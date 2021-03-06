#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp431.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-06-16 17:30:44), PR版次:0004(2016-12-06 18:40:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: axmp431
#+ Description: 銷售折扣帳款處理作業
#+ Creator....: 01588(2015-06-11 10:38:27)
#+ Modifier...: 01588 -SD/PR- 08993
 
{</section>}
 
{<section id="axmp431.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151118-00012#1   2015/11/19  By Shiun      更改抓取匯率時的基準日期
#161109-00085#11  2016/11/10  By 08993      整批調整系統星號寫法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../../com/sub/4gl/s_apmm101.inc"
#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
        xmfjdocno           LIKE xmfj_t.xmfjdocno,   #合約編號
        xmflseq             LIKE xmfl_t.xmflseq,     #合約項次
        l_docno             LIKE ooba_t.ooba002,     #帳款單別
        l_reason            LIKE oocq_t.oocq002,     #理由碼
        l_exchange_rate     LIKE type_t.chr1,        #匯率指定方式
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel                 LIKE type_t.chr1,        #選擇
        xmfj003             LIKE xmfj_t.xmfj003,     #帳款客戶
        xmfj003_desc        LIKE pmaal_t.pmaal004,   #名稱
        xmde001             LIKE xmde_t.xmde001,     #合約編號
        xmde002             LIKE xmde_t.xmde002,     #項次
        xmde005             LIKE xmde_t.xmde005,     #結算日期
        xmde003             LIKE xmde_t.xmde003,     #出貨/銷退單號
        xmde004             LIKE xmde_t.xmde004,     #項次
        xmdk007             LIKE xmdk_t.xmdk007,     #客戶編號
        xmdk007_desc        LIKE pmaal_t.pmaal004,   #名稱
        xmde006             LIKE xmde_t.xmde006,     #料件編號
        xmde006_desc        LIKE imaal_t.imaal003,   #品名
        xmde006_desc1       LIKE imaal_t.imaal004,   #規格
        xmde007             LIKE xmde_t.xmde007,     #產品特徵
        xmde007_desc        LIKE type_t.chr80,       #説明
        xmde008             LIKE xmde_t.xmde008,     #原始數量
        xmde009             LIKE xmde_t.xmde009,     #單位
        xmde009_desc        LIKE oocal_t.oocal003,   #說明
        xmde010             LIKE xmde_t.xmde010,     #原始單價
        xmde011             LIKE xmde_t.xmde011,     #原始未稅金額
        xmde012             LIKE xmde_t.xmde012,     #原始含稅金額
        xmde013             LIKE xmde_t.xmde013,     #原始稅額
        xmde020             LIKE xmde_t.xmde020,     #折扣數量
        xmde021             LIKE xmde_t.xmde021,     #折扣單價
        xmde017             LIKE xmde_t.xmde017,     #折扣未稅金額
        xmde018             LIKE xmde_t.xmde018,     #折扣含稅金額
        xmde019             LIKE xmde_t.xmde019,     #折扣稅額
        xmde029             LIKE xmde_t.xmde029,     #調整折扣單價
        xmde014             LIKE xmde_t.xmde014,     #調整折扣未稅金額
        xmde015             LIKE xmde_t.xmde015,     #調整折扣含稅金額
        xmde016             LIKE xmde_t.xmde016      #調整折扣稅額
                            END RECORD
DEFINE g_param              type_parameter
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_xmfj019            LIKE xmfj_t.xmfj019      #帳款產生方式
DEFINE g_apcasite           LIKE apca_t.apcasite     #帳務中心
DEFINE g_apcald             LIKE apca_t.apcald       #帳套
DEFINE g_apcacomp           LIKE apca_t.apcacomp     #所屬法人
DEFINE g_glaa001            LIKE glaa_t.glaa001      #使用幣別
DEFINE g_glaa016            LIKE glaa_t.glaa016      #本位幣二
DEFINE g_glaa020            LIKE glaa_t.glaa020      #本位幣三
DEFINE g_glaa024            LIKE glaa_t.glaa024      #單據別參照表號
DEFINE g_glaa121            LIKE glaa_t.glaa121      #子模組啟用分錄底稿
DEFINE g_gen_doc            STRING                   #產生的單據組成字串
#161109-00085#11-mod-s
#DEFINE g_xmdk               RECORD LIKE xmdk_t.*   #161109-00085#11   mark
DEFINE g_xmdk               RECORD  #出貨/簽收/銷退單單頭檔
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
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
               END RECORD
#161109-00085#11-mod-e
#161109-00085#11-mod-s
#DEFINE g_xmdl               RECORD LIKE xmdl_t.*   #161109-00085#11   mark
DEFINE g_xmdl               RECORD  #出貨/簽收/銷退單單身明細檔
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
       xmdl059 LIKE xmdl_t.xmdl059, #客戶退貨量
       xmdl060 LIKE xmdl_t.xmdl060  #放行狀態
               END RECORD
#161109-00085#11-mod-e
#161109-00085#11-mod-s
#DEFINE g_apca               RECORD LIKE apca_t.*   #161109-00085#11   mark
DEFINE g_apca               RECORD  #應付憑單單頭
       apcaent LIKE apca_t.apcaent, #企業編號
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
       apcastus LIKE apca_t.apcastus, #狀態碼
       apcald LIKE apca_t.apcald, #帳套
       apcacomp LIKE apca_t.apcacomp, #法人
       apcadocno LIKE apca_t.apcadocno, #應付帳款單號碼
       apcadocdt LIKE apca_t.apcadocdt, #帳款日期
       apcasite LIKE apca_t.apcasite, #帳務中心
       apca001 LIKE apca_t.apca001, #帳款單性質
       apca003 LIKE apca_t.apca003, #帳務人員
       apca004 LIKE apca_t.apca004, #帳款對象編號
       apca005 LIKE apca_t.apca005, #付款對象
       apca006 LIKE apca_t.apca006, #供應商分類
       apca007 LIKE apca_t.apca007, #帳款類別
       apca008 LIKE apca_t.apca008, #付款條件編號
       apca009 LIKE apca_t.apca009, #應付款日/應扣抵日
       apca010 LIKE apca_t.apca010, #容許票據到期日
       apca011 LIKE apca_t.apca011, #稅別
       apca012 LIKE apca_t.apca012, #稅率
       apca013 LIKE apca_t.apca013, #含稅否
       apca014 LIKE apca_t.apca014, #人員編號
       apca015 LIKE apca_t.apca015, #部門編號
       apca016 LIKE apca_t.apca016, #來源作業類型
       apca017 LIKE apca_t.apca017, #產生方式
       apca018 LIKE apca_t.apca018, #來源參考單號
       apca019 LIKE apca_t.apca019, #系統產生對應單號(待抵帳款-預付)
       apca020 LIKE apca_t.apca020, #信用狀付款否
       apca021 LIKE apca_t.apca021, #商業發票號碼(IV no.)
       apca022 LIKE apca_t.apca022, #進口報單號碼
       apca025 LIKE apca_t.apca025, #差異處理(發票與帳款差異)
       apca026 LIKE apca_t.apca026, #原幣未稅差異
       apca027 LIKE apca_t.apca027, #原幣稅額差異
       apca028 LIKE apca_t.apca028, #本幣未稅差異
       apca029 LIKE apca_t.apca029, #本幣幣稅額差異
       apca030 LIKE apca_t.apca030, #差異科目
       apca031 LIKE apca_t.apca031, #產生之差異折讓單號
       apca032 LIKE apca_t.apca032, #發票類型
       apca033 LIKE apca_t.apca033, #專案編號
       apca034 LIKE apca_t.apca034, #責任中心
       apca035 LIKE apca_t.apca035, #應付(貸方)科目編號
       apca036 LIKE apca_t.apca036, #費用(借方)科目編號
       apca037 LIKE apca_t.apca037, #產生傳票否
       apca038 LIKE apca_t.apca038, #拋轉傳票號碼
       apca039 LIKE apca_t.apca039, #會計檢核附件份數
       apca040 LIKE apca_t.apca040, #留置否
       apca041 LIKE apca_t.apca041, #留置理由碼
       apca042 LIKE apca_t.apca042, #留置設定日期
       apca043 LIKE apca_t.apca043, #留置解除日期
       apca044 LIKE apca_t.apca044, #留置原幣金額
       apca045 LIKE apca_t.apca045, #留置說明
       apca046 LIKE apca_t.apca046, #關係人否
       apca047 LIKE apca_t.apca047, #多角序號
       apca048 LIKE apca_t.apca048, #集團代付/代付單號
       apca049 LIKE apca_t.apca049, #來源營運中心編號
       apca050 LIKE apca_t.apca050, #交易原始單據份數
       apca051 LIKE apca_t.apca051, #作廢理由碼
       apca052 LIKE apca_t.apca052, #列印次數
       apca053 LIKE apca_t.apca053, #備註
       apca054 LIKE apca_t.apca054, #多帳期設定
       apca055 LIKE apca_t.apca055, #繳款優惠條件
       apca056 LIKE apca_t.apca056, #會計檢核附件狀態
       apca057 LIKE apca_t.apca057, #交易對象識別碼
       apca058 LIKE apca_t.apca058, #稅別交易類型
       apca059 LIKE apca_t.apca059, #預算編號
       apca060 LIKE apca_t.apca060, #發票開立方式
       apca061 LIKE apca_t.apca061, #預開發票基準日
       apca062 LIKE apca_t.apca062, #多角性質
       apca063 LIKE apca_t.apca063, #整帳批序號
       apca064 LIKE apca_t.apca064, #訂金序次
       apca065 LIKE apca_t.apca065, #發票編號
       apca066 LIKE apca_t.apca066, #發票號碼
       apca100 LIKE apca_t.apca100, #交易原幣別
       apca101 LIKE apca_t.apca101, #原幣匯率
       apca103 LIKE apca_t.apca103, #原幣未稅金額
       apca104 LIKE apca_t.apca104, #原幣稅額
       apca106 LIKE apca_t.apca106, #原幣應稅折抵合計金額
       apca107 LIKE apca_t.apca107, #原幣直接沖帳(調整)合計金額
       apca108 LIKE apca_t.apca108, #原幣應付金額
       apca113 LIKE apca_t.apca113, #本幣未稅金額
       apca114 LIKE apca_t.apca114, #本幣稅額
       apca116 LIKE apca_t.apca116, #本幣應稅折抵合計金額
       apca117 LIKE apca_t.apca117, #NO USE
       apca118 LIKE apca_t.apca118, #本幣應付金額
       apca120 LIKE apca_t.apca120, #本位幣二幣別
       apca121 LIKE apca_t.apca121, #本位幣二匯率
       apca123 LIKE apca_t.apca123, #本位幣二未稅金額
       apca124 LIKE apca_t.apca124, #本位幣二稅額
       apca126 LIKE apca_t.apca126, #本位幣二應稅折抵合計金額
       apca127 LIKE apca_t.apca127, #NO USE
       apca128 LIKE apca_t.apca128, #本位幣二應付金額
       apca130 LIKE apca_t.apca130, #本位幣三幣別
       apca131 LIKE apca_t.apca131, #本位幣三匯率
       apca133 LIKE apca_t.apca133, #本位幣三未稅金額
       apca134 LIKE apca_t.apca134, #本位幣三稅額
       apca136 LIKE apca_t.apca136, #本位幣三應稅折抵合計金額
       apca137 LIKE apca_t.apca137, #NO USE
       apca138 LIKE apca_t.apca138, #本位幣三應付金額
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
       apca067 LIKE apca_t.apca067, #管理品類
       apca068 LIKE apca_t.apca068, #經營方式
       apca069 LIKE apca_t.apca069, #no use
       apca070 LIKE apca_t.apca070, #no use
       apca071 LIKE apca_t.apca071, #no use
       apca072 LIKE apca_t.apca072, #no use
       apca073 LIKE apca_t.apca073  #L/C No.
               END RECORD
#161109-00085#11-mod-e
#161109-00085#11-mod-s
#DEFINE g_apcb               RECORD LIKE apcb_t.*   #161109-00085#11   mark
DEFINE g_apcb               RECORD  #應付憑單單身
       apcbent LIKE apcb_t.apcbent, #企業編號
       apcbld LIKE apcb_t.apcbld, #帳套
       apcblegl LIKE apcb_t.apcblegl, #核算組織
       apcborga LIKE apcb_t.apcborga, #帳務歸屬組織(來源組織)
       apcbsite LIKE apcb_t.apcbsite, #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq LIKE apcb_t.apcbseq, #項次
       apcb001 LIKE apcb_t.apcb001, #來源類型
       apcb002 LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003 LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004 LIKE apcb_t.apcb004, #產品編號
       apcb005 LIKE apcb_t.apcb005, #品名規格
       apcb006 LIKE apcb_t.apcb006, #單位
       apcb007 LIKE apcb_t.apcb007, #計價數量
       apcb008 LIKE apcb_t.apcb008, #參考單據號碼
       apcb009 LIKE apcb_t.apcb009, #參考單據項次
       apcb010 LIKE apcb_t.apcb010, #業務部門
       apcb011 LIKE apcb_t.apcb011, #責任中心
       apcb012 LIKE apcb_t.apcb012, #產品類別
       apcb013 LIKE apcb_t.apcb013, #搭贈
       apcb014 LIKE apcb_t.apcb014, #理由碼
       apcb015 LIKE apcb_t.apcb015, #專案編號
       apcb016 LIKE apcb_t.apcb016, #WBS編號
       apcb017 LIKE apcb_t.apcb017, #預算細項
       apcb018 LIKE apcb_t.apcb018, #专柜编号
       apcb019 LIKE apcb_t.apcb019, #開票性質
       apcb020 LIKE apcb_t.apcb020, #稅別
       apcb021 LIKE apcb_t.apcb021, #費用會計科目
       apcb022 LIKE apcb_t.apcb022, #正負值
       apcb023 LIKE apcb_t.apcb023, #沖暫估單否
       apcb024 LIKE apcb_t.apcb024, #區域
       apcb025 LIKE apcb_t.apcb025, #傳票號碼
       apcb026 LIKE apcb_t.apcb026, #傳票項次
       apcb027 LIKE apcb_t.apcb027, #發票編號
       apcb028 LIKE apcb_t.apcb028, #發票號碼
       apcb029 LIKE apcb_t.apcb029, #應付帳款科目
       apcb030 LIKE apcb_t.apcb030, #付款條件
       apcb032 LIKE apcb_t.apcb032, #訂金序次
       apcb033 LIKE apcb_t.apcb033, #經營方式
       apcb034 LIKE apcb_t.apcb034, #通路
       apcb035 LIKE apcb_t.apcb035, #品牌
       apcb036 LIKE apcb_t.apcb036, #客群
       apcb037 LIKE apcb_t.apcb037, #自由核算項一
       apcb038 LIKE apcb_t.apcb038, #自由核算項二
       apcb039 LIKE apcb_t.apcb039, #自由核算項三
       apcb040 LIKE apcb_t.apcb040, #自由核算項四
       apcb041 LIKE apcb_t.apcb041, #自由核算項五
       apcb042 LIKE apcb_t.apcb042, #自由核算項六
       apcb043 LIKE apcb_t.apcb043, #自由核算項七
       apcb044 LIKE apcb_t.apcb044, #自由核算項八
       apcb045 LIKE apcb_t.apcb045, #自由核算項九
       apcb046 LIKE apcb_t.apcb046, #自由核算項十
       apcb047 LIKE apcb_t.apcb047, #摘要
       apcb048 LIKE apcb_t.apcb048, #來源訂購單號
       apcb049 LIKE apcb_t.apcb049, #開票單號
       apcb050 LIKE apcb_t.apcb050, #開票項次
       apcb051 LIKE apcb_t.apcb051, #業務人員
       apcb100 LIKE apcb_t.apcb100, #交易原幣
       apcb101 LIKE apcb_t.apcb101, #交易原幣單價
       apcb102 LIKE apcb_t.apcb102, #原幣匯率
       apcb103 LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb104 LIKE apcb_t.apcb104, #交易原幣稅額
       apcb105 LIKE apcb_t.apcb105, #交易原幣含稅金額
       apcb106 LIKE apcb_t.apcb106, #交易幣標準成本金額
       apcb107 LIKE apcb_t.apcb107, #入庫單單價
       apcb108 LIKE apcb_t.apcb108, #交易原幣成本認列金額
       apcb111 LIKE apcb_t.apcb111, #本幣單價
       apcb113 LIKE apcb_t.apcb113, #本幣未稅金額
       apcb114 LIKE apcb_t.apcb114, #本幣稅額
       apcb115 LIKE apcb_t.apcb115, #本幣含稅金額
       apcb116 LIKE apcb_t.apcb116, #本幣標準成本金額
       apcb117 LIKE apcb_t.apcb117, #NO USE
       apcb118 LIKE apcb_t.apcb118, #本幣成本認列金額
       apcb119 LIKE apcb_t.apcb119, #應開發票含稅金額
       apcb121 LIKE apcb_t.apcb121, #本位幣二匯率
       apcb123 LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb124 LIKE apcb_t.apcb124, #本位幣二稅額
       apcb125 LIKE apcb_t.apcb125, #本位幣二含稅金額
       apcb126 LIKE apcb_t.apcb126, #本幣二標準成本金額
       apcb127 LIKE apcb_t.apcb127, #NO USE
       apcb128 LIKE apcb_t.apcb128, #本位幣二成本認列金額
       apcb131 LIKE apcb_t.apcb131, #本位幣三匯率
       apcb133 LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb134 LIKE apcb_t.apcb134, #本位幣三稅額
       apcb135 LIKE apcb_t.apcb135, #本位幣三含稅金額
       apcb136 LIKE apcb_t.apcb136, #本幣三標準成本金額
       apcb137 LIKE apcb_t.apcb137, #NO USE
       apcb138 LIKE apcb_t.apcb138, #本位幣三成本認列金額
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
       apcb052 LIKE apcb_t.apcb052, #稅額
       apcb053 LIKE apcb_t.apcb053, #含稅金額
       apcb054 LIKE apcb_t.apcb054, #帳款對象
       apcb055 LIKE apcb_t.apcb055  #付款對象
               END RECORD
#161109-00085#11-mod-e
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp431.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp431 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp431_init()   
 
      #進入選單 Menu (="N")
      CALL axmp431_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp431
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp431.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp431_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp431.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp431_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_ooef004      LIKE ooef_t.ooef004
   DEFINE l_ooef019      LIKE ooef_t.ooef019
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_param.xmflseq = ''
   LET g_param.l_exchange_rate = '1'
   
   IF NOT cl_null(g_argv[01]) THEN
      LET g_param.xmfjdocno = g_argv[01]
      LET g_param.xmflseq = g_argv[02]
      CALL axmp431_query()
   END IF
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp431_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_param.xmfjdocno,g_param.xmflseq,
                       g_param.l_docno,g_param.l_reason,g_param.l_exchange_rate
               ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD xmfjdocno
               IF NOT cl_null(g_param.xmfjdocno) THEN
                  #合約編號檢查
                  IF NOT axmp431_xmfjdocno_chk(g_param.xmfjdocno) THEN
                     LET g_param.xmfjdocno = ''
                     DISPLAY BY NAME g_param.xmfjdocno
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶值
                  IF NOT axmp431_xmfjdocno_default(g_param.xmfjdocno) THEN
                     LET g_param.xmfjdocno = ''
                     DISPLAY BY NAME g_param.xmfjdocno
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  NEXT FIELD CURRENT
               END IF
               CALL axmp431_set_entry()
               CALL axmp431_set_no_entry()
               
            BEFORE FIELD xmflseq
               IF cl_null(g_param.xmfjdocno) THEN
                  NEXT FIELD xmfjdocno
               END IF
               
            AFTER FIELD xmflseq
               IF NOT cl_null(g_param.xmflseq) THEN
                  #合約項次檢查
                  IF NOT axmp431_xmflseq_chk(g_param.xmfjdocno,g_param.xmflseq) THEN
                     LET g_param.xmflseq = ''
                     DISPLAY BY NAME g_param.xmflseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            BEFORE FIELD l_docno
               IF cl_null(g_param.xmfjdocno) THEN
                  NEXT FIELD xmfjdocno
               END IF
               
            AFTER FIELD l_docno
               IF NOT cl_null(g_param.l_docno) THEN
                  #單別檢查
                  IF NOT axmp431_docno_chk(g_param.l_docno) THEN
                     LET g_param.l_docno = ''
                     DISPLAY BY NAME g_param.l_docno
                     DISPLAY '' TO FORMONLY.l_docno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #單別說明
                  CALL axmp431_docno_desc(g_param.l_docno)
               END IF
            
            BEFORE FIELD l_reason
               IF cl_null(g_param.xmfjdocno) THEN 
                  NEXT FIELD xmfjdocno
               END IF
               
            AFTER FIELD l_reason
               IF NOT cl_null(g_param.l_reason) THEN
                  #理由碼檢查
                  IF NOT axmp431_reason_chk(g_param.l_reason) THEN
                     LET g_param.l_reason = ''
                     DISPLAY BY NAME g_param.l_reason
                     DISPLAY '' TO FORMONLY.l_reason_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #理由碼說明
                  CALL axmp431_reason_desc(g_param.l_reason)
               END IF
               
            BEFORE FIELD l_exchange_reate
               IF cl_null(g_param.xmfjdocno) THEN
                  NEXT FIELD xmfjdocno
               END IF
            
            ON ACTION controlp INFIELD xmfjdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.xmfjdocno
               LET l_ooef019 = ''
               SELECT ooef019 INTO l_ooef019 
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site
               LET g_qryparam.arg1 = l_ooef019
               LET g_qryparam.where = " xmfjdocno IN (SELECT xmde001 FROM xmde_t ",
                                      "                WHERE xmdeent = ",g_enterprise,
                                      "                  AND xmdesite= '",g_site,"'",
                                      "                  AND xmde000 = '3' ",
                                      "                  AND xmde025 = '1' )"
               CALL q_xmfjdocno_1()
               LET g_param.xmfjdocno = g_qryparam.return1
               DISPLAY BY NAME g_param.xmfjdocno
               NEXT FIELD xmfjdocno
               
            ON ACTION controlp INFIELD xmflseq
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.xmflseq
               LET g_qryparam.arg1 = g_param.xmfjdocno
               LET g_qryparam.where = " EXISTS(SELECT xmde001,xmde002 FROM xmde_t ",
                                      "         WHERE xmdeent = ",g_enterprise,
                                      "           AND xmdesite = '",g_site,"'",
                                      "           AND xmde000 = '3' ",
                                      "           AND xmde001 = '",g_param.xmfjdocno,"'",
                                      "           AND xmde002 = xmflseq ",
                                      "           AND xmde025 = '1') "
               CALL q_xmflseq()
               LET g_param.xmflseq = g_qryparam.return1
               DISPLAY BY NAME g_param.xmflseq
               NEXT FIELD xmflseq
            
            ON ACTION controlp INFIELD l_docno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.l_docno
               CASE g_xmfj019
                  WHEN '1'
                       LET l_ooef004 = ''
                       SELECT ooef004 INTO l_ooef004
                         FROM ooef_t
                        WHERE ooefent = g_enterprise
                          AND ooef001 = g_site
                       LET g_qryparam.arg1 = l_ooef004
                       LET g_qryparam.arg2 = 'axmt600'
                  WHEN '2'
                       LET g_qryparam.arg1 = g_glaa024
                       LET g_qryparam.arg2 = 'aapt301'
               END CASE
               CALL q_ooba002_1()
               LET g_param.l_docno = g_qryparam.return1
               DISPLAY BY NAME g_param.l_docno
               CALL axmp431_docno_desc(g_param.l_docno)
               NEXT FIELD l_docno
               
            ON ACTION controlp INFIELD l_reason
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_param.l_reason
               CASE g_xmfj019 
                  WHEN '1'   #銷退折讓
                       LET g_qryparam.arg1 = '310'
                       CALL q_oocq002()
                       LET g_param.l_reason = g_qryparam.return1
                       DISPLAY BY NAME g_param.l_reason
                  WHEN '2'   #雜項應付
               END CASE
               CALL axmp431_reason_desc(g_param.l_reason)
               NEXT FIELD l_reason
         END INPUT

         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                    INSERT ROW = FALSE,
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
            
            AFTER FIELD b_xmde029
               IF NOT cl_null(g_detail_d[l_ac].xmde029) THEN
                  #不可大於原始單價(xmde010)
                  IF g_detail_d[l_ac].xmde029 > g_detail_d[l_ac].xmde010 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00675'
                     LET g_errparam.extend = g_detail_d[l_ac].xmde029
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_detail_d[l_ac].xmde010
                     
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出調整折扣含未稅金額與稅額
                  CALL axmp431_xmde029_default()
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmp431_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            IF cl_null(g_param.xmfjdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00676'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               
               CALL cl_err()
               NEXT FIELD xmfjdocno
            ELSE
               IF NOT cl_null(g_param.xmfjdocno) THEN
                  #合約編號檢查
                  IF NOT axmp431_xmfjdocno_chk(g_param.xmfjdocno) THEN
                     LET g_param.xmfjdocno = ''
                     DISPLAY BY NAME g_param.xmfjdocno
                     NEXT FIELD xmfjdocno
                  END IF
                  
                  #帶值
                  IF NOT axmp431_xmfjdocno_default(g_param.xmfjdocno) THEN
                     LET g_param.xmfjdocno = ''
                     DISPLAY BY NAME g_param.xmfjdocno
                     NEXT FIELD xmfjdocno
                  END IF
               ELSE
                  NEXT FIELD CURRENT
               END IF
               CALL axmp431_set_entry()
               CALL axmp431_set_no_entry()
            END IF
            #end add-point
            CALL axmp431_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp431_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(g_param.l_docno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00603'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD l_docno
            ELSE
               #單別檢查
               IF NOT axmp431_docno_chk(g_param.l_docno) THEN
                  LET g_param.l_docno = ''
                  DISPLAY BY NAME g_param.l_docno
                  DISPLAY '' TO FORMONLY.l_docno_desc
                  NEXT FIELD l_docno
               END IF
                  
               #單別說明
               CALL axmp431_docno_desc(g_param.l_docno)
            END IF
            IF g_xmfj019 = '1' THEN
               IF cl_null(g_param.l_reason) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00622'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
 
                  NEXT FIELD l_reason
               ELSE
                  #理由碼檢查
                  IF NOT axmp431_reason_chk(g_param.l_reason) THEN
                     LET g_param.l_reason = ''
                     DISPLAY BY NAME g_param.l_reason
                     DISPLAY '' TO FORMONLY.l_reason_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #理由碼說明
                  CALL axmp431_reason_desc(g_param.l_reason)
               END IF
            END IF
            CALL axmp431_batch_execute()
            CALL axmp431_query()
            CONTINUE DIALOG
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp431.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp431_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axmp431_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp431.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp431_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   LET g_sql = "SELECT 'Y',xmfj003,a.pmaal004,xmde001,xmde002,xmde005,xmde003,xmde004, ",
               "       xmdk007,b.pmaal004,xmde006,imaal003,imaal004,xmde007,'',xmde008, ",
               "       xmde009,oocal003,xmde010,xmde011,xmde012,xmde013,xmde020,xmde021, ",
               "       xmde017,xmde018,xmde019,xmde029,xmde014,xmde015,xmde016 ",
               "  FROM xmde_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent=",g_enterprise," AND imaal001=xmde006 AND imaal002='",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t ON oocalent=",g_enterprise," AND oocal001=xmde009 AND oocal002='",g_dlang,"'",
               "      ,xmfj_t ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent=",g_enterprise," AND a.pmaal001=xmfj003 AND a.pmaal002='",g_dlang,"'",
               "      ,xmdk_t ",
               "       LEFT OUTER JOIN pmaal_t b ON b.pmaalent=",g_enterprise," AND b.pmaal001=xmdk007 AND b.pmaal002='",g_dlang,"'",
               " WHERE xmdeent = ?",
               "   AND xmdesite= '",g_site,"'",
               "   AND xmde000 = '3' ",
               "   AND xmde001 = '",g_param.xmfjdocno,"' ",
               "   AND xmde025 = '1' ",
               "   AND xmfjent = xmdeent ",
               "   AND xmfjdocno = xmde001 ",
               "   AND xmdkent = xmdeent ",
               "   AND xmdkdocno = xmde003 ",
               "   AND ",g_wc_filter CLIPPED
   IF NOT cl_null(g_param.xmflseq) THEN
      LET g_sql = g_sql CLIPPED,
                  " AND xmde002 = ",g_param.xmflseq
   END IF
   LET g_sql = g_sql CLIPPED," ORDER BY xmde005,xmde001,xmde002,xmde003,xmde004 "
   #end add-point
 
   PREPARE axmp431_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp431_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xmfj003,g_detail_d[l_ac].xmfj003_desc,g_detail_d[l_ac].xmde001,
      g_detail_d[l_ac].xmde002,g_detail_d[l_ac].xmde005,g_detail_d[l_ac].xmde003,g_detail_d[l_ac].xmde004,
      g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,g_detail_d[l_ac].xmde006,g_detail_d[l_ac].xmde006_desc,
      g_detail_d[l_ac].xmde006_desc1,g_detail_d[l_ac].xmde007,g_detail_d[l_ac].xmde007_desc,g_detail_d[l_ac].xmde008,
      g_detail_d[l_ac].xmde009,g_detail_d[l_ac].xmde009_desc,g_detail_d[l_ac].xmde010,g_detail_d[l_ac].xmde011,
      g_detail_d[l_ac].xmde012,g_detail_d[l_ac].xmde013,g_detail_d[l_ac].xmde020,g_detail_d[l_ac].xmde021,
      g_detail_d[l_ac].xmde017,g_detail_d[l_ac].xmde018,g_detail_d[l_ac].xmde019,g_detail_d[l_ac].xmde029,
      g_detail_d[l_ac].xmde014,g_detail_d[l_ac].xmde015,g_detail_d[l_ac].xmde016
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      
      #end add-point
      
      CALL axmp431_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axmp431_sel
   
   LET l_ac = 1
   CALL axmp431_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp431.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp431_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp431.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp431_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   CALL s_feature_description(g_detail_d[l_ac].xmde006,g_detail_d[l_ac].xmde007)
        RETURNING l_success,g_detail_d[l_ac].xmde007_desc
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp431.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp431_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   DEFINE l_ooef019      LIKE ooef_t.ooef019
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"

   CLEAR FORM 
   CALL g_detail_d.clear()
   
   CONSTRUCT g_wc_filter ON xmde001,xmde002,xmde005,xmde003,xmde004,xmde006,xmde007,
                            xmde008,xmde009,xmde010,xmde011,xmde012,xmde013,xmde020,
                            xmde021,xmde017,xmde018,xmde019,xmde029,xmde014
        FROM s_detail1[1].b_xmde001,s_detail1[1].b_xmde002,s_detail1[1].b_xmde005,s_detail1[1].b_xmde003,
             s_detail1[1].b_xmde004,s_detail1[1].b_xmde006,s_detail1[1].b_xmde007,s_detail1[1].b_xmde008,
             s_detail1[1].b_xmde009,s_detail1[1].b_xmde010,s_detail1[1].b_xmde011,s_detail1[1].b_xmde012,
             s_detail1[1].b_xmde013,s_detail1[1].b_xmde020,s_detail1[1].b_xmde021,s_detail1[1].b_xmde017,
             s_detail1[1].b_xmde018,s_detail1[1].b_xmde019,s_detail1[1].b_xmde029,s_detail1[1].b_xmde014
             
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_xmde001
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET l_ooef019 = ''
         SELECT ooef019 INTO l_ooef019 
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
         LET g_qryparam.arg1 = l_ooef019
         LET g_qryparam.where = " xmfjdocno IN (SELECT xmde001 FROM xmde_t ",
                                "                WHERE xmdeent = ",g_enterprise,
                                "                  AND xmdesite= '",g_site,"'",
                                "                  AND xmde000 = '3' ",
                                "                  AND xmde025 = '1' )"
         CALL q_xmfjdocno_1()
         DISPLAY g_qryparam.return1 TO b_xmde001
         NEXT FIELD b_xmde001
               
      ON ACTION controlp INFIELD b_xmde003
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " xmdkdocno IN (SELECT xmde003 FROM xmde_t ",
                                "                WHERE xmdeent = ",g_enterprise,
                                "                  AND xmdesite = '",g_site,"'",
                                "                  AND xmde000 = '3' ",
                                "                  AND xmde025 = '1' )"
         CALL q_xmdkdocno_1()
         DISPLAY g_qryparam.return1 TO b_xmde003
         NEXT FIELD b_xmde003
         
      ON ACTION controlp INFIELD b_xmde006
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         
         CALL q_imaf001_15()
         DISPLAY g_qryparam.return1 TO b_xmde006
         NEXT FIELD b_xmde006
         
      ON ACTION controlp INFIELD b_xmde009
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c' 
         LET g_qryparam.reqry = FALSE
         
         CALL q_ooca001_1()  
         DISPLAY g_qryparam.return1 TO b_xmde009
         NEXT FIELD b_xmde009
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axmp431_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp431.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp431_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="axmp431.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp431_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axmp431_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp431.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 合約編號檢查
# Memo...........:
# Usage..........: CALL axmp431_xmfjdocno_chk(p_xmfjdocno)
#                  RETURNING r_success
# Input parameter: p_xmfjdocno    合約編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmfjdocno_chk(p_xmfjdocno)
DEFINE p_xmfjdocno       LIKE xmfj_t.xmfjdocno
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_xmfjdocno) THEN
      RETURN r_success
   END IF
   
   #校驗
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_xmfjdocno
   IF cl_chk_exist("v_xmfjdocno") THEN
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #須存在xmde_t，且資料類型(xmde000) = '3'、差異處理否(xmde025) = '1'
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM xmde_t
    WHERE xmdeent = g_enterprise
      AND xmde000 = '3'
      AND xmde001 = p_xmfjdocno
      AND xmde025 = '1'
   IF cl_null(l_cnt) OR l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00667'
      LET g_errparam.extend = p_xmfjdocno
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 合約編號帶值
# Memo...........:
# Usage..........: CALL axmp431_xmfjdocno_default(p_xmfjdocno)
#                  RETURNING r_success
# Input parameter: p_xmfjdocno    合約編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmfjdocno_default(p_xmfjdocno)
DEFINE p_xmfjdocno       LIKE xmfj_t.xmfjdocno
DEFINE r_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5
DEFINE l_xmfj019_t       LIKE xmfj_t.xmfj019

   LET r_success = TRUE
   LET g_apcasite = ''
   LET g_apcald = ''
   LET g_apcacomp = ''
   LET g_glaa001 = ''
   LET g_glaa016 = ''
   LET g_glaa020 = ''
   LET g_glaa024 = ''
   LET g_glaa121 = ''
   
   IF cl_null(p_xmfjdocno) THEN
      RETURN r_success
   END IF
   
   #判斷該合約單是1.銷退折讓或2.雜項應付
   LET l_xmfj019_t = g_xmfj019
   LET g_xmfj019 = ''
   SELECT xmfj019 INTO g_xmfj019
     FROM xmfj_t
    WHERE xmfjent = g_enterprise
      AND xmfjdocno = p_xmfjdocno
   IF cl_null(g_xmfj019) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00668'
      LET g_errparam.extend = p_xmfjdocno
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CASE g_xmfj019
      WHEN '1'   #銷退折讓
      WHEN '2'   #雜項應付
           #帶出財務資料
           #帳務中心(apcasite),帳套(apcald),所屬法人(apcacomp)
           CALL s_aap_get_default_apcasite('','','') 
                RETURNING l_success1,g_errno,g_apcasite,g_apcald,g_apcacomp
           IF NOT l_success1 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = g_errno
              LET g_errparam.extend = p_xmfjdocno
              LET g_errparam.popup = TRUE
              
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #單據別參照表號(glaa024)
           CALL s_ld_sel_glaa(g_apcald,'glaa001|glaa016|glaa020|glaa024|glaa121') 
                RETURNING l_success1,g_glaa001,g_glaa016,g_glaa020,g_glaa024,g_glaa121
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
   END CASE
   
   IF NOT cl_null(l_xmfj019_t) AND g_xmfj019 != l_xmfj019_t THEN
      LET g_param.l_docno = ''
      DISPLAY BY NAME g_param.l_docno
      DISPLAY '' TO FORMONLY.l_docno_desc
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 欄位開放
# Memo...........:
# Usage..........: CALL axmp431_set_entry()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_set_entry()

   CALL cl_set_comp_entry("l_reason,l_exchange_rate",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉
# Memo...........:
# Usage..........: CALL axmp431_set_no_entry()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_set_no_entry()

   IF NOT cl_null(g_param.xmfjdocno) THEN
      IF g_xmfj019 = '2' THEN
         CALL cl_set_comp_entry("l_reason,l_exchange_rate",FALSE)
         LET g_param.l_reason = ''
         LET g_param.l_exchange_rate = '1'
         DISPLAY BY NAME g_param.l_reason,g_param.l_exchange_rate
         DISPLAY '' TO l_reason_desc
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 合約項次檢查
# Memo...........:
# Usage..........: CALL axmp431_xmflseq_chk(p_xmfjdocno,p_xmflseq)
#                  RETURNING r_success
# Input parameter: p_xmfjdocno    合約編號
#                : p_xmflseq      合約項次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmflseq_chk(p_xmfjdocno,p_xmflseq)
DEFINE p_xmfjdocno       LIKE xmfj_t.xmfjdocno
DEFINE p_xmflseq         LIKE xmfl_t.xmflseq
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = ''
   
   IF cl_null(p_xmfjdocno) OR cl_null(p_xmflseq) THEN
      RETURN r_success
   END IF
   
   #校驗
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_xmfjdocno
   LET g_chkparam.arg2 = p_xmflseq
   IF cl_chk_exist("v_xmflseq") THEN
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #須存在xmde_t，且資料類型(xmde000) = '3'、差異處理否(xmde025) = '1'
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM xmde_t
    WHERE xmdeent = g_enterprise
      AND xmde000 = '3'
      AND xmde001 = p_xmfjdocno
      AND xmde002 = p_xmflseq
      AND xmde025 = '1'
   IF cl_null(l_cnt) OR l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00669'
      LET g_errparam.extend = p_xmfjdocno,"+",p_xmflseq USING '<<<<<'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單別說明
# Memo...........:
# Usage..........: CALL axmp431_docno_desc(p_docno)
#                  
# Input parameter: p_docno        單別
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_docno_desc(p_docno)
DEFINE p_docno           LIKE ooba_t.ooba002
DEFINE l_docno_desc      LIKE type_t.chr80

   IF cl_null(p_docno) THEN
      RETURN
   END IF
   
   CASE g_xmfj019
      WHEN '1'   #銷退折讓
           CALL s_aooi200_get_slip_desc(p_docno) RETURNING l_docno_desc
      WHEN '2'   #雜項應付
           CALL s_aooi200_fin_get_slip_desc(p_docno) RETURNING l_docno_desc
   END CASE
   
   DISPLAY l_docno_desc TO FORMONLY.l_docno_desc
END FUNCTION

################################################################################
# Descriptions...: 單別檢查
# Memo...........:
# Usage..........: CALL axmp431_docno_chk(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno        單別
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_docno_chk(p_docno)
DEFINE p_docno           LIKE ooba_t.ooba002
DEFINE r_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5
DEFINE l_exist           LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_docno) THEN
      RETURN r_success
   END IF
   
   CASE g_xmfj019
      WHEN '1'   #銷退折讓
           #檢查單別是否正確
           CALL s_aooi200_chk_slip(g_site,'',p_docno,'axmt600') RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #檢查該單別可否被key人員對應的控制組使用
           CALL s_control_chk_doc('1',p_docno,'2',g_user,g_dept,'','') 
                RETURNING l_success1,l_exist
           IF l_success1 THEN
              IF NOT l_exist THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axm-00015'
                 LET g_errparam.extend = p_docno
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
         
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           ELSE
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN '2'   #雜項應付
           CALL s_fin_slip_chk(p_docno,'aapt301',g_apcald,'D-FIN-3001')
                RETURNING l_success1,g_errno
           IF NOT l_success1 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = g_errno
              LET g_errparam.extend = p_docno
              LET g_errparam.popup = TRUE
              
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 理由碼說明
# Memo...........:
# Usage..........: CALL axmp431_reason_desc(p_reason)
#                  
# Input parameter: p_reason       理由碼
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_reason_desc(p_reason)
DEFINE p_reason          LIKE oocq_t.oocq002
DEFINE l_reason_desc     LIKE type_t.chr80

   IF cl_null(p_reason) THEN
      RETURN 
   END IF
   
   CASE g_xmfj019
      WHEN '1'   #銷退折讓
           CALL s_desc_get_acc_desc('310',p_reason) RETURNING l_reason_desc
      WHEN '2'   #雜項應付
   END CASE
   
   DISPLAY l_reason_desc TO FORMONLY.l_reason_desc
END FUNCTION

################################################################################
# Descriptions...: 理由碼檢查
# Memo...........:
# Usage..........: CALL axmp431_reason_chk(p_reason)
#                  RETURNING r_success
# Input parameter: p_reason       理由碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_reason_chk(p_reason)
DEFINE p_reason          LIKE oocq_t.oocq002
DEFINE r_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_reason) THEN
      RETURN r_success
   END IF
   
   #理由碼檢查
   CASE g_xmfj019
      WHEN '1'   #銷退折讓
           CALL s_azzi650_chk_exist('310',p_reason) RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN '2'   #雜項應付
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 帶出調整折扣含未稅金額與稅額
# Memo...........:
# Usage..........: CALL axmp431_xmde029_default()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmde029_default()
DEFINE l_curr            LIKE ooai_t.ooai001
DEFINE l_tax             LIKE oodb_t.oodb002
DEFINE l_exrate          LIKE ooan_t.ooan005
DEFINE l_amount          LIKE xmde_t.xmde014
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_success         LIKE type_t.num5

   CASE g_param.l_exchange_rate
      WHEN '1'   #當下匯率
           SELECT xmfj004,xmfj005 INTO l_curr,l_tax
             FROM xmfj_t
            WHERE xmfjent = g_enterprise
              AND xmfjdocno = g_detail_d[l_ac].xmde001
              
           #當前匯率
           CALL axmp431_get_exrate(g_detail_d[l_ac].xmfj003,l_curr) RETURNING l_success,l_exrate
           IF NOT l_success THEN
              RETURN
           END IF
      WHEN '2'   #依據出貨單原始匯率
           SELECT xmdk016,xmdl025,xmdk017 INTO l_curr,l_tax,l_exrate
             FROM xmdk_t,xmdl_t
            WHERE xmdkent = g_enterprise
              AND xmdkdocno = xmdldocno
              AND xmdkdocno = g_detail_d[l_ac].xmde003
              AND xmdlseq = g_detail_d[l_ac].xmde004
   END CASE
   
   LET l_amount = g_detail_d[l_ac].xmde020 * g_detail_d[l_ac].xmde029
   CALL s_tax_count(g_site,l_tax,l_amount,g_detail_d[l_ac].xmde020,l_curr,l_exrate)
        RETURNING g_detail_d[l_ac].xmde014,g_detail_d[l_ac].xmde015,g_detail_d[l_ac].xmde016,
                  l_xrcd113,l_xrcd114,l_xrcd115
END FUNCTION

################################################################################
# Descriptions...: 資料處理
# Memo...........:
# Usage..........: CALL axmp431_batch_execute()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_batch_execute()
DEFINE l_success         LIKE type_t.num5
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE ls_js             STRING
DEFINE lc_param          type_parameter
DEFINE la_param          RECORD
          prog           STRING,
          param          DYNAMIC ARRAY OF STRING
                         END RECORD

   #合約編號帶出預設值
   IF cl_null(g_param.xmfjdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00678'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      RETURN
   ELSE
      CALL axmp431_xmfjdocno_default(g_param.xmfjdocno)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN
      END IF
   END IF
   
   CALL axmp431_create_temptable() RETURNING l_success
   IF NOT l_success THEN
      RETURN 
   END IF
   
   #若有需要產生分錄時要呼叫的TEMP TABLE
   CALL s_aapp330_cre_tmp() RETURNING l_success
   IF NOT l_success THEN 
      RETURN
   END IF
   CALL s_tax_recount_tmp()
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #將勾選的資料新增到temp table
   CALL axmp431_ins_temptable() RETURNING l_success
   IF l_success THEN
      CASE g_xmfj019 
         WHEN '1'   #銷退折讓
              #新增銷退單
              CALL axmp431_ins_axmt600() RETURNING l_success
         WHEN '2'   #雜項應付
              #新增雜項應付
              CALL axmp431_ins_aapt301() RETURNING l_success
      END CASE
   END IF
   
   CALL cl_err_collect_show()
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      IF cl_ask_confirm('aps-00127') THEN
         CASE g_xmfj019
            WHEN '1'
                 LET la_param.prog = 'axmt600'
                 LET la_param.param[1] = g_gen_doc
            WHEN '2'
                 LET la_param.prog = 'aapt301'
                 LET la_param.param[1] = g_apca.apcald
                 LET la_param.param[2] = g_apca.apcadocno
         END CASE
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   CALL axmp431_drop_temptable()
END FUNCTION

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL axmp431_create_temptable()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_create_temptable()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   CALL axmp431_drop_temptable()
   CREATE TEMP TABLE axmp431_temp1(
      xmfj003         VARCHAR(10),          #帳款客戶
      xmfj004         VARCHAR(10),          #幣別
      xmfj005         VARCHAR(10),          #稅別
      xmfj006         DECIMAL(5,2),          #稅率
      xmfj007         VARCHAR(1),          #含稅否
      xmfj008         VARCHAR(10),          #收款條件
      xmfj009         VARCHAR(10),          #交易條件
      xmfj010         VARCHAR(10),          #銷售通路
      exrate          DECIMAL(20,10),          #匯率
      xmde001         VARCHAR(20),          #合約編號
      xmde002         INTEGER,          #合約項次
      xmde003         VARCHAR(20),          #出貨/銷退單號
      xmde004         INTEGER,          #出貨/銷退項次
      xmde006         VARCHAR(40),          #料件編號
      xmde007         VARCHAR(256),          #產品特徵
      xmde014         DECIMAL(20,6),          #未稅金額
      xmde015         DECIMAL(20,6),          #含稅金額
      xmde016         DECIMAL(20,6),          #稅額
      xmde020         DECIMAL(20,6),          #折扣數量
      xmde029         DECIMAL(20,6),          #調整折扣單價
      xmde005        DATETIME YEAR TO SECOND  
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axmp431_tmp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: Drop Temp Table
# Memo...........:
# Usage..........: CALL axmp431_drop_temptable()
#                  
# Input parameter: 
# Return code....:  
# Date & Author..: 2015/06/12 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_drop_temptable()

   DROP TABLE axmp431_temp1;
   
END FUNCTION

################################################################################
# Descriptions...: 將勾選的資料新增到Temp Table
# Memo...........:
# Usage..........: CALL axmp431_ins_temptable()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_ins_temptable()
DEFINE r_success         LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_xmfj004         LIKE xmfj_t.xmfj004
DEFINE l_xmfj005         LIKE xmfj_t.xmfj005
DEFINE l_xmfj006         LIKE xmfj_t.xmfj006
DEFINE l_xmfj007         LIKE xmfj_t.xmfj007
DEFINE l_xmfj008         LIKE xmfj_t.xmfj008
DEFINE l_xmfj009         LIKE xmfj_t.xmfj009
DEFINE l_xmfj010         LIKE xmfj_t.xmfj010
DEFINE l_exrate          LIKE ooan_t.ooan005
DEFINE l_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   FOR l_i = 1 TO g_detail_d.getLength()
      IF cl_null(g_detail_d[l_i].xmde001) THEN
         CONTINUE FOR
      END IF
      
      LET l_xmfj004 = ''
      LET l_xmfj005 = ''
      LET l_xmfj006 = ''
      LET l_xmfj007 = ''
      LET l_xmfj008 = ''
      LET l_xmfj009 = ''
      LET l_xmfj010 = ''
      LET l_exrate = ''
      CASE g_param.l_exchange_rate
         WHEN '1'   #當下匯率
              #幣別、稅別、稅率、含稅否、收款條件、交易條件、銷售通路
              SELECT xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010
                INTO l_xmfj004,l_xmfj005,l_xmfj006,l_xmfj007,l_xmfj008,l_xmfj009,l_xmfj010
                FROM xmfj_t
               WHERE xmfjent = g_enterprise
                 AND xmfjdocno = g_detail_d[l_i].xmde001
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'sel xmfj_t:',g_detail_d[l_i].xmde001
                 LET g_errparam.popup = TRUE
                 
                 CALL cl_err()
                 LET r_success = FALSE
                 EXIT FOR
              END IF
              
              #匯率：當前匯率
              CALL axmp431_get_exrate(g_detail_d[l_i].xmfj003,l_xmfj004) RETURNING l_success,l_exrate
              IF NOT l_success THEN
                 LET r_success = FALSE
                 EXIT FOR
              END IF
         WHEN '2'   #依據出貨單原始匯率
              #幣別、稅別、稅率、含稅否、收款條件、交易條件、銷售通路、匯率
              SELECT xmdk016,xmdk012,xmdk013,xmdk014,xmdk010,xmdk011,xmdk030,xmdk017
                INTO l_xmfj004,l_xmfj005,l_xmfj006,l_xmfj007,l_xmfj008,l_xmfj009,l_xmfj010,l_exrate
                FROM xmdk_t
               WHERE xmdkent = g_enterprise
                 AND xmdkdocno = g_detail_d[l_i].xmde003
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'sel xmdk_t:',g_detail_d[l_i].xmde003
                 LET g_errparam.popup = TRUE
                 
                 CALL cl_err()
                 LET r_success = FALSE
                 EXIT FOR
              END IF
      END CASE
      
      INSERT INTO axmp431_temp1(xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010,exrate,
                                xmde001,xmde002,xmde003,xmde004,xmde006,xmde007,xmde014,xmde015,xmde016,
                                xmde020,xmde029,xmde005)
         VALUES(g_detail_d[l_i].xmfj003,l_xmfj004,l_xmfj005,l_xmfj006,l_xmfj007,l_xmfj008,l_xmfj009,l_xmfj010,l_exrate,
                g_detail_d[l_i].xmde001,g_detail_d[l_i].xmde002,g_detail_d[l_i].xmde003,g_detail_d[l_i].xmde004,
                g_detail_d[l_i].xmde006,g_detail_d[l_i].xmde007,g_detail_d[l_i].xmde014,g_detail_d[l_i].xmde015,
                g_detail_d[l_i].xmde016,g_detail_d[l_i].xmde020,g_detail_d[l_i].xmde029,g_detail_d[l_i].xmde005)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins temp'
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
   END FOR
   
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM axmp431_temp1
   IF cl_null(l_cnt) OR l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00063'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取當前的匯率
# Memo...........:
# Usage..........: CALL axmp431_get_exrate(p_customer,p_curr)
#                  RETURNING r_success,r_exrate
# Input parameter: p_customer     客戶編號
#                : p_curr         幣別
# Return code....: r_success      TRUE/FALSE
#                : r_exrate       匯率
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_get_exrate(p_customer,p_curr)
DEFINE p_customer        LIKE pmaa_t.pmaa001
DEFINE p_curr            LIKE ooai_t.ooai001
DEFINE r_success         LIKE type_t.num5
DEFINE r_exrate          LIKE ooan_t.ooan005
DEFINE l_success         LIKE type_t.num5
DEFINE l_controlno       LIKE ooha_t.ooha001

   LET r_success = TRUE
   LET r_exrate = ''
   
   IF cl_null(p_customer) OR cl_null(p_curr) THEN
      RETURN r_success,r_exrate
   END IF
   
   #取得控制組編號
   CALL s_control_get_group('2',g_user,g_dept) RETURNING l_success,l_controlno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL s_apmm101_default_pmab('2',l_controlno,g_site,p_customer)   
        #161109-00085#11-s mod
#        RETURNING g_pmab.*
        RETURNING g_pmab.prog,g_pmab.pmab033,g_pmab.pmab034,g_pmab.pmab037,g_pmab.pmab038,
                  g_pmab.pmab039,g_pmab.pmab040,g_pmab.pmab041,g_pmab.pmab042,g_pmab.pmab053,
                  g_pmab.pmab054,g_pmab.pmab056,g_pmab.pmab057,g_pmab.pmab058,g_pmab.pmab031,
                  g_pmab.pmab059,g_pmab.pmab043
        #161109-00085#11-e mod
        
   CALL s_axmt540_get_exchange(g_pmab.pmab057,p_curr,g_today)   #modify--151118-00012#1 By Shiun      新增傳入參數g_today
        RETURNING r_exrate
     
   RETURN r_success,r_exrate   
END FUNCTION

################################################################################
# Descriptions...: 新增銷退單
# Memo...........:
# Usage..........: CALL axmp431_ins_axmt600()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_ins_axmt600()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_xmdk007         LIKE xmdk_t.xmdk007
DEFINE l_xmdk010         LIKE xmdk_t.xmdk010
DEFINE l_xmdk011         LIKE xmdk_t.xmdk011
DEFINE l_xmdk012         LIKE xmdk_t.xmdk012
DEFINE l_xmdk013         LIKE xmdk_t.xmdk013
DEFINE l_xmdk014         LIKE xmdk_t.xmdk014
DEFINE l_xmdk016         LIKE xmdk_t.xmdk016
DEFINE l_xmdk017         LIKE xmdk_t.xmdk017
DEFINE l_xmdk030         LIKE xmdk_t.xmdk030
DEFINE l_xmdk086         LIKE xmdk_t.xmdk086
DEFINE l_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5
DEFINE l_tot_success     LIKE type_t.num5
DEFINE l_xmde001         LIKE xmde_t.xmde001
DEFINE l_xmde002         LIKE xmde_t.xmde002
DEFINE l_xmde003         LIKE xmde_t.xmde003
DEFINE l_xmde004         LIKE xmde_t.xmde004
DEFINE l_xmde005         LIKE xmde_t.xmde005
DEFINE l_xmde006         LIKE xmde_t.xmde006
DEFINE l_xmde007         LIKE xmde_t.xmde007
DEFINE l_xmde014         LIKE xmde_t.xmde014
DEFINE l_xmde015         LIKE xmde_t.xmde015
DEFINE l_xmde016         LIKE xmde_t.xmde016
DEFINE l_xmde020         LIKE xmde_t.xmde020
DEFINE l_xmde029         LIKE xmde_t.xmde029
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_xrcd123         LIKE xrcd_t.xrcd123
DEFINE l_xrcd124         LIKE xrcd_t.xrcd124
DEFINE l_xrcd125         LIKE xrcd_t.xrcd125
DEFINE l_xrcd133         LIKE xrcd_t.xrcd133
DEFINE l_xrcd134         LIKE xrcd_t.xrcd134
DEFINE l_xrcd135         LIKE xrcd_t.xrcd135
DEFINE l_seq             LIKE xmdl_t.xmdlseq

   LET r_success = TRUE
   LET l_tot_success = TRUE
   LET l_success = TRUE
   
   LET l_sql = "SELECT xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010,exrate,xmde001 ",
               "  FROM axmp431_temp1 ",
               " GROUP BY xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010,exrate,xmde001 ",
               " ORDER BY xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,xmfj009,xmfj010,exrate,xmde001 "
   PREPARE axmp431_ins_axmt600_pre FROM l_sql
   DECLARE axmp431_ins_axmt600_cs CURSOR FOR axmp431_ins_axmt600_pre
   
   #2015/08/04 by stellar modify ----- (S)
   #不做匯總了
#   #將相同的料件+產品特徵、調整折扣單價做匯總產生銷退明細
#   LET l_sql = "SELECT xmde002,xmde006,xmde007,SUM(xmde020),xmde029",
#               "  FROM axmp431_temp1 ",
#               " WHERE xmfj003 = ? ",
#               "   AND xmfj004 = ? ",
#               "   AND xmfj005 = ? ",
#               "   AND xmfj006 = ? ",
#               "   AND xmfj007 = ? ",
#               "   AND xmfj008 = ? ",
#               "   AND xmfj009 = ? ",
#               "   AND xmfj010 = ? ",
#               "   AND exrate = ? ",
#               "   AND xmde001 = ? ",
#               " GROUP BY xmde002,xmde006,xmde007,xmde029 "
   LET l_sql = "SELECT xmde001,xmde002,xmde003,xmde004,xmde005,xmde006,xmde007,xmde014,xmde015,xmde016,xmde020,xmde029",
               "  FROM axmp431_temp1 ",
               " WHERE xmfj003 = ? ",
               "   AND xmfj004 = ? ",
               "   AND xmfj005 = ? ",
               "   AND xmfj006 = ? ",
               "   AND xmfj007 = ? ",
               "   AND xmfj008 = ? ",
               "   AND xmfj009 = ? ",
               "   AND xmfj010 = ? ",
               "   AND exrate = ? ",
               "   AND xmde001 = ? ",
               " ORDER BY xmde001,xmde002,xmde003,xmde004 "
   #2015/08/04 by stellar modify ----- (E)
   PREPARE axmp431_ins_axmt600_pre1 FROM l_sql
   DECLARE axmp431_ins_axmt600_cs1 CURSOR FOR axmp431_ins_axmt600_pre1
   
   #將有勾選產生帳款處理的xmde_t進行更新
   LET l_sql = "SELECT xmde001,xmde002,xmde003,xmde004,xmde005,xmde014,xmde015,xmde016 ",
               "  FROM axmp431_temp1 ",
               " WHERE xmfj003 = ? ",
               "   AND xmfj004 = ? ",
               "   AND xmfj005 = ? ",
               "   AND xmfj006 = ? ",
               "   AND xmfj007 = ? ",
               "   AND xmfj008 = ? ",
               "   AND xmfj009 = ? ",
               "   AND xmfj010 = ? ",
               "   AND exrate = ? ",
               "   AND xmde001 = ? ",
               "   AND xmde002 = ? ",
               "   AND xmde006 = ? ",
               "   AND xmde007 = ? ",
               "   AND xmde029 = ? "
   PREPARE axmp431_ins_axmt600_pre2 FROM l_sql
   DECLARE axmp431_ins_axmt600_cs2 CURSOR FOR axmp431_ins_axmt600_pre2
   
   FOREACH axmp431_ins_axmt600_cs INTO l_xmdk007,l_xmdk016,l_xmdk012,l_xmdk013,l_xmdk014,
                                       l_xmdk010,l_xmdk011,l_xmdk030,l_xmdk017,l_xmdk086
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axmp431_ins_axmt600_cs:'
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT l_success THEN
         LET l_tot_success = FALSE
      END IF
      LET l_success = TRUE
      
      #銷售單頭新增
      INITIALIZE g_xmdk.* TO NULL
      
      #新增預設
      CALL axmp431_xmdk_init()
      
      #單據別預設
      CALL axmp431_xmdk_doc_default()
      
      #客戶預設
      LET g_xmdk.xmdk007 = l_xmdk007
      CALL axmp431_xmdk_customer_default()
           RETURNING l_success1
      IF NOT l_success1 THEN
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF
      
      #給值
      LET g_xmdk.xmdk005 = NULL   #出貨單號
      LET g_xmdk.xmdk008 = g_xmdk.xmdk007   #帳款客戶
      LET g_xmdk.xmdk009 = g_xmdk.xmdk007   #收貨客戶
      LET g_xmdk.xmdk202 = g_xmdk.xmdk007   #發票客戶
      LET g_xmdk.xmdk045 = '1'   #多角性質
      LET g_xmdk.xmdk082 = '4'   #銷退方式
      LET g_xmdk.xmdk085 = '4'   #資料來源
      LET g_xmdk.xmdk086 = l_xmdk086   #來源單號
      
      #幣別、稅別、稅率、含稅否、收款條件、交易條件、銷售通路、匯率給值
      LET g_xmdk.xmdk016 = l_xmdk016
      LET g_xmdk.xmdk012 = l_xmdk012
      LET g_xmdk.xmdk013 = l_xmdk013
      LET g_xmdk.xmdk014 = l_xmdk014
      LET g_xmdk.xmdk010 = l_xmdk010
      LET g_xmdk.xmdk011 = l_xmdk011
      LET g_xmdk.xmdk030 = l_xmdk030
      LET g_xmdk.xmdk017 = l_xmdk017
      
      #單據別自動編碼
      CALL s_aooi200_gen_docno(g_site,g_param.l_docno,g_xmdk.xmdkdocdt,'axmt600')
           RETURNING l_success,g_xmdk.xmdkdocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_param.l_docno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      
      #161109-00085#11-mod-s
      #INSERT INTO xmdk_t VALUES (g_xmdk.*)   #161109-00085#11   mark
      INSERT INTO xmdk_t (xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
                          xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,
                          xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,
                          xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,
                          xmdk035,xmdk036,xmdk037,xmdk038,xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,
                          xmdk045,xmdk051,xmdk052,xmdk053,xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,
                          xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,
                          xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,
                          xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt,xmdkstus,xmdkud001,xmdkud002,
                          xmdkud003,xmdkud004,xmdkud005,xmdkud006,xmdkud007,xmdkud008,xmdkud009,xmdkud010,xmdkud011,xmdkud012,
                          xmdkud013,xmdkud014,xmdkud015,xmdkud016,xmdkud017,xmdkud018,xmdkud019,xmdkud020,xmdkud021,xmdkud022,
                          xmdkud023,xmdkud024,xmdkud025,xmdkud026,xmdkud027,xmdkud028,xmdkud029,xmdkud030,xmdk085,xmdk086,
                          xmdk046,xmdk087,xmdk047,xmdk088,xmdk089)
                  VALUES (g_xmdk.xmdkent,g_xmdk.xmdksite,g_xmdk.xmdkunit,g_xmdk.xmdkdocno,g_xmdk.xmdkdocdt,
                          g_xmdk.xmdk000,g_xmdk.xmdk001,g_xmdk.xmdk002,g_xmdk.xmdk003,g_xmdk.xmdk004,
                          g_xmdk.xmdk005,g_xmdk.xmdk006,g_xmdk.xmdk007,g_xmdk.xmdk008,g_xmdk.xmdk009,
                          g_xmdk.xmdk010,g_xmdk.xmdk011,g_xmdk.xmdk012,g_xmdk.xmdk013,g_xmdk.xmdk014,
                          g_xmdk.xmdk015,g_xmdk.xmdk016,g_xmdk.xmdk017,g_xmdk.xmdk018,g_xmdk.xmdk019,
                          g_xmdk.xmdk020,g_xmdk.xmdk021,g_xmdk.xmdk022,g_xmdk.xmdk023,g_xmdk.xmdk024,
                          g_xmdk.xmdk025,g_xmdk.xmdk026,g_xmdk.xmdk027,g_xmdk.xmdk028,g_xmdk.xmdk029,
                          g_xmdk.xmdk030,g_xmdk.xmdk031,g_xmdk.xmdk032,g_xmdk.xmdk033,g_xmdk.xmdk034,
                          g_xmdk.xmdk035,g_xmdk.xmdk036,g_xmdk.xmdk037,g_xmdk.xmdk038,g_xmdk.xmdk039,
                          g_xmdk.xmdk040,g_xmdk.xmdk041,g_xmdk.xmdk042,g_xmdk.xmdk043,g_xmdk.xmdk044,
                          g_xmdk.xmdk045,g_xmdk.xmdk051,g_xmdk.xmdk052,g_xmdk.xmdk053,g_xmdk.xmdk054,
                          g_xmdk.xmdk055,g_xmdk.xmdk081,g_xmdk.xmdk082,g_xmdk.xmdk083,g_xmdk.xmdk084,
                          g_xmdk.xmdk200,g_xmdk.xmdk201,g_xmdk.xmdk202,g_xmdk.xmdk203,g_xmdk.xmdk204,
                          g_xmdk.xmdk205,g_xmdk.xmdk206,g_xmdk.xmdk207,g_xmdk.xmdk208,g_xmdk.xmdk209,
                          g_xmdk.xmdk210,g_xmdk.xmdk211,g_xmdk.xmdk212,g_xmdk.xmdk213,g_xmdk.xmdk214,
                          g_xmdk.xmdkownid,g_xmdk.xmdkowndp,g_xmdk.xmdkcrtid,g_xmdk.xmdkcrtdp,g_xmdk.xmdkcrtdt,
                          g_xmdk.xmdkmodid,g_xmdk.xmdkmoddt,g_xmdk.xmdkcnfid,g_xmdk.xmdkcnfdt,g_xmdk.xmdkpstid,
                          g_xmdk.xmdkpstdt,g_xmdk.xmdkstus,g_xmdk.xmdkud001,g_xmdk.xmdkud002,g_xmdk.xmdkud003,
                          g_xmdk.xmdkud004,g_xmdk.xmdkud005,g_xmdk.xmdkud006,g_xmdk.xmdkud007,g_xmdk.xmdkud008,
                          g_xmdk.xmdkud009,g_xmdk.xmdkud010,g_xmdk.xmdkud011,g_xmdk.xmdkud012,g_xmdk.xmdkud013,
                          g_xmdk.xmdkud014,g_xmdk.xmdkud015,g_xmdk.xmdkud016,g_xmdk.xmdkud017,g_xmdk.xmdkud018,
                          g_xmdk.xmdkud019,g_xmdk.xmdkud020,g_xmdk.xmdkud021,g_xmdk.xmdkud022,g_xmdk.xmdkud023,
                          g_xmdk.xmdkud024,g_xmdk.xmdkud025,g_xmdk.xmdkud026,g_xmdk.xmdkud027,g_xmdk.xmdkud028,
                          g_xmdk.xmdkud029,g_xmdk.xmdkud030,g_xmdk.xmdk085,g_xmdk.xmdk086,g_xmdk.xmdk046,
                          g_xmdk.xmdk087,g_xmdk.xmdk047,g_xmdk.xmdk088,g_xmdk.xmdk089)
       #161109-00085#11-mod-e
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins xmdk_t'
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #新增單身
      LET l_seq = 1
      OPEN axmp431_ins_axmt600_cs1 USING l_xmdk007,l_xmdk016,l_xmdk012,l_xmdk013,l_xmdk014,
                                         l_xmdk010,l_xmdk011,l_xmdk030,l_xmdk017,l_xmdk086
      #2015/08/04 by stellar modify ----- (S)
      #不做匯總
#      FOREACH axmp431_ins_axmt600_cs1 INTO l_xmde002,l_xmde006,l_xmde007,l_xmde020,l_xmde029
      FOREACH axmp431_ins_axmt600_cs1 INTO l_xmde001,l_xmde002,l_xmde003,l_xmde004,l_xmde005,
                                           l_xmde006,l_xmde007,l_xmde014,l_xmde015,l_xmde016,
                                           l_xmde020,l_xmde029
      #2015/08/04 by stellar modify ----- (E)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'axmp431_ins_axmt600_cs1:'
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         INITIALIZE g_xmdl.* TO NULL
         LET g_xmdl.xmdlent = g_xmdk.xmdkent
         LET g_xmdl.xmdlsite= g_xmdk.xmdksite
         LET g_xmdl.xmdldocno = g_xmdk.xmdkdocno
         LET g_xmdl.xmdlseq = l_seq
         
         #2015/08/04 by stellar add ----- (S)
         #出貨單號、出貨項次、訂單單號、訂單項次
         LET g_xmdl.xmdl001 = l_xmde003
         LET g_xmdl.xmdl002 = l_xmde004
         
         SELECT xmdl003,xmdl004,xmdl005 
           INTO g_xmdl.xmdl003,g_xmdl.xmdl004,g_xmdl.xmdl005
           FROM xmdl_t
          WHERE xmdlent = g_enterprise
            AND xmdldocno = g_xmdl.xmdl001
            AND xmdlseq = g_xmdl.xmdl002
         #2015/08/04 by stellar add ----- (E)
         
         LET g_xmdl.xmdl008 = l_xmde006
         LET g_xmdl.xmdl009 = l_xmde007
         
#         CALL s_axmt540_materials_search(g_xmdk.xmdk003,g_xmdk.xmdk004,g_xmdk.xmdk007,g_xmdl.xmdl008,g_xmdl.xmdl009)
#              RETURNING g_xmdl.xmdl007,g_xmdl.xmdl010,g_xmdl.xmdl017,g_xmdl.xmdl019,g_xmdl.xmdl021,
#                        g_xmdl.xmdl014,g_xmdl.xmdl015
                      
         LET g_xmdl.xmdl007 = '1'
         LET g_xmdl.xmdl013 = 'N'
         
         #單位
         SELECT xmfl006 INTO g_xmdl.xmdl017 
           FROM xmfl_t
          WHERE xmflent = g_enterprise
            AND xmfldocno = l_xmdk086
            AND xmflseq = l_xmde002
         
         LET g_xmdl.xmdl018 = l_xmde020
         
         #營運據點是否使用參考單位(若不使用為'')
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = "N" THEN
            LET g_xmdl.xmdl019 = ''  #參考單位
         END IF
         
         #推算參考數量
         IF NOT cl_null(g_xmdl.xmdl008) AND NOT cl_null(g_xmdl.xmdl017) AND
            NOT cl_null(g_xmdl.xmdl019) AND NOT cl_null(g_xmdl.xmdl018) THEN

            CALL s_aooi250_convert_qty(g_xmdl.xmdl008,g_xmdl.xmdl017,g_xmdl.xmdl019,g_xmdl.xmdl018)
                 RETURNING l_success1,g_xmdl.xmdl020
            IF NOT l_success1 THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         ELSE
            LET g_xmdl.xmdl020 = ''
         END IF
         
         LET g_xmdl.xmdl021 = g_xmdl.xmdl017
         LET g_xmdl.xmdl022 = g_xmdl.xmdl018
         LET g_xmdl.xmdl023 = 'N'
         LET g_xmdl.xmdl024 = l_xmde029
         
         #稅別、稅率
         LET g_xmdl.xmdl025 = g_xmdk.xmdk012
         LET g_xmdl.xmdl026 = g_xmdk.xmdk013
            
         #含未稅金額與稅額
         CALL s_tax_ins(g_xmdk.xmdkdocno,g_xmdl.xmdlseq,0,g_site,g_xmdl.xmdl022*g_xmdl.xmdl024,
                        g_xmdl.xmdl025,g_xmdl.xmdl022,g_xmdk.xmdk016,g_xmdk.xmdk017,'','','')
              RETURNING g_xmdl.xmdl027,g_xmdl.xmdl029,g_xmdl.xmdl028,l_xrcd113,l_xrcd114,l_xrcd115,
                        l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
         IF NOT g_sub_success THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         
         LET g_xmdl.xmdl050 = g_param.l_reason
         LET g_xmdl.xmdl087 = 'Y'
         LET g_xmdl.xmdl094 = g_xmdk.xmdk086
         LET g_xmdl.xmdl095 = l_xmde002
         
         
         #161109-00085#11-mod-s
         #INSERT INTO xmdl_t VALUES (g_xmdl.*)   #161109-00085#11   mark
         INSERT INTO xmdl_t (xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,
                             xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,xmdl016,
                             xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,xmdl022,xmdl023,xmdl024,xmdl025,xmdl026,
                             xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,xmdl036,
                             xmdl037,xmdl038,xmdl039,xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,xmdl046,
                             xmdl047,xmdl048,xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,xmdl081,
                             xmdl082,xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,xmdl091,
                             xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,xmdl207,
                             xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,xmdl216,xmdl217,
                             xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,xmdl226,xmdlunit,xmdlorga,
                             xmdlud001,xmdlud002,xmdlud003,xmdlud004,xmdlud005,xmdlud006,xmdlud007,xmdlud008,xmdlud009,xmdlud010,
                             xmdlud011,xmdlud012,xmdlud013,xmdlud014,xmdlud015,xmdlud016,xmdlud017,xmdlud018,xmdlud019,xmdlud020,
                             xmdlud021,xmdlud022,xmdlud023,xmdlud024,xmdlud025,xmdlud026,xmdlud027,xmdlud028,xmdlud029,xmdlud030,
                             xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057,xmdl058,xmdl096,xmdl059,xmdl060) 
                     VALUES (g_xmdl.xmdlent,g_xmdl.xmdlsite,g_xmdl.xmdldocno,g_xmdl.xmdlseq,g_xmdl.xmdl001,
                             g_xmdl.xmdl002,g_xmdl.xmdl003,g_xmdl.xmdl004,g_xmdl.xmdl005,g_xmdl.xmdl006,
                             g_xmdl.xmdl007,g_xmdl.xmdl008,g_xmdl.xmdl009,g_xmdl.xmdl010,g_xmdl.xmdl011,
                             g_xmdl.xmdl012,g_xmdl.xmdl013,g_xmdl.xmdl014,g_xmdl.xmdl015,g_xmdl.xmdl016,
                             g_xmdl.xmdl017,g_xmdl.xmdl018,g_xmdl.xmdl019,g_xmdl.xmdl020,g_xmdl.xmdl021,
                             g_xmdl.xmdl022,g_xmdl.xmdl023,g_xmdl.xmdl024,g_xmdl.xmdl025,g_xmdl.xmdl026,
                             g_xmdl.xmdl027,g_xmdl.xmdl028,g_xmdl.xmdl029,g_xmdl.xmdl030,g_xmdl.xmdl031,
                             g_xmdl.xmdl032,g_xmdl.xmdl033,g_xmdl.xmdl034,g_xmdl.xmdl035,g_xmdl.xmdl036,
                             g_xmdl.xmdl037,g_xmdl.xmdl038,g_xmdl.xmdl039,g_xmdl.xmdl040,g_xmdl.xmdl041,
                             g_xmdl.xmdl042,g_xmdl.xmdl043,g_xmdl.xmdl044,g_xmdl.xmdl045,g_xmdl.xmdl046,
                             g_xmdl.xmdl047,g_xmdl.xmdl048,g_xmdl.xmdl049,g_xmdl.xmdl050,g_xmdl.xmdl051,
                             g_xmdl.xmdl052,g_xmdl.xmdl053,g_xmdl.xmdl054,g_xmdl.xmdl055,g_xmdl.xmdl081,
                             g_xmdl.xmdl082,g_xmdl.xmdl083,g_xmdl.xmdl084,g_xmdl.xmdl085,g_xmdl.xmdl086,
                             g_xmdl.xmdl087,g_xmdl.xmdl088,g_xmdl.xmdl089,g_xmdl.xmdl090,g_xmdl.xmdl091,
                             g_xmdl.xmdl092,g_xmdl.xmdl093,g_xmdl.xmdl200,g_xmdl.xmdl201,g_xmdl.xmdl202,
                             g_xmdl.xmdl203,g_xmdl.xmdl204,g_xmdl.xmdl205,g_xmdl.xmdl206,g_xmdl.xmdl207,
                             g_xmdl.xmdl208,g_xmdl.xmdl209,g_xmdl.xmdl210,g_xmdl.xmdl211,g_xmdl.xmdl212,
                             g_xmdl.xmdl213,g_xmdl.xmdl214,g_xmdl.xmdl215,g_xmdl.xmdl216,g_xmdl.xmdl217,
                             g_xmdl.xmdl218,g_xmdl.xmdl219,g_xmdl.xmdl220,g_xmdl.xmdl222,g_xmdl.xmdl223,
                             g_xmdl.xmdl224,g_xmdl.xmdl225,g_xmdl.xmdl226,g_xmdl.xmdlunit,g_xmdl.xmdlorga,
                             g_xmdl.xmdlud001,g_xmdl.xmdlud002,g_xmdl.xmdlud003,g_xmdl.xmdlud004,g_xmdl.xmdlud005,
                             g_xmdl.xmdlud006,g_xmdl.xmdlud007,g_xmdl.xmdlud008,g_xmdl.xmdlud009,g_xmdl.xmdlud010,
                             g_xmdl.xmdlud011,g_xmdl.xmdlud012,g_xmdl.xmdlud013,g_xmdl.xmdlud014,g_xmdl.xmdlud015,
                             g_xmdl.xmdlud016,g_xmdl.xmdlud017,g_xmdl.xmdlud018,g_xmdl.xmdlud019,g_xmdl.xmdlud020,
                             g_xmdl.xmdlud021,g_xmdl.xmdlud022,g_xmdl.xmdlud023,g_xmdl.xmdlud024,g_xmdl.xmdlud025,
                             g_xmdl.xmdlud026,g_xmdl.xmdlud027,g_xmdl.xmdlud028,g_xmdl.xmdlud029,g_xmdl.xmdlud030,
                             g_xmdl.xmdl056,g_xmdl.xmdl094,g_xmdl.xmdl095,g_xmdl.xmdl227,g_xmdl.xmdl228,
                             g_xmdl.xmdl057,g_xmdl.xmdl058,g_xmdl.xmdl096,g_xmdl.xmdl059,g_xmdl.xmdl060)
         #161109-00085#11-mod-e
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins xmdl_t'
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         INSERT INTO xmdm_t(xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                            xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                            xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                            xmdm011,xmdm012,xmdm013,xmdm014,
                            xmdm033)
            VALUES(g_enterprise,g_site,g_xmdk.xmdkdocno,g_xmdl.xmdlseq,1,
                   g_xmdl.xmdl008,g_xmdl.xmdl009,g_xmdl.xmdl011,g_xmdl.xmdl012,g_xmdl.xmdl014,
                   g_xmdl.xmdl015,g_xmdl.xmdl016,g_xmdl.xmdl017,g_xmdl.xmdl018,g_xmdl.xmdl019,
                   g_xmdl.xmdl020,0,0,0,
                   g_xmdl.xmdl052)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins xmdm_t'
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         LET l_seq = l_seq + 1
         
         #2015/08/04 by stellar modify ----- (S)
#         OPEN axmp431_ins_axmt600_cs2 USING l_xmdk007,l_xmdk016,l_xmdk012,l_xmdk013,l_xmdk014,
#                                            l_xmdk010,l_xmdk011,l_xmdk030,l_xmdk017,l_xmdk086,
#                                            l_xmde002,l_xmde006,l_xmde007,l_xmde029
#         FOREACH axmp431_ins_axmt600_cs2 INTO l_xmde001,l_xmde002,l_xmde003,l_xmde004,l_xmde005,
#                                              l_xmde014,l_xmde015,l_xmde016
#      
#            UPDATE xmde_t SET xmde025 = '2',
#                              xmde026 = g_xmfj019,
#                              xmde027 = g_xmdk.xmdkdocno,
#                              xmde028 = g_xmdl.xmdlseq,
#                              xmde029 = g_xmdl.xmdl024,
#                              xmde014 = l_xmde014,
#                              xmde015 = l_xmde015,
#                              xmde016 = l_xmde016
#             WHERE xmdeent = g_enterprise
#               AND xmde000 = '3'
#               AND xmde001 = l_xmde001
#               AND xmde002 = l_xmde002
#               AND xmde003 = l_xmde003
#               AND xmde004 = l_xmde004
#               AND xmde005 = l_xmde005
#            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'upd xmde_t'
#               LET g_errparam.popup = TRUE
#                  
#               CALL cl_err()
#               LET r_success = FALSE
#               EXIT FOREACH
#            END IF
#         END FOREACH
         UPDATE xmde_t SET xmde025 = '2',
                           xmde026 = g_xmfj019,
                           xmde027 = g_xmdk.xmdkdocno,
                           xmde028 = g_xmdl.xmdlseq,
                           xmde029 = g_xmdl.xmdl024,
                           xmde014 = l_xmde014,
                           xmde015 = l_xmde015,
                           xmde016 = l_xmde016
          WHERE xmdeent = g_enterprise
            AND xmde000 = '3'
            AND xmde001 = l_xmde001
            AND xmde002 = l_xmde002
            AND xmde003 = l_xmde003
            AND xmde004 = l_xmde004
            AND xmde005 = l_xmde005
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd xmde_t'
            LET g_errparam.popup = TRUE
               
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         #2015/08/04 by stellar modify ----- (E)
         
         IF NOT r_success THEN
            EXIT FOREACH
         END IF
      END FOREACH
         
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
      
      #整單含未稅金額與稅額
      CALL s_tax_recount(g_xmdk.xmdkdocno)
           RETURNING g_xmdk.xmdk051,g_xmdk.xmdk053,g_xmdk.xmdk052,
                     l_xrcd113,l_xrcd114,l_xrcd115
      UPDATE xmdk_t SET xmdk051 = g_xmdk.xmdk051,
                        xmdk052 = g_xmdk.xmdk052,
                        xmdk053 = g_xmdk.xmdk053
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = g_xmdk.xmdkdocno
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd xmdk_t'
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #2015/07/22 by stellar mark ----- (S)
#      #同雜項應付一樣不做確認過帳
#      #銷退單確認過帳
#      CALL s_axmt600_conf_chk(g_xmdk.xmdkdocno) RETURNING l_success1
#      IF NOT l_success1 THEN
#         LET l_success = FALSE
#         CONTINUE FOREACH
#      END IF
#      
#      CALL s_axmt600_conf_upd(g_xmdk.xmdkdocno) RETURNING l_success1
#      IF NOT l_success1 THEN
#         LET l_success = FALSE
#         CONTINUE FOREACH
#      END IF
#      
#      CALL s_axmt600_post_chk(g_xmdk.xmdkdocno) RETURNING l_success1
#      IF NOT l_success1 THEN
#         LET l_success = FALSE
#         CONTINUE FOREACH
#      END IF
#      
#      CALL s_axmt600_post_upd(g_xmdk.xmdkdocno,'') RETURNING l_success1
#      IF NOT l_success1 THEN
#         LET l_success = FALSE
#         CONTINUE FOREACH
#      END IF
      #2015/07/22 by stellar mark ----- (E)
      
      IF cl_null(g_gen_doc) THEN
         LET g_gen_doc = g_xmdk.xmdkdocno
      ELSE
         LET g_gen_doc = g_gen_doc,"','", g_xmdk.xmdkdocno
      END IF
   END FOREACH
   
   IF NOT l_tot_success OR NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 銷售單頭新增預設
# Memo...........:
# Usage..........: CALL axmp431_xmdk_init()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmdk_init()

   #公用欄位新增給值
   LET g_xmdk.xmdkownid = g_user
   LET g_xmdk.xmdkowndp = g_dept
   LET g_xmdk.xmdkcrtid = g_user
   LET g_xmdk.xmdkcrtdp = g_dept
   LET g_xmdk.xmdkcrtdt = cl_get_current()
   LET g_xmdk.xmdkmodid = g_user
   LET g_xmdk.xmdkmoddt = cl_get_current()
   LET g_xmdk.xmdkstus = 'N'
      
   #一般欄位給值
   LET g_xmdk.xmdkent = g_enterprise
   LET g_xmdk.xmdk000 = "6"
   LET g_xmdk.xmdk045 = "1"
   LET g_xmdk.xmdk082 = "1"
   LET g_xmdk.xmdk014 = "N"
   LET g_xmdk.xmdk084 = "1"
   LET g_xmdk.xmdk042 = "1"
   LET g_xmdk.xmdk043 = "1"
   LET g_xmdk.xmdk085 = "1"
   LET g_xmdk.xmdk083 = "N"
   LET g_xmdk.xmdksite = g_site
   LET g_xmdk.xmdkdocdt = g_today
   LET g_xmdk.xmdk001 = g_today
   LET g_xmdk.xmdkstus = 'N'
   LET g_xmdk.xmdk003 = g_user
   LET g_xmdk.xmdk004 = g_dept
   
END FUNCTION

################################################################################
# Descriptions...: 銷售單的單別預設
# Memo...........:
# Usage..........: CALL axmp431_xmdk_doc_default()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmdk_doc_default()
DEFINE l_success         LIKE type_t.num5
DEFINE l_oodbl004        LIKE oodbl_t.oodbl004
DEFINE l_oodb005         LIKE oodb_t.oodb005
DEFINE l_oodb006         LIKE oodb_t.oodb006
DEFINE l_oodb011         LIKE oodb_t.oodb011
   
   LET g_xmdk.xmdk001 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk001',g_xmdk.xmdk001)
   LET g_xmdk.xmdk003 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk003',g_xmdk.xmdk003)
   LET g_xmdk.xmdk004 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk004',g_xmdk.xmdk004)

   LET g_xmdk.xmdk007 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk007',g_xmdk.xmdk007)
   LET g_xmdk.xmdk008 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk008',g_xmdk.xmdk008)
   LET g_xmdk.xmdk009 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk009',g_xmdk.xmdk009)
   LET g_xmdk.xmdk010 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk010',g_xmdk.xmdk010)
   LET g_xmdk.xmdk011 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk011',g_xmdk.xmdk011)
   LET g_xmdk.xmdk012 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk012',g_xmdk.xmdk012)

   LET g_xmdk.xmdk015 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk015',g_xmdk.xmdk015)
   LET g_xmdk.xmdk016 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk016',g_xmdk.xmdk016)

   LET g_xmdk.xmdk018 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk018',g_xmdk.xmdk018)

   LET g_xmdk.xmdk030 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk030',g_xmdk.xmdk030)
   LET g_xmdk.xmdk031 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk031',g_xmdk.xmdk031)

   LET g_xmdk.xmdk033 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk033',g_xmdk.xmdk033)

   LET g_xmdk.xmdk042 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk042',g_xmdk.xmdk042)
   LET g_xmdk.xmdk043 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk043',g_xmdk.xmdk043)
   LET g_xmdk.xmdk044 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk044',g_xmdk.xmdk044)
   LET g_xmdk.xmdk045 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk045',g_xmdk.xmdk045)
   LET g_xmdk.xmdk054 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk054',g_xmdk.xmdk054)

   LET g_xmdk.xmdk202 = s_aooi200_get_doc_default(g_site,'1',g_param.l_docno,'xmdk202',g_xmdk.xmdk202)
   
   IF NOT cl_null(g_xmdk.xmdk012) THEN
      #檢查、取得稅別、單價含稅否
      CALL s_tax_chk(g_site,g_xmdk.xmdk012)
      RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011

      LET g_xmdk.xmdk013 = l_oodb006
      LET g_xmdk.xmdk014 = l_oodb005
   END IF

   IF NOT cl_null(g_xmdk.xmdk042) AND NOT cl_null(g_xmdk.xmdk016) THEN
      #帶出匯率
      CALL s_axmt540_get_exchange(g_xmdk.xmdk042,g_xmdk.xmdk016,g_today) RETURNING g_xmdk.xmdk017   #modify--151118-00012#1 By Shiun      新增傳入參數g_today
   END IF
END FUNCTION

################################################################################
# Descriptions...: 銷售單的客戶預設
# Memo...........:
# Usage..........: CALL axmp431_xmdk_customer_default()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_xmdk_customer_default()
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_controlno       LIKE ooha_t.ooha001

   LET r_success = TRUE

   #取得控制組編號
   CALL s_control_get_group('2',g_user,g_dept) RETURNING l_success,l_controlno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN
   END IF
   
   CALL s_apmm101_default_pmab('2',l_controlno,g_site,g_xmdk.xmdk007) 
        #161109-00085#11-s mod
#        RETURNING g_pmab.*
        RETURNING g_pmab.prog,g_pmab.pmab033,g_pmab.pmab034,g_pmab.pmab037,g_pmab.pmab038,
                  g_pmab.pmab039,g_pmab.pmab040,g_pmab.pmab041,g_pmab.pmab042,g_pmab.pmab053,
                  g_pmab.pmab054,g_pmab.pmab056,g_pmab.pmab057,g_pmab.pmab058,g_pmab.pmab031,
                  g_pmab.pmab059,g_pmab.pmab043
        #161109-00085#11-e mod
   
   #先判斷欄位是否在單據別設定的預設欄位中，如果存在，則不重新帶值，不存在，則根據交易對象帶預設值
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk003') THEN
      LET g_xmdk.xmdk003 = g_pmab.pmab031   #業務人員
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk004') THEN
      LET g_xmdk.xmdk004 = g_pmab.pmab059  #業務部門
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk015') THEN
      LET g_xmdk.xmdk015 = g_pmab.pmab056  #發票類型
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk018') THEN
      LET g_xmdk.xmdk018 = g_pmab.pmab054  #取價方式
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk042') THEN
      LET g_xmdk.xmdk042 = g_pmab.pmab057  #內外銷
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk043') THEN
      LET g_xmdk.xmdk043 = g_pmab.pmab058  #匯率計算基準
   END IF
   
   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_param.l_docno,'xmdk031') THEN
      LET g_xmdk.xmdk031 = g_pmab.pmab039  #銷售分類
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增雜項應付
# Memo...........:
# Usage..........: CALL axmp431_ins_aapt301()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_ins_aapt301()
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_amount          RECORD
          apcb103        LIKE apcb_t.apcb103,
          apcb113        LIKE apcb_t.apcb113,
          apcb123        LIKE apcb_t.apcb123,
          apcb133        LIKE apcb_t.apcb133,
          xrcd104        LIKE xrcd_t.xrcd104,
          xrcd114        LIKE xrcd_t.xrcd114,
          xrcd124        LIKE xrcd_t.xrcd124,
          xrcd134        LIKE xrcd_t.xrcd134,
          apca106        LIKE apca_t.apca106,
          apca116        LIKE apca_t.apca116,
          apca126        LIKE apca_t.apca126,
          apca136        LIKE apca_t.apca136,
          apca107        LIKE apca_t.apca107,
          apca117        LIKE apca_t.apca117,
          apca127        LIKE apca_t.apca127,
          apca137        LIKE apca_t.apca137,
          apca108        LIKE apca_t.apca108,
          apca118        LIKE apca_t.apca118,
          apca128        LIKE apca_t.apca128,
          apca138        LIKE apca_t.apca138
                         END RECORD
DEFINE l_chr             LIKE type_t.chr1
DEFINE l_ap_slip         LIKE apca_t.apcadocno
DEFINE l_desc            LIKE type_t.chr50

   LET r_success = TRUE
   
   #新增應付單頭
   CALL axmp431_ins_apca() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #新增應付單身
   CALL axmp431_ins_apcb() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #回寫apca_t單頭
   #161109-00085#11-s mod
#   CALL s_aap_clac_bill_master(g_apca.apcald,g_apca.apcadocno) RETURNING l_amount.*   #161109-00085#11-s mark
   CALL s_aap_clac_bill_master(g_apca.apcald,g_apca.apcadocno) RETURNING l_amount.apcb103,l_amount.apcb113,l_amount.apcb123,l_amount.apcb133,
                                                                         l_amount.xrcd104,l_amount.xrcd114,l_amount.xrcd124,l_amount.xrcd134,
                                                                         l_amount.apca106,l_amount.apca116,l_amount.apca126,l_amount.apca136,
                                                                         l_amount.apca107,l_amount.apca117,l_amount.apca127,l_amount.apca137,
                                                                         l_amount.apca108,l_amount.apca118,l_amount.apca128,l_amount.apca138
   #161109-00085#11-e mod
   #本幣匯率在寫入立帳單身後才回寫單頭匯率，因為本幣匯率是單身彙總條件之一，如果先取位了立帳單身會抓不到資料
   CALL s_curr_round_ld('1',g_apca.apcald,g_glaa001,g_apca.apca101,3) RETURNING l_success,g_errno,g_apca.apca101
    
   SELECT apcb001,apcb002 INTO g_apca.apca016,g_apca.apca018
     FROM apcb_t
    WHERE apcbent = g_enterprise
      AND apcbld = g_apca.apcald 
      AND apcbdocno = g_apca.apcadocno
      AND apcbseq = 1
       
   UPDATE apca_t SET (apca103,apca104,apca106,apca107,apca108,
                      apca113,apca114,apca116,apca117,apca118,
                      apca123,apca124,apca126,apca127,apca128,
                      apca133,apca134,apca136,apca137,apca138,
                      apca016,apca018,apca101
                     ) =
                     (l_amount.apcb103,l_amount.xrcd104,l_amount.apca106,l_amount.apca107,l_amount.apca108,
                      l_amount.apcb113,l_amount.xrcd114,l_amount.apca116,l_amount.apca117,l_amount.apca118,
                      l_amount.apcb123,l_amount.xrcd124,l_amount.apca126,l_amount.apca127,l_amount.apca128,
                      l_amount.apcb133,l_amount.xrcd134,l_amount.apca136,l_amount.apca137,l_amount.apca138,
                      g_apca.apca016  ,g_apca.apca018  ,g_apca.apca101
                     )
    WHERE apcaent = g_enterprise AND apcald = g_apca.apcald
      AND apcadocno = g_apca.apcadocno
      
   #立帳
   SELECT apbb051,apbb052 INTO g_apca.apca014,g_apca.apca015
     FROM apcb_t,apbb_t
    WHERE apcbent = g_enterprise  AND apcbent = apbbent
      AND apcb008 = apbbdocno
      AND apcbld  = g_apca.apcald AND apcbdocno = g_apca.apcadocno
      AND apcbseq = 1

   IF NOT cl_null(g_apca.apca015) THEN #以部門去取aooi125設定的所屬責任中心,若抓不到值則帶業務部門
      CALL s_department_get_respon_center(g_apca.apca015,g_apca.apcadocdt)
           RETURNING l_success,g_errno,g_apca.apca034,l_desc
   END IF
   IF NOT cl_null(g_apca.apca014) THEN
      UPDATE apca_t SET apca014 = g_apca.apca014,
                        apca015 = g_apca.apca015,
                        apca034 = g_apca.apca034
       WHERE apcaent = g_enterprise AND apcald = g_apca.apcald
         AND apcadocno= g_apca.apcadocno
   END IF
   
   IF cl_get_para(g_enterprise,g_apcacomp,'S-FIN-2002') = '3' THEN
      SELECT apcb030 INTO g_apca.apca008
        FROM apcb_t
       WHERE apcbent = g_enterprise
         AND apcbld  = g_apca.apcald AND apcbdocno = g_apca.apcadocno
         AND apcbseq = 1
      CALL s_fin_date_ap_payable(g_apca.apcacomp,g_apca.apca004,g_apca.apca008,g_apca.apcadocdt,g_apca.apcadocdt,g_apca.apcadocdt,'')
           RETURNING l_success,g_apca.apca009,g_apca.apca010
      UPDATE apca_t SET apca008 = g_apca.apca008,
                        apca009 = g_apca.apca009,
                        apca010 = g_apca.apca010
       WHERE apcaent = g_enterprise AND apcald = g_apca.apcald
         AND apcadocno = l_apca.apcadocno
   END IF
   
   #產生多帳期
   CALL s_aap_multi_bill_period(g_apca.apcald,g_apca.apcadocno ) RETURNING l_success,g_errno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
   END IF
   
   #產生分錄#
   CALL s_aooi200_fin_get_slip(g_apca.apcadocno) RETURNING l_success,l_ap_slip
   CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ap_slip,'D-FIN-0030') RETURNING l_chr
   IF g_glaa121 = 'Y' AND l_chr = 'Y'THEN
      CALL s_pre_voucher_ins('AP','P10',g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt,'1')
           RETURNING l_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增應付單頭
# Memo...........:
# Usage..........: CALL axmp431_ins_apca()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_ins_apca()
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_apca101         LIKE apca_t.apca101
DEFINE l_apca011         LIKE apca_t.apca011
DEFINE l_desc            LIKE type_t.chr50
DEFINE l_controlno       LIKE ooha_t.ooha001
DEFINE l_xmde001         LIKE xmde_t.xmde001

   LET r_success = TRUE
   
   INITIALIZE g_apca.* TO NULL
   LET g_apca.apcaent  = g_enterprise
   LET g_apca.apcald   = g_apcald
   LET g_apca.apcacomp = g_apcacomp
   LET g_apca.apcadocdt= g_today
   LET g_apca.apcasite = g_apcasite
   LET g_apca.apca001 = '19'
   LET g_apca.apca003 = g_user
   
   SELECT UNIQUE xmfj003,xmfj004,xmfj005,xmfj006,xmfj007,xmfj008,exrate,xmde001
     INTO g_apca.apca004,g_apca.apca100,g_apca.apca011,g_apca.apca012,g_apca.apca013,
          g_apca.apca008,g_apca.apca101,l_xmde001
     FROM axmp431_temp1
     
   #付款條件
   SELECT xmfj020 INTO g_apca.apca008
     FROM xmfj_t
    WHERE xmfjent = g_enterprise
      AND xmfjdocno = l_xmde001
     
   LET g_apca.apca005 = g_apca.apca004
   
   #供應商分類/企業關係人
   SELECT pmaa080,pmaa047 INTO g_apca.apca006,g_apca.apca046
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_apca.apca004
   
   #帳款資訊
   CALL s_aap_get_payment_term(g_apca.apcald,g_apca.apcacomp,g_apca.apca004,g_apca.apca001)
        RETURNING l_success,g_apca.apca015,l_desc,l_desc,g_apca.apca035,
                  g_apca.apca036,g_apca.apca058,l_desc,l_apca011,g_apca.apca014
   
   #帳款類別
   SELECT pmab055 INTO g_apca.apca007
     FROM pmab_t
    WHERE pmabent = g_enterprise
      AND pmabsite= g_site
      AND pmab001 = g_apca.apca004
   
   IF NOT cl_null(g_apca.apca007) THEN
      CALL s_aap_get_apca007_default_acct(g_apca.apcald,g_apca.apca007,g_apca.apca001)
           RETURNING g_apca.apca036,g_apca.apca035
   END IF
   
   CALL s_fin_date_ap_payable(g_apca.apcacomp,g_apca.apca004,g_apca.apca008,g_apca.apcadocdt,
                              g_apca.apcadocdt,g_apca.apcadocdt,'')
        RETURNING l_success,g_apca.apca009,g_apca.apca010
   
   LET g_apca.apca017 = '0'
   LET g_apca.apca020 = 'N'
   LET g_apca.apca025 = '0'
   LET g_apca.apca026 = '0'
   LET g_apca.apca027 = '0'
   LET g_apca.apca028 = '0'
   LET g_apca.apca029 = '0'
   
   #以部門去取aooi125設定的所屬責任中心,若抓不到值則帶業務部門
   IF NOT cl_null(g_apca.apca015) THEN
      CALL s_department_get_respon_center(g_apca.apca015,g_apca.apcadocdt)
           RETURNING l_success,g_errno,g_apca.apca034,l_desc
   END IF
   
   LET g_apca.apca039 = '0'
   LET g_apca.apca040 = 'N'
   LET g_apca.apca044 =  0
   LET g_apca.apca050 = '0'
   LET g_apca.apca052 = '0'          #列印次數
   
   IF cl_get_para(g_enterprise,g_apcacomp,'S-FIN-2002') MATCHES '[12]' THEN
      SELECT ooib025,ooib005 INTO g_apca.apca054,g_apca.apca055
        FROM ooib_t
       WHERE ooibent = g_enterprise
         AND ooib002 = g_apca.apca008
   END IF
   LET g_apca.apca056 = '0'
   LET g_apca.apca057 = g_apca.apca004
   LET g_apca.apca060 = '2'
   
   LET g_apca.apca120 = g_glaa016
   LET g_apca.apca130 = g_glaa020
   
   CALL s_fin_get_curr_rate(g_apca.apcacomp,g_apca.apcald,g_apca.apcadocdt,g_apca.apca100,'')
        RETURNING l_apca101,g_apca.apca121,g_apca.apca131

   #apca101為分帳條件因此 暫不取位，帶產生完單身後 在update apca101的值
   CALL s_curr_round_ld('1',g_apca.apcald,g_apca.apca120,g_apca.apca121,3) 
        RETURNING l_success,g_errno,g_apca.apca121
   CALL s_curr_round_ld('1',g_apca.apcald,g_apca.apca130,g_apca.apca131,3)
        RETURNING l_success,g_errno,g_apca.apca131
   LET g_apca.apca103 = '0'   LET g_apca.apca104 = '0'   LET g_apca.apca106 = '0'
   LET g_apca.apca107 = '0'   LET g_apca.apca108 = '0'
   LET g_apca.apca113 = '0'   LET g_apca.apca114 = '0'   LET g_apca.apca116 = '0'
   LET g_apca.apca117 = '0'   LET g_apca.apca118 = '0'
   LET g_apca.apca121 = '0'   LET g_apca.apca123 = '0'   LET g_apca.apca133 = '0'
   LET g_apca.apca131 = '0'   LET g_apca.apca124 = '0'   LET g_apca.apca134 = '0'
   
   LET g_apca.apcaownid = g_user
   LET g_apca.apcaowndp = g_dept
   LET g_apca.apcacrtid = g_user
   LET g_apca.apcacrtdp = g_dept
   LET g_apca.apcacrtdt = cl_get_current()
   LET g_apca.apcastus  = 'N'
   
   CALL s_aooi200_fin_gen_docno(g_apca.apcald,'','',g_param.l_docno,g_apca.apcadocdt,'aapt301')
        RETURNING l_success,g_apca.apcadocno
        
   
   #161109-00085#11-mod-s
   #INSERT INTO apca_t VALUES(g_apca.*)
   INSERT INTO apca_t(apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt,
                      apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,apca001,apca003,
                      apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,apca013,
                      apca014,apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,
                      apca026,apca027,apca028,apca029,apca030,apca031,apca032,apca033,apca034,apca035,
                      apca036,apca037,apca038,apca039,apca040,apca041,apca042,apca043,apca044,apca045,
                      apca046,apca047,apca048,apca049,apca050,apca051,apca052,apca053,apca054,apca055,
                      apca056,apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca064,apca065,
                      apca066,apca100,apca101,apca103,apca104,apca106,apca107,apca108,apca113,apca114,
                      apca116,apca117,apca118,apca120,apca121,apca123,apca124,apca126,apca127,apca128,
                      apca130,apca131,apca133,apca134,apca136,apca137,apca138,apcaud001,apcaud002,apcaud003,
                      apcaud004,apcaud005,apcaud006,apcaud007,apcaud008,apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,
                      apcaud014,apcaud015,apcaud016,apcaud017,apcaud018,apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,
                      apcaud024,apcaud025,apcaud026,apcaud027,apcaud028,apcaud029,apcaud030,apca067,apca068,apca069,
                      apca070,apca071,apca072,apca073)
               VALUES(g_apca.apcaent,g_apca.apcaownid,g_apca.apcaowndp,g_apca.apcacrtid,g_apca.apcacrtdp,
                      g_apca.apcacrtdt,g_apca.apcamodid,g_apca.apcamoddt,g_apca.apcacnfid,g_apca.apcacnfdt,
                      g_apca.apcapstid,g_apca.apcapstdt,g_apca.apcastus,g_apca.apcald,g_apca.apcacomp,
                      g_apca.apcadocno,g_apca.apcadocdt,g_apca.apcasite,g_apca.apca001,g_apca.apca003,
                      g_apca.apca004,g_apca.apca005,g_apca.apca006,g_apca.apca007,g_apca.apca008,
                      g_apca.apca009,g_apca.apca010,g_apca.apca011,g_apca.apca012,g_apca.apca013,
                      g_apca.apca014,g_apca.apca015,g_apca.apca016,g_apca.apca017,g_apca.apca018,
                      g_apca.apca019,g_apca.apca020,g_apca.apca021,g_apca.apca022,g_apca.apca025,
                      g_apca.apca026,g_apca.apca027,g_apca.apca028,g_apca.apca029,g_apca.apca030,
                      g_apca.apca031,g_apca.apca032,g_apca.apca033,g_apca.apca034,g_apca.apca035,
                      g_apca.apca036,g_apca.apca037,g_apca.apca038,g_apca.apca039,g_apca.apca040,
                      g_apca.apca041,g_apca.apca042,g_apca.apca043,g_apca.apca044,g_apca.apca045,
                      g_apca.apca046,g_apca.apca047,g_apca.apca048,g_apca.apca049,g_apca.apca050,
                      g_apca.apca051,g_apca.apca052,g_apca.apca053,g_apca.apca054,g_apca.apca055,
                      g_apca.apca056,g_apca.apca057,g_apca.apca058,g_apca.apca059,g_apca.apca060,
                      g_apca.apca061,g_apca.apca062,g_apca.apca063,g_apca.apca064,g_apca.apca065,
                      g_apca.apca066,g_apca.apca100,g_apca.apca101,g_apca.apca103,g_apca.apca104,
                      g_apca.apca106,g_apca.apca107,g_apca.apca108,g_apca.apca113,g_apca.apca114,
                      g_apca.apca116,g_apca.apca117,g_apca.apca118,g_apca.apca120,g_apca.apca121,
                      g_apca.apca123,g_apca.apca124,g_apca.apca126,g_apca.apca127,g_apca.apca128,
                      g_apca.apca130,g_apca.apca131,g_apca.apca133,g_apca.apca134,g_apca.apca136,
                      g_apca.apca137,g_apca.apca138,g_apca.apcaud001,g_apca.apcaud002,g_apca.apcaud003,
                      g_apca.apcaud004,g_apca.apcaud005,g_apca.apcaud006,g_apca.apcaud007,g_apca.apcaud008,
                      g_apca.apcaud009,g_apca.apcaud010,g_apca.apcaud011,g_apca.apcaud012,g_apca.apcaud013,
                      g_apca.apcaud014,g_apca.apcaud015,g_apca.apcaud016,g_apca.apcaud017,g_apca.apcaud018,
                      g_apca.apcaud019,g_apca.apcaud020,g_apca.apcaud021,g_apca.apcaud022,g_apca.apcaud023,
                      g_apca.apcaud024,g_apca.apcaud025,g_apca.apcaud026,g_apca.apcaud027,g_apca.apcaud028,
                      g_apca.apcaud029,g_apca.apcaud030,g_apca.apca067,g_apca.apca068,g_apca.apca069,
                      g_apca.apca070,g_apca.apca071,g_apca.apca072,g_apca.apca073)
   #161109-00085#11-mod-e
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apca_t'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增應付單身
# Memo...........:
# Usage..........: CALL axmp431_ins_apcb()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp431_ins_apcb()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_seq             LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_xmde001         LIKE xmde_t.xmde001
DEFINE l_xmde002         LIKE xmde_t.xmde002
DEFINE l_xmde003         LIKE xmde_t.xmde003
DEFINE l_xmde004         LIKE xmde_t.xmde004
DEFINE l_xmde005         LIKE xmde_t.xmde005
DEFINE l_xmde006         LIKE xmde_t.xmde006
DEFINE l_xmde007         LIKE xmde_t.xmde007
DEFINE l_xmde014         LIKE xmde_t.xmde014
DEFINE l_xmde015         LIKE xmde_t.xmde015
DEFINE l_xmde016         LIKE xmde_t.xmde016
DEFINE l_xmde020         LIKE xmde_t.xmde020
DEFINE l_xmde029         LIKE xmde_t.xmde029
DEFINE l_apcb105         LIKE apcb_t.apcb105

   LET r_success = TRUE
   
   LET l_sql = "SELECT xmde001,xmde002,xmde006,xmde007,SUM(xmde020),xmde029 ",
               "  FROM axmp431_temp1 ",
               " GROUP BY xmde001,xmde002,xmde006,xmde007,xmde029 ",
               " ORDER BY xmde001,xmde002,xmde006,xmde007,xmde029 "
   PREPARE axmp431_ins_apcb_pre FROM l_sql
   DECLARE axmp431_ins_apcb_cs CURSOR FOR axmp431_ins_apcb_pre
   
   LET l_sql = "SELECT xmde001,xmde002,xmde003,xmde004,xmde005,xmde014,xmde015,xmde016 ",
               "  FROM axmp431_temp1 ",
               " WHERE xmde001 = ? ",
               "   AND xmde002 = ? ",
               "   AND xmde006 = ? ",
               "   AND xmde007 = ? ",
               "   AND xmde029 = ? "
   PREPARE axmp431_ins_apcb_pre1 FROM l_sql
   DECLARE axmp431_ins_apcb_cs1 CURSOR FOR axmp431_ins_apcb_pre1
   
   LET l_seq = 1
   FOREACH axmp431_ins_apcb_cs INTO l_xmde001,l_xmde002,l_xmde006,l_xmde007,l_xmde020,l_xmde029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'axmp431_ins_apcb_cs:'
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   
      INITIALIZE g_apcb.* TO NULL
      
      LET g_apcb.apcbent = g_enterprise
      LET g_apcb.apcbld = g_apca.apcald
      LET g_apcb.apcborga = g_site
      LET g_apcb.apcbsite = g_apca.apcasite
      LET g_apcb.apcblegl = g_apca.apcacomp
      LET g_apcb.apcbdocno = g_apca.apcadocno
      LET g_apcb.apcbseq = l_seq
      LET g_apcb.apcb001 = '1C'
      LET g_apcb.apcb022 = 1
      LET g_apcb.apcb002 = l_xmde001
      LET g_apcb.apcb003 = l_xmde002
      LET g_apcb.apcb004 = l_xmde006
      LET g_apcb.apcb005 = s_aapt300_get_apcb005(g_apcb.apcb004,'','')
      
      #單位
      SELECT xmfl006 INTO g_apcb.apcb006
        FROM xmfl_t
       WHERE xmflent = g_enterprise
         AND xmfldocno = l_xmde001
         AND xmflseq = l_xmde002
      
      LET g_apcb.apcb007 = l_xmde020
      
      SELECT imaa009 INTO g_apcb.apcb012
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_apcb.apcb004
         
      LET g_apcb.apcb013 = 'N'
      LET g_apcb.apcb015 = g_apca.apca033   #專案編號
      LET g_apcb.apcb017 = g_apca.apca059   #預算編號
      LET g_apcb.apcb020 = g_apca.apca011   #稅別
      LET g_apcb.apcb021 = g_apca.apca036
      LET g_apcb.apcb023 = 'N'
      LET g_apcb.apcb029 = g_apca.apca035
      LET g_apcb.apcb030 = g_apca.apca008
      LET g_apcb.apcb100 = g_apca.apca100   #幣別
      LET g_apcb.apcb101 = l_xmde029        #原幣單價
      
      CALL s_curr_round_ld('1',g_apca.apcald,g_apcb.apcb100,g_apcb.apcb101,1) 
           RETURNING l_success,g_errno,g_apcb.apcb101
           
      LET g_apcb.apcb102  = g_apca.apca101                   #本幣匯率
      LET g_apcb.apcb111  = g_apcb.apcb101 * g_apca.apca101  #本幣單價
      
      CALL s_curr_round_ld('1',g_apca.apcald,g_glaa001,g_apcb.apcb111,1) 
           RETURNING l_success,g_errno,g_apcb.apcb111
           
      LET l_apcb105 = g_apcb.apcb007 * g_apcb.apcb101
      
      CALL s_curr_round_ld('1',g_apca.apcald,g_glaa001,l_apcb105,2) 
           RETURNING l_success,g_errno,l_apcb105

      CALL s_tax_ins(g_apca.apcadocno,g_apcb.apcbseq,'0',g_apcb.apcborga,l_apcb105,
                     g_apcb.apcb020,g_apcb.apcb007,g_apcb.apcb100,g_apca.apca101,
                     g_apca.apcald,g_apca.apca121,g_apca.apca131)
           RETURNING g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,
                     g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,
                     g_apcb.apcb123,g_apcb.apcb124,g_apcb.apcb125,
                     g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135
      
      LET g_apcb.apcb106 = 0  LET g_apcb.apcb107 = 0  LET g_apcb.apcb108 = g_apcb.apcb103
      LET g_apcb.apcb116 = 0  LET g_apcb.apcb117 = 0  LET g_apcb.apcb118 = g_apcb.apcb113  LET g_apcb.apcb119 = 0
      LET g_apcb.apcb126 = 0  LET g_apcb.apcb127 = 0  LET g_apcb.apcb128 = g_apcb.apcb123
      LET g_apcb.apcb136 = 0  LET g_apcb.apcb137 = 0  LET g_apcb.apcb138 = g_apcb.apcb133

     
      #161109-00085#11-mod-s 
      #INSERT INTO apcb_t VALUES(g_apcb.*)    #161109-00085#11   mark
      INSERT INTO apcb_t(apcbent,apcbld,apcblegl,apcborga,apcbsite,apcbdocno,apcbseq,apcb001,apcb002,apcb003,
                         apcb004,apcb005,apcb006,apcb007,apcb008,apcb009,apcb010,apcb011,apcb012,apcb013,
                         apcb014,apcb015,apcb016,apcb017,apcb018,apcb019,apcb020,apcb021,apcb022,apcb023,
                         apcb024,apcb025,apcb026,apcb027,apcb028,apcb029,apcb030,apcb032,apcb033,apcb034,
                         apcb035,apcb036,apcb037,apcb038,apcb039,apcb040,apcb041,apcb042,apcb043,apcb044,
                         apcb045,apcb046,apcb047,apcb048,apcb049,apcb050,apcb051,apcb100,apcb101,apcb102,
                         apcb103,apcb104,apcb105,apcb106,apcb107,apcb108,apcb111,apcb113,apcb114,apcb115,
                         apcb116,apcb117,apcb118,apcb119,apcb121,apcb123,apcb124,apcb125,apcb126,apcb127,
                         apcb128,apcb131,apcb133,apcb134,apcb135,apcb136,apcb137,apcb138,apcbud001,apcbud002,
                         apcbud003,apcbud004,apcbud005,apcbud006,apcbud007,apcbud008,apcbud009,apcbud010,apcbud011,apcbud012,
                         apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,apcbud018,apcbud019,apcbud020,apcbud021,apcbud022,
                         apcbud023,apcbud024,apcbud025,apcbud026,apcbud027,apcbud028,apcbud029,apcbud030,apcb052,apcb053,
                         apcb054,apcb055) 
                  VALUES(g_apcb.apcbent,g_apcb.apcbld,g_apcb.apcblegl,g_apcb.apcborga,g_apcb.apcbsite,
                         g_apcb.apcbdocno,g_apcb.apcbseq,g_apcb.apcb001,g_apcb.apcb002,g_apcb.apcb003,
                         g_apcb.apcb004,g_apcb.apcb005,g_apcb.apcb006,g_apcb.apcb007,g_apcb.apcb008,
                         g_apcb.apcb009,g_apcb.apcb010,g_apcb.apcb011,g_apcb.apcb012,g_apcb.apcb013,
                         g_apcb.apcb014,g_apcb.apcb015,g_apcb.apcb016,g_apcb.apcb017,g_apcb.apcb018,
                         g_apcb.apcb019,g_apcb.apcb020,g_apcb.apcb021,g_apcb.apcb022,g_apcb.apcb023,
                         g_apcb.apcb024,g_apcb.apcb025,g_apcb.apcb026,g_apcb.apcb027,g_apcb.apcb028,
                         g_apcb.apcb029,g_apcb.apcb030,g_apcb.apcb032,g_apcb.apcb033,g_apcb.apcb034,
                         g_apcb.apcb035,g_apcb.apcb036,g_apcb.apcb037,g_apcb.apcb038,g_apcb.apcb039,
                         g_apcb.apcb040,g_apcb.apcb041,g_apcb.apcb042,g_apcb.apcb043,g_apcb.apcb044,
                         g_apcb.apcb045,g_apcb.apcb046,g_apcb.apcb047,g_apcb.apcb048,g_apcb.apcb049,
                         g_apcb.apcb050,g_apcb.apcb051,g_apcb.apcb100,g_apcb.apcb101,g_apcb.apcb102,
                         g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,g_apcb.apcb106,g_apcb.apcb107,
                         g_apcb.apcb108,g_apcb.apcb111,g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,
                         g_apcb.apcb116,g_apcb.apcb117,g_apcb.apcb118,g_apcb.apcb119,g_apcb.apcb121,
                         g_apcb.apcb123,g_apcb.apcb124,g_apcb.apcb125,g_apcb.apcb126,g_apcb.apcb127,
                         g_apcb.apcb128,g_apcb.apcb131,g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135,
                         g_apcb.apcb136,g_apcb.apcb137,g_apcb.apcb138,g_apcb.apcbud001,g_apcb.apcbud002,
                         g_apcb.apcbud003,g_apcb.apcbud004,g_apcb.apcbud005,g_apcb.apcbud006,g_apcb.apcbud007,
                         g_apcb.apcbud008,g_apcb.apcbud009,g_apcb.apcbud010,g_apcb.apcbud011,g_apcb.apcbud012,
                         g_apcb.apcbud013,g_apcb.apcbud014,g_apcb.apcbud015,g_apcb.apcbud016,g_apcb.apcbud017,
                         g_apcb.apcbud018,g_apcb.apcbud019,g_apcb.apcbud020,g_apcb.apcbud021,g_apcb.apcbud022,
                         g_apcb.apcbud023,g_apcb.apcbud024,g_apcb.apcbud025,g_apcb.apcbud026,g_apcb.apcbud027,
                         g_apcb.apcbud028,g_apcb.apcbud029,g_apcb.apcbud030,g_apcb.apcb052,g_apcb.apcb053,
                         g_apcb.apcb054,g_apcb.apcb055)
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apcb_t'
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      OPEN axmp431_ins_apcb_cs1 USING l_xmde001,l_xmde002,l_xmde006,l_xmde007,l_xmde029
      FOREACH axmp431_ins_apcb_cs1 INTO l_xmde001,l_xmde002,l_xmde003,l_xmde004,l_xmde005,
                                        l_xmde014,l_xmde015,l_xmde016
         
         UPDATE xmde_t SET xmde025 = '2',
                           xmde026 = g_xmfj019,
                           xmde027 = g_apca.apcadocno,
                           xmde028 = g_apcb.apcbseq,
                           xmde029 = l_xmde029,
                           xmde014 = l_xmde014,
                           xmde015 = l_xmde015,
                           xmde016 = l_xmde016
             WHERE xmdeent = g_enterprise
               AND xmde000 = '3'
               AND xmde001 = l_xmde001
               AND xmde002 = l_xmde002
               AND xmde003 = l_xmde003
               AND xmde004 = l_xmde004
               AND xmde005 = l_xmde005
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd xmde_t'
            LET g_errparam.popup = TRUE
         
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      LET l_seq = l_seq + 1
   END FOREACH
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
