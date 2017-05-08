#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-09-17 09:46:11), PR版次:0011(2016-12-01 10:40:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000293
#+ Filename...: axrp120
#+ Description: 門店日結批次產生帳款作業
#+ Creator....: 01727(2014-05-22 14:28:52)
#+ Modifier...: 02003 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp120.global" >}
#應用 p02 樣板自動產生(Version:20)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#51     2016/03/29    by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160505-00005#1      2016/05/06    By 01531    取法人據點之交易對象檔,若取不到法人據點時, 取 據點代碼='ALL'
#160905-00007#3      2016/09/05    By zhujing  调整系统中无ENT的SQL条件增加ent
#161128-00061#3      2016/12/01    by 02481    标准程式定义采用宣告模式,弃用.*写法

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
       sel                 LIKE type_t.chr1,
       debz002             LIKE debz_t.debz002,
       debzsite            LIKE debz_t.debzsite,
       debzsite_desc       LIKE ooefl_t.ooefl003,
       debz013             LIKE debz_t.debz013,
       debz012             LIKE debz_t.debz012,
       deby004             LIKE deby_t.deby004,
       debz015             LIKE debz_t.debz015,
       debz005             LIKE debz_t.debz005,
       debz006             LIKE debz_t.debz006,
       debz003             LIKE debz_t.debz003,
       debz004             LIKE debz_t.debz004
                        END RECORD

DEFINE g_detail_idx1    LIKE type_t.num5             
DEFINE g_wc2_table1     STRING
DEFINE l_ac1            LIKE type_t.num5
DEFINE g_rec_b1         LIKE type_t.num5              #單身筆數

TYPE type_g_deby_d      RECORD
       deby001             LIKE deby_t.deby001,
       deby002             LIKE deby_t.deby002,
       deby002_desc        LIKE ooial_t.ooial003,
       deby004             LIKE deby_t.deby004,       
       ooie004             LIKE ooie_t.ooie004,
       ooie004_desc        LIKE ooefl_t.ooefl003,       
       ooie010             LIKE ooie_t.ooie010, 
       deby005             LIKE deby_t.deby005,
       deby006             LIKE deby_t.deby006,
       deby007             LIKE deby_t.deby007,
       deby008             LIKE deby_t.deby008,
       deby008_desc        LIKE nmabl_t.nmabl003,
       deby009             LIKE deby_t.deby009,
       deby010             LIKE deby_t.deby010,
       deby011             LIKE deby_t.deby011,
       deby012             LIKE deby_t.deby012,
       deby013             LIKE deby_t.deby013,
       deby014             LIKE deby_t.deby014,
       deby015             LIKE deby_t.deby015
                        END RECORD
DEFINE g_deby_d         DYNAMIC ARRAY OF type_g_deby_d

TYPE type_g_debz_d      RECORD
       debz005             LIKE debz_t.debz005,
       debz005_desc        LIKE ooefl_t.ooefl003,
       debz007             LIKE debz_t.debz007,
       debz007_desc        LIKE rtaxl_t.rtaxl003,
       debz010             LIKE debz_t.debz010,
       debz011             LIKE debz_t.debz011,
       debz013             LIKE debz_t.debz013,
       debz008             LIKE debz_t.debz008,
       debz008_desc        LIKE oodbl_t.oodbl004,
       debz009             LIKE debz_t.debz009,
       debz014             LIKE debz_t.debz014,
       debz014_desc        LIKE inaa_t.inaa002
                        END RECORD
DEFINE g_debz_d         DYNAMIC ARRAY OF type_g_debz_d

TYPE type_g_xrca_m      RECORD
          xrcald           LIKE xrca_t.xrcald,
          xrcald_desc      LIKE glaal_t.glaal002,
          xrcasite         LIKE xrca_t.xrcasite,
          xrcasite_desc    LIKE ooefl_t.ooefl003,
          xrcacomp         LIKE xrca_t.xrcacomp,
          xrcacomp_desc    LIKE ooefl_t.ooefl003,
          lbl_ra1          LIKE type_t.chr1
                        END RECORD

#模組變數(Module Variables)
DEFINE g_xrca_m         type_g_xrca_m
DEFINE g_xrca_m_t       type_g_xrca_m                #備份舊值
                        
DEFINE g_glaa013        LIKE glaa_t.glaa013
DEFINE g_rec_b2         LIKE type_t.num5              #單身筆數
DEFINE g_rec_b3         LIKE type_t.num5              #單身筆數
                        
DEFINE g_conditions     RECORD
          xrcadocno        LIKE xrca_t.xrcadocno, 
          xrca063          LIKE xrca_t.xrca063, 
          a1               LIKE type_t.chr80, 
          a2               LIKE type_t.chr80, 
          xrcadocdt        LIKE xrca_t.xrcadocdt
                        END RECORD
#161128-00061#3-----modify--begin----------                        
#DEFINE g_xrca           RECORD LIKE xrca_t.*
#DEFINE g_xrcb           RECORD LIKE xrcb_t.*
#DEFINE g_xrce           RECORD LIKE xrce_t.*
#DEFINE g_glaa           RECORD LIKE glaa_t.*
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
DEFINE g_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
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

#end add-point
 
{</section>}
 
{<section id="axrp120.main" >}
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
      OPEN WINDOW w_axrp120 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp120_init()   
 
      #進入選單 Menu (="N")
      CALL axrp120_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp120
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp120.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp120_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("deby001",8310)
 # CALL axrp120_default_search()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp120_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_flag   LIKE type_t.chr1
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET l_flag = 'N'
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp120_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
        INPUT BY NAME g_xrca_m.xrcald,g_xrca_m.xrcasite,g_xrca_m.lbl_ra1
        
           BEFORE INPUT
              LET g_xrca_m.lbl_ra1 = '1'
              DISPLAY BY NAME g_xrca_m.lbl_ra1
          
           AFTER FIELD xrcald
        
              IF NOT cl_null(g_xrca_m.xrcald) THEN 
                 IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN 
                    LET g_xrca_m.xrcald = ''
                    NEXT FIELD CURRENT
                 END IF 
#                 IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',1) THEN  #160318-00005#51  mark
                 IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN   #160318-00005#51  add
                    LET g_xrca_m.xrcald = ''
                    NEXT FIELD CURRENT
                 END IF 
                 IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND (glaa014 = 'Y' OR glaa008 = 'Y') AND glaastus = 'Y' ",'axr-00021',1) THEN 
                    LET g_xrca_m.xrcald = ''
                    NEXT FIELD CURRENT
                 END IF 
                 IF NOT s_ld_chk_authorization(g_user,g_xrca_m.xrcald) THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'axr-00022'
                    LET g_errparam.extend = g_xrca_m.xrcald
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    LET g_xrca_m.xrcald = ''
                    NEXT FIELD CURRENT
                 END IF
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = g_xrca_m.xrcald
                 CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_xrca_m.xrcald_desc = '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_xrca_m.xrcald_desc
                 SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald  = g_xrca_m.xrcald
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = g_xrca_m.xrcacomp
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_xrca_m.xrcacomp_desc = '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 DISPLAY BY NAME g_xrca_m.xrcacomp_desc
              END IF
             
           AFTER FIELD xrcasite
              IF NOT cl_null(g_xrca_m.xrcasite) THEN
#                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ?   ",'aap-00002',0) THEN  #160318-00005#51  mark
                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ?   ",'sub-01302','aapi010') THEN     #160318-00005#51  add
                    LET g_xrca_m.xrcasite = g_xrca_m_t.xrcasite
                    NEXT FIELD CURRENT
                 END IF
                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1'  ",'aap-00005',0) THEN
                    LET g_xrca_m.xrcasite = g_xrca_m_t.xrcasite
                    NEXT FIELD CURRENT
                 END IF
#                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrahstus = 'Y' ",'aap-00004',0) THEN   #160318-00005#51  mark
                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrahstus = 'Y' ",'sub-01302','aapi020') THEN   #160318-00005#51  add
                    LET g_xrca_m.xrcasite = g_xrca_m_t.xrcasite
                    NEXT FIELD CURRENT
                 END IF
                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' ",'aap-00007',0) THEN
                    LET g_xrca_m.xrcasite = g_xrca_m_t.xrcasite
                    NEXT FIELD CURRENT
                 END IF 
                 IF NOT ap_chk_isExist(g_xrca_m.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' AND xrah004 = (SELECT ooag004 FROM ooag_t WHERE ooagent = '"||g_enterprise||"' AND ooag001 ='"||g_user||"')",'aap-00006',0) THEN
                    LET g_xrca_m.xrcasite = g_xrca_m_t.xrcasite
                    NEXT FIELD CURRENT
                 END IF
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = g_xrca_m.xrcasite
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_xrca_m.xrcasite_desc = '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_xrca_m.xrcasite_desc
              END IF
        
           ON ACTION controlp INFIELD xrcald
            	    INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
            	    LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xrca_m.xrcald      #給予default值
              LET g_qryparam.arg1 = g_user
              LET g_qryparam.arg2 = g_dept
              CALL  q_authorised_ld()                                  #呼叫開窗
              LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
              DISPLAY g_xrca_m.xrcald TO xrcald              #顯示到畫面上
              INITIALIZE g_ref_fields TO NULL
              LET g_ref_fields[1] = g_xrca_m.xrcald
              CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
              LET g_xrca_m.xrcald_desc = '', g_rtn_fields[1] , ''
              SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t
               WHERE glaaent = g_enterprise
                 AND glaald  = g_xrca_m.xrcald
              INITIALIZE g_ref_fields TO NULL
              LET g_ref_fields[1] = g_xrca_m.xrcacomp
              CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
              LET g_xrca_m.xrcacomp_desc = '', g_rtn_fields[1] , ''
              DISPLAY BY NAME g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp
              DISPLAY BY NAME g_xrca_m.xrcacomp_desc
              NEXT FIELD xrcald                              #返回原欄位  
        
           ON ACTION controlp INFIELD xrcasite
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
	           LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "

            #給予arg

            CALL q_ooef001()                                #呼叫開窗
              LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
              DISPLAY g_xrca_m.xrcasite TO xrcasite              #顯示到畫面上
              INITIALIZE g_ref_fields TO NULL
              LET g_ref_fields[1] = g_xrca_m.xrcasite
              CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
              LET g_xrca_m.xrcasite_desc = '', g_rtn_fields[1] , ''
              DISPLAY BY NAME g_xrca_m.xrcasite_desc
        
              NEXT FIELD xrcasite                          #返回原欄位
              
           AFTER INPUT
              SELECT glaa013 INTO g_glaa013  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              CALL axrp120_b_fill()
              LET l_flag = 'N'
              FOR li_idx = 1 TO g_detail_d.getLength()
                 IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 THEN
                    LET l_flag = 'Y'
                    EXIT FOR
                 END IF
              END FOR
              
        END INPUT 
        
        #螢幕上取條件
         CONSTRUCT BY NAME g_wc ON debz002,debzsite,debz005_t,debz006
           
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
        
            ON ACTION controlp INFIELD debzsite   #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site 
               LET g_qryparam.arg2 = '2'           
               CALL q_ooed004_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO debzsite  #顯示到畫面上
            
               NEXT FIELD debzsite                     #返回原欄位
        
            AFTER CONSTRUCT
               LET g_wc = cl_replace_str(g_wc,'dezb005_t','debz005')
               CALL axrp120_b_fill()
               LET l_flag = 'N'
               FOR li_idx = 1 TO g_detail_d.getLength()
                  IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 THEN
                     LET l_flag = 'Y'
                     EXIT FOR
                  END IF
               END FOR
        
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b1) #page1  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL axrp120_b_fill1(" deby003 = '"||g_detail_d[l_ac].debz002||"' AND debysite = '"||g_detail_d[l_ac].debzsite||"'")
               CALL axrp120_b_fill2(" debz002 = '"||g_detail_d[l_ac].debz002||"' AND debzsite = '"||g_detail_d[l_ac].debzsite||"'")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
         END DISPLAY
        
         DISPLAY ARRAY g_deby_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
         
         END DISPLAY
 
         DISPLAY ARRAY g_debz_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page3  
 
         END DISPLAY
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 THEN
                  LET l_flag = 'Y'
                  EXIT FOR
               END IF
            END FOR
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
            LET l_flag = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 THEN
               LET l_flag = 'Y'
            END IF
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
               IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 AND g_detail_d[li_idx].sel = "Y" THEN
                  LET l_flag = 'Y'
                  EXIT FOR
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp120_filter()
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
            CALL axrp120_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_xrca_m.* TO NULL
            LET g_xrca_m.lbl_ra1 = '1'
            DISPLAY BY NAME g_xrca_m.lbl_ra1
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp120_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         #整批審核立帳
         ON ACTION axrp120_02
            LET g_action_choice="axrp120_02"
            IF cl_auth_chk_act("axrp120_02") THEN
                IF NOT cl_null(g_xrca_m.xrcald) AND l_flag = 'Y' THEN
                   INITIALIZE g_conditions.* TO NULL
                   CALL axrp120_02(g_xrca_m.xrcald)
                      RETURNING g_conditions.xrcadocno,g_conditions.xrca063,g_conditions.a1,
                                g_conditions.a2,       g_conditions.xrcadocdt
                   CALL axrp120_doc()
                END IF
                CONTINUE DIALOG
            END IF

         #雙擊資料
         ON ACTION modify_detail
            IF l_ac > 0 THEN 
               IF g_detail_d[l_ac].sel = "N" THEN
                  LET g_detail_d[l_ac].sel = "Y"
               ELSE
                  LET g_detail_d[l_ac].sel = "N"
               END IF
               FOR li_idx = 1 TO g_detail_d.getLength()
                  IF g_detail_d[li_idx].debz012 = g_detail_d[li_idx].deby004 AND g_detail_d[li_idx].sel = "Y" THEN
                     LET l_flag = 'Y'
                     EXIT FOR
                  END IF
               END FOR
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
 
{<section id="axrp120.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp120_query()
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
   CALL axrp120_b_fill()
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
 
{<section id="axrp120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp120_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_s             LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_debz013       LIKE debz_t.debz013
   DEFINE l_str           STRING                #add by yangxf 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   IF g_xrca_m.lbl_ra1 = '1' THEN
      CASE
         WHEN l_s = '1'
            LET ls_wc = "HAVING SUM (debz015) < SUM(debz013)"
         WHEN l_s = '2'
            LET ls_wc = "HAVING SUM (debz016) < SUM(debz013)"
         WHEN l_s = '3'
            LET ls_wc = "HAVING SUM (debz017) < SUM(debz013)"
      END CASE
   ELSE
      CASE
         WHEN l_s = '1'
            LET ls_wc = "HAVING SUM (debz015) > 0"
         WHEN l_s = '2'
            LET ls_wc = "HAVING SUM (debz016) > 0"
         WHEN l_s = '3'
            LET ls_wc = "HAVING SUM (debz017) > 0"
      END CASE
   END IF

   LET g_sql = "  SELECT 'N',debz002,debzsite,'',                                                                     ",
               "         CASE WHEN SUM (debz013) IS NULL THEN 0 ELSE SUM (debz013) END,                               ",
               "         CASE WHEN SUM (debz012) IS NULL THEN 0 ELSE SUM (debz012) END,0,                             ",
               "         CASE WHEN '",l_s,"' = '1' THEN CASE WHEN SUM (debz015) IS NULL THEN 0 ELSE SUM (debz015) END ",
               "              WHEN '",l_s,"' = '2' THEN CASE WHEN SUM (debz016) IS NULL THEN 0 ELSE SUM (debz016) END ",
               "              WHEN '",l_s,"' = '3' THEN CASE WHEN SUM (debz017) IS NULL THEN 0 ELSE SUM (debz017) END ",
               "         END,debz005,debz006,debz003,debz004                                                          ",
               "    FROM debz_t WHERE debzsite IN                                                                     ",
               "                                (SELECT xrah004 FROM xrah_t                                           ",
               "                                  WHERE     xrahent = ?                                               ",
               "                                        AND xrah001 = '1'                                             ",
               "                                        AND xrah002 = '",g_xrca_m.xrcasite,"'                         ",
               "                                        AND xrah007 = 'Y')                                            ",
               "         AND ",g_wc,
               " GROUP BY debz002,debzsite,debz005,debz006,debz003,debz004 ",ls_wc
   #end add-point
 
   PREPARE axrp120_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp120_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*,l_debz013
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
      SELECT SUM(deby004) INTO g_detail_d[l_ac].deby004 FROM deby_t WHERE debysite = g_detail_d[l_ac].debzsite AND deby003 = g_detail_d[l_ac].debz002
         AND debyent = g_enterprise #160905-00007#3 add
      IF cl_null(g_detail_d[l_ac].deby004) THEN LET g_detail_d[l_ac].deby004 = 0 END IF

      IF g_detail_d[l_ac].deby004 = g_detail_d[l_ac].debz012 THEN
         LET g_detail_d[l_ac].sel = 'Y'
      END IF

      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_detail_d[l_ac].debzsite
      CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '"||g_enterprise||"' AND ooefl001 = ? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_detail_d[l_ac].debzsite_desc = g_rtn_fields[1] 
      #end add-point
      
      CALL axrp120_detail_show()      
 
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
   FREE axrp120_sel
   
   LET l_ac = 1
   CALL axrp120_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   LET l_str = " deby003 = '"||g_detail_d[1].debz002||"' AND debysite = '"||g_detail_d[1].debzsite||"'"
   CALL axrp120_b_fill1(l_str)
   LET l_str = " debz002 = '"||g_detail_d[1].debz002||"' AND debzsite = '"||g_detail_d[1].debzsite||"'"
   CALL axrp120_b_fill2(l_str)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp120.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp120_fetch()
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
 
{<section id="axrp120.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp120_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp120.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp120_filter()
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
   
   CALL axrp120_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp120.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp120_filter_parser(ps_field)
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
 
{<section id="axrp120.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp120_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp120_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp120.other_function" readonly="Y" >}
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
PRIVATE FUNCTION axrp120_b_fill1(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_ac      LIKE type_t.num5

   CALL g_deby_d.clear()

   LET l_sql = "SELECT deby001,deby002,'',deby004,'','','',deby005,deby006,deby007,deby008,'',deby009,deby010,deby011,deby012,deby013,deby014,deby015",
               "  FROM deby_t ",
               " WHERE ",p_wc
   PREPARE axrp120_pre1 FROM l_sql
   DECLARE axrp120_cur1 CURSOR FOR axrp120_pre1

   LET l_ac = 1
   FOREACH axrp120_cur1 INTO g_deby_d[l_ac].*
     
      CALL axrp120_ooie_desc()
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_deby_d[l_ac].deby002
      CALL ap_ref_array2(g_ref_fields," SELECT ooial003 FROM ooial_t WHERE ooialent = '"||g_enterprise||"' AND ooial001 = ? AND ooial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_deby_d[l_ac].deby002_desc = g_rtn_fields[1] 

      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_deby_d[l_ac].ooie004
      CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '"||g_enterprise||"' AND ooefl001 = ? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_deby_d[l_ac].ooie004_desc = g_rtn_fields[1] 

      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_deby_d[l_ac].deby008
      CALL ap_ref_array2(g_ref_fields," SELECT nmabl003 FROM nmabl_t WHERE nmablent = '"||g_enterprise||"' AND nmabl001 = ? AND nmabl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_deby_d[l_ac].deby008_desc = g_rtn_fields[1] 

      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_deby_d.deleteElement(l_ac)

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
PRIVATE FUNCTION axrp120_b_fill2(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_ac      LIKE type_t.num5

   CALL g_debz_d.clear()

   LET l_sql = "SELECT debz005,'',debz007,debz010,debz011,debz013,debz008,'',debz009,debz014,'' FROM debz_t",
               " WHERE ",p_wc
   PREPARE axrp120_pre2 FROM l_sql
   DECLARE axrp120_cur2 CURSOR FOR axrp120_pre2

   LET l_ac = 1
   FOREACH axrp120_cur2 INTO g_debz_d[l_ac].*
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_debz_d[l_ac].debz007
      CALL ap_ref_array2(g_ref_fields," SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = '"||g_enterprise||"' AND rtaxl001 = ? AND rtaxl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_debz_d[l_ac].debz007_desc = g_rtn_fields[1] 

      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_debz_d[l_ac].debz008
      CALL ap_ref_array2(g_ref_fields," SELECT DISTINCT oodbl004 FROM oodbl_t WHERE oodblent = '"||g_enterprise||"' AND oodbl002 = ? AND oodbl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_debz_d[l_ac].debz008_desc = g_rtn_fields[1] 
   
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_debz_d[l_ac].debz014
      CALL ap_ref_array2(g_ref_fields," SELECT DISTINCT inaa002 FROM inaa_t WHERE inaaent = '"||g_enterprise||"' AND inaa001 = ? ","") RETURNING g_rtn_fields 
      LET g_debz_d[l_ac].debz014_desc = g_rtn_fields[1] 

      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_debz_d.deleteElement(l_ac)
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
PRIVATE FUNCTION axrp120_create_tmp()
   DEFINE r_success         LIKE type_t.chr1

   LET r_success = 'Y'

   DROP TABLE axrp120_debz_tmp;                          
   CREATE TEMP TABLE axrp120_debz_tmp (                   
      debzent          LIKE debz_t.debzent,
      debzsite         LIKE debz_t.debzsite,
      debz002          LIKE debz_t.debz002,
      debz001          LIKE debz_t.debz001,
      debz003          LIKE debz_t.debz003,
      debz004          LIKE debz_t.debz004,
      debz005          LIKE debz_t.debz005,
      debz006          LIKE debz_t.debz006,
      debz007          LIKE debz_t.debz007,
      debz008          LIKE debz_t.debz008,
      debz009          LIKE debz_t.debz009,
      debz010          LIKE debz_t.debz010,
      debz011          LIKE debz_t.debz011,
      debz012          LIKE debz_t.debz012,
      debz013          LIKE debz_t.debz013,
      debz014          LIKE debz_t.debz014,
      debz015          LIKE debz_t.debz015,
      debz016          LIKE debz_t.debz016,
      debz017          LIKE debz_t.debz017
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DROP TABLE axrp120_deby_tmp;                 
   CREATE TEMP TABLE axrp120_deby_tmp (         
      debyent	         LIKE deby_t.debyent,
      debysite          LIKE deby_t.debysite,
      deby001	         LIKE deby_t.deby001,
      deby002	         LIKE deby_t.deby002,
      deby003	         LIKE deby_t.deby003,
      deby004	         LIKE deby_t.deby004,
      deby005	         LIKE deby_t.deby005,
      deby006	         LIKE deby_t.deby006,
      deby007	         LIKE deby_t.deby007,
      deby008	         LIKE deby_t.deby008,
      deby009	         LIKE deby_t.deby009,
      deby010	         LIKE deby_t.deby010,
      deby011	         LIKE deby_t.deby011,
      deby012	         LIKE deby_t.deby012,
      deby013	         LIKE deby_t.deby013,
      deby014	         LIKE deby_t.deby014,
      deby015	         LIKE deby_t.deby015,
      deby016	         LIKE deby_t.deby016,
      deby017	         LIKE deby_t.deby017,
      deby018	         LIKE deby_t.deby018
      
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
PRIVATE FUNCTION axrp120_xrca004_ref()
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
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   #若取不到時依單別參數S-FIN-2011 取得預設帳款類別
   IF cl_null(r_xrca.xrca007) THEN 
      CALL s_aooi200_fin_get_slip(g_conditions.xrcadocno) RETURNING l_success,l_ooba002
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
       WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# g_xrca.xrcacomp--->l_xrcacomp
#   END IF
   #計算各個本位筆匯率
   IF NOT cl_null(r_xrca.xrca100) THEN 
      CALL s_axrt300_get_exrate(g_xrca.xrcadocdt,g_xrca.xrcald,g_xrca.xrcacomp,r_xrca.xrca100)
         RETURNING l_success,r_xrca.xrca101,r_xrca.xrca121,r_xrca.xrca131
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
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# l_site--->l_xrcacomp
   
   #SETP11.客戶分類
   SELECT pmab090 INTO r_xrca.xrca006 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = l_xrcacomp AND pmab001 = g_xrca.xrca004 #160505-00005#1# l_site--->l_xrcacomp

   RETURN r_xrca.*

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
PRIVATE FUNCTION axrp120_doc()
   DEFINE l_sql         STRING
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_debzsite    LIKE debz_t.debzsite
   DEFINE l_debz002     LIKE debz_t.debz002
   DEFINE l_cnt         LIKE type_t.num5

   #STEP1:確定需要匯入的資料範圍
   #STEP2:將資料匯入表中
   #   1):匯入應收單頭檔(xrca_t)
   #   2):匯入稅別明細檔(xrcd_t)
   #   3):匯入應收單身檔(xrcb_t)
   #   4):匯入應沖帳　檔(xrce_t)
   #   5):匯入多帳期　檔(xrcc_t)

   CALL axrp120_create_tmp() RETURNING l_success

   FOR l_count = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_count].sel = 'Y' THEN
         INSERT INTO axrp120_debz_tmp(debzent,debzsite,debz002,debz001,debz003,debz004,           
                                      debz005,debz006, debz007,debz008,debz009,debz010,
                                      debz011,debz012, debz013,debz014,debz015,debz016,debz017)
            SELECT debzent,debzsite,debz002,debz001,debz003,debz004,
                   debz005,debz006, debz007,debz008,debz009,debz010,
                   debz011,debz012, debz013,debz014,debz015,debz016,debz017 FROM debz_t
             WHERE debz002  = g_detail_d[l_count].debz002
               AND debzsite = g_detail_d[l_count].debzsite

         INSERT INTO axrp120_deby_tmp(debyent,debysite,deby001,deby002,deby003,deby004,       
                                      deby005,deby006, deby007,deby008,deby009,deby010,
                                      deby011,deby012, deby013,deby014,deby015,deby016,deby017,deby018)
            SELECT debyent,debysite,deby001,deby002,deby003,deby004,
                   deby005,deby006, deby007,deby008,deby009,deby010,
                   deby011,deby012, deby013,deby014,deby015,deby016,deby017,deby018 FROM deby_t
             WHERE deby003  = g_detail_d[l_count].debz002
               AND debysite = g_detail_d[l_count].debzsite
      END IF
   END FOR

   #xrca新增單據範圍獲取
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT DISTINCT '',debz002 FROM axrp120_debz_tmp"         
   END IF
   
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT DISTINCT '','' FROM DUAL"
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT DISTINCT debzsite,'' FROM axrp120_debz_tmp"
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT DISTINCT debzsite,debz002 FROM axrp120_debz_tmp"
   END IF
   PREPARE axrp120_xrca_prep FROM l_sql
   DECLARE axrp120_xrca_curs CURSOR FOR axrp120_xrca_prep

   #xrcb新增單據範圍獲取
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT debzsite,debz002,debz001,debz003,debz004,          ",
                  "       debz005,debz006, debz007,debz008,debz009,           ",
                  "       SUM(debz010),SUM(debz011),SUM(debz012),SUM(debz013),",
                  "       SUM(debz014),SUM(debz015),SUM(debz016),SUM(debz017),",
                  "       ?,''                                                ",
                  "  FROM axrp120_debz_tmp                                    ",       
                  " WHERE debz002 = ?                                         ",
                  " GROUP BY debzsite,debz002,debz001,debz003,debz004,       ",
                  "          debz005,debz006, debz007,debz008,debz009         ",
                  " ORDER BY debzsite,debz002                                "
   END IF
   
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT debzsite,debz002,debz001,debz003,debz004,          ",
                  "       debz005,debz006, debz007,debz008,debz009,           ",
                  "       SUM(debz010),SUM(debz011),SUM(debz012),SUM(debz013),",
                  "       SUM(debz014),SUM(debz015),SUM(debz016),SUM(debz017),",
                  "       ?,?                                                 ",
                  "  FROM axrp120_debz_tmp                                    ",         
                  " GROUP BY debzsite,debz002,debz001,debz003,debz004,       ",
                  "          debz005,debz006, debz007,debz008,debz009         ",
                  " ORDER BY debzsite,debz002                                "
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT debzsite,debz002,debz001,debz003,debz004,          ",
                  "       debz005,debz006, debz007,debz008,debz009,           ",
                  "       SUM(debz010),SUM(debz011),SUM(debz012),SUM(debz013),",
                  "       SUM(debz014),SUM(debz015),SUM(debz016),SUM(debz017),",
                  "       '',''                                               ",
                  "  FROM axrp120_debz_tmp                                    ",      
                  " WHERE debzsite = ?                                       ",
                  " GROUP BY debzsite,debz002,debz001,debz003,debz004,       ",
                  "          debz005,debz006, debz007,debz008,debz009         ",
                  " ORDER BY debzsite,debz002,?                              "
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT DISTINCT debzsite,debz002 FROM axrp120_debz_tmp"          
      LET l_sql = "SELECT debzsite,debz002,debz001,debz003,debz004,          ",
                  "       debz005,debz006, debz007,debz008,debz009,           ",
                  "       SUM(debz010),SUM(debz011),SUM(debz012),SUM(debz013),",
                  "       SUM(debz014),SUM(debz015),SUM(debz016),SUM(debz017) ",
                  "  FROM axrp120_debz_tmp                                    ",     
                  " WHERE debzsite = ? AND debz002 = ?                       ",
                  " GROUP BY debzsite,debz002,debz001,debz003,debz004,       ",
                  "          debz005,debz006, debz007,debz008,debz009         ",
                  " ORDER BY debzsite,debz002                                "
   END IF
   PREPARE axrp120_debz_prep1 FROM l_sql
   DECLARE axrp120_debz_curs1 CURSOR FOR axrp120_debz_prep1

   #xrce新增單據範圍獲取
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT deby001,deby011,debysite,SUM(deby004),SUM(deby016),SUM(deby017),SUM(deby018),",
                  "       ?,''                                                                         ",
                  "  FROM axrp120_deby_tmp                                                             ",     
                  " WHERE deby003 = ?                                                                  ",
                  " GROUP BY deby001,deby011,debysite                                                  ",
                  " ORDER BY debysite                                                                  "
   END IF
   
   IF g_conditions.a1 = '1' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT deby001,deby011,debysite,SUM(deby004),SUM(deby016),SUM(deby017),SUM(deby018),",
                  "       ?                                                                            ",
                  "  FROM axrp120_deby_tmp                                                             ",     
                  " GROUP BY deby001,deby011,debysite                                                  ",
                  " ORDER BY debysite,?                                                                "
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '1' THEN
      LET l_sql = "SELECT deby001,deby011,debysite,SUM(deby004),SUM(deby016),SUM(deby017),SUM(deby018),",
                  "       '',''                                                                        ",
                  "  FROM axrp120_deby_tmp                                                             ",    
                  " WHERE debysite = ?                                                                 ",
                  " GROUP BY deby001,deby011,debysite                                                  ",
                  " ORDER BY debysite,?                                                                "
   END IF

   IF g_conditions.a1 = '2' AND g_conditions.a2 = '2' THEN
      LET l_sql = "SELECT deby001,deby011,debysite,SUM(deby004),SUM(deby016),SUM(deby017),SUM(deby018),",
                  "       '',''                                                                        ",
                  "  FROM axrp120_deby_tmp                                                            ",     
                  " WHERE debysite = ? AND deby003 = ?                                                 ",
                  " GROUP BY deby001,deby011,debysite                                                  ",
                  " ORDER BY debysite                                                                  "
   END IF
   PREPARE axrp120_deby_prep1 FROM l_sql
   DECLARE axrp120_deby_curs1 CURSOR FOR axrp120_deby_prep1

   CALL s_transaction_begin()

   FOREACH axrp120_xrca_curs INTO l_debzsite,l_debz002
      CALL axrp120_ins_xrca(l_debzsite,l_debz002)

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
      END IF 
      
      SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139) 
        INTO g_xrca.xrca107,g_xrca.xrca117,g_xrca.xrca127,g_xrca.xrca137
        FROM xrce_t
       WHERE xrccent = g_enterprise AND xrceld = g_xrca.xrcald AND xrcedocno = g_xrca.xrcadocno
      
      IF cl_null(g_xrca.xrca107) THEN LET g_xrca.xrca107 = 0 END IF   
      IF cl_null(g_xrca.xrca117) THEN LET g_xrca.xrca117 = 0 END IF   
      IF cl_null(g_xrca.xrca127) THEN LET g_xrca.xrca127 = 0 END IF   
      IF cl_null(g_xrca.xrca137) THEN LET g_xrca.xrca137 = 0 END IF    
      
      UPDATE xrca_t SET xrca107 = g_xrca.xrca107,
                        xrca108 = xrca103 + xrca104 - g_xrca.xrca107,
                        xrca117 = g_xrca.xrca117,
                        xrca118 = xrca113 + xrca114 - g_xrca.xrca117,
                        xrca127 = g_xrca.xrca127,
                        xrca128 = xrca123 + xrca124 - g_xrca.xrca127,
                        xrca137 = g_xrca.xrca137,
                        xrca138 = xrca133 + xrca134 - g_xrca.xrca137
       WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xrca_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

      END IF

   END FOREACH

   CALL s_transaction_end('Y','1')

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
PRIVATE FUNCTION axrp120_ins_xrca(p_debzsite,p_debz002)
   DEFINE p_debzsite       LIKE debz_t.debzsite
   DEFINE p_debz002        LIKE debz_t.debz002
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_xrcadocno      LIKE xrca_t.xrcadocno
   DEFINE l_ooef024        LIKE ooef_t.ooef024
   DEFINE l_xrca034        LIKE xrca_t.xrca034
   DEFINE l_xrca035        LIKE xrca_t.xrca035
   DEFINE l_xrca036        LIKE xrca_t.xrca036
   DEFINE l_s              LIKE type_t.chr1
   DEFINE l_xrca         RECORD
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

   INITIALIZE g_xrca TO NULL
   #单据编号
   IF cl_null(p_debz002) THEN
      CALL s_aooi200_fin_gen_docno(g_xrca_m.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_conditions.xrcadocno,g_conditions.xrcadocdt,'axrt120')
         RETURNING l_success,l_xrcadocno
   ELSE
      CALL s_aooi200_fin_gen_docno(g_xrca_m.xrcald,g_glaa.glaa024,g_glaa.glaa003,g_conditions.xrcadocno,p_debz002,'axrt120')
         RETURNING l_success,l_xrcadocno
   END IF
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_conditions.xrcadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'
   END IF

   SELECT ooef024 INTO l_ooef024 FROM ooef_t WHERE ooefent = g_enterprise
      AND ooef001 = g_xrca_m.xrcasite

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

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   SELECT ooeg004 INTO l_xrca034 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca015

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

   LET g_xrca.xrcaent   = g_enterprise
   LET g_xrca.xrcaownid = g_user
   LET g_xrca.xrcaowndp = g_dept
   LET g_xrca.xrcacrtid = g_user
   LET g_xrca.xrcacrtdp = g_dept
   LET g_xrca.xrcacrtdt = g_today
   LET g_xrca.xrcastus  = 'N'
   LET g_xrca.xrcacomp  = g_xrca_m.xrcacomp
   LET g_xrca.xrcald    = g_xrca_m.xrcald
   LET g_xrca.xrcadocno = l_xrcadocno
   IF cl_null(p_debz002) THEN LET g_xrca.xrcadocdt = g_conditions.xrcadocdt ELSE LET g_xrca.xrcadocdt = p_debz002 END IF
   LET g_xrca.xrca001   = '14'
   LET g_xrca.xrcasite  = g_xrca_m.xrcasite
   LET g_xrca.xrca003   = g_user
   LET g_xrca.xrca004   = l_ooef024
   CALL axrp120_xrca004_ref() RETURNING l_xrca.*
   LET g_xrca.xrca005   = l_xrca.xrca005
   LET g_xrca.xrca006   = l_xrca.xrca006
   LET g_xrca.xrca007   = l_xrca.xrca007
   LET g_xrca.xrca008   = l_xrca.xrca008
   LET g_xrca.xrca009   = l_xrca.xrca009
   LET g_xrca.xrca010   = l_xrca.xrca010
   LET g_xrca.xrca011   = l_xrca.xrca011
   LET g_xrca.xrca012   = l_xrca.xrca012
   LET g_xrca.xrca013   = l_xrca.xrca013
   LET g_xrca.xrca014   = l_xrca.xrca014
   LET g_xrca.xrca015   = l_xrca.xrca015
   LET g_xrca.xrca016   = 'axrp120'
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
   LET g_xrca.xrca100   = l_xrca.xrca100
   LET g_xrca.xrca101   = l_xrca.xrca101
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
   
   
   #add--2015/07/02 By shiun--(S)
   CALL s_aooi390_get_auto_no('14',g_xrca.xrca063) RETURNING l_success,g_xrca.xrca063
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF   
   DISPLAY BY NAME g_xrca.xrca063
   #add--2015/07/02 By shiun--(E)
   CALL s_aooi390_oofi_upd('14',g_xrca.xrca063) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
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
   CALL axrp120_ins_xrcb(p_debzsite,p_debz002)

   CALL axrp120_ins_xrce(p_debzsite,p_debz002)

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
PRIVATE FUNCTION axrp120_ins_xrcb(p_debzsite,p_debz002)
   DEFINE p_debzsite       LIKE debz_t.debzsite
   DEFINE p_debz002        LIKE debz_t.debz002
   DEFINE l_xrcb005        LIKE xrcb_t.xrcb005
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_s              LIKE type_t.chr1

   DEFINE l_debz        RECORD
             debzsite         LIKE debz_t.debzsite,
             debz002          LIKE debz_t.debz002,
             debz001          LIKE debz_t.debz001,
             debz003          LIKE debz_t.debz003,
             debz004          LIKE debz_t.debz004,
             debz005          LIKE debz_t.debz005,
             debz006          LIKE debz_t.debz006,
             debz007          LIKE debz_t.debz007,
             debz008          LIKE debz_t.debz008,
             debz009          LIKE debz_t.debz009,
             debz010          LIKE debz_t.debz010,
             debz011          LIKE debz_t.debz011,
             debz012          LIKE debz_t.debz012,
             debz013          LIKE debz_t.debz013,
             debz014          LIKE debz_t.debz014,
             debz015          LIKE debz_t.debz015,
             debz016          LIKE debz_t.debz016,
             debz017          LIKE debz_t.debz017
                        END RECORD

   INITIALIZE g_xrcb TO NULL

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   LET g_xrcb.xrcbseq = 0

   FOREACH axrp120_debz_curs1 USING p_debzsite,p_debz002 INTO l_debz.*
      SELECT imaal003 INTO l_xrcb005 FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal002 = g_lang
         AND imaal001 = l_debz.debz007

      LET g_xrcb.xrcbent = g_enterprise
      LET g_xrcb.xrcbld  = g_xrca_m.xrcald
      LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
      LET g_xrcb.xrcbseq = g_xrcb.xrcbseq + 1
      LET g_xrcb.xrcbsite= g_xrca_m.xrcasite
      LET g_xrcb.xrcborga=l_debz.debzsite
      LET g_xrcb.xrcb001 = ''
      LET g_xrcb.xrcb002 = ''
      LET g_xrcb.xrcb003 = ''
      LET g_xrcb.xrcb004 = l_debz.debz007
      LET g_xrcb.xrcb005 = l_xrcb005
      LET g_xrcb.xrcb006 = ''
      LET g_xrcb.xrcb007 = 1
      LET g_xrcb.xrcb008 = ''
      LET g_xrcb.xrcb009 = ''
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
      LET g_xrcb.xrcb020 = l_debz.debz008
      LET g_xrcb.xrcb021 = ''
      LET g_xrcb.xrcb022 = 1
      LET g_xrcb.xrcb024 = ''
      LET g_xrcb.xrcb023 = 'N'
      LET g_xrcb.xrcb025 = ''
      LET g_xrcb.xrcb026 = ''
      LET g_xrcb.xrcb027 = ''
      LET g_xrcb.xrcb028 = ''
      LET g_xrcb.xrcb029 = ''
      LET g_xrcb.xrcb030 = 0
      LET g_xrcb.xrcb100 = g_xrca.xrca100
      IF l_s = '1' THEN LET g_xrcb.xrcb101 = l_debz.debz012 - l_debz.debz015 END IF
      IF l_s = '2' THEN LET g_xrcb.xrcb101 = l_debz.debz012 - l_debz.debz016 END IF
      IF l_s = '3' THEN LET g_xrcb.xrcb101 = l_debz.debz012 - l_debz.debz017 END IF
      CALL s_tax_ins(g_xrca.xrcadocno,g_xrcb.xrcbseq,0,g_xrcb.xrcborga,
                     g_xrcb.xrcb007*g_xrcb.xrcb101,g_xrcb.xrcb020,
                     g_xrcb.xrcb007,g_xrcb.xrcb100,g_xrcb.xrcb101,g_xrca.xrcald,g_xrca.xrca121,g_xrca.xrca131)
         RETURNING g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,
                   g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,
                   g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,
                   g_xrcb.xrcb133,g_xrcb.xrcb134,g_xrcb.xrcb135
      LET g_xrcb.xrcb106 = 0
      LET g_xrcb.xrcb111 = g_xrcb.xrcb101 * g_xrcb.xrcb020
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
   END FOREACH

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
PRIVATE FUNCTION axrp120_ins_xrce(p_debzsite,p_debz002)
   DEFINE p_debzsite       LIKE debz_t.debzsite
   DEFINE p_debz002        LIKE debz_t.debz002
   DEFINE l_s              LIKE type_t.chr1
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_deby        RECORD
             deby001          LIKE deby_t.deby001,
             deby011          LIKE deby_t.deby011,
             debysite         LIKE deby_t.debysite,
             deby004          LIKE deby_t.deby004,
             deby016          LIKE deby_t.deby016,
             deby017          LIKE deby_t.deby017,
             deby018          LIKE deby_t.deby018
                        END RECORD

   INITIALIZE g_xrce TO NULL

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   LET g_xrce.xrceseq = 0

   FOREACH axrp120_deby_curs1 USING p_debzsite,p_debz002 INTO l_deby.*
      IF cl_null(l_deby.deby016) THEN LET l_deby.deby016 = 0 END IF
      IF cl_null(l_deby.deby017) THEN LET l_deby.deby017 = 0 END IF
      IF cl_null(l_deby.deby018) THEN LET l_deby.deby018 = 0 END IF
      LET g_xrce.xrceent = g_enterprise
      LET g_xrce.xrcecomp= g_xrca.xrcacomp
      LET g_xrce.xrceld  = g_xrca_m.xrcald
      LET g_xrce.xrcedocno=g_xrca.xrcadocno
      LET g_xrce.xrceseq = g_xrce.xrceseq + 1
      LET g_xrce.xrcelegl= ''
      LET g_xrce.xrcesite= ''
      LET g_xrce.xrceorga= ''
      LET g_xrce.xrce001 = 'axrp120'
      LET g_xrce.xrce002 = '10'
      LET g_xrce.xrce003 = ''
      LET g_xrce.xrce004 = ''
      LET g_xrce.xrce005 = ''
      LET g_xrce.xrce006 = l_deby.deby001
      IF l_s = '1' THEN LET g_xrce.xrce007 = l_deby.deby004 - l_deby.deby016 END IF
      IF l_s = '2' THEN LET g_xrce.xrce007 = l_deby.deby004 - l_deby.deby017 END IF
      IF l_s = '3' THEN LET g_xrce.xrce007 = l_deby.deby004 - l_deby.deby018 END IF
      LET g_xrce.xrce008 = l_deby.deby011
      LET g_xrce.xrce009 = ''
      LET g_xrce.xrce010 = ''
      LET g_xrce.xrce011 = ''
      LET g_xrce.xrce012 = ''
      LET g_xrce.xrce013 = ''
      LET g_xrce.xrce014 = ''
      LET g_xrce.xrce015 = 'D'
      LET g_xrce.xrce016 = ''
      LET g_xrce.xrce017 = ''
      LET g_xrce.xrce018 = ''
      LET g_xrce.xrce019 = ''
      LET g_xrce.xrce020 = ''
      LET g_xrce.xrce021 = ''
      LET g_xrce.xrce022 = ''
      LET g_xrce.xrce023 = ''
      LET g_xrce.xrce024 = ''
      LET g_xrce.xrce025 = ''
      LET g_xrce.xrce026 = ''
      LET g_xrce.xrce027 = 'N'
      LET g_xrce.xrce028 = '0'
      LET g_xrce.xrce029 = ''
      LET g_xrce.xrce030 = ''
      LET g_xrce.xrce035 = ''
      LET g_xrce.xrce036 = ''
      LET g_xrce.xrce037 = ''
      LET g_xrce.xrce038 = ''
      LET g_xrce.xrce100 = g_xrca.xrca100
      LET g_xrce.xrce101 = g_xrca.xrca101
      LET g_xrce.xrce104 = 0
      LET g_xrce.xrce109 = g_xrce.xrce007
      LET g_xrce.xrce114 = 0
      LET g_xrce.xrce120 = g_glaa.glaa016
      LET g_xrce.xrce121 = g_xrca.xrca131
      LET g_xrce.xrce124 = 0
      LET g_xrce.xrce130 = g_glaa.glaa020
      LET g_xrce.xrce131 = g_xrca.xrca131
      LET g_xrce.xrce134 = 0

      CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa001,g_xrce.xrce109,g_xrca.xrca101,g_glaa.glaacomp)
         RETURNING l_success,g_xrce.xrce119
      
      IF g_glaa.glaa015 = 'Y' THEN
         IF g_glaa.glaa017 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa016,g_xrce.xrce109,g_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrce.xrce129
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrce.xrce119,g_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrce.xrce129
         END IF
      ELSE
         LET g_xrce.xrce129 = 0
      END IF   
      
      IF g_glaa.glaa019 = 'Y' THEN
         #計算本位幣三金額
         IF g_glaa.glaa021 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_xrca.xrca100,g_glaa.glaa020,g_xrce.xrce109,g_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrce.xrce139
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa.glaa002,g_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa020,g_xrce.xrce119,g_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrce.xrce139
         END IF
      ELSE
         LET g_xrce.xrce139 = 0
      END IF

      #161128-00061#3-----modify--begin----------
      #INSERT INTO xrce_t VALUES (g_xrce.*)
       INSERT INTO xrce_t (xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,xrce001,
                           xrce002,xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,xrce010,xrce011,
                           xrce012,xrce013,xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,xrce021,
                           xrce022,xrce023,xrce024,xrce025,xrce026,xrce027,xrce028,xrce029,xrce030,xrce035,
                           xrce036,xrce037,xrce038,xrce039,xrce040,xrce041,xrce042,xrce043,xrce044,xrce045,
                           xrce046,xrce047,xrce048,xrce049,xrce050,xrce051,xrce053,xrce054,xrce100,xrce101,
                           xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,xrce124,xrce129,xrce130,xrce131,
                           xrce134,xrce139,xrce055,xrce056,xrce057,xrce058,xrce103,xrce113,xrce123,xrce133,xrce059)
        VALUES (g_xrce.xrceent,g_xrce.xrcecomp,g_xrce.xrceld,g_xrce.xrcedocno,g_xrce.xrceseq,g_xrce.xrcelegl,g_xrce.xrcesite,g_xrce.xrceorga,g_xrce.xrce001,
                g_xrce.xrce002,g_xrce.xrce003,g_xrce.xrce004,g_xrce.xrce005,g_xrce.xrce006,g_xrce.xrce007,g_xrce.xrce008,g_xrce.xrce009,g_xrce.xrce010,g_xrce.xrce011,
                g_xrce.xrce012,g_xrce.xrce013,g_xrce.xrce014,g_xrce.xrce015,g_xrce.xrce016,g_xrce.xrce017,g_xrce.xrce018,g_xrce.xrce019,g_xrce.xrce020,g_xrce.xrce021,
                g_xrce.xrce022,g_xrce.xrce023,g_xrce.xrce024,g_xrce.xrce025,g_xrce.xrce026,g_xrce.xrce027,g_xrce.xrce028,g_xrce.xrce029,g_xrce.xrce030,g_xrce.xrce035,
                g_xrce.xrce036,g_xrce.xrce037,g_xrce.xrce038,g_xrce.xrce039,g_xrce.xrce040,g_xrce.xrce041,g_xrce.xrce042,g_xrce.xrce043,g_xrce.xrce044,g_xrce.xrce045,
                g_xrce.xrce046,g_xrce.xrce047,g_xrce.xrce048,g_xrce.xrce049,g_xrce.xrce050,g_xrce.xrce051,g_xrce.xrce053,g_xrce.xrce054,g_xrce.xrce100,g_xrce.xrce101,
                g_xrce.xrce104,g_xrce.xrce109,g_xrce.xrce114,g_xrce.xrce119,g_xrce.xrce120,g_xrce.xrce121,g_xrce.xrce124,g_xrce.xrce129,g_xrce.xrce130,g_xrce.xrce131,
                g_xrce.xrce134,g_xrce.xrce139,g_xrce.xrce055,g_xrce.xrce056,g_xrce.xrce057,g_xrce.xrce058,g_xrce.xrce103,g_xrce.xrce113,g_xrce.xrce123,g_xrce.xrce133,g_xrce.xrce059)
      #161128-00061#3-----modify--end----------

   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 取值
# Memo...........:
# Usage..........: CALL axrp120_ooie_desc()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/10/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp120_ooie_desc()
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_ooie004   LIKE ooie_t.ooie004
   DEFINE l_ooie010   LIKE ooie_t.ooie010
   
   CALL s_money_ooie_get('','ooie004',g_detail_d[g_detail_idx1].debzsite,g_deby_d[l_ac].deby002) RETURNING l_ooie004
   CALL s_money_ooie_get('','ooie010',g_detail_d[g_detail_idx1].debzsite,g_deby_d[l_ac].deby002) RETURNING l_ooie010
   LET g_deby_d[l_ac].ooie004 = l_ooie004
   LET g_deby_d[l_ac].ooie010 = l_ooie010
END FUNCTION

#end add-point
 
{</section>}
 
