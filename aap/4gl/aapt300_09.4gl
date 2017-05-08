#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_09.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2017-01-23 15:49:32), PR版次:0023(2017-02-15 19:00:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000159
#+ Filename...: aapt300_09
#+ Description: 直接付款
#+ Creator....: 03538(2015-03-02 11:47:18)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt300_09.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150128-00005#9  15/02/04   By apo      單身"款別性質" 1.隱藏ZZ.沖預收,增加90.其他類型,可不限制輸入來源單據號,亦不產生ANM資料,為自行輸入
#                                                     3.選擇90時,預設付款日期=TODAY,幣別=帳套本幣,匯率=1
#150205-00012#1             BY Hans     進欄位之後只顯示編號不顯示中文名稱
#150616-00026#3  15/06/16   By apo      直接付款一開啟畫面時說明沒有帶出,進入編輯狀態時才帶出
#150629-00028#1  15/06/29   By apo      預設付款單身資訊時,同時預設會計科目
#150916-00015#1  2015/12/7  By Xiaozg   1.快捷带出类似科目编号 2. 当有账套时，科目检查改为检查是否存在于glad_t中
#160114-00019#1  16/01/27   By albireo  付款日維持原本根據apde002付款類型開啟是否可輸入的原則,但可輸入時檢核與原帳款單日期會計期間是否相等,不相等則提示不卡住   
#160122-00001#5  2016/02/24 By 07673    添加交易账户编号用户权限控管
#160202-00021#2  2016/03/10 By 02097    受款人全名 apde041 欄位, 預設帶基本資料帳戶對應戶名 pmaf004
#160321-00016#21 2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息(sub部分)
#160324-00032#3  2016/03/30 By 03538    受款人全名不可異動;款別類型=30.票據類,apde041 帶付款對象全名,受款銀行及受款帳戶放空白;款別類型=10 或20,受款銀行及受款帳戶.受款人全名 預帶主要付款帳戶資料
#160318-00025#25 2016/04/26 BY 07900    校验代码重复错误讯息的修改
#160429-00010#1  2016/04/29 By 03538    交易銀行+帳戶的檢核,也應該加入交易對象當作key值
#160422-00021#1  2016/05/19 By 02097    增加信用状下拉选项
#160829-00004#1  2016/08/29 By 08729    處理取匯率但幣別取錯
#160905-00002#1  2016/09/05 By Reanna   SQL條件少ENT補上
#160908-00036#1  2016/09/08 By Reanna   資金中心開窗及檢核條件：1.歸屬法人同apcacomp/2.aooi100資金中心否=Y
#161006-00005#4  2016/10/12 By 08732    組織類型與職能開窗調整
#161104-00024#2  2016/11/10 By 08729    處理DEFINE有星號
#161109-00031#1  2016/11/17 By dorishsu 直接付款如付款類型=10,且款別性質 IN(10,20,30),則控卡"存提碼"(apde011)必需輸入
#161201-00029#1  2016/12/01 By Reanna   重展金額，若是aapt330的費用報支單，原幣金額應放本幣金額顯示
#161208-00026#7  2016/12/12 By 08729    針對SELECT有星號的部分進行展開
#170123-00036#1  170123     By albireo  匯兌時 原幣可為0不需檢核
#170203-00038#1  170207     By albireo  1.原幣為0時(匯兌差異時)不必連動檢本幣數值 2.金額檢核時,應依借貸別調整檢核內容
#170208-00033#1  170215     By 06821    直接付款时，录入了银行账户后，可修改币别。一个账户只有一个币别，所以，当账户不为空时，应不可修改币别。
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_apde_d RECORD
       apdedocno LIKE apde_t.apdedocno, 
   apdeld LIKE apde_t.apdeld, 
   apdeseq LIKE apde_t.apdeseq, 
   apdeorga LIKE apde_t.apdeorga, 
   apdeorga_desc LIKE type_t.chr500, 
   apde002 LIKE apde_t.apde002, 
   apde006 LIKE apde_t.apde006, 
   apde008 LIKE apde_t.apde008, 
   apde021 LIKE apde_t.apde021, 
   apde024 LIKE apde_t.apde024, 
   apde015 LIKE apde_t.apde015, 
   apde016 LIKE apde_t.apde016, 
   apde016_desc LIKE type_t.chr500, 
   apde100 LIKE apde_t.apde100, 
   apde109 LIKE apde_t.apde109, 
   apde101 LIKE apde_t.apde101, 
   apde119 LIKE apde_t.apde119, 
   apde032 LIKE apde_t.apde032, 
   apde013 LIKE apde_t.apde013, 
   apde013_desc LIKE type_t.chr500, 
   apde014 LIKE apde_t.apde014, 
   apde010 LIKE apde_t.apde010, 
   apde009 LIKE apde_t.apde009, 
   apde039 LIKE apde_t.apde039, 
   apde040 LIKE apde_t.apde040, 
   apde041 LIKE apde_t.apde041, 
   apde011 LIKE apde_t.apde011, 
   apde011_desc LIKE type_t.chr500, 
   apde012 LIKE apde_t.apde012, 
   apde012_desc LIKE type_t.chr500, 
   apdecomp LIKE apde_t.apdecomp, 
   apdesite LIKE apde_t.apdesite, 
   apde001 LIKE apde_t.apde001, 
   apde038 LIKE apde_t.apde038, 
   apde061 LIKE apde_t.apde061
       END RECORD
PRIVATE TYPE type_g_apde2_d RECORD
       apdedocno LIKE apde_t.apdedocno, 
   apdeld LIKE apde_t.apdeld, 
   apdeseq LIKE apde_t.apdeseq, 
   apde0022 LIKE type_t.chr10, 
   apde0152 LIKE type_t.chr1, 
   apde0162 LIKE type_t.chr500, 
   apde0162_desc LIKE type_t.chr500, 
   apde017 LIKE apde_t.apde017, 
   apde017_desc LIKE type_t.chr500, 
   apde018 LIKE apde_t.apde018, 
   apde018_desc LIKE type_t.chr500, 
   apde019 LIKE apde_t.apde019, 
   apde019_desc LIKE type_t.chr500, 
   apde020 LIKE apde_t.apde020, 
   apde020_desc LIKE type_t.chr500, 
   apde022 LIKE apde_t.apde022, 
   apde022_desc LIKE type_t.chr500, 
   apde023 LIKE apde_t.apde023, 
   apde023_desc LIKE type_t.chr500, 
   apde035 LIKE apde_t.apde035, 
   apde035_desc LIKE type_t.chr500, 
   apde036 LIKE apde_t.apde036, 
   apde036_desc LIKE type_t.chr500, 
   apde042 LIKE apde_t.apde042, 
   apde042_desc LIKE type_t.chr500, 
   apde043 LIKE apde_t.apde043, 
   apde043_desc LIKE type_t.chr500, 
   apde044 LIKE apde_t.apde044, 
   apde044_desc LIKE type_t.chr500, 
   apde051 LIKE apde_t.apde051, 
   apde051_desc LIKE type_t.chr500, 
   apde052 LIKE apde_t.apde052, 
   apde052_desc LIKE type_t.chr500, 
   apde053 LIKE apde_t.apde053, 
   apde053_desc LIKE type_t.chr500, 
   apde054 LIKE apde_t.apde054, 
   apde054_desc LIKE type_t.chr500, 
   apde055 LIKE apde_t.apde055, 
   apde055_desc LIKE type_t.chr500, 
   apde056 LIKE apde_t.apde056, 
   apde056_desc LIKE type_t.chr500, 
   apde057 LIKE apde_t.apde057, 
   apde057_desc LIKE type_t.chr500, 
   apde058 LIKE apde_t.apde058, 
   apde058_desc LIKE type_t.chr500, 
   apde059 LIKE apde_t.apde059, 
   apde059_desc LIKE type_t.chr500, 
   apde060 LIKE apde_t.apde060, 
   apde060_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_apde3_d RECORD
       apdedocno LIKE apde_t.apdedocno, 
   apdeld LIKE apde_t.apdeld, 
   apdeseq LIKE apde_t.apdeseq, 
   apde0023 LIKE type_t.chr10, 
   apde0063 LIKE type_t.chr10, 
   apde0083 LIKE type_t.chr20, 
   apde1003 LIKE type_t.chr10, 
   apde1093 LIKE type_t.num20_6, 
   apde1013 LIKE type_t.num26_10, 
   apde1193 LIKE type_t.num20_6, 
   apde120 LIKE apde_t.apde120, 
   apde121 LIKE apde_t.apde121, 
   apde129 LIKE apde_t.apde129, 
   apde130 LIKE apde_t.apde130, 
   apde131 LIKE apde_t.apde131, 
   apde139 LIKE apde_t.apde139
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apcald              LIKE apca_t.apcald
DEFINE g_apcadocno           LIKE apca_t.apcadocno
DEFINE l_lock_sw             LIKE type_t.chr1
DEFINE l_n                   LIKE type_t.num10
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE lb_reproduce          BOOLEAN
DEFINE li_reproduce          LIKE type_t.num5
DEFINE li_reproduce_target   LIKE type_t.num5
DEFINE g_ap_slip             LIKE ooba_t.ooba002           #應付帳款單單別
DEFINE g_sfin3008            LIKE type_t.chr80             #S-FIN-3008-付款單直接產生銀存支付帳
DEFINE g_sfin2002            LIKE type_t.chr80             #S-FIN-2002-應付沖銷參數
#總計頁簽
DEFINE g_apce_sum RECORD
                  apca100         LIKE apca_t.apca100,
                  glaa001         LIKE glaa_t.glaa001,
                  glaa016         LIKE glaa_t.glaa016,
                  glaa020         LIKE glaa_t.glaa020,
                  sum_apca103     LIKE apca_t.apca103,
                  sum_apca113     LIKE apca_t.apca113,
                  sum_apca123     LIKE apca_t.apca123,
                  sum_apca133     LIKE apca_t.apca133,
                  sum_apce1091    LIKE apce_t.apce109,
                  sum_apce1191    LIKE apce_t.apce119,
                  sum_apce1291    LIKE apce_t.apce129,
                  sum_apce1391    LIKE apce_t.apce139,
                  sum_apce1092    LIKE apce_t.apce109,
                  sum_apce1192    LIKE apce_t.apce119,
                  sum_apce1292    LIKE apce_t.apce129,
                  sum_apce1392    LIKE apce_t.apce139,
                  sum_apce1093    LIKE apce_t.apce109,
                  sum_apce1193    LIKE apce_t.apce119,
                  sum_apce1293    LIKE apce_t.apce129,
                  sum_apce1393    LIKE apce_t.apce139,                  
                  sum_apce1094    LIKE apce_t.apce109,
                  sum_apce1194    LIKE apce_t.apce119,
                  sum_apce1294    LIKE apce_t.apce129,
                  sum_apce1394    LIKE apce_t.apce139
                  END RECORD
DEFINE g_glaa     RECORD
                  glaald    LIKE glaa_t.glaald,
                  glaacomp  LIKE glaa_t.glaacomp,
                  glaa001   LIKE glaa_t.glaa001,
                  glaa004   LIKE glaa_t.glaa004,
                  glaa005   LIKE glaa_t.glaa005,
                  glaa015   LIKE glaa_t.glaa015,
                  glaa016   LIKE glaa_t.glaa016,
                  glaa017   LIKE glaa_t.glaa017,
                  glaa019   LIKE glaa_t.glaa019,
                  glaa020   LIKE glaa_t.glaa020,
                  glaa021   LIKE glaa_t.glaa021,
                  glaa024   LIKE glaa_t.glaa024,
                  glaa025   LIKE glaa_t.glaa025,
                  glaa026   LIKE glaa_t.glaa026,
                  glaa121   LIKE glaa_t.glaa121
                  END RECORD
DEFINE g_glad     RECORD
                  glad0171    LIKE  glad_t.glad0171, 
                  glad0172    LIKE  glad_t.glad0172,
                  glad0181    LIKE  glad_t.glad0181,
                  glad0182    LIKE  glad_t.glad0182,
                  glad0191    LIKE  glad_t.glad0191,
                  glad0192    LIKE  glad_t.glad0192,
                  glad0201    LIKE  glad_t.glad0201,
                  glad0202    LIKE  glad_t.glad0202,
                  glad0211    LIKE  glad_t.glad0211,
                  glad0212    LIKE  glad_t.glad0212,
                  glad0221    LIKE  glad_t.glad0221,
                  glad0222    LIKE  glad_t.glad0222,
                  glad0231    LIKE  glad_t.glad0231,
                  glad0232    LIKE  glad_t.glad0232,
                  glad0241    LIKE  glad_t.glad0241,
                  glad0242    LIKE  glad_t.glad0242,
                  glad0251    LIKE  glad_t.glad0251,
                  glad0252    LIKE  glad_t.glad0252,
                  glad0261    LIKE  glad_t.glad0261,
                  glad0262    LIKE  glad_t.glad0262
                  END RECORD
#DEFINE g_apca             RECORD LIKE apca_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE g_apca  RECORD  #應付憑單單頭
       apcaent   LIKE apca_t.apcaent, #企業編號
       apcaownid LIKE apca_t.apcaownid, #資料所有者
       apcaowndp LIKE apca_t.apcaowndp, #資料所有部門
       apcacrtid LIKE apca_t.apcacrtid, #資料建立者
       apcacrtdp LIKE apca_t.apcacrtdp, #資料建立部門
       apcacrtdt LIKE apca_t.apcacrtdt, #資料創建日
       apcamodid LIKE apca_t.apcamodid, #資料修改者
       apcamoddt LIKE apca_t.apcamoddt, #最近修改日
       apcacnfid LIKE apca_t.apcacnfid, #資料確認者
       apcacnfdt LIKE apca_t.apcacnfdt, #資料確認日
       apcapstid LIKE apca_t.apcapstid, #資料過帳者
       apcapstdt LIKE apca_t.apcapstdt, #資料過帳日
       apcastus  LIKE apca_t.apcastus, #狀態碼
       apcald    LIKE apca_t.apcald, #帳套
       apcacomp  LIKE apca_t.apcacomp, #法人
       apcadocno LIKE apca_t.apcadocno, #應付帳款單號碼
       apcadocdt LIKE apca_t.apcadocdt, #帳款日期
       apcasite  LIKE apca_t.apcasite, #帳務中心
       apca001   LIKE apca_t.apca001, #帳款單性質
       apca003   LIKE apca_t.apca003, #帳務人員
       apca004   LIKE apca_t.apca004, #帳款對象編號
       apca005   LIKE apca_t.apca005, #付款對象
       apca006   LIKE apca_t.apca006, #供應商分類
       apca007   LIKE apca_t.apca007, #帳款類別
       apca008   LIKE apca_t.apca008, #付款條件編號
       apca009   LIKE apca_t.apca009, #應付款日/應扣抵日
       apca010   LIKE apca_t.apca010, #容許票據到期日
       apca011   LIKE apca_t.apca011, #稅別
       apca012   LIKE apca_t.apca012, #稅率
       apca013   LIKE apca_t.apca013, #含稅否
       apca014   LIKE apca_t.apca014, #人員編號
       apca015   LIKE apca_t.apca015, #部門編號
       apca016   LIKE apca_t.apca016, #來源作業類型
       apca017   LIKE apca_t.apca017, #產生方式
       apca018   LIKE apca_t.apca018, #來源參考單號
       apca019   LIKE apca_t.apca019, #系統產生對應單號(待抵帳款-預付)
       apca020   LIKE apca_t.apca020, #信用狀付款否
       apca021   LIKE apca_t.apca021, #商業發票號碼(IV no.)
       apca022   LIKE apca_t.apca022, #進口報單號碼
       apca025   LIKE apca_t.apca025, #差異處理(發票與帳款差異)
       apca026   LIKE apca_t.apca026, #原幣未稅差異
       apca027   LIKE apca_t.apca027, #原幣稅額差異
       apca028   LIKE apca_t.apca028, #本幣未稅差異
       apca029   LIKE apca_t.apca029, #本幣幣稅額差異
       apca030   LIKE apca_t.apca030, #差異科目
       apca031   LIKE apca_t.apca031, #產生之差異折讓單號
       apca032   LIKE apca_t.apca032, #發票類型
       apca033   LIKE apca_t.apca033, #專案編號
       apca034   LIKE apca_t.apca034, #責任中心
       apca035   LIKE apca_t.apca035, #應付(貸方)科目編號
       apca036   LIKE apca_t.apca036, #費用(借方)科目編號
       apca037   LIKE apca_t.apca037, #產生傳票否
       apca038   LIKE apca_t.apca038, #拋轉傳票號碼
       apca039   LIKE apca_t.apca039, #會計檢核附件份數
       apca040   LIKE apca_t.apca040, #留置否
       apca041   LIKE apca_t.apca041, #留置理由碼
       apca042   LIKE apca_t.apca042, #留置設定日期
       apca043   LIKE apca_t.apca043, #留置解除日期
       apca044   LIKE apca_t.apca044, #留置原幣金額
       apca045   LIKE apca_t.apca045, #留置說明
       apca046   LIKE apca_t.apca046, #關係人否
       apca047   LIKE apca_t.apca047, #多角序號
       apca048   LIKE apca_t.apca048, #集團代付/代付單號
       apca049   LIKE apca_t.apca049, #來源營運中心編號
       apca050   LIKE apca_t.apca050, #交易原始單據份數
       apca051   LIKE apca_t.apca051, #作廢理由碼
       apca052   LIKE apca_t.apca052, #列印次數
       apca053   LIKE apca_t.apca053, #備註
       apca054   LIKE apca_t.apca054, #多帳期設定
       apca055   LIKE apca_t.apca055, #繳款優惠條件
       apca056   LIKE apca_t.apca056, #會計檢核附件狀態
       apca057   LIKE apca_t.apca057, #交易對象識別碼
       apca058   LIKE apca_t.apca058, #稅別交易類型
       apca059   LIKE apca_t.apca059, #預算編號
       apca060   LIKE apca_t.apca060, #發票開立方式
       apca061   LIKE apca_t.apca061, #預開發票基準日
       apca062   LIKE apca_t.apca062, #多角性質
       apca063   LIKE apca_t.apca063, #整帳批序號
       apca064   LIKE apca_t.apca064, #訂金序次
       apca065   LIKE apca_t.apca065, #發票編號
       apca066   LIKE apca_t.apca066, #發票號碼
       apca100   LIKE apca_t.apca100, #交易原幣別
       apca101   LIKE apca_t.apca101, #原幣匯率
       apca103   LIKE apca_t.apca103, #原幣未稅金額
       apca104   LIKE apca_t.apca104, #原幣稅額
       apca106   LIKE apca_t.apca106, #原幣應稅折抵合計金額
       apca107   LIKE apca_t.apca107, #NO USE
       apca108   LIKE apca_t.apca108, #原幣應付金額
       apca113   LIKE apca_t.apca113, #本幣未稅金額
       apca114   LIKE apca_t.apca114, #本幣稅額
       apca116   LIKE apca_t.apca116, #本幣應稅折抵合計金額
       apca117   LIKE apca_t.apca117, #NO USE
       apca118   LIKE apca_t.apca118, #本幣應付金額
       apca120   LIKE apca_t.apca120, #本位幣二幣別
       apca121   LIKE apca_t.apca121, #本位幣二匯率
       apca123   LIKE apca_t.apca123, #本位幣二未稅金額
       apca124   LIKE apca_t.apca124, #本位幣二稅額
       apca126   LIKE apca_t.apca126, #本位幣二應稅折抵合計金額
       apca127   LIKE apca_t.apca127, #NO USE
       apca128   LIKE apca_t.apca128, #本位幣二應付金額
       apca130   LIKE apca_t.apca130, #本位幣三幣別
       apca131   LIKE apca_t.apca131, #本位幣三匯率
       apca133   LIKE apca_t.apca133, #本位幣三未稅金額
       apca134   LIKE apca_t.apca134, #本位幣三稅額
       apca136   LIKE apca_t.apca136, #本位幣三應稅折抵合計金額
       apca137   LIKE apca_t.apca137, #NO USE
       apca138   LIKE apca_t.apca138, #本位幣三應付金額
       apcaud001 LIKE apca_t.apcaud001, #自定義欄位(文字)001
       apcaud002 LIKE apca_t.apcaud002, #自定義欄位(文字)002
       apcaud003 LIKE apca_t.apcaud003, #自定義欄位(文字)003
       apcaud004 LIKE apca_t.apcaud004, #自定義欄位(文字)004
       apcaud005 LIKE apca_t.apcaud005, #自定義欄位(文字)005
       apcaud006 LIKE apca_t.apcaud006, #自定義欄位(文字)006
       apcaud007 LIKE apca_t.apcaud007, #自定義欄位(文字)007
       apcaud008 LIKE apca_t.apcaud008, #自定義欄位(文字)008
       apcaud009 LIKE apca_t.apcaud009, #自定義欄位(文字)009
       apcaud010 LIKE apca_t.apcaud010, #自定義欄位(文字)010
       apcaud011 LIKE apca_t.apcaud011, #自定義欄位(數字)011
       apcaud012 LIKE apca_t.apcaud012, #自定義欄位(數字)012
       apcaud013 LIKE apca_t.apcaud013, #自定義欄位(數字)013
       apcaud014 LIKE apca_t.apcaud014, #自定義欄位(數字)014
       apcaud015 LIKE apca_t.apcaud015, #自定義欄位(數字)015
       apcaud016 LIKE apca_t.apcaud016, #自定義欄位(數字)016
       apcaud017 LIKE apca_t.apcaud017, #自定義欄位(數字)017
       apcaud018 LIKE apca_t.apcaud018, #自定義欄位(數字)018
       apcaud019 LIKE apca_t.apcaud019, #自定義欄位(數字)019
       apcaud020 LIKE apca_t.apcaud020, #自定義欄位(數字)020
       apcaud021 LIKE apca_t.apcaud021, #自定義欄位(日期時間)021
       apcaud022 LIKE apca_t.apcaud022, #自定義欄位(日期時間)022
       apcaud023 LIKE apca_t.apcaud023, #自定義欄位(日期時間)023
       apcaud024 LIKE apca_t.apcaud024, #自定義欄位(日期時間)024
       apcaud025 LIKE apca_t.apcaud025, #自定義欄位(日期時間)025
       apcaud026 LIKE apca_t.apcaud026, #自定義欄位(日期時間)026
       apcaud027 LIKE apca_t.apcaud027, #自定義欄位(日期時間)027
       apcaud028 LIKE apca_t.apcaud028, #自定義欄位(日期時間)028
       apcaud029 LIKE apca_t.apcaud029, #自定義欄位(日期時間)029
       apcaud030 LIKE apca_t.apcaud030, #自定義欄位(日期時間)030
       apca067   LIKE apca_t.apca067, #管理品類
       apca068   LIKE apca_t.apca068, #經營方式
       apca069   LIKE apca_t.apca069, #no use
       apca070   LIKE apca_t.apca070, #no use
       apca071   LIKE apca_t.apca071, #no use
       apca072   LIKE apca_t.apca072, #no use
       apca073   LIKE apca_t.apca073  #信用狀申請單號
           END RECORD
#161104-00024#2-add(e)
DEFINE g_dfin0030            LIKE type_t.chr1

DEFINE g_sql_bank       STRING #160122-00001#5 add by07675
DEFINE g_wc_cs_orga     STRING   #161006-00005#4   add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apde_d          DYNAMIC ARRAY OF type_g_apde_d #單身變數
DEFINE g_apde_d_t        type_g_apde_d                  #單身備份
DEFINE g_apde_d_o        type_g_apde_d                  #單身備份
DEFINE g_apde_d_mask_o   DYNAMIC ARRAY OF type_g_apde_d #單身變數
DEFINE g_apde_d_mask_n   DYNAMIC ARRAY OF type_g_apde_d #單身變數
DEFINE g_apde2_d   DYNAMIC ARRAY OF type_g_apde2_d
DEFINE g_apde2_d_t type_g_apde2_d
DEFINE g_apde2_d_o type_g_apde2_d
DEFINE g_apde2_d_mask_o DYNAMIC ARRAY OF type_g_apde2_d
DEFINE g_apde2_d_mask_n DYNAMIC ARRAY OF type_g_apde2_d
DEFINE g_apde3_d   DYNAMIC ARRAY OF type_g_apde3_d
DEFINE g_apde3_d_t type_g_apde3_d
DEFINE g_apde3_d_o type_g_apde3_d
DEFINE g_apde3_d_mask_o DYNAMIC ARRAY OF type_g_apde3_d
DEFINE g_apde3_d_mask_n DYNAMIC ARRAY OF type_g_apde3_d
 
      
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
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt300_09.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aapt300_09(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_apcald,
   p_apcadocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_apcald         LIKE apca_t.apcald
   DEFINE p_apcadocno      LIKE apca_t.apcadocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   IF cl_null(p_apcald) OR cl_null(p_apcadocno) THEN
      RETURN
   ELSE
      LET g_apcald = p_apcald
      LET g_apcadocno = p_apcadocno
   END IF   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   #應付單頭LOCK CURSOR
#   LET g_sql = "SELECT * FROM apca_t ",   #161208-00026#7 mark
   #161208-00026#7-add(s)
   LET g_sql = "SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,
                       apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt,
                       apcapstid,apcapstdt,apcastus,apcald,apcacomp,
                       apcadocno,apcadocdt,apcasite,apca001,apca003,
                       apca004,apca005,apca006,apca007,apca008,
                       apca009,apca010,apca011,apca012,apca013,
                       apca014,apca015,apca016,apca017,apca018,
                       apca019,apca020,apca021,apca022,apca025,
                       apca026,apca027,apca028,apca029,apca030,
                       apca031,apca032,apca033,apca034,apca035,
                       apca036,apca037,apca038,apca039,apca040,
                       apca041,apca042,apca043,apca044,apca045,
                       apca046,apca047,apca048,apca049,apca050,
                       apca051,apca052,apca053,apca054,apca055,
                       apca056,apca057,apca058,apca059,apca060,
                       apca061,apca062,apca063,apca064,apca065,
                       apca066,apca100,apca101,apca103,apca104,
                       apca106,apca107,apca108,apca113,apca114,
                       apca116,apca117,apca118,apca120,apca121,
                       apca123,apca124,apca126,apca127,apca128,
                       apca130,apca131,apca133,apca134,apca136,
                       apca137,apca138,apcaud001,apcaud002,apcaud003,
                       apcaud004,apcaud005,apcaud006,apcaud007,apcaud008,
                       apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,
                       apcaud014,apcaud015,apcaud016,apcaud017,apcaud018,
                       apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,
                       apcaud024,apcaud025,apcaud026,apcaud027,apcaud028,
                       apcaud029,apcaud030,apca067,apca068,apca069,
                       apca070,apca071,apca072,apca073 
                  FROM apca_t ",
   #161208-00026#7-add(e)
               " WHERE apcaent = ? AND apcald = ? AND apcadocno = ? ",
               "   FOR UPDATE "
   LET g_sql = cl_sql_forupd(g_sql)
   DECLARE aapt300_09_cl CURSOR FROM g_sql
   #end add-point 
   LET g_forupd_sql = "SELECT apdedocno,apdeld,apdeseq,apdeorga,apde002,apde006,apde008,apde021,apde024, 
       apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010,apde009,apde039, 
       apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038,apde061,apdedocno,apdeld,apdeseq, 
       apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051, 
       apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apdedocno,apdeld,apdeseq, 
       apde120,apde121,apde129,apde130,apde131,apde139 FROM apde_t WHERE apdeent=? AND apdeld=? AND  
       apdedocno=? AND apdeseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt300_09_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_09 WITH FORM cl_ap_formpath("aap","aapt300_09")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aapt300_09_init()   
 
   #進入選單 Menu (="N")
   CALL aapt300_09_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aapt300_09
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_09.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapt300_09_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str            STRING
   DEFINE l_ap_slip        LIKE apca_t.apcadocno
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #160122-00001#5--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5--add--end
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   
   #根據傳入參數抓取資料應付單頭資料
   INITIALIZE g_apca.* TO NULL
   #SELECT * INTO g_apca.* FROM apca_t   #161208-00026#7 mark
   #161208-00026#7-add(s)
   SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,
          apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt,
          apcapstid,apcapstdt,apcastus,apcald,apcacomp,
          apcadocno,apcadocdt,apcasite,apca001,apca003,
          apca004,apca005,apca006,apca007,apca008,
          apca009,apca010,apca011,apca012,apca013,
          apca014,apca015,apca016,apca017,apca018,
          apca019,apca020,apca021,apca022,apca025,
          apca026,apca027,apca028,apca029,apca030,
          apca031,apca032,apca033,apca034,apca035,
          apca036,apca037,apca038,apca039,apca040,
          apca041,apca042,apca043,apca044,apca045,
          apca046,apca047,apca048,apca049,apca050,
          apca051,apca052,apca053,apca054,apca055,
          apca056,apca057,apca058,apca059,apca060,
          apca061,apca062,apca063,apca064,apca065,
          apca066,apca100,apca101,apca103,apca104,
          apca106,apca107,apca108,apca113,apca114,
          apca116,apca117,apca118,apca120,apca121,
          apca123,apca124,apca126,apca127,apca128,
          apca130,apca131,apca133,apca134,apca136,
          apca137,apca138,apcaud001,apcaud002,apcaud003,
          apcaud004,apcaud005,apcaud006,apcaud007,apcaud008,
          apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,
          apcaud014,apcaud015,apcaud016,apcaud017,apcaud018,
          apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,
          apcaud024,apcaud025,apcaud026,apcaud027,apcaud028,
          apcaud029,apcaud030,apca067,apca068,apca069,
          apca070,apca071,apca072,apca073 
     INTO g_apca.* 
     FROM apca_t
   #161208-00026#7-add(e)
    WHERE apcaent = g_enterprise
      AND apcald = g_apcald AND apcadocno = g_apcadocno

   #取得參數
   CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-3008') RETURNING g_sfin3008  #應付產生銀存支付帳否
   CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-2002') RETURNING g_sfin2002  #應付沖銷參數
   
   #取得帳別相關資訊
   CALL s_ld_sel_glaa(g_apcald,'glaald|glaacomp|glaa001|glaa004|glaa005|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024|glaa025|glaa026|glaa121')
        RETURNING g_sub_success,g_glaa.*
   CALL s_aooi200_fin_get_slip(g_apcadocno) RETURNING g_sub_success,l_ap_slip
   CALL s_fin_get_doc_para(g_apcald,g_apca.apcacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
   IF g_glaa.glaa015 = 'Y' OR g_glaa.glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
      IF g_glaa.glaa015 = 'Y' THEN
         CALL cl_set_comp_visible('apde120,apde121,apde129',TRUE)
         CALL cl_set_comp_visible('glaa016,sum_apca123,sum_apce1291,sum_apce1292,sum_apce1293,sum_apce1294',TRUE)
      END IF
      IF g_glaa.glaa019 = 'Y' THEN
         CALL cl_set_comp_visible('apde130,apde131,apde139',TRUE)
         CALL cl_set_comp_visible('glaa020,sum_apca133,sum_apce1391,sum_apce1392,sum_apce1393,sum_apce1394',TRUE)
      END IF
   END IF
   #付款明細單身
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '2' AND gzcb002 NOT IN('16','17','21','22') ") CLIPPED
   CALL cl_set_combo_scc_part('apde002','8506',l_str)
   CALL cl_set_combo_scc_part('apde0022','8506',l_str)
   CALL cl_set_combo_scc_part('apde0023','8506',l_str)
   #150128-00005#9--(s)
   LET l_str = s_aap_get_acc_str('8310',"gzcb002 <> 'ZZ' ") CLIPPED
   CALL cl_set_combo_scc_part('apde006','8310',l_str)
   CALL cl_set_combo_scc_part('apde0063','8310',l_str)
   #150128-00005#9--(e)
   #160422-00021#1--(S)
   IF g_prog = 'aapt560' THEN
      CALL cl_set_comp_visible('apde061',TRUE)
      CALL cl_set_combo_scc('apde061','8540')
   ELSE
      CALL cl_set_comp_visible('apde061',FALSE)
   END IF
   #160422-00021#1--(E)
   #本位幣二、三相關欄位預設隱藏,後續判斷是否使用才開啟
   CALL cl_set_comp_visible('page_2',FALSE)
   CALL cl_set_comp_visible('apde120,apde121,apde129',FALSE)
   CALL cl_set_comp_visible('apde130,apde131,apde139',FALSE)
   CALL cl_set_comp_visible('glaa016,sum_apca123,sum_apce1291,sum_apce1292,sum_apce1293,sum_apce1294',FALSE)
   CALL cl_set_comp_visible('glaa020,sum_apca133,sum_apce1391,sum_apce1392,sum_apce1393,sum_apce1394',FALSE)
   #其他訊息
   CALL cl_set_combo_scc('apde042','6013')
   CALL cl_set_combo_scc('apde042_desc','6013')
   
   CALL s_fin_azzi800_sons_query(g_today)                        #161006-00005#4  add
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga   #161006-00005#4  add
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga    #161006-00005#4  add
   #end add-point
   
   CALL aapt300_09_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapt300_09_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apde_d.clear()
         CALL g_apde2_d.clear()
         CALL g_apde3_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapt300_09_init()
      END IF
   
      CALL aapt300_09_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apde_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapt300_09_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_apde2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapt300_09_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_apde3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body3.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body3.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapt300_09_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row3"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL DIALOG.setSelectionMode("s_detail3", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            CALL cl_set_act_visible("logistics", FALSE)
            IF g_apca.apcastus NOT MATCHES "[N]" THEN   
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
            END IF     
            #160225-00001#1--(S)
            IF NOT cl_null(g_apca.apcadocno) THEN
               CALL s_aooi200_fin_get_slip(g_apca.apcadocno) RETURNING g_sub_success,l_slip
               CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
               CALL s_fin_date_close_chk('@',g_apca.apcacomp,'AAP',g_apca.apcadocdt) RETURNING g_sub_success
               IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
                  CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
               END IF
            END IF
            #160225-00001#1--(E)               
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapt300_09_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_09_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapt300_09_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_09_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapt300_09_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_09_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt300_09_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apde_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_apde2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_apde3_d)
               LET g_export_id[3]   = "s_detail3"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt300_09_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt300_09_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt300_09_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt300_09_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apde_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON apdedocno,apdeld,apdeseq,apdeorga,apde002,apde006,apde008,apde021,apde024,apde015, 
          apde016,apde016_desc,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010,apde009, 
          apde039,apde040,apde041,apde011,apde012,apde061,apde0162,apde0162_desc,apde017,apde017_desc, 
          apde018,apde018_desc,apde019,apde019_desc,apde020,apde020_desc,apde022,apde022_desc,apde023, 
          apde023_desc,apde035,apde035_desc,apde036,apde036_desc,apde042,apde042_desc,apde043,apde043_desc, 
          apde044,apde044_desc,apde051,apde051_desc,apde052,apde052_desc,apde053,apde053_desc,apde054, 
          apde054_desc,apde055,apde055_desc,apde056,apde056_desc,apde057,apde057_desc,apde058,apde058_desc, 
          apde059,apde059_desc,apde060,apde060_desc,apde121,apde129,apde131,apde139 
 
         FROM s_detail1[1].apdedocno,s_detail1[1].apdeld,s_detail1[1].apdeseq,s_detail1[1].apdeorga, 
             s_detail1[1].apde002,s_detail1[1].apde006,s_detail1[1].apde008,s_detail1[1].apde021,s_detail1[1].apde024, 
             s_detail1[1].apde015,s_detail1[1].apde016,s_detail1[1].apde016_desc,s_detail1[1].apde100, 
             s_detail1[1].apde109,s_detail1[1].apde101,s_detail1[1].apde119,s_detail1[1].apde032,s_detail1[1].apde013, 
             s_detail1[1].apde014,s_detail1[1].apde010,s_detail1[1].apde009,s_detail1[1].apde039,s_detail1[1].apde040, 
             s_detail1[1].apde041,s_detail1[1].apde011,s_detail1[1].apde012,s_detail1[1].apde061,s_detail2[1].apde0162, 
             s_detail2[1].apde0162_desc,s_detail2[1].apde017,s_detail2[1].apde017_desc,s_detail2[1].apde018, 
             s_detail2[1].apde018_desc,s_detail2[1].apde019,s_detail2[1].apde019_desc,s_detail2[1].apde020, 
             s_detail2[1].apde020_desc,s_detail2[1].apde022,s_detail2[1].apde022_desc,s_detail2[1].apde023, 
             s_detail2[1].apde023_desc,s_detail2[1].apde035,s_detail2[1].apde035_desc,s_detail2[1].apde036, 
             s_detail2[1].apde036_desc,s_detail2[1].apde042,s_detail2[1].apde042_desc,s_detail2[1].apde043, 
             s_detail2[1].apde043_desc,s_detail2[1].apde044,s_detail2[1].apde044_desc,s_detail2[1].apde051, 
             s_detail2[1].apde051_desc,s_detail2[1].apde052,s_detail2[1].apde052_desc,s_detail2[1].apde053, 
             s_detail2[1].apde053_desc,s_detail2[1].apde054,s_detail2[1].apde054_desc,s_detail2[1].apde055, 
             s_detail2[1].apde055_desc,s_detail2[1].apde056,s_detail2[1].apde056_desc,s_detail2[1].apde057, 
             s_detail2[1].apde057_desc,s_detail2[1].apde058,s_detail2[1].apde058_desc,s_detail2[1].apde059, 
             s_detail2[1].apde059_desc,s_detail2[1].apde060,s_detail2[1].apde060_desc,s_detail3[1].apde121, 
             s_detail3[1].apde129,s_detail3[1].apde131,s_detail3[1].apde139 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdedocno
            #add-point:BEFORE FIELD apdedocno name="query.b.page1.apdedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdedocno
            
            #add-point:AFTER FIELD apdedocno name="query.a.page1.apdedocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apdedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdedocno
            #add-point:ON ACTION controlp INFIELD apdedocno name="query.c.page1.apdedocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeld
            #add-point:BEFORE FIELD apdeld name="query.b.page1.apdeld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeld
            
            #add-point:AFTER FIELD apdeld name="query.a.page1.apdeld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeld
            #add-point:ON ACTION controlp INFIELD apdeld name="query.c.page1.apdeld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeseq
            #add-point:BEFORE FIELD apdeseq name="query.b.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeseq
            
            #add-point:AFTER FIELD apdeseq name="query.a.page1.apdeseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apdeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeseq
            #add-point:ON ACTION controlp INFIELD apdeseq name="query.c.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeorga
            #add-point:BEFORE FIELD apdeorga name="query.b.page1.apdeorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeorga
            
            #add-point:AFTER FIELD apdeorga name="query.a.page1.apdeorga"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apdeorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeorga
            #add-point:ON ACTION controlp INFIELD apdeorga name="query.c.page1.apdeorga"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="query.b.page1.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="query.a.page1.apde002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="query.c.page1.apde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde006
            #add-point:BEFORE FIELD apde006 name="query.b.page1.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="query.a.page1.apde006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="query.c.page1.apde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="query.b.page1.apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="query.a.page1.apde008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="query.c.page1.apde008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde021
            #add-point:BEFORE FIELD apde021 name="query.b.page1.apde021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde021
            
            #add-point:AFTER FIELD apde021 name="query.a.page1.apde021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde021
            #add-point:ON ACTION controlp INFIELD apde021 name="query.c.page1.apde021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde024
            #add-point:BEFORE FIELD apde024 name="query.b.page1.apde024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde024
            
            #add-point:AFTER FIELD apde024 name="query.a.page1.apde024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde024
            #add-point:ON ACTION controlp INFIELD apde024 name="query.c.page1.apde024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde015
            #add-point:BEFORE FIELD apde015 name="query.b.page1.apde015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde015
            
            #add-point:AFTER FIELD apde015 name="query.a.page1.apde015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde015
            #add-point:ON ACTION controlp INFIELD apde015 name="query.c.page1.apde015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016
            #add-point:BEFORE FIELD apde016 name="query.b.page1.apde016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016
            
            #add-point:AFTER FIELD apde016 name="query.a.page1.apde016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016
            #add-point:ON ACTION controlp INFIELD apde016 name="query.c.page1.apde016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016_desc
            #add-point:BEFORE FIELD apde016_desc name="query.b.page1.apde016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016_desc
            
            #add-point:AFTER FIELD apde016_desc name="query.a.page1.apde016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016_desc
            #add-point:ON ACTION controlp INFIELD apde016_desc name="query.c.page1.apde016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="query.b.page1.apde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="query.a.page1.apde100"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="query.c.page1.apde100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="query.b.page1.apde109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            
            #add-point:AFTER FIELD apde109 name="query.a.page1.apde109"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="query.c.page1.apde109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde101
            #add-point:BEFORE FIELD apde101 name="query.b.page1.apde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde101
            
            #add-point:AFTER FIELD apde101 name="query.a.page1.apde101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde101
            #add-point:ON ACTION controlp INFIELD apde101 name="query.c.page1.apde101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde119
            #add-point:BEFORE FIELD apde119 name="query.b.page1.apde119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde119
            
            #add-point:AFTER FIELD apde119 name="query.a.page1.apde119"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde119
            #add-point:ON ACTION controlp INFIELD apde119 name="query.c.page1.apde119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="query.b.page1.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="query.a.page1.apde032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="query.c.page1.apde032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde013
            #add-point:BEFORE FIELD apde013 name="query.b.page1.apde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde013
            
            #add-point:AFTER FIELD apde013 name="query.a.page1.apde013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde013
            #add-point:ON ACTION controlp INFIELD apde013 name="query.c.page1.apde013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde014
            #add-point:BEFORE FIELD apde014 name="query.b.page1.apde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde014
            
            #add-point:AFTER FIELD apde014 name="query.a.page1.apde014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde014
            #add-point:ON ACTION controlp INFIELD apde014 name="query.c.page1.apde014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="query.b.page1.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="query.a.page1.apde010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="query.c.page1.apde010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde009
            #add-point:BEFORE FIELD apde009 name="query.b.page1.apde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde009
            
            #add-point:AFTER FIELD apde009 name="query.a.page1.apde009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde009
            #add-point:ON ACTION controlp INFIELD apde009 name="query.c.page1.apde009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde039
            #add-point:BEFORE FIELD apde039 name="query.b.page1.apde039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde039
            
            #add-point:AFTER FIELD apde039 name="query.a.page1.apde039"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde039
            #add-point:ON ACTION controlp INFIELD apde039 name="query.c.page1.apde039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde040
            #add-point:BEFORE FIELD apde040 name="query.b.page1.apde040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde040
            
            #add-point:AFTER FIELD apde040 name="query.a.page1.apde040"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde040
            #add-point:ON ACTION controlp INFIELD apde040 name="query.c.page1.apde040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde041
            #add-point:BEFORE FIELD apde041 name="query.b.page1.apde041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde041
            
            #add-point:AFTER FIELD apde041 name="query.a.page1.apde041"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde041
            #add-point:ON ACTION controlp INFIELD apde041 name="query.c.page1.apde041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="query.b.page1.apde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="query.a.page1.apde011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="query.c.page1.apde011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="query.b.page1.apde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="query.a.page1.apde012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="query.c.page1.apde012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde061
            #add-point:BEFORE FIELD apde061 name="query.b.page1.apde061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde061
            
            #add-point:AFTER FIELD apde061 name="query.a.page1.apde061"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apde061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde061
            #add-point:ON ACTION controlp INFIELD apde061 name="query.c.page1.apde061"
            
            #END add-point
 
 
  
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde0162
            #add-point:BEFORE FIELD apde0162 name="query.b.page2.apde0162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde0162
            
            #add-point:AFTER FIELD apde0162 name="query.a.page2.apde0162"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde0162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde0162
            #add-point:ON ACTION controlp INFIELD apde0162 name="query.c.page2.apde0162"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde0162_desc
            #add-point:BEFORE FIELD apde0162_desc name="query.b.page2.apde0162_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde0162_desc
            
            #add-point:AFTER FIELD apde0162_desc name="query.a.page2.apde0162_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde0162_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde0162_desc
            #add-point:ON ACTION controlp INFIELD apde0162_desc name="query.c.page2.apde0162_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="query.b.page2.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="query.a.page2.apde017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="query.c.page2.apde017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017_desc
            #add-point:BEFORE FIELD apde017_desc name="query.b.page2.apde017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017_desc
            
            #add-point:AFTER FIELD apde017_desc name="query.a.page2.apde017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017_desc
            #add-point:ON ACTION controlp INFIELD apde017_desc name="query.c.page2.apde017_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="query.b.page2.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="query.a.page2.apde018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="query.c.page2.apde018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018_desc
            #add-point:BEFORE FIELD apde018_desc name="query.b.page2.apde018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018_desc
            
            #add-point:AFTER FIELD apde018_desc name="query.a.page2.apde018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018_desc
            #add-point:ON ACTION controlp INFIELD apde018_desc name="query.c.page2.apde018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="query.b.page2.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="query.a.page2.apde019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="query.c.page2.apde019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019_desc
            #add-point:BEFORE FIELD apde019_desc name="query.b.page2.apde019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019_desc
            
            #add-point:AFTER FIELD apde019_desc name="query.a.page2.apde019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019_desc
            #add-point:ON ACTION controlp INFIELD apde019_desc name="query.c.page2.apde019_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020
            #add-point:BEFORE FIELD apde020 name="query.b.page2.apde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020
            
            #add-point:AFTER FIELD apde020 name="query.a.page2.apde020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020
            #add-point:ON ACTION controlp INFIELD apde020 name="query.c.page2.apde020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020_desc
            #add-point:BEFORE FIELD apde020_desc name="query.b.page2.apde020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020_desc
            
            #add-point:AFTER FIELD apde020_desc name="query.a.page2.apde020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020_desc
            #add-point:ON ACTION controlp INFIELD apde020_desc name="query.c.page2.apde020_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022
            #add-point:BEFORE FIELD apde022 name="query.b.page2.apde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022
            
            #add-point:AFTER FIELD apde022 name="query.a.page2.apde022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022
            #add-point:ON ACTION controlp INFIELD apde022 name="query.c.page2.apde022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022_desc
            #add-point:BEFORE FIELD apde022_desc name="query.b.page2.apde022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022_desc
            
            #add-point:AFTER FIELD apde022_desc name="query.a.page2.apde022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022_desc
            #add-point:ON ACTION controlp INFIELD apde022_desc name="query.c.page2.apde022_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023
            #add-point:BEFORE FIELD apde023 name="query.b.page2.apde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023
            
            #add-point:AFTER FIELD apde023 name="query.a.page2.apde023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023
            #add-point:ON ACTION controlp INFIELD apde023 name="query.c.page2.apde023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023_desc
            #add-point:BEFORE FIELD apde023_desc name="query.b.page2.apde023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023_desc
            
            #add-point:AFTER FIELD apde023_desc name="query.a.page2.apde023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023_desc
            #add-point:ON ACTION controlp INFIELD apde023_desc name="query.c.page2.apde023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035
            #add-point:BEFORE FIELD apde035 name="query.b.page2.apde035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035
            
            #add-point:AFTER FIELD apde035 name="query.a.page2.apde035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035
            #add-point:ON ACTION controlp INFIELD apde035 name="query.c.page2.apde035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035_desc
            #add-point:BEFORE FIELD apde035_desc name="query.b.page2.apde035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035_desc
            
            #add-point:AFTER FIELD apde035_desc name="query.a.page2.apde035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035_desc
            #add-point:ON ACTION controlp INFIELD apde035_desc name="query.c.page2.apde035_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036
            #add-point:BEFORE FIELD apde036 name="query.b.page2.apde036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036
            
            #add-point:AFTER FIELD apde036 name="query.a.page2.apde036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036
            #add-point:ON ACTION controlp INFIELD apde036 name="query.c.page2.apde036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036_desc
            #add-point:BEFORE FIELD apde036_desc name="query.b.page2.apde036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036_desc
            
            #add-point:AFTER FIELD apde036_desc name="query.a.page2.apde036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036_desc
            #add-point:ON ACTION controlp INFIELD apde036_desc name="query.c.page2.apde036_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042
            #add-point:BEFORE FIELD apde042 name="query.b.page2.apde042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042
            
            #add-point:AFTER FIELD apde042 name="query.a.page2.apde042"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042
            #add-point:ON ACTION controlp INFIELD apde042 name="query.c.page2.apde042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042_desc
            #add-point:BEFORE FIELD apde042_desc name="query.b.page2.apde042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042_desc
            
            #add-point:AFTER FIELD apde042_desc name="query.a.page2.apde042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042_desc
            #add-point:ON ACTION controlp INFIELD apde042_desc name="query.c.page2.apde042_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043
            #add-point:BEFORE FIELD apde043 name="query.b.page2.apde043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043
            
            #add-point:AFTER FIELD apde043 name="query.a.page2.apde043"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043
            #add-point:ON ACTION controlp INFIELD apde043 name="query.c.page2.apde043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043_desc
            #add-point:BEFORE FIELD apde043_desc name="query.b.page2.apde043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043_desc
            
            #add-point:AFTER FIELD apde043_desc name="query.a.page2.apde043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043_desc
            #add-point:ON ACTION controlp INFIELD apde043_desc name="query.c.page2.apde043_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044
            #add-point:BEFORE FIELD apde044 name="query.b.page2.apde044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044
            
            #add-point:AFTER FIELD apde044 name="query.a.page2.apde044"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044
            #add-point:ON ACTION controlp INFIELD apde044 name="query.c.page2.apde044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044_desc
            #add-point:BEFORE FIELD apde044_desc name="query.b.page2.apde044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044_desc
            
            #add-point:AFTER FIELD apde044_desc name="query.a.page2.apde044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044_desc
            #add-point:ON ACTION controlp INFIELD apde044_desc name="query.c.page2.apde044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051
            #add-point:BEFORE FIELD apde051 name="query.b.page2.apde051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051
            
            #add-point:AFTER FIELD apde051 name="query.a.page2.apde051"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051
            #add-point:ON ACTION controlp INFIELD apde051 name="query.c.page2.apde051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051_desc
            #add-point:BEFORE FIELD apde051_desc name="query.b.page2.apde051_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051_desc
            
            #add-point:AFTER FIELD apde051_desc name="query.a.page2.apde051_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde051_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051_desc
            #add-point:ON ACTION controlp INFIELD apde051_desc name="query.c.page2.apde051_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052
            #add-point:BEFORE FIELD apde052 name="query.b.page2.apde052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052
            
            #add-point:AFTER FIELD apde052 name="query.a.page2.apde052"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052
            #add-point:ON ACTION controlp INFIELD apde052 name="query.c.page2.apde052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052_desc
            #add-point:BEFORE FIELD apde052_desc name="query.b.page2.apde052_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052_desc
            
            #add-point:AFTER FIELD apde052_desc name="query.a.page2.apde052_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde052_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052_desc
            #add-point:ON ACTION controlp INFIELD apde052_desc name="query.c.page2.apde052_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053
            #add-point:BEFORE FIELD apde053 name="query.b.page2.apde053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053
            
            #add-point:AFTER FIELD apde053 name="query.a.page2.apde053"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053
            #add-point:ON ACTION controlp INFIELD apde053 name="query.c.page2.apde053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053_desc
            #add-point:BEFORE FIELD apde053_desc name="query.b.page2.apde053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053_desc
            
            #add-point:AFTER FIELD apde053_desc name="query.a.page2.apde053_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde053_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053_desc
            #add-point:ON ACTION controlp INFIELD apde053_desc name="query.c.page2.apde053_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054
            #add-point:BEFORE FIELD apde054 name="query.b.page2.apde054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054
            
            #add-point:AFTER FIELD apde054 name="query.a.page2.apde054"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054
            #add-point:ON ACTION controlp INFIELD apde054 name="query.c.page2.apde054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054_desc
            #add-point:BEFORE FIELD apde054_desc name="query.b.page2.apde054_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054_desc
            
            #add-point:AFTER FIELD apde054_desc name="query.a.page2.apde054_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde054_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054_desc
            #add-point:ON ACTION controlp INFIELD apde054_desc name="query.c.page2.apde054_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055
            #add-point:BEFORE FIELD apde055 name="query.b.page2.apde055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055
            
            #add-point:AFTER FIELD apde055 name="query.a.page2.apde055"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055
            #add-point:ON ACTION controlp INFIELD apde055 name="query.c.page2.apde055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055_desc
            #add-point:BEFORE FIELD apde055_desc name="query.b.page2.apde055_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055_desc
            
            #add-point:AFTER FIELD apde055_desc name="query.a.page2.apde055_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde055_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055_desc
            #add-point:ON ACTION controlp INFIELD apde055_desc name="query.c.page2.apde055_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056
            #add-point:BEFORE FIELD apde056 name="query.b.page2.apde056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056
            
            #add-point:AFTER FIELD apde056 name="query.a.page2.apde056"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056
            #add-point:ON ACTION controlp INFIELD apde056 name="query.c.page2.apde056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056_desc
            #add-point:BEFORE FIELD apde056_desc name="query.b.page2.apde056_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056_desc
            
            #add-point:AFTER FIELD apde056_desc name="query.a.page2.apde056_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde056_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056_desc
            #add-point:ON ACTION controlp INFIELD apde056_desc name="query.c.page2.apde056_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057
            #add-point:BEFORE FIELD apde057 name="query.b.page2.apde057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057
            
            #add-point:AFTER FIELD apde057 name="query.a.page2.apde057"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057
            #add-point:ON ACTION controlp INFIELD apde057 name="query.c.page2.apde057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057_desc
            #add-point:BEFORE FIELD apde057_desc name="query.b.page2.apde057_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057_desc
            
            #add-point:AFTER FIELD apde057_desc name="query.a.page2.apde057_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde057_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057_desc
            #add-point:ON ACTION controlp INFIELD apde057_desc name="query.c.page2.apde057_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058
            #add-point:BEFORE FIELD apde058 name="query.b.page2.apde058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058
            
            #add-point:AFTER FIELD apde058 name="query.a.page2.apde058"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058
            #add-point:ON ACTION controlp INFIELD apde058 name="query.c.page2.apde058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058_desc
            #add-point:BEFORE FIELD apde058_desc name="query.b.page2.apde058_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058_desc
            
            #add-point:AFTER FIELD apde058_desc name="query.a.page2.apde058_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde058_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058_desc
            #add-point:ON ACTION controlp INFIELD apde058_desc name="query.c.page2.apde058_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059
            #add-point:BEFORE FIELD apde059 name="query.b.page2.apde059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059
            
            #add-point:AFTER FIELD apde059 name="query.a.page2.apde059"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059
            #add-point:ON ACTION controlp INFIELD apde059 name="query.c.page2.apde059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059_desc
            #add-point:BEFORE FIELD apde059_desc name="query.b.page2.apde059_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059_desc
            
            #add-point:AFTER FIELD apde059_desc name="query.a.page2.apde059_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde059_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059_desc
            #add-point:ON ACTION controlp INFIELD apde059_desc name="query.c.page2.apde059_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060
            #add-point:BEFORE FIELD apde060 name="query.b.page2.apde060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060
            
            #add-point:AFTER FIELD apde060 name="query.a.page2.apde060"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060
            #add-point:ON ACTION controlp INFIELD apde060 name="query.c.page2.apde060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060_desc
            #add-point:BEFORE FIELD apde060_desc name="query.b.page2.apde060_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060_desc
            
            #add-point:AFTER FIELD apde060_desc name="query.a.page2.apde060_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apde060_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060_desc
            #add-point:ON ACTION controlp INFIELD apde060_desc name="query.c.page2.apde060_desc"
            
            #END add-point
 
 
  
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde121
            #add-point:BEFORE FIELD apde121 name="query.b.page3.apde121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde121
            
            #add-point:AFTER FIELD apde121 name="query.a.page3.apde121"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.apde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde121
            #add-point:ON ACTION controlp INFIELD apde121 name="query.c.page3.apde121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde129
            #add-point:BEFORE FIELD apde129 name="query.b.page3.apde129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde129
            
            #add-point:AFTER FIELD apde129 name="query.a.page3.apde129"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.apde129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde129
            #add-point:ON ACTION controlp INFIELD apde129 name="query.c.page3.apde129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde131
            #add-point:BEFORE FIELD apde131 name="query.b.page3.apde131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde131
            
            #add-point:AFTER FIELD apde131 name="query.a.page3.apde131"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.apde131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde131
            #add-point:ON ACTION controlp INFIELD apde131 name="query.c.page3.apde131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde139
            #add-point:BEFORE FIELD apde139 name="query.b.page3.apde139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde139
            
            #add-point:AFTER FIELD apde139 name="query.a.page3.apde139"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.apde139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde139
            #add-point:ON ACTION controlp INFIELD apde139 name="query.c.page3.apde139"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG 
   END DIALOG
 
   #add-point:query段after_construct name="query.after_construct"
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL aapt300_09_b_fill(g_wc2)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt300_09_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapt300_09_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt300_09_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_nmag002            LIKE nmag_t.nmag002   
   DEFINE  l_amt               RECORD
                                  apcc10x    LIKE type_t.num20_6,
                                  apcc11x    LIKE type_t.num20_6,
                                  apcc12x    LIKE type_t.num20_6,
                                  apcc13x    LIKE type_t.num20_6
                               END RECORD
   DEFINE  l_glae009              LIKE glae_t.glae009    #自由核算項使用
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   
   #160114-00019#1-----s
   DEFINE l_apcay   LIKE type_t.num5
   DEFINE l_apcam   LIKE type_t.num5
   DEFINE l_apdey   LIKE type_t.num5
   DEFINE l_apdem   LIKE type_t.num5
   #160114-00019#1-----e
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   CASE g_apca.apcastus
        WHEN 'Y'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'axr-00037'
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            RETURN
        WHEN 'X'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'apr-00207'
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            RETURN
   END CASE
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_apde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt300_09_b_fill(g_wc2)
            LET g_detail_cnt = g_apde_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            CALL s_transaction_begin()   #150419
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apde_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_apde_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apde_d[l_ac].apdeld IS NOT NULL
               AND g_apde_d[l_ac].apdedocno IS NOT NULL
               AND g_apde_d[l_ac].apdeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apde_d_t.* = g_apde_d[l_ac].*  #BACKUP
               LET g_apde_d_o.* = g_apde_d[l_ac].*  #BACKUP
               IF NOT aapt300_09_lock_b("apde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_09_bcl INTO g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apdeseq, 
                      g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008, 
                      g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016, 
                      g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119, 
                      g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
                      g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041, 
                      g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
                      g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apdedocno, 
                      g_apde2_d[l_ac].apdeld,g_apde2_d[l_ac].apdeseq,g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018, 
                      g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023, 
                      g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043, 
                      g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053, 
                      g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057, 
                      g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apdedocno, 
                      g_apde3_d[l_ac].apdeld,g_apde3_d[l_ac].apdeseq,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121, 
                      g_apde3_d[l_ac].apde129,g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apde_d_t.apdeld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apde_d_mask_o[l_ac].* =  g_apde_d[l_ac].*
                  CALL aapt300_09_apde_t_mask()
                  LET g_apde_d_mask_n[l_ac].* =  g_apde_d[l_ac].*
                  
                  CALL aapt300_09_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_required()
            CALL aapt300_09_set_required()
            CALL aapt300_09_set_no_entry_b(l_cmd)
            IF l_cmd = 'u' THEN
               CASE
                  WHEN g_apde_d[l_ac].apde006 = '10'  #現金
                     LET l_nmag002 = '5'   #零用金
                  WHEN g_apde_d[l_ac].apde006 = '20'  #銀行電匯款
                     LET l_nmag002 = '1'   #不限制
                  WHEN g_apde_d[l_ac].apde006 = '30'  #票據
                     LET l_nmag002 = '4'   #票據往來
               END CASE
            ELSE
               LET l_nmag002 =''
            END IF             
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apde_d_t.* TO NULL
            INITIALIZE g_apde_d_o.* TO NULL
            INITIALIZE g_apde_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身3)
                  LET g_apde_d[l_ac].apde002 = "10"
      LET g_apde_d[l_ac].apde006 = "20"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_apde_d[l_ac].apdeld = g_apca.apcald
            LET g_apde_d[l_ac].apdedocno = g_apca.apcadocno
            LET g_apde_d[l_ac].apde001 = g_prog
            
            LET l_nmag002 = '1'   #款別為20:現金,帳戶運用類型指定為不限制
            LET g_apde_d[l_ac].apde009 = 'N'
            LET g_apde_d[l_ac].apde015 = s_fin_get_scc_value('8506',g_apde_d[l_ac].apde002,'3')

            LET g_apde_d[l_ac].apdecomp = g_apca.apcacomp
           #LET g_apde_d[l_ac].apdeorga = g_apca.apcacomp #160908-00036#1 mark
            LET g_apde_d[l_ac].apdeorga = g_apca.apcasite #160908-00036#1
            LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
            DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
            LET g_apde_d[l_ac].apdesite = g_apca.apcasite
            LET g_apde_d[l_ac].apde032 = g_apca.apcadocdt
            LET g_apde_d[l_ac].apde038 = g_apca.apca005
            CALL s_aapt420_get_primary_pay_bank(g_apca.apca005) RETURNING g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040 
            #160202-00021#2--(S)
            SELECT pmaf004 INTO g_apde_d[l_ac].apde041
              FROM pmaf_t
             WHERE pmafent = g_enterprise AND pmaf001 = g_apca.apca005
               AND pmaf009 = 'Y' AND pmafstus = 'Y'  #取主要付款帳戶
            #160202-00021#2--(E) 
            #-150629-00028#1--(s)
            IF g_apde_d[l_ac].apde006 ='30' THEN
               LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)  
               LET g_apde2_d[l_ac].apde0162 =g_apde_d[l_ac].apde016
            ELSE
               LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)  
               LET g_apde2_d[l_ac].apde0162 =g_apde_d[l_ac].apde016
            END IF              
            LET g_apde_d[l_ac].apde016_desc   = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)
            LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
            DISPLAY BY NAME g_apde2_d[l_ac].apde0162 ,g_apde2_d[l_ac].apde0162_desc,
                            g_apde_d[l_ac].apde016   ,g_apde_d[l_ac].apde016_desc 
            #-150629-00028#1--(e)
            #end add-point
            LET g_apde_d_t.* = g_apde_d[l_ac].*     #新輸入資料
            LET g_apde_d_o.* = g_apde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde_d[g_apde_d.getLength()].apdeld = NULL
               LET g_apde_d[g_apde_d.getLength()].apdedocno = NULL
               LET g_apde_d[g_apde_d.getLength()].apdeseq = NULL
 
            END IF
            
 
 
 
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aapt300_09_set_no_required()
            CALL aapt300_09_set_required()
            
            #預帶項次
            LET g_apde_d[l_ac].apdeseq = NULL
            SELECT MAX(apdeseq) INTO g_apde_d[l_ac].apdeseq FROM apde_t
             WHERE apdeent = g_enterprise
               AND apdeld  = g_apca.apcald
               AND apdedocno = g_apca.apcadocno
            IF cl_null(g_apde_d[l_ac].apdeseq) THEN
               LET g_apde_d[l_ac].apdeseq = 0
            END IF
            LET g_apde_d[l_ac].apdeseq = g_apde_d[l_ac].apdeseq + 1
            #end add-point  
  
         AFTER INSERT
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
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND apdeld = g_apde_d[l_ac].apdeld
                                       AND apdedocno = g_apde_d[l_ac].apdedocno
                                       AND apdeseq = g_apde_d[l_ac].apdeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde_d[g_detail_idx].apdeld
               LET gs_keys[2] = g_apde_d[g_detail_idx].apdedocno
               LET gs_keys[3] = g_apde_d[g_detail_idx].apdeseq
               CALL aapt300_09_insert_b('apde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_09_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #應付單可沖金額 < 直接付款金額
               CALL aapt300_02_get_contra_amount(g_apca.apcald,g_apca.apcadocno,'','') RETURNING l_amt.apcc10x,l_amt.apcc11x,l_amt.apcc12x,l_amt.apcc13x
               IF l_amt.apcc11x < 0 OR (aapt300_09_contra_curr_chk(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apde100) AND l_amt.apcc10x < 0 ) OR
                  (g_glaa.glaa015 = 'Y' AND l_amt.apcc12x < 0) OR (g_glaa.glaa019 = 'Y' AND l_amt.apcc13x < 0) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'aap-00241' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()         
                  CALL s_transaction_end('N','0')      
                  CANCEL INSERT     
               ELSE                                #150419
                  CALL s_transaction_end('Y','0')  #150419                   
               END IF  
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (apdeld = '", g_apde_d[l_ac].apdeld, "' "
                                  ," AND apdedocno = '", g_apde_d[l_ac].apdedocno, "' "
                                  ," AND apdeseq = '", g_apde_d[l_ac].apdeseq, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
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
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point   
               
               DELETE FROM apde_t
                WHERE apdeent = g_enterprise AND 
                      apdeld = g_apde_d_t.apdeld
                      AND apdedocno = g_apde_d_t.apdedocno
                      AND apdeseq = g_apde_d_t.apdeseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_09_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apde_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_09_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_apde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde_d_t.apdeld
               LET gs_keys[2] = g_apde_d_t.apdedocno
               LET gs_keys[3] = g_apde_d_t.apdeseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_09_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapt300_09_delete_b('apde_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdedocno
            #add-point:BEFORE FIELD apdedocno name="input.b.page1.apdedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdedocno
            
            #add-point:AFTER FIELD apdedocno name="input.a.page1.apdedocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apde_d[g_detail_idx].apdeld IS NOT NULL AND g_apde_d[g_detail_idx].apdedocno IS NOT NULL AND g_apde_d[g_detail_idx].apdeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apde_d[g_detail_idx].apdeld != g_apde_d_t.apdeld OR g_apde_d[g_detail_idx].apdedocno != g_apde_d_t.apdedocno OR g_apde_d[g_detail_idx].apdeseq != g_apde_d_t.apdeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apde_t WHERE "||"apdeent = '" ||g_enterprise|| "' AND "||"apdeld = '"||g_apde_d[g_detail_idx].apdeld ||"' AND "|| "apdedocno = '"||g_apde_d[g_detail_idx].apdedocno ||"' AND "|| "apdeseq = '"||g_apde_d[g_detail_idx].apdeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdedocno
            #add-point:ON CHANGE apdedocno name="input.g.page1.apdedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeld
            #add-point:BEFORE FIELD apdeld name="input.b.page1.apdeld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeld
            
            #add-point:AFTER FIELD apdeld name="input.a.page1.apdeld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apde_d[g_detail_idx].apdeld IS NOT NULL AND g_apde_d[g_detail_idx].apdedocno IS NOT NULL AND g_apde_d[g_detail_idx].apdeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apde_d[g_detail_idx].apdeld != g_apde_d_t.apdeld OR g_apde_d[g_detail_idx].apdedocno != g_apde_d_t.apdedocno OR g_apde_d[g_detail_idx].apdeseq != g_apde_d_t.apdeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apde_t WHERE "||"apdeent = '" ||g_enterprise|| "' AND "||"apdeld = '"||g_apde_d[g_detail_idx].apdeld ||"' AND "|| "apdedocno = '"||g_apde_d[g_detail_idx].apdedocno ||"' AND "|| "apdeseq = '"||g_apde_d[g_detail_idx].apdeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdeld
            #add-point:ON CHANGE apdeld name="input.g.page1.apdeld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeseq
            #add-point:BEFORE FIELD apdeseq name="input.b.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeseq
            
            #add-point:AFTER FIELD apdeseq name="input.a.page1.apdeseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apde_d[g_detail_idx].apdeld IS NOT NULL AND g_apde_d[g_detail_idx].apdedocno IS NOT NULL AND g_apde_d[g_detail_idx].apdeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apde_d[g_detail_idx].apdeld != g_apde_d_t.apdeld OR g_apde_d[g_detail_idx].apdedocno != g_apde_d_t.apdedocno OR g_apde_d[g_detail_idx].apdeseq != g_apde_d_t.apdeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apde_t WHERE "||"apdeent = '" ||g_enterprise|| "' AND "||"apdeld = '"||g_apde_d[g_detail_idx].apdeld ||"' AND "|| "apdedocno = '"||g_apde_d[g_detail_idx].apdedocno ||"' AND "|| "apdeseq = '"||g_apde_d[g_detail_idx].apdeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdeseq
            #add-point:ON CHANGE apdeseq name="input.g.page1.apdeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeorga
            
            #add-point:AFTER FIELD apdeorga name="input.a.page1.apdeorga"
            LET g_apde_d[l_ac].apdeorga_desc = ' '
            DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
            IF NOT cl_null(g_apde_d[l_ac].apdeorga) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apdeorga != g_apde_d_t.apdeorga OR g_apde_d_t.apdeorga IS NULL )) THEN
                  #CALL s_fin_comp_chk(g_apde_d[l_ac].apdeorga) RETURNING g_sub_success,g_errno        #161006-00005#4   mark
                  CALL s_aap_apcborga_chk(g_apcald,g_apcadocno,g_apde_d[l_ac].apdeorga,g_wc_cs_orga)   #161006-00005#4   add
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#21 --e add
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apde_d[l_ac].apdeorga = g_apde_d_t.apdeorga
                     LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
                     DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160908-00036#1-s
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apde_d[l_ac].apdeorga
                  LET g_chkparam.arg2 = g_apca.apcacomp
                  LET g_errshow = TRUE  #是否彈窗   161006-00005#4   add
                  IF NOT cl_chk_exist("v_ooef001_43") THEN
                     LET g_apde_d[l_ac].apdeorga = g_apde_d_t.apdeorga
                     LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
                     DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160908-00036#1-e
                  CALL s_fin_account_center_with_ld_chk(g_apde_d[l_ac].apdeorga,g_glaa.glaald,g_user,'6','Y','',g_today)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apde_d[l_ac].apdeorga = g_apde_d_t.apdeorga
                     LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
                     DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
              LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
              DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
            END IF
            LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)
            DISPLAY BY NAME g_apde_d[l_ac].apdeorga_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeorga
            #add-point:BEFORE FIELD apdeorga name="input.b.page1.apdeorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdeorga
            #add-point:ON CHANGE apdeorga name="input.g.page1.apdeorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="input.b.page1.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="input.a.page1.apde002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde002
            #add-point:ON CHANGE apde002 name="input.g.page1.apde002"
            LET g_apde_d[l_ac].apde015 = s_fin_get_scc_value('8506',g_apde_d[l_ac].apde002,'3')
            
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)   
            CALL aapt300_09_set_no_required()
            CALL aapt300_09_set_required()       
            
            #預帶沖銷科目
            IF g_apde_d[l_ac].apde006 ='30' THEN
               LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021) #150209-00008#8
               LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)
            ELSE
               LET g_apde_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008) #150209-00008#8
               LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)
            END IF     
            LET g_apde_d[l_ac].apde016_desc   = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016) #150209-00008#8
            LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
            DISPLAY BY NAME g_apde2_d[l_ac].apde0162 ,g_apde2_d[l_ac].apde0162_desc,
                            g_apde_d[l_ac].apde016   ,g_apde_d[l_ac].apde016_desc #150209-00008#8
            #付款類型為10,則預帶受款銀行/受款帳戶            
            IF g_apde_d[l_ac].apde002 ='10' OR g_apde_d[l_ac].apde002 ='23' THEN     #160422-00021#1
               CASE                                                   #160324-00032#3
                  WHEN g_apde_d[l_ac].apde006 MATCHES '[12]0'        #160324-00032#3            
                     CALL s_aapt420_get_primary_pay_bank(g_apca.apca005) RETURNING g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040
               #160324-00032#3--s
                     SELECT pmaf004 INTO g_apde_d[l_ac].apde041
                       FROM pmaf_t
                      WHERE pmafent = g_enterprise AND pmaf001 = g_apca.apca005
                        AND pmaf009 = 'Y' AND pmafstus = 'Y'  #取主要付款帳戶         
                  WHEN g_apde_d[l_ac].apde006 MATCHES '[3]0'             
                     LET g_apde_d[l_ac].apde039 = ''
                     LET g_apde_d[l_ac].apde040 = ''
                     LET g_apde_d[l_ac].apde041 = s_desc_get_trading_partner_full_desc(g_apca.apca005)
               END CASE
               #160324-00032#3--e               
               DISPLAY BY NAME g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040
               #160324-00032#3 mark--s
               #160202-00021#2--(S)
               #SELECT pmaf004 INTO g_apde_d[l_ac].apde041
               #  FROM pmaf_t
               # WHERE pmafent = g_enterprise AND pmaf001 = g_apca.apca005
               #   AND pmaf009 = 'Y' AND pmafstus = 'Y'  #取主要付款帳戶
               #160324-00032#3 mark--s
               DISPLAY BY NAME g_apde_d[l_ac].apde041
               #160202-00021#2--(E) 
            #160324-00032#3--s
            ELSE 
               LET g_apde_d[l_ac].apde039 = ''
               LET g_apde_d[l_ac].apde040 = ''               
               LET g_apde_d[l_ac].apde041 = ''   
               DISPLAY BY NAME g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041 
            #160324-00032#3--e               
            END IF
            #付款類型為2*,則預帶轉入對象為付款對象           
            IF g_apde_d[l_ac].apde002[1,1] ='2' THEN
               IF cl_null(g_apde_d[l_ac].apde013) THEN
                  LET g_apde_d[l_ac].apde013 = g_apca.apca005
                  CALL s_desc_get_trading_partner_abbr_desc(g_apde_d[l_ac].apde013) RETURNING g_apde_d[l_ac].apde013_desc
                  DISPLAY BY NAME g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde013_desc 
               END IF
               IF g_apde_d[l_ac].apde002 = '20' THEN
                  IF cl_null(g_apde_d[l_ac].apde014) THEN
                     CALL s_aooi200_fin_get_slip(g_apca.apcadocno) RETURNING g_sub_success,g_ap_slip
                     SELECT ooac004 INTO g_apde_d[l_ac].apde014
                       FROM ooac_t
                      WHERE ooacent = g_enterprise
                        AND ooac001 = g_glaa.glaa024
                        AND ooac002 = g_ap_slip
                        AND ooac003 = 'D-FIN-3005'
                  END IF               
               END IF  
            END IF                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde006
            #add-point:BEFORE FIELD apde006 name="input.b.page1.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="input.a.page1.apde006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde006
            #add-point:ON CHANGE apde006 name="input.g.page1.apde006"
            CASE
               WHEN g_apde_d[l_ac].apde006 = '10'  #現金
                  LET l_nmag002 = '5'   #零用金
               WHEN g_apde_d[l_ac].apde006 = '20'  #銀行電匯款
                  LET l_nmag002 = '1'   #不限制
               WHEN g_apde_d[l_ac].apde006 = '30'  #票據
                  LET l_nmag002 = '4'   #票據往來
               #150128-00005#9--(s)
               WHEN g_apde_d[l_ac].apde006 = '90'  #其他類型
                  LET g_apde_d[l_ac].apde032 = g_today
                  LET g_apde_d[l_ac].apde100 = g_glaa.glaa001
                  LET g_apde_d[l_ac].apde101 = 1
               #150128-00005#9--(e)                    
            END CASE
            #160324-00032#3--s
            #付款類型為10,則預帶受款銀行/受款帳戶            
            IF g_apde_d[l_ac].apde002 ='10' THEN
               CASE
                  WHEN g_apde_d[l_ac].apde006 MATCHES '[12]0'
                     CALL s_aapt420_get_primary_pay_bank(g_apca.apca005) RETURNING g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040
                     SELECT pmaf004 INTO g_apde_d[l_ac].apde041
                       FROM pmaf_t
                      WHERE pmafent = g_enterprise AND pmaf001 = g_apca.apca005
                        AND pmaf009 = 'Y' AND pmafstus = 'Y'  #取主要付款帳戶
                  WHEN g_apde_d[l_ac].apde006 MATCHES '[3]0'            
                     LET g_apde_d[l_ac].apde039 = ''
                     LET g_apde_d[l_ac].apde040 = ''
                     LET g_apde_d[l_ac].apde041 = s_desc_get_trading_partner_full_desc(g_apca.apca005)  
               END CASE
            ELSE 
               LET g_apde_d[l_ac].apde039 = ''
               LET g_apde_d[l_ac].apde040 = ''               
               LET g_apde_d[l_ac].apde041 = ''   
            END IF            
            DISPLAY BY NAME g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041
            #160324-00032#3--e               
            
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            CALL aapt300_09_set_no_required()
            CALL aapt300_09_set_required()     
            
            #預帶沖銷科目
            IF g_apde_d[l_ac].apde006 ='30' THEN
               LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)
               LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)
            ELSE
               LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)
               LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)
            END IF     
            LET g_apde_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)
            LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
            DISPLAY BY NAME g_apde2_d[l_ac].apde0162 ,g_apde2_d[l_ac].apde0162_desc,
                            g_apde_d[l_ac].apde016   ,g_apde_d[l_ac].apde016_desc 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="input.b.page1.apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="input.a.page1.apde008"
            IF NOT cl_null(g_apde_d[l_ac].apde008) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde008 != g_apde_d_t.apde008 OR g_apde_d_t.apde008 IS NULL )) THEN            
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apde_d[l_ac].apde008
                  LET g_chkparam.arg2 = g_apca.apcacomp
                  LET g_chkparam.arg3 = l_nmag002
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_nmas002_4") THEN
                     #檢查成功時後續處理
                     #160122-00001#5 --add---str
                     IF NOT s_anmi120_nmll002_chk(g_apde_d[l_ac].apde008,g_user) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_apde_d[l_ac].apde008
                        LET g_errparam.code   = 'anm-00574' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apde_d[l_ac].apde008 = g_apde_d_t.apde008
                        NEXT FIELD CURRENT
                     END IF
                     #160122-00001#5 --add---end
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF

                  #預帶帳戶幣別
                  LET g_apde_d[l_ac].apde100 = s_anm_get_nmas003(g_apde_d[l_ac].apde008)
                  DISPLAY BY NAME g_apde_d[l_ac].apde100   
                  
                  #預帶沖銷科目
                 #IF cl_null(g_apde_d[l_ac].apde016) THEN   #151009 mark
                     IF g_apde_d[l_ac].apde006 ='30' THEN
                        LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)  #150209-00008 #8   
                        LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)
                     ELSE
                        LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)  #150209-00008 #8   
                        LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)
                     END IF  
                     LET g_apde_d[l_ac].apde016_desc   = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)   #150209-00008 #8   
                     LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
                     DISPLAY BY NAME g_apde2_d[l_ac].apde0162 ,g_apde2_d[l_ac].apde0162_desc,
                                     g_apde_d[l_ac].apde016   ,g_apde_d[l_ac].apde016_desc  #150209-00008 #8       
                 #END IF   #151009 mark

               END IF
            END IF 
            
            #170208-00033#1 --s add 一個帳戶只有一個幣別，當帳戶不為空，應不可修改幣別
            CALL cl_set_comp_entry("apde100",TRUE)
            IF NOT cl_null(g_apde_d[l_ac].apde008) THEN
               CALL cl_set_comp_entry("apde100",FALSE) 
            END IF      
            #170208-00033#1 --e add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde008
            #add-point:ON CHANGE apde008 name="input.g.page1.apde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde021
            #add-point:BEFORE FIELD apde021 name="input.b.page1.apde021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde021
            
            #add-point:AFTER FIELD apde021 name="input.a.page1.apde021"
            IF NOT cl_null(g_apde_d[l_ac].apde021) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde021 != g_apde_d_t.apde021 OR g_apde_d_t.apde021 IS NULL )) THEN            
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apde_d[l_ac].apde021
                  LET g_chkparam.arg2 = g_apde_d[l_ac].apde006
                  IF NOT cl_chk_exist("v_ooia001_4") THEN
                     NEXT FIELD CURRENT
                  END IF
              
                  #預帶沖銷科目
                  IF g_apde_d[l_ac].apde006 ='30' THEN
                     LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021) #150209-00008#8    
                     LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde021)
                  ELSE
                     LET g_apde_d[l_ac].apde016  = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008) #150209-00008#8    
                     LET g_apde2_d[l_ac].apde0162 = s_aapt420_bring_acc_code2(g_apca.apcald,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008)
                  END IF
                  LET g_apde_d[l_ac].apde016_desc  = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)  #150209-00008#8                
                  LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
                  DISPLAY BY NAME g_apde2_d[l_ac].apde0162 ,g_apde2_d[l_ac].apde0162_desc,
                                  g_apde_d[l_ac].apde016   ,g_apde_d[l_ac].apde016_desc #150209-00008#8            
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde021
            #add-point:ON CHANGE apde021 name="input.g.page1.apde021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde024
            #add-point:BEFORE FIELD apde024 name="input.b.page1.apde024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde024
            
            #add-point:AFTER FIELD apde024 name="input.a.page1.apde024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde024
            #add-point:ON CHANGE apde024 name="input.g.page1.apde024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016
            
            #add-point:AFTER FIELD apde016 name="input.a.page1.apde016"
            #150209-00008   ---(s)---
            IF NOT cl_null(g_apde_d[l_ac].apde016) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apde016,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apde_d[l_ac].apdeld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apde_d[l_ac].apde016
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apde_d[l_ac].apde016
                LET g_qryparam.arg3 = g_apde_d[l_ac].apdeld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                 LET g_apde_d[l_ac].apde016 = g_qryparam.return1
                 LET g_apde_d[l_ac].apde016_desc  = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)
                 DISPLAY BY NAME g_apde_d[l_ac].apde016_desc 
                
              END IF
               IF  NOT s_aglt310_lc_subject(g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apde016,'N') THEN
                  LET g_apde_d[l_ac].apde016      = g_apde_d_t.apde016
                     LET g_apde_d[l_ac].apde016_desc = g_apde_d_t.apde016_desc
                     DISPLAY BY NAME g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde016_desc
                     NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
               IF (g_apde_d[l_ac].apde016 != g_apde_d_t.apde016 OR g_apde_d_t.apde016 IS NULL) THEN
                  CALL s_aap_glac002_chk(g_apde_d[l_ac].apde016,g_apca.apcald) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apde_d[l_ac].apde016      = g_apde_d_t.apde016
                     LET g_apde_d[l_ac].apde016_desc = g_apde_d_t.apde016_desc
                     DISPLAY BY NAME g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得自由核算項資訊
               CALL s_fin_sel_glad(g_apca.apcald,g_apde_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*                
            ELSE
               INITIALIZE g_glad.* TO NULL
               LET g_apde_d[l_ac].apde016 = ''
            END IF
            LET g_apde_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)
            DISPLAY BY NAME g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde016_desc 
            #150209-00008   ---(e)---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016
            #add-point:BEFORE FIELD apde016 name="input.b.page1.apde016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde016
            #add-point:ON CHANGE apde016 name="input.g.page1.apde016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016_desc
            #add-point:BEFORE FIELD apde016_desc name="input.b.page1.apde016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016_desc
            
            #add-point:AFTER FIELD apde016_desc name="input.a.page1.apde016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde016_desc
            #add-point:ON CHANGE apde016_desc name="input.g.page1.apde016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="input.b.page1.apde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="input.a.page1.apde100"
            IF NOT cl_null(g_apde_d[l_ac].apde100) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde100 != g_apde_d_t.apde100 OR g_apde_d_t.apde100 IS NULL )) THEN            
                  CALL s_aap_ooaj001_chk(g_apca.apcald,g_apde_d[l_ac].apde100) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     LET g_apde_d[l_ac].apde100 = g_apde_d_t.apde100
                     NEXT FIELD CURRENT
                  END IF            
                  #幣別變換時,重取本幣匯率與重算本幣金額
                  CALL aapt300_09_trans_to_local_curr(g_apde_d[l_ac].apde100)                
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde100
            #add-point:ON CHANGE apde100 name="input.g.page1.apde100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="input.b.page1.apde109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            
            #add-point:AFTER FIELD apde109 name="input.a.page1.apde109"
            IF NOT cl_null(g_apde_d[l_ac].apde109) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde109 != g_apde_d_t.apde109 OR g_apde_d_t.apde109 IS NULL )) THEN            
                  #170123-00036#1-----s
                  IF g_apde_d[l_ac].apde002 = '11' OR g_apde_d[l_ac].apde002 = '12' THEN
                  ELSE
                     IF NOT cl_ap_chk_range(g_apde_d[l_ac].apde109,"0.000","0","","","azz-00079",1) THEN
                        NEXT FIELD apde109
                     END IF
                  END IF
                  #170123-00036#1-----e
                  #原幣
                  CALL s_curr_round_ld('1',g_apca.apcald,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,2) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde109                   
                  DISPLAY BY NAME g_apde_d[l_ac].apde109
                  #本幣
                  LET g_apde_d[l_ac].apde119 = g_apde_d[l_ac].apde109 *g_apde_d[l_ac].apde101
                  IF cl_null(g_apde_d[l_ac].apde119) THEN LET g_apde_d[l_ac].apde119 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde119                   
                  DISPLAY BY NAME g_apde_d[l_ac].apde119
                  #本幣二
                  IF g_glaa.glaa015 = 'Y' THEN
                     LET g_apde3_d[l_ac].apde129 = g_apde_d[l_ac].apde109 *g_apde3_d[l_ac].apde121
                     IF cl_null(g_apde3_d[l_ac].apde129) THEN LET g_apde3_d[l_ac].apde129 = 0 END IF
                     CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa016,g_apde3_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde129 #160201-00016#1 改glaa016
                     DISPLAY BY NAME g_apde3_d[l_ac].apde129            
                  END IF
                  #本幣三
                  IF g_glaa.glaa019 = 'Y' THEN
                     LET g_apde3_d[l_ac].apde139 = g_apde_d[l_ac].apde109 *g_apde3_d[l_ac].apde131
                     IF cl_null(g_apde3_d[l_ac].apde139) THEN LET g_apde3_d[l_ac].apde139 = 0 END IF
                     CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa020,g_apde3_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde139 #160201-00016#1 改glaa020                  
                     DISPLAY BY NAME g_apde3_d[l_ac].apde139            
                  END IF  
                  CALL aapt300_02_get_contra_amount(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apdeseq,'2') RETURNING l_amt.apcc10x,l_amt.apcc11x,l_amt.apcc12x,l_amt.apcc13x 
                  #170203-00038#1-----s
                  IF g_apde_d[l_ac].apde109 > 0 THEN
                     IF g_apde_d[l_ac].apde015 = 'D' THEN
                        LET l_amt.apcc10x = l_amt.apcc10x * -1
                        LET l_amt.apcc11x = l_amt.apcc11x * -1
                        LET l_amt.apcc12x = l_amt.apcc12x * -1
                        LET l_amt.apcc13x = l_amt.apcc13x * -1
                     END IF
                  #170203-00038#1-----e
                     #應付單可沖金額 < 直接付款金額
                     IF g_apde_d[l_ac].apde119 > l_amt.apcc11x OR (aapt300_09_contra_curr_chk(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apde100) AND g_apde_d[l_ac].apde109 > l_amt.apcc10x) OR
                        (g_glaa.glaa015 = 'Y' AND g_apde3_d[l_ac].apde129 > l_amt.apcc12x) OR (g_glaa.glaa019 = 'Y' AND g_apde3_d[l_ac].apde139 > l_amt.apcc13x) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = 'aap-00241' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apde_d[l_ac].apde109 = g_apde_d_t.apde109
                        LET g_apde_d[l_ac].apde119 = g_apde_d_t.apde119
                        LET g_apde3_d[l_ac].apde129 = g_apde3_d_t.apde129
                        LET g_apde3_d[l_ac].apde139 = g_apde3_d_t.apde139
                        NEXT FIELD CURRENT                  
                     END IF             
                  END IF         #170203-00038#1 add                
               END IF      
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde109
            #add-point:ON CHANGE apde109 name="input.g.page1.apde109"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde_d[l_ac].apde101,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde101
            END IF 
 
 
 
            #add-point:AFTER FIELD apde101 name="input.a.page1.apde101"
            IF NOT cl_null(g_apde_d[l_ac].apde101) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde101 != g_apde_d_t.apde101 OR g_apde_d_t.apde101 IS NULL )) THEN            
                  #匯率取位
                  IF cl_null(g_apde_d[l_ac].apde101) THEN LET g_apde_d[l_ac].apde101 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde_d[l_ac].apde101,3) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde101  #160829-00004#1 mark               
                  CALL s_curr_round_ld('1',g_apca.apcald,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde101,3) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde101 #160829-00004#1 
                  #本幣重計
                  LET g_apde_d[l_ac].apde119 = g_apde_d[l_ac].apde109 * g_apde_d[l_ac].apde101
                  IF cl_null(g_apde_d[l_ac].apde119) THEN LET g_apde_d[l_ac].apde119 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde119                  
               END IF            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde101
            #add-point:BEFORE FIELD apde101 name="input.b.page1.apde101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde101
            #add-point:ON CHANGE apde101 name="input.g.page1.apde101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde_d[l_ac].apde119,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde119
            END IF 
 
 
 
            #add-point:AFTER FIELD apde119 name="input.a.page1.apde119"
            IF NOT cl_null(g_apde_d[l_ac].apde119) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde119 != g_apde_d_t.apde119 OR g_apde_d_t.apde119 IS NULL )) THEN            
                  #本幣
                  IF cl_null(g_apde_d[l_ac].apde119) THEN LET g_apde_d[l_ac].apde119 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde119                   
                  DISPLAY BY NAME g_apde_d[l_ac].apde119                
                  CALL aapt300_02_get_contra_amount(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apdeseq,'2') RETURNING l_amt.apcc10x,l_amt.apcc11x,l_amt.apcc12x,l_amt.apcc13x          
                  #170203-00038#1-----s
                  IF g_apde_d[l_ac].apde015 = 'D' THEN
                     LET l_amt.apcc10x = l_amt.apcc10x * -1
                     LET l_amt.apcc11x = l_amt.apcc11x * -1
                     LET l_amt.apcc12x = l_amt.apcc12x * -1
                     LET l_amt.apcc13x = l_amt.apcc13x * -1
                  END IF
                  #170203-00038#1-----e
                  #應付單可沖金額 < 直接付款金額
                  IF g_apde_d[l_ac].apde119 > l_amt.apcc11x OR (aapt300_09_contra_curr_chk(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apde100) AND g_apde_d[l_ac].apde109 > l_amt.apcc10x) OR
                     (g_glaa.glaa015 = 'Y' AND g_apde3_d[l_ac].apde129 > l_amt.apcc12x) OR (g_glaa.glaa019 = 'Y' AND g_apde3_d[l_ac].apde139 > l_amt.apcc13x) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'aap-00241' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apde_d[l_ac].apde109 = g_apde_d_t.apde109
                     LET g_apde_d[l_ac].apde119 = g_apde_d_t.apde119
                     NEXT FIELD CURRENT                  
                  END IF             
               END IF  
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde119
            #add-point:BEFORE FIELD apde119 name="input.b.page1.apde119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde119
            #add-point:ON CHANGE apde119 name="input.g.page1.apde119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="input.b.page1.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="input.a.page1.apde032"
            #160114-00019#1-----s
            IF NOT cl_null(g_apde_d[l_ac].apde032) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde032 != g_apde_d_t.apde032 OR g_apde_d_t.apde032 IS NULL )) THEN
                  LET l_apcay = NULL  LET l_apcam = NULL
                  LET l_apdey = NULL  LET l_apdem = NULL
                  CALL s_fin_date_get_period_value('',g_apca.apcald,g_apca.apcadocdt)RETURNING g_sub_success,l_apcay,l_apcam
                  CALL s_fin_date_get_period_value('',g_apca.apcald,g_apde_d[l_ac].apde032)RETURNING g_sub_success,l_apdey,l_apdem
                  IF NOT cl_null(l_apdey) AND NOT cl_null(l_apdem) 
                     AND NOT cl_null(l_apcay) AND NOT cl_null(l_apcam)THEN
                     IF l_apdey <> l_apcay OR l_apdem <> l_apcam THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code = 'aap-00442'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_apde_d[l_ac].apde032
            #160114-00019#1-----e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde032
            #add-point:ON CHANGE apde032 name="input.g.page1.apde032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde013
            
            #add-point:AFTER FIELD apde013 name="input.a.page1.apde013"
            LET g_apde_d[l_ac].apde013_desc = ' '
            DISPLAY BY NAME g_apde_d[l_ac].apde013_desc            
            IF NOT cl_null(g_apde_d[l_ac].apde013) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde013 != g_apde_d_t.apde013 OR g_apde_d_t.apde013 IS NULL )) THEN
                  CALL s_aap_apca005_chk(g_apde_d[l_ac].apde013)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
#提示不強制
#                     LET g_apde_d[l_ac].apde013 = g_apde_d_t.apde013
#                     CALL s_desc_get_trading_partner_abbr_desc(g_apde_d[l_ac].apde013) RETURNING g_apde_d[l_ac].apde013_desc
#                     DISPLAY BY NAME g_apde_d[l_ac].apde013_desc
#                     NEXT FIELD CURRENT
                  END IF
                  #150427--(s)
                  IF (g_apde_d[l_ac].apde002 = '20' OR g_apde_d[l_ac].apde002 = '21' OR g_apde_d[l_ac].apde002='22') THEN
                     LET g_apde_d[l_ac].apde038 = g_apde_d[l_ac].apde013
                     DISPLAY BY NAME g_apde_d[l_ac].apde038
                  END IF
                  #150427--(e)                  
               END IF
            END IF
          
            LET g_apde_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apde_d[l_ac].apde013)
            DISPLAY BY NAME g_apde_d[l_ac].apde013_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde013
            #add-point:BEFORE FIELD apde013 name="input.b.page1.apde013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde013
            #add-point:ON CHANGE apde013 name="input.g.page1.apde013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde014
            #add-point:BEFORE FIELD apde014 name="input.b.page1.apde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde014
            
            #add-point:AFTER FIELD apde014 name="input.a.page1.apde014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde014
            #add-point:ON CHANGE apde014 name="input.g.page1.apde014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="input.b.page1.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="input.a.page1.apde010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde010
            #add-point:ON CHANGE apde010 name="input.g.page1.apde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde039
            #add-point:BEFORE FIELD apde039 name="input.b.page1.apde039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde039
            
            #add-point:AFTER FIELD apde039 name="input.a.page1.apde039"
            IF NOT cl_null(g_apde_d[l_ac].apde039) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde039 != g_apde_d_t.apde039 OR g_apde_d_t.apde039 IS NULL )) THEN
                  CALL s_aapt420_pmaf002_chk(g_apca.apca005,g_apde_d[l_ac].apde039)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apde_d[l_ac].apde039 = g_apde_d_t.apde039
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde039
            #add-point:ON CHANGE apde039 name="input.g.page1.apde039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde040
            #add-point:BEFORE FIELD apde040 name="input.b.page1.apde040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde040
            
            #add-point:AFTER FIELD apde040 name="input.a.page1.apde040"
            
            IF NOT cl_null(g_apde_d[l_ac].apde040) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde040 != g_apde_d_t.apde040 OR g_apde_d_t.apde040 IS NULL )) THEN
                 #CALL s_aapt420_pmaf003_chk(g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040)RETURNING g_sub_success,g_errno                   #160429-00010#1 mark
                  CALL s_aapt420_pmaf003_chk2(g_apca.apca005,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040)RETURNING g_sub_success,g_errno   #160429-00010#1 
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apde_d[l_ac].apde040 = g_apde_d_t.apde040
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde040
            #add-point:ON CHANGE apde040 name="input.g.page1.apde040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde041
            #add-point:BEFORE FIELD apde041 name="input.b.page1.apde041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde041
            
            #add-point:AFTER FIELD apde041 name="input.a.page1.apde041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde041
            #add-point:ON CHANGE apde041 name="input.g.page1.apde041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="input.a.page1.apde011"
            LET g_apde_d[l_ac].apde011_desc=''
            LET g_apde_d[l_ac].apde012_desc = ''
            DISPLAY BY NAME g_apde_d[l_ac].apde011_desc,g_apde_d[l_ac].apde012_desc
            IF NOT cl_null(g_apde_d[l_ac].apde011) THEN

               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde011 != g_apde_d_t.apde011 OR g_apde_d_t.apde011 IS NULL )) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apde_d[l_ac].apde011
                  LET g_chkparam.arg2 = 2
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                     LET g_apde_d[l_ac].apde011 = g_apde_d_t.apde011
                     LET g_apde_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apde_d[l_ac].apde011)
                     DISPLAY BY NAME g_apde_d[l_ac].apde012
                     LET g_apde_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011)
                     LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)
                     DISPLAY BY NAME g_apde_d[l_ac].apde011_desc,g_apde_d[l_ac].apde012_desc                     
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
               LET g_apde_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apde_d[l_ac].apde011)
               DISPLAY BY NAME g_apde_d[l_ac].apde012
               LET g_apde_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011)
               LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)
               DISPLAY BY NAME g_apde_d[l_ac].apde011_desc,g_apde_d[l_ac].apde012_desc               
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="input.b.page1.apde011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde011
            #add-point:ON CHANGE apde011 name="input.g.page1.apde011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="input.a.page1.apde012"
            LET g_apde_d[l_ac].apde012_desc=''
            DISPLAY BY NAME g_apde_d[l_ac].apde012_desc            
            IF NOT cl_null(g_apde_d[l_ac].apde012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde_d[l_ac].apde012 != g_apde_d_t.apde012 OR g_apde_d_t.apde012 IS NULL )) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apde_d[l_ac].apde012
                  LET g_chkparam.arg2 = g_glaa.glaa005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     LET g_apde_d[l_ac].apde012 = g_apde_d_t.apde012
                     LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)
                     DISPLAY BY NAME g_apde_d[l_ac].apde012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)
               DISPLAY BY NAME g_apde_d[l_ac].apde012_desc
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="input.b.page1.apde012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde012
            #add-point:ON CHANGE apde012 name="input.g.page1.apde012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde061
            #add-point:BEFORE FIELD apde061 name="input.b.page1.apde061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde061
            
            #add-point:AFTER FIELD apde061 name="input.a.page1.apde061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde061
            #add-point:ON CHANGE apde061 name="input.g.page1.apde061"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apdedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdedocno
            #add-point:ON ACTION controlp INFIELD apdedocno name="input.c.page1.apdedocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeld
            #add-point:ON ACTION controlp INFIELD apdeld name="input.c.page1.apdeld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeseq
            #add-point:ON ACTION controlp INFIELD apdeseq name="input.c.page1.apdeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeorga
            #add-point:ON ACTION controlp INFIELD apdeorga name="input.c.page1.apdeorga"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apdeorga
            #161006-00005#4  mark---s
            #LET g_qryparam.where = " ooef206 = 'Y'",                       #160908-00036#1 add ,
            #                       " AND ooef017 = '",g_apca.apcacomp,"'"  #160908-00036#1
            #CALL q_ooef001()     
            #161006-00005#4  mark---e
            #161006-00005#4  add---s
            LET g_qryparam.where = " ooef017 = '",g_apca.apcacomp,"'"
            CALL q_ooef001_33()
            #161006-00005#4  add---e            
            LET g_apde_d[l_ac].apdeorga = g_qryparam.return1
            DISPLAY g_apde_d[l_ac].apdeorga TO apdeorga
            CALL s_desc_get_department_desc(g_apde_d[l_ac].apdeorga) RETURNING g_apde_d[l_ac].apdeorga_desc
            DISPLAY BY NAME g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apdeorga_desc
            NEXT FIELD apdeorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="input.c.page1.apde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="input.c.page1.apde006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="input.c.page1.apde008"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL               
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE                 
            LET g_qryparam.default1 = g_apde_d[l_ac].apde008             #給予default值            
            CASE g_apde_d[l_ac].apde002
               WHEN '10'
                  #開窗i段
                  #給予arg
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  
                  LET g_qryparam.default1 = g_apde_d[l_ac].apde008             #給予default值
                   #160122-00001#5  mark
#                  LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#                                         "              AND ooef017 = '",g_apca.apcacomp,"')",
#                                         " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
#                 #160122-00001#5  mark                        " AND nmag002 IN ('1','",l_nmag002,"'))" #160122-00001#5  mark
                  #160122-00001#5  -add -str
                  LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
                                         "              AND ooef017 = '",g_apca.apcacomp,"')",
                                         " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                         "               AND nmagent = ",g_enterprise, #160905-00002#1
                                         "               AND nmag002 IN ('1','",l_nmag002,"'))",
#                                         " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise," AND nmll002 = '",g_user,"')" 
                                         " AND nmas002 IN (",g_sql_bank,")"  #160122-00001#5 mod by 07675
                  #160122-00001#5  -add -end                  
                 CALL q_nmas_01()                                #呼叫開窗                            
            END CASE
            LET g_apde_d[l_ac].apde008 = g_qryparam.return1
            LET g_apde_d[l_ac].apde100 = s_anm_get_nmas003(g_apde_d[l_ac].apde008)
            DISPLAY BY NAME g_apde_d[l_ac].apde100            
            DISPLAY g_apde_d[l_ac].apde008 TO apde008 
            NEXT FIELD apde008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde021
            #add-point:ON ACTION controlp INFIELD apde021 name="input.c.page1.apde021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde021     #給予default值
            LET g_qryparam.where = " ooia002 = '",g_apde_d[l_ac].apde006,"'",
                                   " AND ooiaent = '",g_enterprise,"'",
                                   " AND ooia011 = 'Y' "
            CALL q_ooia001()                                      #呼叫開窗

            LET g_apde_d[l_ac].apde021 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_apde_d[l_ac].apde021               #顯示到畫面上
            NEXT FIELD apde021                                    #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde024
            #add-point:ON ACTION controlp INFIELD apde024 name="input.c.page1.apde024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016
            #add-point:ON ACTION controlp INFIELD apde016 name="input.c.page1.apde016"
            #應付帳款科目編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde016
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_apde_d[l_ac].apdeld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apde_d[l_ac].apde016 = g_qryparam.return1
            LET g_apde_d[l_ac].apde016_desc  = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)
            DISPLAY BY NAME g_apde_d[l_ac].apde016_desc 
            NEXT FIELD apde016
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016_desc
            #add-point:ON ACTION controlp INFIELD apde016_desc name="input.c.page1.apde016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="input.c.page1.apde100"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooaj001='",g_glaa.glaa026,"' "
            LET g_qryparam.default1 = g_apde_d[l_ac].apde100             #給予default值
            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_apde_d[l_ac].apde100 = g_qryparam.return1              

            DISPLAY g_apde_d[l_ac].apde100 TO apde100              #

            NEXT FIELD apde100                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="input.c.page1.apde109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde101
            #add-point:ON ACTION controlp INFIELD apde101 name="input.c.page1.apde101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde119
            #add-point:ON ACTION controlp INFIELD apde119 name="input.c.page1.apde119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="input.c.page1.apde032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde013
            #add-point:ON ACTION controlp INFIELD apde013 name="input.c.page1.apde013"
            #付款對象
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde013
            LET g_qryparam.arg1 = "1"                         #交易類型
            CALL q_pmac002_8()
            LET g_apde_d[l_ac].apde013 = g_qryparam.return1
            LET g_apde_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apde_d[l_ac].apde013)
            DISPLAY BY NAME g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde013_desc
            NEXT FIELD apde013
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde014
            #add-point:ON ACTION controlp INFIELD apde014 name="input.c.page1.apde014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #開窗i段
            LET g_qryparam.default1 = g_apde_d[l_ac].apde014  
            CASE 
               WHEN g_apde_d[l_ac].apde002 = '10' AND g_apde_d[l_ac].apde006= '30'   #10.付款+30.票據類型(anmt440)    
                  LET g_qryparam.arg1 = g_glaa.glaa024       
                  LET g_qryparam.arg2 = "anmt440"       
                  CALL q_ooba002_1()                                            
               WHEN g_apde_d[l_ac].apde002= '20'                                      #20.轉應付待抵款(aapq343)                   
                  LET g_qryparam.arg1 = g_glaa.glaa024
                  LET g_qryparam.arg2 = "aapq343"
                  CALL q_ooba002_1()                                
            END CASE
            LET g_apde_d[l_ac].apde014 = g_qryparam.return1   
            DISPLAY BY NAME g_apde_d[l_ac].apde014    
            NEXT FIELD apde014 
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="input.c.page1.apde010"
            #摘要
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde010
            CALL q_oocq002_2()
            LET g_apde_d[l_ac].apde010 = g_qryparam.return1
            DISPLAY g_apde_d[l_ac].apde010 TO apde010
            NEXT FIELD apde010     
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde039
            #add-point:ON ACTION controlp INFIELD apde039 name="input.c.page1.apde039"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde039
            LET g_qryparam.arg1 = g_apca.apca005
            CALL q_pmaf002()
            LET g_apde_d[l_ac].apde039 = g_qryparam.return1
            LET g_apde_d[l_ac].apde040 = g_qryparam.return2
            LET g_apde_d[l_ac].apde041 = g_qryparam.return3    #160202-00021#2
            DISPLAY g_apde_d[l_ac].apde039 TO apde039
            DISPLAY g_apde_d[l_ac].apde040 TO apde040
            DISPLAY g_apde_d[l_ac].apde041 TO apde041          #160202-00021#2
            NEXT FIELD apde039  
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde040
            #add-point:ON ACTION controlp INFIELD apde040 name="input.c.page1.apde040"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde040
            LET g_qryparam.arg1 = g_apca.apca005
            CALL q_pmaf002()
            LET g_apde_d[l_ac].apde039 = g_qryparam.return1
            LET g_apde_d[l_ac].apde040 = g_qryparam.return2
            LET g_apde_d[l_ac].apde041 = g_qryparam.return3    #160202-00021#2
            DISPLAY g_apde_d[l_ac].apde039 TO apde039
            DISPLAY g_apde_d[l_ac].apde040 TO apde040
            DISPLAY g_apde_d[l_ac].apde041 TO apde041          #160202-00021#2
            NEXT FIELD apde040                                      
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde041
            #add-point:ON ACTION controlp INFIELD apde041 name="input.c.page1.apde041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="input.c.page1.apde011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apde_d[l_ac].apde011            #給予default值
            CALL q_nmaj001()                                             #呼叫開窗
            LET g_apde_d[l_ac].apde011 = g_qryparam.return1
            LET g_apde_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apde_d[l_ac].apde011)
            DISPLAY BY NAME g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012
            LET g_apde_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011)
            LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)            
            DISPLAY BY NAME g_apde_d[l_ac].apde011_desc,g_apde_d[l_ac].apde012_desc
            NEXT FIELD apde011                                           #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="input.c.page1.apde012"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_glaa.glaa005,"' "
            LET g_qryparam.default1 = g_apde_d[l_ac].apde012 #給予default值
            CALL q_nmai002()                                  #呼叫開窗
            LET g_apde_d[l_ac].apde012 = g_qryparam.return1
            DISPLAY g_apde_d[l_ac].apde012 TO apde012              
            LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)
            DISPLAY BY NAME g_apde_d[l_ac].apde012_desc            
            NEXT FIELD apde012                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde061
            #add-point:ON ACTION controlp INFIELD apde061 name="input.c.page1.apde061"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapt300_09_bcl
               LET INT_FLAG = 0
               LET g_apde_d[l_ac].* = g_apde_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apde_d[l_ac].apdeld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apde_d[l_ac].* = g_apde_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_09_apde_t_mask_restore('restore_mask_o')
 
               UPDATE apde_t SET (apdedocno,apdeld,apdeseq,apdeorga,apde002,apde006,apde008,apde021, 
                   apde024,apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010, 
                   apde009,apde039,apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038, 
                   apde061,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043, 
                   apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060, 
                   apde120,apde121,apde129,apde130,apde131,apde139) = (g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld, 
                   g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006, 
                   g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015, 
                   g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101, 
                   g_apde_d[l_ac].apde119,g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014, 
                   g_apde_d[l_ac].apde010,g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040, 
                   g_apde_d[l_ac].apde041,g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp, 
                   g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061, 
                   g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020, 
                   g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036, 
                   g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051, 
                   g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055, 
                   g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059, 
                   g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129, 
                   g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139)
                WHERE apdeent = g_enterprise AND
                  apdeld = g_apde_d_t.apdeld #項次   
                  AND apdedocno = g_apde_d_t.apdedocno  
                  AND apdeseq = g_apde_d_t.apdeseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde_d[g_detail_idx].apdeld
               LET gs_keys_bak[1] = g_apde_d_t.apdeld
               LET gs_keys[2] = g_apde_d[g_detail_idx].apdedocno
               LET gs_keys_bak[2] = g_apde_d_t.apdedocno
               LET gs_keys[3] = g_apde_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apde_d_t.apdeseq
               CALL aapt300_09_update_b('apde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apde_d_t)
                     LET g_log2 = util.JSON.stringify(g_apde_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_09_apde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               IF l_ac > 0 THEN
                  #S-FIN-3008
                  IF g_sfin3008 = 'Y' AND (cl_null(g_apde_d[l_ac].apde039) OR cl_null(g_apde_d[l_ac].apde040))THEN
                     #屬於20:銀行匯款/30:票據者,若受款銀行/受款帳戶未維護予以提示
                     IF g_apde_d[l_ac].apde006 = '20' OR g_apde_d[l_ac].apde006 = '30' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00267'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                     
                     END IF
                  END IF
               END IF                 
               #應付單可沖金額 < 直接付款金額
               CALL aapt300_02_get_contra_amount(g_apca.apcald,g_apca.apcadocno,'','') RETURNING l_amt.apcc10x,l_amt.apcc11x,l_amt.apcc12x,l_amt.apcc13x 
               IF l_amt.apcc11x < 0 OR (aapt300_09_contra_curr_chk(g_apca.apcald,g_apca.apcadocno,g_apde_d[l_ac].apde100) AND l_amt.apcc10x < 0 ) OR
                  (g_glaa.glaa015 = 'Y' AND l_amt.apcc12x < 0) OR (g_glaa.glaa019 = 'Y' AND l_amt.apcc13x < 0) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'aap-00241' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_apde_d[l_ac].* = g_apde_d_t.*           
                  CALL s_transaction_end('N','0')      
               ELSE                                #150419
                  CALL s_transaction_end('Y','0')  #150419                   
               END IF               
               #150209-00008#9   ---(s)---　重新填充第二單身
               IF (g_apde_d[l_ac].apde016 != g_apde_d_t.apde016 OR g_apde_d_t.apde016 IS NULL) THEN                  
                  CALL aapt300_09_b_fill(g_wc2)  
               END IF
               #150209-00008#9   ---(s)---
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapt300_09_unlock_b("apde_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apde_d[l_ac].* = g_apde_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            CALL aapt300_09_sum_page_show()
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            #重算帳款單頭
            CALL s_transaction_begin()
            CALL aapt300_09_clac_bill_master() RETURNING g_sub_success
            IF g_sub_success THEN 
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF
            #141202-00061-15--(S)
            IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
                    RETURNING g_sub_success
               IF g_sub_success THEN 
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
            END IF         
            #141202-00061-15--(E)
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde_d[li_reproduce_target].apdeld = NULL
               LET g_apde_d[li_reproduce_target].apdedocno = NULL
               LET g_apde_d[li_reproduce_target].apdeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apde_d.getLength()+1
            END IF
            
      END INPUT
      
      INPUT ARRAY g_apde2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL aapt300_09_b_fill(g_wc2)
            LET g_detail_cnt = g_apde2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD apdeld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apde2_d[l_ac].* TO NULL 
            INITIALIZE g_apde2_d_t.* TO NULL
            INITIALIZE g_apde2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.before_bak"
            
            #end add-point
            LET g_apde2_d_t.* = g_apde2_d[l_ac].*     #新輸入資料
            LET g_apde2_d_o.* = g_apde2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde2_d[li_reproduce_target].apdeld = NULL
               LET g_apde2_d[li_reproduce_target].apdedocno = NULL
               LET g_apde2_d[li_reproduce_target].apdeseq = NULL
            END IF
            
 
 
 
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"
            CALL s_transaction_begin()  #150419
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apde2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_apde2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apde2_d[l_ac].apdeld IS NOT NULL
               AND g_apde2_d[l_ac].apdedocno IS NOT NULL
               AND g_apde2_d[l_ac].apdeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apde2_d_t.* = g_apde2_d[l_ac].*  #BACKUP
               LET g_apde2_d_o.* = g_apde2_d[l_ac].*  #BACKUP
               IF NOT aapt300_09_lock_b("apde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_09_bcl INTO g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apdeseq, 
                      g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008, 
                      g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016, 
                      g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119, 
                      g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
                      g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041, 
                      g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
                      g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apdedocno, 
                      g_apde2_d[l_ac].apdeld,g_apde2_d[l_ac].apdeseq,g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018, 
                      g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023, 
                      g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043, 
                      g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053, 
                      g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057, 
                      g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apdedocno, 
                      g_apde3_d[l_ac].apdeld,g_apde3_d[l_ac].apdeseq,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121, 
                      g_apde3_d[l_ac].apde129,g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH aapt300_09_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apde2_d_mask_o[l_ac].* =  g_apde2_d[l_ac].*
                  CALL aapt300_09_apde_t_mask()
                  LET g_apde2_d_mask_n[l_ac].* =  g_apde2_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL aapt300_09_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #取得自由核算項資訊
            IF NOT cl_null(g_apde2_d[l_ac].apde0162) THEN
               CALL s_fin_sel_glad(g_apca.apcald,g_apde_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*                
            ELSE
               INITIALIZE g_glad.* TO NULL
            END IF 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point 
               
               DELETE FROM apde_t
                WHERE apdeent = g_enterprise AND
                  apdeld = g_apde2_d_t.apdeld
                  AND apdedocno = g_apde2_d_t.apdedocno
                  AND apdeseq = g_apde2_d_t.apdeseq
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_09_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apde2_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_09_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"
               
               #end add-point
               LET l_count = g_apde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde2_d_t.apdeld
               LET gs_keys[2] = g_apde2_d_t.apdedocno
               LET gs_keys[3] = g_apde2_d_t.apdeseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_09_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"
               
               #end add-point
                              CALL aapt300_09_delete_b('apde_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apde2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body2.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
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
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND
                   apdeld = g_apde2_d[l_ac].apdeld
                   AND apdedocno = g_apde2_d[l_ac].apdedocno
                   AND apdeseq = g_apde2_d[l_ac].apdeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde2_d[g_detail_idx].apdeld
               LET gs_keys[2] = g_apde2_d[g_detail_idx].apdedocno
               LET gs_keys[3] = g_apde2_d[g_detail_idx].apdeseq
               CALL aapt300_09_insert_b('apde_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_09_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (apdeld = '", g_apde2_d[l_ac].apdeld, "' "
                                  ," AND apdedocno = '", g_apde2_d[l_ac].apdedocno, "' "
                                  ," AND apdeseq = '", g_apde2_d[l_ac].apdeseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_apde2_d[l_ac].* = g_apde2_d_t.*
               CLOSE aapt300_09_bcl
               #add-point:單身page2取消後 name="input.body2.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apde2_d[l_ac].* = g_apde2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_09_apde_t_mask_restore('restore_mask_o')
               
               UPDATE apde_t SET (apdedocno,apdeld,apdeseq,apdeorga,apde002,apde006,apde008,apde021, 
                   apde024,apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010, 
                   apde009,apde039,apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038, 
                   apde061,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043, 
                   apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060, 
                   apde120,apde121,apde129,apde130,apde131,apde139) = (g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld, 
                   g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006, 
                   g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015, 
                   g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101, 
                   g_apde_d[l_ac].apde119,g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014, 
                   g_apde_d[l_ac].apde010,g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040, 
                   g_apde_d[l_ac].apde041,g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp, 
                   g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061, 
                   g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020, 
                   g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036, 
                   g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051, 
                   g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055, 
                   g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059, 
                   g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129, 
                   g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139) #自訂欄位頁簽 
 
                WHERE apdeent = g_enterprise AND
                  apdeld = g_apde2_d_t.apdeld #項次 
                  AND apdedocno = g_apde2_d_t.apdedocno
                  AND apdeseq = g_apde2_d_t.apdeseq
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde2_d[g_detail_idx].apdeld
               LET gs_keys_bak[1] = g_apde2_d_t.apdeld
               LET gs_keys[2] = g_apde2_d[g_detail_idx].apdedocno
               LET gs_keys_bak[2] = g_apde2_d_t.apdedocno
               LET gs_keys[3] = g_apde2_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apde2_d_t.apdeseq
               CALL aapt300_09_update_b('apde_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apde2_d_t)
                     LET g_log2 = util.JSON.stringify(g_apde2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_09_apde_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde0162
            #add-point:BEFORE FIELD apde0162 name="input.b.page2.apde0162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde0162
            
            #add-point:AFTER FIELD apde0162 name="input.a.page2.apde0162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde0162
            #add-point:ON CHANGE apde0162 name="input.g.page2.apde0162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde0162_desc
            #add-point:BEFORE FIELD apde0162_desc name="input.b.page2.apde0162_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde0162_desc
            
            #add-point:AFTER FIELD apde0162_desc name="input.a.page2.apde0162_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde0162_desc
            #add-point:ON CHANGE apde0162_desc name="input.g.page2.apde0162_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="input.b.page2.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="input.a.page2.apde017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde017
            #add-point:ON CHANGE apde017 name="input.g.page2.apde017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017_desc
            #add-point:BEFORE FIELD apde017_desc name="input.b.page2.apde017_desc"
            LET g_apde2_d[l_ac].apde017_desc = g_apde2_d[l_ac].apde017   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017_desc
            
            #add-point:AFTER FIELD apde017_desc name="input.a.page2.apde017_desc"
            #業務人員
            IF NOT cl_null(g_apde2_d[l_ac].apde017_desc) THEN
               IF ( g_apde2_d[l_ac].apde017_desc != g_apde2_d_t.apde017_desc OR g_apde2_d_t.apde017_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde017 = g_apde2_d[l_ac].apde017_desc                  
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde017 != g_apde2_d_t.apde017 OR g_apde2_d_t.apde017 IS NULL) THEN                       
                        CALL s_employee_chk(g_apde2_d[l_ac].apde017_desc)RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apde2_d[l_ac].apde017      = g_apde2_d_t.apde017
                           LET g_apde2_d[l_ac].apde017_desc = g_apde2_d_t.apde017_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde017 ,g_apde2_d[l_ac].apde017_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde017 = ''
            END IF
            LET g_apde2_d[l_ac].apde017_desc = s_desc_show1(g_apde2_d[l_ac].apde017,s_desc_get_person_desc(g_apde2_d[l_ac].apde017))         
            DISPLAY BY NAME g_apde2_d[l_ac].apde017 ,g_apde2_d[l_ac].apde017_desc
            LET g_apde2_d_t.apde017_desc = g_apde2_d[l_ac].apde017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde017_desc
            #add-point:ON CHANGE apde017_desc name="input.g.page2.apde017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="input.b.page2.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="input.a.page2.apde018"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde018
            #add-point:ON CHANGE apde018 name="input.g.page2.apde018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018_desc
            #add-point:BEFORE FIELD apde018_desc name="input.b.page2.apde018_desc"
            LET g_apde2_d[l_ac].apde018_desc = g_apde2_d[l_ac].apde018   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018_desc
            
            #add-point:AFTER FIELD apde018_desc name="input.a.page2.apde018_desc"
            #部門
            IF NOT cl_null(g_apde2_d[l_ac].apde018_desc) THEN
               IF ( g_apde2_d[l_ac].apde018_desc != g_apde2_d_t.apde018_desc OR g_apde2_d_t.apde018_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde018 = g_apde2_d[l_ac].apde018_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde018 != g_apde2_d_t.apde018 OR g_apde2_d_t.apde018 IS NULL) THEN                  
                        CALL s_department_chk(g_apde2_d[l_ac].apde018_desc,g_apca.apcadocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apde2_d[l_ac].apde018      = g_apde2_d_t.apde018
                           LET g_apde2_d[l_ac].apde018_desc = g_apde2_d_t.apde018_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde018 ,g_apde2_d[l_ac].apde018_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF 
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde018 = ''
            END IF
            LET g_apde2_d[l_ac].apde018_desc = s_desc_show1(g_apde2_d[l_ac].apde018,s_desc_get_department_desc(g_apde2_d[l_ac].apde018))         
            DISPLAY BY NAME g_apde2_d[l_ac].apde018 ,g_apde2_d[l_ac].apde018_desc
            LET g_apde2_d_t.apde018_desc = g_apde2_d[l_ac].apde018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde018_desc
            #add-point:ON CHANGE apde018_desc name="input.g.page2.apde018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="input.b.page2.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="input.a.page2.apde019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde019
            #add-point:ON CHANGE apde019 name="input.g.page2.apde019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019_desc
            #add-point:BEFORE FIELD apde019_desc name="input.b.page2.apde019_desc"
            LET g_apde2_d[l_ac].apde019_desc = g_apde2_d[l_ac].apde019   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019_desc
            
            #add-point:AFTER FIELD apde019_desc name="input.a.page2.apde019_desc"
            #責任中心
            IF NOT cl_null(g_apde2_d[l_ac].apde019_desc) THEN
               IF ( g_apde2_d[l_ac].apde019_desc != g_apde2_d_t.apde019_desc OR g_apde2_d_t.apde019_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde019 = g_apde2_d[l_ac].apde019_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde019 != g_apde2_d_t.apde019 OR g_apde2_d_t.apde019 IS NULL) THEN
                        #CALL s_department_chk(g_apde2_d[l_ac].apde019_desc,g_apca.apcadocdt) RETURNING g_sub_success
                        LET g_errno = ''                                                       #20150302
                        CALL s_voucher_glaq019_chk(g_apde2_d[l_ac].apde019_desc,g_apca.apcadocdt) #20150302
                        IF NOT cl_null(g_errno) THEN
                           LET g_apde2_d[l_ac].apde019      = g_apde2_d_t.apde019
                           LET g_apde2_d[l_ac].apde019_desc = g_apde2_d_t.apde019_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde019 ,g_apde2_d[l_ac].apde019_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde019 = ''
            END IF
            LET g_apde2_d[l_ac].apde019_desc = s_desc_show1(g_apde2_d[l_ac].apde019,s_desc_get_department_desc(g_apde2_d[l_ac].apde019))         
            DISPLAY BY NAME g_apde2_d[l_ac].apde019 ,g_apde2_d[l_ac].apde019_desc 
            LET g_apde2_d_t.apde019_desc = g_apde2_d[l_ac].apde019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde019_desc
            #add-point:ON CHANGE apde019_desc name="input.g.page2.apde019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020
            #add-point:BEFORE FIELD apde020 name="input.b.page2.apde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020
            
            #add-point:AFTER FIELD apde020 name="input.a.page2.apde020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde020
            #add-point:ON CHANGE apde020 name="input.g.page2.apde020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020_desc
            #add-point:BEFORE FIELD apde020_desc name="input.b.page2.apde020_desc"
            LET g_apde2_d[l_ac].apde020_desc = g_apde2_d[l_ac].apde020   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020_desc
            
            #add-point:AFTER FIELD apde020_desc name="input.a.page2.apde020_desc"
            #產品類別
            IF NOT cl_null(g_apde2_d[l_ac].apde020_desc) THEN
               IF ( g_apde2_d[l_ac].apde020_desc != g_apde2_d_t.apde020_desc OR g_apde2_d_t.apde020_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde020 = g_apde2_d[l_ac].apde020_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde020 != g_apde2_d_t.apde020 OR g_apde2_d_t.apde020 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_apde2_d[l_ac].apde020)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'arti202'
                           LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                           LET g_errparam.exeprog = 'arti202'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde020      = g_apde2_d_t.apde020
                           LET g_apde2_d[l_ac].apde020_desc = g_apde2_d_t.apde020_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde020 ,g_apde2_d[l_ac].apde020_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde020 = ''
            END IF
            LET g_apde2_d[l_ac].apde020_desc = s_desc_show1(g_apde2_d[l_ac].apde020,s_desc_get_rtaxl003_desc(g_apde2_d[l_ac].apde020))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde020 ,g_apde2_d[l_ac].apde020_desc
            LET g_apde2_d_t.apde020_desc = g_apde2_d[l_ac].apde020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde020_desc
            #add-point:ON CHANGE apde020_desc name="input.g.page2.apde020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022
            #add-point:BEFORE FIELD apde022 name="input.b.page2.apde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022
            
            #add-point:AFTER FIELD apde022 name="input.a.page2.apde022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde022
            #add-point:ON CHANGE apde022 name="input.g.page2.apde022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022_desc
            #add-point:BEFORE FIELD apde022_desc name="input.b.page2.apde022_desc"
            LET g_apde2_d[l_ac].apde022_desc = g_apde2_d[l_ac].apde022   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022_desc
            
            #add-point:AFTER FIELD apde022_desc name="input.a.page2.apde022_desc"
            #專案代號
            IF NOT cl_null(g_apde2_d[l_ac].apde022_desc) THEN
               IF ( g_apde2_d[l_ac].apde022_desc != g_apde2_d_t.apde022_desc OR g_apde2_d_t.apde022_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde022 = g_apde2_d[l_ac].apde022_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde022 != g_apde2_d_t.apde022 OR g_apde2_d_t.apde022 IS NULL) THEN
                        CALL s_aap_project_chk(g_apde2_d[l_ac].apde022) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'apjm200'
                           LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                           LET g_errparam.exeprog = 'apjm200'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde022      = g_apde2_d_t.apde022
                           LET g_apde2_d[l_ac].apde022_desc = g_apde2_d_t.apde022_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde022 ,g_apde2_d[l_ac].apde022_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF 
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde022 = ''
            END IF
            LET g_apde2_d[l_ac].apde022_desc = s_desc_show1(g_apde2_d[l_ac].apde022,s_desc_get_project_desc(g_apde2_d[l_ac].apde022))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde022 ,g_apde2_d[l_ac].apde022_desc
            LET g_apde2_d_t.apde022_desc = g_apde2_d[l_ac].apde022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde022_desc
            #add-point:ON CHANGE apde022_desc name="input.g.page2.apde022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023
            #add-point:BEFORE FIELD apde023 name="input.b.page2.apde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023
            
            #add-point:AFTER FIELD apde023 name="input.a.page2.apde023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde023
            #add-point:ON CHANGE apde023 name="input.g.page2.apde023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023_desc
            #add-point:BEFORE FIELD apde023_desc name="input.b.page2.apde023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023_desc
            
            #add-point:AFTER FIELD apde023_desc name="input.a.page2.apde023_desc"
            #WBS
            IF NOT cl_null(g_apde2_d[l_ac].apde023_desc)  THEN
               IF ( g_apde2_d[l_ac].apde023_desc != g_apde2_d_t.apde023_desc OR g_apde2_d_t.apde023_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde023 = g_apde2_d[l_ac].apde023_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde023 != g_apde2_d_t.apde023 OR g_apde2_d_t.apde023 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023)
                       #CALL s_aap_project_chk( g_apde2_d[l_ac].apde023) RETURNING g_sub_success,g_errno
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde023        = g_apde2_d_t.apde023
                           LET g_apde2_d[l_ac].apde023_desc = g_apde2_d_t.apde023_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde023 = ''
            END IF
            LET g_apde2_d[l_ac].apde023_desc = s_desc_show1(g_apde2_d[l_ac].apde023,s_desc_get_pjbbl004_desc(g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023))
            DISPLAY BY NAME g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde023_desc
            LET g_apde2_d_t.apde023_desc = g_apde2_d[l_ac].apde023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde023_desc
            #add-point:ON CHANGE apde023_desc name="input.g.page2.apde023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035
            #add-point:BEFORE FIELD apde035 name="input.b.page2.apde035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035
            
            #add-point:AFTER FIELD apde035 name="input.a.page2.apde035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde035
            #add-point:ON CHANGE apde035 name="input.g.page2.apde035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035_desc
            #add-point:BEFORE FIELD apde035_desc name="input.b.page2.apde035_desc"
            LET g_apde2_d[l_ac].apde035_desc = g_apde2_d[l_ac].apde035   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035_desc
            
            #add-point:AFTER FIELD apde035_desc name="input.a.page2.apde035_desc"
            #區域
            IF NOT cl_null(g_apde2_d[l_ac].apde035_desc) THEN
               IF ( g_apde2_d[l_ac].apde035_desc != g_apde2_d_t.apde035_desc OR g_apde2_d_t.apde035_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde035 = g_apde2_d[l_ac].apde035_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde035 != g_apde2_d_t.apde035 OR g_apde2_d_t.apde035 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_apde2_d[l_ac].apde035) THEN
                           LET g_apde2_d[l_ac].apde035      = g_apde2_d_t.apde035
                           LET g_apde2_d[l_ac].apde035_desc = g_apde2_d_t.apde035_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde035 ,g_apde2_d[l_ac].apde035_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF                  
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde035 = ''
            END IF
            LET g_apde2_d[l_ac].apde035_desc = s_desc_show1(g_apde2_d[l_ac].apde035,s_desc_get_acc_desc('287',g_apde2_d[l_ac].apde035))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde035 ,g_apde2_d[l_ac].apde035_desc
            LET g_apde2_d_t.apde035_desc = g_apde2_d[l_ac].apde035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde035_desc
            #add-point:ON CHANGE apde035_desc name="input.g.page2.apde035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036
            #add-point:BEFORE FIELD apde036 name="input.b.page2.apde036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036
            
            #add-point:AFTER FIELD apde036 name="input.a.page2.apde036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde036
            #add-point:ON CHANGE apde036 name="input.g.page2.apde036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036_desc
            #add-point:BEFORE FIELD apde036_desc name="input.b.page2.apde036_desc"
            LET g_apde2_d[l_ac].apde036_desc = g_apde2_d[l_ac].apde036   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036_desc
            
            #add-point:AFTER FIELD apde036_desc name="input.a.page2.apde036_desc"
            #客群
            IF NOT cl_null(g_apde2_d[l_ac].apde036_desc) THEN
               IF ( g_apde2_d[l_ac].apde036_desc != g_apde2_d_t.apde036_desc OR g_apde2_d_t.apde036_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde036 = g_apde2_d[l_ac].apde036_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde036 != g_apde2_d_t.apde036 OR g_apde2_d_t.apde036 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_apde2_d[l_ac].apde036) THEN
                           LET g_apde2_d[l_ac].apde036      = g_apde2_d_t.apde036
                           LET g_apde2_d[l_ac].apde036_desc = g_apde2_d_t.apde036_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde036 ,g_apde2_d[l_ac].apde036_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF                  
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde036 = ''
            END IF
            LET g_apde2_d[l_ac].apde036_desc = s_desc_show1(g_apde2_d[l_ac].apde036,s_desc_get_acc_desc('281',g_apde2_d[l_ac].apde036))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde036 ,g_apde2_d[l_ac].apde036_desc 
            LET g_apde2_d_t.apde036_desc = g_apde2_d[l_ac].apde036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde036_desc
            #add-point:ON CHANGE apde036_desc name="input.g.page2.apde036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042
            #add-point:BEFORE FIELD apde042 name="input.b.page2.apde042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042
            
            #add-point:AFTER FIELD apde042 name="input.a.page2.apde042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde042
            #add-point:ON CHANGE apde042 name="input.g.page2.apde042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042_desc
            #add-point:BEFORE FIELD apde042_desc name="input.b.page2.apde042_desc"
            LET g_apde2_d[l_ac].apde042_desc = g_apde2_d[l_ac].apde042   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042_desc
            
            #add-point:AFTER FIELD apde042_desc name="input.a.page2.apde042_desc"
            #經營方式
            IF NOT cl_null(g_apde2_d[l_ac].apde042_desc) THEN
               IF ( g_apde2_d[l_ac].apde042_desc != g_apde2_d_t.apde042_desc OR g_apde2_d_t.apde042_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde042 = g_apde2_d[l_ac].apde042_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde042 != g_apde2_d_t.apde042 OR g_apde2_d_t.apde042 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_apde2_d[l_ac].apde042) 
                        IF NOT cl_null(g_errno) THEN
                           LET g_apde2_d[l_ac].apde042      = g_apde2_d_t.apde042
                           LET g_apde2_d[l_ac].apde042_desc = g_apde2_d_t.apde042_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde042 ,g_apde2_d[l_ac].apde042_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde042 = ''
            END IF
            LET g_apde2_d[l_ac].apde042_desc = s_desc_show1(g_apde2_d[l_ac].apde042,s_desc_get_acc_desc('281',g_apde2_d[l_ac].apde042))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde042 ,g_apde2_d[l_ac].apde042_desc 
            LET g_apde2_d_t.apde042_desc = g_apde2_d[l_ac].apde042_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde042_desc
            #add-point:ON CHANGE apde042_desc name="input.g.page2.apde042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043
            #add-point:BEFORE FIELD apde043 name="input.b.page2.apde043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043
            
            #add-point:AFTER FIELD apde043 name="input.a.page2.apde043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde043
            #add-point:ON CHANGE apde043 name="input.g.page2.apde043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043_desc
            #add-point:BEFORE FIELD apde043_desc name="input.b.page2.apde043_desc"
            LET g_apde2_d[l_ac].apde043_desc = g_apde2_d[l_ac].apde043   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043_desc
            
            #add-point:AFTER FIELD apde043_desc name="input.a.page2.apde043_desc"
            #渠道
            IF NOT cl_null(g_apde2_d[l_ac].apde043_desc) THEN
               IF ( g_apde2_d[l_ac].apde043_desc != g_apde2_d_t.apde043_desc OR g_apde2_d_t.apde043_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde043 = g_apde2_d[l_ac].apde043_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde043 != g_apde2_d_t.apde043 OR g_apde2_d_t.apde043 IS NULL) THEN
                        CALL s_voucher_glaq052_chk(g_apde2_d[l_ac].apde043) 
                        IF NOT cl_null(g_errno) THEN
                           LET g_apde2_d[l_ac].apde043      = g_apde2_d_t.apde043
                           LET g_apde2_d[l_ac].apde043_desc = g_apde2_d_t.apde043_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde043 ,g_apde2_d[l_ac].apde043_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde043 = ''
            END IF
            LET g_apde2_d[l_ac].apde043_desc = s_desc_show1(g_apde2_d[l_ac].apde043,s_desc_get_oojdl003_desc(g_apde2_d[l_ac].apde043))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde043 ,g_apde2_d[l_ac].apde043_desc 
            LET g_apde2_d_t.apde043_desc = g_apde2_d[l_ac].apde043_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde043_desc
            #add-point:ON CHANGE apde043_desc name="input.g.page2.apde043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044
            #add-point:BEFORE FIELD apde044 name="input.b.page2.apde044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044
            
            #add-point:AFTER FIELD apde044 name="input.a.page2.apde044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde044
            #add-point:ON CHANGE apde044 name="input.g.page2.apde044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044_desc
            #add-point:BEFORE FIELD apde044_desc name="input.b.page2.apde044_desc"
            LET g_apde2_d[l_ac].apde044_desc = g_apde2_d[l_ac].apde044   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044_desc
            
            #add-point:AFTER FIELD apde044_desc name="input.a.page2.apde044_desc"
            #品牌
             IF NOT cl_null(g_apde2_d[l_ac].apde044_desc) THEN
               IF ( g_apde2_d[l_ac].apde044_desc != g_apde2_d_t.apde044_desc OR g_apde2_d_t.apde044_desc IS NULL ) THEN
                  LET g_apde2_d[l_ac].apde044 = g_apde2_d[l_ac].apde044_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde044 != g_apde2_d_t.apde044 OR g_apde2_d_t.apde044 IS NULL) THEN                  
                        IF NOT s_azzi650_chk_exist('2002',g_apde2_d[l_ac].apde044) THEN
                           LET g_apde2_d[l_ac].apde044      = g_apde2_d_t.apde044
                           LET g_apde2_d[l_ac].apde044_desc = g_apde2_d_t.apde044_desc
                           DISPLAY BY NAME g_apde2_d[l_ac].apde044 ,g_apde2_d[l_ac].apde044_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde044 = ''
            END IF
            LET g_apde2_d[l_ac].apde044_desc = s_desc_show1(g_apde2_d[l_ac].apde044,s_desc_get_acc_desc('2002',g_apde2_d[l_ac].apde044))      
            DISPLAY BY NAME g_apde2_d[l_ac].apde044 ,g_apde2_d[l_ac].apde044_desc 
            LET g_apde2_d_t.apde044_desc = g_apde2_d[l_ac].apde044_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde044_desc
            #add-point:ON CHANGE apde044_desc name="input.g.page2.apde044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051
            #add-point:BEFORE FIELD apde051 name="input.b.page2.apde051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051
            
            #add-point:AFTER FIELD apde051 name="input.a.page2.apde051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde051
            #add-point:ON CHANGE apde051 name="input.g.page2.apde051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051_desc
            #add-point:BEFORE FIELD apde051_desc name="input.b.page2.apde051_desc"
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde051_desc = g_apde2_d[l_ac].apde051   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051_desc
            
            #add-point:AFTER FIELD apde051_desc name="input.a.page2.apde051_desc"
            #自由核算項一
            IF NOT cl_null(g_apde2_d[l_ac].apde051_desc) THEN
               IF (g_apde2_d[l_ac].apde051_desc != g_apde2_d_t.apde051_desc OR g_apde2_d_t.apde051_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde051 = g_apde2_d[l_ac].apde051_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde051 != g_apde2_d_t.apde051 OR g_apde2_d_t.apde051 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_apde2_d[l_ac].apde051,g_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde051 = g_apde2_d_t.apde051
                           LET g_apde2_d[l_ac].apde051_desc = s_desc_show1(g_apde2_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apde2_d[l_ac].apde051))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde051_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde051 = ''
            END IF
            LET g_apde2_d[l_ac].apde051_desc = s_desc_show1(g_apde2_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apde2_d[l_ac].apde051))
            DISPLAY BY NAME g_apde2_d[l_ac].apde051_desc
            LET g_apde2_d_t.apde051_desc = g_apde2_d[l_ac].apde051_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde051_desc
            #add-point:ON CHANGE apde051_desc name="input.g.page2.apde051_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052
            #add-point:BEFORE FIELD apde052 name="input.b.page2.apde052"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052
            
            #add-point:AFTER FIELD apde052 name="input.a.page2.apde052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde052
            #add-point:ON CHANGE apde052 name="input.g.page2.apde052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052_desc
            #add-point:BEFORE FIELD apde052_desc name="input.b.page2.apde052_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde052_desc = g_apde2_d[l_ac].apde052   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052_desc
            
            #add-point:AFTER FIELD apde052_desc name="input.a.page2.apde052_desc"
            #自由核算項二
            IF NOT cl_null(g_apde2_d[l_ac].apde052_desc) THEN
               IF (g_apde2_d[l_ac].apde052_desc != g_apde2_d_t.apde052_desc OR g_apde2_d_t.apde052_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde052 = g_apde2_d[l_ac].apde052_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde052 != g_apde2_d_t.apde052 OR g_apde2_d_t.apde052 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_apde2_d[l_ac].apde052,g_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde052 = g_apde2_d_t.apde052
                           LET g_apde2_d[l_ac].apde052_desc = s_desc_show1(g_apde2_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apde2_d[l_ac].apde052))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde052_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde052 = ''
            END IF
            LET g_apde2_d[l_ac].apde052_desc = s_desc_show1(g_apde2_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apde2_d[l_ac].apde052))
            DISPLAY BY NAME g_apde2_d[l_ac].apde052_desc
            LET g_apde2_d_t.apde052_desc = g_apde2_d[l_ac].apde052_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde052_desc
            #add-point:ON CHANGE apde052_desc name="input.g.page2.apde052_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053
            #add-point:BEFORE FIELD apde053 name="input.b.page2.apde053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053
            
            #add-point:AFTER FIELD apde053 name="input.a.page2.apde053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde053
            #add-point:ON CHANGE apde053 name="input.g.page2.apde053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053_desc
            #add-point:BEFORE FIELD apde053_desc name="input.b.page2.apde053_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde053_desc = g_apde2_d[l_ac].apde053   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053_desc
            
            #add-point:AFTER FIELD apde053_desc name="input.a.page2.apde053_desc"
            #自由核算項三
            IF NOT cl_null(g_apde2_d[l_ac].apde053_desc) THEN
               IF (g_apde2_d[l_ac].apde053_desc != g_apde2_d_t.apde053_desc OR g_apde2_d_t.apde053_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde053 = g_apde2_d[l_ac].apde053_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde053 != g_apde2_d_t.apde053 OR g_apde2_d_t.apde053 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_apde2_d[l_ac].apde053,g_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde053 = g_apde2_d_t.apde053
                           LET g_apde2_d[l_ac].apde053_desc = s_desc_show1(g_apde2_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apde2_d[l_ac].apde053))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde053_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde053 = ''
            END IF
            LET g_apde2_d[l_ac].apde053_desc = s_desc_show1(g_apde2_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apde2_d[l_ac].apde053))
            DISPLAY BY NAME g_apde2_d[l_ac].apde053_desc
            LET g_apde2_d_t.apde053_desc = g_apde2_d[l_ac].apde053_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde053_desc
            #add-point:ON CHANGE apde053_desc name="input.g.page2.apde053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054
            #add-point:BEFORE FIELD apde054 name="input.b.page2.apde054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054
            
            #add-point:AFTER FIELD apde054 name="input.a.page2.apde054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde054
            #add-point:ON CHANGE apde054 name="input.g.page2.apde054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054_desc
            #add-point:BEFORE FIELD apde054_desc name="input.b.page2.apde054_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde054_desc = g_apde2_d[l_ac].apde054   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054_desc
            
            #add-point:AFTER FIELD apde054_desc name="input.a.page2.apde054_desc"
            #自由核算項四
            IF NOT cl_null(g_apde2_d[l_ac].apde054_desc) THEN
               IF (g_apde2_d[l_ac].apde054_desc != g_apde2_d_t.apde054_desc OR g_apde2_d_t.apde054_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde054 = g_apde2_d[l_ac].apde054_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde054 != g_apde2_d_t.apde054 OR g_apde2_d_t.apde054 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_apde2_d[l_ac].apde054,g_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde054 = g_apde2_d_t.apde054
                           LET g_apde2_d[l_ac].apde054_desc = s_desc_show1(g_apde2_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apde2_d[l_ac].apde054))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde054_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde054 = ''
            END IF
            LET g_apde2_d[l_ac].apde054_desc = s_desc_show1(g_apde2_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apde2_d[l_ac].apde054))
            DISPLAY BY NAME g_apde2_d[l_ac].apde054_desc
            LET g_apde2_d_t.apde054_desc = g_apde2_d[l_ac].apde054_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde054_desc
            #add-point:ON CHANGE apde054_desc name="input.g.page2.apde054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055
            #add-point:BEFORE FIELD apde055 name="input.b.page2.apde055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055
            
            #add-point:AFTER FIELD apde055 name="input.a.page2.apde055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde055
            #add-point:ON CHANGE apde055 name="input.g.page2.apde055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055_desc
            #add-point:BEFORE FIELD apde055_desc name="input.b.page2.apde055_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde055_desc = g_apde2_d[l_ac].apde055   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055_desc
            
            #add-point:AFTER FIELD apde055_desc name="input.a.page2.apde055_desc"
            #自由核算項五
            IF NOT cl_null(g_apde2_d[l_ac].apde055_desc) THEN
               IF (g_apde2_d[l_ac].apde055_desc != g_apde2_d_t.apde055_desc OR g_apde2_d_t.apde055_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde055 = g_apde2_d[l_ac].apde055_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde055 != g_apde2_d_t.apde055 OR g_apde2_d_t.apde055 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_apde2_d[l_ac].apde055,g_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde055 = g_apde2_d_t.apde055
                           LET g_apde2_d[l_ac].apde055_desc = s_desc_show1(g_apde2_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apde2_d[l_ac].apde055))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde055_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde055 = ''
            END IF
            LET g_apde2_d[l_ac].apde055_desc = s_desc_show1(g_apde2_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apde2_d[l_ac].apde055))
            DISPLAY BY NAME g_apde2_d[l_ac].apde055_desc
            LET g_apde2_d_t.apde055_desc = g_apde2_d[l_ac].apde055_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde055_desc
            #add-point:ON CHANGE apde055_desc name="input.g.page2.apde055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056
            #add-point:BEFORE FIELD apde056 name="input.b.page2.apde056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056
            
            #add-point:AFTER FIELD apde056 name="input.a.page2.apde056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde056
            #add-point:ON CHANGE apde056 name="input.g.page2.apde056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056_desc
            #add-point:BEFORE FIELD apde056_desc name="input.b.page2.apde056_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde056_desc = g_apde2_d[l_ac].apde056   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056_desc
            
            #add-point:AFTER FIELD apde056_desc name="input.a.page2.apde056_desc"
            #自由核算項六
            IF NOT cl_null(g_apde2_d[l_ac].apde056_desc) THEN
               IF (g_apde2_d[l_ac].apde056_desc != g_apde2_d_t.apde056_desc OR g_apde2_d_t.apde056_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde056 = g_apde2_d[l_ac].apde056_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde056 != g_apde2_d_t.apde056 OR g_apde2_d_t.apde056 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_apde2_d[l_ac].apde056,g_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde056 = g_apde2_d_t.apde056
                           LET g_apde2_d[l_ac].apde056_desc = s_desc_show1(g_apde2_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apde2_d[l_ac].apde056))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde056_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde056 = ''
            END IF
            LET g_apde2_d[l_ac].apde056_desc = s_desc_show1(g_apde2_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apde2_d[l_ac].apde056))
            DISPLAY BY NAME g_apde2_d[l_ac].apde056_desc
            LET g_apde2_d_t.apde056_desc = g_apde2_d[l_ac].apde056_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde056_desc
            #add-point:ON CHANGE apde056_desc name="input.g.page2.apde056_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057
            #add-point:BEFORE FIELD apde057 name="input.b.page2.apde057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057
            
            #add-point:AFTER FIELD apde057 name="input.a.page2.apde057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde057
            #add-point:ON CHANGE apde057 name="input.g.page2.apde057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057_desc
            #add-point:BEFORE FIELD apde057_desc name="input.b.page2.apde057_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde057_desc = g_apde2_d[l_ac].apde057   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057_desc
            
            #add-point:AFTER FIELD apde057_desc name="input.a.page2.apde057_desc"
            #自由核算項七
            IF NOT cl_null(g_apde2_d[l_ac].apde057_desc) THEN
               IF (g_apde2_d[l_ac].apde057_desc != g_apde2_d_t.apde057_desc OR g_apde2_d_t.apde057_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde057 = g_apde2_d[l_ac].apde057_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde057 != g_apde2_d_t.apde057 OR g_apde2_d_t.apde057 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_apde2_d[l_ac].apde057,g_glad.glad0232) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde057 = g_apde2_d_t.apde057
                           LET g_apde2_d[l_ac].apde057_desc = s_desc_show1(g_apde2_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apde2_d[l_ac].apde057))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde057_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde057 = ''
            END IF
            LET g_apde2_d[l_ac].apde057_desc = s_desc_show1(g_apde2_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apde2_d[l_ac].apde057))
            DISPLAY BY NAME g_apde2_d[l_ac].apde057_desc
            LET g_apde2_d_t.apde057_desc = g_apde2_d[l_ac].apde057_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde057_desc
            #add-point:ON CHANGE apde057_desc name="input.g.page2.apde057_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058
            #add-point:BEFORE FIELD apde058 name="input.b.page2.apde058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058
            
            #add-point:AFTER FIELD apde058 name="input.a.page2.apde058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde058
            #add-point:ON CHANGE apde058 name="input.g.page2.apde058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058_desc
            #add-point:BEFORE FIELD apde058_desc name="input.b.page2.apde058_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde058_desc = g_apde2_d[l_ac].apde058   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058_desc
            
            #add-point:AFTER FIELD apde058_desc name="input.a.page2.apde058_desc"
            #自由核算項八
            IF NOT cl_null(g_apde2_d[l_ac].apde058_desc) THEN
               IF (g_apde2_d[l_ac].apde058_desc != g_apde2_d_t.apde058_desc OR g_apde2_d_t.apde058_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde058 = g_apde2_d[l_ac].apde058_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde058 != g_apde2_d_t.apde058 OR g_apde2_d_t.apde058 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_apde2_d[l_ac].apde058,g_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde058 = g_apde2_d_t.apde058
                           LET g_apde2_d[l_ac].apde058_desc = s_desc_show1(g_apde2_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apde2_d[l_ac].apde058))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde058_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde058 = ''
            END IF
            LET g_apde2_d[l_ac].apde058_desc = s_desc_show1(g_apde2_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apde2_d[l_ac].apde058))
            DISPLAY BY NAME g_apde2_d[l_ac].apde058_desc
            LET g_apde2_d_t.apde058_desc = g_apde2_d[l_ac].apde058_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde058_desc
            #add-point:ON CHANGE apde058_desc name="input.g.page2.apde058_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059
            #add-point:BEFORE FIELD apde059 name="input.b.page2.apde059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059
            
            #add-point:AFTER FIELD apde059 name="input.a.page2.apde059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde059
            #add-point:ON CHANGE apde059 name="input.g.page2.apde059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059_desc
            #add-point:BEFORE FIELD apde059_desc name="input.b.page2.apde059_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde059_desc = g_apde2_d[l_ac].apde059   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059_desc
            
            #add-point:AFTER FIELD apde059_desc name="input.a.page2.apde059_desc"
            #自由核算項九
            IF NOT cl_null(g_apde2_d[l_ac].apde059_desc) THEN
               IF (g_apde2_d[l_ac].apde059_desc != g_apde2_d_t.apde059_desc OR g_apde2_d_t.apde059_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde059 = g_apde2_d[l_ac].apde059_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde059 != g_apde2_d_t.apde059 OR g_apde2_d_t.apde059 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_apde2_d[l_ac].apde059,g_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde059 = g_apde2_d_t.apde059
                           LET g_apde2_d[l_ac].apde059_desc = s_desc_show1(g_apde2_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apde2_d[l_ac].apde059))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde059_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde059 = ''
            END IF
            LET g_apde2_d[l_ac].apde059_desc = s_desc_show1(g_apde2_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apde2_d[l_ac].apde059))
            DISPLAY BY NAME g_apde2_d[l_ac].apde059_desc
            LET g_apde2_d_t.apde059_desc = g_apde2_d[l_ac].apde059_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde059_desc
            #add-point:ON CHANGE apde059_desc name="input.g.page2.apde059_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060
            #add-point:BEFORE FIELD apde060 name="input.b.page2.apde060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060
            
            #add-point:AFTER FIELD apde060 name="input.a.page2.apde060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde060
            #add-point:ON CHANGE apde060 name="input.g.page2.apde060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060_desc
            #add-point:BEFORE FIELD apde060_desc name="input.b.page2.apde060_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apde2_d[l_ac].apde060_desc = g_apde2_d[l_ac].apde060   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060_desc
            
            #add-point:AFTER FIELD apde060_desc name="input.a.page2.apde060_desc"
            #自由核算項十
            IF NOT cl_null(g_apde2_d[l_ac].apde060_desc) THEN
               IF (g_apde2_d[l_ac].apde060_desc != g_apde2_d_t.apde060_desc OR g_apde2_d_t.apde060_desc IS NULL) THEN
                  LET g_apde2_d[l_ac].apde060 = g_apde2_d[l_ac].apde060_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apde2_d[l_ac].apde060 != g_apde2_d_t.apde060 OR g_apde2_d_t.apde060 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_apde2_d[l_ac].apde060,g_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           #160321-00016#21 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#21 --e add
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apde2_d[l_ac].apde060 = g_apde2_d_t.apde060
                           LET g_apde2_d[l_ac].apde060_desc = s_desc_show1(g_apde2_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apde2_d[l_ac].apde060))
                           DISPLAY BY NAME g_apde2_d[l_ac].apde060_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apde2_d[l_ac].apde060 = ''
            END IF
            LET g_apde2_d[l_ac].apde060_desc = s_desc_show1(g_apde2_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apde2_d[l_ac].apde060))
            DISPLAY BY NAME g_apde2_d[l_ac].apde060_desc
            LET g_apde2_d_t.apde060_desc = g_apde2_d[l_ac].apde060_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde060_desc
            #add-point:ON CHANGE apde060_desc name="input.g.page2.apde060_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apde0162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde0162
            #add-point:ON ACTION controlp INFIELD apde0162 name="input.c.page2.apde0162"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde0162_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde0162_desc
            #add-point:ON ACTION controlp INFIELD apde0162_desc name="input.c.page2.apde0162_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="input.c.page2.apde017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017_desc
            #add-point:ON ACTION controlp INFIELD apde017_desc name="input.c.page2.apde017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde017
            CALL q_ooag001_8()                          
            LET g_apde2_d[l_ac].apde017 = g_qryparam.return1    
            LET g_apde2_d[l_ac].apde017_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde017_desc
            NEXT FIELD apde017_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="input.c.page2.apde018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018_desc
            #add-point:ON ACTION controlp INFIELD apde018_desc name="input.c.page2.apde018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde018
            LET g_qryparam.arg1 = g_apca.apcadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apde2_d[l_ac].apde018 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde018_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde018_desc
            NEXT FIELD apde018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="input.c.page2.apde019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019_desc
            #add-point:ON ACTION controlp INFIELD apde019_desc name="input.c.page2.apde019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde019
            LET g_qryparam.arg1 = g_apca.apcadocdt
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_5()
            LET g_apde2_d[l_ac].apde019 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde019_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde019_desc
            NEXT FIELD apde019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020
            #add-point:ON ACTION controlp INFIELD apde020 name="input.c.page2.apde020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020_desc
            #add-point:ON ACTION controlp INFIELD apde020_desc name="input.c.page2.apde020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde020
            CALL q_rtax001()                          
            LET g_apde2_d[l_ac].apde020 = g_qryparam.return1    
            LET g_apde2_d[l_ac].apde020_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde020_desc
            NEXT FIELD apde020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022
            #add-point:ON ACTION controlp INFIELD apde022 name="input.c.page2.apde022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022_desc
            #add-point:ON ACTION controlp INFIELD apde022_desc name="input.c.page2.apde022_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde022
            CALL q_pjba001()
            LET g_apde2_d[l_ac].apde022 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde022_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde022_desc
            NEXT FIELD apde022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023
            #add-point:ON ACTION controlp INFIELD apde023 name="input.c.page2.apde023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023_desc
            #add-point:ON ACTION controlp INFIELD apde023_desc name="input.c.page2.apde023_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde023
            IF NOT cl_null(g_apde2_d[l_ac].apde022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apde2_d[l_ac].apde022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF

            CALL q_pjbb002()
            LET g_apde2_d[l_ac].apde023        = g_qryparam.return1
            LET g_apde2_d[l_ac].apde023_desc = g_apde2_d[l_ac].apde023
            DISPLAY BY NAME g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde023_desc
            NEXT FIELD apde023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035
            #add-point:ON ACTION controlp INFIELD apde035 name="input.c.page2.apde035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035_desc
            #add-point:ON ACTION controlp INFIELD apde035_desc name="input.c.page2.apde035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde035
            CALL q_oocq002_287()
            LET g_apde2_d[l_ac].apde035 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde035_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde035_desc
            NEXT FIELD apde035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036
            #add-point:ON ACTION controlp INFIELD apde036 name="input.c.page2.apde036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036_desc
            #add-point:ON ACTION controlp INFIELD apde036_desc name="input.c.page2.apde036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde036
            CALL q_oocq002_281()
            LET g_apde2_d[l_ac].apde036 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde036_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde036_desc
            NEXT FIELD apde036_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042
            #add-point:ON ACTION controlp INFIELD apde042 name="input.c.page2.apde042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042_desc
            #add-point:ON ACTION controlp INFIELD apde042_desc name="input.c.page2.apde042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043
            #add-point:ON ACTION controlp INFIELD apde043 name="input.c.page2.apde043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043_desc
            #add-point:ON ACTION controlp INFIELD apde043_desc name="input.c.page2.apde043_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde043
            CALL q_oojd001_2()
            LET g_apde2_d[l_ac].apde043 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde043_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde043_desc
            NEXT FIELD apde043_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044
            #add-point:ON ACTION controlp INFIELD apde044 name="input.c.page2.apde044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044_desc
            #add-point:ON ACTION controlp INFIELD apde044_desc name="input.c.page2.apde044_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde2_d[l_ac].apde044
            CALL q_oocq002_2002()
            LET g_apde2_d[l_ac].apde044 = g_qryparam.return1   
            LET g_apde2_d[l_ac].apde044_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde044_desc
            NEXT FIELD apde044_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051
            #add-point:ON ACTION controlp INFIELD apde051 name="input.c.page2.apde051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde051_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051_desc
            #add-point:ON ACTION controlp INFIELD apde051_desc name="input.c.page2.apde051_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde051
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde051      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde051_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde051_desc
               NEXT FIELD apde051_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052
            #add-point:ON ACTION controlp INFIELD apde052 name="input.c.page2.apde052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde052_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052_desc
            #add-point:ON ACTION controlp INFIELD apde052_desc name="input.c.page2.apde052_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde052
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde052      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde052_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde052_desc
               NEXT FIELD apde052_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053
            #add-point:ON ACTION controlp INFIELD apde053 name="input.c.page2.apde053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053_desc
            #add-point:ON ACTION controlp INFIELD apde053_desc name="input.c.page2.apde053_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde053
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde053      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde053_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde053_desc
               NEXT FIELD apde053_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054
            #add-point:ON ACTION controlp INFIELD apde054 name="input.c.page2.apde054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054_desc
            #add-point:ON ACTION controlp INFIELD apde054_desc name="input.c.page2.apde054_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde054
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde054      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde054_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde054_desc
               NEXT FIELD apde054_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055
            #add-point:ON ACTION controlp INFIELD apde055 name="input.c.page2.apde055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde055_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055_desc
            #add-point:ON ACTION controlp INFIELD apde055_desc name="input.c.page2.apde055_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde055
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde055      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde055_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde055_desc
               NEXT FIELD apde055_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056
            #add-point:ON ACTION controlp INFIELD apde056 name="input.c.page2.apde056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde056_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056_desc
            #add-point:ON ACTION controlp INFIELD apde056_desc name="input.c.page2.apde056_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde056
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde056      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde056_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde056_desc
               NEXT FIELD apde056_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057
            #add-point:ON ACTION controlp INFIELD apde057 name="input.c.page2.apde057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde057_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057_desc
            #add-point:ON ACTION controlp INFIELD apde057_desc name="input.c.page2.apde057_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde057
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde057      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde057_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde057_desc
               NEXT FIELD apde057_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058
            #add-point:ON ACTION controlp INFIELD apde058 name="input.c.page2.apde058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde058_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058_desc
            #add-point:ON ACTION controlp INFIELD apde058_desc name="input.c.page2.apde058_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde058
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde058      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde058_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde058_desc
               NEXT FIELD apde058_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059
            #add-point:ON ACTION controlp INFIELD apde059 name="input.c.page2.apde059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde059_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059_desc
            #add-point:ON ACTION controlp INFIELD apde059_desc name="input.c.page2.apde059_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde059
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde059      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde059_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde059_desc
               NEXT FIELD apde059_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060
            #add-point:ON ACTION controlp INFIELD apde060 name="input.c.page2.apde060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde060_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060_desc
            #add-point:ON ACTION controlp INFIELD apde060_desc name="input.c.page2.apde060_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apde2_d[l_ac].apde060
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apde2_d[l_ac].apde060      = g_qryparam.return1
               LET g_apde2_d[l_ac].apde060_desc = g_qryparam.return1
               DISPLAY BY NAME g_apde2_d[l_ac].apde060,g_apde2_d[l_ac].apde060_desc
               NEXT FIELD apde060_desc
            END IF 
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apde2_d[l_ac].* = g_apde2_d_t.*
               END IF
               CLOSE aapt300_09_bcl
               #add-point:單身after row name="input.body2.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aapt300_09_unlock_b("apde_t")
            #add-point:單身after row name="input.body2.a_row"
            CALL aapt300_09_sum_page_show()
            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            #重算帳款單頭
            CALL s_transaction_begin()
            CALL aapt300_09_clac_bill_master() RETURNING g_sub_success
            IF g_sub_success THEN 
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF  
            IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
                    RETURNING g_sub_success
               IF g_sub_success THEN 
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde2_d[li_reproduce_target].apdeld = NULL
               LET g_apde2_d[li_reproduce_target].apdedocno = NULL
               LET g_apde2_d[li_reproduce_target].apdeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apde2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apde2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_apde3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL aapt300_09_b_fill(g_wc2)
            LET g_detail_cnt = g_apde3_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD apdeld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apde3_d[l_ac].* TO NULL 
            INITIALIZE g_apde3_d_t.* TO NULL
            INITIALIZE g_apde3_d_o.* TO NULL
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_apde3_d_t.* = g_apde3_d[l_ac].*     #新輸入資料
            LET g_apde3_d_o.* = g_apde3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde3_d[li_reproduce_target].apdeld = NULL
               LET g_apde3_d[li_reproduce_target].apdedocno = NULL
               LET g_apde3_d[li_reproduce_target].apdeseq = NULL
            END IF
            
 
 
 
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body3.before_row2"
            CALL s_transaction_begin()  #150419
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apde3_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_apde3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apde3_d[l_ac].apdeld IS NOT NULL
               AND g_apde3_d[l_ac].apdedocno IS NOT NULL
               AND g_apde3_d[l_ac].apdeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apde3_d_t.* = g_apde3_d[l_ac].*  #BACKUP
               LET g_apde3_d_o.* = g_apde3_d[l_ac].*  #BACKUP
               IF NOT aapt300_09_lock_b("apde_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_09_bcl INTO g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apdeseq, 
                      g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008, 
                      g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016, 
                      g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119, 
                      g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
                      g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041, 
                      g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
                      g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apdedocno, 
                      g_apde2_d[l_ac].apdeld,g_apde2_d[l_ac].apdeseq,g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018, 
                      g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023, 
                      g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043, 
                      g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053, 
                      g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057, 
                      g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apdedocno, 
                      g_apde3_d[l_ac].apdeld,g_apde3_d[l_ac].apdeseq,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121, 
                      g_apde3_d[l_ac].apde129,g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH aapt300_09_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apde3_d_mask_o[l_ac].* =  g_apde3_d[l_ac].*
                  CALL aapt300_09_apde_t_mask()
                  LET g_apde3_d_mask_n[l_ac].* =  g_apde3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL aapt300_09_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body3.before_row"
            CALL aapt300_09_set_entry_b(l_cmd)
            CALL aapt300_09_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身3ask刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point 
               
               DELETE FROM apde_t
                WHERE apdeent = g_enterprise AND
                  apdeld = g_apde3_d_t.apdeld
                  AND apdedocno = g_apde3_d_t.apdedocno
                  AND apdeseq = g_apde3_d_t.apdeseq
                  
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_09_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apde3_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_09_bcl
               #add-point:單身3刪除關閉bcl name="input.body3.close"
               
               #end add-point
               LET l_count = g_apde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde3_d_t.apdeld
               LET gs_keys[2] = g_apde3_d_t.apdedocno
               LET gs_keys[3] = g_apde3_d_t.apdeseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_09_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body3.after_delete"
               
               #end add-point
                              CALL aapt300_09_delete_b('apde_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apde3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body3.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
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
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND
                   apdeld = g_apde3_d[l_ac].apdeld
                   AND apdedocno = g_apde3_d[l_ac].apdedocno
                   AND apdeseq = g_apde3_d[l_ac].apdeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde3_d[g_detail_idx].apdeld
               LET gs_keys[2] = g_apde3_d[g_detail_idx].apdedocno
               LET gs_keys[3] = g_apde3_d[g_detail_idx].apdeseq
               CALL aapt300_09_insert_b('apde_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_09_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (apdeld = '", g_apde3_d[l_ac].apdeld, "' "
                                  ," AND apdedocno = '", g_apde3_d[l_ac].apdedocno, "' "
                                  ," AND apdeseq = '", g_apde3_d[l_ac].apdeseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_apde3_d[l_ac].* = g_apde3_d_t.*
               CLOSE aapt300_09_bcl
               #add-point:單身page3取消後 name="input.body3.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apde3_d[l_ac].* = g_apde3_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_09_apde_t_mask_restore('restore_mask_o')
               
               UPDATE apde_t SET (apdedocno,apdeld,apdeseq,apdeorga,apde002,apde006,apde008,apde021, 
                   apde024,apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010, 
                   apde009,apde039,apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038, 
                   apde061,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043, 
                   apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060, 
                   apde120,apde121,apde129,apde130,apde131,apde139) = (g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld, 
                   g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006, 
                   g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015, 
                   g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101, 
                   g_apde_d[l_ac].apde119,g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014, 
                   g_apde_d[l_ac].apde010,g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040, 
                   g_apde_d[l_ac].apde041,g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp, 
                   g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061, 
                   g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020, 
                   g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036, 
                   g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051, 
                   g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055, 
                   g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059, 
                   g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129, 
                   g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139) #自訂欄位頁簽 
 
                WHERE apdeent = g_enterprise AND
                  apdeld = g_apde3_d_t.apdeld #項次 
                  AND apdedocno = g_apde3_d_t.apdedocno
                  AND apdeseq = g_apde3_d_t.apdeseq
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde3_d[g_detail_idx].apdeld
               LET gs_keys_bak[1] = g_apde3_d_t.apdeld
               LET gs_keys[2] = g_apde3_d[g_detail_idx].apdedocno
               LET gs_keys_bak[2] = g_apde3_d_t.apdedocno
               LET gs_keys[3] = g_apde3_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apde3_d_t.apdeseq
               CALL aapt300_09_update_b('apde_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apde3_d_t)
                     LET g_log2 = util.JSON.stringify(g_apde3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_09_apde_t_mask_restore('restore_mask_n')
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde121
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde3_d[l_ac].apde121,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde121
            END IF 
 
 
 
            #add-point:AFTER FIELD apde121 name="input.a.page3.apde121"
            IF NOT cl_null(g_apde3_d[l_ac].apde121) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde3_d[l_ac].apde121 != g_apde3_d_t.apde121 OR g_apde3_d_t.apde121 IS NULL )) THEN            
                  #匯率取位
                  IF cl_null(g_apde3_d[l_ac].apde121) THEN LET g_apde3_d[l_ac].apde121 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa016,g_apde3_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde121     #160201-00016#1   改為glaa016 #160829-00004#1 mark  
                  #160829-00004#1-(s)
                  IF g_glaa.glaa015 = 'Y' THEN          
                     #來源幣別
                     IF g_glaa.glaa017 = '1' THEN
                        CALL s_curr_round_ld('1',g_apca.apcald,g_apde_d[l_ac].apde100,g_apde3_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde121      
                     ELSE
                        CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde3_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde121
                     END IF
                  END IF
                  #160829-00004#1-(s)
                  #本幣二重計
                  LET g_apde3_d[l_ac].apde129 = g_apde_d[l_ac].apde109 * g_apde3_d[l_ac].apde121
                  IF cl_null(g_apde3_d[l_ac].apde129) THEN LET g_apde3_d[l_ac].apde129 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa016,g_apde3_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde129     #160201-00016#1   改為glaa016
               END IF            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde121
            #add-point:BEFORE FIELD apde121 name="input.b.page3.apde121"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde121
            #add-point:ON CHANGE apde121 name="input.g.page3.apde121"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde129
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde3_d[l_ac].apde129,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde129
            END IF 
 
 
 
            #add-point:AFTER FIELD apde129 name="input.a.page3.apde129"
            IF NOT cl_null(g_apde3_d[l_ac].apde129) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde3_d[l_ac].apde129 != g_apde3_d_t.apde129 OR g_apde3_d_t.apde129 IS NULL )) THEN            
                  #本幣二
                  IF cl_null(g_apde3_d[l_ac].apde129) THEN LET g_apde3_d[l_ac].apde129 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa016,g_apde3_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde129  #160201-00016#1   改為glaa016
                  DISPLAY BY NAME g_apde3_d[l_ac].apde129              
               END IF 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde129
            #add-point:BEFORE FIELD apde129 name="input.b.page3.apde129"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde129
            #add-point:ON CHANGE apde129 name="input.g.page3.apde129"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde131
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde3_d[l_ac].apde131,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde131
            END IF 
 
 
 
            #add-point:AFTER FIELD apde131 name="input.a.page3.apde131"
            IF NOT cl_null(g_apde3_d[l_ac].apde131) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde3_d[l_ac].apde131 != g_apde3_d_t.apde131 OR g_apde3_d_t.apde131 IS NULL )) THEN            
                  #匯率取位
                  IF cl_null(g_apde3_d[l_ac].apde131) THEN LET g_apde3_d[l_ac].apde131 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa020,g_apde3_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde131     #160201-00016#1   改為glaa020 #160829-00004#1 mark 
                  #160829-00004#1-(s)
                  IF g_glaa.glaa019 = 'Y' THEN 
                     #來源幣別
                     IF g_glaa.glaa021 = '1' THEN 
                        CALL s_curr_round_ld('1',g_apca.apcald,g_apde_d[l_ac].apde100,g_apde3_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde131              
                     ELSE   #表示帳簿幣別 
                        CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde3_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde131   #帳套使用幣別
                     END IF
                  END IF
                  #160829-00004#1-(e)
                  #本幣三重計
                  LET g_apde3_d[l_ac].apde139 = g_apde_d[l_ac].apde109 * g_apde3_d[l_ac].apde131
                  IF cl_null(g_apde3_d[l_ac].apde139) THEN LET g_apde3_d[l_ac].apde139 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa020,g_apde3_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde139     #160201-00016#1   改為glaa020
               END IF                  
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde131
            #add-point:BEFORE FIELD apde131 name="input.b.page3.apde131"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde131
            #add-point:ON CHANGE apde131 name="input.g.page3.apde131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde139
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde3_d[l_ac].apde139,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde139
            END IF 
 
 
 
            #add-point:AFTER FIELD apde139 name="input.a.page3.apde139"
            IF NOT cl_null(g_apde3_d[l_ac].apde139) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apde3_d[l_ac].apde139 != g_apde3_d_t.apde139 OR g_apde3_d_t.apde139 IS NULL )) THEN            
                  #本幣三
                  IF cl_null(g_apde3_d[l_ac].apde139) THEN LET g_apde3_d[l_ac].apde139 = 0 END IF
                  CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa020,g_apde3_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde139  #160201-00016#1   改為glaa020
                  DISPLAY BY NAME g_apde3_d[l_ac].apde139              
               END IF 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde139
            #add-point:BEFORE FIELD apde139 name="input.b.page3.apde139"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde139
            #add-point:ON CHANGE apde139 name="input.g.page3.apde139"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.apde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde121
            #add-point:ON ACTION controlp INFIELD apde121 name="input.c.page3.apde121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apde129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde129
            #add-point:ON ACTION controlp INFIELD apde129 name="input.c.page3.apde129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apde131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde131
            #add-point:ON ACTION controlp INFIELD apde131 name="input.c.page3.apde131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apde139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde139
            #add-point:ON ACTION controlp INFIELD apde139 name="input.c.page3.apde139"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apde3_d[l_ac].* = g_apde3_d_t.*
               END IF
               CLOSE aapt300_09_bcl
               #add-point:單身after row name="input.body3.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aapt300_09_unlock_b("apde_t")
            #add-point:單身after row name="input.body3.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身3input後 name="input.body3.a_input"
            #重算帳款單頭
            CALL s_transaction_begin()
            CALL aapt300_09_clac_bill_master() RETURNING g_sub_success
            IF g_sub_success THEN 
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF 
            IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
                    RETURNING g_sub_success
               IF g_sub_success THEN 
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
               LET g_apde2_d[li_reproduce_target].* = g_apde2_d[li_reproduce].*
               LET g_apde3_d[li_reproduce_target].* = g_apde3_d[li_reproduce].*
 
               LET g_apde3_d[li_reproduce_target].apdeld = NULL
               LET g_apde3_d[li_reproduce_target].apdedocno = NULL
               LET g_apde3_d[li_reproduce_target].apdeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apde3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apde3_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD apdedocno
            WHEN "s_detail2"
               NEXT FIELD apdedocno_2
            WHEN "s_detail3"
               NEXT FIELD apdedocno_3
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_apde_d[g_detail_idx].apdeld) THEN
         CALL g_apde_d.deleteElement(g_detail_idx)
         CALL g_apde2_d.deleteElement(g_detail_idx)
         CALL g_apde3_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_apde_d[g_detail_idx].* = g_apde_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aapt300_09_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt300_09_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   CALL s_transaction_begin()  #150419
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_apde_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapt300_09_lock_b("apde_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("apde_t","") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_apde_d.getLength()
      IF g_apde_d[li_idx].apdeld IS NOT NULL
         AND g_apde_d[li_idx].apdedocno IS NOT NULL
         AND g_apde_d[li_idx].apdeseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM apde_t
          WHERE apdeent = g_enterprise AND 
                apdeld = g_apde_d[li_idx].apdeld
                AND apdedocno = g_apde_d[li_idx].apdedocno
                AND apdeseq = g_apde_d[li_idx].apdeseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
 
            
 
 
 
            
 
 
 
 
            
 
 
 
            
 
 
 
            
 
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apde_d_t.apdeld
               LET gs_keys[2] = g_apde_d_t.apdedocno
               LET gs_keys[3] = g_apde_d_t.apdeseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapt300_09_delete_b('apde_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_09_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   CALL s_transaction_end('Y','0')  #150419   
   #重算帳款單頭
   CALL s_transaction_begin()
   CALL aapt300_09_clac_bill_master() RETURNING g_sub_success
   IF g_sub_success THEN 
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aapt300_09_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt300_09_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = " apdeld = '",g_apcald,"' AND apdedocno = '",g_apcadocno,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.apdedocno,t0.apdeld,t0.apdeseq,t0.apdeorga,t0.apde002,t0.apde006, 
       t0.apde008,t0.apde021,t0.apde024,t0.apde015,t0.apde016,t0.apde100,t0.apde109,t0.apde101,t0.apde119, 
       t0.apde032,t0.apde013,t0.apde014,t0.apde010,t0.apde009,t0.apde039,t0.apde040,t0.apde041,t0.apde011, 
       t0.apde012,t0.apdecomp,t0.apdesite,t0.apde001,t0.apde038,t0.apde061,t0.apdedocno,t0.apdeld,t0.apdeseq, 
       t0.apde017,t0.apde018,t0.apde019,t0.apde020,t0.apde022,t0.apde023,t0.apde035,t0.apde036,t0.apde042, 
       t0.apde043,t0.apde044,t0.apde051,t0.apde052,t0.apde053,t0.apde054,t0.apde055,t0.apde056,t0.apde057, 
       t0.apde058,t0.apde059,t0.apde060,t0.apdedocno,t0.apdeld,t0.apdeseq,t0.apde120,t0.apde121,t0.apde129, 
       t0.apde130,t0.apde131,t0.apde139  FROM apde_t t0",
               "",
               
               " WHERE t0.apdeent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
#   LET g_sql = g_sql," AND (t0.apde008 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = '"||g_enterprise||"' AND nmll002 = '"||g_user||"')",#160122-00001#5 add
#                     " OR t0.apde008 IS NULL)"  #160122-00001#5 add
   LET g_sql = g_sql," AND (t0.apde008 IN(",g_sql_bank,") OR TRIM(t0.apde008) IS NULL)"#160122-00001#5 mod by 07675
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("apde_t"),
                      " ORDER BY t0.apdeld,t0.apdedocno,t0.apdeseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"apde_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt300_09_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapt300_09_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apde_d.clear()
   CALL g_apde2_d.clear()   
   CALL g_apde3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_apde_d[l_ac].apdedocno,g_apde_d[l_ac].apdeld,g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apdeorga, 
       g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024, 
       g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101, 
       g_apde_d[l_ac].apde119,g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
       g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041,g_apde_d[l_ac].apde011, 
       g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001, 
       g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apdedocno,g_apde2_d[l_ac].apdeld, 
       g_apde2_d[l_ac].apdeseq,g_apde2_d[l_ac].apde017,g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019, 
       g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035, 
       g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042,g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044, 
       g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052,g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054, 
       g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056,g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058, 
       g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060,g_apde3_d[l_ac].apdedocno,g_apde3_d[l_ac].apdeld, 
       g_apde3_d[l_ac].apdeseq,g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129, 
       g_apde3_d[l_ac].apde130,g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_apde_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apde_d[l_ac].apdeorga)              #150616-00026#3
      LET g_apde_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011)                  #150616-00026#3
      LET g_apde_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apde_d[l_ac].apde012)   #150616-00026#3
      LET g_apde_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apde_d[l_ac].apde013)      #150616-00026#3
      #沖銷科目
      LET g_apde_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apca.apcald,g_apde_d[l_ac].apde016)

      #帳款其他訊息
      LET g_apde2_d[l_ac].apde0022 = g_apde_d[l_ac].apde002        
      LET g_apde2_d[l_ac].apde0152 = g_apde_d[l_ac].apde015
      LET g_apde2_d[l_ac].apde0162 = g_apde_d[l_ac].apde016
      LET g_apde2_d[l_ac].apde0162_desc = s_desc_show1(g_apde2_d[l_ac].apde0162,s_desc_get_account_desc(g_apca.apcald,g_apde2_d[l_ac].apde0162))
      DISPLAY BY NAME g_apde2_d[l_ac].apde0162_desc 
      #固定核算項
      LET g_apde2_d[l_ac].apde017_desc = s_desc_show1(g_apde2_d[l_ac].apde017,s_desc_get_person_desc(g_apde2_d[l_ac].apde017))
      LET g_apde2_d[l_ac].apde018_desc = s_desc_show1(g_apde2_d[l_ac].apde018,s_desc_get_department_desc(g_apde2_d[l_ac].apde018))
      LET g_apde2_d[l_ac].apde019_desc = s_desc_show1(g_apde2_d[l_ac].apde019,s_desc_get_department_desc(g_apde2_d[l_ac].apde019))
      LET g_apde2_d[l_ac].apde020_desc = s_desc_show1(g_apde2_d[l_ac].apde020,s_desc_get_rtaxl003_desc(g_apde2_d[l_ac].apde020))
      LET g_apde2_d[l_ac].apde022_desc = s_desc_show1(g_apde2_d[l_ac].apde022,s_desc_get_project_desc(g_apde2_d[l_ac].apde022))      
      LET g_apde2_d[l_ac].apde023_desc = s_desc_show1(g_apde2_d[l_ac].apde023,s_desc_get_pjbbl004_desc(g_apde2_d[l_ac].apde022,g_apde2_d[l_ac].apde023))         
      LET g_apde2_d[l_ac].apde035_desc = s_desc_show1(g_apde2_d[l_ac].apde035,s_desc_get_acc_desc('287',g_apde2_d[l_ac].apde035))
      LET g_apde2_d[l_ac].apde036_desc = s_desc_show1(g_apde2_d[l_ac].apde036,s_desc_get_acc_desc('281',g_apde2_d[l_ac].apde036))         
      LET g_apde2_d[l_ac].apde043_desc = s_desc_show1(g_apde2_d[l_ac].apde043,s_desc_get_oojdl003_desc(g_apde2_d[l_ac].apde043))      
      LET g_apde2_d[l_ac].apde044_desc = s_desc_show1(g_apde2_d[l_ac].apde044,s_desc_get_acc_desc('2002',g_apde2_d[l_ac].apde044))      
      DISPLAY BY NAME g_apde2_d[l_ac].apde017_desc,g_apde2_d[l_ac].apde018_desc,g_apde2_d[l_ac].apde019_desc,g_apde2_d[l_ac].apde020_desc,g_apde2_d[l_ac].apde035_desc,g_apde2_d[l_ac].apde036_desc         
      #取得自由核算項類型
      CALL s_fin_sel_glad(g_apca.apcald,g_apde_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,g_glad.*       
      IF NOT cl_null(g_apde2_d[l_ac].apde051) THEN
         LET g_apde2_d[l_ac].apde051_desc = s_desc_show1(g_apde2_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apde2_d[l_ac].apde051))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde052) THEN
        LET g_apde2_d[l_ac].apde052_desc = s_desc_show1(g_apde2_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apde2_d[l_ac].apde052))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde053) THEN
        LET g_apde2_d[l_ac].apde053_desc = s_desc_show1(g_apde2_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apde2_d[l_ac].apde053))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde054) THEN
        LET g_apde2_d[l_ac].apde054_desc = s_desc_show1(g_apde2_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apde2_d[l_ac].apde054))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde055) THEN
        LET g_apde2_d[l_ac].apde055_desc = s_desc_show1(g_apde2_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apde2_d[l_ac].apde055))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde056) THEN
        LET g_apde2_d[l_ac].apde056_desc = s_desc_show1(g_apde2_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apde2_d[l_ac].apde056))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde057) THEN
        LET g_apde2_d[l_ac].apde057_desc = s_desc_show1(g_apde2_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apde2_d[l_ac].apde057))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde058) THEN
        LET g_apde2_d[l_ac].apde058_desc = s_desc_show1(g_apde2_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apde2_d[l_ac].apde058))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde059) THEN
        LET g_apde2_d[l_ac].apde059_desc = s_desc_show1(g_apde2_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apde2_d[l_ac].apde059))
      END IF
      IF NOT cl_null(g_apde2_d[l_ac].apde060) THEN
        LET g_apde2_d[l_ac].apde060_desc = s_desc_show1(g_apde2_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apde2_d[l_ac].apde060)) 
      END IF
      
      DISPLAY BY NAME g_apde2_d[l_ac].apde051_desc,g_apde2_d[l_ac].apde052_desc,g_apde2_d[l_ac].apde053_desc,g_apde2_d[l_ac].apde054_desc,g_apde2_d[l_ac].apde055_desc,
                      g_apde2_d[l_ac].apde056_desc,g_apde2_d[l_ac].apde057_desc,g_apde2_d[l_ac].apde058_desc,g_apde2_d[l_ac].apde059_desc,g_apde2_d[l_ac].apde060_desc         
      #帳款其他本位幣                       
      LET g_apde3_d[l_ac].apde0023 = g_apde_d[l_ac].apde002
      LET g_apde3_d[l_ac].apde0063 = g_apde_d[l_ac].apde006
      LET g_apde3_d[l_ac].apde0083 = g_apde_d[l_ac].apde008
      LET g_apde3_d[l_ac].apde1003 = g_apde_d[l_ac].apde100
      LET g_apde3_d[l_ac].apde1093 = g_apde_d[l_ac].apde109
      LET g_apde3_d[l_ac].apde1013 = g_apde_d[l_ac].apde101
      LET g_apde3_d[l_ac].apde1193 = g_apde_d[l_ac].apde119
      #end add-point
      
      CALL aapt300_09_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_apde_d.deleteElement(g_apde_d.getLength())   
   CALL g_apde2_d.deleteElement(g_apde2_d.getLength())
   CALL g_apde3_d.deleteElement(g_apde3_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_apde_d.getLength()
      LET g_apde2_d[l_ac].apdeld = g_apde_d[l_ac].apdeld 
      LET g_apde2_d[l_ac].apdedocno = g_apde_d[l_ac].apdedocno 
      LET g_apde2_d[l_ac].apdeseq = g_apde_d[l_ac].apdeseq 
      LET g_apde3_d[l_ac].apdeld = g_apde_d[l_ac].apdeld 
      LET g_apde3_d[l_ac].apdedocno = g_apde_d[l_ac].apdedocno 
      LET g_apde3_d[l_ac].apdeseq = g_apde_d[l_ac].apdeseq 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_apde_d.getLength() THEN
      LET l_ac = g_apde_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_apde_d.getLength()
      LET g_apde_d_mask_o[l_ac].* =  g_apde_d[l_ac].*
      CALL aapt300_09_apde_t_mask()
      LET g_apde_d_mask_n[l_ac].* =  g_apde_d[l_ac].*
   END FOR
   
   LET g_apde2_d_mask_o.* =  g_apde2_d.*
   FOR l_ac = 1 TO g_apde2_d.getLength()
      LET g_apde2_d_mask_o[l_ac].* =  g_apde2_d[l_ac].*
      CALL aapt300_09_apde_t_mask()
      LET g_apde2_d_mask_n[l_ac].* =  g_apde2_d[l_ac].*
   END FOR
   LET g_apde3_d_mask_o.* =  g_apde3_d.*
   FOR l_ac = 1 TO g_apde3_d.getLength()
      LET g_apde3_d_mask_o[l_ac].* =  g_apde3_d[l_ac].*
      CALL aapt300_09_apde_t_mask()
      LET g_apde3_d_mask_n[l_ac].* =  g_apde3_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL aapt300_09_sum_page_show()
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_apde_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapt300_09_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapt300_09_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body3.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt300_09_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("apde006,apde008,apde013,apde014,apde021,apde024,apde032,apde039,apde040",TRUE)
   CALL cl_set_comp_entry("apde100",TRUE) #170208-00033#1 add
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aapt300_09.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt300_09_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   CALL cl_set_comp_entry("apde041",FALSE)  #160324-00032#3
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apde_d[l_ac].apde002
		   WHEN '10'
            IF NOT(g_apde_d[l_ac].apde006 = '10' OR g_apde_d[l_ac].apde006 = '20' OR g_apde_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
               LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040=''		
               LET g_apde_d[l_ac].apde041=''    #160202-00021#2
            END IF
            IF NOT (g_apde_d[l_ac].apde006 = '30' OR g_apde_d[l_ac].apde006 = '40' OR g_apde_d[l_ac].apde006 = '50' OR
                    g_apde_d[l_ac].apde006 = '60' OR g_apde_d[l_ac].apde006 = '70' OR g_apde_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde021",FALSE)
               LET g_apde_d[l_ac].apde021=''
            END IF             
            IF NOT (g_apde_d[l_ac].apde006 = '30' OR g_apde_d[l_ac].apde006 = '40' OR g_apde_d[l_ac].apde006 = '50' OR
                    g_apde_d[l_ac].apde006 = '60' OR g_apde_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde024",FALSE)
               LET g_apde_d[l_ac].apde024=''
            END IF    
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''    
            IF NOT(g_apde_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_entry("apde014",FALSE)
               LET g_apde_d[l_ac].apde014=''
            END IF                                           
		   
		   WHEN '11'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''			 
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040='' 
            LET g_apde_d[l_ac].apde041=''    #160202-00021#2
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''            
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''         
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt    
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''     
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apde_d[l_ac].apde014=''                                                         
		   WHEN '12'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''				
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040='' 
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''         
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''                                 	   
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''      
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apde_d[l_ac].apde014=''                                       
		   WHEN '13'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''	
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040=''  
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''        
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''                
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt   
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''      
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apde_d[l_ac].apde014=''                                                     				   
		   WHEN '14'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''		
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040='' 
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''         
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''  
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''        
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apde_d[l_ac].apde014=''                                                                    			   
		   WHEN '15'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''			
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040='' 
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''      
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''      
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013='' 
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apde_d[l_ac].apde014=''                                                                         		   
		   WHEN '20'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apde_d[l_ac].apde006=''				
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040=''
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apde_d[l_ac].apde021=''                 
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apde_d[l_ac].apde024=''           
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apde_d[l_ac].apde032= g_apca.apcadocdt    
         #160422-00021#1--(S)
         WHEN '23'
            IF NOT(g_apde_d[l_ac].apde006 = '10' OR g_apde_d[l_ac].apde006 = '20' OR g_apde_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
               LET g_apde_d[l_ac].apde008='' LET g_apde_d[l_ac].apde039='' LET g_apde_d[l_ac].apde040=''		
               LET g_apde_d[l_ac].apde041=''
            END IF
            IF NOT (g_apde_d[l_ac].apde006 = '30' OR g_apde_d[l_ac].apde006 = '40' OR g_apde_d[l_ac].apde006 = '50' OR
                    g_apde_d[l_ac].apde006 = '60' OR g_apde_d[l_ac].apde006 = '70' OR g_apde_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde021",FALSE)
               LET g_apde_d[l_ac].apde021=''
            END IF             
            IF NOT (g_apde_d[l_ac].apde006 = '30' OR g_apde_d[l_ac].apde006 = '40' OR g_apde_d[l_ac].apde006 = '50' OR
                    g_apde_d[l_ac].apde006 = '60' OR g_apde_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde024",FALSE)
               LET g_apde_d[l_ac].apde024=''
            END IF    
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apde_d[l_ac].apde013=''    
            IF NOT(g_apde_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_entry("apde014",FALSE)
               LET g_apde_d[l_ac].apde014=''
            END IF                                      
         #160422-00021#1--(E)
      END CASE
      #170208-00033#1 --s add
      IF NOT cl_null(g_apde_d[l_ac].apde008) THEN
         CALL cl_set_comp_entry("apde100",FALSE) 
      END IF      
      #170208-00033#1 --e add
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt300_09_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " apdeld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apdedocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " apdeseq = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt300_09_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "apde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'apde_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM apde_t
          WHERE apdeent = g_enterprise AND
            apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apde_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_apde2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apde3_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt300_09_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "apde_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO apde_t
                  (apdeent,
                   apdeld,apdedocno,apdeseq
                   ,apdeorga,apde002,apde006,apde008,apde021,apde024,apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010,apde009,apde039,apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038,apde061,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apde120,apde121,apde129,apde130,apde131,apde139) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008, 
                       g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016, 
                       g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119, 
                       g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
                       g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041, 
                       g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
                       g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apde017, 
                       g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022, 
                       g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042, 
                       g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052, 
                       g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056, 
                       g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060, 
                       g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129,g_apde3_d[l_ac].apde130, 
                       g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt300_09_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "apde_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "apde_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE apde_t 
         SET (apdeld,apdedocno,apdeseq
              ,apdeorga,apde002,apde006,apde008,apde021,apde024,apde015,apde016,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde010,apde009,apde039,apde040,apde041,apde011,apde012,apdecomp,apdesite,apde001,apde038,apde061,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apde120,apde121,apde129,apde130,apde131,apde139) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apde_d[l_ac].apdeorga,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde008, 
                  g_apde_d[l_ac].apde021,g_apde_d[l_ac].apde024,g_apde_d[l_ac].apde015,g_apde_d[l_ac].apde016, 
                  g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119, 
                  g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde013,g_apde_d[l_ac].apde014,g_apde_d[l_ac].apde010, 
                  g_apde_d[l_ac].apde009,g_apde_d[l_ac].apde039,g_apde_d[l_ac].apde040,g_apde_d[l_ac].apde041, 
                  g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde012,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
                  g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde038,g_apde_d[l_ac].apde061,g_apde2_d[l_ac].apde017, 
                  g_apde2_d[l_ac].apde018,g_apde2_d[l_ac].apde019,g_apde2_d[l_ac].apde020,g_apde2_d[l_ac].apde022, 
                  g_apde2_d[l_ac].apde023,g_apde2_d[l_ac].apde035,g_apde2_d[l_ac].apde036,g_apde2_d[l_ac].apde042, 
                  g_apde2_d[l_ac].apde043,g_apde2_d[l_ac].apde044,g_apde2_d[l_ac].apde051,g_apde2_d[l_ac].apde052, 
                  g_apde2_d[l_ac].apde053,g_apde2_d[l_ac].apde054,g_apde2_d[l_ac].apde055,g_apde2_d[l_ac].apde056, 
                  g_apde2_d[l_ac].apde057,g_apde2_d[l_ac].apde058,g_apde2_d[l_ac].apde059,g_apde2_d[l_ac].apde060, 
                  g_apde3_d[l_ac].apde120,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129,g_apde3_d[l_ac].apde130, 
                  g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139) 
         WHERE apdeent = g_enterprise AND apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt300_09_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapt300_09_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "apde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt300_09_bcl USING g_enterprise,
                                       g_apde_d[g_detail_idx].apdeld,g_apde_d[g_detail_idx].apdedocno, 
                                           g_apde_d[g_detail_idx].apdeseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt300_09_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt300_09_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aapt300_09_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapt300_09_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "apdedocno"
      WHEN "s_detail2"
         LET ls_return = "apdedocno_2"
      WHEN "s_detail3"
         LET ls_return = "apdedocno_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_09.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapt300_09_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aapt300_09.mask_functions" >}
&include "erp/aap/aapt300_09_mask.4gl"
 
{</section>}
 
{<section id="aapt300_09.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt300_09_set_pk_array()
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
   LET g_pk_array[1].values = g_apde_d[l_ac].apdeld
   LET g_pk_array[1].column = 'apdeld'
   LET g_pk_array[2].values = g_apde_d[l_ac].apdedocno
   LET g_pk_array[2].column = 'apdedocno'
   LET g_pk_array[3].values = g_apde_d[l_ac].apdeseq
   LET g_pk_array[3].column = 'apdeseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_09.state_change" >}
   
 
{</section>}
 
{<section id="aapt300_09.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt300_09.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 匯總計算單身金額並顯示
# Memo...........:
# Usage..........: CALL aapt300_09_sum_page_show()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/10/31 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_09_sum_page_show()
   DEFINE l_apce_plus  RECORD    #沖帳金額正的部分
              apce109  LIKE apce_t.apce109,
              apce119  LIKE apce_t.apce119,
              apce129  LIKE apce_t.apce129,
              apce139  LIKE apce_t.apce139
                       END RECORD 
   DEFINE l_apce_minus RECORD   #沖帳金額負的部分
              apce109  LIKE apce_t.apce109,
              apce119  LIKE apce_t.apce119,
              apce129  LIKE apce_t.apce129,
              apce139  LIKE apce_t.apce139
                       END RECORD

   INITIALIZE g_apce_sum.* TO NULL
   
   #本幣 本位幣二 本位幣三
   LET g_apce_sum.glaa001 = g_glaa.glaa001
   LET g_apce_sum.glaa016 = g_glaa.glaa016
   LET g_apce_sum.glaa020 = g_glaa.glaa020
   
   #交易合計金額
   SELECT (apca103+apca104),(apca113+apca114),(apca123+apca124),(apca133+apca134) 
     INTO g_apce_sum.sum_apca103,g_apce_sum.sum_apca113,g_apce_sum.sum_apca123,g_apce_sum.sum_apca133
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcald  = g_apca.apcald
      AND apcadocno = g_apca.apcadocno
   IF cl_null(g_apce_sum.sum_apca103)THEN LET g_apce_sum.sum_apca103 = 0 END IF
   IF cl_null(g_apce_sum.sum_apca113)THEN LET g_apce_sum.sum_apca113 = 0 END IF
   IF cl_null(g_apce_sum.sum_apca123)THEN LET g_apce_sum.sum_apca123 = 0 END IF
   IF cl_null(g_apce_sum.sum_apca133)THEN LET g_apce_sum.sum_apca133 = 0 END IF

   #稅前折抵金額
   #正
   INITIALIZE l_apce_plus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
     INTO l_apce_plus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apca.apcald
      AND apcedocno = g_apca.apcadocno
      AND apce015 = 'C' 
      AND apce027 = 'Y'
   IF cl_null(l_apce_plus.apce109)THEN LET l_apce_plus.apce109 = 0 END IF
   IF cl_null(l_apce_plus.apce119)THEN LET l_apce_plus.apce119 = 0 END IF
   IF cl_null(l_apce_plus.apce129)THEN LET l_apce_plus.apce129 = 0 END IF
   IF cl_null(l_apce_plus.apce139)THEN LET l_apce_plus.apce139 = 0 END IF

   #負
   INITIALIZE l_apce_minus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
     INTO l_apce_minus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apca.apcald
      AND apcedocno = g_apca.apcadocno
      AND apce015 = 'D' 
      AND apce027 = 'Y'
   IF cl_null(l_apce_minus.apce109)THEN LET l_apce_minus.apce109 = 0 END IF
   IF cl_null(l_apce_minus.apce119)THEN LET l_apce_minus.apce119 = 0 END IF
   IF cl_null(l_apce_minus.apce129)THEN LET l_apce_minus.apce129 = 0 END IF
   IF cl_null(l_apce_minus.apce139)THEN LET l_apce_minus.apce139 = 0 END IF

   LET g_apce_sum.sum_apce1091 = l_apce_plus.apce109 - l_apce_minus.apce109
   LET g_apce_sum.sum_apce1191 = l_apce_plus.apce119 - l_apce_minus.apce119
   LET g_apce_sum.sum_apce1291 = l_apce_plus.apce129 - l_apce_minus.apce129
   LET g_apce_sum.sum_apce1391 = l_apce_plus.apce139 - l_apce_minus.apce139


   #直接沖帳金額
   #正
   INITIALIZE l_apce_plus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
     INTO l_apce_plus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apca.apcald
      AND apcedocno = g_apca.apcadocno
      AND apce015 = 'C' 
      AND (apce027 = 'N' OR apce027 IS NULL)
   IF cl_null(l_apce_plus.apce109)THEN LET l_apce_plus.apce109 = 0 END IF
   IF cl_null(l_apce_plus.apce119)THEN LET l_apce_plus.apce119 = 0 END IF
   IF cl_null(l_apce_plus.apce129)THEN LET l_apce_plus.apce129 = 0 END IF
   IF cl_null(l_apce_plus.apce139)THEN LET l_apce_plus.apce139 = 0 END IF

   #負
   INITIALIZE l_apce_minus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
     INTO l_apce_minus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apca.apcald
      AND apcedocno = g_apca.apcadocno
      AND apce015 = 'D' 
      AND (apce027 = 'N' OR apce027 IS NULL)
   IF cl_null(l_apce_minus.apce109)THEN LET l_apce_minus.apce109 = 0 END IF
   IF cl_null(l_apce_minus.apce119)THEN LET l_apce_minus.apce119 = 0 END IF
   IF cl_null(l_apce_minus.apce129)THEN LET l_apce_minus.apce129 = 0 END IF
   IF cl_null(l_apce_minus.apce139)THEN LET l_apce_minus.apce139 = 0 END IF

   LET g_apce_sum.sum_apce1092 = l_apce_plus.apce109 - l_apce_minus.apce109
   LET g_apce_sum.sum_apce1192 = l_apce_plus.apce119 - l_apce_minus.apce119
   LET g_apce_sum.sum_apce1292 = l_apce_plus.apce129 - l_apce_minus.apce129
   LET g_apce_sum.sum_apce1392 = l_apce_plus.apce139 - l_apce_minus.apce139
   
   #付款及其他金額
   #正                                                                     
   INITIALIZE l_apce_plus.* TO NULL                                        
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)              
     INTO l_apce_plus.*                                                    
     FROM apde_t                                                           
    WHERE apdeent = g_enterprise                                           
      AND apdeld  = g_apca.apcald                                          
      AND apdedocno = g_apca.apcadocno                                     
      AND apde015 = 'C'                                                    
   IF cl_null(l_apce_plus.apce109)THEN LET l_apce_plus.apce109 = 0 END IF  
   IF cl_null(l_apce_plus.apce119)THEN LET l_apce_plus.apce119 = 0 END IF  
   IF cl_null(l_apce_plus.apce129)THEN LET l_apce_plus.apce129 = 0 END IF  
   IF cl_null(l_apce_plus.apce139)THEN LET l_apce_plus.apce139 = 0 END IF  
                                                                           
   #負                                                                     
   INITIALIZE l_apce_minus.* TO NULL                                       
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)              
     INTO l_apce_minus.*                                                   
     FROM apde_t                                                           
    WHERE apdeent = g_enterprise                                           
      AND apdeld  = g_apca.apcald                                          
      AND apdedocno = g_apca.apcadocno                                     
      AND apde015 = 'D'                                                    
   IF cl_null(l_apce_minus.apce109)THEN LET l_apce_minus.apce109 = 0 END IF
   IF cl_null(l_apce_minus.apce119)THEN LET l_apce_minus.apce119 = 0 END IF
   IF cl_null(l_apce_minus.apce129)THEN LET l_apce_minus.apce129 = 0 END IF
   IF cl_null(l_apce_minus.apce139)THEN LET l_apce_minus.apce139 = 0 END IF
                                                                           
   LET g_apce_sum.sum_apce1093 = l_apce_plus.apce109 - l_apce_minus.apce109
   LET g_apce_sum.sum_apce1193 = l_apce_plus.apce119 - l_apce_minus.apce119
   LET g_apce_sum.sum_apce1293 = l_apce_plus.apce129 - l_apce_minus.apce129
   LET g_apce_sum.sum_apce1393 = l_apce_plus.apce139 - l_apce_minus.apce139    

   #合計金額 = 交易合計金額　-　稅前折抵金額 - 直接沖銷帳金額 -　直接繳款金額
   LET g_apce_sum.sum_apce1094 =g_apce_sum.sum_apca103 - g_apce_sum.sum_apce1091 - g_apce_sum.sum_apce1092 - g_apce_sum.sum_apce1093 
   LET g_apce_sum.sum_apce1194 =g_apce_sum.sum_apca113 - g_apce_sum.sum_apce1191 - g_apce_sum.sum_apce1192 - g_apce_sum.sum_apce1193
   LET g_apce_sum.sum_apce1294 =g_apce_sum.sum_apca123 - g_apce_sum.sum_apce1291 - g_apce_sum.sum_apce1292 - g_apce_sum.sum_apce1293
   LET g_apce_sum.sum_apce1394 =g_apce_sum.sum_apca133 - g_apce_sum.sum_apce1391 - g_apce_sum.sum_apce1392 - g_apce_sum.sum_apce1393  

   DISPLAY BY NAME g_apce_sum.sum_apce1094,g_apce_sum.sum_apce1091,g_apce_sum.sum_apce1092,g_apce_sum.sum_apce1093,
                   g_apce_sum.sum_apce1194,g_apce_sum.sum_apce1191,g_apce_sum.sum_apce1192,g_apce_sum.sum_apce1193,
                   g_apce_sum.sum_apce1294,g_apce_sum.sum_apce1291,g_apce_sum.sum_apce1292,g_apce_sum.sum_apce1293,
                   g_apce_sum.sum_apce1394,g_apce_sum.sum_apce1391,g_apce_sum.sum_apce1392,g_apce_sum.sum_apce1393,
                   g_apce_sum.glaa001,g_apce_sum.glaa016,g_apce_sum.glaa020,
                   g_apce_sum.sum_apca103,g_apce_sum.sum_apca113,g_apce_sum.sum_apca123,g_apce_sum.sum_apca133 
END FUNCTION
################################################################################
# Descriptions...: 檢核直接沖銷中是否與應付單單頭之原幣幣別完全相同
# Memo...........:
# Usage..........: CALL aapt300_09_contra_curr_chk(p_ld,p_docno,p_apde100)
#                  RETURNING r_success
# Input parameter: p_ld           帳別
#                : p_docno        單號
#                : p_apde100      本筆資料幣別
# Return code....: r_success      原幣幣別相同否
# Date & Author..: 14/10/31 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_09_contra_curr_chk(p_ld,p_docno,p_apde100)
   DEFINE p_ld             LIKE apca_t.apcald
   DEFINE p_docno          LIKE apca_t.apcadocno
   DEFINE p_apde100        LIKE apde_t.apde100
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_apca100        LIKE apca_t.apca100
   
   LET r_success = TRUE
   
   #取得應付單原幣幣別
   SELECT apca100 INTO l_apca100 FROM apca_t
    WHERE apcaent = g_enterprise
       AND apcald = p_ld AND apcadocno = p_docno    

   SELECT COUNT(apdeseq) INTO l_cnt FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdeld  = p_ld
      AND apdedocno = p_docno   
      AND apde100 <> l_apca100
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   #直接沖銷中有原幣幣別與應付單單頭不同
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   #當本筆幣別與應付單頭不同則不檢核原幣
   IF NOT cl_null(p_apde100) AND p_apde100 <> l_apca100 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 重新計算本幣金額
# Memo...........: 
# Usage..........: aapt300_09_trans_to_local_curr(p_curr)
# Input parameter: p_curr      原幣幣別
# Date & Author..: 14/10/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_09_trans_to_local_curr(p_curr)
   DEFINE p_curr       LIKE glaa_t.glaa002   #原幣幣別
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD
   DEFINE l_apca100     LIKE apca_t.apca100
   
  #取本幣匯率
  #20150915--MARK
  #CALL s_aooi160_get_exrate('1',g_apca.apcacomp,g_apca.apcadocdt,p_trans,p_curr,0,g_glaa.glaa025)
  #     RETURNING r_rate
  #20150915--MARK
  #20150915--若付款原幣與單據單頭交易幣相同，預設單據匯率
   SELECT apca100,apca101,apca121,apca131
     INTO l_apca100,g_apde_d[l_ac].apde101,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde131
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcald = g_apcald AND apcadocno = g_apcadocno
   IF l_apca100 <> p_curr THEN
      LET lc_param.apca004 = g_apca.apca004
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_apca.apcacomp,g_apca.apcald,g_apca.apcadocdt,p_curr,ls_js)
           RETURNING g_apde_d[l_ac].apde101,g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde131
   END IF
   
#   #本幣金額 = 原幣金額 * 本幣匯率
#   LET r_amt = p_amt * r_rate   
#   IF cl_null(r_amt) THEN LET r_amt = 0 END IF   
#   CALL s_curr_round_ld('1',g_apca.apcald,p_curr,r_amt,2) 
#    RETURNING g_sub_success,g_errno,r_amt 
   #本幣重計
   LET g_apde_d[l_ac].apde119 = g_apde_d[l_ac].apde109 * g_apde_d[l_ac].apde101
   IF cl_null(g_apde_d[l_ac].apde119) THEN LET g_apde_d[l_ac].apde119 = 0 END IF
   CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa001,g_apde_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde119   
   DISPLAY BY NAME g_apde_d[l_ac].apde101,g_apde_d[l_ac].apde119
   #本幣二重計
   IF g_glaa.glaa015 = 'Y' THEN
      LET g_apde3_d[l_ac].apde129 = g_apde_d[l_ac].apde109 * g_apde3_d[l_ac].apde121
      IF cl_null(g_apde3_d[l_ac].apde129) THEN LET g_apde3_d[l_ac].apde129 = 0 END IF
      CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa016,g_apde3_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde129  #160201-00016#1   改為glaa016
      DISPLAY BY NAME g_apde3_d[l_ac].apde121,g_apde3_d[l_ac].apde129
   END IF
   #本幣三重計
   IF g_glaa.glaa019 = 'Y' THEN
      LET g_apde3_d[l_ac].apde139 = g_apde_d[l_ac].apde109 * g_apde3_d[l_ac].apde131
      IF cl_null(g_apde3_d[l_ac].apde139) THEN LET g_apde3_d[l_ac].apde139 = 0 END IF
      CALL s_curr_round_ld('1',g_apca.apcald,g_glaa.glaa020,g_apde3_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apde3_d[l_ac].apde139  #160201-00016#1   改為glaa020
      DISPLAY BY NAME g_apde3_d[l_ac].apde131,g_apde3_d[l_ac].apde139
   END IF    
END FUNCTION

PRIVATE FUNCTION aapt300_09_set_no_required()
   CALL cl_set_comp_required("apde008,apde011,apde012,apde013,apde014,apde021,apde024,apde032,apde039,apde040",FALSE)
END FUNCTION

PRIVATE FUNCTION aapt300_09_set_required()

   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apde_d[l_ac].apde002
		   WHEN '10'
		      CALL cl_set_comp_required("apde032",TRUE)	 
		      IF g_sfin3008 = 'Y' THEN
               IF (g_apde_d[l_ac].apde006 = '10' OR g_apde_d[l_ac].apde006 = '20' OR g_apde_d[l_ac].apde006 = '30') THEN
                  CALL cl_set_comp_required("apde008,apde011,apde012",TRUE)			   
               END IF
               IF g_apde_d[l_ac].apde006 = '30' THEN
                  #限定即期票據,收款相關資訊必輸
#                  CALL cl_set_comp_required("apde039,apde040,apde024",TRUE)
                  CALL cl_set_comp_required("apde024",TRUE)
                     
               END IF
#               IF g_apde_d[l_ac].apde006 = '20' THEN
#                  CALL cl_set_comp_required("apde039,apde040",TRUE)	          
#               END IF                    
            END IF
            
            #161109-00031#1---add---str--
            IF (g_apde_d[l_ac].apde006 = '10' OR g_apde_d[l_ac].apde006 = '20' OR g_apde_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_required("apde011,apde012",TRUE)
               IF cl_null(g_apde_d[l_ac].apde011) THEN
                  DISPLAY BY NAME g_apde_d[l_ac].apde011
               END IF
               IF cl_null(g_apde_d[l_ac].apde012) THEN
                  DISPLAY BY NAME g_apde_d[l_ac].apde012
               END IF
            END IF
            #161109-00031#1---add---end--
            
            IF g_apde_d[l_ac].apde006 = '30' THEN
               CALL cl_set_comp_required("apde021",TRUE)	          
            END IF   
         WHEN '20'            
            CALL cl_set_comp_required("apde013,apde014",TRUE)	  

      END CASE
   END IF      
END FUNCTION

PRIVATE FUNCTION aapt300_09_clac_bill_master()
   DEFINE l_amount         RECORD
                 apcb103      LIKE apcb_t.apcb103,
                 apcb113      LIKE apcb_t.apcb113,
                 apcb123      LIKE apcb_t.apcb123,
                 apcb133      LIKE apcb_t.apcb133,
                 xrcd104      LIKE xrcd_t.xrcd104,
                 xrcd114      LIKE xrcd_t.xrcd114,
                 xrcd124      LIKE xrcd_t.xrcd124,
                 xrcd134      LIKE xrcd_t.xrcd134,
                 apca106      LIKE apca_t.apca106,
                 apca116      LIKE apca_t.apca116,
                 apca126      LIKE apca_t.apca126,
                 apca136      LIKE apca_t.apca136,
                 apca107      LIKE apca_t.apca107,
                 apca117      LIKE apca_t.apca117,
                 apca127      LIKE apca_t.apca127,
                 apca137      LIKE apca_t.apca137,
                 apca108      LIKE apca_t.apca108,
                 apca118      LIKE apca_t.apca118,
                 apca128      LIKE apca_t.apca128,
                 apca138      LIKE apca_t.apca138
                           END RECORD    
   DEFINE r_success        LIKE type_t.num5                           
   
   LET r_success = TRUE
   OPEN aapt300_09_cl USING g_enterprise,g_apca.apcald,g_apca.apcadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt300_09_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aapt300_09_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   #重新計算金額(單頭及多帳期)
   CALL s_aap_create_multi_bill_perod_tmp()   
   INITIALIZE l_amount.* TO NULL
   CALL s_aap_clac_bill_master(g_apca.apcald,g_apca.apcadocno) RETURNING l_amount.*
   
   LET g_apca.apcamodid = g_user 
   LET g_apca.apcamoddt = cl_get_current()
   #161201-00029#1 add ------
   IF g_apca.apca001 = '15' THEN
      LET l_amount.apca108 = l_amount.apca118
   END IF
   #161201-00029#1 add end---
   UPDATE apca_t SET (apca103,apca104,apca106,apca107,apca108,
                      apca113,apca114,apca116,apca117,apca118,
                      apca123,apca124,apca126,apca127,apca128,
                      apca133,apca134,apca136,apca137,apca138,
                      apcamodid,apcamoddt) =
                     (l_amount.apcb103,l_amount.xrcd104,l_amount.apca106,l_amount.apca107,l_amount.apca108,
                      l_amount.apcb113,l_amount.xrcd114,l_amount.apca116,l_amount.apca117,l_amount.apca118,
                      l_amount.apcb123,l_amount.xrcd124,l_amount.apca126,l_amount.apca127,l_amount.apca128,
                      l_amount.apcb133,l_amount.xrcd134,l_amount.apca136,l_amount.apca137,l_amount.apca138,
                      g_user,g_apca.apcamoddt)
     WHERE apcaent = g_enterprise AND apcald = g_apca.apcald
       AND apcadocno = g_apca.apcadocno
       
   IF SQLCA.sqlerrd[3] = 0 THEN
     #CALL s_transaction_end('N','0')   #150419 mark      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00009"
      LET g_errparam.extend = "upd apca_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET r_success = FALSE
   END IF
   
   CALL s_aap_multi_bill_period(g_apca.apcald,g_apca.apcadocno) RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN
     #CALL s_transaction_end('N','0')   #150419 mark      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "aap-00092"
      LET g_errparam.extend = "upd apcc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF   
   CLOSE aapt300_09_cl                              
   RETURN r_success
END FUNCTION

 
{</section>}
 
