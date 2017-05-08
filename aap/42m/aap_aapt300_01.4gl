#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-03-08 15:24:41), PR版次:0013(2017-02-14 10:58:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000273
#+ Filename...: aapt300_01
#+ Description: 應付多帳期帳款明細
#+ Creator....: 01727(2014-01-23 18:23:21)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt300_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150225  15/02/25 By Reanna  新增時有錯誤
#150925-00006     2015/10/08 By albireo   aapt320執行時不可維護
#151216-00008#4   2015/12/28 By albireo   採購訂單有多帳期，出貨款跟尾款時，應付帳款單應該有分兩種帳期，出貨尾款分別展多帳期
#160106           2016/01/06 By albireo   無單,處理ins apcc的預設值
#160829-00004#1   2016/09/05 By 08729     處理匯率取錯幣別
#160905-00002#1   2016/09/05 By Reanna    SQL條件少ENT補上(硬框架調整)
#161104-00024#2   2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#3   2016/11/09 By Reanna    程式中INSERT INTO 有星號作整批調整
#161208-00026#5   2016/12/09 By 08729     針對SELECT有星號的部分進行展開
#170202-00028#1   170203     By albireo   不允許修改付款條件,因展多期時日期展算並不準確,若自行新增時,以帳款單頭付款條件做預設,付款日與票期日自行輸入
#170209-00014#1   2017/02/14 By 06821     aapq342執行時僅提供查詢使用
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
PRIVATE TYPE type_g_apcc_d RECORD
       apcc015 LIKE apcc_t.apcc015, 
   l_apcc015_desc LIKE type_t.chr100, 
   apccdocno LIKE apcc_t.apccdocno, 
   apccld LIKE apcc_t.apccld, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc002 LIKE apcc_t.apcc002, 
   apcc003 LIKE apcc_t.apcc003, 
   ooib002 LIKE type_t.chr500, 
   apcc004 LIKE apcc_t.apcc004, 
   apcc009 LIKE apcc_t.apcc009, 
   apcc108 LIKE apcc_t.apcc108, 
   apcc101 LIKE apcc_t.apcc101, 
   apcc118 LIKE apcc_t.apcc118, 
   apcc109 LIKE apcc_t.apcc109, 
   apcc119 LIKE apcc_t.apcc119, 
   apcc102 LIKE apcc_t.apcc102, 
   apcc113 LIKE apcc_t.apcc113, 
   l_cal1 LIKE type_t.num20_6, 
   l_cal2 LIKE type_t.num20_6, 
   apcc105 LIKE apcc_t.apcc105, 
   apcc106 LIKE apcc_t.apcc106, 
   apcc107 LIKE apcc_t.apcc107, 
   apcc104 LIKE apcc_t.apcc104, 
   apcc115 LIKE apcc_t.apcc115, 
   apcc116 LIKE apcc_t.apcc116, 
   apcc117 LIKE apcc_t.apcc117, 
   apcc114 LIKE apcc_t.apcc114, 
   apcc005 LIKE apcc_t.apcc005, 
   apcc006 LIKE apcc_t.apcc006, 
   apcc100 LIKE apcc_t.apcc100, 
   apcc103 LIKE apcc_t.apcc103, 
   apcc120 LIKE apcc_t.apcc120, 
   apcc121 LIKE apcc_t.apcc121, 
   apcc122 LIKE apcc_t.apcc122, 
   apcc130 LIKE apcc_t.apcc130, 
   apcc131 LIKE apcc_t.apcc131, 
   apcc132 LIKE apcc_t.apcc132, 
   apcccomp LIKE apcc_t.apcccomp, 
   apcclegl LIKE apcc_t.apcclegl, 
   apccsite LIKE apcc_t.apccsite, 
   apcc017 LIKE apcc_t.apcc017, 
   apcc016 LIKE apcc_t.apcc016
       END RECORD
PRIVATE TYPE type_g_apcc2_d RECORD
       apccdocno LIKE apcc_t.apccdocno, 
   apccld LIKE apcc_t.apccld, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc009 LIKE apcc_t.apcc009, 
   apcc1082 LIKE type_t.chr500, 
   apcc128 LIKE apcc_t.apcc128, 
   apcc129 LIKE apcc_t.apcc129, 
   apcc123 LIKE apcc_t.apcc123, 
   l_cal3 LIKE type_t.num20_6, 
   apcc138 LIKE apcc_t.apcc138, 
   apcc133 LIKE apcc_t.apcc133, 
   apcc139 LIKE apcc_t.apcc139, 
   l_cal4 LIKE type_t.num20_6, 
   apcc1182 LIKE type_t.chr500, 
   apcc125 LIKE apcc_t.apcc125, 
   apcc126 LIKE apcc_t.apcc126, 
   apcc127 LIKE apcc_t.apcc127, 
   apcc124 LIKE apcc_t.apcc124, 
   apcc135 LIKE apcc_t.apcc135, 
   apcc136 LIKE apcc_t.apcc136, 
   apcc137 LIKE apcc_t.apcc137, 
   apcc134 LIKE apcc_t.apcc134
       END RECORD
PRIVATE TYPE type_g_apcc3_d RECORD
       apccdocno LIKE apcc_t.apccdocno, 
   apccld LIKE apcc_t.apccld, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc009 LIKE apcc_t.apcc009
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_apca_t      RECORD LIKE apca_t.* #161104-00024#2 mark
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
DEFINE g_glaa        RECORD 
         glaald      LIKE glaa_t.glaald,
         glaa001     LIKE glaa_t.glaa001,
         glaa015     LIKE glaa_t.glaa015,
         glaa016     LIKE glaa_t.glaa016,
         glaa017     LIKE glaa_t.glaa017,
         glaa019     LIKE glaa_t.glaa019,
         glaa020     LIKE glaa_t.glaa020,
         glaa021     LIKE glaa_t.glaa021
                 END RECORD 
DEFINE g_amt17,g_amt18,g_amt19,g_amt20      LIKE xrce_t.xrce109     #差異金額
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apcc_d          DYNAMIC ARRAY OF type_g_apcc_d #單身變數
DEFINE g_apcc_d_t        type_g_apcc_d                  #單身備份
DEFINE g_apcc_d_o        type_g_apcc_d                  #單身備份
DEFINE g_apcc_d_mask_o   DYNAMIC ARRAY OF type_g_apcc_d #單身變數
DEFINE g_apcc_d_mask_n   DYNAMIC ARRAY OF type_g_apcc_d #單身變數
DEFINE g_apcc2_d   DYNAMIC ARRAY OF type_g_apcc2_d
DEFINE g_apcc2_d_t type_g_apcc2_d
DEFINE g_apcc2_d_o type_g_apcc2_d
DEFINE g_apcc2_d_mask_o DYNAMIC ARRAY OF type_g_apcc2_d
DEFINE g_apcc2_d_mask_n DYNAMIC ARRAY OF type_g_apcc2_d
DEFINE g_apcc3_d   DYNAMIC ARRAY OF type_g_apcc3_d
DEFINE g_apcc3_d_t type_g_apcc3_d
DEFINE g_apcc3_d_o type_g_apcc3_d
DEFINE g_apcc3_d_mask_o DYNAMIC ARRAY OF type_g_apcc3_d
DEFINE g_apcc3_d_mask_n DYNAMIC ARRAY OF type_g_apcc3_d
 
      
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
 
{<section id="aapt300_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aapt300_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_ld,p_apcadoc
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_ld      LIKE apca_t.apcald
   DEFINE p_apcadoc LIKE apca_t.apcadocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   #SELECT * INTO g_apca_t.* FROM apca_t   #161208-00026#5 mark
   #161208-00026#5-add(s)
   SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,
          apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt,
          apcapstid,apcapstdt,apcastus, apcald,apcacomp , 
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
     INTO g_apca_t.* FROM apca_t
   #161208-00026#5-add(e)
    WHERE apcaent = g_enterprise
      AND apcald  = p_ld AND apcadocno = p_apcadoc
   
   SELECT glaald,glaa001,glaa015,glaa016,glaa017,
          glaa019,glaa020,glaa021 
     INTO g_glaa.* 
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apcc015,apccdocno,apccld,apccseq,apcc001,apcc002,apcc003,apcc004,apcc009, 
       apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,apcc105,apcc106,apcc107,apcc104,apcc115, 
       apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122,apcc130,apcc131, 
       apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apccdocno,apccld,apccseq,apcc001,apcc009,apcc128, 
       apcc129,apcc123,apcc138,apcc133,apcc139,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136,apcc137, 
       apcc134,apccdocno,apccld,apccseq,apcc001,apcc009 FROM apcc_t WHERE apccent=? AND apccld=? AND  
       apccdocno=? AND apccseq=? AND apcc001=? AND apcc009=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt300_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_01 WITH FORM cl_ap_formpath("aap","aapt300_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aapt300_01_init()   
 
   #進入選單 Menu (="N")
   CALL aapt300_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aapt300_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET INT_FLAG = FALSE
   LET g_action_choice = ""
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapt300_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str          STRING
   DEFINE l_gzzd005      LIKE gzzd_t.gzzd005
   DEFINE l_window      ui.Window 
   DEFINE l_gzdel003    LIKE gzdel_t.gzdel003
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('apcc002','8310') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET l_gzdel003 = cl_getmsg('aap-00121',g_dlang)
   IF (g_prog = 'aapt330' OR g_prog = 'aapt331')
      AND NOT cl_null(l_gzdel003)   THEN
      LET l_window = ui.Window.getCurrent()
      CALL l_window.setText(l_gzdel003 CLIPPED)
   END IF

   CALL aapt300_01_ref()
   
   #應付金額
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc1082'
      
   LET l_str = l_gzzd005,"(",g_apca_t.apca100,")"   #原幣
   CALL cl_set_comp_att_text('apcc1082',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa016,")"   #本位幣二
   CALL cl_set_comp_att_text('apcc128',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa020,")"   #本位幣三
   CALL cl_set_comp_att_text('apcc138',l_str)
   
   #本幣金額
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc1182'
      
   LET l_str = l_gzzd005,"(",g_apca_t.apca100,")"   #本幣
   CALL cl_set_comp_att_text('apcc1182',l_str)
   
   #交易金額
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc125_t'
      
   LET l_str = l_gzzd005,"(",g_glaa.glaa016,")"   #本位幣二
   CALL cl_set_comp_att_text('apcc125',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa020,")"   #本位幣三
   CALL cl_set_comp_att_text('apcc135',l_str)
   
   #稅前折抵
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc126_t'
      
   LET l_str = l_gzzd005,"(",g_glaa.glaa016,")"   #本位幣二
   CALL cl_set_comp_att_text('apcc126',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa020,")"   #本位幣三
   CALL cl_set_comp_att_text('apcc136',l_str)
   
   #沖帳金額
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc127_t'
      
   LET l_str = l_gzzd005,"(",g_glaa.glaa016,")"   #本位幣二
   CALL cl_set_comp_att_text('apcc127',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa020,")"   #本位幣三
   CALL cl_set_comp_att_text('apcc137',l_str)
   
   #調整金額
   SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
    WHERE gzzdstus = 'Y'
      AND gzzd001  = 'aapt300_01'
      AND gzzd002  = g_lang
      AND gzzd003  = 'lbl_apcc124_t'
      
   LET l_str = l_gzzd005,"(",g_glaa.glaa016,")"   #本位幣二
   CALL cl_set_comp_att_text('apcc124',l_str)
   
   LET l_str = l_gzzd005,"(",g_glaa.glaa020,")"   #本位幣三
   CALL cl_set_comp_att_text('apcc134',l_str)
   
   IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('bpage_2',FALSE)
   ELSE
      CALL cl_set_comp_visible('bpage_2',TRUE)
   END IF
   
   IF g_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('apcc124,apcc125,apcc126,apcc127,apcc128',FALSE)
   ELSE
      CALL cl_set_comp_visible('apcc124,apcc125,apcc126,apcc127,apcc128',TRUE)
   END IF
   
   IF g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('apcc134,apcc135,apcc136,apcc137,apcc138',FALSE)
   ELSE
      CALL cl_set_comp_visible('apcc134,apcc135,apcc136,apcc137,apcc138',TRUE)
   END IF
   #151216-00008#4-----s
   CALL cl_set_combo_scc_part('apcc016','3015','3,4')
   #151216-00008#4-----e
   
   #end add-point
   
   CALL aapt300_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapt300_01_ui_dialog()
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
   DEFINE l_apcastus          LIKE apca_t.apcastus
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
         CALL g_apcc_d.clear()
         CALL g_apcc2_d.clear()
         CALL g_apcc3_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapt300_01_init()
      END IF
   
      CALL aapt300_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aapt300_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_apcc2_d TO s_detail2.*
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
   CALL aapt300_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_apcc3_d TO s_detail3.*
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
   CALL aapt300_01_set_pk_array()
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
            IF g_apca_t.apcastus NOT MATCHES "[N]" THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail,output", FALSE)
            END IF
            #160225-00001#1--(S)
            IF NOT cl_null(g_apca_t.apcadocno) THEN
               SELECT glaald INTO l_ld FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_apca_t.apcacomp
                  AND glaa014 = 'Y'
               CALL s_aooi200_fin_get_slip(g_apca_t.apcadocno) RETURNING g_sub_success,l_slip
               CALL s_fin_get_doc_para(l_ld,g_apca_t.apcacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
               CALL s_fin_date_close_chk('@',g_apca_t.apcacomp,'AAP',g_apca_t.apcadocdt) RETURNING g_sub_success
               IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
                  CALL cl_set_act_visible("insert,modify,delete,modify_detail,output", FALSE)
               END IF
            END IF
            #160225-00001#1--(E)
            
            #albireo 151008  150925-00006-----s
            IF g_prog='aapt320' THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail,output", FALSE)
            END IF
            #albireo 151008  150925-00006-----e
            
            #170209-00014#1 --s add
            IF g_prog MATCHES 'aapq342' THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail,output", FALSE)
            END IF
            #170209-00014#1 --e add
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapt300_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapt300_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapt300_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt300_01_insert()
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
               CALL aapt300_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apcc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_apcc2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_apcc3_d)
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
            CALL aapt300_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt300_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt300_01_set_pk_array()
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
         CALL aapt300_01_ref_amt()

         SELECT apcastus INTO l_apcastus FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcadocno = g_apcadocno
            AND apcald = g_apcald

         IF l_apcastus = 'Y' THEN EXIT WHILE END IF

         IF g_amt17  = 0 AND g_amt18 = 0 AND g_amt19 = 0 AND g_amt20 = 0 THEN
            EXIT WHILE
         END IF
        
         
         IF g_prog NOT MATCHES 'aapq342' THEN #170209-00014#1 add aapq342不做提示, 直接呈現資料
         IF NOT cl_ask_confirm('axr-00235') THEN
            CONTINUE WHILE
         END IF
         END IF   #170209-00014#1 add
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt300_01_query()
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
   CALL g_apcc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON apcc015,apccdocno,apccld,apccseq,apcc001,apcc002,apcc003,ooib002,apcc004,apcc009, 
          apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,l_cal1,l_cal2,apcc105,apcc106,apcc107, 
          apcc104,apcc115,apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122, 
          apcc130,apcc131,apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apcc1082,apcc128,apcc129, 
          l_cal3,apcc138,apcc133,apcc139,l_cal4,apcc1182,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136, 
          apcc137,apcc134 
 
         FROM s_detail1[1].apcc015,s_detail1[1].apccdocno,s_detail1[1].apccld,s_detail1[1].apccseq,s_detail1[1].apcc001, 
             s_detail1[1].apcc002,s_detail1[1].apcc003,s_detail1[1].ooib002,s_detail1[1].apcc004,s_detail1[1].apcc009, 
             s_detail1[1].apcc108,s_detail1[1].apcc101,s_detail1[1].apcc118,s_detail1[1].apcc109,s_detail1[1].apcc119, 
             s_detail1[1].apcc102,s_detail1[1].apcc113,s_detail1[1].l_cal1,s_detail1[1].l_cal2,s_detail1[1].apcc105, 
             s_detail1[1].apcc106,s_detail1[1].apcc107,s_detail1[1].apcc104,s_detail1[1].apcc115,s_detail1[1].apcc116, 
             s_detail1[1].apcc117,s_detail1[1].apcc114,s_detail1[1].apcc005,s_detail1[1].apcc006,s_detail1[1].apcc100, 
             s_detail1[1].apcc103,s_detail1[1].apcc120,s_detail1[1].apcc121,s_detail1[1].apcc122,s_detail1[1].apcc130, 
             s_detail1[1].apcc131,s_detail1[1].apcc132,s_detail1[1].apcccomp,s_detail1[1].apcclegl,s_detail1[1].apccsite, 
             s_detail1[1].apcc017,s_detail1[1].apcc016,s_detail2[1].apcc1082,s_detail2[1].apcc128,s_detail2[1].apcc129, 
             s_detail2[1].l_cal3,s_detail2[1].apcc138,s_detail2[1].apcc133,s_detail2[1].apcc139,s_detail2[1].l_cal4, 
             s_detail2[1].apcc1182,s_detail2[1].apcc125,s_detail2[1].apcc126,s_detail2[1].apcc127,s_detail2[1].apcc124, 
             s_detail2[1].apcc135,s_detail2[1].apcc136,s_detail2[1].apcc137,s_detail2[1].apcc134 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc015
            #add-point:BEFORE FIELD apcc015 name="query.b.page1.apcc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc015
            
            #add-point:AFTER FIELD apcc015 name="query.a.page1.apcc015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc015
            #add-point:ON ACTION controlp INFIELD apcc015 name="query.c.page1.apcc015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccdocno
            #add-point:BEFORE FIELD apccdocno name="query.b.page1.apccdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccdocno
            
            #add-point:AFTER FIELD apccdocno name="query.a.page1.apccdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apccdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccdocno
            #add-point:ON ACTION controlp INFIELD apccdocno name="query.c.page1.apccdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccld
            #add-point:BEFORE FIELD apccld name="query.b.page1.apccld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccld
            
            #add-point:AFTER FIELD apccld name="query.a.page1.apccld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccld
            #add-point:ON ACTION controlp INFIELD apccld name="query.c.page1.apccld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccseq
            #add-point:BEFORE FIELD apccseq name="query.b.page1.apccseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccseq
            
            #add-point:AFTER FIELD apccseq name="query.a.page1.apccseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apccseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccseq
            #add-point:ON ACTION controlp INFIELD apccseq name="query.c.page1.apccseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc001
            #add-point:BEFORE FIELD apcc001 name="query.b.page1.apcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc001
            
            #add-point:AFTER FIELD apcc001 name="query.a.page1.apcc001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc001
            #add-point:ON ACTION controlp INFIELD apcc001 name="query.c.page1.apcc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc002
            #add-point:BEFORE FIELD apcc002 name="query.b.page1.apcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc002
            
            #add-point:AFTER FIELD apcc002 name="query.a.page1.apcc002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc002
            #add-point:ON ACTION controlp INFIELD apcc002 name="query.c.page1.apcc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc003
            #add-point:BEFORE FIELD apcc003 name="query.b.page1.apcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc003
            
            #add-point:AFTER FIELD apcc003 name="query.a.page1.apcc003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc003
            #add-point:ON ACTION controlp INFIELD apcc003 name="query.c.page1.apcc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib002
            #add-point:BEFORE FIELD ooib002 name="query.b.page1.ooib002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib002
            
            #add-point:AFTER FIELD ooib002 name="query.a.page1.ooib002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooib002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib002
            #add-point:ON ACTION controlp INFIELD ooib002 name="query.c.page1.ooib002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc004
            #add-point:BEFORE FIELD apcc004 name="query.b.page1.apcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc004
            
            #add-point:AFTER FIELD apcc004 name="query.a.page1.apcc004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc004
            #add-point:ON ACTION controlp INFIELD apcc004 name="query.c.page1.apcc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc009
            #add-point:BEFORE FIELD apcc009 name="query.b.page1.apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc009
            
            #add-point:AFTER FIELD apcc009 name="query.a.page1.apcc009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc009
            #add-point:ON ACTION controlp INFIELD apcc009 name="query.c.page1.apcc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc108
            #add-point:BEFORE FIELD apcc108 name="query.b.page1.apcc108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc108
            
            #add-point:AFTER FIELD apcc108 name="query.a.page1.apcc108"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc108
            #add-point:ON ACTION controlp INFIELD apcc108 name="query.c.page1.apcc108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc101
            #add-point:BEFORE FIELD apcc101 name="query.b.page1.apcc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc101
            
            #add-point:AFTER FIELD apcc101 name="query.a.page1.apcc101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc101
            #add-point:ON ACTION controlp INFIELD apcc101 name="query.c.page1.apcc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc118
            #add-point:BEFORE FIELD apcc118 name="query.b.page1.apcc118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc118
            
            #add-point:AFTER FIELD apcc118 name="query.a.page1.apcc118"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc118
            #add-point:ON ACTION controlp INFIELD apcc118 name="query.c.page1.apcc118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc109
            #add-point:BEFORE FIELD apcc109 name="query.b.page1.apcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc109
            
            #add-point:AFTER FIELD apcc109 name="query.a.page1.apcc109"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc109
            #add-point:ON ACTION controlp INFIELD apcc109 name="query.c.page1.apcc109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc119
            #add-point:BEFORE FIELD apcc119 name="query.b.page1.apcc119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc119
            
            #add-point:AFTER FIELD apcc119 name="query.a.page1.apcc119"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc119
            #add-point:ON ACTION controlp INFIELD apcc119 name="query.c.page1.apcc119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc102
            #add-point:BEFORE FIELD apcc102 name="query.b.page1.apcc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc102
            
            #add-point:AFTER FIELD apcc102 name="query.a.page1.apcc102"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc102
            #add-point:ON ACTION controlp INFIELD apcc102 name="query.c.page1.apcc102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc113
            #add-point:BEFORE FIELD apcc113 name="query.b.page1.apcc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc113
            
            #add-point:AFTER FIELD apcc113 name="query.a.page1.apcc113"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc113
            #add-point:ON ACTION controlp INFIELD apcc113 name="query.c.page1.apcc113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal1
            #add-point:BEFORE FIELD l_cal1 name="query.b.page1.l_cal1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal1
            
            #add-point:AFTER FIELD l_cal1 name="query.a.page1.l_cal1"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.l_cal1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal1
            #add-point:ON ACTION controlp INFIELD l_cal1 name="query.c.page1.l_cal1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal2
            #add-point:BEFORE FIELD l_cal2 name="query.b.page1.l_cal2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal2
            
            #add-point:AFTER FIELD l_cal2 name="query.a.page1.l_cal2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.l_cal2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal2
            #add-point:ON ACTION controlp INFIELD l_cal2 name="query.c.page1.l_cal2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc105
            #add-point:BEFORE FIELD apcc105 name="query.b.page1.apcc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc105
            
            #add-point:AFTER FIELD apcc105 name="query.a.page1.apcc105"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc105
            #add-point:ON ACTION controlp INFIELD apcc105 name="query.c.page1.apcc105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc106
            #add-point:BEFORE FIELD apcc106 name="query.b.page1.apcc106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc106
            
            #add-point:AFTER FIELD apcc106 name="query.a.page1.apcc106"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc106
            #add-point:ON ACTION controlp INFIELD apcc106 name="query.c.page1.apcc106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc107
            #add-point:BEFORE FIELD apcc107 name="query.b.page1.apcc107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc107
            
            #add-point:AFTER FIELD apcc107 name="query.a.page1.apcc107"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc107
            #add-point:ON ACTION controlp INFIELD apcc107 name="query.c.page1.apcc107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc104
            #add-point:BEFORE FIELD apcc104 name="query.b.page1.apcc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc104
            
            #add-point:AFTER FIELD apcc104 name="query.a.page1.apcc104"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc104
            #add-point:ON ACTION controlp INFIELD apcc104 name="query.c.page1.apcc104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc115
            #add-point:BEFORE FIELD apcc115 name="query.b.page1.apcc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc115
            
            #add-point:AFTER FIELD apcc115 name="query.a.page1.apcc115"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc115
            #add-point:ON ACTION controlp INFIELD apcc115 name="query.c.page1.apcc115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc116
            #add-point:BEFORE FIELD apcc116 name="query.b.page1.apcc116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc116
            
            #add-point:AFTER FIELD apcc116 name="query.a.page1.apcc116"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc116
            #add-point:ON ACTION controlp INFIELD apcc116 name="query.c.page1.apcc116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc117
            #add-point:BEFORE FIELD apcc117 name="query.b.page1.apcc117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc117
            
            #add-point:AFTER FIELD apcc117 name="query.a.page1.apcc117"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc117
            #add-point:ON ACTION controlp INFIELD apcc117 name="query.c.page1.apcc117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc114
            #add-point:BEFORE FIELD apcc114 name="query.b.page1.apcc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc114
            
            #add-point:AFTER FIELD apcc114 name="query.a.page1.apcc114"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc114
            #add-point:ON ACTION controlp INFIELD apcc114 name="query.c.page1.apcc114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc005
            #add-point:BEFORE FIELD apcc005 name="query.b.page1.apcc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc005
            
            #add-point:AFTER FIELD apcc005 name="query.a.page1.apcc005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc005
            #add-point:ON ACTION controlp INFIELD apcc005 name="query.c.page1.apcc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc006
            #add-point:BEFORE FIELD apcc006 name="query.b.page1.apcc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc006
            
            #add-point:AFTER FIELD apcc006 name="query.a.page1.apcc006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc006
            #add-point:ON ACTION controlp INFIELD apcc006 name="query.c.page1.apcc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc100
            #add-point:BEFORE FIELD apcc100 name="query.b.page1.apcc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc100
            
            #add-point:AFTER FIELD apcc100 name="query.a.page1.apcc100"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc100
            #add-point:ON ACTION controlp INFIELD apcc100 name="query.c.page1.apcc100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc103
            #add-point:BEFORE FIELD apcc103 name="query.b.page1.apcc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc103
            
            #add-point:AFTER FIELD apcc103 name="query.a.page1.apcc103"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc103
            #add-point:ON ACTION controlp INFIELD apcc103 name="query.c.page1.apcc103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc120
            #add-point:BEFORE FIELD apcc120 name="query.b.page1.apcc120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc120
            
            #add-point:AFTER FIELD apcc120 name="query.a.page1.apcc120"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc120
            #add-point:ON ACTION controlp INFIELD apcc120 name="query.c.page1.apcc120"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc121
            #add-point:BEFORE FIELD apcc121 name="query.b.page1.apcc121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc121
            
            #add-point:AFTER FIELD apcc121 name="query.a.page1.apcc121"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc121
            #add-point:ON ACTION controlp INFIELD apcc121 name="query.c.page1.apcc121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc122
            #add-point:BEFORE FIELD apcc122 name="query.b.page1.apcc122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc122
            
            #add-point:AFTER FIELD apcc122 name="query.a.page1.apcc122"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc122
            #add-point:ON ACTION controlp INFIELD apcc122 name="query.c.page1.apcc122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc130
            #add-point:BEFORE FIELD apcc130 name="query.b.page1.apcc130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc130
            
            #add-point:AFTER FIELD apcc130 name="query.a.page1.apcc130"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc130
            #add-point:ON ACTION controlp INFIELD apcc130 name="query.c.page1.apcc130"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc131
            #add-point:BEFORE FIELD apcc131 name="query.b.page1.apcc131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc131
            
            #add-point:AFTER FIELD apcc131 name="query.a.page1.apcc131"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc131
            #add-point:ON ACTION controlp INFIELD apcc131 name="query.c.page1.apcc131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc132
            #add-point:BEFORE FIELD apcc132 name="query.b.page1.apcc132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc132
            
            #add-point:AFTER FIELD apcc132 name="query.a.page1.apcc132"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc132
            #add-point:ON ACTION controlp INFIELD apcc132 name="query.c.page1.apcc132"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcccomp
            #add-point:BEFORE FIELD apcccomp name="query.b.page1.apcccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcccomp
            
            #add-point:AFTER FIELD apcccomp name="query.a.page1.apcccomp"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcccomp
            #add-point:ON ACTION controlp INFIELD apcccomp name="query.c.page1.apcccomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcclegl
            #add-point:BEFORE FIELD apcclegl name="query.b.page1.apcclegl"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcclegl
            
            #add-point:AFTER FIELD apcclegl name="query.a.page1.apcclegl"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcclegl
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcclegl
            #add-point:ON ACTION controlp INFIELD apcclegl name="query.c.page1.apcclegl"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccsite
            #add-point:BEFORE FIELD apccsite name="query.b.page1.apccsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccsite
            
            #add-point:AFTER FIELD apccsite name="query.a.page1.apccsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apccsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccsite
            #add-point:ON ACTION controlp INFIELD apccsite name="query.c.page1.apccsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc017
            #add-point:BEFORE FIELD apcc017 name="query.b.page1.apcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc017
            
            #add-point:AFTER FIELD apcc017 name="query.a.page1.apcc017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc017
            #add-point:ON ACTION controlp INFIELD apcc017 name="query.c.page1.apcc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc016
            #add-point:BEFORE FIELD apcc016 name="query.b.page1.apcc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc016
            
            #add-point:AFTER FIELD apcc016 name="query.a.page1.apcc016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apcc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc016
            #add-point:ON ACTION controlp INFIELD apcc016 name="query.c.page1.apcc016"
            
            #END add-point
 
 
  
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc1082
            #add-point:BEFORE FIELD apcc1082 name="query.b.page2.apcc1082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc1082
            
            #add-point:AFTER FIELD apcc1082 name="query.a.page2.apcc1082"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc1082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc1082
            #add-point:ON ACTION controlp INFIELD apcc1082 name="query.c.page2.apcc1082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc128
            #add-point:BEFORE FIELD apcc128 name="query.b.page2.apcc128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc128
            
            #add-point:AFTER FIELD apcc128 name="query.a.page2.apcc128"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc128
            #add-point:ON ACTION controlp INFIELD apcc128 name="query.c.page2.apcc128"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc129
            #add-point:BEFORE FIELD apcc129 name="query.b.page2.apcc129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc129
            
            #add-point:AFTER FIELD apcc129 name="query.a.page2.apcc129"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc129
            #add-point:ON ACTION controlp INFIELD apcc129 name="query.c.page2.apcc129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal3
            #add-point:BEFORE FIELD l_cal3 name="query.b.page2.l_cal3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal3
            
            #add-point:AFTER FIELD l_cal3 name="query.a.page2.l_cal3"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.l_cal3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal3
            #add-point:ON ACTION controlp INFIELD l_cal3 name="query.c.page2.l_cal3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc138
            #add-point:BEFORE FIELD apcc138 name="query.b.page2.apcc138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc138
            
            #add-point:AFTER FIELD apcc138 name="query.a.page2.apcc138"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc138
            #add-point:ON ACTION controlp INFIELD apcc138 name="query.c.page2.apcc138"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc133
            #add-point:BEFORE FIELD apcc133 name="query.b.page2.apcc133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc133
            
            #add-point:AFTER FIELD apcc133 name="query.a.page2.apcc133"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc133
            #add-point:ON ACTION controlp INFIELD apcc133 name="query.c.page2.apcc133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc139
            #add-point:BEFORE FIELD apcc139 name="query.b.page2.apcc139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc139
            
            #add-point:AFTER FIELD apcc139 name="query.a.page2.apcc139"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc139
            #add-point:ON ACTION controlp INFIELD apcc139 name="query.c.page2.apcc139"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal4
            #add-point:BEFORE FIELD l_cal4 name="query.b.page2.l_cal4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal4
            
            #add-point:AFTER FIELD l_cal4 name="query.a.page2.l_cal4"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.l_cal4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal4
            #add-point:ON ACTION controlp INFIELD l_cal4 name="query.c.page2.l_cal4"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc1182
            #add-point:BEFORE FIELD apcc1182 name="query.b.page2.apcc1182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc1182
            
            #add-point:AFTER FIELD apcc1182 name="query.a.page2.apcc1182"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc1182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc1182
            #add-point:ON ACTION controlp INFIELD apcc1182 name="query.c.page2.apcc1182"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc125
            #add-point:BEFORE FIELD apcc125 name="query.b.page2.apcc125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc125
            
            #add-point:AFTER FIELD apcc125 name="query.a.page2.apcc125"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc125
            #add-point:ON ACTION controlp INFIELD apcc125 name="query.c.page2.apcc125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc126
            #add-point:BEFORE FIELD apcc126 name="query.b.page2.apcc126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc126
            
            #add-point:AFTER FIELD apcc126 name="query.a.page2.apcc126"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc126
            #add-point:ON ACTION controlp INFIELD apcc126 name="query.c.page2.apcc126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc127
            #add-point:BEFORE FIELD apcc127 name="query.b.page2.apcc127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc127
            
            #add-point:AFTER FIELD apcc127 name="query.a.page2.apcc127"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc127
            #add-point:ON ACTION controlp INFIELD apcc127 name="query.c.page2.apcc127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc124
            #add-point:BEFORE FIELD apcc124 name="query.b.page2.apcc124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc124
            
            #add-point:AFTER FIELD apcc124 name="query.a.page2.apcc124"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc124
            #add-point:ON ACTION controlp INFIELD apcc124 name="query.c.page2.apcc124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc135
            #add-point:BEFORE FIELD apcc135 name="query.b.page2.apcc135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc135
            
            #add-point:AFTER FIELD apcc135 name="query.a.page2.apcc135"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc135
            #add-point:ON ACTION controlp INFIELD apcc135 name="query.c.page2.apcc135"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc136
            #add-point:BEFORE FIELD apcc136 name="query.b.page2.apcc136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc136
            
            #add-point:AFTER FIELD apcc136 name="query.a.page2.apcc136"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc136
            #add-point:ON ACTION controlp INFIELD apcc136 name="query.c.page2.apcc136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc137
            #add-point:BEFORE FIELD apcc137 name="query.b.page2.apcc137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc137
            
            #add-point:AFTER FIELD apcc137 name="query.a.page2.apcc137"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc137
            #add-point:ON ACTION controlp INFIELD apcc137 name="query.c.page2.apcc137"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc134
            #add-point:BEFORE FIELD apcc134 name="query.b.page2.apcc134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc134
            
            #add-point:AFTER FIELD apcc134 name="query.a.page2.apcc134"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.apcc134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc134
            #add-point:ON ACTION controlp INFIELD apcc134 name="query.c.page2.apcc134"
            
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
    
   CALL aapt300_01_b_fill(g_wc2)
 
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
 
{<section id="aapt300_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt300_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapt300_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt300_01_modify()
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
   DEFINE  l_apcastus             LIKE apca_t.apcastus
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   IF g_apca_t.apcastus = 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_apca_t.apcadocno
      LET g_errparam.code   = 'axr-00234'
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
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
      INPUT ARRAY g_apcc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apcc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt300_01_b_fill(g_wc2)
            LET g_detail_cnt = g_apcc_d.getLength()
         
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
            DISPLAY g_apcc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_apcc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apcc_d[l_ac].apccld IS NOT NULL
               AND g_apcc_d[l_ac].apccdocno IS NOT NULL
               AND g_apcc_d[l_ac].apccseq IS NOT NULL
               AND g_apcc_d[l_ac].apcc001 IS NOT NULL
               AND g_apcc_d[l_ac].apcc009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apcc_d_t.* = g_apcc_d[l_ac].*  #BACKUP
               LET g_apcc_d_o.* = g_apcc_d[l_ac].*  #BACKUP
               IF NOT aapt300_01_lock_b("apcc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_01_bcl INTO g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld, 
                      g_apcc_d[l_ac].apccseq,g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003, 
                      g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc009,g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101, 
                      g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102, 
                      g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
                      g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117, 
                      g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005,g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100, 
                      g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120,g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122, 
                      g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp, 
                      g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite,g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016, 
                      g_apcc2_d[l_ac].apccdocno,g_apcc2_d[l_ac].apccld,g_apcc2_d[l_ac].apccseq,g_apcc2_d[l_ac].apcc001, 
                      g_apcc2_d[l_ac].apcc009,g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129,g_apcc2_d[l_ac].apcc123, 
                      g_apcc2_d[l_ac].apcc138,g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139,g_apcc2_d[l_ac].apcc125, 
                      g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124,g_apcc2_d[l_ac].apcc135, 
                      g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134,g_apcc3_d[l_ac].apccdocno, 
                      g_apcc3_d[l_ac].apccld,g_apcc3_d[l_ac].apccseq,g_apcc3_d[l_ac].apcc001,g_apcc3_d[l_ac].apcc009 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apcc_d_t.apccld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apcc_d_mask_o[l_ac].* =  g_apcc_d[l_ac].*
                  CALL aapt300_01_apcc_t_mask()
                  LET g_apcc_d_mask_n[l_ac].* =  g_apcc_d[l_ac].*
                  
                  CALL aapt300_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_01_set_entry_b(l_cmd)
            CALL aapt300_01_set_no_entry_b(l_cmd)
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
            INITIALIZE g_apcc_d_t.* TO NULL
            INITIALIZE g_apcc_d_o.* TO NULL
            INITIALIZE g_apcc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身3)
                  LET g_apcc_d[l_ac].l_cal1 = "0"
      LET g_apcc_d[l_ac].l_cal2 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_apcc_d_t.* = g_apcc_d[l_ac].*     #新輸入資料
            LET g_apcc_d_o.* = g_apcc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apcc_d[li_reproduce_target].* = g_apcc_d[li_reproduce].*
               LET g_apcc2_d[li_reproduce_target].* = g_apcc2_d[li_reproduce].*
               LET g_apcc3_d[li_reproduce_target].* = g_apcc3_d[li_reproduce].*
 
               LET g_apcc_d[g_apcc_d.getLength()].apccld = NULL
               LET g_apcc_d[g_apcc_d.getLength()].apccdocno = NULL
               LET g_apcc_d[g_apcc_d.getLength()].apccseq = NULL
               LET g_apcc_d[g_apcc_d.getLength()].apcc001 = NULL
               LET g_apcc_d[g_apcc_d.getLength()].apcc009 = NULL
 
            END IF
            
 
 
 
            CALL aapt300_01_set_entry_b(l_cmd)
            CALL aapt300_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            #150225
            #項次
            SELECT MAX(apccseq)+1 INTO g_apcc_d[l_ac].apccseq FROM apcc_t
             WHERE apccent = g_enterprise AND apccdocno = g_apca_t.apcadocno
               AND apccld = g_apca_t.apcald
            IF cl_null(g_apcc_d[l_ac].apccseq) OR g_apcc_d[l_ac].apccseq = 0 THEN
               LET g_apcc_d[l_ac].apccseq = 1
            END IF
            IF cl_null(g_apcc_d[l_ac].apccdocno) THEN
               LET g_apcc_d[l_ac].apccdocno = g_apca_t.apcadocno
            END IF
            IF cl_null(g_apcc_d[l_ac].apccld) THEN
               LET g_apcc_d[l_ac].apccld = g_apca_t.apcald
            END IF
            IF cl_null(g_apcc_d[l_ac].apcc009) THEN
               LET g_apcc_d[l_ac].apcc009 = ' '
            END IF
            
            #170202-00028#1-----s
            LET g_apcc_d[l_ac].apcc015 = g_apca_t.apca008
            CALL s_desc_get_ooib002_desc(g_apcc_d[l_ac].apcc015) RETURNING g_apcc_d[l_ac].l_apcc015_desc
            #170202-00028#1-----e
            
            #160106 albireo-----s
            LET g_apcc_d[l_ac].apcc101 = g_apca_t.apca101
            LET g_apcc_d[l_ac].apcc102 = g_apca_t.apca101
            #160106 albireo-----e
            #160107 albireo-----s
            LET g_apcc_d[l_ac].apcc118 = 0
            LET g_apcc_d[l_ac].apcc109 = 0
            LET g_apcc_d[l_ac].apcc119 = 0
            LET g_apcc_d[l_ac].apcc113 = 0
            #160107 albireo-----e
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
            SELECT COUNT(1) INTO l_count FROM apcc_t 
             WHERE apccent = g_enterprise AND apccld = g_apcc_d[l_ac].apccld
                                       AND apccdocno = g_apcc_d[l_ac].apccdocno
                                       AND apccseq = g_apcc_d[l_ac].apccseq
                                       AND apcc001 = g_apcc_d[l_ac].apcc001
                                       AND apcc009 = g_apcc_d[l_ac].apcc009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc_d[g_detail_idx].apccld
               LET gs_keys[2] = g_apcc_d[g_detail_idx].apccdocno
               LET gs_keys[3] = g_apcc_d[g_detail_idx].apccseq
               LET gs_keys[4] = g_apcc_d[g_detail_idx].apcc001
               LET gs_keys[5] = g_apcc_d[g_detail_idx].apcc009
               CALL aapt300_01_insert_b('apcc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apcc_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL aapt300_01_ref_amt()
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (apccld = '", g_apcc_d[l_ac].apccld, "' "
                                  ," AND apccdocno = '", g_apcc_d[l_ac].apccdocno, "' "
                                  ," AND apccseq = '", g_apcc_d[l_ac].apccseq, "' "
                                  ," AND apcc001 = '", g_apcc_d[l_ac].apcc001, "' "
                                  ," AND apcc009 = '", g_apcc_d[l_ac].apcc009, "' "
 
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
               
               DELETE FROM apcc_t
                WHERE apccent = g_enterprise AND 
                      apccld = g_apcc_d_t.apccld
                      AND apccdocno = g_apcc_d_t.apccdocno
                      AND apccseq = g_apcc_d_t.apccseq
                      AND apcc001 = g_apcc_d_t.apcc001
                      AND apcc009 = g_apcc_d_t.apcc009
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  CALL aapt300_01_ref_amt()
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apcc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_apcc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc_d_t.apccld
               LET gs_keys[2] = g_apcc_d_t.apccdocno
               LET gs_keys[3] = g_apcc_d_t.apccseq
               LET gs_keys[4] = g_apcc_d_t.apcc001
               LET gs_keys[5] = g_apcc_d_t.apcc009
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapt300_01_delete_b('apcc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apcc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc015
            
            #add-point:AFTER FIELD apcc015 name="input.a.page1.apcc015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc015
            #add-point:BEFORE FIELD apcc015 name="input.b.page1.apcc015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc015
            #add-point:ON CHANGE apcc015 name="input.g.page1.apcc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcc015_desc
            #add-point:BEFORE FIELD l_apcc015_desc name="input.b.page1.l_apcc015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcc015_desc
            
            #add-point:AFTER FIELD l_apcc015_desc name="input.a.page1.l_apcc015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcc015_desc
            #add-point:ON CHANGE l_apcc015_desc name="input.g.page1.l_apcc015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccdocno
            #add-point:BEFORE FIELD apccdocno name="input.b.page1.apccdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccdocno
            
            #add-point:AFTER FIELD apccdocno name="input.a.page1.apccdocno"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccdocno
            #add-point:ON CHANGE apccdocno name="input.g.page1.apccdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccld
            #add-point:BEFORE FIELD apccld name="input.b.page1.apccld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccld
            
            #add-point:AFTER FIELD apccld name="input.a.page1.apccld"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccld
            #add-point:ON CHANGE apccld name="input.g.page1.apccld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccseq
            #add-point:BEFORE FIELD apccseq name="input.b.page1.apccseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccseq
            
            #add-point:AFTER FIELD apccseq name="input.a.page1.apccseq"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccseq
            #add-point:ON CHANGE apccseq name="input.g.page1.apccseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc001
            #add-point:BEFORE FIELD apcc001 name="input.b.page1.apcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc001
            
            #add-point:AFTER FIELD apcc001 name="input.a.page1.apcc001"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc001
            #add-point:ON CHANGE apcc001 name="input.g.page1.apcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc002
            #add-point:BEFORE FIELD apcc002 name="input.b.page1.apcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc002
            
            #add-point:AFTER FIELD apcc002 name="input.a.page1.apcc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc002
            #add-point:ON CHANGE apcc002 name="input.g.page1.apcc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc003
            #add-point:BEFORE FIELD apcc003 name="input.b.page1.apcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc003
            
            #add-point:AFTER FIELD apcc003 name="input.a.page1.apcc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc003
            #add-point:ON CHANGE apcc003 name="input.g.page1.apcc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib002
            #add-point:BEFORE FIELD ooib002 name="input.b.page1.ooib002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib002
            
            #add-point:AFTER FIELD ooib002 name="input.a.page1.ooib002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib002
            #add-point:ON CHANGE ooib002 name="input.g.page1.ooib002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc004
            #add-point:BEFORE FIELD apcc004 name="input.b.page1.apcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc004
            
            #add-point:AFTER FIELD apcc004 name="input.a.page1.apcc004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc004
            #add-point:ON CHANGE apcc004 name="input.g.page1.apcc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc009
            #add-point:BEFORE FIELD apcc009 name="input.b.page1.apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc009
            
            #add-point:AFTER FIELD apcc009 name="input.a.page1.apcc009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL AND g_apcc_d[g_detail_idx].apcc009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001 OR g_apcc_d[g_detail_idx].apcc009 != g_apcc_d_t.apcc009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"' AND "|| "apcc009 = '"||g_apcc_d[g_detail_idx].apcc009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc009
            #add-point:ON CHANGE apcc009 name="input.g.page1.apcc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc108
            #add-point:BEFORE FIELD apcc108 name="input.b.page1.apcc108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc108
            
            #add-point:AFTER FIELD apcc108 name="input.a.page1.apcc108"
            IF NOT cl_null(g_apcc_d[g_detail_idx].apcc108) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apcc108 != g_apcc_d_t.apcc108)) THEN
                  IF g_apcc_d[g_detail_idx].apcc108 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_apcc_d[g_detail_idx].apcc108
                     LET g_errparam.code   = "axr-00224"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  #計算本幣
                  LET g_apcc_d[g_detail_idx].apcc118 = g_apcc_d[g_detail_idx].apcc108 * g_apcc_d[g_detail_idx].apcc101
                  
                  #計算原幣未沖金額
                  LET g_apcc_d[g_detail_idx].l_cal1 = g_apcc_d[g_detail_idx].apcc108
                  
                  #計算本幣未沖金額
                  LET g_apcc_d[g_detail_idx].l_cal2 = g_apcc_d[g_detail_idx].apcc118
                  
                  IF g_glaa.glaa015 = 'Y' THEN
                     IF g_glaa.glaa017 = '1' THEN
                        LET g_apcc2_d[g_detail_idx].apcc128 = g_apcc_d[g_detail_idx].apcc108 * g_apcc_d[g_detail_idx].apcc121
                     ELSE
                        LET g_apcc2_d[g_detail_idx].apcc128 = g_apcc_d[g_detail_idx].apcc118 * g_apcc_d[g_detail_idx].apcc121
                     END IF
                  END IF
                  IF g_glaa.glaa019 = 'Y' THEN
                     IF g_glaa.glaa021 = '1' THEN
                        LET g_apcc2_d[g_detail_idx].apcc138 = g_apcc_d[g_detail_idx].apcc108 * g_apcc_d[g_detail_idx].apcc131
                     ELSE
                        LET g_apcc2_d[g_detail_idx].apcc138 = g_apcc_d[g_detail_idx].apcc118 * g_apcc_d[g_detail_idx].apcc131
                     END IF
                  END IF
                  #取位
                  CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa001,g_apcc_d[g_detail_idx].apcc118,2)
                       RETURNING g_sub_success,g_errno,g_apcc_d[g_detail_idx].apcc118
                  IF g_glaa.glaa015 = 'Y' THEN
                     CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa016,g_apcc2_d[g_detail_idx].apcc128,2)
                          RETURNING g_sub_success,g_errno,g_apcc2_d[g_detail_idx].apcc128
                  END IF
                  IF g_glaa.glaa019 = 'Y' THEN
                     CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa020,g_apcc2_d[g_detail_idx].apcc138,2)
                          RETURNING g_sub_success,g_errno,g_apcc2_d[g_detail_idx].apcc138
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc108
            #add-point:ON CHANGE apcc108 name="input.g.page1.apcc108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc101
            #add-point:BEFORE FIELD apcc101 name="input.b.page1.apcc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc101
            
            #add-point:AFTER FIELD apcc101 name="input.a.page1.apcc101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc101
            #add-point:ON CHANGE apcc101 name="input.g.page1.apcc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc118
            #add-point:BEFORE FIELD apcc118 name="input.b.page1.apcc118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc118
            
            #add-point:AFTER FIELD apcc118 name="input.a.page1.apcc118"
            IF NOT cl_null(g_apcc_d[g_detail_idx].apcc118) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apcc118 != g_apcc_d_t.apcc118)) THEN
                  IF g_apcc_d[g_detail_idx].apcc108 <= 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apcc_d[g_detail_idx].apcc118
                     LET g_errparam.code   = "axr-00224" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                  
                  #計算本幣未沖金額
                  LET g_apcc_d[g_detail_idx].l_cal2 = g_apcc_d[g_detail_idx].apcc118
                  
                  #計算本位幣
                  IF g_glaa.glaa015 = 'Y' THEN
                     IF g_glaa.glaa017 = '1' THEN
                        LET g_apcc2_d[g_detail_idx].apcc128 = g_apcc_d[g_detail_idx].apcc108 / g_apcc_d[g_detail_idx].apcc121
                     ELSE
                        LET g_apcc2_d[g_detail_idx].apcc128 = g_apcc_d[g_detail_idx].apcc118 / g_apcc_d[g_detail_idx].apcc121
                     END IF
                  END IF
                  IF g_glaa.glaa019 = 'Y' THEN
                     IF g_glaa.glaa021 = '1' THEN
                        LET g_apcc2_d[g_detail_idx].apcc138 = g_apcc_d[g_detail_idx].apcc108 / g_apcc_d[g_detail_idx].apcc131
                     ELSE
                        LET g_apcc2_d[g_detail_idx].apcc138 = g_apcc_d[g_detail_idx].apcc118 / g_apcc_d[g_detail_idx].apcc131
                     END IF
                  END IF  
                  #CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa001,g_apcc_d[g_detail_idx].l_cal2,2)   #160829-00004#1mark
                  CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa001,g_apcc_d[g_detail_idx].l_cal2,3)    #160829-00004#1
                       RETURNING g_sub_success,g_errno,g_apcc_d[g_detail_idx].l_cal2
                  IF g_glaa.glaa015 = 'Y' THEN
                     #CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa016,g_apcc2_d[g_detail_idx].apcc128,2)   #160829-00004#1mark
                     CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa016,g_apcc2_d[g_detail_idx].apcc128,3)    #160829-00004#1
                          RETURNING g_sub_success,g_errno,g_apcc2_d[g_detail_idx].apcc128
                  END IF
                  IF g_glaa.glaa019 = 'Y' THEN
                     #CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa020,g_apcc2_d[g_detail_idx].apcc138,2)   #160829-00004#1mark
                     CALL s_curr_round_ld('1',g_glaa.glaald,g_glaa.glaa020,g_apcc2_d[g_detail_idx].apcc138,3)    #160829-00004#1
                          RETURNING g_sub_success,g_errno,g_apcc2_d[g_detail_idx].apcc138
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc118
            #add-point:ON CHANGE apcc118 name="input.g.page1.apcc118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc109
            #add-point:BEFORE FIELD apcc109 name="input.b.page1.apcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc109
            
            #add-point:AFTER FIELD apcc109 name="input.a.page1.apcc109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc109
            #add-point:ON CHANGE apcc109 name="input.g.page1.apcc109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc119
            #add-point:BEFORE FIELD apcc119 name="input.b.page1.apcc119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc119
            
            #add-point:AFTER FIELD apcc119 name="input.a.page1.apcc119"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc119
            #add-point:ON CHANGE apcc119 name="input.g.page1.apcc119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc102
            #add-point:BEFORE FIELD apcc102 name="input.b.page1.apcc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc102
            
            #add-point:AFTER FIELD apcc102 name="input.a.page1.apcc102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc102
            #add-point:ON CHANGE apcc102 name="input.g.page1.apcc102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc113
            #add-point:BEFORE FIELD apcc113 name="input.b.page1.apcc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc113
            
            #add-point:AFTER FIELD apcc113 name="input.a.page1.apcc113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc113
            #add-point:ON CHANGE apcc113 name="input.g.page1.apcc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal1
            #add-point:BEFORE FIELD l_cal1 name="input.b.page1.l_cal1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal1
            
            #add-point:AFTER FIELD l_cal1 name="input.a.page1.l_cal1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cal1
            #add-point:ON CHANGE l_cal1 name="input.g.page1.l_cal1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal2
            #add-point:BEFORE FIELD l_cal2 name="input.b.page1.l_cal2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal2
            
            #add-point:AFTER FIELD l_cal2 name="input.a.page1.l_cal2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cal2
            #add-point:ON CHANGE l_cal2 name="input.g.page1.l_cal2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc105
            #add-point:BEFORE FIELD apcc105 name="input.b.page1.apcc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc105
            
            #add-point:AFTER FIELD apcc105 name="input.a.page1.apcc105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc105
            #add-point:ON CHANGE apcc105 name="input.g.page1.apcc105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc106
            #add-point:BEFORE FIELD apcc106 name="input.b.page1.apcc106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc106
            
            #add-point:AFTER FIELD apcc106 name="input.a.page1.apcc106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc106
            #add-point:ON CHANGE apcc106 name="input.g.page1.apcc106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc107
            #add-point:BEFORE FIELD apcc107 name="input.b.page1.apcc107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc107
            
            #add-point:AFTER FIELD apcc107 name="input.a.page1.apcc107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc107
            #add-point:ON CHANGE apcc107 name="input.g.page1.apcc107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc104
            #add-point:BEFORE FIELD apcc104 name="input.b.page1.apcc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc104
            
            #add-point:AFTER FIELD apcc104 name="input.a.page1.apcc104"
            #albireo 140826 印象調整金額不給輸入 但SAQ問題所以先行處理成會更新總金額-s
            IF NOT cl_null(g_apcc_d[l_ac].apcc104) THEN
               IF (g_apcc_d[l_ac].apcc104 != g_apcc_d_t.apcc104 OR g_apcc_d_t.apcc104 IS NULL ) THEN
                  LET g_apcc_d[l_ac].apcc108 = g_apcc_d[l_ac].apcc105+g_apcc_d[l_ac].apcc104+
                                               g_apcc_d[l_ac].apcc103-g_apcc_d[l_ac].apcc106-g_apcc_d[l_ac].apcc107
                  DISPLAY BY NAME g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc108
               END IF
            END IF
            
            #140826################################s
            #是否更改後同步更新本幣金額
            #更新本幣之後再加減本幣調整金額 還是本幣調整金額直接給回0?
            #需要再跟sa確認
            #140826################################e
            
            #albireo 140826-----------------------------------------------------e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc104
            #add-point:ON CHANGE apcc104 name="input.g.page1.apcc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc115
            #add-point:BEFORE FIELD apcc115 name="input.b.page1.apcc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc115
            
            #add-point:AFTER FIELD apcc115 name="input.a.page1.apcc115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc115
            #add-point:ON CHANGE apcc115 name="input.g.page1.apcc115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc116
            #add-point:BEFORE FIELD apcc116 name="input.b.page1.apcc116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc116
            
            #add-point:AFTER FIELD apcc116 name="input.a.page1.apcc116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc116
            #add-point:ON CHANGE apcc116 name="input.g.page1.apcc116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc117
            #add-point:BEFORE FIELD apcc117 name="input.b.page1.apcc117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc117
            
            #add-point:AFTER FIELD apcc117 name="input.a.page1.apcc117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc117
            #add-point:ON CHANGE apcc117 name="input.g.page1.apcc117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc114
            #add-point:BEFORE FIELD apcc114 name="input.b.page1.apcc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc114
            
            #add-point:AFTER FIELD apcc114 name="input.a.page1.apcc114"
            #albireo 140826 印象調整金額是不給輸入的但是SAQ出此問題所以先做調整-----------------------------s  
            IF NOT cl_null(g_apcc_d[l_ac].apcc114) THEN
               IF (g_apcc_d[l_ac].apcc114 != g_apcc_d_t.apcc114 OR g_apcc_d_t.apcc114 IS NULL ) THEN
                  LET g_apcc_d[l_ac].apcc118 = g_apcc_d[l_ac].apcc115+g_apcc_d[l_ac].apcc114+
                                               g_apcc_d[l_ac].apcc113-g_apcc_d[l_ac].apcc116-g_apcc_d[l_ac].apcc117
                  DISPLAY BY NAME g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc118
               END IF
            END IF
            #albireo 140826 ----------------------------------------------------------------------------e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc114
            #add-point:ON CHANGE apcc114 name="input.g.page1.apcc114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc005
            #add-point:BEFORE FIELD apcc005 name="input.b.page1.apcc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc005
            
            #add-point:AFTER FIELD apcc005 name="input.a.page1.apcc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc005
            #add-point:ON CHANGE apcc005 name="input.g.page1.apcc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc006
            #add-point:BEFORE FIELD apcc006 name="input.b.page1.apcc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc006
            
            #add-point:AFTER FIELD apcc006 name="input.a.page1.apcc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc006
            #add-point:ON CHANGE apcc006 name="input.g.page1.apcc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc100
            #add-point:BEFORE FIELD apcc100 name="input.b.page1.apcc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc100
            
            #add-point:AFTER FIELD apcc100 name="input.a.page1.apcc100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc100
            #add-point:ON CHANGE apcc100 name="input.g.page1.apcc100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc103
            #add-point:BEFORE FIELD apcc103 name="input.b.page1.apcc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc103
            
            #add-point:AFTER FIELD apcc103 name="input.a.page1.apcc103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc103
            #add-point:ON CHANGE apcc103 name="input.g.page1.apcc103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc120
            #add-point:BEFORE FIELD apcc120 name="input.b.page1.apcc120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc120
            
            #add-point:AFTER FIELD apcc120 name="input.a.page1.apcc120"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc120
            #add-point:ON CHANGE apcc120 name="input.g.page1.apcc120"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc121
            #add-point:BEFORE FIELD apcc121 name="input.b.page1.apcc121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc121
            
            #add-point:AFTER FIELD apcc121 name="input.a.page1.apcc121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc121
            #add-point:ON CHANGE apcc121 name="input.g.page1.apcc121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc122
            #add-point:BEFORE FIELD apcc122 name="input.b.page1.apcc122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc122
            
            #add-point:AFTER FIELD apcc122 name="input.a.page1.apcc122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc122
            #add-point:ON CHANGE apcc122 name="input.g.page1.apcc122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc130
            #add-point:BEFORE FIELD apcc130 name="input.b.page1.apcc130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc130
            
            #add-point:AFTER FIELD apcc130 name="input.a.page1.apcc130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc130
            #add-point:ON CHANGE apcc130 name="input.g.page1.apcc130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc131
            #add-point:BEFORE FIELD apcc131 name="input.b.page1.apcc131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc131
            
            #add-point:AFTER FIELD apcc131 name="input.a.page1.apcc131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc131
            #add-point:ON CHANGE apcc131 name="input.g.page1.apcc131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc132
            #add-point:BEFORE FIELD apcc132 name="input.b.page1.apcc132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc132
            
            #add-point:AFTER FIELD apcc132 name="input.a.page1.apcc132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc132
            #add-point:ON CHANGE apcc132 name="input.g.page1.apcc132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcccomp
            #add-point:BEFORE FIELD apcccomp name="input.b.page1.apcccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcccomp
            
            #add-point:AFTER FIELD apcccomp name="input.a.page1.apcccomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcccomp
            #add-point:ON CHANGE apcccomp name="input.g.page1.apcccomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcclegl
            #add-point:BEFORE FIELD apcclegl name="input.b.page1.apcclegl"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcclegl
            
            #add-point:AFTER FIELD apcclegl name="input.a.page1.apcclegl"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcclegl
            #add-point:ON CHANGE apcclegl name="input.g.page1.apcclegl"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccsite
            #add-point:BEFORE FIELD apccsite name="input.b.page1.apccsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccsite
            
            #add-point:AFTER FIELD apccsite name="input.a.page1.apccsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccsite
            #add-point:ON CHANGE apccsite name="input.g.page1.apccsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc017
            #add-point:BEFORE FIELD apcc017 name="input.b.page1.apcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc017
            
            #add-point:AFTER FIELD apcc017 name="input.a.page1.apcc017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc017
            #add-point:ON CHANGE apcc017 name="input.g.page1.apcc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc016
            #add-point:BEFORE FIELD apcc016 name="input.b.page1.apcc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc016
            
            #add-point:AFTER FIELD apcc016 name="input.a.page1.apcc016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc016
            #add-point:ON CHANGE apcc016 name="input.g.page1.apcc016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apcc015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc015
            #add-point:ON ACTION controlp INFIELD apcc015 name="input.c.page1.apcc015"
            #付款條件編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcc_d[g_detail_idx].apcc015
            LET g_qryparam.arg1 =g_apca_t.apca004
            CALL q_pmad002_2()
            LET g_apcc_d[g_detail_idx].apcc015 = g_qryparam.return1
            CALL s_desc_get_ooib002_desc(g_apcc_d[g_detail_idx].apcc015) RETURNING g_apcc_d[g_detail_idx].l_apcc015_desc
            DISPLAY BY NAME g_apcc_d[g_detail_idx].apcc015,g_apcc_d[g_detail_idx].l_apcc015_desc
            NEXT FIELD apcc015
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_apcc015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcc015_desc
            #add-point:ON ACTION controlp INFIELD l_apcc015_desc name="input.c.page1.l_apcc015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccdocno
            #add-point:ON ACTION controlp INFIELD apccdocno name="input.c.page1.apccdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccld
            #add-point:ON ACTION controlp INFIELD apccld name="input.c.page1.apccld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccseq
            #add-point:ON ACTION controlp INFIELD apccseq name="input.c.page1.apccseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc001
            #add-point:ON ACTION controlp INFIELD apcc001 name="input.c.page1.apcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc002
            #add-point:ON ACTION controlp INFIELD apcc002 name="input.c.page1.apcc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc003
            #add-point:ON ACTION controlp INFIELD apcc003 name="input.c.page1.apcc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooib002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib002
            #add-point:ON ACTION controlp INFIELD ooib002 name="input.c.page1.ooib002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc004
            #add-point:ON ACTION controlp INFIELD apcc004 name="input.c.page1.apcc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc009
            #add-point:ON ACTION controlp INFIELD apcc009 name="input.c.page1.apcc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc108
            #add-point:ON ACTION controlp INFIELD apcc108 name="input.c.page1.apcc108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc101
            #add-point:ON ACTION controlp INFIELD apcc101 name="input.c.page1.apcc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc118
            #add-point:ON ACTION controlp INFIELD apcc118 name="input.c.page1.apcc118"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc109
            #add-point:ON ACTION controlp INFIELD apcc109 name="input.c.page1.apcc109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc119
            #add-point:ON ACTION controlp INFIELD apcc119 name="input.c.page1.apcc119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc102
            #add-point:ON ACTION controlp INFIELD apcc102 name="input.c.page1.apcc102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc113
            #add-point:ON ACTION controlp INFIELD apcc113 name="input.c.page1.apcc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_cal1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal1
            #add-point:ON ACTION controlp INFIELD l_cal1 name="input.c.page1.l_cal1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_cal2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal2
            #add-point:ON ACTION controlp INFIELD l_cal2 name="input.c.page1.l_cal2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc105
            #add-point:ON ACTION controlp INFIELD apcc105 name="input.c.page1.apcc105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc106
            #add-point:ON ACTION controlp INFIELD apcc106 name="input.c.page1.apcc106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc107
            #add-point:ON ACTION controlp INFIELD apcc107 name="input.c.page1.apcc107"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc104
            #add-point:ON ACTION controlp INFIELD apcc104 name="input.c.page1.apcc104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc115
            #add-point:ON ACTION controlp INFIELD apcc115 name="input.c.page1.apcc115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc116
            #add-point:ON ACTION controlp INFIELD apcc116 name="input.c.page1.apcc116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc117
            #add-point:ON ACTION controlp INFIELD apcc117 name="input.c.page1.apcc117"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc114
            #add-point:ON ACTION controlp INFIELD apcc114 name="input.c.page1.apcc114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc005
            #add-point:ON ACTION controlp INFIELD apcc005 name="input.c.page1.apcc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc006
            #add-point:ON ACTION controlp INFIELD apcc006 name="input.c.page1.apcc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc100
            #add-point:ON ACTION controlp INFIELD apcc100 name="input.c.page1.apcc100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc103
            #add-point:ON ACTION controlp INFIELD apcc103 name="input.c.page1.apcc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc120
            #add-point:ON ACTION controlp INFIELD apcc120 name="input.c.page1.apcc120"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc121
            #add-point:ON ACTION controlp INFIELD apcc121 name="input.c.page1.apcc121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc122
            #add-point:ON ACTION controlp INFIELD apcc122 name="input.c.page1.apcc122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc130
            #add-point:ON ACTION controlp INFIELD apcc130 name="input.c.page1.apcc130"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc131
            #add-point:ON ACTION controlp INFIELD apcc131 name="input.c.page1.apcc131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc132
            #add-point:ON ACTION controlp INFIELD apcc132 name="input.c.page1.apcc132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcccomp
            #add-point:ON ACTION controlp INFIELD apcccomp name="input.c.page1.apcccomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcclegl
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcclegl
            #add-point:ON ACTION controlp INFIELD apcclegl name="input.c.page1.apcclegl"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccsite
            #add-point:ON ACTION controlp INFIELD apccsite name="input.c.page1.apccsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc017
            #add-point:ON ACTION controlp INFIELD apcc017 name="input.c.page1.apcc017"
            #151216-00008#4-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcc_d[g_detail_idx].apcc017
            LET g_qryparam.where = "apcbld = '",g_apca_t.apcald,"' AND apcbdocno = '",g_apca_t.apcadocno,"' "
            CALL q_apcb008()
            LET g_apcc_d[g_detail_idx].apcc017= g_qryparam.return1
            DISPLAY BY NAME  g_apcc_d[g_detail_idx].apcc017
            NEXT FIELD apcc017
            #151216-00008#4------e
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc016
            #add-point:ON ACTION controlp INFIELD apcc016 name="input.c.page1.apcc016"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapt300_01_bcl
               LET INT_FLAG = 0
               LET g_apcc_d[l_ac].* = g_apcc_d_t.*
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
               LET g_errparam.extend = g_apcc_d[l_ac].apccld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apcc_d[l_ac].* = g_apcc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_01_apcc_t_mask_restore('restore_mask_o')
 
               UPDATE apcc_t SET (apcc015,apccdocno,apccld,apccseq,apcc001,apcc002,apcc003,apcc004,apcc009, 
                   apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,apcc105,apcc106,apcc107,apcc104, 
                   apcc115,apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122, 
                   apcc130,apcc131,apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apcc128,apcc129, 
                   apcc123,apcc138,apcc133,apcc139,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136,apcc137, 
                   apcc134) = (g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld, 
                   g_apcc_d[l_ac].apccseq,g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003, 
                   g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc009,g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101, 
                   g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102, 
                   g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
                   g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117, 
                   g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005,g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100, 
                   g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120,g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122, 
                   g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp, 
                   g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite,g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016, 
                   g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129,g_apcc2_d[l_ac].apcc123,g_apcc2_d[l_ac].apcc138, 
                   g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139,g_apcc2_d[l_ac].apcc125,g_apcc2_d[l_ac].apcc126, 
                   g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124,g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136, 
                   g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134)
                WHERE apccent = g_enterprise AND
                  apccld = g_apcc_d_t.apccld #項次   
                  AND apccdocno = g_apcc_d_t.apccdocno  
                  AND apccseq = g_apcc_d_t.apccseq  
                  AND apcc001 = g_apcc_d_t.apcc001  
                  AND apcc009 = g_apcc_d_t.apcc009  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc_d[g_detail_idx].apccld
               LET gs_keys_bak[1] = g_apcc_d_t.apccld
               LET gs_keys[2] = g_apcc_d[g_detail_idx].apccdocno
               LET gs_keys_bak[2] = g_apcc_d_t.apccdocno
               LET gs_keys[3] = g_apcc_d[g_detail_idx].apccseq
               LET gs_keys_bak[3] = g_apcc_d_t.apccseq
               LET gs_keys[4] = g_apcc_d[g_detail_idx].apcc001
               LET gs_keys_bak[4] = g_apcc_d_t.apcc001
               LET gs_keys[5] = g_apcc_d[g_detail_idx].apcc009
               LET gs_keys_bak[5] = g_apcc_d_t.apcc009
               CALL aapt300_01_update_b('apcc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apcc_d_t)
                     LET g_log2 = util.JSON.stringify(g_apcc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_01_apcc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL aapt300_01_ref_amt()
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapt300_01_unlock_b("apcc_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apcc_d[l_ac].* = g_apcc_d_t.*
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
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apcc_d[li_reproduce_target].* = g_apcc_d[li_reproduce].*
               LET g_apcc2_d[li_reproduce_target].* = g_apcc2_d[li_reproduce].*
               LET g_apcc3_d[li_reproduce_target].* = g_apcc3_d[li_reproduce].*
 
               LET g_apcc_d[li_reproduce_target].apccld = NULL
               LET g_apcc_d[li_reproduce_target].apccdocno = NULL
               LET g_apcc_d[li_reproduce_target].apccseq = NULL
               LET g_apcc_d[li_reproduce_target].apcc001 = NULL
               LET g_apcc_d[li_reproduce_target].apcc009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apcc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apcc_d.getLength()+1
            END IF
            
      END INPUT
      
      INPUT ARRAY g_apcc2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL aapt300_01_b_fill(g_wc2)
            LET g_detail_cnt = g_apcc2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD apccld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apcc2_d[l_ac].* TO NULL 
            INITIALIZE g_apcc2_d_t.* TO NULL
            INITIALIZE g_apcc2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_apcc2_d[l_ac].apcc129 = "0"
      LET g_apcc2_d[l_ac].l_cal3 = "0"
      LET g_apcc2_d[l_ac].apcc139 = "0"
      LET g_apcc2_d[l_ac].l_cal4 = "0"
 
            #add-point:modify段before備份 name="input.body2.before_bak"
 
            #end add-point
            LET g_apcc2_d_t.* = g_apcc2_d[l_ac].*     #新輸入資料
            LET g_apcc2_d_o.* = g_apcc2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apcc_d[li_reproduce_target].* = g_apcc_d[li_reproduce].*
               LET g_apcc2_d[li_reproduce_target].* = g_apcc2_d[li_reproduce].*
               LET g_apcc3_d[li_reproduce_target].* = g_apcc3_d[li_reproduce].*
 
               LET g_apcc2_d[li_reproduce_target].apccld = NULL
               LET g_apcc2_d[li_reproduce_target].apccdocno = NULL
               LET g_apcc2_d[li_reproduce_target].apccseq = NULL
               LET g_apcc2_d[li_reproduce_target].apcc001 = NULL
               LET g_apcc2_d[li_reproduce_target].apcc009 = NULL
            END IF
            
 
 
 
            CALL aapt300_01_set_entry_b(l_cmd)
            CALL aapt300_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"
            IF 1 = 0 THEN
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_apcc2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_apcc2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apcc2_d[l_ac].apccld IS NOT NULL
               AND g_apcc2_d[l_ac].apccdocno IS NOT NULL
               AND g_apcc2_d[l_ac].apccseq IS NOT NULL
               AND g_apcc2_d[l_ac].apcc001 IS NOT NULL
               AND g_apcc2_d[l_ac].apcc009 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apcc2_d_t.* = g_apcc2_d[l_ac].*  #BACKUP
               LET g_apcc2_d_o.* = g_apcc2_d[l_ac].*  #BACKUP
               IF NOT aapt300_01_lock_b("apcc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_01_bcl INTO g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld, 
                      g_apcc_d[l_ac].apccseq,g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003, 
                      g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc009,g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101, 
                      g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102, 
                      g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
                      g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117, 
                      g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005,g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100, 
                      g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120,g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122, 
                      g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp, 
                      g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite,g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016, 
                      g_apcc2_d[l_ac].apccdocno,g_apcc2_d[l_ac].apccld,g_apcc2_d[l_ac].apccseq,g_apcc2_d[l_ac].apcc001, 
                      g_apcc2_d[l_ac].apcc009,g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129,g_apcc2_d[l_ac].apcc123, 
                      g_apcc2_d[l_ac].apcc138,g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139,g_apcc2_d[l_ac].apcc125, 
                      g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124,g_apcc2_d[l_ac].apcc135, 
                      g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134,g_apcc3_d[l_ac].apccdocno, 
                      g_apcc3_d[l_ac].apccld,g_apcc3_d[l_ac].apccseq,g_apcc3_d[l_ac].apcc001,g_apcc3_d[l_ac].apcc009 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH aapt300_01_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apcc2_d_mask_o[l_ac].* =  g_apcc2_d[l_ac].*
                  CALL aapt300_01_apcc_t_mask()
                  LET g_apcc2_d_mask_n[l_ac].* =  g_apcc2_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL aapt300_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_01_set_entry_b(l_cmd)
            CALL aapt300_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            ELSE
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_cmd = ''
               LET l_ac = ARR_CURR()
               LET l_lock_sw = 'N'            #DEFAULT
               LET l_n = ARR_COUNT()
               DISPLAY l_ac TO FORMONLY.idx
               DISPLAY g_apcc2_d.getLength() TO FORMONLY.cnt
            
               CALL s_transaction_begin()
               
               LET g_detail_cnt = g_apcc2_d.getLength()
               
               IF g_detail_cnt >= l_ac 
                  AND g_apcc2_d[l_ac].apccld IS NOT NULL
                  AND g_apcc2_d[l_ac].apccdocno IS NOT NULL
    
                  AND g_apcc2_d[l_ac].apccseq IS NOT NULL
    
                  AND g_apcc2_d[l_ac].apcc001 IS NOT NULL
    
               THEN 
                  LET l_cmd='u'
                  LET g_apcc2_d_t.* = g_apcc2_d[l_ac].*  #BACKUP
                  IF NOT aapt300_01_lock_b("apcc_t") THEN
                     LET l_lock_sw='Y'
                  ELSE
                     FETCH aapt300_01_bcl INTO g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apccseq, 
                         g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003,g_apcc_d[l_ac].ooib002, 
                         g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
                         g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc116, 
                         g_apcc_d[l_ac].apcc117,g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc005, 
                         g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100,g_apcc_d[l_ac].apcc101,g_apcc_d[l_ac].apcc102, 
                         g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc119, 
                         g_apcc_d[l_ac].apcc120,g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122, 
                         g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132, 
                         g_apcc_d[l_ac].apcccomp,g_apcc_d[l_ac].apcclegl, 
                         g_apcc_d[l_ac].apccsite,g_apcc2_d[l_ac].apccdocno,g_apcc2_d[l_ac].apccld,g_apcc2_d[l_ac].apccseq, 
                         g_apcc2_d[l_ac].apcc1182,g_apcc2_d[l_ac].apcc125, 
                         g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124,g_apcc2_d[l_ac].apcc128, 
                         g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134, 
                         g_apcc2_d[l_ac].apcc138,g_apcc3_d[l_ac].apccdocno,g_apcc3_d[l_ac].apccld,g_apcc3_d[l_ac].apccseq, 
                         g_apcc3_d[l_ac].apcc001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET l_lock_sw = "Y"
                     END IF
                     
                     CALL cl_show_fld_cont()
                     CALL aapt300_01_detail_show()
                  END IF
               ELSE
                  LET l_cmd='a'
               END IF
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
               
               DELETE FROM apcc_t
                WHERE apccent = g_enterprise AND
                  apccld = g_apcc2_d_t.apccld
                  AND apccdocno = g_apcc2_d_t.apccdocno
                  AND apccseq = g_apcc2_d_t.apccseq
                  AND apcc001 = g_apcc2_d_t.apcc001
                  AND apcc009 = g_apcc2_d_t.apcc009
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"
                  CALL aapt300_01_ref_amt()
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apcc2_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_01_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"
               
               #end add-point
               LET l_count = g_apcc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc2_d_t.apccld
               LET gs_keys[2] = g_apcc2_d_t.apccdocno
               LET gs_keys[3] = g_apcc2_d_t.apccseq
               LET gs_keys[4] = g_apcc2_d_t.apcc001
               LET gs_keys[5] = g_apcc2_d_t.apcc009
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"
               
               #end add-point
                              CALL aapt300_01_delete_b('apcc_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apcc2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apcc_t 
             WHERE apccent = g_enterprise AND
                   apccld = g_apcc2_d[l_ac].apccld
                   AND apccdocno = g_apcc2_d[l_ac].apccdocno
                   AND apccseq = g_apcc2_d[l_ac].apccseq
                   AND apcc001 = g_apcc2_d[l_ac].apcc001
                   AND apcc009 = g_apcc2_d[l_ac].apcc009
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc2_d[g_detail_idx].apccld
               LET gs_keys[2] = g_apcc2_d[g_detail_idx].apccdocno
               LET gs_keys[3] = g_apcc2_d[g_detail_idx].apccseq
               LET gs_keys[4] = g_apcc2_d[g_detail_idx].apcc001
               LET gs_keys[5] = g_apcc2_d[g_detail_idx].apcc009
               CALL aapt300_01_insert_b('apcc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apcc_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               CALL aapt300_01_ref_amt()
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (apccld = '", g_apcc2_d[l_ac].apccld, "' "
                                  ," AND apccdocno = '", g_apcc2_d[l_ac].apccdocno, "' "
                                  ," AND apccseq = '", g_apcc2_d[l_ac].apccseq, "' "
                                  ," AND apcc001 = '", g_apcc2_d[l_ac].apcc001, "' "
                                  ," AND apcc009 = '", g_apcc2_d[l_ac].apcc009, "' "
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
               LET g_apcc2_d[l_ac].* = g_apcc2_d_t.*
               CLOSE aapt300_01_bcl
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
               LET g_apcc2_d[l_ac].* = g_apcc2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_01_apcc_t_mask_restore('restore_mask_o')
               
               UPDATE apcc_t SET (apcc015,apccdocno,apccld,apccseq,apcc001,apcc002,apcc003,apcc004,apcc009, 
                   apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,apcc105,apcc106,apcc107,apcc104, 
                   apcc115,apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122, 
                   apcc130,apcc131,apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apcc128,apcc129, 
                   apcc123,apcc138,apcc133,apcc139,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136,apcc137, 
                   apcc134) = (g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld, 
                   g_apcc_d[l_ac].apccseq,g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003, 
                   g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc009,g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101, 
                   g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102, 
                   g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
                   g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117, 
                   g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005,g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100, 
                   g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120,g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122, 
                   g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp, 
                   g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite,g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016, 
                   g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129,g_apcc2_d[l_ac].apcc123,g_apcc2_d[l_ac].apcc138, 
                   g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139,g_apcc2_d[l_ac].apcc125,g_apcc2_d[l_ac].apcc126, 
                   g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124,g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136, 
                   g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134) #自訂欄位頁簽
                WHERE apccent = g_enterprise AND
                  apccld = g_apcc2_d_t.apccld #項次 
                  AND apccdocno = g_apcc2_d_t.apccdocno
                  AND apccseq = g_apcc2_d_t.apccseq
                  AND apcc001 = g_apcc2_d_t.apcc001
                  AND apcc009 = g_apcc2_d_t.apcc009
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apcc2_d[g_detail_idx].apccld
               LET gs_keys_bak[1] = g_apcc2_d_t.apccld
               LET gs_keys[2] = g_apcc2_d[g_detail_idx].apccdocno
               LET gs_keys_bak[2] = g_apcc2_d_t.apccdocno
               LET gs_keys[3] = g_apcc2_d[g_detail_idx].apccseq
               LET gs_keys_bak[3] = g_apcc2_d_t.apccseq
               LET gs_keys[4] = g_apcc2_d[g_detail_idx].apcc001
               LET gs_keys_bak[4] = g_apcc2_d_t.apcc001
               LET gs_keys[5] = g_apcc2_d[g_detail_idx].apcc009
               LET gs_keys_bak[5] = g_apcc2_d_t.apcc009
               CALL aapt300_01_update_b('apcc_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apcc2_d_t)
                     LET g_log2 = util.JSON.stringify(g_apcc2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_01_apcc_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               CALL aapt300_01_ref_amt()
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc1082
            #add-point:BEFORE FIELD apcc1082 name="input.b.page2.apcc1082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc1082
            
            #add-point:AFTER FIELD apcc1082 name="input.a.page2.apcc1082"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc1082
            #add-point:ON CHANGE apcc1082 name="input.g.page2.apcc1082"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc128
            #add-point:BEFORE FIELD apcc128 name="input.b.page2.apcc128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc128
            
            #add-point:AFTER FIELD apcc128 name="input.a.page2.apcc128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc128
            #add-point:ON CHANGE apcc128 name="input.g.page2.apcc128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc129
            #add-point:BEFORE FIELD apcc129 name="input.b.page2.apcc129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc129
            
            #add-point:AFTER FIELD apcc129 name="input.a.page2.apcc129"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc129
            #add-point:ON CHANGE apcc129 name="input.g.page2.apcc129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal3
            #add-point:BEFORE FIELD l_cal3 name="input.b.page2.l_cal3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal3
            
            #add-point:AFTER FIELD l_cal3 name="input.a.page2.l_cal3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cal3
            #add-point:ON CHANGE l_cal3 name="input.g.page2.l_cal3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc138
            #add-point:BEFORE FIELD apcc138 name="input.b.page2.apcc138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc138
            
            #add-point:AFTER FIELD apcc138 name="input.a.page2.apcc138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc138
            #add-point:ON CHANGE apcc138 name="input.g.page2.apcc138"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc133
            #add-point:BEFORE FIELD apcc133 name="input.b.page2.apcc133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc133
            
            #add-point:AFTER FIELD apcc133 name="input.a.page2.apcc133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc133
            #add-point:ON CHANGE apcc133 name="input.g.page2.apcc133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc139
            #add-point:BEFORE FIELD apcc139 name="input.b.page2.apcc139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc139
            
            #add-point:AFTER FIELD apcc139 name="input.a.page2.apcc139"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc139
            #add-point:ON CHANGE apcc139 name="input.g.page2.apcc139"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cal4
            #add-point:BEFORE FIELD l_cal4 name="input.b.page2.l_cal4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cal4
            
            #add-point:AFTER FIELD l_cal4 name="input.a.page2.l_cal4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cal4
            #add-point:ON CHANGE l_cal4 name="input.g.page2.l_cal4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc1182
            #add-point:BEFORE FIELD apcc1182 name="input.b.page2.apcc1182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc1182
            
            #add-point:AFTER FIELD apcc1182 name="input.a.page2.apcc1182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc1182
            #add-point:ON CHANGE apcc1182 name="input.g.page2.apcc1182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc125
            #add-point:BEFORE FIELD apcc125 name="input.b.page2.apcc125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc125
            
            #add-point:AFTER FIELD apcc125 name="input.a.page2.apcc125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc125
            #add-point:ON CHANGE apcc125 name="input.g.page2.apcc125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc126
            #add-point:BEFORE FIELD apcc126 name="input.b.page2.apcc126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc126
            
            #add-point:AFTER FIELD apcc126 name="input.a.page2.apcc126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc126
            #add-point:ON CHANGE apcc126 name="input.g.page2.apcc126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc127
            #add-point:BEFORE FIELD apcc127 name="input.b.page2.apcc127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc127
            
            #add-point:AFTER FIELD apcc127 name="input.a.page2.apcc127"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc127
            #add-point:ON CHANGE apcc127 name="input.g.page2.apcc127"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc124
            #add-point:BEFORE FIELD apcc124 name="input.b.page2.apcc124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc124
            
            #add-point:AFTER FIELD apcc124 name="input.a.page2.apcc124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc124
            #add-point:ON CHANGE apcc124 name="input.g.page2.apcc124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc135
            #add-point:BEFORE FIELD apcc135 name="input.b.page2.apcc135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc135
            
            #add-point:AFTER FIELD apcc135 name="input.a.page2.apcc135"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc135
            #add-point:ON CHANGE apcc135 name="input.g.page2.apcc135"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc136
            #add-point:BEFORE FIELD apcc136 name="input.b.page2.apcc136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc136
            
            #add-point:AFTER FIELD apcc136 name="input.a.page2.apcc136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc136
            #add-point:ON CHANGE apcc136 name="input.g.page2.apcc136"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc137
            #add-point:BEFORE FIELD apcc137 name="input.b.page2.apcc137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc137
            
            #add-point:AFTER FIELD apcc137 name="input.a.page2.apcc137"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc137
            #add-point:ON CHANGE apcc137 name="input.g.page2.apcc137"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc134
            #add-point:BEFORE FIELD apcc134 name="input.b.page2.apcc134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc134
            
            #add-point:AFTER FIELD apcc134 name="input.a.page2.apcc134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc134
            #add-point:ON CHANGE apcc134 name="input.g.page2.apcc134"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apcc1082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc1082
            #add-point:ON ACTION controlp INFIELD apcc1082 name="input.c.page2.apcc1082"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc128
            #add-point:ON ACTION controlp INFIELD apcc128 name="input.c.page2.apcc128"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc129
            #add-point:ON ACTION controlp INFIELD apcc129 name="input.c.page2.apcc129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_cal3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal3
            #add-point:ON ACTION controlp INFIELD l_cal3 name="input.c.page2.l_cal3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc138
            #add-point:ON ACTION controlp INFIELD apcc138 name="input.c.page2.apcc138"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc133
            #add-point:ON ACTION controlp INFIELD apcc133 name="input.c.page2.apcc133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc139
            #add-point:ON ACTION controlp INFIELD apcc139 name="input.c.page2.apcc139"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_cal4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cal4
            #add-point:ON ACTION controlp INFIELD l_cal4 name="input.c.page2.l_cal4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc1182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc1182
            #add-point:ON ACTION controlp INFIELD apcc1182 name="input.c.page2.apcc1182"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc125
            #add-point:ON ACTION controlp INFIELD apcc125 name="input.c.page2.apcc125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc126
            #add-point:ON ACTION controlp INFIELD apcc126 name="input.c.page2.apcc126"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc127
            #add-point:ON ACTION controlp INFIELD apcc127 name="input.c.page2.apcc127"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc124
            #add-point:ON ACTION controlp INFIELD apcc124 name="input.c.page2.apcc124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc135
            #add-point:ON ACTION controlp INFIELD apcc135 name="input.c.page2.apcc135"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc136
            #add-point:ON ACTION controlp INFIELD apcc136 name="input.c.page2.apcc136"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc137
            #add-point:ON ACTION controlp INFIELD apcc137 name="input.c.page2.apcc137"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apcc134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc134
            #add-point:ON ACTION controlp INFIELD apcc134 name="input.c.page2.apcc134"
            
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
                  LET g_apcc2_d[l_ac].* = g_apcc2_d_t.*
               END IF
               CLOSE aapt300_01_bcl
               #add-point:單身after row name="input.body2.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aapt300_01_unlock_b("apcc_t")
            #add-point:單身after row name="input.body2.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apcc_d[li_reproduce_target].* = g_apcc_d[li_reproduce].*
               LET g_apcc2_d[li_reproduce_target].* = g_apcc2_d[li_reproduce].*
               LET g_apcc3_d[li_reproduce_target].* = g_apcc3_d[li_reproduce].*
 
               LET g_apcc2_d[li_reproduce_target].apccld = NULL
               LET g_apcc2_d[li_reproduce_target].apccdocno = NULL
               LET g_apcc2_d[li_reproduce_target].apccseq = NULL
               LET g_apcc2_d[li_reproduce_target].apcc001 = NULL
               LET g_apcc2_d[li_reproduce_target].apcc009 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apcc2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apcc2_d.getLength()+1
            END IF
      END INPUT
 
      
      DISPLAY ARRAY g_apcc3_d TO s_detail3.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aapt300_01_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
            
      END DISPLAY
 
      
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
               NEXT FIELD apcc015
            WHEN "s_detail2"
               NEXT FIELD apccdocno_2
            WHEN "s_detail3"
               NEXT FIELD apccdocno_3
 
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
      IF INT_FLAG OR cl_null(g_apcc_d[g_detail_idx].apccld) THEN
         CALL g_apcc_d.deleteElement(g_detail_idx)
         CALL g_apcc2_d.deleteElement(g_detail_idx)
         CALL g_apcc3_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_apcc_d[g_detail_idx].* = g_apcc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aapt300_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt300_01_delete()
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
   FOR li_idx = 1 TO g_apcc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapt300_01_lock_b("apcc_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("apcc_t","") THEN
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
   
   FOR li_idx = 1 TO g_apcc_d.getLength()
      IF g_apcc_d[li_idx].apccld IS NOT NULL
         AND g_apcc_d[li_idx].apccdocno IS NOT NULL
         AND g_apcc_d[li_idx].apccseq IS NOT NULL
         AND g_apcc_d[li_idx].apcc001 IS NOT NULL
         AND g_apcc_d[li_idx].apcc009 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM apcc_t
          WHERE apccent = g_enterprise AND 
                apccld = g_apcc_d[li_idx].apccld
                AND apccdocno = g_apcc_d[li_idx].apccdocno
                AND apccseq = g_apcc_d[li_idx].apccseq
                AND apcc001 = g_apcc_d[li_idx].apcc001
                AND apcc009 = g_apcc_d[li_idx].apcc009
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_apcc_d_t.apccld
               LET gs_keys[2] = g_apcc_d_t.apccdocno
               LET gs_keys[3] = g_apcc_d_t.apccseq
               LET gs_keys[4] = g_apcc_d_t.apcc001
               LET gs_keys[5] = g_apcc_d_t.apcc009
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapt300_01_delete_b('apcc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_01_set_pk_array()
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
   CALL aapt300_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt300_01_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xrac004       LIKE xrac_t.xrac004
   DEFINE l_xrac005       LIKE xrac_t.xrac005
   DEFINE l_xrac006       LIKE xrac_t.xrac006
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = "apccdocno = '",g_apca_t.apcadocno,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.apcc015,t0.apccdocno,t0.apccld,t0.apccseq,t0.apcc001,t0.apcc002, 
       t0.apcc003,t0.apcc004,t0.apcc009,t0.apcc108,t0.apcc101,t0.apcc118,t0.apcc109,t0.apcc119,t0.apcc102, 
       t0.apcc113,t0.apcc105,t0.apcc106,t0.apcc107,t0.apcc104,t0.apcc115,t0.apcc116,t0.apcc117,t0.apcc114, 
       t0.apcc005,t0.apcc006,t0.apcc100,t0.apcc103,t0.apcc120,t0.apcc121,t0.apcc122,t0.apcc130,t0.apcc131, 
       t0.apcc132,t0.apcccomp,t0.apcclegl,t0.apccsite,t0.apcc017,t0.apcc016,t0.apccdocno,t0.apccld,t0.apccseq, 
       t0.apcc001,t0.apcc009,t0.apcc128,t0.apcc129,t0.apcc123,t0.apcc138,t0.apcc133,t0.apcc139,t0.apcc125, 
       t0.apcc126,t0.apcc127,t0.apcc124,t0.apcc135,t0.apcc136,t0.apcc137,t0.apcc134,t0.apccdocno,t0.apccld, 
       t0.apccseq,t0.apcc001,t0.apcc009  FROM apcc_t t0",
               "",
               
               " WHERE t0.apccent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("apcc_t"),
                      " ORDER BY t0.apccld,t0.apccdocno,t0.apccseq,t0.apcc001,t0.apcc009"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"apcc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt300_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapt300_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apcc_d.clear()
   CALL g_apcc2_d.clear()   
   CALL g_apcc3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apccseq, 
       g_apcc_d[l_ac].apcc001,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003,g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc009, 
       g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101,g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119, 
       g_apcc_d[l_ac].apcc102,g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105,g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107, 
       g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115,g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117,g_apcc_d[l_ac].apcc114, 
       g_apcc_d[l_ac].apcc005,g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100,g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120, 
       g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122,g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131,g_apcc_d[l_ac].apcc132, 
       g_apcc_d[l_ac].apcccomp,g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite,g_apcc_d[l_ac].apcc017, 
       g_apcc_d[l_ac].apcc016,g_apcc2_d[l_ac].apccdocno,g_apcc2_d[l_ac].apccld,g_apcc2_d[l_ac].apccseq, 
       g_apcc2_d[l_ac].apcc001,g_apcc2_d[l_ac].apcc009,g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129, 
       g_apcc2_d[l_ac].apcc123,g_apcc2_d[l_ac].apcc138,g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139, 
       g_apcc2_d[l_ac].apcc125,g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124, 
       g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134, 
       g_apcc3_d[l_ac].apccdocno,g_apcc3_d[l_ac].apccld,g_apcc3_d[l_ac].apccseq,g_apcc3_d[l_ac].apcc001, 
       g_apcc3_d[l_ac].apcc009
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #原幣未沖金額
      LET g_apcc_d[l_ac].l_cal1 = g_apcc_d[l_ac].apcc108 - g_apcc_d[l_ac].apcc109
      #本幣未沖金額
      LET g_apcc_d[l_ac].l_cal2 = g_apcc_d[l_ac].apcc118 - g_apcc_d[l_ac].apcc119 + g_apcc_d[l_ac].apcc113
      #其他幣未沖金額
      LET g_apcc2_d[l_ac].l_cal3 = g_apcc2_d[l_ac].apcc128 - g_apcc2_d[l_ac].apcc129 + g_apcc2_d[l_ac].apcc123
      LET g_apcc2_d[l_ac].l_cal4 = g_apcc2_d[l_ac].apcc138 - g_apcc2_d[l_ac].apcc139 + g_apcc2_d[l_ac].apcc133

      SELECT xrac004,xrac005,xrac006 INTO l_xrac004,l_xrac005,l_xrac006 FROM xrac_t
       WHERE xracent = g_enterprise
         AND xrac002 = g_apca_t.apca054
         AND xrac003 = g_apcc_d[l_ac].apcc001
      IF cl_null(l_xrac004) THEN LET l_xrac004 = 0 END IF
      IF cl_null(l_xrac005) THEN LET l_xrac005 = 0 END IF
      IF cl_null(l_xrac006) THEN LET l_xrac006 = 0 END IF
         
      IF l_xrac004 = 0 THEN
         LET g_apcc_d[l_ac].ooib002 = l_xrac004 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_ac].ooib002 = l_xrac004 USING '<<<<<'
      END IF
      
      IF l_xrac005 = 0 THEN
         LET g_apcc_d[l_ac].ooib002 = g_apcc_d[l_ac].ooib002,"/",l_xrac005 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_ac].ooib002 = g_apcc_d[l_ac].ooib002,"/",l_xrac005 USING '<<<<<'
      END IF
      
      IF l_xrac006 = 0 THEN
         LET g_apcc_d[l_ac].ooib002 = g_apcc_d[l_ac].ooib002,"/",l_xrac006 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_ac].ooib002 = g_apcc_d[l_ac].ooib002,"/",l_xrac006 USING '<<<<<'
      END IF
      
      CALL s_desc_get_ooib002_desc(g_apcc_d[l_ac].apcc015) RETURNING g_apcc_d[l_ac].l_apcc015_desc   #151216-00008#4
      #end add-point
      
      CALL aapt300_01_detail_show()      
 
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
   
 
   
   CALL g_apcc_d.deleteElement(g_apcc_d.getLength())   
   CALL g_apcc2_d.deleteElement(g_apcc2_d.getLength())
   CALL g_apcc3_d.deleteElement(g_apcc3_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_apcc_d.getLength()
      LET g_apcc2_d[l_ac].apccld = g_apcc_d[l_ac].apccld 
      LET g_apcc2_d[l_ac].apccdocno = g_apcc_d[l_ac].apccdocno 
      LET g_apcc2_d[l_ac].apccseq = g_apcc_d[l_ac].apccseq 
      LET g_apcc2_d[l_ac].apcc001 = g_apcc_d[l_ac].apcc001 
      LET g_apcc2_d[l_ac].apcc009 = g_apcc_d[l_ac].apcc009 
      LET g_apcc3_d[l_ac].apccld = g_apcc_d[l_ac].apccld 
      LET g_apcc3_d[l_ac].apccdocno = g_apcc_d[l_ac].apccdocno 
      LET g_apcc3_d[l_ac].apccseq = g_apcc_d[l_ac].apccseq 
      LET g_apcc3_d[l_ac].apcc001 = g_apcc_d[l_ac].apcc001 
      LET g_apcc3_d[l_ac].apcc009 = g_apcc_d[l_ac].apcc009 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_apcc_d.getLength() THEN
      LET l_ac = g_apcc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_apcc_d.getLength()
      LET g_apcc_d_mask_o[l_ac].* =  g_apcc_d[l_ac].*
      CALL aapt300_01_apcc_t_mask()
      LET g_apcc_d_mask_n[l_ac].* =  g_apcc_d[l_ac].*
   END FOR
   
   LET g_apcc2_d_mask_o.* =  g_apcc2_d.*
   FOR l_ac = 1 TO g_apcc2_d.getLength()
      LET g_apcc2_d_mask_o[l_ac].* =  g_apcc2_d[l_ac].*
      CALL aapt300_01_apcc_t_mask()
      LET g_apcc2_d_mask_n[l_ac].* =  g_apcc2_d[l_ac].*
   END FOR
   LET g_apcc3_d_mask_o.* =  g_apcc3_d.*
   FOR l_ac = 1 TO g_apcc3_d.getLength()
      LET g_apcc3_d_mask_o[l_ac].* =  g_apcc3_d[l_ac].*
      CALL aapt300_01_apcc_t_mask()
      LET g_apcc3_d_mask_n[l_ac].* =  g_apcc3_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   FOR l_ac = 1 TO g_apcc_d.getLength()
   #page2
   LET g_apcc2_d[l_ac].apcc1082 = g_apcc_d[l_ac].apcc108
   LET g_apcc2_d[l_ac].apcc1182 = g_apcc_d[l_ac].apcc118
 
   END FOR
   
   CALL aapt300_01_ref_amt()
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_apcc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapt300_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapt300_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_xrac004       LIKE xrac_t.xrac004
   DEFINE l_xrac005       LIKE xrac_t.xrac005
   DEFINE l_xrac006       LIKE xrac_t.xrac006
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   CALL aapt300_01_set_entry_b("a")  
   CALL aapt300_01_set_no_entry_b("a") 
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
   FOR l_i = 1 TO g_detail_cnt
      SELECT xrac004,xrac005,xrac006 INTO l_xrac004,l_xrac005,l_xrac006 FROM xrac_t
       WHERE xracent = g_enterprise
         AND xrac002 = g_apca_t.apca054
         AND xrac003 = g_apcc_d[l_i].apcc001
      IF cl_null(l_xrac004) THEN LET l_xrac004 = 0 END IF
      IF cl_null(l_xrac005) THEN LET l_xrac005 = 0 END IF
      IF cl_null(l_xrac006) THEN LET l_xrac006 = 0 END IF
         
      IF l_xrac004 = 0 THEN
         LET g_apcc_d[l_i].ooib002 = l_xrac004 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_i].ooib002 = l_xrac004 USING '<<<<<'
      END IF
      
      IF l_xrac005 = 0 THEN
         LET g_apcc_d[l_i].ooib002 = g_apcc_d[l_i].ooib002,"/",l_xrac005 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_i].ooib002 = g_apcc_d[l_i].ooib002,"/",l_xrac005 USING '<<<<<'
      END IF
      
      IF l_xrac006 = 0 THEN
         LET g_apcc_d[l_i].ooib002 = g_apcc_d[l_i].ooib002,"/",l_xrac006 USING '&<<<<'
      ELSE
         LET g_apcc_d[l_i].ooib002 = g_apcc_d[l_i].ooib002,"/",l_xrac006 USING '<<<<<'
      END IF
      
      LET g_apcc2_d[l_ac].apccld = g_apcc_d[l_ac].apccld 
      LET g_apcc2_d[l_ac].apccdocno = g_apcc_d[l_ac].apccdocno 
 
      LET g_apcc2_d[l_ac].apccseq = g_apcc_d[l_ac].apccseq 
 
      LET g_apcc2_d[l_ac].apcc001 = g_apcc_d[l_ac].apcc001 
 
 
      LET g_apcc3_d[l_ac].apccld = g_apcc_d[l_ac].apccld 
      LET g_apcc3_d[l_ac].apccdocno = g_apcc_d[l_ac].apccdocno 
 
      LET g_apcc3_d[l_ac].apccseq = g_apcc_d[l_ac].apccseq 
 
      LET g_apcc3_d[l_ac].apcc001 = g_apcc_d[l_ac].apcc001 
      
      #page2
      LET g_apcc2_d[l_ac].apcc1082 = g_apcc_d[l_ac].apcc108
      LET g_apcc2_d[l_ac].apcc1182 = g_apcc_d[l_ac].apcc118
   END FOR
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   CALL aapt300_01_ref_amt()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt300_01_set_entry_b(p_cmd)                                                  
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
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aapt300_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt300_01_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
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
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt300_01_default_search()
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
      LET ls_wc = ls_wc, " apccld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apccdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " apccseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " apcc001 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " apcc009 = '", g_argv[05], "' AND "
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
 
{<section id="aapt300_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt300_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "apcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'apcc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM apcc_t
          WHERE apccent = g_enterprise AND
            apccld = ps_keys_bak[1] AND apccdocno = ps_keys_bak[2] AND apccseq = ps_keys_bak[3] AND apcc001 = ps_keys_bak[4] AND apcc009 = ps_keys_bak[5]
         
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
         CALL g_apcc_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_apcc2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apcc3_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt300_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "apcc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO apcc_t
                  (apccent,
                   apccld,apccdocno,apccseq,apcc001,apcc009
                   ,apcc015,apcc002,apcc003,apcc004,apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,apcc105,apcc106,apcc107,apcc104,apcc115,apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122,apcc130,apcc131,apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apcc128,apcc129,apcc123,apcc138,apcc133,apcc139,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136,apcc137,apcc134) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003,g_apcc_d[l_ac].apcc004, 
                       g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101,g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109, 
                       g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102,g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105, 
                       g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107,g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115, 
                       g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117,g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005, 
                       g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100,g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120, 
                       g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122,g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131, 
                       g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp,g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite, 
                       g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016,g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129, 
                       g_apcc2_d[l_ac].apcc123,g_apcc2_d[l_ac].apcc138,g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139, 
                       g_apcc2_d[l_ac].apcc125,g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124, 
                       g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      #160106 albireo-----s
      UPDATE apcc_t SET apcc005 = g_apca_t.apcadocdt,
                        apcc100 = g_apca_t.apca100,
                        apcc103 = 0,
                        apcc104 = 0,
                        apcc105 = 0,
                        apcc106 = 0,
                        apcc107 = 0,
                        apcc109 = 0,
                        apcc113 = 0,
                        apcc114 = 0,
                        apcc115 = 0,
                        apcc116 = 0,
                        apcc117 = 0,
                        apcc119 = 0,
                        apcccomp = g_apca_t.apcacomp,
                        apccsite = g_apca_t.apcasite
        WHERE apccent   = g_enterprise
          AND apccld    = ps_keys[1]
          AND apccdocno = ps_keys[2]
          AND apccseq   = ps_keys[3]
          AND apcc001   = ps_keys[4]
          AND apcc009   = ps_keys[5]                    
      #160106 albireo-----e
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt300_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "apcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "apcc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE apcc_t 
         SET (apccld,apccdocno,apccseq,apcc001,apcc009
              ,apcc015,apcc002,apcc003,apcc004,apcc108,apcc101,apcc118,apcc109,apcc119,apcc102,apcc113,apcc105,apcc106,apcc107,apcc104,apcc115,apcc116,apcc117,apcc114,apcc005,apcc006,apcc100,apcc103,apcc120,apcc121,apcc122,apcc130,apcc131,apcc132,apcccomp,apcclegl,apccsite,apcc017,apcc016,apcc128,apcc129,apcc123,apcc138,apcc133,apcc139,apcc125,apcc126,apcc127,apcc124,apcc135,apcc136,apcc137,apcc134) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_apcc_d[l_ac].apcc015,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc003,g_apcc_d[l_ac].apcc004, 
                  g_apcc_d[l_ac].apcc108,g_apcc_d[l_ac].apcc101,g_apcc_d[l_ac].apcc118,g_apcc_d[l_ac].apcc109, 
                  g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].apcc102,g_apcc_d[l_ac].apcc113,g_apcc_d[l_ac].apcc105, 
                  g_apcc_d[l_ac].apcc106,g_apcc_d[l_ac].apcc107,g_apcc_d[l_ac].apcc104,g_apcc_d[l_ac].apcc115, 
                  g_apcc_d[l_ac].apcc116,g_apcc_d[l_ac].apcc117,g_apcc_d[l_ac].apcc114,g_apcc_d[l_ac].apcc005, 
                  g_apcc_d[l_ac].apcc006,g_apcc_d[l_ac].apcc100,g_apcc_d[l_ac].apcc103,g_apcc_d[l_ac].apcc120, 
                  g_apcc_d[l_ac].apcc121,g_apcc_d[l_ac].apcc122,g_apcc_d[l_ac].apcc130,g_apcc_d[l_ac].apcc131, 
                  g_apcc_d[l_ac].apcc132,g_apcc_d[l_ac].apcccomp,g_apcc_d[l_ac].apcclegl,g_apcc_d[l_ac].apccsite, 
                  g_apcc_d[l_ac].apcc017,g_apcc_d[l_ac].apcc016,g_apcc2_d[l_ac].apcc128,g_apcc2_d[l_ac].apcc129, 
                  g_apcc2_d[l_ac].apcc123,g_apcc2_d[l_ac].apcc138,g_apcc2_d[l_ac].apcc133,g_apcc2_d[l_ac].apcc139, 
                  g_apcc2_d[l_ac].apcc125,g_apcc2_d[l_ac].apcc126,g_apcc2_d[l_ac].apcc127,g_apcc2_d[l_ac].apcc124, 
                  g_apcc2_d[l_ac].apcc135,g_apcc2_d[l_ac].apcc136,g_apcc2_d[l_ac].apcc137,g_apcc2_d[l_ac].apcc134)  
 
         WHERE apccent = g_enterprise AND apccld = ps_keys_bak[1] AND apccdocno = ps_keys_bak[2] AND apccseq = ps_keys_bak[3] AND apcc001 = ps_keys_bak[4] AND apcc009 = ps_keys_bak[5]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apcc_t:",SQLERRMESSAGE 
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
 
{<section id="aapt300_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt300_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapt300_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "apcc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt300_01_bcl USING g_enterprise,
                                       g_apcc_d[g_detail_idx].apccld,g_apcc_d[g_detail_idx].apccdocno, 
                                           g_apcc_d[g_detail_idx].apccseq,g_apcc_d[g_detail_idx].apcc001, 
                                           g_apcc_d[g_detail_idx].apcc009
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt300_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt300_01_unlock_b(ps_table)
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
      CLOSE aapt300_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapt300_01_modify_detail_chk(ps_record)
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
         LET ls_return = "apcc015"
      WHEN "s_detail2"
         LET ls_return = "apccdocno_2"
      WHEN "s_detail3"
         LET ls_return = "apccdocno_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapt300_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aapt300_01.mask_functions" >}
&include "erp/aap/aapt300_01_mask.4gl"
 
{</section>}
 
{<section id="aapt300_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt300_01_set_pk_array()
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
   LET g_pk_array[1].values = g_apcc_d[l_ac].apccld
   LET g_pk_array[1].column = 'apccld'
   LET g_pk_array[2].values = g_apcc_d[l_ac].apccdocno
   LET g_pk_array[2].column = 'apccdocno'
   LET g_pk_array[3].values = g_apcc_d[l_ac].apccseq
   LET g_pk_array[3].column = 'apccseq'
   LET g_pk_array[4].values = g_apcc_d[l_ac].apcc001
   LET g_pk_array[4].column = 'apcc001'
   LET g_pk_array[5].values = g_apcc_d[l_ac].apcc009
   LET g_pk_array[5].column = 'apcc009'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_01.state_change" >}
   
 
{</section>}
 
{<section id="aapt300_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt300_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aapt300_01_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_01_ref()
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_sql      STRING
   #DEFINE l_apcc_t   RECORD LIKE apcc_t.* #161104-00024#2 mark
   #161104-00024#2-add(s)
   DEFINE l_apcc_t  RECORD  #應付多帳期檔
          apccent     LIKE apcc_t.apccent, #企業編號
          apccld      LIKE apcc_t.apccld, #帳套
          apcccomp    LIKE apcc_t.apcccomp, #法人
          apcclegl    LIKE apcc_t.apcclegl, #核算組織
          apccsite    LIKE apcc_t.apccsite, #帳務中心
          apccdocno   LIKE apcc_t.apccdocno, #應付帳款單號碼
          apccseq     LIKE apcc_t.apccseq, #項次
          apcc001     LIKE apcc_t.apcc001, #分期帳款序
          apcc002     LIKE apcc_t.apcc002, #應付款別性質
          apcc003     LIKE apcc_t.apcc003, #應付款日
          apcc004     LIKE apcc_t.apcc004, #容許票據到期日
          apcc005     LIKE apcc_t.apcc005, #帳款起算日
          apcc006     LIKE apcc_t.apcc006, #正負值
          apcc007     LIKE apcc_t.apcc007, #原幣已請款金額
          apcc008     LIKE apcc_t.apcc008, #發票編號
          apcc009     LIKE apcc_t.apcc009, #發票號碼
          apcc010     LIKE apcc_t.apcc010, #發票日期
          apcc011     LIKE apcc_t.apcc011, #交易單據日期
          apcc012     LIKE apcc_t.apcc012, #立帳日期
          apcc013     LIKE apcc_t.apcc013, #交易認定日期
          apcc014     LIKE apcc_t.apcc014, #出入庫扣帳日期
          apcc100     LIKE apcc_t.apcc100, #交易原幣別
          apcc101     LIKE apcc_t.apcc101, #原幣匯率
          apcc102     LIKE apcc_t.apcc102, #原幣重估後匯率
          apcc103     LIKE apcc_t.apcc103, #NO USE
          apcc104     LIKE apcc_t.apcc104, #NO USE
          apcc105     LIKE apcc_t.apcc105, #NO USE
          apcc106     LIKE apcc_t.apcc106, #NO USE
          apcc107     LIKE apcc_t.apcc107, #NO USE
          apcc108     LIKE apcc_t.apcc108, #原幣應付金額
          apcc109     LIKE apcc_t.apcc109, #原幣付款沖帳金額
          apcc113     LIKE apcc_t.apcc113, #重評價調整數
          apcc114     LIKE apcc_t.apcc114, #NO USE
          apcc115     LIKE apcc_t.apcc115, #NO USE
          apcc116     LIKE apcc_t.apcc116, #NO USE
          apcc117     LIKE apcc_t.apcc117, #NO USE
          apcc118     LIKE apcc_t.apcc118, #本幣應付金額
          apcc119     LIKE apcc_t.apcc119, #本幣付款沖帳金額
          apcc120     LIKE apcc_t.apcc120, #本位幣二幣別
          apcc121     LIKE apcc_t.apcc121, #本位幣二匯率
          apcc122     LIKE apcc_t.apcc122, #本位幣二重估後匯率
          apcc123     LIKE apcc_t.apcc123, #重評價調整數
          apcc124     LIKE apcc_t.apcc124, #NO USE
          apcc125     LIKE apcc_t.apcc125, #NO USE
          apcc126     LIKE apcc_t.apcc126, #NO USE
          apcc127     LIKE apcc_t.apcc127, #NO USE
          apcc128     LIKE apcc_t.apcc128, #本位幣二應付金額
          apcc129     LIKE apcc_t.apcc129, #本位幣二付款沖帳金額
          apcc130     LIKE apcc_t.apcc130, #本位幣三幣別
          apcc131     LIKE apcc_t.apcc131, #本位幣三匯率
          apcc132     LIKE apcc_t.apcc132, #本位幣三重估後匯率
          apcc133     LIKE apcc_t.apcc133, #重評價調整數
          apcc134     LIKE apcc_t.apcc134, #NO USE
          apcc135     LIKE apcc_t.apcc135, #NO USE
          apcc136     LIKE apcc_t.apcc136, #NO USE
          apcc137     LIKE apcc_t.apcc137, #NO USE
          apcc138     LIKE apcc_t.apcc138, #本位幣三應付金額
          apcc139     LIKE apcc_t.apcc139, #本位幣三付款沖帳金額
          apccud001   LIKE apcc_t.apccud001, #自定義欄位(文字)001
          apccud002   LIKE apcc_t.apccud002, #自定義欄位(文字)002
          apccud003   LIKE apcc_t.apccud003, #自定義欄位(文字)003
          apccud004   LIKE apcc_t.apccud004, #自定義欄位(文字)004
          apccud005   LIKE apcc_t.apccud005, #自定義欄位(文字)005
          apccud006   LIKE apcc_t.apccud006, #自定義欄位(文字)006
          apccud007   LIKE apcc_t.apccud007, #自定義欄位(文字)007
          apccud008   LIKE apcc_t.apccud008, #自定義欄位(文字)008
          apccud009   LIKE apcc_t.apccud009, #自定義欄位(文字)009
          apccud010   LIKE apcc_t.apccud010, #自定義欄位(文字)010
          apccud011   LIKE apcc_t.apccud011, #自定義欄位(數字)011
          apccud012   LIKE apcc_t.apccud012, #自定義欄位(數字)012
          apccud013   LIKE apcc_t.apccud013, #自定義欄位(數字)013
          apccud014   LIKE apcc_t.apccud014, #自定義欄位(數字)014
          apccud015   LIKE apcc_t.apccud015, #自定義欄位(數字)015
          apccud016   LIKE apcc_t.apccud016, #自定義欄位(數字)016
          apccud017   LIKE apcc_t.apccud017, #自定義欄位(數字)017
          apccud018   LIKE apcc_t.apccud018, #自定義欄位(數字)018
          apccud019   LIKE apcc_t.apccud019, #自定義欄位(數字)019
          apccud020   LIKE apcc_t.apccud020, #自定義欄位(數字)020
          apccud021   LIKE apcc_t.apccud021, #自定義欄位(日期時間)021
          apccud022   LIKE apcc_t.apccud022, #自定義欄位(日期時間)022
          apccud023   LIKE apcc_t.apccud023, #自定義欄位(日期時間)023
          apccud024   LIKE apcc_t.apccud024, #自定義欄位(日期時間)024
          apccud025   LIKE apcc_t.apccud025, #自定義欄位(日期時間)025
          apccud026   LIKE apcc_t.apccud026, #自定義欄位(日期時間)026
          apccud027   LIKE apcc_t.apccud027, #自定義欄位(日期時間)027
          apccud028   LIKE apcc_t.apccud028, #自定義欄位(日期時間)028
          apccud029   LIKE apcc_t.apccud029, #自定義欄位(日期時間)029
          apccud030   LIKE apcc_t.apccud030, #自定義欄位(日期時間)030
          apcc015     LIKE apcc_t.apcc015, #付款條件
          apcc016     LIKE apcc_t.apcc016, #帳款類型
          apcc017     LIKE apcc_t.apcc017  #採購單號
                END RECORD
   #161104-00024#2-add(e)          
   DEFINE l_xrac007  LIKE xrca_t.xrca007
   DEFINE l_xrac008  LIKE xrca_t.xrca008

   SELECT COUNT(*) INTO l_cnt FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccdocno = g_apca_t.apcadocno
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt < 1 THEN
      LET l_apcc_t.apccdocno = g_apca_t.apcadocno
      LET l_apcc_t.apccent = g_enterprise
      LET l_apcc_t.apccld  = g_apca_t.apcald
      LET l_apcc_t.apcclegl= g_apca_t.apcacomp
      LET l_apcc_t.apccsite= g_apca_t.apcasite
      LET l_apcc_t.apcc100 = g_apca_t.apca100
      LET l_apcc_t.apcc101 = g_apca_t.apca101
      LET l_apcc_t.apcc102 = g_apca_t.apca101
      LET l_apcc_t.apcc103 = 0
      LET l_apcc_t.apcc104 = 0
      LET l_apcc_t.apcc106 = 0
      LET l_apcc_t.apcc107 = 0
      LET l_apcc_t.apcc109 = 0
      LET l_apcc_t.apcc113 = 0
      LET l_apcc_t.apcc114 = 0
      LET l_apcc_t.apcc116 = 0
      LET l_apcc_t.apcc117 = 0
      LET l_apcc_t.apcc119 = 0
      LET l_apcc_t.apcc120 = g_glaa.glaa016
      LET l_apcc_t.apcc121 = g_apca_t.apca121
      LET l_apcc_t.apcc122 = g_apca_t.apca121
      LET l_apcc_t.apcc123 = 0
      LET l_apcc_t.apcc124 = 0
      LET l_apcc_t.apcc126 = 0
      LET l_apcc_t.apcc127 = 0
      LET l_apcc_t.apcc129 = 0
      LET l_apcc_t.apcc130 = g_glaa.glaa020
      LET l_apcc_t.apcc131 = g_apca_t.apca131
      LET l_apcc_t.apcc132 = g_apca_t.apca131
      LET l_apcc_t.apcc133 = 0
      LET l_apcc_t.apcc134 = 0
      LET l_apcc_t.apcc136 = 0
      LET l_apcc_t.apcc137 = 0
      LET l_apcc_t.apcc139 = 0
      
      LET l_sql = "SELECT apcbseq,xrac003,xrac007,apcb022,",
                  "       apcb105*xrac008/100,apcb105*xrac008/100,apcb115*xrac008/100,apcb115*xrac008/100,",
                  "       apcb125*xrac008/100,apcb125*xrac008/100,apcb135*xrac008/100,apcb135*xrac008/100",
                  "  FROM apcb_t,apca_t,xrac_t",
                  " WHERE apcbdocno = apcadocno",
                  "   AND apcbent   = apcaent",
                  "   AND apcbld    = apcald",
                  "   AND apca054   = xrac002",
                  "   AND apcadocno = '",g_apca_t.apcadocno,"'",
                  "   AND apcbent   = '",g_enterprise,"'",
                  "   AND apcald    = '",g_apca_t.apcald,"'"
      PREPARE aapt300_01_prep FROM l_sql
      DECLARE aapt300_01_curs CURSOR FOR aapt300_01_prep
      
      FOREACH aapt300_01_curs INTO l_apcc_t.apccseq,l_apcc_t.apcc001,l_apcc_t.apcc002,l_apcc_t.apcc006,
                                   l_apcc_t.apcc105,l_apcc_t.apcc108,l_apcc_t.apcc115,l_apcc_t.apcc118,
                                   l_apcc_t.apcc125,l_apcc_t.apcc128,l_apcc_t.apcc135,l_apcc_t.apcc138
         CALL s_fin_date_ar_multi_period_get(l_apcc_t.apccsite,g_apca_t.apca054,l_apcc_t.apcc001,g_apca_t.apca009)
            RETURNING g_success,l_xrac007,l_xrac008,l_apcc_t.apcc003
            
         CALL s_fin_date_ar_multi_period_get(l_apcc_t.apccsite,g_apca_t.apca054,l_apcc_t.apcc001,g_apca_t.apca010)
            RETURNING g_success,l_xrac007,l_xrac008,l_apcc_t.apcc004
         
         LET l_apcc_t.apcc005 = g_apca_t.apcadocno
         
         #INSERT INTO apcc_t VALUES(l_apcc_t.*)  #161108-00017#3 mark
         #161108-00017#3 add ------
         INSERT INTO apcc_t (apccent,apccld,apcccomp,apcclegl,apccsite,
                             apccdocno,apccseq,
                             apcc001,apcc002,apcc003,apcc004,apcc005,
                             apcc006,apcc007,apcc008,apcc009,apcc010,
                             apcc011,apcc012,apcc013,apcc014,apcc100,
                             apcc101,apcc102,apcc103,apcc104,apcc105,
                             apcc106,apcc107,apcc108,apcc109,apcc113,
                             apcc114,apcc115,apcc116,apcc117,apcc118,
                             apcc119,apcc120,apcc121,apcc122,apcc123,
                             apcc124,apcc125,apcc126,apcc127,apcc128,
                             apcc129,apcc130,apcc131,apcc132,apcc133,
                             apcc134,apcc135,apcc136,apcc137,apcc138,
                             apcc139,
                             apccud001,apccud002,apccud003,apccud004,apccud005,
                             apccud006,apccud007,apccud008,apccud009,apccud010,
                             apccud011,apccud012,apccud013,apccud014,apccud015,
                             apccud016,apccud017,apccud018,apccud019,apccud020,
                             apccud021,apccud022,apccud023,apccud024,apccud025,
                             apccud026,apccud027,apccud028,apccud029,apccud030,
                             apcc015,apcc016,apcc017
                            )
         VALUES (l_apcc_t.apccent,l_apcc_t.apccld,l_apcc_t.apcccomp,l_apcc_t.apcclegl,l_apcc_t.apccsite,
                 l_apcc_t.apccdocno,l_apcc_t.apccseq,
                 l_apcc_t.apcc001,l_apcc_t.apcc002,l_apcc_t.apcc003,l_apcc_t.apcc004,l_apcc_t.apcc005,
                 l_apcc_t.apcc006,l_apcc_t.apcc007,l_apcc_t.apcc008,l_apcc_t.apcc009,l_apcc_t.apcc010,
                 l_apcc_t.apcc011,l_apcc_t.apcc012,l_apcc_t.apcc013,l_apcc_t.apcc014,l_apcc_t.apcc100,
                 l_apcc_t.apcc101,l_apcc_t.apcc102,l_apcc_t.apcc103,l_apcc_t.apcc104,l_apcc_t.apcc105,
                 l_apcc_t.apcc106,l_apcc_t.apcc107,l_apcc_t.apcc108,l_apcc_t.apcc109,l_apcc_t.apcc113,
                 l_apcc_t.apcc114,l_apcc_t.apcc115,l_apcc_t.apcc116,l_apcc_t.apcc117,l_apcc_t.apcc118,
                 l_apcc_t.apcc119,l_apcc_t.apcc120,l_apcc_t.apcc121,l_apcc_t.apcc122,l_apcc_t.apcc123,
                 l_apcc_t.apcc124,l_apcc_t.apcc125,l_apcc_t.apcc126,l_apcc_t.apcc127,l_apcc_t.apcc128,
                 l_apcc_t.apcc129,l_apcc_t.apcc130,l_apcc_t.apcc131,l_apcc_t.apcc132,l_apcc_t.apcc133,
                 l_apcc_t.apcc134,l_apcc_t.apcc135,l_apcc_t.apcc136,l_apcc_t.apcc137,l_apcc_t.apcc138,
                 l_apcc_t.apcc139,
                 l_apcc_t.apccud001,l_apcc_t.apccud002,l_apcc_t.apccud003,l_apcc_t.apccud004,l_apcc_t.apccud005,
                 l_apcc_t.apccud006,l_apcc_t.apccud007,l_apcc_t.apccud008,l_apcc_t.apccud009,l_apcc_t.apccud010,
                 l_apcc_t.apccud011,l_apcc_t.apccud012,l_apcc_t.apccud013,l_apcc_t.apccud014,l_apcc_t.apccud015,
                 l_apcc_t.apccud016,l_apcc_t.apccud017,l_apcc_t.apccud018,l_apcc_t.apccud019,l_apcc_t.apccud020,
                 l_apcc_t.apccud021,l_apcc_t.apccud022,l_apcc_t.apccud023,l_apcc_t.apccud024,l_apcc_t.apccud025,
                 l_apcc_t.apccud026,l_apcc_t.apccud027,l_apcc_t.apccud028,l_apcc_t.apccud029,l_apcc_t.apccud030,
                 l_apcc_t.apcc015,l_apcc_t.apcc016,l_apcc_t.apcc017
                )
         #161108-00017#3 add end---
      END FOREACH
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刷新合計金額顯示
# Memo...........:
# Usage..........: CALL axrt300_02_ref_amt()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_01_ref_amt()
   DEFINE l_amt1,l_amt2,l_amt3,l_amt4          LIKE xrce_t.xrce109     #應付款金額
   DEFINE l_amt5,l_amt6,l_amt7,l_amt8          LIKE xrce_t.xrce109     #已沖帳金額
   DEFINE l_amt9,l_amt10,l_amt11,l_amt12       LIKE xrce_t.xrce109     #重評價匯差金額
   DEFINE l_amt13,l_amt14,l_amt15,l_amt16      LIKE xrce_t.xrce109     #未沖帳金額
   DEFINE l_str                                STRING
   
   DISPLAY g_apca_t.apca100 TO apca100
   DISPLAY g_glaa.glaa001,g_glaa.glaa016,g_glaa.glaa020 TO glaa001,glaa016,glaa020
   DISPLAY g_apca_t.apca101,g_apca_t.apca121,g_apca_t.apca131 TO apca101,apca121,apca131

   #應付款金額
   LET l_amt1 = g_apca_t.apca108
   LET l_amt2 = g_apca_t.apca118
   LET l_amt3 = g_apca_t.apca128
   LET l_amt4 = g_apca_t.apca138
   IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
   
   #已沖帳金額
   SELECT SUM(apcc109),SUM(apcc119),SUM(apcc129),SUM(apcc139) INTO l_amt5,l_amt6,l_amt7,l_amt8
     FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccld  = g_apca_t.apcald
      AND apccdocno = g_apca_t.apcadocno
   IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
   IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
   IF cl_null(l_amt7) THEN LET l_amt7 = 0 END IF
   IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
   
   #重評價匯差金額
   SELECT SUM(apcc113),SUM(apcc123),SUM(apcc133) INTO l_amt10,l_amt11,l_amt12
     FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccld  = g_apca_t.apcald
      AND apccdocno = g_apca_t.apcadocno
   IF cl_null(l_amt9) THEN LET l_amt9 = 0 END IF
   IF cl_null(l_amt10) THEN LET l_amt10 = 0 END IF
   IF cl_null(l_amt11) THEN LET l_amt11 = 0 END IF
   IF cl_null(l_amt12) THEN LET l_amt12 = 0 END IF
   
   #未沖帳金額
   LET l_amt13 = l_amt1 - l_amt5 + l_amt9
   LET l_amt14 = l_amt2 - l_amt6 + l_amt10
   LET l_amt15 = l_amt3 - l_amt7 + l_amt11
   LET l_amt16 = l_amt4 - l_amt8 + l_amt12

   #差異金額
   SELECT SUM(apcc108),SUM(apcc118),SUM(apcc128),SUM(apcc138) INTO g_amt17,g_amt18,g_amt19,g_amt20 FROM apcc_t
    WHERE apccent = g_enterprise
      AND apccld  = g_apca_t.apcald
      AND apccdocno = g_apca_t.apcadocno
   IF cl_null(g_amt17) THEN LET g_amt17 = 0 END IF
   IF cl_null(g_amt18) THEN LET g_amt18 = 0 END IF
   IF cl_null(g_amt19) THEN LET g_amt19 = 0 END IF
   IF cl_null(g_amt20) THEN LET g_amt20 = 0 END IF
   LET g_amt17 = g_apca_t.apca108 - g_amt17
   LET g_amt18 = g_apca_t.apca118 - g_amt18
   LET g_amt19 = g_apca_t.apca128 - g_amt19
   LET g_amt20 = g_apca_t.apca138 - g_amt20

   #14/11/06 mark------------------------------------
   ##交易合計金額
   #LET l_amt1 = g_apca_t.apca103 + g_apca_t.apca104
   #LET l_amt2 = g_apca_t.apca113 + g_apca_t.apca114
   #LET l_amt3 = g_apca_t.apca123 + g_apca_t.apca124
   #LET l_amt4 = g_apca_t.apca133 + g_apca_t.apca134
   #IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
   #IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   #IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   #IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
   ##沖銷帳金額
   #LET l_amt5 = g_apca_t.apca106 + g_apca_t.apca107
   #LET l_amt6 = g_apca_t.apca116 + g_apca_t.apca117
   #LET l_amt7 = g_apca_t.apca126 + g_apca_t.apca127
   #LET l_amt8 = g_apca_t.apca136 + g_apca_t.apca137
   #IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
   #IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
   #IF cl_null(l_amt7) THEN LET l_amt7 = 0 END IF
   #IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
   ##調整付款金額
   #SELECT SUM(apcc104),SUM(apcc114),SUM(apcc124),SUM(apcc134) INTO l_amt9,l_amt10,l_amt11,l_amt12 FROM apcc_t
   # WHERE apccent = g_enterprise
   #   AND apccld  = g_apca_t.apcald
   #   AND apccdocno = g_apca_t.apcadocno
   #IF cl_null(l_amt9)  THEN LET l_amt9  = 0 END IF
   #IF cl_null(l_amt10) THEN LET l_amt10 = 0 END IF
   #IF cl_null(l_amt11) THEN LET l_amt11 = 0 END IF
   #IF cl_null(l_amt12) THEN LET l_amt12 = 0 END IF
   #14/11/06 mark end--------------------------------

   IF g_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('glaa016,apca121',FALSE)
      CALL cl_set_comp_visible('FFLabel11,FFLabel12,FFLabel13,FFLabel14',FALSE)
      CALL cl_set_comp_visible('amt3,amt7,amt11,amt15,amt19',FALSE)
   ELSE
      CALL cl_set_comp_visible('glaa016,apca121',TRUE)
      CALL cl_set_comp_visible('FFLabel11,FFLabel12,FFLabel13,FFLabel14',TRUE)
      CALL cl_set_comp_visible('amt3,amt7,amt11,amt15,amt19',TRUE)
   END IF
   IF g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('glaa020,apca131',FALSE)
      CALL cl_set_comp_visible('FFLabel21,FFLabel22,FFLabel23,FFLabel24',FALSE)
      CALL cl_set_comp_visible('amt4,amt8,amt12,amt16,amt20',FALSE)
   ELSE
      CALL cl_set_comp_visible('glaa020,apca131',TRUE)
      CALL cl_set_comp_visible('FFLabel21,FFLabel22,FFLabel23,FFLabel24',FALSE)
      CALL cl_set_comp_visible('amt4,amt8,amt12,amt16,amt20',TRUE)
   END IF

   DISPLAY l_amt1,l_amt5,l_amt9, l_amt13,g_amt17 TO amt1,amt5,amt9, amt13,amt17
   DISPLAY l_amt2,l_amt6,l_amt10,l_amt14,g_amt18 TO amt2,amt6,amt10,amt14,amt18
   DISPLAY l_amt3,l_amt7,l_amt11,l_amt15,g_amt19 TO amt3,amt7,amt11,amt15,amt19
   DISPLAY l_amt4,l_amt8,l_amt12,l_amt16,g_amt20 TO amt4,amt8,amt12,amt16,amt20
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aapt300_01_set_comp_att_text(ps_fields,ps_att_value)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_01_set_comp_att_text(ps_fields,ps_att_value)
   DEFINE   ps_fields          STRING,
            ps_att_value       STRING
   DEFINE   lst_fields         base.StringTokenizer,
            lst_string         base.StringTokenizer,
            ls_field_name      STRING,
            ls_field_value     STRING,
            ls_win_name        STRING
   DEFINE   lnode_root         om.DomNode,
            lnode_win          om.DomNode,
            lnode_pre          om.DomNode,
            llst_items         om.NodeList,
            lnode_list         om.NodeList,
            li_i               LIKE type_t.num5,
            lnode_item         om.DomNode,
            ls_item_name       STRING,
            lnode_item_child   om.DomNode,
            ls_item_pre_tag    STRING,
            ls_item_tag_name   STRING
   DEFINE   g_chg              DYNAMIC ARRAY OF RECORD
               item            STRING,
               value           STRING
                               END RECORD
   DEFINE   lwin_curr          ui.Window
   DEFINE   ls_btn_name        STRING
   DEFINE l_str STRING
   DEFINE l_cnt SMALLINT
   DEFINE   lnode_p            om.DomNode,
            ls_item_tag_name_p STRING,
            ls_item_name_p     STRING,
            ls_str_p           LIKE type_t.chr100

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN

      RETURN
   END IF


   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
   LET ls_win_name = lnode_win.getAttribute("name")

   LET llst_items = lnode_win.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   LET lst_string = base.StringTokenizer.create(ps_att_value,",")
   WHILE lst_fields.hasMoreTokens() AND lst_string.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_value = lst_string.nextToken()
      LET ls_field_name = ls_field_name.trim()

      IF ls_field_name.equals(ls_win_name) THEN
         CALL lnode_win.setAttribute("text",ls_field_value)
      END IF

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            LET ls_item_tag_name = lnode_item.getTagName()
            IF ls_item_tag_name.equals("Item") THEN
               IF (ls_item_name IS NOT NULL) THEN
                    LET lnode_p = lnode_item.getParent()   #取父結點
                  LET ls_item_tag_name_p = lnode_p.getTagName()   #父結點類型
                  IF ls_item_tag_name_p.equals("RadioGroup") OR ls_item_tag_name_p.equals("ComboBox") THEN
                         LET ls_item_name_p = lnode_p.getAttribute("comment")  #取comment因為裡面一定會有[***]
                         LET ls_str_p = ls_item_name_p
                         #取[]之間的東西
                         select substr(ls_str_p,instr(ls_str_p,'[',1)+1,length(ls_str_p)-instr(ls_str_p,'[',1)-1) INTO ls_str_p from dual
                         LET ls_item_name = ls_str_p CLIPPED || '_' || ls_item_name
                  END IF
               END IF
            END IF

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET ls_item_tag_name = lnode_item.getTagName()
            LET lnode_list = lnode_item.selectByTagName("CheckBox")
            LET l_cnt = lnode_list.getlength()
            IF ls_item_tag_name.equals("TableColumn") OR
               ls_item_tag_name.equals("Page") OR
               ls_item_tag_name.equals("Item") OR
               ls_item_tag_name.equals("Group") OR
               ls_item_tag_name.equals("Label") OR
               ls_item_tag_name.equals("Window")OR
               ls_item_tag_name.equals("Button") THEN
               CALL lnode_item.setAttribute("text",ls_field_value.trim())
            ELSE
               IF l_cnt > 0 THEN
                  LET lnode_item_child = lnode_item.getFirstChild()
                  CALL lnode_item_child.setAttribute("text",ls_field_value.trim())
               ELSE
                  LET lnode_pre = lnode_item.getPrevious()
                  LET ls_item_pre_tag = lnode_pre.getTagName()
                  IF ls_item_pre_tag.equals("Label") THEN
                     CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                  ELSE
                     IF ls_item_pre_tag.equals("Button") THEN
                        LET ls_btn_name = lnode_pre.getAttribute("name")
                        IF ls_btn_name.subString(1,4) = "btn_" THEN
                           LET lnode_pre = lnode_pre.getPrevious()
                           LET ls_item_pre_tag = lnode_pre.getTagName()
                           IF ls_item_pre_tag.equals("Label") THEN
                              CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                           END IF
                        END IF
                     END IF
                  END IF
              END IF
            END IF
            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION

 
{</section>}
 
