#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0037(2015-11-05 13:41:49), PR版次:0037(2017-02-20 10:08:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000257
#+ Filename...: aapt300_03
#+ Description: 進項發票資訊
#+ Creator....: 01727(2014-02-10 15:23:54)
#+ Modifier...: 05016 -SD/PR- 05634
 
{</section>}
 
{<section id="aapt300_03.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150915                      By Hans      取位
#150925           2015/09/25 By Reanna    新增發票資訊應把買受人統一編號寫入isam017
#150925-00029#1   2015/10/06 By Hans      新增狀態下,查詢發票類型沒有資料,但在修改模式下查詢可查到發票類型.
#151013-00016#5   2015/10/22 By Hans      1. aapt300/aapt340可修改發票內容，但不可新增刪除 
#151022           2015/10/22 By Hans      小數位數
#1511055          2015/11/05 By Hans      修改金額時，稅別含稅否，判斷重計稅，或是重推金額。
#151112           2015/11/12 By 03538     判斷isam是否重複,應排除作廢情況者
#151013-00016#14  2015/12/03 By Hans      1.AP的進項發票輸入時, 扣抵代碼依照發票類型aisi030判斷, 若媒體申報格式為空白isac004, 則扣抵代碼default為’3.不可扣抵
#151218-00009#1   2015/12/22 By 02097     若金額開放修改會造成原對帳單與發票金額不和情況。
#160107-00004#3   2016/01/07 By Reanna    進項發票號碼檢核是否重覆，邏輯調整
#160127           2016/01/27 By albireo   無單,針對原幣本幣等欄位增加_o邏輯(應用原有的_t做)
#160321-00016#20  2016/03/23 By Jessy     修正azzi920重複定義之錯誤訊息
#160419-00022#1   2016/04/22 By catmoon   依含稅否(isam0121)調整原幣未稅金額(isam023)與原幣含稅金額(isam025)輸入順序
#160705-00042#11  2016/07/14 By sakura    程式中寫死g_prog部分改寫MATCHES方式
#160825-00039#1   2016/08/29 By 00768     检查发票号码的前两位在aisi040中是否有效存在
#160905-00002#1   2016/09/05 By Reanna    SQL條件少ENT補上
#160902-00034#1   2016/09/10 By Hans    　開放進項發票輸入
#160923-00045#1   2016/09/26 By dorishsu  AFTER FIELD isam010,增加判斷isac008 != '4'(收據),再呼叫aapt300_03_isad005_chk檢查發票字軌
#161018-00022#1   2016/10/19 By 06821     aapt310維護完發票明細後,應回寫單頭apca066發票號碼.
#161019-00054#1   2016/10/19 By 06821     發票明細回寫單頭apca066發票號碼時,應一併處理pca065發票代碼
#161021-00039#1   2016/10/24 By dorishsu  1.台灣發票，除了檢查2碼英文字軌外，應也要檢查後8碼是數字 2.台灣發票檢查稅務編號不可為空
#161024-00066#1   2016/11/02 By 00768     aapt301 發票明細輸入,要挑選[發票類型]開窗的選項应满足稅區的設定aisi030
#161101-00070#1   2016/11/04 By 06821     发票明细页签的发票类型isam008查詢時开窗增加稅區條件(以g_site對應組織基本資料設定之稅區做為條件)
#161108-00017#3   2016/11/09 By Reanna    程式中INSERT INTO 有星號作整批調整
#161104-00024#2   2016/11/10 By 08729     處理DEFINE有星號
#161019-00030#1   161116     By albireo   發票號碼重複檢查,
#161006-00011#2   161116     By albireo   撈單身所有採購單,發票日期不可小於最小採購日
#161124-00019#1   161124     By albireo   統編檢核應卡無統編的狀況才做檢核
#161115-00002#1   2016/11/24 By dorishsu  1.台灣發票,如果發票格式是28,29海關類,長度是14,前3碼是英文 2.發票格式為28/29海關繳納憑證,不需檢查字軌
#161127-00003#1   2016/12/02 By 06948     發票類型開窗(q_isac002)條件增加僅列出進項發票的條件( isac003 in('1','3') )
#161208-00026#6   2016/12/12 By 08729     針對SELECT有星號的部分進行展開
#161129-00042#1   2016/12/19 By 08729     增加營利事業統一編號檢查
#161223-00014#1   2016/12/28 By Yiting    發票信息頁籤維護後應回寫發票號碼/發票編號
#161229-00029#1   161229     By albireo   isam036應依帳款單性質給值 2* 給21  其他給11
#isam008發票類型  應依帳款單性質限制   2*  只能選到isac003 = '3'     其他只能選isac003 = '1'
#161230-00036#1   2017/01/05 By 08729     當發票類型非為收據類或沒有媒體申報格式時，統一編號未必輸欄位，將客戶家有問題的sub展開
#170218-00012#1   2017/02/18 By dorishsu  媒體申報格式(isac004)如為28,29則不控卡統一編號必輸
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT FGL lib_cl_dlg
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_isam_d RECORD
       isam001 LIKE isam_t.isam001, 
   isamdocno LIKE isam_t.isamdocno, 
   isamseq LIKE isam_t.isamseq, 
   isam008 LIKE isam_t.isam008, 
   isam037 LIKE isam_t.isam037, 
   isam011 LIKE isam_t.isam011, 
   isam010 LIKE isam_t.isam010, 
   isam030 LIKE isam_t.isam030, 
   isam009 LIKE isam_t.isam009, 
   isam012 LIKE isam_t.isam012, 
   isam012_desc_desc LIKE type_t.chr500, 
   isam0121 LIKE isam_t.isam0121, 
   isam013 LIKE isam_t.isam013, 
   isam014 LIKE isam_t.isam014, 
   isam015 LIKE isam_t.isam015, 
   isam023 LIKE isam_t.isam023, 
   isam024 LIKE isam_t.isam024, 
   isam025 LIKE isam_t.isam025, 
   isam026 LIKE isam_t.isam026, 
   isam027 LIKE isam_t.isam027, 
   isam028 LIKE isam_t.isam028, 
   isamcomp LIKE isam_t.isamcomp, 
   isamstus LIKE isam_t.isamstus, 
   isam002 LIKE isam_t.isam002, 
   isam004 LIKE isam_t.isam004, 
   isam016 LIKE isam_t.isam016, 
   isam017 LIKE isam_t.isam017, 
   isam018 LIKE isam_t.isam018, 
   isam019 LIKE isam_t.isam019, 
   isam020 LIKE isam_t.isam020, 
   isam021 LIKE isam_t.isam021, 
   isam022 LIKE isam_t.isam022, 
   isam029 LIKE isam_t.isam029, 
   isam031 LIKE isam_t.isam031, 
   isam032 LIKE isam_t.isam032, 
   isam033 LIKE isam_t.isam033, 
   isam034 LIKE isam_t.isam034, 
   isam038 LIKE isam_t.isam038, 
   isam039 LIKE isam_t.isam039
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_apca_t            RECORD LIKE apca_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE g_apca_t  RECORD  #應付憑單單頭
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
DEFINE g_glaa_t            RECORD
         glaacomp          LIKE glaa_t.glaacomp,
         glaa001           LIKE glaa_t.glaa001,
         glaa002           LIKE glaa_t.glaa002
                       END RECORD
DEFINE g_amt               LIKE apca_t.apca107
DEFINE g_rec_b04           LIKE type_t.num5
DEFINE g_detail_insert     LIKE type_t.num5   #單身的新增權限
DEFINE g_detail_delete     LIKE type_t.num5   #單身的刪除權限
DEFINE g_appoint_idx       LIKE type_t.num5   #指定進入單身行數
DEFINE g_rec_b             LIKE type_t.num5

DEFINE g_apcadocno       LIKE apca_t.apcadocno
DEFINE g_apcald          LIKE apca_t.apcald
DEFINE g_ooef019         LIKE ooef_t.ooef019 #稅區
DEFINE g_apcacomp        LIKE apca_t.apcacomp
DEFINE g_isai002         LIKE isai_t.isai002
DEFINE g_str             LIKE type_t.chr1
DEFINE g_glaa001         LIKE glaa_t.glaa001
DEFINE g_wc_ooef019      LIKE ooef_t.ooef019 #查詢時g_site稅區 #161101-00070#1 add


#匯出excel用所以另外宣告一個GLOBAL變數
GLOBALS
   DEFINE g_apcb_d5        DYNAMIC ARRAY OF type_g_isam_d
   DEFINE g_apcald_03      LIKE apca_t.apcald
   DEFINE g_apcadocno_03   LIKE apca_t.apcadocno
   DEFINE g_modify         BOOLEAN   #151013-00016#5 
   DEFINE g_wc_t300_03     STRING
END GLOBALS


#end add-point
 
#模組變數(Module Variables)
DEFINE g_isam_d          DYNAMIC ARRAY OF type_g_isam_d #單身變數
DEFINE g_isam_d_t        type_g_isam_d                  #單身備份
DEFINE g_isam_d_o        type_g_isam_d                  #單身備份
DEFINE g_isam_d_mask_o   DYNAMIC ARRAY OF type_g_isam_d #單身變數
DEFINE g_isam_d_mask_n   DYNAMIC ARRAY OF type_g_isam_d #單身變數
 
      
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
 
{<section id="aapt300_03.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aapt300_03(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_ld,p_docno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_ld      LIKE apca_t.apcald
   DEFINE p_docno   LIKE apca_t.apcadocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   
   #SELECT * INTO g_apca_t.* FROM apca_t #161208-00026#6 mark
   #161208-00026#6-add(s)
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
     INTO g_apca_t.* 
     FROM apca_t
   #161208-00026#6-add(e)
    WHERE apcaent = g_enterprise
      AND apcadocno = p_docno
      AND apcald  = p_ld
      
   SELECT glaacomp,glaa001,glaa002
     INTO g_glaa_t.glaacomp,g_glaa_t.glaa001,g_glaa_t.glaa002
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030,isam009, 
       isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamcomp, 
       isamstus,isam002,isam004,isam016,isam017,isam018,isam019,isam020,isam021,isam022,isam029,isam031, 
       isam032,isam033,isam034,isam038,isam039 FROM isam_t WHERE isament=? AND isamdocno=? AND isamseq=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt300_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_03 WITH FORM cl_ap_formpath("aap","aapt300_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aapt300_03_init()   
 
   #進入選單 Menu (="N")
   CALL aapt300_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aapt300_03
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ' '
   IF NOT (g_apca_t.apca001 = '10' OR g_apca_t.apca001 = '22' OR g_apca_t.apca001 = '31' OR g_apca_t.apca001 = '50') AND g_amt > 0 THEN
      CALL aapt300_05(g_apca_t.apcald,g_apca_t.apcadocno)
   END IF
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapt300_03_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
      CALL cl_set_combo_scc_part('isamstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('isam037','9719') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('isam037','9719')
   CALL aapt300_03_ref_amt()
   LET g_argv[1] = g_apca_t.apcadocno
   #end add-point
   
   CALL aapt300_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapt300_03_ui_dialog()
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
         CALL g_isam_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapt300_03_init()
      END IF
   
      CALL aapt300_03_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isam_d TO s_detail1_aapt300_03.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_aapt300_03")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapt300_03_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1_aapt300_03",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1_aapt300_03", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapt300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_03_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapt300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_03_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapt300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_03_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt300_03_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt300_03_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1_aapt300_03",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isam_d)
               LET g_export_id[1]   = "s_detail1_aapt300_03"
 
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
            CALL aapt300_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt300_03_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt300_03_set_pk_array()
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
 
{<section id="aapt300_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt300_03_query()
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
   CALL g_isam_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030,isam009,isam012, 
          isam012_desc_desc,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027, 
          isam028 
 
         FROM s_detail1_aapt300_03[1].isam001,s_detail1_aapt300_03[1].isamdocno,s_detail1_aapt300_03[1].isamseq, 
             s_detail1_aapt300_03[1].isam008,s_detail1_aapt300_03[1].isam037,s_detail1_aapt300_03[1].isam011, 
             s_detail1_aapt300_03[1].isam010,s_detail1_aapt300_03[1].isam030,s_detail1_aapt300_03[1].isam009, 
             s_detail1_aapt300_03[1].isam012,s_detail1_aapt300_03[1].isam012_desc_desc,s_detail1_aapt300_03[1].isam0121, 
             s_detail1_aapt300_03[1].isam013,s_detail1_aapt300_03[1].isam014,s_detail1_aapt300_03[1].isam015, 
             s_detail1_aapt300_03[1].isam023,s_detail1_aapt300_03[1].isam024,s_detail1_aapt300_03[1].isam025, 
             s_detail1_aapt300_03[1].isam026,s_detail1_aapt300_03[1].isam027,s_detail1_aapt300_03[1].isam028  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isamcrtdt>>----
 
         #----<<isammoddt>>----
         
         #----<<isamcnfdt>>----
         
         #----<<isampstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam001
            #add-point:BEFORE FIELD isam001 name="query.b.page1_aapt300_03.isam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam001
            
            #add-point:AFTER FIELD isam001 name="query.a.page1_aapt300_03.isam001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam001
            #add-point:ON ACTION controlp INFIELD isam001 name="query.c.page1_aapt300_03.isam001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamdocno
            #add-point:BEFORE FIELD isamdocno name="query.b.page1_aapt300_03.isamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamdocno
            
            #add-point:AFTER FIELD isamdocno name="query.a.page1_aapt300_03.isamdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isamdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamdocno
            #add-point:ON ACTION controlp INFIELD isamdocno name="query.c.page1_aapt300_03.isamdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamseq
            #add-point:BEFORE FIELD isamseq name="query.b.page1_aapt300_03.isamseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamseq
            
            #add-point:AFTER FIELD isamseq name="query.a.page1_aapt300_03.isamseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamseq
            #add-point:ON ACTION controlp INFIELD isamseq name="query.c.page1_aapt300_03.isamseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_aapt300_03.isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam008
            #add-point:ON ACTION controlp INFIELD isam008 name="construct.c.page1_aapt300_03.isam008"
            #此段落由子樣板a08產生
            #開窗c段
            #161101-00070#1 --s add
            #查詢時發票類型開窗稅區條件
            LET g_wc_ooef019 = ''
            SELECT ooef019 INTO g_wc_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            #161101-00070#1 --e add
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_wc_ooef019,"' "  #161101-00070#1 add
            LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('1','3') "  #161127-00003#1 add
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isam008  #顯示到畫面上
            NEXT FIELD isam008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam008
            #add-point:BEFORE FIELD isam008 name="query.b.page1_aapt300_03.isam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam008
            
            #add-point:AFTER FIELD isam008 name="query.a.page1_aapt300_03.isam008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam037
            #add-point:BEFORE FIELD isam037 name="query.b.page1_aapt300_03.isam037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam037
            
            #add-point:AFTER FIELD isam037 name="query.a.page1_aapt300_03.isam037"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam037
            #add-point:ON ACTION controlp INFIELD isam037 name="query.c.page1_aapt300_03.isam037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam011
            #add-point:BEFORE FIELD isam011 name="query.b.page1_aapt300_03.isam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam011
            
            #add-point:AFTER FIELD isam011 name="query.a.page1_aapt300_03.isam011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam011
            #add-point:ON ACTION controlp INFIELD isam011 name="query.c.page1_aapt300_03.isam011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam010
            #add-point:BEFORE FIELD isam010 name="query.b.page1_aapt300_03.isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam010
            
            #add-point:AFTER FIELD isam010 name="query.a.page1_aapt300_03.isam010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam010
            #add-point:ON ACTION controlp INFIELD isam010 name="query.c.page1_aapt300_03.isam010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam030
            #add-point:BEFORE FIELD isam030 name="query.b.page1_aapt300_03.isam030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam030
            
            #add-point:AFTER FIELD isam030 name="query.a.page1_aapt300_03.isam030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam030
            #add-point:ON ACTION controlp INFIELD isam030 name="query.c.page1_aapt300_03.isam030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam009
            #add-point:BEFORE FIELD isam009 name="query.b.page1_aapt300_03.isam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam009
            
            #add-point:AFTER FIELD isam009 name="query.a.page1_aapt300_03.isam009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam009
            #add-point:ON ACTION controlp INFIELD isam009 name="query.c.page1_aapt300_03.isam009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_aapt300_03.isam012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam012
            #add-point:ON ACTION controlp INFIELD isam012 name="construct.c.page1_aapt300_03.isam012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isam012  #顯示到畫面上
            NEXT FIELD isam012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam012
            #add-point:BEFORE FIELD isam012 name="query.b.page1_aapt300_03.isam012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam012
            
            #add-point:AFTER FIELD isam012 name="query.a.page1_aapt300_03.isam012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam012_desc_desc
            #add-point:BEFORE FIELD isam012_desc_desc name="query.b.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam012_desc_desc
            
            #add-point:AFTER FIELD isam012_desc_desc name="query.a.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam012_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam012_desc_desc
            #add-point:ON ACTION controlp INFIELD isam012_desc_desc name="query.c.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam0121
            #add-point:BEFORE FIELD isam0121 name="query.b.page1_aapt300_03.isam0121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam0121
            
            #add-point:AFTER FIELD isam0121 name="query.a.page1_aapt300_03.isam0121"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam0121
            #add-point:ON ACTION controlp INFIELD isam0121 name="query.c.page1_aapt300_03.isam0121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam013
            #add-point:BEFORE FIELD isam013 name="query.b.page1_aapt300_03.isam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam013
            
            #add-point:AFTER FIELD isam013 name="query.a.page1_aapt300_03.isam013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam013
            #add-point:ON ACTION controlp INFIELD isam013 name="query.c.page1_aapt300_03.isam013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_aapt300_03.isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam014
            #add-point:ON ACTION controlp INFIELD isam014 name="construct.c.page1_aapt300_03.isam014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isam014  #顯示到畫面上
            NEXT FIELD isam014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam014
            #add-point:BEFORE FIELD isam014 name="query.b.page1_aapt300_03.isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam014
            
            #add-point:AFTER FIELD isam014 name="query.a.page1_aapt300_03.isam014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam015
            #add-point:BEFORE FIELD isam015 name="query.b.page1_aapt300_03.isam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam015
            
            #add-point:AFTER FIELD isam015 name="query.a.page1_aapt300_03.isam015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam015
            #add-point:ON ACTION controlp INFIELD isam015 name="query.c.page1_aapt300_03.isam015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam023
            #add-point:BEFORE FIELD isam023 name="query.b.page1_aapt300_03.isam023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam023
            
            #add-point:AFTER FIELD isam023 name="query.a.page1_aapt300_03.isam023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam023
            #add-point:ON ACTION controlp INFIELD isam023 name="query.c.page1_aapt300_03.isam023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam024
            #add-point:BEFORE FIELD isam024 name="query.b.page1_aapt300_03.isam024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam024
            
            #add-point:AFTER FIELD isam024 name="query.a.page1_aapt300_03.isam024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam024
            #add-point:ON ACTION controlp INFIELD isam024 name="query.c.page1_aapt300_03.isam024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam025
            #add-point:BEFORE FIELD isam025 name="query.b.page1_aapt300_03.isam025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam025
            
            #add-point:AFTER FIELD isam025 name="query.a.page1_aapt300_03.isam025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam025
            #add-point:ON ACTION controlp INFIELD isam025 name="query.c.page1_aapt300_03.isam025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam026
            #add-point:BEFORE FIELD isam026 name="query.b.page1_aapt300_03.isam026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam026
            
            #add-point:AFTER FIELD isam026 name="query.a.page1_aapt300_03.isam026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam026
            #add-point:ON ACTION controlp INFIELD isam026 name="query.c.page1_aapt300_03.isam026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam027
            #add-point:BEFORE FIELD isam027 name="query.b.page1_aapt300_03.isam027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam027
            
            #add-point:AFTER FIELD isam027 name="query.a.page1_aapt300_03.isam027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam027
            #add-point:ON ACTION controlp INFIELD isam027 name="query.c.page1_aapt300_03.isam027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam028
            #add-point:BEFORE FIELD isam028 name="query.b.page1_aapt300_03.isam028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam028
            
            #add-point:AFTER FIELD isam028 name="query.a.page1_aapt300_03.isam028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_aapt300_03.isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam028
            #add-point:ON ACTION controlp INFIELD isam028 name="query.c.page1_aapt300_03.isam028"
            
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
    
   CALL aapt300_03_b_fill(g_wc2)
 
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
 
{<section id="aapt300_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt300_03_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapt300_03_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt300_03_modify()
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
   DEFINE  l_ooab002              LIKE ooab_t.ooab002
   DEFINE  l_isacstus             LIKE isac_t.isacstus
   DEFINE  l_success              LIKE type_t.chr1
   DEFINE  l_oodbl004             LIKE oodbl_t.oodbl004
   DEFINE  l_oodb011              LIKE oodb_t.oodb011
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_glaa_t.glaacomp
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_isam_d FROM s_detail1_aapt300_03.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_isam_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt300_03_b_fill(g_wc2)
            LET g_detail_cnt = g_isam_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_aapt300_03")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_isam_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_isam_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_isam_d[l_ac].isamdocno IS NOT NULL
               AND g_isam_d[l_ac].isamseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_isam_d_t.* = g_isam_d[l_ac].*  #BACKUP
               LET g_isam_d_o.* = g_isam_d[l_ac].*  #BACKUP
               IF NOT aapt300_03_lock_b("isam_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_03_bcl INTO g_isam_d[l_ac].isam001,g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq, 
                      g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam010, 
                      g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121, 
                      g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023, 
                      g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027, 
                      g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus,g_isam_d[l_ac].isam002, 
                      g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018, 
                      g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022, 
                      g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033, 
                      g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038,g_isam_d[l_ac].isam039
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_isam_d_t.isamdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_isam_d_mask_o[l_ac].* =  g_isam_d[l_ac].*
                  CALL aapt300_03_isam_t_mask()
                  LET g_isam_d_mask_n[l_ac].* =  g_isam_d[l_ac].*
                  
                  CALL aapt300_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_03_set_entry_b(l_cmd)
            CALL aapt300_03_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL aapt300_03_ref_amt()
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
            INITIALIZE g_isam_d_t.* TO NULL
            INITIALIZE g_isam_d_o.* TO NULL
            INITIALIZE g_isam_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_isam_d[l_ac].isamstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_isam_d[l_ac].isam037 = "1"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            CALL aapt300_03_default_ins()
            #end add-point
            LET g_isam_d_t.* = g_isam_d[l_ac].*     #新輸入資料
            LET g_isam_d_o.* = g_isam_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_isam_d[li_reproduce_target].* = g_isam_d[li_reproduce].*
 
               LET g_isam_d[g_isam_d.getLength()].isamdocno = NULL
               LET g_isam_d[g_isam_d.getLength()].isamseq = NULL
 
            END IF
            
 
            CALL aapt300_03_set_entry_b(l_cmd)
            CALL aapt300_03_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM isam_t 
             WHERE isament = g_enterprise AND isamdocno = g_isam_d[l_ac].isamdocno
                                       AND isamseq = g_isam_d[l_ac].isamseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isam_d[g_detail_idx].isamdocno
               LET gs_keys[2] = g_isam_d[g_detail_idx].isamseq
               CALL aapt300_03_insert_b('isam_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_isam_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
 
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (isamdocno = '", g_isam_d[l_ac].isamdocno, "' "
                                  ," AND isamseq = '", g_isam_d[l_ac].isamseq, "' "
 
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
               
               DELETE FROM isam_t
                WHERE isament = g_enterprise AND 
                      isamdocno = g_isam_d_t.isamdocno
                      AND isamseq = g_isam_d_t.isamseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_03_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_isam_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_03_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_isam_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isam_d_t.isamdocno
               LET gs_keys[2] = g_isam_d_t.isamseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapt300_03_delete_b('isam_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_isam_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam001
            #add-point:BEFORE FIELD isam001 name="input.b.page1_aapt300_03.isam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam001
            
            #add-point:AFTER FIELD isam001 name="input.a.page1_aapt300_03.isam001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam001
            #add-point:ON CHANGE isam001 name="input.g.page1_aapt300_03.isam001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamdocno
            #add-point:BEFORE FIELD isamdocno name="input.b.page1_aapt300_03.isamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamdocno
            
            #add-point:AFTER FIELD isamdocno name="input.a.page1_aapt300_03.isamdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_isam_d[g_detail_idx].isamdocno IS NOT NULL AND g_isam_d[g_detail_idx].isamseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isam_d[g_detail_idx].isamdocno != g_isam_d_t.isamdocno OR g_isam_d[g_detail_idx].isamseq != g_isam_d_t.isamseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isam_t WHERE "||"isament = '" ||g_enterprise|| "' AND "||"isamdocno = '"||g_isam_d[g_detail_idx].isamdocno ||"' AND "|| "isamseq = '"||g_isam_d[g_detail_idx].isamseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isamdocno
            #add-point:ON CHANGE isamdocno name="input.g.page1_aapt300_03.isamdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isamseq
            #add-point:BEFORE FIELD isamseq name="input.b.page1_aapt300_03.isamseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isamseq
            
            #add-point:AFTER FIELD isamseq name="input.a.page1_aapt300_03.isamseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_isam_d[g_detail_idx].isamdocno IS NOT NULL AND g_isam_d[g_detail_idx].isamseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isam_d[g_detail_idx].isamdocno != g_isam_d_t.isamdocno OR g_isam_d[g_detail_idx].isamseq != g_isam_d_t.isamseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isam_t WHERE "||"isament = '" ||g_enterprise|| "' AND "||"isamdocno = '"||g_isam_d[g_detail_idx].isamdocno ||"' AND "|| "isamseq = '"||g_isam_d[g_detail_idx].isamseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isamseq
            #add-point:ON CHANGE isamseq name="input.g.page1_aapt300_03.isamseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam008
            #add-point:BEFORE FIELD isam008 name="input.b.page1_aapt300_03.isam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam008
            
            #add-point:AFTER FIELD isam008 name="input.a.page1_aapt300_03.isam008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam008
            #add-point:ON CHANGE isam008 name="input.g.page1_aapt300_03.isam008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam037
            #add-point:BEFORE FIELD isam037 name="input.b.page1_aapt300_03.isam037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam037
            
            #add-point:AFTER FIELD isam037 name="input.a.page1_aapt300_03.isam037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam037
            #add-point:ON CHANGE isam037 name="input.g.page1_aapt300_03.isam037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam011
            #add-point:BEFORE FIELD isam011 name="input.b.page1_aapt300_03.isam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam011
            
            #add-point:AFTER FIELD isam011 name="input.a.page1_aapt300_03.isam011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam011
            #add-point:ON CHANGE isam011 name="input.g.page1_aapt300_03.isam011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam010
            #add-point:BEFORE FIELD isam010 name="input.b.page1_aapt300_03.isam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam010
            
            #add-point:AFTER FIELD isam010 name="input.a.page1_aapt300_03.isam010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam010
            #add-point:ON CHANGE isam010 name="input.g.page1_aapt300_03.isam010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam030
            #add-point:BEFORE FIELD isam030 name="input.b.page1_aapt300_03.isam030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam030
            
            #add-point:AFTER FIELD isam030 name="input.a.page1_aapt300_03.isam030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam030
            #add-point:ON CHANGE isam030 name="input.g.page1_aapt300_03.isam030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam009
            #add-point:BEFORE FIELD isam009 name="input.b.page1_aapt300_03.isam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam009
            
            #add-point:AFTER FIELD isam009 name="input.a.page1_aapt300_03.isam009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam009
            #add-point:ON CHANGE isam009 name="input.g.page1_aapt300_03.isam009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam012
            
            #add-point:AFTER FIELD isam012 name="input.a.page1_aapt300_03.isam012"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam012
            #add-point:BEFORE FIELD isam012 name="input.b.page1_aapt300_03.isam012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam012
            #add-point:ON CHANGE isam012 name="input.g.page1_aapt300_03.isam012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam012_desc_desc
            #add-point:BEFORE FIELD isam012_desc_desc name="input.b.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam012_desc_desc
            
            #add-point:AFTER FIELD isam012_desc_desc name="input.a.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam012_desc_desc
            #add-point:ON CHANGE isam012_desc_desc name="input.g.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam0121
            #add-point:BEFORE FIELD isam0121 name="input.b.page1_aapt300_03.isam0121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam0121
            
            #add-point:AFTER FIELD isam0121 name="input.a.page1_aapt300_03.isam0121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam0121
            #add-point:ON CHANGE isam0121 name="input.g.page1_aapt300_03.isam0121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam013
            #add-point:BEFORE FIELD isam013 name="input.b.page1_aapt300_03.isam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam013
            
            #add-point:AFTER FIELD isam013 name="input.a.page1_aapt300_03.isam013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam013
            #add-point:ON CHANGE isam013 name="input.g.page1_aapt300_03.isam013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam014
            #add-point:BEFORE FIELD isam014 name="input.b.page1_aapt300_03.isam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam014
            
            #add-point:AFTER FIELD isam014 name="input.a.page1_aapt300_03.isam014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam014
            #add-point:ON CHANGE isam014 name="input.g.page1_aapt300_03.isam014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam015
            #add-point:BEFORE FIELD isam015 name="input.b.page1_aapt300_03.isam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam015
            
            #add-point:AFTER FIELD isam015 name="input.a.page1_aapt300_03.isam015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam015
            #add-point:ON CHANGE isam015 name="input.g.page1_aapt300_03.isam015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam023
            #add-point:BEFORE FIELD isam023 name="input.b.page1_aapt300_03.isam023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam023
            
            #add-point:AFTER FIELD isam023 name="input.a.page1_aapt300_03.isam023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam023
            #add-point:ON CHANGE isam023 name="input.g.page1_aapt300_03.isam023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam024
            #add-point:BEFORE FIELD isam024 name="input.b.page1_aapt300_03.isam024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam024
            
            #add-point:AFTER FIELD isam024 name="input.a.page1_aapt300_03.isam024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam024
            #add-point:ON CHANGE isam024 name="input.g.page1_aapt300_03.isam024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam025
            #add-point:BEFORE FIELD isam025 name="input.b.page1_aapt300_03.isam025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam025
            
            #add-point:AFTER FIELD isam025 name="input.a.page1_aapt300_03.isam025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam025
            #add-point:ON CHANGE isam025 name="input.g.page1_aapt300_03.isam025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam026
            #add-point:BEFORE FIELD isam026 name="input.b.page1_aapt300_03.isam026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam026
            
            #add-point:AFTER FIELD isam026 name="input.a.page1_aapt300_03.isam026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam026
            #add-point:ON CHANGE isam026 name="input.g.page1_aapt300_03.isam026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam027
            #add-point:BEFORE FIELD isam027 name="input.b.page1_aapt300_03.isam027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam027
            
            #add-point:AFTER FIELD isam027 name="input.a.page1_aapt300_03.isam027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam027
            #add-point:ON CHANGE isam027 name="input.g.page1_aapt300_03.isam027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isam028
            #add-point:BEFORE FIELD isam028 name="input.b.page1_aapt300_03.isam028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isam028
            
            #add-point:AFTER FIELD isam028 name="input.a.page1_aapt300_03.isam028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isam028
            #add-point:ON CHANGE isam028 name="input.g.page1_aapt300_03.isam028"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_aapt300_03.isam001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam001
            #add-point:ON ACTION controlp INFIELD isam001 name="input.c.page1_aapt300_03.isam001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isamdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamdocno
            #add-point:ON ACTION controlp INFIELD isamdocno name="input.c.page1_aapt300_03.isamdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isamseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isamseq
            #add-point:ON ACTION controlp INFIELD isamseq name="input.c.page1_aapt300_03.isamseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam008
            #add-point:ON ACTION controlp INFIELD isam008 name="input.c.page1_aapt300_03.isam008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isam_d[l_ac].isam008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            LET g_qryparam.where = " isac001 = '",g_ooef019,"' "  #161024-00066#1 add
            LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('1','3') "  #161127-00003#1 add
            CALL q_isac002()                                #呼叫開窗

            LET g_isam_d[l_ac].isam008 = g_qryparam.return1              

            DISPLAY g_isam_d[l_ac].isam008 TO isam008              #

            NEXT FIELD isam008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam037
            #add-point:ON ACTION controlp INFIELD isam037 name="input.c.page1_aapt300_03.isam037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam011
            #add-point:ON ACTION controlp INFIELD isam011 name="input.c.page1_aapt300_03.isam011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam010
            #add-point:ON ACTION controlp INFIELD isam010 name="input.c.page1_aapt300_03.isam010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam030
            #add-point:ON ACTION controlp INFIELD isam030 name="input.c.page1_aapt300_03.isam030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam009
            #add-point:ON ACTION controlp INFIELD isam009 name="input.c.page1_aapt300_03.isam009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam012
            #add-point:ON ACTION controlp INFIELD isam012 name="input.c.page1_aapt300_03.isam012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isam_d[l_ac].isam012             #給予default值
            LET g_qryparam.default2 = "" #g_isam_d[l_ac].oodb002 #稅別代碼
            LET g_qryparam.default3 = "" #g_isam_d[l_ac].oodb005 #含稅否
            LET g_qryparam.default4 = "" #g_isam_d[l_ac].oodb006 #稅率
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oodb002_5()                                #呼叫開窗

            LET g_isam_d[l_ac].isam012 = g_qryparam.return1              
            #LET g_isam_d[l_ac].oodb002 = g_qryparam.return2 
            #LET g_isam_d[l_ac].oodb005 = g_qryparam.return3 
            #LET g_isam_d[l_ac].oodb006 = g_qryparam.return4 
            DISPLAY g_isam_d[l_ac].isam012 TO isam012              #
            #DISPLAY g_isam_d[l_ac].oodb002 TO oodb002 #稅別代碼
            #DISPLAY g_isam_d[l_ac].oodb005 TO oodb005 #含稅否
            #DISPLAY g_isam_d[l_ac].oodb006 TO oodb006 #稅率
            NEXT FIELD isam012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam012_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam012_desc_desc
            #add-point:ON ACTION controlp INFIELD isam012_desc_desc name="input.c.page1_aapt300_03.isam012_desc_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam0121
            #add-point:ON ACTION controlp INFIELD isam0121 name="input.c.page1_aapt300_03.isam0121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam013
            #add-point:ON ACTION controlp INFIELD isam013 name="input.c.page1_aapt300_03.isam013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam014
            #add-point:ON ACTION controlp INFIELD isam014 name="input.c.page1_aapt300_03.isam014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isam_d[l_ac].isam014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_isam_d[l_ac].isam014 = g_qryparam.return1              

            DISPLAY g_isam_d[l_ac].isam014 TO isam014              #

            NEXT FIELD isam014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam015
            #add-point:ON ACTION controlp INFIELD isam015 name="input.c.page1_aapt300_03.isam015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam023
            #add-point:ON ACTION controlp INFIELD isam023 name="input.c.page1_aapt300_03.isam023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam024
            #add-point:ON ACTION controlp INFIELD isam024 name="input.c.page1_aapt300_03.isam024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam025
            #add-point:ON ACTION controlp INFIELD isam025 name="input.c.page1_aapt300_03.isam025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam026
            #add-point:ON ACTION controlp INFIELD isam026 name="input.c.page1_aapt300_03.isam026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam027
            #add-point:ON ACTION controlp INFIELD isam027 name="input.c.page1_aapt300_03.isam027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aapt300_03.isam028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isam028
            #add-point:ON ACTION controlp INFIELD isam028 name="input.c.page1_aapt300_03.isam028"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapt300_03_bcl
               LET INT_FLAG = 0
               LET g_isam_d[l_ac].* = g_isam_d_t.*
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
               LET g_errparam.extend = g_isam_d[l_ac].isamdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_isam_d[l_ac].* = g_isam_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_03_isam_t_mask_restore('restore_mask_o')
 
               UPDATE isam_t SET (isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030, 
                   isam009,isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026, 
                   isam027,isam028,isamcomp,isamstus,isam002,isam004,isam016,isam017,isam018,isam019, 
                   isam020,isam021,isam022,isam029,isam031,isam032,isam033,isam034,isam038,isam039) = (g_isam_d[l_ac].isam001, 
                   g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037, 
                   g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009, 
                   g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014, 
                   g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025, 
                   g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp, 
                   g_isam_d[l_ac].isamstus,g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016, 
                   g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020, 
                   g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031, 
                   g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038, 
                   g_isam_d[l_ac].isam039)
                WHERE isament = g_enterprise AND
                  isamdocno = g_isam_d_t.isamdocno #項次   
                  AND isamseq = g_isam_d_t.isamseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isam_d[g_detail_idx].isamdocno
               LET gs_keys_bak[1] = g_isam_d_t.isamdocno
               LET gs_keys[2] = g_isam_d[g_detail_idx].isamseq
               LET gs_keys_bak[2] = g_isam_d_t.isamseq
               CALL aapt300_03_update_b('isam_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_isam_d_t)
                     LET g_log2 = util.JSON.stringify(g_isam_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_03_isam_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapt300_03_unlock_b("isam_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_isam_d[l_ac].* = g_isam_d_t.*
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
            CALL aapt300_03_ref_amt()
            LET g_apcb_d5.* = g_isam_d.*
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_isam_d[li_reproduce_target].* = g_isam_d[li_reproduce].*
 
               LET g_isam_d[li_reproduce_target].isamdocno = NULL
               LET g_isam_d[li_reproduce_target].isamseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_isam_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_isam_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input name="input.more_input"
 
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1_aapt300_03",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1_aapt300_03"
               NEXT FIELD isam001
 
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
      IF INT_FLAG OR cl_null(g_isam_d[g_detail_idx].isamdocno) THEN
         CALL g_isam_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_isam_d[g_detail_idx].* = g_isam_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL aapt300_03_b_fill(g_wc2)
      CALL s_transaction_end('N','0')
   END IF 
   #end add-point
 
   CLOSE aapt300_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt300_03_delete()
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
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_isam_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapt300_03_lock_b("isam_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("isam_t","isamownid") THEN
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
   
   FOR li_idx = 1 TO g_isam_d.getLength()
      IF g_isam_d[li_idx].isamdocno IS NOT NULL
         AND g_isam_d[li_idx].isamseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM isam_t
          WHERE isament = g_enterprise AND 
                isamdocno = g_isam_d[li_idx].isamdocno
                AND isamseq = g_isam_d[li_idx].isamseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_isam_d_t.isamdocno
               LET gs_keys[2] = g_isam_d_t.isamseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapt300_03_delete_b('isam_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_03_set_pk_array()
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
   CALL aapt300_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt300_03_b_fill(p_wc2)              #BODY FILL UP
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
   IF p_wc2 = " 1=1" THEN
      LET p_wc2 = " isamdocno = '",g_apca_t.apcadocno,"' AND isam001 = 'aapt300' "
   ELSE
      LET p_wc2 = p_wc2," AND isamdocno = '",g_apca_t.apcadocno,"' AND isam001 = 'aapt300' "
   END IF
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.isam001,t0.isamdocno,t0.isamseq,t0.isam008,t0.isam037,t0.isam011, 
       t0.isam010,t0.isam030,t0.isam009,t0.isam012,t0.isam0121,t0.isam013,t0.isam014,t0.isam015,t0.isam023, 
       t0.isam024,t0.isam025,t0.isam026,t0.isam027,t0.isam028,t0.isamcomp,t0.isamstus,t0.isam002,t0.isam004, 
       t0.isam016,t0.isam017,t0.isam018,t0.isam019,t0.isam020,t0.isam021,t0.isam022,t0.isam029,t0.isam031, 
       t0.isam032,t0.isam033,t0.isam034,t0.isam038,t0.isam039  FROM isam_t t0",
               "",
               
               " WHERE t0.isament= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("isam_t"),
                      " ORDER BY t0.isamdocno,t0.isamseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"isam_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt300_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapt300_03_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isam_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_isam_d[l_ac].isam001,g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isam008, 
       g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009, 
       g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014, 
       g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026, 
       g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus, 
       g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018, 
       g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029, 
       g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038, 
       g_isam_d[l_ac].isam039
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
      
      CALL aapt300_03_detail_show()      
 
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
   
 
   
   CALL g_isam_d.deleteElement(g_isam_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_isam_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_isam_d.getLength() THEN
      LET l_ac = g_isam_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_isam_d.getLength()
      LET g_isam_d_mask_o[l_ac].* =  g_isam_d[l_ac].*
      CALL aapt300_03_isam_t_mask()
      LET g_isam_d_mask_n[l_ac].* =  g_isam_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_apcb_d5.* = g_isam_d.*
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_isam_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapt300_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapt300_03_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt300_03_set_entry_b(p_cmd)                                                  
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
  #CALL cl_set_comp_entry('isam023,isam025,isam026,isam028',TRUE)
   CALL cl_set_comp_entry('isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028',TRUE)  #151218-00009#2
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aapt300_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt300_03_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_apca001     LIKE apca_t.apca001     #151218-00009#2
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
   #IF g_isam_d[l_ac].isam014 = g_glaa_t.glaa001 THEN
   #   CALL cl_set_comp_entry('isam026,isam028',FALSE)
   #END IF
   #IF g_isam_d[l_ac].isam0121 = 'Y' THEN
   #   CALL cl_set_comp_entry('isam023,isam026',FALSE)
   #ELSE
   #   CALL cl_set_comp_entry('isam025,isam028',FALSE)
   #END IF
   #151218-00009#2--(S)
   SELECT apca001 INTO l_apca001
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcald  = g_apcald_03 AND apcadocno = g_apcadocno_03
   IF l_apca001 = '17' OR l_apca001 = '22' THEN
      CALL cl_set_comp_entry('isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028',FALSE)
   END IF
   #151218-00009#2--(E)
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt300_03_default_search()
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
      LET ls_wc = ls_wc, " isamdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " isamseq = '", g_argv[02], "' AND "
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
 
{<section id="aapt300_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt300_03_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "isam_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'isam_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM isam_t
          WHERE isament = g_enterprise AND
            isamdocno = ps_keys_bak[1] AND isamseq = ps_keys_bak[2]
         
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
         CALL g_isam_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt300_03_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "isam_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO isam_t
                  (isament,
                   isamdocno,isamseq
                   ,isam001,isam008,isam037,isam011,isam010,isam030,isam009,isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamcomp,isamstus,isam002,isam004,isam016,isam017,isam018,isam019,isam020,isam021,isam022,isam029,isam031,isam032,isam033,isam034,isam038,isam039) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_isam_d[l_ac].isam001,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011, 
                       g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam012, 
                       g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015, 
                       g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026, 
                       g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus, 
                       g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017, 
                       g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021, 
                       g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032, 
                       g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038,g_isam_d[l_ac].isam039) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
       
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      UPDATE isam_t 
         SET isam200 = 'N',isam205 = 'N', isamownid = g_user,isamowndp = g_dept,
             isamcrtid = g_user, isamcrtdt = g_today,isamcrtdp = g_dept,isam036 = 11,
             isamcnfid = g_user, isamcnfdt = g_today
       WHERE isament = g_enterprise AND isamdocno = g_isam_d[l_ac].isamdocno
         AND isam008 = g_isam_d[l_ac].isam008 AND isam010 = g_isam_d[l_ac].isam010
               
  
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt300_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "isam_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "isam_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE isam_t 
         SET (isamdocno,isamseq
              ,isam001,isam008,isam037,isam011,isam010,isam030,isam009,isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamcomp,isamstus,isam002,isam004,isam016,isam017,isam018,isam019,isam020,isam021,isam022,isam029,isam031,isam032,isam033,isam034,isam038,isam039) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_isam_d[l_ac].isam001,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011, 
                  g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam012, 
                  g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015, 
                  g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026, 
                  g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus, 
                  g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017, 
                  g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021, 
                  g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032, 
                  g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038,g_isam_d[l_ac].isam039)  
 
         WHERE isament = g_enterprise AND isamdocno = ps_keys_bak[1] AND isamseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isam_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
       UPDATE isam_t 
         SET  isammodid = g_user,isammoddt = g_today
       WHERE isament = g_enterprise AND isamdocno = g_isam_d[l_ac].isamdocno
         AND isam008 = g_isam_d[l_ac].isam008 AND isam010 = g_isam_d[l_ac].isam010
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt300_03_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapt300_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "isam_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt300_03_bcl USING g_enterprise,
                                       g_isam_d[g_detail_idx].isamdocno,g_isam_d[g_detail_idx].isamseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt300_03_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt300_03_unlock_b(ps_table)
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
      CLOSE aapt300_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapt300_03_modify_detail_chk(ps_record)
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
      WHEN "s_detail1_aapt300_03" 
         LET ls_return = "isam001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_03.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapt300_03_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aapt300_03.mask_functions" >}
&include "erp/aap/aapt300_03_mask.4gl"
 
{</section>}
 
{<section id="aapt300_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt300_03_set_pk_array()
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
   LET g_pk_array[1].values = g_isam_d[l_ac].isamdocno
   LET g_pk_array[1].column = 'isamdocno'
   LET g_pk_array[2].values = g_isam_d[l_ac].isamseq
   LET g_pk_array[2].column = 'isamseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_03.state_change" >}
   
 
{</section>}
 
{<section id="aapt300_03.other_dialog" readonly="Y" >}

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
DIALOG aapt300_03_display()

   DISPLAY ARRAY g_isam_d TO s_detail1_aapt300_03.* ATTRIBUTES(COUNT=300) 
   
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx)
      AFTER DISPLAY
         LET g_apcb_d5.* = g_isam_d.*
   END DISPLAY

END DIALOG

################################################################################
# Descriptions...: 發票明細輸入
# Memo...........:
# Usage..........: CALLaapt300_03_input()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG aapt300_03_input()
#DEFINE l_apcb         RECORD LIKE apcb_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE l_apcb  RECORD  #應付憑單單身
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
DEFINE l_forupd_sql   STRING
DEFINE l_lock_sw      LIKE type_t.chr1 
DEFINE l_apcadocdt    LIKE apca_t.apcadocdt
DEFINE l_glaa004      LIKE glaa_t.glaa004 
DEFINE l_count        LIKE type_t.num5
DEFINE l_cmd          LIKE type_t.chr5
#DEFINE l_isam         RECORD LIKE isam_t.* #161104-00024#2 mark
#161104-00024#2-add(s)
DEFINE l_isam  RECORD  #進項發票主檔
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
       isam0121  LIKE isam_t.isam0121, #含稅否
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
       isam051   LIKE isam_t.isam051    #認證否
           END RECORD
#161104-00024#2-add(e)
DEFINE l_oodb011      LIKE oodb_t.oodb011
#DEFINE l_apca         RECORD LIKE apca_t.* #161104-00024#2 mark
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
#161104-00024#2-add(e)
DEFINE l_change_tax   LIKE type_t.chr1  
DEFINE l_change_rate  LIKE type_t.chr1
DEFINE l_change       LIKE type_t.chr1 
DEFINE l_isam010      LIKE isam_t.isam010
DEFINE l_rate2                LIKE fmmp_t.fmmp010 #匯率二
DEFINE l_rate3                LIKE fmmp_t.fmmp010 #匯率三
DEFINE l_isac004     LIKE isac_t.isac004  #151013-00016#14
#151223-00006#1--(S)
DEFINE ls_js         STRING
DEFINE lc_param2     RECORD
         type        LIKE type_t.chr1,       #類型
         apca004     LIKE apca_t.apca004,
         sfin2009    LIKE type_t.chr1        #汇率基本
                 END RECORD
#151223-00006#1--(E)
DEFINE l_isai002     LIKE isai_t.isai002   #160825-00039#1 add
DEFINE l_isai005     LIKE isai_t.isai005   #160825-00039#1 add
DEFINE l_isac008     LIKE isac_t.isac008   #160923-00045#1 add
DEFINE l_isam009     LIKE isam_t.isam009   #161019-00054#1 add
DEFINE l_ooef011     LIKE ooef_t.ooef011   #161021-00039#1 add
DEFINE l_pmdldocdt   LIKE pmdl_t.pmdldocdt #161006-00011#2 add
DEFINE l_success     LIKE type_t.num5      #161129-00042#1-add
DEFINE l_vat_id      STRING                #161230-00036#1-add
   INPUT ARRAY g_isam_d FROM s_detail1_aapt300_03.*
      
      ATTRIBUTE(COUNT = g_rec_b04,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                INSERT ROW = FALSE,
                DELETE ROW = NOT g_modify, #151013-00016#5 BOOLEAN默認為FALSE因開放aapt300以及aapt340修改，可是不可以新增
                APPEND ROW = NOT g_modify) #               以及刪除所以當aapt300以及aapt340進來時會給TURE                                 
                
      BEFORE INPUT                 
         IF cl_null(g_apcadocno) THEN LET g_apcadocno = g_apcadocno_03 END IF #150925-00029#1
         IF cl_null(g_apcald) THEN LET g_apcald = g_apcald_03 END IF          #150925-00029#1
         #取得該法人的稅區　　　　　　
         #SELECT * INTO l_apca.*   #161208-00026#6 mark
         #161208-00026#6-add(s)
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
           INTO l_apca.*
         #161208-00026#6-add(e)
           FROM apca_t   
          WHERE apcaent = g_enterprise
            AND apcadocno = g_apcadocno
            AND apcald = g_apcald
            
         LET g_apcacomp = l_apca.apcacomp 
         #151223-00006#1--(S)         
         LET lc_param2.apca004 = l_apca.apca004
         CALL cl_get_para(g_enterprise,l_apca.apcacomp,'S-FIN-3009') RETURNING lc_param2.sfin2009 
         LET ls_js = util.JSON.stringify(lc_param2)
         #151223-00006#1--(S)
         SELECT ooef019 INTO g_ooef019
           FROM ooef_t
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_apcacomp 

         #用"發票編碼方式"決定是否隱藏"發票代碼"  
         CALL aapt300_03_set_entry_invoice_code()         
        
         #當執行作業為以下作業時才開放輸入，日後有新增可輸入的作業，需要維護。         
         #160705-00042#11 160714 by sakura mark(S)         
         #CASE g_prog
         #   WHEN 'aapt210'    #20150730 add lujh                        
         #   WHEN 'aapt300'    #151013-00016#5
         #   WHEN 'aapt301'
         #   WHEN 'aapt310'
         #   WHEN 'aapt330'
         #   WHEN 'aapt331'
         #   WHEN 'aapt340'    #151013-00016#5            
         #   WHEN 'aapt341'
         #160705-00042#11 160714 by sakura mark(E)
         #160705-00042#11 160714 by sakura add(S)
         CASE 
            WHEN g_prog MATCHES 'aapt210'
            WHEN g_prog MATCHES 'aapt300'
            WHEN g_prog MATCHES 'aapt301'
            WHEN g_prog MATCHES 'aapt310'
            WHEN g_prog MATCHES 'aapt330'
            WHEN g_prog MATCHES 'aapt331'
            WHEN g_prog MATCHES 'aapt340'
            WHEN g_prog MATCHES 'aapt341' 
            #160705-00042#11 160714 by sakura add(E)            
            OTHERWISE
               NEXT FIELD apca003
         END CASE   


         CALL cl_set_combo_scc('isam037','9719')       
         LET l_forupd_sql = "SELECT isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030,isam009, 
             isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027,isam028,isamcomp, 
             isamstus,isam002,isam004,isam016,isam017,isam018,isam019,isam020,isam021,isam022,isam029,isam031, 
             isam032,isam033,isam034,isam038,isam039 FROM isam_t WHERE isament=? AND isamdocno=? AND isamseq=?  
             FOR UPDATE"
         
         LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
         PREPARE aapt300_03_input_p FROM l_forupd_sql
         DECLARE aapt300_03_input_c CURSOR FOR aapt300_03_input_p
                

      BEFORE ROW 
         CALL aapt300_03_b_fill1(g_apcadocno,g_apcald)
         LET l_cmd = ''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'            #DEFAULT
         DISPLAY l_ac TO FORMONLY.idx                         
         CALL s_transaction_begin() 
         LET g_rec_b04 = g_isam_d.getLength()
                   
         IF g_rec_b04 >= l_ac THEN
            LET l_cmd='u'
            LET g_isam_d_t.* = g_isam_d[l_ac].*  #BACKUP
                
            OPEN aapt300_03_input_c USING g_enterprise,
                               g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "aapt300_03_input_c"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            ELSE
               FETCH aapt300_03_input_c 
               INTO g_isam_d[l_ac].isam001,g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq, 
                    g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam010, 
                    g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121, 
                    g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023, 
                    g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027, 
                    g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus,g_isam_d[l_ac].isam002, 
                    g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018, 
                    g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022, 
                    g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033, 
                    g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038,g_isam_d[l_ac].isam039
               CALL cl_show_fld_cont()    
            END IF
         ELSE 
            LET l_cmd='a'  
         END IF    
         SELECT glaa001 INTO g_glaa001
           FROM glaa_t
          WHERE glaaent  = g_enterprise
           #AND glaacomp = g_isam_d[l_ac].isamcomp   20151012 mark
            AND glaacomp = g_apcacomp                #20151012 add
            AND glaa014  = 'Y' 
         CALL aapt300_03_set_entry_money(g_isam_d[l_ac].isam0121)
         CALL aapt300_03_isac003_chk(g_ooef019) 
         CALL aapt300_03_set_entry_b('')        #151218-00009#2
         CALL aapt300_03_set_no_entry_b('')     #151218-00009#2
 
      ON ROW CHANGE   
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            
            LET INT_FLAG = 0
            LET g_isam_d[l_ac].* = g_isam_d_t.*
            CLOSE aapt300_03_input_c
            CALL s_transaction_end('N','0')
            EXIT DIALOG 
         END IF
                 
         IF l_lock_sw = 'Y' THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_isam_d[l_ac].isamdocno 
            LET g_errparam.code   = -263 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN FALSE
            LET g_isam_d[l_ac].* = g_isam_d_t.*
         ELSE 
            IF g_isam_d[l_ac].isam015 = 1 THEN
               LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
               LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
               LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
            END IF
         
            UPDATE isam_t SET (isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030, 
                 isam009,isam012,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026, 
                 isam027,isam028,isamcomp,isamstus,isam002,isam004,isam016,isam017,isam018,isam019, 
                 isam020,isam021,isam022,isam029,isam031,isam032,isam033,isam034,isam038,isam039) = (g_isam_d[l_ac].isam001, 
                 g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam037, 
                 g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,g_isam_d[l_ac].isam009, 
                 g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,g_isam_d[l_ac].isam014, 
                 g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025, 
                 g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp, 
                 g_isam_d[l_ac].isamstus,g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016, 
                 g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020, 
                 g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029,g_isam_d[l_ac].isam031, 
                 g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038, 
                 g_isam_d[l_ac].isam039)
             WHERE isament   = g_enterprise 
               AND isamdocno = g_isam_d[l_ac].isamdocno    
               AND isamseq   = g_isam_d[l_ac].isamseq  
      
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "isam_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET g_isam_d[l_ac].* = g_isam_d_t.*
                CALL s_transaction_end('N',0) 
             ELSE
                 CALL s_transaction_end('Y',0)                
             END IF
         END IF
         
      BEFORE INSERT
         CALL s_transaction_begin()   
         LET l_cmd = 'a'
         INITIALIZE g_isam_d_t.* TO NULL
         INITIALIZE g_isam_d_o.* TO NULL
         INITIALIZE g_isam_d[l_ac].* TO NULL
         CALL aapt300_03_default_ins()
         LET g_isam_d_t.* = g_isam_d[l_ac].*     #新輸入資料
         LET g_isam_d_o.* = g_isam_d[l_ac].*     #新輸入資料
         CALL cl_show_fld_cont()
       
      AFTER INSERT
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 9001
            LET g_errparam.popup  = FALSE
            CALL cl_err()         
            LET INT_FLAG = 0
            CALL s_transaction_end('N',0) 
         END IF
         IF g_isam_d[l_ac].isam015 = 1 THEN
            LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
            LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
            LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
         END IF
         
         LET l_isam.isament   = g_enterprise
         LET l_isam.isamseq   = g_isam_d[l_ac].isamseq
         LET l_isam.isamcomp  = g_apcacomp
         LET l_isam.isamstus  = 'Y'
         LET l_isam.isamdocno = g_apcadocno
         LET l_isam.isam001   = g_prog
         LET l_isam.isam002   = g_isam_d[l_ac].isam002
         LET l_isam.isam008   = g_isam_d[l_ac].isam008
         LET l_isam.isam037   = g_isam_d[l_ac].isam037
         LET l_isam.isam011   = g_isam_d[l_ac].isam011
         LET l_isam.isam012   = g_isam_d[l_ac].isam012
         LET l_isam.isam010   = g_isam_d[l_ac].isam010
         LET l_isam.isam030   = g_isam_d[l_ac].isam030
         LET l_isam.isam009   = g_isam_d[l_ac].isam009
         LET l_isam.isam0121  = g_isam_d[l_ac].isam0121
         LET l_isam.isam013   = g_isam_d[l_ac].isam013
         LET l_isam.isam014   = g_isam_d[l_ac].isam014
         LET l_isam.isam015   = g_isam_d[l_ac].isam015
         LET l_isam.isam017   = g_isam_d[l_ac].isam017  #150925
         LET l_isam.isam023   = g_isam_d[l_ac].isam023
         LET l_isam.isam024   = g_isam_d[l_ac].isam024
         LET l_isam.isam025   = g_isam_d[l_ac].isam025
         LET l_isam.isam026   = g_isam_d[l_ac].isam026
         LET l_isam.isam027   = g_isam_d[l_ac].isam027
         LET l_isam.isam028   = g_isam_d[l_ac].isam028
         #LET l_isam.isam036   = '11'    #161229-00029#1 mark
         #161229-00029#1-----s
         IF l_apca.apca001 MATCHES '2*' THEN
            LET l_isam.isam036 = '21'
         ELSE
            LET l_isam.isam036 = '11'
         END IF
         #161229-00029#1-----e
         LET l_isam.isam050   = g_apcadocno         
         LET l_isam.isamownid = g_user
         LET l_isam.isamowndp = g_dept
         LET l_isam.isamcrtid = g_user
         LET l_isam.isamcrtdp = g_dept
         LET l_isam.isamcrtdt = cl_get_current() 
         LET l_isam.isammodid = g_user
         LET l_isam.isammoddt = cl_get_current()
                 
         LET l_count = 1
         #資料未重複, 插入新增資料
         SELECT COUNT(*) INTO l_count FROM isam_t
          WHERE isament = g_enterprise 
            AND isamdocno = g_isam_d[l_ac].isamdocno
            AND isamseq = g_isam_d[l_ac].isamseq 
         IF l_count = 0 THEN   
            #INSERT INTO isam_t VALUES(l_isam.*)    #161108-00017#3 mark
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
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "isam_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N',0) 
            END IF   
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'INSERT'
            LET g_errparam.code   = "std-00006"
            LET g_errparam.popup  = TRUE
            CALL cl_err()            
            INITIALIZE g_isam_d[l_ac].* TO NULL
            CALL s_transaction_end('N','0')       
         END IF         
         
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "isam_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            
            CALL s_transaction_end('N','0')
        
         ELSE
            CALL s_transaction_end('Y','0')
            ERROR 'INSERT O.K'
            LET g_rec_b04 = g_rec_b04 + 1            
            LET g_detail_cnt = g_detail_cnt + 1       
         END IF
         
      BEFORE DELETE                            #是否取消單身    
         IF cl_ask_del_detail() THEN
            IF l_lock_sw = "Y" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  -263
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()  
            END IF
                         
            DELETE FROM isam_t
             WHERE isament = g_enterprise 
                AND isamdocno = g_apcadocno
                AND isamseq = g_isam_d[l_ac].isamseq         
                        
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isam_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
            ELSE
               LET g_rec_b04 = g_rec_b04 - 1                   
               CALL s_transaction_end('Y','0')         
            END IF 
         END IF 
      AFTER DELETE
         CALL aapt300_03_b_fill1(g_apcadocno,g_apcald)
         
      AFTER ROW
         CLOSE aapt300_03_input_c
         
      AFTER FIELD isam008 #發闢類型
         IF NOT cl_null(g_isam_d[l_ac].isam008)THEN
            IF g_isam_d[l_ac].isam008 != g_isam_d_o.isam008 OR cl_null(g_isam_d_o.isam008) THEN #161230-00036#1-add
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_isam_d[l_ac].isam008
               IF NOT cl_chk_exist("v_isac002_3") THEN
                  LET g_isam_d[l_ac].isam008 = '' 
                  DISPLAY BY NAME g_isam_d[l_ac].isam008
                  NEXT FIELD CURRENT
               END IF
               CALL aapt300_03_isac003_chk(g_ooef019)
               ##160902-00034#1 ---s--- aapt341必須為紅字發票
               #IF g_prog MATCHES 'aapt341' THEN
               #   IF g_str <> '2' THEN                
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.code = 'aap-00589'
               #      LET g_errparam.extend = ''
               #      LET g_errparam.popup = TRUE
               #      CALL cl_err()
               #      LET g_isam_d[l_ac].isam008 = g_isam_d_t.isam008              
               #   END IF
               #END IF
               ##160902-00034#1 ---e---
               #151013-00016#14 ---s---
               LET l_isac004 = ''
               SELECT isac004 INTO l_isac004 FROM isac_t
                WHERE isacent = g_enterprise AND isac002 = g_isam_d[l_ac].isam008 AND isac001 = g_ooef019
                IF cl_null(l_isac004) THEN LET g_isam_d[l_ac].isam037 = '3' END IF
                DISPLAY BY NAME g_isam_d[l_ac].isam037
                #151013-00016#14 ---e---
                #161230-00036#1-add(s)
                #抓發票聯別
                LET l_isac008 = ''
                SELECT isac008 INTO l_isac008
                  FROM isac_t
                 WHERE isacent = g_enterprise
                   AND isac001 = g_ooef019
                   AND isac002 = g_isam_d[l_ac].isam008
                 #IF l_isac008 MATCHES '[4]' OR cl_null(l_isac004) THEN                                          #170218-00012#1 mark
                 IF l_isac008 MATCHES '[4]' OR cl_null(l_isac004) OR l_isac004 = '28' OR l_isac004 = '29' THEN   #170218-00012#1 add
                    CALL cl_set_comp_required("isam030",FALSE)
                 ELSE
                    CALL cl_set_comp_required("isam030",TRUE)
                    LET l_ooef011 = ' '
                    SELECT ooef011 INTO l_ooef011 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_apcacomp
                    IF l_ooef011 = 'TW' THEN
                       IF NOT cl_null(g_isam_d[l_ac].isam030) THEN
                          #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                          LET l_vat_id = g_isam_d[l_ac].isam030
                          IF l_vat_id.getLength() <> 8  THEN
                             INITIALIZE g_errparam TO NULL
                             LET g_errparam.code = 'sub-001388'
                             LET g_errparam.extend = ''
                             LET g_errparam.popup = TRUE
                             CALL cl_err()
                             LET g_isam_d[l_ac].isam030 = g_isam_d_o.isam030
                             NEXT FIELD isam030        
                          END IF         
                          IF NOT cl_chk_num(g_isam_d[l_ac].isam030,'N') THEN
                             INITIALIZE g_errparam TO NULL
                             LET g_errparam.code = 'sub-001388'
                             LET g_errparam.extend = ''
                             LET g_errparam.popup = TRUE
                             CALL cl_err()
                             LET g_isam_d[l_ac].isam030 = g_isam_d_o.isam030
                             NEXT FIELD isam030
                          END IF
                          #檢查營利事業統一編號邏輯
                          CALL s_rule_chk_vat_id(l_ooef011,g_isam_d[l_ac].isam030) RETURNING l_success
                          IF NOT l_success THEN
                             LET g_isam_d[l_ac].isam030 = g_isam_d[l_ac].isam030
                          END IF
                       END IF
                    END IF
                 END IF
                #161230-00036#1-add(e)
            END IF   #161230-00036#1-add              
         END IF
         LET g_isam_d_o.* = g_isam_d[l_ac].*   #161230-00036#1-add
      
      ON ACTION controlp INFIELD isam008           
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_isam_d[l_ac].isam008             
         ##160902-00034#1 ---s---
         #LET g_qryparam.where = " isac003 IN ('1','3') AND isac001 = '",g_ooef019,"' "
         #IF g_prog = 'aapt341' THEN 
         #   LET g_qryparam.where = " isac003 = '3' AND isac001 = '",g_ooef019,"' "
         #ELSE
         #   LET g_qryparam.where = " isac003 IN ('1','3') AND isac001 = '",g_ooef019,"' "
         #END IF
         #160902-00034#1 ---e---
         LET g_qryparam.where = " isac001 = '",g_ooef019,"' "  #161024-00066#1 add
         #LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('1','3') "  #161127-00003#1 add   #161229-00029#1 mark
         #161229-00029#1-----s
         IF l_apca.apca001 MATCHES '2*' THEN
            LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('3') "
         ELSE
            LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('1') "
         END IF
         #161229-00029#1-----e
         CALL q_isac002()                                
         LET g_isam_d[l_ac].isam008 = g_qryparam.return1
         DISPLAY g_isam_d[l_ac].isam008 TO isam008              
         NEXT FIELD isam008
         
      AFTER FIELD isam009
         IF NOT cl_null(g_isam_d[l_ac].isam009) THEN
            IF g_isam_d[l_ac].isam009 != g_isam_d_t.isam009 OR cl_null(g_isam_d_t.isam009) THEN
               CALL aapt300_03_invoice_repeat_chk(g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam008,g_apcadocno,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam014)
               RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam009 = g_isam_d_t.isam009
                  NEXT FIELD CURRENT              
               END IF
            END IF
         END IF 


      AFTER FIELD isam010
         IF NOT cl_null(g_isam_d[l_ac].isam010) THEN
            IF g_isam_d[l_ac].isam010 != g_isam_d_t.isam010 OR cl_null(g_isam_d_t.isam010) THEN
               #160923-00045#1---add---str--
               SELECT isac008 INTO l_isac008
                 FROM isac_t
                WHERE isacent = g_enterprise
                  AND isac001 = g_ooef019
                  AND isac002 = g_isam_d[l_ac].isam008
               #160923-00045#1---add---end--
               #160825-00039#1 add--s
               SELECT isai002,isai005 INTO l_isai002,l_isai005
                 FROM isai_t
                WHERE isaient = g_enterprise AND isai001 = g_ooef019
               #IF l_isai002 = "1" THEN                       #160923-00045#1 mark
               #IF l_isai002 = "1" AND l_isac008 != '4' THEN   #160923-00045#1 add   #161115-00002#1 mark
               IF l_isai002 = "1" AND l_isac008 NOT MATCHES "[04]" THEN              #161115-00002#1 add
                  #CALL aapt300_03_isad005_chk(g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam011,l_isai005)                         #161115-00002#1 mark
                  CALL aapt300_03_isad005_chk(g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam011,l_isai005,g_isam_d[l_ac].isam008)   #161115-00002#1 add
                       RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_isam_d[l_ac].isam010 = g_isam_d_t.isam010
                     NEXT FIELD isam010
                  END IF
               END IF
               #160825-00039#1 add--e
               CALL aapt300_03_invoice_repeat_chk(g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam008,g_apcadocno,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam014)
               RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam010 = g_isam_d_t.isam010
                  DISPLAY BY NAME g_isam_d[l_ac].isam010
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
     
      #161006-00011#2-----s
      AFTER FIELD isam011
         IF NOT cl_null(g_isam_d[l_ac].isam011)THEN
            IF g_isam_d[l_ac].isam011 != g_isam_d_t.isam011 OR cl_null(g_isam_d_t.isam011) THEN
               LET l_pmdldocdt = ''
               SELECT MIN(pmdldocdt) INTO l_pmdldocdt FROM pmdt_t,pmdl_t
                WHERE pmdtent = pmdlent AND pmdt001 = pmdldocno
                  AND pmdtent = g_enterprise
                  AND EXISTS (SELECT 1 FROM apcb_t WHERE apcbent = pmdlent 
                                 AND apcb008 = pmdldocno AND apcb001 = '11' 
                                 AND apcbld = g_apcald AND apcbdocno = g_apcadocno)
               IF NOT cl_null(l_pmdldocdt) THEN
                  IF g_isam_d[l_ac].isam011 < l_pmdldocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-01136'
                     LET g_errparam.extend = g_isam_d[l_ac].isam011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isam_d[l_ac].isam011 = g_isam_d_t.isam011
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
         END IF
      #161006-00011#2-----e
      AFTER FIELD isam012
         IF NOT cl_null(g_isam_d[l_ac].isam012) THEN 
            IF g_isam_d[l_ac].isam012 != g_isam_d_t.isam012 OR cl_null(g_isam_d_t.isam012) THEN   
               #抓取含稅否&稅率
               CALL s_tax_chk(g_apcacomp,g_isam_d[l_ac].isam012) RETURNING g_sub_success,g_isam_d[l_ac].isam012_desc_desc,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,l_oodb011       
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00164'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam012 = g_isam_d_t.isam012
                   CALL s_desc_get_tax_desc(g_ooef019,g_isam_d[l_ac].isam012) RETURNING g_isam_d[l_ac].isam012_desc_desc
                  DISPLAY BY NAME g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam012_desc_desc
                  NEXT FIELD CURRENT
               END IF              
               #稅別變更重新計算金額  
               IF NOT cl_null(g_isam_d[l_ac].isam025) AND NOT cl_null(g_isam_d[l_ac].isam014) AND NOT cl_null(g_isam_d[l_ac].isam015) THEN  
                  IF g_isam_d[l_ac].isam0121 = 'Y' THEN                 
                     CALL s_tax_count(g_apcacomp,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam025,1,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015)    
                        RETURNING g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                                 ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
                   ELSE     
                      CALL s_tax_count(g_apcacomp,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam023,1,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015)    
                        RETURNING g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                                 ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028  
                  END IF                                 
               END IF
                DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                               ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
               CALL aapt300_03_set_entry_money(g_isam_d[l_ac].isam0121)
               CALL s_desc_get_tax_desc(g_ooef019,g_isam_d[l_ac].isam012) RETURNING g_isam_d[l_ac].isam012_desc_desc
            END IF 
         END IF
         
      
     

      ON ACTION controlp INFIELD isam012
         #稅區
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 =  g_isam_d[l_ac].isam012
         LET g_qryparam.default2 = ""
         LET g_qryparam.default3 = g_isam_d[l_ac].isam0121 #含稅否
         LET g_qryparam.default4 = g_isam_d[l_ac].isam013
         LET g_qryparam.arg1 = g_ooef019                   
         CALL q_oodb002_5()
         LET  g_isam_d[l_ac].isam012  = g_qryparam.return1
         LET  g_isam_d[l_ac].isam0121 = g_qryparam.return3
         LET  g_isam_d[l_ac].isam013  = g_qryparam.return4
         CALL aapt300_03_set_entry_money(g_isam_d[l_ac].isam0121)
         CALL s_desc_get_tax_desc(g_ooef019,g_isam_d[l_ac].isam012) RETURNING g_isam_d[l_ac].isam012_desc_desc
         DISPLAY BY NAME g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013
         NEXT FIELD isam012                          #返回原欄位 
     
     
      AFTER FIELD isam014       
      IF NOT cl_null(g_isam_d[l_ac].isam014) THEN
         CALL s_aap_ooaj001_chk(g_apcald,g_isam_d[l_ac].isam014) RETURNING g_sub_success,g_errno
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
            LET g_isam_d[l_ac].isam014 = ''
            NEXT FIELD CURRENT
         END IF      
         #151105---s---
        #CALL s_fin_get_curr_rate(g_isam_d[l_ac].isamcomp,g_apcald,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam014,'')    #151223-00006#1
         CALL s_fin_get_curr_rate(g_isam_d[l_ac].isamcomp,g_apcald,l_apca.apcadocdt,g_isam_d[l_ac].isam014,ls_js)       #151223-00006#1
            RETURNING g_isam_d[l_ac].isam015,l_rate2,l_rate3
         #取得本幣金額
         IF g_isam_d[l_ac].isam015 = 1 THEN
            LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
            LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
            LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
         ELSE
            LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023 * g_isam_d[l_ac].isam015
            CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026 
            LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025 * g_isam_d[l_ac].isam015
            CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028
            LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
         END IF
            
        #151105---e---          
        DISPLAY BY NAME g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028         
      END IF         
      AFTER FIELD isam015
         IF NOT cl_null(g_isam_d[l_ac].isam014) THEN         
            #取得本幣金額
            IF g_isam_d[l_ac].isam015 = 1 THEN
               LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
               LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
               LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
            ELSE
               LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023 * g_isam_d[l_ac].isam015
               CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026 
               LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025 * g_isam_d[l_ac].isam015
               CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028
               LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
            END IF     
         END IF
      
      ON ACTION controlp INFIELD isam014
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_isam_d[l_ac].isam014
         LET g_qryparam.arg1 = g_apcacomp
         CALL q_ooaj002_1()
         LET g_isam_d[l_ac].isam014 = g_qryparam.return1
         DISPLAY BY NAME g_isam_d[l_ac].isam014
         NEXT FIELD isam014
       
      BEFORE FIELD isam023
         #160419-00022#1--add--start--
         IF g_isam_d[l_ac].isam0121 = 'Y' AND g_isam_d[l_ac].isam024 = 0 AND g_isam_d[l_ac].isam025 = 0 THEN
            NEXT FIELD isam025
         END IF
         #160419-00022#1--add--end----
         CALL aapt300_03_set_entry_money(g_isam_d[l_ac].isam0121)
         
      AFTER FIELD isam023  #原幣未稅金額     
         #紅字發票不可為正數
         IF NOT cl_null(g_isam_d[l_ac].isam023) THEN      
            IF cl_null(g_isam_d_t.isam023) OR (g_isam_d[l_ac].isam023 <> g_isam_d_t.isam023) THEN   #albireo 160127
               IF g_str = '2' AND g_isam_d[l_ac].isam023 > 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'aap-00215'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_isam_d[l_ac].isam023 = g_isam_d_t.isam023
                    NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #151105----s---
                IF g_str = '1' AND g_isam_d[l_ac].isam023 < 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aap-00365'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_isam_d[l_ac].isam023 = g_isam_d_t.isam023
                   NEXT FIELD CURRENT
                END IF
                #151105 add ---e---
               #檢核紅字發票是否超過扣抵金額
               IF g_str = '2' AND g_isai002 ='1' THEN
                    CALL aapt300_03_invoice_repeat_chk(g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam008,g_apcadocno,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam014) 
                    RETURNING g_sub_success,g_errno
                    IF NOT g_sub_success THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = g_errno
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET g_isam_d[l_ac].isam023 = g_isam_d_t.isam023
                       NEXT FIELD CURRENT
                    END IF
               END IF         
               IF cl_null(g_isam_d[l_ac].isam015) THEN LET g_isam_d[l_ac].isam015 = 1 END IF
               IF cl_null(g_isam_d[l_ac].isam013) THEN LET g_isam_d[l_ac].isam013 = 0 END IF 
               
               #151105 ---s---
               IF g_isam_d[l_ac].isam0121 = 'N' THEN 
                  CALL s_tax_count(g_apcacomp,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam023,1,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015)    
                      RETURNING g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                               ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
                                
               ELSE
                  LET g_isam_d[l_ac].isam024 = g_isam_d[l_ac].isam025 - g_isam_d[l_ac].isam023
                  
                  IF g_isam_d[l_ac].isam015 = 1 THEN
                     LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
                     LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
                     LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
                  ELSE
                     LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023 * g_isam_d[l_ac].isam015
                     CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026 
                     LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025 * g_isam_d[l_ac].isam015
                     CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028                     
                     LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
                  END IF         
               END IF
                  
               #151105 ---e---
               DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                              ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
            END IF   #albireo 160127
         END IF
         
         CALL aapt300_03_to_o(l_ac)   #albireo 160127
        

      AFTER FIELD isam024
         IF NOT cl_null(g_isam_d[l_ac].isam024) THEN  
            IF cl_null(g_isam_d_t.isam024) OR (g_isam_d[l_ac].isam024 <> g_isam_d_t.isam024) THEN   #albireo 160127         
               #紅字發票金額不可為正數
               IF g_str = '2' AND g_isam_d[l_ac].isam024 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam024 = g_isam_d_t.isam024
                  NEXT FIELD CURRENT
               END IF 
               #藍字發票不可為負數 #150515 ---s---
               IF g_str = '1' AND g_isam_d[l_ac].isam024 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam024 = g_isam_d_t.isam024
                  NEXT FIELD CURRENT
               END IF
               #151105 ---e--- 
               #檢查容差率
               CALL s_tax_sum_money_tax(g_isam_d[l_ac].isamcomp,g_ooef019,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025)              
               RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025  
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam024 = g_isam_d_t.isam024
                  NEXT FIELD CURRENT
               ELSE           
                  CALL s_curr_round_ld('1',g_apcald,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam024,2) #150915
                      RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam024                         #150915
                  IF cl_null(g_isam_d[l_ac].isam015) THEN LET g_isam_d[l_ac].isam015 = 1 END IF
                  IF cl_null(g_isam_d[l_ac].isam013) THEN LET g_isam_d[l_ac].isam013 = 0 END IF 
                  #容差率OK更新本幣金額
                  #151105 ---s---
                  IF g_isam_d[l_ac].isam015 = 1 THEN
                     LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023
                     LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
                     LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
                  ELSE 
                     IF g_isam_d[l_ac].isam0121 = 'Y' THEN                 
                        LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024 * g_isam_d[l_ac].isam015
                        CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam027,2) 
                           RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam027
                        LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam027  #150812-00010#3                              
                     ELSE     
                        LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024 * g_isam_d[l_ac].isam015                     
                        CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam027,2) 
                           RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam027
                        LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam026 + g_isam_d[l_ac].isam027  #150812-00010#3                     
                     END IF  
                  END IF 
                  #151105 ---e---                  
                  DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                                 ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028        
               END IF            
            END IF    #albireo 160127 
         END IF
         CALL aapt300_03_to_o(l_ac)   #albireo 160127
     #160419-00022#1--add--start--    
      BEFORE FIELD isam025
         IF g_isam_d[l_ac].isam0121 = 'N' AND g_isam_d[l_ac].isam023 = 0 AND g_isam_d[l_ac].isam024 = 0 THEN
            NEXT FIELD isam023
         END IF
     #160419-00022#1--add--end----   
      AFTER FIELD isam025
         #原幣含稅金額
         IF NOT cl_null(g_isam_d[l_ac].isam025) THEN
            IF cl_null(g_isam_d_t.isam025) OR (g_isam_d_t.isam025 <> g_isam_d[l_ac].isam025)THEN   #albireo 160127
               IF g_str = '2' AND g_isam_d[l_ac].isam025 > 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aap-00215'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_isam_d[l_ac].isam025 = g_isam_d_t.isam025
                   NEXT FIELD CURRENT
               END IF
               #藍字發票不可為負數 #150515 ---s---
               IF g_str = '1' AND g_isam_d[l_ac].isam025 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam025 = g_isam_d_t.isam025
                  NEXT FIELD CURRENT
               END IF                              
               IF cl_null(g_isam_d[l_ac].isam015) THEN LET g_isam_d[l_ac].isam015 = 1 END IF
               IF cl_null(g_isam_d[l_ac].isam013) THEN LET g_isam_d[l_ac].isam013 = 0 END IF 
               IF g_isam_d[l_ac].isam0121 = 'Y' THEN
                  CALL s_tax_count(g_apcacomp,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam025,1,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015)    
                      RETURNING g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
                               ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028                
               ELSE 
                  LET g_isam_d[l_ac].isam024 = g_isam_d[l_ac].isam025 - g_isam_d[l_ac].isam023
                  IF g_isam_d[l_ac].isam015 = 1 THEN
                     LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025
                     LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam024
                  ELSE
                     LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025 * g_isam_d[l_ac].isam015
                     CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) 
                             RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028
                     LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
                  END IF 
               END IF  
               #150515---e---              
               DISPLAY BY NAME   g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,
                                 g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028             
            END IF
         END IF
         CALL aapt300_03_to_o(l_ac)     #albireo 160127

      BEFORE FIELD isam026
         CALL aapt300_03_set_entry_money(g_isam_d[l_ac].isam0121)
         
      AFTER FIELD isam026              
         #本幣未稅金額
         IF NOT cl_null(g_isam_d[l_ac].isam026) THEN 
            IF cl_null(g_isam_d_t.isam026) OR (g_isam_d_t.isam026 <> g_isam_d[l_ac].isam026) THEN   #albireo 160127
               #紅字發票金額不可為正數            
               IF g_str = '2' AND g_isam_d[l_ac].isam026 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00215'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam026 = g_isam_d_t.isam026
                  NEXT FIELD CURRENT
               END IF                   
               #藍字發票不可為負數 #150515 add
               IF g_str= '1' AND g_isam_d[l_ac].isam026 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam026 = g_isam_d_t.isam026
                  NEXT FIELD CURRENT
               END IF


               #IF cl_null(g_isam_d[l_ac].isam015) THEN LET g_isam_d[l_ac].isam015 = 1 END IF
               #IF cl_null(g_isam_d[l_ac].isam013) THEN LET g_isam_d[l_ac].isam013 = 0 END IF 
               
               #發票本幣未稅金額 = 發票原幣未稅金額 * 匯率
               #LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam023 * g_isam_d[l_ac].isam015
              
              #幣別取位
               CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam026 ,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026  #150915                   
               #發票本幣含稅金額 =  發票本幣未稅金額 * 1+稅率/100             
               LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam026 * (1+(g_isam_d[l_ac].isam013/100))
               CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028 #150915
               #稅額=含稅-未稅
               LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
               #匯率>>以含稅金額重計匯率
               #LET g_isam_d[l_ac].isam015 = g_isam_d[l_ac].isam028 / g_isam_d[l_ac].isam025
               DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,
                               g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
            END IF   #albireo 160127
         END IF
         CALL aapt300_03_to_o(l_ac)   #albireo 160127
         
      AFTER FIELD isam027 #本幣稅額
         IF NOT cl_null(g_isam_d[l_ac].isam027) THEN 
            IF cl_null(g_isam_d_t.isam027) OR (g_isam_d_t.isam027 <> g_isam_d[l_ac].isam027)THEN   #albireo 160127
               #紅字發票金額不可為正數            
               IF g_str = '2' AND g_isam_d[l_ac].isam027 > 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'aap-00215'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_isam_d[l_ac].isam027 = g_isam_d_t.isam027
                    NEXT FIELD CURRENT
               END IF     
               #藍字發票不可為負數 #151105 ---s---
               IF g_str = '1' AND g_isam_d[l_ac].isam027 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00365'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam027 = g_isam_d_t.isam027
                  NEXT FIELD CURRENT
               END IF               
                  #151105 ---e--- 
               CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam027,2) #150915
                      RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam027                         #150915                  
               #檢核容差率            
               CALL s_tax_sum_money_tax(g_isam_d[l_ac].isamcomp,g_ooef019,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam008,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028)              
               RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028 
               #容差率OK否
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam027 = g_isam_d_t.isam027
                  NEXT FIELD CURRENT
               END IF

               DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,
                               g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
            END IF   #albrieo 160127
         END IF    
         CALL aapt300_03_to_o(l_ac)   #albireo 160127
         
      AFTER FIELD isam028  
         #本幣含稅金額      
         IF NOT cl_null(g_isam_d[l_ac].isam028) THEN 
            IF cl_null(g_isam_d_t.isam028) OR (g_isam_d_t.isam028 <> g_isam_d[l_ac].isam028)THEN   #albireo 160127
                #紅字發票金額不可為正數            
                IF g_str = '2' AND g_isam_d[l_ac].isam028 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00215'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isam_d[l_ac].isam028 = g_isam_d_t.isam028
                     NEXT FIELD CURRENT
                END IF
                IF cl_null(g_isam_d[l_ac].isam015) THEN LET g_isam_d[l_ac].isam015 = 1 END IF
                #發票本幣含稅金額 = 發票原幣含稅金額 * 匯率
                #LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam025 * g_isam_d[l_ac].isam015
                CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam028  #150915              
                IF cl_null(g_isam_d[l_ac].isam013) THEN LET g_isam_d[l_ac].isam013 = 0 END IF
                #發票本幣未稅金額 = 發票本幣含稅金額 / 1+稅率/100
                #LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam028 / (1+(g_isam_d[l_ac].isam013/100))
                CALL s_curr_round_ld('1',g_apcald,g_glaa001,g_isam_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_isam_d[l_ac].isam026 #150915
                #發票本幣稅額 = 發票本幣含稅金額 - 發票本幣未稅金額
                LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam028 - g_isam_d[l_ac].isam026
                DISPLAY BY NAME g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,
                                g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028                                                                       
            END IF   #albireo 160127 
         END IF
         CALL aapt300_03_to_o(l_ac)   #albireo 160127 
         
      #161021-00039#1---add---str--
      AFTER FIELD isam030
         #161129-00042#1-add(s)
         LET l_ooef011 = ' '
         SELECT ooef011 INTO l_ooef011 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_apcacomp
         IF l_ooef011 = 'TW' THEN
            #161230-00036#1-add(s)
            LET l_isac004 = ''
            LET l_isac008 = ''
            SELECT isac004,isac008 INTO l_isac004,l_isac008 FROM isac_t
             WHERE isacent = g_enterprise AND isac002 = g_isam_d[l_ac].isam008 AND isac001 = g_ooef019
            #IF l_isac008 NOT MATCHES '[4]' AND NOT cl_null(l_isac004) THEN                                              #170218-00012#1 mark
            IF l_isac008 NOT MATCHES '[4]' AND NOT cl_null(l_isac004) AND l_isac004 != '28' AND l_isac004 != '29' THEN   #170218-00012#1 add
            #161230-00036#1-add(e)
               IF NOT cl_null(g_isam_d[l_ac].isam030) THEN
               #161230-00036#1-mark(s)
               #   #先檢查輸入的營利事業統一編號是否為8碼或都為數字
               #   CALL s_rule_chk_vat_id_string(g_isam_d[l_ac].isam030) RETURNING l_success
               #   IF NOT l_success THEN
               #      LET g_isam_d[l_ac].isam030 = g_isam_d_o.isam030
               #      NEXT FIELD isam030
               #   END IF
               #161230-00036#1-mark(e)
               #161230-00036#1-add(s)     
               LET l_vat_id = g_isam_d[l_ac].isam030
               IF l_vat_id.getLength() <> 8  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-001388'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam030 = g_isam_d_o.isam030
                  NEXT FIELD isam030        
               END IF         
               IF NOT cl_chk_num(g_isam_d[l_ac].isam030,'N') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-001388'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam030 = g_isam_d_o.isam030
                  NEXT FIELD isam030
               END IF
               #161230-00036#1-add(e)
                  #檢查營利事業統一編號邏輯
                  CALL s_rule_chk_vat_id(l_ooef011,g_isam_d[l_ac].isam030) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_isam_d[l_ac].isam030 = g_isam_d[l_ac].isam030
                  END IF
               END IF
            END IF  #161230-00036#1-add
         END IF
         #161129-00042#1-add(e)
         #IF cl_null(g_isam_d[l_ac].isam008) THEN   #161124-00019#1 add   #161115-00002#1 mark
         IF cl_null(g_isam_d[l_ac].isam030) THEN                          #161115-00002#1 add
            SELECT ooef011 INTO l_ooef011
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apcacomp
            IF l_ooef011 = 'TW' THEN
               SELECT isac004,isac008 INTO l_isac004,l_isac008
                 FROM isac_t
                 LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
                WHERE isacent = g_enterprise
                  AND ooef001 = g_apcacomp
                  AND isac002 = g_isam_d[l_ac].isam008
               #IF l_isac008 <> '4' AND l_isac004 <> '28' AND l_isac004 <> '29' THEN              #161115-00002#1 mark
               IF l_isac008 NOT MATCHES "[04]" AND l_isac004 <> '28' AND l_isac004 <> '29' THEN   #161115-00002#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00601'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_isam_d[l_ac].isam030 = g_isam_d_t.isam030
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF    #161124-00019#1 add
         LET g_isam_d_o.* = g_isam_d[l_ac].*  #161230-00036#1-add(e)  
      #161021-00039#1---add---end-- 
      
      AFTER INPUT  
         #150917   ---s--- 如果只有一張發票apca066顯示一張發票號碼不然 顯示MULTI貨空白
         #IF g_prog = 'aapt301' OR g_prog = 'aapt341' THEN              #160705-00042#11 160714 by sakura mark
         #IF g_prog MATCHES 'aapt301' OR g_prog MATCHES 'aapt341' THEN   #160705-00042#11 160714 by sakura add  #161018-00022#1 mark
         #IF g_prog MATCHES 'aapt301' OR g_prog MATCHES 'aapt341' OR g_prog MATCHES 'aapt310' THEN   #161018-00022#1 add
         IF g_prog MATCHES 'aapt301' OR g_prog MATCHES 'aapt341' OR g_prog MATCHES 'aapt310' OR g_prog MATCHES 'aapt300' THEN   #161223-00014#1 add   
            LET l_count = 0
            SELECT COUNT(*) INTO l_count 
              FROM isam_t
             WHERE isament = g_enterprise
               AND isamdocno = g_apcadocno
               AND isam050 = g_apcadocno
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            
            CALL s_transaction_begin()
            CASE
               WHEN l_count = 0 
                  UPDATE apca_t
                     #SET apca066 = ''             #161019-00054#1 mark
                     SET apca066 = '',apca065 = '' #161019-00054#1 add  apca065
                   WHERE apcadocno = g_apcadocno
                     AND apcald = g_apcald
                     AND apcaent = g_enterprise
                  IF SQLCA.SQLCODE THEN 
                     CALL s_transaction_end('N',0)
                  END IF                    
               WHEN l_count = 1
                  #SELECT isam010 INTO l_isam010                   #161019-00054#1 mark
                  SELECT isam009,isam010 INTO l_isam009,l_isam010  #161019-00054#1 add  l_isam009
                    FROM isam_t 
                   WHERE isament = g_enterprise
                     AND isamdocno = g_apcadocno
                     AND isam050   = g_apcadocno
                 IF cl_null(l_isam009) THEN LET l_isam009 = ' ' END IF    #161019-00054#1 add   
                 IF cl_null(l_isam010) THEN LET l_isam010 = ' ' END IF                 
                 UPDATE apca_t
                    #SET apca066 = l_isam010                              #161019-00054#1 mark
                    SET apca066 = l_isam010,apca065 = l_isam009           #161019-00054#1 add
                  WHERE apcadocno = g_apcadocno
                    AND apcald = g_apcald
                    AND apcaent = g_enterprise
                  IF SQLCA.SQLCODE THEN 
                     CALL s_transaction_end('N',0)
                  END IF
               WHEN l_count > 1
                  UPDATE apca_t
                    #SET apca066 = 'MULTI'                   #161019-00054#1 mark
                    SET apca066 = 'MULTI',apca065 = 'MULTI'  #161019-00054#1 add 
                  WHERE apcadocno = g_apcadocno
                    AND apcald = g_apcald
                    AND apcaent = g_enterprise
                  IF SQLCA.SQLCODE THEN 
                     CALL s_transaction_end('N',0)
                  END IF
            END CASE
            SELECT count(*) INTO l_count
              FROM apcb_t
             WHERE apcbent = g_enterprise
               AND apcald  = g_apcald AND apcbdocno = g_apcadocno
            IF l_count > 0 THEN
               CALL s_aap_multi_bill_period(g_apcald,g_apcadocno) RETURNING g_sub_success,g_errno #151223-00006#1
            END IF
            CALL s_transaction_end('Y',0)
         END IF  
       #150917   ---s--- 
#      #若稅別or匯率有變更，須詢問是否重新推算單身金額
#         LET l_change_tax = 'N' 
#         LET l_change_rate = 'N'         
#         IF g_isam_d[l_ac].isam012 != g_isam_d_t.isam012 THEN
#            LET l_change_tax = 'Y'
#         END IF  
#         IF g_isam_d[l_ac].isam015 != g_isam_d_t.isam015 THEN
#            LET l_change_rate = 'Y'
#         END IF             
#         CASE 
#            WHEN l_change_tax = 'Y' AND l_change_rate = 'Y'         
#               IF cl_ask_confirm('aap-00338') THEN
#                  LET l_change = 'Y'
#               END IF         
#            WHEN l_change_tax = 'Y' 
#               IF cl_ask_confirm('aap-00337') THEN
#                  LET l_change = "Y"
#               END IF
#            WHEN l_change_rate = 'Y'
#               IF cl_ask_confirm('aap-00339')
#                  LET l_change = "Y"  
#               END IF
#         END CASE         
#         IF l_change = 'Y' THEN          
#            CALL s_tax_count(g_apcacomp,g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam023,1,g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015)    
#                RETURNING g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025
#                         ,g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028
#            UPDATE isam_t SET (isam023,isam024,isam025
#               ,isam026,isam027,isam028) = 
#               (g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025 l_apba103,l_apba104,l_apba105
#                g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,l_apba113,l_apba114,l_apba115)
#            WHERE isamdocno = g_isam_d[l_ac].isamdocno
#              AND isamseq   = g_isam_d[l_ac].isamseq
#              AND isament   = g_enterprise
#
#         END IF                        
         LET g_apcb_d5.* = g_isam_d.*
   END INPUT
         

END DIALOG

DIALOG aapt300_03_construct()

   CONSTRUCT g_wc_t300_03 ON isam001,isamdocno,isamseq,isam008,isam037,isam011,isam010,isam030,isam009,isam012, 
             isam012_desc_desc,isam0121,isam013,isam014,isam015,isam023,isam024,isam025,isam026,isam027, 
             isam028 
        FROM s_detail1_aapt300_03[1].isam001,s_detail1_aapt300_03[1].isamdocno,s_detail1_aapt300_03[1].isamseq, 
             s_detail1_aapt300_03[1].isam008,s_detail1_aapt300_03[1].isam037,s_detail1_aapt300_03[1].isam011, 
             s_detail1_aapt300_03[1].isam010,s_detail1_aapt300_03[1].isam030,s_detail1_aapt300_03[1].isam009, 
             s_detail1_aapt300_03[1].isam012,s_detail1_aapt300_03[1].isam012_desc_desc,s_detail1_aapt300_03[1].isam0121, 
             s_detail1_aapt300_03[1].isam013,s_detail1_aapt300_03[1].isam014,s_detail1_aapt300_03[1].isam015, 
             s_detail1_aapt300_03[1].isam023,s_detail1_aapt300_03[1].isam024,s_detail1_aapt300_03[1].isam025, 
             s_detail1_aapt300_03[1].isam026,s_detail1_aapt300_03[1].isam027,s_detail1_aapt300_03[1].isam028  
      BEFORE CONSTRUCT
         CALL cl_set_combo_scc('isam037','9719')
         #161101-00070#1 --s add
         #查詢時發票類型開窗稅區條件
         LET g_wc_ooef019 = ''
         SELECT ooef019 INTO g_wc_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
         #161101-00070#1 --e add
         
      ON ACTION controlp INFIELD isam008
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " isac001 = '",g_wc_ooef019,"' "  #161101-00070#1 add
         LET g_qryparam.where = g_qryparam.where, " AND isac003 in ('1','3') "  #161127-00003#1 add
         CALL q_isac002()
         DISPLAY g_qryparam.return1 TO isam008
         NEXT FIELD isam008
      
      ON ACTION controlp INFIELD isam012
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_oodb002()  
         DISPLAY g_qryparam.return1 TO isam012
         NEXT FIELD isam008
      
      ON ACTION controlp INFIELD isam014
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooai001()
         DISPLAY g_qryparam.return1 TO isam014
         NEXT FIELD isam014
   END CONSTRUCT
END DIALOG

 
{</section>}
 
{<section id="aapt300_03.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 配合CS使用
# Memo...........: 151207-00007#2
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_03_display_cs()
   
   LET g_isam_d[1].isam001 = ""
   DISPLAY ARRAY g_isam_d TO s_detail1_aapt300_03.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   
END FUNCTION
################################################################################
# Descriptions...: 下方合計金額顯示
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
PRIVATE FUNCTION aapt300_03_ref_amt()
   DEFINE l_amt1,l_amt2,l_amt3         LIKE apca_t.apca103
   DEFINE l_amt4,l_amt5,l_amt6         LIKE apca_t.apca103
   DEFINE l_amt7,l_amt8,l_amt9         LIKE apca_t.apca103
   DEFINE l_amt10,l_amt11,l_amt12      LIKE apca_t.apca103
   DEFINE l_isam023                    LIKE isam_t.isam023
   DEFINE l_isam024                    LIKE isam_t.isam024
   DEFINE l_isam026                    LIKE isam_t.isam026
   DEFINE l_isam027                    LIKE isam_t.isam027

#帳款合計金額
   #原幣
   LET l_amt1 = g_apca_t.apca103 - g_apca_t.apca106                      #未稅金額
   LET l_amt2 = g_apca_t.apca104                                         #稅額
   LET l_amt3 = g_apca_t.apca103 - g_apca_t.apca106 + g_apca_t.apca104   #含稅金額
   #本幣
   LET l_amt4 = g_apca_t.apca113 - g_apca_t.apca116                      #未稅金額
   LET l_amt5 = g_apca_t.apca114                                         #稅額
   LET l_amt6 = g_apca_t.apca113 - g_apca_t.apca116 + g_apca_t.apca114   #含稅金額
   
#帳款與發票差異金額
   SELECT SUM(isam023),SUM(isam024),SUM(isam026),SUM(isam027) INTO l_isam023,l_isam024,l_isam026,l_isam027 FROM isam_t
    WHERE isament = g_enterprise
      AND isamdocno = g_apca_t.apcadocno
      AND isam001 = 'aapt300'
   IF cl_null(l_isam023) THEN LEt l_isam023 = 0 END IF
   IF cl_null(l_isam024) THEN LEt l_isam024 = 0 END IF
   IF cl_null(l_isam026) THEN LEt l_isam026 = 0 END IF
   IF cl_null(l_isam027) THEN LEt l_isam027 = 0 END IF
   
   #原幣
   LET l_amt7 = l_amt1 - l_isam023
   LET l_amt8 = l_amt2 - l_isam024
   LET l_amt9 = l_amt7 + l_amt8
   #本幣
   LET l_amt10= l_amt4 - l_isam026
   LET l_amt11= l_amt5 - l_isam027
   LET l_amt12= l_amt10 + l_amt11
   
   DISPLAY l_amt1,l_amt2,l_amt3,     l_amt4,l_amt5,l_amt6,     l_amt7,l_amt8,l_amt9,      l_amt10,l_amt11,l_amt12
        TO apca103,apca104,apca1031, apca113,apca114,apca1131, apca026,apca027,apca0261,  apca028,apca029,apca0281

   LET g_amt = 0
   LET g_amt = l_amt7 + l_amt8 + l_amt9 + l_amt10 + l_amt11 + l_amt12

END FUNCTION
################################################################################
# Descriptions...: 本幣金額計算
# Memo...........:
# Usage..........: CALL aapt300_03_lcurr()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_lcurr()
   DEFINE l_ooab002      LIKE ooab_t.ooab002
   
   CALL cl_get_para(g_enterprise,g_glaa_t.glaacomp,'S-BAS-0015') RETURNING l_ooab002
   #原幣計算本幣
   #isam023 --> isam026
   IF NOT cl_null(g_isam_d[l_ac].isam023) THEN
      CALL aapt300_03_exrate(g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam014,g_glaa_t.glaa001,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam015)
         RETURNING g_isam_d[l_ac].isam026
   END IF
   #isam024 --> isam027
   IF NOT cl_null(g_isam_d[l_ac].isam024) THEN
      CALL aapt300_03_exrate(g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam014,g_glaa_t.glaa001,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam015)
         RETURNING g_isam_d[l_ac].isam027
   END IF
   #isam025 --> isam028
   IF NOT cl_null(g_isam_d[l_ac].isam025) THEN
      CALL aapt300_03_exrate(g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam014,g_glaa_t.glaa001,g_isam_d[l_ac].isam025,g_isam_d[l_ac].isam015)
         RETURNING g_isam_d[l_ac].isam028
   END IF
  
   DISPLAY  g_isam_d[l_ac].isam026, g_isam_d[l_ac].isam027, g_isam_d[l_ac].isam028
        TO s_detail1[l_ac].isam026,s_detail1[l_ac].isam027,s_detail1[l_ac].isam028
END FUNCTION
################################################################################
# Descriptions...: 計算本幣金額
# Memo...........:
# Usage..........: CALL aapt300_03_exrate
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_exrate(p_ooan004,p_ooan002,p_ooan003,p_amount,p_tmp)
   DEFINE p_ooan004      LIKE ooan_t.ooan004
   DEFINE p_ooan002      LIKE ooan_t.ooan002
   DEFINE p_ooan003      LIKE ooan_t.ooan003
   DEFINE p_amount       LIKE ooan_t.ooan005
   DEFINE p_tmp          LIKE ooan_t.ooan005
   DEFINE l_ooef014      LIKE ooef_t.ooef014
   DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
   DEFINE l_ooaj005      LIKE ooaj_t.ooaj005
   DEFINE l_ooan         RECORD
            ooan012      LIKE ooan_t.ooan012,
            ooan013      LIKE ooan_t.ooan013
                     END RECORD
   DEFINE l_conv         LIKE type_t.chr1
   DEFINE l_rate         LIKE ooan_t.ooan005
   DEFINE l_ooan001      LIKE ooan_t.ooan001

   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa_t.glaacomp

   #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,p_ooan003)
        RETURNING l_ooaj004

   #2.取基础币种的汇率精度
   CALL s_curr_sel_ooaj005(l_ooef014,p_ooan003)
        RETURNING l_ooaj005

   #3.取汇率 & 汇率方向
   LET l_conv = '1'  #交易币种对基础币种
   SELECT ooan012,ooan013 INTO l_ooan.ooan012,l_ooan.ooan013
     FROM ooan_t,ooam_t
    WHERE ooanent = g_enterprise
      AND ooan001 = g_glaa_t.glaa002   #汇率参照表号
      AND ooan002 = p_ooan002   #交易币种
      AND ooan003 = p_ooan003   #基础币种
      AND ooan004 = p_ooan004   #日期
      AND ooament = ooanent
      AND ooam001 = ooan001
      AND ooam003 = ooan003
      AND ooam004 = ooan004
      AND ooamstus = 'Y'
   IF SQLCA.sqlcode THEN
      #交易币种对基础币种的关系不存在时,反向查找
      SELECT ooan012,ooan013 INTO l_ooan.ooan012,l_ooan.ooan013
        FROM ooan_t,ooam_t
       WHERE ooanent = g_enterprise
         AND ooan001 = g_glaa_t.glaa002   #汇率参照表号
         AND ooan002 = p_ooan003   #基础币种
         AND ooan003 = p_ooan002   #交易币种
         AND ooan004 = p_ooan004
         AND ooament = ooanent
         AND ooam001 = ooan001
         AND ooam003 = ooan003
         AND ooam004 = ooan004
         AND ooamstus = 'Y'
      IF NOT SQLCA.sqlcode THEN
         LET l_conv = '2'   #基础币种对交易币种
      END IF
   END IF

   #交易币种批量
   IF cl_null(l_ooan.ooan012) THEN LET l_ooan.ooan012 = 1 END IF
   
   #4.计算汇率
   #减少处理步骤,以便精确度降低
   IF l_conv = '1' THEN  #存在交易对基础币种的置换关系
      IF l_ooan.ooan013 = '1' OR cl_null(l_ooan.ooan013) THEN   #存在正向的汇率关系
         LET l_rate = p_tmp / l_ooan.ooan012 * p_amount
      ELSE               #若为反向时,要1除取得的汇率
         LET l_rate = 1 / p_tmp * l_ooan.ooan012 * p_amount
      END IF
   ELSE                  #存在基础对交易币种的转换关系
      IF l_ooan.ooan013 = '1' THEN
         LET l_rate = 1 / p_tmp * l_ooan.ooan012 * p_amount
      ELSE
         LET l_rate = p_tmp / l_ooan.ooan012 * p_amount
      END IF
   END IF

   #5.按精度进位小数取位
   IF p_amount > 1 THEN
      #传入的为金额,直接按ooaj004取位
      CALL s_num_round('1',l_rate,l_ooaj004) RETURNING l_rate
   ELSE
      #没有传入金额,根据汇率的精度进行取位
      CALL s_num_round('1',l_rate,l_ooaj005) RETURNING l_rate
   END IF

   RETURN l_rate

END FUNCTION
################################################################################
# Descriptions...: 新增時給默認值
# Memo...........:
# Usage..........: CALL aapt300_03_default_ins()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_default_ins()
   #DEFINE l_apca     RECORD LIKE apca_t.* #161104-00024#2 mark
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
   #161104-00024#2-add(e)
   
   #SELECT * INTO l_apca.*   #161208-00026#6 mark
   #161208-00026#6-add(s)
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
     INTO l_apca.* 
   #161208-00026#6-add(e)
     FROM apca_t   
    WHERE apcaent = g_enterprise
      AND apcadocno = g_apcadocno
      AND apcald = g_apcald
   
   IF cl_null(l_apca.apcadocno) THEN
      INITIALIZE l_apca TO NULL
   END IF

   #取得該法人的稅區
  #SELECT ooef019 INTO g_ooef019                                #150925 mark
   SELECT ooef019,ooef002 INTO g_ooef019,g_isam_d[l_ac].isam017 #150925
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = l_apca.apcacomp
    
   SELECT isak009,isak010,isak011,isak012
     INTO g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034
     FROM isak_t
    WHERE isakent = g_enterprise     
      AND isak001 = l_apca.apca004
       AND isak002= g_ooef019
   
   #150925 mark ------
   #SELECT isao001,isao002,isao003,isao003,isao004,isao005
   #  INTO g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,
   #150925 mark end---
   #150925 add ------
   SELECT isao002,isao003,isao003,isao004,isao005
     INTO g_isam_d[l_ac].isam018,g_isam_d[l_ac].isam019,
   #150925 add end---
          g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021
     FROM isao_t
    WHERE isaoent = g_enterprise
      AND isaosite= l_apca.apcasite
  
   SELECT pmaa003 INTO g_isam_d[l_ac].isam030 FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = l_apca.apca004
      
   SELECT pmaal003 INTO g_isam_d[l_ac].isam029 FROM pmaal_t
    WHERE pmaalent = g_enterprise
      AND pmaal001 = l_apca.apca004
      AND pmaal002 = g_dlang
      
   SELECT ooefl004 INTO g_isam_d[l_ac].isam016 FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = l_apca.apcasite
      AND ooefl002 = g_lang

   LET g_isam_d[l_ac].isamcomp = l_apca.apcacomp
   LET g_isam_d[l_ac].isamstus = 'Y'
   LET g_isam_d[l_ac].isamdocno = g_apcadocno
   LET g_isam_d[l_ac].isam001 = g_prog
   LET g_isam_d[l_ac].isam002 = l_apca.apca004
   LET g_isam_d[l_ac].isam004 = l_apca.apca015
   IF cl_null(l_apca.apcadocdt ) THEN 
      LET l_apca.apcadocdt  = g_today
   END IF
   LET g_isam_d[l_ac].isam011 = l_apca.apcadocdt
   LET g_isam_d[l_ac].isam012 = l_apca.apca011
   LET g_isam_d[l_ac].isam0121= l_apca.apca013
   LET g_isam_d[l_ac].isam013 = l_apca.apca012
   LET g_isam_d[l_ac].isam014 = l_apca.apca100
   LET g_isam_d[l_ac].isam015 = l_apca.apca101
   IF l_ac = 1 THEN
      IF cl_null(l_apca.apca103) THEN LET l_apca.apca103 = 0 END IF
      IF cl_null(l_apca.apca104) THEN LET l_apca.apca104 = 0 END IF
      IF cl_null(l_apca.apca113) THEN LET l_apca.apca113 = 0 END IF
      IF cl_null(l_apca.apca114) THEN LET l_apca.apca114 = 0 END IF
      LET g_isam_d[l_ac].isam023 = l_apca.apca103
      LET g_isam_d[l_ac].isam024 = l_apca.apca104
      LET g_isam_d[l_ac].isam025 = g_isam_d[l_ac].isam023 + g_isam_d[l_ac].isam024
      LET g_isam_d[l_ac].isam026 = l_apca.apca113
      LET g_isam_d[l_ac].isam027 = l_apca.apca114
      LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam026 + g_isam_d[l_ac].isam027
   END IF   
   #160902-00034#1---s---
   IF g_prog MATCHES 'aapt341' THEN 
      LET g_isam_d[l_ac].isam023 = g_isam_d[l_ac].isam023 * -1
      LET g_isam_d[l_ac].isam024 = g_isam_d[l_ac].isam024 * -1
      LET g_isam_d[l_ac].isam025 = g_isam_d[l_ac].isam025 * -1
      LET g_isam_d[l_ac].isam026 = g_isam_d[l_ac].isam026 * -1
      LET g_isam_d[l_ac].isam027 = g_isam_d[l_ac].isam027 * -1
      LET g_isam_d[l_ac].isam028 = g_isam_d[l_ac].isam028 * -1
   END IF
   #160902-00034#1---e---
   LET g_isam_d[l_ac].isam037 = 1
   LET g_isam_d[l_ac].isam038 = 0
   LET g_isam_d[l_ac].isam039 = 1
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isam_d[l_ac].isam012
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||g_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isam_d[l_ac].isam012_desc_desc = '', g_rtn_fields[1] , ''
   SELECT MAX(isamseq) INTO g_isam_d[l_ac].isamseq
     FROM isam_t
    WHERE isament = g_enterprise
      AND isamdocno = g_apcadocno
      AND isam001 = g_prog   
      
   IF cl_null(g_isam_d[l_ac].isamseq) THEN
      LET g_isam_d[l_ac].isamseq = 1
   ELSE
      LET g_isam_d[l_ac].isamseq = g_isam_d[l_ac].isamseq +1
   END IF

END FUNCTION
################################################################################
# Descriptions...: 含稅、未稅金額計算
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
PRIVATE FUNCTION aapt300_03_tax()
   DEFINE l_ooef014      LIKE ooef_t.ooef014
   DEFINE l_ooaj004      LIKE ooaj_t.ooaj004

   IF g_isam_d[l_ac].isam021 = 'Y' THEN
      IF NOT cl_null(g_isam_d[l_ac].isam013) AND NOT cl_null(g_isam_d[l_ac].isam025) THEN
         LET g_isam_d[l_ac].isam023 = g_isam_d[l_ac].isam025 / (1+ g_isam_d[l_ac].isam013/100)
         LET g_isam_d[l_ac].isam024 = g_isam_d[l_ac].isam025 - g_isam_d[l_ac].isam023
      END IF
   ELSE
      IF NOT cl_null(g_isam_d[l_ac].isam013) AND NOT cl_null(g_isam_d[l_ac].isam023) THEN
         LET g_isam_d[l_ac].isam024 = g_isam_d[l_ac].isam023 * g_isam_d[l_ac].isam013/100
         LET g_isam_d[l_ac].isam025 = g_isam_d[l_ac].isam023 + g_isam_d[l_ac].isam024
      END IF
   END IF
   
   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa_t.glaacomp
   
   CALL s_curr_sel_ooaj004(l_ooef014,g_isam_d[l_ac].isam014)
        RETURNING l_ooaj004

   CALL s_num_round('1',g_isam_d[l_ac].isam023,l_ooaj004) RETURNING g_isam_d[l_ac].isam023
   CALL s_num_round('1',g_isam_d[l_ac].isam024,l_ooaj004) RETURNING g_isam_d[l_ac].isam024
   CALL s_num_round('1',g_isam_d[l_ac].isam025,l_ooaj004) RETURNING g_isam_d[l_ac].isam025
   
   DISPLAY  g_isam_d[l_ac].isam023, g_isam_d[l_ac].isam024, g_isam_d[l_ac].isam025
        TO s_detail1[l_ac].isam023,s_detail1[l_ac].isam024,s_detail1[l_ac].isam025

END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: aapt300_03_b_fill1(p_docno)
# Date & Author..: 2014/10/14 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_03_b_fill1(p_docno,p_ld)
DEFINE p_docno       LIKE apca_t.apcadocno   #單據編號 
DEFINE p_ld          LIKE apca_t.apcald
#DEFINE l_apca     RECORD LIKE apca_t.* #161104-00024#2 mark
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
#161104-00024#2-add(e)
   
   LET g_apcald = p_ld
   LET g_apcadocno = p_docno  
   
   #SELECT * INTO l_apca.*   #161208-00026#6 mark
   #161208-00026#6-add(s)
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
     INTO l_apca.*
   #161208-00026#6-add(e)
     FROM apca_t   
    WHERE apcaent = g_enterprise
      AND apcadocno = g_apcadocno
      AND apcald = g_apcald
      
   #取得稅區
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_apca.apcacomp  
   CALL aapt300_03_clear_detail()
   
   CALL cl_set_combo_scc('isam037','9719')   
   LET l_ac = 1
   LET g_apcadocno = p_docno
   LET g_sql = "   SELECT isam001,isamdocno,isamseq,isam008,isam037,isam011,isam009,isam010,           ", 
               "          isam030,isam012,isam0121,isam013,isam014,isam015,isam023,isam024,            ", 
               "          isam025,isam026,isam027,isam028,isamcomp,isamstus,isam002,isam004,isam016,   ", 
               "          isam017,isam018,isam019,isam020,isam021,isam022,isam029,isam031,isam032,     ",
               "          isam033,isam034,isam038,isam039                                              ",  
               "     FROM isam_t                                                                       ",
               "    WHERE isament = '",g_enterprise,"'                                                 ",
              #"      AND isamdocno = isam050                                                          ",               #避免由110來的資料看不到
               "      AND isam050 = '",p_docno,"'                                                      ", 
               " ORDER BY isamseq                                                            "
   
   PREPARE aapt300_03_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aapt300_03_pb1

   FOREACH b_fill_curs1 
      INTO g_isam_d[l_ac].isam001 ,g_isam_d[l_ac].isamdocno,g_isam_d[l_ac].isamseq,g_isam_d[l_ac].isam008, 
           g_isam_d[l_ac].isam037,g_isam_d[l_ac].isam011,g_isam_d[l_ac].isam009,g_isam_d[l_ac].isam010,g_isam_d[l_ac].isam030,
           g_isam_d[l_ac].isam012,g_isam_d[l_ac].isam0121,g_isam_d[l_ac].isam013,
           g_isam_d[l_ac].isam014,g_isam_d[l_ac].isam015,g_isam_d[l_ac].isam023,g_isam_d[l_ac].isam024,g_isam_d[l_ac].isam025,
           g_isam_d[l_ac].isam026,g_isam_d[l_ac].isam027,g_isam_d[l_ac].isam028,g_isam_d[l_ac].isamcomp,g_isam_d[l_ac].isamstus, 
           g_isam_d[l_ac].isam002,g_isam_d[l_ac].isam004,g_isam_d[l_ac].isam016,g_isam_d[l_ac].isam017,g_isam_d[l_ac].isam018, 
           g_isam_d[l_ac].isam019,g_isam_d[l_ac].isam020,g_isam_d[l_ac].isam021,g_isam_d[l_ac].isam022,g_isam_d[l_ac].isam029, 
           g_isam_d[l_ac].isam031,g_isam_d[l_ac].isam032,g_isam_d[l_ac].isam033,g_isam_d[l_ac].isam034,g_isam_d[l_ac].isam038, 
           g_isam_d[l_ac].isam039
  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #稅別說明
      CALL s_desc_get_tax_desc(g_ooef019,g_isam_d[l_ac].isam012) RETURNING g_isam_d[l_ac].isam012_desc_desc
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_isam_d.deleteElement(g_isam_d.getLength())   
   LET g_rec_b04 = l_ac - 1
   LET g_apcb_d5.* = g_isam_d.*
   
   FREE b_fill_curs1        
              
END FUNCTION

################################################################################
# Descriptions...: 依含稅否開放相關金額欄位
# Memo...........:
# Usage..........: CALL aapt300_03_set_entry_money(p_apbb121)
# Input parameter: p_apbb0121   含稅否
# Date & Author..: 2014/01/09 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_03_set_entry_money(p_apbb0121)
DEFINE p_apbb0121 LIKE apbb_t.apbb0121   
   
 # CALL cl_set_comp_entry("isam023,isam025,isam026,isam028",FALSE)
   #含稅>>  未稅金額皆關閉
   #未稅>>  含稅金額皆關閉
   IF p_apbb0121 = 'Y' THEN
 #     CALL cl_set_comp_entry("isam025,isam028",TRUE)
   ELSE
 #     CALL cl_set_comp_entry("isam023,isam026",TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 清空單身
# Memo...........:
# Usage..........: CALL aapt300_03_clear_detail()
# Date & Author..: 2015/01/13 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_03_clear_detail()
   CALL g_isam_d.clear()
END FUNCTION

################################################################################
# Descriptions...: 檢查是否為紅字發票
# Memo...........:
# Usage..........: CALL aapt300_03_isac003_chk()
# Date & Author..: 2015/01/30 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_isac003_chk(p_ooef019)
   DEFINE l_isac003 LIKE isac_t.isac003
   DEFINE p_ooef019 LIKE ooef_t.ooef019 
     
   SELECT isac003 INTO l_isac003 
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = p_ooef019 
      AND isac002 = g_isam_d[l_ac].isam008
   #1藍字2紅字
   CASE l_isac003
      WHEN 1 
         LET g_str = '1'
      WHEN 2 
         LET g_str = '1'
      WHEN 3
         LET g_str = '2'
      WHEN 4 
         LET g_str = '2'
    END CASE    
        
END FUNCTION

################################################################################
# Descriptions...: 檢查發票是否重複輸入
# Memo...........:
# Usage..........: CALL aapt300_03_invoice_repeat_chk(p_code,p_number,p_type,p_docno,p_money)
#                  RETURNING r_success,r_errno
# Input parameter: p_code    發票代碼
#                : p_number  發票號碼
#                : p_type    發票類型
#                : p_docno   收票單據
#                : p_money   目前輸入的金額
#                : p_curr    幣別
# Date & Author..: 2015/02/02 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_invoice_repeat_chk(p_code,p_number,p_type,p_docno,p_money,p_curr)
DEFINE p_code           LIKE isam_t.isam009
DEFINE p_number         LIKE isam_t.isam010
DEFINE p_type           LIKE isam_t.isam008
DEFINE p_docno          LIKE isam_t.isamdocno
DEFINE p_money          LIKE isam_t.isam023
DEFINE p_curr           LIKE isam_t.isam014
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sum_red        LIKE isam_t.isam023
DEFINE l_sum_blue       LIKE isam_t.isam023
#160107-00004#3 add ------
DEFINE l_sql            STRING
DEFINE l_apcadocdt      LIKE apca_t.apcadocdt
DEFINE l_apca004        LIKE apca_t.apca004
DEFINE l_isac008        LIKE isac_t.isac008
DEFINE l_ooef011        LIKE ooef_t.ooef011
DEFINE l_bdate          LIKE type_t.dat
DEFINE l_edate          LIKE type_t.dat
#160107-00004#3 add end---

#發票重複檢核：
#有發票代碼：
#發票號碼+發票代碼>>不能重複
#(A單據跟B單據or同一張單據的發票號碼都不能重複)
#沒發票代碼：
#1.藍字發票
#發票類型+發票號碼>>不能重複
#(A單據跟B單據or同一張單據的發票號碼都不能重複
#2.紅字發票：
#可以打多張同張發票類型+發票號碼
#(金額不能超過原來的藍字發票總金額(包含本身單據))
#*要排除本单单身的发票号码
#單頭輸入完發票號碼也要check(發票類型也要存在再檢查)
#單頭紅字發票不check單身在檢查
#160107-00004#3修改檢核原則：
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
   
   #160107-00004#3 mark ------
   #抓取"發票編碼方式"區分是大陸or台灣
   #SELECT isai002 INTO g_isai002
   #  FROM ooef_t
   #  LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apcacomp
   #160107-00004#3 mark end---
   #160107-00004#3 add ------
   #改抓專屬國家地區功能來判斷
   SELECT ooef011 INTO l_ooef011
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_apcacomp
   #取得單據日期/帳款對象
   SELECT apcadocdt,apca004 INTO l_apcadocdt,l_apca004
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcadocno = p_docno
   #160107-00004#3 add end---
   
   #China
  #IF g_isai002 = "2" THEN   #160107-00004#3 mark
   IF l_ooef011 <> "TW" THEN #160107-00004#3
      SELECT COUNT(*) INTO l_cnt
        FROM isam_t
       WHERE isament = g_enterprise
         AND isam009 = p_code
         AND isam010 = p_number
         AND isam036 IN ('11','11Y')
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00121'
      END IF
   ELSE #Taiwan
      IF g_str = '1' THEN
         
         #160107-00004#3 add ------
         #抓取發票聯別
         SELECT isac008 INTO l_isac008
           FROM isac_t
           LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
          WHERE isacent = g_enterprise
            AND ooef001 = g_apcacomp
            AND isac002 = p_type
         CALL s_date_get_ymtodate(YEAR(l_apcadocdt),1,YEAR(l_apcadocdt),12) RETURNING l_bdate,l_edate
         IF l_isac008 = '4' THEN
            #廠商+發票號碼>>不可重覆
            LET l_sql = "SELECT COUNT(*)",
                        "  FROM isam_t",
                        " WHERE isament = ",g_enterprise,
                        "   AND isam008 = '",p_type,"'",
                        "   AND isam010 = '",p_number,"'",
                        "   AND isam036 IN ('11','11Y') ",
                        "   AND isamstus <> 'X' ",
                        "   AND isam002 = '",l_apca004,"'"
            PREPARE isam_sel_tw_pb1 FROM l_sql
            EXECUTE isam_sel_tw_pb1 INTO l_cnt
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt > 0 THEN
               LET r_success = FALSE
               LET r_errno = 'ais-00257'
            END IF
         ELSE
         #160107-00004#3 add end---
            SELECT COUNT(*) INTO l_cnt
              FROM isam_t
             WHERE isament = g_enterprise
               #AND isam008 = p_type                    #161019-00030#1 mark
               AND isam010 = p_number
               AND isam036 IN ('11','11Y')
               AND isamstus <> 'X'   #151112
               AND isam011 BETWEEN l_bdate AND l_edate  #160107-00004#3
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            IF l_cnt > 0 THEN
               LET r_success = FALSE
               LET r_errno = 'ais-00123'
            END IF
         END IF  #160107-00004#3 add
      ELSE
         IF NOT cl_null(p_money) THEN
            #紅字發票的總和
            SELECT SUM(isam023) INTO l_sum_red
              FROM isam_t
             WHERE isament = g_enterprise
              #AND isam008 IN (SELECT isac002 FROM isac_t WHERE isac001 = g_ooef019 AND isac003 = '3') #160905-00002#1 mark
               AND isam008 IN (SELECT isac002 FROM isac_t WHERE isacent = g_enterprise #160905-00002#1
                                  AND isac001 = g_ooef019 AND isac003 = '3')           #160905-00002#1
               AND isam010 = p_number
               AND isam014 = p_curr
               AND isam036 IN ('11','11Y')
            IF cl_null(l_sum_red) THEN LET l_sum_red = 0 END IF
            LET l_sum_red = s_math_abs(l_sum_red) + s_math_abs(p_money)
            #藍字發票的總和
            SELECT isam023 INTO l_sum_blue
              FROM isam_t
             WHERE isament = g_enterprise
              #AND isam008 NOT IN (SELECT isac002 FROM isac_t WHERE isac001 = g_ooef019 AND isac003 = '3') #160905-00002#1 mark
               AND isam008 NOT IN (SELECT isac002 FROM isac_t WHERE isacent = g_enterprise #160905-00002#1
                                      AND isac001 = g_ooef019 AND isac003 = '3')           #160905-00002#1
               AND isam010 = p_number
               AND isam014 = p_curr
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
# Descriptions...: 用"發票編碼方式"決定是否隱藏"發票代碼"
# Memo...........:
# Usage..........: CALL aapt300_03_set_entry_invoice_code()
# Date & Author..: 2015/02/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_set_entry_invoice_code()
 
   SELECT isai002 INTO g_isai002
     FROM ooef_t
     LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
    WHERE ooefent = g_enterprise
      AND ooef001 = g_apcacomp
   IF g_isai002 = "1" THEN
      CALL cl_set_comp_visible('isam009',FALSE)
   ELSE
      CALL cl_set_comp_visible('isam009',TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 數值類舊值備份
# Memo...........:
# Date & Author..: 160127 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_03_to_o(p_ac)
   DEFINE p_ac   LIKE type_t.num10

   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   LET g_isam_d_t.isam023 = g_isam_d[p_ac].isam023
   LET g_isam_d_t.isam024 = g_isam_d[p_ac].isam024
   LET g_isam_d_t.isam025 = g_isam_d[p_ac].isam025
   LET g_isam_d_t.isam026 = g_isam_d[p_ac].isam026
   LET g_isam_d_t.isam027 = g_isam_d[p_ac].isam027
   LET g_isam_d_t.isam028 = g_isam_d[p_ac].isam028
END FUNCTION

################################################################################
# Descriptions...: 檢查發票日期與發票字軌需同年月
# Memo...........: 
# Usage..........: CALL aapt110_isad005_chk (p_isam010,p_isam011,p_isai005)
#                  RETURNING r_success,r_errno
# Input parameter: p_isam010   發票號碼
#                : p_isam011   發票日期
#                : p_isai005   字轨长度
#                : p_isam008   發票類型   #161115-00002#1 add
# Return code....: r_success   成功否
#                : r_errno     錯誤代碼
# Date & Author..: #160825-00039#1 16/08/29 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_03_isad005_chk(p_isam010,p_isam011,p_isai005,p_isam008)
DEFINE p_isam010        LIKE isam_t.isam010
DEFINE p_isam011        LIKE isam_t.isam011
DEFINE p_isai005        LIKE isai_t.isai005
DEFINE p_isam008        LIKE isam_t.isam008   #161115-00002#1 add
DEFINE r_success        LIKE type_t.num5
DEFINE l_isad002        LIKE isad_t.isad002
DEFINE l_isad003        LIKE isad_t.isad003
DEFINE l_isad005        LIKE isad_t.isad005
DEFINE l_errno          LIKE gzze_t.gzze001
DEFINE l_isadstus       LIKE isad_t.isadstus
DEFINE l_isam010        LIKE isam_t.isam010   #161021-00039#1 add
DEFINE l_ooef011        LIKE ooef_t.ooef011   #161021-00039#1 add
DEFINE l_str            STRING                #161021-00039#1 add
DEFINE l_i              LIKE type_t.num5      #161021-00039#1 add
DEFINE l_isac004        LIKE isac_t.isac004   #161115-00002#1 add

   LET r_success = TRUE
   
   #IF cl_null(p_isam010) OR cl_null(p_isam011) THEN                        #161115-00002#1 mark
   IF cl_null(p_isam010) OR cl_null(p_isam011) OR cl_null(p_isam008) THEN   #161115-00002#1 add
      RETURN r_success
   END IF
   IF cl_null(p_isai005) THEN LET p_isai005=2 END IF
   
   LET l_isad002 = YEAR(p_isam011)
   LET l_isad003 = MONTH(p_isam011)
   LET l_isad005 = p_isam010[1,p_isai005]
   
   #161115-00002#1---add---str--
   SELECT ooef011,isac004 INTO l_ooef011,l_isac004
     FROM isac_t
     LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
    WHERE isacent = g_enterprise
      AND ooef001 = g_apcacomp
      AND isac002 = p_isam008
   #161115-00002#1---add---end--
   
  #讀取發票字頭檔之資料並檢查年別+月+字軌
   IF l_isac004 != '28' AND l_isac004 != '29' THEN   #161115-00002#1 add 發票格式為28/29海關繳納憑證,不需檢查字軌
      SELECT isadstus INTO l_isadstus
        FROM isad_t
       WHERE isadent = g_enterprise
         AND isad001 = g_ooef019   #税区
         AND isad002 = l_isad002   #年度
         AND l_isad003 BETWEEN isad003 AND isad004  #起始月份，终止月份
         AND isad005 = l_isad005   #发票字轨
      CASE
         WHEN SQLCA.sqlcode = 100  LET l_errno = 'ais-00005'   #输入的资料不存在于发票字轨维护作业[aisi040]当前营运据点交易税区年月中,请检查！
         WHEN l_isadstus <> 'Y'    LET l_errno = 'ais-00006'   #输入的资料在发票字轨维护作业[aisi040]当前营运据点交易税区年月中无效,请检查！
         OTHERWISE                 LET l_errno = SQLCA.SQLCODE USING '-----'
      END CASE
      IF NOT cl_null(l_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = p_isam010
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF   #161115-00002#1 add
   
   #161021-00039#1---add---str--
   #161115-00002#1---mark---str--
   #SELECT ooef011 INTO l_ooef011
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_apcacomp
   #161115-00002#1---mark---end--  
   IF l_ooef011 = 'TW' THEN
      LET l_str = p_isam010
      IF NOT cl_null(l_isac004) THEN #161230-00036#1 add
         IF l_isac004 != '28' AND l_isac004 != '29' THEN   #161115-00002#1 add
            IF l_str.getLength() != 10 THEN
               LET l_errno = 'aap-00597'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = p_isam010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            FOR l_i = 3 TO 10
               LET l_isam010 = p_isam010[l_i,l_i]
               IF l_isam010 NOT MATCHES "[0123456789]" THEN
                  LET l_errno = 'aap-00597'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = p_isam010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            END FOR
         #161115-00002#1---add---str--
         ELSE
            IF l_str.getLength() != 14 THEN
               LET l_errno = 'aap-00603'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = p_isam010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF NOT(p_isam010[1,1] MATCHES '[A-Z]' AND p_isam010[2,2] MATCHES '[A-Z]' AND p_isam010[3,3] MATCHES '[A-Z]') THEN
               LET l_errno = 'aap-00603'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = p_isam010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            FOR l_i = 4 TO 14
               LET l_isam010 = p_isam010[l_i,l_i]
               IF l_isam010 NOT MATCHES "[0123456789]" THEN
                  LET l_errno = 'aap-00603'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = p_isam010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            END FOR
         END IF
         #161115-00002#1---add---end--
      END IF   #161230-00036#1 add
   END IF
   #161021-00039#1---add---end--

   RETURN r_success
END FUNCTION

 
{</section>}
 
