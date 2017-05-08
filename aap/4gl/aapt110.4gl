#該程式已解開Section, 不再透過樣板產出!
{<section id="aapt110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0074(2017-02-21 09:53:45), PR版次:0074(2017-02-24 10:38:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000367
#+ Filename...: aapt110
#+ Description: 供應商貨款對帳作業
#+ Creator....: 03080(2014-05-19 15:51:33)
#+ Modifier...: 08532 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt110.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141218-00011#1              By Reanna   1.新增單身自動產生功能 2.取收貨單的發票資料產生至isam_t 3.單頭增加【付款到期日】
#150127-00005#1              By Reanna   複製功能不完整，應清空及應預設資料的欄位不正確
#140806-00012#7   2015/02/24 By Reanna   增加關帳日檢核
#150303           2015/03/03 By Reanna   取消發票日期檢核
#150316           2015/03/16 By Reanna   修改預帶出貨單發票新增時的寫入機制
#150318-00010#1   2015/03/30 By Reanna   1.單身取消17/27類 2.預帶部門改抓apmm202的設定 3.差異分攤處理
#150422-00026#1   2015/05/05 By Reanna   1.接收收貨進項發票時只取原幣，本幣金額依單頭匯率重新計算寫入發票明細
#                                        2.帳款明細單身，修改金額時，稅別含稅否，判斷重計稅，或是重推金額。
#150515           2015/05/15 By Reanna   增加發票明細藍字發票不可打負數的檢核
#150331-00006#4   2015/06/18 By Reanna   整單操作增加"產生應付帳款"串aapp132產生
#150622-00003#1   2015/06/25 By Reanna   增加發票重覆檢核規則
#150629-00017#1   2015/06/30 By Reanna   調整自動產生發票明細的時機點
#150629-00038#1   2015/06/30 By albireo  增加入庫單性質20委外採購入庫   借貨相關
#150702-00001#1   2015/07/03 By albireo  入庫單性質改為動態抓取
#150622-00007#1   2015/07/07 By Reanna   增加單身輸入待抵單
#150711                      By albireo  發票金額差異處理寫法及transaction整理
#150812-00010#2   2015/08/20 by 03538    取消確認的檢核要排除作廢單據
#151012-00014#2   2015/10/13 By Jessy    帶入日/月平均匯率預設值，依aoos020(S-FIN-3009)設定
#151105-00001#8   2015/11/11 By Jessy    151109秋玲:判斷 發票類型是 0/4 (收據類 INVOICE類)統編欄位不需必輸
#151112           2015/11/12 By 03538    判斷isam是否重複,應排除作廢情況者
#151125-00006#2   2015/11/30 By 06421    新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#151013-00019#13  2015/12/02 By Reanna   購方訊息的稅務編號要改抓aooi100設定的統一編號(ooef002)
#151013-00016#14  2015/12/03 By Hans     1.AP的進項發票輸入時, 扣抵代碼依照發票類型aisi030判斷, 若媒體申報格式為空白isac004, 則扣抵代碼default為’3.不可扣抵
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#151229-00001#2   2015/12/31 By Reanna   修改時不可異動發票性質
#160107-00004#1   2016/01/07 By Reanna   進項發票號碼檢核是否重覆，邏輯調整
#160114-00019#3   2016/01/20 By 02097    aapt110点击【抛转应付时】，立账日期=发票日期；帶入defaulta 日期
#151120-00006#2   2016/01/30 By albireo  aapt110差異處理元件化與aapp320共用,方便維護
#160125-00005#6   2016/02/15 By 02097    查詢時，只顯示有權限的帳套
#151231-00010#10  2016/03/02 By sakura   加控制組權限控管
#160225-00001#1   2016/03/04 By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160314-00005#1   2016/03/14 By Reanna   來源資料檢核調整
#160317-00025#1   2016/03/22 By Reanna   單身來源組織檢核調整
#160321-00016#20  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#160325-00031#1   2016/03/25 By fengmy   aapt110发票补登时金额根据对账金额自动带出来
#160324-00032#1   2016/03/29 By 01531    追单：單身不可取到入庫單之扣帳日期大於單頭單據日期之單據
#160318-00025#41  2016/04/25 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160420-00001#3   2016/04/29 By Reanna   aapt110 "for 流通"欄位隱藏
#160530-00005#3   2016/05/30 By 03538    採購性質串 scc 2061 應用分類一, 若為Y 之性質才可立帳
#160602-00023#1   2016/06/02 By 03297    apba008数据表中设定为品名规格，目前只取了品名，加上规格
#160614-00015#1   2016/06/17 By 06821    入庫/退單時, "單位" , 應取計價單位 pmdt023
#160617-00012#1   2016/06/17 By Reanna   aapt110單身產品編號(apba007)不用隱藏要開啟顯示
#160713-00017#1   2016/07/14 By ywtsai   修改規格，將列印功能取消
#160713-00019#1   2016/07/25 By catmoon  控卡發票字軌所屬年月與發票日期不相符
#160705-00035#1   2016/07/26 By Reanna   增加預付&雜項發票立帳流程
#160726-00020#7   2016/08/02 By yunru    新舊值處理
#160802-00049#1   2016/08/03 By Reanna   金額取位不正確bug修正
#160726-00020#11  2016/08/11 By 08171    新舊值處理二次修改
#160816-00068#14  2016/08/17 By 08209    調整transaction
#160818-00017#1   2016/08/23 By 07900    删除修改未重新判断状态码
#160825-00034#1   2016/08/25 By Reanna   入庫單開窗取值SQL與直接輸入入庫單號取值SQL不一致，補齊#160324-00032#1漏追單的部份
#160705-00035#5   2016/08/30 By Reanna   開放27類待抵調整未稅、稅額的部份，若部分沖，則依照apcc的匯率推算本幣
#160907-00041#1   2016/09/10 By 06821    1.法人欄位的輸入與開窗須具備 azzi800 權限為主 2.整單查詢時需要將 azzi800 權限作為過濾條件 3.單身的來源組織範圍, 新增時, 受帳務中心權限限制
#160929-00048#1   2016/09/29 By dorishsu 調整160910-00007#1修正CALL s_fin_date_ap_payable RETURNING 變數接收順序
#161007-00009#1   2016/10/09 By wuxja    台灣發票，除了檢查2碼英文字軌外，應也要檢查後8碼是數字。
#161011-00043#1   2016/10/11 By dorishsu 修正AFTER FIELD apba005,無法帶入庫單的問題
#161014-00003#1   2016/10/14 By dorishsu 修正apba005開窗選擇入庫單後,無法帶入入庫單的問題 
#161013-00019#1   2016/10/14 By dorishsu 調整aapt110_diff_recount_d()函式,決定單價(apba014)的邏輯
#161017-00024#1   2016/10/17 By Reanna   調整差異處理產生加減項條件邏輯
#161006-00005#4   2016/10/19 By 08732    組織類型與職能開窗調整
#161026-00017#1   2016/10/26 By Reanna   檢查發票日期與發票字軌需同年月，TW的部份需排除發票聯別=0:園區收據/4:收據
#161031-00042#1   2016/10/31 By yihsuan  增加依交易對象預帶出發票類型
#160826-00017#1   2016/11/04 By 08732    對帳單主畫面表尾增加原/本幣未稅、稅額、含稅合計金額
#161101-00070#1   2016/11/04 By 06821    发票明细页签的发票类型isam008查詢時开窗增加稅區條件(以g_site對應組織基本資料設定之稅區做為條件)
#161102-00055#1   2016/11/08 By 08729    處理輸入交易對象所帶出的發票類型,非可用的類型
#161104-00024#1   2016/11/08 By 08729    處理DEFINE或INSERT有星號
#161103-00034#1   2016/11/07 By dorishsu 若是稅額有差異,且來源稅額<發票稅額,aapt110_diff_recount_d函式,計算出的稅額差額應再*-1
#161108-00017#3   2016/11/09 By Reanna   程式中INSERT INTO 有星號作整批調整
#161110-00035#1   2016/11/10 By 00768    修正问题：单身输入发票号码会提示错误：“該交易發票號碼不存在”
#161111-00042#1   2016/11/12 By Reanna   供應商貨款對帳單_開窗過濾據點
#161114-00020#1   2016/11/14 By Reanna   交易對象開窗需排除2.客戶類
#161110-00026#1   2016/11/16 By catmoon  在輸入交易對象時(apbb002),除了帶出發票類型(apbb008),也須帶出異動狀態(apbb036)
#160930-00020#2   2016/11/16 By 08729    增加列印串查到aapr120
#161019-00030#1   2016/11/21 By albireo  發票重覆性檢查範圍變更
#160922-00055#1   2016/11/24 By Reanna   整單操作/產生應付帳款,增加對帳來源為預設值
#161115-00002#1   2016/11/24 By dorishsu 1.發票聯別非收據,且格式非28/29,台灣發票檢查稅務編號不可為空 2.台灣發票,如果是28,29海關類,長度是14,前3碼是英文 3.發票格式為28/29海關繳納憑證,不需檢查字軌
#161129-00024#1   2016/12/01 By 01531    1.可增加入庫明細的單價顯示，display only
#                                        2.單頭的【摘要】內容，開放維護。(原限定作廢時才能維護)
#                                        3.入庫單時，手動錄入來源單號+項次帶不出資料     
#161209-00039#1   2016/12/12 By dorishsu 當發票性質(apbb050)=2:扣抵折讓單,則單身的 扣抵藍字發票apba017帶入倉退單的pmdt050
#161206-00019#1   2016/12/13 By dorishsu 修正手动输入发票时，发票清单中无法自动带出发票金额的問題
#161214-00005#1   2016/12/15 By dorishsu 單身來源作業類型11,20,21,呼叫s_aapt300_get_apcb005取得品名(apba008)
#161129-00042#1   2016/12/19 By 08729    增加營利事業統一編號檢查，將apbb030改為非必要輸入欄位
#161206-00042#1   161228     By albireo  新增欄位交易對象識別碼(apbb059)
#161216-00009#2   2016/12/29 By Reanna   單號查詢開窗增加azzi800條件
#161229-00047#39  2017/01/09 By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161230-00036#1   2017/01/10 By 08729    增加統編如果非收據類且有媒體申報格式才需檢查&統整取ooef_t、isac_t、isai_t的值SQL
#170117-00030#1   2017/01/17 By 06821    1.aapt110_invoice_repeat_chk 檢查 若未打發票號 先輸入金額 造成錯誤的處理 2.aapt110_source_doc_chk  錯誤訊息有誤 3.數量不為1時,修改未稅含稅金額回推單價 應除數量並原幣取位
#170110-00044#1   2017/01/19 By 06821    多发票清单 页签只有第一行，删除当前行时，画面没有更新。只有单头的退出时，该笔资料才消失不见。
#161104-00046#4   2017/01/20 By 06821    單別預設值;資料依照單別user dept權限過濾單號
#170124-00007#1   170124     By albireo  差異金額轉其他加減項邏輯調整:以含稅金額為方向依據判斷是加項或減項
#                                        所有金額欄位與其差異相反者,都應該將取絕對值的差異額*-1
#170110-00035#1   2017/01/24 By Reanna   當對帳來源為7.預付發票立帳時，自動產生單身採購單期別請給予至期別(apba020)
#                                        自動產生單身段改用input決定採購單/單身僅適用同一張採購單控管
#170204-00016#1   2017/02/06 By 06948    補登發票時，異動狀態不可維護
#161006-00011#1   2017/02/07 By Reanna   當對帳來源為 預付發票 或 進貨發票 時,單頭發票日期不可小於單身採購/委外採購單日期(取單身最小的採購日期為檢核依據)
#170203-00027#1   2017/02/16 By Reanna   在多發票清單維護發票類型之後會報錯，調整邏輯
#170208-00007#1   2017/02/16 By Reanna   PREPARE sel_pmds_p 抓取單位邏輯為 pmdt023 不用特別判斷 pmds000
#170215-00057#1   2017/02/17 By liqma    新增“多發票清單”時，使鼠標默認選擇欄位“發票類型”
#170218-00012#1   2017/02/18 By dorishsu 1.媒體申報格式(isac004)如為28,29則不控卡統一編號必輸
#170218-00030#1   2017/02/21 By 00768    单身若有发票资讯，不可随意修改，以防单头与单身不一致
#                                        将单身发票资讯的发票日期更新至单头的发票日期
#                                        若单身发票未维护，审核时增加提示
#170217-00032#1   2017/02/22 By 00768    取消单头发票日期不可大于单据日期的控管
#170223-00016#1   2017/02/24 By 06821    单头输入完，未输入单身时，单头的“对账来源”、“账款对象”等栏位建议允许修改
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apbb_m        RECORD
       apbb004 LIKE apbb_t.apbb004, 
   l_apbb004_desc LIKE type_t.chr80, 
   apbbcomp LIKE apbb_t.apbbcomp, 
   l_apbbcomp_desc LIKE type_t.chr80, 
   apbb053 LIKE apbb_t.apbb053, 
   l_apbb053_desc LIKE type_t.chr80, 
   apbbdocno LIKE apbb_t.apbbdocno, 
   l_apbbdocno_desc LIKE type_t.chr80, 
   apbbdocdt LIKE apbb_t.apbbdocdt, 
   apbb002 LIKE apbb_t.apbb002, 
   l_apbb002_desc LIKE type_t.chr80, 
   apbb059 LIKE apbb_t.apbb059, 
   apbb003 LIKE apbb_t.apbb003, 
   apbb050 LIKE apbb_t.apbb050, 
   apbb009 LIKE apbb_t.apbb009, 
   apbb010 LIKE apbb_t.apbb010, 
   apbbstus LIKE apbb_t.apbbstus, 
   apbb008 LIKE apbb_t.apbb008, 
   l_apbb008_desc LIKE type_t.chr80, 
   apbb011 LIKE apbb_t.apbb011, 
   apbb030 LIKE apbb_t.apbb030, 
   apbb051 LIKE apbb_t.apbb051, 
   l_apbb051_desc LIKE type_t.chr80, 
   apbb052 LIKE apbb_t.apbb052, 
   l_apbb052_desc LIKE type_t.chr80, 
   apbb054 LIKE apbb_t.apbb054, 
   l_apbb054_desc LIKE type_t.chr80, 
   apbb012 LIKE apbb_t.apbb012, 
   l_apbb012_desc LIKE type_t.chr80, 
   apbb0121 LIKE apbb_t.apbb0121, 
   apbb013 LIKE apbb_t.apbb013, 
   apbb037 LIKE apbb_t.apbb037, 
   apbb036 LIKE apbb_t.apbb036, 
   apbb200 LIKE apbb_t.apbb200, 
   apbb055 LIKE apbb_t.apbb055, 
   apbb056 LIKE apbb_t.apbb056, 
   apbb014 LIKE apbb_t.apbb014, 
   apbb023 LIKE apbb_t.apbb023, 
   apbb024 LIKE apbb_t.apbb024, 
   apbb025 LIKE apbb_t.apbb025, 
   apbb015 LIKE apbb_t.apbb015, 
   apbb026 LIKE apbb_t.apbb026, 
   apbb027 LIKE apbb_t.apbb027, 
   apbb028 LIKE apbb_t.apbb028, 
   apbb029 LIKE apbb_t.apbb029, 
   l_apbb030_2 LIKE type_t.chr20, 
   apbb031 LIKE apbb_t.apbb031, 
   apbb032 LIKE apbb_t.apbb032, 
   apbb033 LIKE apbb_t.apbb033, 
   apbb034 LIKE apbb_t.apbb034, 
   apbb016 LIKE apbb_t.apbb016, 
   apbb017 LIKE apbb_t.apbb017, 
   apbb018 LIKE apbb_t.apbb018, 
   apbb019 LIKE apbb_t.apbb019, 
   apbb020 LIKE apbb_t.apbb020, 
   apbb021 LIKE apbb_t.apbb021, 
   apbb202 LIKE apbb_t.apbb202, 
   l_apbb202_desc LIKE type_t.chr80, 
   apbb203 LIKE apbb_t.apbb203, 
   apbb204 LIKE apbb_t.apbb204, 
   apbb207 LIKE apbb_t.apbb207, 
   l_apbb207_desc LIKE type_t.chr80, 
   apbb206 LIKE apbb_t.apbb206, 
   apbb205 LIKE apbb_t.apbb205, 
   l_apbb036_2 LIKE type_t.chr10, 
   apbb042 LIKE apbb_t.apbb042, 
   apbb039 LIKE apbb_t.apbb039, 
   apbb040 LIKE apbb_t.apbb040, 
   apbb041 LIKE apbb_t.apbb041, 
   l_apbb041_desc LIKE type_t.chr80, 
   apbb038 LIKE apbb_t.apbb038, 
   l_apbb038_desc LIKE type_t.chr80, 
   apbb049 LIKE apbb_t.apbb049, 
   apbb107 LIKE apbb_t.apbb107, 
   apbb108 LIKE apbb_t.apbb108, 
   apbb117 LIKE apbb_t.apbb117, 
   apbb118 LIKE apbb_t.apbb118, 
   apbb208 LIKE apbb_t.apbb208, 
   apbb209 LIKE apbb_t.apbb209, 
   apbb210 LIKE apbb_t.apbb210, 
   l_apbb210_desc LIKE type_t.chr80, 
   apbbownid LIKE apbb_t.apbbownid, 
   apbbownid_desc LIKE type_t.chr80, 
   apbbowndp LIKE apbb_t.apbbowndp, 
   apbbowndp_desc LIKE type_t.chr80, 
   apbbcrtid LIKE apbb_t.apbbcrtid, 
   apbbcrtid_desc LIKE type_t.chr80, 
   apbbcrtdp LIKE apbb_t.apbbcrtdp, 
   apbbcrtdp_desc LIKE type_t.chr80, 
   apbbcrtdt LIKE apbb_t.apbbcrtdt, 
   apbbmodid LIKE apbb_t.apbbmodid, 
   apbbmodid_desc LIKE type_t.chr80, 
   apbbmoddt LIKE apbb_t.apbbmoddt, 
   apbbcnfid LIKE apbb_t.apbbcnfid, 
   apbbcnfid_desc LIKE type_t.chr80, 
   apbbcnfdt LIKE apbb_t.apbbcnfdt, 
   apba103_s LIKE type_t.num20_6, 
   apba104_s LIKE type_t.num20_6, 
   apba105_s LIKE type_t.num20_6, 
   apba113_s LIKE type_t.num20_6, 
   apba114_s LIKE type_t.num20_6, 
   apba115_s LIKE type_t.num20_6
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apba_d        RECORD
       apbaseq LIKE apba_t.apbaseq, 
   apbaorga LIKE apba_t.apbaorga, 
   apba004 LIKE apba_t.apba004, 
   apba005 LIKE apba_t.apba005, 
   apba006 LIKE apba_t.apba006, 
   apba020 LIKE apba_t.apba020, 
   apba019 LIKE apba_t.apba019, 
   apba007 LIKE apba_t.apba007, 
   apba008 LIKE apba_t.apba008, 
   apba013 LIKE apba_t.apba013, 
   apba015 LIKE apba_t.apba015, 
   apba012 LIKE apba_t.apba012, 
   apba100 LIKE apba_t.apba100, 
   apba009 LIKE apba_t.apba009, 
   l_pmdt036 LIKE type_t.num20_6, 
   apba014 LIKE apba_t.apba014, 
   apba010 LIKE apba_t.apba010, 
   l_apcc102 LIKE type_t.num26_10, 
   apba103 LIKE apba_t.apba103, 
   apba105 LIKE apba_t.apba105, 
   apba104 LIKE apba_t.apba104, 
   apba113 LIKE apba_t.apba113, 
   apba115 LIKE apba_t.apba115, 
   apba114 LIKE apba_t.apba114, 
   apba016 LIKE apba_t.apba016, 
   apba017 LIKE apba_t.apba017, 
   apba111 LIKE apba_t.apba111
       END RECORD
PRIVATE TYPE type_g_apba2_d RECORD
       isamseq LIKE isam_t.isamseq, 
   isam008 LIKE isam_t.isam008, 
   isam037 LIKE isam_t.isam037, 
   isam011 LIKE isam_t.isam011, 
   isam009 LIKE isam_t.isam009, 
   isam010 LIKE isam_t.isam010, 
   isam200 LIKE isam_t.isam200, 
   isam030 LIKE isam_t.isam030, 
   isam012 LIKE isam_t.isam012, 
   isam014 LIKE isam_t.isam014, 
   isam015 LIKE isam_t.isam015, 
   isam023 LIKE isam_t.isam023, 
   isam024 LIKE isam_t.isam024, 
   isam025 LIKE isam_t.isam025, 
   isam026 LIKE isam_t.isam026, 
   isam027 LIKE isam_t.isam027, 
   isam028 LIKE isam_t.isam028, 
   isam036 LIKE isam_t.isam036, 
   isam050 LIKE isam_t.isam050, 
   isamstus LIKE isam_t.isamstus, 
   isamcomp LIKE isam_t.isamcomp, 
   isam001 LIKE isam_t.isam001
       END RECORD
PRIVATE TYPE type_g_apba3_d RECORD
       isau003 LIKE isau_t.isau003, 
   isau004 LIKE isau_t.isau004, 
   isauseq LIKE isau_t.isauseq, 
   isau007 LIKE isau_t.isau007, 
   isau008 DATETIME YEAR TO FRACTION(5), 
   isau014 LIKE isau_t.isau014, 
   isau015 LIKE isau_t.isau015, 
   isau016 LIKE isau_t.isau016, 
   isau017 LIKE isau_t.isau017, 
   isau018 LIKE isau_t.isau018, 
   isau019 LIKE isau_t.isau019, 
   isau020 LIKE isau_t.isau020, 
   isau208 LIKE isau_t.isau208
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apbbcomp LIKE apbb_t.apbbcomp,
      b_apbb011 LIKE apbb_t.apbb011,
      b_apbb002 LIKE apbb_t.apbb002,
   b_apbb002_desc LIKE type_t.chr80,
      b_apbb008 LIKE apbb_t.apbb008,
   b_apbb008_desc LIKE type_t.chr80,
      b_apbb009 LIKE apbb_t.apbb009,
      b_apbb010 LIKE apbb_t.apbb010,
      b_apbbdocno LIKE apbb_t.apbbdocno,
      b_apbb036 LIKE apbb_t.apbb036
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef019             LIKE ooef_t.ooef019     #稅區
DEFINE g_isai002             LIKE isai_t.isai002     #發票採1字軌還是2代碼
DEFINE g_isai006             LIKE isai_t.isai006     #紅字發票與藍字發票共用發票簿
DEFINE g_wc_apbacomp         STRING                  #法人條件  #160705-00035#1
DEFINE g_wc_apbaorga         STRING                  #帳務組織條件
DEFINE g_ld                  LIKE glaa_t.glaald
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_fin_arg1            LIKE gzsz_t.gzsz002     #財務應用參數(定義於azzi991)D-FIN-3001--應付帳款單性質
DEFINE g_sfin3007            LIKE apca_t.apcadocdt   #140806-00012#7
DEFINE g_wc_cs_orga          STRING                  #160125-00005#6
DEFINE g_sql_ctrl            STRING                  #151231-00010#10
DEFINE g_apcc102             LIKE apcc_t.apcc102     #apcc的匯率  #160705-00035#5
DEFINE g_wc_cs_comp          STRING                  #azzi800的權限可看的資料範圍  #160907-00041#1 add
DEFINE g_wc_ooef019          LIKE ooef_t.ooef019     #查詢時g_site稅區            #161101-00070#1 add
#161206-00042#5-----s
DEFINE g_s400ar              RECORD
          apca057               LIKE apca_t.apca057,
          apcadocno             LIKE apca_t.apcadocno
                             END RECORD
#161206-00042#5-----e
DEFINE g_comp_str            STRING                  #161229-00047#39 add
#161230-00036#1 add ------
DEFINE g_isac004             LIKE isac_t.isac004     #媒體申報格式
DEFINE g_isac008             LIKE isac_t.isac008     #發票聯數
DEFINE g_ooef011             LIKE ooef_t.ooef011
#161230-00036#1 add end---
#161104-00046#4 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING     
DEFINE g_user_slip_wc        STRING
DEFINE g_ap_slip             LIKE ooba_t.ooba002      #應付帳款單單別
#161104-00046#4 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apbb_m          type_g_apbb_m
DEFINE g_apbb_m_t        type_g_apbb_m
DEFINE g_apbb_m_o        type_g_apbb_m
DEFINE g_apbb_m_mask_o   type_g_apbb_m #轉換遮罩前資料
DEFINE g_apbb_m_mask_n   type_g_apbb_m #轉換遮罩後資料
 
   DEFINE g_apbbdocno_t LIKE apbb_t.apbbdocno
 
 
DEFINE g_apba_d          DYNAMIC ARRAY OF type_g_apba_d
DEFINE g_apba_d_t        type_g_apba_d
DEFINE g_apba_d_o        type_g_apba_d
DEFINE g_apba_d_mask_o   DYNAMIC ARRAY OF type_g_apba_d #轉換遮罩前資料
DEFINE g_apba_d_mask_n   DYNAMIC ARRAY OF type_g_apba_d #轉換遮罩後資料
DEFINE g_apba2_d          DYNAMIC ARRAY OF type_g_apba2_d
DEFINE g_apba2_d_t        type_g_apba2_d
DEFINE g_apba2_d_o        type_g_apba2_d
DEFINE g_apba2_d_mask_o   DYNAMIC ARRAY OF type_g_apba2_d #轉換遮罩前資料
DEFINE g_apba2_d_mask_n   DYNAMIC ARRAY OF type_g_apba2_d #轉換遮罩後資料
DEFINE g_apba3_d          DYNAMIC ARRAY OF type_g_apba3_d
DEFINE g_apba3_d_t        type_g_apba3_d
DEFINE g_apba3_d_o        type_g_apba3_d
DEFINE g_apba3_d_mask_o   DYNAMIC ARRAY OF type_g_apba3_d #轉換遮罩前資料
DEFINE g_apba3_d_mask_n   DYNAMIC ARRAY OF type_g_apba3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt110.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   LET g_fin_arg1 = 'D-FIN-3001'
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)                      #160125-00005#6
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  #160125-00005#6
   #151231-00010#10(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl  #161111-00042#1 mark
   #151231-00010#10(E)
   #161111-00042#1 add ------
   SELECT ooef017 INTO g_apbb_m.apbbcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbb_m.apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#39 mark
   #161111-00042#1 add end---
   #161229-00047#39 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#39 --e add  
   #161104-00046#4 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_apbb_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('apbbcomp','','apbbent','apbbdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#4 --e add   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apbb004,'',apbbcomp,'',apbb053,'',apbbdocno,'',apbbdocdt,apbb002,'',apbb059, 
       apbb003,apbb050,apbb009,apbb010,apbbstus,apbb008,'',apbb011,apbb030,apbb051,'',apbb052,'',apbb054, 
       '',apbb012,'',apbb0121,apbb013,apbb037,apbb036,apbb200,apbb055,apbb056,apbb014,apbb023,apbb024, 
       apbb025,apbb015,apbb026,apbb027,apbb028,apbb029,'',apbb031,apbb032,apbb033,apbb034,apbb016,apbb017, 
       apbb018,apbb019,apbb020,apbb021,apbb202,'',apbb203,apbb204,apbb207,'',apbb206,apbb205,'',apbb042, 
       apbb039,apbb040,apbb041,'',apbb038,'',apbb049,apbb107,apbb108,apbb117,apbb118,apbb208,apbb209, 
       apbb210,'',apbbownid,'',apbbowndp,'',apbbcrtid,'',apbbcrtdp,'',apbbcrtdt,apbbmodid,'',apbbmoddt, 
       apbbcnfid,'',apbbcnfdt,'','','','','',''", 
                      " FROM apbb_t",
                      " WHERE apbbent= ? AND apbbdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt110_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apbb004,t0.apbbcomp,t0.apbb053,t0.apbbdocno,t0.apbbdocdt,t0.apbb002, 
       t0.apbb059,t0.apbb003,t0.apbb050,t0.apbb009,t0.apbb010,t0.apbbstus,t0.apbb008,t0.apbb011,t0.apbb030, 
       t0.apbb051,t0.apbb052,t0.apbb054,t0.apbb012,t0.apbb0121,t0.apbb013,t0.apbb037,t0.apbb036,t0.apbb200, 
       t0.apbb055,t0.apbb056,t0.apbb014,t0.apbb023,t0.apbb024,t0.apbb025,t0.apbb015,t0.apbb026,t0.apbb027, 
       t0.apbb028,t0.apbb029,t0.apbb031,t0.apbb032,t0.apbb033,t0.apbb034,t0.apbb016,t0.apbb017,t0.apbb018, 
       t0.apbb019,t0.apbb020,t0.apbb021,t0.apbb202,t0.apbb203,t0.apbb204,t0.apbb207,t0.apbb206,t0.apbb205, 
       t0.apbb042,t0.apbb039,t0.apbb040,t0.apbb041,t0.apbb038,t0.apbb049,t0.apbb107,t0.apbb108,t0.apbb117, 
       t0.apbb118,t0.apbb208,t0.apbb209,t0.apbb210,t0.apbbownid,t0.apbbowndp,t0.apbbcrtid,t0.apbbcrtdp, 
       t0.apbbcrtdt,t0.apbbmodid,t0.apbbmoddt,t0.apbbcnfid,t0.apbbcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM apbb_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.apbbownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apbbowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apbbcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apbbcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apbbmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apbbcnfid  ",
 
               " WHERE t0.apbbent = " ||g_enterprise|| " AND t0.apbbdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
 
   #end add-point
   PREPARE aapt110_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt110 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt110_init()   
 
      #進入選單 Menu (="N")
      CALL aapt110_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt110
      
   END IF 
   
   CLOSE aapt110_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt110.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt110_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_str   STRING
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apbbstus','13','Y,N,A,D,R,W,X')
 
      CALL cl_set_combo_scc('apba004','8541') 
   CALL cl_set_combo_scc('isam037','9719') 
   CALL cl_set_combo_scc('isam036','9716') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #單頭
   CALL cl_set_combo_scc_part('apbb003','8522','2,5,7,8,9') #對帳方式 #160705-00035#1
   CALL cl_set_combo_scc('apbb050','9741') #發票性質
   CALL cl_set_combo_scc('apbb037','9719') #可扣抵代碼
   CALL cl_set_combo_scc('apbb036','9716') #異動狀態
   #單身
   #LET l_str = s_fin_last_doc_fields('aapt300')
   #CALL cl_set_combo_scc_part('apba004','24',l_str) #來源作業
   #CALL cl_set_combo_scc('apba004','8541') #來源作業
   
   CALL cl_set_combo_scc_part('apba004','8541','10,11,12,13,16,19,20,21,23,26,27,29') #來源作業
   #150318-00010#1 take out17/27
   #20150601 add 12,13,23 lujh
   #150622-00007#1 開放27
   #160705-00035#1 開放10
   
   CALL cl_set_combo_scc('isam037','9719') #可扣抵代碼
   CALL cl_set_combo_scc('isam036','9716') #異動狀態
   CALL s_fin_create_account_center_tmp()
   
   #160907-00041#1 --s add
   #查詢時azzi800法人權限
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #160907-00041#1 --e add
 
   #end add-point
   
   #初始化搜尋條件
   CALL aapt110_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt110.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt110_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE  l_cnt                 LIKE type_t.num10      #150331-00006#4
   DEFINE  l_cn                  LIKE type_t.num10      #151125-00006#2
   DEFINE  l_ld                  LIKE glaa_t.glaald     #160225-00001#1
   DEFINE  l_dfin0033            LIKE type_t.chr1       #160225-00001#1
   DEFINE  l_slip                LIKE apca_t.apcadocno  #160225-00001#1
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aapt110_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_apbb_m.* TO NULL
         CALL g_apba_d.clear()
         CALL g_apba2_d.clear()
         CALL g_apba3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt110_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aapt110_fetch('') # reload data
               LET l_ac = 1
               CALL aapt110_ui_detailshow() #Setting the current row 
         
               CALL aapt110_idx_chk()
               #NEXT FIELD apbaseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apba_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt110_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt110_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apba005
                  LET g_action_choice="prog_apba005"
                  IF cl_auth_chk_act("prog_apba005") THEN
                     
                     #add-point:ON ACTION prog_apba005 name="menu.detail_show.page1_sub.prog_apba005"
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     IF cl_null(g_apba_d[g_detail_idx].apbaorga) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'sub-00280'
                        LET g_errparam.extend = s_fin_get_colname(g_prog,'apbaorga')
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     ELSE
                        IF cl_null(g_apba_d[g_detail_idx].apba004) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'sub-00280'
                           LET g_errparam.extend = s_fin_get_colname(g_prog,'apba004')
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        ELSE
                           IF cl_null(g_apba_d[g_detail_idx].apba005) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code   = 'sub-00280'
                              LET g_errparam.extend = s_fin_get_colname(g_prog,'apba005')
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                           ELSE
                           INITIALIZE la_param.* TO NULL
                           CALL s_aapt300_get_source_apm_prog(g_apba_d[g_detail_idx].apba004,g_apba_d[g_detail_idx].apba005) RETURNING la_param.prog
                           LET la_param.param[1] = g_apba_d[g_detail_idx].apba005
                           LET la_param.param[3] = g_apba_d[g_detail_idx].apbaorga
                           LET ls_js = util.JSON.stringify(la_param)
                           CALL cl_cmdrun_wait(ls_js)
                           END IF
                        END IF
                     END IF
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_apba2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt110_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt110_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apba3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt110_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aapt110_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt110_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aapt110_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt110_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt110_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt110_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt110_set_act_visible()   
            CALL aapt110_set_act_no_visible()
            IF NOT (g_apbb_m.apbbdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apbbent = " ||g_enterprise|| " AND",
                                  " apbbdocno = '", g_apbb_m.apbbdocno, "' "
 
               #填到對應位置
               CALL aapt110_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apbb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apba_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "isam_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "isau_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt110_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apbb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apba_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "isam_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "isau_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt110_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt110_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapt110_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt110_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt110_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt110_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt110_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt110_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt110_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt110_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt110_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt110_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt110_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_apba_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_apba2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_apba3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD apbaseq
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt110_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt110_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#2--s
               CALL aapt110_immediately_conf()
               SELECT COUNT(*) INTO l_cn
                 FROM apbb_t
                WHERE apbbent = g_enterprise AND apbb004 = g_apbb_m.apbb004
                  AND apbbcomp = g_apbb_m.apbbcomp AND apbbdocno = g_apbb_m.apbbdocno
               IF l_cn > 0 THEN
                  #CALL aapt110_ui_headershow()  #161006-00011#1 mark
                  #161006-00011#1 add ------
                  LET g_wc = " apbbent = ",g_enterprise," AND apbbdocno = '",g_apbb_m.apbbdocno,"' "
                  CALL aapt110_browser_fill('')
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  CALL aapt110_fetch('/')
                  CALL aapt110_idx_chk()
                  #161006-00011#1 add end---
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt110_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt110_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               CALL aapt110_immediately_conf()
               SELECT COUNT(*) INTO l_cn
                 FROM apbb_t
                WHERE apbbent = g_enterprise AND apbb004 = g_apbb_m.apbb004
                  AND apbbcomp = g_apbb_m.apbbcomp AND apbbdocno = g_apbb_m.apbbdocno
               IF l_cn > 0 THEN
                  #CALL aapt110_ui_headershow()  #161006-00011#1 mark
                  #161006-00011#1 add ------
                  LET g_wc = " apbbent = ",g_enterprise," AND apbbdocno = '",g_apbb_m.apbbdocno,"' "
                  CALL aapt110_browser_fill('')
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  CALL aapt110_fetch('/')
                  CALL aapt110_idx_chk()
                  #161006-00011#1 add end---
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #列印報表aapr110 #141218-00011#15
               LET g_rep_wc = " apbbent = ",g_enterprise," AND apbb004 = '",g_apbb_m.apbb004,"'",
                              " AND apbbcomp = '",g_apbb_m.apbbcomp,"' AND apbbdocno='",g_apbb_m.apbbdocno,"'"
               #END add-point
               &include "erp/aap/aapt110_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #列印報表aapr110 #141218-00011#15
               LET g_rep_wc = " apbbent = ",g_enterprise," AND apbb004 = '",g_apbb_m.apbb004,"'",
                              " AND apbbcomp = '",g_apbb_m.apbbcomp,"' AND apbbdocno='",g_apbb_m.apbbdocno,"'"
               #END add-point
               &include "erp/aap/aapt110_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION invoice_mod
            LET g_action_choice="invoice_mod"
            IF cl_auth_chk_act("invoice_mod") THEN
               
               #add-point:ON ACTION invoice_mod name="menu.invoice_mod"
               CALL s_transaction_begin()
               #發票補登(僅開放"多發票明細"頁籤修改)
               CALL aapt110_invoice_mod() RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt110_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL aapt110_immediately_conf()
               SELECT COUNT(*) INTO l_cn
                 FROM apbb_t
                WHERE apbbent = g_enterprise AND apbb004 = g_apbb_m.apbb004
                  AND apbbcomp = g_apbb_m.apbbcomp AND apbbdocno = g_apbb_m.apbbdocno
               IF l_cn > 0 THEN
                  #CALL aapt110_ui_headershow()  #161006-00011#1 mark
                  #161006-00011#1 add ------
                  LET g_wc = " apbbent = ",g_enterprise," AND apbbdocno = '",g_apbb_m.apbbdocno,"' "
                  CALL aapt110_browser_fill('')
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  CALL aapt110_fetch('/')
                  CALL aapt110_idx_chk()
                  #161006-00011#1 add end---
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt110_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL aapt110_immediately_conf()
               SELECT COUNT(*) INTO l_cn
                 FROM apbb_t
                WHERE apbbent = g_enterprise AND apbb004 = g_apbb_m.apbb004
                  AND apbbcomp = g_apbb_m.apbbcomp AND apbbdocno = g_apbb_m.apbbdocno
               IF l_cn > 0 THEN
                  #CALL aapt110_ui_headershow()  #161006-00011#1 mark
                  #161006-00011#1 add ------
                  LET g_wc = " apbbent = ",g_enterprise," AND apbbdocno = '",g_apbb_m.apbbdocno,"' "
                  CALL aapt110_browser_fill('')
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  CALL aapt110_fetch('/')
                  CALL aapt110_idx_chk()
                  #161006-00011#1 add end---
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aapt110_09
            LET g_action_choice="aapt110_09"
            IF cl_auth_chk_act("aapt110_09") THEN
               
               #add-point:ON ACTION aapt110_09 name="menu.aapt110_09"
               #160225-00001#1--(S)
               IF NOT cl_null(g_apbb_m.apbbdocno) THEN
                  SELECT glaald INTO l_ld FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_apbb_m.apbbcomp AND glaa014 = 'Y'
                  CALL s_aooi200_fin_get_slip(g_apbb_m.apbbdocno) RETURNING g_sub_success,l_slip
                  CALL s_fin_get_doc_para(l_ld,g_apbb_m.apbbcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
                  CALL s_fin_date_close_chk('',g_apbb_m.apbbcomp,'AAP',g_apbb_m.apbbdocdt) RETURNING g_sub_success
                  IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
                  ELSE
                  #160225-00001#1--(E)
                     #150318-00010#1 add ------
                     CALL s_transaction_begin()   #albireo 150711 add
                     CALL cl_err_collect_init()   #albireo 150711 add
                     CALL aapt110_diff_recount_entrance('Y') RETURNING g_sub_success
                     IF g_sub_success THEN
                        CALL cl_err_collect_show()        #albireo 150711 add
                        CALL s_transaction_end('Y','0')   #albireo 150711 add
                     ELSE
                        CALL cl_err_collect_show()        #albireo 150711 add
                        CALL s_transaction_end('N','0')   #albireo 150711 add
                     END IF
                     #150318-00010#1 add end---
                  #160225-00001#1--(S)
                  END IF
               END IF
               #160225-00001#1--(E)             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp132
            LET g_action_choice="open_aapp132"
            IF cl_auth_chk_act("open_aapp132") THEN
               
               #add-point:ON ACTION open_aapp132 name="menu.open_aapp132"
               #150331-00006#4 add ------
               IF g_apbb_m.apbbstus != 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00034'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM isam_t
                WHERE isament = g_enterprise
                  AND isamdocno = g_apbb_m.apbbdocno
                  AND isam050 IS NOT NULL
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               LET la_param.prog = "aapp132"
               LET la_param.param[1] = g_apbb_m.apbb004
               LET la_param.param[2] = g_apbb_m.apbbdocno
               LET la_param.param[3] = g_apbb_m.apbbdocdt   #160114-00019#3
               LET la_param.param[4] = g_apbb_m.apbb003     #對帳來源 #160922-00055#1
               
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
               
               CALL aapt110_show()
               #150331-00006#4 add end---
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apbb053
            LET g_action_choice="prog_apbb053"
            IF cl_auth_chk_act("prog_apbb053") THEN
               
               #add-point:ON ACTION prog_apbb053 name="menu.prog_apbb053"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apbb_m.apbb053)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apbb051
            LET g_action_choice="prog_apbb051"
            IF cl_auth_chk_act("prog_apbb051") THEN
               
               #add-point:ON ACTION prog_apbb051 name="menu.prog_apbb051"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apbb_m.apbb051)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apbb041
            LET g_action_choice="prog_apbb041"
            IF cl_auth_chk_act("prog_apbb041") THEN
               
               #add-point:ON ACTION prog_apbb041 name="menu.prog_apbb041"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apbb_m.apbb041)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt110_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt110_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt110_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apbb_m.apbbdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aapt110.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt110_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apbbdocno ",
                      " FROM apbb_t ",
                      " ",
                      " LEFT JOIN apba_t ON apbaent = apbbent AND apbbdocno = apbadocno ", "  ",
                      #add-point:browser_fill段sql(apba_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN isam_t ON isament = apbbent AND apbbdocno = isamdocno", "  ",
                      #add-point:browser_fill段sql(isam_t1) name="browser_fill.cnt.join.isam_t1"
                      
                      #end add-point
 
                      " LEFT JOIN isau_t ON isauent = apbbent AND apbbdocno = isaudocno", "  ",
                      #add-point:browser_fill段sql(isau_t1) name="browser_fill.cnt.join.isau_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE apbbent = " ||g_enterprise|| " AND apbaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apbb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apbbdocno ",
                      " FROM apbb_t ", 
                      "  ",
                      "  ",
                      " WHERE apbbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apbb_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_apbb_m.* TO NULL
      CALL g_apba_d.clear()        
      CALL g_apba2_d.clear() 
      CALL g_apba3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apbbcomp,t0.apbb011,t0.apbb002,t0.apbb008,t0.apbb009,t0.apbb010,t0.apbbdocno,t0.apbb036 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apbbstus,t0.apbbcomp,t0.apbb011,t0.apbb002,t0.apbb008,t0.apbb009, 
          t0.apbb010,t0.apbbdocno,t0.apbb036,t1.pmaal003 ,t2.isacl004 ",
                  " FROM apbb_t t0",
                  "  ",
                  "  LEFT JOIN apba_t ON apbaent = apbbent AND apbbdocno = apbadocno ", "  ", 
                  #add-point:browser_fill段sql(apba_t1) name="browser_fill.join.apba_t1"
                  
                  #end add-point
                  "  LEFT JOIN isam_t ON isament = apbbent AND apbbdocno = isamdocno", "  ", 
                  #add-point:browser_fill段sql(isam_t1) name="browser_fill.join.isam_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN isau_t ON isauent = apbbent AND apbbdocno = isaudocno", "  ", 
                  #add-point:browser_fill段sql(isau_t1) name="browser_fill.join.isau_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.apbb002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN isacl_t t2 ON t2.isaclent="||g_enterprise||" AND t2.isacl001=t0.apbbcomp AND t2.isacl002=t0.apbb008 AND t2.isacl003='"||g_dlang||"' ",
 
                  " WHERE t0.apbbent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apbb_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apbbstus,t0.apbbcomp,t0.apbb011,t0.apbb002,t0.apbb008,t0.apbb009, 
          t0.apbb010,t0.apbbdocno,t0.apbb036,t1.pmaal003 ,t2.isacl004 ",
                  " FROM apbb_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.apbb002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN isacl_t t2 ON t2.isaclent="||g_enterprise||" AND t2.isacl001=t0.apbbcomp AND t2.isacl002=t0.apbb008 AND t2.isacl003='"||g_dlang||"' ",
 
                  " WHERE t0.apbbent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apbb_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #151231-00010#10(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = apbbent ",
                        "                AND pmaa001 = apbb002 )"
   END IF
   #151231-00010#10(E) 
   #end add-point
   LET g_sql = g_sql, " ORDER BY apbbdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apbb_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apbbcomp,g_browser[g_cnt].b_apbb011, 
          g_browser[g_cnt].b_apbb002,g_browser[g_cnt].b_apbb008,g_browser[g_cnt].b_apbb009,g_browser[g_cnt].b_apbb010, 
          g_browser[g_cnt].b_apbbdocno,g_browser[g_cnt].b_apbb036,g_browser[g_cnt].b_apbb002_desc,g_browser[g_cnt].b_apbb008_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL aapt110_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_apbbdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   CALL aapt110_set_act_visible()   
   CALL aapt110_set_act_no_visible()
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt110_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apbb_m.apbbdocno = g_browser[g_current_idx].b_apbbdocno   
 
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
   CALL aapt110_apbb_t_mask()
   CALL aapt110_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt110.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt110_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt110_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_apbbdocno = g_apbb_m.apbbdocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt110_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apbb_m.* TO NULL
   CALL g_apba_d.clear()        
   CALL g_apba2_d.clear() 
   CALL g_apba3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apbb004,apbbcomp,apbb053,apbbdocno,apbbdocdt,apbb002,apbb059,apbb003, 
          apbb050,apbb009,apbb010,apbbstus,apbb008,apbb011,apbb051,apbb052,apbb054,apbb012,apbb0121, 
          apbb013,apbb037,apbb036,apbb200,apbb055,apbb056,apbb014,apbb023,apbb024,apbb025,apbb015,apbb026, 
          apbb027,apbb028,apbb029,apbb031,apbb032,apbb033,apbb034,apbb016,apbb017,apbb018,apbb019,apbb020, 
          apbb021,apbb202,apbb203,apbb204,apbb207,apbb042,apbb039,apbb040,apbb041,apbb038,apbb049,apbbownid, 
          apbbowndp,apbbcrtid,apbbcrtdp,apbbcrtdt,apbbmodid,apbbmoddt,apbbcnfid,apbbcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            #161101-00070#1 --s add
            #查詢時發票類型開窗稅區條件
            LET g_wc_ooef019 = ''
            SELECT ooef019 INTO g_wc_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            #161101-00070#1 --e add
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apbbcrtdt>>----
         AFTER FIELD apbbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apbbmoddt>>----
         AFTER FIELD apbbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbcnfdt>>----
         AFTER FIELD apbbcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apbbpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb004
            #add-point:ON ACTION controlp INFIELD apbb004 name="construct.c.apbb004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#4  mark
            CALL q_ooef001_46()   #161006-00005#4   add    
            DISPLAY g_qryparam.return1 TO apbb004
            NEXT FIELD apbb004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb004
            #add-point:BEFORE FIELD apbb004 name="construct.b.apbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb004
            
            #add-point:AFTER FIELD apbb004 name="construct.a.apbb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcomp
            #add-point:BEFORE FIELD apbbcomp name="construct.b.apbbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbcomp
            
            #add-point:AFTER FIELD apbbcomp name="construct.a.apbbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbcomp
            #add-point:ON ACTION controlp INFIELD apbbcomp name="construct.c.apbbcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "
            CALL s_fin_azzi800_sons_query(g_today)
            CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
            CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
            #160907-00041#1 --s add
            IF NOT cl_null(g_wc_cs_comp)THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp         
            END IF
            #160907-00041#1 --e add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO apbbcomp
            NEXT FIELD apbbcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb053
            #add-point:BEFORE FIELD apbb053 name="construct.b.apbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb053
            
            #add-point:AFTER FIELD apbb053 name="construct.a.apbb053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb053
            #add-point:ON ACTION controlp INFIELD apbb053 name="construct.c.apbb053"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161216-00009#2 add ------
            LET g_qryparam.where = " apbbcomp IN ",g_wc_cs_comp
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = apbbent ",
                                                       "                AND pmaa001 = apbb002 )"
            END IF
            #161216-00009#2 add end---
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbb053
            NEXT FIELD apbb053
            #END add-point
 
 
         #Ctrlp:construct.c.apbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbdocno
            #add-point:ON ACTION controlp INFIELD apbbdocno name="construct.c.apbbdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161104-00046#4 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q
            END IF
            #161104-00046#4 --e add            
            CALL q_apbbdocno()
            DISPLAY g_qryparam.return1 TO apbbdocno
            NEXT FIELD apbbdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbdocno
            #add-point:BEFORE FIELD apbbdocno name="construct.b.apbbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbdocno
            
            #add-point:AFTER FIELD apbbdocno name="construct.a.apbbdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbdocdt
            #add-point:BEFORE FIELD apbbdocdt name="construct.b.apbbdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbdocdt
            
            #add-point:AFTER FIELD apbbdocdt name="construct.a.apbbdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbdocdt
            #add-point:ON ACTION controlp INFIELD apbbdocdt name="construct.c.apbbdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb002
            #add-point:ON ACTION controlp INFIELD apbb002 name="construct.c.apbb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象
            #151231-00010#10(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               #LET g_qryparam.where = g_sql_ctrl  #161114-00020#1 mark
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl #161114-00020#1
            END IF
            #151231-00010#10(E)
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO apbb002
            NEXT FIELD apbb002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb002
            #add-point:BEFORE FIELD apbb002 name="construct.b.apbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb002
            
            #add-point:AFTER FIELD apbb002 name="construct.a.apbb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb059
            #add-point:BEFORE FIELD apbb059 name="construct.b.apbb059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb059
            
            #add-point:AFTER FIELD apbb059 name="construct.a.apbb059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb059
            #add-point:ON ACTION controlp INFIELD apbb059 name="construct.c.apbb059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb003
            #add-point:BEFORE FIELD apbb003 name="construct.b.apbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb003
            
            #add-point:AFTER FIELD apbb003 name="construct.a.apbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb003
            #add-point:ON ACTION controlp INFIELD apbb003 name="construct.c.apbb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb050
            #add-point:BEFORE FIELD apbb050 name="construct.b.apbb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb050
            
            #add-point:AFTER FIELD apbb050 name="construct.a.apbb050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb050
            #add-point:ON ACTION controlp INFIELD apbb050 name="construct.c.apbb050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb009
            #add-point:BEFORE FIELD apbb009 name="construct.b.apbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb009
            
            #add-point:AFTER FIELD apbb009 name="construct.a.apbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb009
            #add-point:ON ACTION controlp INFIELD apbb009 name="construct.c.apbb009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb010
            #add-point:ON ACTION controlp INFIELD apbb010 name="construct.c.apbb010"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb010
            #add-point:BEFORE FIELD apbb010 name="construct.b.apbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb010
            
            #add-point:AFTER FIELD apbb010 name="construct.a.apbb010"
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbstus
            #add-point:BEFORE FIELD apbbstus name="construct.b.apbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbstus
            
            #add-point:AFTER FIELD apbbstus name="construct.a.apbbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbstus
            #add-point:ON ACTION controlp INFIELD apbbstus name="construct.c.apbbstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb008
            #add-point:ON ACTION controlp INFIELD apbb008 name="construct.c.apbb008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "isac003 IN ('1','3')"                                    #161101-00070#1 mark
            LET g_qryparam.where = " isac003 IN ('1','3') AND isac001 = '",g_wc_ooef019,"' "  #161101-00070#1 add
            CALL q_isac002()
            DISPLAY g_qryparam.return1 TO apbb008
            NEXT FIELD apbb008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb008
            #add-point:BEFORE FIELD apbb008 name="construct.b.apbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb008
            
            #add-point:AFTER FIELD apbb008 name="construct.a.apbb008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb011
            #add-point:BEFORE FIELD apbb011 name="construct.b.apbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb011
            
            #add-point:AFTER FIELD apbb011 name="construct.a.apbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb011
            #add-point:ON ACTION controlp INFIELD apbb011 name="construct.c.apbb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb051
            #add-point:BEFORE FIELD apbb051 name="construct.b.apbb051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb051
            
            #add-point:AFTER FIELD apbb051 name="construct.a.apbb051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb051
            #add-point:ON ACTION controlp INFIELD apbb051 name="construct.c.apbb051"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbb051
            NEXT FIELD apbb051
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb052
            #add-point:BEFORE FIELD apbb052 name="construct.b.apbb052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb052
            
            #add-point:AFTER FIELD apbb052 name="construct.a.apbb052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb052
            #add-point:ON ACTION controlp INFIELD apbb052 name="construct.c.apbb052"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()
            DISPLAY g_qryparam.return1 TO apbb052
            NEXT FIELD apbb052
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb054
            #add-point:BEFORE FIELD apbb054 name="construct.b.apbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb054
            
            #add-point:AFTER FIELD apbb054 name="construct.a.apbb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb054
            #add-point:ON ACTION controlp INFIELD apbb054 name="construct.c.apbb054"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_2()
            DISPLAY g_qryparam.return1 TO apbb054
            NEXT FIELD apbb054
            #END add-point
 
 
         #Ctrlp:construct.c.apbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb012
            #add-point:ON ACTION controlp INFIELD apbb012 name="construct.c.apbb012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()
            DISPLAY g_qryparam.return1 TO apbb012
            NEXT FIELD apbb012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb012
            #add-point:BEFORE FIELD apbb012 name="construct.b.apbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb012
            
            #add-point:AFTER FIELD apbb012 name="construct.a.apbb012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb0121
            #add-point:BEFORE FIELD apbb0121 name="construct.b.apbb0121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb0121
            
            #add-point:AFTER FIELD apbb0121 name="construct.a.apbb0121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb0121
            #add-point:ON ACTION controlp INFIELD apbb0121 name="construct.c.apbb0121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb013
            #add-point:BEFORE FIELD apbb013 name="construct.b.apbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb013
            
            #add-point:AFTER FIELD apbb013 name="construct.a.apbb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb013
            #add-point:ON ACTION controlp INFIELD apbb013 name="construct.c.apbb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb037
            #add-point:BEFORE FIELD apbb037 name="construct.b.apbb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb037
            
            #add-point:AFTER FIELD apbb037 name="construct.a.apbb037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb037
            #add-point:ON ACTION controlp INFIELD apbb037 name="construct.c.apbb037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb036
            #add-point:BEFORE FIELD apbb036 name="construct.b.apbb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb036
            
            #add-point:AFTER FIELD apbb036 name="construct.a.apbb036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb036
            #add-point:ON ACTION controlp INFIELD apbb036 name="construct.c.apbb036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb200
            #add-point:BEFORE FIELD apbb200 name="construct.b.apbb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb200
            
            #add-point:AFTER FIELD apbb200 name="construct.a.apbb200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb200
            #add-point:ON ACTION controlp INFIELD apbb200 name="construct.c.apbb200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb055
            #add-point:BEFORE FIELD apbb055 name="construct.b.apbb055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb055
            
            #add-point:AFTER FIELD apbb055 name="construct.a.apbb055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb055
            #add-point:ON ACTION controlp INFIELD apbb055 name="construct.c.apbb055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb056
            #add-point:BEFORE FIELD apbb056 name="construct.b.apbb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb056
            
            #add-point:AFTER FIELD apbb056 name="construct.a.apbb056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb056
            #add-point:ON ACTION controlp INFIELD apbb056 name="construct.c.apbb056"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb014
            #add-point:ON ACTION controlp INFIELD apbb014 name="construct.c.apbb014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()
            DISPLAY g_qryparam.return1 TO apbb014
            NEXT FIELD apbb014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb014
            #add-point:BEFORE FIELD apbb014 name="construct.b.apbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb014
            
            #add-point:AFTER FIELD apbb014 name="construct.a.apbb014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb023
            #add-point:BEFORE FIELD apbb023 name="construct.b.apbb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb023
            
            #add-point:AFTER FIELD apbb023 name="construct.a.apbb023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb023
            #add-point:ON ACTION controlp INFIELD apbb023 name="construct.c.apbb023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb024
            #add-point:BEFORE FIELD apbb024 name="construct.b.apbb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb024
            
            #add-point:AFTER FIELD apbb024 name="construct.a.apbb024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb024
            #add-point:ON ACTION controlp INFIELD apbb024 name="construct.c.apbb024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb025
            #add-point:BEFORE FIELD apbb025 name="construct.b.apbb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb025
            
            #add-point:AFTER FIELD apbb025 name="construct.a.apbb025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb025
            #add-point:ON ACTION controlp INFIELD apbb025 name="construct.c.apbb025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb015
            #add-point:BEFORE FIELD apbb015 name="construct.b.apbb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb015
            
            #add-point:AFTER FIELD apbb015 name="construct.a.apbb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb015
            #add-point:ON ACTION controlp INFIELD apbb015 name="construct.c.apbb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb026
            #add-point:BEFORE FIELD apbb026 name="construct.b.apbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb026
            
            #add-point:AFTER FIELD apbb026 name="construct.a.apbb026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb026
            #add-point:ON ACTION controlp INFIELD apbb026 name="construct.c.apbb026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb027
            #add-point:BEFORE FIELD apbb027 name="construct.b.apbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb027
            
            #add-point:AFTER FIELD apbb027 name="construct.a.apbb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb027
            #add-point:ON ACTION controlp INFIELD apbb027 name="construct.c.apbb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb028
            #add-point:BEFORE FIELD apbb028 name="construct.b.apbb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb028
            
            #add-point:AFTER FIELD apbb028 name="construct.a.apbb028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb028
            #add-point:ON ACTION controlp INFIELD apbb028 name="construct.c.apbb028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb029
            #add-point:BEFORE FIELD apbb029 name="construct.b.apbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb029
            
            #add-point:AFTER FIELD apbb029 name="construct.a.apbb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb029
            #add-point:ON ACTION controlp INFIELD apbb029 name="construct.c.apbb029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb031
            #add-point:BEFORE FIELD apbb031 name="construct.b.apbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb031
            
            #add-point:AFTER FIELD apbb031 name="construct.a.apbb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb031
            #add-point:ON ACTION controlp INFIELD apbb031 name="construct.c.apbb031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb032
            #add-point:BEFORE FIELD apbb032 name="construct.b.apbb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb032
            
            #add-point:AFTER FIELD apbb032 name="construct.a.apbb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb032
            #add-point:ON ACTION controlp INFIELD apbb032 name="construct.c.apbb032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb033
            #add-point:BEFORE FIELD apbb033 name="construct.b.apbb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb033
            
            #add-point:AFTER FIELD apbb033 name="construct.a.apbb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb033
            #add-point:ON ACTION controlp INFIELD apbb033 name="construct.c.apbb033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb034
            #add-point:BEFORE FIELD apbb034 name="construct.b.apbb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb034
            
            #add-point:AFTER FIELD apbb034 name="construct.a.apbb034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb034
            #add-point:ON ACTION controlp INFIELD apbb034 name="construct.c.apbb034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb016
            #add-point:BEFORE FIELD apbb016 name="construct.b.apbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb016
            
            #add-point:AFTER FIELD apbb016 name="construct.a.apbb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb016
            #add-point:ON ACTION controlp INFIELD apbb016 name="construct.c.apbb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb017
            #add-point:BEFORE FIELD apbb017 name="construct.b.apbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb017
            
            #add-point:AFTER FIELD apbb017 name="construct.a.apbb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb017
            #add-point:ON ACTION controlp INFIELD apbb017 name="construct.c.apbb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb018
            #add-point:BEFORE FIELD apbb018 name="construct.b.apbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb018
            
            #add-point:AFTER FIELD apbb018 name="construct.a.apbb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb018
            #add-point:ON ACTION controlp INFIELD apbb018 name="construct.c.apbb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb019
            #add-point:BEFORE FIELD apbb019 name="construct.b.apbb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb019
            
            #add-point:AFTER FIELD apbb019 name="construct.a.apbb019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb019
            #add-point:ON ACTION controlp INFIELD apbb019 name="construct.c.apbb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb020
            #add-point:BEFORE FIELD apbb020 name="construct.b.apbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb020
            
            #add-point:AFTER FIELD apbb020 name="construct.a.apbb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb020
            #add-point:ON ACTION controlp INFIELD apbb020 name="construct.c.apbb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb021
            #add-point:BEFORE FIELD apbb021 name="construct.b.apbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb021
            
            #add-point:AFTER FIELD apbb021 name="construct.a.apbb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb021
            #add-point:ON ACTION controlp INFIELD apbb021 name="construct.c.apbb021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb202
            #add-point:ON ACTION controlp INFIELD apbb202 name="construct.c.apbb202"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3802"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apbb202
            NEXT FIELD apbb202
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb202
            #add-point:BEFORE FIELD apbb202 name="construct.b.apbb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb202
            
            #add-point:AFTER FIELD apbb202 name="construct.a.apbb202"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb203
            #add-point:BEFORE FIELD apbb203 name="construct.b.apbb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb203
            
            #add-point:AFTER FIELD apbb203 name="construct.a.apbb203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb203
            #add-point:ON ACTION controlp INFIELD apbb203 name="construct.c.apbb203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb204
            #add-point:BEFORE FIELD apbb204 name="construct.b.apbb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb204
            
            #add-point:AFTER FIELD apbb204 name="construct.a.apbb204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb204
            #add-point:ON ACTION controlp INFIELD apbb204 name="construct.c.apbb204"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb207
            #add-point:ON ACTION controlp INFIELD apbb207 name="construct.c.apbb207"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3803"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apbb207
            NEXT FIELD apbb207
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb207
            #add-point:BEFORE FIELD apbb207 name="construct.b.apbb207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb207
            
            #add-point:AFTER FIELD apbb207 name="construct.a.apbb207"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb042
            #add-point:BEFORE FIELD apbb042 name="construct.b.apbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb042
            
            #add-point:AFTER FIELD apbb042 name="construct.a.apbb042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb042
            #add-point:ON ACTION controlp INFIELD apbb042 name="construct.c.apbb042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb039
            #add-point:BEFORE FIELD apbb039 name="construct.b.apbb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb039
            
            #add-point:AFTER FIELD apbb039 name="construct.a.apbb039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb039
            #add-point:ON ACTION controlp INFIELD apbb039 name="construct.c.apbb039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb040
            #add-point:BEFORE FIELD apbb040 name="construct.b.apbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb040
            
            #add-point:AFTER FIELD apbb040 name="construct.a.apbb040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb040
            #add-point:ON ACTION controlp INFIELD apbb040 name="construct.c.apbb040"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbb041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb041
            #add-point:ON ACTION controlp INFIELD apbb041 name="construct.c.apbb041"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbb041
            NEXT FIELD apbb041
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb041
            #add-point:BEFORE FIELD apbb041 name="construct.b.apbb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb041
            
            #add-point:AFTER FIELD apbb041 name="construct.a.apbb041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb038
            #add-point:ON ACTION controlp INFIELD apbb038 name="construct.c.apbb038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3804"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apbb038
            NEXT FIELD apbb038
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb038
            #add-point:BEFORE FIELD apbb038 name="construct.b.apbb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb038
            
            #add-point:AFTER FIELD apbb038 name="construct.a.apbb038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb049
            #add-point:BEFORE FIELD apbb049 name="construct.b.apbb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb049
            
            #add-point:AFTER FIELD apbb049 name="construct.a.apbb049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb049
            #add-point:ON ACTION controlp INFIELD apbb049 name="construct.c.apbb049"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbownid
            #add-point:ON ACTION controlp INFIELD apbbownid name="construct.c.apbbownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbbownid
            NEXT FIELD apbbownid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbownid
            #add-point:BEFORE FIELD apbbownid name="construct.b.apbbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbownid
            
            #add-point:AFTER FIELD apbbownid name="construct.a.apbbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbowndp
            #add-point:ON ACTION controlp INFIELD apbbowndp name="construct.c.apbbowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO apbbowndp
            NEXT FIELD apbbowndp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbowndp
            #add-point:BEFORE FIELD apbbowndp name="construct.b.apbbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbowndp
            
            #add-point:AFTER FIELD apbbowndp name="construct.a.apbbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbcrtid
            #add-point:ON ACTION controlp INFIELD apbbcrtid name="construct.c.apbbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbbcrtid
            NEXT FIELD apbbcrtid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcrtid
            #add-point:BEFORE FIELD apbbcrtid name="construct.b.apbbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbcrtid
            
            #add-point:AFTER FIELD apbbcrtid name="construct.a.apbbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apbbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbcrtdp
            #add-point:ON ACTION controlp INFIELD apbbcrtdp name="construct.c.apbbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO apbbcrtdp
            NEXT FIELD apbbcrtdp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcrtdp
            #add-point:BEFORE FIELD apbbcrtdp name="construct.b.apbbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbcrtdp
            
            #add-point:AFTER FIELD apbbcrtdp name="construct.a.apbbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcrtdt
            #add-point:BEFORE FIELD apbbcrtdt name="construct.b.apbbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbmodid
            #add-point:ON ACTION controlp INFIELD apbbmodid name="construct.c.apbbmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbbmodid
            NEXT FIELD apbbmodid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbmodid
            #add-point:BEFORE FIELD apbbmodid name="construct.b.apbbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbmodid
            
            #add-point:AFTER FIELD apbbmodid name="construct.a.apbbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbmoddt
            #add-point:BEFORE FIELD apbbmoddt name="construct.b.apbbmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apbbcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbcnfid
            #add-point:ON ACTION controlp INFIELD apbbcnfid name="construct.c.apbbcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apbbcnfid
            NEXT FIELD apbbcnfid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcnfid
            #add-point:BEFORE FIELD apbbcnfid name="construct.b.apbbcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbcnfid
            
            #add-point:AFTER FIELD apbbcnfid name="construct.a.apbbcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcnfdt
            #add-point:BEFORE FIELD apbbcnfdt name="construct.b.apbbcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apbaorga,apba004,apba005,apba006,apba020,apba019,apba007,apba012,apba014, 
          apba010,apba103,apba105,apba104,apba113,apba115,apba114,apba016,apba017,apba111
           FROM s_detail1[1].apbaorga,s_detail1[1].apba004,s_detail1[1].apba005,s_detail1[1].apba006, 
               s_detail1[1].apba020,s_detail1[1].apba019,s_detail1[1].apba007,s_detail1[1].apba012,s_detail1[1].apba014, 
               s_detail1[1].apba010,s_detail1[1].apba103,s_detail1[1].apba105,s_detail1[1].apba104,s_detail1[1].apba113, 
               s_detail1[1].apba115,s_detail1[1].apba114,s_detail1[1].apba016,s_detail1[1].apba017,s_detail1[1].apba111 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            CALL cl_set_combo_scc_part('apba004','8541','10,11,12,13,16,19,20,21,23,26,27,29') #150519
            #20150601 add 12,13,23 lujh
            #150622-00007#1 開放27
            #160705-00035#1 add 10
            
            #160826-00017#1   add---s
            #LET l_ac = 1
            #LET g_apba_d[l_ac].apbaorga = ''
            #DISPLAY ARRAY g_apba_d TO s_detail1.*
            #   BEFORE DISPLAY
            #   EXIT DISPLAY
            #END DISPLAY
            #160826-00017#1   add---e
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbaorga
            #add-point:BEFORE FIELD apbaorga name="construct.b.page1.apbaorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbaorga
            
            #add-point:AFTER FIELD apbaorga name="construct.a.page1.apbaorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apbaorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbaorga
            #add-point:ON ACTION controlp INFIELD apbaorga name="construct.c.page1.apbaorga"
            #來源組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y'"   #161006-00005#4   add
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
               LET g_qryparam.where = g_qryparam.where,   #161006-00005#4   add
                                      " AND ooef001 IN ",g_wc_cs_orga
            END IF                                    #160125-00005#6
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO apbaorga
            NEXT FIELD apbaorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba004
            #add-point:BEFORE FIELD apba004 name="construct.b.page1.apba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba004
            
            #add-point:AFTER FIELD apba004 name="construct.a.page1.apba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba004
            #add-point:ON ACTION controlp INFIELD apba004 name="construct.c.page1.apba004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba005
            #add-point:BEFORE FIELD apba005 name="construct.b.page1.apba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba005
            
            #add-point:AFTER FIELD apba005 name="construct.a.page1.apba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba005
            #add-point:ON ACTION controlp INFIELD apba005 name="construct.c.page1.apba005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba006
            #add-point:BEFORE FIELD apba006 name="construct.b.page1.apba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba006
            
            #add-point:AFTER FIELD apba006 name="construct.a.page1.apba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba006
            #add-point:ON ACTION controlp INFIELD apba006 name="construct.c.page1.apba006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba020
            #add-point:BEFORE FIELD apba020 name="construct.b.page1.apba020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba020
            
            #add-point:AFTER FIELD apba020 name="construct.a.page1.apba020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba020
            #add-point:ON ACTION controlp INFIELD apba020 name="construct.c.page1.apba020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba019
            #add-point:BEFORE FIELD apba019 name="construct.b.page1.apba019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba019
            
            #add-point:AFTER FIELD apba019 name="construct.a.page1.apba019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba019
            #add-point:ON ACTION controlp INFIELD apba019 name="construct.c.page1.apba019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba007
            #add-point:ON ACTION controlp INFIELD apba007 name="construct.c.page1.apba007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apba007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apba007  #顯示到畫面上
            NEXT FIELD apba007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba007
            #add-point:BEFORE FIELD apba007 name="construct.b.page1.apba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba007
            
            #add-point:AFTER FIELD apba007 name="construct.a.page1.apba007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba012
            #add-point:BEFORE FIELD apba012 name="construct.b.page1.apba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba012
            
            #add-point:AFTER FIELD apba012 name="construct.a.page1.apba012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba012
            #add-point:ON ACTION controlp INFIELD apba012 name="construct.c.page1.apba012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba014
            #add-point:BEFORE FIELD apba014 name="construct.b.page1.apba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba014
            
            #add-point:AFTER FIELD apba014 name="construct.a.page1.apba014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba014
            #add-point:ON ACTION controlp INFIELD apba014 name="construct.c.page1.apba014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba010
            #add-point:BEFORE FIELD apba010 name="construct.b.page1.apba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba010
            
            #add-point:AFTER FIELD apba010 name="construct.a.page1.apba010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba010
            #add-point:ON ACTION controlp INFIELD apba010 name="construct.c.page1.apba010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba103
            #add-point:BEFORE FIELD apba103 name="construct.b.page1.apba103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba103
            
            #add-point:AFTER FIELD apba103 name="construct.a.page1.apba103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba103
            #add-point:ON ACTION controlp INFIELD apba103 name="construct.c.page1.apba103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba105
            #add-point:BEFORE FIELD apba105 name="construct.b.page1.apba105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba105
            
            #add-point:AFTER FIELD apba105 name="construct.a.page1.apba105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba105
            #add-point:ON ACTION controlp INFIELD apba105 name="construct.c.page1.apba105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba104
            #add-point:BEFORE FIELD apba104 name="construct.b.page1.apba104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba104
            
            #add-point:AFTER FIELD apba104 name="construct.a.page1.apba104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba104
            #add-point:ON ACTION controlp INFIELD apba104 name="construct.c.page1.apba104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba113
            #add-point:BEFORE FIELD apba113 name="construct.b.page1.apba113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba113
            
            #add-point:AFTER FIELD apba113 name="construct.a.page1.apba113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba113
            #add-point:ON ACTION controlp INFIELD apba113 name="construct.c.page1.apba113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba115
            #add-point:BEFORE FIELD apba115 name="construct.b.page1.apba115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba115
            
            #add-point:AFTER FIELD apba115 name="construct.a.page1.apba115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba115
            #add-point:ON ACTION controlp INFIELD apba115 name="construct.c.page1.apba115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba114
            #add-point:BEFORE FIELD apba114 name="construct.b.page1.apba114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba114
            
            #add-point:AFTER FIELD apba114 name="construct.a.page1.apba114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba114
            #add-point:ON ACTION controlp INFIELD apba114 name="construct.c.page1.apba114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba016
            #add-point:BEFORE FIELD apba016 name="construct.b.page1.apba016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba016
            
            #add-point:AFTER FIELD apba016 name="construct.a.page1.apba016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba016
            #add-point:ON ACTION controlp INFIELD apba016 name="construct.c.page1.apba016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba017
            #add-point:BEFORE FIELD apba017 name="construct.b.page1.apba017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba017
            
            #add-point:AFTER FIELD apba017 name="construct.a.page1.apba017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba017
            #add-point:ON ACTION controlp INFIELD apba017 name="construct.c.page1.apba017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba111
            #add-point:BEFORE FIELD apba111 name="construct.b.page1.apba111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba111
            
            #add-point:AFTER FIELD apba111 name="construct.a.page1.apba111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apba111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba111
            #add-point:ON ACTION controlp INFIELD apba111 name="construct.c.page1.apba111"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON isamseq,isam008,isam037,isam011,isam010,isam200,isam030,isam014,isam015, 
          isam023,isam024,isam025,isam026,isam027,isam028
           FROM s_detail2[1].isamseq,s_detail2[1].isam008,s_detail2[1].isam037,s_detail2[1].isam011, 
               s_detail2[1].isam010,s_detail2[1].isam200,s_detail2[1].isam030,s_detail2[1].isam014,s_detail2[1].isam015, 
               s_detail2[1].isam023,s_detail2[1].isam024,s_detail2[1].isam025,s_detail2[1].isam026,s_detail2[1].isam027, 
               s_detail2[1].isam028
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            #160826-00017#1   add---s
            #LET l_ac = 1
            #LET g_apba2_d[l_ac].isam008 = ''
            #DISPLAY ARRAY g_apba2_d TO s_detail2.*
            #   BEFORE DISPLAY
            #   EXIT DISPLAY
            #END DISPLAY
            #160826-00017#1   add---e
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isamcrtdt>>----
 
         #----<<isammoddt>>----
         
         #----<<isamcnfdt>>----
         
         #----<<isampstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamseq
            #add-point:BEFORE FIELD isamseq name="construct.b.page2.isamseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamseq
            
            #add-point:AFTER FIELD isamseq name="construct.a.page2.isamseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamseq
            #add-point:ON ACTION controlp INFIELD isamseq name="construct.c.page2.isamseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam008
            #add-point:ON ACTION controlp INFIELD isam008 name="construct.c.page2.isam008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_wc_ooef019,"' "  #161101-00070#1 add
            CALL q_isac002()
            DISPLAY g_qryparam.return1 TO isam008
            NEXT FIELD isam008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam008
            #add-point:BEFORE FIELD isam008 name="construct.b.page2.isam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam008
            
            #add-point:AFTER FIELD isam008 name="construct.a.page2.isam008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam037
            #add-point:BEFORE FIELD isam037 name="construct.b.page2.isam037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam037
            
            #add-point:AFTER FIELD isam037 name="construct.a.page2.isam037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam037
            #add-point:ON ACTION controlp INFIELD isam037 name="construct.c.page2.isam037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam011
            #add-point:BEFORE FIELD isam011 name="construct.b.page2.isam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam011
            
            #add-point:AFTER FIELD isam011 name="construct.a.page2.isam011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam011
            #add-point:ON ACTION controlp INFIELD isam011 name="construct.c.page2.isam011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.isam010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam010
            #add-point:ON ACTION controlp INFIELD isam010 name="construct.c.page2.isam010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isam010()
            DISPLAY g_qryparam.return1 TO isam010
            NEXT FIELD isam010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam010
            #add-point:BEFORE FIELD isam010 name="construct.b.page2.isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam010
            
            #add-point:AFTER FIELD isam010 name="construct.a.page2.isam010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam200
            #add-point:BEFORE FIELD isam200 name="construct.b.page2.isam200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam200
            
            #add-point:AFTER FIELD isam200 name="construct.a.page2.isam200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam200
            #add-point:ON ACTION controlp INFIELD isam200 name="construct.c.page2.isam200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam030
            #add-point:BEFORE FIELD isam030 name="construct.b.page2.isam030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam030
            
            #add-point:AFTER FIELD isam030 name="construct.a.page2.isam030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam030
            #add-point:ON ACTION controlp INFIELD isam030 name="construct.c.page2.isam030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam014
            #add-point:ON ACTION controlp INFIELD isam014 name="construct.c.page2.isam014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO isam014
            NEXT FIELD isam014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam014
            #add-point:BEFORE FIELD isam014 name="construct.b.page2.isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam014
            
            #add-point:AFTER FIELD isam014 name="construct.a.page2.isam014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam015
            #add-point:BEFORE FIELD isam015 name="construct.b.page2.isam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam015
            
            #add-point:AFTER FIELD isam015 name="construct.a.page2.isam015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam015
            #add-point:ON ACTION controlp INFIELD isam015 name="construct.c.page2.isam015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam023
            #add-point:BEFORE FIELD isam023 name="construct.b.page2.isam023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam023
            
            #add-point:AFTER FIELD isam023 name="construct.a.page2.isam023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam023
            #add-point:ON ACTION controlp INFIELD isam023 name="construct.c.page2.isam023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam024
            #add-point:BEFORE FIELD isam024 name="construct.b.page2.isam024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam024
            
            #add-point:AFTER FIELD isam024 name="construct.a.page2.isam024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam024
            #add-point:ON ACTION controlp INFIELD isam024 name="construct.c.page2.isam024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam025
            #add-point:BEFORE FIELD isam025 name="construct.b.page2.isam025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam025
            
            #add-point:AFTER FIELD isam025 name="construct.a.page2.isam025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam025
            #add-point:ON ACTION controlp INFIELD isam025 name="construct.c.page2.isam025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam026
            #add-point:BEFORE FIELD isam026 name="construct.b.page2.isam026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam026
            
            #add-point:AFTER FIELD isam026 name="construct.a.page2.isam026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam026
            #add-point:ON ACTION controlp INFIELD isam026 name="construct.c.page2.isam026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam027
            #add-point:BEFORE FIELD isam027 name="construct.b.page2.isam027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam027
            
            #add-point:AFTER FIELD isam027 name="construct.a.page2.isam027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam027
            #add-point:ON ACTION controlp INFIELD isam027 name="construct.c.page2.isam027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam028
            #add-point:BEFORE FIELD isam028 name="construct.b.page2.isam028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam028
            
            #add-point:AFTER FIELD isam028 name="construct.a.page2.isam028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam028
            #add-point:ON ACTION controlp INFIELD isam028 name="construct.c.page2.isam028"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON isau003,isau004,isauseq,isau007,isau008,isau014,isau015,isau016,isau017, 
          isau018,isau019,isau020,isau208
           FROM s_detail3[1].isau003,s_detail3[1].isau004,s_detail3[1].isauseq,s_detail3[1].isau007, 
               s_detail3[1].isau008,s_detail3[1].isau014,s_detail3[1].isau015,s_detail3[1].isau016,s_detail3[1].isau017, 
               s_detail3[1].isau018,s_detail3[1].isau019,s_detail3[1].isau020,s_detail3[1].isau208
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau003
            #add-point:BEFORE FIELD isau003 name="construct.b.page3.isau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau003
            
            #add-point:AFTER FIELD isau003 name="construct.a.page3.isau003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau003
            #add-point:ON ACTION controlp INFIELD isau003 name="construct.c.page3.isau003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau004
            #add-point:BEFORE FIELD isau004 name="construct.b.page3.isau004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau004
            
            #add-point:AFTER FIELD isau004 name="construct.a.page3.isau004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau004
            #add-point:ON ACTION controlp INFIELD isau004 name="construct.c.page3.isau004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isauseq
            #add-point:BEFORE FIELD isauseq name="construct.b.page3.isauseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isauseq
            
            #add-point:AFTER FIELD isauseq name="construct.a.page3.isauseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isauseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isauseq
            #add-point:ON ACTION controlp INFIELD isauseq name="construct.c.page3.isauseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau007
            #add-point:BEFORE FIELD isau007 name="construct.b.page3.isau007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau007
            
            #add-point:AFTER FIELD isau007 name="construct.a.page3.isau007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau007
            #add-point:ON ACTION controlp INFIELD isau007 name="construct.c.page3.isau007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau008
            #add-point:BEFORE FIELD isau008 name="construct.b.page3.isau008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau008
            
            #add-point:AFTER FIELD isau008 name="construct.a.page3.isau008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau008
            #add-point:ON ACTION controlp INFIELD isau008 name="construct.c.page3.isau008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau014
            #add-point:BEFORE FIELD isau014 name="construct.b.page3.isau014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau014
            
            #add-point:AFTER FIELD isau014 name="construct.a.page3.isau014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau014
            #add-point:ON ACTION controlp INFIELD isau014 name="construct.c.page3.isau014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau015
            #add-point:BEFORE FIELD isau015 name="construct.b.page3.isau015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau015
            
            #add-point:AFTER FIELD isau015 name="construct.a.page3.isau015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau015
            #add-point:ON ACTION controlp INFIELD isau015 name="construct.c.page3.isau015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau016
            #add-point:BEFORE FIELD isau016 name="construct.b.page3.isau016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau016
            
            #add-point:AFTER FIELD isau016 name="construct.a.page3.isau016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau016
            #add-point:ON ACTION controlp INFIELD isau016 name="construct.c.page3.isau016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau017
            #add-point:BEFORE FIELD isau017 name="construct.b.page3.isau017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau017
            
            #add-point:AFTER FIELD isau017 name="construct.a.page3.isau017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau017
            #add-point:ON ACTION controlp INFIELD isau017 name="construct.c.page3.isau017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau018
            #add-point:BEFORE FIELD isau018 name="construct.b.page3.isau018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau018
            
            #add-point:AFTER FIELD isau018 name="construct.a.page3.isau018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau018
            #add-point:ON ACTION controlp INFIELD isau018 name="construct.c.page3.isau018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau019
            #add-point:BEFORE FIELD isau019 name="construct.b.page3.isau019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau019
            
            #add-point:AFTER FIELD isau019 name="construct.a.page3.isau019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau019
            #add-point:ON ACTION controlp INFIELD isau019 name="construct.c.page3.isau019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau020
            #add-point:BEFORE FIELD isau020 name="construct.b.page3.isau020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau020
            
            #add-point:AFTER FIELD isau020 name="construct.a.page3.isau020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau020
            #add-point:ON ACTION controlp INFIELD isau020 name="construct.c.page3.isau020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau208
            #add-point:BEFORE FIELD isau208 name="construct.b.page3.isau208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau208
            
            #add-point:AFTER FIELD isau208 name="construct.a.page3.isau208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.isau208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau208
            #add-point:ON ACTION controlp INFIELD isau208 name="construct.c.page3.isau208"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL cl_set_comp_visible("apba016,apba017",TRUE)
         CALL cl_set_comp_visible('apbb009,apba016,isam009',TRUE)
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#39 add
         #160826-00017#1   add---s
         #LET g_aw = g_curr_diag.getCurrentItem()
         #LET l_ac = 1
         #IF g_aw = 's_detail1' THEN
         #   LET g_apba_d[l_ac].apbaorga = ''
         #   DISPLAY ARRAY g_apba_d TO s_detail1.*
         #      BEFORE DISPLAY
         #      EXIT DISPLAY
         #   END DISPLAY
         #END IF
         #160826-00017#1   add---e
         
         #IF g_aw = 's_detail2' THEN   #160826-00017#1   add
            LET g_apba2_d[1].isam008 = ''
            DISPLAY ARRAY g_apba2_d TO s_detail2.*
               BEFORE DISPLAY
               EXIT DISPLAY
            END DISPLAY
         #END IF   #160826-00017#1   add
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apbb_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apba_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "isam_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "isau_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #160907-00041#1 --s add
   IF cl_null(g_wc)THEN
      LET g_wc = " apbbcomp IN ",g_wc_cs_comp  
   ELSE
      LET g_wc = g_wc," AND apbbcomp IN ",g_wc_cs_comp   
   END IF
   #160907-00041#1 --e add
   #161104-00046#4 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#4 --e add     
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt110_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON apbbcomp,apbb011,apbb002,apbb008,apbb009,apbb010,apbbdocno,apbb036
                          FROM s_browse[1].b_apbbcomp,s_browse[1].b_apbb011,s_browse[1].b_apbb002,s_browse[1].b_apbb008, 
                              s_browse[1].b_apbb009,s_browse[1].b_apbb010,s_browse[1].b_apbbdocno,s_browse[1].b_apbb036 
 
 
         BEFORE CONSTRUCT
               DISPLAY aapt110_filter_parser('apbbcomp') TO s_browse[1].b_apbbcomp
            DISPLAY aapt110_filter_parser('apbb011') TO s_browse[1].b_apbb011
            DISPLAY aapt110_filter_parser('apbb002') TO s_browse[1].b_apbb002
            DISPLAY aapt110_filter_parser('apbb008') TO s_browse[1].b_apbb008
            DISPLAY aapt110_filter_parser('apbb009') TO s_browse[1].b_apbb009
            DISPLAY aapt110_filter_parser('apbb010') TO s_browse[1].b_apbb010
            DISPLAY aapt110_filter_parser('apbbdocno') TO s_browse[1].b_apbbdocno
            DISPLAY aapt110_filter_parser('apbb036') TO s_browse[1].b_apbb036
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         #160826-00017#1   add---s
         #LET g_aw = g_curr_diag.getCurrentItem()
         #LET l_ac = 1
         #IF g_aw = 's_detail1' THEN
         #   LET g_apba_d[l_ac].apbaorga = ''
         #   DISPLAY ARRAY g_apba_d TO s_detail1.*
         #      BEFORE DISPLAY
         #      EXIT DISPLAY
         #   END DISPLAY
         #END IF
         #
         #IF g_aw = 's_detail2' THEN
         #   LET g_apba2_d[l_ac].isam008 = ''
         #   DISPLAY ARRAY g_apba2_d TO s_detail2.*
         #      BEFORE DISPLAY
         #      EXIT DISPLAY
         #   END DISPLAY
         #END IF
         #160826-00017#1   add---e
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aapt110_filter_show('apbbcomp')
   CALL aapt110_filter_show('apbb011')
   CALL aapt110_filter_show('apbb002')
   CALL aapt110_filter_show('apbb008')
   CALL aapt110_filter_show('apbb009')
   CALL aapt110_filter_show('apbb010')
   CALL aapt110_filter_show('apbbdocno')
   CALL aapt110_filter_show('apbb036')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt110_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt110_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapt110_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt110_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apba_d.clear()
   CALL g_apba2_d.clear()
   CALL g_apba3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt110_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt110_browser_fill("")
      CALL aapt110_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt110_filter_show('apbbcomp')
   CALL aapt110_filter_show('apbb011')
   CALL aapt110_filter_show('apbb002')
   CALL aapt110_filter_show('apbb008')
   CALL aapt110_filter_show('apbb009')
   CALL aapt110_filter_show('apbb010')
   CALL aapt110_filter_show('apbbdocno')
   CALL aapt110_filter_show('apbb036')
   CALL aapt110_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt110_fetch("F") 
      #顯示單身筆數
      CALL aapt110_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt110_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apbb_m.apbbdocno = g_browser[g_current_idx].b_apbbdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
   #遮罩相關處理
   LET g_apbb_m_mask_o.* =  g_apbb_m.*
   CALL aapt110_apbb_t_mask()
   LET g_apbb_m_mask_n.* =  g_apbb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt110_set_act_visible()   
   CALL aapt110_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apbb_m_t.* = g_apbb_m.*
   LET g_apbb_m_o.* = g_apbb_m.*
   
   LET g_data_owner = g_apbb_m.apbbownid      
   LET g_data_dept  = g_apbb_m.apbbowndp
   
   #重新顯示   
   CALL aapt110_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt110_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE  l_exchange2     LIKE type_t.num20_6
   DEFINE  l_exchange3     LIKE type_t.num20_6
   #151012-00014#2-----s
   #交易對象資料轉換
   DEFINE ls_js            STRING
   DEFINE lc_param         RECORD
            apca004           LIKE apca_t.apca004
                           END RECORD
   #151012-00014#2-----e
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apba_d.clear()   
   CALL g_apba2_d.clear()  
   CALL g_apba3_d.clear()  
 
 
   INITIALIZE g_apbb_m.* TO NULL             #DEFAULT 設定
   
   LET g_apbbdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apbb_m.apbbownid = g_user
      LET g_apbb_m.apbbowndp = g_dept
      LET g_apbb_m.apbbcrtid = g_user
      LET g_apbb_m.apbbcrtdp = g_dept 
      LET g_apbb_m.apbbcrtdt = cl_get_current()
      LET g_apbb_m.apbbmodid = g_user
      LET g_apbb_m.apbbmoddt = cl_get_current()
      LET g_apbb_m.apbbstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_apbb_m.apbb050 = "1"
      LET g_apbb_m.apbb037 = "1"
      LET g_apbb_m.apbb200 = "N"
      LET g_apbb_m.apbb056 = "N"
      LET g_apbb_m.apbb023 = "0"
      LET g_apbb_m.apbb024 = "0"
      LET g_apbb_m.apbb025 = "0"
      LET g_apbb_m.apbb026 = "0"
      LET g_apbb_m.apbb027 = "0"
      LET g_apbb_m.apbb028 = "0"
      LET g_apbb_m.apbb205 = "N"
      LET g_apbb_m.apbb107 = "0"
      LET g_apbb_m.apbb108 = "0"
      LET g_apbb_m.apbb117 = "0"
      LET g_apbb_m.apbb118 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apbb_m.apba103_s = "0"
      LET g_apbb_m.apba104_s = "0"
      LET g_apbb_m.apba105_s = "0"
      LET g_apbb_m.apba113_s = "0"
      LET g_apbb_m.apba114_s = "0"
      LET g_apbb_m.apba115_s = "0"
      
      #帳務中心
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_apbb_m.apbb004,g_errno
      CALL s_desc_get_department_desc(g_apbb_m.apbb004) RETURNING g_apbb_m.l_apbb004_desc
      #公司法人
      CALL s_fin_orga_get_comp_ld(g_apbb_m.apbb004) RETURNING g_sub_success,g_errno,g_apbb_m.apbbcomp,g_ld
      CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
      #161111-00042#1 add ------
      CALL s_fin_get_wc_str(g_apbb_m.apbbcomp) RETURNING g_comp_str  #161229-00047#39 add 
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl           #161229-00047#39 add 
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbb_m.apbbcomp) RETURNING g_sub_success,g_sql_ctrl   #161229-00047#39 mark
      #161111-00042#1 add end---
      #抓取購貨方訊息
      CALL aapt110_buy_info(g_apbb_m.apbbcomp) RETURNING g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,
                                                         g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021
      #登錄人員
      LET g_apbb_m.apbb053 = g_user
      CALL s_desc_get_person_desc(g_apbb_m.apbb053) RETURNING g_apbb_m.l_apbb053_desc
      #登錄日期
      LET g_apbb_m.apbbdocdt = g_today
      #發票日期
      LET g_apbb_m.apbb011 = g_today
      #可扣抵代號
      LET g_apbb_m.apbb037 = '1'
      #電子發票否
      LET g_apbb_m.apbb200 = 'N'
      #幣別
      SELECT glaa001 INTO g_glaa001
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_apbb_m.apbbcomp
         AND glaa014  = 'Y'
      LET g_apbb_m.apbb014 = g_glaa001
      #匯率
      IF NOT cl_null(g_apbb_m.apbb011) AND NOT cl_null(g_apbb_m.apbb002) THEN
      #151012-00014#2-----s
      LET lc_param.apca004 = g_apbb_m.apbb002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,ls_js)
     #CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,'S-BAS-0014')
      RETURNING g_apbb_m.apbb015,l_exchange2,l_exchange3
      #151012-00014#2-----e
      ELSE
      LET g_apbb_m.apbb015 = 1
      END IF
      CALL aapt110_set_info()
      
      #160705-00035#1 -s
      LET g_apbb_m.apbb003 = "2"
      
      #取得帳務組織下所屬成員
      CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1')
      #取得帳務組織底下所屬的法人範圍
      CALL s_fin_account_center_comp_str() RETURNING g_wc_apbacomp
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apbaorga
      #將取回的字串轉換為SQL條件
      CALL s_fin_get_wc_str(g_wc_apbacomp) RETURNING g_wc_apbacomp
      CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
      #160705-00035#1 -e
      
      LET g_apbb_m_t.* = g_apbb_m.*    #設定預設值後
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apbb_m_t.* = g_apbb_m.*
      LET g_apbb_m_o.* = g_apbb_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apbb_m.apbbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aapt110_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_apbb_m.* TO NULL
         INITIALIZE g_apba_d TO NULL
         INITIALIZE g_apba2_d TO NULL
         INITIALIZE g_apba3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt110_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apba_d.clear()
      #CALL g_apba2_d.clear()
      #CALL g_apba3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt110_set_act_visible()   
   CALL aapt110_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apbbent = " ||g_enterprise|| " AND",
                      " apbbdocno = '", g_apbb_m.apbbdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt110_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt110_cl
   
   CALL aapt110_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
   
   #遮罩相關處理
   LET g_apbb_m_mask_o.* =  g_apbb_m.*
   CALL aapt110_apbb_t_mask()
   LET g_apbb_m_mask_n.* =  g_apbb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.l_apbb004_desc,g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc, 
       g_apbb_m.apbb053,g_apbb_m.l_apbb053_desc,g_apbb_m.apbbdocno,g_apbb_m.l_apbbdocno_desc,g_apbb_m.apbbdocdt, 
       g_apbb_m.apbb002,g_apbb_m.l_apbb002_desc,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009, 
       g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc, 
       g_apbb_m.apbb054,g_apbb_m.l_apbb054_desc,g_apbb_m.apbb012,g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.l_apbb030_2,g_apbb_m.apbb031,g_apbb_m.apbb032, 
       g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019, 
       g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc,g_apbb_m.apbb203,g_apbb_m.apbb204, 
       g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc,g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.l_apbb036_2, 
       g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.l_apbb041_desc,g_apbb_m.apbb038, 
       g_apbb_m.l_apbb038_desc,g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118, 
       g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.l_apbb210_desc,g_apbb_m.apbbownid, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtid_desc, 
       g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmodid_desc, 
       g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfid_desc,g_apbb_m.apbbcnfdt,g_apbb_m.apba103_s, 
       g_apbb_m.apba104_s,g_apbb_m.apba105_s,g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apbb_m.apbbownid      
   LET g_data_dept  = g_apbb_m.apbbowndp
   
   #功能已完成,通報訊息中心
   CALL aapt110_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt110_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_success        LIKE type_t.num5    #20150629 add lujh
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apbb_m_t.* = g_apbb_m.*
   LET g_apbb_m_o.* = g_apbb_m.*
   
   IF g_apbb_m.apbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
   CALL s_transaction_begin()
   
   OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aapt110_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apbb_m_mask_o.* =  g_apbb_m.*
   CALL aapt110_apbb_t_mask()
   LET g_apbb_m_mask_n.* =  g_apbb_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   #20150629--add--str--lujh
   CALL aapt110_aapt210_exist_chk() RETURNING l_success
   IF l_success = FALSE THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'aap-00377'
      LET g_errparam.extend = g_apbb_m.apbbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #20150629--add--end--lujh
   
   #160705-00035#1 -s
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1')
   #取得帳務組織底下所屬的法人範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apbacomp
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apbaorga
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(g_wc_apbacomp) RETURNING g_wc_apbacomp
   CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
   #160705-00035#1 -e
   #161111-00042#1 add ------
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbb_m.apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#39 mark
   #161111-00042#1 add end---
   #161229-00047#39 --s add 
   CALL s_fin_get_wc_str(g_apbb_m.apbbcomp) RETURNING g_comp_str  
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#39 --e add 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aapt110_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apbb_m.apbbmodid = g_user 
LET g_apbb_m.apbbmoddt = cl_get_current()
LET g_apbb_m.apbbmodid_desc = cl_get_username(g_apbb_m.apbbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_apbb_m.apbbstus MATCHES "[DR]" THEN 
         LET g_apbb_m.apbbstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt110_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apbb_t SET (apbbmodid,apbbmoddt) = (g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt)
          WHERE apbbent = g_enterprise AND apbbdocno = g_apbbdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apbb_m.* = g_apbb_m_t.*
            CALL aapt110_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apbb_m.apbbdocno != g_apbb_m_t.apbbdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apba_t SET apbadocno = g_apbb_m.apbbdocno
 
          WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m_t.apbbdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apba_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE isam_t
            SET isamdocno = g_apbb_m.apbbdocno
 
          WHERE isament = g_enterprise AND
                isamdocno = g_apbbdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "isam_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE isau_t
            SET isaudocno = g_apbb_m.apbbdocno
 
          WHERE isauent = g_enterprise AND
                isaudocno = g_apbbdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "isau_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt110_set_act_visible()   
   CALL aapt110_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apbbent = " ||g_enterprise|| " AND",
                      " apbbdocno = '", g_apbb_m.apbbdocno, "' "
 
   #填到對應位置
   CALL aapt110_browser_fill("")
 
   CLOSE aapt110_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt110_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt110.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt110_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_sql                 STRING
   DEFINE  l_ooef004             LIKE ooef_t.ooef004   #單據別參照表號
   DEFINE  l_oodb011             LIKE oodb_t.oodb011
   DEFINE  l_exchange2           LIKE type_t.num20_6
   DEFINE  l_exchange3           LIKE type_t.num20_6
   DEFINE  l_apba103             LIKE apba_t.apba103
   DEFINE  l_apba104             LIKE apba_t.apba104
   DEFINE  l_apba105             LIKE apba_t.apba105
   DEFINE  l_apba113             LIKE apba_t.apba113
   DEFINE  l_apba114             LIKE apba_t.apba114
   DEFINE  l_apba115             LIKE apba_t.apba115
   DEFINE  l_sum                 LIKE apbb_t.apbb026
   DEFINE  l_field               LIKE type_t.chr10
   DEFINE  l_apbb_money          LIKE isam_t.isam026
   DEFINE  l_apbb010             LIKE apbb_t.apbb010
   DEFINE  l_sum_apba010         LIKE apba_t.apba010  #在aapt110使用的數量總和   
   DEFINE  l_used_apba010        LIKE apba_t.apba010  #總共使用的數量
   DEFINE  l_pmdt024             LIKE pmdt_t.pmdt024
   DEFINE  l_pmdt069             LIKE pmdt_t.pmdt069
   DEFINE  l_sfin3015            LIKE type_t.chr1     #發票限制同法人否?
   DEFINE  l_isam002             LIKE isam_t.isam002
   DEFINE  l_isam011             LIKE isam_t.isam011
   DEFINE  l_isam014             LIKE isam_t.isam014
   DEFINE  l_glaa024             LIKE glaa_t.glaa024  #帳套單據別參照表
   DEFINE  l_change_tax          LIKE type_t.chr1     #稅別有沒有變動的紀錄
   DEFINE  l_change_rate         LIKE type_t.chr1     #匯率有沒有變動的紀錄
   DEFINE  l_change              LIKE type_t.chr1     #確認要不要執行更新
   DEFINE  l_date                LIKE apbb_t.apbb055  #應付款日            #141218-00011#1
   DEFINE  l_gen_flag            LIKE type_t.chr1     #是否使用自動產生單身 #141218-00011#1
   DEFINE  l_apba_flag           LIKE type_t.chr1     #20150317 add
   DEFINE  l_flag                LIKE type_t.chr1     #20150317 add
   DEFINE  l_stbe001             LIKE stbe_t.stbe001  #20150601 add lujh
   
   #150702-00001#1-----s
   DEFINE l_pmds000_str1         STRING   #可入AP的入庫單性質
   DEFINE l_pmds000_str2         STRING   #入庫單性質(入庫)
   DEFINE l_pmds000_str4         STRING   #入庫單性質(倉退)
   DEFINE l_pmds000_str5         STRING   #入庫單性質(驗退)
   DEFINE l_pmds011_str1         STRING   #160530-00005#3
   DEFINE l_str                  STRING   #文字處理用
   #150702-00001#1-----e
   
   #151012-00014#2-----s
   #交易對象資料轉換
   DEFINE ls_js                  STRING
   DEFINE lc_param               RECORD
            apca004                 LIKE apca_t.apca004
                                 END RECORD
   #151012-00014#2-----e
   #161230-00036#1 mark ------
   #DEFINE l_isac004              LIKE isac_t.isac004
   #DEFINE l_isac008              LIKE isac_t.isac008   #161115-00002#1 add
   #161230-00036#1 mark end---
   #160705-00035#1-S
   DEFINE l_wc                   STRING
   DEFINE l_apce                 RECORD
            apce109                 LIKE apce_t.apce109,
            apce119                 LIKE apce_t.apce119,
            apce129                 LIKE apce_t.apce129,
            apce139                 LIKE apce_t.apce139
                                 END RECORD
   #160705-00035#1-E
   DEFINE l_money                LIKE apba_t.apba103  #160802-00049#1
   DEFINE l_cnt_comp             LIKE type_t.num10    #160907-00041#1 add
   DEFINE l_success              LIKE type_t.num10    #161102-00055#1 add
   #160826-00017#1   add---s
   DEFINE l_sum1            RECORD
          apba103           LIKE apba_t.apba103,
          apba104           LIKE apba_t.apba104,
          apba105           LIKE apba_t.apba105,
          apba113           LIKE apba_t.apba113,
          apba114           LIKE apba_t.apba114,
          apba115           LIKE apba_t.apba115
          END RECORD
   #160826-00017#1   add---e
   #DEFINE l_ooef011         LIKE ooef_t.ooef011   #161115-00002#1 add #161230-00036#1 mark
   #161206-00042#5-----s
   DEFINE l_pmaa004         LIKE pmaa_t.pmaa004
   #161206-00042#5-----e
   DEFINE l_isamcnt         LIKE type_t.num10      #170110-00044#1  add
   DEFINE l_flag1           LIKE type_t.num5       #161104-00046#4 add
   DEFINE l_wc2             STRING                 #170110-00035#1
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.l_apbb004_desc,g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc, 
       g_apbb_m.apbb053,g_apbb_m.l_apbb053_desc,g_apbb_m.apbbdocno,g_apbb_m.l_apbbdocno_desc,g_apbb_m.apbbdocdt, 
       g_apbb_m.apbb002,g_apbb_m.l_apbb002_desc,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009, 
       g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc, 
       g_apbb_m.apbb054,g_apbb_m.l_apbb054_desc,g_apbb_m.apbb012,g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.l_apbb030_2,g_apbb_m.apbb031,g_apbb_m.apbb032, 
       g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019, 
       g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc,g_apbb_m.apbb203,g_apbb_m.apbb204, 
       g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc,g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.l_apbb036_2, 
       g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.l_apbb041_desc,g_apbb_m.apbb038, 
       g_apbb_m.l_apbb038_desc,g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118, 
       g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.l_apbb210_desc,g_apbb_m.apbbownid, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtid_desc, 
       g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmodid_desc, 
       g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfid_desc,g_apbb_m.apbbcnfdt,g_apbb_m.apba103_s, 
       g_apbb_m.apba104_s,g_apbb_m.apba105_s,g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apbaseq,apbaorga,apba004,apba005,apba006,apba020,apba019,apba007,apba008, 
       apba013,apba015,apba012,apba100,apba009,apba014,apba010,apba103,apba105,apba104,apba113,apba115, 
       apba114,apba016,apba017,apba111 FROM apba_t WHERE apbaent=? AND apbadocno=? AND apbaseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt110_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT isamseq,isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam012, 
       isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036,isam050,isamstus,isamcomp, 
       isam001 FROM isam_t WHERE isament=? AND isamdocno=? AND isamseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt110_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT isau003,isau004,isauseq,isau007,isau008,isau014,isau015,isau016,isau017, 
       isau018,isau019,isau020,isau208 FROM isau_t WHERE isauent=? AND isaudocno=? AND isauseq=? AND  
       isau003=? AND isau004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt110_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt110_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
 
   #end add-point
   CALL aapt110_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.apbbcomp,g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt, 
       g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010, 
       g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011,g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052, 
       g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036, 
       g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024, 
       g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029, 
       g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017, 
       g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203, 
       g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041, 
       g_apbb_m.apbb038,g_apbb_m.apbb049
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #160705-00035#1 mark ------
   ##發票性質apbb050='2.紅字發票'才開放扣抵藍字發票欄位
   #IF g_apbb_m.apbb050 = 2 THEN
   #   CALL cl_set_comp_visible("apba016,apba017",TRUE)
   #   CALL cl_set_combo_scc_part('apba004','8541','12,20,21,23,26,29') #來源作業 #150318-00010#1 take out 27  #20150601 add 12,23 lujh
   #ELSE
   #   CALL cl_set_comp_visible("apba016,apba017",FALSE)
   #   CALL cl_set_combo_scc_part('apba004','8541','11,12,13,16,19,20,21,23,26,27,29') #來源作業
   #   #150318-00010#1 take out17/27
   #   #20150601 add 12,13,23 lujh
   #   #150622-00007#1 開放27
   #END IF
   #160705-00035#1 mark end---
   #160705-00035#1 add ------
   #依照對帳方式，決定單身"來源作業類型"
   CASE g_apbb_m.apbb003
      WHEN '2'  #2:進貨發票立帳
         CALL cl_set_combo_scc_part('apba004','8541','11,12,13,16,19,20,21,23,26,27,29')
      WHEN '5'  #5:發票扣抵單立帳
         CALL cl_set_combo_scc_part('apba004','8541','12,20,21,23,26,29')
      WHEN '7'  #7:預付發票立帳
         CALL cl_set_combo_scc_part('apba004','8541','10,19,29')
      WHEN '8'  #8:雜項發票立帳
         CALL cl_set_combo_scc_part('apba004','8541','12,13,16,19,23,26,27,29')
      WHEN '9'  #9:雜項待抵立帳
         CALL cl_set_combo_scc_part('apba004','8541','23,26,27,29')
   END CASE
   #160705-00035#1 add end---
   
   #抓取"發票編碼方式"決定是否隱藏"發票代碼"
   CALL aapt110_set_entry_invoice_code()
   #抓取"電子發票否"決定是否開啟電子發票相關欄位
   IF g_apbb_m.apbb200 = "N" THEN
      CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",FALSE)
   ELSE
      CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",TRUE)
   END IF
   
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
  
   LET l_pmds000_str2 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = 1 ")
   LET l_pmds000_str2 = s_fin_get_wc_str(l_pmds000_str2)    
  
   LET l_pmds000_str4 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = -1 AND gzcb005 = 1 ")
   LET l_pmds000_str4 = s_fin_get_wc_str(l_pmds000_str4)  
   
   LET l_pmds000_str5 = s_aap_get_acc_str('2060',"gzcb004 = -1 AND gzcb005 = 2 ")
   LET l_pmds000_str5 = s_fin_get_wc_str(l_pmds000_str5)  
   #150702-00001#1-----e
   #160530-00005#3--s
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)   
   #160530-00005#3--e
   
   #20150317--add--str--
   LET l_apba_flag = 'N'
   LET g_errshow = 1
   
   WHILE TRUE
      LET l_flag = 'N'
      IF l_apba_flag = 'Y' THEN   
         CALL s_transaction_begin()
      END IF
   #20150317--add--end--
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt110.input.head" >}
      #單頭段
      INPUT BY NAME g_apbb_m.apbb004,g_apbb_m.apbbcomp,g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt, 
          g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010, 
          g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011,g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052, 
          g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036, 
          g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024, 
          g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029, 
          g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017, 
          g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203, 
          g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041, 
          g_apbb_m.apbb038,g_apbb_m.apbb049 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt110_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt110_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
            #150127-00005#1 add ------
            #複製前資料清空
            IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
               LET g_apbb_m.apbb053 = g_user
               CALL s_desc_get_person_desc(g_apbb_m.apbb053) RETURNING g_apbb_m.l_apbb053_desc
               DISPLAY BY NAME g_apbb_m.l_apbb053_desc
               LET g_apbb_m.apbb010 = ''
               LET g_apbb_m.apbb023 = ''
               LET g_apbb_m.apbb024 = ''
               LET g_apbb_m.apbb025 = ''
               LET g_apbb_m.apbb026 = ''
               LET g_apbb_m.apbb027 = ''
               LET g_apbb_m.apbb028 = ''
               CALL g_apba_d.clear()
               CALL g_apba2_d.clear()
               CALL g_apba3_d.clear()
               LET l_cmd_t = ''
            END IF
            #150127-00005#1 add end---
            #20150317--add--str--
            IF l_apba_flag = 'Y' THEN 
               LET l_apba_flag = 'N'
               NEXT FIELD apbaseq
            END IF
            #20150317--add--end--        
            #end add-point
            CALL aapt110_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb004
            
            #add-point:AFTER FIELD apbb004 name="input.a.apbb004"
            IF NOT cl_null(g_apbb_m.apbb004) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb004) OR g_apbb_m.apbb004 != g_apbb_m_t.apbb004) OR cl_null(g_apbb_m_t.apbb004))) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbb004 != g_apbb_m_o.apbb004 OR cl_null(g_apbb_m_o.apbb004) THEN  #160726-00020#7
                  CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1') #160808-00033#1
                  CALL s_fin_account_center_chk(g_apbb_m.apbb004,'','3',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbb004 = g_apbb_m_t.apbb004  #160726-00020#7 Mark
                     LET g_apbb_m.apbb004 = g_apbb_m_o.apbb004   #160726-00020#7
                     LET g_apbb_m.apbbcomp = g_apbb_m_o.apbbcomp #160726-00020#7
                     NEXT FIELD CURRENT
                 #ELSE #160808-00033#1 mark
                  END IF #160808-00033#1
                  
                  CALL s_fin_orga_get_comp_ld(g_apbb_m.apbb004) RETURNING g_sub_success,g_errno,g_apbb_m.apbbcomp,g_ld
                  CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
                  DISPLAY BY NAME g_apbb_m.l_apbbcomp_desc
                  CALL s_fin_get_wc_str(g_apbb_m.apbbcomp) RETURNING g_comp_str  #161229-00047#39 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl         #161229-00047#39 add
                  #161111-00042#1 add ------
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbb_m.apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#39 mark 
                  #161111-00042#1 add end---
                  
                  #160808-00033#1-s
                  IF NOT cl_null(g_apbb_m.apbbcomp)THEN
                     CALL s_fin_account_center_with_ld_chk(g_apbb_m.apbb004,g_ld,g_user,'3','Y','',g_today)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apbb_m.apbb004 = g_apbb_m_o.apbb004
                        LET g_apbb_m.apbbcomp = g_apbb_m_o.apbbcomp
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160808-00033#1-e
                     
                  #OK就帶出該帳務中心的法人&帳套&幣別
                  CALL s_fin_orga_get_comp_ld(g_apbb_m.apbb004) RETURNING g_sub_success,g_errno,g_apbb_m.apbbcomp,g_ld
                  CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
                  DISPLAY BY NAME g_apbb_m.l_apbbcomp_desc
                  CALL s_fin_get_wc_str(g_apbb_m.apbbcomp) RETURNING g_comp_str  #161229-00047#39 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl         #161229-00047#39 add 
                  #161111-00042#1 add ------
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apbb_m.apbbcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#39 mark
                  #161111-00042#1 add end---
                  CALL s_ld_sel_glaa(g_ld,'glaa001') RETURNING g_sub_success,g_glaa001
                  LET g_apbb_m.apbb014 = g_glaa001
                  #抓取"發票編碼方式"決定是否隱藏"發票代碼"
                  CALL aapt110_set_entry_invoice_code()
                  #抓取匯率
                  IF NOT cl_null(g_apbb_m.apbb011) AND NOT cl_null(g_apbb_m.apbb002) THEN
                     #151012-00014#2-----s
                     LET lc_param.apca004 = g_apbb_m.apbb002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,ls_js)
                     #CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,'S-BAS-0014')
                          RETURNING g_apbb_m.apbb015,l_exchange2,l_exchange3
                     #151012-00014#2-----e
                     #若匯率=1表示原幣=本幣，關閉本幣欄位
                     CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
                  END IF
                  DISPLAY BY NAME g_apbb_m.apbb014,g_apbb_m.apbb015
                  CALL s_fin_account_center_with_ld_chk(g_apbb_m.apbb004,g_ld,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno   
                  IF NOT g_sub_success THEN
                     #LET g_apbb_m.apbbcomp = '' #160726-00020#7 Mark
                     LET g_apbb_m.apbbcomp = g_apbb_m_o.apbbcomp  #160726-00020#7
                  END IF
                  CALL aapt110_set_info()
                 #END IF #160808-00033#1 mark
                  
                  #160705-00035#1 -s
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1')
                  #取得帳務組織底下所屬的法人範圍
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_apbacomp
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_apbaorga
                  #將取回的字串轉換為SQL條件
                  CALL s_fin_get_wc_str(g_wc_apbacomp) RETURNING g_wc_apbacomp
                  CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
                  #160705-00035#1 -e
               END IF
               #160726-00020#11 Mark ---(S)---
               #LET g_apbb_m_o.apbb004 = g_apbb_m.apbb004  #160726-00020#7 
               #LET g_apbb_m_o.apbbcomp = g_apbb_m.apbbcomp  #160726-00020#7
               #160726-00020#11 Mark ---(E)---
            END IF
            CALL s_desc_get_department_desc(g_apbb_m.apbb004) RETURNING g_apbb_m.l_apbb004_desc
            DISPLAY BY NAME g_apbb_m.l_apbb004_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb004
            #add-point:BEFORE FIELD apbb004 name="input.b.apbb004"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb004
            #add-point:ON CHANGE apbb004 name="input.g.apbb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbcomp
            
            #add-point:AFTER FIELD apbbcomp name="input.a.apbbcomp"
            IF NOT cl_null(g_apbb_m.apbbcomp) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbbcomp) OR g_apbb_m.apbbcomp != g_apbb_m_t.apbbcomp) OR cl_null(g_apbb_m_t.apbbcomp))) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbbcomp != g_apbb_m_o.apbbcomp OR  #160726-00020#7
                  cl_null(g_apbb_m_o.apbbcomp) THEN            #160726-00020#7
                  #160705-00035#1 mark ------
                  ##取得帳務組織下所屬成員
                  #CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1')
                  ##取得帳務組織底下所屬的法人範圍
                  #CALL s_fin_account_center_comp_str() RETURNING g_wc_apbaorga
                  ##將取回的字串轉換為SQL條件
                  #CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
                  #160705-00035#1 mark end---
                  
                  #160907-00041#1 --s add
                  CALL s_fin_azzi800_sons_query(g_today)
                  IF NOT cl_null(g_apbb_m.apbb004) THEN 
                     CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
                  END IF 
                  CALL s_fin_account_center_comp_str()RETURNING g_wc_cs_comp
                  CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
                  #160907-00041#1 --e add
                  
                  #比對輸入的法人是否在帳務組織下
                  #IF s_chr_get_index_of(g_wc_apbaorga,g_apbb_m.apbbcomp,'1') = 0 THEN #160907-00041#1 mark
                  IF s_chr_get_index_of(g_wc_cs_comp,g_apbb_m.apbbcomp,'1') = 0 THEN   #160907-00041#1 add
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbbcomp = g_apbb_m_t.apbbcomp  #160726-00020#7 Mark
                     LET g_apbb_m.apbbcomp = g_apbb_m_o.apbbcomp   #160726-00020#7 
                     #160907-00041#1 --s add
                     CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
                     DISPLAY BY NAME g_apbb_m.l_apbbcomp_desc
                     #160907-00041#1 --e add
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160907-00041#1 --s add
                  #檢核法人是否有azzi800權限
                  LET l_cnt_comp = 0                     
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                              "   AND ooef001 = '",g_apbb_m.apbbcomp,"' ",
                              "   AND ooef001 IN ",g_wc_cs_comp CLIPPED
                  PREPARE sel_cnt_comp FROM l_sql
                  EXECUTE sel_cnt_comp INTO l_cnt_comp
                     
                  IF cl_null(l_cnt_comp)THEN LET l_cnt_comp = 0 END IF
                  IF l_cnt_comp = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00228'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()        
                     LET g_apbb_m.apbbcomp = g_apbb_m_o.apbbcomp 
                     CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
                     DISPLAY BY NAME g_apbb_m.l_apbbcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160907-00041#1 --e add
                  
                  #抓取購貨方訊息
                  CALL aapt110_buy_info(g_apbb_m.apbbcomp) RETURNING g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,
                                                                     g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021
                  DISPLAY BY NAME g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc,g_apbb_m.apbb016,
                                  g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,
                                  g_apbb_m.apbb020,g_apbb_m.apbb021
                  #抓取"發票編碼方式"決定是否隱藏"發票代碼"
                  CALL aapt110_set_entry_invoice_code()
                  #重抓帳套
                  CALL aapt110_set_info()
                  LET g_apbb_m.apbb014 = g_glaa001
                  #抓取匯率
                  IF NOT cl_null(g_apbb_m.apbb011) AND cl_null(g_apbb_m.apbb002) THEN
                     #151012-00014#2-----s
                     LET lc_param.apca004 = g_apbb_m.apbb002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,ls_js)
                     #CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,'S-BAS-0014')
                          RETURNING g_apbb_m.apbb015,l_exchange2,l_exchange3
                     #151012-00014#2-----e
                     #若匯率=1表示原幣=本幣，關閉本幣欄位
                     CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
                  END IF
                  DISPLAY BY NAME g_apbb_m.apbb014,g_apbb_m.apbb015
               END IF
               #LET g_apbb_m_o.apbbcomp = g_apbb_m.apbbcomp  #160726-00020#7 #160726-00020#11 Mark
            END IF
            CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
            DISPLAY BY NAME g_apbb_m.l_apbbcomp_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbcomp
            #add-point:BEFORE FIELD apbbcomp name="input.b.apbbcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbbcomp
            #add-point:ON CHANGE apbbcomp name="input.g.apbbcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb053
            
            #add-point:AFTER FIELD apbb053 name="input.a.apbb053"
            LET g_apbb_m.l_apbb053_desc = ' '
            IF NOT cl_null(g_apbb_m.apbb053) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apbb_m.apbb053 != g_apbb_m_t.apbb053 OR g_apbb_m_t.apbb053 IS NULL )) THEN
                  CALL s_employee_chk(g_apbb_m.apbb053) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apbb_m.apbb053 = g_apbb_m_t.apbb053
                     CALL s_desc_get_person_desc(g_apbb_m.apbb053) RETURNING g_apbb_m.l_apbb053_desc
                     DISPLAY BY NAME g_apbb_m.l_apbb053_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apbb_m.apbb053) RETURNING g_apbb_m.l_apbb053_desc
            DISPLAY BY NAME g_apbb_m.l_apbb053_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb053
            #add-point:BEFORE FIELD apbb053 name="input.b.apbb053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb053
            #add-point:ON CHANGE apbb053 name="input.g.apbb053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbdocno
            
            #add-point:AFTER FIELD apbbdocno name="input.a.apbbdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_apbb_m.apbbdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apbb_t WHERE "||"apbbent = '" ||g_enterprise|| "' AND "||"apbbdocno = '"||g_apbb_m.apbbdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_apbb_m.apbbdocno) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbbdocno) OR g_apbb_m.apbbdocno != g_apbbdocno_t) OR cl_null(g_apbbdocno_t))) THEN
                  #以帳別去取所屬法人,以法人勾稽單別是否在單別參照表
#141204-00017#1 mark                  
#                  CALL s_fin_slip_chk(g_apbb_m.apbbdocno,g_prog,g_ld,g_fin_arg1) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_apbb_m.apbbdocno = g_apbbdocno_t
#                     #CALL s_aooi200_get_slip_desc(g_apbb_m.apbbdocno) RETURNING g_apbb_m.apbbdocno_desc
#                     #DISPLAY BY NAME g_apbb_m.apbbdocno_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  IF NOT s_aooi200_fin_chk_docno(g_ld,'','',g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_prog) THEN
                     LET g_apbb_m.apbbdocno = g_apbbdocno_t
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#4 --s add
                  CALL s_control_chk_doc('1',g_apbb_m.apbbdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
                  IF g_sub_success AND l_flag1 THEN             
                  ELSE
                     LET g_apbb_m.apbbdocno = g_apbbdocno_t
                     NEXT FIELD CURRENT      
                  END IF
                  CALL s_aooi200_fin_get_slip(g_apbb_m.apbbdocno) RETURNING g_sub_success,g_ap_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_apbb_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_apbb_m.apbbcomp,'2',g_ap_slip,'','',g_ld)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_apbb_m.* FROM s_aooi200def1               
                  #161104-00046#4 --e add                    
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apbb_m.apbbdocno) RETURNING g_apbb_m.l_apbbdocno_desc
            DISPLAY BY NAME g_apbb_m.l_apbbdocno_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11 
            #      #抓取單據別參照表號
            #      SELECT ooef004 INTO l_ooef004
            #        FROM ooef_t
            #       WHERE ooefent = g_enterprise
            #         AND ooef001 = g_apbb_m.apbbcomp
            #      IF NOT s_aooi200_chk_slip(g_apbb_m.apbbcomp,l_ooef004,g_apbb_m.apbbdocno,g_prog) THEN
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbdocno
            #add-point:BEFORE FIELD apbbdocno name="input.b.apbbdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbbdocno
            #add-point:ON CHANGE apbbdocno name="input.g.apbbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbdocdt
            #add-point:BEFORE FIELD apbbdocdt name="input.b.apbbdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbdocdt
            
            #add-point:AFTER FIELD apbbdocdt name="input.a.apbbdocdt"
            #140806-00012#7
            IF NOT cl_null(g_apbb_m.apbbdocdt) THEN
               IF NOT cl_null(g_sfin3007) THEN
                  IF g_apbb_m.apbbdocdt <= g_sfin3007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00110'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apbb_m.apbbdocdt= g_apbb_m_t.apbbdocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbbdocdt
            #add-point:ON CHANGE apbbdocdt name="input.g.apbbdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb002
            
            #add-point:AFTER FIELD apbb002 name="input.a.apbb002"
            IF NOT cl_null(g_apbb_m.apbb002) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb002) OR g_apbb_m.apbb002 != g_apbb_m_t.apbb002) OR cl_null(g_apbb_m_t.apbb002))) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbb002 != g_apbb_m_o.apbb002 OR  #160726-00020#7
                  cl_null(g_apbb_m_o.apbb002) THEN           #160726-00020#7
                  CALL s_aap_apca004_chk(g_apbb_m.apbb002) RETURNING g_sub_success, g_errno
                  IF NOT g_sub_success THEN
                     LET g_apbb_m.apbb002 = ''  #160726-00020#11
                     LET g_apbb_m.apbb030 = ''  #160726-00020#11
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     #160321-00016#20 --e add 
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbb002 = g_apbb_m_t.apbb002  #160726-00020#7 Mark
                     LET g_apbb_m.apbb002 = g_apbb_m_o.apbb002  #160726-00020#7
                     LET g_apbb_m.apbb030 = g_apbb_m_o.apbb030  #160726-00020#7
                     DISPLAY BY NAME g_apbb_m.apbb030 #160726-00020#7
                     NEXT FIELD CURRENT
                  END IF
                  LET g_apbb_m.l_apbb030_2 = g_apbb_m.apbb030
                  CALL s_desc_get_trading_partner_abbr_desc(g_apbb_m.apbb002) RETURNING g_apbb_m.apbb029
                  #抓取開票人信息之銷貨方信息 #150318-00010#1 add部門
                  CALL aapt110_sale_info(g_apbb_m.apbbcomp,g_apbb_m.apbb002,g_apbb_m.apbbdocdt)
                       RETURNING g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,
                                 g_apbb_m.apbb030,g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb0121,g_apbb_m.apbb013,
                                 g_apbb_m.apbb054,g_apbb_m.apbb055,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb008  #141218-00011#1 add apbb055   #161031-00042#1 add apbb008
                  #161102-00055#1-add(s)
                  #紅字發票與藍字發票是否共用發票簿
                  #161230-00036#1 mark ------
                  #SELECT isai006 INTO g_isai006
                  #  FROM ooef_t
                  #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_apbb_m.apbbcomp
                  #161230-00036#1 mark end---
                  IF g_isai006 = "Y" THEN #有共用發票簿
                        CALL aapt110_apbb008_chk('3') RETURNING l_success
                        IF l_success = FALSE THEN
                           LET g_apbb_m.apbb008 = ''
                           LET g_apbb_m.l_apbb008_desc = ''
                        END IF 
                  ELSE
                     IF g_apbb_m.apbb050='2' THEN #紅字發票
                        CALL aapt110_apbb008_chk('4') RETURNING l_success
                        IF l_success = FALSE THEN
                           LET g_apbb_m.apbb008 = ''
                           LET g_apbb_m.l_apbb008_desc = ''
                        END IF 
                     ELSE
                        CALL aapt110_apbb008_chk('1') RETURNING l_success
                        IF l_success = FALSE THEN
                           LET g_apbb_m.apbb008 = ''
                           LET g_apbb_m.l_apbb008_desc = ''
                        END IF 
                     END IF
                  END IF
                  #161110-00026#1--add--start--
                  IF NOT cl_null(g_apbb_m.apbb008) THEN
                     CALL aapt110_change_type(g_apbb_m.apbbcomp,g_apbb_m.apbb008) RETURNING g_apbb_m.apbb036
                     DISPLAY BY NAME g_apbb_m.apbb036
                  END IF 
                  #161110-00026#1--add--end----
                  #161102-00055#1-add(e)
                  CALL s_desc_get_ooib002_desc(g_apbb_m.apbb054) RETURNING g_apbb_m.l_apbb054_desc
                  CALL s_desc_get_person_desc(g_apbb_m.apbb051) RETURNING g_apbb_m.l_apbb051_desc
                  CALL s_desc_get_department_desc(g_apbb_m.apbb052) RETURNING g_apbb_m.l_apbb052_desc #150318-00010#1
                  #抓匯率
                  IF NOT cl_null(g_apbb_m.apbb014) AND NOT cl_null(g_apbb_m.apbb002) THEN
                     #151012-00014#2-----s
                     LET lc_param.apca004 = g_apbb_m.apbb002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,ls_js)
                     #CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,'S-BAS-0014')
                          RETURNING g_apbb_m.apbb015,l_exchange2,l_exchange3
                     #151012-00014#2-----e
                     DISPLAY BY NAME g_apbb_m.apbb015
                  END IF
                  CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
                  #150318-00010#1 mark
                  ##用人員去取得部門
                  #CALL s_employee_get_dept(g_apbb_m.apbb051) RETURNING g_sub_success,g_errno,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc
                  DISPLAY BY NAME g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,
                                  g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb0121,g_apbb_m.apbb013,
                                  g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc
                         
                  
                  #161206-00042#5-----s
                  LET l_pmaa004 = NULL                  
                  SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_apbb_m.apbb002
                  IF l_pmaa004 = '2' THEN   #一次性交易對象
                     IF g_apbb_m.apbb003 MATCHES '[89]' THEN
                        CALL apmi004_01('1',g_apbb_m.apbb059,g_apbb_m.apbb002,g_apbb_m.apbbdocno) RETURNING g_apbb_m.apbb059
                     ELSE
                        INITIALIZE g_qryparam.* TO NULL
                        LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE
                        LET g_qryparam.default1 =  g_apbb_m.apbb059
                        LET g_qryparam.arg1 =  g_apbb_m.apbb002
                        CALL q_pmak002()
                        LET g_apbb_m.apbb059 = g_qryparam.return1                
                     END IF
                  END IF
                  IF l_pmaa004 = '4' THEN   #內部員工
                     CALL apmi004_01('2',g_apbb_m.apbb059,g_apbb_m.apbb002,g_apbb_m.apbbdocno) RETURNING g_apbb_m.apbb059
                  END IF          
                  
                  IF l_pmaa004 = '2' THEN
                     SELECT pmak003,pmak004,pmak010,pmak009,pmak005
                       INTO g_apbb_m.apbb029,g_apbb_m.apbb030,g_apbb_m.apbb033,
                            g_apbb_m.apbb034,g_apbb_m.apbb031
                       FROM pmak_t
                      WHERE pmakent = g_enterprise
                        AND pmak001 = g_apbb_m.apbb059
                      LET g_apbb_m.l_apbb030_2 = g_apbb_m.apbb030
                      DISPLAY BY NAME g_apbb_m.apbb029,g_apbb_m.apbb030,g_apbb_m.apbb033,
                                      g_apbb_m.apbb034,g_apbb_m.apbb031, g_apbb_m.l_apbb030_2                      
                  END IF                  
                  #161206-00042#5-----e
               END IF
               #LET g_apbb_m_o.apbb002 = g_apbb_m.apbb002  #160726-00020#7 #160726-00020#11 Mart
               #LET g_apbb_m_o.apbb030 = g_apbb_m.apbb030  #160726-00020#7 #160726-00020#11 Mart
            END IF
            #160802-00007#5-----s
            IF cl_null(g_apbb_m.apbb002) THEN
               LET g_apbb_m.apbb059 = ''
            END IF
            #160802-00007#5-----e
            CALL s_desc_get_trading_partner_abbr_desc(g_apbb_m.apbb002) RETURNING g_apbb_m.l_apbb002_desc
            #160802-00007#5-----s
            IF NOT cl_null(g_apbb_m.apbb059) THEN
               CALL s_axrt300_xrca_ref('xrca057',g_apbb_m.apbb059,'','') RETURNING g_sub_success,g_apbb_m.l_apbb002_desc
            END IF
            #160802-00007#5-----e
            DISPLAY BY NAME g_apbb_m.l_apbb002_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb002
            #add-point:BEFORE FIELD apbb002 name="input.b.apbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb002
            #add-point:ON CHANGE apbb002 name="input.g.apbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb059
            #add-point:BEFORE FIELD apbb059 name="input.b.apbb059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb059
            
            #add-point:AFTER FIELD apbb059 name="input.a.apbb059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb059
            #add-point:ON CHANGE apbb059 name="input.g.apbb059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb003
            #add-point:BEFORE FIELD apbb003 name="input.b.apbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb003
            
            #add-point:AFTER FIELD apbb003 name="input.a.apbb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb003
            #add-point:ON CHANGE apbb003 name="input.g.apbb003"
            #160705-00035#1 add ------
            CASE g_apbb_m.apbb003
               WHEN '2'  #2:進貨發票立帳
                  LET g_apbb_m.apbb050 = '1'
                  CALL cl_set_combo_scc_part('apba004','8541','11,12,13,16,19,20,21,23,26,27,29')
               WHEN '5'  #5:發票扣抵單立帳
                  LET g_apbb_m.apbb050 = '2'
                  CALL cl_set_combo_scc_part('apba004','8541','12,20,21,23,26,29')
               WHEN '7'  #7:預付發票立帳
                  LET g_apbb_m.apbb050 = '1'
                  CALL cl_set_combo_scc_part('apba004','8541','10,19,29')
               WHEN '8'  #8:雜項發票立帳
                  LET g_apbb_m.apbb050 = '1'
                  CALL cl_set_combo_scc_part('apba004','8541','12,13,16,19,23,26,27,29')
               WHEN '9'  #9:雜項待抵立帳
                  LET g_apbb_m.apbb050 = '2'
                  CALL cl_set_combo_scc_part('apba004','8541','23,26,27,29')
            END CASE
            DISPLAY BY NAME g_apbb_m.apbb050
            #160705-00035#1 add end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb050
            #add-point:BEFORE FIELD apbb050 name="input.b.apbb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb050
            
            #add-point:AFTER FIELD apbb050 name="input.a.apbb050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb050
            #add-point:ON CHANGE apbb050 name="input.g.apbb050"
            #發票性質apbb050='2.紅字發票'才開放扣抵藍字發票欄位
            IF g_apbb_m.apbb050 = 2 THEN
               CALL cl_set_comp_visible("apba016,apba017",TRUE)
               CALL cl_set_combo_scc_part('apba004','8541','12,20,21,23,26,29') #來源作業 #150318-00010#1 take out27  #20150601 add 12,23 lujh
            ELSE
               CALL cl_set_comp_visible("apba016,apba017",FALSE)
               CALL cl_set_combo_scc_part('apba004','8541','11,12,13,16,19,20,21,23,26,27,29') #來源作業
               #150318-00010#1 take out17/27
               #20150601 add 12,13,23 lujh
               #150622-00007#1 開放27
            END IF
            #抓取"發票編碼方式"決定是否隱藏"發票代碼"
            CALL aapt110_set_entry_invoice_code()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb009
            #add-point:BEFORE FIELD apbb009 name="input.b.apbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb009
            
            #add-point:AFTER FIELD apbb009 name="input.a.apbb009"
            IF NOT cl_null(g_apbb_m.apbb009) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb009) OR g_apbb_m.apbb009 != g_apbb_m_t.apbb009) OR cl_null(g_apbb_m_t.apbb009))) THEN
                  IF NOT cl_null(g_apbb_m.apbb010) THEN
                     #檢核發票是否重複
                     #160107-00004#1 add apbbcomp,apbb002
                     CALL aapt110_invoice_repeat_chk(g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbb008,g_apbb_m.apbb011,g_apbb_m.apbbdocno,0,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apbb_m.apbb010 = g_apbb_m_t.apbb010
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb009
            #add-point:ON CHANGE apbb009 name="input.g.apbb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb010
            #add-point:BEFORE FIELD apbb010 name="input.b.apbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb010
            
            #add-point:AFTER FIELD apbb010 name="input.a.apbb010"
            IF NOT cl_null(g_apbb_m.apbb010) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb010) OR g_apbb_m.apbb010 != g_apbb_m_t.apbb010) OR cl_null(g_apbb_m_t.apbb010))) THEN #160726-00020#11 Mark
               IF g_apbb_m.apbb010 != g_apbb_m_o.apbb010 OR cl_null(g_apbb_m_o.apbb010) THEN #160726-00020#11
                  IF g_apbb_m.apbb010 <> 'MULTI' THEN #輸入單一發票才檢核重複否
                     #160713-00019#1--add--start-- 
                     IF g_isai002 = "1" THEN
                        CALL aapt110_isad005_chk(g_apbb_m.apbb010,g_apbb_m.apbb011) 
                             RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apbb_m.apbb010 = g_apbb_m_t.apbb010 #160726-00020#11 Mark
                           LET g_apbb_m.apbb010 = g_apbb_m_o.apbb010 #160726-00020#11
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #160713-00019#1--add--end---- 
                     #檢核發票是否重複
                     #160107-00004#1 add apbbcomp,apbb002
                     CALL aapt110_invoice_repeat_chk(g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbb008,g_apbb_m.apbb011,g_apbb_m.apbbdocno,0,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apbb_m.apbb010 = g_apbb_m_t.apbb010 #160726-00020#11 Mark
                        LET g_apbb_m.apbb010 = g_apbb_m_o.apbb010 #160726-00020#11
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb010
            #add-point:ON CHANGE apbb010 name="input.g.apbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbbstus
            #add-point:BEFORE FIELD apbbstus name="input.b.apbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbbstus
            
            #add-point:AFTER FIELD apbbstus name="input.a.apbbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbbstus
            #add-point:ON CHANGE apbbstus name="input.g.apbbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb008
            
            #add-point:AFTER FIELD apbb008 name="input.a.apbb008"
            IF NOT cl_null(g_apbb_m.apbb008) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb008) OR g_apbb_m.apbb008 != g_apbb_m_t.apbb008) OR cl_null(g_apbb_m_t.apbb008))) THEN #160726-00020#11 Mark
               IF g_apbb_m.apbb008 != g_apbb_m_o.apbb008 OR cl_null(g_apbb_m_o.apbb008) THEN  #160726-00020#11
                  #161230-00036#1 add ------
                  #媒體申報格式/發票聯數
                  SELECT isac004,isac008 INTO g_isac004,g_isac008
                    FROM isac_t
                   WHERE isacent = g_enterprise
                     AND isac002 = g_apbb_m.apbb008 AND isac001 = g_ooef019
                  #161230-00036#1 add end---
                  #發票類型檢核的chk
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_apbb_m.apbb008
                  #紅字發票與藍字發票是否共用發票簿
                  #161230-00036#1 mark ------
                  #SELECT isai006 INTO g_isai006
                  #  FROM ooef_t
                  #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_apbb_m.apbbcomp
                  #161230-00036#1 mark end---
                  IF g_isai006 = "Y" THEN #有共用發票簿
                     IF NOT cl_chk_exist("v_isac002_3") THEN
                        #LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008 #160726-00020#11 Mark
                        LET g_apbb_m.apbb008 = g_apbb_m_o.apbb008  #160726-00020#11
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF g_apbb_m.apbb050='2' THEN #紅字發票
                        IF NOT cl_chk_exist("v_isac002_4") THEN
                           LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF NOT cl_chk_exist("v_isac002_1") THEN
                           #LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008 #160726-00020#11 Mark
                           LET g_apbb_m.apbb008 = g_apbb_m_o.apbb008  #160726-00020#11
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  IF NOT cl_null(g_apbb_m.apbb010) THEN #170110-00035#1 add
                     #檢核發票是否重複
                     #160107-00004#1 add apbbcomp,apbb002
                     CALL aapt110_invoice_repeat_chk(g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbb008,g_apbb_m.apbb011,g_apbb_m.apbbdocno,0,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008 #160726-00020#11 Mark
                        LET g_apbb_m.apbb008 = g_apbb_m_o.apbb008  #160726-00020#11
                        NEXT FIELD CURRENT
                     END IF
                  END IF #170110-00035#1 add
                  #變動異動狀態
                  CALL aapt110_change_type(g_apbb_m.apbbcomp,g_apbb_m.apbb008) RETURNING g_apbb_m.apbb036
                  DISPLAY BY NAME g_apbb_m.apbb036
                  LET g_apbb_m.apbb030 = '' #161230-00036#1-add
               END IF
            END IF
            CALL s_desc_get_invoice_type_desc(g_ld,g_apbb_m.apbb008) RETURNING g_apbb_m.l_apbb008_desc
            DISPLAY BY NAME g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc
            
            #151105-00001#8 --s
            IF NOT cl_null(g_apbb_m.apbb008) AND NOT cl_null(g_apbb_m.apbbcomp) THEN
               CALL aapt110_inv_visible(g_apbb_m.apbbcomp,g_apbb_m.apbb008)  
            END IF
            #151105-00001#8 --e
            #161230-00036#1-add(s)
            IF g_ooef011 = 'TW' THEN
               #IF g_isac008 NOT MATCHES '[4]' AND NOT cl_null(g_isac004) THEN   #170218-00012#1 mark
               IF g_isac008 NOT MATCHES '[4]' AND NOT cl_null(g_isac004) AND g_isac004 != '28' AND g_isac004 != '29' THEN   #170218-00012#1 add
                  IF NOT cl_null(g_apbb_m.apbb030) THEN               
                     #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                     CALL s_rule_chk_vat_id_string(g_apbb_m.apbb030) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_apbb_m.apbb030 = g_apbb_m_o.apbb030
                        NEXT FIELD apbb030
                     END IF
                     #檢查營利事業統一編號邏輯
                     CALL s_rule_chk_vat_id(g_ooef011,g_apbb_m.apbb030) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_apbb_m.apbb030 = g_apbb_m.apbb030
                     END IF
                  END IF
               END IF
            END IF
            #161230-00036#1-add(e)
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb008
            #add-point:BEFORE FIELD apbb008 name="input.b.apbb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb008
            #add-point:ON CHANGE apbb008 name="input.g.apbb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb011
            #add-point:BEFORE FIELD apbb011 name="input.b.apbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb011
            
            #add-point:AFTER FIELD apbb011 name="input.a.apbb011"
            IF NOT cl_null(g_apbb_m.apbb011) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb011) OR g_apbb_m.apbb011 != g_apbb_m_t.apbb011) OR cl_null(g_apbb_m_t.apbb011))) THEN
                  IF NOT cl_null(g_apbb_m.apbbdocdt) THEN
                     #170217-00032#1 mark--s
                     ##發票日期不可大於錄入日期
                     #IF g_apbb_m.apbb011 > g_apbb_m.apbbdocdt THEN
                     #   INITIALIZE g_errparam TO NULL
                     #   LET g_errparam.code = 'aap-00198'
                     #   LET g_errparam.extend = ''
                     #   LET g_errparam.popup = TRUE
                     #   CALL cl_err()
                     #   LET g_apbb_m.apbb011 = g_apbb_m_t.apbb011
                     #   NEXT FIELD CURRENT
                     #END IF
                     #170217-00032#1 mark--e
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb011
            #add-point:ON CHANGE apbb011 name="input.g.apbb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb030
            #add-point:BEFORE FIELD apbb030 name="input.b.apbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb030
            
            #add-point:AFTER FIELD apbb030 name="input.a.apbb030"
            #161129-00042#1-add(s)
            #161230-00036#1 mark ------
            #LET l_ooef011 = ' '
            #SELECT ooef011 INTO l_ooef011 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_apbb_m.apbbcomp
            #IF l_ooef011 = 'TW' THEN
            #161230-00036#1 mark end---
            #161230-00036#1 add ------
            IF g_apbb_m.apbb030 != g_apbb_m_o.apbb030 OR cl_null(g_apbb_m_o.apbb030) THEN
               IF g_ooef011 = 'TW' THEN
                  #IF g_isac008 NOT MATCHES '[4]'AND NOT cl_null(g_isac004) THEN                                              #170218-00012#1 mark
                  IF g_isac008 NOT MATCHES '[4]'AND NOT cl_null(g_isac004) AND g_isac004 != '28' AND g_isac004 != '29' THEN   #170218-00012#1 add
            #161230-00036#1 add end---
                     IF NOT cl_null(g_apbb_m.apbb030) THEN
                        #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                        CALL s_rule_chk_vat_id_string(g_apbb_m.apbb030) RETURNING l_success
                        IF NOT l_success THEN
                           LET g_apbb_m.apbb030 = g_apbb_m_o.apbb030
                           NEXT FIELD apbb030
                        END IF
                        #檢查營利事業統一編號邏輯
                        #CALL s_rule_chk_vat_id(l_ooef011,g_apbb_m.apbb030) RETURNING l_success #161230-00036#1 mark
                        CALL s_rule_chk_vat_id(g_ooef011,g_apbb_m.apbb030) RETURNING l_success  #161230-00036#1
                        IF NOT l_success THEN
                           LET g_apbb_m.apbb030 = g_apbb_m.apbb030  
                        END IF
                     END IF
                  END IF   #161230-00036#1-add
               END IF
            #161129-00042#1-add(e)
            #161230-00036#1 add ------
            END IF
            LET g_apbb_m_o.* = g_apbb_m.*
            #161230-00036#1 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb030
            #add-point:ON CHANGE apbb030 name="input.g.apbb030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb051
            
            #add-point:AFTER FIELD apbb051 name="input.a.apbb051"
            LET g_apbb_m.l_apbb051_desc = ' '
            IF NOT cl_null(g_apbb_m.apbb051) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apbb_m.apbb051 != g_apbb_m_t.apbb051 OR g_apbb_m_t.apbb051 IS NULL )) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbb051 != g_apbb_m_o.apbb051 OR #160726-00020#7
                  cl_null(g_apbb_m_o.apbb051) THEN          #160726-00020#7
                  CALL s_employee_chk(g_apbb_m.apbb051) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apbb_m.apbb051 = '' #160726-00020#11
                     #LET g_apbb_m.apbb051 = g_apbb_m_t.apbb051  #160726-00020#7 Mark
                     LET g_apbb_m.apbb051 = g_apbb_m_o.apbb051  #160726-00020#7
                     CALL s_desc_get_person_desc(g_apbb_m.apbb051) RETURNING g_apbb_m.l_apbb051_desc
                     DISPLAY BY NAME g_apbb_m.l_apbb051_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #LET g_apbb_m_o.apbb051 = g_apbb_m.apbb051  #160726-00020#7 #160726-00020#11 Mart
            END IF
            CALL s_desc_get_person_desc(g_apbb_m.apbb051) RETURNING g_apbb_m.l_apbb051_desc
            #用人員去取得部門
            CALL s_employee_get_dept(g_apbb_m.apbb051) RETURNING g_sub_success,g_errno,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc
            DISPLAY BY NAME g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb051
            #add-point:BEFORE FIELD apbb051 name="input.b.apbb051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb051
            #add-point:ON CHANGE apbb051 name="input.g.apbb051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb052
            
            #add-point:AFTER FIELD apbb052 name="input.a.apbb052"
            LET g_apbb_m.l_apbb052_desc = ' '
            DISPLAY BY NAME g_apbb_m.l_apbb052_desc
            IF NOT cl_null(g_apbb_m.apbb052) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apbb_m.apbb052 != g_apbb_m_t.apbb052 OR g_apbb_m_t.apbb052 IS NULL )) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbb052 != g_apbb_m_o.apbb052 OR #160726-00020#7
                  cl_null(g_apbb_m_o.apbb052) THEN          #160726-00020#7
                  CALL s_department_chk(g_apbb_m.apbb052,g_today) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apbb_m.apbb052 = ''  #160726-00020#11 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     IF g_errno= 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi125'
                        LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi125'
                        LET g_apbb_m.apbb052 = g_apbb_m_o.apbb052  #160726-00020#7
                     END IF
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbb052 = g_apbb_m_t.apbb052  #160726-00020#7 Mark
                     LET g_apbb_m.apbb052 = g_apbb_m_o.apbb052  #160726-00020#7
                     CALL s_desc_get_department_desc(g_apbb_m.apbb052) RETURNING g_apbb_m.l_apbb052_desc
                     DISPLAY BY NAME g_apbb_m.l_apbb052_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #LET g_apbb_m_o.apbb052 = g_apbb_m.apbb052  #160726-00020#7 #160726-00020#11 Mart
            END IF
            CALL s_desc_get_department_desc(g_apbb_m.apbb052) RETURNING g_apbb_m.l_apbb052_desc
            DISPLAY BY NAME g_apbb_m.l_apbb052_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb052
            #add-point:BEFORE FIELD apbb052 name="input.b.apbb052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb052
            #add-point:ON CHANGE apbb052 name="input.g.apbb052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb054
            
            #add-point:AFTER FIELD apbb054 name="input.a.apbb054"
            #付款條件
            LET g_apbb_m.l_apbb054_desc = ' '
            IF NOT cl_null(g_apbb_m.apbb054) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb054) OR g_apbb_m.apbb054 != g_apbb_m_t.apbb054) OR cl_null(g_apbb_m_t.apbb054))) THEN #160726-00020#7 Mark
               IF g_apbb_m.apbb054 != g_apbb_m_o.apbb054 OR  #160726-00020#7
                  cl_null(g_apbb_m_o.apbb054) THEN           #160726-00020#7
                  CALL s_aap_ooib002_chk(g_apbb_m.apbb054,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_apbb_m.apbb054 = ''      #160726-00020#11
                     LET g_apbb_m.l_apbb054_desc = '' #160726-00020#11
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'aooi716'
                        LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi716'
                     END IF
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbb054 = g_apbb_m_t.apbb054  #160726-00020#7 Mark
                     LET g_apbb_m.apbb054 = g_apbb_m_o.apbb054   #160726-00020#7
                     CALL s_desc_get_ooib002_desc(g_apbb_m.apbb054) RETURNING g_apbb_m.l_apbb054_desc
                     DISPLAY BY NAME g_apbb_m.l_apbb054_desc
                     NEXT FIELD CURRENT
                  END IF
                  #141218-00011#1---------------
                  #应付款日/应付票据到期日计算
                  CALL s_fin_date_ap_payable(g_apbb_m.apbbcomp,g_apbb_m.apbb002,g_apbb_m.apbb054,g_apbb_m.apbbdocdt,g_apbb_m.apbbdocdt,g_apbb_m.apbbdocdt,g_apbb_m.apbbdocdt)
                       #RETURNING g_sub_success,l_date,g_apbb_m.apbb055   #160929-00048#1 mark(調整#160910-00007#1)
                       RETURNING g_sub_success,g_apbb_m.apbb055,l_date    #160929-00048#1 add(調整#160910-00007#1)
                  #141218-00011#1 END-----------
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_apbb_m.apbb054) RETURNING g_apbb_m.l_apbb054_desc
            DISPLAY BY NAME g_apbb_m.l_apbb054_desc
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb054
            #add-point:BEFORE FIELD apbb054 name="input.b.apbb054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb054
            #add-point:ON CHANGE apbb054 name="input.g.apbb054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb012
            
            #add-point:AFTER FIELD apbb012 name="input.a.apbb012"
            IF NOT cl_null(g_apbb_m.apbb012) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb012) OR g_apbb_m.apbb012 != g_apbb_m_t.apbb012) OR cl_null(g_apbb_m_t.apbb012))) THEN #160726-00020#11 Mark
               IF g_apbb_m.apbb012 != g_apbb_m_o.apbb012 OR cl_null(g_apbb_m_o.apbb012) THEN #160726-00020#11
                  #抓取含稅否&稅率
                  CALL s_tax_chk(g_apbb_m.apbbcomp,g_apbb_m.apbb012) RETURNING g_sub_success,g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121,g_apbb_m.apbb013,l_oodb011
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00164'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apbb_m.apbb012 = g_apbb_m_t.apbb012  #160726-00020#11 Mark
                     LET g_apbb_m.apbb012 = g_apbb_m_o.apbb012   #160726-00020#11
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
               END IF
            END IF
            CALL s_desc_get_tax_desc(g_ooef019,g_apbb_m.apbb012) RETURNING g_apbb_m.l_apbb012_desc
            DISPLAY BY NAME g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121,g_apbb_m.apbb013
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb012
            #add-point:BEFORE FIELD apbb012 name="input.b.apbb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb012
            #add-point:ON CHANGE apbb012 name="input.g.apbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb0121
            #add-point:BEFORE FIELD apbb0121 name="input.b.apbb0121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb0121
            
            #add-point:AFTER FIELD apbb0121 name="input.a.apbb0121"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb0121
            #add-point:ON CHANGE apbb0121 name="input.g.apbb0121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb013
            #add-point:BEFORE FIELD apbb013 name="input.b.apbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb013
            
            #add-point:AFTER FIELD apbb013 name="input.a.apbb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb013
            #add-point:ON CHANGE apbb013 name="input.g.apbb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb037
            #add-point:BEFORE FIELD apbb037 name="input.b.apbb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb037
            
            #add-point:AFTER FIELD apbb037 name="input.a.apbb037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb037
            #add-point:ON CHANGE apbb037 name="input.g.apbb037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb036
            #add-point:BEFORE FIELD apbb036 name="input.b.apbb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb036
            
            #add-point:AFTER FIELD apbb036 name="input.a.apbb036"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb036
            #add-point:ON CHANGE apbb036 name="input.g.apbb036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb200
            #add-point:BEFORE FIELD apbb200 name="input.b.apbb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb200
            
            #add-point:AFTER FIELD apbb200 name="input.a.apbb200"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb200
            #add-point:ON CHANGE apbb200 name="input.g.apbb200"
            IF g_apbb_m.apbb200 = "N" THEN
               CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",FALSE)
            ELSE
               CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb055
            #add-point:BEFORE FIELD apbb055 name="input.b.apbb055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb055
            
            #add-point:AFTER FIELD apbb055 name="input.a.apbb055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb055
            #add-point:ON CHANGE apbb055 name="input.g.apbb055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb056
            #add-point:BEFORE FIELD apbb056 name="input.b.apbb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb056
            
            #add-point:AFTER FIELD apbb056 name="input.a.apbb056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb056
            #add-point:ON CHANGE apbb056 name="input.g.apbb056"
            IF g_apbb_m.apbb056 = 'Y' THEN  
               CALL cl_set_comp_required('apbb009,apbb010',TRUE)
            ELSE
               CALL cl_set_comp_required('apbb009,apbb010',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb014
            #add-point:BEFORE FIELD apbb014 name="input.b.apbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb014
            
            #add-point:AFTER FIELD apbb014 name="input.a.apbb014"
            #幣別
            IF NOT cl_null(g_apbb_m.apbb014) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb014) OR g_apbb_m.apbb014 != g_apbb_m_t.apbb014) OR cl_null(g_apbb_m_t.apbb014))) THEN #160726-00020#11 Mark
               IF g_apbb_m.apbb014 != g_apbb_m_o.apbb014 OR cl_null(g_apbb_m_o.apbb014) THEN  #160726-00020#11
                  CALL s_aap_ooaj001_chk(g_ld,g_apbb_m.apbb014) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apbb_m.apbb014 = g_apbb_m_t.apbb014 #160726-00020#11 Mark
                     LET g_apbb_m.apbb014 = g_apbb_m_o.apbb014 #160726-00020#11
                     NEXT FIELD CURRENT
                  END IF
                  #抓取匯率
                  IF NOT cl_null(g_apbb_m.apbb011) AND NOT cl_null(g_apbb_m.apbb002) THEN
                     #151012-00014#2-----s
                     LET lc_param.apca004 = g_apbb_m.apbb002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,ls_js)
                     #CALL s_fin_get_curr_rate(g_apbb_m.apbbcomp,g_ld,g_apbb_m.apbb011,g_apbb_m.apbb014,'S-BAS-0014')
                          RETURNING g_apbb_m.apbb015,l_exchange2,l_exchange3
                     #151012-00014#2-----e
                     #若匯率=1表示原幣=本幣，關閉本幣欄位
                     CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
                     DISPLAY BY NAME g_apbb_m.apbb015
                  END IF
               END IF
            END IF
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb014
            #add-point:ON CHANGE apbb014 name="input.g.apbb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb023
            #add-point:BEFORE FIELD apbb023 name="input.b.apbb023"
            CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb023
            
            #add-point:AFTER FIELD apbb023 name="input.a.apbb023"
            #原幣未稅金額
            IF NOT cl_null(g_apbb_m.apbb023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb023) OR g_apbb_m.apbb023 != g_apbb_m_t.apbb023) OR cl_null(g_apbb_m_t.apbb023))) THEN
                  IF g_apbb_m.apbb0121 = 'N' THEN
                     CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apbb_m.apbb023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                          RETURNING g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,
                                    g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
                  ELSE
                     #150422-00026#1 add ---
                     LET g_apbb_m.apbb024 = g_apbb_m.apbb025 - g_apbb_m.apbb023
                     
                     IF g_apbb_m.apbb015 = 1 THEN
                        LET g_apbb_m.apbb026 = g_apbb_m.apbb023
                        LET g_apbb_m.apbb027 = g_apbb_m.apbb024
                     ELSE
                        LET g_apbb_m.apbb026 = g_apbb_m.apbb023 * g_apbb_m.apbb015
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                        LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                     END IF
                     #150422-00026#1 end ---
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb023
            #add-point:ON CHANGE apbb023 name="input.g.apbb023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb024
            #add-point:BEFORE FIELD apbb024 name="input.b.apbb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb024
            
            #add-point:AFTER FIELD apbb024 name="input.a.apbb024"
            #原幣稅額
            IF NOT cl_null(g_apbb_m.apbb024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb024) OR g_apbb_m.apbb024 != g_apbb_m_t.apbb024) OR cl_null(g_apbb_m_t.apbb024))) THEN
                  #檢核容差率
                  IF g_apbb_m.apbb023<>0 AND g_apbb_m.apbb024<>0 AND g_apbb_m.apbb025<>0 THEN
                     CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025)
                          RETURNING g_sub_success,g_errno,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025
                     #容差率OK否
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apbb_m.apbb024 = g_apbb_m_t.apbb024
                        NEXT FIELD CURRENT
                     ELSE
                        ##容差率OK更新原幣金額
                        #IF g_apbb_m.apbb0121 = "Y" THEN
                        #   LET g_apbb_m.apbb025 = g_apbb_m.apbb023 + g_apbb_m.apbb024
                        #ELSE
                        #   LET g_apbb_m.apbb023 = g_apbb_m.apbb024 - g_apbb_m.apbb024
                        #END IF
                        #容差率OK更新本幣金額
                        IF g_apbb_m.apbb015 = 1 THEN
                           LET g_apbb_m.apbb026 = g_apbb_m.apbb023
                           LET g_apbb_m.apbb027 = g_apbb_m.apbb024
                           LET g_apbb_m.apbb028 = g_apbb_m.apbb025
                        ELSE
                           IF g_apbb_m.apbb0121 = "Y" THEN
                              #150422-00026#1 add ---
                              LET g_apbb_m.apbb027 = g_apbb_m.apbb024 * g_apbb_m.apbb015
                              CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb027,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb027
                              LET g_apbb_m.apbb026 = g_apbb_m.apbb028 - g_apbb_m.apbb027
                              #150422-00026#1 end ---
   
                              #LET g_apbb_m.apbb028 = g_apbb_m.apbb025 * g_apbb_m.apbb015
                              #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                              #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                              #LET g_apbb_m.apbb026 = g_apbb_m.apbb028 / (1+(g_apbb_m.apbb013/100))
                              #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                              ##稅額=含稅-未稅
                              #LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                           ELSE
                              #150422-00026#1 add ---
                              LET g_apbb_m.apbb027 = g_apbb_m.apbb024 * g_apbb_m.apbb015
                              CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb027,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb027
                              LET g_apbb_m.apbb028 = g_apbb_m.apbb026 + g_apbb_m.apbb027
                              #150422-00026#1 end ---
                              
                              #LET g_apbb_m.apbb026 = g_apbb_m.apbb023 * g_apbb_m.apbb015
                              #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                              #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                              #LET g_apbb_m.apbb028 = g_apbb_m.apbb026 * (1+(g_apbb_m.apbb013/100))
                              #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                              ##稅額=含稅-未稅
                              #LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb024
            #add-point:ON CHANGE apbb024 name="input.g.apbb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb025
            #add-point:BEFORE FIELD apbb025 name="input.b.apbb025"
            CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb025
            
            #add-point:AFTER FIELD apbb025 name="input.a.apbb025"
            #原幣含稅金額
            IF NOT cl_null(g_apbb_m.apbb025) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb025) OR g_apbb_m.apbb025 != g_apbb_m_t.apbb025) OR cl_null(g_apbb_m_t.apbb025))) THEN
                  IF g_apbb_m.apbb0121 = 'Y' THEN
                     CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apbb_m.apbb025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                          RETURNING g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,
                                    g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
                  ELSE
                     #150422-00026#1 add ---
                     LET g_apbb_m.apbb024 = g_apbb_m.apbb025 - g_apbb_m.apbb023
                     IF g_apbb_m.apbb015 = 1 THEN
                        LET g_apbb_m.apbb028 = g_apbb_m.apbb025
                        LET g_apbb_m.apbb027 = g_apbb_m.apbb024
                     ELSE
                        LET g_apbb_m.apbb028 = g_apbb_m.apbb025 * g_apbb_m.apbb015
                        CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                        LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                     END IF
                     #150422-00026#1 end ---
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb025
            #add-point:ON CHANGE apbb025 name="input.g.apbb025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb015
            #add-point:BEFORE FIELD apbb015 name="input.b.apbb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb015
            
            #add-point:AFTER FIELD apbb015 name="input.a.apbb015"
            #本幣匯率
            IF NOT cl_null(g_apbb_m.apbb015) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb015) OR g_apbb_m.apbb015 != g_apbb_m_t.apbb015) OR cl_null(g_apbb_m_t.apbb015))) THEN
                  CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
                  #IF g_apbb_m.apbb0121 = "Y" THEN
                  #   #重算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apbb_m.apbb025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #        RETURNING g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025
                  #                 ,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
                  #ELSE
                  #   #重算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apbb_m.apbb023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #        RETURNING g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025
                  #                 ,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
                  #END IF
                  
                  #IF g_apbb_m.apbb0121 = "Y" THEN
                     CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb023*g_apbb_m.apbb015,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                     CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb024*g_apbb_m.apbb015,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb027
                     CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb025*g_apbb_m.apbb015,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                  #ELSE
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb024*g_apbb_m.apbb015,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb027
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb025*g_apbb_m.apbb015,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                  #END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb015
            #add-point:ON CHANGE apbb015 name="input.g.apbb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb026
            #add-point:BEFORE FIELD apbb026 name="input.b.apbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb026
            
            #add-point:AFTER FIELD apbb026 name="input.a.apbb026"
            #本幣未稅金額
            IF NOT cl_null(g_apbb_m.apbb026) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb026) OR g_apbb_m.apbb026 != g_apbb_m_t.apbb026) OR cl_null(g_apbb_m_t.apbb026))) THEN
                  #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
                  #LET g_apbb_m.apbb026 = g_apbb_m.apbb023 * g_apbb_m.apbb015
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                  #
                  #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                  #LET g_apbb_m.apbb028 = g_apbb_m.apbb026 * (1+(g_apbb_m.apbb013/100))
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                  #
                  ##稅額=含稅-未稅
                  #LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                  
                  #150422-00026#1 add ---
                  #未稅=含稅-稅額
                  LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                  #150422-00026#1 end ---
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb026
            #add-point:ON CHANGE apbb026 name="input.g.apbb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb027
            #add-point:BEFORE FIELD apbb027 name="input.b.apbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb027
            
            #add-point:AFTER FIELD apbb027 name="input.a.apbb027"
            #本幣稅額
            IF NOT cl_null(g_apbb_m.apbb027) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb027) OR g_apbb_m.apbb027 != g_apbb_m_t.apbb027) OR cl_null(g_apbb_m_t.apbb027))) THEN  #160726-00020#11 Mark
               IF g_apbb_m.apbb027 != g_apbb_m_o.apbb027 OR cl_null(g_apbb_m_o.apbb027) THEN #160726-00020#11
                  #檢核容差率
                  IF g_apbb_m.apbb026<>0 AND g_apbb_m.apbb027<>0 AND g_apbb_m.apbb028<>0 THEN
                     CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028)
                          RETURNING g_sub_success,g_errno,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
                     #容差率OK否
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apbb_m.apbb027 = g_apbb_m_t.apbb027 #160726-00020#11 Mark
                        LET g_apbb_m.apbb027 = g_apbb_m_o.apbb027  #160726-00020#11
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_apbb_m_o.* = g_apbb_m.*  #160726-00020#11 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb027
            #add-point:ON CHANGE apbb027 name="input.g.apbb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb028
            #add-point:BEFORE FIELD apbb028 name="input.b.apbb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb028
            
            #add-point:AFTER FIELD apbb028 name="input.a.apbb028"
            #本幣含稅金額
            IF NOT cl_null(g_apbb_m.apbb028) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apbb_m.apbb028) OR g_apbb_m.apbb028 != g_apbb_m_t.apbb028) OR cl_null(g_apbb_m_t.apbb028))) THEN
                  #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
                  #LET g_apbb_m.apbb028 = g_apbb_m.apbb025 * g_apbb_m.apbb015
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
                  #
                  #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                  #LET g_apbb_m.apbb026 = g_apbb_m.apbb028 / (1+(g_apbb_m.apbb013/100))
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
                  #
                  ##稅額=含稅-未稅
                  #LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                  
                  #150422-00026#1 add ---
                  #稅額=含稅-未稅
                  LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
                  #150422-00026#1 end ---
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb028
            #add-point:ON CHANGE apbb028 name="input.g.apbb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb029
            #add-point:BEFORE FIELD apbb029 name="input.b.apbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb029
            
            #add-point:AFTER FIELD apbb029 name="input.a.apbb029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb029
            #add-point:ON CHANGE apbb029 name="input.g.apbb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb031
            #add-point:BEFORE FIELD apbb031 name="input.b.apbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb031
            
            #add-point:AFTER FIELD apbb031 name="input.a.apbb031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb031
            #add-point:ON CHANGE apbb031 name="input.g.apbb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb032
            #add-point:BEFORE FIELD apbb032 name="input.b.apbb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb032
            
            #add-point:AFTER FIELD apbb032 name="input.a.apbb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb032
            #add-point:ON CHANGE apbb032 name="input.g.apbb032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb033
            #add-point:BEFORE FIELD apbb033 name="input.b.apbb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb033
            
            #add-point:AFTER FIELD apbb033 name="input.a.apbb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb033
            #add-point:ON CHANGE apbb033 name="input.g.apbb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb034
            #add-point:BEFORE FIELD apbb034 name="input.b.apbb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb034
            
            #add-point:AFTER FIELD apbb034 name="input.a.apbb034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb034
            #add-point:ON CHANGE apbb034 name="input.g.apbb034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb016
            #add-point:BEFORE FIELD apbb016 name="input.b.apbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb016
            
            #add-point:AFTER FIELD apbb016 name="input.a.apbb016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb016
            #add-point:ON CHANGE apbb016 name="input.g.apbb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb017
            #add-point:BEFORE FIELD apbb017 name="input.b.apbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb017
            
            #add-point:AFTER FIELD apbb017 name="input.a.apbb017"
            #161129-00042#1-add(s)
            #161230-00036#1 mark ------
            #LET l_ooef011 = ' '
            #SELECT ooef011 INTO l_ooef011 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_apbb_m.apbbcomp
            #IF l_ooef011 = 'TW' THEN
            #161230-00036#1 mark end---
            #161230-00036#1 add ------
            IF g_apbb_m.apbb017 != g_apbb_m_o.apbb017 OR cl_null(g_apbb_m_o.apbb017) THEN
               IF g_ooef011 = 'TW' THEN
            #161230-00036#1 add end---
                  IF NOT cl_null(g_apbb_m.apbb017) THEN
                     #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                     CALL s_rule_chk_vat_id_string(g_apbb_m.apbb017) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_apbb_m.apbb017 = g_apbb_m_o.apbb017
                        NEXT FIELD apbb017
                     END IF
                     #檢查營利事業統一編號邏輯
                     #CALL s_rule_chk_vat_id(l_ooef011,g_apbb_m.apbb017) RETURNING l_success #161230-00036#1 mark
                     CALL s_rule_chk_vat_id(g_ooef011,g_apbb_m.apbb017) RETURNING l_success  #161230-00036#1 add
                     IF NOT l_success THEN
                        LET g_apbb_m.apbb017 = g_apbb_m.apbb017  
                     END IF
                  END IF
               END IF
            #161129-00042#1-add(e)
            #161230-00036#1 add ------
            END IF
            LET g_apbb_m_o.* = g_apbb_m.*
            #161230-00036#1 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb017
            #add-point:ON CHANGE apbb017 name="input.g.apbb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb018
            #add-point:BEFORE FIELD apbb018 name="input.b.apbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb018
            
            #add-point:AFTER FIELD apbb018 name="input.a.apbb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb018
            #add-point:ON CHANGE apbb018 name="input.g.apbb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb019
            #add-point:BEFORE FIELD apbb019 name="input.b.apbb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb019
            
            #add-point:AFTER FIELD apbb019 name="input.a.apbb019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb019
            #add-point:ON CHANGE apbb019 name="input.g.apbb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb020
            #add-point:BEFORE FIELD apbb020 name="input.b.apbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb020
            
            #add-point:AFTER FIELD apbb020 name="input.a.apbb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb020
            #add-point:ON CHANGE apbb020 name="input.g.apbb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb021
            #add-point:BEFORE FIELD apbb021 name="input.b.apbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb021
            
            #add-point:AFTER FIELD apbb021 name="input.a.apbb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb021
            #add-point:ON CHANGE apbb021 name="input.g.apbb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb202
            
            #add-point:AFTER FIELD apbb202 name="input.a.apbb202"
            #IF NOT cl_null(g_apbb_m.apbb202) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_chkparam.arg1 = g_apbb_m.apbb202
            #   IF cl_chk_exist("v_oocq002_3802") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #   ELSE
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb202
            #add-point:BEFORE FIELD apbb202 name="input.b.apbb202"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb202
            #add-point:ON CHANGE apbb202 name="input.g.apbb202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb203
            #add-point:BEFORE FIELD apbb203 name="input.b.apbb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb203
            
            #add-point:AFTER FIELD apbb203 name="input.a.apbb203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb203
            #add-point:ON CHANGE apbb203 name="input.g.apbb203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb204
            #add-point:BEFORE FIELD apbb204 name="input.b.apbb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb204
            
            #add-point:AFTER FIELD apbb204 name="input.a.apbb204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb204
            #add-point:ON CHANGE apbb204 name="input.g.apbb204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb207
            
            #add-point:AFTER FIELD apbb207 name="input.a.apbb207"
            #IF NOT cl_null(g_apbb_m.apbb207) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_chkparam.arg1 = g_apbb_m.apbb207
            #   LET g_chkparam.arg2 = '參數2'
            #   IF cl_chk_exist("v_oocq002_3803") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #   ELSE
            #      #檢查失敗時後續處理
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb207
            #add-point:BEFORE FIELD apbb207 name="input.b.apbb207"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb207
            #add-point:ON CHANGE apbb207 name="input.g.apbb207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb042
            #add-point:BEFORE FIELD apbb042 name="input.b.apbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb042
            
            #add-point:AFTER FIELD apbb042 name="input.a.apbb042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb042
            #add-point:ON CHANGE apbb042 name="input.g.apbb042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb039
            #add-point:BEFORE FIELD apbb039 name="input.b.apbb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb039
            
            #add-point:AFTER FIELD apbb039 name="input.a.apbb039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb039
            #add-point:ON CHANGE apbb039 name="input.g.apbb039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb040
            #add-point:BEFORE FIELD apbb040 name="input.b.apbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb040
            
            #add-point:AFTER FIELD apbb040 name="input.a.apbb040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb040
            #add-point:ON CHANGE apbb040 name="input.g.apbb040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb041
            
            #add-point:AFTER FIELD apbb041 name="input.a.apbb041"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb041
            #add-point:BEFORE FIELD apbb041 name="input.b.apbb041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb041
            #add-point:ON CHANGE apbb041 name="input.g.apbb041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb038
            
            #add-point:AFTER FIELD apbb038 name="input.a.apbb038"
            #IF NOT cl_null(g_apbb_m.apbb038) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_chkparam.arg1 = g_apbb_m.apbb038
            #   IF cl_chk_exist_and_ref_val("v_oocq002_3804") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #   ELSE
            #      #檢查失敗時後續處理
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb038
            #add-point:BEFORE FIELD apbb038 name="input.b.apbb038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb038
            #add-point:ON CHANGE apbb038 name="input.g.apbb038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbb049
            #add-point:BEFORE FIELD apbb049 name="input.b.apbb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbb049
            
            #add-point:AFTER FIELD apbb049 name="input.a.apbb049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbb049
            #add-point:ON CHANGE apbb049 name="input.g.apbb049"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb004
            #add-point:ON ACTION controlp INFIELD apbb004 name="input.c.apbb004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb004
            #CALL q_ooef001()     #161006-00005#4  mark
            CALL q_ooef001_46()   #161006-00005#4   add 
            LET g_apbb_m.apbb004 = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbb004
            NEXT FIELD apbb004
            #END add-point
 
 
         #Ctrlp:input.c.apbbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbcomp
            #add-point:ON ACTION controlp INFIELD apbbcomp name="input.c.apbbcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbbcomp
            IF NOT cl_null(g_apbb_m.apbb004) THEN 
               #160705-00035#1 mark ------
               #CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
               #CALL s_fin_account_center_comp_str() RETURNING g_wc_apbaorga
               #CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
               ##160705-00035#1 mark end---
               #LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_apbaorga CLIPPED #160907-00041#1 mark
               
               #160907-00041#1 --s add
               CALL s_fin_azzi800_sons_query(g_today)                 
               CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
               CALL s_fin_account_center_comp_str()RETURNING g_wc_cs_comp
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp CLIPPED
               #160907-00041#1 --e add
            ELSE
               #160907-00041#1 --s add
               CALL s_fin_azzi800_sons_query(g_today)
               CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               #160907-00041#1 --e add
               LET g_qryparam.where = "ooef003 = 'Y'"
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp CLIPPED #160907-00041#1 add
            END IF 
            CALL q_ooef001()
            LET g_apbb_m.apbbcomp = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbbcomp
            NEXT FIELD apbbcomp
            #END add-point
 
 
         #Ctrlp:input.c.apbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb053
            #add-point:ON ACTION controlp INFIELD apbb053 name="input.c.apbb053"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb053
            CALL q_ooag001()
            LET g_apbb_m.apbb053 = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbb053
            NEXT FIELD apbb053
            #END add-point
 
 
         #Ctrlp:input.c.apbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbdocno
            #add-point:ON ACTION controlp INFIELD apbbdocno name="input.c.apbbdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbbdocno
            CALL s_ld_sel_glaa(g_ld,'glaa024') RETURNING g_sub_success,l_glaa024
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx003 = 'aapt110'"
            #161104-00046#4 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#4 --e add             
            CALL q_ooba002_4()
            LET g_apbb_m.apbbdocno = g_qryparam.return1
            DISPLAY g_apbb_m.apbbdocno TO apbbdocno
            CALL s_aooi200_fin_get_slip_desc(g_apbb_m.apbbdocno) RETURNING g_apbb_m.l_apbbdocno_desc
            DISPLAY BY NAME g_apbb_m.l_apbbdocno_desc
            NEXT FIELD apbbdocno
            #END add-point
 
 
         #Ctrlp:input.c.apbbdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbdocdt
            #add-point:ON ACTION controlp INFIELD apbbdocdt name="input.c.apbbdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb002
            #add-point:ON ACTION controlp INFIELD apbb002 name="input.c.apbb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb002
            LET g_qryparam.default2 = g_apbb_m.apbb030
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象
            #151231-00010#10(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               #LET g_qryparam.where = g_sql_ctrl  #161114-00020#1 mark
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl #161114-00020#1
            END IF
            #151231-00010#10(E)
            CALL q_pmaa001_25()
            LET g_apbb_m.apbb002 = g_qryparam.return1
            LET g_apbb_m.apbb030 = g_qryparam.return2
            NEXT FIELD apbb002
            #END add-point
 
 
         #Ctrlp:input.c.apbb059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb059
            #add-point:ON ACTION controlp INFIELD apbb059 name="input.c.apbb059"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb003
            #add-point:ON ACTION controlp INFIELD apbb003 name="input.c.apbb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb050
            #add-point:ON ACTION controlp INFIELD apbb050 name="input.c.apbb050"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb009
            #add-point:ON ACTION controlp INFIELD apbb009 name="input.c.apbb009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb009
            CALL q_isak001()
            LET g_apbb_m.apbb009 = g_qryparam.return1
            DISPLAY g_apbb_m.apbb009 TO apbb009
            NEXT FIELD apbb009
            #END add-point
 
 
         #Ctrlp:input.c.apbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb010
            #add-point:ON ACTION controlp INFIELD apbb010 name="input.c.apbb010"
 
            #END add-point
 
 
         #Ctrlp:input.c.apbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbbstus
            #add-point:ON ACTION controlp INFIELD apbbstus name="input.c.apbbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb008
            #add-point:ON ACTION controlp INFIELD apbb008 name="input.c.apbb008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb008
            #紅字發票與藍字發票是否共用發票簿
            #161230-00036#1 mark ------
            #SELECT isai006 INTO g_isai006
            #  FROM ooef_t
            #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
            # WHERE ooefent = g_enterprise
            #   AND ooef001 = g_apbb_m.apbbcomp
            #161230-00036#1 mark end---
            CASE g_apbb_m.apbb050
               WHEN "1"
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '1'"
               WHEN "2"
                  IF g_isai006 = "Y" THEN
                     LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
                  ELSE
                     LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '3'"
                  END IF
               OTHERWISE
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
            END CASE
            CALL q_isac002()
            LET g_apbb_m.apbb008 = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbb008
            NEXT FIELD apbb008
            #END add-point
 
 
         #Ctrlp:input.c.apbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb011
            #add-point:ON ACTION controlp INFIELD apbb011 name="input.c.apbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb030
            #add-point:ON ACTION controlp INFIELD apbb030 name="input.c.apbb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb051
            #add-point:ON ACTION controlp INFIELD apbb051 name="input.c.apbb051"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb051
            CALL q_ooag001()
            LET g_apbb_m.apbb051 = g_qryparam.return1
            NEXT FIELD apbb051
            #END add-point
 
 
         #Ctrlp:input.c.apbb052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb052
            #add-point:ON ACTION controlp INFIELD apbb052 name="input.c.apbb052"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb052
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()
            LET g_apbb_m.apbb052 = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbb052
            NEXT FIELD apbb052
            #END add-point
 
 
         #Ctrlp:input.c.apbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb054
            #add-point:ON ACTION controlp INFIELD apbb054 name="input.c.apbb054"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb054
            CALL q_ooib001_2() 
            LET g_apbb_m.apbb054 = g_qryparam.return1
            DISPLAY BY NAME g_apbb_m.apbb054
            NEXT FIELD apbb054
            #END add-point
 
 
         #Ctrlp:input.c.apbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb012
            #add-point:ON ACTION controlp INFIELD apbb012 name="input.c.apbb012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb012
            LET g_qryparam.default2 = ""
            LET g_qryparam.default3 = g_apbb_m.apbb0121 #含稅否
            LET g_qryparam.default4 = g_apbb_m.apbb013  #稅率
            LET g_qryparam.arg1 = g_ooef019
            CALL q_oodb002_5()
            LET g_apbb_m.apbb012 = g_qryparam.return1
            LET g_apbb_m.apbb0121 = g_qryparam.return3
            LET g_apbb_m.apbb013 = g_qryparam.return4
            NEXT FIELD apbb012
            #END add-point
 
 
         #Ctrlp:input.c.apbb0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb0121
            #add-point:ON ACTION controlp INFIELD apbb0121 name="input.c.apbb0121"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb013
            #add-point:ON ACTION controlp INFIELD apbb013 name="input.c.apbb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb037
            #add-point:ON ACTION controlp INFIELD apbb037 name="input.c.apbb037"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb036
            #add-point:ON ACTION controlp INFIELD apbb036 name="input.c.apbb036"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb200
            #add-point:ON ACTION controlp INFIELD apbb200 name="input.c.apbb200"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb055
            #add-point:ON ACTION controlp INFIELD apbb055 name="input.c.apbb055"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb056
            #add-point:ON ACTION controlp INFIELD apbb056 name="input.c.apbb056"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb014
            #add-point:ON ACTION controlp INFIELD apbb014 name="input.c.apbb014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb014
            LET g_qryparam.arg1 = g_apbb_m.apbbcomp
            CALL q_ooaj002_1()
            LET g_apbb_m.apbb014 = g_qryparam.return1
            NEXT FIELD apbb014
            #END add-point
 
 
         #Ctrlp:input.c.apbb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb023
            #add-point:ON ACTION controlp INFIELD apbb023 name="input.c.apbb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb024
            #add-point:ON ACTION controlp INFIELD apbb024 name="input.c.apbb024"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb025
            #add-point:ON ACTION controlp INFIELD apbb025 name="input.c.apbb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb015
            #add-point:ON ACTION controlp INFIELD apbb015 name="input.c.apbb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb026
            #add-point:ON ACTION controlp INFIELD apbb026 name="input.c.apbb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb027
            #add-point:ON ACTION controlp INFIELD apbb027 name="input.c.apbb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb028
            #add-point:ON ACTION controlp INFIELD apbb028 name="input.c.apbb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb029
            #add-point:ON ACTION controlp INFIELD apbb029 name="input.c.apbb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb031
            #add-point:ON ACTION controlp INFIELD apbb031 name="input.c.apbb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb032
            #add-point:ON ACTION controlp INFIELD apbb032 name="input.c.apbb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb033
            #add-point:ON ACTION controlp INFIELD apbb033 name="input.c.apbb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb034
            #add-point:ON ACTION controlp INFIELD apbb034 name="input.c.apbb034"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb016
            #add-point:ON ACTION controlp INFIELD apbb016 name="input.c.apbb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb017
            #add-point:ON ACTION controlp INFIELD apbb017 name="input.c.apbb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb018
            #add-point:ON ACTION controlp INFIELD apbb018 name="input.c.apbb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb019
            #add-point:ON ACTION controlp INFIELD apbb019 name="input.c.apbb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb020
            #add-point:ON ACTION controlp INFIELD apbb020 name="input.c.apbb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb021
            #add-point:ON ACTION controlp INFIELD apbb021 name="input.c.apbb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb202
            #add-point:ON ACTION controlp INFIELD apbb202 name="input.c.apbb202"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb202
            LET g_qryparam.default2 = g_apbb_m.l_apbb202_desc
            LET g_qryparam.arg1 = "3802"
            CALL q_oocq002()
            LET g_apbb_m.apbb202 = g_qryparam.return1
            LET g_apbb_m.l_apbb202_desc = g_qryparam.return2
            DISPLAY BY NAME g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc
            NEXT FIELD apbb202
            #END add-point
 
 
         #Ctrlp:input.c.apbb203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb203
            #add-point:ON ACTION controlp INFIELD apbb203 name="input.c.apbb203"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb204
            #add-point:ON ACTION controlp INFIELD apbb204 name="input.c.apbb204"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb207
            #add-point:ON ACTION controlp INFIELD apbb207 name="input.c.apbb207"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb207
            LET g_qryparam.default2 = g_apbb_m.l_apbb207_desc
            LET g_qryparam.arg1 = "3803"
            CALL q_oocq002()
            LET g_apbb_m.apbb207 = g_qryparam.return1
            LET g_apbb_m.l_apbb207_desc = g_qryparam.return2
            DISPLAY BY NAME g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc
            NEXT FIELD apbb207
            #END add-point
 
 
         #Ctrlp:input.c.apbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb042
            #add-point:ON ACTION controlp INFIELD apbb042 name="input.c.apbb042"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb039
            #add-point:ON ACTION controlp INFIELD apbb039 name="input.c.apbb039"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb040
            #add-point:ON ACTION controlp INFIELD apbb040 name="input.c.apbb040"
            
            #END add-point
 
 
         #Ctrlp:input.c.apbb041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb041
            #add-point:ON ACTION controlp INFIELD apbb041 name="input.c.apbb041"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb041
            CALL q_ooag001()
            LET g_apbb_m.apbb041 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_apbb_m.apbb041) RETURNING g_apbb_m.l_apbb041_desc
            DISPLAY BY NAME g_apbb_m.apbb041,g_apbb_m.l_apbb041_desc
            NEXT FIELD apbb041
            #END add-point
 
 
         #Ctrlp:input.c.apbb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb038
            #add-point:ON ACTION controlp INFIELD apbb038 name="input.c.apbb038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apbb_m.apbb038
            LET g_qryparam.arg1 = "3804"
            CALL q_oocq002()
            LET g_apbb_m.apbb038 = g_qryparam.return1
            DISPLAY g_apbb_m.apbb038 TO apbb038
            NEXT FIELD apbb038
            #END add-point
 
 
         #Ctrlp:input.c.apbb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbb049
            #add-point:ON ACTION controlp INFIELD apbb049 name="input.c.apbb049"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apbb_m.apbbdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            ##檢核原幣容差率
            #IF g_apbb_m.apbb024 != g_apbb_m_t.apbb024 AND g_apbb_m.apbb023<>0 AND g_apbb_m.apbb024<>0 AND g_apbb_m.apbb025<>0 THEN
            #   CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025)
            #   RETURNING g_sub_success,g_errno,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025
            #   #容差率OK否
            #   IF NOT g_sub_success THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = g_errno
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      LET g_apbb_m.apbb024 = g_apbb_m_t.apbb024
            #      NEXT FIELD apbb024
            #   ELSE
            #      #容差率OK要更新本幣金額
            #      LET g_apbb_m.apbb026 = g_apbb_m.apbb023 * g_apbb_m.apbb015
            #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
            #      LET g_apbb_m.apbb028 = g_apbb_m.apbb025 * g_apbb_m.apbb015
            #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
            #      #含稅=未稅+稅額
            #      LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
            #      IF g_apbb_m.apbb0121 = "Y" THEN
            #         #容差率OK要更新本幣金額
            #         LET g_apbb_m.apbb028 = (g_apbb_m.apbb023+g_apbb_m.apbb024) * g_apbb_m.apbb015
            #         CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb028,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb028
            #         LET g_apbb_m.apbb026 = g_apbb_m.apbb028 / (1+(g_apbb_m.apbb013/100))
            #         CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
            #         #稅額=含稅-未稅
            #         LET g_apbb_m.apbb027 = g_apbb_m.apbb028 - g_apbb_m.apbb026
            #      ELSE
            #         #容差率OK要更新本幣金額
            #         LET g_apbb_m.apbb026 = g_apbb_m.apbb023 * g_apbb_m.apbb015
            #         CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb026,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb026
            #         LET g_apbb_m.apbb027 = g_apbb_m.apbb026 * (g_apbb_m.apbb013/100)
            #         CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apbb_m.apbb027,2) RETURNING g_sub_success,g_errno,g_apbb_m.apbb027
            #         #含稅=未稅+稅額
            #         LET g_apbb_m.apbb028 = g_apbb_m.apbb026 + g_apbb_m.apbb027
            #      END IF
            #   END IF
            #END IF
            ##檢核本幣容差率
            #IF g_apbb_m.apbb027 != g_apbb_m_t.apbb027 AND g_apbb_m.apbb026<>0 AND g_apbb_m.apbb027<>0 AND g_apbb_m.apbb028<>0 THEN
            #   CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028)
            #   RETURNING g_sub_success,g_errno,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
            #   #容差率OK否
            #   IF NOT g_sub_success THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = g_errno
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      LET g_apbb_m.apbb027 = g_apbb_m_t.apbb027
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_ld,'','',g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_prog)
                    RETURNING g_sub_success,g_apbb_m.apbbdocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apbb_m.apbbdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD apbbdocno
               END IF
               DISPLAY BY NAME g_apbb_m.apbbdocno
               #161206-00042#5-----s
               UPDATE pmak_t SET pmak006 = g_apbb_m.apbbdocno 
                WHERE pmakent = g_enterprise AND pmak001 = g_apbb_m.apbb059
               #161206-00042#5-----e
               #end add-point
               
               INSERT INTO apbb_t (apbbent,apbb004,apbbcomp,apbb053,apbbdocno,apbbdocdt,apbb002,apbb059, 
                   apbb003,apbb050,apbb009,apbb010,apbbstus,apbb008,apbb011,apbb030,apbb051,apbb052, 
                   apbb054,apbb012,apbb0121,apbb013,apbb037,apbb036,apbb200,apbb055,apbb056,apbb014, 
                   apbb023,apbb024,apbb025,apbb015,apbb026,apbb027,apbb028,apbb029,apbb031,apbb032,apbb033, 
                   apbb034,apbb016,apbb017,apbb018,apbb019,apbb020,apbb021,apbb202,apbb203,apbb204,apbb207, 
                   apbb206,apbb205,apbb042,apbb039,apbb040,apbb041,apbb038,apbb049,apbb107,apbb108,apbb117, 
                   apbb118,apbb208,apbb209,apbb210,apbbownid,apbbowndp,apbbcrtid,apbbcrtdp,apbbcrtdt, 
                   apbbmodid,apbbmoddt,apbbcnfid,apbbcnfdt)
               VALUES (g_enterprise,g_apbb_m.apbb004,g_apbb_m.apbbcomp,g_apbb_m.apbb053,g_apbb_m.apbbdocno, 
                   g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050, 
                   g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
                   g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012, 
                   g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200, 
                   g_apbb_m.apbb055,g_apbb_m.apbb056,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024, 
                   g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028, 
                   g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034, 
                   g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
                   g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207, 
                   g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040, 
                   g_apbb_m.apbb041,g_apbb_m.apbb038,g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108, 
                   g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210, 
                   g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdt, 
                   g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apbb_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #150629-00017#1 mark ------
               #IF g_apbb_m.apbb056 = 'N' THEN   #20150604 add lujh
               #   IF NOT cl_null(g_apbb_m.apbb010) AND (g_apbb_m.apbb010 <> 'MULTI') THEN
               #      #發票號碼不為空白AND不等於MULTI，則新增一筆isam_t
               #      CALL aapt110_ins_isam() RETURNING g_sub_success
               #      IF NOT g_sub_success THEN
               #         CALL s_transaction_end('N','0')
               #         CONTINUE DIALOG
               #      END IF
               #   END IF
               #END IF   #20150604 add lujh
               #150629-00017#1 mark end---
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt110_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt110_b_fill()
                  CALL aapt110_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #若稅別or匯率有變更，須詢問是否重新推算單身金額
               LET l_change_tax = 'N'
               LET l_change_rate = 'N'
               LET l_change = 'N'
               IF g_apbb_m.apbb012 != g_apbb_m_t.apbb012 THEN
                  LET l_change_tax = 'Y'
               END IF
               IF g_apbb_m.apbb015 != g_apbb_m_t.apbb015 THEN
                  LET l_change_rate = 'Y'
               END IF
               CASE
                  WHEN l_change_tax = 'Y' AND l_change_rate = 'Y'
                     IF cl_ask_confirm('aap-00253') THEN
                        LET l_change = "Y"
                     END IF
                  WHEN l_change_tax = 'Y'
                     IF cl_ask_confirm('aap-00252') THEN
                        LET l_change = "Y"
                     END IF
                  WHEN l_change_rate = 'Y'
                     IF cl_ask_confirm('aap-00251') THEN
                        LET l_change = "Y"
                     END IF
                  OTHERWISE
               END CASE
               IF l_change = "Y" THEN
                  CALL aapt110_change_tax_or_rate_update() RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "apbb_t"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  ELSE
                     #更新至單頭
                     IF cl_ask_confirm('aap-00210') THEN
                        CALL aapt110_money_update_to_head("apba","Y")
                     END IF
                  END IF
               END IF
               #161206-00042#5-----s
               UPDATE pmak_t SET pmak006 = g_apbb_m.apbbdocno 
                WHERE pmakent = g_enterprise AND pmak001 = g_apbb_m.apbb059
               #161206-00042#5-----e
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt110_apbb_t_mask_restore('restore_mask_o')
               
               UPDATE apbb_t SET (apbb004,apbbcomp,apbb053,apbbdocno,apbbdocdt,apbb002,apbb059,apbb003, 
                   apbb050,apbb009,apbb010,apbbstus,apbb008,apbb011,apbb030,apbb051,apbb052,apbb054, 
                   apbb012,apbb0121,apbb013,apbb037,apbb036,apbb200,apbb055,apbb056,apbb014,apbb023, 
                   apbb024,apbb025,apbb015,apbb026,apbb027,apbb028,apbb029,apbb031,apbb032,apbb033,apbb034, 
                   apbb016,apbb017,apbb018,apbb019,apbb020,apbb021,apbb202,apbb203,apbb204,apbb207,apbb206, 
                   apbb205,apbb042,apbb039,apbb040,apbb041,apbb038,apbb049,apbb107,apbb108,apbb117,apbb118, 
                   apbb208,apbb209,apbb210,apbbownid,apbbowndp,apbbcrtid,apbbcrtdp,apbbcrtdt,apbbmodid, 
                   apbbmoddt,apbbcnfid,apbbcnfdt) = (g_apbb_m.apbb004,g_apbb_m.apbbcomp,g_apbb_m.apbb053, 
                   g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
                   g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008, 
                   g_apbb_m.apbb011,g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054, 
                   g_apbb_m.apbb012,g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036, 
                   g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056,g_apbb_m.apbb014,g_apbb_m.apbb023, 
                   g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026,g_apbb_m.apbb027, 
                   g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
                   g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019, 
                   g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204, 
                   g_apbb_m.apbb207,g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039, 
                   g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038,g_apbb_m.apbb049,g_apbb_m.apbb107, 
                   g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208,g_apbb_m.apbb209, 
                   g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
                   g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt) 
 
                WHERE apbbent = g_enterprise AND apbbdocno = g_apbbdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apbb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #150629-00017#1 mark ------
               #IF g_apbb_m.apbb056 = 'N' THEN   #20150604 add lujh
               #   IF NOT cl_null(g_apbb_m.apbb010) AND (g_apbb_m.apbb010 <> 'MULTI') THEN
               #      SELECT COUNT(*) INTO l_cnt FROM isam_t
               #       WHERE isament = g_enterprise
               #         AND isamdocno = g_apbb_m.apbbdocno
               #         AND isam010 = g_apbb_m.apbb010
               #      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               #      IF l_cnt = 0 THEN
               #         #發票號碼不為空白AND不等於MULTI，則新增一筆isam_t
               #         CALL aapt110_ins_isam() RETURNING g_sub_success
               #         IF NOT g_sub_success THEN
               #            CALL s_transaction_end('N','0')
               #            CONTINUE DIALOG
               #         END IF
               #      END IF
               #   END IF
               #END IF    #20150604 add lujh
               #150629-00017#1 mark end---
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt110_apbb_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apbb_m_t)
               LET g_log2 = util.JSON.stringify(g_apbb_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               CALL aapt110_b_fill()
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt110.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apba_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aapt110_02
            LET g_action_choice="aapt110_02"
            IF cl_auth_chk_act("aapt110_02") THEN
               
               #add-point:ON ACTION aapt110_02 name="input.detail_input.page1.aapt110_02"
               #141218-00011#1 add ------
               CALL aapt110_auto_ins_detail()  
               CALL aapt110_show()
               LET l_gen_flag = 'Y'
                #141218-00011#1 add end---
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt110_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apba_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #雜項發票不用彈自動產生
            IF g_apbb_m.apbb003 NOT MATCHES '[89]' THEN  #160705-00035#1
               #141218-00011#1-------
               #單身沒資料就要開啟自動產生的視窗
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM apba_t
                WHERE apbaent = g_enterprise
                  AND apbadocno = g_apbb_m.apbbdocno
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  CALL aapt110_auto_ins_detail()
               END IF
               CALL aapt110_show()
               #141218-00011#1 END---
            END IF  #160705-00035#1
            CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
            
            #160826-00017#1   add---s
            #對帳單主畫面表尾合計
            CALL aapt110_apbb_sum_button(g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,'')
               RETURNING l_sum1.apba103,l_sum1.apba104,l_sum1.apba105,
                         l_sum1.apba113,l_sum1.apba114,l_sum1.apba115
            DISPLAY BY NAME l_sum1.apba103,l_sum1.apba104,l_sum1.apba105,
                            l_sum1.apba113,l_sum1.apba114,l_sum1.apba115
            #160826-00017#1   add---e
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
 
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt110_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apba_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apba_d[l_ac].apbaseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apba_d_t.* = g_apba_d[l_ac].*  #BACKUP
               LET g_apba_d_o.* = g_apba_d[l_ac].*  #BACKUP
               CALL aapt110_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt110_set_no_entry_b(l_cmd)
               IF NOT aapt110_lock_b("apba_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt110_bcl INTO g_apba_d[l_ac].apbaseq,g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004, 
                      g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apba_d[l_ac].apba019, 
                      g_apba_d[l_ac].apba007,g_apba_d[l_ac].apba008,g_apba_d[l_ac].apba013,g_apba_d[l_ac].apba015, 
                      g_apba_d[l_ac].apba012,g_apba_d[l_ac].apba100,g_apba_d[l_ac].apba009,g_apba_d[l_ac].apba014, 
                      g_apba_d[l_ac].apba010,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba105,g_apba_d[l_ac].apba104, 
                      g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba115,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba016, 
                      g_apba_d[l_ac].apba017,g_apba_d[l_ac].apba111
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apba_d_t.apbaseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apba_d_mask_o[l_ac].* =  g_apba_d[l_ac].*
                  CALL aapt110_apba_t_mask()
                  LET g_apba_d_mask_n[l_ac].* =  g_apba_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt110_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",TRUE)
            CASE
               #MISC01.其他加項
               WHEN g_apba_d[l_ac].apba004 = '16' or g_apba_d[l_ac].apba004 = '19'
                    CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
               #MISC02.其他減項
               WHEN g_apba_d[l_ac].apba004 = '26' or g_apba_d[l_ac].apba004 = '29'
                    CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
               OTHERWISE
            END CASE
            #160705-00035#1 -s
            CALL cl_set_comp_required("apba005,apba006",TRUE)
            IF g_apba_d[l_ac].apba004 MATCHES '1[69]' OR g_apba_d[l_ac].apba004 MATCHES '2[69]' THEN
               CALL cl_set_comp_required("apba005,apba006",FALSE)
            END IF
            #先排除流通
            IF g_apba_d[l_ac].apba004 = '12' OR g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23' THEN
               CALL cl_set_comp_required("apba005,apba006",FALSE)
            END IF
            #只有待底才需要輸入期別
            CALL cl_set_comp_entry("apba020",FALSE)
            #27.待底只開放調整金額，其他公式推算
           #CALL cl_set_comp_entry("apba014,apba010,apba104,apba105,apba113,apba114,apba115",TRUE) #160705-00035#5 mark
            CALL cl_set_comp_entry("apba014,apba010",TRUE)                                         #160705-00035#5
            IF g_apba_d[l_ac].apba004 = '27' THEN
               CALL cl_set_comp_entry("apba020",TRUE)
              #CALL cl_set_comp_entry("apba014,apba010,apba104,apba105,apba113,apba114,apba115",FALSE) #160705-00035#5 mark
               CALL cl_set_comp_entry("apba014,apba010",FALSE)                                         #160705-00035#5
            END IF
            #160705-00035#1 -e
            #170110-00035#1 add ------
            #採購單也開放輸入期別
            IF g_apba_d[l_ac].apba004 = '10' THEN
               CALL cl_set_comp_entry("apba020",TRUE)
            END IF
            #170110-00035#1 add end---
            #160826-00017#1   add---s
            #對帳單主畫面表尾合計
            CALL aapt110_apbb_sum_button(g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq)
               RETURNING l_sum1.apba103,l_sum1.apba104,l_sum1.apba105,
                         l_sum1.apba113,l_sum1.apba114,l_sum1.apba115
            DISPLAY BY NAME l_sum1.apba103,l_sum1.apba104,l_sum1.apba105,
                            l_sum1.apba113,l_sum1.apba114,l_sum1.apba115
            #160826-00017#1   add---e
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apba_d[l_ac].* TO NULL 
            INITIALIZE g_apba_d_t.* TO NULL 
            INITIALIZE g_apba_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET l_gen_flag = 'N'   #141218-00011#1
            LET g_apba_d[l_ac].apba111 = g_apbb_m.apbb015   #150422-00026#1
            #end add-point
            LET g_apba_d_t.* = g_apba_d[l_ac].*     #新輸入資料
            LET g_apba_d_o.* = g_apba_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt110_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt110_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apba_d[li_reproduce_target].* = g_apba_d[li_reproduce].*
 
               LET g_apba_d[li_reproduce_target].apbaseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次
            SELECT MAX(apbaseq)+1 INTO g_apba_d[l_ac].apbaseq
              FROM apba_t
             WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
            IF cl_null(g_apba_d[l_ac].apbaseq) OR g_apba_d[l_ac].apbaseq = 0 THEN
               LET g_apba_d[l_ac].apbaseq = 1
            END IF
            #來源作業預設
            LET g_apba_d[l_ac].apbaorga =  g_apbb_m.apbb004
            #160705-00035#1 mark ------
            #IF g_apbb_m.apbb050 = "1" THEN
            #   LET g_apba_d[l_ac].apba004 = '11'
            #ELSE
            #   LET g_apba_d[l_ac].apba004 = '21'
            #END IF
            #160705-00035#1 mark end---
            #160705-00035#1 add ------
            CASE g_apbb_m.apbb003
               WHEN '2'  #2:進貨發票立帳
                  LET g_apba_d[l_ac].apba004 = '11'
               WHEN '5'  #5:發票扣抵單立帳
                  LET g_apba_d[l_ac].apba004 = '21'
               WHEN '7'  #7:預付發票立帳
                  LET g_apba_d[l_ac].apba004 = '10'
               WHEN '8'  #8:雜項發票立帳
                  LET g_apba_d[l_ac].apba004 = '19'
               WHEN '9'  #9:雜項待抵立帳
                  LET g_apba_d[l_ac].apba004 = '29'
            END CASE
            DISPLAY BY NAME g_apbb_m.apbb050
            #160705-00035#1 add end---
            #稅別
            LET g_apba_d[l_ac].apba015 = g_apbb_m.apbb012
            #匯率
            LET g_apba_d[l_ac].apba111 = g_apbb_m.apbb015
            #正負值給予
            LET g_apba_d[l_ac].apba012 = 1
            CASE
               #apmt500.採購單
               WHEN g_apba_d[l_ac].apba004 = '10'
                    LET g_apba_d[l_ac].apba012 = 1
               #apmt570.採購入庫單
               WHEN g_apba_d[l_ac].apba004 = '11'
                    LET g_apba_d[l_ac].apba012 = 1
               #aapt301.其他應付單
               WHEN g_apba_d[l_ac].apba004 = '17'
                    LET g_apba_d[l_ac].apba012 = 1
               #MISC01.其他加項
               WHEN g_apba_d[l_ac].apba004 = '16' or g_apba_d[l_ac].apba004 = '19'
                    LET g_apba_d[l_ac].apba012 = 1
               #apmt560.採購驗退單
               WHEN g_apba_d[l_ac].apba004 = '20'
                    LET g_apba_d[l_ac].apba012 = -1
               #apmt580.採購倉退單
               WHEN g_apba_d[l_ac].apba004 = '21'
                    LET g_apba_d[l_ac].apba012 = -1
               #aapt340.其他待抵單
               WHEN g_apba_d[l_ac].apba004 = '27'
                    LET g_apba_d[l_ac].apba012 = -1
               #MISC02.其他減項
               WHEN g_apba_d[l_ac].apba004 = '26' or g_apba_d[l_ac].apba004 = '29'
                    LET g_apba_d[l_ac].apba012 = -1
               OTHERWISE
            END CASE
            LET g_apba_d[l_ac].apba019   = ''  #預付已開發票  #160705-00035#1
            
            CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",TRUE)
            CASE
               #MISC01.其他加項
               WHEN g_apba_d[l_ac].apba004 = '16' or g_apba_d[l_ac].apba004 = '19'
                    CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
               #MISC02.其他減項
               WHEN g_apba_d[l_ac].apba004 = '26' or g_apba_d[l_ac].apba004 = '29'
                    CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
               OTHERWISE
            END CASE
            #160705-00035#1 -s
            CALL cl_set_comp_required("apba005,apba006",TRUE)
            IF g_apba_d[l_ac].apba004 MATCHES '1[69]' OR g_apba_d[l_ac].apba004 MATCHES '2[69]' THEN
               CALL cl_set_comp_required("apba005,apba006",FALSE)
            END IF
            #先排除流通
            IF g_apba_d[l_ac].apba004 = '12' OR g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23' THEN
               CALL cl_set_comp_required("apba005,apba006",FALSE)
            END IF
            #160705-00035#1 -e
            #170110-00035#1 add ------
            CALL cl_set_comp_entry("apba020",FALSE)
            #27.待底只開放調整金額，其他公式推算
            CALL cl_set_comp_entry("apba014,apba010",TRUE)
            IF g_apba_d[l_ac].apba004 = '27' THEN
               CALL cl_set_comp_entry("apba020",TRUE)
               CALL cl_set_comp_entry("apba014,apba010",FALSE)
            END IF
            #採購單也開放輸入期別
            IF g_apba_d[l_ac].apba004 = '10' THEN
               CALL cl_set_comp_entry("apba020",TRUE)
            END IF
            #170110-00035#1 add end---
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            #141218-00011#1 add ------
            #若該筆新增到一半啟動了自動新增ACIOTN,則正在新增的該筆視為放棄
            IF l_gen_flag = 'Y' THEN
               CONTINUE DIALOG
            END IF
            #141218-00011#1 add end---
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apba_t 
             WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
 
               AND apbaseq = g_apba_d[l_ac].apbaseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys[2] = g_apba_d[g_detail_idx].apbaseq
               CALL aapt110_insert_b('apba_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #141218-00011#1 add ------
               #若該入庫單的收貨單有發票，來這兒新增到isam_t
               IF g_apbb_m.apbb056 = 'N' THEN   #20150603 add lujh
                  IF g_apba_d[l_ac].apba004 = '11' THEN
                     CALL aapt110_ins_isam_from_pmdw(g_apba_d[l_ac].apba005) RETURNING g_sub_success
                     CALL aapt110_b_fill()
                  END IF
               #20150603--add--str--lujh
               ELSE
                  CALL aapt110_ins_isam_1() RETURNING g_sub_success
                  CALL aapt110_b_fill()
               END IF
               #20150603--add--end--lujh
               #141218-00011#1 add end---
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apba_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt110_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apbb_m.apbbdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apba_d_t.apbaseq
 
            
               #刪除同層單身
               IF NOT aapt110_delete_b('apba_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt110_key_delete_b(gs_keys,'apba_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt110_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apba_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
 
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apba_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apbaorga
            #add-point:BEFORE FIELD apbaorga name="input.b.page1.apbaorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apbaorga
            
            #add-point:AFTER FIELD apbaorga name="input.a.page1.apbaorga"
            IF NOT cl_null(g_apba_d[l_ac].apbaorga) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apbaorga) OR g_apba_d[l_ac].apbaorga != g_apba_d_t.apbaorga) OR cl_null(g_apba_d_t.apbaorga))) THEN
                  #發票限制同法人否?
                  CALL cl_get_para(g_enterprise,g_apbb_m.apbbcomp,'S-FIN-3015') RETURNING l_sfin3015
                  IF l_sfin3015 = "Y" THEN
                     CALL aapt110_apbaorga_chk(g_apbb_m.apbbcomp,g_apba_d[l_ac].apbaorga,g_wc_apbaorga) #141218-00011#1 By Reanna
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba_d[l_ac].apbaorga = g_apba_d_t.apbaorga
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160317-00025#1 mark ------
                  #CALL s_fin_apcborga_chk(g_apbb_m.apbb004,g_apbb_m.apbbcomp,g_apba_d[l_ac].apbaorga,g_apbb_m.apbb011,'3') RETURNING g_sub_success,g_errno
                  #IF NOT g_sub_success THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.extend = ""
                  #   LET g_errparam.code   = g_errno
                  #   LET g_errparam.popup  = TRUE
                  #   CALL cl_err()
                  #   LET g_apba_d[l_ac].apbaorga = g_apba_d_t.apbaorga
                  #   NEXT FIELD CURRENT
                  #END IF
                  #160317-00025#1 mark end---
                  #160907-00041#1 --s mark
                  ##160317-00025#1 add ------
                  #CALL s_aap_apcborga_chk(g_ld,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaorga,g_wc_apbaorga) 
                  #     RETURNING g_sub_success,g_errno
                  #IF NOT g_sub_success THEN
                  #   LET g_errparam.code = g_errno
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_apba_d[l_ac].apbaorga = g_apba_d_t.apbaorga
                  #   NEXT FIELD CURRENT
                  #END IF
                  ##160317-00025#1 add end---
                  #160907-00041#1 --e mark
                  
                  #160907-00041#1 --s add
                  #檢查輸入組織代碼是否存在帳務中心下法人範圍內
                  IF s_chr_get_index_of(g_wc_apbaorga,g_apba_d[l_ac].apbaorga,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00312'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apbaorga = g_apba_d_t.apbaorga
                     NEXT FIELD CURRENT
                  END IF
                  #160907-00041#1 --e add
                
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apbaorga
            #add-point:ON CHANGE apbaorga name="input.g.page1.apbaorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba004
            #add-point:BEFORE FIELD apba004 name="input.b.page1.apba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba004
            
            #add-point:AFTER FIELD apba004 name="input.a.page1.apba004"
            #折讓證明單不可輸入入庫資料
            IF g_apbb_m.apbb050 = "2" THEN
               IF g_apba_d[l_ac].apba004 =  '10' OR g_apba_d[l_ac].apba004 =  '11' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00195'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba004
            #add-point:ON CHANGE apba004 name="input.g.page1.apba004"
            LET g_apba_d[l_ac].apba012 = 1
            CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",TRUE)
            #160705-00035#1 -s
            CALL cl_set_comp_required("apba005,apba006",TRUE)
            CALL cl_set_comp_entry("apba020",FALSE)
           #CALL cl_set_comp_entry("apba014,apba010,apba104,apba105,apba113,apba114,apba115",TRUE) #160705-00035#5 mark
            CALL cl_set_comp_entry("apba014,apba010",TRUE)                                         #160705-00035#5
            #160705-00035#1-e
            CASE
               #apmt500.採購單
               WHEN g_apba_d[l_ac].apba004 = '10'
                  #採購預付對於此張入庫單來說是負的所以要給負
                  LET g_apba_d[l_ac].apba012 = 1
                  #採購單也開放輸入期別
                  CALL cl_set_comp_entry("apba020",TRUE) #170110-00035#1
               
               #apmt570.採購入庫單
               WHEN g_apba_d[l_ac].apba004 = '11'
                  LET g_apba_d[l_ac].apba012 = 1
               
               #aapt301.其他應付單
               WHEN g_apba_d[l_ac].apba004 = '17'
                  LET g_apba_d[l_ac].apba012 = 1
               
               #MISC01.其他加項
               WHEN g_apba_d[l_ac].apba004 = '16' or g_apba_d[l_ac].apba004 = '19'
                  LET g_apba_d[l_ac].apba012 = 1
                  CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
                  CALL cl_set_comp_required("apba005,apba006",FALSE) #160705-00035#1
               
               #apmt560.採購驗退單
               WHEN g_apba_d[l_ac].apba004 = '20'
                  LET g_apba_d[l_ac].apba012   = -1

               #apmt580.採購倉退單
               WHEN g_apba_d[l_ac].apba004 = '21'
                  LET g_apba_d[l_ac].apba012 = -1
               
               #aapt340.其他待抵單
               WHEN g_apba_d[l_ac].apba004 = '27'
                  LET g_apba_d[l_ac].apba012 = -1
                  #160705-00035#1 -s
                  CALL cl_set_comp_entry("apba020",TRUE)
                 #CALL cl_set_comp_entry("apba014,apba010,apba104,apba105,apba113,apba114,apba115",TRUE) #160705-00035#5 mark
                  CALL cl_set_comp_entry("apba014,apba010",TRUE)                                         #160705-00035#5
                  #160705-00035#1 -e
                  
               #MISC02.其他減項
               WHEN g_apba_d[l_ac].apba004 = '26' or g_apba_d[l_ac].apba004 = '29'
                  LET g_apba_d[l_ac].apba012 = -1
                  CALL cl_set_comp_entry("apba005,apba006,apba007,apba013",FALSE)
                  CALL cl_set_comp_required("apba005,apba006",FALSE) #160705-00035#1

               OTHERWISE
            END CASE
            #160705-00035#1-s
            #先排除流通
            IF g_apba_d[l_ac].apba004 = '12' OR g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23' THEN
               CALL cl_set_comp_required("apba005,apba006",FALSE)
            END IF
            #160705-00035#1 -e
            LET g_apba_d[l_ac].apba005 = ''
            LET g_apba_d[l_ac].apba006 = ''
            LET g_apba_d[l_ac].apba007 = ''
            LET g_apba_d[l_ac].apba008 = ''
            LET g_apba_d[l_ac].apba009 = ''
            LET g_apba_d[l_ac].apba013 = ''
            LET g_apba_d[l_ac].apba100 = ''
            
            #160826-00017#1   add---s
            #單身金額合計
            LET g_apbb_m.apba103_s = l_sum1.apba103
            LET g_apbb_m.apba104_s = l_sum1.apba104
            LET g_apbb_m.apba105_s = l_sum1.apba105
            LET g_apbb_m.apba113_s = l_sum1.apba113
            LET g_apbb_m.apba114_s = l_sum1.apba114
            LET g_apbb_m.apba115_s = l_sum1.apba115
            DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                            g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
            #160826-00017#1   add---e
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba005
            #add-point:BEFORE FIELD apba005 name="input.b.page1.apba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba005
            
            #add-point:AFTER FIELD apba005 name="input.a.page1.apba005"
            IF NOT cl_null(g_apba_d[l_ac].apba005) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba005) OR g_apba_d[l_ac].apba005 != g_apba_d_t.apba005) OR cl_null(g_apba_d_t.apba005))) THEN #160726-00020#7 Mark
               IF g_apba_d[l_ac].apba005 != g_apba_d_o.apba005 OR  #160726-00020#7
                  cl_null(g_apba_d_o.apba005) THEN                 #160726-00020#7
                  #有項次才檢查
                  IF NOT cl_null(g_apba_d[l_ac].apba006) THEN
                     IF g_apbb_m.apbb056 = 'N' THEN 
                        #160705-00035#1-s
                        IF g_apba_d[l_ac].apba004 = '27' THEN #27:其他待抵單
                           IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                              #檢查輸入的單號&項次&期別是否存在
                              CALL s_aapt420_exist_chk('41',g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbb002,g_apbb_m.apbbdocno)
                                   RETURNING g_sub_success,g_errno
                              IF NOT g_sub_success THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = g_errno
                                 LET g_errparam.extend = ''
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                                 LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                                 LET g_apba_d[l_ac].apba020 = g_apba_d_t.apba020
                                 DISPLAY BY NAME g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020
                                 NEXT FIELD CURRENT
                              END IF
                              #檢核金額不可超出可沖金額
                              CALL s_aapt420_apcc_used_num('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbbdocno,' ','1')
                                   RETURNING g_sub_success,g_errno,l_apce.apce109,l_apce.apce119,l_apce.apce129,l_apce.apce139
                              CALL s_aapt420_apcc_used_chk('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,
                                   l_apce.apce109,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq,'1','0')
                                   RETURNING g_sub_success,g_errno
                              IF NOT g_sub_success THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = g_errno
                                 LET g_errparam.extend = ''
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 LET g_apba_d[l_ac].apba103 = g_apba_d_t.apba103
                                 DISPLAY BY NAME g_apba_d[l_ac].apba103
                                 NEXT FIELD CURRENT
                              END IF
                           END IF                          
                        ELSE
                        #160705-00035#1-e
                           #檢查輸入的單號&項次是否存在
                           CALL s_aapt300_source_doc_chk(g_apbb_m.apbbcomp,g_apbb_m.apbb004,g_apbb_m.apbb002,g_apba_d[l_ac].apba004,
                                                         g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apbb_m.apbbdocdt,g_ld)
                                RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005 #160726-00020#7 Mark
                              #LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006 #160726-00020#7 Mark
                              LET g_apba_d[l_ac].apba005 = g_apba_d_o.apba005  #160726-00020#7
                              LET g_apba_d[l_ac].apba006 = g_apba_d_o.apba006  #160726-00020#7
                              LET g_apba_d[l_ac].apba020 = g_apba_d_o.apba020  #170110-00035#1
                              NEXT FIELD CURRENT
                           END IF
                        END IF #160705-00035#1
                        #若為11/20/21要在作檢查
                        IF g_apba_d[l_ac].apba004 = 11 OR g_apba_d[l_ac].apba004 MATCHES '2[01]' THEN
                           CALL aapt110_source_doc_chk() RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005 #160726-00020#7 Mark
                              #LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006 #160726-00020#7 Mark
                              LET g_apba_d[l_ac].apba005 = g_apba_d_o.apba005  #160726-00020#7
                              LET g_apba_d[l_ac].apba006 = g_apba_d_o.apba006  #160726-00020#7
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                        #檢查是否重key單
                        SELECT COUNT(*) INTO l_cnt
                          FROM apba_t 
                         WHERE apbaent = g_enterprise
                           AND apbadocno = g_apbb_m.apbbdocno
                           AND apba005 = g_apba_d[l_ac].apba005
                           AND apba006 = g_apba_d[l_ac].apba006
                           AND apbaseq <> g_apba_d[l_ac].apbaseq
                        IF l_cnt > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'asf-00408'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apba_d[l_ac].apba005 = ''
                           LET g_apba_d[l_ac].apba006 = ''
                           LET g_apba_d[l_ac].apba020 = ''  #170110-00035#1
                           LET g_apba_d[l_ac].apba007 = ''
                           LET g_apba_d[l_ac].apba008 = ''
                           LET g_apba_d[l_ac].apba013 = ''
                           LET g_apba_d[l_ac].apba015 = ''
                           LET g_apba_d[l_ac].apba100 = ''
                           LET g_apba_d[l_ac].apba009 = ''
                           LET g_apba_d[l_ac].apba014 = 0
                           LET g_apba_d[l_ac].apba010 = 0
                           LET g_apba_d[l_ac].apba113 = 0
                           LET g_apba_d[l_ac].apba115 = 0
                           LET g_apba_d[l_ac].apba114 = 0
                           NEXT FIELD CURRENT
                        END IF
                        

                        
                        IF g_apba_d[l_ac].apba004 <> '19' or g_apba_d[l_ac].apba004 <> '29' THEN
                           #160705-00035#1-s
                           CASE
                              WHEN g_apba_d[l_ac].apba004 = '10' #10:採購單
                                 #170110-00035#1 mark ------
                                 #LET l_wc = "pmdldocno = '",g_apba_d[l_ac].apba005,"' AND pmdm001 = '",g_apba_d[l_ac].apba006,"'"
                                 #CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                                 #170110-00035#1 mark end---
                                 #170110-00035#1 add ------
                                 IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                                    LET l_wc = "pmdldocno = '",g_apba_d[l_ac].apba005,"' AND pmdm001 = '",g_apba_d[l_ac].apba020,"'"
                                    LET l_wc2 = "pmdnseq = ",g_apba_d[l_ac].apba006
                                    CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,l_wc2)RETURNING g_sub_success
                                 #170110-00035#1 add end---
                                    IF NOT g_sub_success THEN
                                       CALL s_transaction_end('N','0')
                                    ELSE
                                       CALL s_transaction_end('Y','0')
                                    END IF
                                    LET l_apba_flag = 'Y'
                                    LET l_flag = 'Y'
                                    EXIT DIALOG
                                 END IF #170110-00035#1
                              WHEN g_apba_d[l_ac].apba004 = '27' #27:其他待抵單
                                 IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                                    LET l_wc = "apccdocno = '",g_apba_d[l_ac].apba005,"' AND apccseq = '",g_apba_d[l_ac].apba006,"' AND apcc001 = '",g_apba_d[l_ac].apba020,"'"
                                    CALL s_aapt110_auto_ins_27(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                                    IF NOT g_sub_success THEN
                                       CALL s_transaction_end('N','0')
                                    ELSE
                                       CALL s_transaction_end('Y','0')
                                    END IF
                                    LET l_apba_flag = 'Y'
                                    LET l_flag = 'Y'
                                    EXIT DIALOG
                                 END IF
                              OTHERWISE
                           #160705-00035#1-e
                                 CALL aapt110_qbevalue_show(l_ac,g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba004)
                                 #數量(含已開數量+aapt110已新增單據)不能大於計價數量
                                 IF g_apba_d[l_ac].apba004 = '11' or g_apba_d[l_ac].apba004 = '20' or g_apba_d[l_ac].apba004 = '21' THEN
                                    #取得總數量&已開發票數量
                                    #SELECT pmdt024,pmdt069 INTO l_pmdt024,l_pmdt069                                 #161129-00024#1 mark
                                    SELECT pmdt024,pmdt069,pmdt036 INTO l_pmdt024,l_pmdt069,g_apba_d[l_ac].l_pmdt036 #161129-00024#1 add
                                      FROM pmdt_t
                                     WHERE pmdtent = g_enterprise
                                       AND pmdtdocno = g_apba_d[l_ac].apba005
                                       AND pmdtseq = g_apba_d[l_ac].apba006
                                    IF cl_null(l_pmdt024) THEN LET l_pmdt024 = 0 END IF
                                    IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF
                                    IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF #161129-00024#1 add
                                    #取得已開發票數量(單據未確認的部份)
                                    SELECT SUM(apba010) INTO l_sum_apba010
                                      FROM apba_t
                                      LEFT JOIN apbb_t ON apbaent = apbbent AND apbadocno = apbbdocno
                                     WHERE apbaent = g_enterprise
                                       AND apba005 = g_apba_d[l_ac].apba005
                                       AND apba006 = g_apba_d[l_ac].apba006
                                       AND apbadocno <> g_apbb_m.apbbdocno
                                       AND apbbstus = 'N'
                                    IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
                                    LET l_used_apba010 = g_apba_d[l_ac].apba010 + l_pmdt069 + l_sum_apba010
                                    #IF l_used_apba010 > l_pmdt024 THEN                           #160314-00005#1 mark
                                     IF l_used_apba010 > l_pmdt024 OR l_pmdt069 = l_pmdt024 THEN  #160314-00005#1
                                       INITIALIZE g_errparam TO NULL
                                       LET g_errparam.code = 'ais-00133'
                                       LET g_errparam.extend = ''
                                       LET g_errparam.popup = TRUE
                                       CALL cl_err()
                                       LET g_apba_d[l_ac].apba010 = g_apba_d_t.apba010
                                       NEXT FIELD apba010
                                    END IF
                                 END IF
                           END CASE  #160705-00035#1 
                        END IF
                        #161129-00024#1 add s---
                        IF g_apba_d[l_ac].apba004 = '10' THEN #10:採購單
                           SELECT pmdn015 INTO g_apba_d[l_ac].l_pmdt036 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_apba_d[l_ac].apba005 AND pmdnseq = g_apba_d[l_ac].apba006
                           IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
                           DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036 
                        END IF 
                        IF g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23' THEN  
                           SELECT rtib010 INTO g_apba_d[l_ac].l_pmdt036 FROM rtib_t WHERE rtibent = g_enterprise AND rtibdocno = g_apba_d[l_ac].apba005 AND rtibseq = g_apba_d[l_ac].apba006
                           IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
                           DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036  
                        END IF                         
                        #161129-00024#1 add e---                         
                     ELSE
                        CALL aapt110_apba005_chk()    
                        IF NOT cl_null(g_errno) THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005 #160726-00020#7 Mark
                           #LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006 #160726-00020#7 Mark
                           LET g_apba_d[l_ac].apba005 = g_apba_d_o.apba005  #160726-00020#7
                           LET g_apba_d[l_ac].apba006 = g_apba_d_o.apba006  #160726-00020#7
                           NEXT FIELD apba005
                        END IF 
                        CALL aapt110_qbevalue_show_1(l_ac,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006)
                     END IF
                     #160826-00017#1   add---s
                     #單身金額合計
                     LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012) 
                     LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                     DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                     g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                     #160826-00017#1   add---e
                  END IF
               END IF
               LET g_apba_d_o.apba005 = g_apba_d[l_ac].apba005  #160726-00020#7
               LET g_apba_d_o.apba006 = g_apba_d[l_ac].apba006  #160726-00020#7
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba005
            #add-point:ON CHANGE apba005 name="input.g.page1.apba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba006
            #add-point:BEFORE FIELD apba006 name="input.b.page1.apba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba006
            
            #add-point:AFTER FIELD apba006 name="input.a.page1.apba006"
            IF NOT cl_null(g_apba_d[l_ac].apba006) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba006) OR g_apba_d[l_ac].apba006 != g_apba_d_t.apba006) OR cl_null(g_apba_d_t.apba006))) THEN
                  IF NOT cl_null(g_apba_d[l_ac].apba005) THEN
                     IF g_apbb_m.apbb056 = 'N' THEN  #20150601 add lujh
                        #160705-00035#1-s
                        IF g_apba_d[l_ac].apba004 = '27' THEN #27:其他待抵單
                           IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                              #檢查輸入的單號&項次&期別是否存在
                              CALL s_aapt420_exist_chk('41',g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbb002,g_apbb_m.apbbdocno)
                                   RETURNING g_sub_success,g_errno
                              IF NOT g_sub_success THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = g_errno
                                 LET g_errparam.extend = ''
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                                 LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                                 LET g_apba_d[l_ac].apba020 = g_apba_d_t.apba020
                                 DISPLAY BY NAME g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020
                                 NEXT FIELD CURRENT
                              END IF
                              #檢核金額不可超出可沖金額
                              CALL s_aapt420_apcc_used_num('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbbdocno,' ','1')
                                   RETURNING g_sub_success,g_errno,l_apce.apce109,l_apce.apce119,l_apce.apce129,l_apce.apce139
                              CALL s_aapt420_apcc_used_chk('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,
                                   l_apce.apce109,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq,'1','0')
                                   RETURNING g_sub_success,g_errno
                              IF NOT g_sub_success THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = g_errno
                                 LET g_errparam.extend = ''
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 LET g_apba_d[l_ac].apba103 = g_apba_d_t.apba103
                                 DISPLAY BY NAME g_apba_d[l_ac].apba103
                                 NEXT FIELD CURRENT
                              END IF
                           END IF
                        ELSE
                        #160705-00035#1-e
                           #檢查輸入的單號&項次是否存在
                           CALL s_aapt300_source_doc_chk(g_apbb_m.apbbcomp,g_apbb_m.apbb004,g_apbb_m.apbb002,g_apba_d[l_ac].apba004,
                                                         g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apbb_m.apbbdocdt,g_ld)
                                RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                              LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                              LET g_apba_d[l_ac].apba020 = g_apba_d_t.apba020  #170110-00035#1
                              NEXT FIELD apba005
                           END IF
                        END IF #160705-00035#1
                        #若為11/20/21要在作檢查
                        IF g_apba_d[l_ac].apba004 = 11 OR g_apba_d[l_ac].apba004 MATCHES '2[01]' THEN
                           CALL aapt110_source_doc_chk() RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                              LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                              NEXT FIELD apba005
                           END IF
                        END IF
                        #檢查是否重key單
                        SELECT COUNT(*) INTO l_cnt
                          FROM apba_t 
                         WHERE apbaent = g_enterprise
                           AND apbadocno = g_apbb_m.apbbdocno
                           AND apba005 = g_apba_d[l_ac].apba005
                           AND apba006 = g_apba_d[l_ac].apba006
                           AND apbaseq <> g_apba_d[l_ac].apbaseq
                        IF l_cnt > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'asf-00408'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apba_d[l_ac].apba005 = ''
                           LET g_apba_d[l_ac].apba006 = ''
                           LET g_apba_d[l_ac].apba020 = ''  #170110-00035#1
                           LET g_apba_d[l_ac].apba007 = ''
                           LET g_apba_d[l_ac].apba008 = ''
                           LET g_apba_d[l_ac].apba013 = ''
                           LET g_apba_d[l_ac].apba015 = ''
                           LET g_apba_d[l_ac].apba100 = ''
                           LET g_apba_d[l_ac].apba009 = ''
                           LET g_apba_d[l_ac].apba014 = 0
                           LET g_apba_d[l_ac].apba010 = 0
                           LET g_apba_d[l_ac].apba113 = 0
                           LET g_apba_d[l_ac].apba115 = 0
                           LET g_apba_d[l_ac].apba114 = 0
                           NEXT FIELD apba005
                        ELSE
                           IF g_apba_d[l_ac].apba004 <> '19' or g_apba_d[l_ac].apba004 <> '29' THEN
                              #160705-00035#1-s
                              CASE
                                 WHEN g_apba_d[l_ac].apba004 = '10' #10:採購單
                                    #170110-00035#1 mark ------
                                    #LET l_wc = "pmdldocno = '",g_apba_d[l_ac].apba005,"' AND pmdm001 = '",g_apba_d[l_ac].apba006,"'"
                                    #CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                                    #170110-00035#1 mark end---
                                    #170110-00035#1 add ------
                                    IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                                       LET l_wc = "pmdldocno = '",g_apba_d[l_ac].apba005,"' AND pmdm001 = '",g_apba_d[l_ac].apba020,"'"
                                       LET l_wc2 = "pmdnseq = ",g_apba_d[l_ac].apba006
                                       CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,l_wc2)RETURNING g_sub_success
                                    #170110-00035#1 add end---
                                       IF NOT g_sub_success THEN
                                          CALL s_transaction_end('N','0')
                                       ELSE
                                          CALL s_transaction_end('Y','0')
                                       END IF
                                       LET l_apba_flag = 'Y'
                                       LET l_flag = 'Y'
                                       EXIT DIALOG
                                    END IF #170110-00035#1
                                 WHEN g_apba_d[l_ac].apba004 = '27' #27:其他待抵單
                                    IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
                                       LET l_wc = "apccdocno = '",g_apba_d[l_ac].apba005,"' AND apccseq = '",g_apba_d[l_ac].apba006,"' AND apcc001 = '",g_apba_d[l_ac].apba020,"'"
                                       CALL s_aapt110_auto_ins_27(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                                       IF NOT g_sub_success THEN
                                          CALL s_transaction_end('N','0')
                                       ELSE
                                          CALL s_transaction_end('Y','0')
                                       END IF
                                       LET l_apba_flag = 'Y'
                                       LET l_flag = 'Y'
                                       EXIT DIALOG
                                    END IF
                                 OTHERWISE
                              #160705-00035#1-e
                                    CALL aapt110_qbevalue_show(l_ac,g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba004)
                                    #數量(含已開數量+aapt110已新增單據)不能大於計價數量
                                    IF g_apba_d[l_ac].apba004 = '11' or g_apba_d[l_ac].apba004 = '20' or g_apba_d[l_ac].apba004 = '21' THEN
                                       #SELECT pmdt024,pmdt069 INTO l_pmdt024,l_pmdt069                                  #161129-00024#1 mark
                                       SELECT pmdt024,pmdt069,pmdt036 INTO l_pmdt024,l_pmdt069,g_apba_d[l_ac].l_pmdt036  #161129-00024#1 add
                                         FROM pmdt_t
                                        WHERE pmdtent = g_enterprise
                                          AND pmdtdocno = g_apba_d[l_ac].apba005
                                          AND pmdtseq = g_apba_d[l_ac].apba006
                                       IF cl_null(l_pmdt024) THEN LET l_pmdt024 = 0 END IF
                                       IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF
                                       IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF #161129-00024#1 add
                                       SELECT SUM(apba010) INTO l_sum_apba010
                                         FROM apba_t
                                         LEFT JOIN apbb_t ON apbaent = apbbent AND apbadocno = apbbdocno
                                        WHERE apbaent = g_enterprise
                                          AND apba005 = g_apba_d[l_ac].apba005
                                          AND apba006 = g_apba_d[l_ac].apba006
                                          AND apbadocno <> g_apbb_m.apbbdocno
                                          AND apbbstus = 'N'
                                       IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
                                       LET l_used_apba010 = g_apba_d[l_ac].apba010 + l_pmdt069 + l_sum_apba010
                                      #IF l_used_apba010 > l_pmdt024 THEN                           #160314-00005#1 mark
                                       IF l_used_apba010 > l_pmdt024 OR l_pmdt069 = l_pmdt024 THEN  #160314-00005#1
                                          INITIALIZE g_errparam TO NULL
                                          LET g_errparam.code = 'ais-00133'
                                          LET g_errparam.extend = ''
                                          LET g_errparam.popup = TRUE
                                          CALL cl_err()
                                          LET g_apba_d[l_ac].apba010 = g_apba_d_t.apba010
                                          NEXT FIELD apba010
                                       END IF
                                    END IF
                              END CASE  #160705-00035#1
                           END IF
                           #161129-00024#1 add s---
                           IF g_apba_d[l_ac].apba004 = '10' THEN #10:採購單
                              SELECT pmdn015 INTO g_apba_d[l_ac].l_pmdt036 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_apba_d[l_ac].apba005 AND pmdnseq = g_apba_d[l_ac].apba006
                              IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
                              DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036                               
                           END IF  
                           IF g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23' THEN  
                              SELECT rtib010 INTO g_apba_d[l_ac].l_pmdt036 FROM rtib_t WHERE rtibent = g_enterprise AND rtibdocno = g_apba_d[l_ac].apba005 AND rtibseq = g_apba_d[l_ac].apba006
                              IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
                              DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036  
                           END IF   
                           #161129-00024#1 add e---                            
                        END IF
                     #20150601--add--str--lujh
                     ELSE
                        CALL aapt110_apba005_chk()    
                        IF NOT cl_null(g_errno) THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                           LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                           NEXT FIELD apba005
                        END IF               
                        CALL aapt110_qbevalue_show_1(l_ac,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006)                        
                     END IF
                     #20150601--add--end--lujh
                  END IF
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012) 
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba006
            #add-point:ON CHANGE apba006 name="input.g.page1.apba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba020
            #add-point:BEFORE FIELD apba020 name="input.b.page1.apba020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba020
            
            #add-point:AFTER FIELD apba020 name="input.a.page1.apba020"
            #160705-00035#1 -s
            IF NOT cl_null(g_apba_d[l_ac].apba020) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba020) OR g_apba_d[l_ac].apba020 != g_apba_d_t.apba020) OR cl_null(g_apba_d_t.apba020))) THEN
                  IF NOT cl_null(g_apba_d[l_ac].apba005) AND NOT cl_null(g_apba_d[l_ac].apba006) THEN
                     #170110-00035#1 add ------
                     CASE
                        WHEN g_apba_d[l_ac].apba004 = '10' #10:採購單
                           #檢查輸入的單號&項次是否存在
                           CALL s_aapt300_source_doc_chk(g_apbb_m.apbbcomp,g_apbb_m.apbb004,g_apbb_m.apbb002,g_apba_d[l_ac].apba004,
                                                         g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apbb_m.apbbdocdt,g_ld)
                                RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                              LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                              LET g_apba_d[l_ac].apba020 = g_apba_d_t.apba020
                              NEXT FIELD apba005
                           END IF
                        WHEN g_apba_d[l_ac].apba004 = '27' #27:其他待抵單
                     #170110-00035#1 add end---
                           #檢查輸入的單號&項次&期別是否存在
                           CALL s_aapt420_exist_chk('41',g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbb002,g_apbb_m.apbbdocno)
                                RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apba_d[l_ac].apba005 = g_apba_d_t.apba005
                              LET g_apba_d[l_ac].apba006 = g_apba_d_t.apba006
                              LET g_apba_d[l_ac].apba020 = g_apba_d_t.apba020
                              DISPLAY BY NAME g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020
                              NEXT FIELD CURRENT
                           END IF
                           #檢核金額不可超出可沖金額
                           CALL s_aapt420_apcc_used_num('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,g_apbb_m.apbbdocno,' ','1')
                                RETURNING g_sub_success,g_errno,l_apce.apce109,l_apce.apce119,l_apce.apce129,l_apce.apce139
                           CALL s_aapt420_apcc_used_chk('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,
                                l_apce.apce109,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq,'1','0')
                                RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              LET g_apba_d[l_ac].apba103 = g_apba_d_t.apba103
                              DISPLAY BY NAME g_apba_d[l_ac].apba103
                              NEXT FIELD CURRENT
                           END IF
                     END CASE #170110-00035#1
                     #檢查是否重key單
                     SELECT COUNT(*) INTO l_cnt
                       FROM apba_t
                      WHERE apbaent = g_enterprise
                        AND apbadocno = g_apbb_m.apbbdocno
                        AND apba005 = g_apba_d[l_ac].apba005
                        AND apba006 = g_apba_d[l_ac].apba006
                        AND apba020 = g_apba_d[l_ac].apba020
                        AND apbaseq <> g_apba_d[l_ac].apbaseq
                     IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00408'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba_d[l_ac].apba005 = ''
                        LET g_apba_d[l_ac].apba006 = ''
                        LET g_apba_d[l_ac].apba020 = ''  #170110-00035#1
                        LET g_apba_d[l_ac].apba007 = ''
                        LET g_apba_d[l_ac].apba008 = ''
                        LET g_apba_d[l_ac].apba013 = ''
                        LET g_apba_d[l_ac].apba015 = ''
                        LET g_apba_d[l_ac].apba100 = ''
                        LET g_apba_d[l_ac].apba009 = ''
                        LET g_apba_d[l_ac].apba014 = 0
                        LET g_apba_d[l_ac].apba010 = 0
                        LET g_apba_d[l_ac].apba113 = 0
                        LET g_apba_d[l_ac].apba115 = 0
                        LET g_apba_d[l_ac].apba114 = 0
                        NEXT FIELD apba005
                     END IF
                     IF g_apba_d[l_ac].apba004 = '27' THEN #27:其他待抵單
                        LET l_wc = "apccdocno = '",g_apba_d[l_ac].apba005,"' AND apccseq = '",g_apba_d[l_ac].apba006,"' AND apcc001 = '",g_apba_d[l_ac].apba020,"'"
                        CALL s_aapt110_auto_ins_27(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL s_transaction_end('Y','0')
                        END IF
                        LET l_apba_flag = 'Y'
                        LET l_flag = 'Y'
                        EXIT DIALOG
                     END IF
                     #170110-00035#1 add ------
                     IF g_apba_d[l_ac].apba004 = '10' THEN #10:採購單
                        LET l_wc = "pmdldocno = '",g_apba_d[l_ac].apba005,"' AND pmdm001 = '",g_apba_d[l_ac].apba020,"'"
                        LET l_wc2 = "pmdnseq = ",g_apba_d[l_ac].apba006
                        CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,l_wc2)RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL s_transaction_end('Y','0')
                        END IF
                        LET l_apba_flag = 'Y'
                        LET l_flag = 'Y'
                        EXIT DIALOG
                        SELECT pmdn015 INTO g_apba_d[l_ac].l_pmdt036 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_apba_d[l_ac].apba005 AND pmdnseq = g_apba_d[l_ac].apba006
                        IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
                        DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036
                     END IF
                     #170110-00035#1 add end---
                  END IF
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012) 
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            #160705-00035#1 -e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba020
            #add-point:ON CHANGE apba020 name="input.g.page1.apba020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba019
            #add-point:BEFORE FIELD apba019 name="input.b.page1.apba019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba019
            
            #add-point:AFTER FIELD apba019 name="input.a.page1.apba019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba019
            #add-point:ON CHANGE apba019 name="input.g.page1.apba019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba012
            #add-point:BEFORE FIELD apba012 name="input.b.page1.apba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba012
            
            #add-point:AFTER FIELD apba012 name="input.a.page1.apba012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba012
            #add-point:ON CHANGE apba012 name="input.g.page1.apba012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba014
            #add-point:BEFORE FIELD apba014 name="input.b.page1.apba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba014
            
            #add-point:AFTER FIELD apba014 name="input.a.page1.apba014"
            IF NOT cl_null(g_apba_d[l_ac].apba014) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba014) OR g_apba_d[l_ac].apba014 != g_apba_d_t.apba014) OR cl_null(g_apba_d_t.apba014))) THEN
                  
                  IF g_apba_d[l_ac].apba014 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00042'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba014 = g_apba_d_t.apba014
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_apba_d[l_ac].apba010) THEN LET g_apba_d[l_ac].apba010 = 0 END IF
                  #單價取位 Reanna 15/02/03
                  CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #重新計算金額
                  #160802-00049#1-s
                  LET l_money = g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010
                  CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
                  #160802-00049#1-e
                 #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #1160802-00049#1 mark
                  CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
                  RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                           ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  DISPLAY BY NAME g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012) 
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
                  IF p_cmd = 'u' THEN
                     #若為紅字發票，需檢核扣抵藍字發票的總額夠不夠扣
                     IF g_apbb_m.apbb050 = "2" AND NOT cl_null(g_apba_d[l_ac].apba017) THEN
                        CALL aapt110_invoice_debit_chk() RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apba_d[l_ac].apba014 = g_apba_d_t.apba014
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba014
            #add-point:ON CHANGE apba014 name="input.g.page1.apba014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba010
            #add-point:BEFORE FIELD apba010 name="input.b.page1.apba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba010
            
            #add-point:AFTER FIELD apba010 name="input.a.page1.apba010"
            IF NOT cl_null(g_apba_d[l_ac].apba010) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba010) OR g_apba_d[l_ac].apba010 != g_apba_d_t.apba010) OR cl_null(g_apba_d_t.apba010))) THEN
                  #數量不可為負
                  IF g_apba_d[l_ac].apba010 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00041'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba010 = g_apba_d_t.apba010
                     NEXT FIELD CURRENT
                  END IF
                  #數量(含已開數量+aapt110已新增單據)不能大於計價數量
                  IF g_apba_d[l_ac].apba004 = '11' or g_apba_d[l_ac].apba004 = '20' or g_apba_d[l_ac].apba004 = '21' THEN
                     SELECT pmdt024,pmdt069 INTO l_pmdt024,l_pmdt069
                       FROM pmdt_t
                      WHERE pmdtent = g_enterprise
                        AND pmdtdocno = g_apba_d[l_ac].apba005
                        AND pmdtseq = g_apba_d[l_ac].apba006
                     IF cl_null(l_pmdt024) THEN LET l_pmdt024 = 0 END IF
                     IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF
                     SELECT SUM(apba010) INTO l_sum_apba010
                       FROM apba_t
                       LEFT JOIN apbb_t ON apbaent = apbbent AND apbadocno = apbbdocno
                      WHERE apbaent = g_enterprise
                        AND apba005 = g_apba_d[l_ac].apba005
                        AND apba006 = g_apba_d[l_ac].apba006
                        #AND apbadocno <> g_apbb_m.apbbdocno   #20150317 mark
                        #20150317--add--str--
                        AND ((apbadocno = g_apbb_m.apbbdocno AND apbaseq <> g_apba_d[l_ac].apbaseq)
                              OR apbadocno <> g_apbb_m.apbbdocno)
                        #20150317--add--end--
                        AND apbbstus = 'N'
                     IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
                     LET l_used_apba010 = g_apba_d[l_ac].apba010 + l_pmdt069 + l_sum_apba010
                     #IF l_used_apba010 > l_pmdt024 THEN                           #160314-00005#1 mark
                      IF l_used_apba010 > l_pmdt024 OR l_pmdt069 = l_pmdt024 THEN  #160314-00005#1
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00133'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba_d[l_ac].apba010 = g_apba_d_t.apba010
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  IF cl_null(g_apba_d[l_ac].apba014) THEN LET g_apba_d[l_ac].apba014 = 0 END IF
                  #單價取位 Reanna 15/02/03
                  CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #重新計算金額
                  #160802-00049#1-s
                  LET l_money = g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010
                  CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
                  #160802-00049#1-e
                 #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
                  CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
                  RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                            g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  DISPLAY BY NAME g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115                           
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
                  IF p_cmd = 'u' THEN
                     #若為紅字發票，需檢核扣抵藍字發票的總額夠不夠扣
                     IF g_apbb_m.apbb050 = "2" AND NOT cl_null(g_apba_d[l_ac].apba017) THEN
                        CALL aapt110_invoice_debit_chk() RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apba_d[l_ac].apba010 = g_apba_d_t.apba010
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
               
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba010
            #add-point:ON CHANGE apba010 name="input.g.page1.apba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba103
            #add-point:BEFORE FIELD apba103 name="input.b.page1.apba103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba103
            
            #add-point:AFTER FIELD apba103 name="input.a.page1.apba103"
            #原幣未稅金額
            IF NOT cl_null(g_apba_d[l_ac].apba103) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba103) OR g_apba_d[l_ac].apba103 != g_apba_d_t.apba103) OR cl_null(g_apba_d_t.apba103))) THEN
                  #IF cl_null(g_apba_d[l_ac].apba014) THEN LET g_apba_d[l_ac].apba014 = 0 END IF
                  #IF cl_null(g_apba_d[l_ac].apba010) THEN LET g_apba_d[l_ac].apba010 = 0 END IF
                  ##單價取位 Reanna 15/02/03
                  #CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #IF p_cmd = 'a' THEN
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                  #            ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #ELSE
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING l_apba103,l_apba104,l_apba105
                  #            ,l_apba113,l_apba114,l_apba115
                  #   #確認金額是否符合單價*數量的錢
                  #   #141217carol:單頭稅別若未稅則檢查未稅金額,含稅則檢查含稅金額
                  #   IF (g_apbb_m.apbb0121 = 'N' AND (g_apba_d[l_ac].apba103 <> l_apba103)) OR (g_apba_d[l_ac].apba104 <> l_apba104) OR
                  #      (g_apbb_m.apbb0121 = 'Y' AND (g_apba_d[l_ac].apba105 <> l_apba105)) THEN
                  #      INITIALIZE g_errparam TO NULL
                  #      LET g_errparam.code = 'aap-00188'
                  #      LET g_errparam.extend = ''
                  #      LET g_errparam.popup = TRUE
                  #      CALL cl_err()
#141217 carol:只提#示,不強制控卡                        
#                 #       LET g_apba_d[l_ac].apba103 = g_apba_d_t.apba103
#                 #       NEXT FIELD CURRENT
                  #   END IF
                  #END IF
                  #160705-00035#1 -s
                  IF g_apba_d[l_ac].apba004 = '27' THEN
                     #檢核金額不可超出可沖金額
                     CALL s_aapt420_apcc_used_chk('41',g_ld,g_ld,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020,
                     g_apba_d[l_ac].apba103,g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq,'1','0')
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba_d[l_ac].apba103 = g_apba_d_t.apba103
                        DISPLAY BY NAME g_apba_d[l_ac].apba103
                        NEXT FIELD CURRENT
                     END IF
                  #160705-00035#5 mark ------
                  #   LET g_apba_d[l_ac].apba014 = g_apba_d[l_ac].apba103 #單價
                  #   LET g_apba_d[l_ac].apba105 = g_apba_d[l_ac].apba103 #原幣含稅金額
                  #   LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba103 * g_apba_d[l_ac].l_apcc102 #本幣未稅金額
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba113,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba113
                  #   LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba113 #本幣含稅金額
                  #ELSE
                  #160705-00035#5 mark end---
                  END IF #160705-00035#5
                  #160705-00035#1 -e
                  
                  #160705-00035#5 -s
                  IF g_apbb_m.apbb0121 = 'N' THEN
                     #重新計算金額
                     CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba103,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba103
                     IF g_apba_d[l_ac].apba004 = '27' THEN
                        CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apba_d[l_ac].l_apcc102)
                        RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                     ELSE
                        CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                        RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                     END IF
                     #LET g_apba_d[l_ac].apba014 = g_apba_d[l_ac].apba103 #170117-00030#1 mark
                     #170117-00030#1 --s add
                     LET g_apba_d[l_ac].apba014 = g_apba_d[l_ac].apba103 / g_apba_d[l_ac].apba010
                     CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                     #170117-00030#1 --e add
                  ELSE
                  #160705-00035#5 -e
                     #150422-00026#1 add ---
                     LET g_apba_d[l_ac].apba104 = g_apba_d[l_ac].apba105 - g_apba_d[l_ac].apba103
                     
                     IF g_apba_d[l_ac].apba111 = 1 THEN
                        LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba103
                        LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104
                     ELSE
                        #160705-00035#5 -s
                        IF g_apba_d[l_ac].apba004 = '27' THEN
                           LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba103 * g_apba_d[l_ac].l_apcc102
                        ELSE
                        #160705-00035#5 -e
                           LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba111
                        END IF #160705-00035#5
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba113,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba113
                        LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba115 - g_apba_d[l_ac].apba113
                     END IF
                     #150422-00026#1 end ---
                  END IF #160705-00035#1
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba103
            #add-point:ON CHANGE apba103 name="input.g.page1.apba103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba105
            #add-point:BEFORE FIELD apba105 name="input.b.page1.apba105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba105
            
            #add-point:AFTER FIELD apba105 name="input.a.page1.apba105"
            #原幣含稅金額
            IF NOT cl_null(g_apba_d[l_ac].apba105) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba105) OR g_apba_d[l_ac].apba105 != g_apba_d_t.apba105) OR cl_null(g_apba_d_t.apba105))) THEN
                  #IF cl_null(g_apba_d[l_ac].apba014) THEN LET g_apba_d[l_ac].apba014 = 0 END IF
                  #IF cl_null(g_apba_d[l_ac].apba010) THEN LET g_apba_d[l_ac].apba010 = 0 END IF
                  ##單價取位 Reanna 15/02/03
                  #CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #IF p_cmd = 'a' THEN
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                  #            ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #ELSE
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING l_apba103,l_apba104,l_apba105
                  #            ,l_apba113,l_apba114,l_apba115
                  #   #確認金額是否符合單價*數量的錢
                  #   #141217carol:單頭稅別若未稅則檢查未稅金額,含稅則檢查含稅金額
                  #   IF (g_apbb_m.apbb0121 = 'N' AND (g_apba_d[l_ac].apba103 <> l_apba103)) OR (g_apba_d[l_ac].apba104 <> l_apba104) OR
                  #      (g_apbb_m.apbb0121 = 'Y' AND (g_apba_d[l_ac].apba105 <> l_apba105)) THEN
                  #      INITIALIZE g_errparam TO NULL
                  #      INITIALIZE g_errparam TO NULL
                  #      LET g_errparam.code = 'aap-00188'
                  #      LET g_errparam.extend = ''
                  #      LET g_errparam.popup = TRUE
                  #      CALL cl_err()
#141217 carol:只提#示,不強制控卡
#                 #       LET g_apba_d[l_ac].apba105 = g_apba_d_t.apba105
#                 #       NEXT FIELD CURRENT
                  #   END IF
                  #END IF
                  
                  #160705-00035#5 -s
                  IF g_apbb_m.apbb0121 = 'Y' THEN
                     #重新計算金額
                     CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba105,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba105
                     IF g_apba_d[l_ac].apba004 = '27' THEN
                        CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba_d[l_ac].apba105,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apba_d[l_ac].l_apcc102)
                        RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                     ELSE
                        CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba_d[l_ac].apba105,g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                        RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105,
                                  g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                     END IF
                     #LET g_apba_d[l_ac].apba014 = g_apba_d[l_ac].apba105 #170117-00030#1 mark
                     #170117-00030#1 --s add
                     LET g_apba_d[l_ac].apba014 = g_apba_d[l_ac].apba105 / g_apba_d[l_ac].apba010
                     CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                     #170117-00030#1 --e add                     
                  ELSE
                  #160705-00035#5 -e
                     #150422-00026#1 add ---
                     LET g_apba_d[l_ac].apba104 = g_apba_d[l_ac].apba105 - g_apba_d[l_ac].apba103
                     IF g_apba_d[l_ac].apba111 = 1 THEN
                        LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba105
                        LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104
                     ELSE
                        #160705-00035#5 -s
                        IF g_apba_d[l_ac].apba004 = '27' THEN
                           LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba105 * g_apba_d[l_ac].l_apcc102
                        ELSE
                        #160705-00035#5 -e
                           LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba111
                        END IF #160705-00035#5
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba115,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba115
                        LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba115 - g_apba_d[l_ac].apba113
                     END IF
                     #150422-00026#1 end ---
                  END IF  #160705-00035#5
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba105
            #add-point:ON CHANGE apba105 name="input.g.page1.apba105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba104
            #add-point:BEFORE FIELD apba104 name="input.b.page1.apba104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba104
            
            #add-point:AFTER FIELD apba104 name="input.a.page1.apba104"
            IF NOT cl_null(g_apba_d[l_ac].apba104) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba104) OR g_apba_d[l_ac].apba104 != g_apba_d_t.apba104) OR cl_null(g_apba_d_t.apba104))) THEN
                  #檢核容差率
                  CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105)
                       RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                  #容差率OK否
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba104 = g_apba_d_t.apba104
                     NEXT FIELD CURRENT
                  ELSE
                     ##容差率OK要更新本幣金額
                     #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                     #RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                     #         ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                     
                     #150422-00026#1 add ---
                     #容差率OK更新本幣金額
                     IF g_apba_d[l_ac].apba111 = 1 THEN
                        LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba103
                        LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104
                        LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba105
                     ELSE
                        #160705-00035#5 -s
                        IF g_apba_d[l_ac].apba004 = '27' THEN
                           #待抵要用待抵單的匯率乘算
                           LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104 * g_apba_d[l_ac].l_apcc102
                        ELSE
                           LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba111
                        END IF
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba114,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba114
                        #160705-00035#5 -e
                        IF g_apbb_m.apbb0121 = "Y" THEN
                           #LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba111                                             #160705-00035#5 mark
                           #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba114,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba114 #160705-00035#5 mark
                           LET g_apba_d[l_ac].apba113 = g_apba_d[l_ac].apba115 - g_apba_d[l_ac].apba114
                        ELSE
                           #LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba104  * g_apba_d[l_ac].apba111                                            #160705-00035#5 mark
                           #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba_d[l_ac].apba114,2) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba114 #160705-00035#5 mark
                           LET g_apba_d[l_ac].apba115 = g_apba_d[l_ac].apba113 + g_apba_d[l_ac].apba114
                        END IF
                     END IF
                     #150422-00026#1 end ---
                     #160826-00017#1   add---s
                     #單身金額合計
                     LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                     LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                     DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                     g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                     #160826-00017#1   add---e
                  END IF
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba104
            #add-point:ON CHANGE apba104 name="input.g.page1.apba104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba113
            #add-point:BEFORE FIELD apba113 name="input.b.page1.apba113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba113
            
            #add-point:AFTER FIELD apba113 name="input.a.page1.apba113"
            #本幣未稅金額
            IF NOT cl_null(g_apba_d[l_ac].apba113) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba113) OR g_apba_d[l_ac].apba113 != g_apba_d_t.apba113) OR cl_null(g_apba_d_t.apba113))) THEN
                  #IF cl_null(g_apba_d[l_ac].apba014) THEN LET g_apba_d[l_ac].apba014 = 0 END IF
                  #IF cl_null(g_apba_d[l_ac].apba010) THEN LET g_apba_d[l_ac].apba010 = 0 END IF
                  ##單價取位 Reanna 15/02/03
                  #CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #IF p_cmd = 'a' THEN
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                  #            ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #ELSE
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING l_apba103,l_apba104,l_apba105
                  #            ,l_apba113,l_apba114,l_apba115
#141217 carol:只需#檢核原幣                               
#                 #    #確認金額是否符合單價*數量的錢
#                 #    IF (g_apba_d[l_ac].apba113 <> l_apba113) OR (g_apba_d[l_ac].apba114 <> l_apba114) OR (g_apba_d[l_ac].apba115 <> l_apba115) THEN
#                 #       INITIALIZE g_errparam TO NULL
#                 #       LET g_errparam.code = 'aap-00188'
#                 #       LET g_errparam.extend = ''
#                 #       LET g_errparam.popup = TRUE
#                 #       CALL cl_err()
#                 #       LET g_apba_d[l_ac].apba113 = g_apba_d_t.apba113
#                 #       NEXT FIELD CURRENT
#                 #    END IF
                  #END IF
                  
                  #150422-00026#1 add ---
                  LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba115 - g_apba_d[l_ac].apba113

                  #匯率>>2.以含稅金額重計匯率
                  LET g_apba_d[l_ac].apba111 = g_apba_d[l_ac].apba115 / g_apba_d[l_ac].apba105
                  #150422-00026#1 end ---
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba113
            #add-point:ON CHANGE apba113 name="input.g.page1.apba113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba115
            #add-point:BEFORE FIELD apba115 name="input.b.page1.apba115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba115
            
            #add-point:AFTER FIELD apba115 name="input.a.page1.apba115"
            #本幣含稅金額
            IF NOT cl_null(g_apba_d[l_ac].apba115) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba115) OR g_apba_d[l_ac].apba115 != g_apba_d_t.apba115) OR cl_null(g_apba_d_t.apba115))) THEN
                  #IF cl_null(g_apba_d[l_ac].apba014) THEN LET g_apba_d[l_ac].apba014 = 0 END IF
                  #IF cl_null(g_apba_d[l_ac].apba010) THEN LET g_apba_d[l_ac].apba010 = 0 END IF
                  ##單價取位 Reanna 15/02/03
                  #CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[l_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba014
                  #IF p_cmd = 'a' THEN
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba105
                  #            ,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #ELSE
                  #   #重新計算金額
                  #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[l_ac].apba014*g_apba_d[l_ac].apba010),g_apba_d[l_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
                  #   RETURNING l_apba103,l_apba104,l_apba105
                  #            ,l_apba113,l_apba114,l_apba115
#141217 carol:只需#檢核原幣                              
#                 #    #確認金額是否符合單價*數量的錢
#                 #    IF (g_apba_d[l_ac].apba113 <> l_apba113) OR (g_apba_d[l_ac].apba114 <> l_apba114) OR (g_apba_d[l_ac].apba115 <> l_apba115) THEN
#                 #       INITIALIZE g_errparam TO NULL
#                 #       LET g_errparam.code = 'aap-00188'
#                 #       LET g_errparam.extend = ''
#                 #       LET g_errparam.popup = TRUE
#                 #       CALL cl_err()
#                 #       LET g_apba_d[l_ac].apba115 = g_apba_d_t.apba115
#                 #       NEXT FIELD CURRENT
#                 #    END IF
                  #END IF
                  
                  #150422-00026#1 add ---
                  LET g_apba_d[l_ac].apba114 = g_apba_d[l_ac].apba115 - g_apba_d[l_ac].apba113

                  #匯率>>2.以含稅金額重計匯率
                  LET g_apba_d[l_ac].apba111 = g_apba_d[l_ac].apba115 / g_apba_d[l_ac].apba105
                  #150422-00026#1 end ---
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba115
            #add-point:ON CHANGE apba115 name="input.g.page1.apba115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba114
            #add-point:BEFORE FIELD apba114 name="input.b.page1.apba114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba114
            
            #add-point:AFTER FIELD apba114 name="input.a.page1.apba114"
            IF NOT cl_null(g_apba_d[l_ac].apba114) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba114) OR g_apba_d[l_ac].apba114 != g_apba_d_t.apba114) OR cl_null(g_apba_d_t.apba114))) THEN
                  #檢核容差率
                  CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115)
                       RETURNING g_sub_success,g_errno,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba115
                  #容差率OK否
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba114 = g_apba_d_t.apba114
                     NEXT FIELD CURRENT
                  END IF
                  #160826-00017#1   add---s
                  #單身金額合計
                  LET g_apbb_m.apba103_s = l_sum1.apba103 + (g_apba_d[l_ac].apba103 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba104_s = l_sum1.apba104 + (g_apba_d[l_ac].apba104 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba105_s = l_sum1.apba105 + (g_apba_d[l_ac].apba105 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba113_s = l_sum1.apba113 + (g_apba_d[l_ac].apba113 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba114_s = l_sum1.apba114 + (g_apba_d[l_ac].apba114 * g_apba_d[l_ac].apba012)
                  LET g_apbb_m.apba115_s = l_sum1.apba115 + (g_apba_d[l_ac].apba115 * g_apba_d[l_ac].apba012)
                  DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                                  g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
                  #160826-00017#1   add---e
               END IF
            END IF
            LET g_apba_d_o.* = g_apba_d[l_ac].*   #160826-00017#1   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba114
            #add-point:ON CHANGE apba114 name="input.g.page1.apba114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba016
            #add-point:BEFORE FIELD apba016 name="input.b.page1.apba016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba016
            
            #add-point:AFTER FIELD apba016 name="input.a.page1.apba016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba016
            #add-point:ON CHANGE apba016 name="input.g.page1.apba016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba017
            #add-point:BEFORE FIELD apba017 name="input.b.page1.apba017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba017
            
            #add-point:AFTER FIELD apba017 name="input.a.page1.apba017"
            IF NOT cl_null(g_apba_d[l_ac].apba017) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba_d[l_ac].apba017) OR g_apba_d[l_ac].apba017 != g_apba_d_t.apba017) OR cl_null(g_apba_d_t.apba017))) THEN
                  LET l_isam002 = ''
                  LET l_isam011 = ''
                  LET l_isam014 = ''
                  SELECT isam002,isam011,isam014
                    INTO l_isam002,l_isam011,l_isam014
                    FROM isam_t
                   WHERE isament = g_enterprise
                     AND isam008 IN (SELECT isac002
                                       FROM isac_t
                                      #WHERE isacent = g_enterprise AND isac001 = 'T01' AND isac003 = '1')
                                      WHERE isacent = g_enterprise AND isac001 = g_ooef019 AND isac003 = '1')  #161110-00035#1 mod
                     AND isam010 = g_apba_d[l_ac].apba017
                  LET g_errno = ''
                  CASE
                     WHEN g_apbb_m.apbb002 <> l_isam002 #交易對象
                        LET g_errno = 'aap-00304'
                     WHEN g_apbb_m.apbb011 < l_isam011 #交易日期
                        LET g_errno = 'aap-00305'
                     WHEN g_apbb_m.apbb014 <> l_isam014 #幣別
                        LET g_errno = 'aap-00306'
                     WHEN cl_null(l_isam002) OR cl_null(l_isam011) OR cl_null(l_isam014)
                        LET g_errno = 'aap-00201'
                  END CASE
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba016 = g_apba_d_t.apba016
                     LET g_apba_d[l_ac].apba017 = g_apba_d_t.apba017
                     NEXT FIELD CURRENT
                  END IF
                  #檢核扣抵藍字發票的總額夠不夠扣
                  CALL aapt110_invoice_debit_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba_d[l_ac].apba016 = g_apba_d_t.apba016
                     LET g_apba_d[l_ac].apba017 = g_apba_d_t.apba017
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba017
            #add-point:ON CHANGE apba017 name="input.g.page1.apba017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apba111
            #add-point:BEFORE FIELD apba111 name="input.b.page1.apba111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apba111
            
            #add-point:AFTER FIELD apba111 name="input.a.page1.apba111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apba111
            #add-point:ON CHANGE apba111 name="input.g.page1.apba111"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apbaorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apbaorga
            #add-point:ON ACTION controlp INFIELD apbaorga name="input.c.page1.apbaorga"
            #160705-00035#1 mark ------
            #CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
            #CALL s_fin_account_center_sons_str()RETURNING g_wc_apbaorga
            #CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
            #160705-00035#1 mark end---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apba_d[l_ac].apbaorga
            #發票限制同法人否?
            CALL cl_get_para(g_enterprise,g_apbb_m.apbbcomp,'S-FIN-3015') RETURNING l_sfin3015
            IF l_sfin3015 = "Y" THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_apbaorga CLIPPED,
                                      " AND ooef017 ='",g_apbb_m.apbbcomp,"' ",
                                      " AND ooef201 = 'Y'"   #161006-00005#4   add
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_apbaorga CLIPPED,
                                      " AND ooef201 = 'Y'"   #161006-00005#4   add
            END IF
            CALL q_ooef001()
            LET g_apba_d[l_ac].apbaorga = g_qryparam.return1
            DISPLAY BY NAME g_apba_d[l_ac].apbaorga
            NEXT FIELD apbaorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba004
            #add-point:ON ACTION controlp INFIELD apba004 name="input.c.page1.apba004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba005
            #add-point:ON ACTION controlp INFIELD apba005 name="input.c.page1.apba005"
            IF NOT cl_null(g_apba_d[l_ac].apba004) THEN
               #160705-00035#1 add ------
               CASE g_apba_d[l_ac].apba004
                  WHEN '10' #apmt500採購單-預付訂金
                     INITIALIZE g_qryparam.* TO NULL
                     #LET g_qryparam.state = 'm' #170110-00035#1 mark
                     LET g_qryparam.state = 'i'  #170110-00035#1
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.default1 = g_apba_d[l_ac].apba005
                     #LET g_qryparam.default2 = g_apba_d[l_ac].apba006 #170110-00035#1 mark
                     LET g_qryparam.default2 = g_apba_d[l_ac].apba020  #170110-00035#1
                     LET g_qryparam.arg1 = g_apbb_m.apbbdocdt       #立帳日期
                     LET g_qryparam.arg2 = g_apbb_m.apbb002         #帳款對象
                     #預付款發票開立方式pmdl046=2.應開立增值稅發票&帳款類型pmdm014=1.簽約金2.訂金
                     LET g_qryparam.where = " pmdlsite = '",g_apba_d[l_ac].apbaorga,"'",
                                            " AND pmdl011 = '",g_apbb_m.apbb012,"'",       #稅別
                                            " AND pmdl015 = '",g_apbb_m.apbb014,"'",       #幣別
                                            " AND pmdl033 = '",g_apbb_m.apbb008,"'",       #發票類型
                                            " AND pmdl046 ='2' AND pmdm014 IN ('1','2') ",
                                            " AND NOT EXISTS (SELECT 1 FROM apba_t ",  #不存在aapt110
                                            "                   LEFT JOIN apbb_t ON apbaent=apbbent AND apbadocno=apbbdocno",
                                            "                  WHERE apbaent = ",g_enterprise,
                                            "                    AND apba005=pmdldocno AND apbbstus <> 'X')",
                                            " AND NOT EXISTS (SELECT 1 FROM apca_t",   #不存在aapt310
                                            "                  WHERE apcaent = ",g_enterprise,
                                            "                    AND apca018=pmdldocno AND apcastus <> 'X')"
                     #161206-00042#5-----s
                     LET l_pmaa004 = NULL
                     SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                      WHERE pmaaent = g_enterprise
                        AND pmaa001 = g_apbb_m.apbb002
                        
                     IF l_pmaa004 = '2' THEN
                        LET g_qryparam.where = g_qryparam.where ," AND pmdl028 = '",g_apbb_m.apbb059,"' "
                     END IF
                     #161206-00042#5-----e
                     CALL q_pmdn_aap()
                     #170110-00035#1 mark ------
                     #IF g_qryparam.str_array.getLength() = 0 THEN
                     #   NEXT FIELD apba005
                     #END IF
                     #
                     #CALL s_aapt110_get_controlp_wc(g_qryparam.str_array) RETURNING l_wc
                     #CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                     #
                     #IF NOT g_sub_success THEN
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                     #   CALL s_transaction_end('Y','0')
                     #END IF
                     #LET l_apba_flag = 'Y'
                     #LET l_flag = 'Y'
                     #EXIT DIALOG
                     #170110-00035#1 mark end---
                     LET g_apba_d[l_ac].apba005 = g_qryparam.return1
                     #LET g_apba_d[l_ac].apba006 = g_qryparam.return2 #170110-00035#1 mark
                     LET g_apba_d[l_ac].apba020 = g_qryparam.return2  #170110-00035#1
                     DISPLAY BY NAME g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006
                     NEXT FIELD apba005
                  
                  
                  WHEN '27' #27:其他待抵單
                     
                     #161206-00042#5-----s
                     INITIALIZE g_s400ar.* TO NULL
                     LET g_s400ar.apca057   = g_apbb_m.apbb059
                     LET g_s400ar.apcadocno = g_apbb_m.apbbdocno
                     LET ls_js = util.JSON.stringify(g_s400ar)                     
                     #161206-00042#5-----e
                     #CALL s_aapt420_source_doc_query(g_ld,'41','',g_apbb_m.apbbcomp,g_apbb_m.apbb002,g_apbb_m.apbbdocdt,g_apbb_m.apbbdocno)   #161206-00042#5 mark
                     CALL s_aapt420_source_doc_query(g_ld,'41','',g_apbb_m.apbbcomp,g_apbb_m.apbb002,g_apbb_m.apbbdocdt,ls_js)   #161206-00042#5
                          RETURNING l_wc
                     IF g_qryparam.str_array.getLength() = 0 THEN
                        NEXT FIELD apba005
                     END IF
                     
                     CALL s_aapt110_auto_ins_27(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                     LET l_apba_flag = 'Y'
                     LET l_flag = 'Y'
                     EXIT DIALOG
                     NEXT FIELD apba005
                  
                  
                  OTHERWISE
               #160705-00035#1 add end---
                     INITIALIZE g_qryparam.* TO NULL
                    #LET g_qryparam.state = 'i'     #20150317 mark
                     LET g_qryparam.state = 'c'     #20150317 add 
                     #IF p_cmd = 'a' THEN 
                     #  LET g_qryparam.state = 'm'
                     #END IF
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.default1 = g_apba_d[l_ac].apba005
                     LET g_qryparam.default2 = g_apba_d[l_ac].apba006
                     
                     #20150561--add--end--lujh
                     #流通走這
                     IF g_apbb_m.apbb056 = 'Y' THEN
                        LET g_qryparam.arg1 = g_apbb_m.apbb002                   #交易對象
                        LET g_qryparam.arg2 = g_apbb_m.apbb014                   #幣別
                        LET g_qryparam.arg3 = g_apbb_m.apbb012                   #稅別
                        LET g_qryparam.arg4 = g_apbb_m.apbb054                   #付款條件
                        LET g_qryparam.arg5 = g_apbb_m.apbbcomp                  #法人
                        
                        IF g_apba_d[l_ac].apba004 = '11' THEN 
                           LET l_stbe001 = '1'
                        END IF
                        
                        CASE g_apba_d[l_ac].apba004
                          WHEN '11' 
                               LET l_stbe001 = '1' 
                          WHEN '21'
                               LET l_stbe001 = '2' 
                          WHEN '12'
                               LET l_stbe001 = '3'
                          WHEN '13'  
                               LET l_stbe001 = '4' 
                          WHEN '23'  
                               LET l_stbe001 = '5'                          
                        END CASE
                        
                        LET g_qryparam.where = " stbe001 = '",l_stbe001,"'"
                        CALL aapt110_06()    
                        CALL aapt110_qbevalue_ins_apba_1(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                        LET l_apba_flag = 'Y'
                        LET l_flag = 'Y'
                        EXIT DIALOG
                     ELSE
                     #20150561--add--str--lujh
                        CASE g_apba_d[l_ac].apba004
                           #apmt570入庫單
                           WHEN "11"
                              LET g_qryparam.arg1 = "('",g_apba_d[l_ac].apbaorga,"')"  #帳務中心
                              LET g_qryparam.arg2 = g_apbb_m.apbb002                   #交易對象
                              #LET g_qryparam.arg3 = "('3','4','6','12','13')"         #單據性質
                              LET g_qryparam.arg3 = l_pmds000_str2 CLIPPED    #150702-00001#1 add
                              LET g_qryparam.arg4 = g_apbb_m.apbb012                   #稅別
                              LET g_qryparam.where = " pmds037 ='",g_apbb_m.apbb014,"'",
                                                     "  AND pmds001 < = '",g_apbb_m.apbbdocdt,"'", #160324-00032#1 #160530-00005#3 add,
                                                     "  AND pmds011 IN ",l_pmds011_str1 CLIPPED    #160530-00005#3
                              #CALL q_pmdtdocno_5()    #20150317 mark
                              #161206-00042#5-----s
                              LET l_pmaa004 = NULL
                              SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                               WHERE pmaaent = g_enterprise
                                 AND pmaa001 = g_apbb_m.apbb002
                                 
                              IF l_pmaa004 = '2' THEN
                                 LET g_qryparam.where = g_qryparam.where ," AND pmds028 = '",g_apbb_m.apbb059,"' "
                              END IF
                              #161206-00042#5-----e
                              #20150317--add--str--
                              CALL aapt110_03()
                              CALL aapt110_qbevalue_ins_apba(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                              LET l_apba_flag = 'Y'
                              LET l_flag = 'Y'
                              EXIT DIALOG
                              #20150317--add--end--
                        
                           #aapt301其他應付
                           WHEN "17"
                              LET g_qryparam.arg1 = g_apba_d[l_ac].apbaorga            #帳務中心
                              LET g_qryparam.where = " apca001='19' AND apca100 ='",g_apbb_m.apbb014,"'" 
                              #161206-00042#5-----s
                              LET l_pmaa004 = NULL
                              SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                               WHERE pmaaent = g_enterprise
                                 AND pmaa001 = g_apbb_m.apbb002
                                 
                              IF l_pmaa004 = '2' THEN
                                 LET g_qryparam.where = g_qryparam.where ," AND apca057 = '",g_apbb_m.apbb059,"' "
                              END IF
                              #161206-00042#5-----e                              
                              #CALL q_apcbdocno()    #20150317 mark
                              #20150317--add--str--
                              CALL aapt110_04()    
                              CALL aapt110_qbevalue_ins_apba(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                              LET l_apba_flag = 'Y' 
                              LET l_flag = 'Y'
                              EXIT DIALOG
                              #20150317--add--end--
                        
                           #apmt560採購驗退
                           WHEN "20"
                              LET g_qryparam.arg1 = "('",g_apba_d[l_ac].apbaorga,"')"  #帳務中心
                              LET g_qryparam.arg2 = g_apbb_m.apbb002                   #交易對象
                              #LET g_qryparam.arg3 = "('5','10','11')"                 #單據性質
                              LET g_qryparam.arg3 = l_pmds000_str5   #150702-00001#1 add
                              LET g_qryparam.arg4 = g_apbb_m.apbb012                   #稅別
                              LET g_qryparam.where = " pmds037 ='",g_apbb_m.apbb014,"'",
                                                     "  AND pmds001 < = '",g_apbb_m.apbbdocdt,"'"   #160324-00032#1 add 
                                                    ,"  AND pmds011 IN ",l_pmds011_str1 CLIPPED     #160530-00005#3
                              #CALL q_pmdtdocno_5()  #20150317 mark
                              #161206-00042#5-----s
                              LET l_pmaa004 = NULL
                              SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                               WHERE pmaaent = g_enterprise
                                 AND pmaa001 = g_apbb_m.apbb002
                                 
                              IF l_pmaa004 = '2' THEN
                                 LET g_qryparam.where = g_qryparam.where ," AND pmds028 = '",g_apbb_m.apbb059,"' "
                              END IF
                              #161206-00042#5-----e
                              #20150317--add--str--
                              CALL aapt110_03()    
                              CALL aapt110_qbevalue_ins_apba(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                              LET l_apba_flag = 'Y' 
                              LET l_flag = 'Y'
                              EXIT DIALOG
                              #20150317--add--end--
                        
                           #apmt580採購倉退
                           WHEN "21"
                              LET g_qryparam.arg1 = "('",g_apba_d[l_ac].apbaorga,"')"  #帳務中心
                              LET g_qryparam.arg2 = g_apbb_m.apbb002                   #交易對象
                              #LET g_qryparam.arg3 = "('7','14','15')"                  #單據性質
                              LET g_qryparam.arg3 = l_pmds000_str4    #150702-00001#1 add
                              LET g_qryparam.arg4 = g_apbb_m.apbb012                   #稅別
                              LET g_qryparam.where = " pmds037 ='",g_apbb_m.apbb014,"'",
                                                     "  AND pmds001 < = '",g_apbb_m.apbbdocdt,"'"   #160324-00032#1 add
                                                    ,"  AND pmds011 IN ",l_pmds011_str1 CLIPPED     #160530-00005#3
                              #161206-00042#5-----s
                              LET l_pmaa004 = NULL
                              SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                               WHERE pmaaent = g_enterprise
                                 AND pmaa001 = g_apbb_m.apbb002
                                 
                              IF l_pmaa004 = '2' THEN
                                 LET g_qryparam.where = g_qryparam.where ," AND pmds028 = '",g_apbb_m.apbb059,"' "
                              END IF
                              #161206-00042#5-----e
                              #CALL q_pmdtdocno_5()  #20150317 mark
                              #20150317--add--str--
                              CALL aapt110_03()    
                              CALL aapt110_qbevalue_ins_apba(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                              LET l_apba_flag = 'Y' 
                              LET l_flag = 'Y'
                              EXIT DIALOG
                              #20150317--add--end--
                        
                           #aapt340其他待抵
                           WHEN "27"
                              LET g_qryparam.arg1 = g_apba_d[l_ac].apbaorga            #帳務中心
                              LET g_qryparam.where = " apca001='29' AND apca100 ='",g_apbb_m.apbb014,"'"
                              #CALL q_apcbdocno()   #20150317 mark
                              #161206-00042#5-----s
                              LET l_pmaa004 = NULL
                              SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
                               WHERE pmaaent = g_enterprise
                                 AND pmaa001 = g_apbb_m.apbb002
                                 
                              IF l_pmaa004 = '2' THEN
                                 LET g_qryparam.where = g_qryparam.where ," AND apca057 = '",g_apbb_m.apbb059,"' "
                              END IF
                              #161206-00042#5-----e 
                              #20150317--add--str--
                              CALL aapt110_04()
                              CALL aapt110_qbevalue_ins_apba(g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004)
                              LET l_apba_flag = 'Y'
                              LET l_flag = 'Y'
                              EXIT DIALOG
                              #20150317--add--end--
                        END CASE
                     END IF   #20150601 add lujh
                     #20150317--mark--str--
                     #LET g_apba_d[l_ac].apba005 = g_qryparam.return1
                     #LET g_apba_d[l_ac].apba006 = g_qryparam.return2
                     ##帶出相關的來源單據值
                     #CALL aapt110_qbevalue_show(l_ac,g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba004)
                     #DISPLAY BY NAME g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006
                     #20150317--mark--end--
                     NEXT FIELD apba005
                  
               END CASE  #160705-00035#1
            
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba006
            #add-point:ON ACTION controlp INFIELD apba006 name="input.c.page1.apba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba020
            #add-point:ON ACTION controlp INFIELD apba020 name="input.c.page1.apba020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba019
            #add-point:ON ACTION controlp INFIELD apba019 name="input.c.page1.apba019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba012
            #add-point:ON ACTION controlp INFIELD apba012 name="input.c.page1.apba012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba014
            #add-point:ON ACTION controlp INFIELD apba014 name="input.c.page1.apba014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba010
            #add-point:ON ACTION controlp INFIELD apba010 name="input.c.page1.apba010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba103
            #add-point:ON ACTION controlp INFIELD apba103 name="input.c.page1.apba103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba105
            #add-point:ON ACTION controlp INFIELD apba105 name="input.c.page1.apba105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba104
            #add-point:ON ACTION controlp INFIELD apba104 name="input.c.page1.apba104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba113
            #add-point:ON ACTION controlp INFIELD apba113 name="input.c.page1.apba113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba115
            #add-point:ON ACTION controlp INFIELD apba115 name="input.c.page1.apba115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba114
            #add-point:ON ACTION controlp INFIELD apba114 name="input.c.page1.apba114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba016
            #add-point:ON ACTION controlp INFIELD apba016 name="input.c.page1.apba016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba017
            #add-point:ON ACTION controlp INFIELD apba017 name="input.c.page1.apba017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apba_d[l_ac].apba016
            LET g_qryparam.default2 = g_apba_d[l_ac].apba017
            LET g_qryparam.arg1 = g_apbb_m.apbb002
            LET g_qryparam.arg2 = g_apbb_m.apbbdocdt
            LET g_qryparam.arg3 = g_ooef019
            #161230-00036#1 mark ------
            #SELECT isai002 INTO g_isai002
            #  FROM ooef_t
            #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
            # WHERE ooefent = g_enterprise
            #   AND ooef001 = g_apbb_m.apbbcomp
            #161230-00036#1 mark end---
            IF g_isai002 = "1" THEN
               LET g_qryparam.where = " isam023 > (SELECT CASE WHEN SUM(apba103) IS NULL THEN 0 ELSE SUM(apba103) END AS aaa",
                                      "              FROM apba_t,apbb_t",
                                      "             WHERE apbaent = apbbent AND apbadocno = apbbdocno",
                                      "               AND apbbstus<>'X'",
                                      "               AND apba017 = isam010)"
            ELSE
               LET g_qryparam.where = " isam023 > (SELECT CASE WHEN SUM(apba103) IS NULL THEN 0 ELSE SUM(apba103) END AS aaa",
                                      "              FROM apba_t,apbb_t",
                                      "             WHERE apbaent = apbbent AND apbadocno = apbbdocno",
                                      "               AND apbbstus<>'X'",
                                      "               AND apba016 = isam009 AND apba017 = isam010)"
            END IF
            LET g_qryparam.where = g_qryparam.where," AND apbb014 = '",g_apbb_m.apbb014,"' "
            CALL q_isam010_4()
            LET g_apba_d[l_ac].apba016 = g_qryparam.return1
            LET g_apba_d[l_ac].apba017 = g_qryparam.return2
            DISPLAY BY NAME g_apba_d[l_ac].apba017
            NEXT FIELD apba017
            #END add-point
 
 
         #Ctrlp:input.c.page1.apba111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apba111
            #add-point:ON ACTION controlp INFIELD apba111 name="input.c.page1.apba111"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apba_d[l_ac].* = g_apba_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt110_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apba_d[l_ac].apbaseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apba_d[l_ac].* = g_apba_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt110_apba_t_mask_restore('restore_mask_o')
      
               UPDATE apba_t SET (apbadocno,apbaseq,apbaorga,apba004,apba005,apba006,apba020,apba019, 
                   apba007,apba008,apba013,apba015,apba012,apba100,apba009,apba014,apba010,apba103,apba105, 
                   apba104,apba113,apba115,apba114,apba016,apba017,apba111) = (g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq, 
                   g_apba_d[l_ac].apbaorga,g_apba_d[l_ac].apba004,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006, 
                   g_apba_d[l_ac].apba020,g_apba_d[l_ac].apba019,g_apba_d[l_ac].apba007,g_apba_d[l_ac].apba008, 
                   g_apba_d[l_ac].apba013,g_apba_d[l_ac].apba015,g_apba_d[l_ac].apba012,g_apba_d[l_ac].apba100, 
                   g_apba_d[l_ac].apba009,g_apba_d[l_ac].apba014,g_apba_d[l_ac].apba010,g_apba_d[l_ac].apba103, 
                   g_apba_d[l_ac].apba105,g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba115, 
                   g_apba_d[l_ac].apba114,g_apba_d[l_ac].apba016,g_apba_d[l_ac].apba017,g_apba_d[l_ac].apba111) 
 
                WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno 
 
                  AND apbaseq = g_apba_d_t.apbaseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apba_d[l_ac].* = g_apba_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apba_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apba_d[l_ac].* = g_apba_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys_bak[1] = g_apbbdocno_t
               LET gs_keys[2] = g_apba_d[g_detail_idx].apbaseq
               LET gs_keys_bak[2] = g_apba_d_t.apbaseq
               CALL aapt110_update_b('apba_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt110_apba_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apba_d[g_detail_idx].apbaseq = g_apba_d_t.apbaseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apbb_m.apbbdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apba_d_t.apbaseq
 
                  CALL aapt110_key_update_b(gs_keys,'apba_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba_d_t)
               LET g_log2 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #141218-00011#1 add ------
               #若該入庫單的收貨單有發票，來這兒新增到isam_t
               IF g_apbb_m.apbb056 = 'N' THEN   #20150603 add lujh
                  IF g_apba_d[l_ac].apba004 = '11' THEN
                     CALL aapt110_ins_isam_from_pmdw(g_apba_d[l_ac].apba005) RETURNING g_sub_success
                  END IF
               #20150603--add--str--lujh   
               ELSE
                  CALL aapt110_ins_isam_1() RETURNING g_sub_success
                  CALL aapt110_b_fill()
               END IF
               #20150603--add--end--lujh
               #141218-00011#1 add end---
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
 
            #end add-point
            CALL aapt110_unlock_b("apba_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
 
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #更新至單頭
            IF cl_ask_confirm('aap-00210') THEN
               CALL aapt110_money_update_to_head("apba","Y")
            END IF
            #150629-00017#1 add ------
         	IF g_apbb_m.apbb056 = 'N' THEN
               IF NOT cl_null(g_apbb_m.apbb010) AND (g_apbb_m.apbb010 <> 'MULTI') THEN
                  SELECT COUNT(*) INTO l_cnt FROM isam_t
                   WHERE isament = g_enterprise
                     AND isamdocno = g_apbb_m.apbbdocno
                     AND isam010 = g_apbb_m.apbb010
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN
                     #發票號碼不為空白AND不等於MULTI且發票明細無資料，則新增一筆isam_t
                     CALL aapt110_ins_isam() RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
            END IF
            CALL aapt110_show()
            #150629-00017#1 add end---
            #發票號碼兩筆以上且不為空白，則更新apbb010為MULTI，一筆就回寫到單頭的apbb010
            SELECT COUNT(*) INTO l_cnt
              FROM isam_t
             WHERE isament = g_enterprise
               AND isamdocno = g_apbb_m.apbbdocno
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF (l_cnt = 1) AND NOT cl_null(g_apba2_d[1].isam010) THEN
               LET g_apbb_m.apbb009 = g_apba2_d[1].isam009
               LET g_apbb_m.apbb010 = g_apba2_d[1].isam010
               LET g_apbb_m.apbb011 = g_apba2_d[1].isam011  #170218-00030#1 add
            ELSE
               IF l_cnt > 1 THEN #發票兩筆以上
                  LET g_apbb_m.apbb009 = ""
                  LET g_apbb_m.apbb010 = "MULTI"
               ELSE
                  LET g_apbb_m.apbb009 = ""
                  LET g_apbb_m.apbb010 = ""
               END IF
            END IF
            UPDATE apbb_t SET apbb009 = g_apbb_m.apbb009,
                              apbb010 = g_apbb_m.apbb010,
                              apbb011 = g_apbb_m.apbb011  #170218-00030#1 add
             WHERE apbbent = g_enterprise
               AND apbbdocno = g_apbb_m.apbbdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE apbb_t wrong!" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apba_d[li_reproduce_target].* = g_apba_d[li_reproduce].*
 
               LET g_apba_d[li_reproduce_target].apbaseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apba_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apba_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_apba2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apba2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt110_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apba2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL aapt110_set_entry_money(g_apbb_m.apbb0121)
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apba2_d[l_ac].* TO NULL 
            INITIALIZE g_apba2_d_t.* TO NULL 
            INITIALIZE g_apba2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apba2_d[l_ac].isamstus = 'N'
 
 
 
            #自定義預設值(單身2)
                  LET g_apba2_d[l_ac].isam037 = "1"
      LET g_apba2_d[l_ac].isam200 = "N"
      LET g_apba2_d[l_ac].isamstus = "Y"
      LET g_apba2_d[l_ac].isam001 = "aapt110"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015   #150422-00026#1
            #end add-point
            LET g_apba2_d_t.* = g_apba2_d[l_ac].*     #新輸入資料
            LET g_apba2_d_o.* = g_apba2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt110_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt110_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apba2_d[li_reproduce_target].* = g_apba2_d[li_reproduce].*
 
               LET g_apba2_d[li_reproduce_target].isamseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            #項次
            SELECT MAX(isamseq)+1 INTO g_apba2_d[l_ac].isamseq FROM isam_t
             WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
            IF cl_null(g_apba2_d[l_ac].isamseq) OR g_apba2_d[l_ac].isamseq = 0 THEN
               LET g_apba2_d[l_ac].isamseq = 1
            END IF

            IF NOT cl_null(g_apbb_m.apbb010) AND g_apbb_m.apbb010 <> "MULTI" THEN   
               SELECT COUNT (*) INTO l_cnt
                 FROM isam_t
                WHERE isament = g_enterprise
                  AND isamdocno = g_apbb_m.apbbdocno
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  LET g_apba2_d[l_ac].isam037 = g_apbb_m.apbb037
                  LET g_apba2_d[l_ac].isam010 = g_apbb_m.apbb010
                  LET g_apba2_d[l_ac].isam030 = g_apbb_m.apbb030
                  #LET g_apba2_d[l_ac].isam014 = g_apbb_m.apbb014
                  #LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015
                  LET g_apba2_d[l_ac].isam023 = g_apbb_m.apbb023
                  LET g_apba2_d[l_ac].isam024 = g_apbb_m.apbb024
                  LET g_apba2_d[l_ac].isam025 = g_apbb_m.apbb025
                  LET g_apba2_d[l_ac].isam026 = g_apbb_m.apbb026
                  LET g_apba2_d[l_ac].isam027 = g_apbb_m.apbb027
                  LET g_apba2_d[l_ac].isam028 = g_apbb_m.apbb028                  
               END IF
            END IF
            #161206-00019#1---add---str--
            IF g_apba2_d.getLength() = 1 THEN
               IF cl_null(g_apba2_d[l_ac].isam023) THEN LET g_apba2_d[l_ac].isam023 = 0 END IF
               IF cl_null(g_apba2_d[l_ac].isam024) THEN LET g_apba2_d[l_ac].isam024 = 0 END IF
               IF cl_null(g_apba2_d[l_ac].isam025) THEN LET g_apba2_d[l_ac].isam025 = 0 END IF
               IF cl_null(g_apba2_d[l_ac].isam026) THEN LET g_apba2_d[l_ac].isam026 = 0 END IF
               IF cl_null(g_apba2_d[l_ac].isam027) THEN LET g_apba2_d[l_ac].isam027 = 0 END IF
               IF cl_null(g_apba2_d[l_ac].isam028) THEN LET g_apba2_d[l_ac].isam028 = 0 END IF
               IF g_apba2_d[l_ac].isam023 = 0 AND g_apba2_d[l_ac].isam024 = 0 AND g_apba2_d[l_ac].isam025 = 0 AND g_apba2_d[l_ac].isam023 = 0
                   AND g_apba2_d[l_ac].isam023 = 0 AND g_apba2_d[l_ac].isam023 = 0 THEN  
                  SELECT SUM(apba103*apba012),SUM(apba104*apba012),SUM(apba105*apba012),
                         SUM(apba113*apba012),SUM(apba114*apba012),SUM(apba115*apba012)
                    INTO g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025, 
                         g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028 
                    FROM apba_t
                   WHERE apbaent = g_enterprise
                     AND apbadocno = g_apbb_m.apbbdocno
                     AND (apba019 = 'Y' OR apba019 IS NULL)
                  DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                  g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
               END IF
            END IF
            #161206-00019#1---add---end--
            LET g_apba2_d[l_ac].isam008 = g_apbb_m.apbb008    #發票種類
            LET g_apba2_d[l_ac].isam011 = g_apbb_m.apbb011    #發票日期
            LET g_apba2_d[l_ac].isam009 = g_apbb_m.apbb009    #發票代碼
            LET g_apba2_d[l_ac].isam030 = g_apbb_m.apbb030    #統一編號
            LET g_apba2_d[l_ac].isam036 = g_apbb_m.apbb036    #狀態
            LET g_apba2_d[l_ac].isamcomp = g_apbb_m.apbbcomp  #法人
            
            #160826-0000517#1   add--s
            #顯示單身金額合計
            CALL s_aapt300_sum('',g_apbb_m.apbbdocno,g_apba_d[l_ac].apbaseq)
            RETURNING g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                      g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
            DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                            g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
            #160826-0000517#1   add--e
            NEXT FIELD isam008  #170215-00057#1   add
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt110_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apba2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apba2_d[l_ac].isamseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apba2_d_t.* = g_apba2_d[l_ac].*  #BACKUP
               LET g_apba2_d_o.* = g_apba2_d[l_ac].*  #BACKUP
               CALL aapt110_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aapt110_set_no_entry_b(l_cmd)
               IF NOT aapt110_lock_b("isam_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt110_bcl2 INTO g_apba2_d[l_ac].isamseq,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam037, 
                      g_apba2_d[l_ac].isam011,g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam200, 
                      g_apba2_d[l_ac].isam030,g_apba2_d[l_ac].isam012,g_apba2_d[l_ac].isam014,g_apba2_d[l_ac].isam015, 
                      g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,g_apba2_d[l_ac].isam026, 
                      g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028,g_apba2_d[l_ac].isam036,g_apba2_d[l_ac].isam050, 
                      g_apba2_d[l_ac].isamstus,g_apba2_d[l_ac].isamcomp,g_apba2_d[l_ac].isam001
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apba2_d_mask_o[l_ac].* =  g_apba2_d[l_ac].*
                  CALL aapt110_isam_t_mask()
                  LET g_apba2_d_mask_n[l_ac].* =  g_apba2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt110_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apbb_m.apbbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_apba2_d_t.isamseq
            
               #刪除同層單身
               IF NOT aapt110_delete_b('isam_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt110_key_delete_b(gs_keys,'isam_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt110_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_apba_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               #170110-00044#1 --s add
               LET l_isamcnt = 0
               SELECT COUNT(isamdocno) INTO l_isamcnt
                 FROM isam_t WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
               IF cl_null(l_isamcnt) THEN LET l_isamcnt = 0 END IF
               IF l_isamcnt = 0 THEN
                  #更新單頭金額
                  IF cl_ask_confirm('aap-00210') THEN
                     CALL aapt110_money_update_to_head("isam","Y")
                     UPDATE apbb_t SET apbb009 = '',
                                       apbb010 = ''
                      WHERE apbbent = g_enterprise AND apbbdocno = g_apbb_m.apbbdocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "UPDATE apbb_t wrong!" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     END IF
                     DISPLAY BY NAME g_apbb_m.apbb009,g_apbb_m.apbb010                     
                     CALL aapt110_show()
                     EXIT DIALOG
                  END IF                  
               END IF
               #170110-00044#1 --e add  
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apba2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM isam_t 
             WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
               AND isamseq = g_apba2_d[l_ac].isamseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               LET g_apba2_d[l_ac].isam012 = g_apbb_m.apbb012 #稅別
               LET g_apba2_d[l_ac].isam014 = g_apbb_m.apbb014 #幣別
               LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015 #匯率
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys[2] = g_apba2_d[g_detail_idx].isamseq
               CALL aapt110_insert_b('isam_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apba_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt110_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apba2_d[l_ac].* = g_apba2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt110_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apba2_d[l_ac].* = g_apba2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               LET g_apba2_d[l_ac].isam012 = g_apbb_m.apbb012 #稅別
               LET g_apba2_d[l_ac].isam014 = g_apbb_m.apbb014 #幣別
               LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015 #匯率
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL aapt110_isam_t_mask_restore('restore_mask_o')
                              
               UPDATE isam_t SET (isamdocno,isamseq,isam008,isam037,isam011,isam009,isam010,isam200, 
                   isam030,isam012,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036, 
                   isam050,isamstus,isamcomp,isam001) = (g_apbb_m.apbbdocno,g_apba2_d[l_ac].isamseq, 
                   g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam037,g_apba2_d[l_ac].isam011,g_apba2_d[l_ac].isam009, 
                   g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam200,g_apba2_d[l_ac].isam030,g_apba2_d[l_ac].isam012, 
                   g_apba2_d[l_ac].isam014,g_apba2_d[l_ac].isam015,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024, 
                   g_apba2_d[l_ac].isam025,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028, 
                   g_apba2_d[l_ac].isam036,g_apba2_d[l_ac].isam050,g_apba2_d[l_ac].isamstus,g_apba2_d[l_ac].isamcomp, 
                   g_apba2_d[l_ac].isam001) #自訂欄位頁簽
                WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
                  AND isamseq = g_apba2_d_t.isamseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apba2_d[l_ac].* = g_apba2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apba2_d[l_ac].* = g_apba2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys_bak[1] = g_apbbdocno_t
               LET gs_keys[2] = g_apba2_d[g_detail_idx].isamseq
               LET gs_keys_bak[2] = g_apba2_d_t.isamseq
               CALL aapt110_update_b('isam_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt110_isam_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apba2_d[g_detail_idx].isamseq = g_apba2_d_t.isamseq 
                  ) THEN
                  LET gs_keys[01] = g_apbb_m.apbbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apba2_d_t.isamseq
                  CALL aapt110_key_update_b(gs_keys,'isam_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba2_d_t)
               LET g_log2 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamseq
            #add-point:BEFORE FIELD isamseq name="input.b.page2.isamseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamseq
            
            #add-point:AFTER FIELD isamseq name="input.a.page2.isamseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba2_d[g_detail_idx].isamseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba2_d[g_detail_idx].isamseq != g_apba2_d_t.isamseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isam_t WHERE "||"isament = '" ||g_enterprise|| "' AND "||"isamdocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isamseq = '"||g_apba2_d[g_detail_idx].isamseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isamseq
            #add-point:ON CHANGE isamseq name="input.g.page2.isamseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam008
            
            #add-point:AFTER FIELD isam008 name="input.a.page2.isam008"
            IF NOT cl_null(g_apba2_d[l_ac].isam008) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam008) OR g_apba2_d[l_ac].isam008 != g_apba2_d_t.isam008) OR cl_null(g_apba2_d_t.isam008))) THEN #161230-00036#1 mark
               IF g_apba2_d[l_ac].isam008 != g_apba2_d_o.isam008 OR cl_null(g_apba2_d_o.isam008) THEN #161230-00036#1 add
                  #發票類型檢核的chk
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_apba2_d[l_ac].isam008
                  #紅字發票與藍字發票是否共用發票簿
                  #161230-00036#1 mark ------
                  #SELECT isai006 INTO g_isai006
                  #  FROM ooef_t
                  #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_apbb_m.apbbcomp
                  #161230-00036#1 mark end---
                  IF g_isai006 = "Y" THEN #有共用發票簿
                     IF NOT cl_chk_exist("v_isac002_3") THEN
                        LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF g_apbb_m.apbb050='2' THEN #紅字發票
                        IF NOT cl_chk_exist("v_isac002_4") THEN
                           LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF NOT cl_chk_exist("v_isac002_1") THEN
                           LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #檢核發票是否重複
                  #160107-00004#1 add apbbcomp,apbb002
                  CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam008 = g_apba2_d_t.isam008
                     NEXT FIELD CURRENT
                  END IF
                  #變動異動狀態
                  CALL aapt110_change_type(g_apbb_m.apbbcomp,g_apba2_d[l_ac].isam008) RETURNING g_apba2_d[l_ac].isam036
                  DISPLAY BY NAME g_apba2_d[l_ac].isam036
                  #151013-00016#14 ---s---
                  #161230-00036#1 mark ------
                  #LET l_isac004 = ''
                  #SELECT isac004 INTO l_isac004 FROM isac_t
                  # WHERE isacent = g_enterprise AND isac002 = g_apba2_d[l_ac].isam008 AND isac001 = g_ooef019
                  #IF cl_null(l_isac004) THEN LET g_apba2_d[l_ac].isam037 = '3' END IF
                  #161230-00036#1 mark end---
                  #161230-00036#1 add ------
                  #媒體申報格式/發票聯數
                  SELECT isac004,isac008 INTO g_isac004,g_isac008 FROM isac_t
                   WHERE isacent = g_enterprise AND isac002 = g_apba2_d[l_ac].isam008 AND isac001 = g_ooef019
                  
                  IF cl_null(g_isac004) THEN LET g_apba2_d[l_ac].isam037 = '3' END IF
                  LET g_apba2_d[l_ac].isam030 = ''
                  #161230-00036#1 add end---
                  DISPLAY BY NAME g_apba2_d[l_ac].isam037
                  #151013-00016#14 ---e---  
                  #161230-00036#1-add(s)
                  IF g_ooef011 = 'TW' THEN
                     #IF g_isac008 MATCHES '[4]' OR cl_null(g_isac004) THEN                                          #170218-00012#1 mark
                     IF g_isac008 MATCHES '[4]' OR cl_null(g_isac004) OR g_isac004 = '28' OR g_isac004 = '29' THEN   #170218-00012#1 add
                        CALL cl_set_comp_required("isam030",FALSE)
                     ELSE
                        CALL cl_set_comp_required("isam030",TRUE)
                        IF NOT cl_null(g_apba2_d[l_ac].isam030) THEN
                           #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                           CALL s_rule_chk_vat_id_string(g_apba2_d[l_ac].isam030) RETURNING l_success
                           IF NOT l_success THEN
                              LET g_apba2_d[l_ac].isam030 = g_apba2_d_t.isam030
                              NEXT FIELD isam030
                           END IF
                           #檢查營利事業統一編號邏輯
                           CALL s_rule_chk_vat_id(g_ooef011,g_apba2_d[l_ac].isam030) RETURNING l_success
                           IF NOT l_success THEN
                              LET g_apba2_d[l_ac].isam030 = g_apba2_d[l_ac].isam030
                           END IF
                        END IF
                     END IF
                  END IF
                  #161230-00036#1-add(e)
               END IF
            END IF
            LET g_apba2_d_o.* = g_apba2_d[l_ac].* #161230-00036#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam008
            #add-point:BEFORE FIELD isam008 name="input.b.page2.isam008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam008
            #add-point:ON CHANGE isam008 name="input.g.page2.isam008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam037
            #add-point:BEFORE FIELD isam037 name="input.b.page2.isam037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam037
            
            #add-point:AFTER FIELD isam037 name="input.a.page2.isam037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam037
            #add-point:ON CHANGE isam037 name="input.g.page2.isam037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam011
            #add-point:BEFORE FIELD isam011 name="input.b.page2.isam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam011
            
            #add-point:AFTER FIELD isam011 name="input.a.page2.isam011"
            #150303 mark-----
            #IF NOT cl_null(g_apba2_d[l_ac].isam011) THEN
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam011) OR g_apba2_d[l_ac].isam011 != g_apba2_d_t.isam011) OR cl_null(g_apba2_d_t.isam011))) THEN
            #      IF NOT cl_null(g_apbb_m.apbbdocdt) THEN
            #         #發票日期不可大於錄入日期
            #         IF g_apba2_d[l_ac].isam011 > g_apbb_m.apbbdocdt THEN
            #            INITIALIZE g_errparam TO NULL
            #            LET g_errparam.code = 'aap-00198'
            #            LET g_errparam.extend = ''
            #            LET g_errparam.popup = TRUE
            #            CALL cl_err()
            #            LET g_apba2_d[l_ac].isam011 = g_apba2_d_t.isam011
            #            NEXT FIELD CURRENT
            #         END IF
            #      END IF
            #   END IF
            #END IF
            ##150303 mark end-----
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam011
            #add-point:ON CHANGE isam011 name="input.g.page2.isam011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam009
            #add-point:BEFORE FIELD isam009 name="input.b.page2.isam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam009
            
            #add-point:AFTER FIELD isam009 name="input.a.page2.isam009"
            IF NOT cl_null(g_apba2_d[l_ac].isam009) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam009) OR g_apba2_d[l_ac].isam009 != g_apba2_d_t.isam009) OR cl_null(g_apba2_d_t.isam009))) THEN
                  #檢核發票是否重複
                  #160107-00004#1 add apbbcomp,apbb002
                  CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam009 = g_apba2_d_t.isam009
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam009
            #add-point:ON CHANGE isam009 name="input.g.page2.isam009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam010
            #add-point:BEFORE FIELD isam010 name="input.b.page2.isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam010
            
            #add-point:AFTER FIELD isam010 name="input.a.page2.isam010"
            IF NOT cl_null(g_apba2_d[l_ac].isam010) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam010) OR g_apba2_d[l_ac].isam010 != g_apba2_d_t.isam010) OR cl_null(g_apba2_d_t.isam010))) THEN
                  #160713-00019#1--add--start-- 
                  IF g_isai002 = "1" THEN
                     CALL aapt110_isad005_chk(g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam011) 
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba2_d[l_ac].isam010 = g_apba2_d_t.isam010
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160713-00019#1--add--end---- 
                  #檢核發票是否重複
                  #160107-00004#1 add apbbcomp,apbb002
                  CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam010 = g_apba2_d_t.isam010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam010
            #add-point:ON CHANGE isam010 name="input.g.page2.isam010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam200
            #add-point:BEFORE FIELD isam200 name="input.b.page2.isam200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam200
            
            #add-point:AFTER FIELD isam200 name="input.a.page2.isam200"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam200
            #add-point:ON CHANGE isam200 name="input.g.page2.isam200"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam030
            #add-point:BEFORE FIELD isam030 name="input.b.page2.isam030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam030
            
            #add-point:AFTER FIELD isam030 name="input.a.page2.isam030"
            #161115-00002#1---add---str--
            IF cl_null(g_apba2_d[l_ac].isam030) THEN
               #161230-00036#1 mark ------
               #SELECT ooef011 INTO l_ooef011
               #  FROM ooef_t
               # WHERE ooefent = g_enterprise
               #   AND ooef001 = g_apbb_m.apbbcomp
               #IF l_ooef011 = 'TW' THEN
               #   SELECT isac004,isac008 INTO l_isac004,l_isac008
               #     FROM isac_t
               #     LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
               #    WHERE isacent = g_enterprise
               #      AND ooef001 = g_apbb_m.apbbcomp
               #      AND isac002 = g_apba2_d[l_ac].isam008
               #   IF l_isac008 NOT MATCHES "[04]" AND l_isac004 <> '28' AND l_isac004 <> '29' THEN
               #161230-00036#1 mark end---
               IF g_ooef011 = 'TW' THEN  #161230-00036#1
                  IF g_isac008 NOT MATCHES "[04]" AND g_isac004 <> '28' AND g_isac004 <> '29' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00601'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam030 = g_apba2_d_t.isam030
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #161115-00002#1---add---end
            #161230-00036#1-add(s)  
            IF NOT cl_null(g_apba2_d[l_ac].isam030) THEN
               IF g_ooef011 = 'TW' THEN
                  #IF g_isac008 NOT MATCHES '[4]'AND NOT cl_null(g_isac004) THEN                                              #170218-00012#1 mark
                  IF g_isac008 NOT MATCHES '[4]'AND NOT cl_null(g_isac004) AND g_isac004 != '28' AND g_isac004 != '29' THEN   #170218-00012#1 add
                     IF NOT cl_null(g_apba2_d[l_ac].isam030) THEN
                        #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                        CALL s_rule_chk_vat_id_string(g_apba2_d[l_ac].isam030) RETURNING l_success
                        IF NOT l_success THEN
                           LET g_apba2_d[l_ac].isam030 = g_apba2_d_t.isam030
                           NEXT FIELD isam030
                        END IF
                        #檢查營利事業統一編號邏輯
                        CALL s_rule_chk_vat_id(g_ooef011,g_apba2_d[l_ac].isam030) RETURNING l_success
                        IF NOT l_success THEN
                           LET g_apba2_d[l_ac].isam030 = g_apba2_d[l_ac].isam030
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            #161230-00036#1-add(e)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam030
            #add-point:ON CHANGE isam030 name="input.g.page2.isam030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam014
            #add-point:BEFORE FIELD isam014 name="input.b.page2.isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam014
            
            #add-point:AFTER FIELD isam014 name="input.a.page2.isam014"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam014
            #add-point:ON CHANGE isam014 name="input.g.page2.isam014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam015
            #add-point:BEFORE FIELD isam015 name="input.b.page2.isam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam015
            
            #add-point:AFTER FIELD isam015 name="input.a.page2.isam015"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam015
            #add-point:ON CHANGE isam015 name="input.g.page2.isam015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam023
            #add-point:BEFORE FIELD isam023 name="input.b.page2.isam023"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam023
            
            #add-point:AFTER FIELD isam023 name="input.a.page2.isam023"
            #原幣未稅金額
            IF NOT cl_null(g_apba2_d[l_ac].isam023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam023) OR g_apba2_d[l_ac].isam023 != g_apba2_d_t.isam023) OR cl_null(g_apba2_d_t.isam023))) THEN
                  #紅字發票不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam023 >= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam023 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核紅字發票是否超過扣抵金額
                  IF g_apbb_m.apbb050 = '2' AND g_isai002 ='1' THEN
                     IF NOT cl_null(g_apba2_d[l_ac].isam010) THEN #170117-00030#1 add
                     #160107-00004#1 add apbbcomp,apbb002
                     CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                        NEXT FIELD CURRENT
                     END IF
                     END IF #170117-00030#1 add
                  END IF

                  #150422-00026#1 add ---
                  IF g_apbb_m.apbb0121 = 'N' THEN
                     CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam023,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                          RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                    g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
                  ELSE
                     LET g_apba2_d[l_ac].isam024 = g_apba2_d[l_ac].isam025 - g_apba2_d[l_ac].isam023
                     
                     IF g_apba2_d[l_ac].isam015 = 1 THEN
                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                     ELSE
                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apba2_d[l_ac].isam015
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                     END IF
                  END IF

                  #150422-00026#1 end ---
                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam023
            #add-point:ON CHANGE isam023 name="input.g.page2.isam023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam024
            #add-point:BEFORE FIELD isam024 name="input.b.page2.isam024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam024
            
            #add-point:AFTER FIELD isam024 name="input.a.page2.isam024"
            IF NOT cl_null(g_apba2_d[l_ac].isam024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam024) OR g_apba2_d[l_ac].isam024 != g_apba2_d_t.isam024) OR cl_null(g_apba2_d_t.isam024))) THEN
                  #紅字發票金額不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam024 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam024 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                     NEXT FIELD CURRENT
                  END IF

                  #檢核容差率
                  CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025)
                       RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025
                  #容差率OK否
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                     LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                     LET g_apba2_d[l_ac].isam025 = g_apba2_d_t.isam025
                     NEXT FIELD CURRENT
                  ELSE
                     ##若匯率=1則不重算金額
                     #IF g_apbb_m.apbb015 = 1 THEN
                     #   LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
                     #   LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                     #   LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
                     #ELSE
                     #   IF g_apbb_m.apbb0121 = "Y" THEN
                     #      #容差率OK要更新本幣金額
                     #      LET g_apba2_d[l_ac].isam028 = (g_apba2_d[l_ac].isam023+g_apba2_d[l_ac].isam024) * g_apbb_m.apbb015
                     #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                     #      LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 / (1+(g_apbb_m.apbb013/100))
                     #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                     #      #稅額=含稅-未稅
                     #      LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                     #   ELSE
                     #      #容差率OK要更新本幣金額
                     #      LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apbb_m.apbb015
                     #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                     #      LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam026 * (g_apbb_m.apbb013/100)
                     #      CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                     #      #含稅=未稅+稅額
                     #      LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 + g_apba2_d[l_ac].isam027
                     #   END IF
                     #END IF
                     
                     #150422-00026#1 add ---

                     #容差率OK更新本幣金額
                     IF g_apba2_d[l_ac].isam015 = 1 THEN
                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
                     ELSE
                        IF g_apbb_m.apbb0121 = "Y" THEN
                           LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024 * g_apba2_d[l_ac].isam015
                           CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                           LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam027
                        ELSE
                           LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024 * g_apba2_d[l_ac].isam015
                           CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                           LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 + g_apba2_d[l_ac].isam027
                        END IF
                     END IF
                     #150422-00026#1 end ---
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam024
            #add-point:ON CHANGE isam024 name="input.g.page2.isam024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam025
            #add-point:BEFORE FIELD isam025 name="input.b.page2.isam025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam025
            
            #add-point:AFTER FIELD isam025 name="input.a.page2.isam025"
            #原幣含稅金額
            IF NOT cl_null(g_apba2_d[l_ac].isam025) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam025) OR g_apba2_d[l_ac].isam025 != g_apba2_d_t.isam025) OR cl_null(g_apba2_d_t.isam025))) THEN
                  #紅字發票金額不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam025 >= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam025 = g_apba2_d_t.isam025
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam025 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam025 = g_apba2_d_t.isam025
                     NEXT FIELD CURRENT
                  END IF

                  #150422-00026#1 add ---
                 IF g_apbb_m.apbb0121 = 'Y' THEN
                     CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam025,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                          RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                    g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028 
                  ELSE
                     LET g_apba2_d[l_ac].isam024 = g_apba2_d[l_ac].isam025 - g_apba2_d[l_ac].isam023
                     IF g_apba2_d[l_ac].isam015 = 1 THEN
                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                     ELSE
                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025 * g_apba2_d[l_ac].isam015
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                     END IF
                  END IF
                  #150422-00026#1 end ---
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam025
            #add-point:ON CHANGE isam025 name="input.g.page2.isam025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam026
            #add-point:BEFORE FIELD isam026 name="input.b.page2.isam026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam026
            
            #add-point:AFTER FIELD isam026 name="input.a.page2.isam026"
            #本幣未稅金額
            IF NOT cl_null(g_apba2_d[l_ac].isam026) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam026) OR g_apba2_d[l_ac].isam026 != g_apba2_d_t.isam026) OR cl_null(g_apba2_d_t.isam026))) THEN
                  #紅字發票金額不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam026 >= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam026 = g_apba2_d_t.isam026
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam026 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam026 = g_apba2_d_t.isam026
                     NEXT FIELD CURRENT
                  END IF
                  
                  #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
                  #LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apbb_m.apbb015
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                  #
                  #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                  #LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 * (1+(g_apbb_m.apbb013/100))
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                  #
                  ##稅額=含稅-未稅
                  #LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026  

                  #150422-00026#1 add ---
                  #稅額=含稅-未稅
                  LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026

                  #匯率>>2.以含稅金額重計匯率
                  LET g_apba2_d[l_ac].isam015 = g_apba2_d[l_ac].isam028 / g_apba2_d[l_ac].isam025
                  #150422-00026#1 end ---

               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam026
            #add-point:ON CHANGE isam026 name="input.g.page2.isam026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam027
            #add-point:BEFORE FIELD isam027 name="input.b.page2.isam027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam027
            
            #add-point:AFTER FIELD isam027 name="input.a.page2.isam027"
            IF NOT cl_null(g_apba2_d[l_ac].isam027) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam027) OR g_apba2_d[l_ac].isam027 != g_apba2_d_t.isam027) OR cl_null(g_apba2_d_t.isam027))) THEN
                  #紅字發票金額不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam027 >= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam027 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核容差率
                  CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028)
                  RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
                  #容差率OK否
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam027
            #add-point:ON CHANGE isam027 name="input.g.page2.isam027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam028
            #add-point:BEFORE FIELD isam028 name="input.b.page2.isam028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam028
            
            #add-point:AFTER FIELD isam028 name="input.a.page2.isam028"
            #本幣含稅金額
            IF NOT cl_null(g_apba2_d[l_ac].isam028) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam028) OR g_apba2_d[l_ac].isam028 != g_apba2_d_t.isam028) OR cl_null(g_apba2_d_t.isam028))) THEN
                  #紅字發票金額不可為正數
                  IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam028 >= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam028 = g_apba2_d_t.isam028
                     NEXT FIELD CURRENT
                  END IF
                  #藍字發票不可為負數 #150515 add
                  IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam028 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00365'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam028 = g_apba2_d_t.isam028
                     NEXT FIELD CURRENT
                  END IF
                  
                  #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
                  #LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025 * g_apbb_m.apbb015
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                  #
                  #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
                  #LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 / (1+(g_apbb_m.apbb013/100))
                  #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                  #
                  ##稅額=含稅-未稅
                  #LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026                

                  #150422-00026#1 add ---
                  LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026

                  #匯率>>2.以含稅金額重計匯率
                  LET g_apba2_d[l_ac].isam015 = g_apba2_d[l_ac].isam028 / g_apba2_d[l_ac].isam025
                  #150422-00026#1 end ---
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam028
            #add-point:ON CHANGE isam028 name="input.g.page2.isam028"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamseq
            #add-point:ON ACTION controlp INFIELD isamseq name="input.c.page2.isamseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam008
            #add-point:ON ACTION controlp INFIELD isam008 name="input.c.page2.isam008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apba2_d[g_detail_idx].isam008
            #紅字發票與藍字發票是否共用發票簿
            #161230-00036#1 mark ------
            #SELECT isai006 INTO g_isai006
            #  FROM ooef_t
            #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
            # WHERE ooefent = g_enterprise
            #   AND ooef001 = g_apbb_m.apbbcomp
            #161230-00036#1 mark end---
            CASE g_apbb_m.apbb050
               WHEN "1"
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '1'"
               WHEN "2"
                  IF g_isai006 = "Y" THEN
                     LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
                  ELSE
                     LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '3'"
                  END IF
               OTHERWISE
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
            END CASE
            CALL q_isac002()
            LET g_apba2_d[g_detail_idx].isam008 = g_qryparam.return1
            DISPLAY BY NAME g_apba2_d[g_detail_idx].isam008
            NEXT FIELD isam008
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam037
            #add-point:ON ACTION controlp INFIELD isam037 name="input.c.page2.isam037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam011
            #add-point:ON ACTION controlp INFIELD isam011 name="input.c.page2.isam011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam009
            #add-point:ON ACTION controlp INFIELD isam009 name="input.c.page2.isam009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam010
            #add-point:ON ACTION controlp INFIELD isam010 name="input.c.page2.isam010"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam200
            #add-point:ON ACTION controlp INFIELD isam200 name="input.c.page2.isam200"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam030
            #add-point:ON ACTION controlp INFIELD isam030 name="input.c.page2.isam030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam014
            #add-point:ON ACTION controlp INFIELD isam014 name="input.c.page2.isam014"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam015
            #add-point:ON ACTION controlp INFIELD isam015 name="input.c.page2.isam015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam023
            #add-point:ON ACTION controlp INFIELD isam023 name="input.c.page2.isam023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam024
            #add-point:ON ACTION controlp INFIELD isam024 name="input.c.page2.isam024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam025
            #add-point:ON ACTION controlp INFIELD isam025 name="input.c.page2.isam025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam026
            #add-point:ON ACTION controlp INFIELD isam026 name="input.c.page2.isam026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam027
            #add-point:ON ACTION controlp INFIELD isam027 name="input.c.page2.isam027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam028
            #add-point:ON ACTION controlp INFIELD isam028 name="input.c.page2.isam028"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
 
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apba2_d[l_ac].* = g_apba2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt110_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt110_unlock_b("isam_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
 
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            #更新單頭金額
            IF cl_ask_confirm('aap-00210') THEN
               CALL aapt110_money_update_to_head("isam","Y")
            END IF
            
            #發票號碼兩筆以上且不為空白，則更新apbb010為MULTI，一筆就回寫到單頭的apbb010
            SELECT COUNT(*) INTO l_cnt
             FROM isam_t
             WHERE isament = g_enterprise
               AND isamdocno = g_apbb_m.apbbdocno
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF (l_cnt = 1) AND NOT cl_null(g_apba2_d[1].isam010) THEN
               LET g_apbb_m.apbb009 = g_apba2_d[1].isam009
               LET g_apbb_m.apbb010 = g_apba2_d[1].isam010
               LET g_apbb_m.apbb011 = g_apba2_d[1].isam011  #170218-00030#1 add
            ELSE
               IF l_cnt > 1 THEN #發票兩筆以上
                  LET g_apbb_m.apbb009 = ""
                  LET g_apbb_m.apbb010 = "MULTI"
               ELSE
                  LET g_apbb_m.apbb009 = ""
                  LET g_apbb_m.apbb010 = ""
               END IF
            END IF
            UPDATE apbb_t SET apbb009 = g_apbb_m.apbb009,
                              apbb010 = g_apbb_m.apbb010,
                              apbb011 = g_apbb_m.apbb011  #170218-00030#1 add
             WHERE apbbent = g_enterprise
               AND apbbdocno = g_apbb_m.apbbdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE apbb_t wrong!" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            DISPLAY BY NAME g_apbb_m.apbb009,g_apbb_m.apbb010,
                            g_apbb_m.apbb011  #170218-00030#1 add
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apba2_d[li_reproduce_target].* = g_apba2_d[li_reproduce].*
 
               LET g_apba2_d[li_reproduce_target].isamseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apba2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apba2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apba3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apba3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt110_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apba3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apba3_d[l_ac].* TO NULL 
            INITIALIZE g_apba3_d_t.* TO NULL 
            INITIALIZE g_apba3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_apba3_d_t.* = g_apba3_d[l_ac].*     #新輸入資料
            LET g_apba3_d_o.* = g_apba3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt110_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt110_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apba3_d[li_reproduce_target].* = g_apba3_d[li_reproduce].*
 
               LET g_apba3_d[li_reproduce_target].isauseq = NULL
               LET g_apba3_d[li_reproduce_target].isau003 = NULL
               LET g_apba3_d[li_reproduce_target].isau004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
 
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt110_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apba3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apba3_d[l_ac].isauseq IS NOT NULL
               AND g_apba3_d[l_ac].isau003 IS NOT NULL
               AND g_apba3_d[l_ac].isau004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apba3_d_t.* = g_apba3_d[l_ac].*  #BACKUP
               LET g_apba3_d_o.* = g_apba3_d[l_ac].*  #BACKUP
               CALL aapt110_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aapt110_set_no_entry_b(l_cmd)
               IF NOT aapt110_lock_b("isau_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt110_bcl3 INTO g_apba3_d[l_ac].isau003,g_apba3_d[l_ac].isau004,g_apba3_d[l_ac].isauseq, 
                      g_apba3_d[l_ac].isau007,g_apba3_d[l_ac].isau008,g_apba3_d[l_ac].isau014,g_apba3_d[l_ac].isau015, 
                      g_apba3_d[l_ac].isau016,g_apba3_d[l_ac].isau017,g_apba3_d[l_ac].isau018,g_apba3_d[l_ac].isau019, 
                      g_apba3_d[l_ac].isau020,g_apba3_d[l_ac].isau208
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apba3_d_mask_o[l_ac].* =  g_apba3_d[l_ac].*
                  CALL aapt110_isau_t_mask()
                  LET g_apba3_d_mask_n[l_ac].* =  g_apba3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt110_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apbb_m.apbbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isauseq
               LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isau003
               LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isau004
            
               #刪除同層單身
               IF NOT aapt110_delete_b('isau_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt110_key_delete_b(gs_keys,'isau_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt110_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt110_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_apba_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apba3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM isau_t 
             WHERE isauent = g_enterprise AND isaudocno = g_apbb_m.apbbdocno
               AND isauseq = g_apba3_d[l_ac].isauseq
               AND isau003 = g_apba3_d[l_ac].isau003
               AND isau004 = g_apba3_d[l_ac].isau004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys[2] = g_apba3_d[g_detail_idx].isauseq
               LET gs_keys[3] = g_apba3_d[g_detail_idx].isau003
               LET gs_keys[4] = g_apba3_d[g_detail_idx].isau004
               CALL aapt110_insert_b('isau_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apba_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt110_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apba3_d[l_ac].* = g_apba3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt110_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apba3_d[l_ac].* = g_apba3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aapt110_isau_t_mask_restore('restore_mask_o')
                              
               UPDATE isau_t SET (isaudocno,isau003,isau004,isauseq,isau007,isau008,isau014,isau015, 
                   isau016,isau017,isau018,isau019,isau020,isau208) = (g_apbb_m.apbbdocno,g_apba3_d[l_ac].isau003, 
                   g_apba3_d[l_ac].isau004,g_apba3_d[l_ac].isauseq,g_apba3_d[l_ac].isau007,g_apba3_d[l_ac].isau008, 
                   g_apba3_d[l_ac].isau014,g_apba3_d[l_ac].isau015,g_apba3_d[l_ac].isau016,g_apba3_d[l_ac].isau017, 
                   g_apba3_d[l_ac].isau018,g_apba3_d[l_ac].isau019,g_apba3_d[l_ac].isau020,g_apba3_d[l_ac].isau208)  
                   #自訂欄位頁簽
                WHERE isauent = g_enterprise AND isaudocno = g_apbb_m.apbbdocno
                  AND isauseq = g_apba3_d_t.isauseq #項次 
                  AND isau003 = g_apba3_d_t.isau003
                  AND isau004 = g_apba3_d_t.isau004
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apba3_d[l_ac].* = g_apba3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isau_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apba3_d[l_ac].* = g_apba3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apbb_m.apbbdocno
               LET gs_keys_bak[1] = g_apbbdocno_t
               LET gs_keys[2] = g_apba3_d[g_detail_idx].isauseq
               LET gs_keys_bak[2] = g_apba3_d_t.isauseq
               LET gs_keys[3] = g_apba3_d[g_detail_idx].isau003
               LET gs_keys_bak[3] = g_apba3_d_t.isau003
               LET gs_keys[4] = g_apba3_d[g_detail_idx].isau004
               LET gs_keys_bak[4] = g_apba3_d_t.isau004
               CALL aapt110_update_b('isau_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt110_isau_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apba3_d[g_detail_idx].isauseq = g_apba3_d_t.isauseq 
                  AND g_apba3_d[g_detail_idx].isau003 = g_apba3_d_t.isau003 
                  AND g_apba3_d[g_detail_idx].isau004 = g_apba3_d_t.isau004 
                  ) THEN
                  LET gs_keys[01] = g_apbb_m.apbbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isauseq
                  LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isau003
                  LET gs_keys[gs_keys.getLength()+1] = g_apba3_d_t.isau004
                  CALL aapt110_key_update_b(gs_keys,'isau_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba3_d_t)
               LET g_log2 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau003
            #add-point:BEFORE FIELD isau003 name="input.b.page3.isau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau003
            
            #add-point:AFTER FIELD isau003 name="input.a.page3.isau003"
            #此段落由子樣板a05產生
          # #確認資料無重複
          # IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isaudocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
          #    IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isaudocno != g_apba3_d_t.isaudocno OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
          #       IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isaudocno ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau003 ||"'",'std-00004',0) THEN 
          #          NEXT FIELD CURRENT
          #       END IF
          #    END IF
          # END IF


            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isau003 ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau003
            #add-point:ON CHANGE isau003 name="input.g.page3.isau003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau004
            #add-point:BEFORE FIELD isau004 name="input.b.page3.isau004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau004
            
            #add-point:AFTER FIELD isau004 name="input.a.page3.isau004"
            #此段落由子樣板a05產生
            #確認資料無重複
          # IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isaudocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
          #    IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isaudocno != g_apba3_d_t.isaudocno OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
          #       IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isaudocno ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau003 ||"'",'std-00004',0) THEN 
          #          NEXT FIELD CURRENT
          #       END IF
          #    END IF
          # END IF


            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isau003 ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau004
            #add-point:ON CHANGE isau004 name="input.g.page3.isau004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isauseq
            #add-point:BEFORE FIELD isauseq name="input.b.page3.isauseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isauseq
            
            #add-point:AFTER FIELD isauseq name="input.a.page3.isauseq"
            #此段落由子樣板a05產生
            #確認資料無重複
           #IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isaudocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
           #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isaudocno != g_apba3_d_t.isaudocno OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
           #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isaudocno ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau003 ||"'",'std-00004',0) THEN 
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF


            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba3_d[g_detail_idx].isauseq IS NOT NULL AND g_apba3_d[g_detail_idx].isau003 IS NOT NULL AND g_apba3_d[g_detail_idx].isau004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba3_d[g_detail_idx].isauseq != g_apba3_d_t.isauseq OR g_apba3_d[g_detail_idx].isau003 != g_apba3_d_t.isau003 OR g_apba3_d[g_detail_idx].isau004 != g_apba3_d_t.isau004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isau_t WHERE "||"isauent = '" ||g_enterprise|| "' AND "||"isaudocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isauseq = '"||g_apba3_d[g_detail_idx].isauseq ||"' AND "|| "isau003 = '"||g_apba3_d[g_detail_idx].isau003 ||"' AND "|| "isau004 = '"||g_apba3_d[g_detail_idx].isau004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isauseq
            #add-point:ON CHANGE isauseq name="input.g.page3.isauseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau007
            #add-point:BEFORE FIELD isau007 name="input.b.page3.isau007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau007
            
            #add-point:AFTER FIELD isau007 name="input.a.page3.isau007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau007
            #add-point:ON CHANGE isau007 name="input.g.page3.isau007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau008
            #add-point:BEFORE FIELD isau008 name="input.b.page3.isau008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau008
            
            #add-point:AFTER FIELD isau008 name="input.a.page3.isau008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau008
            #add-point:ON CHANGE isau008 name="input.g.page3.isau008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau014
            #add-point:BEFORE FIELD isau014 name="input.b.page3.isau014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau014
            
            #add-point:AFTER FIELD isau014 name="input.a.page3.isau014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau014
            #add-point:ON CHANGE isau014 name="input.g.page3.isau014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau015
            #add-point:BEFORE FIELD isau015 name="input.b.page3.isau015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau015
            
            #add-point:AFTER FIELD isau015 name="input.a.page3.isau015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau015
            #add-point:ON CHANGE isau015 name="input.g.page3.isau015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau016
            #add-point:BEFORE FIELD isau016 name="input.b.page3.isau016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau016
            
            #add-point:AFTER FIELD isau016 name="input.a.page3.isau016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau016
            #add-point:ON CHANGE isau016 name="input.g.page3.isau016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau017
            #add-point:BEFORE FIELD isau017 name="input.b.page3.isau017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau017
            
            #add-point:AFTER FIELD isau017 name="input.a.page3.isau017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau017
            #add-point:ON CHANGE isau017 name="input.g.page3.isau017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau018
            #add-point:BEFORE FIELD isau018 name="input.b.page3.isau018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau018
            
            #add-point:AFTER FIELD isau018 name="input.a.page3.isau018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau018
            #add-point:ON CHANGE isau018 name="input.g.page3.isau018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau019
            #add-point:BEFORE FIELD isau019 name="input.b.page3.isau019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau019
            
            #add-point:AFTER FIELD isau019 name="input.a.page3.isau019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau019
            #add-point:ON CHANGE isau019 name="input.g.page3.isau019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau020
            #add-point:BEFORE FIELD isau020 name="input.b.page3.isau020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau020
            
            #add-point:AFTER FIELD isau020 name="input.a.page3.isau020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau020
            #add-point:ON CHANGE isau020 name="input.g.page3.isau020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isau208
            #add-point:BEFORE FIELD isau208 name="input.b.page3.isau208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isau208
            
            #add-point:AFTER FIELD isau208 name="input.a.page3.isau208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isau208
            #add-point:ON CHANGE isau208 name="input.g.page3.isau208"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.isau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau003
            #add-point:ON ACTION controlp INFIELD isau003 name="input.c.page3.isau003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau004
            #add-point:ON ACTION controlp INFIELD isau004 name="input.c.page3.isau004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isauseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isauseq
            #add-point:ON ACTION controlp INFIELD isauseq name="input.c.page3.isauseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau007
            #add-point:ON ACTION controlp INFIELD isau007 name="input.c.page3.isau007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau008
            #add-point:ON ACTION controlp INFIELD isau008 name="input.c.page3.isau008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau014
            #add-point:ON ACTION controlp INFIELD isau014 name="input.c.page3.isau014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau015
            #add-point:ON ACTION controlp INFIELD isau015 name="input.c.page3.isau015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau016
            #add-point:ON ACTION controlp INFIELD isau016 name="input.c.page3.isau016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau017
            #add-point:ON ACTION controlp INFIELD isau017 name="input.c.page3.isau017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau018
            #add-point:ON ACTION controlp INFIELD isau018 name="input.c.page3.isau018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau019
            #add-point:ON ACTION controlp INFIELD isau019 name="input.c.page3.isau019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau020
            #add-point:ON ACTION controlp INFIELD isau020 name="input.c.page3.isau020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.isau208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isau208
            #add-point:ON ACTION controlp INFIELD isau208 name="input.c.page3.isau208"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apba3_d[l_ac].* = g_apba3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt110_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt110_unlock_b("isau_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apba3_d[li_reproduce_target].* = g_apba3_d[li_reproduce].*
 
               LET g_apba3_d[li_reproduce_target].isauseq = NULL
               LET g_apba3_d[li_reproduce_target].isau003 = NULL
               LET g_apba3_d[li_reproduce_target].isau004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apba3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apba3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt110.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apbbdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apbaseq
               WHEN "s_detail2"
                  NEXT FIELD isamseq
               WHEN "s_detail3"
                  NEXT FIELD isau003
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL s_transaction_begin()    #albireo 150711 add
   CALL cl_err_collect_init()   #albireo 150711 add
   CALL aapt110_diff_recount_entrance('N') RETURNING g_sub_success   #20150617 add lujh
   IF g_sub_success THEN
      CALL cl_err_collect_show()        #albireo 150711 add
      CALL s_transaction_end('Y','0')   #albireo 150711 add
   ELSE
      CALL cl_err_collect_show()        #albireo 150711 add
      CALL s_transaction_end('N','0')   #albireo 150711 add
   END IF
#20150317--add--str--
   IF l_flag = 'Y' THEN                
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
END WHILE
#20150317--add--end--
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt110_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt110_b_fill() #單身填充
      CALL aapt110_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt110_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL aapt110_set_info()
   #帳務中心
   CALL s_desc_get_department_desc(g_apbb_m.apbb004) RETURNING g_apbb_m.l_apbb004_desc
   #公司法人
   CALL s_desc_get_department_desc(g_apbb_m.apbbcomp) RETURNING g_apbb_m.l_apbbcomp_desc
   #登錄人員
   CALL s_desc_get_person_desc(g_apbb_m.apbb053) RETURNING g_apbb_m.l_apbb053_desc
   #單別
   CALL s_aooi200_fin_get_slip_desc(g_apbb_m.apbbdocno) RETURNING g_apbb_m.l_apbbdocno_desc
   #發票類型
   CALL s_desc_get_invoice_type_desc(g_ld,g_apbb_m.apbb008) RETURNING g_apbb_m.l_apbb008_desc
   #交易對象
   CALL s_desc_get_trading_partner_abbr_desc(g_apbb_m.apbb002) RETURNING g_apbb_m.l_apbb002_desc
   #採購人員
   CALL s_desc_get_person_desc(g_apbb_m.apbb051) RETURNING g_apbb_m.l_apbb051_desc
   #採購部門
   CALL s_desc_get_department_desc(g_apbb_m.apbb052) RETURNING g_apbb_m.l_apbb052_desc
   #付款條件
   CALL s_desc_get_ooib002_desc(g_apbb_m.apbb054) RETURNING g_apbb_m.l_apbb054_desc
   #稅別
   CALL s_desc_get_tax_desc(g_ooef019,g_apbb_m.apbb012) RETURNING g_apbb_m.l_apbb012_desc

   #160802-00007#5-----s
   IF cl_null(g_apbb_m.apbb002) THEN
      LET g_apbb_m.apbb059 = ''
   END IF

   IF NOT cl_null(g_apbb_m.apbb059) THEN
      CALL s_axrt300_xrca_ref('xrca057',g_apbb_m.apbb059,'','') RETURNING g_sub_success,g_apbb_m.l_apbb002_desc
   END IF
   #160802-00007#5-----e

   #160705-00035#1 -s
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'1')
   #取得帳務組織底下所屬的法人範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apbacomp
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apbaorga
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(g_wc_apbacomp) RETURNING g_wc_apbacomp
   CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
   #160705-00035#1 -e
   
   #160826-00017#1   add---s
   #對帳單主畫面表尾合計
   IF NOT cl_null(g_apbb_m.apbbcomp) OR NOT cl_null(g_apbb_m.apbbdocno) THEN
      CALL aapt110_apbb_sum_button(g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,'')
         RETURNING g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                   g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
      DISPLAY BY NAME g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,
                      g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s
   END IF
   #160826-00017#1   add---e
   #end add-point
   
   #遮罩相關處理
   LET g_apbb_m_mask_o.* =  g_apbb_m.*
   CALL aapt110_apbb_t_mask()
   LET g_apbb_m_mask_n.* =  g_apbb_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.l_apbb004_desc,g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc, 
       g_apbb_m.apbb053,g_apbb_m.l_apbb053_desc,g_apbb_m.apbbdocno,g_apbb_m.l_apbbdocno_desc,g_apbb_m.apbbdocdt, 
       g_apbb_m.apbb002,g_apbb_m.l_apbb002_desc,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009, 
       g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc, 
       g_apbb_m.apbb054,g_apbb_m.l_apbb054_desc,g_apbb_m.apbb012,g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.l_apbb030_2,g_apbb_m.apbb031,g_apbb_m.apbb032, 
       g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019, 
       g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc,g_apbb_m.apbb203,g_apbb_m.apbb204, 
       g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc,g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.l_apbb036_2, 
       g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.l_apbb041_desc,g_apbb_m.apbb038, 
       g_apbb_m.l_apbb038_desc,g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118, 
       g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.l_apbb210_desc,g_apbb_m.apbbownid, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtid_desc, 
       g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmodid_desc, 
       g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfid_desc,g_apbb_m.apbbcnfdt,g_apbb_m.apba103_s, 
       g_apbb_m.apba104_s,g_apbb_m.apba105_s,g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apbb_m.apbbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_apba_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #160705-00035#1-s
      IF g_apba_d[l_ac].apba004 = '27' THEN
         SELECT apcc102 INTO g_apba_d[l_ac].l_apcc102
           FROM apcc_t
          WHERE apccent = g_enterprise
            AND apccdocno = g_apba_d[l_ac].apba005
            AND apccseq = g_apba_d[l_ac].apba006
            AND apcc001 = g_apba_d[l_ac].apba020
         DISPLAY BY NAME g_apba_d[l_ac].l_apcc102
      END IF
      
      #161129-00024#1 add s---
      CASE 
         WHEN g_apba_d[l_ac].apba004 = '10' #10:採購單
            SELECT pmdn015 INTO g_apba_d[l_ac].l_pmdt036 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = g_apba_d[l_ac].apba005 AND pmdnseq = g_apba_d[l_ac].apba006
            CALL cl_set_comp_visible("l_pmdt036",TRUE) 
            DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036                             
         WHEN g_apba_d[l_ac].apba004 = '11' OR g_apba_d[l_ac].apba004 = '21' OR g_apba_d[l_ac].apba004 = '20' #11:入庫單 #21:倉退單
            SELECT pmdt036 INTO g_apba_d[l_ac].l_pmdt036 FROM pmdt_t WHERE pmdtent = g_enterprise AND pmdtdocno = g_apba_d[l_ac].apba005 AND pmdtseq = g_apba_d[l_ac].apba006 
            CALL cl_set_comp_visible("l_pmdt036",TRUE)  
            DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036
         WHEN g_apba_d[l_ac].apba004 = '13' OR g_apba_d[l_ac].apba004 = '23'   
            SELECT rtib010 INTO g_apba_d[l_ac].l_pmdt036 FROM rtib_t WHERE rtibent = g_enterprise AND rtibdocno = g_apba_d[l_ac].apba005 AND rtibseq = g_apba_d[l_ac].apba006
            IF cl_null(g_apba_d[l_ac].l_pmdt036) THEN LET g_apba_d[l_ac].l_pmdt036 = 0 END IF
            DISPLAY BY NAME  g_apba_d[l_ac].l_pmdt036                   
      END CASE   
      #161129-00024#1 add e---      
      
      #160705-00035#1-e
      
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apba2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apba3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   #發票性質apbb050='2.紅字發票'才開放
   IF g_apbb_m.apbb050 = 2 THEN
      CALL cl_set_comp_visible("apba016,apba017",TRUE)
   ELSE
      CALL cl_set_comp_visible("apba016,apba017",FALSE)
   END IF
   #抓取"發票編碼方式"決定是否隱藏"發票代碼"
   CALL aapt110_set_entry_invoice_code()
   #抓取"電子發票否"決定是否開啟電子發票相關欄位
   IF g_apbb_m.apbb200 = "N" THEN
      CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",FALSE)
   ELSE
      CALL cl_set_comp_entry("apbb202,apbb203,apbb204,apbb205,apbb206,apbb207",TRUE)
   END IF
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt110_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt110_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt110_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apbb_t.apbbdocno 
   DEFINE l_oldno     LIKE apbb_t.apbbdocno 
 
   DEFINE l_master    RECORD LIKE apbb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apba_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE isam_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE isau_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_apbb_m.apbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
    
   LET g_apbb_m.apbbdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apbb_m.apbbownid = g_user
      LET g_apbb_m.apbbowndp = g_dept
      LET g_apbb_m.apbbcrtid = g_user
      LET g_apbb_m.apbbcrtdp = g_dept 
      LET g_apbb_m.apbbcrtdt = cl_get_current()
      LET g_apbb_m.apbbmodid = g_user
      LET g_apbb_m.apbbmoddt = cl_get_current()
      LET g_apbb_m.apbbstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #150127-00005#1
   LET g_apbb_m.apbbcnfid = ''
   LET g_apbb_m.apbbcnfdt = ''
   LET g_apbb_m.apbbownid_desc = ''
   LET g_apbb_m.apbbowndp_desc = ''
   LET g_apbb_m.apbbcrtid_desc = ''
   LET g_apbb_m.apbbcrtdp_desc = ''
   LET g_apbb_m.apbbmodid_desc = ''
   LET g_apbb_m.apbbcnfid_desc = ''
   LET g_apbb_m.l_apbbdocno_desc = '' #單別
   LET g_apbb_m.apbbdocdt = g_today   #登錄日期
   LET g_apbb_m.apbb011 = g_today     #發票日期
   LET g_apbb_m.apbb202 = ''
   LET g_apbb_m.l_apbb202_desc = ''
   LET g_apbb_m.apbb203 = ''
   LET g_apbb_m.apbb204 = ''
   LET g_apbb_m.apbb205 = 'N'
   LET g_apbb_m.apbb206 = ''
   LET g_apbb_m.apbb207 = ''
   LET g_apbb_m.l_apbb207_desc = ''
   LET g_apbb_m.l_apbb036_2 = ''
   LET g_apbb_m.apbb039 = ''
   LET g_apbb_m.apbb040 = ''
   LET g_apbb_m.apbb041 = ''
   LET g_apbb_m.l_apbb041_desc = ''
   LET g_apbb_m.apbb038 = ''
   LET g_apbb_m.l_apbb038_desc = ''
   LET g_apbb_m.apbb049 = ''
   LET g_apbb_m.apbb042 = ''
   LET g_apbb_m.apbb107 = ''
   LET g_apbb_m.apbb108 = ''
   LET g_apbb_m.apbb117 = ''
   LET g_apbb_m.apbb118 = ''
   LET g_apbb_m.apbb208 = ''
   LET g_apbb_m.apbb209 = ''
   LET g_apbb_m.apbb210 = ''
   LET g_apbb_m.l_apbb210_desc = ''
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apbb_m.apbbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aapt110_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apbb_m.* TO NULL
      INITIALIZE g_apba_d TO NULL
      INITIALIZE g_apba2_d TO NULL
      INITIALIZE g_apba3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt110_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt110_set_act_visible()   
   CALL aapt110_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apbbent = " ||g_enterprise|| " AND",
                      " apbbdocno = '", g_apbb_m.apbbdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt110_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt110_idx_chk()
   
   LET g_data_owner = g_apbb_m.apbbownid      
   LET g_data_dept  = g_apbb_m.apbbowndp
   
   #功能已完成,通報訊息中心
   CALL aapt110_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt110_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apba_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE isam_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE isau_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt110_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbbdocno_t
 
    INTO TEMP aapt110_detail
 
   #將key修正為調整後   
   UPDATE aapt110_detail 
      #更新key欄位
      SET apbadocno = g_apbb_m.apbbdocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, isamstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apba_t SELECT * FROM aapt110_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt110_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM isam_t 
    WHERE isament = g_enterprise AND isamdocno = g_apbbdocno_t
 
    INTO TEMP aapt110_detail
 
   #將key修正為調整後   
   UPDATE aapt110_detail SET isamdocno = g_apbb_m.apbbdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO isam_t SELECT * FROM aapt110_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt110_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM isau_t 
    WHERE isauent = g_enterprise AND isaudocno = g_apbbdocno_t
 
    INTO TEMP aapt110_detail
 
   #將key修正為調整後   
   UPDATE aapt110_detail SET isaudocno = g_apbb_m.apbbdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO isau_t SELECT * FROM aapt110_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt110_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt110_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success        LIKE type_t.num5    #20150629 add lujh
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apbb_m.apbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt110_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt110_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apbb_m_mask_o.* =  g_apbb_m.*
   CALL aapt110_apbb_t_mask()
   LET g_apbb_m_mask_n.* =  g_apbb_m.*
   
   CALL aapt110_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      #20150629--add--str--lujh
      CALL aapt110_aapt210_exist_chk() RETURNING l_success
      IF l_success = FALSE THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'aap-00377'
         LET g_errparam.extend = g_apbb_m.apbbdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      #20150629--add--end--lujh
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt110_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apbbdocno_t = g_apbb_m.apbbdocno
 
 
      DELETE FROM apbb_t
       WHERE apbbent = g_enterprise AND apbbdocno = g_apbb_m.apbbdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apbb_m.apbbdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_ld,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apba_t
       WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM isam_t
       WHERE isament = g_enterprise AND
             isamdocno = g_apbb_m.apbbdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM isau_t
       WHERE isauent = g_enterprise AND
             isaudocno = g_apbb_m.apbbdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apbb_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt110_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apba_d.clear() 
      CALL g_apba2_d.clear()       
      CALL g_apba3_d.clear()       
 
     
      CALL aapt110_ui_browser_refresh()  
      #CALL aapt110_ui_headershow()  
      #CALL aapt110_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt110_browser_fill("")
         CALL aapt110_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt110_cl
 
   #功能已完成,通報訊息中心
   CALL aapt110_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt110.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt110_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apba_d.clear()
   CALL g_apba2_d.clear()
   CALL g_apba3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt110_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apbaseq,apbaorga,apba004,apba005,apba006,apba020,apba019,apba007, 
             apba008,apba013,apba015,apba012,apba100,apba009,apba014,apba010,apba103,apba105,apba104, 
             apba113,apba115,apba114,apba016,apba017,apba111  FROM apba_t",   
                     " INNER JOIN apbb_t ON apbbent = " ||g_enterprise|| " AND apbbdocno = apbadocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE apbaent=? AND apbadocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apba_t.apbaseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt110_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt110_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apbb_m.apbbdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apbb_m.apbbdocno INTO g_apba_d[l_ac].apbaseq,g_apba_d[l_ac].apbaorga, 
          g_apba_d[l_ac].apba004,g_apba_d[l_ac].apba005,g_apba_d[l_ac].apba006,g_apba_d[l_ac].apba020, 
          g_apba_d[l_ac].apba019,g_apba_d[l_ac].apba007,g_apba_d[l_ac].apba008,g_apba_d[l_ac].apba013, 
          g_apba_d[l_ac].apba015,g_apba_d[l_ac].apba012,g_apba_d[l_ac].apba100,g_apba_d[l_ac].apba009, 
          g_apba_d[l_ac].apba014,g_apba_d[l_ac].apba010,g_apba_d[l_ac].apba103,g_apba_d[l_ac].apba105, 
          g_apba_d[l_ac].apba104,g_apba_d[l_ac].apba113,g_apba_d[l_ac].apba115,g_apba_d[l_ac].apba114, 
          g_apba_d[l_ac].apba016,g_apba_d[l_ac].apba017,g_apba_d[l_ac].apba111   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF aapt110_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT isamseq,isam008,isam037,isam011,isam009,isam010,isam200,isam030, 
             isam012,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036,isam050, 
             isamstus,isamcomp,isam001  FROM isam_t",   
                     " INNER JOIN  apbb_t ON apbbent = " ||g_enterprise|| " AND apbbdocno = isamdocno ",
 
                     "",
                     
                     
                     " WHERE isament=? AND isamdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY isam_t.isamseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt110_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt110_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_apbb_m.apbbdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_apbb_m.apbbdocno INTO g_apba2_d[l_ac].isamseq,g_apba2_d[l_ac].isam008, 
          g_apba2_d[l_ac].isam037,g_apba2_d[l_ac].isam011,g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010, 
          g_apba2_d[l_ac].isam200,g_apba2_d[l_ac].isam030,g_apba2_d[l_ac].isam012,g_apba2_d[l_ac].isam014, 
          g_apba2_d[l_ac].isam015,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025, 
          g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028,g_apba2_d[l_ac].isam036, 
          g_apba2_d[l_ac].isam050,g_apba2_d[l_ac].isamstus,g_apba2_d[l_ac].isamcomp,g_apba2_d[l_ac].isam001  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF aapt110_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT isau003,isau004,isauseq,isau007,isau008,isau014,isau015,isau016, 
             isau017,isau018,isau019,isau020,isau208  FROM isau_t",   
                     " INNER JOIN  apbb_t ON apbbent = " ||g_enterprise|| " AND apbbdocno = isaudocno ",
 
                     "",
                     
                     
                     " WHERE isauent=? AND isaudocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY isau_t.isauseq,isau_t.isau003,isau_t.isau004"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt110_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aapt110_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_apbb_m.apbbdocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_apbb_m.apbbdocno INTO g_apba3_d[l_ac].isau003,g_apba3_d[l_ac].isau004, 
          g_apba3_d[l_ac].isauseq,g_apba3_d[l_ac].isau007,g_apba3_d[l_ac].isau008,g_apba3_d[l_ac].isau014, 
          g_apba3_d[l_ac].isau015,g_apba3_d[l_ac].isau016,g_apba3_d[l_ac].isau017,g_apba3_d[l_ac].isau018, 
          g_apba3_d[l_ac].isau019,g_apba3_d[l_ac].isau020,g_apba3_d[l_ac].isau208   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_apba_d.deleteElement(g_apba_d.getLength())
   CALL g_apba2_d.deleteElement(g_apba2_d.getLength())
   CALL g_apba3_d.deleteElement(g_apba3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt110_pb
   FREE aapt110_pb2
 
   FREE aapt110_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apba_d.getLength()
      LET g_apba_d_mask_o[l_ac].* =  g_apba_d[l_ac].*
      CALL aapt110_apba_t_mask()
      LET g_apba_d_mask_n[l_ac].* =  g_apba_d[l_ac].*
   END FOR
   
   LET g_apba2_d_mask_o.* =  g_apba2_d.*
   FOR l_ac = 1 TO g_apba2_d.getLength()
      LET g_apba2_d_mask_o[l_ac].* =  g_apba2_d[l_ac].*
      CALL aapt110_isam_t_mask()
      LET g_apba2_d_mask_n[l_ac].* =  g_apba2_d[l_ac].*
   END FOR
   LET g_apba3_d_mask_o.* =  g_apba3_d.*
   FOR l_ac = 1 TO g_apba3_d.getLength()
      LET g_apba3_d_mask_o[l_ac].* =  g_apba3_d[l_ac].*
      CALL aapt110_isau_t_mask()
      LET g_apba3_d_mask_n[l_ac].* =  g_apba3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt110_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM apba_t
       WHERE apbaent = g_enterprise AND
         apbadocno = ps_keys_bak[1] AND apbaseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apba_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM isam_t
       WHERE isament = g_enterprise AND
             isamdocno = ps_keys_bak[1] AND isamseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apba2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM isau_t
       WHERE isauent = g_enterprise AND
             isaudocno = ps_keys_bak[1] AND isauseq = ps_keys_bak[2] AND isau003 = ps_keys_bak[3] AND isau004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_apba3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt110_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO apba_t
                  (apbaent,
                   apbadocno,
                   apbaseq
                   ,apbaorga,apba004,apba005,apba006,apba020,apba019,apba007,apba008,apba013,apba015,apba012,apba100,apba009,apba014,apba010,apba103,apba105,apba104,apba113,apba115,apba114,apba016,apba017,apba111) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apba_d[g_detail_idx].apbaorga,g_apba_d[g_detail_idx].apba004,g_apba_d[g_detail_idx].apba005, 
                       g_apba_d[g_detail_idx].apba006,g_apba_d[g_detail_idx].apba020,g_apba_d[g_detail_idx].apba019, 
                       g_apba_d[g_detail_idx].apba007,g_apba_d[g_detail_idx].apba008,g_apba_d[g_detail_idx].apba013, 
                       g_apba_d[g_detail_idx].apba015,g_apba_d[g_detail_idx].apba012,g_apba_d[g_detail_idx].apba100, 
                       g_apba_d[g_detail_idx].apba009,g_apba_d[g_detail_idx].apba014,g_apba_d[g_detail_idx].apba010, 
                       g_apba_d[g_detail_idx].apba103,g_apba_d[g_detail_idx].apba105,g_apba_d[g_detail_idx].apba104, 
                       g_apba_d[g_detail_idx].apba113,g_apba_d[g_detail_idx].apba115,g_apba_d[g_detail_idx].apba114, 
                       g_apba_d[g_detail_idx].apba016,g_apba_d[g_detail_idx].apba017,g_apba_d[g_detail_idx].apba111) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apba_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
 
      #end add-point 
      INSERT INTO isam_t
                  (isament,
                   isamdocno,
                   isamseq
                   ,isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam012,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036,isam050,isamstus,isamcomp,isam001) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apba2_d[g_detail_idx].isam008,g_apba2_d[g_detail_idx].isam037,g_apba2_d[g_detail_idx].isam011, 
                       g_apba2_d[g_detail_idx].isam009,g_apba2_d[g_detail_idx].isam010,g_apba2_d[g_detail_idx].isam200, 
                       g_apba2_d[g_detail_idx].isam030,g_apba2_d[g_detail_idx].isam012,g_apba2_d[g_detail_idx].isam014, 
                       g_apba2_d[g_detail_idx].isam015,g_apba2_d[g_detail_idx].isam023,g_apba2_d[g_detail_idx].isam024, 
                       g_apba2_d[g_detail_idx].isam025,g_apba2_d[g_detail_idx].isam026,g_apba2_d[g_detail_idx].isam027, 
                       g_apba2_d[g_detail_idx].isam028,g_apba2_d[g_detail_idx].isam036,g_apba2_d[g_detail_idx].isam050, 
                       g_apba2_d[g_detail_idx].isamstus,g_apba2_d[g_detail_idx].isamcomp,g_apba2_d[g_detail_idx].isam001) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apba2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      #將單頭其餘資訊寫入
      UPDATE isam_t SET (isam002,isam004,isam0121,isam013,isam017,
                         isam018,isam019,isam020,isam021,isam029,
                         isam031,isam032,isam033,isam034,isam038,
                         isam039,isam040,isam041,isam042,isam049,
                         isam107,isam108,isam117,isam118,isam202,
                         isam203,isam204,isam205,isam206,isam207,
                         isam208,isam209,isam210) = 
                        (g_apbb_m.apbb002,g_apbb_m.apbb004,g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb017,
                         g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb029,
                         g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb038,
                         g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb042,g_apbb_m.apbb049,
                         g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb202,
                         g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb205,g_apbb_m.apbb206,g_apbb_m.apbb207,
                         g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210)
      WHERE isament = g_enterprise
        AND isamdocno = ps_keys[1]
        AND isamseq = ps_keys[2]
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO isau_t
                  (isauent,
                   isaudocno,
                   isauseq,isau003,isau004
                   ,isau007,isau008,isau014,isau015,isau016,isau017,isau018,isau019,isau020,isau208) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_apba3_d[g_detail_idx].isau007,g_apba3_d[g_detail_idx].isau008,g_apba3_d[g_detail_idx].isau014, 
                       g_apba3_d[g_detail_idx].isau015,g_apba3_d[g_detail_idx].isau016,g_apba3_d[g_detail_idx].isau017, 
                       g_apba3_d[g_detail_idx].isau018,g_apba3_d[g_detail_idx].isau019,g_apba3_d[g_detail_idx].isau020, 
                       g_apba3_d[g_detail_idx].isau208)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_apba3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt110_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apba_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt110_apba_t_mask_restore('restore_mask_o')
               
      UPDATE apba_t 
         SET (apbadocno,
              apbaseq
              ,apbaorga,apba004,apba005,apba006,apba020,apba019,apba007,apba008,apba013,apba015,apba012,apba100,apba009,apba014,apba010,apba103,apba105,apba104,apba113,apba115,apba114,apba016,apba017,apba111) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apba_d[g_detail_idx].apbaorga,g_apba_d[g_detail_idx].apba004,g_apba_d[g_detail_idx].apba005, 
                  g_apba_d[g_detail_idx].apba006,g_apba_d[g_detail_idx].apba020,g_apba_d[g_detail_idx].apba019, 
                  g_apba_d[g_detail_idx].apba007,g_apba_d[g_detail_idx].apba008,g_apba_d[g_detail_idx].apba013, 
                  g_apba_d[g_detail_idx].apba015,g_apba_d[g_detail_idx].apba012,g_apba_d[g_detail_idx].apba100, 
                  g_apba_d[g_detail_idx].apba009,g_apba_d[g_detail_idx].apba014,g_apba_d[g_detail_idx].apba010, 
                  g_apba_d[g_detail_idx].apba103,g_apba_d[g_detail_idx].apba105,g_apba_d[g_detail_idx].apba104, 
                  g_apba_d[g_detail_idx].apba113,g_apba_d[g_detail_idx].apba115,g_apba_d[g_detail_idx].apba114, 
                  g_apba_d[g_detail_idx].apba016,g_apba_d[g_detail_idx].apba017,g_apba_d[g_detail_idx].apba111)  
 
         WHERE apbaent = g_enterprise AND apbadocno = ps_keys_bak[1] AND apbaseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apba_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apba_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt110_apba_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "isam_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt110_isam_t_mask_restore('restore_mask_o')
               
      UPDATE isam_t 
         SET (isamdocno,
              isamseq
              ,isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam012,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036,isam050,isamstus,isamcomp,isam001) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apba2_d[g_detail_idx].isam008,g_apba2_d[g_detail_idx].isam037,g_apba2_d[g_detail_idx].isam011, 
                  g_apba2_d[g_detail_idx].isam009,g_apba2_d[g_detail_idx].isam010,g_apba2_d[g_detail_idx].isam200, 
                  g_apba2_d[g_detail_idx].isam030,g_apba2_d[g_detail_idx].isam012,g_apba2_d[g_detail_idx].isam014, 
                  g_apba2_d[g_detail_idx].isam015,g_apba2_d[g_detail_idx].isam023,g_apba2_d[g_detail_idx].isam024, 
                  g_apba2_d[g_detail_idx].isam025,g_apba2_d[g_detail_idx].isam026,g_apba2_d[g_detail_idx].isam027, 
                  g_apba2_d[g_detail_idx].isam028,g_apba2_d[g_detail_idx].isam036,g_apba2_d[g_detail_idx].isam050, 
                  g_apba2_d[g_detail_idx].isamstus,g_apba2_d[g_detail_idx].isamcomp,g_apba2_d[g_detail_idx].isam001)  
 
         WHERE isament = g_enterprise AND isamdocno = ps_keys_bak[1] AND isamseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt110_isam_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "isau_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt110_isau_t_mask_restore('restore_mask_o')
               
      UPDATE isau_t 
         SET (isaudocno,
              isauseq,isau003,isau004
              ,isau007,isau008,isau014,isau015,isau016,isau017,isau018,isau019,isau020,isau208) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_apba3_d[g_detail_idx].isau007,g_apba3_d[g_detail_idx].isau008,g_apba3_d[g_detail_idx].isau014, 
                  g_apba3_d[g_detail_idx].isau015,g_apba3_d[g_detail_idx].isau016,g_apba3_d[g_detail_idx].isau017, 
                  g_apba3_d[g_detail_idx].isau018,g_apba3_d[g_detail_idx].isau019,g_apba3_d[g_detail_idx].isau020, 
                  g_apba3_d[g_detail_idx].isau208) 
         WHERE isauent = g_enterprise AND isaudocno = ps_keys_bak[1] AND isauseq = ps_keys_bak[2] AND isau003 = ps_keys_bak[3] AND isau004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isau_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isau_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt110_isau_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt110_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt110_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt110_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL aapt110_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apba_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt110_bcl USING g_enterprise,
                                       g_apbb_m.apbbdocno,g_apba_d[g_detail_idx].apbaseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt110_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "isam_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt110_bcl2 USING g_enterprise,
                                             g_apbb_m.apbbdocno,g_apba2_d[g_detail_idx].isamseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt110_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "isau_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt110_bcl3 USING g_enterprise,
                                             g_apbb_m.apbbdocno,g_apba3_d[g_detail_idx].isauseq,g_apba3_d[g_detail_idx].isau003, 
                                                 g_apba3_d[g_detail_idx].isau004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt110_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt110_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt110_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt110_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt110_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt110_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apbbdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apbbdocno",TRUE)
      CALL cl_set_comp_entry("apbbdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("apbbdocdt",TRUE)  #Reanna 150205 add
      #CALL cl_set_comp_entry("apbb004,apbbcomp,apbb050",TRUE) #151229-00001#2 #160705-00035#1 mark
      #CALL cl_set_comp_entry("apbb004,apbbcomp,apbb003",TRUE)  #160705-00035#1 #170223-00016#1 mark
      CALL cl_set_comp_entry("apbb004,apbbcomp",TRUE)               #170223-00016#1 add 移除apbb003
      #CALL cl_set_comp_entry("apbb002",TRUE)    #Reanna 160108 add #170223-00016#1 mark
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("apbb009,apbb010,apbb011",TRUE) #170218-00030#1 add
   CALL cl_set_comp_entry("apbb002,apbb003",TRUE)         #170223-00016#1 add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt110_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1   #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1   #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   DEFINE l_cnt       LIKE type_t.num10  #170218-00030#1 add
   DEFINE l_cnt1      LIKE type_t.num10  #170223-00016#1 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
 
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apbbdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("apbbdocdt",FALSE)  #Reanna 150205 add
      #CALL cl_set_comp_entry("apbb004,apbbcomp,apbb050",FALSE) #151229-00001#2 #160705-00035#1 mark
      #CALL cl_set_comp_entry("apbb004,apbbcomp,apbb003",FALSE)  #160705-00035#1 mark #170223-00016#1 mark 
      CALL cl_set_comp_entry("apbb004,apbbcomp",FALSE)  #170223-00016#1 add 移除原apbb003 FALSE 的控卡
      #CALL cl_set_comp_entry("apbb002",FALSE)    #Reanna 160108 add #170223-00016#1 mark
      
      #170223-00016#1 --s add
      LET l_cnt1 = 0
      SELECT COUNT(apbadocno) INTO l_cnt1
        FROM apba_t
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno
      IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF
      IF l_cnt1 > 0 THEN
         CALL cl_set_comp_entry("apbb002,apbb003",FALSE)
      END IF   
      #170223-00016#1 --e add
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apbbdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apbbdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2  -add -str
   IF NOT cl_null(g_apbb_m.apbbdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_apbb_m.apbbdocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_ld,g_apbb_m.apbbcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("apbbdocdt",TRUE)
      END IF        
      
      #170218-00030#1 add--s
      SELECT COUNT(1) INTO l_cnt FROM isam_t
       WHERE isament = g_enterprise
         AND isamdocno = g_apbb_m.apbbdocno
      IF l_cnt > 0  THEN
         CALL cl_set_comp_entry("apbb009,apbb010,apbb011",FALSE)
      END IF
      #170218-00030#1 add--e   
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt110_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt110_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   #20150601--add--str--lujh
   IF g_apbb_m.apbb056 = 'Y' THEN 
      CALL cl_set_comp_entry("apba014,apba010,apba103,apba105,apba104,apba113,apba115,apba114",FALSE)
   ELSE
      CALL cl_set_comp_entry("apba014,apba010,apba103,apba105,apba104,apba113,apba115,apba114",TRUE)
   END IF
   #20150601--add--end--lujh
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt110_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   #單據確認之後才可以補登發票
   IF g_apbb_m.apbbstus MATCHES "[Y]" THEN
      CALL cl_set_act_visible("invoice_mod", TRUE)
   END IF
   #單據未確認(已確認or作廢不算)才可以產生對帳明細
   #新增差異處理 150318-00010#1
   IF g_apbb_m.apbbstus MATCHES "[N]" THEN
      CALL cl_set_act_visible("aapt110_02,aapt110_09", TRUE)
   END IF
   
   CALL cl_set_act_visible("aapt110_02",TRUE)  #160705-00035#1
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt110_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_apbb_m.apbbstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   #單據確認之後才可以補登發票
   IF g_apbb_m.apbbstus NOT MATCHES "[Y]" OR cl_null(g_apbb_m.apbbstus) THEN
      CALL cl_set_act_visible("invoice_mod", FALSE)
   END IF
   #單據未確認(已確認or作廢不算)才可以產生對帳明細
   #新增差異處理 150318-00010#1
   IF g_apbb_m.apbbstus NOT MATCHES "[N]" OR cl_null(g_apbb_m.apbbstus) THEN
      CALL cl_set_act_visible("aapt110_02,aapt110_09", FALSE)
   END IF
   #160225-00001#1--(S)
   IF NOT cl_null(g_apbb_m.apbbdocno) THEN
      SELECT glaald INTO l_ld FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apbb_m.apbbcomp
         AND glaa014 = 'Y'
      CALL s_aooi200_fin_get_slip(g_apbb_m.apbbdocno) RETURNING g_sub_success,l_slip
      CALL s_fin_get_doc_para(l_ld,g_apbb_m.apbbcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      CALL s_fin_date_close_chk('@',g_apbb_m.apbbcomp,'AAP',g_apbb_m.apbbdocdt) RETURNING g_sub_success
      IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
         CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      END IF
   END IF
   #160225-00001#1--(E)
   
   #160705-00035#1-s
   #雜項發票不用彈自動產生
   IF g_apbb_m.apbb003 NOT MATCHES '[89]' THEN
      CALL cl_set_act_visible("aapt110_02",FALSE)
   END IF
   #160705-00035#1-e
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt110_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt110_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt110_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " apbbdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apbb_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apba_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "isam_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "isau_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt110_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success        LIKE type_t.num5    #20150629 add lujh
   DEFINE l_str9           LIKE type_t.chr9    #170218-00030#1 add
   DEFINE l_count          LIKE type_t.num5    #170218-00030#1 add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apbb_m.apbbdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
   IF STATUS THEN
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt110_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
       g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
       g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
       g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
       g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
       g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
       g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
       g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtdp, 
       g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp_desc, 
       g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt110_action_chk() THEN
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.l_apbb004_desc,g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc, 
       g_apbb_m.apbb053,g_apbb_m.l_apbb053_desc,g_apbb_m.apbbdocno,g_apbb_m.l_apbbdocno_desc,g_apbb_m.apbbdocdt, 
       g_apbb_m.apbb002,g_apbb_m.l_apbb002_desc,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050,g_apbb_m.apbb009, 
       g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc,g_apbb_m.apbb011, 
       g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052,g_apbb_m.l_apbb052_desc, 
       g_apbb_m.apbb054,g_apbb_m.l_apbb054_desc,g_apbb_m.apbb012,g_apbb_m.l_apbb012_desc,g_apbb_m.apbb0121, 
       g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
       g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
       g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.l_apbb030_2,g_apbb_m.apbb031,g_apbb_m.apbb032, 
       g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019, 
       g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc,g_apbb_m.apbb203,g_apbb_m.apbb204, 
       g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc,g_apbb_m.apbb206,g_apbb_m.apbb205,g_apbb_m.l_apbb036_2, 
       g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.l_apbb041_desc,g_apbb_m.apbb038, 
       g_apbb_m.l_apbb038_desc,g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118, 
       g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.l_apbb210_desc,g_apbb_m.apbbownid, 
       g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtid_desc, 
       g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmodid_desc, 
       g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfid_desc,g_apbb_m.apbbcnfdt,g_apbb_m.apba103_s, 
       g_apbb_m.apba104_s,g_apbb_m.apba105_s,g_apbb_m.apba113_s,g_apbb_m.apba114_s,g_apbb_m.apba115_s 
 
 
   CASE g_apbb_m.apbbstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_apbb_m.apbbstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
     
      CASE g_apbb_m.apbbstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aapt110_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt110_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt110_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt110_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #20150629--add--str--lujh
            CALL aapt110_aapt210_exist_chk() RETURNING l_success
            IF l_success = FALSE THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 'aap-00377'
               LET g_errparam.extend = g_apbb_m.apbbdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
               RETURN
            END IF
            #20150629--add--end--lujh
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_apbb_m.apbbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      #150722 mark ------
      ##albireo 150711 add-----s
      ##先差異處理再進行判斷
      #CALL aapt110_diff_recount_entrance('N') RETURNING g_sub_success
      #IF g_sub_success THEN
      #ELSE
      #   CALL cl_err_collect_show()
      #   CALL s_transaction_end('N','0')
      #   RETURN
      #END IF
      ##albrieo 150711 add-----e
      #150722 mark end---
      
      CALL s_aapt110_conf_chk(g_apbb_m.apbbdocno) RETURNING g_sub_success,g_apbb_m.apbb010
      DISPLAY BY NAME g_apbb_m.apbb010
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')     #albireo 150711 add
         #150722 add ------
         #check不OK在進來看要不要做差異分攤
         CALL s_transaction_begin()
         CALL cl_err_collect_init()
         CALL aapt110_diff_recount_entrance('N') RETURNING g_sub_success
         IF g_sub_success THEN
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
         END IF
         #150722 add end---
         RETURN
      ELSE
         #170218-00030#1 add--s
         SELECT COUNT(*) INTO l_count FROM isam_t
           WHERE isament  = g_enterprise
             AND isamdocno= g_apbb_m.apbbdocno
         IF l_count = 0 THEN
            LET l_str9 = 'aap-00610'  #发票信息未录入，是否执行审核？
         ELSE
            LET l_str9 = 'aim-00108'  #是否执行审核？
         END IF
         #170218-00030#1 add--e
         #170218-00030#1 mod--s
         #IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
         IF NOT cl_ask_confirm(l_str9) THEN   #是否執行確認？
         #170218-00030#1 mod--e
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')     #albireo 150711 add
            RETURN
         ELSE
            CALL s_transaction_begin()
            #20150601--add--str--lujh
            IF g_apbb_m.apbb056 = 'Y' THEN
               CALL s_aapt110_conf_ins(g_apbb_m.apbbdocno) RETURNING g_sub_success
            ELSE
            #20150601--add--end--lujh
               CALL s_aapt110_conf_upd(g_apbb_m.apbbdocno) RETURNING g_sub_success
            END IF   #20150601 add lujh
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      CALL s_aapt110_unconf_chk(g_apbb_m.apbbdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')     #albireo 150711 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')     #albireo 150711 add
            RETURN
         ELSE
            CALL s_transaction_begin()
            #20150601--add--str--lujh
            IF g_apbb_m.apbb056 = 'Y' THEN
               CALL s_aapt110_unconf_del(g_apbb_m.apbbdocno) RETURNING g_sub_success
            ELSE
               CALL s_aapt110_unconf_upd(g_apbb_m.apbbdocno) RETURNING g_sub_success
            END IF   #20150601 add lujh
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      CALL cl_err_collect_init()
      CALL s_aapt110_void_chk(g_apbb_m.apbbdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')     #albireo 150711 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行取消作廢？
            CALL s_transaction_end('N','0')     #albireo 150711 add
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt110_void_upd(g_apbb_m.apbbdocno,g_apbb_m.apbbcomp,g_apbb_m.apbb008) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_apbb_m.apbbmodid = g_user
   LET g_apbb_m.apbbmoddt = cl_get_current()
   LET g_apbb_m.apbbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apbb_t 
      SET (apbbstus,apbbmodid,apbbmoddt) 
        = (g_apbb_m.apbbstus,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt)     
    WHERE apbbent = g_enterprise AND apbbdocno = g_apbb_m.apbbdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aapt110_master_referesh USING g_apbb_m.apbbdocno INTO g_apbb_m.apbb004,g_apbb_m.apbbcomp, 
          g_apbb_m.apbb053,g_apbb_m.apbbdocno,g_apbb_m.apbbdocdt,g_apbb_m.apbb002,g_apbb_m.apbb059,g_apbb_m.apbb003, 
          g_apbb_m.apbb050,g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.apbb011, 
          g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.apbb052,g_apbb_m.apbb054,g_apbb_m.apbb012,g_apbb_m.apbb0121, 
          g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055,g_apbb_m.apbb056, 
          g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015,g_apbb_m.apbb026, 
          g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033, 
          g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,g_apbb_m.apbb019,g_apbb_m.apbb020, 
          g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.apbb206, 
          g_apbb_m.apbb205,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb038, 
          g_apbb_m.apbb049,g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208, 
          g_apbb_m.apbb209,g_apbb_m.apbb210,g_apbb_m.apbbownid,g_apbb_m.apbbowndp,g_apbb_m.apbbcrtid, 
          g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdt,g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid, 
          g_apbb_m.apbbcnfdt,g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp_desc,g_apbb_m.apbbcrtid_desc, 
          g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbmodid_desc,g_apbb_m.apbbcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apbb_m.apbb004,g_apbb_m.l_apbb004_desc,g_apbb_m.apbbcomp,g_apbb_m.l_apbbcomp_desc, 
          g_apbb_m.apbb053,g_apbb_m.l_apbb053_desc,g_apbb_m.apbbdocno,g_apbb_m.l_apbbdocno_desc,g_apbb_m.apbbdocdt, 
          g_apbb_m.apbb002,g_apbb_m.l_apbb002_desc,g_apbb_m.apbb059,g_apbb_m.apbb003,g_apbb_m.apbb050, 
          g_apbb_m.apbb009,g_apbb_m.apbb010,g_apbb_m.apbbstus,g_apbb_m.apbb008,g_apbb_m.l_apbb008_desc, 
          g_apbb_m.apbb011,g_apbb_m.apbb030,g_apbb_m.apbb051,g_apbb_m.l_apbb051_desc,g_apbb_m.apbb052, 
          g_apbb_m.l_apbb052_desc,g_apbb_m.apbb054,g_apbb_m.l_apbb054_desc,g_apbb_m.apbb012,g_apbb_m.l_apbb012_desc, 
          g_apbb_m.apbb0121,g_apbb_m.apbb013,g_apbb_m.apbb037,g_apbb_m.apbb036,g_apbb_m.apbb200,g_apbb_m.apbb055, 
          g_apbb_m.apbb056,g_apbb_m.apbb014,g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb015, 
          g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028,g_apbb_m.apbb029,g_apbb_m.l_apbb030_2,g_apbb_m.apbb031, 
          g_apbb_m.apbb032,g_apbb_m.apbb033,g_apbb_m.apbb034,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018, 
          g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021,g_apbb_m.apbb202,g_apbb_m.l_apbb202_desc, 
          g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb207,g_apbb_m.l_apbb207_desc,g_apbb_m.apbb206, 
          g_apbb_m.apbb205,g_apbb_m.l_apbb036_2,g_apbb_m.apbb042,g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041, 
          g_apbb_m.l_apbb041_desc,g_apbb_m.apbb038,g_apbb_m.l_apbb038_desc,g_apbb_m.apbb049,g_apbb_m.apbb107, 
          g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210, 
          g_apbb_m.l_apbb210_desc,g_apbb_m.apbbownid,g_apbb_m.apbbownid_desc,g_apbb_m.apbbowndp,g_apbb_m.apbbowndp_desc, 
          g_apbb_m.apbbcrtid,g_apbb_m.apbbcrtid_desc,g_apbb_m.apbbcrtdp,g_apbb_m.apbbcrtdp_desc,g_apbb_m.apbbcrtdt, 
          g_apbb_m.apbbmodid,g_apbb_m.apbbmodid_desc,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfid_desc, 
          g_apbb_m.apbbcnfdt,g_apbb_m.apba103_s,g_apbb_m.apba104_s,g_apbb_m.apba105_s,g_apbb_m.apba113_s, 
          g_apbb_m.apba114_s,g_apbb_m.apba115_s
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT apbbmodid,apbbmoddt,apbbcnfid,apbbcnfdt
     INTO g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt
     FROM apbb_t
    WHERE apbbent = g_enterprise
      AND apbbdocno = g_apbb_m.apbbdocno
   DISPLAY BY NAME g_apbb_m.apbbmodid,g_apbb_m.apbbmoddt,g_apbb_m.apbbcnfid,g_apbb_m.apbbcnfdt
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
 
   #end add-point  
 
   CLOSE aapt110_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt110_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt110.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt110_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apba_d.getLength() THEN
         LET g_detail_idx = g_apba_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apba_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apba_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_apba2_d.getLength() THEN
         LET g_detail_idx = g_apba2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apba2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apba2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_apba3_d.getLength() THEN
         LET g_detail_idx = g_apba3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apba3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apba3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt110_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aapt110_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt110_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110.status_show" >}
PRIVATE FUNCTION aapt110_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt110.mask_functions" >}
&include "erp/aap/aapt110_mask.4gl"
 
{</section>}
 
{<section id="aapt110.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt110_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aapt110_show()
   CALL aapt110_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aapt110_conf_chk(g_apbb_m.apbbdocno) RETURNING g_sub_success,g_apbb_m.apbb010
   DISPLAY BY NAME g_apbb_m.apbb010
   IF NOT g_sub_success THEN
      CLOSE aapt110_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apbb_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apba_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_apba2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_apba3_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt110_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt110_ui_headershow()
   CALL aapt110_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt110_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt110_ui_headershow()  
   CALL aapt110_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt110.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt110_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_apbb_m.apbbdocno
   LET g_pk_array[1].column = 'apbbdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt110.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt110.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt110_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL aapt110_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apbb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt110.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt110_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#1   2016/08/23  By 07900 --add-s-
   SELECT apbbstus INTO g_apbb_m.apbbstus
     FROM apbb_t
    WHERE apbbent = g_enterprise
      AND apbbdocno= g_apbb_m.apbbdocno
   
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail") THEN
      LET g_errno = NULL
     CASE g_apbb_m.apbbstus
        
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_apbb_m.apbbdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aapt110_set_act_visible()
        CALL aapt110_set_act_no_visible()
        CALL aapt110_show()
        RETURN FALSE
     END IF
   END IF   
   
   #160818-00017#1   2016/08/23  By 07900 --add-e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt110.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 用法人抓取相關值
# Memo...........:
# Usage..........: CALL aapt110_set_info()

# Date & Author..: 2015/01/27 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_set_info()
   
   #取得參數 #140806-00012#7
   CALL cl_get_para(g_enterprise,g_apbb_m.apbbcomp,'S-FIN-3007') RETURNING g_sfin3007
   
   #抓取稅區
   #SELECT ooef019 INTO g_ooef019  #161230-00036#1 mark
   SELECT ooef011,ooef019 INTO g_ooef011,g_ooef019  #161230-00036#1
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_apbb_m.apbbcomp
   
   #161230-00036#1 add ------
   #媒體申報格式/發票聯數
   SELECT isac004,isac008 INTO g_isac004,g_isac008
     FROM isac_t
    WHERE isacent = g_enterprise 
      AND isac002 = g_apbb_m.apbb008 AND isac001 = g_ooef019
      
   #發票編碼方式/紅字發票與藍字發票共用發票簿
   SELECT isai002,isai006 INTO g_isai002,g_isai006
     FROM isai_t
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
   #161230-00036#1 add end---
   
   #本幣幣別、帳套
   SELECT glaa001,glaald INTO g_glaa001,g_ld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apbb_m.apbbcomp
      AND glaa014 = 'Y'
   
   #151105-00001#8 --s
   IF NOT cl_null(g_apbb_m.apbb008) AND NOT cl_null(g_apbb_m.apbbcomp) THEN
      CALL aapt110_inv_visible(g_apbb_m.apbbcomp,g_apbb_m.apbb008)  
   END IF
   #151105-00001#8 --e
   
END FUNCTION

################################################################################
# Descriptions...: 帶出銷貨方訊息
# Memo...........:
# Usage..........: CALL aapt110_sale_info(p_apbbcomp,p_apbb002,p_apbbdocdt)
#                  RETURNING r_pmaal003,r_isak009,r_isak010,r_isak011,r_isak012
#                           ,r_pmaa003,r_pmab034,r_pmab033,r_oodb005,r_oodb006
#                           ,r_pmab037
# Input parameter: p_apbbcomp   法人
#                : p_apbb002    交易對象
#                : p_apbbdocdt  日期
# Return code....: r_pmaal003   銷貨方名稱
#                : r_isak009    地址
#                : r_isak010    電話
#                : r_isak011    開戶行
#                : r_isak012    帳號
#                : r_pmaa003    統一編號
#                : r_pmab033    稅別
#                : r_pmab034    匯率
#                : r_pmab033    稅別
#                : r_oodb005    含稅否
#                : r_oodb006    稅率
#                : r_pmab037    慣用交易條件
#                : r_apbb055    票到期日
#                : r_pmab031    採購人員
#                : r_pmab059    採購部門
# Date & Author..: 2014/10/05 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_sale_info(p_apbbcomp,p_apbb002,p_apbbdocdt)
DEFINE p_apbbcomp       LIKE apbb_t.apbbcomp
DEFINE p_apbb002        LIKE apbb_t.apbb002
DEFINE p_apbbdocdt      LIKE apbb_t.apbbdocdt
DEFINE r_pmaal003       LIKE pmaal_t.pmaal003
DEFINE r_isak008        LIKE isak_t.isak008
DEFINE r_isak009        LIKE isak_t.isak009
DEFINE r_isak010        LIKE isak_t.isak010
DEFINE r_isak011        LIKE isak_t.isak011
DEFINE r_isak012        LIKE isak_t.isak012
DEFINE r_pmaa003        LIKE pmaa_t.pmaa003
DEFINE r_pmab031        LIKE pmab_t.pmab031
DEFINE r_pmab033        LIKE pmab_t.pmab033
DEFINE r_pmab034        LIKE pmab_t.pmab034
DEFINE r_pmab037        LIKE pmab_t.pmab037
DEFINE r_pmab059        LIKE pmab_t.pmab059   #150318-00010#1
DEFINE r_oodb005        LIKE oodb_t.oodb005
DEFINE r_oodb006        LIKE oodb_t.oodb006
DEFINE l_date           LIKE apbb_t.apbb055            #141218-00011#1
DEFINE r_apbb055        LIKE apbb_t.apbb055   #票到期日 #141218-00011#1
DEFINE r_pmab056        LIKE pmab_t.pmab056   #161031-00042#1 add

   SELECT isak008,isak009,isak010,isak011,isak012
     INTO r_isak008,r_isak009,r_isak010,r_isak011,r_isak012
     FROM isak_t
    WHERE isakent = g_enterprise
      AND isak001 = p_apbb002

   #銷貨方名稱
   SELECT pmaal003 INTO r_pmaal003 FROM pmaal_t
    WHERE pmaalent = g_enterprise
      AND pmaal001 = p_apbb002
      AND pmaal002 = g_dlang

   #取得統一編號
   SELECT pmaa003 INTO r_pmaa003
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_apbb002

   #幣別&稅別&慣用交易條件&採購人員
   #150318-00010#1 add 採購部門
   #CALL s_apmm101_sel_pmab(p_apbbcomp,p_apbb002,"pmab033|pmab034|pmab037|pmab031|pmab059")           #161031-00042#1 mark
   #     RETURNING g_sub_success,g_errno,r_pmab033,r_pmab034,r_pmab037,r_pmab031,r_pmab059            #161031-00042#1 mark 
    CALL s_apmm101_sel_pmab(p_apbbcomp,p_apbb002,"pmab033|pmab034|pmab037|pmab031|pmab059|pmab056")   #161031-00042#1 add
         RETURNING g_sub_success,g_errno,r_pmab033,r_pmab034,r_pmab037,r_pmab031,r_pmab059,r_pmab056  #161031-00042#1 add
   
   #抓取含稅否&稅率
   SELECT oodb005,oodb006 INTO r_oodb005,r_oodb006
     FROM oodb_t
    WHERE oodbent = g_enterprise
      AND oodb001 = g_ooef019 #交易稅區
      AND oodb002 = r_pmab034
   
   #141218-00011#1 add ------
   #应付款日/应付票据到期日计算
   CALL s_fin_date_ap_payable(p_apbbcomp,p_apbb002,r_pmab037,p_apbbdocdt,p_apbbdocdt,p_apbbdocdt,p_apbbdocdt)
        #RETURNING g_sub_success,l_date,r_apbb055   #160929-00048#1 mark(調整#160910-00007#1)
        RETURNING g_sub_success,r_apbb055,l_date    #160929-00048#1 add(調整#160910-00007#1)
   #141218-00011#1 add end---
   
   #161230-00036#1 add ------
   #媒體申報格式/發票聯數
   SELECT isac004,isac008 INTO g_isac004,g_isac008
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac002 = r_pmab056 AND isac001 = g_ooef019
   #161230-00036#1 add end---
   
   RETURN r_pmaal003,r_isak009,r_isak010,r_isak011,r_isak012,
          r_pmaa003,r_pmab034,r_pmab033,r_oodb005,r_oodb006,
          r_pmab037,r_apbb055,r_pmab031,r_pmab059,r_pmab056   #141218-00011#1 add r_apbb055 #150318-00010#1 add r_pmab059  #161031-00042#1 add r_pmab056

END FUNCTION

################################################################################
# Descriptions...: 帶出購貨方訊息
# Memo...........:
# Usage..........: CALL aapt110_buy_info(p_apbbcomp)
#                  RETURNING r_pmaal003,r_isao001,r_isao002,r_isao003,r_isao004
#                           ,r_isao005
# Input parameter: p_apbbcomp   法人
# Return code....: r_pmaal003   購貨方名稱
#                : r_isao001    稅務編號
#                : r_isao002    地址
#                : r_isao003    電話
#                : r_isao004    開戶行
#                : r_isao005    帳號
# Date & Author..: 2014/10/06 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_buy_info(p_apbbcomp)
DEFINE p_apbbcomp       LIKE apbb_t.apbbcomp
DEFINE r_pmaal003       LIKE pmaal_t.pmaal003
DEFINE r_isao001        LIKE isao_t.isao001
DEFINE r_isao002        LIKE isao_t.isao002
DEFINE r_isao003        LIKE isao_t.isao003
DEFINE r_isao004        LIKE isao_t.isao004
DEFINE r_isao005        LIKE isao_t.isao005

   SELECT isao001,isao002,isao003,isao004,isao005
     INTO r_isao001,r_isao002,r_isao003,r_isao004,r_isao005
     FROM isao_t
    WHERE isaoent = g_enterprise
      AND isaosite = p_apbbcomp

   CALL s_desc_get_department_desc(p_apbbcomp) RETURNING r_pmaal003
   
   #151013-00019#13 add ------
   #這裡的稅務編號要改抓aooi100設定的
   SELECT ooef002 INTO r_isao001
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_apbbcomp
   #151013-00019#13 add end---
   
   RETURN r_pmaal003,r_isao001,r_isao002,r_isao003,r_isao004,
          r_isao005

END FUNCTION
################################################################################
# Descriptions...: 开窗批量产生单身
# Memo...........:
# Usage..........: CALL aapt110_qbevalue_ins_apba()

# Date & Author..: 2015/03/17 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_qbevalue_ins_apba(p_orga,p_source)
DEFINE p_orga           LIKE apba_t.apbaorga
DEFINE p_docno          LIKE apba_t.apbadocno
DEFINE p_seq            LIKE apba_t.apbaseq
DEFINE p_source         LIKE apba_t.apba004
DEFINE l_sql            STRING
DEFINE p_type           LIKE type_t.chr300
#DEFINE l_apba           RECORD LIKE apba_t.* #161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_apba RECORD  #進項發票明細檔
       apbaent   LIKE apba_t.apbaent, #企業編號
       apbadocno LIKE apba_t.apbadocno, #檔案號碼
       apbaorga  LIKE apba_t.apbaorga, #帳務歸屬組織
       apba001   LIKE apba_t.apba001, #發票類型
       apba002   LIKE apba_t.apba002, #發票編號
       apba003   LIKE apba_t.apba003, #發票號碼
       apbaseq   LIKE apba_t.apbaseq, #項次
       apba004   LIKE apba_t.apba004, #來源作業
       apba005   LIKE apba_t.apba005, #業務單號碼
       apba006   LIKE apba_t.apba006, #業務單項次
       apba007   LIKE apba_t.apba007, #產品編號
       apba008   LIKE apba_t.apba008, #品名規格
       apba009   LIKE apba_t.apba009, #單位
       apba010   LIKE apba_t.apba010, #發票數量
       apba011   LIKE apba_t.apba011, #暫估帳款數量
       apba012   LIKE apba_t.apba012, #正負值
       apba013   LIKE apba_t.apba013, #參考單號
       apba014   LIKE apba_t.apba014, #單價
       apba015   LIKE apba_t.apba015, #稅別
       apba016   LIKE apba_t.apba016, #扣抵發票編號
       apba017   LIKE apba_t.apba017, #扣抵藍字發票號碼
       apba100   LIKE apba_t.apba100, #交易原幣
       apba103   LIKE apba_t.apba103, #原幣未稅金額
       apba104   LIKE apba_t.apba104, #原幣稅額
       apba105   LIKE apba_t.apba105, #原幣含稅總額
       apba111   LIKE apba_t.apba111, #發票匯率
       apba113   LIKE apba_t.apba113, #發票幣未稅金額
       apba114   LIKE apba_t.apba114, #發票幣稅額
       apba115   LIKE apba_t.apba115, #發票幣含稅總額
       apbaud001 LIKE apba_t.apbaud001, #自定義欄位(文字)001
       apbaud002 LIKE apba_t.apbaud002, #自定義欄位(文字)002
       apbaud003 LIKE apba_t.apbaud003, #自定義欄位(文字)003
       apbaud004 LIKE apba_t.apbaud004, #自定義欄位(文字)004
       apbaud005 LIKE apba_t.apbaud005, #自定義欄位(文字)005
       apbaud006 LIKE apba_t.apbaud006, #自定義欄位(文字)006
       apbaud007 LIKE apba_t.apbaud007, #自定義欄位(文字)007
       apbaud008 LIKE apba_t.apbaud008, #自定義欄位(文字)008
       apbaud009 LIKE apba_t.apbaud009, #自定義欄位(文字)009
       apbaud010 LIKE apba_t.apbaud010, #自定義欄位(文字)010
       apbaud011 LIKE apba_t.apbaud011, #自定義欄位(數字)011
       apbaud012 LIKE apba_t.apbaud012, #自定義欄位(數字)012
       apbaud013 LIKE apba_t.apbaud013, #自定義欄位(數字)013
       apbaud014 LIKE apba_t.apbaud014, #自定義欄位(數字)014
       apbaud015 LIKE apba_t.apbaud015, #自定義欄位(數字)015
       apbaud016 LIKE apba_t.apbaud016, #自定義欄位(數字)016
       apbaud017 LIKE apba_t.apbaud017, #自定義欄位(數字)017
       apbaud018 LIKE apba_t.apbaud018, #自定義欄位(數字)018
       apbaud019 LIKE apba_t.apbaud019, #自定義欄位(數字)019
       apbaud020 LIKE apba_t.apbaud020, #自定義欄位(數字)020
       apbaud021 LIKE apba_t.apbaud021, #自定義欄位(日期時間)021
       apbaud022 LIKE apba_t.apbaud022, #自定義欄位(日期時間)022
       apbaud023 LIKE apba_t.apbaud023, #自定義欄位(日期時間)023
       apbaud024 LIKE apba_t.apbaud024, #自定義欄位(日期時間)024
       apbaud025 LIKE apba_t.apbaud025, #自定義欄位(日期時間)025
       apbaud026 LIKE apba_t.apbaud026, #自定義欄位(日期時間)026
       apbaud027 LIKE apba_t.apbaud027, #自定義欄位(日期時間)027
       apbaud028 LIKE apba_t.apbaud028, #自定義欄位(日期時間)028
       apbaud029 LIKE apba_t.apbaud029, #自定義欄位(日期時間)029
       apbaud030 LIKE apba_t.apbaud030, #自定義欄位(日期時間)030
       apba018   LIKE apba_t.apba018, #本次開票金額
       apba019   LIKE apba_t.apba019, #預付已開發票
       apba020   LIKE apba_t.apba020 #期別
          END RECORD
#161104-00024#1-add(e)
DEFINE l_pmdt069        LIKE pmdt_t.pmdt069
DEFINE l_sum_apba010    LIKE apba_t.apba010
DEFINE l_pmds011_str1   STRING               #160530-00005#3
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1

   CALL s_transaction_begin()
   LET g_success = 'Y'

   #160530-00005#3--s
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)   
   #160530-00005#3--e

   #帶出相關的來源單據值
   CASE p_source
      #apmt500採購單
      #WHEN "10" 
      WHEN "11" #apmt570入庫單
         LET p_type="'3','4','6','12','13'"
      WHEN "17" #aapt301其他應付
         LET p_type="'19'"
      WHEN "20" #apmt560採購驗退
         LET p_type="'5','10','11'"
      WHEN "21" #apmt580採購倉退
         LET p_type="'7','14','15'"
      WHEN "27" #aapt340其他待抵
         LET p_type="'29'"
   END CASE
   
   IF cl_null(g_apba_d_t.apba005) THEN 
      SELECT MAX(apbaseq) INTO l_apba.apbaseq
        FROM apba_t
       WHERE apbaent = g_enterprise 
         AND apbadocno = g_apbb_m.apbbdocno
      IF cl_null(l_apba.apbaseq) THEN
         LET l_apba.apbaseq = 1
      ELSE
         LET l_apba.apbaseq = l_apba.apbaseq + 1
      END IF
   ELSE
      LET l_apba.apbaseq = g_apba_d_t.apbaseq
   END IF
   
   LET l_apba.apbaent = g_enterprise
   LET l_apba.apbadocno = g_apbb_m.apbbdocno
   LET l_apba.apbaorga = p_orga
   LET l_apba.apba004 = p_source
   LET l_apba.apba015 = g_apbb_m.apbb012
   LET l_apba.apba111 = g_apbb_m.apbb015
   
   #正負值給予
   LET l_apba.apba012 = 1
   CASE
      #apmt570.採購入庫單
      WHEN l_apba.apba004 = '11'
           LET l_apba.apba012 = 1
      #aapt301.其他應付單
      WHEN l_apba.apba004 = '17'
           LET l_apba.apba012 = 1
      WHEN l_apba.apba004 = '20'
           LET l_apba.apba012 = -1
      #apmt580.採購倉退單
      WHEN l_apba.apba004 = '21'
           LET l_apba.apba012 = -1
      #aapt340.其他待抵單
      WHEN l_apba.apba004 = '27'
           LET l_apba.apba012 = -1
      OTHERWISE
   END CASE

   IF p_source = '11' or p_source = '20' or p_source = '21' THEN
#     LET l_sql = " SELECT pmdtdocno,pmdtseq,pmdt006,imaal003,pmdt001,",  #160602-00023#1 
#160602-00023#1----begin
      LET l_sql = " SELECT pmdtdocno,pmdtseq,pmdt006,",
                  "        (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||",
                  "        (CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||",
                  "        (CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END),",
                  "        pmdt001,",  
#160602-00023#1----end           
                  #"        pmds037,pmdt019,pmdt036,(pmdt024-pmdt069),pmdt038,", #160614-00015#1 mark
                  "        pmds037,pmdt023,pmdt036,(pmdt024-pmdt069),pmdt038,",  #160614-00015#1 add 單位改取pmdt023
                  "        pmdt039,pmdt047,pmdt050 ",   #161209-00039#1 add pmdt050
                  "   FROM pmds_t,pmdt_t ",
                  "   LEFT OUTER JOIN imaal_t ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_lang,"'",
                  "  WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno",
                  "    AND pmdsent = ",g_enterprise,
                  "    AND pmdtsite = '",p_orga,"'",                #160825-00034#1 mark   #161014-00003#1 remark
                  #160825-00034#1-s
                 #"    AND pmdtorga = '",p_orga,"'",                                       #161014-00003#1 mark
                  "    AND pmds001 < = '",g_apbb_m.apbbdocdt,"'",
                  "    AND pmdsstus = 'S'",
                  "    AND pmds037 = '",g_apbb_m.apbb014,"'",
                  "    AND pmdt046 = '",g_apbb_m.apbb012,"'",
                  #160825-00034#1-e
                  "    AND pmds008 = '",g_apbb_m.apbb002,"'",
                  "    AND pmds000 IN (",p_type,")",
                  "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,     #160530-00005#3
                  "    AND (",g_qryparam.return1,")"
      PREPARE pmdt_pre FROM l_sql
      DECLARE pmdt_cur CURSOR FOR pmdt_pre
      FOREACH pmdt_cur INTO l_apba.apba005,l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba013,
                            l_apba.apba100,l_apba.apba009,l_apba.apba014,l_apba.apba010,l_apba.apba103,
                            l_apba.apba105,l_apba.apba104,l_apba.apba017   #161209-00039#1 add l_apba.apba017
         
         #161214-00005#1---add---str--
         IF p_source = '11' OR p_source = '20' OR p_source = '21' THEN
            LET l_apba.apba008 = s_aapt300_get_apcb005(l_apba.apba007,l_apba.apba005,l_apba.apba006)
         END IF
         #161214-00005#1---add---end--
         
         #先統計該單據是有已立過對帳單，若有要把已立數量SUM出來
         SELECT SUM(apba010) INTO l_sum_apba010
           FROM apba_t,apbb_t
          WHERE apbaent = apbbent AND apbadocno = apbbdocno
            AND apbbent = g_enterprise
            AND apbbstus = 'N'
            AND apba005 = l_apba.apba005
            AND apba006 = l_apba.apba006
         IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
         LET l_apba.apba010 = l_apba.apba010 - l_sum_apba010
         
         LET l_pmdt069 = 0
         SELECT pmdt069 INTO l_pmdt069
           FROM pmdt_t
          WHERE pmdtent = g_enterprise
            AND pmdtdocno = p_docno
            AND pmdtseq = p_seq
         IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF
         
         LET l_apba.apba010 = l_apba.apba010 - l_pmdt069
         
         #單價取位
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
         #重新計算金額
         #160802-00049#1-s
         LET l_money = l_apba.apba014*l_apba.apba010
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
         #160802-00049#1-e
        #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
                  
         #沒開過的發票數量不重新計算金額
         IF l_pmdt069 > 0 THEN
           #CALL s_tax_count(p_orga,l_apba.apba015,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,'1') #160802-00049#1 mark
            CALL s_tax_count(p_orga,l_apba.apba015,l_money,l_apba.apba010,g_apbb_m.apbb014,'1') #160802-00049#1
            RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                      l_apba.apba113,l_apba.apba114,l_apba.apba115
         END IF

         #161209-00039#1---add---str--
         IF g_apbb_m.apbb050 != '2' THEN
            LET l_apba.apba017 = '' 
         END IF
         #161209-00039#1---add---end--

         #INSERT INTO apba_t VALUES(l_apba.*) #161108-00017#3 mark
         #161108-00017#3 add ------
         INSERT INTO apba_t (apbaent,apbadocno,apbaorga,
                             apba001,apba002,apba003,apbaseq,apba004,apba005,
                             apba006,apba007,apba008,apba009,apba010,
                             apba011,apba012,apba013,apba014,apba015,
                             apba016,apba017,apba100,apba103,apba104,
                             apba105,apba111,apba113,apba114,apba115,
                             apbaud001,apbaud002,apbaud003,apbaud004,apbaud005,
                             apbaud006,apbaud007,apbaud008,apbaud009,apbaud010,
                             apbaud011,apbaud012,apbaud013,apbaud014,apbaud015,
                             apbaud016,apbaud017,apbaud018,apbaud019,apbaud020,
                             apbaud021,apbaud022,apbaud023,apbaud024,apbaud025,
                             apbaud026,apbaud027,apbaud028,apbaud029,apbaud030,
                             apba018,apba019,apba020
                            )
         VALUES (l_apba.apbaent,l_apba.apbadocno,l_apba.apbaorga,
                 l_apba.apba001,l_apba.apba002,l_apba.apba003,l_apba.apbaseq,l_apba.apba004,l_apba.apba005,
                 l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba009,l_apba.apba010,
                 l_apba.apba011,l_apba.apba012,l_apba.apba013,l_apba.apba014,l_apba.apba015,
                 l_apba.apba016,l_apba.apba017,l_apba.apba100,l_apba.apba103,l_apba.apba104,
                 l_apba.apba105,l_apba.apba111,l_apba.apba113,l_apba.apba114,l_apba.apba115,
                 l_apba.apbaud001,l_apba.apbaud002,l_apba.apbaud003,l_apba.apbaud004,l_apba.apbaud005,
                 l_apba.apbaud006,l_apba.apbaud007,l_apba.apbaud008,l_apba.apbaud009,l_apba.apbaud010,
                 l_apba.apbaud011,l_apba.apbaud012,l_apba.apbaud013,l_apba.apbaud014,l_apba.apbaud015,
                 l_apba.apbaud016,l_apba.apbaud017,l_apba.apbaud018,l_apba.apbaud019,l_apba.apbaud020,
                 l_apba.apbaud021,l_apba.apbaud022,l_apba.apbaud023,l_apba.apbaud024,l_apba.apbaud025,
                 l_apba.apbaud026,l_apba.apbaud027,l_apba.apbaud028,l_apba.apbaud029,l_apba.apbaud030,
                 l_apba.apba018,l_apba.apba019,l_apba.apba020
                )
         #161108-00017#3 add end---
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         #150422-00026#1 add ---
         ELSE
            #入庫單就要看收貨單有沒有發票可寫入
            IF l_apba.apba004 = "11" THEN
               CALL aapt110_ins_isam_from_pmdw(l_apba.apba005) RETURNING g_sub_success
            END IF
         #150422-00026#1 end ---
         END IF
         
         LET l_apba.apbaseq = l_apba.apbaseq + 1
      END FOREACH
   ELSE
      LET g_qryparam.return1 = cl_replace_str(g_qryparam.return1,'pmdsdocno','apcbdocno')
      LET g_qryparam.return1 = cl_replace_str(g_qryparam.return1,'pmdtseq','apcbseq')
      LET l_sql = "SELECT apcbdocno,apcbseq,apcb004,apcb005,apcb002,",
                  "       apca100,apcb006,apcb101,apcb007,",
                  "       apcb103,apcb105,apcb104,",
                  "       apcb113,apcb114,apcb115 ",
                  "  FROM apca_t ",
                  "  LEFT JOIN apcb_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                  " WHERE apcaent = '",g_enterprise,"'",
                  "   AND apcborga = '",p_orga,"'",
                  "   AND apca001 IN (",p_type,")",
                  "   AND apcb049 IS NULL ",
                  "   AND (",g_qryparam.return1,")"
                  
      PREPARE pmdt_pre1 FROM l_sql
      DECLARE pmdt_cur1 CURSOR FOR pmdt_pre1
      FOREACH pmdt_cur1 INTO l_apba.apba005,l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba013,
                             l_apba.apba100,l_apba.apba009,l_apba.apba014,l_apba.apba010,
                             l_apba.apba103,l_apba.apba105,l_apba.apba104,
                             l_apba.apba113,l_apba.apba114,l_apba.apba115

         #單價取位
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
         LET l_pmdt069 = 0
         SELECT pmdt069 INTO l_pmdt069
           FROM pmdt_t
          WHERE pmdtent = g_enterprise
            AND pmdtdocno = p_docno
            AND pmdtseq = p_seq
         IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF
         
         LET l_apba.apba010 = l_apba.apba010 - l_pmdt069
         
         #沒開過的發票數量不重新計算金額
         IF l_pmdt069 > 0 THEN
            #160802-00049#1-s
            LET l_money = l_apba.apba014*l_apba.apba010
            CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
            #160802-00049#1-e
           #CALL s_tax_count(p_orga,l_apba.apba015,(l_apba.apba014*l_apba.apba010),g_apbb_m.apbb014,l_apba.apba100,'1') #160802-00049#1 mark
            CALL s_tax_count(p_orga,l_apba.apba015,l_money,g_apbb_m.apbb014,l_apba.apba100,'1') #160802-00049#1
            RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                      l_apba.apba113,l_apba.apba114,l_apba.apba115
         END IF
         
         #INSERT INTO apba_t VALUES(l_apba.*)  #161108-00017#3 mark
         #161108-00017#3 add ------
         INSERT INTO apba_t (apbaent,apbadocno,apbaorga,
                             apba001,apba002,apba003,apbaseq,apba004,apba005,
                             apba006,apba007,apba008,apba009,apba010,
                             apba011,apba012,apba013,apba014,apba015,
                             apba016,apba017,apba100,apba103,apba104,
                             apba105,apba111,apba113,apba114,apba115,
                             apbaud001,apbaud002,apbaud003,apbaud004,apbaud005,
                             apbaud006,apbaud007,apbaud008,apbaud009,apbaud010,
                             apbaud011,apbaud012,apbaud013,apbaud014,apbaud015,
                             apbaud016,apbaud017,apbaud018,apbaud019,apbaud020,
                             apbaud021,apbaud022,apbaud023,apbaud024,apbaud025,
                             apbaud026,apbaud027,apbaud028,apbaud029,apbaud030,
                             apba018,apba019,apba020
                            )
         VALUES (l_apba.apbaent,l_apba.apbadocno,l_apba.apbaorga,
                 l_apba.apba001,l_apba.apba002,l_apba.apba003,l_apba.apbaseq,l_apba.apba004,l_apba.apba005,
                 l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba009,l_apba.apba010,
                 l_apba.apba011,l_apba.apba012,l_apba.apba013,l_apba.apba014,l_apba.apba015,
                 l_apba.apba016,l_apba.apba017,l_apba.apba100,l_apba.apba103,l_apba.apba104,
                 l_apba.apba105,l_apba.apba111,l_apba.apba113,l_apba.apba114,l_apba.apba115,
                 l_apba.apbaud001,l_apba.apbaud002,l_apba.apbaud003,l_apba.apbaud004,l_apba.apbaud005,
                 l_apba.apbaud006,l_apba.apbaud007,l_apba.apbaud008,l_apba.apbaud009,l_apba.apbaud010,
                 l_apba.apbaud011,l_apba.apbaud012,l_apba.apbaud013,l_apba.apbaud014,l_apba.apbaud015,
                 l_apba.apbaud016,l_apba.apbaud017,l_apba.apbaud018,l_apba.apbaud019,l_apba.apbaud020,
                 l_apba.apbaud021,l_apba.apbaud022,l_apba.apbaud023,l_apba.apbaud024,l_apba.apbaud025,
                 l_apba.apbaud026,l_apba.apbaud027,l_apba.apbaud028,l_apba.apbaud029,l_apba.apbaud030,
                 l_apba.apba018,l_apba.apba019,l_apba.apba020
                )
         #161108-00017#3 add end---
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         END IF
         
         LET l_apba.apbaseq = l_apba.apbaseq + 1
      END FOREACH
   END IF

   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)     
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL aapt110_b_fill()
   
END FUNCTION

################################################################################
# Descriptions...: 用單號+項次撈出該單據的其他資料
# Memo...........:
# Usage..........: CALL aapt110_qbevalue_show(p_ac,p_orga,p_docno,p_seq,p_source)
# Input parameter: p_ac      項次
#                : p_orga    來源組織
#                : p_docno   單號
#                : p_seq     項次
#                : p_source  來源作業
# Date & Author..: 2014/10/09 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_qbevalue_show(p_ac,p_orga,p_docno,p_seq,p_source)
DEFINE p_ac             LIKE type_t.num5
DEFINE p_orga           LIKE apba_t.apbaorga
DEFINE p_docno          LIKE apba_t.apbadocno
DEFINE p_seq            LIKE apba_t.apbaseq
DEFINE p_source         LIKE apba_t.apba004
DEFINE l_sql            STRING
DEFINE p_type           LIKE type_t.chr300
DEFINE l_apba           RECORD
          apba007          LIKE apba_t.apba007,
          apba008          LIKE apba_t.apba008,
          apba013          LIKE apba_t.apba013,
          apba015          LIKE apba_t.apba015,
          apba100          LIKE apba_t.apba100,
          apba009          LIKE apba_t.apba009,
          apba014          LIKE apba_t.apba014,
          apba010          LIKE apba_t.apba010,
          apba113          LIKE apba_t.apba113,
          apba115          LIKE apba_t.apba115,
          apba114          LIKE apba_t.apba114,
          apba103          LIKE apba_t.apba103,
          apba104          LIKE apba_t.apba104,
          apba105          LIKE apba_t.apba105
         ,apba017          LIKE apba_t.apba017   #161209-00039#1 add 
                        END RECORD
DEFINE l_pmdt069        LIKE pmdt_t.pmdt069
DEFINE l_sum_apba010    LIKE apba_t.apba010
DEFINE l_pmds011_str1   STRING               #160530-00005#3
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1
DEFINE l_pmds000        STRING               #161129-00024#1
DEFINE l_pmds000_str1   STRING               #AP可用的入庫單性質 #161129-00024#1
DEFINE l_pmds000_str2   STRING               #入庫單性質(入庫)   #161129-00024#1
DEFINE l_pmds000_str3   STRING               #入庫單性質(倉退)   #161129-00024#1
   #160530-00005#3--s
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)   
   #160530-00005#3--e   
   #帶出相關的來源單據值
##161129-00024#1 mark s---   
#   CASE p_source
#      #apmt500採購單
#      #WHEN "10" 
#      WHEN "11" #apmt570入庫單
#         LET p_type="'3','4','6','12','13'"
#      WHEN "17" #aapt301其他應付
#         LET p_type="'19'"
#      WHEN "20" #apmt560採購驗退
#         LET p_type="'5','10','11'"
#      WHEN "21" #apmt580採購倉退
#         LET p_type="'7','14','15'"
#      WHEN "27" #aapt340其他待抵
#         LET p_type="'29'"
#   END CASE
#161129-00024#1 mark e---

#161129-00024#1 add s---
      #150702-00001#1-----s
      LET l_pmds000_str1 = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
      LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
     
      LET l_pmds000_str2 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = 1 ")
      LET l_pmds000_str2 = s_fin_get_wc_str(l_pmds000_str2)    
     
      LET l_pmds000_str3 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = -1 ")
      LET l_pmds000_str3 = s_fin_get_wc_str(l_pmds000_str3)  
      #150702-00001#1-----e
      
      IF g_apbb_m.apbb050 = "2" THEN  #紅字發票只開倉退單
         #LET l_pmds000 = "('7','14','15','26')"   #150629-00038#1 add '26' #150702-00001#1 mark
         LET l_pmds000 = l_pmds000_str3 CLIPPED
      ELSE #入庫單+倉退單
         #LET l_pmds000 = "('3','4','6','7','12','13','14','15','22','24','25','26','20')"   #150629-00038#1 add 20~26  ##150702-00001#1 mark
         LET l_pmds000 = l_pmds000_str1 CLIPPED    ##150702-00001#1 add
      END IF
#161129-00024#1 add e---      

   IF p_source = '11' or p_source = '20' or p_source = '21' THEN
#      LET l_sql = "SELECT pmdt006,imaal003,pmdt001,pmdt046,pmds037",    #160602-00023#1 
#160602-00023#1 ---begin
      LET l_sql = "SELECT pmdt006,",
                  "       (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||",
                  "       (CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||",
                  "       (CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END),",
                  "       pmdt001,pmdt046,pmds037,",   
#160602-00023#1 ---end   
                  #"     pmdt019,pmdt036,(pmdt024-pmdt069),pmdt038,pmdt039,",  #160614-00015#1 mark
                  "      pmdt023,pmdt036,(pmdt024-pmdt069),pmdt038,pmdt039,",  #160614-00015#1 add 單位改取pmdt023
                  "      pmdt047,pmdt050 ",   #161209-00039#1 add pmdt050
                  "  FROM pmds_t,pmdt_t ",
                  "  LEFT OUTER JOIN imaal_t ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_lang,"'",
                  "  WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno",
                  "    AND pmdsent = ",g_enterprise,
                  "    AND pmdtsite = '",p_orga,"'",                 #160324-00032#1 mark    #161011-00043#1 remark
                  #"    AND pmdtorga = '",p_orga,"'",                  #160324-00032#1 add   #161011-00043#1 mark
                  "    AND pmdtdocno = '",p_docno,"'",
                  "    AND pmdtseq = '",p_seq,"'",
                  "    AND pmds001 < = '",g_apbb_m.apbbdocdt,"'",     #160324-00032#1 add            
                  "    AND pmds008 = '",g_apbb_m.apbb002,"'",
                  #"    AND pmds000 IN (",p_type,")",          #160314-00005#1 add , #161129-00024#1 mark
                  "    AND pmds000 IN ",l_pmds000,   #161129-00024#1 add
                  "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,       #160530-00005#3
                  "    AND pmdsstus = 'S'",                   #160314-00005#1
                  "    AND pmds037 = '",g_apbb_m.apbb014,"'", #160314-00005#1
                  "    AND pmdt046 = '",g_apbb_m.apbb012,"'"  #160314-00005#1
      PREPARE isam_pre2 FROM l_sql
      DECLARE isam_cur2 CURSOR FOR isam_pre2
      FOREACH isam_cur2 INTO l_apba.apba007,l_apba.apba008,l_apba.apba013,l_apba.apba015,l_apba.apba100,
                             l_apba.apba009,l_apba.apba014,l_apba.apba010,l_apba.apba103,l_apba.apba105,
                             l_apba.apba104,l_apba.apba017   #161209-00039#1 add l_apba.apba017
      END FOREACH
      
      LET l_apba.apba008 = s_aapt300_get_apcb005(l_apba.apba007,p_docno,p_seq)   #161214-00005#1 add
      
      #先統計該單據是有已立過對帳單，若有要把已立數量SUM出來
      SELECT SUM(apba010) INTO l_sum_apba010
        FROM apba_t,apbb_t
       WHERE apbaent = apbbent AND apbadocno = apbbdocno
         AND apbbent = g_enterprise
         AND apbbstus = 'N'
         AND apba005 = p_docno
         AND apba006 = p_seq
      IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
      LET l_apba.apba010 = l_apba.apba010 - l_sum_apba010
      #單價取位 Reanna 15/02/03
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
      #重新計算金額
      #160802-00049#1-s
      LET l_money = l_apba.apba014*l_apba.apba010
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
      #160802-00049#1-e
     #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
      CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
      RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                l_apba.apba113,l_apba.apba114,l_apba.apba115
   ELSE
      SELECT apcb004,apcb005,apcb002,apcb020,apca100,
             apcb006,apcb101,apcb007,apcb103,apcb105,
             apcb104,apcb113,apcb114,apcb115
        INTO l_apba.apba007,l_apba.apba008,l_apba.apba013,l_apba.apba015,l_apba.apba100,
             l_apba.apba009,l_apba.apba014,l_apba.apba010,l_apba.apba103,l_apba.apba105,
             l_apba.apba104,l_apba.apba113,l_apba.apba114,l_apba.apba115
        FROM apca_t
        LEFT JOIN apcb_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno 
       WHERE apcaent = g_enterprise
         AND apcborga = p_orga
         AND apca001 IN (p_type)
         AND apcb049 IS NULL
         AND apcbdocno = p_docno
         AND apcbseq = p_seq
   END IF

   LET g_apba_d[p_ac].apba007 = l_apba.apba007
   LET g_apba_d[p_ac].apba008 = l_apba.apba008
   LET g_apba_d[p_ac].apba013 = l_apba.apba013
   #LET g_apba_d[p_ac].apba015 = l_apba.apba015
   #無來源單or空白 default apbb012
   #IF cl_null(g_apba_d[p_ac].apba015) THEN
      LET g_apba_d[p_ac].apba015 = g_apbb_m.apbb012
   #END IF
   LET g_apba_d[p_ac].apba100 = l_apba.apba100

   LET g_apba_d[p_ac].apba009 = l_apba.apba009
   LET g_apba_d[p_ac].apba014 = l_apba.apba014
   #單價取位 Reanna 15/02/03
   CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[p_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[p_ac].apba014
   SELECT pmdt069 INTO l_pmdt069
     FROM pmdt_t
    WHERE pmdtent = g_enterprise
      AND pmdtdocno = p_docno
      AND pmdtseq = p_seq
   IF cl_null(l_pmdt069) THEN LET l_pmdt069 = 0 END IF

   LET g_apba_d[p_ac].apba010 = l_apba.apba010 - l_pmdt069

   #沒開過的發票數量不重新計算金額
   IF l_pmdt069 > 0 THEN
      #160802-00049#1-s
      LET l_money = l_apba.apba014*g_apba_d[p_ac].apba010
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
      #160802-00049#1-e
     #CALL s_tax_count(p_orga,g_apba_d[p_ac].apba015,(l_apba.apba014*g_apba_d[p_ac].apba010),g_apba_d[p_ac].apba010,g_apbb_m.apbb014,'1') #160802-00049#1 mark
      CALL s_tax_count(p_orga,g_apba_d[p_ac].apba015,l_money,g_apba_d[p_ac].apba010,g_apbb_m.apbb014,'1') #160802-00049#1
      RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                l_apba.apba113,l_apba.apba114,l_apba.apba115
   END IF
   LET g_apba_d[p_ac].apba113 = l_apba.apba113
   LET g_apba_d[p_ac].apba115 = l_apba.apba115
   LET g_apba_d[p_ac].apba114 = l_apba.apba114
   LET g_apba_d[p_ac].apba103 = l_apba.apba103
   LET g_apba_d[p_ac].apba104 = l_apba.apba104
   LET g_apba_d[p_ac].apba105 = l_apba.apba105
   
   #161209-00039#1---add---str--
   IF g_apbb_m.apbb050 = '2' THEN
      LET g_apba_d[p_ac].apba017 = l_apba.apba017
   END IF
   #161209-00039#1---add---end--
   
   DISPLAY BY NAME g_apba_d[p_ac].apba007,g_apba_d[p_ac].apba008,g_apba_d[p_ac].apba013,g_apba_d[p_ac].apba015,g_apba_d[p_ac].apba100,
                   g_apba_d[p_ac].apba009,g_apba_d[p_ac].apba014,g_apba_d[p_ac].apba010,g_apba_d[p_ac].apba113,g_apba_d[p_ac].apba115,
                   g_apba_d[p_ac].apba114,g_apba_d[p_ac].apba103,g_apba_d[p_ac].apba104,g_apba_d[p_ac].apba105,g_apba_d[p_ac].apba017   #161209-00039#1 add apba017


END FUNCTION

################################################################################
# Descriptions...: 異動狀態
# Memo...........:
# Usage..........: CALL aapt110_change_type(p_comp,p_apbb008)
#                  RETURNING r_apbb036
# Input parameter: p_comp    法人
#                : p_apbb008 發票類型
# Return code....: r_apbb036 異動狀態
# Date & Author..: 2014/10/06 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_change_type(p_comp,p_apbb008)
DEFINE p_comp           LIKE isam_t.isamcomp
DEFINE p_apbb008        LIKE apbb_t.apbb008
DEFINE l_isac003        LIKE isac_t.isac003    #1進項發票2銷項發票3進項折讓發票4銷項折讓發票
DEFINE r_apbb036        LIKE apbb_t.apbb036    #異動狀態

   #稅區用法人去抓
   LET l_isac003 = NULL
   SELECT isac003 INTO l_isac003
     FROM isac_t, ooef_t 
    WHERE ooefent = isacent AND ooef019 = isac001
      AND isacent = g_enterprise
      AND ooef001 = p_comp
      AND isac002 = p_apbb008
   CASE
      WHEN l_isac003 = '1'
         LET r_apbb036 = '11' #11發票開立
      WHEN l_isac003 = '3'
         LET r_apbb036 = '21' #21折讓閞立
      OTHERWISE
         LET r_apbb036 = ''
   END CASE
   
   RETURN r_apbb036
END FUNCTION

################################################################################
# Descriptions...: 依含稅否開放相關金額欄位
# Usage..........: CALL aapt110_set_entry_money(p_apbb0121)
# Input parameter: p_apbb0121   含稅否
# Date & Author..: 2014/10/07 By Reanna
################################################################################
PRIVATE FUNCTION aapt110_set_entry_money(p_apbb0121)
DEFINE p_apbb0121       LIKE apbb_t.apbb0121

   CALL cl_set_comp_entry("apbb023,apbb025,apbb026,apbb027,apbb028",TRUE)
   CALL cl_set_comp_entry("apba103,apba105,apba113,apba114,apba115",TRUE)
   CALL cl_set_comp_entry("isam023,isam025,isam026,isam027,isam028",TRUE)
   CALL cl_set_comp_entry("isam014,isam015",TRUE)

   IF p_apbb0121 = 'Y' THEN
      #150422-00026#1 發票明細因為沒有單價、數量所以金額都開放維護
      #CALL cl_set_comp_entry("apbb025,apbb028,apba105,apba115,isam025,isam028",FALSE)
      #CALL cl_set_comp_entry("apbb025,apbb028,apba105,apba115",FALSE) #150729 mark
      CALL cl_set_comp_entry("apbb023,apbb026,apba103,apba113",FALSE)  #150729
   ELSE
      #150422-00026#1 發票明細因為沒有單價、數量所以這裡都開放維護
      #CALL cl_set_comp_entry("apbb023,apbb026,apba103,apba113,isam023,isam026",FALSE)
      #CALL cl_set_comp_entry("apbb023,apbb026,apba103,apba113",FALSE)  #150729 mark
      CALL cl_set_comp_entry("apbb025,apbb028,apba105,apba115",FALSE)   #150729
   END IF
   
   #交易原幣=本位幣(即匯率=1)，本幣欄位要鎖住
   IF g_apbb_m.apbb015 = 1 THEN
      CALL cl_set_comp_entry("apbb026,apbb027,apbb028,apba113,apba114,apba115,isam026,isam027,isam028",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 用"發票編碼方式"決定是否隱藏"發票代碼"
# Memo...........:
# Usage..........: CALL aapt110_set_entry_invoice_code()

# Date & Author..: 2014/11/12 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_set_entry_invoice_code()
   
   #161230-00036#1 mark ------
   #SELECT isai002 INTO g_isai002
   #  FROM ooef_t
   #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #161230-00036#1 mark end---
   IF g_isai002 = "1" THEN
      CALL cl_set_comp_visible('apbb009,apba016,isam009',FALSE)
   ELSE
      IF g_apbb_m.apbb050 = 2 THEN
         CALL cl_set_comp_visible('apbb009,apba016,isam009',TRUE)
      ELSE
         CALL cl_set_comp_visible('apbb009,isam009',TRUE)
      END IF
   END IF

END FUNCTION

################################################################################
# Descriptions...: 檢查發票是否重複輸入
# Memo...........:
# Usage..........: CALL aapt110_invoice_repeat_chk(p_code,p_number,p_type,p_docno,p_money)
#                  RETURNING r_success,r_errno
# Input parameter: p_code    發票代碼
#                : p_number  發票號碼
#                : p_type    發票類型
#                : p_date    發票日期
#                : p_docno   收票單據
#                : p_money   目前輸入的金額

# Date & Author..: 2014/10/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_invoice_repeat_chk(p_code,p_number,p_type,p_date,p_docno,p_money,p_comp,p_apbb002)
DEFINE p_code           LIKE isam_t.isam009
DEFINE p_number         LIKE isam_t.isam010
DEFINE p_type           LIKE isam_t.isam008
DEFINE p_date           LIKE isam_t.isam011
DEFINE p_docno          LIKE isam_t.isamdocno
DEFINE p_money          LIKE isam_t.isam023
DEFINE p_comp           LIKE apbb_t.apbbcomp   #160107-00004#1
DEFINE p_apbb002        LIKE apbb_t.apbb002    #160107-00004#1
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_sql            STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sum_red        LIKE isam_t.isam023
DEFINE l_sum_blue       LIKE isam_t.isam023
DEFINE l_isac008        LIKE isac_t.isac008    #150622-00003#1
DEFINE l_bdate          LIKE type_t.dat        #150622-00003#1
DEFINE l_edate          LIKE type_t.dat        #150622-00003#1
#DEFINE l_ooef011        LIKE ooef_t.ooef011    #160107-00004#1 #161230-00036#1 mark

#發票重複檢核規則：
#有發票代碼：China
#  發票號碼+發票代碼>>不能重複
#  (A單據跟B單據or同一張單據的發票號碼都不能重複)
#沒發票代碼：Taiwan
#  1.藍字發票
#    發票類型+發票號碼>>不能重複
#    (A單據跟B單據or同一張單據的發票號碼都不能重複
#  2.紅字發票：
#    可以打多張同張發票類型+發票號碼
#    (金額不能超過原來的藍字發票總金額(包含本身單據))
#*要排除本单单身的发票号码
#*單頭輸入完發票號碼也要check(發票類型也要存在再檢查)
#*單頭紅字發票不check單身在檢查
#150622-00003#1修改Taiwan原則：
#  1.收據類(aisi030發票聯別0:園區收據、4:收據)，不檢核重覆性
#  2.重覆性檢核，發票類型+發票號碼+年度>>只能存在一張
#  EX:B1/2015年/A001這張發票可重覆打在B1/2016年/A001>>不同年度PASS
#     B1/2015年/A001這張發票可重覆打在B2/2015年/A001>>不同類型同年度可PASS
#160107-00004#1修改檢核原則：
#進項發票號碼檢核是否重覆:
#依發票類型的聯數判斷(aisi030.isac008)
#IF isac003=1.進項發票
#  CASE 4.收據
#     廠商+(發票代碼+發票號碼)  不可重覆
#  CASE OTHERWISE
#     年度+(發票代碼+發票號碼)  不可重覆
#ELSE   #isac003=3.進項紅字發票(折讓)
#  #原本是依isai002作判斷TW/CN, 要改成以ooef011
#  CASE ooef011=CN
#       年度+(發票代碼+發票號碼)  不可重覆
#  CASE ooef011=TW
#       允許重覆,
#       但要檢核輸入的發票號碼,必須存在isam的有效發票
#  OTHERWISE
#       同 CN 的原則
#       年度+(發票代碼+發票號碼)  不可重覆
#END IF

   LET r_success = TRUE
   
   #170203-00027#1 add ------
   IF cl_null(p_number) THEN
      RETURN r_success,r_errno
   END IF
   #170203-00027#1 add ------
   
   #160107-00004#1 mark ------
   ##抓取"發票編碼方式"區分是大陸or台灣
   #SELECT isai002 INTO g_isai002
   #  FROM ooef_t
   #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #160107-00004#1 mark end---
   #161230-00036#1 mark ------
   #160107-00004#1 add ------
   ##改抓專屬國家地區功能來判斷
   #SELECT ooef011 INTO l_ooef011
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = p_comp
   ##160107-00004#1 add end---
   #161230-00036#1 mark end---
   
   #China
  #IF g_isai002 = "2" THEN   #160107-00004#1 mark
  #IF l_ooef011 <> "TW" THEN #160107-00004#1 #161230-00036#1 mark
   IF g_ooef011 <> "TW" THEN #161230-00036#1 add
      LET l_sql = "SELECT COUNT(*)",
                  "  FROM isam_t",
                  " WHERE isament = ",g_enterprise,
                  "   AND isam009 = '",p_code,"'",
                  "   AND isam010 = '",p_number,"'",
                  "   AND isam036 IN ('11','11Y') "
      PREPARE isam_sel_cn_pb FROM l_sql
      EXECUTE isam_sel_cn_pb INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00121'
      END IF
   #Taiwan
   ELSE
      IF g_apbb_m.apbb050 = '1' THEN
         #150622-00003#1 add ------
         #161230-00036#1 mark ------
         ##抓取發票聯別
         #SELECT isac008 INTO l_isac008
         #  FROM isac_t
         #  LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
         # WHERE isacent = g_enterprise
         #   AND ooef001 = p_comp
         #   AND isac002 = p_type
         #161230-00036#1 mark end---
         #160107-00004#1 mark ------
         ##發票聯別，是0、4就PASS不檢核
         #IF l_isac008 MATCHES '[04]' THEN
         #   RETURN r_success,r_errno
         #END IF
         #160107-00004#1 mark end---
         
         CALL s_date_get_ymtodate(YEAR(p_date),1,YEAR(p_date),12) RETURNING l_bdate,l_edate

         
         #160107-00004#1 add ------
         #IF l_isac008 = '4' THEN #160107-00004#1 mark
         IF g_isac008 = '4' THEN  #160107-00004#1 add
            #廠商+發票號碼>>不可重覆
            LET l_sql = "SELECT COUNT(*)",
                        "  FROM isam_t",
                        " WHERE isament = ",g_enterprise,
                        "   AND isam008 = '",p_type,"'",
                        "   AND isam010 = '",p_number,"'",
                        "   AND isam036 IN ('11','11Y') ",
                        "   AND isamstus <> 'X' ",
                        "   AND isam002 = '",p_apbb002,"'"
            PREPARE isam_sel_tw_pb1 FROM l_sql
            EXECUTE isam_sel_tw_pb1 INTO l_cnt
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt > 0 THEN
               LET r_success = FALSE
               LET r_errno = 'ais-00257'
            END IF
         ELSE
         #160107-00004#1 add end---
            #150622-00003#1 add isam011條件
            LET l_sql = "SELECT COUNT(*)",
                        "  FROM isam_t",
                        " WHERE isament = ",g_enterprise,
                        #"   AND isam008 = '",p_type,"'",    #161019-00030#1 mark
                        "   AND isam010 = '",p_number,"'",
                        "   AND isam036 IN ('11','11Y') ",
                        "   AND isamstus <> 'X' ",   #151112
                        "   AND isam011 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
            PREPARE isam_sel_tw_pb2 FROM l_sql
            EXECUTE isam_sel_tw_pb2 INTO l_cnt
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt > 0 THEN
               LET r_success = FALSE
               LET r_errno = 'ais-00123'
            END IF
         END IF  #160107-00004#1 add
      ELSE
         IF NOT cl_null(p_money) THEN 
            #紅字發票的總和
            SELECT SUM(isam023) INTO l_sum_red
              FROM isam_t
             WHERE isament = g_enterprise
               AND isam008 IN (SELECT isac002 FROM isac_t WHERE isacent = g_enterprise AND isac001 = g_ooef019 AND isac003 = '3')
               AND isam010 = p_number
               AND isam036 IN ('21')
               AND isamdocno <> p_docno
            IF cl_null(l_sum_red) THEN LET l_sum_red = 0 END IF
            LET l_sum_red = s_math_abs(l_sum_red) + s_math_abs(p_money)
            #藍字發票的總和
            SELECT isam023 INTO l_sum_blue
              FROM apbb_t
              LEFT JOIN isam_t ON apbbent = isament AND apbbdocno = isamdocno
             WHERE apbbent = g_enterprise
               AND apbb050 = '1'
               AND isam010 = p_number
               AND isam036 IN ('11','11Y')
            IF cl_null(l_sum_blue) THEN LET l_sum_blue = 0 END IF
            IF l_sum_red > l_sum_blue THEN
               LET r_success = FALSE
               LET r_errno = 'aap-00080'
            END IF
         END IF
      END IF
   END IF

   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 檢核扣抵藍字發票是否還有扣達可以扣抵
# Memo...........:
# Usage..........: CALL aapt110_invoice_debit_chk()
#                  RETURNING r_success,r_errno

# Date & Author..: 2014/11/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_invoice_debit_chk()
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_sql            STRING
DEFINE l_used           LIKE isam_t.isam023  #每次用過的扣抵藍字發票金額
DEFINE l_used_sum       LIKE isam_t.isam023  #已用過扣抵藍字發票總額
DEFINE l_isam023        LIKE isam_t.isam023  #可用的扣抵藍字發票總額

   LET r_success = TRUE
   
   #161230-00036#1 mark ------
   ##先取出稅區
   #SELECT isai002 INTO g_isai002
   #  FROM ooef_t
   #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #161230-00036#1 mark end---
   
   #撈出藍字發票金額
   #sum出已使用該藍字發票的扣抵金額
   #加上這筆打的金額
   #比對   
   IF g_isai002 = "1" THEN
      SELECT isam023 INTO l_isam023
        FROM apbb_t,isam_t
       WHERE apbbent = isament AND apbbdocno = isamdocno
         AND apbbent = g_enterprise
         #AND apbbdocno = g_apbb_m.apbbdocno
         AND apbb050 = '1'
         AND apbb036 IN ('11','11Y')
         AND apbb002 = g_apbb_m.apbb002
         AND apbb011 <= g_apbb_m.apbbdocdt
         AND isam010 = g_apba_d[l_ac].apba017
         AND isam008 IN (SELECT isac002 FROM isac_t WHERE isacent = g_enterprise AND isac001 = g_ooef019 AND isac003 = '1')
         AND apbb014 = g_apbb_m.apbb014
      IF cl_null(l_isam023) THEN LET l_isam023 = 0 END IF
      LET l_sql = " SELECT CASE WHEN SUM(apba103) IS NULL THEN 0 ELSE SUM(apba103) END AS aaa",
                  "   FROM apba_t,apbb_t",
                  "  WHERE apbaent = apbbent AND apbadocno = apbbdocno",
                  "    AND apbbent =",g_enterprise,
                  "    AND apbbstus<>'X'",
                  "    AND apba017 = '",g_apba_d[l_ac].apba017,"'",
                  "    AND apbb014 = '",g_apbb_m.apbb014,"'"
   ELSE
      SELECT isam023 INTO l_isam023
        FROM apbb_t,isam_t
       WHERE apbbent = isament AND apbbdocno = isamdocno
         AND apbbent = g_enterprise
         AND apbbdocno = g_apbb_m.apbbdocno
         AND apbb050 = '1'
         AND apbb036 IN ('11','11Y')
         AND apbb002 = g_apbb_m.apbb002
         AND apbb011 <= g_apbb_m.apbbdocdt
         AND isam009 = g_apba_d[l_ac].apba016
         AND isam010 = g_apba_d[l_ac].apba017
         AND isam008 IN (SELECT isac002 FROM isac_t WHERE isacent = g_enterprise AND isac001 = g_ooef019 AND isac003 = '1')
         AND apbb014 = g_apbb_m.apbb014
      IF cl_null(l_isam023) THEN LET l_isam023 = 0 END IF
      LET l_sql = " SELECT CASE WHEN SUM(apba103) IS NULL THEN 0 ELSE SUM(apba103) END AS aaa",
                  "   FROM apba_t,apbb_t",
                  "  WHERE apbaent = apbbent AND apbadocno = apbbdocno",
                  "    AND apbbent = ",g_enterprise,
                  "    AND apbbdocno = '",g_apbb_m.apbbdocno,"'",
                  "    AND apbbstus<>'X'",
                  "    AND apba016 = '",g_apba_d[l_ac].apba016,"'",
                  "    AND apba017 = '",g_apba_d[l_ac].apba017,"'",
                  "    AND apbb014 = '",g_apbb_m.apbb014,"'"
   END IF
   PREPARE chk_apba_pre FROM l_sql
   DECLARE chk_apba_cur CURSOR FOR chk_apba_pre
   LET l_used_sum = 0
   FOREACH chk_apba_cur INTO l_used
      LET l_used_sum = l_used_sum + l_used
   END FOREACH
   IF cl_null(l_used_sum) THEN LET l_used_sum = 0 END IF
   LET l_used_sum = l_used_sum + g_apba_d[l_ac].apba103
   IF l_used_sum > l_isam023 THEN
      LET r_success = FALSE
      LET r_errno = 'aap-00229'
   END IF
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 單身交易單號檢查
# Memo...........:
# Usage..........: CALL aapt110_source_doc_chk()
#                  RETURNING r_success,r_errno

# Date & Author..: 2014/11/22 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_source_doc_chk()
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_pmdtsite       LIKE pmdt_t.pmdtsite
DEFINE l_pmds000        LIKE pmds_t.pmds000
DEFINE l_pmds008        LIKE pmds_t.pmds008
DEFINE l_pmds037        LIKE pmds_t.pmds037
DEFINE l_pmdt046        LIKE pmdt_t.pmdt046
DEFINE l_pmdt024        LIKE pmdt_t.pmdt024
DEFINE l_pmdt069        LIKE pmdt_t.pmdt069
DEFINE l_pmds001        LIKE pmds_t.pmds001      #160324-00032#1 add  
DEFINE l_pmdtorga       LIKE pmdt_t.pmdtorga     #160324-00032#1 add  
DEFINE l_pmds011_flag   LIKE type_t.chr1         #採購性質可立AP否     #160530-00005#3

   LET r_success = TRUE

   #160530-00005#3 mod--s
   #SELECT pmdtsite,pmds000,pmds008,pmds037,pmdt046,pmdt024,pmdt069,pmds001,pmdtorga                      #160324-00032#1 add pmds001,pmdtorga
   #  INTO l_pmdtsite,l_pmds000,l_pmds008,l_pmds037,l_pmdt046,l_pmdt024,l_pmdt069,l_pmds001,l_pmdtorga    #160324-00032#1 add l_pmds001,l_pmdtorga
   SELECT pmdtsite,pmds000,pmds008,pmds037,pmdt046,
          pmdt024,pmdt069,pmds001,pmdtorga,
          (SELECT gzcb003 FROM gzcb_t WHERE gzcb001='2061' AND gzcb002=pmds011)   
     INTO l_pmdtsite,l_pmds000,l_pmds008,l_pmds037,l_pmdt046,
          l_pmdt024,l_pmdt069,l_pmds001,l_pmdtorga,
          l_pmds011_flag 
   #160530-00005#3 mod--e
     FROM pmds_t
     LEFT JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno
    WHERE pmdsent = g_enterprise
      AND pmdsdocno = g_apba_d[l_ac].apba005
      AND pmdtseq = g_apba_d[l_ac].apba006
      AND pmdsstus ='S'               #160314-00005#1
      AND pmds037 = g_apbb_m.apbb014  #160314-00005#1
      AND pmdt046 = g_apbb_m.apbb012  #160314-00005#1
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = SQLCA.sqlcode
         LET r_success = FALSE
      WHEN l_pmdtorga <> g_apba_d[l_ac].apbaorga #帳務中心    #160324-00032#1 change l_pmdtsite to l_pmdtorga 
         LET r_errno = 'aap-00274'
         LET r_success = FALSE
      #160324-00032#1--add--str 
      WHEN l_pmds001 > g_apbb_m.apbbdocdt
         LET r_errno = 'aap-00407'
         LET r_success = FALSE  
      #160324-00032#1--add--end     
     #WHEN l_pmds000 <> ''                       #單據性質
      WHEN NOT cl_null(l_pmds000)                #單據性質   #150622-00007#1
         CASE g_apba_d[l_ac].apba004
            WHEN "11"
               #150702-00001#1-----s
               #IF l_pmds000 NOT MATCHES '[345]' OR l_pmds000 NOT MATCHES '1[23]' OR l_pmds000 NOT MATCHES '2[0245]' THEN   #150629-00038#1 add 20~25
               IF NOT s_aap_pmds000_chk('2',l_pmds000) THEN
               #150702-00001#1-----e
                  LET r_errno = 'aap-00279'
                  LET r_success = FALSE
               END IF
            WHEN "20"
               #150702-00001#1-----s
               #IF l_pmds000 NOT MATCHES '[5]' OR l_pmds000 NOT MATCHES '1[01]' THEN
               IF NOT s_aap_pmds000_chk('5',l_pmds000) THEN
               #150702-00001#1-----e
                  LET r_errno = 'aap-00279'
                  LET r_success = FALSE
               END IF
            WHEN "21"
               #150702-00001#1-----s
               #IF l_pmds000 NOT MATCHES '[7]' OR l_pmds000 NOT MATCHES '1[45]' OR l_pmds000 <> '26' THEN      #150629-00038#1 add 26
               IF NOT s_aap_pmds000_chk('4',l_pmds000) THEN
               #150702-00001#1-----e
                  LET r_errno = 'aap-00279'
                  LET r_success = FALSE
               END IF
         END CASE
      WHEN l_pmds008 <> g_apbb_m.apbb002         #交易對象
         LET r_errno = 'aap-00275'
         LET r_success = FALSE
      WHEN l_pmdt046 <> g_apbb_m.apbb012         #稅別
         LET r_errno = 'aap-00276'
         LET r_success = FALSE
      WHEN l_pmds037 <> g_apbb_m.apbb014         #幣別
         LET r_errno = 'aap-00277'
         LET r_success = FALSE
      WHEN l_pmdt024 - l_pmdt069 <= 0            #入庫數量不可大於已扣數量
         LET r_errno = 'aap-00278'
         LET r_success = FALSE
   END CASE
   
   IF r_success THEN #170117-00030#1 add 如以上都無誤,才往下做該檢核,否則先報以上錯誤
   #160530-00005#3--s
   IF (l_pmds011_flag <> 'Y' OR cl_null(l_pmds011_flag)) THEN
      LET r_errno = 'aap-00549'
      LET r_success = FALSE      
   END IF
   #160530-00005#3--e  
   END IF #170117-00030#1 add
   
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 判斷同法人否
# Memo...........:
# Usage..........: CALL aapt110_apbaorga_chk(p_apbborga,p_apbaorga,p_wc_apbaorga)
#                  RETURNING r_success,r_errno
# Input parameter: p_apbborga     單頭法人
#                : p_apbaorga     要比較的法人
#                : p_wc_apbaorga  帳務中心下法人範圍
# Date & Author..: 2015/01/19 By Reanna #141218-00011#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_apbaorga_chk(p_apbbcomp,p_apbaorga,p_wc_apbaorga)
DEFINE p_apbbcomp       LIKE apbb_t.apbbcomp
DEFINE p_apbaorga       LIKE apba_t.apbaorga
DEFINE p_wc_apbaorga    STRING
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_ld             LIKE apda_t.apdald
DEFINE l_comp_orga      LIKE apda_t.apdacomp

   LET r_success = TRUE
   LET r_errno = ''

   #檢查輸入組織代碼是否存在帳務中心下法人範圍內
   IF s_chr_get_index_of(p_wc_apbaorga,p_apbaorga,1) = 0 THEN
      LET r_success = FALSE
      LET r_errno   ='aap-00127'
   END IF

   CALL s_fin_orga_get_comp_ld(p_apbaorga) RETURNING g_sub_success,g_errno,l_comp_orga,l_ld
   IF l_comp_orga <> p_apbbcomp THEN
      LET r_success = FALSE
      LET r_errno   = 'afa-00319'
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 把金額回寫到單頭
# Memo...........:
# Usage..........: CALL aapt110_money_update_to_head(p_table,p_flag)
# Input parameter: p_table    from哪個單身
#                  p_flag     是否更新
# Date & Author..: 2014/10/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_money_update_to_head(p_table,p_flag)
DEFINE p_table          LIKE type_t.chr10
DEFINE p_flag           LIKE type_t.chr1
DEFINE l_apbb           RECORD
         apbb023           LIKE apbb_t.apbb023,    #原幣金額
         apbb024           LIKE apbb_t.apbb024,
         apbb025           LIKE apbb_t.apbb025,
         apbb026           LIKE apbb_t.apbb026,    #本幣金額
         apbb027           LIKE apbb_t.apbb027,
         apbb028           LIKE apbb_t.apbb028
                        END RECORD
DEFINE l_isam           RECORD
         isam023           LIKE isam_t.isam023,    #原幣金額
         isam024           LIKE isam_t.isam024,
         isam025           LIKE isam_t.isam025,
         isam026           LIKE isam_t.isam026,    #本幣金額
         isam027           LIKE isam_t.isam027,
         isam028           LIKE isam_t.isam028
                        END RECORD

   INITIALIZE l_isam.* TO NULL
   
#140424 因單身是call s_tax_count推算出本幣，故這只要直接sum回寫單頭即可，不然會有尾差問題
#EX 取三位，四捨五入
#   單身1 5 * 1.32768 = 6.638 單身2 5 * 1.32768 = 6.638 >>13.276
#   單頭  (5+5)*1.32768 >>13.277
#   會有尾差0.01
   
   #先取得單身總金額
   IF p_table = "apba" THEN
      SELECT SUM(apba103*apba012),SUM(apba104*apba012),SUM(apba105*apba012),
             SUM(apba113*apba012),SUM(apba114*apba012),SUM(apba115*apba012)
        INTO l_isam.isam023,l_isam.isam024,l_isam.isam025,
             l_isam.isam026,l_isam.isam027,l_isam.isam028
        FROM apba_t
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno
         AND (apba019 = 'Y' OR apba019 IS NULL) #160705-00035#1
   ELSE
      SELECT SUM(isam023),SUM(isam024),SUM(isam025),
             SUM(isam026),SUM(isam027),SUM(isam028)
        INTO l_isam.isam023,l_isam.isam024,l_isam.isam025,
             l_isam.isam026,l_isam.isam027,l_isam.isam028
        FROM isam_t
       WHERE isament = g_enterprise
         AND isamdocno = g_apbb_m.apbbdocno
   END IF
   
   IF cl_null(l_isam.isam023)THEN LET l_isam.isam023 = 0 END IF
   IF cl_null(l_isam.isam024)THEN LET l_isam.isam024 = 0 END IF
   IF cl_null(l_isam.isam025)THEN LET l_isam.isam025 = 0 END IF
   IF cl_null(l_isam.isam026)THEN LET l_isam.isam026 = 0 END IF
   IF cl_null(l_isam.isam027)THEN LET l_isam.isam027 = 0 END IF
   IF cl_null(l_isam.isam028)THEN LET l_isam.isam028 = 0 END IF

   ##推出本幣金額
   #IF g_apbb_m.apbb0121 = "Y" THEN
   #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_isam.isam025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
   #        RETURNING l_isam.isam023,l_isam.isam024,l_isam.isam025
   #                 ,l_isam.isam026,l_isam.isam027,l_isam.isam028
   #ELSE
   #   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_isam.isam023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
   #        RETURNING l_isam.isam023,l_isam.isam024,l_isam.isam025
   #                 ,l_isam.isam026,l_isam.isam027,l_isam.isam028
   #END IF
   
   #若沒有要更新單頭金額，單身總額與單頭金額不符，就show訊息
   IF p_flag = "N" THEN
      #取得單頭金額
      SELECT apbb023,apbb024,apbb025,apbb026,apbb027,apbb028
        INTO l_apbb.apbb023,l_apbb.apbb024,l_apbb.apbb025,l_apbb.apbb026,l_apbb.apbb027,l_apbb.apbb028
        FROM apbb_t
       WHERE apbbent = g_enterprise
         AND apbbdocno = g_apbb_m.apbbdocno
      #若不符合僅提示金額有差異的訊息
      IF l_apbb.apbb023 <> l_isam.isam023 OR l_apbb.apbb024 <> l_isam.isam024 OR l_apbb.apbb025 <> l_isam.isam025 OR
         l_apbb.apbb026 <> l_isam.isam026 OR l_apbb.apbb027 <> l_isam.isam027 OR l_apbb.apbb028 <> l_isam.isam028 THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "aap-00296"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   ELSE
      UPDATE apbb_t SET apbb023 = l_isam.isam023,apbb024 = l_isam.isam024,
                        apbb025 = l_isam.isam025,apbb026 = l_isam.isam026,
                        apbb027 = l_isam.isam027,apbb028 = l_isam.isam028
       WHERE apbbent = g_enterprise
         AND apbbdocno = g_apbb_m.apbbdocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = "upd apbb"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      
      LET g_apbb_m.apbb023 = l_isam.isam023
      LET g_apbb_m.apbb024 = l_isam.isam024
      LET g_apbb_m.apbb025 = l_isam.isam025
      LET g_apbb_m.apbb026 = l_isam.isam026
      LET g_apbb_m.apbb027 = l_isam.isam027
      LET g_apbb_m.apbb028 = l_isam.isam028

      DISPLAY BY NAME g_apbb_m.apbb023,g_apbb_m.apbb024,g_apbb_m.apbb025,
                      g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028
   END IF

END FUNCTION

################################################################################
# Descriptions...: 單頭稅別or匯率變更時，單身金額要重新推算
# Memo...........:
# Usage..........: CALL aapt110_change_tax_or_rate_update()
#                  RETURNING r_success
# Date & Author..: 2015/01/12 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_change_tax_or_rate_update()
DEFINE r_success        LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_apbaseq        LIKE apba_t.apbaseq
DEFINE l_apba010        LIKE apba_t.apba010
DEFINE l_apba014        LIKE apba_t.apba014
DEFINE l_apba103        LIKE apba_t.apba103
DEFINE l_apba104        LIKE apba_t.apba104
DEFINE l_apba105        LIKE apba_t.apba105
DEFINE l_apba113        LIKE apba_t.apba113
DEFINE l_apba114        LIKE apba_t.apba114
DEFINE l_apba115        LIKE apba_t.apba115
DEFINE l_isam023        LIKE isam_t.isam023
DEFINE l_isam025        LIKE isam_t.isam025
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1
   
   LET r_success = TRUE
   
   #來源單據
   LET l_sql = "SELECT apbaseq,apba010,apba014",
               "  FROM apba_t",
               " WHERE apbaent = ",g_enterprise,
               "   AND apbadocno = '",g_apbb_m.apbbdocno,"'"
   PREPARE sel_apba_pre FROM l_sql
   DECLARE sel_apba_cur CURSOR FOR sel_apba_pre
   FOREACH sel_apba_cur INTO l_apbaseq,l_apba010,l_apba014
      #單價取位 Reanna 15/02/03
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba014,1) RETURNING g_sub_success,g_errno,l_apba014
      #160802-00049#1-s
      LET l_money = l_apba014*l_apba010
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
      #160802-00049#1-e
     #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba014*l_apba010),l_apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
      CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
      RETURNING l_apba103,l_apba104,l_apba105,
                l_apba113,l_apba114,l_apba115
      #150422-00026#1 add apba111
      UPDATE apba_t SET (apba103,apba104,apba105,
                         apba113,apba114,apba115,apba111
                        ) = (
                         l_apba103,l_apba104,l_apba105,
                         l_apba113,l_apba114,l_apba115,g_apbb_m.apbb015)
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno
         AND apbaseq = l_apbaseq
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   #發票明細
   LET l_sql = "SELECT isamseq,isam023,isam025",
               "  FROM isam_t",
               " WHERE isament = ",g_enterprise,
               "   AND isamdocno = '",g_apbb_m.apbbdocno,"'"
   PREPARE sel_isam_pre FROM l_sql
   DECLARE sel_isam_cur CURSOR FOR sel_isam_pre
   FOREACH sel_isam_cur INTO l_apbaseq,l_isam023,l_isam025
      IF g_apbb_m.apbb0121 = "Y" THEN
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_isam025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba103,l_apba104,l_apba105,
                   l_apba113,l_apba114,l_apba115
      ELSE
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_isam023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba103,l_apba104,l_apba105,
                   l_apba113,l_apba114,l_apba115
      END IF
      #150422-00026#1 add isam015
      UPDATE isam_t SET (isam023,isam024,isam025,
                         isam026,isam027,isam028,isam015
                        ) = (
                         l_apba103,l_apba104,l_apba105,
                         l_apba113,l_apba114,l_apba115,g_apbb_m.apbb015)
       WHERE isament = g_enterprise
         AND isamdocno = g_apbb_m.apbbdocno
         AND isamseq = l_apbaseq
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 發票補登
# Memo...........:
# Usage..........: CALL aapt110_invoice_mod()
#                  RETURNING 回传参数
# Input parameter: 

# Date & Author..: 2014/12/09 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_invoice_mod()
DEFINE p_cmd                  LIKE type_t.chr1
DEFINE l_cmd_t                LIKE type_t.chr1
DEFINE l_cmd                  LIKE type_t.chr1
DEFINE l_n                    LIKE type_t.num5   #檢查重複用
DEFINE l_cnt                  LIKE type_t.num5   #檢查重複用
DEFINE l_lock_sw              LIKE type_t.chr1   #單身鎖住否
DEFINE l_allow_insert         LIKE type_t.num5   #可新增否
DEFINE l_allow_delete         LIKE type_t.num5   #可刪除否
DEFINE l_count                LIKE type_t.num5
DEFINE l_i                    LIKE type_t.num5
DEFINE l_insert               BOOLEAN
DEFINE ls_return              STRING
DEFINE l_var_keys             DYNAMIC ARRAY OF STRING
DEFINE l_field_keys           DYNAMIC ARRAY OF STRING
DEFINE l_vars                 DYNAMIC ARRAY OF STRING
DEFINE l_fields               DYNAMIC ARRAY OF STRING
DEFINE l_var_keys_bak         DYNAMIC ARRAY OF STRING
DEFINE lb_reproduce           BOOLEAN
DEFINE li_reproduce           LIKE type_t.num5
DEFINE li_reproduce_target    LIKE type_t.num5
DEFINE r_success              LIKE type_t.num5
DEFINE l_isac004              LIKE isac_t.isac004
DEFINE l_pmdldocdt            LIKE pmdl_t.pmdldocdt  #161006-00011#1

   LET r_success = TRUE
      
   LET g_forupd_sql = "SELECT isamseq,isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam012, 
       isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isam036,isam050 FROM isam_t WHERE  
       isament=? AND isamdocno=? AND isamseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)
   DECLARE aapt110_bcl4 CURSOR FROM g_forupd_sql

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   INPUT ARRAY g_apba2_d FROM s_detail2.* ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS,
                                                    UNBUFFERED=TRUE,
                                                    INSERT ROW = l_allow_insert,
                                                    DELETE ROW = l_allow_delete,
                                                    APPEND ROW = l_allow_insert)

      BEFORE INPUT
         IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
            CALL FGL_SET_ARR_CURR(g_apba2_d.getLength()+1)
            LET g_insert = 'N'
         END IF
         CALL aapt110_b_fill()
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF
         LET g_rec_b = g_apba2_d.getLength()
         
         #150422-00026#1 發票明細因為沒有單價、數量所以金額都開放維護 mark
         ##金額欄位
         #CALL cl_set_comp_entry("isam023,isam025,isam026,isam028,isam014,isam015",TRUE)
         #IF g_apbb_m.apbb0121 = 'Y' THEN
         #   CALL cl_set_comp_entry("isam025,isam028",FALSE)
         #ELSE
         #   CALL cl_set_comp_entry("isam023,isam026",FALSE)
         #END IF
         ##交易原幣=本位幣(即匯率=1)，本幣欄位要鎖住
         #IF g_apbb_m.apbb015 = 1 THEN
         #   CALL cl_set_comp_entry("isam026,isam027,isam028",FALSE)
         #END IF
         #150422-00026#1 mark end ---

      BEFORE INSERT
         LET l_insert = TRUE
         LET l_n = ARR_COUNT()
         LET l_ac = ARR_CURR()
         LET l_cmd = 'a'
         INITIALIZE g_apba2_d[l_ac].* TO NULL
         INITIALIZE g_apba2_d_t.* TO NULL
         INITIALIZE g_apba2_d_o.* TO NULL

         #項次
         SELECT MAX(isamseq)+1 INTO g_apba2_d[l_ac].isamseq FROM isam_t
          WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
         IF cl_null(g_apba2_d[l_ac].isamseq) OR g_apba2_d[l_ac].isamseq = 0 THEN
            LET g_apba2_d[l_ac].isamseq = 1
         END IF
         
         LET g_apba2_d[l_ac].isam037 = "1"
         LET g_apba2_d[l_ac].isam200 = "N"
         LET g_apba2_d[l_ac].isam008 = g_apbb_m.apbb008    #發票種類
         LET g_apba2_d[l_ac].isam011 = g_apbb_m.apbb011    #發票日期
         LET g_apba2_d[l_ac].isam009 = g_apbb_m.apbb009    #發票代碼
         LET g_apba2_d[l_ac].isam030 = g_apbb_m.apbb030    #統一編號
         LET g_apba2_d[l_ac].isam036 = g_apbb_m.apbb036    #狀態
         LET g_apba2_d[l_ac].isamcomp = g_apbb_m.apbbcomp  #法人
         LET g_apba2_d[l_ac].isam001 = "aapt110"           #150422-00026#1
         LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015    #150422-00026#1
         #160325-00031#1---------b
         IF g_apbb_m.apbb0121 = 'Y' THEN
            LET g_apba2_d[l_ac].isam025=g_apbb_m.apbb025
            CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam025,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                 RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                           g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028 
         ELSE
            LET g_apba2_d[l_ac].isam023=g_apbb_m.apbb023
            CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam023,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                 RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                           g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028         
         END IF                 
         #160325-00031#1---------e         
         #若有立帳單號就不能修改 #150612 add ------
         CALL cl_set_comp_entry("isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam036",TRUE)
         IF NOT cl_null(g_apba2_d[l_ac].isam050) THEN
            CALL cl_set_comp_entry("isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam036",FALSE)
         END IF
         #150612 add end---
         CALL cl_set_comp_entry("isam036",FALSE)    #170204-00016#1 add
         
      BEFORE ROW
         LET l_insert = FALSE
         LET l_cmd = ''
         LET l_ac = ARR_CURR()
         LET g_detail_idx = l_ac
         LET l_lock_sw = 'N'
         LET l_n = ARR_COUNT()
         DISPLAY l_ac TO FORMONLY.idx
   
         #CALL s_transaction_begin() #150318-00010#1
         LET g_rec_b = g_apba2_d.getLength()
   
         IF g_rec_b >= l_ac 
            AND g_apba2_d[l_ac].isamseq IS NOT NULL
         THEN 
            LET l_cmd='u'
            LET g_apba2_d_t.* = g_apba2_d[l_ac].*  #BACKUP
            LET g_apba2_d_o.* = g_apba2_d[l_ac].*  #BACKUP
            OPEN aapt110_bcl4 USING g_enterprise,g_apbb_m.apbbdocno,g_apba2_d[g_detail_idx].isamseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "aapt110_bcl2" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            ELSE
               FETCH aapt110_bcl4 INTO g_apba2_d[l_ac].isamseq,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam037, 
                   g_apba2_d[l_ac].isam011,g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam200, 
                   g_apba2_d[l_ac].isam030,g_apba2_d[l_ac].isam012,g_apba2_d[l_ac].isam014,g_apba2_d[l_ac].isam015, 
                   g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,g_apba2_d[l_ac].isam026, 
                   g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028,g_apba2_d[l_ac].isam036,g_apba2_d[l_ac].isam050 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw = "Y"
               END IF
               LET g_bfill = "N"
               LET g_bfill = "Y"
               CALL cl_show_fld_cont()
            END IF
         END IF
         #若有立帳單號就不能修改
         CALL cl_set_comp_entry("isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam036",TRUE)
         IF NOT cl_null(g_apba2_d[l_ac].isam050) THEN
            CALL cl_set_comp_entry("isam008,isam037,isam011,isam009,isam010,isam200,isam030,isam036",FALSE)
         END IF
         CALL cl_set_comp_entry("isam036",FALSE)    #170204-00016#1 add
         #161230-00036#1 add ------
         #媒體申報格式/發票聯數
         SELECT isac004,isac008 INTO g_isac004,g_isac008
           FROM isac_t
          WHERE isacent = g_enterprise
            AND isac002 = g_apba2_d[l_ac].isam008 AND isac001 = g_ooef019
         #161230-00036#1 add end---
      
      
      BEFORE DELETE
         IF NOT cl_null(g_apba2_d[l_ac].isam050) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00293'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CANCEL DELETE
         ELSE
            IF NOT cl_ask_del_detail() THEN
               CANCEL DELETE
            END IF
            IF l_lock_sw = "Y" THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL DELETE
            END IF
   
            DELETE FROM isam_t
             WHERE isament = g_enterprise
               AND isamdocno = g_apbb_m.apbbdocno
               AND isamseq = g_apba2_d_t.isamseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apba_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               #CALL s_transaction_end('N','0') #150318-00010#1
               LET r_success = FALSE
               CANCEL DELETE
            ELSE
               LET g_rec_b = g_rec_b-1
               #CALL s_transaction_end('Y','0') #150318-00010#1
            END IF 
            CLOSE aapt110_bcl4
            LET l_count = g_apba_d.getLength()
            INITIALIZE gs_keys TO NULL 
            LET gs_keys[1] = g_apbb_m.apbbdocno
            LET gs_keys[2] = g_apba2_d[g_detail_idx].isamseq
         END IF

      AFTER DELETE
         #如果是最後一筆
         IF l_ac = (g_apba2_d.getLength() + 1) THEN
            CALL FGL_SET_ARR_CURR(l_ac-1)
         END IF
      
      AFTER INSERT
         LET l_insert = FALSE
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 9001
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         LET l_count = 1
         SELECT COUNT(*) INTO l_count FROM isam_t 
          WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
            AND isamseq = g_apba2_d[l_ac].isamseq
         IF l_count = 0 THEN 
            LET g_apba2_d[l_ac].isam012 = g_apbb_m.apbb012 #稅別
            LET g_apba2_d[l_ac].isam014 = g_apbb_m.apbb014 #幣別
            LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015 #匯率
            INITIALIZE gs_keys TO NULL 
            LET gs_keys[1] = g_apbb_m.apbbdocno
            LET gs_keys[2] = g_apba2_d[g_detail_idx].isamseq
            CALL aapt110_insert_b('isam_t',gs_keys,"'2'")
         ELSE
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'INSERT' 
            LET g_errparam.code   = "std-00006" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            INITIALIZE g_apba_d[l_ac].* TO NULL
            #CALL s_transaction_end('N','0') #150318-00010#1
            LET r_success = FALSE
            CANCEL INSERT
         END IF
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            #CALL s_transaction_end('N','0') #150318-00010#1
            LET r_success = FALSE
            CANCEL INSERT
         ELSE
            #CALL s_transaction_end('Y','0') #150318-00010#1
            LET g_rec_b = g_rec_b + 1
         END IF
         
      ON ROW CHANGE
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 9001
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            LET g_apba2_d[l_ac].* = g_apba2_d_t.*
            CLOSE aapt110_bcl4
            #CALL s_transaction_end('N','0') #150318-00010#1
            LET r_success = FALSE
         END IF
         IF l_lock_sw = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = -263
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_apba2_d[l_ac].* = g_apba2_d_t.*
         ELSE
            #IF cl_null(g_apba2_d[l_ac].isam050) AND #150612 mark
            #   (g_apba2_d[g_detail_idx].isamseq != g_apba2_d_t.isamseq) THEN  #150612 mark
            IF cl_null(g_apba2_d[l_ac].isam050) THEN #150612 add
               LET g_apba2_d[l_ac].isam012 = g_apbb_m.apbb012 #稅別
               LET g_apba2_d[l_ac].isam014 = g_apbb_m.apbb014 #幣別
               LET g_apba2_d[l_ac].isam015 = g_apbb_m.apbb015 #匯率
               
               UPDATE isam_t SET (isamdocno,isamseq,isam008,isam037,isam011,
                                  isam009,isam010,isam200,isam030,isam012,
                                  isam014,isam015,isam023,isam024,isam025,
                                  isam026,isam027,isam028,isam036,isam050
                                 ) = (
                                 g_apbb_m.apbbdocno,g_apba2_d[l_ac].isamseq,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam037,g_apba2_d[l_ac].isam011,
                                 g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam200,g_apba2_d[l_ac].isam030,g_apba2_d[l_ac].isam012,
                                 g_apba2_d[l_ac].isam014,g_apba2_d[l_ac].isam015,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                 g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028,g_apba2_d[l_ac].isam036,g_apba2_d[l_ac].isam050
                                )
                WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
                  AND isamseq = g_apba2_d_t.isamseq
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #CALL s_transaction_end('N','0') #150318-00010#1
                     LET r_success = FALSE
                     LET g_apba2_d[l_ac].* = g_apba2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #CALL s_transaction_end('N','0') #150318-00010#1
                     LET r_success = FALSE
                     LET g_apba2_d[l_ac].* = g_apba2_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_apbb_m.apbbdocno
                     LET gs_keys_bak[1] = g_apbbdocno_t
                     LET gs_keys[2] = g_apba2_d[g_detail_idx].isamseq
                     LET gs_keys_bak[2] = g_apba2_d_t.isamseq
                     CALL aapt110_update_b('isam_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba2_d_t)
               LET g_log2 = util.JSON.stringify(g_apbb_m),util.JSON.stringify(g_apba2_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  #CALL s_transaction_end('N','0') #150318-00010#1
                  LET r_success = FALSE
               END IF
            END IF
         END IF
   
      AFTER FIELD isamseq
         IF  g_apbb_m.apbbdocno IS NOT NULL AND g_apba2_d[g_detail_idx].isamseq IS NOT NULL THEN 
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apbb_m.apbbdocno != g_apbbdocno_t OR g_apba2_d[g_detail_idx].isamseq != g_apba2_d_t.isamseq)) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isam_t WHERE "||"isament = '" ||g_enterprise|| "' AND "||"isamdocno = '"||g_apbb_m.apbbdocno ||"' AND "|| "isamseq = '"||g_apba2_d[g_detail_idx].isamseq ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
   
      AFTER FIELD isam008
         IF NOT cl_null(g_apba2_d[l_ac].isam008) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam008) OR g_apba2_d[l_ac].isam008 != g_apba2_d_t.isam008) OR cl_null(g_apba2_d_t.isam008))) THEN
               #發票類型檢核的chk
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_apba2_d[l_ac].isam008
               #紅字發票與藍字發票是否共用發票簿
               #161230-00036#1 mark ------
               #SELECT isai006 INTO g_isai006
               #  FROM ooef_t
               #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
               # WHERE ooefent = g_enterprise
               #   AND ooef001 = g_apbb_m.apbbcomp
               #161230-00036#1 mark end---
               IF g_isai006 = "Y" THEN #有共用發票簿
                  IF NOT cl_chk_exist("v_isac002_3") THEN
                     LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF g_apbb_m.apbb050='2' THEN #紅字發票
                     IF NOT cl_chk_exist("v_isac002_4") THEN
                        LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT cl_chk_exist("v_isac002_1") THEN
                        LET g_apbb_m.apbb008 = g_apbb_m_t.apbb008
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #檢核發票是否重複
               #160107-00004#1 add apbbcomp,apbb002
               CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam008 = g_apba2_d_t.isam008
                  NEXT FIELD CURRENT
               END IF
               #變動異動狀態
               CALL aapt110_change_type(g_apbb_m.apbbcomp,g_apba2_d[l_ac].isam008) RETURNING g_apba2_d[l_ac].isam036
               DISPLAY BY NAME g_apba2_d[l_ac].isam036
               
               #151013-00016#14 ---s---
               #161230-00036#1 mark ------
               #LET l_isac004 = ''
               #SELECT isac004 INTO l_isac004 FROM isac_t
               # WHERE isacent = g_enterprise AND isac002 = g_apba2_d[l_ac].isam008 AND isac001 = g_ooef019
               #IF cl_null(l_isac004) THEN LET g_apba2_d[l_ac].isam037 = '3' END IF
               #161230-00036#1 mark end---
               #161230-00036#1 add ------
               SELECT isac004,isac008 INTO g_isac004,g_isac008 FROM isac_t
                WHERE isacent = g_enterprise AND isac002 = g_apba2_d[l_ac].isam008 AND isac001 = g_ooef019
               IF cl_null(g_isac004) THEN LET g_apba2_d[l_ac].isam037 = '3' END IF
               #161230-00036#1 add end---
               DISPLAY BY NAME g_apba2_d[l_ac].isam037
               #151013-00016#14 ---e---
            END IF
         END IF
      
      
      #161006-00011#1 add ------
      #發票日期
      AFTER FIELD isam011
         IF NOT cl_null(g_apba2_d[l_ac].isam011) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam011) OR g_apba2_d[l_ac].isam011 != g_apba2_d_t.isam011) OR cl_null(g_apba2_d_t.isam011))) THEN
               LET l_pmdldocdt = ''
               IF g_apbb_m.apbb003 = '7' THEN
                  #採購單
                  SELECT MIN(pmdldocdt) INTO l_pmdldocdt FROM pmdl_t
                   WHERE pmdlent = g_enterprise
                     AND EXISTS (SELECT 1 FROM apba_t WHERE apbaent = pmdlent
                                    AND apba005 = pmdldocno AND apba004 = '10'
                                    AND apbadocno = g_apbb_m.apbbdocno)
               END IF
               IF g_apbb_m.apbb003 = '2' THEN
                  #入庫單串回採購單
                  SELECT MIN(pmdldocdt) INTO l_pmdldocdt FROM pmdt_t,pmdl_t
                   WHERE pmdtent = pmdlent AND pmdt001 = pmdldocno
                     AND pmdtent = g_enterprise
                     AND EXISTS (SELECT 1 FROM apba_t WHERE apbaent = pmdlent
                                    AND apba013 = pmdldocno AND apba004 = '11'
                                    AND apbadocno = g_apbb_m.apbbdocno)
               END IF
               IF NOT cl_null(l_pmdldocdt) THEN
                  IF g_apba2_d[l_ac].isam011 < l_pmdldocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-01136'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam011 = g_apba2_d_t.isam011
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         END IF
      #161006-00011#1 add end---
      
      
      AFTER FIELD isam009
         IF NOT cl_null(g_apba2_d[l_ac].isam009) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam009) OR g_apba2_d[l_ac].isam009 != g_apba2_d_t.isam009) OR cl_null(g_apba2_d_t.isam009))) THEN
               #檢核發票是否重複
               #160107-00004#1 add apbbcomp,apbb002
               CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam009 = g_apba2_d_t.isam009
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
      
      AFTER FIELD isam010
         IF NOT cl_null(g_apba2_d[l_ac].isam010) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam010) OR g_apba2_d[l_ac].isam010 != g_apba2_d_t.isam010) OR cl_null(g_apba2_d_t.isam010))) THEN
               #160713-00019#1--add--start-- 
               IF g_isai002 = "1" THEN
                  CALL aapt110_isad005_chk(g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam011) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam010 = g_apba2_d_t.isam010
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160713-00019#1--add--end---- 
               #檢核發票是否重複
               #160107-00004#1 add apbbcomp,apbb002
               CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam010 = g_apba2_d_t.isam010
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
   
      AFTER FIELD isam023
         #原幣未稅金額
         IF NOT cl_null(g_apba2_d[l_ac].isam023) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam023) OR g_apba2_d[l_ac].isam023 != g_apba2_d_t.isam023) OR cl_null(g_apba2_d_t.isam023))) THEN
               #紅字發票不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam023 >= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam023 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                  NEXT FIELD CURRENT
               END IF
               
               #檢核紅字發票是否超過扣抵金額
               IF g_apbb_m.apbb050 = '2' AND g_isai002 ='1' THEN
                  IF NOT cl_null(g_apba2_d[l_ac].isam010) THEN #170117-00030#1 add
                  #160107-00004#1 add apbbcomp,apbb002
                  CALL aapt110_invoice_repeat_chk(g_apba2_d[l_ac].isam009,g_apba2_d[l_ac].isam010,g_apba2_d[l_ac].isam008,g_apba2_d[l_ac].isam011,g_apbb_m.apbbdocno,g_apba2_d[l_ac].isam023,g_apbb_m.apbbcomp,g_apbb_m.apbb002)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apba2_d[l_ac].isam023 = g_apba2_d_t.isam023
                     NEXT FIELD CURRENT
                  END IF
                  END IF #170117-00030#1 add
               END IF
               
               #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
               #RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025
               #         ,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
               
               #150422-00026#1 add ---
               IF g_apbb_m.apbb0121 = 'N' THEN
                  CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam023,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                       RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                 g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
               ELSE
                  LET g_apba2_d[l_ac].isam024 = g_apba2_d[l_ac].isam025 - g_apba2_d[l_ac].isam023
                  
                  IF g_apba2_d[l_ac].isam015 = 1 THEN
                     LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                  ELSE
                     LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apba2_d[l_ac].isam015
                     CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                  END IF
               END IF
               #150422-00026#1 end ---
               
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF
   
      AFTER FIELD isam024
         IF NOT cl_null(g_apba2_d[l_ac].isam024) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam024) OR g_apba2_d[l_ac].isam024 != g_apba2_d_t.isam024) OR cl_null(g_apba2_d_t.isam024))) THEN
               #紅字發票金額不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam024 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam024 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                  NEXT FIELD CURRENT
               END IF
               
               #檢核容差率
               CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025)
               RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025
               #容差率OK否
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam024 = g_apba2_d_t.isam024
                  NEXT FIELD CURRENT
               ELSE
                  #IF g_apbb_m.apbb0121 = "Y" THEN
                  #   #容差率OK要更新本幣金額
                  #   LET g_apba2_d[l_ac].isam028 = (g_apba2_d[l_ac].isam023+g_apba2_d[l_ac].isam024) * g_apbb_m.apbb015
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                  #   LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 / (1+(g_apbb_m.apbb013/100))
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                  #   #稅額=含稅-未稅
                  #   LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                  #ELSE
                  #   #容差率OK要更新本幣金額
                  #   LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apbb_m.apbb015
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
                  #   LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam026 * (g_apbb_m.apbb013/100)
                  #   CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                  #   #含稅=未稅+稅額
                  #   LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 + g_apba2_d[l_ac].isam027
                  #END IF
                  #150422-00026#1 add ---
                  #容差率OK更新本幣金額
                  IF g_apba2_d[l_ac].isam015 = 1 THEN
                     LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                     LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
                  ELSE
                     IF g_apbb_m.apbb0121 = "Y" THEN
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024 * g_apba2_d[l_ac].isam015
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam027
                     ELSE
                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024 * g_apba2_d[l_ac].isam015
                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam027,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam027
                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 + g_apba2_d[l_ac].isam027
                     END IF
                  END IF
                  #150422-00026#1 end ---
               END IF
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF
   
      AFTER FIELD isam025
         #原幣含稅金額
         IF NOT cl_null(g_apba2_d[l_ac].isam025) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam025) OR g_apba2_d[l_ac].isam025 != g_apba2_d_t.isam025) OR cl_null(g_apba2_d_t.isam025))) THEN
               #紅字發票金額不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam025 >= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam025 = g_apba2_d_t.isam025
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam025 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam025 = g_apba2_d_t.isam025
                  NEXT FIELD CURRENT
               END IF
               
               #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
               #RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025
               #         ,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
               #150422-00026#1 add ---
               IF g_apbb_m.apbb0121 = 'Y' THEN
                  CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,g_apba2_d[l_ac].isam025,1,g_apbb_m.apbb014,g_apba2_d[l_ac].isam015)
                       RETURNING g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                                 g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028 
               ELSE
                  LET g_apba2_d[l_ac].isam024 = g_apba2_d[l_ac].isam025 - g_apba2_d[l_ac].isam023
                  IF g_apba2_d[l_ac].isam015 = 1 THEN
                     LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
                  ELSE
                     LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025 * g_apba2_d[l_ac].isam015
                     CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
                     LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
                  END IF
               END IF
               #150422-00026#1 end ---
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF

   
      AFTER FIELD isam026
         #本幣未稅金額
         IF NOT cl_null(g_apba2_d[l_ac].isam026) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam026) OR g_apba2_d[l_ac].isam026 != g_apba2_d_t.isam026) OR cl_null(g_apba2_d_t.isam026))) THEN
               #紅字發票金額不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam026 >= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam026 = g_apba2_d_t.isam026
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam026 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam026 = g_apba2_d_t.isam026
                  NEXT FIELD CURRENT
               END IF
               
               #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
               #LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apbb_m.apbb015
               #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
               #
               #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
               #LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam026 * (1+(g_apbb_m.apbb013/100))
               #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
               #
               ##稅額=含稅-未稅
               #LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026  
               
               #150422-00026#1 add ---
               #稅額=含稅-未稅
               LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026

               #匯率>>2.以含稅金額重計匯率
               LET g_apba2_d[l_ac].isam015 = g_apba2_d[l_ac].isam028 / g_apba2_d[l_ac].isam025
               #150422-00026#1 end ---
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF
   
      AFTER FIELD isam027
         IF NOT cl_null(g_apba2_d[l_ac].isam027) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam027) OR g_apba2_d[l_ac].isam027 != g_apba2_d_t.isam027) OR cl_null(g_apba2_d_t.isam027))) THEN
               #紅字發票金額不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam027 >= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam027 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                  NEXT FIELD CURRENT
               END IF
               
               #檢核容差率
               CALL s_tax_sum_money_tax(g_apbb_m.apbbcomp,g_ooef019,g_apbb_m.apbb012,g_apbb_m.apbb008,g_apbb_m.apbb014,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028)
               RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
               #容差率OK否
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam027 = g_apba2_d_t.isam027
                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF
   
      AFTER FIELD isam028
         #本幣含稅金額
         IF NOT cl_null(g_apba2_d[l_ac].isam028) THEN
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_apba2_d[l_ac].isam028) OR g_apba2_d[l_ac].isam028 != g_apba2_d_t.isam028) OR cl_null(g_apba2_d_t.isam028))) THEN
               #紅字發票金額不可為正數
               IF g_apbb_m.apbb050 = '2' AND g_apba2_d[l_ac].isam028 >= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam028 = g_apba2_d_t.isam028
                  NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 add
               IF g_apbb_m.apbb050 = '1' AND g_apba2_d[l_ac].isam028 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_apba2_d[l_ac].isam028 = g_apba2_d_t.isam028
                  NEXT FIELD CURRENT
               END IF
               
               #IF cl_null(g_apbb_m.apbb015) THEN LET g_apbb_m.apbb015 = 1 END IF
               #LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025 * g_apbb_m.apbb015
               #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
               #
               #IF cl_null(g_apbb_m.apbb013) THEN LET g_apbb_m.apbb013 = 0 END IF
               #LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam028 / (1+(g_apbb_m.apbb013/100))
               #CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
               #
               ##稅額=含稅-未稅
               #LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
               
               #150422-00026#1 add ---
               LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026

               #匯率>>2.以含稅金額重計匯率
               LET g_apba2_d[l_ac].isam015 = g_apba2_d[l_ac].isam028 / g_apba2_d[l_ac].isam025
               #150422-00026#1 end ---
               DISPLAY BY NAME g_apba2_d[l_ac].isam023,g_apba2_d[l_ac].isam024,g_apba2_d[l_ac].isam025,
                               g_apba2_d[l_ac].isam026,g_apba2_d[l_ac].isam027,g_apba2_d[l_ac].isam028
            END IF
         END IF
   
      ON ACTION controlp INFIELD isam008
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_apba2_d[g_detail_idx].isam008
         #紅字發票與藍字發票是否共用發票簿
         #161230-00036#1 mark ------
         #SELECT isai006 INTO g_isai006
         #  FROM ooef_t
         #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
         # WHERE ooefent = g_enterprise
         #   AND ooef001 = g_apbb_m.apbbcomp
         #161230-00036#1 mark end---
         CASE g_apbb_m.apbb050
            WHEN "1"
               LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '1'"
            WHEN "2"
               IF g_isai006 = "Y" THEN
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
               ELSE
                  LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 = '3'"
               END IF
            OTHERWISE
               LET g_qryparam.where = "isac001 = '",g_ooef019,"' AND isac003 IN ('1','3')"
         END CASE
         CALL q_isac002()
         LET g_apba2_d[g_detail_idx].isam008 = g_qryparam.return1
         DISPLAY BY NAME g_apba2_d[g_detail_idx].isam008
         NEXT FIELD isam008
   
      AFTER ROW
         LET l_ac = ARR_CURR()
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 9001
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET INT_FLAG = 0
            IF l_cmd = 'u' THEN
               LET g_apba2_d[l_ac].* = g_apba2_d_t.*
            END IF
            CLOSE aapt110_bcl4
            #CALL s_transaction_end('N','0') #150318-00010#1
            LET r_success = FALSE
         END IF
         CALL aapt110_unlock_b("isam_t","'2'")
         #CALL s_transaction_end('Y','0') #150318-00010#1
   
      AFTER INPUT
         #更新單頭金額(此不更新僅判斷有沒有一樣)
         CALL aapt110_money_update_to_head("isam","N")
           
         #發票號碼兩筆以上且不為空白，則更新apbb010為MULTI，一筆就回寫到單頭的apbb010
         SELECT COUNT(*) INTO l_cnt
           FROM isam_t
          WHERE isament = g_enterprise
            AND isamdocno = g_apbb_m.apbbdocno
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF (l_cnt = 1) AND NOT cl_null(g_apba2_d[1].isam010) THEN
            LET g_apbb_m.apbb009 = g_apba2_d[1].isam009
            LET g_apbb_m.apbb010 = g_apba2_d[1].isam010
            LET g_apbb_m.apbb011 = g_apba2_d[1].isam011  #170218-00030#1 add
         ELSE
            IF l_cnt > 1 THEN #發票兩筆以上
               LET g_apbb_m.apbb009 = ""
               LET g_apbb_m.apbb010 = "MULTI"
            ELSE
               LET g_apbb_m.apbb009 = ""
               LET g_apbb_m.apbb010 = ""
            END IF
         END IF
         UPDATE apbb_t SET apbb009 = g_apbb_m.apbb009,
                           apbb010 = g_apbb_m.apbb010,
                           apbb011 = g_apbb_m.apbb011  #170218-00030#1 add
          WHERE apbbent = g_enterprise
            AND apbbdocno = g_apbb_m.apbbdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "UPDATE apbb_t wrong!" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            #CALL s_transaction_end('N','0') #150318-00010#1
            LET r_success = FALSE
         END IF
         DISPLAY BY NAME g_apbb_m.apbb009,g_apbb_m.apbb010,
                         g_apbb_m.apbb011  #170218-00030#1 add
         
   END INPUT
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生對帳單明細
# Memo...........: 
# Usage..........: CALL aapt110_auto_ins_detail()

# Date & Author..: 2015/01/14 By Reanna #141218-00011#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_auto_ins_detail()
DEFINE l_cnt         LIKE type_t.num5

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt110_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aapt110_cl
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      #寫入來源單身
      #20150601--add--str--lujh
      IF g_apbb_m.apbb056 = 'Y' THEN 
         CALL aapt110_ins_apba_1() RETURNING g_sub_success
      ELSE
      #20150601--add--end--lujh
         CALL aapt110_ins_apba() RETURNING g_sub_success
      END IF  #20150601 add lujh

      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL cl_err_collect_show()
         CALL s_transaction_end('Y','0')
         
         #單身總筆數
         SELECT COUNT(*) INTO l_cnt FROM apba_t
          WHERE apbaent = g_enterprise
            AND apbadocno = g_apbb_m.apbbdocno
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         DISPLAY l_cnt TO FORMONLY.cnt
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 產生對帳單明細>>寫入來源單身
# Memo...........: 
# Usage..........: CALL aapt110_ins_apba()
#                  RETURNING r_success
# Date & Author..: 2015/01/14 By Reanna #141218-00011#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_ins_apba()
#DEFINE l_apba           RECORD LIKE apba_t.*#161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_apba RECORD  #進項發票明細檔
       apbaent   LIKE apba_t.apbaent, #企業編號
       apbadocno LIKE apba_t.apbadocno, #檔案號碼
       apbaorga  LIKE apba_t.apbaorga, #帳務歸屬組織
       apba001   LIKE apba_t.apba001, #發票類型
       apba002   LIKE apba_t.apba002, #發票編號
       apba003   LIKE apba_t.apba003, #發票號碼
       apbaseq   LIKE apba_t.apbaseq, #項次
       apba004   LIKE apba_t.apba004, #來源作業
       apba005   LIKE apba_t.apba005, #業務單號碼
       apba006   LIKE apba_t.apba006, #業務單項次
       apba007   LIKE apba_t.apba007, #產品編號
       apba008   LIKE apba_t.apba008, #品名規格
       apba009   LIKE apba_t.apba009, #單位
       apba010   LIKE apba_t.apba010, #發票數量
       apba011   LIKE apba_t.apba011, #暫估帳款數量
       apba012   LIKE apba_t.apba012, #正負值
       apba013   LIKE apba_t.apba013, #參考單號
       apba014   LIKE apba_t.apba014, #單價
       apba015   LIKE apba_t.apba015, #稅別
       apba016   LIKE apba_t.apba016, #扣抵發票編號
       apba017   LIKE apba_t.apba017, #扣抵藍字發票號碼
       apba100   LIKE apba_t.apba100, #交易原幣
       apba103   LIKE apba_t.apba103, #原幣未稅金額
       apba104   LIKE apba_t.apba104, #原幣稅額
       apba105   LIKE apba_t.apba105, #原幣含稅總額
       apba111   LIKE apba_t.apba111, #發票匯率
       apba113   LIKE apba_t.apba113, #發票幣未稅金額
       apba114   LIKE apba_t.apba114, #發票幣稅額
       apba115   LIKE apba_t.apba115, #發票幣含稅總額
       apbaud001 LIKE apba_t.apbaud001, #自定義欄位(文字)001
       apbaud002 LIKE apba_t.apbaud002, #自定義欄位(文字)002
       apbaud003 LIKE apba_t.apbaud003, #自定義欄位(文字)003
       apbaud004 LIKE apba_t.apbaud004, #自定義欄位(文字)004
       apbaud005 LIKE apba_t.apbaud005, #自定義欄位(文字)005
       apbaud006 LIKE apba_t.apbaud006, #自定義欄位(文字)006
       apbaud007 LIKE apba_t.apbaud007, #自定義欄位(文字)007
       apbaud008 LIKE apba_t.apbaud008, #自定義欄位(文字)008
       apbaud009 LIKE apba_t.apbaud009, #自定義欄位(文字)009
       apbaud010 LIKE apba_t.apbaud010, #自定義欄位(文字)010
       apbaud011 LIKE apba_t.apbaud011, #自定義欄位(數字)011
       apbaud012 LIKE apba_t.apbaud012, #自定義欄位(數字)012
       apbaud013 LIKE apba_t.apbaud013, #自定義欄位(數字)013
       apbaud014 LIKE apba_t.apbaud014, #自定義欄位(數字)014
       apbaud015 LIKE apba_t.apbaud015, #自定義欄位(數字)015
       apbaud016 LIKE apba_t.apbaud016, #自定義欄位(數字)016
       apbaud017 LIKE apba_t.apbaud017, #自定義欄位(數字)017
       apbaud018 LIKE apba_t.apbaud018, #自定義欄位(數字)018
       apbaud019 LIKE apba_t.apbaud019, #自定義欄位(數字)019
       apbaud020 LIKE apba_t.apbaud020, #自定義欄位(數字)020
       apbaud021 LIKE apba_t.apbaud021, #自定義欄位(日期時間)021
       apbaud022 LIKE apba_t.apbaud022, #自定義欄位(日期時間)022
       apbaud023 LIKE apba_t.apbaud023, #自定義欄位(日期時間)023
       apbaud024 LIKE apba_t.apbaud024, #自定義欄位(日期時間)024
       apbaud025 LIKE apba_t.apbaud025, #自定義欄位(日期時間)025
       apbaud026 LIKE apba_t.apbaud026, #自定義欄位(日期時間)026
       apbaud027 LIKE apba_t.apbaud027, #自定義欄位(日期時間)027
       apbaud028 LIKE apba_t.apbaud028, #自定義欄位(日期時間)028
       apbaud029 LIKE apba_t.apbaud029, #自定義欄位(日期時間)029
       apbaud030 LIKE apba_t.apbaud030, #自定義欄位(日期時間)030
       apba018   LIKE apba_t.apba018, #本次開票金額
       apba019   LIKE apba_t.apba019, #預付已開發票
       apba020   LIKE apba_t.apba020  #期別
          END RECORD
#161104-00024#1-add(e)
DEFINE r_success        LIKE type_t.num5
DEFINE l_wc             STRING
DEFINE l_sql            STRING
DEFINE l_pmds000        STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sum_apba010    LIKE apba_t.apba010
DEFINE l_sfin3015       LIKE type_t.chr1     #發票限制同法人否?
#150702-00001#1-----s
DEFINE l_pmds000_str1   STRING               #AP可用的入庫單性質
DEFINE l_pmds000_str2   STRING               #入庫單性質(入庫)
DEFINE l_pmds000_str3   STRING               #入庫單性質(倉退)
#150702-00001#1-----e
DEFINE l_pmds011_str1   STRING               #160530-00005#3
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1
#160705-00035#1-s
DEFINE l_apba013        LIKE apba_t.apba013
DEFINE l_apca019        LIKE apca_t.apca019
#160705-00035#1-e
#161206-00042#5-----s
DEFINE l_pmaa004        LIKE pmaa_t.pmaa004
#161206-00042#5-----e 

   LET r_success = TRUE
   
   #160705-00035#1 mark ------
   #CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
   #CALL s_fin_account_center_sons_str()RETURNING g_wc_apbaorga
   #CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
   #160705-00035#1 mark end---
   
  #CALL aapt110_02(g_apbb_m.apbb004,g_apbb_m.apbb002,g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb050,g_wc_apbaorga) #160705-00035#1 mark
  #CALL aapt110_02(g_apbb_m.apbb004,g_apbb_m.apbb002,g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb050,g_wc_apbaorga,g_apbb_m.apbb003) #160705-00035#1   #161206-00042#5 mark
   CALL aapt110_02(g_apbb_m.apbb004,g_apbb_m.apbb002,g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb050,g_wc_apbaorga,g_apbb_m.apbb003,g_apbb_m.apbb059)   #161206-00042#5
        RETURNING l_wc
   
   #161206-00042#5-----s
   LET l_pmaa004 = NULL
   SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_apbb_m.apbb002

   #161206-00042#5-----e   
   
   #160705-00035#1-s
   IF g_apbb_m.apbb003 = '7' THEN  #7:預付發票立帳
      #CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno) RETURNING r_success   #170110-00035#1 mark
      CALL s_aapt110_auto_ins_10(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno,'') RETURNING r_success #170110-00035#1 add
   ELSE
   #160705-00035#1-e
   
      #150702-00001#1-----s
      LET l_pmds000_str1 = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
      LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
     
      LET l_pmds000_str2 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = 1 ")
      LET l_pmds000_str2 = s_fin_get_wc_str(l_pmds000_str2)    
     
      LET l_pmds000_str3 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = -1 ")
      LET l_pmds000_str3 = s_fin_get_wc_str(l_pmds000_str3)  
      #150702-00001#1-----e
      #160530-00005#3--s
      LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
      LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)   
      #160530-00005#3--e   
      
      IF g_apbb_m.apbb050 = "2" THEN  #紅字發票只開倉退單
         #LET l_pmds000 = "('7','14','15','26')"   #150629-00038#1 add '26' #150702-00001#1 mark
         LET l_pmds000 = l_pmds000_str3 CLIPPED
      ELSE #入庫單+倉退單
         #LET l_pmds000 = "('3','4','6','7','12','13','14','15','22','24','25','26','20')"   #150629-00038#1 add 20~26  ##150702-00001#1 mark
         LET l_pmds000 = l_pmds000_str1 CLIPPED    ##150702-00001#1 add
      END IF
      
      #發票限制同法人否?
      CALL cl_get_para(g_enterprise,g_apbb_m.apbbcomp,'S-FIN-3015') RETURNING l_sfin3015

      #161206-00042#5-----e   
      IF l_pmaa004 = '2' THEN
         LET l_wc = l_wc ," AND pmds028 = '",g_apbb_m.apbb059,"' "
      END IF
      #161206-00042#5-----e   
      
      LET l_sql = "SELECT pmdtsite,pmds000,pmdtdocno,pmdtseq,pmdt006,",
      #160602-00023#1-----begin
   #              "       imaal003,pmdt001,pmds037,pmdt019,pmdt036,",
                  "       (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||",
                  "       (CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||",
                  "       (CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END),",
                  #"      pmdt001,pmds037,pmdt019,pmdt036", #160614-00015#1 mark
      #160602-00023#1-----end               
                  #160614-00015#1 --s add
                  "       pmdt001,pmds037,",
                  #       入庫/退單時，"單位"改取計價單位 pmdt023
                  #"       (CASE WHEN pmds000 = '11' OR pmds000 = '20' OR pmds000 = '21' THEN pmdt023 ELSE pmdt019 END),", #170208-00007#1 mark
                  "       pmdt023,", #170208-00007#1
                  "       pmdt036,",
                  #160614-00015#1 --e add
                  "       (pmdt024-pmdt069),pmdt038,pmdt039,pmdt047",
                  "  FROM pmds_t,pmdt_t ",
                  "  LEFT OUTER JOIN imaal_t ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_lang,"'",
                  "  WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno",
                  "    AND (pmdt024-pmdt069>0 OR pmdt069 IS NULL)",
                  "    AND pmdsent = ",g_enterprise,
                  "    AND pmdtsite IN ",g_wc_apbaorga,
                  "    AND pmds008 = '",g_apbb_m.apbb002,"'",
                  "    AND pmds000 IN ",l_pmds000,
                  "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,   #160530-00005#3
                  "    AND pmds037 = '",g_apbb_m.apbb014,"'",
                  "    AND pmdsdocdt <= '",g_apbb_m.apbbdocdt,"'",
                  "    AND pmdt046 = '",g_apbb_m.apbb012,"'",
                  "    AND pmdsstus = 'S'",
                  "    AND (pmdt024-pmdt069) > (SELECT CASE WHEN SUM(apba010)  IS NULL THEN 0 ELSE SUM(apba010) END AS aaa",
                  "                               FROM apba_t,apbb_t",
                  "                              WHERE apbaent = apbbent AND apbadocno = apbbdocno",
                  "                                AND apbbstus = 'N'",
                  "                                AND apba005 = pmdtdocno",
                  "                                AND apba006 = pmdtseq)",
                  "    AND ",l_wc,
                  " ORDER BY pmdtdocno,pmdtseq"
      PREPARE sel_pmds_p FROM l_sql
      DECLARE sel_pmds_c CURSOR FOR sel_pmds_p
      FOREACH sel_pmds_c INTO l_apba.apbaorga,l_apba.apba004,l_apba.apba005,l_apba.apba006,l_apba.apba007,
                              l_apba.apba008,l_apba.apba013,l_apba.apba100,l_apba.apba009,l_apba.apba014,
                              l_apba.apba010,l_apba.apba103,l_apba.apba105,l_apba.apba104
         
         #若發票限制同法人，要判斷是不是同法人，不同就不寫入
         IF l_sfin3015 = "Y" THEN
            CALL aapt110_apbaorga_chk(g_apbb_m.apbbcomp,l_apba.apbaorga,g_wc_apbaorga) #141218-00011#1 By Reanna
                 RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               CONTINUE FOREACH
            END IF
         END IF
         
         #項次
         SELECT MAX(apbaseq)+1 INTO l_apba.apbaseq FROM apba_t
          WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
         IF cl_null(l_apba.apbaseq) OR l_apba.apbaseq = 0 THEN
            LET l_apba.apbaseq = 1
         END IF
      
         #來源作業
         IF l_apba.apba004 = '7' OR l_apba.apba004 MATCHES '1[45]' THEN
            LET l_apba.apba004 = "21"
            LET l_apba.apba012 = -1
         ELSE
            LET l_apba.apba004 = "11"
            LET l_apba.apba012 = 1
         END IF
         
         #161214-00005#1---add---str--
         IF l_apba.apba004 = '11' OR l_apba.apba004 = '20' OR l_apba.apba004 = '21' THEN
            LET l_apba.apba008 = s_aapt300_get_apcb005(l_apba.apba007,l_apba.apba005,l_apba.apba006)
         END IF
         #161214-00005#1---add---end--
   
         #稅別
         LET l_apba.apba015 = g_apbb_m.apbb012
         #匯率
         LET l_apba.apba111 = g_apbb_m.apbb015
         
         #先統計該單據是有已立過對帳單，若有要把已立數量SUM出來
         SELECT SUM(apba010) INTO l_sum_apba010
           FROM apba_t,apbb_t
          WHERE apbaent = apbbent AND apbadocno = apbbdocno
            AND apbbent = g_enterprise
            AND apbbstus = 'N'
            AND apba005 = l_apba.apba005
            AND apba006 = l_apba.apba006
         IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
         LET l_apba.apba010 = l_apba.apba010 - l_sum_apba010
         #單價取位 Reanna 15/02/03
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
         #重新計算金額
         #160802-00049#1-s
         LET l_money = l_apba.apba014*l_apba.apba010
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
         #160802-00049#1-e
        #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115  
         
         #判斷該筆入庫單+項次是否已存在該對帳單，不存在才寫入
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM apba_t
          WHERE apbaent = g_enterprise
            AND apbadocno = g_apbb_m.apbbdocno
            AND apba005 = l_apba.apba005
            AND apba006 = l_apba.apba006
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt = 0 THEN
            INSERT INTO apba_t(apbaent,apbadocno,apbaseq,apbaorga,apba004,
                               apba005,apba006,apba007,apba008,apba013,
                               apba015,apba012,apba100,apba009,apba014,
                               apba010,apba103,apba105,apba104,apba113,
                               apba115,apba114,apba016,apba017,apba111) 
                        VALUES(g_enterprise,g_apbb_m.apbbdocno,l_apba.apbaseq,l_apba.apbaorga,l_apba.apba004,
                               l_apba.apba005,l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba013,
                               l_apba.apba015,l_apba.apba012,l_apba.apba100,l_apba.apba009,l_apba.apba014,
                               l_apba.apba010,l_apba.apba103,l_apba.apba105,l_apba.apba104,l_apba.apba113,
                               l_apba.apba115,l_apba.apba114,'','',l_apba.apba111)
            IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ins apba_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
            ELSE
               #入庫單就要看收貨單有沒有發票可寫入
               IF l_apba.apba004 = "11" THEN
                  CALL aapt110_ins_isam_from_pmdw(l_apba.apba005) RETURNING g_sub_success
               END IF
            END IF
         END IF
      END FOREACH
      
      #160705-00035#1-s
      #入庫單要順便看看採購單有沒有訂金待底，有的話要寫入
      LET l_sql = "SELECT DISTINCT apba013",
                  "  FROM apba_t ",
                  " WHERE apbaent = ",g_enterprise,
                  "   AND apbadocno = '",g_apbb_m.apbbdocno,"'"
      PREPARE aapt110_sel_apba_p1 FROM l_sql
      DECLARE aapt110_sel_apba_c1 CURSOR FOR aapt110_sel_apba_p1
      
      LET l_sql = "SELECT DISTINCT apca019",
                  "  FROM apca_t",
                  "  LEFT JOIN apcb_t ON apcaent=apcbent AND apcald=apcbld AND apcadocno=apcbdocno",
                  " WHERE apcaent = ",g_enterprise,
                  "   AND apcastus = 'Y'",
                  "   AND apcb002 = ? AND apca001 LIKE '1%'"
      PREPARE aapt110_sel_apca_p1 FROM l_sql
      DECLARE aapt110_sel_apca_c1 CURSOR FOR aapt110_sel_apca_p1
      
      FOREACH aapt110_sel_apba_c1 INTO l_apba013
         
         FOREACH aapt110_sel_apca_c1 USING l_apba013 INTO l_apca019
            IF NOT cl_null(l_apca019) THEN
               LET l_wc = "apccdocno = '",l_apca019,"'"
               CALL s_aapt110_auto_ins_27(l_wc,g_apbb_m.apbbcomp,g_apbb_m.apbbdocno)RETURNING g_sub_success
            END IF
         END FOREACH
         
      END FOREACH
      #160705-00035#1-e
      
   END IF   #160705-00035#1

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取收貨單的發票&寫入發票檔
# Memo...........:
# Usage..........: CALL aapt110_ins_isam_from_pmdw(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno  入庫單號
# Date & Author..: 2015/01/14 By Reanna #141218-00011#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_ins_isam_from_pmdw(p_docno)
DEFINE p_docno          LIKE apba_t.apba005  #入庫單號
DEFINE r_success        LIKE type_t.num5
DEFINE l_receiveno      LIKE pmds_t.pmds006  #收貨單號
DEFINE l_pmdw           RECORD
          pmdw001          LIKE pmdw_t.pmdw001,
          pmdw002          LIKE pmdw_t.pmdw002,
          pmdw008          LIKE pmdw_t.pmdw008,
          pmdw009          LIKE pmdw_t.pmdw009,
          pmdw010          LIKE pmdw_t.pmdw010,
          pmdw011          LIKE pmdw_t.pmdw011,
          pmdw012          LIKE pmdw_t.pmdw012,
          pmdw0121         LIKE pmdw_t.pmdw0121,
          pmdw013          LIKE pmdw_t.pmdw013,
          pmdw014          LIKE pmdw_t.pmdw014,
          pmdw015          LIKE pmdw_t.pmdw015,
          pmdw016          LIKE pmdw_t.pmdw016,
          pmdw017          LIKE pmdw_t.pmdw017,
          pmdw018          LIKE pmdw_t.pmdw018,
          pmdw019          LIKE pmdw_t.pmdw019,
          pmdw020          LIKE pmdw_t.pmdw020,
          pmdw021          LIKE pmdw_t.pmdw021,
          pmdw022          LIKE pmdw_t.pmdw022,
          pmdw023          LIKE pmdw_t.pmdw023,
          pmdw024          LIKE pmdw_t.pmdw024,
          pmdw025          LIKE pmdw_t.pmdw025,
          pmdw026          LIKE pmdw_t.pmdw026,
          pmdw027          LIKE pmdw_t.pmdw027,
          pmdw028          LIKE pmdw_t.pmdw028,
          pmdw029          LIKE pmdw_t.pmdw029,
          pmdw030          LIKE pmdw_t.pmdw030,
          pmdw031          LIKE pmdw_t.pmdw031,
          pmdw032          LIKE pmdw_t.pmdw032,
          pmdw033          LIKE pmdw_t.pmdw033,
          pmdw034          LIKE pmdw_t.pmdw034,
          pmdw035          LIKE pmdw_t.pmdw035,
          pmdw036          LIKE pmdw_t.pmdw036,
          pmdw037          LIKE pmdw_t.pmdw037,
          pmdw038          LIKE pmdw_t.pmdw038,
          pmdw039          LIKE pmdw_t.pmdw039,
          pmdw040          LIKE pmdw_t.pmdw040,
          pmdw041          LIKE pmdw_t.pmdw041,
          pmdw042          LIKE pmdw_t.pmdw042,
          pmdw043          LIKE pmdw_t.pmdw043,
          pmdw045          LIKE pmdw_t.pmdw045,
          pmdw046          LIKE pmdw_t.pmdw046,
          pmdw047          LIKE pmdw_t.pmdw047,
          pmdw048          LIKE pmdw_t.pmdw048,
          pmdw049          LIKE pmdw_t.pmdw049,
          pmdw201          LIKE pmdw_t.pmdw201,
          pmdw202          LIKE pmdw_t.pmdw202,
          pmdw203          LIKE pmdw_t.pmdw203,
          pmdw204          LIKE pmdw_t.pmdw204,
          pmdw205          LIKE pmdw_t.pmdw205,
          pmdw206          LIKE pmdw_t.pmdw206,
          pmdw207          LIKE pmdw_t.pmdw207
                        END RECORD
DEFINE l_isamseq        LIKE isam_t.isamseq  #發票項次
DEFINE l_cnt            LIKE type_t.num5
#160107-00004#1 add ------
DEFINE l_sql            STRING
DEFINE l_bdate          LIKE type_t.dat
DEFINE l_edate          LIKE type_t.dat
DEFINE l_isac008        LIKE isac_t.isac008
#DEFINE l_ooef011        LIKE ooef_t.ooef011 #161230-00036#1 mark
#160107-00004#1 add end---

#先撈出這張入庫單的收貨單號
#再撈出這張收貨單號的發票
#check這張發票有沒有存在isam_t
#沒有就寫入
   
   #這裡的r_success一律先給TRUE，因為這裡只是有發票就輔助帶入，若執行失敗不代表整體程式執行失敗
   LET r_success = TRUE
   
   SELECT pmds006 INTO l_receiveno
     FROM pmds_t
    WHERE pmdsent = g_enterprise
      AND pmdsdocno = p_docno
      AND pmdsstus = "S"
   IF SQLCA.SQLcode OR cl_null(l_receiveno) THEN
      #因為樣板是用SQLCA.SQLcode來判斷程式有沒有執行錯誤，這裡若錯誤會影響判斷，因此要給0
      LET SQLCA.SQLcode = 0  #150316
      RETURN r_success
   END IF
   
   SELECT pmdw001,pmdw002,pmdw008,pmdw009,pmdw010,
          pmdw011,pmdw012,pmdw0121,pmdw013,pmdw014,
          pmdw015,pmdw016,pmdw017,pmdw018,pmdw019,
          pmdw020,pmdw021,pmdw022,pmdw023,pmdw024,
          pmdw025,pmdw026,pmdw027,pmdw028,pmdw029,
          pmdw030,pmdw031,pmdw032,pmdw033,pmdw034,
          pmdw035,pmdw036,pmdw037,pmdw038,pmdw039,
          pmdw040,pmdw041,pmdw042,pmdw043,pmdw045,
          pmdw046,pmdw047,pmdw048,pmdw049,
          pmdw201,pmdw202,pmdw203,pmdw204,pmdw205,
          pmdw206,pmdw207
     INTO l_pmdw.pmdw001,l_pmdw.pmdw002,l_pmdw.pmdw008,l_pmdw.pmdw009,l_pmdw.pmdw010,
          l_pmdw.pmdw011,l_pmdw.pmdw012,l_pmdw.pmdw0121,l_pmdw.pmdw013,l_pmdw.pmdw014,
          l_pmdw.pmdw015,l_pmdw.pmdw016,l_pmdw.pmdw017,l_pmdw.pmdw018,l_pmdw.pmdw019,
          l_pmdw.pmdw020,l_pmdw.pmdw021,l_pmdw.pmdw022,l_pmdw.pmdw023,l_pmdw.pmdw024,
          l_pmdw.pmdw025,l_pmdw.pmdw026,l_pmdw.pmdw027,l_pmdw.pmdw028,l_pmdw.pmdw029,
          l_pmdw.pmdw030,l_pmdw.pmdw031,l_pmdw.pmdw032,l_pmdw.pmdw033,l_pmdw.pmdw034,
          l_pmdw.pmdw035,l_pmdw.pmdw036,l_pmdw.pmdw037,l_pmdw.pmdw038,l_pmdw.pmdw039,
          l_pmdw.pmdw040,l_pmdw.pmdw041,l_pmdw.pmdw042,l_pmdw.pmdw043,l_pmdw.pmdw045,
          l_pmdw.pmdw046,l_pmdw.pmdw047,l_pmdw.pmdw048,l_pmdw.pmdw049,
          l_pmdw.pmdw201,l_pmdw.pmdw202,l_pmdw.pmdw203,l_pmdw.pmdw204,l_pmdw.pmdw205,
          l_pmdw.pmdw206,l_pmdw.pmdw207
     FROM pmdw_t
    WHERE pmdwent = g_enterprise
      AND pmdwdocno = l_receiveno
   IF SQLCA.SQLcode OR cl_null(l_pmdw.pmdw010) THEN
      #因為樣板是用SQLCA.SQLcode來判斷程式有沒有執行錯誤，這裡若錯誤會影響判斷，因此要給0
      LET SQLCA.SQLcode = 0  #150316
      RETURN r_success
   END IF
   
   #160107-00004#1 mark ------
   #SELECT isai002 INTO g_isai002
   #  FROM ooef_t
   #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #160107-00004#1 mark end---
   LET l_cnt = 0
   #160107-00004#11 add ------
   #改抓專屬國家地區功能來判斷
   #161230-00036#1 mark ------
   #SELECT ooef011 INTO l_ooef011
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #
   #IF l_ooef011 <> "TW" THEN
   #161230-00036#1 mark end---
   IF g_ooef011 <> "TW" THEN  #161230-00036#1
      #抓取發票聯別
      SELECT isac008 INTO l_isac008
        FROM isac_t
        LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
       WHERE isacent = g_enterprise
         AND ooef001 = g_apbb_m.apbbcomp
         AND isac002 = l_pmdw.pmdw008
      IF l_isac008 = '4' THEN
         #廠商+發票號碼>>不可重覆
         LET l_sql = "SELECT COUNT(*)",
                     "  FROM isam_t",
                     " WHERE isament = ",g_enterprise,
                     "   AND isam008 = '",l_pmdw.pmdw008,"'",
                     "   AND isam010 = '",l_pmdw.pmdw010,"'",
                     "   AND isam036 IN ('11','11Y') ",
                     "   AND isamstus <> 'X' ",
                     "   AND isam002 = '",l_pmdw.pmdw002,"'"
         PREPARE isam_sel_tw_pb3 FROM l_sql
         EXECUTE isam_sel_tw_pb3 INTO l_cnt
      ELSE
         CALL s_date_get_ymtodate(YEAR(g_apbb_m.apbbdocdt),1,YEAR(g_apbb_m.apbbdocdt),12) RETURNING l_bdate,l_edate
         LET l_sql = "SELECT COUNT(*)",
                     "  FROM isam_t",
                     " WHERE isament = ",g_enterprise,
                     "   AND isam008 = '",l_pmdw.pmdw008,"'",
                     "   AND isam010 = '",l_pmdw.pmdw010,"'",
                     "   AND isam036 IN ('11','11Y') ",
                     "   AND isamstus <> 'X' ",
                     "   AND isam011 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
         PREPARE isam_sel_tw_pb4 FROM l_sql
         EXECUTE isam_sel_tw_pb4 INTO l_cnt
      END IF
   ELSE #China
      SELECT COUNT(*) INTO l_cnt
        FROM isam_t
       WHERE isament = g_enterprise
         AND isam036 IN ('11','11Y')
         AND isamstus <> 'X'
         AND isam009 = l_pmdw.pmdw009
         AND isam010 = l_pmdw.pmdw010
   END IF
   #160107-00004#1 add end---
   #160107-00004#1 mark ------
   #IF g_isai002 = "1" THEN
   #   SELECT COUNT(*) INTO l_cnt
   #     FROM isam_t,apbb_t
   #    WHERE isament = apbbent AND isamdocno = apbbdocno
   #      AND isament = g_enterprise
   #      AND apbbstus <> 'X'
   #      AND isam010 = l_pmdw.pmdw010
   #ELSE
   #   SELECT COUNT(*) INTO l_cnt
   #     FROM isam_t,apbb_t
   #    WHERE isament = apbbent AND isamdocno = apbbdocno
   #      AND isament = g_enterprise
   #      AND apbbstus <> 'X'
   #      AND isam009 = l_pmdw.pmdw009
   #      AND isam010 = l_pmdw.pmdw010
   #END IF
   #160107-00004#1 mark end---
   
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 0 THEN
      #項次
      SELECT MAX(isamseq)+1 INTO l_isamseq FROM isam_t
       WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
      IF cl_null(l_isamseq) OR l_isamseq = 0 THEN
         LET l_isamseq = 1
      END IF
      
      IF cl_null(l_pmdw.pmdw016) THEN LET l_pmdw.pmdw016 = g_apbb_m.apbb016 END IF
      IF cl_null(l_pmdw.pmdw017) THEN LET l_pmdw.pmdw017 = g_apbb_m.apbb017 END IF
      IF cl_null(l_pmdw.pmdw018) THEN LET l_pmdw.pmdw018 = g_apbb_m.apbb018 END IF
      IF cl_null(l_pmdw.pmdw019) THEN LET l_pmdw.pmdw019 = g_apbb_m.apbb019 END IF
      IF cl_null(l_pmdw.pmdw020) THEN LET l_pmdw.pmdw020 = g_apbb_m.apbb020 END IF
      IF cl_null(l_pmdw.pmdw021) THEN LET l_pmdw.pmdw021 = g_apbb_m.apbb021 END IF
      IF cl_null(l_pmdw.pmdw022) THEN LET l_pmdw.pmdw022 = '' END IF
      
      IF cl_null(l_pmdw.pmdw029) THEN LET l_pmdw.pmdw029 = g_apbb_m.apbb029 END IF
      IF cl_null(l_pmdw.pmdw030) THEN LET l_pmdw.pmdw030 = g_apbb_m.apbb030 END IF
      IF cl_null(l_pmdw.pmdw031) THEN LET l_pmdw.pmdw031 = g_apbb_m.apbb031 END IF
      IF cl_null(l_pmdw.pmdw032) THEN LET l_pmdw.pmdw032 = g_apbb_m.apbb032 END IF
      IF cl_null(l_pmdw.pmdw033) THEN LET l_pmdw.pmdw033 = g_apbb_m.apbb033 END IF
      IF cl_null(l_pmdw.pmdw034) THEN LET l_pmdw.pmdw034 = g_apbb_m.apbb034 END IF
      
      #150422-00026#1 add ------
      #重新計算本幣金額
      #規則：匯率=1則本幣=原幣，若<>1則call s_tax重算本幣
      IF l_pmdw.pmdw015 = 1 THEN
         LET l_pmdw.pmdw026 = l_pmdw.pmdw023
         LET l_pmdw.pmdw027 = l_pmdw.pmdw024
         LET l_pmdw.pmdw028 = l_pmdw.pmdw025
      ELSE
         IF g_apbb_m.apbb0121 = "Y" THEN
            CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_pmdw.pmdw025,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                 RETURNING l_pmdw.pmdw023,l_pmdw.pmdw024,l_pmdw.pmdw025,
                           l_pmdw.pmdw026,l_pmdw.pmdw027,l_pmdw.pmdw028
         ELSE
            CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_pmdw.pmdw023,1,g_apbb_m.apbb014,g_apbb_m.apbb015)
                 RETURNING l_pmdw.pmdw023,l_pmdw.pmdw024,l_pmdw.pmdw025,
                           l_pmdw.pmdw026,l_pmdw.pmdw027,l_pmdw.pmdw028
         END IF
      END IF
      #150422-00026#1 add end---

      INSERT INTO isam_t
            (isament,isamdocno,isamseq,isamstus,isamcomp,
             isam001,isam002,isam004,isam008,isam009,
             isam010,isam011,isam012,isam0121,isam013,
             isam014,isam015,isam016,isam017,isam018,
             isam019,isam020,isam021,isam022,isam023,
             isam024,isam025,isam026,isam027,isam028,
             isam029,isam030,isam031,isam032,isam033,
             isam034,isam035,isam036,isam037,isam038,
             isam039,isam040,isam041,isam042,isam043,
             isam044,isam045,isam046,isam047,isam048,
             isam049,isam050,
             isam107,isam108,isam117,isam118,isam200,
             isam201,isam202,isam203,isam204,isam205,
             isam206,isam207,isam208,isam209,isam210
            )
      VALUES(g_enterprise,g_apbb_m.apbbdocno,l_isamseq,'Y',g_apbb_m.apbbcomp,
             l_pmdw.pmdw001,l_pmdw.pmdw002,g_apbb_m.apbb004,l_pmdw.pmdw008,l_pmdw.pmdw009,
             l_pmdw.pmdw010,l_pmdw.pmdw011,l_pmdw.pmdw012,l_pmdw.pmdw0121,l_pmdw.pmdw013,
             l_pmdw.pmdw014,l_pmdw.pmdw015,l_pmdw.pmdw016,l_pmdw.pmdw017,l_pmdw.pmdw018,
             l_pmdw.pmdw019,l_pmdw.pmdw020,l_pmdw.pmdw021,l_pmdw.pmdw022,l_pmdw.pmdw023,
             l_pmdw.pmdw024,l_pmdw.pmdw025,l_pmdw.pmdw026,l_pmdw.pmdw027,l_pmdw.pmdw028,
             l_pmdw.pmdw029,l_pmdw.pmdw030,l_pmdw.pmdw031,l_pmdw.pmdw032,l_pmdw.pmdw033,
             l_pmdw.pmdw034,l_pmdw.pmdw035,l_pmdw.pmdw036,l_pmdw.pmdw037,l_pmdw.pmdw038,
             l_pmdw.pmdw039,l_pmdw.pmdw040,l_pmdw.pmdw041,l_pmdw.pmdw042,l_pmdw.pmdw043,
             0,l_pmdw.pmdw045,l_pmdw.pmdw046,l_pmdw.pmdw047,l_pmdw.pmdw048,
             l_pmdw.pmdw049,'',
             0,0,0,0,g_apbb_m.apbb200,
             l_pmdw.pmdw201,l_pmdw.pmdw202,l_pmdw.pmdw203,l_pmdw.pmdw204,l_pmdw.pmdw205,
             l_pmdw.pmdw206,l_pmdw.pmdw207,'','',''
             )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "INSERT isam_t wrong!"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF
   
   #因為樣板是用SQLCA.SQLcode來判斷程式有沒有執行錯誤，這裡若錯誤會影響判斷，因此要給0
   LET SQLCA.SQLcode = 0  #150316   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 若多發票明細無發票時新增一筆發票
# Memo...........:
# Usage..........: CALL aapt110_ins_isam()

# Date & Author..: 2015/01/27 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_ins_isam()
DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   INSERT INTO isam_t
         (isament,isamdocno,isamseq,isamstus,isamcomp,
          isam001,isam002,isam004,isam008,isam009,
          isam010,isam011,isam012,isam0121,isam013,
          isam014,isam015,isam016,isam017,isam018,
          isam019,isam020,isam021,isam022,isam023,
          isam024,isam025,isam026,isam027,isam028,
          isam029,isam030,isam031,isam032,isam033,
          isam034,isam035,isam036,isam037,isam038,
          isam039,isam040,isam041,isam042,isam043,
          isam044,isam045,isam046,isam047,isam048,
          isam049,isam050,
          isam107,isam108,isam117,isam118,isam200,
          isam201,isam202,isam203,isam204,isam205,
          isam206,isam207,isam208,isam209,isam210
         ) 
   VALUES(g_enterprise,g_apbb_m.apbbdocno,'1','Y',g_apbb_m.apbbcomp,
          'aapt110',g_apbb_m.apbb002,g_apbb_m.apbb004,g_apbb_m.apbb008,g_apbb_m.apbb009,
          g_apbb_m.apbb010,g_apbb_m.apbb011,g_apbb_m.apbb012,g_apbb_m.apbb0121,g_apbb_m.apbb013,
          g_apbb_m.apbb014,g_apbb_m.apbb015,g_apbb_m.apbb016,g_apbb_m.apbb017,g_apbb_m.apbb018,
          g_apbb_m.apbb019,g_apbb_m.apbb020,g_apbb_m.apbb021,'',g_apbb_m.apbb023,
          g_apbb_m.apbb024,g_apbb_m.apbb025,g_apbb_m.apbb026,g_apbb_m.apbb027,g_apbb_m.apbb028,
          g_apbb_m.apbb029,g_apbb_m.apbb030,g_apbb_m.apbb031,g_apbb_m.apbb032,g_apbb_m.apbb033,
          g_apbb_m.apbb034,'',g_apbb_m.apbb036,g_apbb_m.apbb037,g_apbb_m.apbb038,
          g_apbb_m.apbb039,g_apbb_m.apbb040,g_apbb_m.apbb041,g_apbb_m.apbb042,'',
          '','','','','',
         #g_apbb_m.apbb049,g_apbb_m.apbb050,       #150401-00001#32 mark   isam0050 是由aapt300回寫 並非為apbb050
          g_apbb_m.apbb049,'',                     #150401-00001#32 modify isam0050 是由aapt300回寫 並非為apbb050
          g_apbb_m.apbb107,g_apbb_m.apbb108,g_apbb_m.apbb117,g_apbb_m.apbb118,g_apbb_m.apbb200,
          '',g_apbb_m.apbb202,g_apbb_m.apbb203,g_apbb_m.apbb204,g_apbb_m.apbb205,
          g_apbb_m.apbb206,g_apbb_m.apbb207,g_apbb_m.apbb208,g_apbb_m.apbb209,g_apbb_m.apbb210
         )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT isam_t wrong!"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 金額差異處理 #150318-00010#1
# Memo...........:
# Usage..........: CALL aapt110_diff_recount_entrance()
# Date & Author..: 2015/03/30 By Reanna
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt110_diff_recount_entrance(p_type)
DEFINE p_type          LIKE type_t.chr1    #若不用作差異分攤是否要show訊息 Y要/N不要
DEFINE l_sum_apba103   LIKE apba_t.apba103
DEFINE l_sum_apba105   LIKE apba_t.apba105
DEFINE l_sum_isam023   LIKE isam_t.isam023
DEFINE l_sum_isam025   LIKE isam_t.isam025
DEFINE l_diff1         LIKE apba_t.apba105
DEFINE l_diff2         LIKE apba_t.apba105
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_type          LIKE type_t.chr5
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   
   #albireo 150711 mark-----s
#   #判斷部分搬入SUB
#   
#   #先判斷要不要作差異處理
#   #抓取來源單身總額
#   SELECT SUM(apba103*apba012),SUM(apba105*apba012)
#     INTO l_sum_apba103,l_sum_apba105
#     FROM apba_t
#    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
#   IF cl_null(l_sum_apba103) THEN LET l_sum_apba103 = 0 END IF
#   IF cl_null(l_sum_apba105) THEN LET l_sum_apba105 = 0 END IF
#   
#   #抓取發票單身總額
#   SELECT SUM(isam023),SUM(isam025)
#     INTO l_sum_isam023,l_sum_isam025
#     FROM isam_t
#    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
#   IF cl_null(l_sum_isam023) THEN LET l_sum_isam023 = 0 END IF
#   IF cl_null(l_sum_isam025) THEN LET l_sum_isam025 = 0 END IF
#   
#   #差異金額
#   LET l_diff1 = l_sum_isam023 - l_sum_apba103
#   LET l_diff2 = l_sum_isam025 - l_sum_apba105
#   IF cl_null(l_diff1) THEN LET l_diff1 = 0 END IF
#   IF cl_null(l_diff2) THEN LET l_diff2 = 0 END IF
#   
#   #若無key打發票則不用進行差異分攤
#   IF (g_apbb_m.apbb0121 = "N" AND l_diff1 = 0) OR (g_apbb_m.apbb0121 = "Y" AND l_diff2 = 0) OR
#      (l_sum_isam023 = 0 AND l_sum_isam025 = 0) THEN
   #albireo 150711 mark-----e
   
   #IF s_aapt110_diff_recount_entrance(g_apbb_m.apbbdocno) THEN    #albireo 150711 add  #151120-00006 mark
   IF s_aapp320_diff_recount_entrance(g_apbb_m.apbbdocno) THEN   #albireo 160130 151120-00006 add
      IF p_type = "Y" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00346'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      #150722 mark ------
      #ELSE
      #   LET r_success = FALSE
      #   RETURN r_success
      #150722 mark end------
      END IF
   ELSE
#      CALL s_transaction_begin()    #albireo 150711 mark
#      CALL cl_err_collect_init()    #albireo 150711 mark
      OPEN aapt110_cl USING g_enterprise,g_apbb_m.apbbdocno
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "OPEN aapt110_cl:" 
         LET g_errparam.code   = STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE aapt110_cl
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         LET r_success = FALSE
         RETURN r_success
      ELSE
         #金額差異處理>>選擇分攤方式
         CALL aapt110_09() RETURNING l_type
         
         IF cl_null(l_type) THEN
            #CALL s_transaction_end('N','0')    #albireo 150711 mark
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         CASE
            WHEN l_type = 'a' #發票明細輸入
               CALL aapt110_invoice_mod() RETURNING g_sub_success
            WHEN l_type = 'b' #差異分攤至單價(依金額比例)
               #CALL aapt110_diff_recount_b() RETURNING g_sub_success    #151120-00006#2 mark
               CALL s_aapp320_diff_recount_b(g_apbb_m.apbbdocno)RETURNING g_sub_success   #albireo 160130 #151120-00006#2
            WHEN l_type = 'c' #差異分攤至單價(依數量比例)
               #CALL aapt110_diff_recount_c() RETURNING g_sub_success   #151120-00006#2 mark
               CALL s_aapp320_diff_recount_c(g_apbb_m.apbbdocno)RETURNING g_sub_success   #albireo 160130 #151120-00006#2               
            WHEN l_type = 'd' #差異金額轉其他加減項
               CALL aapt110_diff_recount_d() RETURNING g_sub_success
            OTHERWISE
         END CASE
         
         IF NOT g_sub_success THEN
#            CALL cl_err_collect_show()    #albireo 150711 mark
#            CALL s_transaction_end('N','0')   #albireo 150711 mark
            LET r_success = FALSE
            RETURN r_success
         ELSE
#            CALL cl_err_collect_show()    #albireo 150711 mark
#            CALL s_transaction_end('Y','0')   #albireo 150711 mark
            LET r_success = TRUE
            
            #單身總筆數
            SELECT COUNT(*) INTO l_cnt FROM apba_t
             WHERE apbaent = g_enterprise
               AND apbadocno = g_apbb_m.apbbdocno
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            DISPLAY l_cnt TO FORMONLY.cnt
            
            #更新單身金額至單頭
            CALL aapt110_money_update_to_head("isam","Y")
            
            CALL aapt110_show()
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 差異分攤至單價(依金額比例) #150318-00010#1
# Memo...........:
# Usage..........: CALL aapt110_diff_recount_b()
#                  RETURNING 回传参数
# Date & Author..: 2015/03/30 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_diff_recount_b()
DEFINE l_sum_apba103    LIKE apba_t.apba103
DEFINE l_sum_apba1032   LIKE apba_t.apba103
DEFINE l_sum_apba105    LIKE apba_t.apba105
DEFINE l_sum_apba1052   LIKE apba_t.apba105
DEFINE l_sum_isam023    LIKE isam_t.isam023
DEFINE l_sum_isam025    LIKE isam_t.isam025
DEFINE l_diff1          LIKE apba_t.apba105
DEFINE l_diff2          LIKE apba_t.apba105
DEFINE l_apba           RECORD
             apbaseq       LIKE apba_t.apbaseq,
             apba010       LIKE apba_t.apba010,
             apba014       LIKE apba_t.apba014,
             apba103       LIKE apba_t.apba103,
             apba104       LIKE apba_t.apba104,
             apba105       LIKE apba_t.apba105,
             apba113       LIKE apba_t.apba113,
             apba114       LIKE apba_t.apba114,
             apba115       LIKE apba_t.apba115
                        END RECORD
DEFINE l_sql            STRING
DEFINE l_wc             STRING
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   
   #抓取來源單身總額
   SELECT SUM(apba103*apba012),SUM(apba105*apba012)
     INTO l_sum_apba103,l_sum_apba105
     FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
      AND (apba019 = 'Y' OR apba019 IS NULL) #160705-00035#1
   IF cl_null(l_sum_apba103) THEN LET l_sum_apba103 = 0 END IF
   IF cl_null(l_sum_apba105) THEN LET l_sum_apba105 = 0 END IF
   
   #抓取發票單身總額
   SELECT SUM(isam023),SUM(isam025)
     INTO l_sum_isam023,l_sum_isam025
     FROM isam_t
    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
   IF cl_null(l_sum_isam023) THEN LET l_sum_isam023 = 0 END IF
   IF cl_null(l_sum_isam025) THEN LET l_sum_isam025 = 0 END IF
   
   #差異金額
   LET l_diff1 = l_sum_isam023 - l_sum_apba103
   LET l_diff2 = l_sum_isam025 - l_sum_apba105
   IF cl_null(l_diff1) THEN LET l_diff1 = 0 END IF
   IF cl_null(l_diff2) THEN LET l_diff2 = 0 END IF

   #如果是藍字發票>>抓正項來分攤，紅字發票>>抓負項來分攤
   IF g_apbb_m.apbb050 = "1" THEN
      LET l_wc = " apba004 IN ('11','16','19')"
   ELSE
      LET l_wc = " apba004 IN ('20','21','26','29')"
   END IF
   
   #先計算等等要被分攤的類型的總額
   LET l_sql = "SELECT SUM(apba103*apba012),SUM(apba105*apba012)",
               "  FROM apba_t",
               " WHERE apbaent = ",g_enterprise," AND apbadocno = '",g_apbb_m.apbbdocno,"'",
               "   AND ",l_wc,                             #160705-00035#1 add ,
               "   AND (apba019 = 'Y' OR apba019 IS NULL)" #160705-00035#1
   PREPARE apba_pb_b FROM l_sql
   EXECUTE apba_pb_b INTO l_sum_apba1032,l_sum_apba1052
   IF cl_null(l_sum_apba1032) THEN LET l_sum_apba1032 = 0 END IF
   IF cl_null(l_sum_apba1052) THEN LET l_sum_apba1052 = 0 END IF
   
   #開始分攤到每一項次
   LET l_sql = "SELECT apbaseq,apba010,",
               "       apba103,apba105,apba113,apba115",
               "  FROM apba_t",
               " WHERE apbaent = ",g_enterprise,
               "   AND apbadocno = '",g_apbb_m.apbbdocno,"'",
               "   AND ",l_wc,                             #160705-00035#1 add ,
               "   AND (apba019 = 'Y' OR apba019 IS NULL)" #160705-00035#1
   PREPARE sel_apba_p2 FROM l_sql
   DECLARE sel_apba_c2 CURSOR FOR sel_apba_p2
   FOREACH sel_apba_c2 INTO l_apba.apbaseq,l_apba.apba010,
                            l_apba.apba103,l_apba.apba105,l_apba.apba113,l_apba.apba115
      #含稅時
      IF g_apbb_m.apbb0121 = "Y" THEN
         #含稅金額＋(差異數＊每筆金額佔比比率)
         LET l_apba.apba105 = l_apba.apba105 + (l_diff2 * l_apba.apba105 / l_sum_apba1052)
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba105,2) RETURNING g_sub_success,g_errno,l_apba.apba105
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba105,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba105 / l_apba.apba010
      ELSE
         #未稅金額＋(差異數＊每筆金額佔比比率)
         LET l_apba.apba103 = l_apba.apba103 + (l_diff1 * l_apba.apba103 / l_sum_apba1032)
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba103,2) RETURNING g_sub_success,g_errno,l_apba.apba103
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba103,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba103 / l_apba.apba010
      END IF
      #單價取位
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
      
      UPDATE apba_t SET (apba014,apba103,apba104,apba105,
                         apba113,apba114,apba115
                        ) = (
                         l_apba.apba014,l_apba.apba103,l_apba.apba104,l_apba.apba105,
                         l_apba.apba113,l_apba.apba114,l_apba.apba115
                        )
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno AND apbaseq = l_apba.apbaseq
      
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         OTHERWISE
      END CASE
   END FOREACH
   
   #調尾差
   CALL aapt110_diff_recount_bal("1") RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 差異分攤至單價(依數量比例) #150318-00010#1
# Memo...........:
# Usage..........: CALL aapt110_diff_recount_c()
#                  RETURNING 回传参数
# Date & Author..: 2015/03/30 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_diff_recount_c()
DEFINE l_sum_apba103    LIKE apba_t.apba103
DEFINE l_sum_apba105    LIKE apba_t.apba105
DEFINE l_sum_apba010    LIKE apba_t.apba010
DEFINE l_sum_apba0102   LIKE apba_t.apba010
DEFINE l_sum_isam023    LIKE isam_t.isam023
DEFINE l_sum_isam025    LIKE isam_t.isam025
DEFINE l_diff1          LIKE apba_t.apba105
DEFINE l_diff2          LIKE apba_t.apba105
DEFINE l_apba           RECORD
             apbaseq       LIKE apba_t.apbaseq,
             apba010       LIKE apba_t.apba010,
             apba014       LIKE apba_t.apba014,
             apba103       LIKE apba_t.apba103,
             apba104       LIKE apba_t.apba104,
             apba105       LIKE apba_t.apba105,
             apba113       LIKE apba_t.apba113,
             apba114       LIKE apba_t.apba114,
             apba115       LIKE apba_t.apba115
                        END RECORD
DEFINE l_sql            STRING
DEFINE l_wc             STRING
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   #抓取來源單身總額&數量
   SELECT SUM(apba103*apba012),SUM(apba105*apba012),SUM(apba010)
     INTO l_sum_apba103,l_sum_apba105,l_sum_apba010
     FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
      AND (apba019 = 'Y' OR apba019 IS NULL) #160705-00035#1
   IF cl_null(l_sum_apba103) THEN LET l_sum_apba103 = 0 END IF
   IF cl_null(l_sum_apba105) THEN LET l_sum_apba105 = 0 END IF
   IF cl_null(l_sum_apba010) THEN LET l_sum_apba010 = 0 END IF
   
   #抓取發票單身總額
   SELECT SUM(isam023),SUM(isam025)
     INTO l_sum_isam023,l_sum_isam025
     FROM isam_t
    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
   IF cl_null(l_sum_isam023) THEN LET l_sum_isam023 = 0 END IF
   IF cl_null(l_sum_isam025) THEN LET l_sum_isam025 = 0 END IF
   
   #差異金額
   LET l_diff1 = l_sum_isam023 - l_sum_apba103
   LET l_diff2 = l_sum_isam025 - l_sum_apba105
   IF cl_null(l_diff1) THEN LET l_diff1 = 0 END IF
   IF cl_null(l_diff2) THEN LET l_diff2 = 0 END IF
   
   #如果是藍字發票>>抓正項來分攤，紅字發票>>抓負項來分攤
   IF g_apbb_m.apbb050 = "1" THEN
      LET l_wc = " apba004 IN ('11','16','19')"
   ELSE
      LET l_wc = " apba004 IN ('20','21','26','29')"
   END IF
   
   #先計算等等要被分攤的類型的數量
   LET l_sql = "SELECT SUM(apba010)",
               "  FROM apba_t",
               " WHERE apbaent = ",g_enterprise," AND apbadocno = '",g_apbb_m.apbbdocno,"'",
               "   AND ",l_wc,                             #160705-00035#1 add ,
               "   AND (apba019 = 'Y' OR apba019 IS NULL)" #160705-00035#1
   PREPARE apba_pb_c FROM l_sql
   EXECUTE apba_pb_c INTO l_sum_apba0102
   IF cl_null(l_sum_apba0102) THEN LET l_sum_apba0102 = 0 END IF
   
   #開始分攤到每一項次
   LET l_sql = "SELECT apbaseq,apba010,",
               "       apba103,apba105,apba113,apba115",
               "  FROM apba_t",
               " WHERE apbaent = ",g_enterprise,
               "   AND apbadocno = '",g_apbb_m.apbbdocno,"'",
               "   AND ",l_wc,                             #160705-00035#1 add ,
               "   AND (apba019 = 'Y' OR apba019 IS NULL)" #160705-00035#1
   PREPARE sel_apba_p3 FROM l_sql
   DECLARE sel_apba_c3 CURSOR FOR sel_apba_p3
   FOREACH sel_apba_c3 INTO l_apba.apbaseq,l_apba.apba010,
                            l_apba.apba103,l_apba.apba105,l_apba.apba113,l_apba.apba115
      #含稅時
      IF g_apbb_m.apbb0121 = "Y" THEN
         #含稅金額＋(差異數＊每筆數量佔比比率)
         LET l_apba.apba105 = l_apba.apba105 + (l_diff2 * l_apba.apba010 / l_sum_apba0102)
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba105,2) RETURNING g_sub_success,g_errno,l_apba.apba105
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba105,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba105 / l_apba.apba010
      ELSE
         #未稅金額＋(差異數＊每筆數量佔比比率)
         LET l_apba.apba103 = l_apba.apba103 + (l_diff1 * l_apba.apba010 / l_sum_apba0102)
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba103,2) RETURNING g_sub_success,g_errno,l_apba.apba103
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba103,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba103 / l_apba.apba010
      END IF
      #單價取位
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014

      UPDATE apba_t SET (apba014,apba103,apba104,apba105,
                         apba113,apba114,apba115
                        ) = (
                         l_apba.apba014,l_apba.apba103,l_apba.apba104,l_apba.apba105,
                         l_apba.apba113,l_apba.apba114,l_apba.apba115
                        )
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno AND apbaseq = l_apba.apbaseq
      
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         OTHERWISE
      END CASE
   END FOREACH
   
   #調尾差
   CALL aapt110_diff_recount_bal("2") RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 差異金額轉其他加減項 #150318-00010#1
# Memo...........:
# Usage..........: CALL aapt110_diff_recount_d()
# Date & Author..: 2015/03/30 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_diff_recount_d()
DEFINE l_sum_apba103    LIKE apba_t.apba103
DEFINE l_sum_apba104    LIKE apba_t.apba104
DEFINE l_sum_apba105    LIKE apba_t.apba105
DEFINE l_sum_apba113    LIKE apba_t.apba113
DEFINE l_sum_apba114    LIKE apba_t.apba114
DEFINE l_sum_apba115    LIKE apba_t.apba115
DEFINE l_sum_isam023    LIKE isam_t.isam023
DEFINE l_sum_isam024    LIKE isam_t.isam024
DEFINE l_sum_isam025    LIKE isam_t.isam025
DEFINE l_sum_isam026    LIKE isam_t.isam026
DEFINE l_sum_isam027    LIKE isam_t.isam027
DEFINE l_sum_isam028    LIKE isam_t.isam028
DEFINE l_apba           RECORD
          apbaseq          LIKE apba_t.apbaseq,
          apba004          LIKE apba_t.apba004,
          apba005          LIKE apba_t.apba005,     #20150626 add lujh
          apba006          LIKE apba_t.apba006,     #20150626 add lujh
          apba012          LIKE apba_t.apba012,
          apba014          LIKE apba_t.apba014,
          apba103          LIKE apba_t.apba103,
          apba104          LIKE apba_t.apba104,
          apba105          LIKE apba_t.apba105,
          apba113          LIKE apba_t.apba113,
          apba114          LIKE apba_t.apba114,
          apba115          LIKE apba_t.apba115
                        END RECORD
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   #抓取來源單身總額
   SELECT SUM(apba103*apba012),SUM(apba104*apba012),SUM(apba105*apba012),
          SUM(apba113*apba012),SUM(apba114*apba012),SUM(apba115*apba012)
     INTO l_sum_apba103,l_sum_apba104,l_sum_apba105,
          l_sum_apba113,l_sum_apba114,l_sum_apba115
     FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
      AND (apba019 = 'Y' OR apba019 IS NULL) #160705-00035#1
   IF cl_null(l_sum_apba103) THEN LET l_sum_apba103 = 0 END IF
   IF cl_null(l_sum_apba104) THEN LET l_sum_apba104 = 0 END IF
   IF cl_null(l_sum_apba105) THEN LET l_sum_apba105 = 0 END IF
   IF cl_null(l_sum_apba113) THEN LET l_sum_apba113 = 0 END IF
   IF cl_null(l_sum_apba114) THEN LET l_sum_apba114 = 0 END IF
   IF cl_null(l_sum_apba115) THEN LET l_sum_apba115 = 0 END IF
   
   #抓取發票單身總額
   SELECT SUM(isam023),SUM(isam024),SUM(isam025),SUM(isam026),SUM(isam027),SUM(isam028)
     INTO l_sum_isam023,l_sum_isam024,l_sum_isam025,l_sum_isam026,l_sum_isam027,l_sum_isam028
     FROM isam_t
    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
   IF cl_null(l_sum_isam023) THEN LET l_sum_isam023 = 0 END IF
   IF cl_null(l_sum_isam024) THEN LET l_sum_isam024 = 0 END IF
   IF cl_null(l_sum_isam025) THEN LET l_sum_isam025 = 0 END IF
   IF cl_null(l_sum_isam026) THEN LET l_sum_isam026 = 0 END IF
   IF cl_null(l_sum_isam027) THEN LET l_sum_isam027 = 0 END IF
   IF cl_null(l_sum_isam028) THEN LET l_sum_isam028 = 0 END IF
   
   #170124-00007#1 mark-----s
  #IF l_sum_apba105 > l_sum_isam025 OR l_sum_apba115 > l_sum_isam028 THEN #161017-00024#1 mark
   #IF l_sum_apba103 > l_sum_isam023 OR l_sum_apba105 > l_sum_isam025 OR   #161017-00024#1
   #   l_sum_apba113 > l_sum_isam026 OR l_sum_apba115 > l_sum_isam028 THEN #161017-00024#1
   #   #來源>發票 >> 產生29.減項
   #   LET l_apba.apba004 = '29'
   #   LET l_apba.apba012 = -1
   #ELSE
   #   #來源<發票 >> 產生19.加項
   #   LET l_apba.apba004 = '19'
   #   LET l_apba.apba012 = 1
   #END IF
   #170124-00007#1 mark-----e
   #170124-00007#1-----s
   IF l_sum_apba105 > l_sum_isam025 OR l_sum_apba115 > l_sum_isam028 THEN 
      #來源>發票 >> 產生29.減項
      LET l_apba.apba004 = '29'
      LET l_apba.apba012 = -1
   ELSE
      #來源<發票 >> 產生19.加項
      LET l_apba.apba004 = '19'
      LET l_apba.apba012 = 1
   END IF   
   #170124-00007#1-----e
   
   #取得差異的金額
   LET l_apba.apba103 = s_math_abs(l_sum_apba103 - l_sum_isam023)
   LET l_apba.apba104 = s_math_abs(l_sum_apba104 - l_sum_isam024)
   LET l_apba.apba105 = s_math_abs(l_sum_apba105 - l_sum_isam025)
   LET l_apba.apba113 = s_math_abs(l_sum_apba113 - l_sum_isam026)
   LET l_apba.apba114 = s_math_abs(l_sum_apba114 - l_sum_isam027)
   LET l_apba.apba115 = s_math_abs(l_sum_apba115 - l_sum_isam028)
   IF cl_null(l_apba.apba103) THEN LET l_apba.apba103 = 0 END IF
   IF cl_null(l_apba.apba104) THEN LET l_apba.apba104 = 0 END IF
   IF cl_null(l_apba.apba105) THEN LET l_apba.apba105 = 0 END IF
   IF cl_null(l_apba.apba113) THEN LET l_apba.apba113 = 0 END IF
   IF cl_null(l_apba.apba114) THEN LET l_apba.apba114 = 0 END IF
   IF cl_null(l_apba.apba115) THEN LET l_apba.apba115 = 0 END IF
   
   #170124-00007#1 mark-----s
   ##161103-00034#1---add---str--
   #IF l_sum_apba104 < l_sum_isam024 THEN
   #   LET l_apba.apba104 = l_apba.apba104 * -1
   #END IF
   #IF l_sum_apba114 < l_sum_isam027 THEN
   #   LET l_apba.apba114 = l_apba.apba114 * -1
   #END IF
   ##161103-00034#1---add---end--
   #170124-00007#1 mark-----e
   #170124-00007#1-----s
   IF l_apba.apba004 = '29' THEN
      IF l_sum_apba103 < l_sum_isam023 THEN
         LET l_apba.apba103 = l_apba.apba103 * -1
      END IF
      IF l_sum_apba113 < l_sum_isam026 THEN
         LET l_apba.apba113 = l_apba.apba113 * -1
      END IF
      IF l_sum_apba104 < l_sum_isam024 THEN
         LET l_apba.apba104 = l_apba.apba104 * -1
      END IF
      IF l_sum_apba114 < l_sum_isam027 THEN
         LET l_apba.apba114 = l_apba.apba114 * -1
      END IF
      IF l_sum_apba105 < l_sum_isam025 THEN
         LET l_apba.apba105 = l_apba.apba105 * -1
      END IF
      IF l_sum_apba115 < l_sum_isam028 THEN
         LET l_apba.apba115 = l_apba.apba115 * -1
      END IF            
   ELSE
      IF l_sum_apba103 > l_sum_isam023 THEN
         LET l_apba.apba103 = l_apba.apba103 * -1
      END IF
      IF l_sum_apba113 > l_sum_isam026 THEN
         LET l_apba.apba113 = l_apba.apba113 * -1
      END IF
      IF l_sum_apba104 > l_sum_isam024 THEN
         LET l_apba.apba104 = l_apba.apba104 * -1
      END IF
      IF l_sum_apba114 > l_sum_isam027 THEN
         LET l_apba.apba114 = l_apba.apba114 * -1
      END IF
      IF l_sum_apba105 > l_sum_isam025 THEN
         LET l_apba.apba105 = l_apba.apba105 * -1
      END IF
      IF l_sum_apba115 > l_sum_isam028 THEN
         LET l_apba.apba115 = l_apba.apba115 * -1
      END IF
   END IF
   #170124-00007#1-----e
   
   #單價
   IF g_apbb_m.apbb0121 = "Y" THEN
      LET l_apba.apba014 = l_apba.apba105
   ELSE
      #LET l_apba.apba014 = l_apba.apba103   #161013-00019#1 mark
      #161013-00019#1---add---str--
      IF l_apba.apba103 > 0 THEN
         LET l_apba.apba014 = l_apba.apba103
      ELSE
         LET l_apba.apba014 = l_apba.apba104
      END IF
      #161013-00019#1---add---end--
   END IF
   CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
   
   #項次
   SELECT MAX(apbaseq)+1 INTO l_apba.apbaseq FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
   IF cl_null(l_apba.apbaseq) OR l_apba.apbaseq = 0 THEN
      LET l_apba.apbaseq = 1
   END IF
   
   #20150626--add--str--lujh
   LET l_apba.apba005 = g_apbb_m.apbbdocno
   LET l_apba.apba006 = l_apba.apbaseq
   #20150626--add--end--lujh

   INSERT INTO apba_t(apbaent,apbadocno,apbaseq,apbaorga,apba004,
                      apba005,apba006,                             #20150626 add lujh
                      apba010,apba012,apba014,apba015,apba111,
                      apba103,apba105,apba104,
                      apba113,apba115,apba114,
                      apba100)   #20150603 add apba100 lujh
               VALUES(g_enterprise,g_apbb_m.apbbdocno,l_apba.apbaseq,g_apbb_m.apbb004,l_apba.apba004,
                      l_apba.apba005,l_apba.apba006,               #20150626 add lujh
                      1,l_apba.apba012,l_apba.apba014,g_apbb_m.apbb012,g_apbb_m.apbb015,
                      l_apba.apba103,l_apba.apba105,l_apba.apba104,
                      l_apba.apba113,l_apba.apba115,l_apba.apba114,
                      g_apbb_m.apbb014)   #20150603 add g_apbb_m.apbb014 lujh
   IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins apba_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 尾差處理
# Memo...........:
# Usage..........: CALL aapt110_diff_recount_bal(p_type)
#                  p_type  分攤類型1:金額2:數量
# Date & Author..: 2015/03/31 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_diff_recount_bal(p_type)
DEFINE p_type           LIKE type_t.chr1
DEFINE l_sum_apba103    LIKE apba_t.apba103
DEFINE l_sum_apba105    LIKE apba_t.apba105
DEFINE l_sum_isam023    LIKE isam_t.isam023
DEFINE l_sum_isam025    LIKE isam_t.isam025
DEFINE l_diff1          LIKE apba_t.apba105
DEFINE l_diff2          LIKE apba_t.apba105
DEFINE l_apba           RECORD
          apbaseq          LIKE apba_t.apbaseq,
          apba010          LIKE apba_t.apba010,
          apba014          LIKE apba_t.apba014,
          apba103          LIKE apba_t.apba103,
          apba104          LIKE apba_t.apba104,
          apba105          LIKE apba_t.apba105,
          apba113          LIKE apba_t.apba113,
          apba114          LIKE apba_t.apba114,
          apba115          LIKE apba_t.apba115
                        END RECORD
DEFINE l_sql            STRING
DEFINE l_wc             STRING
DEFINE r_success        LIKE type_t.num5

#先判斷有沒有平
#沒平在抓要調整的那一筆seq是多少
#在UPDATE尾差金額到那一筆去

   LET r_success = TRUE
   
   #抓取來源單身總額
   SELECT SUM(apba103*apba012),SUM(apba105*apba012)
     INTO l_sum_apba103,l_sum_apba105
     FROM apba_t
    WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
      AND (apba019 = 'Y' OR apba019 IS NULL) #160705-00035#1
   IF cl_null(l_sum_apba103) THEN LET l_sum_apba103 = 0 END IF
   IF cl_null(l_sum_apba105) THEN LET l_sum_apba105 = 0 END IF
   
   #抓取發票單身總額
   SELECT SUM(isam023),SUM(isam025)
     INTO l_sum_isam023,l_sum_isam025
     FROM isam_t
    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
   IF cl_null(l_sum_isam023) THEN LET l_sum_isam023 = 0 END IF
   IF cl_null(l_sum_isam025) THEN LET l_sum_isam025 = 0 END IF
   
   #差異金額
   LET l_diff1 = l_sum_isam023 - l_sum_apba103
   LET l_diff2 = l_sum_isam025 - l_sum_apba105
   IF cl_null(l_diff1) THEN LET l_diff1 = 0 END IF
   IF cl_null(l_diff2) THEN LET l_diff2 = 0 END IF
   
   
   IF (g_apbb_m.apbb0121 = "N" AND l_diff1 = 0) OR (g_apbb_m.apbb0121 = "Y" AND l_diff2 = 0) THEN
      RETURN r_success
   ELSE
      #如果是藍字發票>>抓正項來分攤，紅字發票>>抓負項來分攤
      IF g_apbb_m.apbb050 = "1" THEN
         LET l_wc = " apba004 IN ('11','16','19')"
      ELSE
         LET l_wc = " apba004 IN ('20','21','26','29')"
      END IF
      #取最大(金額or數量)的項次
      CASE
         WHEN p_type = "1" #金額
            LET l_sql = "SELECT apbaseq,apba010,apba103,apba105",
                        "  FROM apba_t",
                        " WHERE apbaent = ",g_enterprise," AND apbadocno = '",g_apbb_m.apbbdocno,"'",
                        "   AND apba105 IN (SELECT MAX(apba105)",
                        "                     FROM apba_t",
                        "                    WHERE apbaent = ",g_enterprise,
                       #"                      AND apbadocno = '",g_apbb_m.apbbdocno,"' AND ",l_wc,")" #160705-00035#1 mark
                        "                      AND apbadocno = '",g_apbb_m.apbbdocno,"' AND ",l_wc,  #160705-00035#1
                        "                      AND (apba019 = 'Y' OR apba019 IS NULL))"              #160705-00035#1
         WHEN p_type = "2" #數量
            LET l_sql = "SELECT apbaseq,apba010,apba103,apba105",
                        "  FROM apba_t",
                        " WHERE apbaent = ",g_enterprise," AND apbadocno = '",g_apbb_m.apbbdocno,"'",
                        "   AND apba010 IN (SELECT MAX(apba010)",
                        "                     FROM apba_t",
                        "                    WHERE apbaent = ",g_enterprise,
                       #"                      AND apbadocno = '",g_apbb_m.apbbdocno,"' AND ",l_wc,")" #160705-00035#1 mark
                        "                      AND apbadocno = '",g_apbb_m.apbbdocno,"' AND ",l_wc,  #160705-00035#1
                        "                      AND (apba019 = 'Y' OR apba019 IS NULL))"              #160705-00035#1
      END CASE
      PREPARE apba_pb_bal FROM l_sql
      EXECUTE apba_pb_bal INTO l_apba.apbaseq,l_apba.apba010,l_apba.apba103,l_apba.apba105
      
      #含稅時
      IF g_apbb_m.apbb0121 = "Y" THEN
         #含稅金額＋尾差
         LET l_apba.apba105 = l_apba.apba105 + l_diff2
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba105,2) RETURNING g_sub_success,g_errno,l_apba.apba105
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba105,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba105 / l_apba.apba010
      ELSE
         #未稅金額＋尾差
         LET l_apba.apba103 = l_apba.apba103 + l_diff1
         CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba103,2) RETURNING g_sub_success,g_errno,l_apba.apba103
         #重新計算金額
         CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_apba.apba103,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015)
         RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                   l_apba.apba113,l_apba.apba114,l_apba.apba115
         LET l_apba.apba014 = l_apba.apba103 / l_apba.apba010
      END IF
      #單價取位
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
      
      UPDATE apba_t SET (apba014,apba103,apba104,apba105,
                         apba113,apba114,apba115
                        ) = (
                         l_apba.apba014,l_apba.apba103,l_apba.apba104,l_apba.apba105,
                         l_apba.apba113,l_apba.apba114,l_apba.apba115
                        )
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno AND apbaseq = l_apba.apbaseq
      
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "apba_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         OTHERWISE
      END CASE

   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 开窗批量产生单身--流通
# Memo...........:
# Usage..........: CALL aapt110_qbevalue_ins_apba(p_orga,p_source)

# Date & Author..: 2015/06/01 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_qbevalue_ins_apba_1(p_orga,p_source)
DEFINE p_orga           LIKE apba_t.apbaorga
DEFINE p_source         LIKE apba_t.apba004
#DEFINE l_apba           RECORD LIKE apba_t.*#161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_apba RECORD  #進項發票明細檔
       apbaent   LIKE apba_t.apbaent, #企業編號
       apbadocno LIKE apba_t.apbadocno, #檔案號碼
       apbaorga  LIKE apba_t.apbaorga, #帳務歸屬組織
       apba001   LIKE apba_t.apba001, #發票類型
       apba002   LIKE apba_t.apba002, #發票編號
       apba003   LIKE apba_t.apba003, #發票號碼
       apbaseq   LIKE apba_t.apbaseq, #項次
       apba004   LIKE apba_t.apba004, #來源作業
       apba005   LIKE apba_t.apba005, #業務單號碼
       apba006   LIKE apba_t.apba006, #業務單項次
       apba007   LIKE apba_t.apba007, #產品編號
       apba008   LIKE apba_t.apba008, #品名規格
       apba009   LIKE apba_t.apba009, #單位
       apba010   LIKE apba_t.apba010, #發票數量
       apba011   LIKE apba_t.apba011, #暫估帳款數量
       apba012   LIKE apba_t.apba012, #正負值
       apba013   LIKE apba_t.apba013, #參考單號
       apba014   LIKE apba_t.apba014, #單價
       apba015   LIKE apba_t.apba015, #稅別
       apba016   LIKE apba_t.apba016, #扣抵發票編號
       apba017   LIKE apba_t.apba017, #扣抵藍字發票號碼
       apba100   LIKE apba_t.apba100, #交易原幣
       apba103   LIKE apba_t.apba103, #原幣未稅金額
       apba104   LIKE apba_t.apba104, #原幣稅額
       apba105   LIKE apba_t.apba105, #原幣含稅總額
       apba111   LIKE apba_t.apba111, #發票匯率
       apba113   LIKE apba_t.apba113, #發票幣未稅金額
       apba114   LIKE apba_t.apba114, #發票幣稅額
       apba115   LIKE apba_t.apba115, #發票幣含稅總額
       apbaud001 LIKE apba_t.apbaud001, #自定義欄位(文字)001
       apbaud002 LIKE apba_t.apbaud002, #自定義欄位(文字)002
       apbaud003 LIKE apba_t.apbaud003, #自定義欄位(文字)003
       apbaud004 LIKE apba_t.apbaud004, #自定義欄位(文字)004
       apbaud005 LIKE apba_t.apbaud005, #自定義欄位(文字)005
       apbaud006 LIKE apba_t.apbaud006, #自定義欄位(文字)006
       apbaud007 LIKE apba_t.apbaud007, #自定義欄位(文字)007
       apbaud008 LIKE apba_t.apbaud008, #自定義欄位(文字)008
       apbaud009 LIKE apba_t.apbaud009, #自定義欄位(文字)009
       apbaud010 LIKE apba_t.apbaud010, #自定義欄位(文字)010
       apbaud011 LIKE apba_t.apbaud011, #自定義欄位(數字)011
       apbaud012 LIKE apba_t.apbaud012, #自定義欄位(數字)012
       apbaud013 LIKE apba_t.apbaud013, #自定義欄位(數字)013
       apbaud014 LIKE apba_t.apbaud014, #自定義欄位(數字)014
       apbaud015 LIKE apba_t.apbaud015, #自定義欄位(數字)015
       apbaud016 LIKE apba_t.apbaud016, #自定義欄位(數字)016
       apbaud017 LIKE apba_t.apbaud017, #自定義欄位(數字)017
       apbaud018 LIKE apba_t.apbaud018, #自定義欄位(數字)018
       apbaud019 LIKE apba_t.apbaud019, #自定義欄位(數字)019
       apbaud020 LIKE apba_t.apbaud020, #自定義欄位(數字)020
       apbaud021 LIKE apba_t.apbaud021, #自定義欄位(日期時間)021
       apbaud022 LIKE apba_t.apbaud022, #自定義欄位(日期時間)022
       apbaud023 LIKE apba_t.apbaud023, #自定義欄位(日期時間)023
       apbaud024 LIKE apba_t.apbaud024, #自定義欄位(日期時間)024
       apbaud025 LIKE apba_t.apbaud025, #自定義欄位(日期時間)025
       apbaud026 LIKE apba_t.apbaud026, #自定義欄位(日期時間)026
       apbaud027 LIKE apba_t.apbaud027, #自定義欄位(日期時間)027
       apbaud028 LIKE apba_t.apbaud028, #自定義欄位(日期時間)028
       apbaud029 LIKE apba_t.apbaud029, #自定義欄位(日期時間)029
       apbaud030 LIKE apba_t.apbaud030, #自定義欄位(日期時間)030
       apba018   LIKE apba_t.apba018, #本次開票金額
       apba019   LIKE apba_t.apba019, #預付已開發票
       apba020   LIKE apba_t.apba020 #期別
          END RECORD
#161104-00024#1-add(e)
DEFINE l_sql            STRING
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   IF cl_null(g_apba_d_t.apba005) THEN 
      SELECT MAX(apbaseq) INTO l_apba.apbaseq
        FROM apba_t
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno
      IF cl_null(l_apba.apbaseq) THEN
         LET l_apba.apbaseq = 1
      ELSE
         LET l_apba.apbaseq = l_apba.apbaseq + 1
      END IF
   ELSE
      LET l_apba.apbaseq = g_apba_d_t.apbaseq
   END IF
   
   LET l_apba.apbaent = g_enterprise
   LET l_apba.apbadocno = g_apbb_m.apbbdocno
   LET l_apba.apbaorga = p_orga
   LET l_apba.apba004 = p_source
   LET l_apba.apba111 = g_apbb_m.apbb015
   
   LET l_sql = "SELECT stbe002,stbe003,stbedocno,stbe008,stbe009,",
               "       stbe027,stbe026,stbe011 " ,
               "  FROM stbe_t ",
               " WHERE stbeent = ",g_enterprise,
               "   AND (",g_qryparam.return1,")",
               " ORDER BY stbedocno,stbeseq "
   PREPARE aapt110_stbe_pre FROM l_sql
   DECLARE aapt110_stbe_cs CURSOR FOR aapt110_stbe_pre
   FOREACH aapt110_stbe_cs INTO l_apba.apba005,l_apba.apba006,l_apba.apba013,l_apba.apba100,l_apba.apba015,
                                l_apba.apba014,l_apba.apba010,l_apba.apba012
      SELECT pmdt006,pmdt023
        INTO l_apba.apba007,l_apba.apba009
        FROM pmdt_t
       WHERE pmdtent = g_enterprise AND pmdtdocno = l_apba.apba005 AND pmdtseq = l_apba.apba006 
       
      #20150629--add--str--lujh
      IF p_source = '12' THEN 
         LET l_apba.apba012 = l_apba.apba012 * -1
      END IF
      #20150629--add--end--lujh
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_apba.apba007
#160602-00023#1---begin
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      CALL ap_ref_array2(g_ref_fields,"SELECT (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||(CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||(CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END) FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#160602-00023#1---end 
      LET l_apba.apba008 = '', g_rtn_fields[1] , ''
      
      #單價取位
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
      #重新計算金額
      #160802-00049#1-s
      LET l_money = l_apba.apba014*l_apba.apba010
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
      #160802-00049#1-e
     #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
      CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
      RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105
               ,l_apba.apba113,l_apba.apba114,l_apba.apba115
      
      #INSERT INTO apba_t VALUES(l_apba.*)  #161108-00017#3 mark
      #161108-00017#3 add ------
      INSERT INTO apba_t (apbaent,apbadocno,apbaorga,
                          apba001,apba002,apba003,apbaseq,apba004,apba005,
                          apba006,apba007,apba008,apba009,apba010,
                          apba011,apba012,apba013,apba014,apba015,
                          apba016,apba017,apba100,apba103,apba104,
                          apba105,apba111,apba113,apba114,apba115,
                          apbaud001,apbaud002,apbaud003,apbaud004,apbaud005,
                          apbaud006,apbaud007,apbaud008,apbaud009,apbaud010,
                          apbaud011,apbaud012,apbaud013,apbaud014,apbaud015,
                          apbaud016,apbaud017,apbaud018,apbaud019,apbaud020,
                          apbaud021,apbaud022,apbaud023,apbaud024,apbaud025,
                          apbaud026,apbaud027,apbaud028,apbaud029,apbaud030,
                          apba018,apba019,apba020
                         )
      VALUES (l_apba.apbaent,l_apba.apbadocno,l_apba.apbaorga,
              l_apba.apba001,l_apba.apba002,l_apba.apba003,l_apba.apbaseq,l_apba.apba004,l_apba.apba005,
              l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba009,l_apba.apba010,
              l_apba.apba011,l_apba.apba012,l_apba.apba013,l_apba.apba014,l_apba.apba015,
              l_apba.apba016,l_apba.apba017,l_apba.apba100,l_apba.apba103,l_apba.apba104,
              l_apba.apba105,l_apba.apba111,l_apba.apba113,l_apba.apba114,l_apba.apba115,
              l_apba.apbaud001,l_apba.apbaud002,l_apba.apbaud003,l_apba.apbaud004,l_apba.apbaud005,
              l_apba.apbaud006,l_apba.apbaud007,l_apba.apbaud008,l_apba.apbaud009,l_apba.apbaud010,
              l_apba.apbaud011,l_apba.apbaud012,l_apba.apbaud013,l_apba.apbaud014,l_apba.apbaud015,
              l_apba.apbaud016,l_apba.apbaud017,l_apba.apbaud018,l_apba.apbaud019,l_apba.apbaud020,
              l_apba.apbaud021,l_apba.apbaud022,l_apba.apbaud023,l_apba.apbaud024,l_apba.apbaud025,
              l_apba.apbaud026,l_apba.apbaud027,l_apba.apbaud028,l_apba.apbaud029,l_apba.apbaud030,
              l_apba.apba018,l_apba.apba019,l_apba.apba020
             )
      #161108-00017#3 add end---
      IF SQLCA.sqlcode THEN
         LET g_success = 'N' RETURN
      #150422-00026#1 add ---
      ELSE
         #入庫單就要看收貨單有沒有發票可寫入
         #IF l_apba.apba004 = "11" THEN
         #   CALL aapt110_ins_isam_from_pmdw(l_apba.apba005) RETURNING g_sub_success
         #END IF
      #150422-00026#1 end ---
      END IF
      LET l_apba.apbaseq = l_apba.apbaseq + 1
   END FOREACH 
   
   CALL aapt110_ins_isam_1() RETURNING g_sub_success
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL aapt110_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 產生對帳單明細>>寫入來源單身(流通)
# Memo...........: 
# Usage..........: CALL aapt110_ins_apba_1()
#                  RETURNING r_success
# Date & Author..: 2015/06/01 By lujh #150417-00007#30 add
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_ins_apba_1()
#DEFINE l_apba           RECORD LIKE apba_t.*#161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_apba RECORD  #進項發票明細檔
       apbaent   LIKE apba_t.apbaent, #企業編號
       apbadocno LIKE apba_t.apbadocno, #檔案號碼
       apbaorga  LIKE apba_t.apbaorga, #帳務歸屬組織
       apba001   LIKE apba_t.apba001, #發票類型
       apba002   LIKE apba_t.apba002, #發票編號
       apba003   LIKE apba_t.apba003, #發票號碼
       apbaseq   LIKE apba_t.apbaseq, #項次
       apba004   LIKE apba_t.apba004, #來源作業
       apba005   LIKE apba_t.apba005, #業務單號碼
       apba006   LIKE apba_t.apba006, #業務單項次
       apba007   LIKE apba_t.apba007, #產品編號
       apba008   LIKE apba_t.apba008, #品名規格
       apba009   LIKE apba_t.apba009, #單位
       apba010   LIKE apba_t.apba010, #發票數量
       apba011   LIKE apba_t.apba011, #暫估帳款數量
       apba012   LIKE apba_t.apba012, #正負值
       apba013   LIKE apba_t.apba013, #參考單號
       apba014   LIKE apba_t.apba014, #單價
       apba015   LIKE apba_t.apba015, #稅別
       apba016   LIKE apba_t.apba016, #扣抵發票編號
       apba017   LIKE apba_t.apba017, #扣抵藍字發票號碼
       apba100   LIKE apba_t.apba100, #交易原幣
       apba103   LIKE apba_t.apba103, #原幣未稅金額
       apba104   LIKE apba_t.apba104, #原幣稅額
       apba105   LIKE apba_t.apba105, #原幣含稅總額
       apba111   LIKE apba_t.apba111, #發票匯率
       apba113   LIKE apba_t.apba113, #發票幣未稅金額
       apba114   LIKE apba_t.apba114, #發票幣稅額
       apba115   LIKE apba_t.apba115, #發票幣含稅總額
       apbaud001 LIKE apba_t.apbaud001, #自定義欄位(文字)001
       apbaud002 LIKE apba_t.apbaud002, #自定義欄位(文字)002
       apbaud003 LIKE apba_t.apbaud003, #自定義欄位(文字)003
       apbaud004 LIKE apba_t.apbaud004, #自定義欄位(文字)004
       apbaud005 LIKE apba_t.apbaud005, #自定義欄位(文字)005
       apbaud006 LIKE apba_t.apbaud006, #自定義欄位(文字)006
       apbaud007 LIKE apba_t.apbaud007, #自定義欄位(文字)007
       apbaud008 LIKE apba_t.apbaud008, #自定義欄位(文字)008
       apbaud009 LIKE apba_t.apbaud009, #自定義欄位(文字)009
       apbaud010 LIKE apba_t.apbaud010, #自定義欄位(文字)010
       apbaud011 LIKE apba_t.apbaud011, #自定義欄位(數字)011
       apbaud012 LIKE apba_t.apbaud012, #自定義欄位(數字)012
       apbaud013 LIKE apba_t.apbaud013, #自定義欄位(數字)013
       apbaud014 LIKE apba_t.apbaud014, #自定義欄位(數字)014
       apbaud015 LIKE apba_t.apbaud015, #自定義欄位(數字)015
       apbaud016 LIKE apba_t.apbaud016, #自定義欄位(數字)016
       apbaud017 LIKE apba_t.apbaud017, #自定義欄位(數字)017
       apbaud018 LIKE apba_t.apbaud018, #自定義欄位(數字)018
       apbaud019 LIKE apba_t.apbaud019, #自定義欄位(數字)019
       apbaud020 LIKE apba_t.apbaud020, #自定義欄位(數字)020
       apbaud021 LIKE apba_t.apbaud021, #自定義欄位(日期時間)021
       apbaud022 LIKE apba_t.apbaud022, #自定義欄位(日期時間)022
       apbaud023 LIKE apba_t.apbaud023, #自定義欄位(日期時間)023
       apbaud024 LIKE apba_t.apbaud024, #自定義欄位(日期時間)024
       apbaud025 LIKE apba_t.apbaud025, #自定義欄位(日期時間)025
       apbaud026 LIKE apba_t.apbaud026, #自定義欄位(日期時間)026
       apbaud027 LIKE apba_t.apbaud027, #自定義欄位(日期時間)027
       apbaud028 LIKE apba_t.apbaud028, #自定義欄位(日期時間)028
       apbaud029 LIKE apba_t.apbaud029, #自定義欄位(日期時間)029
       apbaud030 LIKE apba_t.apbaud030, #自定義欄位(日期時間)030
       apba018   LIKE apba_t.apba018, #本次開票金額
       apba019   LIKE apba_t.apba019, #預付已開發票
       apba020   LIKE apba_t.apba020  #期別
          END RECORD
#161104-00024#1-add(e)
DEFINE r_success        LIKE type_t.num5
DEFINE l_wc             STRING
DEFINE l_sql            STRING
DEFINE l_pmds000        STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sum_apba010    LIKE apba_t.apba010
DEFINE l_sfin3015       LIKE type_t.chr1     #發票限制同法人否?
DEFINE l_stbe001        LIKE stbe_t.stbe001
DEFINE l_stbe016        LIKE stbe_t.stbe016
DEFINE l_stbe021        LIKE stbe_t.stbe021
DEFINE l_stbe024        LIKE stbe_t.stbe024
DEFINE l_stbe025        LIKE stbe_t.stbe025
DEFINE l_apba103_sum    LIKE apba_t.apba103
DEFINE l_apba105_sum    LIKE apba_t.apba105
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1
   
   LET r_success = TRUE
   
   #160705-00035#1 mark ------
   #CALL s_fin_account_center_sons_query('3',g_apbb_m.apbb004,g_today,'')
   #CALL s_fin_account_center_sons_str()RETURNING g_wc_apbaorga
   #CALL s_fin_get_wc_str(g_wc_apbaorga) RETURNING g_wc_apbaorga
   #160705-00035#1 mark end---
   
   CALL aapt110_05(g_apbb_m.apbb004,g_apbb_m.apbb002,g_apbb_m.apbb012,g_apbb_m.apbb014,g_apbb_m.apbb050,g_wc_apbaorga)
        RETURNING l_wc
        
   IF l_wc = " 1=2 " THEN
      RETURN r_success
   END IF

   #IF g_apbb_m.apbb050 = "2" THEN  #紅字發票只開倉退單
   #   LET l_pmds000 = "('7','14','15')"
   #ELSE #入庫單+倉退單
   #   LET l_pmds000 = "('3','4','6','7','12','13','14','15')"
   #END IF
   
   #發票限制同法人否?
   CALL cl_get_para(g_enterprise,g_apbb_m.apbbcomp,'S-FIN-3015') RETURNING l_sfin3015

   LET l_sql = "SELECT stbe001,stbe002,stbe003,stbedocno,stbe008,",
               "       stbe027,stbe026,stbe011,stbe016,stbe021,",
               "       stbe024,stbe025 ",
               "  FROM stbe_t,stbd_t ",
               "  LEFT OUTER JOIN stan_t ",
               "    ON stbd001 = stan001 ",
               " WHERE stbeent = ",g_enterprise,
               "   AND stbeent = stbdent ",
               "   AND stbedocno = stbddocno ",
               "   AND stbdstus = 'Y' ",
               "   AND stbe024 = 'Y' ",
               "   AND stbe025 = 'Y' ",
               "   AND stbd002 = '",g_apbb_m.apbb002,"'",   #交易對象
               "   AND stbe008 = '",g_apbb_m.apbb014,"'",   #幣別
               "   AND stbe009 = '",g_apbb_m.apbb012,"'",   #稅別
               "   AND stan008 = '",g_apbb_m.apbb054,"'",   #付款條件
               "   AND (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise,
               "           AND ooef001 = stbesite) = '",g_apbb_m.apbbcomp,"'",   #法人
               "   AND ", l_wc CLIPPED,
               " ORDER BY stbedocno,stbeseq "
   PREPARE sel_stbe_p FROM l_sql
   DECLARE sel_stbe_c CURSOR FOR sel_stbe_p
   FOREACH sel_stbe_c INTO l_stbe001,l_apba.apba005,l_apba.apba006,
                           l_apba.apba013,l_apba.apba100,l_apba.apba014,
                           l_apba.apba010,l_apba.apba012,l_stbe016,l_stbe021,
                           l_stbe024,l_stbe025
                           
      #20150709--add--str--lujh
      SELECT COUNT(*) INTO l_cnt
        FROM apba_t
       WHERE apbaent = g_enterprise
         AND apba005 = l_apba.apba005
         AND apba006 = l_apba.apba006
      IF l_cnt > 0 THEN 
         CONTINUE FOREACH
      END IF
      #20150709--add--end--lujh
   
      LET l_apba.apbaorga = g_apbb_m.apbbcomp
      
      #項次
      SELECT MAX(apbaseq)+1 INTO l_apba.apbaseq FROM apba_t
       WHERE apbaent = g_enterprise AND apbadocno = g_apbb_m.apbbdocno
      IF cl_null(l_apba.apbaseq) OR l_apba.apbaseq = 0 THEN
         LET l_apba.apbaseq = 1
      END IF
      
      CASE l_stbe001
        WHEN '1' 
             LET l_apba.apba004 = '11' 
        WHEN '2'
             LET l_apba.apba004 = '21' 
        WHEN '3' 
             LET l_apba.apba004 = '12' 
        WHEN '4' 
             LET l_apba.apba004 = '13' 
        WHEN '5' 
             LET l_apba.apba004 = '23' 
      END CASE
      
      #20150629--add--str--lujh
      IF l_apba.apba004 = '12' THEN 
         LET l_apba.apba012 = l_apba.apba012 * -1
      END IF
      #20150629--add--end--lujh
      
      IF cl_null(l_stbe021) THEN LET l_stbe021 = 0 END IF

      SELECT SUM(apba103),SUM(apba105) INTO l_apba103_sum,l_apba105_sum
        FROM apba_t
        LEFT JOIN apbb_t ON apbaent = apbbent AND apbadocno = apbbdocno
       WHERE apbaent = g_enterprise
         AND apba005 = l_apba.apba005
         AND apba006 = l_apba.apba006

      IF cl_null(l_apba103_sum) THEN LET l_apba103_sum = 0 END IF
      IF cl_null(l_apba105_sum) THEN LET l_apba105_sum = 0 END IF
      
      IF g_apbb_m.apbb0121 = 'Y' THEN 
         IF l_apba105_sum + l_stbe021 > l_stbe016 THEN 
            CONTINUE FOREACH 
         END IF
      ELSE
         IF l_apba103_sum + l_stbe021 > l_stbe016 THEN 
            CONTINUE FOREACH 
         END IF
      END IF
      
      IF l_stbe001 = '3' AND (l_stbe024 = 'N' OR cl_null(l_stbe024)) THEN 
         CONTINUE FOREACH
      END IF 
      
      IF l_stbe001 = '3' AND (l_stbe025 = 'N' OR cl_null(l_stbe025)) THEN 
         CONTINUE FOREACH
      END IF
      
      #稅別
      LET l_apba.apba015 = g_apbb_m.apbb012
      #匯率
      LET l_apba.apba111 = g_apbb_m.apbb015
      
      SELECT pmdt006,pmdt023
        INTO l_apba.apba007,l_apba.apba009
        FROM pmdt_t
       WHERE pmdtent = g_enterprise   AND pmdtdocno = l_apba.apba005 AND pmdtseq = l_apba.apba006 
  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_apba.apba007
#160602-00023#1---begin
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      CALL ap_ref_array2(g_ref_fields,"SELECT (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||(CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||(CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END) FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#160602-00023#1---end  
      LET l_apba.apba008 = '', g_rtn_fields[1] , ''
      
      #單價取位 
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_apba.apba014,1) RETURNING g_sub_success,g_errno,l_apba.apba014
      #重新計算金額
      #160802-00049#1-s
      LET l_money = l_apba.apba014*l_apba.apba010
      CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
      #160802-00049#1-e
     #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(l_apba.apba014*l_apba.apba010),l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
      CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,l_apba.apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
      RETURNING l_apba.apba103,l_apba.apba104,l_apba.apba105,
                l_apba.apba113,l_apba.apba114,l_apba.apba115  
      
      #判斷該筆入庫單+項次是否已存在該對帳單，不存在才寫入
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM apba_t
       WHERE apbaent = g_enterprise
         AND apbadocno = g_apbb_m.apbbdocno
         AND apba005 = l_apba.apba005
         AND apba006 = l_apba.apba006
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INSERT INTO apba_t(apbaent,apbadocno,apbaseq,apbaorga,apba004,
                            apba005,apba006,apba007,apba008,apba013,
                            apba015,apba012,apba100,apba009,apba014,
                            apba010,apba103,apba105,apba104,apba113,
                            apba115,apba114,apba016,apba017,apba111) 
                     VALUES(g_enterprise,g_apbb_m.apbbdocno,l_apba.apbaseq,l_apba.apbaorga,l_apba.apba004,
                            l_apba.apba005,l_apba.apba006,l_apba.apba007,l_apba.apba008,l_apba.apba013,
                            l_apba.apba015,l_apba.apba012,l_apba.apba100,l_apba.apba009,l_apba.apba014,
                            l_apba.apba010,l_apba.apba103,l_apba.apba105,l_apba.apba104,l_apba.apba113,
                            l_apba.apba115,l_apba.apba114,'','',l_apba.apba111)
         IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins apba_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         ELSE
            #入庫單就要看收貨單有沒有發票可寫入
            #IF l_apba.apba004 = "11" THEN
            #   CALL aapt110_ins_isam_from_pmdw(l_apba.apba005) RETURNING g_sub_success
            #END IF
         END IF
      END IF
   END FOREACH
   
   CALL aapt110_ins_isam_1() RETURNING g_sub_success

   RETURN r_success
END FUNCTION


# 来源单据+项次检查
PRIVATE FUNCTION aapt110_apba005_chk()
DEFINE l_stbdstus       LIKE stbd_t.stbdstus
DEFINE l_stbesite       LIKE stbe_t.stbesite
DEFINE l_ooef017        LIKE ooef_t.ooef017
DEFINE l_n              LIKE type_t.num5
   
   LET g_errno = ''
   
   SELECT stbdstus,stbesite INTO l_stbdstus,l_stbesite
     FROM stbd_t,stbe_t
    WHERE stbdent = stbeent AND stbddocno = stbedocno
      AND stbdent = g_enterprise
      AND stbe002 = g_apba_d[l_ac].apba005
      AND stbe003 = g_apba_d[l_ac].apba006
   IF l_stbdstus <> 'Y' THEN 
      LET g_errno = 'aap-00356'
      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_n
     FROM stbe_t,stbd_t
     LEFT OUTER JOIN stan_t
       ON stbd001 = stan001
    WHERE stbdent = stbeent AND stbddocno = stbedocno
      AND stbdent = g_enterprise
      AND stbe002 = g_apba_d[l_ac].apba005
      AND stbe003 = g_apba_d[l_ac].apba006
      AND stbd002 = g_apbb_m.apbb002      #交易對象
      AND stbe008 = g_apbb_m.apbb014      #幣別
      AND stbe009 = g_apbb_m.apbb012      #稅別
      AND stan008 = g_apbb_m.apbb054      #付款條件
   IF l_n = 0 THEN 
      LET g_errno = 'aap-00371'
      RETURN
   END IF
   
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = l_stbesite
   IF l_ooef017 <> g_apbb_m.apbbcomp THEN
      LET g_errno = 'aap-00372'
      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_n
     FROM apba_t
    WHERE apbaent = g_enterprise
      AND apbadocno = g_apbb_m.apbbdocno
      AND apba005 = g_apba_d[l_ac].apba005
      AND apba006 = g_apba_d[l_ac].apba006
      AND apbaseq <> g_apba_d[l_ac].apbaseq
   IF l_n > 0 THEN 
      LET g_errno = 'asf-00408'
      RETURN
   END IF
   
END FUNCTION


# 用單號+項次撈出該單據的其他資料
PRIVATE FUNCTION aapt110_qbevalue_show_1(p_ac,p_apba005,p_apba006)
DEFINE p_ac             LIKE type_t.num5
DEFINE p_apba005        LIKE apba_t.apba005
DEFINE p_apba006        LIKE apba_t.apba006
DEFINE l_money          LIKE apba_t.apba103  #160802-00049#1

   SELECT stbedocno,stbe008,stbe027,stbe026,stbe011,
          stbe016,stbe021,stbe024,stbe025 
     INTO g_apba_d[p_ac].apba013,g_apba_d[p_ac].apba100,g_apba_d[p_ac].apba014,
          g_apba_d[p_ac].apba010,g_apba_d[p_ac].apba012
     FROM stbe_t,stbd_t
    WHERE stbeent = stbdent
      AND stbedocno = stbddocno
      AND stbeent = g_enterprise
      AND stbe002 = p_apba005
      AND stbe003 = p_apba006
      
   #稅別
   LET g_apba_d[p_ac].apba015 = g_apbb_m.apbb012
   #匯率
   LET g_apba_d[p_ac].apba111 = g_apbb_m.apbb015   
   
   SELECT pmdt006,pmdt023
     INTO g_apba_d[p_ac].apba007,g_apba_d[p_ac].apba009
     FROM pmdt_t
    WHERE pmdtent = g_enterprise AND pmdtdocno = p_apba005 AND pmdtseq = p_apba006 
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apba_d[p_ac].apba007
#160602-00023#1---begin
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      CALL ap_ref_array2(g_ref_fields,"SELECT (CASE WHEN imaal003 IS NULL THEN '' ELSE imaal003 END)||(CASE WHEN imaal003 IS NULL OR imaal004 IS NULL THEN '' ELSE '/' END)||(CASE WHEN imaal004 IS NULL THEN '' ELSE imaal004 END) FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#160602-00023#1---end  
      LET g_apba_d[p_ac].apba008 = '', g_rtn_fields[1] , ''
   
   #單價取位 
   CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,g_apba_d[p_ac].apba014,1) RETURNING g_sub_success,g_errno,g_apba_d[p_ac].apba014
   
   #重新計算金額
   #160802-00049#1-s
   LET l_money = g_apba_d[p_ac].apba014*g_apba_d[p_ac].apba010
   CALL s_curr_round_ld('1',g_ld,g_apbb_m.apbb014,l_money,2) RETURNING g_sub_success,g_errno,l_money
   #160802-00049#1-e
  #CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,(g_apba_d[p_ac].apba014*g_apba_d[p_ac].apba010),g_apba_d[p_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1 mark
   CALL s_tax_count(g_apbb_m.apbbcomp,g_apbb_m.apbb012,l_money,g_apba_d[p_ac].apba010,g_apbb_m.apbb014,g_apbb_m.apbb015) #160802-00049#1
   RETURNING g_apba_d[p_ac].apba103,g_apba_d[p_ac].apba104,g_apba_d[p_ac].apba105,
             g_apba_d[p_ac].apba113,g_apba_d[p_ac].apba114,g_apba_d[p_ac].apba115  
   
   DISPLAY BY NAME g_apba_d[p_ac].apba007,g_apba_d[p_ac].apba008,g_apba_d[p_ac].apba013,g_apba_d[p_ac].apba015,g_apba_d[p_ac].apba100,
                   g_apba_d[p_ac].apba009,g_apba_d[p_ac].apba014,g_apba_d[p_ac].apba010,g_apba_d[p_ac].apba113,g_apba_d[p_ac].apba115,
                   g_apba_d[p_ac].apba114,g_apba_d[p_ac].apba103,g_apba_d[p_ac].apba104,g_apba_d[p_ac].apba105   
       
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
PRIVATE FUNCTION aapt110_ins_isam_1()
#DEFINE l_isam           RECORD LIKE isam_t.* #161104-00024#1 mark
#161104-00024#1-add(s)
DEFINE l_isam RECORD  #進項發票主檔  
       isament   LIKE isam_t.isament, #企業編號
       isamownid LIKE isam_t.isamownid, #資料所有者
       isamowndp LIKE isam_t.isamowndp, #資料所屬部門
       isamcrtid LIKE isam_t.isamcrtid, #資料建立者
       isamcrtdp LIKE isam_t.isamcrtdp, #資料建立部門
       isamcrtdt LIKE isam_t.isamcrtdt, #資料創建日
       isammodid LIKE isam_t.isammodid, #資料修改者
       isammoddt LIKE isam_t.isammoddt, #最近修改日
       isamcnfid LIKE isam_t.isamcnfid, #資料確認者
       isamcnfdt LIKE isam_t.isamcnfdt, #資料確認日
       isamstus  LIKE isam_t.isamstus, #狀態碼
       isamcomp  LIKE isam_t.isamcomp, #法人
       isamdocno LIKE isam_t.isamdocno, #收票單號
       isamseq   LIKE isam_t.isamseq, #項次
       isam001   LIKE isam_t.isam001, #發票來源
       isam002   LIKE isam_t.isam002, #開發票人
       isam004   LIKE isam_t.isam004, #帳務中心(業務組織)
       isam006   LIKE isam_t.isam006, #業務部門(登錄部門)
       isam008   LIKE isam_t.isam008, #發票類型
       isam009   LIKE isam_t.isam009, #銷方發票編號
       isam010   LIKE isam_t.isam010, #發票號碼
       isam011   LIKE isam_t.isam011, #發票日期
       isam012   LIKE isam_t.isam012, #稅別
       isam0121   LIKE isam_t.isam0121, #含稅否
       isam013   LIKE isam_t.isam013, #稅率
       isam014   LIKE isam_t.isam014, #幣別
       isam015   LIKE isam_t.isam015, #匯率
       isam016   LIKE isam_t.isam016, #購貨方名稱
       isam017   LIKE isam_t.isam017, #購貨方稅務編號
       isam018   LIKE isam_t.isam018, #購貨方地址
       isam019   LIKE isam_t.isam019, #購貨方電話
       isam020   LIKE isam_t.isam020, #購貨方開戶銀行
       isam021   LIKE isam_t.isam021, #購貨方帳戶編碼
       isam022   LIKE isam_t.isam022, #銷方銀行帳戶編碼
       isam023   LIKE isam_t.isam023, #發票原幣未稅金額
       isam024   LIKE isam_t.isam024, #發票原幣稅額
       isam025   LIKE isam_t.isam025, #發票原幣含稅金額
       isam026   LIKE isam_t.isam026, #發票本幣未稅金額
       isam027   LIKE isam_t.isam027, #發票本幣稅額
       isam028   LIKE isam_t.isam028, #發票本幣含稅金額
       isam029   LIKE isam_t.isam029, #銷貨方名稱
       isam030   LIKE isam_t.isam030, #稅務編號
       isam031   LIKE isam_t.isam031, #銷貨方地址
       isam032   LIKE isam_t.isam032, #銷貨方電話
       isam033   LIKE isam_t.isam033, #銷貨方開戶銀行
       isam034   LIKE isam_t.isam034, #銷貨方帳號
       isam035   LIKE isam_t.isam035, #申報數量
       isam036   LIKE isam_t.isam036, #異動狀態
       isam037   LIKE isam_t.isam037, #可扣抵編號
       isam038   LIKE isam_t.isam038, #作廢(註銷)理由碼
       isam039   LIKE isam_t.isam039, #作廢日期
       isam040   LIKE isam_t.isam040, #作廢時間
       isam041   LIKE isam_t.isam041, #作廢人員
       isam042   LIKE isam_t.isam042, #專案作廢核准文號
       isam043   LIKE isam_t.isam043, #通關方式註記
       isam044   LIKE isam_t.isam044, #列印次數
       isam045   LIKE isam_t.isam045, #支付工具卡號1
       isam046   LIKE isam_t.isam046, #支付工具卡號2
       isam047   LIKE isam_t.isam047, #支付工具卡號3
       isam048   LIKE isam_t.isam048, #通關註記
       isam049   LIKE isam_t.isam049, #備註說明
       isam050   LIKE isam_t.isam050, #立帳單號
       isam107   LIKE isam_t.isam107, #發票原幣已折金額
       isam108   LIKE isam_t.isam108, #發票原幣已折稅額
       isam117   LIKE isam_t.isam117, #發票本幣已折金額
       isam118   LIKE isam_t.isam118, #發票本幣已折稅額
       isam200   LIKE isam_t.isam200, #電子發票否
       isam201   LIKE isam_t.isam201, #愛心碼
       isam202   LIKE isam_t.isam202, #載具類別號碼
       isam203   LIKE isam_t.isam203, #載具顯碼 ID
       isam204   LIKE isam_t.isam204, #載具隱碼 ID
       isam205   LIKE isam_t.isam205, #電子發票匯出狀態
       isam206   LIKE isam_t.isam206, #電子發票匯出序號
       isam207   LIKE isam_t.isam207, #電子發票領取方式
       isam208   LIKE isam_t.isam208, #申報年度
       isam209   LIKE isam_t.isam209, #申報月份
       isam210   LIKE isam_t.isam210, #申報據點
       isamud001 LIKE isam_t.isamud001, #自定義欄位(文字)001
       isamud002 LIKE isam_t.isamud002, #自定義欄位(文字)002
       isamud003 LIKE isam_t.isamud003, #自定義欄位(文字)003
       isamud004 LIKE isam_t.isamud004, #自定義欄位(文字)004
       isamud005 LIKE isam_t.isamud005, #自定義欄位(文字)005
       isamud006 LIKE isam_t.isamud006, #自定義欄位(文字)006
       isamud007 LIKE isam_t.isamud007, #自定義欄位(文字)007
       isamud008 LIKE isam_t.isamud008, #自定義欄位(文字)008
       isamud009 LIKE isam_t.isamud009, #自定義欄位(文字)009
       isamud010 LIKE isam_t.isamud010, #自定義欄位(文字)010
       isamud011 LIKE isam_t.isamud011, #自定義欄位(數字)011
       isamud012 LIKE isam_t.isamud012, #自定義欄位(數字)012
       isamud013 LIKE isam_t.isamud013, #自定義欄位(數字)013
       isamud014 LIKE isam_t.isamud014, #自定義欄位(數字)014
       isamud015 LIKE isam_t.isamud015, #自定義欄位(數字)015
       isamud016 LIKE isam_t.isamud016, #自定義欄位(數字)016
       isamud017 LIKE isam_t.isamud017, #自定義欄位(數字)017
       isamud018 LIKE isam_t.isamud018, #自定義欄位(數字)018
       isamud019 LIKE isam_t.isamud019, #自定義欄位(數字)019
       isamud020 LIKE isam_t.isamud020, #自定義欄位(數字)020
       isamud021 LIKE isam_t.isamud021, #自定義欄位(日期時間)021
       isamud022 LIKE isam_t.isamud022, #自定義欄位(日期時間)022
       isamud023 LIKE isam_t.isamud023, #自定義欄位(日期時間)023
       isamud024 LIKE isam_t.isamud024, #自定義欄位(日期時間)024
       isamud025 LIKE isam_t.isamud025, #自定義欄位(日期時間)025
       isamud026 LIKE isam_t.isamud026, #自定義欄位(日期時間)026
       isamud027 LIKE isam_t.isamud027, #自定義欄位(日期時間)027
       isamud028 LIKE isam_t.isamud028, #自定義欄位(日期時間)028
       isamud029 LIKE isam_t.isamud029, #自定義欄位(日期時間)029
       isamud030 LIKE isam_t.isamud030, #自定義欄位(日期時間)030
       isam051   LIKE isam_t.isam051      #認證否
          END RECORD
#161104-00024#1-add(s)
DEFINE r_success        LIKE type_t.num5
DEFINE l_n              LIKE type_t.num5    #20150713 add lujh
   
   LET r_success = TRUE
   
   #20150713--add--str--lujh
   SELECT COUNT(*) INTO l_n
     FROM isam_t
    WHERE isament = g_enterprise
      AND isamdocno = g_apbb_m.apbbdocno
   IF l_n > 0 THEN
      RETURN r_success
   END IF
   #20150713--add--end--lujh
   
   LET l_isam.isament = g_enterprise
   LET l_isam.isamcomp = g_apbb_m.apbbcomp
   LET l_isam.isamdocno = g_apbb_m.apbbdocno
   
   #項次
   SELECT MAX(isamseq)+1 INTO l_isam.isamseq FROM isam_t
    WHERE isament = g_enterprise AND isamdocno = g_apbb_m.apbbdocno
   IF cl_null(l_isam.isamseq) OR l_isam.isamseq = 0 THEN
      LET l_isam.isamseq = 1
   END IF

   LET l_isam.isam002 = g_apbb_m.apbb053
   LET l_isam.isam004 = g_apbb_m.apbb004
   #LET l_isam.isam006 = 
   LET l_isam.isam008 = g_apbb_m.apbb008
   LET l_isam.isam009 = g_apbb_m.apbb009
   LET l_isam.isam010 = g_apbb_m.apbb010
   LET l_isam.isam011 = g_apbb_m.apbb011
   LET l_isam.isam012 = g_apbb_m.apbb012
   LET l_isam.isam0121 = g_apbb_m.apbb0121
   LET l_isam.isam013 = g_apbb_m.apbb013
   LET l_isam.isam014 = g_apbb_m.apbb014
   LET l_isam.isam015 = g_apbb_m.apbb015
   LET l_isam.isam030 = g_apbb_m.apbb030
   LET l_isam.isam036 = '11'
   LET l_isam.isam037 = '1'
   LET l_isam.isam200 = g_apbb_m.apbb200
   
   SELECT SUM(apba012 * apba103),SUM(apba012 * apba104),SUM(apba012 * apba105),
          SUM(apba012 * apba113),SUM(apba012 * apba114),SUM(apba012 * apba115)
     INTO l_isam.isam023,l_isam.isam024,l_isam.isam025,
          l_isam.isam026,l_isam.isam027,l_isam.isam028
     FROM apba_t
    WHERE apbaent = g_enterprise
      AND apbadocno = g_apbb_m.apbbdocno
   
   #INSERT INTO isam_t VALUES(l_isam.*)  #161108-00017#3 mark
   #161108-00017#3 add ------
   INSERT INTO isam_t (isament,isamownid,isamowndp,isamcrtid,isamcrtdp,
                       isamcrtdt,isammodid,isammoddt,isamcnfid,isamcnfdt,
                       isamstus,isamcomp,isamdocno,isamseq,
                       isam001,isam002,isam004,isam006,isam008,
                       isam009,isam010,isam011,isam012,isam0121,
                       isam013,isam014,isam015,isam016,isam017,
                       isam018,isam019,isam020,isam021,isam022,
                       isam023,isam024,isam025,isam026,isam027,
                       isam028,isam029,isam030,isam031,isam032,
                       isam033,isam034,isam035,isam036,isam037,
                       isam038,isam039,isam040,isam041,isam042,
                       isam043,isam044,isam045,isam046,isam047,
                       isam048,isam049,isam050,isam107,isam108,
                       isam117,isam118,isam200,isam201,isam202,
                       isam203,isam204,isam205,isam206,isam207,
                       isam208,isam209,isam210,
                       isamud001,isamud002,isamud003,isamud004,isamud005,
                       isamud006,isamud007,isamud008,isamud009,isamud010,
                       isamud011,isamud012,isamud013,isamud014,isamud015,
                       isamud016,isamud017,isamud018,isamud019,isamud020,
                       isamud021,isamud022,isamud023,isamud024,isamud025,
                       isamud026,isamud027,isamud028,isamud029,isamud030,
                       isam051
                      )
   VALUES (l_isam.isament,l_isam.isamownid,l_isam.isamowndp,l_isam.isamcrtid,l_isam.isamcrtdp,
           l_isam.isamcrtdt,l_isam.isammodid,l_isam.isammoddt,l_isam.isamcnfid,l_isam.isamcnfdt,
           l_isam.isamstus,l_isam.isamcomp,l_isam.isamdocno,l_isam.isamseq,
           l_isam.isam001,l_isam.isam002,l_isam.isam004,l_isam.isam006,l_isam.isam008,
           l_isam.isam009,l_isam.isam010,l_isam.isam011,l_isam.isam012,l_isam.isam0121,
           l_isam.isam013,l_isam.isam014,l_isam.isam015,l_isam.isam016,l_isam.isam017,
           l_isam.isam018,l_isam.isam019,l_isam.isam020,l_isam.isam021,l_isam.isam022,
           l_isam.isam023,l_isam.isam024,l_isam.isam025,l_isam.isam026,l_isam.isam027,
           l_isam.isam028,l_isam.isam029,l_isam.isam030,l_isam.isam031,l_isam.isam032,
           l_isam.isam033,l_isam.isam034,l_isam.isam035,l_isam.isam036,l_isam.isam037,
           l_isam.isam038,l_isam.isam039,l_isam.isam040,l_isam.isam041,l_isam.isam042,
           l_isam.isam043,l_isam.isam044,l_isam.isam045,l_isam.isam046,l_isam.isam047,
           l_isam.isam048,l_isam.isam049,l_isam.isam050,l_isam.isam107,l_isam.isam108,
           l_isam.isam117,l_isam.isam118,l_isam.isam200,l_isam.isam201,l_isam.isam202,
           l_isam.isam203,l_isam.isam204,l_isam.isam205,l_isam.isam206,l_isam.isam207,
           l_isam.isam208,l_isam.isam209,l_isam.isam210,
           l_isam.isamud001,l_isam.isamud002,l_isam.isamud003,l_isam.isamud004,l_isam.isamud005,
           l_isam.isamud006,l_isam.isamud007,l_isam.isamud008,l_isam.isamud009,l_isam.isamud010,
           l_isam.isamud011,l_isam.isamud012,l_isam.isamud013,l_isam.isamud014,l_isam.isamud015,
           l_isam.isamud016,l_isam.isamud017,l_isam.isamud018,l_isam.isamud019,l_isam.isamud020,
           l_isam.isamud021,l_isam.isamud022,l_isam.isamud023,l_isam.isamud024,l_isam.isamud025,
           l_isam.isamud026,l_isam.isamud027,l_isam.isamud028,l_isam.isamud029,l_isam.isamud030,
           l_isam.isam051
          )
   #161108-00017#3 add end---
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT isam_t wrong!"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE 
   END IF
   
   RETURN r_success
END FUNCTION


# 检查aapt110是否已经产生aapt210
PRIVATE FUNCTION aapt110_aapt210_exist_chk()
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apca018 = g_apbb_m.apbbdocno
      AND apcastus <> 'X'   #150812-00010#2 by 03538
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依照發票聯別，控制統編是否必輸
# Memo...........: #151105-00001#8
# Usage..........: CALL aapt110_inv_visible(p_comp,p_apbb008)
# Date & Author..: 151111 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_inv_visible(p_comp,p_apbb008)
DEFINE l_isac008        LIKE isac_t.isac008
DEFINE p_comp           LIKE apbb_t.apbbcomp
DEFINE p_apbb008        LIKE apbb_t.apbb008
   
   #161230-00036#1 mark ------
   ##抓取稅區
   #SELECT ooef019 INTO g_ooef019
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = p_comp
   #161230-00036#1 mark end---
   #161129-00042#1 mark(s)
   ##抓取發票聯別，若是0、4統編不須必輸
   #SELECT isac008 INTO l_isac008
   #  FROM isac_t
   #  LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001 AND ooef001 = p_comp
   # WHERE isacent = g_enterprise
   #   AND isac001 = g_ooef019
   #   AND isac002 = p_apbb008
   #
   #IF l_isac008 MATCHES '[04]' THEN
   #   CALL cl_set_comp_required("apbb030",FALSE)
   #ELSE
   #   CALL cl_set_comp_required("apbb030",TRUE)
   #END IF
   #161129-00042#1 mark(e)
   #161230-00036#1-add(s)
   #IF g_isac008 MATCHES '[4]' OR cl_null(g_isac004) THEN                                          #170218-00012#1 mark
   IF g_isac008 MATCHES '[4]' OR cl_null(g_isac004) OR g_isac004 = '28' OR g_isac004 = '29' THEN   #170218-00012#1 add
      CALL cl_set_comp_required("apbb030",FALSE)
   ELSE
      CALL cl_set_comp_required("apbb030",TRUE)
   END IF
   #161230-00036#1-add(e)
END FUNCTION

################################################################################
# Descriptions...: 編輯完單據後立即審核
# Memo...........:
# Usage..........: CALL aapt110_immediately_conf()

# Date & Author..: 2015/11/30 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_immediately_conf()
#151125-00006#2--s
DEFINE l_success        LIKE type_t.num5
DEFINE l_doc_success    LIKE type_t.num5
DEFINE l_slip           LIKE ooba_t.ooba002
DEFINE l_dfin0031       LIKE type_t.chr1
DEFINE l_count          LIKE type_t.num5
   
   IF cl_null(g_ld) THEN RETURN END IF
   IF cl_null(g_apbb_m.apbbcomp) THEN RETURN END IF
   IF cl_null(g_apbb_m.apbbdocno) THEN RETURN END IF
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apba_t
    WHERE apbaent = g_enterprise
      AND apbadocno = g_apbb_m.apbbdocno
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN
   END IF
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_apbb_m.apbbdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_ld,g_apbb_m.apbbcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   #170218-00030#1 mod--s
   #IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   SELECT COUNT(*) INTO l_count FROM isam_t
     WHERE isament  = g_enterprise
       AND isamdocno= g_apbb_m.apbbdocno
   IF l_count = 0 THEN
      IF NOT cl_ask_confirm('aap-00609') THEN RETURN END IF  #询问发票信息未录入，是否立即审核?
   ELSE
      IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   END IF
   #170218-00030#1 mod--e
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      
   CALL s_aapt110_conf_chk(g_apbb_m.apbbdocno) RETURNING l_doc_success,g_apbb_m.apbb010 
   DISPLAY BY NAME g_apbb_m.apbb010
#   IF NOT s_aapt110_conf_chk(g_apbb_m.apbbdocno) THEN
#      LET l_doc_success = FALSE
#   END IF
   IF g_apbb_m.apbb056 = 'Y' THEN #for流通
      # CALL s_aapt110_conf_ins(g_apbb_m.apbbdocno) RETURNING g_sub_success
      IF NOT s_aapt110_conf_ins(g_apbb_m.apbbdocno) THEN
         LET l_doc_success = FALSE
      END IF
   ELSE    
       #CALL s_aapt110_conf_upd(g_apbb_m.apbbdocno) RETURNING g_sub_success
       IF NOT s_aapt110_conf_upd(g_apbb_m.apbbdocno) THEN
         LET l_doc_success = FALSE
      END IF
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_apbb_m.apbbmoddt = cl_get_current()
   LET g_apbb_m.apbbcnfdt = cl_get_current()
   UPDATE apbb_t SET apbbstus = 'Y',
                     apbbmodid= g_user,
                     apbbmoddt= g_apbb_m.apbbmoddt,
                     apbbcnfid= g_user,
                     apbbcnfdt= g_apbb_m.apbbcnfdt
    WHERE apbbent = g_enterprise AND apbb004 = g_apbb_m.apbb004
      AND apbbdocno = g_apbb_m.apbbdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

################################################################################
# Descriptions...: 檢查發票日期與發票字軌需同年月
# Memo...........: 
# Usage..........: CALL aapt110_isad005_chk (p_apbb010,p_apbb011)
#                  RETURNING r_success,r_errno
# Input parameter: p_apbb010   發票號碼
#                : p_apbb011   發票日期
# Return code....: r_success   成功否
#                : r_errno     錯誤代碼
# Date & Author..: #160713-00019#1 16/07/25 By catmoon 
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_isad005_chk(p_apbb010,p_apbb011)
#160713-00019#1--add--start--
DEFINE p_apbb010        LIKE apbb_t.apbb010
DEFINE p_apbb011        LIKE apbb_t.apbb011
DEFINE l_isad002        LIKE isad_t.isad002
DEFINE l_isad003        LIKE isad_t.isad003
DEFINE l_isad005        LIKE isad_t.isad005
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_cnt            LIKE type_t.num5
#DEFINE l_ooef011        LIKE ooef_t.ooef011  #161007-00009#1 by wuxja add #161230-00036#1 mark
DEFINE l_str            STRING               #161007-00009#1 by wuxja add
DEFINE l_i              LIKE type_t.num5     #161007-00009#1 by wuxja add
DEFINE l_apbb010        LIKE apbb_t.apbb010  #161007-00009#1 by wuxja add
DEFINE l_isac008        LIKE isac_t.isac008  #161026-00017#1
DEFINE l_isac004        LIKE isac_t.isac004  #161115-00002#1 add

   LET r_success = TRUE
   LET l_cnt = 0
   LET l_isad002 = YEAR(p_apbb011)
   LET l_isad003 = MONTH(p_apbb011)
   LET l_isad005 = p_apbb010[1,2]
   
   #161026-00017#1 add ------
   #發票聯別=0:園區收據/4:收據>>PASS不檢查
   #161230-00036#1 mark ------
   #SELECT isac008 INTO l_isac008
   #  FROM isac_t
   #  LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
   # WHERE isacent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #   AND isac002 = g_apbb_m.apbb008
   #IF l_isac008 MATCHES '[04]' THEN
   #161230-00036#1 mark end---
   IF g_isac008 MATCHES '[04]' THEN #161230-00036#1
      RETURN r_success,r_errno
   END IF
   #161026-00017#1 add end---
   #161230-00036#1 mark ------
   ##161115-00002#1---add---str--
   #SELECT ooef011,isac004 INTO l_ooef011,l_isac004
   #  FROM isac_t
   #  LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
   # WHERE isacent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #   AND isac002 = g_apbb_m.apbb008
   ###161115-00002#1---add---end--
   #161230-00036#1 mark end---
   
   #讀取發票字頭檔之資料並檢查年別+月+字軌
   #IF l_isac004 != '28' AND l_isac004 != '29' THEN #161115-00002#1 add 發票格式為28/29海關繳納憑證,不需檢查字軌 #161230-00036#1 mark
   IF g_isac004 != '28' AND g_isac004 != '29' THEN  #161230-00036#1 add
      SELECT COUNT(*) 
        INTO l_cnt
        FROM isad_t
       WHERE isad001 = g_ooef019
         AND isadent = g_enterprise  #160705-00035#1
         AND isad002 = l_isad002
         AND l_isad003 BETWEEN isad003 AND isad004
         AND isad005 = l_isad005
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt <= 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00005'
         RETURN r_success,r_errno    #161007-00009#1 by wuxja  add
      END IF
   END IF   #161115-00002#1 add
   
   #161007-00009#1 by wuxja  --begin--
   #161115-00002#1---mark---str--
   #SELECT ooef011 INTO l_ooef011 FROM ooef_t 
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apbb_m.apbbcomp
   #161115-00002#1---mark---end--
   #IF l_ooef011 = 'TW' AND g_apbb_m.apbb050 = '1' THEN #161230-00036#1 mark
   IF g_ooef011 = 'TW' AND g_apbb_m.apbb050 = '1' THEN  #161230-00036#1 add
      LET l_str = p_apbb010
      #IF l_isac004 != '28' AND l_isac004 != '29' THEN #161115-00002#1 add #161230-00036#1 mark
      IF g_isac004 != '28' AND g_isac004 != '29' THEN  #161230-00036#1 add
         IF l_str.getLength() != 10 THEN
            LET r_success = FALSE
            LET r_errno = 'aap-00597'
            RETURN r_success,r_errno
         END IF
         FOR l_i = 3 TO 10   
            LET l_apbb010 = p_apbb010[l_i,l_i]
            IF l_apbb010 NOT MATCHES "[0123456789]" THEN
               LET r_success = FALSE
               LET r_errno = 'aap-00597'
               RETURN r_success,r_errno
            END IF
         END FOR
      #161115-00002#1---add---str--
      ELSE
         IF l_str.getLength() != 14 THEN
            LET r_success = FALSE
            LET r_errno = 'aap-00603'                        
            RETURN r_success,r_errno
         END IF
         IF NOT(p_apbb010[1,1] MATCHES '[A-Z]' AND p_apbb010[2,2] MATCHES '[A-Z]' AND p_apbb010[3,3] MATCHES '[A-Z]') THEN
            LET r_success = FALSE
            LET r_errno = 'aap-00603'                        
            RETURN r_success,r_errno
         END IF
         FOR l_i = 4 TO 14
            LET l_apbb010 = p_apbb010[l_i,l_i]
            IF l_apbb010 NOT MATCHES "[0123456789]" THEN
               LET r_success = FALSE
               LET r_errno = 'aap-00603'                        
               RETURN r_success,r_errno
            END IF
         END FOR
      END IF
      #161115-00002#1---add---end--   
   END IF
   #161007-00009#1 by wuxja  --end--      
   
   RETURN r_success,r_errno
   
#160713-00019#1--add--end----
END FUNCTION

################################################################################
# Descriptions...: 輸入交易對象所帶出發票類型是否符合
# Memo...........:
# Usage..........: CALL aapt110_apbb008_chk(p_type)
# Input parameter: 無
# Return code....: r_success
# Date & Author..: 2016/11/08 By 08729 #161102-00055#1 add
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_apbb008_chk(p_type)
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
DEFINE p_type           LIKE type_t.num5  
   LET r_success = TRUE
   LET l_cnt = 0
   CASE
      WHEN p_type = 1
         SELECT COUNT(1) INTO l_cnt
           FROM isac_t
          WHERE isacent = g_enterprise 
            AND isac001 = g_ooef019 
            AND isac002 = g_apbb_m.apbb008
            AND isacstus = 'Y'
            AND isac003 = '1'
      WHEN p_type = 3
         SELECT COUNT(1) INTO l_cnt
           FROM isac_t
          WHERE isacent = g_enterprise 
            AND isac001 = g_ooef019 
            AND isac002 = g_apbb_m.apbb008
            AND isacstus = 'Y'
            AND isac003 IN ('1','3')
      WHEN p_type = 4
         SELECT COUNT(1) INTO l_cnt
           FROM isac_t
          WHERE isacent = g_enterprise 
            AND isac001 = g_ooef019 
            AND isac002 = g_apbb_m.apbb008
            AND isacstus = 'Y'
            AND isac003 = '3'
   END CASE 
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 對帳單主畫面表尾合計金額
# Memo...........: 160826-00017#1
# Usage..........: CALL aapt110_apba_sum_button(p_apbbcomp,p_apbbdocno,p_apbaseq)
# Date & Author..: 16110811 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt110_apbb_sum_button(p_apbbcomp,p_apbbdocno,p_apbaseq)
   DEFINE p_apbbcomp       LIKE apbb_t.apbbcomp
   DEFINE p_apbbdocno      LIKE apbb_t.apbbdocno
   DEFINE p_apbaseq        LIKE apba_t.apbaseq
   DEFINE r_apba103_s      LIKE apba_t.apba103
   DEFINE r_apba104_s      LIKE apba_t.apba104
   DEFINE r_apba105_s      LIKE apba_t.apba105
   DEFINE r_apba113_s      LIKE apba_t.apba113
   DEFINE r_apba114_s      LIKE apba_t.apba114
   DEFINE r_apba115_s      LIKE apba_t.apba115

   IF cl_null(p_apbbcomp) OR cl_null(p_apbbdocno) THEN
      RETURN
   END IF

   LET r_apba103_s = ''
   LET r_apba104_s = ''
   LET r_apba105_s = ''
   LET r_apba113_s = ''
   LET r_apba114_s = ''
   LET r_apba115_s = ''

   IF cl_null(p_apbaseq) OR p_apbaseq = 0 THEN
      SELECT SUM(apba103*apba012),SUM(apba104*apba012),SUM(apba105*apba012),
             SUM(apba113*apba012),SUM(apba114*apba012),SUM(apba115*apba012)
        INTO r_apba103_s,r_apba104_s,r_apba105_s,
             r_apba113_s,r_apba114_s,r_apba115_s
        FROM apba_t INNER JOIN apbb_t ON apbbent = apbaent AND apbbdocno = apbadocno
       WHERE apbaent = g_enterprise AND apbadocno = p_apbbdocno AND (apba019 = 'Y' OR apba019 IS NULL) 
   ELSE
      SELECT SUM(apba103*apba012),SUM(apba104*apba012),SUM(apba105*apba012),
             SUM(apba113*apba012),SUM(apba114*apba012),SUM(apba115*apba012)
        INTO r_apba103_s,r_apba104_s,r_apba105_s,
             r_apba113_s,r_apba114_s,r_apba115_s
        FROM apba_t INNER JOIN apbb_t ON apbbent = apbaent AND apbbdocno = apbadocno
       WHERE apbaent = g_enterprise AND apbadocno = p_apbbdocno 
         AND (apba019 = 'Y' OR apba019 IS NULL) AND apbaseq <> p_apbaseq
   END IF

   IF cl_null(r_apba103_s) THEN LET r_apba103_s = 0 END IF
   IF cl_null(r_apba104_s) THEN LET r_apba104_s = 0 END IF
   IF cl_null(r_apba105_s) THEN LET r_apba105_s = 0 END IF
   IF cl_null(r_apba113_s) THEN LET r_apba113_s = 0 END IF
   IF cl_null(r_apba114_s) THEN LET r_apba114_s = 0 END IF
   IF cl_null(r_apba115_s) THEN LET r_apba115_s = 0 END IF

   #同發票主檔金額合計取位
   LET r_apba103_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba103_s,2)
   LET r_apba104_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba104_s,2)
   LET r_apba105_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba105_s,2)
   LET r_apba113_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba113_s,2)
   LET r_apba114_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba114_s,2)
   LET r_apba115_s = s_curr_round(g_site,g_apbb_m.apbb014,r_apba115_s,2)
   
   RETURN r_apba103_s,r_apba104_s,r_apba105_s,
          r_apba113_s,r_apba114_s,r_apba115_s
END FUNCTION

 
{</section>}
 
