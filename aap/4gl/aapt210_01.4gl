#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt210_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-07-28 11:56:20), PR版次:0006(2016-12-14 09:55:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: aapt210_01
#+ Description: 沖暫估資訊
#+ Creator....: 02114(2016-01-05 16:34:51)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="aapt210_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150205-00012#1              BY Hans     進欄位之後只顯示編號不顯示中文名稱
#160321-00016#20  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#43  2016/04/26 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160905-00002#1   2016/09/05 By Reanna   SQL條件少ENT補上
#160920-00019#2   2016/09/21 By 08732    交易對象開窗校驗調整
#161104-00024#2   2016/11/09 By 08729    處理DEFINE有星號  
#161208-00026#5   2016/12/09 By 08729    針對SELECT有星號的部分進行展開
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
PRIVATE TYPE type_g_apcf_d RECORD
       apcfdocno LIKE apcf_t.apcfdocno, 
   apcfld LIKE apcf_t.apcfld, 
   apcfseq LIKE apcf_t.apcfseq, 
   apcfseq2 LIKE apcf_t.apcfseq2, 
   apca001 LIKE type_t.chr500, 
   apcf008 LIKE apcf_t.apcf008, 
   apcf009 LIKE apcf_t.apcf009, 
   apcf010 LIKE apcf_t.apcf010, 
   apcf021 LIKE apcf_t.apcf021, 
   l_apcf021_desc LIKE type_t.chr500, 
   apcf007 LIKE apcf_t.apcf007, 
   apcf101 LIKE apcf_t.apcf101, 
   apcf103 LIKE apcf_t.apcf103, 
   apcf104 LIKE apcf_t.apcf104, 
   apcf105 LIKE apcf_t.apcf105, 
   apcf102 LIKE apcf_t.apcf102, 
   apcf113 LIKE apcf_t.apcf113, 
   apcf114 LIKE apcf_t.apcf114, 
   apcf115 LIKE apcf_t.apcf115, 
   apcf020 LIKE apcf_t.apcf020, 
   apcf022 LIKE apcf_t.apcf022, 
   apcf023 LIKE apcf_t.apcf023, 
   apcf111 LIKE apcf_t.apcf111, 
   apcf122 LIKE apcf_t.apcf122, 
   apcf123 LIKE apcf_t.apcf123, 
   apcf124 LIKE apcf_t.apcf124, 
   apcf125 LIKE apcf_t.apcf125, 
   apcf126 LIKE apcf_t.apcf126, 
   apcf127 LIKE apcf_t.apcf127, 
   apcf132 LIKE apcf_t.apcf132, 
   apcf133 LIKE apcf_t.apcf133, 
   apcf134 LIKE apcf_t.apcf134, 
   apcf135 LIKE apcf_t.apcf135, 
   apcf136 LIKE apcf_t.apcf136, 
   apcf137 LIKE apcf_t.apcf137, 
   apcf001 LIKE apcf_t.apcf001, 
   apcf002 LIKE apcf_t.apcf002, 
   apcf024 LIKE apcf_t.apcf024, 
   apcf025 LIKE apcf_t.apcf025
       END RECORD
PRIVATE TYPE type_g_apcf2_d RECORD
       apcfld LIKE apcf_t.apcfld, 
   apcfdocno LIKE apcf_t.apcfdocno, 
   apcfseq LIKE apcf_t.apcfseq, 
   apcfseq2 LIKE apcf_t.apcfseq2, 
   apcf008_desc LIKE type_t.chr500, 
   apcf021_desc LIKE type_t.chr500, 
   apcf049 LIKE apcf_t.apcf049, 
   apcforga LIKE apcf_t.apcforga, 
   apcforga_desc LIKE type_t.chr500, 
   apcf026 LIKE apcf_t.apcf026, 
   apcf026_desc LIKE type_t.chr500, 
   apcf027 LIKE apcf_t.apcf027, 
   apcf027_desc LIKE type_t.chr500, 
   apcf028 LIKE apcf_t.apcf028, 
   apcf028_desc LIKE type_t.chr500, 
   apcf029 LIKE apcf_t.apcf029, 
   apcf029_desc LIKE type_t.chr500, 
   apcf030 LIKE apcf_t.apcf030, 
   apcf030_desc LIKE type_t.chr500, 
   apcf031 LIKE apcf_t.apcf031, 
   apcf031_desc LIKE type_t.chr500, 
   apcf032 LIKE apcf_t.apcf032, 
   apcf032_desc LIKE type_t.chr500, 
   apcf033 LIKE apcf_t.apcf033, 
   apcf033_desc LIKE type_t.chr500, 
   apcf034 LIKE apcf_t.apcf034, 
   apcf034_desc LIKE type_t.chr500, 
   apcf035 LIKE apcf_t.apcf035, 
   apcf035_desc LIKE type_t.chr500, 
   apcf036 LIKE apcf_t.apcf036, 
   apcf037 LIKE apcf_t.apcf037, 
   apcf037_desc LIKE type_t.chr500, 
   apcf038 LIKE apcf_t.apcf038, 
   apcf038_desc LIKE type_t.chr500, 
   apcf039 LIKE apcf_t.apcf039, 
   apcf039_desc LIKE type_t.chr500, 
   apcf040 LIKE apcf_t.apcf040, 
   apcf040_desc LIKE type_t.chr500, 
   apcf041 LIKE apcf_t.apcf041, 
   apcf041_desc LIKE type_t.chr500, 
   apcf042 LIKE apcf_t.apcf042, 
   apcf042_desc LIKE type_t.chr500, 
   apcf043 LIKE apcf_t.apcf043, 
   apcf043_desc LIKE type_t.chr500, 
   apcf044 LIKE apcf_t.apcf044, 
   apcf044_desc LIKE type_t.chr500, 
   apcf045 LIKE apcf_t.apcf045, 
   apcf045_desc LIKE type_t.chr500, 
   apcf046 LIKE apcf_t.apcf046, 
   apcf046_desc LIKE type_t.chr500, 
   apcf047 LIKE apcf_t.apcf047, 
   apcf047_desc LIKE type_t.chr500, 
   apcf048 LIKE apcf_t.apcf048, 
   apcf048_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa              RECORD
                           glaacomp    LIKE glaa_t.glaacomp,
                           glaa004     LIKE glaa_t.glaa004,
                           glaa121     LIKE glaa_t.glaa121
                       END RECORD
#DEFINE g_apca              RECORD LIKE apca_t.*  #161104-00024#2 mark
#DEFINE g_apcf              RECORD LIKE apcf_t.*  #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE g_apca RECORD  #應付憑單單頭
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
DEFINE g_apcf RECORD  #應付沖暫估明細檔
       apcfent   LIKE apcf_t.apcfent, #企業編號
       apcfld    LIKE apcf_t.apcfld, #帳套
       apcforga  LIKE apcf_t.apcforga, #來源組織
       apcfdocno LIKE apcf_t.apcfdocno, #單號
       apcfseq   LIKE apcf_t.apcfseq, #項次
       apcfseq2  LIKE apcf_t.apcfseq2, #項次2
       apcf001   LIKE apcf_t.apcf001, #作業別
       apcf002   LIKE apcf_t.apcf002, #沖銷類型
       apcf007   LIKE apcf_t.apcf007, #沖銷數量
       apcf008   LIKE apcf_t.apcf008, #暫估單號碼
       apcf009   LIKE apcf_t.apcf009, #暫估單號項次
       apcf010   LIKE apcf_t.apcf010, #期別
       apcf020   LIKE apcf_t.apcf020, #稅別
       apcf021   LIKE apcf_t.apcf021, #待沖銷應付會科
       apcf022   LIKE apcf_t.apcf022, #待沖銷未稅會科
       apcf023   LIKE apcf_t.apcf023, #待沖銷稅額會科
       apcf024   LIKE apcf_t.apcf024, #沖銷價差科目
       apcf025   LIKE apcf_t.apcf025, #沖銷會差科目
       apcf026   LIKE apcf_t.apcf026, #業務部門
       apcf027   LIKE apcf_t.apcf027, #責任中心
       apcf028   LIKE apcf_t.apcf028, #區域
       apcf029   LIKE apcf_t.apcf029, #收付款客商
       apcf030   LIKE apcf_t.apcf030, #帳款客商
       apcf031   LIKE apcf_t.apcf031, #客群
       apcf032   LIKE apcf_t.apcf032, #產品類別
       apcf033   LIKE apcf_t.apcf033, #業務人員
       apcf034   LIKE apcf_t.apcf034, #專案編號
       apcf035   LIKE apcf_t.apcf035, #WBS
       apcf036   LIKE apcf_t.apcf036, #經營方式
       apcf037   LIKE apcf_t.apcf037, #通路
       apcf038   LIKE apcf_t.apcf038, #品牌
       apcf039   LIKE apcf_t.apcf039, #自由核算項一
       apcf040   LIKE apcf_t.apcf040, #自由核算項二
       apcf041   LIKE apcf_t.apcf041, #自由核算項三
       apcf042   LIKE apcf_t.apcf042, #自由核算項四
       apcf043   LIKE apcf_t.apcf043, #自由核算項五
       apcf044   LIKE apcf_t.apcf044, #自由核算項六
       apcf045   LIKE apcf_t.apcf045, #自由核算項七
       apcf046   LIKE apcf_t.apcf046, #自由核算項八
       apcf047   LIKE apcf_t.apcf047, #自由核算項九
       apcf048   LIKE apcf_t.apcf048, #自由核算項十
       apcf049   LIKE apcf_t.apcf049, #摘要
       apcf101   LIKE apcf_t.apcf101, #原幣單價
       apcf102   LIKE apcf_t.apcf102, #原幣匯率
       apcf103   LIKE apcf_t.apcf103, #原幣未稅金額
       apcf104   LIKE apcf_t.apcf104, #原幣稅額
       apcf105   LIKE apcf_t.apcf105, #原幣含稅金額
       apcf106   LIKE apcf_t.apcf106, #原幣沖銷差異金額
       apcf111   LIKE apcf_t.apcf111, #本幣單價
       apcf113   LIKE apcf_t.apcf113, #本幣未稅金額
       apcf114   LIKE apcf_t.apcf114, #本幣稅額
       apcf115   LIKE apcf_t.apcf115, #本幣含稅金額
       apcf116   LIKE apcf_t.apcf116, #本幣價差金額
       apcf117   LIKE apcf_t.apcf117, #本幣匯差金額
       apcf122   LIKE apcf_t.apcf122, #暫估本未幣二匯率
       apcf123   LIKE apcf_t.apcf123, #本位幣二未稅金額
       apcf124   LIKE apcf_t.apcf124, #本位幣二稅額
       apcf125   LIKE apcf_t.apcf125, #本位幣二含稅金額
       apcf126   LIKE apcf_t.apcf126, #本位幣二價格差異金額
       apcf127   LIKE apcf_t.apcf127, #本位幣二匯差
       apcf132   LIKE apcf_t.apcf132, #暫估本位幣三匯率
       apcf133   LIKE apcf_t.apcf133, #本位幣三未稅金額
       apcf134   LIKE apcf_t.apcf134, #本位幣三稅額
       apcf135   LIKE apcf_t.apcf135, #本位幣三含稅金額
       apcf136   LIKE apcf_t.apcf136, #本位幣三價格差異金額
       apcf137   LIKE apcf_t.apcf137, #本位幣三匯差
       apcfud001 LIKE apcf_t.apcfud001, #自定義欄位(文字)001
       apcfud002 LIKE apcf_t.apcfud002, #自定義欄位(文字)002
       apcfud003 LIKE apcf_t.apcfud003, #自定義欄位(文字)003
       apcfud004 LIKE apcf_t.apcfud004, #自定義欄位(文字)004
       apcfud005 LIKE apcf_t.apcfud005, #自定義欄位(文字)005
       apcfud006 LIKE apcf_t.apcfud006, #自定義欄位(文字)006
       apcfud007 LIKE apcf_t.apcfud007, #自定義欄位(文字)007
       apcfud008 LIKE apcf_t.apcfud008, #自定義欄位(文字)008
       apcfud009 LIKE apcf_t.apcfud009, #自定義欄位(文字)009
       apcfud010 LIKE apcf_t.apcfud010, #自定義欄位(文字)010
       apcfud011 LIKE apcf_t.apcfud011, #自定義欄位(數字)011
       apcfud012 LIKE apcf_t.apcfud012, #自定義欄位(數字)012
       apcfud013 LIKE apcf_t.apcfud013, #自定義欄位(數字)013
       apcfud014 LIKE apcf_t.apcfud014, #自定義欄位(數字)014
       apcfud015 LIKE apcf_t.apcfud015, #自定義欄位(數字)015
       apcfud016 LIKE apcf_t.apcfud016, #自定義欄位(數字)016
       apcfud017 LIKE apcf_t.apcfud017, #自定義欄位(數字)017
       apcfud018 LIKE apcf_t.apcfud018, #自定義欄位(數字)018
       apcfud019 LIKE apcf_t.apcfud019, #自定義欄位(數字)019
       apcfud020 LIKE apcf_t.apcfud020, #自定義欄位(數字)020
       apcfud021 LIKE apcf_t.apcfud021, #自定義欄位(日期時間)021
       apcfud022 LIKE apcf_t.apcfud022, #自定義欄位(日期時間)022
       apcfud023 LIKE apcf_t.apcfud023, #自定義欄位(日期時間)023
       apcfud024 LIKE apcf_t.apcfud024, #自定義欄位(日期時間)024
       apcfud025 LIKE apcf_t.apcfud025, #自定義欄位(日期時間)025
       apcfud026 LIKE apcf_t.apcfud026, #自定義欄位(日期時間)026
       apcfud027 LIKE apcf_t.apcfud027, #自定義欄位(日期時間)027
       apcfud028 LIKE apcf_t.apcfud028, #自定義欄位(日期時間)028
       apcfud029 LIKE apcf_t.apcfud029, #自定義欄位(日期時間)029
       apcfud030 LIKE apcf_t.apcfud030  #自定義欄位(日期時間)030
          END RECORD
#161104-00024#2-add(e)
DEFINE g_glad              RECORD
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
DEFINE g_apcald            LIKE apca_t.apcald
DEFINE g_apcadocno         LIKE apca_t.apcadocno 
DEFINE g_dfin0030          LIKE type_t.chr1
DEFINE g_sfin2002          LIKE type_t.chr1
DEFINE g_sfin2011          LIKE type_t.chr1
DEFINE g_sfin3012          LIKE type_t.chr1
DEFINE g_apcf_tmp          DYNAMIC ARRAY OF RECORD
         apca001           LIKE apca_t.apca001,
         apcfseq           LIKE apcf_t.apcfseq,
         apcf103           LIKE apcf_t.apcf103,
         apcf104           LIKE apcf_t.apcf104,
         apcf105           LIKE apcf_t.apcf105,
         apcf106           LIKE apcf_t.apcf106,
         apcf107           LIKE apcf_t.apcf117,
         apcf113           LIKE apcf_t.apcf113,
         apcf114           LIKE apcf_t.apcf114,
         apcf115           LIKE apcf_t.apcf115,
         apcf116           LIKE apcf_t.apcf116,
         apcf117           LIKE apcf_t.apcf117,
         apcf123           LIKE apcf_t.apcf123,
         apcf124           LIKE apcf_t.apcf124,
         apcf125           LIKE apcf_t.apcf125,
         apcf133           LIKE apcf_t.apcf133,
         apcf134           LIKE apcf_t.apcf134,
         apcf135           LIKE apcf_t.apcf135 
                       END RECORD
DEFINE g_sql_ctrl      STRING  
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apcf_d          DYNAMIC ARRAY OF type_g_apcf_d #單身變數
DEFINE g_apcf_d_t        type_g_apcf_d                  #單身備份
DEFINE g_apcf_d_o        type_g_apcf_d                  #單身備份
DEFINE g_apcf_d_mask_o   DYNAMIC ARRAY OF type_g_apcf_d #單身變數
DEFINE g_apcf_d_mask_n   DYNAMIC ARRAY OF type_g_apcf_d #單身變數
DEFINE g_apcf2_d   DYNAMIC ARRAY OF type_g_apcf2_d
DEFINE g_apcf2_d_t type_g_apcf2_d
DEFINE g_apcf2_d_o type_g_apcf2_d
DEFINE g_apcf2_d_mask_o DYNAMIC ARRAY OF type_g_apcf2_d
DEFINE g_apcf2_d_mask_n DYNAMIC ARRAY OF type_g_apcf2_d
 
      
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
 
{<section id="aapt210_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aapt210_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_apcald,p_apcadocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_apcald        LIKE apca_t.apcald
   DEFINE p_apcadocno     LIKE apca_t.apcadocno
   DEFINE l_ap_slip       LIKE apca_t.apcadocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_apcadocno = p_apcadocno
   LET g_apcald    = p_apcald
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apcfdocno,apcfld,apcfseq,apcfseq2,apcf008,apcf009,apcf010,apcf021,apcf007, 
       apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022,apcf023,apcf111, 
       apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134,apcf135,apcf136,apcf137, 
       apcf001,apcf002,apcf024,apcf025,apcfld,apcfdocno,apcfseq,apcfseq2,apcf049,apcforga,apcf026,apcf027, 
       apcf028,apcf029,apcf030,apcf031,apcf032,apcf033,apcf034,apcf035,apcf036,apcf037,apcf038,apcf039, 
       apcf040,apcf041,apcf042,apcf043,apcf044,apcf045,apcf046,apcf047,apcf048 FROM apcf_t WHERE apcfent=?  
       AND apcfld=? AND apcfdocno=? AND apcfseq=? AND apcfseq2=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt210_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt210_01 WITH FORM cl_ap_formpath("aap","aapt210_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aapt210_01_init()   
 
   #進入選單 Menu (="N")
   CALL aapt210_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aapt210_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt210_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapt210_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_ap_slip     LIKE apca_t.apcadocno
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('apca001','8502','01,02,03,04')
   CALL cl_set_combo_scc('apcf036_2','6013')    #經營方式
   INITIALIZE g_glaa.* TO NULL   
   CALL s_ld_sel_glaa(g_apcald,'glaacomp|glaa004|glaa121')
        RETURNING g_sub_success, g_glaa.*
        
   #SELECT * INTO g_apca.* FROM apca_t    #161208-00026#5 mark
   #161208-00026#5-add(s)
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
     INTO g_apca.* FROM apca_t 
   #161208-00026#5-add(e)
    WHERE apcaent = g_enterprise
      AND apcald  = g_apcald  AND apcadocno = g_apcadocno 
   IF g_apca.apcastus <> 'N' THEN
      CALL cl_set_toolbaritem_visible("execute_add",FALSE)
      CALL cl_set_toolbaritem_visible("execute_del",FALSE)
   END IF
   CALL s_aooi200_fin_get_slip(g_apcadocno) RETURNING g_sub_success,l_ap_slip                  
   CALL s_fin_get_doc_para(g_apcald,g_apca.apcacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
   CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-2002') RETURNING g_sfin2002
  #CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-2011') RETURNING g_sfin2011
   CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-3011') RETURNING g_sfin2011
   CALL cl_get_para(g_enterprise,g_apca.apcacomp,'S-FIN-3012') RETURNING g_sfin3012 
   IF g_sfin2011 = 'N' THEN LET g_sfin3012 = '1' END IF  #1.立帳不含稅
   CALL cl_set_comp_entry("apcf103,apcf105,apcf113,apcf115,apcf123,apcf125,apcf133,apcf135",FALSE)
   IF g_sfin3012 = '1' THEN
      CALL cl_set_comp_entry("apcf103,apcf113,apcf123,apcf133",TRUE) #未稅欄位開放輸入
   ELSE
      CALL cl_set_comp_entry("apcf105,apcf115,apcf125,apcf135",TRUE) #含稅欄位開放輸入
   END IF
   #160920-00019#2---s
   LET g_sql_ctrl = NULL
   CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #160920-00019#2---e
   #end add-point
   
   CALL aapt210_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapt210_01_ui_dialog()
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
   DEFINE l_sql      STRING
   DEFINE l_cnt      LIKE type_t.num5
   #DEFINE l_apcb     RECORD LIKE apcb_t.* #161104-00024#2 mark
   #161104-00024#2-add(s)
   DEFINE l_apcb    RECORD  #應付憑單單身
       apcbent   LIKE apcb_t.apcbent, #企業編號
       apcbld    LIKE apcb_t.apcbld, #帳套
       apcblegl  LIKE apcb_t.apcblegl, #核算組織
       apcborga  LIKE apcb_t.apcborga, #帳務歸屬組織(來源組織)
       apcbsite  LIKE apcb_t.apcbsite, #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq   LIKE apcb_t.apcbseq, #項次
       apcb001   LIKE apcb_t.apcb001, #來源類型
       apcb002   LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003   LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004   LIKE apcb_t.apcb004, #產品編號
       apcb005   LIKE apcb_t.apcb005, #品名規格
       apcb006   LIKE apcb_t.apcb006, #單位
       apcb007   LIKE apcb_t.apcb007, #計價數量
       apcb008   LIKE apcb_t.apcb008, #參考單據號碼
       apcb009   LIKE apcb_t.apcb009, #參考單據項次
       apcb010   LIKE apcb_t.apcb010, #業務部門
       apcb011   LIKE apcb_t.apcb011, #責任中心
       apcb012   LIKE apcb_t.apcb012, #產品類別
       apcb013   LIKE apcb_t.apcb013, #搭贈
       apcb014   LIKE apcb_t.apcb014, #理由碼
       apcb015   LIKE apcb_t.apcb015, #專案編號
       apcb016   LIKE apcb_t.apcb016, #WBS編號
       apcb017   LIKE apcb_t.apcb017, #預算細項
       apcb018   LIKE apcb_t.apcb018, #专柜编号
       apcb019   LIKE apcb_t.apcb019, #開票性質
       apcb020   LIKE apcb_t.apcb020, #稅別
       apcb021   LIKE apcb_t.apcb021, #費用會計科目
       apcb022   LIKE apcb_t.apcb022, #正負值
       apcb023   LIKE apcb_t.apcb023, #沖暫估單否
       apcb024   LIKE apcb_t.apcb024, #區域
       apcb025   LIKE apcb_t.apcb025, #傳票號碼
       apcb026   LIKE apcb_t.apcb026, #傳票項次
       apcb027   LIKE apcb_t.apcb027, #發票代碼
       apcb028   LIKE apcb_t.apcb028, #發票號碼
       apcb029   LIKE apcb_t.apcb029, #應付帳款科目
       apcb030   LIKE apcb_t.apcb030, #付款條件
       apcb032   LIKE apcb_t.apcb032, #訂金序次
       apcb033   LIKE apcb_t.apcb033, #經營方式
       apcb034   LIKE apcb_t.apcb034, #通路
       apcb035   LIKE apcb_t.apcb035, #品牌
       apcb036   LIKE apcb_t.apcb036, #客群
       apcb037   LIKE apcb_t.apcb037, #自由核算項一
       apcb038   LIKE apcb_t.apcb038, #自由核算項二
       apcb039   LIKE apcb_t.apcb039, #自由核算項三
       apcb040   LIKE apcb_t.apcb040, #自由核算項四
       apcb041   LIKE apcb_t.apcb041, #自由核算項五
       apcb042   LIKE apcb_t.apcb042, #自由核算項六
       apcb043   LIKE apcb_t.apcb043, #自由核算項七
       apcb044   LIKE apcb_t.apcb044, #自由核算項八
       apcb045   LIKE apcb_t.apcb045, #自由核算項九
       apcb046   LIKE apcb_t.apcb046, #自由核算項十
       apcb047   LIKE apcb_t.apcb047, #摘要
       apcb048   LIKE apcb_t.apcb048, #來源訂購單號
       apcb049   LIKE apcb_t.apcb049, #開票單號
       apcb050   LIKE apcb_t.apcb050, #開票項次
       apcb051   LIKE apcb_t.apcb051, #業務人員
       apcb100   LIKE apcb_t.apcb100, #交易原幣
       apcb101   LIKE apcb_t.apcb101, #交易原幣單價
       apcb102   LIKE apcb_t.apcb102, #原幣匯率
       apcb103   LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb104   LIKE apcb_t.apcb104, #交易原幣稅額
       apcb105   LIKE apcb_t.apcb105, #交易原幣含稅金額
       apcb106   LIKE apcb_t.apcb106, #交易幣標準成本金額
       apcb107   LIKE apcb_t.apcb107, #NO USE
       apcb108   LIKE apcb_t.apcb108, #交易原幣成本認列金額
       apcb111   LIKE apcb_t.apcb111, #本幣單價
       apcb113   LIKE apcb_t.apcb113, #本幣未稅金額
       apcb114   LIKE apcb_t.apcb114, #本幣稅額
       apcb115   LIKE apcb_t.apcb115, #本幣含稅金額
       apcb116   LIKE apcb_t.apcb116, #本幣標準成本金額
       apcb117   LIKE apcb_t.apcb117, #NO USE
       apcb118   LIKE apcb_t.apcb118, #本幣成本認列金額
       apcb119   LIKE apcb_t.apcb119, #應開發票含稅金額
       apcb121   LIKE apcb_t.apcb121, #本位幣二匯率
       apcb123   LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb124   LIKE apcb_t.apcb124, #本位幣二稅額
       apcb125   LIKE apcb_t.apcb125, #本位幣二含稅金額
       apcb126   LIKE apcb_t.apcb126, #本幣二標準成本金額
       apcb127   LIKE apcb_t.apcb127, #NO USE
       apcb128   LIKE apcb_t.apcb128, #本位幣二成本認列金額
       apcb131   LIKE apcb_t.apcb131, #本位幣三匯率
       apcb133   LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb134   LIKE apcb_t.apcb134, #本位幣三稅額
       apcb135   LIKE apcb_t.apcb135, #本位幣三含稅金額
       apcb136   LIKE apcb_t.apcb136, #本幣三標準成本金額
       apcb137   LIKE apcb_t.apcb137, #NO USE
       apcb138   LIKE apcb_t.apcb138, #本位幣三成本認列金額
       apcbud001 LIKE apcb_t.apcbud001, #自定義欄位(文字)001
       apcbud002 LIKE apcb_t.apcbud002, #自定義欄位(文字)002
       apcbud003 LIKE apcb_t.apcbud003, #自定義欄位(文字)003
       apcbud004 LIKE apcb_t.apcbud004, #自定義欄位(文字)004
       apcbud005 LIKE apcb_t.apcbud005, #自定義欄位(文字)005
       apcbud006 LIKE apcb_t.apcbud006, #自定義欄位(文字)006
       apcbud007 LIKE apcb_t.apcbud007, #自定義欄位(文字)007
       apcbud008 LIKE apcb_t.apcbud008, #自定義欄位(文字)008
       apcbud009 LIKE apcb_t.apcbud009, #自定義欄位(文字)009
       apcbud010 LIKE apcb_t.apcbud010, #自定義欄位(文字)010
       apcbud011 LIKE apcb_t.apcbud011, #自定義欄位(數字)011
       apcbud012 LIKE apcb_t.apcbud012, #自定義欄位(數字)012
       apcbud013 LIKE apcb_t.apcbud013, #自定義欄位(數字)013
       apcbud014 LIKE apcb_t.apcbud014, #自定義欄位(數字)014
       apcbud015 LIKE apcb_t.apcbud015, #自定義欄位(數字)015
       apcbud016 LIKE apcb_t.apcbud016, #自定義欄位(數字)016
       apcbud017 LIKE apcb_t.apcbud017, #自定義欄位(數字)017
       apcbud018 LIKE apcb_t.apcbud018, #自定義欄位(數字)018
       apcbud019 LIKE apcb_t.apcbud019, #自定義欄位(數字)019
       apcbud020 LIKE apcb_t.apcbud020, #自定義欄位(數字)020
       apcbud021 LIKE apcb_t.apcbud021, #自定義欄位(日期時間)021
       apcbud022 LIKE apcb_t.apcbud022, #自定義欄位(日期時間)022
       apcbud023 LIKE apcb_t.apcbud023, #自定義欄位(日期時間)023
       apcbud024 LIKE apcb_t.apcbud024, #自定義欄位(日期時間)024
       apcbud025 LIKE apcb_t.apcbud025, #自定義欄位(日期時間)025
       apcbud026 LIKE apcb_t.apcbud026, #自定義欄位(日期時間)026
       apcbud027 LIKE apcb_t.apcbud027, #自定義欄位(日期時間)027
       apcbud028 LIKE apcb_t.apcbud028, #自定義欄位(日期時間)028
       apcbud029 LIKE apcb_t.apcbud029, #自定義欄位(日期時間)029
       apcbud030 LIKE apcb_t.apcbud030, #自定義欄位(日期時間)030
       apcb052   LIKE apcb_t.apcb052, #稅額
       apcb053   LIKE apcb_t.apcb053, #含稅金額
       apcb054   LIKE apcb_t.apcb054, #帳款對象
       apcb055   LIKE apcb_t.apcb055  #付款對象
                END RECORD
   #161104-00024#2-add(e)
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #150727-(S)
   SELECT count(*) INTO l_cnt
     FROM apcb_t
    WHERE apcbent = g_enterprise
      AND apcbld = g_apcald AND apcbdocno = g_apcadocno
      AND apcb023 = 'Y'
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "aap-00381"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   #150727-(E)
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apcf_d.clear()
         CALL g_apcf2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapt210_01_init()
      END IF
   
      CALL aapt210_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apcf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aapt210_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_apcf2_d TO s_detail2.*
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
   CALL aapt210_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
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
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            CALL cl_set_act_visible("logistics", FALSE)
            IF g_apca.apcastus NOT MATCHES "[N]" THEN   
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
            END IF  
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION execute_add
            LET g_action_choice="execute_add"
               
               #add-point:ON ACTION execute_add name="menu.execute_add"
               #整批新增
               CALL s_transaction_begin()
               CALL s_aapp831_del_apcf(g_apcald,g_apcadocno)
               CALL s_aapp831_ins_apcf('0',g_apcald,g_apcadocno) RETURNING g_sub_success
               IF g_sub_success THEN
                  CALL s_transaction_end('Y','0')
                  CALL aapt210_01_b_fill('')  
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               #END add-point
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapt210_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt210_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapt210_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt210_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt210_01_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapt210_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt210_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION execute_del
            LET g_action_choice="execute_del"
               
               #add-point:ON ACTION execute_del name="menu.execute_del"
               #整批刪除
               CALL s_transaction_begin()
               CALL s_aapp831_del_apcf(g_apcald,g_apcadocno)
               IF SQLCA.SQLERRD[3] > 0 THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               CALL aapt210_01_b_fill('')  
               #END add-point
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apcf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_apcf2_d)
               LET g_export_id[2]   = "s_detail2"
 
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
            CALL aapt210_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt210_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt210_01_set_pk_array()
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
 
{<section id="aapt210_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt210_01_query()
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
   CALL g_apcf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON apcfdocno,apcfld,apcfseq,apcfseq2,apca001,apcf008,apcf009,apcf010,apcf021,l_apcf021_desc, 
          apcf007,apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022,apcf023, 
          apcf111,apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134,apcf135,apcf136, 
          apcf137,apcf001,apcf002,apcf024,apcf025,apcf008_desc,apcforga_desc,apcf026_desc,apcf027_desc, 
          apcf028_desc,apcf029_desc,apcf030_desc,apcf031_desc,apcf032_desc,apcf033_desc,apcf034_desc, 
          apcf035_desc,apcf037_desc,apcf038_desc,apcf039_desc,apcf040_desc,apcf041_desc,apcf042_desc, 
          apcf043_desc,apcf044_desc,apcf045_desc,apcf046_desc,apcf047_desc,apcf048_desc 
 
         FROM s_detail1[1].apcfdocno,s_detail1[1].apcfld,s_detail1[1].apcfseq,s_detail1[1].apcfseq2, 
             s_detail1[1].apca001,s_detail1[1].apcf008,s_detail1[1].apcf009,s_detail1[1].apcf010,s_detail1[1].apcf021, 
             s_detail1[1].l_apcf021_desc,s_detail1[1].apcf007,s_detail1[1].apcf101,s_detail1[1].apcf103, 
             s_detail1[1].apcf104,s_detail1[1].apcf105,s_detail1[1].apcf102,s_detail1[1].apcf113,s_detail1[1].apcf114, 
             s_detail1[1].apcf115,s_detail1[1].apcf020,s_detail1[1].apcf022,s_detail1[1].apcf023,s_detail1[1].apcf111, 
             s_detail1[1].apcf122,s_detail1[1].apcf123,s_detail1[1].apcf124,s_detail1[1].apcf125,s_detail1[1].apcf126, 
             s_detail1[1].apcf127,s_detail1[1].apcf132,s_detail1[1].apcf133,s_detail1[1].apcf134,s_detail1[1].apcf135, 
             s_detail1[1].apcf136,s_detail1[1].apcf137,s_detail1[1].apcf001,s_detail1[1].apcf002,s_detail1[1].apcf024, 
             s_detail1[1].apcf025,s_detail2[1].apcf008_desc,s_detail2[1].apcforga_desc,s_detail2[1].apcf026_desc, 
             s_detail2[1].apcf027_desc,s_detail2[1].apcf028_desc,s_detail2[1].apcf029_desc,s_detail2[1].apcf030_desc, 
             s_detail2[1].apcf031_desc,s_detail2[1].apcf032_desc,s_detail2[1].apcf033_desc,s_detail2[1].apcf034_desc, 
             s_detail2[1].apcf035_desc,s_detail2[1].apcf037_desc,s_detail2[1].apcf038_desc,s_detail2[1].apcf039_desc, 
             s_detail2[1].apcf040_desc,s_detail2[1].apcf041_desc,s_detail2[1].apcf042_desc,s_detail2[1].apcf043_desc, 
             s_detail2[1].apcf044_desc,s_detail2[1].apcf045_desc,s_detail2[1].apcf046_desc,s_detail2[1].apcf047_desc, 
             s_detail2[1].apcf048_desc 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfdocno
            #add-point:BEFORE FIELD apcfdocno name="query.b.page1.apcfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfdocno
            
            #add-point:AFTER FIELD apcfdocno name="query.a.page1.apcfdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfdocno
            #add-point:ON ACTION controlp INFIELD apcfdocno name="query.c.page1.apcfdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfld
            #add-point:BEFORE FIELD apcfld name="query.b.page1.apcfld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfld
            
            #add-point:AFTER FIELD apcfld name="query.a.page1.apcfld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcfld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfld
            #add-point:ON ACTION controlp INFIELD apcfld name="query.c.page1.apcfld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfseq
            #add-point:BEFORE FIELD apcfseq name="query.b.page1.apcfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfseq
            
            #add-point:AFTER FIELD apcfseq name="query.a.page1.apcfseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfseq
            #add-point:ON ACTION controlp INFIELD apcfseq name="query.c.page1.apcfseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfseq2
            #add-point:BEFORE FIELD apcfseq2 name="query.b.page1.apcfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfseq2
            
            #add-point:AFTER FIELD apcfseq2 name="query.a.page1.apcfseq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfseq2
            #add-point:ON ACTION controlp INFIELD apcfseq2 name="query.c.page1.apcfseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="query.b.page1.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="query.a.page1.apca001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="query.c.page1.apca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf008
            #add-point:BEFORE FIELD apcf008 name="query.b.page1.apcf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf008
            
            #add-point:AFTER FIELD apcf008 name="query.a.page1.apcf008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf008
            #add-point:ON ACTION controlp INFIELD apcf008 name="query.c.page1.apcf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf009
            #add-point:BEFORE FIELD apcf009 name="query.b.page1.apcf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf009
            
            #add-point:AFTER FIELD apcf009 name="query.a.page1.apcf009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf009
            #add-point:ON ACTION controlp INFIELD apcf009 name="query.c.page1.apcf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf010
            #add-point:BEFORE FIELD apcf010 name="query.b.page1.apcf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf010
            
            #add-point:AFTER FIELD apcf010 name="query.a.page1.apcf010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf010
            #add-point:ON ACTION controlp INFIELD apcf010 name="query.c.page1.apcf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf021
            #add-point:BEFORE FIELD apcf021 name="query.b.page1.apcf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf021
            
            #add-point:AFTER FIELD apcf021 name="query.a.page1.apcf021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf021
            #add-point:ON ACTION controlp INFIELD apcf021 name="query.c.page1.apcf021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcf021_desc
            #add-point:BEFORE FIELD l_apcf021_desc name="query.b.page1.l_apcf021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcf021_desc
            
            #add-point:AFTER FIELD l_apcf021_desc name="query.a.page1.l_apcf021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.l_apcf021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcf021_desc
            #add-point:ON ACTION controlp INFIELD l_apcf021_desc name="query.c.page1.l_apcf021_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf007
            #add-point:BEFORE FIELD apcf007 name="query.b.page1.apcf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf007
            
            #add-point:AFTER FIELD apcf007 name="query.a.page1.apcf007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf007
            #add-point:ON ACTION controlp INFIELD apcf007 name="query.c.page1.apcf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf101
            #add-point:BEFORE FIELD apcf101 name="query.b.page1.apcf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf101
            
            #add-point:AFTER FIELD apcf101 name="query.a.page1.apcf101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf101
            #add-point:ON ACTION controlp INFIELD apcf101 name="query.c.page1.apcf101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf103
            #add-point:BEFORE FIELD apcf103 name="query.b.page1.apcf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf103
            
            #add-point:AFTER FIELD apcf103 name="query.a.page1.apcf103"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf103
            #add-point:ON ACTION controlp INFIELD apcf103 name="query.c.page1.apcf103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf104
            #add-point:BEFORE FIELD apcf104 name="query.b.page1.apcf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf104
            
            #add-point:AFTER FIELD apcf104 name="query.a.page1.apcf104"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf104
            #add-point:ON ACTION controlp INFIELD apcf104 name="query.c.page1.apcf104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf105
            #add-point:BEFORE FIELD apcf105 name="query.b.page1.apcf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf105
            
            #add-point:AFTER FIELD apcf105 name="query.a.page1.apcf105"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf105
            #add-point:ON ACTION controlp INFIELD apcf105 name="query.c.page1.apcf105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf102
            #add-point:BEFORE FIELD apcf102 name="query.b.page1.apcf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf102
            
            #add-point:AFTER FIELD apcf102 name="query.a.page1.apcf102"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf102
            #add-point:ON ACTION controlp INFIELD apcf102 name="query.c.page1.apcf102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf113
            #add-point:BEFORE FIELD apcf113 name="query.b.page1.apcf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf113
            
            #add-point:AFTER FIELD apcf113 name="query.a.page1.apcf113"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf113
            #add-point:ON ACTION controlp INFIELD apcf113 name="query.c.page1.apcf113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf114
            #add-point:BEFORE FIELD apcf114 name="query.b.page1.apcf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf114
            
            #add-point:AFTER FIELD apcf114 name="query.a.page1.apcf114"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf114
            #add-point:ON ACTION controlp INFIELD apcf114 name="query.c.page1.apcf114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf115
            #add-point:BEFORE FIELD apcf115 name="query.b.page1.apcf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf115
            
            #add-point:AFTER FIELD apcf115 name="query.a.page1.apcf115"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf115
            #add-point:ON ACTION controlp INFIELD apcf115 name="query.c.page1.apcf115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf020
            #add-point:BEFORE FIELD apcf020 name="query.b.page1.apcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf020
            
            #add-point:AFTER FIELD apcf020 name="query.a.page1.apcf020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf020
            #add-point:ON ACTION controlp INFIELD apcf020 name="query.c.page1.apcf020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf022
            #add-point:BEFORE FIELD apcf022 name="query.b.page1.apcf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf022
            
            #add-point:AFTER FIELD apcf022 name="query.a.page1.apcf022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf022
            #add-point:ON ACTION controlp INFIELD apcf022 name="query.c.page1.apcf022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf023
            #add-point:BEFORE FIELD apcf023 name="query.b.page1.apcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf023
            
            #add-point:AFTER FIELD apcf023 name="query.a.page1.apcf023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf023
            #add-point:ON ACTION controlp INFIELD apcf023 name="query.c.page1.apcf023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf111
            #add-point:BEFORE FIELD apcf111 name="query.b.page1.apcf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf111
            
            #add-point:AFTER FIELD apcf111 name="query.a.page1.apcf111"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf111
            #add-point:ON ACTION controlp INFIELD apcf111 name="query.c.page1.apcf111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf122
            #add-point:BEFORE FIELD apcf122 name="query.b.page1.apcf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf122
            
            #add-point:AFTER FIELD apcf122 name="query.a.page1.apcf122"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf122
            #add-point:ON ACTION controlp INFIELD apcf122 name="query.c.page1.apcf122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf123
            #add-point:BEFORE FIELD apcf123 name="query.b.page1.apcf123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf123
            
            #add-point:AFTER FIELD apcf123 name="query.a.page1.apcf123"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf123
            #add-point:ON ACTION controlp INFIELD apcf123 name="query.c.page1.apcf123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf124
            #add-point:BEFORE FIELD apcf124 name="query.b.page1.apcf124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf124
            
            #add-point:AFTER FIELD apcf124 name="query.a.page1.apcf124"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf124
            #add-point:ON ACTION controlp INFIELD apcf124 name="query.c.page1.apcf124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf125
            #add-point:BEFORE FIELD apcf125 name="query.b.page1.apcf125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf125
            
            #add-point:AFTER FIELD apcf125 name="query.a.page1.apcf125"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf125
            #add-point:ON ACTION controlp INFIELD apcf125 name="query.c.page1.apcf125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf126
            #add-point:BEFORE FIELD apcf126 name="query.b.page1.apcf126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf126
            
            #add-point:AFTER FIELD apcf126 name="query.a.page1.apcf126"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf126
            #add-point:ON ACTION controlp INFIELD apcf126 name="query.c.page1.apcf126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf127
            #add-point:BEFORE FIELD apcf127 name="query.b.page1.apcf127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf127
            
            #add-point:AFTER FIELD apcf127 name="query.a.page1.apcf127"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf127
            #add-point:ON ACTION controlp INFIELD apcf127 name="query.c.page1.apcf127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf132
            #add-point:BEFORE FIELD apcf132 name="query.b.page1.apcf132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf132
            
            #add-point:AFTER FIELD apcf132 name="query.a.page1.apcf132"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf132
            #add-point:ON ACTION controlp INFIELD apcf132 name="query.c.page1.apcf132"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf133
            #add-point:BEFORE FIELD apcf133 name="query.b.page1.apcf133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf133
            
            #add-point:AFTER FIELD apcf133 name="query.a.page1.apcf133"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf133
            #add-point:ON ACTION controlp INFIELD apcf133 name="query.c.page1.apcf133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf134
            #add-point:BEFORE FIELD apcf134 name="query.b.page1.apcf134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf134
            
            #add-point:AFTER FIELD apcf134 name="query.a.page1.apcf134"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf134
            #add-point:ON ACTION controlp INFIELD apcf134 name="query.c.page1.apcf134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf135
            #add-point:BEFORE FIELD apcf135 name="query.b.page1.apcf135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf135
            
            #add-point:AFTER FIELD apcf135 name="query.a.page1.apcf135"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf135
            #add-point:ON ACTION controlp INFIELD apcf135 name="query.c.page1.apcf135"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf136
            #add-point:BEFORE FIELD apcf136 name="query.b.page1.apcf136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf136
            
            #add-point:AFTER FIELD apcf136 name="query.a.page1.apcf136"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf136
            #add-point:ON ACTION controlp INFIELD apcf136 name="query.c.page1.apcf136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf137
            #add-point:BEFORE FIELD apcf137 name="query.b.page1.apcf137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf137
            
            #add-point:AFTER FIELD apcf137 name="query.a.page1.apcf137"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf137
            #add-point:ON ACTION controlp INFIELD apcf137 name="query.c.page1.apcf137"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf001
            #add-point:BEFORE FIELD apcf001 name="query.b.page1.apcf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf001
            
            #add-point:AFTER FIELD apcf001 name="query.a.page1.apcf001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf001
            #add-point:ON ACTION controlp INFIELD apcf001 name="query.c.page1.apcf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf002
            #add-point:BEFORE FIELD apcf002 name="query.b.page1.apcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf002
            
            #add-point:AFTER FIELD apcf002 name="query.a.page1.apcf002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf002
            #add-point:ON ACTION controlp INFIELD apcf002 name="query.c.page1.apcf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf024
            #add-point:BEFORE FIELD apcf024 name="query.b.page1.apcf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf024
            
            #add-point:AFTER FIELD apcf024 name="query.a.page1.apcf024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf024
            #add-point:ON ACTION controlp INFIELD apcf024 name="query.c.page1.apcf024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf025
            #add-point:BEFORE FIELD apcf025 name="query.b.page1.apcf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf025
            
            #add-point:AFTER FIELD apcf025 name="query.a.page1.apcf025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf025
            #add-point:ON ACTION controlp INFIELD apcf025 name="query.c.page1.apcf025"
            
            #END add-point
 
 
  
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf008_desc
            #add-point:BEFORE FIELD apcf008_desc name="query.b.page2.apcf008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf008_desc
            
            #add-point:AFTER FIELD apcf008_desc name="query.a.page2.apcf008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf008_desc
            #add-point:ON ACTION controlp INFIELD apcf008_desc name="query.c.page2.apcf008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf021_desc
            #add-point:BEFORE FIELD apcf021_desc name="query.b.page2.apcf021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf021_desc
            
            #add-point:AFTER FIELD apcf021_desc name="query.a.page2.apcf021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf021_desc
            #add-point:ON ACTION controlp INFIELD apcf021_desc name="query.c.page2.apcf021_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcforga_desc
            #add-point:BEFORE FIELD apcforga_desc name="query.b.page2.apcforga_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcforga_desc
            
            #add-point:AFTER FIELD apcforga_desc name="query.a.page2.apcforga_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcforga_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcforga_desc
            #add-point:ON ACTION controlp INFIELD apcforga_desc name="query.c.page2.apcforga_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf026_desc
            #add-point:BEFORE FIELD apcf026_desc name="query.b.page2.apcf026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf026_desc
            
            #add-point:AFTER FIELD apcf026_desc name="query.a.page2.apcf026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf026_desc
            #add-point:ON ACTION controlp INFIELD apcf026_desc name="query.c.page2.apcf026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf027_desc
            #add-point:BEFORE FIELD apcf027_desc name="query.b.page2.apcf027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf027_desc
            
            #add-point:AFTER FIELD apcf027_desc name="query.a.page2.apcf027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf027_desc
            #add-point:ON ACTION controlp INFIELD apcf027_desc name="query.c.page2.apcf027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf028_desc
            #add-point:BEFORE FIELD apcf028_desc name="query.b.page2.apcf028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf028_desc
            
            #add-point:AFTER FIELD apcf028_desc name="query.a.page2.apcf028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf028_desc
            #add-point:ON ACTION controlp INFIELD apcf028_desc name="query.c.page2.apcf028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf029_desc
            #add-point:BEFORE FIELD apcf029_desc name="query.b.page2.apcf029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf029_desc
            
            #add-point:AFTER FIELD apcf029_desc name="query.a.page2.apcf029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf029_desc
            #add-point:ON ACTION controlp INFIELD apcf029_desc name="query.c.page2.apcf029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf030_desc
            #add-point:BEFORE FIELD apcf030_desc name="query.b.page2.apcf030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf030_desc
            
            #add-point:AFTER FIELD apcf030_desc name="query.a.page2.apcf030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf030_desc
            #add-point:ON ACTION controlp INFIELD apcf030_desc name="query.c.page2.apcf030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf031_desc
            #add-point:BEFORE FIELD apcf031_desc name="query.b.page2.apcf031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf031_desc
            
            #add-point:AFTER FIELD apcf031_desc name="query.a.page2.apcf031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf031_desc
            #add-point:ON ACTION controlp INFIELD apcf031_desc name="query.c.page2.apcf031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf032_desc
            #add-point:BEFORE FIELD apcf032_desc name="query.b.page2.apcf032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf032_desc
            
            #add-point:AFTER FIELD apcf032_desc name="query.a.page2.apcf032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf032_desc
            #add-point:ON ACTION controlp INFIELD apcf032_desc name="query.c.page2.apcf032_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf033_desc
            #add-point:BEFORE FIELD apcf033_desc name="query.b.page2.apcf033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf033_desc
            
            #add-point:AFTER FIELD apcf033_desc name="query.a.page2.apcf033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf033_desc
            #add-point:ON ACTION controlp INFIELD apcf033_desc name="query.c.page2.apcf033_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf034_desc
            #add-point:BEFORE FIELD apcf034_desc name="query.b.page2.apcf034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf034_desc
            
            #add-point:AFTER FIELD apcf034_desc name="query.a.page2.apcf034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf034_desc
            #add-point:ON ACTION controlp INFIELD apcf034_desc name="query.c.page2.apcf034_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf035_desc
            #add-point:BEFORE FIELD apcf035_desc name="query.b.page2.apcf035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf035_desc
            
            #add-point:AFTER FIELD apcf035_desc name="query.a.page2.apcf035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf035_desc
            #add-point:ON ACTION controlp INFIELD apcf035_desc name="query.c.page2.apcf035_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf037_desc
            #add-point:BEFORE FIELD apcf037_desc name="query.b.page2.apcf037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf037_desc
            
            #add-point:AFTER FIELD apcf037_desc name="query.a.page2.apcf037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf037_desc
            #add-point:ON ACTION controlp INFIELD apcf037_desc name="query.c.page2.apcf037_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf038_desc
            #add-point:BEFORE FIELD apcf038_desc name="query.b.page2.apcf038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf038_desc
            
            #add-point:AFTER FIELD apcf038_desc name="query.a.page2.apcf038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf038_desc
            #add-point:ON ACTION controlp INFIELD apcf038_desc name="query.c.page2.apcf038_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf039_desc
            #add-point:BEFORE FIELD apcf039_desc name="query.b.page2.apcf039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf039_desc
            
            #add-point:AFTER FIELD apcf039_desc name="query.a.page2.apcf039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf039_desc
            #add-point:ON ACTION controlp INFIELD apcf039_desc name="query.c.page2.apcf039_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf040_desc
            #add-point:BEFORE FIELD apcf040_desc name="query.b.page2.apcf040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf040_desc
            
            #add-point:AFTER FIELD apcf040_desc name="query.a.page2.apcf040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf040_desc
            #add-point:ON ACTION controlp INFIELD apcf040_desc name="query.c.page2.apcf040_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf041_desc
            #add-point:BEFORE FIELD apcf041_desc name="query.b.page2.apcf041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf041_desc
            
            #add-point:AFTER FIELD apcf041_desc name="query.a.page2.apcf041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf041_desc
            #add-point:ON ACTION controlp INFIELD apcf041_desc name="query.c.page2.apcf041_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf042_desc
            #add-point:BEFORE FIELD apcf042_desc name="query.b.page2.apcf042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf042_desc
            
            #add-point:AFTER FIELD apcf042_desc name="query.a.page2.apcf042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf042_desc
            #add-point:ON ACTION controlp INFIELD apcf042_desc name="query.c.page2.apcf042_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf043_desc
            #add-point:BEFORE FIELD apcf043_desc name="query.b.page2.apcf043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf043_desc
            
            #add-point:AFTER FIELD apcf043_desc name="query.a.page2.apcf043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf043_desc
            #add-point:ON ACTION controlp INFIELD apcf043_desc name="query.c.page2.apcf043_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf044_desc
            #add-point:BEFORE FIELD apcf044_desc name="query.b.page2.apcf044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf044_desc
            
            #add-point:AFTER FIELD apcf044_desc name="query.a.page2.apcf044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf044_desc
            #add-point:ON ACTION controlp INFIELD apcf044_desc name="query.c.page2.apcf044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf045_desc
            #add-point:BEFORE FIELD apcf045_desc name="query.b.page2.apcf045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf045_desc
            
            #add-point:AFTER FIELD apcf045_desc name="query.a.page2.apcf045_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf045_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf045_desc
            #add-point:ON ACTION controlp INFIELD apcf045_desc name="query.c.page2.apcf045_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf046_desc
            #add-point:BEFORE FIELD apcf046_desc name="query.b.page2.apcf046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf046_desc
            
            #add-point:AFTER FIELD apcf046_desc name="query.a.page2.apcf046_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf046_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf046_desc
            #add-point:ON ACTION controlp INFIELD apcf046_desc name="query.c.page2.apcf046_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf047_desc
            #add-point:BEFORE FIELD apcf047_desc name="query.b.page2.apcf047_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf047_desc
            
            #add-point:AFTER FIELD apcf047_desc name="query.a.page2.apcf047_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf047_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf047_desc
            #add-point:ON ACTION controlp INFIELD apcf047_desc name="query.c.page2.apcf047_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf048_desc
            #add-point:BEFORE FIELD apcf048_desc name="query.b.page2.apcf048_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf048_desc
            
            #add-point:AFTER FIELD apcf048_desc name="query.a.page2.apcf048_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcf048_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf048_desc
            #add-point:ON ACTION controlp INFIELD apcf048_desc name="query.c.page2.apcf048_desc"
            
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
    
   CALL aapt210_01_b_fill(g_wc2)
 
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
 
{<section id="aapt210_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt210_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapt210_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt210_01_modify()
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
   DEFINE  l_apca001              LIKE apca_t.apca001
   DEFINE  l_apcb001              LIKE apcb_t.apcb001
   DEFINE  l_apcb007              LIKE apcb_t.apcb007
   DEFINE  l_apcf007              LIKE apcf_t.apcf007
   DEFINE  l_apcf103              LIKE apcf_t.apcf103
   DEFINE  l_oodb005              LIKE oodb_t.oodb005
   DEFINE  l_desc                 LIKE type_t.chr5
   DEFINE  l_apca100              LIKE apca_t.apca100
   DEFINE  l_glae009              LIKE glae_t.glae009
   DEFINE  l_sfin2011             LIKE type_t.chr1
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   
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
            LET g_errparam.code   = 'axc-00037' 
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
      INPUT ARRAY g_apcf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apcf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt210_01_b_fill(g_wc2)
            LET g_detail_cnt = g_apcf_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apcf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_apcf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apcf_d[l_ac].apcfld IS NOT NULL
               AND g_apcf_d[l_ac].apcfdocno IS NOT NULL
               AND g_apcf_d[l_ac].apcfseq IS NOT NULL
               AND g_apcf_d[l_ac].apcfseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apcf_d_t.* = g_apcf_d[l_ac].*  #BACKUP
               LET g_apcf_d_o.* = g_apcf_d[l_ac].*  #BACKUP
               IF NOT aapt210_01_lock_b("apcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt210_01_bcl INTO g_apcf_d[l_ac].apcfdocno,g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcfseq, 
                      g_apcf_d[l_ac].apcfseq2,g_apcf_d[l_ac].apcf008,g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010, 
                      g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].apcf007,g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103, 
                      g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105,g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113, 
                      g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115,g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022, 
                      g_apcf_d[l_ac].apcf023,g_apcf_d[l_ac].apcf111,g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123, 
                      g_apcf_d[l_ac].apcf124,g_apcf_d[l_ac].apcf125,g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127, 
                      g_apcf_d[l_ac].apcf132,g_apcf_d[l_ac].apcf133,g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135, 
                      g_apcf_d[l_ac].apcf136,g_apcf_d[l_ac].apcf137,g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002, 
                      g_apcf_d[l_ac].apcf024,g_apcf_d[l_ac].apcf025,g_apcf2_d[l_ac].apcfld,g_apcf2_d[l_ac].apcfdocno, 
                      g_apcf2_d[l_ac].apcfseq,g_apcf2_d[l_ac].apcfseq2,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga, 
                      g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029, 
                      g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033, 
                      g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037, 
                      g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041, 
                      g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045, 
                      g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf048
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apcf_d_t.apcfld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apcf_d_mask_o[l_ac].* =  g_apcf_d[l_ac].*
                  CALL aapt210_01_apcf_t_mask()
                  LET g_apcf_d_mask_n[l_ac].* =  g_apcf_d[l_ac].*
                  
                  CALL aapt210_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt210_01_set_entry_b(l_cmd)
            CALL aapt210_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
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
            INITIALIZE g_apcf_d_t.* TO NULL
            INITIALIZE g_apcf_d_o.* TO NULL
            INITIALIZE g_apcf_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身2)
                  LET g_apcf_d[l_ac].apcf007 = "0"
      LET g_apcf_d[l_ac].apcf101 = "0"
      LET g_apcf_d[l_ac].apcf103 = "0"
      LET g_apcf_d[l_ac].apcf104 = "0"
      LET g_apcf_d[l_ac].apcf105 = "0"
      LET g_apcf_d[l_ac].apcf113 = "0"
      LET g_apcf_d[l_ac].apcf114 = "0"
      LET g_apcf_d[l_ac].apcf115 = "0"
      LET g_apcf_d[l_ac].apcf111 = "0"
      LET g_apcf_d[l_ac].apcf123 = "0"
      LET g_apcf_d[l_ac].apcf124 = "0"
      LET g_apcf_d[l_ac].apcf125 = "0"
      LET g_apcf_d[l_ac].apcf126 = "0"
      LET g_apcf_d[l_ac].apcf127 = "0"
      LET g_apcf_d[l_ac].apcf133 = "0"
      LET g_apcf_d[l_ac].apcf134 = "0"
      LET g_apcf_d[l_ac].apcf135 = "0"
      LET g_apcf_d[l_ac].apcf136 = "0"
      LET g_apcf_d[l_ac].apcf137 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_apcf_d[l_ac].apcfld = g_apcald
            LET g_apcf_d[l_ac].apcfdocno = g_apcadocno
            CASE 
                 WHEN g_apca.apca001 MATCHES '1[37]' 
                      LET g_apcf_d[l_ac].apca001 ='01'
                 WHEN g_apca.apca001 MATCHES '1[9]' 
                      LET g_apcf_d[l_ac].apca001 ='03'
                 WHEN g_apca.apca001 MATCHES '2[2]' 
                      LET g_apcf_d[l_ac].apca001 ='02'
                 WHEN g_apca.apca001 MATCHES '2[9]' 
                      LET g_apcf_d[l_ac].apca001 ='04'
            END CASE
            DISPLAY BY NAME g_apcf_d[l_ac].apca001
            SELECT MAX(apcfseq) + 1 INTO g_apcf_d[l_ac].apcfseq
              FROM apcf_t
             WHERE apcfent = g_enterprise
               AND apcfld  = g_apcald AND apcfdocno = g_apcadocno
            IF cl_null(g_apcf_d[l_ac].apcfseq)THEN LET g_apcf_d[l_ac].apcfseq = 1 END IF
            DISPLAY BY NAME g_apcf_d[l_ac].apcfseq
           #15/04/23改以apcf021顯示--(S)--
           #CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2011') RETURNING l_sfin2011
           #IF l_sfin2011 = 'N' THEN #不迴轉
           #   CALL s_fin_get_account(g_apcald,'13',g_apca.apca007,'8504_22') RETURNING g_sub_success,g_apcf_d[l_ac].apcf025,g_errno
           #ELSE
           #   CALL s_fin_get_account(g_apcald,'13',g_apca.apca007,'8504_21') RETURNING g_sub_success,g_apcf_d[l_ac].apcf024,g_errno
           #END IF
           #15/04/23改以apcf021顯示--(E)-- 
            #end add-point
            LET g_apcf_d_t.* = g_apcf_d[l_ac].*     #新輸入資料
            LET g_apcf_d_o.* = g_apcf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apcf_d[li_reproduce_target].* = g_apcf_d[li_reproduce].*
               LET g_apcf2_d[li_reproduce_target].* = g_apcf2_d[li_reproduce].*
 
               LET g_apcf_d[g_apcf_d.getLength()].apcfld = NULL
               LET g_apcf_d[g_apcf_d.getLength()].apcfdocno = NULL
               LET g_apcf_d[g_apcf_d.getLength()].apcfseq = NULL
               LET g_apcf_d[g_apcf_d.getLength()].apcfseq2 = NULL
 
            END IF
            
 
 
            CALL aapt210_01_set_entry_b(l_cmd)
            CALL aapt210_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
 
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
            SELECT COUNT(1) INTO l_count FROM apcf_t 
             WHERE apcfent = g_enterprise AND apcfld = g_apcf_d[l_ac].apcfld
                                       AND apcfdocno = g_apcf_d[l_ac].apcfdocno
                                       AND apcfseq = g_apcf_d[l_ac].apcfseq
                                       AND apcfseq2 = g_apcf_d[l_ac].apcfseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf_d[g_detail_idx].apcfld
               LET gs_keys[2] = g_apcf_d[g_detail_idx].apcfdocno
               LET gs_keys[3] = g_apcf_d[g_detail_idx].apcfseq
               LET gs_keys[4] = g_apcf_d[g_detail_idx].apcfseq2
               CALL aapt210_01_insert_b('apcf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #單身新增後，非雜項產生價差/匯差差異--(S)--暫不提供自動產生價差匯差功能
               #IF g_apcf_tmp.getLength() > 0 THEN
               #   CALL s_aapp831_ins_apcf_diff('1',g_apcald,g_apcadocno,g_apcf_tmp)
               #   CALL aapt210_01_b_fill(g_wc2)
               #END IF
               #單身新增後，非雜項產生價差/匯差差異--(E)
               #end add-point
            ELSE    
               INITIALIZE g_apcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt210_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (apcfld = '", g_apcf_d[l_ac].apcfld, "' "
                                  ," AND apcfdocno = '", g_apcf_d[l_ac].apcfdocno, "' "
                                  ," AND apcfseq = '", g_apcf_d[l_ac].apcfseq, "' "
                                  ," AND apcfseq2 = '", g_apcf_d[l_ac].apcfseq2, "' "
 
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
               
               DELETE FROM apcf_t
                WHERE apcfent = g_enterprise AND 
                      apcfld = g_apcf_d_t.apcfld
                      AND apcfdocno = g_apcf_d_t.apcfdocno
                      AND apcfseq = g_apcf_d_t.apcfseq
                      AND apcfseq2 = g_apcf_d_t.apcfseq2
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt210_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apcf_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt210_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_apcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf_d_t.apcfld
               LET gs_keys[2] = g_apcf_d_t.apcfdocno
               LET gs_keys[3] = g_apcf_d_t.apcfseq
               LET gs_keys[4] = g_apcf_d_t.apcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt210_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapt210_01_delete_b('apcf_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apcf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfdocno
            #add-point:BEFORE FIELD apcfdocno name="input.b.page1.apcfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfdocno
            
            #add-point:AFTER FIELD apcfdocno name="input.a.page1.apcfdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcfdocno
            #add-point:ON CHANGE apcfdocno name="input.g.page1.apcfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfld
            #add-point:BEFORE FIELD apcfld name="input.b.page1.apcfld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfld
            
            #add-point:AFTER FIELD apcfld name="input.a.page1.apcfld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcfld
            #add-point:ON CHANGE apcfld name="input.g.page1.apcfld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfseq
            #add-point:BEFORE FIELD apcfseq name="input.b.page1.apcfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfseq
            
            #add-point:AFTER FIELD apcfseq name="input.a.page1.apcfseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcfseq
            #add-point:ON CHANGE apcfseq name="input.g.page1.apcfseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcfseq2
            #add-point:BEFORE FIELD apcfseq2 name="input.b.page1.apcfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcfseq2
            
            #add-point:AFTER FIELD apcfseq2 name="input.a.page1.apcfseq2"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcfseq2
            #add-point:ON CHANGE apcfseq2 name="input.g.page1.apcfseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="input.b.page1.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="input.a.page1.apca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca001
            #add-point:ON CHANGE apca001 name="input.g.page1.apca001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf008
            
            #add-point:AFTER FIELD apcf008 name="input.a.page1.apcf008"
            #來源單據
            IF NOT cl_null(g_apcf_d[l_ac].apcf008) THEN
               IF g_apcf_d[l_ac].apcf008 != g_apcf_d_t.apcf008 OR g_apcf_d_t.apcf008 IS NULL THEN
                  CALL aapt210_01_chk_docno() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_apcf_d[l_ac].apcf008 = g_apcf_d_t.apcf008
                     LET g_apcf_d[l_ac].apcf009 = g_apcf_d_t.apcf009
                     LET g_apcf_d[l_ac].apcf010 = g_apcf_d_t.apcf010
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt210_01_set_apcf008_detail()
                  LET g_apcf_d_t.apcf008 = g_apcf_d[l_ac].apcf008
                  LET g_apcf_d_t.apcf009 = g_apcf_d[l_ac].apcf009
                  LET g_apcf_d_t.apcf010 = g_apcf_d[l_ac].apcf010
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf008
            #add-point:BEFORE FIELD apcf008 name="input.b.page1.apcf008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf008
            #add-point:ON CHANGE apcf008 name="input.g.page1.apcf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf009
            #add-point:BEFORE FIELD apcf009 name="input.b.page1.apcf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf009
            
            #add-point:AFTER FIELD apcf009 name="input.a.page1.apcf009"
            IF NOT cl_null(g_apcf_d[l_ac].apcf009) THEN
               IF g_apcf_d[l_ac].apcf009 != g_apcf_d_t.apcf009 OR g_apcf_d_t.apcf009 IS NULL THEN
                  CALL aapt210_01_chk_docno() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_apcf_d[l_ac].apcf008 = g_apcf_d_t.apcf008
                     LET g_apcf_d[l_ac].apcf009 = g_apcf_d_t.apcf009
                     LET g_apcf_d[l_ac].apcf010 = g_apcf_d_t.apcf010
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt210_01_set_apcf008_detail()
                  LET g_apcf_d_t.apcf008 = g_apcf_d[l_ac].apcf008
                  LET g_apcf_d_t.apcf009 = g_apcf_d[l_ac].apcf009
                  LET g_apcf_d_t.apcf010 = g_apcf_d[l_ac].apcf010
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf009
            #add-point:ON CHANGE apcf009 name="input.g.page1.apcf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf010
            #add-point:BEFORE FIELD apcf010 name="input.b.page1.apcf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf010
            
            #add-point:AFTER FIELD apcf010 name="input.a.page1.apcf010"
            IF NOT cl_null(g_apcf_d[l_ac].apcf010) THEN
               IF g_apcf_d[l_ac].apcf010 != g_apcf_d_t.apcf010 OR g_apcf_d_t.apcf010 IS NULL THEN
                  CALL aapt210_01_chk_docno() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_apcf_d[l_ac].apcf008 = g_apcf_d_t.apcf008
                     LET g_apcf_d[l_ac].apcf009 = g_apcf_d_t.apcf009
                     LET g_apcf_d[l_ac].apcf010 = g_apcf_d_t.apcf010
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt210_01_set_apcf008_detail()
                  LET g_apcf_d_t.apcf008 = g_apcf_d[l_ac].apcf008
                  LET g_apcf_d_t.apcf009 = g_apcf_d[l_ac].apcf009
                  LET g_apcf_d_t.apcf010 = g_apcf_d[l_ac].apcf010
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf010
            #add-point:ON CHANGE apcf010 name="input.g.page1.apcf010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf021
            
            #add-point:AFTER FIELD apcf021 name="input.a.page1.apcf021"
      #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcf021,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apcf_d[l_ac].apcfld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apcf_d[l_ac].apcf021
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apcf_d[l_ac].apcf021
                LET g_qryparam.arg3 = g_apcf_d[l_ac].apcfld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_apcf_d[l_ac].apcf021 = g_qryparam.return1
                 CALL s_desc_get_account_desc(g_apcald,g_apcf_d[l_ac].apcf021) RETURNING g_apcf_d[l_ac].l_apcf021_desc
                 DISPLAY BY NAME g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].l_apcf021_desc
              END IF
               IF NOT  s_aglt310_lc_subject(g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcf021,'N') THEN
                     LET g_apcf_d[l_ac].apcf021 = g_apcf_d_t.apcf021
                     NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf021
            #add-point:BEFORE FIELD apcf021 name="input.b.page1.apcf021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf021
            #add-point:ON CHANGE apcf021 name="input.g.page1.apcf021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcf021_desc
            #add-point:BEFORE FIELD l_apcf021_desc name="input.b.page1.l_apcf021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcf021_desc
            
            #add-point:AFTER FIELD l_apcf021_desc name="input.a.page1.l_apcf021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcf021_desc
            #add-point:ON CHANGE l_apcf021_desc name="input.g.page1.l_apcf021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf007
            #add-point:BEFORE FIELD apcf007 name="input.b.page1.apcf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf007
            
            #add-point:AFTER FIELD apcf007 name="input.a.page1.apcf007"
            #數量
            IF NOT cl_null(g_apcf_d[l_ac].apcf007) THEN
               IF g_apcf_d[l_ac].apcf007 != g_apcf_d_t.apcf007 OR g_apcf_d_t.apcf007 IS NULL THEN
                  SELECT b1.apcb001,b1.apcb007 INTO l_apcb001,l_apcb007
                    FROM apcb_t b1, apcb_t b2
                   WHERE b1.apcbent = g_enterprise AND b1.apcbld = g_apcald
                     AND b1.apcb023 = 'Y'
                     AND b1.apcbdocno= g_apcadocno
                     AND b2.apcbdocno=g_apcf_d[l_ac].apcf008
                     AND b2.apcbseq = g_apcf_d[l_ac].apcf009
                     AND b1.apcbent = b2.apcbent AND b1.apcbld = b2.apcbld
                     AND b1.apcb002 = b2.apcb002 AND b1.apcb003= b2.apcb003
                     
                     
                  LET g_errno = ''
                  CASE l_apcb001
                       WHEN '16'
                       
                       WHEN '26'
                       
                       OTHERWISE
                           #檢核數量
                           SELECT apcb007 INTO l_apcf007
                             FROM apcb_t
                            WHERE apcbent = g_enterprise AND apcbld = g_apcald
                              AND apcbdocno=g_apcf_d[l_ac].apcf008 AND apcbseq = g_apcf_d[l_ac].apcf009
                           IF l_apcb007 > l_apcf007 THEN     #沖銷數量(此次立帳大於暫估數量)
                              IF g_apcf_d[l_ac].apcf007 > l_apcf007 THEN  #依立暫估數量 
                                 LET g_errno = 'aap-00212'
                              END IF
                           ELSE
                              IF g_apcf_d[l_ac].apcf007 > l_apcb007 THEN   #依立帳數量
                                 LET g_errno = 'aap-00212'
                              END IF
                           END IF
                  END CASE
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apcf_d[l_ac].apcf007 = g_apcf_d_t.apcf007
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_apcf_d[l_ac].apcf020) THEN
                     SELECT apca100 INTO l_apca100
                       FROM apca_t
                      WHERE apcaent = g_enterprise AND apcald = g_apcald
                        AND apcadocno = g_apcf_d[l_ac].apcf008
                     LET l_apcf103 = g_apcf_d[l_ac].apcf007 * g_apcf_d[l_ac].apcf101
                     CALL s_tax_count(g_glaa.glaacomp,g_apcf_d[l_ac].apcf020,l_apcf103,g_apcf_d[l_ac].apcf007,l_apca100,g_apcf_d[l_ac].apcf102)
                          RETURNING g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105,
                                    g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf007
            #add-point:ON CHANGE apcf007 name="input.g.page1.apcf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf101
            #add-point:BEFORE FIELD apcf101 name="input.b.page1.apcf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf101
            
            #add-point:AFTER FIELD apcf101 name="input.a.page1.apcf101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf101
            #add-point:ON CHANGE apcf101 name="input.g.page1.apcf101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf103
            #add-point:BEFORE FIELD apcf103 name="input.b.page1.apcf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf103
            
            #add-point:AFTER FIELD apcf103 name="input.a.page1.apcf103"
            #原幣未稅金額
            IF NOT cl_null(g_apcf_d[l_ac].apcf103)THEN
               IF g_apcf_d[l_ac].apcf008 <> 'DIFF' THEN        #20150923
                  CALL aapt210_01_chk_amt()
               END IF                                          #20150923
               IF cl_null(g_apcf_d_t.apcf103) OR (g_apcf_d[l_ac].apcf103 <> g_apcf_d_t.apcf103) THEN
                  LET g_apcf_d[l_ac].apcf105 = g_apcf_d[l_ac].apcf103 + g_apcf_d[l_ac].apcf104
                  LET g_apcf_d[l_ac].apcf113 = g_apcf_d[l_ac].apcf103 * g_apcf_d[l_ac].apcf102
                  LET g_apcf_d[l_ac].apcf114 = g_apcf_d[l_ac].apcf104 * g_apcf_d[l_ac].apcf102
                  LET g_apcf_d[l_ac].apcf115 = g_apcf_d[l_ac].apcf105 * g_apcf_d[l_ac].apcf102
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf103
            #add-point:ON CHANGE apcf103 name="input.g.page1.apcf103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf104
            #add-point:BEFORE FIELD apcf104 name="input.b.page1.apcf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf104
            
            #add-point:AFTER FIELD apcf104 name="input.a.page1.apcf104"
            #原幣稅額
            IF NOT cl_null(g_apcf_d[l_ac].apcf104)THEN
               IF cl_null(g_apcf_d_t.apcf104) OR (g_apcf_d[l_ac].apcf104 <> g_apcf_d_t.apcf104) THEN
                  CALL s_tax_chk(g_glaa.glaacomp,g_apcf_d[l_ac].apcf020) RETURNING g_sub_success,l_desc,l_oodb005,l_desc,l_desc
                  IF l_oodb005 = 'Y' THEN
                     LET g_apcf_d[l_ac].apcf103 = g_apcf_d[l_ac].apcf105 - g_apcf_d[l_ac].apcf104  
                  ELSE
                     LET g_apcf_d[l_ac].apcf105 = g_apcf_d[l_ac].apcf103 + g_apcf_d[l_ac].apcf104  
                  END IF
                  LET g_apcf_d[l_ac].apcf113 = g_apcf_d[l_ac].apcf103 * g_apcf_d[l_ac].apcf102
                  LET g_apcf_d[l_ac].apcf114 = g_apcf_d[l_ac].apcf104 * g_apcf_d[l_ac].apcf102
                  LET g_apcf_d[l_ac].apcf115 = g_apcf_d[l_ac].apcf105 * g_apcf_d[l_ac].apcf102
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf104
            #add-point:ON CHANGE apcf104 name="input.g.page1.apcf104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf105
            #add-point:BEFORE FIELD apcf105 name="input.b.page1.apcf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf105
            
            #add-point:AFTER FIELD apcf105 name="input.a.page1.apcf105"
            #原幣含稅金額
            IF NOT cl_null(g_apcf_d[l_ac].apcf105)THEN
               IF g_apcf_d[l_ac].apcf008 <> 'DIFF' THEN
                  CALL aapt210_01_chk_amt()
               END IF
               IF cl_null(g_apcf_d_t.apcf105) OR (g_apcf_d[l_ac].apcf105 <> g_apcf_d_t.apcf105) THEN
                  LET g_apcf_d[l_ac].apcf103 = g_apcf_d[l_ac].apcf105 - g_apcf_d[l_ac].apcf104
               END IF
               LET g_apcf_d[l_ac].apcf113 = g_apcf_d[l_ac].apcf103 * g_apcf_d[l_ac].apcf102
               LET g_apcf_d[l_ac].apcf114 = g_apcf_d[l_ac].apcf104 * g_apcf_d[l_ac].apcf102
               LET g_apcf_d[l_ac].apcf115 = g_apcf_d[l_ac].apcf105 * g_apcf_d[l_ac].apcf102
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf105
            #add-point:ON CHANGE apcf105 name="input.g.page1.apcf105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf102
            #add-point:BEFORE FIELD apcf102 name="input.b.page1.apcf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf102
            
            #add-point:AFTER FIELD apcf102 name="input.a.page1.apcf102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf102
            #add-point:ON CHANGE apcf102 name="input.g.page1.apcf102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf113
            #add-point:BEFORE FIELD apcf113 name="input.b.page1.apcf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf113
            
            #add-point:AFTER FIELD apcf113 name="input.a.page1.apcf113"
            #本幣未稅金額
            IF NOT cl_null(g_apcf_d[l_ac].apcf113)THEN
               IF g_apcf_d[l_ac].apcf008 <> 'DIFF' THEN
                  CALL aapt210_01_chk_amt()
               END IF
               IF cl_null(g_apcf_d_t.apcf113) OR (g_apcf_d[l_ac].apcf113 <> g_apcf_d_t.apcf113) THEN
                  LET g_apcf_d[l_ac].apcf115 = g_apcf_d[l_ac].apcf113 + g_apcf_d[l_ac].apcf114
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf113
            #add-point:ON CHANGE apcf113 name="input.g.page1.apcf113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf114
            #add-point:BEFORE FIELD apcf114 name="input.b.page1.apcf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf114
            
            #add-point:AFTER FIELD apcf114 name="input.a.page1.apcf114"
            #本幣稅額
            IF NOT cl_null(g_apcf_d[l_ac].apcf114)THEN
               IF cl_null(g_apcf_d_t.apcf114) OR (g_apcf_d[l_ac].apcf114 <> g_apcf_d_t.apcf114) THEN
                  CALL s_tax_chk(g_glaa.glaacomp,g_apcf_d[l_ac].apcf020) RETURNING g_sub_success,l_desc,l_oodb005,l_desc,l_desc
                  IF l_oodb005 = 'Y' THEN
                     LET g_apcf_d[l_ac].apcf103 = g_apcf_d[l_ac].apcf105 - g_apcf_d[l_ac].apcf104  
                  ELSE
                     LET g_apcf_d[l_ac].apcf105 = g_apcf_d[l_ac].apcf103 + g_apcf_d[l_ac].apcf104  
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf114
            #add-point:ON CHANGE apcf114 name="input.g.page1.apcf114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf115
            #add-point:BEFORE FIELD apcf115 name="input.b.page1.apcf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf115
            
            #add-point:AFTER FIELD apcf115 name="input.a.page1.apcf115"
            #本幣含稅金額
            IF NOT cl_null(g_apcf_d[l_ac].apcf115)THEN
               IF g_apcf_d[l_ac].apcf008 <> 'DIFF' THEN
                  CALL aapt210_01_chk_amt()
               END IF
               IF cl_null(g_apcf_d_t.apcf115) OR (g_apcf_d[l_ac].apcf115 <> g_apcf_d_t.apcf115) THEN
                  LET g_apcf_d[l_ac].apcf113 = g_apcf_d[l_ac].apcf113 - g_apcf_d[l_ac].apcf114
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf115
            #add-point:ON CHANGE apcf115 name="input.g.page1.apcf115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf020
            #add-point:BEFORE FIELD apcf020 name="input.b.page1.apcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf020
            
            #add-point:AFTER FIELD apcf020 name="input.a.page1.apcf020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf020
            #add-point:ON CHANGE apcf020 name="input.g.page1.apcf020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf022
            #add-point:BEFORE FIELD apcf022 name="input.b.page1.apcf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf022
            
            #add-point:AFTER FIELD apcf022 name="input.a.page1.apcf022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf022
            #add-point:ON CHANGE apcf022 name="input.g.page1.apcf022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf023
            #add-point:BEFORE FIELD apcf023 name="input.b.page1.apcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf023
            
            #add-point:AFTER FIELD apcf023 name="input.a.page1.apcf023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf023
            #add-point:ON CHANGE apcf023 name="input.g.page1.apcf023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf111
            #add-point:BEFORE FIELD apcf111 name="input.b.page1.apcf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf111
            
            #add-point:AFTER FIELD apcf111 name="input.a.page1.apcf111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf111
            #add-point:ON CHANGE apcf111 name="input.g.page1.apcf111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf122
            #add-point:BEFORE FIELD apcf122 name="input.b.page1.apcf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf122
            
            #add-point:AFTER FIELD apcf122 name="input.a.page1.apcf122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf122
            #add-point:ON CHANGE apcf122 name="input.g.page1.apcf122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf123
            #add-point:BEFORE FIELD apcf123 name="input.b.page1.apcf123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf123
            
            #add-point:AFTER FIELD apcf123 name="input.a.page1.apcf123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf123
            #add-point:ON CHANGE apcf123 name="input.g.page1.apcf123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf124
            #add-point:BEFORE FIELD apcf124 name="input.b.page1.apcf124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf124
            
            #add-point:AFTER FIELD apcf124 name="input.a.page1.apcf124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf124
            #add-point:ON CHANGE apcf124 name="input.g.page1.apcf124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf125
            #add-point:BEFORE FIELD apcf125 name="input.b.page1.apcf125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf125
            
            #add-point:AFTER FIELD apcf125 name="input.a.page1.apcf125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf125
            #add-point:ON CHANGE apcf125 name="input.g.page1.apcf125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf126
            #add-point:BEFORE FIELD apcf126 name="input.b.page1.apcf126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf126
            
            #add-point:AFTER FIELD apcf126 name="input.a.page1.apcf126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf126
            #add-point:ON CHANGE apcf126 name="input.g.page1.apcf126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf127
            #add-point:BEFORE FIELD apcf127 name="input.b.page1.apcf127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf127
            
            #add-point:AFTER FIELD apcf127 name="input.a.page1.apcf127"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf127
            #add-point:ON CHANGE apcf127 name="input.g.page1.apcf127"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf132
            #add-point:BEFORE FIELD apcf132 name="input.b.page1.apcf132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf132
            
            #add-point:AFTER FIELD apcf132 name="input.a.page1.apcf132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf132
            #add-point:ON CHANGE apcf132 name="input.g.page1.apcf132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf133
            #add-point:BEFORE FIELD apcf133 name="input.b.page1.apcf133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf133
            
            #add-point:AFTER FIELD apcf133 name="input.a.page1.apcf133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf133
            #add-point:ON CHANGE apcf133 name="input.g.page1.apcf133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf134
            #add-point:BEFORE FIELD apcf134 name="input.b.page1.apcf134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf134
            
            #add-point:AFTER FIELD apcf134 name="input.a.page1.apcf134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf134
            #add-point:ON CHANGE apcf134 name="input.g.page1.apcf134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf135
            #add-point:BEFORE FIELD apcf135 name="input.b.page1.apcf135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf135
            
            #add-point:AFTER FIELD apcf135 name="input.a.page1.apcf135"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf135
            #add-point:ON CHANGE apcf135 name="input.g.page1.apcf135"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf136
            #add-point:BEFORE FIELD apcf136 name="input.b.page1.apcf136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf136
            
            #add-point:AFTER FIELD apcf136 name="input.a.page1.apcf136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf136
            #add-point:ON CHANGE apcf136 name="input.g.page1.apcf136"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf137
            #add-point:BEFORE FIELD apcf137 name="input.b.page1.apcf137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf137
            
            #add-point:AFTER FIELD apcf137 name="input.a.page1.apcf137"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf137
            #add-point:ON CHANGE apcf137 name="input.g.page1.apcf137"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf001
            #add-point:BEFORE FIELD apcf001 name="input.b.page1.apcf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf001
            
            #add-point:AFTER FIELD apcf001 name="input.a.page1.apcf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf001
            #add-point:ON CHANGE apcf001 name="input.g.page1.apcf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf002
            #add-point:BEFORE FIELD apcf002 name="input.b.page1.apcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf002
            
            #add-point:AFTER FIELD apcf002 name="input.a.page1.apcf002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf002
            #add-point:ON CHANGE apcf002 name="input.g.page1.apcf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf024
            #add-point:BEFORE FIELD apcf024 name="input.b.page1.apcf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf024
            
            #add-point:AFTER FIELD apcf024 name="input.a.page1.apcf024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf024
            #add-point:ON CHANGE apcf024 name="input.g.page1.apcf024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf025
            #add-point:BEFORE FIELD apcf025 name="input.b.page1.apcf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf025
            
            #add-point:AFTER FIELD apcf025 name="input.a.page1.apcf025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf025
            #add-point:ON CHANGE apcf025 name="input.g.page1.apcf025"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apcfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfdocno
            #add-point:ON ACTION controlp INFIELD apcfdocno name="input.c.page1.apcfdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcfld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfld
            #add-point:ON ACTION controlp INFIELD apcfld name="input.c.page1.apcfld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfseq
            #add-point:ON ACTION controlp INFIELD apcfseq name="input.c.page1.apcfseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcfseq2
            #add-point:ON ACTION controlp INFIELD apcfseq2 name="input.c.page1.apcfseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="input.c.page1.apca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf008
            #add-point:ON ACTION controlp INFIELD apcf008 name="input.c.page1.apcf008"
            #來源單據號碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf_d[l_ac].apcf008
            
            IF g_apcf_d[l_ac].apca001 MATCHES '0[34]' THEN
               LET g_qryparam.where =  " apca001 = '",g_apcf_d[l_ac].apca001 ,"'",
                                      #" AND NOT EXISTS (SELECT * FROM apcf_t WHERE apcfdocno = '",g_apcadocno,"' AND apcf008 = apcadocno )" #160905-00002#1 mark
                                       " AND NOT EXISTS (SELECT * FROM apcf_t WHERE apcfent = ",g_enterprise,            #160905-00002#1     
                                       "                    AND apcfdocno = '",g_apcadocno,"' AND apcf008 = apcadocno )" #160905-00002#1
               LET g_qryparam.arg1 = g_apcald
               LET g_qryparam.arg2 = g_apca.apca004
               CALL q_apcadocno_8()
            ELSE
               LET g_qryparam.where = " apca001 IN ('01','02')",
                                     #" AND NOT EXISTS (SELECT * FROM apcf_t WHERE apcfdocno = '",g_apcadocno,"' AND apcf008 = apcadocno )" #160905-00002#1 mark
                                     " AND NOT EXISTS (SELECT * FROM apcf_t WHERE apcfent = ",g_enterprise,            #160905-00002#1     
                                      "                    AND apcfdocno = '",g_apcadocno,"' AND apcf008 = apcadocno )" #160905-00002#1
               LET g_qryparam.arg1 = g_apcald
               LET g_qryparam.arg2 = g_apcadocno 
               CALL q_apcadocno_5()
            END IF
            LET g_apcf_d[l_ac].apcf008 = g_qryparam.return1
            LET g_apcf_d[l_ac].apcf009 = g_qryparam.return2
            LET g_apcf_d[l_ac].apcf010 = g_qryparam.return3
            NEXT FIELD apcf008
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf009
            #add-point:ON ACTION controlp INFIELD apcf009 name="input.c.page1.apcf009"
            #來源單據號碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf_d[l_ac].apcf008
            LET g_qryparam.where = " apca001 IN ('01','02')"
            LET g_qryparam.arg1 = g_apcald
            LET g_qryparam.arg2 = g_apcadocno 
            CALL q_apcadocno_5()
            LET g_apcf_d[l_ac].apcf008 = g_qryparam.return1
            LET g_apcf_d[l_ac].apcf009 = g_qryparam.return2
            NEXT FIELD apcf009
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf010
            #add-point:ON ACTION controlp INFIELD apcf010 name="input.c.page1.apcf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf021
            #add-point:ON ACTION controlp INFIELD apcf021 name="input.c.page1.apcf021"
            #暫估會計科目
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf_d[l_ac].apcf021
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_apcf_d[l_ac].apcfld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                          
            LET g_apcf_d[l_ac].apcf021 = g_qryparam.return1     
            CALL s_desc_get_account_desc(g_apcald,g_apcf_d[l_ac].apcf021) RETURNING g_apcf_d[l_ac].l_apcf021_desc
            DISPLAY BY NAME g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].l_apcf021_desc
            NEXT FIELD apcf021  
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_apcf021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcf021_desc
            #add-point:ON ACTION controlp INFIELD l_apcf021_desc name="input.c.page1.l_apcf021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf007
            #add-point:ON ACTION controlp INFIELD apcf007 name="input.c.page1.apcf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf101
            #add-point:ON ACTION controlp INFIELD apcf101 name="input.c.page1.apcf101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf103
            #add-point:ON ACTION controlp INFIELD apcf103 name="input.c.page1.apcf103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf104
            #add-point:ON ACTION controlp INFIELD apcf104 name="input.c.page1.apcf104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf105
            #add-point:ON ACTION controlp INFIELD apcf105 name="input.c.page1.apcf105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf102
            #add-point:ON ACTION controlp INFIELD apcf102 name="input.c.page1.apcf102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf113
            #add-point:ON ACTION controlp INFIELD apcf113 name="input.c.page1.apcf113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf114
            #add-point:ON ACTION controlp INFIELD apcf114 name="input.c.page1.apcf114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf115
            #add-point:ON ACTION controlp INFIELD apcf115 name="input.c.page1.apcf115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf020
            #add-point:ON ACTION controlp INFIELD apcf020 name="input.c.page1.apcf020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf022
            #add-point:ON ACTION controlp INFIELD apcf022 name="input.c.page1.apcf022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf023
            #add-point:ON ACTION controlp INFIELD apcf023 name="input.c.page1.apcf023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf111
            #add-point:ON ACTION controlp INFIELD apcf111 name="input.c.page1.apcf111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf122
            #add-point:ON ACTION controlp INFIELD apcf122 name="input.c.page1.apcf122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf123
            #add-point:ON ACTION controlp INFIELD apcf123 name="input.c.page1.apcf123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf124
            #add-point:ON ACTION controlp INFIELD apcf124 name="input.c.page1.apcf124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf125
            #add-point:ON ACTION controlp INFIELD apcf125 name="input.c.page1.apcf125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf126
            #add-point:ON ACTION controlp INFIELD apcf126 name="input.c.page1.apcf126"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf127
            #add-point:ON ACTION controlp INFIELD apcf127 name="input.c.page1.apcf127"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf132
            #add-point:ON ACTION controlp INFIELD apcf132 name="input.c.page1.apcf132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf133
            #add-point:ON ACTION controlp INFIELD apcf133 name="input.c.page1.apcf133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf134
            #add-point:ON ACTION controlp INFIELD apcf134 name="input.c.page1.apcf134"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf135
            #add-point:ON ACTION controlp INFIELD apcf135 name="input.c.page1.apcf135"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf136
            #add-point:ON ACTION controlp INFIELD apcf136 name="input.c.page1.apcf136"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf137
            #add-point:ON ACTION controlp INFIELD apcf137 name="input.c.page1.apcf137"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf001
            #add-point:ON ACTION controlp INFIELD apcf001 name="input.c.page1.apcf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf002
            #add-point:ON ACTION controlp INFIELD apcf002 name="input.c.page1.apcf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf024
            #add-point:ON ACTION controlp INFIELD apcf024 name="input.c.page1.apcf024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf025
            #add-point:ON ACTION controlp INFIELD apcf025 name="input.c.page1.apcf025"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapt210_01_bcl
               LET INT_FLAG = 0
               LET g_apcf_d[l_ac].* = g_apcf_d_t.*
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
               LET g_errparam.extend = g_apcf_d[l_ac].apcfld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apcf_d[l_ac].* = g_apcf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt210_01_apcf_t_mask_restore('restore_mask_o')
 
               UPDATE apcf_t SET (apcfdocno,apcfld,apcfseq,apcfseq2,apcf008,apcf009,apcf010,apcf021, 
                   apcf007,apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022, 
                   apcf023,apcf111,apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134, 
                   apcf135,apcf136,apcf137,apcf001,apcf002,apcf024,apcf025,apcf049,apcforga,apcf026, 
                   apcf027,apcf028,apcf029,apcf030,apcf031,apcf032,apcf033,apcf034,apcf035,apcf036,apcf037, 
                   apcf038,apcf039,apcf040,apcf041,apcf042,apcf043,apcf044,apcf045,apcf046,apcf047,apcf048) = (g_apcf_d[l_ac].apcfdocno, 
                   g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcfseq,g_apcf_d[l_ac].apcfseq2,g_apcf_d[l_ac].apcf008, 
                   g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010,g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].apcf007, 
                   g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105, 
                   g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115, 
                   g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022,g_apcf_d[l_ac].apcf023,g_apcf_d[l_ac].apcf111, 
                   g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123,g_apcf_d[l_ac].apcf124,g_apcf_d[l_ac].apcf125, 
                   g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127,g_apcf_d[l_ac].apcf132,g_apcf_d[l_ac].apcf133, 
                   g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135,g_apcf_d[l_ac].apcf136,g_apcf_d[l_ac].apcf137, 
                   g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002,g_apcf_d[l_ac].apcf024,g_apcf_d[l_ac].apcf025, 
                   g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf027, 
                   g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf031, 
                   g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035, 
                   g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf039, 
                   g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf043, 
                   g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf047, 
                   g_apcf2_d[l_ac].apcf048)
                WHERE apcfent = g_enterprise AND
                  apcfld = g_apcf_d_t.apcfld #項次   
                  AND apcfdocno = g_apcf_d_t.apcfdocno  
                  AND apcfseq = g_apcf_d_t.apcfseq  
                  AND apcfseq2 = g_apcf_d_t.apcfseq2  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf_d[g_detail_idx].apcfld
               LET gs_keys_bak[1] = g_apcf_d_t.apcfld
               LET gs_keys[2] = g_apcf_d[g_detail_idx].apcfdocno
               LET gs_keys_bak[2] = g_apcf_d_t.apcfdocno
               LET gs_keys[3] = g_apcf_d[g_detail_idx].apcfseq
               LET gs_keys_bak[3] = g_apcf_d_t.apcfseq
               LET gs_keys[4] = g_apcf_d[g_detail_idx].apcfseq2
               LET gs_keys_bak[4] = g_apcf_d_t.apcfseq2
               CALL aapt210_01_update_b('apcf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apcf_d_t)
                     LET g_log2 = util.JSON.stringify(g_apcf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt210_01_apcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapt210_01_unlock_b("apcf_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apcf_d[l_ac].* = g_apcf_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            IF NOT INT_FLAG THEN
               SELECT count(*) INTO l_cnt
                 FROM apcf_t
                WHERE apcfent = g_enterprise
                  AND apcfld  = g_apcald AND apcfdocno = g_apcadocno
                  AND apcf008 <> 'DIFF'
               IF l_cnt > 0 THEN
                  SELECT count(*) INTO l_cnt
                    FROM apcf_t
                   WHERE apcfent = g_enterprise
                     AND apcfld  = g_apcald AND apcfdocno = g_apcadocno
                     AND apcf008 = 'DIFF'
                  IF l_cnt = 0 THEN
                     IF cl_ask_confirm('aap-00211') THEN
                        CALL s_aapp831_ins_apcf_diff('2',g_apcald,g_apcadocno,'')
                        CALL aapt210_01_b_fill(g_wc2)
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               
               IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
                  CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
                       RETURNING g_sub_success
               END IF
               CALL aapt210_01_b_fill('')
               CONTINUE DIALOG
            END IF
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apcf_d[li_reproduce_target].* = g_apcf_d[li_reproduce].*
               LET g_apcf2_d[li_reproduce_target].* = g_apcf2_d[li_reproduce].*
 
               LET g_apcf_d[li_reproduce_target].apcfld = NULL
               LET g_apcf_d[li_reproduce_target].apcfdocno = NULL
               LET g_apcf_d[li_reproduce_target].apcfseq = NULL
               LET g_apcf_d[li_reproduce_target].apcfseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apcf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apcf_d.getLength()+1
            END IF
            
      END INPUT
      
      INPUT ARRAY g_apcf2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL aapt210_01_b_fill(g_wc2)
            LET g_detail_cnt = g_apcf2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD apcfld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apcf2_d[l_ac].* TO NULL 
            INITIALIZE g_apcf2_d_t.* TO NULL
            INITIALIZE g_apcf2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.before_bak"
            
            #end add-point
            LET g_apcf2_d_t.* = g_apcf2_d[l_ac].*     #新輸入資料
            LET g_apcf2_d_o.* = g_apcf2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apcf_d[li_reproduce_target].* = g_apcf_d[li_reproduce].*
               LET g_apcf2_d[li_reproduce_target].* = g_apcf2_d[li_reproduce].*
 
               LET g_apcf2_d[li_reproduce_target].apcfld = NULL
               LET g_apcf2_d[li_reproduce_target].apcfdocno = NULL
               LET g_apcf2_d[li_reproduce_target].apcfseq = NULL
               LET g_apcf2_d[li_reproduce_target].apcfseq2 = NULL
            END IF
            
 
 
            CALL aapt210_01_set_entry_b(l_cmd)
            CALL aapt210_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apcf2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_apcf2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apcf2_d[l_ac].apcfld IS NOT NULL
               AND g_apcf2_d[l_ac].apcfdocno IS NOT NULL
               AND g_apcf2_d[l_ac].apcfseq IS NOT NULL
               AND g_apcf2_d[l_ac].apcfseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apcf2_d_t.* = g_apcf2_d[l_ac].*  #BACKUP
               LET g_apcf2_d_o.* = g_apcf2_d[l_ac].*  #BACKUP
               IF NOT aapt210_01_lock_b("apcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt210_01_bcl INTO g_apcf_d[l_ac].apcfdocno,g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcfseq, 
                      g_apcf_d[l_ac].apcfseq2,g_apcf_d[l_ac].apcf008,g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010, 
                      g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].apcf007,g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103, 
                      g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105,g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113, 
                      g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115,g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022, 
                      g_apcf_d[l_ac].apcf023,g_apcf_d[l_ac].apcf111,g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123, 
                      g_apcf_d[l_ac].apcf124,g_apcf_d[l_ac].apcf125,g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127, 
                      g_apcf_d[l_ac].apcf132,g_apcf_d[l_ac].apcf133,g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135, 
                      g_apcf_d[l_ac].apcf136,g_apcf_d[l_ac].apcf137,g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002, 
                      g_apcf_d[l_ac].apcf024,g_apcf_d[l_ac].apcf025,g_apcf2_d[l_ac].apcfld,g_apcf2_d[l_ac].apcfdocno, 
                      g_apcf2_d[l_ac].apcfseq,g_apcf2_d[l_ac].apcfseq2,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga, 
                      g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029, 
                      g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033, 
                      g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037, 
                      g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041, 
                      g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045, 
                      g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf048
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH aapt210_01_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apcf2_d_mask_o[l_ac].* =  g_apcf2_d[l_ac].*
                  CALL aapt210_01_apcf_t_mask()
                  LET g_apcf2_d_mask_n[l_ac].* =  g_apcf2_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL aapt210_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt210_01_set_entry_b(l_cmd)
            CALL aapt210_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            INITIALIZE g_glad.* TO NULL
            IF NOT cl_null(g_apcf2_d[l_ac].apcf021_desc) THEN
               CALL s_fin_sel_glad(g_apcald,g_apcf2_d[l_ac].apcf021_desc,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*
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
               
               DELETE FROM apcf_t
                WHERE apcfent = g_enterprise AND
                  apcfld = g_apcf2_d_t.apcfld
                  AND apcfdocno = g_apcf2_d_t.apcfdocno
                  AND apcfseq = g_apcf2_d_t.apcfseq
                  AND apcfseq2 = g_apcf2_d_t.apcfseq2
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt210_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apcf2_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt210_01_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"
               
               #end add-point
               LET l_count = g_apcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf2_d_t.apcfld
               LET gs_keys[2] = g_apcf2_d_t.apcfdocno
               LET gs_keys[3] = g_apcf2_d_t.apcfseq
               LET gs_keys[4] = g_apcf2_d_t.apcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt210_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"
               
               #end add-point
                              CALL aapt210_01_delete_b('apcf_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apcf2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apcf_t 
             WHERE apcfent = g_enterprise AND
                   apcfld = g_apcf2_d[l_ac].apcfld
                   AND apcfdocno = g_apcf2_d[l_ac].apcfdocno
                   AND apcfseq = g_apcf2_d[l_ac].apcfseq
                   AND apcfseq2 = g_apcf2_d[l_ac].apcfseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf2_d[g_detail_idx].apcfld
               LET gs_keys[2] = g_apcf2_d[g_detail_idx].apcfdocno
               LET gs_keys[3] = g_apcf2_d[g_detail_idx].apcfseq
               LET gs_keys[4] = g_apcf2_d[g_detail_idx].apcfseq2
               CALL aapt210_01_insert_b('apcf_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt210_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (apcfld = '", g_apcf2_d[l_ac].apcfld, "' "
                                  ," AND apcfdocno = '", g_apcf2_d[l_ac].apcfdocno, "' "
                                  ," AND apcfseq = '", g_apcf2_d[l_ac].apcfseq, "' "
                                  ," AND apcfseq2 = '", g_apcf2_d[l_ac].apcfseq2, "' "
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
               LET g_apcf2_d[l_ac].* = g_apcf2_d_t.*
               CLOSE aapt210_01_bcl
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
               LET g_apcf2_d[l_ac].* = g_apcf2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
 
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt210_01_apcf_t_mask_restore('restore_mask_o')
               
               UPDATE apcf_t SET (apcfdocno,apcfld,apcfseq,apcfseq2,apcf008,apcf009,apcf010,apcf021, 
                   apcf007,apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022, 
                   apcf023,apcf111,apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134, 
                   apcf135,apcf136,apcf137,apcf001,apcf002,apcf024,apcf025,apcf049,apcforga,apcf026, 
                   apcf027,apcf028,apcf029,apcf030,apcf031,apcf032,apcf033,apcf034,apcf035,apcf036,apcf037, 
                   apcf038,apcf039,apcf040,apcf041,apcf042,apcf043,apcf044,apcf045,apcf046,apcf047,apcf048) = (g_apcf_d[l_ac].apcfdocno, 
                   g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcfseq,g_apcf_d[l_ac].apcfseq2,g_apcf_d[l_ac].apcf008, 
                   g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010,g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].apcf007, 
                   g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105, 
                   g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115, 
                   g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022,g_apcf_d[l_ac].apcf023,g_apcf_d[l_ac].apcf111, 
                   g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123,g_apcf_d[l_ac].apcf124,g_apcf_d[l_ac].apcf125, 
                   g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127,g_apcf_d[l_ac].apcf132,g_apcf_d[l_ac].apcf133, 
                   g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135,g_apcf_d[l_ac].apcf136,g_apcf_d[l_ac].apcf137, 
                   g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002,g_apcf_d[l_ac].apcf024,g_apcf_d[l_ac].apcf025, 
                   g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf027, 
                   g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf031, 
                   g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035, 
                   g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf039, 
                   g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf043, 
                   g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf047, 
                   g_apcf2_d[l_ac].apcf048) #自訂欄位頁簽
                WHERE apcfent = g_enterprise AND
                  apcfld = g_apcf2_d_t.apcfld #項次 
                  AND apcfdocno = g_apcf2_d_t.apcfdocno
                  AND apcfseq = g_apcf2_d_t.apcfseq
                  AND apcfseq2 = g_apcf2_d_t.apcfseq2
                  
               #add-point:單身page2修改中 name="input.body2.m_update"

                  
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcf2_d[g_detail_idx].apcfld
               LET gs_keys_bak[1] = g_apcf2_d_t.apcfld
               LET gs_keys[2] = g_apcf2_d[g_detail_idx].apcfdocno
               LET gs_keys_bak[2] = g_apcf2_d_t.apcfdocno
               LET gs_keys[3] = g_apcf2_d[g_detail_idx].apcfseq
               LET gs_keys_bak[3] = g_apcf2_d_t.apcfseq
               LET gs_keys[4] = g_apcf2_d[g_detail_idx].apcfseq2
               LET gs_keys_bak[4] = g_apcf2_d_t.apcfseq2
               CALL aapt210_01_update_b('apcf_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apcf2_d_t)
                     LET g_log2 = util.JSON.stringify(g_apcf2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt210_01_apcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf008_desc
            #add-point:BEFORE FIELD apcf008_desc name="input.b.page2.apcf008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf008_desc
            
            #add-point:AFTER FIELD apcf008_desc name="input.a.page2.apcf008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf008_desc
            #add-point:ON CHANGE apcf008_desc name="input.g.page2.apcf008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf021_desc
            #add-point:BEFORE FIELD apcf021_desc name="input.b.page2.apcf021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf021_desc
            
            #add-point:AFTER FIELD apcf021_desc name="input.a.page2.apcf021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf021_desc
            #add-point:ON CHANGE apcf021_desc name="input.g.page2.apcf021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcforga_desc
            #add-point:BEFORE FIELD apcforga_desc name="input.b.page2.apcforga_desc"
            LET g_apcf2_d[l_ac].apcforga_desc = g_apcf2_d[l_ac].apcforga   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcforga_desc
            
            #add-point:AFTER FIELD apcforga_desc name="input.a.page2.apcforga_desc"
            #來源組織
            IF NOT cl_null(g_apcf2_d[l_ac].apcforga_desc) THEN
               IF ( g_apcf2_d[l_ac].apcforga_desc != g_apcf2_d_t.apcforga_desc OR g_apcf2_d_t.apcforga_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcforga = g_apcf2_d[l_ac].apcforga_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_apcf2_d[l_ac].apcforga
                     #160318-00025#43  2016/04/26  by pengxin  add(S)
                     LET g_errshow = TRUE #是否開窗 
                     LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                     #160318-00025#43  2016/04/26  by pengxin  add(E)
                     IF NOT cl_chk_exist("v_ooef001") THEN
                        LET g_apcf2_d[l_ac].apcforga      = g_apcf2_d_t.apcforga
                        LET g_apcf2_d[l_ac].apcforga_desc = g_apcf2_d_t.apcforga_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcforga ,g_apcf2_d[l_ac].apcforga_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcforga = ''
            END IF
            LET g_apcf2_d[l_ac].apcforga_desc = s_desc_show1(g_apcf2_d[l_ac].apcforga,s_desc_get_department_desc(g_apcf2_d[l_ac].apcforga))         
            LET g_apcf2_d_t.apcforga_desc = g_apcf2_d[l_ac].apcforga_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcforga ,g_apcf2_d[l_ac].apcforga_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcforga_desc
            #add-point:ON CHANGE apcforga_desc name="input.g.page2.apcforga_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf026_desc
            #add-point:BEFORE FIELD apcf026_desc name="input.b.page2.apcf026_desc"
            LET g_apcf2_d[l_ac].apcf026_desc = g_apcf2_d[l_ac].apcf026   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf026_desc
            
            #add-point:AFTER FIELD apcf026_desc name="input.a.page2.apcf026_desc"
            #部門
            IF NOT cl_null(g_apcf2_d[l_ac].apcf026_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf026_desc != g_apcf2_d_t.apcf026_desc OR g_apcf2_d_t.apcf026_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf026 = g_apcf2_d[l_ac].apcf026_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_department_chk(g_apcf2_d[l_ac].apcf026_desc,g_apca.apcadocdt) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        LET g_apcf2_d[l_ac].apcf026      = g_apcf2_d_t.apcf026
                        LET g_apcf2_d[l_ac].apcf026_desc = g_apcf2_d_t.apcf026_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf026 ,g_apcf2_d[l_ac].apcf026_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf026 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf026_desc = s_desc_show1(g_apcf2_d[l_ac].apcf026,s_desc_get_department_desc(g_apcf2_d[l_ac].apcf026))         
            LET g_apcf2_d_t.apcf026_desc = g_apcf2_d[l_ac].apcf026_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf026 ,g_apcf2_d[l_ac].apcf026_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf026_desc
            #add-point:ON CHANGE apcf026_desc name="input.g.page2.apcf026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf027_desc
            #add-point:BEFORE FIELD apcf027_desc name="input.b.page2.apcf027_desc"
            LET g_apcf2_d[l_ac].apcf027_desc = g_apcf2_d[l_ac].apcf027   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf027_desc
            
            #add-point:AFTER FIELD apcf027_desc name="input.a.page2.apcf027_desc"
            #責任中心
            IF NOT cl_null(g_apcf2_d[l_ac].apcf027_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf027_desc != g_apcf2_d_t.apcf027_desc OR g_apcf2_d_t.apcf027_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf027 = g_apcf2_d[l_ac].apcf027_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq019_chk(g_apcf2_d[l_ac].apcf027_desc,g_apca.apcadocdt)
                     IF NOT cl_null(g_errno) THEN
                        LET g_apcf2_d[l_ac].apcf027      = g_apcf2_d_t.apcf027
                        LET g_apcf2_d[l_ac].apcf027_desc = g_apcf2_d_t.apcf027_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf027 ,g_apcf2_d[l_ac].apcf027_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf027 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf027_desc = s_desc_show1(g_apcf2_d[l_ac].apcf027,s_desc_get_department_desc(g_apcf2_d[l_ac].apcf027))         
            LET g_apcf2_d_t.apcf027_desc = g_apcf2_d[l_ac].apcf027_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf027 ,g_apcf2_d[l_ac].apcf027_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf027_desc
            #add-point:ON CHANGE apcf027_desc name="input.g.page2.apcf027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf028_desc
            #add-point:BEFORE FIELD apcf028_desc name="input.b.page2.apcf028_desc"
            LET g_apcf2_d[l_ac].apcf028_desc = g_apcf2_d[l_ac].apcf028   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf028_desc
            
            #add-point:AFTER FIELD apcf028_desc name="input.a.page2.apcf028_desc"
            #區域
            IF NOT cl_null(g_apcf2_d[l_ac].apcf028_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf028_desc != g_apcf2_d_t.apcf028_desc OR g_apcf2_d_t.apcf028_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf028 = g_apcf2_d[l_ac].apcf028_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('287',g_apcf2_d[l_ac].apcf028) THEN
                        LET g_apcf2_d[l_ac].apcf028      = g_apcf2_d_t.apcf028
                        LET g_apcf2_d[l_ac].apcf028_desc = g_apcf2_d_t.apcf028_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf028 ,g_apcf2_d[l_ac].apcf028_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf028 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf028_desc = s_desc_show1(g_apcf2_d[l_ac].apcf028,s_desc_get_acc_desc('287',g_apcf2_d[l_ac].apcf028))      
            LET g_apcf2_d_t.apcf028_desc = g_apcf2_d[l_ac].apcf028_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf028 ,g_apcf2_d[l_ac].apcf028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf028_desc
            #add-point:ON CHANGE apcf028_desc name="input.g.page2.apcf028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf029_desc
            #add-point:BEFORE FIELD apcf029_desc name="input.b.page2.apcf029_desc"
            LET g_apcf2_d[l_ac].apcf029_desc = g_apcf2_d[l_ac].apcf029   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf029_desc
            
            #add-point:AFTER FIELD apcf029_desc name="input.a.page2.apcf029_desc"
            #交易客商
            IF NOT cl_null(g_apcf2_d[l_ac].apcf029_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf029_desc != g_apcf2_d_t.apcf029_desc OR g_apcf2_d_t.apcf029_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf029 = g_apcf2_d[l_ac].apcf029_desc
                  #160920-00019#2---s
                  CALL s_aap_apca004_chk(g_apcf2_d[l_ac].apcf029_desc) RETURNING g_sub_success,g_errno  

                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcf2_d[l_ac].apcf029      = g_apcf2_d_t.apcf029
                     LET g_apcf2_d[l_ac].apcf029_desc = g_apcf2_d_t.apcf029_desc
                     DISPLAY BY NAME g_apcf2_d[l_ac].apcf029 ,g_apcf2_d[l_ac].apcf029_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160920-00019#2---e
                  
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq021_chk(g_apcf2_d[l_ac].apcf029_desc)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'apmm100'
                        LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                        LET g_errparam.exeprog = 'apmm100'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf029      = g_apcf2_d_t.apcf029
                        LET g_apcf2_d[l_ac].apcf029_desc = g_apcf2_d_t.apcf029_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf029 ,g_apcf2_d[l_ac].apcf029_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf029 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf029_desc = s_desc_show1(g_apcf2_d[l_ac].apcf029,s_desc_get_trading_partner_abbr_desc(g_apcf2_d[l_ac].apcf029))         
            LET g_apcf2_d_t.apcf029_desc = g_apcf2_d[l_ac].apcf029_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf029 ,g_apcf2_d[l_ac].apcf029_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf029_desc
            #add-point:ON CHANGE apcf029_desc name="input.g.page2.apcf029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf030_desc
            #add-point:BEFORE FIELD apcf030_desc name="input.b.page2.apcf030_desc"
            LET g_apcf2_d[l_ac].apcf030_desc = g_apcf2_d[l_ac].apcf030   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf030_desc
            
            #add-point:AFTER FIELD apcf030_desc name="input.a.page2.apcf030_desc"
            #帳款客商
            IF NOT cl_null(g_apcf2_d[l_ac].apcf030_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf030_desc != g_apcf2_d_t.apcf030_desc OR g_apcf2_d_t.apcf030_desc IS NULL ) THEN
                  #160920-00019#2---s
                  CALL s_aap_apca004_chk(g_apcf2_d[l_ac].apcf030_desc) RETURNING g_sub_success,g_errno  

                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcf2_d[l_ac].apcf030      = g_apcf2_d_t.apcf030
                     LET g_apcf2_d[l_ac].apcf030_desc = g_apcf2_d_t.apcf030_desc
                     DISPLAY BY NAME g_apcf2_d[l_ac].apcf030 ,g_apcf2_d[l_ac].apcf030_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160920-00019#2---e
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq021_chk(g_apcf2_d[l_ac].apcf030_desc)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'apmm100'
                        LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                        LET g_errparam.exeprog = 'apmm100'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf030      = g_apcf2_d_t.apcf030
                        LET g_apcf2_d[l_ac].apcf030_desc = g_apcf2_d_t.apcf030_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf030 ,g_apcf2_d[l_ac].apcf030_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf030 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf030_desc = s_desc_show1(g_apcf2_d[l_ac].apcf030,s_desc_get_trading_partner_abbr_desc(g_apcf2_d[l_ac].apcf030))         
            LET g_apcf2_d_t.apcf030_desc = g_apcf2_d[l_ac].apcf030_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf030 ,g_apcf2_d[l_ac].apcf030_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf030_desc
            #add-point:ON CHANGE apcf030_desc name="input.g.page2.apcf030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf031_desc
            #add-point:BEFORE FIELD apcf031_desc name="input.b.page2.apcf031_desc"
            LET g_apcf2_d[l_ac].apcf031_desc = g_apcf2_d[l_ac].apcf031   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf031_desc
            
            #add-point:AFTER FIELD apcf031_desc name="input.a.page2.apcf031_desc"
            #客群
            IF NOT cl_null(g_apcf2_d[l_ac].apcf031_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf031_desc != g_apcf2_d_t.apcf031_desc OR g_apcf2_d_t.apcf031_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf031 = g_apcf2_d[l_ac].apcf031_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('281',g_apcf2_d[l_ac].apcf031) THEN
                        LET g_apcf2_d[l_ac].apcf031      = g_apcf2_d_t.apcf031
                        LET g_apcf2_d[l_ac].apcf031_desc = g_apcf2_d_t.apcf031_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf031 ,g_apcf2_d[l_ac].apcf031_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf031 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf031_desc = s_desc_show1(g_apcf2_d[l_ac].apcf031,s_desc_get_acc_desc('281',g_apcf2_d[l_ac].apcf031))      
            LET g_apcf2_d_t.apcf031_desc = g_apcf2_d[l_ac].apcf031_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf031 ,g_apcf2_d[l_ac].apcf031_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf031_desc
            #add-point:ON CHANGE apcf031_desc name="input.g.page2.apcf031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf032_desc
            #add-point:BEFORE FIELD apcf032_desc name="input.b.page2.apcf032_desc"
            LET g_apcf2_d[l_ac].apcf032_desc = g_apcf2_d[l_ac].apcf032   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf032_desc
            
            #add-point:AFTER FIELD apcf032_desc name="input.a.page2.apcf032_desc"
            #產品類別
            IF NOT cl_null(g_apcf2_d[l_ac].apcf032_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf032_desc != g_apcf2_d_t.apcf032_desc OR g_apcf2_d_t.apcf032_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf032 = g_apcf2_d[l_ac].apcf032_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq024_chk(g_apcf2_d[l_ac].apcf032)
                     IF NOT cl_null(g_errno) THEN
                        LET g_apcf2_d[l_ac].apcf032      = g_apcf2_d_t.apcf032
                        LET g_apcf2_d[l_ac].apcf032_desc = g_apcf2_d_t.apcf032_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf032 ,g_apcf2_d[l_ac].apcf032_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf032 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf032_desc = s_desc_show1(g_apcf2_d[l_ac].apcf032,s_desc_get_rtaxl003_desc(g_apcf2_d[l_ac].apcf032))      
            LET g_apcf2_d_t.apcf032_desc = g_apcf2_d[l_ac].apcf032_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf032 ,g_apcf2_d[l_ac].apcf032_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf032_desc
            #add-point:ON CHANGE apcf032_desc name="input.g.page2.apcf032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf033_desc
            #add-point:BEFORE FIELD apcf033_desc name="input.b.page2.apcf033_desc"
            LET g_apcf2_d[l_ac].apcf033_desc = g_apcf2_d[l_ac].apcf033   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf033_desc
            
            #add-point:AFTER FIELD apcf033_desc name="input.a.page2.apcf033_desc"
            #業務人員
            IF NOT cl_null(g_apcf2_d[l_ac].apcf033_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf033_desc != g_apcf2_d_t.apcf033_desc OR g_apcf2_d_t.apcf033_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf033 = g_apcf2_d[l_ac].apcf033_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_employee_chk(g_apcf2_d[l_ac].apcf033_desc) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        LET g_apcf2_d[l_ac].apcf033      = g_apcf2_d_t.apcf033
                        LET g_apcf2_d[l_ac].apcf033_desc = g_apcf2_d_t.apcf033_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf033 ,g_apcf2_d[l_ac].apcf033_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf033 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf033_desc = s_desc_show1(g_apcf2_d[l_ac].apcf033,s_desc_get_person_desc(g_apcf2_d[l_ac].apcf033))         
            LET g_apcf2_d_t.apcf033_desc = g_apcf2_d[l_ac].apcf033_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf033 ,g_apcf2_d[l_ac].apcf033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf033_desc
            #add-point:ON CHANGE apcf033_desc name="input.g.page2.apcf033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf034_desc
            #add-point:BEFORE FIELD apcf034_desc name="input.b.page2.apcf034_desc"
            LET g_apcf2_d[l_ac].apcf034_desc = g_apcf2_d[l_ac].apcf034   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf034_desc
            
            #add-point:AFTER FIELD apcf034_desc name="input.a.page2.apcf034_desc"
            #專案編號
            IF NOT cl_null(g_apcf2_d[l_ac].apcf034_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf034_desc != g_apcf2_d_t.apcf034_desc OR g_apcf2_d_t.apcf034_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf034 = g_apcf2_d[l_ac].apcf034_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_aap_project_chk(g_apcf2_d[l_ac].apcf034_desc) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'apjm200'
                        LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                        LET g_errparam.exeprog = 'apjm200'
                        #160321-00016#20 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf034      = g_apcf2_d_t.apcf034
                        LET g_apcf2_d[l_ac].apcf034_desc = g_apcf2_d_t.apcf034_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf034 ,g_apcf2_d[l_ac].apcf034_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf034 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf034_desc = s_desc_show1(g_apcf2_d[l_ac].apcf034,s_desc_get_project_desc(g_apcf2_d[l_ac].apcf034))         
            LET g_apcf2_d_t.apcf034_desc = g_apcf2_d[l_ac].apcf034_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf034 ,g_apcf2_d[l_ac].apcf034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf034_desc
            #add-point:ON CHANGE apcf034_desc name="input.g.page2.apcf034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf035_desc
            #add-point:BEFORE FIELD apcf035_desc name="input.b.page2.apcf035_desc"
            LET g_apcf2_d[l_ac].apcf035_desc = g_apcf2_d[l_ac].apcf035   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf035_desc
            
            #add-point:AFTER FIELD apcf035_desc name="input.a.page2.apcf035_desc"
            #WBS
            IF NOT cl_null(g_apcf2_d[l_ac].apcf035_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf035_desc != g_apcf2_d_t.apcf035_desc OR g_apcf2_d_t.apcf035_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf035 = g_apcf2_d[l_ac].apcf035_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq028_chk(g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035)
                     IF NOT cl_null(g_errno) THEN
                        LET g_apcf2_d[l_ac].apcf035      = g_apcf2_d_t.apcf035
                        LET g_apcf2_d[l_ac].apcf035_desc = g_apcf2_d_t.apcf035_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf035 ,g_apcf2_d[l_ac].apcf035_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf035 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf035_desc = s_desc_show1(g_apcf2_d[l_ac].apcf035,s_desc_get_pjbbl004_desc(g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035))         
            LET g_apcf2_d_t.apcf035_desc = g_apcf2_d[l_ac].apcf035_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf035 ,g_apcf2_d[l_ac].apcf035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf035_desc
            #add-point:ON CHANGE apcf035_desc name="input.g.page2.apcf035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf037_desc
            #add-point:BEFORE FIELD apcf037_desc name="input.b.page2.apcf037_desc"
            LET g_apcf2_d[l_ac].apcf037_desc = g_apcf2_d[l_ac].apcf037   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf037_desc
            
            #add-point:AFTER FIELD apcf037_desc name="input.a.page2.apcf037_desc"
            #渠道
            IF NOT cl_null(g_apcf2_d[l_ac].apcf037_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf037_desc != g_apcf2_d_t.apcf037_desc OR g_apcf2_d_t.apcf037_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf037 = g_apcf2_d[l_ac].apcf037_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq052_chk(g_apcf2_d[l_ac].apcf037_desc)
                     IF NOT cl_null(g_errno) THEN
                        LET g_apcf2_d[l_ac].apcf037      = g_apcf2_d_t.apcf037
                        LET g_apcf2_d[l_ac].apcf037_desc = g_apcf2_d_t.apcf037_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf037 ,g_apcf2_d[l_ac].apcf037_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf037 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf037_desc = s_desc_show1(g_apcf2_d[l_ac].apcf037,s_desc_get_oojdl003_desc(g_apcf2_d[l_ac].apcf037))         
            LET g_apcf2_d_t.apcf037_desc = g_apcf2_d[l_ac].apcf037_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf037 ,g_apcf2_d[l_ac].apcf037_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf037_desc
            #add-point:ON CHANGE apcf037_desc name="input.g.page2.apcf037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf038_desc
            #add-point:BEFORE FIELD apcf038_desc name="input.b.page2.apcf038_desc"
            LET g_apcf2_d[l_ac].apcf038_desc = g_apcf2_d[l_ac].apcf038
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf038_desc
            
            #add-point:AFTER FIELD apcf038_desc name="input.a.page2.apcf038_desc"
            #品牌
            IF NOT cl_null(g_apcf2_d[l_ac].apcf038_desc) THEN
               IF ( g_apcf2_d[l_ac].apcf038_desc != g_apcf2_d_t.apcf038_desc OR g_apcf2_d_t.apcf038_desc IS NULL ) THEN
                  LET g_apcf2_d[l_ac].apcf038 = g_apcf2_d[l_ac].apcf038_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('2002',g_apcf2_d[l_ac].apcf038_desc) THEN
                        LET g_apcf2_d[l_ac].apcf038      = g_apcf2_d_t.apcf038
                        LET g_apcf2_d[l_ac].apcf038_desc = g_apcf2_d_t.apcf038_desc
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf038 ,g_apcf2_d[l_ac].apcf038_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf038 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf038_desc = s_desc_show1(g_apcf2_d[l_ac].apcf038,s_desc_get_acc_desc('2002',g_apcf2_d[l_ac].apcf038))
            LET g_apcf2_d_t.apcf038_desc = g_apcf2_d[l_ac].apcf038_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf038 ,g_apcf2_d[l_ac].apcf038_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf038_desc
            #add-point:ON CHANGE apcf038_desc name="input.g.page2.apcf038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf039_desc
            #add-point:BEFORE FIELD apcf039_desc name="input.b.page2.apcf039_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf039_desc = g_apcf2_d[l_ac].apcf039   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf039_desc
            
            #add-point:AFTER FIELD apcf039_desc name="input.a.page2.apcf039_desc"
            #自由核算項一
            IF NOT cl_null(g_apcf2_d[l_ac].apcf039_desc) THEN
               IF (g_apcf2_d[l_ac].apcf039_desc != g_apcf2_d_t.apcf039_desc OR g_apcf2_d_t.apcf039_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf039 = g_apcf2_d[l_ac].apcf039_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0171,g_apcf2_d[l_ac].apcf039,g_glad.glad0172)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf039 = g_apcf2_d_t.apcf039
                        LET g_apcf2_d[l_ac].apcf039_desc = s_desc_show1(g_apcf2_d[l_ac].apcf039,s_fin_get_accting_desc(g_glad.glad0171,g_apcf2_d[l_ac].apcf039))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf039_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf039 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf039_desc = s_desc_show1(g_apcf2_d[l_ac].apcf039,s_fin_get_accting_desc(g_glad.glad0171,g_apcf2_d[l_ac].apcf039))
            LET g_apcf2_d_t.apcf039_desc = g_apcf2_d[l_ac].apcf039_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf039_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf039_desc
            #add-point:ON CHANGE apcf039_desc name="input.g.page2.apcf039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf040_desc
            #add-point:BEFORE FIELD apcf040_desc name="input.b.page2.apcf040_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf040_desc = g_apcf2_d[l_ac].apcf040   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf040_desc
            
            #add-point:AFTER FIELD apcf040_desc name="input.a.page2.apcf040_desc"
            #自由核算項二
            IF NOT cl_null(g_apcf2_d[l_ac].apcf040_desc) THEN
               IF (g_apcf2_d[l_ac].apcf040_desc != g_apcf2_d_t.apcf040_desc OR g_apcf2_d_t.apcf040_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf040 = g_apcf2_d[l_ac].apcf040_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0181,g_apcf2_d[l_ac].apcf040,g_glad.glad0182)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf040 = g_apcf2_d_t.apcf040
                        LET g_apcf2_d[l_ac].apcf040_desc = s_desc_show1(g_apcf2_d[l_ac].apcf040,s_fin_get_accting_desc(g_glad.glad0181,g_apcf2_d[l_ac].apcf040))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf040_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf040 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf040_desc = s_desc_show1(g_apcf2_d[l_ac].apcf040,s_fin_get_accting_desc(g_glad.glad0181,g_apcf2_d[l_ac].apcf040))
            LET g_apcf2_d_t.apcf040_desc = g_apcf2_d[l_ac].apcf040_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf040_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf040_desc
            #add-point:ON CHANGE apcf040_desc name="input.g.page2.apcf040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf041_desc
            #add-point:BEFORE FIELD apcf041_desc name="input.b.page2.apcf041_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf041_desc = g_apcf2_d[l_ac].apcf041   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf041_desc
            
            #add-point:AFTER FIELD apcf041_desc name="input.a.page2.apcf041_desc"
            #自由核算項三
            IF NOT cl_null(g_apcf2_d[l_ac].apcf041_desc) THEN
               IF (g_apcf2_d[l_ac].apcf041_desc != g_apcf2_d_t.apcf041_desc OR g_apcf2_d_t.apcf041_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf041 = g_apcf2_d[l_ac].apcf041_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0191,g_apcf2_d[l_ac].apcf041,g_glad.glad0192)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE                         
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf041 = g_apcf2_d_t.apcf041
                        LET g_apcf2_d[l_ac].apcf041_desc = s_desc_show1(g_apcf2_d[l_ac].apcf041,s_fin_get_accting_desc(g_glad.glad0191,g_apcf2_d[l_ac].apcf041))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf041_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf041 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf041_desc = s_desc_show1(g_apcf2_d[l_ac].apcf041,s_fin_get_accting_desc(g_glad.glad0191,g_apcf2_d[l_ac].apcf041))
            LET g_apcf2_d_t.apcf041_desc = g_apcf2_d[l_ac].apcf041_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf041_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf041_desc
            #add-point:ON CHANGE apcf041_desc name="input.g.page2.apcf041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf042_desc
            #add-point:BEFORE FIELD apcf042_desc name="input.b.page2.apcf042_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf042_desc = g_apcf2_d[l_ac].apcf042   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf042_desc
            
            #add-point:AFTER FIELD apcf042_desc name="input.a.page2.apcf042_desc"
            #自由核算項四
            IF NOT cl_null(g_apcf2_d[l_ac].apcf042_desc) THEN
               IF (g_apcf2_d[l_ac].apcf042_desc != g_apcf2_d_t.apcf042_desc OR g_apcf2_d_t.apcf042_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf042 = g_apcf2_d[l_ac].apcf042_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0201,g_apcf2_d[l_ac].apcf042,g_glad.glad0202)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf042 = g_apcf2_d_t.apcf042
                        LET g_apcf2_d[l_ac].apcf042_desc = s_desc_show1(g_apcf2_d[l_ac].apcf042,s_fin_get_accting_desc(g_glad.glad0201,g_apcf2_d[l_ac].apcf042))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf042_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf042 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf042_desc = s_desc_show1(g_apcf2_d[l_ac].apcf042,s_fin_get_accting_desc(g_glad.glad0201,g_apcf2_d[l_ac].apcf042))
            LET g_apcf2_d_t.apcf042_desc = g_apcf2_d[l_ac].apcf042_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf042_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf042_desc
            #add-point:ON CHANGE apcf042_desc name="input.g.page2.apcf042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf043_desc
            #add-point:BEFORE FIELD apcf043_desc name="input.b.page2.apcf043_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf043_desc = g_apcf2_d[l_ac].apcf043   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf043_desc
            
            #add-point:AFTER FIELD apcf043_desc name="input.a.page2.apcf043_desc"
            #自由核算項五
            IF NOT cl_null(g_apcf2_d[l_ac].apcf043_desc) THEN
               IF (g_apcf2_d[l_ac].apcf043_desc != g_apcf2_d_t.apcf043_desc OR g_apcf2_d_t.apcf043_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf043 = g_apcf2_d[l_ac].apcf043_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0211,g_apcf2_d[l_ac].apcf043,g_glad.glad0212)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf043 = g_apcf2_d_t.apcf043
                        LET g_apcf2_d[l_ac].apcf043_desc = s_desc_show1(g_apcf2_d[l_ac].apcf043,s_fin_get_accting_desc(g_glad.glad0211,g_apcf2_d[l_ac].apcf043))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf043_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf043 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf043_desc = s_desc_show1(g_apcf2_d[l_ac].apcf043,s_fin_get_accting_desc(g_glad.glad0211,g_apcf2_d[l_ac].apcf043))
            LET g_apcf2_d_t.apcf042_desc = g_apcf2_d[l_ac].apcf042_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf043_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf043_desc
            #add-point:ON CHANGE apcf043_desc name="input.g.page2.apcf043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf044_desc
            #add-point:BEFORE FIELD apcf044_desc name="input.b.page2.apcf044_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf044_desc = g_apcf2_d[l_ac].apcf044   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf044_desc
            
            #add-point:AFTER FIELD apcf044_desc name="input.a.page2.apcf044_desc"
            #自由核算項六
            IF NOT cl_null(g_apcf2_d[l_ac].apcf044_desc) THEN
               IF (g_apcf2_d[l_ac].apcf044_desc != g_apcf2_d_t.apcf044_desc OR g_apcf2_d_t.apcf044_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf044 = g_apcf2_d[l_ac].apcf044_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0221,g_apcf2_d[l_ac].apcf044,g_glad.glad0222)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf044 = g_apcf2_d_t.apcf044
                        LET g_apcf2_d[l_ac].apcf044_desc = s_desc_show1(g_apcf2_d[l_ac].apcf044,s_fin_get_accting_desc(g_glad.glad0221,g_apcf2_d[l_ac].apcf044))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf044_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf044 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf044_desc = s_desc_show1(g_apcf2_d[l_ac].apcf044,s_fin_get_accting_desc(g_glad.glad0221,g_apcf2_d[l_ac].apcf044))
            LET g_apcf2_d_t.apcf044_desc = g_apcf2_d[l_ac].apcf044_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf044_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf044_desc
            #add-point:ON CHANGE apcf044_desc name="input.g.page2.apcf044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf045_desc
            #add-point:BEFORE FIELD apcf045_desc name="input.b.page2.apcf045_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf045_desc = g_apcf2_d[l_ac].apcf045   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf045_desc
            
            #add-point:AFTER FIELD apcf045_desc name="input.a.page2.apcf045_desc"
            #自由核算項七
            IF NOT cl_null(g_apcf2_d[l_ac].apcf045_desc) THEN
               IF (g_apcf2_d[l_ac].apcf045_desc != g_apcf2_d_t.apcf045_desc OR g_apcf2_d_t.apcf045_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf045 = g_apcf2_d[l_ac].apcf045_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0231,g_apcf2_d[l_ac].apcf045,g_glad.glad0232)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf045 = g_apcf2_d_t.apcf045
                        LET g_apcf2_d[l_ac].apcf045_desc = s_desc_show1(g_apcf2_d[l_ac].apcf045,s_fin_get_accting_desc(g_glad.glad0231,g_apcf2_d[l_ac].apcf045))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf045_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf045 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf045_desc = s_desc_show1(g_apcf2_d[l_ac].apcf045,s_fin_get_accting_desc(g_glad.glad0231,g_apcf2_d[l_ac].apcf045))
            LET g_apcf2_d_t.apcf045_desc = g_apcf2_d[l_ac].apcf045_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf045_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf045_desc
            #add-point:ON CHANGE apcf045_desc name="input.g.page2.apcf045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf046_desc
            #add-point:BEFORE FIELD apcf046_desc name="input.b.page2.apcf046_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf046_desc = g_apcf2_d[l_ac].apcf046   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf046_desc
            
            #add-point:AFTER FIELD apcf046_desc name="input.a.page2.apcf046_desc"
            #自由核算項八
            IF NOT cl_null(g_apcf2_d[l_ac].apcf046_desc) THEN
               IF (g_apcf2_d[l_ac].apcf046_desc != g_apcf2_d_t.apcf046_desc OR g_apcf2_d_t.apcf046_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf046 = g_apcf2_d[l_ac].apcf046_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0241,g_apcf2_d[l_ac].apcf046,g_glad.glad0242) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf046 = g_apcf2_d_t.apcf046
                        LET g_apcf2_d[l_ac].apcf046_desc = s_desc_show1(g_apcf2_d[l_ac].apcf046,s_fin_get_accting_desc(g_glad.glad0241,g_apcf2_d[l_ac].apcf046))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf046_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf046 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf046_desc = s_desc_show1(g_apcf2_d[l_ac].apcf046,s_fin_get_accting_desc(g_glad.glad0241,g_apcf2_d[l_ac].apcf046))
            LET g_apcf2_d_t.apcf046_desc = g_apcf2_d[l_ac].apcf046_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf046_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf046_desc
            #add-point:ON CHANGE apcf046_desc name="input.g.page2.apcf046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf047_desc
            #add-point:BEFORE FIELD apcf047_desc name="input.b.page2.apcf047_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf047_desc = g_apcf2_d[l_ac].apcf047   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf047_desc
            
            #add-point:AFTER FIELD apcf047_desc name="input.a.page2.apcf047_desc"
            #自由核算項九
            IF NOT cl_null(g_apcf2_d[l_ac].apcf047_desc) THEN
               IF (g_apcf2_d[l_ac].apcf047_desc != g_apcf2_d_t.apcf047_desc OR g_apcf2_d_t.apcf047_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf047 = g_apcf2_d[l_ac].apcf047_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0251,g_apcf2_d[l_ac].apcf047,g_glad.glad0252)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf047 = g_apcf2_d_t.apcf047
                        LET g_apcf2_d[l_ac].apcf047_desc = s_desc_show1(g_apcf2_d[l_ac].apcf047,s_fin_get_accting_desc(g_glad.glad0251,g_apcf2_d[l_ac].apcf047))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf047_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf047 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf047_desc = s_desc_show1(g_apcf2_d[l_ac].apcf047,s_fin_get_accting_desc(g_glad.glad0251,g_apcf2_d[l_ac].apcf047))
            LET g_apcf2_d_t.apcf047_desc = g_apcf2_d[l_ac].apcf047_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf047_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf047_desc
            #add-point:ON CHANGE apcf047_desc name="input.g.page2.apcf047_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcf048_desc
            #add-point:BEFORE FIELD apcf048_desc name="input.b.page2.apcf048_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apcf2_d[l_ac].apcf048_desc = g_apcf2_d[l_ac].apcf048   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcf048_desc
            
            #add-point:AFTER FIELD apcf048_desc name="input.a.page2.apcf048_desc"
            #自由核算項十
            IF NOT cl_null(g_apcf2_d[l_ac].apcf048_desc) THEN
               IF (g_apcf2_d[l_ac].apcf048_desc != g_apcf2_d_t.apcf048_desc OR g_apcf2_d_t.apcf048_desc IS NULL) THEN
                  LET g_apcf2_d[l_ac].apcf048 = g_apcf2_d[l_ac].apcf048_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_free_account_chk(g_glad.glad0261,g_apcf2_d[l_ac].apcf048,g_glad.glad0262)  RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apcf2_d[l_ac].apcf048 = g_apcf2_d_t.apcf048
                        LET g_apcf2_d[l_ac].apcf048_desc = s_desc_show1(g_apcf2_d[l_ac].apcf048,s_fin_get_accting_desc(g_glad.glad0261,g_apcf2_d[l_ac].apcf048))
                        DISPLAY BY NAME g_apcf2_d[l_ac].apcf048_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apcf2_d[l_ac].apcf048 = ''
            END IF
            LET g_apcf2_d[l_ac].apcf048_desc = s_desc_show1(g_apcf2_d[l_ac].apcf048,s_fin_get_accting_desc(g_glad.glad0261,g_apcf2_d[l_ac].apcf048))
            LET g_apcf2_d_t.apcf048_desc = g_apcf2_d[l_ac].apcf048_desc
            DISPLAY BY NAME g_apcf2_d[l_ac].apcf048_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcf048_desc
            #add-point:ON CHANGE apcf048_desc name="input.g.page2.apcf048_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apcf008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf008_desc
            #add-point:ON ACTION controlp INFIELD apcf008_desc name="input.c.page2.apcf008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf021_desc
            #add-point:ON ACTION controlp INFIELD apcf021_desc name="input.c.page2.apcf021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcforga_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcforga_desc
            #add-point:ON ACTION controlp INFIELD apcforga_desc name="input.c.page2.apcforga_desc"
            #來源組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcforga
            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_apca.apcadocdt,"' AND (ooed007 IS NULL OR ooed007 >='",g_apca.apcadocdt,"')"
            CALL q_ooed004_1() 
            LET g_apcf2_d[l_ac].apcforga = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcforga_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcforga_desc
            NEXT FIELD apcforga_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf026_desc
            #add-point:ON ACTION controlp INFIELD apcf026_desc name="input.c.page2.apcf026_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf026
            LET g_qryparam.arg1 = g_apca.apcadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apcf2_d[l_ac].apcf026 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf026_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf026_desc
            CALL DIALOG.setFieldTouched("apcf026_2", TRUE)
            NEXT FIELD apcf026_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf027_desc
            #add-point:ON ACTION controlp INFIELD apcf027_desc name="input.c.page2.apcf027_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf027
            LET g_qryparam.arg1  = g_apca.apcadocdt          #生效日期
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()    
            LET g_apcf2_d[l_ac].apcf027 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf027_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf027_desc
            CALL DIALOG.setFieldTouched("apcf027_2", TRUE)
            NEXT FIELD apcf027_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf028_desc
            #add-point:ON ACTION controlp INFIELD apcf028_desc name="input.c.page2.apcf028_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf028
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()
            LET g_apcf2_d[l_ac].apcf028 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf028_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf028_desc
            CALL DIALOG.setFieldTouched("apcf027_2", TRUE)
            NEXT FIELD apcf028_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf029_desc
            #add-point:ON ACTION controlp INFIELD apcf029_desc name="input.c.page2.apcf029_desc"
            #交易客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf029
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001() 
            LET g_apcf2_d[l_ac].apcf029 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf029_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf029_desc
            CALL DIALOG.setFieldTouched("apcf029_2", TRUE)
            NEXT FIELD apcf029_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf030_desc
            #add-point:ON ACTION controlp INFIELD apcf030_desc name="input.c.page2.apcf030_desc"
            #帳款客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf030
            LET g_qryparam.arg1 = "1"                         #交易類型
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001() 
            LET g_apcf2_d[l_ac].apcf030 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf030_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf030_desc
            CALL DIALOG.setFieldTouched("apcf030_2", TRUE)
            NEXT FIELD apcf030_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf031_desc
            #add-point:ON ACTION controlp INFIELD apcf031_desc name="input.c.page2.apcf031_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf031
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()
            LET g_apcf2_d[l_ac].apcf031 = g_qryparam.return1   
            LET g_apcf2_d[l_ac].apcf031_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf031_desc
            CALL DIALOG.setFieldTouched("apcf031_2", TRUE)
            NEXT FIELD apcf031_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf032_desc
            #add-point:ON ACTION controlp INFIELD apcf032_desc name="input.c.page2.apcf032_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf032
            CALL q_rtax001()                          
            LET g_apcf2_d[l_ac].apcf032 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf032_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf032_desc
            CALL DIALOG.setFieldTouched("apcf032_2", TRUE)
            NEXT FIELD apcf032_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf033_desc
            #add-point:ON ACTION controlp INFIELD apcf033_desc name="input.c.page2.apcf033_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf033
            CALL q_ooag001_8()                          
            LET g_apcf2_d[l_ac].apcf033 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf033_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf033_desc
            CALL DIALOG.setFieldTouched("apcf033_2", TRUE)
            NEXT FIELD apcf033_desc    
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf034_desc
            #add-point:ON ACTION controlp INFIELD apcf034_desc name="input.c.page2.apcf034_desc"
            #專案編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf034
            CALL q_pjba001()                          
            LET g_apcf2_d[l_ac].apcf034 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf034_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf034_desc
            CALL DIALOG.setFieldTouched("apcf034_2", TRUE)
            NEXT FIELD apcf034_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf035_desc
            #add-point:ON ACTION controlp INFIELD apcf035_desc name="input.c.page2.apcf035_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf035
            IF NOT cl_null(g_apcf2_d[l_ac].apcf034) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apcf2_d[l_ac].apcf034,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF 
            CALL q_pjbb002()            
            LET g_apcf2_d[l_ac].apcf035 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf035_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf035_desc
            CALL DIALOG.setFieldTouched("apcf035_2", TRUE)
            NEXT FIELD apcf035_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf037_desc
            #add-point:ON ACTION controlp INFIELD apcf037_desc name="input.c.page2.apcf037_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf037
            CALL q_oojd001_2()     
            LET g_apcf2_d[l_ac].apcf037 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf037_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf037_desc
            CALL DIALOG.setFieldTouched("apcf037_2", TRUE)
            NEXT FIELD apcf037_desc  
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf038_desc
            #add-point:ON ACTION controlp INFIELD apcf038_desc name="input.c.page2.apcf038_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf038
            CALL q_oocq002_2002()     
            LET g_apcf2_d[l_ac].apcf038 = g_qryparam.return1    
            LET g_apcf2_d[l_ac].apcf038_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf038_desc
            CALL DIALOG.setFieldTouched("apcf038_2", TRUE)
            NEXT FIELD apcf038_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf039_desc
            #add-point:ON ACTION controlp INFIELD apcf039_desc name="input.c.page2.apcf039_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf039
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf039      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf039_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf039_desc
               CALL DIALOG.setFieldTouched("apcf039_2", TRUE)
               NEXT FIELD apcf039_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf040_desc
            #add-point:ON ACTION controlp INFIELD apcf040_desc name="input.c.page2.apcf040_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf040
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf040      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf040_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf040_desc
               CALL DIALOG.setFieldTouched("apcf040_2", TRUE)
               NEXT FIELD apcf040_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf041_desc
            #add-point:ON ACTION controlp INFIELD apcf041_desc name="input.c.page2.apcf041_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf041
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf041      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf041_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf041_desc
               CALL DIALOG.setFieldTouched("apcf041_2", TRUE)
               NEXT FIELD apcf041_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf042_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf042_desc
            #add-point:ON ACTION controlp INFIELD apcf042_desc name="input.c.page2.apcf042_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf042
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf042      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf042_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf042_desc
               CALL DIALOG.setFieldTouched("apcf042_2", TRUE)
               NEXT FIELD apcf042_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf043_desc
            #add-point:ON ACTION controlp INFIELD apcf043_desc name="input.c.page2.apcf043_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf043
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf043      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf043_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf043_desc
               CALL DIALOG.setFieldTouched("apcf043_2", TRUE)
               NEXT FIELD apcf043_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf044_desc
            #add-point:ON ACTION controlp INFIELD apcf044_desc name="input.c.page2.apcf044_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf044
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf044      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf044_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf044_desc
               CALL DIALOG.setFieldTouched("apcf044_2", TRUE)
               NEXT FIELD apcf044_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf045_desc
            #add-point:ON ACTION controlp INFIELD apcf045_desc name="input.c.page2.apcf045_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf045
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf045      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf045_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf045_desc
               CALL DIALOG.setFieldTouched("apcf045_2", TRUE)
               NEXT FIELD apcf045_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf046_desc
            #add-point:ON ACTION controlp INFIELD apcf046_desc name="input.c.page2.apcf046_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf046
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf046      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf046_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf046_desc
               CALL DIALOG.setFieldTouched("apcf046_2", TRUE)
               NEXT FIELD apcf046_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf047_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf047_desc
            #add-point:ON ACTION controlp INFIELD apcf047_desc name="input.c.page2.apcf047_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf047
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf047      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf047_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf047_desc
               CALL DIALOG.setFieldTouched("apcf047_2", TRUE)
               NEXT FIELD apcf047_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcf048_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcf048_desc
            #add-point:ON ACTION controlp INFIELD apcf048_desc name="input.c.page2.apcf048_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apcf2_d[l_ac].apcf048
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apcf2_d[l_ac].apcf048      = g_qryparam.return1
               LET g_apcf2_d[l_ac].apcf048_desc = g_qryparam.return1
               DISPLAY BY NAME g_apcf2_d[l_ac].apcf048,g_apcf2_d[l_ac].apcf048_desc
               CALL DIALOG.setFieldTouched("apcf048_2", TRUE)
               NEXT FIELD apcf048_desc
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
                  LET g_apcf2_d[l_ac].* = g_apcf2_d_t.*
               END IF
               CLOSE aapt210_01_bcl
               #add-point:單身after row name="input.body2.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aapt210_01_unlock_b("apcf_t")
            #add-point:單身after row name="input.body2.a_row"
   
            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
               CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
                    RETURNING g_sub_success
            END IF
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apcf_d[li_reproduce_target].* = g_apcf_d[li_reproduce].*
               LET g_apcf2_d[li_reproduce_target].* = g_apcf2_d[li_reproduce].*
 
               LET g_apcf2_d[li_reproduce_target].apcfld = NULL
               LET g_apcf2_d[li_reproduce_target].apcfdocno = NULL
               LET g_apcf2_d[li_reproduce_target].apcfseq = NULL
               LET g_apcf2_d[li_reproduce_target].apcfseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apcf2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apcf2_d.getLength()+1
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
               NEXT FIELD apcfdocno
            WHEN "s_detail2"
               NEXT FIELD apcfld_2
 
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
      IF INT_FLAG OR cl_null(g_apcf_d[g_detail_idx].apcfld) THEN
         CALL g_apcf_d.deleteElement(g_detail_idx)
         CALL g_apcf2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_apcf_d[g_detail_idx].* = g_apcf_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aapt210_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt210_01_delete()
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
   CASE g_apca.apcastus
        WHEN 'Y'
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 'axc-0037' 
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
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_apcf_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapt210_01_lock_b("apcf_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("apcf_t","") THEN
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
   
   FOR li_idx = 1 TO g_apcf_d.getLength()
      IF g_apcf_d[li_idx].apcfld IS NOT NULL
         AND g_apcf_d[li_idx].apcfdocno IS NOT NULL
         AND g_apcf_d[li_idx].apcfseq IS NOT NULL
         AND g_apcf_d[li_idx].apcfseq2 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM apcf_t
          WHERE apcfent = g_enterprise AND 
                apcfld = g_apcf_d[li_idx].apcfld
                AND apcfdocno = g_apcf_d[li_idx].apcfdocno
                AND apcfseq = g_apcf_d[li_idx].apcfseq
                AND apcfseq2 = g_apcf_d[li_idx].apcfseq2
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_apcf_d_t.apcfld
               LET gs_keys[2] = g_apcf_d_t.apcfdocno
               LET gs_keys[3] = g_apcf_d_t.apcfseq
               LET gs_keys[4] = g_apcf_d_t.apcfseq2
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapt210_01_delete_b('apcf_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt210_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aapt210_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt210_01_b_fill(p_wc2)              #BODY FILL UP
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
   LET p_wc2 = " apcfld = '",g_apcald,"' AND apcfdocno = '",g_apcadocno,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.apcfdocno,t0.apcfld,t0.apcfseq,t0.apcfseq2,t0.apcf008,t0.apcf009, 
       t0.apcf010,t0.apcf021,t0.apcf007,t0.apcf101,t0.apcf103,t0.apcf104,t0.apcf105,t0.apcf102,t0.apcf113, 
       t0.apcf114,t0.apcf115,t0.apcf020,t0.apcf022,t0.apcf023,t0.apcf111,t0.apcf122,t0.apcf123,t0.apcf124, 
       t0.apcf125,t0.apcf126,t0.apcf127,t0.apcf132,t0.apcf133,t0.apcf134,t0.apcf135,t0.apcf136,t0.apcf137, 
       t0.apcf001,t0.apcf002,t0.apcf024,t0.apcf025,t0.apcfld,t0.apcfdocno,t0.apcfseq,t0.apcfseq2,t0.apcf049, 
       t0.apcforga,t0.apcf026,t0.apcf027,t0.apcf028,t0.apcf029,t0.apcf030,t0.apcf031,t0.apcf032,t0.apcf033, 
       t0.apcf034,t0.apcf035,t0.apcf036,t0.apcf037,t0.apcf038,t0.apcf039,t0.apcf040,t0.apcf041,t0.apcf042, 
       t0.apcf043,t0.apcf044,t0.apcf045,t0.apcf046,t0.apcf047,t0.apcf048  FROM apcf_t t0",
               "",
               
               " WHERE t0.apcfent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("apcf_t"),
                      " ORDER BY t0.apcfld,t0.apcfdocno,t0.apcfseq,t0.apcfseq2"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"apcf_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt210_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapt210_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apcf_d.clear()
   CALL g_apcf2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_apcf_d[l_ac].apcfdocno,g_apcf_d[l_ac].apcfld,g_apcf_d[l_ac].apcfseq,g_apcf_d[l_ac].apcfseq2, 
       g_apcf_d[l_ac].apcf008,g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010,g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].apcf007, 
       g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105,g_apcf_d[l_ac].apcf102, 
       g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115,g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022, 
       g_apcf_d[l_ac].apcf023,g_apcf_d[l_ac].apcf111,g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123,g_apcf_d[l_ac].apcf124, 
       g_apcf_d[l_ac].apcf125,g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127,g_apcf_d[l_ac].apcf132,g_apcf_d[l_ac].apcf133, 
       g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135,g_apcf_d[l_ac].apcf136,g_apcf_d[l_ac].apcf137,g_apcf_d[l_ac].apcf001, 
       g_apcf_d[l_ac].apcf002,g_apcf_d[l_ac].apcf024,g_apcf_d[l_ac].apcf025,g_apcf2_d[l_ac].apcfld,g_apcf2_d[l_ac].apcfdocno, 
       g_apcf2_d[l_ac].apcfseq,g_apcf2_d[l_ac].apcfseq2,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga, 
       g_apcf2_d[l_ac].apcf026,g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029, 
       g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033, 
       g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037, 
       g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041, 
       g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045, 
       g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf048
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_apcf_d[l_ac].l_apcf021_desc = s_desc_get_account_desc(g_apcald,g_apcf_d[l_ac].apcf021)
      SELECT apca001 INTO g_apcf_d[l_ac].apca001
        FROM apca_t
       WHERE apcaent = g_enterprise
         AND apcald  = g_apcald AND apcadocno = g_apcf_d[l_ac].apcf008
      #end add-point
      
      CALL aapt210_01_detail_show()      
 
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
   
 
   
   CALL g_apcf_d.deleteElement(g_apcf_d.getLength())   
   CALL g_apcf2_d.deleteElement(g_apcf2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_apcf_d.getLength()
      LET g_apcf2_d[l_ac].apcfld = g_apcf_d[l_ac].apcfld 
      LET g_apcf2_d[l_ac].apcfdocno = g_apcf_d[l_ac].apcfdocno 
      LET g_apcf2_d[l_ac].apcfseq = g_apcf_d[l_ac].apcfseq 
      LET g_apcf2_d[l_ac].apcfseq2 = g_apcf_d[l_ac].apcfseq2 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_apcf_d.getLength() THEN
      LET l_ac = g_apcf_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_apcf_d.getLength()
      LET g_apcf_d_mask_o[l_ac].* =  g_apcf_d[l_ac].*
      CALL aapt210_01_apcf_t_mask()
      LET g_apcf_d_mask_n[l_ac].* =  g_apcf_d[l_ac].*
   END FOR
   
   LET g_apcf2_d_mask_o.* =  g_apcf2_d.*
   FOR l_ac = 1 TO g_apcf2_d.getLength()
      LET g_apcf2_d_mask_o[l_ac].* =  g_apcf2_d[l_ac].*
      CALL aapt210_01_apcf_t_mask()
      LET g_apcf2_d_mask_n[l_ac].* =  g_apcf2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   ##其他科目明細---(S)---
   LET l_ac = 1
   LET g_sql = "SELECT apcfld,apcfdocno,apcfseq,apcfseq2,apcf008,apcf021,apcf049,apcforga,'',apcf026,'',",
               "       apcf027,'',apcf028,'',apcf029,'',apcf030,'',apcf031,'',",
               "       apcf032,'',apcf033,'',apcf034,'',apcf035,'',apcf036,   ",
               "       apcf037,'',apcf038,'', ",
               "       apcf039,'',apcf040,'',apcf041,'',apcf042,'',apcf043,'',",
               "       apcf044,'',apcf045,'',apcf046,'',apcf047,'',apcf048,'' ",
               "  FROM apcf_t ",
               " WHERE apcfent = ",g_enterprise," ",
               "   AND apcfld  = '",g_apcald,"' AND apcfdocno = '",g_apcadocno,"' "
   
   PREPARE aapt210_01_apcf_p1 FROM g_sql
   DECLARE aapt210_01_apcf_c1 CURSOR FOR aapt210_01_apcf_p1
   #FOREACH aapt210_01_apcf_c1 INTO g_apcf2_d[l_ac].*     #161208-00026#5 mark
   #161208-00026#5-add(s)
   FOREACH aapt210_01_apcf_c1 INTO g_apcf2_d[l_ac].apcfld,g_apcf2_d[l_ac].apcfdocno,g_apcf2_d[l_ac].apcfseq,g_apcf2_d[l_ac].apcfseq2,g_apcf2_d[l_ac].apcf008_desc, 
                                   g_apcf2_d[l_ac].apcf021_desc,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcforga_desc,g_apcf2_d[l_ac].apcf026,
                                   g_apcf2_d[l_ac].apcf026_desc,g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf027_desc,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf028_desc, 
                                   g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf029_desc,g_apcf2_d[l_ac].apcf030,g_apcf2_d[l_ac].apcf030_desc,g_apcf2_d[l_ac].apcf031, 
                                   g_apcf2_d[l_ac].apcf031_desc,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf032_desc,g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf033_desc, 
                                   g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf034_desc,g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf035_desc,g_apcf2_d[l_ac].apcf036, 
                                   g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf037_desc,g_apcf2_d[l_ac].apcf038,g_apcf2_d[l_ac].apcf038_desc,g_apcf2_d[l_ac].apcf039, 
                                   g_apcf2_d[l_ac].apcf039_desc,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf040_desc,g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf041_desc, 
                                   g_apcf2_d[l_ac].apcf042,g_apcf2_d[l_ac].apcf042_desc,g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf043_desc,g_apcf2_d[l_ac].apcf044, 
                                   g_apcf2_d[l_ac].apcf044_desc,g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf045_desc,g_apcf2_d[l_ac].apcf046,g_apcf2_d[l_ac].apcf046_desc, 
                                   g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf047_desc,g_apcf2_d[l_ac].apcf048,g_apcf2_d[l_ac].apcf048_desc
   #161208-00026#5-add(e)
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      INITIALIZE g_glad.* TO NULL
      CALL s_fin_sel_glad(g_apcald,g_apcf2_d[l_ac].apcf021_desc,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,g_glad.*
      LET g_apcf2_d[l_ac].apcforga_desc= s_desc_show1(g_apcf2_d[l_ac].apcforga,s_desc_get_department_desc(g_apcf2_d[l_ac].apcforga))
      LET g_apcf2_d[l_ac].apcf026_desc = s_desc_show1(g_apcf2_d[l_ac].apcf026,s_desc_get_department_desc(g_apcf2_d[l_ac].apcf026))
      LET g_apcf2_d[l_ac].apcf027_desc = s_desc_show1(g_apcf2_d[l_ac].apcf027,s_desc_get_department_desc(g_apcf2_d[l_ac].apcf027))
      LET g_apcf2_d[l_ac].apcf028_desc = s_desc_show1(g_apcf2_d[l_ac].apcf028, s_desc_get_acc_desc('287',g_apcf2_d[l_ac].apcf028))
      LET g_apcf2_d[l_ac].apcf029_desc = s_desc_show1(g_apcf2_d[l_ac].apcf029,s_desc_get_trading_partner_abbr_desc(g_apcf2_d[l_ac].apcf029))
      LET g_apcf2_d[l_ac].apcf030_desc = s_desc_show1(g_apcf2_d[l_ac].apcf030,s_desc_get_trading_partner_abbr_desc(g_apcf2_d[l_ac].apcf030))

      LET g_apcf2_d[l_ac].apcf031_desc = s_desc_show1(g_apcf2_d[l_ac].apcf031,s_desc_get_acc_desc('281',g_apcf2_d[l_ac].apcf031))
      LET g_apcf2_d[l_ac].apcf032_desc = s_desc_show1(g_apcf2_d[l_ac].apcf032,s_desc_get_rtaxl003_desc(g_apcf2_d[l_ac].apcf032))
      LET g_apcf2_d[l_ac].apcf033_desc = s_desc_show1(g_apcf2_d[l_ac].apcf033,s_desc_get_person_desc(g_apcf2_d[l_ac].apcf033))
      LET g_apcf2_d[l_ac].apcf034_desc = s_desc_show1(g_apcf2_d[l_ac].apcf034,s_desc_get_project_desc(g_apcf2_d[l_ac].apcf034))
      LET g_apcf2_d[l_ac].apcf035_desc = s_desc_show1(g_apcf2_d[l_ac].apcf035,s_desc_get_pjbbl004_desc(g_apcf2_d[l_ac].apcf034,g_apcf2_d[l_ac].apcf035))
      
      LET g_apcf2_d[l_ac].apcf037_desc = s_desc_show1(g_apcf2_d[l_ac].apcf037,s_desc_get_oojdl003_desc(g_apcf2_d[l_ac].apcf037))
      LET g_apcf2_d[l_ac].apcf038_desc = s_desc_show1(g_apcf2_d[l_ac].apcf038,s_desc_get_acc_desc('2002',g_apcf2_d[l_ac].apcf038))
      IF NOT cl_null(g_apcf2_d[l_ac].apcf039) THEN
         LET g_apcf2_d[l_ac].apcf039_desc = s_desc_show1(g_apcf2_d[l_ac].apcf039,s_fin_get_accting_desc(g_glad.glad0171,g_apcf2_d[l_ac].apcf039))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf040) THEN
         LET g_apcf2_d[l_ac].apcf040_desc = s_desc_show1(g_apcf2_d[l_ac].apcf040,s_fin_get_accting_desc(g_glad.glad0181,g_apcf2_d[l_ac].apcf040))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf041) THEN
         LET g_apcf2_d[l_ac].apcf041_desc = s_desc_show1(g_apcf2_d[l_ac].apcf041,s_fin_get_accting_desc(g_glad.glad0191,g_apcf2_d[l_ac].apcf041))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf042) THEN
         LET g_apcf2_d[l_ac].apcf042_desc = s_desc_show1(g_apcf2_d[l_ac].apcf042,s_fin_get_accting_desc(g_glad.glad0201,g_apcf2_d[l_ac].apcf042))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf043) THEN
         LET g_apcf2_d[l_ac].apcf043_desc = s_desc_show1(g_apcf2_d[l_ac].apcf043,s_fin_get_accting_desc(g_glad.glad0211,g_apcf2_d[l_ac].apcf043))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf044) THEN
         LET g_apcf2_d[l_ac].apcf044_desc = s_desc_show1(g_apcf2_d[l_ac].apcf044,s_fin_get_accting_desc(g_glad.glad0221,g_apcf2_d[l_ac].apcf044))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf045) THEN
         LET g_apcf2_d[l_ac].apcf045_desc = s_desc_show1(g_apcf2_d[l_ac].apcf045,s_fin_get_accting_desc(g_glad.glad0231,g_apcf2_d[l_ac].apcf045))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf046) THEN
         LET g_apcf2_d[l_ac].apcf046_desc = s_desc_show1(g_apcf2_d[l_ac].apcf046,s_fin_get_accting_desc(g_glad.glad0241,g_apcf2_d[l_ac].apcf046))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf047) THEN
         LET g_apcf2_d[l_ac].apcf047_desc = s_desc_show1(g_apcf2_d[l_ac].apcf047,s_fin_get_accting_desc(g_glad.glad0251,g_apcf2_d[l_ac].apcf047))
      END IF
      IF NOT cl_null(g_apcf2_d[l_ac].apcf048) THEN
         LET g_apcf2_d[l_ac].apcf048_desc = s_desc_show1(g_apcf2_d[l_ac].apcf048,s_fin_get_accting_desc(g_glad.glad0261,g_apcf2_d[l_ac].apcf048))
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_apcf2_d.deleteElement(l_ac)
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_apcf_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapt210_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapt210_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
 
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt210_01_set_entry_b(p_cmd)                                                  
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
   #数量和金额都可以修改，只要单价、币别、汇率不让修改就可以
   CALL cl_set_comp_entry("apcf007,
                           apcf103,apcf104,apcf105,
                           apcf113,apcf114,apcf115",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aapt210_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt210_01_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_desc     LIKE type_t.chr50
   DEFINE l_oodb005  LIKE oodb_t.oodb005
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

   IF NOT cl_null(g_apcf_d[l_ac].apcf020) THEN
      CALL s_tax_chk(g_glaa.glaacomp,g_apcf_d[l_ac].apcf020) 
           RETURNING g_sub_success,l_desc,l_oodb005,l_desc,l_desc
      IF l_oodb005 = 'Y' THEN
         CALL cl_set_comp_entry("apcf103,apcf113",FALSE)
      ELSE
         CALL cl_set_comp_entry("apcf105,apcf115",FALSE)
      END IF
   END IF
   
   IF g_apcf_d[l_ac].apcf008 = 'DIFF' THEN
      CALL cl_set_comp_entry("apcf007,
                              apcf103,apcf104,apcf105,
                              apcf113,apcf114,apcf115",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt210_01_default_search()
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
      LET ls_wc = ls_wc, " apcfld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apcfdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " apcfseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " apcfseq2 = '", g_argv[04], "' AND "
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
 
{<section id="aapt210_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt210_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "apcf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'apcf_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM apcf_t
          WHERE apcfent = g_enterprise AND
            apcfld = ps_keys_bak[1] AND apcfdocno = ps_keys_bak[2] AND apcfseq = ps_keys_bak[3] AND apcfseq2 = ps_keys_bak[4]
         
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
         CALL g_apcf_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_apcf2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt210_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "apcf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO apcf_t
                  (apcfent,
                   apcfld,apcfdocno,apcfseq,apcfseq2
                   ,apcf008,apcf009,apcf010,apcf021,apcf007,apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022,apcf023,apcf111,apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134,apcf135,apcf136,apcf137,apcf001,apcf002,apcf024,apcf025,apcf049,apcforga,apcf026,apcf027,apcf028,apcf029,apcf030,apcf031,apcf032,apcf033,apcf034,apcf035,apcf036,apcf037,apcf038,apcf039,apcf040,apcf041,apcf042,apcf043,apcf044,apcf045,apcf046,apcf047,apcf048) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_apcf_d[l_ac].apcf008,g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010,g_apcf_d[l_ac].apcf021, 
                       g_apcf_d[l_ac].apcf007,g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104, 
                       g_apcf_d[l_ac].apcf105,g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114, 
                       g_apcf_d[l_ac].apcf115,g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022,g_apcf_d[l_ac].apcf023, 
                       g_apcf_d[l_ac].apcf111,g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123,g_apcf_d[l_ac].apcf124, 
                       g_apcf_d[l_ac].apcf125,g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127,g_apcf_d[l_ac].apcf132, 
                       g_apcf_d[l_ac].apcf133,g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135,g_apcf_d[l_ac].apcf136, 
                       g_apcf_d[l_ac].apcf137,g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002,g_apcf_d[l_ac].apcf024, 
                       g_apcf_d[l_ac].apcf025,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcf026, 
                       g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf030, 
                       g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf034, 
                       g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf038, 
                       g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf042, 
                       g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf046, 
                       g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf048)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt210_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "apcf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "apcf_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE apcf_t 
         SET (apcfld,apcfdocno,apcfseq,apcfseq2
              ,apcf008,apcf009,apcf010,apcf021,apcf007,apcf101,apcf103,apcf104,apcf105,apcf102,apcf113,apcf114,apcf115,apcf020,apcf022,apcf023,apcf111,apcf122,apcf123,apcf124,apcf125,apcf126,apcf127,apcf132,apcf133,apcf134,apcf135,apcf136,apcf137,apcf001,apcf002,apcf024,apcf025,apcf049,apcforga,apcf026,apcf027,apcf028,apcf029,apcf030,apcf031,apcf032,apcf033,apcf034,apcf035,apcf036,apcf037,apcf038,apcf039,apcf040,apcf041,apcf042,apcf043,apcf044,apcf045,apcf046,apcf047,apcf048) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_apcf_d[l_ac].apcf008,g_apcf_d[l_ac].apcf009,g_apcf_d[l_ac].apcf010,g_apcf_d[l_ac].apcf021, 
                  g_apcf_d[l_ac].apcf007,g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104, 
                  g_apcf_d[l_ac].apcf105,g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114, 
                  g_apcf_d[l_ac].apcf115,g_apcf_d[l_ac].apcf020,g_apcf_d[l_ac].apcf022,g_apcf_d[l_ac].apcf023, 
                  g_apcf_d[l_ac].apcf111,g_apcf_d[l_ac].apcf122,g_apcf_d[l_ac].apcf123,g_apcf_d[l_ac].apcf124, 
                  g_apcf_d[l_ac].apcf125,g_apcf_d[l_ac].apcf126,g_apcf_d[l_ac].apcf127,g_apcf_d[l_ac].apcf132, 
                  g_apcf_d[l_ac].apcf133,g_apcf_d[l_ac].apcf134,g_apcf_d[l_ac].apcf135,g_apcf_d[l_ac].apcf136, 
                  g_apcf_d[l_ac].apcf137,g_apcf_d[l_ac].apcf001,g_apcf_d[l_ac].apcf002,g_apcf_d[l_ac].apcf024, 
                  g_apcf_d[l_ac].apcf025,g_apcf2_d[l_ac].apcf049,g_apcf2_d[l_ac].apcforga,g_apcf2_d[l_ac].apcf026, 
                  g_apcf2_d[l_ac].apcf027,g_apcf2_d[l_ac].apcf028,g_apcf2_d[l_ac].apcf029,g_apcf2_d[l_ac].apcf030, 
                  g_apcf2_d[l_ac].apcf031,g_apcf2_d[l_ac].apcf032,g_apcf2_d[l_ac].apcf033,g_apcf2_d[l_ac].apcf034, 
                  g_apcf2_d[l_ac].apcf035,g_apcf2_d[l_ac].apcf036,g_apcf2_d[l_ac].apcf037,g_apcf2_d[l_ac].apcf038, 
                  g_apcf2_d[l_ac].apcf039,g_apcf2_d[l_ac].apcf040,g_apcf2_d[l_ac].apcf041,g_apcf2_d[l_ac].apcf042, 
                  g_apcf2_d[l_ac].apcf043,g_apcf2_d[l_ac].apcf044,g_apcf2_d[l_ac].apcf045,g_apcf2_d[l_ac].apcf046, 
                  g_apcf2_d[l_ac].apcf047,g_apcf2_d[l_ac].apcf048) 
         WHERE apcfent = g_enterprise AND apcfld = ps_keys_bak[1] AND apcfdocno = ps_keys_bak[2] AND apcfseq = ps_keys_bak[3] AND apcfseq2 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcf_t:",SQLERRMESSAGE 
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
 
{<section id="aapt210_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt210_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapt210_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "apcf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt210_01_bcl USING g_enterprise,
                                       g_apcf_d[g_detail_idx].apcfld,g_apcf_d[g_detail_idx].apcfdocno, 
                                           g_apcf_d[g_detail_idx].apcfseq,g_apcf_d[g_detail_idx].apcfseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt210_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt210_01_unlock_b(ps_table)
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
      CLOSE aapt210_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapt210_01_modify_detail_chk(ps_record)
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
         LET ls_return = "apcfdocno"
      WHEN "s_detail2"
         LET ls_return = "apcfld_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapt210_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapt210_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aapt210_01.mask_functions" >}
&include "erp/aap/aapt210_01_mask.4gl"
 
{</section>}
 
{<section id="aapt210_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt210_01_set_pk_array()
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
   LET g_pk_array[1].values = g_apcf_d[l_ac].apcfld
   LET g_pk_array[1].column = 'apcfld'
   LET g_pk_array[2].values = g_apcf_d[l_ac].apcfdocno
   LET g_pk_array[2].column = 'apcfdocno'
   LET g_pk_array[3].values = g_apcf_d[l_ac].apcfseq
   LET g_pk_array[3].column = 'apcfseq'
   LET g_pk_array[4].values = g_apcf_d[l_ac].apcfseq2
   LET g_pk_array[4].column = 'apcfseq2'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt210_01.state_change" >}
   
 
{</section>}
 
{<section id="aapt210_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt210_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 暫估資料
# Memo...........:
# Date & Author..: 15/04/07 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt210_01_set_apcf008_detail()
DEFINE l_cmd         LIKE type_t.chr1
#DEFINE l_apca        RECORD LIKE apca_t.* #161104-00024#2 mark
#DEFINE l_apcc        RECORD LIKE apcc_t.* #161104-00024#2 mark
#DEFINE l_apcf        RECORD LIKE apcf_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE l_apca  RECORD  #應付憑單單頭
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
DEFINE l_apcc  RECORD  #應付多帳期檔
       apccent   LIKE apcc_t.apccent, #企業編號
       apccld    LIKE apcc_t.apccld, #帳套
       apcccomp  LIKE apcc_t.apcccomp, #法人
       apcclegl  LIKE apcc_t.apcclegl, #核算組織
       apccsite  LIKE apcc_t.apccsite, #帳務中心
       apccdocno LIKE apcc_t.apccdocno, #應付帳款單號碼
       apccseq   LIKE apcc_t.apccseq, #項次
       apcc001   LIKE apcc_t.apcc001, #分期帳款序
       apcc002   LIKE apcc_t.apcc002, #應付款別性質
       apcc003   LIKE apcc_t.apcc003, #應付款日
       apcc004   LIKE apcc_t.apcc004, #容許票據到期日
       apcc005   LIKE apcc_t.apcc005, #帳款起算日
       apcc006   LIKE apcc_t.apcc006, #正負值
       apcc007   LIKE apcc_t.apcc007, #原幣已請款金額
       apcc008   LIKE apcc_t.apcc008, #發票編號
       apcc009   LIKE apcc_t.apcc009, #發票號碼
       apcc010   LIKE apcc_t.apcc010, #發票日期
       apcc011   LIKE apcc_t.apcc011, #交易單據日期
       apcc012   LIKE apcc_t.apcc012, #立帳日期
       apcc013   LIKE apcc_t.apcc013, #交易認定日期
       apcc014   LIKE apcc_t.apcc014, #出入庫扣帳日期
       apcc100   LIKE apcc_t.apcc100, #交易原幣別
       apcc101   LIKE apcc_t.apcc101, #原幣匯率
       apcc102   LIKE apcc_t.apcc102, #原幣重估後匯率
       apcc103   LIKE apcc_t.apcc103, #NO USE
       apcc104   LIKE apcc_t.apcc104, #NO USE
       apcc105   LIKE apcc_t.apcc105, #NO USE
       apcc106   LIKE apcc_t.apcc106, #NO USE
       apcc107   LIKE apcc_t.apcc107, #NO USE
       apcc108   LIKE apcc_t.apcc108, #原幣應付金額
       apcc109   LIKE apcc_t.apcc109, #原幣付款沖帳金額
       apcc113   LIKE apcc_t.apcc113, #重評價調整數
       apcc114   LIKE apcc_t.apcc114, #NO USE
       apcc115   LIKE apcc_t.apcc115, #NO USE
       apcc116   LIKE apcc_t.apcc116, #NO USE
       apcc117   LIKE apcc_t.apcc117, #NO USE
       apcc118   LIKE apcc_t.apcc118, #本幣應付金額
       apcc119   LIKE apcc_t.apcc119, #本幣付款沖帳金額
       apcc120   LIKE apcc_t.apcc120, #本位幣二幣別
       apcc121   LIKE apcc_t.apcc121, #本位幣二匯率
       apcc122   LIKE apcc_t.apcc122, #本位幣二重估後匯率
       apcc123   LIKE apcc_t.apcc123, #重評價調整數
       apcc124   LIKE apcc_t.apcc124, #NO USE
       apcc125   LIKE apcc_t.apcc125, #NO USE
       apcc126   LIKE apcc_t.apcc126, #NO USE
       apcc127   LIKE apcc_t.apcc127, #NO USE
       apcc128   LIKE apcc_t.apcc128, #本位幣二應付金額
       apcc129   LIKE apcc_t.apcc129, #本位幣二付款沖帳金額
       apcc130   LIKE apcc_t.apcc130, #本位幣三幣別
       apcc131   LIKE apcc_t.apcc131, #本位幣三匯率
       apcc132   LIKE apcc_t.apcc132, #本位幣三重估後匯率
       apcc133   LIKE apcc_t.apcc133, #重評價調整數
       apcc134   LIKE apcc_t.apcc134, #NO USE
       apcc135   LIKE apcc_t.apcc135, #NO USE
       apcc136   LIKE apcc_t.apcc136, #NO USE
       apcc137   LIKE apcc_t.apcc137, #NO USE
       apcc138   LIKE apcc_t.apcc138, #本位幣三應付金額
       apcc139   LIKE apcc_t.apcc139, #本位幣三付款沖帳金額
       apccud001 LIKE apcc_t.apccud001, #自定義欄位(文字)001
       apccud002 LIKE apcc_t.apccud002, #自定義欄位(文字)002
       apccud003 LIKE apcc_t.apccud003, #自定義欄位(文字)003
       apccud004 LIKE apcc_t.apccud004, #自定義欄位(文字)004
       apccud005 LIKE apcc_t.apccud005, #自定義欄位(文字)005
       apccud006 LIKE apcc_t.apccud006, #自定義欄位(文字)006
       apccud007 LIKE apcc_t.apccud007, #自定義欄位(文字)007
       apccud008 LIKE apcc_t.apccud008, #自定義欄位(文字)008
       apccud009 LIKE apcc_t.apccud009, #自定義欄位(文字)009
       apccud010 LIKE apcc_t.apccud010, #自定義欄位(文字)010
       apccud011 LIKE apcc_t.apccud011, #自定義欄位(數字)011
       apccud012 LIKE apcc_t.apccud012, #自定義欄位(數字)012
       apccud013 LIKE apcc_t.apccud013, #自定義欄位(數字)013
       apccud014 LIKE apcc_t.apccud014, #自定義欄位(數字)014
       apccud015 LIKE apcc_t.apccud015, #自定義欄位(數字)015
       apccud016 LIKE apcc_t.apccud016, #自定義欄位(數字)016
       apccud017 LIKE apcc_t.apccud017, #自定義欄位(數字)017
       apccud018 LIKE apcc_t.apccud018, #自定義欄位(數字)018
       apccud019 LIKE apcc_t.apccud019, #自定義欄位(數字)019
       apccud020 LIKE apcc_t.apccud020, #自定義欄位(數字)020
       apccud021 LIKE apcc_t.apccud021, #自定義欄位(日期時間)021
       apccud022 LIKE apcc_t.apccud022, #自定義欄位(日期時間)022
       apccud023 LIKE apcc_t.apccud023, #自定義欄位(日期時間)023
       apccud024 LIKE apcc_t.apccud024, #自定義欄位(日期時間)024
       apccud025 LIKE apcc_t.apccud025, #自定義欄位(日期時間)025
       apccud026 LIKE apcc_t.apccud026, #自定義欄位(日期時間)026
       apccud027 LIKE apcc_t.apccud027, #自定義欄位(日期時間)027
       apccud028 LIKE apcc_t.apccud028, #自定義欄位(日期時間)028
       apccud029 LIKE apcc_t.apccud029, #自定義欄位(日期時間)029
       apccud030 LIKE apcc_t.apccud030, #自定義欄位(日期時間)030
       apcc015   LIKE apcc_t.apcc015, #付款條件
       apcc016   LIKE apcc_t.apcc016, #帳款類型
       apcc017   LIKE apcc_t.apcc017  #採購單號
           END RECORD
DEFINE l_apcf  RECORD  #應付沖暫估明細檔
       apcfent   LIKE apcf_t.apcfent, #企業編號
       apcfld    LIKE apcf_t.apcfld, #帳套
       apcforga  LIKE apcf_t.apcforga, #來源組織
       apcfdocno LIKE apcf_t.apcfdocno, #單號
       apcfseq   LIKE apcf_t.apcfseq, #項次
       apcfseq2  LIKE apcf_t.apcfseq2, #項次2
       apcf001   LIKE apcf_t.apcf001, #作業別
       apcf002   LIKE apcf_t.apcf002, #沖銷類型
       apcf007   LIKE apcf_t.apcf007, #沖銷數量
       apcf008   LIKE apcf_t.apcf008, #暫估單號碼
       apcf009   LIKE apcf_t.apcf009, #暫估單號項次
       apcf010   LIKE apcf_t.apcf010, #期別
       apcf020   LIKE apcf_t.apcf020, #稅別
       apcf021   LIKE apcf_t.apcf021, #待沖銷應付會科
       apcf022   LIKE apcf_t.apcf022, #待沖銷未稅會科
       apcf023   LIKE apcf_t.apcf023, #待沖銷稅額會科
       apcf024   LIKE apcf_t.apcf024, #沖銷價差科目
       apcf025   LIKE apcf_t.apcf025, #沖銷會差科目
       apcf026   LIKE apcf_t.apcf026, #業務部門
       apcf027   LIKE apcf_t.apcf027, #責任中心
       apcf028   LIKE apcf_t.apcf028, #區域
       apcf029   LIKE apcf_t.apcf029, #收付款客商
       apcf030   LIKE apcf_t.apcf030, #帳款客商
       apcf031   LIKE apcf_t.apcf031, #客群
       apcf032   LIKE apcf_t.apcf032, #產品類別
       apcf033   LIKE apcf_t.apcf033, #業務人員
       apcf034   LIKE apcf_t.apcf034, #專案編號
       apcf035   LIKE apcf_t.apcf035, #WBS
       apcf036   LIKE apcf_t.apcf036, #經營方式
       apcf037   LIKE apcf_t.apcf037, #通路
       apcf038   LIKE apcf_t.apcf038, #品牌
       apcf039   LIKE apcf_t.apcf039, #自由核算項一
       apcf040   LIKE apcf_t.apcf040, #自由核算項二
       apcf041   LIKE apcf_t.apcf041, #自由核算項三
       apcf042   LIKE apcf_t.apcf042, #自由核算項四
       apcf043   LIKE apcf_t.apcf043, #自由核算項五
       apcf044   LIKE apcf_t.apcf044, #自由核算項六
       apcf045   LIKE apcf_t.apcf045, #自由核算項七
       apcf046   LIKE apcf_t.apcf046, #自由核算項八
       apcf047   LIKE apcf_t.apcf047, #自由核算項九
       apcf048   LIKE apcf_t.apcf048, #自由核算項十
       apcf049   LIKE apcf_t.apcf049, #摘要
       apcf101   LIKE apcf_t.apcf101, #原幣單價
       apcf102   LIKE apcf_t.apcf102, #原幣匯率
       apcf103   LIKE apcf_t.apcf103, #原幣未稅金額
       apcf104   LIKE apcf_t.apcf104, #原幣稅額
       apcf105   LIKE apcf_t.apcf105, #原幣含稅金額
       apcf106   LIKE apcf_t.apcf106, #原幣沖銷差異金額
       apcf111   LIKE apcf_t.apcf111, #本幣單價
       apcf113   LIKE apcf_t.apcf113, #本幣未稅金額
       apcf114   LIKE apcf_t.apcf114, #本幣稅額
       apcf115   LIKE apcf_t.apcf115, #本幣含稅金額
       apcf116   LIKE apcf_t.apcf116, #本幣價差金額
       apcf117   LIKE apcf_t.apcf117, #本幣匯差金額
       apcf122   LIKE apcf_t.apcf122, #暫估本未幣二匯率
       apcf123   LIKE apcf_t.apcf123, #本位幣二未稅金額
       apcf124   LIKE apcf_t.apcf124, #本位幣二稅額
       apcf125   LIKE apcf_t.apcf125, #本位幣二含稅金額
       apcf126   LIKE apcf_t.apcf126, #本位幣二價格差異金額
       apcf127   LIKE apcf_t.apcf127, #本位幣二匯差
       apcf132   LIKE apcf_t.apcf132, #暫估本位幣三匯率
       apcf133   LIKE apcf_t.apcf133, #本位幣三未稅金額
       apcf134   LIKE apcf_t.apcf134, #本位幣三稅額
       apcf135   LIKE apcf_t.apcf135, #本位幣三含稅金額
       apcf136   LIKE apcf_t.apcf136, #本位幣三價格差異金額
       apcf137   LIKE apcf_t.apcf137, #本位幣三匯差
       apcfud001 LIKE apcf_t.apcfud001, #自定義欄位(文字)001
       apcfud002 LIKE apcf_t.apcfud002, #自定義欄位(文字)002
       apcfud003 LIKE apcf_t.apcfud003, #自定義欄位(文字)003
       apcfud004 LIKE apcf_t.apcfud004, #自定義欄位(文字)004
       apcfud005 LIKE apcf_t.apcfud005, #自定義欄位(文字)005
       apcfud006 LIKE apcf_t.apcfud006, #自定義欄位(文字)006
       apcfud007 LIKE apcf_t.apcfud007, #自定義欄位(文字)007
       apcfud008 LIKE apcf_t.apcfud008, #自定義欄位(文字)008
       apcfud009 LIKE apcf_t.apcfud009, #自定義欄位(文字)009
       apcfud010 LIKE apcf_t.apcfud010, #自定義欄位(文字)010
       apcfud011 LIKE apcf_t.apcfud011, #自定義欄位(數字)011
       apcfud012 LIKE apcf_t.apcfud012, #自定義欄位(數字)012
       apcfud013 LIKE apcf_t.apcfud013, #自定義欄位(數字)013
       apcfud014 LIKE apcf_t.apcfud014, #自定義欄位(數字)014
       apcfud015 LIKE apcf_t.apcfud015, #自定義欄位(數字)015
       apcfud016 LIKE apcf_t.apcfud016, #自定義欄位(數字)016
       apcfud017 LIKE apcf_t.apcfud017, #自定義欄位(數字)017
       apcfud018 LIKE apcf_t.apcfud018, #自定義欄位(數字)018
       apcfud019 LIKE apcf_t.apcfud019, #自定義欄位(數字)019
       apcfud020 LIKE apcf_t.apcfud020, #自定義欄位(數字)020
       apcfud021 LIKE apcf_t.apcfud021, #自定義欄位(日期時間)021
       apcfud022 LIKE apcf_t.apcfud022, #自定義欄位(日期時間)022
       apcfud023 LIKE apcf_t.apcfud023, #自定義欄位(日期時間)023
       apcfud024 LIKE apcf_t.apcfud024, #自定義欄位(日期時間)024
       apcfud025 LIKE apcf_t.apcfud025, #自定義欄位(日期時間)025
       apcfud026 LIKE apcf_t.apcfud026, #自定義欄位(日期時間)026
       apcfud027 LIKE apcf_t.apcfud027, #自定義欄位(日期時間)027
       apcfud028 LIKE apcf_t.apcfud028, #自定義欄位(日期時間)028
       apcfud029 LIKE apcf_t.apcfud029, #自定義欄位(日期時間)029
       apcfud030 LIKE apcf_t.apcfud030  #自定義欄位(日期時間)030
           END RECORD
#161104-00024#2-add(e)
DEFINE l_type        LIKE type_t.chr1
DEFINE l_flag        LIKE type_t.chr1
DEFINE l_sql         STRING

   IF cl_null(g_apcf_d[l_ac].apcf008) OR cl_null(g_apcf_d[l_ac].apcf009) OR cl_null(g_apcf_d[l_ac].apcf010) THEN
      RETURN
   END IF
   
   IF g_apcf_d[l_ac].apcf008 = 'DIFF' THEN
      RETURN
   END IF
   
   CALL g_apcf_tmp.clear()
   IF NOT g_apcf_d[l_ac].apca001 MATCHES '0[34]' THEN
      LET l_type = 1
   ELSE
      LET l_type = 2
   END IF
   
   #LET l_sql = "SELECT apca_t.*,apcc_t.* ",   #161208-00026#5 mark
   #161208-00026#5-add(s)
   LET l_sql = "SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,
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
                       apca070,apca071,apca072,apca073,apccent,
                       apccld,apcccomp,apcclegl,apccsite,apccdocno,
                       apccseq,apcc001,apcc002,apcc003,apcc004,
                       apcc005,apcc006,apcc007,apcc008,apcc009,
                       apcc010,apcc011,apcc012,apcc013,apcc014,
                       apcc100,apcc101,apcc102,apcc103,apcc104,
                       apcc105,apcc106,apcc107,apcc108,apcc109,
                       apcc113,apcc114,apcc115,apcc116,apcc117,
                       apcc118,apcc119,apcc120,apcc121,apcc122,
                       apcc123,apcc124,apcc125,apcc126,apcc127,
                       apcc128,apcc129,apcc130,apcc131,apcc132,
                       apcc133,apcc134,apcc135,apcc136,apcc137,
                       apcc138,apcc139,apccud001,apccud002,apccud003,
                       apccud004,apccud005,apccud006,apccud007,apccud008,
                       apccud009,apccud010,apccud011,apccud012,apccud013,
                       apccud014,apccud015,apccud016,apccud017,apccud018,
                       apccud019,apccud020,apccud021,apccud022,apccud023,
                       apccud024,apccud025,apccud026,apccud027,apccud028,
                       apccud029,apccud030,apcc015,apcc016,apcc017 ", 
   #161208-00026#5-add(e)
                "    FROM apca_t,apcc_t",
                "   WHERE apcaent = apccent AND apcald = apccld ",
                "     AND apcadocno = apccdocno AND apcc108 - apcc109 <> 0 ",
                "     AND apcaent = ",g_enterprise," AND apcald = '",g_apcald,"'",
                "     AND apcadocno='",g_apcf_d[l_ac].apcf008,"'",
                "     AND apccseq = '",g_apcf_d[l_ac].apcf009,"'",
                "     AND apcc001 = '",g_apcf_d[l_ac].apcf010,"'"
                
   PREPARE aapt210_01_get_apcf_p1 FROM l_sql
   DECLARE aapt210_01_get_apcf_c1 CURSOR FOR aapt210_01_get_apcf_p1   
   OPEN  aapt210_01_get_apcf_c1
   #FETCH aapt210_01_get_apcf_c1 INTO l_apca.*,l_apcc.*    #取得t320的暫估資料   #161208-00026#5 mark
   #161208-00026#5-add(s)
   FETCH aapt210_01_get_apcf_c1 INTO l_apca.apcaent,l_apca.apcaownid,l_apca.apcaowndp,l_apca.apcacrtid,l_apca.apcacrtdp,
                                     l_apca.apcacrtdt,l_apca.apcamodid,l_apca.apcamoddt,l_apca.apcacnfid,l_apca.apcacnfdt,
                                     l_apca.apcapstid,l_apca.apcapstdt,l_apca.apcastus,l_apca.apcald,l_apca.apcacomp,
                                     l_apca.apcadocno,l_apca.apcadocdt,l_apca.apcasite,l_apca.apca001,l_apca.apca003,
                                     l_apca.apca004,l_apca.apca005,l_apca.apca006,l_apca.apca007,l_apca.apca008,
                                     l_apca.apca009,l_apca.apca010,l_apca.apca011,l_apca.apca012,l_apca.apca013,
                                     l_apca.apca014,l_apca.apca015,l_apca.apca016,l_apca.apca017,l_apca.apca018,
                                     l_apca.apca019,l_apca.apca020,l_apca.apca021,l_apca.apca022,l_apca.apca025,
                                     l_apca.apca026,l_apca.apca027,l_apca.apca028,l_apca.apca029,l_apca.apca030,
                                     l_apca.apca031,l_apca.apca032,l_apca.apca033,l_apca.apca034,l_apca.apca035,
                                     l_apca.apca036,l_apca.apca037,l_apca.apca038,l_apca.apca039,l_apca.apca040,
                                     l_apca.apca041,l_apca.apca042,l_apca.apca043,l_apca.apca044,l_apca.apca045,
                                     l_apca.apca046,l_apca.apca047,l_apca.apca048,l_apca.apca049,l_apca.apca050,
                                     l_apca.apca051,l_apca.apca052,l_apca.apca053,l_apca.apca054,l_apca.apca055,
                                     l_apca.apca056,l_apca.apca057,l_apca.apca058,l_apca.apca059,l_apca.apca060,
                                     l_apca.apca061,l_apca.apca062,l_apca.apca063,l_apca.apca064,l_apca.apca065,
                                     l_apca.apca066,l_apca.apca100,l_apca.apca101,l_apca.apca103,l_apca.apca104,
                                     l_apca.apca106,l_apca.apca107,l_apca.apca108,l_apca.apca113,l_apca.apca114,
                                     l_apca.apca116,l_apca.apca117,l_apca.apca118,l_apca.apca120,l_apca.apca121,
                                     l_apca.apca123,l_apca.apca124,l_apca.apca126,l_apca.apca127,l_apca.apca128,
                                     l_apca.apca130,l_apca.apca131,l_apca.apca133,l_apca.apca134,l_apca.apca136,
                                     l_apca.apca137,l_apca.apca138,l_apca.apcaud001,l_apca.apcaud002,l_apca.apcaud003,
                                     l_apca.apcaud004,l_apca.apcaud005,l_apca.apcaud006,l_apca.apcaud007,l_apca.apcaud008,
                                     l_apca.apcaud009,l_apca.apcaud010,l_apca.apcaud011,l_apca.apcaud012,l_apca.apcaud013,
                                     l_apca.apcaud014,l_apca.apcaud015,l_apca.apcaud016,l_apca.apcaud017,l_apca.apcaud018,
                                     l_apca.apcaud019,l_apca.apcaud020,l_apca.apcaud021,l_apca.apcaud022,l_apca.apcaud023,
                                     l_apca.apcaud024,l_apca.apcaud025,l_apca.apcaud026,l_apca.apcaud027,l_apca.apcaud028,
                                     l_apca.apcaud029,l_apca.apcaud030,l_apca.apca067,l_apca.apca068,l_apca.apca069,
                                     l_apca.apca070,l_apca.apca071,l_apca.apca072,l_apca.apca073,l_apcc.apccent,
                                     l_apcc.apccld,l_apcc.apcccomp,l_apcc.apcclegl,l_apcc.apccsite,l_apcc.apccdocno,
                                     l_apcc.apccseq,l_apcc.apcc001,l_apcc.apcc002,l_apcc.apcc003,l_apcc.apcc004,
                                     l_apcc.apcc005,l_apcc.apcc006,l_apcc.apcc007,l_apcc.apcc008,l_apcc.apcc009,
                                     l_apcc.apcc010,l_apcc.apcc011,l_apcc.apcc012,l_apcc.apcc013,l_apcc.apcc014,
                                     l_apcc.apcc100,l_apcc.apcc101,l_apcc.apcc102,l_apcc.apcc103,l_apcc.apcc104,
                                     l_apcc.apcc105,l_apcc.apcc106,l_apcc.apcc107,l_apcc.apcc108,l_apcc.apcc109,
                                     l_apcc.apcc113,l_apcc.apcc114,l_apcc.apcc115,l_apcc.apcc116,l_apcc.apcc117,
                                     l_apcc.apcc118,l_apcc.apcc119,l_apcc.apcc120,l_apcc.apcc121,l_apcc.apcc122,
                                     l_apcc.apcc123,l_apcc.apcc124,l_apcc.apcc125,l_apcc.apcc126,l_apcc.apcc127,
                                     l_apcc.apcc128,l_apcc.apcc129,l_apcc.apcc130,l_apcc.apcc131,l_apcc.apcc132,
                                     l_apcc.apcc133,l_apcc.apcc134,l_apcc.apcc135,l_apcc.apcc136,l_apcc.apcc137,
                                     l_apcc.apcc138,l_apcc.apcc139,l_apcc.apccud001,l_apcc.apccud002,l_apcc.apccud003,
                                     l_apcc.apccud004,l_apcc.apccud005,l_apcc.apccud006,l_apcc.apccud007,l_apcc.apccud008,
                                     l_apcc.apccud009,l_apcc.apccud010,l_apcc.apccud011,l_apcc.apccud012,l_apcc.apccud013,
                                     l_apcc.apccud014,l_apcc.apccud015,l_apcc.apccud016,l_apcc.apccud017,l_apcc.apccud018,
                                     l_apcc.apccud019,l_apcc.apccud020,l_apcc.apccud021,l_apcc.apccud022,l_apcc.apccud023,
                                     l_apcc.apccud024,l_apcc.apccud025,l_apcc.apccud026,l_apcc.apccud027,l_apcc.apccud028,
                                     l_apcc.apccud029,l_apcc.apccud030,l_apcc.apcc015,l_apcc.apcc016,l_apcc.apcc017  
#161208-00026#5-add(e)
   CALL s_aapp831_get_apcf(g_apcald,g_apcadocno,l_type,l_apca.*,l_apcc.*) RETURNING l_flag,l_apcf.*,g_apcf_tmp
   IF l_flag MATCHES '[12]' THEN RETURN END IF
   LET g_apcf2_d[l_ac].apcforga= l_apcf.apcforga
   LET g_apcf_d[l_ac].apcfld   = l_apcf.apcfld
   LET g_apcf_d[l_ac].apcfdocno= l_apcf.apcfdocno
   LET g_apcf_d[l_ac].apcfseq  = l_apcf.apcfseq
   LET g_apcf_d[l_ac].apcfseq2 = l_apcf.apcfseq2
   LET g_apcf_d[l_ac].apcf007  = l_apcf.apcf007
   LET g_apcf_d[l_ac].apcf010  = l_apcf.apcf010
   LET g_apcf_d[l_ac].apcf020  = l_apcf.apcf020
   LET g_apcf_d[l_ac].apcf021  = l_apcf.apcf021
   LET g_apcf_d[l_ac].apcf022  = l_apcf.apcf022
   LET g_apcf_d[l_ac].apcf023  = l_apcf.apcf023
   LET g_apcf2_d[l_ac].apcf026 = l_apcf.apcf026
   LET g_apcf2_d[l_ac].apcf027 = l_apcf.apcf027
   LET g_apcf2_d[l_ac].apcf028 = l_apcf.apcf028
   LET g_apcf2_d[l_ac].apcf029 = l_apcf.apcf029
   LET g_apcf2_d[l_ac].apcf030 = l_apcf.apcf030
   LET g_apcf2_d[l_ac].apcf031 = l_apcf.apcf031
   LET g_apcf2_d[l_ac].apcf032 = l_apcf.apcf032
   LET g_apcf2_d[l_ac].apcf033 = l_apcf.apcf033
   LET g_apcf2_d[l_ac].apcf034 = l_apcf.apcf034
   LET g_apcf2_d[l_ac].apcf035 = l_apcf.apcf035
   LET g_apcf2_d[l_ac].apcf036 = l_apcf.apcf036
   LET g_apcf2_d[l_ac].apcf037 = l_apcf.apcf037
   LET g_apcf2_d[l_ac].apcf038 = l_apcf.apcf038
   LET g_apcf2_d[l_ac].apcf039 = l_apcf.apcf039
   LET g_apcf2_d[l_ac].apcf040 = l_apcf.apcf040
   LET g_apcf2_d[l_ac].apcf041 = l_apcf.apcf041
   LET g_apcf2_d[l_ac].apcf042 = l_apcf.apcf042
   LET g_apcf2_d[l_ac].apcf043 = l_apcf.apcf043
   LET g_apcf2_d[l_ac].apcf044 = l_apcf.apcf044
   LET g_apcf2_d[l_ac].apcf045 = l_apcf.apcf045
   LET g_apcf2_d[l_ac].apcf046 = l_apcf.apcf046
   LET g_apcf2_d[l_ac].apcf047 = l_apcf.apcf047
   LET g_apcf2_d[l_ac].apcf048 = l_apcf.apcf048
   LET g_apcf_d[l_ac].apcf101  = l_apcf.apcf101
   LET g_apcf_d[l_ac].apcf102  = l_apcf.apcf102
   LET g_apcf_d[l_ac].apcf103  = l_apcf.apcf103
   LET g_apcf_d[l_ac].apcf104  = l_apcf.apcf104
   LET g_apcf_d[l_ac].apcf105  = l_apcf.apcf105
   LET g_apcf_d[l_ac].apcf113  = l_apcf.apcf113
   LET g_apcf_d[l_ac].apcf114  = l_apcf.apcf114
   LET g_apcf_d[l_ac].apcf115  = l_apcf.apcf115
   LET g_apcf_d[l_ac].l_apcf021_desc  = s_desc_get_account_desc(g_apcald,g_apcf_d[l_ac].apcf021)
   DISPLAY BY NAME g_apcf_d[l_ac].apcfseq,g_apcf_d[l_ac].apcf007,g_apcf_d[l_ac].apcf021,g_apcf_d[l_ac].l_apcf021_desc,
                   g_apcf_d[l_ac].apcf101,g_apcf_d[l_ac].apcf102,g_apcf_d[l_ac].apcf103,g_apcf_d[l_ac].apcf104,g_apcf_d[l_ac].apcf105,
                   g_apcf_d[l_ac].apcf113,g_apcf_d[l_ac].apcf114,g_apcf_d[l_ac].apcf115

   CALL aapt210_01_set_entry_b(l_cmd)
   CALL aapt210_01_set_no_entry_b(l_cmd)
   


























































































END FUNCTION

################################################################################
# Descriptions...: 可沖金額是否超出
# Date & Author..: 15/04/21 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt210_01_chk_amt()
DEFINE l_apcc108        LIKE apcc_t.apcc108
DEFINE l_apcc118        LIKE apcc_t.apcc118
DEFINE l_apcc128        LIKE apcc_t.apcc128
DEFINE l_apcc138        LIKE apcc_t.apcc138
DEFINE l_apcc109        LIKE apcc_t.apcc109
DEFINE l_apcc119        LIKE apcc_t.apcc119
DEFINE l_apcc129        LIKE apcc_t.apcc129
DEFINE l_apcc139        LIKE apcc_t.apcc139
DEFINE l_apcf105        LIKE apcf_t.apcf105
DEFINE l_apcf115        LIKE apcf_t.apcf115
DEFINE l_apcf125        LIKE apcf_t.apcf125
DEFINE l_apcf135        LIKE apcf_t.apcf135
DEFINE l_apcf1051       LIKE apcf_t.apcf105
DEFINE l_apcf1151       LIKE apcf_t.apcf115
DEFINE l_apcf1251       LIKE apcf_t.apcf125
DEFINE l_apcf1351       LIKE apcf_t.apcf135
DEFINE l_errno          LIKE gzze_t.gzze001 

   WHENEVER ERROR CONTINUE
   IF g_apcf_d[l_ac].apcf008 = 'DIFF' THEN RETURN END IF
   LET l_errno = ''
   LET l_apcc108 = 0 LET l_apcc118 = 0   LET l_apcc128 = 0   LET l_apcc138 = 0
   LET l_apcc109 = 0 LET l_apcc119 = 0   LET l_apcc129 = 0   LET l_apcc139 = 0
   LET l_apcf105 = 0 LET l_apcf115 = 0   LET l_apcf125 = 0   LET l_apcf135 = 0
   LET l_apcf1051= 0 LET l_apcf1151= 0   LET l_apcf1251= 0   LET l_apcf1351= 0
   
   SELECT (apcc108 - apcc109),(apcc118 - apcc119),(apcc128 - apcc129),(apcc138 - apcc139)
     INTO l_apcc108,l_apcc118,l_apcc128,l_apcc138
     FROM apcc_t
    WHERE apccent = g_enterprise 
      AND apccld  = g_apcald AND apccdocno = g_apcf_d[l_ac].apcf008
      AND apccseq = g_apcf_d[l_ac].apcf009
      AND apcc001 = g_apcf_d[l_ac].apcf010
   
   #取得未確認的有效單據apcf的金額
   SELECT apcf105,apcf115,apcf125,apcf135
     INTO l_apcf105,l_apcf115,l_apcf125,l_apcf135
     FROM apca_t,apcf_t 
    WHERE apcaent = apcfent AND apcadocno = apcfdocno
      AND apcald  = apcfld  AND apcastus NOT IN ('Y','X')
      AND apcaent = g_enterprise
      AND apcald  = g_apcald
      AND apcf008 = g_apcf_d[l_ac].apcf008
      AND apcf009 = g_apcf_d[l_ac].apcf009
      AND apcf010 = g_apcf_d[l_ac].apcf010
   
   #取得目前這一筆資料在DB的金額
   SELECT apcf105,apcf115,apcf125,apcf135
     INTO l_apcf1051,l_apcf1151,l_apcf1251,l_apcf1351
     FROM apca_t,apcf_t 
    WHERE apcaent = apcfent AND apcadocno = apcfdocno
      AND apcald  = apcfld  
      AND apcaent = g_enterprise
      AND apcald  = g_apcald AND apcadocno = g_apcadocno
      AND apcfseq = g_apcf_d[l_ac].apcfseq
   
   IF cl_null(l_apcc108)  THEN LET l_apcc108 = 0 END IF
   IF cl_null(l_apcc118)  THEN LET l_apcc118 = 0 END IF
   IF cl_null(l_apcc128)  THEN LET l_apcc128 = 0 END IF
   IF cl_null(l_apcc138)  THEN LET l_apcc138 = 0 END IF
   IF cl_null(l_apcf105)  THEN LET l_apcf105 = 0 END IF
   IF cl_null(l_apcf115)  THEN LET l_apcf115 = 0 END IF
   IF cl_null(l_apcf125)  THEN LET l_apcf125 = 0 END IF
   IF cl_null(l_apcf135)  THEN LET l_apcf135 = 0 END IF
   IF cl_null(l_apcf1051) THEN LET l_apcf1051= 0 END IF
   IF cl_null(l_apcf1151) THEN LET l_apcf1151= 0 END IF
   IF cl_null(l_apcf1251) THEN LET l_apcf1251= 0 END IF
   IF cl_null(l_apcf1351) THEN LET l_apcf1351= 0 END IF
   LET l_apcc109 = l_apcc108 - l_apcf105 + l_apcf1051
   LET l_apcc119 = l_apcc118 - l_apcf115 + l_apcf1151
   LET l_apcc129 = l_apcc128 - l_apcf125 + l_apcf1251
   LET l_apcc139 = l_apcc138 - l_apcf135 + l_apcf1351
   
   CASE
      WHEN INFIELD (apcf103)
         IF g_apcf_d[l_ac].apcf103 > l_apcc109 THEN
            LET l_errno = "axr-00054"
            LET g_apcf_d[l_ac].apcf103 = l_apcc109
            DISPLAY BY NAME g_apcf_d[l_ac].apcf103
         END IF
         
      WHEN INFIELD (apcf105)
         IF g_apcf_d[l_ac].apcf105 > l_apcc109 THEN
            LET l_errno = "axr-00054"
            LET g_apcf_d[l_ac].apcf105 = l_apcc109
            DISPLAY BY NAME g_apcf_d[l_ac].apcf105
         END IF
      
      WHEN INFIELD (apcf113)
         IF g_apcf_d[l_ac].apcf113 > l_apcc119 THEN
            LET l_errno = "axr-00054"
            LET g_apcf_d[l_ac].apcf113 = l_apcc119
            DISPLAY BY NAME g_apcf_d[l_ac].apcf113
         END IF      
      
      WHEN INFIELD (apcf115)
         IF g_apcf_d[l_ac].apcf115 > l_apcc119 THEN
            LET l_errno = "axr-00054"
            LET g_apcf_d[l_ac].apcf115 = l_apcc119
            DISPLAY BY NAME g_apcf_d[l_ac].apcf115
         END IF
      WHEN INFIELD (apcf125)
      WHEN INFIELD (apcf135)
      
   END CASE
   IF NOT cl_null(l_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.popup = TRUE
      CALL cl_err()   
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 檢核單據是否重複
# Memo...........:
# Date & Author..: 15/05/05 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt210_01_chk_docno()
DEFINE l_cnt1           LIKE type_t.num5
DEFINE l_cnt2           LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_errno   = ''
   IF g_apcf_d[l_ac].apcf008 = 'DIFF' THEN
      RETURN r_success,r_errno
   END IF
   IF cl_null(g_apcf_d[l_ac].apcf008) OR cl_null(g_apcf_d[l_ac].apcf009) OR cl_null(g_apcf_d[l_ac].apcf010) THEN
      RETURN r_success,r_errno
   END IF
   LET l_cnt1 = 0
   LET l_cnt2 = 0
   
   SELECT count(*) INTO l_cnt1
     FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccld  = g_apcald 
      AND apccdocno = g_apcf_d[l_ac].apcf008
      AND apccseq = g_apcf_d[l_ac].apcf009
      AND apcc001 = g_apcf_d[l_ac].apcf010
   IF l_cnt1 = 0 THEN
      LET r_success = FALSE 
      LET r_errno = 'aap-00313'
      RETURN r_success,r_errno
   END IF
   SELECT count(*) INTO l_cnt1
     FROM apcf_t
    WHERE apcfent = g_enterprise 
      AND apcfld  = g_apcald AND apcfdocno = g_apcadocno
      AND apcf008 = g_apcf_d[l_ac].apcf008
      AND apcf009 = g_apcf_d[l_ac].apcf009
      AND apcf010 = g_apcf_d[l_ac].apcf010
      
   SELECT count(*) INTO l_cnt2
     FROM apcf_t
    WHERE apcfent = g_enterprise 
      AND apcfld  = g_apcald AND apcfdocno = g_apcadocno
      AND apcfseq = g_apcf_d[l_ac].apcfseq
      AND apcfseq2= g_apcf_d[l_ac].apcfseq2
      AND apcf008 = g_apcf_d[l_ac].apcf008
      AND apcf009 = g_apcf_d[l_ac].apcf009
      AND apcf010 = g_apcf_d[l_ac].apcf010
      
   IF l_cnt1 - l_cnt2 > 1 THEN
      LET r_success = FALSE 
      LET r_errno   = 'aap-00214'
      RETURN r_success,r_errno
   END IF
   CASE g_apcf_d[l_ac].apca001
        WHEN '03'
           SELECT count(*) INTO l_cnt1
             FROM apca_t,apcb_t,apcc_t
            WHERE apcaent = apcbent AND apcaent = apccent AND apcald = apcbld AND apcald = apccld
              AND apcadocno = apcbdocno AND apcadocno = apccdocno AND apcc108 - apcc109 <> 0
              AND apca001 IN('03','04') AND apcastus = 'Y' 
              AND apcb002 IS NULL AND apcb003 IS NULL
              AND apcaent = g_enterprise AND apcald = g_apcald
              AND apca004 = g_apca.apca004    AND apca005= g_apca.apca005
              AND apcb001 = '19'
        WHEN '04'
           SELECT count(*) INTO l_cnt1
             FROM apca_t,apcb_t,apcc_t
            WHERE apcaent = apcbent AND apcaent = apccent AND apcald = apcbld AND apcald = apccld
              AND apcadocno = apcbdocno AND apcadocno = apccdocno AND apcc108 - apcc109 <> 0
              AND apca001 IN('03','04') AND apcastus = 'Y' 
              AND apcb002 IS NULL AND apcb003 IS NULL
              AND apcaent = g_enterprise AND apcald = g_apcald
              AND apca004 = g_apca.apca004    AND apca005= g_apca.apca005
              AND apcb001 = '29'
        OTHERWISE
            SELECT count(*) INTO l_cnt1
              FROM apca_t,apcb_t,apcc_t
             WHERE apcaent = apcbent AND apcaent = apccent AND apcald = apcbld AND apcald = apccld 
               AND apcadocno=apcbdocno AND apcadocno = apccdocno AND apcc108 - apcc109 <> 0 
               AND apcastus = 'Y'      AND apca001 IN ('01','02') 
               AND apcb002 IS NOT NULL AND apcb003 IS NOT NULL 
               AND apcaent = g_enterprise AND apcald = g_apcald
               AND apcbdocno= g_apcf_d[l_ac].apcf008 AND apcbseq= g_apcf_d[l_ac].apcf009
   END CASE
   
   IF l_cnt1 = 0 THEN
      LET r_success = FALSE 
      LET r_errno   = 'aap-00213'
      RETURN r_success,r_errno
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
