#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp134.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-06-09 15:51:44), PR版次:0015(2016-12-01 14:03:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000174
#+ Filename...: axrp134
#+ Description: 銷退單批次立應收帳款作業
#+ Creator....: 01727(2014-06-06 00:00:00)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp134.global" >}
#應用 p02 樣板自動產生(Version:20)
#add-point:填寫註解說明 name="global.memo"
#160414-00007#1   2016/04/14 By Smapmin   修改參數寫死中文字問題
#160318-00025#42  2016/04/25 By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00005#1   2016/05/06 By 01531     取法人據點之交易對象檔,若取不到法人據點時, 取 據點代碼='ALL'
#160811-00009#4   2016/08/22 By 01531     账务中心/法人/账套权限控管
#160905-00007#3   2016/09/05 By zhujing   调整系统中无ENT的SQL条件增加ent
#161128-00061#3   2016/12/01 by 02481     标准程式定义采用宣告模式,弃用.*写法
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel             LIKE type_t.chr1,
        xmdk007         LIKE xmdk_t.xmdk007,
        xmdk082         LIKE xmdk_t.xmdk082,
        xmdldocno       LIKE xmdl_t.xmdldocno,
        xmdlseq         LIKE xmdl_t.xmdlseq,
        xmdl008         LIKE xmdl_t.xmdl008,
        imaal003        LIKE type_t.chr200,
        xmdl003         LIKE xmdl_t.xmdl003,
        xmdl001         LIKE xmdl_t.xmdl003,
        xmdl018         LIKE type_t.chr200,
        xmdk016         LIKE xmdk_t.xmdk016,
        xmdl027         LIKE type_t.chr200,
        xrcb007         LIKE xrcb_t.xrcb007,
        xrcb103         LIKE xrcb_t.xrcb103,
        xrcb105         LIKE xrcb_t.xrcb105,
        xmdl048         LIKE xmdl_t.xmdl048,
        xmdk008         LIKE type_t.chr200,
        xmdlsite        LIKE type_t.chr200,
        xmdk003         LIKE xmdk_t.xmdk003,
        xmdk003_s       LIKE type_t.chr200,
        xmdk004         LIKE xmdk_t.xmdk004,
        xmdk004_s       LIKE type_t.chr200,
        xmdk010         LIKE type_t.chr200,
        lbl_hide        LIKE type_t.chr1,
        xmdl017         LIKE xmdl_t.xmdl017,
        xmdl021         LIKE xmdl_t.xmdl021,
        xmdl048_1       LIKE xmdl_t.xmdl048,
        xmdl049_1       LIKE xmdl_t.xmdl049,
        xrcb007_t       LIKE xrcb_t.xrcb007,
        xrcb103_t       LIKE xrcb_t.xrcb103,
        xrcb105_t       LIKE xrcb_t.xrcb105
                     END RECORD
TYPE type_g_xrca_m   RECORD
        xrcasite        LIKE xrca_t.xrcasite,
        xrcasite_desc   LIKE ooefl_t.ooefl003,
        xrcald          LIKE xrca_t.xrcald,
        xrcald_desc     LIKE glaal_t.glaal002,
        xrcacomp        LIKE type_t.chr80,
        comb1           LIKE type_t.chr1,
        check1          LIKE type_t.chr1
                     END RECORD
DEFINE g_xrca_m      type_g_xrca_m
DEFINE g_conditions  RECORD
          xrcasite           LIKE xrca_t.xrcasite,
          xrcasite_desc      LIKE ooefl_t.ooefl003,
          xrcald             LIKE xrca_t.xrcald,
          xrcald_desc        LIKE glaal_t.glaal002,
          xrcacomp           LIKE type_t.chr200,
          comb1              LIKE type_t.chr1,
          comb2              LIKE type_t.chr1,
          xrcadocno          LIKE oobx_t.oobx001,
          xrcadocno_desc     LIKE oobxl_t.oobxl003,
          xrca003            LIKE xrca_t.xrca003,
          xrca003_desc       LIKE oofa_t.oofa011,
          check1             LIKE type_t.chr1,
          check2             LIKE type_t.chr1,
          check3             LIKE type_t.chr1,
          xrcadocdt          LIKE xrca_t.xrcadocdt,
          xrca007            LIKE xrca_t.xrca007,
          xrca007_desc       LIKE oocql_t.oocql004,
          xrca063            LIKE xrca_t.xrca063
                     END RECORD
DEFINE g_sel         DYNAMIC ARRAY OF VARCHAR(500)
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa                RECORD LIKE glaa_t.*
#DEFINE g_xrca                RECORD LIKE xrca_t.*
#DEFINE g_xrcb                RECORD LIKE xrcb_t.*
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

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_rec_b       LIKE type_t.num5              #單身筆數
DEFINE g_detail_idx  LIKE type_t.num5 
DEFINE g_rec_b1      LIKE type_t.num5              #單身筆數
DEFINE g_detail_idx1 LIKE type_t.num5 
DEFINE l_ac1         LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="axrp134.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success    LIKE type_t.num5   #add--2015/03/19 By shiun
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp134 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp134_init()   
 
      #進入選單 Menu (="N")
      CALL axrp134_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp134
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp134.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp134_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("comb1",8325)
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp134.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp134_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_s               LIKE type_t.chr1
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_comb1           LIKE type_t.chr1
   DEFINE l_xrcacomp        LIKE xrca_t.xrcacomp
   DEFINE ls_wc             STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp134_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
        INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcald,g_xrca_m.comb1,g_xrca_m.check1
        
           BEFORE INPUT
              CALL axrp134_def()
          
           AFTER FIELD xrcald
              IF NOT cl_null(g_xrca_m.xrcald) THEN 
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
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
                    FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_xrca_m.xrcald
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 LET g_xrca_m.xrcald_desc = ''
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
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp
             
           AFTER FIELD xrcasite
              IF NOT cl_null(g_xrca_m.xrcasite) THEN
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 IF NOT l_success THEN NEXT FIELD CURRENT END IF
              ELSE
                 LET g_xrca_m.xrcasite_desc = ''
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
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp

           BEFORE FIELD comb1

           ON CHANGE comb1

           ON ACTION controlp INFIELD xrcald
              #取得帳務組織下所屬成員
              CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
              #取得帳務組織下所屬成員之帳別   
              CALL s_fin_account_center_comp_str() RETURNING ls_wc
              #將取回的字串轉換為SQL條件
              CALL axrp134_get_ooef001_wc(ls_wc) RETURNING ls_wc  
              #開窗i段
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
			     LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
#160811-00009#4 mod s---              
#              IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#              ELSE
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#              END IF
              LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#160811-00009#4 mod e---
              LET g_qryparam.arg1 = g_user
              LET g_qryparam.arg2 = g_dept
              CALL  q_authorised_ld()                                  #呼叫開窗
              LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
              IF NOT cl_null(g_xrca_m.xrcald) THEN
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 #161128-00061#3-----modify--begin----------
                 #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                 #161128-00061#3-----modify--end---------- 
                 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
                 IF NOT cl_null(g_glaa.glaacomp) THEN
                    CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                    LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
                 ELSE
                    LET g_xrca_m.xrcacomp = ''
                 END IF
              END IF
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp
              NEXT FIELD xrcald                              #返回原欄位  
        
           ON ACTION controlp INFIELD xrcasite
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrca_m.xrcasite             #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 

            #給予arg

            CALL q_ooef001()                                        #呼叫開窗
            LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
            IF NOT cl_null(g_xrca_m.xrcasite) THEN
               CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
               #161128-00061#3-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#3-----modify--end---------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
               IF NOT cl_null(g_glaa.glaacomp) THEN
                  CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                  LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
               ELSE
                  LET g_xrca_m.xrcacomp = ''
               END IF
            END IF
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
            DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
            DISPLAY BY NAME g_xrca_m.xrcacomp
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
            NEXT FIELD xrcasite

        END INPUT 
        
        #螢幕上取條件
         CONSTRUCT BY NAME g_wc ON xmdk007,xmdk001,xmdk003,xmdl003,xmdldocno,xmdl001
           
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
        
            ON ACTION controlp INFIELD xmdk007              #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE      
               LET g_qryparam.arg1  = 'ALL'
               CALL q_pmaa001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007        #顯示到畫面上
               NEXT FIELD xmdk007                           #返回原欄位

            ON ACTION controlp INFIELD xmdk003              #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE      
               CALL q_ooag001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003        #顯示到畫面上
               NEXT FIELD xmdk003                           #返回原欄位

            ON ACTION controlp INFIELD xmdl003              #開窗c段
               CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = g_xrca_m.xrcasite
               LET g_qryparam.arg2  = l_s
               CALL q_xmdl003()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdl003        #顯示到畫面上
               NEXT FIELD xmdl003                           #返回原欄位

            ON ACTION controlp INFIELD xmdldocno            #開窗c段
               CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = g_xrca_m.xrcasite
               LET g_qryparam.arg2  = l_s
               CALL q_xmdl_101()                            #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdldocno      #顯示到畫面上
               NEXT FIELD xmdldocno                         #返回原欄位

            ON ACTION controlp INFIELD xmdl001              #開窗c段
               CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = g_xrca_m.xrcasite
               LET g_qryparam.arg2  = l_s
               CALL q_xmdl_10()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdl001        #顯示到畫面上
               NEXT FIELD xmdl001                           #返回原欄位

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
    
            BEFORE INPUT
               LET l_ac = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               IF l_ac > 0 THEN
                  IF g_detail_d[l_ac].sel = 'N' THEN
                     CALL cl_set_comp_entry('b_xrcb007,b_xrcb103,b_xrcb105',FALSE)
                     NEXT FIELD sel
                  ELSE
                     CALL cl_set_comp_entry('b_xrcb007,b_xrcb103,b_xrcb105',TRUE)
                  END IF
               END IF

            ON CHANGE sel
               IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                  IF g_detail_d[l_ac].sel = 'N' THEN
                     CALL cl_set_comp_entry('b_xrcb007,b_xrcb103,b_xrcb105',FALSE)
                     NEXT FIELD sel
                  ELSE
                     CALL cl_set_comp_entry('b_xrcb007,b_xrcb103,b_xrcb105',TRUE)
                  END IF
               END IF

            BEFORE FIELD b_xrcb007
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD sel
               END IF

            AFTER FIELD b_xrcb007
               IF NOT cl_null(g_detail_d[l_ac].xrcb007) THEN
                  IF g_detail_d[l_ac].xrcb007 > g_detail_d[l_ac].xrcb007_t OR g_detail_d[l_ac].xrcb007 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00126'
                     LET g_errparam.extend = g_detail_d[l_ac].xrcb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].xrcb007 = g_detail_d[l_ac].xrcb007_t
                     DISPLAY g_detail_d[l_ac].xrcb007 TO s_detail1[l_ac].xrcb007
                     NEXT FIELD CURRENT
                  END IF
               END IF

            BEFORE FIELD b_xrcb103
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD sel
               END IF

            AFTER FIELD b_xrcb103
               IF NOT cl_null(g_detail_d[l_ac].xrcb103) THEN
                  IF g_detail_d[l_ac].xrcb103 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00127'
                     LET g_errparam.extend = g_detail_d[l_ac].xrcb103
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].xrcb103 = g_detail_d[l_ac].xrcb103_t
                     DISPLAY g_detail_d[l_ac].xrcb103 TO s_detail1[l_ac].xrcb103
                     NEXT FIELD CURRENT
                  END IF
                  IF g_detail_d[l_ac].xrcb103 > g_detail_d[l_ac].xrcb103_t THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00128'
                     LET g_errparam.extend = g_detail_d[l_ac].xrcb103
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].xrcb103 = g_detail_d[l_ac].xrcb103_t
                     DISPLAY g_detail_d[l_ac].xrcb103 TO s_detail1[l_ac].xrcb103
                     NEXT FIELD CURRENT
                  END IF
               END IF

            BEFORE FIELD b_xrcb105
               IF g_detail_d[l_ac].sel = 'N' THEN
                  NEXT FIELD sel
               END IF

            AFTER FIELD b_xrcb105
               IF NOT cl_null(g_detail_d[l_ac].xrcb105) THEN
                  IF g_detail_d[l_ac].xrcb105 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00127'
                     LET g_errparam.extend = g_detail_d[l_ac].xrcb105
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].xrcb105 = g_detail_d[l_ac].xrcb105_t
                     DISPLAY g_detail_d[l_ac].xrcb105 TO s_detail1[l_ac].xrcb105
                     NEXT FIELD CURRENT
                  END IF
                  IF g_detail_d[l_ac].xrcb105 > g_detail_d[l_ac].xrcb105_t THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00128'
                     LET g_errparam.extend = g_detail_d[l_ac].xrcb105
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].xrcb105 = g_detail_d[l_ac].xrcb105_t
                     DISPLAY g_detail_d[l_ac].xrcb105 TO s_detail1[l_ac].xrcb105
                     NEXT FIELD CURRENT
                  END IF
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
            NEXT FIELD xrcasite
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
            NEXT FIELD xrcasite
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
            NEXT FIELD xrcasite
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp134_filter()
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
            CALL axrp134_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_xrca_m.* TO NULL
            CALL axrp134_def()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp134_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"

         ON ACTION open_axrp134_s01
            LET g_action_choice="open_axrp134_s01"
            IF cl_auth_chk_act("open_axrp134_s01") THEN
               CALL axrp134_s01()
               EXIT DIALOG
            END IF

         ON ACTION batch_execute
            LET g_action_choice="batch_execute"
            IF cl_auth_chk_act("batch_execute") THEN
               CALL axrp134_s01()
               EXIT DIALOG
            END IF

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
 
{<section id="axrp134.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp134_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xrcd103     LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104     LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105     LIKE xrcd_t.xrcd105
   DEFINE l_xrcd113     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115     LIKE xrcd_t.xrcd115
   DEFINE ls_wc1        STRING
   DEFINE ls_wc2        STRING
   DEFINE ls_wc3        STRING
   DEFINE l_xmdk        RECORD
             flag          LIKE type_t.chr1,
             xmdk007       LIKE xmdk_t.xmdk007,
             xmdk000       LIKE xmdk_t.xmdk000,
             xmdl003       LIKE xmdl_t.xmdl003,
             xmdl048       LIKE xmdl_t.xmdl048,
             xmdl049       LIKE xmdl_t.xmdl049,
             xmdldocno     LIKE xmdl_t.xmdldocno,
             xmdlseq       LIKE xmdl_t.xmdlseq,
             xmdl008       LIKE xmdl_t.xmdl008,
             imaal003      LIKE imaal_t.imaal003,
             imaal004      LIKE imaal_t.imaal004,
             xmdk003       LIKE xmdk_t.xmdk003,
             xmdk004       LIKE xmdk_t.xmdk004,
             xmdk010       LIKE xmdk_t.xmdk010,
             xmdl018       LIKE xmdl_t.xmdl018,
             xmdl017       LIKE xmdl_t.xmdl017,
             xmdl022       LIKE xmdl_t.xmdl022,
             xmdl021       LIKE xmdl_t.xmdl021,
             xmdk016       LIKE xmdk_t.xmdk016,
             xmdl027       LIKE xmdl_t.xmdl027,
             xmdl028       LIKE xmdl_t.xmdl028,
             xmdk008       LIKE xmdk_t.xmdk008,
             xmdlsite      LIKE xmdl_t.xmdlsite,
             xmdl026       LIKE xmdl_t.xmdl026,
             xmdl024       LIKE xmdl_t.xmdl024,
             xrcb007       LIKE xrcb_t.xrcb007,
             xrcb103       LIKE xrcb_t.xrcb103,
             xrcb105       LIKE xrcb_t.xrcb105,
             xmdk017       LIKE xmdk_t.xmdk017,
             xmdl025       LIKE xmdl_t.xmdl025,
             xmdk012       LIKE xmdk_t.xmdk012,
             xrca001       LIKE xrca_t.xrca001
                        END RECORD
   DEFINE l_s_bas_0012  LIKE gzsz_t.gzsz008
   DEFINE l_s_bas_0011  LIKE gzsz_t.gzsz008
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
 
   #end add-point
        
   LET g_error_show = 1
   CALL axrp134_b_fill()
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
 
{<section id="axrp134.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp134_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_imaal003      LIKE imaal_t.imaal003
   DEFINE l_imaal004      LIKE imaal_t.imaal004
   DEFINE ls_wc1          STRING
   DEFINE ls_wc2          STRING
   DEFINE l_s             LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_xrcd103       LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104       LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105       LIKE xrcd_t.xrcd105
   DEFINE l_xrcd113       LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114       LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115       LIKE xrcd_t.xrcd115
   DEFINE l_xmdk017       LIKE xmdk_t.xmdk017
   DEFINE l_xmdl024       LIKE xmdl_t.xmdl024
   DEFINE l_xmdl025       LIKE xmdl_t.xmdl025
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   IF g_xrca_m.comb1 = '1' THEN
      LET ls_wc1 = " xmdk083 = 'N'"
   ELSE
      LET ls_wc1 = " xmdk083 = 'N'"
   END IF

   IF g_xrca_m.check1 = 'Y' THEN   #銷退單顯示
      LET ls_wc2 = " (xmdk000 <> '5' OR (xmdk000 = '5' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y')))"
   ELSE
      LET ls_wc2 = " xmdk000 <> '5'"
   END IF

   LET g_sql = "SELECT 'N',xmdk007,xmdk082,xmdldocno,xmdlseq,xmdl008,                 ",
               "       imaal003 || '\n' || imaal004,xmdl003,xmdl001,                  ",
               "       xmdl018 || ' ' || xmdl017 || '\n' || xmdl022 || ' ' || xmdl021,",
               "       xmdk016,xmdl027 || '\n' || xmdl028,xrcb007,0,0,                ",
               "       xmdl048 || '\n' || xmdl049,xmdk008,xmdlsite,xmdk003,'',        ",
               "       xmdk004,'',xmdk010,'',xmdl017,xmdl021,xmdl048,xmdl049,0,0,0,   ",
               "       xmdk017,xmdl024,xmdl025                                        ",
               "  FROM (SELECT xmdk007,xmdk082,xmdlseq,xmdl008,xmdl049,xmdldocno,     ",
               "               xmdl003,xmdl001,xmdl018,xmdl017,xmdl022,imaal003,      ",
               "               xmdl021,xmdk016,xmdl027,xmdl028,xmdl048,xmdlsite,      ",
               "               xmdk008,xmdk003,xmdk004,xmdk010,imaal004,xmdk000,      ",
               "               xmdk017,xmdl024,xmdl025,                               ",
               "               CASE                                                   ",
               "                  WHEN '",l_s,"' = '1' THEN                           ",
               "                     CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END",
               "                   - CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END",
               "                  WHEN '",l_s,"' = '2' THEN                           ",
               "                     CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END",
               "                   - CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END",
               "                  WHEN '",l_s,"' = '3' THEN                           ",
               "                     CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END",
               "                   - CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END",
               "               END xrcb007                                            ",
               "          FROM xmdk_t, xmdl_t, imaal_t                                ",
               "         WHERE     xmdkdocno = xmdldocno        AND xmdkent = xmdlent ",
               "               AND xmdkent = ?                  AND imaalent = xmdkent",
               "               AND imaal002 = '",g_lang,"'      AND imaal001 = xmdl008",
               "               AND xmdkstus = 'S'               AND xmdl087 = 'Y'     ",
          #    "               AND xmdk000 IN ('5','6')                               ",
               "               AND ", g_wc CLIPPED,
               "               AND ",ls_wc1 CLIPPED,
               "               AND ",ls_wc2 CLIPPED,"                                 )"
   #end add-point
 
   PREPARE axrp134_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp134_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*,l_xmdk017,l_xmdl024,l_xmdl025
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

      IF NOT cl_null(l_xmdl024) AND NOT cl_null(l_xmdl025) AND NOT cl_null(g_detail_d[l_ac].xrcb007) THEN
         CALL s_tax_count(g_detail_d[l_ac].xmdlsite,l_xmdl025,g_detail_d[l_ac].xrcb007 * l_xmdl024,
                          g_detail_d[l_ac].xrcb007,g_detail_d[l_ac].xmdk016,l_xmdk017)
            RETURNING l_xrcd103,l_xrcd104,l_xrcd105,
                      l_xrcd113,l_xrcd114,l_xrcd115
         LET g_detail_d[l_ac].xrcb103 = l_xrcd103
         LET g_detail_d[l_ac].xrcb105 = l_xrcd105
      ELSE
         LET g_detail_d[l_ac].xrcb103 = 0
         LET g_detail_d[l_ac].xrcb105 = 0
      END IF

      LET g_detail_d[l_ac].xrcb007_t = g_detail_d[l_ac].xrcb007
      LET g_detail_d[l_ac].xrcb103_t = g_detail_d[l_ac].xrcb103
      LET g_detail_d[l_ac].xrcb105_t = g_detail_d[l_ac].xrcb105

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdk010
      CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdk010 = g_detail_d[l_ac].xmdk010,'(', g_rtn_fields[1] , ')'

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdlsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdlsite = g_detail_d[l_ac].xmdlsite,'(', g_rtn_fields[1] , ')'

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdk003
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdk003_s = g_detail_d[l_ac].xmdk003,'(', g_rtn_fields[1] , ')'

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdk004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdk004_s = g_detail_d[l_ac].xmdk003,'(', g_rtn_fields[1] , ')'

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_detail_d[l_ac].xmdk008
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_detail_d[l_ac].xmdk008 = g_detail_d[l_ac].xmdk008,'(', g_rtn_fields[1] , ')'

      #end add-point
      
      CALL axrp134_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp134_sel
   
   LET l_ac = 1
   CALL axrp134_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp134.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp134_fetch()
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
 
{<section id="axrp134.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp134_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp134.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp134_filter()
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
   
   CALL axrp134_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp134.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp134_filter_parser(ps_field)
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
 
{<section id="axrp134.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp134_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp134_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp134.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION axrp134_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003

   IF cl_null(g_xrca_m.xrcasite) OR cl_null(g_xrca_m.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_xrca_m.xrcasite,g_errno
      CALL s_desc_get_department_desc(g_xrca_m.xrcasite) RETURNING g_xrca_m.xrcasite_desc
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      IF l_success THEN
         CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_xrca_m.xrcald,g_xrca_m.xrcacomp,g_errno
         CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
      END IF
       
      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_xrca_m.xrcald   = ''
         LET g_xrca_m.xrcacomp = ''
      END IF
      CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO g_glaa.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161128-00061#3-----modify--end----------
      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
      CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
      CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcacomp,'','') RETURNING l_success,l_ooefl003
      LET g_xrca_m.xrcacomp = g_xrca_m.xrcacomp,'(',l_ooefl003,')'
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,
                      g_xrca_m.xrcald,  g_xrca_m.xrcald_desc,
                      g_xrca_m.xrcacomp
   END IF

   IF cl_null(g_xrca_m.comb1)  THEN LET g_xrca_m.comb1 = '1' END IF
   IF cl_null(g_xrca_m.check1) THEN LET g_xrca_m.check1= 'N' END IF
   DISPLAY BY NAME g_xrca_m.comb1,g_xrca_m.check1

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
PRIVATE FUNCTION axrp134_create_tmp()
   DEFINE r_success         LIKE type_t.chr1

   LET r_success = 'Y'

   DROP TABLE axrp134_xmdk_tmp;        
   CREATE TEMP TABLE axrp134_xmdk_tmp (    
      xmdldocno      VARCHAR(20),
      xmdlseq        INTEGER,
      xmdk0171       DECIMAL(20,10),
      xmdl048        VARCHAR(20),
      xmdl049        VARCHAR(20),
      xrcb007        DECIMAL(20,6),
      xrcb103        DECIMAL(20,6),
      xrcb105        DECIMAL(20,6)
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   RETURN r_success
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
PRIVATE FUNCTION axrp134_s01()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_ooef004         LIKE ooef_t.ooef004
   DEFINE l_oobn003         LIKE oobn_t.oobn003
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_s_fin_3007      LIKE type_t.chr20
   DEFINE l_s_fin_2011      LIKE type_t.chr20
   DEFINE l_s_bas_0012      LIKE type_t.chr20
   DEFINE l_s_bas_0011      LIKE type_t.chr20
   DEFINE l_sql             STRING
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xmdk        RECORD LIKE xmdk_t.*
   #DEFINE l_xmdl        RECORD LIKE xmdl_t.*
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
       xmdk085 LIKE xmdk_t.xmdk085, #資料來源(銷退)
       xmdk086 LIKE xmdk_t.xmdk086, #來源單號(銷退)
       xmdk046 LIKE xmdk_t.xmdk046, #整合來源
       xmdk087 LIKE xmdk_t.xmdk087, #出貨走發票倉調撥
       xmdk047 LIKE xmdk_t.xmdk047, #一次性交易對象識別碼
       xmdk088 LIKE xmdk_t.xmdk088, #來源類型
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
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

   #161128-00061#3-----modify--end----------
   DEFINE l_xmdk001         LIKE xmdk_t.xmdk001
   DEFINE l_xmdk042         LIKE xmdk_t.xmdk042
   DEFINE l_xmdk043         LIKE xmdk_t.xmdk043
   DEFINE l_xmdl001         LIKE xmdl_t.xmdl001
   DEFINE li_idx            LIKE type_t.num5
   #add--2015/05/08 By shiun--(S)
   DEFINE l_success_1       LIKE type_t.num5
   DEFINE l_oofg_return     DYNAMIC ARRAY OF RECORD
                    oofg019     LIKE oofg_t.oofg019,   #field
                    oofg020     LIKE oofg_t.oofg020    #value
                            END RECORD
   #add--2015/05/08 By shiun--(E)
   
   OPEN WINDOW w_axrp134_s01 WITH FORM cl_ap_formpath("axr",'axrp134_s01')

      CALL cl_set_combo_scc("comb1",8325)

      IF g_lang = 'zh_CN' THEN
         #CALL cl_set_comp_att_text('lbl_comb1','红字发票开立')   #160414-00007#1 mark
         CALL cl_set_comp_att_text('lbl_comb1',cl_getmsg("axr-01002",g_dlang))   #160414-00007#1 
      END IF

      LET g_conditions.xrcasite = g_xrca_m.xrcasite
      LET g_conditions.xrcasite_desc = g_xrca_m.xrcasite_desc
      LET g_conditions.xrcald = g_xrca_m.xrcald
      LET g_conditions.xrcald_desc = g_xrca_m.xrcald_desc
      LET g_conditions.xrcacomp = g_xrca_m.xrcacomp
      LET g_conditions.comb1 = g_xrca_m.comb1
      LET g_conditions.comb2 = '0'
      LET g_conditions.check1 = 'Y'
      LET g_conditions.xrcadocdt = NULL
      CALL cl_set_comp_entry('xrcadocdt',FALSE)
      LET g_conditions.check2 = 'Y'
      IF g_conditions.check2 = 'Y' THEN
         LET g_conditions.xrca007 = NULL
         CALL cl_set_comp_entry('xrca007',FALSE)
      ELSE
         CALL cl_set_comp_entry('xrca007',TRUE)
      END IF
      #[帳款單別xrcadocno]是否須走簽流程? (此判別式尚未定,預留)
      LET g_conditions.check3 = 'Y'
      
      LET g_conditions.xrca003 = g_user
      CALL s_axrt300_xrca_ref('xrca003',g_user,'','') RETURNING l_success,g_conditions.xrca003_desc
      DISPLAY BY NAME g_conditions.xrcasite,g_conditions.xrcasite_desc
      DISPLAY BY NAME g_conditions.xrcald,g_conditions.xrcald_desc
      DISPLAY BY NAME g_conditions.xrcacomp,g_conditions.comb1
      DISPLAY BY NAME g_conditions.comb2
      DISPLAY BY NAME g_conditions.xrcadocdt,g_conditions.check1
      DISPLAY BY NAME g_conditions.check2,g_conditions.check3
      DISPLAY BY NAME g_conditions.xrca003,g_conditions.xrca003_desc

      CALL s_aooi200_fin_get_slip(g_detail_d[1].xmdldocno) RETURNING l_success,l_slip
      SELECT ooef004 INTO l_ooef004 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_glaa.glaacomp
      LET l_sql = " SELECT oobn003  FROM oobm_t,oobn_t ",
                  "  WHERE oobment = oobnent ",
                  "    AND oobm001 = oobn001 ",
                  "    AND oobment = '",g_enterprise,"'",
                  "    AND oobm002 = '",l_ooef004,"'",
                  "    AND oobn002 = '",l_slip,"'"
      PREPARE axrp134_oobn_pre FROM l_sql
      DECLARE axrp134_oobn_cur CURSOR FOR axrp134_oobn_pre
      LET l_oobn003 = ''
      LET g_conditions.xrcadocno = ''
      FOREACH axrp134_oobn_cur INTO l_oobn003
         IF NOT cl_null(l_oobn003) THEN
            CALL s_fin_get_doc_para(g_conditions.xrcald,g_glaa.glaacomp,l_oobn003,"S-FIN-2011") RETURNING l_s_fin_2011
            IF cl_null(g_conditions.xrcadocno) THEN
               IF l_s_fin_2011 <> '02' AND g_conditions.comb1 = '1' THEN
                  LET g_conditions.xrcadocno = l_oobn003
               END IF
               
               IF l_s_fin_2011 <> '22' AND g_conditions.comb1 = '2' THEN
                  LET g_conditions.xrcadocno = l_oobn003
               END IF
            END IF
         END IF
         IF NOT cl_null(g_conditions.xrcadocno) THEN
            EXIT FOREACH
         END IF
      END FOREACH
      CALL s_aooi200_fin_get_slip_desc(g_conditions.xrcadocno) RETURNING g_conditions.xrcadocno_desc
      DISPLAY g_conditions.xrcadocno_desc TO xrcadocno_desc

      INPUT BY NAME g_conditions.comb2,g_conditions.xrcadocno,g_conditions.xrca003,
                    g_conditions.check1,g_conditions.check2,g_conditions.check3,g_conditions.xrcadocdt,
                    g_conditions.xrca007,g_conditions.xrca063
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT

         AFTER FIELD xrcadocno
            IF NOT cl_null(g_conditions.xrcadocno) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_glaa.glaa024
               LET g_chkparam.arg2 = g_conditions.xrcadocno
               IF NOT cl_chk_exist("v_oobx001_1") THEN
                  LET g_conditions.xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_get_doc_para(g_conditions.xrcald,g_glaa.glaacomp,g_conditions.xrcadocno,"S-FIN-2011")
                  RETURNING l_s_fin_2011
               IF (g_conditions.comb1 = '1' AND l_s_fin_2011 <> '02') OR (g_conditions.comb1 = '2' AND l_s_fin_2011 <> '22') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00124'
                  LET g_errparam.extend = g_conditions.xrcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_conditions.xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_conditions.xrcadocno) RETURNING g_conditions.xrcadocno_desc
            DISPLAY g_conditions.xrcadocno_desc TO xrcadocno_desc
 
         ON CHANGE check1
            IF NOT cl_null(g_conditions.check1) THEN
               IF g_conditions.check1 = 'Y' THEN
                  LET g_conditions.xrcadocdt = NULL
                  CALL cl_set_comp_entry('xrcadocdt',FALSE)
               ELSE
                  LET g_conditions.xrcadocdt = g_today
                  CALL cl_set_comp_entry('xrcadocdt',TRUE)
               END IF
            END IF
            DISPLAY BY NAME g_conditions.xrcadocdt
 
         AFTER FIELD xrcadocdt
            IF NOT cl_null(g_conditions.xrcadocdt) THEN
               CALL cl_get_para(g_enterprise,'','S-FIN-3007') RETURNING l_s_fin_3007
               IF l_s_fin_3007 > g_conditions.xrcadocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00125'
                  LET g_errparam.extend = g_conditions.xrcadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_conditions.xrcadocdt = g_today
                  NEXT FIELD CURRENT
               END IF
            END IF
 
         ON CHANGE check2
            IF NOT cl_null(g_conditions.check2) THEN
               IF g_conditions.check2 = 'Y' THEN
                  LET g_conditions.xrca007 = NULL
                  LET g_conditions.xrca007_desc = NULL
                  CALL cl_set_comp_entry('xrca007',FALSE)
               ELSE
                  CALL cl_set_comp_entry('xrca007',TRUE)
               END IF
            END IF
            DISPLAY BY NAME g_conditions.xrca007
 
         AFTER FIELD xrca007
            IF NOT cl_null(g_conditions.xrca007) THEN
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_conditions.xrca007
                #160318-00025#42  2016/04/25  by pengxin  add(S)
                LET g_errshow = TRUE #是否開窗 
                LET g_chkparam.err_str[1] = "aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
                #160318-00025#42  2016/04/25  by pengxin  add(E)
                IF NOT cl_chk_exist("v_oocq002_3111") THEN
                   LET g_conditions.xrca007 = ''
                   CALL s_axrt300_xrca_ref('xrca007',g_conditions.xrca007,'','') RETURNING l_success,g_conditions.xrca007_desc
                   NEXT FIELD CURRENT
                END IF
            END IF
 
         ON ACTION controlp INFIELD xrcadocno
 			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
 		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_conditions.xrcadocno      #給予default值
            #給予arg
            SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = "axrt300"
            LET g_qryparam.where = " oobx004 IN ('axrt320','axrt340')"
            CALL q_ooba002_3()                                       #呼叫開窗
            LET g_conditions.xrcadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_aooi200_fin_get_slip_desc(g_conditions.xrcadocno) RETURNING g_conditions.xrcadocno_desc
            DISPLAY g_conditions.xrcadocno TO xrcadocno        #顯示到畫面上
            DISPLAY g_conditions.xrcadocno_desc TO xrcadocno_desc        #顯示到畫面上
            NEXT FIELD xrcadocno                                  #返回原欄位
 
         ON ACTION controlp INFIELD xrca007
 	   		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
 			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_conditions.xrca007           #給予default值
            #給予arg
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                                         #呼叫開窗
            LET g_conditions.xrca007 = g_qryparam.return1            #將開窗取得的值回傳到變數
            CALL s_axrt300_xrca_ref('xrca007',g_conditions.xrca007,'','') RETURNING l_success,g_conditions.xrca007_desc
            DISPLAY g_conditions.xrca007 TO xrca007                  #顯示到畫面上
            DISPLAY g_conditions.xrca007_desc TO xrca007_desc        #顯示到畫面上
            NEXT FIELD xrca007                                       #返回原欄位
 
         ON ACTION controlp INFIELD xrca063
#            CALL s_aooi390('14') RETURNING g_success,g_conditions.xrca063   #mark--2015/05/08 By shiun
            CALL s_aooi390_gen('14') RETURNING l_success_1,g_conditions.xrca063,l_oofg_return   #add--2015/05/08 By shiun
            DISPLAY BY NAME g_conditions.xrca063
            NEXT FIELD xrca063
 
         ON ACTION accept
            ACCEPT INPUT
 
         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT INPUT
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT INPUT
 
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT INPUT

      END INPUT

   CLOSE WINDOW w_axrp134_s01

   IF INT_FLAG = 0 THEN
      CALL axrp134_create_tmp() RETURNING l_success

      FOR li_idx = 1 TO g_detail_d.getLength()
         IF g_detail_d[li_idx].sel = 'N' THEN CONTINUE FOR END IF

      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdk.* 
      SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
             xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,
             xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,
             xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,xmdk035,xmdk036,xmdk037,
             xmdk038,xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,xmdk045,xmdk051,xmdk052,xmdk053,
             xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,
             xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,
             xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,
             xmdkpstdt,xmdkstus,xmdk085,xmdk086,xmdk046,xmdk087,xmdk047,xmdk088,xmdk089 INTO l_xmdk.* 
      #161128-00061#3-----modify--end----------
         FROM xmdk_t WHERE xmdkent = g_enterprise AND xmdkdocno = g_detail_d[li_idx].xmdldocno
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdl.* 
      SELECT xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,
             xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,
             xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,xmdl022,xmdl023,xmdl024,xmdl025,
             xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,
             xmdl036,xmdl037,xmdl038,xmdl039,xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,
             xmdl046,xmdl047,xmdl048,xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,
             xmdl081,xmdl082,xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,
             xmdl091,xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,
             xmdl207,xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,xmdl216,
             xmdl217,xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,xmdl226,xmdlunit,
             xmdlorga,xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057,xmdl058,xmdl096,xmdl059,xmdl060 INTO l_xmdl.*
      #161128-00061#3-----modify--end----------  
         FROM xmdl_t WHERE xmdlent = g_enterprise AND xmdldocno = g_detail_d[li_idx].xmdldocno
         CASE
            WHEN l_xmdk.xmdk043 = '1'   #依訂單日匯率
               IF NOT cl_null(l_xmdl.xmdl003) THEN
                  SELECT xmda016 INTO l_xmdk.xmdk017 FROM xmda_t WHERE xmdadocno = l_xmdl.xmdl003
                     AND xmdaent = g_enterprise #160905-00007#3 add
               END IF
            WHEN l_xmdk.xmdk043 = '2'   #依Invoice日匯率
               SELECT xmdo017 INTO l_xmdk.xmdk017 FROM xmdo_t 
 		          WHERE (xmdo005 = l_xmdl.xmdldocno OR xmdo005 = l_xmdl.xmdl001) AND xmdostus='Y'
            WHEN l_xmdk.xmdk043 = '3'   #依出貨日匯率
               #---
            WHEN l_xmdk.xmdk043 = '4'   #依立帳日匯率
               CALL cl_get_para(g_enterprise,l_xmdl.xmdlsite,'S-BAS-0011') RETURNING l_s_bas_0011
               CALL cl_get_para(g_enterprise,l_xmdl.xmdlsite,'S-BAS-0012') RETURNING l_s_bas_0012
               IF l_xmdk.xmdk042 = '1' THEN LET l_s_bas_0011 = l_s_bas_0012 END IF
               IF g_conditions.check1 = 'Y' THEN
                  CALL s_aooi160_get_exrate('2',g_glaa.glaald,l_xmdk.xmdk001,l_xmdk.xmdk016,g_glaa.glaa001,0,l_s_bas_0011)
                     RETURNING l_xmdk.xmdk017
               ELSE
                  CALL s_aooi160_get_exrate('2',g_glaa.glaald,g_conditions.xrcadocdt,l_xmdk.xmdk016,g_glaa.glaa001,0,l_s_bas_0011)
                     RETURNING l_xmdk.xmdk017
               END IF
            WHEN l_xmdk.xmdk043 = '5'   #依立帳日月平均匯率
               #因為月平均匯率取得方式AOO模組正在開發中
               #所以暫用日平均匯率代替取值
               #By zhangwei 2014/06/04
               CALL cl_get_para(g_enterprise,l_xmdl.xmdlsite,'S-BAS-0011') RETURNING l_s_bas_0011
               CALL cl_get_para(g_enterprise,l_xmdl.xmdlsite,'S-BAS-0012') RETURNING l_s_bas_0012
               IF l_xmdk.xmdk042 = '1' THEN LET l_s_bas_0011 = l_s_bas_0012 END IF
               IF g_conditions.check1 = 'Y' THEN
                  CALL s_aooi160_get_exrate('2',g_glaa.glaald,l_xmdk.xmdk001,l_xmdk.xmdk016,g_glaa.glaa001,0,l_s_bas_0011)
                     RETURNING l_xmdk.xmdk017
               ELSE
                  CALL s_aooi160_get_exrate('2',g_glaa.glaald,g_conditions.xrcadocdt,l_xmdk.xmdk016,g_glaa.glaa001,0,l_s_bas_0011)
                     RETURNING l_xmdk.xmdk017
               END IF 
 
         END CASE
 
         INSERT INTO axrp134_xmdk_tmp(xmdldocno,xmdlseq,xmdk0171,xmdl048,xmdl049,xrcb007,xrcb103,xrcb105)    
            VALUES(l_xmdk.xmdkdocno,l_xmdl.xmdlseq,l_xmdk.xmdk017,l_xmdl.xmdl048,l_xmdl.xmdl049,
                   g_detail_d[li_idx].xrcb007,g_detail_d[li_idx].xrcb103,g_detail_d[li_idx].xrcb105)

      END FOR

      CALL s_axrt300_create_tmp()

      CALL s_transaction_begin()
      CALL axrp134_get_ar()
      CALL s_transaction_end('Y','1')
   ELSE
      LET INT_FLAG = 0
      RETURN
   END IF

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
PRIVATE FUNCTION axrp134_get_ar()
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_orders      STRING
   DEFINE l_order       LIKE type_t.chr200
   DEFINE l_order_t     LIKE type_t.chr200
   DEFINE l_xmdk0001    LIKE type_t.chr200
   DEFINE l_xmdldocno   LIKE xmdl_t.xmdldocno
   DEFINE l_xmdlseq     LIKE xmdl_t.xmdlseq
   DEFINE l_xrcb007     LIKE xrcb_t.xrcb007
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xmdk        RECORD LIKE xmdk_t.*
   #DEFINE l_xmdl        RECORD LIKE xmdl_t.*
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
       xmdk085 LIKE xmdk_t.xmdk085, #資料來源(銷退)
       xmdk086 LIKE xmdk_t.xmdk086, #來源單號(銷退)
       xmdk046 LIKE xmdk_t.xmdk046, #整合來源
       xmdk087 LIKE xmdk_t.xmdk087, #出貨走發票倉調撥
       xmdk047 LIKE xmdk_t.xmdk047, #一次性交易對象識別碼
       xmdk088 LIKE xmdk_t.xmdk088, #來源類型
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
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

   #161128-00061#3-----modify--end----------
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xrca001     LIKE xrca_t.xrca001
   DEFINE l_slip        LIKE xrca_t.xrcadocno
   DEFINE l_xmdk008     LIKE xmdk_t.xmdk008
   DEFINE l_pmaa071     LIKE pmaa_t.pmaa071
   DEFINE l_xmdk016     LIKE xmdk_t.xmdk016
   DEFINE l_xmdk017     LIKE xmdk_t.xmdk017
   DEFINE l_xmdk010     LIKE xmdk_t.xmdk010
   DEFINE l_xmdk012     LIKE xmdk_t.xmdk012
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
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
   DEFINE l_cnt          LIKE type_t.chr1
   DEFINE l_s            LIKE type_t.chr1
   DEFINE l_xrca034      LIKE xrca_t.xrca034
   DEFINE l_xrca035      LIKE xrca_t.xrca035
   DEFINE l_xrca036      LIKE xrca_t.xrca036
   DEFINE l_xrcb005      LIKE xrcb_t.xrcb005
   DEFINE l_xmdksite     LIKE xmdk_t.xmdksite
   DEFINE l_xmdk007      LIKE xmdk_t.xmdk007
   DEFINE l_xmdk003      LIKE xmdk_t.xmdk003
   DEFINE l_xmdl048      LIKE xmdl_t.xmdl048
   DEFINE l_xmdl049      LIKE xmdl_t.xmdl049
   DEFINE l_xrcb103      LIKE xrcb_t.xrcb103
   DEFINE l_xrcb105      LIKE xrcb_t.xrcb105
   DEFINE l_success_1    LIKE type_t.num5

   #STEP1.依照匯總條件將出貨單資料匯總、排序
   #STEP2.將資料插入xrca_t
   #STEP3.將出貨單資料插入xrcb_t、xrcd_t
   #STEP4.将单身金额回写至单头
   #STEP5.產生多帳期資料

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   LET l_str  = "xmdksite||xmdk007||xmdk008||xmdk016||xmdk0171||xmdk010||xmdk012"
   LET l_order= "xmdksite,xmdk007,xmdk008,xmdk016,xmdk0171,xmdk010,xmdk012,xmdldocno,xmdk003,xmdl048,xmdl049"
   CASE
      WHEN g_xrca_m.comb1 = '0'   #銷退單
         LET l_str  = l_str,"||xmdldocno"
      WHEN g_xrca_m.comb1 = '1'   #業務人員
         LET l_str  = l_str,"||xmdk003"
      WHEN g_xrca_m.comb1 = '2'   #發票號碼
         LET l_str  = l_str,"||xmdl048||xmdl049"
   END CASE

   LET l_sql = "SELECT ",l_order,",xmdlseq,xrcb007,xrcb103,xrcb105,",l_str," FROM axrp134_xmdk_tmp,xmdk_t",      
               " WHERE xmdkdocno = xmdldocno                                                         ",
               " ORDER BY ",l_order
   PREPARE axrp134_xmdk_prep FROM l_sql
   DECLARE axrp134_xmdk_curs CURSOR FOR axrp134_xmdk_prep

   FOREACH axrp134_xmdk_curs INTO l_xmdksite,l_xmdk007,l_xmdk008,l_xmdk016,l_xmdk017,l_xmdk010,l_xmdk012,l_xmdldocno,
                                  l_xmdk003, l_xmdl048,l_xmdl049,l_xmdlseq,l_xrcb007,l_xrcb103,l_xrcb105,l_order
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdk.* 
      SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
             xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,
             xmdk016,xmdk017,xmdk018,xmdk019,xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,xmdk025,xmdk026,
             xmdk027,xmdk028,xmdk029,xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,xmdk035,xmdk036,xmdk037,
             xmdk038,xmdk039,xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,xmdk045,xmdk051,xmdk052,xmdk053,
             xmdk054,xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,
             xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,xmdkownid,
             xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,
             xmdkpstdt,xmdkstus,xmdk085,xmdk086,xmdk046,xmdk087,xmdk047,xmdk088,xmdk089 INTO l_xmdk.* 
      #161128-00061#3-----modify--end---------- 
      FROM xmdk_t WHERE xmdkent = g_enterprise AND xmdkdocno = l_xmdldocno
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO l_xmdl.* 
      SELECT xmdlent,xmdlsite,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,
             xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,
             xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,xmdl021,xmdl022,xmdl023,xmdl024,xmdl025,
             xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,xmdl031,xmdl032,xmdl033,xmdl034,xmdl035,
             xmdl036,xmdl037,xmdl038,xmdl039,xmdl040,xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,
             xmdl046,xmdl047,xmdl048,xmdl049,xmdl050,xmdl051,xmdl052,xmdl053,xmdl054,xmdl055,
             xmdl081,xmdl082,xmdl083,xmdl084,xmdl085,xmdl086,xmdl087,xmdl088,xmdl089,xmdl090,
             xmdl091,xmdl092,xmdl093,xmdl200,xmdl201,xmdl202,xmdl203,xmdl204,xmdl205,xmdl206,
             xmdl207,xmdl208,xmdl209,xmdl210,xmdl211,xmdl212,xmdl213,xmdl214,xmdl215,xmdl216,
             xmdl217,xmdl218,xmdl219,xmdl220,xmdl222,xmdl223,xmdl224,xmdl225,xmdl226,xmdlunit,
             xmdlorga,xmdl056,xmdl094,xmdl095,xmdl227,xmdl228,xmdl057,xmdl058,xmdl096,xmdl059,xmdl060 INTO l_xmdl.*
      #161128-00061#3-----modify--end----------   
      FROM xmdl_t WHERE xmdlent = g_enterprise AND xmdldocno = l_xmdldocno AND xmdlseq = l_xmdlseq
      IF g_conditions.check1 = 'Y' THEN LET g_conditions.xrcadocdt = l_xmdk.xmdk001 END IF
      LET l_prog = 'axmt600'
      IF cl_null(l_order_t) OR l_order_t <> l_order THEN
         CALL s_aooi200_fin_gen_docno(g_xrca_m.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_conditions.xrcadocno,g_conditions.xrcadocdt,'axrt340')
            RETURNING l_success,l_xrcadocno
         IF g_conditions.comb1 = '1' THEN LET l_xrca001 = '02' ELSE LET l_xrca001 = '22' END IF

         LET l_cnt = 0 
         SELECT COUNT(*) INTO l_cnt FROM xrcb_t
          WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno 
         IF l_cnt > 0 THEN  
            SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb113),SUM(xrcb114),SUM(xrcb123),SUM(xrcb124),SUM(xrcb133),SUM(xrcb134)  
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
            UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
             WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xrca_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()

            END IF
            CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
            CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
         END IF

         INITIALIZE g_xrca TO NULL

         LET g_xrca.xrcaent   = g_enterprise
         LET g_xrca.xrcaownid = g_user
         LET g_xrca.xrcaowndp = g_dept
         LET g_xrca.xrcacrtid = g_user
         LET g_xrca.xrcacrtdp = g_dept
         LET g_xrca.xrcacrtdt = g_today
         LET g_xrca.xrcastus  = 'N'
         LET g_xrca.xrcacomp  = g_glaa.glaacomp
         LET g_xrca.xrcald    = g_xrca_m.xrcald
         LET g_xrca.xrcadocno = l_xrcadocno
         LET g_xrca.xrcadocdt = g_conditions.xrcadocdt
         LET g_xrca.xrca001   = l_xrca001
         LET g_xrca.xrcasite  = g_xrca_m.xrcasite
         LET g_xrca.xrca003   = g_user
         LET g_xrca.xrca004   = l_xmdk008
         CALL axrp134_xrca004_ref() RETURNING l_xrca.*
         LET g_xrca.xrca005   = l_xrca.xrca005
         LET g_xrca.xrca006   = l_xrca.xrca006
         LET g_xrca.xrca007   = l_xrca.xrca007

         SELECT glab005 INTO l_xrca035 FROM glab_t 
          WHERE glabld = g_xrca_m.xrcald 
            AND glabent = g_enterprise
            AND glab002 = l_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
           AND glab003 = '8304_01'
         
         SELECT glab005 INTO l_xrca036 FROM glab_t 
          WHERE glabld = g_xrca_m.xrcald 
            AND glabent = g_enterprise
            AND glab002 = l_xrca.xrca007   # 帳款類別
            AND glab001 = '13'             # 應收帳務類型科目設定
           AND glab003 = '8304_22'

         SELECT ooeg004 INTO l_xrca034 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015

         LET g_xrca.xrca008   = l_xmdk010
         LET g_xrca.xrca009   = l_xrca.xrca009
         LET g_xrca.xrca010   = l_xrca.xrca010
         LET g_xrca.xrca011   = l_xmdk012
         CALL s_tax_chk(g_xrca.xrcasite,g_xrca.xrca011)
            RETURNING l_success,l_oodbl004,l_xrca.xrca013,l_xrca.xrca012,l_oodb011
         LET g_xrca.xrca012   = l_xrca.xrca012
         LET g_xrca.xrca013   = l_xrca.xrca013
         LET g_xrca.xrca014   = l_xrca.xrca014
         LET g_xrca.xrca015   = l_xrca.xrca015
         LET g_xrca.xrca016   = ''
         LET g_xrca.xrca017   = 0
         LET g_xrca.xrca018   = ''
         LET g_xrca.xrca019   = ''
         LET g_xrca.xrca020   = 'N'
         LET g_xrca.xrca021   = ''
         LET g_xrca.xrca022   = ''
         LET g_xrca.xrca023   = ''
         LET g_xrca.xrca024   = ''
         LET g_xrca.xrca025   = ''
         LET g_xrca.xrca026   = ''
         LET g_xrca.xrca028   = ''
         LET g_xrca.xrca029   = 1
         LET g_xrca.xrca030   = 0
         LET g_xrca.xrca031   = 0
         LET g_xrca.xrca032   = 0
         LET g_xrca.xrca033   = ''
         LET g_xrca.xrca034   = l_xrca034
         LET g_xrca.xrca035   = l_xrca035
         LET g_xrca.xrca036   = l_xrca036
         LET g_xrca.xrca037   = 'N'
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
         LET g_xrca.xrca055   = ''
         LET g_xrca.xrca056   = ''
         LET g_xrca.xrca057   = ''
         LET g_xrca.xrca058   = l_xrca.xrca058
         LET g_xrca.xrca059   = ''
         LET g_xrca.xrca060   = 1
         LET g_xrca.xrca061   = l_xrca.xrca061
         LET g_xrca.xrca062   = '1'
         LET g_xrca.xrca063   = ''
         LET g_xrca.xrca100   = l_xmdk016
         LET g_xrca.xrca101   = l_xmdk017
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
         LET g_xrca.xrca120   = 0
         LET g_xrca.xrca121   = l_xrca.xrca121
         LET g_xrca.xrca123   = 0
         LET g_xrca.xrca124   = 0
         LET g_xrca.xrca126   = 0
         LET g_xrca.xrca127   = 0
         LET g_xrca.xrca128   = 0
         LET g_xrca.xrca130   = 0
         LET g_xrca.xrca131   = l_xrca.xrca131
         LET g_xrca.xrca133   = 0
         LET g_xrca.xrca134   = 0
         LET g_xrca.xrca136   = 0
         LET g_xrca.xrca137   = 0
         LET g_xrca.xrca138   = 0
         
         CALL s_aooi390_get_auto_no('14',g_xrca.xrca063) RETURNING l_success_1,g_xrca.xrca063
         IF NOT l_success THEN
            EXIT FOREACH
         END IF   
         CALL s_aooi390_oofi_upd('14',g_xrca.xrca063) RETURNING l_success_1  #add--2015/05/08 By shiun 增加編碼功能
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

         LET g_xrcb.xrcbseq = 0

      END IF

      SELECT imaal003 INTO l_xrcb005 FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal002 = g_lang
         AND imaal001 = l_xmdl.xmdl008

      LET g_xrcb.xrcbent = g_enterprise
      LET g_xrcb.xrcbld  = g_xrca_m.xrcald
      LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
      LET g_xrcb.xrcbseq = g_xrcb.xrcbseq + 1
      LET g_xrcb.xrcbsite= g_xrca_m.xrcasite
      LET g_xrcb.xrcborga= l_xmdk.xmdksite
      LET g_xrcb.xrcb001 = l_prog
      LET g_xrcb.xrcb002 = l_xmdl.xmdldocno
      LET g_xrcb.xrcb003 = l_xmdl.xmdlseq
      LET g_xrcb.xrcb004 = l_xmdl.xmdl008
      LET g_xrcb.xrcb005 = l_xrcb005
      LET g_xrcb.xrcb006 = l_xmdl.xmdl017
      LET g_xrcb.xrcb007 = l_xrcb007
      LET g_xrcb.xrcb008 = l_xmdl.xmdl003
      LET g_xrcb.xrcb009 = l_xmdl.xmdl004
      LET g_xrcb.xrcblegl= g_xrca.xrcacomp
      LET g_xrcb.xrcb010 = g_xrca.xrca015
      LET g_xrcb.xrcb011 = g_xrca.xrca034
      LET g_xrcb.xrcb012 = ''
      LET g_xrcb.xrcb013 = ''
      LET g_xrcb.xrcb014 = ''
      LET g_xrcb.xrcb015 = ''
      LET g_xrcb.xrcb016 = ''
      LET g_xrcb.xrcb017 = ''
      LET g_xrcb.xrcb018 = ''
      LET g_xrcb.xrcb019 = ''
      LET g_xrcb.xrcb020 = l_xmdl.xmdl025
      LET g_xrcb.xrcb021 = ''
      LET g_xrcb.xrcb022 = -1
      LET g_xrcb.xrcb024 = ''
      LET g_xrcb.xrcb023 = 'N'
      LET g_xrcb.xrcb025 = ''
      LET g_xrcb.xrcb026 = ''
      LET g_xrcb.xrcb027 = ''
      LET g_xrcb.xrcb028 = ''
      LET g_xrcb.xrcb029 = ''
      LET g_xrcb.xrcb030 = 0
      LET g_xrcb.xrcb100 = g_xrca.xrca100
      LET g_xrcb.xrcb101 = l_xmdl.xmdl024
      CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,g_xrcb.xrcb101,g_xrca.xrca101,g_glaa.glaacomp)
         RETURNING l_success,g_xrcb.xrcb111
      CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,g_xrcb.xrcborga,
                     g_xrcb.xrcb007*g_xrcb.xrcb101,g_xrcb.xrcb020,
                     g_xrcb.xrcb007,g_xrcb.xrcb100,g_xrca.xrca101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
         RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                   g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                   g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                   g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
      LET g_xrcb.xrcb106 = 0
      LET g_xrcb.xrcb116 = 0
      LET g_xrcb.xrcb117 = 0
      LET g_xrcb.xrcb118 = g_xrcb.xrcb113
      LET g_xrcb.xrcb119 = g_xrcb.xrcb115
      LET g_xrcb.xrcb126 = 0
      LET g_xrcb.xrcb136 = 0

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

      LET l_order_t = l_order

   END FOREACH

   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM xrcb_t
    WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno 
   IF l_cnt > 0 THEN  
      SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb113),SUM(xrcb114),SUM(xrcb123),SUM(xrcb124),SUM(xrcb133),SUM(xrcb134)  
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
      UPDATE xrca_t SET (xrca103,xrca104,xrca113,xrca114,xrca123,xrca124,xrca133,xrca134) = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca133,g_xrca.xrca134) 
       WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xrca_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()

      END IF
      CALL s_axrt300_installments(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success 
      CALL s_axrt300_xrca_upd(g_xrca.xrcald,g_xrca.xrcadocno) RETURNING l_success
   END IF

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
PRIVATE FUNCTION axrp134_upd_tmp(p_chr)
   DEFINE p_chr       LIKE type_t.chr1
   DEFINE l_sql       STRING


   LET l_sql = "UPDATE axrp134_xmdk_tmp SET flag = '",p_chr,"' WHERE"     

   CASE
      WHEN g_xrca_m.comb1 = '0'
         LET l_sql = l_sql," xmdldocno = '",g_detail_d[l_ac].xmdldocno,"'"
      WHEN g_xrca_m.comb1 = '1'
         IF cl_null(g_detail_d[l_ac].xmdl003) THEN LET g_detail_d[l_ac].xmdl003 = ' ' END IF
         LET l_sql = l_sql," xmdl003   = '",g_detail_d[l_ac].xmdl003  ,"'"
      WHEN g_xrca_m.comb1 = '2'
         IF cl_null(g_detail_d[l_ac].xmdk003) THEN LET g_detail_d[l_ac].xmdk003 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl017) THEN LET g_detail_d[l_ac].xmdl017 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl021) THEN LET g_detail_d[l_ac].xmdl021 = ' ' END IF
         LET l_sql = l_sql," xmdk003   = '",g_detail_d[l_ac].xmdk003  ,"'",
                       " AND xmdl017   = '",g_detail_d[l_ac].xmdl017  ,"'",
                       " AND xmdl021   = '",g_detail_d[l_ac].xmdl021  ,"'"
      WHEN g_xrca_m.comb1 = '3'
         IF cl_null(g_detail_d[l_ac].xmdk004) THEN LET g_detail_d[l_ac].xmdk004 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl017) THEN LET g_detail_d[l_ac].xmdl017 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl021) THEN LET g_detail_d[l_ac].xmdl021 = ' ' END IF
         LET l_sql = l_sql," xmdk004   = '",g_detail_d[l_ac].xmdk004  ,"'",
                       " AND xmdl017   = '",g_detail_d[l_ac].xmdl017  ,"'",
                       " AND xmdl021   = '",g_detail_d[l_ac].xmdl021  ,"'"
      WHEN g_xrca_m.comb1 = '4'
         IF cl_null(g_detail_d[l_ac].xmdl048_1) THEN LET g_detail_d[l_ac].xmdl048_1 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl049_1) THEN LET g_detail_d[l_ac].xmdl049_1 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl017) THEN LET g_detail_d[l_ac].xmdl017 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl021) THEN LET g_detail_d[l_ac].xmdl021 = ' ' END IF
         LET l_sql = l_sql," xmdl048   = '",g_detail_d[l_ac].xmdl048_1,"'",
                       " AND xmdl049   = '",g_detail_d[l_ac].xmdl049_1,"'",
                       " AND xmdl017   = '",g_detail_d[l_ac].xmdl017  ,"'",
                       " AND xmdl021   = '",g_detail_d[l_ac].xmdl021  ,"'"
      WHEN g_xrca_m.comb1 = '5'
         IF cl_null(g_detail_d[l_ac].xmdl008) THEN LET g_detail_d[l_ac].xmdl008 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl017) THEN LET g_detail_d[l_ac].xmdl017 = ' ' END IF
         IF cl_null(g_detail_d[l_ac].xmdl021) THEN LET g_detail_d[l_ac].xmdl021 = ' ' END IF
         LET l_sql = l_sql," xmdl008   = '",g_detail_d[l_ac].xmdl008  ,"'",
                       " AND xmdl017   = '",g_detail_d[l_ac].xmdl017  ,"'",
                       " AND xmdl021   = '",g_detail_d[l_ac].xmdl021  ,"'"
   END CASE

   PREPARE axrp134_upd_tmp FROM l_sql
   EXECUTE axrp134_upd_tmp

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
PRIVATE FUNCTION axrp134_xrca004_ref()
DEFINE l_site         LIKE xrca_t.xrcasite
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmab085      LIKE pmab_t.pmab085
DEFINE l_oodbl004     LIKE oodbl_t.oodbl004
DEFINE l_oodb011      LIKE oodb_t.oodb011
#161128-00061#3-----modify--begin----------
#DEFINE l_ooib         RECORD LIKE ooib_t.*
DEFINE l_ooib RECORD  #收付款條件主檔
       ooibent LIKE ooib_t.ooibent, #企業編號
       ooibownid LIKE ooib_t.ooibownid, #資料所有者
       ooibowndp LIKE ooib_t.ooibowndp, #資料所屬部門
       ooibcrtid LIKE ooib_t.ooibcrtid, #資料建立者
       ooibcrtdp LIKE ooib_t.ooibcrtdp, #資料建立部門
       ooibcrtdt LIKE ooib_t.ooibcrtdt, #資料創建日
       ooibmodid LIKE ooib_t.ooibmodid, #資料修改者
       ooibmoddt LIKE ooib_t.ooibmoddt, #最近修改日
       ooibstus LIKE ooib_t.ooibstus, #狀態碼
       ooib001 LIKE ooib_t.ooib001, #收款/付款
       ooib002 LIKE ooib_t.ooib002, #收付款條件編號
       ooib004 LIKE ooib_t.ooib004, #款別性質
       ooib005 LIKE ooib_t.ooib005, #慣用繳款優惠條件
       ooib006 LIKE ooib_t.ooib006, #訂金收取否
       ooib007 LIKE ooib_t.ooib007, #現付交易否
       ooib011 LIKE ooib_t.ooib011, #應收付款起算基準
       ooib012 LIKE ooib_t.ooib012, #應收付款日加(季)
       ooib013 LIKE ooib_t.ooib013, #應收付款日加(月)
       ooib014 LIKE ooib_t.ooib014, #應收付款日加(日)
       ooib021 LIKE ooib_t.ooib021, #帳款兌現起算基準
       ooib022 LIKE ooib_t.ooib022, #帳款兌現日加(季)
       ooib023 LIKE ooib_t.ooib023, #帳款兌現日加(月)
       ooib024 LIKE ooib_t.ooib024, #帳款兌現日加(日)
       ooib025 LIKE ooib_t.ooib025, #慣用多帳期類型　
       ooib026 LIKE ooib_t.ooib026  #尾款性質
       END RECORD
#161128-00061#3-----modify--end----------
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
DEFINE ls_js         STRING
DEFINE lc_param      RECORD
         apca004     LIKE apca_t.apca004
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
   
#   #STEP2.帶出主要應收條件
#   SELECT pmab087 INTO r_xrca.xrca008 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004   
#   IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab087 INTO r_xrca.xrca008 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   
   #應收日期/票據到期日
   #161128-00061#3-----modify--begin----------
   #SELECT * INTO l_ooib.* 
    SELECT ooibent,ooibownid,ooibowndp,ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt,ooibstus,
           ooib001,ooib002,ooib004,ooib005,ooib006,ooib007,ooib011,ooib012,ooib013,ooib014,ooib021,
           ooib022,ooib023,ooib024,ooib025,ooib026 INTO l_ooib.* 
   #161128-00061#3-----modify--end----------
   FROM ooib_t WHERE ooibent = g_enterprise AND ooib001 = '2' AND ooib002 = r_xrca.xrca008
   CALL s_fin_date_ap_payable(g_xrca.xrcasite,g_xrca.xrca004,r_xrca.xrca008,g_xrca.xrcadocdt,
     g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') RETURNING l_success,r_xrca.xrca009,r_xrca.xrca010
   
#   #STEP3.帳款類別
#   SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004 
#   IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab105 INTO r_xrca.xrca007 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   #若取不到時依單別參數S-FIN-2011 取得預設帳款類別
   IF cl_null(r_xrca.xrca007) THEN 
      CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'S-FIN-2011') RETURNING r_xrca.xrca007
   END IF
   
#   #STEP4.業務人員/業務部門
#   SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004 
#   IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab081 INTO r_xrca.xrca014 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   SELECT ooag003 INTO r_xrca.xrca015 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = r_xrca.xrca014
   
   #STEP5.稅別/含稅否/稅率
   SELECT isak002 INTO r_xrca.xrca011 FROM isak_t
    WHERE isakent = g_enterprise AND isaksite = l_site AND isak001 = g_xrca.xrca004   
   CALL s_tax_chk(g_xrca.xrcasite,r_xrca.xrca011) RETURNING l_success,l_oodbl004,r_xrca.xrca013,r_xrca.xrca012,l_oodb011
   
#   #STEP6.慣用幣別/匯率
#   SELECT pmab083 INTO r_xrca.xrca100 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004 
#   IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab083 INTO r_xrca.xrca100 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   #計算各個本位筆匯率
   IF NOT cl_null(r_xrca.xrca100) THEN 
     #150518-00044#5--Mark
     #CALL s_axrt300_get_exrate(g_xrca.xrcadocdt,g_xrca.xrcald,g_xrca.xrcacomp,r_xrca.xrca100)
     #   RETURNING l_success,r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
     #150518-00044#5--Mark
     #150518-00044#5--(S)
      LET lc_param.apca004 = g_xrca.xrca004
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocdt,r_xrca.xrca100,ls_js)
           RETURNING r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
     #150518-00044#5--(E)
   END IF
   
#   #STEP7.預開發票日
#   SELECT pmab085 INTO l_pmab085 FROM pmab_t
#    WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004 
#   IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab083 INTO l_pmab085 FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
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
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004  #160505-00005#1# l_site--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmab090 INTO r_xrca.xrca006 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# l_site--->l_xrcacomp

   RETURN r_xrca.*

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp134_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/12/08 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp134_get_ooef001_wc(p_wc)
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

#end add-point
 
{</section>}
 
