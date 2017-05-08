#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-09-10 20:38:01), PR版次:0005(2016-12-01 16:15:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000296
#+ Filename...: axrp350
#+ Description: 應收單轉發票作業_取消
#+ Creator....: 02114(2014-09-02 10:16:53)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp350.global" >}
#應用 p02 樣板自動產生(Version:20)
#add-point:填寫註解說明 name="global.memo"
#151023-00016#1   2015/10/26  By 01727 錯誤訊息改為正規報錯
#160318-00005#52  2016/03/29  By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息
#160413-00024#1   2016/04/14  By 01727 打开作业后，预设的账套信息非g_site对应的主账套
#160318-00025#35  2016/04/15  By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161128-00061#3   2016/12/01  by 02481 标准程式定义采用宣告模式,弃用.*写法
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
        xrcald           LIKE xrca_t.xrcald,
        xrcald_desc      LIKE type_t.chr80,
        glaacomp         LIKE glaa_t.glaacomp,
        glaacomp_desc    LIKE type_t.chr80,
        isae004          LIKE isae_t.isae004,
        isae004_desc     LIKE type_t.chr80,
        xmdk016          LIKE xmdk_t.xmdk016,
        total_type       LIKE type_t.chr1,
        isah_type        LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel               LIKE type_t.chr1,
     b_xrcald          LIKE xrca_t.xrcald,
     b_xrcadocno       LIKE xrca_t.xrcadocno,
     b_xrcadocdt       LIKE xrca_t.xrcadocdt,
     b_xrca004         LIKE type_t.chr80,
     b_xrca061         LIKE xrca_t.xrca061,
     b_xrca028         LIKE xrca_t.xrca028,
     xrca028_desc      LIKE type_t.chr80,
     b_xrcb001         LIKE xrcb_t.xrcb001,
     b_xrcb002         LIKE xrcb_t.xrcb002,
     b_xrcb003         LIKE xrcb_t.xrcb003,
     b_xrcb005         LIKE xrcb_t.xrcb005,
     b_xrcb007         LIKE xrcb_t.xrcb007,
     b_xrcb103         LIKE xrcb_t.xrcb103,
     b_xrcb104         LIKE xrcb_t.xrcb104,
     b_xrcb105         LIKE xrcb_t.xrcb105,
     b_xmdl022         LIKE xmdl_t.xmdl022,
     b_xmdl047         LIKE xmdl_t.xmdl047,
     b_xrcborga        LIKE xrcb_t.xrcborga,
     seq               LIKE type_t.num5
     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_input        type_parameter
DEFINE g_ooef004      LIKE ooef_t.ooef004     
DEFINE g_ooef019      LIKE ooef_t.ooef019
DEFINE g_ooef016      LIKE ooef_t.ooef016
DEFINE g_isac003      LIKE isac_t.isac003
DEFINE g_rec_b        LIKE type_t.num5              #單身筆數

TYPE type_g_isae_m RECORD
       isafdocno           LIKE isaf_t.isafdocno,
       isafdocno_desc      LIKE type_t.chr80,
       isafdocdt_type      LIKE type_t.chr1, 
       isaf014             LIKE isaf_t.isaf014,
       isaf004             LIKE isaf_t.isaf004,
       isaf004_desc        LIKE type_t.chr80,
       isaf005             LIKE isaf_t.isaf005,
       isaf005_desc        LIKE type_t.chr80,
       isaf006             LIKE isaf_t.isaf006,
       isaf006_desc        LIKE type_t.chr80,
       str_no              LIKE type_t.chr80,
       end_no              LIKE type_t.chr80,
       isaesite            LIKE isae_t.isaesite,
       isaesite_desc       LIKE type_t.chr80,
       isae001             LIKE isae_t.isae001,
       isae014             LIKE isae_t.isae014,
       isae008             LIKE isae_t.isae008,
       isae012             LIKE isae_t.isae012
       END RECORD
       
DEFINE g_isae_m        type_g_isae_m
DEFINE g_isae_m_t      type_g_isae_m                #備份舊值
#161128-00061#3-----modify--begin----------
#DEFINE g_xrcb         RECORD LIKE xrcb_t.*
#DEFINE g_isaf         RECORD LIKE isaf_t.*
#DEFINE g_isag         RECORD LIKE isag_t.*
#DEFINE g_isah         RECORD LIKE isah_t.*
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
DEFINE g_isag RECORD  #銷項發票來源明細檔
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
DEFINE g_isah RECORD  #銷項發票明細檔
       isahent LIKE isah_t.isahent, #企業編號
       isahcomp LIKE isah_t.isahcomp, #法人
       isahdocno LIKE isah_t.isahdocno, #開票單號
       isahseq LIKE isah_t.isahseq, #項次
       isahorga LIKE isah_t.isahorga, #來源組織
       isah001 LIKE isah_t.isah001, #發票編號
       isah002 LIKE isah_t.isah002, #發票號碼
       isah003 LIKE isah_t.isah003, #貨物或應稅勞務編碼
       isah004 LIKE isah_t.isah004, #貨物或應稅勞務名稱
       isah005 LIKE isah_t.isah005, #發票單位
       isah006 LIKE isah_t.isah006, #發票數量
       isah007 LIKE isah_t.isah007, #稅率
       isah008 LIKE isah_t.isah008, #原始發票編號
       isah009 LIKE isah_t.isah009, #原始發票號碼
       isah010 LIKE isah_t.isah010, #正負值
       isah101 LIKE isah_t.isah101, #發票單價
       isah103 LIKE isah_t.isah103, #發票原幣未稅金額
       isah104 LIKE isah_t.isah104, #發票原幣稅額
       isah105 LIKE isah_t.isah105, #發票原幣稅後金額
       isah113 LIKE isah_t.isah113, #發票本幣未稅金額
       isah114 LIKE isah_t.isah114, #發票本幣稅額
       isah115 LIKE isah_t.isah115, #發票本幣稅後金額
       isah011 LIKE isah_t.isah011, #發票分群
       isah012 LIKE isah_t.isah012, #備註
       isah013 LIKE isah_t.isah013, #規格
       isah106 LIKE isah_t.isah106, #原幣折扣金額
       isah116 LIKE isah_t.isah116  #本幣折扣金額
       END RECORD
#161128-00061#3-----modify--end----------
DEFINE g_xrca              RECORD 
                           xrcadocno  LIKE xrca_t.xrcadocno,
                           xrcacomp   LIKE xrca_t.xrcacomp, 
                           xrca001    LIKE xrca_t.xrca001,                           
                           xrca023    LIKE xrca_t.xrca023,  
                           xrca005    LIKE xrca_t.xrca005,  
                           xrca003    LIKE xrca_t.xrca003,  
                           xrca028    LIKE xrca_t.xrca028,  
                           xrca011    LIKE xrca_t.xrca011,  
                           xrca013    LIKE xrca_t.xrca013,  
                           xrca100    LIKE xrca_t.xrca100,  
                           xrca101    LIKE xrca_t.xrca101,
                           xrcb010    LIKE xrcb_t.xrcb010,
                           xrcb002    LIKE xrcb_t.xrcb002,
                           xrca061    LIKE xrca_t.xrca061                        
                           END RECORD
                           
DEFINE g_xrcd   DYNAMIC ARRAY OF RECORD
                xrcborga  LIKE xrcb_t.xrcborga, 
                xrcb027   LIKE xrcb_t.xrcb027, 
                xrcb028   LIKE xrcb_t.xrcb028, 
                xrcb004   LIKE xrcb_t.xrcb004, 
                xrcb005   LIKE xrcb_t.xrcb005, 
                xrcb006   LIKE xrcb_t.xrcb006, 
                xrcb007   LIKE xrcb_t.xrcb007,
                xrcd003   LIKE xrcd_t.xrcd003,                
                xrcb101   LIKE xrcb_t.xrcb101, 
                xrcd103   LIKE xrcd_t.xrcd103,
                xrcd104   LIKE xrcd_t.xrcd104,
                xrcd105   LIKE xrcd_t.xrcd105,
                xrcd113   LIKE xrcd_t.xrcd113,
                xrcd114   LIKE xrcd_t.xrcd114,
                xrcd115   LIKE xrcd_t.xrcd115      
                END RECORD

DEFINE g_isae012       LIKE isae_t.isae012
DEFINE g_isae005       LIKE isae_t.isae005
DEFINE g_isafdocno     LIKE isaf_t.isafdocno
DEFINE g_oodb008       LIKE oodb_t.oodb008
DEFINE g_isai004       LIKE isai_t.isai004
DEFINE g_gzcb003       LIKE gzcb_t.gzcb003
DEFINE g_isac008       LIKE isac_t.isac008
DEFINE g_isaq005       LIKE isaq_t.isaq005
DEFINE g_isai002       LIKE isai_t.isai002
DEFINE g_isai006       LIKE isai_t.isai006
#end add-point
 
{</section>}
 
{<section id="axrp350.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp350 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp350_init()   
 
      #進入選單 Menu (="N")
      CALL axrp350_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp350
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrp350_tmp;
   DROP TABLE axrp350_tmp1;
   DROP TABLE axrp350_tmp2;
   DROP TABLE axrp350_tmp3;
   DROP TABLE axrp350_tmp4;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp350.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp350_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('total_type','9735')
   CALL cl_set_combo_scc('isah_type','9731')
   CALL cl_set_combo_scc('b_xrcb001','24')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp350_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE gzze_t.gzze001 
   DEFINE l_n             LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_errshow = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp350_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.xrcald,g_input.glaacomp,g_input.isae004,g_input.xmdk016,
                       g_input.total_type,g_input.isah_type                

            BEFORE INPUT
               #CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_input.xrcald,g_input.glaacomp,l_errno  
               #CALL axrp350_xrcald_desc()
               #LET g_input.xmdk016 = g_ooef016
               #LET g_input.total_type = '1'
               #LET g_input.isah_type  = '1'
               
               CALL axrp350_default()

            BEFORE FIELD xrcald
               CALL axrp350_xrcald_desc()
            
            AFTER FIELD xrcald
               CALL axrp350_xrcald_desc()
               IF NOT cl_null(g_input.xrcald) THEN 
                  IF NOT ap_chk_isExist(g_input.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN 
                     LET g_input.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF 
#                  IF NOT ap_chk_isExist(g_input.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',1) THEN     #160318-00005#52  mark
                  IF NOT ap_chk_isExist(g_input.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN      #160318-00005#52  add
                     LET g_input.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF 
                  IF NOT ap_chk_isExist(g_input.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND (glaa014 = 'Y' OR glaa008 = 'Y') AND glaastus = 'Y' ",'axr-00021',1) THEN 
                     LET g_input.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_ld_chk_authorization(g_user,g_input.xrcald) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_input.xrcald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_input.xrcald = ''
                     NEXT FIELD CURRENT               
                  END IF                  
               END IF
               LET g_input.xmdk016 = g_ooef016
               
            AFTER FIELD isae004
               CALL axrp350_isae004_desc()
               IF NOT cl_null(g_input.isae004) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_input.isae004
			   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_isac002_2") THEN
                     #檢查成功時後續處理
                     SELECT isac003,isac008 INTO g_isac003,g_isac008
                       FROM isac_t
                      WHERE isacent = g_enterprise
                        AND isac001 = g_ooef019
                        AND isac002 = g_input.isae004
                     IF g_isac003 <> '2' AND g_isac003 <> '4' THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "axr-00168" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        
                        LET g_input.isae004 = ''
                        CALL axrp350_isae004_desc()
                        NEXT FIELD CURRENT 
                     END IF
                     
                     SELECT isaq005 INTO g_isaq005 
                       FROM isaq_t
                      WHERE isaqent = g_enterprise
                        AND isaqsite = g_input.glaacomp
                        AND isaq001 = g_input.isae004
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.isae004 = ''
                     CALL axrp350_isae004_desc()
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF  
               
            AFTER FIELD xmdk016
               IF NOT cl_null(g_input.xmdk016) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_input.xmdk016
			         #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooai001") THEN
                     #檢查成功時後續處理
                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.xmdk016 = ''
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF  
               
            ON ACTION controlp INFIELD xrcald
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xrcald      #給予default值
               LET g_qryparam.where = " (glaa008 ='Y' OR glaa014 ='Y') "
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()                                  #呼叫開窗
               LET g_input.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_input.xrcald TO xrcald              #顯示到畫面上
               CALL axrp350_xrcald_desc()
               NEXT FIELD xrcald                              #返回原欄位  
                  
            
            ON ACTION controlp INFIELD isae004
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
			   
               LET g_qryparam.default1 = g_input.isae004             #給予default值
               LET g_qryparam.where = "      isac001 = '",g_ooef019,"'",
                                      "  AND (isac003 = '2' OR isac003 = '4')"
               #給予arg
			   
               CALL q_isac002()                                #呼叫開窗
			   
               LET g_input.isae004  = g_qryparam.return1              #將開窗取得的值回傳到變數
			   
               DISPLAY g_input.isae004 TO isae004              #顯示到畫面上
               CALL axrp350_isae004_desc()
               NEXT FIELD isae004 
               
            ON ACTION controlp INFIELD xmdk016
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
			   
               LET g_qryparam.default1 = g_input.xmdk016             #給予default值

               #給予arg
			   
               CALL q_aooi001_1()                                #呼叫開窗
			   
               LET g_input.xmdk016  = g_qryparam.return1              #將開窗取得的值回傳到變數
			   
               DISPLAY g_input.xmdk016 TO xmdk016              #顯示到畫面上

               NEXT FIELD xmdk016 

            AFTER INPUT

         END INPUT 
         
         CONSTRUCT BY NAME g_wc ON xrca004,xrcadocdt,xrcadocno,xrca003,xrcborga,xrcb002,xrcb004
   
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
       
            ON ACTION controlp INFIELD xrca004
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_7()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca004  #顯示到畫面上
               NEXT FIELD xrca004                     #返回原欄位 
      
            ON ACTION controlp INFIELD xrcadocno
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         IF g_isac003 = '2' THEN 
		            LET g_qryparam.where = " (xrca001 = '12' OR xrca001 = '19')"
		         END IF
		         IF g_isac003 = '4' THEN 
		            LET g_qryparam.where = " (xrca001 = '22' OR xrca001 = '29')"
		         END IF
               CALL q_xrcadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上  
               NEXT FIELD xrcadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD xrca003
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca003  #顯示到畫面上  
               NEXT FIELD xrca003                     #返回原欄位  

            ON ACTION controlp INFIELD xrcborga
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooef001()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcborga  #顯示到畫面上  
               NEXT FIELD xrcborga                     #返回原欄位
               
            ON ACTION controlp INFIELD xrcb002
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_xrcb002()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcb002   #顯示到畫面上  
               NEXT FIELD xrcb002                      #返回原欄位
               
            ON ACTION controlp INFIELD xrcb004
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcb004   #顯示到畫面上  
               NEXT FIELD xrcb004                      #返回原欄位
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
             BEFORE INPUT
             
             BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL axrp350_fetch() 
                
             ON CHANGE sel
                IF g_detail_d[l_ac].sel = "Y" THEN  
                   UPDATE axrp350_tmp SET sel = 'Y' 
                    WHERE xrcadocno = g_detail_d[l_ac].b_xrcadocno
                      AND seq       = g_detail_d[l_ac].seq
                ELSE
                   UPDATE axrp350_tmp SET sel = 'N' 
                    WHERE xrcadocno = g_detail_d[l_ac].b_xrcadocno
                      AND seq       = g_detail_d[l_ac].seq
                END IF
                
         END INPUT
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
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               UPDATE axrp350_tmp SET sel = 'Y' 
                WHERE xrcadocno = g_detail_d[li_idx].b_xrcadocno
                  AND seq       = g_detail_d[li_idx].seq
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
               UPDATE axrp350_tmp SET sel = 'N' 
                WHERE xrcadocno = g_detail_d[li_idx].b_xrcadocno
                  AND seq       = g_detail_d[li_idx].seq
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE axrp350_tmp SET sel = 'Y' 
                   WHERE xrcadocno = g_detail_d[li_idx].b_xrcadocno
                     AND seq       = g_detail_d[li_idx].seq
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE axrp350_tmp SET sel = 'N' 
                   WHERE xrcadocno = g_detail_d[li_idx].b_xrcadocno
                     AND seq       = g_detail_d[li_idx].seq
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp350_filter()
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
            
            #end add-point
            CALL axrp350_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_input.* TO NULL
            CALL axrp350_default()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp350_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION open_axrp350_01
            LET g_action_choice="open_axrp350_01"
            IF cl_auth_chk_act("open_axrp350_01") THEN
               CALL axrp350_01()
            END IF
         
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM axrp350_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               CONTINUE DIALOG
            END IF
            
            CALL axrp350_s01()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp350.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp350_query()
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
   CALL axrp350_b_fill()
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
 
{<section id="axrp350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp350_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   CALL axrp350_create_tmp() RETURNING l_success
   DELETE FROM axrp350_tmp
   
   LET g_sql= " SELECT DISTINCT 'N',xrcald,xrcadocno,xrcadocdt,xrca004,xrca061,xrca028,'',xrcb001,xrcb002,xrcb003,",
              "                 xrcb005,xrcb007,xrcb103,xrcb104,xrcb105,xrcb118-xrcb117,xrcb007-xrcb030,xrcborga,1 ",
              "   FROM xrca_t,xrcb_t",
              "  WHERE xrcaent = ? ",
              "    AND xrcaent = xrcbent ",
              "    AND xrcald = xrcbld ",
              "    AND xrcadocno = xrcbdocno ",
              "    AND xrcastus = 'Y' ",
              "    AND xrcald = '",g_input.xrcald,"'",
              "    AND xrca028 = '",g_input.isae004,"'",
              "    AND xrca100 = '",g_input.xmdk016,"'",
              "    AND xrcb030 = 0 ",
              "    AND xrcb117 = 0 ",
              "    AND ",g_wc
              
   IF g_isac003 = '2' THEN               
      LET g_sql = g_sql,"  AND (xrca001 = '12' OR xrca001 = '19')"              
   END IF
   IF g_isac003 = '4' THEN 
      LET g_sql = g_sql,"  AND (xrca001 = '22' OR xrca001 = '29')" 
   END IF
   
   LET g_sql = g_sql,"  ORDER BY xrcadocno"
   #end add-point
 
   PREPARE axrp350_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp350_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*   
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
      LET g_detail_d[l_ac].seq = l_ac
      CALL axrp350_xrca004_desc()
      LET g_detail_d[l_ac].xrca028_desc = g_input.isae004_desc
      
      INSERT INTO axrp350_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL axrp350_detail_show()      
 
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
   FREE axrp350_sel
   
   LET l_ac = 1
   CALL axrp350_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp350.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp350_fetch()
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
 
{<section id="axrp350.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp350_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp350.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp350_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axrp350_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp350.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp350_filter_parser(ps_field)
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
 
{<section id="axrp350.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp350_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axrp350_xrcald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.xrcald_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_input.xrcald_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_input.glaacomp = g_rtn_fields[1]
   DISPLAY BY NAME g_input.glaacomp

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_input.glaacomp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooef004,ooef019,ooef016 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
   LET g_ooef004 = g_rtn_fields[1]
   LET g_ooef019 = g_rtn_fields[2]
   LET g_ooef016 = g_rtn_fields[3]

END FUNCTION

PRIVATE FUNCTION axrp350_isae004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_input.isae004
   CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002 = ? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.isae004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.isae004_desc
END FUNCTION

PRIVATE FUNCTION axrp350_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,
          lnode_item    om.DomNode,
          ls_item_name  STRING

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN
      RETURN
   END IF

   IF (ps_fields IS NULL) THEN
      RETURN
   END IF

   LET ps_fields = ps_fields.toLowerCase()

   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()

   LET llst_items = lnode_win.selectByPath("//Form//*")

   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()

     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")

            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")

               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF

            LET ls_item_name = ls_item_name.trim()

            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF

               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION

PRIVATE FUNCTION axrp350_set_combo_scc(p_field,p_scc)
   DEFINE p_field        LIKE type_t.chr80
  DEFINE p_scc          LIKE type_t.num5
  DEFINE l_gzcb002      LIKE gzcb_t.gzcb002
  DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
  DEFINE comb_value     STRING
  DEFINE comb_item      STRING
  DEFINE l_str          STRING

    DECLARE gzcb_cs CURSOR FOR
     SELECT gzcb002,gzcbl004 FROM gzcb_t LEFT OUTER join gzcbl_t ON gzcbl001 = gzcb001
                                                                AND gzcbl002 = gzcb002
                                                                AND gzcbl003 = g_dlang
      WHERE gzcb001 = p_scc
    FOREACH gzcb_cs INTO l_gzcb002,l_gzcbl004
        LET l_str = l_gzcb002
        LET l_str = l_str.substring(1,1)
        IF l_str = '0' THEN
           LET l_str = l_gzcb002
           LET l_gzcb002 = l_str.substring(2,2)
        END IF
        LET comb_value = comb_value CLIPPED,',',l_gzcb002
        LET comb_item  = comb_item  CLIPPED,',',l_gzcb002

    END FOREACH
    CALL cl_set_combo_items(p_field,comb_value,comb_item)
END FUNCTION

PRIVATE FUNCTION axrp350_p()
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_year       LIKE type_t.num5
   DEFINE l_month      LIKE type_t.num5
   DEFINE l_isaq005    LIKE isaq_t.isaq005
   DEFINE ls_sql       STRING

   WHENEVER ERROR CONTINUE
   INITIALIZE g_xrca.* TO NULL
   INITIALIZE g_xrcb.* TO NULL
   CALL g_xrcd.clear()

   DROP TABLE axrp350_tmp1
   DROP TABLE axrp350_tmp2
   DROP TABLE axrp350_tmp4

   #Create temp table
   CREATE TEMP TABLE axrp350_tmp1(
      num       LIKE type_t.num5,
      xrcborga  LIKE xrcb_t.xrcborga,
      xrcb027   LIKE xrcb_t.xrcb027,
      xrcb028   LIKE xrcb_t.xrcb028,
      xrcb004   LIKE xrcb_t.xrcb004,
      xrcb005   LIKE xrcb_t.xrcb005,
      xrcb006   LIKE xrcb_t.xrcb006,
      xrcb007   LIKE xrcb_t.xrcb007,
      xrcd003   LIKE xrcd_t.xrcd003,
      xrcb101   LIKE xrcb_t.xrcb101,
      xrcd103   LIKE xrcd_t.xrcd103,
      xrcd104   LIKE xrcd_t.xrcd104,
      xrcd105   LIKE xrcd_t.xrcd105,
      xrcd113   LIKE xrcd_t.xrcd113,
      xrcd114   LIKE xrcd_t.xrcd114,
      xrcd115   LIKE xrcd_t.xrcd115);
      
   
   CREATE TEMP TABLE axrp350_tmp2(
   num               LIKE type_t.num5,
   xrcadocno         LIKE xrca_t.xrcadocno
   );
   
   CREATE TEMP TABLE axrp350_tmp4(
   isafdocno         LIKE isaf_t.isafdocno
   );
   
   DELETE FROM axrp350_tmp1
   DELETE FROM axrp350_tmp2
   DELETE FROM axrp350_tmp4

   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   CALL cl_err_collect_init()   #151023-00016#1 Mod   cl_showmsg_init() --> cl_err_collect_init()

   #依單據各別開立
   IF g_input.total_type = '1' THEN
      LET g_sql = "SELECT DISTINCT xrcadocno,xrcacomp,xrca001,xrca023,xrca005,xrca003,xrca028,xrca011,xrca013,xrca100,xrca101,'','',xrca061 FROM xrca_t ",
                  " WHERE xrcaent = '",g_enterprise,"'",
                  "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')",
                  " ORDER BY xrcadocno"
   END IF

   #合併開立
   IF g_input.total_type = '2' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,'','',xrca061 FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      ELSE
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,'','','' FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      END IF
   END IF

   #依業務部門
   IF g_input.total_type = '3' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,xrcb010,'',xrca061 ",
                     "  FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      ELSE
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,xrcb010,'','' ",
                     "  FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      END IF
   END IF


   #來源單據
   IF g_input.total_type = '4' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,'',xrcb002,xrca061 ",
                     "  FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      ELSE
         LET g_sql = "SELECT DISTINCT '','',xrca001,xrca023,xrca005,'',xrca028,xrca011,'',xrca100,xrca101,'',xrcb002,'' ",
                     "  FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp WHERE sel = 'Y')"
      END IF
   END IF

   PREPARE axrp350_pre FROM g_sql
   DECLARE axrp350_cs CURSOR FOR  axrp350_pre
   FOREACH axrp350_cs INTO g_xrca.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #獲取開票單號
      CALL axrp350_isafdocno_get()
      
      #处理起始单号,截止单号
      IF cl_null(g_isae_m.str_no) THEN LET g_isae_m.str_no = g_isafdocno END IF
      LET g_isae_m.end_no   = g_isafdocno 

      #插入發票主檔isaf_t
      CALL axrp350_ins_isaf()

      #插入發票來源明細檔isag_t
      IF g_success = 'Y' THEN
         CALL axrp350_ins_isag()
      END IF

      #插入發票明細檔isah_t
      IF g_success = 'Y' AND g_input.isah_type <> '3' THEN
         DELETE FROM axrp350_tmp1
         CALL axrp350_ins_tmp()
         CALL axrp350_ins_isah()
      END IF
      
      INSERT INTO axrp350_tmp4 VALUES(g_isafdocno)

   END FOREACH


  #CALL cl_err_showmsg()   #151023-00016#1   Mark
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   END IF
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','1')
   END IF
   #SELECT isaq005 INTO l_isaq005
   #  FROM isaq_t
   # WHERE isaqent = g_enterprise
   #   AND isaqsite = g_site
   #   AND isaqstus = 'Y'
   #IF l_isaq005 = '2' THEN
   #   CALL axrp350_02(g_wc,g_xrca_m.isafdocdt_type,g_xrca_m.isaf014,g_xrca_m.xrcald,g_xrca_m.isae009,g_ooef019)
   #ELSE
   #   #call發票列印的程式 aisr310
   #   CALL axrp350_02(g_wc,g_xrca_m.isafdocdt_type,g_xrca_m.isaf014,g_xrca_m.xrcald,g_xrca_m.isae009,g_ooef019)
   #END IF

END FUNCTION

PRIVATE FUNCTION axrp350_ins_isaf()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_ooef017    LIKE ooef_t.ooef017
   DEFINE l_n          LIKE type_t.num5

   LET g_success = 'Y'
   LET g_isaf.isafent = g_enterprise
   LET g_isaf.isafcomp = g_input.glaacomp
   LET g_isaf.isafdocno = g_isafdocno
   LET g_isaf.isafdocdt = g_today   
   LET g_isaf.isaf002 = g_xrca.xrca023
   LET g_isaf.isaf003 = g_xrca.xrca005
   LET g_isaf.isaf004 = g_isae_m.isaf004
   LET g_isaf.isaf005 = g_isae_m.isaf005
   LET g_isaf.isaf006 = g_isae_m.isaf006
   LET g_isaf.isaf007 = NULL
   LET g_isaf.isaf008 = g_xrca.xrca028
   
   IF g_xrca.xrca001 = '12' OR g_xrca.xrca001 = '19' THEN
      LET g_isaf.isaf001 = '1'
      LET g_isaf.isaf009 = g_isae005
      LET g_isaf.isaf036 = '11'
   END IF
   
   IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
      LET g_isaf.isaf001 = '3'
      LET g_isaf.isaf009 = 'N'
      LET g_isaf.isaf036 = '21'
   END IF
   
   IF g_isae_m.isafdocdt_type = '1' THEN 
      LET g_isaf.isaf014 = g_xrca.xrca061
   ELSE
      LET g_isaf.isaf014 = g_isae_m.isaf014
   END IF
   
   CALL s_invoice_get_no(g_site,g_input.isae004,g_isaf.isaf014,g_isae_m.isae001)
   RETURNING l_success,g_isaf.isaf010,g_isaf.isaf011,g_isaf.isaf012,g_isaf.isaf013
   
   IF g_isai002 = '1' THEN 
      LET g_isaf.isaf011 = g_isaf.isaf010 CLIPPED,g_isaf.isaf011
   END IF

   LET g_isaf.isaf015 = TIME
   LET g_isaf.isaf016 = g_xrca.xrca011

   #       含稅否  稅率
   SELECT oodb005,oodb006
     INTO g_isaf.isaf017,g_isaf.isaf018
     FROM oodb_t
    WHERE oodbent = g_enterprise
      AND oodb001 = g_ooef019
      AND oodb002 = g_isaf.isaf016

   SELECT isac004 INTO g_isaf.isaf019
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = g_ooef019
      AND isac002 = g_xrca.xrca028


   LET g_isaf.isaf020 = g_isaf.isaf011   

   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_isaf_m.isaf006

   #------購貨方訊息-------
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isaf.isaf002
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isaf.isaf021 = '', g_rtn_fields[1] , ''

   SELECT COUNT(*) INTO l_n
     FROM isak_t
    WHERE isaksite = g_enterprise
      AND isaksite = g_isaf.isaf006
      AND isak001 = g_isaf.isaf002
      AND isakstus = 'Y'
      
   IF l_n = 0 THEN 
      SELECT isak008,isak009,isak010,isak011,isak012
        INTO g_isaf.isaf022,g_isaf.isaf023,g_isaf.isaf024,g_isaf.isaf025,g_isaf.isaf026
        FROM isak_t
       WHERE isakent = g_enterprise
         AND isaksite = l_ooef017
         AND isak001 = g_isaf.isaf002
         AND isakstus = 'Y'
   ELSE
      SELECT isak008,isak009,isak010,isak011,isak012
        INTO g_isaf.isaf022,g_isaf.isaf023,g_isaf.isaf024,g_isaf.isaf025,g_isaf.isaf026
        FROM isak_t
       WHERE isakent = g_enterprise
         AND isaksite = g_isaf.isaf006
         AND isak001 = g_isaf.isaf002
         AND isakstus = 'Y'
   END IF
   #------購貨方訊息-------


   #------銷貨方訊息-------
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isaf.isaf006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl004 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isaf.isaf027 = '', g_rtn_fields[1] , ''

   SELECT COUNT(*) INTO l_n
     FROM isao_t
    WHERE isaoent = g_enterprise
      AND isaosite = g_isaf.isaf006
      AND isaostus = 'Y'
   
   IF l_n = 0 THEN 
      SELECT isao001,isao002,isao003,isao004,isao005
        INTO g_isaf.isaf028,g_isaf.isaf029,g_isaf.isaf030,g_isaf.isaf031,g_isaf.isaf032
        FROM isao_t
       WHERE isaoent = g_enterprise
         AND isaosite = l_ooef017
         AND isaostus = 'Y'   
   ELSE
      SELECT isao001,isao002,isao003,isao004,isao005
        INTO g_isaf.isaf028,g_isaf.isaf029,g_isaf.isaf030,g_isaf.isaf031,g_isaf.isaf032
        FROM isao_t
       WHERE isaoent = g_enterprise
         AND isaosite = g_isaf.isaf006
         AND isaostus = 'Y'
   END IF
   #------銷貨方訊息-------

   LET g_isaf.isaf033 = NULL
   LET g_isaf.isaf034 = NULL
   IF g_input.total_type = '1' THEN
      LET g_isaf.isaf035 = g_xrca.xrcadocno
   ELSE
      LET g_isaf.isaf035 = NULL
   END IF
   
   LET g_isaf.isaf037 = NULL
   LET g_isaf.isaf038 = NULL
   LET g_isaf.isaf039 = NULL
   LET g_isaf.isaf040 = NULL
   LET g_isaf.isaf041 = NULL
   LET g_isaf.isaf042 = NULL
   LET g_isaf.isaf043 = NULL
   LET g_isaf.isaf044 = 0
   LET g_isaf.isaf045 = NULL
   LET g_isaf.isaf046 = NULL
   LET g_isaf.isaf047 = NULL
   LET g_isaf.isaf048 = NULL
   LET g_isaf.isaf049 = NULL
   LET g_isaf.isaf050 = NULL
   LET g_isaf.isaf051 = g_isae_m.isae001
   LET g_isaf.isaf052 = g_isae_m.isaesite
   LET g_isaf.isaf053 = g_isac008

   LET g_isaf.isaf100 = g_xrca.xrca100
   LET g_isaf.isaf101 = g_xrca.xrca101
   LET g_isaf.isaf103 = 0     #單身發票明細 sum(isah103) 回寫
   LET g_isaf.isaf104 = 0     #單身發票明細 sum(isah104) 回寫
   LET g_isaf.isaf105 = 0     #單身發票明細 sum(isah105) 回寫
   LET g_isaf.isaf106 = 0
   LET g_isaf.isaf107 = 0
   LET g_isaf.isaf108 = 0
   LET g_isaf.isaf113 = 0     #單身發票明細 sum(isah113) 回寫
   LET g_isaf.isaf114 = 0     #單身發票明細 sum(isah114) 回寫
   LET g_isaf.isaf115 = 0     #單身發票明細 sum(isah115) 回寫
   LET g_isaf.isaf116 = 0
   LET g_isaf.isaf117 = 0
   LET g_isaf.isaf118 = 0

   #1.應稅  2.免稅  3.零稅
   SELECT oodb008 INTO g_oodb008
     FROM oodb_t
    WHERE oodbent = g_enterprise
      AND oodb001 = g_ooef019
      AND oodb002 = g_xrca.xrca011

   #正負值 +1/-1
   SELECT isai004 INTO g_isai004
     FROM isai_t
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019

   SELECT gzcb003 INTO g_gzcb003
     FROM gzcb_t
    WHERE gzcb001 = '9728'
      AND gzcb002 = g_isai004

   #1.應稅
   IF g_oodb008 = '1' THEN
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf119 = g_isaf.isaf105 * g_gzcb003
      ELSE
         LET g_isaf.isaf119 = g_isaf.isaf105
      END IF
      LET g_isaf.isaf120 = 0
      LET g_isaf.isaf121 = 0
   END IF

   #2.免稅
   IF g_oodb008 = '2' THEN
      LET g_isaf.isaf119 = 0
      LET g_isaf.isaf120 = 0
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf121 = g_isaf.isaf105 * g_gzcb003
      ELSE
         LET g_isaf.isaf121 = g_isaf.isaf105
      END IF
   END IF

   #3.零稅
   IF g_oodb008 = '3' THEN
      LET g_isaf.isaf119 = 0
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf120 = g_isaf.isaf105 * g_gzcb003
      ELSE
         LET g_isaf.isaf120 = g_isaf.isaf105
      END IF
      LET g_isaf.isaf121 = 0
   END IF

   LET g_isaf.isaf122 = 0
   LET g_isaf.isaf123 = 0
   LET g_isaf.isaf124 = 0
   LET g_isaf.isaf201 = NULL
   LET g_isaf.isaf202 = NULL
   LET g_isaf.isaf203 = NULL
   LET g_isaf.isaf204 = NULL
   LET g_isaf.isaf205 = NULL
   LET g_isaf.isaf206 = NULL
   LET g_isaf.isaf207 = NULL
   LET g_isaf.isaf208 = NULL
   LET g_isaf.isaf209 = NULL
   LET g_isaf.isaf210 = NULL

   IF g_input.isah_type = '3' THEN    #3.自行輸入
      LET g_isaf.isafstus = 'N'
   ELSE
      LET g_isaf.isafstus = 'Y'
   END IF

   #異動資訊
   LET g_isaf.isafcrtid = g_user
   LET g_isaf.isafcrtdt = cl_get_current()
   LET g_isaf.isafownid = g_user
   LET g_isaf.isafowndp = g_dept
   LET g_isaf.isafcrtid = g_user
   LET g_isaf.isafcrtdp = g_dept
   LET g_isaf.isafcrtdt = cl_get_current()
   LET g_isaf.isafcnfid = g_user
   LET g_isaf.isafcnfdt = cl_get_current()

   #161128-00061#3-----modify--begin----------
   #INSERT INTO isaf_t VALUES (g_isaf.*)
    INSERT INTO isaf_t (isafent,isafsite,isafcomp,isafdocno,isafdocdt,isaf001,isaf002,isaf003,isaf004,
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
                        isaf063,isaf064,isaf065,isaf066,isaf067)
     VALUES (g_isaf.isafent,g_isaf.isafsite,g_isaf.isafcomp,g_isaf.isafdocno,g_isaf.isafdocdt,g_isaf.isaf001,g_isaf.isaf002,g_isaf.isaf003,g_isaf.isaf004,
             g_isaf.isaf005,g_isaf.isaf006,g_isaf.isaf007,g_isaf.isaf008,g_isaf.isaf009,g_isaf.isaf010,g_isaf.isaf011,g_isaf.isaf012,g_isaf.isaf013,g_isaf.isaf014,
             g_isaf.isaf015,g_isaf.isaf016,g_isaf.isaf017,g_isaf.isaf018,g_isaf.isaf019,g_isaf.isaf020,g_isaf.isaf021,g_isaf.isaf022,g_isaf.isaf023,g_isaf.isaf024,
             g_isaf.isaf025,g_isaf.isaf026,g_isaf.isaf027,g_isaf.isaf028,g_isaf.isaf029,g_isaf.isaf030,g_isaf.isaf031,g_isaf.isaf032,g_isaf.isaf033,g_isaf.isaf034,
             g_isaf.isaf035,g_isaf.isaf036,g_isaf.isaf037,g_isaf.isaf038,g_isaf.isaf039,g_isaf.isaf040,g_isaf.isaf041,g_isaf.isaf042,g_isaf.isaf043,g_isaf.isaf044,
             g_isaf.isaf045,g_isaf.isaf046,g_isaf.isaf047,g_isaf.isaf048,g_isaf.isaf049,g_isaf.isaf050,g_isaf.isaf051,g_isaf.isaf052,g_isaf.isaf053,g_isaf.isaf054,
             g_isaf.isaf055,g_isaf.isaf056,g_isaf.isaf057,g_isaf.isaf058,g_isaf.isaf100,g_isaf.isaf101,g_isaf.isaf103,g_isaf.isaf104,g_isaf.isaf105,g_isaf.isaf106,
             g_isaf.isaf107,g_isaf.isaf108,g_isaf.isaf113,g_isaf.isaf114,g_isaf.isaf115,g_isaf.isaf116,g_isaf.isaf117,g_isaf.isaf118,g_isaf.isaf119,g_isaf.isaf120,
             g_isaf.isaf121,g_isaf.isaf122,g_isaf.isaf123,g_isaf.isaf124,g_isaf.isaf201,g_isaf.isaf202,g_isaf.isaf203,g_isaf.isaf204,g_isaf.isaf205,g_isaf.isaf206,
             g_isaf.isaf207,g_isaf.isaf208,g_isaf.isaf209,g_isaf.isaf210,g_isaf.isafstus,g_isaf.isafownid,g_isaf.isafowndp,g_isaf.isafcrtid,g_isaf.isafcrtdp,
             g_isaf.isafcrtdt,g_isaf.isafmodid,g_isaf.isafmoddt,g_isaf.isafcnfid,g_isaf.isafcnfdt,g_isaf.isaf059,g_isaf.isaf060,g_isaf.isaf061,g_isaf.isaf062,
             g_isaf.isaf063,g_isaf.isaf064,g_isaf.isaf065,g_isaf.isaf066,g_isaf.isaf067)
   #161128-00061#3-----modify--end----------
   IF SQLCA.SQLCODE THEN
     #CALL cl_errmsg('INSERT isaf_t',g_isaf.isafdocno,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
     #151023-00016#1 Add  ---(S)---
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'INSERT isaf_t'
      LET g_errparam.popup = FALSE
      CALL cl_err()
     #151023-00016#1 Add  ---(E)---
      LET g_success = 'N'
   END IF


END FUNCTION

PRIVATE FUNCTION axrp350_ins_isag()
   DEFINE l_ac       LIKE type_t.num5
   DEFINE ls_sql     STRING

   DELETE FROM axrp350_tmp2

   IF g_input.total_type = '1' THEN
      #161128-00061#3-----modify--begin----------
      #LET g_sql = "SELECT * FROM xrcb_t ",
      LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                  "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                  "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                  "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                  "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                  "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                  "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                  "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                  "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                  "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                  "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
       #161128-00061#3-----modify--end----------
                  " WHERE xrcbent = '",g_enterprise,"'",
                  "   AND xrcbld = '",g_input.xrcald,"'",
                  "   AND xrcbdocno = '",g_xrca.xrcadocno,"'"
   END IF

   IF g_input.total_type = '2' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         #161128-00061#3-----modify--begin----------
         #LET g_sql = "SELECT * FROM xrcb_t ",
         LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                     "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                     "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                     "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                     "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                     "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                     "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                     "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                     "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                     "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                     "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
          #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     "   AND xrca061 = '",g_xrca.xrca061,"'",
                     ")"
      ELSE
         #161128-00061#3-----modify--begin----------
         #LET g_sql = "SELECT * FROM xrcb_t ",
         LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                     "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                     "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                     "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                     "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                     "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                     "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                     "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                     "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                     "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                     "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
          #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t ",
                     " WHERE xrcaent = '",g_enterprise,"'",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     ")"
      END IF
   END IF

   IF g_input.total_type = '3' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         #161128-00061#3-----modify--begin----------
         #LET g_sql = "SELECT * FROM xrcb_t ",
         LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                     "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                     "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                     "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                     "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                     "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                     "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                     "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                     "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                     "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                     "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
          #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     "   AND xrcb010 = '",g_xrca.xrcb010,"'",
                     "   AND xrca061 = '",g_xrca.xrca061,"'",
                     ")"
      ELSE
          #161128-00061#3-----modify--begin----------
          #LET g_sql = "SELECT * FROM xrcb_t ",
          LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                      "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                      "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                      "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                      "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                      "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                      "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                      "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                      "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                      "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                      "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
           #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     "   AND xrcb010 = '",g_xrca.xrcb010,"'",
                     ")"
      END IF
   END IF

   IF g_input.total_type = '4' THEN
      IF g_isae_m.isafdocdt_type = '1' THEN   #發票日期原則依應收預開票日,則還要根據預開票日xrca061匯總
         #161128-00061#3-----modify--begin----------
         #LET g_sql = "SELECT * FROM xrcb_t ",
         LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                     "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                     "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                     "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                     "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                     "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                     "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                     "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                     "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                     "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                     "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
          #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     "   AND xrcb002 = '",g_xrca.xrcb002,"'",
                     "   AND xrca061 = '",g_xrca.xrca061,"'",
                     ")"
      ELSE
          #161128-00061#3-----modify--begin----------
          #LET g_sql = "SELECT * FROM xrcb_t ",
          LET g_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
                      "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
                      "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
                      "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
                      "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
                      "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
                      "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
                      "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
                      "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
                      "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
                      "xrcb058,xrcb059,xrcb060,xrcb107  FROM xrcb_t ",
           #161128-00061#3-----modify--end----------
                     " WHERE xrcbent = '",g_enterprise,"'",
                     "   AND xrcbld = '",g_input.xrcald,"'",
                     "   AND xrcbdocno IN ( ",
                     "SELECT xrcadocno FROM xrca_t,xrcb_t ",
                     " WHERE xrcaent = xrcbent ",
                     "   AND xrcald = xrcbld ",
                     "   AND xrcadocno = xrcbdocno ",
                     "   AND xrcald  = '",g_input.xrcald,"'",
                     "   AND xrca023 = '",g_xrca.xrca023,"'",
                     "   AND xrca005 = '",g_xrca.xrca005,"'",
                     "   AND xrca028 = '",g_xrca.xrca028,"'",
                     "   AND xrca011 = '",g_xrca.xrca011,"'",
                     "   AND xrca100 = '",g_xrca.xrca100,"'",
                     "   AND xrca101 = '",g_xrca.xrca101,"'",
                     "   AND xrcb002 = '",g_xrca.xrcb002,"'",
                     ")"
      END IF 
   END IF

   PREPARE axrp350_pre1 FROM g_sql
   DECLARE axrp350_cs1 CURSOR FOR  axrp350_pre1

   LET l_ac = 1
   FOREACH axrp350_cs1 INTO g_xrcb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_isag.isagent = g_enterprise
      LET g_isag.isagcomp = g_input.glaacomp
      LET g_isag.isagdocno = g_isafdocno
      LET g_isag.isagseq = l_ac
      LET g_isag.isagorga = g_xrcb.xrcborga
      LET g_isag.isag001 = g_xrcb.xrcb001
      LET g_isag.isag002 = g_xrcb.xrcb002
      LET g_isag.isag003 = g_xrcb.xrcb003
      LET g_isag.isag004 = g_xrcb.xrcb007
      LET g_isag.isag005 = g_xrcb.xrcb006
      LET g_isag.isag006 = g_xrcb.xrcb020

      SELECT oodb005,oodb006
        INTO g_isag.isag007,g_isag.isag008
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = g_isag.isag006

      LET g_isag.isag009 = g_xrcb.xrcbdocno
      LET g_isag.isag010 = g_xrcb.xrcbseq
      LET g_isag.isag011 = g_xrcb.xrcb031
      #LET g_isag.isag012 = g_xrcb.xrcb032     #xrcb032沒了
      
      IF g_xrca.xrca001 = '12' OR g_xrca.xrca001 = '19' THEN
         LET g_isag.isag013 = ''
         LET g_isag.isag014 = '' 
      END IF
      
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isag.isag013 = g_xrcb.xrcb027
         LET g_isag.isag014 = g_xrcb.xrcb028
      END IF

      LET g_isag.isag101 = g_xrcb.xrcb101
      
      IF g_xrca.xrca001 = '12' OR g_xrca.xrca001 = '19' THEN
         LET g_isag.isag103 = g_xrcb.xrcb103
         LET g_isag.isag104 = g_xrcb.xrcb104
         LET g_isag.isag105 = g_xrcb.xrcb105
         LET g_isag.isag113 = g_xrcb.xrcb113
         LET g_isag.isag114 = g_xrcb.xrcb114
         LET g_isag.isag115 = g_xrcb.xrcb115
      END IF

      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isag.isag103 = g_xrcb.xrcb103 * g_gzcb003
         LET g_isag.isag104 = g_xrcb.xrcb104 * g_gzcb003
         LET g_isag.isag105 = g_xrcb.xrcb105 * g_gzcb003
         LET g_isag.isag113 = g_xrcb.xrcb113 * g_gzcb003
         LET g_isag.isag114 = g_xrcb.xrcb114 * g_gzcb003
         LET g_isag.isag115 = g_xrcb.xrcb115 * g_gzcb003
      END IF
 
      LET g_isag.isag116 = 0
      LET g_isag.isag117 = 0
      LET g_isag.isag126 = 0
      LET g_isag.isag127 = 0
      LET g_isag.isag128 = NULL
      LET g_isag.isag136 = 0
      LET g_isag.isag137 = 0
      LET g_isag.isag138 = NULL


     #161128-00061#3-----modify--begin----------
     #INSERT INTO isag_t VALUES (g_isag.*)
      INSERT INTO isag_t (isagent,isagcomp,isagdocno,isagseq,isagorga,isag001,isag002,isag003,isag004,
                          isag005,isag006,isag007,isag008,isag009,isag010,isag011,isag012,isag013,isag014,
                          isag015,isag016,isag017,isag101,isag103,isag104,isag105,isag106,isag113,isag114,
                          isag115,isag116,isag117,isag126,isag127,isag128,isag136,isag137,isag138,isag018)
       VALUES (g_isag.isagent,g_isag.isagcomp,g_isag.isagdocno,g_isag.isagseq,g_isag.isagorga,g_isag.isag001,g_isag.isag002,g_isag.isag003,g_isag.isag004,
               g_isag.isag005,g_isag.isag006,g_isag.isag007,g_isag.isag008,g_isag.isag009,g_isag.isag010,g_isag.isag011,g_isag.isag012,g_isag.isag013,g_isag.isag014,
               g_isag.isag015,g_isag.isag016,g_isag.isag017,g_isag.isag101,g_isag.isag103,g_isag.isag104,g_isag.isag105,g_isag.isag106,g_isag.isag113,g_isag.isag114,
               g_isag.isag115,g_isag.isag116,g_isag.isag117,g_isag.isag126,g_isag.isag127,g_isag.isag128,g_isag.isag136,g_isag.isag137,g_isag.isag138,g_isag.isag018)
     #161128-00061#3-----modify--end----------
      IF SQLCA.SQLCODE THEN
        #CALL cl_errmsg('INSERT isag_t',g_isag.isagdocno,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
        #151023-00016#1 Add  ---(S)---
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'INSERT isag_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
        #151023-00016#1 Add  ---(E)---
         LET g_success = 'N'
      END IF
      
      UPDATE xrcb_t SET xrcb030 = g_xrcb.xrcb007,     #本次開發票數量 
                        xrcb117 = g_isag.isag103      #本次開發票金額 
       WHERE xrcbent   = g_enterprise
         AND xrcbdocno = g_isag.isag009  #應收單號 
         AND xrcbseq   = g_isag.isag010  #應收單項次 
         AND xrcbld    = g_input.xrcald
         
      IF SQLCA.SQLCODE THEN
        #CALL cl_errmsg('upd xrcb_t',g_isag.isag002,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
        #151023-00016#1 Add  ---(S)---
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'upd xrcb_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
        #151023-00016#1 Add  ---(E)---
         LET g_success = 'N'
      END IF
      
      #若為出貨/銷退單時回寫已開發票數量
      IF g_xrcb.xrcb001 = 'axmt540' OR g_xrcb.xrcb001 = 'axmt600' THEN 
          UPDATE xmdl_t SET xmdl047 = xmdl047 + g_xrcb.xrcb007 
           WHERE xmdlent = g_enterprise
             AND xmdldocno = g_xrcb.xrcb002
             AND xmdlseq  =  g_xrcb.xrcb003
             
          IF SQLCA.SQLCODE THEN
            #CALL cl_errmsg('upd xmdl_t',g_isag.isag002,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
            #151023-00016#1 Add  ---(S)---
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.SQLCODE
             LET g_errparam.extend = 'upd xmdl_t'
             LET g_errparam.popup = FALSE
             CALL cl_err()
            #151023-00016#1 Add  ---(E)---
             LET g_success = 'N'
          END IF
      END IF
      
      #CREATE TEMP TABLE
      DROP TABLE axrp350_tmp3
      LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axrp350_tmp3 AS ",
                   "SELECT * FROM xrcd_t  "
      PREPARE axrp350_tmp_pre FROM ls_sql
      EXECUTE axrp350_tmp_pre
      FREE axrp350_tmp_pre
                   
      #將符合條件的資料丟入TEMP TABLE
      INSERT INTO axrp350_tmp3 SELECT DISTINCT * FROM xrcd_t 
                                WHERE xrcdent = g_enterprise
                                  AND xrcdld  = g_input.xrcald
                                  AND xrcddocno = g_xrcb.xrcbdocno
                                  AND xrcdseq = g_xrcb.xrcbseq
                                  #AND xrcddocno IN (SELECT xrcadocno FROM axrp350_tmp2)
                                  
      UPDATE axrp350_tmp3 SET xrcddocno = g_isafdocno,
                              xrcdseq   = l_ac
                          
      INSERT INTO xrcd_t SELECT * FROM axrp350_tmp3  
      
      IF SQLCA.sqlcode THEN
        #CALL cl_errmsg('INSERT xrcd_t',g_isaf.isafdocno,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
        #151023-00016#1 Add  ---(S)---
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'INSERT xrcd_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
        #151023-00016#1 Add  ---(E)---
         LET g_success = 'N'
      END IF
      
      DROP TABLE axrp350_tmp3
      
      INSERT INTO axrp350_tmp2 VALUES (l_ac,g_xrcb.xrcbdocno)

      LET l_ac = l_ac + 1
   END FOREACH
END FUNCTION

PRIVATE FUNCTION axrp350_ins_isah()
   DEFINE l_ac         LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   DEFINE l_count      LIKE type_t.num5
   DEFINE l_isac006    LIKE type_t.num5
   DEFINE l_isah103    LIKE isah_t.isah103
   DEFINE l_isah104    LIKE isah_t.isah104
   DEFINE l_isah105    LIKE isah_t.isah105
   DEFINE l_isah113    LIKE isah_t.isah113
   DEFINE l_isah114    LIKE isah_t.isah114
   DEFINE l_isah115    LIKE isah_t.isah115


   #發票明細筆數
   SELECT isac006 INTO l_isac006
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = g_ooef019
      AND isac002 = g_input.isae004

   LET g_sql = " SELECT * FROM axrp350_tmp1 ",
                 "  ORDER BY num"

   PREPARE axrp350_pre2 FROM g_sql
   DECLARE axrp350_cs2 CURSOR FOR  axrp350_pre2

   LET l_isah103 = 0
   LET l_isah104 = 0
   LET l_isah105 = 0
   LET l_isah113 = 0
   LET l_isah114 = 0
   LET l_isah115 = 0

   LET l_ac = 1
   LET l_count = 1
   FOREACH axrp350_cs2 INTO l_num,g_xrcd[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

#      LET g_isafdocno_t = g_isafdocno
#      #若筆數超過一張發票明細限制,則要再取第二發票號碼
#      IF l_isac006 <> 0 AND l_ac > l_isac006 THEN
#         CALL axrp350_isafdocno_get()
#         LET l_count = 1
#         CALL axrp350_ins_isaf()
#         IF g_success = 'Y' THEN
#            CALL axrp350_ins_isag()
#         END IF
#      END IF
#
#      IF g_isafdocno_t <> g_isafdocno THEN
#         UPDATE isaf_t SET isaf103 = l_isah103,
#                           isaf104 = l_isah104,
#                           isaf105 = l_isah105,
#                           isaf113 = l_isah113,
#                           isaf114 = l_isah114,
#                           isaf115 = l_isah115
#          WHERE isafent = g_enterprise
#            AND isafcomp = g_xrca.xrcacomp
#            AND isafdocno = g_isafdocno_t
#         LET l_isah103 = 0
#         LET l_isah104 = 0
#         LET l_isah105 = 0
#         LET l_isah113 = 0
#         LET l_isah114 = 0
#         LET l_isah115 = 0
#      END IF

      LET g_isah.isahent = g_enterprise
      LET g_isah.isahcomp = g_isaf.isafcomp
      LET g_isah.isahdocno = g_isaf.isafdocno
      LET g_isah.isahseq = l_count
      LET g_isah.isahorga = g_xrcd[l_ac].xrcborga
      LET g_isah.isah001 = g_xrcd[l_ac].xrcb027
      LET g_isah.isah002 = g_xrcd[l_ac].xrcb028
      LET g_isah.isah003 = g_xrcd[l_ac].xrcb004
      LET g_isah.isah004 = g_xrcd[l_ac].xrcb005
      LET g_isah.isah005 = g_xrcd[l_ac].xrcb006
      LET g_isah.isah006 = g_xrcd[l_ac].xrcb007
      LET g_isah.isah007 = g_xrcd[l_ac].xrcd003
      LET g_isah.isah101 = g_xrcd[l_ac].xrcb101

      IF g_xrca.xrca001 = '12' OR g_xrca.xrca001 = '19' THEN
         LET g_isah.isah103 = g_xrcd[l_ac].xrcd103
         LET g_isah.isah104 = g_xrcd[l_ac].xrcd104
         LET g_isah.isah105 = g_xrcd[l_ac].xrcd105
         LET g_isah.isah113 = g_xrcd[l_ac].xrcd113
         LET g_isah.isah114 = g_xrcd[l_ac].xrcd114
         LET g_isah.isah115 = g_xrcd[l_ac].xrcd115
      END IF

      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isah.isah103 =  g_xrcd[l_ac].xrcd103 * g_gzcb003
         LET g_isah.isah104 =  g_xrcd[l_ac].xrcd104 * g_gzcb003
         LET g_isah.isah105 =  g_xrcd[l_ac].xrcd105 * g_gzcb003
         LET g_isah.isah113 =  g_xrcd[l_ac].xrcd113 * g_gzcb003
         LET g_isah.isah114 =  g_xrcd[l_ac].xrcd114 * g_gzcb003
         LET g_isah.isah115 =  g_xrcd[l_ac].xrcd115 * g_gzcb003
      END IF
      
      #161128-00061#3-----modify--begin----------
      #INSERT INTO isah_t VALUES (g_isah.*)
      INSERT INTO isah_t (isahent,isahcomp,isahdocno,isahseq,isahorga,isah001,isah002,isah003,isah004,
                          isah005,isah006,isah007,isah008,isah009,isah010,isah101,isah103,isah104,isah105,
                          isah113,isah114,isah115,isah011,isah012,isah013,isah106,isah116)
       VALUES (g_isah.isahent,g_isah.isahcomp,g_isah.isahdocno,g_isah.isahseq,g_isah.isahorga,g_isah.isah001,g_isah.isah002,g_isah.isah003,g_isah.isah004,
               g_isah.isah005,g_isah.isah006,g_isah.isah007,g_isah.isah008,g_isah.isah009,g_isah.isah010,g_isah.isah101,g_isah.isah103,g_isah.isah104,g_isah.isah105,
               g_isah.isah113,g_isah.isah114,g_isah.isah115,g_isah.isah011,g_isah.isah012,g_isah.isah013,g_isah.isah106,g_isah.isah116)
      #161128-00061#3-----modify--end----------
      IF SQLCA.SQLCODE THEN
        #CALL cl_errmsg('INSERT isah_t',g_isah.isahdocno,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
        #151023-00016#1 Add  ---(S)---
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'UPDATE isah_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
        #151023-00016#1 Add  ---(E)---
         LET g_success = 'N'
      END IF

      #DELETE FROM axrp350_tmp1 WHERE num = l_num

      LET l_isah103 = l_isah103 + g_isah.isah103
      LET l_isah104 = l_isah104 + g_isah.isah104
      LET l_isah105 = l_isah105 + g_isah.isah105
      LET l_isah113 = l_isah113 + g_isah.isah113
      LET l_isah114 = l_isah114 + g_isah.isah114
      LET l_isah115 = l_isah115 + g_isah.isah115

      LET l_ac = l_ac + 1
      LET l_count = l_count + 1
   END FOREACH

   #1.應稅  2.免稅  3.零稅
   SELECT oodb008 INTO g_oodb008
     FROM oodb_t
    WHERE oodbent = g_enterprise
      AND oodb001 = g_ooef019
      AND oodb002 = g_xrca.xrca011

   #正負值 +1/-1
   SELECT isai004 INTO g_isai004
     FROM isai_t
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019

   SELECT gzcb003 INTO g_gzcb003
     FROM gzcb_t
    WHERE gzcb001 = '9728'
      AND gzcb002 = g_isai004

   #1.應稅
   IF g_oodb008 = '1' THEN
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf119 = l_isah105 * g_gzcb003
      ELSE
         LET g_isaf.isaf119 = l_isah105
      END IF
      LET g_isaf.isaf120 = 0
      LET g_isaf.isaf121 = 0
   END IF

   #2.免稅
   IF g_oodb008 = '2' THEN
      LET g_isaf.isaf119 = 0
      LET g_isaf.isaf120 = 0
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf121 = l_isah105 * g_gzcb003
      ELSE
         LET g_isaf.isaf121 = l_isah105
      END IF
   END IF

   #3.零稅
   IF g_oodb008 = '3' THEN
      LET g_isaf.isaf119 = 0
      IF g_xrca.xrca001 = '22' OR g_xrca.xrca001 = '29' THEN
         LET g_isaf.isaf120 = l_isah105 * g_gzcb003
      ELSE
         LET g_isaf.isaf120 = l_isah105
      END IF
      LET g_isaf.isaf121 = 0
   END IF

   UPDATE isaf_t SET isaf103 = l_isah103,
                     isaf104 = l_isah104,
                     isaf105 = l_isah105,
                     isaf113 = l_isah113,
                     isaf114 = l_isah114,
                     isaf115 = l_isah115,
                     isaf119 = g_isaf.isaf119,
                     isaf120 = g_isaf.isaf120,
                     isaf121 = g_isaf.isaf121
    WHERE isafent = g_enterprise
      AND isafcomp = g_input.glaacomp
      AND isafdocno = g_isafdocno

    IF SQLCA.SQLCODE THEN
      #CALL cl_errmsg('UPDATE isaf_t',g_isafdocno,'',SQLCA.SQLCODE,1) #151023-00016#1 Mark
      #151023-00016#1 Add  ---(S)---
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.SQLCODE
       LET g_errparam.extend = 'UPDATE isaf_t'
       LET g_errparam.popup = FALSE
       CALL cl_err()
      #151023-00016#1 Add  ---(E)---
       LET g_success = 'N'
    END IF
END FUNCTION

PRIVATE FUNCTION axrp350_ins_tmp()

   IF g_input.isah_type = '1' THEN
      INSERT INTO axrp350_tmp1
      SELECT rownum,xrcborga,xrcb027,xrcb028,xrcb004,xrcb005,xrcb006,
             xrcb007,xrcd003,xrcb101,
             xrcd103,xrcd104,xrcd105,
             xrcd113,xrcd114,xrcd115
        FROM
        (SELECT xrcborga,xrcb027,xrcb028,xrcb004,xrcb005,xrcb006,
                xrcb007,xrcd003,xrcb101,
                SUM(xrcd103) xrcd103,SUM(xrcd104) xrcd104,SUM(xrcd105) xrcd105,
                SUM(xrcd113) xrcd113,SUM(xrcd114) xrcd114,SUM(xrcd115) xrcd115
           FROM xrca_t,xrcb_t,xrcd_t,ooef_t,oodb_t
          WHERE xrcbent = xrcdent
            AND xrcbdocno = xrcddocno
            AND xrcadocno = xrcbdocno
            AND xrcbseq  = xrcdseq
            AND xrcacomp = ooef001
            AND ooef019  = oodb001
            AND xrcd002  = oodb002
            AND oodb003  =  'T01'
            AND xrcastus = 'Y'
            AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp2)
            AND xrcald = g_input.xrcald
            GROUP BY xrcborga,xrcb027,xrcb028,xrcb004,xrcb005,xrcb006,xrcb007,xrcd003,xrcb101)
   END IF
   IF g_input.isah_type = '2' THEN
      INSERT INTO axrp350_tmp1
      SELECT rownum,xrcborga,xrcb027,xrcb028,xrcb004,xrcb005,xrcb006,
             xrcb007,xrcd003,xrcb101,xrcd103,xrcd104,xrcd105,
             xrcd113,xrcd114,xrcd115
        FROM xrca_t,xrcb_t,xrcd_t,ooef_t,oodb_t
       WHERE xrcbent = xrcdent
         AND xrcbdocno = xrcddocno
         AND xrcadocno = xrcbdocno
         AND xrcbseq  = xrcdseq
         AND xrcacomp = ooef001
         AND ooef019  = oodb001
         AND xrcd002  = oodb002
         AND oodb003  =  'T01'
         AND xrcastus = 'Y'
         AND xrcadocno IN (SELECT xrcadocno FROM axrp350_tmp2)
         AND xrcald = g_input.xrcald
   END IF


END FUNCTION

PRIVATE FUNCTION axrp350_isafdocno_get()
   DEFINE l_success    LIKE type_t.num5

   #獲取單號
   LET g_isafdocno = NULL
   CALL s_aooi200_fin_gen_docno(g_input.xrcald,'','',g_isae_m.isafdocno,g_today,'aist310')
   RETURNING l_success,g_isafdocno
   IF l_success  = 0  THEN
     #CALL cl_errmsg('',g_isafdocno,'','apm-00003',1) #151023-00016#1 Mark
     #151023-00016#1 Add  ---(S)---
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_isafdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
     #151023-00016#1 Add  ---(E)---
      LET g_success = 'N'
      RETURN
   END IF
END FUNCTION

PRIVATE FUNCTION axrp350_create_tmp()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF

   DROP TABLE axrp350_tmp;
   CREATE TEMP TABLE axrp350_tmp(
   sel               LIKE type_t.chr1,
   xrcald            LIKE xrca_t.xrcald,
   xrcadocno         LIKE xrca_t.xrcadocno,
   xrcadocdt         LIKE xrca_t.xrcadocdt,
   xrca004           LIKE type_t.chr80,
   xrca061           LIKE xrca_t.xrca061,
   xrca028           LIKE xrca_t.xrca028,
   xrca028_desc      LIKE type_t.chr80,
   xrcb001           LIKE xrcb_t.xrcb001,
   xrcb002           LIKE xrcb_t.xrcb002,
   xrcb003           LIKE xrcb_t.xrcb003,
   xrcb005           LIKE xrcb_t.xrcb005,
   xrcb007           LIKE xrcb_t.xrcb007,
   xrcb103           LIKE xrcb_t.xrcb103,
   xrcb104           LIKE xrcb_t.xrcb104,
   xrcb105           LIKE xrcb_t.xrcb105,
   xmdl022           LIKE xmdl_t.xmdl022,
   xmdl047           LIKE xmdl_t.xmdl047,
   xrcborga          LIKE xrcb_t.xrcborga,
   seq               LIKE type_t.num5
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axrp350_s01()
   DEFINE p_docno       LIKE xrca_t.xrcadocno
   DEFINE p_glaq001     LIKE glaq_t.glaq001
   DEFINE p_glaq002     LIKE glaq_t.glaq002
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002 
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE lwin_curr     ui.Window
   DEFINE lfrm_curr     ui.Form
   DEFINE ls_path       STRING
   DEFINE l_msg         STRING
   DEFINE l_today       LIKE isaf_t.isaf014


   OPEN WINDOW w_axrp350_s01 WITH FORM cl_ap_formpath("axr","axrp350_s01")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '9732' AND gzcb003 = 'AXR'"
   PREPARE axrp350_prep FROM l_sql
   DECLARE axrp350_curs CURSOR FOR axrp350_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrp350_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH

   CALL cl_set_combo_scc_part('isafdocdt_type','9732',l_str)
                 
   SELECT isai002,isai006 INTO g_isai002,g_isai006
     FROM isai_t 
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
      
   IF g_isai002 = '1' THEN 
      LET l_msg = cl_getmsg('ais-00112',g_dlang)
      CALL cl_set_comp_att_text('isae008',l_msg)
   END IF
   IF g_isai002 = '2' THEN 
      LET l_msg = cl_getmsg('ais-00113',g_dlang)
      CALL cl_set_comp_att_text('isae008',l_msg)
   END IF

   WHILE TRUE

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT BY NAME g_isae_m.isafdocno,g_isae_m.isafdocno_desc,g_isae_m.isafdocdt_type,
                       g_isae_m.isaf014,g_isae_m.isaf004,g_isae_m.isaf004_desc,
                       g_isae_m.isaf005,g_isae_m.isaf005_desc,g_isae_m.isaf006,
                       g_isae_m.str_no,g_isae_m.end_no,
                       g_isae_m.isaf006_desc,g_isae_m.isaesite,g_isae_m.isaesite_desc,
                       g_isae_m.isae001,g_isae_m.isae014,g_isae_m.isae008,
                       g_isae_m.isae012                   

            BEFORE INPUT
               DISPLAY g_isae_m.str_no TO str_no
               DISPLAY g_isae_m.end_no TO end_no
            
               IF g_isaq005 = '1' THEN   #1:列印時回寫  隱藏發票薄條件
                  CALL cl_set_comp_visible('lbl_group2',FALSE) 
               ELSE
                  CALL cl_set_comp_visible('lbl_group2',TRUE)
                  IF g_isac003 = '4' THEN  #發票類型為銷項折單
                     IF g_isai006 = 'N' THEN   #紅字發票與藍字發票共用發票簿
                        CALL cl_set_comp_visible('lbl_group2',FALSE)
                     END IF
                  END IF
               END IF
            
               IF g_isac003 = '2' THEN 
                  SELECT isao014 INTO g_isae_m.isafdocno 
                    FROM isao_t
                   WHERE isaoent = g_enterprise
                     AND isaosite = g_input.glaacomp
               END IF
                  
               IF g_isac003 = '4' THEN 
                  SELECT isao015 INTO g_isae_m.isafdocno 
                    FROM isao_t
                   WHERE isaoent = g_enterprise
                     AND isaosite = g_input.glaacomp
               END IF
               
               LET g_isae_m.isaf004 = g_input.glaacomp
               LET g_isae_m.isaf005 = g_user
               SELECT ooag003 INTO g_isae_m.isaf006 
                 FROM ooag_t
                WHERE ooagent = g_enterprise 
                  AND ooag001 = g_user
               
               SELECT COUNT(DISTINCT xrcborga) INTO l_n
                 FROM axrp350_tmp
                WHERE sel = 'Y'
                  
               IF l_n = '1' THEN 
                  SELECT DISTINCT xrcborga INTO g_isae_m.isaesite
                    FROM axrp350_tmp
                   WHERE sel = 'Y'
               ELSE
                  LET g_isae_m.isaesite = g_input.glaacomp
               END IF
               
               CALL axrp350_set_comp_entry('isae008,isae014',FALSE)
               LET g_isae_m.isafdocdt_type = '2'
               LET g_isae_m.isaf014 = g_today
               
               CALL axrp350_isafdocno_desc()
               CALL axrp350_isaf004_desc()
               CALL axrp350_isaf005_desc()
               CALL axrp350_isaf006_desc()
               CALL axrp350_isaesite_desc()
         
            AFTER FIELD isafdocno
               CALL axrp350_isafdocno_desc()
               IF NOT cl_null(g_isae_m.isafdocno) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ooef004
                  LET g_chkparam.arg2 = g_isae_m.isafdocno
			         #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)

                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooba002_04") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
			
                  ELSE
                     #檢查失敗時後續處理
                     LET g_isae_m.isafdocno = ''
                     CALL axrp350_isafdocno_desc()
                     NEXT FIELD CURRENT
                  END IF

               END IF


            ON CHANGE isafdocdt_type
               IF g_isae_m.isafdocdt_type = '1' THEN
                  CALL axrp350_set_comp_entry("isaf014",FALSE)
                  LET g_isae_m.isaf014 = ''
               END IF
               IF g_isae_m.isafdocdt_type = '2' THEN
                  CALL axrp350_set_comp_entry("isaf014",TRUE)
                  LET g_isae_m.isaf014 = g_today
                  #IF g_isae_m.isaf014 < g_isae017 THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'axr-00086'
                  #   LET g_errparam.extend = g_isae_m.isaf014
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   LET g_isae_m.isaf014 = ''
                  #   DISPLAY g_isae_m.isaf014 TO isaf014
                  #   NEXT FIELD isaf014
                  #END IF
               END IF


            AFTER FIELD isaf014
               #IF NOT cl_null(g_isae_m.isaf014) THEN
               #   IF g_isae_m.isaf014 < g_isae017 THEN
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.code = 'axr-00086'
               #      LET g_errparam.extend = g_isae_m.isaf014
               #      LET g_errparam.popup = TRUE
               #      CALL cl_err()
               #
               #      LET g_isae_m.isaf014 = ''
               #      DISPLAY g_isae_m.isaf014 TO isaf014
               #      NEXT FIELD isaf014
               #   END IF
               #END IF
               
            AFTER FIELD isaf004
               CALL axrp350_isaf004_desc()
               IF NOT cl_null(g_isae_m.isaf004) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_isae_m.isaf004
                  #160318-00025#35  2016/04/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#35  2016/04/15  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001") THEN
                     #檢查成功時後續處理

                  ELSE
                     #檢查失敗時後續處理
                     LET g_isae_m.isaf004 = ''
                     CALL axrp350_isaf004_desc()
                     NEXT FIELD CURRENT
                  END IF
               
               END IF 
               
            AFTER FIELD isaf005
               CALL axrp350_isaf005_desc()
               IF NOT cl_null(g_isae_m.isaf005) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_isae_m.isaf005
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理

                  ELSE
                     #檢查失敗時後續處理
                     LET g_isae_m.isaf005 = ''
                     CALL axrp350_isaf005_desc()
                     NEXT FIELD CURRENT
                  END IF
               
               END IF 
               
           AFTER FIELD isaf006
              CALL axrp350_isaf006_desc()
              IF NOT cl_null(g_isae_m.isaf006) THEN    
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                 INITIALIZE g_chkparam.* TO NULL      
                 
                 #設定g_chkparam.*的參數
                 LET g_chkparam.arg1 = g_isae_m.isaf006
                 #160318-00025#35  2016/04/15  by pengxin  add(S)
                 LET g_errshow = TRUE #是否開窗 
                 LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#35  2016/04/15  by pengxin  add(E)
                 #呼叫檢查存在並帶值的library
                 IF cl_chk_exist("v_ooef001") THEN
                    #檢查成功時後續處理

                 ELSE
                    #檢查失敗時後續處理
                    LET g_isae_m.isaf006 = ''
                    CALL axrp350_isaf006_desc()
                    NEXT FIELD CURRENT
                 END IF
              
              END IF               

            AFTER FIELD isaesite
               IF NOT cl_null(g_isae_m.isaesite) THEN            
                  CALL axrp350_isaesite_chk()             
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     LET g_isae_m.isaesite = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL axrp350_isaesite_desc()
               CALL axrp350_isae_get()
               
            AFTER FIELD isae001
               IF NOT cl_null(g_isae_m.isae001) THEN    
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                 INITIALIZE g_chkparam.* TO NULL      
                 
                 #設定g_chkparam.*的參數
                 LET g_chkparam.arg1 = g_isae_m.isaesite
                 LET g_chkparam.arg2 = g_isae_m.isae001
              
                 #呼叫檢查存在並帶值的library
                 IF cl_chk_exist("v_isae001") THEN
                    #檢查成功時後續處理
                    CALL axrp350_isae_get()
                 ELSE
                    #檢查失敗時後續處理
                    LET g_isae_m.isae001 = ''
                    NEXT FIELD CURRENT
                 END IF
              
              END IF      

            ON ACTION controlp INFIELD isafdocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
			
               LET g_qryparam.default1 = g_isae_m.isafdocno             #給予default值

               LET g_qryparam.where = " ooba001 = '",g_ooef004,"' AND oobx003 = 'aist310'"
               #給予arg
			
               CALL q_ooba002()                                #呼叫開窗
			
               LET g_isae_m.isafdocno = g_qryparam.return1              #將開窗取得的值回傳到變數
			
               DISPLAY g_isae_m.isafdocno TO isafdocno              #顯示到畫面上
               CALL axrp350_isafdocno_desc()
               NEXT FIELD isafdocno                          #返回原欄位
               
            ON ACTION controlp INFIELD isaf004
               #add-point:ON ACTION controlp INFIELD isaf004
#此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_isae_m.isaf004             #給予default值
               
               #給予arg
               
               CALL q_ooef001()                                #呼叫開窗
               
               LET g_isae_m.isaf004 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_isae_m.isaf004 TO isaf004              #顯示到畫面上
               CALL axrp350_isaf004_desc()
               NEXT FIELD isaf004                          #返回原欄位
               
            ON ACTION controlp INFIELD isaf005
               #add-point:ON ACTION controlp INFIELD isaf005
#此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_isae_m.isaf005             #給予default值
               
               #給予arg
               
               CALL q_ooag001()                                #呼叫開窗
               
               LET g_isae_m.isaf005 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_isae_m.isaf005 TO isaf005              #顯示到畫面上
               CALL axrp350_isaf005_desc()
               NEXT FIELD isaf005                          #返回原欄位
               
            ON ACTION controlp INFIELD isaf006
               #add-point:ON ACTION controlp INFIELD isaf006
#此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_isae_m.isaf006             #給予default值
               
               #給予arg
               
               CALL q_ooef001()                                #呼叫開窗
               
               LET g_isae_m.isaf006 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_isae_m.isaf006 TO isaf006              #顯示到畫面上
               CALL axrp350_isaf006_desc()
               NEXT FIELD isaf006                          #返回原欄位
               
            ON ACTION controlp INFIELD isaesite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	    		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isaesite             #給予default值
               LET g_qryparam.where = "   isaesite IN ('",g_isae_m.isaesite,"','",g_input.glaacomp,"' ) ",
                                         "   AND isae004  = '",g_input.isae004,"'",
                                         "   AND isae002 <= '",g_isae_m.isaf014,"'",
                                         "   AND isae003 >= '",g_isae_m.isaf014,"'"            
               CALL q_isaesite_3()                                        #呼叫開窗
               LET g_isae_m.isaesite = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_isae_m.isae001  = g_qryparam.return2 
               DISPLAY g_isae_m.isaesite TO isaesite                   #顯示到畫面上
               CALL axrp350_isaesite_desc()
               NEXT FIELD isaesite 
               
            ON ACTION controlp INFIELD isae001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	    		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isae001             #給予default值
               IF cl_null(g_isae_m.isaf014) THEN 
                  LET l_today = g_today
               ELSE
                  LET l_today = g_isae_m.isaf014
               END IF
               LET g_qryparam.where = "   isaesite IN ('",g_isae_m.isaesite,"','",g_input.glaacomp,"' ) ",
                                         "   AND isae004  = '",g_input.isae004,"'",
                                         "   AND isae002 <= '",l_today,"'",
                                         "   AND isae003 >= '",l_today,"'"            
               CALL q_isaesite_3()                                        #呼叫開窗
               LET g_isae_m.isae001 = g_qryparam.return2              #將開窗取得的值回傳到變數
               DISPLAY g_isae_m.isae001 TO isae001                   #顯示到畫面上
               NEXT FIELD isae001 
           

            AFTER INPUT
               

         END INPUT

         ON ACTION accept
            ACCEPT DIALOG

         ON ACTION cancel      #在dialog button (放棄)
            LET g_action_choice=""
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
      END DIALOG

  
  
  IF INT_FLAG THEN
     LET INT_FLAG = TRUE 
     EXIT WHILE
  ELSE
     CALL axrp350_p()
     DISPLAY g_isae_m.str_no TO str_no
     DISPLAY g_isae_m.end_no TO end_no
     CONTINUE WHILE
  END IF
  
  END WHILE

  #畫面關閉
  CLOSE WINDOW w_axrp350_s01
END FUNCTION
# 帳款客戶名稱
PRIVATE FUNCTION axrp350_xrca004_desc()
   DEFINE l_xrca004_desc    LIKE type_t.chr200
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].b_xrca004
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xrca004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME l_xrca004_desc
   
   LET g_detail_d[l_ac].b_xrca004 = g_detail_d[l_ac].b_xrca004,l_xrca004_desc
END FUNCTION
# 單別名稱
PRIVATE FUNCTION axrp350_isafdocno_desc()
   CALL s_aooi200_fin_get_slip_desc(g_isae_m.isafdocno)
   RETURNING g_isae_m.isafdocno_desc
   DISPLAY g_isae_m.isafdocno_desc TO isafdocno_desc
END FUNCTION
# 業務組織名稱
PRIVATE FUNCTION axrp350_isaf004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaf004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaf004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_isae_m.isaf004_desc
END FUNCTION
# 開票人員名稱
PRIVATE FUNCTION axrp350_isaf005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaf005
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_isae_m.isaf005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_isae_m.isaf005_desc
END FUNCTION
# 開票部門名稱
PRIVATE FUNCTION axrp350_isaf006_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaf006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaf006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_isae_m.isaf006_desc
END FUNCTION
# 營運據點名稱
PRIVATE FUNCTION axrp350_isaesite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_isae_m.isaesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isae_m.isaesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_isae_m.isaesite_desc
END FUNCTION
# 營運據點檢查
PRIVATE FUNCTION axrp350_isaesite_chk()
   DEFINE l_count     LIKE type_t.num10  # 錯誤數目  
   DEFINE l_site      LIKE isae_t.isaesite  
   DEFINE l_today     LIKE isaf_t.isaf014   

   LET g_errno = ''
   
   IF cl_null(g_isae_m.isaf014) THEN 
      LET l_today = g_today
   ELSE
      LET l_today = g_isae_m.isaf014
   END IF
   
   LET l_count = 0
   SELECT count (*) INTO l_count 
     FROM isae_t 
    WHERE isaeent = g_enterprise
      AND isaesite IN (g_isae_m.isaesite,g_input.glaacomp) 
      AND isae004  = g_input.isae004
      AND isae002 <= l_today
      AND isae003 >= l_today
    
   IF l_count = 0 THEN
      LET g_errno ='ais-00144'
   END IF
    
   SELECT isaesite INTO l_site 
     FROM isae_t 
    WHERE isaeent = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae004  = g_input.isae004
      AND isae002 <= l_today
      AND isae003 >= l_today

   IF cl_null(l_site) THEN
      LET g_errno ='ais-00144'
   END IF
    
END FUNCTION
# 抓取發票簿預設值
PRIVATE FUNCTION axrp350_isae_get()
   DEFINE l_isae007     LIKE isae_t.isae007
   DEFINE l_isae008     LIKE isae_t.isae008
   DEFINE l_today       LIKE isaf_t.isaf014
   
   IF cl_null(g_isae_m.isaf014) THEN 
      LET l_today = g_today
   ELSE
      LET l_today = g_isae_m.isaf014
   END IF
   
   SELECT isae005,isae014,isae007,isae008,isae012
     INTO g_isae005,g_isae_m.isae014,l_isae007,l_isae008,g_isae012
     FROM isae_t           
    WHERE isaeent = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae001  = g_isae_m.isae001
      AND isae002 <= l_today
      AND isae003 >= l_today
   
   IF g_isai002 = '1' THEN 
      LET g_isae_m.isae008 = l_isae007
   END IF
   
   IF g_isai002 = '2' THEN 
      LET g_isae_m.isae008 = l_isae008
   END IF
   
   LET g_isae_m.isae012 = g_isae012
END FUNCTION
# 赋默认值
PRIVATE FUNCTION axrp350_default()
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE gzze_t.gzze001 
   
  #160413-00024#1 Mod  ---(S)---
  #CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_input.xrcald,g_input.glaacomp,l_errno  
   
   SELECT ooef017 INTO g_input.glaacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      
   SELECT glaald INTO g_input.xrcald
    FROM glaa_t
   WHERE glaacomp = g_input.glaacomp
     AND glaaent  = g_enterprise
     AND glaa014  = 'Y'
     
  #160413-00024#1 Mod  ---(E)---
   CALL axrp350_xrcald_desc()
   LET g_input.xmdk016 = g_ooef016
   LET g_input.total_type = '1'
   LET g_input.isah_type  = '1'
   
   CALL axrp350_xrcald_desc()
END FUNCTION

#end add-point
 
{</section>}
 
