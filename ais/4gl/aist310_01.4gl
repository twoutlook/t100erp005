#該程式未解開Section, 採用最新樣板產出!
{<section id="aist310_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0029(2016-10-26 12:05:51), PR版次:0029(2017-02-23 10:08:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000418
#+ Filename...: aist310_01
#+ Description: 批次產生對帳資料
#+ Creator....: 02114(2015-01-13 16:29:32)
#+ Modifier...: 03080 -SD/PR- 04152
 
{</section>}
 
{<section id="aist310_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150603-00046#1  150603 By Reanna    修正開窗
#151207-00018#1  160112 By 01727     自動產生單身資料時,出貨單需要區分普通出貨單和出貨簽收單
#160413-00018#1  160425 By Hans      修正自動產生單身
#160426-00013#2  160602 By Reanna    增加訂金發票流程
#160623-00019#1  160628 By Reanna    1.出貨對帳時,自動產生段與直接維護時,發票數量計算應過濾以出貨對帳資料為主
#160223-00002#3  160725 By Reanna    增加流通門店銷售單&門店銷退單整批產生
#160517-00001#7  160808 By 01727     判斷訂單是否為100%訂金.如果是100%訂金則將訂單單身數量/金額照搬至對帳單/應收單
#160823-00016#1  160824 By Reanna    金額統計時，訂金沒開發票，不可以加進來(發票開在出貨單)
#160831-00059#1  160901 By Reanna    自動產生的開窗無法選取到可以用的銷退單
#161013-00041#1  161014 By 06821     批次產生單身對帳資料時,出貨單單據性質時,單據單號加串"出貨簽收單"性質
#161018-00001#1  161018 By Reanna    調整整批產生bug&藍字發票開放銷退單
#161006-00005#29 161018 By 08732     組織類型與職能開窗調整
#161005-00018#3  161020 By albireo   27類時金額需依xrca稅率計算未稅及稅額
#161026-00001#1  161026 By albireo   自動產生單身空白時,應開1 2 3 6類型的自動產生單身邏輯
#161024-00065#2  161028 By Reanna    依照aoos020的參數S-FIN-2023(流通門店銷售立帳方式)，選1.發票立帳，除抓資料來源=1:ERP外，
#                                    可多抓取4:日結的門店銷售單對帳，選2:店日結立帳只可抓資料來源=1:ERP
#161102-00003#1  161103 By Reanna    自動產生單身邏輯增加對帳來源條件
#161102-00039#1  161103 By Reanna    調整抓取訂金待抵單邏輯
#161104-00024#10 161108 By 08171     程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#6  161110 By 08171     程式中INSERT時不可以用*的寫法，要一個一個欄位定義
#161123-00012#1  161123 By Reanna    調整取得訂金發票的待抵單條件
#161130-00006#1  161130 By 08171     因應程式中不能有星號做內容調整,把有define 星號的地方展開
#161208-00026#19 161214 By 08732     SUB_程式中DEFINE / INSERT INTO 有星號整批調整(針對SELECT *的部份)
#161214-00053#1  161219 By Reanna    8.調整bug：整批產生訂金時，若訂金有兩筆以上只能產生第一筆，第二筆之後無法產生
#                                    9.整批產生的訂金單號開窗增加排除已立aist310的訂金
#161205-00025#16 161220 By albireo   效能調整
#161206-00042#2  161229 By albireo   來源對象增加考慮一次交易對象
#170112-00018#1  170112 By albireo   1.根據isac005  總額攤算時 應與aisp320同樣處置,且本幣=原幣時以攤算後本幣金額蓋掉原幣金額
#                                    2.客戶料號說明 應抓取
#170221-00030#1  170223 By Reanna    調整161206-00042#2一次性交易條件
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input              RECORD
          type                 LIKE type_t.chr1,       #160223-00002#3 add ,
          xmdk000              LIKE xmdk_t.xmdk000     #160223-00002#3
                            END RECORD
#DEFINE g_isaf               RECORD LIKE isaf_t.*      #161104-00024#10 mark
#161104-00024#10 --s add 
DEFINE g_isaf RECORD  #銷項發票主檔
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
       isaf022 LIKE isaf_t.isaf022, #購貨方稅務編號
       isaf023 LIKE isaf_t.isaf023, #購貨方地址
       isaf024 LIKE isaf_t.isaf024, #購貨方電話
       isaf025 LIKE isaf_t.isaf025, #購貨方開戶銀行
       isaf026 LIKE isaf_t.isaf026, #購貨方帳戶編碼
       isaf027 LIKE isaf_t.isaf027, #銷貨方名稱
       isaf028 LIKE isaf_t.isaf028, #銷方稅務編號
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
       isafud001 LIKE isaf_t.isafud001, #自定義欄位(文字)001
       isafud002 LIKE isaf_t.isafud002, #自定義欄位(文字)002
       isafud003 LIKE isaf_t.isafud003, #自定義欄位(文字)003
       isafud004 LIKE isaf_t.isafud004, #自定義欄位(文字)004
       isafud005 LIKE isaf_t.isafud005, #自定義欄位(文字)005
       isafud006 LIKE isaf_t.isafud006, #自定義欄位(文字)006
       isafud007 LIKE isaf_t.isafud007, #自定義欄位(文字)007
       isafud008 LIKE isaf_t.isafud008, #自定義欄位(文字)008
       isafud009 LIKE isaf_t.isafud009, #自定義欄位(文字)009
       isafud010 LIKE isaf_t.isafud010, #自定義欄位(文字)010
       isafud011 LIKE isaf_t.isafud011, #自定義欄位(數字)011
       isafud012 LIKE isaf_t.isafud012, #自定義欄位(數字)012
       isafud013 LIKE isaf_t.isafud013, #自定義欄位(數字)013
       isafud014 LIKE isaf_t.isafud014, #自定義欄位(數字)014
       isafud015 LIKE isaf_t.isafud015, #自定義欄位(數字)015
       isafud016 LIKE isaf_t.isafud016, #自定義欄位(數字)016
       isafud017 LIKE isaf_t.isafud017, #自定義欄位(數字)017
       isafud018 LIKE isaf_t.isafud018, #自定義欄位(數字)018
       isafud019 LIKE isaf_t.isafud019, #自定義欄位(數字)019
       isafud020 LIKE isaf_t.isafud020, #自定義欄位(數字)020
       isafud021 LIKE isaf_t.isafud021, #自定義欄位(日期時間)021
       isafud022 LIKE isaf_t.isafud022, #自定義欄位(日期時間)022
       isafud023 LIKE isaf_t.isafud023, #自定義欄位(日期時間)023
       isafud024 LIKE isaf_t.isafud024, #自定義欄位(日期時間)024
       isafud025 LIKE isaf_t.isafud025, #自定義欄位(日期時間)025
       isafud026 LIKE isaf_t.isafud026, #自定義欄位(日期時間)026
       isafud027 LIKE isaf_t.isafud027, #自定義欄位(日期時間)027
       isafud028 LIKE isaf_t.isafud028, #自定義欄位(日期時間)028
       isafud029 LIKE isaf_t.isafud029, #自定義欄位(日期時間)029
       isafud030 LIKE isaf_t.isafud030, #自定義欄位(日期時間)030
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
#161104-00024#10 --e add
DEFINE g_glaald             LIKE glaa_t.glaald
DEFINE g_para_data          LIKE type_t.chr80
#160223-00002#3-s
DEFINE g_origin_str         STRING                     #組織範圍
DEFINE g_sfin2023           LIKE type_t.chr10          #161024-00065#2
DEFINE g_pmaa004            LIKE pmaa_t.pmaa004        #170221-00030#1
#160223-00002#3-e
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="aist310_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aist310_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_docno,p_comp
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_docno         LIKE isaf_t.isafdocno
   DEFINE p_comp          LIKE isaf_t.isafcomp
   #DEFINE l_origin_str    STRING   #組織範圍 #160223-00002#3 mark
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aist310_01 WITH FORM cl_ap_formpath("ais","aist310_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   WHENEVER ERROR CONTINUE  #160823-00016#1
   
   #SELECT * INTO g_isaf.*   #161208-00026#19   mark
   #161208-00026#19   add---s
   SELECT isafent,isafsite,isafcomp,isafdocno,isafdocdt,
          isaf001,isaf002,isaf003,isaf004,isaf005,
          isaf006,isaf007,isaf008,isaf009,isaf010,
          isaf011,isaf012,isaf013,isaf014,isaf015,
          isaf016,isaf017,isaf018,isaf019,isaf020,
          isaf021,isaf022,isaf023,isaf024,isaf025,
          isaf026,isaf027,isaf028,isaf029,isaf030,
          isaf031,isaf032,isaf033,isaf034,isaf035,
          isaf036,isaf037,isaf038,isaf039,isaf040,
          isaf041,isaf042,isaf043,isaf044,isaf045,
          isaf046,isaf047,isaf048,isaf049,isaf050,
          isaf051,isaf052,isaf053,isaf054,isaf055,
          isaf056,isaf057,isaf058,isaf100,isaf101,
          isaf103,isaf104,isaf105,isaf106,isaf107,
          isaf108,isaf113,isaf114,isaf115,isaf116,
          isaf117,isaf118,isaf119,isaf120,isaf121,
          isaf122,isaf123,isaf124,isaf201,isaf202,
          isaf203,isaf204,isaf205,isaf206,isaf207,
          isaf208,isaf209,isaf210,isafstus,isafownid,
          isafowndp,isafcrtid,isafcrtdp,isafcrtdt,isafmodid,
          isafmoddt,isafcnfid,isafcnfdt,isafud001,isafud002,
          isafud003,isafud004,isafud005,isafud006,isafud007,
          isafud008,isafud009,isafud010,isafud011,isafud012,
          isafud013,isafud014,isafud015,isafud016,isafud017,
          isafud018,isafud019,isafud020,isafud021,isafud022,
          isafud023,isafud024,isafud025,isafud026,isafud027,
          isafud028,isafud029,isafud030,isaf059,isaf060,
          isaf061,isaf062,isaf063,isaf064,isaf065,
          isaf066,isaf067
     INTO g_isaf.*
   #161208-00026#19   add---e
     FROM isaf_t
    WHERE isafent = g_enterprise AND isafcomp = p_comp AND isafdocno = p_docno
   IF g_isaf.isaf056 = '2' THEN
      #CALL cl_set_combo_scc_part('xmdk000','2077','6')   #160223-00002#3 mark
      CALL cl_set_combo_scc_part('xmdk000','2077','6,11') #160223-00002#3
   ELSE
      #CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3')    #160223-00002#3 mark
      #CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3,10') #160223-00002#3 #161018-00001#1 mark
      CALL cl_set_combo_scc_part('xmdk000','2077','1,2,3,6,10,11')             #161018-00001#1
   END IF
   #160223-00002#3 -s
   IF g_isaf.isaf001 = '3' THEN
      CALL cl_set_combo_scc_part('xmdk000','2077','9') #160223-00002#3
   END IF
   #160223-00002#3 -e
   SELECT glaald INTO g_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_comp
      AND glaa014 = 'Y'
   CALL cl_get_para(g_enterprise,g_isaf.isafcomp,'S-FIN-2013') RETURNING g_para_data
   LET g_input.type = '1'
   CALL cl_set_comp_entry("xmdksite,xmdk000,xmdkdocno,xmdk006,xmdkdocdt,xmdk001,xmdk055",FALSE)
   LET g_errshow = 1
   #160223-00002#3-s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_sons_query('3',g_isaf.isafcomp,g_today,'')
   CALL s_fin_account_center_sons_str()RETURNING g_origin_str
   CALL aist310_01_change_to_sql(g_origin_str)RETURNING g_origin_str
   #161024-00065#2 add ------
   #取得aoos020的參數S-FIN-2023(流通門店銷售立帳方式)
   CALL cl_get_para(g_enterprise,g_isaf.isafcomp,'S-FIN-2023') RETURNING g_sfin2023
   #161024-00065#2 add end---
   #160223-00002#3-e
   
   #170221-00030#1 add ------
   #抓取是否為一次性交易對象
   SELECT pmaa004 INTO g_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_isaf_m.isaf003
   #170221-00030#1 add end---
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON xmdksite,xmdkdocno,xmdk006,xmdkdocdt,xmdk001,xmdk055 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            BEFORE FIELD xmdksite
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
            
            #160223-00002#3 mark ------
            #BEFORE FIELD xmdk000
            #   IF g_input.type = '1' THEN
            #      NEXT FIELD type
            #   END IF
            #160223-00002#3 mark end---
            
            BEFORE FIELD xmdkdocno
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
               
            BEFORE FIELD xmdk006
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
               
            BEFORE FIELD xmdkdocdt
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
               
            BEFORE FIELD xmdk001
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
               
            BEFORE FIELD xmdk055
               IF g_input.type = '1' THEN
                  NEXT FIELD type
               END IF
            
            ON ACTION controlp INFIELD xmdksite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL s_fin_create_account_center_tmp()
               CALL s_fin_account_center_sons_query('3',g_isaf.isafsite,g_today,'')
               #CALL s_fin_account_center_comp_str()RETURNING l_origin_str #150603-00046#1 mark
               #160223-00002#3 mark ------
               #CALL s_fin_account_center_sons_str()RETURNING l_origin_str #150603-00046#1
               #CALL aist310_01_change_to_sql(l_origin_str)RETURNING l_origin_str
               #LET g_qryparam.where = " ooef001 IN (",l_origin_str CLIPPED,")"
               #160223-00002#3 mark end---
               #160223-00002#3 add ------
               CALL s_fin_account_center_sons_str()RETURNING g_origin_str #150603-00046#1
               CALL aist310_01_change_to_sql(g_origin_str)RETURNING g_origin_str
               LET g_qryparam.where = " ooef001 IN (",g_origin_str CLIPPED,")",
                                      " AND ooef201 = 'Y'"   #161006-00005#29   add
               #160223-00002#3 add end---
               IF g_para_data = 'Y' THEN
                  LET g_qryparam.where = g_qryparam.where," AND ooef017 ='",g_isaf.isafcomp,"' "
               END IF
               CALL q_ooef001()  
               DISPLAY g_qryparam.return1 TO xmdksite
               NEXT FIELD xmdksite

            
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160223-00002#3 mark ------
               #LET g_qryparam.where = " xmdk008 = '",g_isaf.isaf003,"'",     #帳款客戶
               #                       " AND xmdk202 = '",g_isaf.isaf002,"'", #160126-00015#1 add lujh
               #                       " AND xmdk012 ='",g_isaf.isaf016,"'",  #稅別 #150603-00046#1
               #                       " AND xmdk016 ='",g_isaf.isaf100,"'",  #幣別 #150603-00046#1        #160426-00013#2 add,
               #                       " AND EXISTS (SELECT 1 FROM xmdl_t WHERE xmdlent = xmdkent ",       #160426-00013#2
               #                       "                AND xmdldocno = xmdkdocno AND xmdl022 > xmdl047)"  #160426-00013#2
               #IF g_para_data = 'Y' THEN 
               #   LET g_qryparam.where = g_qryparam.where," AND xmdksite IN (SELECT ooef001 FROM ooef_t ",
               #                                           "                   WHERE ooefent = ",g_enterprise,
               #                                           "                     AND ooef017 = '",g_isaf.isafcomp,"')"
               #END IF
               #CALL q_xmdkdocno()
               #160223-00002#3 mark end---
               #160223-00002#3 -s
               CASE
                  WHEN g_input.xmdk000 MATCHES '[123]' #出貨單
                     LET g_qryparam.where = " xmdk008 = '",g_isaf.isaf003,"'",     #帳款客戶
                                            " AND xmdk202 = '",g_isaf.isaf002,"'",
                                            " AND xmdk012 ='",g_isaf.isaf016,"'",  #稅別
                                            " AND xmdk016 ='",g_isaf.isaf100,"'",  #幣別
                                            #" AND xmdk000 IN ('1','2','3')",              #161013-00041#1 mark
                                            #dido:單據單號增加"出貨簽收單"性質,並加串狀態碼與出貨性質(該部分修改同新增開窗條件)
                                            #161013-00041#1 add --s
                                            " AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002 = '1') ",
                                            "  OR (xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
                                            #161013-00041#1 add --e
                                            " AND xmdksite IN (",g_origin_str CLIPPED,")",
                                            " AND EXISTS (SELECT 1 FROM xmdl_t WHERE xmdlent = xmdkent ",
                                            "                AND xmdldocno = xmdkdocno AND xmdl022 > xmdl047)"
                     IF g_para_data = 'Y' THEN
                        LET g_qryparam.where = g_qryparam.where," AND xmdksite IN (SELECT ooef001 FROM ooef_t ",
                                                                "                   WHERE ooefent = ",g_enterprise,
                                                                "                     AND ooef017 = '",g_isaf.isafcomp,"')"
                     END IF
                     #161206-00042#2-----s
                     #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
                     IF g_pmaa004 = '2' THEN             #170221-00030#1
                        LET g_qryparam.where = g_qryparam.where," AND xmdk047 = '",g_isaf.isaf067,"' "
                     END IF
                     #161206-00042#2-----e
                     CALL q_xmdkdocno()
                 
                  WHEN g_input.xmdk000 = '6' #銷退單
                     LET g_qryparam.where = " xmdk008 = '",g_isaf.isaf003,"'",     #帳款客戶
                                            " AND xmdk202 = '",g_isaf.isaf002,"'",
                                            " AND xmdk012 ='",g_isaf.isaf016,"'",  #稅別
                                            " AND xmdk016 ='",g_isaf.isaf100,"'",  #幣別
                                            " AND xmdk000 IN ('6')",
                                            " AND xmdksite IN (",g_origin_str CLIPPED,")",
                                            " AND EXISTS (SELECT 1 FROM xmdl_t WHERE xmdlent = xmdkent ",
                                            "                AND xmdldocno = xmdkdocno AND xmdl022 > xmdl047)"
                     IF g_para_data = 'Y' THEN
                        LET g_qryparam.where = g_qryparam.where," AND xmdksite IN (SELECT ooef001 FROM ooef_t ",
                                                                "                   WHERE ooefent = ",g_enterprise,
                                                                "                     AND ooef017 = '",g_isaf.isafcomp,"')"
                     END IF
                     #161206-00042#2-----s
                     #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
                     IF g_pmaa004 = '2' THEN             #170221-00030#1
                        LET g_qryparam.where = g_qryparam.where," AND xmdk047 = '",g_isaf.isaf067,"' "
                     END IF
                     #161206-00042#2-----e
                     CALL q_xmdkdocno()
                  
                  WHEN g_input.xmdk000 = '9' #訂單
                     LET g_qryparam.where = " xmda004 = '",g_isaf.isaf003,"'",
                                            " AND xmdasite IN (",g_origin_str CLIPPED,")",
                                            " AND EXISTS (SELECT 1 FROM xmdb_t WHERE xmdbent = xmdaent ",
                                            "                AND xmdbdocno = xmdadocno AND xmdb016 IN ('1','2'))"
                     IF g_para_data = 'Y' THEN
                        LET g_qryparam.where = g_qryparam.where," AND xmdasite IN (SELECT ooef001 FROM ooef_t ",
                                                                "                   WHERE ooefent = ",g_enterprise,
                                                                "                     AND ooef017 = '",g_isaf.isafcomp,"')"
                     END IF
                     #161214-00053#1 add ------
                     LET g_qryparam.where = g_qryparam.where,
                                            " AND (SELECT SUM(xmdb005) FROM xmdb_t ",
                                            "       WHERE xmdbent=xmdaent AND xmdbdocno=xmdadocno AND xmdb016 IN ('1','2')) - ",
                                            "     (CASE WHEN ",
                                            "          (SELECT SUM(isag103) FROM isag_t",
                                            "             LEFT JOIN isaf_t ON isagent=isafent AND isagcomp=isafcomp AND isagdocno=isafdocno ",
                                            "             WHERE isagent = xmdaent AND isag002 =xmdadocno AND isafstus <> 'X')",
                                            "      IS NULL THEN 0 ELSE",
                                            "          (SELECT SUM(isag103) FROM isag_t",
                                            "             LEFT JOIN isaf_t ON isagent=isafent AND isagcomp=isafcomp AND isagdocno=isafdocno ",
                                            "             WHERE isagent = xmdaent AND isag002 =xmdadocno AND isafstus <> 'X')",
                                            "     END) > 0"
                     #161214-00053#1 add end---
                     #161206-00042#2-----s
                     #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
                     IF g_pmaa004 = '2' THEN             #170221-00030#1
                        LET g_qryparam.where = g_qryparam.where," AND xmda028 = '",g_isaf.isaf067,"' "
                     END IF
                     #161206-00042#2-----e
                     CALL q_xmdadocno_2()
                  
                  WHEN g_input.xmdk000 MATCHES '1[01]' #10:門店銷售單/#11:門店銷退單
                     LET g_qryparam.where = " rtiastus = 'S' ",
                                            " AND rtiasite IN (",g_origin_str CLIPPED,")",
                                            " AND rtiadocdt <= '",g_isaf.isafdocdt,"' ",
                                            " AND rtib017 IS NOT NULL ", #計價數量
                                            " AND rtib006 = '",g_isaf.isaf016,"'",
                                            " AND rtia026 = '",g_isaf.isaf100,"'",
                                            " AND rtia002 = '",g_isaf.isaf003,"'",
                                            " AND NOT EXISTS (SELECT 1 FROM isaf_t,isag_t ",
                                            "                  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno ",
                                            "                    AND isag002 = rtiadocno AND isag003 = rtibseq AND isafstus <> 'X' )"
                     IF g_isaf.isaf056 = '1' THEN
                        #藍字發票
                        LET g_qryparam.where = g_qryparam.where," AND rtia000 IN ('artt600','artt610','artt620')"
                     ELSE
                        #紅字發票
                        LET g_qryparam.where = g_qryparam.where," AND rtia000 IN ('artt700') "
                     END IF
                     #161024-00065#2 add ------
                     IF g_sfin2023 = '1' THEN
                        LET g_qryparam.where = g_qryparam.where," AND rtia032 IN ('1','4')"
                     ELSE
                        LET g_qryparam.where = g_qryparam.where," AND rtia032 IN ('1')"
                     END IF
                     #161024-00065#2 add end---
                     CALL q_rtiadocno_4()
                  #161026-00001#1-----s
                  OTHERWISE 
                     LET g_qryparam.where = " xmdk008 = '",g_isaf.isaf003,"'",     #帳款客戶
                                            " AND xmdk202 = '",g_isaf.isaf002,"'",
                                            " AND xmdk012 ='",g_isaf.isaf016,"'",  #稅別
                                            " AND xmdk016 ='",g_isaf.isaf100,"'",  #幣別
                                            " AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002 = '1') ",
                                            "  OR (xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')  OR (xmdk000 IN ('6'))) ",
                                            " AND xmdksite IN (",g_origin_str CLIPPED,")",
                                            " AND EXISTS (SELECT 1 FROM xmdl_t WHERE xmdlent = xmdkent ",
                                            "                AND xmdldocno = xmdkdocno AND xmdl022 > xmdl047)"
                     IF g_para_data = 'Y' THEN
                        LET g_qryparam.where = g_qryparam.where," AND xmdksite IN (SELECT ooef001 FROM ooef_t ",
                                                                "                   WHERE ooefent = ",g_enterprise,
                                                                "                     AND ooef017 = '",g_isaf.isafcomp,"')"
                     END IF
                     #161206-00042#2-----s
                     #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
                     IF g_pmaa004 = '2' THEN             #170221-00030#1
                        LET g_qryparam.where = g_qryparam.where," AND xmdk047 = '",g_isaf.isaf067,"' "
                     END IF
                     #161206-00042#2-----e
                     CALL q_xmdkdocno()                      
                  #161026-00001#1-----e                          
               END CASE
               #160223-00002#3 -e
               DISPLAY g_qryparam.return1 TO xmdkdocno
               NEXT FIELD xmdkdocno
               
            
            ON ACTION controlp INFIELD xmdk006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " xmda004 = '",g_isaf.isaf003,"'"
               IF g_para_data = 'Y' THEN 
               LET g_qryparam.where = g_qryparam.where," AND xmdasite IN (SELECT ooef001 FROM ooef_t ",
                                                       "                   WHERE ooefent = ",g_enterprise,
                                                       "                     AND ooef017 = '",g_isaf.isafcomp,"')"
               END IF
               #161206-00042#2-----s
               #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
               IF g_pmaa004 = '2' THEN             #170221-00030#1
                  LET g_qryparam.where = g_qryparam.where," AND xmda028 = '",g_isaf.isaf067,"' "
               END IF
               #161206-00042#2-----e
               CALL q_xmdadocno_2()
               DISPLAY g_qryparam.return1 TO xmdk006
               NEXT FIELD xmdk006
            
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
 
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      #INPUT BY NAME g_input.type                #160223-00002#3 mark
      INPUT BY NAME g_input.type,g_input.xmdk000 #160223-00002#3
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
         
         #160223-00002#3 -s
         ON CHANGE type
            IF g_input.type = '1' THEN
               CALL cl_set_comp_entry("xmdk000",FALSE)
               LET g_input.xmdk000 = ''
            ELSE
               CALL cl_set_comp_entry("xmdk000",TRUE)
               IF g_isaf.isaf001 = '3' THEN
                  LET g_input.xmdk000 = '9'
               ELSE
                  LET g_input.xmdk000 = '1'
               END IF
            END IF
            DISPLAY BY NAME g_input.xmdk000
         #160223-00002#3 -e
         
         
      END INPUT
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_aist310_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   #CALL aist310_01_isag_ins() #160223-00002#3 mark
   #160223-00002#3 add ------
   CASE
      #WHEN g_input.xmdk000 MATCHES '[1236]' #出貨單 #161018-00001#1 mark
      WHEN g_input.xmdk000 MATCHES '[1236]' OR cl_null(g_input.xmdk000) #出貨單 #161018-00001#1
         CALL aist310_01_isag_ins()
      #WHEN g_input.xmdk000 = '9' #訂單  #161102-00003#1 mark
      WHEN g_input.xmdk000 = '9' OR g_isaf.isaf001 = '3' #訂單 #161102-00003#1
         CALL aist310_01_isag_ins_10()
      WHEN g_input.xmdk000 MATCHES '1[01]' #10:門店銷售單/#11:門店銷退單 
         CALL aist310_01_isag_ins_1322()
   END CASE
   #160223-00002#3 add end---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aist310_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aist310_01.other_function" readonly="Y" >}
# 整批产生立账来源明细
PRIVATE FUNCTION aist310_01_isag_ins()
   DEFINE l_sql            STRING
   #161104-00024#10 --s mark
  #DEFINE l_xmdk           RECORD LIKE xmdk_t.*
  #DEFINE l_xmdl           RECORD LIKE xmdl_t.*
  #DEFINE l_isag           RECORD LIKE isag_t.*
   #161104-00024#10 --e mark
   #161104-00024#10 --s add
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
          xmdkud001 LIKE xmdk_t.xmdkud001, #自定義欄位(文字)001
          xmdkud002 LIKE xmdk_t.xmdkud002, #自定義欄位(文字)002
          xmdkud003 LIKE xmdk_t.xmdkud003, #自定義欄位(文字)003
          xmdkud004 LIKE xmdk_t.xmdkud004, #自定義欄位(文字)004
          xmdkud005 LIKE xmdk_t.xmdkud005, #自定義欄位(文字)005
          xmdkud006 LIKE xmdk_t.xmdkud006, #自定義欄位(文字)006
          xmdkud007 LIKE xmdk_t.xmdkud007, #自定義欄位(文字)007
          xmdkud008 LIKE xmdk_t.xmdkud008, #自定義欄位(文字)008
          xmdkud009 LIKE xmdk_t.xmdkud009, #自定義欄位(文字)009
          xmdkud010 LIKE xmdk_t.xmdkud010, #自定義欄位(文字)010
          xmdkud011 LIKE xmdk_t.xmdkud011, #自定義欄位(數字)011
          xmdkud012 LIKE xmdk_t.xmdkud012, #自定義欄位(數字)012
          xmdkud013 LIKE xmdk_t.xmdkud013, #自定義欄位(數字)013
          xmdkud014 LIKE xmdk_t.xmdkud014, #自定義欄位(數字)014
          xmdkud015 LIKE xmdk_t.xmdkud015, #自定義欄位(數字)015
          xmdkud016 LIKE xmdk_t.xmdkud016, #自定義欄位(數字)016
          xmdkud017 LIKE xmdk_t.xmdkud017, #自定義欄位(數字)017
          xmdkud018 LIKE xmdk_t.xmdkud018, #自定義欄位(數字)018
          xmdkud019 LIKE xmdk_t.xmdkud019, #自定義欄位(數字)019
          xmdkud020 LIKE xmdk_t.xmdkud020, #自定義欄位(數字)020
          xmdkud021 LIKE xmdk_t.xmdkud021, #自定義欄位(日期時間)021
          xmdkud022 LIKE xmdk_t.xmdkud022, #自定義欄位(日期時間)022
          xmdkud023 LIKE xmdk_t.xmdkud023, #自定義欄位(日期時間)023
          xmdkud024 LIKE xmdk_t.xmdkud024, #自定義欄位(日期時間)024
          xmdkud025 LIKE xmdk_t.xmdkud025, #自定義欄位(日期時間)025
          xmdkud026 LIKE xmdk_t.xmdkud026, #自定義欄位(日期時間)026
          xmdkud027 LIKE xmdk_t.xmdkud027, #自定義欄位(日期時間)027
          xmdkud028 LIKE xmdk_t.xmdkud028, #自定義欄位(日期時間)028
          xmdkud029 LIKE xmdk_t.xmdkud029, #自定義欄位(日期時間)029
          xmdkud030 LIKE xmdk_t.xmdkud030, #自定義欄位(日期時間)030
          xmdk085 LIKE xmdk_t.xmdk085, #資料來源(銷退)
          xmdk086 LIKE xmdk_t.xmdk086, #來源單號(銷退)
          xmdk046 LIKE xmdk_t.xmdk046, #整合來源
          xmdk087 LIKE xmdk_t.xmdk087, #出貨走發票倉調撥
          xmdk047 LIKE xmdk_t.xmdk047, #一次性交易對象識別碼
          xmdk088 LIKE xmdk_t.xmdk088, #來源類型
          xmdk089 LIKE xmdk_t.xmdk089 #來源單號
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
          xmdlud001 LIKE xmdl_t.xmdlud001, #自定義欄位(文字)001
          xmdlud002 LIKE xmdl_t.xmdlud002, #自定義欄位(文字)002
          xmdlud003 LIKE xmdl_t.xmdlud003, #自定義欄位(文字)003
          xmdlud004 LIKE xmdl_t.xmdlud004, #自定義欄位(文字)004
          xmdlud005 LIKE xmdl_t.xmdlud005, #自定義欄位(文字)005
          xmdlud006 LIKE xmdl_t.xmdlud006, #自定義欄位(文字)006
          xmdlud007 LIKE xmdl_t.xmdlud007, #自定義欄位(文字)007
          xmdlud008 LIKE xmdl_t.xmdlud008, #自定義欄位(文字)008
          xmdlud009 LIKE xmdl_t.xmdlud009, #自定義欄位(文字)009
          xmdlud010 LIKE xmdl_t.xmdlud010, #自定義欄位(文字)010
          xmdlud011 LIKE xmdl_t.xmdlud011, #自定義欄位(數字)011
          xmdlud012 LIKE xmdl_t.xmdlud012, #自定義欄位(數字)012
          xmdlud013 LIKE xmdl_t.xmdlud013, #自定義欄位(數字)013
          xmdlud014 LIKE xmdl_t.xmdlud014, #自定義欄位(數字)014
          xmdlud015 LIKE xmdl_t.xmdlud015, #自定義欄位(數字)015
          xmdlud016 LIKE xmdl_t.xmdlud016, #自定義欄位(數字)016
          xmdlud017 LIKE xmdl_t.xmdlud017, #自定義欄位(數字)017
          xmdlud018 LIKE xmdl_t.xmdlud018, #自定義欄位(數字)018
          xmdlud019 LIKE xmdl_t.xmdlud019, #自定義欄位(數字)019
          xmdlud020 LIKE xmdl_t.xmdlud020, #自定義欄位(數字)020
          xmdlud021 LIKE xmdl_t.xmdlud021, #自定義欄位(日期時間)021
          xmdlud022 LIKE xmdl_t.xmdlud022, #自定義欄位(日期時間)022
          xmdlud023 LIKE xmdl_t.xmdlud023, #自定義欄位(日期時間)023
          xmdlud024 LIKE xmdl_t.xmdlud024, #自定義欄位(日期時間)024
          xmdlud025 LIKE xmdl_t.xmdlud025, #自定義欄位(日期時間)025
          xmdlud026 LIKE xmdl_t.xmdlud026, #自定義欄位(日期時間)026
          xmdlud027 LIKE xmdl_t.xmdlud027, #自定義欄位(日期時間)027
          xmdlud028 LIKE xmdl_t.xmdlud028, #自定義欄位(日期時間)028
          xmdlud029 LIKE xmdl_t.xmdlud029, #自定義欄位(日期時間)029
          xmdlud030 LIKE xmdl_t.xmdlud030, #自定義欄位(日期時間)030
          xmdl056 LIKE xmdl_t.xmdl056, #檢驗合格量
          xmdl094 LIKE xmdl_t.xmdl094, #來源單號(銷退)
          xmdl095 LIKE xmdl_t.xmdl095, #項次(銷退)
          xmdl227 LIKE xmdl_t.xmdl227, #現金折扣單號
          xmdl228 LIKE xmdl_t.xmdl228, #現金折扣單項次
          xmdl057 LIKE xmdl_t.xmdl057, #有效日期
          xmdl058 LIKE xmdl_t.xmdl058, #製造日期
          xmdl096 LIKE xmdl_t.xmdl096, #來源項次
         #xmdl059 LIKE xmdl_t.xmdl059#, #客戶退貨量 #161130-00006#1 mark
          xmdl059 LIKE xmdl_t.xmdl059, #客戶退貨量 #161130-00006#1 add
          xmdl060 LIKE xmdl_t.xmdl060  #放行狀態 #161130-00006#1 add
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
          isagud001 LIKE isag_t.isagud001, #自定義欄位(文字)001
          isagud002 LIKE isag_t.isagud002, #自定義欄位(文字)002
          isagud003 LIKE isag_t.isagud003, #自定義欄位(文字)003
          isagud004 LIKE isag_t.isagud004, #自定義欄位(文字)004
          isagud005 LIKE isag_t.isagud005, #自定義欄位(文字)005
          isagud006 LIKE isag_t.isagud006, #自定義欄位(文字)006
          isagud007 LIKE isag_t.isagud007, #自定義欄位(文字)007
          isagud008 LIKE isag_t.isagud008, #自定義欄位(文字)008
          isagud009 LIKE isag_t.isagud009, #自定義欄位(文字)009
          isagud010 LIKE isag_t.isagud010, #自定義欄位(文字)010
          isagud011 LIKE isag_t.isagud011, #自定義欄位(數字)011
          isagud012 LIKE isag_t.isagud012, #自定義欄位(數字)012
          isagud013 LIKE isag_t.isagud013, #自定義欄位(數字)013
          isagud014 LIKE isag_t.isagud014, #自定義欄位(數字)014
          isagud015 LIKE isag_t.isagud015, #自定義欄位(數字)015
          isagud016 LIKE isag_t.isagud016, #自定義欄位(數字)016
          isagud017 LIKE isag_t.isagud017, #自定義欄位(數字)017
          isagud018 LIKE isag_t.isagud018, #自定義欄位(數字)018
          isagud019 LIKE isag_t.isagud019, #自定義欄位(數字)019
          isagud020 LIKE isag_t.isagud020, #自定義欄位(數字)020
          isagud021 LIKE isag_t.isagud021, #自定義欄位(日期時間)021
          isagud022 LIKE isag_t.isagud022, #自定義欄位(日期時間)022
          isagud023 LIKE isag_t.isagud023, #自定義欄位(日期時間)023
          isagud024 LIKE isag_t.isagud024, #自定義欄位(日期時間)024
          isagud025 LIKE isag_t.isagud025, #自定義欄位(日期時間)025
          isagud026 LIKE isag_t.isagud026, #自定義欄位(日期時間)026
          isagud027 LIKE isag_t.isagud027, #自定義欄位(日期時間)027
          isagud028 LIKE isag_t.isagud028, #自定義欄位(日期時間)028
          isagud029 LIKE isag_t.isagud029, #自定義欄位(日期時間)029
          isagud030 LIKE isag_t.isagud030, #自定義欄位(日期時間)030
          isag018 LIKE isag_t.isag018  #訂金已開發票
   END RECORD
   #161104-00024#10 --e add
   DEFINE l_xmdl003        LIKE xmdl_t.xmdl003
   DEFINE l_xmdl004        LIKE xmdl_t.xmdl004
   DEFINE l_isag004        LIKE isag_t.isag004
   DEFINE l_isag004_2      LIKE isag_t.isag004
   DEFINE r_xrcd123        LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124        LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125        LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133        LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134        LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135        LIKE xrcd_t.xrcd115
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.chr1
   #170112-00018#1-----s
   DEFINE l_ooef019      LIKE ooef_t.ooef019
   DEFINE l_isac005      LIKE isac_t.isac005   
   DEFINE l_glaa001      LIKE glaa_t.glaa001
   DEFINE l_xrcd         RECORD
            xrcd113        LIKE xrcd_t.xrcd113,
            xrcd114        LIKE xrcd_t.xrcd114,
            xrcd115        LIKE xrcd_t.xrcd115,
            xrcd1132       LIKE xrcd_t.xrcd113,
            xrcd1142       LIKE xrcd_t.xrcd114,
            xrcd1152       LIKE xrcd_t.xrcd115,
            xrcd002        LIKE xrcd_t.xrcd002,
            xrcd006        LIKE xrcd_t.xrcd006,
            xrcdseq        LIKE xrcd_t.xrcdseq
                         END RECORD
   DEFINE l_dummy1       LIKE type_t.num20_6
   DEFINE l_dummy2       LIKE type_t.num20_6
   DEFINE l_dummy3       LIKE type_t.num20_6
   #170112-00018#1-----e
   
   WHENEVER ERROR CONTINUE #160823-00016#1
   
   #CALL s_transaction_begin()  #160426-00013#2 mark
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_flag = 'N'
   
   #161205-00025#16-----s
   LET l_sql = " INSERT INTO isag_t(isagent,isagcomp,isagdocno,isagseq,isagorga, ",
                         "          isag001,isag002,isag003,isag004,isag005, ",
                         "          isag006,isag007,isag008,isag009,isag010, ",
                         "          isag011,isag012,isag013,isag014,isag015, ",
                         "          isag016,isag017,isag101,isag103,isag104, ",
                         "          isag105,isag113,isag114,isag115) ",
                         " VALUES(?,?,?,?,?, ",
                         "        ?,?,?,?,?, ",
                         "        ?,?,?,?,?, ",
                         "        ?,?,?,?,?, ",
                         "        ?,?,?,?,?, ",
                         "        ?,?,?,?)"
   PREPARE ins_isagp1 FROM l_sql

   LET l_sql = " SELECT SUM(isag004) ",
               "   FROM isag_t,isaf_t ",
                " WHERE isagent = ? ",
                "   AND isag002 = ? ",
                "   AND isag003 = ? ",
                "   AND isafent = isagent ",
                "   AND isafdocno = isagdocno ",
                "   AND isafcomp = isagcomp ",
                "   AND isafstus <> 'X' ",
                "   AND isaf001 = '1'        "
   PREPARE selisag4p1 FROM l_sql

   LET l_sql = " SELECT SUM(isag004) ",
               "   FROM isag_t,isaf_t ",
               "  WHERE isagent = ? ",
               "    AND isag002 = ? ",
               "    AND isag003 = ? ",
               "    AND isafent = isagent ",
               "    AND isafdocno = isagdocno ",
               "    AND isafcomp = isagcomp ",
               "    AND isafstus <> 'X'      "
   PREPARE selisag4p2 FROM l_sql

   LET l_sql = " SELECT MAX(isagseq) ",
               "   FROM isag_t ",
               "  WHERE isagent = ? ",
               "    AND isagdocno = ? ",
               "    AND isagcomp = ? "
   PREPARE selisagseq1 FROM l_sql
   
   LET l_sql = " SELECT imaal003 ",
               "   FROM imaal_t ",
               "  WHERE imaalent = ",g_enterprise," ",
               "    AND imaal001=? ",
               "    AND imaal002='",g_dlang,"' "
   PREPARE selimaalp1 FROM l_sql               
   #161205-00025#16-----e
   
   #LET l_sql = "SELECT * FROM xmdk_t,xmdl_t ",   #161208-00026#19   mark
   
   #161205-00025#16 mark-----s
   #161208-00026#19   add---s
   #LET l_sql = "SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,
   #                    xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
   #                    xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,
   #                    xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,
   #                    xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,
   #                    xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,
   #                    xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,
   #                    xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,
   #                    xmdk035,xmdk036,xmdk037,xmdk038,xmdk039,
   #                    xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,
   #                    xmdk045,xmdk051,xmdk052,xmdk053,xmdk054,
   #                    xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,
   #                    xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,
   #                    xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,
   #                    xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,
   #                    xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,
   #                    xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,
   #                    xmdkpstdt,xmdkstus,xmdkud001,xmdkud002,xmdkud003,
   #                    xmdkud004,xmdkud005,xmdkud006,xmdkud007,xmdkud008,
   #                    xmdkud009,xmdkud010,xmdkud011,xmdkud012,xmdkud013,
   #                    xmdkud014,xmdkud015,xmdkud016,xmdkud017,xmdkud018,
   #                    xmdkud019,xmdkud020,xmdkud021,xmdkud022,xmdkud023,
   #                    xmdkud024,xmdkud025,xmdkud026,xmdkud027,xmdkud028,
   #                    xmdkud029,xmdkud030,xmdk085,xmdk086,xmdk046,
   #                    xmdk087,xmdk047,xmdk088,xmdk089,xmdlent,
   #                    xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,
   #                    xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,
   #                    xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,
   #                    xmdl013,xmdl014,xmdl015,xmdl016,xmdl017,
   #                    xmdl018,xmdl019,xmdl020,xmdl021,xmdl022,
   #                    xmdl023,xmdl024,xmdl025,xmdl026,xmdl027,
   #                    xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,
   #                    xmdl033,xmdl034,xmdl035,xmdl036,xmdl037,
   #                    xmdl038,xmdl039,xmdl040,xmdl041,xmdl042,
   #                    xmdl043,xmdl044,xmdl045,xmdl046,xmdl047,
   #                    xmdl048,xmdl049,xmdl050,xmdl051,xmdl052,
   #                    xmdl053,xmdl054,xmdl055,xmdl081,xmdl082,
   #                    xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,
   #                    xmdl088,xmdl089,xmdl090,xmdl091,xmdl092,
   #                    xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,
   #                    xmdl204,xmdl205,xmdl206,xmdl207,xmdl208,
   #                    xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,
   #                    xmdl214,xmdl215,xmdl216,xmdl217,xmdl218,
   #                    xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,
   #                    xmdl225,xmdl226,xmdlunit,xmdlorga,xmdlud001,
   #                    xmdlud002,xmdlud003,xmdlud004,xmdlud005,xmdlud006,
   #                    xmdlud007,xmdlud008,xmdlud009,xmdlud010,xmdlud011,
   #                    xmdlud012,xmdlud013,xmdlud014,xmdlud015,xmdlud016,
   #                    xmdlud017,xmdlud018,xmdlud019,xmdlud020,xmdlud021,
   #                    xmdlud022,xmdlud023,xmdlud024,xmdlud025,xmdlud026,
   #                    xmdlud027,xmdlud028,xmdlud029,xmdlud030,xmdl056,
   #                    xmdl094,xmdl095,xmdl227,xmdl228,xmdl057,
   #                    xmdl058,xmdl096,xmdl059,xmdl060
   #               FROM xmdk_t,xmdl_t ",
   ##161208-00026#19   add---e
   #161205-00025#16 mark-----e
   #161205-00025#16-----s
   LET l_sql = "SELECT xmdksite,xmdkdocno,xmdkdocdt, ",
               "       xmdk000,xmdk006,xmdk010, ",
               "       xmdldocno,xmdlseq,xmdl008, ",
               "       xmdl021,xmdl022,xmdl024, ",
               "       xmdl033,xmdl047,xmdl048, ",
               "       xmdl049,xmdl003,xmdl004 ",
               "       FROM xmdk_t,xmdl_t ",
   #161205-00025#16-----e
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkdocno = xmdldocno ",
               "   AND xmdl022 >  xmdl047 ",
               "   AND xmdk008 = '",g_isaf.isaf003,"'", 
               "   AND xmdk202 = '",g_isaf.isaf002,"'",    #160126-00015#1 add lujh
              #"   AND xmdkstus = 'S' ",   #151207-00018#1   Mark
               "   AND xmdk001 <= '",g_isaf.isafdocdt,"'",
               "   AND xmdksite = '",g_isaf.isafsite,"'",
               "   AND xmdl025 = '",g_isaf.isaf016,"'",
              #151207-00018#1 Add  ---(S)---
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') ",
               "      OR (xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')             ",
              #"      OR (xmdk000 = '6' AND xmdkstus = 'Y' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y')))", #160831-00059#1 mark
               "      OR (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y')))", #160831-00059#1
              #151207-00018#1 Add  ---(E)---
               "   AND xmdk016 = '",g_isaf.isaf100,"'" #150603-00046#1 add
              ,"   AND xmdkent = xmdlent "             #160413-00018#1
   IF g_isaf.isaf056 = '1' THEN 
      #LET l_sql = l_sql," AND xmdk000 IN ('1','2','3')"
   ELSE
      LET l_sql = l_sql," AND xmdk000 = '6' "
   END IF
   IF g_input.type = '2' THEN
      LET l_sql = l_sql," AND ",g_wc
   END IF
   PREPARE aist310_01_pre FROM l_sql
   DECLARE aist310_01_cur CURSOR FOR aist310_01_pre
   #FOREACH aist310_01_cur INTO l_xmdk.*,l_xmdl.*   #161208-00026#19   mark
   #161205-00025#16 mark-----s
   #161208-00026#19   add---s
   #FOREACH aist310_01_cur 
   #   INTO l_xmdk.xmdkent,l_xmdk.xmdksite,l_xmdk.xmdkunit,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,
   #        l_xmdk.xmdk000,l_xmdk.xmdk001,l_xmdk.xmdk002,l_xmdk.xmdk003,l_xmdk.xmdk004,
   #        l_xmdk.xmdk005,l_xmdk.xmdk006,l_xmdk.xmdk007,l_xmdk.xmdk008,l_xmdk.xmdk009,
   #        l_xmdk.xmdk010,l_xmdk.xmdk011,l_xmdk.xmdk012,l_xmdk.xmdk013,l_xmdk.xmdk014,
   #        l_xmdk.xmdk015,l_xmdk.xmdk016,l_xmdk.xmdk017,l_xmdk.xmdk018,l_xmdk.xmdk019,
   #        l_xmdk.xmdk020,l_xmdk.xmdk021,l_xmdk.xmdk022,l_xmdk.xmdk023,l_xmdk.xmdk024,
   #        l_xmdk.xmdk025,l_xmdk.xmdk026,l_xmdk.xmdk027,l_xmdk.xmdk028,l_xmdk.xmdk029,
   #        l_xmdk.xmdk030,l_xmdk.xmdk031,l_xmdk.xmdk032,l_xmdk.xmdk033,l_xmdk.xmdk034,
   #        l_xmdk.xmdk035,l_xmdk.xmdk036,l_xmdk.xmdk037,l_xmdk.xmdk038,l_xmdk.xmdk039,
   #        l_xmdk.xmdk040,l_xmdk.xmdk041,l_xmdk.xmdk042,l_xmdk.xmdk043,l_xmdk.xmdk044,
   #        l_xmdk.xmdk045,l_xmdk.xmdk051,l_xmdk.xmdk052,l_xmdk.xmdk053,l_xmdk.xmdk054,
   #        l_xmdk.xmdk055,l_xmdk.xmdk081,l_xmdk.xmdk082,l_xmdk.xmdk083,l_xmdk.xmdk084,
   #        l_xmdk.xmdk200,l_xmdk.xmdk201,l_xmdk.xmdk202,l_xmdk.xmdk203,l_xmdk.xmdk204,
   #        l_xmdk.xmdk205,l_xmdk.xmdk206,l_xmdk.xmdk207,l_xmdk.xmdk208,l_xmdk.xmdk209,
   #        l_xmdk.xmdk210,l_xmdk.xmdk211,l_xmdk.xmdk212,l_xmdk.xmdk213,l_xmdk.xmdk214,
   #        l_xmdk.xmdkownid,l_xmdk.xmdkowndp,l_xmdk.xmdkcrtid,l_xmdk.xmdkcrtdp,l_xmdk.xmdkcrtdt,
   #        l_xmdk.xmdkmodid,l_xmdk.xmdkmoddt,l_xmdk.xmdkcnfid,l_xmdk.xmdkcnfdt,l_xmdk.xmdkpstid,
   #        l_xmdk.xmdkpstdt,l_xmdk.xmdkstus,l_xmdk.xmdkud001,l_xmdk.xmdkud002,l_xmdk.xmdkud003,
   #        l_xmdk.xmdkud004,l_xmdk.xmdkud005,l_xmdk.xmdkud006,l_xmdk.xmdkud007,l_xmdk.xmdkud008,
   #        l_xmdk.xmdkud009,l_xmdk.xmdkud010,l_xmdk.xmdkud011,l_xmdk.xmdkud012,l_xmdk.xmdkud013,
   #        l_xmdk.xmdkud014,l_xmdk.xmdkud015,l_xmdk.xmdkud016,l_xmdk.xmdkud017,l_xmdk.xmdkud018,
   #        l_xmdk.xmdkud019,l_xmdk.xmdkud020,l_xmdk.xmdkud021,l_xmdk.xmdkud022,l_xmdk.xmdkud023,
   #        l_xmdk.xmdkud024,l_xmdk.xmdkud025,l_xmdk.xmdkud026,l_xmdk.xmdkud027,l_xmdk.xmdkud028,
   #        l_xmdk.xmdkud029,l_xmdk.xmdkud030,l_xmdk.xmdk085,l_xmdk.xmdk086,l_xmdk.xmdk046,
   #        l_xmdk.xmdk087,l_xmdk.xmdk047,l_xmdk.xmdk088,l_xmdk.xmdk089,l_xmdl.xmdlent,
   #        l_xmdl.xmdlsite,l_xmdl.xmdldocno,l_xmdl.xmdlseq,l_xmdl.xmdl001,l_xmdl.xmdl002,
   #        l_xmdl.xmdl003,l_xmdl.xmdl004,l_xmdl.xmdl005,l_xmdl.xmdl006,l_xmdl.xmdl007,
   #        l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl010,l_xmdl.xmdl011,l_xmdl.xmdl012,
   #        l_xmdl.xmdl013,l_xmdl.xmdl014,l_xmdl.xmdl015,l_xmdl.xmdl016,l_xmdl.xmdl017,
   #        l_xmdl.xmdl018,l_xmdl.xmdl019,l_xmdl.xmdl020,l_xmdl.xmdl021,l_xmdl.xmdl022,
   #        l_xmdl.xmdl023,l_xmdl.xmdl024,l_xmdl.xmdl025,l_xmdl.xmdl026,l_xmdl.xmdl027,
   #        l_xmdl.xmdl028,l_xmdl.xmdl029,l_xmdl.xmdl030,l_xmdl.xmdl031,l_xmdl.xmdl032,
   #        l_xmdl.xmdl033,l_xmdl.xmdl034,l_xmdl.xmdl035,l_xmdl.xmdl036,l_xmdl.xmdl037,
   #        l_xmdl.xmdl038,l_xmdl.xmdl039,l_xmdl.xmdl040,l_xmdl.xmdl041,l_xmdl.xmdl042,
   #        l_xmdl.xmdl043,l_xmdl.xmdl044,l_xmdl.xmdl045,l_xmdl.xmdl046,l_xmdl.xmdl047,
   #        l_xmdl.xmdl048,l_xmdl.xmdl049,l_xmdl.xmdl050,l_xmdl.xmdl051,l_xmdl.xmdl052,
   #        l_xmdl.xmdl053,l_xmdl.xmdl054,l_xmdl.xmdl055,l_xmdl.xmdl081,l_xmdl.xmdl082,
   #        l_xmdl.xmdl083,l_xmdl.xmdl084,l_xmdl.xmdl085,l_xmdl.xmdl086,l_xmdl.xmdl087,
   #        l_xmdl.xmdl088,l_xmdl.xmdl089,l_xmdl.xmdl090,l_xmdl.xmdl091,l_xmdl.xmdl092,
   #        l_xmdl.xmdl093,l_xmdl.xmdl200,l_xmdl.xmdl201,l_xmdl.xmdl202,l_xmdl.xmdl203,
   #        l_xmdl.xmdl204,l_xmdl.xmdl205,l_xmdl.xmdl206,l_xmdl.xmdl207,l_xmdl.xmdl208,
   #        l_xmdl.xmdl209,l_xmdl.xmdl210,l_xmdl.xmdl211,l_xmdl.xmdl212,l_xmdl.xmdl213,
   #        l_xmdl.xmdl214,l_xmdl.xmdl215,l_xmdl.xmdl216,l_xmdl.xmdl217,l_xmdl.xmdl218,
   #        l_xmdl.xmdl219,l_xmdl.xmdl220,l_xmdl.xmdl222,l_xmdl.xmdl223,l_xmdl.xmdl224,
   #        l_xmdl.xmdl225,l_xmdl.xmdl226,l_xmdl.xmdlunit,l_xmdl.xmdlorga,l_xmdl.xmdlud001,
   #        l_xmdl.xmdlud002,l_xmdl.xmdlud003,l_xmdl.xmdlud004,l_xmdl.xmdlud005,l_xmdl.xmdlud006,
   #        l_xmdl.xmdlud007,l_xmdl.xmdlud008,l_xmdl.xmdlud009,l_xmdl.xmdlud010,l_xmdl.xmdlud011,
   #        l_xmdl.xmdlud012,l_xmdl.xmdlud013,l_xmdl.xmdlud014,l_xmdl.xmdlud015,l_xmdl.xmdlud016,
   #        l_xmdl.xmdlud017,l_xmdl.xmdlud018,l_xmdl.xmdlud019,l_xmdl.xmdlud020,l_xmdl.xmdlud021,
   #        l_xmdl.xmdlud022,l_xmdl.xmdlud023,l_xmdl.xmdlud024,l_xmdl.xmdlud025,l_xmdl.xmdlud026,
   #        l_xmdl.xmdlud027,l_xmdl.xmdlud028,l_xmdl.xmdlud029,l_xmdl.xmdlud030,l_xmdl.xmdl056,
   #        l_xmdl.xmdl094,l_xmdl.xmdl095,l_xmdl.xmdl227,l_xmdl.xmdl228,l_xmdl.xmdl057,
   #        l_xmdl.xmdl058,l_xmdl.xmdl096,l_xmdl.xmdl059,l_xmdl.xmdl060
   ##161208-00026#19   add---e
   #161205-00025#16 mark-----e
   #161205-00025#16-----s
   FOREACH aist310_01_cur 
      INTO l_xmdk.xmdksite,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,
           l_xmdk.xmdk000,l_xmdk.xmdk006,l_xmdk.xmdk010,
           l_xmdl.xmdldocno,l_xmdl.xmdlseq,l_xmdl.xmdl008,
           l_xmdl.xmdl021,l_xmdl.xmdl022,l_xmdl.xmdl024,
           l_xmdl.xmdl033,l_xmdl.xmdl047,l_xmdl.xmdl048,
           l_xmdl.xmdl049,l_xmdl.xmdl003,l_xmdl.xmdl004
   #161205-00025#16-----e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      #161205-00025#16 mark-----s
      #SELECT MAX(isagseq) INTO l_isag.isagseq
      #  FROM isag_t
      # WHERE isagent = g_enterprise
      #   AND isagdocno = g_isaf.isafdocno
      #   AND isagcomp = g_isaf.isafcomp
      #161205-00025#16 mark-----e
      #161205-00025#16-----s
      EXECUTE selisagseq1 USING g_enterprise,g_isaf.isafdocno,g_isaf.isafcomp INTO l_isag.isagseq
      #161205-00025#16-----e
      IF cl_null(l_isag.isagseq) THEN 
        LET l_isag.isagseq = 1
      ELSE
         LET l_isag.isagseq = l_isag.isagseq + 1
      END IF
      
      LET l_isag.isagent = g_enterprise
      LET l_isag.isagcomp = g_isaf.isafcomp
      LET l_isag.isagdocno = g_isaf.isafdocno
      LET l_isag.isagorga = l_xmdk.xmdksite
      
      IF l_xmdk.xmdk000 = '6' THEN 
         LET l_isag.isag001 = '21'    #销退
      ELSE
         LET l_isag.isag001 = '11'    #出货
      END IF
      
      LET l_isag.isag002 = l_xmdl.xmdldocno
      LET l_isag.isag003 = l_xmdl.xmdlseq
      
      #161205-00025#16 mark-----s
      ##由出貨單串訂單
      #SELECT xmdl003,xmdl004 INTO l_xmdl003,l_xmdl004
      #  FROM xmdl_t
      # WHERE xmdlent = g_enterprise
      #   AND xmdldocno = l_isag.isag002
      #   AND xmdlseq = l_isag.isag003
      #161205-00025#16 mark-----e
      
      #161205-00025#16 mark-----s
      #SELECT SUM(isag004) INTO l_isag004
      #  FROM isag_t,isaf_t
      # WHERE isagent = g_enterprise
      #   AND isag002 = l_xmdl003  # 訂單號碼
      #   AND isag003 = l_xmdl004  #-訂單項次
      #   AND isafent = isagent
      #   AND isafdocno = isagdocno
      #   AND isafcomp = isagcomp
      #   AND isafstus <> 'X'      #151223-00001#3 add lujh
      #   AND isaf001 = '1'        #160623-00019#1
      #IF cl_null(l_isag004) THEN LET l_isag004 = 0 END IF
	   #  
      ##出貨單 
      #SELECT SUM(isag004) INTO l_isag004_2
      #  FROM isag_t,isaf_t
      # WHERE isagent = g_enterprise
      #   AND isag002 = l_isag.isag002
      #   AND isag003 = l_isag.isag003
      #   AND isafent = isagent
      #   AND isafdocno = isagdocno
      #   AND isafcomp = isagcomp　
      #   AND isafstus <> 'X'           #151223-00001#3 add lujh
      #IF cl_null(l_isag004_2) THEN LET l_isag004_2 = 0 END IF
      #161205-00025#16 mark-----e  
      #161205-00025#16-----s
      EXECUTE selisag4p1 USING g_enterprise,l_xmdl.xmdl003,l_xmdl.xmdl004 INTO l_isag004   
      IF cl_null(l_isag004) THEN LET l_isag004 = 0 END IF
      
      EXECUTE selisag4p2 USING g_enterprise,l_xmdl.xmdl003,l_xmdl.xmdl004 INTO l_isag004_2
      IF cl_null(l_isag004_2) THEN LET l_isag004_2 = 0 END IF	   
      #161205-00025#16-----e      
      
      #LET l_isag.isag004 = l_xmdl.xmdl022 - l_isag004 - l_isag004_2   #160426-00013#2 mark
      LET l_isag.isag004 = l_xmdl.xmdl022 - l_isag004 - l_xmdl.xmdl047 #160426-00013#2
      
      IF l_isag.isag004 <= 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_isag.isag005 = l_xmdl.xmdl021
      LET l_isag.isag006 = g_isaf.isaf016
      LET l_isag.isag007 = g_isaf.isaf017
      LET l_isag.isag008 = g_isaf.isaf018
      LET l_isag.isag009 = l_xmdl.xmdl008
      
      #161205-00025#16 mark-----s
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = l_isag.isag009
      #CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET l_isag.isag010 = '', g_rtn_fields[1] , ''
      #161205-00025#16 mark-----e
      #161205-00025#16-----s
      EXECUTE selimaalp1 USING l_isag.isag009 INTO l_isag.isag010
      #161205-00025#16-----e
   
      LET l_isag.isag011 = 0
      LET l_isag.isag012 = l_xmdk.xmdk010
      LET l_isag.isag013 = l_xmdl.xmdl048
      LET l_isag.isag014 = l_xmdl.xmdl049
      
      IF l_isag.isag001 = '11' THEN
         LET l_isag.isag015 = 1
      ELSE
         LET l_isag.isag015 = -1
      END IF
      
      LET l_isag.isag016 = l_xmdl.xmdl033
      LET l_isag.isag017 = ''
      #170112-00018#1-----s
      SELECT pmao009
        INTO l_isag.isag017
        FROM pmao_t
       WHERE pmaoent = g_enterprise
         AND pmao001 = l_xmdk.xmdk007
         AND pmao002 = l_xmdl.xmdl008
         AND pmao003 = l_xmdl.xmdl009
         AND pmao004 = l_xmdl.xmdl033
      #170112-00018#1-----e
      
      LET l_isag.isag101 = l_xmdl.xmdl024
      
      CALL s_tax_ins(g_isaf.isafdocno,l_isag.isagseq,0,l_isag.isagorga,
                     l_isag.isag004 * l_isag.isag101,l_isag.isag006,
                     l_isag.isag004,g_isaf.isaf100,g_isaf.isaf101,g_glaald,0,0)
           RETURNING l_isag.isag103,l_isag.isag104,l_isag.isag105,
                     l_isag.isag113,l_isag.isag114,l_isag.isag115,
                     r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
      
      
      #161205-00025#16 mark-----s
      #INSERT INTO isag_t(isagent,isagcomp,isagdocno,isagseq,isagorga,
      #                   isag001,isag002,isag003,isag004,isag005,
      #                   isag006,isag007,isag008,isag009,isag010,
      #                   isag011,isag012,isag013,isag014,isag015,
      #                   isag016,isag017,isag101,isag103,isag104,
      #                   isag105,isag113,isag114,isag115)
      #            VALUES(g_enterprise,l_isag.isagcomp,l_isag.isagdocno,l_isag.isagseq,l_isag.isagorga,
      #                   l_isag.isag001,l_isag.isag002,l_isag.isag003,l_isag.isag004,l_isag.isag005,
      #                   l_isag.isag006,l_isag.isag007,l_isag.isag008,l_isag.isag009,l_isag.isag010,
      #                   l_isag.isag011,l_isag.isag012,l_isag.isag013,l_isag.isag014,l_isag.isag015,
      #                   l_isag.isag016,l_isag.isag017,l_isag.isag101,l_isag.isag103,l_isag.isag104,
      #                   l_isag.isag105,l_isag.isag113,l_isag.isag114,l_isag.isag115)
      #161205-00025#16 mark-----e
      #161205-00025#16-----s
      EXECUTE ins_isagp1 USING g_enterprise,l_isag.isagcomp,l_isag.isagdocno,l_isag.isagseq,l_isag.isagorga,
                         l_isag.isag001,l_isag.isag002,l_isag.isag003,l_isag.isag004,l_isag.isag005,
                         l_isag.isag006,l_isag.isag007,l_isag.isag008,l_isag.isag009,l_isag.isag010,
                         l_isag.isag011,l_isag.isag012,l_isag.isag013,l_isag.isag014,l_isag.isag015,
                         l_isag.isag016,l_isag.isag017,l_isag.isag101,l_isag.isag103,l_isag.isag104,
                         l_isag.isag105,l_isag.isag113,l_isag.isag114,l_isag.isag115
      #161205-00025#16-----e
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "isag_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
      
      #151223-00001#3--add--str--lujh
      CALL aist310_upd_xmdl(l_isag.isagseq,l_isag.isag002,l_isag.isag003,'+') RETURNING l_success
      IF l_success = FALSE THEN 
         #CALL s_transaction_end('N','0') #160426-00013#2
         LET l_success = FALSE
      END IF
      #151223-00001#3--add--str--lujh
      
      LET l_flag = 'Y'
   END FOREACH
   
   #170112-00018#1-----s
   LET l_glaa001 = NULL
   SELECT glaa001 INTO l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
   
   LET l_ooef019 = NULL
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_isaf.isafcomp
      AND ooefstus = 'Y'
    
    #1.取發票類型判斷
    SELECT isac005 INTO l_isac005
      FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = l_ooef019
      AND isac002 = g_isaf.isaf008
    
    IF l_isac005='1' THEN 	#	依總額計稅 T
       DISPLAY 'DO TAX RECOUNT'
       #CALL s_tax_recount(g_isaf.isafdocno)   #170215-00049#1 mark
       CALL aist310_01_tax_recount(g_isaf.isafdocno)    #170215-00049#1
          RETURNING r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
       
       LET l_sql = "SELECT xrcd002,xrcd006,SUM(xrcd113),SUM(xrcd114),SUM(xrcd115) ",
                  "  FROM xrcd_t ",
                  " WHERE xrcdent = ",g_enterprise,
                  "   AND xrcddocno ='", g_isaf.isafdocno,"' ",
                  " GROUP BY xrcd002,xrcd006 "
      PREPARE sel_xrcdp1 FROM l_sql
      DECLARE sel_xrcdc1 CURSOR FOR sel_xrcdp1
      FOREACH sel_xrcdc1 INTO l_xrcd.xrcd002,l_xrcd.xrcd006,l_xrcd.xrcd113,l_xrcd.xrcd114,l_xrcd.xrcd115
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         IF l_xrcd.xrcd006 = 'Y' THEN
            CALL s_tax_count(g_isaf.isafcomp,l_xrcd.xrcd002,l_xrcd.xrcd115,1,l_glaa001,g_isaf.isaf101)
               RETURNING l_xrcd.xrcd1132,l_xrcd.xrcd1142,l_xrcd.xrcd1152,
                         l_dummy1,l_dummy2,l_dummy3
         ELSE
            CALL s_tax_count(g_isaf.isafcomp,l_xrcd.xrcd002,l_xrcd.xrcd113,1,l_glaa001,g_isaf.isaf101)
               RETURNING l_xrcd.xrcd1132,l_xrcd.xrcd1142,l_xrcd.xrcd1152,
                         l_dummy1,l_dummy2,l_dummy3
         END IF
         
         SELECT MIN(xrcdseq) INTO l_xrcd.xrcdseq FROM xrcd_t
          WHERE xrcdent   = g_enterprise
            AND xrcddocno = g_isaf.isafdocno
            AND xrcd002   = l_xrcd.xrcd002
            AND xrcd115   = (SELECT MAX(xrcd115) FROM xrcd_t WHERE xrcdent = g_enterprise 
                                AND xrcddocno = g_isaf.isafdocno AND xrcd002 = l_xrcd.xrcd002)
         
         LET l_xrcd.xrcd1132 = l_xrcd.xrcd1132 - l_xrcd.xrcd113
         LET l_xrcd.xrcd1142 = l_xrcd.xrcd1142 - l_xrcd.xrcd114
         LET l_xrcd.xrcd1152 = l_xrcd.xrcd1152 - l_xrcd.xrcd115
         
         UPDATE xrcd_t SET xrcd113 = xrcd113 + l_xrcd.xrcd1132,
                           xrcd114 = xrcd114 + l_xrcd.xrcd1142,
                           xrcd115 = xrcd115 + l_xrcd.xrcd1152
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_isaf.isafdocno
            AND xrcdseq   = l_xrcd.xrcdseq
         
         UPDATE isag_t SET isag113 = isag113 + l_xrcd.xrcd1132,
                           isag114 = isag114 + l_xrcd.xrcd1142,
                           isag115 = isag115 + l_xrcd.xrcd1152
          WHERE isagent = g_enterprise
            AND isagdocno = g_isaf.isafdocno
            AND isagcomp = g_isaf.isafcomp
            AND isagseq = l_xrcd.xrcdseq
         IF g_isaf.isaf100 = l_glaa001 THEN
            UPDATE xrcd_t SET xrcd103 = xrcd113,
                              xrcd104 = xrcd114,
                              xrcd105 = xrcd115
             WHERE xrcdent = g_enterprise       
               AND xrcddocno = g_isaf.isafdocno 
               AND xrcdseq   = l_xrcd.xrcdseq   
                                                
            UPDATE isag_t SET isag103 = isag113,
                              isag104 = isag114,
                              isag105 = isag115
             WHERE isagent = g_enterprise
               AND isagdocno = g_isaf.isafdocno
               AND isagcomp = g_isaf.isafcomp
               AND isagseq = l_xrcd.xrcdseq
         END IF
      END FOREACH
   END IF 
   #170112-00018#1-----e
   
   #160426-00013#2-s
   CALL aist310_01_isag_ins_2729() RETURNING l_success
   IF l_success = FALSE THEN 
      LET l_success = FALSE
   END IF
   #160426-00013#2-e
   
   CALL cl_err_collect_show()
   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION
#
PRIVATE FUNCTION aist310_01_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 抓取該出貨單對應的訂單產生的訂金帳款單
# Memo...........: #160426-00013#2
# Usage..........: CALL aist310_01_isag_ins_2729()
# Date & Author..: 2016/06/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aist310_01_isag_ins_2729()
DEFINE l_xmdk RECORD   #出貨/簽收/銷退單單頭檔
                 xmdksite LIKE xmdk_t.xmdksite,   #營運據點
                 xmdk006  LIKE xmdk_t.xmdk006,    #訂單單號
                 xmdk010  LIKE xmdk_t.xmdk010     #收款條件
              END RECORD
DEFINE l_sfin2022        LIKE type_t.chr10
DEFINE l_sql            STRING
#DEFINE l_isag           RECORD LIKE isag_t.* #161104-00024#10 mark
#161104-00024#10 --s add
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
       isagud001 LIKE isag_t.isagud001, #自定義欄位(文字)001
       isagud002 LIKE isag_t.isagud002, #自定義欄位(文字)002
       isagud003 LIKE isag_t.isagud003, #自定義欄位(文字)003
       isagud004 LIKE isag_t.isagud004, #自定義欄位(文字)004
       isagud005 LIKE isag_t.isagud005, #自定義欄位(文字)005
       isagud006 LIKE isag_t.isagud006, #自定義欄位(文字)006
       isagud007 LIKE isag_t.isagud007, #自定義欄位(文字)007
       isagud008 LIKE isag_t.isagud008, #自定義欄位(文字)008
       isagud009 LIKE isag_t.isagud009, #自定義欄位(文字)009
       isagud010 LIKE isag_t.isagud010, #自定義欄位(文字)010
       isagud011 LIKE isag_t.isagud011, #自定義欄位(數字)011
       isagud012 LIKE isag_t.isagud012, #自定義欄位(數字)012
       isagud013 LIKE isag_t.isagud013, #自定義欄位(數字)013
       isagud014 LIKE isag_t.isagud014, #自定義欄位(數字)014
       isagud015 LIKE isag_t.isagud015, #自定義欄位(數字)015
       isagud016 LIKE isag_t.isagud016, #自定義欄位(數字)016
       isagud017 LIKE isag_t.isagud017, #自定義欄位(數字)017
       isagud018 LIKE isag_t.isagud018, #自定義欄位(數字)018
       isagud019 LIKE isag_t.isagud019, #自定義欄位(數字)019
       isagud020 LIKE isag_t.isagud020, #自定義欄位(數字)020
       isagud021 LIKE isag_t.isagud021, #自定義欄位(日期時間)021
       isagud022 LIKE isag_t.isagud022, #自定義欄位(日期時間)022
       isagud023 LIKE isag_t.isagud023, #自定義欄位(日期時間)023
       isagud024 LIKE isag_t.isagud024, #自定義欄位(日期時間)024
       isagud025 LIKE isag_t.isagud025, #自定義欄位(日期時間)025
       isagud026 LIKE isag_t.isagud026, #自定義欄位(日期時間)026
       isagud027 LIKE isag_t.isagud027, #自定義欄位(日期時間)027
       isagud028 LIKE isag_t.isagud028, #自定義欄位(日期時間)028
       isagud029 LIKE isag_t.isagud029, #自定義欄位(日期時間)029
       isagud030 LIKE isag_t.isagud030, #自定義欄位(日期時間)030
       isag018 LIKE isag_t.isag018  #訂金已開發票
END RECORD
#161104-00024#10 --e add
DEFINE l_xmdk006        LIKE xmdk_t.xmdk006
DEFINE l_xrca019        LIKE xrca_t.xrca019
DEFINE l_xrca060        LIKE xrca_t.xrca060    #160823-00016#1
DEFINE l_isag105        LIKE isag_t.isag105
DEFINE l_isag115        LIKE isag_t.isag115
DEFINE l_isag105_sum    LIKE isag_t.isag105
DEFINE l_isag115_sum    LIKE isag_t.isag115
DEFINE l_xrccseq        LIKE xrcc_t.xrccseq
DEFINE r_success        LIKE type_t.num5
#161005-00018#3-----s
DEFINE l_xrcald         LIKE xrca_t.xrcald
DEFINE l_xrca012        LIKE xrca_t.xrca012
#161005-00018#3-----e
   
   WHENEVER ERROR CONTINUE #160823-00016#1
   
   LET r_success = TRUE
   
   LET l_sfin2022 = cl_get_para(g_enterprise,g_isaf.isafcomp,'S-FIN-2022')
   
   #先取得出貨單的訂單
   LET l_sql = "SELECT DISTINCT xmdksite,xmdk006,xmdk010",
               "   FROM xmdk_t",
               "   LEFT JOIN xmdl_t ON xmdkdocno = xmdldocno AND xmdkent = xmdlent",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdksite = '",g_isaf.isafsite,"'",
               "   AND xmdk001 <= '",g_isaf.isafdocdt,"'",
               "   AND xmdk008 = '",g_isaf.isaf003,"'",
               "   AND xmdl025 = '",g_isaf.isaf016,"'",
               "   AND xmdk016 = '",g_isaf.isaf100,"'",
               "   AND xmdk202 = '",g_isaf.isaf002,"'",
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') ",
               "      OR (xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')",
              #"      OR (xmdk000 = '6' AND xmdkstus = 'Y' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y'))", #160831-00059#1 mark
               "      OR (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y'))", #160831-00059#1
               "      ) "
   IF g_isaf.isaf056 = '1' THEN 
      #LET l_sql = l_sql," AND xmdk000 IN ('1','2','3')"
   ELSE
      LET l_sql = l_sql," AND xmdk000 = '6' "
   END IF
   IF g_input.type = '2' THEN
      LET l_sql = l_sql," AND ",g_wc
   END IF
   #161206-00042#2-----s
   #IF NOT cl_null(g_isaf.isaf067)THEN #170221-00030#1 mark
   IF g_pmaa004 = '2' THEN             #170221-00030#1
      LET g_qryparam.where = g_qryparam.where," AND xmdk047 = '",g_isaf.isaf067,"' "
   END IF
   #161206-00042#2-----e
   PREPARE aist310_01_pre2 FROM l_sql
   DECLARE aist310_01_cur2 CURSOR FOR aist310_01_pre2
   FOREACH aist310_01_cur2 INTO l_xmdk.xmdksite,l_xmdk.xmdk006,l_xmdk.xmdk010   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_xrca019 = ''
      #檢查訂金是否有產生待抵單(axrq342) or 認列收入(產生axrt300)
      CASE
         WHEN l_sfin2022 = '01'  #認列收入
            #161102-00039#1 mark ------
            ##SELECT DISTINCT xrcadocno INTO l_xrca019                   #160823-00016#1 mark
            #SELECT DISTINCT xrcadocno,xrca060 ,
            #                xrcald,xrca012    #161005-00018#3
            #  INTO l_xrca019,l_xrca060, #160823-00016#1
            #       l_xrcald,l_xrca012   #161005-00018#3
            #  FROM xrca_t
            #  LEFT JOIN xrcb_t ON xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld
            #  LEFT JOIN xrcc_t ON xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald = xrccld
            # WHERE xrcaent = g_enterprise
            #   AND xrca001 = '17'
            #   AND xrca016 = '10'
            #   AND xrcb002 = l_xmdk.xmdk006    #訂單單號
            #   AND xrcastus = 'Y'
            #   #AND xrcc108 - xrcc109 > 0       #160823-00016#1 mark
            #   AND xrcadocdt <= g_isaf.isafdocdt
            #   AND xrca004 = g_isaf.isaf003
            #161102-00039#1 mark end---
            #161102-00039#1 add ------
            LET l_sql = "SELECT DISTINCT xrcadocno,xrca060,xrcald,xrca012",
                        "  FROM xrca_t",
                        "  LEFT JOIN xrcb_t ON xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld",
                        "  LEFT JOIN xrcc_t ON xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald = xrccld",
                        " WHERE xrcaent = ",g_enterprise,
                        "   AND xrca001 = '17'",
                        #"   AND xrca016 = '10'",        #161123-00012#1 mark
                        "   AND xrca016 IN ('10','12')", #161123-00012#1 add
                        "   AND xrcb002 = '",l_xmdk.xmdk006,"'",    #訂單單號
                        "   AND xrcastus = 'Y'",
                        "   AND xrcadocdt <= '",g_isaf.isafdocdt,"'",
                        "   AND xrca004 = '",g_isaf.isaf003,"'"     #帳款客戶
            #161102-00039#1 add end---
         WHEN l_sfin2022 = '02'  #認列預收
            #161102-00039#1 mark ------
            ##SELECT DISTINCT xrca019 INTO l_xrca019                   #160823-00016#1 mark
            #SELECT DISTINCT xrca019,xrca060,
            #                xrcald,xrca012    #161005-00018#3
            #  INTO l_xrca019,l_xrca060, #160823-00016#1
            #       l_xrcald,l_xrca012   #161005-00018#3
            #  FROM xrca_t
            #  LEFT JOIN xrcb_t ON xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld
            #  LEFT JOIN xrcc_t ON xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald = xrccld
            # WHERE xrcaent = g_enterprise
            #   AND xrca001 = '11'
            #   AND xrca016 = '10'
            #   AND xrcb002 = l_xmdk.xmdk006     #訂單單號
            #   AND xrcastus = 'Y'
            #   AND xrca019 IS NOT NULL          #待抵單號不可空
            #  #AND xrcc108 - xrcc109 > 0        #160823-00016#1 mark
            #   AND xrcc108 - xrcc109 = 0        #160823-00016#1
            #   AND xrcadocdt <= g_isaf.isafdocdt
            #   AND xrca004 = g_isaf.isaf003
            #161102-00039#1 mark end---
            #161102-00039#1 add ------
            LET l_sql = "SELECT DISTINCT xrca019,xrca060,xrcald,xrca012",
                        "  FROM xrca_t",
                        "  LEFT JOIN xrcb_t ON xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld",
                        "  LEFT JOIN xrcc_t ON xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald = xrccld",
                        " WHERE xrcaent = ",g_enterprise,
                        "   AND xrca001 = '11'",
                        #"   AND xrca016 = '10'",        #161123-00012#1 mark
                        "   AND xrca016 IN ('10','12')", #161123-00012#1 add
                        "   AND xrcb002 = '",l_xmdk.xmdk006,"'", #訂單單號
                        "   AND xrcastus = 'Y'",
                        "   AND xrca019 IS NOT NULL",            #待抵單號不可空
                        "   AND xrcc108 - xrcc109 = 0",
                        "   AND xrcadocdt <= '",g_isaf.isafdocdt,"'",
                        "   AND xrca004 = '",g_isaf.isaf003,"'"
            #161102-00039#1 add end---
      END CASE
      #161102-00039#1 add ------
      PREPARE aist310_01_pre6 FROM l_sql
      DECLARE aist310_01_cur6 CURSOR FOR aist310_01_pre6
      FOREACH aist310_01_cur6 INTO l_xrca019,l_xrca060,l_xrcald,l_xrca012
      #161102-00039#1 add end---
         IF NOT cl_null(l_xrca019) THEN
            LET l_sql = "SELECT xrcc108-xrcc109,xrcc118-xrcc119+xrcc113,xrccseq ",
                        "  FROM xrcc_t",
                        " WHERE xrccent = ",g_enterprise,
                        "   AND xrccdocno ='",l_xrca019,"'"
            PREPARE aist310_01_pre3 FROM l_sql
            DECLARE aist310_01_cur3 CURSOR FOR aist310_01_pre3
            FOREACH aist310_01_cur3 INTO l_isag105,l_isag115,l_xrccseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT FOREACH
               END IF
            
               SELECT SUM(isag105),SUM(isag115) INTO l_isag105_sum,l_isag115_sum 
                 FROM isag_t,isaf_t
                WHERE isagent = g_enterprise
                  AND isag002 = l_xrca019
                  AND isag003 = l_xrccseq
                  AND isafent = isagent AND isafdocno = isagdocno AND isafcomp = isafcomp
                  AND isafstus = 'N'
                  #AND ((isafdocno = g_isaf_m.isafdocno
                  #AND isagseq <> g_isag_d[l_ac].isagseq)
                  # OR isafdocno <> g_isaf_m.isafdocno)
               IF cl_null(l_isag105_sum) THEN LET l_isag105_sum = 0 END IF
               IF cl_null(l_isag115_sum) THEN LET l_isag115_sum = 0 END IF
               LET l_isag.isag105 = l_isag105 - l_isag105_sum
               LET l_isag.isag115 = l_isag115 - l_isag115_sum
               IF l_isag.isag105 = 0 THEN
                  CONTINUE FOREACH
               END IF
               #161005-00018#3 mark-----s
               #LET l_isag.isag103 = l_isag.isag105
               #LET l_isag.isag113 = l_isag.isag115
               #161005-00018#3 mark-----e
               
               #161005-00018#3-----s
               LET l_isag.isag103 = l_isag.isag105 /  (1 + l_xrca012 / 100) 
               CALL s_curr_round_ld('1',l_xrcald,g_isaf.isaf100,l_isag.isag103,2) RETURNING g_sub_success,g_errno,l_isag.isag103
               LET l_isag.isag104 = l_isag.isag105 - l_isag.isag103
               
               LET l_isag.isag113 = l_isag.isag115 /  (1 + l_xrca012 / 100) 
               CALL s_curr_round_ld('1',l_xrcald,g_isaf.isaf100,l_isag.isag113,2) RETURNING g_sub_success,g_errno,l_isag.isag113
               LET l_isag.isag114 = l_isag.isag115 - l_isag.isag113            
               #161005-00018#3-----e
               
            
               SELECT MAX(isagseq) INTO l_isag.isagseq
                 FROM isag_t
                WHERE isagent = g_enterprise
                  AND isagdocno = g_isaf.isafdocno
                  AND isagcomp = g_isaf.isafcomp
               IF cl_null(l_isag.isagseq) THEN 
                 LET l_isag.isagseq = 1
               ELSE
                  LET l_isag.isagseq = l_isag.isagseq + 1
               END IF
               
               LET l_isag.isagent = g_enterprise
               LET l_isag.isagcomp = g_isaf.isafcomp
               LET l_isag.isagdocno = g_isaf.isafdocno
               LET l_isag.isagorga = l_xmdk.xmdksite
               CASE
                  WHEN l_sfin2022 = '01'  #認列收入
                     LET l_isag.isag001 = '29'   #其他減項
                  WHEN l_sfin2022 = '02'  #認列預收
                     LET l_isag.isag001 = '27'   #其他待抵單
               END CASE
               LET l_isag.isag002 = l_xrca019
               LET l_isag.isag003 = l_xrccseq
               LET l_isag.isag006 = g_isaf.isaf016
               LET l_isag.isag012 = l_xmdk.xmdk010
               LET l_isag.isag015 = -1
               
               #160823-00016#1-s
               #訂金已開發票
               CASE
                  WHEN l_xrca060 = '1'  #1:不開立發票
                     LET l_isag.isag018 = 'N'
                  WHEN l_xrca060 = '2'  #2:應開立發票
                     LET l_isag.isag018 = 'Y'
                  WHEN l_xrca060 = '3'  #3:普通收據
                     LET l_isag.isag018 = 'N'
               END CASE
               #160823-00016#1-e
               
               #160823-00016#1 add isag018
               INSERT INTO isag_t(isagent,isagcomp,isagdocno,isagseq,isagorga,
                                  isag001,isag002,isag003,isag004,isag005,
                                  isag006,isag007,isag008,isag009,isag010,
                                  isag011,isag012,isag013,isag014,isag015,
                                  isag016,isag017,isag101,isag103,isag104,
                                  isag105,isag113,isag114,isag115,isag018)
                           VALUES(g_enterprise,l_isag.isagcomp,l_isag.isagdocno,l_isag.isagseq,l_isag.isagorga,
                                  l_isag.isag001,l_isag.isag002,l_isag.isag003,l_isag.isag004,l_isag.isag005,
                                  l_isag.isag006,l_isag.isag007,l_isag.isag008,l_isag.isag009,l_isag.isag010,
                                  l_isag.isag011,l_isag.isag012,l_isag.isag013,l_isag.isag014,l_isag.isag015,
                                  l_isag.isag016,l_isag.isag017,l_isag.isag101,l_isag.isag103,l_isag.isag104,
                                  l_isag.isag105,l_isag.isag113,l_isag.isag114,l_isag.isag115,l_isag.isag018)
               IF SQLCA.SQLcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "isag_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END FOREACH
         END IF
      END FOREACH #161102-00039#1
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 訂單資料新增
# Memo...........: #160223-00002#3
# Usage..........: CALL aist310_01_isag_ins_10()
# Date & Author..: 2016/07/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aist310_01_isag_ins_10()
   DEFINE l_sql                STRING
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_isag004            LIKE isag_t.isag004
  #DEFINE l_isag               RECORD LIKE isag_t.* #161104-00024#10 mark
   #161104-00024#10 --s add
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
          isagud001 LIKE isag_t.isagud001, #自定義欄位(文字)001
          isagud002 LIKE isag_t.isagud002, #自定義欄位(文字)002
          isagud003 LIKE isag_t.isagud003, #自定義欄位(文字)003
          isagud004 LIKE isag_t.isagud004, #自定義欄位(文字)004
          isagud005 LIKE isag_t.isagud005, #自定義欄位(文字)005
          isagud006 LIKE isag_t.isagud006, #自定義欄位(文字)006
          isagud007 LIKE isag_t.isagud007, #自定義欄位(文字)007
          isagud008 LIKE isag_t.isagud008, #自定義欄位(文字)008
          isagud009 LIKE isag_t.isagud009, #自定義欄位(文字)009
          isagud010 LIKE isag_t.isagud010, #自定義欄位(文字)010
          isagud011 LIKE isag_t.isagud011, #自定義欄位(數字)011
          isagud012 LIKE isag_t.isagud012, #自定義欄位(數字)012
          isagud013 LIKE isag_t.isagud013, #自定義欄位(數字)013
          isagud014 LIKE isag_t.isagud014, #自定義欄位(數字)014
          isagud015 LIKE isag_t.isagud015, #自定義欄位(數字)015
          isagud016 LIKE isag_t.isagud016, #自定義欄位(數字)016
          isagud017 LIKE isag_t.isagud017, #自定義欄位(數字)017
          isagud018 LIKE isag_t.isagud018, #自定義欄位(數字)018
          isagud019 LIKE isag_t.isagud019, #自定義欄位(數字)019
          isagud020 LIKE isag_t.isagud020, #自定義欄位(數字)020
          isagud021 LIKE isag_t.isagud021, #自定義欄位(日期時間)021
          isagud022 LIKE isag_t.isagud022, #自定義欄位(日期時間)022
          isagud023 LIKE isag_t.isagud023, #自定義欄位(日期時間)023
          isagud024 LIKE isag_t.isagud024, #自定義欄位(日期時間)024
          isagud025 LIKE isag_t.isagud025, #自定義欄位(日期時間)025
          isagud026 LIKE isag_t.isagud026, #自定義欄位(日期時間)026
          isagud027 LIKE isag_t.isagud027, #自定義欄位(日期時間)027
          isagud028 LIKE isag_t.isagud028, #自定義欄位(日期時間)028
          isagud029 LIKE isag_t.isagud029, #自定義欄位(日期時間)029
          isagud030 LIKE isag_t.isagud030, #自定義欄位(日期時間)030
          isag018 LIKE isag_t.isag018  #訂金已開發票
   END RECORD
   #161104-00024#10 --e add
   DEFINE r_xrcd123            LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124            LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125            LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133            LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134            LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135            LIKE xrcd_t.xrcd115
   DEFINE l_xmdc016            LIKE xmdc_t.xmdc016    #160322-00027#3 add lujh
   DEFINE l_isag105            LIKE isag_t.isag105
   DEFINE l_isagseq            LIKE isag_t.isagseq
   DEFINE l_xmdb006            LIKE xmdb_t.xmdb006
   DEFINE l_tmp                RECORD
                               num            LIKE type_t.num5,
                               xmdcsite       LIKE xmdc_t.xmdcsite,
                               type           LIKE type_t.chr20,
                               xmdadocno      LIKE xmda_t.xmdadocno,   #订单单号
                               xmdb001        LIKE xmdb_t.xmdb001,     #期别
                               xmdcseq        LIKE xmdc_t.xmdcseq,     #项次
                               xmdc010        LIKE xmdc_t.xmdc010,     #计价单位
                               xmda011        LIKE xmda_t.xmda011,     #税别
                               oodb005        LIKE oodb_t.oodb005,     #含税否
                               oodb006        LIKE oodb_t.oodb006,     #税率
                               xmda009        LIKE xmda_t.xmda009,     #收款条件
                               xmdc015        LIKE xmdc_t.xmdc015,     #单价
                               xmda016        LIKE xmda_t.xmda016,     #汇率
                               amt            LIKE xmdc_t.xmdc047,     #金額 
                               qty            LIKE xmdc_t.xmdc011,     #數量
                               #160517-00001#7 Add  ---(S)---
                               xmdc011        LIKE xmdc_t.xmdc011,
                               xmdc046        LIKE xmdc_t.xmdc046,
                               xmdc047        LIKE xmdc_t.xmdc047,
                               xmdc048        LIKE xmdc_t.xmdc048,
                               flag           LIKE type_t.chr1
                               #160517-00001#7 Add  ---(E)---
                               END RECORD
   DEFINE l_flag               LIKE type_t.chr1
   DEFINE l_xmdadocno          LIKE xmda_t.xmdadocno
   DEFINE l_xmdb001            LIKE xmdb_t.xmdb001    #161214-00053#1
   
   WHENEVER ERROR CONTINUE  #160823-00016#1
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_flag = 'N'

   #LET l_sql = "SELECT xmdadocno",        #161214-00053#1 mark
   LET l_sql = "SELECT xmdadocno,xmdb001", #161214-00053#1
               "  FROM xmda_t",
               "  LEFT JOIN xmdb_t ON xmdaent=xmdbent AND xmdadocno=xmdbdocno",
               " WHERE xmdaent = ",g_enterprise,
              #"   AND xmdastus = 'S'",  #160823-00016#1 mark
               "   AND xmdastus = 'Y'",  #160823-00016#1
               "   AND xmda004 = '",g_isaf.isaf003,"'",
               "   AND xmdb016 IN ('1','2')",
               "   AND xmdasite IN (",g_origin_str CLIPPED,")"
   IF NOT cl_null(g_wc) THEN
      CALL s_chr_replace(g_wc,'xmdkdocno','xmdadocno',0) RETURNING g_wc
      CALL s_chr_replace(g_wc,'xmdkdocdt','xmdadocdt',0) RETURNING g_wc
      CALL s_chr_replace(g_wc,'xmdksite','xmdasite',0) RETURNING g_wc
      LET l_sql = l_sql," AND ",g_wc
   END IF
   PREPARE aist310_01_pre4 FROM l_sql
   DECLARE aist310_01_cur4 CURSOR FOR aist310_01_pre4
   #FOREACH aist310_01_cur4 INTO l_xmdadocno          #161214-00053#1 mark
   FOREACH aist310_01_cur4 INTO l_xmdadocno,l_xmdb001 #161214-00053#1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aist310_01_cur4'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #CALL s_dep_pay(l_xmdadocno,'1',g_isaf.isaf016,g_isaf.isafsite,g_isaf.isaf101,'') RETURNING l_success      #161214-00053#1 mark
      CALL s_dep_pay(l_xmdadocno,l_xmdb001,g_isaf.isaf016,g_isaf.isafsite,g_isaf.isaf101,'') RETURNING l_success #161214-00053#1
      IF l_success = FALSE THEN 
         RETURN l_success
      END IF
   
      LET l_sql = "SELECT * FROM s_dep_pay_tmp "
      PREPARE aist310_01_s_dep_pay_tmp_pr FROM l_sql
      DECLARE aist310_01_s_dep_pay_tmp_cs CURSOR FOR aist310_01_s_dep_pay_tmp_pr
      
      FOREACH aist310_01_s_dep_pay_tmp_cs INTO l_tmp.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aist310_01_s_dep_pay_tmp_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         SELECT MAX(isagseq)+1 INTO l_isag.isagseq
           FROM isag_t
          WHERE isagent = g_enterprise
            AND isagcomp = g_isaf.isafcomp
            AND isagdocno = g_isaf.isafdocno
         IF cl_null(l_isag.isagseq) THEN LET l_isag.isagseq = 1 END IF
   
         SELECT xmdc001,xmda009,xmdc027,xmdc016    #160322-00027#3 add xmdc016 lujh
           INTO l_isag.isag009,l_isag.isag012,l_isag.isag016,l_xmdc016    #160322-00027#3 add l_xmdc016 lujh
           FROM xmda_t,xmdc_t
          WHERE xmdaent = g_enterprise
            AND xmdaent = xmdcent
            AND xmdadocno = xmdcdocno
            AND xmdadocno = l_tmp.xmdadocno
            AND xmdcseq = l_tmp.xmdcseq
            
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_isag.isag009
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET l_isag.isag010 = '', g_rtn_fields[1] , ''
         
         SELECT gzcb004 INTO l_isag.isag015
           FROM gzcb_t
          WHERE gzcb001 = '8341' AND gzcb002 = '10'
   
         LET l_isag.isagent   = g_enterprise
         LET l_isag.isagcomp  = g_isaf.isafcomp
         LET l_isag.isagdocno = g_isaf.isafdocno
         LET l_isag.isagorga  = l_tmp.xmdcsite
         LET l_isag.isag001   = '10'
         LET l_isag.isag002   = l_tmp.xmdadocno
         LET l_isag.isag003   = l_tmp.xmdcseq
         LET l_isag.isag005   = l_tmp.xmdc010
         LET l_isag.isag006   = l_xmdc016           #160322-00027#3 change l_tmp.xmda011 to xmdc016 lujh
         LET l_isag.isag007   = l_tmp.oodb005
         LET l_isag.isag008   = l_tmp.oodb006
         LET l_isag.isag011   = l_tmp.xmdb001
         LET l_isag.isag101   = l_tmp.xmdc015
         
         SELECT SUM(isag004) INTO l_isag004
           FROM isag_t,isaf_t
          WHERE isagent = g_enterprise
            AND isag002 = l_isag.isag002
            AND isag003 = l_isag.isag003
            AND isafent = isagent
            AND isafdocno = isagdocno
            AND isafcomp = isafcomp 
            AND isag011 = l_isag.isag011
            AND isafstus <> 'X'
         IF cl_null(l_isag004) THEN LET l_isag004 = 0 END IF
        #160517-00001#7 Mark ---(S)---
        #IF cl_null(l_tmp.qty) THEN LET l_tmp.qty = 0 END IF
   	  #LET l_isag.isag004 = l_tmp.qty - l_isag004
        #160517-00001#7 Mark ---(E)---
        #160517-00001#7 Add  ---(S)---
         IF cl_null(l_tmp.xmdc011) THEN LET l_tmp.xmdc011 = 0 END IF
	   
        LET l_isag.isag004 = l_tmp.xmdc011 - l_isag004
        #160517-00001#7 Add  ---(E)---
         IF l_isag.isag004 = 0 THEN 
            #20160427--add--str--lujh
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "ais-00315"
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            #20160427--add--end--lujh
            CONTINUE FOREACH
         END IF
         
         #160517-00001#7 Mark ---(S)---
         #CALL s_tax_ins(g_isaf.isafdocno,l_isag.isagseq,0,l_isag.isagorga,
         #               l_tmp.amt,l_isag.isag006,
         #               l_isag.isag004,g_isaf.isaf100,g_isaf.isaf101,g_glaald,0,0)
         #  RETURNING l_isag.isag103,l_isag.isag104,l_isag.isag105,
         #            l_isag.isag113,l_isag.isag114,l_isag.isag115,
         #            r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
         #160517-00001#7 Mark ---(E)---
         #160517-00001#7 Add  ---(S)---
         LET l_isag.isag103 = l_tmp.xmdc046
         LET l_isag.isag104 = l_tmp.xmdc048
         LET l_isag.isag105 = l_tmp.xmdc047
         LET l_isag.isag113 = l_isag.isag103 * g_isaf.isaf101
         LET l_isag.isag114 = l_isag.isag104 * g_isaf.isaf101
         LET l_isag.isag115 = l_isag.isag105 * g_isaf.isaf101

         DROP TABLE aist310_detail
         SELECT * FROM xrcd_t WHERE xrcdent = g_enterprise
            AND xrcddocno = l_tmp.xmdadocno
            AND xrcdseq   = l_tmp.xmdcseq
         INTO TEMP aist310_detail
         UPDATE aist310_detail SET xrcddocno = l_isag.isagdocno,xrcdseq = l_isag.isagseq
         INSERT INTO xrcd_t SELECT * FROM aist310_detail
         DROP TABLE aist310_detail

         UPDATE xrcd_t SET xrcd103 = l_isag.isag103,
                           xrcd104 = l_isag.isag104,
                           xrcd105 = l_isag.isag105,
                           xrcd113 = l_isag.isag113,
                           xrcd114 = l_isag.isag114,
                           xrcd115 = l_isag.isag115
          WHERE xrcdent   = g_enterprise
            AND xrcddocno = l_isag.isagdocno
            AND xrcdseq   = l_isag.isagseq

         #160517-00001#7 Add  ---(E)---
         
        #INSERT INTO isag_t VALUES(l_isag.*) #161108-00017#6 mark
         #161108-00017#6 --s add
         INSERT INTO isag_t(isagent,isagcomp,isagdocno,isagseq,isagorga,
                            isag001,isag002,isag003,isag004,isag005,
                            isag006,isag007,isag008,isag009,isag010,
                            isag011,isag012,isag013,isag014,isag015,
                            isag016,isag017,isag101,isag103,isag104,
                            isag105,isag106,isag113,isag114,isag115,
                            isag116,isag117,isag126,isag127,isag128,
                            isag136,isag137,isag138,isagud001,isagud002,
                            isagud003,isagud004,isagud005,isagud006,isagud007,
                            isagud008,isagud009,isagud010,isagud011,isagud012,
                            isagud013,isagud014,isagud015,isagud016,isagud017,
                            isagud018,isagud019,isagud020,isagud021,isagud022,
                            isagud023,isagud024,isagud025,isagud026,isagud027,
                            isagud028,isagud029,isagud030,isag018)
         VALUES(l_isag.isagent,l_isag.isagcomp,l_isag.isagdocno,l_isag.isagseq,l_isag.isagorga,
                l_isag.isag001,l_isag.isag002,l_isag.isag003,l_isag.isag004,l_isag.isag005,
                l_isag.isag006,l_isag.isag007,l_isag.isag008,l_isag.isag009,l_isag.isag010,
                l_isag.isag011,l_isag.isag012,l_isag.isag013,l_isag.isag014,l_isag.isag015,
                l_isag.isag016,l_isag.isag017,l_isag.isag101,l_isag.isag103,l_isag.isag104,
                l_isag.isag105,l_isag.isag106,l_isag.isag113,l_isag.isag114,l_isag.isag115,
                l_isag.isag116,l_isag.isag117,l_isag.isag126,l_isag.isag127,l_isag.isag128,
                l_isag.isag136,l_isag.isag137,l_isag.isag138,l_isag.isagud001,l_isag.isagud002,
                l_isag.isagud003,l_isag.isagud004,l_isag.isagud005,l_isag.isagud006,l_isag.isagud007,
                l_isag.isagud008,l_isag.isagud009,l_isag.isagud010,l_isag.isagud011,l_isag.isagud012,
                l_isag.isagud013,l_isag.isagud014,l_isag.isagud015,l_isag.isagud016,l_isag.isagud017,
                l_isag.isagud018,l_isag.isagud019,l_isag.isagud020,l_isag.isagud021,l_isag.isagud022,
                l_isag.isagud023,l_isag.isagud024,l_isag.isagud025,l_isag.isagud026,l_isag.isagud027,
                l_isag.isagud028,l_isag.isagud029,l_isag.isagud030,l_isag.isag018)
         #161108-00017#6 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert isag_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END FOREACH
      
      LET l_isag105 = 0
      SELECT SUM(isag105) INTO l_isag105 FROM isag_t
       WHERE isagent = g_enterprise AND isagdocno = g_isaf.isafdocno
         AND isagcomp = g_isaf.isafcomp
      IF cl_null(l_isag105) THEN LET l_isag105 = 0 END IF
   
      LET l_xmdb006 = 0
      #161214-00053#1 mark ------
      #SELECT xmdb006 INTO l_xmdb006 FROM xmdb_t
      # WHERE xmdbent = g_enterprise AND xmdbdocno = l_xmdadocno AND xmdb001 = '1'
      #161214-00053#1 mark end---
      #161214-00053#1 add ------
      SELECT SUM(xmdb006) INTO l_xmdb006 FROM xmdb_t
       WHERE xmdbent = g_enterprise AND xmdbdocno = l_xmdadocno AND xmdb016 IN ('1','2')
      #161214-00053#1 add end---
      IF cl_null(l_xmdb006) THEN LET l_xmdb006 = 0 END IF
   
      #訂金金額和发票金額存在差異
      IF l_isag105 <> l_xmdb006 THEN
         SELECT isagseq INTO l_isagseq FROM isag_t
          WHERE isagent = g_enterprise AND isagdocno = g_isaf.isafdocno AND isagcomp = g_isaf.isafcomp
            AND isag105 = (SELECT MAX(isag105) FROM isag_t WHERE isagent = g_enterprise
                              AND isagdocno = g_isaf.isafdocno AND isagcomp = g_isaf.isafcomp)
         IF cl_null(l_isagseq) THEN LET l_isagseq = 1 END IF
         #將差異金額放入應收單據單身金額最大的一筆的含稅金額中
         LET l_isag105 = l_xmdb006 - l_isag105
         UPDATE isag_t SET isag103 = isag103 + l_isag105,
                           isag105 = isag105 + l_isag105
          WHERE isagent = g_enterprise
            AND isagdocno = g_isaf.isafdocno
            AND isagcomp = g_isaf.isafcomp
            AND isagseq = l_isagseq
         UPDATE isag_t SET isag113 = isag103 * g_isaf.isaf101,
                           isag115 = isag105 * g_isaf.isaf101
          WHERE isagent = g_enterprise
            AND isagdocno = g_isaf.isafdocno
            AND isagcomp = g_isaf.isafcomp
            AND isagseq = l_isagseq
      END IF
      LET l_flag = 'Y'
   END FOREACH
   
   CALL cl_err_collect_show()
   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 整批產生門店銷售單or門店銷退單
# Memo...........: #160223-00002#3
# Usage..........: CALL aist310_01_isag_ins_1322()
# Date & Author..: 2016/07/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aist310_01_isag_ins_1322()
DEFINE l_sql         STRING
DEFINE l_success     LIKE type_t.num5
DEFINE l_flag        LIKE type_t.chr1
DEFINE l_rtiadocno   LIKE rtia_t.rtiadocno
DEFINE l_array       DYNAMIC ARRAY OF RECORD
                        chr  LIKE type_t.chr1000,
                        dat  LIKE type_t.dat
                     END RECORD
   
   WHENEVER ERROR CONTINUE #160823-00016#1
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_flag = 'N'
   
   LET l_sql = "SELECT rtiadocno",
               "  FROM rtia_t",
               " WHERE rtiaent = ",g_enterprise,
               "   AND rtiastus = 'S'",
               "   AND rtiasite IN (",g_origin_str CLIPPED,")",
               #"   AND rtia032 = '1'", #1:ERP  #161024-00065#2 mark
               "   AND rtia014 IS NULL AND rtia015 IS NULL",
               "   AND NOT EXISTS (SELECT 1 FROM isaf_t ",
               "                   LEFT JOIN isag_t ON isafent=isagent AND isafcomp=isagcomp AND isafdocno=isagdocno",
               "                  WHERE isagent = rtiaent AND isag002 = rtiadocno ",
               "                    AND isafstus <> 'X') ",
               "   AND rtia000 IN ('artt600','artt610','artt620','artt700')"
   IF NOT cl_null(g_wc) THEN
      CALL s_chr_replace(g_wc,'xmdkdocno','rtiadocno',0) RETURNING g_wc
      CALL s_chr_replace(g_wc,'xmdkdocdt','rtiadocdt',0) RETURNING g_wc
      CALL s_chr_replace(g_wc,'xmdksite','rtiasite',0) RETURNING g_wc
      LET l_sql = l_sql," AND ",g_wc
   END IF
   #161024-00065#2 add ------
   IF g_sfin2023 = '1' THEN
      LET l_sql = l_sql," AND rtia032 IN ('1','4')" #1:ERP+4:日結
   ELSE
      LET l_sql = l_sql," AND rtia032 IN ('1')"
   END IF
   #161024-00065#2 add end---
   PREPARE aist310_01_pre5 FROM l_sql
   DECLARE aist310_01_cur5 CURSOR FOR aist310_01_pre5
   FOREACH aist310_01_cur5 INTO l_rtiadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aist310_01_cur5'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      CALL l_array.clear()
      LET l_array[1].chr  = g_isaf.isafdocno  #對帳單號
      LET l_array[2].chr  = l_rtiadocno       #門店銷售單號
      LET l_array[3].chr  = g_isaf.isaf056    #發票性質
      CALL s_aisp390_ins_isag(l_array) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET l_success = FALSE
      END IF
      
      LET l_flag = 'Y'
   END FOREACH
   
   CALL cl_err_collect_show()
   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 參考isag正負值處理xrcd總額計算
# Memo...........: 呼叫元件前請先CALL s_tax_recount_tmp()
# Usage..........:
# Date & Author..: #170215-00049#1 170215 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aist310_01_tax_recount(p_xrcddocno)
DEFINE p_xrcddocno   LIKE type_t.chr50
DEFINE l_xrcdseq2    LIKE xrcd_t.xrcdseq2
DEFINE l_docno       STRING
DEFINE l_seq2        STRING
DEFINE l_i           LIKE type_t.num5
DEFINE l_e           LIKE type_t.num5
DEFINE r_xrcd103     LIKE xrcd_t.xrcd103
DEFINE r_xrcd104     LIKE xrcd_t.xrcd104
DEFINE r_xrcd105     LIKE xrcd_t.xrcd105
DEFINE r_xrcd113     LIKE xrcd_t.xrcd113
DEFINE r_xrcd114     LIKE xrcd_t.xrcd114
DEFINE r_xrcd115     LIKE xrcd_t.xrcd115
DEFINE diff_xrcd103  LIKE xrcd_t.xrcd103
DEFINE diff_xrcd104  LIKE xrcd_t.xrcd104
DEFINE l_xrcd  RECORD
   xrcdsite   LIKE xrcd_t.xrcdsite,  #營運據點
   xrcdld     LIKE xrcd_t.xrcdld,    #帳別
   xrcdseq    LIKE xrcd_t.xrcdseq,   #項次
   xrcdseq2   LIKE xrcd_t.xrcdseq2,  #項序
   xrcd002    LIKE xrcd_t.xrcd002,   #稅別
   xrcd003    LIKE xrcd_t.xrcd003,   #稅率
   xrcd004    LIKE xrcd_t.xrcd004,   #固定課稅金額
   xrcd005    LIKE xrcd_t.xrcd005,   #課稅數量
   xrcd006    LIKE xrcd_t.xrcd006,   #含稅否
   xrcd007    LIKE xrcd_t.xrcd007,   #計算序
   xrcd100    LIKE xrcd_t.xrcd100,   #幣別
   xrcd101    LIKE xrcd_t.xrcd101,   #匯率
   xrcd103    LIKE xrcd_t.xrcd103,   #原幣未稅金額
   xrcd104    LIKE xrcd_t.xrcd104,   #原幣稅額
   xrcd105    LIKE xrcd_t.xrcd105,   #原幣含稅金額
   xrcd121    LIKE xrcd_t.xrcd121,   #本位幣二匯率
   xrcd131    LIKE xrcd_t.xrcd131,   #本位幣三匯率
   xrcd123    LIKE xrcd_t.xrcd113,   #本位幣二未稅金額
   xrcd124    LIKE xrcd_t.xrcd124,   #本位幣二稅額
   xrcd125    LIKE xrcd_t.xrcd115,   #本位幣二含稅金額
   xrcd133    LIKE xrcd_t.xrcd113,   #本位幣三未稅金額
   xrcd134    LIKE xrcd_t.xrcd134,   #本位幣三稅額
   xrcd135    LIKE xrcd_t.xrcd115    #本位幣三含稅金額
            END RECORD
DEFINE l_xrcd002     LIKE xrcd_t.xrcd002   #稅別
DEFINE l_ooef016     LIKE ooef_t.ooef016   #主幣別編號
DEFINE l_ooef017     LIKE ooef_t.ooef017   #法人
DEFINE l_ooef019     LIKE ooef_t.ooef019   #稅區
DEFINE l_oodb003     LIKE oodb_t.oodb003   #稅種
DEFINE l_oodb007     LIKE oodb_t.oodb007   #公式代碼
DEFINE l_oodb008     LIKE oodb_t.oodb008   #課稅別
DEFINE l_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_xrcd103_s   LIKE xrcd_t.xrcd103
DEFINE l_xrcd104_s   LIKE xrcd_t.xrcd104
DEFINE l_row_no      LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_xrcdsite    LIKE xrcd_t.xrcdsite


   WHENEVER ERROR CONTINUE

   LET g_sub_success = TRUE
   LET r_xrcd103 = 0
   LET r_xrcd104 = 0
   LET r_xrcd105 = 0
   LET r_xrcd113 = 0
   LET r_xrcd114 = 0
   LET r_xrcd115 = 0
   
   IF cl_null(p_xrcddocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00344'
      LET g_errparam.extend = p_xrcddocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_sub_success = FALSE
      RETURN r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115
   END IF
 
   #單號加傳變更序當key值，用|判斷，如果有|，表示有傳變更序值進來，需多串變更序
   LET l_docno = p_xrcddocno
   LET l_seq2 = ''
   LET l_i = 0
   LET l_e = 0
   LET l_i = l_docno.getIndexOf("|",1)
   LET l_e = l_docno.getLength()
   IF l_i > 0 THEN
      LET l_seq2 = l_docno.subString(l_i +1,l_e)
      LET l_docno = l_docno.subString(1,l_i -1)
      LET p_xrcddocno = l_docno
   ELSE
      LET l_seq2 = 0     
   END IF
   LET l_xrcdseq2 = l_seq2

   IF NOT s_transaction_chk('Y',1) THEN
      LET g_sub_success = FALSE
      RETURN r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115
   END IF
   
   INITIALIZE l_xrcd.* TO NULL
   LET l_xrcd002 = ''
   #項次0 表示整單發票調整額,不再重計
   DECLARE xrcd_cur CURSOR FOR
      SELECT DISTINCT xrcdsite,xrcd002,xrcd003,xrcd005,xrcd006,xrcd100,xrcd101 #160716-00007#1 add DISTINCT
        FROM xrcd_t
       WHERE xrcddocno = p_xrcddocno
         AND xrcdent = g_enterprise
         AND xrcdseq != 0
         AND xrcdseq2 = l_xrcdseq2                 #20150106 polly add
       ORDER BY xrcd002 
   FOREACH xrcd_cur INTO l_xrcd.xrcdsite,l_xrcd.xrcd002,l_xrcd.xrcd003,
                         l_xrcd.xrcd005,l_xrcd.xrcd006,l_xrcd.xrcd100,l_xrcd.xrcd101
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_sub_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT cl_null(l_xrcd002) AND l_xrcd002 = l_xrcd.xrcd002 THEN
         CONTINUE FOREACH
      END IF
      
      SELECT sum(xrcd103*isag015),sum(xrcd105*isag015)
        INTO l_xrcd.xrcd103,l_xrcd.xrcd105
        FROM xrcd_t,isag_t
       WHERE xrcd002 = l_xrcd.xrcd002
         AND xrcddocno = p_xrcddocno
         AND xrcdseq2 = l_xrcdseq2                     #20150106 polly add
         AND xrcdent = g_enterprise
         AND isagent = xrcdent
         AND isagdocno = xrcddocno
         AND isagseq   = xrcdseq
      IF cl_null(l_xrcd.xrcd103) THEN LET l_xrcd.xrcd103 = 0 END IF
      IF cl_null(l_xrcd.xrcd105) THEN LET l_xrcd.xrcd105 = 0 END IF
      
      CALL s_tax_get_ooef(l_xrcd.xrcdsite) RETURNING l_success,l_ooef016,l_ooef017,l_ooef019
      
      LET l_oodb003 = ''
      LET l_oodb007 = ''
      LET l_oodb008 = ''
      SELECT oodb003,oodb007,oodb008
        INTO l_oodb003,l_oodb007,l_oodb008
        FROM oodb_t
       WHERE oodb002 = l_xrcd.xrcd002
         AND oodb001 = l_ooef019
         AND oodbent = g_enterprise
         
      LET r_xrcd103 = 0
      LET r_xrcd104 = 0
      IF cl_null(l_oodb007) THEN
         #未設公式代碼,但有稅率的稅別才重計
         IF l_oodb008 = '1' THEN
            CALL s_tax_no_formula(l_xrcd.xrcd103,l_xrcd.xrcd105,l_xrcd.xrcd100,l_xrcd.xrcd101,l_ooef016,l_ooef017,l_oodb003,l_xrcd.xrcd006,l_xrcd.xrcd003)
                 RETURNING r_xrcd103,r_xrcd104,r_xrcd105
         ELSE
            CONTINUE FOREACH
         END IF
      ELSE
         #公式依從價isan004 = '1' 的才重計
         LET l_cnt = ''
         SELECT COUNT(*) INTO l_cnt
           FROM isan_t
          WHERE isan004 = '1'
            AND isan002 = l_oodb007
            AND isan001 = l_ooef019
            AND isanent = g_enterprise
         IF cl_null(l_cnt) OR l_cnt = 0 THEN
            CONTINUE FOREACH
         ELSE
            CALL s_tax_formula(l_xrcd.xrcd103,l_xrcd.xrcd105,l_xrcd.xrcd005,l_xrcd.xrcd100,l_xrcd.xrcd101,l_ooef016,l_ooef017,l_ooef019,l_oodb003,l_xrcd.xrcd003,l_oodb007)
                 RETURNING l_xrcd.xrcd003,l_xrcd.xrcd004,r_xrcd103,r_xrcd104,r_xrcd105
         END IF
      END IF
      LET l_xrcd002 = l_xrcd.xrcd002
      INSERT INTO tax_tmp VALUES(l_xrcd.xrcd002,r_xrcd103,r_xrcd104)
      INITIALIZE l_xrcd.* TO NULL
   END FOREACH
   
   LET l_xrcd002 = ''
   DECLARE xrcd002_cur CURSOR FOR
      SELECT xrcd002 FROM tax_tmp
   FOREACH xrcd002_cur INTO l_xrcd002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_sub_success = FALSE
         EXIT FOREACH
      END IF
      
      #160716-00007#1--add--str--
      #1.当未税金额和差额存在差额时，抓取金额最大的10笔资料，按照比例分摊差额，当分摊完之后金额小于0时，金额赋值0
      LET l_xrcd.xrcd103 = 0
      LET l_xrcd.xrcd104 = 0
      SELECT sum(xrcd103*isag015),sum(xrcd104*isag015)
        INTO l_xrcd.xrcd103,l_xrcd.xrcd104
        FROM xrcd_t,isag_t
       WHERE xrcd002 = l_xrcd002
         AND xrcddocno = p_xrcddocno
         AND xrcdseq2 = l_xrcdseq2                   #20150106 polly add         
         AND xrcdent = g_enterprise
         AND xrcdent = isagent
         AND xrcddocno = isagdocno
         AND xrcdseq   = isagseq
      IF cl_null(l_xrcd.xrcd103) THEN LET l_xrcd.xrcd103 = 0 END IF 
      IF cl_null(l_xrcd.xrcd104) THEN LET l_xrcd.xrcd104 = 0 END IF
      #重新計算後的未稅金額、稅額
      LET r_xrcd103 = 0
      LET r_xrcd104 = 0
      SELECT sum(xrcd103),sum(xrcd104)
        INTO r_xrcd103,r_xrcd104
        FROM tax_tmp
       WHERE xrcd002 = l_xrcd002
      IF cl_null(r_xrcd103) THEN LET r_xrcd103 = 0 END IF 
      IF cl_null(r_xrcd104) THEN LET r_xrcd104 = 0 END IF 
     
      LET diff_xrcd103 = r_xrcd103 - l_xrcd.xrcd103
      LET diff_xrcd104 = r_xrcd104 - l_xrcd.xrcd104
      IF diff_xrcd103 != 0 OR diff_xrcd104 != 0 THEN
         #抓取金额最大10笔金额总计
         LET l_xrcd103_s=0
         LET l_xrcd104_s=0
         LET l_sql = "SELECT SUM(xrcd103),SUM(xrcd104)",
                     "  FROM (SELECT xrcd103,xrcd104,row_number() over (ORDER BY xrcd103 DESC,xrcd104 DESC) num",
                     "          FROM xrcd_t",
                     "         WHERE xrcd002 = '",l_xrcd002,"'",
                     "           AND xrcddocno = '",p_xrcddocno,"'",
                     "           AND xrcdseq2 = ",l_xrcdseq2,
                     "           AND xrcdent = ",g_enterprise,
                     "           ) xx",
                     " WHERE xx.num<=10"
         PREPARE s_tax_recount_sum_pr FROM l_sql
         EXECUTE s_tax_recount_sum_pr INTO l_xrcd103_s,l_xrcd104_s
         IF cl_null(l_xrcd103_s) THEN LET l_xrcd103_s=0 END IF
         IF cl_null(l_xrcd104_s) THEN LET l_xrcd104_s=0 END IF
         
         INITIALIZE l_xrcd.* TO NULL
         DECLARE upd_cur1 CURSOR FOR
            SELECT xrcdsite,xrcdld,xrcdseq,xrcdseq2,xrcd007,xrcd100,xrcd101,
                   xrcd103,xrcd104,xrcd121,xrcd131
              FROM xrcd_t
             WHERE xrcd002 = l_xrcd002
               AND xrcddocno = p_xrcddocno
               AND xrcdseq2 = l_xrcdseq2       
               AND xrcdent = g_enterprise
             ORDER BY xrcd103 DESC,xrcd104 DESC
         LET l_row_no=0
         FOREACH upd_cur1 INTO l_xrcd.xrcdsite,l_xrcd.xrcdld,l_xrcd.xrcdseq,l_xrcd.xrcdseq2,
                              l_xrcd.xrcd007,l_xrcd.xrcd100,l_xrcd.xrcd101,l_xrcd.xrcd103,
                              l_xrcd.xrcd104,l_xrcd.xrcd121,l_xrcd.xrcd131
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'foreach:upd_cur1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sub_success = FALSE
               EXIT FOREACH
            END IF
            IF cl_null(l_xrcd.xrcd103) THEN LET l_xrcd.xrcd103 = 0 END IF
            IF cl_null(l_xrcd.xrcd104) THEN LET l_xrcd.xrcd104 = 0 END IF
            #抓取税区等资料
            IF cl_null(l_xrcdsite) OR l_xrcdsite <> l_xrcd.xrcdsite THEN
               CALL s_tax_get_ooef(l_xrcd.xrcdsite) RETURNING l_success,l_ooef016,l_ooef017,l_ooef019
               LET l_xrcdsite = l_xrcd.xrcdsite
            END IF
            #未税金额有差额
            IF diff_xrcd103 <> 0 THEN
               LET l_xrcd.xrcd103 = l_xrcd.xrcd103 + diff_xrcd103 * l_xrcd.xrcd103 / l_xrcd103_s
               LET l_xrcd.xrcd103 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd103,2)
               IF l_xrcd.xrcd103 < 0 THEN
                  LET l_xrcd.xrcd103 = 0
               END IF
            END IF
            #税额有差额
            IF diff_xrcd104 <> 0 THEN
               LET l_xrcd.xrcd104 = l_xrcd.xrcd104 + diff_xrcd104 * l_xrcd.xrcd104 / l_xrcd104_s
               LET l_xrcd.xrcd104 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd104,2)
               IF l_xrcd.xrcd104 < 0 THEN
                  LET l_xrcd.xrcd104 = 0
               END IF 
            END IF
            #重新计算含税金额
            LET l_xrcd.xrcd105 = l_xrcd.xrcd103 + l_xrcd.xrcd104
            LET l_xrcd.xrcd105 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd105,2)
            #计算本币金额
            CALL s_tax_get_xrcd114(l_xrcd.xrcd103,l_xrcd.xrcd104,l_xrcd.xrcd101,l_ooef017,l_ooef016,l_xrcd002,l_ooef019)
                 RETURNING r_xrcd113,r_xrcd114,r_xrcd115
            #当账套启用其他本位币时，计算其他本位币金额
            IF NOT cl_null(l_xrcd.xrcdld) THEN
               CALL s_tax_get_xrcd124(l_xrcd.xrcdld,r_xrcd103,r_xrcd104,r_xrcd113,r_xrcd114,l_xrcd.xrcd121,l_xrcd.xrcd131)
                    RETURNING l_xrcd.xrcd123,l_xrcd.xrcd124,l_xrcd.xrcd125,l_xrcd.xrcd133,l_xrcd.xrcd134,l_xrcd.xrcd135
            END IF
            #更新数据库
            UPDATE xrcd_t SET xrcd103 = l_xrcd.xrcd103,
                              xrcd104 = l_xrcd.xrcd104,
                              xrcd105 = l_xrcd.xrcd105,
                              xrcd113 = r_xrcd113,
                              xrcd114 = r_xrcd114,
                              xrcd115 = r_xrcd115,
                              xrcd124 = l_xrcd.xrcd124,
                              xrcd134 = l_xrcd.xrcd134
             WHERE xrcd007 = l_xrcd.xrcd007
               AND xrcdseq2 = l_xrcd.xrcdseq2
               AND xrcdseq = l_xrcd.xrcdseq
               AND xrcdld = l_xrcd.xrcdld
               AND xrcddocno = p_xrcddocno
               AND xrcdent = g_enterprise  
            
            #当抓到第10笔金额后，退出循环
            LET l_row_no=l_row_no+1
            IF l_row_no=10 THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      #2.当差额分摊完毕后，再次计算是否存在差额，如果存在，将差额放入未税金额和税额最大笔中
      #160716-00007#1--add--end
      #單據原始的未稅金額、稅額
      LET l_xrcd.xrcd103 = 0
      LET l_xrcd.xrcd104 = 0
      SELECT sum(xrcd103),sum(xrcd104)
        INTO l_xrcd.xrcd103,l_xrcd.xrcd104
        FROM xrcd_t
       WHERE xrcd002 = l_xrcd002
         AND xrcddocno = p_xrcddocno
         AND xrcdseq2 = l_xrcdseq2                   #20150106 polly add         
         AND xrcdent = g_enterprise
      IF cl_null(l_xrcd.xrcd103) THEN LET l_xrcd.xrcd103 = 0 END IF 
      IF cl_null(l_xrcd.xrcd104) THEN LET l_xrcd.xrcd104 = 0 END IF 

      #重新計算後的未稅金額、稅額
      LET r_xrcd103 = 0
      LET r_xrcd104 = 0
      SELECT sum(xrcd103),sum(xrcd104)
        INTO r_xrcd103,r_xrcd104
        FROM tax_tmp
       WHERE xrcd002 = l_xrcd002
      IF cl_null(r_xrcd103) THEN LET r_xrcd103 = 0 END IF 
      IF cl_null(r_xrcd104) THEN LET r_xrcd104 = 0 END IF 
     
      LET diff_xrcd103 = r_xrcd103 - l_xrcd.xrcd103
      LET diff_xrcd104 = r_xrcd104 - l_xrcd.xrcd104
      IF diff_xrcd103 != 0 OR diff_xrcd104 != 0 THEN
         INITIALIZE l_xrcd.* TO NULL
         #抓取未税金额和税额最大笔资料
         DECLARE upd_cur CURSOR FOR
            SELECT xrcdsite,xrcdld,xrcdseq,xrcdseq2,xrcd007,xrcd100,xrcd101,
                   xrcd103,xrcd104,xrcd121,xrcd131
              FROM xrcd_t
             WHERE xrcd002 = l_xrcd002
               AND xrcddocno = p_xrcddocno
               AND xrcdseq2 = l_xrcdseq2                                
               AND xrcdent = g_enterprise
             ORDER BY xrcd103 DESC,xrcd104 DESC  # 抓取最大笔未税金额和税额分摊差额
         FOREACH upd_cur INTO l_xrcd.xrcdsite,l_xrcd.xrcdld,l_xrcd.xrcdseq,l_xrcd.xrcdseq2,
                              l_xrcd.xrcd007,l_xrcd.xrcd100,l_xrcd.xrcd101,l_xrcd.xrcd103,
                              l_xrcd.xrcd104,l_xrcd.xrcd121,l_xrcd.xrcd131
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sub_success = FALSE
               EXIT FOREACH
            END IF
            IF cl_null(l_xrcd.xrcd103) THEN LET l_xrcd.xrcd103 = 0 END IF
            IF cl_null(l_xrcd.xrcd104) THEN LET l_xrcd.xrcd104 = 0 END IF
            EXIT FOREACH
         END FOREACH

         CALL s_tax_get_ooef(l_xrcd.xrcdsite) RETURNING l_success,l_ooef016,l_ooef017,l_ooef019
         #未税金额有差额
         IF diff_xrcd103 <> 0 THEN 
            LET l_xrcd.xrcd103 = l_xrcd.xrcd103 + diff_xrcd103
            LET l_xrcd.xrcd103 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd103,2) #150903
         END IF 
         #税额有差额
         IF diff_xrcd104 <> 0 THEN 
            LET l_xrcd.xrcd104 = l_xrcd.xrcd104 + diff_xrcd104
            LET l_xrcd.xrcd104 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd104,2) #150903
         END IF 
         LET l_xrcd.xrcd105 = l_xrcd.xrcd103 + l_xrcd.xrcd104
         LET l_xrcd.xrcd105 = s_curr_round(l_ooef017,l_xrcd.xrcd100,l_xrcd.xrcd105,2)
         CALL s_tax_get_xrcd114(l_xrcd.xrcd103,l_xrcd.xrcd104,l_xrcd.xrcd101,l_ooef017,l_ooef016,l_xrcd002,l_ooef019)
              RETURNING r_xrcd113,r_xrcd114,r_xrcd115
         IF NOT cl_null(l_xrcd.xrcdld) THEN
            CALL s_tax_get_xrcd124(l_xrcd.xrcdld,r_xrcd103,r_xrcd104,r_xrcd113,r_xrcd114,l_xrcd.xrcd121,l_xrcd.xrcd131)
                 RETURNING l_xrcd.xrcd123,l_xrcd.xrcd124,l_xrcd.xrcd125,l_xrcd.xrcd133,l_xrcd.xrcd134,l_xrcd.xrcd135
         END IF
         
         UPDATE xrcd_t SET xrcd103 = l_xrcd.xrcd103,
                           xrcd104 = l_xrcd.xrcd104,
                           xrcd105 = l_xrcd.xrcd105,
                           xrcd113 = r_xrcd113,
                           xrcd114 = r_xrcd114,
                           xrcd115 = r_xrcd115,
                           xrcd124 = l_xrcd.xrcd124,
                           xrcd134 = l_xrcd.xrcd134
          WHERE xrcd007 = l_xrcd.xrcd007
            AND xrcdseq2 = l_xrcd.xrcdseq2
            AND xrcdseq = l_xrcd.xrcdseq
            AND xrcdld = l_xrcd.xrcdld
            AND xrcddocno = p_xrcddocno
            AND xrcdent = g_enterprise      
      END IF
      LET l_xrcd002 = ''
   END FOREACH
   
   LET r_xrcd103 = 0
   LET r_xrcd104 = 0
   LET r_xrcd113 = 0
   LET r_xrcd114 = 0
   SELECT sum(xrcd103),sum(xrcd104),sum(xrcd113),sum(xrcd114)
     INTO r_xrcd103,r_xrcd104,r_xrcd113,r_xrcd114
     FROM xrcd_t
    WHERE xrcddocno = p_xrcddocno
      AND xrcdseq2 = l_xrcdseq2                     
      AND xrcdent = g_enterprise
   LET r_xrcd105 = r_xrcd103 + r_xrcd104
   LET r_xrcd115 = r_xrcd113 + r_xrcd114
   
   DELETE FROM tax_tmp
   
   RETURN r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115
END FUNCTION

 
{</section>}
 
