#該程式未解開Section, 採用最新樣板產出!
{<section id="afap270.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-11-01 16:26:00), PR版次:0016(2017-01-10 18:17:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: afap270
#+ Description: 資產出售/調撥產生帳款作業
#+ Creator....: 02599(2014-08-08 11:16:07)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="afap270.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150601-00034#1   2015/06/03 By 01727      1.afap270_xrca004_ref()中拿掉人员所属据点之惯用设置
#                                          2.根据收款条件带出应收款日、票到期日
#150731-00004#1   by yangtt 20150807       錯誤信息匯總報錯，將舊的報錯方式(cl_errmdg)改成新的報錯方式
#151125-00006#1   2015/12/15 by 06862      产生应收/应付账款后立即审核及立即抛转传票
#160318-00005#9   2016/03/23 by 07675      將重複內容的錯誤訊息置換為公用錯誤訊息
#160616-00005#3   2016/06/21 By 02599      修正BUG
#160628-00015#1   2016/07/14 By 01531      去除平行账套生成账款
#160125-00005#7   2016/08/09 By 01531      查詢時加上帳套人員權限條件過濾
#160727-00019#34  2016/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
#160913-00017#1   2016/09/23 By 07900      AFA模组调整交易客商开窗
#161021-00053#1   2016/10/21 By dorishsu   根據課稅別(oodb008),決定產生到axrt300的稅別(xrca060)
#161024-00008#1   2016/10/24 By Hans       AFA組織類型與職能開窗清單調整。 
#160426-00014#45  2016/10/31 By 02114      增加afat517的逻辑
#160426-00014#44  2016/11/03 By 02114      增加afat510的逻辑
#161215-00044#1   2016/12/15 by 02481      标准程式定义采用宣告模式,弃用.*写
#161221-00011#1   2016/12/21 By 02114      afap270出售抛应收后,1.判断出售单别是否需要自动抛总账，若设置为N，则不再走抛总账的逻辑
#                                          2.回写凭证编号的sql有误
#160426-00014#46  2017/01/05 By 07900      1、修改名称为资产出售/调拨生成账款作业。
#                                          2、原调拨生成账款作业的处理分成拨出和拨入分开，对应产生axrt330其他应收和aapt301其他应付。
#161228-00013#1   2017/01/10 By 07900      对确定的一笔出售单，通过整单操作的“生成账款”，调出afap270未将单号显示在单身的符合条件的单据，需要点击“对勾”才能查询出
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
   fabgld              LIKE fabg_t.fabgld,
   fabgld_desc         LIKE glaal_t.glaal002,
   fabgcomp            LIKE fabg_t.fabgcomp,
   fabgcomp_desc       LIKE ooefl_t.ooefl003,
   type                LIKE type_t.chr1,
   fabg005             LIKE fabg_t.fabg005,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel              LIKE type_t.chr1,
   fabgdocno        LIKE fabg_t.fabgdocno,
   fabgdocdt        LIKE fabg_t.fabgdocdt,
   fabg006          LIKE fabg_t.fabg006,
   fabg015          LIKE fabg_t.fabg015,
   fabg013          LIKE fabg_t.fabg013,
   fabo012          LIKE fabo_t.fabo012,
   fabo013          LIKE fabo_t.fabo013,
   fabo014          LIKE fabo_t.fabo014,
   fabo015          LIKE fabo_t.fabo015,
   fabo016          LIKE fabo_t.fabo016,
   fabo017          LIKE fabo_t.fabo017
   END RECORD 
TYPE type_g_fabo_d RECORD
   fabgdocno        LIKE fabg_t.fabgdocno,
   faboseq          LIKE fabo_t.faboseq,
   fabg007          LIKE fabg_t.fabg007,
   fabg006          LIKE fabg_t.fabg006,
   fabo024          LIKE fabo_t.fabo024,
   fabo024_desc     LIKE glacl_t.glacl004,
   fabo010          LIKE fabo_t.fabo010,
   fabo009          LIKE fabo_t.fabo009,
   fabo012          LIKE fabo_t.fabo012,
   fabo013          LIKE fabo_t.fabo013,
   fabo014          LIKE fabo_t.fabo014,
   fabo015          LIKE fabo_t.fabo015,
   fabo016          LIKE fabo_t.fabo016,
   fabo017          LIKE fabo_t.fabo017
   END RECORD
 #160426-00014#45--mark--str--lujh
 #TYPE type_g_fabu_d RECORD
 #  fabgdocno        LIKE fabg_t.fabgdocno,
 #  fabuseq          LIKE fabu_t.fabuseq,
 #  fabg007          LIKE fabg_t.fabg007,
 #  fabg006          LIKE fabg_t.fabg006,
 #  fabu022          LIKE fabu_t.fabu022,
 #  fabu022_desc     LIKE glacl_t.glacl004,
 #  fabu010          LIKE fabu_t.fabu010,
 #  fabu009          LIKE fabu_t.fabu009,
 #  fabu012          LIKE fabu_t.fabu012,
 #  fabu013          LIKE fabu_t.fabu013,
 #  fabu014          LIKE fabu_t.fabu014,
 #  fabu015          LIKE fabu_t.fabu015,
 #  fabu016          LIKE fabu_t.fabu016,
 #  fabu017          LIKE fabu_t.fabu017
 #  END RECORD
 #160426-00014#45--mark--end--lujh 
 #160426-00014#45--add--str--lujh 
 TYPE type_g_faca_d RECORD
   fabgdocno        LIKE fabg_t.fabgdocno,
   facaseq          LIKE faca_t.facaseq,
   fabg007          LIKE fabg_t.fabg007,
   fabg006          LIKE fabg_t.fabg006,
   faca023          LIKE faca_t.faca023,
   faca023_desc     LIKE glacl_t.glacl004,
   fabg015          LIKE fabg_t.fabg015,
   faca010          LIKE faca_t.faca010,
   faca011          LIKE faca_t.faca011,
   faca012          LIKE faca_t.faca012,
   faca013          LIKE faca_t.faca013,
   faca014          LIKE faca_t.faca014,
   faca015          LIKE faca_t.faca015,
   faca016          LIKE faca_t.faca016
   END RECORD  
 #160426-00014#45--add--str--lujh 
DEFINE g_input      RECORD
   xrcasite         LIKE xrca_t.xrcasite,
   xrcasite_desc    LIKE ooefl_t.ooefl003,
   xrcald           LIKE xrca_t.xrcald,
   xrcald_desc      LIKE ooefl_t.ooefl003,
   xrcadocno        LIKE xrca_t.xrcadocno,
   xrcadocdt        LIKE xrca_t.xrcadocdt,
   flag             LIKE type_t.chr1,
   docno_s          LIKE xrca_t.xrcadocno,
   docno_e          LIKE xrca_t.xrcadocno,
   apcasite         LIKE apca_t.apcasite,
   apcasite_desc    LIKE ooefl_t.ooefl003,
   apcald           LIKE apca_t.apcald,
   apcald_desc      LIKE ooefl_t.ooefl003,
   apcadocno        LIKE apca_t.apcadocno,
   apcadocdt        LIKE apca_t.apcadocdt,
   flag1            LIKE type_t.chr1,
   docno_s1         LIKE apca_t.apcadocno,
   docno_e1         LIKE apca_t.apcadocno
                    END RECORD   
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_master          type_parameter
DEFINE g_fabo_d          DYNAMIC ARRAY OF type_g_fabo_d
#DEFINE g_fabu_d          DYNAMIC ARRAY OF type_g_fabu_d    #160426-00014#45 mark lujh
DEFINE g_faca_d          DYNAMIC ARRAY OF type_g_faca_d     #160426-00014#45 add lujh
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaa004         LIKE glaa_t.glaa004
DEFINE g_rec_b           LIKE type_t.num5              #單身筆數
DEFINE g_detail_idx      LIKE type_t.num5
DEFINE l_ac2             LIKE type_t.num5 
DEFINE l_ac3             LIKE type_t.num5 
DEFINE g_success         LIKE type_t.num5
#161215-00044#1---modify----begin----------------
#DEFINE g_xrca            RECORD LIKE xrca_t.*
#DEFINE g_xrcb            RECORD LIKE xrcb_t.*
#DEFINE g_xrcc            RECORD LIKE xrcc_t.*
#DEFINE g_apca            RECORD LIKE apca_t.*
#DEFINE g_apcb            RECORD LIKE apcb_t.*
#DEFINE g_apcc            RECORD LIKE apcc_t.*
#DEFINE g_glaa            RECORD LIKE glaa_t.*
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
       xrca138 LIKE xrca_t.xrca138, #本位幣三應收金額
       xrcaud001 LIKE xrca_t.xrcaud001, #自定義欄位(文字)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定義欄位(文字)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定義欄位(文字)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定義欄位(文字)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定義欄位(文字)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定義欄位(文字)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定義欄位(文字)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定義欄位(文字)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定義欄位(文字)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定義欄位(文字)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定義欄位(數字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定義欄位(數字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定義欄位(數字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定義欄位(數字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定義欄位(數字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定義欄位(數字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定義欄位(數字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定義欄位(數字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定義欄位(數字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定義欄位(數字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定義欄位(日期時間)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定義欄位(日期時間)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定義欄位(日期時間)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定義欄位(日期時間)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定義欄位(日期時間)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定義欄位(日期時間)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定義欄位(日期時間)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定義欄位(日期時間)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定義欄位(日期時間)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定義欄位(日期時間)030
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
       xrcbud001 LIKE xrcb_t.xrcbud001, #自定義欄位(文字)001
       xrcbud002 LIKE xrcb_t.xrcbud002, #自定義欄位(文字)002
       xrcbud003 LIKE xrcb_t.xrcbud003, #自定義欄位(文字)003
       xrcbud004 LIKE xrcb_t.xrcbud004, #自定義欄位(文字)004
       xrcbud005 LIKE xrcb_t.xrcbud005, #自定義欄位(文字)005
       xrcbud006 LIKE xrcb_t.xrcbud006, #自定義欄位(文字)006
       xrcbud007 LIKE xrcb_t.xrcbud007, #自定義欄位(文字)007
       xrcbud008 LIKE xrcb_t.xrcbud008, #自定義欄位(文字)008
       xrcbud009 LIKE xrcb_t.xrcbud009, #自定義欄位(文字)009
       xrcbud010 LIKE xrcb_t.xrcbud010, #自定義欄位(文字)010
       xrcbud011 LIKE xrcb_t.xrcbud011, #自定義欄位(數字)011
       xrcbud012 LIKE xrcb_t.xrcbud012, #自定義欄位(數字)012
       xrcbud013 LIKE xrcb_t.xrcbud013, #自定義欄位(數字)013
       xrcbud014 LIKE xrcb_t.xrcbud014, #自定義欄位(數字)014
       xrcbud015 LIKE xrcb_t.xrcbud015, #自定義欄位(數字)015
       xrcbud016 LIKE xrcb_t.xrcbud016, #自定義欄位(數字)016
       xrcbud017 LIKE xrcb_t.xrcbud017, #自定義欄位(數字)017
       xrcbud018 LIKE xrcb_t.xrcbud018, #自定義欄位(數字)018
       xrcbud019 LIKE xrcb_t.xrcbud019, #自定義欄位(數字)019
       xrcbud020 LIKE xrcb_t.xrcbud020, #自定義欄位(數字)020
       xrcbud021 LIKE xrcb_t.xrcbud021, #自定義欄位(日期時間)021
       xrcbud022 LIKE xrcb_t.xrcbud022, #自定義欄位(日期時間)022
       xrcbud023 LIKE xrcb_t.xrcbud023, #自定義欄位(日期時間)023
       xrcbud024 LIKE xrcb_t.xrcbud024, #自定義欄位(日期時間)024
       xrcbud025 LIKE xrcb_t.xrcbud025, #自定義欄位(日期時間)025
       xrcbud026 LIKE xrcb_t.xrcbud026, #自定義欄位(日期時間)026
       xrcbud027 LIKE xrcb_t.xrcbud027, #自定義欄位(日期時間)027
       xrcbud028 LIKE xrcb_t.xrcbud028, #自定義欄位(日期時間)028
       xrcbud029 LIKE xrcb_t.xrcbud029, #自定義欄位(日期時間)029
       xrcbud030 LIKE xrcb_t.xrcbud030, #自定義欄位(日期時間)030
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
DEFINE g_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票編號
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrccud001 LIKE xrcc_t.xrccud001, #自定義欄位(文字)001
       xrccud002 LIKE xrcc_t.xrccud002, #自定義欄位(文字)002
       xrccud003 LIKE xrcc_t.xrccud003, #自定義欄位(文字)003
       xrccud004 LIKE xrcc_t.xrccud004, #自定義欄位(文字)004
       xrccud005 LIKE xrcc_t.xrccud005, #自定義欄位(文字)005
       xrccud006 LIKE xrcc_t.xrccud006, #自定義欄位(文字)006
       xrccud007 LIKE xrcc_t.xrccud007, #自定義欄位(文字)007
       xrccud008 LIKE xrcc_t.xrccud008, #自定義欄位(文字)008
       xrccud009 LIKE xrcc_t.xrccud009, #自定義欄位(文字)009
       xrccud010 LIKE xrcc_t.xrccud010, #自定義欄位(文字)010
       xrccud011 LIKE xrcc_t.xrccud011, #自定義欄位(數字)011
       xrccud012 LIKE xrcc_t.xrccud012, #自定義欄位(數字)012
       xrccud013 LIKE xrcc_t.xrccud013, #自定義欄位(數字)013
       xrccud014 LIKE xrcc_t.xrccud014, #自定義欄位(數字)014
       xrccud015 LIKE xrcc_t.xrccud015, #自定義欄位(數字)015
       xrccud016 LIKE xrcc_t.xrccud016, #自定義欄位(數字)016
       xrccud017 LIKE xrcc_t.xrccud017, #自定義欄位(數字)017
       xrccud018 LIKE xrcc_t.xrccud018, #自定義欄位(數字)018
       xrccud019 LIKE xrcc_t.xrccud019, #自定義欄位(數字)019
       xrccud020 LIKE xrcc_t.xrccud020, #自定義欄位(數字)020
       xrccud021 LIKE xrcc_t.xrccud021, #自定義欄位(日期時間)021
       xrccud022 LIKE xrcc_t.xrccud022, #自定義欄位(日期時間)022
       xrccud023 LIKE xrcc_t.xrccud023, #自定義欄位(日期時間)023
       xrccud024 LIKE xrcc_t.xrccud024, #自定義欄位(日期時間)024
       xrccud025 LIKE xrcc_t.xrccud025, #自定義欄位(日期時間)025
       xrccud026 LIKE xrcc_t.xrccud026, #自定義欄位(日期時間)026
       xrccud027 LIKE xrcc_t.xrccud027, #自定義欄位(日期時間)027
       xrccud028 LIKE xrcc_t.xrccud028, #自定義欄位(日期時間)028
       xrccud029 LIKE xrcc_t.xrccud029, #自定義欄位(日期時間)029
       xrccud030 LIKE xrcc_t.xrccud030, #自定義欄位(日期時間)030
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD
DEFINE g_apca RECORD  #應付憑單單頭
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

DEFINE g_apcb RECORD  #應付憑單單身
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

DEFINE g_apcc RECORD  #應付多帳期檔
       apccent LIKE apcc_t.apccent, #企業編號
       apccld LIKE apcc_t.apccld, #帳套
       apcccomp LIKE apcc_t.apcccomp, #法人
       apcclegl LIKE apcc_t.apcclegl, #核算組織
       apccsite LIKE apcc_t.apccsite, #帳務中心
       apccdocno LIKE apcc_t.apccdocno, #應付帳款單號碼
       apccseq LIKE apcc_t.apccseq, #項次
       apcc001 LIKE apcc_t.apcc001, #分期帳款序
       apcc002 LIKE apcc_t.apcc002, #應付款別性質
       apcc003 LIKE apcc_t.apcc003, #應付款日
       apcc004 LIKE apcc_t.apcc004, #容許票據到期日
       apcc005 LIKE apcc_t.apcc005, #帳款起算日
       apcc006 LIKE apcc_t.apcc006, #正負值
       apcc007 LIKE apcc_t.apcc007, #原幣已請款金額
       apcc008 LIKE apcc_t.apcc008, #發票編號
       apcc009 LIKE apcc_t.apcc009, #發票號碼
       apcc010 LIKE apcc_t.apcc010, #發票日期
       apcc011 LIKE apcc_t.apcc011, #交易單據日期
       apcc012 LIKE apcc_t.apcc012, #立帳日期
       apcc013 LIKE apcc_t.apcc013, #交易認定日期
       apcc014 LIKE apcc_t.apcc014, #出入庫扣帳日期
       apcc100 LIKE apcc_t.apcc100, #交易原幣別
       apcc101 LIKE apcc_t.apcc101, #原幣匯率
       apcc102 LIKE apcc_t.apcc102, #原幣重估後匯率
       apcc103 LIKE apcc_t.apcc103, #NO USE
       apcc104 LIKE apcc_t.apcc104, #NO USE
       apcc105 LIKE apcc_t.apcc105, #NO USE
       apcc106 LIKE apcc_t.apcc106, #NO USE
       apcc107 LIKE apcc_t.apcc107, #NO USE
       apcc108 LIKE apcc_t.apcc108, #原幣應付金額
       apcc109 LIKE apcc_t.apcc109, #原幣付款沖帳金額
       apcc113 LIKE apcc_t.apcc113, #重評價調整數
       apcc114 LIKE apcc_t.apcc114, #NO USE
       apcc115 LIKE apcc_t.apcc115, #NO USE
       apcc116 LIKE apcc_t.apcc116, #NO USE
       apcc117 LIKE apcc_t.apcc117, #NO USE
       apcc118 LIKE apcc_t.apcc118, #本幣應付金額
       apcc119 LIKE apcc_t.apcc119, #本幣付款沖帳金額
       apcc120 LIKE apcc_t.apcc120, #本位幣二幣別
       apcc121 LIKE apcc_t.apcc121, #本位幣二匯率
       apcc122 LIKE apcc_t.apcc122, #本位幣二重估後匯率
       apcc123 LIKE apcc_t.apcc123, #重評價調整數
       apcc124 LIKE apcc_t.apcc124, #NO USE
       apcc125 LIKE apcc_t.apcc125, #NO USE
       apcc126 LIKE apcc_t.apcc126, #NO USE
       apcc127 LIKE apcc_t.apcc127, #NO USE
       apcc128 LIKE apcc_t.apcc128, #本位幣二應付金額
       apcc129 LIKE apcc_t.apcc129, #本位幣二付款沖帳金額
       apcc130 LIKE apcc_t.apcc130, #本位幣三幣別
       apcc131 LIKE apcc_t.apcc131, #本位幣三匯率
       apcc132 LIKE apcc_t.apcc132, #本位幣三重估後匯率
       apcc133 LIKE apcc_t.apcc133, #重評價調整數
       apcc134 LIKE apcc_t.apcc134, #NO USE
       apcc135 LIKE apcc_t.apcc135, #NO USE
       apcc136 LIKE apcc_t.apcc136, #NO USE
       apcc137 LIKE apcc_t.apcc137, #NO USE
       apcc138 LIKE apcc_t.apcc138, #本位幣三應付金額
       apcc139 LIKE apcc_t.apcc139, #本位幣三付款沖帳金額
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
       apcc015 LIKE apcc_t.apcc015, #付款條件
       apcc016 LIKE apcc_t.apcc016, #帳款類型
       apcc017 LIKE apcc_t.apcc017  #採購單號
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

#161215-00044#1---modify----end-----------------
DEFINE g_fabgdocno       LIKE fabg_t.fabgdocno
DEFINE g_wc_cs_orga      STRING      #160125-00005#7
DEFINE g_site_str        STRING      #160125-00005#7
DEFINE g_wc_cs_ld        STRING      #160125-00005#7
#end add-point
 
{</section>}
 
{<section id="afap270.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151125-00006#1---add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success 
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
   CALL s_fin_continue_no_tmp() 
   #151125-00006#1---add---e
   CALL s_aapp330_cre_tmp() RETURNING l_success      #160426-00014#44 add lujh
   #161228-00013#1--add--s---
   LET g_bgjob = g_argv[5]
   IF cl_null(g_bgjob) THEN LET g_bgjob = 'N' END IF
   #161228-00013#1--add--e--
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap270 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap270_init()   
 
      #進入選單 Menu (="N")
      CALL afap270_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap270
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap270.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap270_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7   
   CALL afap270_default_search()   #161228-00013#1 add xul 
   CALL cl_set_combo_scc_part('fabg005','9910','4,43,44')   #160426-00014#45 change 17 to 43 lujh  #160426-00014#44 add 44 lujh
   IF NOT cl_null(g_argv[1]) THEN
      LET g_glaald=g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_fabgdocno=g_argv[02]
      DISPLAY g_fabgdocno TO fabgdocno
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_master.fabg005=g_argv[03]
      DISPLAY g_master.fabg005 TO fabg005
   END IF
   IF cl_null(g_glaald) THEN
      #抓取预设帐别
      CALL s_ld_bookno() RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         LET g_glaald=NULL
         RETURN
      END IF
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_glaald=NULL
         RETURN
      END IF
   END IF
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap270.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap270_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_pass      LIKE type_t.num5
   DEFINE l_str       STRING  #160426-00014#46 add xul
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CLEAR FORM 
   LET g_master.wc=NULL
   DISPLAY BY NAME g_master.fabgld,g_master.fabgld_desc,g_master.fabgcomp,g_master.fabgcomp_desc,g_master.type,g_master.fabg005
   LET g_site_str = NULL #160125-00005#7   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap270_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT BY NAME g_master.fabgld,g_master.type,g_master.fabg005  
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               #帳套
               IF cl_null(g_master.fabgld) THEN 
                  LET g_master.fabgld=g_glaald
               END IF
               CALL afap270_fabgld_desc(g_master.fabgld)
               #單據性質
               IF cl_null(g_master.fabg005) OR g_master.fabg005=0 THEN
                  LET g_master.fabg005='4'
                  DISPLAY BY NAME g_master.fabg005
               END IF
               IF g_master.fabg005='4' THEN #出售單
                  CALL cl_set_comp_visible("page_3",FALSE)
               ELSE#調撥單
                  CALL cl_set_comp_visible("page_3",TRUE)
               END IF
               IF NOT cl_null(g_fabgdocno) THEN
                  DISPLAY g_fabgdocno TO fabgdocno
               END IF
               #匯總方式
               IF cl_null(g_master.type) THEN
                  LET g_master.type='1'
                  DISPLAY BY NAME g_master.type
               END IF
               IF g_master.type='1' THEN
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",TRUE)
                  CALL cl_set_comp_visible("fabg006_1",FALSE)
               ELSE
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",FALSE)
                  CALL cl_set_comp_visible("fabg006_1",TRUE)
               END IF
               
            AFTER FIELD fabgld
               IF NOT cl_null(g_master.fabgld) THEN
                  CALL afap270_fabgld_chk(g_master.fabgld)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.fabgld
                     #160318-00005#9 --add--str
                     LET g_errparam.replace[1] ='agli010'
                     LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                     LET g_errparam.exeprog    ='agli010'
                     #160318-00005#9 --add--end
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
            
                     LET g_master.fabgld = ''
                     NEXT FIELD fabgld
                  END IF
                  #检查使用者是否有权限使用当前账别
                  CALL s_ld_chk_authorization(g_user,g_master.fabgld) RETURNING l_pass
                  IF l_pass = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_master.fabgld
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
            
                     LET g_master.fabgld = ''
                     NEXT FIELD fabgld
                  END IF
                  CALL afap270_fabgld_desc(g_master.fabgld)               
               END IF 
               
            ON CHANGE type
               IF g_master.type NOT MATCHES '[12]' THEN
                  NEXT FIELD type
               END IF
               IF g_master.type='1' THEN
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",TRUE)
                  CALL cl_set_comp_visible("fabg006_1",FALSE)
               ELSE
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",FALSE)
                  CALL cl_set_comp_visible("fabg006_1",TRUE)
               END IF
                 
            ON CHANGE fabg005
               IF g_master.fabg005<>'4' AND g_master.fabg005<>'43' AND g_master.fabg005<>'44' THEN   #160426-00014#45 change 17 to 43 lujh  #160426-00014#45 change 17 to 44 lujh
                  NEXT FIELD fabg005
               END IF
               IF g_master.fabg005='4' THEN #出售單
                  CALL cl_set_comp_visible("page_3",FALSE)
                  CALL cl_set_comp_visible("page_2",TRUE)    #160426-00014#45 add lujh
               ELSE#調撥單
                  #160426-00014#46--add--s--
                  IF g_master.fabg005 = '43' THEN #拨出账务
                     LET l_str = cl_getmsg("afa-01143",g_lang)
                     CALL cl_set_comp_att_text("page_3",l_str)
                  END IF
                  IF g_master.fabg005 = '44' THEN #拨入账务
                     LET l_str = cl_getmsg("afa-01144",g_lang)
                     CALL cl_set_comp_att_text("page_3",l_str)
                  END IF                
                  #160426-00014#46--add--e--
                  CALL cl_set_comp_visible("page_2",FALSE)   #160426-00014#45 add lujh
                  CALL cl_set_comp_visible("page_3",TRUE) 
                  
               END IF
               
            ON ACTION controlp INFIELD fabgld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.fabgld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept 
               #160125-00005#7--add--str--
               #账套范围
               CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
               IF NOT cl_null(g_wc_cs_ld) THEN   
                  LET g_qryparam.where = g_wc_cs_ld
               END IF
               #160125-00005#7--add--end               
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_master.fabgld = g_qryparam.return1              
               DISPLAY g_master.fabgld TO fabgld              #
               CALL afap270_fabgld_desc(g_master.fabgld)
               NEXT FIELD fabgld                          #返回原欄位
         END INPUT
 
 
         
         #+ 此段落由子樣板a57產生
         CONSTRUCT BY NAME g_master.wc ON fabgsite,fabg001,fabg006,fabgdocdt,fabgdocno
         
            BEFORE CONSTRUCT
               #add-point:cs段before_construct
               CALL cl_qbe_init()
            #160125-00005#7 add s---   
            AFTER FIELD fabgsite   
               CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str  
            #160125-00005#7 add e---
            
            ON ACTION controlp INFIELD fabgsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160125-00005#7--add--str--   
               LET g_qryparam.where = " ooef201 = 'Y' "
               IF NOT cl_null(g_wc_cs_orga) THEN
			         LET g_qryparam.where = g_wc_cs_orga
			      END IF
			      #160125-00005#7--add--end               
               #CALL q_ooef001()                           #呼叫開窗 #161024-00008#1 
               CALL q_ooef001_47()                                  #161024-00008#1 
               DISPLAY g_qryparam.return1 TO fabgsite  #顯示到畫面上
               NEXT FIELD fabgsite                     #返回原欄位
            ON ACTION controlp INFIELD fabg001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fabg001  #顯示到畫面上
               NEXT FIELD fabg001  
            ON ACTION controlp INFIELD fabg006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               # CALL q_pmaa001()   #160913-00017#1  mark                  #呼叫開窗
               #160913-00017#1--ADD(S)--
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
               #160913-00017#1--ADD(E)- 
               DISPLAY g_qryparam.return1 TO fabg006  #顯示到畫面上
               NEXT FIELD fabg006                     #返回原欄位
            ON ACTION controlp INFIELD fabgdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF g_master.fabg005='4' THEN
                  LET g_qryparam.where = " fabg005='4' "
               END IF
               IF g_master.fabg005='43' THEN                #160426-00014#45 change 17 to 43 lujh
                  LET g_qryparam.where = " fabg005='43' "   #160426-00014#45 change 17 to 43 lujh
               END IF
               #160426-00014#44--add--str--lujh
               IF g_master.fabg005='44' THEN                 
                  LET g_qryparam.where = " fabg005='44' "   
               END IF
               #160426-00014#44--add--end--lujh
               CALL q_fabgdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fabgdocno  #顯示到畫面上
               NEXT FIELD fabgdocno                     #返回原欄位
         END CONSTRUCT
         
#         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
#    
#            BEFORE ROW
#               LET l_ac = DIALOG.getCurrentRow("s_detail1")
#               
#            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               LET l_ac = DIALOG.getCurrentRow("s_detail1")
#               CALL afap270_b_fill()
#               
#         END DISPLAY
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
#               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
#                 LET g_insert = 'N' 
#               END IF 
#               CALL afap270_b_fill()
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
#               LET g_master_idx = l_ac
#               DISPLAY l_ac TO FORMONLY.h_index
#               CALL afap270_fetch() 
#               IF l_ac>0 THEN
#                  CALL afap270_b_fill()
#               END IF                  
               
                    
         END INPUT
         
         DISPLAY ARRAY g_fabo_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               CALL afap270_b_fill2()
               
         END DISPLAY
         
         #DISPLAY ARRAY g_fabu_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1   #160426-00014#45 mark lujh
         DISPLAY ARRAY g_faca_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)           #160426-00014#45 add lujh
    
            BEFORE ROW
               LET l_ac3 = DIALOG.getCurrentRow("s_detail1")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail1")
               CALL afap270_b_fill3()
               
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            #161228-00013#1--add--s---
            IF g_bgjob = "T" THEN
               #帳套
               IF cl_null(g_master.fabgld) THEN 
                  LET g_master.fabgld=g_glaald
               END IF
               CALL afap270_fabgld_desc(g_master.fabgld)
              IF g_master.fabg005='4' THEN #出售單
                  CALL cl_set_comp_visible("page_3",FALSE)
                  CALL cl_set_comp_visible("page_2",TRUE)    #160426-00014#45 add lujh
               ELSE#調撥單
                 
                  IF g_master.fabg005 = '43' THEN #拨出账务
                     LET l_str = cl_getmsg("afa-01143",g_lang)
                     CALL cl_set_comp_att_text("page_3",l_str)
                  END IF
                  IF g_master.fabg005 = '44' THEN #拨入账务
                     LET l_str = cl_getmsg("afa-01144",g_lang)
                     CALL cl_set_comp_att_text("page_3",l_str)
                  END IF                
                 
                  CALL cl_set_comp_visible("page_2",FALSE)   #160426-00014#45 add lujh
                  CALL cl_set_comp_visible("page_3",TRUE)                  
               END IF
               #匯總方式
               IF cl_null(g_master.type) THEN
                  LET g_master.type='1'
                  DISPLAY BY NAME g_master.type
               END IF
               IF g_master.type='1' THEN
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",TRUE)
                  CALL cl_set_comp_visible("fabg006_1",FALSE)
               ELSE
                  CALL cl_set_comp_visible("fabgdocno_1,fabgdocdt_1",FALSE)
                  CALL cl_set_comp_visible("fabg006_1",TRUE)
               END IF
               CALL afap270_query()
            END IF 
            #161228-00013#1--add--e--
            NEXT FIELD fabgld
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
            CALL afap270_filter()
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
            CALL afap270_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap270_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION sel_page
            NEXT FIELD sel
            
         ON ACTION sale_page
            NEXT FIELD fabgdocno_2
            
         ON ACTION detail_page
            NEXT FIELD fabgdocno_3
            
         ON ACTION batch_execute
            CALL afap270_execute()
            IF NOT cl_null(g_argv[03]) THEN
               LET INT_FLAG=FALSE         
               LET g_action_choice = "exit"
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
 
{<section id="afap270.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap270_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_master_idx=1
   #end add-point
        
   LET g_error_show = 1
   CALL afap270_b_fill()
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
 
{<section id="afap270.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap270_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc=" 1=1"
   END IF
   IF g_master.fabg005 = '4' THEN        #160426-00014#45 add lujh
      LET ls_wc="SUM(fabo012),SUM(fabo013),SUM(fabo014),SUM(fabo015),SUM(fabo016),SUM(fabo017)",
                "  FROM fabg_t,fabo_t",
                " WHERE fabgent=faboent AND fabgld=fabold AND fabgdocno=fabodocno AND fabgent=?",
                "   AND fabgld='",g_master.fabgld,"'",   
                "   AND fabg011 IS NULL AND fabg012 IS NULL "
   #160426-00014#45--add--str--lujh
   ELSE
      LET ls_wc="SUM(faca011),SUM(faca012),SUM(faca013),SUM(faca014),SUM(faca015),SUM(faca016)",
                "  FROM fabg_t,faca_t",
                " WHERE fabgent = facaent ",
                "   AND fabgld = facald ",
                "   AND fabgdocno = facadocno ",
                "   AND fabgent = ?",
                "   AND fabgld='",g_master.fabgld,"'",   
                "   AND fabg011 IS NULL "
   END IF
   #160426-00014#45--add--end--lujh
   IF g_master.fabg005='4' THEN #出售單
#      LET ls_wc=ls_wc," AND fabg005='4' AND fabgstus='Y' AND fabg019 IS NULL "  #20141120 mark
      LET ls_wc=ls_wc," AND fabg005='4' AND (fabgstus='Y' OR fabgstus = 'S')  "   #20141120 add by chenying 应收账款为空时，已过帐单据也可产生应收账款；另调拨在调整，fabg019调拨单号条件先mark  
   ELSE #調撥單 
      #LET ls_wc=ls_wc," AND fabg005='17' AND fabgstus='Y' "   #160426-00014#45 mark lujh
      LET ls_wc=ls_wc," AND fabg005 = '",g_master.fabg005,"' AND (fabgstus='Y' OR fabgstus = 'S') " #160426-00014#45 add lujh
   END IF
   IF NOT cl_null(g_fabgdocno) THEN
      LET ls_wc = ls_wc," AND fabgdocno ='",g_fabgdocno,"'"
   END IF
   LET ls_wc=ls_wc,"   AND ",g_master.wc   
   
   IF g_master.type='1' THEN
      IF g_master.fabg005='4' THEN
         LET g_sql="SELECT 'N',fabgdocno,fabgdocdt,'',fabg015,fabg013,",ls_wc,                
                   " GROUP BY fabgdocno,fabgdocdt,fabg015,fabg013",
                   " ORDER BY fabgdocno,fabgdocdt,fabg015,fabg013"
      END IF             
      IF g_master.fabg005='43' OR g_master.fabg005='44' THEN    #160426-00014#45 change 17 to 43 lujh   #160426-00014#44 add OR g_master.fabg005='44' lujh 
         #160426-00014#45--mark--str--lujh
         #LET g_sql="SELECT 'N',fabgdocno,fabgdocdt,'',fabo010,fabo009,",ls_wc,                
         #          " GROUP BY fabgdocno,fabgdocdt,fabo010,fabo009",
         #          " ORDER BY fabgdocno,fabgdocdt,fabo010,fabo009"
         #160426-00014#45--mark--end--lujh  
         #160426-00014#45--add--str--lujh          
         LET g_sql="SELECT 'N',fabgdocno,fabgdocdt,'',fabg015,faca010,",ls_wc,                
                   " GROUP BY fabgdocno,fabgdocdt,fabg015,faca010",
                   " ORDER BY fabgdocno,fabgdocdt,fabg015,faca010"     
         #160426-00014#45--add--end--lujh                   
      END IF           
   ELSE
      IF g_master.fabg005='4' THEN
         LET g_sql="SELECT 'N','','',fabg006,fabg015,fabg013,",ls_wc,                
                   " GROUP BY fabg006,fabg015,fabg013",
                   " ORDER BY fabg006,fabg015,fabg013"
      END IF         
      IF g_master.fabg005='43' OR g_master.fabg005='44' THEN     #160426-00014#45 change 17 to 43 lujh  #160426-00014#44 add OR g_master.fabg005='44' lujh 
         #160426-00014#45--mark--str--lujh
         #LET g_sql="SELECT 'N','','',fabg006,fabo010,fabo009,",ls_wc,                
         #          " GROUP BY fabg006,fabo010,fabo009",
         #          " ORDER BY fabg006,fabo010,fabo009"
         #160426-00014#45--mark--end--lujh  
         #160426-00014#45--add--str--lujh           
         LET g_sql="SELECT 'N','','',fabg006,fabg015,faca010,",ls_wc,                
                   " GROUP BY fabg006,fabg015,faca010",
                   " ORDER BY fabg006,fabg015,faca010"
         #160426-00014#45--add--end--lujh 
      END IF             
   END IF
   #end add-point
 
   PREPARE afap270_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap270_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].fabgdocno,g_detail_d[l_ac].fabgdocdt,g_detail_d[l_ac].fabg006,
   g_detail_d[l_ac].fabg015,g_detail_d[l_ac].fabg013,g_detail_d[l_ac].fabo012,g_detail_d[l_ac].fabo013,
   g_detail_d[l_ac].fabo014,g_detail_d[l_ac].fabo015,g_detail_d[l_ac].fabo016,g_detail_d[l_ac].fabo017
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
      #161228-00013#1--add--s--
      IF g_bgjob = "T" THEN
         LET g_detail_d[l_ac].sel = "Y"
      END IF
      #161228-00013#1--add--e--
      #end add-point
      
      CALL afap270_detail_show()      
 
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
   FREE afap270_sel
   
   LET l_ac = 1
   CALL afap270_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap270.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap270_fetch()
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
 
{<section id="afap270.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap270_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap270.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap270_filter()
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
   
   CALL afap270_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap270.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap270_filter_parser(ps_field)
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
 
{<section id="afap270.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap270_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap270_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap270.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 帳別檢查
# Memo...........:
# Usage..........: CALL afap270_fabgld_chk(p_fabgld)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_fabgld_chk(p_fabgld)
   DEFINE p_fabgld    LIKE fabg_t.fabgld
   DEFINE l_glaastus  LIKE glaa_t.glaastus
   
   LET g_errno = ''
   SELECT glaastus INTO l_glaastus FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_fabgld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302' #'agl-00051' #160318-00005#9 mod
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 帳套說明
# Memo...........:
# Usage..........: CALL afap270_fabgld_desc(p_fabgld)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_fabgld_desc(p_fabgld)
   DEFINE p_fabgld    LIKE fabg_t.fabgld
   
   SELECT glaacomp,glaa004 INTO g_master.fabgcomp,g_glaa004 FROM glaa_t 
   WHERE glaaent=g_enterprise AND glaald= p_fabgld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabgld 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabgld_desc=g_rtn_fields[1]
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.fabgcomp 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabgcomp_desc=g_rtn_fields[1]
   DISPLAY BY NAME g_master.fabgld_desc,g_master.fabgcomp,g_master.fabgcomp_desc
END FUNCTION

################################################################################
# Descriptions...: 顯示單身2資料
# Memo...........:
# Usage..........: CALL afap270_b_fill2()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_b_fill2()
DEFINE l_wc   STRING

   IF l_ac<1 THEN
      RETURN
   END IF
   IF cl_null(g_master.wc) THEN
      LET g_master.wc=" 1=1"
   END IF    
   LET g_sql="SELECT fabgdocno,faboseq,fabg007,fabg006,fabo024,fabo010,fabo009,",
             "       fabo012,fabo013,fabo014,fabo015,fabo016,fabo017",
             "  FROM fabg_t,fabo_t",
             " WHERE fabgent=faboent AND fabgld=fabold AND fabgdocno=fabodocno AND fabgent=?",
#             "   AND fabgld='",g_master.fabgld,"' AND fabg005='4' AND fabgstus='Y' ",  #20141120 mark
             "   AND fabgld='",g_master.fabgld,"' AND fabg005='4' AND (fabgstus='Y' OR fabgstus='S') ",  #20141120 add             
             "   AND fabg015='",g_detail_d[l_ac].fabg015,"' AND fabg013='",g_detail_d[l_ac].fabg013,"'"
   IF g_master.fabg005 = '4' THEN 
      #異動單號
      IF NOT cl_null(g_detail_d[l_ac].fabgdocno) THEN
         LET g_sql=g_sql," AND fabgdocno='",g_detail_d[l_ac].fabgdocno,"' "
      END IF
      #單據日期
      IF NOT cl_null(g_detail_d[l_ac].fabgdocdt) THEN
         LET g_sql=g_sql," AND fabgdocdt='",g_detail_d[l_ac].fabgdocdt,"' "
      END IF
   ELSE
      #異動單號
      IF NOT cl_null(g_detail_d[l_ac].fabgdocno) THEN
         LET g_sql=g_sql," AND fabg019='",g_detail_d[l_ac].fabgdocno,"' "
      END IF   
   END IF   

   #帳款客戶
   IF NOT cl_null(g_detail_d[l_ac].fabg006) THEN
      LET g_sql=g_sql," AND fabg006='",g_detail_d[l_ac].fabg006,"' "
   END IF
   
   IF NOT cl_null(g_fabgdocno) THEN
      LET g_sql = g_sql," AND fabgdocno ='",g_fabgdocno,"'"
   END IF
   
   IF g_master.fabg005 = '4' THEN 
      LET g_sql=g_sql," AND ",g_master.wc   
   ELSE 
      LET l_wc = ""
      LET l_wc = cl_replace_str(g_master.wc,'fabgdocno','fabg019')
      LET g_sql=g_sql," AND ",l_wc   
   END IF
   PREPARE afap270_sel2 FROM g_sql
   DECLARE b_fill2_curs CURSOR FOR afap270_sel2
   
   CALL g_fabo_d.clear()
   LET l_ac2 = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill2_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into
   g_fabo_d[l_ac2].fabgdocno,g_fabo_d[l_ac2].faboseq,g_fabo_d[l_ac2].fabg006,g_fabo_d[l_ac2].fabg007,g_fabo_d[l_ac2].fabo024,
   g_fabo_d[l_ac2].fabo010,g_fabo_d[l_ac2].fabo009,g_fabo_d[l_ac2].fabo012,g_fabo_d[l_ac2].fabo013,
   g_fabo_d[l_ac2].fabo014,g_fabo_d[l_ac2].fabo015,g_fabo_d[l_ac2].fabo016,g_fabo_d[l_ac2].fabo017
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      CALL afap270_fabo024_desc(g_fabo_d[l_ac2].fabo024) RETURNING g_fabo_d[l_ac2].fabo024_desc
      
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
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
       
   LET g_detail_cnt = l_ac2 - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   CALL g_fabo_d.deleteElement(g_fabo_d.getLength())
   CLOSE b_fill2_curs
   FREE afap270_sel2
   
END FUNCTION

################################################################################
# Descriptions...: 顯示單身3資料
# Memo...........:
# Usage..........: CALL afap270_b_fill3()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_b_fill3()
   
   IF l_ac<1 THEN
      RETURN
   END IF
   IF cl_null(g_master.wc) THEN
      LET g_master.wc=" 1=1"
   END IF
   #160426-00014#45--mark--str--lujh
   #LET g_sql="SELECT fabgdocno,fabuseq,fabg007,fabg006,fabu022,fabu010,fabu009,",
   #          "       fabu012,fabu013,fabu014,fabu015,fabu016,fabu017",
   #          "  FROM fabg_t,fabu_t",
   #          " WHERE fabgent=fabuent AND fabgld=fabuld AND fabgdocno=fabudocno AND fabgent=?",
   #          "   AND fabgld='",g_master.fabgld,"' AND fabg005='17' AND fabgstus='Y' "       
   #          #"   AND fabu010='",g_detail_d[l_ac].fabg015,"' AND fabu009='",g_detail_d[l_ac].fabg013,"'"
   #160426-00014#45--mark--end--lujh
   
   #160426-00014#45--add--str--lujh   
   LET g_sql="SELECT fabgdocno,facaseq,fabg007,fabg006,faca023,fabg015,faca010,",
             "       faca011,faca012,faca013,faca014,faca015,faca016",
             "  FROM fabg_t,faca_t",
             " WHERE fabgent = facaent ",
             "   AND fabgld = facald ",
             "   AND fabgdocno = facadocno ",
             "   AND fabgent = ? ",
             "   AND fabgld = '",g_master.fabgld,"'",
             "   AND fabg005 = '",g_master.fabg005,"'",
             "   AND fabgstus IN ('Y','S') "  
   #160426-00014#45--add--end--lujh 
 
   #異動單號
   IF NOT cl_null(g_detail_d[l_ac].fabgdocno) THEN
      LET g_sql=g_sql," AND fabgdocno='",g_detail_d[l_ac].fabgdocno,"' "
   END IF
   #單據日期
   IF NOT cl_null(g_detail_d[l_ac].fabgdocdt) THEN
      LET g_sql=g_sql," AND fabgdocdt='",g_detail_d[l_ac].fabgdocdt,"' "
   END IF

   #帳款客戶
   IF NOT cl_null(g_detail_d[l_ac].fabg006) THEN
      LET g_sql=g_sql," AND fabg006='",g_detail_d[l_ac].fabg006,"' "
   END IF
   
   IF NOT cl_null(g_fabgdocno) THEN
      LET g_sql = g_sql," AND fabgdocno ='",g_fabgdocno,"'"
   END IF
   
   LET g_sql=g_sql," AND ",g_master.wc  
  
 
   PREPARE afap270_sel3 FROM g_sql
   DECLARE b_fill3_curs CURSOR FOR afap270_sel3
   
   #CALL g_fabu_d.clear()   #160426-00014#45 mark lujh
   CALL g_faca_d.clear()    #160426-00014#45 add lujh
   LET l_ac3 = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill3_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into
   #160426-00014#45--mark--str--lujh
   #g_fabu_d[l_ac3].fabgdocno,g_fabu_d[l_ac3].fabuseq,g_fabu_d[l_ac3].fabg006,g_fabu_d[l_ac3].fabg007,g_fabu_d[l_ac3].fabu022,
   #g_fabu_d[l_ac3].fabu010,g_fabu_d[l_ac3].fabu009,g_fabu_d[l_ac3].fabu012,g_fabu_d[l_ac3].fabu013,
   #g_fabu_d[l_ac3].fabu014,g_fabu_d[l_ac3].fabu015,g_fabu_d[l_ac3].fabu016,g_fabu_d[l_ac3].fabu017
   #160426-00014#45--mark--end--lujh
   
   #160426-00014#45--add--str--lujh   
   g_faca_d[l_ac3].fabgdocno,g_faca_d[l_ac3].facaseq,g_faca_d[l_ac3].fabg007,
   g_faca_d[l_ac3].fabg006  ,g_faca_d[l_ac3].faca023,g_faca_d[l_ac3].fabg015,
   g_faca_d[l_ac3].faca010  ,g_faca_d[l_ac3].faca011,g_faca_d[l_ac3].faca012,
   g_faca_d[l_ac3].faca013  ,g_faca_d[l_ac3].faca014,g_faca_d[l_ac3].faca015,
   g_faca_d[l_ac3].faca016
   #160426-00014#45--add--end--lujh 
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      #CALL afap270_fabo024_desc(g_fabu_d[l_ac3].fabu022) RETURNING g_fabu_d[l_ac3].fabu022_desc  #160426-00014#45 mark lujh
      CALL afap270_fabo024_desc(g_faca_d[l_ac3].faca023) RETURNING g_faca_d[l_ac3].faca023_desc   #160426-00014#45 add lujh
      
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
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
       
   LET g_detail_cnt = l_ac3 - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count

   #CALL g_fabu_d.deleteElement(g_fabu_d.getLength())   #160426-00014#45 mark lujh
   CALL g_faca_d.deleteElement(g_faca_d.getLength())    #160426-00014#45 add lujh
   CLOSE b_fill3_curs
   FREE afap270_sel3
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afap270_fabo024_desc(p_fabo024)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_fabo024_desc(p_fabo024)
   DEFINE p_fabo024      LIKE fabo_t.fabo024
   DEFINE r_desc         LIKE glacl_t.glacl004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = p_fabo024
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 產生應收賬款
# Memo...........:
# Usage..........: CALL afap270_execute()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_execute()
   DEFINE l_flag         LIKE type_t.num5
   DEFINE l_para_data    LIKE xrca_t.xrcadocdt
   DEFINE l_para_data1   LIKE xrca_t.xrcadocdt
   DEFINE l_ooef004      LIKE ooef_t.ooef004
   DEFINE l_success      LIKE type_t.num5
   #20141120
   DEFINE l_fabgsite     LIKE fabg_t.fabgsite 
   DEFINE l_colname_1     STRING   
   DEFINE l_colname_2     STRING   
   DEFINE l_colname_3     STRING   
   DEFINE l_colname_4     STRING   
   DEFINE l_comment_1     STRING   
   DEFINE l_comment_2     STRING   
   DEFINE l_comment_3     STRING   
   DEFINE l_comment_4     STRING 
   DEFINE l_site          LIKE fabg_t.fabgsite 
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_year          LIKE type_t.num5    
   #20141120   
   #20141226 add by chenying
   DEFINE l_xrcacomp      LIKE xrca_t.xrcacomp
   DEFINE l_xrca003       LIKE xrca_t.xrca003
   DEFINE l_xrca003_desc  STRING
   DEFINE l_xrca001       LIKE xrca_t.xrca001
   DEFINE g_wc_apcald     STRING
   DEFINE ls_wc           STRING
   DEFINE g_bookno        LIKE glaa_t.glaald
   DEFINE l_apcacomp      LIKE apca_t.apcacomp
   #20141226 add by chenying
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   
   #(1)判斷是否有勾選要拋轉的資料，沒有勾選提示用戶，勾選了進行拋轉操作
   LET l_flag=FALSE
   FOR l_ac=1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel='Y' THEN
         LET l_flag=TRUE
         EXIT FOR
      END IF
   END FOR
   
   IF l_flag=FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00172'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #20141120 add by chenying 
   #现行年月与关账日期检查
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgdocno")    RETURNING l_colname_1,l_comment_1   
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgld")       RETURNING l_colname_2,l_comment_2
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgsite")     RETURNING l_colname_4,l_comment_4   
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgdocdt")    RETURNING l_colname_3,l_comment_3   
   LET g_coll_title[1] = l_colname_1
   LET g_coll_title[2] = l_colname_2
   LET g_coll_title[3] = l_colname_3
   LET g_coll_title[4] = l_colname_4
   
   LET g_success = TRUE
   FOR l_ac=1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel='Y' THEN
         SELECT fabgsite INTO l_fabgsite FROM fabg_t WHERE fabgent = g_enterprise
            AND fabgdocno = g_detail_d[l_ac].fabgdocno AND fabgld = g_master.fabgld
         SELECT glaacomp INTO l_site FROM glaa_t
          WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
         CALL cl_get_para(g_enterprise,l_site,'S-FIN-9018') RETURNING l_year
         CALL cl_get_para(g_enterprise,l_site,'S-FIN-9019') RETURNING l_month
         IF l_year <> YEAR(g_detail_d[l_ac].fabgdocdt) OR l_month <> MONTH(g_detail_d[l_ac].fabgdocdt)  THEN          
            LET g_errparam.code = "afa-00283"  
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = ''
            LET g_errparam.coll_vals[1] = g_detail_d[l_ac].fabgdocno
            LET g_errparam.coll_vals[2] = g_master.fabgld 
            LET g_errparam.coll_vals[3] = l_fabgsite
            LET g_errparam.coll_vals[4] = g_detail_d[l_ac].fabgdocdt
            LET g_errparam.sqlerr = SQLCA.SQLCODE  
            CALL cl_err()
            LET g_success = FALSE       
         END IF 
      END IF
   END FOR
   CALL cl_err_collect_show()  #显示错误讯息汇总
   IF g_success = FALSE THEN
      RETURN
   END IF
   #20141120 add by chenying
   
   #(2)開啟窗口錄入拋轉單別等資料
   INITIALIZE g_input.* TO NULL
   
   OPEN WINDOW w_afap270_s01 WITH FORM cl_ap_formpath("afa","afap270_s01")
   
   IF g_master.fabg005='44' THEN #調撥單   #160426-00014#44 change 17 to 44 lujh
      CALL cl_set_comp_visible("master_gen1",TRUE)
      CALL cl_set_comp_visible("master",FALSE)
   ELSE
      CALL cl_set_comp_visible("master_gen1",FALSE)
      CALL cl_set_comp_visible("master",TRUE)
   END IF
  # SELECT ooef004 INTO l_ooef004 from ooef_t where ooefent = g_enterprise AND ooef001 = g_master.fabgcomp
    SELECT glaa024 INTO l_glaa024 FROM glaa_t  WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
   LET INT_FLAG = FALSE  
   
   CALL s_axrt300_create_tmp() #20141226 add by chenying
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
             #輸入開始
         INPUT BY NAME g_input.xrcasite,g_input.xrcald,g_input.xrcadocno,g_input.xrcadocdt,g_input.flag,
                       g_input.apcasite,g_input.apcald,g_input.apcadocno,g_input.apcadocdt,g_input.flag1
            ATTRIBUTE(WITHOUT DEFAULTS)
       
            BEFORE INPUT
               LET g_input.flag='N'
               LET g_input.xrcadocdt=g_today
               LET g_input.apcadocdt=g_today
               DISPLAY BY NAME g_input.xrcadocdt,g_input.apcadocdt
               
               #20141226 add by chenying
               IF g_master.fabg005='4' OR g_master.fabg005='43' THEN #出售單   #160426-00014#45 OR g_master.fabg005='43' add lujh
                  #應收
                 ##################################################mark by huangtao\默认带afap270的账务中心及账套
                 #CALL s_axrt300_ins_default('xrca',g_bookno) 
                 #  RETURNING l_success,g_input.xrcasite,g_input.xrcasite_desc,g_input.xrcald,g_input.xrcald_desc,
                 #            l_xrcacomp,l_xrca003,l_xrca003_desc,l_xrca001,g_input.xrcadocdt
                 LET g_input.xrcasite = g_master.fabgcomp
                 LET g_input.xrcald = g_master.fabgld
                 LET g_input.xrcadocdt = g_today
                 CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc
                 CALL s_desc_get_ld_desc(g_input.xrcald) RETURNING g_input.xrcald_desc
                 #################################################mark by huangtao
                  DISPLAY BY NAME g_input.xrcasite,g_input.xrcasite_desc,g_input.xrcald,g_input.xrcald_desc,g_input.xrcadocdt
                  #161215-00044#1---modify----begin-----------------
                  #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
                  glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                  glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                  glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
                  glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
                  glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
                  #161215-00044#1---modify----end-----------------
                  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.xrcald
               END IF
               
               IF g_master.fabg005='44' THEN #調撥單    #160426-00014#44 change 17 to 44 lujh
                  #應付
                 #############################################mark by huangtao
                 #CALL s_aap_get_default_apcasite('','','') RETURNING l_success,g_errno,g_input.apcasite,g_input.apcald,l_apcacomp 
                 #CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                 ##設定帳別相關預設值
                 #IF NOT cl_null(g_input.apcald) THEN
                 #   CALL s_desc_get_ld_desc(g_input.apcald)  RETURNING g_input.apcald_desc
                 #END IF
                 LET g_input.apcasite = g_master.fabgcomp
                 LET g_input.apcald = g_master.fabgld
                 LET g_input.apcadocdt = g_today
                 CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                 CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
                 #############################################mark by huangtao                  
                  DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc,g_input.apcald,g_input.apcald_desc,g_input.apcadocdt
                  #161215-00044#1---modify----begin-----------------
                  #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
                  glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                  glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                  glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
                  glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
                  glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
                  #161215-00044#1---modify----end-----------------
                  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.apcald               
               END IF
               #20141226 add by chenying
               
#               CALL cl_get_para(g_enterprise,g_site,'S-FIN-2007') RETURNING l_para_data  #20141226 mod by chenying
               CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2007') RETURNING l_para_data   #20141226 add by chenying
               IF g_today>l_para_data THEN
                  LET g_input.xrcadocdt=g_today
               END IF
               IF g_master.fabg005='17' THEN
                  LET g_input.flag1='N'
                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-3007') RETURNING l_para_data1
                  IF g_today>l_para_data1 THEN
                     LET g_input.apcadocdt=g_today
                  END IF
               END IF
               
            AFTER FIELD xrcasite
               IF NOT cl_null(g_input.xrcasite) THEN 
#                  IF NOT ap_chk_isExist(g_input.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1'  ",'axr-00018',1) THEN 
#                     LET g_input.xrcasite = ''
#                     LET g_input.xrcasite_desc=''
#                     DISPLAY BY NAME g_input.xrcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT ap_chk_isExist(g_input.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrahstus = 'Y' ",'axr-00019',1) THEN 
#                     LET g_input.xrcasite = ''
#                     LET g_input.xrcasite_desc=''
#                     DISPLAY BY NAME g_input.xrcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT ap_chk_isExist(g_input.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' ",'axr-00020',1) THEN 
#                     LET g_input.xrcasite = ''
#                     LET g_input.xrcasite_desc=''
#                     DISPLAY BY NAME g_input.xrcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF 
#                  IF NOT ap_chk_isExist(g_input.xrcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' AND xrah004 = (SELECT ooag004 FROM ooag_t WHERE ooagent = '"||g_enterprise||"' AND ooag001 ='"||g_user||"')",'axr-00069',1) THEN 
#                     LET g_input.xrcasite = ''
#                     LET g_input.xrcasite_desc=''
#                     DISPLAY BY NAME g_input.xrcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','N','',g_input.xrcadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.xrcasite = ''
                     LET g_input.xrcasite_desc=''
                     DISPLAY BY NAME g_input.xrcasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc
               DISPLAY BY NAME g_input.xrcasite_desc
               
            AFTER FIELD xrcald
               IF NOT cl_null(g_input.xrcald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,g_input.xrcald,g_user,'3','N','',g_input.xrcadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_desc_get_ld_desc(g_input.xrcald) RETURNING g_input.xrcald_desc
                  DISPLAY BY NAME g_input.xrcald_desc
               END IF
            
            AFTER FIELD xrcadocno
               IF NOT cl_null(g_input.xrcadocno) THEN
                  SELECT glaa024 INTO l_glaa024 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
#                  IF NOT s_aooi200_chk_slip(g_master.fabgcomp,l_ooef004,g_input.xrcadocno,'axrt330') THEN   #mark by yangxf
                  IF NOT s_aooi200_fin_chk_slip(g_input.xrcald,l_glaa024,g_input.xrcadocno,'axrt330') THEN   #add by yangxf
                     LET g_input.xrcadocno = ''
                     NEXT FIELD xrcadocno
                  END IF                         
               END IF 
               
            AFTER FIELD xrcadocdt
               IF NOT cl_null(g_input.xrcadocdt) THEN
                  IF g_input.xrcadocdt < l_para_data THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "asf-00008"
                     LET g_errparam.extend = g_input.xrcadocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD xrcadocdt
                  END IF 
               END IF
               
            AFTER FIELD apcasite
#               IF NOT cl_null(g_input.apcasite) THEN
#                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_master.fabgld,g_user,3,'N','',g_input.apcadocdt) RETURNING l_success,g_errno
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#      
#                     LET g_input.apcasite = ''
#                     NEXT FIELD apcasite
#                  END IF
#               END IF
               IF NOT cl_null(g_input.apcasite) THEN 
#                  IF NOT ap_chk_isExist(g_input.apcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1'  ",'axr-00018',1) THEN 
#                     LET g_input.apcasite = ''
#                     LET g_input.apcasite_desc=''
#                     DISPLAY BY NAME g_input.apcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT ap_chk_isExist(g_input.apcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrahstus = 'Y' ",'axr-00019',1) THEN 
#                     LET g_input.apcasite = ''
#                     LET g_input.apcasite_desc=''
#                     DISPLAY BY NAME g_input.apcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
#                  IF NOT ap_chk_isExist(g_input.apcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' ",'axr-00020',1) THEN 
#                     LET g_input.apcasite = ''
#                     LET g_input.apcasite_desc=''
#                     DISPLAY BY NAME g_input.apcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF 
#                  IF NOT ap_chk_isExist(g_input.apcasite,"SELECT COUNT(*) FROM xrah_t WHERE "||"xrahent = '" ||g_enterprise|| "' AND "||"xrah002 = ? AND xrah001 = '1' AND xrah007 = 'Y' AND xrahstus = 'Y' AND xrah004 = (SELECT ooag004 FROM ooag_t WHERE ooagent = '"||g_enterprise||"' AND ooag001 ='"||g_user||"')",'axr-00069',1) THEN 
#                     LET g_input.apcasite = ''
#                     LET g_input.apcasite_desc=''
#                     DISPLAY BY NAME g_input.apcasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_input.apcadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcasite = ''
                     LET g_input.apcasite_desc=''
                     DISPLAY BY NAME g_input.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
               DISPLAY BY NAME g_input.apcasite_desc
               
            AFTER FIELD apcald
               IF NOT cl_null(g_input.apcald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_input.apcadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcald = ''
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
                  DISPLAY BY NAME g_input.apcald_desc
               END IF
            
            AFTER FIELD apcadocno
               IF NOT cl_null(g_input.apcadocno) THEN
                  SELECT glaa024 INTO l_glaa024 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
#                  IF NOT s_aooi200_chk_slip(g_master.fabgcomp,l_ooef004,g_input.xrcadocno,'aapt300') THEN   #mark by yangxf
                  #IF NOT s_aooi200_fin_chk_slip(g_input.xrcald,l_glaa024,g_input.xrcadocno,'aapt300') THEN   #add by yangxf   #160426-00014#44 mark lujh
                  IF NOT s_aooi200_fin_chk_slip(g_input.apcald,l_glaa024,g_input.apcadocno,'aapt301') THEN   #160426-00014#44 add lujh
                     LET g_input.apcadocno = ''
                     NEXT FIELD apcadocno
                  END IF                         
               END IF 
               
            AFTER FIELD apcadocdt
               IF NOT cl_null(g_input.apcadocdt) THEN
                  IF g_input.apcadocdt < l_para_data1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "asf-00008"
                     LET g_errparam.extend = g_input.apcadocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD apcadocdt
                  END IF 
               END IF
            
            AFTER INPUT
            
            ON ACTION controlp INFIELD xrcasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	   		   LET g_qryparam.reqry = FALSE
      
               LET g_qryparam.default1 = g_input.xrcasite             #給予default值
               LET g_qryparam.default2 = "" # #帳務中心
              #LET g_qryparam.where = " xrah004 = (SELECT ooag004 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 ='",g_user,"')"
               LET g_qryparam.where = " ooef201 = 'Y' "  #20141226 add by chenying
               #給予arg     
              #CALL q_xrah002_1()                                #呼叫開窗
               CALL q_ooef001()
               LET g_input.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc  
               DISPLAY g_input.xrcasite,g_input.xrcasite_desc   TO xrcasite,xrcasite_desc  #顯 LET g_qryparam.where = " ooef201 = 'Y' "示到畫面上
               NEXT FIELD xrcasite                          #返回原欄位
            
            ON ACTION controlp INFIELD xrcald
               #帳別
               #開窗i段
#20141226 mod by chenying               
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.default1 = g_input.xrcald
#               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
#               LET g_qryparam.arg1 = g_user                                 #人員權限
#               LET g_qryparam.arg2 = g_dept                                 #部門權限
#               CALL q_authorised_ld()
#               LET g_input.xrcald = g_qryparam.return1
#               CALL s_desc_get_ld_desc(g_input.xrcald) RETURNING g_input.xrcald_desc
#               DISPLAY BY NAME g_input.xrcald,g_input.xrcald_desc
#               NEXT FIELD xrcald

               CALL s_fin_create_account_center_tmp()   
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_input.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL afap270_get_ooef001_wc(ls_wc) RETURNING ls_wc  
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xrcald             #給予default值
               IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
               ELSE
                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
               END IF
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()                                  #呼叫開窗
               LET g_input.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               CALL s_desc_get_ld_desc(g_input.xrcald) RETURNING g_input.xrcald_desc
               DISPLAY BY NAME g_input.xrcald,g_input.xrcald_desc
#20141226 mod by chenying                 
            
            ON ACTION controlp INFIELD xrcadocno
	   		   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	   		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xrcadocno             #給予default值
               #給予arg
               LET g_qryparam.arg1 = l_glaa024 
               LET g_qryparam.arg2 = "axrt330" 
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_input.xrcadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_input.xrcadocno TO xrcadocno              #顯示到畫面上
               NEXT FIELD xrcadocno  
            
            ON ACTION controlp INFIELD apcasite
                #帳務中心            
                #開窗i段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
			       LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_input.apcasite       #給予default值
               #LET g_qryparam.where = " xrah004 = (SELECT ooag004 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 ='",g_user,"')"
               #CALL q_xrah002_2()                                #呼叫開窗
                CALL q_ooef001()
                LET g_input.apcasite = g_qryparam.return1        #將開窗取得的值回傳到變數
                CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc                    
                DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
                NEXT FIELD apcasite    
         
            ON ACTION controlp INFIELD apcald
               #帳別
               #開窗i段
#20141226 mod by chenying                 
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.default1 = g_input.apcald
#               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
#               LET g_qryparam.arg1 = g_user                                 #人員權限
#               LET g_qryparam.arg2 = g_dept                                 #部門權限
#               CALL q_authorised_ld()
#               LET g_input.apcald = g_qryparam.return1
#               CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
#               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc
#               NEXT FIELD apcald

               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcald        
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                 #部門權限
               CALL s_fin_create_account_center_tmp() 
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_input.apcadocdt,'1')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald               
               LET g_qryparam.where = " glaald IN ",g_wc_apcald
               CALL q_authorised_ld()                                 
               LET g_input.apcald = g_qryparam.return1                  
               CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc
               NEXT FIELD apcald 
#20141226 mod by chenying               
            
            ON ACTION controlp INFIELD apcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcadocno             #給予default值
               #給予arg
               LET g_qryparam.arg1 = l_glaa024 
               LET g_qryparam.arg2 = "aapt301"    #160426-00014#44 change aapt300 to aapt301
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_input.apcadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_input.apcadocno TO apcadocno              #顯示到畫面上
               NEXT FIELD apcadocno      
         END INPUT
      
         ON ACTION cancel
            LET INT_FLAG = TRUE 
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG = TRUE 
            EXIT DIALOG
      
         ON ACTION exit
            LET INT_FLAG = TRUE 
            EXIT DIALOG
            
         ON ACTION accept
            IF NOT cl_null(g_input.docno_s) OR NOT cl_null(g_input.docno_e) OR
               (g_master.fabg005='17' AND (NOT cl_null(g_input.docno_s1) OR NOT cl_null(g_input.docno_e1))) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00408'
               LET g_errparam.extend = g_input.docno_s
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               CALL afap270_p()
               #在畫面中顯示拋轉的起始截止單號
               DISPLAY BY NAME g_input.docno_s,g_input.docno_e,g_input.docno_s1,g_input.docno_e1
               IF NOT cl_null(g_argv[02]) THEN
                  LET INT_FLAG=TRUE
                  EXIT DIALOG
               END IF
            END IF
            ACCEPT DIALOG
      END DIALOG
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
   END WHILE
   
   #畫面關閉
   CLOSE WINDOW w_afap270_s01   
   
END FUNCTION

################################################################################
# Descriptions...: 插入應收帳款(xrca_t xrcb_t xrcc_t xrcd_t)
# Memo...........:
# Usage..........: CALL afap270_xrca_ins()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_xrca_ins()
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_fabg        RECORD LIKE fabg_t.*
   #DEFINE l_fabo        RECORD LIKE fabo_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020 #資產性質
       END RECORD
   DEFINE l_fabo RECORD  #資產出售單身檔
       faboent LIKE fabo_t.faboent, #企業編碼
       fabold LIKE fabo_t.fabold, #帳套
       fabodocno LIKE fabo_t.fabodocno, #異動單號
       faboseq LIKE fabo_t.faboseq, #項次
       fabo000 LIKE fabo_t.fabo000, #資產類型
       fabo001 LIKE fabo_t.fabo001, #財產編號
       fabo002 LIKE fabo_t.fabo002, #附號
       fabo003 LIKE fabo_t.fabo003, #卡片編號
       fabo004 LIKE fabo_t.fabo004, #未折減額
       fabo005 LIKE fabo_t.fabo005, #單位
       fabo006 LIKE fabo_t.fabo006, #單價
       fabo007 LIKE fabo_t.fabo007, #調撥/出售數量
       fabo008 LIKE fabo_t.fabo008, #成本
       fabo009 LIKE fabo_t.fabo009, #稅別
       fabo010 LIKE fabo_t.fabo010, #交易幣別
       fabo011 LIKE fabo_t.fabo011, #原幣匯率
       fabo012 LIKE fabo_t.fabo012, #原幣未稅金額
       fabo013 LIKE fabo_t.fabo013, #原幣稅額
       fabo014 LIKE fabo_t.fabo014, #原幣應收金額
       fabo015 LIKE fabo_t.fabo015, #本幣未稅金額
       fabo016 LIKE fabo_t.fabo016, #本幣稅額
       fabo017 LIKE fabo_t.fabo017, #本幣應收金額
       fabo018 LIKE fabo_t.fabo018, #處置成本
       fabo019 LIKE fabo_t.fabo019, #處置累折
       fabo020 LIKE fabo_t.fabo020, #處置減值準備
       fabo021 LIKE fabo_t.fabo021, #處置本期折舊
       fabo022 LIKE fabo_t.fabo022, #處置未折減額
       fabo023 LIKE fabo_t.fabo023, #異動原因
       fabo024 LIKE fabo_t.fabo024, #異動科目
       fabo025 LIKE fabo_t.fabo025, #處置預留殘值
       fabo026 LIKE fabo_t.fabo026, #累折科目
       fabo027 LIKE fabo_t.fabo027, #減值準備科目
       fabo028 LIKE fabo_t.fabo028, #資產科目
       fabo029 LIKE fabo_t.fabo029, #應收帳款科目
       fabo030 LIKE fabo_t.fabo030, #稅額科目
       fabo031 LIKE fabo_t.fabo031, #營運據點
       fabo032 LIKE fabo_t.fabo032, #部門
       fabo033 LIKE fabo_t.fabo033, #利潤/成本中心
       fabo034 LIKE fabo_t.fabo034, #區域
       fabo035 LIKE fabo_t.fabo035, #交易客商
       fabo036 LIKE fabo_t.fabo036, #帳款客商
       fabo037 LIKE fabo_t.fabo037, #客群
       fabo038 LIKE fabo_t.fabo038, #人員
       fabo039 LIKE fabo_t.fabo039, #專案編號
       fabo040 LIKE fabo_t.fabo040, #WBS
       fabo041 LIKE fabo_t.fabo041, #帳款編號
       fabo042 LIKE fabo_t.fabo042, #摘要
       fabo043 LIKE fabo_t.fabo043, #調出管理組織
       fabo044 LIKE fabo_t.fabo044, #調出所有組織
       fabo045 LIKE fabo_t.fabo045, #調出核算組織
       fabo046 LIKE fabo_t.fabo046, #調入管理組織
       fabo047 LIKE fabo_t.fabo047, #調入所有組織
       fabo048 LIKE fabo_t.fabo048, #調入核算組織
       fabo049 LIKE fabo_t.fabo049, #處分損益
       fabo050 LIKE fabo_t.fabo050, #應收帳款單號
       fabo051 LIKE fabo_t.fabo051, #交易價格差異
       fabo052 LIKE fabo_t.fabo052, #應付帳款單號
       fabo053 LIKE fabo_t.fabo053, #已計提減值準備
       fabo054 LIKE fabo_t.fabo054, #經營方式
       fabo055 LIKE fabo_t.fabo055, #通路
       fabo056 LIKE fabo_t.fabo056, #品牌
       fabo060 LIKE fabo_t.fabo060, #自由核算項一
       fabo061 LIKE fabo_t.fabo061, #自由核算項二
       fabo062 LIKE fabo_t.fabo062, #自由核算項三
       fabo063 LIKE fabo_t.fabo063, #自由核算項四
       fabo064 LIKE fabo_t.fabo064, #自由核算項五
       fabo065 LIKE fabo_t.fabo065, #自由核算項六
       fabo066 LIKE fabo_t.fabo066, #自由核算項七
       fabo067 LIKE fabo_t.fabo067, #自由核算項八
       fabo068 LIKE fabo_t.fabo068, #自由核算項九
       fabo069 LIKE fabo_t.fabo069, #自由核算項十
       fabo101 LIKE fabo_t.fabo101, #本位幣二幣別
       fabo102 LIKE fabo_t.fabo102, #本位幣二匯率
       fabo103 LIKE fabo_t.fabo103, #本位幣二未稅金額
       fabo104 LIKE fabo_t.fabo104, #本位幣二稅額
       fabo105 LIKE fabo_t.fabo105, #本位幣二應收金額
       fabo106 LIKE fabo_t.fabo106, #本位幣二處份損益
       fabo107 LIKE fabo_t.fabo107, #本位幣二處置成本
       fabo108 LIKE fabo_t.fabo108, #本位幣二處置累折
       fabo109 LIKE fabo_t.fabo109, #本位幣二處置減值準備
       fabo110 LIKE fabo_t.fabo110, #本位幣二本期處置折舊
       fabo111 LIKE fabo_t.fabo111, #本位幣二處置後未折減額
       fabo150 LIKE fabo_t.fabo150, #本位幣三幣別
       fabo151 LIKE fabo_t.fabo151, #本位幣三匯率
       fabo152 LIKE fabo_t.fabo152, #本位幣三未稅金額
       fabo153 LIKE fabo_t.fabo153, #本位幣三稅額
       fabo154 LIKE fabo_t.fabo154, #本位幣三應收金額
       fabo155 LIKE fabo_t.fabo155, #本位幣三處份損益
       fabo156 LIKE fabo_t.fabo156, #本位幣三處置成本
       fabo157 LIKE fabo_t.fabo157, #本位幣三處置累折
       fabo158 LIKE fabo_t.fabo158, #本位幣三處置減值準備
       fabo159 LIKE fabo_t.fabo159, #本位幣三本期處置折舊
       fabo160 LIKE fabo_t.fabo160, #本位幣三處置後未折減額
       faboud001 LIKE fabo_t.faboud001, #自定義欄位(文字)001
       faboud002 LIKE fabo_t.faboud002, #自定義欄位(文字)002
       faboud003 LIKE fabo_t.faboud003, #自定義欄位(文字)003
       faboud004 LIKE fabo_t.faboud004, #自定義欄位(文字)004
       faboud005 LIKE fabo_t.faboud005, #自定義欄位(文字)005
       faboud006 LIKE fabo_t.faboud006, #自定義欄位(文字)006
       faboud007 LIKE fabo_t.faboud007, #自定義欄位(文字)007
       faboud008 LIKE fabo_t.faboud008, #自定義欄位(文字)008
       faboud009 LIKE fabo_t.faboud009, #自定義欄位(文字)009
       faboud010 LIKE fabo_t.faboud010, #自定義欄位(文字)010
       faboud011 LIKE fabo_t.faboud011, #自定義欄位(數字)011
       faboud012 LIKE fabo_t.faboud012, #自定義欄位(數字)012
       faboud013 LIKE fabo_t.faboud013, #自定義欄位(數字)013
       faboud014 LIKE fabo_t.faboud014, #自定義欄位(數字)014
       faboud015 LIKE fabo_t.faboud015, #自定義欄位(數字)015
       faboud016 LIKE fabo_t.faboud016, #自定義欄位(數字)016
       faboud017 LIKE fabo_t.faboud017, #自定義欄位(數字)017
       faboud018 LIKE fabo_t.faboud018, #自定義欄位(數字)018
       faboud019 LIKE fabo_t.faboud019, #自定義欄位(數字)019
       faboud020 LIKE fabo_t.faboud020, #自定義欄位(數字)020
       faboud021 LIKE fabo_t.faboud021, #自定義欄位(日期時間)021
       faboud022 LIKE fabo_t.faboud022, #自定義欄位(日期時間)022
       faboud023 LIKE fabo_t.faboud023, #自定義欄位(日期時間)023
       faboud024 LIKE fabo_t.faboud024, #自定義欄位(日期時間)024
       faboud025 LIKE fabo_t.faboud025, #自定義欄位(日期時間)025
       faboud026 LIKE fabo_t.faboud026, #自定義欄位(日期時間)026
       faboud027 LIKE fabo_t.faboud027, #自定義欄位(日期時間)027
       faboud028 LIKE fabo_t.faboud028, #自定義欄位(日期時間)028
       faboud029 LIKE fabo_t.faboud029, #自定義欄位(日期時間)029
       faboud030 LIKE fabo_t.faboud030, #自定義欄位(日期時間)030
       fabo112 LIKE fabo_t.fabo112, #本位幣二處置預留殘值
       fabo161 LIKE fabo_t.fabo161  #本位幣三處置預留殘值
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_xrcbseq     LIKE xrcb_t.xrcbseq
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   #151125-00006#1--add--s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0030            LIKE type_t.chr1
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_conf_success        LIKE type_t.chr1
   #151125-00006#1--add--e
   DEFINE l_glaa003       LIKE glaa_t.glaa003 #160616-00005#3 add
   DEFINE l_glaa024       LIKE glaa_t.glaa024 #160616-00005#3 add
   DEFINE l_oodb008       LIKE oodb_t.oodb008 #161021-00053#1 add
   
   INITIALIZE l_fabg.* TO NULL
   LET l_fabg.fabgld=g_master.fabgld
   LET l_fabg.fabg013=g_detail_d[l_ac].fabg013 #稅別
   LET l_fabg.fabg015=g_detail_d[l_ac].fabg015 #幣別
   #依單號匯總
   IF g_master.type='1' THEN
      LET l_fabg.fabgdocno=g_detail_d[l_ac].fabgdocno
      SELECT fabg001,fabg006,fabg007,fabg016 
        INTO l_fabg.fabg001,l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg016
        FROM fabg_t
       WHERE fabgent=g_enterprise AND fabgld=g_master.fabgld
         AND fabgdocno=g_detail_d[l_ac].fabgdocno
   ELSE #依帳款客戶匯總
      LET l_fabg.fabg006=g_detail_d[l_ac].fabg006
   END IF
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_input.xrcald
   INITIALIZE g_xrca.* TO NULL
   
   #################
   #160628-00015#1 mod s---
#   LET l_sql = "SELECT glaald,glaa024,glaa003 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND (glaald = '",g_master.fabgld,"'", #160616-00005#3 add glaa024,glaa003
#               " OR glaald IN (SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaa008 = 'Y' AND glaacomp = '",l_glaacomp,"' )) ORDER BY glaa023 "
   LET l_sql = "SELECT glaald,glaa024,glaa003 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.fabgld,"'", #160616-00005#3 add glaa024,glaa003
               " ORDER BY glaa023 "   
   #160628-00015#1 mod e---
   PREPARE pre_glaald FROM l_sql
   DECLARE sel_glaald CURSOR FOR  pre_glaald
   FOREACH  sel_glaald INTO g_xrca.xrcald,l_glaa024,l_glaa003  #160616-00005#3 add glaa024,glaa003
   #################
      #插入單頭
      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcaownid = g_user
      LET g_xrca.xrcaowndp = g_dept
      LET g_xrca.xrcacrtid = g_user
      LET g_xrca.xrcacrtdp = g_dept 
      LET g_xrca.xrcacrtdt = cl_get_current()
      LET g_xrca.xrcamodid = ""
      LET g_xrca.xrcamoddt = ""
      LET g_xrca.xrcastus = "N"
      LET g_xrca.xrcacomp = l_glaacomp
      #LET g_xrca.xrcald = g_master.fabgld  
      #單據日期
      LET g_xrca.xrcadocdt= g_input.xrcadocdt
      #单据编号
#      CALL s_aooi200_gen_docno(l_glaacomp,g_input.xrcadocno,g_input.xrcadocdt,'axrt330')      #mark by yangxf
#      CALL s_aooi200_fin_gen_docno(g_xrca.xrcald,'','',g_input.xrcadocno,g_input.xrcadocdt,'axrt330')   #add by yangxf #20150204 g_input.xrcald-->g_xrca.xrcald #160616-00005#3 mark
      CALL s_aooi200_fin_gen_docno(g_xrca.xrcald,l_glaa024,l_glaa003,g_input.xrcadocno,g_input.xrcadocdt,'axrt330') #160616-00005#3 add
      RETURNING l_success,g_xrca.xrcadocno
      IF l_success  = 0  THEN
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('','','','apm-00003',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
         CONTINUE FOREACH       #151125-00006#1--add by aiqq
      END IF 
      LET g_xrca.xrca001 = '19' #其他應收帳款
      LET g_xrca.xrcasite = g_input.xrcasite
      LET g_xrca.xrca003 = g_user          #帳務人員
      LET g_xrca.xrca004 = l_fabg.fabg006  #帳款客戶
      LET g_xrca.xrca005 = l_fabg.fabg007  #收款客戶
      LET g_xrca.xrca011 = l_fabg.fabg013  #稅別
      CALL afap270_xrca004_ref()
      LET g_xrca.xrca016 = '15'
  #   LET g_xrca.xrca017 = 1  #150917 mark
      LET g_xrca.xrca017 = 0  #150917
      LET g_xrca.xrca018 = g_detail_d[l_ac].fabgdocno
      LET g_xrca.xrca020 = 'N'     
      LET g_xrca.xrca030 = 0
      LET g_xrca.xrca031 = 0
      LET g_xrca.xrca032 = 0
      LET g_xrca.xrca037 = 'N'
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = 'N'
      LET g_xrca.xrca044 = 0
      LET g_xrca.xrca052 = 0
      #LET g_xrca.xrca060 = 1   #161021-00053#1 mark
      #161021-00053#1---add---str--
      SELECT oodb008 INTO l_oodb008
        FROM oodb_t,ooef_t 
       WHERE ooefent = oodbent AND oodb001 = ooef019 AND ooef001 = g_xrca.xrcacomp 
         AND oodbent= g_enterprise AND oodb002=g_xrca.xrca011
         
      CASE l_oodb008
         WHEN '1'
            LET g_xrca.xrca060 = 2
         WHEN '2'
            LET g_xrca.xrca060 = 1
         WHEN '3'
            LET g_xrca.xrca060 = 3
         OTHERWISE
            LET g_xrca.xrca060 = 1         
      END CASE
      #161021-00053#1---add---end--
      LET g_xrca.xrca062 = '1'
      LET g_xrca.xrca100 = l_fabg.fabg015  #交易原幣
      LET g_xrca.xrca101 = l_fabg.fabg016
      SELECT DISTINCT fabo101,fabo102,fabo150,fabo151 
        INTO g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca130,g_xrca.xrca131
      FROM fabo_t
      WHERE faboent=g_enterprise AND fabold=l_fabg.fabgld AND fabodocno=l_fabg.fabgdocno
   
      LET g_xrca.xrca103 = 0
      LET g_xrca.xrca104 = 0
      LET g_xrca.xrca106 = 0
      LET g_xrca.xrca107 = 0
      LET g_xrca.xrca108 = 0
      LET g_xrca.xrca113 = 0
      LET g_xrca.xrca114 = 0
      LET g_xrca.xrca116 = 0
      LET g_xrca.xrca117 = 0
      LET g_xrca.xrca118 = 0
      
      LET g_xrca.xrca123 = 0
      LET g_xrca.xrca124 = 0
      LET g_xrca.xrca126 = 0
      LET g_xrca.xrca127 = 0
      LET g_xrca.xrca128 = 0
   
      LET g_xrca.xrca133 = 0
      LET g_xrca.xrca134 = 0
      LET g_xrca.xrca136 = 0
      LET g_xrca.xrca137 = 0
      LET g_xrca.xrca138 = 0
   
      #161215-00044#1---modify----begin-----------------
      #INSERT INTO xrca_t VALUES (g_xrca.*)
      INSERT INTO xrca_t (xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
                          xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,
                          xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,
                          xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
                          xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,
                          xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,
                          xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
                          xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,
                          xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,
                          xrca133,xrca134,xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,xrcaud005,xrcaud006,
                          xrcaud007,xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,xrcaud015,xrcaud016,
                          xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,xrcaud025,xrcaud026,
                          xrcaud027,xrcaud028,xrcaud029,xrcaud030)
       VALUES (g_xrca.xrcaent,g_xrca.xrcaownid,g_xrca.xrcaowndp,g_xrca.xrcacrtid,g_xrca.xrcacrtdp,g_xrca.xrcacrtdt,g_xrca.xrcamodid,g_xrca.xrcamoddt,g_xrca.xrcacnfid,
               g_xrca.xrcacnfdt,g_xrca.xrcapstid,g_xrca.xrcapstdt,g_xrca.xrcastus,g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,g_xrca.xrca001,g_xrca.xrcasite,
               g_xrca.xrca003,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca006,g_xrca.xrca007,g_xrca.xrca008,g_xrca.xrca009,g_xrca.xrca010,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,g_xrca.xrca014,
               g_xrca.xrca015,g_xrca.xrca016,g_xrca.xrca017,g_xrca.xrca018,g_xrca.xrca019,g_xrca.xrca020,g_xrca.xrca021,g_xrca.xrca022,g_xrca.xrca023,g_xrca.xrca024,g_xrca.xrca025,g_xrca.xrca026,
               g_xrca.xrca028,g_xrca.xrca029,g_xrca.xrca030,g_xrca.xrca031,g_xrca.xrca032,g_xrca.xrca033,g_xrca.xrca034,g_xrca.xrca035,g_xrca.xrca036,g_xrca.xrca037,g_xrca.xrca038,g_xrca.xrca039,
               g_xrca.xrca040,g_xrca.xrca041,g_xrca.xrca042,g_xrca.xrca043,g_xrca.xrca044,g_xrca.xrca045,g_xrca.xrca046,g_xrca.xrca047,g_xrca.xrca048,g_xrca.xrca049,g_xrca.xrca050,g_xrca.xrca051,
               g_xrca.xrca052,g_xrca.xrca053,g_xrca.xrca054,g_xrca.xrca055,g_xrca.xrca056,g_xrca.xrca057,g_xrca.xrca058,g_xrca.xrca059,g_xrca.xrca060,g_xrca.xrca061,g_xrca.xrca062,g_xrca.xrca063,
               g_xrca.xrca064,g_xrca.xrca065,g_xrca.xrca066,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca106,g_xrca.xrca107,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,
               g_xrca.xrca116,g_xrca.xrca117,g_xrca.xrca118,g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca126,g_xrca.xrca127,g_xrca.xrca128,g_xrca.xrca130,g_xrca.xrca131,
               g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca136,g_xrca.xrca137,g_xrca.xrca138,g_xrca.xrcaud001,g_xrca.xrcaud002,g_xrca.xrcaud003,g_xrca.xrcaud004,g_xrca.xrcaud005,g_xrca.xrcaud006,
               g_xrca.xrcaud007,g_xrca.xrcaud008,g_xrca.xrcaud009,g_xrca.xrcaud010,g_xrca.xrcaud011,g_xrca.xrcaud012,g_xrca.xrcaud013,g_xrca.xrcaud014,g_xrca.xrcaud015,g_xrca.xrcaud016,
               g_xrca.xrcaud017,g_xrca.xrcaud018,g_xrca.xrcaud019,g_xrca.xrcaud020,g_xrca.xrcaud021,g_xrca.xrcaud022,g_xrca.xrcaud023,g_xrca.xrcaud024,g_xrca.xrcaud025,g_xrca.xrcaud026,
               g_xrca.xrcaud027,g_xrca.xrcaud028,g_xrca.xrcaud029,g_xrca.xrcaud030)
      #161215-00044#1---modify----end-----------------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('ins xrca_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'ins xrca_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
      END IF
   
      #記錄第一張應收單單號
      IF cl_null(g_input.docno_s) THEN
         LET g_input.docno_s=g_xrca.xrcadocno
      END IF
   
      #插入單身
      LET g_sql="SELECT fabodocno,faboseq,fabo001,fabo002,fabo003,fabo005,",
                "       fabo007,fabo009,fabo010,fabo034,fabo039,fabo040,fabo044,",
                "       fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,",
                "       fabo103,fabo104,fabo105,fabo152,fabo153,fabo154 ",
                "  FROM fabg_t,fabo_t",
                " WHERE fabgent=faboent AND fabgld=fabold AND fabgdocno=fabodocno AND fabgent=",g_enterprise,
#                "   AND fabgld='",g_master.fabgld,"' AND fabg005='4' AND fabgstus='Y' ",                     #20141213 mark by chenying
                "   AND fabgld='",g_master.fabgld,"' AND fabg005='4' AND (fabgstus='Y' OR fabgstus='S') ",    #20141213 add by chenying
                "   AND fabg011 IS NULL AND fabg012 IS NULL ",
                "   AND fabg015='",g_detail_d[l_ac].fabg015,"' AND fabg013='",g_detail_d[l_ac].fabg013,"'"
      IF g_master.type='1' THEN
         IF g_master.fabg005 = '4' THEN 
            LET g_sql=g_sql," AND fabgdocno='",g_detail_d[l_ac].fabgdocno,"' "
         END IF   
      ELSE
         LET g_sql=g_sql," AND fabg006='",g_detail_d[l_ac].fabg006,"' "
      END IF
      IF NOT cl_null(g_master.wc) THEN
         IF g_master.fabg005 = '4' THEN 
            LET g_sql=g_sql," AND ",g_master.wc
         ELSE
            LET l_wc = ""
            LET l_wc = cl_replace_str(g_master.wc,'fabgdocno','fabg019')
            LET g_sql=g_sql," AND ",l_wc         
         END IF    
      END IF
      LET g_sql=g_sql," ORDER BY fabodocno,faboseq"
   
      PREPARE afap270_pr1 FROM g_sql
      DECLARE afap270_cs1 CURSOR FOR afap270_pr1
      LET l_xrcbseq =0
      
      FOREACH afap270_cs1 INTO l_fabo.fabodocno,l_fabo.faboseq,l_fabo.fabo001,l_fabo.fabo002,l_fabo.fabo003,
                               l_fabo.fabo005,l_fabo.fabo007,l_fabo.fabo009,
                               l_fabo.fabo010,l_fabo.fabo034,l_fabo.fabo039,l_fabo.fabo040,l_fabo.fabo044,
                               l_fabo.fabo012,l_fabo.fabo013,l_fabo.fabo014,l_fabo.fabo015,l_fabo.fabo016,
                               l_fabo.fabo017,l_fabo.fabo103,l_fabo.fabo104,l_fabo.fabo105,l_fabo.fabo152,
                               l_fabo.fabo153,l_fabo.fabo154
      
         IF SQLCA.sqlcode THEN
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('','foreach','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'foreach'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq
            EXIT FOREACH
         END IF
         LET l_xrcbseq = l_xrcbseq + 1
         
         INITIALIZE g_xrcb.* TO NULL
         LET g_xrcb.xrcbent = g_enterprise
         LET g_xrcb.xrcbld  = g_xrca.xrcald
         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq = l_xrcbseq
         LET g_xrcb.xrcbsite= g_xrca.xrcasite    #?營運據點
         #來源組織
         SELECT faah028 INTO g_xrcb.xrcborga FROM faah_t
          WHERE faahent = g_enterprise AND faah001 = l_fabo.fabo003
            AND faah003 = l_fabo.fabo001 AND faah004 = l_fabo.fabo002
         IF g_master.fabg005='17' AND NOT cl_null(l_fabo.fabo044) THEN
            LET g_xrcb.xrcborga = l_fabo.fabo044
         END IF
         LET g_xrcb.xrcb001 = '15'          #來源類型
         LET g_xrcb.xrcb002 = l_fabo.fabodocno #來源單號
         LET g_xrcb.xrcb003 = l_fabo.faboseq   #來源項次
         LET g_xrcb.xrcb004 = ''
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = l_fabo.fabo005
         LET g_xrcb.xrcb007 = l_fabo.fabo007
         LET g_xrcb.xrcb008 = ''
         LET g_xrcb.xrcb009 = ''
         LET g_xrcb.xrcblegl= g_xrca.xrcacomp  #?核算組織
         LET g_xrcb.xrcb010 = g_xrca.xrca015
         LET g_xrcb.xrcb011 = g_xrca.xrca034
         LET g_xrcb.xrcb012 = '' #產品類別
         LET g_xrcb.xrcb013 = '' #
         LET g_xrcb.xrcb014 = ''
         LET g_xrcb.xrcb015 = l_fabo.fabo039 #專案代碼
         LET g_xrcb.xrcb016 = l_fabo.fabo040 #WBS 
         LET g_xrcb.xrcb017 = '' #預算項目
         LET g_xrcb.xrcb018 = '' #客戶編號 
         LET g_xrcb.xrcb019 = ''
         LET g_xrcb.xrcb020 = l_fabo.fabo009
         LET g_xrcb.xrcb021 = g_xrca.xrca036 
         LET g_xrcb.xrcb022 = 1  #正負值
         LET g_xrcb.xrcb023 = 'N'
         LET g_xrcb.xrcb024 = l_fabo.fabo034 #區域
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = ''
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb029 = g_xrca.xrca035  #收入會計科目
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008 #收款條件
         LET g_xrcb.xrcb100 = l_fabo.fabo010
         LET g_xrcb.xrcb101 = l_fabo.fabo014/l_fabo.fabo007 #原幣單價
         LET g_xrcb.xrcb103 = l_fabo.fabo012
         LET g_xrcb.xrcb104 = l_fabo.fabo013
         LET g_xrcb.xrcb105 = l_fabo.fabo014
         LET g_xrcb.xrcb106 = 0
         LET g_xrcb.xrcb111 = l_fabo.fabo017/l_fabo.fabo007 #本幣單價
         LET g_xrcb.xrcb113 = l_fabo.fabo015
         LET g_xrcb.xrcb114 = l_fabo.fabo016
         LET g_xrcb.xrcb115 = l_fabo.fabo017
         LET g_xrcb.xrcb116 = 0
         LET g_xrcb.xrcb117 = 0
         LET g_xrcb.xrcb118 = g_xrcb.xrcb113
         LET g_xrcb.xrcb119 = g_xrcb.xrcb115
         LET g_xrcb.xrcb123 = l_fabo.fabo103
         LET g_xrcb.xrcb124 = l_fabo.fabo104
         LET g_xrcb.xrcb125 = l_fabo.fabo105
         LET g_xrcb.xrcb126 = 0
         LET g_xrcb.xrcb133 = l_fabo.fabo152
         LET g_xrcb.xrcb134 = l_fabo.fabo153
         LET g_xrcb.xrcb135 = l_fabo.fabo154
         LET g_xrcb.xrcb136 = 0
       
         #161215-00044#1---modify----begin-----------------
         #INSERT INTO xrcb_t VALUES (g_xrcb.*)
         INSERT INTO xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
                             xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
                             xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
                             xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
                             xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
                             xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
                             xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
                             xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
                             xrcb134,xrcb135,xrcb136,xrcbud001,xrcbud002,xrcbud003,xrcbud004,xrcbud005,xrcbud006,
                             xrcbud007,xrcbud008,xrcbud009,xrcbud010,xrcbud011,xrcbud012,xrcbud013,xrcbud014,
                             xrcbud015,xrcbud016,xrcbud017,xrcbud018,xrcbud019,xrcbud020,xrcbud021,xrcbud022,
                             xrcbud023,xrcbud024,xrcbud025,xrcbud026,xrcbud027,xrcbud028,xrcbud029,xrcbud030,
                             xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107)
          VALUES (g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,
                  g_xrcb.xrcb005,g_xrcb.xrcb006,g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcblegl,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,g_xrcb.xrcb013,
                   g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,
                   g_xrcb.xrcb024,g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,
                   g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,g_xrcb.xrcb043,
                   g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,
                   g_xrcb.xrcb102,g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,
                   g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,g_xrcb.xrcb133,
                   g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcbud001,g_xrcb.xrcbud002,g_xrcb.xrcbud003,g_xrcb.xrcbud004,g_xrcb.xrcbud005,g_xrcb.xrcbud006,
                   g_xrcb.xrcbud007,g_xrcb.xrcbud008,g_xrcb.xrcbud009,g_xrcb.xrcbud010,g_xrcb.xrcbud011,g_xrcb.xrcbud012,g_xrcb.xrcbud013,g_xrcb.xrcbud014,
                   g_xrcb.xrcbud015,g_xrcb.xrcbud016,g_xrcb.xrcbud017,g_xrcb.xrcbud018,g_xrcb.xrcbud019,g_xrcb.xrcbud020,g_xrcb.xrcbud021,g_xrcb.xrcbud022,
                   g_xrcb.xrcbud023,g_xrcb.xrcbud024,g_xrcb.xrcbud025,g_xrcb.xrcbud026,g_xrcb.xrcbud027,g_xrcb.xrcbud028,g_xrcb.xrcbud029,g_xrcb.xrcbud030,
                   g_xrcb.xrcb052,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb055,g_xrcb.xrcb056,g_xrcb.xrcb057,g_xrcb.xrcb058,g_xrcb.xrcb059,g_xrcb.xrcb060,g_xrcb.xrcb107)
         #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('ins xrcb_t','','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins xrcb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq 
         END IF
      
         #插入多賬期（只含一期）
         INITIALIZE g_xrcc.* TO NULL
         LET g_xrcc.xrccent = g_enterprise
         LET g_xrcc.xrccld  = g_xrca.xrcald
         LET g_xrcc.xrcccomp = g_xrca.xrcacomp
         LET g_xrcc.xrccdocno = g_xrca.xrcadocno
         LET g_xrcc.xrccseq = g_xrcb.xrcbseq
         LET g_xrcc.xrcc001 = 1   #期別
         LET g_xrcc.xrcc002 = ''  #應收收款類別
         LET g_xrcc.xrcc003 = ''  #應收款日
         LET g_xrcc.xrcc004 = ''  #容許票據到期日
         LET g_xrcc.xrcc005 = ''  #帳款起算日
         LET g_xrcc.xrcclegl = '' #核算組織
         LET g_xrcc.xrccsite = g_xrca.xrcasite #帳務中心
         LET g_xrcc.xrcc100 = g_xrca.xrca100 #原幣
         LET g_xrcc.xrcc101 = g_xrca.xrca101 #原幣匯率
         LET g_xrcc.xrcc102 = 0
         LET g_xrcc.xrcc103 = 0
         LET g_xrcc.xrcc104 = 0
         LET g_xrcc.xrcc105 = g_xrcb.xrcb105
         LET g_xrcc.xrcc106 = 0
         LET g_xrcc.xrcc107 = 0
         LET g_xrcc.xrcc108 = g_xrcb.xrcb105
         LET g_xrcc.xrcc109 = 0
         LET g_xrcc.xrcc113 = 0
         LET g_xrcc.xrcc114 = 0
         LET g_xrcc.xrcc115 = g_xrcb.xrcb115
         LET g_xrcc.xrcc116 = 0
         LET g_xrcc.xrcc117 = 0
         LET g_xrcc.xrcc118 = g_xrcb.xrcb115
         LET g_xrcc.xrcc119 = 0
         LET g_xrcc.xrcc120 = g_xrca.xrca120
         LET g_xrcc.xrcc121 = g_xrca.xrca121
         LET g_xrcc.xrcc122 = 0
         LET g_xrcc.xrcc123 = 0
         LET g_xrcc.xrcc124 = 0
         LET g_xrcc.xrcc125 = g_xrcb.xrcb125
         LET g_xrcc.xrcc126 = 0
         LET g_xrcc.xrcc127 = 0
         LET g_xrcc.xrcc128 = g_xrcb.xrcb125
         LET g_xrcc.xrcc129 = 0
         LET g_xrcc.xrcc130 = g_xrca.xrca130
         LET g_xrcc.xrcc131 = g_xrca.xrca131
         LET g_xrcc.xrcc132 = 0
         LET g_xrcc.xrcc133 = 0
         LET g_xrcc.xrcc134 = 0
         LET g_xrcc.xrcc135 = g_xrcb.xrcb135
         LET g_xrcc.xrcc136 = 0
         LET g_xrcc.xrcc137 = 0
         LET g_xrcc.xrcc138 = g_xrcb.xrcb135
         LET g_xrcc.xrcc139 = 0
        #161215-00044#1---modify----begin-----------------
        #INSERT INTO xrcc_t VALUES (g_xrcc.*)
         INSERT INTO xrcc_t (xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,
                             xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,
                             xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,
                             xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,
                             xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,
                             xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,
                             xrccud008,xrccud009,xrccud010,xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,
                             xrccud017,xrccud018,xrccud019,xrccud020,xrccud021,xrccud022,xrccud023,xrccud024,xrccud025,
                             xrccud026,xrccud027,xrccud028,xrccud029,xrccud030,xrcc015,xrcc016,xrcc017)
          VALUES (g_xrcc.xrccent,g_xrcc.xrccld,g_xrcc.xrcccomp,g_xrcc.xrccdocno,g_xrcc.xrccseq,g_xrcc.xrcc001,g_xrcc.xrcc002,g_xrcc.xrcc003,g_xrcc.xrcc004,g_xrcc.xrcc005,g_xrcc.xrcc006,
                  g_xrcc.xrcclegl,g_xrcc.xrcc008,g_xrcc.xrcc009,g_xrcc.xrccsite,g_xrcc.xrcc010,g_xrcc.xrcc011,g_xrcc.xrcc012,g_xrcc.xrcc013,g_xrcc.xrcc014,g_xrcc.xrcc100,g_xrcc.xrcc101,
                  g_xrcc.xrcc102,g_xrcc.xrcc103,g_xrcc.xrcc104,g_xrcc.xrcc105,g_xrcc.xrcc106,g_xrcc.xrcc107,g_xrcc.xrcc108,g_xrcc.xrcc109,g_xrcc.xrcc113,g_xrcc.xrcc114,g_xrcc.xrcc115,
                  g_xrcc.xrcc116,g_xrcc.xrcc117,g_xrcc.xrcc118,g_xrcc.xrcc119,g_xrcc.xrcc120,g_xrcc.xrcc121,g_xrcc.xrcc122,g_xrcc.xrcc123,g_xrcc.xrcc124,g_xrcc.xrcc125,g_xrcc.xrcc126,
                  g_xrcc.xrcc127,g_xrcc.xrcc128,g_xrcc.xrcc129,g_xrcc.xrcc130,g_xrcc.xrcc131,g_xrcc.xrcc132,g_xrcc.xrcc133,g_xrcc.xrcc134,g_xrcc.xrcc135,g_xrcc.xrcc136,g_xrcc.xrcc137,
                  g_xrcc.xrcc138,g_xrcc.xrcc139,g_xrcc.xrccud001,g_xrcc.xrccud002,g_xrcc.xrccud003,g_xrcc.xrccud004,g_xrcc.xrccud005,g_xrcc.xrccud006,g_xrcc.xrccud007,
                  g_xrcc.xrccud008,g_xrcc.xrccud009,g_xrcc.xrccud010,g_xrcc.xrccud011,g_xrcc.xrccud012,g_xrcc.xrccud013,g_xrcc.xrccud014,g_xrcc.xrccud015,g_xrcc.xrccud016,
                  g_xrcc.xrccud017,g_xrcc.xrccud018,g_xrcc.xrccud019,g_xrcc.xrccud020,g_xrcc.xrccud021,g_xrcc.xrccud022,g_xrcc.xrccud023,g_xrcc.xrccud024,g_xrcc.xrccud025,
                  g_xrcc.xrccud026,g_xrcc.xrccud027,g_xrcc.xrccud028,g_xrcc.xrccud029,g_xrcc.xrccud030,g_xrcc.xrcc015,g_xrcc.xrcc016,g_xrcc.xrcc017)
        #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('ins xrcc_t','','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins xrcc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq 
         END IF
      
         #插入交易明細稅
         LET l_sql = "CREATE GLOBAL TEMPORARY TABLE afap270_detail AS ",
                       "SELECT * FROM xrcd_t "
         PREPARE repro_tbl1 FROM l_sql
         EXECUTE repro_tbl1
         FREE repro_tbl1
   
         #將符合條件的資料丟入TEMP TABLE
         INSERT INTO afap270_detail SELECT * FROM xrcd_t
                                     WHERE xrcdent = g_enterprise AND xrcdld = g_xrca.xrcald 
                                     AND xrcddocno = l_fabo.fabodocno AND xrcdseq=l_fabo.faboseq   
                                    
      
         #將key修正為調整後   
         UPDATE afap270_detail SET xrcddocno = g_xrca.xrcadocno,
                                   xrcdseq   = g_xrcb.xrcbseq
              
         #將資料塞回原table   
         INSERT INTO xrcd_t SELECT * FROM afap270_detail
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('upd xrcd_t','','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            #LET g_errparam.code =SQLCA.SQLCODE  #160628-00015#1
            LET g_errparam.code ='afa-01074'     #160628-00015#1
            LET g_errparam.extend = 'upd xrcd_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq
         END IF
         #刪除TEMP TABLE
         DROP TABLE afap270_detail
      
         ################
         IF g_xrca.xrcald = g_master.fabgld THEN
            ################
            #更新單頭應收帳款單號
            UPDATE fabg_t SET fabg011 = g_xrca.xrcadocno
             WHERE fabgent=g_enterprise AND fabgld=g_xrca.xrcald 
               AND fabgdocno=l_fabo.fabodocno 
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               #150731-00004#1 20150807 str---
               #CALL cl_errmsg('upd fabg_t','','',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               #LET g_errparam.code =SQLCA.SQLCODE  #160628-00015#1
               LET g_errparam.code ='afa-01075'     #160628-00015#1
               LET g_errparam.extend = 'upd fabg_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150807 end---
               #LET g_success = 'N'   #151125-00006#1--mark by aiqq
               LET g_success = FALSE  #151125-00006#1--add by aiqq 
            END IF
            
            #更新單身應收帳款單號
            UPDATE fabo_t SET fabo050 = g_xrca.xrcadocno
             WHERE faboent=g_enterprise AND fabold=g_xrca.xrcald 
               AND fabodocno=l_fabo.fabodocno AND faboseq=l_fabo.faboseq
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               #150731-00004#1 20150807 str---
               #CALL cl_errmsg('upd fabu_t','','',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               #LET g_errparam.code =SQLCA.SQLCODE  #160628-00015#1
               LET g_errparam.code ='afa-01075'     #160628-00015#1
               LET g_errparam.extend = 'upd fabu_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150807 end---
               #LET g_success = 'N'   #151125-00006#1--mark by aiqq
               LET g_success = FALSE  #151125-00006#1--add by aiqq 
            END IF
         ################
         
         END IF
         ################
      END FOREACH
       
      #判斷是否產生單身，如果有資料，匯總金額更新單頭金額，否則刪除單頭資料
      SELECT COUNT(*) INTO l_cnt FROM xrcb_t
       WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno 
      IF l_cnt > 0 THEN  
         SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115),
                SUM(xrcb123),SUM(xrcb124),SUM(xrcb125),SUM(xrcb133),SUM(xrcb134),SUM(xrcb135)  
           INTO g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
                g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138   
           FROM xrcb_t
          WHERE xrcbent = g_enterprise AND xrcbld = g_xrca.xrcald AND xrcbdocno = g_xrca.xrcadocno
         IF cl_null(g_xrca.xrca103) THEN LET g_xrca.xrca103 = 0 END IF 
         IF cl_null(g_xrca.xrca104) THEN LET g_xrca.xrca104 = 0 END IF 
         IF cl_null(g_xrca.xrca108) THEN LET g_xrca.xrca108 = 0 END IF
         IF cl_null(g_xrca.xrca113) THEN LET g_xrca.xrca113 = 0 END IF 
         IF cl_null(g_xrca.xrca114) THEN LET g_xrca.xrca114 = 0 END IF
         IF cl_null(g_xrca.xrca118) THEN LET g_xrca.xrca118 = 0 END IF
         IF cl_null(g_xrca.xrca123) THEN LET g_xrca.xrca123 = 0 END IF 
         IF cl_null(g_xrca.xrca124) THEN LET g_xrca.xrca124 = 0 END IF
         IF cl_null(g_xrca.xrca128) THEN LET g_xrca.xrca128 = 0 END IF
         IF cl_null(g_xrca.xrca133) THEN LET g_xrca.xrca133 = 0 END IF 
         IF cl_null(g_xrca.xrca134) THEN LET g_xrca.xrca134 = 0 END IF
         IF cl_null(g_xrca.xrca138) THEN LET g_xrca.xrca138 = 0 END IF
         UPDATE xrca_t SET (xrca103,xrca104,xrca108,xrca113,xrca114,xrca118,
                            xrca123,xrca124,xrca128,xrca133,xrca134,xrca138)
                         = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
                            g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138) 
          WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN 
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('upd xrca_t','','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'upd xrca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq
         END IF
      ELSE
         DELETE FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN 
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('delete xrca_t','','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'delete xrca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
            #LET g_success = 'N'   #151125-00006#1--mark by aiqq
            LET g_success = FALSE  #151125-00006#1--add by aiqq 
         END IF
         
         #160616-00005#3--add--str--
         #刪除單號
         IF NOT s_aooi200_fin_del_docno(g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt) THEN
            LET g_success = FALSE
         END IF
         CONTINUE FOREACH  #无账款单身产生时，后续生产分录底稿和审核操作不用在执行
         #160616-00005#3--add--end
      END IF
    
      #151125-00006#1--add-s
      #生成分录底稿
      IF NOT cl_null(g_xrca.xrcadocno) AND g_xrca.xrcastus = 'N' THEN
         #获取单别
         CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_success,l_ooba002
         #是否抛傳票
         CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      
         IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
            CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
            CALL s_pre_voucher_ins('AR','R10',g_glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1')
               RETURNING l_success
            IF NOT l_success THEN
               LET g_success = FALSE
            END IF
        END IF 
      END IF
  
      #应收账款立即审核
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno)
               RETURNING l_conf_success
      END IF
      IF NOT l_conf_success  THEN 
         LET g_success = FALSE
      END IF 
      #151125-00006#1--add-e
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 抓取帳款客戶相關資料
# Memo...........:
# Usage..........: CALL afap270_xrca004_ref()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_xrca004_ref()
   DEFINE l_site    LIKE xrca_t.xrcasite
   DEFINE l_ooba002 LIKE ooba_t.ooba002
   DEFINE l_success LIKE type_t.num5

  #SELECT DISTINCT ooag004 INTO l_site
  #  FROM ooag_t
  # WHERE ooag001 = g_xrca.xrca003 AND ooagstus ='Y' 
     
  ##抓取客戶慣用收款條件/應收帳款類別/負責業務人員/客戶慣用交易幣別  
  #SELECT pmab087,pmab105,pmab081,pmab089
  #  INTO g_xrca.xrca008,g_xrca.xrca007,g_xrca.xrca014,g_xrca.xrca058
  #  FROM pmab_t
  # WHERE pmabent = g_enterprise AND pmabsite = l_site AND pmab001 = g_xrca.xrca004 
  #IF SQLCA.sqlcode = 100 THEN 
      SELECT pmab087,pmab105,pmab081,pmab089
        INTO g_xrca.xrca008,g_xrca.xrca007,g_xrca.xrca014,g_xrca.xrca058
        FROM pmab_t
       WHERE pmabent = g_enterprise AND pmabsite = g_xrca.xrcacomp AND pmab001 = g_xrca.xrca004    
  #END IF
   IF cl_null(g_xrca.xrca007) THEN 
#      CALL s_aooi200_get_slip(g_xrca.xrcadocno) RETURNING l_success,l_ooba002           #mark by yangxf
#      CALL s_aooi200_fin_get_slip_desc(g_xrca.xrcadocno) RETURNING l_success,l_ooba002   #add by yangxf
       CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_success,l_ooba002        #add by huangtao
#      CALL cl_get_doc_para(g_enterprise,g_xrca.xrcacomp,l_ooba002,'S-FIN-2011') RETURNING g_xrca.xrca007
      CALL s_fin_get_doc_para(g_xrca.xrcald,'',l_ooba002,'S-FIN-2011') RETURNING g_xrca.xrca007      
   END IF
  #150601-00034#1 Add  ---(S)---
   IF NOT cl_null(g_xrca.xrca008) THEN
      CALL s_fin_date_ar_receivable(g_xrca.xrcacomp,g_xrca.xrca004,g_xrca.xrca008,g_xrca.xrcadocdt,g_xrca.xrcadocdt,g_xrca.xrcadocdt,'') 
         RETURNING l_success,g_xrca.xrca009,g_xrca.xrca010
   END IF
  #150601-00034#1 Add  ---(E)---
   SELECT ooib025,ooib005 INTO g_xrca.xrca054,g_xrca.xrca055 FROM ooib_t
    WHERE ooibent = g_enterprise AND ooib001 = g_xrca.xrca008
   #應收(借方)科目編號
#   SELECT glab005 INTO g_xrca.xrca035 FROM glab_t 
#    WHERE glabent=g_enterprise AND glabld= g_xrca.xrcald AND glab002=g_xrca.xrca007 
#      AND glab001='13' AND glab003 = '8304_01' 
   SELECT glab005 INTO g_xrca.xrca035 FROM glab_t 
    WHERE glabent=g_enterprise AND glabld= g_xrca.xrcald AND glab001='90' 
      AND glab002='40' AND glab003 = '9902_05' 
   #收入(貸方)科目編號
#   SELECT glab005 INTO g_xrca.xrca036 FROM glab_t 
#    WHERE glabent=g_enterprise AND glabld= g_xrca.xrcald AND glab002=g_xrca.xrca007 
#     AND glab001='13' AND glab003 = '8304_21'
   SELECT glab005 INTO g_xrca.xrca036 FROM glab_t 
    WHERE glabent=g_enterprise AND glabld= g_xrca.xrcald AND glab001='90'
      AND glab002='25' AND glab003 = '9902_12'
   
   
   IF cl_null(g_xrca.xrca005) THEN
      #帶出收款客戶   
      SELECT pmac002 INTO g_xrca.xrca005
        FROM pmac_t
       WHERE pmacent = g_enterprise AND pmac001 = g_xrca.xrca004 
         AND pmac003 = '1' AND pmac004 = 'Y' AND pmacstus = 'Y'
      IF SQLCA.sqlcode = 100 THEN
         LET g_xrca.xrca005 = g_xrca.xrca004
      END IF  
   END IF   
      
   #關係人   
   SELECT pmaa047 INTO g_xrca.xrca046
     FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xrca.xrca004     
   #稅率、含稅否
   SELECT oodb005,oodb006 INTO g_xrca.xrca013,g_xrca.xrca012 FROM oodb_t,ooef_t 
    WHERE ooefent = oodbent AND oodb001 = ooef019 AND ooef001 = g_xrca.xrcacomp 
      AND oodbent= g_enterprise AND oodb002=g_xrca.xrca011
  
   #部門
   SELECT ooag003 INTO g_xrca.xrca015 FROM ooag_t
   WHERE ooagent=g_enterprise AND ooag001=g_xrca.xrca014 AND ooagstus ='Y' 
   #責任中心
   SELECT ooeg004 INTO g_xrca.xrca034 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_xrca.xrca015
     
END FUNCTION

################################################################################
# Descriptions...: 執行插入應收應付帳款
# Memo...........:
# Usage..........: CALL afap270_p()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_p()
   DEFINE l_para_data    LIKE xrca_t.xrcadocdt
   DEFINE l_para_data1   LIKE xrca_t.xrcadocdt
   DEFINE l_sfin3007     LIKE apca_t.apcadocdt    #160426-00014#44 add lujh
   #151125-00006#1--add--s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0032            LIKE type_t.chr1
   #151125-00006#1--add--e
   
   IF g_master.fabg005 = '4' OR g_master.fabg005 = '43' THEN    #160426-00014#44 add lujh
      #詢問是否產生應收帳款
      IF NOT cl_ask_confirm("afa-00158") THEN
         RETURN
      END IF
   END IF   #160426-00014#44 add lujh
   
   #160426-00014#44--add--str--lujh
   IF g_master.fabg005 = '44' THEN 
      #詢問是否產生應付帳款
      IF NOT cl_ask_confirm("afa-01116") THEN
         RETURN
      END IF
   END IF
   #160426-00014#44--add--end--lujh
   
   IF g_master.fabg005='4' THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-2007') RETURNING l_para_data
      #IF g_input.xrcadocdt>l_para_data THEN
       IF g_input.xrcadocdt<=l_para_data THEN            #huangtao mod
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "asf-00008"
         LET g_errparam.extend = g_input.xrcadocdt
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN
      END IF
   END IF
   IF g_master.fabg005='43' THEN    #160426-00014#45 change 17 to 43 lujh
      LET g_input.flag1='N'
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-2007') RETURNING l_para_data1  #160426-00014#45 chaneg 'S-FIN-3007' to 'S-FIN-2007' lujh
      IF g_input.xrcadocdt < = l_para_data1 THEN    #160426-00014#45 change > to <= lujh
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "asf-00008"
         LET g_errparam.extend = g_input.xrcadocdt
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN
      END IF
   END IF
   
   #160426-00014#44--add--str--lujh
   IF g_master.fabg005='44' THEN   
      LET g_input.flag1='N'
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-3007') RETURNING l_para_data1  
      IF g_input.apcadocdt < = l_sfin3007 THEN    
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "asf-00008"
         LET g_errparam.extend = g_input.apcadocdt
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN
      END IF
   END IF
   #160426-00014#44--add--end--lujh
   
  #CALL cl_showmsg_init()       #150731-00004#1 20150807 mark
   CALL cl_err_collect_init()   #150731-00004#1 20150807 add
   LET g_success=TRUE
   CALL s_transaction_begin()
   LET g_input.docno_s=''
   LET g_input.docno_e=''
   LET g_input.docno_s1=''
   LET g_input.docno_e1=''
   FOR l_ac=1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel='Y' THEN
         IF g_master.fabg005 = '4' THEN   #160426-00014#45 add lujh
            CALL afap270_xrca_ins()
         #160426-00014#45--add--str--lujh
         END IF
         IF g_master.fabg005 = '43' THEN
            CALL afap270_xrca_ins_43()
         END IF
         #160426-00014#45--add--end--lujh
         
         #記錄最後一張應收單單號
         LET g_input.docno_e=g_xrca.xrcadocno
         #當為調撥單時，同時產生應付帳款
         IF g_master.fabg005='44' THEN   #160426-00014#44 change 17 to 44 lujh
            #CALL afap270_apca_ins()     #160426-00014#44 mark lujh
            CALL afap270_apca_ins_44()   #160426-00014#44 add lujh
            #記錄最後一張應付單單號
            LET g_input.docno_e1=g_apca.apcadocno
         END IF
      END IF
   END FOR
   
   #IF g_success='N' THEN
   IF NOT g_success THEN           #151125-00006#1 20151221 add
     #CALL cl_err_showmsg()        #150731-00004#1 20150807 mark
      CALL s_transaction_end('N','1') 
      LET g_input.docno_s=''
      LET g_input.docno_e=''
      LET g_input.docno_s1=''
      LET g_input.docno_e1=''
      CALL cl_err_collect_show()   #150731-00004#1 20150807 add
      RETURN    
   ELSE
      CALL s_transaction_end('Y','1')    
   END IF
   
   #151125-00006#1---add-s
   #应收账款立即抛转
   IF g_master.fabg005 = '4' OR g_master.fabg005 = '43' THEN   #160426-00014#44 add lujh
      CALL afap270_xrca_immediately_gen()
   END IF                                                      #160426-00014#44 add lujh
   #应付账款立即抛转   
   IF g_master.fabg005='44' THEN     #160426-00014#44 change 17 to 44 lujh
      CALL afap270_apca_immediately_gen()
   END IF 
   #资产出售立即抛转
   CALL afap270_fabg_immediately_gen()  
   CALL cl_err_collect_show() 
   #151125-00006#1---add-s
   
END FUNCTION

################################################################################
# Descriptions...: 插入應付帳款(apca_t apcb_t apcc_t)
# Memo...........:
# Usage..........: CALL afap270_apca_ins()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_apca_ins()
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_fabg        RECORD LIKE fabg_t.*
   #DEFINE l_fabu        RECORD LIKE fabu_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020 #資產性質
       END RECORD
    DEFINE l_fabu RECORD  #資產調撥單身檔
       fabuent LIKE fabu_t.fabuent, #企業編碼
       fabuld LIKE fabu_t.fabuld, #帳套
       fabudocno LIKE fabu_t.fabudocno, #異動單號
       fabuseq LIKE fabu_t.fabuseq, #項次
       fabu000 LIKE fabu_t.fabu000, #異動類型
       fabu001 LIKE fabu_t.fabu001, #財產編號
       fabu002 LIKE fabu_t.fabu002, #附號
       fabu003 LIKE fabu_t.fabu003, #卡片編號
       fabu004 LIKE fabu_t.fabu004, #未折減額
       fabu005 LIKE fabu_t.fabu005, #單位
       fabu006 LIKE fabu_t.fabu006, #單價
       fabu007 LIKE fabu_t.fabu007, #調撥/出售數量
       fabu008 LIKE fabu_t.fabu008, #成本
       fabu009 LIKE fabu_t.fabu009, #稅別
       fabu010 LIKE fabu_t.fabu010, #交易幣別
       fabu011 LIKE fabu_t.fabu011, #原幣匯率
       fabu012 LIKE fabu_t.fabu012, #原幣未稅金額
       fabu013 LIKE fabu_t.fabu013, #原幣稅額
       fabu014 LIKE fabu_t.fabu014, #原幣應收金額
       fabu015 LIKE fabu_t.fabu015, #本幣未稅金額
       fabu016 LIKE fabu_t.fabu016, #本幣稅額
       fabu017 LIKE fabu_t.fabu017, #本幣應收金額
       fabu018 LIKE fabu_t.fabu018, #no use
       fabu019 LIKE fabu_t.fabu019, #累折科目
       fabu020 LIKE fabu_t.fabu020, #減值準備科目
       fabu021 LIKE fabu_t.fabu021, #資產科目
       fabu022 LIKE fabu_t.fabu022, #應付帳款科目
       fabu023 LIKE fabu_t.fabu023, #稅額科目
       fabu024 LIKE fabu_t.fabu024, #營運據點
       fabu025 LIKE fabu_t.fabu025, #部門
       fabu026 LIKE fabu_t.fabu026, #利潤/成本中心
       fabu027 LIKE fabu_t.fabu027, #區域
       fabu028 LIKE fabu_t.fabu028, #交易客商
       fabu029 LIKE fabu_t.fabu029, #帳款客商
       fabu030 LIKE fabu_t.fabu030, #客群
       fabu031 LIKE fabu_t.fabu031, #人員
       fabu032 LIKE fabu_t.fabu032, #專案編號
       fabu033 LIKE fabu_t.fabu033, #WBS
       fabu034 LIKE fabu_t.fabu034, #帳款編號
       fabu035 LIKE fabu_t.fabu035, #摘要
       fabu036 LIKE fabu_t.fabu036, #應付帳款單號
       fabu101 LIKE fabu_t.fabu101, #本位幣二幣別
       fabu102 LIKE fabu_t.fabu102, #本位幣二匯率
       fabu103 LIKE fabu_t.fabu103, #本位幣二未稅金額
       fabu104 LIKE fabu_t.fabu104, #本位幣二稅額
       fabu105 LIKE fabu_t.fabu105, #本位幣二應付金額
       fabu106 LIKE fabu_t.fabu106, #本位幣二處置成本
       fabu107 LIKE fabu_t.fabu107, #本位幣二處置後未折減額
       fabu150 LIKE fabu_t.fabu150, #本位幣三幣別
       fabu151 LIKE fabu_t.fabu151, #本位幣三匯率
       fabu152 LIKE fabu_t.fabu152, #本位幣三未稅金額
       fabu153 LIKE fabu_t.fabu153, #本位幣三稅額
       fabu154 LIKE fabu_t.fabu154, #本位幣三應付金額
       fabu155 LIKE fabu_t.fabu155, #本位幣三處置成本
       fabu156 LIKE fabu_t.fabu156, #本位幣三處置後未折減額
       fabuud001 LIKE fabu_t.fabuud001, #自定義欄位(文字)001
       fabuud002 LIKE fabu_t.fabuud002, #自定義欄位(文字)002
       fabuud003 LIKE fabu_t.fabuud003, #自定義欄位(文字)003
       fabuud004 LIKE fabu_t.fabuud004, #自定義欄位(文字)004
       fabuud005 LIKE fabu_t.fabuud005, #自定義欄位(文字)005
       fabuud006 LIKE fabu_t.fabuud006, #自定義欄位(文字)006
       fabuud007 LIKE fabu_t.fabuud007, #自定義欄位(文字)007
       fabuud008 LIKE fabu_t.fabuud008, #自定義欄位(文字)008
       fabuud009 LIKE fabu_t.fabuud009, #自定義欄位(文字)009
       fabuud010 LIKE fabu_t.fabuud010, #自定義欄位(文字)010
       fabuud011 LIKE fabu_t.fabuud011, #自定義欄位(數字)011
       fabuud012 LIKE fabu_t.fabuud012, #自定義欄位(數字)012
       fabuud013 LIKE fabu_t.fabuud013, #自定義欄位(數字)013
       fabuud014 LIKE fabu_t.fabuud014, #自定義欄位(數字)014
       fabuud015 LIKE fabu_t.fabuud015, #自定義欄位(數字)015
       fabuud016 LIKE fabu_t.fabuud016, #自定義欄位(數字)016
       fabuud017 LIKE fabu_t.fabuud017, #自定義欄位(數字)017
       fabuud018 LIKE fabu_t.fabuud018, #自定義欄位(數字)018
       fabuud019 LIKE fabu_t.fabuud019, #自定義欄位(數字)019
       fabuud020 LIKE fabu_t.fabuud020, #自定義欄位(數字)020
       fabuud021 LIKE fabu_t.fabuud021, #自定義欄位(日期時間)021
       fabuud022 LIKE fabu_t.fabuud022, #自定義欄位(日期時間)022
       fabuud023 LIKE fabu_t.fabuud023, #自定義欄位(日期時間)023
       fabuud024 LIKE fabu_t.fabuud024, #自定義欄位(日期時間)024
       fabuud025 LIKE fabu_t.fabuud025, #自定義欄位(日期時間)025
       fabuud026 LIKE fabu_t.fabuud026, #自定義欄位(日期時間)026
       fabuud027 LIKE fabu_t.fabuud027, #自定義欄位(日期時間)027
       fabuud028 LIKE fabu_t.fabuud028, #自定義欄位(日期時間)028
       fabuud029 LIKE fabu_t.fabuud029, #自定義欄位(日期時間)029
       fabuud030 LIKE fabu_t.fabuud030  #自定義欄位(日期時間)030
       END RECORD

    #161215-00044#1---modify----end-----------------
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_apcbseq     LIKE apcb_t.apcbseq
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_oodb004     LIKE oodb_t.oodb004
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_fabo044     LIKE fabo_t.fabo044
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   #151125-00006#1--add--s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0030            LIKE type_t.chr1
   DEFINE  l_dfin0031            LIKE type_t.chr1
   #151125-00006#1--add--e
   
   INITIALIZE l_fabg.* TO NULL
   LET l_fabg.fabgld=g_master.fabgld
   LET l_fabg.fabg013=g_detail_d[l_ac].fabg013 #稅別
   LET l_fabg.fabg015=g_detail_d[l_ac].fabg015 #幣別
   #依單號匯總
   IF g_master.type='1' THEN
      LET l_fabg.fabgdocno=g_detail_d[l_ac].fabgdocno
      SELECT fabg001,fabg006,fabg007,fabg016 
        INTO l_fabg.fabg001,l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg016
        FROM fabg_t
       WHERE fabgent=g_enterprise AND fabgld=g_master.fabgld
         AND fabgdocno=g_detail_d[l_ac].fabgdocno
   ELSE #依帳款客戶匯總
      LET l_fabg.fabg006=g_detail_d[l_ac].fabg006
   END IF
   
   #插入單頭
   INITIALIZE g_apca.* TO NULL
   
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_input.apcald
   LET g_apca.apcaent = g_enterprise
   LET g_apca.apcaownid = g_user
   LET g_apca.apcaowndp = g_dept
   LET g_apca.apcacrtid = g_user
   LET g_apca.apcacrtdp = g_dept 
   LET g_apca.apcacrtdt = cl_get_current()
   LET g_apca.apcamodid = ""
   LET g_apca.apcamoddt = ""
   LET g_apca.apcastus = "N"
   LET g_apca.apcacomp = l_glaacomp
   LET g_apca.apcald = g_input.apcald
   #單據日期
   LET g_apca.apcadocdt= g_input.apcadocdt
   #单据编号
#   CALL s_aooi200_gen_docno(l_glaacomp,g_input.xrcadocno,g_input.xrcadocdt,'axrt330')      #mark by yangxf
   CALL s_aooi200_fin_gen_docno(g_input.xrcald,'','',g_input.xrcadocno,g_input.xrcadocdt,'axrt330')     #add by yangxf
   RETURNING l_success,g_apca.apcadocno
   IF l_success  = 0  THEN
      #150731-00004#1 20150807 str---
      #CALL cl_errmsg('','','','apm-00003',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code ='apm-00003'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #150731-00004#1 20150807 end---
      #LET g_success = 'N'   #151125-00006#1--mark by aiqq
      LET g_success = FALSE  #151125-00006#1--add by aiqq
   END IF 
   LET g_apca.apca001 = '19' #其他應付帳款
   LET g_apca.apcasite = g_input.apcasite
   LET g_apca.apca003 = g_user          #帳務人員
   LET g_apca.apca004 = l_fabg.fabg006  #帳款客戶
   CALL afap270_apca004_ref()
   #稅別
   LET g_apca.apca011 = l_fabg.fabg013  #稅別
   CALL s_tax_chk(g_apca.apcacomp,g_apca.apca011) 
   RETURNING l_success,l_oodb004,g_apca.apca013,g_apca.apca012,l_oodb011
   LET g_apca.apca016 = '15' #調撥單
   LET g_apca.apca017 = 1
   LET g_apca.apca017 = g_detail_d[l_ac].fabgdocno
   LET g_apca.apca020 = 'N'     
   LET g_apca.apca026 = 0
   LET g_apca.apca027 = 0
   LET g_apca.apca028 = 0
   LET g_apca.apca029 = 0
   LET g_apca.apca037 = 'N'
   LET g_apca.apca039 = 0
   LET g_apca.apca040 = 'N'
   LET g_apca.apca044 = 0 
   LET g_apca.apca052 = 0
   LET g_apca.apca060 = 1
   LET g_apca.apca062 = '1'
   LET g_apca.apca100 = l_fabg.fabg015  #交易原幣
   LET g_apca.apca101 = l_fabg.fabg016
   SELECT DISTINCT fabu101,fabu102,fabu150,fabu151 
     INTO g_apca.apca120,g_apca.apca121,g_apca.apca130,g_apca.apca131
   FROM fabu_t
   WHERE fabuent=g_enterprise AND fabuld=l_fabg.fabgld AND fabudocno=l_fabg.fabgdocno
   
   LET g_apca.apca103 = 0
   LET g_apca.apca104 = 0
   LET g_apca.apca106 = 0
   LET g_apca.apca107 = 0
   LET g_apca.apca108 = 0
   LET g_apca.apca113 = 0
   LET g_apca.apca114 = 0
   LET g_apca.apca116 = 0
   LET g_apca.apca117 = 0
   LET g_apca.apca118 = 0
      
   LET g_apca.apca123 = 0
   LET g_apca.apca124 = 0
   LET g_apca.apca126 = 0
   LET g_apca.apca127 = 0
   LET g_apca.apca128 = 0
   
   LET g_apca.apca133 = 0
   LET g_apca.apca134 = 0
   LET g_apca.apca136 = 0
   LET g_apca.apca137 = 0
   LET g_apca.apca138 = 0
   #161215-00044#1---modify----begin-----------------
   #INSERT INTO apca_t VALUES (g_apca.*)
   INSERT INTO apca_t (apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,
                       apcacnfdt,apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,apca001,
                       apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,apca013,apca014,
                       apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,apca026,apca027,apca028,
                       apca029,apca030,apca031,apca032,apca033,apca034,apca035,apca036,apca037,apca038,apca039,apca040,
                       apca041,apca042,apca043,apca044,apca045,apca046,apca047,apca048,apca049,apca050,apca051,apca052,
                       apca053,apca054,apca055,apca056,apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca064,
                       apca065,apca066,apca100,apca101,apca103,apca104,apca106,apca107,apca108,apca113,apca114,apca116,
                       apca117,apca118,apca120,apca121,apca123,apca124,apca126,apca127,apca128,apca130,apca131,apca133,
                       apca134,apca136,apca137,apca138,apcaud001,apcaud002,apcaud003,apcaud004,apcaud005,apcaud006,apcaud007,
                       apcaud008,apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,apcaud014,apcaud015,apcaud016,apcaud017,
                       apcaud018,apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,apcaud024,apcaud025,apcaud026,apcaud027,
                       apcaud028,apcaud029,apcaud030,apca067,apca068,apca069,apca070,apca071,apca072,apca073)
    VALUES (g_apca.apcaent,g_apca.apcaownid,g_apca.apcaowndp,g_apca.apcacrtid,g_apca.apcacrtdp,g_apca.apcacrtdt,g_apca.apcamodid,g_apca.apcamoddt,g_apca.apcacnfid,
            g_apca.apcacnfdt,g_apca.apcapstid,g_apca.apcapstdt,g_apca.apcastus,g_apca.apcald,g_apca.apcacomp,g_apca.apcadocno,g_apca.apcadocdt,g_apca.apcasite,g_apca.apca001,
            g_apca.apca003,g_apca.apca004,g_apca.apca005,g_apca.apca006,g_apca.apca007,g_apca.apca008,g_apca.apca009,g_apca.apca010,g_apca.apca011,g_apca.apca012,g_apca.apca013,g_apca.apca014,
            g_apca.apca015,g_apca.apca016,g_apca.apca017,g_apca.apca018,g_apca.apca019,g_apca.apca020,g_apca.apca021,g_apca.apca022,g_apca.apca025,g_apca.apca026,g_apca.apca027,g_apca.apca028,
            g_apca.apca029,g_apca.apca030,g_apca.apca031,g_apca.apca032,g_apca.apca033,g_apca.apca034,g_apca.apca035,g_apca.apca036,g_apca.apca037,g_apca.apca038,g_apca.apca039,g_apca.apca040,
            g_apca.apca041,g_apca.apca042,g_apca.apca043,g_apca.apca044,g_apca.apca045,g_apca.apca046,g_apca.apca047,g_apca.apca048,g_apca.apca049,g_apca.apca050,g_apca.apca051,g_apca.apca052,
            g_apca.apca053,g_apca.apca054,g_apca.apca055,g_apca.apca056,g_apca.apca057,g_apca.apca058,g_apca.apca059,g_apca.apca060,g_apca.apca061,g_apca.apca062,g_apca.apca063,g_apca.apca064,
            g_apca.apca065,g_apca.apca066,g_apca.apca100,g_apca.apca101,g_apca.apca103,g_apca.apca104,g_apca.apca106,g_apca.apca107,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca116,
            g_apca.apca117,g_apca.apca118,g_apca.apca120,g_apca.apca121,g_apca.apca123,g_apca.apca124,g_apca.apca126,g_apca.apca127,g_apca.apca128,g_apca.apca130,g_apca.apca131,g_apca.apca133,
            g_apca.apca134,g_apca.apca136,g_apca.apca137,g_apca.apca138,g_apca.apcaud001,g_apca.apcaud002,g_apca.apcaud003,g_apca.apcaud004,g_apca.apcaud005,g_apca.apcaud006,g_apca.apcaud007,
            g_apca.apcaud008,g_apca.apcaud009,g_apca.apcaud010,g_apca.apcaud011,g_apca.apcaud012,g_apca.apcaud013,g_apca.apcaud014,g_apca.apcaud015,g_apca.apcaud016,g_apca.apcaud017,
            g_apca.apcaud018,g_apca.apcaud019,g_apca.apcaud020,g_apca.apcaud021,g_apca.apcaud022,g_apca.apcaud023,g_apca.apcaud024,g_apca.apcaud025,g_apca.apcaud026,g_apca.apcaud027,
            g_apca.apcaud028,g_apca.apcaud029,g_apca.apcaud030,g_apca.apca067,g_apca.apca068,g_apca.apca069,g_apca.apca070,g_apca.apca071,g_apca.apca072,g_apca.apca073)
   #161215-00044#1---modify----end-----------------
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
      #150731-00004#1 20150807 str---
      #CALL cl_errmsg('ins apca_t','','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =SQLCA.SQLCODE
      LET g_errparam.extend = 'ins apca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #150731-00004#1 20150807 end---
      #LET g_success = 'N'   #151125-00006#1--mark by aiqq
      LET g_success = FALSE  #151125-00006#1--add by aiqq 
   END IF
   
   #記錄第一張應收單單號
   IF cl_null(g_input.docno_s1) THEN
      LET g_input.docno_s1=g_apca.apcadocno
   END IF
   
   #插入單身
   LET g_sql="SELECT fabudocno,fabuseq,fabu001,fabu002,fabu003,fabu005,",
             "       fabu007,fabu009,fabu010,fabu011,fabu027,fabu032,fabu033,",
             "       fabu012,fabu013,fabu014,fabu015,fabu016,fabu017,",
             "       fabu102,fabu103,fabu104,fabu105,fabu151,fabu152,fabu153,fabu154 ",
             "  FROM fabg_t,fabu_t",
             " WHERE fabgent=fabuent AND fabgld=fabuld AND fabgdocno=fabudocno AND fabgent=",g_enterprise,
#0921
#            "   AND fabgld='",g_master.fabgld,"' AND fabg005='4' AND fabgstus='S' ",
#            "   AND fabg011 IS NULL AND fabg012 IS NULL ",  
#            "   AND fabg015='",g_detail_d[l_ac].fabg015,"' AND fabg013='",g_detail_d[l_ac].fabg013,"'"
             "   AND fabg012 IS NULL ",
             "   AND fabgld='",g_master.fabgld,"' AND fabg005='17' AND fabgstus='Y' "
             
   IF g_master.type='1' THEN
      LET g_sql=g_sql," AND fabgdocno='",g_detail_d[l_ac].fabgdocno,"' "  
   ELSE
      LET g_sql=g_sql," AND fabg006='",g_detail_d[l_ac].fabg006,"' "
   END IF
   IF NOT cl_null(g_master.wc) THEN
      LET g_sql=g_sql," AND ",g_master.wc  
   END IF
   LET g_sql=g_sql," ORDER BY fabudocno,fabuseq"
   
   PREPARE afap270_pr2 FROM g_sql
   DECLARE afap270_cs2 CURSOR FOR afap270_pr2
   LET l_apcbseq =0
   
   FOREACH afap270_cs2 INTO l_fabu.fabudocno,l_fabu.fabuseq,l_fabu.fabu001,l_fabu.fabu002,l_fabu.fabu003,
                            l_fabu.fabu005,l_fabu.fabu007,l_fabu.fabu009,
                            l_fabu.fabu010,l_fabu.fabu011,l_fabu.fabu027,l_fabu.fabu032,l_fabu.fabu033,
                            l_fabu.fabu012,l_fabu.fabu013,l_fabu.fabu014,l_fabu.fabu015,l_fabu.fabu016,
                            l_fabu.fabu017,l_fabu.fabu102,l_fabu.fabu103,l_fabu.fabu104,l_fabu.fabu105,
                            l_fabu.fabu151,l_fabu.fabu152,l_fabu.fabu153,l_fabu.fabu154

      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('foreach','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'foreach'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
         EXIT FOREACH
      END IF
      LET l_apcbseq = l_apcbseq + 1
      
      INITIALIZE g_apcb.* TO NULL
      LET g_apcb.apcbent = g_enterprise
      LET g_apcb.apcbld  = g_apca.apcald
      LET g_apcb.apcbdocno = g_apca.apcadocno
      LET g_apcb.apcbseq = l_apcbseq
      LET g_apcb.apcbsite= g_apca.apcasite    #營運據點
      #來源組織
      SELECT fabo048 INTO g_apcb.apcborga FROM fabo_t
      WHERE faboent=g_enterprise AND fabold=g_master.fabgld 
      AND fabodocno=l_fabu.fabudocno AND faboseq=l_fabu.fabuseq
      IF cl_null(g_apcb.apcborga) THEN
         SELECT faah028 INTO g_apcb.apcborga FROM faah_t
          WHERE faahent = g_enterprise AND faah001 = l_fabu.fabu003
            AND faah003 = l_fabu.fabu001 AND faah004 = l_fabu.fabu002
      END IF
      LET g_apcb.apcb001 = 'afat505'        #來源類型
      LET g_apcb.apcb002 = l_fabu.fabudocno #來源單號
      LET g_apcb.apcb003 = l_fabu.fabuseq   #來源項次
      LET g_apcb.apcb004 = ''
      LET g_apcb.apcb005 = ''
      LET g_apcb.apcb006 = l_fabu.fabu005
      LET g_apcb.apcb007 = l_fabu.fabu007
      LET g_apcb.apcb008 = ''
      LET g_apcb.apcb009 = ''
      LET g_apcb.apcblegl= g_apca.apcacomp  #?核算組織
      LET g_apcb.apcb010 = g_apca.apca015
      LET g_apcb.apcb011 = g_apca.apca034
      LET g_apcb.apcb012 = '' #產品類別
      LET g_apcb.apcb013 = '' #
      LET g_apcb.apcb014 = ''
      LET g_apcb.apcb015 = l_fabu.fabu032 #專案代碼
      LET g_apcb.apcb016 = l_fabu.fabu033 #WBS 
      LET g_apcb.apcb017 = '' #預算項目
      LET g_apcb.apcb018 = '' #客戶編號 
      LET g_apcb.apcb019 = ''
      LET g_apcb.apcb020 = l_fabu.fabu009
      LET g_apcb.apcb021 = g_apca.apca036 
      LET g_apcb.apcb022 = 1  #正負值
      LET g_apcb.apcb023 = 'N'
      LET g_apcb.apcb024 = l_fabu.fabu027 #區域
      LET g_apcb.apcb025 = ''
      LET g_apcb.apcb026 = ''
      LET g_apcb.apcb027 = ''
      LET g_apcb.apcb028 = ''
      LET g_apcb.apcb029 = g_apca.apca035  #收入會計科目
      LET g_apcb.apcb030 = g_apca.apca008  #付款條件
      LET g_apcb.apcb100 = l_fabu.fabu010
      LET g_apcb.apcb101 = l_fabu.fabu006 #原幣單價
      LET g_apcb.apcb102 = l_fabu.fabu011 #匯率
      LET g_apcb.apcb103 = l_fabu.fabu012
      LET g_apcb.apcb104 = l_fabu.fabu013
      LET g_apcb.apcb105 = l_fabu.fabu014
      LET g_apcb.apcb106 = 0
      LET g_apcb.apcb107 = 0
      LET g_apcb.apcb108 = 0
      LET g_apcb.apcb111 = l_fabu.fabu006 #本幣單價
      LET g_apcb.apcb113 = l_fabu.fabu015
      LET g_apcb.apcb114 = l_fabu.fabu016
      LET g_apcb.apcb115 = l_fabu.fabu017
      LET g_apcb.apcb116 = 0
      LET g_apcb.apcb117 = 0
      LET g_apcb.apcb118 = 0
      LET g_apcb.apcb119 = g_apcb.apcb115
      LET g_apcb.apcb121 = l_fabu.fabu102
      LET g_apcb.apcb123 = l_fabu.fabu103
      LET g_apcb.apcb124 = l_fabu.fabu104
      LET g_apcb.apcb125 = l_fabu.fabu105
      LET g_apcb.apcb126 = 0
      LET g_apcb.apcb127 = 0
      LET g_apcb.apcb128 = 0
      LET g_apcb.apcb133 = l_fabu.fabu152
      LET g_apcb.apcb134 = l_fabu.fabu153
      LET g_apcb.apcb135 = l_fabu.fabu154
      LET g_apcb.apcb136 = 0
      LET g_apcb.apcb137 = 0
      LET g_apcb.apcb138 = 0
      #161215-00044#1---modify----begin-----------------
      #INSERT INTO apcb_t VALUES (g_apcb.*)
      INSERT INTO apcb_t (apcbent,apcbld,apcblegl,apcborga,apcbsite,apcbdocno,apcbseq,apcb001,apcb002,apcb003,
                          apcb004,apcb005,apcb006,apcb007,apcb008,apcb009,apcb010,apcb011,apcb012,apcb013,apcb014,
                          apcb015,apcb016,apcb017,apcb018,apcb019,apcb020,apcb021,apcb022,apcb023,apcb024,apcb025,
                          apcb026,apcb027,apcb028,apcb029,apcb030,apcb032,apcb033,apcb034,apcb035,apcb036,apcb037,
                          apcb038,apcb039,apcb040,apcb041,apcb042,apcb043,apcb044,apcb045,apcb046,apcb047,apcb048,
                          apcb049,apcb050,apcb051,apcb100,apcb101,apcb102,apcb103,apcb104,apcb105,apcb106,apcb107,
                          apcb108,apcb111,apcb113,apcb114,apcb115,apcb116,apcb117,apcb118,apcb119,apcb121,apcb123,
                          apcb124,apcb125,apcb126,apcb127,apcb128,apcb131,apcb133,apcb134,apcb135,apcb136,apcb137,
                          apcb138,apcbud001,apcbud002,apcbud003,apcbud004,apcbud005,apcbud006,apcbud007,apcbud008,
                          apcbud009,apcbud010,apcbud011,apcbud012,apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,
                          apcbud018,apcbud019,apcbud020,apcbud021,apcbud022,apcbud023,apcbud024,apcbud025,apcbud026,
                          apcbud027,apcbud028,apcbud029,apcbud030,apcb052,apcb053,apcb054,apcb055)
       VALUES (g_apcb.apcbent,g_apcb.apcbld,g_apcb.apcblegl,g_apcb.apcborga,g_apcb.apcbsite,g_apcb.apcbdocno,g_apcb.apcbseq,g_apcb.apcb001,g_apcb.apcb002,g_apcb.apcb003,
               g_apcb.apcb004,g_apcb.apcb005,g_apcb.apcb006,g_apcb.apcb007,g_apcb.apcb008,g_apcb.apcb009,g_apcb.apcb010,g_apcb.apcb011,g_apcb.apcb012,g_apcb.apcb013,g_apcb.apcb014,
               g_apcb.apcb015,g_apcb.apcb016,g_apcb.apcb017,g_apcb.apcb018,g_apcb.apcb019,g_apcb.apcb020,g_apcb.apcb021,g_apcb.apcb022,g_apcb.apcb023,g_apcb.apcb024,g_apcb.apcb025,
               g_apcb.apcb026,g_apcb.apcb027,g_apcb.apcb028,g_apcb.apcb029,g_apcb.apcb030,g_apcb.apcb032,g_apcb.apcb033,g_apcb.apcb034,g_apcb.apcb035,g_apcb.apcb036,g_apcb.apcb037,
               g_apcb.apcb038,g_apcb.apcb039,g_apcb.apcb040,g_apcb.apcb041,g_apcb.apcb042,g_apcb.apcb043,g_apcb.apcb044,g_apcb.apcb045,g_apcb.apcb046,g_apcb.apcb047,g_apcb.apcb048,
               g_apcb.apcb049,g_apcb.apcb050,g_apcb.apcb051,g_apcb.apcb100,g_apcb.apcb101,g_apcb.apcb102,g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,g_apcb.apcb106,g_apcb.apcb107,
               g_apcb.apcb108,g_apcb.apcb111,g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,g_apcb.apcb116,g_apcb.apcb117,g_apcb.apcb118,g_apcb.apcb119,g_apcb.apcb121,g_apcb.apcb123,
               g_apcb.apcb124,g_apcb.apcb125,g_apcb.apcb126,g_apcb.apcb127,g_apcb.apcb128,g_apcb.apcb131,g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135,g_apcb.apcb136,g_apcb.apcb137,
               g_apcb.apcb138,g_apcb.apcbud001,g_apcb.apcbud002,g_apcb.apcbud003,g_apcb.apcbud004,g_apcb.apcbud005,g_apcb.apcbud006,g_apcb.apcbud007,g_apcb.apcbud008,
               g_apcb.apcbud009,g_apcb.apcbud010,g_apcb.apcbud011,g_apcb.apcbud012,g_apcb.apcbud013,g_apcb.apcbud014,g_apcb.apcbud015,g_apcb.apcbud016,g_apcb.apcbud017,
               g_apcb.apcbud018,g_apcb.apcbud019,g_apcb.apcbud020,g_apcb.apcbud021,g_apcb.apcbud022,g_apcb.apcbud023,g_apcb.apcbud024,g_apcb.apcbud025,g_apcb.apcbud026,
               g_apcb.apcbud027,g_apcb.apcbud028,g_apcb.apcbud029,g_apcb.apcbud030,g_apcb.apcb052,g_apcb.apcb053,g_apcb.apcb054,g_apcb.apcb055)
      #161215-00044#1---modify----end-----------------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('ins apcb_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'ins apcb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
      END IF
      
      #插入多賬期（只含一期）
      INITIALIZE g_apcc.* TO NULL
      LET g_apcc.apccent = g_enterprise
      LET g_apcc.apccld  = g_apca.apcald
      LET g_apcc.apcccomp = g_apca.apcacomp
      LET g_apcc.apccdocno = g_apca.apcadocno
      LET g_apcc.apccseq = g_apcb.apcbseq
      LET g_apcc.apcc001 = 1   #期別
      LET g_apcc.apcc002 = ''  #應付付款類別
      LET g_apcc.apcc003 = ''  #應付款日
      LET g_apcc.apcc004 = ''  #容許票據到期日
      LET g_apcc.apcc005 = ''  #帳款起算日
      LET g_apcc.apcc005 = 1   #正負值
      LET g_apcc.apcclegl = '' #核算組織
      LET g_apcc.apccsite = g_apca.apcasite #帳務中心
      LET g_apcc.apcc100 = g_apca.apca100 #原幣
      LET g_apcc.apcc101 = g_apca.apca101 #原幣匯率
      LET g_apcc.apcc102 = 0
      LET g_apcc.apcc103 = 0
      LET g_apcc.apcc104 = 0
      LET g_apcc.apcc105 = g_apcb.apcb105
      LET g_apcc.apcc106 = 0
      LET g_apcc.apcc107 = 0
      LET g_apcc.apcc108 = g_apcb.apcb105
      LET g_apcc.apcc109 = 0
      LET g_apcc.apcc113 = 0
      LET g_apcc.apcc114 = 0
      LET g_apcc.apcc115 = g_apcb.apcb115
      LET g_apcc.apcc116 = 0
      LET g_apcc.apcc117 = 0
      LET g_apcc.apcc118 = g_apcb.apcb115
      LET g_apcc.apcc119 = 0
      LET g_apcc.apcc120 = g_apca.apca120
      LET g_apcc.apcc121 = g_apca.apca121
      LET g_apcc.apcc122 = 0
      LET g_apcc.apcc123 = 0
      LET g_apcc.apcc124 = 0
      LET g_apcc.apcc125 = g_apcb.apcb125
      LET g_apcc.apcc126 = 0
      LET g_apcc.apcc127 = 0
      LET g_apcc.apcc128 = g_apcb.apcb125
      LET g_apcc.apcc129 = 0
      LET g_apcc.apcc130 = g_apca.apca130
      LET g_apcc.apcc131 = g_apca.apca131
      LET g_apcc.apcc132 = 0
      LET g_apcc.apcc133 = 0
      LET g_apcc.apcc134 = 0
      LET g_apcc.apcc135 = g_apcb.apcb135
      LET g_apcc.apcc136 = 0
      LET g_apcc.apcc137 = 0
      LET g_apcc.apcc138 = g_apcb.apcb135
      LET g_apcc.apcc139 = 0
      #161215-00044#1---modify----begin-----------------
      #INSERT INTO apcc_t VALUES (g_apcc.*)
      INSERT INTO apcc_t (apccent,apccld,apcccomp,apcclegl,apccsite,apccdocno,apccseq,apcc001,apcc002,apcc003,
                          apcc004,apcc005,apcc006,apcc007,apcc008,apcc009,apcc010,apcc011,apcc012,apcc013,apcc014,
                          apcc100,apcc101,apcc102,apcc103,apcc104,apcc105,apcc106,apcc107,apcc108,apcc109,apcc113,
                          apcc114,apcc115,apcc116,apcc117,apcc118,apcc119,apcc120,apcc121,apcc122,apcc123,apcc124,
                          apcc125,apcc126,apcc127,apcc128,apcc129,apcc130,apcc131,apcc132,apcc133,apcc134,apcc135,
                          apcc136,apcc137,apcc138,apcc139,apccud001,apccud002,apccud003,apccud004,apccud005,apccud006,
                          apccud007,apccud008,apccud009,apccud010,apccud011,apccud012,apccud013,apccud014,apccud015,
                          apccud016,apccud017,apccud018,apccud019,apccud020,apccud021,apccud022,apccud023,apccud024,
                          apccud025,apccud026,apccud027,apccud028,apccud029,apccud030,apcc015,apcc016,apcc017)
       VALUES (g_apcc.apccent,g_apcc.apccld,g_apcc.apcccomp,g_apcc.apcclegl,g_apcc.apccsite,g_apcc.apccdocno,g_apcc.apccseq,g_apcc.apcc001,g_apcc.apcc002,g_apcc.apcc003,
               g_apcc.apcc004,g_apcc.apcc005,g_apcc.apcc006,g_apcc.apcc007,g_apcc.apcc008,g_apcc.apcc009,g_apcc.apcc010,g_apcc.apcc011,g_apcc.apcc012,g_apcc.apcc013,g_apcc.apcc014,
               g_apcc.apcc100,g_apcc.apcc101,g_apcc.apcc102,g_apcc.apcc103,g_apcc.apcc104,g_apcc.apcc105,g_apcc.apcc106,g_apcc.apcc107,g_apcc.apcc108,g_apcc.apcc109,g_apcc.apcc113,
               g_apcc.apcc114,g_apcc.apcc115,g_apcc.apcc116,g_apcc.apcc117,g_apcc.apcc118,g_apcc.apcc119,g_apcc.apcc120,g_apcc.apcc121,g_apcc.apcc122,g_apcc.apcc123,g_apcc.apcc124,
               g_apcc.apcc125,g_apcc.apcc126,g_apcc.apcc127,g_apcc.apcc128,g_apcc.apcc129,g_apcc.apcc130,g_apcc.apcc131,g_apcc.apcc132,g_apcc.apcc133,g_apcc.apcc134,g_apcc.apcc135,
               g_apcc.apcc136,g_apcc.apcc137,g_apcc.apcc138,g_apcc.apcc139,g_apcc.apccud001,g_apcc.apccud002,g_apcc.apccud003,g_apcc.apccud004,g_apcc.apccud005,g_apcc.apccud006,
               g_apcc.apccud007,g_apcc.apccud008,g_apcc.apccud009,g_apcc.apccud010,g_apcc.apccud011,g_apcc.apccud012,g_apcc.apccud013,g_apcc.apccud014,g_apcc.apccud015,
               g_apcc.apccud016,g_apcc.apccud017,g_apcc.apccud018,g_apcc.apccud019,g_apcc.apccud020,g_apcc.apccud021,g_apcc.apccud022,g_apcc.apccud023,g_apcc.apccud024,
               g_apcc.apccud025,g_apcc.apccud026,g_apcc.apccud027,g_apcc.apccud028,g_apcc.apccud029,g_apcc.apccud030,g_apcc.apcc015,g_apcc.apcc016,g_apcc.apcc017)
      #161215-00044#1---modify----end-----------------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('ins apcc_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'ins apcc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq 
      END IF
      
      #插入交易明細稅
      LET l_sql = "CREATE GLOBAL TEMPORARY TABLE afap270_detail AS ",
                    "SELECT * FROM xrcd_t "
      PREPARE repro_tbl2 FROM l_sql
      EXECUTE repro_tbl2
      FREE repro_tbl2
   
      #將符合條件的資料丟入TEMP TABLE
      INSERT INTO afap270_detail SELECT * FROM xrcd_t
                                  WHERE xrcdent = g_enterprise AND xrcdld = g_apca.apcald
                                  AND xrcddocno = l_fabu.fabudocno AND xrcdseq2=l_fabu.fabuseq
      
      
      #將key修正為調整後   
      UPDATE afap270_detail SET xrcddocno = g_apca.apcadocno,
                                xrcdseq   = g_apcb.apcbseq
           
      #將資料塞回原table   
      INSERT INTO xrcd_t SELECT * FROM afap270_detail
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('upd xrcd_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'upd xrcd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
      END IF
      #刪除TEMP TABLE
      DROP TABLE afap270_detail
      
      
      #更新單頭應付帳款單號
      UPDATE fabg_t SET fabg012 = g_apca.apcadocno
       WHERE fabgent=g_enterprise AND fabgld=g_apca.apcald 
         AND fabgdocno=l_fabu.fabudocno 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('upd fabg_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'upd fabg_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq 
      END IF
      
      #更新單身應付帳款單號
      UPDATE fabu_t SET fabu036 = g_apca.apcadocno
       WHERE fabuent=g_enterprise AND fabuld=g_apca.apcald 
         AND fabudocno=l_fabu.fabudocno AND fabuseq=l_fabu.fabuseq
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('upd fabu_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'upd fabu_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq
      END IF
      
      #151125-00006#1---add-s
      #执行立即审核
      CALL s_aooi200_fin_get_slip(l_fabu.fabudocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_afat503_immediately_conf(l_fabu.fabudocno ,'',g_apca.apcald,g_apca.apcadocdt,'afap270') 
              RETURNING l_success
      END IF 
      IF NOT l_success THEN
         LET g_success = 'N'
      END IF 
      #151125-00006#1---add-e
      
   END FOREACH
   
   #判斷是否產生單身，如果有資料，匯總金額更新單頭金額，否則刪除單頭資料
   SELECT COUNT(*) INTO l_cnt FROM apcb_t
    WHERE apcbent = g_enterprise AND apcbld = g_apca.apcald AND apcbdocno = g_apca.apcadocno 
   IF l_cnt > 0 THEN  
      SELECT SUM(apcb103),SUM(apcb104),SUM(apcb105),SUM(apcb113),SUM(apcb114),SUM(apcb115),
             SUM(apcb123),SUM(apcb124),SUM(apcb125),SUM(apcb133),SUM(apcb134),SUM(apcb135)  
        INTO g_apca.apca103,g_apca.apca104,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca118,
             g_apca.apca123,g_apca.apca124,g_apca.apca128,g_apca.apca133,g_apca.apca134,g_apca.apca138   
        FROM apcb_t
       WHERE apcbent = g_enterprise AND apcbld = g_apca.apcald AND apcbdocno = g_apca.apcadocno
      IF cl_null(g_apca.apca103) THEN LET g_apca.apca103 = 0 END IF 
      IF cl_null(g_apca.apca104) THEN LET g_apca.apca104 = 0 END IF 
      IF cl_null(g_apca.apca108) THEN LET g_apca.apca108 = 0 END IF
      IF cl_null(g_apca.apca113) THEN LET g_apca.apca113 = 0 END IF 
      IF cl_null(g_apca.apca114) THEN LET g_apca.apca114 = 0 END IF
      IF cl_null(g_apca.apca118) THEN LET g_apca.apca118 = 0 END IF
      IF cl_null(g_apca.apca123) THEN LET g_apca.apca123 = 0 END IF 
      IF cl_null(g_apca.apca124) THEN LET g_apca.apca124 = 0 END IF
      IF cl_null(g_apca.apca128) THEN LET g_apca.apca128 = 0 END IF
      IF cl_null(g_apca.apca133) THEN LET g_apca.apca133 = 0 END IF 
      IF cl_null(g_apca.apca134) THEN LET g_apca.apca134 = 0 END IF
      IF cl_null(g_apca.apca138) THEN LET g_apca.apca138 = 0 END IF
      UPDATE apca_t SET (apca103,apca104,apca108,apca113,apca114,apca118,
                         apca123,apca124,apca128,apca133,apca134,apca138)
                      = (g_apca.apca103,g_apca.apca104,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca118,
                         g_apca.apca123,g_apca.apca124,g_apca.apca128,g_apca.apca133,g_apca.apca134,g_apca.apca138) 
       WHERE apcaent = g_enterprise AND apcald = g_apca.apcald AND apcadocno = g_apca.apcadocno
      IF SQLCA.SQLCODE THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('upd apca_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'upd apca_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq 
      END IF  
   ELSE
      DELETE FROM apca_t WHERE apcaent = g_enterprise AND apcald = g_apca.apcald AND apcadocno = g_apca.apcadocno
      IF SQLCA.SQLCODE THEN 
         #150731-00004#1 20150807 str---
         #CALL cl_errmsg('delete apca_t','','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'delete apca_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150807 end---
         #LET g_success = 'N'   #151125-00006#1--mark by aiqq
         LET g_success = FALSE  #151125-00006#1--add by aiqq 
      END IF      
   END IF
   
   #151125-00006#1--add-s
   #生成分录底稿
   IF NOT cl_null(g_apca.apcadocno) AND g_apca.apcastus = 'N' THEN
      #获取单别
      CALL s_aooi200_fin_get_slip(g_apca.apcadocno) RETURNING l_success,l_ooba002
      #是否抛傳票
      CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
   
      IF l_dfin0030 = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_ooba002
         LET g_errparam.code   = 'axr-00225'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
     ELSE     
         CALL s_pre_voucher_ins('AR','R10',g_glaald,g_apca.apcadocno,g_apca.apcadocdt,'1')
            RETURNING l_success
         IF NOT l_success THEN
            LET g_success = FALSE
         END IF
     END IF 
   END IF
   #应付账款立即审核
   CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
   IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
      CALL s_aapp131_immediately_conf(g_apca.apcald,g_apca.apcacomp,g_apca.apcadocno)
            RETURNING l_success
   END IF
   IF NOT l_success THEN 
      LET g_success = FALSE  
   END IF 
   #151125-00006#1--add-e
END FUNCTION

################################################################################
# Descriptions...: 帳款對象帶出相關付款資料
# Memo...........:
# Usage..........: CALL afap270_apca004_ref()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_apca004_ref()
   DEFINE l_using     LIKE type_t.num5
   DEFINE l_oodb004   LIKE oodb_t.oodb004
   DEFINE l_oodb011   LIKE oodb_t.oodb011
   DEFINE l_desc      STRING
   DEFINE l_success   LIKE type_t.num5
   
   #付款對象
   IF NOT cl_null(g_apca.apca004) THEN #0921
      CALL s_apmm100_sel_pmac002(g_apca.apca004,'1') RETURNING g_apca.apca005,l_desc
   END IF
   
   #抓取客戶慣用收款條件 
   SELECT pmab037 INTO g_apca.apca008 FROM pmab_t
    WHERE pmabent = g_enterprise AND pmabsite = g_apca.apcacomp AND pmab001 = g_apca.apca005 
   
   #供應商分類/企業關係人
   SELECT pmaa080,pmaa047
     INTO g_apca.apca006,g_apca.apca046
     FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_apca.apca004
   #帳款資訊
   CALL s_aap_get_payment_term(g_apca.apcald,g_apca.apcacomp,g_apca.apca004,g_apca.apca001)
   RETURNING l_success,g_errno,g_apca.apca007,g_apca.apca008,g_apca.apca035,
             g_apca.apca036,g_apca.apca058,g_apca.apca100,g_apca.apca011,g_apca.apca014
   
   #依據付款條件帶出票到期日
   #付款日期/票據到期日
   CALL s_fin_date_ap_payable(g_apca.apcasite,g_apca.apca004,g_apca.apca008,g_apca.apcadocdt,
       g_apca.apcadocdt,g_apca.apcadocdt,g_apca.apcadocdt) RETURNING g_sub_success,g_apca.apca009,g_apca.apca010
   #多帳期設定/繳款優惠條件
   IF NOT cl_null(g_apca.apca008) THEN
      SELECT ooib025,ooib005 INTO g_apca.apca054,g_apca.apca055
        FROM ooib_t
       WHERE ooibent = g_enterprise AND ooib002 = g_apca.apca008
   END IF
   
   #稅別
   IF NOT cl_null(g_apca.apca011) THEN #0921
      CALL s_tax_chk(g_apca.apcacomp,g_apca.apca011) 
      RETURNING l_success,l_oodb004,g_apca.apca013,g_apca.apca012,l_oodb011
   END IF 
   #部門/人員
   CALL s_employee_get_dept(g_apca.apca014)    RETURNING l_success,g_errno,g_apca.apca015,l_desc
   #以部門去取aooi125設定的所屬責任中心,若抓不到值則帶業務部門
   IF NOT cl_null(g_apca.apca015) THEN
      CALL s_department_get_respon_center(g_apca.apca015,g_apca.apcadocdt)
           RETURNING l_success,g_errno,g_apca.apca034,l_desc
      IF NOT l_success THEN
         LET g_apca.apca034 = g_apca.apca015
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
################################################################################
PRIVATE FUNCTION afap270_get_ooef001_wc(p_wc)
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

################################################################################
# Descriptions...: 立即抛转传票
# Memo...........:
# Usage..........: CALL afap270_fabg_immediately_gen()
#                  RETURNING 回传参数
# Date & Author..: 2015/12/11 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_fabg_immediately_gen()
  #161215-00044#1---modify----begin----------------- 
  #DEFINE l_fabg           RECORD LIKE fabg_t.* 
  DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020  #資產性質
       END RECORD
  #161215-00044#1---modify----end-----------------
   DEFINE l_ooba002        LIKE ooba_t.ooba002
   DEFINE l_dfin0032       LIKE type_t.chr1
   DEFINE l_slip           LIKE type_t.chr20   
   DEFINE l_wc             STRING 
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_cate           LIKE type_t.chr10
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_fabgmoddt      LIKE fabg_t.fabgmoddt
   
    
     
     FOR l_ac=1 TO g_detail_d.getLength()
       IF g_detail_d[l_ac].sel='Y' THEN
          #161215-00044#1---modify----begin----------------
          #SELECT * INTO l_fabg.* 
          SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,
                 fabg006,fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,
                 fabg018,fabg019,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,
                 fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt,fabgud001,fabgud002,fabgud003,fabgud004,fabgud005,fabgud006,
                 fabgud007,fabgud008,fabgud009,fabgud010,fabgud011,fabgud012,fabgud013,fabgud014,fabgud015,fabgud016,
                 fabgud017,fabgud018,fabgud019,fabgud020,fabgud021,fabgud022,fabgud023,fabgud024,fabgud025,fabgud026,
                 fabgud027,fabgud028,fabgud029,fabgud030,fabg020 INTO l_fabg.* 
          #161215-00044#1---modify----end-----------------
          FROM fabg_t WHERE fabgent = g_enterprise
                        AND fabgdocno = g_detail_d[l_ac].fabgdocno AND fabgld = g_master.fabgld
         
          IF cl_null(l_fabg.fabgdocno) THEN RETURN END IF     #无此单号不做处理
          IF cl_null(l_fabg.fabgld) THEN RETURN END IF        #无账套不做处理  
          IF l_fabg.fabgstus != 'Y' THEN RETURN END IF        #未审核不做处理
          IF NOT cl_null(l_fabg.fabg008) THEN RETURN END IF   #已有传票不做处理
          
          #获取单别
          CALL s_aooi200_fin_get_slip(l_fabg.fabgdocno) RETURNING l_success,l_ooba002 
         
          #判断是否可直接抛转
          CALL s_fin_get_doc_para(l_fabg.fabgld,l_fabg.fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
          
          #161221-00011#1--add--str--lujh
          IF cl_null(l_dfin0032) OR l_dfin0032 = 'N' THEN
             CONTINUE FOR
          END IF
          #161221-00011#1--add--end--lujh
          
          #获取默认单别
          CALL s_fin_get_doc_para(l_fabg.fabgld,l_fabg.fabgcomp,l_ooba002,'D-FIN-2002') RETURNING l_slip
          
          #不存在默认单别，不抛转
          IF cl_null(l_slip) THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "" 
             LET g_errparam.code   = "axr-00987" 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             EXIT FOR 
          END IF  
          
          DROP TABLE s_pre_vr_tmp01;    #160727-00019#34   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01                        
          CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
         
          CASE l_fabg.fabg005
              WHEN '0'
                 LET l_cate =  'F30'  
              WHEN '4'
                 LET l_cate =  'F40'  
              WHEN '6'
                 LET l_cate =  'F50'  
              WHEN '8'
                 LET l_cate =  'F50' 
              WHEN '14'
                 LET l_cate =  'F50'  
              WHEN '21'
                 LET l_cate =  'F50'
              WHEN '9'
                 LET l_cate =  'F50'   
              WHEN '31'              
                 LET l_cate =  'F50'    
              OTHERWISE                          
                 LET l_cate =  'F50'             
           END CASE  
          
           #161215-00044#1---modify----begin-----------------
           #SELECT * INTO g_glaa.* 
           SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
           glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
           glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
           glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
           glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
           glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
           #161215-00044#1---modify----end-----------------
           FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_fabg.fabgld
           IF g_glaa.glaa121 = 'Y' THEN 
              CALL s_transaction_begin()
              CALL cl_err_collect_init() 
                           
              LET l_wc =" glgbdocno IN ('",l_fabg.fabgdocno,"')"     
                
              CALL s_pre_voucher_ins_glap('FA',l_cate,l_fabg.fabgld,l_fabg.fabgdocdt,l_slip,g_master.type,l_wc) 
                   RETURNING r_success,l_fabg.fabg008,l_fabg.fabg008
           ELSE 
              CALL afap280_01_p(l_fabg.fabg005,l_fabg.fabgld,g_master.type,l_slip,l_fabg.fabgdocdt) 
                   RETURNING l_fabg.fabg008,l_fabg.fabg008
           END IF  
           
           #更新传票单号
           LET l_fabgmoddt = cl_get_current()
           #UPDATE fabg_t SET fabg008 = r_start_no,      #161221-00011#1 mark lujh
           UPDATE fabg_t SET fabg008 = l_fabg.fabg008,   #161221-00011#1 add lujh
                             fabgmodid= g_user,
                             fabgmoddt= l_fabgmoddt
                       WHERE fabgent = g_enterprise
                         AND fabgdocno = l_fabg.fabgdocno                 
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = "" 
              LET g_errparam.code   = SQLCA.sqlcode 
              LET g_errparam.popup  = FALSE 
              CALL cl_err()
              LET r_success = FALSE
           END IF
           
           IF r_success THEN
              CALL s_transaction_end('Y','1')
           ELSE
              IF cl_null(l_fabg.fabg008) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'axc-00530' 
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              ELSE
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'axr-00120' 
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              END IF
              CALL s_transaction_end('N','0')    
           END IF
                    
       END IF 
       
     END FOR 
END FUNCTION

################################################################################
# Descriptions...: 应付账款立即抛转
# Memo...........:
# Usage..........: CALL afap270_xrca_immediately_gen()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/14 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_xrca_immediately_gen()
    #161215-00044#1---modify----begin-----------------
    #DEFINE l_xrca       RECORD LIKE xrca_t.*
    DEFINE l_xrca RECORD  #應收憑單單頭
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
       xrca138 LIKE xrca_t.xrca138, #本位幣三應收金額
       xrcaud001 LIKE xrca_t.xrcaud001, #自定義欄位(文字)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定義欄位(文字)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定義欄位(文字)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定義欄位(文字)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定義欄位(文字)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定義欄位(文字)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定義欄位(文字)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定義欄位(文字)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定義欄位(文字)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定義欄位(文字)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定義欄位(數字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定義欄位(數字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定義欄位(數字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定義欄位(數字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定義欄位(數字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定義欄位(數字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定義欄位(數字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定義欄位(數字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定義欄位(數字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定義欄位(數字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定義欄位(日期時間)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定義欄位(日期時間)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定義欄位(日期時間)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定義欄位(日期時間)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定義欄位(日期時間)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定義欄位(日期時間)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定義欄位(日期時間)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定義欄位(日期時間)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定義欄位(日期時間)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定義欄位(日期時間)030
       END RECORD

    #161215-00044#1---modify----end-----------------
    DEFINE l_sql        STRING 
    DEFINE l_ooba002    LIKE ooba_t.ooba002
    DEFINE l_dfin0032   LIKE type_t.chr1
    DEFINE l_gl_slip    LIKE type_t.chr20
    DEFINE l_success    LIKE type_t.num5
    DEFINE l_glaa121    LIKE glaa_t.glaa121
    DEFINE r_success    LIKE type_t.num5
    DEFINE r_start_no   LIKE xrca_t.xrcadocno
    DEFINE r_end_no     LIKE xrca_t.xrcadocno
    DEFINE l_wc         STRING 
    DEFINE l_xrcamoddt  LIKE xrca_t.xrcamoddt
    
    
    FOR l_ac=1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel='Y' THEN
         #161215-00044#1---modify----begin-----------------
         #SELECT * INTO l_xrca.* FROM xrca_t 
         SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,
                xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,xrca003,xrca004,
                xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,
                xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,
                xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,
                xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,
                xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,xrca064,xrca065,
                xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,xrca116,xrca117,
                xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,
                xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,xrcaud005,xrcaud006,xrcaud007,
                xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,xrcaud015,xrcaud016,
                xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,xrcaud025,
                xrcaud026,xrcaud027,xrcaud028,xrcaud029,xrcaud030 INTO l_xrca.* FROM xrca_t 
         #161215-00044#1---modify----end-----------------
                               WHERE xrcaent = g_enterprise
                                 AND xrcadocno in 
                                 (select fabg011 FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_detail_d[l_ac].fabgdocno AND fabgld = g_master.fabgld) 
   
           #获取单别
           CALL s_aooi200_fin_get_slip(l_xrca.xrcadocno) RETURNING l_success,l_ooba002
           #是否可立即抛转
           CALL s_fin_get_doc_para(l_xrca.xrcald,l_xrca.xrcacomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
           #抛转默认单据别
           CALL s_fin_get_doc_para(l_xrca.xrcald,l_xrca.xrcacomp,l_ooba002,'D-FIN-2002') RETURNING l_gl_slip
           IF NOT cl_null(l_gl_slip) THEN 
              IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN 
              
                     IF cl_null(l_xrca.xrcald)    THEN RETURN END IF   #無資料直接返回不做處理
                     IF cl_null(l_xrca.xrcadocno) THEN RETURN END IF   #無資料直接返回不做處理
                     IF l_xrca.xrcastus <> 'Y' THEN RETURN END IF      #未审核直接返回不做处理
                     
                     CALL s_transaction_begin()
                     
                     #是否产生分录底稿
                     SELECT glaa121 INTO l_glaa121
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaald = l_xrca.xrcald
                        
                     IF l_glaa121 = 'Y' THEN 
                        LET l_wc =" xrcadocno = '",l_xrca.xrcadocno,"' "
                        CALL s_voucher_gen_ar('1',l_xrca.xrcald,l_xrca.xrcadocdt,l_gl_slip,1,l_wc,'N') 
                             RETURNING r_success,r_start_no,r_end_no
                     END IF
                    
                     #更新传票单号
                     LET l_xrcamoddt = cl_get_current()
                     UPDATE xrca_t SET xrca038 = r_start_no,
                                       xrcamodid= g_user,
                                       xrcamoddt= l_xrcamoddt
                                 WHERE xrcaent = g_enterprise
                                   AND xrcadocno = l_xrca.xrcadocno                 
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET r_success = FALSE
                     END IF
                     
                     IF r_success THEN
                        CALL s_transaction_end('Y','1')
                     ELSE
                        IF cl_null(r_start_no) THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'axc-00530' 
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'axr-00120' 
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        END IF
                        CALL s_transaction_end('N','0')    
                     END IF
              END IF  
           END IF 
      END IF 
           
   END FOR    
        
END FUNCTION

################################################################################
# Descriptions...: 应付账款立即抛转
# Memo...........:
# Usage..........: CALL afap270_apca_immediately_gen()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/14 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_apca_immediately_gen()
    #161215-00044#1---modify----begin-----------------
    #DEFINE l_apca       RECORD LIKE apca_t.*
    DEFINE l_apca RECORD  #應付憑單單頭
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
    #161215-00044#1---modify----end-----------------
    DEFINE l_sql        STRING 
    DEFINE l_ooba002    LIKE ooba_t.ooba002
    DEFINE l_dfin0032   LIKE type_t.chr1
    DEFINE l_gl_slip    LIKE type_t.chr20
    DEFINE l_success    LIKE type_t.num5

    FOR l_ac=1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel='Y' THEN
        #161215-00044#1---modify----begin-----------------
        #SELECT * INTO l_apca.* FROM apca_t 
        SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,
               apcacnfdt,apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,apca001,
               apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,apca013,apca014,
               apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,apca026,apca027,apca028,
               apca029,apca030,apca031,apca032,apca033,apca034,apca035,apca036,apca037,apca038,apca039,apca040,
               apca041,apca042,apca043,apca044,apca045,apca046,apca047,apca048,apca049,apca050,apca051,apca052,
               apca053,apca054,apca055,apca056,apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca064,
               apca065,apca066,apca100,apca101,apca103,apca104,apca106,apca107,apca108,apca113,apca114,apca116,
               apca117,apca118,apca120,apca121,apca123,apca124,apca126,apca127,apca128,apca130,apca131,apca133,
               apca134,apca136,apca137,apca138,apcaud001,apcaud002,apcaud003,apcaud004,apcaud005,apcaud006,
               apcaud007,apcaud008,apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,apcaud014,apcaud015,
               apcaud016,apcaud017,apcaud018,apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,apcaud024,
               apcaud025,apcaud026,apcaud027,apcaud028,apcaud029,apcaud030,apca067,apca068,apca069,apca070,
               apca071,apca072,apca073 INTO l_apca.* FROM apca_t 
        #161215-00044#1---modify----end-----------------
                               WHERE apcaent = g_enterprise
                                 AND apcadocno in 
                                 (select fabg012 FROM fabg_t WHERE fabgent = g_enterprise AND fabgdocno = g_detail_d[l_ac].fabgdocno AND fabgld = g_master.fabgld) 
            CALL s_aapp131_immediately_gen(l_apca.apcald,l_apca.apcacomp,l_apca.apcadocno)
       END IF 
    END FOR
    
END FUNCTION
# Descriptions...: 插入應收帳款(xrca_t xrcb_t xrcc_t xrcd_t)
# Memo...........:
# Usage..........: CALL afap270_xrca_ins_43()
# Modify.........: #160426-00014#45 add lujh
PRIVATE FUNCTION afap270_xrca_ins_43()
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_fabg          RECORD LIKE fabg_t.*
   #DEFINE l_faca          RECORD LIKE faca_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020  #資產性質
       END RECORD
    DEFINE l_faca RECORD  #調撥帳務單身檔
       facaent LIKE faca_t.facaent, #企業代碼
       facald LIKE faca_t.facald, #帳套
       facadocno LIKE faca_t.facadocno, #單號
       facaseq LIKE faca_t.facaseq, #項次
       faca001 LIKE faca_t.faca001, #來源單號
       faca002 LIKE faca_t.faca002, #來源項次
       faca003 LIKE faca_t.faca003, #財產編號
       faca004 LIKE faca_t.faca004, #附號
       faca005 LIKE faca_t.faca005, #卡片編號
       faca006 LIKE faca_t.faca006, #單位
       faca007 LIKE faca_t.faca007, #单价
       faca008 LIKE faca_t.faca008, #調撥數量
       faca009 LIKE faca_t.faca009, #調撥成本
       faca010 LIKE faca_t.faca010, #稅別
       faca011 LIKE faca_t.faca011, #原幣未稅金額
       faca012 LIKE faca_t.faca012, #原幣稅額
       faca013 LIKE faca_t.faca013, #原幣應收金額
       faca014 LIKE faca_t.faca014, #本幣未稅金額
       faca015 LIKE faca_t.faca015, #本幣稅額
       faca016 LIKE faca_t.faca016, #本幣應收金額
       faca017 LIKE faca_t.faca017, #稅率
       faca018 LIKE faca_t.faca018, #處置損益
       faca019 LIKE faca_t.faca019, #異動科目
       faca020 LIKE faca_t.faca020, #累折科目
       faca021 LIKE faca_t.faca021, #減值準備科目
       faca022 LIKE faca_t.faca022, #資產科目
       faca023 LIKE faca_t.faca023, #應收/付帳款科目
       faca024 LIKE faca_t.faca024, #稅額科目
       faca025 LIKE faca_t.faca025, #營運據點
       faca026 LIKE faca_t.faca026, #部門
       faca027 LIKE faca_t.faca027, #利潤/成本中心
       faca028 LIKE faca_t.faca028, #區域
       faca029 LIKE faca_t.faca029, #交易客商
       faca030 LIKE faca_t.faca030, #帳款客商
       faca031 LIKE faca_t.faca031, #客群
       faca032 LIKE faca_t.faca032, #人員
       faca033 LIKE faca_t.faca033, #專案編號
       faca034 LIKE faca_t.faca034, #WBS
       faca035 LIKE faca_t.faca035, #帳款編號
       faca036 LIKE faca_t.faca036, #摘要
       faca037 LIKE faca_t.faca037, #應收/付帳款單號
       faca038 LIKE faca_t.faca038, #本位幣二幣別
       faca039 LIKE faca_t.faca039, #本位幣二匯率
       faca040 LIKE faca_t.faca040, #本位幣二未稅金額
       faca041 LIKE faca_t.faca041, #本位幣二稅額
       faca042 LIKE faca_t.faca042, #本位幣二應收金額
       faca043 LIKE faca_t.faca043, #本位幣二調撥成本
       faca044 LIKE faca_t.faca044, #本位幣二處置損益
       faca045 LIKE faca_t.faca045, #本位幣三幣別
       faca046 LIKE faca_t.faca046, #本位幣三匯率
       faca047 LIKE faca_t.faca047, #本位幣三未稅金額
       faca048 LIKE faca_t.faca048, #本位幣三稅額
       faca049 LIKE faca_t.faca049, #本位幣三應收金額
       faca050 LIKE faca_t.faca050, #本位幣三調撥成本
       faca051 LIKE faca_t.faca051, #本位幣三處置損益
       faca052 LIKE faca_t.faca052, #經營方式
       faca053 LIKE faca_t.faca053, #通路
       faca054 LIKE faca_t.faca054, #品牌
       faca055 LIKE faca_t.faca055, #自由核算項一
       faca056 LIKE faca_t.faca056, #自由核算項二
       faca057 LIKE faca_t.faca057, #自由核算項三
       faca058 LIKE faca_t.faca058, #自由核算項四
       faca059 LIKE faca_t.faca059, #自由核算項五
       faca060 LIKE faca_t.faca060, #自由核算項六
       faca061 LIKE faca_t.faca061, #自由核算項七
       faca062 LIKE faca_t.faca062, #自由核算項八
       faca063 LIKE faca_t.faca063, #自由核算項九
       faca064 LIKE faca_t.faca064, #自由核算項十
       faca065 LIKE faca_t.faca065, #產品類別
       facaud001 LIKE faca_t.facaud001, #自定義欄位(文字)001
       facaud002 LIKE faca_t.facaud002, #自定義欄位(文字)002
       facaud003 LIKE faca_t.facaud003, #自定義欄位(文字)003
       facaud004 LIKE faca_t.facaud004, #自定義欄位(文字)004
       facaud005 LIKE faca_t.facaud005, #自定義欄位(文字)005
       facaud006 LIKE faca_t.facaud006, #自定義欄位(文字)006
       facaud007 LIKE faca_t.facaud007, #自定義欄位(文字)007
       facaud008 LIKE faca_t.facaud008, #自定義欄位(文字)008
       facaud009 LIKE faca_t.facaud009, #自定義欄位(文字)009
       facaud010 LIKE faca_t.facaud010, #自定義欄位(文字)010
       facaud011 LIKE faca_t.facaud011, #自定義欄位(數字)011
       facaud012 LIKE faca_t.facaud012, #自定義欄位(數字)012
       facaud013 LIKE faca_t.facaud013, #自定義欄位(數字)013
       facaud014 LIKE faca_t.facaud014, #自定義欄位(數字)014
       facaud015 LIKE faca_t.facaud015, #自定義欄位(數字)015
       facaud016 LIKE faca_t.facaud016, #自定義欄位(數字)016
       facaud017 LIKE faca_t.facaud017, #自定義欄位(數字)017
       facaud018 LIKE faca_t.facaud018, #自定義欄位(數字)018
       facaud019 LIKE faca_t.facaud019, #自定義欄位(數字)019
       facaud020 LIKE faca_t.facaud020, #自定義欄位(數字)020
       facaud021 LIKE faca_t.facaud021, #自定義欄位(日期時間)021
       facaud022 LIKE faca_t.facaud022, #自定義欄位(日期時間)022
       facaud023 LIKE faca_t.facaud023, #自定義欄位(日期時間)023
       facaud024 LIKE faca_t.facaud024, #自定義欄位(日期時間)024
       facaud025 LIKE faca_t.facaud025, #自定義欄位(日期時間)025
       facaud026 LIKE faca_t.facaud026, #自定義欄位(日期時間)026
       facaud027 LIKE faca_t.facaud027, #自定義欄位(日期時間)027
       facaud028 LIKE faca_t.facaud028, #自定義欄位(日期時間)028
       facaud029 LIKE faca_t.facaud029, #自定義欄位(日期時間)029
       facaud030 LIKE faca_t.facaud030  #自定義欄位(日期時間)030
       END RECORD
   #161215-00044#1---modify----end-----------------
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_xrcbseq       LIKE xrcb_t.xrcbseq
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_sql           STRING
   DEFINE l_wc            STRING
   DEFINE l_ooba002       LIKE ooba_t.ooba002
   DEFINE l_dfin0030      LIKE type_t.chr1
   DEFINE l_dfin0031      LIKE type_t.chr1
   DEFINE l_conf_success  LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003 
   DEFINE l_glaa024       LIKE glaa_t.glaa024 
   DEFINE l_oodb008       LIKE oodb_t.oodb008 
   
   INITIALIZE l_fabg.* TO NULL
   LET l_fabg.fabgld = g_master.fabgld
   LET l_fabg.fabg013 = g_detail_d[l_ac].fabg013 #稅別
   LET l_fabg.fabg015 = g_detail_d[l_ac].fabg015 #幣別
   #依單號匯總
   IF g_master.type='1' THEN
      LET l_fabg.fabgdocno = g_detail_d[l_ac].fabgdocno
      SELECT fabg001,fabg006,fabg007,fabg016 
        INTO l_fabg.fabg001,l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg016
        FROM fabg_t
       WHERE fabgent = g_enterprise 
         AND fabgld = g_master.fabgld
         AND fabgdocno = g_detail_d[l_ac].fabgdocno
   ELSE #依帳款客戶匯總
      LET l_fabg.fabg006 = g_detail_d[l_ac].fabg006
   END IF
   SELECT glaacomp INTO l_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_input.xrcald
      
   INITIALIZE g_xrca.* TO NULL
   
   LET l_sql = "SELECT glaald,glaa024,glaa003 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.fabgld,"'", 
               " ORDER BY glaa023 "   
   PREPARE pre_glaald_43 FROM l_sql
   DECLARE sel_glaald_43 CURSOR FOR pre_glaald_43
   FOREACH sel_glaald_43 INTO g_xrca.xrcald,l_glaa024,l_glaa003 
      #插入單頭
      LET g_xrca.xrcaent = g_enterprise
      LET g_xrca.xrcaownid = g_user
      LET g_xrca.xrcaowndp = g_dept
      LET g_xrca.xrcacrtid = g_user
      LET g_xrca.xrcacrtdp = g_dept 
      LET g_xrca.xrcacrtdt = cl_get_current()
      LET g_xrca.xrcamodid = ""
      LET g_xrca.xrcamoddt = ""
      LET g_xrca.xrcastus = "N"
      LET g_xrca.xrcacomp = l_glaacomp
      #單據日期
      LET g_xrca.xrcadocdt= g_input.xrcadocdt
      #单据编号
      CALL s_aooi200_fin_gen_docno(g_xrca.xrcald,l_glaa024,l_glaa003,g_input.xrcadocno,g_input.xrcadocdt,'axrt330') 
      RETURNING l_success,g_xrca.xrcadocno
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE  
         CONTINUE FOREACH       
      END IF 
      LET g_xrca.xrca001 = '19' #其他應收帳款
      LET g_xrca.xrcasite = g_input.xrcasite
      LET g_xrca.xrca003 = l_fabg.fabg001  #帳務人員
      LET g_xrca.xrca004 = l_fabg.fabg006  #帳款客戶
      LET g_xrca.xrca005 = l_fabg.fabg007  #收款客戶
      LET g_xrca.xrca011 = l_fabg.fabg013  #稅別
      CALL afap270_xrca004_ref()
      LET g_xrca.xrca016 = '15'
      LET g_xrca.xrca017 = 0  
      LET g_xrca.xrca018 = g_detail_d[l_ac].fabgdocno
      LET g_xrca.xrca020 = 'N'     
      LET g_xrca.xrca030 = 0
      LET g_xrca.xrca031 = 0
      LET g_xrca.xrca032 = 0
      LET g_xrca.xrca037 = 'N'
      LET g_xrca.xrca039 = 0
      LET g_xrca.xrca040 = 'N'
      LET g_xrca.xrca044 = 0
      LET g_xrca.xrca052 = 0
      SELECT oodb008 INTO l_oodb008
        FROM oodb_t,ooef_t 
       WHERE ooefent = oodbent AND oodb001 = ooef019 AND ooef001 = g_xrca.xrcacomp 
         AND oodbent= g_enterprise AND oodb002=g_xrca.xrca011
         
      CASE l_oodb008
         WHEN '1'
            LET g_xrca.xrca060 = 2
         WHEN '2'
            LET g_xrca.xrca060 = 1
         WHEN '3'
            LET g_xrca.xrca060 = 3
         OTHERWISE
            LET g_xrca.xrca060 = 1         
      END CASE
      LET g_xrca.xrca062 = '1'
      LET g_xrca.xrca100 = l_fabg.fabg015  #交易原幣
      LET g_xrca.xrca101 = l_fabg.fabg016
      SELECT DISTINCT faca038,faca039,faca045,faca046 
        INTO g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca130,g_xrca.xrca131
        FROM faca_t
       WHERE facaent = g_enterprise 
         AND facald = l_fabg.fabgld 
         AND facadocno = l_fabg.fabgdocno
      
      LET g_xrca.xrca103 = 0
      LET g_xrca.xrca104 = 0
      LET g_xrca.xrca106 = 0
      LET g_xrca.xrca107 = 0
      LET g_xrca.xrca108 = 0
      LET g_xrca.xrca113 = 0
      LET g_xrca.xrca114 = 0
      LET g_xrca.xrca116 = 0
      LET g_xrca.xrca117 = 0
      LET g_xrca.xrca118 = 0
      
      LET g_xrca.xrca123 = 0
      LET g_xrca.xrca124 = 0
      LET g_xrca.xrca126 = 0
      LET g_xrca.xrca127 = 0
      LET g_xrca.xrca128 = 0
       
      LET g_xrca.xrca133 = 0
      LET g_xrca.xrca134 = 0
      LET g_xrca.xrca136 = 0
      LET g_xrca.xrca137 = 0
      LET g_xrca.xrca138 = 0
      
      #161215-00044#1---modify----begin-----------------
      #INSERT INTO xrca_t VALUES (g_xrca.*)
      INSERT INTO xrca_t (xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
                          xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,
                          xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,
                          xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
                          xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,
                          xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,
                          xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
                          xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,
                          xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,
                          xrca133,xrca134,xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,xrcaud005,xrcaud006,
                          xrcaud007,xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,xrcaud015,xrcaud016,
                          xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,xrcaud025,xrcaud026,
                          xrcaud027,xrcaud028,xrcaud029,xrcaud030)
       VALUES (g_xrca.xrcaent,g_xrca.xrcaownid,g_xrca.xrcaowndp,g_xrca.xrcacrtid,g_xrca.xrcacrtdp,g_xrca.xrcacrtdt,g_xrca.xrcamodid,g_xrca.xrcamoddt,g_xrca.xrcacnfid,
               g_xrca.xrcacnfdt,g_xrca.xrcapstid,g_xrca.xrcapstdt,g_xrca.xrcastus,g_xrca.xrcacomp,g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt,g_xrca.xrca001,g_xrca.xrcasite,
               g_xrca.xrca003,g_xrca.xrca004,g_xrca.xrca005,g_xrca.xrca006,g_xrca.xrca007,g_xrca.xrca008,g_xrca.xrca009,g_xrca.xrca010,g_xrca.xrca011,g_xrca.xrca012,g_xrca.xrca013,g_xrca.xrca014,
               g_xrca.xrca015,g_xrca.xrca016,g_xrca.xrca017,g_xrca.xrca018,g_xrca.xrca019,g_xrca.xrca020,g_xrca.xrca021,g_xrca.xrca022,g_xrca.xrca023,g_xrca.xrca024,g_xrca.xrca025,g_xrca.xrca026,
               g_xrca.xrca028,g_xrca.xrca029,g_xrca.xrca030,g_xrca.xrca031,g_xrca.xrca032,g_xrca.xrca033,g_xrca.xrca034,g_xrca.xrca035,g_xrca.xrca036,g_xrca.xrca037,g_xrca.xrca038,g_xrca.xrca039,
               g_xrca.xrca040,g_xrca.xrca041,g_xrca.xrca042,g_xrca.xrca043,g_xrca.xrca044,g_xrca.xrca045,g_xrca.xrca046,g_xrca.xrca047,g_xrca.xrca048,g_xrca.xrca049,g_xrca.xrca050,g_xrca.xrca051,
               g_xrca.xrca052,g_xrca.xrca053,g_xrca.xrca054,g_xrca.xrca055,g_xrca.xrca056,g_xrca.xrca057,g_xrca.xrca058,g_xrca.xrca059,g_xrca.xrca060,g_xrca.xrca061,g_xrca.xrca062,g_xrca.xrca063,
               g_xrca.xrca064,g_xrca.xrca065,g_xrca.xrca066,g_xrca.xrca100,g_xrca.xrca101,g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca106,g_xrca.xrca107,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,
               g_xrca.xrca116,g_xrca.xrca117,g_xrca.xrca118,g_xrca.xrca120,g_xrca.xrca121,g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca126,g_xrca.xrca127,g_xrca.xrca128,g_xrca.xrca130,g_xrca.xrca131,
               g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca136,g_xrca.xrca137,g_xrca.xrca138,g_xrca.xrcaud001,g_xrca.xrcaud002,g_xrca.xrcaud003,g_xrca.xrcaud004,g_xrca.xrcaud005,g_xrca.xrcaud006,
               g_xrca.xrcaud007,g_xrca.xrcaud008,g_xrca.xrcaud009,g_xrca.xrcaud010,g_xrca.xrcaud011,g_xrca.xrcaud012,g_xrca.xrcaud013,g_xrca.xrcaud014,g_xrca.xrcaud015,g_xrca.xrcaud016,
               g_xrca.xrcaud017,g_xrca.xrcaud018,g_xrca.xrcaud019,g_xrca.xrcaud020,g_xrca.xrcaud021,g_xrca.xrcaud022,g_xrca.xrcaud023,g_xrca.xrcaud024,g_xrca.xrcaud025,g_xrca.xrcaud026,
               g_xrca.xrcaud027,g_xrca.xrcaud028,g_xrca.xrcaud029,g_xrca.xrcaud030)
      #161215-00044#1---modify----end-----------------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'ins xrca_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE  
      END IF
      
      #記錄第一張應收單單號
      IF cl_null(g_input.docno_s) THEN
         LET g_input.docno_s=g_xrca.xrcadocno
      END IF
      
      #插入單身
      #161215-00044#1---modify----begin----------------
      #LET g_sql="SELECT faca_t.* ",
      LET g_sql="SELECT facaent,facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca006,faca007,",
                "faca008,faca009,faca010,faca011,faca012,faca013,faca014,faca015,faca016,faca017,faca018,faca019,",
                "faca020,faca021,faca022,faca023,faca024,faca025,faca026,faca027,faca028,faca029,faca030,faca031,",
                "faca032,faca033,faca034,faca035,faca036,faca037,faca038,faca039,faca040,faca041,faca042,faca043,",
                "faca044,faca045,faca046,faca047,faca048,faca049,faca050,faca051,faca052,faca053,faca054,faca055,",
                "faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063,faca064,faca065,facaud001,",
                "facaud002,facaud003,facaud004,facaud005,facaud006,facaud007,facaud008,facaud009,facaud010,facaud011,",
                "facaud012,facaud013,facaud014,facaud015,facaud016,facaud017,facaud018,facaud019,facaud020,facaud021,",
                "facaud022,facaud023,facaud024,facaud025,facaud026,facaud027,facaud028,facaud029,facaud030 ",
      #161215-00044#1---modify----end-----------------
                "  FROM fabg_t,faca_t",
                " WHERE fabgent = facaent ",
                "   AND fabgld = facald ",
                "   AND fabgdocno = facadocno ",
                "   AND fabgent = ",g_enterprise,
                "   AND fabgld = '",g_master.fabgld,"'",
                "   AND fabg005 = '43' ",
                "   AND (fabgstus = 'Y' OR fabgstus = 'S') ",    
                "   AND fabg011 IS NULL ",
                "   AND fabg015 = '",g_detail_d[l_ac].fabg015,"'",
                "   AND fabg013 = '",g_detail_d[l_ac].fabg013,"'",
                "   AND ",g_master.wc
      IF g_master.type = '1' THEN
         LET g_sql=g_sql," AND fabgdocno = '",g_detail_d[l_ac].fabgdocno,"' "
      ELSE
         LET g_sql=g_sql," AND fabg006 = '",g_detail_d[l_ac].fabg006,"' "
      END IF
         
      LET g_sql=g_sql," ORDER BY facadocno,facaseq"
      
      PREPARE afap270_xrcb_pre FROM g_sql
      DECLARE afap270_xrcb_cs CURSOR FOR afap270_xrcb_pre
      LET l_xrcbseq =0
      
      FOREACH afap270_xrcb_cs INTO l_faca.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'foreach'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
            EXIT FOREACH
         END IF
         LET l_xrcbseq = l_xrcbseq + 1
            
         INITIALIZE g_xrcb.* TO NULL
         LET g_xrcb.xrcbent = g_enterprise
         LET g_xrcb.xrcbld  = g_xrca.xrcald
         LET g_xrcb.xrcbdocno = g_xrca.xrcadocno
         LET g_xrcb.xrcbseq = l_xrcbseq
         LET g_xrcb.xrcbsite= g_xrca.xrcasite    #營運據點
         #來源組織
         SELECT faah028 INTO g_xrcb.xrcborga FROM faah_t
          WHERE faahent = g_enterprise AND faah001 = l_faca.faca005
            AND faah003 = l_faca.faca003 AND faah004 = l_faca.faca004
         LET g_xrcb.xrcb001 = '15'               #來源類型
         LET g_xrcb.xrcb002 = l_faca.facadocno   #來源單號
         LET g_xrcb.xrcb003 = l_faca.facaseq     #來源項次
         LET g_xrcb.xrcb004 = ''
         LET g_xrcb.xrcb005 = ''
         LET g_xrcb.xrcb006 = l_faca.faca006
         LET g_xrcb.xrcb007 = l_faca.faca008
         LET g_xrcb.xrcb008 = ''
         LET g_xrcb.xrcb009 = ''
         LET g_xrcb.xrcblegl= g_xrca.xrcacomp    #核算組織
         LET g_xrcb.xrcb010 = g_xrca.xrca015
         LET g_xrcb.xrcb011 = g_xrca.xrca034
         LET g_xrcb.xrcb012 = l_faca.faca065     #產品類別
         LET g_xrcb.xrcb013 = '' #
         LET g_xrcb.xrcb014 = ''
         LET g_xrcb.xrcb015 = l_faca.faca033     #專案代碼
         LET g_xrcb.xrcb016 = l_faca.faca034     #WBS 
         LET g_xrcb.xrcb017 = ''                 #預算項目
         LET g_xrcb.xrcb018 = ''                 #客戶編號 
         LET g_xrcb.xrcb019 = ''
         LET g_xrcb.xrcb020 = l_faca.faca010
         LET g_xrcb.xrcb021 = g_xrca.xrca036 
         LET g_xrcb.xrcb022 = 1  #正負值
         LET g_xrcb.xrcb023 = 'N'
         LET g_xrcb.xrcb024 = l_faca.faca028     #區域
         LET g_xrcb.xrcb025 = ''
         LET g_xrcb.xrcb026 = ''
         LET g_xrcb.xrcb027 = ''
         LET g_xrcb.xrcb028 = ''
         LET g_xrcb.xrcb029 = g_xrca.xrca035     #收入會計科目
         LET g_xrcb.xrcb030 = 0
         LET g_xrcb.xrcb031 = g_xrca.xrca008     #收款條件
         LET g_xrcb.xrcb033 = l_faca.faca052     #經營方式
         LET g_xrcb.xrcb034 = l_faca.faca053     #通路
         LET g_xrcb.xrcb035 = l_faca.faca054     #品牌
         LET g_xrcb.xrcb036 = l_faca.faca031     #客群
         LET g_xrcb.xrcb037 = l_faca.faca055     #自由核算項一
         LET g_xrcb.xrcb038 = l_faca.faca056     #自由核算項二
         LET g_xrcb.xrcb039 = l_faca.faca057     #自由核算項三
         LET g_xrcb.xrcb040 = l_faca.faca058     #自由核算項四
         LET g_xrcb.xrcb041 = l_faca.faca059     #自由核算項五
         LET g_xrcb.xrcb042 = l_faca.faca060     #自由核算項六
         LET g_xrcb.xrcb043 = l_faca.faca061     #自由核算項七
         LET g_xrcb.xrcb044 = l_faca.faca062     #自由核算項八
         LET g_xrcb.xrcb045 = l_faca.faca063     #自由核算項九
         LET g_xrcb.xrcb046 = l_faca.faca064     #自由核算項十
         LET g_xrcb.xrcb047 = l_faca.faca036     #摘要
         LET g_xrcb.xrcb100 = l_fabg.fabg015
         LET g_xrcb.xrcb101 = l_faca.faca007     #原幣單價
         LET g_xrcb.xrcb103 = l_faca.faca011
         LET g_xrcb.xrcb104 = l_faca.faca012
         LET g_xrcb.xrcb105 = l_faca.faca013
         LET g_xrcb.xrcb106 = 0
         LET g_xrcb.xrcb111 = g_xrcb.xrcb101 * g_xrca.xrca101 #本幣單價
         LET g_xrcb.xrcb113 = l_faca.faca014
         LET g_xrcb.xrcb114 = l_faca.faca015
         LET g_xrcb.xrcb115 = l_faca.faca016
         LET g_xrcb.xrcb116 = 0
         LET g_xrcb.xrcb117 = 0
         LET g_xrcb.xrcb118 = g_xrcb.xrcb113
         LET g_xrcb.xrcb119 = g_xrcb.xrcb115
         LET g_xrcb.xrcb123 = l_faca.faca040
         LET g_xrcb.xrcb124 = l_faca.faca041
         LET g_xrcb.xrcb125 = l_faca.faca042
         LET g_xrcb.xrcb126 = 0
         LET g_xrcb.xrcb133 = l_faca.faca047
         LET g_xrcb.xrcb134 = l_faca.faca048
         LET g_xrcb.xrcb135 = l_faca.faca049
         LET g_xrcb.xrcb136 = 0
          
          #161215-00044#1---modify----begin-----------------
         #INSERT INTO xrcb_t VALUES (g_xrcb.*)
         INSERT INTO xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
                             xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
                             xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
                             xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
                             xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
                             xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
                             xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
                             xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
                             xrcb134,xrcb135,xrcb136,xrcbud001,xrcbud002,xrcbud003,xrcbud004,xrcbud005,xrcbud006,
                             xrcbud007,xrcbud008,xrcbud009,xrcbud010,xrcbud011,xrcbud012,xrcbud013,xrcbud014,
                             xrcbud015,xrcbud016,xrcbud017,xrcbud018,xrcbud019,xrcbud020,xrcbud021,xrcbud022,
                             xrcbud023,xrcbud024,xrcbud025,xrcbud026,xrcbud027,xrcbud028,xrcbud029,xrcbud030,
                             xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107)
          VALUES (g_xrcb.xrcbent,g_xrcb.xrcbld,g_xrcb.xrcbdocno,g_xrcb.xrcbseq,g_xrcb.xrcbsite,g_xrcb.xrcborga,g_xrcb.xrcb001,g_xrcb.xrcb002,g_xrcb.xrcb003,g_xrcb.xrcb004,
                  g_xrcb.xrcb005,g_xrcb.xrcb006,g_xrcb.xrcb007,g_xrcb.xrcb008,g_xrcb.xrcb009,g_xrcb.xrcblegl,g_xrcb.xrcb010,g_xrcb.xrcb011,g_xrcb.xrcb012,g_xrcb.xrcb013,
                   g_xrcb.xrcb014,g_xrcb.xrcb015,g_xrcb.xrcb016,g_xrcb.xrcb017,g_xrcb.xrcb018,g_xrcb.xrcb019,g_xrcb.xrcb020,g_xrcb.xrcb021,g_xrcb.xrcb022,g_xrcb.xrcb023,
                   g_xrcb.xrcb024,g_xrcb.xrcb025,g_xrcb.xrcb026,g_xrcb.xrcb027,g_xrcb.xrcb028,g_xrcb.xrcb029,g_xrcb.xrcb030,g_xrcb.xrcb031,g_xrcb.xrcb032,g_xrcb.xrcb033,
                   g_xrcb.xrcb034,g_xrcb.xrcb035,g_xrcb.xrcb036,g_xrcb.xrcb037,g_xrcb.xrcb038,g_xrcb.xrcb039,g_xrcb.xrcb040,g_xrcb.xrcb041,g_xrcb.xrcb042,g_xrcb.xrcb043,
                   g_xrcb.xrcb044,g_xrcb.xrcb045,g_xrcb.xrcb046,g_xrcb.xrcb047,g_xrcb.xrcb048,g_xrcb.xrcb049,g_xrcb.xrcb050,g_xrcb.xrcb051,g_xrcb.xrcb100,g_xrcb.xrcb101,
                   g_xrcb.xrcb102,g_xrcb.xrcb103,g_xrcb.xrcb104,g_xrcb.xrcb105,g_xrcb.xrcb106,g_xrcb.xrcb111,g_xrcb.xrcb113,g_xrcb.xrcb114,g_xrcb.xrcb115,g_xrcb.xrcb116,
                   g_xrcb.xrcb117,g_xrcb.xrcb118,g_xrcb.xrcb119,g_xrcb.xrcb121,g_xrcb.xrcb123,g_xrcb.xrcb124,g_xrcb.xrcb125,g_xrcb.xrcb126,g_xrcb.xrcb131,g_xrcb.xrcb133,
                   g_xrcb.xrcb134,g_xrcb.xrcb135,g_xrcb.xrcb136,g_xrcb.xrcbud001,g_xrcb.xrcbud002,g_xrcb.xrcbud003,g_xrcb.xrcbud004,g_xrcb.xrcbud005,g_xrcb.xrcbud006,
                   g_xrcb.xrcbud007,g_xrcb.xrcbud008,g_xrcb.xrcbud009,g_xrcb.xrcbud010,g_xrcb.xrcbud011,g_xrcb.xrcbud012,g_xrcb.xrcbud013,g_xrcb.xrcbud014,
                   g_xrcb.xrcbud015,g_xrcb.xrcbud016,g_xrcb.xrcbud017,g_xrcb.xrcbud018,g_xrcb.xrcbud019,g_xrcb.xrcbud020,g_xrcb.xrcbud021,g_xrcb.xrcbud022,
                   g_xrcb.xrcbud023,g_xrcb.xrcbud024,g_xrcb.xrcbud025,g_xrcb.xrcbud026,g_xrcb.xrcbud027,g_xrcb.xrcbud028,g_xrcb.xrcbud029,g_xrcb.xrcbud030,
                   g_xrcb.xrcb052,g_xrcb.xrcb053,g_xrcb.xrcb054,g_xrcb.xrcb055,g_xrcb.xrcb056,g_xrcb.xrcb057,g_xrcb.xrcb058,g_xrcb.xrcb059,g_xrcb.xrcb060,g_xrcb.xrcb107)
         #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins xrcb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE 
         END IF
         
         #插入多賬期（只含一期）
         INITIALIZE g_xrcc.* TO NULL
         LET g_xrcc.xrccent = g_enterprise
         LET g_xrcc.xrccld  = g_xrca.xrcald
         LET g_xrcc.xrcccomp = g_xrca.xrcacomp
         LET g_xrcc.xrccdocno = g_xrca.xrcadocno
         LET g_xrcc.xrccseq = g_xrcb.xrcbseq
         LET g_xrcc.xrcc001 = 1   #期別
         LET g_xrcc.xrcc002 = ''  #應收收款類別
         LET g_xrcc.xrcc003 = ''  #應收款日
         LET g_xrcc.xrcc004 = ''  #容許票據到期日
         LET g_xrcc.xrcc005 = ''  #帳款起算日
         LET g_xrcc.xrcclegl = '' #核算組織
         LET g_xrcc.xrccsite = g_xrca.xrcasite #帳務中心
         LET g_xrcc.xrcc100 = g_xrca.xrca100 #原幣
         LET g_xrcc.xrcc101 = g_xrca.xrca101 #原幣匯率
         LET g_xrcc.xrcc102 = 0
         LET g_xrcc.xrcc103 = 0
         LET g_xrcc.xrcc104 = 0
         LET g_xrcc.xrcc105 = g_xrcb.xrcb105
         LET g_xrcc.xrcc106 = 0
         LET g_xrcc.xrcc107 = 0
         LET g_xrcc.xrcc108 = g_xrcb.xrcb105
         LET g_xrcc.xrcc109 = 0
         LET g_xrcc.xrcc113 = 0
         LET g_xrcc.xrcc114 = 0
         LET g_xrcc.xrcc115 = g_xrcb.xrcb115
         LET g_xrcc.xrcc116 = 0
         LET g_xrcc.xrcc117 = 0
         LET g_xrcc.xrcc118 = g_xrcb.xrcb115
         LET g_xrcc.xrcc119 = 0
         LET g_xrcc.xrcc120 = g_xrca.xrca120
         LET g_xrcc.xrcc121 = g_xrca.xrca121
         LET g_xrcc.xrcc122 = 0
         LET g_xrcc.xrcc123 = 0
         LET g_xrcc.xrcc124 = 0
         LET g_xrcc.xrcc125 = g_xrcb.xrcb125
         LET g_xrcc.xrcc126 = 0
         LET g_xrcc.xrcc127 = 0
         LET g_xrcc.xrcc128 = g_xrcb.xrcb125
         LET g_xrcc.xrcc129 = 0
         LET g_xrcc.xrcc130 = g_xrca.xrca130
         LET g_xrcc.xrcc131 = g_xrca.xrca131
         LET g_xrcc.xrcc132 = 0
         LET g_xrcc.xrcc133 = 0
         LET g_xrcc.xrcc134 = 0
         LET g_xrcc.xrcc135 = g_xrcb.xrcb135
         LET g_xrcc.xrcc136 = 0
         LET g_xrcc.xrcc137 = 0
         LET g_xrcc.xrcc138 = g_xrcb.xrcb135
         LET g_xrcc.xrcc139 = 0
           
        #161215-00044#1---modify----begin-----------------
        #INSERT INTO xrcc_t VALUES (g_xrcc.*)
         INSERT INTO xrcc_t (xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,
                             xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,
                             xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,
                             xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,
                             xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,
                             xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,
                             xrccud008,xrccud009,xrccud010,xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,
                             xrccud017,xrccud018,xrccud019,xrccud020,xrccud021,xrccud022,xrccud023,xrccud024,xrccud025,
                             xrccud026,xrccud027,xrccud028,xrccud029,xrccud030,xrcc015,xrcc016,xrcc017)
          VALUES (g_xrcc.xrccent,g_xrcc.xrccld,g_xrcc.xrcccomp,g_xrcc.xrccdocno,g_xrcc.xrccseq,g_xrcc.xrcc001,g_xrcc.xrcc002,g_xrcc.xrcc003,g_xrcc.xrcc004,g_xrcc.xrcc005,g_xrcc.xrcc006,
                  g_xrcc.xrcclegl,g_xrcc.xrcc008,g_xrcc.xrcc009,g_xrcc.xrccsite,g_xrcc.xrcc010,g_xrcc.xrcc011,g_xrcc.xrcc012,g_xrcc.xrcc013,g_xrcc.xrcc014,g_xrcc.xrcc100,g_xrcc.xrcc101,
                  g_xrcc.xrcc102,g_xrcc.xrcc103,g_xrcc.xrcc104,g_xrcc.xrcc105,g_xrcc.xrcc106,g_xrcc.xrcc107,g_xrcc.xrcc108,g_xrcc.xrcc109,g_xrcc.xrcc113,g_xrcc.xrcc114,g_xrcc.xrcc115,
                  g_xrcc.xrcc116,g_xrcc.xrcc117,g_xrcc.xrcc118,g_xrcc.xrcc119,g_xrcc.xrcc120,g_xrcc.xrcc121,g_xrcc.xrcc122,g_xrcc.xrcc123,g_xrcc.xrcc124,g_xrcc.xrcc125,g_xrcc.xrcc126,
                  g_xrcc.xrcc127,g_xrcc.xrcc128,g_xrcc.xrcc129,g_xrcc.xrcc130,g_xrcc.xrcc131,g_xrcc.xrcc132,g_xrcc.xrcc133,g_xrcc.xrcc134,g_xrcc.xrcc135,g_xrcc.xrcc136,g_xrcc.xrcc137,
                  g_xrcc.xrcc138,g_xrcc.xrcc139,g_xrcc.xrccud001,g_xrcc.xrccud002,g_xrcc.xrccud003,g_xrcc.xrccud004,g_xrcc.xrccud005,g_xrcc.xrccud006,g_xrcc.xrccud007,
                  g_xrcc.xrccud008,g_xrcc.xrccud009,g_xrcc.xrccud010,g_xrcc.xrccud011,g_xrcc.xrccud012,g_xrcc.xrccud013,g_xrcc.xrccud014,g_xrcc.xrccud015,g_xrcc.xrccud016,
                  g_xrcc.xrccud017,g_xrcc.xrccud018,g_xrcc.xrccud019,g_xrcc.xrccud020,g_xrcc.xrccud021,g_xrcc.xrccud022,g_xrcc.xrccud023,g_xrcc.xrccud024,g_xrcc.xrccud025,
                  g_xrcc.xrccud026,g_xrcc.xrccud027,g_xrcc.xrccud028,g_xrcc.xrccud029,g_xrcc.xrccud030,g_xrcc.xrcc015,g_xrcc.xrcc016,g_xrcc.xrcc017)
        #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins xrcc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         
         #插入交易明細稅
         LET l_sql = "CREATE GLOBAL TEMPORARY TABLE afap270_detail_43 AS ",
                       "SELECT * FROM xrcd_t "
         PREPARE repro_tbl3 FROM l_sql
         EXECUTE repro_tbl3
         FREE repro_tbl3
          
         #將符合條件的資料丟入TEMP TABLE
         INSERT INTO afap270_detail_43 
         SELECT * FROM xrcd_t
          WHERE xrcdent = g_enterprise 
            AND xrcdld = g_xrca.xrcald 
            AND xrcddocno = l_faca.facadocno 
            AND xrcdseq = l_faca.facaseq   
                                    
          
         #將key修正為調整後   
         UPDATE afap270_detail_43 SET xrcddocno = g_xrca.xrcadocno,
                                        xrcdseq = g_xrcb.xrcbseq
              
         #將資料塞回原table   
         INSERT INTO xrcd_t SELECT * FROM afap270_detail_43
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code ='afa-01074'    
            LET g_errparam.extend = 'upd xrcd_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         #刪除TEMP TABLE
         DROP TABLE afap270_detail_43
         
         IF g_xrca.xrcald = g_master.fabgld THEN
            #更新單頭應收帳款單號
            UPDATE fabg_t SET fabg011 = g_xrca.xrcadocno
             WHERE fabgent = g_enterprise 
               AND fabgld = g_xrca.xrcald 
               AND fabgdocno = l_faca.facadocno 
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code ='afa-01075'    
               LET g_errparam.extend = 'upd fabg_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE  
            END IF
            
            #更新單身應收帳款單號
            UPDATE faca_t SET faca037 = g_xrca.xrcadocno
             WHERE facaent = g_enterprise 
               AND facald = g_xrca.xrcald 
               AND facadocno = l_faca.facadocno 
               AND facaseq = l_faca.facaseq
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code ='afa-01075'     
               LET g_errparam.extend = 'upd faca_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE 
            END IF
         END IF
      END FOREACH
       
      #判斷是否產生單身，如果有資料，匯總金額更新單頭金額，否則刪除單頭資料
      SELECT COUNT(*) INTO l_cnt 
        FROM xrcb_t
       WHERE xrcbent = g_enterprise 
         AND xrcbld = g_xrca.xrcald 
         AND xrcbdocno = g_xrca.xrcadocno 
      IF l_cnt > 0 THEN  
         SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115),
                SUM(xrcb123),SUM(xrcb124),SUM(xrcb125),SUM(xrcb133),SUM(xrcb134),SUM(xrcb135)  
           INTO g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
                g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138   
           FROM xrcb_t
          WHERE xrcbent = g_enterprise 
            AND xrcbld = g_xrca.xrcald 
            AND xrcbdocno = g_xrca.xrcadocno
            
         IF cl_null(g_xrca.xrca103) THEN LET g_xrca.xrca103 = 0 END IF 
         IF cl_null(g_xrca.xrca104) THEN LET g_xrca.xrca104 = 0 END IF 
         IF cl_null(g_xrca.xrca108) THEN LET g_xrca.xrca108 = 0 END IF
         IF cl_null(g_xrca.xrca113) THEN LET g_xrca.xrca113 = 0 END IF 
         IF cl_null(g_xrca.xrca114) THEN LET g_xrca.xrca114 = 0 END IF
         IF cl_null(g_xrca.xrca118) THEN LET g_xrca.xrca118 = 0 END IF
         IF cl_null(g_xrca.xrca123) THEN LET g_xrca.xrca123 = 0 END IF 
         IF cl_null(g_xrca.xrca124) THEN LET g_xrca.xrca124 = 0 END IF
         IF cl_null(g_xrca.xrca128) THEN LET g_xrca.xrca128 = 0 END IF
         IF cl_null(g_xrca.xrca133) THEN LET g_xrca.xrca133 = 0 END IF 
         IF cl_null(g_xrca.xrca134) THEN LET g_xrca.xrca134 = 0 END IF
         IF cl_null(g_xrca.xrca138) THEN LET g_xrca.xrca138 = 0 END IF
         
         UPDATE xrca_t SET (xrca103,xrca104,xrca108,xrca113,xrca114,xrca118,
                            xrca123,xrca124,xrca128,xrca133,xrca134,xrca138)
                         = (g_xrca.xrca103,g_xrca.xrca104,g_xrca.xrca108,g_xrca.xrca113,g_xrca.xrca114,g_xrca.xrca118,
                            g_xrca.xrca123,g_xrca.xrca124,g_xrca.xrca128,g_xrca.xrca133,g_xrca.xrca134,g_xrca.xrca138) 
          WHERE xrcaent = g_enterprise 
            AND xrcald = g_xrca.xrcald 
            AND xrcadocno = g_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'upd xrca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
      ELSE
         DELETE FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_xrca.xrcald AND xrcadocno = g_xrca.xrcadocno
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'delete xrca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         
         #刪除單號
         LET g_prog = 'axrt330'
         IF NOT s_aooi200_fin_del_docno(g_xrca.xrcald,g_xrca.xrcadocno,g_xrca.xrcadocdt) THEN
            LET g_success = FALSE
         END IF
         LET g_prog = 'afap270'
         CONTINUE FOREACH  #无账款单身产生时，后续生产分录底稿和审核操作不用在执行
      END IF
    
      #生成分录底稿
      IF NOT cl_null(g_xrca.xrcadocno) AND g_xrca.xrcastus = 'N' THEN
         #获取单别
         CALL s_aooi200_fin_get_slip(g_xrca.xrcadocno) RETURNING l_success,l_ooba002
         #是否抛傳票
         CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      
         IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
            CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
            CALL s_pre_voucher_ins('AR','R10',g_glaald,g_xrca.xrcadocno,g_xrca.xrcadocdt,'1')
               RETURNING l_success
            IF NOT l_success THEN
               LET g_success = FALSE
            END IF
        END IF 
      END IF
      
      #应收账款立即审核
      CALL s_fin_get_doc_para(g_xrca.xrcald,g_xrca.xrcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_axrp133_immediately_conf(g_xrca.xrcald,g_xrca.xrcadocno)
               RETURNING l_conf_success
      END IF
      IF NOT l_conf_success  THEN 
         LET g_success = FALSE
      END IF 
   END FOREACH 
END FUNCTION
# Descriptions...: 插入應付帳款(apca_t apcb_t apcc_t xrcd_t)
# Memo...........:
# Usage..........: CALL afap270_apca_ins_44()
# Modify.........: #160426-00014#44 add lujh
PRIVATE FUNCTION afap270_apca_ins_44()
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_fabg          RECORD LIKE fabg_t.*
   #DEFINE l_faca          RECORD LIKE faca_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020  #資產性質
       END RECORD
    DEFINE l_faca RECORD  #調撥帳務單身檔
       facaent LIKE faca_t.facaent, #企業代碼
       facald LIKE faca_t.facald, #帳套
       facadocno LIKE faca_t.facadocno, #單號
       facaseq LIKE faca_t.facaseq, #項次
       faca001 LIKE faca_t.faca001, #來源單號
       faca002 LIKE faca_t.faca002, #來源項次
       faca003 LIKE faca_t.faca003, #財產編號
       faca004 LIKE faca_t.faca004, #附號
       faca005 LIKE faca_t.faca005, #卡片編號
       faca006 LIKE faca_t.faca006, #單位
       faca007 LIKE faca_t.faca007, #单价
       faca008 LIKE faca_t.faca008, #調撥數量
       faca009 LIKE faca_t.faca009, #調撥成本
       faca010 LIKE faca_t.faca010, #稅別
       faca011 LIKE faca_t.faca011, #原幣未稅金額
       faca012 LIKE faca_t.faca012, #原幣稅額
       faca013 LIKE faca_t.faca013, #原幣應收金額
       faca014 LIKE faca_t.faca014, #本幣未稅金額
       faca015 LIKE faca_t.faca015, #本幣稅額
       faca016 LIKE faca_t.faca016, #本幣應收金額
       faca017 LIKE faca_t.faca017, #稅率
       faca018 LIKE faca_t.faca018, #處置損益
       faca019 LIKE faca_t.faca019, #異動科目
       faca020 LIKE faca_t.faca020, #累折科目
       faca021 LIKE faca_t.faca021, #減值準備科目
       faca022 LIKE faca_t.faca022, #資產科目
       faca023 LIKE faca_t.faca023, #應收/付帳款科目
       faca024 LIKE faca_t.faca024, #稅額科目
       faca025 LIKE faca_t.faca025, #營運據點
       faca026 LIKE faca_t.faca026, #部門
       faca027 LIKE faca_t.faca027, #利潤/成本中心
       faca028 LIKE faca_t.faca028, #區域
       faca029 LIKE faca_t.faca029, #交易客商
       faca030 LIKE faca_t.faca030, #帳款客商
       faca031 LIKE faca_t.faca031, #客群
       faca032 LIKE faca_t.faca032, #人員
       faca033 LIKE faca_t.faca033, #專案編號
       faca034 LIKE faca_t.faca034, #WBS
       faca035 LIKE faca_t.faca035, #帳款編號
       faca036 LIKE faca_t.faca036, #摘要
       faca037 LIKE faca_t.faca037, #應收/付帳款單號
       faca038 LIKE faca_t.faca038, #本位幣二幣別
       faca039 LIKE faca_t.faca039, #本位幣二匯率
       faca040 LIKE faca_t.faca040, #本位幣二未稅金額
       faca041 LIKE faca_t.faca041, #本位幣二稅額
       faca042 LIKE faca_t.faca042, #本位幣二應收金額
       faca043 LIKE faca_t.faca043, #本位幣二調撥成本
       faca044 LIKE faca_t.faca044, #本位幣二處置損益
       faca045 LIKE faca_t.faca045, #本位幣三幣別
       faca046 LIKE faca_t.faca046, #本位幣三匯率
       faca047 LIKE faca_t.faca047, #本位幣三未稅金額
       faca048 LIKE faca_t.faca048, #本位幣三稅額
       faca049 LIKE faca_t.faca049, #本位幣三應收金額
       faca050 LIKE faca_t.faca050, #本位幣三調撥成本
       faca051 LIKE faca_t.faca051, #本位幣三處置損益
       faca052 LIKE faca_t.faca052, #經營方式
       faca053 LIKE faca_t.faca053, #通路
       faca054 LIKE faca_t.faca054, #品牌
       faca055 LIKE faca_t.faca055, #自由核算項一
       faca056 LIKE faca_t.faca056, #自由核算項二
       faca057 LIKE faca_t.faca057, #自由核算項三
       faca058 LIKE faca_t.faca058, #自由核算項四
       faca059 LIKE faca_t.faca059, #自由核算項五
       faca060 LIKE faca_t.faca060, #自由核算項六
       faca061 LIKE faca_t.faca061, #自由核算項七
       faca062 LIKE faca_t.faca062, #自由核算項八
       faca063 LIKE faca_t.faca063, #自由核算項九
       faca064 LIKE faca_t.faca064, #自由核算項十
       faca065 LIKE faca_t.faca065, #產品類別
       facaud001 LIKE faca_t.facaud001, #自定義欄位(文字)001
       facaud002 LIKE faca_t.facaud002, #自定義欄位(文字)002
       facaud003 LIKE faca_t.facaud003, #自定義欄位(文字)003
       facaud004 LIKE faca_t.facaud004, #自定義欄位(文字)004
       facaud005 LIKE faca_t.facaud005, #自定義欄位(文字)005
       facaud006 LIKE faca_t.facaud006, #自定義欄位(文字)006
       facaud007 LIKE faca_t.facaud007, #自定義欄位(文字)007
       facaud008 LIKE faca_t.facaud008, #自定義欄位(文字)008
       facaud009 LIKE faca_t.facaud009, #自定義欄位(文字)009
       facaud010 LIKE faca_t.facaud010, #自定義欄位(文字)010
       facaud011 LIKE faca_t.facaud011, #自定義欄位(數字)011
       facaud012 LIKE faca_t.facaud012, #自定義欄位(數字)012
       facaud013 LIKE faca_t.facaud013, #自定義欄位(數字)013
       facaud014 LIKE faca_t.facaud014, #自定義欄位(數字)014
       facaud015 LIKE faca_t.facaud015, #自定義欄位(數字)015
       facaud016 LIKE faca_t.facaud016, #自定義欄位(數字)016
       facaud017 LIKE faca_t.facaud017, #自定義欄位(數字)017
       facaud018 LIKE faca_t.facaud018, #自定義欄位(數字)018
       facaud019 LIKE faca_t.facaud019, #自定義欄位(數字)019
       facaud020 LIKE faca_t.facaud020, #自定義欄位(數字)020
       facaud021 LIKE faca_t.facaud021, #自定義欄位(日期時間)021
       facaud022 LIKE faca_t.facaud022, #自定義欄位(日期時間)022
       facaud023 LIKE faca_t.facaud023, #自定義欄位(日期時間)023
       facaud024 LIKE faca_t.facaud024, #自定義欄位(日期時間)024
       facaud025 LIKE faca_t.facaud025, #自定義欄位(日期時間)025
       facaud026 LIKE faca_t.facaud026, #自定義欄位(日期時間)026
       facaud027 LIKE faca_t.facaud027, #自定義欄位(日期時間)027
       facaud028 LIKE faca_t.facaud028, #自定義欄位(日期時間)028
       facaud029 LIKE faca_t.facaud029, #自定義欄位(日期時間)029
       facaud030 LIKE faca_t.facaud030  #自定義欄位(日期時間)030
       END RECORD
   #161215-00044#1---modify----end-----------------
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_apcbseq       LIKE apcb_t.apcbseq
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_sql           STRING
   DEFINE l_wc            STRING
   DEFINE l_ooba002       LIKE ooba_t.ooba002
   DEFINE l_dfin0030      LIKE type_t.chr1
   DEFINE l_dfin0031      LIKE type_t.chr1
   DEFINE l_conf_success  LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003 
   DEFINE l_glaa024       LIKE glaa_t.glaa024 
   DEFINE l_oodb008       LIKE oodb_t.oodb008 
   
   INITIALIZE l_fabg.* TO NULL
   LET l_fabg.fabgld = g_master.fabgld
   LET l_fabg.fabg013 = g_detail_d[l_ac].fabg013 #稅別
   LET l_fabg.fabg015 = g_detail_d[l_ac].fabg015 #幣別
   #依單號匯總
   IF g_master.type='1' THEN
      LET l_fabg.fabgdocno = g_detail_d[l_ac].fabgdocno
      SELECT fabg001,fabg006,fabg007,fabg016 
        INTO l_fabg.fabg001,l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg016
        FROM fabg_t
       WHERE fabgent = g_enterprise 
         AND fabgld = g_master.fabgld
         AND fabgdocno = g_detail_d[l_ac].fabgdocno
   ELSE #依帳款客戶匯總
      LET l_fabg.fabg006 = g_detail_d[l_ac].fabg006
   END IF
   SELECT glaacomp INTO l_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_input.apcald
      
   INITIALIZE g_apca.* TO NULL
   
   LET l_sql = "SELECT glaald,glaa024,glaa003 FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.fabgld,"'", 
               " ORDER BY glaa023 "   
   PREPARE pre_glaald_44 FROM l_sql
   DECLARE sel_glaald_44 CURSOR FOR pre_glaald_44
   FOREACH sel_glaald_44 INTO g_apca.apcald,l_glaa024,l_glaa003 
      #插入單頭
      LET g_apca.apcaent = g_enterprise
      LET g_apca.apcaownid = g_user
      LET g_apca.apcaowndp = g_dept
      LET g_apca.apcacrtid = g_user
      LET g_apca.apcacrtdp = g_dept 
      LET g_apca.apcacrtdt = cl_get_current()
      LET g_apca.apcamodid = ""
      LET g_apca.apcamoddt = ""
      LET g_apca.apcastus = "N"
      LET g_apca.apcacomp = l_glaacomp
      #單據日期
      LET g_apca.apcadocdt= g_input.apcadocdt
      #单据编号
      CALL s_aooi200_fin_gen_docno(g_apca.apcald,l_glaa024,l_glaa003,g_input.apcadocno,g_input.apcadocdt,'aapt301') 
      RETURNING l_success,g_apca.apcadocno
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE  
         CONTINUE FOREACH       
      END IF 
      LET g_apca.apca001 = '19' #其他應付帳款
      LET g_apca.apcasite = g_input.apcasite
      LET g_apca.apca003 = l_fabg.fabg001  #帳務人員
      LET g_apca.apca004 = l_fabg.fabg006  #帳款客戶
      LET g_apca.apca005 = l_fabg.fabg007  #收款客戶
      LET g_apca.apca011 = l_fabg.fabg013  #稅別
      CALL afap270_apca004_ref()
      LET g_apca.apca016 = '15'
      LET g_apca.apca017 = 0  
      LET g_apca.apca018 = g_detail_d[l_ac].fabgdocno
      LET g_apca.apca020 = 'N'     
      LET g_apca.apca026 = 0
      LET g_apca.apca027 = 0
      LET g_apca.apca028 = 0
      LET g_apca.apca029 = 0
      LET g_apca.apca037 = 'N'
      LET g_apca.apca039 = 0
      LET g_apca.apca040 = 'N'
      LET g_apca.apca044 = 0 
      LET g_apca.apca052 = 0
      SELECT oodb008 INTO l_oodb008
        FROM oodb_t,ooef_t 
       WHERE ooefent = oodbent AND oodb001 = ooef019 AND ooef001 = g_apca.apcacomp 
         AND oodbent= g_enterprise AND oodb002=g_apca.apca011
         
      CASE l_oodb008
         WHEN '1'
            LET g_apca.apca060 = 2
         WHEN '2'
            LET g_apca.apca060 = 1
         WHEN '3'
            LET g_apca.apca060 = 3
         OTHERWISE
            LET g_apca.apca060 = 1         
      END CASE
      LET g_apca.apca062 = '1'
      LET g_apca.apca100 = l_fabg.fabg015  #交易原幣
      LET g_apca.apca101 = l_fabg.fabg016
      SELECT DISTINCT faca038,faca039,faca045,faca046 
        INTO g_apca.apca120,g_apca.apca121,g_apca.apca130,g_apca.apca131
        FROM faca_t
       WHERE facaent = g_enterprise 
         AND facald = l_fabg.fabgld 
         AND facadocno = l_fabg.fabgdocno
      
      LET g_apca.apca103 = 0
      LET g_apca.apca104 = 0
      LET g_apca.apca106 = 0
      LET g_apca.apca107 = 0
      LET g_apca.apca108 = 0
      LET g_apca.apca113 = 0
      LET g_apca.apca114 = 0
      LET g_apca.apca116 = 0
      LET g_apca.apca117 = 0
      LET g_apca.apca118 = 0
      
      LET g_apca.apca123 = 0
      LET g_apca.apca124 = 0
      LET g_apca.apca126 = 0
      LET g_apca.apca127 = 0
      LET g_apca.apca128 = 0
       
      LET g_apca.apca133 = 0
      LET g_apca.apca134 = 0
      LET g_apca.apca136 = 0
      LET g_apca.apca137 = 0
      LET g_apca.apca138 = 0
      
      #161215-00044#1---modify----begin-----------------
      #INSERT INTO apca_t VALUES (g_apca.*)
      INSERT INTO apca_t (apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,
                          apcacnfdt,apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,apca001,
                          apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,apca013,apca014,
                          apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,apca026,apca027,apca028,
                          apca029,apca030,apca031,apca032,apca033,apca034,apca035,apca036,apca037,apca038,apca039,apca040,
                          apca041,apca042,apca043,apca044,apca045,apca046,apca047,apca048,apca049,apca050,apca051,apca052,
                          apca053,apca054,apca055,apca056,apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca064,
                          apca065,apca066,apca100,apca101,apca103,apca104,apca106,apca107,apca108,apca113,apca114,apca116,
                          apca117,apca118,apca120,apca121,apca123,apca124,apca126,apca127,apca128,apca130,apca131,apca133,
                          apca134,apca136,apca137,apca138,apcaud001,apcaud002,apcaud003,apcaud004,apcaud005,apcaud006,apcaud007,
                          apcaud008,apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,apcaud014,apcaud015,apcaud016,apcaud017,
                          apcaud018,apcaud019,apcaud020,apcaud021,apcaud022,apcaud023,apcaud024,apcaud025,apcaud026,apcaud027,
                          apcaud028,apcaud029,apcaud030,apca067,apca068,apca069,apca070,apca071,apca072,apca073)
       VALUES (g_apca.apcaent,g_apca.apcaownid,g_apca.apcaowndp,g_apca.apcacrtid,g_apca.apcacrtdp,g_apca.apcacrtdt,g_apca.apcamodid,g_apca.apcamoddt,g_apca.apcacnfid,
               g_apca.apcacnfdt,g_apca.apcapstid,g_apca.apcapstdt,g_apca.apcastus,g_apca.apcald,g_apca.apcacomp,g_apca.apcadocno,g_apca.apcadocdt,g_apca.apcasite,g_apca.apca001,
               g_apca.apca003,g_apca.apca004,g_apca.apca005,g_apca.apca006,g_apca.apca007,g_apca.apca008,g_apca.apca009,g_apca.apca010,g_apca.apca011,g_apca.apca012,g_apca.apca013,g_apca.apca014,
               g_apca.apca015,g_apca.apca016,g_apca.apca017,g_apca.apca018,g_apca.apca019,g_apca.apca020,g_apca.apca021,g_apca.apca022,g_apca.apca025,g_apca.apca026,g_apca.apca027,g_apca.apca028,
               g_apca.apca029,g_apca.apca030,g_apca.apca031,g_apca.apca032,g_apca.apca033,g_apca.apca034,g_apca.apca035,g_apca.apca036,g_apca.apca037,g_apca.apca038,g_apca.apca039,g_apca.apca040,
               g_apca.apca041,g_apca.apca042,g_apca.apca043,g_apca.apca044,g_apca.apca045,g_apca.apca046,g_apca.apca047,g_apca.apca048,g_apca.apca049,g_apca.apca050,g_apca.apca051,g_apca.apca052,
               g_apca.apca053,g_apca.apca054,g_apca.apca055,g_apca.apca056,g_apca.apca057,g_apca.apca058,g_apca.apca059,g_apca.apca060,g_apca.apca061,g_apca.apca062,g_apca.apca063,g_apca.apca064,
               g_apca.apca065,g_apca.apca066,g_apca.apca100,g_apca.apca101,g_apca.apca103,g_apca.apca104,g_apca.apca106,g_apca.apca107,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca116,
               g_apca.apca117,g_apca.apca118,g_apca.apca120,g_apca.apca121,g_apca.apca123,g_apca.apca124,g_apca.apca126,g_apca.apca127,g_apca.apca128,g_apca.apca130,g_apca.apca131,g_apca.apca133,
               g_apca.apca134,g_apca.apca136,g_apca.apca137,g_apca.apca138,g_apca.apcaud001,g_apca.apcaud002,g_apca.apcaud003,g_apca.apcaud004,g_apca.apcaud005,g_apca.apcaud006,g_apca.apcaud007,
               g_apca.apcaud008,g_apca.apcaud009,g_apca.apcaud010,g_apca.apcaud011,g_apca.apcaud012,g_apca.apcaud013,g_apca.apcaud014,g_apca.apcaud015,g_apca.apcaud016,g_apca.apcaud017,
               g_apca.apcaud018,g_apca.apcaud019,g_apca.apcaud020,g_apca.apcaud021,g_apca.apcaud022,g_apca.apcaud023,g_apca.apcaud024,g_apca.apcaud025,g_apca.apcaud026,g_apca.apcaud027,
               g_apca.apcaud028,g_apca.apcaud029,g_apca.apcaud030,g_apca.apca067,g_apca.apca068,g_apca.apca069,g_apca.apca070,g_apca.apca071,g_apca.apca072,g_apca.apca073)
      #161215-00044#1---modify----end-----------------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =SQLCA.SQLCODE
         LET g_errparam.extend = 'ins apca_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE  
      END IF
      
      #記錄第一張應收單單號
      IF cl_null(g_input.docno_s1) THEN
         LET g_input.docno_s1=g_apca.apcadocno
      END IF
      
      #插入單身
      #161215-00044#1---modify----begin----------------
      #LET g_sql="SELECT faca_t.* ",
      LET g_sql="SELECT facaent,facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca006,faca007,",
                "faca008,faca009,faca010,faca011,faca012,faca013,faca014,faca015,faca016,faca017,faca018,faca019,",
                "faca020,faca021,faca022,faca023,faca024,faca025,faca026,faca027,faca028,faca029,faca030,faca031,",
                "faca032,faca033,faca034,faca035,faca036,faca037,faca038,faca039,faca040,faca041,faca042,faca043,",
                "faca044,faca045,faca046,faca047,faca048,faca049,faca050,faca051,faca052,faca053,faca054,faca055,",
                "faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063,faca064,faca065,facaud001,",
                "facaud002,facaud003,facaud004,facaud005,facaud006,facaud007,facaud008,facaud009,facaud010,facaud011,",
                "facaud012,facaud013,facaud014,facaud015,facaud016,facaud017,facaud018,facaud019,facaud020,facaud021,",
                "facaud022,facaud023,facaud024,facaud025,facaud026,facaud027,facaud028,facaud029,facaud030 ",
      #161215-00044#1---modify----end-----------------
                "  FROM fabg_t,faca_t",
                " WHERE fabgent = facaent ",
                "   AND fabgld = facald ",
                "   AND fabgdocno = facadocno ",
                "   AND fabgent = ",g_enterprise,
                "   AND fabgld = '",g_master.fabgld,"'",
                "   AND fabg005 = '44' ",
                "   AND (fabgstus = 'Y' OR fabgstus = 'S') ",    
                "   AND fabg011 IS NULL ",
                "   AND fabg015 = '",g_detail_d[l_ac].fabg015,"'",
                "   AND fabg013 = '",g_detail_d[l_ac].fabg013,"'",
                "   AND ",g_master.wc
      IF g_master.type = '1' THEN
         LET g_sql=g_sql," AND fabgdocno = '",g_detail_d[l_ac].fabgdocno,"' "
      ELSE
         LET g_sql=g_sql," AND fabg006 = '",g_detail_d[l_ac].fabg006,"' "
      END IF
         
      LET g_sql=g_sql," ORDER BY facadocno,facaseq"
      
      PREPARE afap270_apcb_pre FROM g_sql
      DECLARE afap270_apcb_cs CURSOR FOR afap270_apcb_pre
      LET l_apcbseq =0
      
      FOREACH afap270_apcb_cs INTO l_faca.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'foreach'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
            EXIT FOREACH
         END IF
         LET l_apcbseq = l_apcbseq + 1
            
         INITIALIZE g_apcb.* TO NULL
         LET g_apcb.apcbent = g_enterprise
         LET g_apcb.apcbld  = g_apca.apcald
         LET g_apcb.apcbdocno = g_apca.apcadocno
         LET g_apcb.apcbseq = l_apcbseq
         LET g_apcb.apcbsite= g_apca.apcasite    #營運據點
         #來源組織
         SELECT faah028 INTO g_apcb.apcborga FROM faah_t
          WHERE faahent = g_enterprise AND faah001 = l_faca.faca005
            AND faah003 = l_faca.faca003 AND faah004 = l_faca.faca004
         LET g_apcb.apcb001 = '15'               #來源類型
         LET g_apcb.apcb002 = l_faca.facadocno   #來源單號
         LET g_apcb.apcb003 = l_faca.facaseq     #來源項次
         LET g_apcb.apcb004 = ''
         LET g_apcb.apcb005 = ''
         LET g_apcb.apcb006 = l_faca.faca006
         LET g_apcb.apcb007 = l_faca.faca008
         LET g_apcb.apcb008 = ''
         LET g_apcb.apcb009 = ''
         LET g_apcb.apcblegl= g_apca.apcacomp    #核算組織
         LET g_apcb.apcb010 = g_apca.apca015
         LET g_apcb.apcb011 = g_apca.apca034
         LET g_apcb.apcb012 = l_faca.faca065     #產品類別
         LET g_apcb.apcb013 = '' #
         LET g_apcb.apcb014 = ''
         LET g_apcb.apcb015 = l_faca.faca033     #專案代碼
         LET g_apcb.apcb016 = l_faca.faca034     #WBS 
         LET g_apcb.apcb017 = ''                 #預算項目
         LET g_apcb.apcb018 = ''                 #客戶編號 
         LET g_apcb.apcb019 = ''
         LET g_apcb.apcb020 = l_faca.faca010
         LET g_apcb.apcb021 = g_apca.apca036 
         LET g_apcb.apcb022 = 1  #正負值
         LET g_apcb.apcb023 = 'N'
         LET g_apcb.apcb024 = l_faca.faca028     #區域
         LET g_apcb.apcb025 = ''
         LET g_apcb.apcb026 = ''
         LET g_apcb.apcb027 = ''
         LET g_apcb.apcb028 = ''
         LET g_apcb.apcb029 = g_apca.apca035     #收入會計科目
         LET g_apcb.apcb030 = g_apca.apca008     #收款條件
         LET g_apcb.apcb033 = l_faca.faca052     #經營方式
         LET g_apcb.apcb034 = l_faca.faca053     #通路
         LET g_apcb.apcb035 = l_faca.faca054     #品牌
         LET g_apcb.apcb036 = l_faca.faca031     #客群
         LET g_apcb.apcb037 = l_faca.faca055     #自由核算項一
         LET g_apcb.apcb038 = l_faca.faca056     #自由核算項二
         LET g_apcb.apcb039 = l_faca.faca057     #自由核算項三
         LET g_apcb.apcb040 = l_faca.faca058     #自由核算項四
         LET g_apcb.apcb041 = l_faca.faca059     #自由核算項五
         LET g_apcb.apcb042 = l_faca.faca060     #自由核算項六
         LET g_apcb.apcb043 = l_faca.faca061     #自由核算項七
         LET g_apcb.apcb044 = l_faca.faca062     #自由核算項八
         LET g_apcb.apcb045 = l_faca.faca063     #自由核算項九
         LET g_apcb.apcb046 = l_faca.faca064     #自由核算項十
         LET g_apcb.apcb047 = l_faca.faca036     #摘要
         LET g_apcb.apcb100 = l_fabg.fabg015
         LET g_apcb.apcb101 = l_faca.faca007     #原幣單價
         LET g_apcb.apcb103 = l_faca.faca011
         LET g_apcb.apcb104 = l_faca.faca012
         LET g_apcb.apcb105 = l_faca.faca013
         LET g_apcb.apcb106 = 0
         LET g_apcb.apcb111 = g_apcb.apcb101 * g_apca.apca101 #本幣單價
         LET g_apcb.apcb113 = l_faca.faca014
         LET g_apcb.apcb114 = l_faca.faca015
         LET g_apcb.apcb115 = l_faca.faca016
         LET g_apcb.apcb116 = 0
         LET g_apcb.apcb117 = 0
         LET g_apcb.apcb118 = g_apcb.apcb113
         LET g_apcb.apcb119 = g_apcb.apcb115
         LET g_apcb.apcb123 = l_faca.faca040
         LET g_apcb.apcb124 = l_faca.faca041
         LET g_apcb.apcb125 = l_faca.faca042
         LET g_apcb.apcb126 = 0
         LET g_apcb.apcb133 = l_faca.faca047
         LET g_apcb.apcb134 = l_faca.faca048
         LET g_apcb.apcb135 = l_faca.faca049
         LET g_apcb.apcb136 = 0
          
         #161215-00044#1---modify----begin-----------------
         #INSERT INTO apcb_t VALUES (g_apcb.*)
         INSERT INTO apcb_t (apcbent,apcbld,apcblegl,apcborga,apcbsite,apcbdocno,apcbseq,apcb001,apcb002,apcb003,
                             apcb004,apcb005,apcb006,apcb007,apcb008,apcb009,apcb010,apcb011,apcb012,apcb013,apcb014,
                             apcb015,apcb016,apcb017,apcb018,apcb019,apcb020,apcb021,apcb022,apcb023,apcb024,apcb025,
                             apcb026,apcb027,apcb028,apcb029,apcb030,apcb032,apcb033,apcb034,apcb035,apcb036,apcb037,
                             apcb038,apcb039,apcb040,apcb041,apcb042,apcb043,apcb044,apcb045,apcb046,apcb047,apcb048,
                             apcb049,apcb050,apcb051,apcb100,apcb101,apcb102,apcb103,apcb104,apcb105,apcb106,apcb107,
                             apcb108,apcb111,apcb113,apcb114,apcb115,apcb116,apcb117,apcb118,apcb119,apcb121,apcb123,
                             apcb124,apcb125,apcb126,apcb127,apcb128,apcb131,apcb133,apcb134,apcb135,apcb136,apcb137,
                             apcb138,apcbud001,apcbud002,apcbud003,apcbud004,apcbud005,apcbud006,apcbud007,apcbud008,
                             apcbud009,apcbud010,apcbud011,apcbud012,apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,
                             apcbud018,apcbud019,apcbud020,apcbud021,apcbud022,apcbud023,apcbud024,apcbud025,apcbud026,
                             apcbud027,apcbud028,apcbud029,apcbud030,apcb052,apcb053,apcb054,apcb055)
          VALUES (g_apcb.apcbent,g_apcb.apcbld,g_apcb.apcblegl,g_apcb.apcborga,g_apcb.apcbsite,g_apcb.apcbdocno,g_apcb.apcbseq,g_apcb.apcb001,g_apcb.apcb002,g_apcb.apcb003,
                  g_apcb.apcb004,g_apcb.apcb005,g_apcb.apcb006,g_apcb.apcb007,g_apcb.apcb008,g_apcb.apcb009,g_apcb.apcb010,g_apcb.apcb011,g_apcb.apcb012,g_apcb.apcb013,g_apcb.apcb014,
                  g_apcb.apcb015,g_apcb.apcb016,g_apcb.apcb017,g_apcb.apcb018,g_apcb.apcb019,g_apcb.apcb020,g_apcb.apcb021,g_apcb.apcb022,g_apcb.apcb023,g_apcb.apcb024,g_apcb.apcb025,
                  g_apcb.apcb026,g_apcb.apcb027,g_apcb.apcb028,g_apcb.apcb029,g_apcb.apcb030,g_apcb.apcb032,g_apcb.apcb033,g_apcb.apcb034,g_apcb.apcb035,g_apcb.apcb036,g_apcb.apcb037,
                  g_apcb.apcb038,g_apcb.apcb039,g_apcb.apcb040,g_apcb.apcb041,g_apcb.apcb042,g_apcb.apcb043,g_apcb.apcb044,g_apcb.apcb045,g_apcb.apcb046,g_apcb.apcb047,g_apcb.apcb048,
                  g_apcb.apcb049,g_apcb.apcb050,g_apcb.apcb051,g_apcb.apcb100,g_apcb.apcb101,g_apcb.apcb102,g_apcb.apcb103,g_apcb.apcb104,g_apcb.apcb105,g_apcb.apcb106,g_apcb.apcb107,
                  g_apcb.apcb108,g_apcb.apcb111,g_apcb.apcb113,g_apcb.apcb114,g_apcb.apcb115,g_apcb.apcb116,g_apcb.apcb117,g_apcb.apcb118,g_apcb.apcb119,g_apcb.apcb121,g_apcb.apcb123,
                  g_apcb.apcb124,g_apcb.apcb125,g_apcb.apcb126,g_apcb.apcb127,g_apcb.apcb128,g_apcb.apcb131,g_apcb.apcb133,g_apcb.apcb134,g_apcb.apcb135,g_apcb.apcb136,g_apcb.apcb137,
                  g_apcb.apcb138,g_apcb.apcbud001,g_apcb.apcbud002,g_apcb.apcbud003,g_apcb.apcbud004,g_apcb.apcbud005,g_apcb.apcbud006,g_apcb.apcbud007,g_apcb.apcbud008,
                  g_apcb.apcbud009,g_apcb.apcbud010,g_apcb.apcbud011,g_apcb.apcbud012,g_apcb.apcbud013,g_apcb.apcbud014,g_apcb.apcbud015,g_apcb.apcbud016,g_apcb.apcbud017,
                  g_apcb.apcbud018,g_apcb.apcbud019,g_apcb.apcbud020,g_apcb.apcbud021,g_apcb.apcbud022,g_apcb.apcbud023,g_apcb.apcbud024,g_apcb.apcbud025,g_apcb.apcbud026,
                  g_apcb.apcbud027,g_apcb.apcbud028,g_apcb.apcbud029,g_apcb.apcbud030,g_apcb.apcb052,g_apcb.apcb053,g_apcb.apcb054,g_apcb.apcb055)
         #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins apcb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE 
         END IF
         
         #插入多賬期（只含一期）
         INITIALIZE g_apcc.* TO NULL
         LET g_apcc.apccent = g_enterprise
         LET g_apcc.apccld  = g_apca.apcald
         LET g_apcc.apcccomp = g_apca.apcacomp
         LET g_apcc.apccdocno = g_apca.apcadocno
         LET g_apcc.apccseq = g_apcb.apcbseq
         LET g_apcc.apcc001 = 1   #期別
         LET g_apcc.apcc002 = ''  #應收收款類別
         LET g_apcc.apcc003 = ''  #應收款日
         LET g_apcc.apcc004 = ''  #容許票據到期日
         LET g_apcc.apcc005 = ''  #帳款起算日
         LET g_apcc.apcc009 = ' '
         LET g_apcc.apcclegl = '' #核算組織
         LET g_apcc.apccsite = g_apca.apcasite #帳務中心
         LET g_apcc.apcc100 = g_apca.apca100 #原幣
         LET g_apcc.apcc101 = g_apca.apca101 #原幣匯率
         LET g_apcc.apcc102 = 0
         LET g_apcc.apcc103 = 0
         LET g_apcc.apcc104 = 0
         LET g_apcc.apcc105 = g_apcb.apcb105
         LET g_apcc.apcc106 = 0
         LET g_apcc.apcc107 = 0
         LET g_apcc.apcc108 = g_apcb.apcb105
         LET g_apcc.apcc109 = 0
         LET g_apcc.apcc113 = 0
         LET g_apcc.apcc114 = 0
         LET g_apcc.apcc115 = g_apcb.apcb115
         LET g_apcc.apcc116 = 0
         LET g_apcc.apcc117 = 0
         LET g_apcc.apcc118 = g_apcb.apcb115
         LET g_apcc.apcc119 = 0
         LET g_apcc.apcc120 = g_apca.apca120
         LET g_apcc.apcc121 = g_apca.apca121
         LET g_apcc.apcc122 = 0
         LET g_apcc.apcc123 = 0
         LET g_apcc.apcc124 = 0
         LET g_apcc.apcc125 = g_apcb.apcb125
         LET g_apcc.apcc126 = 0
         LET g_apcc.apcc127 = 0
         LET g_apcc.apcc128 = g_apcb.apcb125
         LET g_apcc.apcc129 = 0
         LET g_apcc.apcc130 = g_apca.apca130
         LET g_apcc.apcc131 = g_apca.apca131
         LET g_apcc.apcc132 = 0
         LET g_apcc.apcc133 = 0
         LET g_apcc.apcc134 = 0
         LET g_apcc.apcc135 = g_apcb.apcb135
         LET g_apcc.apcc136 = 0
         LET g_apcc.apcc137 = 0
         LET g_apcc.apcc138 = g_apcb.apcb135
         LET g_apcc.apcc139 = 0
           
         #161215-00044#1---modify----begin-----------------
         #INSERT INTO apcc_t VALUES (g_apcc.*)
         INSERT INTO apcc_t (apccent,apccld,apcccomp,apcclegl,apccsite,apccdocno,apccseq,apcc001,apcc002,apcc003,
                             apcc004,apcc005,apcc006,apcc007,apcc008,apcc009,apcc010,apcc011,apcc012,apcc013,apcc014,
                             apcc100,apcc101,apcc102,apcc103,apcc104,apcc105,apcc106,apcc107,apcc108,apcc109,apcc113,
                             apcc114,apcc115,apcc116,apcc117,apcc118,apcc119,apcc120,apcc121,apcc122,apcc123,apcc124,
                             apcc125,apcc126,apcc127,apcc128,apcc129,apcc130,apcc131,apcc132,apcc133,apcc134,apcc135,
                             apcc136,apcc137,apcc138,apcc139,apccud001,apccud002,apccud003,apccud004,apccud005,apccud006,
                             apccud007,apccud008,apccud009,apccud010,apccud011,apccud012,apccud013,apccud014,apccud015,
                             apccud016,apccud017,apccud018,apccud019,apccud020,apccud021,apccud022,apccud023,apccud024,
                             apccud025,apccud026,apccud027,apccud028,apccud029,apccud030,apcc015,apcc016,apcc017)
          VALUES (g_apcc.apccent,g_apcc.apccld,g_apcc.apcccomp,g_apcc.apcclegl,g_apcc.apccsite,g_apcc.apccdocno,g_apcc.apccseq,g_apcc.apcc001,g_apcc.apcc002,g_apcc.apcc003,
                  g_apcc.apcc004,g_apcc.apcc005,g_apcc.apcc006,g_apcc.apcc007,g_apcc.apcc008,g_apcc.apcc009,g_apcc.apcc010,g_apcc.apcc011,g_apcc.apcc012,g_apcc.apcc013,g_apcc.apcc014,
                  g_apcc.apcc100,g_apcc.apcc101,g_apcc.apcc102,g_apcc.apcc103,g_apcc.apcc104,g_apcc.apcc105,g_apcc.apcc106,g_apcc.apcc107,g_apcc.apcc108,g_apcc.apcc109,g_apcc.apcc113,
                  g_apcc.apcc114,g_apcc.apcc115,g_apcc.apcc116,g_apcc.apcc117,g_apcc.apcc118,g_apcc.apcc119,g_apcc.apcc120,g_apcc.apcc121,g_apcc.apcc122,g_apcc.apcc123,g_apcc.apcc124,
                  g_apcc.apcc125,g_apcc.apcc126,g_apcc.apcc127,g_apcc.apcc128,g_apcc.apcc129,g_apcc.apcc130,g_apcc.apcc131,g_apcc.apcc132,g_apcc.apcc133,g_apcc.apcc134,g_apcc.apcc135,
                  g_apcc.apcc136,g_apcc.apcc137,g_apcc.apcc138,g_apcc.apcc139,g_apcc.apccud001,g_apcc.apccud002,g_apcc.apccud003,g_apcc.apccud004,g_apcc.apccud005,g_apcc.apccud006,
                  g_apcc.apccud007,g_apcc.apccud008,g_apcc.apccud009,g_apcc.apccud010,g_apcc.apccud011,g_apcc.apccud012,g_apcc.apccud013,g_apcc.apccud014,g_apcc.apccud015,
                  g_apcc.apccud016,g_apcc.apccud017,g_apcc.apccud018,g_apcc.apccud019,g_apcc.apccud020,g_apcc.apccud021,g_apcc.apccud022,g_apcc.apccud023,g_apcc.apccud024,
                  g_apcc.apccud025,g_apcc.apccud026,g_apcc.apccud027,g_apcc.apccud028,g_apcc.apccud029,g_apcc.apccud030,g_apcc.apcc015,g_apcc.apcc016,g_apcc.apcc017)
         #161215-00044#1---modify----end-----------------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'ins apcc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         
         #插入交易明細稅
         LET l_sql = "CREATE GLOBAL TEMPORARY TABLE afap270_detail_44 AS ",
                       "SELECT * FROM xrcd_t "
         PREPARE repro_tbl4 FROM l_sql
         EXECUTE repro_tbl4
         FREE repro_tbl4
          
         #將符合條件的資料丟入TEMP TABLE
         INSERT INTO afap270_detail_44 
         SELECT * FROM xrcd_t
          WHERE xrcdent = g_enterprise 
            AND xrcdld = g_apca.apcald 
            AND xrcddocno = l_faca.facadocno 
            AND xrcdseq = l_faca.facaseq   
                                    
          
         #將key修正為調整後   
         UPDATE afap270_detail_44 SET xrcddocno = g_apca.apcadocno,
                                        xrcdseq = g_apcb.apcbseq
              
         #將資料塞回原table   
         INSERT INTO xrcd_t SELECT * FROM afap270_detail_44
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code ='afa-01074'    
            LET g_errparam.extend = 'upd xrcd_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         #刪除TEMP TABLE
         DROP TABLE afap270_detail_44
         
         IF g_apca.apcald = g_master.fabgld THEN
            #更新單頭應付帳款單號
            UPDATE fabg_t SET fabg012 = g_apca.apcadocno
             WHERE fabgent = g_enterprise 
               AND fabgld = g_apca.apcald 
               AND fabgdocno = l_faca.facadocno 
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code ='afa-01075'    
               LET g_errparam.extend = 'upd fabg_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE  
            END IF
            
            #更新單身應收帳款單號
            UPDATE faca_t SET faca037 = g_apca.apcadocno
             WHERE facaent = g_enterprise 
               AND facald = g_apca.apcald 
               AND facadocno = l_faca.facadocno 
               AND facaseq = l_faca.facaseq
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code ='afa-01075'     
               LET g_errparam.extend = 'upd faca_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE 
            END IF
         END IF
      END FOREACH
       
      #判斷是否產生單身，如果有資料，匯總金額更新單頭金額，否則刪除單頭資料
      SELECT COUNT(*) INTO l_cnt 
        FROM apcb_t
       WHERE apcbent = g_enterprise 
         AND apcbld = g_apca.apcald 
         AND apcbdocno = g_apca.apcadocno 
      IF l_cnt > 0 THEN  
         SELECT SUM(apcb103),SUM(apcb104),SUM(apcb105),SUM(apcb113),SUM(apcb114),SUM(apcb115),
                SUM(apcb123),SUM(apcb124),SUM(apcb125),SUM(apcb133),SUM(apcb134),SUM(apcb135)  
           INTO g_apca.apca103,g_apca.apca104,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca118,
                g_apca.apca123,g_apca.apca124,g_apca.apca128,g_apca.apca133,g_apca.apca134,g_apca.apca138   
           FROM apcb_t
          WHERE apcbent = g_enterprise 
            AND apcbld = g_apca.apcald 
            AND apcbdocno = g_apca.apcadocno
            
         IF cl_null(g_apca.apca103) THEN LET g_apca.apca103 = 0 END IF 
         IF cl_null(g_apca.apca104) THEN LET g_apca.apca104 = 0 END IF 
         IF cl_null(g_apca.apca108) THEN LET g_apca.apca108 = 0 END IF
         IF cl_null(g_apca.apca113) THEN LET g_apca.apca113 = 0 END IF 
         IF cl_null(g_apca.apca114) THEN LET g_apca.apca114 = 0 END IF
         IF cl_null(g_apca.apca118) THEN LET g_apca.apca118 = 0 END IF
         IF cl_null(g_apca.apca123) THEN LET g_apca.apca123 = 0 END IF 
         IF cl_null(g_apca.apca124) THEN LET g_apca.apca124 = 0 END IF
         IF cl_null(g_apca.apca128) THEN LET g_apca.apca128 = 0 END IF
         IF cl_null(g_apca.apca133) THEN LET g_apca.apca133 = 0 END IF 
         IF cl_null(g_apca.apca134) THEN LET g_apca.apca134 = 0 END IF
         IF cl_null(g_apca.apca138) THEN LET g_apca.apca138 = 0 END IF
         
         UPDATE apca_t SET (apca103,apca104,apca108,apca113,apca114,apca118,
                            apca123,apca124,apca128,apca133,apca134,apca138)
                         = (g_apca.apca103,g_apca.apca104,g_apca.apca108,g_apca.apca113,g_apca.apca114,g_apca.apca118,
                            g_apca.apca123,g_apca.apca124,g_apca.apca128,g_apca.apca133,g_apca.apca134,g_apca.apca138) 
          WHERE apcaent = g_enterprise 
            AND apcald = g_apca.apcald 
            AND apcadocno = g_apca.apcadocno
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'upd apca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
      ELSE
         DELETE FROM apca_t WHERE apcaent = g_enterprise AND apcald = g_apca.apcald AND apcadocno = g_apca.apcadocno
         IF SQLCA.SQLCODE THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =SQLCA.SQLCODE
            LET g_errparam.extend = 'delete apca_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE  
         END IF
         
         #刪除單號
         LET g_prog = 'aapt301'
         IF NOT s_aooi200_fin_del_docno(g_apca.apcald,g_apca.apcadocno,g_apca.apcadocdt) THEN
            LET g_success = FALSE
         END IF
         LET g_prog = 'afap270'
         CONTINUE FOREACH  #无账款单身产生时，后续生产分录底稿和审核操作不用在执行
      END IF
    
      #生成分录底稿
      IF NOT cl_null(g_apca.apcadocno) AND g_apca.apcastus = 'N' THEN
         #获取单别
         CALL s_aooi200_fin_get_slip(g_apca.apcadocno) RETURNING l_success,l_ooba002
         #是否抛傳票
         CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      
         IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
            CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
            CALL s_pre_voucher_ins('AP','P10',g_glaald,g_apca.apcadocno,g_apca.apcadocdt,'1')
               RETURNING l_success
            IF NOT l_success THEN
               LET g_success = FALSE
            END IF
        END IF 
      END IF
      
      #应付账款立即审核
      CALL s_fin_get_doc_para(g_apca.apcald,g_apca.apcacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL s_axrp133_immediately_conf(g_apca.apcald,g_apca.apcadocno)
               RETURNING l_conf_success
      END IF
      IF NOT l_conf_success  THEN 
         LET g_success = FALSE
      END IF 
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 外部参数
# Memo...........: #161228-00013#1 add xul
# Date & Author..: 20170110 By 07900
# Modify.........:
################################################################################
PRIVATE FUNCTION afap270_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " fabgld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabg005 = '", g_argv[03], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   LET g_master.wc = g_wc
   
END FUNCTION

#end add-point
 
{</section>}
 
