#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0044(2016-09-09 17:29:53), PR版次:0044(2017-02-10 17:23:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000196
#+ Filename...: aapt430
#+ Description: 費用分攤維護作業
#+ Creator....: 03080(2014-08-04 17:19:13)
#+ Modifier...: 08729 -SD/PR- 05634
 
{</section>}
 
{<section id="aapt430.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141218-00011#6               By Belle    單身維護時：其他信息的核算，不必檢核是否有輸入及合理性。
#141202-00061#17              By Belle    產生分錄底稿
#150126-00027#1               By Belle    增加傳票補號
#150205-00012#1               BY Hans     進欄位之後只顯示編號不顯示中文名稱
#131212-00002#47              By Reanna   增加列印功能 & 傳票憑證查詢時開窗
#140806-00012#8               By Reanna   增加WBS開窗+檢核 & 固定核算項查詢開窗
#150506-00033#6               By RayHuang 新增單據串查功能
#150629-00038#1               By albireo  入庫性質增加20;借貨性質
#150702-00001#1               By albireo  入庫單性質改動態抓取
#150401-00001#13              By RayHuang statechange段問題修正
#151125-00006#2               By 06421    新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#150916-00015#1   2015/12/7   By Xiaozg   当有账套时，科目检查改为检查是否存在于glad_t中
#151207-00018#3   2015/12/10  By Belle    增加暫估分攤的功能
#151130-00015#2   2015/12/21  BY taozf   判断 是否可以更改單據日期 設定開放單據日期修改
#160104-00007#3   2016/01/29  By Hans     單據作業傳票還原功能aapt210
#160125-00005#6   2016/02/15  By 02097    查詢時，只顯示有權限的帳套
#160225-00001#1   2016/03/04  By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160321-00016#20  2016/03/23  By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#43  2016/04/26  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160506-00002#3   2016/05/30  By Hans     增加費用分攤類型
#160620-00010#2   2016/06/21  By 01531    拋轉傳票時，傳票憑證日期應該預設單據的財務日期，而非系統日期
#160629-00016#1   2016/07/04  By catmoon  調整where條件寫法，避免因為資料庫版本不同有誤
#160727-00028#1   2016/07/29  By catmoon  當抓不到單頭的費用科目(apca036)時，改抓單身最小項次的費用科目(apcb021)
#160816-00021#1   2016/08/16  By 07900   1.隐藏【收款冲销应用】&【请款冲销应用】
#                                        2.系统中目前有aapt430用到【请款冲销应用】把这个逻辑拿掉
#160726-00020#14  2016/08/17  By 08171    人員帶出部門
#160812-00027#1   2016/08/19  By 06821    全面盤點應付程式帳套權限控管
#160818-00017#1   2016/08/23  By 07900    删除修改未重新判断状态码
#160816-00022#1   2016/08/22  By 03538    目的帳款單據頁籤:交易單據+項次串到原入庫單的pmdu(收貨/驗退/入庫/倉退單多庫儲批收貨明細檔),
#                                         檢查於庫位基本資料(aini001)檢查 i中至少要有一筆是成本庫,才可分攤,否則則給予警訊,並不可輸入
#160822-00008#3   2016/08/25  By 08732    新舊值調整
#160905-00002#1   2016/09/05  By Reanna   SQL條件少ENT補上
#160908-00045#1   2016/09/09  By 08729    規格新增來源組織說明欄位
#161006-00005#5   2016/10/12  By 08732    組織類型與職能開窗調整
#161014-00053#3   2016/10/21  By 08171    帳套權限調整
#161104-00024#4   2016/10/21  By 08729    處理DEFINE有星號
#161114-00017#2   2016/11/15  By 06821    應付_開窗過濾據點,帳款單號apce003開窗錯誤一併調整
#160628-00001#1   2016/11/16  By Reanna   調整目的分攤方式=2:依產品號碼取單價的方式
#161208-00026#9   2016/12/12  By 08729    針對SELECT有星號的部分進行展開
#161216-00068#1   2016/12/20  By 06948    調整類型為暫估差異的開窗內容，已存在aapt430的單據將不再出現於開窗清單內(除作廢單據)
#161222-00053#1   2016/12/23  By 06694    agli010與aooi200设置不启用分录底稿，去除提示框。
#161222-00052#1   2016/12/27  By dorishsu 修改當帳款性質為"05:暫估差異",取得aapt430目前已分攤的金額的邏輯
#161104-00046#5   2016/12/30  By 08171    單別預設值;資料依照單別user dept權限過濾單號
#161229-00047#47  2017/01/06  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161213-00023#2   2017/01/12  By 06694    新增axrp330_01元件單別參數，默認拋轉單別
#170123-00045#1   2017/01/25  By 06821    SQL中撈取資料時使用 rownum 語法撰寫方式調整
#170207-00049#1   2017/02/10  By dorishsu 修正161216-00068,需再加上項次條件
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
GLOBALS "../../cfg/top_finance.inc"    #財務模組使用
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apda_m        RECORD
       apdasite LIKE apda_t.apdasite, 
   apdasite_desc LIKE type_t.chr80, 
   apdald LIKE apda_t.apdald, 
   apdald_desc LIKE type_t.chr80, 
   apdadocno LIKE apda_t.apdadocno, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apda014 LIKE apda_t.apda014, 
   apda001 LIKE apda_t.apda001, 
   apda123 LIKE apda_t.apda123, 
   apda133 LIKE apda_t.apda133, 
   apdacomp LIKE apda_t.apdacomp, 
   apdastus LIKE apda_t.apdastus, 
   apda019 LIKE apda_t.apda019, 
   apda020 LIKE apda_t.apda020, 
   apda021 LIKE apda_t.apda021, 
   apda003 LIKE apda_t.apda003, 
   apda003_desc LIKE type_t.chr80, 
   apda018 LIKE apda_t.apda018, 
   apda018_desc LIKE type_t.chr80, 
   apda113 LIKE apda_t.apda113, 
   l_sum_apdc113213 LIKE type_t.num20_6, 
   l_sum_apceapdc LIKE type_t.num20_6, 
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
   apdapstid LIKE apda_t.apdapstid, 
   apdapstid_desc LIKE type_t.chr80, 
   apdapstdt LIKE apda_t.apdapstdt, 
   l_sumcost LIKE type_t.num20_6, 
   l_sumdiscount LIKE type_t.num20_6, 
   l_sumprepay LIKE type_t.num20_6
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apce_d        RECORD
       apceseq LIKE apce_t.apceseq, 
   apce001 LIKE apce_t.apce001, 
   apce002 LIKE apce_t.apce002, 
   apca001 LIKE type_t.chr10, 
   apceorga LIKE apce_t.apceorga, 
   apceorga_desc LIKE type_t.chr500, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce005 LIKE apce_t.apce005, 
   apca004 LIKE type_t.chr10, 
   apca004_desc LIKE type_t.chr500, 
   apce038 LIKE apce_t.apce038, 
   apce047 LIKE apce_t.apce047, 
   apce048 LIKE apce_t.apce048, 
   l_sum_apcb113 LIKE type_t.num20_6, 
   apce119 LIKE apce_t.apce119, 
   l_sum_apcb123 LIKE type_t.num20_6, 
   apce129 LIKE apce_t.apce129, 
   l_sum_apcb133 LIKE type_t.num20_6, 
   apce139 LIKE apce_t.apce139, 
   apce010 LIKE apce_t.apce010, 
   apce015 LIKE apce_t.apce015, 
   apce016 LIKE apce_t.apce016, 
   apce016_desc LIKE type_t.chr500, 
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
   apce060_desc LIKE type_t.chr500, 
   apcecomp LIKE apce_t.apcecomp, 
   apcelegl LIKE apce_t.apcelegl, 
   apcesite LIKE apce_t.apcesite, 
   apce027 LIKE apce_t.apce027, 
   apce028 LIKE apce_t.apce028, 
   apce031 LIKE apce_t.apce031, 
   apce032 LIKE apce_t.apce032, 
   apce100 LIKE apce_t.apce100, 
   apce101 LIKE apce_t.apce101, 
   apce109 LIKE apce_t.apce109, 
   apce120 LIKE apce_t.apce120, 
   apce121 LIKE apce_t.apce121, 
   apce130 LIKE apce_t.apce130, 
   apce131 LIKE apce_t.apce131, 
   apce104 LIKE apce_t.apce104, 
   apce114 LIKE apce_t.apce114, 
   apce124 LIKE apce_t.apce124, 
   apce134 LIKE apce_t.apce134
       END RECORD
PRIVATE TYPE type_g_apce2_d RECORD
       apdcseq LIKE apdc_t.apdcseq, 
   apdc001 LIKE apdc_t.apdc001, 
   apdcorga LIKE apdc_t.apdcorga, 
   apdcorga_desc LIKE type_t.chr500, 
   apdc002 LIKE apdc_t.apdc002, 
   apdc003 LIKE apdc_t.apdc003, 
   apdc004 LIKE apdc_t.apdc004, 
   imaal003 LIKE type_t.chr500, 
   apdc008 LIKE apdc_t.apdc008, 
   apdc009 LIKE apdc_t.apdc009, 
   apdc111 LIKE apdc_t.apdc111, 
   apdc113 LIKE apdc_t.apdc113, 
   apdc211 LIKE apdc_t.apdc211, 
   apdc213 LIKE apdc_t.apdc213, 
   apdc123 LIKE apdc_t.apdc123, 
   apdc223 LIKE apdc_t.apdc223, 
   apdc133 LIKE apdc_t.apdc133, 
   apdc233 LIKE apdc_t.apdc233, 
   apdc005 LIKE apdc_t.apdc005, 
   apdc006 LIKE apdc_t.apdc006, 
   apdc041 LIKE apdc_t.apdc041, 
   apdc015 LIKE apdc_t.apdc015, 
   apdc007 LIKE apdc_t.apdc007, 
   apdc007_desc LIKE type_t.chr500, 
   apdc017 LIKE apdc_t.apdc017, 
   apdc017_desc LIKE type_t.chr500, 
   apdc018 LIKE apdc_t.apdc018, 
   apdc018_desc LIKE type_t.chr500, 
   apdc019 LIKE apdc_t.apdc019, 
   apdc019_desc LIKE type_t.chr500, 
   apdc020 LIKE apdc_t.apdc020, 
   apdc020_desc LIKE type_t.chr500, 
   apdc022 LIKE apdc_t.apdc022, 
   apdc022_desc LIKE type_t.chr500, 
   apdc023 LIKE apdc_t.apdc023, 
   apdc023_desc LIKE type_t.chr500, 
   apdc024 LIKE apdc_t.apdc024, 
   apdc024_desc LIKE type_t.chr500, 
   apdc025 LIKE apdc_t.apdc025, 
   apdc025_desc LIKE type_t.chr500, 
   apdc027 LIKE apdc_t.apdc027, 
   apdc027_desc LIKE type_t.chr500, 
   apdc028 LIKE apdc_t.apdc028, 
   apdc028_desc LIKE type_t.chr500, 
   apdc029 LIKE apdc_t.apdc029, 
   apdc029_desc LIKE type_t.chr500, 
   apdc031 LIKE apdc_t.apdc031, 
   apdc031_desc LIKE type_t.chr500, 
   apdc032 LIKE apdc_t.apdc032, 
   apdc032_desc LIKE type_t.chr500, 
   apdc033 LIKE apdc_t.apdc033, 
   apdc033_desc LIKE type_t.chr500, 
   apdc034 LIKE apdc_t.apdc034, 
   apdc034_desc LIKE type_t.chr500, 
   apdc035 LIKE apdc_t.apdc035, 
   apdc035_desc LIKE type_t.chr500, 
   apdc036 LIKE apdc_t.apdc036, 
   apdc036_desc LIKE type_t.chr500, 
   apdc037 LIKE apdc_t.apdc037, 
   apdc037_desc LIKE type_t.chr500, 
   apdc038 LIKE apdc_t.apdc038, 
   apdc038_desc LIKE type_t.chr500, 
   apdc039 LIKE apdc_t.apdc039, 
   apdc039_desc LIKE type_t.chr500, 
   apdc040 LIKE apdc_t.apdc040, 
   apdc040_desc LIKE type_t.chr500, 
   apdccomp LIKE apdc_t.apdccomp, 
   apdcsite LIKE apdc_t.apdcsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apdadocno LIKE apda_t.apdadocno,
      b_apdald LIKE apda_t.apdald
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_s_fin_2002          LIKE type_t.chr1              #明細沖帳否
DEFINE g_fin_arg1            LIKE gzsz_t.gzsz002           #財務應用參數(定義於azzi991)D-FIN-3001--應付帳款單性質
DEFINE g_fin_arg2            LIKE gzsz_t.gzsz002           #財務應用參數(定義於aoos020)S-BAS-0014--內購外幣使用匯率來源
DEFINE g_array1              DYNAMIC ARRAY OF RECORD
               apcadocno        LIKE apca_t.apcadocno,
               apcbseq          LIKE apcb_t.apcbseq,
               apcc001          LIKE apcc_t.apcc001
                             END RECORD
DEFINE g_glaa102             LIKE glaa_t.glaa102           #借貸不平衡處理方式
DEFINE g_glaa                RECORD
               glaacomp         LIKE glaa_t.glaacomp,
               glaa004          LIKE glaa_t.glaa004,
               glaa015          LIKE glaa_t.glaa015,
               glaa019          LIKE glaa_t.glaa019,
               glaa120          LIKE glaa_t.glaa120,       #成本計算類型 #160628-00001#1
               glaa121          LIKE glaa_t.glaa121
                             END RECORD
DEFINE g_glad                RECORD
               glad0171         LIKE  glad_t.glad0171,
               glad0172         LIKE  glad_t.glad0172,
               glad0181         LIKE  glad_t.glad0181,
               glad0182         LIKE  glad_t.glad0182,
               glad0191         LIKE  glad_t.glad0191,
               glad0192         LIKE  glad_t.glad0192,
               glad0201         LIKE  glad_t.glad0201,
               glad0202         LIKE  glad_t.glad0202,
               glad0211         LIKE  glad_t.glad0211,
               glad0212         LIKE  glad_t.glad0212,
               glad0221         LIKE  glad_t.glad0221,
               glad0222         LIKE  glad_t.glad0222,
               glad0231         LIKE  glad_t.glad0231,
               glad0232         LIKE  glad_t.glad0232,
               glad0241         LIKE  glad_t.glad0241,
               glad0242         LIKE  glad_t.glad0242,
               glad0251         LIKE  glad_t.glad0251,
               glad0252         LIKE  glad_t.glad0252,
               glad0261         LIKE  glad_t.glad0261,
               glad0262         LIKE  glad_t.glad0262
                             END RECORD
DEFINE g_wc_apdasite         STRING                        #帳務組織條件
DEFINE g_wc_apdald           STRING
DEFINE g_ap_slip             LIKE ooba_t.ooba002           #應付帳款單單別
DEFINE g_gl_slip             LIKE ooba_t.ooba002           #總帳單別
DEFINE g_scc8502             STRING
DEFINE g_dfin0030            LIKE type_t.chr1           #141202-00061#17
DEFINE g_wc_cs_ld            STRING                #160125-00005#6
DEFINE g_wc_cs_orga          STRING                #160125-00005#6
DEFINE g_site_str            STRING                #161014-00053#3
DEFINE g_wc_apcald           STRING                #161014-00053#3
DEFINE g_sql_ctrl            STRING                #161114-00017#2 add
#161104-00046#5 --s add
DEFINE g_user_dept_wc      STRING
DEFINE g_user_dept_wc_q    STRING
DEFINE g_user_slip_wc      STRING
#161104-00046#5 --e add
DEFINE g_wc_cs_comp        STRING  #161229-00047#47 add
DEFINE g_comp_str          STRING  #161229-00047#47 add 
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
 
{<section id="aapt430.main" >}
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
   LET g_fin_arg2 = 'S-BAS-0014'
   #161114-00017#2 --s add
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO g_apda_m.apdacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47 mark
   #161114-00017#2 --e add  
   #161104-00046#5 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_apda_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apdald','apdaent','apdadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#5 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apdasite,'',apdald,'',apdadocno,apdadocdt,apda014,apda001,apda123,apda133, 
       apdacomp,apdastus,apda019,apda020,apda021,apda003,'',apda018,'',apda113,'','',apdaownid,'',apdaowndp, 
       '',apdacrtid,'',apdacrtdp,'',apdacrtdt,apdamodid,'',apdamoddt,apdacnfid,'',apdacnfdt,apdapstid, 
       '',apdapstdt,'','',''", 
                      " FROM apda_t",
                      " WHERE apdaent= ? AND apdald=? AND apdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt430_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apdasite,t0.apdald,t0.apdadocno,t0.apdadocdt,t0.apda014,t0.apda001, 
       t0.apda123,t0.apda133,t0.apdacomp,t0.apdastus,t0.apda019,t0.apda020,t0.apda021,t0.apda003,t0.apda018, 
       t0.apda113,t0.apdaownid,t0.apdaowndp,t0.apdacrtid,t0.apdacrtdp,t0.apdacrtdt,t0.apdamodid,t0.apdamoddt, 
       t0.apdacnfid,t0.apdacnfdt,t0.apdapstid,t0.apdapstdt,t1.ooefl003 ,t2.glaal002 ,t3.ooag011 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011 ,t10.ooag011",
               " FROM apda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.apdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.apdald AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apda003  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.apdaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.apdaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apdacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.apdacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.apdamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.apdacnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.apdapstid  ",
 
               " WHERE t0.apdaent = " ||g_enterprise|| " AND t0.apdald = ? AND t0.apdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt430_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt430 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt430_init()   
 
      #進入選單 Menu (="N")
      CALL aapt430_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt430
      
   END IF 
   
   CLOSE aapt430_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt430.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt430_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apdastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('apda019','8513')
   CALL cl_set_combo_scc('apda020','8514')
   CALL cl_set_combo_scc('apda021','8901')
   CALL s_aap_get_acc_str("8502"," gzcb006 = 'Y' ") RETURNING g_scc8502
   CALL cl_set_combo_scc_part('apca001','8502',g_scc8502)
   CALL cl_set_combo_scc_part('apce002','8502',g_scc8502)      #151218-00004#1
   LET g_scc8502 = s_fin_get_wc_str(g_scc8502)                 #161114-00017#2 add 轉換字串,組入SQL才不會有問題 
   CALL cl_set_combo_scc('apce044_desc','6013') #經營方式
   CALL cl_set_combo_scc('apdc027_desc','6013') #經營方式
   
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_continue_no_tmp()                 #150126-00027#1

   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #寫入暫存檔
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   CALL s_fin_azzi800_sons_query(g_today)                      #160125-00005#6
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld      #160125-00005#6
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  #160125-00005#6
   #161229-00047#47 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#47 --e add   
   #end add-point
   
   #初始化搜尋條件
   CALL aapt430_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt430.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt430_ui_dialog()
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
   DEFINE l_chr         LIKE type_t.chr1       #狀態碼
   DEFINE l_glap001     LIKE glap_t.glap001    #傳票性質
   
   DEFINE l_slip      LIKE glap_t.glapdocno 
   DEFINE l_date      LIKE glap_t.glapdocdt
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_docno     LIKE xrem_t.xremdocno
   DEFINE l_start_no  LIKE glap_t.glapdocno
   DEFINE l_stus      LIKE glap_t.glapstus
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE l_glaacomp  LIKE glaa_t.glaacomp
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_j         LIKE type_t.num5
   DEFINE l_cn        LIKE type_t.num10 #151125-00006#2
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
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
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
            CALL aapt430_insert()
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
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt430_init()
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
               
               CALL aapt430_fetch('') # reload data
               LET l_ac = 1
               CALL aapt430_ui_detailshow() #Setting the current row 
         
               CALL aapt430_idx_chk()
               #NEXT FIELD apceseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apce_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt430_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt430_idx_chk()
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
                     #150506-00033#6-----s   
                     IF cl_null(g_apda_m.apdald) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'sub-00280'
                        LET g_errparam.extend = s_fin_get_colname(g_prog,'apdald')
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                     IF cl_null(g_apce_d[g_detail_idx].apce003) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'sub-00280'
                        LET g_errparam.extend = s_fin_get_colname(g_prog,'apce003')
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                     
                     INITIALIZE la_param.* TO NULL
                     CALL s_aapt300_get_aapt3xx_prog(g_apda_m.apdald,g_apce_d[g_detail_idx].apce003)RETURNING la_param.prog,l_i,l_j
                     LET la_param.param[l_i] = g_apda_m.apdald
                     LET la_param.param[l_j] = g_apce_d[g_detail_idx].apce003
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                     #150506-00033#6-----e  
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
               CALL aapt430_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt430_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page2_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apdc002
                  LET g_action_choice="prog_apdc002"
                  IF cl_auth_chk_act("prog_apdc002") THEN
                     
                     #add-point:ON ACTION prog_apdc002 name="menu.detail_show.page2_sub.prog_apdc002"
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     #150506-00033#6-----s
                     IF cl_null(g_apda_m.apdasite) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'sub-00280'
                        LET g_errparam.extend = s_fin_get_colname(g_prog,'apdasite')
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        RETURN
                     END IF
                     
                     IF cl_null(g_apce2_d[g_detail_idx].apdc002) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = 'sub-00280'
                        LET g_errparam.extend = s_fin_get_colname(g_prog,'apdc002')
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        RETURN
                     END IF
                    
                     INITIALIZE la_param.* TO NULL
                     CALL s_aapt300_get_source_apm_prog(11,g_apce2_d[g_detail_idx].apdc002) RETURNING la_param.prog
                     LET la_param.param[1] = g_apce2_d[g_detail_idx].apdc002
                     LET la_param.param[3] = g_apda_m.apdasite
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                     #150506-00033#6-----e
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt430_browser_fill("")
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
               CALL aapt430_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt430_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt430_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt430_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt430_set_act_visible()   
            CALL aapt430_set_act_no_visible()
            IF NOT (g_apda_m.apdald IS NULL
              OR g_apda_m.apdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                                  " apdald = '", g_apda_m.apdald, "' "
                                  ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
               #填到對應位置
               CALL aapt430_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "apdc_t" 
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
               CALL aapt430_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "apdc_t" 
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
                  CALL aapt430_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt430_fetch("F")
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
               CALL aapt430_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt430_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt430_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt430_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt430_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt430_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt430_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt430_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt430_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt430_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt430_idx_chk()
          
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt430_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#2--s
#           IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿  #160818-00017#1 mark
             # 產生分錄底稿             
             IF NOT cl_null(g_apda_m.apdadocno) AND g_apda_m.apdastus = 'N' THEN
                #161222-00053#1--s
                CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip     
                CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
                IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
                #161222-00053#1--e
                   IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿  #160818-00017#1 add
                       CALL s_transaction_begin()
                       CALL s_pre_voucher_ins('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
                            RETURNING g_sub_success
                       IF g_sub_success THEN 
                          CALL s_transaction_end('Y','0')
                       ELSE
                          CALL s_transaction_end('N','0')
                       END IF
                    END IF
                 END IF  #161222-00053#1 add
               END IF
               CALL aapt430_immediately_conf()
               CALL aapt430_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apcaent = g_enterprise #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt430_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt430_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#2--s
#             IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿   #160818-00017#1 mark
              # 產生分錄底稿
              IF NOT cl_null(g_apda_m.apdadocno) AND g_apda_m.apdastus = 'N' THEN
                 #161222-00053#1--s
                 CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip     
                 CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
                 IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
                 #161222-00053#1--e
                    IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿  #160818-00017#1 add
                       CALL s_transaction_begin()
                       CALL s_pre_voucher_ins('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
                            RETURNING g_sub_success
                       IF g_sub_success THEN 
                          CALL s_transaction_end('Y','0')
                       ELSE
                          CALL s_transaction_end('N','0')
                       END IF
                    END IF
                 END IF #161222-00053#1 add
               END IF
               CALL aapt430_immediately_conf()
               CALL aapt430_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apcaent = g_enterprise #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt430_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #141202-00061#17--產生分錄底稿
               IF NOT cl_null(g_apda_m.apdadocno) AND g_apda_m.apdastus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
                       RETURNING g_sub_success
                  IF g_sub_success THEN 
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #141202-00061#17--(E)
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
               
               #無傳票號碼才可拋轉
               IF cl_null(g_apda_m.apda014) THEN
                  #傳票成立時,借貸不平衡的處理方式
                  CALL s_ld_sel_glaa(g_apda_m.apdald,'glaacomp|glaa102')
                       RETURNING g_sub_success,l_glaacomp,g_glaa102
                  #取所屬法人關帳日
                  CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
                  
                  #產生單別/日期
                  #CALL axrp330_01(g_apda_m.apdald) RETURNING l_slip,l_date                           #160620-00010#2 mark
                  CALL axrp330_01(g_apda_m.apdald,g_apda_m.apdadocdt,g_apda_m.apdadocno) RETURNING l_slip,l_date         #160620-00010#2 add  #161213-00023#2 add g_apda_m.apdadocno
                  
                  #必須大於帳套關帳日期才可拋轉
                  IF l_date < l_sfin3007 THEN 
                     LET g_errparam.code = 'aap-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  
                  CALL s_aapp330_cre_tmp() RETURNING g_sub_success
                  CALL s_transaction_begin()
                  
                  DELETE FROM s_voucher_tmp
                  
                  INSERT INTO s_voucher_tmp (docno,type)
                         VALUES (g_apda_m.apdadocno, '0' )
                  SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
                  
                  SELECT count(*) INTO l_count
                    FROM s_voucher_tmp
                  IF l_count > 0 THEN
                     CALL s_aapp330_gen_ac('1','P30',g_apda_m.apdald,'','','1','!#@',g_apda_m.apdastus) RETURNING g_sub_success,l_start_no,l_start_no
                     IF g_sub_success THEN
                        CALL s_transaction_end('Y','Y')
                     ELSE
                        CALL s_transaction_end('N','Y')
                     END IF

                     #傳票拋轉
                     CALL s_transaction_begin()
                     CALL cl_err_collect_init()
                     CALL s_aapp330_generate_voucher('P30',l_slip,l_date,g_apda_m.apdald,'1','Y',g_glaa102,'AP')
                          RETURNING g_sub_success,g_apda_m.apda014,g_apda_m.apda014
                     CALL cl_err_collect_show()
                     
                     #成功則更新aapt920的傳票號碼
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
                     #重新顯示傳票號碼
                     SELECT apda014 INTO g_apda_m.apda014
                       FROM apda_t
                      WHERE apdaent = g_enterprise
                        AND apdadocno = g_apda_m.apdadocno
                        AND apdald = g_apda_m.apdald
                     DISPLAY BY NAME g_apda_m.apda014
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
                      EXIT DIALOG
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
                      CALL cl_cmdrun(ls_js)
                   END IF
               END IF
               ##已產生傳票,不可執行
               #CALL la_param.param.clear()
               #IF cl_null(g_apda_m.apda014) THEN
               #   CALL s_aooi200_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip               
               #   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
               #   IF l_chr = 'Y' THEN
               #      #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
               #      LET g_gl_slip = ''
               #      CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-2002') RETURNING g_gl_slip
               #      IF cl_null(g_gl_slip) THEN
               #         INITIALIZE g_errparam TO NULL
               #         LET g_errparam.code = 'aap-00219'
               #         LET g_errparam.extend = ''
               #         LET g_errparam.popup = TRUE
               #         CALL cl_err()
               #         EXIT DIALOG
               #      END IF
               #      LET la_param.prog = 'aapp420'
               #      IF NOT cl_null(g_gl_slip) THEN 
               #         LET la_param.param[1] = g_apda_m.apdald      #帳套
               #         LET la_param.param[2] = g_apda_m.apdadocno   #單號
               #         LET la_param.param[3] = g_gl_slip            #總帳單別
               #         LET la_param.param[4] = g_apda_m.apdadocdt   #日期
               #         LET la_param.param[5] = g_apda_m.apdasite    #帳務中心
               #      END IF
               #      LET ls_js = util.JSON.stringify( la_param )
               #      CALL cl_cmdrun(ls_js)
               #      SELECT apda014 INTO g_apda_m.apda014
               #        FROM apda_t
               #       WHERE apdaent = g_enterprise
               #         AND apdald  = g_apda_m.apdald AND apdadocno = g_apda_m.apdadocno
               #      DISPLAY BY NAME g_apda_m.apda014
               #   ELSE
               #      INITIALIZE g_errparam TO NULL
               #      LET g_errparam.code = 'aap-00054'
               #      LET g_errparam.extend = g_ap_slip
               #      LET g_errparam.popup = TRUE
               #      CALL cl_err()
               #      EXIT DIALOG
               #   END IF
               #END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt300_14
            LET g_action_choice="open_aapt300_14"
            IF cl_auth_chk_act("open_aapt300_14") THEN
               
               #add-point:ON ACTION open_aapt300_14 name="menu.open_aapt300_14"
               #傳票預覽
               #141202-00061#17--(S)
               IF g_glaa.glaa121 = 'Y' THEN
                  CALL s_pre_voucher('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt)
               ELSE
               #141202-00061#17--(E)
                 CALL s_aapp330_cre_tmp() RETURNING g_sub_success
                 CALL aapt300_14(g_apda_m.apdald,g_apda_m.apdadocno,'1')
               END IF         #141202-00061#17
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt430_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt430_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#2--s
#              IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿  #160818-00017#1 mark
              # 產生分錄底稿
              IF NOT cl_null(g_apda_m.apdadocno) AND g_apda_m.apdastus = 'N' THEN
                 #161222-00053#1--s
                 CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip     
                 CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
                 IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
                 #161222-00053#1--e
                    IF cl_ask_confirm('aap-00420') THEN #是否产生分录底稿 #160818-00017#1 add
                       CALL s_transaction_begin()
                       CALL s_pre_voucher_ins('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,'2')
                            RETURNING g_sub_success
                       IF g_sub_success THEN 
                          CALL s_transaction_end('Y','0')
                       ELSE
                          CALL s_transaction_end('N','0')
                       END IF
                    END IF
                 END IF #161222-00053#1 add
               END IF
               CALL aapt430_immediately_conf()
               CALL aapt430_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apcaent = g_enterprise #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt430_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #列印報表aapr430 #131212-00002#47
               LET g_rep_wc = " apdaent = '",g_enterprise,"' AND apdasite = '",g_apda_m.apdasite,"'"
                             ," AND apdald = '",g_apda_m.apdald,"' AND apdadocno = '",g_apda_m.apdadocno,"'"
                             ," AND apda001 = '",g_apda_m.apda001,"'"
               #END add-point
               &include "erp/aap/aapt430_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #列印報表aapr430 #131212-00002#47
               LET g_rep_wc = " apdaent = '",g_enterprise,"' AND apdasite = '",g_apda_m.apdasite,"'"
                             ," AND apdald = '",g_apda_m.apdald,"' AND apdadocno = '",g_apda_m.apdadocno,"'"
                             ," AND apda001 = '",g_apda_m.apda001,"'"
               #END add-point
               &include "erp/aap/aapt430_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt430_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#2--s
               CALL aapt430_immediately_conf()
               CALL aapt430_immediately_gen()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apcaent = g_enterprise #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt430_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt430_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION recountbody
            LET g_action_choice="recountbody"
            IF cl_auth_chk_act("recountbody") THEN
               
               #add-point:ON ACTION recountbody name="menu.recountbody"
               #160225-00001#1--(S)
               IF NOT cl_null(g_apda_m.apdadocno) THEN
                  SELECT glaald INTO l_ld FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_apda_m.apdacomp
                     AND glaa014 = 'Y'
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,l_slip
                  CALL s_fin_get_doc_para(l_ld,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
                  CALL s_fin_date_close_chk('',g_apda_m.apdacomp,'AAP',g_apda_m.apdadocdt) RETURNING g_sub_success
                  IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
                  ELSE
                  #160225-00001#1--(E)
                     IF NOT cl_ask_confirm('aap-00119') THEN   #是否執行確認？
                     ELSE
                        CALL aapt430_apce_apdc_balance()
                     END IF
                     CALL aapt430_b_fill()
                     CALL aapt430_sum_show()
                  #160225-00001#1--(S)
                  END IF
               END IF
               #160225-00001#1--(E)
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
         ON ACTION prog_apda003
            LET g_action_choice="prog_apda003"
            IF cl_auth_chk_act("prog_apda003") THEN
               
               #add-point:ON ACTION prog_apda003 name="menu.prog_apda003"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apda_m.apda003)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt430_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt430_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt430_set_pk_array()
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
 
{<section id="aapt430.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt430_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #161014-00053#3 add
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
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
   #161014-00053#3 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdald")
   LET l_wc = l_wc," AND ",l_ld_str
   #161014-00053#3 --e add
   LET l_wc = l_wc CLIPPED," AND apda001 = '43' "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ",
                      " ",
                      " LEFT JOIN apce_t ON apceent = apdaent AND apdald = apceld AND apdadocno = apcedocno ", "  ",
                      #add-point:browser_fill段sql(apce_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apdc_t ON apdcent = apdaent AND apdald = apdcld AND apdadocno = apdcdocno", "  ",
                      #add-point:browser_fill段sql(apdc_t1) name="browser_fill.cnt.join.apdc_t1"
                      
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
   LET g_wc = g_wc CLIPPED," AND apda001 = '43' "
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
                  "  LEFT JOIN apdc_t ON apdcent = apdaent AND apdald = apdcld AND apdadocno = apdcdocno", "  ", 
                  #add-point:browser_fill段sql(apdc_t1) name="browser_fill.join.apdc_t1"
                  
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
   IF NOT cl_null(g_wc_cs_ld) THEN     #160125-00005#6--(S)
      LET g_sql = g_sql , " AND apdald IN ",g_wc_cs_ld
   END IF                              #160125-00005#6--(E)
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
         CALL aapt430_browser_mask()
      
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
 
{<section id="aapt430.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt430_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apda_m.apdald = g_browser[g_current_idx].b_apdald   
   LET g_apda_m.apdadocno = g_browser[g_current_idx].b_apdadocno   
 
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
   CALL aapt430_apda_t_mask()
   CALL aapt430_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt430.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt430_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt430_ui_browser_refresh()
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
 
{<section id="aapt430.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt430_construct()
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
   DEFINE l_ld_str    STRING  #161014-00053#3 add
   #161114-00017#2 --s add
   DEFINE l_apdc004_comp LIKE ooef_t.ooef017
   DEFINE l_ld           LIKE glaa_t.glaald
   DEFINE l_comp         LIKE ooef_t.ooef001
   #161114-00017#2 --e add   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apda_m.* TO NULL
   CALL g_apce_d.clear()        
   CALL g_apce2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL   #161014-00053#3
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apdasite,apdald,apdadocno,apdadocdt,apda014,apda001,apda123,apda133, 
          apdacomp,apdastus,apda019,apda020,apda021,apda003,apda018,apda018_desc,apda113,l_sum_apdc113213, 
          l_sum_apceapdc,apdaownid,apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid, 
          apdacnfdt,apdapstid,apdapstdt
 
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
         AFTER FIELD apdapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="construct.c.apdasite"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_46()   #161006-00005#5   add
            DISPLAY g_qryparam.return1 TO apdasite
            NEXT FIELD apdasite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="construct.b.apdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="construct.a.apdasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161014-00053#3
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
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161014-00053#3 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld    #160125-00005#6  #161014-00053#3 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161014-00053#3 add
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
            LET g_qryparam.where = " apda001 = '43'"
            #161114-00017#2 --s add
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161114-00017#2 --e add    
            #161104-00046#5 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#5 --e add             
            CALL q_apdadocno_1()
            DISPLAY g_qryparam.return1 TO apdadocno
            NEXT FIELD apdadocno
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
            #開窗C段-傳票編號 #131212-00002#47
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apda001 = '43' "
            CALL q_apda014_2()
            DISPLAY g_qryparam.return1 TO apda014
            NEXT FIELD apda014
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
         BEFORE FIELD apda123
            #add-point:BEFORE FIELD apda123 name="construct.b.apda123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda123
            
            #add-point:AFTER FIELD apda123 name="construct.a.apda123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda123
            #add-point:ON ACTION controlp INFIELD apda123 name="construct.c.apda123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda133
            #add-point:BEFORE FIELD apda133 name="construct.b.apda133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda133
            
            #add-point:AFTER FIELD apda133 name="construct.a.apda133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda133
            #add-point:ON ACTION controlp INFIELD apda133 name="construct.c.apda133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacomp
            #add-point:BEFORE FIELD apdacomp name="construct.b.apdacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacomp
            
            #add-point:AFTER FIELD apdacomp name="construct.a.apdacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacomp
            #add-point:ON ACTION controlp INFIELD apdacomp name="construct.c.apdacomp"
            
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
         BEFORE FIELD apda019
            #add-point:BEFORE FIELD apda019 name="construct.b.apda019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda019
            
            #add-point:AFTER FIELD apda019 name="construct.a.apda019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda019
            #add-point:ON ACTION controlp INFIELD apda019 name="construct.c.apda019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda020
            #add-point:BEFORE FIELD apda020 name="construct.b.apda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda020
            
            #add-point:AFTER FIELD apda020 name="construct.a.apda020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda020
            #add-point:ON ACTION controlp INFIELD apda020 name="construct.c.apda020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda021
            #add-point:BEFORE FIELD apda021 name="construct.b.apda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda021
            
            #add-point:AFTER FIELD apda021 name="construct.a.apda021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda021
            #add-point:ON ACTION controlp INFIELD apda021 name="construct.c.apda021"
            
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
            DISPLAY g_qryparam.return1 TO apda003
            NEXT FIELD apda003
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
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apda018
            NEXT FIELD apda018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018_desc
            #add-point:BEFORE FIELD apda018_desc name="construct.b.apda018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018_desc
            
            #add-point:AFTER FIELD apda018_desc name="construct.a.apda018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018_desc
            #add-point:ON ACTION controlp INFIELD apda018_desc name="construct.c.apda018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda113
            #add-point:BEFORE FIELD apda113 name="construct.b.apda113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda113
            
            #add-point:AFTER FIELD apda113 name="construct.a.apda113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda113
            #add-point:ON ACTION controlp INFIELD apda113 name="construct.c.apda113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apdc113213
            #add-point:BEFORE FIELD l_sum_apdc113213 name="construct.b.l_sum_apdc113213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apdc113213
            
            #add-point:AFTER FIELD l_sum_apdc113213 name="construct.a.l_sum_apdc113213"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_sum_apdc113213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apdc113213
            #add-point:ON ACTION controlp INFIELD l_sum_apdc113213 name="construct.c.l_sum_apdc113213"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apceapdc
            #add-point:BEFORE FIELD l_sum_apceapdc name="construct.b.l_sum_apceapdc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apceapdc
            
            #add-point:AFTER FIELD l_sum_apceapdc name="construct.a.l_sum_apceapdc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_sum_apceapdc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apceapdc
            #add-point:ON ACTION controlp INFIELD l_sum_apceapdc name="construct.c.l_sum_apceapdc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdaownid
            #add-point:ON ACTION controlp INFIELD apdaownid name="construct.c.apdaownid"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apdaownid
            NEXT FIELD apdaownid
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
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO apdaowndp
            NEXT FIELD apdaowndp
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
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apdacrtid
            NEXT FIELD apdacrtid
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
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO apdacrtdp
            NEXT FIELD apdacrtdp
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
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apdamodid
            NEXT FIELD apdamodid
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
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apdacnfid
            NEXT FIELD apdacnfid
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
 
 
         #Ctrlp:construct.c.apdapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdapstid
            #add-point:ON ACTION controlp INFIELD apdapstid name="construct.c.apdapstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdapstid  #顯示到畫面上
            NEXT FIELD apdapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdapstid
            #add-point:BEFORE FIELD apdapstid name="construct.b.apdapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdapstid
            
            #add-point:AFTER FIELD apdapstid name="construct.a.apdapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdapstdt
            #add-point:BEFORE FIELD apdapstdt name="construct.b.apdapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apceseq,apce002,apca001,apceorga,apce003,apce004,apce005,apce038,apce047, 
          apce048,apce119,l_sum_apcb123,apce129,l_sum_apcb133,apce139,apce010,apce016,apce016_desc,apce017, 
          apce017_desc,apce018,apce018_desc,apce019,apce019_desc,apce020,apce020_desc,apce022,apce022_desc, 
          apce023,apce023_desc,apce035,apce035_desc,apce036,apce036_desc,apce044,apce044_desc,apce045, 
          apce045_desc,apce046,apce046_desc,apcecomp,apcelegl,apcesite,apce027,apce028,apce031,apce032, 
          apce100,apce101,apce109,apce120,apce121,apce130,apce131,apce104,apce114,apce124,apce134
           FROM s_detail1[1].apceseq,s_detail1[1].apce002,s_detail1[1].apca001,s_detail1[1].apceorga, 
               s_detail1[1].apce003,s_detail1[1].apce004,s_detail1[1].apce005,s_detail1[1].apce038,s_detail1[1].apce047, 
               s_detail1[1].apce048,s_detail1[1].apce119,s_detail1[1].l_sum_apcb123,s_detail1[1].apce129, 
               s_detail1[1].l_sum_apcb133,s_detail1[1].apce139,s_detail1[1].apce010,s_detail1[1].apce016, 
               s_detail1[1].apce016_desc,s_detail1[1].apce017,s_detail1[1].apce017_desc,s_detail1[1].apce018, 
               s_detail1[1].apce018_desc,s_detail1[1].apce019,s_detail1[1].apce019_desc,s_detail1[1].apce020, 
               s_detail1[1].apce020_desc,s_detail1[1].apce022,s_detail1[1].apce022_desc,s_detail1[1].apce023, 
               s_detail1[1].apce023_desc,s_detail1[1].apce035,s_detail1[1].apce035_desc,s_detail1[1].apce036, 
               s_detail1[1].apce036_desc,s_detail1[1].apce044,s_detail1[1].apce044_desc,s_detail1[1].apce045, 
               s_detail1[1].apce045_desc,s_detail1[1].apce046,s_detail1[1].apce046_desc,s_detail1[1].apcecomp, 
               s_detail1[1].apcelegl,s_detail1[1].apcesite,s_detail1[1].apce027,s_detail1[1].apce028, 
               s_detail1[1].apce031,s_detail1[1].apce032,s_detail1[1].apce100,s_detail1[1].apce101,s_detail1[1].apce109, 
               s_detail1[1].apce120,s_detail1[1].apce121,s_detail1[1].apce130,s_detail1[1].apce131,s_detail1[1].apce104, 
               s_detail1[1].apce114,s_detail1[1].apce124,s_detail1[1].apce134
                      
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="construct.b.page1.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="construct.a.page1.apca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="construct.c.page1.apca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceorga
            #add-point:BEFORE FIELD apceorga name="construct.b.page1.apceorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceorga
            
            #add-point:AFTER FIELD apceorga name="construct.a.page1.apceorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apceorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceorga
            #add-point:ON ACTION controlp INFIELD apceorga name="construct.c.page1.apceorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,
   			                          " AND ooef201 = 'Y'"   #161006-00005#5   add
   			END IF                                    #160125-00005#6
            #CALL q_ooef001_11()   #161006-00005#5   mark
            CALL q_ooef001()       #161006-00005#5   add
            DISPLAY g_qryparam.return1 TO apceorga
            NEXT FIELD apceorga
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
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "apca001 IN (",g_scc8502,")" #161114-00017#2 mark
            LET g_qryparam.where = "apca001 IN ",g_scc8502       #161114-00017#2 add
            CALL q_apce003_01()
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
         BEFORE FIELD apce038
            #add-point:BEFORE FIELD apce038 name="construct.b.page1.apce038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce038
            
            #add-point:AFTER FIELD apce038 name="construct.a.page1.apce038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce038
            #add-point:ON ACTION controlp INFIELD apce038 name="construct.c.page1.apce038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce047
            #add-point:BEFORE FIELD apce047 name="construct.b.page1.apce047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce047
            
            #add-point:AFTER FIELD apce047 name="construct.a.page1.apce047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce047
            #add-point:ON ACTION controlp INFIELD apce047 name="construct.c.page1.apce047"
            
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
         BEFORE FIELD l_sum_apcb123
            #add-point:BEFORE FIELD l_sum_apcb123 name="construct.b.page1.l_sum_apcb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apcb123
            
            #add-point:AFTER FIELD l_sum_apcb123 name="construct.a.page1.l_sum_apcb123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_sum_apcb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apcb123
            #add-point:ON ACTION controlp INFIELD l_sum_apcb123 name="construct.c.page1.l_sum_apcb123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce129
            #add-point:BEFORE FIELD apce129 name="construct.b.page1.apce129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce129
            
            #add-point:AFTER FIELD apce129 name="construct.a.page1.apce129"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce129
            #add-point:ON ACTION controlp INFIELD apce129 name="construct.c.page1.apce129"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apcb133
            #add-point:BEFORE FIELD l_sum_apcb133 name="construct.b.page1.l_sum_apcb133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apcb133
            
            #add-point:AFTER FIELD l_sum_apcb133 name="construct.a.page1.l_sum_apcb133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_sum_apcb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apcb133
            #add-point:ON ACTION controlp INFIELD l_sum_apcb133 name="construct.c.page1.l_sum_apcb133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce139
            #add-point:BEFORE FIELD apce139 name="construct.b.page1.apce139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce139
            
            #add-point:AFTER FIELD apce139 name="construct.a.page1.apce139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce139
            #add-point:ON ACTION controlp INFIELD apce139 name="construct.c.page1.apce139"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce010
            #add-point:ON ACTION controlp INFIELD apce010 name="construct.c.page1.apce010"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016
            #add-point:ON ACTION controlp INFIELD apce016 name="construct.c.page1.apce016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016_desc
            #add-point:BEFORE FIELD apce016_desc name="construct.b.page1.apce016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016_desc
            
            #add-point:AFTER FIELD apce016_desc name="construct.a.page1.apce016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016_desc
            #add-point:ON ACTION controlp INFIELD apce016_desc name="construct.c.page1.apce016_desc"
            #來源會計科目 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "
            #161114-00017#2 --s add
			   LET l_comp = NULL
			   SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			   LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glacent = gladent AND glad001= glac002 ",
                                   " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161114-00017#2 --s add              
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apce016
            DISPLAY g_qryparam.return1 TO apce016_desc
            NEXT FIELD apce016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017
            #add-point:BEFORE FIELD apce017 name="construct.b.page1.apce017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017
            
            #add-point:AFTER FIELD apce017 name="construct.a.page1.apce017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017
            #add-point:ON ACTION controlp INFIELD apce017 name="construct.c.page1.apce017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017_desc
            #add-point:BEFORE FIELD apce017_desc name="construct.b.page1.apce017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017_desc
            
            #add-point:AFTER FIELD apce017_desc name="construct.a.page1.apce017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017_desc
            #add-point:ON ACTION controlp INFIELD apce017_desc name="construct.c.page1.apce017_desc"
            #業務人員 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO apce017
            DISPLAY g_qryparam.return1 TO apce017_desc
            NEXT FIELD apce017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018
            #add-point:BEFORE FIELD apce018 name="construct.b.page1.apce018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018
            
            #add-point:AFTER FIELD apce018 name="construct.a.page1.apce018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018
            #add-point:ON ACTION controlp INFIELD apce018 name="construct.c.page1.apce018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018_desc
            #add-point:BEFORE FIELD apce018_desc name="construct.b.page1.apce018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018_desc
            
            #add-point:AFTER FIELD apce018_desc name="construct.a.page1.apce018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018_desc
            #add-point:ON ACTION controlp INFIELD apce018_desc name="construct.c.page1.apce018_desc"
            #業務部門 #140806-00012#8
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
            #add-point:BEFORE FIELD apce019 name="construct.b.page1.apce019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019
            
            #add-point:AFTER FIELD apce019 name="construct.a.page1.apce019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019
            #add-point:ON ACTION controlp INFIELD apce019 name="construct.c.page1.apce019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019_desc
            #add-point:BEFORE FIELD apce019_desc name="construct.b.page1.apce019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019_desc
            
            #add-point:AFTER FIELD apce019_desc name="construct.a.page1.apce019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019_desc
            #add-point:ON ACTION controlp INFIELD apce019_desc name="construct.c.page1.apce019_desc"
            #責任中心 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apce019
            DISPLAY g_qryparam.return1 TO apce019_desc
            NEXT FIELD apce019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020
            #add-point:BEFORE FIELD apce020 name="construct.b.page1.apce020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020
            
            #add-point:AFTER FIELD apce020 name="construct.a.page1.apce020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020
            #add-point:ON ACTION controlp INFIELD apce020 name="construct.c.page1.apce020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020_desc
            #add-point:BEFORE FIELD apce020_desc name="construct.b.page1.apce020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020_desc
            
            #add-point:AFTER FIELD apce020_desc name="construct.a.page1.apce020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020_desc
            #add-point:ON ACTION controlp INFIELD apce020_desc name="construct.c.page1.apce020_desc"
            #產品類別 #140806-00012#8
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
            #add-point:BEFORE FIELD apce022 name="construct.b.page1.apce022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022
            
            #add-point:AFTER FIELD apce022 name="construct.a.page1.apce022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022
            #add-point:ON ACTION controlp INFIELD apce022 name="construct.c.page1.apce022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022_desc
            #add-point:BEFORE FIELD apce022_desc name="construct.b.page1.apce022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022_desc
            
            #add-point:AFTER FIELD apce022_desc name="construct.a.page1.apce022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022_desc
            #add-point:ON ACTION controlp INFIELD apce022_desc name="construct.c.page1.apce022_desc"
            #專案代號 #140806-00012#8
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
            #add-point:BEFORE FIELD apce023 name="construct.b.page1.apce023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023
            
            #add-point:AFTER FIELD apce023 name="construct.a.page1.apce023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023
            #add-point:ON ACTION controlp INFIELD apce023 name="construct.c.page1.apce023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023_desc
            #add-point:BEFORE FIELD apce023_desc name="construct.b.page1.apce023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023_desc
            
            #add-point:AFTER FIELD apce023_desc name="construct.a.page1.apce023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023_desc
            #add-point:ON ACTION controlp INFIELD apce023_desc name="construct.c.page1.apce023_desc"
            #WBS #140806-00012#8
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
            #add-point:BEFORE FIELD apce035 name="construct.b.page1.apce035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035
            
            #add-point:AFTER FIELD apce035 name="construct.a.page1.apce035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035
            #add-point:ON ACTION controlp INFIELD apce035 name="construct.c.page1.apce035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035_desc
            #add-point:BEFORE FIELD apce035_desc name="construct.b.page1.apce035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035_desc
            
            #add-point:AFTER FIELD apce035_desc name="construct.a.page1.apce035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035_desc
            #add-point:ON ACTION controlp INFIELD apce035_desc name="construct.c.page1.apce035_desc"
            #區域 #140806-00012#8
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
            #add-point:BEFORE FIELD apce036 name="construct.b.page1.apce036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036
            
            #add-point:AFTER FIELD apce036 name="construct.a.page1.apce036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036
            #add-point:ON ACTION controlp INFIELD apce036 name="construct.c.page1.apce036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036_desc
            #add-point:BEFORE FIELD apce036_desc name="construct.b.page1.apce036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036_desc
            
            #add-point:AFTER FIELD apce036_desc name="construct.a.page1.apce036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036_desc
            #add-point:ON ACTION controlp INFIELD apce036_desc name="construct.c.page1.apce036_desc"
            #客群 #140806-00012#8
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
            #add-point:BEFORE FIELD apce044 name="construct.b.page1.apce044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044
            
            #add-point:AFTER FIELD apce044 name="construct.a.page1.apce044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044
            #add-point:ON ACTION controlp INFIELD apce044 name="construct.c.page1.apce044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044_desc
            #add-point:BEFORE FIELD apce044_desc name="construct.b.page1.apce044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044_desc
            
            #add-point:AFTER FIELD apce044_desc name="construct.a.page1.apce044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044_desc
            #add-point:ON ACTION controlp INFIELD apce044_desc name="construct.c.page1.apce044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045
            #add-point:BEFORE FIELD apce045 name="construct.b.page1.apce045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045
            
            #add-point:AFTER FIELD apce045 name="construct.a.page1.apce045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045
            #add-point:ON ACTION controlp INFIELD apce045 name="construct.c.page1.apce045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045_desc
            #add-point:BEFORE FIELD apce045_desc name="construct.b.page1.apce045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045_desc
            
            #add-point:AFTER FIELD apce045_desc name="construct.a.page1.apce045_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045_desc
            #add-point:ON ACTION controlp INFIELD apce045_desc name="construct.c.page1.apce045_desc"
            #渠道 #140806-00012#8
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
            #add-point:BEFORE FIELD apce046 name="construct.b.page1.apce046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046
            
            #add-point:AFTER FIELD apce046 name="construct.a.page1.apce046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046
            #add-point:ON ACTION controlp INFIELD apce046 name="construct.c.page1.apce046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046_desc
            #add-point:BEFORE FIELD apce046_desc name="construct.b.page1.apce046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046_desc
            
            #add-point:AFTER FIELD apce046_desc name="construct.a.page1.apce046_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046_desc
            #add-point:ON ACTION controlp INFIELD apce046_desc name="construct.c.page1.apce046_desc"
            #品牌 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO apce046
            DISPLAY g_qryparam.return1 TO apce046_desc
            NEXT FIELD apce046_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcecomp
            #add-point:BEFORE FIELD apcecomp name="construct.b.page1.apcecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcecomp
            
            #add-point:AFTER FIELD apcecomp name="construct.a.page1.apcecomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apcecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcecomp
            #add-point:ON ACTION controlp INFIELD apcecomp name="construct.c.page1.apcecomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcelegl
            #add-point:BEFORE FIELD apcelegl name="construct.b.page1.apcelegl"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcelegl
            
            #add-point:AFTER FIELD apcelegl name="construct.a.page1.apcelegl"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apcelegl
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcelegl
            #add-point:ON ACTION controlp INFIELD apcelegl name="construct.c.page1.apcelegl"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcesite
            #add-point:BEFORE FIELD apcesite name="construct.b.page1.apcesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcesite
            
            #add-point:AFTER FIELD apcesite name="construct.a.page1.apcesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apcesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcesite
            #add-point:ON ACTION controlp INFIELD apcesite name="construct.c.page1.apcesite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce027
            #add-point:BEFORE FIELD apce027 name="construct.b.page1.apce027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce027
            
            #add-point:AFTER FIELD apce027 name="construct.a.page1.apce027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce027
            #add-point:ON ACTION controlp INFIELD apce027 name="construct.c.page1.apce027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce028
            #add-point:BEFORE FIELD apce028 name="construct.b.page1.apce028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce028
            
            #add-point:AFTER FIELD apce028 name="construct.a.page1.apce028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce028
            #add-point:ON ACTION controlp INFIELD apce028 name="construct.c.page1.apce028"
            
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
         BEFORE FIELD apce032
            #add-point:BEFORE FIELD apce032 name="construct.b.page1.apce032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce032
            
            #add-point:AFTER FIELD apce032 name="construct.a.page1.apce032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce032
            #add-point:ON ACTION controlp INFIELD apce032 name="construct.c.page1.apce032"
            
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
         BEFORE FIELD apce120
            #add-point:BEFORE FIELD apce120 name="construct.b.page1.apce120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce120
            
            #add-point:AFTER FIELD apce120 name="construct.a.page1.apce120"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce120
            #add-point:ON ACTION controlp INFIELD apce120 name="construct.c.page1.apce120"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce121
            #add-point:BEFORE FIELD apce121 name="construct.b.page1.apce121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce121
            
            #add-point:AFTER FIELD apce121 name="construct.a.page1.apce121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce121
            #add-point:ON ACTION controlp INFIELD apce121 name="construct.c.page1.apce121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce130
            #add-point:BEFORE FIELD apce130 name="construct.b.page1.apce130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce130
            
            #add-point:AFTER FIELD apce130 name="construct.a.page1.apce130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce130
            #add-point:ON ACTION controlp INFIELD apce130 name="construct.c.page1.apce130"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce131
            #add-point:BEFORE FIELD apce131 name="construct.b.page1.apce131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce131
            
            #add-point:AFTER FIELD apce131 name="construct.a.page1.apce131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce131
            #add-point:ON ACTION controlp INFIELD apce131 name="construct.c.page1.apce131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce104
            #add-point:BEFORE FIELD apce104 name="construct.b.page1.apce104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce104
            
            #add-point:AFTER FIELD apce104 name="construct.a.page1.apce104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce104
            #add-point:ON ACTION controlp INFIELD apce104 name="construct.c.page1.apce104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce114
            #add-point:BEFORE FIELD apce114 name="construct.b.page1.apce114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce114
            
            #add-point:AFTER FIELD apce114 name="construct.a.page1.apce114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce114
            #add-point:ON ACTION controlp INFIELD apce114 name="construct.c.page1.apce114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce124
            #add-point:BEFORE FIELD apce124 name="construct.b.page1.apce124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce124
            
            #add-point:AFTER FIELD apce124 name="construct.a.page1.apce124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce124
            #add-point:ON ACTION controlp INFIELD apce124 name="construct.c.page1.apce124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce134
            #add-point:BEFORE FIELD apce134 name="construct.b.page1.apce134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce134
            
            #add-point:AFTER FIELD apce134 name="construct.a.page1.apce134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apce134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce134
            #add-point:ON ACTION controlp INFIELD apce134 name="construct.c.page1.apce134"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apdcseq,apdc001,apdcorga,apdc002,apdc003,apdc004,apdc009,apdc111,apdc113, 
          apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,apdc007,apdc007_desc, 
          apdc017,apdc017_desc,apdc018,apdc018_desc,apdc019,apdc019_desc,apdc020,apdc020_desc,apdc022, 
          apdc022_desc,apdc023,apdc023_desc,apdc024,apdc024_desc,apdc025,apdc025_desc,apdc027,apdc027_desc, 
          apdc028,apdc028_desc,apdc029,apdc029_desc,apdccomp,apdcsite
           FROM s_detail2[1].apdcseq,s_detail2[1].apdc001,s_detail2[1].apdcorga,s_detail2[1].apdc002, 
               s_detail2[1].apdc003,s_detail2[1].apdc004,s_detail2[1].apdc009,s_detail2[1].apdc111,s_detail2[1].apdc113, 
               s_detail2[1].apdc211,s_detail2[1].apdc213,s_detail2[1].apdc123,s_detail2[1].apdc223,s_detail2[1].apdc133, 
               s_detail2[1].apdc233,s_detail2[1].apdc005,s_detail2[1].apdc006,s_detail2[1].apdc041,s_detail2[1].apdc007, 
               s_detail2[1].apdc007_desc,s_detail2[1].apdc017,s_detail2[1].apdc017_desc,s_detail2[1].apdc018, 
               s_detail2[1].apdc018_desc,s_detail2[1].apdc019,s_detail2[1].apdc019_desc,s_detail2[1].apdc020, 
               s_detail2[1].apdc020_desc,s_detail2[1].apdc022,s_detail2[1].apdc022_desc,s_detail2[1].apdc023, 
               s_detail2[1].apdc023_desc,s_detail2[1].apdc024,s_detail2[1].apdc024_desc,s_detail2[1].apdc025, 
               s_detail2[1].apdc025_desc,s_detail2[1].apdc027,s_detail2[1].apdc027_desc,s_detail2[1].apdc028, 
               s_detail2[1].apdc028_desc,s_detail2[1].apdc029,s_detail2[1].apdc029_desc,s_detail2[1].apdccomp, 
               s_detail2[1].apdcsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcseq
            #add-point:BEFORE FIELD apdcseq name="construct.b.page2.apdcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcseq
            
            #add-point:AFTER FIELD apdcseq name="construct.a.page2.apdcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcseq
            #add-point:ON ACTION controlp INFIELD apdcseq name="construct.c.page2.apdcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc001
            #add-point:BEFORE FIELD apdc001 name="construct.b.page2.apdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc001
            
            #add-point:AFTER FIELD apdc001 name="construct.a.page2.apdc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc001
            #add-point:ON ACTION controlp INFIELD apdc001 name="construct.c.page2.apdc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcorga
            #add-point:BEFORE FIELD apdcorga name="construct.b.page2.apdcorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcorga
            
            #add-point:AFTER FIELD apdcorga name="construct.a.page2.apdcorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcorga
            #add-point:ON ACTION controlp INFIELD apdcorga name="construct.c.page2.apdcorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,
   			                          " AND ooef201 = 'Y'"   #161006-00005#5   add
   			END IF                                    #160125-00005#6
            #CALL q_ooef001_11()   #161006-00005#5   mark
            CALL q_ooef001()       #161006-00005#5   add
            DISPLAY g_qryparam.return1 TO apdcorga
            NEXT FIELD apdcorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc002
            #add-point:BEFORE FIELD apdc002 name="construct.b.page2.apdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc002
            
            #add-point:AFTER FIELD apdc002 name="construct.a.page2.apdc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc002
            #add-point:ON ACTION controlp INFIELD apdc002 name="construct.c.page2.apdc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdc002_01()
            DISPLAY g_qryparam.return1 TO apdc002
            NEXT FIELD apdc002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc003
            #add-point:BEFORE FIELD apdc003 name="construct.b.page2.apdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc003
            
            #add-point:AFTER FIELD apdc003 name="construct.a.page2.apdc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc003
            #add-point:ON ACTION controlp INFIELD apdc003 name="construct.c.page2.apdc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc004
            #add-point:BEFORE FIELD apdc004 name="construct.b.page2.apdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc004
            
            #add-point:AFTER FIELD apdc004 name="construct.a.page2.apdc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc004
            #add-point:ON ACTION controlp INFIELD apdc004 name="construct.c.page2.apdc004"
            #161114-00017#2 --s add 
            LET l_apdc004_comp = ''
            SELECT ooef017 INTO l_apdc004_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            #161114-00017#2 --e add              
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_apda_m.apdasite  #161114-00017#2 mark
            #CALL q_imaf001_7()                       #161114-00017#2 mark
            LET g_qryparam.arg1 = l_apdc004_comp      #161114-00017#2 add
            CALL q_imaf001_21()                       #161114-00017#2 add
            DISPLAY g_qryparam.return1 TO apdc004
            NEXT FIELD apdc004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc009
            #add-point:BEFORE FIELD apdc009 name="construct.b.page2.apdc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc009
            
            #add-point:AFTER FIELD apdc009 name="construct.a.page2.apdc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc009
            #add-point:ON ACTION controlp INFIELD apdc009 name="construct.c.page2.apdc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc111
            #add-point:BEFORE FIELD apdc111 name="construct.b.page2.apdc111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc111
            
            #add-point:AFTER FIELD apdc111 name="construct.a.page2.apdc111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc111
            #add-point:ON ACTION controlp INFIELD apdc111 name="construct.c.page2.apdc111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc113
            #add-point:BEFORE FIELD apdc113 name="construct.b.page2.apdc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc113
            
            #add-point:AFTER FIELD apdc113 name="construct.a.page2.apdc113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc113
            #add-point:ON ACTION controlp INFIELD apdc113 name="construct.c.page2.apdc113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc211
            #add-point:BEFORE FIELD apdc211 name="construct.b.page2.apdc211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc211
            
            #add-point:AFTER FIELD apdc211 name="construct.a.page2.apdc211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc211
            #add-point:ON ACTION controlp INFIELD apdc211 name="construct.c.page2.apdc211"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc213
            #add-point:BEFORE FIELD apdc213 name="construct.b.page2.apdc213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc213
            
            #add-point:AFTER FIELD apdc213 name="construct.a.page2.apdc213"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc213
            #add-point:ON ACTION controlp INFIELD apdc213 name="construct.c.page2.apdc213"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc123
            #add-point:BEFORE FIELD apdc123 name="construct.b.page2.apdc123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc123
            
            #add-point:AFTER FIELD apdc123 name="construct.a.page2.apdc123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc123
            #add-point:ON ACTION controlp INFIELD apdc123 name="construct.c.page2.apdc123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc223
            #add-point:BEFORE FIELD apdc223 name="construct.b.page2.apdc223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc223
            
            #add-point:AFTER FIELD apdc223 name="construct.a.page2.apdc223"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc223
            #add-point:ON ACTION controlp INFIELD apdc223 name="construct.c.page2.apdc223"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc133
            #add-point:BEFORE FIELD apdc133 name="construct.b.page2.apdc133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc133
            
            #add-point:AFTER FIELD apdc133 name="construct.a.page2.apdc133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc133
            #add-point:ON ACTION controlp INFIELD apdc133 name="construct.c.page2.apdc133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc233
            #add-point:BEFORE FIELD apdc233 name="construct.b.page2.apdc233"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc233
            
            #add-point:AFTER FIELD apdc233 name="construct.a.page2.apdc233"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc233
            #add-point:ON ACTION controlp INFIELD apdc233 name="construct.c.page2.apdc233"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc005
            #add-point:BEFORE FIELD apdc005 name="construct.b.page2.apdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc005
            
            #add-point:AFTER FIELD apdc005 name="construct.a.page2.apdc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc005
            #add-point:ON ACTION controlp INFIELD apdc005 name="construct.c.page2.apdc005"
            #目的帳款單號查詢
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdc005()
            DISPLAY g_qryparam.return1 TO apdc005
            NEXT FIELD apdc005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc006
            #add-point:BEFORE FIELD apdc006 name="construct.b.page2.apdc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc006
            
            #add-point:AFTER FIELD apdc006 name="construct.a.page2.apdc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc006
            #add-point:ON ACTION controlp INFIELD apdc006 name="construct.c.page2.apdc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc041
            #add-point:BEFORE FIELD apdc041 name="construct.b.page2.apdc041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc041
            
            #add-point:AFTER FIELD apdc041 name="construct.a.page2.apdc041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc041
            #add-point:ON ACTION controlp INFIELD apdc041 name="construct.c.page2.apdc041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc007
            #add-point:BEFORE FIELD apdc007 name="construct.b.page2.apdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc007
            
            #add-point:AFTER FIELD apdc007 name="construct.a.page2.apdc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc007
            #add-point:ON ACTION controlp INFIELD apdc007 name="construct.c.page2.apdc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc007_desc
            #add-point:BEFORE FIELD apdc007_desc name="construct.b.page2.apdc007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc007_desc
            
            #add-point:AFTER FIELD apdc007_desc name="construct.a.page2.apdc007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc007_desc
            #add-point:ON ACTION controlp INFIELD apdc007_desc name="construct.c.page2.apdc007_desc"
            #來源會計科目 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "
            #161114-00017#2 --s add
			   LET l_comp = NULL
			   SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			   LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glacent = gladent AND glad001= glac002 ",
                                   " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161114-00017#2 --s add            
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apdc007
            DISPLAY g_qryparam.return1 TO apdc007_desc
            NEXT FIELD apdc007_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc017
            #add-point:BEFORE FIELD apdc017 name="construct.b.page2.apdc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc017
            
            #add-point:AFTER FIELD apdc017 name="construct.a.page2.apdc017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc017
            #add-point:ON ACTION controlp INFIELD apdc017 name="construct.c.page2.apdc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc017_desc
            #add-point:BEFORE FIELD apdc017_desc name="construct.b.page2.apdc017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc017_desc
            
            #add-point:AFTER FIELD apdc017_desc name="construct.a.page2.apdc017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc017_desc
            #add-point:ON ACTION controlp INFIELD apdc017_desc name="construct.c.page2.apdc017_desc"
            #業務人員 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO apdc017
            DISPLAY g_qryparam.return1 TO apdc017_desc
            NEXT FIELD apdc017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc018
            #add-point:BEFORE FIELD apdc018 name="construct.b.page2.apdc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc018
            
            #add-point:AFTER FIELD apdc018 name="construct.a.page2.apdc018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc018
            #add-point:ON ACTION controlp INFIELD apdc018 name="construct.c.page2.apdc018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc018_desc
            #add-point:BEFORE FIELD apdc018_desc name="construct.b.page2.apdc018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc018_desc
            
            #add-point:AFTER FIELD apdc018_desc name="construct.a.page2.apdc018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc018_desc
            #add-point:ON ACTION controlp INFIELD apdc018_desc name="construct.c.page2.apdc018_desc"
            #業務部門 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apdc018
            DISPLAY g_qryparam.return1 TO apdc018_desc
            NEXT FIELD apdc018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc019
            #add-point:BEFORE FIELD apdc019 name="construct.b.page2.apdc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc019
            
            #add-point:AFTER FIELD apdc019 name="construct.a.page2.apdc019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc019
            #add-point:ON ACTION controlp INFIELD apdc019 name="construct.c.page2.apdc019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc019_desc
            #add-point:BEFORE FIELD apdc019_desc name="construct.b.page2.apdc019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc019_desc
            
            #add-point:AFTER FIELD apdc019_desc name="construct.a.page2.apdc019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc019_desc
            #add-point:ON ACTION controlp INFIELD apdc019_desc name="construct.c.page2.apdc019_desc"
            #責任中心 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apdc019
            DISPLAY g_qryparam.return1 TO apdc019_desc
            NEXT FIELD apdc019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc020
            #add-point:BEFORE FIELD apdc020 name="construct.b.page2.apdc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc020
            
            #add-point:AFTER FIELD apdc020 name="construct.a.page2.apdc020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc020
            #add-point:ON ACTION controlp INFIELD apdc020 name="construct.c.page2.apdc020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc020_desc
            #add-point:BEFORE FIELD apdc020_desc name="construct.b.page2.apdc020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc020_desc
            
            #add-point:AFTER FIELD apdc020_desc name="construct.a.page2.apdc020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc020_desc
            #add-point:ON ACTION controlp INFIELD apdc020_desc name="construct.c.page2.apdc020_desc"
            #產品類別 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO apdc020
            DISPLAY g_qryparam.return1 TO apdc020_desc
            NEXT FIELD apdc020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc022
            #add-point:BEFORE FIELD apdc022 name="construct.b.page2.apdc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc022
            
            #add-point:AFTER FIELD apdc022 name="construct.a.page2.apdc022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc022
            #add-point:ON ACTION controlp INFIELD apdc022 name="construct.c.page2.apdc022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc022_desc
            #add-point:BEFORE FIELD apdc022_desc name="construct.b.page2.apdc022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc022_desc
            
            #add-point:AFTER FIELD apdc022_desc name="construct.a.page2.apdc022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc022_desc
            #add-point:ON ACTION controlp INFIELD apdc022_desc name="construct.c.page2.apdc022_desc"
            #專案代號 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO apdc022
            DISPLAY g_qryparam.return1 TO apdc022_desc
            NEXT FIELD apdc022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc023
            #add-point:BEFORE FIELD apdc023 name="construct.b.page2.apdc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc023
            
            #add-point:AFTER FIELD apdc023 name="construct.a.page2.apdc023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc023
            #add-point:ON ACTION controlp INFIELD apdc023 name="construct.c.page2.apdc023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc023_desc
            #add-point:BEFORE FIELD apdc023_desc name="construct.b.page2.apdc023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc023_desc
            
            #add-point:AFTER FIELD apdc023_desc name="construct.a.page2.apdc023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc023_desc
            #add-point:ON ACTION controlp INFIELD apdc023_desc name="construct.c.page2.apdc023_desc"
            #WBS #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO apdc023
            DISPLAY g_qryparam.return1 TO apdc023_desc
            NEXT FIELD apdc023_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc024
            #add-point:BEFORE FIELD apdc024 name="construct.b.page2.apdc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc024
            
            #add-point:AFTER FIELD apdc024 name="construct.a.page2.apdc024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc024
            #add-point:ON ACTION controlp INFIELD apdc024 name="construct.c.page2.apdc024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc024_desc
            #add-point:BEFORE FIELD apdc024_desc name="construct.b.page2.apdc024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc024_desc
            
            #add-point:AFTER FIELD apdc024_desc name="construct.a.page2.apdc024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc024_desc
            #add-point:ON ACTION controlp INFIELD apdc024_desc name="construct.c.page2.apdc024_desc"
            #區域 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO apdc024
            DISPLAY g_qryparam.return1 TO apdc024_desc
            NEXT FIELD apdc024_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc025
            #add-point:BEFORE FIELD apdc025 name="construct.b.page2.apdc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc025
            
            #add-point:AFTER FIELD apdc025 name="construct.a.page2.apdc025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc025
            #add-point:ON ACTION controlp INFIELD apdc025 name="construct.c.page2.apdc025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc025_desc
            #add-point:BEFORE FIELD apdc025_desc name="construct.b.page2.apdc025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc025_desc
            
            #add-point:AFTER FIELD apdc025_desc name="construct.a.page2.apdc025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc025_desc
            #add-point:ON ACTION controlp INFIELD apdc025_desc name="construct.c.page2.apdc025_desc"
            #客群 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO apdc025
            DISPLAY g_qryparam.return1 TO apdc025_desc
            NEXT FIELD apdc025_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc027
            #add-point:BEFORE FIELD apdc027 name="construct.b.page2.apdc027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc027
            
            #add-point:AFTER FIELD apdc027 name="construct.a.page2.apdc027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc027
            #add-point:ON ACTION controlp INFIELD apdc027 name="construct.c.page2.apdc027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc027_desc
            #add-point:BEFORE FIELD apdc027_desc name="construct.b.page2.apdc027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc027_desc
            
            #add-point:AFTER FIELD apdc027_desc name="construct.a.page2.apdc027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc027_desc
            #add-point:ON ACTION controlp INFIELD apdc027_desc name="construct.c.page2.apdc027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc028
            #add-point:BEFORE FIELD apdc028 name="construct.b.page2.apdc028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc028
            
            #add-point:AFTER FIELD apdc028 name="construct.a.page2.apdc028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc028
            #add-point:ON ACTION controlp INFIELD apdc028 name="construct.c.page2.apdc028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc028_desc
            #add-point:BEFORE FIELD apdc028_desc name="construct.b.page2.apdc028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc028_desc
            
            #add-point:AFTER FIELD apdc028_desc name="construct.a.page2.apdc028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc028_desc
            #add-point:ON ACTION controlp INFIELD apdc028_desc name="construct.c.page2.apdc028_desc"
            #渠道 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO apdc028
            DISPLAY g_qryparam.return1 TO apdc028_desc
            NEXT FIELD apdc028_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc029
            #add-point:BEFORE FIELD apdc029 name="construct.b.page2.apdc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc029
            
            #add-point:AFTER FIELD apdc029 name="construct.a.page2.apdc029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc029
            #add-point:ON ACTION controlp INFIELD apdc029 name="construct.c.page2.apdc029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc029_desc
            #add-point:BEFORE FIELD apdc029_desc name="construct.b.page2.apdc029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc029_desc
            
            #add-point:AFTER FIELD apdc029_desc name="construct.a.page2.apdc029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdc029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc029_desc
            #add-point:ON ACTION controlp INFIELD apdc029_desc name="construct.c.page2.apdc029_desc"
            #品牌 #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO apdc029
            DISPLAY g_qryparam.return1 TO apdc029_desc
            NEXT FIELD apdc029_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdccomp
            #add-point:BEFORE FIELD apdccomp name="construct.b.page2.apdccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdccomp
            
            #add-point:AFTER FIELD apdccomp name="construct.a.page2.apdccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdccomp
            #add-point:ON ACTION controlp INFIELD apdccomp name="construct.c.page2.apdccomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcsite
            #add-point:BEFORE FIELD apdcsite name="construct.b.page2.apdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcsite
            
            #add-point:AFTER FIELD apdcsite name="construct.a.page2.apdcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcsite
            #add-point:ON ACTION controlp INFIELD apdcsite name="construct.c.page2.apdcsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47  add  
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
                  WHEN la_wc[li_idx].tableid = "apdc_t" 
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
   #161104-00046#5 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#5 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt430_filter()
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
               DISPLAY aapt430_filter_parser('apdadocno') TO s_browse[1].b_apdadocno
            DISPLAY aapt430_filter_parser('apdald') TO s_browse[1].b_apdald
      
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
 
      CALL aapt430_filter_show('apdadocno')
   CALL aapt430_filter_show('apdald')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt430_filter_parser(ps_field)
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
 
{<section id="aapt430.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt430_filter_show(ps_field)
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
   LET ls_condition = aapt430_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt430_query()
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
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt430_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt430_browser_fill("")
      CALL aapt430_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt430_filter_show('apdadocno')
   CALL aapt430_filter_show('apdald')
   CALL aapt430_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt430_fetch("F") 
      #顯示單身筆數
      CALL aapt430_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt430_fetch(p_flag)
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
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt430_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt430_set_act_visible()   
   CALL aapt430_set_act_no_visible()
   
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
   CALL aapt430_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt430_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apce_d.clear()   
   CALL g_apce2_d.clear()  
 
 
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
            LET g_apda_m.apda123 = "0"
      LET g_apda_m.apda133 = "0"
      LET g_apda_m.apda020 = "1"
      LET g_apda_m.apda113 = "0"
      LET g_apda_m.l_sum_apdc113213 = "0"
      LET g_apda_m.l_sum_apceapdc = "0"
      LET g_apda_m.l_sumcost = "0"
      LET g_apda_m.l_sumdiscount = "0"
      LET g_apda_m.l_sumprepay = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apda_m.apda001 = '43'
      LET g_apda_m.apda003 = g_user        #帳務人員
      LET g_apda_m.apdadocdt = g_today     #帳款日期
      CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
      
      #新版取帳務中心 Reanna 14/11/25--------------------------------------------------------------
      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdacomp
      CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
      CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str  #161229-00047#47 add 
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47 add 
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161114-00017#2 add 控制組   #161229-00047#47 mark
      #設定帳別相關預設值
      IF NOT cl_null(g_apda_m.apdald) THEN
         CALL s_desc_get_ld_desc(g_apda_m.apdald)  RETURNING g_apda_m.apdald_desc
         CALL aapt430_set_ld_info(g_apda_m.apdald)
      END IF
      DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdacomp
      #新版取帳務中心 Reanna 14/11/25 END----------------------------------------------------------

      LET g_apda_m.apda019 = '1'
      LET g_apda_m.apda020 = '1'
      LET g_apda_m.apda021 = '1'
     
      LET g_apda_m.apda018_desc  =  s_desc_get_acc_desc('3113',g_apda_m.apda018)
      DISPLAY BY NAME g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc,
                      g_apda_m.apda018_desc
      
      LET g_apda_m_t.* = g_apda_m.*
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
 
 
 
    
      CALL aapt430_input("a")
      
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
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt430_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apce_d.clear()
      #CALL g_apce2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt430_set_act_visible()   
   CALL aapt430_set_act_no_visible()
   
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
   CALL aapt430_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt430_cl
   
   CALL aapt430_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt430_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apdald,g_apda_m.apdald_desc,g_apda_m.apdadocno, 
       g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp, 
       g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda003_desc, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda113,g_apda_m.l_sum_apdc113213,g_apda_m.l_sum_apceapdc, 
       g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstid_desc,g_apda_m.apdapstdt,g_apda_m.l_sumcost,g_apda_m.l_sumdiscount, 
       g_apda_m.l_sumprepay
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt430_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt430_modify()
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
   
   OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt430_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
   #檢查是否允許此動作
   IF NOT aapt430_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt430_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aapt430_show()
   #add-point:modify段show之後 name="modify.after_show"
   
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
      LET g_apda_m_o.* = g_apda_m.*  #舊值備份
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt430_input("u")
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
            CALL aapt430_show()
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
         
         UPDATE apdc_t
            SET apdcld = g_apda_m.apdald
               ,apdcdocno = g_apda_m.apdadocno
 
          WHERE apdcent = g_enterprise AND
                apdcld = g_apdald_t
            AND apdcdocno = g_apdadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apdc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
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
   CALL aapt430_set_act_visible()   
   CALL aapt430_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到對應位置
   CALL aapt430_browser_fill("")
 
   CLOSE aapt430_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt430_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt430.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt430_input(p_cmd)
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
   DEFINE l_date_s_fin_3007      LIKE type_t.dat        #成本關帳日
   DEFINE l_date_s_fin_6012      LIKE type_t.dat        #應付關帳日
   DEFINE l_oocq015              LIKE type_t.chr1       #請款類沖銷理由碼否
   DEFINE l_where                STRING                 #組好where條件送入hardcode
   DEFINE l_auto_ins1            LIKE type_t.chr1       #來源單身自動產生
   DEFINE l_auto_ins2            LIKE type_t.chr1       #目的單身自動產生
   DEFINE l_origin_str           STRING
   DEFINE l_glaa001              LIKE glaa_t.glaa001    #幣別
   DEFINE l_glaa024              LIKE glaa_t.glaa024
   DEFINE l_glae009              LIKE glae_t.glae009    #自由核算項使用
   DEFINE l_str                  STRING
   DEFINE l_apce119_sum          LIKE apce_t.apce119    #統計已分攤金額
   DEFINE l_apce119_sum2         LIKE apce_t.apce119    #統計已分攤金額(自己這張單據的)
   DEFINE l_apce                 type_g_apce_d
   
#ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   #160816-00022#1--s
   DEFINE l_apcc108              LIKE apcc_t.apcc108
   DEFINE l_apcc118              LIKE apcc_t.apcc118
   DEFINE l_apcc128              LIKE apcc_t.apcc128
   DEFINE l_apcc138              LIKE apcc_t.apcc138
   DEFINE l_type                 LIKE type_t.chr1
   DEFINE l_apcb113              LIKE apcb_t.apcb113
   #160816-00022#1--e   
   DEFINE l_comp_wc              STRING  #161014-00053#3 add
   DEFINE l_apdc004_comp         LIKE glaa_t.glaacomp  #161114-00017#2
   #160628-00001#1 add ------
   DEFINE l_year                 LIKE type_t.num5
   DEFINE l_month                LIKE type_t.num5
   #160628-00001#1 add end---
   DEFINE l_flag                 LIKE type_t.num5      #161104-00046#5
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
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apdald,g_apda_m.apdald_desc,g_apda_m.apdadocno, 
       g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp, 
       g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda003_desc, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda113,g_apda_m.l_sum_apdc113213,g_apda_m.l_sum_apceapdc, 
       g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstid_desc,g_apda_m.apdapstdt,g_apda_m.l_sumcost,g_apda_m.l_sumdiscount, 
       g_apda_m.l_sumprepay
   
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
   LET g_forupd_sql = "SELECT apceseq,apce001,apce002,apceorga,apce003,apce004,apce005,apce038,apce047, 
       apce048,apce119,apce129,apce139,apce010,apce015,apce016,apce017,apce018,apce019,apce020,apce022, 
       apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056, 
       apce057,apce058,apce059,apce060,apcecomp,apcelegl,apcesite,apce027,apce028,apce031,apce032,apce100, 
       apce101,apce109,apce120,apce121,apce130,apce131,apce104,apce114,apce124,apce134 FROM apce_t WHERE  
       apceent=? AND apceld=? AND apcedocno=? AND apceseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt430_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apdcseq,apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,apdc009,apdc111, 
       apdc113,apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,apdc015,apdc007, 
       apdc017,apdc018,apdc019,apdc020,apdc022,apdc023,apdc024,apdc025,apdc027,apdc028,apdc029,apdc031, 
       apdc032,apdc033,apdc034,apdc035,apdc036,apdc037,apdc038,apdc039,apdc040,apdccomp,apdcsite FROM  
       apdc_t WHERE apdcent=? AND apdcld=? AND apdcdocno=? AND apdcseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt430_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt430_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL cl_set_comp_entry("apdc004",TRUE)
   CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',TRUE)
   IF g_apda_m.apda019 = '1' THEN
      #依入庫單據分攤，不開放選產品
      CALL cl_set_comp_entry("apdc004",FALSE)
   ELSE
      #依產品分攤，以下欄位隱藏
      #來源歸屬組織apdcorga/交易單號apdc002/交易項次apdc003/目的帳款單號apdc005/帳款項次apdc006
      CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',FALSE)
   END IF
   #end add-point
   CALL aapt430_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda001, 
       g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020, 
       g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda018,g_apda_m.apda113,g_apda_m.l_sum_apdc113213, 
       g_apda_m.l_sum_apceapdc
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #WHILE TRUE   
   #   LET l_auto_ins1 = 'N'
   #   LET l_auto_ins2 = 'N'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt430.input.head" >}
      #單頭段
      INPUT BY NAME g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda001, 
          g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020, 
          g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda018,g_apda_m.apda113,g_apda_m.l_sum_apdc113213, 
          g_apda_m.l_sum_apceapdc 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt430_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt430_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt430_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aapt430_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            LET g_apda_m.apdasite_desc = ' '
            DISPLAY BY NAME g_apda_m.apdasite_desc
            IF NOT cl_null(g_apda_m.apdasite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdasite != g_apda_m_t.apdasite OR g_apda_m_t.apdasite IS NULL )) THEN  #160822-00008#3  mark
               IF g_apda_m.apdasite != g_apda_m_o.apdasite OR cl_null(g_apda_m_o.apdasite ) THEN                                     #160822-00008#3
                  #IF g_apda_m_o.apdasite != g_apda_m.apdasite AND NOT cl_null(g_apda_m.apdald) THEN #161014-00053#3  mark
                  IF g_apda_m_o.apdasite != g_apda_m.apdasite AND NOT cl_null(g_apda_m_o.apdald) THEN #161014-00053#3 add
                     #先檢查預帶的帳務中心or新的帳務中心跟預帶的帳套是否OK
                     #不OK在取最新的帳務中心取出主帳套來check
                     CALL s_fin_account_center_sons_query('3',g_apda_m.apdasite,g_apda_m.apdadocdt,'1')
                     CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
                     CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N',g_wc_apdald,g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        CALL s_fin_orga_get_comp_ld(g_apda_m.apdasite) RETURNING g_sub_success,g_errno,g_apda_m.apdacomp,g_apda_m.apdald
                        CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N',g_wc_apdald,g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno
                        CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str  #161229-00047#47 add 
                        CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47 add 
                        #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161114-00017#2 add 控制組  #161229-00047#47 mark
                     END IF
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apda_m.apdasite = g_apda_m_t.apdasite   #160822-00008#3  mark
                        #LET g_apda_m.apdald   = g_apda_m_t.apdald     #160822-00008#3  mark
                        LET g_apda_m.apdasite = g_apda_m_o.apdasite    #160822-00008#3
                        LET g_apda_m.apdald   = g_apda_m_o.apdald      #160822-00008#3
                        CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
                        DISPLAY BY NAME g_apda_m.apdasite_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_desc_get_ld_desc(g_apda_m.apdald) RETURNING g_apda_m.apdald_desc
                     CALL aapt430_set_ld_info(g_apda_m.apdald)
                     DISPLAY BY NAME g_apda_m.apdald_desc
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N',g_wc_apdald,g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdasite = g_apda_m_t.apdasite   #160822-00008#3  mark
                     LET g_apda_m.apdasite = g_apda_m_o.apdasite    #160822-00008#3
                     LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
                     DISPLAY BY NAME g_apda_m.apdasite_desc,g_apda_m.apdasite
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt430_set_ld_info(g_apda_m.apdald)
                  LET g_apda_m_t.apdasite = g_apda_m.apdasite
               END IF
            END IF
            LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
            DISPLAY BY NAME g_apda_m.apdasite_desc
            LET g_apda_m_o.* = g_apda_m.*    #160822-00008#3
            #161014-00053#3 --s add
            CALL s_fin_account_center_sons_query('3',g_apda_m.apdasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            #161014-00053#3 --e add
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
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            LET g_apda_m.apdald_desc = ' '
            DISPLAY BY NAME g_apda_m.apdald_desc
            IF NOT cl_null(g_apda_m.apdald) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdald != g_apda_m_t.apdald OR g_apda_m_t.apdald IS NULL )) THEN  #160822-00008#3  mark
               IF g_apda_m.apdald != g_apda_m_o.apdald OR cl_null(g_apda_m_o.apdald) THEN                                      #160822-00008#3
                  #CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N',g_wc_apdald,g_apda_m.apdadocdt)  #160812-00027#1 mark
                  CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','Y',g_wc_apdald,g_apda_m.apdadocdt)   #160812-00027#1 add
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdald = g_apda_m_t.apdald      #160822-00008#3  mark
                     #LET g_apda_m.apdacomp = g_apda_m_t.apdacomp  #160822-00008#3  mark
                     LET g_apda_m.apdald = g_apda_m_o.apdald       #160822-00008#3
                     LET g_apda_m.apdacomp = g_apda_m_o.apdacomp   #160822-00008#3
                     LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
                     DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdacomp,g_apda_m.apdald_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #取得帳別帶出資訊
                  CALL aapt430_set_ld_info(g_apda_m.apdald)
                  
                  #日期因為帳別改變 而不符合條件的話就給空
                  CALL aapt430_apdadocdt_chk(g_apda_m.apdacomp,g_apda_m.apdadocdt)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_apda_m.apdadocdt = ''
                     DISPLAY BY NAME g_apda_m.apdadocdt
                  END IF
               END IF
            ELSE
               LET g_apda_m.apdacomp = ''
               LET g_apda_m.apdald_desc = ''
            END IF
            LET g_apda_m.apdald_desc = s_desc_get_ld_desc(g_apda_m.apdald)
            DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdacomp,g_apda_m.apdald_desc
            LET g_apda_m_o.* = g_apda_m.*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            #檢查是否有重複的單據編號(企業代碼/帳別/單號)
            IF NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_apda_m_t.apdadocno) OR g_apda_m.apdadocno != g_apda_m_t.apdadocno)) THEN 
                  #檢查單別是否存在單別檔/單別是有效
                  LET g_errno = NULL
                  IF NOT s_aooi200_fin_chk_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,g_prog) THEN
                     LET g_apda_m.apdadocno = g_apda_m_t.apdadocno
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#5 --s add
                  CALL s_control_chk_doc('1',g_apda_m.apdadocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_apda_m.apdadocno = g_apda_m_t.apdadocno 
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_apda_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_apda_m.apdasite,'2',g_ap_slip,'','',g_apda_m.apdald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_apda_m.* FROM s_aooi200def1
                  #161104-00046#5 --e add
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocno
            #add-point:ON CHANGE apdadocno name="input.g.apdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="input.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="input.a.apdadocdt"
            IF NOT cl_null(g_apda_m.apdadocdt) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdadocdt != g_apda_m_t.apdadocdt OR g_apda_m_t.apdadocdt IS NULL )) THEN
                  #日期檢查
                  CALL aapt430_apdadocdt_chk(g_apda_m.apdacomp,g_apda_m.apdadocdt)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     #小於應付關帳日
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_apda_m.apdadocdt = g_apda_m_t.apdadocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocdt
            #add-point:ON CHANGE apdadocdt name="input.g.apdadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda001
            #add-point:BEFORE FIELD apda001 name="input.b.apda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda001
            
            #add-point:AFTER FIELD apda001 name="input.a.apda001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda001
            #add-point:ON CHANGE apda001 name="input.g.apda001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda123
            #add-point:BEFORE FIELD apda123 name="input.b.apda123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda123
            
            #add-point:AFTER FIELD apda123 name="input.a.apda123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda123
            #add-point:ON CHANGE apda123 name="input.g.apda123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda133
            #add-point:BEFORE FIELD apda133 name="input.b.apda133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda133
            
            #add-point:AFTER FIELD apda133 name="input.a.apda133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda133
            #add-point:ON CHANGE apda133 name="input.g.apda133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacomp
            #add-point:BEFORE FIELD apdacomp name="input.b.apdacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacomp
            
            #add-point:AFTER FIELD apdacomp name="input.a.apdacomp"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdacomp
            #add-point:ON CHANGE apdacomp name="input.g.apdacomp"
            
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
         BEFORE FIELD apda019
            #add-point:BEFORE FIELD apda019 name="input.b.apda019"
            CALL aapt430_set_entry(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda019
            
            #add-point:AFTER FIELD apda019 name="input.a.apda019"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda019
            #add-point:ON CHANGE apda019 name="input.g.apda019"
            CALL cl_set_comp_entry("apdc004",TRUE)
            CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',TRUE)
            IF g_apda_m.apda019 = '1' THEN
               #依入庫單據分攤，不開放選產品
               CALL cl_set_comp_entry("apdc004",FALSE)
            ELSE
               #依產品分攤，以下欄位隱藏
               #來源歸屬組織apdcorga/交易單號apdc002/交易項次apdc003/目的帳款單號apdc005/帳款項次apdc006
               CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda020
            #add-point:BEFORE FIELD apda020 name="input.b.apda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda020
            
            #add-point:AFTER FIELD apda020 name="input.a.apda020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda020
            #add-point:ON CHANGE apda020 name="input.g.apda020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda021
            #add-point:BEFORE FIELD apda021 name="input.b.apda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda021
            
            #add-point:AFTER FIELD apda021 name="input.a.apda021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda021
            #add-point:ON CHANGE apda021 name="input.g.apda021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="input.a.apda003"
            LET g_apda_m.apda003_desc = ' '
            IF NOT cl_null(g_apda_m.apda003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda003 != g_apda_m_t.apda003 OR g_apda_m_t.apda003 IS NULL )) THEN
                  LET g_errno = ''
                  CALL s_employee_chk(g_apda_m.apda003) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apda_m.apda003 = g_apda_m_t.apda003
                     CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
                     DISPLAY BY NAME g_apda_m.apda003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
            DISPLAY BY NAME g_apda_m.apda003_desc
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
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="input.a.apda018"
            LET g_apda_m.apda018_desc = ' '
            DISPLAY BY NAME g_apda_m.apda018_desc
            IF NOT cl_null(g_apda_m.apda018) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda018 != g_apda_m_t.apda018 OR g_apda_m_t.apda018 IS NULL )) THEN
                  CALL s_azzi650_chk_exist('3113',g_apda_m.apda018)RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apda_m.apda018 = g_apda_m_t.apda018 
                     LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
                     DISPLAY BY NAME g_apda_m.apda018_desc,g_apda_m.apda018
                     NEXT FIELD CURRENT
                  END IF
                  
                #160816-00021#1   2016/08/16  By 07900 --mark-- 
                  #是否為請款沖銷應用的理由碼
#                  LET l_oocq015 = ''
#                  SELECT oocq015 INTO l_oocq015 FROM oocq_t
#                   WHERE oocqent = g_enterprise
#                     AND oocq001 = '3113'
#                     AND oocq002 = g_apda_m.apda018
#                  IF NOT cl_null(l_oocq015) AND l_oocq015 = 'Y' THEN
#                  ELSE
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'aap-00112'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_apda_m.apda018 = g_apda_m_t.apda018 
#                     LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
#                     DISPLAY BY NAME g_apda_m.apda018_desc,g_apda_m.apda018
#                     NEXT FIELD CURRENT
#                  END IF
               #160816-00021#1   2016/08/16  By 07900 --mark--
               END IF
            END IF
            LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
            DISPLAY BY NAME g_apda_m.apda018_desc
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
         BEFORE FIELD apda113
            #add-point:BEFORE FIELD apda113 name="input.b.apda113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda113
            
            #add-point:AFTER FIELD apda113 name="input.a.apda113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda113
            #add-point:ON CHANGE apda113 name="input.g.apda113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apdc113213
            #add-point:BEFORE FIELD l_sum_apdc113213 name="input.b.l_sum_apdc113213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apdc113213
            
            #add-point:AFTER FIELD l_sum_apdc113213 name="input.a.l_sum_apdc113213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_apdc113213
            #add-point:ON CHANGE l_sum_apdc113213 name="input.g.l_sum_apdc113213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apceapdc
            #add-point:BEFORE FIELD l_sum_apceapdc name="input.b.l_sum_apceapdc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apceapdc
            
            #add-point:AFTER FIELD l_sum_apceapdc name="input.a.l_sum_apceapdc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_apceapdc
            #add-point:ON CHANGE l_sum_apceapdc name="input.g.l_sum_apceapdc"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdasite
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_46()   #161006-00005#5   add
            LET g_apda_m.apdasite = g_qryparam.return1
            LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite)
            DISPLAY BY NAME g_apda_m.apdasite_desc
            NEXT FIELD apdasite
            #END add-point
 
 
         #Ctrlp:input.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            #161014-00053#3 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapt430_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161014-00053#3 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            #161014-00053#3 --s mark
            #CALL s_fin_account_center_sons_query('3',g_apda_m.apdasite,g_apda_m.apdadocdt,'1')
            #CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
            #CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
            #161014-00053#3 --e mark
            #LET g_qryparam.where = " glaald IN ",g_wc_apdald                                     #160812-00027#1 mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apdald #160812-00027#1 add #161014-00053#3 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161014-00053#3 add
            CALL q_authorised_ld()
            LET g_apda_m.apdald = g_qryparam.return1
            CALL s_fin_ld_carry(g_apda_m.apdald,g_user)RETURNING g_sub_success,g_apda_m.apdald,g_apda_m.apdacomp,g_errno
            CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str  #161229-00047#47 add 
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47 add 
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161114-00017#2 add 控制組 #161229-00047#47 mark
            DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdacomp
            LET g_apda_m.apdald_desc = s_desc_get_department_desc(g_apda_m.apdacomp)
            DISPLAY BY NAME g_apda_m.apdald_desc
            NEXT FIELD apdald
            #END add-point
 
 
         #Ctrlp:input.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="input.c.apdadocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_apda_m.apdald
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdadocno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#5 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#5 --e add
            CALL q_ooba002_1()
            LET g_apda_m.apdadocno = g_qryparam.return1
             DISPLAY BY NAME g_apda_m.apdadocno
            NEXT FIELD apdadocno
            #END add-point
 
 
         #Ctrlp:input.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="input.c.apdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda001
            #add-point:ON ACTION controlp INFIELD apda001 name="input.c.apda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda123
            #add-point:ON ACTION controlp INFIELD apda123 name="input.c.apda123"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda133
            #add-point:ON ACTION controlp INFIELD apda133 name="input.c.apda133"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacomp
            #add-point:ON ACTION controlp INFIELD apdacomp name="input.c.apdacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdastus
            #add-point:ON ACTION controlp INFIELD apdastus name="input.c.apdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda019
            #add-point:ON ACTION controlp INFIELD apda019 name="input.c.apda019"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda020
            #add-point:ON ACTION controlp INFIELD apda020 name="input.c.apda020"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda021
            #add-point:ON ACTION controlp INFIELD apda021 name="input.c.apda021"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="input.c.apda003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda003
            CALL q_ooag001()
            LET g_apda_m.apda003 = g_qryparam.return1
            DISPLAY g_apda_m.apda003 TO apda003
            LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)
            DISPLAY BY NAME g_apda_m.apda003_desc
            NEXT FIELD apda003
            #END add-point
 
 
         #Ctrlp:input.c.apda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="input.c.apda018"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda018
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()
            LET g_apda_m.apda018 = g_qryparam.return1
            LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
            DISPLAY g_apda_m.apda018 TO apda018
            DISPLAY BY NAME g_apda_m.apda018_desc
            NEXT FIELD apda018
            #END add-point
 
 
         #Ctrlp:input.c.apda113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda113
            #add-point:ON ACTION controlp INFIELD apda113 name="input.c.apda113"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_sum_apdc113213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apdc113213
            #add-point:ON ACTION controlp INFIELD l_sum_apdc113213 name="input.c.l_sum_apdc113213"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_sum_apceapdc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apceapdc
            #add-point:ON ACTION controlp INFIELD l_sum_apceapdc name="input.c.l_sum_apceapdc"
            
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
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apda_m.apdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD apdadocno
               END IF
               DISPLAY BY NAME g_apda_m.apdadocno
               #end add-point
               
               INSERT INTO apda_t (apdaent,apdasite,apdald,apdadocno,apdadocdt,apda014,apda001,apda123, 
                   apda133,apdacomp,apdastus,apda019,apda020,apda021,apda003,apda018,apda113,apdaownid, 
                   apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid, 
                   apdapstdt)
               VALUES (g_enterprise,g_apda_m.apdasite,g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt, 
                   g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp, 
                   g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
                   g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid, 
                   g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid, 
                   g_apda_m.apdacnfdt,g_apda_m.apdapstid,g_apda_m.apdapstdt) 
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
               #預設列印次數為0 #131212-00002#47
               UPDATE apda_t SET (apda016) = (0)
                WHERE apdaent = g_enterprise 
                  AND apdald = g_apda_m.apdald
                  AND apdadocno = g_apda_m.apdadocno
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt430_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt430_b_fill()
                  CALL aapt430_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt430_apda_t_mask_restore('restore_mask_o')
               
               UPDATE apda_t SET (apdasite,apdald,apdadocno,apdadocdt,apda014,apda001,apda123,apda133, 
                   apdacomp,apdastus,apda019,apda020,apda021,apda003,apda018,apda113,apdaownid,apdaowndp, 
                   apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid,apdapstdt) = (g_apda_m.apdasite, 
                   g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001, 
                   g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019, 
                   g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda018,g_apda_m.apda113, 
                   g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
                   g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdapstid, 
                   g_apda_m.apdapstdt)
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
               CALL aapt430_apda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apda_m_t)
               LET g_log2 = util.JSON.stringify(g_apda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apdald_t = g_apda_m.apdald
            LET g_apdadocno_t = g_apda_m.apdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt430.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apce_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apce_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt430_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apce_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
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
            OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt430_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt430_cl
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
               CALL aapt430_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt430_set_no_entry_b(l_cmd)
               IF NOT aapt430_lock_b("apce_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt430_bcl INTO g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce001,g_apce_d[l_ac].apce002, 
                      g_apce_d[l_ac].apceorga,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005, 
                      g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce047,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce119, 
                      g_apce_d[l_ac].apce129,g_apce_d[l_ac].apce139,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce015, 
                      g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce017,g_apce_d[l_ac].apce018,g_apce_d[l_ac].apce019, 
                      g_apce_d[l_ac].apce020,g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce023,g_apce_d[l_ac].apce035, 
                      g_apce_d[l_ac].apce036,g_apce_d[l_ac].apce044,g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce046, 
                      g_apce_d[l_ac].apce051,g_apce_d[l_ac].apce052,g_apce_d[l_ac].apce053,g_apce_d[l_ac].apce054, 
                      g_apce_d[l_ac].apce055,g_apce_d[l_ac].apce056,g_apce_d[l_ac].apce057,g_apce_d[l_ac].apce058, 
                      g_apce_d[l_ac].apce059,g_apce_d[l_ac].apce060,g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcelegl, 
                      g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce027,g_apce_d[l_ac].apce028,g_apce_d[l_ac].apce031, 
                      g_apce_d[l_ac].apce032,g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce109, 
                      g_apce_d[l_ac].apce120,g_apce_d[l_ac].apce121,g_apce_d[l_ac].apce130,g_apce_d[l_ac].apce131, 
                      g_apce_d[l_ac].apce104,g_apce_d[l_ac].apce114,g_apce_d[l_ac].apce124,g_apce_d[l_ac].apce134 
 
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
                  CALL aapt430_apce_t_mask()
                  LET g_apce_d_mask_n[l_ac].* =  g_apce_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt430_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #取得自由核算項資訊 #150330
            #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'ALL') RETURNING g_glad.*
            CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*
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
                  LET g_apce_d[l_ac].apce001 = "aapt430"
      LET g_apce_d[l_ac].apce002 = "43"
      LET g_apce_d[l_ac].apca001 = "19"
      LET g_apce_d[l_ac].l_sum_apcb113 = "0"
      LET g_apce_d[l_ac].l_sum_apcb123 = "0"
      LET g_apce_d[l_ac].l_sum_apcb133 = "0"
      LET g_apce_d[l_ac].apce027 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_apce_d_t.* = g_apce_d[l_ac].*     #新輸入資料
            LET g_apce_d_o.* = g_apce_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt430_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt430_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
 
               LET g_apce_d[li_reproduce_target].apceseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #apceseq
            LET g_apce_d[l_ac].apceseq = NULL
            SELECT MAX(apceseq) INTO g_apce_d[l_ac].apceseq FROM apce_t
             WHERE apceent = g_enterprise 
               AND apceld  = g_apda_m.apdald
               AND apcedocno = g_apda_m.apdadocno
            IF cl_null(g_apce_d[l_ac].apceseq) THEN LET g_apce_d[l_ac].apceseq = 0 END IF
            LET g_apce_d[l_ac].apceseq = g_apce_d[l_ac].apceseq + 1
            #單身來源組織預帶單頭帳務中心
            LET g_apce_d[l_ac].apceorga = g_apda_m.apdasite
            #160908-00045#1--add(s)
            CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
            DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
            #160908-00045#1--add(e)
            #單身帳務中心預帶單頭帳務中心
            LET g_apce_d[l_ac].apcesite = g_apda_m.apdasite
            #單身法人預帶單頭法人
            LET g_apce_d[l_ac].apcecomp = g_apda_m.apdacomp
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
               CALL aapt430_insert_b('apce_t',gs_keys,"'1'")
                           
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
               #CALL aapt430_b_fill()
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
               IF NOT aapt430_delete_b('apce_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt430_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt430_key_delete_b(gs_keys,'apce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt430_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt430_bcl
            
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
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_d[l_ac].apceseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apceseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apceseq name="input.a.page1.apceseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apda_m.apdald IS NOT NULL AND g_apda_m.apdadocno IS NOT NULL AND g_apce_d[g_detail_idx].apceseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t OR g_apda_m.apdadocno != g_apdadocno_t OR g_apce_d[g_detail_idx].apceseq != g_apce_d_t.apceseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apda_m.apdald ||"' AND "|| "apcedocno = '"||g_apda_m.apdadocno ||"' AND "|| "apceseq = '"||g_apce_d[g_detail_idx].apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceseq
            #add-point:BEFORE FIELD apceseq name="input.b.page1.apceseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceseq
            #add-point:ON CHANGE apceseq name="input.g.page1.apceseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce001
            #add-point:BEFORE FIELD apce001 name="input.b.page1.apce001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce001
            
            #add-point:AFTER FIELD apce001 name="input.a.page1.apce001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce001
            #add-point:ON CHANGE apce001 name="input.g.page1.apce001"
            
            #END add-point 
 
 
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
            INITIALIZE l_apce.* TO NULL
            LET l_apce.apca001 = g_apce_d[l_ac].apca001
            LET l_apce.apceorga = g_apce_d[l_ac].apceorga
            LET l_apce.apceseq = g_apce_d[l_ac].apceseq
            LET g_apce_d[l_ac].* = l_apce.*
            LET g_apce_d[l_ac].apce001 = "aapt430"  #150325
            LET g_apce_d[l_ac].apce002 = "43"       #150325
            LET g_apce_d[l_ac].apce027 = "N"        #150325
            #151207-00018#3
            IF g_apce_d[l_ac].apca001 = '05' THEN
               LET g_apce_d[l_ac].apce005 = 0
            ELSE
               LET g_apce_d[l_ac].apce005 = ''
            END IF
            DISPLAY BY NAME g_apce_d[l_ac].apce005
            #151207-00018#3
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceorga
            
            #add-point:AFTER FIELD apceorga name="input.a.page1.apceorga"
            #來源組織
            IF NOT cl_null(g_apce_d[l_ac].apceorga) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_d[l_ac].apceorga != g_apce_d_t.apceorga OR g_apce_d_t.apceorga IS NULL)) THEN
                  #160908-00045#1--add(s)
                  CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
                  DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
                  #160908-00045#1--add(e)
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce_d[l_ac].apceorga
                  #160318-00025#43  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#43  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_apce_d[l_ac].apceorga = g_apce_d_t.apceorga
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce_d[l_ac].apceorga,g_wc_apdasite) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce_d[l_ac].apceorga = g_apce_d_t.apceorga
                     #160908-00045#1--add(s)
                     CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
                     DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
                     #160908-00045#1--add(e)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
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
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_d[l_ac].apce003 != g_apce_d_t.apce003 OR g_apce_d_t.apce003 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apce_d[l_ac].apce003 != g_apce_d_o.apce003 OR cl_null(g_apce_d_o.apce003) THEN                                      #160822-00008#3
                 #IF NOT cl_null(g_apce_d[l_ac].apce004) AND NOT cl_null(g_apce_d[l_ac].apce005) THEN   #160816-00022#1 mark
                  IF NOT cl_null(g_apce_d[l_ac].apce004) THEN                                           #160816-00022#1 
                     CALL aapt430_source_doc_chk(l_ac,g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                        RETURNING g_sub_success,g_errno 
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = g_errno
                       #LET g_errparam.popup  = FALSE  #160816-00022#1 mark
                        LET g_errparam.popup  = TRUE   #160816-00022#1 
                        CALL cl_err()
                        #LET g_apce_d[l_ac].apce003 = g_apce_d_t.apce003  #160822-00008#3  mark
                        LET g_apce_d[l_ac].apce003 = g_apce_d_o.apce003   #160822-00008#3
                        DISPLAY BY NAME g_apce_d[l_ac].apce003
                        NEXT FIELD CURRENT
                     END IF
                     #帶出單據資料
                     IF g_apce_d[l_ac].apca001 <> '05' THEN #151207-00018#3
                        CALL aapt430_source_doc_carry(g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                     #151207-00018#3--(S)
                     ELSE
                        CALL aapt430_source_doc_carry_05(g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                     END IF
                     #151207-00018#3--(E)
                     #160816-00022#1--s
                     IF g_apce_d[l_ac].apce109 = 0 AND g_apce_d[l_ac].apce119 = 0 AND
                        g_apce_d[l_ac].apce129 = 0 AND g_apce_d[l_ac].apce139 = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00054'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apce_d[l_ac].apce003 = g_apce_d_t.apce003  #160822-00008#3  mark
                        LET g_apce_d[l_ac].apce003 = g_apce_d_o.apce003   #160822-00008#3
                        DISPLAY BY NAME g_apce_d[l_ac].apce003
                        #160908-00045#1--add(s)
                        CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
                        #160908-00045#1--add(e)
                        NEXT FIELD CURRENT                                                
                     END IF
                     #160816-00022#1--e
                     #取得單身其他資訊
                     CALL aapt430_apce_msg(l_ac)
                  END IF
               END IF
            END IF
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #160908-00045#1--add(s)
            CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
            DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
            #160908-00045#1--add(e)
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
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_d[l_ac].apce004 != g_apce_d_t.apce004 OR g_apce_d_t.apce004 IS NULL )) THEN   #160822-00008#3  mark
               IF g_apce_d[l_ac].apce004 != g_apce_d_o.apce004 OR cl_null(g_apce_d_o.apce004) THEN                                       #160822-00008#3
                 #IF NOT cl_null(g_apce_d[l_ac].apce003) AND NOT cl_null(g_apce_d[l_ac].apce005)THEN   #160816-00022#1 mark
                  IF NOT cl_null(g_apce_d[l_ac].apce003) THEN                                          #160816-00022#1 
                     CALL aapt430_source_doc_chk(l_ac,g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = g_errno
                       #LET g_errparam.popup  = FALSE  #160816-00022#1 mark
                        LET g_errparam.popup  = TRUE   #160816-00022#1 
                        CALL cl_err()
                        #LET g_apce_d[l_ac].apce004 = g_apce_d_t.apce004  #160822-00008#3  mark
                        LET g_apce_d[l_ac].apce004 = g_apce_d_o.apce004   #160822-00008#3
                        DISPLAY BY NAME g_apce_d[l_ac].apce004
                        NEXT FIELD CURRENT
                     END IF
                     #帶出單據資料
                     IF g_apce_d[l_ac].apca001 <> '05' THEN #151207-00018#3
                        CALL aapt430_source_doc_carry(g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                     #151207-00018#3--(S)
                     ELSE
                        CALL aapt430_source_doc_carry_05(g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                     END IF
                     #151207-00018#3--(E)
                     #160816-00022#1--s
                     IF g_apce_d[l_ac].apce109 = 0 AND g_apce_d[l_ac].apce119 = 0 AND
                        g_apce_d[l_ac].apce129 = 0 AND g_apce_d[l_ac].apce139 = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00054'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apce_d[l_ac].apce004 = g_apce_d_t.apce004  #160822-00008#3  mark
                        LET g_apce_d[l_ac].apce004 = g_apce_d_o.apce004   #160822-00008#3
                        DISPLAY BY NAME g_apce_d[l_ac].apce004
                        NEXT FIELD CURRENT                                                
                     END IF
                     #160816-00022#1--e                     
                     #取得單身其他資訊
                     CALL aapt430_apce_msg(l_ac)
                  END IF
               END IF
            END IF
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce004
            #add-point:ON CHANGE apce004 name="input.g.page1.apce004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce005
            #add-point:BEFORE FIELD apce005 name="input.b.page1.apce005"
            #151207-00018#3--(S)
            IF g_apce_d[l_ac].apca001 = '05' THEN
               LET g_apce_d[l_ac].apce005 = 0
               DISPLAY BY NAME g_apce_d[l_ac].apce005
               NEXT FIELD apce119
            END IF
            #151207-00018#3--(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce005
            
            #add-point:AFTER FIELD apce005 name="input.a.page1.apce005"
            IF NOT cl_null(g_apce_d[l_ac].apce005) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_d[l_ac].apce005 != g_apce_d_t.apce005 OR g_apce_d_t.apce005 IS NULL )) THEN   #160822-00008#3  mark
               IF g_apce_d[l_ac].apce005 != g_apce_d_o.apce005 OR cl_null(g_apce_d_o.apce005) THEN                                       #160822-00008#3
                  IF NOT cl_null(g_apce_d[l_ac].apce003) AND NOT cl_null(g_apce_d[l_ac].apce004)THEN
                     CALL aapt430_source_doc_chk(l_ac,g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = g_errno
                       #LET g_errparam.popup  = FALSE  #160816-00022#1 mark
                        LET g_errparam.popup  = TRUE   #160816-00022#1 
                        CALL cl_err()
                        #LET g_apce_d[l_ac].apce005 = g_apce_d_t.apce005    #160822-00008#3  mark
                        LET g_apce_d[l_ac].apce005 = g_apce_d_o.apce005     #160822-00008#3
                        DISPLAY BY NAME g_apce_d[l_ac].apce005
                        NEXT FIELD CURRENT
                     END IF
                     #帶出單據資料
                     CALL aapt430_source_doc_carry(g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005)
                     #取得單身其他資訊
                     CALL aapt430_apce_msg(l_ac)
                  END IF
               END IF
            END IF
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce005
            #add-point:ON CHANGE apce005 name="input.g.page1.apce005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca004
            
            #add-point:AFTER FIELD apca004 name="input.a.page1.apca004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca004
            #add-point:BEFORE FIELD apca004 name="input.b.page1.apca004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca004
            #add-point:ON CHANGE apca004 name="input.g.page1.apca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce038
            #add-point:BEFORE FIELD apce038 name="input.b.page1.apce038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce038
            
            #add-point:AFTER FIELD apce038 name="input.a.page1.apce038"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce038
            #add-point:ON CHANGE apce038 name="input.g.page1.apce038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce047
            #add-point:BEFORE FIELD apce047 name="input.b.page1.apce047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce047
            
            #add-point:AFTER FIELD apce047 name="input.a.page1.apce047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce047
            #add-point:ON CHANGE apce047 name="input.g.page1.apce047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce048
            #add-point:BEFORE FIELD apce048 name="input.b.page1.apce048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce048
            
            #add-point:AFTER FIELD apce048 name="input.a.page1.apce048"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce048
            #add-point:ON CHANGE apce048 name="input.g.page1.apce048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apcb113
            #add-point:BEFORE FIELD l_sum_apcb113 name="input.b.page1.l_sum_apcb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apcb113
            
            #add-point:AFTER FIELD l_sum_apcb113 name="input.a.page1.l_sum_apcb113"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_apcb113
            #add-point:ON CHANGE l_sum_apcb113 name="input.g.page1.l_sum_apcb113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce119
            #add-point:BEFORE FIELD apce119 name="input.b.page1.apce119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce119
            
            #add-point:AFTER FIELD apce119 name="input.a.page1.apce119"
            IF NOT cl_null(g_apce_d[l_ac].apce119) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_d[l_ac].apce119 != g_apce_d_t.apce119 OR g_apce_d_t.apce119 IS NULL)) THEN  #160822-00008#3  mark
               IF g_apce_d[l_ac].apce119 != g_apce_d_o.apce119 OR cl_null(g_apce_d_o.apce119 ) THEN                                    #160822-00008#3
                  IF NOT cl_null(g_apce_d[l_ac].l_sum_apcb113) THEN
                     IF cl_null(g_apce_d[l_ac].apce119) THEN LET g_apce_d[l_ac].apce119 = 0 END IF                    
                        #撈出該單據是否有其他分攤的單，若有統計已分攤了多少(不含自己)
                        SELECT SUM(apce119) INTO l_apce119_sum
                          FROM apce_t
                          LEFT JOIN apda_t ON apceent = apdaent AND apceld = apdald AND apcedocno = apdadocno
                         WHERE apceent = g_enterprise
                           AND apce003 = g_apce_d[l_ac].apce003
                           AND apce004 = g_apce_d[l_ac].apce004
                          #AND apce005 = g_apce_d[l_ac].apce005   #160816-00022#1 mark
                           AND apcedocno <> g_apda_m.apdadocno
                           AND apdald = g_apda_m.apdald
                           AND apdastus <> 'X'
                           AND apda001 = '43'
                        SELECT SUM(apce119) INTO l_apce119_sum2
                          FROM apce_t
                          LEFT JOIN apda_t ON apceent = apdaent AND apceld = apdald AND apcedocno = apdadocno
                         WHERE apceent = g_enterprise
                           AND apce003 = g_apce_d[l_ac].apce003
                           AND apce004 = g_apce_d[l_ac].apce004
                          #AND apce005 = g_apce_d[l_ac].apce005   #160816-00022#1 mark
                           AND apcedocno = g_apda_m.apdadocno
                           AND apceseq <> g_apce_d[l_ac].apceseq
                           AND apdald = g_apda_m.apdald
                           AND apdastus <> 'X'
                           AND apda001 = '43'
                        IF cl_null(l_apce119_sum) THEN LET l_apce119_sum = 0 END IF
                        IF cl_null(l_apce119_sum2) THEN LET l_apce119_sum2 = 0 END IF
                        #分攤金額不可大於帳款帳款
                        IF (g_apce_d[l_ac].l_sum_apcb113 - (l_apce119_sum + l_apce119_sum2)) < g_apce_d[l_ac].apce119 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'aap-00281'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_apce_d[l_ac].apce119 = g_apce_d_t.apce119  #160822-00008#3  mark
                           LET g_apce_d[l_ac].apce119 = g_apce_d_o.apce119   #160822-00008#3
                           NEXT FIELD CURRENT
                        ELSE
                           #160816-00022#1--s
                           #帳款性質為2*(待抵單),由於確認時會回寫已沖金額,因此需扣除已被沖銷/預沖金額
                           IF g_apce_d[l_ac].apca001 MATCHES '2*' THEN
                              #如果沖銷參數是3,則多帳期的項次與單身apcb項次是可以對應的,因此判斷可沖金額的時候,必須考量到項次
                              #如果沖銷參數是1/2,則項次是對應不上的,因此以整張單的角度看可沖金額
                              IF g_s_fin_2002 = '3' THEN
                                 LET l_type = '3'
                              ELSE
                                 LET l_type = '2'
                              END IF
                              CALL s_aapt420_apcc_used_num('41',g_apda_m.apdald,g_apda_m.apdald,g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,'',g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,l_type)   
                               RETURNING g_sub_success,g_errno,l_apcc108,l_apcc118,l_apcc128,l_apcc138   
                              LET l_apcb113 = g_apce_d[l_ac].l_sum_apcb113 - (l_apce119_sum + l_apce119_sum2)
                              #多帳期剩餘可沖金額與該項次可沖金額相比,取小者為超沖標準
                              IF (l_apcc118 < l_apcb113 AND l_apcc118 < g_apce_d[l_ac].apce119) OR
                                 (l_apcc118 > l_apcb113 AND l_apcb113 < g_apce_d[l_ac].apce119) THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = 'aap-00281'
                                 LET g_errparam.extend = ''
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 #LET g_apce_d[l_ac].apce119 = g_apce_d_t.apce119  #160822-00008#3  mark
                                 LET g_apce_d[l_ac].apce119 = g_apce_d_o.apce119   #160822-00008#3
                                 NEXT FIELD CURRENT                           
                              ELSE
                                 #重新計算原幣、本位幣二、本位幣三
                                 #160822-00008#3--add--s--
                                 LET g_apce_d[l_ac].apce109 = ''
                                 LET g_apce_d[l_ac].apce129 = ''
                                 LET g_apce_d[l_ac].apce139 = ''
                                 #160822-00008#3--add--e--
                                 CALL aapt430_cal_other_money(g_apda_m.apdald,g_apda_m.apdadocdt,g_apce_d[l_ac].apce100
                                                             ,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119
                                                             ,g_apce_d[l_ac].apce121,g_apce_d[l_ac].apce131)
                                      RETURNING g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce129,g_apce_d[l_ac].apce139
                              END IF
                           END IF
                           #160816-00022#1--e                           
                           #重新計算原幣、本位幣二、本位幣三
                           #160822-00008#3--add--s--
                           LET g_apce_d[l_ac].apce109 = ''
                           LET g_apce_d[l_ac].apce129 = ''
                           LET g_apce_d[l_ac].apce139 = ''
                           #160822-00008#3--add--e--
                           CALL aapt430_cal_other_money(g_apda_m.apdald,g_apda_m.apdadocdt,g_apce_d[l_ac].apce100
                                                       ,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce119
                                                       ,g_apce_d[l_ac].apce121,g_apce_d[l_ac].apce131)
                                RETURNING g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce129,g_apce_d[l_ac].apce139
                        END IF
                  END IF
               END IF
            END IF
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce119
            #add-point:ON CHANGE apce119 name="input.g.page1.apce119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apcb123
            #add-point:BEFORE FIELD l_sum_apcb123 name="input.b.page1.l_sum_apcb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apcb123
            
            #add-point:AFTER FIELD l_sum_apcb123 name="input.a.page1.l_sum_apcb123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_apcb123
            #add-point:ON CHANGE l_sum_apcb123 name="input.g.page1.l_sum_apcb123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce129
            #add-point:BEFORE FIELD apce129 name="input.b.page1.apce129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce129
            
            #add-point:AFTER FIELD apce129 name="input.a.page1.apce129"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce129
            #add-point:ON CHANGE apce129 name="input.g.page1.apce129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum_apcb133
            #add-point:BEFORE FIELD l_sum_apcb133 name="input.b.page1.l_sum_apcb133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum_apcb133
            
            #add-point:AFTER FIELD l_sum_apcb133 name="input.a.page1.l_sum_apcb133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum_apcb133
            #add-point:ON CHANGE l_sum_apcb133 name="input.g.page1.l_sum_apcb133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce139
            #add-point:BEFORE FIELD apce139 name="input.b.page1.apce139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce139
            
            #add-point:AFTER FIELD apce139 name="input.a.page1.apce139"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce139
            #add-point:ON CHANGE apce139 name="input.g.page1.apce139"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce010
            #add-point:BEFORE FIELD apce010 name="input.b.page1.apce010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce010
            
            #add-point:AFTER FIELD apce010 name="input.a.page1.apce010"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce010
            #add-point:ON CHANGE apce010 name="input.g.page1.apce010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016
            #add-point:BEFORE FIELD apce016 name="input.b.page1.apce016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016
            
            #add-point:AFTER FIELD apce016 name="input.a.page1.apce016"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce016
            #add-point:ON CHANGE apce016 name="input.g.page1.apce016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016_desc
            #add-point:BEFORE FIELD apce016_desc name="input.b.page1.apce016_desc"
            LET g_apce_d[l_ac].apce016_desc = g_apce_d[l_ac].apce016   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016_desc
            
            #add-point:AFTER FIELD apce016_desc name="input.a.page1.apce016_desc"
            IF NOT cl_null(g_apce_d[l_ac].apce016_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apda_m.apdald,g_apce_d[l_ac].apce016_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apda_m.apdald
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apce_d[l_ac].apce016_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apce_d[l_ac].apce016_desc
                LET g_qryparam.arg3 = g_apda_m.apdald
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_apce_d[l_ac].apce016      = g_qryparam.return1
                LET g_apce_d[l_ac].apce016_desc = g_qryparam.return1
                DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
              END IF
              IF NOT s_aglt310_lc_subject(g_apda_m.apdald,g_apce_d[l_ac].apce016_desc,'N') THEN
                      LET g_apce_d[l_ac].apce016      = g_apce_d_t.apce016
                     LET g_apce_d[l_ac].apce016_desc = g_apce_d_t.apce016_desc
                     DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
                     NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               IF ( g_apce_d[l_ac].apce016_desc != g_apce_d_t.apce016_desc OR g_apce_d_t.apce016_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce016 = g_apce_d[l_ac].apce016_desc
                  CALL s_aap_glac002_chk(g_apce_d[l_ac].apce016,g_apda_m.apdald) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce_d[l_ac].apce016      = g_apce_d_t.apce016
                     LET g_apce_d[l_ac].apce016_desc = g_apce_d_t.apce016_desc
                     DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得自由核算項資訊 #150330
               #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'ALL') RETURNING g_glad.*
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*
            ELSE
               INITIALIZE g_glad.* TO NULL
               LET g_apce_d[l_ac].apce016 = ''
            END IF
            LET g_apce_d[l_ac].apce016_desc = s_desc_show1(g_apce_d[l_ac].apce016,s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016))
            DISPLAY BY NAME g_apce_d[l_ac].apce016 ,g_apce_d[l_ac].apce016_desc
            LET g_apce_d_t.apce016_desc = g_apce_d[l_ac].apce016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce016_desc
            #add-point:ON CHANGE apce016_desc name="input.g.page1.apce016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017
            #add-point:BEFORE FIELD apce017 name="input.b.page1.apce017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017
            
            #add-point:AFTER FIELD apce017 name="input.a.page1.apce017"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce017
            #add-point:ON CHANGE apce017 name="input.g.page1.apce017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017_desc
            #add-point:BEFORE FIELD apce017_desc name="input.b.page1.apce017_desc"
            LET g_apce_d[l_ac].apce017_desc = g_apce_d[l_ac].apce017   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017_desc
            
            #add-point:AFTER FIELD apce017_desc name="input.a.page1.apce017_desc"
            #業務人員
            IF NOT cl_null(g_apce_d[l_ac].apce017_desc) THEN
               IF ( g_apce_d[l_ac].apce017_desc != g_apce_d_t.apce017_desc OR g_apce_d_t.apce017_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce017 = g_apce_d[l_ac].apce017_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_employee_chk(g_apce_d[l_ac].apce017_desc) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        LET g_apce_d[l_ac].apce017      = g_apce_d_t.apce017
                        LET g_apce_d[l_ac].apce017_desc = g_apce_d_t.apce017_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce017 ,g_apce_d[l_ac].apce017_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #160726-00020#14 ---(S)
               IF cl_null(g_apce_d[l_ac].apce018_desc) THEN
                  SELECT ooag003 INTO g_apce_d[l_ac].apce018 FROM ooag_t
                   WHERE ooagent = g_enterprise AND ooag001 = g_apce_d[l_ac].apce017_desc
               END IF
               #160726-00020#14 ---(E)
            ELSE
               LET g_apce_d[l_ac].apce017 = ''
            END IF
            LET g_apce_d[l_ac].apce017_desc = s_desc_show1(g_apce_d[l_ac].apce017,s_desc_get_person_desc(g_apce_d[l_ac].apce017))         
            DISPLAY BY NAME g_apce_d[l_ac].apce017 ,g_apce_d[l_ac].apce017_desc
            LET g_apce_d_t.apce017_desc = g_apce_d[l_ac].apce017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce017_desc
            #add-point:ON CHANGE apce017_desc name="input.g.page1.apce017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018
            #add-point:BEFORE FIELD apce018 name="input.b.page1.apce018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018
            
            #add-point:AFTER FIELD apce018 name="input.a.page1.apce018"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce018
            #add-point:ON CHANGE apce018 name="input.g.page1.apce018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018_desc
            #add-point:BEFORE FIELD apce018_desc name="input.b.page1.apce018_desc"
            LET g_apce_d[l_ac].apce018_desc = g_apce_d[l_ac].apce018   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018_desc
            
            #add-point:AFTER FIELD apce018_desc name="input.a.page1.apce018_desc"
            #部門
            IF NOT cl_null(g_apce_d[l_ac].apce018_desc) THEN
               IF ( g_apce_d[l_ac].apce018_desc != g_apce_d_t.apce018_desc OR g_apce_d_t.apce018_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce018 = g_apce_d[l_ac].apce018_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_department_chk(g_apce_d[l_ac].apce018_desc,g_apda_m.apdadocdt) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        LET g_apce_d[l_ac].apce018      = g_apce_d_t.apce018
                        LET g_apce_d[l_ac].apce018_desc = g_apce_d_t.apce018_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce018 ,g_apce_d[l_ac].apce018_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce018 = ''
            END IF
            LET g_apce_d[l_ac].apce018_desc = s_desc_show1(g_apce_d[l_ac].apce018,s_desc_get_department_desc(g_apce_d[l_ac].apce018))         
            DISPLAY BY NAME g_apce_d[l_ac].apce018 ,g_apce_d[l_ac].apce018_desc
            LET g_apce_d_t.apce018_desc = g_apce_d[l_ac].apce018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce018_desc
            #add-point:ON CHANGE apce018_desc name="input.g.page1.apce018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019
            #add-point:BEFORE FIELD apce019 name="input.b.page1.apce019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019
            
            #add-point:AFTER FIELD apce019 name="input.a.page1.apce019"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce019
            #add-point:ON CHANGE apce019 name="input.g.page1.apce019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019_desc
            #add-point:BEFORE FIELD apce019_desc name="input.b.page1.apce019_desc"
            LET g_apce_d[l_ac].apce019_desc = g_apce_d[l_ac].apce019   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019_desc
            
            #add-point:AFTER FIELD apce019_desc name="input.a.page1.apce019_desc"
            #責任中心
            IF NOT cl_null(g_apce_d[l_ac].apce019_desc) THEN
               IF ( g_apce_d[l_ac].apce019_desc != g_apce_d_t.apce019_desc OR g_apce_d_t.apce019_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce019 = g_apce_d[l_ac].apce019_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                    #CALL s_department_chk(g_apce_d[l_ac].apce019_desc,g_apda_m.apdadocdt) RETURNING g_sub_success #140806-00012#8 mark
                    CALL s_voucher_glaq019_chk(g_apce_d[l_ac].apce019_desc,g_apda_m.apdadocdt) #140806-00012#8
                    IF NOT g_sub_success THEN
                       LET g_apce_d[l_ac].apce019      = g_apce_d_t.apce019
                       LET g_apce_d[l_ac].apce019_desc = g_apce_d_t.apce019_desc
                       DISPLAY BY NAME g_apce_d[l_ac].apce019 ,g_apce_d[l_ac].apce019_desc
                       NEXT FIELD CURRENT
                    END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce019 = ''
            END IF
            LET g_apce_d[l_ac].apce019_desc = s_desc_show1(g_apce_d[l_ac].apce019,s_desc_get_department_desc(g_apce_d[l_ac].apce019))         
            DISPLAY BY NAME g_apce_d[l_ac].apce019 ,g_apce_d[l_ac].apce019_desc
            LET g_apce_d_t.apce019_desc = g_apce_d[l_ac].apce019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce019_desc
            #add-point:ON CHANGE apce019_desc name="input.g.page1.apce019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020
            #add-point:BEFORE FIELD apce020 name="input.b.page1.apce020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020
            
            #add-point:AFTER FIELD apce020 name="input.a.page1.apce020"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce020
            #add-point:ON CHANGE apce020 name="input.g.page1.apce020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020_desc
            #add-point:BEFORE FIELD apce020_desc name="input.b.page1.apce020_desc"
            LET g_apce_d[l_ac].apce020_desc = g_apce_d[l_ac].apce020   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020_desc
            
            #add-point:AFTER FIELD apce020_desc name="input.a.page1.apce020_desc"
            #產品類別
            IF NOT cl_null(g_apce_d[l_ac].apce020_desc) THEN
               IF ( g_apce_d[l_ac].apce020_desc != g_apce_d_t.apce020_desc OR g_apce_d_t.apce020_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce020 = g_apce_d[l_ac].apce020_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq024_chk(g_apce_d[l_ac].apce020)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'arti202'
                        LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                        LET g_errparam.exeprog = 'arti202'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apce_d[l_ac].apce020      = g_apce_d_t.apce020
                        LET g_apce_d[l_ac].apce020_desc = g_apce_d_t.apce020_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce020 ,g_apce_d[l_ac].apce020_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce_d[l_ac].apce020 = ''
            END IF
            LET g_apce_d[l_ac].apce020_desc = s_desc_show1(g_apce_d[l_ac].apce020,s_desc_get_rtaxl003_desc(g_apce_d[l_ac].apce020))      
            DISPLAY BY NAME g_apce_d[l_ac].apce020 ,g_apce_d[l_ac].apce020_desc
            LET g_apce_d_t.apce020_desc = g_apce_d[l_ac].apce020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce020_desc
            #add-point:ON CHANGE apce020_desc name="input.g.page1.apce020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022
            #add-point:BEFORE FIELD apce022 name="input.b.page1.apce022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022
            
            #add-point:AFTER FIELD apce022 name="input.a.page1.apce022"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce022
            #add-point:ON CHANGE apce022 name="input.g.page1.apce022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022_desc
            #add-point:BEFORE FIELD apce022_desc name="input.b.page1.apce022_desc"
            LET g_apce_d[l_ac].apce022_desc = g_apce_d[l_ac].apce022   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022_desc
            
            #add-point:AFTER FIELD apce022_desc name="input.a.page1.apce022_desc"
            #專案代號
            IF NOT cl_null(g_apce_d[l_ac].apce022_desc) THEN
               IF ( g_apce_d[l_ac].apce022_desc != g_apce_d_t.apce022_desc OR g_apce_d_t.apce022_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce022 = g_apce_d[l_ac].apce022_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_aap_project_chk(g_apce_d[l_ac].apce022) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'apjm200'
                        LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                        LET g_errparam.exeprog = 'apjm200'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_apce_d[l_ac].apce022      = g_apce_d_t.apce022
                        LET g_apce_d[l_ac].apce022_desc = g_apce_d_t.apce022_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce022 ,g_apce_d[l_ac].apce022_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce_d[l_ac].apce022 = ''
            END IF
            LET g_apce_d[l_ac].apce022_desc = s_desc_show1(g_apce_d[l_ac].apce022,s_desc_get_project_desc(g_apce_d[l_ac].apce022))      
            DISPLAY BY NAME g_apce_d[l_ac].apce022 ,g_apce_d[l_ac].apce022_desc 
            LET g_apce_d_t.apce022_desc = g_apce_d[l_ac].apce022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce022_desc
            #add-point:ON CHANGE apce022_desc name="input.g.page1.apce022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023
            #add-point:BEFORE FIELD apce023 name="input.b.page1.apce023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023
            
            #add-point:AFTER FIELD apce023 name="input.a.page1.apce023"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce023
            #add-point:ON CHANGE apce023 name="input.g.page1.apce023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023_desc
            #add-point:BEFORE FIELD apce023_desc name="input.b.page1.apce023_desc"
            LET g_apce_d[l_ac].apce023_desc = g_apce_d[l_ac].apce023 #140806-00012#8
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023_desc
            
            #add-point:AFTER FIELD apce023_desc name="input.a.page1.apce023_desc"
            #140806-00012#8 add---
            #WBS
            IF NOT cl_null(g_apce_d[l_ac].apce023_desc) THEN
               IF ( g_apce_d[l_ac].apce023_desc != g_apce_d_t.apce023_desc OR g_apce_d_t.apce023_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce023 = g_apce_d[l_ac].apce023_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq028_chk(g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce023)
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_apce_d[l_ac].apce023      = g_apce_d_t.apce023
                        LET g_apce_d[l_ac].apce023_desc = g_apce_d_t.apce023_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce023 ,g_apce_d[l_ac].apce023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce_d[l_ac].apce023 = ''
            END IF
            LET g_apce_d[l_ac].apce023_desc = s_desc_show1(g_apce_d[l_ac].apce023,s_desc_get_pjbbl004_desc(g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce023))
            DISPLAY BY NAME g_apce_d[l_ac].apce023 ,g_apce_d[l_ac].apce023_desc 
            LET g_apce_d_t.apce023_desc = g_apce_d[l_ac].apce023_desc
            #140806-00012#8 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce023_desc
            #add-point:ON CHANGE apce023_desc name="input.g.page1.apce023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035
            #add-point:BEFORE FIELD apce035 name="input.b.page1.apce035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035
            
            #add-point:AFTER FIELD apce035 name="input.a.page1.apce035"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce035
            #add-point:ON CHANGE apce035 name="input.g.page1.apce035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce035_desc
            #add-point:BEFORE FIELD apce035_desc name="input.b.page1.apce035_desc"
            LET g_apce_d[l_ac].apce035_desc = g_apce_d[l_ac].apce035   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce035_desc
            
            #add-point:AFTER FIELD apce035_desc name="input.a.page1.apce035_desc"
            #區域
            IF NOT cl_null(g_apce_d[l_ac].apce035_desc) THEN
               IF ( g_apce_d[l_ac].apce035_desc != g_apce_d_t.apce035_desc OR g_apce_d_t.apce035_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce035 = g_apce_d[l_ac].apce035_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('287',g_apce_d[l_ac].apce035) THEN
                        LET g_apce_d[l_ac].apce035      = g_apce_d_t.apce035
                        LET g_apce_d[l_ac].apce035_desc = g_apce_d_t.apce035_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce035 ,g_apce_d[l_ac].apce035_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce_d[l_ac].apce035 = ''
            END IF
            LET g_apce_d[l_ac].apce035_desc = s_desc_show1(g_apce_d[l_ac].apce035,s_desc_get_acc_desc('287',g_apce_d[l_ac].apce035))      
            DISPLAY BY NAME g_apce_d[l_ac].apce035 ,g_apce_d[l_ac].apce035_desc
            LET g_apce_d_t.apce035_desc = g_apce_d[l_ac].apce035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce035_desc
            #add-point:ON CHANGE apce035_desc name="input.g.page1.apce035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036
            #add-point:BEFORE FIELD apce036 name="input.b.page1.apce036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036
            
            #add-point:AFTER FIELD apce036 name="input.a.page1.apce036"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce036
            #add-point:ON CHANGE apce036 name="input.g.page1.apce036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce036_desc
            #add-point:BEFORE FIELD apce036_desc name="input.b.page1.apce036_desc"
            LET g_apce_d[l_ac].apce036_desc = g_apce_d[l_ac].apce036   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce036_desc
            
            #add-point:AFTER FIELD apce036_desc name="input.a.page1.apce036_desc"
            #客群
            IF NOT cl_null(g_apce_d[l_ac].apce036_desc) THEN
               IF ( g_apce_d[l_ac].apce036_desc != g_apce_d_t.apce036_desc OR g_apce_d_t.apce036_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce036 = g_apce_d[l_ac].apce036_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('281',g_apce_d[l_ac].apce036) THEN
                        LET g_apce_d[l_ac].apce036      = g_apce_d_t.apce036
                        LET g_apce_d[l_ac].apce036_desc = g_apce_d_t.apce036_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce036 ,g_apce_d[l_ac].apce036_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce036 = ''
            END IF
            LET g_apce_d[l_ac].apce036_desc = s_desc_show1(g_apce_d[l_ac].apce036,s_desc_get_acc_desc('281',g_apce_d[l_ac].apce036))      
            DISPLAY BY NAME g_apce_d[l_ac].apce036 ,g_apce_d[l_ac].apce036_desc
            LET g_apce_d_t.apce036_desc = g_apce_d[l_ac].apce036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce036_desc
            #add-point:ON CHANGE apce036_desc name="input.g.page1.apce036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044
            #add-point:BEFORE FIELD apce044 name="input.b.page1.apce044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044
            
            #add-point:AFTER FIELD apce044 name="input.a.page1.apce044"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce044
            #add-point:ON CHANGE apce044 name="input.g.page1.apce044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce044_desc
            #add-point:BEFORE FIELD apce044_desc name="input.b.page1.apce044_desc"
            LET g_apce_d[l_ac].apce044_desc = g_apce_d[l_ac].apce044   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce044_desc
            
            #add-point:AFTER FIELD apce044_desc name="input.a.page1.apce044_desc"
            #經營方式
            IF NOT cl_null(g_apce_d[l_ac].apce044_desc) THEN
               IF ( g_apce_d[l_ac].apce044_desc != g_apce_d_t.apce044_desc OR g_apce_d_t.apce044_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce044 = g_apce_d[l_ac].apce044_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq051_chk(g_apce_d[l_ac].apce044) 
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_apce_d[l_ac].apce044      = g_apce_d_t.apce044
                        LET g_apce_d[l_ac].apce044_desc = g_apce_d_t.apce044_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce044 ,g_apce_d[l_ac].apce044_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce044 = ''
            END IF
            DISPLAY BY NAME g_apce_d[l_ac].apce044 ,g_apce_d[l_ac].apce044_desc
            LET g_apce_d_t.apce044_desc = g_apce_d[l_ac].apce044_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce044_desc
            #add-point:ON CHANGE apce044_desc name="input.g.page1.apce044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045
            #add-point:BEFORE FIELD apce045 name="input.b.page1.apce045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045
            
            #add-point:AFTER FIELD apce045 name="input.a.page1.apce045"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce045
            #add-point:ON CHANGE apce045 name="input.g.page1.apce045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce045_desc
            #add-point:BEFORE FIELD apce045_desc name="input.b.page1.apce045_desc"
            LET g_apce_d[l_ac].apce045_desc = g_apce_d[l_ac].apce045   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce045_desc
            
            #add-point:AFTER FIELD apce045_desc name="input.a.page1.apce045_desc"
            #渠道
            IF NOT cl_null(g_apce_d[l_ac].apce045_desc) THEN
               IF ( g_apce_d[l_ac].apce045_desc != g_apce_d_t.apce045_desc OR g_apce_d_t.apce045_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce045 = g_apce_d[l_ac].apce045_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #CALL s_aap_oojd001_chk(g_apce_d[l_ac].apce045) RETURNING g_sub_success,g_errno #140806-00012#8 mark
                     CALL s_voucher_glaq052_chk(g_apce_d[l_ac].apce045)  #140806-00012#8
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apce_d[l_ac].apce045 = g_apce_d_t.apce045
                        LET g_apce_d[l_ac].apce045_desc = g_apce_d_t.apce045_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce045_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce045 = ''
            END IF
            LET g_apce_d[l_ac].apce045_desc = s_desc_show1(g_apce_d[l_ac].apce045,s_desc_get_oojdl003_desc(g_apce_d[l_ac].apce045))
            DISPLAY BY NAME g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce045_desc
            LET g_apce_d_t.apce045_desc = g_apce_d[l_ac].apce045_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce045_desc
            #add-point:ON CHANGE apce045_desc name="input.g.page1.apce045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046
            #add-point:BEFORE FIELD apce046 name="input.b.page1.apce046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046
            
            #add-point:AFTER FIELD apce046 name="input.a.page1.apce046"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce046
            #add-point:ON CHANGE apce046 name="input.g.page1.apce046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce046_desc
            #add-point:BEFORE FIELD apce046_desc name="input.b.page1.apce046_desc"
            LET g_apce_d[l_ac].apce046_desc = g_apce_d[l_ac].apce046   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce046_desc
            
            #add-point:AFTER FIELD apce046_desc name="input.a.page1.apce046_desc"
            #品牌
            IF NOT cl_null(g_apce_d[l_ac].apce046_desc) THEN
               IF ( g_apce_d[l_ac].apce046_desc != g_apce_d_t.apce046_desc OR g_apce_d_t.apce046_desc IS NULL ) THEN
                  LET g_apce_d[l_ac].apce046 = g_apce_d[l_ac].apce046_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('2002',g_apce_d[l_ac].apce046) THEN
                        LET g_apce_d[l_ac].apce046      = g_apce_d_t.apce046
                        LET g_apce_d[l_ac].apce046_desc = g_apce_d_t.apce046_desc
                        DISPLAY BY NAME g_apce_d[l_ac].apce046 ,g_apce_d[l_ac].apce046_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce046 = ''
            END IF
            LET g_apce_d[l_ac].apce046_desc = s_desc_show1(g_apce_d[l_ac].apce046,s_desc_get_acc_desc('2002',g_apce_d[l_ac].apce046))      
            DISPLAY BY NAME g_apce_d[l_ac].apce046 ,g_apce_d[l_ac].apce046_desc
            LET g_apce_d_t.apce046_desc = g_apce_d[l_ac].apce046_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce046_desc
            #add-point:ON CHANGE apce046_desc name="input.g.page1.apce046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce051
            #add-point:BEFORE FIELD apce051 name="input.b.page1.apce051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce051
            
            #add-point:AFTER FIELD apce051 name="input.a.page1.apce051"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce051
            #add-point:ON CHANGE apce051 name="input.g.page1.apce051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce051_desc
            #add-point:BEFORE FIELD apce051_desc name="input.b.page1.apce051_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apce_d[l_ac].apce051_desc = g_apce_d[l_ac].apce051   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce051_desc
            
            #add-point:AFTER FIELD apce051_desc name="input.a.page1.apce051_desc"
            #自由核算項一
            IF NOT cl_null(g_apce_d[l_ac].apce051_desc) THEN
               IF (g_apce_d[l_ac].apce051_desc != g_apce_d_t.apce051_desc OR g_apce_d_t.apce051_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce051 = g_apce_d[l_ac].apce051_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce051 != g_apce_d_t.apce051 OR g_apce_d_t.apce051 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_apce_d[l_ac].apce051,g_glad.glad0172) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce051 = g_apce_d_t.apce051
                           LET g_apce_d[l_ac].apce051_desc = s_desc_show1(g_apce_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce_d[l_ac].apce051))
                           DISPLAY BY NAME g_apce_d[l_ac].apce051_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce051 = ''
            END IF
            LET g_apce_d[l_ac].apce051_desc = s_desc_show1(g_apce_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce_d[l_ac].apce051))
            DISPLAY BY NAME g_apce_d[l_ac].apce051_desc
            LET g_apce_d_t.apce051_desc = g_apce_d[l_ac].apce051_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce051_desc
            #add-point:ON CHANGE apce051_desc name="input.g.page1.apce051_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce052
            #add-point:BEFORE FIELD apce052 name="input.b.page1.apce052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce052
            
            #add-point:AFTER FIELD apce052 name="input.a.page1.apce052"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce052
            #add-point:ON CHANGE apce052 name="input.g.page1.apce052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce052_desc
            #add-point:BEFORE FIELD apce052_desc name="input.b.page1.apce052_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apce_d[l_ac].apce052_desc = g_apce_d[l_ac].apce052   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce052_desc
            
            #add-point:AFTER FIELD apce052_desc name="input.a.page1.apce052_desc"
            #自由核算項二
            IF NOT cl_null(g_apce_d[l_ac].apce052_desc) THEN
               IF (g_apce_d[l_ac].apce052_desc != g_apce_d_t.apce052_desc OR g_apce_d_t.apce052_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce052 = g_apce_d[l_ac].apce052_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce052 != g_apce_d_t.apce052 OR g_apce_d_t.apce052 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_apce_d[l_ac].apce052,g_glad.glad0182) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce052 = g_apce_d_t.apce052
                           LET g_apce_d[l_ac].apce052_desc = s_desc_show1(g_apce_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce_d[l_ac].apce052))
                           DISPLAY BY NAME g_apce_d[l_ac].apce052_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce052 = ''
            END IF
            LET g_apce_d[l_ac].apce052_desc = s_desc_show1(g_apce_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce_d[l_ac].apce052))
            DISPLAY BY NAME g_apce_d[l_ac].apce052_desc 
            LET g_apce_d_t.apce052_desc = g_apce_d[l_ac].apce052_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce052_desc
            #add-point:ON CHANGE apce052_desc name="input.g.page1.apce052_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce053
            #add-point:BEFORE FIELD apce053 name="input.b.page1.apce053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce053
            
            #add-point:AFTER FIELD apce053 name="input.a.page1.apce053"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce053
            #add-point:ON CHANGE apce053 name="input.g.page1.apce053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce053_desc
            #add-point:BEFORE FIELD apce053_desc name="input.b.page1.apce053_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apce_d[l_ac].apce053_desc = g_apce_d[l_ac].apce053   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce053_desc
            
            #add-point:AFTER FIELD apce053_desc name="input.a.page1.apce053_desc"
            #自由核算項三
            IF NOT cl_null(g_apce_d[l_ac].apce053_desc) THEN
               IF (g_apce_d[l_ac].apce053_desc != g_apce_d_t.apce053_desc OR g_apce_d_t.apce053_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce053 = g_apce_d[l_ac].apce053_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce053 != g_apce_d_t.apce053 OR g_apce_d_t.apce053 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_apce_d[l_ac].apce053,g_glad.glad0192) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce053 = g_apce_d_t.apce053
                           LET g_apce_d[l_ac].apce053_desc = s_desc_show1(g_apce_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce_d[l_ac].apce053))
                           DISPLAY BY NAME g_apce_d[l_ac].apce053_desc
                           NEXT FIELD CURRENT
                        END IF 
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce053 = ''
            END IF
            LET g_apce_d[l_ac].apce053_desc = s_desc_show1(g_apce_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce_d[l_ac].apce053))
            DISPLAY BY NAME g_apce_d[l_ac].apce053_desc 
            LET g_apce_d_t.apce053_desc = g_apce_d[l_ac].apce053_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce053_desc
            #add-point:ON CHANGE apce053_desc name="input.g.page1.apce053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce054
            #add-point:BEFORE FIELD apce054 name="input.b.page1.apce054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce054
            
            #add-point:AFTER FIELD apce054 name="input.a.page1.apce054"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce054
            #add-point:ON CHANGE apce054 name="input.g.page1.apce054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce054_desc
            #add-point:BEFORE FIELD apce054_desc name="input.b.page1.apce054_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apce_d[l_ac].apce054_desc = g_apce_d[l_ac].apce054   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce054_desc
            
            #add-point:AFTER FIELD apce054_desc name="input.a.page1.apce054_desc"
            #自由核算項四
            IF NOT cl_null(g_apce_d[l_ac].apce054_desc) THEN
               IF (g_apce_d[l_ac].apce054_desc != g_apce_d_t.apce054_desc OR g_apce_d_t.apce054_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce054 = g_apce_d[l_ac].apce054_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce054 != g_apce_d_t.apce054 OR g_apce_d_t.apce054 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_apce_d[l_ac].apce054,g_glad.glad0202) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce054 = g_apce_d_t.apce054
                           LET g_apce_d[l_ac].apce054_desc = s_desc_show1(g_apce_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce_d[l_ac].apce054))
                           DISPLAY BY NAME g_apce_d[l_ac].apce054_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce054 = ''
            END IF
            LET g_apce_d[l_ac].apce054_desc = s_desc_show1(g_apce_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce_d[l_ac].apce054))
            DISPLAY BY NAME g_apce_d[l_ac].apce054_desc 
            LET g_apce_d_t.apce054_desc = g_apce_d[l_ac].apce054_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce054_desc
            #add-point:ON CHANGE apce054_desc name="input.g.page1.apce054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce055
            #add-point:BEFORE FIELD apce055 name="input.b.page1.apce055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce055
            
            #add-point:AFTER FIELD apce055 name="input.a.page1.apce055"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce055
            #add-point:ON CHANGE apce055 name="input.g.page1.apce055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce055_desc
            #add-point:BEFORE FIELD apce055_desc name="input.b.page1.apce055_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apce_d[l_ac].apce055_desc = g_apce_d[l_ac].apce055   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce055_desc
            
            #add-point:AFTER FIELD apce055_desc name="input.a.page1.apce055_desc"
            #自由核算項五
            IF NOT cl_null(g_apce_d[l_ac].apce055_desc) THEN
               IF (g_apce_d[l_ac].apce055_desc != g_apce_d_t.apce055_desc OR g_apce_d_t.apce055_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce055 = g_apce_d[l_ac].apce055_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce055 != g_apce_d_t.apce055 OR g_apce_d_t.apce055 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_apce_d[l_ac].apce055,g_glad.glad0212) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce055 = g_apce_d_t.apce055
                           LET g_apce_d[l_ac].apce055_desc = s_desc_show1(g_apce_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce_d[l_ac].apce055))
                           DISPLAY BY NAME g_apce_d[l_ac].apce055_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce055 = ''
            END IF
            LET g_apce_d[l_ac].apce055_desc = s_desc_show1(g_apce_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce_d[l_ac].apce055))
            DISPLAY BY NAME g_apce_d[l_ac].apce055_desc 
            LET g_apce_d_t.apce055_desc = g_apce_d[l_ac].apce055_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce055_desc
            #add-point:ON CHANGE apce055_desc name="input.g.page1.apce055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce056
            #add-point:BEFORE FIELD apce056 name="input.b.page1.apce056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce056
            
            #add-point:AFTER FIELD apce056 name="input.a.page1.apce056"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce056
            #add-point:ON CHANGE apce056 name="input.g.page1.apce056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce056_desc
            #add-point:BEFORE FIELD apce056_desc name="input.b.page1.apce056_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apce_d[l_ac].apce056_desc = g_apce_d[l_ac].apce056   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce056_desc
            
            #add-point:AFTER FIELD apce056_desc name="input.a.page1.apce056_desc"
            #自由核算項六
            IF NOT cl_null(g_apce_d[l_ac].apce056_desc) THEN
               IF (g_apce_d[l_ac].apce056_desc != g_apce_d_t.apce056_desc OR g_apce_d_t.apce056_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce056 = g_apce_d[l_ac].apce056_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce056 != g_apce_d_t.apce056 OR g_apce_d_t.apce056 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_apce_d[l_ac].apce056,g_glad.glad0222) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce056 = g_apce_d_t.apce056
                           LET g_apce_d[l_ac].apce056_desc = s_desc_show1(g_apce_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce_d[l_ac].apce056))
                           DISPLAY BY NAME g_apce_d[l_ac].apce056_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce055 = ''
            END IF
            LET g_apce_d[l_ac].apce056_desc = s_desc_show1(g_apce_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce_d[l_ac].apce056))
            DISPLAY BY NAME g_apce_d[l_ac].apce056_desc 
            LET g_apce_d_t.apce056_desc = g_apce_d[l_ac].apce056_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce056_desc
            #add-point:ON CHANGE apce056_desc name="input.g.page1.apce056_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce057
            #add-point:BEFORE FIELD apce057 name="input.b.page1.apce057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce057
            
            #add-point:AFTER FIELD apce057 name="input.a.page1.apce057"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce057
            #add-point:ON CHANGE apce057 name="input.g.page1.apce057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce057_desc
            #add-point:BEFORE FIELD apce057_desc name="input.b.page1.apce057_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apce_d[l_ac].apce057_desc = g_apce_d[l_ac].apce057   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce057_desc
            
            #add-point:AFTER FIELD apce057_desc name="input.a.page1.apce057_desc"
            #自由核算項七
            IF NOT cl_null(g_apce_d[l_ac].apce057_desc) THEN
               IF (g_apce_d[l_ac].apce057_desc != g_apce_d_t.apce057_desc OR g_apce_d_t.apce057_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce057 = g_apce_d[l_ac].apce057_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce057 != g_apce_d_t.apce057 OR g_apce_d_t.apce057 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_apce_d[l_ac].apce057,g_glad.glad0232) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce057 = g_apce_d_t.apce057
                           LET g_apce_d[l_ac].apce057_desc = s_desc_show1(g_apce_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce_d[l_ac].apce057))
                           DISPLAY BY NAME g_apce_d[l_ac].apce057_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce057 = ''
            END IF
            LET g_apce_d[l_ac].apce057_desc = s_desc_show1(g_apce_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce_d[l_ac].apce057))
            DISPLAY BY NAME g_apce_d[l_ac].apce057_desc
            LET g_apce_d_t.apce057_desc = g_apce_d[l_ac].apce057_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce057_desc
            #add-point:ON CHANGE apce057_desc name="input.g.page1.apce057_desc"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce058
            #add-point:BEFORE FIELD apce058 name="input.b.page1.apce058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce058
            
            #add-point:AFTER FIELD apce058 name="input.a.page1.apce058"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce058
            #add-point:ON CHANGE apce058 name="input.g.page1.apce058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce058_desc
            #add-point:BEFORE FIELD apce058_desc name="input.b.page1.apce058_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apce_d[l_ac].apce058_desc = g_apce_d[l_ac].apce058   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce058_desc
            
            #add-point:AFTER FIELD apce058_desc name="input.a.page1.apce058_desc"
            #自由核算項八
            IF NOT cl_null(g_apce_d[l_ac].apce058_desc) THEN
               IF (g_apce_d[l_ac].apce058_desc != g_apce_d_t.apce058_desc OR g_apce_d_t.apce058_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce058 = g_apce_d[l_ac].apce058_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce058 != g_apce_d_t.apce058 OR g_apce_d_t.apce058 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_apce_d[l_ac].apce058,g_glad.glad0242) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce058 = g_apce_d_t.apce058
                           LET g_apce_d[l_ac].apce058_desc = s_desc_show1(g_apce_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce_d[l_ac].apce058))
                           DISPLAY BY NAME g_apce_d[l_ac].apce058_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce058 = ''
            END IF
            LET g_apce_d[l_ac].apce058_desc = s_desc_show1(g_apce_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce_d[l_ac].apce058))
            DISPLAY BY NAME g_apce_d[l_ac].apce058_desc 
            LET g_apce_d_t.apce058_desc = g_apce_d[l_ac].apce058_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce058_desc
            #add-point:ON CHANGE apce058_desc name="input.g.page1.apce058_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce059
            #add-point:BEFORE FIELD apce059 name="input.b.page1.apce059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce059
            
            #add-point:AFTER FIELD apce059 name="input.a.page1.apce059"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce059
            #add-point:ON CHANGE apce059 name="input.g.page1.apce059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce059_desc
            #add-point:BEFORE FIELD apce059_desc name="input.b.page1.apce059_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apce_d[l_ac].apce059_desc = g_apce_d[l_ac].apce059   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce059_desc
            
            #add-point:AFTER FIELD apce059_desc name="input.a.page1.apce059_desc"
            #自由核算項九
            IF NOT cl_null(g_apce_d[l_ac].apce059_desc) THEN
               IF (g_apce_d[l_ac].apce059_desc != g_apce_d_t.apce059_desc OR g_apce_d_t.apce059_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce059 = g_apce_d[l_ac].apce059_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce059 != g_apce_d_t.apce059 OR g_apce_d_t.apce059 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_apce_d[l_ac].apce059,g_glad.glad0252) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce059 = g_apce_d_t.apce059
                           LET g_apce_d[l_ac].apce059_desc = s_desc_show1(g_apce_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce_d[l_ac].apce059))
                           DISPLAY BY NAME g_apce_d[l_ac].apce059_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce_d[l_ac].apce059 = ''
            END IF
            LET g_apce_d[l_ac].apce059_desc = s_desc_show1(g_apce_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce_d[l_ac].apce059))
             DISPLAY BY NAME g_apce_d[l_ac].apce059_desc 
             LET g_apce_d_t.apce059_desc = g_apce_d[l_ac].apce059_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce059_desc
            #add-point:ON CHANGE apce059_desc name="input.g.page1.apce059_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce060
            #add-point:BEFORE FIELD apce060 name="input.b.page1.apce060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce060
            
            #add-point:AFTER FIELD apce060 name="input.a.page1.apce060"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce060
            #add-point:ON CHANGE apce060 name="input.g.page1.apce060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce060_desc
            #add-point:BEFORE FIELD apce060_desc name="input.b.page1.apce060_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apce_d[l_ac].apce060_desc = g_apce_d[l_ac].apce060   #150205-00012#1  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce060_desc
            
            #add-point:AFTER FIELD apce060_desc name="input.a.page1.apce060_desc"
            #自由核算項十
            IF NOT cl_null(g_apce_d[l_ac].apce060_desc) THEN
               IF (g_apce_d[l_ac].apce060_desc != g_apce_d_t.apce060_desc OR g_apce_d_t.apce060_desc IS NULL) THEN
                  LET g_apce_d[l_ac].apce060 = g_apce_d[l_ac].apce060_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce_d[l_ac].apce060 != g_apce_d_t.apce060 OR g_apce_d_t.apce060 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_apce_d[l_ac].apce060,g_glad.glad0262) RETURNING g_errno
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
                           LET g_apce_d[l_ac].apce060 = g_apce_d_t.apce060
                           LET g_apce_d[l_ac].apce060_desc = s_desc_show1(g_apce_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce_d[l_ac].apce060))
                           DISPLAY BY NAME g_apce_d[l_ac].apce060_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce_d[l_ac].apce060 = ''
            END IF
            LET g_apce_d[l_ac].apce060_desc = s_desc_show1(g_apce_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce_d[l_ac].apce060))
            DISPLAY BY NAME g_apce_d[l_ac].apce060_desc 
            LET g_apce_d_t.apce060_desc = g_apce_d[l_ac].apce060_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce060_desc
            #add-point:ON CHANGE apce060_desc name="input.g.page1.apce060_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcecomp
            #add-point:BEFORE FIELD apcecomp name="input.b.page1.apcecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcecomp
            
            #add-point:AFTER FIELD apcecomp name="input.a.page1.apcecomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcecomp
            #add-point:ON CHANGE apcecomp name="input.g.page1.apcecomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcelegl
            #add-point:BEFORE FIELD apcelegl name="input.b.page1.apcelegl"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcelegl
            
            #add-point:AFTER FIELD apcelegl name="input.a.page1.apcelegl"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcelegl
            #add-point:ON CHANGE apcelegl name="input.g.page1.apcelegl"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcesite
            #add-point:BEFORE FIELD apcesite name="input.b.page1.apcesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcesite
            
            #add-point:AFTER FIELD apcesite name="input.a.page1.apcesite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcesite
            #add-point:ON CHANGE apcesite name="input.g.page1.apcesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce027
            #add-point:BEFORE FIELD apce027 name="input.b.page1.apce027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce027
            
            #add-point:AFTER FIELD apce027 name="input.a.page1.apce027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce027
            #add-point:ON CHANGE apce027 name="input.g.page1.apce027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce028
            #add-point:BEFORE FIELD apce028 name="input.b.page1.apce028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce028
            
            #add-point:AFTER FIELD apce028 name="input.a.page1.apce028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce028
            #add-point:ON CHANGE apce028 name="input.g.page1.apce028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce031
            #add-point:BEFORE FIELD apce031 name="input.b.page1.apce031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce031
            
            #add-point:AFTER FIELD apce031 name="input.a.page1.apce031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce031
            #add-point:ON CHANGE apce031 name="input.g.page1.apce031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce032
            #add-point:BEFORE FIELD apce032 name="input.b.page1.apce032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce032
            
            #add-point:AFTER FIELD apce032 name="input.a.page1.apce032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce032
            #add-point:ON CHANGE apce032 name="input.g.page1.apce032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce100
            #add-point:BEFORE FIELD apce100 name="input.b.page1.apce100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce100
            
            #add-point:AFTER FIELD apce100 name="input.a.page1.apce100"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce100
            #add-point:ON CHANGE apce100 name="input.g.page1.apce100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_d[l_ac].apce101,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce101
            END IF 
 
 
 
            #add-point:AFTER FIELD apce101 name="input.a.page1.apce101"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce101
            #add-point:BEFORE FIELD apce101 name="input.b.page1.apce101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce101
            #add-point:ON CHANGE apce101 name="input.g.page1.apce101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_d[l_ac].apce109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apce109
            END IF 
 
 
 
            #add-point:AFTER FIELD apce109 name="input.a.page1.apce109"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce109
            #add-point:BEFORE FIELD apce109 name="input.b.page1.apce109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce109
            #add-point:ON CHANGE apce109 name="input.g.page1.apce109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce120
            #add-point:BEFORE FIELD apce120 name="input.b.page1.apce120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce120
            
            #add-point:AFTER FIELD apce120 name="input.a.page1.apce120"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce120
            #add-point:ON CHANGE apce120 name="input.g.page1.apce120"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce121
            #add-point:BEFORE FIELD apce121 name="input.b.page1.apce121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce121
            
            #add-point:AFTER FIELD apce121 name="input.a.page1.apce121"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce121
            #add-point:ON CHANGE apce121 name="input.g.page1.apce121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce130
            #add-point:BEFORE FIELD apce130 name="input.b.page1.apce130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce130
            
            #add-point:AFTER FIELD apce130 name="input.a.page1.apce130"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce130
            #add-point:ON CHANGE apce130 name="input.g.page1.apce130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce131
            #add-point:BEFORE FIELD apce131 name="input.b.page1.apce131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce131
            
            #add-point:AFTER FIELD apce131 name="input.a.page1.apce131"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce131
            #add-point:ON CHANGE apce131 name="input.g.page1.apce131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce104
            #add-point:BEFORE FIELD apce104 name="input.b.page1.apce104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce104
            
            #add-point:AFTER FIELD apce104 name="input.a.page1.apce104"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce104
            #add-point:ON CHANGE apce104 name="input.g.page1.apce104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce114
            #add-point:BEFORE FIELD apce114 name="input.b.page1.apce114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce114
            
            #add-point:AFTER FIELD apce114 name="input.a.page1.apce114"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce114
            #add-point:ON CHANGE apce114 name="input.g.page1.apce114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce124
            #add-point:BEFORE FIELD apce124 name="input.b.page1.apce124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce124
            
            #add-point:AFTER FIELD apce124 name="input.a.page1.apce124"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce124
            #add-point:ON CHANGE apce124 name="input.g.page1.apce124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce134
            #add-point:BEFORE FIELD apce134 name="input.b.page1.apce134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce134
            
            #add-point:AFTER FIELD apce134 name="input.a.page1.apce134"
            LET g_apce_d_o.* = g_apce_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce134
            #add-point:ON CHANGE apce134 name="input.g.page1.apce134"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apceseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceseq
            #add-point:ON ACTION controlp INFIELD apceseq name="input.c.page1.apceseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce001
            #add-point:ON ACTION controlp INFIELD apce001 name="input.c.page1.apce001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce002
            #add-point:ON ACTION controlp INFIELD apce002 name="input.c.page1.apce002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="input.c.page1.apca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apceorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceorga
            #add-point:ON ACTION controlp INFIELD apceorga name="input.c.page1.apceorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apceorga
            LET g_qryparam.where = " ooef001 IN ",g_wc_apdasite CLIPPED,
                                   " AND ooef017 ='",g_apda_m.apdacomp,"' ",
                                   " AND ooef201 = 'Y'"   #161006-00005#5   add
            CALL q_ooef001()
            LET g_apce_d[l_ac].apceorga = g_qryparam.return1
            DISPLAY BY NAME g_apce_d[l_ac].apceorga
            NEXT FIELD apceorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce003
            #add-point:ON ACTION controlp INFIELD apce003 name="input.c.page1.apce003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce003
            LET g_qryparam.default2 = g_apce_d[l_ac].apce004
            LET g_qryparam.default3 = g_apce_d[l_ac].apce005
            IF g_apce_d[l_ac].apca001 <> '05' THEN    #151207-00018#3
              #LET g_qryparam.where = "apca001 IN (",g_apce_d[l_ac].apca001,")"   #160629-00016#1 mark
               LET g_qryparam.where = "apca001 = '",g_apce_d[l_ac].apca001,"'" #160629-00016#1 add
               LET g_qryparam.arg1 = g_apda_m.apdald
               LET g_qryparam.arg2 = g_apda_m.apdadocdt
              #CALL q_apce003()      #160816-00022#1 mark
               CALL q_apce003_02()   #160816-00022#1 
               LET g_apce_d[l_ac].apce003 = g_qryparam.return1
               LET g_apce_d[l_ac].apce004 = g_qryparam.return2
              #LET g_apce_d[l_ac].apce005 = g_qryparam.return3   #160816-00022#1 mark
               LET g_apce_d[l_ac].apce005 = ''                   #160816-00022#1 
            #151207-00018#3--(S)
            ELSE
               LET g_qryparam.where = " apcf008 = 'DIFF' AND apcastus = 'Y' ",
                                     #161216-00068#1 mark (S)
                                     #" AND (apcfdocno,apcfseq) NOT IN (SELECT DISTINCT apce003,apce004 FROM apda_t,apce_t ",
                                     #                       " WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno AND apda001 = '43' AND apce003 IS NOT NULL ",
                                     #                       "   AND apdaent = ",g_enterprise," AND apdald = '",g_apda_m.apdald,"' AND apdadocno = '",g_apda_m.apdadocno,"' )"
                                     #161216-00068#1 mark (E)
                                     #161216-00068#1 add (S)
                                      #" AND apcfdocno NOT IN (SELECT DISTINCT apce003 FROM apda_t,apce_t ",                    #170207-00049#1 mark
                                      " AND (apcfdocno,apcfseq) NOT IN (SELECT DISTINCT apce003,apce004 FROM apda_t,apce_t ",   #170207-00049#1 add
                                      "                        WHERE apdaent = apceent AND apdald = apceld ",
                                      "                          AND apdadocno = apcedocno AND apda001 = '43' ",
                                      "                          AND apce003 IS NOT NULL AND apdastus <> 'X' ",
                                      "                          AND apdaent = ",g_enterprise,
                                      "                          AND apdald = '",g_apda_m.apdald,"' ) "
                                     #161216-00068#1 add (E)
               LET g_qryparam.arg1 = g_apda_m.apdald
               LET g_qryparam.arg2 = g_apda_m.apdadocdt
               CALL q_apcfdocno()
               LET g_apce_d[l_ac].apce003 = g_qryparam.return1
               LET g_apce_d[l_ac].apce004 = g_qryparam.return2
               LET g_apce_d[l_ac].apce005 = 0
            END IF
            #151207-00018#3--(E)
            
            DISPLAY BY NAME g_apce_d[l_ac].apce003
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
 
 
         #Ctrlp:input.c.page1.apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca004
            #add-point:ON ACTION controlp INFIELD apca004 name="input.c.page1.apca004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apca004
            #161114-00017#2 --s add
            #控制組條件
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF            
            #161114-00017#2 --e add            
            CALL q_pmaa001()
            LET g_apce_d[l_ac].apca004 = g_qryparam.return1
            DISPLAY g_apce_d[l_ac].apca004 TO apca004
            NEXT FIELD apca004
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce038
            #add-point:ON ACTION controlp INFIELD apce038 name="input.c.page1.apce038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce047
            #add-point:ON ACTION controlp INFIELD apce047 name="input.c.page1.apce047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce048
            #add-point:ON ACTION controlp INFIELD apce048 name="input.c.page1.apce048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sum_apcb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apcb113
            #add-point:ON ACTION controlp INFIELD l_sum_apcb113 name="input.c.page1.l_sum_apcb113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce119
            #add-point:ON ACTION controlp INFIELD apce119 name="input.c.page1.apce119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sum_apcb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apcb123
            #add-point:ON ACTION controlp INFIELD l_sum_apcb123 name="input.c.page1.l_sum_apcb123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce129
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce129
            #add-point:ON ACTION controlp INFIELD apce129 name="input.c.page1.apce129"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sum_apcb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum_apcb133
            #add-point:ON ACTION controlp INFIELD l_sum_apcb133 name="input.c.page1.l_sum_apcb133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce139
            #add-point:ON ACTION controlp INFIELD apce139 name="input.c.page1.apce139"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce010
            #add-point:ON ACTION controlp INFIELD apce010 name="input.c.page1.apce010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016
            #add-point:ON ACTION controlp INFIELD apce016 name="input.c.page1.apce016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016_desc
            #add-point:ON ACTION controlp INFIELD apce016_desc name="input.c.page1.apce016_desc"
            #目的會計科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce016
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                    " AND glacent = gladent ", #161114-00017#2 add
                                   "AND gladld='",g_apda_m.apdald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apce_d[l_ac].apce016      = g_qryparam.return1
            LET g_apce_d[l_ac].apce016_desc = g_qryparam.return1
            DISPLAY BY NAME g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce016_desc
            NEXT FIELD apce016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017
            #add-point:ON ACTION controlp INFIELD apce017 name="input.c.page1.apce017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017_desc
            #add-point:ON ACTION controlp INFIELD apce017_desc name="input.c.page1.apce017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce017
            CALL q_ooag001_8()
            LET g_apce_d[l_ac].apce017 = g_qryparam.return1
            LET g_apce_d[l_ac].apce017_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce_d[l_ac].apce017,g_apce_d[l_ac].apce017_desc
            NEXT FIELD apce017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018
            #add-point:ON ACTION controlp INFIELD apce018 name="input.c.page1.apce018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018_desc
            #add-point:ON ACTION controlp INFIELD apce018_desc name="input.c.page1.apce018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce018
            LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apce_d[l_ac].apce018 = g_qryparam.return1   
            LET g_apce_d[l_ac].apce018_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce_d[l_ac].apce018,g_apce_d[l_ac].apce018_desc
            NEXT FIELD apce018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019
            #add-point:ON ACTION controlp INFIELD apce019 name="input.c.page1.apce019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019_desc
            #add-point:ON ACTION controlp INFIELD apce019_desc name="input.c.page1.apce019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce019
            LET g_qryparam.arg1 = g_apda_m.apdadocdt
            #LET g_qryparam.where =" ooeg003 IN ('1','2','3')"  #140806-00012#8 mark
            #CALL q_ooeg001_4()                                 #140806-00012#8 mark
            CALL q_ooeg001_5()                                  #140806-00012#8 add
            LET g_apce_d[l_ac].apce019 = g_qryparam.return1
            LET g_apce_d[l_ac].apce019_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce_d[l_ac].apce019,g_apce_d[l_ac].apce019_desc
            NEXT FIELD apce019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020
            #add-point:ON ACTION controlp INFIELD apce020 name="input.c.page1.apce020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020_desc
            #add-point:ON ACTION controlp INFIELD apce020_desc name="input.c.page1.apce020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce020
            CALL q_rtax001()
            LET g_apce_d[l_ac].apce020 = g_qryparam.return1
            LET g_apce_d[l_ac].apce020_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce_d[l_ac].apce020,g_apce_d[l_ac].apce020_desc
            NEXT FIELD apce020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022
            #add-point:ON ACTION controlp INFIELD apce022 name="input.c.page1.apce022"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022_desc
            #add-point:ON ACTION controlp INFIELD apce022_desc name="input.c.page1.apce022_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce022
            CALL q_pjba001()
            LET g_apce_d[l_ac].apce022 = g_qryparam.return1
            LET g_apce_d[l_ac].apce022_desc = g_qryparam.return1
            DISPLAY BY NAME g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce022_desc
            NEXT FIELD apce022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023
            #add-point:ON ACTION controlp INFIELD apce023 name="input.c.page1.apce023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023_desc
            #add-point:ON ACTION controlp INFIELD apce023_desc name="input.c.page1.apce023_desc"
            #WBS #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce023
            IF NOT cl_null(g_apce_d[l_ac].apce022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apce_d[l_ac].apce022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_apce_d[l_ac].apce023 = g_qryparam.return1   
            LET g_apce_d[l_ac].apce023_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce_d[l_ac].apce023,g_apce_d[l_ac].apce023_desc
            NEXT FIELD apce023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035
            #add-point:ON ACTION controlp INFIELD apce035 name="input.c.page1.apce035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce035_desc
            #add-point:ON ACTION controlp INFIELD apce035_desc name="input.c.page1.apce035_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce035
            CALL q_oocq002_287()
            LET g_apce_d[l_ac].apce035 = g_qryparam.return1
            LET g_apce_d[l_ac].apce035_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce_d[l_ac].apce035,g_apce_d[l_ac].apce035_desc
            NEXT FIELD apce035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036
            #add-point:ON ACTION controlp INFIELD apce036 name="input.c.page1.apce036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce036_desc
            #add-point:ON ACTION controlp INFIELD apce036_desc name="input.c.page1.apce036_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce036
            CALL q_oocq002_281()
            LET g_apce_d[l_ac].apce036 = g_qryparam.return1
            LET g_apce_d[l_ac].apce036_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce_d[l_ac].apce036,g_apce_d[l_ac].apce036_desc
            NEXT FIELD apce036_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044
            #add-point:ON ACTION controlp INFIELD apce044 name="input.c.page1.apce044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce044_desc
            #add-point:ON ACTION controlp INFIELD apce044_desc name="input.c.page1.apce044_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045
            #add-point:ON ACTION controlp INFIELD apce045 name="input.c.page1.apce045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce045_desc
            #add-point:ON ACTION controlp INFIELD apce045_desc name="input.c.page1.apce045_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce045
            CALL q_oojd001_2()
            LET g_apce_d[l_ac].apce045 = g_qryparam.return1   
            LET g_apce_d[l_ac].apce045_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce045_desc
            NEXT FIELD apce045_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046
            #add-point:ON ACTION controlp INFIELD apce046 name="input.c.page1.apce046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce046_desc
            #add-point:ON ACTION controlp INFIELD apce046_desc name="input.c.page1.apce046_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce046
            CALL q_oocq002_2002()
            LET g_apce_d[l_ac].apce046 = g_qryparam.return1   
            LET g_apce_d[l_ac].apce046_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce_d[l_ac].apce046,g_apce_d[l_ac].apce046_desc
            NEXT FIELD apce046_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce051
            #add-point:ON ACTION controlp INFIELD apce051 name="input.c.page1.apce051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce051_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce051_desc
            #add-point:ON ACTION controlp INFIELD apce051_desc name="input.c.page1.apce051_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce051
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce051      = g_qryparam.return1
               LET g_apce_d[l_ac].apce051_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce051,g_apce_d[l_ac].apce051_desc
               NEXT FIELD apce051_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce052
            #add-point:ON ACTION controlp INFIELD apce052 name="input.c.page1.apce052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce052_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce052_desc
            #add-point:ON ACTION controlp INFIELD apce052_desc name="input.c.page1.apce052_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce052
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce052      = g_qryparam.return1
               LET g_apce_d[l_ac].apce052_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce052,g_apce_d[l_ac].apce052_desc
               NEXT FIELD apce052_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce053
            #add-point:ON ACTION controlp INFIELD apce053 name="input.c.page1.apce053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce053_desc
            #add-point:ON ACTION controlp INFIELD apce053_desc name="input.c.page1.apce053_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce053
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce053      = g_qryparam.return1
               LET g_apce_d[l_ac].apce053_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce053,g_apce_d[l_ac].apce053_desc
               NEXT FIELD apce053_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce054
            #add-point:ON ACTION controlp INFIELD apce054 name="input.c.page1.apce054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce054_desc
            #add-point:ON ACTION controlp INFIELD apce054_desc name="input.c.page1.apce054_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce054
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce054      = g_qryparam.return1
               LET g_apce_d[l_ac].apce054_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce054,g_apce_d[l_ac].apce054_desc
               NEXT FIELD apce054_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce055
            #add-point:ON ACTION controlp INFIELD apce055 name="input.c.page1.apce055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce055_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce055_desc
            #add-point:ON ACTION controlp INFIELD apce055_desc name="input.c.page1.apce055_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce055
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce055      = g_qryparam.return1
               LET g_apce_d[l_ac].apce055_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce055,g_apce_d[l_ac].apce055_desc
               NEXT FIELD apce055_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce056
            #add-point:ON ACTION controlp INFIELD apce056 name="input.c.page1.apce056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce056_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce056_desc
            #add-point:ON ACTION controlp INFIELD apce056_desc name="input.c.page1.apce056_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce056
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce056      = g_qryparam.return1
               LET g_apce_d[l_ac].apce056_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce056,g_apce_d[l_ac].apce056_desc
               NEXT FIELD apce056_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce057
            #add-point:ON ACTION controlp INFIELD apce057 name="input.c.page1.apce057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce057_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce057_desc
            #add-point:ON ACTION controlp INFIELD apce057_desc name="input.c.page1.apce057_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce057
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce057      = g_qryparam.return1
               LET g_apce_d[l_ac].apce057_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce057,g_apce_d[l_ac].apce057_desc
               NEXT FIELD apce057_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce058
            #add-point:ON ACTION controlp INFIELD apce058 name="input.c.page1.apce058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce058_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce058_desc
            #add-point:ON ACTION controlp INFIELD apce058_desc name="input.c.page1.apce058_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce058
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce058      = g_qryparam.return1
               LET g_apce_d[l_ac].apce058_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce058,g_apce_d[l_ac].apce058_desc
               NEXT FIELD apce058_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce059
            #add-point:ON ACTION controlp INFIELD apce059 name="input.c.page1.apce059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce059_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce059_desc
            #add-point:ON ACTION controlp INFIELD apce059_desc name="input.c.page1.apce059_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce059
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce059      = g_qryparam.return1
               LET g_apce_d[l_ac].apce059_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce059,g_apce_d[l_ac].apce059_desc
               NEXT FIELD apce059_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce060
            #add-point:ON ACTION controlp INFIELD apce060 name="input.c.page1.apce060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce060_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce060_desc
            #add-point:ON ACTION controlp INFIELD apce060_desc name="input.c.page1.apce060_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce_d[l_ac].apce060
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce_d[l_ac].apce060      = g_qryparam.return1
               LET g_apce_d[l_ac].apce060_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce_d[l_ac].apce060,g_apce_d[l_ac].apce060_desc
               NEXT FIELD apce060_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcecomp
            #add-point:ON ACTION controlp INFIELD apcecomp name="input.c.page1.apcecomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcelegl
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcelegl
            #add-point:ON ACTION controlp INFIELD apcelegl name="input.c.page1.apcelegl"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcesite
            #add-point:ON ACTION controlp INFIELD apcesite name="input.c.page1.apcesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce027
            #add-point:ON ACTION controlp INFIELD apce027 name="input.c.page1.apce027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce028
            #add-point:ON ACTION controlp INFIELD apce028 name="input.c.page1.apce028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce031
            #add-point:ON ACTION controlp INFIELD apce031 name="input.c.page1.apce031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce032
            #add-point:ON ACTION controlp INFIELD apce032 name="input.c.page1.apce032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce100
            #add-point:ON ACTION controlp INFIELD apce100 name="input.c.page1.apce100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_d[l_ac].apce100       
            CALL q_ooai001()
            LET g_apce_d[l_ac].apce100 = g_qryparam.return1
            DISPLAY g_apce_d[l_ac].apce100 TO apce100 
            NEXT FIELD apce100
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce101
            #add-point:ON ACTION controlp INFIELD apce101 name="input.c.page1.apce101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce109
            #add-point:ON ACTION controlp INFIELD apce109 name="input.c.page1.apce109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce120
            #add-point:ON ACTION controlp INFIELD apce120 name="input.c.page1.apce120"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce121
            #add-point:ON ACTION controlp INFIELD apce121 name="input.c.page1.apce121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce130
            #add-point:ON ACTION controlp INFIELD apce130 name="input.c.page1.apce130"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce131
            #add-point:ON ACTION controlp INFIELD apce131 name="input.c.page1.apce131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce104
            #add-point:ON ACTION controlp INFIELD apce104 name="input.c.page1.apce104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce114
            #add-point:ON ACTION controlp INFIELD apce114 name="input.c.page1.apce114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce124
            #add-point:ON ACTION controlp INFIELD apce124 name="input.c.page1.apce124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apce134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce134
            #add-point:ON ACTION controlp INFIELD apce134 name="input.c.page1.apce134"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apce_d[l_ac].* = g_apce_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt430_bcl
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
               LET g_apce_d[g_detail_idx].apce002 = g_apce_d[g_detail_idx].apca001        #151218-00004#1
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt430_apce_t_mask_restore('restore_mask_o')
      
               UPDATE apce_t SET (apceld,apcedocno,apceseq,apce001,apce002,apceorga,apce003,apce004, 
                   apce005,apce038,apce047,apce048,apce119,apce129,apce139,apce010,apce015,apce016,apce017, 
                   apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051, 
                   apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apcecomp, 
                   apcelegl,apcesite,apce027,apce028,apce031,apce032,apce100,apce101,apce109,apce120, 
                   apce121,apce130,apce131,apce104,apce114,apce124,apce134) = (g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apce_d[l_ac].apceseq,g_apce_d[l_ac].apce001,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga, 
                   g_apce_d[l_ac].apce003,g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce038, 
                   g_apce_d[l_ac].apce047,g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce129, 
                   g_apce_d[l_ac].apce139,g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce015,g_apce_d[l_ac].apce016, 
                   g_apce_d[l_ac].apce017,g_apce_d[l_ac].apce018,g_apce_d[l_ac].apce019,g_apce_d[l_ac].apce020, 
                   g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce023,g_apce_d[l_ac].apce035,g_apce_d[l_ac].apce036, 
                   g_apce_d[l_ac].apce044,g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce046,g_apce_d[l_ac].apce051, 
                   g_apce_d[l_ac].apce052,g_apce_d[l_ac].apce053,g_apce_d[l_ac].apce054,g_apce_d[l_ac].apce055, 
                   g_apce_d[l_ac].apce056,g_apce_d[l_ac].apce057,g_apce_d[l_ac].apce058,g_apce_d[l_ac].apce059, 
                   g_apce_d[l_ac].apce060,g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcelegl,g_apce_d[l_ac].apcesite, 
                   g_apce_d[l_ac].apce027,g_apce_d[l_ac].apce028,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce032, 
                   g_apce_d[l_ac].apce100,g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce120, 
                   g_apce_d[l_ac].apce121,g_apce_d[l_ac].apce130,g_apce_d[l_ac].apce131,g_apce_d[l_ac].apce104, 
                   g_apce_d[l_ac].apce114,g_apce_d[l_ac].apce124,g_apce_d[l_ac].apce134)
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
               CALL aapt430_update_b('apce_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt430_apce_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apce_d[g_detail_idx].apceseq = g_apce_d_t.apceseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apce_d_t.apceseq
 
                  CALL aapt430_key_update_b(gs_keys,'apce_t')
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
            CALL aapt430_unlock_b("apce_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce_d[li_reproduce_target].* = g_apce_d[li_reproduce].*
 
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
 
            CALL aapt430_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apce2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
 
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
                  LET g_apce2_d[l_ac].apdc008 = "0"
      LET g_apce2_d[l_ac].apdc111 = "0"
      LET g_apce2_d[l_ac].apdc113 = "0"
      LET g_apce2_d[l_ac].apdc211 = "0"
      LET g_apce2_d[l_ac].apdc213 = "0"
      LET g_apce2_d[l_ac].apdc123 = "0"
      LET g_apce2_d[l_ac].apdc223 = "0"
      LET g_apce2_d[l_ac].apdc133 = "0"
      LET g_apce2_d[l_ac].apdc233 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_apce2_d_t.* = g_apce2_d[l_ac].*     #新輸入資料
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt430_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt430_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
 
               LET g_apce2_d[li_reproduce_target].apdcseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_apce2_d[l_ac].apdcseq = NULL
            SELECT MAX(apdcseq) INTO g_apce2_d[l_ac].apdcseq FROM apdc_t
             WHERE apdcent = g_enterprise 
               AND apdcld  = g_apda_m.apdald
               AND apdcdocno = g_apda_m.apdadocno
            IF cl_null(g_apce2_d[l_ac].apdcseq) THEN LET g_apce2_d[l_ac].apdcseq = 0 END IF
            LET g_apce2_d[l_ac].apdcseq = g_apce2_d[l_ac].apdcseq + 1
            
            #來源組織預帶單頭帳務中心
            LET g_apce2_d[l_ac].apdcorga = g_apda_m.apdasite
            #160908-00045#1--add(s)
            CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apce2_d[l_ac].apdcorga_desc
            DISPLAY BY NAME g_apce2_d[l_ac].apdcorga_desc
            #160908-00045#1--add(e)
            #單身帳務中心預帶單頭帳務中心
            LET g_apce2_d[l_ac].apdcsite = g_apda_m.apdasite
            #單身法人預帶單頭法人
            LET g_apce2_d[l_ac].apdccomp = g_apda_m.apdacomp
            
            #預設給借
            LET g_apce2_d[l_ac].apdc015 = 'D'
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
            OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt430_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt430_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apce2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apce2_d[l_ac].apdcseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apce2_d_t.* = g_apce2_d[l_ac].*  #BACKUP
               LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #BACKUP
               CALL aapt430_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aapt430_set_no_entry_b(l_cmd)
               IF NOT aapt430_lock_b("apdc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt430_bcl2 INTO g_apce2_d[l_ac].apdcseq,g_apce2_d[l_ac].apdc001,g_apce2_d[l_ac].apdcorga, 
                      g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003,g_apce2_d[l_ac].apdc004,g_apce2_d[l_ac].apdc008, 
                      g_apce2_d[l_ac].apdc009,g_apce2_d[l_ac].apdc111,g_apce2_d[l_ac].apdc113,g_apce2_d[l_ac].apdc211, 
                      g_apce2_d[l_ac].apdc213,g_apce2_d[l_ac].apdc123,g_apce2_d[l_ac].apdc223,g_apce2_d[l_ac].apdc133, 
                      g_apce2_d[l_ac].apdc233,g_apce2_d[l_ac].apdc005,g_apce2_d[l_ac].apdc006,g_apce2_d[l_ac].apdc041, 
                      g_apce2_d[l_ac].apdc015,g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc017,g_apce2_d[l_ac].apdc018, 
                      g_apce2_d[l_ac].apdc019,g_apce2_d[l_ac].apdc020,g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023, 
                      g_apce2_d[l_ac].apdc024,g_apce2_d[l_ac].apdc025,g_apce2_d[l_ac].apdc027,g_apce2_d[l_ac].apdc028, 
                      g_apce2_d[l_ac].apdc029,g_apce2_d[l_ac].apdc031,g_apce2_d[l_ac].apdc032,g_apce2_d[l_ac].apdc033, 
                      g_apce2_d[l_ac].apdc034,g_apce2_d[l_ac].apdc035,g_apce2_d[l_ac].apdc036,g_apce2_d[l_ac].apdc037, 
                      g_apce2_d[l_ac].apdc038,g_apce2_d[l_ac].apdc039,g_apce2_d[l_ac].apdc040,g_apce2_d[l_ac].apdccomp, 
                      g_apce2_d[l_ac].apdcsite
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
                  CALL aapt430_apdc_t_mask()
                  LET g_apce2_d_mask_n[l_ac].* =  g_apce2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt430_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            #取得自由核算項資訊 #150330
            #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'ALL') RETURNING g_glad.*
            CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*
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
               LET gs_keys[gs_keys.getLength()+1] = g_apce2_d_t.apdcseq
            
               #刪除同層單身
               IF NOT aapt430_delete_b('apdc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt430_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt430_key_delete_b(gs_keys,'apdc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt430_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt430_bcl
 
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
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apdc_t 
             WHERE apdcent = g_enterprise AND apdcld = g_apda_m.apdald
               AND apdcdocno = g_apda_m.apdadocno
               AND apdcseq = g_apce2_d[l_ac].apdcseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apce2_d[g_detail_idx].apdcseq
               CALL aapt430_insert_b('apdc_t',gs_keys,"'2'")
                           
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
               LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt430_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
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
               CLOSE aapt430_bcl2
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
               CALL aapt430_apdc_t_mask_restore('restore_mask_o')
                              
               UPDATE apdc_t SET (apdcld,apdcdocno,apdcseq,apdc001,apdcorga,apdc002,apdc003,apdc004, 
                   apdc008,apdc009,apdc111,apdc113,apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005, 
                   apdc006,apdc041,apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,apdc022,apdc023,apdc024, 
                   apdc025,apdc027,apdc028,apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,apdc036,apdc037, 
                   apdc038,apdc039,apdc040,apdccomp,apdcsite) = (g_apda_m.apdald,g_apda_m.apdadocno, 
                   g_apce2_d[l_ac].apdcseq,g_apce2_d[l_ac].apdc001,g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002, 
                   g_apce2_d[l_ac].apdc003,g_apce2_d[l_ac].apdc004,g_apce2_d[l_ac].apdc008,g_apce2_d[l_ac].apdc009, 
                   g_apce2_d[l_ac].apdc111,g_apce2_d[l_ac].apdc113,g_apce2_d[l_ac].apdc211,g_apce2_d[l_ac].apdc213, 
                   g_apce2_d[l_ac].apdc123,g_apce2_d[l_ac].apdc223,g_apce2_d[l_ac].apdc133,g_apce2_d[l_ac].apdc233, 
                   g_apce2_d[l_ac].apdc005,g_apce2_d[l_ac].apdc006,g_apce2_d[l_ac].apdc041,g_apce2_d[l_ac].apdc015, 
                   g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc017,g_apce2_d[l_ac].apdc018,g_apce2_d[l_ac].apdc019, 
                   g_apce2_d[l_ac].apdc020,g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023,g_apce2_d[l_ac].apdc024, 
                   g_apce2_d[l_ac].apdc025,g_apce2_d[l_ac].apdc027,g_apce2_d[l_ac].apdc028,g_apce2_d[l_ac].apdc029, 
                   g_apce2_d[l_ac].apdc031,g_apce2_d[l_ac].apdc032,g_apce2_d[l_ac].apdc033,g_apce2_d[l_ac].apdc034, 
                   g_apce2_d[l_ac].apdc035,g_apce2_d[l_ac].apdc036,g_apce2_d[l_ac].apdc037,g_apce2_d[l_ac].apdc038, 
                   g_apce2_d[l_ac].apdc039,g_apce2_d[l_ac].apdc040,g_apce2_d[l_ac].apdccomp,g_apce2_d[l_ac].apdcsite)  
                   #自訂欄位頁簽
                WHERE apdcent = g_enterprise AND apdcld = g_apda_m.apdald
                  AND apdcdocno = g_apda_m.apdadocno
                  AND apdcseq = g_apce2_d_t.apdcseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apce2_d[l_ac].* = g_apce2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apdc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apce2_d[l_ac].* = g_apce2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
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
               LET gs_keys[3] = g_apce2_d[g_detail_idx].apdcseq
               LET gs_keys_bak[3] = g_apce2_d_t.apdcseq
               CALL aapt430_update_b('apdc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt430_apdc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apce2_d[g_detail_idx].apdcseq = g_apce2_d_t.apdcseq 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apce2_d_t.apdcseq
                  CALL aapt430_key_update_b(gs_keys,'apdc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce2_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apce2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               #更新單頭"來源應攤銷金額"
               CALL aapt430_upd_apda113() RETURNING g_sub_success
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcseq
            #add-point:BEFORE FIELD apdcseq name="input.b.page2.apdcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcseq
            
            #add-point:AFTER FIELD apdcseq name="input.a.page2.apdcseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apda_m.apdald IS NOT NULL AND g_apda_m.apdadocno IS NOT NULL AND g_apce2_d[g_detail_idx].apdcseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t OR g_apda_m.apdadocno != g_apdadocno_t OR g_apce2_d[g_detail_idx].apdcseq != g_apce2_d_t.apdcseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apdc_t WHERE "||"apdcent = '" ||g_enterprise|| "' AND "||"apdcld = '"||g_apda_m.apdald ||"' AND "|| "apdcdocno = '"||g_apda_m.apdadocno ||"' AND "|| "apdcseq = '"||g_apce2_d[g_detail_idx].apdcseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdcseq
            #add-point:ON CHANGE apdcseq name="input.g.page2.apdcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc001
            #add-point:BEFORE FIELD apdc001 name="input.b.page2.apdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc001
            
            #add-point:AFTER FIELD apdc001 name="input.a.page2.apdc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc001
            #add-point:ON CHANGE apdc001 name="input.g.page2.apdc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcorga
            
            #add-point:AFTER FIELD apdcorga name="input.a.page2.apdcorga"
            #來源組織
            IF NOT cl_null(g_apce2_d[l_ac].apdcorga) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce2_d[l_ac].apdcorga != g_apce2_d_t.apdcorga OR g_apce2_d_t.apdcorga IS NULL )) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdcorga != g_apce2_d_o.apdcorga OR cl_null(g_apce2_d_o.apdcorga)  THEN                                     #160822-00008#3
                  #160908-00045#1--add(s)
                  CALL s_desc_get_department_desc(g_apce2_d[l_ac].apdcorga) RETURNING g_apce2_d[l_ac].apdcorga_desc
                  DISPLAY BY NAME g_apce2_d[l_ac].apdcorga_desc
                  #160908-00045#1--add(e)
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce2_d[l_ac].apdcorga
                  #160318-00025#43  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#43  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_apce2_d[l_ac].apdcorga = g_apce2_d_t.apdcorga
                     #160908-00045#1--add(s)
                     CALL s_desc_get_department_desc(g_apce2_d[l_ac].apdcorga) RETURNING g_apce2_d[l_ac].apdcorga_desc
                     DISPLAY BY NAME g_apce2_d[l_ac].apdcorga_desc
                     #160908-00045#1--add(e)
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[l_ac].apdcorga,g_wc_apdasite) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apce2_d[l_ac].apdcorga = g_apce2_d_t.apdcorga  #160822-00008#3  mark
                     LET g_apce2_d[l_ac].apdcorga = g_apce2_d_o.apdcorga   #160822-00008#3
                     #160908-00045#1--add(s)
                     CALL s_desc_get_department_desc(g_apce2_d[l_ac].apdcorga) RETURNING g_apce2_d[l_ac].apdcorga_desc
                     DISPLAY BY NAME g_apce2_d[l_ac].apdcorga_desc
                     #160908-00045#1--add(e)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160908-00045#1--add(s)
            CALL s_desc_get_department_desc(g_apce2_d[l_ac].apdcorga) RETURNING g_apce2_d[l_ac].apdcorga_desc
            DISPLAY BY NAME g_apce2_d[l_ac].apdcorga_desc
            #160908-00045#1--add(e)
            DISPLAY BY NAME g_apce2_d[l_ac].apdcorga
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcorga
            #add-point:BEFORE FIELD apdcorga name="input.b.page2.apdcorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdcorga
            #add-point:ON CHANGE apdcorga name="input.g.page2.apdcorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc002
            #add-point:BEFORE FIELD apdc002 name="input.b.page2.apdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc002
            
            #add-point:AFTER FIELD apdc002 name="input.a.page2.apdc002"
            IF NOT cl_null(g_apce2_d[l_ac].apdc002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce2_d[l_ac].apdc002 != g_apce2_d_t.apdc002 OR g_apce2_d_t.apdc002 IS NULL )) THEN
                  IF NOT cl_null(g_apce2_d[l_ac].apdcorga) AND NOT cl_null(g_apce2_d[l_ac].apdc003) THEN
                    #CALL aapt430_apdc002_chk(l_ac,g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003)RETURNING g_sub_success,g_errno   #160816-00022#1 mark
                     CALL s_aapt430_apdc002_chk(g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003,g_apda_m.apdadocno,g_apda_m.apdald)  #160816-00022#1 
                      RETURNING g_sub_success,g_errno                                                                                                         #160816-00022#1                      
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apce2_d[l_ac].apdc002 = g_apce2_d_t.apdc002
                        NEXT FIELD CURRENT
                     END IF
                     #帶出其他資料
                     CALL aapt430_source_doc_carry2(g_apda_m.apdald,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc002
            #add-point:ON CHANGE apdc002 name="input.g.page2.apdc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc003
            #add-point:BEFORE FIELD apdc003 name="input.b.page2.apdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc003
            
            #add-point:AFTER FIELD apdc003 name="input.a.page2.apdc003"
            IF NOT cl_null(g_apce2_d[l_ac].apdc003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' 
                  AND (g_apce2_d[l_ac].apdc003 != g_apce2_d_t.apdc003 OR g_apce2_d_t.apdc003 IS NULL )) THEN
                  IF NOT cl_null(g_apce2_d[l_ac].apdcorga) AND NOT cl_null(g_apce2_d[l_ac].apdc002) THEN    
                    #CALL aapt430_apdc002_chk(l_ac,g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003)RETURNING g_sub_success,g_errno   #160816-00022#1 mark
                     CALL s_aapt430_apdc002_chk(g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003,g_apda_m.apdadocno,g_apda_m.apdald)  #160816-00022#1 
                      RETURNING g_sub_success,g_errno                                                                                                         #160816-00022#1                      
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apce2_d[l_ac].apdc003 = g_apce2_d_t.apdc003
                        NEXT FIELD CURRENT
                     END IF
                     #帶出其他資料
                     CALL aapt430_source_doc_carry2(g_apda_m.apdald,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc003
            #add-point:ON CHANGE apdc003 name="input.g.page2.apdc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc004
            #add-point:BEFORE FIELD apdc004 name="input.b.page2.apdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc004
            
            #add-point:AFTER FIELD apdc004 name="input.a.page2.apdc004"
            #產品編號
            IF NOT cl_null(g_apce2_d[l_ac].apdc004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce2_d[l_ac].apdc004 != g_apce2_d_t.apdc004 OR g_apce2_d_t.apdc004 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc004 != g_apce2_d_o.apdc004 OR cl_null(g_apce2_d_o.apdc004) THEN                                      #160822-00008#3
                  CALL s_aimm200_chk_item(g_apce2_d[l_ac].apdc004) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apce2_d[l_ac].apdc004 = g_apce2_d_t.apdc004
                     NEXT FIELD CURRENT
                  END IF
                  
                  #161114-00017#2 --s add 
                  LET l_apdc004_comp = ''
                  SELECT glaacomp INTO l_apdc004_comp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_apda_m.apdald
                  #161114-00017#2 --e add                  
                  
                  #檢核該料件是否存在該營運據點
                  INITIALIZE g_chkparam.* TO NULL
                  #LET g_chkparam.arg1 = g_apda_m.apdasite        #161114-00017#2 mark
                  LET g_chkparam.arg1 = l_apdc004_comp            #161114-00017#2 add
                  LET g_chkparam.arg2 = g_apce2_d[l_ac].apdc004
                  IF NOT cl_chk_exist("v_imaf001_3") THEN
                     #LET g_apce2_d[l_ac].apdc004 = g_apce2_d_t.apdc004  #160822-00008#3  mark
                     LET g_apce2_d[l_ac].apdc004 = g_apce2_d_o.apdc004   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  
                  #同單據不可重覆產品號碼
                  SELECT COUNT(*) INTO l_cnt
                    FROM apdc_t
                   WHERE apdcent = g_enterprise
                     AND apdcld = g_apda_m.apdald
                     AND apdcdocno = g_apda_m.apdadocno
                     AND apdc004 = g_apce2_d[l_ac].apdc004
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00297'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apce2_d[l_ac].apdc004 = g_apce2_d_t.apdc004  #160822-00008#3  mark
                     LET g_apce2_d[l_ac].apdc004 = g_apce2_d_o.apdc004   #160822-00008#3
                     LET g_apce2_d[l_ac].imaal003 = ''
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓取產品名稱
                  CALL s_desc_get_item_desc(g_apce2_d[l_ac].apdc004)
                       RETURNING g_apce2_d[l_ac].imaal003,l_str
                  IF cl_null(g_apce2_d[l_ac].imaal003) AND NOT cl_null(l_str) THEN
                     LET g_apce2_d[l_ac].imaal003 = l_str
                  END IF
                  IF NOT cl_null(g_apce2_d[l_ac].imaal003) AND NOT cl_null(l_str) THEN
                     LET g_apce2_d[l_ac].imaal003 = g_apce2_d[l_ac].imaal003,"/",l_str
                  END IF
                  
                  #抓取數量&分攤成本
                  #期末結存數量/期末結存金額
                  #160628-00001#1 add ------
                  #目的分攤方式 = 2:依產品號碼
                  IF g_apda_m.apda019 = '2' THEN
                     #先取得日期是屬於哪個年度期別
                     CALL s_fin_date_get_period_value('',g_apda_m.apdald,g_apda_m.apdadocdt)
                          RETURNING g_sub_success,l_year,l_month
                     #再取得該年度期別的上一期
                     CALL s_fin_date_get_last_period('',g_apda_m.apdald,l_year,l_month)
                          RETURNING g_sub_success,l_year,l_month
                     LET g_sql = "SELECT SUM(xccc901),SUM(xccc902)",
                                 "  FROM xccc_t",
                                 " WHERE xcccent= ",g_enterprise,
                                 "   AND xccccomp= '",g_apda_m.apdacomp,"'",
                                 "   AND xcccld  = '",g_apda_m.apdald,"'",
                                 "   AND xccc004 = ",l_year,   #年度
                                 "   AND xccc005 = ",l_month,  #期別
                                 "   AND xccc006 = '",g_apce2_d[l_ac].apdc004,"'",
                                 "   AND xccc003 = '",g_glaa.glaa120,"'"
                  ELSE
                  #160628-00001#1 add end---
                     LET g_sql = "SELECT SUM(xccc901),SUM(xccc902)",
                                 "  FROM xccc_t",
                                 " WHERE xcccent= ",g_enterprise,
                                 "   AND xccccomp= '",g_apda_m.apdacomp,"'",
                                 "   AND xcccld  = '",g_apda_m.apdald,"'",
                                 "   AND (xccc004*100+xccc005) <= (",YEAR(g_apda_m.apdadocdt)*100+MONTH(g_apda_m.apdadocdt),")",
                                 "   AND xccc006 = '",g_apce2_d[l_ac].apdc004,"'"
                  END IF #160628-00001#1
                  PREPARE sel_aaa FROM g_sql
                  DECLARE sel_bbb2 CURSOR FOR sel_aaa
                  EXECUTE sel_bbb2 INTO g_apce2_d[l_ac].apdc008,g_apce2_d[l_ac].apdc113
                  IF cl_null(g_apce2_d[l_ac].apdc113) THEN
                     #取不到成本價的,提示訊息"無成本金額結算數值可參考。"
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00298'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apce2_d[l_ac].apdc008 = 0
                     LET g_apce2_d[l_ac].apdc113 = 0
                  ELSE
                     #計算分攤前單價
                     LET g_apce2_d[l_ac].apdc111 = g_apce2_d[l_ac].apdc113 / g_apce2_d[l_ac].apdc008
                     #取位
                     CALL s_ld_sel_glaa(g_apda_m.apdald,'glaa001') RETURNING g_sub_success,l_glaa001
                     #Reanna 15/02/03
                     #CALL s_curr_round_ld('1',g_apda_m.apdald,l_glaa001,g_apce2_d[l_ac].apdc111,2)
                     CALL s_curr_round_ld('1',g_apda_m.apdald,l_glaa001,g_apce2_d[l_ac].apdc111,1)
                          RETURNING g_sub_success,g_errno,g_apce2_d[l_ac].apdc111
                  END IF
                  #抓會計科目
                  IF cl_null(g_apce2_d[l_ac].apdc007) THEN
                     CALL s_get_item_acc(g_apda_m.apdald,'1',g_apce2_d[l_ac].apdc007,'','','','')
                          RETURNING g_sub_success,g_apce2_d[l_ac].apdc007
                  END IF
               END IF
            END IF
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc004
            #add-point:ON CHANGE apdc004 name="input.g.page2.apdc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc009
            #add-point:BEFORE FIELD apdc009 name="input.b.page2.apdc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc009
            
            #add-point:AFTER FIELD apdc009 name="input.a.page2.apdc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc009
            #add-point:ON CHANGE apdc009 name="input.g.page2.apdc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc111
            #add-point:BEFORE FIELD apdc111 name="input.b.page2.apdc111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc111
            
            #add-point:AFTER FIELD apdc111 name="input.a.page2.apdc111"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc111
            #add-point:ON CHANGE apdc111 name="input.g.page2.apdc111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc113
            #add-point:BEFORE FIELD apdc113 name="input.b.page2.apdc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc113
            
            #add-point:AFTER FIELD apdc113 name="input.a.page2.apdc113"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc113
            #add-point:ON CHANGE apdc113 name="input.g.page2.apdc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc211
            #add-point:BEFORE FIELD apdc211 name="input.b.page2.apdc211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc211
            
            #add-point:AFTER FIELD apdc211 name="input.a.page2.apdc211"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc211
            #add-point:ON CHANGE apdc211 name="input.g.page2.apdc211"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc213
            #add-point:BEFORE FIELD apdc213 name="input.b.page2.apdc213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc213
            
            #add-point:AFTER FIELD apdc213 name="input.a.page2.apdc213"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc213
            #add-point:ON CHANGE apdc213 name="input.g.page2.apdc213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc123
            #add-point:BEFORE FIELD apdc123 name="input.b.page2.apdc123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc123
            
            #add-point:AFTER FIELD apdc123 name="input.a.page2.apdc123"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc123
            #add-point:ON CHANGE apdc123 name="input.g.page2.apdc123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc223
            #add-point:BEFORE FIELD apdc223 name="input.b.page2.apdc223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc223
            
            #add-point:AFTER FIELD apdc223 name="input.a.page2.apdc223"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc223
            #add-point:ON CHANGE apdc223 name="input.g.page2.apdc223"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc133
            #add-point:BEFORE FIELD apdc133 name="input.b.page2.apdc133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc133
            
            #add-point:AFTER FIELD apdc133 name="input.a.page2.apdc133"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc133
            #add-point:ON CHANGE apdc133 name="input.g.page2.apdc133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc233
            #add-point:BEFORE FIELD apdc233 name="input.b.page2.apdc233"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc233
            
            #add-point:AFTER FIELD apdc233 name="input.a.page2.apdc233"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc233
            #add-point:ON CHANGE apdc233 name="input.g.page2.apdc233"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc005
            #add-point:BEFORE FIELD apdc005 name="input.b.page2.apdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc005
            
            #add-point:AFTER FIELD apdc005 name="input.a.page2.apdc005"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc005
            #add-point:ON CHANGE apdc005 name="input.g.page2.apdc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc006
            #add-point:BEFORE FIELD apdc006 name="input.b.page2.apdc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc006
            
            #add-point:AFTER FIELD apdc006 name="input.a.page2.apdc006"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc006
            #add-point:ON CHANGE apdc006 name="input.g.page2.apdc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc041
            #add-point:BEFORE FIELD apdc041 name="input.b.page2.apdc041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc041
            
            #add-point:AFTER FIELD apdc041 name="input.a.page2.apdc041"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc041
            #add-point:ON CHANGE apdc041 name="input.g.page2.apdc041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc007
            #add-point:BEFORE FIELD apdc007 name="input.b.page2.apdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc007
            
            #add-point:AFTER FIELD apdc007 name="input.a.page2.apdc007"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc007
            #add-point:ON CHANGE apdc007 name="input.g.page2.apdc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc007_desc
            #add-point:BEFORE FIELD apdc007_desc name="input.b.page2.apdc007_desc"
            LET g_apce2_d[l_ac].apdc007_desc = g_apce2_d[l_ac].apdc007   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc007_desc
            
            #add-point:AFTER FIELD apdc007_desc name="input.a.page2.apdc007_desc"
            IF NOT cl_null(g_apce2_d[l_ac].apdc007_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apda_m.apdald,g_apce2_d[l_ac].apdc007_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apda_m.apdald
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apce2_d[l_ac].apdc007_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apce2_d[l_ac].apdc007_desc
                LET g_qryparam.arg3 = g_apda_m.apdald
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                 LET g_apce2_d[l_ac].apdc007      = g_qryparam.return1
                LET g_apce2_d[l_ac].apdc007_desc = g_qryparam.return1
                DISPLAY BY NAME g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc007_desc
              END IF
              IF NOT s_aglt310_lc_subject(g_apda_m.apdald,g_apce2_d[l_ac].apdc007_desc,'N') THEN
                   #LET g_apce2_d[l_ac].apdc007      = g_apce2_d_t.apdc007       #160822-00008#3  mark
                     #LET g_apce2_d[l_ac].apdc007_desc = g_apce2_d_t.apdc007_desc  #160822-00008#3  mark
                     LET g_apce2_d[l_ac].apdc007      = g_apce2_d_o.apdc007        #160822-00008#3
                     LET g_apce2_d[l_ac].apdc007_desc = g_apce2_d_o.apdc007_desc   #160822-00008#3
                     DISPLAY BY NAME g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc007_desc
                     NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               #IF ( g_apce2_d[l_ac].apdc007_desc != g_apce2_d_t.apdc007_desc OR g_apce2_d_t.apdc007_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc007_desc != g_apce2_d_o.apdc007_desc OR cl_null(g_apce2_d_o.apdc007_desc) THEN     #160822-00008#3
                  LET g_apce2_d[l_ac].apdc007 = g_apce2_d[l_ac].apdc007_desc
                  CALL s_aap_glac002_chk(g_apce2_d[l_ac].apdc007,g_apda_m.apdald) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apce2_d[l_ac].apdc007      = g_apce2_d_t.apdc007       #160822-00008#3  mark
                     #LET g_apce2_d[l_ac].apdc007_desc = g_apce2_d_t.apdc007_desc  #160822-00008#3  mark
                     LET g_apce2_d[l_ac].apdc007      = g_apce2_d_o.apdc007        #160822-00008#3
                     LET g_apce2_d[l_ac].apdc007_desc = g_apce2_d_o.apdc007_desc   #160822-00008#3
                     DISPLAY BY NAME g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #取得自由核算項資訊 #150330
               #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'ALL') RETURNING g_glad.*
               CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
                    RETURNING g_errno,g_glad.*
            ELSE
               INITIALIZE g_glad.* TO NULL
               LET g_apce2_d[l_ac].apdc007 = ''
            END IF
            LET g_apce2_d[l_ac].apdc007_desc = s_desc_show1(g_apce2_d[l_ac].apdc007,s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apdc007))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc007 ,g_apce2_d[l_ac].apdc007_desc
            LET g_apce2_d_t.apdc007_desc = g_apce2_d[l_ac].apdc007_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc007_desc
            #add-point:ON CHANGE apdc007_desc name="input.g.page2.apdc007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc017
            #add-point:BEFORE FIELD apdc017 name="input.b.page2.apdc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc017
            
            #add-point:AFTER FIELD apdc017 name="input.a.page2.apdc017"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc017
            #add-point:ON CHANGE apdc017 name="input.g.page2.apdc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc017_desc
            #add-point:BEFORE FIELD apdc017_desc name="input.b.page2.apdc017_desc"
             LET g_apce2_d[l_ac].apdc017_desc = g_apce2_d[l_ac].apdc017   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc017_desc
            
            #add-point:AFTER FIELD apdc017_desc name="input.a.page2.apdc017_desc"
            #業務人員
            IF NOT cl_null(g_apce2_d[l_ac].apdc017_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc017_desc != g_apce2_d_t.apdc017_desc OR g_apce2_d_t.apdc017_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc017_desc != g_apce2_d_o.apdc017_desc OR cl_null(g_apce2_d_o.apdc017_desc) THEN     #160822-00008#3
                  LET g_apce2_d[l_ac].apdc017 = g_apce2_d[l_ac].apdc017_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_employee_chk(g_apce2_d[l_ac].apdc017_desc) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        #LET g_apce2_d[l_ac].apdc017      = g_apce2_d_t.apdc017       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc017_desc = g_apce2_d_t.apdc017_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc017      = g_apce2_d_o.apdc017        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc017_desc = g_apce2_d_o.apdc017_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc017 ,g_apce2_d[l_ac].apdc017_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #160726-00020#14 ---(S)
               IF cl_null(g_apce2_d[l_ac].apdc018_desc) THEN
                  SELECT ooag003 INTO g_apce2_d[l_ac].apdc018 FROM ooag_t
                   WHERE ooagent = g_enterprise AND ooag001 = g_apce2_d[l_ac].apdc017_desc
               END IF
               #160726-00020#14 ---(E)
            ELSE
               LET g_apce2_d[l_ac].apdc017 = ''
            END IF
            LET g_apce2_d[l_ac].apdc017_desc = s_desc_show1(g_apce2_d[l_ac].apdc017,s_desc_get_person_desc(g_apce2_d[l_ac].apdc017))         
            DISPLAY BY NAME g_apce2_d[l_ac].apdc017 ,g_apce2_d[l_ac].apdc017_desc
            LET g_apce2_d_t.apdc017_desc = g_apce2_d[l_ac].apdc017_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc017_desc
            #add-point:ON CHANGE apdc017_desc name="input.g.page2.apdc017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc018
            #add-point:BEFORE FIELD apdc018 name="input.b.page2.apdc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc018
            
            #add-point:AFTER FIELD apdc018 name="input.a.page2.apdc018"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc018
            #add-point:ON CHANGE apdc018 name="input.g.page2.apdc018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc018_desc
            #add-point:BEFORE FIELD apdc018_desc name="input.b.page2.apdc018_desc"
             LET g_apce2_d[l_ac].apdc018_desc = g_apce2_d[l_ac].apdc018   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc018_desc
            
            #add-point:AFTER FIELD apdc018_desc name="input.a.page2.apdc018_desc"
            #部門
            IF NOT cl_null(g_apce2_d[l_ac].apdc018_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc018_desc != g_apce2_d_t.apdc018_desc OR g_apce2_d_t.apdc018_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc018_desc != g_apce2_d_o.apdc018_desc OR cl_null(g_apce2_d_o.apdc018_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc018 = g_apce2_d[l_ac].apdc018_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_department_chk(g_apce2_d[l_ac].apdc018_desc,g_apda_m.apdadocdt) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        #LET g_apce2_d[l_ac].apdc018      = g_apce2_d_t.apdc018       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc018_desc = g_apce2_d_t.apdc018_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc018      = g_apce2_d_o.apdc018        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc018_desc = g_apce2_d_o.apdc018_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc018 ,g_apce2_d[l_ac].apdc018_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc018 = ''
            END IF
            LET g_apce2_d[l_ac].apdc018_desc = s_desc_show1(g_apce2_d[l_ac].apdc018,s_desc_get_department_desc(g_apce2_d[l_ac].apdc018))         
            DISPLAY BY NAME g_apce2_d[l_ac].apdc018 ,g_apce2_d[l_ac].apdc018_desc
            LET g_apce2_d_t.apdc018_desc = g_apce2_d[l_ac].apdc018_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc018_desc
            #add-point:ON CHANGE apdc018_desc name="input.g.page2.apdc018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc019
            #add-point:BEFORE FIELD apdc019 name="input.b.page2.apdc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc019
            
            #add-point:AFTER FIELD apdc019 name="input.a.page2.apdc019"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc019
            #add-point:ON CHANGE apdc019 name="input.g.page2.apdc019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc019_desc
            #add-point:BEFORE FIELD apdc019_desc name="input.b.page2.apdc019_desc"
            LET g_apce2_d[l_ac].apdc019_desc = g_apce2_d[l_ac].apdc019   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc019_desc
            
            #add-point:AFTER FIELD apdc019_desc name="input.a.page2.apdc019_desc"
            #責任中心
            IF NOT cl_null(g_apce2_d[l_ac].apdc019_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc019_desc != g_apce2_d_t.apdc019_desc OR g_apce2_d_t.apdc019_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc019_desc != g_apce2_d_o.apdc019_desc OR cl_null(g_apce2_d_o.apdc019_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc019 = g_apce2_d[l_ac].apdc019_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #CALL s_department_chk(g_apce2_d[l_ac].apdc019_desc,g_apda_m.apdadocdt) RETURNING g_sub_success #140806-00012#8 mark
                     CALL s_voucher_glaq019_chk(g_apce2_d[l_ac].apdc019_desc,g_apda_m.apdadocdt) #140806-00012#8
                     IF NOT g_sub_success THEN
                        #LET g_apce2_d[l_ac].apdc019      = g_apce2_d_t.apdc019       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc019_desc = g_apce2_d_t.apdc019_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc019      = g_apce2_d_o.apdc019        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc019_desc = g_apce2_d_o.apdc019_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc019 ,g_apce2_d[l_ac].apdc019_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc019 = ''
            END IF
            LET g_apce2_d[l_ac].apdc019_desc = s_desc_show1(g_apce2_d[l_ac].apdc019,s_desc_get_department_desc(g_apce2_d[l_ac].apdc019))         
            DISPLAY BY NAME g_apce2_d[l_ac].apdc019 ,g_apce2_d[l_ac].apdc019_desc
            LET g_apce2_d_t.apdc019_desc = g_apce2_d[l_ac].apdc019_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc019_desc
            #add-point:ON CHANGE apdc019_desc name="input.g.page2.apdc019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc020
            #add-point:BEFORE FIELD apdc020 name="input.b.page2.apdc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc020
            
            #add-point:AFTER FIELD apdc020 name="input.a.page2.apdc020"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc020
            #add-point:ON CHANGE apdc020 name="input.g.page2.apdc020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc020_desc
            #add-point:BEFORE FIELD apdc020_desc name="input.b.page2.apdc020_desc"
            LET g_apce2_d[l_ac].apdc020_desc = g_apce2_d[l_ac].apdc020   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc020_desc
            
            #add-point:AFTER FIELD apdc020_desc name="input.a.page2.apdc020_desc"
            #產品類別
            IF NOT cl_null(g_apce2_d[l_ac].apdc020_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc020_desc != g_a pce2_d_t.apdc020_desc OR g_apce2_d_t.apdc020_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc020_desc != g_apce2_d_o.apdc020_desc OR cl_null(g_apce2_d_o.apdc020_desc) THEN       #160822-00008#3
                  LET g_apce2_d[l_ac].apdc020 = g_apce2_d[l_ac].apdc020_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq024_chk(g_apce2_d[l_ac].apdc020)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno                        
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'arti202'
                        LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                        LET g_errparam.exeprog = 'arti202'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_apce2_d[l_ac].apdc020      = g_apce2_d_t.apdc020       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc020_desc = g_apce2_d_t.apdc020_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc020      = g_apce2_d_o.apdc020        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc020_desc = g_apce2_d_o.apdc020_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc020 ,g_apce2_d[l_ac].apdc020_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc020 = ''
            END IF
            LET g_apce2_d[l_ac].apdc020_desc = s_desc_show1(g_apce2_d[l_ac].apdc020,s_desc_get_rtaxl003_desc(g_apce2_d[l_ac].apdc020))      
            DISPLAY BY NAME g_apce2_d[l_ac].apdc020 ,g_apce2_d[l_ac].apdc020_desc
            LET g_apce2_d_t.apdc020_desc = g_apce2_d[l_ac].apdc020_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc020_desc
            #add-point:ON CHANGE apdc020_desc name="input.g.page2.apdc020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc022
            #add-point:BEFORE FIELD apdc022 name="input.b.page2.apdc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc022
            
            #add-point:AFTER FIELD apdc022 name="input.a.page2.apdc022"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc022
            #add-point:ON CHANGE apdc022 name="input.g.page2.apdc022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc022_desc
            #add-point:BEFORE FIELD apdc022_desc name="input.b.page2.apdc022_desc"
            LET g_apce2_d[l_ac].apdc022_desc = g_apce2_d[l_ac].apdc022   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc022_desc
            
            #add-point:AFTER FIELD apdc022_desc name="input.a.page2.apdc022_desc"
            #專案代號
            IF NOT cl_null(g_apce2_d[l_ac].apdc022_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc022_desc != g_apce2_d_t.apdc022_desc OR g_apce2_d_t.apdc022_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc022_desc != g_apce2_d_o.apdc022_desc OR cl_null(g_apce2_d_o.apdc022_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc022 = g_apce2_d[l_ac].apdc022_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_aap_project_chk(g_apce2_d[l_ac].apdc022) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        #160321-00016#20 --s add
                        LET g_errparam.replace[1] = 'apjm200'
                        LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                        LET g_errparam.exeprog = 'apjm200'
                        #160321-00016#20 --e add
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apce2_d[l_ac].apdc022      = g_apce2_d_t.apdc022       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc022_desc = g_apce2_d_t.apdc022_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc022      = g_apce2_d_o.apdc022        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc022_desc = g_apce2_d_o.apdc022_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc022 ,g_apce2_d[l_ac].apdc022_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc022 = ''
            END IF
            LET g_apce2_d[l_ac].apdc022_desc = s_desc_show1(g_apce2_d[l_ac].apdc022,s_desc_get_project_desc(g_apce2_d[l_ac].apdc022))      
            DISPLAY BY NAME g_apce2_d[l_ac].apdc022 ,g_apce2_d[l_ac].apdc022_desc
            LET g_apce2_d_t.apdc022_desc = g_apce2_d[l_ac].apdc022_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc022_desc
            #add-point:ON CHANGE apdc022_desc name="input.g.page2.apdc022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc023
            #add-point:BEFORE FIELD apdc023 name="input.b.page2.apdc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc023
            
            #add-point:AFTER FIELD apdc023 name="input.a.page2.apdc023"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc023
            #add-point:ON CHANGE apdc023 name="input.g.page2.apdc023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc023_desc
            #add-point:BEFORE FIELD apdc023_desc name="input.b.page2.apdc023_desc"
            LET g_apce2_d[l_ac].apdc023_desc = g_apce2_d[l_ac].apdc023   #140806-00012#8
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc023_desc
            
            #add-point:AFTER FIELD apdc023_desc name="input.a.page2.apdc023_desc"
            #140806-00012#8 add---
            #WBS
            IF NOT cl_null(g_apce2_d[l_ac].apdc023_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc023_desc != g_apce2_d_t.apdc023_desc OR g_apce2_d_t.apdc023_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc023_desc != g_apce2_d_o.apdc023_desc OR cl_null(g_apce2_d_o.apdc023_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc023 = g_apce2_d[l_ac].apdc023_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq028_chk(g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023)
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apce2_d[l_ac].apdc023      = g_apce2_d_t.apdc023       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc023_desc = g_apce2_d_t.apdc023_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc023      = g_apce2_d_o.apdc023        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc023_desc = g_apce2_d_o.apdc023_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc023 ,g_apce2_d[l_ac].apdc023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
                LET g_apce2_d[l_ac].apdc023 = ''
            END IF
            LET g_apce2_d[l_ac].apdc023_desc = s_desc_show1(g_apce2_d[l_ac].apdc023,s_desc_get_pjbbl004_desc(g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc023 ,g_apce2_d[l_ac].apdc023_desc 
            LET g_apce2_d_t.apdc023_desc = g_apce2_d[l_ac].apdc023_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc023_desc
            #add-point:ON CHANGE apdc023_desc name="input.g.page2.apdc023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc024
            #add-point:BEFORE FIELD apdc024 name="input.b.page2.apdc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc024
            
            #add-point:AFTER FIELD apdc024 name="input.a.page2.apdc024"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc024
            #add-point:ON CHANGE apdc024 name="input.g.page2.apdc024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc024_desc
            #add-point:BEFORE FIELD apdc024_desc name="input.b.page2.apdc024_desc"
            LET g_apce2_d[l_ac].apdc024_desc = g_apce2_d[l_ac].apdc024   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc024_desc
            
            #add-point:AFTER FIELD apdc024_desc name="input.a.page2.apdc024_desc"
            #區域
            IF NOT cl_null(g_apce2_d[l_ac].apdc024_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc024_desc != g_apce2_d_t.apdc024_desc OR g_apce2_d_t.apdc024_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc024_desc != g_apce2_d_o.apdc024_desc OR cl_null(g_apce2_d_o.apdc024_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc024 = g_apce2_d[l_ac].apdc024_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('287',g_apce2_d[l_ac].apdc024) THEN
                        #LET g_apce2_d[l_ac].apdc024      = g_apce2_d_t.apdc024       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc024_desc = g_apce2_d_t.apdc024_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc024      = g_apce2_d_o.apdc024        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc024_desc = g_apce2_d_o.apdc024_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc024 ,g_apce2_d[l_ac].apdc024_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc024 = ''
            END IF
            LET g_apce2_d[l_ac].apdc024_desc = s_desc_show1(g_apce2_d[l_ac].apdc024,s_desc_get_acc_desc('287',g_apce2_d[l_ac].apdc024))      
            DISPLAY BY NAME g_apce2_d[l_ac].apdc024 ,g_apce2_d[l_ac].apdc024_desc
            LET g_apce2_d_t.apdc024_desc = g_apce2_d[l_ac].apdc024_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc024_desc
            #add-point:ON CHANGE apdc024_desc name="input.g.page2.apdc024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc025
            #add-point:BEFORE FIELD apdc025 name="input.b.page2.apdc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc025
            
            #add-point:AFTER FIELD apdc025 name="input.a.page2.apdc025"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc025
            #add-point:ON CHANGE apdc025 name="input.g.page2.apdc025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc025_desc
            #add-point:BEFORE FIELD apdc025_desc name="input.b.page2.apdc025_desc"
            LET g_apce2_d[l_ac].apdc025_desc = g_apce2_d[l_ac].apdc025   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc025_desc
            
            #add-point:AFTER FIELD apdc025_desc name="input.a.page2.apdc025_desc"
            #客群
            IF NOT cl_null(g_apce2_d[l_ac].apdc025_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc025_desc != g_apce2_d_t.apdc025_desc OR g_apce2_d_t.apdc025_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc025_desc != g_apce2_d_o.apdc025_desc OR cl_null(g_apce2_d_o.apdc025_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc025 = g_apce2_d[l_ac].apdc025_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('281',g_apce2_d[l_ac].apdc025) THEN
                        #LET g_apce2_d[l_ac].apdc025      = g_apce2_d_t.apdc025       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc025_desc = g_apce2_d_t.apdc025_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc025      = g_apce2_d_o.apdc025        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc025_desc = g_apce2_d_o.apdc025_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc025 ,g_apce2_d[l_ac].apdc025_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc025 = ''
            END IF
            LET g_apce2_d[l_ac].apdc025_desc = s_desc_show1(g_apce2_d[l_ac].apdc025,s_desc_get_acc_desc('281',g_apce2_d[l_ac].apdc025))      
            DISPLAY BY NAME g_apce2_d[l_ac].apdc025 ,g_apce2_d[l_ac].apdc025_desc
            LET g_apce2_d_t.apdc025_desc = g_apce2_d[l_ac].apdc025_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc025_desc
            #add-point:ON CHANGE apdc025_desc name="input.g.page2.apdc025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc027
            #add-point:BEFORE FIELD apdc027 name="input.b.page2.apdc027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc027
            
            #add-point:AFTER FIELD apdc027 name="input.a.page2.apdc027"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc027
            #add-point:ON CHANGE apdc027 name="input.g.page2.apdc027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc027_desc
            #add-point:BEFORE FIELD apdc027_desc name="input.b.page2.apdc027_desc"
            LET g_apce2_d[l_ac].apdc027_desc = g_apce2_d[l_ac].apdc027   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc027_desc
            
            #add-point:AFTER FIELD apdc027_desc name="input.a.page2.apdc027_desc"
            #經營方式
            IF NOT cl_null(g_apce2_d[l_ac].apdc027_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc027_desc != g_apce2_d_t.apdc027_desc OR g_apce2_d_t.apdc027_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc027_desc != g_apce2_d_o.apdc027_desc OR cl_null(g_apce2_d_o.apdc027_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc027 = g_apce2_d[l_ac].apdc027_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq051_chk(g_apce2_d[l_ac].apdc027) 
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apce2_d[l_ac].apdc027      = g_apce2_d_t.apdc027       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc027_desc = g_apce2_d_t.apdc027_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc027      = g_apce2_d_o.apdc027        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc027_desc = g_apce2_d_o.apdc027_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc027 ,g_apce2_d[l_ac].apdc027_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc027 = ''
            END IF
            DISPLAY BY NAME g_apce2_d[l_ac].apdc027 ,g_apce2_d[l_ac].apdc027_desc
            LET g_apce2_d_t.apdc027_desc = g_apce2_d[l_ac].apdc027_desc  
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc027_desc
            #add-point:ON CHANGE apdc027_desc name="input.g.page2.apdc027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc028
            #add-point:BEFORE FIELD apdc028 name="input.b.page2.apdc028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc028
            
            #add-point:AFTER FIELD apdc028 name="input.a.page2.apdc028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc028
            #add-point:ON CHANGE apdc028 name="input.g.page2.apdc028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc028_desc
            #add-point:BEFORE FIELD apdc028_desc name="input.b.page2.apdc028_desc"
            LET g_apce2_d[l_ac].apdc028_desc = g_apce2_d[l_ac].apdc028   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc028_desc
            
            #add-point:AFTER FIELD apdc028_desc name="input.a.page2.apdc028_desc"
            #渠道
            IF NOT cl_null(g_apce2_d[l_ac].apdc028_desc) THEN
               IF ( g_apce2_d[l_ac].apdc028_desc != g_apce2_d_t.apdc028_desc OR g_apce2_d_t.apdc028_desc IS NULL ) THEN
                  LET g_apce2_d[l_ac].apdc028 = g_apce2_d[l_ac].apdc028_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #CALL s_aap_oojd001_chk(g_apce2_d[l_ac].apdc028) RETURNING g_sub_success,g_errno #140806-00012#8 mark
                     CALL s_voucher_glaq052_chk(g_apce2_d[l_ac].apdc028)  #140806-00012#8
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apce2_d[l_ac].apdc028 = g_apce2_d_t.apdc028
                        LET g_apce2_d[l_ac].apdc028_desc = g_apce2_d_t.apdc028_desc
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc028,g_apce2_d[l_ac].apdc028_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc028 = ''
            END IF
            LET g_apce2_d[l_ac].apdc028_desc = s_desc_show1(g_apce2_d[l_ac].apdc028,s_desc_get_oojdl003_desc(g_apce2_d[l_ac].apdc028))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc028,g_apce2_d[l_ac].apdc028_desc
            LET g_apce2_d_t.apdc028_desc = g_apce2_d[l_ac].apdc028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc028_desc
            #add-point:ON CHANGE apdc028_desc name="input.g.page2.apdc028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc029
            #add-point:BEFORE FIELD apdc029 name="input.b.page2.apdc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc029
            
            #add-point:AFTER FIELD apdc029 name="input.a.page2.apdc029"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc029
            #add-point:ON CHANGE apdc029 name="input.g.page2.apdc029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc029_desc
            #add-point:BEFORE FIELD apdc029_desc name="input.b.page2.apdc029_desc"
            LET g_apce2_d[l_ac].apdc029_desc = g_apce2_d[l_ac].apdc029   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc029_desc
            
            #add-point:AFTER FIELD apdc029_desc name="input.a.page2.apdc029_desc"
            #品牌
            IF NOT cl_null(g_apce2_d[l_ac].apdc029_desc) THEN
               #IF ( g_apce2_d[l_ac].apdc029_desc != g_apce2_d_t.apdc029_desc OR g_apce2_d_t.apdc029_desc IS NULL ) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc029_desc != g_apce2_d_o.apdc029_desc OR cl_null(g_apce2_d_o.apdc029_desc) THEN      #160822-00008#3
                  LET g_apce2_d[l_ac].apdc029 = g_apce2_d[l_ac].apdc029_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('2002',g_apce2_d[l_ac].apdc029) THEN
                        #LET g_apce2_d[l_ac].apdc029      = g_apce2_d_t.apdc029       #160822-00008#3  mark
                        #LET g_apce2_d[l_ac].apdc029_desc = g_apce2_d_t.apdc029_desc  #160822-00008#3  mark
                        LET g_apce2_d[l_ac].apdc029      = g_apce2_d_o.apdc029        #160822-00008#3
                        LET g_apce2_d[l_ac].apdc029_desc = g_apce2_d_o.apdc029_desc   #160822-00008#3
                        DISPLAY BY NAME g_apce2_d[l_ac].apdc029 ,g_apce2_d[l_ac].apdc029_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc029 = ''
            END IF
            LET g_apce2_d[l_ac].apdc029_desc = s_desc_show1(g_apce2_d[l_ac].apdc029,s_desc_get_acc_desc('2002',g_apce2_d[l_ac].apdc029))      
            DISPLAY BY NAME g_apce2_d[l_ac].apdc029 ,g_apce2_d[l_ac].apdc029_desc
            LET g_apce2_d_t.apdc029_desc = g_apce2_d[l_ac].apdc029_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc029_desc
            #add-point:ON CHANGE apdc029_desc name="input.g.page2.apdc029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc031
            #add-point:BEFORE FIELD apdc031 name="input.b.page2.apdc031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc031
            
            #add-point:AFTER FIELD apdc031 name="input.a.page2.apdc031"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc031
            #add-point:ON CHANGE apdc031 name="input.g.page2.apdc031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc031_desc
            #add-point:BEFORE FIELD apdc031_desc name="input.b.page2.apdc031_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc031_desc = g_apce2_d[l_ac].apdc031   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc031_desc
            
            #add-point:AFTER FIELD apdc031_desc name="input.a.page2.apdc031_desc"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc031_desc
            #add-point:ON CHANGE apdc031_desc name="input.g.page2.apdc031_desc"
            #自由核算項一
            IF NOT cl_null(g_apce2_d[l_ac].apdc031_desc) THEN
               IF (g_apce2_d[l_ac].apdc031_desc != g_apce2_d_t.apdc031_desc OR g_apce2_d_t.apdc031_desc IS NULL) THEN
                  LET g_apce2_d[l_ac].apdc031 = g_apce2_d[l_ac].apdc031_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce2_d[l_ac].apdc031 != g_apce2_d_t.apdc031 OR g_apce2_d_t.apdc031 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_apce2_d[l_ac].apdc031,g_glad.glad0172) RETURNING g_errno
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
                           LET g_apce2_d[l_ac].apdc031 = g_apce2_d_t.apdc031
                           LET g_apce2_d[l_ac].apdc031_desc = s_desc_show1(g_apce2_d[l_ac].apdc031,s_fin_get_accting_desc(g_glad.glad0171,g_apce2_d[l_ac].apdc031))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc031 = ''
            END IF
            LET g_apce2_d[l_ac].apdc031_desc = s_desc_show1(g_apce2_d[l_ac].apdc031,s_fin_get_accting_desc(g_glad.glad0171,g_apce2_d[l_ac].apdc031))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc031_desc
            LET g_apce2_d_t.apdc031_desc = g_apce2_d[l_ac].apdc031_desc
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc032
            #add-point:BEFORE FIELD apdc032 name="input.b.page2.apdc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc032
            
            #add-point:AFTER FIELD apdc032 name="input.a.page2.apdc032"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc032
            #add-point:ON CHANGE apdc032 name="input.g.page2.apdc032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc032_desc
            #add-point:BEFORE FIELD apdc032_desc name="input.b.page2.apdc032_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc032_desc = g_apce2_d[l_ac].apdc032   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc032_desc
            
            #add-point:AFTER FIELD apdc032_desc name="input.a.page2.apdc032_desc"
            #自由核算項二
            IF NOT cl_null(g_apce2_d[l_ac].apdc032_desc) THEN
               #IF (g_apce2_d[l_ac].apdc032_desc != g_apce2_d_t.apdc032_desc OR g_apce2_d_t.apdc032_desc IS NULL) THEN   #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc032_desc != g_apce2_d_o.apdc032_desc OR cl_null(g_apce2_d_o.apdc032_desc) THEN     #160822-00008#3
                  LET g_apce2_d[l_ac].apdc032 = g_apce2_d[l_ac].apdc032_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc032 != g_apce2_d_t.apdc032 OR g_apce2_d_t.apdc032 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc032 != g_apce2_d_o.apdc032 OR cl_null(g_apce2_d_o.apdc032) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_apce2_d[l_ac].apdc032,g_glad.glad0182) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc032 = g_apce2_d_t.apdc032  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc032 = g_apce2_d_o.apdc032   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc032_desc = s_desc_show1(g_apce2_d[l_ac].apdc032,s_fin_get_accting_desc(g_glad.glad0181,g_apce2_d[l_ac].apdc032))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc032 = ''
            END IF
            LET g_apce2_d[l_ac].apdc032_desc = s_desc_show1(g_apce2_d[l_ac].apdc032,s_fin_get_accting_desc(g_glad.glad0181,g_apce2_d[l_ac].apdc032))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc032_desc 
            LET g_apce2_d_t.apdc032_desc = g_apce2_d[l_ac].apdc032_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc032_desc
            #add-point:ON CHANGE apdc032_desc name="input.g.page2.apdc032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc033
            #add-point:BEFORE FIELD apdc033 name="input.b.page2.apdc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc033
            
            #add-point:AFTER FIELD apdc033 name="input.a.page2.apdc033"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc033
            #add-point:ON CHANGE apdc033 name="input.g.page2.apdc033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc033_desc
            #add-point:BEFORE FIELD apdc033_desc name="input.b.page2.apdc033_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc033_desc = g_apce2_d[l_ac].apdc033   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc033_desc
            
            #add-point:AFTER FIELD apdc033_desc name="input.a.page2.apdc033_desc"
            #自由核算項三
            IF NOT cl_null(g_apce2_d[l_ac].apdc033_desc) THEN
               #IF (g_apce2_d[l_ac].apdc033_desc != g_apce2_d_t.apdc033_desc OR g_apce2_d_t.apdc033_desc IS NULL) THEN   #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc033_desc != g_apce2_d_o.apdc033_desc OR cl_null(g_apce2_d_o.apdc033_desc) THEN     #160822-00008#3
                  LET g_apce2_d[l_ac].apdc033 = g_apce2_d[l_ac].apdc033_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc033 != g_apce2_d_t.apdc033 OR g_apce2_d_t.apdc033 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc033 != g_apce2_d_o.apdc033 OR cl_null(g_apce2_d_o.apdc033) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_apce2_d[l_ac].apdc033,g_glad.glad0192) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc033 = g_apce2_d_t.apdc033  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc033 = g_apce2_d_o.apdc033   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc033_desc = s_desc_show1(g_apce2_d[l_ac].apdc033,s_fin_get_accting_desc(g_glad.glad0191,g_apce2_d[l_ac].apdc033))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc033_desc
                           NEXT FIELD CURRENT
                        END IF 
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc033 = ''
            END IF
            LET g_apce2_d[l_ac].apdc033_desc = s_desc_show1(g_apce2_d[l_ac].apdc033,s_fin_get_accting_desc(g_glad.glad0191,g_apce2_d[l_ac].apdc033))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc033_desc 
            LET g_apce2_d_t.apdc033_desc = g_apce2_d[l_ac].apdc033_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc033_desc
            #add-point:ON CHANGE apdc033_desc name="input.g.page2.apdc033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc034
            #add-point:BEFORE FIELD apdc034 name="input.b.page2.apdc034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc034
            
            #add-point:AFTER FIELD apdc034 name="input.a.page2.apdc034"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc034
            #add-point:ON CHANGE apdc034 name="input.g.page2.apdc034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc034_desc
            #add-point:BEFORE FIELD apdc034_desc name="input.b.page2.apdc034_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc034_desc = g_apce2_d[l_ac].apdc034   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc034_desc
            
            #add-point:AFTER FIELD apdc034_desc name="input.a.page2.apdc034_desc"
            #自由核算項四
            IF NOT cl_null(g_apce2_d[l_ac].apdc034_desc) THEN
               #IF (g_apce2_d[l_ac].apdc034_desc != g_apce2_d_t.apdc034_desc OR g_apce2_d_t.apdc034_desc IS NULL) THEN   #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc034_desc != g_apce2_d_o.apdc034_desc OR cl_null(g_apce2_d_o.apdc034_desc) THEN     #160822-00008#3
                  LET g_apce2_d[l_ac].apdc034 = g_apce2_d[l_ac].apdc034_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc034 != g_apce2_d_t.apdc034 OR g_apce2_d_t.apdc034 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc034 != g_apce2_d_o.apdc034 OR cl_null(g_apce2_d_o.apdc034) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_apce2_d[l_ac].apdc034,g_glad.glad0202) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc034 = g_apce2_d_t.apdc034  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc034 = g_apce2_d_o.apdc034   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc034_desc = s_desc_show1(g_apce2_d[l_ac].apdc034,s_fin_get_accting_desc(g_glad.glad0201,g_apce2_d[l_ac].apdc034))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc034_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc034 = ''
            END IF
            LET g_apce2_d[l_ac].apdc034_desc = s_desc_show1(g_apce2_d[l_ac].apdc034,s_fin_get_accting_desc(g_glad.glad0201,g_apce2_d[l_ac].apdc034))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc034_desc 
            LET g_apce2_d_t.apdc034_desc = g_apce2_d[l_ac].apdc034_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc034_desc
            #add-point:ON CHANGE apdc034_desc name="input.g.page2.apdc034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc035
            #add-point:BEFORE FIELD apdc035 name="input.b.page2.apdc035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc035
            
            #add-point:AFTER FIELD apdc035 name="input.a.page2.apdc035"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc035
            #add-point:ON CHANGE apdc035 name="input.g.page2.apdc035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc035_desc
            #add-point:BEFORE FIELD apdc035_desc name="input.b.page2.apdc035_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc035_desc = g_apce2_d[l_ac].apdc035   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc035_desc
            
            #add-point:AFTER FIELD apdc035_desc name="input.a.page2.apdc035_desc"
            #自由核算項五
            IF NOT cl_null(g_apce2_d[l_ac].apdc035_desc) THEN
               #IF (g_apce2_d[l_ac].apdc035_desc != g_apce2_d_t.apdc035_desc OR g_apce2_d_t.apdc035_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc035_desc != g_apce2_d_o.apdc035_desc OR cl_null(g_apce2_d_o.apdc035_desc) THEN    #160822-00008#3
                  LET g_apce2_d[l_ac].apdc035 = g_apce2_d[l_ac].apdc035_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc035 != g_apce2_d_t.apdc035 OR g_apce2_d_t.apdc035 IS NULL) THEN   #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc035 != g_apce2_d_o.apdc035 OR cl_null(g_apce2_d_o.apdc035) THEN     #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_apce2_d[l_ac].apdc035,g_glad.glad0212) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc035 = g_apce2_d_t.apdc035  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc035 = g_apce2_d_o.apdc035   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc035_desc = s_desc_show1(g_apce2_d[l_ac].apdc035,s_fin_get_accting_desc(g_glad.glad0211,g_apce2_d[l_ac].apdc035))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc035_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc035 = ''
            END IF
            LET g_apce2_d[l_ac].apdc035_desc = s_desc_show1(g_apce2_d[l_ac].apdc035,s_fin_get_accting_desc(g_glad.glad0211,g_apce2_d[l_ac].apdc035))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc035_desc 
            LET g_apce2_d_t.apdc035_desc = g_apce2_d[l_ac].apdc035_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc035_desc
            #add-point:ON CHANGE apdc035_desc name="input.g.page2.apdc035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc036
            #add-point:BEFORE FIELD apdc036 name="input.b.page2.apdc036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc036
            
            #add-point:AFTER FIELD apdc036 name="input.a.page2.apdc036"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc036
            #add-point:ON CHANGE apdc036 name="input.g.page2.apdc036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc036_desc
            #add-point:BEFORE FIELD apdc036_desc name="input.b.page2.apdc036_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc036_desc = g_apce2_d[l_ac].apdc036   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc036_desc
            
            #add-point:AFTER FIELD apdc036_desc name="input.a.page2.apdc036_desc"
            #自由核算項六
            IF NOT cl_null(g_apce2_d[l_ac].apdc036_desc) THEN
               #IF (g_apce2_d[l_ac].apdc036_desc != g_apce2_d_t.apdc036_desc OR g_apce2_d_t.apdc036_desc IS NULL) THEN  #160822-00008#3    mark
               IF g_apce2_d[l_ac].apdc036_desc != g_apce2_d_o.apdc036_desc OR cl_null(g_apce2_d_o.apdc036_desc) THEN    #160822-00008#3  
                  LET g_apce2_d[l_ac].apdc036 = g_apce2_d[l_ac].apdc036_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc036 != g_apce2_d_t.apdc036 OR g_apce2_d_t.apdc036 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc036 != g_apce2_d_o.apdc036 OR cl_null(g_apce2_d_o.apdc036) THEN   #160822-00008#3  
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_apce2_d[l_ac].apdc036,g_glad.glad0222) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc036 = g_apce2_d_t.apdc036  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc036 = g_apce2_d_o.apdc036   #160822-00008#3  
                           LET g_apce2_d[l_ac].apdc036_desc = s_desc_show1(g_apce2_d[l_ac].apdc036,s_fin_get_accting_desc(g_glad.glad0221,g_apce2_d[l_ac].apdc036))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc036_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc036 = ''
            END IF
            LET g_apce2_d[l_ac].apdc036_desc = s_desc_show1(g_apce2_d[l_ac].apdc036,s_fin_get_accting_desc(g_glad.glad0221,g_apce2_d[l_ac].apdc036))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc036_desc 
            LET g_apce2_d_t.apdc036_desc = g_apce2_d[l_ac].apdc036_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc036_desc
            #add-point:ON CHANGE apdc036_desc name="input.g.page2.apdc036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc037
            #add-point:BEFORE FIELD apdc037 name="input.b.page2.apdc037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc037
            
            #add-point:AFTER FIELD apdc037 name="input.a.page2.apdc037"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc037
            #add-point:ON CHANGE apdc037 name="input.g.page2.apdc037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc037_desc
            #add-point:BEFORE FIELD apdc037_desc name="input.b.page2.apdc037_desc"
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc037_desc = g_apce2_d[l_ac].apdc037   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc037_desc
            
            #add-point:AFTER FIELD apdc037_desc name="input.a.page2.apdc037_desc"
            #自由核算項七
            IF NOT cl_null(g_apce2_d[l_ac].apdc037_desc) THEN
               #IF (g_apce2_d[l_ac].apdc037_desc != g_apce2_d_t.apdc037_desc OR g_apce2_d_t.apdc037_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc037_desc != g_apce2_d_o.apdc037_desc OR cl_null(g_apce2_d_o.apdc037_desc) THEN    #160822-00008#3
                  LET g_apce2_d[l_ac].apdc037 = g_apce2_d[l_ac].apdc037_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc037 != g_apce2_d_t.apdc037 OR g_apce2_d_t.apdc037 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc037 != g_apce2_d_o.apdc037 OR cl_null(g_apce2_d_o.apdc037) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_apce2_d[l_ac].apdc037,g_glad.glad0232) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc037 = g_apce2_d_t.apdc037  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc037 = g_apce2_d_o.apdc037   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc037_desc = s_desc_show1(g_apce2_d[l_ac].apdc037,s_fin_get_accting_desc(g_glad.glad0231,g_apce2_d[l_ac].apdc037))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc037_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc037 = ''
            END IF
            LET g_apce2_d[l_ac].apdc037_desc = s_desc_show1(g_apce2_d[l_ac].apdc037,s_fin_get_accting_desc(g_glad.glad0231,g_apce2_d[l_ac].apdc037))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc037_desc
            LET g_apce2_d_t.apdc037_desc = g_apce2_d[l_ac].apdc037_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc037_desc
            #add-point:ON CHANGE apdc037_desc name="input.g.page2.apdc037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc038
            #add-point:BEFORE FIELD apdc038 name="input.b.page2.apdc038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc038
            
            #add-point:AFTER FIELD apdc038 name="input.a.page2.apdc038"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc038
            #add-point:ON CHANGE apdc038 name="input.g.page2.apdc038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc038_desc
            #add-point:BEFORE FIELD apdc038_desc name="input.b.page2.apdc038_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc038_desc = g_apce2_d[l_ac].apdc038   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc038_desc
            
            #add-point:AFTER FIELD apdc038_desc name="input.a.page2.apdc038_desc"
            #自由核算項八
            IF NOT cl_null(g_apce2_d[l_ac].apdc038_desc) THEN
               #IF (g_apce2_d[l_ac].apdc038_desc != g_apce2_d_t.apdc038_desc OR g_apce2_d_t.apdc038_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc038_desc != g_apce2_d_o.apdc038_desc OR cl_null(g_apce2_d_o.apdc038_desc) THEN    #160822-00008#3
                  LET g_apce2_d[l_ac].apdc038 = g_apce2_d[l_ac].apdc038_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc038 != g_apce2_d_t.apdc038 OR g_apce2_d_t.apdc038 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc038 != g_apce2_d_o.apdc038 OR cl_null(g_apce2_d_o.apdc038) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_apce2_d[l_ac].apdc038,g_glad.glad0242) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc038 = g_apce2_d_t.apdc038  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc038 = g_apce2_d_o.apdc038   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc038_desc = s_desc_show1(g_apce2_d[l_ac].apdc038,s_fin_get_accting_desc(g_glad.glad0241,g_apce2_d[l_ac].apdc038))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc038_desc
                           NEXT FIELD CURRENT
                        END IF                       
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc038 = ''
            END IF
            LET g_apce2_d[l_ac].apdc038_desc = s_desc_show1(g_apce2_d[l_ac].apdc038,s_fin_get_accting_desc(g_glad.glad0241,g_apce2_d[l_ac].apdc038))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc038_desc 
            LET g_apce2_d_t.apdc038_desc = g_apce2_d[l_ac].apdc038_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc038_desc
            #add-point:ON CHANGE apdc038_desc name="input.g.page2.apdc038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc039
            #add-point:BEFORE FIELD apdc039 name="input.b.page2.apdc039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc039
            
            #add-point:AFTER FIELD apdc039 name="input.a.page2.apdc039"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc039
            #add-point:ON CHANGE apdc039 name="input.g.page2.apdc039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc039_desc
            #add-point:BEFORE FIELD apdc039_desc name="input.b.page2.apdc039_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc039_desc = g_apce2_d[l_ac].apdc039   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc039_desc
            
            #add-point:AFTER FIELD apdc039_desc name="input.a.page2.apdc039_desc"
            #自由核算項九
            IF NOT cl_null(g_apce2_d[l_ac].apdc039_desc) THEN
               #IF (g_apce2_d[l_ac].apdc039_desc != g_apce2_d_t.apdc039_desc OR g_apce2_d_t.apdc039_desc IS NULL) THEN  #160822-00008#3  mark
               IF g_apce2_d[l_ac].apdc039_desc != g_apce2_d_o.apdc039_desc OR cl_null(g_apce2_d_o.apdc039_desc) THEN    #160822-00008#3
                  LET g_apce2_d[l_ac].apdc039 = g_apce2_d[l_ac].apdc039_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     #IF (g_apce2_d[l_ac].apdc039 != g_apce2_d_t.apdc039 OR g_apce2_d_t.apdc039 IS NULL) THEN  #160822-00008#3  mark
                     IF g_apce2_d[l_ac].apdc039 != g_apce2_d_o.apdc039 OR cl_null(g_apce2_d_o.apdc039) THEN    #160822-00008#3
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_apce2_d[l_ac].apdc039,g_glad.glad0252) RETURNING g_errno
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
                           #LET g_apce2_d[l_ac].apdc039 = g_apce2_d_t.apdc039  #160822-00008#3  mark
                           LET g_apce2_d[l_ac].apdc039 = g_apce2_d_o.apdc039   #160822-00008#3
                           LET g_apce2_d[l_ac].apdc039_desc = s_desc_show1(g_apce2_d[l_ac].apdc039,s_fin_get_accting_desc(g_glad.glad0251,g_apce2_d[l_ac].apdc039))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc039_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc039 = ''
            END IF
            LET g_apce2_d[l_ac].apdc039_desc = s_desc_show1(g_apce2_d[l_ac].apdc039,s_fin_get_accting_desc(g_glad.glad0251,g_apce2_d[l_ac].apdc039))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc039_desc 
            LET g_apce2_d_t.apdc039_desc = g_apce2_d[l_ac].apdc039_desc
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc039_desc
            #add-point:ON CHANGE apdc039_desc name="input.g.page2.apdc039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc040
            #add-point:BEFORE FIELD apdc040 name="input.b.page2.apdc040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc040
            
            #add-point:AFTER FIELD apdc040 name="input.a.page2.apdc040"
            LET g_apce2_d_o.* = g_apce2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc040
            #add-point:ON CHANGE apdc040 name="input.g.page2.apdc040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdc040_desc
            #add-point:BEFORE FIELD apdc040_desc name="input.b.page2.apdc040_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_apce2_d[l_ac].apdc040_desc = g_apce2_d[l_ac].apdc040   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdc040_desc
            
            #add-point:AFTER FIELD apdc040_desc name="input.a.page2.apdc040_desc"
            #自由核算項十
            IF NOT cl_null(g_apce2_d[l_ac].apdc040_desc) THEN
               IF (g_apce2_d[l_ac].apdc040_desc != g_apce2_d_t.apdc040_desc OR g_apce2_d_t.apdc040_desc IS NULL) THEN  
                  LET g_apce2_d[l_ac].apdc040 = g_apce2_d[l_ac].apdc040_desc
                  IF g_glaa.glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_apce2_d[l_ac].apdc040 != g_apce2_d_t.apdc040 OR g_apce2_d_t.apdc040 IS NULL) THEN  
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_apce2_d[l_ac].apdc040,g_glad.glad0262) RETURNING g_errno
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
                           LET g_apce2_d[l_ac].apdc040 = g_apce2_d_t.apdc040  
                           LET g_apce2_d[l_ac].apdc040_desc = s_desc_show1(g_apce2_d[l_ac].apdc040,s_fin_get_accting_desc(g_glad.glad0261,g_apce2_d[l_ac].apdc040))
                           DISPLAY BY NAME g_apce2_d[l_ac].apdc040_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF               
               END IF
            ELSE
               LET g_apce2_d[l_ac].apdc040_desc = '' 
            END IF
            LET g_apce2_d[l_ac].apdc040_desc = s_desc_show1(g_apce2_d[l_ac].apdc040,s_fin_get_accting_desc(g_glad.glad0261,g_apce2_d[l_ac].apdc040))
            DISPLAY BY NAME g_apce2_d[l_ac].apdc040_desc 
            LET g_apce2_d_t.apdc040_desc = g_apce2_d[l_ac].apdc040_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdc040_desc
            #add-point:ON CHANGE apdc040_desc name="input.g.page2.apdc040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdccomp
            #add-point:BEFORE FIELD apdccomp name="input.b.page2.apdccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdccomp
            
            #add-point:AFTER FIELD apdccomp name="input.a.page2.apdccomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdccomp
            #add-point:ON CHANGE apdccomp name="input.g.page2.apdccomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdcsite
            #add-point:BEFORE FIELD apdcsite name="input.b.page2.apdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdcsite
            
            #add-point:AFTER FIELD apdcsite name="input.a.page2.apdcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdcsite
            #add-point:ON CHANGE apdcsite name="input.g.page2.apdcsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apdcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcseq
            #add-point:ON ACTION controlp INFIELD apdcseq name="input.c.page2.apdcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc001
            #add-point:ON ACTION controlp INFIELD apdc001 name="input.c.page2.apdc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcorga
            #add-point:ON ACTION controlp INFIELD apdcorga name="input.c.page2.apdcorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdcorga
            LET g_qryparam.where = " ooef001 IN ",g_wc_apdasite CLIPPED,
                                   " AND ooef017 ='",g_apda_m.apdacomp,"' ",
                                   " AND ooef201 = 'Y'"   #161006-00005#5   add
            CALL q_ooef001()
            LET g_apce2_d[l_ac].apdcorga = g_qryparam.return1
            DISPLAY BY NAME g_apce2_d[l_ac].apdcorga
            NEXT FIELD apdcorga
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc002
            #add-point:ON ACTION controlp INFIELD apdc002 name="input.c.page2.apdc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc002
            LET g_qryparam.default2 = g_apce2_d[l_ac].apdc003
            LET g_qryparam.where = " apcborga = '",g_apce2_d[l_ac].apdcorga,"' "
            CALL q_apdc002()
            LET g_apce2_d[l_ac].apdc002 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc003 = g_qryparam.return2
            DISPLAY BY NAME g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003
            NEXT FIELD apdc002
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc003
            #add-point:ON ACTION controlp INFIELD apdc003 name="input.c.page2.apdc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc004
            #add-point:ON ACTION controlp INFIELD apdc004 name="input.c.page2.apdc004"
            #161114-00017#2 --s add 
            LET l_apdc004_comp = ''
            SELECT glaacomp INTO l_apdc004_comp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_apda_m.apdald
            #161114-00017#2 --e add             
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc004
            #LET g_qryparam.arg1 = g_apda_m.apdasite  #161114-00017#2 mark
            #CALL q_imaf001_7()                       #161114-00017#2 mark            
            LET g_qryparam.arg1 = l_apdc004_comp      #161114-00017#2 add
            CALL q_imaf001_21()                       #161114-00017#2 add
            LET g_apce2_d[l_ac].apdc004 = g_qryparam.return1
            DISPLAY BY NAME g_apce2_d[l_ac].apdc004
            NEXT FIELD apdc004
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc009
            #add-point:ON ACTION controlp INFIELD apdc009 name="input.c.page2.apdc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc111
            #add-point:ON ACTION controlp INFIELD apdc111 name="input.c.page2.apdc111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc113
            #add-point:ON ACTION controlp INFIELD apdc113 name="input.c.page2.apdc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc211
            #add-point:ON ACTION controlp INFIELD apdc211 name="input.c.page2.apdc211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc213
            #add-point:ON ACTION controlp INFIELD apdc213 name="input.c.page2.apdc213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc123
            #add-point:ON ACTION controlp INFIELD apdc123 name="input.c.page2.apdc123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc223
            #add-point:ON ACTION controlp INFIELD apdc223 name="input.c.page2.apdc223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc133
            #add-point:ON ACTION controlp INFIELD apdc133 name="input.c.page2.apdc133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc233
            #add-point:ON ACTION controlp INFIELD apdc233 name="input.c.page2.apdc233"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc005
            #add-point:ON ACTION controlp INFIELD apdc005 name="input.c.page2.apdc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc006
            #add-point:ON ACTION controlp INFIELD apdc006 name="input.c.page2.apdc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc041
            #add-point:ON ACTION controlp INFIELD apdc041 name="input.c.page2.apdc041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc007
            #add-point:ON ACTION controlp INFIELD apdc007 name="input.c.page2.apdc007"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc007_desc
            #add-point:ON ACTION controlp INFIELD apdc007_desc name="input.c.page2.apdc007_desc"
            #目的會計科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc007
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                    " AND glacent = gladent ", #161114-00017#2 add
                                   "AND gladld='",g_apda_m.apdald,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_apce2_d[l_ac].apdc007      = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc007_desc = g_qryparam.return1
            DISPLAY BY NAME g_apce2_d[l_ac].apdc007,g_apce2_d[l_ac].apdc007_desc
            NEXT FIELD apdc007_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc017
            #add-point:ON ACTION controlp INFIELD apdc017 name="input.c.page2.apdc017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc017_desc
            #add-point:ON ACTION controlp INFIELD apdc017_desc name="input.c.page2.apdc017_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc017
            CALL q_ooag001()
            LET g_apce2_d[l_ac].apdc017 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc017_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc017,g_apce2_d[l_ac].apdc017_desc
            NEXT FIELD apdc017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc018
            #add-point:ON ACTION controlp INFIELD apdc018 name="input.c.page2.apdc018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc018_desc
            #add-point:ON ACTION controlp INFIELD apdc018_desc name="input.c.page2.apdc018_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc018
            LET g_qryparam.arg1 = g_apda_m.apdadocdt         #應以單據日期
            CALL q_ooeg001_4()
            LET g_apce2_d[l_ac].apdc018 = g_qryparam.return1   
            LET g_apce2_d[l_ac].apdc018_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc018,g_apce2_d[l_ac].apdc018_desc
            NEXT FIELD apdc018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc019
            #add-point:ON ACTION controlp INFIELD apdc019 name="input.c.page2.apdc019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc019_desc
            #add-point:ON ACTION controlp INFIELD apdc019_desc name="input.c.page2.apdc019_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc019
            LET g_qryparam.arg1 = g_apda_m.apdadocdt
            #LET g_qryparam.where =" ooeg003 IN ('1','2','3')" #140806-00012#8 mark
            #CALL q_ooeg001_4()                                #140806-00012#8 mark
            CALL q_ooeg001_5()                                 #140806-00012#8 add
            LET g_apce2_d[l_ac].apdc019 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc019_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc019,g_apce2_d[l_ac].apdc019_desc
            NEXT FIELD apdc019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc020
            #add-point:ON ACTION controlp INFIELD apdc020 name="input.c.page2.apdc020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc020_desc
            #add-point:ON ACTION controlp INFIELD apdc020_desc name="input.c.page2.apdc020_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc020
            CALL q_rtax001()
            LET g_apce2_d[l_ac].apdc020 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc020_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc020,g_apce2_d[l_ac].apdc020_desc
            NEXT FIELD apdc020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc022
            #add-point:ON ACTION controlp INFIELD apdc022 name="input.c.page2.apdc022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc022_desc
            #add-point:ON ACTION controlp INFIELD apdc022_desc name="input.c.page2.apdc022_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc022
            CALL q_pjba001()
            LET g_apce2_d[l_ac].apdc022 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc022_desc = g_qryparam.return1
            DISPLAY BY NAME g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc022_desc
            NEXT FIELD apdc022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc023
            #add-point:ON ACTION controlp INFIELD apdc023 name="input.c.page2.apdc023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc023_desc
            #add-point:ON ACTION controlp INFIELD apdc023_desc name="input.c.page2.apdc023_desc"
            #WBS #140806-00012#8
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc023
            IF NOT cl_null(g_apce_d[l_ac].apce022) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_apce2_d[l_ac].apdc022,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_apce2_d[l_ac].apdc023 = g_qryparam.return1   
            LET g_apce2_d[l_ac].apdc023_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc023,g_apce2_d[l_ac].apdc023_desc
            NEXT FIELD apdc023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc024
            #add-point:ON ACTION controlp INFIELD apdc024 name="input.c.page2.apdc024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc024_desc
            #add-point:ON ACTION controlp INFIELD apdc024_desc name="input.c.page2.apdc024_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc024
            CALL q_oocq002_287()
            LET g_apce2_d[l_ac].apdc024 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc024_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc024,g_apce2_d[l_ac].apdc024_desc
            NEXT FIELD apdc024_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc025
            #add-point:ON ACTION controlp INFIELD apdc025 name="input.c.page2.apdc025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc025_desc
            #add-point:ON ACTION controlp INFIELD apdc025_desc name="input.c.page2.apdc025_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc025
            CALL q_oocq002_281()
            LET g_apce2_d[l_ac].apdc025 = g_qryparam.return1
            LET g_apce2_d[l_ac].apdc025_desc = g_qryparam.return1
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc025,g_apce2_d[l_ac].apdc025_desc
            NEXT FIELD apdc025_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc027
            #add-point:ON ACTION controlp INFIELD apdc027 name="input.c.page2.apdc027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc027_desc
            #add-point:ON ACTION controlp INFIELD apdc027_desc name="input.c.page2.apdc027_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc028
            #add-point:ON ACTION controlp INFIELD apdc028 name="input.c.page2.apdc028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc028_desc
            #add-point:ON ACTION controlp INFIELD apdc028_desc name="input.c.page2.apdc028_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc028
            CALL q_oojd001_2()
            LET g_apce2_d[l_ac].apdc028 = g_qryparam.return1   
            LET g_apce2_d[l_ac].apdc028_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc028,g_apce2_d[l_ac].apdc028_desc
            NEXT FIELD apdc028_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc029
            #add-point:ON ACTION controlp INFIELD apdc029 name="input.c.page2.apdc029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc029_desc
            #add-point:ON ACTION controlp INFIELD apdc029_desc name="input.c.page2.apdc029_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce2_d[l_ac].apdc029
            CALL q_oocq002_2002()
            LET g_apce2_d[l_ac].apdc029 = g_qryparam.return1   
            LET g_apce2_d[l_ac].apdc029_desc = g_qryparam.return1 
            DISPLAY BY NAME  g_apce2_d[l_ac].apdc029,g_apce2_d[l_ac].apdc029_desc
            NEXT FIELD apdc029_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc031
            #add-point:ON ACTION controlp INFIELD apdc031 name="input.c.page2.apdc031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc031_desc
            #add-point:ON ACTION controlp INFIELD apdc031_desc name="input.c.page2.apdc031_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc031

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc031      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc031_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc031,g_apce2_d[l_ac].apdc031_desc
               NEXT FIELD apdc031_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc032
            #add-point:ON ACTION controlp INFIELD apdc032 name="input.c.page2.apdc032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc032_desc
            #add-point:ON ACTION controlp INFIELD apdc032_desc name="input.c.page2.apdc032_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc032
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc032      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc032_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc032,g_apce2_d[l_ac].apdc032_desc
               NEXT FIELD apdc032_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc033
            #add-point:ON ACTION controlp INFIELD apdc033 name="input.c.page2.apdc033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc033_desc
            #add-point:ON ACTION controlp INFIELD apdc033_desc name="input.c.page2.apdc033_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc033
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc033      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc033_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc033,g_apce2_d[l_ac].apdc033_desc
               NEXT FIELD apdc033_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc034
            #add-point:ON ACTION controlp INFIELD apdc034 name="input.c.page2.apdc034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc034_desc
            #add-point:ON ACTION controlp INFIELD apdc034_desc name="input.c.page2.apdc034_desc"
           #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc034
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc034      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc034_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc034,g_apce2_d[l_ac].apdc034_desc
               NEXT FIELD apdc034_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc035
            #add-point:ON ACTION controlp INFIELD apdc035 name="input.c.page2.apdc035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc035_desc
            #add-point:ON ACTION controlp INFIELD apdc035_desc name="input.c.page2.apdc035_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc035
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc035      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc035_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc035,g_apce2_d[l_ac].apdc035_desc
               NEXT FIELD apdc035_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc036
            #add-point:ON ACTION controlp INFIELD apdc036 name="input.c.page2.apdc036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc036_desc
            #add-point:ON ACTION controlp INFIELD apdc036_desc name="input.c.page2.apdc036_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc036
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc036      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc036_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc036,g_apce2_d[l_ac].apdc036_desc
               NEXT FIELD apdc036_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc037
            #add-point:ON ACTION controlp INFIELD apdc037 name="input.c.page2.apdc037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc037_desc
            #add-point:ON ACTION controlp INFIELD apdc037_desc name="input.c.page2.apdc037_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc037
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc037      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc037_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc037,g_apce2_d[l_ac].apdc037_desc
               NEXT FIELD apdc037_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc038
            #add-point:ON ACTION controlp INFIELD apdc038 name="input.c.page2.apdc038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc038_desc
            #add-point:ON ACTION controlp INFIELD apdc038_desc name="input.c.page2.apdc038_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc038
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc038      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc038_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc038,g_apce2_d[l_ac].apdc038_desc
               NEXT FIELD apdc038_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc039
            #add-point:ON ACTION controlp INFIELD apdc039 name="input.c.page2.apdc039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc039_desc
            #add-point:ON ACTION controlp INFIELD apdc039_desc name="input.c.page2.apdc039_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc039
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc039      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc039_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc039,g_apce2_d[l_ac].apdc039_desc
               NEXT FIELD apdc039_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc040
            #add-point:ON ACTION controlp INFIELD apdc040 name="input.c.page2.apdc040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdc040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdc040_desc
            #add-point:ON ACTION controlp INFIELD apdc040_desc name="input.c.page2.apdc040_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_apce2_d[l_ac].apdc040
               
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_apce2_d[l_ac].apdc040      = g_qryparam.return1
               LET g_apce2_d[l_ac].apdc040_desc = g_qryparam.return1
               DISPLAY BY NAME g_apce2_d[l_ac].apdc040,g_apce2_d[l_ac].apdc040_desc
               NEXT FIELD apdc040_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdccomp
            #add-point:ON ACTION controlp INFIELD apdccomp name="input.c.page2.apdccomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdcsite
            #add-point:ON ACTION controlp INFIELD apdcsite name="input.c.page2.apdcsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
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
               CLOSE aapt430_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt430_unlock_b("apdc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apce2_d[li_reproduce_target].* = g_apce2_d[li_reproduce].*
 
               LET g_apce2_d[li_reproduce_target].apdcseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apce2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apce2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt430.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
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
                  NEXT FIELD apdcseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL aapt430_b_fill()
   #更新單頭"來源應攤銷金額"
   CALL aapt430_upd_apda113() RETURNING g_sub_success
   CALL aapt430_sum_show()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt430_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt430_b_fill() #單身填充
      CALL aapt430_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt430_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_apda_m.apda018_desc = s_desc_get_acc_desc('3113',g_apda_m.apda018)
   CALL aapt430_set_ld_info(g_apda_m.apdald)
   CALL aapt430_sum_show()
   #end add-point
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt430_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apdald,g_apda_m.apdald_desc,g_apda_m.apdadocno, 
       g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp, 
       g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda003_desc, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda113,g_apda_m.l_sum_apdc113213,g_apda_m.l_sum_apceapdc, 
       g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstid_desc,g_apda_m.apdapstdt,g_apda_m.l_sumcost,g_apda_m.l_sumdiscount, 
       g_apda_m.l_sumprepay
   
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
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apce2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   CALL cl_set_comp_entry("apdc004",TRUE)
   CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',TRUE)
   IF g_apda_m.apda019 = '1' THEN
      #依入庫單據分攤，不開放選產品
      CALL cl_set_comp_entry("apdc004",FALSE)
   ELSE
      #依產品分攤，以下欄位隱藏
      #來源歸屬組織apdcorga/交易單號apdc002/交易項次apdc003/目的帳款單號apdc005/帳款項次apdc006
      CALL cl_set_comp_visible('apdcorga,apdc002,apdc003,apdc005,apdc006',FALSE)
   END IF
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt430_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt430_detail_show()
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
 
{<section id="aapt430.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt430_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apda_t.apdald 
   DEFINE l_oldno     LIKE apda_t.apdald 
   DEFINE l_newno02     LIKE apda_t.apdadocno 
   DEFINE l_oldno02     LIKE apda_t.apdadocno 
 
   DEFINE l_master    RECORD LIKE apda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apce_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apdc_t.* #此變數樣板目前無使用
 
 
 
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
   #add by zhaoqya 2016-08-08複製時不清空單身 -S
   LET g_apda_m.apdacnfid = NULL   
   LET g_apda_m.apdacnfid_desc = NULL   
   LET g_apda_m.apdacnfdt = NULL
   LET g_apda_m.apda014 = NULL       
   #add by zhaoqya 2016-08-08 -E
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
 
   
   CALL aapt430_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apda_m.* TO NULL
      INITIALIZE g_apce_d TO NULL
      INITIALIZE g_apce2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt430_show()
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
   CALL aapt430_set_act_visible()   
   CALL aapt430_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt430_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt430_idx_chk()
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt430_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt430_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apce_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apdc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt430_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apce_t
    WHERE apceent = g_enterprise AND apceld = g_apdald_t
     AND apcedocno = g_apdadocno_t
 
    INTO TEMP aapt430_detail
 
   #將key修正為調整後   
   UPDATE aapt430_detail 
      #更新key欄位
      SET apceld = g_apda_m.apdald
          , apcedocno = g_apda_m.apdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apce_t SELECT * FROM aapt430_detail
   
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
   DROP TABLE aapt430_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apdc_t 
    WHERE apdcent = g_enterprise AND apdcld = g_apdald_t
      AND apdcdocno = g_apdadocno_t   
 
    INTO TEMP aapt430_detail
 
   #將key修正為調整後   
   UPDATE aapt430_detail SET apdcld = g_apda_m.apdald
                                       , apdcdocno = g_apda_m.apdadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apdc_t SELECT * FROM aapt430_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt430_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt430_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt           LIKE type_t.num5  #141202-00061#17
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
 
   OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt430_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt430_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt430_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   CALL aapt430_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt430_set_pk_array()
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
      #141202-00061#17
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_glaa.glaacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      IF g_glaa.glaa121 = 'Y' AND g_dfin0030 = 'Y'THEN
         #150319改寫 Reanna
         CALL s_pre_voucher_del('AP','P30',g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         ##分錄單頭
         #SELECT count(*) INTO l_cnt
         #  FROM glga_t
         # WHERE glgaent = g_enterprise
         #   AND glgald  = g_apda_m.apdald AND glgadocno = g_apda_m.apdadocno
         #   AND glga100 = 'AP' AND glga101 = 'P30'
         #IF l_cnt > 0 THEN
         #  DELETE FROM glga_t
         #   WHERE glgaent = g_enterprise
         #     AND glgald  = g_apda_m.apdald AND glgadocno = g_apda_m.apdadocno
         #     AND glga100 = 'AP' AND glga101 = '30'
         #  IF SQLCA.sqlcode THEN
         #     INITIALIZE g_errparam TO NULL 
         #     LET g_errparam.extend = g_apda_m.apdadocno 
         #     LET g_errparam.code   = SQLCA.sqlcode 
         #     LET g_errparam.popup  = FALSE 
         #     CALL cl_err()
         #  END IF 
         #END IF
         ##分錄單身
         #SELECT count(*) INTO l_cnt
         # FROM glgb_t
         #WHERE glgbent = g_enterprise
         #  AND glgbld  = g_apda_m.apdald AND glgbdocno = g_apda_m.apdadocno
         #  AND glgb100 = 'AP' AND glgb101 LIKE 'P60'
         #IF l_cnt > 0 THEN
         #  DELETE FROM glgb_t
         #   WHERE glgbent = g_enterprise
         #     AND glgbld  = g_apda_m.apdald AND glgbdocno = g_apda_m.apdadocno
         #     AND glgb100 = 'AP' AND glgb101 LIKE 'P60'
         #     IF SQLCA.sqlcode THEN
         #        INITIALIZE g_errparam TO NULL 
         #        LET g_errparam.extend = g_apda_m.apdadocno 
         #        LET g_errparam.code   = SQLCA.sqlcode 
         #        LET g_errparam.popup  = FALSE 
         #        CALL cl_err()
         #     END IF 
         #END IF
      END IF
      #141202-00061#17
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
      DELETE FROM apdc_t
       WHERE apdcent = g_enterprise AND
             apdcld = g_apda_m.apdald AND apdcdocno = g_apda_m.apdadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
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
         CLOSE aapt430_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apce_d.clear() 
      CALL g_apce2_d.clear()       
 
     
      CALL aapt430_ui_browser_refresh()  
      #CALL aapt430_ui_headershow()  
      #CALL aapt430_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt430_browser_fill("")
         CALL aapt430_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt430_cl
 
   #功能已完成,通報訊息中心
   CALL aapt430_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt430.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt430_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_desc     LIKE type_t.chr500 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apce_d.clear()
   CALL g_apce2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt430_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apceseq,apce001,apce002,apceorga,apce003,apce004,apce005,apce038, 
             apce047,apce048,apce119,apce129,apce139,apce010,apce015,apce016,apce017,apce018,apce019, 
             apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053, 
             apce054,apce055,apce056,apce057,apce058,apce059,apce060,apcecomp,apcelegl,apcesite,apce027, 
             apce028,apce031,apce032,apce100,apce101,apce109,apce120,apce121,apce130,apce131,apce104, 
             apce114,apce124,apce134 ,t1.ooefl003 FROM apce_t",   
                     " INNER JOIN apda_t ON apdaent = " ||g_enterprise|| " AND apdald = apceld ",
                     " AND apdadocno = apcedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=apceorga AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE apceent=? AND apceld=? AND apcedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
            LET g_wc2_table1 = g_wc2_table1 CLIPPED,
                            " AND (apcedocno,apceseq) IN (SELECT apdcdocno,apdcseq FROM apdc_t ",
                                                         " WHERE apceent = apdcent ",
                                                         "   AND apcedocno = apdcdocno ",
                                                         "   AND apceseq = apdcseq ",
                                                         "   AND ",g_wc2_table2 CLIPPED,")"
         END IF
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apce_t.apceseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt430_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt430_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno INTO g_apce_d[l_ac].apceseq, 
          g_apce_d[l_ac].apce001,g_apce_d[l_ac].apce002,g_apce_d[l_ac].apceorga,g_apce_d[l_ac].apce003, 
          g_apce_d[l_ac].apce004,g_apce_d[l_ac].apce005,g_apce_d[l_ac].apce038,g_apce_d[l_ac].apce047, 
          g_apce_d[l_ac].apce048,g_apce_d[l_ac].apce119,g_apce_d[l_ac].apce129,g_apce_d[l_ac].apce139, 
          g_apce_d[l_ac].apce010,g_apce_d[l_ac].apce015,g_apce_d[l_ac].apce016,g_apce_d[l_ac].apce017, 
          g_apce_d[l_ac].apce018,g_apce_d[l_ac].apce019,g_apce_d[l_ac].apce020,g_apce_d[l_ac].apce022, 
          g_apce_d[l_ac].apce023,g_apce_d[l_ac].apce035,g_apce_d[l_ac].apce036,g_apce_d[l_ac].apce044, 
          g_apce_d[l_ac].apce045,g_apce_d[l_ac].apce046,g_apce_d[l_ac].apce051,g_apce_d[l_ac].apce052, 
          g_apce_d[l_ac].apce053,g_apce_d[l_ac].apce054,g_apce_d[l_ac].apce055,g_apce_d[l_ac].apce056, 
          g_apce_d[l_ac].apce057,g_apce_d[l_ac].apce058,g_apce_d[l_ac].apce059,g_apce_d[l_ac].apce060, 
          g_apce_d[l_ac].apcecomp,g_apce_d[l_ac].apcelegl,g_apce_d[l_ac].apcesite,g_apce_d[l_ac].apce027, 
          g_apce_d[l_ac].apce028,g_apce_d[l_ac].apce031,g_apce_d[l_ac].apce032,g_apce_d[l_ac].apce100, 
          g_apce_d[l_ac].apce101,g_apce_d[l_ac].apce109,g_apce_d[l_ac].apce120,g_apce_d[l_ac].apce121, 
          g_apce_d[l_ac].apce130,g_apce_d[l_ac].apce131,g_apce_d[l_ac].apce104,g_apce_d[l_ac].apce114, 
          g_apce_d[l_ac].apce124,g_apce_d[l_ac].apce134,g_apce_d[l_ac].apceorga_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #來源帳款---------------------------------------
         #取得單身其他資訊
         LET g_apce_d[l_ac].apca001 = g_apce_d[l_ac].apce002      #151218-00004#1
         CALL aapt430_apce_msg(l_ac)
         #固定核算項
         LET g_apce_d[l_ac].apce016_desc = s_desc_show1(g_apce_d[l_ac].apce016,s_desc_get_account_desc(g_apda_m.apdald,g_apce_d[l_ac].apce016))
         LET g_apce_d[l_ac].apce017_desc = s_desc_show1(g_apce_d[l_ac].apce017,s_desc_get_person_desc(g_apce_d[l_ac].apce017))
         LET g_apce_d[l_ac].apce018_desc = s_desc_show1(g_apce_d[l_ac].apce018,s_desc_get_department_desc(g_apce_d[l_ac].apce018))
         LET g_apce_d[l_ac].apce019_desc = s_desc_show1(g_apce_d[l_ac].apce019,s_desc_get_department_desc(g_apce_d[l_ac].apce019))
         LET g_apce_d[l_ac].apce020_desc = s_desc_show1(g_apce_d[l_ac].apce020,s_desc_get_rtaxl003_desc(g_apce_d[l_ac].apce020))
         LET g_apce_d[l_ac].apce022_desc = s_desc_show1(g_apce_d[l_ac].apce022,s_desc_get_project_desc(g_apce_d[l_ac].apce022))
         #140806-00012#8 add---
         LET g_apce_d[l_ac].apce023_desc = s_desc_show1(g_apce_d[l_ac].apce023,s_desc_get_pjbbl004_desc(g_apce_d[l_ac].apce022,g_apce_d[l_ac].apce023))
         #140806-00012#8 add end---
         LET g_apce_d[l_ac].apce035_desc = s_desc_show1(g_apce_d[l_ac].apce035,s_desc_get_acc_desc('287',g_apce_d[l_ac].apce035))
         LET g_apce_d[l_ac].apce036_desc = s_desc_show1(g_apce_d[l_ac].apce036,s_desc_get_acc_desc('281',g_apce_d[l_ac].apce036))
         LET g_apce_d[l_ac].apce044_desc = g_apce_d[l_ac].apce044
         LET g_apce_d[l_ac].apce045_desc = s_desc_show1(g_apce_d[l_ac].apce045,s_desc_get_oojdl003_desc(g_apce_d[l_ac].apce045))
         LET g_apce_d[l_ac].apce046_desc = s_desc_show1(g_apce_d[l_ac].apce046,s_desc_get_acc_desc('2002',g_apce_d[l_ac].apce046))
         #取得自由核算項類型 #150330
         #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'ALL') RETURNING g_glad.*
         CALL s_fin_sel_glad(g_apda_m.apdald,g_apce_d[l_ac].apce016,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_apce_d[l_ac].apce051_desc) THEN
            LET g_apce_d[l_ac].apce051_desc = s_desc_show1(g_apce_d[l_ac].apce051,s_fin_get_accting_desc(g_glad.glad0171,g_apce_d[l_ac].apce051))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce052_desc) THEN
            LET g_apce_d[l_ac].apce052_desc = s_desc_show1(g_apce_d[l_ac].apce052,s_fin_get_accting_desc(g_glad.glad0181,g_apce_d[l_ac].apce052))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce053_desc) THEN
            LET g_apce_d[l_ac].apce053_desc = s_desc_show1(g_apce_d[l_ac].apce053,s_fin_get_accting_desc(g_glad.glad0191,g_apce_d[l_ac].apce053))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce054_desc) THEN
            LET g_apce_d[l_ac].apce054_desc = s_desc_show1(g_apce_d[l_ac].apce054,s_fin_get_accting_desc(g_glad.glad0201,g_apce_d[l_ac].apce054))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce055_desc) THEN
            LET g_apce_d[l_ac].apce055_desc = s_desc_show1(g_apce_d[l_ac].apce055,s_fin_get_accting_desc(g_glad.glad0211,g_apce_d[l_ac].apce055))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce056_desc) THEN
            LET g_apce_d[l_ac].apce056_desc = s_desc_show1(g_apce_d[l_ac].apce056,s_fin_get_accting_desc(g_glad.glad0221,g_apce_d[l_ac].apce056))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce057_desc) THEN
            LET g_apce_d[l_ac].apce057_desc = s_desc_show1(g_apce_d[l_ac].apce057,s_fin_get_accting_desc(g_glad.glad0231,g_apce_d[l_ac].apce057))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce058_desc) THEN
            LET g_apce_d[l_ac].apce058_desc = s_desc_show1(g_apce_d[l_ac].apce058,s_fin_get_accting_desc(g_glad.glad0241,g_apce_d[l_ac].apce058))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce059_desc) THEN
            LET g_apce_d[l_ac].apce059_desc = s_desc_show1(g_apce_d[l_ac].apce059,s_fin_get_accting_desc(g_glad.glad0251,g_apce_d[l_ac].apce059))
         END IF
         IF NOT cl_null(g_apce_d[l_ac].apce060_desc) THEN
            LET g_apce_d[l_ac].apce060_desc = s_desc_show1(g_apce_d[l_ac].apce060,s_fin_get_accting_desc(g_glad.glad0261,g_apce_d[l_ac].apce060))
         END IF
         
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
   IF aapt430_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apdcseq,apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,apdc009, 
             apdc111,apdc113,apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005,apdc006,apdc041, 
             apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,apdc022,apdc023,apdc024,apdc025,apdc027, 
             apdc028,apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,apdc036,apdc037,apdc038,apdc039, 
             apdc040,apdccomp,apdcsite ,t2.ooefl003 FROM apdc_t",   
                     " INNER JOIN  apda_t ON apdaent = " ||g_enterprise|| " AND apdald = apdcld ",
                     " AND apdadocno = apdcdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=apdcsite AND t2.ooefl002='"||g_dlang||"' ",
 
                     " WHERE apdcent=? AND apdcld=? AND apdcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apdc_t.apdcseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt430_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt430_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno INTO g_apce2_d[l_ac].apdcseq, 
          g_apce2_d[l_ac].apdc001,g_apce2_d[l_ac].apdcorga,g_apce2_d[l_ac].apdc002,g_apce2_d[l_ac].apdc003, 
          g_apce2_d[l_ac].apdc004,g_apce2_d[l_ac].apdc008,g_apce2_d[l_ac].apdc009,g_apce2_d[l_ac].apdc111, 
          g_apce2_d[l_ac].apdc113,g_apce2_d[l_ac].apdc211,g_apce2_d[l_ac].apdc213,g_apce2_d[l_ac].apdc123, 
          g_apce2_d[l_ac].apdc223,g_apce2_d[l_ac].apdc133,g_apce2_d[l_ac].apdc233,g_apce2_d[l_ac].apdc005, 
          g_apce2_d[l_ac].apdc006,g_apce2_d[l_ac].apdc041,g_apce2_d[l_ac].apdc015,g_apce2_d[l_ac].apdc007, 
          g_apce2_d[l_ac].apdc017,g_apce2_d[l_ac].apdc018,g_apce2_d[l_ac].apdc019,g_apce2_d[l_ac].apdc020, 
          g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023,g_apce2_d[l_ac].apdc024,g_apce2_d[l_ac].apdc025, 
          g_apce2_d[l_ac].apdc027,g_apce2_d[l_ac].apdc028,g_apce2_d[l_ac].apdc029,g_apce2_d[l_ac].apdc031, 
          g_apce2_d[l_ac].apdc032,g_apce2_d[l_ac].apdc033,g_apce2_d[l_ac].apdc034,g_apce2_d[l_ac].apdc035, 
          g_apce2_d[l_ac].apdc036,g_apce2_d[l_ac].apdc037,g_apce2_d[l_ac].apdc038,g_apce2_d[l_ac].apdc039, 
          g_apce2_d[l_ac].apdc040,g_apce2_d[l_ac].apdccomp,g_apce2_d[l_ac].apdcsite,g_apce2_d[l_ac].apdcorga_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL s_desc_get_item_desc(g_apce2_d[l_ac].apdc004)
                       RETURNING g_apce2_d[l_ac].imaal003,l_desc
         #目的帳款---------------------------------------
         #固定核算項
         LET g_apce2_d[l_ac].apdc007_desc = s_desc_show1(g_apce2_d[l_ac].apdc007,s_desc_get_account_desc(g_apda_m.apdald,g_apce2_d[l_ac].apdc007))
         LET g_apce2_d[l_ac].apdc017_desc = s_desc_show1(g_apce2_d[l_ac].apdc017,s_desc_get_person_desc(g_apce2_d[l_ac].apdc017))
         LET g_apce2_d[l_ac].apdc018_desc = s_desc_show1(g_apce2_d[l_ac].apdc018,s_desc_get_department_desc(g_apce2_d[l_ac].apdc018))
         LET g_apce2_d[l_ac].apdc019_desc = s_desc_show1(g_apce2_d[l_ac].apdc019,s_desc_get_department_desc(g_apce2_d[l_ac].apdc019))
         LET g_apce2_d[l_ac].apdc020_desc = s_desc_show1(g_apce2_d[l_ac].apdc020,s_desc_get_rtaxl003_desc(g_apce2_d[l_ac].apdc020))
         LET g_apce2_d[l_ac].apdc022_desc = s_desc_show1(g_apce2_d[l_ac].apdc022,s_desc_get_project_desc(g_apce2_d[l_ac].apdc022))
         #140806-00012#8 add---
         LET g_apce2_d[l_ac].apdc023_desc = s_desc_show1(g_apce2_d[l_ac].apdc023,s_desc_get_pjbbl004_desc(g_apce2_d[l_ac].apdc022,g_apce2_d[l_ac].apdc023))
         #140806-00012#8 add end---
         LET g_apce2_d[l_ac].apdc024_desc = s_desc_show1(g_apce2_d[l_ac].apdc024,s_desc_get_acc_desc('287',g_apce2_d[l_ac].apdc024))
         LET g_apce2_d[l_ac].apdc025_desc = s_desc_show1(g_apce2_d[l_ac].apdc025,s_desc_get_acc_desc('281',g_apce2_d[l_ac].apdc025))
         LET g_apce2_d[l_ac].apdc027_desc = g_apce2_d[l_ac].apdc027
         LET g_apce2_d[l_ac].apdc028_desc = s_desc_show1(g_apce2_d[l_ac].apdc028,s_desc_get_oojdl003_desc(g_apce2_d[l_ac].apdc028))
         LET g_apce2_d[l_ac].apdc029_desc = s_desc_show1(g_apce2_d[l_ac].apdc029,s_desc_get_acc_desc('2002',g_apce2_d[l_ac].apdc029))
         #取得自由核算項類型 #150330
         #CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'ALL') RETURNING g_glad.*
         CALL s_fin_sel_glad(g_apda_m.apdald,g_apce2_d[l_ac].apdc007,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_apce2_d[l_ac].apdc031_desc) THEN
            LET g_apce2_d[l_ac].apdc031_desc = s_desc_show1(g_apce2_d[l_ac].apdc031,s_fin_get_accting_desc(g_glad.glad0171,g_apce2_d[l_ac].apdc031))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc032_desc) THEN
            LET g_apce2_d[l_ac].apdc032_desc = s_desc_show1(g_apce2_d[l_ac].apdc032,s_fin_get_accting_desc(g_glad.glad0181,g_apce2_d[l_ac].apdc032))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc033_desc) THEN
            LET g_apce2_d[l_ac].apdc033_desc = s_desc_show1(g_apce2_d[l_ac].apdc033,s_fin_get_accting_desc(g_glad.glad0191,g_apce2_d[l_ac].apdc033))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc034_desc) THEN
            LET g_apce2_d[l_ac].apdc034_desc = s_desc_show1(g_apce2_d[l_ac].apdc034,s_fin_get_accting_desc(g_glad.glad0201,g_apce2_d[l_ac].apdc034))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc035_desc) THEN
            LET g_apce2_d[l_ac].apdc035_desc = s_desc_show1(g_apce2_d[l_ac].apdc035,s_fin_get_accting_desc(g_glad.glad0211,g_apce2_d[l_ac].apdc035))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc036_desc) THEN
            LET g_apce2_d[l_ac].apdc036_desc = s_desc_show1(g_apce2_d[l_ac].apdc036,s_fin_get_accting_desc(g_glad.glad0221,g_apce2_d[l_ac].apdc036))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc037_desc) THEN
            LET g_apce2_d[l_ac].apdc037_desc = s_desc_show1(g_apce2_d[l_ac].apdc037,s_fin_get_accting_desc(g_glad.glad0231,g_apce2_d[l_ac].apdc037))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc038_desc) THEN
            LET g_apce2_d[l_ac].apdc038_desc = s_desc_show1(g_apce2_d[l_ac].apdc038,s_fin_get_accting_desc(g_glad.glad0241,g_apce2_d[l_ac].apdc038))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc039_desc) THEN
            LET g_apce2_d[l_ac].apdc039_desc = s_desc_show1(g_apce2_d[l_ac].apdc039,s_fin_get_accting_desc(g_glad.glad0251,g_apce2_d[l_ac].apdc039))
         END IF
         IF NOT cl_null(g_apce2_d[l_ac].apdc040_desc) THEN
            LET g_apce2_d[l_ac].apdc040_desc = s_desc_show1(g_apce2_d[l_ac].apdc040,s_fin_get_accting_desc(g_glad.glad0261,g_apce2_d[l_ac].apdc040))
         END IF
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
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt430_pb
   FREE aapt430_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apce_d.getLength()
      LET g_apce_d_mask_o[l_ac].* =  g_apce_d[l_ac].*
      CALL aapt430_apce_t_mask()
      LET g_apce_d_mask_n[l_ac].* =  g_apce_d[l_ac].*
   END FOR
   
   LET g_apce2_d_mask_o.* =  g_apce2_d.*
   FOR l_ac = 1 TO g_apce2_d.getLength()
      LET g_apce2_d_mask_o[l_ac].* =  g_apce2_d[l_ac].*
      CALL aapt430_apdc_t_mask()
      LET g_apce2_d_mask_n[l_ac].* =  g_apce2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt430_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
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
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apdc_t
       WHERE apdcent = g_enterprise AND
             apdcld = ps_keys_bak[1] AND apdcdocno = ps_keys_bak[2] AND apdcseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apce2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt430_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET g_apce_d[g_detail_idx].apce002 = g_apce_d[g_detail_idx].apca001        #151218-00004#1
      #end add-point 
      INSERT INTO apce_t
                  (apceent,
                   apceld,apcedocno,
                   apceseq
                   ,apce001,apce002,apceorga,apce003,apce004,apce005,apce038,apce047,apce048,apce119,apce129,apce139,apce010,apce015,apce016,apce017,apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apcecomp,apcelegl,apcesite,apce027,apce028,apce031,apce032,apce100,apce101,apce109,apce120,apce121,apce130,apce131,apce104,apce114,apce124,apce134) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apce_d[g_detail_idx].apce001,g_apce_d[g_detail_idx].apce002,g_apce_d[g_detail_idx].apceorga, 
                       g_apce_d[g_detail_idx].apce003,g_apce_d[g_detail_idx].apce004,g_apce_d[g_detail_idx].apce005, 
                       g_apce_d[g_detail_idx].apce038,g_apce_d[g_detail_idx].apce047,g_apce_d[g_detail_idx].apce048, 
                       g_apce_d[g_detail_idx].apce119,g_apce_d[g_detail_idx].apce129,g_apce_d[g_detail_idx].apce139, 
                       g_apce_d[g_detail_idx].apce010,g_apce_d[g_detail_idx].apce015,g_apce_d[g_detail_idx].apce016, 
                       g_apce_d[g_detail_idx].apce017,g_apce_d[g_detail_idx].apce018,g_apce_d[g_detail_idx].apce019, 
                       g_apce_d[g_detail_idx].apce020,g_apce_d[g_detail_idx].apce022,g_apce_d[g_detail_idx].apce023, 
                       g_apce_d[g_detail_idx].apce035,g_apce_d[g_detail_idx].apce036,g_apce_d[g_detail_idx].apce044, 
                       g_apce_d[g_detail_idx].apce045,g_apce_d[g_detail_idx].apce046,g_apce_d[g_detail_idx].apce051, 
                       g_apce_d[g_detail_idx].apce052,g_apce_d[g_detail_idx].apce053,g_apce_d[g_detail_idx].apce054, 
                       g_apce_d[g_detail_idx].apce055,g_apce_d[g_detail_idx].apce056,g_apce_d[g_detail_idx].apce057, 
                       g_apce_d[g_detail_idx].apce058,g_apce_d[g_detail_idx].apce059,g_apce_d[g_detail_idx].apce060, 
                       g_apce_d[g_detail_idx].apcecomp,g_apce_d[g_detail_idx].apcelegl,g_apce_d[g_detail_idx].apcesite, 
                       g_apce_d[g_detail_idx].apce027,g_apce_d[g_detail_idx].apce028,g_apce_d[g_detail_idx].apce031, 
                       g_apce_d[g_detail_idx].apce032,g_apce_d[g_detail_idx].apce100,g_apce_d[g_detail_idx].apce101, 
                       g_apce_d[g_detail_idx].apce109,g_apce_d[g_detail_idx].apce120,g_apce_d[g_detail_idx].apce121, 
                       g_apce_d[g_detail_idx].apce130,g_apce_d[g_detail_idx].apce131,g_apce_d[g_detail_idx].apce104, 
                       g_apce_d[g_detail_idx].apce114,g_apce_d[g_detail_idx].apce124,g_apce_d[g_detail_idx].apce134) 
 
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
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO apdc_t
                  (apdcent,
                   apdcld,apdcdocno,
                   apdcseq
                   ,apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,apdc009,apdc111,apdc113,apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,apdc022,apdc023,apdc024,apdc025,apdc027,apdc028,apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,apdc036,apdc037,apdc038,apdc039,apdc040,apdccomp,apdcsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apce2_d[g_detail_idx].apdc001,g_apce2_d[g_detail_idx].apdcorga,g_apce2_d[g_detail_idx].apdc002, 
                       g_apce2_d[g_detail_idx].apdc003,g_apce2_d[g_detail_idx].apdc004,g_apce2_d[g_detail_idx].apdc008, 
                       g_apce2_d[g_detail_idx].apdc009,g_apce2_d[g_detail_idx].apdc111,g_apce2_d[g_detail_idx].apdc113, 
                       g_apce2_d[g_detail_idx].apdc211,g_apce2_d[g_detail_idx].apdc213,g_apce2_d[g_detail_idx].apdc123, 
                       g_apce2_d[g_detail_idx].apdc223,g_apce2_d[g_detail_idx].apdc133,g_apce2_d[g_detail_idx].apdc233, 
                       g_apce2_d[g_detail_idx].apdc005,g_apce2_d[g_detail_idx].apdc006,g_apce2_d[g_detail_idx].apdc041, 
                       g_apce2_d[g_detail_idx].apdc015,g_apce2_d[g_detail_idx].apdc007,g_apce2_d[g_detail_idx].apdc017, 
                       g_apce2_d[g_detail_idx].apdc018,g_apce2_d[g_detail_idx].apdc019,g_apce2_d[g_detail_idx].apdc020, 
                       g_apce2_d[g_detail_idx].apdc022,g_apce2_d[g_detail_idx].apdc023,g_apce2_d[g_detail_idx].apdc024, 
                       g_apce2_d[g_detail_idx].apdc025,g_apce2_d[g_detail_idx].apdc027,g_apce2_d[g_detail_idx].apdc028, 
                       g_apce2_d[g_detail_idx].apdc029,g_apce2_d[g_detail_idx].apdc031,g_apce2_d[g_detail_idx].apdc032, 
                       g_apce2_d[g_detail_idx].apdc033,g_apce2_d[g_detail_idx].apdc034,g_apce2_d[g_detail_idx].apdc035, 
                       g_apce2_d[g_detail_idx].apdc036,g_apce2_d[g_detail_idx].apdc037,g_apce2_d[g_detail_idx].apdc038, 
                       g_apce2_d[g_detail_idx].apdc039,g_apce2_d[g_detail_idx].apdc040,g_apce2_d[g_detail_idx].apdccomp, 
                       g_apce2_d[g_detail_idx].apdcsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apce2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt430_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apce_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      LET g_apce_d[g_detail_idx].apce002 = g_apce_d[g_detail_idx].apca001        #151218-00004#1
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt430_apce_t_mask_restore('restore_mask_o')
               
      UPDATE apce_t 
         SET (apceld,apcedocno,
              apceseq
              ,apce001,apce002,apceorga,apce003,apce004,apce005,apce038,apce047,apce048,apce119,apce129,apce139,apce010,apce015,apce016,apce017,apce018,apce019,apce020,apce022,apce023,apce035,apce036,apce044,apce045,apce046,apce051,apce052,apce053,apce054,apce055,apce056,apce057,apce058,apce059,apce060,apcecomp,apcelegl,apcesite,apce027,apce028,apce031,apce032,apce100,apce101,apce109,apce120,apce121,apce130,apce131,apce104,apce114,apce124,apce134) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apce_d[g_detail_idx].apce001,g_apce_d[g_detail_idx].apce002,g_apce_d[g_detail_idx].apceorga, 
                  g_apce_d[g_detail_idx].apce003,g_apce_d[g_detail_idx].apce004,g_apce_d[g_detail_idx].apce005, 
                  g_apce_d[g_detail_idx].apce038,g_apce_d[g_detail_idx].apce047,g_apce_d[g_detail_idx].apce048, 
                  g_apce_d[g_detail_idx].apce119,g_apce_d[g_detail_idx].apce129,g_apce_d[g_detail_idx].apce139, 
                  g_apce_d[g_detail_idx].apce010,g_apce_d[g_detail_idx].apce015,g_apce_d[g_detail_idx].apce016, 
                  g_apce_d[g_detail_idx].apce017,g_apce_d[g_detail_idx].apce018,g_apce_d[g_detail_idx].apce019, 
                  g_apce_d[g_detail_idx].apce020,g_apce_d[g_detail_idx].apce022,g_apce_d[g_detail_idx].apce023, 
                  g_apce_d[g_detail_idx].apce035,g_apce_d[g_detail_idx].apce036,g_apce_d[g_detail_idx].apce044, 
                  g_apce_d[g_detail_idx].apce045,g_apce_d[g_detail_idx].apce046,g_apce_d[g_detail_idx].apce051, 
                  g_apce_d[g_detail_idx].apce052,g_apce_d[g_detail_idx].apce053,g_apce_d[g_detail_idx].apce054, 
                  g_apce_d[g_detail_idx].apce055,g_apce_d[g_detail_idx].apce056,g_apce_d[g_detail_idx].apce057, 
                  g_apce_d[g_detail_idx].apce058,g_apce_d[g_detail_idx].apce059,g_apce_d[g_detail_idx].apce060, 
                  g_apce_d[g_detail_idx].apcecomp,g_apce_d[g_detail_idx].apcelegl,g_apce_d[g_detail_idx].apcesite, 
                  g_apce_d[g_detail_idx].apce027,g_apce_d[g_detail_idx].apce028,g_apce_d[g_detail_idx].apce031, 
                  g_apce_d[g_detail_idx].apce032,g_apce_d[g_detail_idx].apce100,g_apce_d[g_detail_idx].apce101, 
                  g_apce_d[g_detail_idx].apce109,g_apce_d[g_detail_idx].apce120,g_apce_d[g_detail_idx].apce121, 
                  g_apce_d[g_detail_idx].apce130,g_apce_d[g_detail_idx].apce131,g_apce_d[g_detail_idx].apce104, 
                  g_apce_d[g_detail_idx].apce114,g_apce_d[g_detail_idx].apce124,g_apce_d[g_detail_idx].apce134)  
 
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
      CALL aapt430_apce_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apdc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt430_apdc_t_mask_restore('restore_mask_o')
               
      UPDATE apdc_t 
         SET (apdcld,apdcdocno,
              apdcseq
              ,apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,apdc009,apdc111,apdc113,apdc211,apdc213,apdc123,apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,apdc022,apdc023,apdc024,apdc025,apdc027,apdc028,apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,apdc036,apdc037,apdc038,apdc039,apdc040,apdccomp,apdcsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apce2_d[g_detail_idx].apdc001,g_apce2_d[g_detail_idx].apdcorga,g_apce2_d[g_detail_idx].apdc002, 
                  g_apce2_d[g_detail_idx].apdc003,g_apce2_d[g_detail_idx].apdc004,g_apce2_d[g_detail_idx].apdc008, 
                  g_apce2_d[g_detail_idx].apdc009,g_apce2_d[g_detail_idx].apdc111,g_apce2_d[g_detail_idx].apdc113, 
                  g_apce2_d[g_detail_idx].apdc211,g_apce2_d[g_detail_idx].apdc213,g_apce2_d[g_detail_idx].apdc123, 
                  g_apce2_d[g_detail_idx].apdc223,g_apce2_d[g_detail_idx].apdc133,g_apce2_d[g_detail_idx].apdc233, 
                  g_apce2_d[g_detail_idx].apdc005,g_apce2_d[g_detail_idx].apdc006,g_apce2_d[g_detail_idx].apdc041, 
                  g_apce2_d[g_detail_idx].apdc015,g_apce2_d[g_detail_idx].apdc007,g_apce2_d[g_detail_idx].apdc017, 
                  g_apce2_d[g_detail_idx].apdc018,g_apce2_d[g_detail_idx].apdc019,g_apce2_d[g_detail_idx].apdc020, 
                  g_apce2_d[g_detail_idx].apdc022,g_apce2_d[g_detail_idx].apdc023,g_apce2_d[g_detail_idx].apdc024, 
                  g_apce2_d[g_detail_idx].apdc025,g_apce2_d[g_detail_idx].apdc027,g_apce2_d[g_detail_idx].apdc028, 
                  g_apce2_d[g_detail_idx].apdc029,g_apce2_d[g_detail_idx].apdc031,g_apce2_d[g_detail_idx].apdc032, 
                  g_apce2_d[g_detail_idx].apdc033,g_apce2_d[g_detail_idx].apdc034,g_apce2_d[g_detail_idx].apdc035, 
                  g_apce2_d[g_detail_idx].apdc036,g_apce2_d[g_detail_idx].apdc037,g_apce2_d[g_detail_idx].apdc038, 
                  g_apce2_d[g_detail_idx].apdc039,g_apce2_d[g_detail_idx].apdc040,g_apce2_d[g_detail_idx].apdccomp, 
                  g_apce2_d[g_detail_idx].apdcsite) 
         WHERE apdcent = g_enterprise AND apdcld = ps_keys_bak[1] AND apdcdocno = ps_keys_bak[2] AND apdcseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apdc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apdc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt430_apdc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aapt430.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt430_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt430.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt430_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt430.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt430_lock_b(ps_table,ps_page)
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
   #CALL aapt430_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apce_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt430_bcl USING g_enterprise,
                                       g_apda_m.apdald,g_apda_m.apdadocno,g_apce_d[g_detail_idx].apceseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt430_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "apdc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt430_bcl2 USING g_enterprise,
                                             g_apda_m.apdald,g_apda_m.apdadocno,g_apce2_d[g_detail_idx].apdcseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt430_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aapt430.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt430_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt430_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt430_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt430_set_entry(p_cmd)
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
      CALL cl_set_comp_entry("apdadocdt",TRUE)  #Reanna 150205 add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt430_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apdald,apdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
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
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_glaa.glaacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("apdadocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt430_set_entry_b(p_cmd)
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
 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt430_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt430_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   #單據未確認前才可以重分攤計算
   IF g_apda_m.apdastus NOT MATCHES "[Y]" THEN
      CALL cl_set_act_visible("recountbody", TRUE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt430_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_apda_m.apdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #單據未確認前才可以重分攤計算
   IF g_apda_m.apdastus MATCHES "[Y]" THEN
      CALL cl_set_act_visible("recountbody", FALSE)
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
 
{<section id="aapt430.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt430_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt430_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt430_default_search()
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
               WHEN la_wc[li_idx].tableid = "apdc_t" 
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
 
{<section id="aapt430.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt430_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
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
   
   OPEN aapt430_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF STATUS THEN
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt430_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite,g_apda_m.apdald, 
       g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
       g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
       g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp, 
       g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc,g_apda_m.apda003_desc, 
       g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc, 
       g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt430_action_chk() THEN
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apdald,g_apda_m.apdald_desc,g_apda_m.apdadocno, 
       g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133,g_apda_m.apdacomp, 
       g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003,g_apda_m.apda003_desc, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda113,g_apda_m.l_sum_apdc113213,g_apda_m.l_sum_apceapdc, 
       g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid, 
       g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid, 
       g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt, 
       g_apda_m.apdapstid,g_apda_m.apdapstid_desc,g_apda_m.apdapstdt,g_apda_m.l_sumcost,g_apda_m.l_sumdiscount, 
       g_apda_m.l_sumprepay
 
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
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aapt430_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt430_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt430_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt430_cl
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
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'Y' THEN
      IF g_apda_m.apdastus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_aapt430_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                    #150401-00001#13
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               CALL cl_err_collect_show()
               RETURN                                 #150401-00001#13
            ELSE
               CALL s_transaction_begin()
               CALL s_aapt430_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
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
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      CALL s_aapt430_unconf_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                    #150401-00001#13
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                 #150401-00001#13
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt430_unconf_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
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
   #作廢
   IF lc_state = 'X' THEN
      CALL cl_err_collect_init()
      CALL s_aapt430_void_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                    #150401-00001#13
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行取消作廢？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                 #150401-00001#13
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt430_void_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
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
      EXECUTE aapt430_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apdasite, 
          g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123, 
          g_apda_m.apda133,g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021, 
          g_apda_m.apda003,g_apda_m.apda018,g_apda_m.apda113,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid, 
          g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid, 
          g_apda_m.apdacnfdt,g_apda_m.apdapstid,g_apda_m.apdapstdt,g_apda_m.apdasite_desc,g_apda_m.apdald_desc, 
          g_apda_m.apda003_desc,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc, 
          g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc,g_apda_m.apdapstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apdald,g_apda_m.apdald_desc, 
          g_apda_m.apdadocno,g_apda_m.apdadocdt,g_apda_m.apda014,g_apda_m.apda001,g_apda_m.apda123,g_apda_m.apda133, 
          g_apda_m.apdacomp,g_apda_m.apdastus,g_apda_m.apda019,g_apda_m.apda020,g_apda_m.apda021,g_apda_m.apda003, 
          g_apda_m.apda003_desc,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda113,g_apda_m.l_sum_apdc113213, 
          g_apda_m.l_sum_apceapdc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
          g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
          g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
          g_apda_m.apdacnfdt,g_apda_m.apdapstid,g_apda_m.apdapstid_desc,g_apda_m.apdapstdt,g_apda_m.l_sumcost, 
          g_apda_m.l_sumdiscount,g_apda_m.l_sumprepay
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT apdamodid,apdamoddt,apdacnfid,apdacnfdt
     INTO g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
   DISPLAY BY NAME g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   #151125-00006#2--s
   IF g_apda_m.apdastus = 'Y' THEN
      CALL aapt430_immediately_gen()
      CALL aapt430_ui_headershow()
   END IF
   #151125-00006#2--e
   #end add-point  
 
   CLOSE aapt430_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt430_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt430.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt430_idx_chk()
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
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt430_b_fill2(pi_idx)
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
   
   CALL aapt430_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt430_fill_chk(ps_idx)
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
 
{<section id="aapt430.status_show" >}
PRIVATE FUNCTION aapt430_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt430.mask_functions" >}
&include "erp/aap/aapt430_mask.4gl"
 
{</section>}
 
{<section id="aapt430.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt430_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aapt430_show()
   CALL aapt430_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_aapt430_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
      CLOSE aapt430_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apce_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_apce2_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt430_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt430_ui_headershow()
   CALL aapt430_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt430_draw_out()
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
   CALL aapt430_ui_headershow()  
   CALL aapt430_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt430.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt430_set_pk_array()
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
 
{<section id="aapt430.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt430.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt430_msgcentre_notify(lc_state)
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
   CALL aapt430_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt430.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt430_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#1   2016/08/23  By 07900   --add--s-
   SELECT apdastus INTO g_apda_m.apdastus
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdadocno= g_apda_m.apdadocno
      AND apdald = g_apda_m.apdald
      
   
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail") THEN
     LET g_errno = NULL
     CASE g_apda_m.apdastus
        
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_apda_m.apdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aapt430_set_act_visible()
        CALL aapt430_set_act_no_visible()
        CALL aapt430_show()
        RETURN FALSE
     END IF
   END IF  
   #160818-00017#1   2016/08/23  By 07900   --add--e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt430.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳務中心下所屬成員
# Memo...........:
# Usage..........: CALL aapt430_set_ld_info(p_ld)

# Date & Author..: 2014/12/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_set_ld_info(p_ld)
DEFINE p_ld        LIKE apca_t.apcald
DEFINE l_glaa015   LIKE glaa_t.glaa015
DEFINE l_glaa019   LIKE glaa_t.glaa019
   
   #CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa121')        #160628-00001#1 mark
   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa120|glaa121') #160628-00001#1
        RETURNING g_sub_success,g_glaa.*
   LET g_apda_m.apdacomp = g_glaa.glaacomp
   CALL s_fin_get_wc_str(g_apda_m.apdacomp) RETURNING g_comp_str  #161229-00047#47 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#47 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apda_m.apdacomp) RETURNING g_sub_success,g_sql_ctrl #161114-00017#2 add 控制組 #161229-00047#47 mark
   #160816-00022#1--s
   #取得沖銷參數
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-2002') RETURNING g_s_fin_2002
   #160816-00022#1--e
   #取得帳務中心下所屬成員
   CALL s_fin_account_center_sons_query('3',g_apda_m.apdasite,g_apda_m.apdadocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
   CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
   CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
   
   #單身本位幣二&三顯示否
   CALL cl_set_comp_visible('l_sum_apcb123,apce129,l_sum_apcb133,apce139',TRUE)
   CALL cl_set_comp_visible('apdc123,apdc223,apdc133,apdc233',TRUE)
   IF g_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('l_sum_apcb123,apce129',FALSE)
      CALL cl_set_comp_visible('apdc123,apdc223',FALSE)
   END IF
   IF g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('l_sum_apcb133,apce139',FALSE)
      CALL cl_set_comp_visible('apdc133,apdc233',FALSE)
   END IF
   
   #是否啟用分錄底稿
   #141202-00061#17
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("open_pre", FALSE)
   END IF
   #141202-00061#17
END FUNCTION

################################################################################
# Descriptions...: 單身來源明細之其他欄位資訊顯示
# Memo...........:
# Date & Author..: 14/08/14 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_apce_msg(p_ac)
   DEFINE p_ac   LIKE type_t.num5
   DEFINE l_apca RECORD
                 apca001       LIKE apca_t.apca001,
                 apca004       LIKE apca_t.apca004,
                 apca004_desc  LIKE type_t.chr1000,
                 apcb005       LIKE apcb_t.apcb005,
                 l_sum_apcb113 LIKE apcb_t.apcb113
                 END RECORD
   DEFINE l_sql  STRING
   DEFINE l_apca001  LIKE apca_t.apca001     #151207-00018#3
   #160816-00022#1--s
   DEFINE l_apcc108  LIKE apcc_t.apcc108
   DEFINE l_apcc118  LIKE apcc_t.apcc118
   DEFINE l_apcc128  LIKE apcc_t.apcc128
   DEFINE l_apcc138  LIKE apcc_t.apcc138
   DEFINE l_type     LIKE type_t.chr1
   #160816-00022#1--e   
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF

   #帳款單性質/帳款對象/本幣未稅帳款
  #SELECT apca001,apca004,apcc118         #151218-00004#1
  #  INTO g_apce_d[p_ac].apca001,g_apce_d[p_ac].apca004,g_apce_d[p_ac].l_sum_apcb113   #151218-00004#1
   #160816-00022#1 mark--s 
   #SELECT apca004,apcc118                 #151218-00004#1
   #  INTO g_apce_d[p_ac].apca004,g_apce_d[p_ac].l_sum_apcb113     #151218-00004#1
   #  FROM apca_t,apcc_t
   # WHERE apcaent   = apccent
   #   AND apcald    = apccld
   #   AND apcadocno = apccdocno
   #   AND apcaent   = g_enterprise
   #   AND apcald    = g_apda_m.apdald
   #   AND apcadocno = g_apce_d[p_ac].apce003
   #   AND apccseq   = g_apce_d[p_ac].apce004
   #   AND apcc001   = g_apce_d[p_ac].apce005
   #160816-00022#1 mark--e
   #160816-00022#1--s
   #改取apcb
   SELECT apca004,apcb113,apcb123,apcb133
     INTO g_apce_d[p_ac].apca004,g_apce_d[p_ac].l_sum_apcb113,g_apce_d[p_ac].l_sum_apcb123,g_apce_d[p_ac].l_sum_apcb133
     FROM apca_t,apcb_t
    WHERE apcaent   = apcbent
      AND apcald    = apcbld
      AND apcadocno = apcbdocno     
      AND apcaent   = g_enterprise
      AND apcald    = g_apda_m.apdald
      AND apcadocno = g_apce_d[p_ac].apce003
      AND apcbseq   = g_apce_d[p_ac].apce004

   #151207-00018#3--(S)
   IF cl_null(g_apce_d[p_ac].apca001) OR g_apce_d[p_ac].apca001 = '05' THEN
      SELECT apca004,apcf113,apca001
        INTO g_apce_d[p_ac].apca004,g_apce_d[p_ac].l_sum_apcb113,l_apca001
        FROM apca_t,apcf_t
       WHERE apcaent   = apcfent
         AND apcald    = apcfld AND apcadocno = apcfdocno
         AND apcaent   = g_enterprise AND apcald = g_apda_m.apdald
         AND apcadocno = g_apce_d[p_ac].apce003
         AND apcfseq   = g_apce_d[p_ac].apce004
         AND apcf008   = 'DIFF'
      IF NOT cl_null(g_apce_d[p_ac].apca004) THEN
        #LET g_apce_d[p_ac].apca001 = '05'         #151218-00004#1
         IF l_apca001[1,1] = '2' THEN
            LET g_apce_d[p_ac].l_sum_apcb113 = g_apce_d[p_ac].l_sum_apcb113 * -1
         END IF
      END IF
   END IF
   #151207-00018#3--(E)
   #帳款對象
   CALL s_desc_get_trading_partner_full_desc(g_apce_d[p_ac].apca004) RETURNING g_apce_d[p_ac].apca004_desc
   #160908-00045#1--add(s)
   CALL s_desc_get_department_desc(g_apce_d[l_ac].apceorga) RETURNING g_apce_d[l_ac].apceorga_desc
   DISPLAY BY NAME g_apce_d[l_ac].apceorga_desc
   #160908-00045#1--add(e)
END FUNCTION

################################################################################
# Descriptions...: 來源明細之單據開窗處理(array處理)
# Memo...........: 為應用在單身預設又要應用在自動產生單身
#                : 所以改用array方式塞值
# Date & Author..: 140812 By albireo 
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_source_doc_carry(p_ld,p_docno,p_seq,p_apcc001)
DEFINE p_ld      LIKE apda_t.apdald
DEFINE p_docno   LIKE apca_t.apcadocno
DEFINE p_seq     LIKE apcb_t.apcbseq
DEFINE p_apcc001 LIKE apcc_t.apcc001
DEFINE r_array    DYNAMIC ARRAY OF RECORD
                  chr     LIKE type_t.chr1000,
                  dat     LIKE type_t.dat
                  END RECORD   

#DEFINE l_apca    RECORD LIKE apca_t.* #161104-00024#4 mark
#DEFINE l_apcc    RECORD LIKE apcc_t.* #161104-00024#4 mark
#161104-00024#4-add(s)
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
#161104-00024#4-add(e)
#160816-00022#1--s
DEFINE l_apcb    RECORD     #應付憑單單身
                 apcblegl   LIKE apcb_t.apcblegl,
                 apcbsite   LIKE apcb_t.apcbsite,
                 apcb028    LIKE apcb_t.apcb028,
                 apcb102    LIKE apcb_t.apcb102,
                 apcb103    LIKE apcb_t.apcb103,
                 apcb113    LIKE apcb_t.apcb113,
                 apcb121    LIKE apcb_t.apcb121,
                 apcb123    LIKE apcb_t.apcb123,
                 apcb131    LIKE apcb_t.apcb131,
                 apcb133    LIKE apcb_t.apcb133
END RECORD
DEFINE l_apcc108  LIKE apcc_t.apcc108
DEFINE l_apcc118  LIKE apcc_t.apcc118
DEFINE l_apcc128  LIKE apcc_t.apcc128
DEFINE l_apcc138  LIKE apcc_t.apcc138
DEFINE l_type     LIKE type_t.chr1
#160816-00022#1--e
DEFINE l_sumapce RECORD
                 apce109    LIKE apce_t.apce109,   #160816-00022#1
                 apce119    LIKE apce_t.apce119,
                 apce129    LIKE apce_t.apce129,
                 apce139    LIKE apce_t.apce139
                 END RECORD
DEFINE l_sql           STRING
DEFINE l_apce        RECORD
                     apce017    LIKE apce_t.apce017,
                     apce018    LIKE apce_t.apce018,
                     apce019    LIKE apce_t.apce019, #責任中心
                     
                     apce020    LIKE apce_t.apce020, #產品類別
                     apce022    LIKE apce_t.apce022, #專案代號
                     apce023    LIKE apce_t.apce023, #WBS編號
                     
                     apce035    LIKE apce_t.apce035,
                     apce036    LIKE apce_t.apce036,
                     apce044    LIKE apce_t.apce044,
                     apce045    LIKE apce_t.apce045,
                     apce046    LIKE apce_t.apce046,
                     
                     apce051    LIKE apce_t.apce051,
                     apce052    LIKE apce_t.apce052,
                     apce053    LIKE apce_t.apce053,
                     apce054    LIKE apce_t.apce054,
                     apce055    LIKE apce_t.apce055,
                     
                     apce056    LIKE apce_t.apce056,
                     apce057    LIKE apce_t.apce057,
                     apce058    LIKE apce_t.apce058,
                     apce059    LIKE apce_t.apce059,
                     apce060    LIKE apce_t.apce060,
                     apce010    LIKE apce_t.apce010
                     END RECORD

   CALL r_array.clear()
   INITIALIZE l_apca.* TO NULL
  #INITIALIZE l_apcc.* TO NULL   #160816-00022#1 mark   
   
   #SELECT * INTO l_apca.* FROM apca_t   #161208-00026#9 mark
   #161208-00026#9-add(s)
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
     FROM apca_t
   #161208-00026#9-add(e)
    WHERE apcaent = g_enterprise
      AND apcald  = p_ld
      AND apcadocno = p_docno
   #160816-00022#1 mark--s
   ##單身改取apcc_t
   #SELECT * INTO l_apcc.* FROM apcc_t
   # WHERE apccent = g_enterprise
   #   AND apccld = p_ld
   #   AND apccdocno = p_docno
   #   AND apccseq   = p_seq
   #   AND apcc001 = p_apcc001
   #LET g_apce_d[l_ac].apcelegl = l_apcc.apcclegl
   #LET g_apce_d[l_ac].apceorga = l_apcc.apccsite
   #160816-00022#1 mark--e
   #160816-00022#1--s
   SELECT apcblegl,apcbsite,apcb028,apcb102,apcb103,
          apcb113,apcb121,apcb123,apcb131,apcb133 
     INTO l_apcb.*
     FROM apcb_t
    WHERE apcbent = g_enterprise
      AND apcbld = p_ld
      AND apcbdocno = p_docno
      AND apcbseq   = p_seq     
   LET g_apce_d[l_ac].apcelegl = l_apcb.apcblegl
   LET g_apce_d[l_ac].apceorga = l_apcb.apcbsite   
   #160816-00022#1--e   

      
   
   #抓apca001判斷是C或D
   LET g_apce_d[l_ac].apce015= s_fin_get_scc_value('8502',l_apca.apca001,'2')
   #這裡要先借貸反轉
   CASE
      WHEN g_apce_d[l_ac].apce015 = 'D'
         LET g_apce_d[l_ac].apce015 = 'C'
      WHEN g_apce_d[l_ac].apce015 = 'C'
         LET g_apce_d[l_ac].apce015 = 'D'
   END CASE
   #費用科目
   #160727-00028#1--add--start--
   IF cl_null(l_apca.apca036) THEN
      #170123-00045#1 --s mark
      #SELECT apcb021 INTO l_apca.apca036
      #  FROM apcb_t
      # WHERE apcbent = g_enterprise 
      #   AND apcbld  = p_ld 
      #   AND apcbdocno = p_docno
      #   AND apcb021 IS NOT NULL 
      #   AND ROWNUM = 1
      # ORDER BY apcbseq
      #170123-00045#1 --e mark
      #170123-00045#1 --s add
      LET l_sql = " SELECT apcb021 FROM apcb_t ",
                  "  WHERE apcbent = ",g_enterprise," AND apcbld  = '",p_ld,"'  ",
                  "    AND apcbdocno = '",p_docno,"' AND apcb021 IS NOT NULL  ",
                  "  ORDER BY apcbseq "
      PREPARE aapt430_apcb021_p FROM l_sql
      DECLARE aapt430_apcb021_c SCROLL CURSOR FOR aapt430_apcb021_p
      OPEN aapt430_apcb021_c
      FETCH FIRST aapt430_apcb021_c INTO l_apca.apca036
      CLOSE aapt430_apcb021_c        
      #170123-00045#1 --e add         
   END IF
   #160727-00028#1--add--end----
   LET g_apce_d[l_ac].apce016      = l_apca.apca036
   LET g_apce_d[l_ac].apce016_desc = l_apca.apca036
   #產生方式
   LET g_apce_d[l_ac].apce028 = 0
   #160816-00022#1 mark--s   
   ##發票號碼
   #LET g_apce_d[l_ac].apce048 = l_apcc.apcc009
   ##幣別
   #LET g_apce_d[l_ac].apce100 = l_apcc.apcc100
   ##匯率
   #LET g_apce_d[l_ac].apce101 = l_apcc.apcc101
   ##原幣apce109 = apcc108-apcc109
   #LET g_apce_d[l_ac].apce109 = l_apcc.apcc108 - l_apcc.apcc109
   #160816-00022#1 mark--e
   #160816-00022#1--s
   #發票號碼
   LET g_apce_d[l_ac].apce048 = ''
   #幣別
   LET g_apce_d[l_ac].apce100 = l_apca.apca100
   #匯率
   LET g_apce_d[l_ac].apce101 = l_apcb.apcb102
   #原幣金額
   LET g_apce_d[l_ac].apce109 = l_apcb.apcb103
   #本幣金額
   LET g_apce_d[l_ac].apce119 = l_apcb.apcb113
   #本位幣二幣別
   LET g_apce_d[l_ac].apce120 = l_apca.apca120
   #本位幣二匯率
   LET g_apce_d[l_ac].apce121 = l_apcb.apcb121
   #本幣二金額
   LET g_apce_d[l_ac].apce129 = l_apcb.apcb123
   #本位幣三幣別
   LET g_apce_d[l_ac].apce130 = l_apca.apca130
   #本位幣三匯率
   LET g_apce_d[l_ac].apce131 = l_apcb.apcb131
   #本幣三金額
   LET g_apce_d[l_ac].apce139 = l_apcb.apcb133
   #160816-00022#1--e
   
   #原幣應稅折抵稅額
   LET g_apce_d[l_ac].apce104 = 0
   #本幣應稅折抵稅額
   LET g_apce_d[l_ac].apce114 = 0
   #本位幣二應稅折抵稅額
   LET g_apce_d[l_ac].apce124 = 0
   #本位幣三應稅折抵稅額
   LET g_apce_d[l_ac].apce134 = 0

   #取得該項次已維護在分攤單身的金額
   #SELECT SUM(apce119),SUM(apce129),SUM(apce139)                                    #160816-00022#1 mark
   #  INTO l_sumapce.apce119,l_sumapce.apce129,l_sumapce.apce139                     #160816-00022#1 mark
    SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)                       #160816-00022#1
      INTO l_sumapce.apce109,l_sumapce.apce119,l_sumapce.apce129,l_sumapce.apce139   #160816-00022#1    
      FROM apce_t
      LEFT JOIN apda_t ON apceent = apdaent AND apceld = apdald AND apcedocno = apdadocno
     WHERE apceent = g_enterprise
       AND apce003 = p_docno
       AND apce004 = p_seq
      #AND apce005 = p_apcc001   #160816-00022#1 mark
       AND apdald = p_ld
       AND apdastus <> 'X'
       AND apda001 = '43'
       AND ((apcedocno <> g_apda_m.apdadocno) OR                                      #160816-00022#1
            (apcedocno  = g_apda_m.apdadocno AND apceseq <> g_apce_d[l_ac].apceseq))  #160816-00022#1
    IF cl_null(l_sumapce.apce109)THEN LET l_sumapce.apce109 = 0 END IF                #160816-00022#1
    IF cl_null(l_sumapce.apce119)THEN LET l_sumapce.apce119 = 0 END IF
    IF cl_null(l_sumapce.apce129)THEN LET l_sumapce.apce129 = 0 END IF
    IF cl_null(l_sumapce.apce139)THEN LET l_sumapce.apce139 = 0 END IF  
   #160816-00022#1--s
   LET g_apce_d[l_ac].apce109 = g_apce_d[l_ac].apce109 - l_sumapce.apce109
   LET g_apce_d[l_ac].apce119 = g_apce_d[l_ac].apce119 - l_sumapce.apce119
   LET g_apce_d[l_ac].apce129 = g_apce_d[l_ac].apce129 - l_sumapce.apce129
   LET g_apce_d[l_ac].apce139 = g_apce_d[l_ac].apce139 - l_sumapce.apce139  
   IF cl_null(g_apce_d[l_ac].apce109)THEN LET g_apce_d[l_ac].apce109 = 0 END IF
   IF cl_null(g_apce_d[l_ac].apce119)THEN LET g_apce_d[l_ac].apce119 = 0 END IF
   IF cl_null(g_apce_d[l_ac].apce129)THEN LET g_apce_d[l_ac].apce129 = 0 END IF
   IF cl_null(g_apce_d[l_ac].apce139)THEN LET g_apce_d[l_ac].apce139 = 0 END IF
   #帳款性質為2*(待抵單),由於確認時會回寫已沖金額,因此需扣除已被沖銷/預沖金額(此處會扣除包含aapt430單身已維護的金額)
   IF l_apca.apca001 MATCHES '2*' THEN
      #如果沖銷參數是3,則多帳期的項次與單身apcb項次是可以對應的,因此判斷可沖金額的時候,必須考量到項次
      #如果沖銷參數是1/2,則項次是對應不上的,因此以整張單的角度看可沖金額
      IF g_s_fin_2002 = '3' THEN
         LET l_type = '3'
      ELSE
         LET l_type = '2'
      END IF
      CALL s_aapt420_apcc_used_num('41',p_ld,p_ld,p_docno,p_seq,'',g_apda_m.apdadocno,g_apce_d[l_ac].apceseq,l_type)   
       RETURNING g_sub_success,g_errno,l_apcc108,l_apcc118,l_apcc128,l_apcc138 
      #多帳期剩餘可沖金額與該項次可沖金額相比,取小者為超沖標準       
      IF l_apcc118 < g_apce_d[l_ac].apce119 THEN
         LET g_apce_d[l_ac].apce109 = l_apcc108
         LET g_apce_d[l_ac].apce119 = l_apcc118
         LET g_apce_d[l_ac].apce129 = l_apcc128
         LET g_apce_d[l_ac].apce139 = l_apcc138
      END IF
   END IF   
   #160816-00022#1--e
   #160816-00022#1 mark--s   
   ##apce119 = apcc118 - apcc119 - sum(apce119) =帳款金額-沖銷-已分攤
   #LET g_apce_d[l_ac].apce119 = l_apcc.apcc118 - l_apcc.apcc119 - l_sumapce.apce119
   # 
   ##本位幣二幣別
   #LET g_apce_d[l_ac].apce120 = l_apcc.apcc120
   ##本位幣二匯率
   #LET g_apce_d[l_ac].apce121 = l_apcc.apcc121
   ##apce129  = apcc128 - apcc129 - sum(apce129)已分攤
   #LET g_apce_d[l_ac].apce129 = l_apcc.apcc128 - l_apcc.apcc129 - l_sumapce.apce129
   #
   ##本位幣三幣別
   #LET g_apce_d[l_ac].apce130 = l_apcc.apcc120
   ##本位幣三匯率
   #LET g_apce_d[l_ac].apce131 = l_apcc.apcc121
   ##apce139 = apcc138 - apcc139 - sum(apce139)已分攤
   #LET g_apce_d[l_ac].apce139 = l_apcc.apcc138 - l_apcc.apcc139 - l_sumapce.apce139
   #160816-00022#1 mark--e
        

   #抓取來源單據的核算項
   CALL aapt430_source_account_carry(p_docno,p_seq,p_ld,'1') RETURNING l_apce.*
   
   #給值
   LET g_apce_d[l_ac].apce017      = l_apce.apce017
   LET g_apce_d[l_ac].apce017_desc = l_apce.apce017
   LET g_apce_d[l_ac].apce018      = l_apce.apce018
   LET g_apce_d[l_ac].apce018_desc = l_apce.apce018
   LET g_apce_d[l_ac].apce019      = l_apce.apce019
   LET g_apce_d[l_ac].apce019_desc = l_apce.apce019
   
   LET g_apce_d[l_ac].apce020      = l_apce.apce020
   LET g_apce_d[l_ac].apce020_desc = l_apce.apce020
   LET g_apce_d[l_ac].apce022      = l_apce.apce022
   LET g_apce_d[l_ac].apce022_desc = l_apce.apce022
   LET g_apce_d[l_ac].apce023      = l_apce.apce023
   LET g_apce_d[l_ac].apce023_desc = l_apce.apce023
   
   LET g_apce_d[l_ac].apce035      = l_apce.apce035
   LET g_apce_d[l_ac].apce035_desc = l_apce.apce035
   LET g_apce_d[l_ac].apce036      = l_apce.apce036
   LET g_apce_d[l_ac].apce036_desc = l_apce.apce036
   LET g_apce_d[l_ac].apce044      = l_apce.apce044
   LET g_apce_d[l_ac].apce044_desc = l_apce.apce044
   LET g_apce_d[l_ac].apce045      = l_apce.apce045
   LET g_apce_d[l_ac].apce045_desc = l_apce.apce045
   LET g_apce_d[l_ac].apce046      = l_apce.apce046
   LET g_apce_d[l_ac].apce046_desc = l_apce.apce046
   
   LET g_apce_d[l_ac].apce051      = l_apce.apce051
   LET g_apce_d[l_ac].apce051_desc = l_apce.apce051
   LET g_apce_d[l_ac].apce052      = l_apce.apce052
   LET g_apce_d[l_ac].apce052_desc = l_apce.apce052
   LET g_apce_d[l_ac].apce053      = l_apce.apce053
   LET g_apce_d[l_ac].apce053_desc = l_apce.apce053
   LET g_apce_d[l_ac].apce054      = l_apce.apce054
   LET g_apce_d[l_ac].apce054_desc = l_apce.apce054
   LET g_apce_d[l_ac].apce055      = l_apce.apce055
   LET g_apce_d[l_ac].apce055_desc = l_apce.apce055
   
   LET g_apce_d[l_ac].apce056      = l_apce.apce056
   LET g_apce_d[l_ac].apce056_desc = l_apce.apce056
   LET g_apce_d[l_ac].apce057      = l_apce.apce057
   LET g_apce_d[l_ac].apce057_desc = l_apce.apce057
   LET g_apce_d[l_ac].apce058      = l_apce.apce058
   LET g_apce_d[l_ac].apce058_desc = l_apce.apce058
   LET g_apce_d[l_ac].apce059      = l_apce.apce059
   LET g_apce_d[l_ac].apce059_desc = l_apce.apce059
   LET g_apce_d[l_ac].apce060      = l_apce.apce060
   LET g_apce_d[l_ac].apce060_desc = l_apce.apce060
   #摘要說明
   LET g_apce_d[l_ac].apce010      = l_apce.apce010
   #帳款對象
   LET g_apce_d[l_ac].apce038      = l_apca.apca004

END FUNCTION

################################################################################
# Descriptions...: 目的頁籤之單據開窗-帶值
# Memo...........:
# Date & Author..: 14/08/15 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_source_doc_carry2(p_ld,p_docno,p_seq)
DEFINE p_ld          LIKE apda_t.apdald
DEFINE p_docno       LIKE apca_t.apcadocno
DEFINE p_seq         LIKE apcb_t.apcbseq
#DEFINE l_apcb        RECORD LIKE apcb_t.* #161104-00024#4 mark
#161104-00024#4-add(s)
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
#161104-00024#4-add(e)
DEFINE l_pmdt        RECORD
             pmdtsite   LIKE pmdt_t.pmdtsite,
             pmdt006   LIKE pmdt_t.pmdt006
                     END RECORD
DEFINE l_str         STRING
DEFINE l_apce        RECORD
             apce017    LIKE apce_t.apce017,
             apce018    LIKE apce_t.apce018,
             apce019    LIKE apce_t.apce019, #責任中心
             
             apce020    LIKE apce_t.apce020, #產品類別
             apce022    LIKE apce_t.apce022, #專案代號
             apce023    LIKE apce_t.apce023, #WBS編號
             
             apce035    LIKE apce_t.apce035,
             apce036    LIKE apce_t.apce036,
             apce044    LIKE apce_t.apce044,
             apce045    LIKE apce_t.apce045,
             apce046    LIKE apce_t.apce046,
             
             apce051    LIKE apce_t.apce051,
             apce052    LIKE apce_t.apce052,
             apce053    LIKE apce_t.apce053,
             apce054    LIKE apce_t.apce054,
             apce055    LIKE apce_t.apce055,
             
             apce056    LIKE apce_t.apce056,
             apce057    LIKE apce_t.apce057,
             apce058    LIKE apce_t.apce058,
             apce059    LIKE apce_t.apce059,
             apce060    LIKE apce_t.apce060,
             apce010    LIKE apce_t.apce010
                     END RECORD

   INITIALIZE l_apcb.* TO NULL
   INITIALIZE l_pmdt.* TO NULL
   
   #SELECT * INTO l_apcb.* FROM apcb_t   #161208-00026#9 mark
   #161208-00026#9-add(s)
   SELECT apcbent,apcbld,apcblegl,apcborga,apcbsite,
          apcbdocno,apcbseq,apcb001,apcb002,apcb003,
          apcb004,apcb005,apcb006,apcb007,apcb008,
          apcb009,apcb010,apcb011,apcb012,apcb013,
          apcb014,apcb015,apcb016,apcb017,apcb018,
          apcb019,apcb020,apcb021,apcb022,apcb023,
          apcb024,apcb025,apcb026,apcb027,apcb028,
          apcb029,apcb030,apcb032,apcb033,apcb034,
          apcb035,apcb036,apcb037,apcb038,apcb039,
          apcb040,apcb041,apcb042,apcb043,apcb044,
          apcb045,apcb046,apcb047,apcb048,apcb049,
          apcb050,apcb051,apcb100,apcb101,apcb102,
          apcb103,apcb104,apcb105,apcb106,apcb107,
          apcb108,apcb111,apcb113,apcb114,apcb115,
          apcb116,apcb117,apcb118,apcb119,apcb121,
          apcb123,apcb124,apcb125,apcb126,apcb127,
          apcb128,apcb131,apcb133,apcb134,apcb135,
          apcb136,apcb137,apcb138,apcbud001,apcbud002,
          apcbud003,apcbud004,apcbud005,apcbud006,apcbud007,
          apcbud008,apcbud009,apcbud010,apcbud011,apcbud012,
          apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,
          apcbud018,apcbud019,apcbud020,apcbud021,apcbud022,
          apcbud023,apcbud024,apcbud025,apcbud026,apcbud027,
          apcbud028,apcbud029,apcbud030,apcb052,apcb053,
          apcb054,apcb055 
     INTO l_apcb.* 
     FROM apcb_t
   #161208-00026#9-add(e)
    WHERE apcbent = g_enterprise
      AND apcbld  = p_ld
      AND apcb002 = p_docno
      AND apcb003 = p_seq
   
   SELECT pmdtsite,pmdt006 
     INTO l_pmdt.pmdtsite,l_pmdt.pmdt006
     FROM pmdt_t
    WHERE pmdtent   = g_enterprise
      AND pmdtdocno = p_docno
      AND pmdtseq   = p_seq
 
   LET g_apce2_d[l_ac].apdcorga = l_pmdt.pmdtsite
   #產品編號
   LET g_apce2_d[l_ac].apdc004 = l_pmdt.pmdt006
   #抓取產品名稱
   CALL s_desc_get_item_desc(g_apce2_d[l_ac].apdc004)
        RETURNING g_apce2_d[l_ac].imaal003,l_str
   IF cl_null(g_apce2_d[l_ac].imaal003) AND NOT cl_null(l_str) THEN
      LET g_apce2_d[l_ac].imaal003 = l_str
   END IF
   IF NOT cl_null(g_apce2_d[l_ac].imaal003) AND NOT cl_null(l_str) THEN
      LET g_apce2_d[l_ac].imaal003 = g_apce2_d[l_ac].imaal003,"/",l_str
   END IF
   #目的帳款單號
   LET g_apce2_d[l_ac].apdc005 = l_apcb.apcbdocno
   #目的項次
   LET g_apce2_d[l_ac].apdc006 = l_apcb.apcbseq
   #目的會計科目
   LET g_apce2_d[l_ac].apdc007      = l_apcb.apcb021
   LET g_apce2_d[l_ac].apdc007_desc = l_apcb.apcb021
   #數量
   LET g_apce2_d[l_ac].apdc008 = l_apcb.apcb007
   #帳款單性質
   LET g_apce2_d[l_ac].apdc015 = 'D'
   
   #本幣分攤前單價
   LET g_apce2_d[l_ac].apdc111 = l_apcb.apcb111
   #本幣分攤前金額
   LET g_apce2_d[l_ac].apdc113 = l_apcb.apcb113
   #本幣分攤後單價
   LET g_apce2_d[l_ac].apdc211 = 0
   #本幣分攤後金額
   LET g_apce2_d[l_ac].apdc213 = 0
   
   #本位幣二分攤前金額
   LET g_apce2_d[l_ac].apdc123 = l_apcb.apcb123
   #本位幣二分攤後金額
   LET g_apce2_d[l_ac].apdc223 = 0
   #本位幣三分攤前金額
   LET g_apce2_d[l_ac].apdc133 = l_apcb.apcb133
   #本位幣三分攤後金額
   LET g_apce2_d[l_ac].apdc233 = 0
   
   
   #抓取來源單據的核算項
   CALL aapt430_source_account_carry(l_apcb.apcbdocno,l_apcb.apcbseq,p_ld,'2') RETURNING l_apce.*
   
   #核算項給值
   LET g_apce2_d[l_ac].apdc017      = l_apce.apce017
   LET g_apce2_d[l_ac].apdc017_desc = l_apce.apce017
   LET g_apce2_d[l_ac].apdc018      = l_apce.apce018
   LET g_apce2_d[l_ac].apdc018_desc = l_apce.apce018
   LET g_apce2_d[l_ac].apdc019      = l_apce.apce019
   LET g_apce2_d[l_ac].apdc019_desc = l_apce.apce019
   
   LET g_apce2_d[l_ac].apdc020      = l_apce.apce020
   LET g_apce2_d[l_ac].apdc020_desc = l_apce.apce020
   LET g_apce2_d[l_ac].apdc022      = l_apce.apce022
   LET g_apce2_d[l_ac].apdc022_desc = l_apce.apce022
   LET g_apce2_d[l_ac].apdc023      = l_apce.apce023
   LET g_apce2_d[l_ac].apdc023_desc = l_apce.apce023
   
   LET g_apce2_d[l_ac].apdc024      = l_apce.apce035
   LET g_apce2_d[l_ac].apdc024_desc = l_apce.apce035
   LET g_apce2_d[l_ac].apdc025      = l_apce.apce036
   LET g_apce2_d[l_ac].apdc025_desc = l_apce.apce036
   LET g_apce2_d[l_ac].apdc027      = l_apce.apce044
   LET g_apce2_d[l_ac].apdc027_desc = l_apce.apce044
   LET g_apce2_d[l_ac].apdc028      = l_apce.apce045
   LET g_apce2_d[l_ac].apdc028_desc = l_apce.apce045
   LET g_apce2_d[l_ac].apdc029      = l_apce.apce046
   LET g_apce2_d[l_ac].apdc029_desc = l_apce.apce046
   
   LET g_apce2_d[l_ac].apdc031      = l_apce.apce051
   LET g_apce2_d[l_ac].apdc031_desc = l_apce.apce051
   LET g_apce2_d[l_ac].apdc032      = l_apce.apce052
   LET g_apce2_d[l_ac].apdc032_desc = l_apce.apce052
   LET g_apce2_d[l_ac].apdc033      = l_apce.apce053
   LET g_apce2_d[l_ac].apdc033_desc = l_apce.apce053
   LET g_apce2_d[l_ac].apdc034      = l_apce.apce054
   LET g_apce2_d[l_ac].apdc034_desc = l_apce.apce054
   LET g_apce2_d[l_ac].apdc035      = l_apce.apce055
   LET g_apce2_d[l_ac].apdc035_desc = l_apce.apce055
   
   LET g_apce2_d[l_ac].apdc036      = l_apce.apce056
   LET g_apce2_d[l_ac].apdc036_desc = l_apce.apce056
   LET g_apce2_d[l_ac].apdc037      = l_apce.apce057
   LET g_apce2_d[l_ac].apdc037_desc = l_apce.apce057
   LET g_apce2_d[l_ac].apdc038      = l_apce.apce058
   LET g_apce2_d[l_ac].apdc038_desc = l_apce.apce058
   LET g_apce2_d[l_ac].apdc039      = l_apce.apce059
   LET g_apce2_d[l_ac].apdc039_desc = l_apce.apce059
   LET g_apce2_d[l_ac].apdc040      = l_apce.apce060
   LET g_apce2_d[l_ac].apdc040_desc = l_apce.apce060
   #摘要說明
   LET g_apce2_d[l_ac].apdc041      = l_apce.apce010

END FUNCTION

################################################################################
# Descriptions...: 取回apcf資料
# Memo...........:
# Date & Author..: 15/12/10 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_source_doc_carry_05(p_ld,p_docno,p_seq,p_apcc001)
DEFINE p_ld      LIKE apda_t.apdald
DEFINE p_docno   LIKE apca_t.apcadocno
DEFINE p_seq     LIKE apcb_t.apcbseq
DEFINE p_apcc001 LIKE apcc_t.apcc001
DEFINE r_array    DYNAMIC ARRAY OF RECORD
                  chr     LIKE type_t.chr1000,
                  dat     LIKE type_t.dat
                  END RECORD   
DEFINE l_apca     RECORD
                  apca001  LIKE apca_t.apca001,
                  apca004  LIKE apca_t.apca004,
                  apca100  LIKE apca_t.apca100,
                  apca101  LIKE apca_t.apca101,
                  apca120  LIKE apca_t.apca120,
                  apca121  LIKE apca_t.apca121,
                  apca130  LIKE apca_t.apca130,
                  apca131  LIKE apca_t.apca131
                  END RECORD
DEFINE l_apcf     RECORD
                  apcforga LIKE apcf_t.apcforga,
                  apcf021  LIKE apcf_t.apcf021,
                  apcf026  LIKE apcf_t.apcf026,
                  apcf027  LIKE apcf_t.apcf027,
                  apcf028  LIKE apcf_t.apcf028,
                  apcf031  LIKE apcf_t.apcf031,
                  apcf032  LIKE apcf_t.apcf032,
                  apcf033  LIKE apcf_t.apcf033,
                  apcf034  LIKE apcf_t.apcf034,
                  apcf035  LIKE apcf_t.apcf035,
                  apcf036  LIKE apcf_t.apcf036,
                  apcf037  LIKE apcf_t.apcf037,
                  apcf038  LIKE apcf_t.apcf038,
                  apcf039  LIKE apcf_t.apcf039,
                  apcf040  LIKE apcf_t.apcf040,
                  apcf041  LIKE apcf_t.apcf041,
                  apcf042  LIKE apcf_t.apcf042,
                  apcf043  LIKE apcf_t.apcf043,
                  apcf044  LIKE apcf_t.apcf044,
                  apcf045  LIKE apcf_t.apcf045,
                  apcf046  LIKE apcf_t.apcf046,
                  apcf047  LIKE apcf_t.apcf047,
                  apcf048  LIKE apcf_t.apcf048,
                  apcf049  LIKE apcf_t.apcf049,
                  apcf103  LIKE apcf_t.apcf103,
                  apcf113  LIKE apcf_t.apcf113,
                  apcf123  LIKE apcf_t.apcf123,
                  apcf133  LIKE apcf_t.apcf133
                  END RECORD
DEFINE l_sumapce  RECORD
                  apce109    LIKE apce_t.apce109,   #161222-00052#1 add
                  apce119    LIKE apce_t.apce119,
                  apce129    LIKE apce_t.apce129,
                  apce139    LIKE apce_t.apce139
              END RECORD
DEFINE l_sql      STRING


   CALL r_array.clear()
   INITIALIZE l_apca.* TO NULL
   INITIALIZE l_apcf.* TO NULL
   
   SELECT apca001,apca004,
          apca100,apca101,apca120,apca121,
          apca130,apca131
     INTO l_apca.apca001,l_apca.apca004,l_apca.apca100,l_apca.apca101,l_apca.apca120,l_apca.apca121,
          l_apca.apca130,l_apca.apca131 
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcald  = p_ld AND apcadocno = p_docno
   #抓取來源單據的核算項
   SELECT apcforga,apcf021,apcf026,
          apcf027,apcf028,apcf031,apcf032,apcf033,
          apcf034,apcf035,apcf036,apcf037,apcf038,
          apcf039,apcf040,apcf041,apcf042,apcf043,
          apcf044,apcf045,apcf046,apcf047,apcf048,
          apcf049,apcf103,apcf113,apcf123,apcf133
     INTO l_apcf.apcforga,l_apcf.apcf021,l_apcf.apcf026,
          l_apcf.apcf027,l_apcf.apcf028,l_apcf.apcf031,l_apcf.apcf032,l_apcf.apcf033,
          l_apcf.apcf034,l_apcf.apcf035,l_apcf.apcf036,l_apcf.apcf037,l_apcf.apcf038,
          l_apcf.apcf039,l_apcf.apcf040,l_apcf.apcf041,l_apcf.apcf042,l_apcf.apcf043,
          l_apcf.apcf044,l_apcf.apcf045,l_apcf.apcf046,l_apcf.apcf047,l_apcf.apcf048,
          l_apcf.apcf049,l_apcf.apcf103,l_apcf.apcf113,l_apcf.apcf123,l_apcf.apcf133
     FROM apcf_t
    WHERE apcfent = g_enterprise
      AND apcfld  = p_ld  AND apcfdocno = p_docno
      AND apcfseq = p_seq AND apcf008 = 'DIFF'
   
   IF l_apcf.apcf103 <> l_apcf.apcf113 THEN
      LET g_apce_d[l_ac].apce100 = l_apca.apca100
      LET g_apce_d[l_ac].apce101 = l_apca.apca101  #匯率   
   ELSE
      LET g_apce_d[l_ac].apce100 = l_apca.apca100
      LET g_apce_d[l_ac].apce101 = l_apca.apca101  #匯率   
   END IF
   IF l_apca.apca001[1,1] = '2' THEN
      LET l_apcf.apcf103 = l_apcf.apcf103 * -1
      LET l_apcf.apcf113 = l_apcf.apcf113 * -1
      LET l_apcf.apcf123 = l_apcf.apcf123 * -1
      LET l_apcf.apcf133 = l_apcf.apcf133 * -1
   END IF
   LET g_apce_d[l_ac].apce104 = 0               #原幣應稅折抵稅額   
   LET g_apce_d[l_ac].apce114 = 0               #本幣應稅折抵稅額   
   LET g_apce_d[l_ac].apce120 = l_apca.apca120  #本位幣二幣別
   LET g_apce_d[l_ac].apce121 = l_apca.apca121  #本位幣二匯率   
   LET g_apce_d[l_ac].apce124 = 0               #本位幣二應稅折抵稅額
   LET g_apce_d[l_ac].apce130 = l_apca.apca130  #本位幣三幣別   
   LET g_apce_d[l_ac].apce131 = l_apca.apca131  #本位幣三匯率
   LET g_apce_d[l_ac].apce134 = 0               #本位幣三應稅折抵稅額
   
   #取得aapt430目前已分攤的金額
   #SELECT SUM(apce119),SUM(apce129),SUM(apce139)                                   #161222-00052#1 mark
   #  INTO l_sumapce.apce119,l_sumapce.apce129,l_sumapce.apce139                    #161222-00052#1 mark
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)                       #161222-00052#1 add
     INTO l_sumapce.apce109,l_sumapce.apce119,l_sumapce.apce129,l_sumapce.apce139   #161222-00052#1 add
     FROM apda_t,apce_t 
    WHERE apceent = apdaent AND apceld = apdald AND apcedocno = apdadocno
      AND apdaent = g_enterprise 
      AND apda001 = '43'    AND apdastus <> 'X'
      AND apdald  = p_ld    AND apce003 = p_docno 
      AND apce004 = p_seq   AND apce005 = p_apcc001
      
   IF cl_null(l_sumapce.apce109)THEN LET l_sumapce.apce109 = 0 END IF   #161222-00052#1 add
   IF cl_null(l_sumapce.apce119)THEN LET l_sumapce.apce119 = 0 END IF
   IF cl_null(l_sumapce.apce129)THEN LET l_sumapce.apce129 = 0 END IF
   IF cl_null(l_sumapce.apce139)THEN LET l_sumapce.apce139 = 0 END IF

   #原幣apce109 = apcc108-apcc109
   #LET g_apce_d[l_ac].apce109 = l_apcf.apcf103                      #161222-00052#1 mark
   LET g_apce_d[l_ac].apce109 = l_apcf.apcf103 - l_sumapce.apce109   #161222-00052#1 add
   LET g_apce_d[l_ac].apce119 = l_apcf.apcf113 - l_sumapce.apce119
   LET g_apce_d[l_ac].apce129 = l_apcf.apcf123 - l_sumapce.apce129
   LET g_apce_d[l_ac].apce139 = l_apcf.apcf133 - l_sumapce.apce139
      
   LET g_apce_d[l_ac].apcelegl     = l_apcf.apcforga
   LET g_apce_d[l_ac].apceorga     = l_apcf.apcforga
   ##160506-00002#3 ---s---
   IF  g_apce_d[l_ac].apce119 < 0 THEN 
      LET g_apce_d[l_ac].apce015 = 'D'
   ELSE
      LET g_apce_d[l_ac].apce015 = 'C'
   END IF
   #LET g_apce_d[l_ac].apce015      = 'D'
   ##160506-00002#3 ---e---   
   LET g_apce_d[l_ac].apce016      = l_apcf.apcf021
   LET g_apce_d[l_ac].apce016_desc = l_apcf.apcf021
   
   LET g_apce_d[l_ac].apce017      = l_apcf.apcf033
   LET g_apce_d[l_ac].apce017_desc = l_apcf.apcf033
   LET g_apce_d[l_ac].apce018      = l_apcf.apcf026
   LET g_apce_d[l_ac].apce018_desc = l_apcf.apcf026
   LET g_apce_d[l_ac].apce019      = l_apcf.apcf027
   LET g_apce_d[l_ac].apce019_desc = l_apcf.apcf027
   
   LET g_apce_d[l_ac].apce020      = l_apcf.apcf032
   LET g_apce_d[l_ac].apce020_desc = l_apcf.apcf032
   LET g_apce_d[l_ac].apce022      = l_apcf.apcf034
   LET g_apce_d[l_ac].apce022_desc = l_apcf.apcf034
   LET g_apce_d[l_ac].apce023      = l_apcf.apcf035
   LET g_apce_d[l_ac].apce023_desc = l_apcf.apcf035
   LET g_apce_d[l_ac].apce028 = 0                     #產生方式
   LET g_apce_d[l_ac].apce035      = l_apcf.apcf028
   LET g_apce_d[l_ac].apce035_desc = l_apcf.apcf028
   LET g_apce_d[l_ac].apce036      = l_apcf.apcf031
   LET g_apce_d[l_ac].apce036_desc = l_apcf.apcf031
   LET g_apce_d[l_ac].apce044      = l_apcf.apcf036
   LET g_apce_d[l_ac].apce044_desc = l_apcf.apcf036
   LET g_apce_d[l_ac].apce045      = l_apcf.apcf037
   LET g_apce_d[l_ac].apce045_desc = l_apcf.apcf037
   LET g_apce_d[l_ac].apce046      = l_apcf.apcf038
   LET g_apce_d[l_ac].apce046_desc = l_apcf.apcf038
   LET g_apce_d[l_ac].apce048      = ' '              #發票號碼
   
   LET g_apce_d[l_ac].apce051      = l_apcf.apcf039   #自由核算項一
   LET g_apce_d[l_ac].apce051_desc = l_apcf.apcf039
   LET g_apce_d[l_ac].apce052      = l_apcf.apcf040
   LET g_apce_d[l_ac].apce052_desc = l_apcf.apcf040
   LET g_apce_d[l_ac].apce053      = l_apcf.apcf041
   LET g_apce_d[l_ac].apce053_desc = l_apcf.apcf041
   LET g_apce_d[l_ac].apce054      = l_apcf.apcf042
   LET g_apce_d[l_ac].apce054_desc = l_apcf.apcf042
   LET g_apce_d[l_ac].apce055      = l_apcf.apcf043
   LET g_apce_d[l_ac].apce055_desc = l_apcf.apcf043
   
   LET g_apce_d[l_ac].apce056      = l_apcf.apcf044   #自由核算項六
   LET g_apce_d[l_ac].apce056_desc = l_apcf.apcf044
   LET g_apce_d[l_ac].apce057      = l_apcf.apcf045
   LET g_apce_d[l_ac].apce057_desc = l_apcf.apcf045
   LET g_apce_d[l_ac].apce058      = l_apcf.apcf046
   LET g_apce_d[l_ac].apce058_desc = l_apcf.apcf046
   LET g_apce_d[l_ac].apce059      = l_apcf.apcf047
   LET g_apce_d[l_ac].apce059_desc = l_apcf.apcf047
   LET g_apce_d[l_ac].apce060      = l_apcf.apcf048
   LET g_apce_d[l_ac].apce060_desc = l_apcf.apcf048
   #摘要說明
   LET g_apce_d[l_ac].apce010      = l_apcf.apcf049
   #帳款對象
   LET g_apce_d[l_ac].apce038      = l_apca.apca004
   CALL aapt430_apce_msg(l_ac)
   LET g_apce_d[l_ac].apca004      = l_apca.apca004
  
END FUNCTION

################################################################################
# Descriptions...: 抓取來源單據的核算項
# Memo...........:
# Usage..........: CALL aapt430_source_account_carry(p_docno,p_seq,p_ld,p_type)

# Date & Author..: 2014/12/27 By Reanna
################################################################################
PRIVATE FUNCTION aapt430_source_account_carry(p_docno,p_seq,p_ld,p_type)
DEFINE p_docno       LIKE apcc_t.apccdocno
DEFINE p_seq         LIKE apcc_t.apccseq
DEFINE p_ld          LIKE apca_t.apcald
DEFINE p_type        LIKE type_t.chr1
DEFINE r_apce        RECORD
                     apce017    LIKE apce_t.apce017,
                     apce018    LIKE apce_t.apce018,
                     apce019    LIKE apce_t.apce019, #責任中心=apcb011
                     
                     apce020    LIKE apce_t.apce020, #產品類別
                     apce022    LIKE apce_t.apce022, #專案代號
                     apce023    LIKE apce_t.apce023, #WBS編號
                     
                     apce035    LIKE apce_t.apce035, #區域
                     apce036    LIKE apce_t.apce036, #客戶分類
                     apce044    LIKE apce_t.apce044, #經營方式
                     apce045    LIKE apce_t.apce045, #渠道
                     apce046    LIKE apce_t.apce046, #品牌
                     
                     apce051    LIKE apce_t.apce051,
                     apce052    LIKE apce_t.apce052,
                     apce053    LIKE apce_t.apce053,
                     apce054    LIKE apce_t.apce054,
                     apce055    LIKE apce_t.apce055,
                     
                     apce056    LIKE apce_t.apce056,
                     apce057    LIKE apce_t.apce057,
                     apce058    LIKE apce_t.apce058,
                     apce059    LIKE apce_t.apce059,
                     apce060    LIKE apce_t.apce060,
                     apce010    LIKE apce_t.apce010  #摘要
                     END RECORD
DEFINE l_sfin2002    LIKE type_t.chr1
DEFINE l_sql         STRING

   #取得沖銷參數
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-2002') RETURNING l_sfin2002
   IF p_type = '2' THEN
      LET l_sfin2002 = '3'
   END IF
   
   #1/2:取單頭核算項 3:取單身
   IF l_sfin2002 = '1' OR l_sfin2002 = '2' THEN
      LET l_sql = l_sql,
               " SELECT apca014,apca015,apca034,'',apca033, ",
               "        '','','','','', ",
               "        '','','','','', ",
               "        '','','','','', ",
               "        '',''"
   ELSE
      LET l_sql = l_sql,
               " SELECT apcb051,apcb010,apcb011,apcb012,apcb015, ",
               "        apcb016,apcb024,apcb036,apcb033,apcb034, ",
               "        apcb035,apcb037,apcb038,apcb039,apcb040, ",
               "        apcb041,apcb042,apcb043,apcb044,apcb045, ",
               "        apcb046,apcb047"
   END IF
   LET l_sql = l_sql,
               "   FROM apca_t,apcb_t",
               "  WHERE apcaent = apcbent ", 
               "    AND apcald = apcbld ",
               "    AND apcadocno = apcbdocno ",
               "    AND apcaent = '",g_enterprise,"' ",
               "    AND apcadocno = '",p_docno,"' ",
               "    AND apcbseq = '",p_seq,"' ",
               "    AND apcald = '",p_ld,"' "
   PREPARE s_aapt430_source_account_carry_p FROM l_sql
   DECLARE s_aapt430_source_account_carry_c CURSOR FOR s_aapt430_source_account_carry_p
   OPEN s_aapt430_source_account_carry_c
   FETCH s_aapt430_source_account_carry_c INTO r_apce.*

   RETURN r_apce.*

END FUNCTION

################################################################################
# Descriptions...: 分攤日期檢核
# Memo...........: 寫成function是因為
#                : 除了日期本身檢查以外,帳套
#                : 變更時,日期也要跟著檢核並決定是否清空
# Date & Author..: 14/08/07 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_apdadocdt_chk(p_comp,p_dat)
   DEFINE p_comp            LIKE glaa_t.glaald
   DEFINE p_dat             LIKE type_t.dat
   DEFINE r_success         LIKE type_t.num5
   DEFINE r_errno           LIKE gzze_t.gzze001
   DEFINE l_date_s_fin_3007 LIKE type_t.dat
   DEFINE l_date_s_fin_6012 LIKE type_t.dat
   
   LET r_success = TRUE
   LET r_errno = ''
   
   #日期檢查
   #檢查應付關帳日
   LET l_date_s_fin_3007 = NULL
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-3007') RETURNING l_date_s_fin_3007
   
   #檢察成本關帳日
   LET l_date_s_fin_6012 = NULL
   CALL cl_get_para(g_enterprise,g_apda_m.apdacomp,'S-FIN-6012') RETURNING l_date_s_fin_6012

   CASE
      WHEN NOT cl_null(l_date_s_fin_3007)
         AND g_apda_m.apdadocdt <= l_date_s_fin_3007
         LET r_success = FALSE
         LET r_errno = 'aap-00110'
      WHEN NOT cl_null(l_date_s_fin_6012)
         AND g_apda_m.apdadocdt <= l_date_s_fin_6012
         LET r_success = FALSE
         LET r_errno = 'aap-00111'
   END CASE
   
   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 來源單據檢核
# Memo...........:
# Date & Author..: 14/08/11 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_source_doc_chk(p_ac,p_ld,p_docno,p_seq,p_apcc001)
DEFINE p_ld            LIKE glaa_t.glaald
DEFINE p_docno         LIKE apcc_t.apccdocno
DEFINE p_seq           LIKE apcc_t.apccseq
DEFINE p_apcc001       LIKE apcc_t.apcc001
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         LIKE gzze_t.gzze001
DEFINE l_count         LIKE type_t.num10
DEFINE l_count2        LIKE type_t.num10   #160816-00022#1
DEFINE l_apca          RECORD 
                       apcastus    LIKE apca_t.apcastus,
                       apca001     LIKE apca_t.apca001
                       END RECORD
DEFINE l_sql           STRING
DEFINE l_slip_type_str STRING
DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
DEFINE p_ac            LIKE type_t.num10

   LET r_success = TRUE
   LET r_errno  = ''
   
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN r_success,r_errno END IF   
  #IF cl_null(p_ld) OR cl_null(p_docno) OR cl_null(p_apcc001) THEN   #160816-00022#1 mark
   IF cl_null(p_ld) OR cl_null(p_docno) THEN                         #160816-00022#1 
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
   IF g_apce_d[p_ac].apca001 <> '05' THEN #151207-00018#3
      LET l_sql = " SELECT apcastus,apca001",
                  #160816-00022#1--s
                  "   FROM apca_t,apcb_t",
                  "  WHERE apcaent = apcbent",
                  "    AND apcald = apcbld ",
                  "    AND apcadocno = apcbdocno",
                  "    AND apcaent = ",g_enterprise,
                  "    AND apcald = '",p_ld,"'",
                  "    AND apcadocno = '",p_docno,"'",
                  "    AND apcbseq = ",p_seq                 
                  #160816-00022#1--e
                  #160816-00022#1 mark--s
                  #"   FROM apca_t,apcc_t",
                  #"  WHERE apcaent = apccent",
                  #"    AND apcald = apccld ",
                  #"    AND apcadocno = apccdocno",
                  #"    AND apcaent = ",g_enterprise,
                  #"    AND apcald = '",p_ld,"'",
                  #"    AND apcadocno = '",p_docno,"'",
                  #"    AND apccseq = ",p_seq,       
                  #"    AND apcc001 = ",p_apcc001    
                  #160816-00022#1 mark--e
   #151207-00018#3--(S)
   ELSE
      LET l_sql = " SELECT apcastus,apca001",
                  "   FROM apca_t,apcf_t",
                  "  WHERE apcaent = apcfent AND apcald = apcfld ",
                  "    AND apcadocno = apcfdocno",
                  "    AND apcaent = ",g_enterprise,
                  "    AND apcald = '",p_ld,"' AND apcadocno = '",p_docno,"'",
                  "    AND apcfseq = ",p_seq
   END IF
   #151207-00018#3--(E)
   INITIALIZE l_apca.* TO NULL
   PREPARE sel_aapt430_apce003p1 FROM l_sql
   #EXECUTE sel_aapt430_apce003p1 INTO l_apca.*   #161208-00026#9 mark
   #161208-00026#9-add(s)
   EXECUTE sel_aapt430_apce003p1 INTO l_apca.apcastus,l_apca.apca001
   #161208-00026#9-add(e)
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno  = 'aap-00051'
      WHEN g_apce_d[p_ac].apca001 <> '05' AND (cl_null(g_scc8502) OR s_chr_get_index_of(g_scc8502,l_apca.apca001,1) = 0)   #151207-00018#3 暫估差異不考慮帳款單性質
         #與SCC設定可用的帳款單性質不合
         LET r_errno = 'aap-00285'
      WHEN l_apca.apcastus <> 'Y'
         #狀態不為確認
         LET r_errno = 'aap-00014'
      #160816-00022#1--s
      WHEN g_apce_d[p_ac].apca001 <> '05' AND l_apca.apca001 <> g_apce_d[p_ac].apca001
         LET r_errno = 'aap-00583'
      #160816-00022#1--e
   END CASE
   #160816-00022#1--s
   #待抵單
   IF g_apce_d[p_ac].apca001 MATCHES '2*' THEN
      LET l_count = 0
      SELECT COUNT(apce001) INTO l_count
        FROM apce_t
       WHERE apceent = g_enterprise
         AND apceld = p_ld
         AND apce003 = p_docno
         AND apce001 <> 'aapt430'   #存在核銷就不能分攤
         AND (EXISTS (SELECT 1 FROM apda_t WHERE apceent = apdaent AND apceld = apdald    #應付核銷
                                             AND apcedocno = apdadocno AND apdastus NOT IN('X')) OR  
              EXISTS (SELECT 1 FROM apca_t WHERE apceent = apcaent AND apceld = apcald    #應付直接沖帳
                                             AND apcedocno = apcadocno AND apcastus NOT IN('X'))                                            
             )                                             
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      LET l_count2 = 0
      SELECT COUNT(xrce001) INTO l_count2
        FROM xrce_t
       WHERE xrceent = g_enterprise
         AND xrceld = p_ld
         AND xrce003 = p_docno
         AND xrce001 <> 'aapt430'   #存在核銷就不能分攤
         AND (EXISTS (SELECT 1 FROM xrda_t WHERE xrceent = xrdaent AND xrceld = xrdald    #應收核銷
                                             AND xrcedocno = xrdadocno AND xrdastus NOT IN('X'))                                           
             )                                             
      IF cl_null(l_count2) THEN LET l_count2 = 0 END IF      
      IF l_count + l_count2 > 0 THEN
         LET r_success = FALSE
         LET r_errno = 'aap-00585'
         RETURN r_success,r_errno           
      END IF            
   END IF
   #160816-00022#1--e   

   IF NOT cl_null(r_errno)THEN
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 目的頁籤之交易單據check
# Memo...........:
# Usage..........: CALL aapt430_apdc002_chk(p_ac,p_orga,p_docno,p_seq)

# Date & Author..: 14/08/13 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_apdc002_chk(p_ac,p_orga,p_docno,p_seq)
DEFINE p_ac      LIKE type_t.num5
DEFINE p_orga    LIKE pmdt_t.pmdtsite
DEFINE p_docno   LIKE pmdt_t.pmdtdocno
DEFINE p_seq     LIKE pmdt_t.pmdtseq
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_pmds    RECORD 
                 pmdsstus   LIKE pmds_t.pmdsstus,
                 pmds000    LIKE pmds_t.pmds000,
                 pmdtsite   LIKE pmdt_t.pmdtsite
                 END RECORD
DEFINE l_count   LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_errno   = ''
   IF cl_null(p_ac) OR p_ac <= 0 OR cl_null(p_orga) OR cl_null(p_docno) OR cl_null(p_seq) THEN
      RETURN r_success,r_errno
   END IF
   #有效入庫單 pmdsstus='S'
	#非收貨單   pmds000<> '1','2','5','７'	#不顯示收貨單、倉退單、驗退單

	INITIALIZE l_pmds.* TO NULL
	SELECT pmdsstus,pmds000,pmdtsite INTO l_pmds.*
	  FROM pmds_t,pmdt_t
	 WHERE pmdsent = pmdtent AND pmdsdocno = pmdtdocno
	   AND pmdsent = g_enterprise
	   AND pmdsdocno = p_docno
	   AND pmdtseq = p_seq
	
	CASE
	   WHEN SQLCA.SQLCODE = 100
	      LET r_errno = 'asf-00154'
	      LET r_success = FALSE
	   WHEN l_pmds.pmdsstus <> 'S'
	      LET r_errno = 'ain-00227'
	      LET r_success = FALSE
	  #WHEN l_pmds.pmds000 MATCHES '[125789]' OR l_pmds.pmds000 MATCHES '1[0145]' OR l_pmds.pmds000 = '26'  #150629-00038#1 add #150702-00001#1 mark
	   WHEN s_aap_pmds000_chk("  (gzcb003 IS NULL OR gzcb004 <> 1) ",l_pmds.pmds000)   #150702-00001#1 add   #排除不符合性質為入庫且立帳者
	     LET r_errno = 'aap-00173'
	     LET r_success = FALSE
	   WHEN l_pmds.pmdtsite <> p_orga
	      LET r_errno = 'aap-00274'
	      LET r_success = FALSE
	END CASE
	#IF r_success AND NOT cl_null(p_docno) THEN
	   #入庫單號+項次，已存在於本筆分攤單據者，不可重覆輸入
	   LET l_count = NULL
	   SELECT COUNT(*) INTO l_count FROM apdc_t
	    WHERE apdcent = g_enterprise
	      AND apdcld  = g_apda_m.apdald
	      AND apdcdocno = g_apda_m.apdadocno
	      AND apdc002   = p_docno
	      AND apdc003   = p_seq
	   IF cl_null(l_count)THEN LET l_count = 0 END IF
	   IF l_count > 0 THEN
	      LET r_success = FALSE
	      LET r_errno   = 'aap-00174'
	   END IF
	#END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 更新單頭"應攤本幣(二&三)金額"
# Memo...........:
# Usage..........: CALL aapt430_upd_apda113()
# Date & Author..: 14/12/02 By Reanna
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_upd_apda113()
DEFINE r_success        LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_scc8502D       STRING
DEFINE l_scc8502C       STRING
DEFINE l_apce119_sumD   LIKE apce_t.apce119
DEFINE l_apce119_sumC   LIKE apce_t.apce119
DEFINE l_apce129_sumD   LIKE apce_t.apce129
DEFINE l_apce129_sumC   LIKE apce_t.apce129
DEFINE l_apce139_sumD   LIKE apce_t.apce139
DEFINE l_apce139_sumC   LIKE apce_t.apce139
DEFINE l_apce119_sumDIFF   LIKE apce_t.apce119
DEFINE l_apce129_sumDIFF   LIKE apce_t.apce119
DEFINE l_apce139_sumDIFF   LIKE apce_t.apce129
   
   LET r_success  =  TRUE
   
   LET g_apda_m.apda113 = ''
   
   #算出帳款單性質D類的總金額
   CALL s_aap_get_acc_str("8502"," gzcb006 = 'Y' AND gzcb004 = 'D' ") RETURNING l_scc8502D
   LET l_sql = "SELECT SUM(apce119),SUM(apce129),SUM(apce139)",
               "  FROM apca_t",
               "  LEFT JOIN apce_t ON apcaent = apceent AND apcald = apceld AND apcadocno = apce003",
               " WHERE apcaent = ",g_enterprise,
               "   AND apceld = '",g_apda_m.apdald,"'",
               "   AND apcedocno = '",g_apda_m.apdadocno,"'",
              # "   AND (apcadocno,apce004,apce005) IN (SELECT apccdocno,apccseq,apcc001 FROM apcc_t WHERE apcaent = apccent AND apcadocno = apccdocno )",   #151207-00018#3
               "   AND apca001 IN (",l_scc8502D,")",
               "   AND apce002 <> '05' "     #151218-00004#1
   PREPARE sel_aapt430_sumapce119D FROM l_sql
   EXECUTE sel_aapt430_sumapce119D INTO l_apce119_sumD,l_apce129_sumD,l_apce139_sumD
   
   IF cl_null(l_apce119_sumD) THEN LET l_apce119_sumD = 0 END IF
   IF cl_null(l_apce129_sumD) THEN LET l_apce129_sumD = 0 END IF
   IF cl_null(l_apce139_sumD) THEN LET l_apce139_sumD = 0 END IF
   
   
   #算出帳款單性質C類的總金額
   CALL s_aap_get_acc_str("8502"," gzcb006 = 'Y' AND gzcb004 = 'C' ") RETURNING l_scc8502C
   LET l_sql = "SELECT SUM(apce119),SUM(apce129),SUM(apce139)",
               "  FROM apca_t",
               "  LEFT JOIN apce_t ON apcaent = apceent AND apcald = apceld AND apcadocno = apce003",
               " WHERE apcaent = ",g_enterprise,
               "   AND apceld = '",g_apda_m.apdald,"'",
               "   AND apcedocno = '",g_apda_m.apdadocno,"'",
              # "   AND (apcadocno,apce004,apce005) IN (SELECT apccdocno,apccseq,apcc001 FROM apcc_t WHERE apcaent = apccent AND apcadocno = apccdocno )",   #151207-00018#3
               "   AND apca001 IN (",l_scc8502C,")",
               "   AND apce002 <> '05' "     #151218-00004#1
   PREPARE sel_aapt430_sumapce119C FROM l_sql
   EXECUTE sel_aapt430_sumapce119C INTO l_apce119_sumC,l_apce129_sumC,l_apce139_sumC
   
   
   IF cl_null(l_apce119_sumC) THEN LET l_apce119_sumC = 0 END IF
   IF cl_null(l_apce129_sumC) THEN LET l_apce129_sumC = 0 END IF
   IF cl_null(l_apce139_sumC) THEN LET l_apce139_sumC = 0 END IF
   #151207-00018#3   
   LET l_sql = "SELECT SUM(apce119),SUM(apce129),SUM(apce139)  ",
               "  FROM apca_t LEFT JOIN apce_t ON apcaent = apceent AND apcald = apceld AND apcadocno = apce003",
               " WHERE apcaent = ",g_enterprise," AND apceld = '",g_apda_m.apdald,"' AND apcedocno = '",g_apda_m.apdadocno,"'",
              # "  AND (apcadocno,apce004) IN (SELECT apcfdocno,apcfseq FROM apcf_t WHERE apcaent = apcfent AND apcadocno = apcfdocno)",
               "  AND apce002 = '05' "     #151218-00004#1
   PREPARE sel_aapt430_sumapcf119C FROM l_sql
   EXECUTE sel_aapt430_sumapcf119C INTO l_apce119_sumDIFF,l_apce129_sumDIFF,l_apce139_sumDIFF
   IF cl_null(l_apce119_sumDIFF) THEN LET l_apce119_sumDIFF = 0 END IF
   IF cl_null(l_apce129_sumDIFF) THEN LET l_apce129_sumDIFF = 0 END IF
   IF cl_null(l_apce139_sumDIFF) THEN LET l_apce139_sumDIFF = 0 END IF
   #151207-00018#3
   LET g_apda_m.apda113 = l_apce119_sumD - l_apce119_sumC + l_apce119_sumDIFF
   LET g_apda_m.apda123 = l_apce129_sumD - l_apce129_sumC + l_apce129_sumDIFF
   LET g_apda_m.apda133 = l_apce139_sumD - l_apce139_sumC + l_apce139_sumDIFF
   
   UPDATE apda_t SET apda113 = g_apda_m.apda113
                    ,apda123 = g_apda_m.apda123
                    ,apda133 = g_apda_m.apda133
    WHERE apdaent = g_enterprise
      AND apdald  = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單頭金額&單尾來源金額統計顯示
# Memo...........:
# Date & Author..: 14/08/07 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt430_sum_show()
DEFINE l_apdc113        LIKE apdc_t.apdc113
DEFINE l_apdc213        LIKE apdc_t.apdc213
   
   #來源應攤銷金額
   SELECT apda113 INTO g_apda_m.apda113
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdald  = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
   IF cl_null(g_apda_m.apda113)THEN LET g_apda_m.apda113 = 0 END IF

   #目的己攤銷金額 l_sum_apdc113123  合計目的檔案金額，依正負數合計 SUM (apdc113)-SUM (apdc213) 
   LET g_apda_m.l_sum_apdc113213 = ''
   LET l_apdc113 = ''
   LET l_apdc213 = ''
   SELECT SUM(apdc113),SUM(apdc213) INTO l_apdc113,l_apdc213
     FROM apdc_t
    WHERE apdcent = g_enterprise
      AND apdcld  = g_apda_m.apdald
      AND apdcdocno = g_apda_m.apdadocno
   IF cl_null(l_apdc113)THEN LET l_apdc113 = 0 END IF
   IF cl_null(l_apdc213)THEN LET l_apdc213 = 0 END IF
   #分攤後-分攤前
   LET g_apda_m.l_sum_apdc113213 = l_apdc213 - l_apdc113
   
   #差異未攤銷金額l_sum_apceapdc
   LET g_apda_m.l_sum_apceapdc = g_apda_m.apda113 - g_apda_m.l_sum_apdc113213
   
   
   #費用分攤(19/15/13/01/03) l_sumcost
   LET g_apda_m.l_sumcost = NULL
   SELECT SUM(apce119) INTO g_apda_m.l_sumcost
     FROM apce_t,apca_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apda_m.apdald
      AND apcedocno  = g_apda_m.apdadocno
      AND apcaent = apceent
      AND apcald  = apceld
      AND apcadocno = apce003
      AND apca001 IN ('22','19','17','15','13','01','03') #160506-00002#3 add 22,17
   IF cl_null(g_apda_m.l_sumcost)THEN LET g_apda_m.l_sumcost = 0 END IF
   
   #折扣分攤(29/02/04) l_sumdiscount
   LET g_apda_m.l_sumdiscount = NULL
   SELECT SUM(apce119) INTO g_apda_m.l_sumdiscount
     FROM apce_t,apca_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apda_m.apdald
      AND apcedocno  = g_apda_m.apdadocno
      AND apcaent = apceent
      AND apcald  = apceld
      AND apcadocno = apce003
      AND apca001 IN ('29','02','04')
   IF cl_null(g_apda_m.l_sumdiscount)THEN LET g_apda_m.l_sumdiscount = 0 END IF
   
   #預(溢)付分攤(21/23/24/26) l_sumperpay
   LET g_apda_m.l_sumprepay = NULL
   SELECT SUM(apce119) INTO g_apda_m.l_sumprepay
     FROM apce_t,apca_t
    WHERE apceent = g_enterprise
      AND apceld  = g_apda_m.apdald
      AND apcedocno  = g_apda_m.apdadocno
      AND apcaent = apceent
      AND apcald  = apceld
      AND apcadocno = apce003
      AND apca001 IN ('21','23','24','26')
   IF cl_null(g_apda_m.l_sumprepay)THEN LET g_apda_m.l_sumprepay = 0 END IF
   
   DISPLAY BY NAME g_apda_m.apda113,g_apda_m.l_sum_apdc113213,g_apda_m.l_sum_apceapdc,
                   g_apda_m.l_sumcost,g_apda_m.l_sumdiscount,g_apda_m.l_sumprepay
END FUNCTION

################################################################################
# Descriptions...: 本幣推算原幣、本位幣二、本位幣三
# Memo...........:
# Usage..........: CALL aapt430_cal_other_money(p_ld,p_docdt,p_apce100,p_apce101,p_apce119,p_apce121,p_apce131)
#                  RETURNING r_apce109,r_apce129,r_apce139
# Input parameter: p_ld        帳別
#                : p_docdt     單據日期
#                : p_apce100   幣別
#                : p_apce101   匯率
#                : p_apce119   本幣
#                : p_apce121   匯率-本幣二
#                : p_apce131   匯率-本幣三
# Return code....: r_apce109   原幣
#                : r_apce129   本位幣二
#                : r_apce139   本位幣三
# Date & Author..: 2014/12/10 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_cal_other_money(p_ld,p_docdt,p_apce100,p_apce101,p_apce119,p_apce121,p_apce131)
DEFINE p_ld         LIKE apda_t.apdald
DEFINE p_docdt      LIKE apda_t.apdadocdt
DEFINE p_apce100    LIKE apce_t.apce100    #幣別
DEFINE p_apce101    LIKE apce_t.apce101    #匯率
DEFINE p_apce119    LIKE apce_t.apce119    #本幣分攤金額
DEFINE p_apce121    LIKE apce_t.apce121    #匯率-本幣二
DEFINE p_apce131    LIKE apce_t.apce131    #匯率-本幣三
DEFINE l_glaa       RECORD
         glaa001    LIKE glaa_t.glaa001,
         glaa002    LIKE glaa_t.glaa002,   #匯率參照表
         glaa015    LIKE glaa_t.glaa015,
         glaa016    LIKE glaa_t.glaa016,   #160816-00022#1
         glaa017    LIKE glaa_t.glaa017,
         glaa019    LIKE glaa_t.glaa019,
         glaa020    LIKE glaa_t.glaa020,   #160816-00022#1
         glaa021    LIKE glaa_t.glaa021
                    END RECORD
DEFINE l_ooan013    LIKE ooan_t.ooan013    #匯率輸入方式
DEFINE r_apce109    LIKE apce_t.apce109
DEFINE r_apce129    LIKE apce_t.apce129
DEFINE r_apce139    LIKE apce_t.apce139

   IF cl_null(p_apce101) THEN LET p_apce101 = 0 END IF
   IF cl_null(p_apce119) THEN LET p_apce119 = 0 END IF
   IF cl_null(p_apce121) THEN LET p_apce121 = 0 END IF
   IF cl_null(p_apce131) THEN LET p_apce131 = 0 END IF
   
   #使用幣別/匯率參照表號/啟用本位幣二/本位幣二換算基準/啟用本位幣三/本位幣三換算基準
   CALL s_ld_sel_glaa(p_ld,'glaa001|glaa002|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021')   #160816-00022#1 add glaa016,glaa020
        RETURNING g_sub_success,l_glaa.glaa001,l_glaa.glaa002
                 ,l_glaa.glaa015,l_glaa.glaa016,l_glaa.glaa017   #160816-00022#1 add glaa016
                 ,l_glaa.glaa019,l_glaa.glaa020,l_glaa.glaa021   #160816-00022#1 add glaa020
   
   #推算出原幣
   #用匯率參照表找出是用乘推還是用除推
   SELECT ooan013 INTO l_ooan013
     FROM ooan_t,ooam_t
    WHERE ooament = ooanent
      AND ooam001 = ooan001
      AND ooam003 = ooan003
      AND ooam004 = p_docdt
      AND ooanent = g_enterprise
      AND ooan001 = l_glaa.glaa002   #匯率參照表號
      AND ooan002 = p_apce100        #交易幣別
      AND ooan003 = l_glaa.glaa001   #基礎幣別
      AND ooamstus = 'Y'

   IF cl_null(l_ooan013) THEN LET l_ooan013 = 1 END IF
   
   IF l_ooan013 = "1" THEN
      LET r_apce109 = p_apce119 / p_apce101
   ELSE
      LET r_apce109 = p_apce101 * p_apce119
   END IF
   IF cl_null(r_apce109) THEN LET r_apce109 = 0 END IF
   #取位
  #CALL s_curr_round_ld('1',p_ld,l_glaa.glaa001,r_apce109,2) RETURNING g_sub_success,g_errno,r_apce109   #160816-00022#1 mark
   CALL s_curr_round_ld('1',p_ld,p_apce100,r_apce109,2) RETURNING g_sub_success,g_errno,r_apce109        #160816-00022#1 
   
   #本位幣二
   IF l_glaa.glaa015 = "Y" THEN
      IF l_glaa.glaa017 = "1" THEN #用原幣推
         LET r_apce129 = r_apce109 * p_apce121
      ELSE
         LET r_apce129 = p_apce119 * p_apce121
      END IF
   END IF
   IF cl_null(r_apce129) THEN LET r_apce129 = 0 END IF
   #取位
  #CALL s_curr_round_ld('1',p_ld,l_glaa.glaa001,r_apce129,2) RETURNING g_sub_success,g_errno,r_apce129   #160816-00022#1 mark
   CALL s_curr_round_ld('1',p_ld,l_glaa.glaa016,r_apce129,2) RETURNING g_sub_success,g_errno,r_apce129   #160816-00022#1 
   
   #本位幣三
   IF l_glaa.glaa019 = "Y" THEN
      IF l_glaa.glaa021 = "1" THEN #用原幣推
         LET r_apce139 = r_apce109 * p_apce131
      ELSE
         LET r_apce139 = p_apce119 * p_apce131
      END IF
   END IF
   IF cl_null(r_apce139) THEN LET r_apce139 = 0 END IF
   #取位
  #CALL s_curr_round_ld('1',p_ld,l_glaa.glaa001,r_apce139,2) RETURNING g_sub_success,g_errno,r_apce139   #160816-00022#1 mark
   CALL s_curr_round_ld('1',p_ld,l_glaa.glaa020,r_apce139,2) RETURNING g_sub_success,g_errno,r_apce139   #160816-00022#1 
   
   RETURN r_apce109,r_apce129,r_apce139

END FUNCTION

################################################################################
# Descriptions...: 整單操作>>重分攤計算
# Memo...........:
# Usage..........: CALL aapt430_apce_apdc_balance()

# Date & Author..: 2014/12/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_apce_apdc_balance()
DEFINE l_apdc        RECORD
         apdcseq     LIKE apdc_t.apdcseq,
         apdc002     LIKE apdc_t.apdc002,
         apdc008     LIKE apdc_t.apdc008,
         apdc015     LIKE apdc_t.apdc015, #借/貸
         apdc113     LIKE apdc_t.apdc113,
         apdc123     LIKE apdc_t.apdc123,
         apdc133     LIKE apdc_t.apdc133
                     END RECORD
DEFINE l_sql         STRING
DEFINE l_i           LIKE type_t.num10
DEFINE l_count       LIKE type_t.num10
DEFINE l_apdc008_sum LIKE apdc_t.apdc008
DEFINE l_apdc113_sum LIKE apdc_t.apdc113
DEFINE l_apdc123_sum LIKE apdc_t.apdc123
DEFINE l_apdc133_sum LIKE apdc_t.apdc133
DEFINE l_apdc113_max LIKE apdc_t.apdc113
DEFINE l_apdc123_max LIKE apdc_t.apdc123
DEFINE l_apdc133_max LIKE apdc_t.apdc133
DEFINE l_apdcseq_max LIKE apdc_t.apdcseq
DEFINE l_apda113_sum LIKE apda_t.apda113
DEFINE l_apda123_sum LIKE apda_t.apda123
DEFINE l_apda133_sum LIKE apda_t.apda133
DEFINE l_apdc211     LIKE apdc_t.apdc211
DEFINE l_apdc213     LIKE apdc_t.apdc213
DEFINE l_apdc223     LIKE apdc_t.apdc223
DEFINE l_apdc233     LIKE apdc_t.apdc233
DEFINE l_apdc213_sum LIKE apdc_t.apdc213
DEFINE l_apdc223_sum LIKE apdc_t.apdc223
DEFINE l_apdc233_sum LIKE apdc_t.apdc233
DEFINE l_pmds037     LIKE pmds_t.pmds037 #來源單據的幣別
DEFINE l_diff        LIKE type_t.num20_6
DEFINE l_success     LIKE type_t.chr1
DEFINE l_do_diff     LIKE type_t.chr1

   LET l_success = 'Y'
   CALL s_transaction_begin()
   
   #項次/數量/本幣分攤前金額/本位幣二分攤前金額/本位幣三分攤前金額
   LET l_sql = " SELECT apdcseq,apdc002,apdc008,apdc015",
               "       ,apdc113,apdc123,apdc133",
               "   FROM apdc_t ",
               "  WHERE apdcent = ",g_enterprise,
               "    AND apdcld = '",g_apda_m.apdald,"'",
               "    AND apdcdocno = '",g_apda_m.apdadocno,"'"
   PREPARE sel_aapt430_apdcp2 FROM l_sql
   DECLARE sel_aapt430_apdcc2 CURSOR FOR sel_aapt430_apdcp2
   LET l_apdc008_sum = 0
   LET l_apdc113_sum = 0
   LET l_apdc123_sum = 0
   LET l_apdc133_sum = 0
   #FOREACH sel_aapt430_apdcc2 INTO l_apdc.* #161208-00026#9 mark
   #161208-00026#9-add(s)
   FOREACH sel_aapt430_apdcc2 INTO l_apdc.apdcseq,l_apdc.apdc002,l_apdc.apdc008,l_apdc.apdc015,l_apdc.apdc113,
                                   l_apdc.apdc123,l_apdc.apdc133
   #161208-00026#9-add(e)
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(l_apdc.apdc113)THEN LET l_apdc.apdc113 = 0 END IF
      IF cl_null(l_apdc.apdc123)THEN LET l_apdc.apdc123 = 0 END IF
      IF cl_null(l_apdc.apdc133)THEN LET l_apdc.apdc133 = 0 END IF
      #統計分攤前總金額
      LET l_apdc113_sum = l_apdc113_sum + l_apdc.apdc113
      LET l_apdc123_sum = l_apdc123_sum + l_apdc.apdc123
      LET l_apdc133_sum = l_apdc133_sum + l_apdc.apdc133
      #統計分攤前總數量
      LET l_apdc008_sum = l_apdc008_sum + l_apdc.apdc008
   END FOREACH
   
   #統計本幣分攤金額(改取單頭的錢)
   LET l_apda113_sum = g_apda_m.apda113
   LET l_apda123_sum = g_apda_m.apda123
   LET l_apda133_sum = g_apda_m.apda133
   IF cl_null(l_apda113_sum)THEN LET l_apda113_sum = 0 END IF
   IF cl_null(l_apda123_sum)THEN LET l_apda123_sum = 0 END IF
   IF cl_null(l_apda133_sum)THEN LET l_apda133_sum = 0 END IF
   IF l_apda113_sum = 0 AND l_apda123_sum= 0 AND l_apda133_sum = 0 THEN
      CALL s_transaction_end('N',0)
      RETURN 
   END IF

   #統計有幾筆要作分攤
   SELECT COUNT(*) INTO l_count
     FROM apdc_t
    WHERE apdcent = g_enterprise
      AND apdcld = g_apda_m.apdald
      AND apdcdocno = g_apda_m.apdadocno
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   LET l_apdc113_max = 0
   LET l_apdc123_max = 0
   LET l_apdc133_max = 0
   
   LET l_sql = " SELECT apdcseq,apdc002,apdc008,apdc015",
               "       ,apdc113,apdc123,apdc133",
               "   FROM apdc_t ",
               "  WHERE apdcent = ",g_enterprise,
               "    AND apdcld  = '",g_apda_m.apdald,"' ",
               "    AND apdcdocno = '",g_apda_m.apdadocno,"' ",
               "  ORDER BY apdc113 DESC"
   PREPARE sel_aapt430_apdcp3 FROM l_sql
   DECLARE sel_aapt430_apdcc3 CURSOR FOR sel_aapt430_apdcp3
   LET l_i = 1
   #FOREACH sel_aapt430_apdcc3 INTO l_apdc.*   #161208-00026#9 mark
   #161208-00026#9-add(s)
   FOREACH sel_aapt430_apdcc2 INTO l_apdc.apdcseq,l_apdc.apdc002,l_apdc.apdc008,l_apdc.apdc015,l_apdc.apdc113,
                                   l_apdc.apdc123,l_apdc.apdc133
   #161208-00026#9-add(e)
      #取得來源單據的幣別
      SELECT pmds037 INTO l_pmds037
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_apdc.apdc002
   
      CASE g_apda_m.apda020
         WHEN "1" #1:依金額比例分攤
            LET l_apdc213 = l_apdc.apdc113 + l_apda113_sum * (l_apdc.apdc113 / l_apdc113_sum)
            LET l_apdc223 = l_apdc.apdc123 + l_apda123_sum * (l_apdc.apdc123 / l_apdc123_sum)
            LET l_apdc233 = l_apdc.apdc133 + l_apda133_sum * (l_apdc.apdc133 / l_apdc133_sum)

         WHEN "2" #2:依數量比例分攤
            LET l_apdc213 = l_apdc.apdc113 + l_apda113_sum * (l_apdc.apdc008 / l_apdc008_sum)
            LET l_apdc223 = l_apdc.apdc123 + l_apda123_sum * (l_apdc.apdc008 / l_apdc008_sum)
            LET l_apdc233 = l_apdc.apdc133 + l_apda133_sum * (l_apdc.apdc008 / l_apdc008_sum)
            
         WHEN "0" #0:平均分攤
            LET l_apdc213 = l_apdc.apdc113 + (l_apda113_sum / l_count)
            LET l_apdc223 = l_apdc.apdc123 + (l_apda123_sum / l_count)
            LET l_apdc233 = l_apdc.apdc133 + (l_apda133_sum / l_count)
      END CASE
      #取位
      CALL s_curr_round_ld('1',g_apda_m.apdald,l_pmds037,l_apdc213,2) RETURNING g_sub_success,g_errno,l_apdc213
      CALL s_curr_round_ld('1',g_apda_m.apdald,l_pmds037,l_apdc223,2) RETURNING g_sub_success,g_errno,l_apdc223
      CALL s_curr_round_ld('1',g_apda_m.apdald,l_pmds037,l_apdc233,2) RETURNING g_sub_success,g_errno,l_apdc233
      
      #重新計算分攤後單價
      LET l_apdc211 = l_apdc213 / l_apdc.apdc008
      #Reanna 15/02/03
      #CALL s_curr_round_ld('1',g_apda_m.apdald,l_pmds037,l_apdc211,2) RETURNING g_sub_success,g_errno,l_apdc211
      CALL s_curr_round_ld('1',g_apda_m.apdald,l_pmds037,l_apdc211,1) RETURNING g_sub_success,g_errno,l_apdc211
      
      IF cl_null(l_apdc213) THEN LET l_apdc213 = 0 END IF
      IF cl_null(l_apdc223) THEN LET l_apdc223 = 0 END IF
      IF cl_null(l_apdc233) THEN LET l_apdc233 = 0 END IF
      IF cl_null(l_apdc211) THEN LET l_apdc211 = 0 END IF
      
      #160506-00002#3 ---s---
      ##若金額小於零，要做借貸相反處理
      #IF (l_apdc213-l_apdc.apdc113) < 0 THEN
      #   IF l_apdc.apdc015 = 'D' THEN
      #      LET l_apdc.apdc015 = 'C'
      #   ELSE
      #      LET l_apdc.apdc015 = 'D'
      #   END IF
      #END IF      
      IF (l_apdc213-l_apdc.apdc113) < 0 THEN
         LET l_apdc.apdc015 = 'C'
      ELSE
         LET l_apdc.apdc015 = 'D'
      END IF
      #160506-00002#3 ---e---
      
      UPDATE apdc_t SET apdc213 = l_apdc213
                       ,apdc223 = l_apdc223
                       ,apdc233 = l_apdc233
                       ,apdc211 = l_apdc211
                       ,apdc015 = l_apdc.apdc015
       WHERE apdcent = g_enterprise
         AND apdcld = g_apda_m.apdald
         AND apdcdocno = g_apda_m.apdadocno
         AND apdcseq = l_apdc.apdcseq
      
      #紀錄金額最大的那一筆(尾差處理用)
      IF l_i = 1 THEN
         LET l_apdc113_max = l_apdc213
         LET l_apdc123_max = l_apdc223
         LET l_apdc133_max = l_apdc233
         LET l_apdcseq_max = l_apdc.apdcseq
      END IF
      LET l_i = l_i + 1
   END FOREACH

   #尾差處理
   #取得攤完之後的總額
   SELECT SUM(apdc213),SUM(apdc223),SUM(apdc233)
     INTO l_apdc213_sum,l_apdc223_sum,l_apdc233_sum
     FROM apdc_t
    WHERE apdcent = g_enterprise
      AND apdcld = g_apda_m.apdald
      AND apdcdocno = g_apda_m.apdadocno
   IF cl_null(l_apdc213_sum)THEN LET l_apdc213_sum = 0 END IF
   IF cl_null(l_apdc223_sum)THEN LET l_apdc223_sum = 0 END IF
   IF cl_null(l_apdc233_sum)THEN LET l_apdc233_sum = 0 END IF
   #計算有無尾差
   LET l_diff = 0
   LET l_do_diff = "N"
   
   IF (l_apdc113_sum + l_apda113_sum) <> l_apdc213_sum THEN
      LET l_diff = (l_apdc113_sum + l_apda113_sum) - l_apdc213_sum
      LET l_apdc213 = l_apdc113_max + l_diff
      LET l_do_diff = "Y"
   END IF
   IF (l_apdc123_sum + l_apda123_sum) <> l_apdc223_sum THEN
      LET l_diff = (l_apdc123_sum + l_apda123_sum) - l_apdc223_sum
      LET l_apdc223 = l_apdc123_max + l_diff
      LET l_do_diff = "Y"
   END IF
   IF (l_apdc133_sum + l_apda133_sum) <> l_apdc233_sum THEN
      LET l_diff = (l_apdc133_sum + l_apda133_sum) - l_apdc233_sum
      LET l_apdc233 = l_apdc133_max + l_diff
      LET l_do_diff = "Y"
   END IF

   IF l_do_diff = "Y" THEN
      UPDATE apdc_t SET apdc213 = l_apdc213
                       ,apdc223 = l_apdc223
                       ,apdc233 = l_apdc233
       WHERE apdcent = g_enterprise
         AND apdcld = g_apda_m.apdald
         AND apdcdocno = g_apda_m.apdadocno
         AND apdcseq = l_apdcseq_max
   END IF
      
   IF l_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 編輯完單據後立即審核
# Memo...........:
# Usage..........: CALL aapt430_immediately_conf()
#                  RETURNING ---

# Date & Author..: 2015/12/01 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   IF cl_null(g_apda_m.apdald)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdasite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdadocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apce_t WHERE apceent = g_enterprise
      AND apcedocno = g_apda_m.apdadocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
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
      

   IF NOT s_aapt430_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_aapt430_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno) THEN
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
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

################################################################################
# Descriptions...: 編輯完單據後立即拋轉憑證
# Memo...........:
# Usage..........: CALL aapt430_immediately_gen()
#                  RETURNING ---
# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_immediately_gen()
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
        RETURNING g_sub_success,l_glaacomp,g_glaa102
   #取所屬法人關帳日
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
   
   
   
    
   #取得單別
   CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
   # D-FIN-0030 产生分录传票否
   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0030') RETURNING l_chr
   IF l_chr <> 'Y' OR  cl_null(l_chr) THEN RETURN END IF 
   
   #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032
 
   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      RETURN 
   END IF 
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
   IF cl_null(l_gl_slip) THEN
      #產生單別/日期
      #CALL axrp330_01(g_apda_m.apdald) RETURNING l_gl_slip,l_date                         #160620-00010#2 mark
      CALL axrp330_01(g_apda_m.apdald,g_apda_m.apdadocdt,g_apda_m.apdadocno) RETURNING l_gl_slip,l_date       #160620-00010#2 add   #160620-00010#2 add  #161213-00023#2 add g_apda_m.apdadocno
   ELSE 
      LET l_date = g_apda_m.apdadocdt
   END IF 
   #必須大於帳套關帳日期才可拋轉
      IF l_date < l_sfin3007 THEN 
         RETURN
      END IF
   
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
      CALL s_aapp330_gen_ac('1','P30',g_apda_m.apdald,'','','1','!#@',g_apda_m.apdastus) RETURNING g_sub_success,l_start_no,l_start_no
      IF g_sub_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')
      END IF
   
      #傳票拋轉
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      CALL s_aapp330_generate_voucher('P30',l_gl_slip,l_date,g_apda_m.apdald,'1','Y',g_glaa102,'AP')
           RETURNING g_sub_success,g_apda_m.apda014,g_apda_m.apda014
      CALL cl_err_collect_show()
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
      #重新顯示傳票號碼
      SELECT apda014 INTO g_apda_m.apda014
        FROM apda_t
       WHERE apdaent = g_enterprise
         AND apdadocno = g_apda_m.apdadocno
         AND apdald = g_apda_m.apdald
      DISPLAY BY NAME g_apda_m.apda014
      
   END IF

      
      
      
#151125-00006#2---e
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#3
# Usage..........: CALL aapt430_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161021 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt430_get_ooef001_wc(p_wc)
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

 
{</section>}
 
