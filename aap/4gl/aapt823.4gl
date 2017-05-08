#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt823.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-09-04 17:05:27), PR版次:0012(2017-01-23 10:13:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aapt823
#+ Description: 多廠商付款單維護作業(流通)
#+ Creator....: 03538(2016-06-29 11:22:59)
#+ Modifier...: 07142 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt823.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141218-00011#6   15/01/06   By Belle    單身維護時：其他信息的核算，不必檢核是否有輸入及合理性。
#150128-00005#1   15/01/28   By Belle    核算項分錄是否重新產生改到確認段處理
#150128-00005#9   15/02/02   By apo      1.無單身時自動產生帳款單身跳窗取消
#150205-00012#1   15/02/10   BY Hans     進欄位之後只顯示編號不顯示中文名稱
#150311           15/03/11   By apo      配合狀態碼狀態修改/調整整帳批序號應用
#150427           15/04/27   By apo      當aapt823付款單身apde002
#                                        1.為20/21/22:
#                                        apde038預帶apde013(單身轉入對象)
#                                        2.非20/21/22:
#                                        apde038預帶apda005(單頭付款對象)
#                                        產生分錄底稿時,帳款客商與交易客商都以apde038值為準
#150512-00036#1   15/05/19   By apo      帳款單號開窗改為開窗多選寫入
#150506-00033#6   15/05/20   By RayHuang 新增單據串查功能
#150629-00028#1   15/06/29   By apo      預設富款單身資訊時,同時預設會計科目
#150401-00001#13  15/07/17   By RayHuang statechange段問題修正
#150812-00010#3   15/08/28   By apo      當單身金額都是0,不新增該筆
#150930-00010#4   15/10/06   BY 03538    若有登打付款交易帳戶時, 依s-fin-4012 取用
#151029           15/10/29   By 03538    多帳期的key只要到帳期為止即可,因為不同發票會拆成不同項次
#151104           15/11/04   By 03538    帳款單身已先維護摘要,開窗選擇單號後,摘要需要保持原來維護的值(FMT提出)
#151105-00007#2   2015/11/05 By Charles4m 作廢狀態時需可正常維護作廢原因，並為必填。
#151105           2015/11/05 By 03538    151105 carol:當支付款別為10.現金,不參考S-FIN3008(直接產生銀存支付帳),一律都要產生到nmbc;所以相關欄位必填
#151125-00006#2   2015/12/02 By 06421    新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#151130-00015#4   2015/12/23 By 02097    配合s_aapt823增加參數
#151231-00010#1   2016/01/20 By sakura   增加控制組
#160104-00007#3   2016/01/29 By Hans     單據作業傳票還原功能aapt823
#160125-00005#6   2016/02/15 By 02097    查詢時，只顯示有權限的帳套
#160122-00001#5   2016/02/22 By 07673    添加交易账户编号用户权限控管
#                                        当没有权限时，用户不能看到交易账户编号，用“*”显示，当有权限时，才可以看到具体交易账户编号。
#160203-00009#1   2016/02/25 By 02097    增加串查
#160202-00021#2   2016/03/10 By 02097    受款人全名 apde041 欄位, 預設帶基本資料帳戶對應戶名 pmaf004
#160225-00001#1   2016/03/04 By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160318-00005#2   2016/03/18 By Jessy    修正azzi920重複定義之錯誤訊息
#160321-00016#21  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息(sub部分)
#160324-00032#3   2016/03/30 By 03538    受款人全名不可異動;款別類型=30.票據類,apde041 帶付款對象全名,受款銀行及受款帳戶放空白;款別類型=10 或20,受款銀行及受款帳戶.受款人全名 預帶主要付款帳戶資料
#160325-00026#1   2016/04/01 By catmoon  若第二單身付款類型選'16收票轉付',則付款其他信息的帳款對象,應該是該收票單號的交易對象
#160318-00025#25  2016/04/26 BY 07900    校验代码重复错误讯息的修改
#160420-00001#11  2016/04/29 By 03538    已付款單開窗, 只要同法人之同對象未沖資料皆可取,不考慮資金中心(nmcksite)的條件
#160429-00010#1   2016/04/29 By 03538    交易銀行+帳戶的檢核,也應該加入交易對象當作key值
#160419-00040#1   2016/05/09 By 03538    富款單身為16:收票轉付時,已付款單號狀態加入V複核也為合理
#160726-00020#17  2016/08/23 By 08729    複製時清空特定欄位
#160822-00008#4   2016/08/24 By 08732    新舊值調整
#160829-00004#1   2016/08/30 By 08729    處理取匯率但幣別取錯
#160920-00019#2   2016/09/21 By 08732    交易對象開窗校驗調整
#161006-00005#8   2016/10/12 By 08732    組織類型與職能開窗調整
#161115-00046#2   2016/11/22 By 08171    開窗範圍處理
#161026-00010#2   2017/01/04 By 01531    改狀態條件抓取已复核狀態的资料
#161229-00047#63  2017/01/12 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170123-00010#1   2017/01/23 By 06821    SQL中缺乏ent條件
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
GLOBALS "../../cfg/top_finance.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apda_m        RECORD
       apdasite LIKE apda_t.apdasite, 
   apdasite_desc LIKE type_t.chr80, 
   apda003 LIKE apda_t.apda003, 
   apda003_desc LIKE type_t.chr80, 
   apdald LIKE apda_t.apdald, 
   apdald_desc LIKE type_t.chr80, 
   apdadocno LIKE apda_t.apdadocno, 
   apdadocno_desc LIKE type_t.chr80, 
   apda001 LIKE apda_t.apda001, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apda005 LIKE apda_t.apda005, 
   apda005_desc LIKE type_t.chr80, 
   apda023 LIKE apda_t.apda023, 
   apda014 LIKE apda_t.apda014, 
   apdastus LIKE apda_t.apdastus, 
   apdacomp LIKE apda_t.apdacomp, 
   apda008 LIKE apda_t.apda008, 
   apda010 LIKE apda_t.apda010, 
   apda018 LIKE apda_t.apda018, 
   apda018_desc LIKE type_t.chr80, 
   apda007 LIKE apda_t.apda007, 
   apda009 LIKE apda_t.apda009, 
   apda015 LIKE apda_t.apda015, 
   apda015_desc LIKE type_t.chr80, 
   apda016 LIKE apda_t.apda016, 
   apda017 LIKE apda_t.apda017, 
   apdaownid LIKE apda_t.apdaownid, 
   apdaownid_desc LIKE type_t.chr80, 
   apdaowndp LIKE apda_t.apdaowndp, 
   apdaowndp_desc LIKE type_t.chr80, 
   apdacrtid LIKE apda_t.apdacrtid, 
   apdacrtid_desc LIKE type_t.chr80, 
   apdacrtdp LIKE apda_t.apdacrtdp, 
   apdacrtdp_desc LIKE type_t.chr80, 
   apdacrtdt LIKE apda_t.apdacrtdt, 
   apdamodid LIKE apda_t.apdamodid, 
   apdamodid_desc LIKE type_t.chr80, 
   apdamoddt LIKE apda_t.apdamoddt, 
   apdacnfid LIKE apda_t.apdacnfid, 
   apdacnfid_desc LIKE type_t.chr80, 
   apdacnfdt LIKE apda_t.apdacnfdt, 
   dummy3 LIKE type_t.chr100, 
   glaa001 LIKE type_t.chr10, 
   sum_apde1092 LIKE type_t.num20_6, 
   sum_apde1192 LIKE type_t.num20_6, 
   sum_apde1091 LIKE type_t.num20_6, 
   sum_apde1191 LIKE type_t.num20_6, 
   sum_apde1093 LIKE type_t.num20_6, 
   sum_apde1193 LIKE type_t.num20_6, 
   sum_apde1094 LIKE type_t.num20_6, 
   sum_apde1194 LIKE type_t.num20_6, 
   glaa016 LIKE type_t.chr10, 
   glaa020 LIKE type_t.chr10, 
   sum_apde1291 LIKE type_t.num20_6, 
   sum_apde1391 LIKE type_t.num20_6, 
   sum_apde1292 LIKE type_t.num20_6, 
   sum_apde1392 LIKE type_t.num20_6, 
   sum_apde1293 LIKE type_t.num20_6, 
   sum_apde1393 LIKE type_t.num20_6, 
   sum_apde1294 LIKE type_t.num20_6, 
   sum_apde1394 LIKE type_t.num20_6
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apce_d        RECORD
       apceseq LIKE apce_t.apceseq, 
   apce002 LIKE apce_t.apce002, 
   apceorga LIKE apce_t.apceorga, 
   apceorga_desc LIKE type_t.chr500, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce005 LIKE apce_t.apce005, 
   l_yymm LIKE type_t.chr500, 
   apce061 LIKE apce_t.apce061, 
   apce061_desc LIKE type_t.chr500, 
   apce038 LIKE apce_t.apce038, 
   apce038_desc LIKE type_t.chr500, 
   l_apca057 LIKE type_t.chr20, 
   l_apca057_desc LIKE type_t.chr500, 
   apce048 LIKE apce_t.apce048, 
   apce024 LIKE apce_t.apce024, 
   apce100 LIKE apce_t.apce100, 
   apce109 LIKE apce_t.apce109, 
   apce101 LIKE apce_t.apce101, 
   apce119 LIKE apce_t.apce119, 
   apce015 LIKE apce_t.apce015, 
   apce016 LIKE apce_t.apce016, 
   apce016_desc LIKE type_t.chr500, 
   apce010 LIKE apce_t.apce010, 
   apce031 LIKE apce_t.apce031, 
   apce049 LIKE apce_t.apce049, 
   apcecomp LIKE apce_t.apcecomp, 
   apcesite LIKE apce_t.apcesite, 
   apce001 LIKE apce_t.apce001
       END RECORD
PRIVATE TYPE type_g_apce2_d RECORD
       apdeseq LIKE apde_t.apdeseq, 
   apdeorga LIKE apde_t.apdeorga, 
   apdeorga_desc LIKE type_t.chr500, 
   apde002 LIKE apde_t.apde002, 
   apde006 LIKE apde_t.apde006, 
   apde003 LIKE apde_t.apde003, 
   apde008 LIKE apde_t.apde008, 
   lc_apde008 LIKE type_t.chr20, 
   apde021 LIKE apde_t.apde021, 
   apde024 LIKE apde_t.apde024, 
   apde100 LIKE apde_t.apde100, 
   apde109 LIKE apde_t.apde109, 
   apde101 LIKE apde_t.apde101, 
   apde119 LIKE apde_t.apde119, 
   apde032 LIKE apde_t.apde032, 
   apde013 LIKE apde_t.apde013, 
   apde013_desc LIKE type_t.chr500, 
   apde014 LIKE apde_t.apde014, 
   apde015 LIKE apde_t.apde015, 
   apde016 LIKE apde_t.apde016, 
   apde016_desc LIKE type_t.chr500, 
   apde010 LIKE apde_t.apde010, 
   apde009 LIKE apde_t.apde009, 
   apde039 LIKE apde_t.apde039, 
   apde040 LIKE apde_t.apde040, 
   apde041 LIKE apde_t.apde041, 
   apde011 LIKE apde_t.apde011, 
   apde011_desc LIKE type_t.chr500, 
   apde012 LIKE apde_t.apde012, 
   apde012_desc LIKE type_t.chr500, 
   apde046 LIKE apde_t.apde046, 
   apdecomp LIKE apde_t.apdecomp, 
   apdesite LIKE apde_t.apdesite, 
   apde001 LIKE apde_t.apde001
       END RECORD
PRIVATE TYPE type_g_apce3_d RECORD
       apceseq LIKE apce_t.apceseq, 
   apce0022 LIKE type_t.chr20, 
   apce0152 LIKE type_t.chr1, 
   apce0162 LIKE type_t.chr500, 
   apce0162_desc LIKE type_t.chr500, 
   apce017 LIKE apce_t.apce017, 
   apce017_desc LIKE type_t.chr500, 
   apce018 LIKE apce_t.apce018, 
   apce018_desc LIKE type_t.chr500, 
   apce019 LIKE apce_t.apce019, 
   apce019_desc LIKE type_t.chr500, 
   apce020 LIKE apce_t.apce020, 
   apce020_desc LIKE type_t.chr500, 
   apce022 LIKE apce_t.apce022, 
   apce022_desc LIKE type_t.chr500, 
   apce023 LIKE apce_t.apce023, 
   apce023_desc LIKE type_t.chr500, 
   apce035 LIKE apce_t.apce035, 
   apce035_desc LIKE type_t.chr500, 
   apce036 LIKE apce_t.apce036, 
   apce036_desc LIKE type_t.chr500, 
   apce044 LIKE apce_t.apce044, 
   apce044_desc LIKE type_t.chr500, 
   apce045 LIKE apce_t.apce045, 
   apce045_desc LIKE type_t.chr500, 
   apce046 LIKE apce_t.apce046, 
   apce046_desc LIKE type_t.chr500, 
   apce051 LIKE apce_t.apce051, 
   apce051_desc LIKE type_t.chr500, 
   apce052 LIKE apce_t.apce052, 
   apce052_desc LIKE type_t.chr500, 
   apce053 LIKE apce_t.apce053, 
   apce053_desc LIKE type_t.chr500, 
   apce054 LIKE apce_t.apce054, 
   apce054_desc LIKE type_t.chr500, 
   apce055 LIKE apce_t.apce055, 
   apce055_desc LIKE type_t.chr500, 
   apce056 LIKE apce_t.apce056, 
   apce056_desc LIKE type_t.chr500, 
   apce057 LIKE apce_t.apce057, 
   apce057_desc LIKE type_t.chr500, 
   apce058 LIKE apce_t.apce058, 
   apce058_desc LIKE type_t.chr500, 
   apce059 LIKE apce_t.apce059, 
   apce059_desc LIKE type_t.chr500, 
   apce060 LIKE apce_t.apce060, 
   apce060_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_apce4_d RECORD
       apceseq LIKE apce_t.apceseq, 
   apce0023 LIKE type_t.chr20, 
   apce0033 LIKE type_t.chr20, 
   apce0043 LIKE type_t.num10, 
   apce0053 LIKE type_t.num10, 
   apce1003 LIKE type_t.chr10, 
   apce1093 LIKE type_t.num20_6, 
   apce1013 LIKE type_t.num26_10, 
   apce1193 LIKE type_t.num20_6, 
   apce120 LIKE apce_t.apce120, 
   apce121 LIKE apce_t.apce121, 
   apce129 LIKE apce_t.apce129, 
   apce130 LIKE apce_t.apce130, 
   apce131 LIKE apce_t.apce131, 
   apce139 LIKE apce_t.apce139
       END RECORD
PRIVATE TYPE type_g_apce5_d RECORD
       apdeseq LIKE apde_t.apdeseq, 
   apde0022 LIKE type_t.chr10, 
   apde0152 LIKE type_t.chr1, 
   apde0162 LIKE type_t.chr500, 
   apde0162_desc LIKE type_t.chr500, 
   apde038 LIKE apde_t.apde038, 
   apde038_desc LIKE type_t.chr500, 
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
PRIVATE TYPE type_g_apce6_d RECORD
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
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apdadocno LIKE apda_t.apdadocno,
      b_apdald LIKE apda_t.apdald
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ap_slip             LIKE ooba_t.ooba002           #應付帳款單單別
DEFINE g_gl_slip             LIKE ooba_t.ooba002           #總帳單別
DEFINE g_fin_arg1            LIKE gzsz_t.gzsz002           #財務應用參數(定義於azzi991)D-FIN-3006--應付沖銷單性質
DEFINE g_sfin3008            LIKE type_t.chr80             #S-FIN-3008-付款單直接產生銀存支付帳
DEFINE g_sfin2002            LIKE type_t.chr80             #S-FIN-2002-應付沖帳參數
DEFINE g_glaa                RECORD
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
DEFINE g_glad            RECORD
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
DEFINE g_dfin0030        LIKE type_t.chr1
DEFINE g_ld_wc           STRING
DEFINE g_site_wc         STRING
DEFINE g_sfin3007        LIKE apca_t.apcadocdt
DEFINE g_sfin4012        LIKE type_t.chr80   #銀存支出匯率來源   #150930-00010#4

DEFINE g_amt1_d          LIKE xrde_t.xrde109
DEFINE g_amt2_d          LIKE xrde_t.xrde109
DEFINE g_amt3_c          LIKE xrde_t.xrde109
DEFINE g_amt4_c          LIKE xrde_t.xrde109
DEFINE g_amt5_diff       LIKE xrde_t.xrde109
DEFINE g_amt6_diff       LIKE xrde_t.xrde109
DEFINE g_amt1_d_1        LIKE xrde_t.xrde109
DEFINE g_amt2_d_1        LIKE xrde_t.xrde109
DEFINE g_amt3_c_1        LIKE xrde_t.xrde109
DEFINE g_amt4_c_1        LIKE xrde_t.xrde109
DEFINE g_amt5_diff_1     LIKE xrde_t.xrde109
DEFINE g_amt6_diff_1     LIKE xrde_t.xrde109
DEFINE g_sql_ctrl        STRING                #151231-00010#1
DEFINE g_wc_cs_ld        STRING                #160125-00005#6
DEFINE g_wc_cs_orga      STRING                #160125-00005#6
DEFINE g_sql_bank        STRING                #160122-00001#5
DEFINE g_site_str        STRING                #161115-00046#2 add
DEFINE g_wc_apdald       STRING                #161115-00046#2 add
#161229-00047#63 add ------
DEFINE g_wc_cs_comp      STRING
DEFINE g_comp_str        STRING
#161229-00047#63 add end---
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apda_m          type_g_apda_m
DEFINE g_apda_m_t        type_g_apda_m
DEFINE g_apda_m_o        type_g_apda_m
DEFINE g_apda_m_mask_o   type_g_apda_m #轉換遮罩前資料
DEFINE g_apda_m_mask_n   type_g_apda_m #轉換遮罩後資料
 
   DEFINE g_apdald_t LIKE apda_t.apdald
DEFINE g_apdadocno_t LIKE apda_t.apdadocno
 
 
DEFINE g_apce_d          DYNAMIC ARRAY OF type_g_apce_d
DEFINE g_apce_d_t        type_g_apce_d
DEFINE g_apce_d_o        type_g_apce_d
DEFINE g_apce_d_mask_o   DYNAMIC ARRAY OF type_g_apce_d #轉換遮罩前資料
DEFINE g_apce_d_mask_n   DYNAMIC ARRAY OF type_g_apce_d #轉換遮罩後資料
DEFINE g_apce2_d          DYNAMIC ARRAY OF type_g_apce2_d
DEFINE g_apce2_d_t        type_g_apce2_d
DEFINE g_apce2_d_o        type_g_apce2_d
DEFINE g_apce2_d_mask_o   DYNAMIC ARRAY OF type_g_apce2_d #轉換遮罩前資料
DEFINE g_apce2_d_mask_n   DYNAMIC ARRAY OF type_g_apce2_d #轉換遮罩後資料
DEFINE g_apce3_d          DYNAMIC ARRAY OF type_g_apce3_d
DEFINE g_apce3_d_t        type_g_apce3_d
DEFINE g_apce3_d_o        type_g_apce3_d
DEFINE g_apce3_d_mask_o   DYNAMIC ARRAY OF type_g_apce3_d #轉換遮罩前資料
DEFINE g_apce3_d_mask_n   DYNAMIC ARRAY OF type_g_apce3_d #轉換遮罩後資料
DEFINE g_apce4_d          DYNAMIC ARRAY OF type_g_apce4_d
DEFINE g_apce4_d_t        type_g_apce4_d
DEFINE g_apce4_d_o        type_g_apce4_d
DEFINE g_apce4_d_mask_o   DYNAMIC ARRAY OF type_g_apce4_d #轉換遮罩前資料
DEFINE g_apce4_d_mask_n   DYNAMIC ARRAY OF type_g_apce4_d #轉換遮罩後資料
DEFINE g_apce5_d          DYNAMIC ARRAY OF type_g_apce5_d
DEFINE g_apce5_d_t        type_g_apce5_d
DEFINE g_apce5_d_o        type_g_apce5_d
DEFINE g_apce5_d_mask_o   DYNAMIC ARRAY OF type_g_apce5_d #轉換遮罩前資料
DEFINE g_apce5_d_mask_n   DYNAMIC ARRAY OF type_g_apce5_d #轉換遮罩後資料
DEFINE g_apce6_d          DYNAMIC ARRAY OF type_g_apce6_d
DEFINE g_apce6_d_t        type_g_apce6_d
DEFINE g_apce6_d_o        type_g_apce6_d
DEFINE g_apce6_d_mask_o   DYNAMIC ARRAY OF type_g_apce6_d #轉換遮罩前資料
DEFINE g_apce6_d_mask_n   DYNAMIC ARRAY OF type_g_apce6_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
 
{<section id="aapt823.main" >}
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
   LET g_fin_arg1 = 'D-FIN-3006'
   LET g_sql_ctrl = NULL      #151231-00010#1(S)
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #151231-00010#1(E) #161115-00046#2 mark   
   #161115-00046#2 --s add
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO g_apda_m.apdacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#63 mark
   #161115-00046#2 --e add
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
   CALL s_aap_create_multi_bill_perod_tmp()                 #新增多帳期FUNCTION用的TEMP TABLE  #151110
   CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)                      #160125-00005#6
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld      #160125-00005#6
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  #160125-00005#6
   
   #161229-00047#63 add ------
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#63 add end---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apdasite,'',apda003,'',apdald,'',apdadocno,'',apda001,apdadocdt,apda005, 
       '',apda023,apda014,apdastus,apdacomp,apda008,apda010,apda018,'',apda007,apda009,apda015,'',apda016, 
       apda017,apdaownid,'',apdaowndp,'',apdacrtid,'',apdacrtdp,'',apdacrtdt,apdamodid,'',apdamoddt, 
       apdacnfid,'',apdacnfdt,'','','','','','','','','','','','','','','','','','','',''", 
                      " FROM apda_t",
                      " WHERE apdaent= ? AND apdald=? AND apdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt823_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apdasite,t0.apda003,t0.apdald,t0.apdadocno,t0.apda001,t0.apdadocdt, 
       t0.apda005,t0.apda023,t0.apda014,t0.apdastus,t0.apdacomp,t0.apda008,t0.apda010,t0.apda018,t0.apda007, 
       t0.apda009,t0.apda015,t0.apda016,t0.apda017,t0.apdaownid,t0.apdaowndp,t0.apdacrtid,t0.apdacrtdp, 
       t0.apdacrtdt,t0.apdamodid,t0.apdamoddt,t0.apdacnfid,t0.apdacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM apda_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.apdaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apdaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apdacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apdacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apdamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apdacnfid  ",
 
               " WHERE t0.apdaent = " ||g_enterprise|| " AND t0.apdald = ? AND t0.apdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt823_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt823 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt823_init()   
 
      #進入選單 Menu (="N")
      CALL aapt823_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt823
      
   END IF 
   
   CLOSE aapt823_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt823.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt823_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str    STRING
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apdastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','3','4',","1")
   CALL g_idx_group.addAttribute("'2','5','6',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #單頭
   CALL cl_set_combo_scc_part('apda001','8507','85')   #85:多對象應付核銷單
   #帳款明細單身   
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '3'") CLIPPED 
   CALL cl_set_combo_scc_part('apce002','8506',l_str)
   CALL cl_set_combo_scc_part('apce0022','8506',l_str)
   CALL cl_set_combo_scc_part('apce0023','8506',l_str)
   #預設付款明細單身
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '2' AND gzcb002 <> '17' ") CLIPPED      
   CALL cl_set_combo_scc_part('apde002','8506',l_str)
   CALL cl_set_combo_scc_part('apde0022','8506',l_str)
   CALL cl_set_combo_scc_part('apde0023','8506',l_str)
   #150128-00005#9--(s)
   LET l_str = s_aap_get_acc_str('8310',"gzcb002 <> 'ZZ' ") CLIPPED      
   CALL cl_set_combo_scc_part('apde006','8310',l_str)
   CALL cl_set_combo_scc_part('apde0063','8310',l_str)
   CALL cl_set_combo_scc('apce044','6013')  #經營方式
   CALL cl_set_combo_scc('apde042','6013')  #經營方式
   #150128-00005#9--(e)
   #150128-00005#9-mark--
   #CALL cl_set_combo_scc('apde006','8310')
   #CALL cl_set_combo_scc('apde0063','8310')
   #150128-00005#9-mark-- 

   #160122-00001#5 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5 --add--end   
   #end add-point
   
   #初始化搜尋條件
   CALL aapt823_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt823.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt823_ui_dialog()
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
   DEFINE l_continue    LIKE type_t.chr1
   DEFINE l_chr         LIKE type_t.chr1       #狀態碼
   DEFINE l_glap001     LIKE glap_t.glap001    #傳票性質   
   DEFINE l_cn          LIKE type_t.num10 #151125-00006#2
   #160104-00007#3--(S)
   DEFINE la_param1  RECORD
             glaald  LIKE glaa_t.glaald,
             type	   LIKE type_t.chr10,
             wc      STRING
                 END RECORD
   DEFINE l_glapstus LIKE glap_t.glapstus
   DEFINE l_glapdocdt  LIKE glap_t.glapdocdt
   DEFINE l_glaa013   LIKE glaa_t.glaa013   
   #160104-00007#3--(E)
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
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
            CALL aapt823_insert()
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
         INITIALIZE g_apda_m.* TO NULL
         CALL g_apce_d.clear()
         CALL g_apce2_d.clear()
         CALL g_apce3_d.clear()
         CALL g_apce4_d.clear()
         CALL g_apce5_d.clear()
         CALL g_apce6_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt823_init()
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
               
               CALL aapt823_fetch('') # reload data
               LET l_ac = 1
               CALL aapt823_ui_detailshow() #Setting the current row 
         
               CALL aapt823_idx_chk()
               #NEXT FIELD apceseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apce_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','3','4',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3','4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apce003
                  LET g_action_choice="prog_apce003"
                  IF cl_auth_chk_act("prog_apce003") THEN
                     
                     #add-point:ON ACTION prog_apce003 name="menu.detail_show.page1_sub.prog_apce003"
                     CALL aapt823_qrystr('apce003')
                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apce024
                  LET g_action_choice="prog_apce024"
                  IF cl_auth_chk_act("prog_apce024") THEN
                     
                     #add-point:ON ACTION prog_apce024 name="menu.detail_show.page1_sub.prog_apce024"
                     CALL aapt823_qrystr('apce024')
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_apce2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2','5','6',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','5','6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page2_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apde003
                  LET g_action_choice="prog_apde003"
                  IF cl_auth_chk_act("prog_apde003") THEN
                     
                     #add-point:ON ACTION prog_apde003 name="menu.detail_show.page2_sub.prog_apde003"
                     CALL aapt823_qrystr('apde003')
                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apde014
                  LET g_action_choice="prog_apde014"
                  IF cl_auth_chk_act("prog_apde014") THEN
                     
                     #add-point:ON ACTION prog_apde014 name="menu.detail_show.page2_sub.prog_apde014"
                     CALL aapt823_qrystr('apde014')
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apce3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apce4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apce5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apce6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt823_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body6.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL aapt823_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body6.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
         
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt823_browser_fill("")
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
               CALL aapt823_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt823_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt823_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt823_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt823_set_act_visible()   
            CALL aapt823_set_act_no_visible()
            IF NOT (g_apda_m.apdald IS NULL
              OR g_apda_m.apdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                                  " apdald = '", g_apda_m.apdald, "' "
                                  ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
               #填到對應位置
               CALL aapt823_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apce_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apde_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt823_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apce_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apde_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt823_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt823_fetch("F")
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
               CALL aapt823_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt823_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt823_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt823_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt823_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt823_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt823_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt823_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt823_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt823_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt823_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_apce_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_apce2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_apce3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_apce4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_apce5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_apce6_d)
                  LET g_export_id[6]   = "s_detail6"
 
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
               NEXT FIELD apceseq
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
         ON ACTION aapi060
            LET g_action_choice="aapi060"
            IF cl_auth_chk_act("aapi060") THEN
               
               #add-point:ON ACTION aapi060 name="menu.aapi060"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt823_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#2--s
               CALL aapt823_immediately_conf()
               CALL aapt823_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
               WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                 AND apdaent = g_enterprise #170123-00010#1 add
               IF l_cn > 0 THEN
                  CALL aapt823_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt823_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#2--s
               CALL aapt823_immediately_conf()
               CALL aapt823_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
               WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                 AND apdaent = g_enterprise #170123-00010#1 add
               IF l_cn > 0 THEN
                  CALL aapt823_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #產生分錄底稿
               #141202-00061#15--(S)
               IF NOT cl_null(g_apda_m.apdadocno) AND g_apda_m.apdastus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
                       RETURNING g_sub_success
                  IF g_sub_success THEN 
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #141202-00061#15--(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp420
            LET g_action_choice="open_aapp420"
            IF cl_auth_chk_act("open_aapp420") THEN
               
               #add-point:ON ACTION open_aapp420 name="menu.open_aapp420"
               #科目及核算項預覽
               #未確認不可拋傳票
               IF g_apda_m.apdastus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00255'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF               
               #已產生傳票,不可執行
               CALL la_param.param.clear()
               IF cl_null(g_apda_m.apda014) THEN
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip               
                 #CALL cl_get_doc_para(g_enterprise,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
                  CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
                  IF l_chr = 'Y' THEN
                     #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
                     LET g_gl_slip = ''
                    #CALL cl_get_doc_para(g_enterprise,g_apda_m.apdacomp,g_ap_slip,'D-FIN-2002') RETURNING g_gl_slip
                     CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-2002') RETURNING g_gl_slip
                     IF cl_null(g_gl_slip) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00219'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                     LET la_param.prog = 'aapp420'
                     IF NOT cl_null(g_gl_slip) THEN 
                        LET la_param.param[1] = g_apda_m.apdald      #帳套
                        LET la_param.param[2] = g_apda_m.apdadocno   #單號
                        LET la_param.param[3] = g_gl_slip            #總帳單別
                        LET la_param.param[4] = g_apda_m.apdadocdt   #日期
                        LET la_param.param[5] = g_apda_m.apdasite    #帳務中心
                     END IF
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                     SELECT apda014 INTO g_apda_m.apda014
                       FROM apda_t
                      WHERE apdaent = g_enterprise
                        AND apdald  = g_apda_m.apdald AND apdadocno = g_apda_m.apdadocno
                     DISPLAY BY NAME g_apda_m.apda014
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00054'
                     LET g_errparam.extend = g_ap_slip
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
               ELSE
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001
                    FROM glap_t
                   WHERE glapent = g_enterprise AND glapld = g_apda_m.apdald
                     AND glapdocno = g_apda_m.apda014
                  IF NOT l_glap001 MATCHES '[1235]' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00029'
                     LET g_errparam.extend = g_apda_m.apdadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  ELSE
                     CASE
                         WHEN '1'  LET la_param.prog = 'aglt310'
                         WHEN '2'  LET la_param.prog = 'aglt320'
                         WHEN '3'  LET la_param.prog = 'aglt330'
                         WHEN '5'  LET la_param.prog = 'aglt350'
                     END CASE
                     LET la_param.param[1] = g_apda_m.apdald
                     LET la_param.param[2] = g_apda_m.apda014
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                  END IF
               END IF
               CALL aapt823_ui_headershow()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt300_14
            LET g_action_choice="open_aapt300_14"
            IF cl_auth_chk_act("open_aapt300_14") THEN
               
               #add-point:ON ACTION open_aapt300_14 name="menu.open_aapt300_14"
               #傳票預覽
               #141202-00061-15--(S)
               IF g_glaa.glaa121 = 'Y' THEN               
                  CALL s_pre_voucher('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt)
               ELSE
               #141202-00061-15--(E)
                  CALL aapt300_14(g_apda_m.apdald,g_apda_m.apdadocno,'1')
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt823_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt823_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#2--s
               CALL aapt823_immediately_conf()
               CALL aapt823_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
               WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                 AND apdaent = g_enterprise #170123-00010#1 add
               IF l_cn > 0 THEN
                  CALL aapt823_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt823_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#2--s
               CALL aapt823_immediately_conf()
               CALL aapt823_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
               WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                 AND apdaent = g_enterprise #170123-00010#1 add
               IF l_cn > 0 THEN
                  CALL aapt823_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt823_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION copy_memo
            LET g_action_choice="copy_memo"
            IF cl_auth_chk_act("copy_memo") THEN
               
               #add-point:ON ACTION copy_memo name="menu.copy_memo"
               #160225-00001#1--(S)
               CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_slip
               CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
               CALL s_fin_date_close_chk('',g_apda_m.apdacomp,'AAP',g_apda_m.apdadocdt) RETURNING g_sub_success
               IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
               ELSE
               #160225-00001#1--(E)
                  CALL aapt823_copy_memo()
                  CALL aapt823_b_fill()   
               END IF         #160225-00001#1
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp342
            LET g_action_choice="open_aapp342"
            IF cl_auth_chk_act("open_aapp342") THEN
               
               #add-point:ON ACTION open_aapp342 name="menu.open_aapp342"
                 #160104-00007#3--(S)
               SELECT glapstus,glapdocdt INTO l_glapstus,l_glapdocdt
                 FROM glap_t
                WHERE glapent = g_enterprise 
                  AND glapld = g_apda_m.apdald AND glapdocno = g_apda_m.apda014
               SELECT glaa013 INTO l_glaa013
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_apda_m.apdald    
               
               CASE                  
                  WHEN l_glapstus = 'Y' OR l_glapstus = 'S' OR cl_null(g_apda_m.apda014)
                     INITIALIZE g_errparam TO NULL
                     CASE
                        WHEN l_glapstus = 'Y' OR l_glapstus = 'S' 
                            LET g_errparam.code   = 'axr-00076'
                        WHEN cl_null(g_apda_m.apda014) 
                            LET g_errparam.code   = 'aap-00093'
                            LET g_errparam.extend = s_fin_get_colname('','apca038'),"=' '"
                     END CASE
                     LET g_errparam.popup = TRUE
                     CALL cl_err()              
                  WHEN l_glapdocdt <  l_glaa013  #傳票還原日期不可小於關帳日期
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                  OTHERWISE
                     LET la_param.prog = "aapp342" 
                     LET la_param.background = "Y"
                     LET la_param1.glaald = g_apda_m.apdald 
                     LET la_param1.type   = "aapt400"
                     LET la_param1.wc     = " glapdocno = '",g_apda_m.apda014,"'" 
                     LET la_param.param[1] = util.JSON.stringify( la_param1 )
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
                     LET g_apda_m.apda014 = ''
                     DISPLAY BY NAME g_apda_m.apda014
               END CASE
                     
               #160104-00007#3--(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt420_09
            LET g_action_choice="open_aapt420_09"
            IF cl_auth_chk_act("open_aapt420_09") THEN
               
               #add-point:ON ACTION open_aapt420_09 name="menu.open_aapt420_09"
               #未確認才有用
               LET g_apda_m.apdastus = NULL
               SELECT apdastus INTO g_apda_m.apdastus FROM apda_t
                WHERE apdaent = g_enterprise
                  AND apdald  = g_apda_m.apdald
                  AND apdadocno = g_apda_m.apdadocno
               IF NOT cl_null(g_apda_m.apdastus) AND (g_apda_m.apdastus <> 'Y' OR g_apda_m.apdastus <> 'X') THEN
                  #160225-00001#1--(S)
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_slip
                  CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
                  CALL s_fin_date_close_chk('',g_apda_m.apdacomp,'AAP',g_apda_m.apdadocdt) RETURNING g_sub_success
                  IF l_dfin0033 = "N" AND NOT g_sub_success THEN
                  ELSE
                  #160225-00001#1--(E)
                     CALL aapt823_open_aapt823_09()RETURNING g_sub_success,l_continue
                     CALL aapt823_show()
                  END IF      #160225-00001#1
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apda003
            LET g_action_choice="prog_apda003"
            IF cl_auth_chk_act("prog_apda003") THEN
               
               #add-point:ON ACTION prog_apda003 name="menu.prog_apda003"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apda_m.apda003)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apda014
            LET g_action_choice="prog_apda014"
            IF cl_auth_chk_act("prog_apda014") THEN
               
               #add-point:ON ACTION prog_apda014 name="menu.prog_apda014"
               CALL aapt823_qrystr('apda014')
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt823_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt823_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt823_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apda_m.apdadocdt)
 
 
 
         
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
 
{<section id="aapt823.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt823_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #161115-00046#2 add
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161115-00046#2 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdald")
   LET l_wc = l_wc," AND ",l_ld_str
   #161115-00046#2 --e add
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
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ",
                      " ",
                      " LEFT JOIN apce_t ON apceent = apdaent AND apdald = apceld AND apdadocno = apcedocno ", "  ",
                      #add-point:browser_fill段sql(apce_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno", "  ",
                      #add-point:browser_fill段sql(apde_t1) name="browser_fill.cnt.join.apde_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE apdaent = " ||g_enterprise|| " AND apceent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ", 
                      "  ",
                      "  ",
                      " WHERE apdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apda_t")
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
      INITIALIZE g_apda_m.* TO NULL
      CALL g_apce_d.clear()        
      CALL g_apce2_d.clear() 
      CALL g_apce3_d.clear() 
      CALL g_apce4_d.clear() 
      CALL g_apce5_d.clear() 
      CALL g_apce6_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apdadocno,t0.apdald Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald ",
                  " FROM apda_t t0",
                  "  ",
                  "  LEFT JOIN apce_t ON apceent = apdaent AND apdald = apceld AND apdadocno = apcedocno ", "  ", 
                  #add-point:browser_fill段sql(apce_t1) name="browser_fill.join.apce_t1"
                  
                  #end add-point
                  "  LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno", "  ", 
                  #add-point:browser_fill段sql(apde_t1) name="browser_fill.join.apde_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.apdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald ",
                  " FROM apda_t t0",
                  "  ",
                  
                  " WHERE t0.apdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161115-00046#2 --s mark
   #IF NOT cl_null(g_wc_cs_ld) THEN     #160125-00005#6--(S)
   #   LET l_wc = l_wc , " AND apdald IN ",g_wc_cs_ld
   #END IF                              #160125-00005#6--(E)
   #161115-00046#2 --e mark
   #end add-point
   LET g_sql = g_sql, " ORDER BY apdald,apdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apdadocno,g_browser[g_cnt].b_apdald 
 
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
         CALL aapt823_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_apdald) THEN
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
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt823_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apda_m.apdald = g_browser[g_current_idx].b_apdald   
   LET g_apda_m.apdadocno = g_browser[g_current_idx].b_apdadocno   
 
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
   CALL aapt823_apda_t_mask()
   CALL aapt823_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt823.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt823_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt823_ui_browser_refresh()
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
      IF g_browser[l_i].b_apdald = g_apda_m.apdald 
         AND g_browser[l_i].b_apdadocno = g_apda_m.apdadocno 
 
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
 
{<section id="aapt823.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt823_construct()
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
   DEFINE l_apce002   LIKE apce_t.apce002
   DEFINE l_apde002   LIKE apde_t.apde002
   DEFINE l_ld_str    STRING #161115-00046#2 add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apda_m.* TO NULL
   CALL g_apce_d.clear()        
   CALL g_apce2_d.clear() 
   CALL g_apce3_d.clear() 
   CALL g_apce4_d.clear() 
   CALL g_apce5_d.clear() 
   CALL g_apce6_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apdasite,apda003,apdald,apdadocno,apda001,apdadocdt,apda005,apda023, 
          apda014,apdastus,apda008,apda010,apda018,apda007,apda009,apda015,apda016,apda017,apdaownid, 
          apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apdacrtdt>>----
         AFTER FIELD apdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apdamoddt>>----
         AFTER FIELD apdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdacnfdt>>----
         AFTER FIELD apdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="construct.c.apdasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#8   mark
            CALL q_ooef001_46()   #161006-00005#8   add                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdasite  #顯示到畫面上
            NEXT FIELD apdasite                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="construct.b.apdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="construct.a.apdasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161115-00046#2 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="construct.b.apda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="construct.a.apda003"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="construct.c.apda003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apda003      #顯示到畫面上
            NEXT FIELD apda003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="construct.b.apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="construct.a.apdald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="construct.c.apdald"
            #帳別
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161115-00046#2 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
           #LET g_qryparam.arg2 = g_grup #161115-00046#2 mark
            LET g_qryparam.arg2 = g_dept #161115-00046#2 add
            #161115-00046#2 --s add
            #IF NOT cl_null(g_wc_cs_ld) THEN        #160125-00005#6
            #   LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            #END IF                                 #160125-00005#6
            #161115-00046#2 --e add
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161115-00046#2 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO apdald
            NEXT FIELD apdald
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="construct.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="construct.a.apdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="construct.c.apdadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apda001 = '85' "
            #161115-00046#2 --s add
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161115-00046#2 --e add
            CALL q_apdadocno()
            DISPLAY g_qryparam.return1 TO apdadocno
            NEXT FIELD apdadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda001
            #add-point:BEFORE FIELD apda001 name="construct.b.apda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda001
            
            #add-point:AFTER FIELD apda001 name="construct.a.apda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda001
            #add-point:ON ACTION controlp INFIELD apda001 name="construct.c.apda001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="construct.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="construct.a.apdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="construct.c.apdadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda005
            #add-point:BEFORE FIELD apda005 name="construct.b.apda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda005
            
            #add-point:AFTER FIELD apda005 name="construct.a.apda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda005
            #add-point:ON ACTION controlp INFIELD apda005 name="construct.c.apda005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = apcaent ",
                                      "            AND pmaa001 = apca005 )"
            END IF
            #151231-00010#1(E)            
            CALL q_apca005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda005  #顯示到畫面上
            NEXT FIELD apda005 
            #END add-point
 
 
         #Ctrlp:construct.c.apda023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda023
            #add-point:ON ACTION controlp INFIELD apda023 name="construct.c.apda023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apea001 = '80' "
            #161115-00046#2 --s add
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = apeaent ",
                                                       "                AND pmaa001 = apea005 )"
            END IF
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apeald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161115-00046#2 --e add
            CALL q_apeadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda023  #顯示到畫面上
            NEXT FIELD apda023                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda023
            #add-point:BEFORE FIELD apda023 name="construct.b.apda023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda023
            
            #add-point:AFTER FIELD apda023 name="construct.a.apda023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda014
            #add-point:BEFORE FIELD apda014 name="construct.b.apda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda014
            
            #add-point:AFTER FIELD apda014 name="construct.a.apda014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda014
            #add-point:ON ACTION controlp INFIELD apda014 name="construct.c.apda014"
            #拋轉傳票號碼
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apda014()
            DISPLAY g_qryparam.return1 TO apda014  #顯示到畫面上
            NEXT FIELD apda014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdastus
            #add-point:BEFORE FIELD apdastus name="construct.b.apdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdastus
            
            #add-point:AFTER FIELD apdastus name="construct.a.apdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdastus
            #add-point:ON ACTION controlp INFIELD apdastus name="construct.c.apdastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda008
            #add-point:BEFORE FIELD apda008 name="construct.b.apda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda008
            
            #add-point:AFTER FIELD apda008 name="construct.a.apda008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda008
            #add-point:ON ACTION controlp INFIELD apda008 name="construct.c.apda008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda010
            #add-point:BEFORE FIELD apda010 name="construct.b.apda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda010
            
            #add-point:AFTER FIELD apda010 name="construct.a.apda010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda010
            #add-point:ON ACTION controlp INFIELD apda010 name="construct.c.apda010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018
            #add-point:BEFORE FIELD apda018 name="construct.b.apda018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="construct.a.apda018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="construct.c.apda018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda018  #顯示到畫面上
            NEXT FIELD apda018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda007
            #add-point:BEFORE FIELD apda007 name="construct.b.apda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda007
            
            #add-point:AFTER FIELD apda007 name="construct.a.apda007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda007
            #add-point:ON ACTION controlp INFIELD apda007 name="construct.c.apda007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda009
            #add-point:BEFORE FIELD apda009 name="construct.b.apda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda009
            
            #add-point:AFTER FIELD apda009 name="construct.a.apda009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda009
            #add-point:ON ACTION controlp INFIELD apda009 name="construct.c.apda009"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apea009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda009      #顯示到畫面上
            NEXT FIELD apda009 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda015
            #add-point:BEFORE FIELD apda015 name="construct.b.apda015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda015
            
            #add-point:AFTER FIELD apda015 name="construct.a.apda015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda015
            #add-point:ON ACTION controlp INFIELD apda015 name="construct.c.apda015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3115"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda015  #顯示到畫面上
            NEXT FIELD apda015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda016
            #add-point:BEFORE FIELD apda016 name="construct.b.apda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda016
            
            #add-point:AFTER FIELD apda016 name="construct.a.apda016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda016
            #add-point:ON ACTION controlp INFIELD apda016 name="construct.c.apda016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda017
            #add-point:BEFORE FIELD apda017 name="construct.b.apda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda017
            
            #add-point:AFTER FIELD apda017 name="construct.a.apda017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda017
            #add-point:ON ACTION controlp INFIELD apda017 name="construct.c.apda017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdaownid
            #add-point:ON ACTION controlp INFIELD apdaownid name="construct.c.apdaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdaownid  #顯示到畫面上
            NEXT FIELD apdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdaownid
            #add-point:BEFORE FIELD apdaownid name="construct.b.apdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdaownid
            
            #add-point:AFTER FIELD apdaownid name="construct.a.apdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdaowndp
            #add-point:ON ACTION controlp INFIELD apdaowndp name="construct.c.apdaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdaowndp  #顯示到畫面上
            NEXT FIELD apdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdaowndp
            #add-point:BEFORE FIELD apdaowndp name="construct.b.apdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdaowndp
            
            #add-point:AFTER FIELD apdaowndp name="construct.a.apdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacrtid
            #add-point:ON ACTION controlp INFIELD apdacrtid name="construct.c.apdacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacrtid  #顯示到畫面上
            NEXT FIELD apdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtid
            #add-point:BEFORE FIELD apdacrtid name="construct.b.apdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacrtid
            
            #add-point:AFTER FIELD apdacrtid name="construct.a.apdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacrtdp
            #add-point:ON ACTION controlp INFIELD apdacrtdp name="construct.c.apdacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacrtdp  #顯示到畫面上
            NEXT FIELD apdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtdp
            #add-point:BEFORE FIELD apdacrtdp name="construct.b.apdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacrtdp
            
            #add-point:AFTER FIELD apdacrtdp name="construct.a.apdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtdt
            #add-point:BEFORE FIELD apdacrtdt name="construct.b.apdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdamodid
            #add-point:ON ACTION controlp INFIELD apdamodid name="construct.c.apdamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdamodid  #顯示到畫面上
            NEXT FIELD apdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdamodid
            #add-point:BEFORE FIELD apdamodid name="construct.b.apdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdamodid
            
            #add-point:AFTER FIELD apdamodid name="construct.a.apdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdamoddt
            #add-point:BEFORE FIELD apdamoddt name="construct.b.apdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacnfid
            #add-point:ON ACTION controlp INFIELD apdacnfid name="construct.c.apdacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacnfid  #顯示到畫面上
            NEXT FIELD apdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfid
            #add-point:BEFORE FIELD apdacnfid name="construct.b.apdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacnfid
            
            #add-point:AFTER FIELD apdacnfid name="construct.a.apdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfdt
            #add-point:BEFORE FIELD apdacnfdt name="construct.b.apdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apceseq,apce002,apceorga,apce003,apce004,apce005,apce061,apce038,l_apca057, 
          apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010,apce031,apce049,apce017, 
          apce017_desc,apce018,apce018_desc,apce019,apce019_desc,apce020,apce020_desc,apce022,apce022_desc, 
          apce023,apce023_desc,apce035,apce035_desc,apce036,apce036_desc,apce044,apce044_desc,apce045, 
          apce045_desc,apce046,apce046_desc,apce121,apce129,apce131,apce139
           FROM s_detail1[1].apceseq,s_detail1[1].apce002,s_detail1[1].apceorga,s_detail1[1].apce003, 
               s_detail1[1].apce004,s_detail1[1].apce005,s_detail1[1].apce061,s_detail1[1].apce038,s_detail1[1].l_apca057, 
               s_detail1[1].apce048,s_detail1[1].apce024,s_detail1[1].apce100,s_detail1[1].apce109,s_detail1[1].apce101, 
               s_detail1[1].apce119,s_detail1[1].apce015,s_detail1[1].apce016,s_detail1[1].apce010,s_detail1[1].apce031, 
               s_detail1[1].apce049,s_detail3[1].apce017,s_detail3[1].apce017_desc,s_detail3[1].apce018, 
               s_detail3[1].apce018_desc,s_detail3[1].apce019,s_detail3[1].apce019_desc,s_detail3[1].apce020, 
               s_detail3[1].apce020_desc,s_detail3[1].apce022,s_detail3[1].apce022_desc,s_detail3[1].apce023, 
               s_detail3[1].apce023_desc,s_detail3[1].apce035,s_detail3[1].apce035_desc,s_detail3[1].apce036, 
               s_detail3[1].apce036_desc,s_detail3[1].apce044,s_detail3[1].apce044_desc,s_detail3[1].apce045, 
               s_detail3[1].apce045_desc,s_detail3[1].apce046,s_detail3[1].apce046_desc,s_detail4[1].apce121, 
               s_detail4[1].apce129,s_detail4[1].apce131,s_detail4[1].apce139
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceseq
            #add-point:BEFORE FIELD apceseq name="construct.b.page1.apceseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceseq
            
            #add-point:AFTER FIELD apceseq name="construct.a.page1.apceseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apceseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceseq
            #add-point:ON ACTION controlp INFIELD apceseq name="construct.c.page1.apceseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce002
            #add-point:BEFORE FIELD apce002 name="construct.b.page1.apce002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce002
            
            #add-point:AFTER FIELD apce002 name="construct.a.page1.apce002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce002
            #add-point:ON ACTION controlp INFIELD apce002 name="construct.c.page1.apce002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apceorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceorga
            #add-point:ON ACTION controlp INFIELD apceorga name="construct.c.page1.apceorga"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,
   			                          " AND ooef201 = 'Y'"   #161006-00005#8   add
   			END IF         #160125-00005#6
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apceorga  #顯示到畫面上
            NEXT FIELD apceorga                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceorga
            #add-point:BEFORE FIELD apceorga name="construct.b.page1.apceorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceorga
            
            #add-point:AFTER FIELD apceorga name="construct.a.page1.apceorga"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce003
            #add-point:BEFORE FIELD apce003 name="construct.b.page1.apce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce003
            
            #add-point:AFTER FIELD apce003 name="construct.a.page1.apce003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce003
            #add-point:ON ACTION controlp INFIELD apce003 name="construct.c.page1.apce003"
            LET l_apce002 = GET_FLDBUF(apce002)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CASE l_apce002[1,1]
               WHEN '4'
                  #151231-00010#1(S)
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                            "          WHERE pmaaent = ",g_enterprise,
                                            "            AND ",g_sql_ctrl,
                                            "            AND pmaaent = apcaent ",
                                            "            AND pmaa001 = apca057 )"
                  END IF
                  #151231-00010#1(E) 
                  #161115-00046#2 --s add
                  #查詢依帳套權限管理
                  CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apcald")
                  LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str    
                  #161115-00046#2 --e add                  
                  CALL q_apcadocno_3()                  
               WHEN '3' 
                  #161115-00046#2 --s add               
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                         "          WHERE pmaaent = ",g_enterprise,
                                         "            AND ",g_sql_ctrl,
                                         "            AND pmaaent = xrcaent ",
                                         "            AND pmaa001 = xrca005 )"
                  END IF
                  #查詢依帳套權限管理
                  CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrcald")
                  LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str  
                  #161115-00046#2 --e add                  
                  CALL q_xrcadocno_8()
               OTHERWISE
                  #151231-00010#1(S)
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                            "          WHERE pmaaent = ",g_enterprise,
                                            "            AND ",g_sql_ctrl,
                                            "            AND pmaaent = apcaent ",
                                            "            AND pmaa001 = apca057 )"
                  END IF
                  #151231-00010#1(E) 
                  #161115-00046#2 --s add
                  #查詢依帳套權限管理
                  CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apcald")
                  LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str    
                  #161115-00046#2 --e add                   
                  CALL q_apcadocno_3()
            END CASE                  
            DISPLAY g_qryparam.return1 TO apce003
            NEXT FIELD apce003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce004
            #add-point:BEFORE FIELD apce004 name="construct.b.page1.apce004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce004
            
            #add-point:AFTER FIELD apce004 name="construct.a.page1.apce004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce004
            #add-point:ON ACTION controlp INFIELD apce004 name="construct.c.page1.apce004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce005
            #add-point:BEFORE FIELD apce005 name="construct.b.page1.apce005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce005
            
            #add-point:AFTER FIELD apce005 name="construct.a.page1.apce005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce005
            #add-point:ON ACTION controlp INFIELD apce005 name="construct.c.page1.apce005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce061
            #add-point:BEFORE FIELD apce061 name="construct.b.page1.apce061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce061
            
            #add-point:AFTER FIELD apce061 name="construct.a.page1.apce061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce061
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce061
            #add-point:ON ACTION controlp INFIELD apce061 name="construct.c.page1.apce061"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apce061  #顯示到畫面上
            NEXT FIELD apce061
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce038
            #add-point:BEFORE FIELD apce038 name="construct.b.page1.apce038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce038
            
            #add-point:AFTER FIELD apce038 name="construct.a.page1.apce038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce038
            #add-point:ON ACTION controlp INFIELD apce038 name="construct.c.page1.apce038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apce038  #顯示到畫面上
            NEXT FIELD apce038
            #END add-point
 
 
         #Ctrlp:construct.c.page1.l_apca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apca057
            #add-point:ON ACTION controlp INFIELD l_apca057 name="construct.c.page1.l_apca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_apca057  #顯示到畫面上
            NEXT FIELD l_apca057                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apca057
            #add-point:BEFORE FIELD l_apca057 name="construct.b.page1.l_apca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apca057
            
            #add-point:AFTER FIELD l_apca057 name="construct.a.page1.l_apca057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce048
            #add-point:BEFORE FIELD apce048 name="construct.b.page1.apce048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce048
            
            #add-point:AFTER FIELD apce048 name="construct.a.page1.apce048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce048
            #add-point:ON ACTION controlp INFIELD apce048 name="construct.c.page1.apce048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce024
            #add-point:BEFORE FIELD apce024 name="construct.b.page1.apce024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce024
            
            #add-point:AFTER FIELD apce024 name="construct.a.page1.apce024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce024
            #add-point:ON ACTION controlp INFIELD apce024 name="construct.c.page1.apce024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apce100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce100
            #add-point:ON ACTION controlp INFIELD apce100 name="construct.c.page1.apce100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apce100  #顯示到畫面上
            NEXT FIELD apce100                     #返回原欄位
   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce100
            #add-point:BEFORE FIELD apce100 name="construct.b.page1.apce100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce100
            
            #add-point:AFTER FIELD apce100 name="construct.a.page1.apce100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce109
            #add-point:BEFORE FIELD apce109 name="construct.b.page1.apce109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce109
            
            #add-point:AFTER FIELD apce109 name="construct.a.page1.apce109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce109
            #add-point:ON ACTION controlp INFIELD apce109 name="construct.c.page1.apce109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce101
            #add-point:BEFORE FIELD apce101 name="construct.b.page1.apce101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce101
            
            #add-point:AFTER FIELD apce101 name="construct.a.page1.apce101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce101
            #add-point:ON ACTION controlp INFIELD apce101 name="construct.c.page1.apce101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce119
            #add-point:BEFORE FIELD apce119 name="construct.b.page1.apce119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce119
            
            #add-point:AFTER FIELD apce119 name="construct.a.page1.apce119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce119
            #add-point:ON ACTION controlp INFIELD apce119 name="construct.c.page1.apce119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce015
            #add-point:BEFORE FIELD apce015 name="construct.b.page1.apce015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce015
            
            #add-point:AFTER FIELD apce015 name="construct.a.page1.apce015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce015
            #add-point:ON ACTION controlp INFIELD apce015 name="construct.c.page1.apce015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016
            #add-point:BEFORE FIELD apce016 name="construct.b.page1.apce016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016
            
            #add-point:AFTER FIELD apce016 name="construct.a.page1.apce016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016
            #add-point:ON ACTION controlp INFIELD apce016 name="construct.c.page1.apce016"
            #科目編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161115-00046#2 --s add
			   SELECT ooef017 INTO g_apda_m.apdacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_apda_m.apdald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_apda_m.apdacomp
               AND glaa014 = 'Y' 
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_apda_m.apdald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
			   #161115-00046#2 --e add
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apce016   #顯示到畫面上
            NEXT FIELD apce016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce010
            #add-point:BEFORE FIELD apce010 name="construct.b.page1.apce010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce010
            
            #add-point:AFTER FIELD apce010 name="construct.a.page1.apce010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce010
            #add-point:ON ACTION controlp INFIELD apce010 name="construct.c.page1.apce010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3005"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apce010  #顯示到畫面上
            NEXT FIELD apce010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce031
            #add-point:BEFORE FIELD apce031 name="construct.b.page1.apce031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce031
            
            #add-point:AFTER FIELD apce031 name="construct.a.page1.apce031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce031
            #add-point:ON ACTION controlp INFIELD apce031 name="construct.c.page1.apce031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce049
            #add-point:BEFORE FIELD apce049 name="construct.b.page1.apce049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce049
            
            #add-point:AFTER FIELD apce049 name="construct.a.page1.apce049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce049
            #add-point:ON ACTION controlp INFIELD apce049 name="construct.c.page1.apce049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017
            #add-point:BEFORE FIELD apce017 name="construct.b.page3.apce017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017
            
            #add-point:AFTER FIELD apce017 name="construct.a.page3.apce017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017
            #add-point:ON ACTION controlp INFIELD apce017 name="construct.c.page3.apce017"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017_desc
            #add-point:BEFORE FIELD apce017_desc name="construct.b.page3.apce017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017_desc
            
            #add-point:AFTER FIELD apce017_desc name="construct.a.page3.apce017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017_desc
            #add-point:ON ACTION controlp INFIELD apce017_desc name="construct.c.page3.apce017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()            
            DISPLAY g_qryparam.return1 TO apce017
            DISPLAY g_qryparam.return1 TO apce017_desc     
            NEXT FIELD apce017_desc                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018
            #add-point:BEFORE FIELD apce018 name="construct.b.page3.apce018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018
            
            #add-point:AFTER FIELD apce018 name="construct.a.page3.apce018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018
            #add-point:ON ACTION controlp INFIELD apce018 name="construct.c.page3.apce018"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018_desc
            #add-point:BEFORE FIELD apce018_desc name="construct.b.page3.apce018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018_desc
            
            #add-point:AFTER FIELD apce018_desc name="construct.a.page3.apce018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018_desc
            #add-point:ON ACTION controlp INFIELD apce018_desc name="construct.c.page3.apce018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apce018
            DISPLAY g_qryparam.return1 TO apce018_desc
            NEXT FIELD apce018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019
            #add-point:BEFORE FIELD apce019 name="construct.b.page3.apce019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019
            
            #add-point:AFTER FIELD apce019 name="construct.a.page3.apce019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019
            #add-point:ON ACTION controlp INFIELD apce019 name="construct.c.page3.apce019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019_desc
            #add-point:BEFORE FIELD apce019_desc name="construct.b.page3.apce019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019_desc
            
            #add-point:AFTER FIELD apce019_desc name="construct.a.page3.apce019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019_desc
            #add-point:ON ACTION controlp INFIELD apce019_desc name="construct.c.page3.apce019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_5()
            DISPLAY g_qryparam.return1 TO apce019
            DISPLAY g_qryparam.return1 TO apce019_desc
            NEXT FIELD apce019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020
            #add-point:BEFORE FIELD apce020 name="construct.b.page3.apce020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020
            
            #add-point:AFTER FIELD apce020 name="construct.a.page3.apce020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020
            #add-point:ON ACTION controlp INFIELD apce020 name="construct.c.page3.apce020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020_desc
            #add-point:BEFORE FIELD apce020_desc name="construct.b.page3.apce020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020_desc
            
            #add-point:AFTER FIELD apce020_desc name="construct.a.page3.apce020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020_desc
            #add-point:ON ACTION controlp INFIELD apce020_desc name="construct.c.page3.apce020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO apce020
            DISPLAY g_qryparam.return1 TO apce020_desc
            NEXT FIELD apce020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022
            #add-point:BEFORE FIELD apce022 name="construct.b.page3.apce022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022
            
            #add-point:AFTER FIELD apce022 name="construct.a.page3.apce022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022
            #add-point:ON ACTION controlp INFIELD apce022 name="construct.c.page3.apce022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022_desc
            #add-point:BEFORE FIELD apce022_desc name="construct.b.page3.apce022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022_desc
            
            #add-point:AFTER FIELD apce022_desc name="construct.a.page3.apce022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022_desc
            #add-point:ON ACTION controlp INFIELD apce022_desc name="construct.c.page3.apce022_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO apce022
            DISPLAY g_qryparam.return1 TO apce022_desc
            NEXT FIELD apce022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023
            #add-point:BEFORE FIELD apce023 name="construct.b.page3.apce023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023
            
            #add-point:AFTER FIELD apce023 name="construct.a.page3.apce023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023
            #add-point:ON ACTION controlp INFIELD apce023 name="construct.c.page3.apce023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023_desc
            #add-point:BEFORE FIELD apce023_desc name="construct.b.page3.apce023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023_desc
            
            #add-point:AFTER FIELD apce023_desc name="construct.a.page3.apce023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023_desc
            #add-point:ON ACTION controlp INFIELD apce023_desc name="construct.c.page3.apce023_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO apce023
            DISPLAY g_qryparam.return1 TO apce023_desc
            NEXT FIELD apce023_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035
            #add-point:BEFORE FIELD apce035 name="construct.b.page3.apce035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035
            
            #add-point:AFTER FIELD apce035 name="construct.a.page3.apce035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035
            #add-point:ON ACTION controlp INFIELD apce035 name="construct.c.page3.apce035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035_desc
            #add-point:BEFORE FIELD apce035_desc name="construct.b.page3.apce035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035_desc
            
            #add-point:AFTER FIELD apce035_desc name="construct.a.page3.apce035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035_desc
            #add-point:ON ACTION controlp INFIELD apce035_desc name="construct.c.page3.apce035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO apce035
            DISPLAY g_qryparam.return1 TO apce035_desc
            NEXT FIELD apce035_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036
            #add-point:BEFORE FIELD apce036 name="construct.b.page3.apce036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036
            
            #add-point:AFTER FIELD apce036 name="construct.a.page3.apce036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036
            #add-point:ON ACTION controlp INFIELD apce036 name="construct.c.page3.apce036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036_desc
            #add-point:BEFORE FIELD apce036_desc name="construct.b.page3.apce036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036_desc
            
            #add-point:AFTER FIELD apce036_desc name="construct.a.page3.apce036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036_desc
            #add-point:ON ACTION controlp INFIELD apce036_desc name="construct.c.page3.apce036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO apce036
            DISPLAY g_qryparam.return1 TO apce036_desc
            NEXT FIELD apce036_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044
            #add-point:BEFORE FIELD apce044 name="construct.b.page3.apce044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044
            
            #add-point:AFTER FIELD apce044 name="construct.a.page3.apce044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044
            #add-point:ON ACTION controlp INFIELD apce044 name="construct.c.page3.apce044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044_desc
            #add-point:BEFORE FIELD apce044_desc name="construct.b.page3.apce044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044_desc
            
            #add-point:AFTER FIELD apce044_desc name="construct.a.page3.apce044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044_desc
            #add-point:ON ACTION controlp INFIELD apce044_desc name="construct.c.page3.apce044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045
            #add-point:BEFORE FIELD apce045 name="construct.b.page3.apce045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045
            
            #add-point:AFTER FIELD apce045 name="construct.a.page3.apce045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045
            #add-point:ON ACTION controlp INFIELD apce045 name="construct.c.page3.apce045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045_desc
            #add-point:BEFORE FIELD apce045_desc name="construct.b.page3.apce045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045_desc
            
            #add-point:AFTER FIELD apce045_desc name="construct.a.page3.apce045_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045_desc
            #add-point:ON ACTION controlp INFIELD apce045_desc name="construct.c.page3.apce045_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO apce045
            DISPLAY g_qryparam.return1 TO apce045_desc
            NEXT FIELD apce045_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046
            #add-point:BEFORE FIELD apce046 name="construct.b.page3.apce046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046
            
            #add-point:AFTER FIELD apce046 name="construct.a.page3.apce046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046
            #add-point:ON ACTION controlp INFIELD apce046 name="construct.c.page3.apce046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046_desc
            #add-point:BEFORE FIELD apce046_desc name="construct.b.page3.apce046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046_desc
            
            #add-point:AFTER FIELD apce046_desc name="construct.a.page3.apce046_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apce046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046_desc
            #add-point:ON ACTION controlp INFIELD apce046_desc name="construct.c.page3.apce046_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO apce046
            DISPLAY g_qryparam.return1 TO apce046_desc
            NEXT FIELD apce046_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce121
            #add-point:BEFORE FIELD apce121 name="construct.b.page4.apce121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce121
            
            #add-point:AFTER FIELD apce121 name="construct.a.page4.apce121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.apce121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce121
            #add-point:ON ACTION controlp INFIELD apce121 name="construct.c.page4.apce121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce129
            #add-point:BEFORE FIELD apce129 name="construct.b.page4.apce129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce129
            
            #add-point:AFTER FIELD apce129 name="construct.a.page4.apce129"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.apce129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce129
            #add-point:ON ACTION controlp INFIELD apce129 name="construct.c.page4.apce129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce131
            #add-point:BEFORE FIELD apce131 name="construct.b.page4.apce131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce131
            
            #add-point:AFTER FIELD apce131 name="construct.a.page4.apce131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.apce131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce131
            #add-point:ON ACTION controlp INFIELD apce131 name="construct.c.page4.apce131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce139
            #add-point:BEFORE FIELD apce139 name="construct.b.page4.apce139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce139
            
            #add-point:AFTER FIELD apce139 name="construct.a.page4.apce139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.apce139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce139
            #add-point:ON ACTION controlp INFIELD apce139 name="construct.c.page4.apce139"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apdeseq,apdeorga,apde002,apde006,apde003,apde008,lc_apde008,apde021, 
          apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016,apde010,apde009, 
          apde039,apde040,apde041,apde011,apde012,apde046,apde038,apde038_desc,apde017,apde017_desc, 
          apde018,apde018_desc,apde019,apde019_desc,apde020,apde020_desc,apde022,apde022_desc,apde023, 
          apde023_desc,apde035,apde035_desc,apde036,apde036_desc,apde042,apde042_desc,apde043,apde043_desc, 
          apde044,apde044_desc,apde121,apde129,apde131,apde139
           FROM s_detail2[1].apdeseq,s_detail2[1].apdeorga,s_detail2[1].apde002,s_detail2[1].apde006, 
               s_detail2[1].apde003,s_detail2[1].apde008,s_detail2[1].lc_apde008,s_detail2[1].apde021, 
               s_detail2[1].apde024,s_detail2[1].apde100,s_detail2[1].apde109,s_detail2[1].apde101,s_detail2[1].apde119, 
               s_detail2[1].apde032,s_detail2[1].apde013,s_detail2[1].apde014,s_detail2[1].apde015,s_detail2[1].apde016, 
               s_detail2[1].apde010,s_detail2[1].apde009,s_detail2[1].apde039,s_detail2[1].apde040,s_detail2[1].apde041, 
               s_detail2[1].apde011,s_detail2[1].apde012,s_detail2[1].apde046,s_detail5[1].apde038,s_detail5[1].apde038_desc, 
               s_detail5[1].apde017,s_detail5[1].apde017_desc,s_detail5[1].apde018,s_detail5[1].apde018_desc, 
               s_detail5[1].apde019,s_detail5[1].apde019_desc,s_detail5[1].apde020,s_detail5[1].apde020_desc, 
               s_detail5[1].apde022,s_detail5[1].apde022_desc,s_detail5[1].apde023,s_detail5[1].apde023_desc, 
               s_detail5[1].apde035,s_detail5[1].apde035_desc,s_detail5[1].apde036,s_detail5[1].apde036_desc, 
               s_detail5[1].apde042,s_detail5[1].apde042_desc,s_detail5[1].apde043,s_detail5[1].apde043_desc, 
               s_detail5[1].apde044,s_detail5[1].apde044_desc,s_detail6[1].apde121,s_detail6[1].apde129, 
               s_detail6[1].apde131,s_detail6[1].apde139
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeseq
            #add-point:BEFORE FIELD apdeseq name="construct.b.page2.apdeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeseq
            
            #add-point:AFTER FIELD apdeseq name="construct.a.page2.apdeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeseq
            #add-point:ON ACTION controlp INFIELD apdeseq name="construct.c.page2.apdeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeorga
            #add-point:BEFORE FIELD apdeorga name="construct.b.page2.apdeorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeorga
            
            #add-point:AFTER FIELD apdeorga name="construct.a.page2.apdeorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeorga
            #add-point:ON ACTION controlp INFIELD apdeorga name="construct.c.page2.apdeorga"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#8   mark
            CALL q_ooef001_33()   #161006-00005#8   add                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdeorga  #顯示到畫面上
            NEXT FIELD apdeorga                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="construct.b.page2.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="construct.a.page2.apde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="construct.c.page2.apde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde006
            #add-point:BEFORE FIELD apde006 name="construct.b.page2.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="construct.a.page2.apde006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="construct.c.page2.apde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde003
            #add-point:BEFORE FIELD apde003 name="construct.b.page2.apde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde003
            
            #add-point:AFTER FIELD apde003 name="construct.a.page2.apde003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde003
            #add-point:ON ACTION controlp INFIELD apde003 name="construct.c.page2.apde003"
            #開窗c段
            LET l_apde002 = ''
            LET l_apde002 = GET_FLDBUF(apde002)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE     
                        
            CASE l_apde002
               WHEN '10'   #付款
                  #161115-00046#2 --s add            
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                            "              WHERE pmaaent = ",g_enterprise,
                                            "                AND ",g_sql_ctrl,
                                            "                AND pmaaent = nmckent ",
                                            "                AND pmaa001 = nmck005 )"
                  END IF            
                  #161115-00046#2 --e add
                  CALL q_nmckdocno_2()                    #呼叫開窗
               WHEN '16'   #收票轉付
                  #161115-00046#2 --s add            
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                            "              WHERE pmaaent = ",g_enterprise,
                                            "                AND ",g_sql_ctrl,
                                            "                AND pmaaent = nmbaent ",
                                            "                AND pmaa001 = nmba004 )"
                  END IF            
                  #161115-00046#2 --e add
                  CALL q_nmbadocno_3()
            END CASE
            DISPLAY g_qryparam.return1 TO apde003  #顯示到畫面上
            NEXT FIELD apde003                     #返回原欄位            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="construct.b.page2.apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="construct.a.page2.apde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="construct.c.page2.apde008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#5 -add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#5 -add - end 

            CALL q_nmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apde008  #顯示到畫面上
            NEXT FIELD apde008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_apde008
            #add-point:BEFORE FIELD lc_apde008 name="construct.b.page2.lc_apde008"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_apde008
            
            #add-point:AFTER FIELD lc_apde008 name="construct.a.page2.lc_apde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.lc_apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_apde008
            #add-point:ON ACTION controlp INFIELD lc_apde008 name="construct.c.page2.lc_apde008"
            #160122-00001#5 -add -str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE          
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            CALL q_nmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO lc_apde008  #顯示到畫面上
            NEXT FIELD lc_apde008
            #160122-00001#5 -add - end             
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde021
            #add-point:BEFORE FIELD apde021 name="construct.b.page2.apde021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde021
            
            #add-point:AFTER FIELD apde021 name="construct.a.page2.apde021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde021
            #add-point:ON ACTION controlp INFIELD apde021 name="construct.c.page2.apde021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde024
            #add-point:BEFORE FIELD apde024 name="construct.b.page2.apde024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde024
            
            #add-point:AFTER FIELD apde024 name="construct.a.page2.apde024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde024
            #add-point:ON ACTION controlp INFIELD apde024 name="construct.c.page2.apde024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apde100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="construct.c.page2.apde100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apde100  #顯示到畫面上
            NEXT FIELD apde100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="construct.b.page2.apde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="construct.a.page2.apde100"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="construct.b.page2.apde109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            
            #add-point:AFTER FIELD apde109 name="construct.a.page2.apde109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="construct.c.page2.apde109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde101
            #add-point:BEFORE FIELD apde101 name="construct.b.page2.apde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde101
            
            #add-point:AFTER FIELD apde101 name="construct.a.page2.apde101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde101
            #add-point:ON ACTION controlp INFIELD apde101 name="construct.c.page2.apde101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde119
            #add-point:BEFORE FIELD apde119 name="construct.b.page2.apde119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde119
            
            #add-point:AFTER FIELD apde119 name="construct.a.page2.apde119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde119
            #add-point:ON ACTION controlp INFIELD apde119 name="construct.c.page2.apde119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="construct.b.page2.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="construct.a.page2.apde032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="construct.c.page2.apde032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde013
            #add-point:BEFORE FIELD apde013 name="construct.b.page2.apde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde013
            
            #add-point:AFTER FIELD apde013 name="construct.a.page2.apde013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde013
            #add-point:ON ACTION controlp INFIELD apde013 name="construct.c.page2.apde013"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161115-00046#2 --s add
			   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent ",
                                      "            AND pmaa001 = pmac002 )"
            END IF
            #161115-00046#2 --e add
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO apde013  #顯示到畫面上
            NEXT FIELD apde013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde014
            #add-point:BEFORE FIELD apde014 name="construct.b.page2.apde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde014
            
            #add-point:AFTER FIELD apde014 name="construct.a.page2.apde014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde014
            #add-point:ON ACTION controlp INFIELD apde014 name="construct.c.page2.apde014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde015
            #add-point:BEFORE FIELD apde015 name="construct.b.page2.apde015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde015
            
            #add-point:AFTER FIELD apde015 name="construct.a.page2.apde015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde015
            #add-point:ON ACTION controlp INFIELD apde015 name="construct.c.page2.apde015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016
            #add-point:BEFORE FIELD apde016 name="construct.b.page2.apde016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016
            
            #add-point:AFTER FIELD apde016 name="construct.a.page2.apde016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016
            #add-point:ON ACTION controlp INFIELD apde016 name="construct.c.page2.apde016"
            #科目編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161115-00046#2 --s add
			   SELECT ooef017 INTO g_apda_m.apdacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_apda_m.apdald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_apda_m.apdacomp
               AND glaa014 = 'Y' 
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_apda_m.apdald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
			   #161115-00046#2 --e add
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apde016   #顯示到畫面上
            NEXT FIELD apde016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="construct.b.page2.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="construct.a.page2.apde010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="construct.c.page2.apde010"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde009
            #add-point:BEFORE FIELD apde009 name="construct.b.page2.apde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde009
            
            #add-point:AFTER FIELD apde009 name="construct.a.page2.apde009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde009
            #add-point:ON ACTION controlp INFIELD apde009 name="construct.c.page2.apde009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde039
            #add-point:BEFORE FIELD apde039 name="construct.b.page2.apde039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde039
            
            #add-point:AFTER FIELD apde039 name="construct.a.page2.apde039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde039
            #add-point:ON ACTION controlp INFIELD apde039 name="construct.c.page2.apde039"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde040
            #add-point:BEFORE FIELD apde040 name="construct.b.page2.apde040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde040
            
            #add-point:AFTER FIELD apde040 name="construct.a.page2.apde040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde040
            #add-point:ON ACTION controlp INFIELD apde040 name="construct.c.page2.apde040"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde041
            #add-point:BEFORE FIELD apde041 name="construct.b.page2.apde041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde041
            
            #add-point:AFTER FIELD apde041 name="construct.a.page2.apde041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde041
            #add-point:ON ACTION controlp INFIELD apde041 name="construct.c.page2.apde041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="construct.b.page2.apde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="construct.a.page2.apde011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="construct.c.page2.apde011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apde011  #顯示到畫面上
            NEXT FIELD apde011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="construct.b.page2.apde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="construct.a.page2.apde012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="construct.c.page2.apde012"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apde012  #顯示到畫面上
            NEXT FIELD apde012                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde046
            #add-point:BEFORE FIELD apde046 name="construct.b.page2.apde046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde046
            
            #add-point:AFTER FIELD apde046 name="construct.a.page2.apde046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apde046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde046
            #add-point:ON ACTION controlp INFIELD apde046 name="construct.c.page2.apde046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde038
            #add-point:BEFORE FIELD apde038 name="construct.b.page5.apde038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde038
            
            #add-point:AFTER FIELD apde038 name="construct.a.page5.apde038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde038
            #add-point:ON ACTION controlp INFIELD apde038 name="construct.c.page5.apde038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde038_desc
            #add-point:BEFORE FIELD apde038_desc name="construct.b.page5.apde038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde038_desc
            
            #add-point:AFTER FIELD apde038_desc name="construct.a.page5.apde038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde038_desc
            #add-point:ON ACTION controlp INFIELD apde038_desc name="construct.c.page5.apde038_desc"
            #帳款對象
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apde038
            DISPLAY g_qryparam.return1 TO apde038_desc      
            NEXT FIELD apde038_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="construct.b.page5.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="construct.a.page5.apde017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="construct.c.page5.apde017"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apde017  #顯示到畫面上
            NEXT FIELD apde017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017_desc
            #add-point:BEFORE FIELD apde017_desc name="construct.b.page5.apde017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017_desc
            
            #add-point:AFTER FIELD apde017_desc name="construct.a.page5.apde017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017_desc
            #add-point:ON ACTION controlp INFIELD apde017_desc name="construct.c.page5.apde017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()            
            DISPLAY g_qryparam.return1 TO apde017
            DISPLAY g_qryparam.return1 TO apde017_desc     
            NEXT FIELD apde017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="construct.b.page5.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="construct.a.page5.apde018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="construct.c.page5.apde018"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apde018  #顯示到畫面上
            NEXT FIELD apde018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018_desc
            #add-point:BEFORE FIELD apde018_desc name="construct.b.page5.apde018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018_desc
            
            #add-point:AFTER FIELD apde018_desc name="construct.a.page5.apde018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018_desc
            #add-point:ON ACTION controlp INFIELD apde018_desc name="construct.c.page5.apde018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apde018
            DISPLAY g_qryparam.return1 TO apde018_desc
            NEXT FIELD apde018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="construct.b.page5.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="construct.a.page5.apde019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="construct.c.page5.apde019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019_desc
            #add-point:BEFORE FIELD apde019_desc name="construct.b.page5.apde019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019_desc
            
            #add-point:AFTER FIELD apde019_desc name="construct.a.page5.apde019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019_desc
            #add-point:ON ACTION controlp INFIELD apde019_desc name="construct.c.page5.apde019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_5()
            DISPLAY g_qryparam.return1 TO apde019
            DISPLAY g_qryparam.return1 TO apde019_desc
            NEXT FIELD apde019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020
            #add-point:BEFORE FIELD apde020 name="construct.b.page5.apde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020
            
            #add-point:AFTER FIELD apde020 name="construct.a.page5.apde020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020
            #add-point:ON ACTION controlp INFIELD apde020 name="construct.c.page5.apde020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020_desc
            #add-point:BEFORE FIELD apde020_desc name="construct.b.page5.apde020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020_desc
            
            #add-point:AFTER FIELD apde020_desc name="construct.a.page5.apde020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020_desc
            #add-point:ON ACTION controlp INFIELD apde020_desc name="construct.c.page5.apde020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO apde020
            DISPLAY g_qryparam.return1 TO apde020_desc
            NEXT FIELD apde020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022
            #add-point:BEFORE FIELD apde022 name="construct.b.page5.apde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022
            
            #add-point:AFTER FIELD apde022 name="construct.a.page5.apde022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022
            #add-point:ON ACTION controlp INFIELD apde022 name="construct.c.page5.apde022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022_desc
            #add-point:BEFORE FIELD apde022_desc name="construct.b.page5.apde022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022_desc
            
            #add-point:AFTER FIELD apde022_desc name="construct.a.page5.apde022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022_desc
            #add-point:ON ACTION controlp INFIELD apde022_desc name="construct.c.page5.apde022_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO apde022
            DISPLAY g_qryparam.return1 TO apde022_desc
            NEXT FIELD apde022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023
            #add-point:BEFORE FIELD apde023 name="construct.b.page5.apde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023
            
            #add-point:AFTER FIELD apde023 name="construct.a.page5.apde023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023
            #add-point:ON ACTION controlp INFIELD apde023 name="construct.c.page5.apde023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023_desc
            #add-point:BEFORE FIELD apde023_desc name="construct.b.page5.apde023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023_desc
            
            #add-point:AFTER FIELD apde023_desc name="construct.a.page5.apde023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023_desc
            #add-point:ON ACTION controlp INFIELD apde023_desc name="construct.c.page5.apde023_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO apde023
            DISPLAY g_qryparam.return1 TO apde023_desc
            NEXT FIELD apde023_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035
            #add-point:BEFORE FIELD apde035 name="construct.b.page5.apde035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035
            
            #add-point:AFTER FIELD apde035 name="construct.a.page5.apde035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035
            #add-point:ON ACTION controlp INFIELD apde035 name="construct.c.page5.apde035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035_desc
            #add-point:BEFORE FIELD apde035_desc name="construct.b.page5.apde035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035_desc
            
            #add-point:AFTER FIELD apde035_desc name="construct.a.page5.apde035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035_desc
            #add-point:ON ACTION controlp INFIELD apde035_desc name="construct.c.page5.apde035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO apde035
            DISPLAY g_qryparam.return1 TO apde035_desc
            NEXT FIELD apde035_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036
            #add-point:BEFORE FIELD apde036 name="construct.b.page5.apde036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036
            
            #add-point:AFTER FIELD apde036 name="construct.a.page5.apde036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036
            #add-point:ON ACTION controlp INFIELD apde036 name="construct.c.page5.apde036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036_desc
            #add-point:BEFORE FIELD apde036_desc name="construct.b.page5.apde036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036_desc
            
            #add-point:AFTER FIELD apde036_desc name="construct.a.page5.apde036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036_desc
            #add-point:ON ACTION controlp INFIELD apde036_desc name="construct.c.page5.apde036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO apde036
            DISPLAY g_qryparam.return1 TO apde036_desc
            NEXT FIELD apde036_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042
            #add-point:BEFORE FIELD apde042 name="construct.b.page5.apde042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042
            
            #add-point:AFTER FIELD apde042 name="construct.a.page5.apde042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042
            #add-point:ON ACTION controlp INFIELD apde042 name="construct.c.page5.apde042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042_desc
            #add-point:BEFORE FIELD apde042_desc name="construct.b.page5.apde042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042_desc
            
            #add-point:AFTER FIELD apde042_desc name="construct.a.page5.apde042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042_desc
            #add-point:ON ACTION controlp INFIELD apde042_desc name="construct.c.page5.apde042_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043
            #add-point:BEFORE FIELD apde043 name="construct.b.page5.apde043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043
            
            #add-point:AFTER FIELD apde043 name="construct.a.page5.apde043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043
            #add-point:ON ACTION controlp INFIELD apde043 name="construct.c.page5.apde043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043_desc
            #add-point:BEFORE FIELD apde043_desc name="construct.b.page5.apde043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043_desc
            
            #add-point:AFTER FIELD apde043_desc name="construct.a.page5.apde043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043_desc
            #add-point:ON ACTION controlp INFIELD apde043_desc name="construct.c.page5.apde043_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO apde043
            DISPLAY g_qryparam.return1 TO apde043_desc
            NEXT FIELD apde043_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044
            #add-point:BEFORE FIELD apde044 name="construct.b.page5.apde044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044
            
            #add-point:AFTER FIELD apde044 name="construct.a.page5.apde044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044
            #add-point:ON ACTION controlp INFIELD apde044 name="construct.c.page5.apde044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044_desc
            #add-point:BEFORE FIELD apde044_desc name="construct.b.page5.apde044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044_desc
            
            #add-point:AFTER FIELD apde044_desc name="construct.a.page5.apde044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.apde044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044_desc
            #add-point:ON ACTION controlp INFIELD apde044_desc name="construct.c.page5.apde044_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO apde044
            DISPLAY g_qryparam.return1 TO apde044_desc
            NEXT FIELD apde044_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde121
            #add-point:BEFORE FIELD apde121 name="construct.b.page6.apde121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde121
            
            #add-point:AFTER FIELD apde121 name="construct.a.page6.apde121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.apde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde121
            #add-point:ON ACTION controlp INFIELD apde121 name="construct.c.page6.apde121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde129
            #add-point:BEFORE FIELD apde129 name="construct.b.page6.apde129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde129
            
            #add-point:AFTER FIELD apde129 name="construct.a.page6.apde129"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.apde129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde129
            #add-point:ON ACTION controlp INFIELD apde129 name="construct.c.page6.apde129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde131
            #add-point:BEFORE FIELD apde131 name="construct.b.page6.apde131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde131
            
            #add-point:AFTER FIELD apde131 name="construct.a.page6.apde131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.apde131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde131
            #add-point:ON ACTION controlp INFIELD apde131 name="construct.c.page6.apde131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde139
            #add-point:BEFORE FIELD apde139 name="construct.b.page6.apde139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde139
            
            #add-point:AFTER FIELD apde139 name="construct.a.page6.apde139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.apde139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde139
            #add-point:ON ACTION controlp INFIELD apde139 name="construct.c.page6.apde139"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#63 add
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apce_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apde_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #160122-00001#5 --add--str--
   IF NOT cl_null(g_wc2) THEN 
      LET g_wc2 = cl_replace_str(g_wc2,"lc_apde008","apde008")
      LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"lc_apde008","apde008")
   END IF
   #160122-00001#5 --add--end  
  IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc," AND apda001 = '85' "
      LET g_wc2 = cl_replace_str(g_wc2,'_desc',' ')                 #150915 
      LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'_desc',' ')   #150915 
      LET g_wc2_table2 = cl_replace_str(g_wc2_table1,'_desc',' ')   #150915   
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt823_filter()
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
      CONSTRUCT g_wc_filter ON apdadocno,apdald
                          FROM s_browse[1].b_apdadocno,s_browse[1].b_apdald
 
         BEFORE CONSTRUCT
               DISPLAY aapt823_filter_parser('apdadocno') TO s_browse[1].b_apdadocno
            DISPLAY aapt823_filter_parser('apdald') TO s_browse[1].b_apdald
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
      CALL aapt823_filter_show('apdadocno')
   CALL aapt823_filter_show('apdald')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt823_filter_parser(ps_field)
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
 
{<section id="aapt823.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt823_filter_show(ps_field)
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
   LET ls_condition = aapt823_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt823_query()
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
   CALL g_apce_d.clear()
   CALL g_apce2_d.clear()
   CALL g_apce3_d.clear()
   CALL g_apce4_d.clear()
   CALL g_apce5_d.clear()
   CALL g_apce6_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt823_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt823_browser_fill("")
      CALL aapt823_fetch("")
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt823_filter_show('apdadocno')
   CALL aapt823_filter_show('apdald')
   CALL aapt823_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt823_fetch("F") 
      #顯示單身筆數
      CALL aapt823_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt823_fetch(p_flag)
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
   
   LET g_apda_m.apdald = g_browser[g_current_idx].b_apdald
   LET g_apda_m.apdadocno = g_browser[g_current_idx].b_apdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt823_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt823_set_act_visible()   
   CALL aapt823_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apda_m_t.* = g_apda_m.*
   LET g_apda_m_o.* = g_apda_m.*
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #重新顯示   
   CALL aapt823_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt823_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_count   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apce_d.clear()   
   CALL g_apce2_d.clear()  
   CALL g_apce3_d.clear()  
   CALL g_apce4_d.clear()  
   CALL g_apce5_d.clear()  
   CALL g_apce6_d.clear()  
 
 
   INITIALIZE g_apda_m.* TO NULL             #DEFAULT 設定
   
   LET g_apdald_t = NULL
   LET g_apdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apda_m.apdaownid = g_user
      LET g_apda_m.apdaowndp = g_dept
      LET g_apda_m.apdacrtid = g_user
      LET g_apda_m.apdacrtdp = g_dept 
      LET g_apda_m.apdacrtdt = cl_get_current()
      LET g_apda_m.apdamodid = g_user
      LET g_apda_m.apdamoddt = cl_get_current()
      LET g_apda_m.apdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_apda_m.apda007 = "0"
      LET g_apda_m.apda016 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apda_m.apdastus = 'N'
      LET g_apda_m.apdadocdt = g_today
      LET g_apda_m.apda003   = g_user
      LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)      
      LET g_apda_m.apda007 = '0'   #人員輸入


      #取得預設帳務中心
      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdacomp
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#2 add #161229-00047#63 mark
      #161229-00047#63 add ------
      CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#63 add end---
      IF NOT cl_null(g_apda_m.apdald) THEN
         CALL aapt823_set_ld_info(g_apda_m.apdald)
      END IF
      #160825-00012#1--s
      #取得帳套範圍
      CALL aapt823_get_ld_wc(g_apda_m.apdasite) RETURNING g_ld_wc,g_site_wc
      #160825-00012#1--e          
      CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
      LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
      LET g_apda_m_t.* = g_apda_m.*    #設定預設值後
      LET g_apda_m_o.* = g_apda_m.*    #舊值備份      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apda_m_t.* = g_apda_m.*
      LET g_apda_m_o.* = g_apda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
 
 
 
    
      CALL aapt823_input("a")
      
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
         INITIALIZE g_apda_m.* TO NULL
         INITIALIZE g_apce_d TO NULL
         INITIALIZE g_apce2_d TO NULL
         INITIALIZE g_apce3_d TO NULL
         INITIALIZE g_apce4_d TO NULL
         INITIALIZE g_apce5_d TO NULL
         INITIALIZE g_apce6_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt823_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apce_d.clear()
      #CALL g_apce2_d.clear()
      #CALL g_apce3_d.clear()
      #CALL g_apce4_d.clear()
      #CALL g_apce5_d.clear()
      #CALL g_apce6_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt823_set_act_visible()   
   CALL aapt823_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt823_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt823_cl
   
   CALL aapt823_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt823_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003,g_apda_m.apda003_desc,g_apda_m.apdald, 
       g_apda_m.apdald_desc,g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001,g_apda_m.apdadocdt, 
       g_apda_m.apda005,g_apda_m.apda005_desc,g_apda_m.apda023,g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp, 
       g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda007,g_apda_m.apda009, 
       g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt, 
       g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt,g_apda_m.dummy3,g_apda_m.glaa001, 
       g_apda_m.sum_apde1092,g_apda_m.sum_apde1192,g_apda_m.sum_apde1091,g_apda_m.sum_apde1191,g_apda_m.sum_apde1093, 
       g_apda_m.sum_apde1193,g_apda_m.sum_apde1094,g_apda_m.sum_apde1194,g_apda_m.glaa016,g_apda_m.glaa020, 
       g_apda_m.sum_apde1291,g_apda_m.sum_apde1391,g_apda_m.sum_apde1292,g_apda_m.sum_apde1392,g_apda_m.sum_apde1293, 
       g_apda_m.sum_apde1393,g_apda_m.sum_apde1294,g_apda_m.sum_apde1394
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt823_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt823_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apda_m_t.* = g_apda_m.*
   LET g_apda_m_o.* = g_apda_m.*
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   CALL s_transaction_begin()
   
   OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aapt823_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt823_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aapt823_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150311--(s)
  # IF g_apda_m.apdastus <> 'N' THEN #xujing mark
    IF g_apda_m.apdastus NOT MATCHES '[NDR]' THEN #xujing add
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apda_m.apdastus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #150311--(e)
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_apdald_t = g_apda_m.apdald
      LET g_apdadocno_t = g_apda_m.apdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apda_m.apdamodid = g_user 
LET g_apda_m.apdamoddt = cl_get_current()
LET g_apda_m.apdamodid_desc = cl_get_username(g_apda_m.apdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt823_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_apda_m.apdastus MATCHES "[DR]" THEN 
         LET g_apda_m.apdastus = "N"
      END IF
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apda_t SET (apdamodid,apdamoddt) = (g_apda_m.apdamodid,g_apda_m.apdamoddt)
          WHERE apdaent = g_enterprise AND apdald = g_apdald_t
            AND apdadocno = g_apdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apda_m.* = g_apda_m_t.*
            CALL aapt823_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apda_m.apdald != g_apda_m_t.apdald
      OR g_apda_m.apdadocno != g_apda_m_t.apdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apce_t SET apceld = g_apda_m.apdald
                                       ,apcedocno = g_apda_m.apdadocno
 
          WHERE apceent = g_enterprise AND apceld = g_apda_m_t.apdald
            AND apcedocno = g_apda_m_t.apdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apce_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
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
         
         UPDATE apde_t
            SET apdeld = g_apda_m.apdald
               ,apdedocno = g_apda_m.apdadocno
 
          WHERE apdeent = g_enterprise AND
                apdeld = g_apdald_t
            AND apdedocno = g_apdadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apde_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt823_set_act_visible()   
   CALL aapt823_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到對應位置
   CALL aapt823_browser_fill("")
 
   CLOSE aapt823_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt823_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt823.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt823_input(p_cmd)
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
   DEFINE  l_apceorga_comp       LIKE glaa_t.glaacomp
   DEFINE  l_apceorga_ld         LIKE glaa_t.glaald
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_apcc_used           RECORD
                                 apcc10x    LIKE type_t.num20_6,
                                 apcc11x    LIKE type_t.num20_6,
                                 apcc12x    LIKE type_t.num20_6,
                                 apcc13x    LIKE type_t.num20_6
                                 END RECORD   
   DEFINE  l_nmag002             LIKE nmag_t.nmag002
   DEFINE  l_nouse               STRING
   DEFINE  l_continue            LIKE type_t.chr1
   DEFINE  l_glae009             LIKE glae_t.glae009    #自由核算項使用
   DEFINE  l_chr                 LIKE type_t.chr1
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_count2              LIKE type_t.num5
   DEFINE  l_account             DYNAMIC ARRAY OF RECORD
                    f1           LIKE type_t.chr100,     #欄位值
                    f2           LIKE type_t.chr7,       #欄位說明
                    f3           LIKE apca_t.apcadocdt   #條件             
                                 END RECORD      
   DEFINE  l_ooia011             LIKE ooia_t.ooia011         
   DEFINE  l_ar_condition        STRING   
   DEFINE  l_ap_slip             LIKE apda_t.apdadocno
   DEFINE  l_gen_flag            LIKE type_t.chr1        #是否使用自動產生單身
   DEFINE  l_ask_flag            LIKE type_t.chr1        #是否使用自動產生單身
   #150311--(s)
   DEFINE l_oofg_return          DYNAMIC ARRAY OF RECORD
                   oofg019       LIKE oofg_t.oofg019,   #field
                   oofg020       LIKE oofg_t.oofg020    #value
                             END RECORD   
   #150311--(e)
   DEFINE l_success              LIKE type_t.num5       #add--2015/05/18 By shiun
   #150512-00036#1--(s)
   DEFINE l_wc                   STRING
   DEFINE l_flag                 LIKE type_t.chr1       #開窗多筆寫入後,標記繼續留在輸入中
   #150512-00036#1--(e) 
   DEFINE l_amt1                 LIKE type_t.num20_6
   DEFINE l_amt2                 LIKE type_t.num20_6   
   DEFINE l_apce010              LIKE apce_t.apce010  #151104
      #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   DEFINE l_comp_wc              STRING #161115-00046#2 add
   DEFINE l_ld_str               STRING #161115-00046#2 add
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
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003,g_apda_m.apda003_desc,g_apda_m.apdald, 
       g_apda_m.apdald_desc,g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001,g_apda_m.apdadocdt, 
       g_apda_m.apda005,g_apda_m.apda005_desc,g_apda_m.apda023,g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp, 
       g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda007,g_apda_m.apda009, 
       g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt, 
       g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt,g_apda_m.dummy3,g_apda_m.glaa001, 
       g_apda_m.sum_apde1092,g_apda_m.sum_apde1192,g_apda_m.sum_apde1091,g_apda_m.sum_apde1191,g_apda_m.sum_apde1093, 
       g_apda_m.sum_apde1193,g_apda_m.sum_apde1094,g_apda_m.sum_apde1194,g_apda_m.glaa016,g_apda_m.glaa020, 
       g_apda_m.sum_apde1291,g_apda_m.sum_apde1391,g_apda_m.sum_apde1292,g_apda_m.sum_apde1392,g_apda_m.sum_apde1293, 
       g_apda_m.sum_apde1393,g_apda_m.sum_apde1294,g_apda_m.sum_apde1394
   
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
   LET g_forupd_sql = "SELECT apceseq,apce002,apceorga,apce003,apce004,apce005,apce061,apce038,apce048, 
       apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010,apce031,apce049,apcecomp,apcesite, 
       apce001,apceseq,apce017,apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045, 
       apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apceseq, 
       apce120,apce121,apce129,apce130,apce131,apce139 FROM apce_t WHERE apceent=? AND apceld=? AND  
       apcedocno=? AND apceseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt823_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apdeseq,apdeorga,apde002,apde006,apde003,apde008,apde021,apde024,apde100, 
       apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016,apde010,apde009,apde039,apde040, 
       apde041,apde011,apde012,apde046,apdecomp,apdesite,apde001,apdeseq,apde038,apde017,apde018,apde019, 
       apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051,apde052,apde053,apde054, 
       apde055,apde056,apde057,apde058,apde059,apde060,apdeseq,apde120,apde121,apde129,apde130,apde131, 
       apde139 FROM apde_t WHERE apdeent=? AND apdeld=? AND apdedocno=? AND apdeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt823_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt823_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt823_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001, 
       g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023,g_apda_m.apdastus,g_apda_m.apda008,g_apda_m.apda010, 
       g_apda_m.apda018,g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda017
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #150512-00036#1--(s)
   WHILE TRUE
      LET l_flag = 'N'
   #150512-00036#1--(e)
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt823.input.head" >}
      #單頭段
      INPUT BY NAME g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001, 
          g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023,g_apda_m.apdastus,g_apda_m.apda008,g_apda_m.apda010, 
          g_apda_m.apda018,g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda017 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt823_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL aapt823_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            LET g_apda_m.apdasite_desc = ' '
            DISPLAY BY NAME g_apda_m.apdasite_desc
            IF NOT cl_null(g_apda_m.apdasite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdasite != g_apda_m_t.apdasite OR g_apda_m_t.apdasite IS NULL )) THEN  #160822-00008#4  mark
               IF g_apda_m.apdasite != g_apda_m_o.apdasite OR cl_null(g_apda_m_o.apdasite) THEN                                      #160822-00008#4
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apda_m.apdasite
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                     #LET g_apda_m.apdasite = g_apda_m_t.apdasite  #160822-00008#4  mark
                     LET g_apda_m.apdasite = g_apda_m_o.apdasite   #160822-00008#4
                     LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
                     DISPLAY BY NAME g_apda_m.apdasite_desc
                     NEXT FIELD CURRENT
                  END IF

                  CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','Y','',g_today)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdasite = g_apda_m_t.apdasite  #160822-00008#4  mark
                     LET g_apda_m.apdasite = g_apda_m_o.apdasite   #160822-00008#4
                     LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
                     DISPLAY BY NAME g_apda_m.apdasite_desc
                     NEXT FIELD CURRENT
                  END IF
               
                  #取得所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_apda_m.apdasite) RETURNING g_sub_success,g_errno,g_apda_m.apdacomp,g_apda_m.apdald
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#2 add #161229-00047#63 mark
                  IF NOT cl_null(g_apda_m.apdald) THEN
                     CALL aapt823_set_ld_info(g_apda_m.apdald)
                  END IF                                     
               END IF
            END IF           
            LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
            DISPLAY BY NAME g_apda_m.apdasite_desc
            #161115-00046#2 --s add
            CALL s_fin_account_center_sons_query('3',g_apda_m.apdasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
            CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
            #161115-00046#2 --e add
            #161229-00047#63 add ------
            CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#63 add end---
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="input.b.apdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdasite
            #add-point:ON CHANGE apdasite name="input.g.apdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="input.a.apda003"
            LET g_apda_m.apda003_desc = ' '
            DISPLAY BY NAME g_apda_m.apda003_desc
            IF NOT cl_null(g_apda_m.apda003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda003 != g_apda_m_t.apda003 OR g_apda_m_t.apda003 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apda_m.apda003 != g_apda_m_o.apda003 OR cl_null(g_apda_m_o.apda003) THEN                                      #160822-00008#4
                  CALL s_voucher_glaq013_chk(g_apda_m.apda003)
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi130'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_apda_m.apda003 = g_apda_m_t.apda003  #160822-00008#4  mark
                     LET g_apda_m.apda003 = g_apda_m_o.apda003   #160822-00008#4   
                     LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)
                     DISPLAY BY NAME g_apda_m.apda003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)
            DISPLAY BY NAME g_apda_m.apda003_desc
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="input.b.apda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda003
            #add-point:ON CHANGE apda003 name="input.g.apda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            LET g_apda_m.apdald_desc = ''
            DISPLAY BY NAME g_apda_m.apdald_desc
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_apda_m.apdald) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t)) THEN   #160822-00008#4  mark
               IF (g_apda_m.apdald != g_apda_m.apdald) THEN                                 #160822-00008#4   
                 #CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N','',g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno #161115-00046#2 mark
                  CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','Y',g_wc_apdald,g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno #161115-00046#2 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdald = g_apda_m_t.apdald  #160822-00008#4  mark
                     LET g_apda_m.apdald = g_apda_m_o.apdald   #160822-00008#4
                     LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
                     DISPLAY BY NAME g_apda_m.apdald_desc                     
                     NEXT FIELD CURRENT
                  END IF    
                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_ld_wc,g_apda_m.apdald,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdald = g_apda_m_t.apdald  #160822-00008#4  mark
                     LET g_apda_m.apdald = g_apda_m_o.apdald   #160822-00008#4   
                     NEXT FIELD CURRENT
                  END IF
                  #抓所屬法人
                  SELECT glaacomp INTO g_apda_m.apdacomp FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_apda_m.apdald            
                  CALL aapt823_set_ld_info(g_apda_m.apdald)                     
               END IF
            END IF
            LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
            DISPLAY BY NAME g_apda_m.apdald_desc
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apda_m.apdadocno != g_apdadocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apda_t WHERE "||"apdaent = '" ||g_enterprise|| "' AND "||"apdadocno = '"||g_apda_m.apdadocno ||"'  AND "||"apdald = '"||g_apda_m.apdald ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            IF NOT cl_null(g_apda_m.apdadocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdadocno != g_apda_m_t.apdadocno OR g_apda_m_t.apdadocno IS NULL )) THEN  #160822-00008#4  mark
               IF g_apda_m.apdadocno != g_apda_m_o.apdadocno OR cl_null(g_apda_m_o.apdadocno) THEN                                      #160822-00008#4
                  IF NOT s_aooi200_fin_chk_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,g_prog) THEN
                     #LET g_apda_m.apdadocno = g_apda_m_t.apdadocno  #160822-00008#4  mark
                     LET g_apda_m.apdadocno = g_apda_m_o.apdadocno   #160822-00008#4  mark
                     NEXT FIELD CURRENT
                  END IF           
                  #150203-(s)
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
                  CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,g_fin_arg1) RETURNING g_apda_m.apda001
                  DISPLAY BY NAME g_apda_m.apda001
                  #150203-(e)
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno) RETURNING g_apda_m.apdadocno_desc
            DISPLAY BY NAME g_apda_m.apdadocno_desc 
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocno
            #add-point:ON CHANGE apdadocno name="input.g.apdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda001
            #add-point:BEFORE FIELD apda001 name="input.b.apda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda001
            
            #add-point:AFTER FIELD apda001 name="input.a.apda001"
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda001
            #add-point:ON CHANGE apda001 name="input.g.apda001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="input.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="input.a.apdadocdt"
            IF NOT cl_null(g_apda_m.apdadocdt) THEN               
               IF NOT cl_null(g_sfin3007) THEN
                  IF g_apda_m.apdadocdt <= g_sfin3007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00110'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apda_m.apdadocdt= g_apda_m_t.apdadocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocdt
            #add-point:ON CHANGE apdadocdt name="input.g.apdadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda005
            
            #add-point:AFTER FIELD apda005 name="input.a.apda005"
            LET g_apda_m.apda005_desc = ' '
            DISPLAY BY NAME g_apda_m.apda005_desc
            IF NOT cl_null(g_apda_m.apda005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda005 != g_apda_m_t.apda005 OR g_apda_m_t.apda005 IS NULL )) THEN
#                 CALL s_aap_pmaa001_chk(g_apda_m.apda005) RETURNING g_sub_success,g_errno #151231-00010#1 mark
                  CALL s_aap_apca004_chk(g_apda_m.apda005) RETURNING g_sub_success,g_errno  #151231-00010#1 add
                  IF NOT cl_null(g_errno)THEN
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

                     LET g_apda_m.apda005 = g_apda_m_t.apda005
                     LET g_apda_m.apda005_desc = s_desc_get_trading_partner_abbr_desc(g_apda_m.apda005)
                     DISPLAY BY NAME g_apda_m.apda005_desc
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF           
            LET g_apda_m.apda005_desc = s_desc_get_trading_partner_abbr_desc(g_apda_m.apda005)
            DISPLAY BY NAME g_apda_m.apda005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda005
            #add-point:BEFORE FIELD apda005 name="input.b.apda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda005
            #add-point:ON CHANGE apda005 name="input.g.apda005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda023
            #add-point:BEFORE FIELD apda023 name="input.b.apda023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda023
            
            #add-point:AFTER FIELD apda023 name="input.a.apda023"
            IF NOT cl_null(g_apda_m.apda023) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda023 != g_apda_m_t.apda023 OR g_apda_m_t.apda023 IS NULL )) THEN
                  CALL aapt823_apda023_chk(g_apda_m.apda023) RETURNING g_sub_success,g_errno  
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aapt815'
                     LET g_errparam.replace[2] = cl_get_progname('aapt815',g_lang,"2")
                     LET g_errparam.exeprog = 'aapt815'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apda_m.apda023 = g_apda_m_t.apda023
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda023
            #add-point:ON CHANGE apda023 name="input.g.apda023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdastus
            #add-point:BEFORE FIELD apdastus name="input.b.apdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdastus
            
            #add-point:AFTER FIELD apdastus name="input.a.apdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdastus
            #add-point:ON CHANGE apdastus name="input.g.apdastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda008
            #add-point:BEFORE FIELD apda008 name="input.b.apda008"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda008
            
            #add-point:AFTER FIELD apda008 name="input.a.apda008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda008
            #add-point:ON CHANGE apda008 name="input.g.apda008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda010
            #add-point:BEFORE FIELD apda010 name="input.b.apda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda010
            
            #add-point:AFTER FIELD apda010 name="input.a.apda010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda010
            #add-point:ON CHANGE apda010 name="input.g.apda010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="input.a.apda018"
            LET g_apda_m.apda018_desc = ' '
            DISPLAY BY NAME g_apda_m.apda018_desc
            IF NOT cl_null(g_apda_m.apda018) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda018 != g_apda_m_t.apda018 OR g_apda_m_t.apda018 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apda_m.apda018 != g_apda_m_o.apda018 OR cl_null(g_apda_m_o.apda018) THEN                                      #160822-00008#4 
                  IF NOT s_azzi650_chk_exist('3113',g_apda_m.apda018) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_apda_m.apda018 = g_apda_m_t.apda018  #160822-00008#4 mark
                     LET g_apda_m.apda018 = g_apda_m_o.apda018   #160822-00008#4 
                     LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
                     DISPLAY BY NAME g_apda_m.apda018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
            DISPLAY BY NAME g_apda_m.apda018_desc
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#4 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018
            #add-point:BEFORE FIELD apda018 name="input.b.apda018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda018
            #add-point:ON CHANGE apda018 name="input.g.apda018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda007
            #add-point:BEFORE FIELD apda007 name="input.b.apda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda007
            
            #add-point:AFTER FIELD apda007 name="input.a.apda007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda007
            #add-point:ON CHANGE apda007 name="input.g.apda007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda009
            #add-point:BEFORE FIELD apda009 name="input.b.apda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda009
            
            #add-point:AFTER FIELD apda009 name="input.a.apda009"
            #add--2015/05/18 By shiun--(S)
            IF NOT cl_null(g_apda_m.apda009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda009 != g_apda_m_t.apda009 OR g_apda_m_t.apda009 IS NULL )) THEN
                  IF NOT s_aooi390_chk('14',g_apda_m.apda009) THEN
                     LET g_apda_m.apda009 = g_apda_m_t.apda009
                     DISPLAY BY NAME g_apda_m.apda009
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #add--2015/05/18 By shiun--(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda009
            #add-point:ON CHANGE apda009 name="input.g.apda009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda015
            
            #add-point:AFTER FIELD apda015 name="input.a.apda015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda015
            #add-point:BEFORE FIELD apda015 name="input.b.apda015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda015
            #add-point:ON CHANGE apda015 name="input.g.apda015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda017
            #add-point:BEFORE FIELD apda017 name="input.b.apda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda017
            
            #add-point:AFTER FIELD apda017 name="input.a.apda017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda017
            #add-point:ON CHANGE apda017 name="input.g.apda017"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdasite       #給予default值
            #CALL q_ooef001()     #161006-00005#8   mark
            CALL q_ooef001_46()   #161006-00005#8   add                                 #呼叫開窗
            LET g_apda_m.apdasite = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
            DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc
            NEXT FIELD apdasite 

            #END add-point
 
 
         #Ctrlp:input.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="input.c.apda003"
		     	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda003      #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_apda_m.apda003 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
            DISPLAY BY NAME g_apda_m.apda003,g_apda_m.apda003_desc
            NEXT FIELD apda003  
            #END add-point
 
 
         #Ctrlp:input.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            #帳別
            #開窗i段
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00046#2  add
            CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00046#2  add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdald
            #161115-00046#2 --s mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND ",  #glaa008(平行記帳)/glaa014(主帳套)
            #                       "  glaald IN ",g_ld_wc
            #161115-00046#2 --e mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""       #161115-00046#2 add
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            CALL q_authorised_ld()
            LET g_apda_m.apdald = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_apda_m.apdald) RETURNING g_apda_m.apdald_desc
            DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdald_desc
            NEXT FIELD apdald
            #END add-point
 
 
         #Ctrlp:input.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="input.c.apdadocno"
     
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apda_m.apdadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_apda_m.apdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno) RETURNING g_apda_m.apdadocno_desc
            CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
           #CALL cl_get_doc_para(g_enterprise,g_apda_m.apdacomp,g_ap_slip,g_fin_arg1) RETURNING g_apda_m.apda001
            CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,g_fin_arg1) RETURNING g_apda_m.apda001
            DISPLAY g_apda_m.apdadocno TO apdadocno              #顯示到畫面上

            NEXT FIELD apdadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda001
            #add-point:ON ACTION controlp INFIELD apda001 name="input.c.apda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="input.c.apdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda005
            #add-point:ON ACTION controlp INFIELD apda005 name="input.c.apda005"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda005      #給予default值
           #LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') AND (pmaa004 = '1' OR pmaa004 = '3')"  #150211apo mark
            LET g_qryparam.arg1 = "('1','3')"   #150211apo 
           #CALL q_pmaa001()                                #呼叫開窗  #150211apo mark
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#1(E)           
            CALL q_pmaa001_1()                                        #150211apo
            LET g_apda_m.apda005 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_trading_partner_abbr_desc(g_apda_m.apda005) RETURNING g_apda_m.apda005_desc
            DISPLAY BY NAME g_apda_m.apda005,g_apda_m.apda005_desc
            NEXT FIELD apda005            
            #END add-point
 
 
         #Ctrlp:input.c.apda023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda023
            #add-point:ON ACTION controlp INFIELD apda023 name="input.c.apda023"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda023        #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "  apea001 = '80' ",
                                   "  AND apeald = '",g_apda_m.apdald,"'",
                                   "  AND apeadocdt <= '",g_apda_m.apdadocdt,"'",
                                   "  AND NOT EXISTS ",                      #已存在aapt823項次排除
                                   "  (SELECT 1 FROM apda_t,apce_t ",   
                                   "    WHERE apdaent = apceent ", 
                                   "      AND apdald  = apceld ",  
                                   "      AND apdadocno = apcedocno ",
                                   "      AND apdastus <> 'X' ",             #作廢不算
                                   "      AND apceld  = apeald ",               
                                   "      AND apceent = apebent ",
                                   "      AND apda023 = apebdocno ",
                                   "     AND apceseq = apebseq "            
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where,"AND ",cl_replace_str(g_sql_ctrl,'pmaa001','apce038')
            END IF                                   
            LET g_qryparam.where = g_qryparam.where," )"
            #161115-00046#2 --s add
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apeald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161115-00046#2 --e add
            CALL q_apeadocno()                                #呼叫開窗 
            LET g_apda_m.apda023 = g_qryparam.return1              
            DISPLAY g_apda_m.apda023 TO apda023              
            NEXT FIELD apda023                                #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdastus
            #add-point:ON ACTION controlp INFIELD apdastus name="input.c.apdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda008
            #add-point:ON ACTION controlp INFIELD apda008 name="input.c.apda008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda010
            #add-point:ON ACTION controlp INFIELD apda010 name="input.c.apda010"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="input.c.apda018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apda_m.apda018             #給予default值
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()                                #呼叫開窗

            LET g_apda_m.apda018 = g_qryparam.return1              
            DISPLAY g_apda_m.apda018 TO apda018              #
            NEXT FIELD apda018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apda007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda007
            #add-point:ON ACTION controlp INFIELD apda007 name="input.c.apda007"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda009
            #add-point:ON ACTION controlp INFIELD apda009 name="input.c.apda009"
            #CALL s_aooi390('15') RETURNING g_sub_success,g_apda_m.apda009                         #150311 mark
#            CALL s_aooi390_auto_no('15') RETURNING g_sub_success,g_apda_m.apda009,l_oofg_return    #150311   #mark--2015/05/18 By shiun
            CALL s_aooi390_gen('14') RETURNING g_sub_success,g_apda_m.apda009,l_oofg_return   #add--2015/05/18 By shiun
            DISPLAY BY NAME g_apda_m.apda009
            NEXT FIELD apda009
            #END add-point
 
 
         #Ctrlp:input.c.apda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda015
            #add-point:ON ACTION controlp INFIELD apda015 name="input.c.apda015"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apda_m.apda015             #給予default值
            LET g_qryparam.arg1 = "3115"
            CALL q_oocq002()                                #呼叫開窗

            LET g_apda_m.apda015 = g_qryparam.return1              
            DISPLAY g_apda_m.apda015 TO apda015              #
            NEXT FIELD apda015                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda017
            #add-point:ON ACTION controlp INFIELD apda017 name="input.c.apda017"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,g_prog)
                    RETURNING g_sub_success,g_apda_m.apdadocno
               IF g_sub_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apda_m.apdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD apdadocno
               END IF
               DISPLAY BY NAME g_apda_m.apdadocno     
               #add--2015/07/01 By shiun--(S) 編碼功能修改
               CALL s_aooi390_get_auto_no('14',g_apda_m.apda009) RETURNING l_success,g_apda_m.apda009
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF               
               DISPLAY BY NAME g_apda_m.apda009
               #add--2015/07/01 By shiun--(E)
               CALL s_aooi390_oofi_upd('14',g_apda_m.apda009) RETURNING l_success  #add--2015/05/18 By shiun 增加編碼功能               
               #end add-point
               
               INSERT INTO apda_t (apdaent,apdasite,apda003,apdald,apdadocno,apda001,apdadocdt,apda005, 
                   apda023,apda014,apdastus,apdacomp,apda008,apda010,apda018,apda007,apda009,apda015, 
                   apda016,apda017,apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt, 
                   apdacnfid,apdacnfdt)
               VALUES (g_enterprise,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023,g_apda_m.apda014, 
                   g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
                   g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017, 
                   g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
                   g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt823_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt823_b_fill()
                  CALL aapt823_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               #自動產生
               IF cl_ask_confirm('axm-00013') THEN 
                  CALL aapt823_gen_detail()
               END IF
               LET l_ask_flag = 'N'
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #add--2015/07/01 By shiun--(S) 編碼功能修改
               CALL s_aooi390_get_auto_no('14',g_apda_m.apda009) RETURNING l_success,g_apda_m.apda009              
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_apda_m.apda009
               #add--2015/07/01 By shiun--(E)
               CALL s_aooi390_oofi_upd('14',g_apda_m.apda009) RETURNING l_success  #add--2015/05/18 By shiun 增加編碼功能
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt823_apda_t_mask_restore('restore_mask_o')
               
               UPDATE apda_t SET (apdasite,apda003,apdald,apdadocno,apda001,apdadocdt,apda005,apda023, 
                   apda014,apdastus,apdacomp,apda008,apda010,apda018,apda007,apda009,apda015,apda016, 
                   apda017,apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid, 
                   apdacnfdt) = (g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023,g_apda_m.apda014, 
                   g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
                   g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017, 
                   g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
                   g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt)
                WHERE apdaent = g_enterprise AND apdald = g_apdald_t
                  AND apdadocno = g_apdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apda_m_t)
               LET g_log2 = util.JSON.stringify(g_apda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
              #150128-00005#1---Mark----
              ##141202-00061-15--(S)
              #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
              #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
              #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
              #   SELECT count(*) INTO l_count
              #     FROM apce_t
              #    WHERE apceent = g_enterprise 
              #      AND apceld = g_apdald_t AND apcedocno= g_apdadocno_t
              #   SELECT count(*) INTO l_count2
              #     FROM apde_t
              #    WHERE apdeent = g_enterprise 
              #      AND apdeld = g_apdald_t AND apdedocno= g_apdadocno_t
              #   #修改時 判斷是否有兩個單身都有資料 若有資料再重展單身
              #   IF l_count > 0 AND l_count2 > 0 THEN                        
              #      CALL s_transaction_begin()
              #      CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
              #           RETURNING g_sub_success
              #      IF g_sub_success THEN 
              #         CALL s_transaction_end('Y','0')
              #      ELSE
              #         CALL s_transaction_end('N','0')
              #      END IF
              #   END IF
              #END IF
              ##141202-00061-15--(E)
              #150128-00005#1---Mark----
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apdald_t = g_apda_m.apdald
            LET g_apdadocno_t = g_apda_m.apdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt823.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apce_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apce_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3','4',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apce_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            LET l_count = 0
            SELECT COUNT(*) INTO l_count FROM apce_t
             WHERE apceent = g_enterprise
               AND apceld  = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            
#            LET l_count2 = 0
#            SELECT COUNT(*) INTO l_count2 FROM apde_t
#             WHERE apdeent = g_enterprise
#               AND apdeld  = g_apda_m.apdald
#               AND apdedocno = g_apda_m.apdadocno
#            IF cl_null(l_count2)THEN LET l_count2 = 0 END IF            
                
            IF l_ask_flag = 'Y' THEN
               #自動產生
               IF cl_ask_confirm('axm-00013') THEN 
                  CALL aapt823_gen_detail()
               END IF
            END IF
            LET l_ask_flag = 'Y'
            CALL aapt823_show()
           
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            LET g_aw = 's_detail1'
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
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce_d[l_ac].apceseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apce_d_t.* = g_apce_d[l_ac].*  #BACKUP
               LET g_apce_d_o.* = g_apce_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL aapt823_set_no_required()
               CALL aapt823_set_required()
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apce_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl INTO g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                      g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                      g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                      g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                      g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                      g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apceseq, 
                      g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020, 
                      g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036, 
                      g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051, 
                      g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055, 
                      g_apce3_d[l_ac].apce056,g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059, 
                      g_apce3_d[l_ac].apce060,g_apce4_d[l_ac].apceseq,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121, 
                      g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apce_d_t.apceseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce_d_mask_o[l_ac].* =  g_apce_d[l_ac].*
                  CALL aapt823_apce_t_mask()
                  LET g_apce_d_mask_n[l_ac].* =  g_apce_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #取得來源組織所屬法人
            CALL s_fin_orga_get_comp_ld(g_apce_d[l_ac].apceorga) RETURNING g_sub_success,g_errno,l_apceorga_comp,l_apceorga_ld
            CALL s_ld_sel_glaa(l_apceorga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001
          
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
            INITIALIZE g_apce_d[l_ac].* TO NULL 
            INITIALIZE g_apce_d_t.* TO NULL 
            INITIALIZE g_apce_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_apce_d[l_ac].apce002 = "80"
      LET g_apce_d[l_ac].apce001 = "aapt823"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET l_gen_flag = 'N'
            #帶出借貸別(正負值)
            LET g_apce_d[l_ac].apce015 = s_fin_get_scc_value('8506',g_apce_d[l_ac].apce002,'1')    
            LET g_apce_d[l_ac].apcecomp = g_apda_m.apdacomp
           #LET g_apce_d[l_ac].apceorga = g_apda_m.apdacomp   #151029 mark
            LET g_apce_d[l_ac].apceorga = g_apda_m.apdasite   #151029 
            LET g_apce_d[l_ac].apceorga_desc = s_desc_get_department_desc(g_apce_d[l_ac].apceorga)
            DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc             
            LET g_apce_d[l_ac].apce048 = ' '
            #-150309apo--mark--(s)
            ##150106-00008#1-str--
            ##以上筆單身摘要作為預設值
            #IF l_ac > 1 THEN 
            #   LET g_apce_d[l_ac].apce010 = g_apce_d[l_ac-1].apce010
            #END IF
            ##150106-00008#1-end--  
            #-150309apo--mark--(e)
            #-150309apo--(s)
            LET l_cnt = 0
            SELECT COUNT(apceseq) INTO l_cnt FROM apce_t
             WHERE apceent   = g_enterprise
               AND apceld    = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno  
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF  
            IF l_cnt > 0 THEN
               #沿用上一筆付款單身的摘要
               SELECT apce010 INTO g_apce_d[l_ac].apce010 FROM apce_t
                WHERE apceent   = g_enterprise
                  AND apceld    = g_apda_m.apdald
                  AND apcedocno = g_apda_m.apdadocno
                  AND apceseq   = (SELECT MAX(apceseq) FROM apce_t WHERE apceent   = g_enterprise
                                                                     AND apceld    = g_apda_m.apdald
                                                                     AND apcedocno = g_apda_m.apdadocno )  
            END IF            
            #-150309apo--(e)
            #取得來源組織所屬法人
            CALL s_fin_orga_get_comp_ld(g_apce_d[l_ac].apceorga) RETURNING g_sub_success,g_errno,l_apceorga_comp,l_apceorga_ld            
            CALL s_ld_sel_glaa(l_apceorga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001              
            LET g_apce_d[l_ac].apcesite = g_apda_m.apdasite            
            IF g_glaa.glaa015 = 'Y' THEN
               LET g_apce4_d[l_ac].apce120 = g_glaa.glaa016  
            END IF      
            IF g_glaa.glaa019 = 'Y' THEN
               LET g_apce4_d[l_ac].apce130 = g_glaa.glaa020  
            END IF              
            #end add-point
            LET g_apce_d_t.* = g_apce_d[l_ac].*     #新輸入資料
            LET g_apce_d_o.* = g_apce_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            CALL aapt823_set_no_required()
            CALL aapt823_set_required()
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce_d[li_reproduce_target].apceseq = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_apce_d[l_ac].apceseq = NULL
            SELECT MAX(apceseq) INTO g_apce_d[l_ac].apceseq FROM apce_t
             WHERE apceent = g_enterprise
               AND apceld  = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
            IF cl_null(g_apce_d[l_ac].apceseq) THEN
               LET g_apce_d[l_ac].apceseq = 0 
            END IF            
            LET g_apce_d[l_ac].apceseq = g_apce_d[l_ac].apceseq + 1 
            

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
            #若該筆新增到一半啟動了自動新增ACIOTN,則正在新增的該筆視為放棄
            IF l_gen_flag = 'Y' THEN
               CONTINUE DIALOG
            END IF
            #150812-00010#3 --s
            IF cl_null(g_apce4_d[l_ac].apce129) THEN LET g_apce4_d[l_ac].apce129 = 0 END IF
            IF cl_null(g_apce4_d[l_ac].apce139) THEN LET g_apce4_d[l_ac].apce139 = 0 END IF
            IF g_apce_d[l_ac].apce109 = 0 AND g_apce_d[l_ac].apce119 = 0 AND
               g_apce4_d[l_ac].apce129 = 0 AND g_apce4_d[l_ac].apce139 = 0 THEN
               CANCEL INSERT               
            END IF
            #150812-00010#3 --e              
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apce_t 
             WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
 
               AND apceseq = g_apce_d[l_ac].apceseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce_d[g_detail_idx].apceseq
               CALL aapt823_insert_b('apce_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apce_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
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
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apce_d_t.apceseq
 
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apce_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce002
            #add-point:BEFORE FIELD apce002 name="input.b.page1.apce002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce002
            
            #add-point:AFTER FIELD apce002 name="input.a.page1.apce002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce002
            #add-point:ON CHANGE apce002 name="input.g.page1.apce002"
            LET g_apce_d[l_ac].apce015 = s_fin_get_scc_value('8506',g_apce_d[l_ac].apce002,'1')
          
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceorga
            
            #add-point:AFTER FIELD apceorga name="input.a.page1.apceorga"
            LET g_apce_d[l_ac].apceorga_desc = ' '
            DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
            IF NOT cl_null(g_apce_d[l_ac].apceorga) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apceorga != g_apce_d_t.apceorga OR g_apce_d_t.apceorga IS NULL )) THEN
#                  CALL s_fin_comp_chk(g_apce_d[l_ac].apceorga) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_apce_d[l_ac].apceorga = g_apce_d_t.apceorga
#                     LET g_apce_d[l_ac].apceorga_desc = s_desc_get_department_desc(g_apce_d[l_ac].apceorga)
#                     DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
#                     NEXT FIELD CURRENT
#                  END IF          
                  CALL aapt823_apceorga_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce_d[l_ac].apceorga,g_site_wc)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce_d[l_ac].apceorga = g_apce_d_t.apceorga
                     NEXT FIELD CURRENT
                  END IF
                  #取得來源組織所屬法人
                  CALL s_fin_orga_get_comp_ld(g_apce_d[l_ac].apceorga) RETURNING g_sub_success,g_errno,l_apceorga_comp,l_apceorga_ld            
                  CALL s_ld_sel_glaa(l_apceorga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001                     
                
               END IF
            ELSE
               LET l_apceorga_comp = ''
               LET l_apceorga_ld = ''
            END IF           
            LET g_apce_d[l_ac].apceorga_desc = s_desc_get_department_desc(g_apce_d[l_ac].apceorga)
            DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceorga
            #add-point:BEFORE FIELD apceorga name="input.b.page1.apceorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceorga
            #add-point:ON CHANGE apceorga name="input.g.page1.apceorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce003
            #add-point:BEFORE FIELD apce003 name="input.b.page1.apce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce003
            
            #add-point:AFTER FIELD apce003 name="input.a.page1.apce003"
            IF NOT cl_null(g_apce_d[l_ac].apce003) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apce003 != g_apce_d_t.apce003 OR g_apce_d_t.apce003 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce_d[l_ac].apce003 != g_apce_d_o.apce003 OR cl_null(g_apce_d_o.apce003) THEN                                      #160822-00008#4
                  IF NOT cl_null(g_apce_d[l_ac].apce004)
                     AND NOT cl_null(g_apce_d[l_ac].apce005) THEN    
                     IF NOT cl_null(g_apce_d[l_ac].apce003) AND NOT cl_null(g_apce_d[l_ac].apce004) AND 
                        NOT cl_null(g_apce_d[l_ac].apce005) THEN
#                        CALL s_aapt823_exist_chk(g_apce_d[l_ac].apce002,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apda_m.apda005,'') #151130-00015#4                        
#                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce003 = g_apce_d_t.apce003  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce003 = g_apce_d_o.apce003   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce003
                           NEXT FIELD CURRENT
                        END IF    
  
#                        #帶回開窗帳款單資訊                        
#                        CALL s_aapt823_source_doc_carry(g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,l_apceorga_ld,
#                                                                               g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apda_m.apdald,
#                                                                               g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048,g_sfin2002)
#                         RETURNING g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
#                                   g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,
#                                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,g_apce_d[l_ac].apce031,g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,
#                                   g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,
#                                   g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,
#                                   g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056,
#                                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060,l_nouse,
#                                   g_apce_d[l_ac].apce048   #151029
                        LET g_apce_d[l_ac].apce038_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce038)
                        LET g_apce_d[l_ac].apce061_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce061)
               
#                        #來源組織本幣與代付法人本幣不同            
#                        IF l_glaa001 <> g_glaa001 THEN            
#                           CALL aapt823_trans_to_local_curr(g_apce_d[l_ac].apce100,g_glaa001,g_apce_d[l_ac].apce109)
#                            RETURNING g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119
#                        END IF
#                        #檢核金額不可超出可沖金額                        
#                        CALL s_aapt823_apcc_used_chk(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                                                     g_apce_d[l_ac].apce109,g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1','0')
#                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce003 = g_apce_d_t.apce003  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce003 = g_apce_d_o.apce003   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce003
                           NEXT FIELD CURRENT
                        END IF
                        #帶預設會計科目                        
#                        LET g_apce_d[l_ac].apce016 = s_aapt823_bring_acc_code(l_apceorga_ld,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_sfin2002)                        
                        LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
                        DISPLAY BY NAME g_apce_d[l_ac].apce016 ,g_apce_d[l_ac].apce016_desc
                       
                     END IF
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
                            g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,
                            g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce038_desc,g_apce_d[l_ac].apce010,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce130,
                            g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce061_desc   #151029
            LET g_apce_d_o.* = g_apce_d[l_ac].*                #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce003
            #add-point:ON CHANGE apce003 name="input.g.page1.apce003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce004
            #add-point:BEFORE FIELD apce004 name="input.b.page1.apce004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce004
            
            #add-point:AFTER FIELD apce004 name="input.a.page1.apce004"
            IF NOT cl_null(g_apce_d[l_ac].apce004) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apce004 != g_apce_d_t.apce004 OR g_apce_d_t.apce004 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce_d[l_ac].apce004 != g_apce_d_o.apce004 OR cl_null(g_apce_d_o.apce004) THEN                                      #160822-00008#4
                  IF NOT cl_null(g_apce_d[l_ac].apce004)
                     AND NOT cl_null(g_apce_d[l_ac].apce005) THEN            
                     IF NOT cl_null(g_apce_d[l_ac].apce003) AND NOT cl_null(g_apce_d[l_ac].apce004) AND 
                        NOT cl_null(g_apce_d[l_ac].apce005) THEN
#                        CALL s_aapt823_exist_chk(g_apce_d[l_ac].apce002,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apda_m.apda005,'') #151130-00015#4
#                           RETURNING g_sub_success,g_errno                        
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce004 = g_apce_d_t.apce004  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce004 = g_apce_d_o.apce004   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce004
                           NEXT FIELD CURRENT
                        END IF                     

                        #帶回開窗帳款單資訊          
#                        CALL s_aapt823_source_doc_carry(g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,l_apceorga_ld,
#                                                                               g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apda_m.apdald,
#                                                                               g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048,g_sfin2002)                        
#                         RETURNING g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
#                                   g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,
#                                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,g_apce_d[l_ac].apce031,g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,
#                                   g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,
#                                   g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,
#                                   g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056,
#                                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060,l_nouse,
#                                   g_apce_d[l_ac].apce048   #151029
                        LET g_apce_d[l_ac].apce038_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce038)
                        LET g_apce_d[l_ac].apce061_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce061)
                     
                        ##來源組織本幣與代付法人本幣不同            
                        #IF l_glaa001 <> g_glaa001 THEN            
                        #   CALL aapt823_trans_to_local_curr(g_apce_d[l_ac].apce100,g_glaa001,g_apce_d[l_ac].apce109)
                        #    RETURNING g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119
                        #END IF
#                        #檢核金額不可超出可沖金額                        
#                        CALL s_aapt823_apcc_used_chk(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                                                     g_apce_d[l_ac].apce109,g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1','0')
#                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce004 = g_apce_d_t.apce004  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce004 = g_apce_d_o.apce004   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce004
                           NEXT FIELD CURRENT
                        END IF  
                        #帶預設會計科目                        
#                        LET g_apce_d[l_ac].apce016 = s_aapt823_bring_acc_code(l_apceorga_ld,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_sfin2002)                        
                        LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
                        DISPLAY BY NAME g_apce_d[l_ac].apce016 ,g_apce_d[l_ac].apce016_desc                    
                     END IF                     
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
                            g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,
                            g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce038_desc,g_apce_d[l_ac].apce010,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce130,
                            g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce061_desc   #151029
            LET g_apce_d_o.* = g_apce_d[l_ac].*                #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce004
            #add-point:ON CHANGE apce004 name="input.g.page1.apce004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce005
            #add-point:BEFORE FIELD apce005 name="input.b.page1.apce005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce005
            
            #add-point:AFTER FIELD apce005 name="input.a.page1.apce005"
            IF NOT cl_null(g_apce_d[l_ac].apce005) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apce005 != g_apce_d_t.apce005 OR g_apce_d_t.apce005 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce_d[l_ac].apce005 != g_apce_d_o.apce005 OR cl_null(g_apce_d_o.apce005) THEN                                      #160822-00008#4
                  IF NOT cl_null(g_apce_d[l_ac].apce004)
                     AND NOT cl_null(g_apce_d[l_ac].apce005) THEN   
                     IF NOT cl_null(g_apce_d[l_ac].apce003) AND NOT cl_null(g_apce_d[l_ac].apce004) AND 
                        NOT cl_null(g_apce_d[l_ac].apce005) THEN
#                        CALL s_aapt823_exist_chk(g_apce_d[l_ac].apce002,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apda_m.apda005,'') #151130-00015#4
#                           RETURNING g_sub_success,g_errno                           
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce005 = g_apce_d_t.apce005  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce005 = g_apce_d_o.apce005   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce005
                           NEXT FIELD CURRENT
                        END IF                      
            
                        #帶回開窗帳款單資訊          
#                        CALL s_aapt823_source_doc_carry(g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,l_apceorga_ld,
#                                                                               g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apda_m.apdald,
#                                                                               g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048,g_sfin2002)                                                
#                         RETURNING g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
#                                   g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,
#                                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,g_apce_d[l_ac].apce031,g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,
#                                   g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,
#                                   g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,
#                                   g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056,
#                                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060,l_nouse,
#                                   g_apce_d[l_ac].apce048   #151029
                        LET g_apce_d[l_ac].apce038_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce038)
                        LET g_apce_d[l_ac].apce061_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce061)
                   
                        ##來源組織本幣與代付法人本幣不同            
                        #IF l_glaa001 <> g_glaa001 THEN            
                        #   CALL aapt823_trans_to_local_curr(g_apce_d[l_ac].apce100,g_glaa001,g_apce_d[l_ac].apce109)
                        #    RETURNING g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119
                        #END IF
                        #檢核金額不可超出可沖金額                        
#                        CALL s_aapt823_apcc_used_chk(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                                                     g_apce_d[l_ac].apce109,g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1','0')
#                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce005 = g_apce_d_t.apce005  #160822-00008#4  mark
                           LET g_apce_d[l_ac].apce005 = g_apce_d_o.apce005   #160822-00008#4
                           DISPLAY BY NAME g_apce_d[l_ac].apce005
                           NEXT FIELD CURRENT
                        END IF    
                        #150921-00077--(S)
                        #帶預設會計科目                        
#                        LET g_apce_d[l_ac].apce016 = s_aapt823_bring_acc_code(l_apceorga_ld,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_sfin2002)                        
                        LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
                        DISPLAY BY NAME g_apce_d[l_ac].apce016 ,g_apce_d[l_ac].apce016_desc
                        #150921-00077--(E)
                     END IF
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,
                            g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,
                            g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce038_desc,g_apce_d[l_ac].apce010,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce130,
                            g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce061_desc   #151029
            LET g_apce_d_o.* = g_apce_d[l_ac].*                #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce005
            #add-point:ON CHANGE apce005 name="input.g.page1.apce005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_d[l_ac].apce109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce109
            END IF 
 
 
 
            #add-point:AFTER FIELD apce109 name="input.a.page1.apce109"
            IF NOT cl_null(g_apce_d[l_ac].apce109) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apce109 != g_apce_d_o.apce109 OR g_apce_d_o.apce109 IS NULL )) THEN
                  #檢核金額不可超出可沖金額 
#                  CALL s_aapt823_apcc_used_chk(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                                               g_apce_d[l_ac].apce109,g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1','0')
#                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce_d[l_ac].apce109 = g_apce_d_t.apce109
                     #160324-00032#3--s
                     LET g_apce_d[l_ac].apce119 = g_apce_d_t.apce119
                     LET g_apce4_d[l_ac].apce129 = g_apce4_d_t.apce129
                     LET g_apce4_d[l_ac].apce139 = g_apce4_d_t.apce139
                     DISPLAY BY NAME g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce139
                     #160324-00032#3--e
                     DISPLAY BY NAME g_apce_d[l_ac].apce109
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_apce_d[l_ac].apce101)THEN
                     #計算可用金額(原幣)
                     #如果=剩下全額就直接讓apce119 = 剩下全額
                     INITIALIZE l_apcc_used.* TO NULL
#                     CALL s_aapt823_apcc_used_num(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                     g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1')
#                         RETURNING g_sub_success,g_errno,l_apcc_used.apcc10x,l_apcc_used.apcc11x,l_apcc_used.apcc12x,l_apcc_used.apcc13x
                         
                     IF l_apcc_used.apcc10x = g_apce_d[l_ac].apce109 THEN
                        LET g_apce_d[l_ac].apce119 = l_apcc_used.apcc11x
                        IF g_glaa.glaa015 = 'Y' THEN
                           LET g_apce4_d[l_ac].apce129 = l_apcc_used.apcc12x
                        END IF
                        IF g_glaa.glaa019 = 'Y' THEN
                           LET g_apce4_d[l_ac].apce139 = l_apcc_used.apcc13x
                        END IF
                     ELSE                     
                        #部分又不是全額的話
                        #本幣金額
                        LET g_apce_d[l_ac].apce119 = g_apce_d[l_ac].apce109 * g_apce_d[l_ac].apce101
                        IF cl_null(g_apce_d[l_ac].apce119) THEN LET g_apce_d[l_ac].apce119 = 0 END IF
                        CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce_d[l_ac].apce119,2) RETURNING g_sub_success,g_errno,g_apce_d[l_ac].apce119   
                        #本位幣二金額
                        IF g_glaa.glaa015 = 'Y' THEN
                           LET g_apce4_d[l_ac].apce129 = g_apce_d[l_ac].apce109 * g_apce4_d[l_ac].apce121
                           IF cl_null(g_apce4_d[l_ac].apce129) THEN LET g_apce4_d[l_ac].apce129 = 0 END IF
                           CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa016,g_apce4_d[l_ac].apce129,2) RETURNING g_sub_success,g_errno,g_apce4_d[l_ac].apce129                         
                        END IF                        
                        #本位幣三金額
                        IF g_glaa.glaa019 = 'Y' THEN
                           LET g_apce4_d[l_ac].apce139 = g_apce_d[l_ac].apce109 * g_apce4_d[l_ac].apce131
                           IF cl_null(g_apce4_d[l_ac].apce139) THEN LET g_apce4_d[l_ac].apce139 = 0 END IF
                           CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa020,g_apce4_d[l_ac].apce139,2) RETURNING g_sub_success,g_errno,g_apce4_d[l_ac].apce139                          
                        END IF                        
                     END IF  
                     DISPLAY BY NAME g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce139
                  END IF
               END IF
            END IF
            LET g_apce_d_o.apce109 = g_apce_d[l_ac].apce109
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce109
            #add-point:BEFORE FIELD apce109 name="input.b.page1.apce109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce109
            #add-point:ON CHANGE apce109 name="input.g.page1.apce109"
            LET g_apce_d[l_ac].apce119 = g_apce_d[l_ac].apce109 * g_apce_d[l_ac].apce101
            IF cl_null(g_apce_d[l_ac].apce119) THEN LET g_apce_d[l_ac].apce119 = 0 END IF
            CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce_d[l_ac].apce119,2) RETURNING g_sub_success,g_errno,g_apce_d[l_ac].apce119                   
            DISPLAY BY NAME g_apce_d[l_ac].apce119
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_d[l_ac].apce119,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce119
            END IF 
 
 
 
            #add-point:AFTER FIELD apce119 name="input.a.page1.apce119"
            IF NOT cl_null(g_apce_d[l_ac].apce119) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce_d[l_ac].apce119 != g_apce_d_o.apce119 OR g_apce_d_o.apce119 IS NULL )) THEN
                  #檢核金額不可超出可沖金額
#                  CALL s_aapt823_apcc_used_chk(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                                               g_apce_d[l_ac].apce119,g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1','1')
#                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce_d[l_ac].apce119 = g_apce_d_t.apce119
                     #160324-00032#3--s
                     LET g_apce_d[l_ac].apce109 = g_apce_d_t.apce109
                     LET g_apce4_d[l_ac].apce129 = g_apce4_d_t.apce129
                     LET g_apce4_d[l_ac].apce139 = g_apce4_d_t.apce139
                     DISPLAY BY NAME g_apce_d[l_ac].apce109,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce139
                     #160324-00032#3--e                     
                     DISPLAY BY NAME g_apce_d[l_ac].apce119
                     NEXT FIELD CURRENT
                  END IF   
                  INITIALIZE l_apcc_used.* TO NULL
#                  CALL s_aapt823_apcc_used_num(g_apce_d[l_ac].apce002,g_apda_m.apdald,l_apceorga_ld,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,
#                  g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,'1')
#                      RETURNING g_sub_success,g_errno,l_apcc_used.apcc10x,l_apcc_used.apcc11x,l_apcc_used.apcc12x,l_apcc_used.apcc13x
                                             
                  IF l_apcc_used.apcc10x = g_apce_d[l_ac].apce109 THEN
                     LET g_apce_d[l_ac].apce119 = l_apcc_used.apcc11x
                     IF g_glaa.glaa015 = 'Y' THEN
                        LET g_apce4_d[l_ac].apce129 = l_apcc_used.apcc12x
                     END IF
                     IF g_glaa.glaa019 = 'Y' THEN
                        LET g_apce4_d[l_ac].apce139 = l_apcc_used.apcc13x
                     END IF                            
                  END IF
                  IF l_apcc_used.apcc11x = g_apce_d[l_ac].apce119 THEN
                     LET g_apce_d[l_ac].apce109 = l_apcc_used.apcc10x          
                     IF g_glaa.glaa015 = 'Y' THEN
                        LET g_apce4_d[l_ac].apce129 = l_apcc_used.apcc12x
                     END IF
                     IF g_glaa.glaa019 = 'Y' THEN
                        LET g_apce4_d[l_ac].apce139 = l_apcc_used.apcc13x
                     END IF                         
                  END IF                   
                  DISPLAY BY NAME g_apce_d[l_ac].apce119,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce139                      
               END IF
            END IF
            LET g_apce_d_o.apce119 = g_apce_d[l_ac].apce119            
        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce119
            #add-point:BEFORE FIELD apce119 name="input.b.page1.apce119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce119
            #add-point:ON CHANGE apce119 name="input.g.page1.apce119"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016
            
            #add-point:AFTER FIELD apce016 name="input.a.page1.apce016"
            #沖銷科目
            IF NOT cl_null(g_apce_d[l_ac].apce016) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apda_m.apdald,g_apce_d[l_ac].apce016,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apda_m.apdald
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apce_d[l_ac].apce016
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apce_d[l_ac].apce016
                LET g_qryparam.arg3 = g_apda_m.apdald
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_apce_d[l_ac].apce016 = g_qryparam.return1
            LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
            DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
         
              END IF
              IF NOT  s_aglt310_lc_subject(g_apda_m.apdald,g_apce_d[l_ac].apce016,'N') THEN
                  LET g_apce_d[l_ac].apce016      = g_apce_d_t.apce016
                     LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
                     DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
                     NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               #IF ( g_apce_d[l_ac].apce016 != g_apce_d_t.apce016 OR g_apce_d_t.apce016 IS NULL ) THEN  #160822-00008#4  mark
               IF g_apce_d[l_ac].apce016 != g_apce_d_o.apce016 OR cl_null(g_apce_d_o.apce016) THEN      #160822-00008#4
                  CALL s_aap_glac002_chk(g_apce_d[l_ac].apce016,g_apda_m.apdald) RETURNING g_sub_success,g_errno
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
                     #LET g_apce_d[l_ac].apce016      = g_apce_d_t.apce016   #160822-00008#4  mark
                     LET g_apce_d[l_ac].apce016      = g_apce_d_o.apce016    #160822-00008#4
                     LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
                     DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得自由核算項資訊
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*               
            ELSE
               INITIALIZE g_glad.* TO NULL
               LET g_apce_d[l_ac].apce016 = ''
            END IF
            LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
            DISPLAY BY NAME g_apce_d[l_ac].apce016 ,g_apce_d[l_ac].apce016_desc
            LET g_apce_d_o.* = g_apce_d[l_ac].*                #160822-00008#4

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016
            #add-point:BEFORE FIELD apce016 name="input.b.page1.apce016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce016
            #add-point:ON CHANGE apce016 name="input.g.page1.apce016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce010
            #add-point:BEFORE FIELD apce010 name="input.b.page1.apce010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce010
            
            #add-point:AFTER FIELD apce010 name="input.a.page1.apce010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce010
            #add-point:ON CHANGE apce010 name="input.g.page1.apce010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce002
            #add-point:ON ACTION controlp INFIELD apce002 name="input.c.page1.apce002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apceorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceorga
            #add-point:ON ACTION controlp INFIELD apceorga name="input.c.page1.apceorga"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apceorga
            LET g_qryparam.where    = "ooef001 IN ",g_site_wc,
                                      " AND ooef017 ='",g_apda_m.apdacomp,"' ",
                                      " AND ooef201 = 'Y'"   #161006-00005#8   add            
            CALL q_ooef001()
            LET g_apce_d[l_ac].apceorga = g_qryparam.return1
            CALL s_fin_orga_get_comp_ld(g_apce_d[l_ac].apceorga) RETURNING g_sub_success,g_errno,l_apceorga_comp,l_apceorga_ld            
            CALL s_ld_sel_glaa(l_apceorga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001                
            CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
            DISPLAY BY NAME g_apce_d[l_ac].apceorga,g_apce_d[l_ac].apceorga_desc
            NEXT FIELD apceorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce003
            #add-point:ON ACTION controlp INFIELD apce003 name="input.c.page1.apce003"
            LET l_apce010 = ''                       #151104
            LET l_apce010 = g_apce_d[l_ac].apce010   #151104
            #依帳款類型開窗
            IF NOT cl_null(l_apceorga_comp) THEN
#               CALL s_aapt823_source_doc_query(g_apda_m.apdald,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,l_apceorga_comp,g_apda_m.apda005,g_apda_m.apdadocdt,'') #151130-00015#4  #150622-00004#1 add ld
#                RETURNING l_wc   #150512-00036#1
                #RETURNING g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048   #150512-00036#1 mark
            ELSE
#               CALL s_aapt823_source_doc_query(g_apda_m.apdald,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apce003,g_apda_m.apdacomp,g_apda_m.apda005,g_apda_m.apdadocdt,'') #151130-00015#4  #150622-00004#1 add ld
#                RETURNING l_wc   #150512-00036#1
                #RETURNING g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048   #150512-00036#1 mark
            END IF
            #150512-00036#1--(S)
            #無選擇任何一筆
            IF g_qryparam.str_array.getLength() = 0 THEN
               NEXT FIELD apce003
            ELSE
               CALL cl_err_collect_init() 
               #寫入帳款單身
#               CALL s_aapt823_ins_payable_detail(g_apda_m.apdasite,g_apda_m.apdadocno,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apda005,
#                                                 g_apda_m.apdadocdt,g_sfin2002,l_wc,g_apce_d[l_ac].apce002[1,1]) RETURNING g_sub_success   
               #151104--s
               IF NOT cl_null(l_apce010) THEN
                  CALL aapt823_keep_memo(l_apce010)   
               END IF
               #151104--e
               IF NOT g_sub_success THEN
                  CALL cl_err_collect_show() 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL cl_err_collect_show()    
                  CALL s_transaction_end('Y','0')
               END IF  
               LET l_flag = 'Y'
               CALL aapt823_show()
               EXIT DIALOG               
            END IF              
            #150512-00036#1--(E)
            DISPLAY BY NAME g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce048
            NEXT FIELD apce003
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce004
            #add-point:ON ACTION controlp INFIELD apce004 name="input.c.page1.apce004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce005
            #add-point:ON ACTION controlp INFIELD apce005 name="input.c.page1.apce005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce109
            #add-point:ON ACTION controlp INFIELD apce109 name="input.c.page1.apce109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce119
            #add-point:ON ACTION controlp INFIELD apce119 name="input.c.page1.apce119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016
            #add-point:ON ACTION controlp INFIELD apce016 name="input.c.page1.apce016"
            #科目編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce016
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161115-00046#2 add
                                   " AND gladld='",g_apda_m.apdald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apce_d[l_ac].apce016 = g_qryparam.return1
            LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
            DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
            NEXT FIELD apce016
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce010
            #add-point:ON ACTION controlp INFIELD apce010 name="input.c.page1.apce010"
            #開窗i段
            #摘要
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce010
            CALL q_oocq002_2()
            LET g_apce_d[l_ac].apce010 = g_qryparam.return1
            DISPLAY g_apce_d[l_ac].apce010 TO apce010
            NEXT FIELD apce010     
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce_d[l_ac].* = g_apce_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apce_d[l_ac].apceseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apce_d[l_ac].* = g_apce_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt823_apce_t_mask_restore('restore_mask_o')
      
               UPDATE apce_t SET (apceld,apcedocno,apceseq,apce002,apceorga,apce003,apce004,apce005, 
                   apce061,apce038,apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010, 
                   apce031,apce049,apcecomp,apcesite,apce001,apce017,apce018,apce019,apce020,apce022, 
                   apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055, 
                   apce056,apce057,apce058,apce059,apce060,apce120,apce121,apce129,apce130,apce131,apce139) = (g_apda_m.apdald, 
                   g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                   g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                   g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                   g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                   g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                   g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apce017, 
                   g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce022, 
                   g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044, 
                   g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,g_apce3_d[l_ac].apce052, 
                   g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056, 
                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060, 
                   g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130, 
                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139)
                WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald 
                  AND apcedocno = g_apda_m.apdadocno 
 
                  AND apceseq = g_apce_d_t.apceseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce_d[l_ac].* = g_apce_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce_d[l_ac].* = g_apce_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce_d[g_detail_idx].apceseq
               LET gs_keys_bak[3] = g_apce_d_t.apceseq
               CALL aapt823_update_b('apce_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt823_apce_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apce_d[g_detail_idx].apceseq = g_apce_d_t.apceseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apce_d_t.apceseq
 
                  CALL aapt823_key_update_b(gs_keys,'apce_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt823_unlock_b("apce_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
            #回寫核銷單借貸金額
            CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo           
            CALL aapt823_sum_page_show()  #150212apo           
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce_d[li_reproduce_target].apceseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_apce2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apce2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','5','6',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            LET l_count = 0
            SELECT COUNT(*) INTO l_count FROM apce_t
             WHERE apceent = g_enterprise
               AND apceld  = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            
#            LET l_count2 = 0
#            SELECT COUNT(*) INTO l_count2 FROM apde_t
#             WHERE apdeent = g_enterprise
#               AND apdeld  = g_apda_m.apdald
#               AND apdedocno = g_apda_m.apdadocno
#            IF cl_null(l_count2)THEN LET l_count2 = 0 END IF            
           #150128-00005#9-mark--
           ##無資料則自動產生
           #IF l_count = 0 THEN            
           #   CALL aapt823_gen_detail()
           #END IF            
           #CALL aapt823_show()
           #150128-00005#9-mark--            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apce2_d[l_ac].* TO NULL 
            INITIALIZE g_apce2_d_t.* TO NULL 
            INITIALIZE g_apce2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_apce2_d[l_ac].apde002 = "10"
      LET g_apce2_d[l_ac].apde006 = "20"
      LET g_apce2_d[l_ac].apde001 = "aapt823"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET l_nmag002 = '1'   #款別為20:現金,帳戶運用類型指定為不限制
            LET g_apce2_d[l_ac].apde009 = 'N' 
            LET g_apce2_d[l_ac].apde015 = s_fin_get_scc_value('8506',g_apce2_d[l_ac].apde002,'1')   
            LET g_apce2_d[l_ac].apdecomp = g_apda_m.apdacomp
            LET g_apce2_d[l_ac].apdeorga = g_apda_m.apdasite
            LET g_apce2_d[l_ac].apdesite = g_apda_m.apdasite    #160324-00032#2
            LET g_apce2_d[l_ac].apde100 = g_glaa.glaa001
            #--150629-00028#1--(s)
            #預帶沖銷科目
            IF g_apce2_d[l_ac].apde006 ='30' THEN
               LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
            ELSE
               LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008)  

            END IF     
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc              
            #--150629-00028#1--(e)
            #--150309apo mark--(s)
            ##150106-00008#1-str--
            ##以上筆單身摘要作為預設值
            #IF l_ac > 1 THEN                                             
            #   LET g_apce2_d[l_ac].apde010 = g_apce2_d[l_ac-1].apde010   
            #END IF                                                     
            ##150106-00008#1-end--
            #--150309apo mark--(e)
            #150309apo--(s)
            LET l_cnt = 0
            SELECT COUNT(apdeseq) INTO l_cnt FROM apde_t
             WHERE apdeent   = g_enterprise
               AND apdeld    = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno  
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF  
            IF l_cnt = 0 THEN
               #預設帳款單身最大項次摘要給付款單身第一筆
               SELECT apce010 INTO g_apce2_d[l_ac].apde010 FROM apce_t
                WHERE apceent   = g_enterprise
                  AND apceld    = g_apda_m.apdald
                  AND apcedocno = g_apda_m.apdadocno
                  AND apceseq   = (SELECT MAX(apceseq) FROM apce_t WHERE apceent   = g_enterprise
                                                                     AND apceld    = g_apda_m.apdald
                                                                     AND apcedocno = g_apda_m.apdadocno )
            ELSE
               #沿用上一筆付款單身的摘要
               SELECT apde010 INTO g_apce2_d[l_ac].apde010 FROM apde_t
                WHERE apdeent   = g_enterprise
                  AND apdeld    = g_apda_m.apdald
                  AND apdedocno = g_apda_m.apdadocno
                  AND apdeseq   = (SELECT MAX(apdeseq) FROM apde_t WHERE apdeent   = g_enterprise
                                                                     AND apdeld    = g_apda_m.apdald
                                                                     AND apdedocno = g_apda_m.apdadocno )            
            END IF            
            #150309apo--(e)            
            #抓代付組織所屬法人
            LET l_ooef017 = ''
            SELECT ooef017 INTO l_ooef017
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apce2_d[l_ac].apdeorga
               AND ooefstus = 'Y'                 
            LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
            DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc                 
            LET g_apce2_d[l_ac].apdesite = g_apda_m.apdasite    
            LET g_apce2_d[l_ac].apde032 = g_apda_m.apdadocdt

            #付款對象在各筆帳款單身,因此不預帶付款銀行資訊
            LET g_apce2_d[l_ac].apde039 = ''
            LET g_apce2_d[l_ac].apde040 = ''               
            LET g_apce2_d[l_ac].apde041 = ''   
            DISPLAY BY NAME g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041 
            IF g_glaa.glaa015 = 'Y' THEN
               LET g_apce6_d[l_ac].apde120 = g_glaa.glaa016  
            END IF      
            IF g_glaa.glaa019 = 'Y' THEN
               LET g_apce6_d[l_ac].apde130 = g_glaa.glaa020  
            END IF   
            CALL s_aapt420_amt_default(g_apda_m.apdadocno,g_apda_m.apdald) RETURNING g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119,g_apce2_d[l_ac].apde101 
           
            #end add-point
            LET g_apce2_d_t.* = g_apce2_d[l_ac].*     #新輸入資料
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            CALL aapt823_set_no_required()
            CALL aapt823_set_required()
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce2_d[li_reproduce_target].apdeseq = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_apce2_d[l_ac].apdeseq = NULL
            SELECT MAX(apdeseq) INTO g_apce2_d[l_ac].apdeseq FROM apde_t
             WHERE apdeent = g_enterprise
               AND apdeld  = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno
            IF cl_null(g_apce2_d[l_ac].apdeseq) THEN
               LET g_apce2_d[l_ac].apdeseq = 0 
            END IF            
            LET g_apce2_d[l_ac].apdeseq = g_apce2_d[l_ac].apdeseq + 1 
            
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
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce2_d[l_ac].apdeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce2_d_t.* = g_apce2_d[l_ac].*  #BACKUP
               LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               CALL aapt823_set_no_required()
               CALL aapt823_set_required()
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apde_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl2 INTO g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002, 
                      g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021, 
                      g_apce2_d[l_ac].apde024,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101, 
                      g_apce2_d[l_ac].apde119,g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014, 
                      g_apce2_d[l_ac].apde015,g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009, 
                      g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011, 
                      g_apce2_d[l_ac].apde012,g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite, 
                      g_apce2_d[l_ac].apde001,g_apce5_d[l_ac].apdeseq,g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017, 
                      g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019,g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022, 
                      g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035,g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042, 
                      g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044,g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052, 
                      g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054,g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056, 
                      g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058,g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060, 
                      g_apce6_d[l_ac].apdeseq,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129, 
                      g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce2_d_mask_o[l_ac].* =  g_apce2_d[l_ac].*
                  CALL aapt823_apde_t_mask()
                  LET g_apce2_d_mask_n[l_ac].* =  g_apce2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"

            IF l_cmd = 'u' THEN
               CASE
                  WHEN g_apce2_d[l_ac].apde006 = '10'  #現金
                     LET l_nmag002 = '5'   #零用金
                  WHEN g_apce2_d[l_ac].apde006 = '20'  #銀行電匯款
                     LET l_nmag002 = '1'   #不限制
                  WHEN g_apce2_d[l_ac].apde006 = '30'  #票據
                     LET l_nmag002 = '4'   #票據往來
               END CASE
               #160122-00001#5 --add--str--
               #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
               CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
               DISPLAY BY NAME g_apce2_d[l_ac].lc_apde008
               #160122-00001#5 --add--end
            ELSE
               LET l_nmag002 =''
            END IF   
            #抓代付組織所屬法人
            LET l_ooef017 = ''
            SELECT ooef017 INTO l_ooef017
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apce2_d[l_ac].apdeorga
               AND ooefstus = 'Y'     
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
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apce2_d_t.apdeseq
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apde_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce2_d.getLength() + 1) THEN
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
            #150812-00010#3 --s
            IF cl_null(g_apce6_d[l_ac].apde129) THEN LET g_apce6_d[l_ac].apde129 = 0 END IF
            IF cl_null(g_apce6_d[l_ac].apde139) THEN LET g_apce6_d[l_ac].apde139 = 0 END IF
            IF g_apce2_d[l_ac].apde109 = 0 AND g_apce2_d[l_ac].apde119 = 0 AND
               g_apce6_d[l_ac].apde129 = 0 AND g_apce6_d[l_ac].apde139 = 0 THEN
               CANCEL INSERT               
            END IF
            #150812-00010#3 --e    
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno
               AND apdeseq = g_apce2_d[l_ac].apdeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce2_d[g_detail_idx].apdeseq
               CALL aapt823_insert_b('apde_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apce_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               CALL aapt823_b_fill()
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce2_d[l_ac].* = g_apce2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
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
               LET g_apce2_d[l_ac].* = g_apce2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt823_apde_t_mask_restore('restore_mask_o')
                              
               UPDATE apde_t SET (apdeld,apdedocno,apdeseq,apdeorga,apde002,apde006,apde003,apde008, 
                   apde021,apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016, 
                   apde010,apde009,apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite, 
                   apde001,apde038,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042, 
                   apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059, 
                   apde060,apde120,apde121,apde129,apde130,apde131,apde139) = (g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006, 
                   g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde024, 
                   g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119, 
                   g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde015, 
                   g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009,g_apce2_d[l_ac].apde039, 
                   g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012, 
                   g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite,g_apce2_d[l_ac].apde001, 
                   g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019, 
                   g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035, 
                   g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044, 
                   g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052,g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054, 
                   g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056,g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058, 
                   g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121, 
                   g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139)  
                   #自訂欄位頁簽
                WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
                  AND apdedocno = g_apda_m.apdadocno
                  AND apdeseq = g_apce2_d_t.apdeseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce2_d[l_ac].* = g_apce2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce2_d[l_ac].* = g_apce2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce2_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apce2_d_t.apdeseq
               CALL aapt823_update_b('apde_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce2_d[g_detail_idx].apdeseq = g_apce2_d_t.apdeseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce2_d_t.apdeseq
                  CALL aapt823_key_update_b(gs_keys,'apde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce2_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeorga
            
            #add-point:AFTER FIELD apdeorga name="input.a.page2.apdeorga"
            LET g_apce2_d[l_ac].apdeorga_desc = ' '
            DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc
            IF NOT cl_null(g_apce2_d[l_ac].apdeorga) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apdeorga != g_apce2_d_t.apdeorga OR g_apce2_d_t.apdeorga IS NULL )) THEN
#                  CALL s_fin_comp_chk(g_apce2_d[l_ac].apdeorga) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_apce2_d[l_ac].apdeorga = g_apce2_d_t.apdeorga
#                     LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
#                     DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc
#                     NEXT FIELD CURRENT
#                  END IF                             
                  CALL aapt823_apceorga_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeorga,g_site_wc)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce2_d[l_ac].apdeorga = g_apce2_d_t.apdeorga
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_apce2_d[l_ac].apdeorga,g_glaa.glaald,g_user,'6','Y','',g_today)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce2_d[l_ac].apdeorga = g_apce2_d_t.apdeorga
                     LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
                     DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc
                     NEXT FIELD CURRENT
                  END IF 
                  #抓所屬法人
                  LET l_ooef017 = ''
                  SELECT ooef017 INTO l_ooef017
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_apce2_d[l_ac].apdeorga
                     AND ooefstus = 'Y'                        
         
               END IF
              LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
              DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc
#              #帶出集團代收付基本資料
#              CALL aapt823_sel_apaf('2',g_apce2_d[l_ac].apdeorga)
#               RETURNING g_apce2_d[l_ac].apee005,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012
#              DISPLAY BY NAME g_apce2_d[l_ac].apee005,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012            
            END IF           

            LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
            DISPLAY BY NAME g_apce2_d[l_ac].apdeorga_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeorga
            #add-point:BEFORE FIELD apdeorga name="input.b.page2.apdeorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdeorga
            #add-point:ON CHANGE apdeorga name="input.g.page2.apdeorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="input.b.page2.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="input.a.page2.apde002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde002
            #add-point:ON CHANGE apde002 name="input.g.page2.apde002"
            LET g_apce2_d[l_ac].apde015 = s_fin_get_scc_value('8506',g_apce2_d[l_ac].apde002,'1')
            #非10,款別清空
            IF g_apce2_d[l_ac].apde002 <> '10' THEN
               LET g_apce2_d[l_ac].apde006 =''
            END IF
            CALL aapt823_set_entry_b(l_cmd)
            CALL aapt823_set_no_entry_b(l_cmd)   
            CALL aapt823_set_no_required()
            CALL aapt823_set_required()       
            #預帶沖銷科目
            IF g_apce2_d[l_ac].apde006 ='30' THEN
               LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
            ELSE
                LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008)
            END IF     
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc

            #付款對象在各筆帳款單身,因此不預帶付款銀行資訊
            LET g_apce2_d[l_ac].apde039 = ''
            LET g_apce2_d[l_ac].apde040 = ''               
            LET g_apce2_d[l_ac].apde041 = ''   
            DISPLAY BY NAME g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041 

            #付款類型為2*,則預帶轉入對象為付款對象           
            IF g_apce2_d[l_ac].apde002[1,1] ='2' THEN
               IF g_apce2_d[l_ac].apde002 = '20' THEN
                  IF cl_null(g_apce2_d[l_ac].apde014) THEN
                     CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
                     SELECT ooac004 INTO g_apce2_d[l_ac].apde014
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
            #add-point:BEFORE FIELD apde006 name="input.b.page2.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="input.a.page2.apde006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde006
            #add-point:ON CHANGE apde006 name="input.g.page2.apde006"
            CASE
               WHEN g_apce2_d[l_ac].apde006 = '10'  #現金
                  LET l_nmag002 = '5'   #零用金
               WHEN g_apce2_d[l_ac].apde006 = '20'  #銀行電匯款
                  LET l_nmag002 = '1'   #不限制
               WHEN g_apce2_d[l_ac].apde006 = '30'  #票據
                  LET l_nmag002 = '4'   #票據往來
               #150128-00005#9--(s)
               WHEN g_apce2_d[l_ac].apde006 = '90'  #其他類型
                 #LET g_apce2_d[l_ac].apde032 = g_today  #150212apo mark
                  LET g_apce2_d[l_ac].apde100 = g_glaa.glaa001
                  LET g_apce2_d[l_ac].apde101 = 1
               #150128-00005#9--(e)                   
            END CASE
       
            #付款對象在各筆帳款單身,因此不預帶付款銀行資訊
            LET g_apce2_d[l_ac].apde039 = ''
            LET g_apce2_d[l_ac].apde040 = ''               
            LET g_apce2_d[l_ac].apde041 = ''   
            DISPLAY BY NAME g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041     
                  
            CALL aapt823_set_entry_b(l_cmd)
            CALL aapt823_set_no_entry_b(l_cmd)
            CALL aapt823_set_no_required()
            CALL aapt823_set_required()     
            #預帶沖銷科目
            IF g_apce2_d[l_ac].apde006 ='30' THEN
               LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
            ELSE
                LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008) 
            END IF     
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc                   
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde003
            #add-point:BEFORE FIELD apde003 name="input.b.page2.apde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde003
            
            #add-point:AFTER FIELD apde003 name="input.a.page2.apde003"
            IF NOT cl_null(g_apce2_d[l_ac].apde003) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde003 != g_apce2_d_t.apde003 OR g_apce2_d_t.apde003 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde003 != g_apce2_d_o.apde003 OR cl_null(g_apce2_d_o.apde003) THEN                                      #160822-00008#4
                  CASE g_apce2_d[l_ac].apde002 
                     WHEN '10'    #付款
                       #CALL aapt823_apde003_chk(g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde006)RETURNING g_sub_success,g_errno   #160420-00001#11 mark
                        CALL aapt823_apde003_chk(g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde006)RETURNING g_sub_success,g_errno   #160420-00001#11 
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce2_d[l_ac].apde003 = g_apce2_d_t.apde003  #160822-00008#4  mark
                           LET g_apce2_d[l_ac].apde003 = g_apce2_d_o.apde003   #160822-00008#4
                           NEXT FIELD CURRENT
                        END IF
                        CALL aapt823_set_entry_b(l_cmd)
                        CALL aapt823_set_no_entry_b(l_cmd)               
                        CALL aapt823_nmck_carry(l_ooef017,g_apce2_d[l_ac].apde003)    
                        NEXT FIELD apde109                        
                     WHEN '16'   #收票轉付
                        CALL aapt823_apde003_chk_16(l_ooef017,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde024)RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160318-00005#2 --s add
                           LET g_errparam.replace[1] = 'anmt510'
                           LET g_errparam.replace[2] = cl_get_progname('anmt510',g_lang,"2")
                           LET g_errparam.exeprog = 'anmt510'
                           #160318-00005#2 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce2_d[l_ac].apde003 = g_apce2_d_t.apde003  #160822-00008#4  mark
                           LET g_apce2_d[l_ac].apde003 = g_apce2_d_o.apde003   #160822-00008#4
                           NEXT FIELD CURRENT
                        END IF
                        CALL aapt823_set_entry_b(l_cmd)
                        CALL aapt823_set_no_entry_b(l_cmd)               
                        CALL aapt823_nmbb_carry(l_ooef017,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde024)     
                        IF cl_null(g_apce2_d[l_ac].apde024) THEN 
                           NEXT FIELD apde024            
                        ELSE
                           NEXT FIELD apde101
                        END IF                           
                  END CASE
               END IF          
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde003
            #add-point:ON CHANGE apde003 name="input.g.page2.apde003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="input.b.page2.apde008"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="input.a.page2.apde008"
            IF NOT cl_null(g_apce2_d[l_ac].apde008) AND g_apce2_d[l_ac].apde002 <> '16' THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde008 != g_apce2_d_t.apde008 OR g_apce2_d_t.apde008 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde008 != g_apce2_d_o.apde008 OR cl_null(g_apce2_d_o.apde008) THEN                                      #160822-00008#4
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].apde008
                  LET g_chkparam.arg2 = g_apda_m.apdacomp
                  LET g_chkparam.arg3 = l_nmag002
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_nmas002_4") THEN
                     #檢查成功時後續處理
                      #160122-00001#5--add---str
                      IF NOT s_anmi120_nmll002_chk(g_apce2_d[l_ac].apde008,g_user) THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = g_apce2_d[l_ac].apde008
                         LET g_errparam.code   = 'anm-00574' 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         #LET g_apce2_d[l_ac].apde008 = g_apce2_d_t.apde008  #160822-00008#4  mark
                         LET g_apce2_d[l_ac].apde008 = g_apce2_d_o.apde008   #160822-00008#4
                         NEXT FIELD CURRENT
                      END IF
                      #160122-00001#5--add---end 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
                  #預帶帳戶幣別
                  LET g_apce2_d[l_ac].apde100 = s_anm_get_nmas003(g_apce2_d[l_ac].apde008)
                  DISPLAY BY NAME g_apce2_d[l_ac].apde100                  
                  CALL aapt823_trans_to_local_curr(g_apce2_d[l_ac].apde100)   #150930-00010#4
                  #預帶沖銷科目
                  IF cl_null(g_apce2_d[l_ac].apde016) THEN
                     IF g_apce2_d[l_ac].apde006 ='30' THEN
                        LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
                     ELSE
                        LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008)
                     END IF  
                     LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc                      
                  END IF  
                 
               END IF 
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde008
            #add-point:ON CHANGE apde008 name="input.g.page2.apde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_apde008
            #add-point:BEFORE FIELD lc_apde008 name="input.b.page2.lc_apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_apde008
            
            #add-point:AFTER FIELD lc_apde008 name="input.a.page2.lc_apde008"
            #160122-00001#5--add---str           
            IF NOT cl_null(g_apce2_d[l_ac].lc_apde008) AND g_apce2_d[l_ac].apde002 <> '16' THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].lc_apde008 != g_apce2_d_t.lc_apde008 OR g_apce2_d_t.lc_apde008 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].lc_apde008 != g_apce2_d_o.lc_apde008 OR cl_null(g_apce2_d_o.lc_apde008) THEN                                      #160822-00008#4
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].lc_apde008
                  LET g_chkparam.arg2 = g_apda_m.apdacomp
                  LET g_chkparam.arg3 = l_nmag002
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_nmas002_4") THEN
                     #檢查成功時後續處理

                      IF NOT s_anmi120_nmll002_chk(g_apce2_d[l_ac].lc_apde008,g_user) THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = g_apce2_d[l_ac].lc_apde008
                         LET g_errparam.code   = 'anm-00574' 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         #LET g_apce2_d[l_ac].lc_apde008 = g_apce2_d_t.lc_apde008  #160822-00008#4  mark
                         LET g_apce2_d[l_ac].lc_apde008 = g_apce2_d_o.lc_apde008   #160822-00008#4
                         NEXT FIELD CURRENT
                      END IF
                      LET g_apce2_d[l_ac].apde008 = g_apce2_d[l_ac].lc_apde008
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF

                  #預帶帳戶幣別
                  LET g_apce2_d[l_ac].apde100 = s_anm_get_nmas003(g_apce2_d[l_ac].lc_apde008)
                  DISPLAY BY NAME g_apce2_d[l_ac].apde100                  
                  CALL aapt823_trans_to_local_curr(g_apce2_d[l_ac].apde100)   #150930-00010#4
                  #預帶沖銷科目
                  IF cl_null(g_apce2_d[l_ac].apde016) THEN
                     IF g_apce2_d[l_ac].apde006 ='30' THEN
                        LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
                     ELSE
                        LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].lc_apde008)
                     END IF  
                     LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc                      
                  END IF  
                 
               END IF 
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            IF cl_null(g_apce2_d[l_ac].lc_apde008) AND NOT cl_null(g_apce2_d[l_ac].apde008) AND g_apce2_d[l_ac].apde002 <> '16' AND g_apce2_d[l_ac].lc_apde008="********"  THEN
               LET g_apce2_d[l_ac].lc_apde008 = g_apce2_d_t.lc_apde008
            END IF   
            #160122-00001#5--add---end             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_apde008
            #add-point:ON CHANGE lc_apde008 name="input.g.page2.lc_apde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde021
            #add-point:BEFORE FIELD apde021 name="input.b.page2.apde021"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde021
            
            #add-point:AFTER FIELD apde021 name="input.a.page2.apde021"
            IF NOT cl_null(g_apce2_d[l_ac].apde021) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde021 != g_apce2_d_t.apde021 OR g_apce2_d_t.apde021 IS NULL )) THEN   #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde021 != g_apce2_d_o.apde021 OR cl_null(g_apce2_d_o.apde021) THEN                                       #160822-00008#4
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].apde021
                  LET g_chkparam.arg2 = g_apce2_d[l_ac].apde006
                  LET g_chkparam.err_str[2] ="amm-00245:anm-00217"
                  IF NOT cl_chk_exist("v_ooia001_1") THEN
                     NEXT FIELD CURRENT
                  END IF
   
                  CALL aapt823_set_no_required()
                  CALL aapt823_set_required()
              
                  #預帶沖銷科目
                  IF g_apce2_d[l_ac].apde006 ='30' THEN
                     LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
                  ELSE
                     LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008)  
                  END IF    
                  LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
                  DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc             
               END IF
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*   #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde021
            #add-point:ON CHANGE apde021 name="input.g.page2.apde021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde024
            #add-point:BEFORE FIELD apde024 name="input.b.page2.apde024"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde024
            
            #add-point:AFTER FIELD apde024 name="input.a.page2.apde024"
            IF NOT cl_null(g_apce2_d[l_ac].apde024) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde024 != g_apce2_d_t.apde024 OR g_apce2_d_t.apde024 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde024 != g_apce2_d_o.apde024 OR cl_null(g_apce2_d_o.apde024) THEN                                      #160822-00008#4
                  CASE g_apce2_d[l_ac].apde002                     
                     WHEN '16'   #收票轉付
                        CALL aapt823_apde003_chk_16(l_ooef017,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde024)RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160318-00005#2 --s add
                           LET g_errparam.replace[1] = 'anmt510'
                           LET g_errparam.replace[2] = cl_get_progname('anmt510',g_lang,"2")
                           LET g_errparam.exeprog = 'anmt510'
                           #160318-00005#2 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce2_d[l_ac].apde024 = g_apce2_d_t.apde024  #160822-00008#4  mark
                           LET g_apce2_d[l_ac].apde024 = g_apce2_d_o.apde024   #160822-00008#4
                           NEXT FIELD CURRENT
                        END IF
                        CALL aapt823_set_entry_b(l_cmd)
                        CALL aapt823_set_no_entry_b(l_cmd)               
                        CALL aapt823_nmbb_carry(l_ooef017,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde024)     
                        NEXT FIELD apde101                                             
                  END CASE
               END IF          
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde024
            #add-point:ON CHANGE apde024 name="input.g.page2.apde024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="input.b.page2.apde100"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="input.a.page2.apde100"
            IF NOT cl_null(g_apce2_d[l_ac].apde100) THEN  
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde100 != g_apce2_d_t.apde100 OR g_apce2_d_t.apde100 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde100 != g_apce2_d_o.apde100 OR cl_null(g_apce2_d_o.apde100) THEN                                      #160822-00008#4
                  CALL s_aap_ooaj001_chk(g_apda_m.apdald,g_apce2_d[l_ac].apde100) RETURNING g_sub_success,g_errno
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
   
                     #LET g_apce2_d[l_ac].apde100 = g_apce2_d_t.apde100  #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde100 = g_apce2_d_o.apde100   #160822-00008#4
                     NEXT FIELD CURRENT
                  END IF            
                  #幣別變換時,重取本幣匯率與重算本幣金額
                  CALL aapt823_trans_to_local_curr(g_apce2_d[l_ac].apde100)            
               END IF
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde100
            #add-point:ON CHANGE apde100 name="input.g.page2.apde100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce2_d[l_ac].apde109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde109
            END IF 
 
 
 
            #add-point:AFTER FIELD apde109 name="input.a.page2.apde109"
            IF NOT cl_null(g_apce2_d[l_ac].apde109) THEN 
               IF NOT cl_null(g_apce2_d[l_ac].apde003) THEN             
                  CASE g_apce2_d[l_ac].apde002
                     WHEN '10'
                        CALL s_aapt420_nmck_used_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeseq,l_ooef017,
                                                     g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde109,'0') 
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce2_d[l_ac].apde109 = g_apce2_d_t.apde109  #160822-00008#4  mark
                           #LET g_apce2_d[l_ac].apde119 = g_apce2_d_t.apde119  #160822-00008#4  mark
                           LET g_apce2_d[l_ac].apde109 = g_apce2_d_o.apde109   #160822-00008#4
                           LET g_apce2_d[l_ac].apde119 = g_apce2_d_o.apde119   #160822-00008#4
                           DISPLAY BY NAME g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119
                           NEXT FIELD CURRENT
                        END IF           
                  END CASE             
                              
               END IF   
               #原幣
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,2) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde109                   
               DISPLAY BY NAME g_apce2_d[l_ac].apde109
               #本幣
               LET g_apce2_d[l_ac].apde119 = g_apce2_d[l_ac].apde109 *g_apce2_d[l_ac].apde101
               IF cl_null(g_apce2_d[l_ac].apde119) THEN LET g_apce2_d[l_ac].apde119 = 0 END IF
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce2_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde119                   
               DISPLAY BY NAME g_apce2_d[l_ac].apde119
               #本幣二
               IF g_glaa.glaa015 = 'Y' THEN
                  LET g_apce6_d[l_ac].apde129 = g_apce2_d[l_ac].apde109 *g_apce6_d[l_ac].apde121
                  IF cl_null(g_apce6_d[l_ac].apde129) THEN LET g_apce6_d[l_ac].apde129 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde129                   
                  DISPLAY BY NAME g_apce6_d[l_ac].apde129            
               END IF
               #本幣三
               IF g_glaa.glaa019 = 'Y' THEN
                  LET g_apce6_d[l_ac].apde139 = g_apce2_d[l_ac].apde109 *g_apce6_d[l_ac].apde131
                  IF cl_null(g_apce6_d[l_ac].apde139) THEN LET g_apce6_d[l_ac].apde139 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde139                   
                  DISPLAY BY NAME g_apce6_d[l_ac].apde139            
               END IF                  
               #CALL aapt823_trans_to_local_curr(g_apce2_d[l_ac].apde100,g_glaa.glaa001,g_apce2_d[l_ac].apde109)            
               # RETURNING g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119                 
               #DISPLAY BY NAME g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119                
            END IF 
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4

            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="input.b.page2.apde109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde109
            #add-point:ON CHANGE apde109 name="input.g.page2.apde109"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce2_d[l_ac].apde101,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde101
            END IF 
 
 
 
            #add-point:AFTER FIELD apde101 name="input.a.page2.apde101"
            IF NOT cl_null(g_apce2_d[l_ac].apde101) THEN 
               #IF cl_null(g_apce2_d_t.apde101) OR (g_apce2_d_t.apde101 <> g_apce2_d[l_ac].apde101)THEN  #160822-00008#4  mark
               IF cl_null(g_apce2_d_o.apde101) OR (g_apce2_d[l_ac].apde101 <> g_apce2_d_o.apde101)THEN   #160822-00008#4
                  #匯率取位
                  IF cl_null(g_apce2_d[l_ac].apde101) THEN LET g_apce2_d[l_ac].apde101 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce2_d[l_ac].apde101,3) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde101  #160829-00004#1 mark
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde101,3) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde101  #160829-00004#1
                  #本幣重計
                  LET g_apce2_d[l_ac].apde119 = g_apce2_d[l_ac].apde109 * g_apce2_d[l_ac].apde101
                  IF cl_null(g_apce2_d[l_ac].apde119) THEN LET g_apce2_d[l_ac].apde119 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce2_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde119                    
               END IF            
            END IF 
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde101
            #add-point:BEFORE FIELD apde101 name="input.b.page2.apde101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde101
            #add-point:ON CHANGE apde101 name="input.g.page2.apde101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce2_d[l_ac].apde119,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde119
            END IF 
 
 
 
            #add-point:AFTER FIELD apde119 name="input.a.page2.apde119"
            IF NOT cl_null(g_apce2_d[l_ac].apde119) THEN 
               #本幣
               IF cl_null(g_apce2_d[l_ac].apde119) THEN LET g_apce2_d[l_ac].apde119 = 0 END IF
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce2_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde119                   
               DISPLAY BY NAME g_apce2_d[l_ac].apde119                  
               IF NOT cl_null(g_apce2_d[l_ac].apde003) THEN
                  CASE g_apce2_d[l_ac].apde002
                     WHEN '10'               
                        CALL s_aapt420_nmck_used_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeseq,l_ooef017,
                                                     g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde119,'1') 
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce2_d[l_ac].apde119 = g_apce2_d_t.apde119  #160822-00008#4  mark
                           LET g_apce2_d[l_ac].apde119 = g_apce2_d_o.apde119   #160822-00008#4
                           DISPLAY BY NAME g_apce2_d[l_ac].apde119
                           NEXT FIELD CURRENT
                        END IF         
                  END CASE                    
               END IF              
            END IF 
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde119
            #add-point:BEFORE FIELD apde119 name="input.b.page2.apde119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde119
            #add-point:ON CHANGE apde119 name="input.g.page2.apde119"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="input.b.page2.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="input.a.page2.apde032"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde032
            #add-point:ON CHANGE apde032 name="input.g.page2.apde032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde013
            
            #add-point:AFTER FIELD apde013 name="input.a.page2.apde013"
            LET g_apce2_d[l_ac].apde013_desc = ' '
            DISPLAY BY NAME g_apce2_d[l_ac].apde013_desc            
            IF NOT cl_null(g_apce2_d[l_ac].apde013) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde013 != g_apce2_d_t.apde013 OR g_apce2_d_t.apde013 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde013 != g_apce2_d_o.apde013 OR cl_null(g_apce2_d_o.apde013) THEN                                      #160822-00008#4
                  CALL s_aap_apca005_chk(g_apce2_d[l_ac].apde013)RETURNING g_sub_success,g_errno
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
#                     LET g_apce2_d[l_ac].apde013 = g_apce2_d_t.apde013
#                     CALL s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde013) RETURNING g_apce2_d[l_ac].apde013_desc
#                     DISPLAY BY NAME g_apce2_d[l_ac].apde013_desc
#                     NEXT FIELD CURRENT
                  END IF
                  #對象以付款單身轉入對象給予
                  LET g_apce5_d[l_ac].apde038 = g_apce2_d[l_ac].apde013
                  DISPLAY BY NAME g_apce5_d[l_ac].apde038
                  
               END IF
            END IF
          
            LET g_apce2_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde013)
            DISPLAY BY NAME g_apce2_d[l_ac].apde013_desc
            LET g_apce5_d_o.* = g_apce5_d[l_ac].*   #160822-00008#4
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*   #160822-00008#4

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde013
            #add-point:BEFORE FIELD apde013 name="input.b.page2.apde013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde013
            #add-point:ON CHANGE apde013 name="input.g.page2.apde013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde014
            #add-point:BEFORE FIELD apde014 name="input.b.page2.apde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde014
            
            #add-point:AFTER FIELD apde014 name="input.a.page2.apde014"
            IF NOT cl_null(g_apce2_d[l_ac].apde014) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde014 != g_apce2_d_t.apde014 OR g_apce2_d_t.apde014 IS NULL )) THEN
                  IF g_apce2_d[l_ac].apde002 = '22' OR g_apce2_d[l_ac].apde002 = '21' OR g_apce2_d[l_ac].apde002 = '20'THEN
                    #CALL cl_get_doc_para(g_enterprise,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apde014,'D-FIN-0030') RETURNING l_chr
                    CALL s_fin_get_doc_para(g_apda_m.apdald,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apde014,'D-FIN-0030') RETURNING l_chr
                     IF l_chr = 'Y' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00237'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apce2_d[l_ac].apde014 = g_apce2_d_t.apde014
                        NEXT FIELD CURRENT                  
                     END IF
                  END IF
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde014
            #add-point:ON CHANGE apde014 name="input.g.page2.apde014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde016
            
            #add-point:AFTER FIELD apde016 name="input.a.page2.apde016"
            #沖銷科目
            IF NOT cl_null(g_apce2_d[l_ac].apde016) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apda_m.apdald,g_apce2_d[l_ac].apde016,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apda_m.apdald
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apce2_d[l_ac].apde016
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apce2_d[l_ac].apde016
                LET g_qryparam.arg3 = g_apda_m.apdald
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_apce2_d[l_ac].apde016 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde016_desc
              END IF
              IF NOT  s_aglt310_lc_subject(g_apda_m.apdald,g_apce2_d[l_ac].apde016,'N') THEN
                  #LET g_apce2_d[l_ac].apde016      = g_apce2_d_t.apde016  #160822-00008#4  mark
                  LET g_apce2_d[l_ac].apde016      = g_apce2_d_o.apde016   #160822-00008#4
                     LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde016_desc
                     NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END 
               #IF ( g_apce2_d[l_ac].apde016 != g_apce2_d_t.apde016 OR g_apce2_d_t.apde016 IS NULL ) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde016 != g_apce2_d_o.apde016 OR cl_null(g_apce2_d_o.apde016) THEN      #160822-00008#4
                  CALL s_aap_glac002_chk(g_apce2_d[l_ac].apde016,g_apda_m.apdald) RETURNING g_sub_success,g_errno
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
                     #LET g_apce2_d[l_ac].apde016      = g_apce2_d_t.apde016  #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde016      = g_apce2_d_o.apde016   #160822-00008#4
                     LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得自由核算項資訊
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*                 
            ELSE
               INITIALIZE g_glad.* TO NULL
               LET g_apce2_d[l_ac].apde016 = ''
            END IF
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016 ,g_apce2_d[l_ac].apde016_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde016
            #add-point:BEFORE FIELD apde016 name="input.b.page2.apde016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde016
            #add-point:ON CHANGE apde016 name="input.g.page2.apde016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="input.b.page2.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="input.a.page2.apde010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde010
            #add-point:ON CHANGE apde010 name="input.g.page2.apde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde039
            #add-point:BEFORE FIELD apde039 name="input.b.page2.apde039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde039
            
            #add-point:AFTER FIELD apde039 name="input.a.page2.apde039"
#            LET g_apce2_d[l_ac].apde039_desc = ' '
#            DISPLAY BY NAME g_apce2_d[l_ac].apde039_desc            
            IF NOT cl_null(g_apce2_d[l_ac].apde039) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde039 != g_apce2_d_t.apde039 OR g_apce2_d_t.apde039 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde039 != g_apce2_d_o.apde039 OR cl_null(g_apce2_d_o.apde039) THEN                                      #160822-00008#4
                  CALL s_aapt420_pmaf002_chk('',g_apce2_d[l_ac].apde039)RETURNING g_sub_success,g_errno
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

                     #LET g_apce2_d[l_ac].apde039 = g_apce2_d_t.apde039  #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde039 = g_apce2_d_o.apde039   #160822-00008#4
#                     CALL s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde039) RETURNING g_apce2_d[l_ac].apde039_desc
#                     DISPLAY BY NAME g_apce2_d[l_ac].apde039_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
          
#            LET g_apce2_d[l_ac].apde039_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde039)
#            DISPLAY BY NAME g_apce2_d[l_ac].apde039_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde039
            #add-point:ON CHANGE apde039 name="input.g.page2.apde039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde040
            #add-point:BEFORE FIELD apde040 name="input.b.page2.apde040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde040
            
            #add-point:AFTER FIELD apde040 name="input.a.page2.apde040"
#            LET g_apce2_d[l_ac].apde040_desc = ' '
#            DISPLAY BY NAME g_apce2_d[l_ac].apde040_desc            
            IF NOT cl_null(g_apce2_d[l_ac].apde040) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde040 != g_apce2_d_t.apde040 OR g_apce2_d_t.apde040 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde040 != g_apce2_d_o.apde040 OR cl_null(g_apce2_d_o.apde040) THEN                                      #160822-00008#4
                  CALL s_aapt420_pmaf003_chk2('',g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040)RETURNING g_sub_success,g_errno  
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

                     #LET g_apce2_d[l_ac].apde040 = g_apce2_d_t.apde040   #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde040 = g_apce2_d_o.apde040    #160822-00008#4
#                     CALL s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde040) RETURNING g_apce2_d[l_ac].apde040_desc
#                     DISPLAY BY NAME g_apce2_d[l_ac].apde040_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#4
          
#            LET g_apce2_d[l_ac].apde040_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde040)
#            DISPLAY BY NAME g_apce2_d[l_ac].apde040_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde040
            #add-point:ON CHANGE apde040 name="input.g.page2.apde040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde041
            #add-point:BEFORE FIELD apde041 name="input.b.page2.apde041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde041
            
            #add-point:AFTER FIELD apde041 name="input.a.page2.apde041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde041
            #add-point:ON CHANGE apde041 name="input.g.page2.apde041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="input.a.page2.apde011"
            LET g_apce2_d[l_ac].apde011_desc=''
            LET g_apce2_d[l_ac].apde012_desc = ''
            DISPLAY BY NAME g_apce2_d[l_ac].apde011_desc,g_apce2_d[l_ac].apde012_desc
            IF NOT cl_null(g_apce2_d[l_ac].apde011) THEN

               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde011 != g_apce2_d_t.apde011 OR g_apce2_d_t.apde011 IS NULL )) THEN   #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde011 != g_apce2_d_o.apde011 OR cl_null(g_apce2_d_o.apde011) THEN                                       #160822-00008#4
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].apde011
                  LET g_chkparam.arg2 = 2
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                     #LET g_apce2_d[l_ac].apde011 = g_apce2_d_t.apde011  #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde011 = g_apce2_d_o.apde011   #160822-00008#4
                     LET g_apce2_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apce2_d[l_ac].apde011)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde012
                     LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
                     LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde011_desc,g_apce2_d[l_ac].apde012_desc                     
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
               LET g_apce2_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apce2_d[l_ac].apde011)
               DISPLAY BY NAME g_apce2_d[l_ac].apde012
               LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
               LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
               DISPLAY BY NAME g_apce2_d[l_ac].apde011_desc,g_apce2_d[l_ac].apde012_desc               
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*   #160822-00008#4
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="input.b.page2.apde011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde011
            #add-point:ON CHANGE apde011 name="input.g.page2.apde011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="input.a.page2.apde012"
            LET g_apce2_d[l_ac].apde012_desc=''
            DISPLAY BY NAME g_apce2_d[l_ac].apde012_desc            
            IF NOT cl_null(g_apce2_d[l_ac].apde012) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apce2_d[l_ac].apde012 != g_apce2_d_t.apde012 OR g_apce2_d_t.apde012 IS NULL )) THEN  #160822-00008#4  mark
               IF g_apce2_d[l_ac].apde012 != g_apce2_d_o.apde012 OR cl_null(g_apce2_d_o.apde012) THEN                                      #160822-00008#4

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].apde012
                  LET g_chkparam.arg2 = g_glaa.glaa005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     #LET g_apce2_d[l_ac].apde012 = g_apce2_d_t.apde012  #160822-00008#4  mark
                     LET g_apce2_d[l_ac].apde012 = g_apce2_d_o.apde012   #160822-00008#4
                     LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
                     DISPLAY BY NAME g_apce2_d[l_ac].apde012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
               DISPLAY BY NAME g_apce2_d[l_ac].apde012_desc
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*   #160822-00008#4
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="input.b.page2.apde012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde012
            #add-point:ON CHANGE apde012 name="input.g.page2.apde012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apdeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeorga
            #add-point:ON ACTION controlp INFIELD apdeorga name="input.c.page2.apdeorga"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdeorga             #給予default值
           #LET g_qryparam.where = " ooef206 = 'Y' AND ooef001 IN ",g_site_wc, " AND ooef017 ='",g_apda_m.apdacomp,"' "    #150128-00005#1 Mark          
            LET g_qryparam.where = " ooef001 IN ",g_site_wc, " AND ooef017 ='",g_apda_m.apdacomp,"' "                      #150128-00005#1
            #CALL q_ooef001()     #161006-00005#8   mark
            CALL q_ooef001_33()   #161006-00005#8   add                                 #呼叫開窗

            LET g_apce2_d[l_ac].apdeorga = g_qryparam.return1              
            DISPLAY g_apce2_d[l_ac].apdeorga TO apdeorga             
            CALL s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga) RETURNING g_apce2_d[l_ac].apdeorga_desc
            DISPLAY BY NAME g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apdeorga_desc
            NEXT FIELD apdeorga                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="input.c.page2.apde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="input.c.page2.apde006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde003
            #add-point:ON ACTION controlp INFIELD apde003 name="input.c.page2.apde003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde003     #給予default值            
            CASE g_apce2_d[l_ac].apde002 
               WHEN '10' 
                  LET g_qryparam.where = " NOT EXISTS ",
                                         "    (SELECT 1 FROM apde_t WHERE apdeent = nmckent ",
                                         "        AND apdeorga = nmcksite ",
                                         "        AND apde003 = nmckdocno ",
                                         "        AND apdedocno = '",g_apda_m.apdadocno,"')"
                 #161115-00046#2 --s add            
                 IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                    LET g_qryparam.where = g_qryparam.where, " AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                             "            WHERE pmaaent = ",g_enterprise,
                                                             "              AND ",g_sql_ctrl,
                                                             "              AND pmaaent = nmckent ",
                                                             "              AND pmaa001 = nmck005 )"
                 END IF            
                 #161115-00046#2 --e add
                 #160420-00001#11--mod--s
                 #LET g_qryparam.arg1 = g_apce2_d[l_ac].apdeorga
                  LET g_qryparam.arg1 = g_apce2_d[l_ac].apdecomp
                  LET g_qryparam.arg2 = g_apce2_d[l_ac].apde006
                  LET g_qryparam.arg3 = '%'          
                 #CALL q_nmckdocno_2()
                  CALL q_nmckdocno_5() 
                 #160420-00001#11--mod--e
                  LET g_apce2_d[l_ac].apde003 = g_qryparam.return1      #將開窗取得的值回傳到變數
                  DISPLAY BY NAME g_apce2_d[l_ac].apde003               #顯示到畫面上                  
               WHEN '16'
                  LET g_qryparam.where = " NOT EXISTS ",
                                         "    (SELECT 1 FROM apde_t WHERE apdeent = nmbaent ",
                                         "        AND apdecomp = nmbacomp ",
                                         "        AND apde003 = nmbadocno )" 
                  #161115-00046#2 --s add            
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = g_qryparam.where, " AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                              "            WHERE pmaaent = ",g_enterprise,
                                                              "              AND ",g_sql_ctrl,
                                                              "              AND pmaaent = nmbaent ",
                                                              "              AND pmaa001 = nmba004 )"
                  END IF            
                  #161115-00046#2 --e add                                         
                  LET g_qryparam.arg1 = g_apda_m.apdacomp
                  
                 #CALL q_nmbadocno_3()   #160419-00040#1 mark
                  CALL q_nmbadocno_5()   #160419-00040#1
                  LET g_apce2_d[l_ac].apde024 = g_qryparam.return1                   #將開窗取得的值回傳到變數
                  LET g_apce2_d[l_ac].apde003 = g_qryparam.return2    
                  DISPLAY BY NAME g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde024    #顯示到畫面上                  
            END CASE
            NEXT FIELD apde003                                   #返回原欄位            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="input.c.page2.apde008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL               
            LET g_qryparam.reqry = FALSE                 
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde008             #給予default值            
            CASE g_apce2_d[l_ac].apde002
               WHEN '10'
                  #開窗i段
                  #給予arg
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  
                  LET g_qryparam.default1 = g_apce2_d[l_ac].apde008             #給予default值
                  #160122-00001#5 mrak
#                  LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#                                         "              AND ooef017 = '",g_apda_m.apdacomp,"')",                  
#                                         " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
#                                         " AND nmag002 IN ('1','",l_nmag002,"'))"
                  #160122-00001#5 -add -str 
                  LET g_qryparam.where =  " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                          "              AND ooef017 = '",g_apda_m.apdacomp,"')",                   
                                          #" AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",                                 #170123-00010#1 mark
                                          " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmagent = '",g_enterprise,"' AND nmag001 = nmaa003 ", #170123-00010#1 add
                                          " AND nmag002 IN ('1','",l_nmag002,"'))",
                                          " AND nmas002 IN (",g_sql_bank,")"
                  #160122-00001#5 -add -end
                  CALL q_nmas_01()                                #呼叫開窗
                  LET g_apce2_d[l_ac].apde008 = g_qryparam.return1
                  LET g_apce2_d[l_ac].apde100 = s_anm_get_nmas003(g_apce2_d[l_ac].apde008)
                  DISPLAY BY NAME g_apce2_d[l_ac].apde100                           
  
#               WHEN '16'         
#                  #給予arg
#                  LET g_qryparam.state = 'c'
#                  LET g_qryparam.arg1 = g_apda_m.apdasite         #帳務中心(接收,暫不處理)
#                  LET g_qryparam.arg2 = ''                        #核銷客戶
#                  LET g_qryparam.arg3 = g_apda_m.apda005          #收款客戶
#                  LET g_qryparam.arg4 = g_apda_m.apdacomp         #來源組織(接收,暫不處理)
#                  LET g_qryparam.arg5 = g_apda_m.apdald           #帳套                  
#                  LET g_qryparam.where = " nmbb029 = '",g_apce2_d[l_ac].apde006,"'" #款別                  
#                  CALL axrt400_07()  
#                  LET l_ar_condition = '' 
#                  LET l_ar_condition = g_qryparam.return1
#                  CALL aapt823_bring_ar(g_qryparam.return1) RETURNING g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119
#                  DISPLAY BY NAME g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119
                  
#               WHEN '17'                                          
#                  LET g_qryparam.arg1 = g_apda_m.apdasite         #帳務中心(接收,暫不處理)
#                  LET g_qryparam.arg2 = ''                        #核銷客戶
#                  LET g_qryparam.arg3 = g_apda_m.apda005          #收款客戶
#                  LET g_qryparam.arg4 = g_apda_m.apdacomp         #來源組織(接收,暫不處理)
#                  LET g_qryparam.arg5 = g_apda_m.apdald           #帳套                  
#                  LET g_qryparam.where = " nmbb029 = '",g_apce2_d[l_ac].apde006,"'" #款別
#                  CALL axrt400_07()                               
            END CASE
            
   
            DISPLAY g_apce2_d[l_ac].apde008 TO apde008 
            NEXT FIELD apde008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.lc_apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_apde008
            #add-point:ON ACTION controlp INFIELD lc_apde008 name="input.c.page2.lc_apde008"
            #160122-00001#5 -add -str 
            INITIALIZE g_qryparam.* TO NULL               
            LET g_qryparam.reqry = FALSE                 
            LET g_qryparam.default1 = g_apce2_d[l_ac].lc_apde008             #給予default值            
            CASE g_apce2_d[l_ac].apde002
               WHEN '10'
                  #開窗i段
                  #給予arg
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  
                  LET g_qryparam.default1 = g_apce2_d[l_ac].lc_apde008             #給予default值
                  LET g_qryparam.where =  " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                          "              AND ooef017 = '",g_apda_m.apdacomp,"')",                  
                                          #" AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",                                 #170123-00010#1 mark
                                          " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmagent = '",g_enterprise,"' AND nmag001 = nmaa003 ", #170123-00010#1 add
                                          " AND nmag002 IN ('1','",l_nmag002,"'))",
                                          " AND nmas002 IN (",g_sql_bank,")"

                  CALL q_nmas_01()                                #呼叫開窗
                  LET g_apce2_d[l_ac].lc_apde008 = g_qryparam.return1
                  LET g_apce2_d[l_ac].apde100 = s_anm_get_nmas003(g_apce2_d[l_ac].lc_apde008)
                  DISPLAY BY NAME g_apce2_d[l_ac].apde100                           
                             
            END CASE
            
   
            DISPLAY g_apce2_d[l_ac].lc_apde008 TO lc_apde008 
            NEXT FIELD lc_apde008                          #返回原欄位
            #160122-00001#5 -add -end
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde021
            #add-point:ON ACTION controlp INFIELD apde021 name="input.c.page2.apde021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde021     #給予default值
            LET g_qryparam.where = " ooia002 = '",g_apce2_d[l_ac].apde006,"'",
                                   " AND ooiaent = '",g_enterprise,"'"
            CALL q_ooia001()                                      #呼叫開窗

            LET g_apce2_d[l_ac].apde021 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_apce2_d[l_ac].apde021               #顯示到畫面上
            NEXT FIELD apde021                                    #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde024
            #add-point:ON ACTION controlp INFIELD apde024 name="input.c.page2.apde024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="input.c.page2.apde100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooaj001='",g_glaa.glaa026,"' "
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde100             #給予default值
            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_apce2_d[l_ac].apde100 = g_qryparam.return1              

            DISPLAY g_apce2_d[l_ac].apde100 TO apde100              #

            NEXT FIELD apde100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="input.c.page2.apde109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde101
            #add-point:ON ACTION controlp INFIELD apde101 name="input.c.page2.apde101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde119
            #add-point:ON ACTION controlp INFIELD apde119 name="input.c.page2.apde119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="input.c.page2.apde032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde013
            #add-point:ON ACTION controlp INFIELD apde013 name="input.c.page2.apde013"
            #付款對象
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde013
            LET g_qryparam.arg1 = "1"                         #交易類型
            #LET g_qryparam.where = " pmac001 = '",g_apda_m.apda005,"' "            #150427apo mark
            #161115-00046#2 --s add
			   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent ",
                                      "            AND pmaa001 = pmac002 )"
            END IF
            #161115-00046#2 --e add
            CALL q_pmac002_10()
            LET g_apce2_d[l_ac].apde013 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde013)
            DISPLAY BY NAME g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde013_desc
            NEXT FIELD apde013
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde014
            #add-point:ON ACTION controlp INFIELD apde014 name="input.c.page2.apde014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #開窗i段
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde014  
            CASE 
               WHEN g_apce2_d[l_ac].apde002 = '10' AND g_apce2_d[l_ac].apde006= '30'   #10.付款+30.票據類型(anmt440)    
                  LET g_qryparam.arg1 = g_glaa.glaa024       
                  LET g_qryparam.arg2 = "anmt440"       
                  CALL q_ooba002_1()                                            
               WHEN g_apce2_d[l_ac].apde002= '20'                                      #20.轉應付待抵款(aapq343)                  
                  LET g_qryparam.arg1 = g_glaa.glaa024
                  LET g_qryparam.arg2 = "aapq343"
                  LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                          "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                          "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生傳票的單別                      
                  CALL q_ooba002_1()     
               WHEN g_apce2_d[l_ac].apde002= '22'                                      #22.代扣轉付(aapt301)
                  LET g_qryparam.arg1 = g_glaa.glaa024
                  LET g_qryparam.arg2 = "aapt301"
                  LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                          "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                          "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生傳票的單別                  
                  CALL q_ooba002_1()                    

               WHEN g_apce2_d[l_ac].apde002= '21'                                      #21.轉應收款(axrt330)                   
                  LET g_qryparam.arg1 = g_glaa.glaa024
                  LET g_qryparam.arg2 = "axrt330"
                  LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                          "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                          "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生傳票的單別                      
                  CALL q_ooba002_1()                                 
            END CASE
            LET g_apce2_d[l_ac].apde014 = g_qryparam.return1   
            DISPLAY BY NAME g_apce2_d[l_ac].apde014    
            NEXT FIELD apde014 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde016
            #add-point:ON ACTION controlp INFIELD apde016 name="input.c.page2.apde016"
            #科目編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde016
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161115-00046#2 add
                                   " AND gladld='",g_apda_m.apdald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apce2_d[l_ac].apde016 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
            DISPLAY BY NAME g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde016_desc
            NEXT FIELD apde016
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="input.c.page2.apde010"

            #摘要
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde010
            CALL q_oocq002_2()
            LET g_apce2_d[l_ac].apde010 = g_qryparam.return1
            DISPLAY g_apce2_d[l_ac].apde010 TO apde010
            NEXT FIELD apde010            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde039
            #add-point:ON ACTION controlp INFIELD apde039 name="input.c.page2.apde039"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde039
            LET g_qryparam.arg1 = '%'
            CALL q_pmaf002()
            LET g_apce2_d[l_ac].apde039 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde040 = g_qryparam.return2
            LET g_apce2_d[l_ac].apde041 = g_qryparam.return3   #160202-00021#2
            DISPLAY g_apce2_d[l_ac].apde039 TO apde039
            DISPLAY g_apce2_d[l_ac].apde040 TO apde040
            DISPLAY g_apce2_d[l_ac].apde041 TO apde041         #160202-00021#2
            NEXT FIELD apde039  
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde040
            #add-point:ON ACTION controlp INFIELD apde040 name="input.c.page2.apde040"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde040
            LET g_qryparam.arg1 = '%'
            CALL q_pmaf002()
            LET g_apce2_d[l_ac].apde039 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde040 = g_qryparam.return2
            LET g_apce2_d[l_ac].apde041 = g_qryparam.return3      #160202-00021#2
            DISPLAY g_apce2_d[l_ac].apde039 TO apde039
            DISPLAY g_apce2_d[l_ac].apde040 TO apde040
            DISPLAY g_apce2_d[l_ac].apde041 TO apde041            #160202-00021#2
            NEXT FIELD apde040                                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde041
            #add-point:ON ACTION controlp INFIELD apde041 name="input.c.page2.apde041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="input.c.page2.apde011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde011            #給予default值
            CALL q_nmaj001()                                             #呼叫開窗
            LET g_apce2_d[l_ac].apde011 = g_qryparam.return1
            LET g_apce2_d[l_ac].apde012 = s_anm_get_nmad003(g_glaa.glaa005,g_apce2_d[l_ac].apde011)
            DISPLAY BY NAME g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012
            LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
            LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)            
            DISPLAY BY NAME g_apce2_d[l_ac].apde011_desc,g_apce2_d[l_ac].apde012_desc
            NEXT FIELD apde011                                           #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="input.c.page2.apde012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_glaa.glaa005,"' "
            LET g_qryparam.default1 = g_apce2_d[l_ac].apde012 #給予default值
            CALL q_nmai002()                                  #呼叫開窗
            LET g_apce2_d[l_ac].apde012 = g_qryparam.return1
            DISPLAY g_apce2_d[l_ac].apde012 TO apde012              
            LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
            DISPLAY BY NAME g_apce2_d[l_ac].apde012_desc            
            NEXT FIELD apde012                                #返回原欄位
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            LET l_ac = ARR_CURR()
            IF l_ac > 0 THEN
               #S-FIN-3008
               IF g_sfin3008 = 'Y' AND (cl_null(g_apce2_d[l_ac].apde039) OR cl_null(g_apce2_d[l_ac].apde040))THEN
                  #即期票據否
                  LET l_ooia011 = ''
                  SELECT ooia011 INTO l_ooia011
                   FROM ooia_t WHERE ooia001 = g_apce2_d[l_ac].apde021
                                 AND ooiaent = g_enterprise #170123-00010#1
                  #屬於20:銀行匯款/30:票據且為即期票據者,若受款銀行/受款帳戶未維護予以提示
                  IF g_apce2_d[l_ac].apde006 = '20' OR (g_apce2_d[l_ac].apde006 = '30' AND l_ooia011 = 'Y')THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00267'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                  END IF
               END IF
            END IF
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apce2_d[l_ac].* = g_apce2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt823_unlock_b("apde_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
            #回寫核銷單借貸金額
            CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo            
            CALL aapt823_sum_page_show()  #150212apo                      
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce2_d[li_reproduce_target].apdeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apce3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apce3_d[l_ac].* TO NULL 
            INITIALIZE g_apce3_d_t.* TO NULL 
            INITIALIZE g_apce3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_apce3_d_t.* = g_apce3_d[l_ac].*     #新輸入資料
            LET g_apce3_d_o.* = g_apce3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce3_d[li_reproduce_target].apceseq = NULL
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
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce3_d[l_ac].apceseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce3_d_t.* = g_apce3_d[l_ac].*  #BACKUP
               LET g_apce3_d_o.* = g_apce3_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apce_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl INTO g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                      g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                      g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                      g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                      g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                      g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apceseq, 
                      g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020, 
                      g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036, 
                      g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051, 
                      g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055, 
                      g_apce3_d[l_ac].apce056,g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059, 
                      g_apce3_d[l_ac].apce060,g_apce4_d[l_ac].apceseq,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121, 
                      g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce3_d_mask_o[l_ac].* =  g_apce3_d[l_ac].*
                  CALL aapt823_apce_t_mask()
                  LET g_apce3_d_mask_n[l_ac].* =  g_apce3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            #取得自由核算項資訊
            IF NOT cl_null(g_apce_d[l_ac].apce016) THEN
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
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
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apce3_d_t.apceseq
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apce_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apce_t 
             WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
               AND apceseq = g_apce3_d[l_ac].apceseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce3_d[g_detail_idx].apceseq
               CALL aapt823_insert_b('apce_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apce_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
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
               LET g_apce3_d[l_ac].* = g_apce3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl
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
               LET g_apce3_d[l_ac].* = g_apce3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aapt823_apce_t_mask_restore('restore_mask_o')
                              
               UPDATE apce_t SET (apceld,apcedocno,apceseq,apce002,apceorga,apce003,apce004,apce005, 
                   apce061,apce038,apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010, 
                   apce031,apce049,apcecomp,apcesite,apce001,apce017,apce018,apce019,apce020,apce022, 
                   apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055, 
                   apce056,apce057,apce058,apce059,apce060,apce120,apce121,apce129,apce130,apce131,apce139) = (g_apda_m.apdald, 
                   g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                   g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                   g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                   g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                   g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                   g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apce017, 
                   g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce022, 
                   g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044, 
                   g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,g_apce3_d[l_ac].apce052, 
                   g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056, 
                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060, 
                   g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130, 
                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139) #自訂欄位頁簽
                WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
                  AND apcedocno = g_apda_m.apdadocno
                  AND apceseq = g_apce3_d_t.apceseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce3_d[l_ac].* = g_apce3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce3_d[l_ac].* = g_apce3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce3_d[g_detail_idx].apceseq
               LET gs_keys_bak[3] = g_apce3_d_t.apceseq
               CALL aapt823_update_b('apce_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apce_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce3_d[g_detail_idx].apceseq = g_apce3_d_t.apceseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce3_d_t.apceseq
                  CALL aapt823_key_update_b(gs_keys,'apce_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce3_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017
            #add-point:BEFORE FIELD apce017 name="input.b.page3.apce017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017
            
            #add-point:AFTER FIELD apce017 name="input.a.page3.apce017"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce017
            #add-point:ON CHANGE apce017 name="input.g.page3.apce017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017_desc
            #add-point:BEFORE FIELD apce017_desc name="input.b.page3.apce017_desc"
            LET g_apce3_d[l_ac].apce017_desc = g_apce3_d[l_ac].apce017 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017_desc
            
            #add-point:AFTER FIELD apce017_desc name="input.a.page3.apce017_desc"
            #業務人員
            IF NOT cl_null(g_apce3_d[l_ac].apce017_desc) THEN
               IF ( g_apce3_d[l_ac].apce017_desc != g_apce3_d_t.apce017_desc OR g_apce3_d_t.apce017_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce017 = g_apce3_d[l_ac].apce017_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce017 != g_apce3_d_t.apce017 OR g_apce3_d_t.apce017 IS NULL) THEN
                        CALL s_employee_chk(g_apce3_d[l_ac].apce017) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apce3_d[l_ac].apce017        = g_apce3_d_t.apce017
                           LET g_apce3_d[l_ac].apce017_desc = g_apce3_d_t.apce017_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce017_desc
                           NEXT FIELD CURRENT
                        END IF             
                     END IF     
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce017 = ''               
            END IF
            LET g_apce3_d[l_ac].apce017_desc = s_desc_show1(g_apce3_d[l_ac].apce017,s_desc_get_person_desc(g_apce3_d[l_ac].apce017))         
            DISPLAY BY NAME g_apce3_d[l_ac].apce017 ,g_apce3_d[l_ac].apce017_desc
            LET g_apce3_d_t.apce017_desc = g_apce3_d[l_ac].apce017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce017_desc
            #add-point:ON CHANGE apce017_desc name="input.g.page3.apce017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018
            #add-point:BEFORE FIELD apce018 name="input.b.page3.apce018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018
            
            #add-point:AFTER FIELD apce018 name="input.a.page3.apce018"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce018
            #add-point:ON CHANGE apce018 name="input.g.page3.apce018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018_desc
            #add-point:BEFORE FIELD apce018_desc name="input.b.page3.apce018_desc"
            LET g_apce3_d[l_ac].apce018_desc = g_apce3_d[l_ac].apce018 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018_desc
            
            #add-point:AFTER FIELD apce018_desc name="input.a.page3.apce018_desc"
            #業務部門
            IF NOT cl_null(g_apce3_d[l_ac].apce018_desc) THEN
               IF ( g_apce3_d[l_ac].apce018_desc != g_apce3_d_t.apce018_desc OR g_apce3_d_t.apce018_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce018 = g_apce3_d[l_ac].apce018_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce018 != g_apce3_d_t.apce018 OR g_apce3_d_t.apce018 IS NULL) THEN
                        CALL s_department_chk(g_apce3_d[l_ac].apce018_desc,g_apda_m.apdadocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apce3_d[l_ac].apce018      = g_apce3_d_t.apce018
                           LET g_apce3_d[l_ac].apce018_desc = g_apce3_d_t.apce018_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce018 ,g_apce3_d[l_ac].apce018_desc
                           NEXT FIELD CURRENT
                        END IF                 
                     END IF 
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce018 = ''                       
            END IF
            LET g_apce3_d[l_ac].apce018_desc = s_desc_show1(g_apce3_d[l_ac].apce018,s_desc_get_department_desc(g_apce3_d[l_ac].apce018))         
            DISPLAY BY NAME g_apce3_d[l_ac].apce018 ,g_apce3_d[l_ac].apce018_desc
            LET g_apce3_d_t.apce018_desc = g_apce3_d[l_ac].apce018_desc             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce018_desc
            #add-point:ON CHANGE apce018_desc name="input.g.page3.apce018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019
            #add-point:BEFORE FIELD apce019 name="input.b.page3.apce019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019
            
            #add-point:AFTER FIELD apce019 name="input.a.page3.apce019"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce019
            #add-point:ON CHANGE apce019 name="input.g.page3.apce019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019_desc
            #add-point:BEFORE FIELD apce019_desc name="input.b.page3.apce019_desc"
            LET g_apce3_d[l_ac].apce019_desc = g_apce3_d[l_ac].apce019 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019_desc
            
            #add-point:AFTER FIELD apce019_desc name="input.a.page3.apce019_desc"
            #責任中心
            IF NOT cl_null(g_apce3_d[l_ac].apce019_desc) THEN
               IF ( g_apce3_d[l_ac].apce019_desc != g_apce3_d_t.apce019_desc OR g_apce3_d_t.apce019_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce019 = g_apce3_d[l_ac].apce019_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce019 != g_apce3_d_t.apce019 OR g_apce3_d_t.apce019 IS NULL) THEN
                       # CALL s_department_chk(g_apce3_d[l_ac].apce019_desc,g_apda_m.apdadocdt) RETURNING g_sub_success #20150302
                       LET g_errno = ''
                       CALL s_voucher_glaq019_chk(g_apce3_d[l_ac].apce019_desc,g_apda_m.apdadocdt)
                       IF NOT cl_null(g_errno) THEN
                           
                           LET g_apce3_d[l_ac].apce019      = g_apce3_d_t.apce019
                           LET g_apce3_d[l_ac].apce019_desc = g_apce3_d_t.apce019_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce019 ,g_apce3_d[l_ac].apce019_desc
                           NEXT FIELD CURRENT
                        END IF     
                     END IF  
                  END IF    
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce019 = ''                       
            END IF
            LET g_apce3_d[l_ac].apce019_desc = s_desc_show1(g_apce3_d[l_ac].apce019,s_desc_get_department_desc(g_apce3_d[l_ac].apce019))         
            DISPLAY BY NAME g_apce3_d[l_ac].apce019 ,g_apce3_d[l_ac].apce019_desc
            LET g_apce3_d_t.apce019_desc = g_apce3_d[l_ac].apce019_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce019_desc
            #add-point:ON CHANGE apce019_desc name="input.g.page3.apce019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020
            #add-point:BEFORE FIELD apce020 name="input.b.page3.apce020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020
            
            #add-point:AFTER FIELD apce020 name="input.a.page3.apce020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce020
            #add-point:ON CHANGE apce020 name="input.g.page3.apce020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020_desc
            #add-point:BEFORE FIELD apce020_desc name="input.b.page3.apce020_desc"
            LET g_apce3_d[l_ac].apce020_desc = g_apce3_d[l_ac].apce020 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020_desc
            
            #add-point:AFTER FIELD apce020_desc name="input.a.page3.apce020_desc"
            #產品類別
            IF NOT cl_null(g_apce3_d[l_ac].apce020_desc) THEN
               IF ( g_apce3_d[l_ac].apce020_desc != g_apce3_d_t.apce020_desc OR g_apce3_d_t.apce020_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce020 = g_apce3_d[l_ac].apce020_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce020 != g_apce3_d_t.apce020 OR g_apce3_d_t.apce020 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_apce3_d[l_ac].apce020)
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
                           LET g_apce3_d[l_ac].apce020      = g_apce3_d_t.apce020
                           LET g_apce3_d[l_ac].apce020_desc = g_apce3_d_t.apce020_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce020 ,g_apce3_d[l_ac].apce020_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce020 = ''                       
            END IF
            LET g_apce3_d[l_ac].apce020_desc = s_desc_show1(g_apce3_d[l_ac].apce020,s_desc_get_rtaxl003_desc(g_apce3_d[l_ac].apce020))      
            DISPLAY BY NAME g_apce3_d[l_ac].apce020 ,g_apce3_d[l_ac].apce020_desc 
            LET g_apce3_d_t.apce020_desc = g_apce3_d[l_ac].apce020_desc                  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce020_desc
            #add-point:ON CHANGE apce020_desc name="input.g.page3.apce020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022
            #add-point:BEFORE FIELD apce022 name="input.b.page3.apce022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022
            
            #add-point:AFTER FIELD apce022 name="input.a.page3.apce022"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce022
            #add-point:ON CHANGE apce022 name="input.g.page3.apce022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022_desc
            #add-point:BEFORE FIELD apce022_desc name="input.b.page3.apce022_desc"
            LET g_apce3_d[l_ac].apce022_desc = g_apce3_d[l_ac].apce022 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022_desc
            
            #add-point:AFTER FIELD apce022_desc name="input.a.page3.apce022_desc"
            #專案
            IF NOT cl_null(g_apce3_d[l_ac].apce022_desc) THEN
               IF ( g_apce3_d[l_ac].apce022_desc != g_apce3_d_t.apce022_desc OR g_apce3_d_t.apce022_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce022 = g_apce3_d[l_ac].apce022_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce022 != g_apce3_d_t.apce022 OR g_apce3_d_t.apce022 IS NULL) THEN
                        CALL s_aap_project_chk(g_apce3_d[l_ac].apce022) RETURNING g_sub_success,g_errno
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
                           LET g_apce3_d[l_ac].apce022      = g_apce3_d_t.apce022
                           LET g_apce3_d[l_ac].apce022_desc = g_apce3_d_t.apce022_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce022 ,g_apce3_d[l_ac].apce022_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce022 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce022_desc = s_desc_show1(g_apce3_d[l_ac].apce022,s_desc_get_project_desc(g_apce3_d[l_ac].apce022))      
            DISPLAY BY NAME g_apce3_d[l_ac].apce022 ,g_apce3_d[l_ac].apce022_desc 
            LET g_apce3_d_t.apce022_desc = g_apce3_d[l_ac].apce022_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce022_desc
            #add-point:ON CHANGE apce022_desc name="input.g.page3.apce022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023
            #add-point:BEFORE FIELD apce023 name="input.b.page3.apce023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023
            
            #add-point:AFTER FIELD apce023 name="input.a.page3.apce023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce023
            #add-point:ON CHANGE apce023 name="input.g.page3.apce023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023_desc
            #add-point:BEFORE FIELD apce023_desc name="input.b.page3.apce023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023_desc
            
            #add-point:AFTER FIELD apce023_desc name="input.a.page3.apce023_desc"
            #WBS
            IF NOT cl_null(g_apce3_d[l_ac].apce023_desc)  THEN
               IF ( g_apce3_d[l_ac].apce023_desc != g_apce3_d_t.apce023_desc OR g_apce3_d_t.apce023_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce023 = g_apce3_d[l_ac].apce023_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce023 != g_apce3_d_t.apce023 OR g_apce3_d_t.apce023 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023)
                       #CALL s_aap_project_chk( g_apce3_d[l_ac].apce023) RETURNING g_sub_success,g_errno
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apce3_d[l_ac].apce023        = g_apce3_d_t.apce023
                           LET g_apce3_d[l_ac].apce023_desc = g_apce3_d_t.apce023_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce023 = ''
            END IF
            LET g_apce3_d[l_ac].apce023_desc = s_desc_show1(g_apce3_d[l_ac].apce023,s_desc_get_pjbbl004_desc(g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023))
            DISPLAY BY NAME g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce023_desc
            LET g_apce3_d_t.apce023_desc = g_apce3_d[l_ac].apce023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce023_desc
            #add-point:ON CHANGE apce023_desc name="input.g.page3.apce023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035
            #add-point:BEFORE FIELD apce035 name="input.b.page3.apce035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035
            
            #add-point:AFTER FIELD apce035 name="input.a.page3.apce035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce035
            #add-point:ON CHANGE apce035 name="input.g.page3.apce035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035_desc
            #add-point:BEFORE FIELD apce035_desc name="input.b.page3.apce035_desc"
            LET g_apce3_d[l_ac].apce035_desc = g_apce3_d[l_ac].apce035 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035_desc
            
            #add-point:AFTER FIELD apce035_desc name="input.a.page3.apce035_desc"
            #區域
            IF NOT cl_null(g_apce3_d[l_ac].apce035_desc) THEN
               IF ( g_apce3_d[l_ac].apce035_desc != g_apce3_d_t.apce035_desc OR g_apce3_d_t.apce035_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce035 = g_apce3_d[l_ac].apce035_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce035 != g_apce3_d_t.apce035 OR g_apce3_d_t.apce035 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_apce3_d[l_ac].apce035) THEN
                           LET g_apce3_d[l_ac].apce035      = g_apce3_d_t.apce035
                           LET g_apce3_d[l_ac].apce035_desc = g_apce3_d_t.apce035_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce035 ,g_apce3_d[l_ac].apce035_desc
                           NEXT FIELD CURRENT
                        END IF   
                     END IF 
                  END iF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce035 = ''                
            END IF
            LET g_apce3_d[l_ac].apce035_desc = s_desc_show1(g_apce3_d[l_ac].apce035,s_desc_get_acc_desc('287',g_apce3_d[l_ac].apce035))      
            DISPLAY BY NAME g_apce3_d[l_ac].apce035 ,g_apce3_d[l_ac].apce035_desc 
            LET g_apce3_d_t.apce035_desc = g_apce3_d[l_ac].apce035_desc                  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce035_desc
            #add-point:ON CHANGE apce035_desc name="input.g.page3.apce035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036
            #add-point:BEFORE FIELD apce036 name="input.b.page3.apce036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036
            
            #add-point:AFTER FIELD apce036 name="input.a.page3.apce036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce036
            #add-point:ON CHANGE apce036 name="input.g.page3.apce036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036_desc
            #add-point:BEFORE FIELD apce036_desc name="input.b.page3.apce036_desc"
            LET g_apce3_d[l_ac].apce036_desc = g_apce3_d[l_ac].apce036 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036_desc
            
            #add-point:AFTER FIELD apce036_desc name="input.a.page3.apce036_desc"
            #客群
            IF NOT cl_null(g_apce3_d[l_ac].apce036_desc) THEN
               IF ( g_apce3_d[l_ac].apce036_desc != g_apce3_d_t.apce036_desc OR g_apce3_d_t.apce036_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce036 = g_apce3_d[l_ac].apce036_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce036 != g_apce3_d_t.apce036 OR g_apce3_d_t.apce036 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_apce3_d[l_ac].apce036) THEN
                           LET g_apce3_d[l_ac].apce036      = g_apce3_d_t.apce036
                           LET g_apce3_d[l_ac].apce036_desc = g_apce3_d_t.apce036_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce036 ,g_apce3_d[l_ac].apce036_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce036 = ''                
            END IF
            LET g_apce3_d[l_ac].apce036_desc = s_desc_show1(g_apce3_d[l_ac].apce036,s_desc_get_acc_desc('281',g_apce3_d[l_ac].apce036))      
            DISPLAY BY NAME g_apce3_d[l_ac].apce036 ,g_apce3_d[l_ac].apce036_desc 
            LET g_apce3_d_t.apce036_desc = g_apce3_d[l_ac].apce036_desc                  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce036_desc
            #add-point:ON CHANGE apce036_desc name="input.g.page3.apce036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044
            #add-point:BEFORE FIELD apce044 name="input.b.page3.apce044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044
            
            #add-point:AFTER FIELD apce044 name="input.a.page3.apce044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce044
            #add-point:ON CHANGE apce044 name="input.g.page3.apce044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044_desc
            #add-point:BEFORE FIELD apce044_desc name="input.b.page3.apce044_desc"
            LET g_apce3_d[l_ac].apce044_desc = g_apce3_d[l_ac].apce044 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044_desc
            
            #add-point:AFTER FIELD apce044_desc name="input.a.page3.apce044_desc"
            #經營方式
            IF NOT cl_null(g_apce3_d[l_ac].apce044_desc) THEN
               IF ( g_apce3_d[l_ac].apce044_desc != g_apce3_d_t.apce044_desc OR g_apce3_d_t.apce044_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce044 = g_apce3_d[l_ac].apce044_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce044 != g_apce3_d_t.apce044 OR g_apce3_d_t.apce044 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_apce3_d[l_ac].apce044) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_apce3_d[l_ac].apce044      = g_apce3_d_t.apce044
                           LET g_apce3_d[l_ac].apce044_desc = g_apce3_d_t.apce044_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce044 ,g_apce3_d[l_ac].apce044_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce044 = ''                
            END IF
            LET g_apce3_d[l_ac].apce044_desc = g_apce3_d[l_ac].apce044
            DISPLAY BY NAME g_apce3_d[l_ac].apce044 ,g_apce3_d[l_ac].apce044_desc 
            LET g_apce3_d_t.apce044_desc = g_apce3_d[l_ac].apce044_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce044_desc
            #add-point:ON CHANGE apce044_desc name="input.g.page3.apce044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045
            #add-point:BEFORE FIELD apce045 name="input.b.page3.apce045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045
            
            #add-point:AFTER FIELD apce045 name="input.a.page3.apce045"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce045
            #add-point:ON CHANGE apce045 name="input.g.page3.apce045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045_desc
            #add-point:BEFORE FIELD apce045_desc name="input.b.page3.apce045_desc"
            LET g_apce3_d[l_ac].apce045_desc = g_apce3_d[l_ac].apce045 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045_desc
            
            #add-point:AFTER FIELD apce045_desc name="input.a.page3.apce045_desc"
            #渠道
            IF NOT cl_null(g_apce3_d[l_ac].apce045_desc) THEN
               IF ( g_apce3_d[l_ac].apce045_desc != g_apce3_d_t.apce045_desc OR g_apce3_d_t.apce045_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce045 = g_apce3_d[l_ac].apce045_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce045 != g_apce3_d_t.apce045 OR g_apce3_d_t.apce045 IS NULL) THEN
                        CALL s_voucher_glaq052_chk(g_apce3_d[l_ac].apce045)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apce3_d[l_ac].apce045 = g_apce3_d_t.apce045
                           LET g_apce3_d[l_ac].apce045_desc = g_apce3_d_t.apce045_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce045_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce045 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce045_desc = s_desc_show1(g_apce3_d[l_ac].apce045,s_desc_get_oojdl003_desc(g_apce3_d[l_ac].apce045))
            DISPLAY BY NAME g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce045_desc
            LET g_apce3_d_t.apce045_desc = g_apce3_d[l_ac].apce045_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce045_desc
            #add-point:ON CHANGE apce045_desc name="input.g.page3.apce045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046
            #add-point:BEFORE FIELD apce046 name="input.b.page3.apce046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046
            
            #add-point:AFTER FIELD apce046 name="input.a.page3.apce046"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce046
            #add-point:ON CHANGE apce046 name="input.g.page3.apce046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046_desc
            #add-point:BEFORE FIELD apce046_desc name="input.b.page3.apce046_desc"
            LET g_apce3_d[l_ac].apce046_desc = g_apce3_d[l_ac].apce046 #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046_desc
            
            #add-point:AFTER FIELD apce046_desc name="input.a.page3.apce046_desc"
            #品牌
            IF NOT cl_null(g_apce3_d[l_ac].apce046_desc) THEN
               IF ( g_apce3_d[l_ac].apce046_desc != g_apce3_d_t.apce046_desc OR g_apce3_d_t.apce046_desc IS NULL ) THEN
                  LET g_apce3_d[l_ac].apce046 = g_apce3_d[l_ac].apce046_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce046 != g_apce3_d_t.apce046 OR g_apce3_d_t.apce046 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('2002',g_apce3_d[l_ac].apce046) THEN
                           LET g_apce3_d[l_ac].apce046      = g_apce3_d_t.apce046
                           LET g_apce3_d[l_ac].apce046_desc = g_apce3_d_t.apce046_desc
                           DISPLAY BY NAME g_apce3_d[l_ac].apce046 ,g_apce3_d[l_ac].apce046_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce046 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce046_desc = s_desc_show1(g_apce3_d[l_ac].apce046,s_desc_get_acc_desc('2002',g_apce3_d[l_ac].apce046))      
            DISPLAY BY NAME g_apce3_d[l_ac].apce046 ,g_apce3_d[l_ac].apce046_desc
            LET g_apce3_d_t.apce046_desc = g_apce3_d[l_ac].apce046_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce046_desc
            #add-point:ON CHANGE apce046_desc name="input.g.page3.apce046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce051
            #add-point:BEFORE FIELD apce051 name="input.b.page3.apce051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce051
            
            #add-point:AFTER FIELD apce051 name="input.a.page3.apce051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce051
            #add-point:ON CHANGE apce051 name="input.g.page3.apce051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce051_desc
            #add-point:BEFORE FIELD apce051_desc name="input.b.page3.apce051_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce051_desc = g_apce3_d[l_ac].apce051    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce051_desc
            
            #add-point:AFTER FIELD apce051_desc name="input.a.page3.apce051_desc"
            #自由核算項一
            IF NOT cl_null(g_apce3_d[l_ac].apce051_desc) THEN
               IF (g_apce3_d[l_ac].apce051_desc != g_apce3_d_t.apce051_desc OR g_apce3_d_t.apce051_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce051 = g_apce3_d[l_ac].apce051_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce051 != g_apce3_d_t.apce051 OR g_apce3_d_t.apce051 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_apce3_d[l_ac].apce051,g_glad.glad0172) RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce051 = g_apce3_d_t.apce051
                           LET g_apce3_d[l_ac].apce051_desc = s_desc_show1(g_apce3_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce3_d[l_ac].apce051))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce051_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce051 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce051_desc = s_desc_show1(g_apce3_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce3_d[l_ac].apce051))
            DISPLAY BY NAME g_apce3_d[l_ac].apce051_desc 
            LET g_apce3_d_t.apce051_desc = g_apce3_d[l_ac].apce051_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce051_desc
            #add-point:ON CHANGE apce051_desc name="input.g.page3.apce051_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce052
            #add-point:BEFORE FIELD apce052 name="input.b.page3.apce052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce052
            
            #add-point:AFTER FIELD apce052 name="input.a.page3.apce052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce052
            #add-point:ON CHANGE apce052 name="input.g.page3.apce052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce052_desc
            #add-point:BEFORE FIELD apce052_desc name="input.b.page3.apce052_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce052_desc = g_apce3_d[l_ac].apce052    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce052_desc
            
            #add-point:AFTER FIELD apce052_desc name="input.a.page3.apce052_desc"
            #自由核算項二
            IF NOT cl_null(g_apce3_d[l_ac].apce052_desc) THEN
               IF (g_apce3_d[l_ac].apce052_desc != g_apce3_d_t.apce052_desc OR g_apce3_d_t.apce052_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce052 = g_apce3_d[l_ac].apce052_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce052 != g_apce3_d_t.apce052 OR g_apce3_d_t.apce052 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_apce3_d[l_ac].apce052,g_glad.glad0182)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce052 = g_apce3_d_t.apce052
                           LET g_apce3_d[l_ac].apce052_desc = s_desc_show1(g_apce3_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce3_d[l_ac].apce052))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce052_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF   
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce052 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce052_desc = s_desc_show1(g_apce3_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce3_d[l_ac].apce052))
            DISPLAY BY NAME g_apce3_d[l_ac].apce052_desc 
            LET g_apce3_d_t.apce052_desc = g_apce3_d[l_ac].apce052_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce052_desc
            #add-point:ON CHANGE apce052_desc name="input.g.page3.apce052_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce053
            #add-point:BEFORE FIELD apce053 name="input.b.page3.apce053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce053
            
            #add-point:AFTER FIELD apce053 name="input.a.page3.apce053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce053
            #add-point:ON CHANGE apce053 name="input.g.page3.apce053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce053_desc
            #add-point:BEFORE FIELD apce053_desc name="input.b.page3.apce053_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce053_desc = g_apce3_d[l_ac].apce053    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce053_desc
            
            #add-point:AFTER FIELD apce053_desc name="input.a.page3.apce053_desc"
            #自由核算項三
            IF NOT cl_null(g_apce3_d[l_ac].apce053_desc) THEN
               IF (g_apce3_d[l_ac].apce053_desc != g_apce3_d_t.apce053_desc OR g_apce3_d_t.apce053_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce053 = g_apce3_d[l_ac].apce053_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce053 != g_apce3_d_t.apce053 OR g_apce3_d_t.apce053 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_apce3_d[l_ac].apce053,g_glad.glad0192)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce053 = g_apce3_d_t.apce053
                           LET g_apce3_d[l_ac].apce053_desc = s_desc_show1(g_apce3_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce3_d[l_ac].apce053))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce053_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce053 = ''                
            END IF
            LET g_apce3_d[l_ac].apce053_desc = s_desc_show1(g_apce3_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce3_d[l_ac].apce053))
            DISPLAY BY NAME g_apce3_d[l_ac].apce053_desc 
            LET g_apce3_d_t.apce053_desc = g_apce3_d[l_ac].apce053_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce053_desc
            #add-point:ON CHANGE apce053_desc name="input.g.page3.apce053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce054
            #add-point:BEFORE FIELD apce054 name="input.b.page3.apce054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce054
            
            #add-point:AFTER FIELD apce054 name="input.a.page3.apce054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce054
            #add-point:ON CHANGE apce054 name="input.g.page3.apce054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce054_desc
            #add-point:BEFORE FIELD apce054_desc name="input.b.page3.apce054_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce054_desc = g_apce3_d[l_ac].apce054    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce054_desc
            
            #add-point:AFTER FIELD apce054_desc name="input.a.page3.apce054_desc"
            #自由核算項四
            IF NOT cl_null(g_apce3_d[l_ac].apce054_desc) THEN
               IF (g_apce3_d[l_ac].apce054_desc != g_apce3_d_t.apce054_desc OR g_apce3_d_t.apce054_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce054 = g_apce3_d[l_ac].apce054_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce054 != g_apce3_d_t.apce054 OR g_apce3_d_t.apce054 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_apce3_d[l_ac].apce054,g_glad.glad0202) RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce054 = g_apce3_d_t.apce054
                           LET g_apce3_d[l_ac].apce054_desc = s_desc_show1(g_apce3_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce3_d[l_ac].apce054))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce054_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF   
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce054 = ''                
            END IF
            LET g_apce3_d[l_ac].apce054_desc = s_desc_show1(g_apce3_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce3_d[l_ac].apce054))
            DISPLAY BY NAME g_apce3_d[l_ac].apce054_desc 
            LET g_apce3_d_t.apce054_desc = g_apce3_d[l_ac].apce054_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce054_desc
            #add-point:ON CHANGE apce054_desc name="input.g.page3.apce054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce055
            #add-point:BEFORE FIELD apce055 name="input.b.page3.apce055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce055
            
            #add-point:AFTER FIELD apce055 name="input.a.page3.apce055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce055
            #add-point:ON CHANGE apce055 name="input.g.page3.apce055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce055_desc
            #add-point:BEFORE FIELD apce055_desc name="input.b.page3.apce055_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce055_desc = g_apce3_d[l_ac].apce055    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce055_desc
            
            #add-point:AFTER FIELD apce055_desc name="input.a.page3.apce055_desc"
            #自由核算項五
            IF NOT cl_null(g_apce3_d[l_ac].apce055_desc) THEN
               IF (g_apce3_d[l_ac].apce055_desc != g_apce3_d_t.apce055_desc OR g_apce3_d_t.apce055_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce055 = g_apce3_d[l_ac].apce055_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce055 != g_apce3_d_t.apce055 OR g_apce3_d_t.apce055 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_apce3_d[l_ac].apce055,g_glad.glad0212)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce055 = g_apce3_d_t.apce055
                           LET g_apce3_d[l_ac].apce055_desc = s_desc_show1(g_apce3_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce3_d[l_ac].apce055))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce055_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce055 = ''                  
            END IF
            LET g_apce3_d[l_ac].apce055_desc = s_desc_show1(g_apce3_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce3_d[l_ac].apce055))
            DISPLAY BY NAME g_apce3_d[l_ac].apce055_desc 
            LET g_apce3_d_t.apce055_desc = g_apce3_d[l_ac].apce055_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce055_desc
            #add-point:ON CHANGE apce055_desc name="input.g.page3.apce055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce056
            #add-point:BEFORE FIELD apce056 name="input.b.page3.apce056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce056
            
            #add-point:AFTER FIELD apce056 name="input.a.page3.apce056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce056
            #add-point:ON CHANGE apce056 name="input.g.page3.apce056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce056_desc
            #add-point:BEFORE FIELD apce056_desc name="input.b.page3.apce056_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce056_desc = g_apce3_d[l_ac].apce056    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce056_desc
            
            #add-point:AFTER FIELD apce056_desc name="input.a.page3.apce056_desc"
            #自由核算項六
            IF NOT cl_null(g_apce3_d[l_ac].apce056_desc) THEN
               IF (g_apce3_d[l_ac].apce056_desc != g_apce3_d_t.apce056_desc OR g_apce3_d_t.apce056_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce056 = g_apce3_d[l_ac].apce056_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce056 != g_apce3_d_t.apce056 OR g_apce3_d_t.apce056 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_apce3_d[l_ac].apce056,g_glad.glad0222)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce056 = g_apce3_d_t.apce056
                           LET g_apce3_d[l_ac].apce056_desc = s_desc_show1(g_apce3_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce3_d[l_ac].apce056))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce056_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce056 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce056_desc = s_desc_show1(g_apce3_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce3_d[l_ac].apce056))
            DISPLAY BY NAME g_apce3_d[l_ac].apce056_desc 
            LET g_apce3_d_t.apce056_desc = g_apce3_d[l_ac].apce056_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce056_desc
            #add-point:ON CHANGE apce056_desc name="input.g.page3.apce056_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce057
            #add-point:BEFORE FIELD apce057 name="input.b.page3.apce057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce057
            
            #add-point:AFTER FIELD apce057 name="input.a.page3.apce057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce057
            #add-point:ON CHANGE apce057 name="input.g.page3.apce057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce057_desc
            #add-point:BEFORE FIELD apce057_desc name="input.b.page3.apce057_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce057_desc = g_apce3_d[l_ac].apce057    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce057_desc
            
            #add-point:AFTER FIELD apce057_desc name="input.a.page3.apce057_desc"
            #自由核算項七
            IF NOT cl_null(g_apce3_d[l_ac].apce057_desc) THEN
               IF (g_apce3_d[l_ac].apce057_desc != g_apce3_d_t.apce057_desc OR g_apce3_d_t.apce057_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce057 = g_apce3_d[l_ac].apce057_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce057 != g_apce3_d_t.apce057 OR g_apce3_d_t.apce057 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_apce3_d[l_ac].apce057,g_glad.glad0232)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce057 = g_apce3_d_t.apce057
                           LET g_apce3_d[l_ac].apce057_desc = s_desc_show1(g_apce3_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce3_d[l_ac].apce057))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce057_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce057 = ''                        
            END IF
            LET g_apce3_d[l_ac].apce057_desc = s_desc_show1(g_apce3_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce3_d[l_ac].apce057))
            DISPLAY BY NAME g_apce3_d[l_ac].apce057_desc 
            LET g_apce3_d_t.apce057_desc = g_apce3_d[l_ac].apce057_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce057_desc
            #add-point:ON CHANGE apce057_desc name="input.g.page3.apce057_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce058
            #add-point:BEFORE FIELD apce058 name="input.b.page3.apce058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce058
            
            #add-point:AFTER FIELD apce058 name="input.a.page3.apce058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce058
            #add-point:ON CHANGE apce058 name="input.g.page3.apce058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce058_desc
            #add-point:BEFORE FIELD apce058_desc name="input.b.page3.apce058_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce058_desc = g_apce3_d[l_ac].apce058    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce058_desc
            
            #add-point:AFTER FIELD apce058_desc name="input.a.page3.apce058_desc"
            #自由核算項八
            IF NOT cl_null(g_apce3_d[l_ac].apce058_desc) THEN
               IF (g_apce3_d[l_ac].apce058_desc != g_apce3_d_t.apce058_desc OR g_apce3_d_t.apce058_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce058 = g_apce3_d[l_ac].apce058_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce058 != g_apce3_d_t.apce058 OR g_apce3_d_t.apce058 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_apce3_d[l_ac].apce058,g_glad.glad0242) RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce058 = g_apce3_d_t.apce058
                           LET g_apce3_d[l_ac].apce058_desc = s_desc_show1(g_apce3_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce3_d[l_ac].apce058))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce058_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce058 = ''               
            END IF
            LET g_apce3_d[l_ac].apce058_desc = s_desc_show1(g_apce3_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce3_d[l_ac].apce058))
            DISPLAY BY NAME g_apce3_d[l_ac].apce058_desc 
            LET g_apce3_d_t.apce058_desc = g_apce3_d[l_ac].apce058_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce058_desc
            #add-point:ON CHANGE apce058_desc name="input.g.page3.apce058_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce059
            #add-point:BEFORE FIELD apce059 name="input.b.page3.apce059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce059
            
            #add-point:AFTER FIELD apce059 name="input.a.page3.apce059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce059
            #add-point:ON CHANGE apce059 name="input.g.page3.apce059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce059_desc
            #add-point:BEFORE FIELD apce059_desc name="input.b.page3.apce059_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce059_desc = g_apce3_d[l_ac].apce059    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce059_desc
            
            #add-point:AFTER FIELD apce059_desc name="input.a.page3.apce059_desc"
            #自由核算項九
            IF NOT cl_null(g_apce3_d[l_ac].apce059_desc) THEN
               IF (g_apce3_d[l_ac].apce059_desc != g_apce3_d_t.apce059_desc OR g_apce3_d_t.apce059_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce059 = g_apce3_d[l_ac].apce059_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce059 != g_apce3_d_t.apce059 OR g_apce3_d_t.apce059 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_apce3_d[l_ac].apce059,g_glad.glad0252)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce059 = g_apce3_d_t.apce059
                           LET g_apce3_d[l_ac].apce059_desc = s_desc_show1(g_apce3_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce3_d[l_ac].apce059))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce059_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce059 = ''                     
            END IF
            LET g_apce3_d[l_ac].apce059_desc = s_desc_show1(g_apce3_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce3_d[l_ac].apce059))
            DISPLAY BY NAME g_apce3_d[l_ac].apce059_desc 
            LET g_apce3_d_t.apce059_desc = g_apce3_d[l_ac].apce059_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce059_desc
            #add-point:ON CHANGE apce059_desc name="input.g.page3.apce059_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce060
            #add-point:BEFORE FIELD apce060 name="input.b.page3.apce060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce060
            
            #add-point:AFTER FIELD apce060 name="input.a.page3.apce060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce060
            #add-point:ON CHANGE apce060 name="input.g.page3.apce060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce060_desc
            #add-point:BEFORE FIELD apce060_desc name="input.b.page3.apce060_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apce3_d[l_ac].apce060_desc = g_apce3_d[l_ac].apce060    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce060_desc
            
            #add-point:AFTER FIELD apce060_desc name="input.a.page3.apce060_desc"
            #自由核算項十
            IF NOT cl_null(g_apce3_d[l_ac].apce060_desc) THEN
               IF (g_apce3_d[l_ac].apce060_desc != g_apce3_d_t.apce060_desc OR g_apce3_d_t.apce060_desc IS NULL) THEN
                  LET g_apce3_d[l_ac].apce060 = g_apce3_d[l_ac].apce060_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce3_d[l_ac].apce060 != g_apce3_d_t.apce060 OR g_apce3_d_t.apce060 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_apce3_d[l_ac].apce060,g_glad.glad0262)  RETURNING g_errno
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
                           LET g_apce3_d[l_ac].apce060 = g_apce3_d_t.apce060
                           LET g_apce3_d[l_ac].apce060_desc = s_desc_show1(g_apce3_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce3_d[l_ac].apce060))
                           DISPLAY BY NAME g_apce3_d[l_ac].apce060_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce3_d[l_ac].apce060 = ''                 
            END IF
            LET g_apce3_d[l_ac].apce060_desc = s_desc_show1(g_apce3_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce3_d[l_ac].apce060))
            DISPLAY BY NAME g_apce3_d[l_ac].apce060_desc 
            LET g_apce3_d_t.apce060_desc = g_apce3_d[l_ac].apce060_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce060_desc
            #add-point:ON CHANGE apce060_desc name="input.g.page3.apce060_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.apce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017
            #add-point:ON ACTION controlp INFIELD apce017 name="input.c.page3.apce017"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017_desc
            #add-point:ON ACTION controlp INFIELD apce017_desc name="input.c.page3.apce017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce017
            CALL q_ooag001_8()                          
            LET g_apce3_d[l_ac].apce017 = g_qryparam.return1    
            LET g_apce3_d[l_ac].apce017_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce017_desc
            NEXT FIELD apce017_desc   
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018
            #add-point:ON ACTION controlp INFIELD apce018 name="input.c.page3.apce018"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018_desc
            #add-point:ON ACTION controlp INFIELD apce018_desc name="input.c.page3.apce018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce018
            LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apce3_d[l_ac].apce018 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce018_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce018_desc
            NEXT FIELD apce018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019
            #add-point:ON ACTION controlp INFIELD apce019 name="input.c.page3.apce019"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019_desc
            #add-point:ON ACTION controlp INFIELD apce019_desc name="input.c.page3.apce019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
		      LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce019
            LET g_qryparam.where =" ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_5()
            LET g_apce3_d[l_ac].apce019 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce019_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce019_desc
            NEXT FIELD apce019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020
            #add-point:ON ACTION controlp INFIELD apce020 name="input.c.page3.apce020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020_desc
            #add-point:ON ACTION controlp INFIELD apce020_desc name="input.c.page3.apce020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce020
            CALL q_rtax001()                          
            LET g_apce3_d[l_ac].apce020 = g_qryparam.return1    
            LET g_apce3_d[l_ac].apce020_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce020_desc
            NEXT FIELD apce020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022
            #add-point:ON ACTION controlp INFIELD apce022 name="input.c.page3.apce022"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022_desc
            #add-point:ON ACTION controlp INFIELD apce022_desc name="input.c.page3.apce022_desc"
            #專案
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce022
            CALL q_pjba001()                          
            LET g_apce3_d[l_ac].apce022 = g_qryparam.return1    
            LET g_apce3_d[l_ac].apce022_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce022_desc
            NEXT FIELD apce022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023
            #add-point:ON ACTION controlp INFIELD apce023 name="input.c.page3.apce023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023_desc
            #add-point:ON ACTION controlp INFIELD apce023_desc name="input.c.page3.apce023_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce023
            IF NOT cl_null(g_apce3_d[l_ac].apce022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apce3_d[l_ac].apce022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF

            CALL q_pjbb002()
            LET g_apce3_d[l_ac].apce023        = g_qryparam.return1
            LET g_apce3_d[l_ac].apce023_desc = g_apce3_d[l_ac].apce023
            DISPLAY BY NAME g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce023_desc
            NEXT FIELD apce023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035
            #add-point:ON ACTION controlp INFIELD apce035 name="input.c.page3.apce035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035_desc
            #add-point:ON ACTION controlp INFIELD apce035_desc name="input.c.page3.apce035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce035
            CALL q_oocq002_287()
            LET g_apce3_d[l_ac].apce035 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce035_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce035_desc
            NEXT FIELD apce035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036
            #add-point:ON ACTION controlp INFIELD apce036 name="input.c.page3.apce036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036_desc
            #add-point:ON ACTION controlp INFIELD apce036_desc name="input.c.page3.apce036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce036
            CALL q_oocq002_281()
            LET g_apce3_d[l_ac].apce036 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce036_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce036_desc
            NEXT FIELD apce036_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044
            #add-point:ON ACTION controlp INFIELD apce044 name="input.c.page3.apce044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044_desc
            #add-point:ON ACTION controlp INFIELD apce044_desc name="input.c.page3.apce044_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045
            #add-point:ON ACTION controlp INFIELD apce045 name="input.c.page3.apce045"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045_desc
            #add-point:ON ACTION controlp INFIELD apce045_desc name="input.c.page3.apce045_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce045
            CALL q_oojd001_2()
            LET g_apce3_d[l_ac].apce045 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce045_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce045_desc
            NEXT FIELD apce045_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046
            #add-point:ON ACTION controlp INFIELD apce046 name="input.c.page3.apce046"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046_desc
            #add-point:ON ACTION controlp INFIELD apce046_desc name="input.c.page3.apce046_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce3_d[l_ac].apce046
            CALL q_oocq002_2002()
            LET g_apce3_d[l_ac].apce046 = g_qryparam.return1   
            LET g_apce3_d[l_ac].apce046_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce046_desc
            NEXT FIELD apce046_desc
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce051
            #add-point:ON ACTION controlp INFIELD apce051 name="input.c.page3.apce051"
 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce051_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce051_desc
            #add-point:ON ACTION controlp INFIELD apce051_desc name="input.c.page3.apce051_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce051
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce051      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce051_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce051,g_apce3_d[l_ac].apce051_desc
               NEXT FIELD apce051_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce052
            #add-point:ON ACTION controlp INFIELD apce052 name="input.c.page3.apce052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce052_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce052_desc
            #add-point:ON ACTION controlp INFIELD apce052_desc name="input.c.page3.apce052_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce052
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce052      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce052_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce052_desc
               NEXT FIELD apce052_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce053
            #add-point:ON ACTION controlp INFIELD apce053 name="input.c.page3.apce053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce053_desc
            #add-point:ON ACTION controlp INFIELD apce053_desc name="input.c.page3.apce053_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce053
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce053      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce053_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce053_desc
               NEXT FIELD apce053_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce054
            #add-point:ON ACTION controlp INFIELD apce054 name="input.c.page3.apce054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce054_desc
            #add-point:ON ACTION controlp INFIELD apce054_desc name="input.c.page3.apce054_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce054
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce054      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce054_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce054_desc
               NEXT FIELD apce054_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce055
            #add-point:ON ACTION controlp INFIELD apce055 name="input.c.page3.apce055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce055_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce055_desc
            #add-point:ON ACTION controlp INFIELD apce055_desc name="input.c.page3.apce055_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce055
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce055      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce055_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce055_desc
               NEXT FIELD apce055_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce056
            #add-point:ON ACTION controlp INFIELD apce056 name="input.c.page3.apce056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce056_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce056_desc
            #add-point:ON ACTION controlp INFIELD apce056_desc name="input.c.page3.apce056_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce056
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce056      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce056_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce056,g_apce3_d[l_ac].apce056_desc
               NEXT FIELD apce056_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce057
            #add-point:ON ACTION controlp INFIELD apce057 name="input.c.page3.apce057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce057_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce057_desc
            #add-point:ON ACTION controlp INFIELD apce057_desc name="input.c.page3.apce057_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce057
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce057      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce057_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce057_desc
               NEXT FIELD apce057_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce058
            #add-point:ON ACTION controlp INFIELD apce058 name="input.c.page3.apce058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce058_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce058_desc
            #add-point:ON ACTION controlp INFIELD apce058_desc name="input.c.page3.apce058_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce058
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce058      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce058_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce058_desc
               NEXT FIELD apce058_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce059
            #add-point:ON ACTION controlp INFIELD apce059 name="input.c.page3.apce059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce059_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce059_desc
            #add-point:ON ACTION controlp INFIELD apce059_desc name="input.c.page3.apce059_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce059
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce059      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce059_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce059_desc
               NEXT FIELD apce059_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce060
            #add-point:ON ACTION controlp INFIELD apce060 name="input.c.page3.apce060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apce060_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce060_desc
            #add-point:ON ACTION controlp INFIELD apce060_desc name="input.c.page3.apce060_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce3_d[l_ac].apce060
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce3_d[l_ac].apce060      = g_qryparam.return1
               LET g_apce3_d[l_ac].apce060_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce3_d[l_ac].apce060,g_apce3_d[l_ac].apce060_desc
               NEXT FIELD apce060_desc
            END IF 
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            LET l_ac = ARR_CURR()
            IF l_ac > 0 THEN
               CALL l_account.clear()
               LET l_account[7].f1  = g_apce3_d[l_ac].apce018    LET l_account[7].f2 = "apce018"      LET l_account[7].f3 = g_apda_m.apdadocdt  #部門
               LET l_account[8].f1  = g_apce3_d[l_ac].apce019    LET l_account[8].f2 = "apce019"      #責任中心
               LET l_account[9].f1  = g_apce3_d[l_ac].apce035    LET l_account[9].f2 = "apce035"	   #區域
               LET l_account[10].f1 = g_apce_d[l_ac].apce038     LET l_account[10].f2 = "apce038"	   #交易客商      
               LET l_account[11].f1 = g_apce3_d[l_ac].apce036    LET l_account[11].f2 = "apce036"	   #客群
               
               LET l_account[12].f1 = g_apce3_d[l_ac].apce020    LET l_account[12].f2 = "apce020"	   #產品類別      
               LET l_account[13].f1 = g_apce3_d[l_ac].apce017    LET l_account[13].f2 = "apce017"     #人員      
               LET l_account[15].f1 = g_apce3_d[l_ac].apce022    LET l_account[15].f2 = "apce022"     #專案管理      
               LET l_account[16].f1 = g_apce3_d[l_ac].apce023    LET l_account[16].f2 = "apce023"     #WBS    
               LET l_account[27].f1 = g_apce_d[l_ac].apce038     LET l_account[27].f2 = "apce038"	   #帳款客商      
               
               LET l_account[31].f1 = g_apce3_d[l_ac].apce044    LET l_account[31].f2 = "apce044"	   #經營方式      
               LET l_account[32].f1 = g_apce3_d[l_ac].apce045    LET l_account[32].f2 = "apce045"     #渠道
               LET l_account[33].f1 = g_apce3_d[l_ac].apce046    LET l_account[33].f2 = "apce046"     #品牌
               
                                                                                             
               LET l_account[17].f1 = g_apce3_d[l_ac].apce051    LET l_account[17].f2 = "apce051"	   #自由核算項一
               LET l_account[18].f1 = g_apce3_d[l_ac].apce052    LET l_account[18].f2 = "apce052"	   #自由核算項二
               LET l_account[19].f1 = g_apce3_d[l_ac].apce053    LET l_account[19].f2 = "apce053"	   #自由核算項三
               LET l_account[20].f1 = g_apce3_d[l_ac].apce054    LET l_account[20].f2 = "apce054"	   #自由核算項四
               LET l_account[21].f1 = g_apce3_d[l_ac].apce055    LET l_account[21].f2 = "apce055"	   #自由核算項五
               
               LET l_account[22].f1 = g_apce3_d[l_ac].apce056    LET l_account[22].f2 = "apce056"	   #自由核算項六
               LET l_account[23].f1 = g_apce3_d[l_ac].apce057    LET l_account[23].f2 = "apce057"	   #自由核算項七
               LET l_account[24].f1 = g_apce3_d[l_ac].apce058    LET l_account[24].f2 = "apce058"	   #自由核算項八
               LET l_account[25].f1 = g_apce3_d[l_ac].apce059    LET l_account[25].f2 = "apce059"	   #自由核算項九
               LET l_account[26].f1 = g_apce3_d[l_ac].apce060    LET l_account[26].f2 = "apce060"	   #自由核算項十
               
               CALL cl_err_collect_init()
               CALL s_fin_accting_chk(g_apda_m.apdald,g_apce_d[l_ac].apce016,l_account) RETURNING g_sub_success
               CALL cl_err_collect_show()   
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT             
               END IF
            END IF
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apce3_d[l_ac].* = g_apce3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt823_unlock_b("apce_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
            #回寫核銷單借貸金額
            CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo           
            CALL aapt823_sum_page_show()  #150212apo
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce3_d[li_reproduce_target].apceseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apce4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apce4_d[l_ac].* TO NULL 
            INITIALIZE g_apce4_d_t.* TO NULL 
            INITIALIZE g_apce4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_apce4_d_t.* = g_apce4_d[l_ac].*     #新輸入資料
            LET g_apce4_d_o.* = g_apce4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce4_d[li_reproduce_target].apceseq = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce4_d[l_ac].apceseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce4_d_t.* = g_apce4_d[l_ac].*  #BACKUP
               LET g_apce4_d_o.* = g_apce4_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apce_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl INTO g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                      g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                      g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                      g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                      g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                      g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apceseq, 
                      g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020, 
                      g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036, 
                      g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051, 
                      g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055, 
                      g_apce3_d[l_ac].apce056,g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059, 
                      g_apce3_d[l_ac].apce060,g_apce4_d[l_ac].apceseq,g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121, 
                      g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130,g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce4_d_mask_o[l_ac].* =  g_apce4_d[l_ac].*
                  CALL aapt823_apce_t_mask()
                  LET g_apce4_d_mask_n[l_ac].* =  g_apce4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apce4_d_t.apceseq
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apce_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce4_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apce_t 
             WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
               AND apceseq = g_apce4_d[l_ac].apceseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce4_d[g_detail_idx].apceseq
               CALL aapt823_insert_b('apce_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apce_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce4_d[l_ac].* = g_apce4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl
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
               LET g_apce4_d[l_ac].* = g_apce4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aapt823_apce_t_mask_restore('restore_mask_o')
                              
               UPDATE apce_t SET (apceld,apcedocno,apceseq,apce002,apceorga,apce003,apce004,apce005, 
                   apce061,apce038,apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010, 
                   apce031,apce049,apcecomp,apcesite,apce001,apce017,apce018,apce019,apce020,apce022, 
                   apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055, 
                   apce056,apce057,apce058,apce059,apce060,apce120,apce121,apce129,apce130,apce131,apce139) = (g_apda_m.apdald, 
                   g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                   g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061, 
                   g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100, 
                   g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015, 
                   g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049, 
                   g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apce017, 
                   g_apce3_d[l_ac].apce018,g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce022, 
                   g_apce3_d[l_ac].apce023,g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044, 
                   g_apce3_d[l_ac].apce045,g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,g_apce3_d[l_ac].apce052, 
                   g_apce3_d[l_ac].apce053,g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056, 
                   g_apce3_d[l_ac].apce057,g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060, 
                   g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130, 
                   g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139) #自訂欄位頁簽
                WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
                  AND apcedocno = g_apda_m.apdadocno
                  AND apceseq = g_apce4_d_t.apceseq #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce4_d[l_ac].* = g_apce4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce4_d[l_ac].* = g_apce4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce4_d[g_detail_idx].apceseq
               LET gs_keys_bak[3] = g_apce4_d_t.apceseq
               CALL aapt823_update_b('apce_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apce_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce4_d[g_detail_idx].apceseq = g_apce4_d_t.apceseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce4_d_t.apceseq
                  CALL aapt823_key_update_b(gs_keys,'apce_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce4_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce121
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce4_d[l_ac].apce121,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce121
            END IF 
 
 
 
            #add-point:AFTER FIELD apce121 name="input.a.page4.apce121"
            IF NOT cl_null(g_apce4_d[l_ac].apce121) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce121
            #add-point:BEFORE FIELD apce121 name="input.b.page4.apce121"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce121
            #add-point:ON CHANGE apce121 name="input.g.page4.apce121"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce129
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce4_d[l_ac].apce129,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce129
            END IF 
 
 
 
            #add-point:AFTER FIELD apce129 name="input.a.page4.apce129"
            IF NOT cl_null(g_apce4_d[l_ac].apce129) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce129
            #add-point:BEFORE FIELD apce129 name="input.b.page4.apce129"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce129
            #add-point:ON CHANGE apce129 name="input.g.page4.apce129"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce131
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce4_d[l_ac].apce131,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce131
            END IF 
 
 
 
            #add-point:AFTER FIELD apce131 name="input.a.page4.apce131"
            IF NOT cl_null(g_apce4_d[l_ac].apce131) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce131
            #add-point:BEFORE FIELD apce131 name="input.b.page4.apce131"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce131
            #add-point:ON CHANGE apce131 name="input.g.page4.apce131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce139
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce4_d[l_ac].apce139,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce139
            END IF 
 
 
 
            #add-point:AFTER FIELD apce139 name="input.a.page4.apce139"
            IF NOT cl_null(g_apce4_d[l_ac].apce139) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce139
            #add-point:BEFORE FIELD apce139 name="input.b.page4.apce139"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce139
            #add-point:ON CHANGE apce139 name="input.g.page4.apce139"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.apce121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce121
            #add-point:ON ACTION controlp INFIELD apce121 name="input.c.page4.apce121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.apce129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce129
            #add-point:ON ACTION controlp INFIELD apce129 name="input.c.page4.apce129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.apce131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce131
            #add-point:ON ACTION controlp INFIELD apce131 name="input.c.page4.apce131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.apce139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce139
            #add-point:ON ACTION controlp INFIELD apce139 name="input.c.page4.apce139"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apce4_d[l_ac].* = g_apce4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt823_unlock_b("apce_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
            #回寫核銷單借貸金額
            CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo           
            CALL aapt823_sum_page_show()  #150212apo
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
               LET g_apce3_d[li_reproduce_target].* = g_apce3_d[li_reproduce].*
               LET g_apce4_d[li_reproduce_target].* = g_apce4_d[li_reproduce].*
 
               LET g_apce4_d[li_reproduce_target].apceseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apce5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apce5_d[l_ac].* TO NULL 
            INITIALIZE g_apce5_d_t.* TO NULL 
            INITIALIZE g_apce5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_apce5_d_t.* = g_apce5_d[l_ac].*     #新輸入資料
            LET g_apce5_d_o.* = g_apce5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce5_d[li_reproduce_target].apdeseq = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body5.before_insert"
       
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce5_d[l_ac].apdeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce5_d_t.* = g_apce5_d[l_ac].*  #BACKUP
               LET g_apce5_d_o.* = g_apce5_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apde_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl2 INTO g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002, 
                      g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021, 
                      g_apce2_d[l_ac].apde024,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101, 
                      g_apce2_d[l_ac].apde119,g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014, 
                      g_apce2_d[l_ac].apde015,g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009, 
                      g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011, 
                      g_apce2_d[l_ac].apde012,g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite, 
                      g_apce2_d[l_ac].apde001,g_apce5_d[l_ac].apdeseq,g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017, 
                      g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019,g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022, 
                      g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035,g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042, 
                      g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044,g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052, 
                      g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054,g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056, 
                      g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058,g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060, 
                      g_apce6_d[l_ac].apdeseq,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129, 
                      g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce5_d_mask_o[l_ac].* =  g_apce5_d[l_ac].*
                  CALL aapt823_apde_t_mask()
                  LET g_apce5_d_mask_n[l_ac].* =  g_apce5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            #160122-00001#5 --add--str--
            #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
            CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
            DISPLAY BY NAME g_apce2_d[l_ac].lc_apde008
            #160122-00001#5 --add--end            
           #取得自由核算項資訊
            IF NOT cl_null(g_apce2_d[l_ac].apde016) THEN
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
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
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apce5_d_t.apdeseq
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apde_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno
               AND apdeseq = g_apce5_d[l_ac].apdeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce5_d[g_detail_idx].apdeseq
               CALL aapt823_insert_b('apde_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apce_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce5_d[l_ac].* = g_apce5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
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
               LET g_apce5_d[l_ac].* = g_apce5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL aapt823_apde_t_mask_restore('restore_mask_o')
                              
               UPDATE apde_t SET (apdeld,apdedocno,apdeseq,apdeorga,apde002,apde006,apde003,apde008, 
                   apde021,apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016, 
                   apde010,apde009,apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite, 
                   apde001,apde038,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042, 
                   apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059, 
                   apde060,apde120,apde121,apde129,apde130,apde131,apde139) = (g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006, 
                   g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde024, 
                   g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119, 
                   g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde015, 
                   g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009,g_apce2_d[l_ac].apde039, 
                   g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012, 
                   g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite,g_apce2_d[l_ac].apde001, 
                   g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019, 
                   g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035, 
                   g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044, 
                   g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052,g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054, 
                   g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056,g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058, 
                   g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121, 
                   g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139)  
                   #自訂欄位頁簽
                WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
                  AND apdedocno = g_apda_m.apdadocno
                  AND apdeseq = g_apce5_d_t.apdeseq #項次 
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce5_d[l_ac].* = g_apce5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce5_d[l_ac].* = g_apce5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce5_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apce5_d_t.apdeseq
               CALL aapt823_update_b('apde_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce5_d[g_detail_idx].apdeseq = g_apce5_d_t.apdeseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce5_d_t.apdeseq
                  CALL aapt823_key_update_b(gs_keys,'apde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce5_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde038
            #add-point:BEFORE FIELD apde038 name="input.b.page5.apde038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde038
            
            #add-point:AFTER FIELD apde038 name="input.a.page5.apde038"
            LET g_apce5_d_o.* = g_apce5_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde038
            #add-point:ON CHANGE apde038 name="input.g.page5.apde038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde038_desc
            #add-point:BEFORE FIELD apde038_desc name="input.b.page5.apde038_desc"
            LET g_apce5_d[l_ac].apde038_desc = g_apce5_d[l_ac].apde038    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde038_desc
            
            #add-point:AFTER FIELD apde038_desc name="input.a.page5.apde038_desc"
            #帳款對象
            IF NOT cl_null(g_apce5_d[l_ac].apde038_desc) THEN
               #IF ( g_apce5_d[l_ac].apde038_desc != g_apce5_d_t.apde038_desc OR g_apce5_d_t.apde038_desc IS NULL ) THEN  #160822-00008#4  mark
               IF g_apce5_d[l_ac].apde038_desc != g_apce5_d_o.apde038_desc OR cl_null(g_apce5_d_o.apde038_desc) THEN      #160822-00008#4
                  LET g_apce5_d[l_ac].apde038 = g_apce5_d[l_ac].apde038_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce5_d[l_ac].apde038 != g_apce5_d_t.apde038 OR g_apce5_d_t.apde038 IS NULL) THEN  #160822-00008#4  mark
                     IF g_apce5_d[l_ac].apde038 != g_apce5_d_o.apde038 OR cl_null(g_apce5_d_o.apde038) THEN    #160822-00008#4
                        #CALL s_aap_pmaa001_chk(g_apce5_d[l_ac].apde038_desc) RETURNING g_sub_success,g_errno  #150309apo mark
                        CALL s_voucher_glaq021_chk(g_apce5_d[l_ac].apde038_desc)
                        IF NOT cl_null(g_errno) THEN
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
                           #LET g_apce5_d[l_ac].apde038      = g_apce5_d_t.apde038       #160822-00008#4  mark
                           #LET g_apce5_d[l_ac].apde038_desc = g_apce5_d_t.apde038_desc  #160822-00008#4  mark
                           LET g_apce5_d[l_ac].apde038      = g_apce5_d_o.apde038        #160822-00008#4
                           LET g_apce5_d[l_ac].apde038_desc = g_apce5_d_o.apde038_desc   #160822-00008#4
                           DISPLAY BY NAME g_apce5_d[l_ac].apde038 ,g_apce5_d[l_ac].apde038_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF    
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde038 = ''               
            END IF
            LET g_apce5_d[l_ac].apde038_desc = s_desc_show1(g_apce5_d[l_ac].apde038,s_desc_get_trading_partner_abbr_desc(g_apce5_d[l_ac].apde038))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde038 ,g_apce5_d[l_ac].apde038_desc
            LET g_apce5_d_o.* = g_apce5_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde038_desc
            #add-point:ON CHANGE apde038_desc name="input.g.page5.apde038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="input.b.page5.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="input.a.page5.apde017"
            LET g_apce5_d_o.* = g_apce5_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde017
            #add-point:ON CHANGE apde017 name="input.g.page5.apde017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017_desc
            #add-point:BEFORE FIELD apde017_desc name="input.b.page5.apde017_desc"
            LET g_apce5_d[l_ac].apde017_desc = g_apce5_d[l_ac].apde017    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017_desc
            
            #add-point:AFTER FIELD apde017_desc name="input.a.page5.apde017_desc"
            #業務人員
            IF NOT cl_null(g_apce5_d[l_ac].apde017_desc) THEN
               IF ( g_apce5_d[l_ac].apde017_desc != g_apce5_d_t.apde017_desc OR g_apce5_d_t.apde017_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde017 = g_apce5_d[l_ac].apde017_desc   
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde017 != g_apce5_d_t.apde017 OR g_apce5_d_t.apde017 IS NULL) THEN
                        CALL s_employee_chk(g_apce5_d[l_ac].apde017) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apce5_d[l_ac].apde017        = g_apce5_d_t.apde017
                           LET g_apce5_d[l_ac].apde017_desc = g_apce5_d_t.apde017_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde017_desc
                           NEXT FIELD CURRENT
                        END IF                    
                     END IF  
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde017 = ''                 
            END IF
            LET g_apce5_d[l_ac].apde017_desc = s_desc_show1(g_apce5_d[l_ac].apde017,s_desc_get_person_desc(g_apce5_d[l_ac].apde017))         
            DISPLAY BY NAME g_apce5_d[l_ac].apde017 ,g_apce5_d[l_ac].apde017_desc
            LET g_apce5_d_t.apde017_desc = g_apce5_d[l_ac].apde017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde017_desc
            #add-point:ON CHANGE apde017_desc name="input.g.page5.apde017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="input.b.page5.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="input.a.page5.apde018"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde018
            #add-point:ON CHANGE apde018 name="input.g.page5.apde018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018_desc
            #add-point:BEFORE FIELD apde018_desc name="input.b.page5.apde018_desc"
            LET g_apce5_d[l_ac].apde018_desc = g_apce5_d[l_ac].apde018    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018_desc
            
            #add-point:AFTER FIELD apde018_desc name="input.a.page5.apde018_desc"
            #業務部門
            IF NOT cl_null(g_apce5_d[l_ac].apde018_desc) THEN
               IF ( g_apce5_d[l_ac].apde018_desc != g_apce5_d_t.apde018_desc OR g_apce5_d_t.apde018_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde018 = g_apce5_d[l_ac].apde018_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde018 != g_apce5_d_t.apde018 OR g_apce5_d_t.apde018 IS NULL) THEN                  
                        CALL s_department_chk(g_apce5_d[l_ac].apde018_desc,g_apda_m.apdadocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_apce5_d[l_ac].apde018      = g_apce5_d_t.apde018
                           LET g_apce5_d[l_ac].apde018_desc = g_apce5_d_t.apde018_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde018 ,g_apce5_d[l_ac].apde018_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF      
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde018 = ''                
            END IF
            LET g_apce5_d[l_ac].apde018_desc = s_desc_show1(g_apce5_d[l_ac].apde018,s_desc_get_department_desc(g_apce5_d[l_ac].apde018))         
            DISPLAY BY NAME g_apce5_d[l_ac].apde018 ,g_apce5_d[l_ac].apde018_desc
            LET g_apce5_d_t.apde018_desc = g_apce5_d[l_ac].apde018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde018_desc
            #add-point:ON CHANGE apde018_desc name="input.g.page5.apde018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="input.b.page5.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="input.a.page5.apde019"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde019
            #add-point:ON CHANGE apde019 name="input.g.page5.apde019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019_desc
            #add-point:BEFORE FIELD apde019_desc name="input.b.page5.apde019_desc"
            LET g_apce5_d[l_ac].apde019_desc = g_apce5_d[l_ac].apde019    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019_desc
            
            #add-point:AFTER FIELD apde019_desc name="input.a.page5.apde019_desc"
            #責任中心
            IF NOT cl_null(g_apce5_d[l_ac].apde019_desc) THEN
               IF ( g_apce5_d[l_ac].apde019_desc != g_apce5_d_t.apde019_desc OR g_apce5_d_t.apde019_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde019 = g_apce5_d[l_ac].apde019_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde019 != g_apce5_d_t.apde019 OR g_apce5_d_t.apde019 IS NULL) THEN
                       # CALL s_department_chk(g_apce5_d[l_ac].apde019_desc,g_apda_m.apdadocdt) RETURNING g_sub_success
                        LET g_errno = ''                                                       #20150302
                        CALL s_voucher_glaq019_chk(g_apce5_d[l_ac].apde019_desc,g_apda_m.apdadocdt) #20150302
                        IF NOT cl_null(g_errno) THEN                           
                           LET g_apce5_d[l_ac].apde019      = g_apce5_d_t.apde019
                           LET g_apce5_d[l_ac].apde019_desc = g_apce5_d_t.apde019_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde019 ,g_apce5_d[l_ac].apde019_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde019 = ''                
            END IF
            LET g_apce5_d[l_ac].apde019_desc = s_desc_show1(g_apce5_d[l_ac].apde019,s_desc_get_department_desc(g_apce5_d[l_ac].apde019))         
            DISPLAY BY NAME g_apce5_d[l_ac].apde019 ,g_apce5_d[l_ac].apde019_desc 
            LET g_apce5_d_t.apde019_desc = g_apce5_d[l_ac].apde019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde019_desc
            #add-point:ON CHANGE apde019_desc name="input.g.page5.apde019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020
            #add-point:BEFORE FIELD apde020 name="input.b.page5.apde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020
            
            #add-point:AFTER FIELD apde020 name="input.a.page5.apde020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde020
            #add-point:ON CHANGE apde020 name="input.g.page5.apde020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde020_desc
            #add-point:BEFORE FIELD apde020_desc name="input.b.page5.apde020_desc"
            LET g_apce5_d[l_ac].apde020_desc = g_apce5_d[l_ac].apde020    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde020_desc
            
            #add-point:AFTER FIELD apde020_desc name="input.a.page5.apde020_desc"
            #產品類別
            IF NOT cl_null(g_apce5_d[l_ac].apde020_desc) THEN
               IF ( g_apce5_d[l_ac].apde020_desc != g_apce5_d_t.apde020_desc OR g_apce5_d_t.apde020_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde020 = g_apce5_d[l_ac].apde020_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde020 != g_apce5_d_t.apde020 OR g_apce5_d_t.apde020 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_apce5_d[l_ac].apde020)
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
                           LET g_apce5_d[l_ac].apde020      = g_apce5_d_t.apde020
                           LET g_apce5_d[l_ac].apde020_desc = g_apce5_d_t.apde020_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde020 ,g_apce5_d[l_ac].apde020_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF       
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde020 = ''                
            END IF
            LET g_apce5_d[l_ac].apde020_desc = s_desc_show1(g_apce5_d[l_ac].apde020,s_desc_get_rtaxl003_desc(g_apce5_d[l_ac].apde020))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde020 ,g_apce5_d[l_ac].apde020_desc
            LET g_apce5_d_t.apde020_desc = g_apce5_d[l_ac].apde020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde020_desc
            #add-point:ON CHANGE apde020_desc name="input.g.page5.apde020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022
            #add-point:BEFORE FIELD apde022 name="input.b.page5.apde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022
            
            #add-point:AFTER FIELD apde022 name="input.a.page5.apde022"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde022
            #add-point:ON CHANGE apde022 name="input.g.page5.apde022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde022_desc
            #add-point:BEFORE FIELD apde022_desc name="input.b.page5.apde022_desc"
            LET g_apce5_d[l_ac].apde022_desc = g_apce5_d[l_ac].apde022    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde022_desc
            
            #add-point:AFTER FIELD apde022_desc name="input.a.page5.apde022_desc"
            #專案編號
            IF NOT cl_null(g_apce5_d[l_ac].apde022_desc) THEN
               IF ( g_apce5_d[l_ac].apde022_desc != g_apce5_d_t.apde022_desc OR g_apce5_d_t.apde022_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde022 = g_apce5_d[l_ac].apde022_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde022 != g_apce5_d_t.apde022 OR g_apce5_d_t.apde022 IS NULL) THEN
                        CALL s_aap_project_chk(g_apce5_d[l_ac].apde022) RETURNING g_sub_success,g_errno
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
                           LET g_apce5_d[l_ac].apde022      = g_apce5_d_t.apde022
                           LET g_apce5_d[l_ac].apde022_desc = g_apce5_d_t.apde022_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde022 ,g_apce5_d[l_ac].apde022_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF    
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde022 = ''                 
            END IF
            LET g_apce5_d[l_ac].apde022_desc = s_desc_show1(g_apce5_d[l_ac].apde022,s_desc_get_project_desc(g_apce5_d[l_ac].apde022))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde022 ,g_apce5_d[l_ac].apde022_desc
            LET g_apce5_d_t.apde022_desc = g_apce5_d[l_ac].apde022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde022_desc
            #add-point:ON CHANGE apde022_desc name="input.g.page5.apde022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023
            #add-point:BEFORE FIELD apde023 name="input.b.page5.apde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023
            
            #add-point:AFTER FIELD apde023 name="input.a.page5.apde023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde023
            #add-point:ON CHANGE apde023 name="input.g.page5.apde023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde023_desc
            #add-point:BEFORE FIELD apde023_desc name="input.b.page5.apde023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde023_desc
            
            #add-point:AFTER FIELD apde023_desc name="input.a.page5.apde023_desc"
            #WBS
            IF NOT cl_null(g_apce5_d[l_ac].apde023_desc)  THEN
               IF ( g_apce5_d[l_ac].apde023_desc != g_apce5_d_t.apde023_desc OR g_apce5_d_t.apde023_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde023 = g_apce5_d[l_ac].apde023_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde023 != g_apce5_d_t.apde023 OR g_apce5_d_t.apde023 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023)
                       #CALL s_aap_project_chk( g_apce5_d[l_ac].apde023) RETURNING g_sub_success,g_errno
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apce5_d[l_ac].apde023        = g_apce5_d_t.apde023
                           LET g_apce5_d[l_ac].apde023_desc = g_apce5_d_t.apde023_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde023 = ''
            END IF
            LET g_apce5_d[l_ac].apde023_desc = s_desc_show1(g_apce5_d[l_ac].apde023,s_desc_get_pjbbl004_desc(g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023))
            DISPLAY BY NAME g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde023_desc
            LET g_apce5_d_t.apde023_desc = g_apce5_d[l_ac].apde023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde023_desc
            #add-point:ON CHANGE apde023_desc name="input.g.page5.apde023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035
            #add-point:BEFORE FIELD apde035 name="input.b.page5.apde035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035
            
            #add-point:AFTER FIELD apde035 name="input.a.page5.apde035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde035
            #add-point:ON CHANGE apde035 name="input.g.page5.apde035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde035_desc
            #add-point:BEFORE FIELD apde035_desc name="input.b.page5.apde035_desc"
            LET g_apce5_d[l_ac].apde035_desc = g_apce5_d[l_ac].apde035    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde035_desc
            
            #add-point:AFTER FIELD apde035_desc name="input.a.page5.apde035_desc"
            #區域
            IF NOT cl_null(g_apce5_d[l_ac].apde035_desc) THEN
               IF ( g_apce5_d[l_ac].apde035_desc != g_apce5_d_t.apde035_desc OR g_apce5_d_t.apde035_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde035 = g_apce5_d[l_ac].apde035_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde035 != g_apce5_d_t.apde035 OR g_apce5_d_t.apde035 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_apce5_d[l_ac].apde035) THEN
                           LET g_apce5_d[l_ac].apde035      = g_apce5_d_t.apde035
                           LET g_apce5_d[l_ac].apde035_desc = g_apce5_d_t.apde035_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde035 ,g_apce5_d[l_ac].apde035_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF 
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde035 = ''                 
            END IF
            LET g_apce5_d[l_ac].apde035_desc = s_desc_show1(g_apce5_d[l_ac].apde035,s_desc_get_acc_desc('287',g_apce5_d[l_ac].apde035))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde035 ,g_apce5_d[l_ac].apde035_desc
            LET g_apce5_d_t.apde035_desc = g_apce5_d[l_ac].apde035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde035_desc
            #add-point:ON CHANGE apde035_desc name="input.g.page5.apde035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036
            #add-point:BEFORE FIELD apde036 name="input.b.page5.apde036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036
            
            #add-point:AFTER FIELD apde036 name="input.a.page5.apde036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde036
            #add-point:ON CHANGE apde036 name="input.g.page5.apde036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde036_desc
            #add-point:BEFORE FIELD apde036_desc name="input.b.page5.apde036_desc"
            LET g_apce5_d[l_ac].apde036_desc = g_apce5_d[l_ac].apde036    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde036_desc
            
            #add-point:AFTER FIELD apde036_desc name="input.a.page5.apde036_desc"
            #客群
            IF NOT cl_null(g_apce5_d[l_ac].apde036_desc) THEN
               IF ( g_apce5_d[l_ac].apde036_desc != g_apce5_d_t.apde036_desc OR g_apce5_d_t.apde036_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde036 = g_apce5_d[l_ac].apde036_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde036 != g_apce5_d_t.apde036 OR g_apce5_d_t.apde036 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_apce5_d[l_ac].apde036) THEN
                           LET g_apce5_d[l_ac].apde036      = g_apce5_d_t.apde036
                           LET g_apce5_d[l_ac].apde036_desc = g_apce5_d_t.apde036_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde036 ,g_apce5_d[l_ac].apde036_desc
                           NEXT FIELD CURRENT
                        END IF                 
                     END IF    
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde036 = ''                
            END IF
            LET g_apce5_d[l_ac].apde036_desc = s_desc_show1(g_apce5_d[l_ac].apde036,s_desc_get_acc_desc('281',g_apce5_d[l_ac].apde036))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde036 ,g_apce5_d[l_ac].apde036_desc 
            LET g_apce5_d_t.apde036_desc = g_apce5_d[l_ac].apde036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde036_desc
            #add-point:ON CHANGE apde036_desc name="input.g.page5.apde036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042
            #add-point:BEFORE FIELD apde042 name="input.b.page5.apde042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042
            
            #add-point:AFTER FIELD apde042 name="input.a.page5.apde042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde042
            #add-point:ON CHANGE apde042 name="input.g.page5.apde042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde042_desc
            #add-point:BEFORE FIELD apde042_desc name="input.b.page5.apde042_desc"
            LET g_apce5_d[l_ac].apde042_desc = g_apce5_d[l_ac].apde042    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde042_desc
            
            #add-point:AFTER FIELD apde042_desc name="input.a.page5.apde042_desc"
            #經營方式
            IF NOT cl_null(g_apce5_d[l_ac].apde042_desc) THEN
               IF ( g_apce5_d[l_ac].apde042_desc != g_apce5_d_t.apde042_desc OR g_apce5_d_t.apde042_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde042 = g_apce5_d[l_ac].apde042_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde042 != g_apce5_d_t.apde042 OR g_apce5_d_t.apde042 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_apce5_d[l_ac].apde042) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apce5_d[l_ac].apde042 = g_apce5_d_t.apde042
                           LET g_apce5_d[l_ac].apde042_desc = g_apce5_d_t.apde042_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde042_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde042 = ''                
            END IF
            LET g_apce5_d[l_ac].apde042_desc = g_apce5_d[l_ac].apde042
            DISPLAY BY NAME g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde042_desc
            LET g_apce5_d_t.apde042_desc = g_apce5_d[l_ac].apde042_desc   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde042_desc
            #add-point:ON CHANGE apde042_desc name="input.g.page5.apde042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043
            #add-point:BEFORE FIELD apde043 name="input.b.page5.apde043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043
            
            #add-point:AFTER FIELD apde043 name="input.a.page5.apde043"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde043
            #add-point:ON CHANGE apde043 name="input.g.page5.apde043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde043_desc
            #add-point:BEFORE FIELD apde043_desc name="input.b.page5.apde043_desc"
            LET g_apce5_d[l_ac].apde043_desc = g_apce5_d[l_ac].apde043    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde043_desc
            
            #add-point:AFTER FIELD apde043_desc name="input.a.page5.apde043_desc"
            #渠道
            IF NOT cl_null(g_apce5_d[l_ac].apde043_desc) THEN
               IF ( g_apce5_d[l_ac].apde043_desc != g_apce5_d_t.apde043_desc OR g_apce5_d_t.apde043_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde043 = g_apce5_d[l_ac].apde043_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde043 != g_apce5_d_t.apde043 OR g_apce5_d_t.apde043 IS NULL) THEN
                        CALL s_voucher_glaq052_chk(g_apce5_d[l_ac].apde043) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apce5_d[l_ac].apde043 = g_apce5_d_t.apde043
                           LET g_apce5_d[l_ac].apde043_desc = g_apce5_d_t.apde043_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde043_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END iF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde043 = ''                  
            END IF
            LET g_apce5_d[l_ac].apde043_desc = s_desc_show1(g_apce5_d[l_ac].apde043,s_desc_get_oojdl003_desc(g_apce5_d[l_ac].apde043))
            DISPLAY BY NAME g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde043_desc
            LET g_apce5_d_t.apde043_desc = g_apce5_d[l_ac].apde043_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde043_desc
            #add-point:ON CHANGE apde043_desc name="input.g.page5.apde043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044
            #add-point:BEFORE FIELD apde044 name="input.b.page5.apde044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044
            
            #add-point:AFTER FIELD apde044 name="input.a.page5.apde044"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde044
            #add-point:ON CHANGE apde044 name="input.g.page5.apde044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde044_desc
            #add-point:BEFORE FIELD apde044_desc name="input.b.page5.apde044_desc"
            LET g_apce5_d[l_ac].apde044_desc = g_apce5_d[l_ac].apde044    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde044_desc
            
            #add-point:AFTER FIELD apde044_desc name="input.a.page5.apde044_desc"
            #品牌
            IF NOT cl_null(g_apce5_d[l_ac].apde044_desc) THEN
               IF ( g_apce5_d[l_ac].apde044_desc != g_apce5_d_t.apde044_desc OR g_apce5_d_t.apde044_desc IS NULL ) THEN
                  LET g_apce5_d[l_ac].apde044 = g_apce5_d[l_ac].apde044_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde044 != g_apce5_d_t.apde044 OR g_apce5_d_t.apde044 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('2002',g_apce5_d[l_ac].apde044) THEN
                           LET g_apce5_d[l_ac].apde044      = g_apce5_d_t.apde044
                           LET g_apce5_d[l_ac].apde044_desc = g_apce5_d_t.apde044_desc
                           DISPLAY BY NAME g_apce5_d[l_ac].apde044 ,g_apce5_d[l_ac].apde044_desc
                           NEXT FIELD CURRENT
                        END IF                  
                     END IF     
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde044 = ''                  
            END IF
            LET g_apce5_d[l_ac].apde044_desc = s_desc_show1(g_apce5_d[l_ac].apde044,s_desc_get_acc_desc('2002',g_apce5_d[l_ac].apde044))      
            DISPLAY BY NAME g_apce5_d[l_ac].apde044 ,g_apce5_d[l_ac].apde044_desc
            LET g_apce5_d_t.apde044_desc = g_apce5_d[l_ac].apde044_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde044_desc
            #add-point:ON CHANGE apde044_desc name="input.g.page5.apde044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051
            #add-point:BEFORE FIELD apde051 name="input.b.page5.apde051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051
            
            #add-point:AFTER FIELD apde051 name="input.a.page5.apde051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde051
            #add-point:ON CHANGE apde051 name="input.g.page5.apde051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde051_desc
            #add-point:BEFORE FIELD apde051_desc name="input.b.page5.apde051_desc"
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde051_desc = g_apce5_d[l_ac].apde051    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde051_desc
            
            #add-point:AFTER FIELD apde051_desc name="input.a.page5.apde051_desc"
            #自由核算項一
            IF NOT cl_null(g_apce5_d[l_ac].apde051_desc) THEN
               IF (g_apce5_d[l_ac].apde051_desc != g_apce5_d_t.apde051_desc OR g_apce5_d_t.apde051_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde051 = g_apce5_d[l_ac].apde051_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde051 != g_apce5_d_t.apde051 OR g_apce5_d_t.apde051 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_apce5_d[l_ac].apde051,g_glad.glad0172) RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde051 = g_apce5_d_t.apde051
                           LET g_apce5_d[l_ac].apde051_desc = s_desc_show1(g_apce5_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apce5_d[l_ac].apde051))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde051_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde051 = ''                  
            END IF
            LET g_apce5_d[l_ac].apde051_desc = s_desc_show1(g_apce5_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apce5_d[l_ac].apde051))
            DISPLAY BY NAME g_apce5_d[l_ac].apde051_desc
            LET g_apce5_d_t.apde051_desc = g_apce5_d[l_ac].apde051_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde051_desc
            #add-point:ON CHANGE apde051_desc name="input.g.page5.apde051_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052
            #add-point:BEFORE FIELD apde052 name="input.b.page5.apde052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052
            
            #add-point:AFTER FIELD apde052 name="input.a.page5.apde052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde052
            #add-point:ON CHANGE apde052 name="input.g.page5.apde052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde052_desc
            #add-point:BEFORE FIELD apde052_desc name="input.b.page5.apde052_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde052_desc = g_apce5_d[l_ac].apde052    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde052_desc
            
            #add-point:AFTER FIELD apde052_desc name="input.a.page5.apde052_desc"
            #自由核算項二
            IF NOT cl_null(g_apce5_d[l_ac].apde052_desc) THEN
               IF (g_apce5_d[l_ac].apde052_desc != g_apce5_d_t.apde052_desc OR g_apce5_d_t.apde052_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde052 = g_apce5_d[l_ac].apde052_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde052 != g_apce5_d_t.apde052 OR g_apce5_d_t.apde052 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_apce5_d[l_ac].apde052,g_glad.glad0182)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde052 = g_apce5_d_t.apde052
                           LET g_apce5_d[l_ac].apde052_desc = s_desc_show1(g_apce5_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apce5_d[l_ac].apde052))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde052_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde052 = ''                   
            END IF
            LET g_apce5_d[l_ac].apde052_desc = s_desc_show1(g_apce5_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apce5_d[l_ac].apde052))
            DISPLAY BY NAME g_apce5_d[l_ac].apde052_desc
            LET g_apce5_d_t.apde052_desc = g_apce5_d[l_ac].apde052_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde052_desc
            #add-point:ON CHANGE apde052_desc name="input.g.page5.apde052_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053
            #add-point:BEFORE FIELD apde053 name="input.b.page5.apde053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053
            
            #add-point:AFTER FIELD apde053 name="input.a.page5.apde053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde053
            #add-point:ON CHANGE apde053 name="input.g.page5.apde053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde053_desc
            #add-point:BEFORE FIELD apde053_desc name="input.b.page5.apde053_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde053_desc = g_apce5_d[l_ac].apde053    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde053_desc
            
            #add-point:AFTER FIELD apde053_desc name="input.a.page5.apde053_desc"
            #自由核算項三
            IF NOT cl_null(g_apce5_d[l_ac].apde053_desc) THEN
               IF (g_apce5_d[l_ac].apde053_desc != g_apce5_d_t.apde053_desc OR g_apce5_d_t.apde053_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde053 = g_apce5_d[l_ac].apde053_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde053 != g_apce5_d_t.apde053 OR g_apce5_d_t.apde053 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_apce5_d[l_ac].apde053,g_glad.glad0192)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde053 = g_apce5_d_t.apde053
                           LET g_apce5_d[l_ac].apde053_desc = s_desc_show1(g_apce5_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apce5_d[l_ac].apde053))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde053_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde053 = ''                    
            END IF
            LET g_apce5_d[l_ac].apde053_desc = s_desc_show1(g_apce5_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apce5_d[l_ac].apde053))
            DISPLAY BY NAME g_apce5_d[l_ac].apde053_desc
            LET g_apce5_d_t.apde053_desc = g_apce5_d[l_ac].apde053_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde053_desc
            #add-point:ON CHANGE apde053_desc name="input.g.page5.apde053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054
            #add-point:BEFORE FIELD apde054 name="input.b.page5.apde054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054
            
            #add-point:AFTER FIELD apde054 name="input.a.page5.apde054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde054
            #add-point:ON CHANGE apde054 name="input.g.page5.apde054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde054_desc
            #add-point:BEFORE FIELD apde054_desc name="input.b.page5.apde054_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde054_desc = g_apce5_d[l_ac].apde054    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde054_desc
            
            #add-point:AFTER FIELD apde054_desc name="input.a.page5.apde054_desc"
            #自由核算項四
            IF NOT cl_null(g_apce5_d[l_ac].apde054_desc) THEN
               IF (g_apce5_d[l_ac].apde054_desc != g_apce5_d_t.apde054_desc OR g_apce5_d_t.apde054_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde054 = g_apce5_d[l_ac].apde054_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde054 != g_apce5_d_t.apde054 OR g_apce5_d_t.apde054 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_apce5_d[l_ac].apde054,g_glad.glad0202)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde054 = g_apce5_d_t.apde054
                           LET g_apce5_d[l_ac].apde054_desc = s_desc_show1(g_apce5_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apce5_d[l_ac].apde054))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde054_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde054 = ''               
            END IF
            LET g_apce5_d[l_ac].apde054_desc = s_desc_show1(g_apce5_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apce5_d[l_ac].apde054))
            DISPLAY BY NAME g_apce5_d[l_ac].apde054_desc
            LET g_apce5_d_t.apde054_desc = g_apce5_d[l_ac].apde054_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde054_desc
            #add-point:ON CHANGE apde054_desc name="input.g.page5.apde054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055
            #add-point:BEFORE FIELD apde055 name="input.b.page5.apde055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055
            
            #add-point:AFTER FIELD apde055 name="input.a.page5.apde055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde055
            #add-point:ON CHANGE apde055 name="input.g.page5.apde055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde055_desc
            #add-point:BEFORE FIELD apde055_desc name="input.b.page5.apde055_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde055_desc = g_apce5_d[l_ac].apde055    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde055_desc
            
            #add-point:AFTER FIELD apde055_desc name="input.a.page5.apde055_desc"
            #自由核算項五
            IF NOT cl_null(g_apce5_d[l_ac].apde055_desc) THEN
               IF (g_apce5_d[l_ac].apde055_desc != g_apce5_d_t.apde055_desc OR g_apce5_d_t.apde055_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde055 = g_apce5_d[l_ac].apde055_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde055 != g_apce5_d_t.apde055 OR g_apce5_d_t.apde055 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_apce5_d[l_ac].apde055,g_glad.glad0212)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde055 = g_apce5_d_t.apde055
                           LET g_apce5_d[l_ac].apde055_desc = s_desc_show1(g_apce5_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apce5_d[l_ac].apde055))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde055_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde055 = ''                  
            END IF
             LET g_apce5_d[l_ac].apde055_desc = s_desc_show1(g_apce5_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apce5_d[l_ac].apde055))
             DISPLAY BY NAME g_apce5_d[l_ac].apde055_desc
             LET g_apce5_d_t.apde055_desc = g_apce5_d[l_ac].apde055_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde055_desc
            #add-point:ON CHANGE apde055_desc name="input.g.page5.apde055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056
            #add-point:BEFORE FIELD apde056 name="input.b.page5.apde056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056
            
            #add-point:AFTER FIELD apde056 name="input.a.page5.apde056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde056
            #add-point:ON CHANGE apde056 name="input.g.page5.apde056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde056_desc
            #add-point:BEFORE FIELD apde056_desc name="input.b.page5.apde056_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde056_desc = g_apce5_d[l_ac].apde056    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde056_desc
            
            #add-point:AFTER FIELD apde056_desc name="input.a.page5.apde056_desc"
            #自由核算項六
            IF NOT cl_null(g_apce5_d[l_ac].apde056_desc) THEN
               IF (g_apce5_d[l_ac].apde056_desc != g_apce5_d_t.apde056_desc OR g_apce5_d_t.apde056_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde056 = g_apce5_d[l_ac].apde056_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde056 != g_apce5_d_t.apde056 OR g_apce5_d_t.apde056 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_apce5_d[l_ac].apde056,g_glad.glad0222)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde056 = g_apce5_d_t.apde056
                           LET g_apce5_d[l_ac].apde056_desc = s_desc_show1(g_apce5_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apce5_d[l_ac].apde056))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde056_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde056 = ''                
            END IF
            LET g_apce5_d[l_ac].apde056_desc = s_desc_show1(g_apce5_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apce5_d[l_ac].apde056))
            DISPLAY BY NAME g_apce5_d[l_ac].apde056_desc
            LET g_apce5_d_t.apde056_desc = g_apce5_d[l_ac].apde056_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde056_desc
            #add-point:ON CHANGE apde056_desc name="input.g.page5.apde056_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057
            #add-point:BEFORE FIELD apde057 name="input.b.page5.apde057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057
            
            #add-point:AFTER FIELD apde057 name="input.a.page5.apde057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde057
            #add-point:ON CHANGE apde057 name="input.g.page5.apde057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde057_desc
            #add-point:BEFORE FIELD apde057_desc name="input.b.page5.apde057_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde057_desc = g_apce5_d[l_ac].apde057    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde057_desc
            
            #add-point:AFTER FIELD apde057_desc name="input.a.page5.apde057_desc"
            #自由核算項七
            IF NOT cl_null(g_apce5_d[l_ac].apde057_desc) THEN
               IF (g_apce5_d[l_ac].apde057_desc != g_apce5_d_t.apde057_desc OR g_apce5_d_t.apde057_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde057 = g_apce5_d[l_ac].apde057_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde057 != g_apce5_d_t.apde057 OR g_apce5_d_t.apde057 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_apce5_d[l_ac].apde057,g_glad.glad0232)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde057 = g_apce5_d_t.apde057
                           LET g_apce5_d[l_ac].apde057_desc = s_desc_show1(g_apce5_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apce5_d[l_ac].apde057))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde057_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde057 = ''                
            END IF
            LET g_apce5_d[l_ac].apde057_desc = s_desc_show1(g_apce5_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apce5_d[l_ac].apde057))
            DISPLAY BY NAME g_apce5_d[l_ac].apde057_desc
            LET g_apce5_d_t.apde057_desc = g_apce5_d[l_ac].apde057_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde057_desc
            #add-point:ON CHANGE apde057_desc name="input.g.page5.apde057_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058
            #add-point:BEFORE FIELD apde058 name="input.b.page5.apde058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058
            
            #add-point:AFTER FIELD apde058 name="input.a.page5.apde058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde058
            #add-point:ON CHANGE apde058 name="input.g.page5.apde058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde058_desc
            #add-point:BEFORE FIELD apde058_desc name="input.b.page5.apde058_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde058_desc = g_apce5_d[l_ac].apde058    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde058_desc
            
            #add-point:AFTER FIELD apde058_desc name="input.a.page5.apde058_desc"
            #自由核算項八
            IF NOT cl_null(g_apce5_d[l_ac].apde058_desc) THEN
               IF (g_apce5_d[l_ac].apde058_desc != g_apce5_d_t.apde058_desc OR g_apce5_d_t.apde058_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde058 = g_apce5_d[l_ac].apde058_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde058 != g_apce5_d_t.apde058 OR g_apce5_d_t.apde058 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_apce5_d[l_ac].apde058,g_glad.glad0242) RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde058 = g_apce5_d_t.apde058
                           LET g_apce5_d[l_ac].apde058_desc = s_desc_show1(g_apce5_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apce5_d[l_ac].apde058))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde058_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde058 = ''               
            END IF
            LET g_apce5_d[l_ac].apde058_desc = s_desc_show1(g_apce5_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apce5_d[l_ac].apde058))
            DISPLAY BY NAME g_apce5_d[l_ac].apde058_desc
            LET g_apce5_d_t.apde058_desc = g_apce5_d[l_ac].apde058_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde058_desc
            #add-point:ON CHANGE apde058_desc name="input.g.page5.apde058_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059
            #add-point:BEFORE FIELD apde059 name="input.b.page5.apde059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059
            
            #add-point:AFTER FIELD apde059 name="input.a.page5.apde059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde059
            #add-point:ON CHANGE apde059 name="input.g.page5.apde059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde059_desc
            #add-point:BEFORE FIELD apde059_desc name="input.b.page5.apde059_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde059_desc = g_apce5_d[l_ac].apde059    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde059_desc
            
            #add-point:AFTER FIELD apde059_desc name="input.a.page5.apde059_desc"
            #自由核算項九
            IF NOT cl_null(g_apce5_d[l_ac].apde059_desc) THEN
               IF (g_apce5_d[l_ac].apde059_desc != g_apce5_d_t.apde059_desc OR g_apce5_d_t.apde059_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde059 = g_apce5_d[l_ac].apde059_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde059 != g_apce5_d_t.apde059 OR g_apce5_d_t.apde059 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_apce5_d[l_ac].apde059,g_glad.glad0252)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde059 = g_apce5_d_t.apde059
                           LET g_apce5_d[l_ac].apde059_desc = s_desc_show1(g_apce5_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apce5_d[l_ac].apde059))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde059_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde059 = ''                    
            END IF
            LET g_apce5_d[l_ac].apde059_desc = s_desc_show1(g_apce5_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apce5_d[l_ac].apde059))
            DISPLAY BY NAME g_apce5_d[l_ac].apde059_desc
            LET g_apce5_d_t.apde059_desc = g_apce5_d[l_ac].apde059_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde059_desc
            #add-point:ON CHANGE apde059_desc name="input.g.page5.apde059_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060
            #add-point:BEFORE FIELD apde060 name="input.b.page5.apde060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060
            
            #add-point:AFTER FIELD apde060 name="input.a.page5.apde060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde060
            #add-point:ON CHANGE apde060 name="input.g.page5.apde060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde060_desc
            #add-point:BEFORE FIELD apde060_desc name="input.b.page5.apde060_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apce5_d[l_ac].apde060_desc = g_apce5_d[l_ac].apde060    #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde060_desc
            
            #add-point:AFTER FIELD apde060_desc name="input.a.page5.apde060_desc"
            #自由核算項十
            IF NOT cl_null(g_apce5_d[l_ac].apde060_desc) THEN
               IF (g_apce5_d[l_ac].apde060_desc != g_apce5_d_t.apde060_desc OR g_apce5_d_t.apde060_desc IS NULL) THEN
                  LET g_apce5_d[l_ac].apde060 = g_apce5_d[l_ac].apde060_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce5_d[l_ac].apde060 != g_apce5_d_t.apde060 OR g_apce5_d_t.apde060 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_apce5_d[l_ac].apde060,g_glad.glad0262)  RETURNING g_errno
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
                           LET g_apce5_d[l_ac].apde060 = g_apce5_d_t.apde060
                           LET g_apce5_d[l_ac].apde060_desc = s_desc_show1(g_apce5_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apce5_d[l_ac].apde060))
                           DISPLAY BY NAME g_apce5_d[l_ac].apde060_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce5_d[l_ac].apde060 = ''               
            END IF
            LET g_apce5_d[l_ac].apde060_desc = s_desc_show1(g_apce5_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apce5_d[l_ac].apde060))
            DISPLAY BY NAME g_apce5_d[l_ac].apde060_desc
            LET g_apce5_d_t.apde060_desc = g_apce5_d[l_ac].apde060_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde060_desc
            #add-point:ON CHANGE apde060_desc name="input.g.page5.apde060_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.apde038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde038
            #add-point:ON ACTION controlp INFIELD apde038 name="input.c.page5.apde038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde038_desc
            #add-point:ON ACTION controlp INFIELD apde038_desc name="input.c.page5.apde038_desc"
            #帳款對象
            #開窗i段		      
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde038
            LET g_qryparam.arg1 = "('1','3')"
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001_1()            
            LET g_apce5_d[l_ac].apde038 = g_qryparam.return1    
            LET g_apce5_d[l_ac].apde038_desc = g_qryparam.return1
            DISPLAY BY NAME g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde038_desc
            NEXT FIELD apde038_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="input.c.page5.apde017"
    
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017_desc
            #add-point:ON ACTION controlp INFIELD apde017_desc name="input.c.page5.apde017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde017
            CALL q_ooag001_8()                          
            LET g_apce5_d[l_ac].apde017 = g_qryparam.return1    
            LET g_apce5_d[l_ac].apde017_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde017_desc
            NEXT FIELD apde017_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="input.c.page5.apde018"
 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018_desc
            #add-point:ON ACTION controlp INFIELD apde018_desc name="input.c.page5.apde018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde018
            LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apce5_d[l_ac].apde018 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde018_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde018_desc
            NEXT FIELD apde018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="input.c.page5.apde019"
 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019_desc
            #add-point:ON ACTION controlp INFIELD apde019_desc name="input.c.page5.apde019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde019
            LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_5()
            LET g_apce5_d[l_ac].apde019 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde019_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde019,g_apce5_d[l_ac].apde019_desc
            NEXT FIELD apde019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020
            #add-point:ON ACTION controlp INFIELD apde020 name="input.c.page5.apde020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde020_desc
            #add-point:ON ACTION controlp INFIELD apde020_desc name="input.c.page5.apde020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde020
            CALL q_rtax001()                          
            LET g_apce5_d[l_ac].apde020 = g_qryparam.return1    
            LET g_apce5_d[l_ac].apde020_desc = g_qryparam.return1    
            DISPLAY BY NAME  g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde020_desc
            NEXT FIELD apde020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022
            #add-point:ON ACTION controlp INFIELD apde022 name="input.c.page5.apde022"
 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde022_desc
            #add-point:ON ACTION controlp INFIELD apde022_desc name="input.c.page5.apde022_desc"
            #專案編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde022
            CALL q_pjba001()
            LET g_apce5_d[l_ac].apde022 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde022_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde022_desc
            NEXT FIELD apde022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023
            #add-point:ON ACTION controlp INFIELD apde023 name="input.c.page5.apde023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde023_desc
            #add-point:ON ACTION controlp INFIELD apde023_desc name="input.c.page5.apde023_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde023
            IF NOT cl_null(g_apce5_d[l_ac].apde022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apce5_d[l_ac].apde022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF

            CALL q_pjbb002()
            LET g_apce5_d[l_ac].apde023        = g_qryparam.return1
            LET g_apce5_d[l_ac].apde023_desc = g_apce5_d[l_ac].apde023
            DISPLAY BY NAME g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde023_desc
            NEXT FIELD apde023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035
            #add-point:ON ACTION controlp INFIELD apde035 name="input.c.page5.apde035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde035_desc
            #add-point:ON ACTION controlp INFIELD apde035_desc name="input.c.page5.apde035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde035
            CALL q_oocq002_287()
            LET g_apce5_d[l_ac].apde035 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde035_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde035,g_apce5_d[l_ac].apde035_desc
            NEXT FIELD apde035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036
            #add-point:ON ACTION controlp INFIELD apde036 name="input.c.page5.apde036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde036_desc
            #add-point:ON ACTION controlp INFIELD apde036_desc name="input.c.page5.apde036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde036
            CALL q_oocq002_281()
            LET g_apce5_d[l_ac].apde036 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde036_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde036_desc
            NEXT FIELD apde036_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042
            #add-point:ON ACTION controlp INFIELD apde042 name="input.c.page5.apde042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde042_desc
            #add-point:ON ACTION controlp INFIELD apde042_desc name="input.c.page5.apde042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043
            #add-point:ON ACTION controlp INFIELD apde043 name="input.c.page5.apde043"
           
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde043_desc
            #add-point:ON ACTION controlp INFIELD apde043_desc name="input.c.page5.apde043_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde043
            CALL q_oojd001_2()
            LET g_apce5_d[l_ac].apde043 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde043_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde043_desc
            NEXT FIELD apde043_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044
            #add-point:ON ACTION controlp INFIELD apde044 name="input.c.page5.apde044"
 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde044_desc
            #add-point:ON ACTION controlp INFIELD apde044_desc name="input.c.page5.apde044_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce5_d[l_ac].apde044
            CALL q_oocq002_2002()
            LET g_apce5_d[l_ac].apde044 = g_qryparam.return1   
            LET g_apce5_d[l_ac].apde044_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce5_d[l_ac].apde044,g_apce5_d[l_ac].apde044_desc
            NEXT FIELD apde044_desc
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051
            #add-point:ON ACTION controlp INFIELD apde051 name="input.c.page5.apde051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde051_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde051_desc
            #add-point:ON ACTION controlp INFIELD apde051_desc name="input.c.page5.apde051_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde051
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde051      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde051_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde051_desc
               NEXT FIELD apde051_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052
            #add-point:ON ACTION controlp INFIELD apde052 name="input.c.page5.apde052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde052_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde052_desc
            #add-point:ON ACTION controlp INFIELD apde052_desc name="input.c.page5.apde052_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde052
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde052      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde052_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde052,g_apce5_d[l_ac].apde052_desc
               NEXT FIELD apde052_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053
            #add-point:ON ACTION controlp INFIELD apde053 name="input.c.page5.apde053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde053_desc
            #add-point:ON ACTION controlp INFIELD apde053_desc name="input.c.page5.apde053_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde053
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde053      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde053_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde053_desc
               NEXT FIELD apde053_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054
            #add-point:ON ACTION controlp INFIELD apde054 name="input.c.page5.apde054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde054_desc
            #add-point:ON ACTION controlp INFIELD apde054_desc name="input.c.page5.apde054_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde054
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde054      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde054_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde054,g_apce5_d[l_ac].apde054_desc
               NEXT FIELD apde054_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055
            #add-point:ON ACTION controlp INFIELD apde055 name="input.c.page5.apde055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde055_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde055_desc
            #add-point:ON ACTION controlp INFIELD apde055_desc name="input.c.page5.apde055_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde055
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde055      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde055_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde055_desc
               NEXT FIELD apde055_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056
            #add-point:ON ACTION controlp INFIELD apde056 name="input.c.page5.apde056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde056_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde056_desc
            #add-point:ON ACTION controlp INFIELD apde056_desc name="input.c.page5.apde056_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde056
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde056      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde056_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde056,g_apce5_d[l_ac].apde056_desc
               NEXT FIELD apde056_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057
            #add-point:ON ACTION controlp INFIELD apde057 name="input.c.page5.apde057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde057_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde057_desc
            #add-point:ON ACTION controlp INFIELD apde057_desc name="input.c.page5.apde057_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde057
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde057      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde057_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde057_desc
               NEXT FIELD apde057_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058
            #add-point:ON ACTION controlp INFIELD apde058 name="input.c.page5.apde058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde058_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde058_desc
            #add-point:ON ACTION controlp INFIELD apde058_desc name="input.c.page5.apde058_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde058
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde058      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde058_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde058,g_apce5_d[l_ac].apde058_desc
               NEXT FIELD apde058_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059
            #add-point:ON ACTION controlp INFIELD apde059 name="input.c.page5.apde059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde059_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde059_desc
            #add-point:ON ACTION controlp INFIELD apde059_desc name="input.c.page5.apde059_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde059
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde059      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde059_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde059_desc
               NEXT FIELD apde059_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060
            #add-point:ON ACTION controlp INFIELD apde060 name="input.c.page5.apde060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.apde060_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde060_desc
            #add-point:ON ACTION controlp INFIELD apde060_desc name="input.c.page5.apde060_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce5_d[l_ac].apde060
               
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_apce5_d[l_ac].apde060      = g_qryparam.return1
               LET g_apce5_d[l_ac].apde060_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce5_d[l_ac].apde060,g_apce5_d[l_ac].apde060_desc
               NEXT FIELD apde060_desc
            END IF 
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            LET l_ac = ARR_CURR()
            IF l_ac > 0 THEN
               CALL l_account.clear()
               LET l_account[7].f1  = g_apce5_d[l_ac].apde018    LET l_account[7].f2 = "apde018"      LET l_account[7].f3 = g_apda_m.apdadocdt  #部門
               LET l_account[8].f1  = g_apce5_d[l_ac].apde019    LET l_account[8].f2 = "apde019"      #責任中心
               LET l_account[9].f1  = g_apce5_d[l_ac].apde035    LET l_account[9].f2 = "apde035"	   #區域
               LET l_account[10].f1 = g_apce5_d[l_ac].apde038    LET l_account[10].f2 = "apde038"	   #交易客商      
               LET l_account[11].f1 = g_apce5_d[l_ac].apde036    LET l_account[11].f2 = "apde036"	   #客群
               
               LET l_account[12].f1 = g_apce5_d[l_ac].apde020    LET l_account[12].f2 = "apde020"	   #產品類別      
               LET l_account[13].f1 = g_apce5_d[l_ac].apde017    LET l_account[13].f2 = "apde017"     #人員      
               LET l_account[15].f1 = g_apce5_d[l_ac].apde022    LET l_account[15].f2 = "apde022"     #專案管理      
               LET l_account[16].f1 = g_apce5_d[l_ac].apde023    LET l_account[16].f2 = "apde023"     #WBS  
               LET l_account[27].f1 = g_apce5_d[l_ac].apde038    LET l_account[27].f2 = "apde038"	   #帳款客商        
               
               LET l_account[31].f1 = g_apce5_d[l_ac].apde042    LET l_account[31].f2 = "apde042"	   #經營方式      
               LET l_account[32].f1 = g_apce5_d[l_ac].apde043    LET l_account[32].f2 = "apde043"     #渠道
               LET l_account[33].f1 = g_apce5_d[l_ac].apde044    LET l_account[33].f2 = "apde044"     #品牌
                                                                                             
               LET l_account[17].f1 = g_apce5_d[l_ac].apde051    LET l_account[17].f2 = "apde051"	   #自由核算項一
               LET l_account[18].f1 = g_apce5_d[l_ac].apde052    LET l_account[18].f2 = "apde052"	   #自由核算項二
               LET l_account[19].f1 = g_apce5_d[l_ac].apde053    LET l_account[19].f2 = "apde053"	   #自由核算項三
               LET l_account[20].f1 = g_apce5_d[l_ac].apde054    LET l_account[20].f2 = "apde054"	   #自由核算項四
               LET l_account[21].f1 = g_apce5_d[l_ac].apde055    LET l_account[21].f2 = "apde055"	   #自由核算項五
               
               LET l_account[22].f1 = g_apce5_d[l_ac].apde056    LET l_account[22].f2 = "apde056"	   #自由核算項六
               LET l_account[23].f1 = g_apce5_d[l_ac].apde057    LET l_account[23].f2 = "apde057"	   #自由核算項七
               LET l_account[24].f1 = g_apce5_d[l_ac].apde058    LET l_account[24].f2 = "apde058"	   #自由核算項八
               LET l_account[25].f1 = g_apce5_d[l_ac].apde059    LET l_account[25].f2 = "apde059"	   #自由核算項九
               LET l_account[26].f1 = g_apce5_d[l_ac].apde060    LET l_account[26].f2 = "apde060"	   #自由核算項十
               
               CALL cl_err_collect_init()
               CALL s_fin_accting_chk(g_apda_m.apdald,g_apce2_d[l_ac].apde016,l_account) RETURNING g_sub_success
               CALL cl_err_collect_show()   
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT             
               END IF
            END IF
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apce5_d[l_ac].* = g_apce5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt823_unlock_b("apde_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
            #回寫核銷單借貸金額
            CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo           
            CALL aapt823_sum_page_show()  #150212apo
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce5_d[li_reproduce_target].apdeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce5_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apce6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_6)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body6.before_input2"
            
            #end add-point
            
            CALL aapt823_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce6_d.getLength()
            #add-point:資料輸入前 name="input.body6.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apce6_d[l_ac].* TO NULL 
            INITIALIZE g_apce6_d_t.* TO NULL 
            INITIALIZE g_apce6_d_o.* TO NULL 
            #公用欄位給值(單身6)
            
            #自定義預設值(單身6)
            
            #add-point:modify段before備份 name="input.body6.insert.before_bak"
            
            #end add-point
            LET g_apce6_d_t.* = g_apce6_d[l_ac].*     #新輸入資料
            LET g_apce6_d_o.* = g_apce6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt823_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body6.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt823_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce6_d[li_reproduce_target].apdeseq = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body6.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body6.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[6] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 6
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt823_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce6_d[l_ac].apdeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce6_d_t.* = g_apce6_d[l_ac].*  #BACKUP
               LET g_apce6_d_o.* = g_apce6_d[l_ac].*  #BACKUP
               CALL aapt823_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body6.after_set_entry_b"
               
               #end add-point  
               CALL aapt823_set_no_entry_b(l_cmd)
               IF NOT aapt823_lock_b("apde_t","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt823_bcl2 INTO g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002, 
                      g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021, 
                      g_apce2_d[l_ac].apde024,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101, 
                      g_apce2_d[l_ac].apde119,g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014, 
                      g_apce2_d[l_ac].apde015,g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009, 
                      g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011, 
                      g_apce2_d[l_ac].apde012,g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite, 
                      g_apce2_d[l_ac].apde001,g_apce5_d[l_ac].apdeseq,g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017, 
                      g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019,g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022, 
                      g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035,g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042, 
                      g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044,g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052, 
                      g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054,g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056, 
                      g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058,g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060, 
                      g_apce6_d[l_ac].apdeseq,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129, 
                      g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apce6_d_mask_o[l_ac].* =  g_apce6_d[l_ac].*
                  CALL aapt823_apde_t_mask()
                  LET g_apce6_d_mask_n[l_ac].* =  g_apce6_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt823_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body6.before_row"
            #160122-00001#5 --add--str--
            #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
            CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
            DISPLAY BY NAME g_apce2_d[l_ac].lc_apde008
            #160122-00001#5 --add--end
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body6.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body6.b_delete_ask"
               
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
               
               #add-point:單身6刪除前 name="input.body6.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apce6_d_t.apdeseq
            
               #刪除同層單身
               IF NOT aapt823_delete_b('apde_t',gs_keys,"'6'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt823_key_delete_b(gs_keys,'apde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt823_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身6刪除中 name="input.body6.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt823_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身6刪除後 name="input.body6.a_delete"
               
               #end add-point
               LET l_count = g_apce_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body6.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apce6_d.getLength() + 1) THEN
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
               
            #add-point:單身6新增前 name="input.body6.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno
               AND apdeseq = g_apce6_d[l_ac].apdeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身6新增前 name="input.body6.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce6_d[g_detail_idx].apdeseq
               CALL aapt823_insert_b('apde_t',gs_keys,"'6'")
                           
               #add-point:單身新增後6 name="input.body6.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apce_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt823_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body6.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce6_d[l_ac].* = g_apce6_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
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
               LET g_apce6_d[l_ac].* = g_apce6_d_t.*
            ELSE
               #add-point:單身page6修改前 name="input.body6.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身6)
               
               
               #將遮罩欄位還原
               CALL aapt823_apde_t_mask_restore('restore_mask_o')
                              
               UPDATE apde_t SET (apdeld,apdedocno,apdeseq,apdeorga,apde002,apde006,apde003,apde008, 
                   apde021,apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016, 
                   apde010,apde009,apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite, 
                   apde001,apde038,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042, 
                   apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059, 
                   apde060,apde120,apde121,apde129,apde130,apde131,apde139) = (g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apce2_d[l_ac].apdeseq,g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006, 
                   g_apce2_d[l_ac].apde003,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde024, 
                   g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119, 
                   g_apce2_d[l_ac].apde032,g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde015, 
                   g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009,g_apce2_d[l_ac].apde039, 
                   g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012, 
                   g_apce2_d[l_ac].apde046,g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite,g_apce2_d[l_ac].apde001, 
                   g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019, 
                   g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035, 
                   g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044, 
                   g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052,g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054, 
                   g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056,g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058, 
                   g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121, 
                   g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139)  
                   #自訂欄位頁簽
                WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
                  AND apdedocno = g_apda_m.apdadocno
                  AND apdeseq = g_apce6_d_t.apdeseq #項次 
                  
               #add-point:單身page6修改中 name="input.body6.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce6_d[l_ac].* = g_apce6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce6_d[l_ac].* = g_apce6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apce6_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apce6_d_t.apdeseq
               CALL aapt823_update_b('apde_t',gs_keys,gs_keys_bak,"'6'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt823_apde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce6_d[g_detail_idx].apdeseq = g_apce6_d_t.apdeseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce6_d_t.apdeseq
                  CALL aapt823_key_update_b(gs_keys,'apde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce6_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce6_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page6修改後 name="input.body6.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde121
            #add-point:BEFORE FIELD apde121 name="input.b.page6.apde121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde121
            
            #add-point:AFTER FIELD apde121 name="input.a.page6.apde121"
            IF NOT cl_null(g_apce6_d[l_ac].apde121) THEN 
               #IF cl_null(g_apce6_d_t.apde121) OR (g_apce6_d_t.apde121 <> g_apce6_d[l_ac].apde121)THEN  #160822-00008#4  mark
               IF cl_null(g_apce6_d_o.apde121) OR (g_apce6_d[l_ac].apde121 <> g_apce6_d_o.apde121)THEN   #160822-00008#4
                  #匯率取位
                  IF cl_null(g_apce6_d[l_ac].apde121) THEN LET g_apce6_d[l_ac].apde121 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde121  #160829-00004#1 mark
                  #160829-00004#1--(s)
                  IF g_glaa.glaa015 = 'Y' THEN          
                     #來源幣別
                     IF g_glaa.glaa017 = '1' THEN
                        CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce2_d[l_ac].apde100,g_apce6_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde121
                     ELSE   #表示帳簿幣別 
                        CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce6_d[l_ac].apde121,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde121   #帳套使用幣別
                     END IF
                  END IF
                  #160829-00004#1--(e)
                  #本幣二重計
                  LET g_apce6_d[l_ac].apde129 = g_apce2_d[l_ac].apde109 * g_apce6_d[l_ac].apde121
                  IF cl_null(g_apce6_d[l_ac].apde129) THEN LET g_apce6_d[l_ac].apde129 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde129                    
               END IF            
            END IF 
            LET g_apce6_d_o.* = g_apce6_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde121
            #add-point:ON CHANGE apde121 name="input.g.page6.apde121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde129
            #add-point:BEFORE FIELD apde129 name="input.b.page6.apde129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde129
            
            #add-point:AFTER FIELD apde129 name="input.a.page6.apde129"
            IF NOT cl_null(g_apce6_d[l_ac].apde129) THEN 
               #本幣二
               IF cl_null(g_apce6_d[l_ac].apde129) THEN LET g_apce6_d[l_ac].apde129 = 0 END IF
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde129                   
               DISPLAY BY NAME g_apce6_d[l_ac].apde129                  
               IF NOT cl_null(g_apce2_d[l_ac].apde003) THEN
                  CASE g_apce2_d[l_ac].apde002
                     WHEN '10'               
                        CALL s_aapt420_nmck_used_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeseq,l_ooef017,
                                                     g_apce2_d[l_ac].apde003,g_apce6_d[l_ac].apde129,'2') 
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce6_d[l_ac].apde129 = g_apce6_d_t.apde129  #160822-00008#4  mark
                           LET g_apce6_d[l_ac].apde129 = g_apce6_d_o.apde129   #160822-00008#4
                           DISPLAY BY NAME g_apce6_d[l_ac].apde129
                           NEXT FIELD CURRENT
                        END IF         
                  END CASE                       
               END IF              
            END IF 
            LET g_apce6_d_o.* = g_apce6_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde129
            #add-point:ON CHANGE apde129 name="input.g.page6.apde129"
           
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde131
            #add-point:BEFORE FIELD apde131 name="input.b.page6.apde131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde131
            
            #add-point:AFTER FIELD apde131 name="input.a.page6.apde131"
            IF NOT cl_null(g_apce6_d[l_ac].apde131) THEN 
               #IF cl_null(g_apce6_d_t.apde131) OR (g_apce6_d_t.apde131 <> g_apce6_d[l_ac].apde131)THEN  #160822-00008#4  mark
               IF cl_null(g_apce6_d_o.apde131) OR (g_apce6_d[l_ac].apde131 <> g_apce6_d_o.apde131)THEN   #160822-00008#4
                  #匯率取位
                  IF cl_null(g_apce6_d[l_ac].apde131) THEN LET g_apce6_d[l_ac].apde131 = 0 END IF
                  #CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde131 #160829-00004#1 mark                 
                  #160829-00004#1--(s)
                  IF g_glaa.glaa019 = 'Y' THEN          
                     #來源幣別
                     IF g_glaa.glaa021 = '1' THEN
                        CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce2_d[l_ac].apde100,g_apce6_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde131
                     ELSE   #表示帳簿幣別 
                        CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce6_d[l_ac].apde131,3) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde131   #帳套使用幣別
                     END IF
                  END IF
                  #160829-00004#1--(e) 
                  #本幣三重計
                  LET g_apce6_d[l_ac].apde139 = g_apce2_d[l_ac].apde109 * g_apce6_d[l_ac].apde131
                  IF cl_null(g_apce6_d[l_ac].apde139) THEN LET g_apce6_d[l_ac].apde139 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde139                    
               END IF            
            END IF 
            LET g_apce6_d_o.* = g_apce6_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde131
            #add-point:ON CHANGE apde131 name="input.g.page6.apde131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde139
            #add-point:BEFORE FIELD apde139 name="input.b.page6.apde139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde139
            
            #add-point:AFTER FIELD apde139 name="input.a.page6.apde139"
            IF NOT cl_null(g_apce6_d[l_ac].apde139) THEN 
               #IF cl_null(g_apce6_d_t.apde139) OR (g_apce6_d_t.apde139 <> g_apce6_d[l_ac].apde139)THEN  #160822-00008#4  mark
               IF cl_null(g_apce6_d_o.apde139) OR (g_apce6_d[l_ac].apde139 <> g_apce6_d_o.apde139)THEN   #160822-00008#4
                  #本幣三
                  IF cl_null(g_apce6_d[l_ac].apde139) THEN LET g_apce6_d[l_ac].apde139 = 0 END IF
                  CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde139                   
                  DISPLAY BY NAME g_apce6_d[l_ac].apde139                 
                  IF NOT cl_null(g_apce2_d[l_ac].apde003) THEN
                     CASE g_apce2_d[l_ac].apde002
                        WHEN '10'               
                           CALL s_aapt420_nmck_used_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeseq,l_ooef017,
                                                        g_apce2_d[l_ac].apde003,g_apce6_d[l_ac].apde139,'3') 
                              RETURNING g_sub_success,g_errno
                           IF NOT g_sub_success THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = g_errno
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_apce6_d[l_ac].apde139 = g_apce6_d_t.apde139  #160822-00008#4  mark
                              LET g_apce6_d[l_ac].apde139 = g_apce6_d_o.apde139   #160822-00008#4
                              DISPLAY BY NAME g_apce6_d[l_ac].apde139
                              NEXT FIELD CURRENT
                           END IF         
                     END CASE                        
                  END IF              
               END IF              
            END IF 
            LET g_apce6_d_o.* = g_apce6_d[l_ac].*  #160822-00008#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde139
            #add-point:ON CHANGE apde139 name="input.g.page6.apde139"
     
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page6.apde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde121
            #add-point:ON ACTION controlp INFIELD apde121 name="input.c.page6.apde121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.apde129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde129
            #add-point:ON ACTION controlp INFIELD apde129 name="input.c.page6.apde129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.apde131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde131
            #add-point:ON ACTION controlp INFIELD apde131 name="input.c.page6.apde131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.apde139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde139
            #add-point:ON ACTION controlp INFIELD apde139 name="input.c.page6.apde139"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page6 after_row name="input.body6.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apce6_d[l_ac].* = g_apce6_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt823_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt823_unlock_b("apde_t","'6'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page6 after_row2 name="input.body6.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body6.after_input"
           #150128-00005#1---Mark----
           ##141202-00061-15--(S)
           #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
           #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
           #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
           #   CALL s_transaction_begin()
           #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
           #        RETURNING g_sub_success
           #   IF g_sub_success THEN 
           #      CALL s_transaction_end('Y','0')
           #   ELSE
           #      CALL s_transaction_end('N','0')
           #   END IF
           #END IF
           ##141202-00061-15--(E)
           #150128-00005#1---Mark----
           #回寫核銷單借貸金額
           CALL s_aapt420_upd_dc_money(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success  #150325apo           
           CALL aapt823_sum_page_show()  #150212apo
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
               LET g_apce5_d[li_reproduce_target].* = g_apce5_d[li_reproduce].*
               LET g_apce6_d[li_reproduce_target].* = g_apce6_d[li_reproduce].*
 
               LET g_apce6_d[li_reproduce_target].apdeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce6_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce6_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt823.input.other" >}
      
      #add-point:自定義input name="input.more_input"
 
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         LET l_ask_flag = 'Y'
         IF p_cmd = 'a' THEN
            NEXT FIELD apdald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apceseq
               WHEN "s_detail2"
                  NEXT FIELD apdeseq
               WHEN "s_detail3"
                  NEXT FIELD apce017
               WHEN "s_detail4"
                  NEXT FIELD apce129   #150512-00036#1 mod apce121-->apce129
               WHEN "s_detail5"
                  NEXT FIELD apde038
               WHEN "s_detail6"
                  NEXT FIELD apde121
            END CASE
         END IF         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','3','4',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2','5','6',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apdald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apceseq
               WHEN "s_detail2"
                  NEXT FIELD apdeseq
               WHEN "s_detail3"
                  NEXT FIELD apceseq_3
               WHEN "s_detail4"
                  NEXT FIELD apceseq_4
               WHEN "s_detail5"
                  NEXT FIELD apdeseq_5
               WHEN "s_detail6"
                  NEXT FIELD apdeseq_6
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         CALL aapt823_open_aapt823_09()RETURNING g_sub_success,l_continue
         CALL aapt823_show()   
         CALL aapt823_sum_page_show()
         IF l_continue = 'Y' THEN
            NEXT FIELD CURRENT
         END IF  
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
#150512-00036#1--(s)
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
   
END WHILE   
#150512-00036#1--(e)
   #150210--add
   IF NOT INT_FLAG THEN
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
         CALL s_transaction_begin()
         CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
              RETURNING g_sub_success
         IF g_sub_success THEN 
            CALL s_transaction_end('Y','0')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
      END IF
   END IF
   #150210--add
   #2015/6/4--by--02599--add--str--
   #当账款类型是应收单冲销时，需检查该付款对象的金额是否冲销完
   #未收款款金额
   LET l_amt1=0
   SELECT SUM(xrcc118-xrcc119+xrcc113) INTO l_amt1 
     FROM xrcc_t,xrca_t
    WHERE xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno
      AND xrcaent=g_enterprise 
      AND xrcasite=g_apda_m.apdasite
      AND xrcald=g_apda_m.apdald
      AND xrca001 LIKE '1%'
      AND xrca005 IN (SELECT apce038 FROM apce_t
                       WHERE apceent = g_enterprise 
                         AND apceld  = g_apda_m.apdald
                         AND apcedocno = g_apda_m.apdadocno)
      AND xrcastus='Y'
   IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
   
   #该单据要用应收单冲抵的金额
   LET l_amt2=0
   SELECT SUM(apce119) INTO l_amt2 FROM apce_t
    WHERE apceent=g_enterprise AND apceld=g_apda_m.apdald
      AND apcedocno=g_apda_m.apdadocno AND apce002='30'
   IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
   
   #当该客户还有尚未收款的金额，提示是否付款
   IF l_amt1-l_amt2 > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'aap-00373'
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF
   #2015/6/4--by--02599--add--end
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt823_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt823_b_fill() #單身填充
      CALL aapt823_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt823_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apda_m.apdaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_apda_m.apdaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apda_m.apdacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_apda_m.apdacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apda_m.apdamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdamodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apda_m.apdacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apda_m.apdacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apda_m.apdacnfid_desc
   
   LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
   LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
   LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)
#   LET g_apda_m.apda005_desc = s_desc_get_trading_partner_abbr_desc(g_apda_m.apda005)
   LET g_apda_m.apda015_desc = s_desc_get_acc_desc('3115',g_apda_m.apda015)
   LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
   CALL s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno) RETURNING g_apda_m.apdadocno_desc
   CALL aapt823_set_ld_info(g_apda_m.apdald)

   CALL aapt823_sum_page_show()
   #end add-point
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt823_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003,g_apda_m.apda003_desc,g_apda_m.apdald, 
       g_apda_m.apdald_desc,g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001,g_apda_m.apdadocdt, 
       g_apda_m.apda005,g_apda_m.apda005_desc,g_apda_m.apda023,g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp, 
       g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda007,g_apda_m.apda009, 
       g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt, 
       g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt,g_apda_m.dummy3,g_apda_m.glaa001, 
       g_apda_m.sum_apde1092,g_apda_m.sum_apde1192,g_apda_m.sum_apde1091,g_apda_m.sum_apde1191,g_apda_m.sum_apde1093, 
       g_apda_m.sum_apde1193,g_apda_m.sum_apde1094,g_apda_m.sum_apde1194,g_apda_m.glaa016,g_apda_m.glaa020, 
       g_apda_m.sum_apde1291,g_apda_m.sum_apde1391,g_apda_m.sum_apde1292,g_apda_m.sum_apde1392,g_apda_m.sum_apde1293, 
       g_apda_m.sum_apde1393,g_apda_m.sum_apde1294,g_apda_m.sum_apde1394
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
   FOR l_ac = 1 TO g_apce_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      LET g_apce_d[l_ac].apceorga_desc = s_desc_get_department_desc(g_apce_d[l_ac].apceorga)
      LET g_apce_d[l_ac].apce038_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce038)
      LET g_apce_d[l_ac].apce061_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce061)
      LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)
      #取得年度期別
      CALL aapt823_get_yymm(g_apce_d[l_ac].apce003) RETURNING g_apce_d[l_ac].l_yymm      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apce2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

      LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
      LET g_apce2_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde013)   
      LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
      LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
      LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apce3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apce4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apce5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apce6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt823_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt823_detail_show()
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
 
{<section id="aapt823.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt823_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apda_t.apdald 
   DEFINE l_oldno     LIKE apda_t.apdald 
   DEFINE l_newno02     LIKE apda_t.apdadocno 
   DEFINE l_oldno02     LIKE apda_t.apdadocno 
 
   DEFINE l_master    RECORD LIKE apda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apce_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apde_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
    
   LET g_apda_m.apdald = ""
   LET g_apda_m.apdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apda_m.apdaownid = g_user
      LET g_apda_m.apdaowndp = g_dept
      LET g_apda_m.apdacrtid = g_user
      LET g_apda_m.apdacrtdp = g_dept 
      LET g_apda_m.apdacrtdt = cl_get_current()
      LET g_apda_m.apdamodid = g_user
      LET g_apda_m.apdamoddt = cl_get_current()
      LET g_apda_m.apdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_apda_m.apda014 = ''     #160726-00020#17
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
      LET g_apda_m.apdald_desc = ''
   DISPLAY BY NAME g_apda_m.apdald_desc
   LET g_apda_m.apdadocno_desc = ''
   DISPLAY BY NAME g_apda_m.apdadocno_desc
 
   
   CALL aapt823_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apda_m.* TO NULL
      INITIALIZE g_apce_d TO NULL
      INITIALIZE g_apce2_d TO NULL
      INITIALIZE g_apce3_d TO NULL
      INITIALIZE g_apce4_d TO NULL
      INITIALIZE g_apce5_d TO NULL
      INITIALIZE g_apce6_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt823_show()
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
   CALL aapt823_set_act_visible()   
   CALL aapt823_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt823_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt823_idx_chk()
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt823_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt823_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apce_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apde_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt823_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apce_t
    WHERE apceent = g_enterprise AND apceld = g_apdald_t
     AND apcedocno = g_apdadocno_t
 
    INTO TEMP aapt823_detail
 
   #將key修正為調整後   
   UPDATE aapt823_detail 
      #更新key欄位
      SET apceld = g_apda_m.apdald
          , apcedocno = g_apda_m.apdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apce_t SELECT * FROM aapt823_detail
   
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
   DROP TABLE aapt823_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apde_t 
    WHERE apdeent = g_enterprise AND apdeld = g_apdald_t
      AND apdedocno = g_apdadocno_t   
 
    INTO TEMP aapt823_detail
 
   #將key修正為調整後   
   UPDATE aapt823_detail SET apdeld = g_apda_m.apdald
                                       , apdedocno = g_apda_m.apdadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apde_t SELECT * FROM aapt823_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt823_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt823_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_ap_slip       LIKE apda_t.apdadocno

   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt823_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aapt823_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt823_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   CALL aapt823_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150311--add--str--
   IF g_apda_m.apdastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apda_m.apdastus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #150311--add--end--
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt823_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apdald_t = g_apda_m.apdald
      LET g_apdadocno_t = g_apda_m.apdadocno
 
 
      DELETE FROM apda_t
       WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
         AND apdadocno = g_apda_m.apdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apda_m.apdald,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
       IF NOT s_aooi200_fin_del_docno(g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip   
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN      
         CALL s_pre_voucher_del('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apce_t
       WHERE apceent = g_enterprise AND apceld = g_apda_m.apdald
         AND apcedocno = g_apda_m.apdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
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
      DELETE FROM apde_t
       WHERE apdeent = g_enterprise AND
             apdeld = g_apda_m.apdald AND apdedocno = g_apda_m.apdadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
 
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt823_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apce_d.clear() 
      CALL g_apce2_d.clear()       
      CALL g_apce3_d.clear()       
      CALL g_apce4_d.clear()       
      CALL g_apce5_d.clear()       
      CALL g_apce6_d.clear()       
 
     
      CALL aapt823_ui_browser_refresh()  
      #CALL aapt823_ui_headershow()  
      #CALL aapt823_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt823_browser_fill("")
         CALL aapt823_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt823_cl
 
   #功能已完成,通報訊息中心
   CALL aapt823_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt823.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt823_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apce_d.clear()
   CALL g_apce2_d.clear()
   CALL g_apce3_d.clear()
   CALL g_apce4_d.clear()
   CALL g_apce5_d.clear()
   CALL g_apce6_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF aapt823_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apceseq,apce002,apceorga,apce003,apce004,apce005,apce061,apce038, 
             apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010,apce031,apce049, 
             apcecomp,apcesite,apce001,apceseq,apce017,apce018,apce019,apce020,apce022,apce023,apce035, 
             apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057, 
             apce058,apce059,apce060,apceseq,apce120,apce121,apce129,apce130,apce131,apce139 ,t1.pmaal003 FROM apce_t", 
                
                     " INNER JOIN apda_t ON apdaent = " ||g_enterprise|| " AND apdald = apceld ",
                     " AND apdadocno = apcedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=apce038 AND t1.pmaal002='"||g_dlang||"' ",
 
                     " WHERE apceent=? AND apceld=? AND apcedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
            LET g_wc2_table1 = g_wc2_table1 CLIPPED,
                            " AND (apcedocno,apceld) IN (SELECT apdedocno,apdeld FROM apde_t ",
                                                         " WHERE apceent = apdeent ",
                                                         "   AND apceld = apdeld ",
                                                         "   AND apcedocno = apdedocno ",
                                                         "   AND ",g_wc2_table2 CLIPPED,")"
         END IF
         IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
            LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                              "              WHERE pmaaent = ",g_enterprise,
                              "                AND ",g_sql_ctrl,
                              "                AND pmaaent = apdaent ",
                              "                AND pmaa001 = apce038 )"
         END IF
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apce_t.apceseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         LET g_wc2_table1 = " 1=1"   #150213apo
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt823_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt823_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno INTO g_apce_d[l_ac].apceseq, 
          g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004, 
          g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce061,g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce048, 
          g_apce_d[l_ac].apce024,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce101, 
          g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce015,g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce010, 
          g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce049,g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcesite, 
          g_apce_d[l_ac].apce001,g_apce3_d[l_ac].apceseq,g_apce3_d[l_ac].apce017,g_apce3_d[l_ac].apce018, 
          g_apce3_d[l_ac].apce019,g_apce3_d[l_ac].apce020,g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023, 
          g_apce3_d[l_ac].apce035,g_apce3_d[l_ac].apce036,g_apce3_d[l_ac].apce044,g_apce3_d[l_ac].apce045, 
          g_apce3_d[l_ac].apce046,g_apce3_d[l_ac].apce051,g_apce3_d[l_ac].apce052,g_apce3_d[l_ac].apce053, 
          g_apce3_d[l_ac].apce054,g_apce3_d[l_ac].apce055,g_apce3_d[l_ac].apce056,g_apce3_d[l_ac].apce057, 
          g_apce3_d[l_ac].apce058,g_apce3_d[l_ac].apce059,g_apce3_d[l_ac].apce060,g_apce4_d[l_ac].apceseq, 
          g_apce4_d[l_ac].apce120,g_apce4_d[l_ac].apce121,g_apce4_d[l_ac].apce129,g_apce4_d[l_ac].apce130, 
          g_apce4_d[l_ac].apce131,g_apce4_d[l_ac].apce139,g_apce_d[l_ac].apce038_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_apce_d[l_ac].apceorga_desc = s_desc_get_department_desc(g_apce_d[l_ac].apceorga)
         LET g_apce_d[l_ac].apce038_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce038)
         LET g_apce_d[l_ac].apce061_desc = s_desc_get_trading_partner_abbr_desc(g_apce_d[l_ac].apce061)
         LET g_apce_d[l_ac].apce016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016)         
         #帳款其他訊息
         LET g_apce3_d[l_ac].apce0022 = g_apce_d[l_ac].apce002   
         LET g_apce3_d[l_ac].apce0152 = g_apce_d[l_ac].apce015
         LET g_apce3_d[l_ac].apce0162 = g_apce_d[l_ac].apce016
         #固定核算項
         LET g_apce3_d[l_ac].apce0162_desc = s_desc_show1(g_apce3_d[l_ac].apce0162,s_desc_get_account_desc(g_apda_m.apdald,g_apce3_d[l_ac].apce0162))         
         LET g_apce3_d[l_ac].apce017_desc = s_desc_show1(g_apce3_d[l_ac].apce017,s_desc_get_person_desc(g_apce3_d[l_ac].apce017))                  
         LET g_apce3_d[l_ac].apce018_desc = s_desc_show1(g_apce3_d[l_ac].apce018,s_desc_get_department_desc(g_apce3_d[l_ac].apce018))         
         LET g_apce3_d[l_ac].apce019_desc = s_desc_show1(g_apce3_d[l_ac].apce019,s_desc_get_department_desc(g_apce3_d[l_ac].apce019))         
         LET g_apce3_d[l_ac].apce020_desc = s_desc_show1(g_apce3_d[l_ac].apce020,s_desc_get_rtaxl003_desc(g_apce3_d[l_ac].apce020))      
         LET g_apce3_d[l_ac].apce022_desc = s_desc_show1(g_apce3_d[l_ac].apce022,s_desc_get_project_desc(g_apce3_d[l_ac].apce022))      
         LET g_apce3_d[l_ac].apce023_desc = s_desc_show1(g_apce3_d[l_ac].apce023,s_desc_get_pjbbl004_desc(g_apce3_d[l_ac].apce022,g_apce3_d[l_ac].apce023))
         LET g_apce3_d[l_ac].apce044_desc = g_apce3_d[l_ac].apce044
         LET g_apce3_d[l_ac].apce045_desc = s_desc_show1(g_apce3_d[l_ac].apce045,s_desc_get_oojdl003_desc(g_apce3_d[l_ac].apce045))         
         LET g_apce3_d[l_ac].apce046_desc = s_desc_show1(g_apce3_d[l_ac].apce046,s_desc_get_acc_desc('2002',g_apce3_d[l_ac].apce046))      
         LET g_apce3_d[l_ac].apce035_desc = s_desc_show1(g_apce3_d[l_ac].apce035,s_desc_get_acc_desc('287',g_apce3_d[l_ac].apce035))      
         LET g_apce3_d[l_ac].apce036_desc = s_desc_show1(g_apce3_d[l_ac].apce036,s_desc_get_acc_desc('281',g_apce3_d[l_ac].apce036))      
         #取得自由核算項類型
         CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*          
         IF NOT cl_null(g_apce3_d[l_ac].apce051) THEN
            LET g_apce3_d[l_ac].apce051_desc = s_desc_show1(g_apce3_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce3_d[l_ac].apce051))
         END IF
         IF NOT cl_null(g_apce3_d[l_ac].apce052) THEN
            LET g_apce3_d[l_ac].apce052_desc = s_desc_show1(g_apce3_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce3_d[l_ac].apce052))
         END IF   
         IF NOT cl_null(g_apce3_d[l_ac].apce053) THEN         
            LET g_apce3_d[l_ac].apce053_desc = s_desc_show1(g_apce3_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce3_d[l_ac].apce053))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce054) THEN
            LET g_apce3_d[l_ac].apce054_desc = s_desc_show1(g_apce3_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce3_d[l_ac].apce054))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce055) THEN
            LET g_apce3_d[l_ac].apce055_desc = s_desc_show1(g_apce3_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce3_d[l_ac].apce055))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce056) THEN
            LET g_apce3_d[l_ac].apce056_desc = s_desc_show1(g_apce3_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce3_d[l_ac].apce056))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce057) THEN
            LET g_apce3_d[l_ac].apce057_desc = s_desc_show1(g_apce3_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce3_d[l_ac].apce057))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce058) THEN
            LET g_apce3_d[l_ac].apce058_desc = s_desc_show1(g_apce3_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce3_d[l_ac].apce058))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce059) THEN
            LET g_apce3_d[l_ac].apce059_desc = s_desc_show1(g_apce3_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce3_d[l_ac].apce059))
         END IF            
         IF NOT cl_null(g_apce3_d[l_ac].apce060) THEN
            LET g_apce3_d[l_ac].apce060_desc = s_desc_show1(g_apce3_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce3_d[l_ac].apce060))         
         END IF            
         #帳款其他本位幣
         LET g_apce4_d[l_ac].apce0023 = g_apce_d[l_ac].apce002
         LET g_apce4_d[l_ac].apce0033 = g_apce_d[l_ac].apce003
         LET g_apce4_d[l_ac].apce0043 = g_apce_d[l_ac].apce004
         LET g_apce4_d[l_ac].apce0053 = g_apce_d[l_ac].apce005
         LET g_apce4_d[l_ac].apce1003 = g_apce_d[l_ac].apce100
         LET g_apce4_d[l_ac].apce1093 = g_apce_d[l_ac].apce109
         LET g_apce4_d[l_ac].apce1013 = g_apce_d[l_ac].apce101
         LET g_apce4_d[l_ac].apce1193 = g_apce_d[l_ac].apce119

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
   IF aapt823_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apdeseq,apdeorga,apde002,apde006,apde003,apde008,apde021,apde024, 
             apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016,apde010,apde009, 
             apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite,apde001,apdeseq,apde038, 
             apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044, 
             apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apdeseq, 
             apde120,apde121,apde129,apde130,apde131,apde139  FROM apde_t",   
                     " INNER JOIN  apda_t ON apdaent = " ||g_enterprise|| " AND apdald = apdeld ",
                     " AND apdadocno = apdedocno ",
 
                     "",
                     
                     
                     " WHERE apdeent=? AND apdeld=? AND apdedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"

        
         IF NOT cl_null(g_wc2_table1) AND g_wc2_table1 <> " 1=1" THEN
            LET g_wc2_table2 = g_wc2_table2 CLIPPED,
                            " AND (apdedocno,apdeld) IN (SELECT apdedocno,apdeld FROM apce_t ",
                                                         " WHERE apceent = apdeent ",
                                                         "   AND apcedocno = apdedocno ",
                                                         "   AND apceld = apdeld ",
                                                         "   AND ",g_wc2_table1 CLIPPED,")"
         END IF
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apde_t.apdeseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         LET g_wc2_table2 = " 1=1"   #150213apo
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt823_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt823_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno INTO g_apce2_d[l_ac].apdeseq, 
          g_apce2_d[l_ac].apdeorga,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde003, 
          g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde024,g_apce2_d[l_ac].apde100, 
          g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119,g_apce2_d[l_ac].apde032, 
          g_apce2_d[l_ac].apde013,g_apce2_d[l_ac].apde014,g_apce2_d[l_ac].apde015,g_apce2_d[l_ac].apde016, 
          g_apce2_d[l_ac].apde010,g_apce2_d[l_ac].apde009,g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040, 
          g_apce2_d[l_ac].apde041,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012,g_apce2_d[l_ac].apde046, 
          g_apce2_d[l_ac].apdecomp,g_apce2_d[l_ac].apdesite,g_apce2_d[l_ac].apde001,g_apce5_d[l_ac].apdeseq, 
          g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde017,g_apce5_d[l_ac].apde018,g_apce5_d[l_ac].apde019, 
          g_apce5_d[l_ac].apde020,g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023,g_apce5_d[l_ac].apde035, 
          g_apce5_d[l_ac].apde036,g_apce5_d[l_ac].apde042,g_apce5_d[l_ac].apde043,g_apce5_d[l_ac].apde044, 
          g_apce5_d[l_ac].apde051,g_apce5_d[l_ac].apde052,g_apce5_d[l_ac].apde053,g_apce5_d[l_ac].apde054, 
          g_apce5_d[l_ac].apde055,g_apce5_d[l_ac].apde056,g_apce5_d[l_ac].apde057,g_apce5_d[l_ac].apde058, 
          g_apce5_d[l_ac].apde059,g_apce5_d[l_ac].apde060,g_apce6_d[l_ac].apdeseq,g_apce6_d[l_ac].apde120, 
          g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131, 
          g_apce6_d[l_ac].apde139   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         #160122-00001#5 add -str
         #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
         CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
         #160122-00001#5 add -end
         
         LET g_apce2_d[l_ac].apdeorga_desc = s_desc_get_department_desc(g_apce2_d[l_ac].apdeorga)
         LET g_apce2_d[l_ac].apde013_desc = s_desc_get_trading_partner_abbr_desc(g_apce2_d[l_ac].apde013)   
         LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
         LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012)
         LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)         
         #帳款其他訊息
         LET g_apce5_d[l_ac].apde0022 = g_apce2_d[l_ac].apde002 
         LET g_apce5_d[l_ac].apde0152 = g_apce2_d[l_ac].apde015
         LET g_apce5_d[l_ac].apde0162 = g_apce2_d[l_ac].apde016
         
         #固定核算項
         LET g_apce5_d[l_ac].apde038_desc = s_desc_show1(g_apce5_d[l_ac].apde038,s_desc_get_trading_partner_abbr_desc(g_apce5_d[l_ac].apde038))
         LET g_apce5_d[l_ac].apde0162_desc = s_desc_show1(g_apce5_d[l_ac].apde0162,s_desc_get_account_desc(g_apda_m.apdald,g_apce5_d[l_ac].apde0162))         
         LET g_apce5_d[l_ac].apde017_desc = s_desc_show1(g_apce5_d[l_ac].apde017,s_desc_get_person_desc(g_apce5_d[l_ac].apde017))                  
         LET g_apce5_d[l_ac].apde018_desc = s_desc_show1(g_apce5_d[l_ac].apde018,s_desc_get_department_desc(g_apce5_d[l_ac].apde018))         
         LET g_apce5_d[l_ac].apde019_desc = s_desc_show1(g_apce5_d[l_ac].apde019,s_desc_get_department_desc(g_apce5_d[l_ac].apde019))         
         LET g_apce5_d[l_ac].apde020_desc = s_desc_show1(g_apce5_d[l_ac].apde020,s_desc_get_rtaxl003_desc(g_apce5_d[l_ac].apde020))      
         LET g_apce5_d[l_ac].apde022_desc = s_desc_show1(g_apce5_d[l_ac].apde022,s_desc_get_project_desc(g_apce5_d[l_ac].apde022))      
         LET g_apce5_d[l_ac].apde023_desc = s_desc_show1(g_apce5_d[l_ac].apde023,s_desc_get_pjbbl004_desc(g_apce5_d[l_ac].apde022,g_apce5_d[l_ac].apde023))
         LET g_apce5_d[l_ac].apde042_desc = g_apce5_d[l_ac].apde042
         LET g_apce5_d[l_ac].apde043_desc = s_desc_show1(g_apce5_d[l_ac].apde043,s_desc_get_oojdl003_desc(g_apce5_d[l_ac].apde043))
         LET g_apce5_d[l_ac].apde044_desc = s_desc_show1(g_apce5_d[l_ac].apde044,s_desc_get_acc_desc('2002',g_apce5_d[l_ac].apde044))      
         LET g_apce5_d[l_ac].apde035_desc = s_desc_show1(g_apce5_d[l_ac].apde035,s_desc_get_acc_desc('287',g_apce5_d[l_ac].apde035))      
         LET g_apce5_d[l_ac].apde036_desc = s_desc_show1(g_apce5_d[l_ac].apde036,s_desc_get_acc_desc('281',g_apce5_d[l_ac].apde036))      
         #取得自由核算項類型
         CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apde016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*          
         IF NOT cl_null(g_apce5_d[l_ac].apde051) THEN
            LET g_apce5_d[l_ac].apde051_desc = s_desc_show1(g_apce5_d[l_ac].apde051,s_fin_get_accting_desc(g_glad.glad0171,g_apce5_d[l_ac].apde051))
         END IF         
         IF NOT cl_null(g_apce5_d[l_ac].apde052) THEN
            LET g_apce5_d[l_ac].apde052_desc = s_desc_show1(g_apce5_d[l_ac].apde052,s_fin_get_accting_desc(g_glad.glad0181,g_apce5_d[l_ac].apde052))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde053) THEN
            LET g_apce5_d[l_ac].apde053_desc = s_desc_show1(g_apce5_d[l_ac].apde053,s_fin_get_accting_desc(g_glad.glad0191,g_apce5_d[l_ac].apde053))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde054) THEN
            LET g_apce5_d[l_ac].apde054_desc = s_desc_show1(g_apce5_d[l_ac].apde054,s_fin_get_accting_desc(g_glad.glad0201,g_apce5_d[l_ac].apde054))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde055) THEN
            LET g_apce5_d[l_ac].apde055_desc = s_desc_show1(g_apce5_d[l_ac].apde055,s_fin_get_accting_desc(g_glad.glad0211,g_apce5_d[l_ac].apde055))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde056) THEN
            LET g_apce5_d[l_ac].apde056_desc = s_desc_show1(g_apce5_d[l_ac].apde056,s_fin_get_accting_desc(g_glad.glad0221,g_apce5_d[l_ac].apde056))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde057) THEN
            LET g_apce5_d[l_ac].apde057_desc = s_desc_show1(g_apce5_d[l_ac].apde057,s_fin_get_accting_desc(g_glad.glad0231,g_apce5_d[l_ac].apde057))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde058) THEN
            LET g_apce5_d[l_ac].apde058_desc = s_desc_show1(g_apce5_d[l_ac].apde058,s_fin_get_accting_desc(g_glad.glad0241,g_apce5_d[l_ac].apde058))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde059) THEN
            LET g_apce5_d[l_ac].apde059_desc = s_desc_show1(g_apce5_d[l_ac].apde059,s_fin_get_accting_desc(g_glad.glad0251,g_apce5_d[l_ac].apde059))
         END IF
         IF NOT cl_null(g_apce5_d[l_ac].apde060) THEN
            LET g_apce5_d[l_ac].apde060_desc = s_desc_show1(g_apce5_d[l_ac].apde060,s_fin_get_accting_desc(g_glad.glad0261,g_apce5_d[l_ac].apde060))         
         END IF
         
         #帳款其他本位幣                       
         LET g_apce6_d[l_ac].apde0023 = g_apce2_d[l_ac].apde002
         LET g_apce6_d[l_ac].apde0063 = g_apce2_d[l_ac].apde006
#         LET g_apce6_d[l_ac].apde0083 = g_apce2_d[l_ac].apde008 #160122-00001#5 mark
         LET g_apce6_d[l_ac].apde0083 = g_apce2_d[l_ac].lc_apde008  #160122-00001#5 add
         LET g_apce6_d[l_ac].apde1003 = g_apce2_d[l_ac].apde100
         LET g_apce6_d[l_ac].apde1093 = g_apce2_d[l_ac].apde109
         LET g_apce6_d[l_ac].apde1013 = g_apce2_d[l_ac].apde101
         LET g_apce6_d[l_ac].apde1193 = g_apce2_d[l_ac].apde119
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
   
   CALL g_apce_d.deleteElement(g_apce_d.getLength())
   CALL g_apce2_d.deleteElement(g_apce2_d.getLength())
   CALL g_apce3_d.deleteElement(g_apce3_d.getLength())
   CALL g_apce4_d.deleteElement(g_apce4_d.getLength())
   CALL g_apce5_d.deleteElement(g_apce5_d.getLength())
   CALL g_apce6_d.deleteElement(g_apce6_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt823_pb
   FREE aapt823_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apce_d.getLength()
      LET g_apce_d_mask_o[l_ac].* =  g_apce_d[l_ac].*
      CALL aapt823_apce_t_mask()
      LET g_apce_d_mask_n[l_ac].* =  g_apce_d[l_ac].*
   END FOR
   
   LET g_apce2_d_mask_o.* =  g_apce2_d.*
   FOR l_ac = 1 TO g_apce2_d.getLength()
      LET g_apce2_d_mask_o[l_ac].* =  g_apce2_d[l_ac].*
      CALL aapt823_apde_t_mask()
      LET g_apce2_d_mask_n[l_ac].* =  g_apce2_d[l_ac].*
   END FOR
   LET g_apce3_d_mask_o.* =  g_apce3_d.*
   FOR l_ac = 1 TO g_apce3_d.getLength()
      LET g_apce3_d_mask_o[l_ac].* =  g_apce3_d[l_ac].*
      CALL aapt823_apce_t_mask()
      LET g_apce3_d_mask_n[l_ac].* =  g_apce3_d[l_ac].*
   END FOR
   LET g_apce4_d_mask_o.* =  g_apce4_d.*
   FOR l_ac = 1 TO g_apce4_d.getLength()
      LET g_apce4_d_mask_o[l_ac].* =  g_apce4_d[l_ac].*
      CALL aapt823_apce_t_mask()
      LET g_apce4_d_mask_n[l_ac].* =  g_apce4_d[l_ac].*
   END FOR
   LET g_apce5_d_mask_o.* =  g_apce5_d.*
   FOR l_ac = 1 TO g_apce5_d.getLength()
      LET g_apce5_d_mask_o[l_ac].* =  g_apce5_d[l_ac].*
      CALL aapt823_apde_t_mask()
      LET g_apce5_d_mask_n[l_ac].* =  g_apce5_d[l_ac].*
   END FOR
   LET g_apce6_d_mask_o.* =  g_apce6_d.*
   FOR l_ac = 1 TO g_apce6_d.getLength()
      LET g_apce6_d_mask_o[l_ac].* =  g_apce6_d[l_ac].*
      CALL aapt823_apde_t_mask()
      LET g_apce6_d_mask_n[l_ac].* =  g_apce6_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt823_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM apce_t
       WHERE apceent = g_enterprise AND
         apceld = ps_keys_bak[1] AND apcedocno = ps_keys_bak[2] AND apceseq = ps_keys_bak[3]
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
         CALL g_apce_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apce3_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_apce4_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2','5','6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apde_t
       WHERE apdeent = g_enterprise AND
             apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apce2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'5'" THEN 
         CALL g_apce5_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'6'" THEN 
         CALL g_apce6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt823_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO apce_t
                  (apceent,
                   apceld,apcedocno,
                   apceseq
                   ,apce002,apceorga,apce003,apce004,apce005,apce061,apce038,apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010,apce031,apce049,apcecomp,apcesite,apce001,apce017,apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apce120,apce121,apce129,apce130,apce131,apce139) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apce_d[g_detail_idx].apce002,g_apce_d[g_detail_idx].apceorga,g_apce_d[g_detail_idx].apce003, 
                       g_apce_d[g_detail_idx].apce004,g_apce_d[g_detail_idx].apce005,g_apce_d[g_detail_idx].apce061, 
                       g_apce_d[g_detail_idx].apce038,g_apce_d[g_detail_idx].apce048,g_apce_d[g_detail_idx].apce024, 
                       g_apce_d[g_detail_idx].apce100,g_apce_d[g_detail_idx].apce109,g_apce_d[g_detail_idx].apce101, 
                       g_apce_d[g_detail_idx].apce119,g_apce_d[g_detail_idx].apce015,g_apce_d[g_detail_idx].apce016, 
                       g_apce_d[g_detail_idx].apce010,g_apce_d[g_detail_idx].apce031,g_apce_d[g_detail_idx].apce049, 
                       g_apce_d[g_detail_idx].apcecomp,g_apce_d[g_detail_idx].apcesite,g_apce_d[g_detail_idx].apce001, 
                       g_apce3_d[g_detail_idx].apce017,g_apce3_d[g_detail_idx].apce018,g_apce3_d[g_detail_idx].apce019, 
                       g_apce3_d[g_detail_idx].apce020,g_apce3_d[g_detail_idx].apce022,g_apce3_d[g_detail_idx].apce023, 
                       g_apce3_d[g_detail_idx].apce035,g_apce3_d[g_detail_idx].apce036,g_apce3_d[g_detail_idx].apce044, 
                       g_apce3_d[g_detail_idx].apce045,g_apce3_d[g_detail_idx].apce046,g_apce3_d[g_detail_idx].apce051, 
                       g_apce3_d[g_detail_idx].apce052,g_apce3_d[g_detail_idx].apce053,g_apce3_d[g_detail_idx].apce054, 
                       g_apce3_d[g_detail_idx].apce055,g_apce3_d[g_detail_idx].apce056,g_apce3_d[g_detail_idx].apce057, 
                       g_apce3_d[g_detail_idx].apce058,g_apce3_d[g_detail_idx].apce059,g_apce3_d[g_detail_idx].apce060, 
                       g_apce4_d[g_detail_idx].apce120,g_apce4_d[g_detail_idx].apce121,g_apce4_d[g_detail_idx].apce129, 
                       g_apce4_d[g_detail_idx].apce130,g_apce4_d[g_detail_idx].apce131,g_apce4_d[g_detail_idx].apce139) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apce_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apce3_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_apce4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2','5','6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO apde_t
                  (apdeent,
                   apdeld,apdedocno,
                   apdeseq
                   ,apdeorga,apde002,apde006,apde003,apde008,apde021,apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016,apde010,apde009,apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite,apde001,apde038,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apde120,apde121,apde129,apde130,apde131,apde139) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apce2_d[g_detail_idx].apdeorga,g_apce2_d[g_detail_idx].apde002,g_apce2_d[g_detail_idx].apde006, 
                       g_apce2_d[g_detail_idx].apde003,g_apce2_d[g_detail_idx].apde008,g_apce2_d[g_detail_idx].apde021, 
                       g_apce2_d[g_detail_idx].apde024,g_apce2_d[g_detail_idx].apde100,g_apce2_d[g_detail_idx].apde109, 
                       g_apce2_d[g_detail_idx].apde101,g_apce2_d[g_detail_idx].apde119,g_apce2_d[g_detail_idx].apde032, 
                       g_apce2_d[g_detail_idx].apde013,g_apce2_d[g_detail_idx].apde014,g_apce2_d[g_detail_idx].apde015, 
                       g_apce2_d[g_detail_idx].apde016,g_apce2_d[g_detail_idx].apde010,g_apce2_d[g_detail_idx].apde009, 
                       g_apce2_d[g_detail_idx].apde039,g_apce2_d[g_detail_idx].apde040,g_apce2_d[g_detail_idx].apde041, 
                       g_apce2_d[g_detail_idx].apde011,g_apce2_d[g_detail_idx].apde012,g_apce2_d[g_detail_idx].apde046, 
                       g_apce2_d[g_detail_idx].apdecomp,g_apce2_d[g_detail_idx].apdesite,g_apce2_d[g_detail_idx].apde001, 
                       g_apce5_d[g_detail_idx].apde038,g_apce5_d[g_detail_idx].apde017,g_apce5_d[g_detail_idx].apde018, 
                       g_apce5_d[g_detail_idx].apde019,g_apce5_d[g_detail_idx].apde020,g_apce5_d[g_detail_idx].apde022, 
                       g_apce5_d[g_detail_idx].apde023,g_apce5_d[g_detail_idx].apde035,g_apce5_d[g_detail_idx].apde036, 
                       g_apce5_d[g_detail_idx].apde042,g_apce5_d[g_detail_idx].apde043,g_apce5_d[g_detail_idx].apde044, 
                       g_apce5_d[g_detail_idx].apde051,g_apce5_d[g_detail_idx].apde052,g_apce5_d[g_detail_idx].apde053, 
                       g_apce5_d[g_detail_idx].apde054,g_apce5_d[g_detail_idx].apde055,g_apce5_d[g_detail_idx].apde056, 
                       g_apce5_d[g_detail_idx].apde057,g_apce5_d[g_detail_idx].apde058,g_apce5_d[g_detail_idx].apde059, 
                       g_apce5_d[g_detail_idx].apde060,g_apce6_d[g_detail_idx].apde120,g_apce6_d[g_detail_idx].apde121, 
                       g_apce6_d[g_detail_idx].apde129,g_apce6_d[g_detail_idx].apde130,g_apce6_d[g_detail_idx].apde131, 
                       g_apce6_d[g_detail_idx].apde139)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apce2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'5'" THEN 
         CALL g_apce5_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'6'" THEN 
         CALL g_apce6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt823_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apce_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt823_apce_t_mask_restore('restore_mask_o')
               
      UPDATE apce_t 
         SET (apceld,apcedocno,
              apceseq
              ,apce002,apceorga,apce003,apce004,apce005,apce061,apce038,apce048,apce024,apce100,apce109,apce101,apce119,apce015,apce016,apce010,apce031,apce049,apcecomp,apcesite,apce001,apce017,apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apce120,apce121,apce129,apce130,apce131,apce139) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apce_d[g_detail_idx].apce002,g_apce_d[g_detail_idx].apceorga,g_apce_d[g_detail_idx].apce003, 
                  g_apce_d[g_detail_idx].apce004,g_apce_d[g_detail_idx].apce005,g_apce_d[g_detail_idx].apce061, 
                  g_apce_d[g_detail_idx].apce038,g_apce_d[g_detail_idx].apce048,g_apce_d[g_detail_idx].apce024, 
                  g_apce_d[g_detail_idx].apce100,g_apce_d[g_detail_idx].apce109,g_apce_d[g_detail_idx].apce101, 
                  g_apce_d[g_detail_idx].apce119,g_apce_d[g_detail_idx].apce015,g_apce_d[g_detail_idx].apce016, 
                  g_apce_d[g_detail_idx].apce010,g_apce_d[g_detail_idx].apce031,g_apce_d[g_detail_idx].apce049, 
                  g_apce_d[g_detail_idx].apcecomp,g_apce_d[g_detail_idx].apcesite,g_apce_d[g_detail_idx].apce001, 
                  g_apce3_d[g_detail_idx].apce017,g_apce3_d[g_detail_idx].apce018,g_apce3_d[g_detail_idx].apce019, 
                  g_apce3_d[g_detail_idx].apce020,g_apce3_d[g_detail_idx].apce022,g_apce3_d[g_detail_idx].apce023, 
                  g_apce3_d[g_detail_idx].apce035,g_apce3_d[g_detail_idx].apce036,g_apce3_d[g_detail_idx].apce044, 
                  g_apce3_d[g_detail_idx].apce045,g_apce3_d[g_detail_idx].apce046,g_apce3_d[g_detail_idx].apce051, 
                  g_apce3_d[g_detail_idx].apce052,g_apce3_d[g_detail_idx].apce053,g_apce3_d[g_detail_idx].apce054, 
                  g_apce3_d[g_detail_idx].apce055,g_apce3_d[g_detail_idx].apce056,g_apce3_d[g_detail_idx].apce057, 
                  g_apce3_d[g_detail_idx].apce058,g_apce3_d[g_detail_idx].apce059,g_apce3_d[g_detail_idx].apce060, 
                  g_apce4_d[g_detail_idx].apce120,g_apce4_d[g_detail_idx].apce121,g_apce4_d[g_detail_idx].apce129, 
                  g_apce4_d[g_detail_idx].apce130,g_apce4_d[g_detail_idx].apce131,g_apce4_d[g_detail_idx].apce139)  
 
         WHERE apceent = g_enterprise AND apceld = ps_keys_bak[1] AND apcedocno = ps_keys_bak[2] AND apceseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apce_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apce_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt823_apce_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2','5','6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt823_apde_t_mask_restore('restore_mask_o')
               
      UPDATE apde_t 
         SET (apdeld,apdedocno,
              apdeseq
              ,apdeorga,apde002,apde006,apde003,apde008,apde021,apde024,apde100,apde109,apde101,apde119,apde032,apde013,apde014,apde015,apde016,apde010,apde009,apde039,apde040,apde041,apde011,apde012,apde046,apdecomp,apdesite,apde001,apde038,apde017,apde018,apde019,apde020,apde022,apde023,apde035,apde036,apde042,apde043,apde044,apde051,apde052,apde053,apde054,apde055,apde056,apde057,apde058,apde059,apde060,apde120,apde121,apde129,apde130,apde131,apde139) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apce2_d[g_detail_idx].apdeorga,g_apce2_d[g_detail_idx].apde002,g_apce2_d[g_detail_idx].apde006, 
                  g_apce2_d[g_detail_idx].apde003,g_apce2_d[g_detail_idx].apde008,g_apce2_d[g_detail_idx].apde021, 
                  g_apce2_d[g_detail_idx].apde024,g_apce2_d[g_detail_idx].apde100,g_apce2_d[g_detail_idx].apde109, 
                  g_apce2_d[g_detail_idx].apde101,g_apce2_d[g_detail_idx].apde119,g_apce2_d[g_detail_idx].apde032, 
                  g_apce2_d[g_detail_idx].apde013,g_apce2_d[g_detail_idx].apde014,g_apce2_d[g_detail_idx].apde015, 
                  g_apce2_d[g_detail_idx].apde016,g_apce2_d[g_detail_idx].apde010,g_apce2_d[g_detail_idx].apde009, 
                  g_apce2_d[g_detail_idx].apde039,g_apce2_d[g_detail_idx].apde040,g_apce2_d[g_detail_idx].apde041, 
                  g_apce2_d[g_detail_idx].apde011,g_apce2_d[g_detail_idx].apde012,g_apce2_d[g_detail_idx].apde046, 
                  g_apce2_d[g_detail_idx].apdecomp,g_apce2_d[g_detail_idx].apdesite,g_apce2_d[g_detail_idx].apde001, 
                  g_apce5_d[g_detail_idx].apde038,g_apce5_d[g_detail_idx].apde017,g_apce5_d[g_detail_idx].apde018, 
                  g_apce5_d[g_detail_idx].apde019,g_apce5_d[g_detail_idx].apde020,g_apce5_d[g_detail_idx].apde022, 
                  g_apce5_d[g_detail_idx].apde023,g_apce5_d[g_detail_idx].apde035,g_apce5_d[g_detail_idx].apde036, 
                  g_apce5_d[g_detail_idx].apde042,g_apce5_d[g_detail_idx].apde043,g_apce5_d[g_detail_idx].apde044, 
                  g_apce5_d[g_detail_idx].apde051,g_apce5_d[g_detail_idx].apde052,g_apce5_d[g_detail_idx].apde053, 
                  g_apce5_d[g_detail_idx].apde054,g_apce5_d[g_detail_idx].apde055,g_apce5_d[g_detail_idx].apde056, 
                  g_apce5_d[g_detail_idx].apde057,g_apce5_d[g_detail_idx].apde058,g_apce5_d[g_detail_idx].apde059, 
                  g_apce5_d[g_detail_idx].apde060,g_apce6_d[g_detail_idx].apde120,g_apce6_d[g_detail_idx].apde121, 
                  g_apce6_d[g_detail_idx].apde129,g_apce6_d[g_detail_idx].apde130,g_apce6_d[g_detail_idx].apde131, 
                  g_apce6_d[g_detail_idx].apde139) 
         WHERE apdeent = g_enterprise AND apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt823_apde_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt823_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt823.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt823_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt823.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt823_lock_b(ps_table,ps_page)
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
   #CALL aapt823_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','3','4',"
   #僅鎖定自身table
   LET ls_group = "apce_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt823_bcl USING g_enterprise,
                                       g_apda_m.apdald,g_apda_m.apdadocno,g_apce_d[g_detail_idx].apceseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt823_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2','5','6',"
   #僅鎖定自身table
   LET ls_group = "apde_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt823_bcl2 USING g_enterprise,
                                             g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[g_detail_idx].apdeseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt823_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aapt823.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt823_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','3','4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt823_bcl
   END IF
   
   LET ls_group = "'2','5','6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt823_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt823_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apdadocno,apdald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apdald,apdadocno",TRUE)
      CALL cl_set_comp_entry("apdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("apdasite,apda001,apdadocdt,apda023",TRUE)  
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt823_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
    CALL cl_set_comp_entry("apda015",FALSE) #151105-00007#2 add
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apdald,apdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("apdasite,apda001,apda023",FALSE)  
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apdadocno,apdald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"

   #151130-00015#2  -add -str
   IF NOT cl_null(g_apda_m.apdadocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("apdadocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt823_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("apde006,apde008,apde013,apde014,apde021,apde024,apde032,apde039,apde040",TRUE)
   CALL cl_set_comp_entry("apdeorga,apde002,apde006,apde008,apde021,apde024,apde100,apde109,apde101,apde119,
                           apde013,apde014,apde032,apde039,apde040,apde011,apde012",TRUE)
   
   CALL cl_set_comp_entry("apde003",TRUE)   #已付款單號        
   CALL cl_set_comp_entry("apdeorga,apde002,apde006,apde008,apde021,apde024,apde100,apde101,apde010,
                           apde013,apde014,apde032,apde039,apde040,apde011,apde012",TRUE)
   CALL cl_set_comp_entry("lc_apde008",TRUE)    #160122-00001#5                    
  #CALL cl_set_comp_entry("apde041",TRUE)    #160324-00032#3 mark   #160202-00021#2
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt823_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   CALL cl_set_comp_entry("apde041",FALSE) #160324-00032#3
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apce2_d[l_ac].apde002
		   WHEN '10'
            IF NOT(g_apce2_d[l_ac].apde006 = '10' OR g_apce2_d[l_ac].apde006 = '20' OR g_apce2_d[l_ac].apde006 = '30') THEN 
               CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
               CALL cl_set_comp_entry("apde041",FALSE)      #160202-00021#2
               CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
               LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040=''	
               LET g_apce2_d[l_ac].apde041=''	#160202-00021#2
               LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
               IF g_apce2_d[l_ac].apde006 = '90' THEN   #150128-00005#9
                  CALL cl_set_comp_entry("apde003",FALSE)                         
               END IF  #150128-00005#9
               LET g_apce2_d[l_ac].apde003=''               
            END IF
            IF NOT (g_apce2_d[l_ac].apde006 = '30' OR g_apce2_d[l_ac].apde006 = '40' OR g_apce2_d[l_ac].apde006 = '50' OR
                    g_apce2_d[l_ac].apde006 = '60' OR g_apce2_d[l_ac].apde006 = '70' OR g_apce2_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde021",FALSE)
               LET g_apce2_d[l_ac].apde021=''
            END IF             
            IF NOT (g_apce2_d[l_ac].apde006 = '30' OR g_apce2_d[l_ac].apde006 = '40' OR g_apce2_d[l_ac].apde006 = '50' OR
                    g_apce2_d[l_ac].apde006 = '60' OR g_apce2_d[l_ac].apde006 = '90') THEN
               CALL cl_set_comp_entry("apde024",FALSE)
               LET g_apce2_d[l_ac].apde024=''
            END IF    
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013=''    
            IF NOT(g_apce2_d[l_ac].apde006 = '30') THEN
               CALL cl_set_comp_entry("apde014",FALSE)
               LET g_apce2_d[l_ac].apde014=''
            END IF                                           
		   
		   WHEN '11'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''			 
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''            #160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040='' 
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''            
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''         
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt    
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013=''     
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apce2_d[l_ac].apde014=''     
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                
		   WHEN '12'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''				
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''            #160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040='' 
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''         
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''                                 	   
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013=''      
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apce2_d[l_ac].apde014=''        
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '13'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''	
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''            #160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040=''  
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''        
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''                
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt   
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013=''      
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apce2_d[l_ac].apde014=''         
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '14'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''		
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''            #160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040='' 
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''         
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''  
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013=''        
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apce2_d[l_ac].apde014=''    
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '15'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''			
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''            #160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040='' 
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''      
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''      
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt  
            CALL cl_set_comp_entry("apde013",FALSE)
            LET g_apce2_d[l_ac].apde013='' 
            CALL cl_set_comp_entry("apde014",FALSE)
            LET g_apce2_d[l_ac].apde014='' 
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '20'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''				
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''	#160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040=''
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add           
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''                 
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''           
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '21'
            CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''				
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''	#160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040=''  
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''               
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''           
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt  
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
		   WHEN '22'
		      CALL cl_set_comp_entry("apde006",FALSE)
            LET g_apce2_d[l_ac].apde006=''
            CALL cl_set_comp_entry("apde008,apde039,apde040",FALSE)
            CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
            LET g_apce2_d[l_ac].apde041=''	#160202-00021#2
            CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
            LET g_apce2_d[l_ac].apde008='' LET g_apce2_d[l_ac].apde039='' LET g_apce2_d[l_ac].apde040=''        
            LET g_apce2_d[l_ac].lc_apde008='' #160122-00001#5 add
            CALL cl_set_comp_entry("apde021",FALSE)
            LET g_apce2_d[l_ac].apde021=''      
            CALL cl_set_comp_entry("apde024",FALSE)
            LET g_apce2_d[l_ac].apde024=''           
            CALL cl_set_comp_entry("apde032",FALSE)
            LET g_apce2_d[l_ac].apde032= g_apda_m.apdadocdt
            CALL cl_set_comp_entry("apde003",FALSE) 
            LET g_apce2_d[l_ac].apde003=''                     
      END CASE            

      IF NOT cl_null(g_apce2_d[l_ac].apde046) THEN
         CALL cl_set_comp_entry("apdeorga,apde002,apde006,apde008,apde021,apde024,apde100,apde109,apde101,apde119,
                                 apde013,apde014,apde032,apde039,apde040,apde011,apde012",FALSE)
         CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
         CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
      END IF      
      #付款類型為10:付款,且有已付款單號者(來源為anmt440/anmt460),不可異動的欄位
      IF g_apce2_d[l_ac].apde002 = '10' AND NOT cl_null(g_apce2_d[l_ac].apde003) THEN
         CALL cl_set_comp_entry("apdeorga,apde002,apde006,apde008,apde021,apde024,apde100,apde101,apde010,
                                 apde013,apde014,apde032,apde039,apde040,apde011,apde012",FALSE)
         CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
         CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add
      END IF          
      #付款類型為16:收票轉付,限定款別為30:票據
      IF g_apce2_d[l_ac].apde002 = '16' THEN
         LET g_apce2_d[l_ac].apde006 = '30'
         CALL cl_set_comp_entry("apde006",FALSE)
      END IF     
      #付款類型為16:收票轉付,有已付款單號者(來源為anmt510),不可異動的欄位
      IF g_apce2_d[l_ac].apde002 = '16' AND NOT cl_null(g_apce2_d[l_ac].apde003) THEN
         CALL cl_set_comp_entry("apdeorga,apde002,apde006,apde008,apde021,apde100,apde109,apde010,
                                 apde013,apde014,apde032,apde039,apde040",FALSE)
         CALL cl_set_comp_entry("apde041",FALSE)   #160202-00021#2
         CALL cl_set_comp_entry("lc_apde008",FALSE)    #160122-00001#5 add                        
      END IF                  
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt823_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
 
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt823_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   IF g_apda_m.apdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160225-00001#1--(S)
   IF NOT cl_null(g_apda_m.apdadocno) THEN
      SELECT glaald INTO l_ld FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apda_m.apdacomp
         AND glaa014 = 'Y'
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_slip
      CALL s_fin_get_doc_para(l_ld,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      CALL s_fin_date_close_chk('@',g_apda_m.apdacomp,'AAP',g_apda_m.apdadocdt) RETURNING g_sub_success
      IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
         CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      END IF
   END IF
   #160225-00001#1--(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt823_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt823_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt823_default_search()
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
      LET ls_wc = ls_wc, " apdald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apdadocno = '", g_argv[02], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apce_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apde_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="aapt823.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt823_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE  l_continue            LIKE type_t.chr1
   DEFINE  l_ap_slip             LIKE apca_t.apcadocno
   DEFINE  l_amt1                LIKE apce_t.apce119
   DEFINE  l_amt2                LIKE apce_t.apce119
   DEFINE  l_flag                LIKE type_t.num5
   #151125-00006#2--s
   DEFINE l_sql            STRING
   DEFINE l_apde014        LIKE apde_t.apde014
   DEFINE l_apde002        LIKE apde_t.apde002
   #151125-00006#2--e
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   CALL aapt823_ui_headershow()        #150311--add #顯示最新的資料
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apda_m.apdald IS NULL
      OR g_apda_m.apdadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF STATUS THEN
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt823_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apda003, 
       g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda023, 
       g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018, 
       g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid, 
       g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aapt823_action_chk() THEN
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003,g_apda_m.apda003_desc,g_apda_m.apdald, 
       g_apda_m.apdald_desc,g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001,g_apda_m.apdadocdt, 
       g_apda_m.apda005,g_apda_m.apda005_desc,g_apda_m.apda023,g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp, 
       g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda007,g_apda_m.apda009, 
       g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apda016,g_apda_m.apda017,g_apda_m.apdaownid,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt, 
       g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt,g_apda_m.dummy3,g_apda_m.glaa001, 
       g_apda_m.sum_apde1092,g_apda_m.sum_apde1192,g_apda_m.sum_apde1091,g_apda_m.sum_apde1191,g_apda_m.sum_apde1093, 
       g_apda_m.sum_apde1193,g_apda_m.sum_apde1094,g_apda_m.sum_apde1194,g_apda_m.glaa016,g_apda_m.glaa020, 
       g_apda_m.sum_apde1291,g_apda_m.sum_apde1391,g_apda_m.sum_apde1292,g_apda_m.sum_apde1392,g_apda_m.sum_apde1293, 
       g_apda_m.sum_apde1393,g_apda_m.sum_apde1294,g_apda_m.sum_apde1394
 
   CASE g_apda_m.apdastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
         CASE g_apda_m.apdastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
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

      CASE g_apda_m.apdastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed",FALSE)
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
            CALL s_transaction_end('N','0')          #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aapt823_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt823_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt823_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt823_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
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
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_apda_m.apdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      #150210--Mark---
      #150128-00005#1---(S)----
      #CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_ap_slip               
      #CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      #IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
      #   CALL s_transaction_begin()
      #   CALL s_pre_voucher_ins('AP','P20',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
      #        RETURNING g_sub_success
      #   IF g_sub_success THEN 
      #      CALL s_transaction_end('Y','0')
      #   ELSE
      #      CALL s_transaction_end('N','0')
      #   END IF
      #END IF
      #150128-00005#1---(E)----
      #150210--Mark---
      CALL cl_err_collect_init()
      IF NOT s_aapt823_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
         CALL s_transaction_end('N','0')             #150401-00001#13
         CALL cl_err_collect_show()
         #差異處理
         CALL aapt823_open_aapt823_09()RETURNING g_sub_success,l_continue
         CALL aapt823_show()      
         RETURN                 
      ELSE
        #2015/6/4--by--02599--add--str--
        #当账款类型是应收单冲销时，需检查该付款对象的金额是否冲销完
        #未收款款金额
        LET l_amt1=0
        SELECT SUM(xrcc118-xrcc119+xrcc113) INTO l_amt1 
          FROM xrcc_t,xrca_t
         WHERE xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno
           AND xrcaent=g_enterprise 
           AND xrcasite=g_apda_m.apdasite
           AND xrcald=g_apda_m.apdald
           AND xrca001 LIKE '1%'
           AND xrca005 IN (SELECT apce038 FROM apce_t
                            WHERE apceent = g_enterprise 
                              AND apceld  = g_apda_m.apdald
                              AND apcedocno = g_apda_m.apdadocno)
           AND xrcastus='Y'
        IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
        
        #该单据要用应收单冲抵的金额
        LET l_amt2=0
        SELECT SUM(apce119) INTO l_amt2 FROM apce_t
         WHERE apceent=g_enterprise AND apceld=g_apda_m.apdald
           AND apcedocno=g_apda_m.apdadocno AND apce002='30'
        IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
        
        LET l_flag = TRUE #标示询问执行提醒
        #当该客户还有尚未收款的金额，提示是否付款
        IF l_amt1-l_amt2 > 0 THEN
           IF NOT cl_ask_confirm('aap-00373') THEN   #是否執行確認？
              CALL s_transaction_end('N','0')        #150401-00001#13
              CALL cl_err_collect_show()
              RETURN
           END IF
           LET l_flag = FALSE #标示不询问执行提醒
        END IF
        #根据标示判断是否显示提醒信息
        IF l_flag = TRUE THEN        
           IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
              CALL s_transaction_end('N','0')        #150401-00001#13
              CALL cl_err_collect_show()
              RETURN
           END IF
        END IF
        CALL s_transaction_begin()
        IF NOT s_aapt823_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno,g_sfin3008) THEN
           CALL s_transaction_end('N','0')
           CALL cl_err_collect_show()
           RETURN
        ELSE
           CALL s_transaction_end('Y','0')
           CALL cl_err_collect_show()
           #151125-00006#2--s--
           LET l_sql = " SELECT DISTINCT apde002,apde014 FROM apde_t,apda_t ",
                       "  WHERE apdeld = apdald AND apdedocno = apdadocno AND apdeent = apdaent ",
                       "    AND apdaent = '",g_enterprise,"' ",
                       "    AND apdald = '",g_apda_m.apdald,"' ", 
                       "    AND apdadocno = '",g_apda_m.apdadocno,"' "   
           PREPARE s_aapt823_doc_gen_p FROM l_sql
           DECLARE s_aapt823_doc_gen_c CURSOR FOR s_aapt823_doc_gen_p
   
           FOREACH s_aapt823_doc_gen_c INTO l_apde002,l_apde014             
           CASE 
              WHEN l_apde002 = '20'
                 CALL s_aapt420_contra_doc_immediately_gen(g_apda_m.apdald,l_apde014)
              WHEN l_apde002 = '21'
                 CALL s_aapt420_contra_doc2_immediately_gen(g_apda_m.apdald,l_apde014)
              WHEN l_apde002 = '22'  
                 CALL s_aapt420_contra_doc_immediately_gen(g_apda_m.apdald,l_apde014)
           END CASE
           END FOREACH
           #151125-00006#2--e--
        END IF
        #2015/6/4--by--02599--mod--end
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt823_unconf_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_sfin3008) THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt823_unconf_upd(g_apda_m.apdald,g_apda_m.apdadocno) THEN
               CALL s_transaction_end('N','0')     #150401-00001#13
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
      CALL cl_set_comp_entry("apda015",TRUE)
      CALL cl_err_collect_init()
      IF "1=1" THEN
#      IF NOT s_aapt823_void_chk(g_apda_m.apdald,g_apda_m.apdadocno)  THEN
      	CALL s_transaction_end('N','0')           #150401-00001#13
      	CALL cl_err_collect_show()
         RETURN    
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            #151105-00007#2 ---add (S)---
            INPUT BY NAME g_apda_m.apda015 WITHOUT DEFAULTS
               BEFORE INPUT
                  LET INT_FLAG = 0
               
               ON ACTION controlp INFIELD apda015
                  #作廢
      			   INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
      			   LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apda_m.apda015       
                  LET g_qryparam.arg1 = "3115"
                  CALL q_oocq002()                           
                  LET g_apda_m.apda015 = g_qryparam.return1     
                  CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                  DISPLAY BY NAME g_apda_m.apda015,g_apda_m.apda015_desc            
                  NEXT FIELD apda015   
               
               AFTER FIELD apda015
                  LET g_apda_m.apda015_desc = ' '
                  IF NOT cl_null(g_apda_m.apda015) THEN
                     IF NOT s_azzi650_chk_exist('3115',g_apda_m.apda015) THEN
                        LET g_apda_m.apda015 = g_apda_m_t.apda015
                        CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                        DISPLAY BY NAME g_apda_m.apda015_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT 
                  END IF
                  CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                  DISPLAY BY NAME g_apda_m.apda015_desc 
               
               AFTER INPUT
                  IF NOT cl_null(g_apda_m.apdald) THEN
                     UPDATE apda_t SET apda015 = g_apda_m.apda015
                      WHERE apdaent   = g_enterprise
                        AND apdald    = g_apda_m.apdald
                        AND apdadocno = g_apda_m.apdadocno
                  END IF
               ON ACTION accept
                  ACCEPT INPUT
              
               ON ACTION cancel
                  LET INT_FLAG = 1
                  LET g_apda_m.apda015 = ''
                  LET g_apda_m.apda015_desc = ''
                  EXIT INPUT 
                  
               IF INT_FLAG THEN
                  CALL cl_err_collect_show()   
                  CALL s_transaction_end('N','0') 
                  RETURN
               END IF
            END INPUT
            IF cl_null(g_apda_m.apda015) THEN
               LET lc_state = 'N'
               LET g_apda_m.apdastus = lc_state
               CALL s_transaction_end('N','0') 
               CALL cl_err_collect_show()   
               DISPLAY BY NAME g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apdastus
               RETURN
            END IF
            #151105-00007#2 ---add (E)---
            IF "1=1" THEN
#            IF NOT s_aapt823_void_upd(g_apda_m.apdald,g_apda_m.apdadocno) THEN
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
   
   LET g_apda_m.apdamodid = g_user
   LET g_apda_m.apdamoddt = cl_get_current()
   LET g_apda_m.apdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apda_t 
      SET (apdastus,apdamodid,apdamoddt) 
        = (g_apda_m.apdastus,g_apda_m.apdamodid,g_apda_m.apdamoddt)     
    WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
      EXECUTE aapt823_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite, 
          g_apda_m.apda003,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdadocdt,g_apda_m.apda005, 
          g_apda_m.apda023,g_apda_m.apda014,g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010, 
          g_apda_m.apda018,g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda016,g_apda_m.apda017, 
          g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
          g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
          g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
          g_apda_m.apdacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003,g_apda_m.apda003_desc, 
          g_apda_m.apdald,g_apda_m.apdald_desc,g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001, 
          g_apda_m.apdadocdt,g_apda_m.apda005,g_apda_m.apda005_desc,g_apda_m.apda023,g_apda_m.apda014, 
          g_apda_m.apdastus,g_apda_m.apdacomp,g_apda_m.apda008,g_apda_m.apda010,g_apda_m.apda018,g_apda_m.apda018_desc, 
          g_apda_m.apda007,g_apda_m.apda009,g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apda016, 
          g_apda_m.apda017,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
          g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
          g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
          g_apda_m.apdacnfdt,g_apda_m.dummy3,g_apda_m.glaa001,g_apda_m.sum_apde1092,g_apda_m.sum_apde1192, 
          g_apda_m.sum_apde1091,g_apda_m.sum_apde1191,g_apda_m.sum_apde1093,g_apda_m.sum_apde1193,g_apda_m.sum_apde1094, 
          g_apda_m.sum_apde1194,g_apda_m.glaa016,g_apda_m.glaa020,g_apda_m.sum_apde1291,g_apda_m.sum_apde1391, 
          g_apda_m.sum_apde1292,g_apda_m.sum_apde1392,g_apda_m.sum_apde1293,g_apda_m.sum_apde1393,g_apda_m.sum_apde1294, 
          g_apda_m.sum_apde1394
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT apdamodid,apdamoddt,apdacnfid,apdacnfdt
     INTO g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdald = g_apda_m.apdald AND apdadocno = g_apda_m.apdadocno
   DISPLAY BY NAME g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt   
   CALL aapt823_show()
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   #151125-00006#2--s
   IF g_apda_m.apdastus = 'Y' THEN
      CALL aapt823_immediately_gen()
      CALL aapt823_ui_headershow()
   END IF
   #151125-00006#2--e
   #end add-point  
 
   CLOSE aapt823_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt823_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt823.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt823_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apce_d.getLength() THEN
         LET g_detail_idx = g_apce_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_apce2_d.getLength() THEN
         LET g_detail_idx = g_apce2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_apce3_d.getLength() THEN
         LET g_detail_idx = g_apce3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_apce4_d.getLength() THEN
         LET g_detail_idx = g_apce4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_apce5_d.getLength() THEN
         LET g_detail_idx = g_apce5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_apce6_d.getLength() THEN
         LET g_detail_idx = g_apce6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apce6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apce6_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt823_b_fill2(pi_idx)
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
   
   CALL aapt823_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt823_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   IF ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) OR
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt823.status_show" >}
PRIVATE FUNCTION aapt823_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt823.mask_functions" >}
&include "erp/aap/aapt823_mask.4gl"
 
{</section>}
 
{<section id="aapt823.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt823_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aapt823_show()
   CALL aapt823_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"


   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apce_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_apce2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_apce3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_apce4_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_apce5_d))
   CALL cl_bpm_set_detail_data("s_detail6", util.JSONArray.fromFGL(g_apce6_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   IF NOT s_aapt823_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt823_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt823_ui_headershow()
   CALL aapt823_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt823_draw_out()
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
   CALL aapt823_ui_headershow()  
   CALL aapt823_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt823.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt823_set_pk_array()
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
   LET g_pk_array[1].values = g_apda_m.apdald
   LET g_pk_array[1].column = 'apdald'
   LET g_pk_array[2].values = g_apda_m.apdadocno
   LET g_pk_array[2].column = 'apdadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt823.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt823.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt823_msgcentre_notify(lc_state)
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
   CALL aapt823_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt823.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt823_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt823.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳別預設資料
# Memo...........:
# Usage..........: CALL aapt823_set_ld_info(p_ld)
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_set_ld_info(p_ld)
DEFINE p_ld       LIKE apda_t.apdald
DEFINE l_using    LIKE type_t.num5

   CALL s_ld_sel_glaa(p_ld,'glaald|glaacomp|glaa001|glaa004|glaa005|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024|glaa025|glaa026|glaa121')
        RETURNING g_sub_success,g_glaa.*   
   LET g_apda_m.glaa001 = g_glaa.glaa001 

   #取得帳套範圍
   CALL aapt823_get_ld_wc(g_apda_m.apdasite) RETURNING g_ld_wc,g_site_wc      
   #取得參數
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-3007') RETURNING g_sfin3007
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-3008') RETURNING g_sfin3008
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-2002') RETURNING g_sfin2002   
   #是否啟用分錄底稿
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("open_pre", FALSE)
   END IF
   IF g_glaa.glaa015 = 'N' AND  g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page_5,page_8,page_9,grid_22',FALSE)    #本位幣頁籤隱藏
      CALL cl_set_comp_required('apde121,apde131',FALSE)      
   ELSE
      CALL cl_set_comp_visible('page_5,page_8,page_9',TRUE)     #本位幣頁籤顯示
      #本幣二處理===(S)===
      IF g_glaa.glaa015 = 'Y' THEN
         LET l_using = TRUE
         LET g_apda_m.glaa016 = g_glaa.glaa016
      ELSE
         LET l_using = FALSE
      END IF
      CALL cl_set_comp_visible('apce120,apce121,apce129',l_using)
      CALL cl_set_comp_visible('apde120,apde121,apde129',l_using)
      CALL cl_set_comp_required('apde121',l_using)      
      CALL cl_set_comp_visible('lbl_glaa016,glaa016,sum_apde1291,sum_apde1292,sum_apde1293,sum_apde1294',l_using)
      CALL cl_set_comp_visible('glaa001_2,amt1_d_1,amt3_c_1,amt5_diff_1',l_using)
      LET g_amt1_d_1 = 0
      LET g_amt3_c_1 = 0
      LET g_amt5_diff_1 = 0
      #本幣二處理===(E)===

      #本幣三處理===(S)===
      LET l_using = TRUE
      IF g_glaa.glaa019 = 'Y' THEN
         LET l_using = TRUE
         LET g_apda_m.glaa020 = g_glaa.glaa020
      ELSE
         LET l_using = FALSE
      END IF
      CALL cl_set_comp_visible('apce130,apce131,apce139',l_using)
      CALL cl_set_comp_visible('apde130,apde131,apde139',l_using)
      CALL cl_set_comp_required('apde131',l_using)          
      CALL cl_set_comp_visible('lbl_glaa020,glaa020,sum_apde1391,sum_apde1392,sum_apde1393,sum_apde1394',l_using)
      CALL cl_set_comp_visible('glaa001_3,amt2_d_1,amt4_c_1,amt6_diff_1',l_using)   
      LET g_amt2_d_1 = 0
      LET g_amt4_c_1 = 0
      LET g_amt6_diff_1 = 0      
      #本幣三處理===(E)===
   END IF   
   
   DISPLAY BY NAME g_apda_m.glaa001,g_apda_m.glaa016,g_apda_m.glaa020
   DISPLAY g_glaa.glaa016,g_glaa.glaa020 TO glaa001_2,glaa001_3 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#2 #161229-00047#63 mark
   #161229-00047#63 add ------
   CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#63 add end---   
END FUNCTION

################################################################################
# Descriptions...: 抓取集團代收付基本資料
# Memo...........:
# Usage..........: CALL aapt823_sel_apaf(p_apaf001,p_apaf011)
#                  RETURNING r_apaf012,r_apaf013,r_apaf015,r_apaf016
# Input parameter: p_apaf001    代收付類型
#                : p_apaf011    帳務歸屬組織
# Return code....: r_apaf012    內部帳戶
#                : r_apaf013    沖銷單別
#                : r_apaf015    存提碼
#                : r_apaf016    現金變動碼
# Date & Author..: 14/10/08 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_sel_apaf(p_apaf001,p_apaf011)
   DEFINE p_apaf001    LIKE apaf_t.apaf001   #代收付類型
   DEFINE p_apaf011    LIKE apaf_t.apaf011   #帳務歸屬組織
   DEFINE r_apaf012    LIKE apaf_t.apaf012   #內部帳戶
   DEFINE r_apaf013    LIKE apaf_t.apaf013   #沖銷單別
   DEFINE r_apaf015    LIKE apaf_t.apaf015   #存提碼
   DEFINE r_apaf016    LIKE apaf_t.apaf016   #現金變動碼
   
   SELECT apaf012,apaf013,apaf015,apaf016
     INTO r_apaf012,r_apaf013,r_apaf015,r_apaf016 FROM apaf_t
    WHERE apafent = g_enterprise
      AND apaf001 = p_apaf001
      AND apaf011 = p_apaf011
      
   RETURN r_apaf012,r_apaf013,r_apaf015,r_apaf016
END FUNCTION

################################################################################
# Descriptions...: 重新計算本幣金額
# Memo...........: 
# Usage..........: aapt823_trans_to_local_curr(p_curr)
# Input parameter: p_curr      原幣幣別
# Date & Author..: 14/10/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_trans_to_local_curr(p_curr)
   DEFINE p_curr       LIKE glaa_t.glaa002   #原幣幣別
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            type     LIKE type_t.chr1
                    END RECORD
#   #取本幣匯率
#   CALL s_aooi160_get_exrate('1',g_apda_m.apdacomp,g_apda_m.apdadocdt,p_trans,p_curr,0,g_glaa.glaa025)
#        RETURNING r_rate
   #150930-00010#4--s
   #有輸入交易帳戶時,取銀存支出匯率來源
#   IF NOT cl_null(g_apce2_d[l_ac].apde008) THEN #160122-00001#5 mark
    IF NOT cl_null(g_apce2_d[l_ac].lc_apde008) THEN #160122-00001#5 add
      CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-4012') RETURNING g_sfin4012  
   ELSE
      LET g_sfin4012 = ''
   END IF
   IF g_sfin4012  = '23' THEN
      #銀行日平均匯率
      CALL s_anm_get_exrate(g_apda_m.apdald,g_apda_m.apdacomp,g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde100,g_apda_m.glaa001,g_apda_m.apdadocdt) RETURNING g_apce2_d[l_ac].apde101   
   ELSE
   #150930-00010#4--e    

      LET lc_param.type = '0'   #因為對象在各筆單身,所以只依帳套設定取匯率來源
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apdadocdt,p_curr,ls_js)
           RETURNING g_apce2_d[l_ac].apde101,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde131

   END IF   #150930-00010#4   
      
#   #本幣金額 = 原幣金額 * 本幣匯率
#   LET r_amt = p_amt * r_rate   
#   IF cl_null(r_amt) THEN LET r_amt = 0 END IF   
#   CALL s_curr_round_ld('1',g_apda_m.apdald,p_curr,r_amt,2) 
#    RETURNING g_sub_success,g_errno,r_amt 
   #本幣重計
   LET g_apce2_d[l_ac].apde119 = g_apce2_d[l_ac].apde109 * g_apce2_d[l_ac].apde101
   IF cl_null(g_apce2_d[l_ac].apde119) THEN LET g_apce2_d[l_ac].apde119 = 0 END IF
   CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa.glaa001,g_apce2_d[l_ac].apde119,2) RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apde119   
   DISPLAY BY NAME g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde119
   #本幣二重計
   IF g_glaa.glaa015 = 'Y' THEN
      LET g_apce6_d[l_ac].apde129 = g_apce2_d[l_ac].apde109 * g_apce6_d[l_ac].apde121
      IF cl_null(g_apce6_d[l_ac].apde129) THEN LET g_apce6_d[l_ac].apde129 = 0 END IF
      CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde129,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde129 
      DISPLAY BY NAME g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129
   END IF
   #本幣三重計
   IF g_glaa.glaa019 = 'Y' THEN
      LET g_apce6_d[l_ac].apde139 = g_apce2_d[l_ac].apde109 * g_apce6_d[l_ac].apde131
      IF cl_null(g_apce6_d[l_ac].apde139) THEN LET g_apce6_d[l_ac].apde139 = 0 END IF
      CALL s_curr_round_ld('1',g_apda_m.apdald,g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde139,2) RETURNING g_sub_success,g_errno,g_apce6_d[l_ac].apde139                        
      DISPLAY BY NAME g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139
   END IF      
   
END FUNCTION
################################################################################
# Descriptions...: 合計頁簽計算及顯示
# Memo...........:
# Usage..........: CALL aapt823_sum_page_show()
# Date & Author..: 14/10/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_sum_page_show()
   DEFINE l_apde_plus  RECORD    #沖帳金額正的部分
              apde109  LIKE apde_t.apde109,
              apde119  LIKE apde_t.apde119,
              apde129  LIKE apde_t.apde129,
              apde139  LIKE apde_t.apde139
                       END RECORD 
   DEFINE l_apde_minus RECORD   #沖帳金額負的部分
              apde109  LIKE apde_t.apde109,
              apde119  LIKE apde_t.apde119,
              apde129  LIKE apde_t.apde129,
              apde139  LIKE apde_t.apde139
                       END RECORD
                                             
   DEFINE l_apde109_d  LIKE apde_t.apde109 
   DEFINE l_apde119_d  LIKE apde_t.apde119
   DEFINE l_apde129_d  LIKE apde_t.apde129
   DEFINE l_apde139_d  LIKE apde_t.apde139
   DEFINE l_apde109_c  LIKE apde_t.apde109
   DEFINE l_apde119_c  LIKE apde_t.apde119
   DEFINE l_apde129_c  LIKE apde_t.apde129
   DEFINE l_apde139_c  LIKE apde_t.apde139
   DEFINE l_apce109_d  LIKE apde_t.apde109
   DEFINE l_apce119_d  LIKE apde_t.apde119
   DEFINE l_apce129_d  LIKE apde_t.apde129
   DEFINE l_apce139_d  LIKE apde_t.apde139
   DEFINE l_apce109_c  LIKE apde_t.apde109
   DEFINE l_apce119_c  LIKE apde_t.apde119
   DEFINE l_apce129_c  LIKE apde_t.apde129
   DEFINE l_apce139_c  LIKE apde_t.apde139
   

   LET g_apda_m.sum_apde1091 = NULL
   LET g_apda_m.sum_apde1092 = NULL
   LET g_apda_m.sum_apde1093 = NULL
   LET g_apda_m.sum_apde1094 = NULL

   LET g_apda_m.sum_apde1191 = NULL
   LET g_apda_m.sum_apde1192 = NULL
   LET g_apda_m.sum_apde1193 = NULL
   LET g_apda_m.sum_apde1194 = NULL
   
      
   ###收付款金額###
   #正
   INITIALIZE l_apde_plus.* TO NULL
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
     INTO l_apde_plus.* 
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald
      AND apde002 IN ('10','16')
      AND apde015 = 'C' 
   IF cl_null(l_apde_plus.apde109)THEN LET l_apde_plus.apde109 = 0 END IF
   IF cl_null(l_apde_plus.apde119)THEN LET l_apde_plus.apde119 = 0 END IF
   IF cl_null(l_apde_plus.apde129)THEN LET l_apde_plus.apde129 = 0 END IF
   IF cl_null(l_apde_plus.apde139)THEN LET l_apde_plus.apde139 = 0 END IF

   #負
   INITIALIZE l_apde_minus.* TO NULL
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
     INTO l_apde_minus.* 
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald
      AND apde002 IN ('10','16')
      AND apde015 = 'D' 
   IF cl_null(l_apde_minus.apde109)THEN LET l_apde_minus.apde109 = 0 END IF
   IF cl_null(l_apde_minus.apde119)THEN LET l_apde_minus.apde119 = 0 END IF
   IF cl_null(l_apde_minus.apde129)THEN LET l_apde_minus.apde129 = 0 END IF
   IF cl_null(l_apde_minus.apde139)THEN LET l_apde_minus.apde139 = 0 END IF
   
   
   
   LET g_apda_m.sum_apde1091 = l_apde_plus.apde109 - l_apde_minus.apde109
   LET g_apda_m.sum_apde1191 = l_apde_plus.apde119 - l_apde_minus.apde119
   LET g_apda_m.sum_apde1291 = l_apde_plus.apde129 - l_apde_minus.apde129
   LET g_apda_m.sum_apde1391 = l_apde_plus.apde139 - l_apde_minus.apde139


   ####核銷請款金額###
   #正
   INITIALIZE l_apde_plus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139) 
     INTO l_apde_plus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      AND apce002 IN ('30','31','32','40','41','42')
      AND apce015 = 'C' 
   IF cl_null(l_apde_plus.apde109)THEN LET l_apde_plus.apde109 = 0 END IF
   IF cl_null(l_apde_plus.apde119)THEN LET l_apde_plus.apde119 = 0 END IF
   IF cl_null(l_apde_plus.apde129)THEN LET l_apde_plus.apde129 = 0 END IF
   IF cl_null(l_apde_plus.apde139)THEN LET l_apde_plus.apde139 = 0 END IF

   #負
   INITIALIZE l_apde_minus.* TO NULL
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
     INTO l_apde_minus.* 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      AND apce002 IN ('30','31','32','40','41','42')
      AND apce015 = 'D' 
   IF cl_null(l_apde_minus.apde109)THEN LET l_apde_minus.apde109 = 0 END IF
   IF cl_null(l_apde_minus.apde119)THEN LET l_apde_minus.apde119 = 0 END IF
   IF cl_null(l_apde_minus.apde129)THEN LET l_apde_minus.apde129 = 0 END IF
   IF cl_null(l_apde_minus.apde139)THEN LET l_apde_minus.apde139 = 0 END IF

   LET g_apda_m.sum_apde1092 = l_apde_plus.apde109 - l_apde_minus.apde109
   LET g_apda_m.sum_apde1192 = l_apde_plus.apde119 - l_apde_minus.apde119
   LET g_apda_m.sum_apde1292 = l_apde_plus.apde129 - l_apde_minus.apde129
   LET g_apda_m.sum_apde1392 = l_apde_plus.apde139 - l_apde_minus.apde139
   #帳款金額合計後轉向作計算
   LET g_apda_m.sum_apde1092 = g_apda_m.sum_apde1092 * -1
   LET g_apda_m.sum_apde1192 = g_apda_m.sum_apde1192 * -1
   LET g_apda_m.sum_apde1292 = g_apda_m.sum_apde1292 * -1
   LET g_apda_m.sum_apde1392 = g_apda_m.sum_apde1392 * -1


   ###匯差及調整金額###
   #正
   INITIALIZE l_apde_plus.* TO NULL
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139) 
     INTO l_apde_plus.* 
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald      
      AND apde002 NOT IN ('10','16')
      AND apde015 = 'C' 
   IF cl_null(l_apde_plus.apde109)THEN LET l_apde_plus.apde109 = 0 END IF
   IF cl_null(l_apde_plus.apde119)THEN LET l_apde_plus.apde119 = 0 END IF
   IF cl_null(l_apde_plus.apde129)THEN LET l_apde_plus.apde129 = 0 END IF
   IF cl_null(l_apde_plus.apde139)THEN LET l_apde_plus.apde139 = 0 END IF

   #負
   INITIALIZE l_apde_minus.* TO NULL
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
     INTO l_apde_minus.* 
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald
      AND apde002 NOT IN ('10','16')
      AND apde015 = 'D'
   IF cl_null(l_apde_minus.apde109)THEN LET l_apde_minus.apde109 = 0 END IF
   IF cl_null(l_apde_minus.apde119)THEN LET l_apde_minus.apde119 = 0 END IF
   IF cl_null(l_apde_minus.apde129)THEN LET l_apde_minus.apde129 = 0 END IF
   IF cl_null(l_apde_minus.apde139)THEN LET l_apde_minus.apde139 = 0 END IF

   LET g_apda_m.sum_apde1093 = l_apde_plus.apde109 - l_apde_minus.apde109
   LET g_apda_m.sum_apde1193 = l_apde_plus.apde119 - l_apde_minus.apde119
   LET g_apda_m.sum_apde1293 = l_apde_plus.apde129 - l_apde_minus.apde129
   LET g_apda_m.sum_apde1393 = l_apde_plus.apde139 - l_apde_minus.apde139

   ###合計金額###
   LET g_apda_m.sum_apde1094 = g_apda_m.sum_apde1091 - g_apda_m.sum_apde1092 + g_apda_m.sum_apde1093 
   LET g_apda_m.sum_apde1194 = g_apda_m.sum_apde1191 - g_apda_m.sum_apde1192 + g_apda_m.sum_apde1193
   LET g_apda_m.sum_apde1294 = g_apda_m.sum_apde1291 - g_apda_m.sum_apde1292 + g_apda_m.sum_apde1293
   LET g_apda_m.sum_apde1394 = g_apda_m.sum_apde1391 - g_apda_m.sum_apde1392 + g_apda_m.sum_apde1393
   
   #借方合計
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
     INTO  l_apde109_d,l_apde119_d,l_apde129_d,l_apde139_d   
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald
      AND apde015 = 'D' 
   IF cl_null(l_apde109_d)THEN LET l_apde109_d = 0 END IF
   IF cl_null(l_apde119_d)THEN LET l_apde119_d = 0 END IF
   IF cl_null(l_apde129_d)THEN LET l_apde129_d = 0 END IF
   IF cl_null(l_apde139_d)THEN LET l_apde139_d = 0 END IF
   
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
     INTO  l_apce109_d,l_apce119_d,l_apce129_d,l_apce139_d   
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      AND apceld = g_apda_m.apdald
      AND apce015 = 'D' 
   IF cl_null(l_apce109_d)THEN LET l_apce109_d = 0 END IF
   IF cl_null(l_apce119_d)THEN LET l_apce119_d = 0 END IF
   IF cl_null(l_apce129_d)THEN LET l_apce129_d = 0 END IF
   IF cl_null(l_apce139_d)THEN LET l_apce139_d = 0 END IF   
   
   #貸方合計
   SELECT SUM(apde109),SUM(apde119),SUM(apde129),SUM(apde139)
     INTO  l_apde109_c,l_apde119_c,l_apde129_c,l_apde139_c   
     FROM apde_t
    WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      AND apdeld = g_apda_m.apdald
      AND apde015 = 'C' 
   IF cl_null(l_apde109_c)THEN LET l_apde109_c = 0 END IF
   IF cl_null(l_apde119_c)THEN LET l_apde119_c = 0 END IF
   IF cl_null(l_apde129_c)THEN LET l_apde129_c = 0 END IF
   IF cl_null(l_apde139_c)THEN LET l_apde139_c = 0 END IF
   
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
     INTO  l_apce109_c,l_apce119_c,l_apce129_c,l_apce139_c   
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      AND apceld = g_apda_m.apdald
      AND apce015 = 'C' 
   IF cl_null(l_apce109_c)THEN LET l_apce109_c = 0 END IF
   IF cl_null(l_apce119_c)THEN LET l_apce119_c = 0 END IF
   IF cl_null(l_apce129_c)THEN LET l_apce129_c = 0 END IF
   IF cl_null(l_apce139_c)THEN LET l_apce139_c = 0 END IF  
   
   #借方合計   
   LET g_amt1_d = l_apde109_d + l_apce109_d      #原幣
   LET g_amt2_d = l_apde119_d + l_apce119_d      #本幣

   #貸方合計                                     
   LET g_amt3_c = l_apde109_c + l_apce109_c      #原幣
   LET g_amt4_c = l_apde119_c + l_apce119_c      #本幣
   
   #差異
   LET g_amt5_diff = g_amt1_d - g_amt3_c         #原币
   LET g_amt6_diff = g_amt2_d - g_amt4_c         #本币
   
   #本位幣二
   #借方
   LET g_amt1_d_1 = l_apde129_d + l_apce129_d
   #貸方
   LET g_amt3_c_1 = l_apde129_c + l_apce129_c
   #差異
   LET g_amt5_diff_1 = g_amt1_d_1 - g_amt3_c_1
   
   #本位幣三
   #借方
   LET g_amt2_d_1 = l_apde139_d + l_apce139_d
   #貸方
   LET g_amt4_c_1 = l_apde139_c + l_apce139_c
   #差異
   LET g_amt6_diff_1 = g_amt2_d_1 - g_amt4_c_1
   
   
   DISPLAY g_amt1_d,  g_amt3_c,  g_amt5_diff   TO amt1_d,  amt3_c,  amt5_diff
   DISPLAY g_amt2_d,  g_amt4_c,  g_amt6_diff   TO amt2_d,  amt4_c,  amt6_diff
   DISPLAY g_amt1_d_1,g_amt3_c_1,g_amt5_diff_1 TO amt1_d_1,amt3_c_1,amt5_diff_1
   DISPLAY g_amt2_d_1,g_amt4_c_1,g_amt6_diff_1 TO amt2_d_1,amt4_c_1,amt6_diff_1 
   
   DISPLAY BY NAME g_apda_m.sum_apde1094,g_apda_m.sum_apde1091,g_apda_m.sum_apde1092,g_apda_m.sum_apde1093,
                   g_apda_m.sum_apde1194,g_apda_m.sum_apde1191,g_apda_m.sum_apde1192,g_apda_m.sum_apde1193,
                   g_apda_m.sum_apde1294,g_apda_m.sum_apde1291,g_apda_m.sum_apde1292,g_apda_m.sum_apde1293,
                   g_apda_m.sum_apde1394,g_apda_m.sum_apde1391,g_apda_m.sum_apde1392,g_apda_m.sum_apde1393


                  
END FUNCTION

PRIVATE FUNCTION aapt823_set_no_required()
   CALL cl_set_comp_required("apde008,apde011,apde012,apde013,apde014,apde021,apde024,apde032,apde039,apde040",FALSE)
   CALL cl_set_comp_required("apde003,apde024",FALSE)
   CALL cl_set_comp_required("lc_apde008",FALSE)    #160122-00001#5 add
END FUNCTION

PRIVATE FUNCTION aapt823_set_required()
DEFINE l_ooia011     LIKE ooia_t.ooia011
   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apce2_d[l_ac].apde002
		   WHEN '10'
		      CALL cl_set_comp_required("apde032",TRUE)	 
		      IF g_sfin3008 = 'Y' THEN
               IF (g_apce2_d[l_ac].apde006 = '10' OR g_apce2_d[l_ac].apde006 = '20' OR g_apce2_d[l_ac].apde006 = '30') THEN
                  CALL cl_set_comp_required("apde008,apde011,apde012",TRUE)
                  CALL cl_set_comp_required("lc_apde008",TRUE)  #160122-00001#5                  
               END IF
               IF g_apce2_d[l_ac].apde006 = '30' THEN
                  SELECT ooia011 INTO l_ooia011
                   FROM ooia_t WHERE ooia001 = g_apce2_d[l_ac].apde021
                                 AND ooiaent = g_enterprise #170123-00010#1 add
                  #即期票據否                
                  IF l_ooia011 = 'Y' THEN
#                     CALL cl_set_comp_required("apde039,apde040,apde024",TRUE)	
                     CALL cl_set_comp_required("apde024",TRUE)
                  ELSE
                     CALL cl_set_comp_required("apde014",TRUE)
                  END IF                  
               END IF
#               IF g_apce2_d[l_ac].apde006 = '20' THEN
#                  CALL cl_set_comp_required("apde039,apde040",TRUE)	          
#               END IF                    
            END IF
            #151105--s
            IF g_apce2_d[l_ac].apde006 = '10' THEN
               CALL cl_set_comp_required("apde008,apde011,apde012",TRUE)
               CALL cl_set_comp_required("lc_apde008",TRUE)  #160122-00001#5               
            END IF            
            #151105--e
            IF g_apce2_d[l_ac].apde006 = '30' THEN
               CALL cl_set_comp_required("apde021",TRUE)	          
            END IF   
         WHEN '20'            
            CALL cl_set_comp_required("apde013,apde014",TRUE)	  
         WHEN '21'
            CALL cl_set_comp_required("apde013,apde014",TRUE)	  
         WHEN '22'
            CALL cl_set_comp_required("apde013,apde014",TRUE)	  
         WHEN '16'
            CALL cl_set_comp_required("apde003,apde024",TRUE)	  
      END CASE
   END IF 
   CALL cl_set_comp_visible("apde008",FALSE)  #160122-00001#5 add 
END FUNCTION
################################################################################
# Descriptions...: 做差異處理
# Memo...........:
# Usage..........: CALL aapt823_open_aapt823_09()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/10/13 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_open_aapt823_09()
   DEFINE r_redo_body   LIKE type_t.num5
   DEFINE r_continue    LIKE type_t.chr1
   
   LET r_redo_body = FALSE
   CALL s_transaction_begin()
   OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aapt823_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aapt823_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   CALL aapt420_09(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING r_redo_body,r_continue
   CALL s_transaction_end('Y','0')
   RETURN r_redo_body,r_continue
END FUNCTION

PRIVATE FUNCTION aapt823_gen_detail()
DEFINE ls_js         STRING
DEFINE lc_param      RECORD
          apdald     LIKE apda_t.apdald,
          apdadocno  LIKE apda_t.apdadocno,          
          apdadocdt  LIKE apda_t.apdadocdt,     
          apdacomp   LIKE apda_t.apdacomp,
          apdasite   LIKE apda_t.apdasite,           
          apebdocno  LIKE apeb_t.apebdocno,
          sfin2002   LIKE type_t.chr1,
          glaa015    LIKE glaa_t.glaa015,
          glaa016    LIKE glaa_t.glaa016,
          glaa019    LIKE glaa_t.glaa019,
          glaa020    LIKE glaa_t.glaa020          
                 END RECORD
                 
   CALL s_transaction_begin()
   CALL cl_err_collect_init()              
   OPEN aapt823_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aapt823_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CLOSE aapt823_cl
      CALL cl_err_collect_show() 
      CALL s_transaction_end('N','0')
      RETURN
   ELSE   
      LET lc_param.apdald    = g_apda_m.apdald
      LET lc_param.apdadocno = g_apda_m.apdadocno
      LET lc_param.apdadocdt = g_apda_m.apdadocdt
      LET lc_param.apdacomp  = g_apda_m.apdacomp
      LET lc_param.apdasite  = g_apda_m.apdasite
      LET lc_param.apebdocno = g_apda_m.apda023
      LET lc_param.sfin2002  = g_sfin2002
      LET lc_param.glaa015   = g_glaa.glaa015
      LET lc_param.glaa016   = g_glaa.glaa016
      LET lc_param.glaa019   = g_glaa.glaa019
      LET lc_param.glaa020   = g_glaa.glaa020
      LET ls_js = util.JSON.stringify(lc_param)
      
      #寫入帳款單身
      CALL s_aapt823_ins_payable_detail(ls_js) RETURNING g_sub_success   
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show() 
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL cl_err_collect_show()    
         CALL s_transaction_end('Y','0')
      END IF  
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 取得帳務中心下帳套範圍
# Memo...........:
# Usage..........: CALL aapt823_get_ld_wc(p_site)
#                  RETURNING r_wc
# Input parameter: p_site         營運據點
# Return code....: r_ld_wc           範圍帳套字串
#                : r_site_wc         範圍組織字串
# Date & Author..: 14/10/21 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_get_ld_wc(p_site)
   DEFINE p_site     LIKE apda_t.apdasite
   DEFINE r_ld_wc    STRING
   DEFINE r_site_wc  STRING

   #取得帳務組織下所屬成員範圍
   CALL s_fin_account_center_sons_query('3',p_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_ld_str() RETURNING r_ld_wc
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_str() RETURNING r_site_wc
  #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(r_ld_wc) RETURNING r_ld_wc   
   CALL s_fin_get_wc_str(r_site_wc) RETURNING r_site_wc   

   RETURN r_ld_wc,r_site_wc
END FUNCTION

################################################################################
# Descriptions...: 檢核已付款單號(10:付款情形)
# Memo...........:
# Usage..........: CALL aapt823_apde003_chk(p_site,p_docno,p_nmck023)
#                  RETURNING r_success,r_errno
# Input parameter: p_site     資金中心
#                : p_docno    單號
#                : p_nmck023      款別分類
# Return code....: r_success      
#                : r_errno        
# Date & Author..: 14/11/05 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_apde003_chk(p_site,p_docno,p_nmck023)
DEFINE p_site         LIKE nmck_t.nmcksite
DEFINE p_docno        LIKE nmck_t.nmckdocno
DEFINE p_nmck023      LIKE nmck_t.nmck023
DEFINE r_success      LIKE type_t.num5
DEFINE r_errno        LIKE gzze_t.gzze001
DEFINE l_nmckstus     LIKE nmck_t.nmckstus  #狀態
DEFINE l_nmck026      LIKE nmck_t.nmck026   #票況
DEFINE l_nmck025      LIKE nmck_t.nmck025   #票據號碼
DEFINE l_nmck023      LIKE nmck_t.nmck023   #款別
DEFINE l_nmck001      LIKE nmck_t.nmck001   #來源類型
DEFINE l_nmck005      LIKE nmck_t.nmck005   #付款對象
DEFINE l_nmck043      LIKE nmck_t.nmck043   #暫付否
DEFINE l_cnt          LIKE type_t.num5

   LET r_errno = ''
   LET r_success = TRUE
   
   SELECT nmckstus,nmck026,nmck025,nmck023,nmck001,nmck005,nmck043
     INTO l_nmckstus,l_nmck026,l_nmck025,l_nmck023,l_nmck001,l_nmck005,l_nmck043
     FROM nmck_t
    WHERE nmckent = g_enterprise
     #AND nmcksite = p_site   #160420-00001#11 mark
      AND nmckcomp = p_site   #160420-00001#11
      AND nmckdocno = p_docno
      
   CASE
      #是否存在
      WHEN SQLCA.SQLCODE = 100
         IF p_nmck023 = '30' THEN
            LET r_errno = 'anm-00204'
         ELSE
            LET r_errno = 'anm-00202'
         END IF
         LET r_success = FALSE
      #是否為確認
      WHEN l_nmckstus <> 'Y'
         IF p_nmck023 = '30' THEN
            LET r_errno = 'anm-00205'
         ELSE
            LET r_errno = 'anm-00203'
         END IF
         LET r_success = FALSE      
      #151102--s
      WHEN l_nmck023 <> p_nmck023
          LET r_errno = 'aap-00402'
         LET r_success = FALSE      
      #151102--e
      #來源須為其他
      WHEN l_nmck001 <> 'XX'
         LET r_errno = 'aap-00246'
         LET r_success = FALSE         

      #---------------------------匯款情形條件---------------------------#         
      #支付狀況須為付訖
      WHEN l_nmck026 <> '11' AND (p_nmck023 = '10' OR p_nmck023 = '20')
         LET r_errno = 'aap-00244'
         LET r_success = FALSE      
      #須為暫付
      WHEN l_nmck043 <> 'Y' AND (p_nmck023 = '10' OR p_nmck023 = '20')
         LET r_errno = 'aap-00250'
         LET r_success = FALSE                  
      #---------------------------票據情形條件---------------------------#      
      #票據號碼不可為空
      WHEN cl_null(l_nmck025) AND (p_nmck023 = '30')
         LET r_errno = 'aap-00254'
         LET r_success = FALSE        
   END CASE    

   #同一張沖銷單中,一張付款單/應收票據只可使用一次
   SELECT COUNT(*) INTO l_cnt FROM apde_t
    WHERE apdeent = g_enterprise 
      AND apdeld = g_apda_m.apdald
      AND apdedocno = g_apda_m.apdadocno
      AND apde003 = p_docno
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      LET r_errno = 'aap-00247'
      LET r_success = FALSE    
   END IF
   
 
   RETURN r_success,r_errno 
   
END FUNCTION

################################################################################
# Descriptions...: 檢核已付款單號(16:收票轉付情形)
# Memo...........:
# Usage..........: CALL aapt823_apde003_chk_16(p_nmbbcomp,p_nmbbdocno,p_nmbb030)
#                  RETURNING r_success,r_errno
# Input parameter: p_nmbbcomp     法人
#                : p_nmbbdocno    收支單號
#                : p_nmbb030      票據號碼
# Return code....: r_success      
#                : r_errno        
# Date & Author..: 14/12/06 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_apde003_chk_16(p_nmbbcomp,p_nmbbdocno,p_nmbb030)
DEFINE p_nmbbcomp     LIKE nmbb_t.nmbbcomp    #法人
DEFINE p_nmbbdocno    LIKE nmbb_t.nmbbdocno   #收支單號
DEFINE p_nmbb030      LIKE nmbb_t.nmbb030     #票據號碼

DEFINE r_success      LIKE type_t.num5
DEFINE r_errno        LIKE gzze_t.gzze001
DEFINE l_nmbastus     LIKE nmba_t.nmbastus  #狀態
DEFINE l_nmbb029      LIKE nmbb_t.nmbb029   #款別
DEFINE l_nmbb042      LIKE nmbb_t.nmbb042   #票況
DEFINE l_cnt          LIKE type_t.num5

   LET r_errno = ''
   LET r_success = TRUE

   IF cl_null(p_nmbbdocno) OR cl_null(p_nmbb030) THEN
      RETURN r_success,r_errno
   END IF
   SELECT nmbastus,nmbb029,nmbb042 INTO l_nmbastus,l_nmbb029,l_nmbb042
     FROM nmba_t,nmbb_t
    WHERE nmbbent  = g_enterprise
      AND nmbbcomp = p_nmbbcomp
      AND nmbbdocno= p_nmbbdocno
      AND nmbb030  = p_nmbb030
      AND nmbbent  = nmbaent
      AND nmbbcomp = nmbacomp
      AND nmbbdocno= nmbadocno
      
   CASE
      #是否存在
      WHEN SQLCA.SQLCODE = 100
         #LET r_errno = 'anm-00169' #160318-00005#2 mark
         LET r_errno = 'sub-01310'  #160318-00005#2 add
         LET r_success = FALSE
      #是否為確認
     #WHEN l_nmbastus <> 'Y'               #160419-00040#1 mark
     #WHEN l_nmbastus NOT MATCHES '[YV]'   #160419-00040#1 #161026-00010#2 mark
     WHEN l_nmbastus <> 'V'                #161026-00010#2 add
         #LET r_errno = 'anm-00170' #160318-00005#2 mark
         LET r_errno = 'sub-01312'  #160318-00005#2 add
         LET r_success = FALSE      
      #非票據類型
      WHEN l_nmbb029 <> '30' OR cl_null(l_nmbb029)
         LET r_errno = 'agl-00256'
         LET r_success = FALSE         
      #票況不為1:應收票據收票         
      WHEN l_nmbb042 <> '1'
         LET r_errno = 'anm-00332'
         LET r_success = FALSE   

   END CASE    

   #一張應收票據只可沖銷一次
   SELECT COUNT(*) INTO l_cnt FROM apde_t
    WHERE apdeent = g_enterprise 
      AND apdeld = g_apda_m.apdald
      AND apde003 = p_nmbbdocno
      AND apde024 = p_nmbb030
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      LET r_errno = 'aap-00290'
      LET r_success = FALSE    
   END IF

   RETURN r_success,r_errno 

END FUNCTION

################################################################################
# Descriptions...: 帶回選取之付款單資訊
# Memo...........:
# Usage..........: CALL aapt823_nmck_carry(p_nmckcomp,p_nmckdocno)
# Input parameter: p_nmckcomp     法人
#                : p_nmckdocno    單號
# Date & Author..: 14/11/05 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_nmck_carry(p_nmckcomp,p_nmckdocno)
DEFINE p_nmckcomp   LIKE nmck_t.nmckcomp
DEFINE p_nmckdocno  LIKE nmck_t.nmckdocno
DEFINE l_nmck           RECORD
   nmckent           LIKE nmck_t.nmckent,
   nmckcomp          LIKE nmck_t.nmckcomp,
   nmckdocno         LIKE nmck_t.nmckdocno,
   nmckdocdt         LIKE nmck_t.nmckdocdt,
   nmcksite          LIKE nmck_t.nmcksite,
   nmck001           LIKE nmck_t.nmck001,
   nmck002           LIKE nmck_t.nmck002,
   nmck003           LIKE nmck_t.nmck003,
   nmck004           LIKE nmck_t.nmck004,
   nmck005           LIKE nmck_t.nmck005,
   nmck006           LIKE nmck_t.nmck006,
   nmck007           LIKE nmck_t.nmck007,
   nmck008           LIKE nmck_t.nmck008,
   nmck009           LIKE nmck_t.nmck009,
   nmck010           LIKE nmck_t.nmck010,
   nmck011           LIKE nmck_t.nmck011,
   nmck012           LIKE nmck_t.nmck012,
   nmck013           LIKE nmck_t.nmck013,
   nmck014           LIKE nmck_t.nmck014,
   nmck015           LIKE nmck_t.nmck015,
   nmck016           LIKE nmck_t.nmck016,
   nmck017           LIKE nmck_t.nmck017,
   nmck018           LIKE nmck_t.nmck018,
   nmck019           LIKE nmck_t.nmck019,
   nmck020           LIKE nmck_t.nmck020,
   nmck021           LIKE nmck_t.nmck021,
   nmck022           LIKE nmck_t.nmck022,
   nmck023           LIKE nmck_t.nmck023,
   nmck024           LIKE nmck_t.nmck024,
   nmck025           LIKE nmck_t.nmck025,
   nmck026           LIKE nmck_t.nmck026,
   nmck027           LIKE nmck_t.nmck027,
   nmck028           LIKE nmck_t.nmck028,
   nmck029           LIKE nmck_t.nmck029,
   nmck030           LIKE nmck_t.nmck030,
   nmck031           LIKE nmck_t.nmck031,
   nmck032           LIKE nmck_t.nmck032,
   nmck033           LIKE nmck_t.nmck033,
   nmck034           LIKE nmck_t.nmck034,
   nmck035           LIKE nmck_t.nmck035,
   nmck036           LIKE nmck_t.nmck036,
   nmck100           LIKE nmck_t.nmck100,
   nmck101           LIKE nmck_t.nmck101,
   nmck103           LIKE nmck_t.nmck103,
   nmck113           LIKE nmck_t.nmck113,
   nmck114           LIKE nmck_t.nmck114,
   nmck121           LIKE nmck_t.nmck121,
   nmck124           LIKE nmck_t.nmck124,
   nmck123           LIKE nmck_t.nmck123,
   nmck131           LIKE nmck_t.nmck131,
   nmck133           LIKE nmck_t.nmck133,
   nmck134           LIKE nmck_t.nmck134,
   nmckstus          LIKE nmck_t.nmckstus,
   nmckownid         LIKE nmck_t.nmckownid,
   nmckowndp         LIKE nmck_t.nmckowndp,
   nmckcrtid         LIKE nmck_t.nmckcrtid,
   nmckcrtdp         LIKE nmck_t.nmckcrtdp,
   nmckcrtdt         LIKE nmck_t.nmckcrtdt,
   nmckmodid         LIKE nmck_t.nmckmodid,
   nmckmoddt         LIKE nmck_t.nmckmoddt,
   nmckcnfid         LIKE nmck_t.nmckcnfid,
   nmckcnfdt         LIKE nmck_t.nmckcnfdt 
                        END RECORD

   SELECT nmckent, nmckcomp, nmckdocno, nmckdocdt, nmcksite,
          nmck001, nmck002,  nmck003,   nmck004,   nmck005, 
          nmck006, nmck007,  nmck008,   nmck009,   nmck010, 
          nmck011, nmck012,  nmck013,   nmck014,   nmck015,
          nmck016, nmck017,  nmck018,   nmck019,   nmck020, 
          nmck021, nmck022,  nmck023,   nmck024,   nmck025, 
          nmck026, nmck027,  nmck028,   nmck029,   nmck030, 
          nmck031, nmck032,  nmck033,   nmck034,   nmck035, 
          nmck036, nmck100,  nmck101,   nmck103,   nmck113, 
          nmck114, nmck121,  nmck124,   nmck123,   nmck131, 
          nmck133, nmck134,  nmckstus,  nmckownid, nmckowndp, 
          nmckcrtid,nmckcrtdp,nmckcrtdt,nmckmodid, nmckmoddt,
          nmckcnfid,nmckcnfdt INTO l_nmck.*
     FROM nmck_t
    WHERE nmckent = g_enterprise
      AND nmckcomp = p_nmckcomp
      AND nmckdocno = p_nmckdocno

   LET g_apce2_d[l_ac].apde008 = l_nmck.nmck004
   LET g_apce2_d[l_ac].apde009 = 'Y'	
   LET g_apce2_d[l_ac].apde011 = l_nmck.nmck009
   LET g_apce2_d[l_ac].apde012 = l_nmck.nmck010   
   LET g_apce5_d[l_ac].apde017 = l_nmck.nmck003	
   
   LET g_apce2_d[l_ac].apde021 = l_nmck.nmck002	
   LET g_apce2_d[l_ac].apde024 = l_nmck.nmck025	
   LET g_apce2_d[l_ac].apde032 = l_nmck.nmck012	
   LET g_apce5_d[l_ac].apde038 = l_nmck.nmck005	
   LET g_apce2_d[l_ac].apde039 = l_nmck.nmck013	
   
   LET g_apce2_d[l_ac].apde040 = l_nmck.nmck014	
   LET g_apce2_d[l_ac].apde100 = l_nmck.nmck100	
   LET g_apce2_d[l_ac].apde101 = l_nmck.nmck101	
   

   LET g_apce6_d[l_ac].apde120 = g_glaa.glaa016
   LET g_apce6_d[l_ac].apde121 = l_nmck.nmck121	

   LET g_apce6_d[l_ac].apde130 = g_glaa.glaa020
   LET g_apce6_d[l_ac].apde131 = l_nmck.nmck131	

   #取得已付款單剩餘可沖金額
   CALL s_aapt420_get_payed_amount(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdeseq,p_nmckcomp,g_apce2_d[l_ac].apde003)
    RETURNING g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119,g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde139
    
   #預帶沖銷科目
   IF g_apce2_d[l_ac].apde006 ='30' THEN
      LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
   ELSE
      LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde008)
   END IF 
   #帶相關欄位說明   
   LET g_apce5_d[l_ac].apde038_desc = s_desc_show1(g_apce5_d[l_ac].apde038,s_desc_get_trading_partner_abbr_desc(g_apce5_d[l_ac].apde038))
   LET g_apce5_d[l_ac].apde0162_desc = s_desc_show1(g_apce2_d[l_ac].apde016,s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016))
   LET g_apce2_d[l_ac].apde011_desc = s_desc_get_nmajl003_desc(g_apce2_d[l_ac].apde011)
   LET g_apce2_d[l_ac].apde012_desc = s_desc_get_nmail004_desc(g_glaa.glaa005,g_apce2_d[l_ac].apde012) 
   LET g_apce2_d[l_ac].apde016_desc =s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
   DISPLAY BY NAME g_apce2_d[l_ac].apde011_desc,g_apce2_d[l_ac].apde012_desc,g_apce2_d[l_ac].apde016,g_apce2_d[l_ac].apde016_desc,g_apce5_d[l_ac].apde0162_desc,g_apce5_d[l_ac].apde038_desc  
   
   DISPLAY BY NAME g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde009,g_apce2_d[l_ac].apde011,g_apce2_d[l_ac].apde012,
                   g_apce5_d[l_ac].apde017,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde024,
                   g_apce2_d[l_ac].apde032,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,
                   g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde101,g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119,
                   g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129,g_apce6_d[l_ac].apde130,
                   g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139 

   #160122-00001#5 --add--str--
   #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
   CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
   DISPLAY BY NAME g_apce2_d[l_ac].lc_apde008
   #160122-00001#5 --add--end

END FUNCTION
################################################################################
# Descriptions...: 帶回選取之收款單資訊
# Memo...........:
# Usage..........: CALL aapt823_nmbb_carry(p_nmbbcomp,p_nmbbdocno,nmbb030)
# Input parameter: p_nmbbcomp     法人
#                : p_nmbbdocno    單號
#                : p_nmbb030      票據號碼
# Date & Author..: 14/11/05 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_nmbb_carry(p_nmbbcomp,p_nmbbdocno,p_nmbb030)
DEFINE  p_nmbbcomp   LIKE nmbb_t.nmbbcomp   #法人
DEFINE  p_nmbbdocno  LIKE nmbb_t.nmbbdocno  #單號
DEFINE  p_nmbb030    LIKE nmbb_t.nmbb030    #票據號碼
DEFINE  l_nmbb       RECORD
     nmbb043      LIKE nmbb_t.nmbb043,
     nmbb028      LIKE nmbb_t.nmbb028,
     nmbb031      LIKE nmbb_t.nmbb031,
     nmbb004      LIKE nmbb_t.nmbb004,
     nmbb056      LIKE nmbb_t.nmbb056,
     nmbb006      LIKE nmbb_t.nmbb006,
     nmbb058      LIKE nmbb_t.nmbb058,
     nmbb059      LIKE nmbb_t.nmbb059,
     nmbb060      LIKE nmbb_t.nmbb060,
     nmbb061      LIKE nmbb_t.nmbb061,
     nmbb062      LIKE nmbb_t.nmbb062        
    ,nmbb026      LIKE nmbb_t.nmbb026     #160325-00026#1 add     
                     END RECORD

   IF cl_null(p_nmbbdocno) OR cl_null(p_nmbb030) THEN
      RETURN
   END IF
   
	LET g_apce2_d[l_ac].apde008 = ''	LET g_apce2_d[l_ac].apde009 =	''	LET g_apce5_d[l_ac].apde017 =	''
	LET g_apce2_d[l_ac].apde021 =	''	LET g_apce2_d[l_ac].apde032 =	''	LET g_apce5_d[l_ac].apde038 =	''
	LET g_apce2_d[l_ac].apde039 =	''	LET g_apce2_d[l_ac].apde040 =	''	LET g_apce2_d[l_ac].apde100 =	''
	LET g_apce2_d[l_ac].apde101 =	''	LET g_apce2_d[l_ac].apde109 =	''	LET g_apce2_d[l_ac].apde119 =	''
	LET g_apce6_d[l_ac].apde120 = ''	LET g_apce6_d[l_ac].apde121 =	''	LET g_apce6_d[l_ac].apde129 =	''	
	LET g_apce6_d[l_ac].apde130 = ''	LET g_apce6_d[l_ac].apde131 = ''	LET g_apce6_d[l_ac].apde139 = ''
	LET g_apce2_d[l_ac].apde016 = '' LET g_apce2_d[l_ac].apde016_desc = ''
	LET g_apce5_d[l_ac].apde0162_desc = '' LET g_apce5_d[l_ac].apde038_desc = ''
   LET g_apce2_d[l_ac].apde041 =	''       #160202-00021#2
   SELECT nmbb043,nmbb028,nmbb031,nmbb004,nmbb056,
          nmbb006,nmbb058,nmbb059,nmbb060,nmbb061,
         #nmbb062 INTO l_nmbb.*          #160325-00026#1 mark
          nmbb062,nmbb026 INTO l_nmbb.*  #160325-00026#1 add 
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = p_nmbbcomp
      AND nmbbdocno = p_nmbbdocno
      AND nmbb030 = p_nmbb030
   
	LET g_apce2_d[l_ac].apde008	= l_nmbb.nmbb043	  #交易帳戶編碼
	LET g_apce2_d[l_ac].apde009	=	'Y'	           #已轉資料
	LET g_apce5_d[l_ac].apde017	=	g_user	        #帳務人員
	LET g_apce2_d[l_ac].apde021	=	l_nmbb.nmbb028	  #票據類型
	LET g_apce2_d[l_ac].apde032	=	l_nmbb.nmbb031	  #付款日
	
  #LET g_apce5_d[l_ac].apde038	=	g_apda_m.apda005 #付款對象  #160325-00026#1 mark
   LET g_apce5_d[l_ac].apde038	=	l_nmbb.nmbb026   #付款對象  #160325-00026#1 add
	LET g_apce2_d[l_ac].apde039	=	l_nmbb.nmbb043	  #付款銀行
	LET g_apce2_d[l_ac].apde040	=	''	
	LET g_apce2_d[l_ac].apde100	=	l_nmbb.nmbb004	  #幣別
	LET g_apce2_d[l_ac].apde101	=	l_nmbb.nmbb056	  #匯率
	
	LET g_apce2_d[l_ac].apde109	=	l_nmbb.nmbb006	  #原幣沖帳金額
	LET g_apce2_d[l_ac].apde119	=	l_nmbb.nmbb058	  #本幣沖帳金額	
	LET g_apce6_d[l_ac].apde120   =  g_glaa.glaa016	     #本位幣二幣別
	LET g_apce6_d[l_ac].apde121	=	l_nmbb.nmbb059	  #本位幣二匯率
	LET g_apce6_d[l_ac].apde129   =	l_nmbb.nmbb060	  #本位幣二沖帳金額
	
	LET g_apce6_d[l_ac].apde130   =  g_glaa.glaa020        #本位幣三幣別	
	LET g_apce6_d[l_ac].apde131   =	l_nmbb.nmbb061	  #本位幣三匯率	
	LET g_apce6_d[l_ac].apde139	=	l_nmbb.nmbb062	  #本位幣三沖帳金額
	LET g_apce2_d[l_ac].apde016 = s_aapt420_bring_acc_code2(g_apda_m.apdald,g_apce2_d[l_ac].apdesite,g_apce5_d[l_ac].apde038,g_apce2_d[l_ac].apde002,g_apce2_d[l_ac].apde006,g_apce2_d[l_ac].apde021)
	#帶相關欄位說明   
	LET g_apce2_d[l_ac].apde016_desc = s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016)
   LET g_apce5_d[l_ac].apde0162_desc = s_desc_show1(g_apce2_d[l_ac].apde016,s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apde016))
   LET g_apce5_d[l_ac].apde038_desc = s_desc_show1(g_apce5_d[l_ac].apde038,s_desc_get_trading_partner_abbr_desc(g_apce5_d[l_ac].apde038))
   DISPLAY BY NAME g_apce2_d[l_ac].apde008,g_apce2_d[l_ac].apde009,g_apce5_d[l_ac].apde017,g_apce2_d[l_ac].apde021,g_apce2_d[l_ac].apde032,
                   g_apce5_d[l_ac].apde038,g_apce5_d[l_ac].apde038_desc,g_apce2_d[l_ac].apde039,g_apce2_d[l_ac].apde040,g_apce2_d[l_ac].apde100,g_apce2_d[l_ac].apde101,
                   g_apce2_d[l_ac].apde109,g_apce2_d[l_ac].apde119,g_apce6_d[l_ac].apde120,g_apce6_d[l_ac].apde121,g_apce6_d[l_ac].apde129,
                   g_apce6_d[l_ac].apde130,g_apce6_d[l_ac].apde131,g_apce6_d[l_ac].apde139,g_apce2_d[l_ac].apde016,g_apce5_d[l_ac].apde0162_desc,g_apce2_d[l_ac].apde016_desc,
                   g_apce2_d[l_ac].apde041   #160202-00021#2
   #160122-00001#5 --add--str--
   #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
   CALL aapt823_get_lc_apde008(g_apce2_d[l_ac].apde008) RETURNING g_apce2_d[l_ac].lc_apde008
   DISPLAY BY NAME g_apce2_d[l_ac].lc_apde008
   #160122-00001#5 --add--end                
END FUNCTION

################################################################################
# Descriptions...: 將收票轉付帶回資料給到單身上
# Memo...........:
# Usage..........: CALL aapt823_bring_ar(p_wc)
#                  RETURNING r_apde008,r_apde100,r_apde109,r_apde100,r_apde119
# Date & Author..: 14/11/27 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_bring_ar(p_wc)
   DEFINE p_wc         STRING
   DEFINE r_apde008    LIKE apde_t.apde008
   DEFINE r_apde100    LIKE apde_t.apde100
   DEFINE r_apde101    LIKE apde_t.apde101
   DEFINE r_apde109    LIKE apde_t.apde109   
   DEFINE r_apde119    LIKE apde_t.apde119
   DEFINE l_sql        STRING
   DEFINE l_nmbb_t     RECORD
     nmbbdocno      LIKE nmbb_t.nmbbdocno,
     nmbbseq        LIKE nmbb_t.nmbbseq,
     nmbb004        LIKE nmbb_t.nmbb004,
     nmbb005        LIKE nmbb_t.nmbb005,
     nmbb006        LIKE nmbb_t.nmbb006,
     nmbb007        LIKE nmbb_t.nmbb007,
     nmbb008        LIKE nmbb_t.nmbb008,
     nmbb009        LIKE nmbb_t.nmbb009       
                       END RECORD   
   DEFINE l_xrde109    LIKE xrde_t.xrde109
   DEFINE l_xrde119    LIKE xrde_t.xrde119

   
   LET l_sql = "SELECT nmbbdocno,nmbbseq,nmbb004,nmbb005,nmbb006,",
               "       nmbb007,nmbb008,nmbb009 FROM nmbb_t WHERE ",g_qryparam.return1
   PREPARE aapt823_sel_nmbb_prep FROM l_sql
   DECLARE aapt823_sel_nmbb_curs CURSOR FOR aapt823_sel_nmbb_prep
   
   INITIALIZE l_nmbb_t.* TO NULL
      
   FOREACH aapt823_sel_nmbb_curs INTO l_nmbb_t.*
      #計算預沖金額
      LET l_xrde109 = 0   LET l_xrde119 = 0
      SELECT SUM(xrde109),SUM(xrde119) INTO l_xrde109,l_xrde119 FROM xrde_t,xrda_t
       WHERE xrdaent   = xrdeent
         AND xrdald    = xrdeld
         AND xrdadocno = xrdedocno
         AND xrde003   = l_nmbb_t.nmbbdocno
         AND xrde004   = l_nmbb_t.nmbbseq
         AND xrdastus  = 'N'
      IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
      IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      LET r_apde008  = l_nmbb_t.nmbbdocno
      LET r_apde100  = l_nmbb_t.nmbb004
      LET r_apde101  = l_nmbb_t.nmbb005

      LET r_apde109  = l_nmbb_t.nmbb006 - l_nmbb_t.nmbb008 - l_xrde109
      LET r_apde119  = l_nmbb_t.nmbb007 - l_nmbb_t.nmbb009 - l_xrde119
   END FOREACH
   RETURN r_apde008,r_apde100,r_apde101,r_apde109,r_apde119
END FUNCTION
################################################################################
# Descriptions...: 來源組織檢核
# Memo...........:
# Usage..........: CALL aapt823_apceorga_chk(p_ld,p_docno,p_apceorga,p_site_wc)
# Date & Author..: 15/01/02 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_apceorga_chk(p_ld,p_docno,p_apceorga,p_site_wc)
DEFINE p_ld          LIKE apda_t.apdald
DEFINE p_docno       LIKE apda_t.apdadocno
DEFINE p_apceorga    LIKE apce_t.apceorga
DEFINE p_site_wc     STRING
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE l_ld          LIKE apda_t.apdald
DEFINE l_comp_orga   LIKE apda_t.apdacomp
DEFINE l_comp_apda   LIKE apda_t.apdacomp

   LET r_success = TRUE
   LET r_errno = ''

   #檢查輸入組織代碼是否存在帳務中心下法人範圍內
   IF s_chr_get_index_of(p_site_wc,p_apceorga,1) = 0 THEN
      LET r_success = FALSE
      LET r_errno   ='aap-00127'
   END IF
   #檢查是否同一個法人
   SELECT apdacomp INTO l_comp_apda
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdald  = p_ld AND apdadocno = p_docno

   CALL s_fin_orga_get_comp_ld(p_apceorga) RETURNING g_sub_success,g_errno,l_comp_orga,l_ld
   IF l_comp_orga <> l_comp_apda THEN
      LET r_success = FALSE
      LET r_errno   = 'afa-00319'
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 單頭備註一次帶入單身
# Memo...........:
# Usage..........: CALL aapt823_copy_memo()
# Date & Author..: 15/02/06 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_copy_memo()
   #帳款單身
   UPDATE apce_t SET apce010 = g_apda_m.apda017
    WHERE apceent = g_enterprise
      AND apceld = g_apda_m.apdald
      AND apcedocno = g_apda_m.apdadocno
      AND apce010 IS NULL
   #付款單身
   UPDATE apde_t SET apde010 = g_apda_m.apda017
    WHERE apdeent = g_enterprise
      AND apdeld = g_apda_m.apdald
      AND apdedocno = g_apda_m.apdadocno
      AND apde010 IS NULL         
      
END FUNCTION

################################################################################
# Descriptions...: 依據傳入參數不同,執行單據串查
# Memo...........:
# Usage..........: aapt823_qrystr(,p_field)
# Date & Author..: 150527 By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_qrystr(p_field)
   DEFINE p_field       LIKE type_t.chr500     
   DEFINE l_type        LIKE apcb_t.apcb001 
   DEFINE l_apcasite    LIKE apca_t.apcasite
   DEFINE la_param      RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                        END RECORD
   DEFINE ls_js      STRING
   DEFINE l_sql      STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_j           LIKE type_t.num5   
        
   INITIALIZE la_param.* TO NULL
   CASE p_field 
      WHEN 'apda014'
         IF cl_null(g_apda_m.apda014) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'apda014')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         CALL s_aapt300_get_aglt3xx_prog(g_apda_m.apdald,g_apda_m.apda014)RETURNING la_param.prog
         LET la_param.param[1] = g_apda_m.apdald
         LET la_param.param[2] = g_apda_m.apda014
      
      WHEN 'apce003'
         IF cl_null(g_apce_d[g_detail_idx].apce003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'apce003')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         IF g_apce_d[g_detail_idx].apce002[1,1]='4' THEN
            CALL s_aapt300_get_aapt3xx_prog(g_apda_m.apdald,g_apce_d[g_detail_idx].apce003)RETURNING la_param.prog,l_i,l_j
            LET la_param.param[l_i] = g_apda_m.apdald
            LET la_param.param[l_j] = g_apce_d[g_detail_idx].apce003
         ELSE
            CALL s_aapt300_get_axrt3xx_prog(g_apda_m.apdald,g_apce_d[g_detail_idx].apce003)RETURNING la_param.prog
            LET la_param.param[1] = g_apda_m.apdald
            LET la_param.param[2] = g_apce_d[g_detail_idx].apce003
         END IF
      
      WHEN 'apce024'
         IF cl_null(g_apce_d[g_detail_idx].apce024) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'apce024')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         IF g_sfin2002 MATCHES '[12]' THEN
            SELECT UNIQUE apca016,apcasite INTO l_type,l_apcasite
            FROM apca_t
            WHERE apcadocno = g_apce_d[g_detail_idx].apce003
            AND apcbent = g_enterprise #170123-00010#1 add            
            AND apca018 = g_apce_d[g_detail_idx].apce024 
            AND apca016 IN ('11','20','21')
         ELSE
            SELECT UNIQUE apcb001,apcborga INTO l_type ,l_apcasite
            FROM apcb_t
            WHERE apcbdocno = g_apce_d[g_detail_idx].apce003 
            AND apcbent = g_enterprise #170123-00010#1 add
            AND apcb002 = g_apce_d[g_detail_idx].apce024 
            AND apcb001 IN ('11','20','21')
         END IF
         CALL s_aapt300_get_source_apm_prog(l_type,g_apce_d[g_detail_idx].apce024) RETURNING la_param.prog
         LET la_param.param[1] = g_apce_d[g_detail_idx].apce024
         LET la_param.param[3] = l_apcasite    
      
      WHEN 'apde003'
         ##160203-00009#1--MARK
         #IF cl_null(g_apce2_d[g_detail_idx].apde003) THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code   = 'sub-00280'
         #   LET g_errparam.extend = s_fin_get_colname(g_prog,'apde003')
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   RETURN
         #END IF
         ##160203-00009#1--MARK
         CASE
            #apde002='10'/apde006 = '30'  >>>>> anmt440  應付票據
            WHEN g_apce2_d[g_detail_idx].apde002 = 10 AND g_apce2_d[g_detail_idx].apde006 = 30
            	LET la_param.prog = 'anmt440'
            	LET la_param.param[1] = g_apda_m.apdacomp
               LET la_param.param[2] = g_apce2_d[g_detail_idx].apde003
               #160203-00009#1--(S)
               IF cl_null(g_apce2_d[g_detail_idx].apde003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apde003')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN
               END IF
               #160203-00009#1--(E)
            #apde002='10'/apde006 = '20'  >>>>> anmt460  應付匯款        #160203-00009#1--(S)
            WHEN g_apce2_d[g_detail_idx].apde002 = 10 AND g_apce2_d[g_detail_idx].apde006 = 20
               LET la_param.prog = 'anmt460'
            	LET la_param.param[1] = g_apda_m.apdacomp
               LET la_param.param[2] = g_apce2_d[g_detail_idx].apde003
               #160203-00009#1--(S)
               IF cl_null(g_apce2_d[g_detail_idx].apde003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apde003')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN
               END IF
               #160203-00009#1--(E)
            #apde006 = '10'  >>>>> anmq210  交易查詢(傳入帳戶/銀行日期)
            WHEN g_apce2_d[g_detail_idx].apde002 = 10 AND g_apce2_d[g_detail_idx].apde006 = 10
               LET la_param.prog = 'anmq210'
            	LET la_param.param[1] = g_apce2_d[g_detail_idx].apde008 

            	LET la_param.param[2] = g_apda_m.apdadocdt
               LET la_param.param[3] = '1'
               #160203-00009#1--(S)
               IF cl_null(g_apce2_d[g_detail_idx].apde008) THEN 

                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apde008') 

                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN
               END IF
               #160203-00009#1--(E)
            #apde002 = '16' 收票轉付  >>>>> anmt510  應收票              #160203-00009#1--(E)
            WHEN g_apce2_d[g_detail_idx].apde002 = 16  AND g_apce2_d[g_detail_idx].apde006 = 30
            	LET la_param.prog = 'anmt510'
            	LET la_param.param[1] = g_apda_m.apdacomp
               LET la_param.param[2] = g_apce2_d[g_detail_idx].apde003
               #160203-00009#1--(S)
               IF cl_null(g_apce2_d[g_detail_idx].apde003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apde003')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN
               END IF
               #160203-00009#1--(E)
            OTHERWISE
               LET la_param.prog = ''
         END CASE      
      
      WHEN 'apde014'
         IF cl_null(g_apce2_d[g_detail_idx].apde014) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'apde014')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         CASE g_apce2_d[g_detail_idx].apde002 
            WHEN g_apce2_d[g_detail_idx].apde002 = '20' OR g_apce2_d[g_detail_idx].apde002 ='22'
               CALL s_aapt300_get_aapt3xx_prog(g_apda_m.apdald,g_apce2_d[g_detail_idx].apde014)RETURNING la_param.prog,l_i,l_j
               LET la_param.param[l_i] = g_apda_m.apdald
               LET la_param.param[l_j] = g_apce2_d[g_detail_idx].apde014
            WHEN '21'
               CALL s_aapt300_get_axrt3xx_prog(g_apda_m.apdald,g_apce2_d[g_detail_idx].apde014)RETURNING la_param.prog
               LET la_param.param[1] = g_apda_m.apdald
               LET la_param.param[2] = g_apce2_d[g_detail_idx].apde014
         END CASE 
   END CASE
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js)   
END FUNCTION

################################################################################
# Descriptions...: 開窗勾選多筆寫入時,要留住事先維護的摘要
# Date & Author..: 151104 By 03538(#151104)
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_keep_memo(p_apce010)
DEFINE p_apce010  LIKE apce_t.apce010
DEFINE l_cnt      LIKE type_t.num5

   SELECT COUNT(apceseq) INTO l_cnt 
     FROM apce_t
    WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      AND apceld = g_apda_m.apdald
      AND apceseq = g_apce_d[l_ac].apceseq
   IF l_cnt > 0 THEN
      UPDATE apce_t SET apce010 = p_apce010
       WHERE apceent = g_enterprise
         AND apcedocno = g_apda_m.apdadocno
         AND apceld = g_apda_m.apdald
         AND apceseq = g_apce_d[l_ac].apceseq        
   END IF
END FUNCTION

################################################################################
# Descriptions...: 立即審核
# Memo...........:
# Usage..........: CALL aapt823_immediately_conf()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count,l_count2  LIKE type_t.num5
   DEFINE l_sfin3008        LIKE type_t.chr80             #S-FIN-3008-付款單直接產生銀存支付帳
   DEFINE l_sql            STRING
   DEFINE l_apde014        LIKE apde_t.apde014
   DEFINE l_apde002        LIKE apde_t.apde002
   IF cl_null(g_apda_m.apdald)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdasite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdadocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apce_t WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   
   LET l_count2 = 0
   SELECT COUNT(*) INTO l_count2 FROM apde_t WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      
   IF cl_null(l_count2) THEN LET l_count2 = 0 END IF
   IF l_count + l_count2 = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      

   IF NOT s_aapt823_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
      LET l_doc_success = FALSE
   END IF
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-3008') RETURNING l_sfin3008
   IF NOT s_aapt823_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno,l_sfin3008) THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_apda_m.apdamoddt = cl_get_current()
   LET g_apda_m.apdacnfdt = cl_get_current()
   UPDATE apda_t SET apdastus = 'Y',
                     apdamodid= g_user,
                     apdamoddt= g_apda_m.apdamoddt,
                     apdacnfid= g_user,
                     apdacnfdt= g_apda_m.apdacnfdt
    WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
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
      #151125-00006#2--s--
           LET l_sql = " SELECT DISTINCT apde002,apde014 FROM apde_t,apda_t ",
                       "  WHERE apdeld = apdald AND apdedocno = apdadocno AND apdeent = apdaent ",
                       "    AND apdaent = '",g_enterprise,"' ",
                       "    AND apdald = '",g_apda_m.apdald,"' ", 
                       "    AND apdadocno = '",g_apda_m.apdadocno,"' "   
           PREPARE s_aapt823_doc_gen_p2 FROM l_sql
           DECLARE s_aapt823_doc_gen_c2 CURSOR FOR s_aapt823_doc_gen_p2
   
           FOREACH s_aapt823_doc_gen_c2 INTO l_apde002,l_apde014             
           CASE 
              WHEN l_apde002 = '20'
                 CALL s_aapt420_contra_doc_immediately_gen(g_apda_m.apdald,l_apde014)
              WHEN l_apde002 = '21'
                 CALL s_aapt420_contra_doc2_immediately_gen(g_apda_m.apdald,l_apde014)
              WHEN l_apde002 = '22'  
                 CALL s_aapt420_contra_doc_immediately_gen(g_apda_m.apdald,l_apde014)
           END CASE
           END FOREACH
      #151125-00006#2--e--
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

################################################################################
# Descriptions...: 立即拋轉憑證
# Memo...........:
# Usage..........: CALL aapt823_immediately_gen()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_immediately_gen()
#151125-00006#2---s
   DEFINE l_cnt            LIKE type_t.num10
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_date            LIKE glap_t.glapdocdt
   DEFINE l_chr             LIKE type_t.chr1       #狀態碼
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE l_glaacomp  LIKE glaa_t.glaacomp
   DEFINE l_docno     LIKE xrem_t.xremdocno
   DEFINE l_start_no  LIKE glap_t.glapdocno
   DEFINE l_glaa102   LIKE glaa_t.glaa102
   DEFINE l_apdastus  LIKE apda_t.apdastus
   IF cl_null(g_apda_m.apdald)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdasite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdadocno) THEN RETURN END IF   #無資料直接返回不做處理
   SELECT apdastus INTO g_apda_m.apdastus 
     FROM apda_t
    WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
     IF g_apda_m.apdastus != 'Y' OR cl_null(g_apda_m.apdastus) THEN
        RETURN
      END IF
     IF NOT cl_null(g_apda_m.apda014)  THEN RETURN END IF #传票号码已经存在返回不做处理
     #傳票成立時,借貸不平衡的處理方式
     CALL s_ld_sel_glaa(g_apda_m.apdald,'glaacomp|glaa102')
          RETURNING g_sub_success,l_glaacomp,l_glaa102
     #取所屬法人關帳日
     CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
     
     
     
      
     #取得單別
     CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
     #取得單別設置的"是否直接抛转凭证"參數
     CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032
  
     IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
        RETURN 
     END IF 
     # D-FIN-0030 产生分录传票否
     CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0030') RETURNING l_chr
     IF l_chr <> 'Y' OR  cl_null(l_chr) THEN RETURN END IF 
     
     #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
     LET l_gl_slip = ''
     CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
     
     
     IF cl_null(l_gl_slip) THEN
        IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
        LET la_param.prog = 'aapp420'
        LET la_param.param[1] = g_apda_m.apdald      #帳套
        LET la_param.param[2] = g_apda_m.apdadocno   #單號   
        LET la_param.param[4] = g_apda_m.apdadocdt   #日期
        LET la_param.param[5] = g_apda_m.apdasite    #帳務中心
        LET ls_js = util.JSON.stringify( la_param )
        CALL cl_cmdrun_wait(ls_js)
     ELSE 
        IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
        CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
        CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
        CALL s_fin_continue_no_tmp()               
        CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
        
        CALL s_transaction_begin()
       
        DELETE FROM s_voucher_tmp
       
        INSERT INTO s_voucher_tmp (docno,type)
              VALUES (g_apda_m.apdadocno, '0' )
        SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
       
        SELECT count(*) INTO l_count
           FROM s_voucher_tmp
        IF l_count > 0 THEN
               CALL s_aapp330_gen_ac('1','P20',g_apda_m.apdald,'','','1','!#@',g_apda_m.apdastus) RETURNING g_sub_success,l_start_no,l_start_no
               IF g_sub_success THEN
                 CALL s_transaction_end('Y','Y')
              ELSE
                 CALL s_transaction_end('N','Y')
              END IF
             
              #傳票拋轉
              CALL s_transaction_begin()
              CALL cl_err_collect_init()
              CALL s_aapp330_generate_voucher('P20',l_gl_slip,g_apda_m.apdadocdt,g_apda_m.apdald,'1','Y',l_glaa102,'AP')
                   RETURNING g_sub_success,g_apda_m.apda014,g_apda_m.apda014
              
              #成功則更新aapt430的傳票號碼
              IF g_sub_success THEN
                 UPDATE apda_t SET apda014 = g_apda_m.apda014
                  WHERE apdaent = g_enterprise
                    AND apdadocno = g_apda_m.apdadocno
                    AND apdald = g_apda_m.apdald
                 CALL s_transaction_end('Y','Y')
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'adz-00217'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              ELSE
                 CALL s_transaction_end('N','Y')
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'adz-00218'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              END IF
              CALL cl_err_collect_show()
        END IF
       END IF
        #重新顯示傳票號碼
        SELECT apda014 INTO g_apda_m.apda014
          FROM apda_t
         WHERE apdaent = g_enterprise
           AND apdadocno = g_apda_m.apdadocno
           AND apdald = g_apda_m.apdald
        DISPLAY BY NAME g_apda_m.apda014
            
#151125-00006#2---e
END FUNCTION
################################################################################
# Descriptions...: 获取显示给用户看到的交易账户型态
# Memo...........: #160122-00001#5
# Usage..........: CALL aapt823_get_lc_apde008(p_apde008)
#                  RETURNING lc_apde008
# Input parameter: p_apde008      交易账户编号
# Return code....: lc_apde008     返回现在在画面中的交易账户编号
# Date & Author..: 2016/03/04 By 07673
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_get_lc_apde008(p_apde008)
   DEFINE p_apde008        LIKE apde_t.apde008
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_cnt2           LIKE type_t.num5
   DEFINE lc_apde008       LIKE apde_t.apde008  
   
   #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
   LET lc_apde008 = p_apde008
   IF NOT cl_null(p_apde008) THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM nmll_t 
       WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y'
         AND nmll001 = p_apde008
      SELECT COUNT(*) INTO l_cnt2 FROM nmlm_t 
       WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y'
         AND nmlm001 = p_apde008   
      IF l_cnt = 0 AND l_cnt2 = 0 THEN
         LET lc_apde008 = "********"
      END IF
   END IF
   RETURN lc_apde008
END FUNCTION
################################################################################
# Descriptions...: 取得年度期別
# Memo...........:
# Usage..........: CALL aapt823_get_yymm(p_apeb003)
# Date & Author..: 2016/07/01 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_get_yymm(p_apeb003)
DEFINE p_apeb003     LIKE apeb_t.apeb003
DEFINE l_apcadocdt   LIKE apca_t.apcadocdt
DEFINE l_yy          LIKE type_t.chr5
DEFINE l_mm          LIKE type_t.chr5
DEFINE r_yymm        LIKE type_t.chr10

   SELECT apcadocdt INTO l_apcadocdt
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcadocno = p_apeb003

   LET l_yy = YEAR(l_apcadocdt)
   LET l_mm = MONTH(l_apcadocdt)
   LET l_mm = l_mm USING "&&"
   LET r_yymm = l_yy,"/",l_mm

   RETURN r_yymm
END FUNCTION

################################################################################
# Descriptions...: 檢核輸入的請款單號
# Memo...........:
# Usage..........: aapt823_apda023_chk(p_apda023) RETURNING g_sub_success
# Input parameter: p_apda023
# Date & Author..: 160701 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt823_apda023_chk(p_apda023)
DEFINE p_apda023     LIKE apda_t.apda023
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE l_apeald      LIKE apea_t.apeald
DEFINE l_apeastus    LIKE apea_t.apeastus
DEFINE l_apeadocdt   LIKE apea_t.apeadocdt
   
   LET r_errno = ''
   LET r_success = TRUE
   
   SELECT apeald,apeastus,apeadocdt
     INTO l_apeald,l_apeastus,l_apeadocdt
     FROM apea_t
    WHERE apeaent = g_enterprise
      AND apeadocno = p_apda023
      
   CASE
      #是否存在
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = 'anm-00129'         
         LET r_success = FALSE      
      #帳套是否符合
      WHEN l_apeald <> g_apda_m.apdald
         LET r_errno = 'aap-00568'
         LET r_success = FALSE       
      #是否為確認
      WHEN l_apeastus <> 'Y'
         LET r_errno = 'sub-01302'
         LET r_success = FALSE   
      #日期不可大於單頭日期
      WHEN l_apeadocdt > g_apda_m.apdadocdt
         LET r_errno = 'ade-00011'
         LET r_success = FALSE       
   END CASE    
   RETURN r_success,r_errno 
END FUNCTION

 
{</section>}
 
