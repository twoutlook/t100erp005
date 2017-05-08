#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt311.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0036(2017-02-13 15:59:29), PR版次:0036(2017-02-13 16:35:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000582
#+ Filename...: anmt311
#+ Description: 銀存收支帳務處理作業
#+ Creator....: ()
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="anmt311.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#140829-00070#30  2015/01/13 By zhangwei 增加邏輯:根據單別的設定判斷是否拋轉傳票
#                                  　　　         根據單別的設定判斷是否將資料產生至分錄底稿表中
#141106-00011#22  2015/01/13 By Belle    增加COMMIT/REMARK conf段
#150417-00007#56  2015/06/10 BY 01727    單身來源增加anmt563繳款匯總單
#150618-00003#1   2015/06/18 By apo      屬於4:繳款單,應可撈取到anmt540之資料
#150616-00026#12  2015/06/22 By apo      如果非開窗多選寫入,那手打單號與項次還是能夠新增
#150714-00024#1   2015/07/15 By Reanna   bug修正
#150401-00001#13  2015/07/21 By RayHuang statechange段問題修正
#150803-00018#1   2015/08/12 By Reanna   產生帳務資料後，將單號傳回主程式，並查詢出來
#150930-00010#4   2015/10/05 By 03538    平行帳套處理:異動類別為支出,匯率來源參數參照S-FIN-4012,且日平均匯率以新元件計算
#151001-00006#1   2015/10/08 By yangtt   傳票拋轉後，回寫傳票編號，欄位可以串查傳票資料aglt310
#150930-00010#2   2015/10/22 By 02599    已抛转产生凭证时，凭证预览采用分录底稿预览方式
#150401-00001#31  2015/10/22 By Hans     修改狀況下把日期鎖掉，但新增時卻未開啟
#151013-00016#6   2015/10/30 By RayHuang glbc_t新增狀態碼
#150916-00015#1   2015/11/30 By 07392    当有账套时，科目检查改为检查是否存在于glad_t中
#151201-00003#2   2015/12/02 By 02599    1.单据来源=3收支单时，收支单号+项次可以为空，不为空时检查逻辑不变。
#                                        2.单据来源=收支单时，一笔anmt310的收支单号+项次可以拆开，但金额(原币本币）之和要与收支单相等.
#151125-00006#3   2015/12/18 By 07166    新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#151130-00015#2   2015/12/21 BY Xiaozg   根据是否可以更改單據日期 設定開放單據日期修改
#151224-00022#1   2016/01/13 By 02599    当异动别是3/4时，带出科目，在画面增加存提码
#150813-00015#4   2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160318-00005#27  2016/03/24 By 07900    重复错误信息修改
#160321-00016#39  2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160331-00011#1   2016/04/05 By 07673    修改整单操作中整批产生张务段；修改单身来源单号带值段,单身的nmbt021、nmbt022应该给来源单据单身的值
#160318-00025#1   2016/04/06 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160413-00025#1   2016/04/14 By 01531    单身的本币三金额与anmt310业务单的本币二、本币三金额小数位保留不一致，导致审核报金额有误
#160409-00004#21  2016/05/18 By liyan    单身增加往来账款核销数据逻辑
#160519-00043#1   2016/05/19 By 02599    当异动别为1存入或2提出时，反向若未設定對應的存提科目，則不產生單身的的3借方或4.贷方
#160525-00021#2   2016/05/25 By Dido     拋轉傳票指定傳票時宣告單別長度不足問題
#160509-00004#60  2016/05/25 By lujh     账套预设帐务中心的法人的帐套
#160620-00010#2   2016/06/21 By 01531    拋轉傳票時，傳票憑證日期應該預設單據的財務日期，而非系統日期
#160509-00004#114 2016/08/04 By 02114    anmt310单据产生anmt311时,若anmt310单身往来据点有值,则anmt311的交易客商和账款客商给往来据点的值
#160125-00005#8   2016/08/08 By 02599    查詢時加上帳套人員權限條件過濾
#160811-00055#2   2016/08/12 By 01531    取銀存收支單的資料時, 請含 nmba003 = 'anmt440'
#160727-00019#38  2016/08/15 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06,s_voucher_nm_group ——> s_vr_tmp07,s_voucher_fm_tmp ——> s_vr_tmp08
#160822-00018#1   2016/08/22 By Reanna   調整匯率取位問題，應用原幣幣別取位
#160816-00012#3   2016/09/01 By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#160905-00007#8   2016/09/05 By 07900    调整系统中无ENT的SQL条件增加ent
#160908-00015#1   2016/09/08 By 00768    修改成同anmt310，输入单身一笔不会报错，只要分录平就可以。目前审核的时候也不卡的
#160912-00024#1   2016/09/20 By 01531    来源组织权限控管
#160913-00017#5   2016/09/23 By 07900    ANM模组调整交易客商开窗
#160929-00040#1   2016/10/13 By 01531    账套开窗检查只能是主账套及平行账套，拿掉这个控卡
#161021-00050#8   2016/10/26 By Reanna   账务中心开窗调整为q_ooef001_46新增时where条件限定ooefstus= 'Y'查询时不限定此条件
#                                        法人进不去不调整;营运据点见excel"资金单身来源组织"
#160518-00024#14  2016/10/29 By 01531    取銀存收支單的資料時, 請含 nmba003 = 'aapt352'
#161028-00051#1   2016/10/31 By 08732    財務權限修改
#160822-00012#5   2016/11/10 By 08732    新舊值調整
#161110-00001#1   2016/11/28 By 07900    ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#161208-00065#1   2016/12/09 By 01531    單別有設定預設傳票單別, 卻沒有帶出來预设的单别 
#161215-00044#2   2016/12/16 by 02481    标准程式定义采用宣告模式,弃用.*写
#161026-00010#1   2016/12/22 By 01531    來源非nmba003<>'anmt311',其余皆須檢核nmbastus='V'
#170103-00019#14  2017/01/04 By 02599    1.凭证还原时，同步更新细项立冲账资料；2.当'S-COM-0002'=Y限定单据连号时, 采用凭证作废处理
#170105-00063#1   2017/01/06 By 02114    来源缴款单时,交易对象抓取anmt540单身的交易nmbb026
#161213-00023#1   2017/01/17 By 06694    新增aapp330_01、axrp330_01元件單別參數，默認拋轉單別
#161104-00046#12  2017/01/20 By 08729    單別預設值;資料依照單別user dept權限過濾單號
#161221-00054#3   2017/02/10 By 01531    相關單身(會計科目+部門) 及傳票預覽( 會計科目+部門), 要擋<<科目拒絕部門>> 參照agli060擋拒絕部門設定
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
 
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_nmbs_m        RECORD
       nmbssite LIKE nmbs_t.nmbssite, 
   nmbssite_desc LIKE type_t.chr80, 
   nmbsld LIKE nmbs_t.nmbsld, 
   nmbsld_desc LIKE type_t.chr80, 
   nmbscomp_desc LIKE type_t.chr500, 
   nmbscomp LIKE nmbs_t.nmbscomp, 
   glaa001 LIKE glaa_t.glaa001, 
   nmbsdocno LIKE nmbs_t.nmbsdocno, 
   nmbsdocdt LIKE nmbs_t.nmbsdocdt, 
   nmbs001 LIKE nmbs_t.nmbs001, 
   nmbs003 LIKE nmbs_t.nmbs003, 
   nmbs004 LIKE nmbs_t.nmbs004, 
   nmbsstus LIKE nmbs_t.nmbsstus, 
   nmbsownid LIKE nmbs_t.nmbsownid, 
   nmbsownid_desc LIKE type_t.chr80, 
   nmbsowndp LIKE nmbs_t.nmbsowndp, 
   nmbsowndp_desc LIKE type_t.chr80, 
   nmbscrtid LIKE nmbs_t.nmbscrtid, 
   nmbscrtid_desc LIKE type_t.chr80, 
   nmbscrtdp LIKE nmbs_t.nmbscrtdp, 
   nmbscrtdp_desc LIKE type_t.chr80, 
   nmbscrtdt LIKE nmbs_t.nmbscrtdt, 
   nmbsmodid LIKE nmbs_t.nmbsmodid, 
   nmbsmodid_desc LIKE type_t.chr80, 
   nmbsmoddt LIKE nmbs_t.nmbsmoddt, 
   nmbscnfid LIKE nmbs_t.nmbscnfid, 
   nmbscnfid_desc LIKE type_t.chr80, 
   nmbscnfdt LIKE nmbs_t.nmbscnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmbt_d        RECORD
       nmbtseq LIKE nmbt_t.nmbtseq, 
   nmbt017 LIKE nmbt_t.nmbt017, 
   nmbt017_desc LIKE type_t.chr500, 
   nmbt001 LIKE nmbt_t.nmbt001, 
   nmbt002 LIKE nmbt_t.nmbt002, 
   nmbt003 LIKE nmbt_t.nmbt003, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb002_desc LIKE type_t.chr500, 
   nmbt011 LIKE nmbt_t.nmbt011, 
   nmbb028 LIKE nmbb_t.nmbb028, 
   nmbb028_desc LIKE type_t.chr500, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbt100 LIKE nmbt_t.nmbt100, 
   nmbt101 LIKE nmbt_t.nmbt101, 
   nmbt103 LIKE nmbt_t.nmbt103, 
   nmbt113 LIKE nmbt_t.nmbt113, 
   nmbt029 LIKE nmbt_t.nmbt029, 
   nmbt029_desc LIKE type_t.chr500, 
   nmbt030 LIKE nmbt_t.nmbt030, 
   nmbt030_desc LIKE type_t.chr500, 
   nmbt012 LIKE nmbt_t.nmbt012, 
   nmbt013 LIKE nmbt_t.nmbt013, 
   nmbt014 LIKE nmbt_t.nmbt014, 
   nmbt121 LIKE nmbt_t.nmbt121, 
   nmbt123 LIKE type_t.num20_6, 
   nmbt131 LIKE nmbt_t.nmbt131, 
   nmbt133 LIKE type_t.num20_6, 
   nmbt004 LIKE nmbt_t.nmbt004
       END RECORD
PRIVATE TYPE type_g_nmbt2_d RECORD
       nmbtseq LIKE nmbt_t.nmbtseq, 
   nmbt001 LIKE nmbt_t.nmbt001, 
   nmbt002 LIKE nmbt_t.nmbt002, 
   nmbt003 LIKE nmbt_t.nmbt003, 
   nmbt018 LIKE nmbt_t.nmbt018, 
   nmbt018_desc LIKE type_t.chr500, 
   nmbt019 LIKE nmbt_t.nmbt019, 
   nmbt019_desc LIKE type_t.chr500, 
   nmbt020 LIKE nmbt_t.nmbt020, 
   nmbt020_desc LIKE type_t.chr500, 
   nmbt021 LIKE nmbt_t.nmbt021, 
   nmbt021_desc LIKE type_t.chr500, 
   nmbt022 LIKE nmbt_t.nmbt022, 
   nmbt022_desc LIKE type_t.chr500, 
   nmbt023 LIKE nmbt_t.nmbt023, 
   nmbt023_desc LIKE type_t.chr500, 
   nmbt024 LIKE nmbt_t.nmbt024, 
   nmbt024_desc LIKE type_t.chr500, 
   nmbt025 LIKE nmbt_t.nmbt025, 
   nmbt025_desc LIKE type_t.chr500, 
   nmbt026 LIKE nmbt_t.nmbt026, 
   nmbt026_desc LIKE type_t.chr500, 
   nmbt027 LIKE nmbt_t.nmbt027, 
   nmbt027_desc LIKE type_t.chr500, 
   nmbt028 LIKE nmbt_t.nmbt028, 
   nmbt028_desc LIKE type_t.chr500, 
   nmbt031 LIKE nmbt_t.nmbt031, 
   nmbt032 LIKE nmbt_t.nmbt032, 
   nmbt032_desc LIKE type_t.chr500, 
   nmbt033 LIKE nmbt_t.nmbt033, 
   nmbt033_desc LIKE type_t.chr500, 
   nmbt034 LIKE type_t.chr30, 
   nmbt034_desc LIKE type_t.chr500, 
   nmbt035 LIKE type_t.chr30, 
   nmbt035_desc LIKE type_t.chr500, 
   nmbt036 LIKE type_t.chr30, 
   nmbt036_desc LIKE type_t.chr500, 
   nmbt037 LIKE type_t.chr30, 
   nmbt037_desc LIKE type_t.chr500, 
   nmbt038 LIKE type_t.chr30, 
   nmbt038_desc LIKE type_t.chr500, 
   nmbt039 LIKE type_t.chr30, 
   nmbt039_desc LIKE type_t.chr500, 
   nmbt040 LIKE type_t.chr30, 
   nmbt040_desc LIKE type_t.chr500, 
   nmbt041 LIKE type_t.chr30, 
   nmbt041_desc LIKE type_t.chr500, 
   nmbt042 LIKE type_t.chr30, 
   nmbt042_desc LIKE type_t.chr500, 
   nmbt043 LIKE type_t.chr30, 
   nmbt043_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_nmbt3_d RECORD
       nmbtseq LIKE nmbt_t.nmbtseq, 
   nmbt001 LIKE nmbt_t.nmbt001, 
   nmbt002 LIKE nmbt_t.nmbt002, 
   nmbt003 LIKE nmbt_t.nmbt003, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbt100 LIKE nmbt_t.nmbt100, 
   nmbt103 LIKE nmbt_t.nmbt103, 
   nmbt121 LIKE nmbt_t.nmbt121, 
   nmbt123 LIKE nmbt_t.nmbt123, 
   nmbt131 LIKE nmbt_t.nmbt131, 
   nmbt133 LIKE nmbt_t.nmbt133
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmbsld LIKE nmbs_t.nmbsld,
      b_nmbsdocno LIKE nmbs_t.nmbsdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa005             LIKE glaa_t.glaa005
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa008             LIKE glaa_t.glaa008
DEFINE g_glaa014             LIKE glaa_t.glaa014
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa025             LIKE glaa_t.glaa025  #151201-00003#2 add
#是否做自由科目核算项管理
DEFINE g_glad017             LIKE glad_t.glad017
DEFINE g_glad0171            LIKE glad_t.glad0171 
DEFINE g_glad0172            LIKE glad_t.glad0172 
DEFINE g_glad018             LIKE glad_t.glad018
DEFINE g_glad0181            LIKE glad_t.glad0181
DEFINE g_glad0182            LIKE glad_t.glad0182
DEFINE g_glad019             LIKE glad_t.glad019
DEFINE g_glad0191            LIKE glad_t.glad0191
DEFINE g_glad0192            LIKE glad_t.glad0192
DEFINE g_glad020             LIKE glad_t.glad020
DEFINE g_glad0201            LIKE glad_t.glad0201
DEFINE g_glad0202            LIKE glad_t.glad0202
DEFINE g_glad021             LIKE glad_t.glad021
DEFINE g_glad0211            LIKE glad_t.glad0211
DEFINE g_glad0212            LIKE glad_t.glad0212
DEFINE g_glad022             LIKE glad_t.glad022
DEFINE g_glad0221            LIKE glad_t.glad0221
DEFINE g_glad0222            LIKE glad_t.glad0222
DEFINE g_glad023             LIKE glad_t.glad023
DEFINE g_glad0231            LIKE glad_t.glad0231
DEFINE g_glad0232            LIKE glad_t.glad0232
DEFINE g_glad024             LIKE glad_t.glad024
DEFINE g_glad0241            LIKE glad_t.glad0241
DEFINE g_glad0242            LIKE glad_t.glad0242
DEFINE g_glad025             LIKE glad_t.glad025
DEFINE g_glad0251            LIKE glad_t.glad0251
DEFINE g_glad0252            LIKE glad_t.glad0252
DEFINE g_glad026             LIKE glad_t.glad026
DEFINE g_glad0261            LIKE glad_t.glad0261
DEFINE g_glad0262            LIKE glad_t.glad0262
#开窗编号                     
DEFINE g_glae009             LIKE glae_t.glae009
DEFINE g_glae002             LIKE glae_t.glae002

DEFINE g_flag                LIKE type_t.chr1
DEFINE g_para_data           LIKE type_t.chr80     #資金模組匯率來源
DEFINE g_ap_slip             LIKE type_t.chr20
DEFINE g_ins_cnt             LIKE type_t.num5      #150616-00026#12

#151111-00001#1--add--str--lujh
DEFINE g_free_m    RECORD
       free_item_1     LIKE nmbt_t.nmbt034, 
       free_item_2     LIKE nmbt_t.nmbt035,
       free_item_3     LIKE nmbt_t.nmbt036, 
       free_item_4     LIKE nmbt_t.nmbt037,
       free_item_5     LIKE nmbt_t.nmbt038, 
       free_item_6     LIKE nmbt_t.nmbt039,
       free_item_7     LIKE nmbt_t.nmbt040, 
       free_item_8     LIKE nmbt_t.nmbt041,
       free_item_9     LIKE nmbt_t.nmbt042,     
       free_item_10    LIKE nmbt_t.nmbt043            
       END RECORD

DEFINE g_field_m       RECORD
       field1     LIKE type_t.chr10, 
       field2     LIKE type_t.chr10,
       field3     LIKE type_t.chr10, 
       field4     LIKE type_t.chr10,
       field5     LIKE type_t.chr10, 
       field6     LIKE type_t.chr10,
       field7     LIKE type_t.chr10, 
       field8     LIKE type_t.chr10,
       field9     LIKE type_t.chr10,     
       field10    LIKE type_t.chr10            
       END RECORD
#151111-00001#1--add--end--lujh
DEFINE g_wc_cs_ld            STRING   #160125-00005#8
DEFINE g_site_str            STRING   #160125-00005#8
DEFINE g_site_wc             STRING   #160816-00012#3  
DEFINE g_user_dept_wc        STRING   #161104-00046#12
DEFINE g_user_dept_wc_q      STRING   #161104-00046#12
DEFINE g_user_slip_wc        STRING   #161104-00046#12
#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmbs_m          type_g_nmbs_m
DEFINE g_nmbs_m_t        type_g_nmbs_m
DEFINE g_nmbs_m_o        type_g_nmbs_m
DEFINE g_nmbs_m_mask_o   type_g_nmbs_m #轉換遮罩前資料
DEFINE g_nmbs_m_mask_n   type_g_nmbs_m #轉換遮罩後資料
 
   DEFINE g_nmbsld_t LIKE nmbs_t.nmbsld
DEFINE g_nmbsdocno_t LIKE nmbs_t.nmbsdocno
 
 
DEFINE g_nmbt_d          DYNAMIC ARRAY OF type_g_nmbt_d
DEFINE g_nmbt_d_t        type_g_nmbt_d
DEFINE g_nmbt_d_o        type_g_nmbt_d
DEFINE g_nmbt_d_mask_o   DYNAMIC ARRAY OF type_g_nmbt_d #轉換遮罩前資料
DEFINE g_nmbt_d_mask_n   DYNAMIC ARRAY OF type_g_nmbt_d #轉換遮罩後資料
DEFINE g_nmbt2_d          DYNAMIC ARRAY OF type_g_nmbt2_d
DEFINE g_nmbt2_d_t        type_g_nmbt2_d
DEFINE g_nmbt2_d_o        type_g_nmbt2_d
DEFINE g_nmbt2_d_mask_o   DYNAMIC ARRAY OF type_g_nmbt2_d #轉換遮罩前資料
DEFINE g_nmbt2_d_mask_n   DYNAMIC ARRAY OF type_g_nmbt2_d #轉換遮罩後資料
DEFINE g_nmbt3_d          DYNAMIC ARRAY OF type_g_nmbt3_d
DEFINE g_nmbt3_d_t        type_g_nmbt3_d
DEFINE g_nmbt3_d_o        type_g_nmbt3_d
DEFINE g_nmbt3_d_mask_o   DYNAMIC ARRAY OF type_g_nmbt3_d #轉換遮罩前資料
DEFINE g_nmbt3_d_mask_n   DYNAMIC ARRAY OF type_g_nmbt3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      nmbbcomp LIKE nmbb_t.nmbbcomp,
      nmbbdocno LIKE nmbb_t.nmbbdocno,
      nmbbseq LIKE nmbb_t.nmbbseq,
      nmbb001 LIKE nmbb_t.nmbb001,
      nmbb002 LIKE nmbb_t.nmbb002,
      nmbb028 LIKE nmbb_t.nmbb028,
      nmbb029 LIKE nmbb_t.nmbb029
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
 
{<section id="anmt311.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#12-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_nmbs_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('nmbscomp','','nmbsent','nmbsdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#12-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmbssite,'',nmbsld,'','',nmbscomp,'',nmbsdocno,nmbsdocdt,nmbs001,nmbs003, 
       nmbs004,nmbsstus,nmbsownid,'',nmbsowndp,'',nmbscrtid,'',nmbscrtdp,'',nmbscrtdt,nmbsmodid,'',nmbsmoddt, 
       nmbscnfid,'',nmbscnfdt", 
                      " FROM nmbs_t",
                      " WHERE nmbsent= ? AND nmbsld=? AND nmbsdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt311_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbssite,t0.nmbsld,t0.nmbscomp,t0.nmbsdocno,t0.nmbsdocdt,t0.nmbs001, 
       t0.nmbs003,t0.nmbs004,t0.nmbsstus,t0.nmbsownid,t0.nmbsowndp,t0.nmbscrtid,t0.nmbscrtdp,t0.nmbscrtdt, 
       t0.nmbsmodid,t0.nmbsmoddt,t0.nmbscnfid,t0.nmbscnfdt,t1.ooefl003 ,t2.glaal002 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011",
               " FROM nmbs_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmbssite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.nmbsld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.nmbsownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.nmbsowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmbscrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.nmbscrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmbsmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.nmbscnfid  ",
 
               " WHERE t0.nmbsent = " ||g_enterprise|| " AND t0.nmbsld = ? AND t0.nmbsdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt311_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt311 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt311_init()   
 
      #進入選單 Menu (="N")
      CALL anmt311_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE s_vr_tmp06;  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
      DROP TABLE s_vr_tmp07;  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_group ——> s_vr_tmp07
      DROP TABLE s_vr_tmp08;  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_fm_tmp ——> s_vr_tmp08
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt311
      
   END IF 
   
   CLOSE anmt311_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt311.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt311_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002 
   DEFINE l_success  LIKE type_t.num5
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('nmbsstus','13','A,D,N,R,W,Y,X')
 
      CALL cl_set_combo_scc('nmbb001','8701') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','3',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
  #LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8717' AND gzcb003 IN ('anmt311','anmt561','adet403') "             #150618-00003#1 mark
  #LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8717' AND gzcb003 IN ('anmt311','anmt561','adet403','anmt540') "   #150618-00003#1 #161026-00010#1 mark
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8717' AND gzcb003 IN ('anmt311','anmt561','adet403','anmt540','anmt530','anmt541') "   #161026-00010#1 add
   PREPARE anmt311_nmbt001_prep FROM l_sql
   DECLARE anmt311_nmbt001_curs CURSOR FOR anmt311_nmbt001_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH anmt311_nmbt001_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('nmbt001','8717',l_str)

   CALL cl_set_combo_scc('nmbb001','8701')
   CALL cl_set_combo_scc('nmbt001_2','8717')
   CALL cl_set_combo_scc('nmbb029','8310')
   
   CALL cl_set_combo_scc('nmbt001_3','8717')
   CALL cl_set_combo_scc('nmbb001_3','8701')
   CALL cl_set_combo_scc('nmbb029_3','8310')
   CALL cl_set_combo_scc('nmbt031','6013')  #經營方式
   
   #LET g_flag = 'N'
   CALL s_voucher_cre_nm_tmp_table() RETURNING l_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success   #140829-00070#31 15/01/13   Add
   CALL s_fin_continue_no_tmp()
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   #初始化搜尋條件
   CALL anmt311_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt311.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt311_ui_dialog()
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
  #DEFINE l_slip      LIKE ooba_t.ooba002    #160525-00021#2 mark
   DEFINE l_slip      LIKE type_t.chr50      #160525-00021#2    
   DEFINE l_date      LIKE glap_t.glapdocdt
   DEFINE p_wc        STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_glapstus  LIKE glap_t.glapstus
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_chr       LIKE type_t.chr1
   DEFINE l_dfin0030  LIKE ooac_t.ooac004   #140829-00070#30 15/01/13 Add
   DEFINE l_ooba002   LIKE ooba_t.ooba002   #140829-00070#30 15/01/13 Add
   DEFINE l_glaa121   LIKE glaa_t.glaa121   #140829-00070#30 15/01/13 Add
   DEFINE l_yy1       LIKE glav_t.glav002
   DEFINE l_mm1       LIKE glav_t.glav004
   DEFINE l_yy2       LIKE glav_t.glav002
   DEFINE l_mm2       LIKE glav_t.glav004
   DEFINE l_docno     LIKE nmbs_t.nmbsdocno   #150803-00018#1
   DEFINE l_glap001   LIKE glap_t.glap001     #151001-00006#1
   DEFINE l_n         LIKE type_t.num10       #151125-00006#3
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL anmt311_insert()
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
         INITIALIZE g_nmbs_m.* TO NULL
         CALL g_nmbt_d.clear()
         CALL g_nmbt2_d.clear()
         CALL g_nmbt3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt311_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_nmbt_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt311_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL anmt311_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_anmt310
                  LET g_action_choice="prog_anmt310"
                  IF cl_auth_chk_act("prog_anmt310") THEN
                     
                     #add-point:ON ACTION prog_anmt310 name="menu.detail_show.page1_sub.prog_anmt310"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt310'
               LET la_param.param[1] = g_nmbs_m.nmbscomp
               LET la_param.param[2] = g_nmbt_d[l_ac].nmbt002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_nmbt2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt311_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL anmt311_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page2_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_anmt310
                  LET g_action_choice="prog_anmt310"
                  IF cl_auth_chk_act("prog_anmt310") THEN
                     
                     #add-point:ON ACTION prog_anmt310 name="menu.detail_show.page2_sub.prog_anmt310"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt310'
               LET la_param.param[1] = g_nmbs_m.nmbscomp
               LET la_param.param[2] = g_nmbt_d[l_ac].nmbt002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_nmbt3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt311_idx_chk()
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
               CALL anmt311_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page3_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_anmt310
                  LET g_action_choice="prog_anmt310"
                  IF cl_auth_chk_act("prog_anmt310") THEN
                     
                     #add-point:ON ACTION prog_anmt310 name="menu.detail_show.page3_sub.prog_anmt310"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt310'
               LET la_param.param[1] = g_nmbs_m.nmbscomp
               LET la_param.param[2] = g_nmbt_d[l_ac].nmbt002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt311_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL anmt311_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt311_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt311_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt311_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt311_set_act_visible()   
            CALL anmt311_set_act_no_visible()
            IF NOT (g_nmbs_m.nmbsld IS NULL
              OR g_nmbs_m.nmbsdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmbsent = " ||g_enterprise|| " AND",
                                  " nmbsld = '", g_nmbs_m.nmbsld, "' "
                                  ," AND nmbsdocno = '", g_nmbs_m.nmbsdocno, "' "
 
               #填到對應位置
               CALL anmt311_browser_fill("")
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
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmbs_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbt_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL anmt311_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmbs_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbt_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL anmt311_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt311_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt311_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt311_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt311_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt311_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt311_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt311_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt311_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt311_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt311_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt311_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmbt_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmbt2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_nmbt3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               CALL anmt311_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s
               CALL anmt311_immediately_conf()
               CALL anmt311_immediately_gen()
               SELECT COUNT(*) INTO l_n FROM nmbs_t
                WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld AND nmbsdocno = g_nmbs_m.nmbsdocno
                IF l_n > 0 THEN CALL anmt311_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt311_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               IF g_nmbs_m.nmbsstus = 'Y' THEN 
                  IF g_nmbt_d[l_ac].nmbt001 = '3' THEN 
                     LET la_param.prog = "anmt310"
                     LET la_param.param[1] = g_nmbs_m.nmbscomp
                     LET la_param.param[2] = g_nmbt_d[l_ac].nmbt002
                  END IF
                  IF g_nmbt_d[l_ac].nmbt001 = '4' THEN 
                     LET la_param.prog = "anmt540"
                     LET la_param.param[1] = g_nmbs_m.nmbscomp
                     LET la_param.param[2] = g_nmbt_d[l_ac].nmbt002
                  END IF
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
               
               #151125-00006#3--s
               CALL anmt311_immediately_conf()
               CALL anmt311_immediately_gen()
               SELECT COUNT(*) INTO l_n FROM nmbs_t
                WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld AND nmbsdocno = g_nmbs_m.nmbsdocno
                IF l_n > 0 THEN CALL anmt311_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               
               #140829-00070#30 15/01/13 Add
               IF NOT cl_null(g_nmbs_m.nmbsdocno) AND g_nmbs_m.nmbsstus = 'N' THEN
                  #获取单别
                  CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_slip
                  #是否抛傳票
                  CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0030') RETURNING l_dfin0030

                  IF l_dfin0030 = 'N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_slip
                     LET g_errparam.code   = 'axr-00225'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     EXIT DIALOG
                  END IF

                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,'1')
                     RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y','1')
                  ELSE
                     CALL s_transaction_end('N','1')
                  END IF
               END IF
              #140829-00070#30 15/01/13 Add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt311_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt311_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s
               CALL anmt311_immediately_conf()
               CALL anmt311_immediately_gen()
               SELECT COUNT(*) INTO l_n FROM nmbs_t
                WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld AND nmbsdocno = g_nmbs_m.nmbsdocno
                IF l_n > 0 THEN CALL anmt311_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " nmbsent = '",g_enterprise,"' AND nmbsdocno = '",g_nmbs_m.nmbsdocno,"' "
               #END add-point
               &include "erp/anm/anmt311_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " nmbsent = '",g_enterprise,"' AND nmbsdocno = '",g_nmbs_m.nmbsdocno,"' "
               #END add-point
               &include "erp/anm/anmt311_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_anmt311_01
            LET g_action_choice="open_anmt311_01"
            IF cl_auth_chk_act("open_anmt311_01") THEN
               
               #add-point:ON ACTION open_anmt311_01 name="menu.open_anmt311_01"
               #產生帳務資料
               CALL anmt311_01('','','','','','','')
               #150803-00018#1 add ------
                    RETURNING l_docno
               IF NOT cl_null(l_docno) THEN
                  LET g_nmbs_m.nmbsdocno = l_docno
                  #把產生的那張顯示出來
                  LET g_wc = " nmbsent = ",g_enterprise," AND nmbsdocno = '",g_nmbs_m.nmbsdocno,"' "
                  CALL anmt311_browser_fill("F")
                  CALL anmt311_fetch("F")
                  CALL anmt311_idx_chk()
               END IF
               #150803-00018#1 add end---
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt311_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrp330_01
            LET g_action_choice="open_axrp330_01"
            IF cl_auth_chk_act("open_axrp330_01") THEN
               
               #add-point:ON ACTION open_axrp330_01 name="menu.open_axrp330_01"
               #傳票產生
               IF g_nmbs_m.nmbsstus <> 'Y' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               IF NOT cl_null(g_nmbs_m.nmbs003) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00198'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               LET l_chr = 'N'
               
               #CALL s_aooi200_get_slip(g_nmbs_m.nmbsdocno) RETURNING g_sub_success,g_ap_slip                     #2014/12/29 liuym mark
               CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING g_sub_success,g_ap_slip                  #2014/12/29 liuym add
               #CALL cl_get_doc_para(g_enterprise,g_nmbs_m.nmbscomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr       #2014/12/25 liuym mark
               CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr  #2014/12/25 liuym add

               #單據別拋轉傳票否
               IF l_chr = 'Y' THEN              
                  CALL anmt311_fix_acc_open_chk() RETURNING l_success
                  CALL cl_err_collect_show()
                  IF l_success = FALSE THEN 
                     #CALL cl_err_showmsg()
                     EXIT DIALOG
                  END IF
               
                  #CALL axrp330_01(g_nmbs_m.nmbsld) RETURNING l_slip,l_date                     #160620-00010#2 mark
                  #CALL axrp330_01(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocdt) RETURNING l_slip,l_date   #160620-00010#2 add #161208-00065#1 mark
                  CALL aapp330_01(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocdt,'',g_nmbs_m.nmbsdocno) RETURNING l_slip,l_date#161208-00065#1 add  #161213-00023#1 add g_nmbs_m.nmbsdocno remove g_ap_slip
                  IF cl_null(l_slip) AND cl_null(l_date) THEN 
                     CONTINUE DIALOG
                  ELSE
                     LET l_yy1 = NULL
                     LET l_mm1 = NULL
                     LET l_yy2 = NULL
                     LET l_mm2 = NULL
                     SELECT glav002,glav006 INTO l_yy1,l_mm1 
                       FROM glav_t,glaa_t
                      WHERE glavent = glaaent
                        AND glav001 = glaa003
                        AND glav004 = g_nmbs_m.nmbsdocdt
                        AND glaaent = g_enterprise 
                        AND glaald = g_nmbs_m.nmbsld
                     
                     SELECT glav002,glav006 INTO l_yy2,l_mm2
                       FROM glav_t,glaa_t
                      WHERE glavent = glaaent
                        AND glav001 = glaa003
                        AND glav004 = l_date
                        AND glaaent = g_enterprise 
                        AND glaald = g_nmbs_m.nmbsld
                     
                     IF l_yy1 <> l_yy2 OR l_mm1 <> l_mm2 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-00327'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       
                        CONTINUE DIALOG
                     ELSE
                        CALL anmt311_turn_gen(l_slip,l_date)
                        SELECT nmbs003,nmbs004 INTO g_nmbs_m.nmbs003,g_nmbs_m.nmbs004 FROM nmbs_t WHERE nmbsent = g_enterprise
                                                                                                    AND nmbsld = g_nmbs_m.nmbsld
                                                                                                    AND nmbsdocno = g_nmbs_m.nmbsdocno
                        CALL anmt311_show()
                     END IF 
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00054'
                  LET g_errparam.extend = g_ap_slip
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF                
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reduction
            LET g_action_choice="reduction"
            IF cl_auth_chk_act("reduction") THEN
               
               #add-point:ON ACTION reduction name="menu.reduction"
               #傳票還原
               #150803-00018#1 add ------
               IF g_nmbs_m.nmbsdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #150803-00018#1 add end---
               
               IF cl_null(g_nmbs_m.nmbs003) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00186'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #150803-00018#1 add ------
               IF NOT cl_ask_confirm('aap-00239') THEN
                  EXIT DIALOG
               ELSE
               #150803-00018#1 add end---
                  SELECT glapstus INTO l_glapstus
                    FROM glap_t
                   WHERE glapent = g_enterprise
                     AND glapld = g_nmbs_m.nmbsld
                     AND glapdocno = g_nmbs_m.nmbs003
                  IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00076'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     EXIT DIALOG
                  END IF
                  CALL anmt311_reduction()
               END IF #150803-00018#1 add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt300_13
            LET g_action_choice="open_axrt300_13"
            IF cl_auth_chk_act("open_axrt300_13") THEN
               
               #add-point:ON ACTION open_axrt300_13 name="menu.open_axrt300_13"
#150930-00010#2--mark--str--
#               #傳票預覽
#               IF NOT cl_null(g_nmbs_m.nmbs003) THEN
#                  LET la_param.prog = 'aglt310'
#                  LET la_param.param[1] = g_nmbs_m.nmbsld
#                  LET la_param.param[2] = g_nmbs_m.nmbs003
#                  LET ls_js = util.JSON.stringify(la_param)
#                  CALL cl_cmdrun(ls_js)
#                  EXIT DIALOG
#               END IF                                         
#150930-00010#2--mark--end              
              #140829-00070#30 15/01/13 Mark
              ##IF g_flag = 'N' THEN
              #   CALL s_transaction_begin()
              #   LET p_wc = "nmbsdocno = '"||g_nmbs_m.nmbsdocno||"'"
              #   CALL s_voucher_gen_nm('1',g_nmbs_m.nmbsld,'',' ','0',p_wc,'Y','anmt311') RETURNING r_success
              ##END IF
              #CALL axrt300_13('AM',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,'') 
              #LET g_flag = 'Y'
              #140829-00070#30 15/01/13 Mark
             IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN  #150930-00010#2 add
               #140829-00070#30 15/01/13 Add
                CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
                CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
                SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
                   AND glaald = g_nmbs_m.nmbsld
                IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
                   CALL s_pre_voucher('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt)
                ELSE
                   CALL s_transaction_begin()
                   LET p_wc = "nmbsdocno = '"||g_nmbs_m.nmbsdocno||"'"
                   CALL s_voucher_gen_nm('1',g_nmbs_m.nmbsld,'',' ','0',p_wc,'Y','anmt311') RETURNING r_success
                   CALL axrt300_13('NM',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,'1')
                END IF
               #140829-00070#30 15/01/13 Add
             END IF  #150930-00010#2 add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmbs003
            LET g_action_choice="prog_nmbs003"
            IF cl_auth_chk_act("prog_nmbs003") THEN
               
               #add-point:ON ACTION prog_nmbs003 name="menu.prog_nmbs003"
               #151001-00006#1----add----str--
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL

               IF NOT cl_null(g_nmbs_m.nmbs003) THEN
                  SELECT glap001 INTO l_glap001 FROM glap_t WHERE glapent = g_enterprise
                     AND glapdocno = g_nmbs_m.nmbs003  AND glapld = g_nmbs_m.nmbsld
                  CASE
                     WHEN l_glap001 = '1'
                        LET la_param.prog = "aglt310"
                     WHEN l_glap001 = '2'
                        LET la_param.prog = "aglt320"
                     WHEN l_glap001 = '3'
                        LET la_param.prog = "aglt330"
                     WHEN l_glap001 = '5'
                        LET la_param.prog = "aglt350"
                  END CASE
                  LET la_param.param[1] = g_nmbs_m.nmbsld
                  LET la_param.param[2] = g_nmbs_m.nmbs003
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #151001-00006#1----add----end--
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt311_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt311_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt311_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmbs_m.nmbsdocdt)
 
 
 
         
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
 
{<section id="anmt311.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt311_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #160125-00005#8
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " nmbs001 = 'anmt311' "
   ELSE
      LET g_wc = g_wc," AND nmbs001 = 'anmt311'"
   END IF
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
   #160125-00005#8--add--str--
   #账套范围
   CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
   IF NOT cl_null(g_wc_cs_ld) THEN   
      LET l_ld_str = cl_replace_str(g_wc_cs_ld,"glaald","nmbsld")
      LET l_wc = l_wc , " AND ",l_ld_str
   END IF
   #160125-00005#8--add--end
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmbsld,nmbsdocno ",
                      " FROM nmbs_t ",
                      " ",
                      " LEFT JOIN nmbt_t ON nmbtent = nmbsent AND nmbsld = nmbtld AND nmbsdocno = nmbtdocno ", "  ",
                      #add-point:browser_fill段sql(nmbt_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN nmbb_t ON nmbbent = "||g_enterprise||" AND nmbsld = nmbbcomp AND nmbsdocno = nmbbdocno AND nmbtseq = nmbbseq ", 
 
 
                      " WHERE nmbsent = " ||g_enterprise|| " AND nmbtent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmbs_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbsld,nmbsdocno ",
                      " FROM nmbs_t ", 
                      "  ",
                      "  ",
                      " WHERE nmbsent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmbs_t")
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
      INITIALIZE g_nmbs_m.* TO NULL
      CALL g_nmbt_d.clear()        
      CALL g_nmbt2_d.clear() 
      CALL g_nmbt3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmbsld,t0.nmbsdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbsstus,t0.nmbsld,t0.nmbsdocno ",
                  " FROM nmbs_t t0",
                  "  ",
                  "  LEFT JOIN nmbt_t ON nmbtent = nmbsent AND nmbsld = nmbtld AND nmbsdocno = nmbtdocno ", "  ", 
                  #add-point:browser_fill段sql(nmbt_t1) name="browser_fill.join.nmbt_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN nmbb_t ON nmbbent = "||g_enterprise||" AND nmbsld = nmbbcomp AND nmbsdocno = nmbbdocno AND nmbtseq = nmbbseq ", 
 
 
                  
                  " WHERE t0.nmbsent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmbs_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbsstus,t0.nmbsld,t0.nmbsdocno ",
                  " FROM nmbs_t t0",
                  "  ",
                  
                  " WHERE t0.nmbsent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmbs_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmbsld,nmbsdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbs_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmbsld,g_browser[g_cnt].b_nmbsdocno 
 
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
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_nmbsld) THEN
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
 
{<section id="anmt311.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt311_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmbs_m.nmbsld = g_browser[g_current_idx].b_nmbsld   
   LET g_nmbs_m.nmbsdocno = g_browser[g_current_idx].b_nmbsdocno   
 
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
   CALL anmt311_nmbs_t_mask()
   CALL anmt311_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt311.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt311_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt311_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmbsld = g_nmbs_m.nmbsld 
         AND g_browser[l_i].b_nmbsdocno = g_nmbs_m.nmbsdocno 
 
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
 
{<section id="anmt311.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt311_construct()
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
   DEFINE l_wc        STRING #160816-00012#3 
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmbs_m.* TO NULL
   CALL g_nmbt_d.clear()        
   CALL g_nmbt2_d.clear() 
   CALL g_nmbt3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL #160125-00005#8
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmbssite,nmbsld,nmbscomp_desc,nmbscomp,glaa001,nmbsdocno,nmbsdocdt,nmbs001, 
          nmbs003,nmbs004,nmbsstus,nmbsownid,nmbsowndp,nmbscrtid,nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt, 
          nmbscnfid,nmbscnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbscrtdt>>----
         AFTER FIELD nmbscrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbsmoddt>>----
         AFTER FIELD nmbsmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbscnfdt>>----
         AFTER FIELD nmbscnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbspstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.nmbssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbssite
            #add-point:ON ACTION controlp INFIELD nmbssite name="construct.c.nmbssite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef201 = 'Y'" #150714-00024#1 #160816-00012#3 mark 
            #CALL q_ooef001()   #161021-00050#8 mark
            CALL q_ooef001_46() #161021-00050#8
            DISPLAY g_qryparam.return1 TO nmbssite
            NEXT FIELD nmbssite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbssite
            #add-point:BEFORE FIELD nmbssite name="construct.b.nmbssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbssite
            
            #add-point:AFTER FIELD nmbssite name="construct.a.nmbssite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #160125-00005#8
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="construct.c.nmbsld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160125-00005#8--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
            IF NOT cl_null(g_wc_cs_ld) THEN   
               #LET g_qryparam.where = g_wc_cs_ld                                                #161028-00051#1 mark
               LET g_qryparam.where = g_wc_cs_ld CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161028-00051#1 add
            END IF
            #160125-00005#8--add--end
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsld  #顯示到畫面上
            NEXT FIELD nmbsld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsld
            #add-point:BEFORE FIELD nmbsld name="construct.b.nmbsld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="construct.a.nmbsld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscomp_desc
            #add-point:BEFORE FIELD nmbscomp_desc name="construct.b.nmbscomp_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscomp_desc
            
            #add-point:AFTER FIELD nmbscomp_desc name="construct.a.nmbscomp_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbscomp_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp_desc
            #add-point:ON ACTION controlp INFIELD nmbscomp_desc name="construct.c.nmbscomp_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbscomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp
            #add-point:ON ACTION controlp INFIELD nmbscomp name="construct.c.nmbscomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()
            DISPLAY g_qryparam.return1 TO nmbscomp
            NEXT FIELD nmbscomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscomp
            #add-point:BEFORE FIELD nmbscomp name="construct.b.nmbscomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscomp
            
            #add-point:AFTER FIELD nmbscomp name="construct.a.nmbscomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="construct.c.nmbsdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'anmt311'
            #161104-00046#12-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#12-----e
            CALL q_nmbsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsdocno  #顯示到畫面上
            NEXT FIELD nmbsdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocno
            #add-point:BEFORE FIELD nmbsdocno name="construct.b.nmbsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="construct.a.nmbsdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocdt
            #add-point:BEFORE FIELD nmbsdocdt name="construct.b.nmbsdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocdt
            
            #add-point:AFTER FIELD nmbsdocdt name="construct.a.nmbsdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocdt
            #add-point:ON ACTION controlp INFIELD nmbsdocdt name="construct.c.nmbsdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs001
            #add-point:BEFORE FIELD nmbs001 name="construct.b.nmbs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs001
            
            #add-point:AFTER FIELD nmbs001 name="construct.a.nmbs001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs001
            #add-point:ON ACTION controlp INFIELD nmbs001 name="construct.c.nmbs001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs003
            #add-point:BEFORE FIELD nmbs003 name="construct.b.nmbs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs003
            
            #add-point:AFTER FIELD nmbs003 name="construct.a.nmbs003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs003
            #add-point:ON ACTION controlp INFIELD nmbs003 name="construct.c.nmbs003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs004
            #add-point:BEFORE FIELD nmbs004 name="construct.b.nmbs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs004
            
            #add-point:AFTER FIELD nmbs004 name="construct.a.nmbs004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs004
            #add-point:ON ACTION controlp INFIELD nmbs004 name="construct.c.nmbs004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsstus
            #add-point:BEFORE FIELD nmbsstus name="construct.b.nmbsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsstus
            
            #add-point:AFTER FIELD nmbsstus name="construct.a.nmbsstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsstus
            #add-point:ON ACTION controlp INFIELD nmbsstus name="construct.c.nmbsstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbsownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsownid
            #add-point:ON ACTION controlp INFIELD nmbsownid name="construct.c.nmbsownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsownid  #顯示到畫面上
            NEXT FIELD nmbsownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsownid
            #add-point:BEFORE FIELD nmbsownid name="construct.b.nmbsownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsownid
            
            #add-point:AFTER FIELD nmbsownid name="construct.a.nmbsownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbsowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsowndp
            #add-point:ON ACTION controlp INFIELD nmbsowndp name="construct.c.nmbsowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsowndp  #顯示到畫面上
            NEXT FIELD nmbsowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsowndp
            #add-point:BEFORE FIELD nmbsowndp name="construct.b.nmbsowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsowndp
            
            #add-point:AFTER FIELD nmbsowndp name="construct.a.nmbsowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbscrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscrtid
            #add-point:ON ACTION controlp INFIELD nmbscrtid name="construct.c.nmbscrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbscrtid  #顯示到畫面上
            NEXT FIELD nmbscrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscrtid
            #add-point:BEFORE FIELD nmbscrtid name="construct.b.nmbscrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscrtid
            
            #add-point:AFTER FIELD nmbscrtid name="construct.a.nmbscrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbscrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscrtdp
            #add-point:ON ACTION controlp INFIELD nmbscrtdp name="construct.c.nmbscrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbscrtdp  #顯示到畫面上
            NEXT FIELD nmbscrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscrtdp
            #add-point:BEFORE FIELD nmbscrtdp name="construct.b.nmbscrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscrtdp
            
            #add-point:AFTER FIELD nmbscrtdp name="construct.a.nmbscrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscrtdt
            #add-point:BEFORE FIELD nmbscrtdt name="construct.b.nmbscrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbsmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsmodid
            #add-point:ON ACTION controlp INFIELD nmbsmodid name="construct.c.nmbsmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsmodid  #顯示到畫面上
            NEXT FIELD nmbsmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsmodid
            #add-point:BEFORE FIELD nmbsmodid name="construct.b.nmbsmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsmodid
            
            #add-point:AFTER FIELD nmbsmodid name="construct.a.nmbsmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsmoddt
            #add-point:BEFORE FIELD nmbsmoddt name="construct.b.nmbsmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbscnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscnfid
            #add-point:ON ACTION controlp INFIELD nmbscnfid name="construct.c.nmbscnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbscnfid  #顯示到畫面上
            NEXT FIELD nmbscnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscnfid
            #add-point:BEFORE FIELD nmbscnfid name="construct.b.nmbscnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscnfid
            
            #add-point:AFTER FIELD nmbscnfid name="construct.a.nmbscnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscnfdt
            #add-point:BEFORE FIELD nmbscnfdt name="construct.b.nmbscnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON nmbtseq,nmbt017,nmbt017_desc,nmbt001,nmbt002,nmbt003,nmbadocdt_2,nmbb001, 
          nmbb002,nmbt011,nmbb028,nmbb028_desc,nmbb029,nmbt100,nmbt101,nmbt103,nmbt113,nmbt029,nmbt029_desc, 
          nmbt030,nmbt030_desc,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004,nmbt018, 
          nmbt018_desc,nmbt019,nmbt019_desc,nmbt020,nmbt020_desc,nmbt021,nmbt021_desc,nmbt022,nmbt022_desc, 
          nmbt023,nmbt023_desc,nmbt024,nmbt024_desc,nmbt025,nmbt025_desc,nmbt026,nmbt026_desc,nmbt027, 
          nmbt027_desc,nmbt028,nmbt028_desc,nmbt031,nmbt032,nmbt032_desc,nmbt033,nmbt033_desc,nmbt034, 
          nmbt034_desc,nmbt035,nmbt035_desc,nmbt036,nmbt036_desc,nmbt037,nmbt037_desc,nmbt038,nmbt038_desc, 
          nmbt039,nmbt039_desc,nmbt040,nmbt040_desc,nmbt041,nmbt041_desc,nmbt042,nmbt042_desc,nmbt043, 
          nmbt043_desc
           FROM s_detail1[1].nmbtseq,s_detail1[1].nmbt017,s_detail1[1].nmbt017_desc,s_detail1[1].nmbt001, 
               s_detail1[1].nmbt002,s_detail1[1].nmbt003,s_detail1[1].nmbadocdt_2,s_detail1[1].nmbb001, 
               s_detail1[1].nmbb002,s_detail1[1].nmbt011,s_detail1[1].nmbb028,s_detail1[1].nmbb028_desc, 
               s_detail1[1].nmbb029,s_detail1[1].nmbt100,s_detail1[1].nmbt101,s_detail1[1].nmbt103,s_detail1[1].nmbt113, 
               s_detail1[1].nmbt029,s_detail1[1].nmbt029_desc,s_detail1[1].nmbt030,s_detail1[1].nmbt030_desc, 
               s_detail1[1].nmbt012,s_detail1[1].nmbt013,s_detail1[1].nmbt014,s_detail1[1].nmbt121,s_detail1[1].nmbt123, 
               s_detail1[1].nmbt131,s_detail1[1].nmbt133,s_detail1[1].nmbt004,s_detail2[1].nmbt018,s_detail2[1].nmbt018_desc, 
               s_detail2[1].nmbt019,s_detail2[1].nmbt019_desc,s_detail2[1].nmbt020,s_detail2[1].nmbt020_desc, 
               s_detail2[1].nmbt021,s_detail2[1].nmbt021_desc,s_detail2[1].nmbt022,s_detail2[1].nmbt022_desc, 
               s_detail2[1].nmbt023,s_detail2[1].nmbt023_desc,s_detail2[1].nmbt024,s_detail2[1].nmbt024_desc, 
               s_detail2[1].nmbt025,s_detail2[1].nmbt025_desc,s_detail2[1].nmbt026,s_detail2[1].nmbt026_desc, 
               s_detail2[1].nmbt027,s_detail2[1].nmbt027_desc,s_detail2[1].nmbt028,s_detail2[1].nmbt028_desc, 
               s_detail2[1].nmbt031,s_detail2[1].nmbt032,s_detail2[1].nmbt032_desc,s_detail2[1].nmbt033, 
               s_detail2[1].nmbt033_desc,s_detail2[1].nmbt034,s_detail2[1].nmbt034_desc,s_detail2[1].nmbt035, 
               s_detail2[1].nmbt035_desc,s_detail2[1].nmbt036,s_detail2[1].nmbt036_desc,s_detail2[1].nmbt037, 
               s_detail2[1].nmbt037_desc,s_detail2[1].nmbt038,s_detail2[1].nmbt038_desc,s_detail2[1].nmbt039, 
               s_detail2[1].nmbt039_desc,s_detail2[1].nmbt040,s_detail2[1].nmbt040_desc,s_detail2[1].nmbt041, 
               s_detail2[1].nmbt041_desc,s_detail2[1].nmbt042,s_detail2[1].nmbt042_desc,s_detail2[1].nmbt043, 
               s_detail2[1].nmbt043_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbtseq
            #add-point:BEFORE FIELD nmbtseq name="construct.b.page1.nmbtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbtseq
            
            #add-point:AFTER FIELD nmbtseq name="construct.a.page1.nmbtseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbtseq
            #add-point:ON ACTION controlp INFIELD nmbtseq name="construct.c.page1.nmbtseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt017
            #add-point:BEFORE FIELD nmbt017 name="construct.b.page1.nmbt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt017
            
            #add-point:AFTER FIELD nmbt017 name="construct.a.page1.nmbt017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt017
            #add-point:ON ACTION controlp INFIELD nmbt017 name="construct.c.page1.nmbt017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbt017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt017_desc
            #add-point:ON ACTION controlp INFIELD nmbt017_desc name="construct.c.page1.nmbt017_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y'"  #160912-00024#1 add  #161021-00050#8 mark
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc         #160816-00012#3 add
            LET g_qryparam.where = " ooef201 = 'Y'" #150714-00024#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED  #160816-00012#3 add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmbt017_desc
            NEXT FIELD nmbt017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt017_desc
            #add-point:BEFORE FIELD nmbt017_desc name="construct.b.page1.nmbt017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt017_desc
            
            #add-point:AFTER FIELD nmbt017_desc name="construct.a.page1.nmbt017_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt001
            #add-point:BEFORE FIELD nmbt001 name="construct.b.page1.nmbt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt001
            
            #add-point:AFTER FIELD nmbt001 name="construct.a.page1.nmbt001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt001
            #add-point:ON ACTION controlp INFIELD nmbt001 name="construct.c.page1.nmbt001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbt002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt002
            #add-point:ON ACTION controlp INFIELD nmbt002 name="construct.c.page1.nmbt002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt002  #顯示到畫面上
            NEXT FIELD nmbt002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt002
            #add-point:BEFORE FIELD nmbt002 name="construct.b.page1.nmbt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt002
            
            #add-point:AFTER FIELD nmbt002 name="construct.a.page1.nmbt002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt003
            #add-point:BEFORE FIELD nmbt003 name="construct.b.page1.nmbt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt003
            
            #add-point:AFTER FIELD nmbt003 name="construct.a.page1.nmbt003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt003
            #add-point:ON ACTION controlp INFIELD nmbt003 name="construct.c.page1.nmbt003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocdt_2
            #add-point:BEFORE FIELD nmbadocdt_2 name="construct.b.page1.nmbadocdt_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocdt_2
            
            #add-point:AFTER FIELD nmbadocdt_2 name="construct.a.page1.nmbadocdt_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbadocdt_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocdt_2
            #add-point:ON ACTION controlp INFIELD nmbadocdt_2 name="construct.c.page1.nmbadocdt_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb001
            #add-point:BEFORE FIELD nmbb001 name="construct.b.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb001
            
            #add-point:AFTER FIELD nmbb001 name="construct.a.page1.nmbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb001
            #add-point:ON ACTION controlp INFIELD nmbb001 name="construct.c.page1.nmbb001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002
            #add-point:ON ACTION controlp INFIELD nmbb002 name="construct.c.page1.nmbb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb002  #顯示到畫面上
            NEXT FIELD nmbb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="construct.b.page1.nmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="construct.a.page1.nmbb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt011
            #add-point:BEFORE FIELD nmbt011 name="construct.b.page1.nmbt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt011
            
            #add-point:AFTER FIELD nmbt011 name="construct.a.page1.nmbt011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt011
            #add-point:ON ACTION controlp INFIELD nmbt011 name="construct.c.page1.nmbt011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028
            #add-point:ON ACTION controlp INFIELD nmbb028 name="construct.c.page1.nmbb028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb028  #顯示到畫面上
            NEXT FIELD nmbb028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028
            #add-point:BEFORE FIELD nmbb028 name="construct.b.page1.nmbb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028
            
            #add-point:AFTER FIELD nmbb028 name="construct.a.page1.nmbb028"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028_desc
            #add-point:BEFORE FIELD nmbb028_desc name="construct.b.page1.nmbb028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028_desc
            
            #add-point:AFTER FIELD nmbb028_desc name="construct.a.page1.nmbb028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028_desc
            #add-point:ON ACTION controlp INFIELD nmbb028_desc name="construct.c.page1.nmbb028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb029
            #add-point:BEFORE FIELD nmbb029 name="construct.b.page1.nmbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb029
            
            #add-point:AFTER FIELD nmbb029 name="construct.a.page1.nmbb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb029
            #add-point:ON ACTION controlp INFIELD nmbb029 name="construct.c.page1.nmbb029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbt100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt100
            #add-point:ON ACTION controlp INFIELD nmbt100 name="construct.c.page1.nmbt100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt100  #顯示到畫面上
            NEXT FIELD nmbt100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt100
            #add-point:BEFORE FIELD nmbt100 name="construct.b.page1.nmbt100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt100
            
            #add-point:AFTER FIELD nmbt100 name="construct.a.page1.nmbt100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt101
            #add-point:BEFORE FIELD nmbt101 name="construct.b.page1.nmbt101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt101
            
            #add-point:AFTER FIELD nmbt101 name="construct.a.page1.nmbt101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt101
            #add-point:ON ACTION controlp INFIELD nmbt101 name="construct.c.page1.nmbt101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt103
            #add-point:BEFORE FIELD nmbt103 name="construct.b.page1.nmbt103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt103
            
            #add-point:AFTER FIELD nmbt103 name="construct.a.page1.nmbt103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt103
            #add-point:ON ACTION controlp INFIELD nmbt103 name="construct.c.page1.nmbt103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt113
            #add-point:BEFORE FIELD nmbt113 name="construct.b.page1.nmbt113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt113
            
            #add-point:AFTER FIELD nmbt113 name="construct.a.page1.nmbt113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt113
            #add-point:ON ACTION controlp INFIELD nmbt113 name="construct.c.page1.nmbt113"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbt029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt029
            #add-point:ON ACTION controlp INFIELD nmbt029 name="construct.c.page1.nmbt029"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt029  #顯示到畫面上
            NEXT FIELD nmbt029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt029
            #add-point:BEFORE FIELD nmbt029 name="construct.b.page1.nmbt029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt029
            
            #add-point:AFTER FIELD nmbt029 name="construct.a.page1.nmbt029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt029_desc
            #add-point:BEFORE FIELD nmbt029_desc name="construct.b.page1.nmbt029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt029_desc
            
            #add-point:AFTER FIELD nmbt029_desc name="construct.a.page1.nmbt029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt029_desc
            #add-point:ON ACTION controlp INFIELD nmbt029_desc name="construct.c.page1.nmbt029_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbt030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt030
            #add-point:ON ACTION controlp INFIELD nmbt030 name="construct.c.page1.nmbt030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt030  #顯示到畫面上
            NEXT FIELD nmbt030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt030
            #add-point:BEFORE FIELD nmbt030 name="construct.b.page1.nmbt030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt030
            
            #add-point:AFTER FIELD nmbt030 name="construct.a.page1.nmbt030"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt030_desc
            #add-point:BEFORE FIELD nmbt030_desc name="construct.b.page1.nmbt030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt030_desc
            
            #add-point:AFTER FIELD nmbt030_desc name="construct.a.page1.nmbt030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt030_desc
            #add-point:ON ACTION controlp INFIELD nmbt030_desc name="construct.c.page1.nmbt030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt012
            #add-point:BEFORE FIELD nmbt012 name="construct.b.page1.nmbt012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt012
            
            #add-point:AFTER FIELD nmbt012 name="construct.a.page1.nmbt012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt012
            #add-point:ON ACTION controlp INFIELD nmbt012 name="construct.c.page1.nmbt012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt013
            #add-point:BEFORE FIELD nmbt013 name="construct.b.page1.nmbt013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt013
            
            #add-point:AFTER FIELD nmbt013 name="construct.a.page1.nmbt013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt013
            #add-point:ON ACTION controlp INFIELD nmbt013 name="construct.c.page1.nmbt013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt014
            #add-point:BEFORE FIELD nmbt014 name="construct.b.page1.nmbt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt014
            
            #add-point:AFTER FIELD nmbt014 name="construct.a.page1.nmbt014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt014
            #add-point:ON ACTION controlp INFIELD nmbt014 name="construct.c.page1.nmbt014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt121
            #add-point:BEFORE FIELD nmbt121 name="construct.b.page1.nmbt121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt121
            
            #add-point:AFTER FIELD nmbt121 name="construct.a.page1.nmbt121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt121
            #add-point:ON ACTION controlp INFIELD nmbt121 name="construct.c.page1.nmbt121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt123
            #add-point:BEFORE FIELD nmbt123 name="construct.b.page1.nmbt123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt123
            
            #add-point:AFTER FIELD nmbt123 name="construct.a.page1.nmbt123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt123
            #add-point:ON ACTION controlp INFIELD nmbt123 name="construct.c.page1.nmbt123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt131
            #add-point:BEFORE FIELD nmbt131 name="construct.b.page1.nmbt131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt131
            
            #add-point:AFTER FIELD nmbt131 name="construct.a.page1.nmbt131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt131
            #add-point:ON ACTION controlp INFIELD nmbt131 name="construct.c.page1.nmbt131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt133
            #add-point:BEFORE FIELD nmbt133 name="construct.b.page1.nmbt133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt133
            
            #add-point:AFTER FIELD nmbt133 name="construct.a.page1.nmbt133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt133
            #add-point:ON ACTION controlp INFIELD nmbt133 name="construct.c.page1.nmbt133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt004
            #add-point:BEFORE FIELD nmbt004 name="construct.b.page1.nmbt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt004
            
            #add-point:AFTER FIELD nmbt004 name="construct.a.page1.nmbt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt004
            #add-point:ON ACTION controlp INFIELD nmbt004 name="construct.c.page1.nmbt004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt018
            #add-point:BEFORE FIELD nmbt018 name="construct.b.page2.nmbt018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt018
            
            #add-point:AFTER FIELD nmbt018 name="construct.a.page2.nmbt018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt018
            #add-point:ON ACTION controlp INFIELD nmbt018 name="construct.c.page2.nmbt018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt018
            NEXT FIELD nmbt018
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt018_desc
            #add-point:ON ACTION controlp INFIELD nmbt018_desc name="construct.c.page2.nmbt018_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt018
            DISPLAY g_qryparam.return1 TO nmbt018_desc
            NEXT FIELD nmbt018_desc   
            #161221-00054#3 add e---            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt018_desc
            #add-point:BEFORE FIELD nmbt018_desc name="construct.b.page2.nmbt018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt018_desc
            
            #add-point:AFTER FIELD nmbt018_desc name="construct.a.page2.nmbt018_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt019
            #add-point:BEFORE FIELD nmbt019 name="construct.b.page2.nmbt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt019
            
            #add-point:AFTER FIELD nmbt019 name="construct.a.page2.nmbt019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt019
            #add-point:ON ACTION controlp INFIELD nmbt019 name="construct.c.page2.nmbt019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt019
            NEXT FIELD nmbt019
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt019_desc
            #add-point:ON ACTION controlp INFIELD nmbt019_desc name="construct.c.page2.nmbt019_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt019
            DISPLAY g_qryparam.return1 TO nmbt019_desc
            NEXT FIELD nmbt019_desc 
            #161221-00054#3 add e---            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt019_desc
            #add-point:BEFORE FIELD nmbt019_desc name="construct.b.page2.nmbt019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt019_desc
            
            #add-point:AFTER FIELD nmbt019_desc name="construct.a.page2.nmbt019_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt020
            #add-point:BEFORE FIELD nmbt020 name="construct.b.page2.nmbt020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt020
            
            #add-point:AFTER FIELD nmbt020 name="construct.a.page2.nmbt020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt020
            #add-point:ON ACTION controlp INFIELD nmbt020 name="construct.c.page2.nmbt020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt020
            NEXT FIELD nmbt020
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt020_desc
            #add-point:ON ACTION controlp INFIELD nmbt020_desc name="construct.c.page2.nmbt020_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt020
            DISPLAY g_qryparam.return1 TO nmbt020_desc
            NEXT FIELD nmbt020_desc            
            #161221-00054#3 add e---           
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt020_desc
            #add-point:BEFORE FIELD nmbt020_desc name="construct.b.page2.nmbt020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt020_desc
            
            #add-point:AFTER FIELD nmbt020_desc name="construct.a.page2.nmbt020_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt021
            #add-point:BEFORE FIELD nmbt021 name="construct.b.page2.nmbt021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt021
            
            #add-point:AFTER FIELD nmbt021 name="construct.a.page2.nmbt021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt021
            #add-point:ON ACTION controlp INFIELD nmbt021 name="construct.c.page2.nmbt021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      
            DISPLAY g_qryparam.return1 TO nmbt021
            NEXT FIELD nmbt021
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt021_desc
            #add-point:ON ACTION controlp INFIELD nmbt021_desc name="construct.c.page2.nmbt021_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      
            DISPLAY g_qryparam.return1 TO nmbt021
             DISPLAY g_qryparam.return1 TO nmbt021_desc
            NEXT FIELD nmbt021_desc            
            #161221-00054#3 add e---   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt021_desc
            #add-point:BEFORE FIELD nmbt021_desc name="construct.b.page2.nmbt021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt021_desc
            
            #add-point:AFTER FIELD nmbt021_desc name="construct.a.page2.nmbt021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt022
            #add-point:BEFORE FIELD nmbt022 name="construct.b.page2.nmbt022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt022
            
            #add-point:AFTER FIELD nmbt022 name="construct.a.page2.nmbt022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt022
            #add-point:ON ACTION controlp INFIELD nmbt022 name="construct.c.page2.nmbt022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      
            DISPLAY g_qryparam.return1 TO nmbt022
            NEXT FIELD nmbt022
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt022_desc
            #add-point:ON ACTION controlp INFIELD nmbt022_desc name="construct.c.page2.nmbt022_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      
            DISPLAY g_qryparam.return1 TO nmbt022
            DISPLAY g_qryparam.return1 TO nmbt022_desc
            NEXT FIELD nmbt022_desc            
            #161221-00054#3 add e---               
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt022_desc
            #add-point:BEFORE FIELD nmbt022_desc name="construct.b.page2.nmbt022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt022_desc
            
            #add-point:AFTER FIELD nmbt022_desc name="construct.a.page2.nmbt022_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt023
            #add-point:BEFORE FIELD nmbt023 name="construct.b.page2.nmbt023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt023
            
            #add-point:AFTER FIELD nmbt023 name="construct.a.page2.nmbt023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt023
            #add-point:ON ACTION controlp INFIELD nmbt023 name="construct.c.page2.nmbt023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt023
            NEXT FIELD nmbt023
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt023_desc
            #add-point:ON ACTION controlp INFIELD nmbt023_desc name="construct.c.page2.nmbt023_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt023
            DISPLAY g_qryparam.return1 TO nmbt023_desc
            NEXT FIELD nmbt023_desc            
            #161221-00054#3 add e---               
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt023_desc
            #add-point:BEFORE FIELD nmbt023_desc name="construct.b.page2.nmbt023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt023_desc
            
            #add-point:AFTER FIELD nmbt023_desc name="construct.a.page2.nmbt023_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt024
            #add-point:BEFORE FIELD nmbt024 name="construct.b.page2.nmbt024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt024
            
            #add-point:AFTER FIELD nmbt024 name="construct.a.page2.nmbt024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt024
            #add-point:ON ACTION controlp INFIELD nmbt024 name="construct.c.page2.nmbt024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt024
            NEXT FIELD nmbt024
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt024_desc
            #add-point:ON ACTION controlp INFIELD nmbt024_desc name="construct.c.page2.nmbt024_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt024
            DISPLAY g_qryparam.return1 TO nmbt024_desc
            NEXT FIELD nmbt024_desc            
            #161221-00054#3 add e---            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt024_desc
            #add-point:BEFORE FIELD nmbt024_desc name="construct.b.page2.nmbt024_desc"
  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt024_desc
            
            #add-point:AFTER FIELD nmbt024_desc name="construct.a.page2.nmbt024_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt025
            #add-point:BEFORE FIELD nmbt025 name="construct.b.page2.nmbt025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt025
            
            #add-point:AFTER FIELD nmbt025 name="construct.a.page2.nmbt025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt025
            #add-point:ON ACTION controlp INFIELD nmbt025 name="construct.c.page2.nmbt025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt025
            NEXT FIELD nmbt025
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt025_desc
            #add-point:ON ACTION controlp INFIELD nmbt025_desc name="construct.c.page2.nmbt025_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt025
            DISPLAY g_qryparam.return1 TO nmbt025_desc
            NEXT FIELD nmbt025_desc            
            #161221-00054#3 add e---               
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt025_desc
            #add-point:BEFORE FIELD nmbt025_desc name="construct.b.page2.nmbt025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt025_desc
            
            #add-point:AFTER FIELD nmbt025_desc name="construct.a.page2.nmbt025_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt026
            #add-point:BEFORE FIELD nmbt026 name="construct.b.page2.nmbt026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt026
            
            #add-point:AFTER FIELD nmbt026 name="construct.a.page2.nmbt026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt026
            #add-point:ON ACTION controlp INFIELD nmbt026 name="construct.c.page2.nmbt026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt026
            NEXT FIELD nmbt026
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt026_desc
            #add-point:ON ACTION controlp INFIELD nmbt026_desc name="construct.c.page2.nmbt026_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt026
            DISPLAY g_qryparam.return1 TO nmbt026_desc
            NEXT FIELD nmbt026_desc            
            #161221-00054#3 add e---               
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt026_desc
            #add-point:BEFORE FIELD nmbt026_desc name="construct.b.page2.nmbt026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt026_desc
            
            #add-point:AFTER FIELD nmbt026_desc name="construct.a.page2.nmbt026_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt027
            #add-point:BEFORE FIELD nmbt027 name="construct.b.page2.nmbt027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt027
            
            #add-point:AFTER FIELD nmbt027 name="construct.a.page2.nmbt027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt027
            #add-point:ON ACTION controlp INFIELD nmbt027 name="construct.c.page2.nmbt027"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt027
            NEXT FIELD nmbt027
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt027_desc
            #add-point:ON ACTION controlp INFIELD nmbt027_desc name="construct.c.page2.nmbt027_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt027
            DISPLAY g_qryparam.return1 TO nmbt027_desc
            NEXT FIELD nmbt027_desc            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt027_desc
            #add-point:BEFORE FIELD nmbt027_desc name="construct.b.page2.nmbt027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt027_desc
            
            #add-point:AFTER FIELD nmbt027_desc name="construct.a.page2.nmbt027_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt028
            #add-point:BEFORE FIELD nmbt028 name="construct.b.page2.nmbt028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt028
            
            #add-point:AFTER FIELD nmbt028 name="construct.a.page2.nmbt028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt028
            #add-point:ON ACTION controlp INFIELD nmbt028 name="construct.c.page2.nmbt028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt028
            NEXT FIELD nmbt028
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt028_desc
            #add-point:ON ACTION controlp INFIELD nmbt028_desc name="construct.c.page2.nmbt028_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt028
            DISPLAY g_qryparam.return1 TO nmbt028_desc
            NEXT FIELD nmbt028_desc            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt028_desc
            #add-point:BEFORE FIELD nmbt028_desc name="construct.b.page2.nmbt028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt028_desc
            
            #add-point:AFTER FIELD nmbt028_desc name="construct.a.page2.nmbt028_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt031
            #add-point:BEFORE FIELD nmbt031 name="construct.b.page2.nmbt031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt031
            
            #add-point:AFTER FIELD nmbt031 name="construct.a.page2.nmbt031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt031
            #add-point:ON ACTION controlp INFIELD nmbt031 name="construct.c.page2.nmbt031"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt032
            #add-point:ON ACTION controlp INFIELD nmbt032 name="construct.c.page2.nmbt032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1" 
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt032  #顯示到畫面上
            NEXT FIELD nmbt032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt032
            #add-point:BEFORE FIELD nmbt032 name="construct.b.page2.nmbt032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt032
            
            #add-point:AFTER FIELD nmbt032 name="construct.a.page2.nmbt032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt032_desc
            #add-point:ON ACTION controlp INFIELD nmbt032_desc name="construct.c.page2.nmbt032_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1" 
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt032
            DISPLAY g_qryparam.return1 TO nmbt032_desc  #顯示到畫面上
            NEXT FIELD nmbt032_desc                     #返回原欄位            
            #161221-00054#3 add e---   
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt032_desc
            #add-point:BEFORE FIELD nmbt032_desc name="construct.b.page2.nmbt032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt032_desc
            
            #add-point:AFTER FIELD nmbt032_desc name="construct.a.page2.nmbt032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt033
            #add-point:ON ACTION controlp INFIELD nmbt033 name="construct.c.page2.nmbt033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = "2002" #
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt033  #顯示到畫面上
            NEXT FIELD nmbt033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt033
            #add-point:BEFORE FIELD nmbt033 name="construct.b.page2.nmbt033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt033
            
            #add-point:AFTER FIELD nmbt033 name="construct.a.page2.nmbt033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt033_desc
            #add-point:ON ACTION controlp INFIELD nmbt033_desc name="construct.c.page2.nmbt033_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = "2002" #
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt033  #顯示到畫面上
            DISPLAY g_qryparam.return1 TO nmbt033_desc  #顯示到畫面上
            NEXT FIELD nmbt033_desc                     #返回原欄位            
            #161221-00054#3 add e---   
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt033_desc
            #add-point:BEFORE FIELD nmbt033_desc name="construct.b.page2.nmbt033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt033_desc
            
            #add-point:AFTER FIELD nmbt033_desc name="construct.a.page2.nmbt033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt034
            #add-point:ON ACTION controlp INFIELD nmbt034 name="construct.c.page2.nmbt034"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt034  #顯示到畫面上
            NEXT FIELD nmbt034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt034
            #add-point:BEFORE FIELD nmbt034 name="construct.b.page2.nmbt034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt034
            
            #add-point:AFTER FIELD nmbt034 name="construct.a.page2.nmbt034"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt034_desc
            #add-point:BEFORE FIELD nmbt034_desc name="construct.b.page2.nmbt034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt034_desc
            
            #add-point:AFTER FIELD nmbt034_desc name="construct.a.page2.nmbt034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt034_desc
            #add-point:ON ACTION controlp INFIELD nmbt034_desc name="construct.c.page2.nmbt034_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt035
            #add-point:ON ACTION controlp INFIELD nmbt035 name="construct.c.page2.nmbt035"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt035  #顯示到畫面上
            NEXT FIELD nmbt035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt035
            #add-point:BEFORE FIELD nmbt035 name="construct.b.page2.nmbt035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt035
            
            #add-point:AFTER FIELD nmbt035 name="construct.a.page2.nmbt035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt035_desc
            #add-point:BEFORE FIELD nmbt035_desc name="construct.b.page2.nmbt035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt035_desc
            
            #add-point:AFTER FIELD nmbt035_desc name="construct.a.page2.nmbt035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt035_desc
            #add-point:ON ACTION controlp INFIELD nmbt035_desc name="construct.c.page2.nmbt035_desc"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt036
            #add-point:ON ACTION controlp INFIELD nmbt036 name="construct.c.page2.nmbt036"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt036  #顯示到畫面上
            NEXT FIELD nmbt036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt036
            #add-point:BEFORE FIELD nmbt036 name="construct.b.page2.nmbt036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt036
            
            #add-point:AFTER FIELD nmbt036 name="construct.a.page2.nmbt036"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt036_desc
            #add-point:BEFORE FIELD nmbt036_desc name="construct.b.page2.nmbt036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt036_desc
            
            #add-point:AFTER FIELD nmbt036_desc name="construct.a.page2.nmbt036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt036_desc
            #add-point:ON ACTION controlp INFIELD nmbt036_desc name="construct.c.page2.nmbt036_desc"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt037
            #add-point:ON ACTION controlp INFIELD nmbt037 name="construct.c.page2.nmbt037"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt037  #顯示到畫面上
            NEXT FIELD nmbt037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt037
            #add-point:BEFORE FIELD nmbt037 name="construct.b.page2.nmbt037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt037
            
            #add-point:AFTER FIELD nmbt037 name="construct.a.page2.nmbt037"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt037_desc
            #add-point:BEFORE FIELD nmbt037_desc name="construct.b.page2.nmbt037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt037_desc
            
            #add-point:AFTER FIELD nmbt037_desc name="construct.a.page2.nmbt037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt037_desc
            #add-point:ON ACTION controlp INFIELD nmbt037_desc name="construct.c.page2.nmbt037_desc"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt038
            #add-point:ON ACTION controlp INFIELD nmbt038 name="construct.c.page2.nmbt038"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt038  #顯示到畫面上
            NEXT FIELD nmbt038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt038
            #add-point:BEFORE FIELD nmbt038 name="construct.b.page2.nmbt038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt038
            
            #add-point:AFTER FIELD nmbt038 name="construct.a.page2.nmbt038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt038_desc
            #add-point:BEFORE FIELD nmbt038_desc name="construct.b.page2.nmbt038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt038_desc
            
            #add-point:AFTER FIELD nmbt038_desc name="construct.a.page2.nmbt038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt038_desc
            #add-point:ON ACTION controlp INFIELD nmbt038_desc name="construct.c.page2.nmbt038_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt039
            #add-point:ON ACTION controlp INFIELD nmbt039 name="construct.c.page2.nmbt039"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt039  #顯示到畫面上
            NEXT FIELD nmbt039                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt039
            #add-point:BEFORE FIELD nmbt039 name="construct.b.page2.nmbt039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt039
            
            #add-point:AFTER FIELD nmbt039 name="construct.a.page2.nmbt039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt039_desc
            #add-point:BEFORE FIELD nmbt039_desc name="construct.b.page2.nmbt039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt039_desc
            
            #add-point:AFTER FIELD nmbt039_desc name="construct.a.page2.nmbt039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt039_desc
            #add-point:ON ACTION controlp INFIELD nmbt039_desc name="construct.c.page2.nmbt039_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt040
            #add-point:ON ACTION controlp INFIELD nmbt040 name="construct.c.page2.nmbt040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt040  #顯示到畫面上
            NEXT FIELD nmbt040                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt040
            #add-point:BEFORE FIELD nmbt040 name="construct.b.page2.nmbt040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt040
            
            #add-point:AFTER FIELD nmbt040 name="construct.a.page2.nmbt040"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt040_desc
            #add-point:BEFORE FIELD nmbt040_desc name="construct.b.page2.nmbt040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt040_desc
            
            #add-point:AFTER FIELD nmbt040_desc name="construct.a.page2.nmbt040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt040_desc
            #add-point:ON ACTION controlp INFIELD nmbt040_desc name="construct.c.page2.nmbt040_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt041
            #add-point:ON ACTION controlp INFIELD nmbt041 name="construct.c.page2.nmbt041"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt041  #顯示到畫面上
            NEXT FIELD nmbt041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt041
            #add-point:BEFORE FIELD nmbt041 name="construct.b.page2.nmbt041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt041
            
            #add-point:AFTER FIELD nmbt041 name="construct.a.page2.nmbt041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt041_desc
            #add-point:BEFORE FIELD nmbt041_desc name="construct.b.page2.nmbt041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt041_desc
            
            #add-point:AFTER FIELD nmbt041_desc name="construct.a.page2.nmbt041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt041_desc
            #add-point:ON ACTION controlp INFIELD nmbt041_desc name="construct.c.page2.nmbt041_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt042
            #add-point:ON ACTION controlp INFIELD nmbt042 name="construct.c.page2.nmbt042"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt042  #顯示到畫面上
            NEXT FIELD nmbt042                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt042
            #add-point:BEFORE FIELD nmbt042 name="construct.b.page2.nmbt042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt042
            
            #add-point:AFTER FIELD nmbt042 name="construct.a.page2.nmbt042"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt042_desc
            #add-point:BEFORE FIELD nmbt042_desc name="construct.b.page2.nmbt042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt042_desc
            
            #add-point:AFTER FIELD nmbt042_desc name="construct.a.page2.nmbt042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt042_desc
            #add-point:ON ACTION controlp INFIELD nmbt042_desc name="construct.c.page2.nmbt042_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmbt043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt043
            #add-point:ON ACTION controlp INFIELD nmbt043 name="construct.c.page2.nmbt043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbt043  #顯示到畫面上
            NEXT FIELD nmbt043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt043
            #add-point:BEFORE FIELD nmbt043 name="construct.b.page2.nmbt043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt043
            
            #add-point:AFTER FIELD nmbt043 name="construct.a.page2.nmbt043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt043_desc
            #add-point:BEFORE FIELD nmbt043_desc name="construct.b.page2.nmbt043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt043_desc
            
            #add-point:AFTER FIELD nmbt043_desc name="construct.a.page2.nmbt043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmbt043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt043_desc
            #add-point:ON ACTION controlp INFIELD nmbt043_desc name="construct.c.page2.nmbt043_desc"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "nmbs_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbt_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#12-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#12-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt311_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_nmbt_d.clear()
   CALL g_nmbt2_d.clear()
   CALL g_nmbt3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt311_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt311_browser_fill("")
      CALL anmt311_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL anmt311_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt311_fetch("F") 
      #顯示單身筆數
      CALL anmt311_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt311_fetch(p_flag)
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_nmbs_m.nmbsld = g_browser[g_current_idx].b_nmbsld
   LET g_nmbs_m.nmbsdocno = g_browser[g_current_idx].b_nmbsdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
   #遮罩相關處理
   LET g_nmbs_m_mask_o.* =  g_nmbs_m.*
   CALL anmt311_nmbs_t_mask()
   LET g_nmbs_m_mask_n.* =  g_nmbs_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt311_set_act_visible()   
   CALL anmt311_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbs_m_t.* = g_nmbs_m.*
   LET g_nmbs_m_o.* = g_nmbs_m.*
   
   LET g_data_owner = g_nmbs_m.nmbsownid      
   LET g_data_dept  = g_nmbs_m.nmbsowndp
   
   #重新顯示   
   CALL anmt311_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt311_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmbt_d.clear()   
   CALL g_nmbt2_d.clear()  
   CALL g_nmbt3_d.clear()  
 
 
   INITIALIZE g_nmbs_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmbsld_t = NULL
   LET g_nmbsdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbs_m.nmbsownid = g_user
      LET g_nmbs_m.nmbsowndp = g_dept
      LET g_nmbs_m.nmbscrtid = g_user
      LET g_nmbs_m.nmbscrtdp = g_dept 
      LET g_nmbs_m.nmbscrtdt = cl_get_current()
      LET g_nmbs_m.nmbsmodid = g_user
      LET g_nmbs_m.nmbsmoddt = cl_get_current()
      LET g_nmbs_m.nmbsstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_nmbs_m.nmbs001 = "anmt311"
      LET g_nmbs_m.nmbsstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_nmbs_m.nmbssite,g_errno
      CALL anmt311_nmbssite_desc()
      
      #160509-00004#60--add--str--lujh
      SELECT ooef017 INTO g_nmbs_m.nmbscomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmbs_m.nmbssite
      #160509-00004#60--add--end--lujh
      
      SELECT glaald,glaacomp INTO g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp
        FROM glaa_t
       WHERE glaaent = g_enterprise #2015/04/01 by 02599 add
         AND glaacomp = g_nmbs_m.nmbscomp       #160509-00004#60 change nmbssite to nmbscomp lujh    
         AND glaa014 = 'Y'
      LET g_nmbs_m.nmbsdocdt = g_today
      CALL anmt311_show_ref()
      
      #CALL s_anm_get_site_wc('6',g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocdt) RETURNING g_site_wc      #160816-00012#3  add
      CALL s_anm_get_site_wc('6',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt) RETURNING g_site_wc       #160912-00024#1
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmbs_m_t.* = g_nmbs_m.*
      LET g_nmbs_m_o.* = g_nmbs_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbs_m.nmbsstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL anmt311_input("a")
      
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
         INITIALIZE g_nmbs_m.* TO NULL
         INITIALIZE g_nmbt_d TO NULL
         INITIALIZE g_nmbt2_d TO NULL
         INITIALIZE g_nmbt3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt311_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmbt_d.clear()
      #CALL g_nmbt2_d.clear()
      #CALL g_nmbt3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt311_set_act_visible()   
   CALL anmt311_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbsld_t = g_nmbs_m.nmbsld
   LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbsent = " ||g_enterprise|| " AND",
                      " nmbsld = '", g_nmbs_m.nmbsld, "' "
                      ," AND nmbsdocno = '", g_nmbs_m.nmbsdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt311_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt311_cl
   
   CALL anmt311_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
   
   #遮罩相關處理
   LET g_nmbs_m_mask_o.* =  g_nmbs_m.*
   CALL anmt311_nmbs_t_mask()
   LET g_nmbs_m_mask_n.* =  g_nmbs_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbscomp_desc, 
       g_nmbs_m.nmbscomp,g_nmbs_m.glaa001,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003, 
       g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp, 
       g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdp_desc, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid, 
       g_nmbs_m.nmbscnfid_desc,g_nmbs_m.nmbscnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmbs_m.nmbsownid      
   LET g_data_dept  = g_nmbs_m.nmbsowndp
   
   #功能已完成,通報訊息中心
   CALL anmt311_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt311_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   #150813-00015#4--add--str--
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_slip      LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat
   #150813-00015#4--add--end  
#150813-00015#4--mark--str--
#   IF g_nmbs_m.nmbsstus = 'Y' THEN 
#      RETURN
#   END IF
#150813-00015#4--mark--end
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbs_m_t.* = g_nmbs_m.*
   LET g_nmbs_m_o.* = g_nmbs_m.*
   
   IF g_nmbs_m.nmbsld IS NULL
   OR g_nmbs_m.nmbsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmbsld_t = g_nmbs_m.nmbsld
   LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
   CALL s_transaction_begin()
   
   OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt311_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
   #檢查是否允許此動作
   IF NOT anmt311_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbs_m_mask_o.* =  g_nmbs_m.*
   CALL anmt311_nmbs_t_mask()
   LET g_nmbs_m_mask_n.* =  g_nmbs_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL anmt311_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150813-00015#4--add--str--
   IF g_nmbs_m.nmbsstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   #获取单别
   CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_slip
   #是否可改日期
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
   IF l_dfin0033 = 'N' THEN
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_nmbs_m.nmbscomp,'ANM',g_nmbs_m.nmbsdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE anmt311_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #150813-00015#4--add--end
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_nmbsld_t = g_nmbs_m.nmbsld
      LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmbs_m.nmbsmodid = g_user 
LET g_nmbs_m.nmbsmoddt = cl_get_current()
LET g_nmbs_m.nmbsmodid_desc = cl_get_username(g_nmbs_m.nmbsmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt311_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmbs_t SET (nmbsmodid,nmbsmoddt) = (g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt)
          WHERE nmbsent = g_enterprise AND nmbsld = g_nmbsld_t
            AND nmbsdocno = g_nmbsdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmbs_m.* = g_nmbs_m_t.*
            CALL anmt311_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmbs_m.nmbsld != g_nmbs_m_t.nmbsld
      OR g_nmbs_m.nmbsdocno != g_nmbs_m_t.nmbsdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmbt_t SET nmbtld = g_nmbs_m.nmbsld
                                       ,nmbtdocno = g_nmbs_m.nmbsdocno
 
          WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m_t.nmbsld
            AND nmbtdocno = g_nmbs_m_t.nmbsdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbt_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'nmbbent'
LET l_new_key[02] = g_nmbs_m.nmbsld
LET l_old_key[02] = g_nmbsld_t
LET l_field_key[02] = 'nmbbcomp'
LET l_new_key[03] = g_nmbs_m.nmbsdocno
LET l_old_key[03] = g_nmbsdocno_t
LET l_field_key[03] = 'nmbbdocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'nmbb_t')
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt311_set_act_visible()   
   CALL anmt311_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbsent = " ||g_enterprise|| " AND",
                      " nmbsld = '", g_nmbs_m.nmbsld, "' "
                      ," AND nmbsdocno = '", g_nmbs_m.nmbsdocno, "' "
 
   #填到對應位置
   CALL anmt311_browser_fill("")
 
   CLOSE anmt311_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt311_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt311.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt311_input(p_cmd)
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
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_success              LIKE type_t.num5
   DEFINE tok                    base.stringtokenizer
   DEFINE l_nmbt002              STRING
   DEFINE l_flag                 LIKE type_t.chr1
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_origin_str           STRING   #組織範圍
   DEFINE l_glaa004              LIKE glaa_t.glaa004
   DEFINE l_success1             LIKE type_t.num5
   DEFINE l_cnt1                 LIKE type_t.num5 
   DEFINE i                      LIKE type_t.num5 
   DEFINE l_glaa024              LIKE glaa_t.glaa024   #单据别参照表号     2014/12/29 liuym add
   DEFINE l_glaa003              LIKE glaa_t.glaa003   #会计周期参照表号   2014/12/29 liuym add
   DEFINE l_dfin0030             LIKE ooac_t.ooac004   #140829-00070#30 15/01/13 Add
   DEFINE l_ooba002              LIKE ooba_t.ooba002   #140829-00070#30 15/01/13 Add
   DEFINE l_glaa121              LIKE glaa_t.glaa121   #140829-00070#30 15/01/13 Add
   #151201-00003#2--add--str--
   DEFINE l_nmbbdocno            LIKE nmbb_t.nmbbdocno
   DEFINE l_nmbbseq              LIKE nmbb_t.nmbbseq
   DEFINE l_nmbt103              LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113              LIKE nmbt_t.nmbt113
   DEFINE l_nmbt123              LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133              LIKE nmbt_t.nmbt133
   DEFINE l_nmbt103_c            LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113_c            LIKE nmbt_t.nmbt113
   DEFINE l_nmbt123_c            LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133_c            LIKE nmbt_t.nmbt133
   DEFINE l_nmbb006              LIKE nmbb_t.nmbb006
   DEFINE l_nmbb007              LIKE nmbb_t.nmbb007
   DEFINE l_nmbb013              LIKE nmbb_t.nmbb013
   DEFINE l_nmbb017              LIKE nmbb_t.nmbb017
   DEFINE l_sql                  STRING
   DEFINE l_nmbt004  LIKE nmbt_t.nmbt004 #151224-00022#1 add
   DEFINE l_flag1          LIKE type_t.num5    #161104-00046#12 單別預設值用
   DEFINE l_slip           LIKE ooba_t.ooba002 #161104-00046#12
   #161221-00054#3 add s---
   DEFINE l_wc                   STRING
   DEFINE l_glak_sql             STRING
   #161221-00054#3 add e---      
   #151201-00003#2--add--end
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
   DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbscomp_desc, 
       g_nmbs_m.nmbscomp,g_nmbs_m.glaa001,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003, 
       g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp, 
       g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdp_desc, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid, 
       g_nmbs_m.nmbscnfid_desc,g_nmbs_m.nmbscnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmbtseq,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100,nmbt101,nmbt103, 
       nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004,nmbtseq, 
       nmbt001,nmbt002,nmbt003,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026, 
       nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040, 
       nmbt041,nmbt042,nmbt043,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt100,nmbt103,nmbt121,nmbt123,nmbt131, 
       nmbt133 FROM nmbt_t WHERE nmbtent=? AND nmbtld=? AND nmbtdocno=? AND nmbtseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt311_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt311_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt311_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp_desc,g_nmbs_m.nmbscomp,g_nmbs_m.glaa001, 
       g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   WHILE TRUE
      LET l_flag = 'N'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt311.input.head" >}
      #單頭段
      INPUT BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp_desc,g_nmbs_m.nmbscomp,g_nmbs_m.glaa001, 
          g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt311_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt311_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt311_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            SELECT glaa003,glaa024 INTO l_glaa003,l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmbs_m.nmbsld #2014/12/29 liuym add 
            #CALL cl_showmsg_init()
            #CALL cl_err_collect_init()
            #end add-point
            CALL anmt311_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbssite
            
            #add-point:AFTER FIELD nmbssite name="input.a.nmbssite"
            IF NOT cl_null(g_nmbs_m.nmbssite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmbs_m.nmbssite != g_nmbs_m_t.nmbssite OR g_nmbs_m_t.nmbssite IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmbs_m.nmbssite != g_nmbs_m_o.nmbssite OR cl_null(g_nmbs_m_o.nmbssite) THEN                                       #160822-00012#5   add
                  CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')   #160816-00012#3 Add
                  CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbs_m.nmbssite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmbs_m.nmbssite = g_nmbs_m_t.nmbssite   #160822-00012#5   mark
                     LET g_nmbs_m.nmbssite = g_nmbs_m_o.nmbssite   #160822-00012#5   add
                     CALL anmt311_nmbssite_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL anmt311_nmbssite_desc()
            LET g_nmbs_m_o.* = g_nmbs_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbssite
            #add-point:BEFORE FIELD nmbssite name="input.b.nmbssite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbssite
            #add-point:ON CHANGE nmbssite name="input.g.nmbssite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="input.a.nmbsld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmbs_m.nmbscomp) AND NOT cl_null(g_nmbs_m.nmbsld) AND NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t  OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbs_t WHERE "||"nmbsent = '" ||g_enterprise|| "' AND "||"nmbscomp = '"||g_nmbs_m.nmbscomp ||"' AND "|| "nmbsld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbsdocno = '"||g_nmbs_m.nmbsdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            
            IF NOT cl_null(g_nmbs_m.nmbsld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbs_m_t.nmbsld OR g_nmbs_m_t.nmbsld IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmbs_m.nmbsld != g_nmbs_m_o.nmbsld OR cl_null(g_nmbs_m_o.nmbsld) THEN                                       #160822-00012#5   add
                  #CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno  #160816-00012#3 mark
                  #CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','Y','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno   #160816-00012#3 add #160929-00040#1 mark
                  #CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno #160929-00040#1 add   #161028-00051#1   mark
                  CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','Y',g_wc_cs_ld,g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno                #161028-00051#1   add
                  IF NOT cl_null(g_errno) THEN                  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbs_m.nmbsld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_nmbs_m.nmbsld = g_nmbs_m_t.nmbsld   #160822-00012#5   mark
                     LET g_nmbs_m.nmbsld = g_nmbs_m_o.nmbsld    #160822-00012#5   add
                     LET g_nmbs_m.nmbscomp = ''                 #160822-00012#5   add
                     SELECT glaacomp INTO g_nmbs_m.nmbscomp
                     FROM glaa_t WHERE glaald = g_nmbs_m.nmbsld AND glaaent = g_enterprise
                     CALL anmt311_show_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_nmbs_m.nmbscomp = ''   #160822-00012#5   add
            SELECT glaacomp INTO g_nmbs_m.nmbscomp
              FROM glaa_t
              WHERE glaald = g_nmbs_m.nmbsld AND glaaent = g_enterprise
            CALL anmt311_show_ref()
            LET g_nmbs_m_o.* = g_nmbs_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsld
            #add-point:BEFORE FIELD nmbsld name="input.b.nmbsld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsld
            #add-point:ON CHANGE nmbsld name="input.g.nmbsld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscomp_desc
            #add-point:BEFORE FIELD nmbscomp_desc name="input.b.nmbscomp_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscomp_desc
            
            #add-point:AFTER FIELD nmbscomp_desc name="input.a.nmbscomp_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbscomp_desc
            #add-point:ON CHANGE nmbscomp_desc name="input.g.nmbscomp_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscomp
            
            #add-point:AFTER FIELD nmbscomp name="input.a.nmbscomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbscomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbscomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbscomp_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmbs_m.nmbscomp) AND NOT cl_null(g_nmbs_m.nmbsld) AND NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t  OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbs_t WHERE "||"nmbsent = '" ||g_enterprise|| "' AND "||"nmbscomp = '"||g_nmbs_m.nmbscomp ||"' AND "|| "nmbsld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbsdocno = '"||g_nmbs_m.nmbsdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscomp
            #add-point:BEFORE FIELD nmbscomp name="input.b.nmbscomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbscomp
            #add-point:ON CHANGE nmbscomp name="input.g.nmbscomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="input.a.nmbsdocno"

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmbs_m.nmbscomp) AND NOT cl_null(g_nmbs_m.nmbsld) AND NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t  OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbs_t WHERE "||"nmbsent = '" ||g_enterprise|| "' AND "||"nmbscomp = '"||g_nmbs_m.nmbscomp ||"' AND "|| "nmbsld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbsdocno = '"||g_nmbs_m.nmbsdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET l_glaa024 = ''
            CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024   
            IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               #CALL s_aooi200_chk_slip(g_nmbs_m.nmbscomp,l_glaa024,g_nmbs_m.nmbsdocno,'anmt311') RETURNING l_success       #2014/12/29 liuym mark               
               CALL s_aooi200_fin_chk_slip(g_nmbs_m.nmbsld,l_glaa024,g_nmbs_m.nmbsdocno,'anmt311') RETURNING l_success      #2014/12/29 liuym add  
               IF l_success = FALSE THEN 
                  LET g_nmbs_m.nmbsdocno = g_nmbs_m_t.nmbsdocno
                  NEXT FIELD nmbsdocno
               END IF
               #161104-00046#12-----s
               CALL s_control_chk_doc('1',g_nmbs_m.nmbsdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
               IF g_sub_success AND l_flag1 THEN             
               ELSE
                  LET g_nmbs_m.nmbsdocno = g_nmbs_m_o.nmbsdocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_nmbs_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_nmbs_m.nmbscomp,'2',l_slip,'','',g_nmbs_m.nmbsld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_nmbs_m.* FROM s_aooi200def1
               #161104-00046#12-----e  
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocno
            #add-point:BEFORE FIELD nmbsdocno name="input.b.nmbsdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsdocno
            #add-point:ON CHANGE nmbsdocno name="input.g.nmbsdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocdt
            #add-point:BEFORE FIELD nmbsdocdt name="input.b.nmbsdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocdt
            
            #add-point:AFTER FIELD nmbsdocdt name="input.a.nmbsdocdt"
            #150813-00015#4--add--str--
            IF NOT cl_null(g_nmbs_m.nmbsdocdt) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsdocdt != g_nmbs_m_t.nmbsdocdt OR cl_null(g_nmbs_m_t.nmbsdocdt))) THEN 
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_nmbs_m.nmbscomp,'ANM',g_nmbs_m.nmbsdocdt) RETURNING l_success
                  IF l_success=FALSE THEN
                     LET g_nmbs_m.nmbsdocdt = g_nmbs_m_t.nmbsdocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #150813-00015#4--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsdocdt
            #add-point:ON CHANGE nmbsdocdt name="input.g.nmbsdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs001
            #add-point:BEFORE FIELD nmbs001 name="input.b.nmbs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs001
            
            #add-point:AFTER FIELD nmbs001 name="input.a.nmbs001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbs001
            #add-point:ON CHANGE nmbs001 name="input.g.nmbs001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs003
            #add-point:BEFORE FIELD nmbs003 name="input.b.nmbs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs003
            
            #add-point:AFTER FIELD nmbs003 name="input.a.nmbs003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbs003
            #add-point:ON CHANGE nmbs003 name="input.g.nmbs003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbs004
            #add-point:BEFORE FIELD nmbs004 name="input.b.nmbs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbs004
            
            #add-point:AFTER FIELD nmbs004 name="input.a.nmbs004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbs004
            #add-point:ON CHANGE nmbs004 name="input.g.nmbs004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsstus
            #add-point:BEFORE FIELD nmbsstus name="input.b.nmbsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsstus
            
            #add-point:AFTER FIELD nmbsstus name="input.a.nmbsstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsstus
            #add-point:ON CHANGE nmbsstus name="input.g.nmbsstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbssite
            #add-point:ON ACTION controlp INFIELD nmbssite name="input.c.nmbssite"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbs_m.nmbssite
            #LET g_qryparam.where = " ooef201 = 'Y'" #150714-00024#1 #160816-00012#3  mark 
            LET g_qryparam.where = " ooefstus = 'Y'" #161021-00050#8
            #CALL q_ooef001()   #161021-00050#8 mark
            CALL q_ooef001_46() #161021-00050#8
            LET g_nmbs_m.nmbssite = g_qryparam.return1
            DISPLAY g_nmbs_m.nmbssite TO nmbssite
            CALL anmt311_nmbssite_desc()
            NEXT FIELD nmbssite
            #END add-point
 
 
         #Ctrlp:input.c.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="input.c.nmbsld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbsld             #給予default值
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL anmt311_change_to_sql(l_origin_str) RETURNING l_origin_str  
            
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )" #160929-00040#1 mark
            #LET g_qryparam.where = " glaacomp IN (",l_origin_str," )"  #160929-00040#1 add                #161028-00051#1 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )" #161028-00051#1 add
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_nmbs_m.nmbsld = g_qryparam.return1              

            DISPLAY g_nmbs_m.nmbsld TO nmbsld              #
            CALL anmt311_show_ref()
            NEXT FIELD nmbsld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbscomp_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp_desc
            #add-point:ON ACTION controlp INFIELD nmbscomp_desc name="input.c.nmbscomp_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbscomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp
            #add-point:ON ACTION controlp INFIELD nmbscomp name="input.c.nmbscomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="input.c.nmbsdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbsdocno             #給予default值
            LET l_glaa024 = ''
            CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024   
            LET g_qryparam.where = " ooba001 = '",l_glaa024,"' AND oobx003 = 'anmt311'"
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161104-00046#12-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#12-----e
            CALL q_ooba002()                                #呼叫開窗

            LET g_nmbs_m.nmbsdocno = g_qryparam.return1              

            DISPLAY g_nmbs_m.nmbsdocno TO nmbsdocno              #

            NEXT FIELD nmbsdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocdt
            #add-point:ON ACTION controlp INFIELD nmbsdocdt name="input.c.nmbsdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs001
            #add-point:ON ACTION controlp INFIELD nmbs001 name="input.c.nmbs001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbs003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs003
            #add-point:ON ACTION controlp INFIELD nmbs003 name="input.c.nmbs003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbs003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooba002_4()                                #呼叫開窗

            LET g_nmbs_m.nmbs003 = g_qryparam.return1              

            DISPLAY g_nmbs_m.nmbs003 TO nmbs003              #

            NEXT FIELD nmbs003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbs004
            #add-point:ON ACTION controlp INFIELD nmbs004 name="input.c.nmbs004"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsstus
            #add-point:ON ACTION controlp INFIELD nmbsstus name="input.c.nmbsstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/29 liuym mark-----str----- 
               #CALL s_aooi200_gen_docno(g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_prog)
               #RETURNING l_success,g_nmbs_m.nmbsdocno
               #2014/12/29 liuym add-----str-----
               CALL s_aooi200_fin_gen_docno(g_nmbs_m.nmbsld,l_glaa024,l_glaa003,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_prog)
                        RETURNING l_success,g_nmbs_m.nmbsdocno
               #2014/12/29 liuym add-----end-----                  
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_nmbs_m.nmbsdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD nmbsdocno
               END IF 
               #end add-point
               
               INSERT INTO nmbs_t (nmbsent,nmbssite,nmbsld,nmbscomp,nmbsdocno,nmbsdocdt,nmbs001,nmbs003, 
                   nmbs004,nmbsstus,nmbsownid,nmbsowndp,nmbscrtid,nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt, 
                   nmbscnfid,nmbscnfdt)
               VALUES (g_enterprise,g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno, 
                   g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus, 
                   g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdt, 
                   g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmbs_m:",SQLERRMESSAGE 
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
                  CALL anmt311_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt311_b_fill()
                  CALL anmt311_b_fill2('0')
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
               CALL anmt311_nmbs_t_mask_restore('restore_mask_o')
               
               UPDATE nmbs_t SET (nmbssite,nmbsld,nmbscomp,nmbsdocno,nmbsdocdt,nmbs001,nmbs003,nmbs004, 
                   nmbsstus,nmbsownid,nmbsowndp,nmbscrtid,nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid, 
                   nmbscnfdt) = (g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno, 
                   g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus, 
                   g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdt, 
                   g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt)
                WHERE nmbsent = g_enterprise AND nmbsld = g_nmbsld_t
                  AND nmbsdocno = g_nmbsdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt311_nmbs_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmbs_m_t)
               LET g_log2 = util.JSON.stringify(g_nmbs_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmbsld_t = g_nmbs_m.nmbsld
            LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt311.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmbt_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbt_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt311_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmbt_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            LET l_glaa004 = ''
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmbs_m.nmbsld 
            IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN
               CALL cl_set_comp_visible("s_detail3",FALSE)
            ELSE
               CALL cl_set_comp_visible("s_detail3",TRUE)   
            END IF
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            LET g_ins_cnt = 0   #150616-00026#12
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
            OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt311_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt311_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbt_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbt_d[l_ac].nmbtseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmbt_d_t.* = g_nmbt_d[l_ac].*  #BACKUP
               LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*  #BACKUP
               CALL anmt311_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt311_set_no_entry_b(l_cmd)
               IF NOT anmt311_lock_b("nmbt_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt311_bcl INTO g_nmbt_d[l_ac].nmbtseq,g_nmbt_d[l_ac].nmbt017,g_nmbt_d[l_ac].nmbt001, 
                      g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003,g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt100, 
                      g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103,g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt029, 
                      g_nmbt_d[l_ac].nmbt030,g_nmbt_d[l_ac].nmbt012,g_nmbt_d[l_ac].nmbt013,g_nmbt_d[l_ac].nmbt014, 
                      g_nmbt_d[l_ac].nmbt121,g_nmbt_d[l_ac].nmbt123,g_nmbt_d[l_ac].nmbt131,g_nmbt_d[l_ac].nmbt133, 
                      g_nmbt_d[l_ac].nmbt004,g_nmbt2_d[l_ac].nmbtseq,g_nmbt2_d[l_ac].nmbt001,g_nmbt2_d[l_ac].nmbt002, 
                      g_nmbt2_d[l_ac].nmbt003,g_nmbt2_d[l_ac].nmbt018,g_nmbt2_d[l_ac].nmbt019,g_nmbt2_d[l_ac].nmbt020, 
                      g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt022,g_nmbt2_d[l_ac].nmbt023,g_nmbt2_d[l_ac].nmbt024, 
                      g_nmbt2_d[l_ac].nmbt025,g_nmbt2_d[l_ac].nmbt026,g_nmbt2_d[l_ac].nmbt027,g_nmbt2_d[l_ac].nmbt028, 
                      g_nmbt2_d[l_ac].nmbt031,g_nmbt2_d[l_ac].nmbt032,g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt034, 
                      g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036,g_nmbt2_d[l_ac].nmbt037,g_nmbt2_d[l_ac].nmbt038, 
                      g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040,g_nmbt2_d[l_ac].nmbt041,g_nmbt2_d[l_ac].nmbt042, 
                      g_nmbt2_d[l_ac].nmbt043,g_nmbt3_d[l_ac].nmbtseq,g_nmbt3_d[l_ac].nmbt001,g_nmbt3_d[l_ac].nmbt002, 
                      g_nmbt3_d[l_ac].nmbt003,g_nmbt3_d[l_ac].nmbt100,g_nmbt3_d[l_ac].nmbt103,g_nmbt3_d[l_ac].nmbt121, 
                      g_nmbt3_d[l_ac].nmbt123,g_nmbt3_d[l_ac].nmbt131,g_nmbt3_d[l_ac].nmbt133
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbt_d_t.nmbtseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbt_d_mask_o[l_ac].* =  g_nmbt_d[l_ac].*
                  CALL anmt311_nmbt_t_mask()
                  LET g_nmbt_d_mask_n[l_ac].* =  g_nmbt_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt311_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET l_nmbt004 = g_nmbt_d[l_ac].nmbt004 #151224-00022#1 add
            CALL anmt311_nmbt002_get()
            #151224-00022#1--add--str--
            IF NOT cl_null(l_nmbt004) THEN
               LET g_nmbt_d[l_ac].nmbt004 = l_nmbt004
               LET g_nmbt_d[l_ac].nmbb001 = l_nmbt004  
            END IF
            #151224-00022#1--add--end
            
            #161221-00054#3 add s---
            LET l_wc = g_nmbt_d[l_ac].nmbt029,",",g_nmbt_d[l_ac].nmbt030
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---                       
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
 
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'nmbbent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'nmbbcomp'
            LET l_var_keys[02] = g_nmbs_m.nmbsld
            LET l_field_keys[03] = 'nmbbdocno'
            LET l_var_keys[03] = g_nmbs_m.nmbsdocno
            LET l_field_keys[04] = 'nmbbseq'
            LET l_var_keys[04] = g_nmbt_d[l_ac].nmbtseq
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'nmbb_t') THEN
               RETURN 
            END IF 
 
 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbt_d[l_ac].* TO NULL 
            INITIALIZE g_nmbt_d_t.* TO NULL 
            INITIALIZE g_nmbt_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_nmbt_d[l_ac].nmbt017 = g_nmbs_m.nmbscomp   #默認歸屬法人
            LET g_nmbt_d[l_ac].nmbt001 = '3'                 #默認銀存收支單
            LET g_nmbt_d[l_ac].nmbt013 = g_user #151224-00022#1 add
            CALL anmt311_nmbt017_desc()         #151224-00022#1 add 
            LET g_nmbt_d[l_ac].nmbt017 = g_nmbs_m.nmbssite  #160912-00024#1 add
            CALL s_anm_orga_chk(g_nmbt_d[l_ac].nmbt017,g_nmbs_m.nmbscomp) RETURNING g_nmbt_d[l_ac].nmbt017  #160912-00024#1 add
            #end add-point
            LET g_nmbt_d_t.* = g_nmbt_d[l_ac].*     #新輸入資料
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt311_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt311_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbt_d[li_reproduce_target].* = g_nmbt_d[li_reproduce].*
               LET g_nmbt2_d[li_reproduce_target].* = g_nmbt2_d[li_reproduce].*
               LET g_nmbt3_d[li_reproduce_target].* = g_nmbt3_d[li_reproduce].*
 
               LET g_nmbt_d[li_reproduce_target].nmbtseq = NULL
 
            END IF
            
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
 
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_nmbt_d[g_detail_idx].nmbtseq) THEN 
                  SELECT MAX(nmbtseq) INTO g_nmbt_d[g_detail_idx].nmbtseq
                    FROM nmbt_t
                   WHERE nmbtent = g_enterprise
                     AND nmbtld = g_nmbs_m.nmbsld
                     AND nmbtdocno = g_nmbs_m.nmbsdocno
                     
                  IF cl_null(g_nmbt_d[g_detail_idx].nmbtseq) THEN 
                     LET g_nmbt_d[g_detail_idx].nmbtseq = 1
                  ELSE
                     LET g_nmbt_d[g_detail_idx].nmbtseq = g_nmbt_d[g_detail_idx].nmbtseq + 1
                  END IF
               END IF
            END IF
#            LET g_nmbt_d[l_ac].nmbt013 = g_user  #151224-00022#1 mark
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
            #20150521--add--str--lujh
            IF g_ins_cnt > 0 THEN   #150616-00026#12
               #新增操作不再走系统产生的逻辑,故不再走这边的新增逻辑
               CANCEL INSERT   
            END IF   #150616-00026#12
            #20150521--add--end--lujh
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM nmbt_t 
             WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m.nmbsld
               AND nmbtdocno = g_nmbs_m.nmbsdocno
 
               AND nmbtseq = g_nmbt_d[l_ac].nmbtseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_m.nmbsld
               LET gs_keys[2] = g_nmbs_m.nmbsdocno
               LET gs_keys[3] = g_nmbt_d[g_detail_idx].nmbtseq
               CALL anmt311_insert_b('nmbt_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
             #  CALL anmt311_nmbv_ins(g_nmbs_m.nmbsdocno,g_nmbt_d[l_ac].nmbtseq,g_nmbt_d[l_ac].nmbt001,g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbb001,g_nmbt_d[l_ac].nmbt003,g_nmbt_d[l_ac].nmbt103,g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt123,g_nmbt_d[l_ac].nmbt133)
               IF g_success = 'N' THEN
                  CALL s_transaction_end('N',0)
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmbt_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt311_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_nmbs_m.nmbsld = g_detail_multi_table_t.nmbbcomp AND
         g_nmbs_m.nmbsdocno = g_detail_multi_table_t.nmbbdocno AND
         g_nmbt_d[l_ac].nmbtseq = g_detail_multi_table_t.nmbbseq AND
         g_nmbt_d[l_ac].nmbb001 = g_detail_multi_table_t.nmbb001 AND
         g_nmbt_d[l_ac].nmbb002 = g_detail_multi_table_t.nmbb002 AND
         g_nmbt_d[l_ac].nmbb028 = g_detail_multi_table_t.nmbb028 AND
         g_nmbt_d[l_ac].nmbb029 = g_detail_multi_table_t.nmbb029 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'nmbbent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_nmbs_m.nmbsld
            LET l_field_keys[02] = 'nmbbcomp'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.nmbbcomp
            LET l_var_keys[03] = g_nmbs_m.nmbsdocno
            LET l_field_keys[03] = 'nmbbdocno'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.nmbbdocno
            LET l_var_keys[04] = g_nmbt_d[l_ac].nmbtseq
            LET l_field_keys[04] = 'nmbbseq'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.nmbbseq
            LET l_vars[01] = g_nmbt_d[l_ac].nmbb001
            LET l_fields[01] = 'nmbb001'
            LET l_vars[02] = g_nmbt_d[l_ac].nmbb002
            LET l_fields[02] = 'nmbb002'
            LET l_vars[03] = g_nmbt_d[l_ac].nmbb028
            LET l_fields[03] = 'nmbb028'
            LET l_vars[04] = g_nmbt_d[l_ac].nmbb029
            LET l_fields[04] = 'nmbb029'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'nmbb_t')
         END IF 
 
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
               IF 1 = 2 THEN 
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_nmbs_m.nmbsld
               LET gs_keys[gs_keys.getLength()+1] = g_nmbs_m.nmbsdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmbt_d_t.nmbtseq
 
            
               #刪除同層單身
               IF NOT anmt311_delete_b('nmbt_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt311_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt311_key_delete_b(gs_keys,'nmbt_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt311_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'nmbbent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'nmbbcomp'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.nmbbcomp
                  LET l_field_keys[03] = 'nmbbdocno'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.nmbbdocno
                  LET l_field_keys[04] = 'nmbbseq'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.nmbbseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'nmbb_t')
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               ELSE
                  #151201-00003#2--add--str--
                  #当单据来源是3.银存收支单时，只可以一笔一笔删除
                  IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
                     #151224-00022#1--add--str--
                     #當業務單號或項次為空時，一筆一筆刪除單身資料
                     #當業務單號和項次都不為空時，刪除單身中所有業務單號+項次的單身資料
                     IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
                        DELETE FROM nmbv_t 
                         WHERE nmbvent = g_enterprise 
                           AND nmbvld = g_nmbs_m.nmbsld 
                           AND nmbvdocno = g_nmbs_m.nmbsdocno
                           AND nmbvseq IN (SELECT nmbtseq FROM nmbt_t 
                                            WHERE nmbtent = g_enterprise 
                                              AND nmbtld = g_nmbs_m.nmbsld 
                                              AND nmbtdocno = g_nmbs_m.nmbsdocno 
                                              AND nmbt002 = g_nmbt_d[l_ac].nmbt002
                                              AND nmbt003 = g_nmbt_d[l_ac].nmbt003)
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbv_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF
                        
                        DELETE FROM nmbt_t
                         WHERE nmbtent = g_enterprise 
                           AND nmbtld = g_nmbs_m.nmbsld 
                           AND nmbtdocno = g_nmbs_m.nmbsdocno 
                           AND nmbt002 = g_nmbt_d[l_ac].nmbt002
                           AND nmbt003 = g_nmbt_d[l_ac].nmbt003
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbt_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF
                     ELSE
                     #151224-00022#1--add--end
                        DELETE FROM nmbv_t 
                         WHERE nmbvent = g_enterprise 
                           AND nmbvld = g_nmbs_m.nmbsld 
                           AND nmbvdocno = g_nmbs_m.nmbsdocno
                           AND nmbvseq =g_nmbt_d[l_ac].nmbtseq
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbv_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF
                        
                        DELETE FROM nmbt_t
                         WHERE nmbtent = g_enterprise 
                           AND nmbtld = g_nmbs_m.nmbsld 
                           AND nmbtdocno = g_nmbs_m.nmbsdocno 
                           AND nmbtseq = g_nmbt_d[l_ac].nmbtseq
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbt_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF
                     END IF #151224-00022#1 add
                  ELSE
                  #151201-00003#2--add--end               
                     IF cl_ask_confirm('anm-00260') THEN
                        DELETE FROM nmbv_t 
                         WHERE nmbvent = g_enterprise 
                           AND nmbvld = g_nmbs_m.nmbsld 
                           AND nmbvdocno = g_nmbs_m.nmbsdocno
                           AND nmbvseq IN (SELECT nmbtseq FROM nmbt_t 
                                            WHERE nmbtent = g_enterprise 
                                              AND nmbtld = g_nmbs_m.nmbsld 
                                              AND nmbtdocno = g_nmbs_m.nmbsdocno 
                                              AND nmbt002 = g_nmbt_d[l_ac].nmbt002)
                        #2015/05/18--by--02599--add--str-- 
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbv_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF
                        #2015/05/18--by--02599--add--end
                        DELETE FROM nmbt_t
                         WHERE nmbtent = g_enterprise 
                           AND nmbtld = g_nmbs_m.nmbsld 
                           AND nmbtdocno = g_nmbs_m.nmbsdocno 
                           AND nmbt002 = g_nmbt_d[l_ac].nmbt002
                        #2015/05/18--by--02599--add--str--  
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'del nmbt_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CANCEL DELETE
                        END IF                     
                        CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
                        CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
                        SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
                           AND glaald = g_nmbs_m.nmbsld
                        IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
                           CALL s_pre_voucher_del('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING l_success
                           IF l_success = FALSE THEN
                              CALL s_transaction_end('N','0')
                              CANCEL DELETE
                           END IF
                        END IF
                        #2015/05/18--by--02599--add--end
                     ELSE
#                        RETURN        #151201-00003#2 mark
                        CANCEL DELETE  #151201-00003#2 add
                     END IF
                  END IF  #151201-00003#2 add
               END IF
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt311_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               #151201-00003#2--add--str--
               #当单据来源是3.银存收支单时，只可以一笔一笔删除時，不需要在查詢
               IF g_nmbt_d[l_ac].nmbt001 <> '3' THEN
                  CALL anmt311_b_fill()
                  LET l_flag = 'Y'   #151224-00022#1 add
                  EXIT DIALOG        #151224-00022#1 add
               END IF
               #151201-00003#2--add--end
               
               #151224-00022#1--add--str--
               #當業務單號和項次都不為空時，刪除單身中所有業務單號+項次的單身資料,需重新查詢單身資料
               IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
                  IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
                     CALL anmt311_b_fill()
                     LET l_flag = 'Y'
                     EXIT DIALOG
                  END IF
               END IF
               #151224-00022#1--add--end
               #end add-point
               LET l_count = g_nmbt_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbt_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbtseq
            #add-point:BEFORE FIELD nmbtseq name="input.b.page1.nmbtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbtseq
            
            #add-point:AFTER FIELD nmbtseq name="input.a.page1.nmbtseq"
            #此段落由子樣板a05產生
            IF  g_nmbs_m.nmbscomp IS NOT NULL AND g_nmbs_m.nmbsld IS NOT NULL AND g_nmbs_m.nmbsdocno IS NOT NULL AND g_nmbt_d[g_detail_idx].nmbtseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t OR g_nmbt_d[g_detail_idx].nmbtseq != g_nmbt_d_t.nmbtseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbt_t WHERE "||"nmbtent = '" ||g_enterprise|| "' AND "||"nmbtld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbtdocno = '"||g_nmbs_m.nmbsdocno ||"' AND "|| "nmbtseq = '"||g_nmbt_d[g_detail_idx].nmbtseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbtseq
            #add-point:ON CHANGE nmbtseq name="input.g.page1.nmbtseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt017
            #add-point:BEFORE FIELD nmbt017 name="input.b.page1.nmbt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt017
            
            #add-point:AFTER FIELD nmbt017 name="input.a.page1.nmbt017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt017
            #add-point:ON CHANGE nmbt017 name="input.g.page1.nmbt017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt017_desc
            #add-point:BEFORE FIELD nmbt017_desc name="input.b.page1.nmbt017_desc"
            LET g_nmbt_d[l_ac].nmbt017_desc = g_nmbt_d[l_ac].nmbt017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt017_desc
            
            #add-point:AFTER FIELD nmbt017_desc name="input.a.page1.nmbt017_desc"
            IF cl_null(g_nmbt_d[l_ac].nmbt017_desc) THEN
               LET g_nmbt_d[l_ac].nmbt017_desc = g_nmbs_m.nmbscomp
            END IF
            LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d[l_ac].nmbt017_desc
            CALL anmt311_nmbt017_desc()
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt017 != g_nmbt_d_t.nmbt017 OR g_nmbt_d_t.nmbt017 IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt017 != g_nmbt_d_o.nmbt017 OR cl_null(g_nmbt_d_o.nmbt017) THEN                                       #160822-00012#5   add
#160816-00012#3 mod s---
#                  CALL s_fin_apcborga_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbscomp,g_nmbt_d[l_ac].nmbt017,g_nmbs_m.nmbsdocdt,'3')
#                     RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = ""
#                     LET g_errparam.code   = g_errno
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()
#                     LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_t.nmbt017
#                     LET g_nmbt_d[l_ac].nmbt017_desc = g_nmbt_d_t.nmbt017_desc
#                     CALL anmt311_nmbt017_desc()
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_anm_ooef001_chk(g_nmbt_d[l_ac].nmbt017) RETURNING g_sub_success,g_errno     
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_t.nmbt017   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_o.nmbt017    #160822-00012#5   add
                     CALL anmt311_nmbt017_desc()
                     NEXT FIELD CURRENT
                  END IF

                  #160912-00024#1 add s---
                  CALL s_anm_get_site_wc('6',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmbs_m.nmbssite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_t.nmbt017   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_o.nmbt017    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF                  
                  #160912-00024#1 add e---

                  #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜訪權限)
                  IF s_chr_get_index_of(g_site_wc,g_nmbt_d[l_ac].nmbt017,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'axc-00099'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_t.nmbt017   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_o.nmbt017    #160822-00012#5   add
                     CALL anmt311_nmbt017_desc()
                     NEXT FIELD CURRENT
                  #160912-00024#1 add s---   
                  ELSE
                     IF NOT ap_chk_isExist(g_nmbt_d[l_ac].nmbt017,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef017 = '"||g_nmbs_m.nmbscomp||"'",'anm-03022',1) THEN 
                        #LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_t.nmbt017   #160822-00012#5   mark
                        LET g_nmbt_d[l_ac].nmbt017 = g_nmbt_d_o.nmbt017    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF 
                  #160912-00024#1 add e---                       
                  END IF                  
#160816-00012#3 mod e---                  
               END IF
            END IF
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*    #160822-00012#5   add            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt017_desc
            #add-point:ON CHANGE nmbt017_desc name="input.g.page1.nmbt017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt001
            #add-point:BEFORE FIELD nmbt001 name="input.b.page1.nmbt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt001
            
            #add-point:AFTER FIELD nmbt001 name="input.a.page1.nmbt001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt001
            #add-point:ON CHANGE nmbt001 name="input.g.page1.nmbt001"
            #151201-00003#2--add--str--
            IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
               CALL cl_set_comp_required('nmbt002,nmbt003',FALSE)
               IF cl_null(g_nmbt_d[l_ac].nmbt002) THEN
                  CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,nmbt103,nmbt113',TRUE)
               ELSE
                  CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101',FALSE)
                  #151224-00022#1--mod--str--
#                  IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN 
                  IF (g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4') AND
                     (cl_null(g_nmbt_d[l_ac].nmbt002) OR cl_null(g_nmbt_d[l_ac].nmbt003))
                     THEN 
                  #151224-00022#1--mod--end
                     CALL cl_set_comp_entry('nmbt103,nmbt113',TRUE)
                  ELSE
                     CALL cl_set_comp_entry('nmbt103,nmbt113',FALSE)
                  END IF
               END IF
            ELSE
               CALL cl_set_comp_required('nmbt002,nmbt003',TRUE)
               CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,nmbt103,nmbt113',FALSE)
            END IF
            #151201-00003#2--add--end
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt002
            
            #add-point:AFTER FIELD nmbt002 name="input.a.page1.nmbt002"
            IF g_nmbt_d[l_ac].nmbt001 = '3' THEN 
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) THEN 
                  #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt002 <> g_nmbt_d_t.nmbt002 OR cl_null(g_nmbt_d_t.nmbt002))) THEN #151201-00003#2 add   #160822-00012#5   mark
                  IF g_nmbt_d[l_ac].nmbt002 != g_nmbt_d_o.nmbt002 OR cl_null(g_nmbt_d_o.nmbt002) THEN                                                         #160822-00012#5   add
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_nmbt_d[l_ac].nmbt002
                     LET g_chkparam.arg2 = g_nmbs_m.nmbscomp
                     #160318-00025#1--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "anm-00189:sub-01310|anmt310|",cl_get_progname("anmt310",g_lang,"2"),"|:EXEPROGanmt310"
                     LET g_chkparam.err_str[2] = "anm-00189:sub-01312|anmt310|",cl_get_progname("anmt310",g_lang,"2"),"|:EXEPROGanmt310"
                     #160318-00025#1--add--end
#                    IF cl_chk_exist("v_nmbadocno_1") THEN   #2015/6/25 by 02599 mark
                     IF cl_chk_exist("v_nmbadocno_3") THEN   #2015/6/25 by 02599 add 增加了adet402
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                        
                        #業務單號不可重複錄入
                        CALL anmt311_nmbt002_chk(l_cmd)
                        IF NOT cl_null(g_errno) THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002
                           #160318-00005#27 by 07900 --add--str
                           CASE g_errno
                             WHEN 'sub-01310'
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                             WHEN 'sub-01312'  
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                            END CASE      
                           #160318-00005#27 by 07900 --add--end
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_t.nmbt002   #160822-00012#5   mark
                           LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_o.nmbt002    #160822-00012#5   add
                           NEXT FIELD CURRENT
                        END IF
                        
                        CALL anmt311_nmbt002_get()
                        
                        #抓取其他欄位的預設值
                        CALL anmt311_nmbt002_default() 
                     
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_t.nmbt002   #160822-00012#5   mark
                        LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_o.nmbt002    #160822-00012#5   add
                        CALL anmt311_nmbt002_get()
                        NEXT FIELD CURRENT
                     END IF
               #151201-00003#2--add--str--
                  ELSE
                     IF l_cmd = 'u' AND (NOT cl_null(g_nmbt_d_o.nmbt002) AND g_nmbt_d_o.nmbt002 = g_nmbt_d[l_ac].nmbt002 
                                         AND g_nmbt_d_o.nmbt003 = g_nmbt_d[l_ac].nmbt003 ) THEN
                        LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d_o.nmbt103
                        LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d_o.nmbt113
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d_o.nmbt123
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d_o.nmbt133
                        LET g_nmbt_d[l_ac].nmbt029 = g_nmbt_d_o.nmbt029
                        LET g_nmbt_d[l_ac].nmbb001 = g_nmbt_d_o.nmbb001
                        LET g_nmbt_d[l_ac].nmbb028 = g_nmbt_d_o.nmbb028
                        LET g_nmbt_d[l_ac].nmbb028_desc = g_nmbt_d_o.nmbb028_desc
                        LET g_nmbt_d[l_ac].nmbt004 = g_nmbt_d_o.nmbt004
                     END IF
                  END IF
                  CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,',FALSE)
                  #151224-00022#1--mod--str--
#                  IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN 
                  IF (g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4') AND
                     (cl_null(g_nmbt_d[l_ac].nmbt002) OR cl_null(g_nmbt_d[l_ac].nmbt003))
                     THEN 
                  #151224-00022#1--mod--end
                     CALL cl_set_comp_entry('nmbt103,nmbt113',TRUE)
                  ELSE
                     CALL cl_set_comp_entry('nmbt103,nmbt113',FALSE)
                  END IF
               ELSE
                  CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,nmbt103,nmbt113',TRUE)
                  LET g_nmbt_d[l_ac].nmbb028 = ''
                  LET g_nmbt_d[l_ac].nmbb028_desc = ''
               #151201-00003#2--add--end
               END IF
            END IF
            
            IF g_nmbt_d[l_ac].nmbt001 = '4' THEN 
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_nmbt_d[l_ac].nmbt002
                  LET g_chkparam.arg2 = g_nmbs_m.nmbscomp
                  #160318-00025#1--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "anm-00191:sub-01310|anmt540|",cl_get_progname("anmt540",g_lang,"2"),"|:EXEPROGanmt540"
                  LET g_chkparam.err_str[2] = "anm-00192:sub-01312|anmt540|",cl_get_progname("anmt540",g_lang,"2"),"|:EXEPROGanmt540"
                  #160318-00025#1--add--end
                  IF cl_chk_exist("v_nmbadocno_2") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     #業務單號不可重複錄入
                     CALL anmt311_nmbt002_chk(l_cmd)
                     IF NOT cl_null(g_errno) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002
                        #160318-00005#27 by 07900 --add--str
                           CASE g_errno
                             WHEN 'sub-01310'
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                             WHEN 'sub-01312'  
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                            END CASE 
                        #160318-00005#27 by 07900 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_t.nmbt002   #160822-00012#5   mark
                        LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_o.nmbt002    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                     
                     CALL anmt311_nmbt002_get()
                     
                     #抓取其他欄位的預設值
                     CALL anmt311_nmbt002_default()

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_t.nmbt002   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_o.nmbt002    #160822-00012#5   add
                     CALL anmt311_nmbt002_get()
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               
            END IF
            
            #2015/04/30--by--02599--add--str--
            #7.待結算卡回款
            #8.營業款存款
            IF g_nmbt_d[l_ac].nmbt001 = '7'  OR g_nmbt_d[l_ac].nmbt001 = '8' OR g_nmbt_d[l_ac].nmbt001 = '9' OR g_nmbt_d[l_ac].nmbt001 = '10' OR g_nmbt_d[l_ac].nmbt001 = '12' THEN  #20150521 add g_nmbt_d[l_ac].nmbt001 = '9' lujh    #150417-00007#56 Add  OR g_nmbt_d[l_ac].nmbt001 = '10' 
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) THEN 
                  CALL anmt311_nmbt002_chk(l_cmd)
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002
                     #160318-00005#27 by 07900 --add--str
                       CASE g_errno
                             WHEN 'sub-01310'
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                             WHEN 'sub-01312'  
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                            END CASE 
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_t.nmbt002   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt002 = g_nmbt_d_o.nmbt002    #160822-00012#5   add
                     CALL anmt311_nmbt002_get()
                     NEXT FIELD CURRENT
                  END IF
                  CALL anmt311_nmbt002_get()
                  #抓取其他欄位的預設值
                  IF l_cmd = 'a' THEN
                     IF g_nmbt_d[l_ac].nmbt001 = '7' THEN
                        CALL anmt311_nmbt_get_7(g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003)
                     END IF
                     IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
                        CALL anmt311_nmbt_get_8(g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003)
                     END IF
                     #20150521--add--str--lujh
                     IF g_nmbt_d[l_ac].nmbt001 = '9' THEN
                        CALL anmt311_nmbt_get_9(g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003)
                     END IF
                     #20150521--add--end--lujh
                  END IF
               END IF 
            END IF
            #2015/04/30--by--02599--add--end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt002
            #add-point:BEFORE FIELD nmbt002 name="input.b.page1.nmbt002"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt002
            #add-point:ON CHANGE nmbt002 name="input.g.page1.nmbt002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt003
            #add-point:BEFORE FIELD nmbt003 name="input.b.page1.nmbt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt003
            
            #add-point:AFTER FIELD nmbt003 name="input.a.page1.nmbt003"
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN 
               #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt003 <> g_nmbt_d_t.nmbt003 OR cl_null(g_nmbt_d_t.nmbt003))) THEN #151201-00003#2 add   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt003 != g_nmbt_d_o.nmbt003 OR cl_null(g_nmbt_d_o.nmbt003) THEN   #160822-00012#5   add
                  #業務單號不可重複錄入
                  CALL anmt311_nmbt002_chk(l_cmd)
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbt_d[l_ac].nmbt003
                     #160318-00005#27 by 07900 --add--str
                     CASE g_errno
                             WHEN 'sub-01310'
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                             WHEN 'sub-01312'  
                                  LET g_errparam.replace[1] = 'anmt561'
                                  LET g_errparam.replace[2] = cl_get_progname("anmt561",g_lang,"2")
                                  LET g_errparam.exeprog ='anmt561'
                     END CASE 
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_nmbt_d[l_ac].nmbt003 = g_nmbt_d_t.nmbt003   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt003 = g_nmbt_d_o.nmbt003    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL anmt311_nmbt002_get()
                  
                  #抓取其他欄位的預設值
                  IF g_nmbt_d[l_ac].nmbt001 = '3' OR g_nmbt_d[l_ac].nmbt001 = '4' THEN #2015/04/30 by 02599 add
                     CALL anmt311_nmbt002_default()
                  END IF #2015/04/30 by 02599 add
               
               #151201-00003#2--add--str--
               ELSE
                  IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
                     IF l_cmd = 'u' AND (NOT cl_null(g_nmbt_d_o.nmbt002) AND g_nmbt_d_o.nmbt002 = g_nmbt_d[l_ac].nmbt002 
                                         AND g_nmbt_d_o.nmbt003 = g_nmbt_d[l_ac].nmbt003 ) THEN
                        LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d_o.nmbt103
                        LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d_o.nmbt113
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d_o.nmbt123
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d_o.nmbt133
                        LET g_nmbt_d[l_ac].nmbt029 = g_nmbt_d_o.nmbt029
                        LET g_nmbt_d[l_ac].nmbb001 = g_nmbt_d_o.nmbb001
                        LET g_nmbt_d[l_ac].nmbb028 = g_nmbt_d_o.nmbb028
                        LET g_nmbt_d[l_ac].nmbb028_desc = g_nmbt_d_o.nmbb028_desc
                        LET g_nmbt_d[l_ac].nmbt004 = g_nmbt_d_o.nmbt004
                     END IF
                  END IF
               END IF
               IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
                  #151224-00022#1--mod--str--
#                  IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN 
                  IF (g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4') AND
                     (cl_null(g_nmbt_d[l_ac].nmbt002) OR cl_null(g_nmbt_d[l_ac].nmbt003))
                     THEN 
                  #151224-00022#1--mod--end
                     CALL cl_set_comp_entry('nmbt103,nmbt113',TRUE)
                  ELSE
                     CALL cl_set_comp_entry('nmbt103,nmbt113',FALSE)
                  END IF
               END IF
               #151201-00003#2--add--end
            END IF
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt003
            #add-point:ON CHANGE nmbt003 name="input.g.page1.nmbt003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocdt_2
            #add-point:BEFORE FIELD nmbadocdt_2 name="input.b.page1.nmbadocdt_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocdt_2
            
            #add-point:AFTER FIELD nmbadocdt_2 name="input.a.page1.nmbadocdt_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocdt_2
            #add-point:ON CHANGE nmbadocdt_2 name="input.g.page1.nmbadocdt_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb001
            #add-point:BEFORE FIELD nmbb001 name="input.b.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb001
            
            #add-point:AFTER FIELD nmbb001 name="input.a.page1.nmbb001"
            LET g_nmbt_d[l_ac].nmbt004=g_nmbt_d[l_ac].nmbb001 #151201-00003#2 add
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb001
            #add-point:ON CHANGE nmbb001 name="input.g.page1.nmbb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="input.a.page1.nmbb002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbt_d[l_ac].nmbb002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbt_d[l_ac].nmbb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbt_d[l_ac].nmbb002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="input.b.page1.nmbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb002
            #add-point:ON CHANGE nmbb002 name="input.g.page1.nmbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt011
            #add-point:BEFORE FIELD nmbt011 name="input.b.page1.nmbt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt011
            
            #add-point:AFTER FIELD nmbt011 name="input.a.page1.nmbt011"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt011
            #add-point:ON CHANGE nmbt011 name="input.g.page1.nmbt011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028
            
            #add-point:AFTER FIELD nmbb028 name="input.a.page1.nmbb028"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028
            #add-point:BEFORE FIELD nmbb028 name="input.b.page1.nmbb028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb028
            #add-point:ON CHANGE nmbb028 name="input.g.page1.nmbb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028_desc
            #add-point:BEFORE FIELD nmbb028_desc name="input.b.page1.nmbb028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028_desc
            
            #add-point:AFTER FIELD nmbb028_desc name="input.a.page1.nmbb028_desc"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb028_desc
            #add-point:ON CHANGE nmbb028_desc name="input.g.page1.nmbb028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb029
            #add-point:BEFORE FIELD nmbb029 name="input.b.page1.nmbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb029
            
            #add-point:AFTER FIELD nmbb029 name="input.a.page1.nmbb029"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb029
            #add-point:ON CHANGE nmbb029 name="input.g.page1.nmbb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt100
            #add-point:BEFORE FIELD nmbt100 name="input.b.page1.nmbt100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt100
            
            #add-point:AFTER FIELD nmbt100 name="input.a.page1.nmbt100"
            #151201-00003#2--add--str--
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt100) THEN
               #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt100 <> g_nmbt_d_t.nmbt100 OR cl_null(g_nmbt_d_t.nmbt100))) THEN #151224-00022#1 add   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt100 != g_nmbt_d_o.nmbt100 OR cl_null(g_nmbt_d_o.nmbt100) THEN   #160822-00012#5   add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_nmbt_d[l_ac].nmbt100
                  #160318-00025#1--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#1--add--end
                  IF NOT cl_chk_exist("v_ooai001") THEN
                     #LET g_nmbt_d[l_ac].nmbt100 = g_nmbt_d_t.nmbt100   #160822-00012#5   mark
                     LET g_nmbt_d[l_ac].nmbt100 = g_nmbt_d_o.nmbt100    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
                  #本幣匯率
                  CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_nmbt_d[l_ac].nmbt100,g_glaa001,g_glaa025)
                  RETURNING g_nmbt_d[l_ac].nmbt101 
                  LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt101
                  CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa001,g_nmbt_d[l_ac].nmbt113,2)
                  RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt113 
                  IF g_glaa015 = 'Y' THEN
                     #主帳套本位幣二匯率
                     IF g_glaa017 = '1' THEN 
                                                #日期;             來源幣別                目的幣別; 匯類類型
                        CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_nmbt_d[l_ac].nmbt100,g_glaa016,g_glaa018)
                        RETURNING g_nmbt_d[l_ac].nmbt121
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt121
                     ELSE
                                                #日期;             來源幣別   目的幣別; 匯類類型
                        CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_glaa001,g_glaa016,g_glaa018)
                        RETURNING g_nmbt_d[l_ac].nmbt121   
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123 
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     #主帳套本位幣三匯率
                     IF g_glaa021 = '1' THEN 
                                                #日期;             來源幣別                目的幣別; 匯類類型
                        CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_nmbt_d[l_ac].nmbt100,g_glaa020,g_glaa022)
                             RETURNING g_nmbt_d[l_ac].nmbt131   
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt131
                     ELSE
                                                #日期;             來源幣別   目的幣別; 匯類類型
                        CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_glaa001,g_glaa020,g_glaa022)
                             RETURNING g_nmbt_d[l_ac].nmbt131   
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133 
                  END IF
               END IF #151224-00022#1 add
            END IF
            #151201-00003#2--add--end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt100
            #add-point:ON CHANGE nmbt100 name="input.g.page1.nmbt100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt101
            #add-point:BEFORE FIELD nmbt101 name="input.b.page1.nmbt101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt101
            
            #add-point:AFTER FIELD nmbt101 name="input.a.page1.nmbt101"
            #151201-00003#2--add--str--
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt101) THEN
               #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt101 <> g_nmbt_d_t.nmbt101 OR cl_null(g_nmbt_d_t.nmbt101))) THEN #151224-00022#1 add   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt101 != g_nmbt_d_o.nmbt101 OR cl_null(g_nmbt_d_o.nmbt101) THEN          #160822-00012#5   add
                  LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt101
                  CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa001,g_nmbt_d[l_ac].nmbt113,2)
                  RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt113
                  IF g_glaa015 = 'Y' THEN
                     #主帳套本位幣二匯率
                     IF g_glaa017 = '1' THEN 
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt121
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     #主帳套本位幣三匯率
                     IF g_glaa021 = '1' THEN                  
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt131
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133
                  END IF
               END IF #151224-00022#1 add
            END IF
            #151201-00003#2--add--end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt101
            #add-point:ON CHANGE nmbt101 name="input.g.page1.nmbt101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt103
            #add-point:BEFORE FIELD nmbt103 name="input.b.page1.nmbt103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt103
            
            #add-point:AFTER FIELD nmbt103 name="input.a.page1.nmbt103"
            #151201-00003#2--add--str--
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt103) THEN
               #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt103 <> g_nmbt_d_t.nmbt103 OR cl_null(g_nmbt_d_t.nmbt103))) THEN #151224-00022#1 add   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt103 != g_nmbt_d_o.nmbt103 OR cl_null(g_nmbt_d_o.nmbt103) THEN   #160822-00012#5   add
                  IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
                     IF NOT anmt311_amt_chk('nmbt103') THEN
                        #LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d_t.nmbt103   #160822-00012#5   mark
                        LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d_o.nmbt103    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt101
                  CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa001,g_nmbt_d[l_ac].nmbt113,2)
                  RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt113
                  
                  IF g_glaa015 = 'Y' THEN
                     #主帳套本位幣二匯率
                     IF g_glaa017 = '1' THEN 
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt121
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     #主帳套本位幣三匯率
                     IF g_glaa021 = '1' THEN                  
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt131
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133
                  END IF
                  IF NOT cl_null(g_nmbt_d_o.nmbt002) AND g_nmbt_d_o.nmbt002 = g_nmbt_d[l_ac].nmbt002 
                     AND g_nmbt_d_o.nmbt003 = g_nmbt_d[l_ac].nmbt003 THEN
                     LET g_nmbt_d_o.nmbt103 = g_nmbt_d[l_ac].nmbt103
                     LET g_nmbt_d_o.nmbt113 = g_nmbt_d[l_ac].nmbt113
                     LET g_nmbt_d_o.nmbt123 = g_nmbt_d[l_ac].nmbt123
                     LET g_nmbt_d_o.nmbt133 = g_nmbt_d[l_ac].nmbt133
                  END IF
               END IF #151224-00022#1 add
            END IF
            #151201-00003#2--add--end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt103
            #add-point:ON CHANGE nmbt103 name="input.g.page1.nmbt103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt113
            #add-point:BEFORE FIELD nmbt113 name="input.b.page1.nmbt113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt113
            
            #add-point:AFTER FIELD nmbt113 name="input.a.page1.nmbt113"
            #151201-00003#2--add--str--
            IF NOT cl_null(g_nmbt_d[l_ac].nmbt113) THEN
               #IF l_cmd='a' OR (l_cmd = 'u' AND (g_nmbt_d[l_ac].nmbt113 <> g_nmbt_d_t.nmbt113 OR cl_null(g_nmbt_d_t.nmbt113))) THEN #151224-00022#1 add   #160822-00012#5   mark
               IF g_nmbt_d[l_ac].nmbt113 != g_nmbt_d_o.nmbt113 OR cl_null(g_nmbt_d_o.nmbt113) THEN   #160822-00012#5   add
                  IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
                     IF NOT anmt311_amt_chk('nmbt113') THEN
                        #LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d_t.nmbt113   #160822-00012#5   mark
                        LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d_o.nmbt113    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d[l_ac].nmbt113 / g_nmbt_d[l_ac].nmbt101
                  CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt103,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt103
                  IF g_glaa015 = 'Y' THEN
                     #主帳套本位幣二匯率
                     IF g_glaa017 = '1' THEN 
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt121
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123
                  END IF
                  
                  IF g_glaa019 = 'Y' THEN
                     #主帳套本位幣三匯率
                     IF g_glaa021 = '1' THEN                  
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt131
                     ELSE
                        LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
                     END IF
                     CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
                     RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133
                  END IF
                  IF NOT cl_null(g_nmbt_d_o.nmbt002) AND g_nmbt_d_o.nmbt002 = g_nmbt_d[l_ac].nmbt002 
                     AND g_nmbt_d_o.nmbt003 = g_nmbt_d[l_ac].nmbt003 THEN
                     LET g_nmbt_d_o.nmbt103 = g_nmbt_d[l_ac].nmbt103
                     LET g_nmbt_d_o.nmbt113 = g_nmbt_d[l_ac].nmbt113
                     LET g_nmbt_d_o.nmbt123 = g_nmbt_d[l_ac].nmbt123
                     LET g_nmbt_d_o.nmbt133 = g_nmbt_d[l_ac].nmbt133
                  END IF
               END IF #151224-00022#1 add
            END IF
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt113
            #add-point:ON CHANGE nmbt113 name="input.g.page1.nmbt113"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt029
            
            #add-point:AFTER FIELD nmbt029 name="input.a.page1.nmbt029"
              IF NOT cl_null(g_nmbt_d[l_ac].nmbt029) THEN
              
              # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_nmbs_m.nmbsld,g_nmbt_d[l_ac].nmbt029,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_nmbs_m.nmbsld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbt029
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_nmbt_d[l_ac].nmbt029
                  LET g_qryparam.arg3 = g_nmbs_m.nmbsld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_nmbt_d[l_ac].nmbt029 = g_qryparam.return1                 
               END IF
               
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_nmbs_m.nmbsld,g_nmbt_d[l_ac].nmbt029,'N') THEN
                  LET g_nmbt_d[l_ac].nmbt029 = g_nmbt_d_t.nmbt029
                  CALL anmt311_nmbt029_desc()
                  NEXT FIELD CURRENT
               ELSE
                  CALL anmt311_nmbt029_desc()   
               END IF
               # 150916-00015#1 --end
               
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = l_glaa004
#               LET g_chkparam.arg2 = g_nmbt_d[l_ac].nmbt029
#               IF NOT cl_chk_exist("v_glac002_4") THEN
#                  LET g_nmbt_d[l_ac].nmbt029 = g_nmbt_d_t.nmbt029
#                  CALL anmt311_nmbt029_desc()
#                  NEXT FIELD CURRENT
#               ELSE
#                  CALL anmt311_nmbt029_desc()
#               END IF
               IF NOT cl_null(g_nmbt_d_o.nmbt002) AND g_nmbt_d_o.nmbt002 = g_nmbt_d[l_ac].nmbt002
                  AND g_nmbt_d_o.nmbt003 = g_nmbt_d[l_ac].nmbt003 THEN
                  LET g_nmbt_d_o.nmbt029 = g_nmbt_d[l_ac].nmbt029
               END IF               
            END IF   
            #161221-00054#3 add s---
            LET l_wc = g_nmbt_d[l_ac].nmbt029,",",g_nmbt_d[l_ac].nmbt030
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt029
            #add-point:BEFORE FIELD nmbt029 name="input.b.page1.nmbt029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt029
            #add-point:ON CHANGE nmbt029 name="input.g.page1.nmbt029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt029_desc
            #add-point:BEFORE FIELD nmbt029_desc name="input.b.page1.nmbt029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt029_desc
            
            #add-point:AFTER FIELD nmbt029_desc name="input.a.page1.nmbt029_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt029_desc
            #add-point:ON CHANGE nmbt029_desc name="input.g.page1.nmbt029_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt030
            
            #add-point:AFTER FIELD nmbt030 name="input.a.page1.nmbt030"
           IF NOT cl_null(g_nmbt_d[l_ac].nmbt030) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_glaa004
               LET g_chkparam.arg2 = g_nmbt_d[l_ac].nmbt030
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#1--add--end
               IF NOT cl_chk_exist("v_glac002_4") THEN
                  LET g_nmbt_d[l_ac].nmbt030 = g_nmbt_d_t.nmbt030
                  CALL anmt311_nmbt030_desc()
                  NEXT FIELD CURRENT
               ELSE
                  CALL anmt311_nmbt030_desc()
               END IF                  
            END IF   
            #161221-00054#3 add s---
            LET l_wc = g_nmbt_d[l_ac].nmbt029,",",g_nmbt_d[l_ac].nmbt030
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt030
            #add-point:BEFORE FIELD nmbt030 name="input.b.page1.nmbt030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt030
            #add-point:ON CHANGE nmbt030 name="input.g.page1.nmbt030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt030_desc
            #add-point:BEFORE FIELD nmbt030_desc name="input.b.page1.nmbt030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt030_desc
            
            #add-point:AFTER FIELD nmbt030_desc name="input.a.page1.nmbt030_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt030_desc
            #add-point:ON CHANGE nmbt030_desc name="input.g.page1.nmbt030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt012
            #add-point:BEFORE FIELD nmbt012 name="input.b.page1.nmbt012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt012
            
            #add-point:AFTER FIELD nmbt012 name="input.a.page1.nmbt012"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt012
            #add-point:ON CHANGE nmbt012 name="input.g.page1.nmbt012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt013
            #add-point:BEFORE FIELD nmbt013 name="input.b.page1.nmbt013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt013
            
            #add-point:AFTER FIELD nmbt013 name="input.a.page1.nmbt013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt013
            #add-point:ON CHANGE nmbt013 name="input.g.page1.nmbt013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt014
            #add-point:BEFORE FIELD nmbt014 name="input.b.page1.nmbt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt014
            
            #add-point:AFTER FIELD nmbt014 name="input.a.page1.nmbt014"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt014
            #add-point:ON CHANGE nmbt014 name="input.g.page1.nmbt014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt121
            #add-point:BEFORE FIELD nmbt121 name="input.b.page1.nmbt121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt121
            
            #add-point:AFTER FIELD nmbt121 name="input.a.page1.nmbt121"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt121
            #add-point:ON CHANGE nmbt121 name="input.g.page1.nmbt121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt123
            #add-point:BEFORE FIELD nmbt123 name="input.b.page1.nmbt123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt123
            
            #add-point:AFTER FIELD nmbt123 name="input.a.page1.nmbt123"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt123
            #add-point:ON CHANGE nmbt123 name="input.g.page1.nmbt123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt131
            #add-point:BEFORE FIELD nmbt131 name="input.b.page1.nmbt131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt131
            
            #add-point:AFTER FIELD nmbt131 name="input.a.page1.nmbt131"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt131
            #add-point:ON CHANGE nmbt131 name="input.g.page1.nmbt131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt133
            #add-point:BEFORE FIELD nmbt133 name="input.b.page1.nmbt133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt133
            
            #add-point:AFTER FIELD nmbt133 name="input.a.page1.nmbt133"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt133
            #add-point:ON CHANGE nmbt133 name="input.g.page1.nmbt133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt004
            #add-point:BEFORE FIELD nmbt004 name="input.b.page1.nmbt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt004
            
            #add-point:AFTER FIELD nmbt004 name="input.a.page1.nmbt004"
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt004
            #add-point:ON CHANGE nmbt004 name="input.g.page1.nmbt004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmbtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbtseq
            #add-point:ON ACTION controlp INFIELD nmbtseq name="input.c.page1.nmbtseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt017
            #add-point:ON ACTION controlp INFIELD nmbt017 name="input.c.page1.nmbt017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt017_desc
            #add-point:ON ACTION controlp INFIELD nmbt017_desc name="input.c.page1.nmbt017_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbt017
            CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_today,'')
            CALL s_fin_account_center_sons_str()RETURNING l_origin_str
            CALL anmt311_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef001 IN (",l_origin_str CLIPPED,") AND ooef017 ='",g_nmbs_m.nmbscomp,"' "
            LET g_qryparam.where = g_qryparam.where ," AND ooef201 = 'Y'" #161021-00050#8
            CALL q_ooef001()
            LET g_nmbt_d[l_ac].nmbt017 = g_qryparam.return1
            CALL anmt311_nmbt017_desc()
            DISPLAY g_nmbt_d[l_ac].nmbt017_desc TO nmbt017_desc
            NEXT FIELD nmbt017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt001
            #add-point:ON ACTION controlp INFIELD nmbt001 name="input.c.page1.nmbt001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt002
            #add-point:ON ACTION controlp INFIELD nmbt002 name="input.c.page1.nmbt002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL anmt311_change_to_sql(l_origin_str) RETURNING l_origin_str
            
            IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
#161026-00010#1 mod s---            
#               LET g_qryparam.where = " nmba003 IN ('anmt310','adet402','anmt440','aapt352') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", #2015/6/25 by 02599 add adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352 
#                                      "   AND (nmbastus = 'Y' OR nmbastus = 'V' ) ",
               LET g_qryparam.where = "  nmba003 IN ('adet402','anmt440','aapt352','anmt310') AND nmbastus = 'Y'  AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", #2015/6/25 by 02599 add adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352  
#161026-00010#1 mod e---                                      
                                      "   AND nmba006 = 'Y' ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT DISTINCT nmbt002 FROM nmbt_t ",  #151201-00003#2 add DISTINCT
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbtdocno <> '",g_nmbs_m.nmbsdocno,"'", #151201-00003#2 add
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               #2015/04/30--by--02599--add--str--
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
                  LET g_qryparam.where = g_qryparam.where,
                                         "   AND nmbadocno IN (",
                                         "       SELECT DISTINCT nmbbdocno FROM nmbb_t,nmba_t ",
                                         "        WHERE nmbbent = nmbaent AND nmbbcomp = nmbacomp AND nmbbdocno = nmbadocno ",
                                         "          AND nmbbent = ",g_enterprise,
                                         "          AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                         "          AND nmbborga = '",g_nmbt_d[l_ac].nmbt017,"')"
               END IF
               #2015/04/30--by--02599--add--end
            END IF
            
            #160509-0004--str--
            IF g_nmbt_d[l_ac].nmbt001 = '11' THEN
               LET g_qryparam.where = " nmba003 IN ('anmt310') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", #2015/6/25 by 02599 add adet402
                                      #"   AND (nmbastus = 'Y' OR nmbastus = 'V' ) ",  #161026-00010#1 mark
                                      "   AND nmbastus = 'Y' ",                        #161026-00010#1 add
                                      "   AND nmba006 = 'Y' ",
                                      "   AND nmba015='Y' ", #160509-0004#21
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT DISTINCT nmbt002 FROM nmbt_t ",  #151201-00003#2 add DISTINCT
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbtdocno <> '",g_nmbs_m.nmbsdocno,"'", #151201-00003#2 add
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
            end if 
            #160509-0004#21  --end--
            
            IF g_nmbt_d[l_ac].nmbt001 = '4' THEN
              #LET g_qryparam.where = " nmba003 = 'anmt540' AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",                #151021 by 03538 mark
              #LET g_qryparam.where = " nmba003 IN ('anmt540','anmt541') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",   #151021 by 03538  #161026-00010#1 mark
              LET g_qryparam.where = " nmba003 IN ('anmt540') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",    #161026-00010#1 add
                                      "   AND nmbastus = 'V'  ",
                                      "   AND nmba006 = 'Y' ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               
            END IF
            #161026-00010#1 add s---
            IF g_nmbt_d[l_ac].nmbt001 = '13' THEN
              LET g_qryparam.where = " nmba003 IN ('anmt541') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",    
                                      "   AND nmbastus = 'V'  ",
                                      "   AND nmba006 = 'Y' ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               
            END IF 
            IF g_nmbt_d[l_ac].nmbt001 = '1' THEN            
               LET g_qryparam.where =    " nmba003 IN ('anmt510') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",    
                                      "   AND nmbastus = 'V'  ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'",  
                                      "          AND nmbt002 IS NOT NULL ",  
                                      "       )"
            END IF              
            #161026-00010#1 add e---            
            #2015/04/30--by--02599--add--str--
            #待結算卡回款
            IF g_nmbt_d[l_ac].nmbt001 = '7' THEN
               LET g_qryparam.where = " nmba003 = 'anmt561' AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                      "   AND nmbastus = 'Y'  ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = ",g_enterprise,
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN 
                  LET g_qryparam.where = g_qryparam.where,
                                         "   AND nmbadocno IN (",
                                         "       SELECT DISTINCT nmecdocno FROM nmec_t,nmba_t ",
                                         "        WHERE nmecent = nmbaent AND nmeccomp = nmbacomp AND nmecdocno = nmbadocno ",
                                         "          AND nmecent = ",g_enterprise,
                                         "          AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                         "          AND nmecsite = '",g_nmbt_d[l_ac].nmbt017,"'",
                                         "       )"
               END IF
            END IF
            #營業款存款
            IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
               IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
                  LET g_qryparam.where = " deaksite = '",g_nmbt_d[l_ac].nmbt017,"'"
               ELSE
                  LET g_qryparam.where = " deaksite = '",g_nmbs_m.nmbscomp,"'"
               END IF
               LET g_qryparam.where = g_qryparam.where,
                                      "   AND deakstus = 'Y'  ",
                                      "   AND deakdocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
            END IF
            IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
               CALL q_deakdocno()
            END IF
            #IF g_nmbt_d[l_ac].nmbt001 MATCHES '[347]' OR g_nmbt_d[l_ac].nmbt001='11' THEN  #160509-0004#21  #161026-00010#1 mark
            IF g_nmbt_d[l_ac].nmbt001 MATCHES '[1347]' OR g_nmbt_d[l_ac].nmbt001='11' OR g_nmbt_d[l_ac].nmbt001='13' THEN   #161026-00010#1 add
            #2015/04/30--by--02599--add--end
               CALL q_nmbadocno()                           #呼叫開窗
            END IF 
            
            #20150521--add--str--lujh
            IF g_nmbt_d[l_ac].nmbt001 = '9' THEN
               LET g_qryparam.where = "       deabsite IN (",l_origin_str," )",
                                      "   AND deabstus = 'Y' ",
                                      "   AND deabdocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               CALL q_deabdocno()
            END IF
            #20150521--add--end--lujh

            #150417-00007#56 Add  ---(S)---
            IF g_nmbt_d[l_ac].nmbt001 = '10' THEN
               LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                      "   AND nmbastus = 'Y' ",
                                      "   AND nmba003 = 'anmt563' ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               CALL q_nmbadocno()
            END IF
            IF g_nmbt_d[l_ac].nmbt001 = '12' THEN
               LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                      "   AND nmbastus = 'Y' ",
                                      "   AND nmba003 = 'anmt564' ",
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               CALL q_nmbadocno()
            END IF
            #150417-00007#56 Add  ---(E)---

            LET tok = base.StringTokenizer.create(g_qryparam.return1,"||")
            WHILE tok.hasMoreTokens()
               LET l_nmbt002 = tok.nextToken()
               LET l_nmbt002 = l_nmbt002.trim()
               #IF g_nmbt_d[l_ac].nmbt001 = '3' OR g_nmbt_d[l_ac].nmbt001 = '4' OR g_nmbt_d[l_ac].nmbt001 = '11' THEN #161026-00010#1 mark
               IF g_nmbt_d[l_ac].nmbt001 = '3' OR g_nmbt_d[l_ac].nmbt001 = '4' OR g_nmbt_d[l_ac].nmbt001 = '11' OR g_nmbt_d[l_ac].nmbt001 = '13' OR g_nmbt_d[l_ac].nmbt001 = '1'  THEN  #161026-00010#1 add
                  CALL anmt311_nmba_get(g_nmbt_d[l_ac].nmbt001,l_nmbt002)
               END IF
               IF g_nmbt_d[l_ac].nmbt001 = '7'  THEN
                  CALL anmt311_nmbt_get_7(l_nmbt002,'')
               END IF
               IF g_nmbt_d[l_ac].nmbt001 = '8'  THEN
                  CALL anmt311_nmbt_get_8(l_nmbt002,'')
               END IF
               #20150521--add--str--lujh
               IF g_nmbt_d[l_ac].nmbt001 = '9'  THEN
                  CALL anmt311_nmbt_get_9(l_nmbt002,'')
               END IF
               #20150521--add--end--lujh
               #150417-00007#56 Add  ---(S)---
               IF g_nmbt_d[l_ac].nmbt001 = '10'  THEN
                  CALL anmt311_nmbt_get_10(l_nmbt002,'')
               END IF
                #150417-00007#56 Add  ---(E)---
               #160509-00004#47  add  by Naysa  S
               IF g_nmbt_d[l_ac].nmbt001 = '12'  THEN
                  CALL anmt311_nmbt_get_12(l_nmbt002,'')
               END IF
               #160509-00004#47  add  by Naysa  E
            
            END WHILE
            LET l_flag = 'Y'
            EXIT DIALOG 

            NEXT FIELD nmbt002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt003
            #add-point:ON ACTION controlp INFIELD nmbt003 name="input.c.page1.nmbt003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbadocdt_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocdt_2
            #add-point:ON ACTION controlp INFIELD nmbadocdt_2 name="input.c.page1.nmbadocdt_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb001
            #add-point:ON ACTION controlp INFIELD nmbb001 name="input.c.page1.nmbb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002
            #add-point:ON ACTION controlp INFIELD nmbb002 name="input.c.page1.nmbb002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbt_d[l_ac].nmbb002 = g_qryparam.return1              

            DISPLAY g_nmbt_d[l_ac].nmbb002 TO nmbb002              #

            NEXT FIELD nmbb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt011
            #add-point:ON ACTION controlp INFIELD nmbt011 name="input.c.page1.nmbt011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028
            #add-point:ON ACTION controlp INFIELD nmbb028 name="input.c.page1.nmbb028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbb028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooia001()                                #呼叫開窗

            LET g_nmbt_d[l_ac].nmbb028 = g_qryparam.return1              

            DISPLAY g_nmbt_d[l_ac].nmbb028 TO nmbb028              #

            NEXT FIELD nmbb028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028_desc
            #add-point:ON ACTION controlp INFIELD nmbb028_desc name="input.c.page1.nmbb028_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb029
            #add-point:ON ACTION controlp INFIELD nmbb029 name="input.c.page1.nmbb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt100
            #add-point:ON ACTION controlp INFIELD nmbt100 name="input.c.page1.nmbt100"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbt100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooai001()                                #呼叫開窗

            LET g_nmbt_d[l_ac].nmbt100 = g_qryparam.return1              

            DISPLAY g_nmbt_d[l_ac].nmbt100 TO nmbt100              #

            NEXT FIELD nmbt100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt101
            #add-point:ON ACTION controlp INFIELD nmbt101 name="input.c.page1.nmbt101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt103
            #add-point:ON ACTION controlp INFIELD nmbt103 name="input.c.page1.nmbt103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt113
            #add-point:ON ACTION controlp INFIELD nmbt113 name="input.c.page1.nmbt113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt029
            #add-point:ON ACTION controlp INFIELD nmbt029 name="input.c.page1.nmbt029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbt029             #給予default值

            #給予arg
           # LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "glac003<> '1' AND glac001 = '",l_glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_nmbs_m.nmbsld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_nmbt_d[l_ac].nmbt029 = g_qryparam.return1              
            CALL anmt311_nmbt029_desc()
            DISPLAY g_nmbt_d[l_ac].nmbt029 TO nmbt029              #

            NEXT FIELD nmbt029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt029_desc
            #add-point:ON ACTION controlp INFIELD nmbt029_desc name="input.c.page1.nmbt029_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt030
            #add-point:ON ACTION controlp INFIELD nmbt030 name="input.c.page1.nmbt030"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt_d[l_ac].nmbt030             #給予default值

            #給予arg
           # LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "glac003 <> '1' AND glac001 = '",l_glaa004,"' "
            
            CALL aglt310_04()                                #呼叫開窗
        
            LET g_nmbt_d[l_ac].nmbt030 = g_qryparam.return1              
            CALL anmt311_nmbt030_desc()
            DISPLAY g_nmbt_d[l_ac].nmbt030 TO nmbt030              #

            NEXT FIELD nmbt030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt030_desc
            #add-point:ON ACTION controlp INFIELD nmbt030_desc name="input.c.page1.nmbt030_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt012
            #add-point:ON ACTION controlp INFIELD nmbt012 name="input.c.page1.nmbt012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt013
            #add-point:ON ACTION controlp INFIELD nmbt013 name="input.c.page1.nmbt013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt014
            #add-point:ON ACTION controlp INFIELD nmbt014 name="input.c.page1.nmbt014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt121
            #add-point:ON ACTION controlp INFIELD nmbt121 name="input.c.page1.nmbt121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt123
            #add-point:ON ACTION controlp INFIELD nmbt123 name="input.c.page1.nmbt123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt131
            #add-point:ON ACTION controlp INFIELD nmbt131 name="input.c.page1.nmbt131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt133
            #add-point:ON ACTION controlp INFIELD nmbt133 name="input.c.page1.nmbt133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt004
            #add-point:ON ACTION controlp INFIELD nmbt004 name="input.c.page1.nmbt004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbt_d[l_ac].* = g_nmbt_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt311_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmbt_d[l_ac].nmbtseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmbt_d[l_ac].* = g_nmbt_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt311_nmbt_t_mask_restore('restore_mask_o')
      
               UPDATE nmbt_t SET (nmbtld,nmbtdocno,nmbtseq,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100, 
                   nmbt101,nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131, 
                   nmbt133,nmbt004,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026, 
                   nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039, 
                   nmbt040,nmbt041,nmbt042,nmbt043) = (g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbt_d[l_ac].nmbtseq, 
                   g_nmbt_d[l_ac].nmbt017,g_nmbt_d[l_ac].nmbt001,g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003, 
                   g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103, 
                   g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt029,g_nmbt_d[l_ac].nmbt030,g_nmbt_d[l_ac].nmbt012, 
                   g_nmbt_d[l_ac].nmbt013,g_nmbt_d[l_ac].nmbt014,g_nmbt_d[l_ac].nmbt121,g_nmbt_d[l_ac].nmbt123, 
                   g_nmbt_d[l_ac].nmbt131,g_nmbt_d[l_ac].nmbt133,g_nmbt_d[l_ac].nmbt004,g_nmbt2_d[l_ac].nmbt018, 
                   g_nmbt2_d[l_ac].nmbt019,g_nmbt2_d[l_ac].nmbt020,g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt022, 
                   g_nmbt2_d[l_ac].nmbt023,g_nmbt2_d[l_ac].nmbt024,g_nmbt2_d[l_ac].nmbt025,g_nmbt2_d[l_ac].nmbt026, 
                   g_nmbt2_d[l_ac].nmbt027,g_nmbt2_d[l_ac].nmbt028,g_nmbt2_d[l_ac].nmbt031,g_nmbt2_d[l_ac].nmbt032, 
                   g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt034,g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036, 
                   g_nmbt2_d[l_ac].nmbt037,g_nmbt2_d[l_ac].nmbt038,g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040, 
                   g_nmbt2_d[l_ac].nmbt041,g_nmbt2_d[l_ac].nmbt042,g_nmbt2_d[l_ac].nmbt043)
                WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m.nmbsld 
                  AND nmbtdocno = g_nmbs_m.nmbsdocno 
 
                  AND nmbtseq = g_nmbt_d_t.nmbtseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbt_d[l_ac].* = g_nmbt_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbt_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbt_d[l_ac].* = g_nmbt_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_nmbs_m.nmbsld = g_detail_multi_table_t.nmbbcomp AND
         g_nmbs_m.nmbsdocno = g_detail_multi_table_t.nmbbdocno AND
         g_nmbt_d[l_ac].nmbtseq = g_detail_multi_table_t.nmbbseq AND
         g_nmbt_d[l_ac].nmbb001 = g_detail_multi_table_t.nmbb001 AND
         g_nmbt_d[l_ac].nmbb002 = g_detail_multi_table_t.nmbb002 AND
         g_nmbt_d[l_ac].nmbb028 = g_detail_multi_table_t.nmbb028 AND
         g_nmbt_d[l_ac].nmbb029 = g_detail_multi_table_t.nmbb029 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'nmbbent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_nmbs_m.nmbsld
            LET l_field_keys[02] = 'nmbbcomp'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.nmbbcomp
            LET l_var_keys[03] = g_nmbs_m.nmbsdocno
            LET l_field_keys[03] = 'nmbbdocno'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.nmbbdocno
            LET l_var_keys[04] = g_nmbt_d[l_ac].nmbtseq
            LET l_field_keys[04] = 'nmbbseq'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.nmbbseq
            LET l_vars[01] = g_nmbt_d[l_ac].nmbb001
            LET l_fields[01] = 'nmbb001'
            LET l_vars[02] = g_nmbt_d[l_ac].nmbb002
            LET l_fields[02] = 'nmbb002'
            LET l_vars[03] = g_nmbt_d[l_ac].nmbb028
            LET l_fields[03] = 'nmbb028'
            LET l_vars[04] = g_nmbt_d[l_ac].nmbb029
            LET l_fields[04] = 'nmbb029'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'nmbb_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_m.nmbsld
               LET gs_keys_bak[1] = g_nmbsld_t
               LET gs_keys[2] = g_nmbs_m.nmbsdocno
               LET gs_keys_bak[2] = g_nmbsdocno_t
               LET gs_keys[3] = g_nmbt_d[g_detail_idx].nmbtseq
               LET gs_keys_bak[3] = g_nmbt_d_t.nmbtseq
               CALL anmt311_update_b('nmbt_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt311_nmbt_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmbt_d[g_detail_idx].nmbtseq = g_nmbt_d_t.nmbtseq 
 
                  ) THEN
                  LET gs_keys[01] = g_nmbs_m.nmbsld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbs_m.nmbsdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbt_d_t.nmbtseq
 
                  CALL anmt311_key_update_b(gs_keys,'nmbt_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbs_m),util.JSON.stringify(g_nmbt_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbs_m),util.JSON.stringify(g_nmbt_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
            #   CALL anmt311_nmbv_ins(g_nmbs_m.nmbsdocno,g_nmbt_d[l_ac].nmbtseq,g_nmbt_d[l_ac].nmbt001,g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbb001,g_nmbt_d[l_ac].nmbt003,g_nmbt_d[l_ac].nmbt103,g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt123,g_nmbt_d[l_ac].nmbt133)
               IF g_success = 'N' THEN
                  CALL s_transaction_end('N',0)
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL anmt311_unlock_b("nmbt_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            LET l_success1 = TRUE
            #CALL cl_showmsg_init()   
            CALL cl_err_collect_init()            
            FOR i=1 TO g_nmbt_d.getLength()
                SELECT COUNT(*) INTO l_cnt 
                  FROM nmbt_t
                 WHERE nmbtent = g_enterprise 
                   AND nmbtld = g_nmbs_m.nmbsld 
                   AND nmbtdocno = g_nmbs_m.nmbsdocno 
                   AND nmbt002 =  g_nmbt_d[i].nmbt002
                   
                SELECT COUNT(*) INTO l_cnt1
                  FROM nmbb_t
                 WHERE nmbbent = g_enterprise 
                   AND nmbbcomp = g_nmbs_m.nmbscomp
                   AND nmbbdocno = g_nmbt_d[i].nmbt002
                IF l_cnt < l_cnt1 THEN
                   LET l_success1 = FALSE
                   #CALL cl_errmsg('nmbt002',g_nmbt_d[i].nmbt002,'','anm-00321',1)
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'anm-00321'
                   LET g_errparam.extend = g_nmbt_d[i].nmbt002
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                END IF 
            END FOR
            CALL cl_err_collect_show()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmbt_d[li_reproduce_target].* = g_nmbt_d[li_reproduce].*
               LET g_nmbt2_d[li_reproduce_target].* = g_nmbt2_d[li_reproduce].*
               LET g_nmbt3_d[li_reproduce_target].* = g_nmbt3_d[li_reproduce].*
 
               LET g_nmbt_d[li_reproduce_target].nmbtseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbt_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbt_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_nmbt2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL anmt311_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmbt2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbt2_d[l_ac].* TO NULL 
            INITIALIZE g_nmbt2_d_t.* TO NULL 
            INITIALIZE g_nmbt2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_nmbt2_d_t.* = g_nmbt2_d[l_ac].*     #新輸入資料
            LET g_nmbt2_d_o.* = g_nmbt2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt311_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt311_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbt_d[li_reproduce_target].* = g_nmbt_d[li_reproduce].*
               LET g_nmbt2_d[li_reproduce_target].* = g_nmbt2_d[li_reproduce].*
               LET g_nmbt3_d[li_reproduce_target].* = g_nmbt3_d[li_reproduce].*
 
               LET g_nmbt2_d[li_reproduce_target].nmbtseq = NULL
            END IF
            
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
 
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
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
            OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt311_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt311_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbt2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbt2_d[l_ac].nmbtseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmbt2_d_t.* = g_nmbt2_d[l_ac].*  #BACKUP
               LET g_nmbt2_d_o.* = g_nmbt2_d[l_ac].*  #BACKUP
               CALL anmt311_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL anmt311_set_no_entry_b(l_cmd)
               IF NOT anmt311_lock_b("nmbt_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt311_bcl INTO g_nmbt_d[l_ac].nmbtseq,g_nmbt_d[l_ac].nmbt017,g_nmbt_d[l_ac].nmbt001, 
                      g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003,g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt100, 
                      g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103,g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt029, 
                      g_nmbt_d[l_ac].nmbt030,g_nmbt_d[l_ac].nmbt012,g_nmbt_d[l_ac].nmbt013,g_nmbt_d[l_ac].nmbt014, 
                      g_nmbt_d[l_ac].nmbt121,g_nmbt_d[l_ac].nmbt123,g_nmbt_d[l_ac].nmbt131,g_nmbt_d[l_ac].nmbt133, 
                      g_nmbt_d[l_ac].nmbt004,g_nmbt2_d[l_ac].nmbtseq,g_nmbt2_d[l_ac].nmbt001,g_nmbt2_d[l_ac].nmbt002, 
                      g_nmbt2_d[l_ac].nmbt003,g_nmbt2_d[l_ac].nmbt018,g_nmbt2_d[l_ac].nmbt019,g_nmbt2_d[l_ac].nmbt020, 
                      g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt022,g_nmbt2_d[l_ac].nmbt023,g_nmbt2_d[l_ac].nmbt024, 
                      g_nmbt2_d[l_ac].nmbt025,g_nmbt2_d[l_ac].nmbt026,g_nmbt2_d[l_ac].nmbt027,g_nmbt2_d[l_ac].nmbt028, 
                      g_nmbt2_d[l_ac].nmbt031,g_nmbt2_d[l_ac].nmbt032,g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt034, 
                      g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036,g_nmbt2_d[l_ac].nmbt037,g_nmbt2_d[l_ac].nmbt038, 
                      g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040,g_nmbt2_d[l_ac].nmbt041,g_nmbt2_d[l_ac].nmbt042, 
                      g_nmbt2_d[l_ac].nmbt043,g_nmbt3_d[l_ac].nmbtseq,g_nmbt3_d[l_ac].nmbt001,g_nmbt3_d[l_ac].nmbt002, 
                      g_nmbt3_d[l_ac].nmbt003,g_nmbt3_d[l_ac].nmbt100,g_nmbt3_d[l_ac].nmbt103,g_nmbt3_d[l_ac].nmbt121, 
                      g_nmbt3_d[l_ac].nmbt123,g_nmbt3_d[l_ac].nmbt131,g_nmbt3_d[l_ac].nmbt133
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbt2_d_mask_o[l_ac].* =  g_nmbt2_d[l_ac].*
                  CALL anmt311_nmbt_t_mask()
                  LET g_nmbt2_d_mask_n[l_ac].* =  g_nmbt2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt311_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            CALL anmt311_nmbt017_desc()
            CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
            CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
            CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
            CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc 
            CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
            CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
            CALL anmt311_nmbt024_desc()
            CALL anmt311_nmbt025_desc()
            CALL anmt311_nmbt026_desc()
            CALL anmt311_nmbt027_desc()
            CALL anmt311_nmbt028_desc()
            CALL anmt311_nmbt029_check()   #根據科目判斷自由核算項目是否開啟
            
            #161221-00054#3 add s---
            LET l_wc = g_nmbt_d[l_ac].nmbt029,",",g_nmbt_d[l_ac].nmbt030
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---              
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
 
LET g_detail_multi_table_t.nmbbcomp = g_nmbs_m.nmbsld
LET g_detail_multi_table_t.nmbbdocno = g_nmbs_m.nmbsdocno
LET g_detail_multi_table_t.nmbbseq = g_nmbt_d[l_ac].nmbtseq
LET g_detail_multi_table_t.nmbb001 = g_nmbt_d[l_ac].nmbb001
LET g_detail_multi_table_t.nmbb002 = g_nmbt_d[l_ac].nmbb002
LET g_detail_multi_table_t.nmbb028 = g_nmbt_d[l_ac].nmbb028
LET g_detail_multi_table_t.nmbb029 = g_nmbt_d[l_ac].nmbb029
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'nmbbent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'nmbbcomp'
            LET l_var_keys[02] = g_nmbs_m.nmbsld
            LET l_field_keys[03] = 'nmbbdocno'
            LET l_var_keys[03] = g_nmbs_m.nmbsdocno
            LET l_field_keys[04] = 'nmbbseq'
            LET l_var_keys[04] = g_nmbt_d[l_ac].nmbtseq
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'nmbb_t') THEN
               RETURN 
            END IF 
 
 
 
            
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
               LET gs_keys[01] = g_nmbs_m.nmbsld
               LET gs_keys[gs_keys.getLength()+1] = g_nmbs_m.nmbsdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbt2_d_t.nmbtseq
            
               #刪除同層單身
               IF NOT anmt311_delete_b('nmbt_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt311_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt311_key_delete_b(gs_keys,'nmbt_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt311_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'nmbbent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'nmbbcomp'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.nmbbcomp
                  LET l_field_keys[03] = 'nmbbdocno'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.nmbbdocno
                  LET l_field_keys[04] = 'nmbbseq'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.nmbbseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'nmbb_t')
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt311_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_nmbt_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbt2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM nmbt_t 
             WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m.nmbsld
               AND nmbtdocno = g_nmbs_m.nmbsdocno
               AND nmbtseq = g_nmbt2_d[l_ac].nmbtseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_m.nmbsld
               LET gs_keys[2] = g_nmbs_m.nmbsdocno
               LET gs_keys[3] = g_nmbt2_d[g_detail_idx].nmbtseq
               CALL anmt311_insert_b('nmbt_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbt_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt311_b_fill()
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
               LET g_nmbt2_d[l_ac].* = g_nmbt2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt311_bcl
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
               LET g_nmbt2_d[l_ac].* = g_nmbt2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL anmt311_nmbt_t_mask_restore('restore_mask_o')
                              
               UPDATE nmbt_t SET (nmbtld,nmbtdocno,nmbtseq,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100, 
                   nmbt101,nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131, 
                   nmbt133,nmbt004,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026, 
                   nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039, 
                   nmbt040,nmbt041,nmbt042,nmbt043) = (g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbt_d[l_ac].nmbtseq, 
                   g_nmbt_d[l_ac].nmbt017,g_nmbt_d[l_ac].nmbt001,g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003, 
                   g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103, 
                   g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt029,g_nmbt_d[l_ac].nmbt030,g_nmbt_d[l_ac].nmbt012, 
                   g_nmbt_d[l_ac].nmbt013,g_nmbt_d[l_ac].nmbt014,g_nmbt_d[l_ac].nmbt121,g_nmbt_d[l_ac].nmbt123, 
                   g_nmbt_d[l_ac].nmbt131,g_nmbt_d[l_ac].nmbt133,g_nmbt_d[l_ac].nmbt004,g_nmbt2_d[l_ac].nmbt018, 
                   g_nmbt2_d[l_ac].nmbt019,g_nmbt2_d[l_ac].nmbt020,g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt022, 
                   g_nmbt2_d[l_ac].nmbt023,g_nmbt2_d[l_ac].nmbt024,g_nmbt2_d[l_ac].nmbt025,g_nmbt2_d[l_ac].nmbt026, 
                   g_nmbt2_d[l_ac].nmbt027,g_nmbt2_d[l_ac].nmbt028,g_nmbt2_d[l_ac].nmbt031,g_nmbt2_d[l_ac].nmbt032, 
                   g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt034,g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036, 
                   g_nmbt2_d[l_ac].nmbt037,g_nmbt2_d[l_ac].nmbt038,g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040, 
                   g_nmbt2_d[l_ac].nmbt041,g_nmbt2_d[l_ac].nmbt042,g_nmbt2_d[l_ac].nmbt043) #自訂欄位頁簽 
 
                WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m.nmbsld
                  AND nmbtdocno = g_nmbs_m.nmbsdocno
                  AND nmbtseq = g_nmbt2_d_t.nmbtseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbt2_d[l_ac].* = g_nmbt2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbt_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbt2_d[l_ac].* = g_nmbt2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_m.nmbsld
               LET gs_keys_bak[1] = g_nmbsld_t
               LET gs_keys[2] = g_nmbs_m.nmbsdocno
               LET gs_keys_bak[2] = g_nmbsdocno_t
               LET gs_keys[3] = g_nmbt2_d[g_detail_idx].nmbtseq
               LET gs_keys_bak[3] = g_nmbt2_d_t.nmbtseq
               CALL anmt311_update_b('nmbt_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt311_nmbt_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmbt2_d[g_detail_idx].nmbtseq = g_nmbt2_d_t.nmbtseq 
                  ) THEN
                  LET gs_keys[01] = g_nmbs_m.nmbsld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbs_m.nmbsdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbt2_d_t.nmbtseq
                  CALL anmt311_key_update_b(gs_keys,'nmbt_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbs_m),util.JSON.stringify(g_nmbt2_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbs_m),util.JSON.stringify(g_nmbt2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt018
            #add-point:BEFORE FIELD nmbt018 name="input.b.page2.nmbt018"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt018
            
            #add-point:AFTER FIELD nmbt018 name="input.a.page2.nmbt018"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt018)  THEN
               CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
            END IF
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add            
            #160331-00011#1 add -end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt018
            #add-point:ON CHANGE nmbt018 name="input.g.page2.nmbt018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt018_desc
            #add-point:BEFORE FIELD nmbt018_desc name="input.b.page2.nmbt018_desc"
            LET g_nmbt2_d[l_ac].nmbt018_desc = g_nmbt2_d[l_ac].nmbt018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt018_desc
            
            #add-point:AFTER FIELD nmbt018_desc name="input.a.page2.nmbt018_desc"
            LET g_nmbt2_d[l_ac].nmbt018 = g_nmbt2_d[l_ac].nmbt018_desc
            CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc   
            DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO s_detail2[l_ac].nmbt018_desc  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt018) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt018
               LET g_chkparam.arg2 = g_today 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'02',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt018) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt018 = g_nmbt2_d_o.nmbt018    
                     LET g_nmbt2_d[l_ac].nmbt018_desc = g_nmbt2_d_o.nmbt018_desc    
                     CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO s_detail2[l_ac].nmbt018_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'02',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt018) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt018 = g_nmbt2_d_o.nmbt018    
                     LET g_nmbt2_d[l_ac].nmbt018_desc = g_nmbt2_d_o.nmbt018_desc    
                     CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO s_detail2[l_ac].nmbt018_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
               ELSE
                  #檢查失敗時後續處理
                  #LET g_nmbt2_d[l_ac].nmbt018 = g_nmbt2_d_t.nmbt018   #160822-00012#5   mark
                   LET g_nmbt2_d[l_ac].nmbt018 = g_nmbt2_d_o.nmbt018    #160822-00012#5   add
                   #LET g_nmbt2_d[l_ac].nmbt018_desc = g_nmbt2_d_t.nmbt018_desc   #160822-00012#5   mark
                   LET g_nmbt2_d[l_ac].nmbt018_desc = g_nmbt2_d_o.nmbt018_desc    #160822-00012#5   add
                  CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
                  DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO s_detail2[l_ac].nmbt018_desc
                  NEXT FIELD CURRENT
               END IF          
            END IF
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt018_desc
            #add-point:ON CHANGE nmbt018_desc name="input.g.page2.nmbt018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt019
            #add-point:BEFORE FIELD nmbt019 name="input.b.page2.nmbt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt019
            
            #add-point:AFTER FIELD nmbt019 name="input.a.page2.nmbt019"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt019)  THEN
               CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
            END IF 
            #160331-00011#1 add -end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt019
            #add-point:ON CHANGE nmbt019 name="input.g.page2.nmbt019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt019_desc
            #add-point:BEFORE FIELD nmbt019_desc name="input.b.page2.nmbt019_desc"
            LET g_nmbt2_d[l_ac].nmbt019_desc = g_nmbt2_d[l_ac].nmbt019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt019_desc
            
            #add-point:AFTER FIELD nmbt019_desc name="input.a.page2.nmbt019_desc"
             LET g_nmbt2_d[l_ac].nmbt019 = g_nmbt2_d[l_ac].nmbt019_desc
             CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc 
             DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO s_detail2[l_ac].nmbt019_desc  
             IF NOT cl_null(g_nmbt2_d[l_ac].nmbt019) THEN 
                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                INITIALIZE g_chkparam.* TO NULL              
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt019
                LET g_chkparam.arg2 = g_today 
                #160318-00025#1--add--str
                LET g_errshow = TRUE 
                LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                #160318-00025#1--add--end                
                #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_ooeg001") THEN
                   #檢查成功時後續處理
                   #LET  = g_chkparam.return1
                   #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'03',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt019) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt019 = g_nmbt2_d_o.nmbt019    
                     LET g_nmbt2_d[l_ac].nmbt019_desc = g_nmbt2_d_o.nmbt019_desc     
                     CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO s_detail2[l_ac].nmbt019_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'03',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt019) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt019 = g_nmbt2_d_o.nmbt019    
                     LET g_nmbt2_d[l_ac].nmbt019_desc = g_nmbt2_d_o.nmbt019_desc     
                     CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO s_detail2[l_ac].nmbt019_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
                ELSE
                   #檢查失敗時後續處理
                   #LET g_nmbt2_d[l_ac].nmbt019 = g_nmbt2_d_t.nmbt019   #160822-00012#5   mark
                   LET g_nmbt2_d[l_ac].nmbt019 = g_nmbt2_d_o.nmbt019    #160822-00012#5   add
                   #LET g_nmbt2_d[l_ac].nmbt019_desc = g_nmbt2_d_t.nmbt019_desc   #160822-00012#5   mark
                   LET g_nmbt2_d[l_ac].nmbt019_desc = g_nmbt2_d_o.nmbt019_desc    #160822-00012#5   add
                   CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
                   DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO s_detail2[l_ac].nmbt019_desc
                   NEXT FIELD CURRENT
                END IF
             END IF
             LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add              
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt019_desc
            #add-point:ON CHANGE nmbt019_desc name="input.g.page2.nmbt019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt020
            #add-point:BEFORE FIELD nmbt020 name="input.b.page2.nmbt020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt020
            
            #add-point:AFTER FIELD nmbt020 name="input.a.page2.nmbt020"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt020)  THEN
               CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
            END IF 
            #160331-00011#1 add -end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt020
            #add-point:ON CHANGE nmbt020 name="input.g.page2.nmbt020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt020_desc
            #add-point:BEFORE FIELD nmbt020_desc name="input.b.page2.nmbt020_desc"
            LET g_nmbt2_d[l_ac].nmbt020_desc = g_nmbt2_d[l_ac].nmbt020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt020_desc
            
            #add-point:AFTER FIELD nmbt020_desc name="input.a.page2.nmbt020_desc"
            LET g_nmbt2_d[l_ac].nmbt020 = g_nmbt2_d[l_ac].nmbt020_desc
            CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc  
            DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO s_detail2[l_ac].nmbt020_desc  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt020) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL            
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt020 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_287") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'04',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt020) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt020 = g_nmbt2_d_t.nmbt020
                     LET g_nmbt2_d[l_ac].nmbt020_desc = g_nmbt2_d_t.nmbt020_desc
                     CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO s_detail2[l_ac].nmbt020_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'04',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt020) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt020 = g_nmbt2_d_t.nmbt020
                     LET g_nmbt2_d[l_ac].nmbt020_desc = g_nmbt2_d_t.nmbt020_desc
                     CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO s_detail2[l_ac].nmbt020_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt020 = g_nmbt2_d_t.nmbt020
                  LET g_nmbt2_d[l_ac].nmbt020_desc = g_nmbt2_d_t.nmbt020_desc
                  CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
                  DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO s_detail2[l_ac].nmbt020_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt020_desc
            #add-point:ON CHANGE nmbt020_desc name="input.g.page2.nmbt020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt021
            #add-point:BEFORE FIELD nmbt021 name="input.b.page2.nmbt021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt021
            
            #add-point:AFTER FIELD nmbt021 name="input.a.page2.nmbt021"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt021)  THEN
               CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc
            END IF 
            #160331-00011#1 add -end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt021
            #add-point:ON CHANGE nmbt021 name="input.g.page2.nmbt021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt021_desc
            #add-point:BEFORE FIELD nmbt021_desc name="input.b.page2.nmbt021_desc"
            LET g_nmbt2_d[l_ac].nmbt021_desc = g_nmbt2_d[l_ac].nmbt021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt021_desc
            
            #add-point:AFTER FIELD nmbt021_desc name="input.a.page2.nmbt021_desc"
            LET g_nmbt2_d[l_ac].nmbt021 = g_nmbt2_d[l_ac].nmbt021_desc
            CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc 
            DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt021) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt021
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'05',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt021) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt021 = g_nmbt2_d_o.nmbt021     
                     LET g_nmbt2_d[l_ac].nmbt021_desc = g_nmbt2_d_o.nmbt021_desc    
                     CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'05',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt021) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt021 = g_nmbt2_d_o.nmbt021     
                     LET g_nmbt2_d[l_ac].nmbt021_desc = g_nmbt2_d_o.nmbt021_desc    
                     CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---   
               ELSE
                  #檢查失敗時後續處理
                  #LET g_nmbt2_d[l_ac].nmbt021 = g_nmbt2_d_t.nmbt021   #160822-00012#5   mark
                  LET g_nmbt2_d[l_ac].nmbt021 = g_nmbt2_d_o.nmbt021    #160822-00012#5   add
                  #LET g_nmbt2_d[l_ac].nmbt021_desc = g_nmbt2_d_t.nmbt021_desc   #160822-00012#5   mark
                  LET g_nmbt2_d[l_ac].nmbt021_desc = g_nmbt2_d_o.nmbt021_desc    #160822-00012#5   add
                  CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc
                  DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF 
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt021_desc
            #add-point:ON CHANGE nmbt021_desc name="input.g.page2.nmbt021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt022
            #add-point:BEFORE FIELD nmbt022 name="input.b.page2.nmbt022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt022
            
            #add-point:AFTER FIELD nmbt022 name="input.a.page2.nmbt022"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt022)  THEN
               CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
            END IF 
            #160331-00011#1 add -end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt022
            #add-point:ON CHANGE nmbt022 name="input.g.page2.nmbt022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt022_desc
            #add-point:BEFORE FIELD nmbt022_desc name="input.b.page2.nmbt022_desc"
            LET g_nmbt2_d[l_ac].nmbt022_desc = g_nmbt2_d[l_ac].nmbt022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt022_desc
            
            #add-point:AFTER FIELD nmbt022_desc name="input.a.page2.nmbt022_desc"
            LET g_nmbt2_d[l_ac].nmbt022 = g_nmbt2_d[l_ac].nmbt022_desc
            CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc  
            DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc 
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt022) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt022 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'06',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt022) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt022 = g_nmbt2_d_t.nmbt022
                     LET g_nmbt2_d[l_ac].nmbt022_desc = g_nmbt2_d_t.nmbt022_desc
                     CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'06',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt022) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt022 = g_nmbt2_d_t.nmbt022
                     LET g_nmbt2_d[l_ac].nmbt022_desc = g_nmbt2_d_t.nmbt022_desc
                     CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt022 = g_nmbt2_d_t.nmbt022
                  LET g_nmbt2_d[l_ac].nmbt022_desc = g_nmbt2_d_t.nmbt022_desc
                  CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
                  DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO s_detail2[l_ac].nmbt021_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt022_desc
            #add-point:ON CHANGE nmbt022_desc name="input.g.page2.nmbt022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt023
            #add-point:BEFORE FIELD nmbt023 name="input.b.page2.nmbt023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt023
            
            #add-point:AFTER FIELD nmbt023 name="input.a.page2.nmbt023"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt023)  THEN
               CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
            END IF 
            #160331-00011#1 add -end            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt023
            #add-point:ON CHANGE nmbt023 name="input.g.page2.nmbt023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt023_desc
            #add-point:BEFORE FIELD nmbt023_desc name="input.b.page2.nmbt023_desc"
             LET g_nmbt2_d[l_ac].nmbt023_desc = g_nmbt2_d[l_ac].nmbt023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt023_desc
            
            #add-point:AFTER FIELD nmbt023_desc name="input.a.page2.nmbt023_desc"
            LET g_nmbt2_d[l_ac].nmbt023 = g_nmbt2_d[l_ac].nmbt023_desc
            CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc 
            DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO s_detail2[l_ac].nmbt023_desc  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt023) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt023
                #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               LET g_chkparam.err_str[1] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'07',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt023) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt023 = g_nmbt2_d_t.nmbt023
                     LET g_nmbt2_d[l_ac].nmbt023_desc = g_nmbt2_d_t.nmbt023_desc
                     CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO s_detail2[l_ac].nmbt023_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'07',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt023) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt023 = g_nmbt2_d_t.nmbt023
                     LET g_nmbt2_d[l_ac].nmbt023_desc = g_nmbt2_d_t.nmbt023_desc
                     CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
                     DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO s_detail2[l_ac].nmbt023_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                       
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt023 = g_nmbt2_d_t.nmbt023
                  LET g_nmbt2_d[l_ac].nmbt023_desc = g_nmbt2_d_t.nmbt023_desc
                  CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
                  DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO s_detail2[l_ac].nmbt023_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt023_desc
            #add-point:ON CHANGE nmbt023_desc name="input.g.page2.nmbt023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt024
            #add-point:BEFORE FIELD nmbt024 name="input.b.page2.nmbt024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt024
            
            #add-point:AFTER FIELD nmbt024 name="input.a.page2.nmbt024"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt024)  THEN
               CALL anmt311_nmbt024_desc()
            END IF 
            #160331-00011#1 add -end 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt024
            #add-point:ON CHANGE nmbt024 name="input.g.page2.nmbt024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt024_desc
            #add-point:BEFORE FIELD nmbt024_desc name="input.b.page2.nmbt024_desc"
            LET g_nmbt2_d[l_ac].nmbt024_desc = g_nmbt2_d[l_ac].nmbt024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt024_desc
            
            #add-point:AFTER FIELD nmbt024_desc name="input.a.page2.nmbt024_desc"
            LET g_nmbt2_d[l_ac].nmbt024 = g_nmbt2_d[l_ac].nmbt024_desc
            CALL anmt311_nmbt024_desc() 
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt024) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt024
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'08',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt024) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt024 = g_nmbt2_d_t.nmbt024
                     LET g_nmbt2_d[l_ac].nmbt024_desc = g_nmbt2_d_t.nmbt024_desc
                     CALL anmt311_nmbt024_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'08',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt024) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt024 = g_nmbt2_d_t.nmbt024
                     LET g_nmbt2_d[l_ac].nmbt024_desc = g_nmbt2_d_t.nmbt024_desc
                     CALL anmt311_nmbt024_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt024 = g_nmbt2_d_t.nmbt024
                  LET g_nmbt2_d[l_ac].nmbt024_desc = g_nmbt2_d_t.nmbt024_desc
                  CALL anmt311_nmbt024_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt024_desc
            #add-point:ON CHANGE nmbt024_desc name="input.g.page2.nmbt024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt025
            #add-point:BEFORE FIELD nmbt025 name="input.b.page2.nmbt025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt025
            
            #add-point:AFTER FIELD nmbt025 name="input.a.page2.nmbt025"

            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt025)  THEN
              CALL anmt311_nmbt025_desc()
            END IF 
            #160331-00011#1 add -end
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt025
            #add-point:ON CHANGE nmbt025 name="input.g.page2.nmbt025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt025_desc
            #add-point:BEFORE FIELD nmbt025_desc name="input.b.page2.nmbt025_desc"
            LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d[l_ac].nmbt025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt025_desc
            
            #add-point:AFTER FIELD nmbt025_desc name="input.a.page2.nmbt025_desc"
            LET g_nmbt2_d[l_ac].nmbt025 = g_nmbt2_d[l_ac].nmbt025_desc
            CALL anmt311_nmbt025_desc() 
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt025) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt025
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'12',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt025) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt025 = g_nmbt2_d_o.nmbt025     
                     LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d_o.nmbt025_desc    
                     CALL anmt311_nmbt025_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'12',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt025) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt025 = g_nmbt2_d_o.nmbt025     
                     LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d_o.nmbt025_desc    
                     CALL anmt311_nmbt025_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
               ELSE
                  #檢查失敗時後續處理
                  #LET g_nmbt2_d[l_ac].nmbt025 = g_nmbt2_d_t.nmbt025   #160822-00012#5   mark
                  LET g_nmbt2_d[l_ac].nmbt025 = g_nmbt2_d_o.nmbt025    #160822-00012#5   add
                  #LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d_t.nmbt025_desc   #160822-00012#5   mark
                  LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d_o.nmbt025_desc    #160822-00012#5   add
                  CALL anmt311_nmbt025_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_nmbt_d_o.* = g_nmbt_d[l_ac].*   #160822-00012#5   add 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt025_desc
            #add-point:ON CHANGE nmbt025_desc name="input.g.page2.nmbt025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt026
            #add-point:BEFORE FIELD nmbt026 name="input.b.page2.nmbt026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt026
            
            #add-point:AFTER FIELD nmbt026 name="input.a.page2.nmbt026"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt026)  THEN
              CALL anmt311_nmbt026_desc()
            END IF 
            #160331-00011#1 add -end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt026
            #add-point:ON CHANGE nmbt026 name="input.g.page2.nmbt026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt026_desc
            #add-point:BEFORE FIELD nmbt026_desc name="input.b.page2.nmbt026_desc"
            LET g_nmbt2_d[l_ac].nmbt026_desc = g_nmbt2_d[l_ac].nmbt026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt026_desc
            
            #add-point:AFTER FIELD nmbt026_desc name="input.a.page2.nmbt026_desc"
            LET g_nmbt2_d[l_ac].nmbt026 = g_nmbt2_d[l_ac].nmbt026_desc
            CALL anmt311_nmbt026_desc()  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt026) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt026
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt026 = g_nmbt2_d_t.nmbt026
                  LET g_nmbt2_d[l_ac].nmbt026_desc = g_nmbt2_d_t.nmbt026_desc
                  CALL anmt311_nmbt026_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt026_desc
            #add-point:ON CHANGE nmbt026_desc name="input.g.page2.nmbt026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt027
            #add-point:BEFORE FIELD nmbt027 name="input.b.page2.nmbt027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt027
            
            #add-point:AFTER FIELD nmbt027 name="input.a.page2.nmbt027"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt027)  THEN
              CALL anmt311_nmbt027_desc()
            END IF 
            #160331-00011#1 add -end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt027
            #add-point:ON CHANGE nmbt027 name="input.g.page2.nmbt027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt027_desc
            #add-point:BEFORE FIELD nmbt027_desc name="input.b.page2.nmbt027_desc"
            LET g_nmbt2_d[l_ac].nmbt027_desc = g_nmbt2_d[l_ac].nmbt027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt027_desc
            
            #add-point:AFTER FIELD nmbt027_desc name="input.a.page2.nmbt027_desc"
            LET g_nmbt2_d[l_ac].nmbt027 = g_nmbt2_d[l_ac].nmbt027_desc
            CALL anmt311_nmbt027_desc()  
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt027) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt027 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'13',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt027) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt027 = g_nmbt2_d_t.nmbt027
                     LET g_nmbt2_d[l_ac].nmbt027_desc = g_nmbt2_d_t.nmbt027_desc
                     CALL anmt311_nmbt027_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'13',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt027) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt027 = g_nmbt2_d_t.nmbt027
                     LET g_nmbt2_d[l_ac].nmbt027_desc = g_nmbt2_d_t.nmbt027_desc
                     CALL anmt311_nmbt027_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---             
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt027 = g_nmbt2_d_t.nmbt027
                  LET g_nmbt2_d[l_ac].nmbt027_desc = g_nmbt2_d_t.nmbt027_desc
                  CALL anmt311_nmbt027_desc()
                  NEXT FIELD CURRENT
               END IF         
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt027_desc
            #add-point:ON CHANGE nmbt027_desc name="input.g.page2.nmbt027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt028
            #add-point:BEFORE FIELD nmbt028 name="input.b.page2.nmbt028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt028
            
            #add-point:AFTER FIELD nmbt028 name="input.a.page2.nmbt028"
            #160331-00011#1 add -str
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt028)  THEN
              CALL anmt311_nmbt028_desc()
            END IF 
            #160331-00011#1 add -end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt028
            #add-point:ON CHANGE nmbt028 name="input.g.page2.nmbt028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt028_desc
            #add-point:BEFORE FIELD nmbt028_desc name="input.b.page2.nmbt028_desc"
            LET g_nmbt2_d[l_ac].nmbt028_desc = g_nmbt2_d[l_ac].nmbt028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt028_desc
            
            #add-point:AFTER FIELD nmbt028_desc name="input.a.page2.nmbt028_desc"
            LET g_nmbt2_d[l_ac].nmbt028 = g_nmbt2_d[l_ac].nmbt028_desc
            CALL anmt311_nmbt028_desc() #161221-00054#3
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt028) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt027
               LET g_chkparam.arg2 = g_nmbt2_d[l_ac].nmbt028
            
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'14',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt028) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt028 = g_nmbt2_d_t.nmbt028
                     LET g_nmbt2_d[l_ac].nmbt028_desc = g_nmbt2_d_t.nmbt028_desc
                     CALL anmt311_nmbt028_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'14',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt028) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt028 = g_nmbt2_d_t.nmbt028
                     LET g_nmbt2_d[l_ac].nmbt028_desc = g_nmbt2_d_t.nmbt028_desc
                     CALL anmt311_nmbt028_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---             
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt028 = g_nmbt2_d_t.nmbt028
                  LET g_nmbt2_d[l_ac].nmbt028_desc = g_nmbt2_d_t.nmbt028_desc
                  CALL anmt311_nmbt028_desc()
                  NEXT FIELD CURRENT
               END IF         
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt028_desc
            #add-point:ON CHANGE nmbt028_desc name="input.g.page2.nmbt028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt031
            #add-point:BEFORE FIELD nmbt031 name="input.b.page2.nmbt031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt031
            
            #add-point:AFTER FIELD nmbt031 name="input.a.page2.nmbt031"
            #161221-00054#3 add s---
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt031) THEN 
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'09',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt031) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_nmbt2_d[l_ac].nmbt031 = g_nmbt2_d_t.nmbt031
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'09',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt032) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_nmbt2_d[l_ac].nmbt031 = g_nmbt2_d_t.nmbt031
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #161221-00054#3 add e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt031
            #add-point:ON CHANGE nmbt031 name="input.g.page2.nmbt031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt032
            #add-point:BEFORE FIELD nmbt032 name="input.b.page2.nmbt032"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt032
            
            #add-point:AFTER FIELD nmbt032 name="input.a.page2.nmbt032"
            
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt032) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt032  #渠道編號
               LET g_chkparam.arg2 = '1'  #渠道類型 
            
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oojd001") THEN
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'10',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt032_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                     CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                     DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'10',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt032_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                     CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                     DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---   
#161221-00054#3 mark s---                  
#                  CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
#                  DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
#161221-00054#3  mark e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                  CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                  DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                  NEXT FIELD CURRENT
               END IF     
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt032
            #add-point:ON CHANGE nmbt032 name="input.g.page2.nmbt032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt032_desc
            #add-point:BEFORE FIELD nmbt032_desc name="input.b.page2.nmbt032_desc"
            LET g_nmbt2_d[l_ac].nmbt032_desc = g_nmbt2_d[l_ac].nmbt032  #161221-00054#3 add 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt032_desc
            
            #add-point:AFTER FIELD nmbt032_desc name="input.a.page2.nmbt032_desc"
            #161221-00054#3 add s---
            LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d[l_ac].nmbt032_desc
            CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
            LET g_nmbt2_d[l_ac].nmbt032_desc = g_nmbt2_d_t.nmbt032 CLIPPED,g_nmbt2_d[l_ac].nmbt032_desc 
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc            
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt032) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbt2_d[l_ac].nmbt032  #渠道編號
               LET g_chkparam.arg2 = '1'  #渠道類型 
            
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oojd001") THEN
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'10',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt032) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                     CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                     DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'10',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt032) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                     CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                     DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---   
#161221-00054#3 mark s---                  
#                  CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
#                  DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
#161221-00054#3  mark e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt032 = g_nmbt2_d_t.nmbt032
                  CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
                  LET g_nmbt2_d[l_ac].nmbt032_desc = g_nmbt2_d_t.nmbt032 CLIPPED,g_nmbt2_d[l_ac].nmbt032_desc 
                  DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt032_desc
                  NEXT FIELD CURRENT
               END IF     
            END IF            
            #161221-00054#3 add e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt032_desc
            #add-point:ON CHANGE nmbt032_desc name="input.g.page2.nmbt032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt033
            #add-point:BEFORE FIELD nmbt033 name="input.b.page2.nmbt033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt033
            
            #add-point:AFTER FIELD nmbt033 name="input.a.page2.nmbt033"
           IF NOT cl_null(g_nmbt2_d[l_ac].nmbt033) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2002'  
               LET g_chkparam.arg2 = g_nmbt2_d[l_ac].nmbt033
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_01") THEN
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'11',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt033_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                     CALL anmt311_nmbt033_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'11',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt033_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                     CALL anmt311_nmbt033_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---               
#                  CALL anmt311_nmbt033_desc() #161221-00054#3 mark
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                   CALL anmt311_nmbt033_desc()
                  NEXT FIELD CURRENT
               END IF     
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt033
            #add-point:ON CHANGE nmbt033 name="input.g.page2.nmbt033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt033_desc
            #add-point:BEFORE FIELD nmbt033_desc name="input.b.page2.nmbt033_desc"
             LET g_nmbt2_d[l_ac].nmbt033_desc = g_nmbt2_d[l_ac].nmbt033  #161221-00054#3 add 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt033_desc
            
            #add-point:AFTER FIELD nmbt033_desc name="input.a.page2.nmbt033_desc"
            #161221-00054#3 add e---
            LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d[l_ac].nmbt033_desc   
            CALL anmt311_nmbt033_desc()
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt033) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2002'  
               LET g_chkparam.arg2 = g_nmbt2_d[l_ac].nmbt033
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_01") THEN
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'11',g_nmbt_d[l_ac].nmbt029,g_nmbt2_d[l_ac].nmbt033) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                     CALL anmt311_nmbt033_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_nmbs_m.nmbsld,'11',g_nmbt_d[l_ac].nmbt030,g_nmbt2_d[l_ac].nmbt033) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                     CALL anmt311_nmbt033_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---               
#                  CALL anmt311_nmbt033_desc() #161221-00054#3 mark
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbt2_d[l_ac].nmbt033 = g_nmbt2_d_t.nmbt033
                   CALL anmt311_nmbt033_desc()
                  NEXT FIELD CURRENT
               END IF     
            END IF
            #161221-00054#3 add e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt033_desc
            #add-point:ON CHANGE nmbt033_desc name="input.g.page2.nmbt033_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt034
            
            #add-point:AFTER FIELD nmbt034 name="input.a.page2.nmbt034"
            DISPLAY '' TO nmbt034_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt034) THEN
               CALL anmt311_free_account_chk(g_glad0171,g_nmbt2_d[l_ac].nmbt034,g_glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt034
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt034 = g_nmbt2_d_t.nmbt034
                  LET g_nmbt2_d[l_ac].nmbt034_desc = g_nmbt2_d_t.nmbt034_desc
                  CALL anmt311_free_account_desc()
                  DISPLAY g_nmbt2_d[l_ac].nmbt034_desc TO s_detail2[l_ac].nmbt034_desc
                  NEXT FIELD nmbt034
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt034_desc TO s_detail2[l_ac].nmbt034_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt034
            #add-point:BEFORE FIELD nmbt034 name="input.b.page2.nmbt034"
             #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0171
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt034
            #add-point:ON CHANGE nmbt034 name="input.g.page2.nmbt034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt034_desc
            #add-point:BEFORE FIELD nmbt034_desc name="input.b.page2.nmbt034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt034_desc
            
            #add-point:AFTER FIELD nmbt034_desc name="input.a.page2.nmbt034_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt034_desc
            #add-point:ON CHANGE nmbt034_desc name="input.g.page2.nmbt034_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt035
            
            #add-point:AFTER FIELD nmbt035 name="input.a.page2.nmbt035"
            DISPLAY '' TO nmbt035_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt035) THEN
               CALL anmt311_free_account_chk(g_glad0181,g_nmbt2_d[l_ac].nmbt035,g_glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt035
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt035 = g_nmbt2_d_t.nmbt035
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt035_desc
                  NEXT FIELD nmbt035
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt035_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt035
            #add-point:BEFORE FIELD nmbt035 name="input.b.page2.nmbt035"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0181
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0181
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt035
            #add-point:ON CHANGE nmbt035 name="input.g.page2.nmbt035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt035_desc
            #add-point:BEFORE FIELD nmbt035_desc name="input.b.page2.nmbt035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt035_desc
            
            #add-point:AFTER FIELD nmbt035_desc name="input.a.page2.nmbt035_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt035_desc
            #add-point:ON CHANGE nmbt035_desc name="input.g.page2.nmbt035_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt036
            
            #add-point:AFTER FIELD nmbt036 name="input.a.page2.nmbt036"
            DISPLAY '' TO nmbt036_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt036) THEN
               CALL anmt311_free_account_chk(g_glad0191,g_nmbt2_d[l_ac].nmbt036,g_glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt036
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt036= g_nmbt2_d_t.nmbt036
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt036_desc
                  NEXT FIELD nmbt036
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt036_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt036
            #add-point:BEFORE FIELD nmbt036 name="input.b.page2.nmbt036"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0191
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0191
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt036
            #add-point:ON CHANGE nmbt036 name="input.g.page2.nmbt036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt036_desc
            #add-point:BEFORE FIELD nmbt036_desc name="input.b.page2.nmbt036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt036_desc
            
            #add-point:AFTER FIELD nmbt036_desc name="input.a.page2.nmbt036_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt036_desc
            #add-point:ON CHANGE nmbt036_desc name="input.g.page2.nmbt036_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt037
            
            #add-point:AFTER FIELD nmbt037 name="input.a.page2.nmbt037"
            DISPLAY '' TO nmbt037_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt037) THEN
               CALL anmt311_free_account_chk(g_glad0201,g_nmbt2_d[l_ac].nmbt037,g_glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt037
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt037= g_nmbt2_d_t.nmbt037
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt037_desc
                  NEXT FIELD nmbt037
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt037_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt037
            #add-point:BEFORE FIELD nmbt037 name="input.b.page2.nmbt037"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0201
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0201
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt037
            #add-point:ON CHANGE nmbt037 name="input.g.page2.nmbt037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt037_desc
            #add-point:BEFORE FIELD nmbt037_desc name="input.b.page2.nmbt037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt037_desc
            
            #add-point:AFTER FIELD nmbt037_desc name="input.a.page2.nmbt037_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt037_desc
            #add-point:ON CHANGE nmbt037_desc name="input.g.page2.nmbt037_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt038
            
            #add-point:AFTER FIELD nmbt038 name="input.a.page2.nmbt038"
            DISPLAY '' TO nmbt038_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt038) THEN
               CALL anmt311_free_account_chk(g_glad0211,g_nmbt2_d[l_ac].nmbt038,g_glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt038
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt038= g_nmbt2_d_t.nmbt038
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt038_desc
                  NEXT FIELD nmbt038
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt038_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt038
            #add-point:BEFORE FIELD nmbt038 name="input.b.page2.nmbt038"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0211
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0211
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt038
            #add-point:ON CHANGE nmbt038 name="input.g.page2.nmbt038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt038_desc
            #add-point:BEFORE FIELD nmbt038_desc name="input.b.page2.nmbt038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt038_desc
            
            #add-point:AFTER FIELD nmbt038_desc name="input.a.page2.nmbt038_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt038_desc
            #add-point:ON CHANGE nmbt038_desc name="input.g.page2.nmbt038_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt039
            
            #add-point:AFTER FIELD nmbt039 name="input.a.page2.nmbt039"
            DISPLAY '' TO nmbt039_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt039) THEN
               CALL anmt311_free_account_chk(g_glad0221,g_nmbt2_d[l_ac].nmbt039,g_glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt039
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt039= g_nmbt2_d_t.nmbt039
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt039_desc
                  NEXT FIELD nmbt039
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt039_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt039
            #add-point:BEFORE FIELD nmbt039 name="input.b.page2.nmbt039"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0221
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0221
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt039
            #add-point:ON CHANGE nmbt039 name="input.g.page2.nmbt039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt039_desc
            #add-point:BEFORE FIELD nmbt039_desc name="input.b.page2.nmbt039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt039_desc
            
            #add-point:AFTER FIELD nmbt039_desc name="input.a.page2.nmbt039_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt039_desc
            #add-point:ON CHANGE nmbt039_desc name="input.g.page2.nmbt039_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt040
            
            #add-point:AFTER FIELD nmbt040 name="input.a.page2.nmbt040"
            DISPLAY '' TO nmbt040_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt040) THEN
               CALL anmt311_free_account_chk(g_glad0231,g_nmbt2_d[l_ac].nmbt040,g_glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt040
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt040= g_nmbt2_d_t.nmbt040
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt040_desc
                  NEXT FIELD nmbt040
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt040_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt040
            #add-point:BEFORE FIELD nmbt040 name="input.b.page2.nmbt040"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0231
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0231
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt040
            #add-point:ON CHANGE nmbt040 name="input.g.page2.nmbt040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt040_desc
            #add-point:BEFORE FIELD nmbt040_desc name="input.b.page2.nmbt040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt040_desc
            
            #add-point:AFTER FIELD nmbt040_desc name="input.a.page2.nmbt040_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt040_desc
            #add-point:ON CHANGE nmbt040_desc name="input.g.page2.nmbt040_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt041
            
            #add-point:AFTER FIELD nmbt041 name="input.a.page2.nmbt041"
            DISPLAY '' TO nmbt041_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt041) THEN
               CALL anmt311_free_account_chk(g_glad0241,g_nmbt2_d[l_ac].nmbt041,g_glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt041
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt041= g_nmbt2_d_t.nmbt041
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt041_desc
                  NEXT FIELD nmbt041
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt041_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt041
            #add-point:BEFORE FIELD nmbt041 name="input.b.page2.nmbt041"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0241
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0241
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt041
            #add-point:ON CHANGE nmbt041 name="input.g.page2.nmbt041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt041_desc
            #add-point:BEFORE FIELD nmbt041_desc name="input.b.page2.nmbt041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt041_desc
            
            #add-point:AFTER FIELD nmbt041_desc name="input.a.page2.nmbt041_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt041_desc
            #add-point:ON CHANGE nmbt041_desc name="input.g.page2.nmbt041_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt042
            
            #add-point:AFTER FIELD nmbt042 name="input.a.page2.nmbt042"
            DISPLAY '' TO nmbt042_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt042) THEN
               CALL anmt311_free_account_chk(g_glad0251,g_nmbt2_d[l_ac].nmbt042,g_glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt042
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt042= g_nmbt2_d_t.nmbt042
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt042_desc
                  NEXT FIELD nmbt042
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt042_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt042
            #add-point:BEFORE FIELD nmbt042 name="input.b.page2.nmbt042"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0251
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0251
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt042
            #add-point:ON CHANGE nmbt042 name="input.g.page2.nmbt042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt042_desc
            #add-point:BEFORE FIELD nmbt042_desc name="input.b.page2.nmbt042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt042_desc
            
            #add-point:AFTER FIELD nmbt042_desc name="input.a.page2.nmbt042_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt042_desc
            #add-point:ON CHANGE nmbt042_desc name="input.g.page2.nmbt042_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt043
            
            #add-point:AFTER FIELD nmbt043 name="input.a.page2.nmbt043"
            DISPLAY '' TO nmbt043_desc
            IF NOT cl_null(g_nmbt2_d[l_ac].nmbt043) THEN
               CALL anmt311_free_account_chk(g_glad0261,g_nmbt2_d[l_ac].nmbt043,g_glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_nmbt2_d[l_ac].nmbt043
                  #160318-00005#27 by 07900 --add--str
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname("agli041",g_lang,"2")
                  LET g_errparam.exeprog ='agli041'
                  #160318-00005#27 by 07900 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbt2_d[l_ac].nmbt043= g_nmbt2_d_t.nmbt043
                  CALL anmt311_free_account_desc()
                  DISPLAY BY NAME  g_nmbt2_d[l_ac].nmbt043_desc
                  NEXT FIELD nmbt043
               END IF
            END IF
            CALL anmt311_free_account_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt043_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt043
            #add-point:BEFORE FIELD nmbt043 name="input.b.page2.nmbt043"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0261
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0261
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt043
            #add-point:ON CHANGE nmbt043 name="input.g.page2.nmbt043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbt043_desc
            #add-point:BEFORE FIELD nmbt043_desc name="input.b.page2.nmbt043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbt043_desc
            
            #add-point:AFTER FIELD nmbt043_desc name="input.a.page2.nmbt043_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbt043_desc
            #add-point:ON CHANGE nmbt043_desc name="input.g.page2.nmbt043_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.nmbt018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt018
            #add-point:ON ACTION controlp INFIELD nmbt018 name="input.c.page2.nmbt018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt018           #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            #161221-00054#3 add s---
            #agli060设置的部門限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld, '02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt018 = g_qryparam.return1              
            CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt018 TO nmbt018
            DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO nmbt018_desc              #
            NEXT FIELD nmbt018                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt018_desc
            #add-point:ON ACTION controlp INFIELD nmbt018_desc name="input.c.page2.nmbt018_desc"
            #此段落由子樣板a07產生            
            #開窗i段 
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt018_desc           #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            #161221-00054#3 add s---
            #agli060设置的部門限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld, '02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt018 = g_qryparam.return1              
            CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt018 TO nmbt018
            DISPLAY g_nmbt2_d[l_ac].nmbt018_desc TO nmbt018_desc              #
            NEXT FIELD nmbt018_desc                          #返回原欄位            
            #161221-00054#3 add e---            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt019
            #add-point:ON ACTION controlp INFIELD nmbt019 name="input.c.page2.nmbt019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt019             #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today

            #161221-00054#3 add s---
            #agli060设置的責任中心限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt019 = g_qryparam.return1              
            CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt019 TO nmbt019
            DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO nmbt019_desc           
            NEXT FIELD nmbt019

            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt019_desc
            #add-point:ON ACTION controlp INFIELD nmbt019_desc name="input.c.page2.nmbt019_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt019_desc             #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today

            #161221-00054#3 add s---
            #agli060设置的責任中心限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt019 = g_qryparam.return1              
            CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt019 TO nmbt019
            DISPLAY g_nmbt2_d[l_ac].nmbt019_desc TO nmbt019_desc           
            NEXT FIELD nmbt019_desc            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt020
            #add-point:ON ACTION controlp INFIELD nmbt020 name="input.c.page2.nmbt020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt020             #給予default值
            LET g_qryparam.default2 = "" #g_nmbt2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '287'
            
            #161221-00054#3 add s---
            #agli060设置的區域限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt020 = g_qryparam.return1              
            CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt020 TO nmbt020
            DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO nmbt020_desc            
            NEXT FIELD nmbt020
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt020_desc
            #add-point:ON ACTION controlp INFIELD nmbt020_desc name="input.c.page2.nmbt020_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt020_desc             #給予default值
            LET g_qryparam.default2 = "" #g_nmbt2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '287'
            
            #161221-00054#3 add s---
            #agli060设置的區域限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt020 = g_qryparam.return1              
            CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt020 TO nmbt020
            DISPLAY g_nmbt2_d[l_ac].nmbt020_desc TO nmbt020_desc            
            NEXT FIELD nmbt020_desc            
            #161221-00054#3 add e---           
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt021
            #add-point:ON ACTION controlp INFIELD nmbt021 name="input.c.page2.nmbt021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的交易客商限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e--- 
            
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      

            LET g_nmbt2_d[l_ac].nmbt021 = g_qryparam.return1              
            CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc 
            DISPLAY g_nmbt2_d[l_ac].nmbt021 TO nmbt021
            DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO nmbt021_desc              #
            NEXT FIELD nmbt021
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt021_desc
            #add-point:ON ACTION controlp INFIELD nmbt021_desc name="input.c.page2.nmbt021_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt021_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的交易客商限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e--- 
            
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      

            LET g_nmbt2_d[l_ac].nmbt021 = g_qryparam.return1              
            CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc 
            DISPLAY g_nmbt2_d[l_ac].nmbt021 TO nmbt021
            DISPLAY g_nmbt2_d[l_ac].nmbt021_desc TO nmbt021_desc              #
            NEXT FIELD nmbt021_desc            
            #161221-00054#3 add e---            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt022
            #add-point:ON ACTION controlp INFIELD nmbt022 name="input.c.page2.nmbt022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            #161221-00054#3 add s---
            #agli060设置的账款客商限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      

            LET g_nmbt2_d[l_ac].nmbt022 = g_qryparam.return1              
            CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt022 TO nmbt022
            DISPLAY g_nmbt2_d[l_ac].nmbt022_desc TO nmbt022_desc              #
            NEXT FIELD nmbt022
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt022_desc
            #add-point:ON ACTION controlp INFIELD nmbt022_desc name="input.c.page2.nmbt022_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt022_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            #161221-00054#3 add s---
            #agli060设置的账款客商限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      

            LET g_nmbt2_d[l_ac].nmbt022 = g_qryparam.return1              
            CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt022 TO nmbt022
            DISPLAY g_nmbt2_d[l_ac].nmbt022_desc TO nmbt022_desc              #
            NEXT FIELD nmbt022_desc            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt023
            #add-point:ON ACTION controlp INFIELD nmbt023 name="input.c.page2.nmbt023"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt023             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'

            #161221-00054#3 add s ---
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---  
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt023 = g_qryparam.return1              
            CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt023 TO nmbt023
            DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO nmbt023_desc              #

            NEXT FIELD nmbt023                  #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt023_desc
            #add-point:ON ACTION controlp INFIELD nmbt023_desc name="input.c.page2.nmbt023_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt023_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'

            #161221-00054#3 add s ---
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---  
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt023 = g_qryparam.return1              
            CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt023 TO nmbt023
            DISPLAY g_nmbt2_d[l_ac].nmbt023_desc TO nmbt023_desc              #

            NEXT FIELD nmbt023_desc                  #返回原欄位            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt024
            #add-point:ON ACTION controlp INFIELD nmbt024 name="input.c.page2.nmbt024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的產品類別限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'08',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_rtax001_1()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt024 = g_qryparam.return1              
            CALL anmt311_nmbt024_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt024 TO nmbt024
            DISPLAY g_nmbt2_d[l_ac].nmbt024_desc TO nmbt024_desc              #

            NEXT FIELD nmbt024                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt024_desc
            #add-point:ON ACTION controlp INFIELD nmbt024_desc name="input.c.page2.nmbt024_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt024_desc #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的產品類別限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'08',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_rtax001_1()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt024 = g_qryparam.return1              
            CALL anmt311_nmbt024_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt024 TO nmbt024
            DISPLAY g_nmbt2_d[l_ac].nmbt024_desc TO nmbt024_desc              #

            NEXT FIELD nmbt024_desc                         #返回原欄位            
            #161221-00054#3 add e---             
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt025
            #add-point:ON ACTION controlp INFIELD nmbt025 name="input.c.page2.nmbt025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt025             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的人員限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---       
            
            CALL q_ooag001_2()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt025 = g_qryparam.return1              
            CALL anmt311_nmbt025_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt025 TO nmbt025
            DISPLAY g_nmbt2_d[l_ac].nmbt025_desc TO nmbt025_desc              #

            NEXT FIELD nmbt025                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt025_desc
            #add-point:ON ACTION controlp INFIELD nmbt025_desc name="input.c.page2.nmbt025_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt025_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的人員限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---       
            
            CALL q_ooag001_2()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt025 = g_qryparam.return1              
            CALL anmt311_nmbt025_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt025 TO nmbt025
            DISPLAY g_nmbt2_d[l_ac].nmbt025_desc TO nmbt025_desc              #

            NEXT FIELD nmbt025_desc                          #返回原欄位            
            #161221-00054#3 add e---          
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt026
            #add-point:ON ACTION controlp INFIELD nmbt026 name="input.c.page2.nmbt026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bgaa001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt026 = g_qryparam.return1              
            CALL anmt311_nmbt026_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt026 TO nmbt026
            DISPLAY g_nmbt2_d[l_ac].nmbt026_desc TO nmbt026_desc              #

            NEXT FIELD nmbt026                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt026_desc
            #add-point:ON ACTION controlp INFIELD nmbt026_desc name="input.c.page2.nmbt026_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt026_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_bgaa001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt026 = g_qryparam.return1              
            CALL anmt311_nmbt026_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt026 TO nmbt026
            DISPLAY g_nmbt2_d[l_ac].nmbt026_desc TO nmbt026_desc              #

            NEXT FIELD nmbt026_desc                          #返回原欄位            
            #161221-00054#3 add e---            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt027
            #add-point:ON ACTION controlp INFIELD nmbt027 name="input.c.page2.nmbt027"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的專案代號限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_pjba001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt027 = g_qryparam.return1              
            CALL anmt311_nmbt027_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt027 TO nmbt027
            DISPLAY g_nmbt2_d[l_ac].nmbt027_desc TO nmbt027_desc              #

            NEXT FIELD nmbt027                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt027_desc
            #add-point:ON ACTION controlp INFIELD nmbt027_desc name="input.c.page2.nmbt027_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt027_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161221-00054#3 add s---
            #agli060设置的專案代號限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_pjba001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt027 = g_qryparam.return1              
            CALL anmt311_nmbt027_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt027 TO nmbt027
            DISPLAY g_nmbt2_d[l_ac].nmbt027_desc TO nmbt027_desc              #

            NEXT FIELD nmbt027_desc                          #返回原欄位            
            #161221-00054#3 add e---           
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt028
            #add-point:ON ACTION controlp INFIELD nmbt028 name="input.c.page2.nmbt028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmbt2_d[l_ac].nmbt027
            
            #161221-00054#3 add s---
            #agli060设置的WBS限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt028 = g_qryparam.return1              
            CALL anmt311_nmbt028_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt028 TO nmbt028
            DISPLAY g_nmbt2_d[l_ac].nmbt028_desc TO nmbt028_desc              #

            NEXT FIELD nmbt028
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt028_desc
            #add-point:ON ACTION controlp INFIELD nmbt028_desc name="input.c.page2.nmbt028_desc"
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt028_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmbt2_d[l_ac].nmbt027
            
            #161221-00054#3 add s---
            #agli060设置的WBS限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt028 = g_qryparam.return1              
            CALL anmt311_nmbt028_desc()
            DISPLAY g_nmbt2_d[l_ac].nmbt028 TO nmbt028
            DISPLAY g_nmbt2_d[l_ac].nmbt028_desc TO nmbt028_desc              #

            NEXT FIELD nmbt028_desc            
            #161221-00054#3 add e---            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt031
            #add-point:ON ACTION controlp INFIELD nmbt031 name="input.c.page2.nmbt031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt032
            #add-point:ON ACTION controlp INFIELD nmbt032 name="input.c.page2.nmbt032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #

            #161221-00054#3 add s---
            #agli060设置的渠道限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_oojd001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt032 = g_qryparam.return1              

            DISPLAY g_nmbt2_d[l_ac].nmbt032 TO nmbt032              #

            NEXT FIELD nmbt032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt032_desc
            #add-point:ON ACTION controlp INFIELD nmbt032_desc name="input.c.page2.nmbt032_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt032_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #

            #161221-00054#3 add s---
            #agli060设置的渠道限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---
            
            CALL q_oojd001()                                #呼叫開窗

            LET g_nmbt2_d[l_ac].nmbt032 = g_qryparam.return1
            CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc
            LET g_nmbt2_d[l_ac].nmbt032_desc = g_nmbt2_d[l_ac].nmbt032,g_nmbt2_d[l_ac].nmbt032_desc
            DISPLAY g_nmbt2_d[l_ac].nmbt032 TO nmbt032
            DISPLAY g_nmbt2_d[l_ac].nmbt032_desc TO nmbt032_desc
            NEXT FIELD nmbt032_desc           
            #161221-00054#3 add e--- 



            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt033
            #add-point:ON ACTION controlp INFIELD nmbt033 name="input.c.page2.nmbt033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt033
            #LET g_qryparam.arg1 = "2002" #150714-00024#1 mark
            #CALL q_oocq002()             #150714-00024#1 mark
            #161221-00054#3 add ------
            #agli060设置的品牌限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add end---            
            CALL q_oocq002_2002()         #150714-00024#1
            LET g_nmbt2_d[l_ac].nmbt033 = g_qryparam.return1
            DISPLAY g_nmbt2_d[l_ac].nmbt033 TO nmbt033
            NEXT FIELD nmbt033
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt033_desc
            #add-point:ON ACTION controlp INFIELD nmbt033_desc name="input.c.page2.nmbt033_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #161221-00054#3 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt033_desc
            #LET g_qryparam.arg1 = "2002" #150714-00024#1 mark
            #CALL q_oocq002()             #150714-00024#1 mark
            #161221-00054#3 add ------
            #agli060设置的品牌限制条件
            CALL s_voucher_get_glak_sql(g_nmbs_m.nmbsld,'11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add end---            
            CALL q_oocq002_2002()         #150714-00024#1
            LET g_nmbt2_d[l_ac].nmbt033 = g_qryparam.return1
            CALL anmt311_nmbt033_desc()
            DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt033_desc
            NEXT FIELD nmbt033_desc            
            #161221-00054#3 add e--- 



            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt034
            #add-point:ON ACTION controlp INFIELD nmbt034 name="input.c.page2.nmbt034"
           IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt034
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt034 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt034 TO nmbt034              #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt034_desc TO nmbt034_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt034                          #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt034_desc
            #add-point:ON ACTION controlp INFIELD nmbt034_desc name="input.c.page2.nmbt034_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt035
            #add-point:ON ACTION controlp INFIELD nmbt035 name="input.c.page2.nmbt035"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt035
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where ="glaf001 = '",g_glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt035 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt035 TO nmbt035             #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt035_desc TO nmbt035_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt035                          #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt035_desc
            #add-point:ON ACTION controlp INFIELD nmbt035_desc name="input.c.page2.nmbt035_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt036
            #add-point:ON ACTION controlp INFIELD nmbt036 name="input.c.page2.nmbt036"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt036
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt036 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt036 TO nmbt036             #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt036_desc TO nmbt036_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt036                          #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt036_desc
            #add-point:ON ACTION controlp INFIELD nmbt036_desc name="input.c.page2.nmbt036_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt037
            #add-point:ON ACTION controlp INFIELD nmbt037 name="input.c.page2.nmbt037"
             IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt037
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt037 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt037 TO nmbt037             #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt037_desc TO nmbt037_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt037                         #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt037_desc
            #add-point:ON ACTION controlp INFIELD nmbt037_desc name="input.c.page2.nmbt037_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt038
            #add-point:ON ACTION controlp INFIELD nmbt038 name="input.c.page2.nmbt038"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt038
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt038 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt038 TO nmbt038           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt038_desc TO nmbt038_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt038                        #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt038_desc
            #add-point:ON ACTION controlp INFIELD nmbt038_desc name="input.c.page2.nmbt038_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt039
            #add-point:ON ACTION controlp INFIELD nmbt039 name="input.c.page2.nmbt039"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt039
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt039 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt039 TO nmbt039           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt039_desc TO nmbt039_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt039                        #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt039_desc
            #add-point:ON ACTION controlp INFIELD nmbt039_desc name="input.c.page2.nmbt039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt040
            #add-point:ON ACTION controlp INFIELD nmbt040 name="input.c.page2.nmbt040"
           IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt040
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt040 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt040 TO nmbt040           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt040_desc TO nmbt040_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt040                        #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt040_desc
            #add-point:ON ACTION controlp INFIELD nmbt040_desc name="input.c.page2.nmbt040_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt041
            #add-point:ON ACTION controlp INFIELD nmbt041 name="input.c.page2.nmbt041"
             IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt041
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt041 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt041 TO nmbt041           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt041_desc TO nmbt041_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt041                      #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt041_desc
            #add-point:ON ACTION controlp INFIELD nmbt041_desc name="input.c.page2.nmbt041_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt042
            #add-point:ON ACTION controlp INFIELD nmbt042 name="input.c.page2.nmbt042"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt042
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt042 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt042 TO nmbt042           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt042_desc TO nmbt042_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt042                     #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt042_desc
            #add-point:ON ACTION controlp INFIELD nmbt042_desc name="input.c.page2.nmbt042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt043
            #add-point:ON ACTION controlp INFIELD nmbt043 name="input.c.page2.nmbt043"
            #此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmbt2_d[l_ac].nmbt043
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明

               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗

               LET g_nmbt2_d[l_ac].nmbt043 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL anmt311_free_account_desc()
               DISPLAY g_nmbt2_d[l_ac].nmbt043 TO nmbt043           #顯示到畫面上
               DISPLAY g_nmbt2_d[l_ac].nmbt043_desc TO nmbt043_desc
               LET g_qryparam.where = ''
               NEXT FIELD nmbt043                     #返回原欄位
            END IF


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbt043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbt043_desc
            #add-point:ON ACTION controlp INFIELD nmbt043_desc name="input.c.page2.nmbt043_desc"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbt2_d[l_ac].* = g_nmbt2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt311_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt311_unlock_b("nmbt_t","'2'")
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
               LET g_nmbt_d[li_reproduce_target].* = g_nmbt_d[li_reproduce].*
               LET g_nmbt2_d[li_reproduce_target].* = g_nmbt2_d[li_reproduce].*
               LET g_nmbt3_d[li_reproduce_target].* = g_nmbt3_d[li_reproduce].*
 
               LET g_nmbt2_d[li_reproduce_target].nmbtseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbt2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbt2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_nmbt3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL anmt311_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL anmt311_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="anmt311.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD nmbssite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmbtseq
               WHEN "s_detail2"
                  NEXT FIELD nmbtseq_2
               WHEN "s_detail3"
                  NEXT FIELD nmbtseq_3
 
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','3',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD nmbsld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmbtseq
               WHEN "s_detail2"
                  NEXT FIELD nmbtseq_2
               WHEN "s_detail3"
                  NEXT FIELD nmbtseq_3
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
END WHILE

   #151201-00003#2--add--str--
   CALL cl_err_collect_init()
   #檢查收支單拆單后，總金額是否等於單據+項次的金額
   LET l_sql="SELECT nmbt002,nmbt003,nmbt004,SUM(nmbt103),SUM(nmbt113),SUM(nmbt123),SUM(nmbt133) ", #151224-00022#1 add nmbt004
             "  FROM nmbt_t",
             " WHERE nmbtent=",g_enterprise," AND nmbtld='",g_nmbs_m.nmbsld,"'",
             "   AND nmbtdocno='",g_nmbs_m.nmbsdocno,"'",
             "   AND nmbt001='3' AND nmbt002 IS NOT NULL AND nmbt003 IS NOT NULL",
             " GROUP BY nmbt002,nmbt003,nmbt004"  #151224-00022#1 add nmbt004
   PREPARE anmt311_amt_chk_pr FROM l_sql
   DECLARE anmt311_amt_chk_cs CURSOR FOR anmt311_amt_chk_pr
   FOREACH anmt311_amt_chk_cs INTO l_nmbbdocno,l_nmbbseq,l_nmbt004,l_nmbt103,l_nmbt113,l_nmbt123,l_nmbt133 #151224-00022#1 add l_nmbt004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:anmt311_amt_chk_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF cl_null(l_nmbt103) THEN LET l_nmbt103=0 END IF
      IF cl_null(l_nmbt113) THEN LET l_nmbt113=0 END IF      
      #抓取收支單單號+項次對應的金額
      LET l_nmbb006 = 0
      LET l_nmbb007 = 0
      LET l_nmbb013 = 0
      LET l_nmbb017 = 0
      SELECT nmbb006,nmbb007,nmbb013,nmbb017 
        INTO l_nmbb006,l_nmbb007,l_nmbb013,l_nmbb017 
        FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbcomp=g_nmbs_m.nmbscomp
         AND nmbbdocno = l_nmbbdocno AND nmbbseq = l_nmbbseq
      IF cl_null(l_nmbb006) THEN LET l_nmbb006=0 END IF
      IF cl_null(l_nmbb007) THEN LET l_nmbb007=0 END IF
      #原幣金額
      IF l_nmbt103 <> l_nmbb006 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_nmbbdocno,"|",l_nmbbseq
         LET g_errparam.code   = 'anm-00375' 
         LET g_errparam.replace[1] = l_nmbt103
         LET g_errparam.replace[2] = l_nmbb006
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      #本幣金額
      IF l_nmbt113 <> l_nmbb007 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_nmbbdocno,"|",l_nmbbseq
         LET g_errparam.code   = 'anm-00376' 
         LET g_errparam.replace[1] = l_nmbt113
         LET g_errparam.replace[2] = l_nmbb007
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      #本位幣二
      IF g_glaa015 = 'Y' THEN
         IF cl_null(l_nmbt123) THEN LET l_nmbt123=0 END IF
         IF cl_null(l_nmbb013) THEN LET l_nmbb013=0 END IF
         IF l_nmbt123 <> l_nmbb013 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_nmbbdocno,"|",l_nmbbseq
            LET g_errparam.code   = 'anm-00377' 
            LET g_errparam.replace[1] = l_nmbt123
            LET g_errparam.replace[2] = l_nmbb013
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      END IF
      #本位幣三
      IF g_glaa019 = 'Y' THEN
         IF cl_null(l_nmbt133) THEN LET l_nmbt133=0 END IF
         IF cl_null(l_nmbb017) THEN LET l_nmbb017=0 END IF
         IF l_nmbt133 <> l_nmbb017 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_nmbbdocno,"|",l_nmbbseq
            LET g_errparam.code   = 'anm-00378' 
            LET g_errparam.replace[1] = l_nmbt133
            LET g_errparam.replace[2] = l_nmbb017
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      END IF
   END FOREACH
   #160908-00015#1 mark--s
   ##檢查存入+借方與提出+貸方金額是否平
   #LET l_nmbt103 = 0
   #LET l_nmbt113 = 0
   #LET l_nmbt123 = 0
   #LET l_nmbt133 = 0
   #LET l_nmbt103_c = 0
   #LET l_nmbt113_c = 0
   #LET l_nmbt123_c = 0
   #LET l_nmbt133_c = 0
   ##存入+借方
   #SELECT SUM(nmbt103),SUM(nmbt113),SUM(nmbt123),SUM(nmbt133)
   #  INTO l_nmbt103,l_nmbt113,l_nmbt123,l_nmbt133
   #  FROM nmbt_t
   # WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
   #   AND nmbtdocno=g_nmbs_m.nmbsdocno
   #   AND nmbt004 IN ('1','3')
   ##提出+貸方
   #SELECT SUM(nmbt103),SUM(nmbt113),SUM(nmbt123),SUM(nmbt133)
   #  INTO l_nmbt103_c,l_nmbt113_c,l_nmbt123_c,l_nmbt133_c
   #  FROM nmbt_t
   # WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
   #   AND nmbtdocno=g_nmbs_m.nmbsdocno
   #   AND nmbt004 IN ('2','4')  
   #IF cl_null(l_nmbt103) THEN LET l_nmbt103=0 END IF
   #IF cl_null(l_nmbt113) THEN LET l_nmbt113=0 END IF
   #IF cl_null(l_nmbt103_c) THEN LET l_nmbt103_c=0 END IF
   #IF cl_null(l_nmbt113_c) THEN LET l_nmbt113_c=0 END IF
   ##本幣金額
   #IF l_nmbt113 <> l_nmbt113_c THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = g_nmbs_m.nmbsdocno
   #   LET g_errparam.code   = 'anm-00380' 
   #   LET g_errparam.replace[1] = l_nmbt113
   #   LET g_errparam.replace[2] = l_nmbt113_c
   #   LET g_errparam.popup  = TRUE 
   #   CALL cl_err()
   #END IF
   ##本位幣二
   #IF g_glaa015 = 'Y' THEN
   #   IF cl_null(l_nmbt123) THEN LET l_nmbt123=0 END IF
   #   IF cl_null(l_nmbt123_c) THEN LET l_nmbt123_c=0 END IF
   #   IF l_nmbt123 <> l_nmbt123_c THEN
   #      INITIALIZE g_errparam TO NULL 
   #      LET g_errparam.extend = g_nmbs_m.nmbsdocno
   #      LET g_errparam.code   = 'anm-00381' 
   #      LET g_errparam.replace[1] = l_nmbt123
   #      LET g_errparam.replace[2] = l_nmbt123_c
   #      LET g_errparam.popup  = TRUE 
   #      CALL cl_err()
   #   END IF
   #END IF
   ##本位幣三
   #IF g_glaa015 = 'Y' THEN
   #   IF cl_null(l_nmbt133) THEN LET l_nmbt133=0 END IF
   #   IF cl_null(l_nmbt133_c) THEN LET l_nmbt133_c=0 END IF
   #   IF l_nmbt133 <> l_nmbt133_c THEN
   #      INITIALIZE g_errparam TO NULL 
   #      LET g_errparam.extend = g_nmbs_m.nmbsdocno
   #      LET g_errparam.code   = 'anm-00382' 
   #      LET g_errparam.replace[1] = l_nmbt133
   #      LET g_errparam.replace[2] = l_nmbt133_c
   #      LET g_errparam.popup  = TRUE 
   #      CALL cl_err()
   #   END IF
   #END IF
   #160908-00015#1 mark--e
   CALL cl_err_collect_show()
   #151201-00003#2--add--end
   
  #140829-00070#30 15/01/13 Add
   IF NOT INT_FLAG THEN
      CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_nmbs_m.nmbsld
      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_transaction_begin()
         CALL s_pre_voucher_ins('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,'1') RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N',0)
         ELSE                                #141106-00011#22
            CALL s_transaction_end('Y',0)    #141106-00011#22
         END IF
      END IF
   END IF
  #140829-00070#30 15/01/13 Add
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt311_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003 
   DEFINE l_dfin0030             LIKE ooac_t.ooac004   #140829-00070#30 15/01/13 Add
   DEFINE l_ooba002              LIKE ooba_t.ooba002   #140829-00070#30 15/01/13 Add
   DEFINE l_glaa121              LIKE glaa_t.glaa121   #140829-00070#30 15/01/13 Add
   DEFINE l_success              LIKE type_t.num5      #140829-00070#30 15/01/13 Add
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_nmbs_m.nmbsstus <> 'N' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)   
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)  
   END IF
   CALL anmt311_show_ref()
   CALL anmt311_visible()
   IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible("s_detail3",FALSE)
   ELSE
      CALL cl_set_comp_visible("s_detail3",TRUE)   
   END IF
  
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt311_b_fill() #單身填充
      CALL anmt311_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt311_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbsld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbsld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbsld_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbscomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbscomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbscomp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbsownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbsownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbsownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbsowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbsowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbsowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbscrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbscrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbscrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbscrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbscrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbscrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbsmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbsmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbsmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbs_m.nmbscnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_nmbs_m.nmbscnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbs_m.nmbscnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_nmbs_m_mask_o.* =  g_nmbs_m.*
   CALL anmt311_nmbs_t_mask()
   LET g_nmbs_m_mask_n.* =  g_nmbs_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbscomp_desc, 
       g_nmbs_m.nmbscomp,g_nmbs_m.glaa001,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003, 
       g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp, 
       g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdp_desc, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid, 
       g_nmbs_m.nmbscnfid_desc,g_nmbs_m.nmbscnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbs_m.nmbsstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_nmbt_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#2015/6/25--by--02599--mark--str--
#   #根据業務單號+項次賦值 nmbt029,nmbt030
#      IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
#         LET l_nmbb002 = ''
#         LET l_nmbb003 = ''
#         SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
#         FROM nmbb_t
#         WHERE nmbbent = g_enterprise
#         AND nmbbcomp = g_nmbs_m.nmbscomp
#         AND nmbbdocno = g_nmbt_d[l_ac].nmbt002
#         AND nmbbseq = g_nmbt_d[l_ac].nmbt003
#         
#         IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN
#            SELECT DISTINCT glab006 INTO g_nmbt_d[l_ac].nmbt029  #anmi171
#              FROM glab_t
#             WHERE glabent = g_enterprise
#               AND glabld  = g_nmbs_m.nmbsld
#               AND glab001 = '43'
#               AND glab002 = '43'
#               AND glab003 = l_nmbb002
#         ELSE
#            SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi121
#            FROM glab_t
#           WHERE glabent = g_enterprise
#             AND glabld  = g_nmbs_m.nmbsld
#             AND glab001 = '40'
#             AND glab002 = '40'
#             AND glab003 = l_nmbb003
#         END IF 
#        #对方科目
#        SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt030  #anmi171
#        FROM glab_t,nmbb_t
#       WHERE glabent = g_enterprise
#         AND glabld  = g_nmbs_m.nmbsld
#         AND glab001 = '43'
#         AND glab002 = '43'
#         AND glab003 = l_nmbb002
#         DISPLAY g_nmbt_d[l_ac].nmbt029  TO s_detail1[l_ac].nmbt029  
#         DISPLAY g_nmbt_d[l_ac].nmbt030  TO s_detail1[l_ac].nmbt030
#         CALL anmt311_nmbt029_desc()
#         CALL anmt311_nmbt030_desc()
#      END IF 
#2015/6/25--by--02599--mark--end
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmbt2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_nmbt3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt311_detail_show()
 
   #add-point:show段之後 name="show.after"
  #140829-00070#30 15/01/13 Add
   IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN #2015/04/01 by 02599 add
      CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_nmbs_m.nmbsld
      IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL cl_set_toolbaritem_visible('open_pre',TRUE)
      ELSE
         CALL cl_set_toolbaritem_visible('open_pre',FALSE)
      END IF
   END IF  #2015/04/01 by 02599 add
  #140829-00070#30 15/01/13 Add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt311_detail_show()
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
 
{<section id="anmt311.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt311_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmbs_t.nmbsld 
   DEFINE l_oldno     LIKE nmbs_t.nmbsld 
   DEFINE l_newno02     LIKE nmbs_t.nmbsdocno 
   DEFINE l_oldno02     LIKE nmbs_t.nmbsdocno 
 
   DEFINE l_master    RECORD LIKE nmbs_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmbt_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_nmbs_m.nmbsld IS NULL
   OR g_nmbs_m.nmbsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmbsld_t = g_nmbs_m.nmbsld
   LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
    
   LET g_nmbs_m.nmbsld = ""
   LET g_nmbs_m.nmbsdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbs_m.nmbsownid = g_user
      LET g_nmbs_m.nmbsowndp = g_dept
      LET g_nmbs_m.nmbscrtid = g_user
      LET g_nmbs_m.nmbscrtdp = g_dept 
      LET g_nmbs_m.nmbscrtdt = cl_get_current()
      LET g_nmbs_m.nmbsmodid = g_user
      LET g_nmbs_m.nmbsmoddt = cl_get_current()
      LET g_nmbs_m.nmbsstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbs_m.nmbsstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_nmbs_m.nmbsld_desc = ''
   DISPLAY BY NAME g_nmbs_m.nmbsld_desc
 
   
   CALL anmt311_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmbs_m.* TO NULL
      INITIALIZE g_nmbt_d TO NULL
      INITIALIZE g_nmbt2_d TO NULL
      INITIALIZE g_nmbt3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt311_show()
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
   CALL anmt311_set_act_visible()   
   CALL anmt311_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbsld_t = g_nmbs_m.nmbsld
   LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbsent = " ||g_enterprise|| " AND",
                      " nmbsld = '", g_nmbs_m.nmbsld, "' "
                      ," AND nmbsdocno = '", g_nmbs_m.nmbsdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt311_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL anmt311_idx_chk()
   
   LET g_data_owner = g_nmbs_m.nmbsownid      
   LET g_data_dept  = g_nmbs_m.nmbsowndp
   
   #功能已完成,通報訊息中心
   CALL anmt311_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt311_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmbt_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt311_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbt_t
    WHERE nmbtent = g_enterprise AND nmbtld = g_nmbsld_t
     AND nmbtdocno = g_nmbsdocno_t
 
    INTO TEMP anmt311_detail
 
   #將key修正為調整後   
   UPDATE anmt311_detail 
      #更新key欄位
      SET nmbtld = g_nmbs_m.nmbsld
          , nmbtdocno = g_nmbs_m.nmbsdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmbt_t SELECT * FROM anmt311_detail
   
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
   DROP TABLE anmt311_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE anmt311_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM nmbb_t 
    WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmbsld_t
      AND nmbbdocno = g_nmbsdocno_t
     INTO TEMP anmt311_detail_lang
 
   #將key修正為調整後   
   UPDATE anmt311_detail_lang 
      #更新key欄位
      SET nmbbcomp = g_nmbs_m.nmbsld
          , nmbbdocno = g_nmbs_m.nmbsdocno
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO nmbb_t SELECT * FROM anmt311_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE anmt311_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmbsld_t = g_nmbs_m.nmbsld
   LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt311_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_dfin0030             LIKE ooac_t.ooac004   #140829-00070#30 15/01/13 Add
   DEFINE l_ooba002              LIKE ooba_t.ooba002   #140829-00070#30 15/01/13 Add
   DEFINE l_glaa121              LIKE glaa_t.glaa121   #140829-00070#30 15/01/13 Add
   DEFINE l_success              LIKE type_t.num5      #140829-00070#30 15/01/13 Add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmbs_m.nmbsld IS NULL
   OR g_nmbs_m.nmbsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt311_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT anmt311_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbs_m_mask_o.* =  g_nmbs_m.*
   CALL anmt311_nmbs_t_mask()
   LET g_nmbs_m_mask_n.* =  g_nmbs_m.*
   
   CALL anmt311_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150813-00015#4--add--str--
   IF g_nmbs_m.nmbsstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmbs_m.nmbscomp,'ANM',g_nmbs_m.nmbsdocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #150813-00015#4--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt311_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmbsld_t = g_nmbs_m.nmbsld
      LET g_nmbsdocno_t = g_nmbs_m.nmbsdocno
 
 
      DELETE FROM nmbs_t
       WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld
         AND nmbsdocno = g_nmbs_m.nmbsdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      IF NOT s_aooi200_fin_del_docno(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmbs_m.nmbsld,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmbt_t
       WHERE nmbtent = g_enterprise AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtdocno = g_nmbs_m.nmbsdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM nmbv_t 
       WHERE nmbvent = g_enterprise 
         AND nmbvld = g_nmbs_m.nmbsld 
         AND nmbvdocno = g_nmbs_m.nmbsdocno

      #140829-00070#30 15/01/13 Add
       CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
       CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
       SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
          AND glaald = g_nmbs_m.nmbsld
       IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
          CALL s_pre_voucher_del('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING l_success
     
          IF l_success = FALSE THEN
             CALL s_transaction_end('N','0')
             RETURN
          END IF
       END IF
      #140829-00070#30 15/01/13 Add
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmbs_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt311_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmbt_d.clear() 
      CALL g_nmbt2_d.clear()       
      CALL g_nmbt3_d.clear()       
 
     
      CALL anmt311_ui_browser_refresh()  
      #CALL anmt311_ui_headershow()  
      #CALL anmt311_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'nmbbent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'nmbbcomp'
         LET l_var_keys_bak[02] = g_nmbs_m.nmbsld
         LET l_field_keys[03] = 'nmbbdocno'
         LET l_var_keys_bak[03] = g_nmbs_m.nmbsdocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'nmbb_t')
 
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt311_browser_fill("")
         CALL anmt311_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt311_cl
 
   #功能已完成,通報訊息中心
   CALL anmt311_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt311.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt311_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_nmbt004  LIKE nmbt_t.nmbt004 #151224-00022#1 add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmbt_d.clear()
   CALL g_nmbt2_d.clear()
   CALL g_nmbt3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF anmt311_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbtseq,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100,nmbt101, 
             nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133, 
             nmbt004,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023, 
             nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036, 
             nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043,nmbtseq,nmbt001,nmbt002,nmbt003, 
             nmbt100,nmbt103,nmbt121,nmbt123,nmbt131,nmbt133  FROM nmbt_t",   
                     " INNER JOIN nmbs_t ON nmbsent = " ||g_enterprise|| " AND nmbsld = nmbtld ",
                     " AND nmbsdocno = nmbtdocno ",
 
                     #" LEFT JOIN nmbb_t ON nmbbent = "||g_enterprise||" AND nmbsld = nmbbcomp AND nmbsdocno = nmbbdocno AND nmbtseq = nmbbseq",
                     
                     " LEFT JOIN nmbb_t ON nmbbent = "||g_enterprise||" AND nmbsld = nmbbcomp AND nmbsdocno = nmbbdocno AND nmbtseq = nmbbseq",
                     #下層單身所需的join條件
 
                     
                     " WHERE nmbtent=? AND nmbtld=? AND nmbtdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbt_t.nmbtseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt311_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt311_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbt_d[l_ac].nmbtseq, 
          g_nmbt_d[l_ac].nmbt017,g_nmbt_d[l_ac].nmbt001,g_nmbt_d[l_ac].nmbt002,g_nmbt_d[l_ac].nmbt003, 
          g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103, 
          g_nmbt_d[l_ac].nmbt113,g_nmbt_d[l_ac].nmbt029,g_nmbt_d[l_ac].nmbt030,g_nmbt_d[l_ac].nmbt012, 
          g_nmbt_d[l_ac].nmbt013,g_nmbt_d[l_ac].nmbt014,g_nmbt_d[l_ac].nmbt121,g_nmbt_d[l_ac].nmbt123, 
          g_nmbt_d[l_ac].nmbt131,g_nmbt_d[l_ac].nmbt133,g_nmbt_d[l_ac].nmbt004,g_nmbt2_d[l_ac].nmbtseq, 
          g_nmbt2_d[l_ac].nmbt001,g_nmbt2_d[l_ac].nmbt002,g_nmbt2_d[l_ac].nmbt003,g_nmbt2_d[l_ac].nmbt018, 
          g_nmbt2_d[l_ac].nmbt019,g_nmbt2_d[l_ac].nmbt020,g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt022, 
          g_nmbt2_d[l_ac].nmbt023,g_nmbt2_d[l_ac].nmbt024,g_nmbt2_d[l_ac].nmbt025,g_nmbt2_d[l_ac].nmbt026, 
          g_nmbt2_d[l_ac].nmbt027,g_nmbt2_d[l_ac].nmbt028,g_nmbt2_d[l_ac].nmbt031,g_nmbt2_d[l_ac].nmbt032, 
          g_nmbt2_d[l_ac].nmbt033,g_nmbt2_d[l_ac].nmbt034,g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036, 
          g_nmbt2_d[l_ac].nmbt037,g_nmbt2_d[l_ac].nmbt038,g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040, 
          g_nmbt2_d[l_ac].nmbt041,g_nmbt2_d[l_ac].nmbt042,g_nmbt2_d[l_ac].nmbt043,g_nmbt3_d[l_ac].nmbtseq, 
          g_nmbt3_d[l_ac].nmbt001,g_nmbt3_d[l_ac].nmbt002,g_nmbt3_d[l_ac].nmbt003,g_nmbt3_d[l_ac].nmbt100, 
          g_nmbt3_d[l_ac].nmbt103,g_nmbt3_d[l_ac].nmbt121,g_nmbt3_d[l_ac].nmbt123,g_nmbt3_d[l_ac].nmbt131, 
          g_nmbt3_d[l_ac].nmbt133   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
#         LET g_nmbt_d[l_ac].nmbb001 = g_nmbt_d[l_ac].nmbt004  #151224-00022#1 mark
         LET l_nmbt004 = g_nmbt_d[l_ac].nmbt004   #151224-00022#1 add
         CALL anmt311_nmbt002_get()
         CALL anmt311_nmbt017_desc()
         CALL anmt311_nmbt018_desc(g_nmbt2_d[l_ac].nmbt018) RETURNING g_nmbt2_d[l_ac].nmbt018_desc
         CALL anmt311_nmbt019_desc(g_nmbt2_d[l_ac].nmbt019) RETURNING g_nmbt2_d[l_ac].nmbt019_desc
         CALL anmt311_nmbt020_desc('287',g_nmbt2_d[l_ac].nmbt020) RETURNING g_nmbt2_d[l_ac].nmbt020_desc
         CALL anmt311_nmbt021_desc(g_nmbt2_d[l_ac].nmbt021) RETURNING g_nmbt2_d[l_ac].nmbt021_desc 
         CALL anmt311_nmbt022_desc(g_nmbt2_d[l_ac].nmbt022) RETURNING g_nmbt2_d[l_ac].nmbt022_desc
         CALL anmt311_nmbt020_desc('281',g_nmbt2_d[l_ac].nmbt023) RETURNING g_nmbt2_d[l_ac].nmbt023_desc
         CALL anmt311_nmbt024_desc()
         CALL anmt311_nmbt025_desc()
         CALL anmt311_nmbt026_desc()
         CALL anmt311_nmbt027_desc()
         CALL anmt311_nmbt028_desc()
         CALL anmt311_nmbt029_desc() #科目
         CALL anmt311_nmbt030_desc() #對方科目
         CALL s_desc_get_oojdl003_desc(g_nmbt2_d[l_ac].nmbt032) RETURNING g_nmbt2_d[l_ac].nmbt032_desc  #渠道
         CALL anmt311_nmbt033_desc() #品牌
         CALL anmt311_free_account_desc()   #自由核算項說明
         LET g_nmbt_d[l_ac].nmbt004 = l_nmbt004 #151224-00022#1 add
         LET g_nmbt_d[l_ac].nmbb001 = l_nmbt004 #151224-00022#1 add
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_nmbt_d.deleteElement(g_nmbt_d.getLength())
   CALL g_nmbt2_d.deleteElement(g_nmbt2_d.getLength())
   CALL g_nmbt3_d.deleteElement(g_nmbt3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt311_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbt_d.getLength()
      LET g_nmbt_d_mask_o[l_ac].* =  g_nmbt_d[l_ac].*
      CALL anmt311_nmbt_t_mask()
      LET g_nmbt_d_mask_n[l_ac].* =  g_nmbt_d[l_ac].*
   END FOR
   
   LET g_nmbt2_d_mask_o.* =  g_nmbt2_d.*
   FOR l_ac = 1 TO g_nmbt2_d.getLength()
      LET g_nmbt2_d_mask_o[l_ac].* =  g_nmbt2_d[l_ac].*
      CALL anmt311_nmbt_t_mask()
      LET g_nmbt2_d_mask_n[l_ac].* =  g_nmbt2_d[l_ac].*
   END FOR
   LET g_nmbt3_d_mask_o.* =  g_nmbt3_d.*
   FOR l_ac = 1 TO g_nmbt3_d.getLength()
      LET g_nmbt3_d_mask_o[l_ac].* =  g_nmbt3_d[l_ac].*
      CALL anmt311_nmbt_t_mask()
      LET g_nmbt3_d_mask_n[l_ac].* =  g_nmbt3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt311_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   RETURN
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM nmbt_t
       WHERE nmbtent = g_enterprise AND
         nmbtld = ps_keys_bak[1] AND nmbtdocno = ps_keys_bak[2] AND nmbtseq = ps_keys_bak[3]
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
         CALL g_nmbt_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbt2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_nmbt3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt311_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      IF 1 = 2 THEN 
      #end add-point 
      INSERT INTO nmbt_t
                  (nmbtent,
                   nmbtld,nmbtdocno,
                   nmbtseq
                   ,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100,nmbt101,nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004,nmbt001,nmbt002,nmbt003,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043,nmbt001,nmbt002,nmbt003,nmbt100,nmbt103,nmbt121,nmbt123,nmbt131,nmbt133) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmbt_d[g_detail_idx].nmbt017,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                       g_nmbt_d[g_detail_idx].nmbt003,g_nmbt_d[g_detail_idx].nmbt011,g_nmbt_d[g_detail_idx].nmbt100, 
                       g_nmbt_d[g_detail_idx].nmbt101,g_nmbt_d[g_detail_idx].nmbt103,g_nmbt_d[g_detail_idx].nmbt113, 
                       g_nmbt_d[g_detail_idx].nmbt029,g_nmbt_d[g_detail_idx].nmbt030,g_nmbt_d[g_detail_idx].nmbt012, 
                       g_nmbt_d[g_detail_idx].nmbt013,g_nmbt_d[g_detail_idx].nmbt014,g_nmbt_d[g_detail_idx].nmbt121, 
                       g_nmbt_d[g_detail_idx].nmbt123,g_nmbt_d[g_detail_idx].nmbt131,g_nmbt_d[g_detail_idx].nmbt133, 
                       g_nmbt_d[g_detail_idx].nmbt004,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                       g_nmbt_d[g_detail_idx].nmbt003,g_nmbt2_d[g_detail_idx].nmbt018,g_nmbt2_d[g_detail_idx].nmbt019, 
                       g_nmbt2_d[g_detail_idx].nmbt020,g_nmbt2_d[g_detail_idx].nmbt021,g_nmbt2_d[g_detail_idx].nmbt022, 
                       g_nmbt2_d[g_detail_idx].nmbt023,g_nmbt2_d[g_detail_idx].nmbt024,g_nmbt2_d[g_detail_idx].nmbt025, 
                       g_nmbt2_d[g_detail_idx].nmbt026,g_nmbt2_d[g_detail_idx].nmbt027,g_nmbt2_d[g_detail_idx].nmbt028, 
                       g_nmbt2_d[g_detail_idx].nmbt031,g_nmbt2_d[g_detail_idx].nmbt032,g_nmbt2_d[g_detail_idx].nmbt033, 
                       g_nmbt2_d[g_detail_idx].nmbt034,g_nmbt2_d[g_detail_idx].nmbt035,g_nmbt2_d[g_detail_idx].nmbt036, 
                       g_nmbt2_d[g_detail_idx].nmbt037,g_nmbt2_d[g_detail_idx].nmbt038,g_nmbt2_d[g_detail_idx].nmbt039, 
                       g_nmbt2_d[g_detail_idx].nmbt040,g_nmbt2_d[g_detail_idx].nmbt041,g_nmbt2_d[g_detail_idx].nmbt042, 
                       g_nmbt2_d[g_detail_idx].nmbt043,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                       g_nmbt_d[g_detail_idx].nmbt003,g_nmbt_d[g_detail_idx].nmbt100,g_nmbt_d[g_detail_idx].nmbt103, 
                       g_nmbt_d[g_detail_idx].nmbt121,g_nmbt_d[g_detail_idx].nmbt123,g_nmbt_d[g_detail_idx].nmbt131, 
                       g_nmbt_d[g_detail_idx].nmbt133)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      ELSE
         INSERT INTO nmbt_t
                  (nmbtent,
                   nmbtld,nmbtdocno,
                   nmbtseq,nmbt017,
                   nmbt001,nmbt002,nmbt003,nmbt011,nmbt100,nmbt101,nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004,
                   nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,
                   nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],g_nmbt_d[g_detail_idx].nmbt017,
                   g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002,g_nmbt_d[g_detail_idx].nmbt003, 
                       g_nmbt_d[g_detail_idx].nmbt011,g_nmbt_d[g_detail_idx].nmbt100,g_nmbt_d[g_detail_idx].nmbt101, 
                       g_nmbt_d[g_detail_idx].nmbt103,g_nmbt_d[g_detail_idx].nmbt113,g_nmbt_d[g_detail_idx].nmbt029,
                       g_nmbt_d[g_detail_idx].nmbt030,g_nmbt_d[g_detail_idx].nmbt012, 
                       g_nmbt_d[g_detail_idx].nmbt013,g_nmbt_d[g_detail_idx].nmbt014,g_nmbt_d[g_detail_idx].nmbt121, 
                       g_nmbt_d[g_detail_idx].nmbt123,g_nmbt_d[g_detail_idx].nmbt131,g_nmbt_d[g_detail_idx].nmbt133,g_nmbt_d[g_detail_idx].nmbt004, 
                       g_nmbt2_d[g_detail_idx].nmbt018,g_nmbt2_d[g_detail_idx].nmbt019, 
                       g_nmbt2_d[g_detail_idx].nmbt020,g_nmbt2_d[g_detail_idx].nmbt021,g_nmbt2_d[g_detail_idx].nmbt022, 
                       g_nmbt2_d[g_detail_idx].nmbt023,g_nmbt2_d[g_detail_idx].nmbt024,g_nmbt2_d[g_detail_idx].nmbt025, 
                       g_nmbt2_d[g_detail_idx].nmbt026,g_nmbt2_d[g_detail_idx].nmbt027,g_nmbt2_d[g_detail_idx].nmbt028,
                       g_nmbt2_d[g_detail_idx].nmbt031, 
                       g_nmbt2_d[g_detail_idx].nmbt032,g_nmbt2_d[g_detail_idx].nmbt033,g_nmbt2_d[g_detail_idx].nmbt034, 
                       g_nmbt2_d[g_detail_idx].nmbt035,g_nmbt2_d[g_detail_idx].nmbt036,g_nmbt2_d[g_detail_idx].nmbt037, 
                       g_nmbt2_d[g_detail_idx].nmbt038,g_nmbt2_d[g_detail_idx].nmbt039,g_nmbt2_d[g_detail_idx].nmbt040, 
                       g_nmbt2_d[g_detail_idx].nmbt041,g_nmbt2_d[g_detail_idx].nmbt042,g_nmbt2_d[g_detail_idx].nmbt043)
      END IF
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmbt_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbt2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_nmbt3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      #151111-00001#1--add--add--lujh
      LET g_free_m.free_item_1 = g_nmbt2_d[l_ac].nmbt034
      LET g_free_m.free_item_2 = g_nmbt2_d[l_ac].nmbt035
      LET g_free_m.free_item_3 = g_nmbt2_d[l_ac].nmbt036
      LET g_free_m.free_item_4 = g_nmbt2_d[l_ac].nmbt037
      LET g_free_m.free_item_5 = g_nmbt2_d[l_ac].nmbt038
      LET g_free_m.free_item_6 = g_nmbt2_d[l_ac].nmbt039
      LET g_free_m.free_item_7 = g_nmbt2_d[l_ac].nmbt040
      LET g_free_m.free_item_8 = g_nmbt2_d[l_ac].nmbt041
      LET g_free_m.free_item_9 = g_nmbt2_d[l_ac].nmbt042
      LET g_free_m.free_item_10 = g_nmbt2_d[l_ac].nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,g_nmbt_d[l_ac].nmbt029,g_prog,g_nmbs_m.nmbsdocno,g_nmbt_d[l_ac].nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_nmbt2_d[l_ac].nmbt034,g_nmbt2_d[l_ac].nmbt035,g_nmbt2_d[l_ac].nmbt036,g_nmbt2_d[l_ac].nmbt037,
                g_nmbt2_d[l_ac].nmbt038,g_nmbt2_d[l_ac].nmbt039,g_nmbt2_d[l_ac].nmbt040,g_nmbt2_d[l_ac].nmbt041,
                g_nmbt2_d[l_ac].nmbt042,g_nmbt2_d[l_ac].nmbt043
                
      UPDATE nmbt_t SET nmbt034 = g_nmbt2_d[l_ac].nmbt034,
                        nmbt035 = g_nmbt2_d[l_ac].nmbt035,
                        nmbt036 = g_nmbt2_d[l_ac].nmbt036,
                        nmbt037 = g_nmbt2_d[l_ac].nmbt037,                           
                        nmbt038 = g_nmbt2_d[l_ac].nmbt038,
                        nmbt039 = g_nmbt2_d[l_ac].nmbt039,
                        nmbt040 = g_nmbt2_d[l_ac].nmbt040,
                        nmbt031 = g_nmbt2_d[l_ac].nmbt041,
                        nmbt042 = g_nmbt2_d[l_ac].nmbt042,
                        nmbt043 = g_nmbt2_d[l_ac].nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = g_nmbt_d[l_ac].nmbtseq
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbt_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #151111-00001#1--add--end--lujh
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt311_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbt_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt311_nmbt_t_mask_restore('restore_mask_o')
               
      UPDATE nmbt_t 
         SET (nmbtld,nmbtdocno,
              nmbtseq
              ,nmbt017,nmbt001,nmbt002,nmbt003,nmbt011,nmbt100,nmbt101,nmbt103,nmbt113,nmbt029,nmbt030,nmbt012,nmbt013,nmbt014,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004,nmbt001,nmbt002,nmbt003,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt031,nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,nmbt043,nmbt001,nmbt002,nmbt003,nmbt100,nmbt103,nmbt121,nmbt123,nmbt131,nmbt133) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmbt_d[g_detail_idx].nmbt017,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                  g_nmbt_d[g_detail_idx].nmbt003,g_nmbt_d[g_detail_idx].nmbt011,g_nmbt_d[g_detail_idx].nmbt100, 
                  g_nmbt_d[g_detail_idx].nmbt101,g_nmbt_d[g_detail_idx].nmbt103,g_nmbt_d[g_detail_idx].nmbt113, 
                  g_nmbt_d[g_detail_idx].nmbt029,g_nmbt_d[g_detail_idx].nmbt030,g_nmbt_d[g_detail_idx].nmbt012, 
                  g_nmbt_d[g_detail_idx].nmbt013,g_nmbt_d[g_detail_idx].nmbt014,g_nmbt_d[g_detail_idx].nmbt121, 
                  g_nmbt_d[g_detail_idx].nmbt123,g_nmbt_d[g_detail_idx].nmbt131,g_nmbt_d[g_detail_idx].nmbt133, 
                  g_nmbt_d[g_detail_idx].nmbt004,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                  g_nmbt_d[g_detail_idx].nmbt003,g_nmbt2_d[g_detail_idx].nmbt018,g_nmbt2_d[g_detail_idx].nmbt019, 
                  g_nmbt2_d[g_detail_idx].nmbt020,g_nmbt2_d[g_detail_idx].nmbt021,g_nmbt2_d[g_detail_idx].nmbt022, 
                  g_nmbt2_d[g_detail_idx].nmbt023,g_nmbt2_d[g_detail_idx].nmbt024,g_nmbt2_d[g_detail_idx].nmbt025, 
                  g_nmbt2_d[g_detail_idx].nmbt026,g_nmbt2_d[g_detail_idx].nmbt027,g_nmbt2_d[g_detail_idx].nmbt028, 
                  g_nmbt2_d[g_detail_idx].nmbt031,g_nmbt2_d[g_detail_idx].nmbt032,g_nmbt2_d[g_detail_idx].nmbt033, 
                  g_nmbt2_d[g_detail_idx].nmbt034,g_nmbt2_d[g_detail_idx].nmbt035,g_nmbt2_d[g_detail_idx].nmbt036, 
                  g_nmbt2_d[g_detail_idx].nmbt037,g_nmbt2_d[g_detail_idx].nmbt038,g_nmbt2_d[g_detail_idx].nmbt039, 
                  g_nmbt2_d[g_detail_idx].nmbt040,g_nmbt2_d[g_detail_idx].nmbt041,g_nmbt2_d[g_detail_idx].nmbt042, 
                  g_nmbt2_d[g_detail_idx].nmbt043,g_nmbt_d[g_detail_idx].nmbt001,g_nmbt_d[g_detail_idx].nmbt002, 
                  g_nmbt_d[g_detail_idx].nmbt003,g_nmbt_d[g_detail_idx].nmbt100,g_nmbt_d[g_detail_idx].nmbt103, 
                  g_nmbt_d[g_detail_idx].nmbt121,g_nmbt_d[g_detail_idx].nmbt123,g_nmbt_d[g_detail_idx].nmbt131, 
                  g_nmbt_d[g_detail_idx].nmbt133) 
         WHERE nmbtent = g_enterprise AND nmbtld = ps_keys_bak[1] AND nmbtdocno = ps_keys_bak[2] AND nmbtseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbt_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbt_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt311_nmbt_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'nmbbent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'nmbbcomp'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'nmbbdocno'
LET l_new_key[04] = ps_keys[3] 
LET l_old_key[04] = ps_keys_bak[3] 
LET l_field_key[04] = 'nmbbseq'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'nmbb_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt311_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt311.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt311_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt311.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt311_lock_b(ps_table,ps_page)
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
   #CALL anmt311_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "nmbt_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt311_bcl USING g_enterprise,
                                       g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbt_d[g_detail_idx].nmbtseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt311_bcl:",SQLERRMESSAGE 
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
 
{<section id="anmt311.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt311_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt311_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt311_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmbsdocno,nmbsld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmbsld,nmbsdocno",TRUE)
      CALL cl_set_comp_entry("nmbsdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("nmbssite",TRUE) #150714-00024#1 add
      CALL cl_set_comp_entry("nmbsdocdt",TRUE)  #150401-00001#31 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt311_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success   LIKE type_t.num5  #151130-00015#2 
   DEFINE l_slip      LIKE type_t.chr10 #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   DEFINE l_para_date LIKE type_t.dat   #150813-00015#4 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbsld,nmbsdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("nmbssite",FALSE) #150714-00024#1 add
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmbsdocno,nmbsld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("nmbsdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151218
#   IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN                  #150813-00015#4 mark
   IF NOT cl_null(g_nmbs_m.nmbsdocno) AND p_cmd = 'u'  THEN  #150813-00015#4 add
      #获取单别
      CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #抓取关帐日期
      CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4007') RETURNING l_para_date #150813-00015#4 add
#      IF l_dfin0033 = "N"  THEN  #150813-00015#4 mark
      IF l_dfin0033 = "N" AND g_nmbs_m.nmbsdocdt <= l_para_date THEN  #150813-00015#4 add
         CALL cl_set_comp_entry("nmbsdocdt",FALSE)
      ELSE 
         CALL cl_set_comp_entry("nmbsdocdt",TRUE)
      END IF          
   END IF 
   #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt311_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("nmbt001,nmbt002,nmbt003",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt311_set_no_entry_b(p_cmd)
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
   #151201-00003#2--add--str--
   IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
      CALL cl_set_comp_required('nmbt002,nmbt003',FALSE)
      IF cl_null(g_nmbt_d[l_ac].nmbt002) THEN
         CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,nmbt103,nmbt113',TRUE)
      ELSE
         CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101',FALSE)
         #151224-00022#1--mod--str--
#         IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN 
         IF (g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4') AND
            (NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003))
            THEN 
         #151224-00022#1--mod--end
            CALL cl_set_comp_entry('nmbt103,nmbt113',TRUE)
         ELSE
            CALL cl_set_comp_entry('nmbt103,nmbt113',FALSE)
         END IF
      END IF
   ELSE
      CALL cl_set_comp_required('nmbt002,nmbt003',TRUE)
      CALL cl_set_comp_entry('nmbb001,nmbt100,nmbt101,nmbt103,nmbt113',FALSE)
   END IF
   #151201-00003#2--add--end
   IF p_cmd = 'u' THEN
      IF g_nmbt_d[l_ac].nmbt001 = '7' OR g_nmbt_d[l_ac].nmbt001 = '8' OR g_nmbt_d[l_ac].nmbt001 = '9' OR g_nmbt_d[l_ac].nmbt001 = '10' OR g_nmbt_d[l_ac].nmbt001 = '12' THEN  #20150521 add g_nmbt_d[l_ac].nmbt001 = '9' lujh #150417-00007#56 Add OR g_nmbt_d[l_ac].nmbt001 = '10' #20160613 add '12' by Naysa
         CALL cl_set_comp_entry("nmbt001,nmbt002,nmbt003",FALSE)
      ELSE
         CALL cl_set_comp_entry("nmbt001,nmbt002,nmbt003",TRUE)
      END IF
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt311_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_nmbs_m.nmbsstus ='N' THEN
      #150714-00024#1 add modify_detail
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt311_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_nmbs_m.nmbsstus <> 'N' THEN
      #150714-00024#1 add modify_detail
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt311_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt311_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt311_default_search()
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
      LET ls_wc = ls_wc, " nmbsld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbsdocno = '", g_argv[02], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "nmbs_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbt_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
 
{<section id="anmt311.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt311_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_today       DATETIME YEAR TO SECOND
   DEFINE l_dfin0030    LIKE ooac_t.ooac004   #140829-00070#30 15/01/13 Add
   DEFINE l_ooba002     LIKE ooba_t.ooba002   #140829-00070#30 15/01/13 Add
   DEFINE l_glaa121     LIKE glaa_t.glaa121   #140829-00070#30 15/01/13 Add
   DEFINE l_wc          STRING                #140829-00070#30 15/01/13 Add
   DEFINE l_efin5001    LIKE type_t.chr1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmbs_m.nmbsld IS NULL
      OR g_nmbs_m.nmbsdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt311_cl USING g_enterprise,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno
   IF STATUS THEN
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt311_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite,g_nmbs_m.nmbsld, 
       g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004, 
       g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtdp, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfdt, 
       g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid_desc, 
       g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT anmt311_action_chk() THEN
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbscomp_desc, 
       g_nmbs_m.nmbscomp,g_nmbs_m.glaa001,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003, 
       g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp, 
       g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdp_desc, 
       g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid, 
       g_nmbs_m.nmbscnfid_desc,g_nmbs_m.nmbscnfdt
 
   CASE g_nmbs_m.nmbsstus
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_nmbs_m.nmbsstus
            
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #open改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",TRUE)
      #無條件關結案
      CALL cl_set_act_visible("closed",FALSE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_nmbs_m.nmbsstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold,unhold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
            CLOSE anmt311_cl #150813-00015#4 add
            CALL s_transaction_end('N','0')        #150401-00001#13
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)

         WHEN "H"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

          #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold,unhold",FALSE)

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,unhold",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt311_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt311_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt311_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt311_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #151013-00016#7 151027 by sakura mark(S)
            #IF NOT cl_null(g_nmbs_m.nmbs003) THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00187'
            #   LET g_errparam.extend = g_nmbs_m.nmbsdocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #CALL anmt311_unconfirm()   #141106-00011#22
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
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
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #151013-00016#7 151027 by sakura mark(S)
            #IF g_nmbs_m.nmbsstus = 'X' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00133'
            #   LET g_errparam.extend = g_nmbs_m.nmbsdocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            ##單身需有資料
            #SELECT COUNT(*) INTO l_n
            #  FROM nmbt_t
            # WHERE nmbtent = g_enterprise
            #   AND nmbtld = g_nmbs_m.nmbsld
            #   AND nmbtdocno = g_nmbs_m.nmbsdocno
            #IF l_n = 0 THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agl-00065'
            #   LET g_errparam.extend = g_nmbs_m.nmbsstus
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN 
            #END IF
            #
            ##150602-00057#2 by 02291 add
            #CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
            #CALL s_fin_chk_E5001(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002) RETURNING l_efin5001
            #IF l_efin5001 = 'N' THEN
            #   IF g_nmbs_m.nmbscrtid = g_user THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'axr-00346'
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      CALL s_transaction_end('N','0')
            #      CLOSE anmt311_cl
            #      RETURN
            #   END IF
            #END IF   
            ##150602-00057#2 by 02291 add
            #
            ##150714-00024#1 add ------
            ##核算項檢核
            #CALL cl_err_collect_init()
            #CALL anmt311_conf_chk(g_nmbs_m.nmbsdocno) RETURNING g_sub_success
            #IF NOT g_sub_success THEN
            #   CALL cl_err_collect_show()
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##150714-00024#1 add end---
            #
            #CALL anmt311_confirm()     #141106-00011#22
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            #151013-00016#7 151027 by sakura mark(S)
            #IF g_nmbs_m.nmbsstus = 'Y' THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00134'
            #   LET g_errparam.extend = g_nmbs_m.nmbsdocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_nmbs_m.nmbsstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
  #140829-00070#30 15/01/13 Add
   CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
   SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_nmbs_m.nmbsld
   IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
      LET l_wc = "glgadocno = '",g_nmbs_m.nmbsdocno,"'"
      CALL s_pre_voucher_upd('NM','N10',g_nmbs_m.nmbsld,lc_state,'','',l_wc) RETURNING l_success

      IF l_success = FALSE THEN
         LET g_errno = 'N'
      END IF
   END IF
  #140829-00070#30 15/01/13 Add
  
   #151013-00016#7 151027 by sakura add(S)
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmbs_m.nmbsstus = 'N' THEN
         CALL s_anmt311_conf_chk(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt311_conf_upd(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
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
      CALL s_anmt311_unconf_chk(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt311_unconf_upd(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
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
      CALL s_anmt311_invalid_chk(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行作廢？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt311_invalid_upd(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) RETURNING g_sub_success
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
   #151013-00016#7 151027 by sakura add(E)
  
   #end add-point
   
   LET g_nmbs_m.nmbsmodid = g_user
   LET g_nmbs_m.nmbsmoddt = cl_get_current()
   LET g_nmbs_m.nmbsstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmbs_t 
      SET (nmbsstus,nmbsmodid,nmbsmoddt) 
        = (g_nmbs_m.nmbsstus,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt)     
    WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld
      AND nmbsdocno = g_nmbs_m.nmbsdocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE anmt311_master_referesh USING g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno INTO g_nmbs_m.nmbssite, 
          g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbs001,g_nmbs_m.nmbs003, 
          g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsowndp,g_nmbs_m.nmbscrtid, 
          g_nmbs_m.nmbscrtdp,g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmoddt,g_nmbs_m.nmbscnfid, 
          g_nmbs_m.nmbscnfdt,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld_desc,g_nmbs_m.nmbsownid_desc,g_nmbs_m.nmbsowndp_desc, 
          g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbscnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbssite_desc,g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc, 
          g_nmbs_m.nmbscomp_desc,g_nmbs_m.nmbscomp,g_nmbs_m.glaa001,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt, 
          g_nmbs_m.nmbs001,g_nmbs_m.nmbs003,g_nmbs_m.nmbs004,g_nmbs_m.nmbsstus,g_nmbs_m.nmbsownid,g_nmbs_m.nmbsownid_desc, 
          g_nmbs_m.nmbsowndp,g_nmbs_m.nmbsowndp_desc,g_nmbs_m.nmbscrtid,g_nmbs_m.nmbscrtid_desc,g_nmbs_m.nmbscrtdp, 
          g_nmbs_m.nmbscrtdp_desc,g_nmbs_m.nmbscrtdt,g_nmbs_m.nmbsmodid,g_nmbs_m.nmbsmodid_desc,g_nmbs_m.nmbsmoddt, 
          g_nmbs_m.nmbscnfid,g_nmbs_m.nmbscnfid_desc,g_nmbs_m.nmbscnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #151013-00016#7 151027 by sakura mark(S)
   ##151013-00016#6---s
   #CALL s_anm_glbc015_upd(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbsstus) RETURNING l_success
   #IF NOT l_success THEN
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   ##151013-00016#6---e
   #LET g_success = 'Y'
   #IF lc_state = 'Y' THEN 
   #   LET l_today  = cl_get_current() 
   #   UPDATE nmbs_t SET nmbscnfid = g_user,
   #                     nmbscnfdt = l_today
   #    WHERE nmbsent = g_enterprise 
   #      AND nmbscomp =  g_nmbs_m.nmbscomp
   #      AND nmbsdocno = g_nmbs_m.nmbsdocno
   #      
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   END IF
   #ELSE
   #   UPDATE nmbs_t SET nmbscnfid = '',
   #                     nmbscnfdt = ''
   #    WHERE nmbsent = g_enterprise 
   #      AND nmbscomp =  g_nmbs_m.nmbscomp
   #      AND nmbsdocno = g_nmbs_m.nmbsdocno
   #
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   END IF
   #END IF
   #151013-00016#7 151027 by sakura mark(E)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   #151125-00006#3--s
   IF g_nmbs_m.nmbsstus = 'Y' THEN
      CALL anmt311_immediately_gen()
      CALL anmt311_ui_headershow()
   END IF
   #151125-00006#3--e
   #end add-point  
 
   CLOSE anmt311_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt311_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt311.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt311_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmbt_d.getLength() THEN
         LET g_detail_idx = g_nmbt_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbt_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbt_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmbt2_d.getLength() THEN
         LET g_detail_idx = g_nmbt2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbt2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbt2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_nmbt3_d.getLength() THEN
         LET g_detail_idx = g_nmbt3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbt3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbt3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt311_b_fill2(pi_idx)
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
   
   CALL anmt311_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt311_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt311.status_show" >}
PRIVATE FUNCTION anmt311_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt311.mask_functions" >}
&include "erp/anm/anmt311_mask.4gl"
 
{</section>}
 
{<section id="anmt311.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt311_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL anmt311_show()
   CALL anmt311_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#7 151027 by sakura add(S)
   IF NOT s_anmt311_conf_chk(g_nmbs_m.nmbsld ,g_nmbs_m.nmbsdocno) THEN
      CLOSE anmt311_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#7 151027 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmbs_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmbt_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_nmbt2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_nmbt3_d))
 
 
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
   #CALL anmt311_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt311_ui_headershow()
   CALL anmt311_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt311_draw_out()
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
   CALL anmt311_ui_headershow()  
   CALL anmt311_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt311.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt311_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbs_m.nmbsld
   LET g_pk_array[1].column = 'nmbsld'
   LET g_pk_array[2].values = g_nmbs_m.nmbsdocno
   LET g_pk_array[2].column = 'nmbsdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt311.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt311.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt311_msgcentre_notify(lc_state)
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
   CALL anmt311_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmbs_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt311.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt311_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311.other_function" readonly="Y" >}
# 單頭參考欄位帶值
PRIVATE FUNCTION anmt311_show_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbsld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbsld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbsld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbsld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa001 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
#   LET g_nmbs_m.nmbscomp = '', g_rtn_fields[1] , ''
   LET g_nmbs_m.glaa001 = '', g_rtn_fields[2] , ''
#   DISPLAY BY NAME g_nmbs_m.nmbscomp
   DISPLAY BY NAME g_nmbs_m.glaa001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbscomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbscomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbscomp_desc
   
   SELECT glaa001,glaa005,glaa004,glaa008,glaa014,glaa015,glaa016,
          glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa025
     INTO g_glaa001,g_glaa005,g_glaa004,g_glaa008,g_glaa014,g_glaa015,g_glaa016,
          g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa025  #151201-00003#2 add glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_nmbs_m.nmbsld
   
   IF NOT cl_null(g_nmbs_m.nmbscomp) THEN 
      CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源
   END IF
END FUNCTION
# 根據nmbt002抓取收票/異動票據資料
PRIVATE FUNCTION anmt311_nmbt002_get()
   #2015/04/30--by--02599--mod--str--
   IF g_nmbt_d[l_ac].nmbt001 = '3' OR g_nmbt_d[l_ac].nmbt001 = '4' OR g_nmbt_d[l_ac].nmbt001 = '11' THEN
      SELECT nmbadocdt,nmbb001,nmbb028,nmbb029,nmbb002  #151224-00022#1 add nmbb002
        INTO g_nmbt_d[l_ac].nmbadocdt,g_nmbt_d[l_ac].nmbb001,g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029
            ,g_nmbt_d[l_ac].nmbb002  #151224-00022#1 add
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002
         AND nmbbseq = g_nmbt_d[l_ac].nmbt003
      LET g_nmbt_d[l_ac].nmbt004 = g_nmbt_d[l_ac].nmbb001
   END IF
   IF g_nmbt_d[l_ac].nmbt001 = '7' THEN
      SELECT nmbadocdt,nmec012,nmec011
        INTO g_nmbt_d[l_ac].nmbadocdt,g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029  
        FROM nmba_t,nmec_t
       WHERE nmbaent = nmecent
         AND nmbacomp = nmeccomp
         AND nmbadocno = nmecdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002
         AND nmecseq = g_nmbt_d[l_ac].nmbt003
   END IF
   IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
      SELECT deakdocdt,deal006,deal005
        INTO g_nmbt_d[l_ac].nmbadocdt,g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029  
        FROM deak_t,deal_t
       WHERE deakent = dealent
         AND deakdocno = dealdocno
         AND deakent = g_enterprise
         AND deakdocno = g_nmbt_d[l_ac].nmbt002
         AND dealseq = g_nmbt_d[l_ac].nmbt003
   END IF
   #2015/04/30--by--02599--mod--end
   
   #20150521--add--str--lujh
   IF g_nmbt_d[l_ac].nmbt001 = '9' THEN
      SELECT deabdocdt,deac006,deac005
        INTO g_nmbt_d[l_ac].nmbadocdt,g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029  
        FROM deab_t,deac_t
       WHERE deabent = deacent
         AND deabdocno = deacdocno
         AND deabent = g_enterprise
         AND deabdocno = g_nmbt_d[l_ac].nmbt002
         AND deacseq = g_nmbt_d[l_ac].nmbt003
   END IF
   #20150521--add--end--lujh

   #150417-00007#56 Add  ---(S)---
   IF g_nmbt_d[l_ac].nmbt001 = '10' THEN
      SELECT nmbadocdt INTO g_nmbt_d[l_ac].nmbadocdt
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002

      SELECT nmbb028,nmbb029 INTO g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002
         AND nmbbseq = g_nmbt_d[l_ac].nmbt003

   END IF
   #150417-00007#56 Add  ---(E)---
      IF g_nmbt_d[l_ac].nmbt001 = '12' THEN
      SELECT nmbadocdt INTO g_nmbt_d[l_ac].nmbadocdt
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002

      SELECT nmbb028,nmbb029 INTO g_nmbt_d[l_ac].nmbb028,g_nmbt_d[l_ac].nmbb029
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002
         AND nmbbseq = g_nmbt_d[l_ac].nmbt003

   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt_d[l_ac].nmbb028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt_d[l_ac].nmbb028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbt_d[l_ac].nmbb028_desc
   
   LET g_nmbt3_d[l_ac].nmbadocdt = g_nmbt_d[l_ac].nmbadocdt
   LET g_nmbt3_d[l_ac].nmbb001 = g_nmbt_d[l_ac].nmbb001
   LET g_nmbt3_d[l_ac].nmbb029 = g_nmbt_d[l_ac].nmbb029
      
   DISPLAY g_nmbt_d[l_ac].nmbadocdt TO s_detail1[l_ac].nmbadocdt_2
   DISPLAY g_nmbt_d[l_ac].nmbb001 TO s_detail1[l_ac].nmbb001
   DISPLAY g_nmbt_d[l_ac].nmbb029 TO s_detail1[l_ac].nmbb029
   
   DISPLAY g_nmbt3_d[l_ac].nmbadocdt TO s_detail3[l_ac].nmbadocdt_3
   DISPLAY g_nmbt3_d[l_ac].nmbb001 TO s_detail3[l_ac].nmbb001
   DISPLAY g_nmbt3_d[l_ac].nmbb029 TO s_detail3[l_ac].nmbb029
   
   #151224-00022#1--add--str--
   #存提码说明
   CALL s_desc_get_nmajl003_desc(g_nmbt_d[l_ac].nmbb002) RETURNING g_nmbt_d[l_ac].nmbb002_desc
   DISPLAY BY NAME g_nmbt_d[l_ac].nmbb002_desc
   #151224-00022#1--add--end
END FUNCTION
# 整批抓取銀存收支/繳款單資料插入單身
PRIVATE FUNCTION anmt311_nmba_get(p_nmbt001,p_nmbt002)
DEFINE p_nmbt001      LIKE nmbt_t.nmbt001
DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
DEFINE l_nmcrdocno    LIKE nmcr_t.nmcrdocno
DEFINE l_nmcrseq      LIKE nmcr_t.nmcrseq
DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
DEFINE l_nmbt002      LIKE nmbt_t.nmbt002
DEFINE l_nmbt003      LIKE nmbt_t.nmbt003
DEFINE l_nmbt011      LIKE nmbt_t.nmbt011
DEFINE l_nmbt012      LIKE nmbt_t.nmbt012
DEFINE l_nmbt014      LIKE nmbt_t.nmbt014
DEFINE l_nmbt017      LIKE nmbt_t.nmbt017
DEFINE l_nmbt018      LIKE nmbt_t.nmbt018
DEFINE l_nmbt019      LIKE nmbt_t.nmbt019
DEFINE l_nmbt021      LIKE nmbt_t.nmbt021
DEFINE l_nmbt022      LIKE nmbt_t.nmbt022
DEFINE l_nmbt025      LIKE nmbt_t.nmbt025
DEFINE l_nmbt100      LIKE nmbt_t.nmbt100
DEFINE l_nmbt101      LIKE nmbt_t.nmbt101
DEFINE l_nmbt103      LIKE nmbt_t.nmbt103
DEFINE l_nmbt113      LIKE nmbt_t.nmbt113
DEFINE l_nmbt121      LIKE nmbt_t.nmbt121
DEFINE l_nmbt131      LIKE nmbt_t.nmbt131
DEFINE l_nmbt123      LIKE nmbt_t.nmbt123
DEFINE l_nmbt133      LIKE nmbt_t.nmbt133
DEFINE l_nmbb001      LIKE nmbb_t.nmbb001
DEFINE l_ooam003      LIKE ooam_t.ooam003
DEFINE l_nmbb002      LIKE nmbb_t.nmbb002
DEFINE l_nmbb003      LIKE nmbb_t.nmbb003
DEFINE l_nmbt029      LIKE nmbt_t.nmbt029
DEFINE l_nmbt030      LIKE nmbt_t.nmbt030
DEFINE l_nmbb028      LIKE nmbb_t.nmbb028   #150803-00018#1
DEFINE l_nmbb029      LIKE nmbb_t.nmbb029   #150803-00018#1
DEFINE l_nmbb070      LIKE nmbb_t.nmbb070   #160509-00004#114 add lujh
#151201-00003#2--add--str--
DEFINE l_nmbt103_o     LIKE nmbt_t.nmbt103
DEFINE l_nmbt113_o     LIKE nmbt_t.nmbt113
#151201-00003#2--add--end

   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #150803-00018#1 add nmbb028,nmbb029
   LET g_sql = " SELECT nmbbdocno,nmbbseq,nmbb030,nmbb031,nmbb003,",
               "        nmbacomp,nmba001,nmbb026,nmba008,nmbb004,",     #170105-00063#1 change nmba004 to nmbb026
               "        nmbb005,nmbb006,nmbb007,nmbb001,nmbb028,",
               "        nmbb029,nmbb070",    #160509-00004#114 add nmbb070 lujh
               "   FROM nmba_t,nmbb_t ",
               "  WHERE nmbaent = ",g_enterprise,
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'",
               "    AND nmbaent = nmbbent ",
               "    AND nmbacomp = nmbbcomp ",
               "    AND nmbadocno = nmbbdocno "
   IF p_nmbt001 = '3' THEN 
      LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt310','adet402','anmt440','aapt352')" #2015/6/25 by 02599 add adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
   END IF 
   IF p_nmbt001 = '4' THEN 
     #LET g_sql = g_sql CLIPPED," AND nmba003 = 'anmt540'"                 #151021 by 03538 mark
     #LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt540','anmt541') "   #151021 by 03538   #161026-00010#1 mark
     LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt540') "  #161026-00010#1 add
   END IF
   #161026-00010#1 add s---
   IF p_nmbt001 = '13' THEN 
     LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt541') "  
   END IF  
   IF p_nmbt001 = '1' THEN 
     LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt510') "  
   END IF      
   #161026-00010#1 add e---   
   PREPARE nmba_pre FROM g_sql
   DECLARE nmba_cur CURSOR FOR nmba_pre
   FOREACH nmba_cur INTO l_nmbt002,l_nmbt003,l_nmbt011,l_nmbt012,l_nmbt014,
                         l_nmbt017,l_nmbt018,l_nmbt021,l_nmbt025,l_nmbt100,
                         l_nmbt101,l_nmbt103,l_nmbt113,l_nmbb001,l_nmbb028,
                         l_nmbb029,l_nmbb070     #160509-00004#114 add lujh
      SELECT MAX(nmbtseq) + 1 INTO l_nmbtseq
        FROM nmbt_t
       WHERE nmbtent = g_enterprise
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtdocno = g_nmbs_m.nmbsdocno
       
      IF cl_null(l_nmbtseq) THEN 
         LET l_nmbtseq = 1
      END IF
      #151201-00003#2--add--str--
      IF p_nmbt001 = '3' THEN
         #扣除已经存在单据中的业务单+项次的金额
         LET l_nmbt103_o = 0
         LET l_nmbt113_o = 0
         SELECT SUM(nmbt103),SUM(nmbt113) 
           INTO l_nmbt103_o,l_nmbt113_o
           FROM nmbt_t
          WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
            AND nmbtdocno=g_nmbs_m.nmbsdocno
            AND nmbt002 = l_nmbt002 
            AND nmbt003 = l_nmbt003
            AND nmbtseq <> l_nmbtseq
         IF cl_null(l_nmbt103_o) THEN LET l_nmbt103_o = 0 END IF
         IF cl_null(l_nmbt113_o) THEN LET l_nmbt113_o = 0 END IF
         LET l_nmbt103 = l_nmbt103 - l_nmbt103_o
         LET l_nmbt113 = l_nmbt113 - l_nmbt113_o
         IF l_nmbt103 <= 0 OR l_nmbt113 <= 0 THEN
            CONTINUE FOREACH
         END IF
      END IF
      #151201-00003#2--add--end
      
      IF g_glaa014 = 'Y' THEN 
         IF g_glaa015 = 'Y' THEN
            #主帳套本位幣二匯率
            IF g_glaa017 = '1' THEN
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;          來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)
                 RETURNING l_nmbt121
            LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--
         END IF
          
         IF g_glaa019 = 'Y' THEN
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;           來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
                 RETURNING l_nmbt131
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--            
         END IF
      END IF
      
      
      
      #平行賬套,金額匯率重新計算
      IF g_glaa014 <> 'Y' AND g_glaa008 = 'Y' THEN
         LET l_nmbt101 = 0
         LET l_nmbt113 = 0
         #150930-00010#4--s
         IF l_nmbb001 = '2' THEN
            LET g_para_data =''
            CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4012') RETURNING g_para_data   #銀存支出匯率來源
         ELSE
            CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源
         END IF
         #150930-00010#4--e            
         #平行賬套匯率
         #150930-00010#4--s
         IF g_para_data = '23' THEN
            #銀行日平均匯率
            CALL s_anm_get_exrate(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_nmbt014,l_nmbt100,g_glaa001,g_nmbs_m.nmbsdocdt) 
             RETURNING l_nmbt101
         ELSE         
         #150930-00010#4--e         
                                       #日期;             來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_nmbt100,g_glaa001,g_para_data)
                 RETURNING l_nmbt101   
         END IF   #150930-00010#4
         LET l_nmbt113 = l_nmbt103 * l_nmbt101
         
         IF g_glaa015 = 'Y' THEN
            #主帳套本位幣二匯率
            IF g_glaa017 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;            來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)
            RETURNING l_nmbt121   
            LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--             
         END IF
          
         IF g_glaa019 = 'Y' THEN
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;            來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
                 RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--             
         END IF
      END IF
      
      #160509-00004#114--add--str--lujh
      IF NOT cl_null(l_nmbb070) THEN 
         LET l_nmbt021 = l_nmbb070
      END IF
      #160509-00004#114--add--end--lujh
      
      LET l_nmbt022 = l_nmbt021
      SELECT ooeg004 INTO l_nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt018
      
      
      #2015/6/25--by--02599--add--str--
      #根据業務單號+項次賦值 nmbt029,nmbt030
      IF NOT cl_null(l_nmbt002) AND NOT cl_null(l_nmbt003) THEN
         LET l_nmbb002 = ''
         LET l_nmbb003 = ''
         SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
           FROM nmbb_t
          WHERE nmbbent = g_enterprise
            AND nmbbcomp = g_nmbs_m.nmbscomp
            AND nmbbdocno = l_nmbt002
            AND nmbbseq = l_nmbt003
         LET l_nmbt029 = "" #150817
         LET l_nmbt030 = "" #150817
         #IF p_nmbt001 = '3' OR p_nmbt001 = '4' OR p_nmbt001 = '11' THEN    #161026-00010#1 mark
         IF p_nmbt001 = '3' OR p_nmbt001 = '4' OR p_nmbt001 = '11' OR p_nmbt001 = '13' OR p_nmbt001 = '1'  THEN   #161026-00010#1 add
            #150803-00018#1 add ------
            CASE p_nmbt001
               WHEN '3'
                  #anmt310異動別:1存入/2提出
                  IF l_nmbb001 MATCHES '[12]' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi121
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '40'
                        AND glab002 = '40'
                        AND glab003 = l_nmbb003
                  END IF
                  #anmt310異動別:3借方科目/4貸方科目
                  IF l_nmbb001 MATCHES '[34]' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi171
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '43'
                        AND glab002 = '43'
                        AND glab003 = l_nmbb002
                  END IF
                  
               WHEN '11'
                  #anmt310異動別:1存入/2提出
                  IF l_nmbb001 MATCHES '[12]' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi121
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '40'
                        AND glab002 = '40'
                        AND glab003 = l_nmbb003
                  END IF
                  #anmt310異動別:3借方科目/4貸方科目
                  IF l_nmbb001 MATCHES '[34]' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi171
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '43'
                        AND glab002 = '43'
                        AND glab003 = l_nmbb002
                  END IF
                  
               WHEN '4'
                  #當款別為10/20,取銀行帳戶科目anmi121;其他款別則依款別科目agli190
                  IF l_nmbb029 MATCHES '[12]0' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi121
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '40'
                        AND glab002 = '40'
                        AND glab003 = l_nmbb003
                  ELSE
                     SELECT DISTINCT glab005 INTO l_nmbt029  #agli190 
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '21'
                        AND glab002 = l_nmbb029
                        AND glab003 = l_nmbb028
                  END IF
               #161026-00010#1 add s---   
               WHEN '13'
                  #當款別為10/20,取銀行帳戶科目anmi121;其他款別則依款別科目agli190
                  IF l_nmbb029 MATCHES '[12]0' THEN
                     SELECT DISTINCT glab005 INTO l_nmbt029  #anmi121
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '40'
                        AND glab002 = '40'
                        AND glab003 = l_nmbb003
                  ELSE
                     SELECT DISTINCT glab005 INTO l_nmbt029  #agli190 
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_nmbs_m.nmbsld
                        AND glab001 = '21'
                        AND glab002 = l_nmbb029
                        AND glab003 = l_nmbb028
                  END IF 
               WHEN '1'   
                  SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029 FROM glab_t 
                   WHERE glabent = g_enterprise #借方科目: 依 agli190 設定
                     AND glabld  = g_nmbs_m.nmbsld
                     AND glab001 = '21'
                     AND glab002 = '30'
                     AND glab003 = l_nmbb028
               #161026-00010#1 add e---                  
            END CASE
            #150803-00018#1 add end---
            #150803-00018#1 mark ------
            ##SELECT DISTINCT glab006 INTO l_nmbt029  #anmi171   #150707-00001#7 mark
            #SELECT DISTINCT glab005 INTO l_nmbt029  #anmi171   #150707-00001#7
            #  FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld  = g_nmbs_m.nmbsld
            #   AND glab001 = '43'
            #   AND glab002 = '43'
            #   AND glab003 = l_nmbb002
            #150803-00018#1 mark end---
         ELSE                        
            SELECT DISTINCT glab005 INTO l_nmbt029  #anmi121
            FROM glab_t
           WHERE glabent = g_enterprise
             AND glabld  = g_nmbs_m.nmbsld
             AND glab001 = '40'
             AND glab002 = '40'
             AND glab003 = l_nmbb003 
         END IF
         
         
         #对方科目
         #150803-00018#1 add ------
         CASE
            WHEN g_nmbt_d[l_ac].nmbt001 = '4'  #繳款單>>取anmi152收款待沖銷科目
               SELECT DISTINCT glab005 INTO l_nmbt030
                 FROM glab_t
                WHERE glabent = g_enterprise
                  AND glabld = g_nmbs_m.nmbsld
                  AND glab001 = '41'
                  AND glab002 = '8714'
                  AND glab003 = 'F'
           #161222-00030#1 add s---       
           WHEN g_nmbt_d[l_ac].nmbt001 = '1'       
              SELECT DISTINCT glab005 INTO l_nmbt030 FROM glab_t 
               WHERE glabent = g_enterprise
                 AND glabld  = g_nmbs_m.nmbsld
                 AND glab001 = '41'
                 AND glab002 = '8714'  # 應收票據 異動項
                 AND glab003 = '1'     # 應收票據收票   
          #161222-00030#1 add e---       
            OTHERWISE
         #150803-00018#1 add end---
               SELECT DISTINCT glab005 INTO l_nmbt030  #anmi171
                 FROM glab_t,nmbb_t
                WHERE glabent = g_enterprise
                  AND glabld  = g_nmbs_m.nmbsld
                  AND glab001 = '43'
                  AND glab002 = '43'
                  AND glab003 = l_nmbb002
         END CASE #150803-00018#1
      END IF
      #2015/6/25--by--02599--add--end
      
      #160509-0004--str--
      IF p_nmbt001 = '11' THEN 
         SELECT nmbb070 INTO l_nmbt017 FROM nmbb_t WHERE nmbbdocno=l_nmbt002 AND nmbbseq=l_nmbt003 AND nmbbent = g_enterprise #160905-00007#8 add nmbbent = g_enterprise
      END IF
      if p_nmbt001 = '10' THEN
      
      end if       
      #160509-0004--end--
      
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt011,nmbt100,nmbt101,nmbt103,nmbt113,nmbt012,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt004,nmbt029,nmbt030)  #2015/6/25 by 02599 add nmbt029,nmbt030
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         p_nmbt001,l_nmbt002,l_nmbt003,l_nmbt011,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         l_nmbt012,g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbb001,
                         l_nmbt029,l_nmbt030)  #2015/6/25 by 02599 add nmbt029,nmbt030
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'   
      #--150616-00026#12--(s)
      ELSE
         LET g_ins_cnt = g_ins_cnt +1   #150622apo
      #--150616-00026#12--(e)
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
    #  CALL anmt311_nmbv_ins(g_nmbs_m.nmbsdocno,l_nmbtseq,p_nmbt001,l_nmbt002,l_nmbb001,l_nmbt003,l_nmbt103,l_nmbt113,l_nmbt123,l_nmbt133)
      
      #151224-00022#1--add--str--
      #當錄入3.銀存收支單時，在輸入資料同時，插入一筆相反資料，
      #即當錄入1.存入時再插入一筆4.貸方科目，當錄入2.提出時再插入一筆3.借方科目,
      #  當錄入3.借方科目時再插入一筆4.貸方科目，當錄入4.貸方科目時再插入一筆3.借方科目
      IF p_nmbt001 = '3' OR p_nmbt001 = '11' THEN
         #當異動別為：1.存入或2.提出時，nmbt029按存提码取glab005的存提科目
         IF l_nmbb001='1' OR l_nmbb001='2' THEN
            SELECT DISTINCT glab005 INTO l_nmbt029  #anmi171
             FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = g_nmbs_m.nmbsld
              AND glab001 = '43'
              AND glab002 = '43'
              AND glab003 = l_nmbb002
         ELSE
         #當異動別為：3.借方科目或4.貸方科目時，nmbt029按存提码取glab006的对应科目
            SELECT DISTINCT glab006 INTO l_nmbt029  #anmi171
             FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = g_nmbs_m.nmbsld
              AND glab001 = '43'
              AND glab002 = '43'
              AND glab003 = l_nmbb002
         END IF
         #160519-00043#1--add--str--
         IF cl_null(l_nmbt029) THEN
            CONTINUE FOREACH
         END IF
         #160519-00043#1--add--end
         #異動別
         IF l_nmbb001='1' OR l_nmbb001='3' THEN
            LET l_nmbb001='4'
         ELSE
            LET l_nmbb001='3'
         END IF
         #項次
         LET l_nmbtseq = l_nmbtseq + 1
         INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                            nmbt011,nmbt100,nmbt101,nmbt103,nmbt113,nmbt012,nmbt013,nmbt014,
                            nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                            nmbt131,nmbt133,nmbt004,nmbt029,nmbt030)  
                     VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                            p_nmbt001,l_nmbt002,l_nmbt003,l_nmbt011,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                            l_nmbt012,g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                            l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbb001,
                            l_nmbt029,l_nmbt030)  
                         
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'   
         ELSE
            LET g_ins_cnt = g_ins_cnt +1  
         END IF
         #更新核算項值
         LET g_free_m.free_item_1 = ''
         LET g_free_m.free_item_2 = ''
         LET g_free_m.free_item_3 = ''
         LET g_free_m.free_item_4 = ''
         LET g_free_m.free_item_5 = ''
         LET g_free_m.free_item_6 = ''
         LET g_free_m.free_item_7 = ''
         LET g_free_m.free_item_8 = ''
         LET g_free_m.free_item_9 = ''
         LET g_free_m.free_item_10 = ''
         
         LET g_field_m.field1 = 'nmbt034'
         LET g_field_m.field2 = 'nmbt035'
         LET g_field_m.field3 = 'nmbt036'
         LET g_field_m.field4 = 'nmbt037'
         LET g_field_m.field5 = 'nmbt038'
         LET g_field_m.field6 = 'nmbt039'
         LET g_field_m.field7 = 'nmbt040'
         LET g_field_m.field8 = 'nmbt041'
         LET g_field_m.field9 = 'nmbt042'
         LET g_field_m.field10= 'nmbt043'
         
         CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
         RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                   g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                   g_free_m.free_item_9,g_free_m.free_item_10
                   
         UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                           nmbt035 = g_free_m.free_item_2,
                           nmbt036 = g_free_m.free_item_3,
                           nmbt037 = g_free_m.free_item_4,                           
                           nmbt038 = g_free_m.free_item_5,
                           nmbt039 = g_free_m.free_item_6,
                           nmbt040 = g_free_m.free_item_7,
                           nmbt031 = g_free_m.free_item_8,
                           nmbt042 = g_free_m.free_item_9,
                           nmbt043 = g_free_m.free_item_10
          WHERE nmbtent = g_enterprise
            AND nmbtdocno = g_nmbs_m.nmbsdocno
            AND nmbtld = g_nmbs_m.nmbsld
            AND nmbtseq = l_nmbtseq
            
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET g_success = 'N'         
         END IF
      END IF
      #151224-00022#1--add--end
   END FOREACH 
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()
END FUNCTION
# 插入nmbv_t
PRIVATE FUNCTION anmt311_nmbv_ins(p_nmbtdocno,p_nmbtseq,p_nmbt001,p_nmbt002,p_nmbb001,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt001       LIKE nmbt_t.nmbt001
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbb001       LIKE nmbb_t.nmbb001
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_success       LIKE type_t.num5
   
   LET l_success = TRUE
   
   IF p_nmbt001 = '3' THEN    #銀存收支單
      IF p_nmbb001 = '1'  THEN    #存入
         CALL anmt311_nmbv_ins_3_1(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
      END IF
      
      IF p_nmbb001 = '2'  THEN    #存入
         CALL anmt311_nmbv_ins_3_2(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
      END IF
   END IF
   
   IF p_nmbt001 = '4' THEN    #繳款單
      CALL anmt311_nmbv_ins_4(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
   END IF
   
   IF l_success = FALSE THEN 
      LET g_success = 'N'
   END IF

END FUNCTION
# nmbt002重複性檢查
PRIVATE FUNCTION anmt311_nmbt002_chk(p_cmd)
   DEFINE l_n             LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_nmbastus      LIKE nmba_t.nmbastus
   DEFINE l_sql           STRING    #20150521 add lujh
   DEFINE l_origin_str    STRING    #20150521 add lujh
   DEFINE l_nmba006       LIKE nmba_t.nmba006   #150707-00001#7
   
   LET g_errno = ''
   
   #20150521--add--str--lujh
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   #將取回的字串轉換為SQL條件
   CALL anmt311_change_to_sql(l_origin_str) RETURNING l_origin_str  
   #20150521--add--end--lujh
   
   LET l_n = 0 
   IF g_nmbt_d[l_ac].nmbt001 = '3' THEN 
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN 
         SELECT COUNT(*) INTO l_n
           FROM nmba_t,nmbb_t
          WHERE nmbaent = nmbbent
            AND nmbacomp = nmbbcomp
            AND nmbadocno = nmbbdocno
            AND nmbaent = g_enterprise
            AND nmbacomp = g_nmbs_m.nmbscomp
            AND nmbadocno = g_nmbt_d[l_ac].nmbt002
            AND nmbbseq = g_nmbt_d[l_ac].nmbt003
            AND nmba003 IN ('anmt310','adet402','anmt440','aapt352') #2015/6/25 by 02599 add adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
         IF l_n = 0 THEN 
            LET g_errno = 'anm-00193'
            RETURN
         END IF
      END IF
   END IF
   
   IF g_nmbt_d[l_ac].nmbt001 = '4' THEN 
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN 
         SELECT COUNT(*) INTO l_n
           FROM nmba_t,nmbb_t
          WHERE nmbaent = nmbbent
            AND nmbacomp = nmbbcomp
            AND nmbadocno = nmbbdocno
            AND nmbaent = g_enterprise
            AND nmbacomp = g_nmbs_m.nmbscomp
            AND nmbadocno = g_nmbt_d[l_ac].nmbt002
            AND nmbbseq = g_nmbt_d[l_ac].nmbt003
           #AND nmba003 = 'anmt540'                #151021 by 03538 mark
            AND nmba003 IN ('anmt540','anmt541')   #151021 by 03538
         IF l_n = 0 THEN 
            LET g_errno = 'anm-00194'
            RETURN
         END IF
         #150707-00001#7--(s)
         SELECT nmba006 INTO l_nmba006
           FROM nmba_t
          WHERE nmbaent = g_enterprise
            AND nmbacomp = g_nmbs_m.nmbscomp
            AND nmbadocno = g_nmbt_d[l_ac].nmbt002
         IF l_nmba006 <> 'Y' THEN
            LET g_errno = 'anm-02943'
            RETURN
         END IF
         #150707-00001#7--(e)
      END IF
   END IF
   
   #2015/04/30--by--02599--add--str--
   #待結算卡回款
   IF g_nmbt_d[l_ac].nmbt001 = '7' THEN
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) THEN
         SELECT nmbastus INTO l_nmbastus
           FROM nmba_t
          WHERE nmbaent = g_enterprise AND nmbadocno = g_nmbt_d[l_ac].nmbt002 
            AND nmbacomp = g_nmbs_m.nmbscomp AND nmba003 = 'anmt561'
            
         CASE 
            WHEN SQLCA.sqlcode=100  LET g_errno='sub-01310' #anm-00346 #160318-00005#27  By 07900 --mod
            WHEN l_nmbastus <> 'Y'  LET g_errno='sub-01312' #anm-00347 #160318-00005#27  By 07900 --mod
         END CASE
         IF NOT cl_null(g_errno) THEN
            RETURN
         END IF
      END IF
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN 
         IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
            SELECT COUNT(*) INTO l_n
              FROM nmba_t,nmec_t
             WHERE nmbaent = nmecent
               AND nmbacomp = nmeccomp
               AND nmbadocno = nmecdocno
               AND nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = g_nmbt_d[l_ac].nmbt002
               AND nmecseq = g_nmbt_d[l_ac].nmbt003
               AND nmecsite = g_nmbt_d[l_ac].nmbt017
               AND nmba003 = 'anmt561'
         ELSE    
            SELECT COUNT(*) INTO l_n
              FROM nmba_t,nmec_t
             WHERE nmbaent = nmecent
               AND nmbacomp = nmeccomp
               AND nmbadocno = nmecdocno
               AND nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = g_nmbt_d[l_ac].nmbt002
               AND nmecseq = g_nmbt_d[l_ac].nmbt003
               AND nmba003 = 'anmt561'
         END IF
         IF l_n = 0 THEN 
            LET g_errno = 'anm-00348'
            RETURN
         END IF
      END IF
   END IF
   
   #營業款存繳
   IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
         SELECT deakstus INTO l_nmbastus
            FROM deak_t
           WHERE deakent = g_enterprise AND deakdocno = g_nmbt_d[l_ac].nmbt002 
             AND deaksite = g_nmbt_d[l_ac].nmbt017
      ELSE
         SELECT deakstus INTO l_nmbastus
            FROM deak_t
           WHERE deakent = g_enterprise AND deakdocno = g_nmbt_d[l_ac].nmbt002 
             AND deaksite = g_nmbs_m.nmbscomp
      END IF
      CASE 
         WHEN SQLCA.sqlcode=100  LET g_errno='anm-00349'
         WHEN l_nmbastus <> 'Y'  LET g_errno='anm-00350'
      END CASE
      IF NOT cl_null(g_errno) THEN
         RETURN
      END IF
      
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
         SELECT COUNT(*) INTO l_n
           FROM deal_t
          WHERE dealent = g_enterprise
            AND dealdocno = g_nmbt_d[l_ac].nmbt002
            AND dealseq = g_nmbt_d[l_ac].nmbt003
         IF l_n = 0 THEN 
            LET g_errno = 'anm-00351'
            RETURN
         END IF
      END IF
   END IF
   #2015/04/30--by--02599--add--end
   
   #20150521--add--str--lujh
   IF g_nmbt_d[l_ac].nmbt001 = '9' THEN
      SELECT deabstus INTO l_nmbastus
        FROM deab_t
       WHERE deabent = g_enterprise 
         AND deabdocno = g_nmbt_d[l_ac].nmbt002 
             
      CASE 
         WHEN SQLCA.sqlcode=100  LET g_errno='anm-02908'
         WHEN l_nmbastus <> 'Y'  LET g_errno='anm-02909'
      END CASE
      
      IF NOT cl_null(g_errno) THEN
         RETURN
      END IF
      
      LET l_sql = "SELECT COUNT(*) FROM deab_t ",
                  " WHERE deabent = '",g_enterprise,"'",
                  "   AND deabdocno = '",g_nmbt_d[l_ac].nmbt002,"'",
                  "   AND deabsite IN (",l_origin_str," )"
      PREPARE deabsite_pre FROM l_sql
      EXECUTE deabsite_pre INTO l_n
      IF l_n = 0 THEN 
         LET g_errno='anm-02910'
      END IF
      
      IF NOT cl_null(g_errno) THEN
         RETURN
      END IF
      
      IF NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
         SELECT COUNT(*) INTO l_n
           FROM deac_t
          WHERE deacent = g_enterprise
            AND deacdocno = g_nmbt_d[l_ac].nmbt002
            AND deacseq = g_nmbt_d[l_ac].nmbt003
         IF l_n = 0 THEN 
            LET g_errno = 'anm-02911'
            RETURN
         END IF
      END IF
   END IF
   #20150521--add--end--lujh
   
   LET l_n = 0
   IF p_cmd = 'a' THEN 
      SELECT COUNT(*) INTO l_n
        FROM nmbt_t
        LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno #150714-00024#1
       WHERE nmbtent = g_enterprise
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbt002 = g_nmbt_d[l_ac].nmbt002 
         AND nmbt003 = g_nmbt_d[l_ac].nmbt003
         AND nmbsstus <> 'X' #150714-00024#1
   END IF
   IF p_cmd = 'u' THEN 
      SELECT COUNT(*) INTO l_n
        FROM nmbt_t
        LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno #150714-00024#1
       WHERE nmbtent = g_enterprise
         AND nmbt002 = g_nmbt_d[l_ac].nmbt002
         AND nmbt003 = g_nmbt_d[l_ac].nmbt003
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtseq <> g_nmbt_d[l_ac].nmbtseq
         AND nmbsstus <> 'X' #150714-00024#1
   END IF
   #银存收支单
   IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
      #151201-00003#2--add--str--
      SELECT COUNT(*) INTO l_n
        FROM nmbt_t LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno 
       WHERE nmbtent = g_enterprise
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtdocno<>g_nmbs_m.nmbsdocno
         AND nmbt002 = g_nmbt_d[l_ac].nmbt002 
         AND nmbt003 = g_nmbt_d[l_ac].nmbt003
         AND nmbsstus <> 'X' 
      #151201-00003#2--add--end
      IF l_n > 0 THEN 
         LET g_errno = 'anm-00171'
         RETURN 
      END IF
      
   END IF
   #待结算卡回款
   IF g_nmbt_d[l_ac].nmbt001 = '7' THEN
      IF l_n > 3 THEN 
         LET g_errno = 'anm-00171'
         RETURN 
      END IF
   END IF
   #营业款存缴
   IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
      IF l_n > 2 THEN 
         LET g_errno = 'anm-00171'
         RETURN 
      END IF
   END IF
   #20150521--add--str--lujh
   #营业款转备用金
   IF g_nmbt_d[l_ac].nmbt001 = '8' THEN
      IF l_n > 0 THEN 
         LET g_errno = 'anm-00171'
         RETURN 
      END IF
   END IF
   #20150521--add--end--lujh

   #150417-00007#56 Add  ---(S)---
   #繳款匯總單檢查
   IF g_nmbt_d[l_ac].nmbt001 = '10' THEN
      SELECT nmbastus INTO l_nmbastus
        FROM nmba_t
       WHERE nmbaent = g_enterprise 
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002 
         AND nmbacomp = g_nmbs_m.nmbscomp
             
      CASE 
         WHEN SQLCA.sqlcode=100  LET g_errno='anm-00561'
         WHEN l_nmbastus <> 'Y'  LET g_errno='anm-00562'
      END CASE

      IF NOT cl_null(g_errno) THEN
         RETURN
      END IF

   END IF
   #150417-00007#56 Add  ---(E)---
      IF g_nmbt_d[l_ac].nmbt001 = '12' THEN
      SELECT nmbastus INTO l_nmbastus
        FROM nmba_t
       WHERE nmbaent = g_enterprise 
         AND nmbadocno = g_nmbt_d[l_ac].nmbt002 
         AND nmbacomp = g_nmbs_m.nmbscomp
             
      CASE 
         WHEN SQLCA.sqlcode=100  LET g_errno='anm-00561'
         WHEN l_nmbastus <> 'Y'  LET g_errno='anm-00562'
      END CASE

      IF NOT cl_null(g_errno) THEN
         RETURN
      END IF
 
    END IF
   IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM nmba_t WHERE nmbaent = g_enterprise 
                                             AND nmbacomp = g_nmbs_m.nmbscomp
                                             AND nmbadocno = g_nmbt_d[l_ac].nmbt002
                                             AND nmba006 = 'Y'
      IF cl_null(l_n) OR l_n = 0 THEN
         LET g_errno = 'anm-00293'
         RETURN 
      END IF   
   END IF
END FUNCTION
# 抓取本位幣二三匯率
PRIVATE FUNCTION anmt311_get_exrate(p_date,p_ooam003,p_ooan002,p_type)
   DEFINE p_date       LIKE nmbs_t.nmbsdocdt
   DEFINE p_ooam003    LIKE ooam_t.ooam003
   DEFINE p_ooan002    LIKE ooan_t.ooan002
   DEFINE p_type       LIKE glaa_t.glaa018
   DEFINE r_exrate     LIKE nmbt_t.nmbt121
   
                          #匯率參照表;帳套;         日期;  來源幣別
   CALL s_aooi160_get_exrate('2',g_nmbs_m.nmbsld,p_date,p_ooam003,
                             #目的幣別; 交易金額; 匯類類型
                             p_ooan002,0,p_type)
   RETURNING r_exrate  
   
   RETURN r_exrate   
   
END FUNCTION
# 根據nmbt002抓取其他欄位的預設值
PRIVATE FUNCTION anmt311_nmbt002_default()
DEFINE l_ooam003       LIKE ooam_t.ooam003
DEFINE l_nmbb001       LIKE nmbb_t.nmbb001   #150803-00018#1
DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
DEFINE l_nmbb028       LIKE nmbb_t.nmbb028   #150803-00018#1
DEFINE l_nmbb029       LIKE nmbb_t.nmbb029   #150803-00018#1
#151201-00003#2--add--str--
DEFINE l_nmbt103_o     LIKE nmbt_t.nmbt103
DEFINE l_nmbt113_o     LIKE nmbt_t.nmbt113
DEFINE l_nmbt123_o     LIKE nmbt_t.nmbt123
DEFINE l_nmbt133_o     LIKE nmbt_t.nmbt133
#151201-00003#2--add--end

   SELECT nmbb030,nmbb031,nmbb003,nmba001,nmbb026,   #170105-00063#1 change nmba004 to nmbb026
          nmba008,nmbb004,nmbb005,nmbb006,nmbb007,
          nmbb001,nmbb028,nmbb029                    #150803-00018#1
     INTO g_nmbt_d[l_ac].nmbt011,g_nmbt_d[l_ac].nmbt012,g_nmbt_d[l_ac].nmbt014,
          g_nmbt2_d[l_ac].nmbt018,g_nmbt2_d[l_ac].nmbt021,g_nmbt2_d[l_ac].nmbt025,
          g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt101,g_nmbt_d[l_ac].nmbt103,
          g_nmbt_d[l_ac].nmbt113,l_nmbb001,l_nmbb028,l_nmbb029
     FROM nmba_t,nmbb_t
    WHERE nmbaent = nmbbent
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmbaent = g_enterprise
      AND nmbacomp = g_nmbs_m.nmbscomp
      AND nmbadocno = g_nmbt_d[l_ac].nmbt002
      AND nmbbseq =  g_nmbt_d[l_ac].nmbt003
 
   #151201-00003#2--add--str--
   IF g_nmbt_d[l_ac].nmbt001 = '3' THEN
      #扣除已经存在单据中的业务单+项次的金额
      LET l_nmbt103_o = 0
      LET l_nmbt113_o = 0
      LET l_nmbt123_o = 0
      LET l_nmbt133_o = 0
      SELECT SUM(nmbt103),SUM(nmbt113),SUM(nmbt123),SUM(nmbt133) 
        INTO l_nmbt103_o,l_nmbt113_o,l_nmbt123_o,l_nmbt133_o
        FROM nmbt_t
       WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
         AND nmbtdocno=g_nmbs_m.nmbsdocno
         AND nmbt002 = g_nmbt_d[l_ac].nmbt002 
         AND nmbt003 = g_nmbt_d[l_ac].nmbt003
         AND nmbtseq <> g_nmbt_d[l_ac].nmbtseq
      IF cl_null(l_nmbt103_o) THEN LET l_nmbt103_o = 0 END IF
      IF cl_null(l_nmbt113_o) THEN LET l_nmbt113_o = 0 END IF
      LET g_nmbt_d[l_ac].nmbt103 = g_nmbt_d[l_ac].nmbt103 - l_nmbt103_o
      LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d[l_ac].nmbt113 - l_nmbt113_o
      IF g_glaa015='Y' THEN
         IF cl_null(l_nmbt123_o) THEN LET l_nmbt123_o = 0 END IF
         LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt123 - l_nmbt123_o
      END IF
      IF g_glaa019='Y' THEN
         IF cl_null(l_nmbt133_o) THEN LET l_nmbt133_o = 0 END IF
         LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt133 - l_nmbt133_o
      END IF
   END IF
   #151201-00003#2--add--end
   LET g_nmbt2_d[l_ac].nmbt022 = g_nmbt2_d[l_ac].nmbt021
   SELECT ooeg004 INTO g_nmbt2_d[l_ac].nmbt019
     FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = g_nmbt2_d[l_ac].nmbt018

   IF g_glaa014 = 'Y' THEN 
      IF g_glaa015 = 'Y' THEN
         #主帳套本位幣二匯率
         IF g_glaa017 = '1' THEN 
            LET l_ooam003 = g_nmbt_d[l_ac].nmbt100
         ELSE
            LET l_ooam003 = g_glaa001
         END IF
                                    #日期;          來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)
              RETURNING g_nmbt_d[l_ac].nmbt121  
         LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
         #160413-00025#1 add--str--
         CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
            RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123           
         #160413-00025#1 add--end--         
      END IF
       
      IF g_glaa019 = 'Y' THEN
         #主帳套本位幣三匯率
         IF g_glaa021 = '1' THEN 
            LET l_ooam003 = g_nmbt_d[l_ac].nmbt100
         ELSE
            LET l_ooam003 = g_glaa001
         END IF
                                    #日期;           來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
              RETURNING g_nmbt_d[l_ac].nmbt131
         LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
         #160413-00025#1 add--str--
         CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
            RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133           
         #160413-00025#1 add--end--            
      END IF
   END IF
   
   #平行賬套,金額匯率重新計算
   IF g_glaa014 <> 'Y' AND g_glaa008 = 'Y' THEN 
      LET g_nmbt_d[l_ac].nmbt101 = 0
      LET g_nmbt_d[l_ac].nmbt113 = 0
      #150930-00010#4--s
      IF l_nmbb001 = '2' THEN
         LET g_para_data =''
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4012') RETURNING g_para_data   #銀存支出匯率來源
      ELSE
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源
      END IF
      #150930-00010#4--e
      #平行賬套匯率
      #150930-00010#4--s
      IF g_para_data = '23' THEN
         #銀行日平均匯率
         CALL s_anm_get_exrate(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_nmbt_d[l_ac].nmbt014,g_nmbt_d[l_ac].nmbt100,g_glaa001,g_nmbs_m.nmbsdocdt) 
          RETURNING g_nmbt_d[l_ac].nmbt101
      ELSE
      #150930-00010#4--e
                                    #日期;              來源幣別            目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,g_nmbt_d[l_ac].nmbt100,g_glaa001,g_para_data)
              RETURNING g_nmbt_d[l_ac].nmbt101
      END IF   #150930-00010#4
      LET g_nmbt_d[l_ac].nmbt113 = g_nmbt_d[l_ac].nmbt103 * g_nmbt_d[l_ac].nmbt101
      #160413-00025#1 add--str--
     #CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa001,g_nmbt_d[l_ac].nmbt113,3)              #160822-00018#1 mark
      CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_nmbt_d[l_ac].nmbt100,g_nmbt_d[l_ac].nmbt113,3) #160822-00018#1
       RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt113
      #160413-00025#1 add--end--
      
      IF g_glaa015 = 'Y' THEN
         #主帳套本位幣二匯率
         IF g_glaa017 = '1' THEN
            LET l_ooam003 = g_nmbt_d[l_ac].nmbt100
         ELSE
            LET l_ooam003 = g_glaa001
         END IF
                                    #日期;           來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)
              RETURNING g_nmbt_d[l_ac].nmbt121
         LET g_nmbt_d[l_ac].nmbt123 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt121
         #160413-00025#1 add--str--
         CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,g_nmbt_d[l_ac].nmbt123,2)
              RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt123
         #160413-00025#1 add--end--
      END IF
      
      IF g_glaa019 = 'Y' THEN
         #主帳套本位幣三匯率
         IF g_glaa021 = '1' THEN
            LET l_ooam003 = g_nmbt_d[l_ac].nmbt100
         ELSE
            LET l_ooam003 = g_glaa001
         END IF
                                    #日期;           來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
              RETURNING g_nmbt_d[l_ac].nmbt131    
         LET g_nmbt_d[l_ac].nmbt133 = g_nmbt_d[l_ac].nmbt113 * g_nmbt_d[l_ac].nmbt131
         #160413-00025#1 add--str--
         CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,g_nmbt_d[l_ac].nmbt133,2)
            RETURNING g_sub_success,g_errno,g_nmbt_d[l_ac].nmbt133
         #160413-00025#1 add--end--
      END IF
   END IF
   
   LET g_nmbt_d[l_ac].nmbt029 = "" #150817
   LET g_nmbt_d[l_ac].nmbt030 = "" #150817
   #根据業務單號+項次賦值 nmbt029,nmbt030
   IF NOT cl_null(g_nmbt_d[l_ac].nmbt002) AND NOT cl_null(g_nmbt_d[l_ac].nmbt003) THEN
      
      LET l_nmbb002 = ''
      LET l_nmbb003 = ''
      
      SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
        FROM nmbb_t
       WHERE nmbbent = g_enterprise
         AND nmbbcomp = g_nmbs_m.nmbscomp
         AND nmbbdocno = g_nmbt_d[l_ac].nmbt002
         AND nmbbseq = g_nmbt_d[l_ac].nmbt003
      
      IF g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4' THEN
         #150803-00018#1 add ------
         CASE g_nmbt_d[l_ac].nmbb001
            WHEN '3'
               #anmt310異動別:1存入/2提出
               IF l_nmbb001 MATCHES '[12]' THEN
                  SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi121
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = g_nmbs_m.nmbsld
                     AND glab001 = '40'
                     AND glab002 = '40'
                     AND glab003 = l_nmbb003
               END IF
               #anmt310異動別:3借方科目/4貸方科目
               IF l_nmbb001 MATCHES '[34]' THEN
                  SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi171
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = g_nmbs_m.nmbsld
                     AND glab001 = '43'
                     AND glab002 = '43'
                     AND glab003 = l_nmbb002
               END IF
            WHEN '4'
               #當款別為10/20,取銀行帳戶科目anmi121;其他款別則依款別科目agli190
               IF l_nmbb029 MATCHES '[12]0' THEN
                  SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi121
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = g_nmbs_m.nmbsld
                     AND glab001 = '40'
                     AND glab002 = '40'
                     AND glab003 = l_nmbb003
               ELSE
                  SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #agli190 
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = g_nmbs_m.nmbsld
                     AND glab001 = '21'
                     AND glab002 = l_nmbb029
                     AND glab003 = l_nmbb028
               END IF
         END CASE
         #150803-00018#1 add end---
         #150803-00018#1 mark ------
         ##SELECT DISTINCT glab006 INTO g_nmbt_d[l_ac].nmbt029  #anmi171   #150707-00001#7 mark
         #SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi171   #150707-00001#7
         #  FROM glab_t
         # WHERE glabent = g_enterprise
         #   AND glabld  = g_nmbs_m.nmbsld
         #   AND glab001 = '43'
         #   AND glab002 = '43'
         #   AND glab003 = l_nmbb002
         #150803-00018#1 mark end---
      ELSE
         SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt029  #anmi121
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = g_nmbs_m.nmbsld
            AND glab001 = '40'
            AND glab002 = '40'
            AND glab003 = l_nmbb003
      END IF 
      
      
      #150803-00018#1 add ------
      CASE
         WHEN g_nmbt_d[l_ac].nmbt001 = '4'  #繳款單>>取anmi152收款待沖銷科目
            SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt030
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_nmbs_m.nmbsld
               AND glab001 = '41'
               AND glab002 = '8714'
               AND glab003 = 'F'
         OTHERWISE
      #150803-00018#1 add end---
            #对方科目
            SELECT DISTINCT glab005 INTO g_nmbt_d[l_ac].nmbt030  #anmi171
              FROM glab_t,nmbb_t
             WHERE glabent = g_enterprise
               AND glabld  = g_nmbs_m.nmbsld
               AND glab001 = '43'
               AND glab002 = '43'
               AND glab003 = l_nmbb002
      END CASE #150803-00018#1
      
      DISPLAY g_nmbt_d[l_ac].nmbt029  TO s_detail1[l_ac].nmbt029
      DISPLAY g_nmbt_d[l_ac].nmbt030  TO s_detail1[l_ac].nmbt030
      
      CALL anmt311_nmbt029_desc()
      CALL anmt311_nmbt030_desc()
   #151224-00022#1--add--str--
#   ELSE
#      IF g_nmbt_d[l_ac].nmbt001 = '3' AND (g_nmbt_d[l_ac].nmbb001 = '3' OR g_nmbt_d[l_ac].nmbb001 = '4') THEN
#         IF g_nmbt_d[l_ac].nmbb001 = '3' THEN
#            SELECT nmbt002,nmbt003 INTO l_nmbt002,l_nmbt003 
#              FROM nmbt_t
#             WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
#               AND nmbtdocno=g_nmbs_m.nmbsdocno
#               AND nmbt001='3' AND nmbt004='2'
#               AND nmbtseq=(SELECT MIN(nmbtseq) FROM nmbt_t
#                            )
#            SELECT nmbb002 INTO l_nmbb002 FROM nmbb_t
#              FROM nmbb_t
#             WHERE nmbbent=g_enterprise AND nmbbcomp=g_nmbs_m.nmbscomp
#              
#         END IF
#      END IF
   #151224-00022#1--add--end
   END IF   

   DISPLAY g_nmbt_d[l_ac].nmbt003  TO s_detail1[l_ac].nmbt003
   DISPLAY g_nmbt_d[l_ac].nmbt011  TO s_detail1[l_ac].nmbt011
   DISPLAY g_nmbt_d[l_ac].nmbt100  TO s_detail1[l_ac].nmbt100
   DISPLAY g_nmbt_d[l_ac].nmbt101  TO s_detail1[l_ac].nmbt101
   DISPLAY g_nmbt_d[l_ac].nmbt103  TO s_detail1[l_ac].nmbt103
   DISPLAY g_nmbt_d[l_ac].nmbt113  TO s_detail1[l_ac].nmbt113
   DISPLAY g_nmbt_d[l_ac].nmbt012  TO s_detail1[l_ac].nmbt012
   DISPLAY g_nmbt_d[l_ac].nmbt014  TO s_detail1[l_ac].nmbt014
   DISPLAY g_nmbt_d[l_ac].nmbt121  TO s_detail1[l_ac].nmbt121
   DISPLAY g_nmbt_d[l_ac].nmbt123  TO s_detail1[l_ac].nmbt123
   DISPLAY g_nmbt_d[l_ac].nmbt131  TO s_detail1[l_ac].nmbt131
   DISPLAY g_nmbt_d[l_ac].nmbt133  TO s_detail1[l_ac].nmbt133
   DISPLAY g_nmbt2_d[l_ac].nmbt018 TO g_nmbt2_d[l_ac].nmbt018
   DISPLAY g_nmbt2_d[l_ac].nmbt021 TO g_nmbt2_d[l_ac].nmbt021
   DISPLAY g_nmbt2_d[l_ac].nmbt025 TO g_nmbt2_d[l_ac].nmbt025
   DISPLAY g_nmbt2_d[l_ac].nmbt022 TO g_nmbt2_d[l_ac].nmbt022
   DISPLAY g_nmbt2_d[l_ac].nmbt019 TO g_nmbt2_d[l_ac].nmbt019
   
END FUNCTION
# 銀存收支單：存入
PRIVATE FUNCTION anmt311_nmbv_ins_3_1(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #通路
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbvud001 LIKE nmbv_t.nmbvud001, #自定義欄位(文字)001
       nmbvud002 LIKE nmbv_t.nmbvud002, #自定義欄位(文字)002
       nmbvud003 LIKE nmbv_t.nmbvud003, #自定義欄位(文字)003
       nmbvud004 LIKE nmbv_t.nmbvud004, #自定義欄位(文字)004
       nmbvud005 LIKE nmbv_t.nmbvud005, #自定義欄位(文字)005
       nmbvud006 LIKE nmbv_t.nmbvud006, #自定義欄位(文字)006
       nmbvud007 LIKE nmbv_t.nmbvud007, #自定義欄位(文字)007
       nmbvud008 LIKE nmbv_t.nmbvud008, #自定義欄位(文字)008
       nmbvud009 LIKE nmbv_t.nmbvud009, #自定義欄位(文字)009
       nmbvud010 LIKE nmbv_t.nmbvud010, #自定義欄位(文字)010
       nmbvud011 LIKE nmbv_t.nmbvud011, #自定義欄位(數字)011
       nmbvud012 LIKE nmbv_t.nmbvud012, #自定義欄位(數字)012
       nmbvud013 LIKE nmbv_t.nmbvud013, #自定義欄位(數字)013
       nmbvud014 LIKE nmbv_t.nmbvud014, #自定義欄位(數字)014
       nmbvud015 LIKE nmbv_t.nmbvud015, #自定義欄位(數字)015
       nmbvud016 LIKE nmbv_t.nmbvud016, #自定義欄位(數字)016
       nmbvud017 LIKE nmbv_t.nmbvud017, #自定義欄位(數字)017
       nmbvud018 LIKE nmbv_t.nmbvud018, #自定義欄位(數字)018
       nmbvud019 LIKE nmbv_t.nmbvud019, #自定義欄位(數字)019
       nmbvud020 LIKE nmbv_t.nmbvud020, #自定義欄位(數字)020
       nmbvud021 LIKE nmbv_t.nmbvud021, #自定義欄位(日期時間)021
       nmbvud022 LIKE nmbv_t.nmbvud022, #自定義欄位(日期時間)022
       nmbvud023 LIKE nmbv_t.nmbvud023, #自定義欄位(日期時間)023
       nmbvud024 LIKE nmbv_t.nmbvud024, #自定義欄位(日期時間)024
       nmbvud025 LIKE nmbv_t.nmbvud025, #自定義欄位(日期時間)025
       nmbvud026 LIKE nmbv_t.nmbvud026, #自定義欄位(日期時間)026
       nmbvud027 LIKE nmbv_t.nmbvud027, #自定義欄位(日期時間)027
       nmbvud028 LIKE nmbv_t.nmbvud028, #自定義欄位(日期時間)028
       nmbvud029 LIKE nmbv_t.nmbvud029, #自定義欄位(日期時間)029
       nmbvud030 LIKE nmbv_t.nmbvud030, #自定義欄位(日期時間)030
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD
   #161215-00044#2---modify----end-----------------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = g_nmbs_m.nmbsld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = g_nmbs_m.nmbsld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：銀行帳戶對應會科
    
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目: 依 anmi121  設定 
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise 
      AND glabld  = g_nmbs_m.nmbsld
      AND glab001 = '40'
      AND glab002 = '40'     
      AND glab003 = l_nmbb003  #交易帳戶編號
   
      
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 #  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 #  LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：存提碼對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi171  設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = g_nmbs_m.nmbsld
      AND glab001 = '43' 
      AND glab002 = '43'
      AND glab003 = l_nmbb002
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 提出
PRIVATE FUNCTION anmt311_nmbv_ins_3_2(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #通路
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbvud001 LIKE nmbv_t.nmbvud001, #自定義欄位(文字)001
       nmbvud002 LIKE nmbv_t.nmbvud002, #自定義欄位(文字)002
       nmbvud003 LIKE nmbv_t.nmbvud003, #自定義欄位(文字)003
       nmbvud004 LIKE nmbv_t.nmbvud004, #自定義欄位(文字)004
       nmbvud005 LIKE nmbv_t.nmbvud005, #自定義欄位(文字)005
       nmbvud006 LIKE nmbv_t.nmbvud006, #自定義欄位(文字)006
       nmbvud007 LIKE nmbv_t.nmbvud007, #自定義欄位(文字)007
       nmbvud008 LIKE nmbv_t.nmbvud008, #自定義欄位(文字)008
       nmbvud009 LIKE nmbv_t.nmbvud009, #自定義欄位(文字)009
       nmbvud010 LIKE nmbv_t.nmbvud010, #自定義欄位(文字)010
       nmbvud011 LIKE nmbv_t.nmbvud011, #自定義欄位(數字)011
       nmbvud012 LIKE nmbv_t.nmbvud012, #自定義欄位(數字)012
       nmbvud013 LIKE nmbv_t.nmbvud013, #自定義欄位(數字)013
       nmbvud014 LIKE nmbv_t.nmbvud014, #自定義欄位(數字)014
       nmbvud015 LIKE nmbv_t.nmbvud015, #自定義欄位(數字)015
       nmbvud016 LIKE nmbv_t.nmbvud016, #自定義欄位(數字)016
       nmbvud017 LIKE nmbv_t.nmbvud017, #自定義欄位(數字)017
       nmbvud018 LIKE nmbv_t.nmbvud018, #自定義欄位(數字)018
       nmbvud019 LIKE nmbv_t.nmbvud019, #自定義欄位(數字)019
       nmbvud020 LIKE nmbv_t.nmbvud020, #自定義欄位(數字)020
       nmbvud021 LIKE nmbv_t.nmbvud021, #自定義欄位(日期時間)021
       nmbvud022 LIKE nmbv_t.nmbvud022, #自定義欄位(日期時間)022
       nmbvud023 LIKE nmbv_t.nmbvud023, #自定義欄位(日期時間)023
       nmbvud024 LIKE nmbv_t.nmbvud024, #自定義欄位(日期時間)024
       nmbvud025 LIKE nmbv_t.nmbvud025, #自定義欄位(日期時間)025
       nmbvud026 LIKE nmbv_t.nmbvud026, #自定義欄位(日期時間)026
       nmbvud027 LIKE nmbv_t.nmbvud027, #自定義欄位(日期時間)027
       nmbvud028 LIKE nmbv_t.nmbvud028, #自定義欄位(日期時間)028
       nmbvud029 LIKE nmbv_t.nmbvud029, #自定義欄位(日期時間)029
       nmbvud030 LIKE nmbv_t.nmbvud030, #自定義欄位(日期時間)030
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD
   #161215-00044#2---modify----end-----------------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = g_nmbs_m.nmbsld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = g_nmbs_m.nmbsld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：銀行帳戶對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目: 依 anmi171  設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = g_nmbs_m.nmbsld
      AND glab001 = '43' 
      AND glab002 = '43'
      AND glab003 = l_nmbb002
   
      
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 #  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 #  LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：存提碼對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi121  設定 
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t,nmbb_t 
    WHERE glabent = g_enterprise 
      AND glabld  = g_nmbs_m.nmbsld
      AND glab001 = '40'
      AND glab002 = '40'  
      AND glab003 = l_nmbb003   #交易帳戶編號
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
  # LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 繳款單
PRIVATE FUNCTION anmt311_nmbv_ins_4(p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #通路
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbvud001 LIKE nmbv_t.nmbvud001, #自定義欄位(文字)001
       nmbvud002 LIKE nmbv_t.nmbvud002, #自定義欄位(文字)002
       nmbvud003 LIKE nmbv_t.nmbvud003, #自定義欄位(文字)003
       nmbvud004 LIKE nmbv_t.nmbvud004, #自定義欄位(文字)004
       nmbvud005 LIKE nmbv_t.nmbvud005, #自定義欄位(文字)005
       nmbvud006 LIKE nmbv_t.nmbvud006, #自定義欄位(文字)006
       nmbvud007 LIKE nmbv_t.nmbvud007, #自定義欄位(文字)007
       nmbvud008 LIKE nmbv_t.nmbvud008, #自定義欄位(文字)008
       nmbvud009 LIKE nmbv_t.nmbvud009, #自定義欄位(文字)009
       nmbvud010 LIKE nmbv_t.nmbvud010, #自定義欄位(文字)010
       nmbvud011 LIKE nmbv_t.nmbvud011, #自定義欄位(數字)011
       nmbvud012 LIKE nmbv_t.nmbvud012, #自定義欄位(數字)012
       nmbvud013 LIKE nmbv_t.nmbvud013, #自定義欄位(數字)013
       nmbvud014 LIKE nmbv_t.nmbvud014, #自定義欄位(數字)014
       nmbvud015 LIKE nmbv_t.nmbvud015, #自定義欄位(數字)015
       nmbvud016 LIKE nmbv_t.nmbvud016, #自定義欄位(數字)016
       nmbvud017 LIKE nmbv_t.nmbvud017, #自定義欄位(數字)017
       nmbvud018 LIKE nmbv_t.nmbvud018, #自定義欄位(數字)018
       nmbvud019 LIKE nmbv_t.nmbvud019, #自定義欄位(數字)019
       nmbvud020 LIKE nmbv_t.nmbvud020, #自定義欄位(數字)020
       nmbvud021 LIKE nmbv_t.nmbvud021, #自定義欄位(日期時間)021
       nmbvud022 LIKE nmbv_t.nmbvud022, #自定義欄位(日期時間)022
       nmbvud023 LIKE nmbv_t.nmbvud023, #自定義欄位(日期時間)023
       nmbvud024 LIKE nmbv_t.nmbvud024, #自定義欄位(日期時間)024
       nmbvud025 LIKE nmbv_t.nmbvud025, #自定義欄位(日期時間)025
       nmbvud026 LIKE nmbv_t.nmbvud026, #自定義欄位(日期時間)026
       nmbvud027 LIKE nmbv_t.nmbvud027, #自定義欄位(日期時間)027
       nmbvud028 LIKE nmbv_t.nmbvud028, #自定義欄位(日期時間)028
       nmbvud029 LIKE nmbv_t.nmbvud029, #自定義欄位(日期時間)029
       nmbvud030 LIKE nmbv_t.nmbvud030, #自定義欄位(日期時間)030
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD
   #161215-00044#2---modify----end-----------------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE l_nmbb029       LIKE nmbb_t.nmbb029
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = g_nmbs_m.nmbsld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb003,nmbb028,nmbb029 INTO l_nmbb003,l_nmbb028,l_nmbb029
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = g_nmbs_m.nmbsld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：款別對應的會科
    
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目
   IF l_nmbb029 <> '20' THEN   # 20.電匯款
      #借方科目: 依 agli190 設定 
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t
       WHERE glabent = g_enterprise 
         AND glabld  = g_nmbs_m.nmbsld
        #AND glab001 = '42'   #150707-00001#7 mark
         AND glab001 = '21'   #150707-00001#7
         AND glab002 = l_nmbb029   
         AND glab003 = l_nmbb028
   ELSE
      #Dr. 銀行帳戶對應會科 
      #借方科目: 依 anmi121  設定 
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t 
       WHERE glabent = g_enterprise 
         AND glabld  = g_nmbs_m.nmbsld
         AND glab001 = '40' 
         AND glab002 = '40' 
         AND glab003 = l_nmbb003
   END IF
   
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 #  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 #  LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：收款待沖銷科目
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi171  設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = g_nmbs_m.nmbsld
      AND glab001 = '41' 
      AND glab002 = '8714'   # 應收票據 異動項 
      AND glab003 = 'F'      # 收款待沖銷科目 
          
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   #161215-00044#2---modify----begin-----------------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*)
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,nmbv019,nmbv020,
                       nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,nmbv029,nmbv030,nmbv031,
                       nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,nmbv039,nmbv040,nmbv041,nmbv103,
                       nmbv113,nmbv123,nmbv133,nmbvud001,nmbvud002,nmbvud003,nmbvud004,nmbvud005,nmbvud006,nmbvud007,
                       nmbvud008,nmbvud009,nmbvud010,nmbvud011,nmbvud012,nmbvud013,nmbvud014,nmbvud015,nmbvud016,
                       nmbvud017,nmbvud018,nmbvud019,nmbvud020,nmbvud021,nmbvud022,nmbvud023,nmbvud024,nmbvud025,
                       nmbvud026,nmbvud027,nmbvud028,nmbvud029,nmbvud030,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,l_nmbv.nmbv019,l_nmbv.nmbv020,
           l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,
           l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,
           l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbvud001,l_nmbv.nmbvud002,l_nmbv.nmbvud003,l_nmbv.nmbvud004,l_nmbv.nmbvud005,l_nmbv.nmbvud006,l_nmbv.nmbvud007,
           l_nmbv.nmbvud008,l_nmbv.nmbvud009,l_nmbv.nmbvud010,l_nmbv.nmbvud011,l_nmbv.nmbvud012,l_nmbv.nmbvud013,l_nmbv.nmbvud014,l_nmbv.nmbvud015,l_nmbv.nmbvud016,
           l_nmbv.nmbvud017,l_nmbv.nmbvud018,l_nmbv.nmbvud019,l_nmbv.nmbvud020,l_nmbv.nmbvud021,l_nmbv.nmbvud022,l_nmbv.nmbvud023,l_nmbv.nmbvud024,l_nmbv.nmbvud025,
           l_nmbv.nmbvud026,l_nmbv.nmbvud027,l_nmbv.nmbvud028,l_nmbv.nmbvud029,l_nmbv.nmbvud030,l_nmbv.nmbv042,l_nmbv.nmbv100)
   #161215-00044#2---modify----end-----------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins nmbv'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success  
END FUNCTION
# 拋轉傳票
PRIVATE FUNCTION anmt311_turn_gen(p_slip,p_date)
   DEFINE p_type         LIKE type_t.chr2
   DEFINE p_ld           LIKE glaa_t.glaald
   DEFINE p_date         LIKE glap_t.glapdocdt
  #DEFINE p_slip          LIKE ooba_t.ooba002    #160525-00021#2 mark
   DEFINE p_slip          LIKE type_t.chr50      #160525-00021#2     
   DEFINE p_sum_type     LIKE type_t.chr1
   DEFINE p_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_start_no     LIKE glap_t.glapdocno
   DEFINE r_end_no       LIKE glap_t.glapdocno
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_glaa121      LIKE glaa_t.glaa121   #140829-00070#30 Add

   #140829-00070#30 Add  ---(S)---
   SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmbs_m.nmbsld
   #140829-00070#30 Add  ---(E)---

   CALL s_transaction_begin()
   
   IF l_glaa121 = 'N' THEN   #140829-00070#30 Add
   #IF g_flag = 'N' THEN 
      #传入参数赋值
      LET p_type = '1'
      LET p_ld = g_nmbs_m.nmbsld
      LET p_sum_type = '0'
      LET p_wc = "nmbsdocno = '"||g_nmbs_m.nmbsdocno||"'"

      CALL s_voucher_gen_nm(p_type,p_ld,p_date,p_slip,p_sum_type,p_wc,'Y','anmt311') RETURNING r_success
   #END IF
   
      #檢查科目是否為空
      LET l_sql = "SELECT COUNT(*) FROM s_vr_tmp06 ",  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
                  " WHERE glaq002 IS NULL "
      PREPARE chk_glaq002 FROM l_sql
      EXECUTE chk_glaq002 INTO l_n   
      IF l_n > 0 THEN  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00068'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN
      END IF
   
      #5.插入凭证单头
      CALL s_voucher_gen_nm_1_ins_glap(p_slip,p_date,g_nmbs_m.nmbsld,'anmt311')
           RETURNING r_success,r_start_no,r_end_no
   
   #140829-00070#30 Add  ---(S)---
   ELSE
      LET p_wc =" glgbdocno = '"||g_nmbs_m.nmbsdocno||"'"
      CALL s_pre_voucher_ins_glap('NM','N10',g_nmbs_m.nmbsld,p_date,p_slip,'1',p_wc) RETURNING r_success,r_start_no,r_end_no
   END IF
   #140829-00070#30 Add  ---(E)---
   IF r_success THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)   
    END IF
END FUNCTION
# nmbt017帶值
PRIVATE FUNCTION anmt311_nmbt017_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt_d[l_ac].nmbt017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt_d[l_ac].nmbt017_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt_d[l_ac].nmbt017_desc = g_nmbt_d[l_ac].nmbt017 CLIPPED,g_nmbt_d[l_ac].nmbt017_desc
   DISPLAY g_nmbt_d[l_ac].nmbt017_desc TO s_detail1[l_ac].nmbt017_desc
END FUNCTION
# nmbt018帶值
#161110-00001#1 mod p_ooea001 -> p_ooef001
PRIVATE FUNCTION anmt311_nmbt018_desc(p_ooef001)
#  DEFINE p_ooea001  LIKE ooea_t.ooea001    #161110-00001#1 MARK
   DEFINE p_ooef001  LIKE ooef_t.ooef001    #161110-00001#1 ADD  
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001 #161110-00001#1 mod p_ooea001 -> p_ooef001 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_nmbt2_d[l_ac].nmbt018 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION
# nmbt019帶值
#161110-00001#1 mod p_ooea001 -> p_ooef001
PRIVATE FUNCTION anmt311_nmbt019_desc(p_ooef001)
#  DEFINE p_ooea001  LIKE ooea_t.ooea001   #161110-00001#1 MARK
   DEFINE p_ooef001  LIKE ooef_t.ooef001   #161110-00001#1 ADD 
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001  #161110-00001#1 mod p_ooea001 -> p_ooef001 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_nmbt2_d[l_ac].nmbt019 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION
# nmbt018帶值
PRIVATE FUNCTION anmt311_nmbt020_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001  LIKE oocq_t.oocq001
   DEFINE p_oocq002  LIKE oocq_t.oocq002
   DEFINE r_oocql004 LIKE oocql_t.oocql004 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocq001
   LET g_ref_fields[2] = p_oocq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   IF p_oocq001 = '287' THEN 
      LET r_oocql004 = g_nmbt2_d[l_ac].nmbt020 CLIPPED,r_oocql004
   END IF
   IF p_oocq001 = '281' THEN 
      LET r_oocql004 = g_nmbt2_d[l_ac].nmbt023 CLIPPED,r_oocql004
   END IF
   RETURN r_oocql004
END FUNCTION
# nmbt021帶值
PRIVATE FUNCTION anmt311_nmbt021_desc(p_pmaa001)
   DEFINE p_pmaa001  LIKE pmaa_t.pmaa001
   DEFINE r_pmaal004 LIKE pmaal_t.pmaal004    
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , '' 
   LET r_pmaal004 = g_nmbt2_d[l_ac].nmbt021 CLIPPED,r_pmaal004
   RETURN r_pmaal004
END FUNCTION
# nmbt022帶值
PRIVATE FUNCTION anmt311_nmbt022_desc(p_pmaa001)
   DEFINE p_pmaa001  LIKE pmaa_t.pmaa001
   DEFINE r_pmaal004 LIKE pmaal_t.pmaal004    
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , '' 
   LET r_pmaal004 = g_nmbt2_d[l_ac].nmbt022 CLIPPED,r_pmaal004
   RETURN r_pmaal004
END FUNCTION
# nmbt024帶值
PRIVATE FUNCTION anmt311_nmbt024_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt024
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt2_d[l_ac].nmbt024_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt2_d[l_ac].nmbt024_desc = g_nmbt2_d[l_ac].nmbt024 CLIPPED,g_nmbt2_d[l_ac].nmbt024_desc
   DISPLAY g_nmbt2_d[l_ac].nmbt024_desc TO s_detail2[l_ac].nmbt024_desc
END FUNCTION
# nmbt025帶值
PRIVATE FUNCTION anmt311_nmbt025_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt025
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_nmbt2_d[l_ac].nmbt025_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt2_d[l_ac].nmbt025_desc = g_nmbt2_d[l_ac].nmbt025 CLIPPED ,g_nmbt2_d[l_ac].nmbt025_desc
   DISPLAY g_nmbt2_d[l_ac].nmbt025_desc TO s_detail2[l_ac].nmbt025_desc
END FUNCTION
# nmbt026帶值
PRIVATE FUNCTION anmt311_nmbt026_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt026
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt2_d[l_ac].nmbt026_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt2_d[l_ac].nmbt026_desc = g_nmbt2_d[l_ac].nmbt026 CLIPPED ,g_nmbt2_d[l_ac].nmbt026_desc
   DISPLAY g_nmbt2_d[l_ac].nmbt026_desc TO s_detail2[l_ac].nmbt026_desc
END FUNCTION
# nmbt027帶值
PRIVATE FUNCTION anmt311_nmbt027_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt027
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt2_d[l_ac].nmbt027_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt2_d[l_ac].nmbt027_desc = g_nmbt2_d[l_ac].nmbt027 CLIPPED ,g_nmbt2_d[l_ac].nmbt027_desc
   DISPLAY g_nmbt2_d[l_ac].nmbt027_desc TO s_detail2[l_ac].nmbt027_desc
END FUNCTION
# nmbt028帶值
PRIVATE FUNCTION anmt311_nmbt028_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt027
   LET g_ref_fields[2] = g_nmbt2_d[l_ac].nmbt028
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbt2_d[l_ac].nmbt028_desc = '', g_rtn_fields[1] , ''
   LET g_nmbt2_d[l_ac].nmbt028_desc = g_nmbt2_d[l_ac].nmbt028 CLIPPED ,g_nmbt2_d[l_ac].nmbt028_desc
   DISPLAY g_nmbt2_d[l_ac].nmbt028_desc TO s_detail2[l_ac].nmbt028_desc
END FUNCTION


# 傳票還原
PRIVATE FUNCTION anmt311_reduction()
DEFINE l_glapdocdt   LIKE glap_t.glapdocdt   #150618-00003#1
DEFINE l_scom0002    LIKE type_t.chr10       #170103-00019#14 add
DEFINE l_success     LIKE type_t.num5        #170103-00019#14 add

   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   
   #150618-00003#1--(s)
   #取得傳票日期
   SELECT glapdocdt INTO l_glapdocdt
     FROM glap_t
    WHERE glapent = g_enterprise
      AND glapld = g_nmbs_m.nmbsld
      AND glapdocno = g_nmbs_m.nmbs003   
   #150618-00003#1--(e)
   
   #170103-00019#14--add--str--
   LET g_success = 'Y'
   CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-COM-0002') RETURNING l_scom0002 
   #更新相关的细项立冲账资料
   LET l_success = TRUE
   CALL s_pre_voucher_delete_glax(g_nmbs_m.nmbsld,g_nmbs_m.nmbs003,'',l_scom0002) RETURNING l_success
   IF l_success = FALSE THEN
      LET g_success = 'N' 
   END IF
   
   IF l_scom0002 = 'Y' THEN
   #凭证作废处理
      UPDATE glap_t SET glapstus = 'X'
       WHERE glapent = g_enterprise
         AND glapld = g_nmbs_m.nmbsld
         AND glapdocno = g_nmbs_m.nmbs003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'UPDATE glap_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   ELSE
   #170103-00019#14--add--end   
      #刪除單頭
      DELETE FROM glap_t
       WHERE glapent = g_enterprise
         AND glapld = g_nmbs_m.nmbsld
         AND glapdocno = g_nmbs_m.nmbs003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'DELETE glap_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      
      #刪除單身
      DELETE FROM glaq_t
       WHERE glaqent = g_enterprise
         AND glaqld = g_nmbs_m.nmbsld
         AND glaqdocno = g_nmbs_m.nmbs003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'DELETE glaq_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
#170103-00019#14--mark--str--
#将删除现金变动码操作移到下面
#   #150807-00007#1 add ------
#   #刪除傳票產生的現金變動碼
#   CALL s_cashflow_nm_del_glbc(g_nmbs_m.nmbs004,g_nmbs_m.nmbsld,g_nmbs_m.nmbs003,'')
#        RETURNING g_sub_success,g_errno
#   IF NOT g_sub_success THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code   = g_errno
#      LET g_errparam.extend = 'DELETE glbc_t'
#      LET g_errparam.popup  = TRUE
#      CALL cl_err()
#      LET g_success = 'N'
#   END IF
#   #150807-00007#1 add end---
#170103-00019#14--mark--end
      #150618-00003#1--(s)
      #更新最大號
      LET g_prog  = 'aglt310'
      IF NOT s_aooi200_fin_del_docno(g_nmbs_m.nmbsld,g_nmbs_m.nmbs003,l_glapdocdt) THEN
         LET g_success = 'N'
      END IF
      LET g_prog  = 'anmt311'
      #150618-00003#1--(e)
   END IF #170103-00019#14 add
   
   #170103-00019#14--add--str--
   #刪除傳票產生的現金變動碼
   CALL s_cashflow_nm_del_glbc(g_nmbs_m.nmbs004,g_nmbs_m.nmbsld,g_nmbs_m.nmbs003,'')
        RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = g_errno
      LET g_errparam.extend = 'DELETE glbc_t'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   #170103-00019#14--add--end
   
   UPDATE nmbs_t SET nmbs003 = NULL,nmbs004 = NULL
    WHERE nmbsent = g_enterprise
      AND nmbsld = g_nmbs_m.nmbsld
      AND nmbsdocno = g_nmbs_m.nmbsdocno
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'update xrca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   ELSE
      LET  g_nmbs_m.nmbs003 = NULL
      LET  g_nmbs_m.nmbs004 = NULL
   END IF
   
   IF g_success = 'N' THEN
      CALL s_transaction_end('N',1)
   ELSE
      CALL s_transaction_end('Y',1)
   END IF
   
   CALL cl_err_collect_show()
   
   DISPLAY BY NAME g_nmbs_m.nmbs003
   DISPLAY BY NAME g_nmbs_m.nmbs004
END FUNCTION
#核算项说明
#如果栏位对应的核算项类型对应的资料来源为‘1’，则自组sql来抓取说明
PRIVATE FUNCTION anmt311_free_account_desc()
   DEFINE l_glae002     LIKE glae_t.glae002     #资料来源
   DEFINE l_sql         STRING                  #组的抓取资料的sql
   
   #核算项一
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0171
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0171
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt034
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt034_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt034
      CALL anmt311_make_sql_desc(g_glad0171) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt034_desc= g_rtn_fields[1]
   END IF 
 
   #核算项二
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0181
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0181
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt035  
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt035_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt035
      CALL anmt311_make_sql_desc(g_glad0181) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt035_desc= g_rtn_fields[1]
   END IF   
 
   #核算项三
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0191
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0191
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt036
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt036_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt036
      CALL anmt311_make_sql_desc(g_glad0191) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt036_desc= g_rtn_fields[1]   
   END IF     
  
   #核算项四
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0201
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0201
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt037
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt037_desc= g_rtn_fields[1]
    ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt037
      CALL anmt311_make_sql_desc(g_glad0201) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt037_desc= g_rtn_fields[1]   
   END IF   
   
   #核算项五
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0211
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0211
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt038
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt038_desc= g_rtn_fields[1]  
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt038
      CALL anmt311_make_sql_desc(g_glad0211) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt038_desc= g_rtn_fields[1]   
   END IF    
 
   #核算项六
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0221
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0221
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt039
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt039_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt039
      CALL anmt311_make_sql_desc(g_glad0221) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt039_desc= g_rtn_fields[1]   
   END IF    
   
   #核算项七
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0231
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0231
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt040
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt040_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt040
      CALL anmt311_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt040_desc= g_rtn_fields[1]   
   END IF     
  
   #核算项八
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0241
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0241
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt041
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt041_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt041
      CALL anmt311_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt041_desc= g_rtn_fields[1]   
   END IF     
  
   #核算项九
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0251
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0251
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt042
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt042_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt042
      CALL anmt311_make_sql_desc(g_glad0251) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt042_desc= g_rtn_fields[1]   
   END IF  
  
   #核算项十
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0261
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0261
      LET g_ref_fields[2] =g_nmbt2_d[l_ac].nmbt043
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt043_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt043
      CALL anmt311_make_sql_desc(g_glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_nmbt2_d[l_ac].nmbt043_desc= g_rtn_fields[1]   
   END IF  
 
END FUNCTION
# 自由核算項檢查
PRIVATE FUNCTION anmt311_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
   DEFINE p_glaf001      LIKE glaf_t.glaf001
   DEFINE p_glaf002      LIKE glaf_t.glaf002
   DEFINE p_ctrl         LIKE type_t.chr5       #控制方式1.1.允许空白，2：必输不需检查或，3：必输需要检查
   DEFINE r_errno        LIKE type_t.chr10      #错误编号
   DEFINE l_glafstus     LIKE glaf_t.glafstus
   DEFINE l_glae002      LIKE glae_t.glae002
   DEFINE l_glae003      LIKE glae_t.glae003
   DEFINE l_glae004      LIKE glae_t.glae004
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   
      LET r_errno = ''
      LET l_glae002 = ''
      LET l_glae003 = ''
      LET l_glae004 = ''
      #.抓出該类型对应的资料来源，来源档案，来源编号栏位
      SELECT glae002,glae003,glae004 INTO l_glae002,l_glae003,l_glae004 FROM glae_t
       WHERE glaeent = g_enterprise
         AND glae001 = p_glaf001
      #来源类型为1.‘基本资料’，則檢核來源編號欄位是否存在,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '1' THEN
         SELECT count(*) INTO l_cnt FROM dzeb_t
          WHERE dzeb001 = l_glae003
            AND dzeb002 = l_glae004
         IF l_cnt = 0  THEN
            LET r_errno = 'agl-00073'
            RETURN r_errno
         END IF
         #控制方式3：必输必检查
         IF p_ctrl = '3'  THEN
            #1.检查资料的有效存在
             LET l_cnt = 0
             CALL anmt311_make_sql(l_glae003,l_glae004,p_glaf002) RETURNING l_sql
             PREPARE anmt530_03_chk  FROM l_sql
             EXECUTE anmt530_03_chk INTO l_cnt             
             IF  l_cnt = 0  THEN
                 LET r_errno = 'agl-00099'
                 RETURN r_errno
             END IF
             #IF  l_glafstus = 'N'  THEN
             #    LET g_errno = 'agl-00063'
             #    RETURN r_errno
             #END IF
         END IF
      END IF
      #来源类型为2.预设值，則輸入值應檢核是否存在自由核算項資料檔,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '2' THEN
         SELECT glafstus INTO l_glafstus FROM glaf_t
             WHERE glafent = g_enterprise
               AND glaf001 = p_glaf001
               AND glaf002 = p_glaf002
         IF SQLCA.SQLCODE = 100  THEN
            LET r_errno = 'agl-00062'
            RETURN r_errno
          END IF
          IF p_ctrl = '3'  THEN
             IF l_glafstus = 'N'  THEN
                LET g_errno = 'sub-01302'   #agl-00063 #160318-00005#27  By 07900 --mod
                RETURN r_errno
             END IF
          END IF
      END IF
      #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
      RETURN r_errno
END FUNCTION
# 组检查资料存在有效的sql
PRIVATE FUNCTION anmt311_make_sql(p_glae003,p_glae004,p_glaf002)
   DEFINE p_glae003 LIKE glae_t.glae003    #来源档案
   DEFINE p_glae004 LIKE glae_t.glae004    #来源编号栏位
   DEFINE p_glaf002 LIKE glaf_t.glaf002    #核算项值
   DEFINE l_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE l_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE l_sql     STRING
   DEFINE r_sql     STRING

   LET r_sql = " SELECT count(*) FROM ",p_glae003 ,
               "  WHERE ", p_glae004," = '",p_glaf002,"'"
               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '", p_glae003,"'"
   PREPARE anmt311_make_sql_pre FROM l_sql
   DECLARE anmt311_make_sql_cs CURSOR FOR anmt311_make_sql_pre
   FOREACH anmt311_make_sql_cs INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF
      #判断是否有stus栏位
      IF l_dzeb002 LIKE '%stus'  THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='Y'"
      END IF
   END FOREACH
   RETURN r_sql
END FUNCTION
# 核算项说明
PRIVATE FUNCTION anmt311_make_sql_desc(p_glae001)
   DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
   #DEFINE p_field_value   LIKE glaf_t.glaf002   #核算项值
   DEFINE r_sql       STRING
   DEFINE l_glae003   LIKE glae_t.glae003   #来源档案
   DEFINE l_glae004   LIKE glae_t.glae004   #来源编号栏位
   DEFINE l_glae005   LIKE glae_t.glae005   #来源说明档案
   DEFINE l_glae006   LIKE glae_t.glae006   #来源说明栏位  
   DEFINE l_dzeb002   LIKE dzeb_t.dzeb002   #栏位代号
   DEFINE l_dzeb006   LIKE dzeb_t.dzeb002   #栏位属性    
   DEFINE l_sql     STRING
   DEFINE li_sql1   STRING    #抓主档表的key
   DEFINE li_sql2   STRING    #抓对应多语言表的key 
   #抓取主表的key放入数组
   DEFINE li_main    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002       
   END RECORD 
   #抓取多语言表的key放入数组
   DEFINE li_dlang    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002       
   END RECORD 
   DEFINE l_where   STRING    #组出的对应的抓取说明的where条件    
   DEFINE l_i,l_i2,l_i3       LIKE type_t.num5
    
    #初始化
    CALL li_main.clear()
    CALL li_dlang.clear()
    
   #抓取来源档案，来源说明档案，来源说明栏位
   SELECT glae003,glae004,glae005,glae006 INTO l_glae003,l_glae004,l_glae005,l_glae006 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001
      
   #抓取主档key
   LET l_i = 1
   LET li_sql1 = " SELECT dzeb002 FROM dzeb_t ",
                 "  WHERE dzeb001 = '",l_glae003,"'",
                 "    AND dzeb004 = 'Y'", 
                 "  ORDER BY dzeb021 " 
   PREPARE anmt311_pr FROM li_sql1
   DECLARE anmt311_cs1 CURSOR FOR anmt311_pr
   FOREACH anmt311_cs1 INTO li_main[l_i].dzeb002
       LET l_i = l_i +1
   END FOREACH
   #真实数组长度
   LET l_i = l_i -1  
   
   #抓取多语言档key
   LET l_i2 = 1
   LET li_sql2 = " SELECT dzeb002 FROM dzeb_t ",
                 " WHERE dzeb001 = '",l_glae005,"'" ,
                  "  AND dzeb004 = 'Y'",
                 " ORDER BY dzeb021 "
   PREPARE anmt311_pr2 FROM li_sql2
   DECLARE anmt311_cs2 CURSOR FOR anmt311_pr2
   FOREACH anmt311_cs2 INTO li_dlang[l_i2].dzeb002
       LET l_i2 = l_i2 +1
   END FOREACH
   #真实数组长度
   LET l_i2 = l_i2 -1  

   
   #组合where条件 
   LET l_where = '1=1'
   FOR  l_i3 = 1 TO  l_i 
       LET l_where = l_where," AND ", li_main[l_i3].dzeb002, " = " ,li_dlang[l_i3].dzeb002
   END FOR    
   
   #组出的基础sql   
   LET r_sql = " SELECT ", l_glae006 ," FROM ",l_glae005 ,',',l_glae003,
               " WHERE " , l_glae004," = ?",
               "   AND " ,l_where
   #组sql               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '",l_glae005,"'",
               "   AND dzeb004 = 'Y'"
   PREPARE anmt311_make_sql_pre1 FROM l_sql
   DECLARE anmt311_make_sql_cs1 CURSOR FOR anmt311_make_sql_pre1
   FOREACH anmt311_make_sql_cs1 INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF 
      
      IF l_dzeb006 = 'C800' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_dlang,"' "
      END IF

   END FOREACH
   RETURN r_sql
END FUNCTION
# 資料確認
PRIVATE FUNCTION anmt311_confirm()
DEFINE l_nmbt002     LIKE nmbt_t.nmbt002
DEFINE l_nmbt001     LIKE nmbt_t.nmbt001
DEFINE l_nmba010     LIKE nmba_t.nmba010
DEFINE l_nmba011     LIKE nmba_t.nmba011
   
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   LET g_success = 'Y'
   
   LET g_sql = "SELECT DISTINCT nmbt002,nmbt001 ",
               "  FROM nmbt_t ",
               " WHERE nmbtent = '",g_enterprise,"'",
               "   AND nmbtld = '",g_nmbs_m.nmbsld,"'",
               "   AND nmbtdocno = '",g_nmbs_m.nmbsdocno,"'"
   PREPARE anmt311_pre FROM g_sql
   DECLARE anmt311_cur CURSOR FOR anmt311_pre
   FOREACH anmt311_cur INTO l_nmbt002,l_nmbt001
      SELECT nmba010,nmba011 INTO l_nmba010,l_nmba011
        FROM nmba_t
       WHERE nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = l_nmbt002
      
      IF g_glaa014 = 'Y' THEN 
         UPDATE nmba_t SET nmba007 = g_nmbs_m.nmbsdocno
          WHERE nmbaent = g_enterprise
            AND nmbacomp = g_nmbs_m.nmbscomp
            AND nmbadocno = l_nmbt002
      END IF
      
      IF g_glaa014 = 'N' AND g_glaa008 = 'Y' THEN 
         IF cl_null(l_nmba010) THEN 
            UPDATE nmba_t SET nmba010 = g_nmbs_m.nmbsdocno
             WHERE nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = l_nmbt002
         END IF
         IF NOT cl_null(l_nmba010) AND cl_null(l_nmba011) THEN 
            UPDATE nmba_t SET nmba011 = g_nmbs_m.nmbsdocno
             WHERE nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = l_nmbt002
         END IF
      END IF
      IF SQLCA.SQLcode  THEN
         #CALL cl_errmsg('update',l_nmbt002,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'update'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'         
      END IF
   END FOREACH 
   
   IF g_success = 'N' THEN
      CALL s_transaction_end('N',1)
      #CALL cl_err_showmsg()
   ELSE
      CALL s_transaction_end('Y',1)
   END IF
   CALL cl_err_collect_show()
END FUNCTION
# 資料取消確認
PRIVATE FUNCTION anmt311_unconfirm()
   DEFINE l_nmbt002     LIKE nmbt_t.nmbt002
   DEFINE l_nmbt001     LIKE nmbt_t.nmbt001
   DEFINE l_nmba010     LIKE nmba_t.nmba010
   DEFINE l_nmba011     LIKE nmba_t.nmba011
   
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   LET g_success = 'Y'
   
   LET g_sql = "SELECT DISTINCT nmbt002,nmbt001 ",
               "  FROM nmbt_t ",
               " WHERE nmbtent = '",g_enterprise,"'",
               "   AND nmbtld = '",g_nmbs_m.nmbsld,"'",
               "   AND nmbtdocno = '",g_nmbs_m.nmbsdocno,"'"
   PREPARE anmt311_pre1 FROM g_sql
   DECLARE anmt311_cur1 CURSOR FOR anmt311_pre1
   
   FOREACH anmt311_cur1 INTO l_nmbt002,l_nmbt001
      SELECT nmba010,nmba011 INTO l_nmba010,l_nmba011
        FROM nmba_t
       WHERE nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = l_nmbt002
      IF g_glaa014 = 'Y' THEN 
         UPDATE nmba_t SET nmba007 = ''
          WHERE nmbaent = g_enterprise
            AND nmbacomp = g_nmbs_m.nmbscomp
            AND nmbadocno = l_nmbt002
            
         IF SQLCA.SQLcode  THEN
            #CALL cl_errmsg('update',l_nmbt002,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'update'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'         
         END IF
      END IF
      
      IF g_glaa014 = 'N' AND g_glaa008 = 'Y' THEN 
         IF NOT cl_null(l_nmba010) THEN 
            UPDATE nmba_t SET nmba010 = ''
             WHERE nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = l_nmbt002
            
            IF SQLCA.SQLcode  THEN
               #CALL cl_errmsg('update',l_nmbt002,'',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'update'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'         
            END IF
         END IF

         IF cl_null(l_nmba010) AND NOT cl_null(l_nmba011) THEN 
            UPDATE nmba_t SET nmba011 = ''
             WHERE nmbaent = g_enterprise
               AND nmbacomp = g_nmbs_m.nmbscomp
               AND nmbadocno = l_nmbt002
               
            IF SQLCA.SQLcode  THEN
               #CALL cl_errmsg('update',l_nmbt002,'',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'update'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'         
            END IF
         END IF 
         
      END IF
   END FOREACH 
   
   IF g_success = 'N' THEN
      CALL s_transaction_end('N',1)
      #CALL cl_err_showmsg()
   ELSE
      CALL s_transaction_end('Y',1)
   END IF
   CALL cl_err_collect_show()
END FUNCTION
# 本位幣二三欄位顯示
PRIVATE FUNCTION anmt311_visible()
   
   CALL cl_set_comp_visible('lbl_page3',TRUE) 
   IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('lbl_page3',FALSE)
   END IF 
   
   IF g_glaa015 = 'N' THEN 
      CALL cl_set_comp_visible('nmbt121_3,nmbt123_3',FALSE)
   ELSE
      CALL cl_set_comp_visible('nmbt121_3,nmbt123_3',TRUE)
   END IF
   
   IF g_glaa019 = 'N' THEN 
      CALL cl_set_comp_visible('nmbt131_3,nmbt133_3',FALSE)
   ELSE
      CALL cl_set_comp_visible('nmbt131_3,nmbt133_3',TRUE)
   END IF
   
END FUNCTION
# 核算項檢查
PRIVATE FUNCTION anmt311_fix_acc_open_chk()
   #固定核算项（agli030）
   DEFINE l_glad007       LIKE glad_t.glad007     #部門管理否
   DEFINE l_glad008       LIKE glad_t.glad008     #利潤成本中心管理
   DEFINE l_glad009       LIKE glad_t.glad009     #區域管理
   DEFINE l_glad010       LIKE glad_t.glad010     #交易客商管理
   DEFINE l_glad027       LIKE glad_t.glad027     #账款客商管理
   DEFINE l_glad011       LIKE glad_t.glad011     #客群管理否
   DEFINE l_glad012       LIKE glad_t.glad012     #產品類別
   DEFINE l_glad013       LIKE glad_t.glad013     #人員
   DEFINE l_glad014       LIKE glad_t.glad014     #预算管理否
   DEFINE l_glad015       LIKE glad_t.glad015     #专案管理否
   DEFINE l_glad016       LIKE glad_t.glad016     #wbs管理
   DEFINE l_errno         LIKE type_t.chr10
   DEFINE l_errmsg        LIKE type_t.chr80     #组合报错信息
   DEFINE l_desc          LIKE type_t.chr80     #接受s_get_orga返回值
   DEFINE l_date          LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_glaq017       LIKE glaq_t.glaq017  
   DEFINE l_nmbv001       LIKE nmbv_t.nmbv001
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_nmbt018       LIKE nmbt_t.nmbt018
   DEFINE l_nmbt019       LIKE nmbt_t.nmbt019
   DEFINE l_nmbt020       LIKE nmbt_t.nmbt020
   DEFINE l_nmbt021       LIKE nmbt_t.nmbt021
   DEFINE l_nmbt022       LIKE nmbt_t.nmbt022
   DEFINE l_nmbt023       LIKE nmbt_t.nmbt023
   DEFINE l_nmbt024       LIKE nmbt_t.nmbt024
   DEFINE l_nmbt025       LIKE nmbt_t.nmbt025
   DEFINE l_nmbt026       LIKE nmbt_t.nmbt026
   DEFINE l_nmbt027       LIKE nmbt_t.nmbt027
   DEFINE l_nmbt028       LIKE nmbt_t.nmbt028
   
   LET r_success = TRUE
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   
   LET g_sql = "SELECT nmbv001,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,",
               "       nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028 ",
               "  FROM nmbt_t,nmbv_t ",
               " WHERE nmbvent = '",g_enterprise,"'",
               "   AND nmbtent = nmbvent ",
               "   AND nmbtld = nmbvld ",
               "   AND nmbtdocno = nmbvdocno ",
               "   AND nmbvld = '",g_nmbs_m.nmbsld,"'",
               "   AND nmbtdocno = '",g_nmbs_m.nmbsdocno,"'"
   PREPARE nmbv001_pre FROM g_sql
   DECLARE nmbv001_cur CURSOR FOR nmbv001_pre
   
   FOREACH nmbv001_cur INTO l_nmbv001,l_nmbt018,l_nmbt019,l_nmbt020,l_nmbt021,l_nmbt022, 
                            l_nmbt023,l_nmbt024,l_nmbt025,l_nmbt026,l_nmbt027,l_nmbt028
      #依據帳別，科目編號，判斷該科目是否启用
      #部門管理， 利潤成本中心管理，區域管理，交易客商管理，客群管理，產品類別，人員，預算，專案，wbs管理，账款客商管理，自由核算项1~10
      #1.清空核算项管理值
      LET l_glad007 = ''  LET l_glad008 = ''  LET l_glad009 = ''  LET l_glad010 = ''  LET l_glad027 = ''   LET l_glad011 = ''
      LET l_glad012 = ''  LET l_glad013 = ''  LET l_glad014 = ''  LET l_glad015 = ''  LET l_glad016 = ''   
      #2.重新依账套，科目抓取核算项管理值(细部核算项)
      CALL anmt311_glad_set(g_nmbs_m.nmbsld,l_nmbv001,g_glaa004)
      RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad014,l_glad015,l_glad016
                
      #======================================
      #固定核算项检查
      #如果启用改固定核算项勾选，则对该核算项的值进行检查
      #======================================  
      #該科目做部門管理時，部門不可空白  
      IF l_glad007 = 'Y' THEN
         IF cl_null(l_nmbt018) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt018',l_errmsg,l_nmbv001,'agl-00043',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00043'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         #部门检查          
         CALL s_get_orga('6',l_nmbt018,'',g_nmbs_m.nmbsdocdt) 
         RETURNING l_success,l_desc,l_desc,l_desc,l_date,l_date,g_errno
         IF l_success = FALSE THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt018',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF    
      END IF
      
      #該科目做利潤成本管理時，利潤成本不可空白  
      IF l_glad008 = 'Y'  THEN
         IF cl_null(l_nmbt019) THEN
           LET r_success = FALSE
           #CALL cl_errmsg('nmbt019',l_errmsg,l_nmbv001,'agl-00044',1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'agl-00044'
           LET g_errparam.extend = l_nmbv001
           LET g_errparam.popup = TRUE
           CALL cl_err()
         END IF
         #利润成本中心检查         
         CALL s_get_orga('6',l_nmbt019,'',g_nmbs_m.nmbsdocdt) 
         RETURNING l_success,l_desc,l_desc,l_desc,l_date,l_date,g_errno
         IF l_success = FALSE THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt019',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF   
      END IF 
      
      #該科目做區域管理時，區域不可空白  
      IF l_glad009 = 'Y'  THEN
         IF cl_null(l_nmbt020) THEN
           LET r_success = FALSE
           #CALL cl_errmsg('nmbt020',l_errmsg,l_nmbv001,'agl-00045',1) 
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'agl-00045'
           LET g_errparam.extend = l_nmbv001
           LET g_errparam.popup = TRUE
           CALL cl_err()
         END IF 
         #区域检查
         CALL s_voucher_glaq020_chk('287',l_nmbt020)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt020',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'axmi021'
            LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
            LET g_errparam.exeprog = 'axmi021'           
            #160321-00016#39 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF                     
      END IF 
      
      #該科目做交易客商管理時，客商不可空白  
      IF l_glad010 = 'Y'  THEN
         IF cl_null(l_nmbt021) THEN
           LET r_success = FALSE
           #CALL cl_errmsg('nmbt021',l_errmsg,l_nmbv001,'agl-00046',1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'agl-00046'
           LET g_errparam.extend = l_nmbv001
           LET g_errparam.popup = TRUE
           CALL cl_err()
         END IF
         #客商检查
         CALL s_voucher_glaq021_chk(l_nmbt021)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt021',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'apmm100'
            LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
            LET g_errparam.exeprog = 'apmm100'
            #160321-00016#39 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF           
      END IF 
      
      #該科目做账款客商管理時，客商不可空白
      IF l_glad027 = 'Y'  THEN
         IF cl_null(l_nmbt022) THEN
           LET r_success = FALSE
           #CALL cl_errmsg('nmbt022',l_errmsg,l_nmbv001,'agl-00046',1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'agl-00046'
           LET g_errparam.extend = l_nmbv001
           LET g_errparam.popup = TRUE
           CALL cl_err()
         END IF
         #客商检查
         CALL s_voucher_glaq021_chk(l_nmbt022)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt022',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'apmm100'
            LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
            LET g_errparam.exeprog = 'apmm100'
            #160321-00016#39 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF           
      END IF 
      #該科目做客群管理時，客群不可空白  
      IF l_glad011 = 'Y'  THEN
         IF cl_null(l_nmbt023) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt023',l_errmsg,l_nmbv001,'agl-00047',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00047'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
             #区域检查
            CALL s_voucher_glaq020_chk('281',l_nmbt023)
            IF NOT cl_null(g_errno) THEN
               LET r_success = FALSE
               #CALL cl_errmsg('nmbt023',l_errmsg,l_nmbv001,g_errno,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = l_nmbv001
               #160321-00016#39 --s add
               LET g_errparam.replace[1] = 'axmi027'
               LET g_errparam.replace[2] = cl_get_progname('axmi027',g_lang,"2")
               LET g_errparam.exeprog = 'axmi027'           
               #160321-00016#39 --e add
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF                     
         END IF
      END IF 
      
      #該科目做產品分類管理時，不可空白  
      IF l_glad012 = 'Y'  THEN
         IF cl_null(l_nmbt024) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt024',l_errmsg,l_nmbv001,'agl-00068',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00068'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         #产品分类检查 
         CALL s_voucher_glaq024_chk(l_nmbt024)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt024',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'arti202'
            LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
            LET g_errparam.exeprog = 'arti202'
            #160321-00016#39 --e add 
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF           
      END IF 
      
      #該科目做人員管理時，不可空白  
      IF l_glad013 = 'Y'  THEN
         IF cl_null(l_nmbt025) THEN
           LET r_success = FALSE
           #CALL cl_errmsg('nmbt025',l_errmsg,l_nmbv001,'agl-00069',1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'agl-00069'
           LET g_errparam.extend = l_nmbv001
           LET g_errparam.popup = TRUE
           CALL cl_err()
         END IF
         #人员检查
         CALL s_voucher_glaq013_chk(l_nmbt025)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt025',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'aooi130'
            LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
            LET g_errparam.exeprog = 'aooi130'
            #160321-00016#39 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF           
      END IF 
      
      #該科目做預算管理時，不可空白  
      IF l_glad014 = 'Y'  THEN
         IF cl_null(l_nmbt026) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt026',l_errmsg,l_nmbv001,'agl-00070',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00070'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         #预算检查
         CALL s_voucher_glaq026_chk(l_nmbt026)
         IF NOT cl_null(g_errno) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt026',l_errmsg,l_nmbv001,g_errno,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = l_nmbv001
            #160321-00016#39 --s add
            LET g_errparam.replace[1] = 'abgi010'
            LET g_errparam.replace[2] = cl_get_progname('abgi010',g_lang,"2")
            LET g_errparam.exeprog = 'abgi010'
            #160321-00016#39 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF           
      END IF
      
      #該科目做專案管理時，不可空白  
      IF l_glad015 = 'Y'  THEN
         IF cl_null(l_nmbt027) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt027',l_errmsg,l_nmbv001,'agl-00071',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00071'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF 
      END IF 
      
      #該科目做WBS管理時，不可空白  
      IF l_glad016 = 'Y'  THEN
         IF cl_null(l_nmbt028) THEN
            LET r_success = FALSE
            #CALL cl_errmsg('nmbt028',l_errmsg,l_nmbv001,'agl-00072',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00072'
            LET g_errparam.extend = l_nmbv001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF 
      END IF
      
   END FOREACH 
   
   RETURN r_success
END FUNCTION
#
PRIVATE FUNCTION anmt311_glad_set(p_ld,p_subj,p_glaa004)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_subj          LIKE glaq_t.glaq002
   DEFINE p_glaa004       LIKE glaa_t.glaa004
   #科目核算项
   DEFINE r_glad007       LIKE glad_t.glad007
   DEFINE r_glad008       LIKE glad_t.glad008
   DEFINE r_glad009       LIKE glad_t.glad009
   DEFINE r_glad010       LIKE glad_t.glad010
   DEFINE r_glad027       LIKE glad_t.glad027
   DEFINE r_glad011       LIKE glad_t.glad011
   DEFINE r_glad012       LIKE glad_t.glad012
   DEFINE r_glad013       LIKE glad_t.glad013
   DEFINE r_glad014       LIKE glad_t.glad014
   DEFINE r_glad015       LIKE glad_t.glad015
   DEFINE r_glad016       LIKE glad_t.glad016
   DEFINE l_cnt           LIKE type_t.num5
   
   LET l_cnt = 0
   #agli020已加入核算项管理的勾选,未来应用都改成先抓agli030(细的),抓不到再抓agli020(粗的)
   #==>glad_t 若找不到該科目  就到agli020裡去抓
   SELECT COUNT(*) INTO l_cnt FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld = p_ld
      AND glad001 = p_subj
   IF l_cnt <> 0 THEN   
      #依據帳別，科目編號，判斷該科目是否做部門管理，利潤成本中心管理，區域管理，客商管理，帳款客商管理，客群管理，產品類別，人員，預算，專案，wbs管理
      SELECT glad007,glad008,glad009,glad010,glad027,glad011,glad012,glad013,glad014,glad015,glad016 
        INTO r_glad007,r_glad008,r_glad009,r_glad010,r_glad027,r_glad011,r_glad012,r_glad013,r_glad014,r_glad015,r_glad016
        FROM glad_t
      WHERE gladent = g_enterprise
        AND gladld = p_ld
        AND glad001 = p_subj     
   ELSE
      #依據帳別，科目編號，判斷該科目是否做部門管理， 利潤成本中心管理，區域管理，客商管理，帳款客商管理，客群管理，產品類別，人員，預算，專案，wbs管理
      SELECT glac017,glac018,glac019,glac020,glac027,glac021,glac022,glac023,glac024,glac025,glac026 
        INTO r_glad007,r_glad008,r_glad009,r_glad010,r_glad027,r_glad011,r_glad012,r_glad013,r_glad014,r_glad015,r_glad016
        FROM glac_t
      WHERE glacent = g_enterprise
        AND glac001 = p_glaa004
        AND glac002 = p_subj
   END IF 
   #如果核算项没有启用，则不需开出子视窗  
   RETURN r_glad007,r_glad008,r_glad009,r_glad010,r_glad027,r_glad011,r_glad012,r_glad013,r_glad014,r_glad015,r_glad016
END FUNCTION
# 帳務組織名稱
PRIVATE FUNCTION anmt311_nmbssite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbssite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbssite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbssite_desc
END FUNCTION
#
PRIVATE FUNCTION anmt311_change_to_sql(p_wc)
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
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt311_nmbt029_desc()
#                 
# Date & Author..: 日期 By 作者
# Modify.........: 
################################################################################
PRIVATE FUNCTION anmt311_nmbt029_desc()
DEFINE l_glaa004  LIKE glaa_t.glaa004
  LET l_glaa004 = ''
  SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmbs_m.nmbsld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = g_nmbt_d[l_ac].nmbt029
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","")
                 RETURNING g_rtn_fields
  LET g_nmbt_d[l_ac].nmbt029_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_nmbt_d[l_ac].nmbt029_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt311_nmbt030_desc()
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt030_desc()
DEFINE l_glaa004  LIKE glaa_t.glaa004
  LET l_glaa004 = ''
  SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmbs_m.nmbsld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = g_nmbt_d[l_ac].nmbt030
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","")
                 RETURNING g_rtn_fields
  LET g_nmbt_d[l_ac].nmbt030_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_nmbt_d[l_ac].nmbt030_desc
  
  
  
  
  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt311_nmbt033_desc()
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt033_desc()
 INITIALIZE g_ref_fields TO NULL
 LET g_ref_fields[1] = g_nmbt2_d[l_ac].nmbt033
 CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
 LET g_nmbt2_d[l_ac].nmbt033_desc = '', g_rtn_fields[1] , ''
 LET g_nmbt2_d[l_ac].nmbt033_desc = g_nmbt2_d[l_ac].nmbt033 CLIPPED,g_nmbt2_d[l_ac].nmbt033_desc #161221-00054#3 
 DISPLAY BY NAME g_nmbt2_d[l_ac].nmbt033_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt311_nmbt029_check()
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt029_check()
 #总体说明：若启用该核算项管理则对应控制方式为2.必须输入不检查，3.必须输入必检查，则栏位不可空白，为1时可以空白，否则栏位>
   SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
          glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,
          glad023,glad0231,glad0232,glad024,glad0221,glad0242,
          glad025,glad0251,glad0252,glad026,glad0261,glad0262
    INTO  g_glad017,g_glad0171,g_glad0172,g_glad018,g_glad0181,g_glad0182,
          g_glad019,g_glad0191,g_glad0192,g_glad020,g_glad0201,g_glad0202,
          g_glad021,g_glad0211,g_glad0212,g_glad022,g_glad0221,g_glad0222,
          g_glad023,g_glad0231,g_glad0232,g_glad024,g_glad0241,g_glad0242,
          g_glad025,g_glad0251,g_glad0252,g_glad026,g_glad0261,g_glad0262
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_nmbs_m.nmbsld
      AND glad001 = g_nmbt_d[l_ac].nmbt029
      
   
#  #啟用自由核算項一
#  IF g_glad017 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt034',TRUE)
#     IF g_glad0172 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt034',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt034,nmbt034_desc',FALSE)
#  END IF
#
#  #啟用自由核算項二
#  IF g_glad018 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt035',TRUE)
#     IF g_glad0182 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt035',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt035,nmbt035_desc',FALSE)
#  END IF 
#
#   #啟用自由核算項三
#  IF g_glad019 = 'Y'  THEN
#      CALL cl_set_comp_entry('nmbt036',TRUE)
#     IF g_glad0192 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt036',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt036,nmbt036_desc',FALSE)
#  END IF
#
#  #啟用自由核算項四
#  IF g_glad020 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt037',TRUE)
#     IF g_glad0202 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt037',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt037,nmbt037_desc',FALSE)
#  END IF
#  
#   #啟用自由核算項五
#  IF g_glad021 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt038',TRUE)
#     IF g_glad0212 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt038',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt038,nmbt038_desc',FALSE)
#  END IF
#  
#  #啟用自由核算項六
#  IF g_glad022 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt039',TRUE)
#     IF g_glad0222 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt039',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt039,nmbt039_desc',FALSE)
#  END IF
#
#  #啟用自由核算項七
#  IF g_glad023 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt040',TRUE)
#     IF g_glad0232 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt040',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt040,nmbt040_desc',FALSE)
#  END IF
#
#   #啟用自由核算項八
#  IF g_glad024 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt041',TRUE)
#     IF g_glad0242 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt041',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt041,nmbt041_desc',FALSE)
#  END IF
#
#  #啟用自由核算項九
#  IF g_glad025 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt042',TRUE)
#     IF g_glad0252 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt042',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt042,nmbt042_desc',FALSE)
#  END IF
#  
#  
#  #啟用自由核算項十
#  IF g_glad026 = 'Y'  THEN
#     CALL cl_set_comp_entry('nmbt043',TRUE)
#     IF g_glad0262 MATCHES'[23]' THEN
#        CALL cl_set_comp_required('nmbt043',TRUE)
#     END IF
#  ELSE
#     CALL cl_set_comp_visible('nmbt043,nmbt043_desc',FALSE)
#  END IF
   
END FUNCTION

################################################################################
# Descriptions...: 抓取待结算卡回款插入账务处理单身
# Memo...........:
# Usage..........: CALL anmt311_nmbt_get_7(p_nmbt002,p_nmbt003)
#                  RETURNING 回传参数
# Input parameter: p_nmbt002      单号
#                : p_nmbt003      项次
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt_get_7(p_nmbt002,p_nmbt003)
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   DEFINE l_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbt014      LIKE nmbt_t.nmbt014
   DEFINE l_nmbt017      LIKE nmbt_t.nmbt017
   DEFINE l_nmbt018      LIKE nmbt_t.nmbt018
   DEFINE l_nmbt019      LIKE nmbt_t.nmbt019
   DEFINE l_nmbt021      LIKE nmbt_t.nmbt021
   DEFINE l_nmbt022      LIKE nmbt_t.nmbt022
   DEFINE l_nmbt025      LIKE nmbt_t.nmbt025
   DEFINE l_nmbt100      LIKE nmbt_t.nmbt100
   DEFINE l_nmbt101      LIKE nmbt_t.nmbt101
   DEFINE l_nmbt103_1    LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113_1    LIKE nmbt_t.nmbt113
   DEFINE l_nmbt121      LIKE nmbt_t.nmbt121
   DEFINE l_nmbt131      LIKE nmbt_t.nmbt131
   DEFINE l_nmbt123_1    LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133_1    LIKE nmbt_t.nmbt133
   DEFINE l_nmbt103_2    LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113_2    LIKE nmbt_t.nmbt113
   DEFINE l_nmbt123_2    LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133_2    LIKE nmbt_t.nmbt133
   DEFINE l_nmbt103_3    LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113_3    LIKE nmbt_t.nmbt113
   DEFINE l_nmbt123_3    LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133_3    LIKE nmbt_t.nmbt133
   DEFINE l_ooam003      LIKE ooam_t.ooam003
   DEFINE l_nmbt029_1    LIKE nmbt_t.nmbt029
   DEFINE l_nmbt029_2    LIKE nmbt_t.nmbt029
   DEFINE l_nmbt029_3    LIKE nmbt_t.nmbt029
   DEFINE l_nmec006      LIKE nmec_t.nmec006
   DEFINE l_nmec008      LIKE nmec_t.nmec008
   DEFINE l_nmec009      LIKE nmec_t.nmec009
   DEFINE l_nmec011      LIKE nmec_t.nmec011
   DEFINE l_nmec012      LIKE nmec_t.nmec012
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #科目2：anmi152 会增加一项维护手续费的科目
   LET l_nmbt029_2 = ''
   SELECT glab005 INTO l_nmbt029_2 FROM glab_t
    WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
     AND glab001='41' AND glab002='8714' AND glab003='G'
    
   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = g_nmbs_m.nmbsdocno
    
   IF cl_null(l_nmbtseq) THEN 
      LET l_nmbtseq = 0
   END IF
           
               #        單號/     項次/   營運據點  /繳款部門/
   LET g_sql = " SELECT nmecdocno,nmecseq,nmecsite,nmba001,",
               #        交易對象/繳款人員/收款金額/手續費/總金額  
               "        nmba004,nmba008,nmec006,nmec008,nmec009,",
               #        交易帐户编号/款別類型/款別
               "        nmec018,   nmec011, nmec012",
               "   FROM nmba_t,nmec_t ",
               "  WHERE nmbaent = nmecent",
               "    AND nmbacomp = nmeccomp ",
               "    AND nmbadocno = nmecdocno ",
               "    AND nmbaent = '",g_enterprise,"'",
               "    AND nmba003 = 'anmt561'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'"
   IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
      LET g_sql=g_sql," AND nmecsite = '",g_nmbt_d[l_ac].nmbt017,"'"
   END IF
   IF NOT cl_null(p_nmbt003) THEN
      LET g_sql=g_sql, " AND nmecseq = ",p_nmbt003
   END IF
   
   PREPARE nmba_pre_7 FROM g_sql
   DECLARE nmba_cur_7 CURSOR FOR nmba_pre_7
   FOREACH nmba_cur_7 INTO l_nmbt002,l_nmbt003,l_nmbt017,l_nmbt018,
                         l_nmbt021,l_nmbt025,l_nmec006,l_nmec008,l_nmec009,
                         l_nmbt014,l_nmec011,l_nmec012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:nmba_cur_7' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #項次
      LET l_nmbtseq = l_nmbtseq + 1
     
      #幣別=帳套本位幣一，匯率=1
      LET l_nmbt100 = g_glaa001
      LET l_nmbt101 = 1
      #利潤/成本中心
      SELECT ooeg004 INTO l_nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt018
      #帳款客商   
      LET l_nmbt022 = l_nmbt021
      
      #1）存入第一筆資料：異動別=1.存入；金額=收款金額
      #原幣金額
      LET l_nmbt103_1 = l_nmec006
      #本幣金額
      LET l_nmbt113_1 = l_nmec006
      #科目1：anmi121 交易账户nmec018对应的科目
      LET l_nmbt029_1 = ''
      SELECT glab005 INTO l_nmbt029_1 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='40' AND glab002='40' AND glab003=l_nmbt014
     
      #2)當手續費不為零時存入一筆手續費資料：異動別=3.借方科目；金額=手續費
      #原幣金額
      LET l_nmbt103_2 = l_nmec008
      #本幣金額
      LET l_nmbt113_2 = l_nmec008
      
      #3）存入第三筆對應的貸方資料：異動別=4.貸方科目；金額=合計金額
      #原幣金額
      LET l_nmbt103_3 = l_nmec009
      #本幣金額
      LET l_nmbt113_3 = l_nmec009
      #科目3：agli190 款别对应会科
      LET l_nmbt029_3 = ''
      SELECT glab007 INTO l_nmbt029_3 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='21' AND glab002=l_nmec011 AND glab003=l_nmec012
      
      IF g_glaa014 = 'Y' THEN 
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;          來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121  
             LET l_nmbt123_1 = l_nmbt113_1 * l_nmbt121
             LET l_nmbt123_2 = l_nmbt113_2 * l_nmbt121
             LET l_nmbt123_3 = l_nmbt113_3 * l_nmbt121
             
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_1,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_1  
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_2,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_2   
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_3,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_3                  
            #160413-00025#1 add--end--             
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;           來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133_1 = l_nmbt113_1 * l_nmbt131
            LET l_nmbt133_2 = l_nmbt113_2 * l_nmbt131
            LET l_nmbt133_3 = l_nmbt113_3 * l_nmbt131
            
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_1,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_1  
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_2,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_2   
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_3,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_3                  
            #160413-00025#1 add--end--      
            
         END IF
      END IF
      
      #平行賬套,金額匯率重新計算
      IF g_glaa014 <> 'Y' AND g_glaa008 = 'Y' THEN 
         LET l_nmbt101 = 0
         LET l_nmbt113_1 = 0
         LET l_nmbt113_2 = 0
         LET l_nmbt113_3 = 0
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源      #150930-00010#4
         #平行賬套匯率
                                    #日期;             來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_nmbt100,g_glaa001,g_para_data)                      
         RETURNING l_nmbt101   
         LET l_nmbt113_1 = l_nmbt103_1 * l_nmbt101
         LET l_nmbt113_2 = l_nmbt103_2 * l_nmbt101
         LET l_nmbt113_3 = l_nmbt103_3 * l_nmbt101
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;            來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121   
             LET l_nmbt123_1 = l_nmbt113_1 * l_nmbt121
             LET l_nmbt123_2 = l_nmbt113_2 * l_nmbt121
             LET l_nmbt123_3 = l_nmbt113_3 * l_nmbt121
             
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_1,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_1  
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_2,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_2   
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123_3,2)
               RETURNING g_sub_success,g_errno,l_nmbt123_3                  
            #160413-00025#1 add--end-- 
            
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;            來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133_1 = l_nmbt113_1 * l_nmbt131
            LET l_nmbt133_2 = l_nmbt113_2 * l_nmbt131
            LET l_nmbt133_3 = l_nmbt113_3 * l_nmbt131
            
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_1,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_1  
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_2,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_2   
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133_3,2)
               RETURNING g_sub_success,g_errno,l_nmbt133_3                  
            #160413-00025#1 add--end--             
         END IF
      END IF
      
      #1）插入第一筆應收金額 
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,
                         nmbt001,nmbt002,nmbt003,nmbt100,nmbt101,nmbt103,nmbt113,
                         nmbt013,nmbt014,nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,
                         nmbt025,nmbt121,nmbt123,nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '7',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103_1,l_nmbt113_1,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123_1,l_nmbt131,l_nmbt133_1,l_nmbt029_1,'1')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_1,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
      
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
      #2)當手續費不等與零時，插入一筆手續費資料
      IF l_nmec008 <> 0 THEN
         LET l_nmbtseq = l_nmbtseq + 1
         INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                            nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                            nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                            nmbt131,nmbt133,nmbt029,nmbt004,
                            #151111-00001#1--add--str--lujh
                            nmbt034,nmbt035,nmbt036,nmbt037,
                            nmbt038,nmbt039,nmbt040,nmbt041,
                            nmbt042,nmbt043
                            #151111-00001#1--add--end--lujh
                            ) 
                     VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                            '7',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103_2,l_nmbt113_2,
                            g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                            l_nmbt025,l_nmbt121,l_nmbt123_2,l_nmbt131,l_nmbt133_2,l_nmbt029_2,'3',
                            #151111-00001#1--add--str--lujh
                            g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                            g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                            g_free_m.free_item_9,g_free_m.free_item_10
                            #151111-00001#1--add--end--lujh
                            )
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET g_success = 'N'         
         END IF
         
         #151111-00001#1--add--str--lujh
         LET g_free_m.free_item_1 = ''
         LET g_free_m.free_item_2 = ''
         LET g_free_m.free_item_3 = ''
         LET g_free_m.free_item_4 = ''
         LET g_free_m.free_item_5 = ''
         LET g_free_m.free_item_6 = ''
         LET g_free_m.free_item_7 = ''
         LET g_free_m.free_item_8 = ''
         LET g_free_m.free_item_9 = ''
         LET g_free_m.free_item_10 = ''
         
         LET g_field_m.field1 = 'nmbt034'
         LET g_field_m.field2 = 'nmbt035'
         LET g_field_m.field3 = 'nmbt036'
         LET g_field_m.field4 = 'nmbt037'
         LET g_field_m.field5 = 'nmbt038'
         LET g_field_m.field6 = 'nmbt039'
         LET g_field_m.field7 = 'nmbt040'
         LET g_field_m.field8 = 'nmbt041'
         LET g_field_m.field9 = 'nmbt042'
         LET g_field_m.field10 = 'nmbt043'
         
         CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_2,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
         RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                   g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                   g_free_m.free_item_9,g_free_m.free_item_10
                   
         UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
          WHERE nmbtent = g_enterprise
            AND nmbtdocno = g_nmbs_m.nmbsdocno
            AND nmbtld = g_nmbs_m.nmbsld
            AND nmbtseq = l_nmbtseq
            
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET g_success = 'N'         
         END IF
         #151111-00001#1--add--end--lujh
         
      END IF
      #3）插入一筆貸方合計金額
      LET l_nmbtseq = l_nmbtseq + 1
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '7',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103_3,l_nmbt113_3,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123_3,l_nmbt131,l_nmbt133_3,l_nmbt029_3,'4')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_3,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
   END FOREACH 
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()
   
END FUNCTION

################################################################################
# Descriptions...: 抓取营业款存缴资料插入账务处理单身
# Memo...........:
# Usage..........: CALL anmt311_nmbt_get_8(p_nmbt002,p_nmbt003)
#                  RETURNING 回传参数
# Input parameter: p_nmbt002      营业款存缴单号
#                : p_nmbt003      项次
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt_get_8(p_nmbt002,p_nmbt003)
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   DEFINE l_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbt014      LIKE nmbt_t.nmbt014
   DEFINE l_nmbt017      LIKE nmbt_t.nmbt017
   DEFINE l_nmbt018      LIKE nmbt_t.nmbt018
   DEFINE l_nmbt019      LIKE nmbt_t.nmbt019
   DEFINE l_nmbt021      LIKE nmbt_t.nmbt021
   DEFINE l_nmbt022      LIKE nmbt_t.nmbt022
   DEFINE l_nmbt025      LIKE nmbt_t.nmbt025
   DEFINE l_nmbt100      LIKE nmbt_t.nmbt100
   DEFINE l_nmbt101      LIKE nmbt_t.nmbt101
   DEFINE l_nmbt103      LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113      LIKE nmbt_t.nmbt113
   DEFINE l_nmbt121      LIKE nmbt_t.nmbt121
   DEFINE l_nmbt131      LIKE nmbt_t.nmbt131
   DEFINE l_nmbt123      LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133      LIKE nmbt_t.nmbt133
   DEFINE l_ooam003      LIKE ooam_t.ooam003
   DEFINE l_nmbt029_1    LIKE nmbt_t.nmbt029
   DEFINE l_nmbt029_2    LIKE nmbt_t.nmbt029
   DEFINE l_deal007      LIKE deal_t.deal007
   DEFINE l_deal005      LIKE deal_t.deal005
   DEFINE l_deal006      LIKE deal_t.deal006
   DEFINE l_deaksite     LIKE deak_t.deaksite
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = g_nmbs_m.nmbsdocno
    
   IF cl_null(l_nmbtseq) THEN 
      LET l_nmbtseq = 0
   END IF
   IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
      LET l_deaksite=g_nmbt_d[l_ac].nmbt017
   ELSE
      LET l_deaksite=g_nmbs_m.nmbscomp
   END IF
               #        單號/     項次/   營運據點  /繳款部門/
   LET g_sql = " SELECT dealdocno,dealseq,dealsite,deakunit,",
               #        繳款人員/存款金額  
               "        deak002,deal007,",
               #        帳戶編號/款別類型/款別
               "        deal002,deal005,deal006",
               "   FROM deak_t,deal_t ",
               "  WHERE deakent = dealent",
               "    AND deakdocno = dealdocno ",
               "    AND deakent = '",g_enterprise,"'",
               "    AND deaksite = '",l_deaksite,"'",
               "    AND deakdocno = '",p_nmbt002,"'"
   IF NOT cl_null(p_nmbt003) THEN
      LET g_sql=g_sql," AND dealseq = ",p_nmbt003
   END IF   
   
   PREPARE nmba_pre_8 FROM g_sql
   DECLARE nmba_cur_8 CURSOR FOR nmba_pre_8
   FOREACH nmba_cur_8 INTO l_nmbt002,l_nmbt003,l_nmbt017,l_nmbt018,
                           l_nmbt025,l_deal007,
                           l_nmbt014,l_deal005,l_deal006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:nmba_cur_8' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #項次
      LET l_nmbtseq = l_nmbtseq + 1
     
      #幣別=帳套本位幣一，匯率=1
      LET l_nmbt100 = g_glaa001
      LET l_nmbt101 = 1
      #利潤/成本中心
      SELECT ooeg004 INTO l_nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt018
      #原幣金額
      LET l_nmbt103 = l_deal007
      #本幣金額
      LET l_nmbt113 = l_deal007
      
      #1）存入第一筆資料：異動別=1.存入；金額=存款金額
      #科目1：anmi121 交易账户deal003对应的科目
      LET l_nmbt029_1 = ''
      SELECT glab005 INTO l_nmbt029_1 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='40' AND glab002='40' AND glab003=l_nmbt014
     
     
      #2）存入第二筆對應的貸方資料：異動別=4.貸方科目；金額=存款金額
      #科目3：agli190 款别对应会科
      LET l_nmbt029_2 = ''
      SELECT glab005 INTO l_nmbt029_2 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='21' AND glab002=l_deal005 AND glab003=l_deal006
      
      IF g_glaa014 = 'Y' THEN 
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;          來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121  
             LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--             
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;           來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--              
         END IF
      END IF
      
      #平行賬套,金額匯率重新計算
      IF g_glaa014 <> 'Y' AND g_glaa008 = 'Y' THEN 
         LET l_nmbt101 = 0
         LET l_nmbt113 = 0
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源      #150930-00010#4      
         #平行賬套匯率
                                    #日期;             來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_nmbt100,g_glaa001,g_para_data)                      
         RETURNING l_nmbt101   
         LET l_nmbt113 = l_nmbt103 * l_nmbt101
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;            來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121   
             LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--             
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;            來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--              
         END IF
      END IF
      
      #1）插入第一筆應收金額 
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '8',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_1,'1')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_1,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
      #2）插入一筆貸方合計金額
      LET l_nmbtseq = l_nmbtseq + 1
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '8',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_2,'4')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_2,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
   END FOREACH 
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()
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
PRIVATE FUNCTION anmt311_nmbt_get_9(p_nmbt002,p_nmbt003)
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   DEFINE l_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbt014      LIKE nmbt_t.nmbt014
   DEFINE l_nmbt017      LIKE nmbt_t.nmbt017
   DEFINE l_nmbt018      LIKE nmbt_t.nmbt018
   DEFINE l_nmbt019      LIKE nmbt_t.nmbt019
   DEFINE l_nmbt021      LIKE nmbt_t.nmbt021
   DEFINE l_nmbt022      LIKE nmbt_t.nmbt022
   DEFINE l_nmbt025      LIKE nmbt_t.nmbt025
   DEFINE l_nmbt100      LIKE nmbt_t.nmbt100
   DEFINE l_nmbt101      LIKE nmbt_t.nmbt101
   DEFINE l_nmbt103      LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113      LIKE nmbt_t.nmbt113
   DEFINE l_nmbt121      LIKE nmbt_t.nmbt121
   DEFINE l_nmbt131      LIKE nmbt_t.nmbt131
   DEFINE l_nmbt123      LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133      LIKE nmbt_t.nmbt133
   DEFINE l_ooam003      LIKE ooam_t.ooam003
   DEFINE l_nmbt029_1    LIKE nmbt_t.nmbt029
   DEFINE l_nmbt029_2    LIKE nmbt_t.nmbt029
   DEFINE l_deac007      LIKE deal_t.deal007
   DEFINE l_deac005      LIKE deac_t.deac005
   DEFINE l_deac006      LIKE deac_t.deac006
   DEFINE l_deabsite     LIKE deab_t.deabsite
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = g_nmbs_m.nmbsdocno
    
   IF cl_null(l_nmbtseq) THEN 
      LET l_nmbtseq = 0
   END IF
   IF NOT cl_null(g_nmbt_d[l_ac].nmbt017) THEN
      LET l_deabsite=g_nmbt_d[l_ac].nmbt017
   ELSE
      LET l_deabsite=g_nmbs_m.nmbscomp
   END IF
               #        單號/     項次/   營運據點  /繳款部門/
   LET g_sql = " SELECT deacdocno,deacseq,deacsite,deacunit,",
               #        繳款人員/存款金額  
               "        deab002,deac007,",
               #        帳戶編號/款別類型/款別
               "        deac002,deac005,deac006",
               "   FROM deab_t,deac_t ",
               "  WHERE deabent = deacent",
               "    AND deabdocno = deacdocno ",
               "    AND deabent = '",g_enterprise,"'",
               "    AND deabsite = '",l_deabsite,"'",
               "    AND deabdocno = '",p_nmbt002,"'"
   IF NOT cl_null(p_nmbt003) THEN
      LET g_sql=g_sql," AND deacseq = ",p_nmbt003
   END IF   
   
   PREPARE deab_pre FROM g_sql
   DECLARE deab_cur CURSOR FOR deab_pre
   FOREACH deab_cur INTO l_nmbt002,l_nmbt003,l_nmbt017,
                         l_nmbt018,l_nmbt025,l_deac007,
                         l_nmbt014,l_deac005,l_deac006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:deab_cur' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #項次
      LET l_nmbtseq = l_nmbtseq + 1
     
      #幣別=帳套本位幣一，匯率=1
      LET l_nmbt100 = g_glaa001
      LET l_nmbt101 = 1
      #利潤/成本中心
      SELECT ooeg004 INTO l_nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt018
      #原幣金額
      LET l_nmbt103 = l_deac007
      #本幣金額
      LET l_nmbt113 = l_deac007
      
      #1）存入第一筆資料：異動別=1.存入；金額=存款金額
      #科目1：anmi121 交易账户deal003对应的科目
      LET l_nmbt029_1 = ''
      SELECT glab005 INTO l_nmbt029_1 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='40' AND glab002='40' AND glab003=l_nmbt014
     
     
      #2）存入第二筆對應的貸方資料：異動別=4.貸方科目；金額=存款金額
      #科目3：agli190 款别对应会科
      LET l_nmbt029_2 = ''
      SELECT glab005 INTO l_nmbt029_2 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='21' AND glab002=l_deac005 AND glab003=l_deac006
      
      IF g_glaa014 = 'Y' THEN 
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;          來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121  
             LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--             
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;           來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--              
         END IF
      END IF
      
      #平行賬套,金額匯率重新計算
      IF g_glaa014 <> 'Y' AND g_glaa008 = 'Y' THEN 
         LET l_nmbt101 = 0
         LET l_nmbt113 = 0
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源      #150930-00010#4
         #平行賬套匯率
                                    #日期;             來源幣別   目的幣別; 匯類類型
         CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_nmbt100,g_glaa001,g_para_data)                      
         RETURNING l_nmbt101   
         LET l_nmbt113 = l_nmbt103 * l_nmbt101
         IF g_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF g_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = g_glaa001
             END IF
                                        #日期;            來源幣別   目的幣別; 匯類類型
             CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa016,g_glaa018)                      
             RETURNING l_nmbt121   
             LET l_nmbt123 = l_nmbt113 * l_nmbt121
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa016,l_nmbt123,2)
               RETURNING g_sub_success,g_errno,l_nmbt123            
            #160413-00025#1 add--end--              
         END IF
          
         IF g_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF g_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = g_glaa001
            END IF
                                       #日期;            來源幣別   目的幣別; 匯類類型
            CALL anmt311_get_exrate(g_nmbs_m.nmbsdocdt,l_ooam003,g_glaa020,g_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
            #160413-00025#1 add--str--
            CALL s_curr_round_ld('1',g_nmbs_m.nmbsld,g_glaa020,l_nmbt133,2)
               RETURNING g_sub_success,g_errno,l_nmbt133            
            #160413-00025#1 add--end--              
         END IF
      END IF
      
      #1）插入第一筆應收金額 
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '9',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_1,'1')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_1,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
      #2）插入一筆貸方合計金額
      LET l_nmbtseq = l_nmbtseq + 1
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,l_nmbtseq,
                         '9',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_2,'4')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(g_nmbs_m.nmbsld,l_nmbt029_2,g_prog,g_nmbs_m.nmbsdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = g_nmbs_m.nmbsdocno
         AND nmbtld = g_nmbs_m.nmbsld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
   END FOREACH 
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()
END FUNCTION
################################################################################
# Descriptions...: 抓取繳款匯總單资料插入账务处理单身
# Memo...........:
# Usage..........: CALL anmt311_nmbt_get_10(p_nmbt002,p_nmbt003)
#                  RETURNING 回传参数
# Input parameter: p_nmbt002      繳款匯總單单号
#                : p_nmbt003      项次
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_nmbt_get_10(p_nmbt002,p_nmbt003)
   DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbadocno    LIKE nmba_t.nmbadocno
   DEFINE l_nmbacomp     LIKE nmba_t.nmbacomp
   DEFINE l_nmbbseq      LIKE nmbb_t.nmbbseq
   DEFINE l_nmba001      LIKE nmba_t.nmba001
   DEFINE l_nmba008      LIKE nmba_t.nmba008
   DEFINE l_nmbb004      LIKE nmbb_t.nmbb004
   DEFINE l_nmbb005      LIKE nmbb_t.nmbb005
   DEFINE l_nmbb006      LIKE nmbb_t.nmbb006
   DEFINE l_nmbb028      LIKE nmbb_t.nmbb028
   DEFINE l_nmee006      LIKE nmee_t.nmee006
   DEFINE l_nmee009      LIKE nmee_t.nmee009
   DEFINE l_nmee018      LIKE nmee_t.nmee018
   DEFINE l_glab005      LIKE glab_t.glab005
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   #160509-00004#28 add by liyan --str--
   DEFINE l_nmee022      LIKE nmee_t.nmee022,
          l_nmee020      LIKE nmee_t.nmee020,
          l_nmee003      LIKE nmee_t.nmee003
   #160509-00004#28 add by liyan --end--
   DEFINE l_nmbt         RECORD
             nmbtent        LIKE nmbt_t.nmbtent,     #企業編號
             nmbtcomp       LIKE nmbt_t.nmbtcomp,    #法人
             nmbtld         LIKE nmbt_t.nmbtld,      #帳別(套)編號
             nmbtdocno      LIKE nmbt_t.nmbtdocno,   #帳務編號
             nmbtseq        LIKE nmbt_t.nmbtseq,     #項次
             nmbt001        LIKE nmbt_t.nmbt001,     #單據來源
             nmbt002        LIKE nmbt_t.nmbt002,     #來源單號
             nmbt003        LIKE nmbt_t.nmbt003,     #來源單項次
             nmbt011        LIKE nmbt_t.nmbt011,     #票據號碼
             nmbt012        LIKE nmbt_t.nmbt012,     #票據日期
             nmbt013        LIKE nmbt_t.nmbt013,     #申請人
             nmbt014        LIKE nmbt_t.nmbt014,     #銀行帳號
             nmbt015        LIKE nmbt_t.nmbt015,     #結算方式
             nmbt016        LIKE nmbt_t.nmbt016,     #收支項目
             nmbt017        LIKE nmbt_t.nmbt017,     #營運據點
             nmbt018        LIKE nmbt_t.nmbt018,     #部門
             nmbt019        LIKE nmbt_t.nmbt019,     #利潤/成本中心
             nmbt020        LIKE nmbt_t.nmbt020,     #區域
             nmbt021        LIKE nmbt_t.nmbt021,     #交易客商
             nmbt022        LIKE nmbt_t.nmbt022,     #帳款客商
             nmbt023        LIKE nmbt_t.nmbt023,     #客群
             nmbt024        LIKE nmbt_t.nmbt024,     #產品類別
             nmbt025        LIKE nmbt_t.nmbt025,     #人員
             nmbt026        LIKE nmbt_t.nmbt026,     #預算編號
             nmbt027        LIKE nmbt_t.nmbt027,     #專案編號
             nmbt028        LIKE nmbt_t.nmbt028,     #WBS
             nmbt029        LIKE nmbt_t.nmbt029,     #科目
             nmbt030        LIKE nmbt_t.nmbt030,     #對方科目
             nmbt031        LIKE nmbt_t.nmbt031,     #經營方式
             nmbt032        LIKE nmbt_t.nmbt032,     #渠道
             nmbt033        LIKE nmbt_t.nmbt033,     #品牌
             nmbt034        LIKE nmbt_t.nmbt034,     #自由核算項一
             nmbt035        LIKE nmbt_t.nmbt035,     #自由核算項二
             nmbt036        LIKE nmbt_t.nmbt036,     #自由核算項三
             nmbt037        LIKE nmbt_t.nmbt037,     #自由核算項四
             nmbt038        LIKE nmbt_t.nmbt038,     #自由核算項五
             nmbt039        LIKE nmbt_t.nmbt039,     #自由核算項六
             nmbt040        LIKE nmbt_t.nmbt040,     #自由核算項七
             nmbt041        LIKE nmbt_t.nmbt041,     #自由核算項八
             nmbt042        LIKE nmbt_t.nmbt042,     #自由核算項九
             nmbt043        LIKE nmbt_t.nmbt043,     #自由核算項十
             nmbt100        LIKE nmbt_t.nmbt100,     #幣別
             nmbt101        LIKE nmbt_t.nmbt101,     #匯率
             nmbt103        LIKE nmbt_t.nmbt103,     #原幣金額
             nmbt113        LIKE nmbt_t.nmbt113,     #本幣金額
             nmbt121        LIKE nmbt_t.nmbt121,     #本位幣二匯率
             nmbt123        LIKE nmbt_t.nmbt123,     #本位幣二金額
             nmbt131        LIKE nmbt_t.nmbt131,     #本位幣三匯率
             nmbt133        LIKE nmbt_t.nmbt133,     #本位幣三金額
             nmbt004        LIKE nmbt_t.nmbt004      #異動別
                         END RECORD

   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = g_nmbs_m.nmbsdocno
   IF cl_null(l_nmbtseq) THEN LET l_nmbtseq = 0 END IF

   CALL s_transaction_begin()
   LET g_success = 'Y'

   #STEP1.存入
   LET g_sql = " SELECT nmbadocno,nmbbseq,nmbacomp,nmba001,nmba008,nmbb004,nmbb005,nmbb006,nmbb028",
               "   FROM nmba_t,nmbb_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'",
               "    AND nmbaent = nmbbent ",
               "    AND nmbacomp = nmbbcomp ",
               "    AND nmba003 = 'anmt563'",
               "    AND nmbadocno = nmbbdocno "
   PREPARE anmt311_nmbb_prep FROM g_sql
   DECLARE anmt311_nmbb_curs CURSOR FOR anmt311_nmbb_prep
   FOREACH anmt311_nmbb_curs INTO l_nmbadocno,l_nmbbseq,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb004,l_nmbb005,l_nmbb006,l_nmbb028

      SELECT glab007 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
         AND glab001 = '21' AND glab003 = l_nmbb028
         AND glabld = g_nmbs_m.nmbsld
      IF cl_null(l_glab005) THEN
         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glab001 = '21' AND glab003 = l_nmbb028
            AND glabld = g_nmbs_m.nmbsld
      END IF

      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = g_nmbs_m.nmbsld
      LET l_nmbt.nmbtdocno= g_nmbs_m.nmbsdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = l_nmbbseq
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt021  = ''
      LET l_nmbt.nmbt022  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmbb004
      LET l_nmbt.nmbt101  = l_nmbb005
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = 1
      
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

   #STEP2.貸方科目
   LET g_sql = " SELECT nmbadocno,nmbacomp,nmba001,nmba008,SUM(nmee012),nmee006,nmee009,nmee018,nmee022,nmee020,nmee003", #160509-00004#28 by liyan
               "   FROM nmba_t,nmee_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'",
               "    AND nmbaent = nmeeent ",
               "    AND nmbacomp = nmeecomp ",
               "    AND nmba003 = 'anmt563'",
               "    AND nmbadocno = nmeedocno ",
               "  GROUP BY nmbadocno,nmbacomp,nmba001,nmba008,nmee006,nmee009,nmee018,nmee022,nmee020,nmee003"

   PREPARE anmt311_nmee_prep FROM g_sql
   DECLARE anmt311_nmee_curs CURSOR FOR anmt311_nmee_prep
   FOREACH anmt311_nmee_curs INTO l_nmbadocno,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb006,l_nmee006,l_nmee009,l_nmee018
                                  ,l_nmee022,l_nmee020,l_nmee003   #20160509-00004#28 add by liyan 
      LET l_glab005 = ""
      #160509-00004#28 mod by liyan --str--
      IF l_nmee022 MATCHES '[12]' AND l_nmee020='Y' THEN 
         SELECT glab013 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_nmbs_m.nmbsld
            AND glab001 = 'AR'
            AND glab002 = (select steu004 FROM steu_t WHERE steuent=g_enterprise AND steudocno=l_nmee003)
            AND glab003 = l_nmee006
      ELSE    
         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_nmbs_m.nmbsld
            AND glab001 = 'AP'
            AND glab003 = l_nmee006
      END IF 
      #160509-00004#28 mod by liyan --end--
      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = g_nmbs_m.nmbsld
      LET l_nmbt.nmbtdocno= g_nmbs_m.nmbsdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = 0
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt021  = ''
      LET l_nmbt.nmbt022  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmee009
      LET l_nmbt.nmbt101  = l_nmee018
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = '4'

      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 核算項檢核
# Memo...........: #150714-00024#1
# Usage..........: CALL anmt311_conf_chk()
# Date & Author..: 2015/07/15 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_conf_chk(p_nmbsdocno)
DEFINE p_nmbsdocno      LIKE nmbs_t.nmbsdocno
DEFINE r_success        LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_nmbsld         LIKE nmbs_t.nmbsld
DEFINE l_nmbsdocdt      LIKE nmbs_t.nmbsdocdt
DEFINE l_nmbt           RECORD
         nmbtseq        LIKE nmbt_t.nmbtseq,
         nmbt029        LIKE nmbt_t.nmbt029, #科目
         nmbt018        LIKE nmbt_t.nmbt018, #部門
         nmbt019        LIKE nmbt_t.nmbt019, #利潤/成本中心
         nmbt020        LIKE nmbt_t.nmbt020, #區域
         nmbt023        LIKE nmbt_t.nmbt023, #客群
         nmbt024        LIKE nmbt_t.nmbt024, #產品類別
         nmbt025        LIKE nmbt_t.nmbt025, #人員
         nmbt027        LIKE nmbt_t.nmbt027, #專案代號
         nmbt028        LIKE nmbt_t.nmbt028, #WBS編號
         nmbt031        LIKE nmbt_t.nmbt031, #經營方式
         nmbt032        LIKE nmbt_t.nmbt032, #渠道
         nmbt033        LIKE nmbt_t.nmbt033, #品牌
         nmbt034        LIKE nmbt_t.nmbt034,
         nmbt035        LIKE nmbt_t.nmbt035,
         nmbt036        LIKE nmbt_t.nmbt036,
         nmbt037        LIKE nmbt_t.nmbt037,
         nmbt038        LIKE nmbt_t.nmbt038,  
         nmbt039        LIKE nmbt_t.nmbt039,
         nmbt040        LIKE nmbt_t.nmbt040,
         nmbt041        LIKE nmbt_t.nmbt041,
         nmbt042        LIKE nmbt_t.nmbt042,
         nmbt043        LIKE nmbt_t.nmbt043,
         nmbt021        LIKE nmbt_t.nmbt021, #交易客商
         nmbt022        LIKE nmbt_t.nmbt022  #帳款客商
                        END RECORD
DEFINE l_account        DYNAMIC ARRAY OF RECORD
              f1           LIKE type_t.chr100,     #欄位值
              f2           LIKE type_t.chr7,       #欄位說明
              f3           LIKE nmbs_t.nmbsdocdt   #條件
                        END RECORD
DEFINE l_glaa121        LIKE glaa_t.glaa121

   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   SELECT nmbsld,nmbsdocdt INTO l_nmbsld,l_nmbsdocdt FROM nmbs_t
    WHERE nmbsent = g_enterprise
      AND nmbsdocno = p_nmbsdocno
   
   CALL s_ld_sel_glaa(l_nmbsld,'glaa121') RETURNING  g_sub_success,l_glaa121
   
   LET l_sql = " SELECT nmbtseq,nmbt029,nmbt018,nmbt019,nmbt020,",
               "        nmbt023,nmbt024,nmbt025,nmbt027,nmbt028,",
               "        nmbt031,nmbt032,nmbt033,",
               "        nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,",
               "        nmbt039,nmbt040,nmbt041,nmbt042,nmbt043,",
               "        nmbt021,nmbt022 ",
               "   FROM nmbt_t ",
               "  WHERE nmbtent   = ",g_enterprise,
               "    AND nmbtdocno = '",p_nmbsdocno,"' ",
               "  ORDER BY nmbtseq "
   PREPARE anmt311_sel_nmbt_chk_p1 FROM l_sql
   DECLARE anmt311_sel_nmbt_chk_c1 CURSOR FOR anmt311_sel_nmbt_chk_p1
   FOREACH anmt311_sel_nmbt_chk_c1 INTO l_nmbt.*
      #會科未維護者,直接報錯
      IF cl_null(l_nmbt.nmbt029) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afm-00127'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_nmbt.nmbtseq
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      
      IF l_glaa121 = 'N' THEN
         CALL l_account.clear()
         LET l_account[7].f1  = l_nmbt.nmbt018    LET l_account[7].f2 =  "nmbt018"    LET l_account[7].f3 = l_nmbsdocdt  #部門
         LET l_account[8].f1  = l_nmbt.nmbt019    LET l_account[8].f2 =  "nmbt019"    #利潤中心
         LET l_account[9].f1  = l_nmbt.nmbt020    LET l_account[9].f2 =  "nmbt020"    #區域
         LET l_account[10].f1 = l_nmbt.nmbt021    LET l_account[10].f2 = "nmbt021"    #交易客商
         LET l_account[11].f1 = l_nmbt.nmbt023    LET l_account[11].f2 = "nmbt023"    #客群      
         LET l_account[12].f1 = l_nmbt.nmbt024    LET l_account[12].f2 = "nmbt024"    #產品類別
         LET l_account[13].f1 = l_nmbt.nmbt025    LET l_account[13].f2 = "nmbt025"    #業務人員      
         LET l_account[15].f1 = l_nmbt.nmbt027    LET l_account[15].f2 = "nmbt027"    #專案代號
         LET l_account[16].f1 = l_nmbt.nmbt028    LET l_account[16].f2 = "nmbt028"    #WBS
         LET l_account[27].f1 = l_nmbt.nmbt022    LET l_account[27].f2 = "nmbt022"    #帳款客商      
         LET l_account[31].f1 = l_nmbt.nmbt031    LET l_account[31].f2 = "nmbt031"    #經營方式
         LET l_account[32].f1 = l_nmbt.nmbt032    LET l_account[32].f2 = "nmbt032"    #渠道
         LET l_account[33].f1 = l_nmbt.nmbt033    LET l_account[33].f2 = "nmbt033"    #品牌   
         LET l_account[17].f1 = l_nmbt.nmbt034    LET l_account[17].f2 = "nmbt034"    #自由核算項一
         LET l_account[18].f1 = l_nmbt.nmbt035    LET l_account[18].f2 = "nmbt035"    #自由核算項二
         LET l_account[19].f1 = l_nmbt.nmbt036    LET l_account[19].f2 = "nmbt036"    #自由核算項三
         LET l_account[20].f1 = l_nmbt.nmbt037    LET l_account[20].f2 = "nmbt037"    #自由核算項四
         LET l_account[21].f1 = l_nmbt.nmbt038    LET l_account[21].f2 = "nmbt038"    #自由核算項五
         LET l_account[22].f1 = l_nmbt.nmbt039    LET l_account[22].f2 = "nmbt039"    #自由核算項六
         LET l_account[23].f1 = l_nmbt.nmbt040    LET l_account[23].f2 = "nmbt040"    #自由核算項七
         LET l_account[24].f1 = l_nmbt.nmbt041    LET l_account[24].f2 = "nmbt041"    #自由核算項八
         LET l_account[25].f1 = l_nmbt.nmbt042    LET l_account[25].f2 = "nmbt042"    #自由核算項九
         LET l_account[26].f1 = l_nmbt.nmbt043    LET l_account[26].f2 = "nmbt043"    #自由核算項十
   
         LET l_account[1].f2  = "nmbt029"
         CALL s_fin_accting_chk(l_nmbsld,l_nmbt.nmbt029,l_account) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF

   END FOREACH

   IF l_glaa121 = 'Y' THEN
      CALL s_chk_voucher('NM','N10',l_nmbsld,p_nmbsdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 金额检查
# Memo...........: #151201-00003#2
# Usage..........: CALL anmt311_amt_chk(p_field)
#                  RETURNING 回传参数
# Input parameter: p_field     检查栏位名
# Return code....: 
# Date & Author..: 2015/12/06 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_amt_chk(p_field)
   DEFINE p_field         LIKE  type_t.chr20
   DEFINE l_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE l_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_nmbb006       LIKE nmbb_t.nmbb006
   DEFINE l_nmbb007       LIKE nmbb_t.nmbb007
   DEFINE l_nmbb013       LIKE nmbb_t.nmbb013
   DEFINE l_nmbb017       LIKE nmbb_t.nmbb017

   LET g_errno=NULL
   LET l_nmbt103 = 0
   LET l_nmbt113 = 0
   LET l_nmbt123 = 0
   LET l_nmbt133 = 0
   SELECT SUM(nmbt103),SUM(nmbt113),SUM(nmbt123),SUM(nmbt133) 
     INTO l_nmbt103,l_nmbt113,l_nmbt123,l_nmbt133
     FROM nmbt_t
    WHERE nmbtent=g_enterprise AND nmbtld=g_nmbs_m.nmbsld
      AND nmbtdocno=g_nmbs_m.nmbsdocno
      AND nmbt002 = g_nmbt_d[l_ac].nmbt002 
      AND nmbt003 = g_nmbt_d[l_ac].nmbt003
      AND nmbtseq <> g_nmbt_d[l_ac].nmbtseq
   
   LET l_nmbb006 = 0
   LET l_nmbb007 = 0
   LET l_nmbb013 = 0
   LET l_nmbb017 = 0
   SELECT nmbb006,nmbb007,nmbb013,nmbb017 
     INTO l_nmbb006,l_nmbb007,l_nmbb013,l_nmbb017 
     FROM nmbb_t
    WHERE nmbbent = g_enterprise AND nmbbcomp=g_nmbs_m.nmbscomp
      AND nmbbdocno = g_nmbt_d[l_ac].nmbt002 
      AND nmbbseq = g_nmbt_d[l_ac].nmbt003
   
   CASE p_field
      WHEN 'nmbt103'
         #原币金额比较
         IF cl_null(l_nmbt103) THEN LET l_nmbt103 = 0 END IF
         IF cl_null(l_nmbb006) THEN LET l_nmbb006=0 END IF
         IF cl_null(g_nmbt_d[l_ac].nmbt103) THEN LET g_nmbt_d[l_ac].nmbt103 = 0 END IF
         LET l_nmbt103 = l_nmbt103 + g_nmbt_d[l_ac].nmbt103
         IF l_nmbt103 > l_nmbb006 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00383'
            LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002,'|',g_nmbt_d[l_ac].nmbt003
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_nmbt103
            LET g_errparam.replace[2] = l_nmbb006
            CALL cl_err()
            RETURN FALSE
         END IF
      WHEN 'nmbt113'
         #本币金额比较
         IF cl_null(l_nmbt113) THEN LET l_nmbt113 = 0 END IF
         IF cl_null(l_nmbb007) THEN LET l_nmbb007=0 END IF
         IF cl_null(g_nmbt_d[l_ac].nmbt113) THEN LET g_nmbt_d[l_ac].nmbt113 = 0 END IF
         LET l_nmbt113 = l_nmbt113 + g_nmbt_d[l_ac].nmbt113
         IF l_nmbt113 > l_nmbb007 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00384'
            LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002,'|',g_nmbt_d[l_ac].nmbt003
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_nmbt113
            LET g_errparam.replace[2] = l_nmbb007
            CALL cl_err()
            RETURN FALSE
         END IF
      WHEN 'nmbt123'
         #本位币二金额比较
         IF g_glaa015 = 'Y' THEN
            IF cl_null(l_nmbt123) THEN LET l_nmbt123 = 0 END IF
            IF cl_null(g_nmbt_d[l_ac].nmbt123) THEN LET g_nmbt_d[l_ac].nmbt123 = 0 END IF
            IF cl_null(l_nmbb013) THEN LET l_nmbb013=0 END IF
            LET l_nmbt123 = l_nmbt123 + g_nmbt_d[l_ac].nmbt123
            IF l_nmbt123 > l_nmbb013 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00385'
               LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002,'|',g_nmbt_d[l_ac].nmbt003
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_nmbt123
               LET g_errparam.replace[2] = l_nmbb013
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
      WHEN 'nmbt133'
         #本位币三金额比较
         IF g_glaa015 = 'Y' THEN
            IF cl_null(l_nmbt133) THEN LET l_nmbt133 = 0 END IF
            IF cl_null(g_nmbt_d[l_ac].nmbt133) THEN LET g_nmbt_d[l_ac].nmbt133 = 0 END IF
            IF cl_null(l_nmbb017) THEN LET l_nmbb017=0 END IF
            LET l_nmbt133 = l_nmbt133 + g_nmbt_d[l_ac].nmbt133
            IF l_nmbt133 > l_nmbb017 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00386'
               LET g_errparam.extend = g_nmbt_d[l_ac].nmbt002,'|',g_nmbt_d[l_ac].nmbt003
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_nmbt133
               LET g_errparam.replace[2] = l_nmbb017
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
   END CASE 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即审核
# Memo...........:
# Usage..........: CALL anmt311_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/18 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   IF cl_null(g_nmbs_m.nmbsld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbs_m.nmbscomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbs_m.nmbsdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbt_t WHERE nmbtent = g_enterprise
      AND nmbtdocno = g_nmbs_m.nmbsdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
        
   IF NOT s_anmt311_conf_chk(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_anmt311_conf_upd(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno) THEN
      LET l_doc_success = FALSE
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmbs_m.nmbsmoddt = cl_get_current()
   LET g_nmbs_m.nmbscnfdt = cl_get_current()
   UPDATE nmbs_t SET nmbsstus = 'Y',
                     nmbsmodid= g_user,
                     nmbsmoddt= g_nmbs_m.nmbsmoddt,
                     nmbscnfid= g_user,
                     nmbscnfdt= g_nmbs_m.nmbscnfdt
    WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_m.nmbsld
      AND nmbsdocno = g_nmbs_m.nmbsdocno
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
#151125-00006#3--e
END FUNCTION

################################################################################
# Descriptions...: 立即抛转总账
# Memo...........:
# Usage..........: CALL anmt311_immediately_gen()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/18 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_immediately_gen()
#151125-00006#3--s
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
   DEFINE l_ooac004         LIKE ooac_t.ooac004
   DEFINE l_dfin0030        LIKE type_t.chr1       #狀態碼
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別
   DEFINE r_success        LIKE type_t.num5      #处理状态TRUE/FALSE
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_nmbs           RECORD LIKE nmbs_t.*
   DEFINE l_nmbs RECORD  #帳務底稿主檔
       nmbsent LIKE nmbs_t.nmbsent, #企業編號
       nmbssite LIKE nmbs_t.nmbssite, #帳務中心
       nmbscomp LIKE nmbs_t.nmbscomp, #法人
       nmbsld LIKE nmbs_t.nmbsld, #帳套
       nmbsdocno LIKE nmbs_t.nmbsdocno, #帳務單號
       nmbsdocdt LIKE nmbs_t.nmbsdocdt, #帳務單日期
       nmbs001 LIKE nmbs_t.nmbs001, #作業來源
       nmbs002 LIKE nmbs_t.nmbs002, #附件張數
       nmbs003 LIKE nmbs_t.nmbs003, #傳票編號
       nmbs004 LIKE nmbs_t.nmbs004, #傳票日期
       nmbsownid LIKE nmbs_t.nmbsownid, #資料所有者
       nmbsowndp LIKE nmbs_t.nmbsowndp, #資料所屬部門
       nmbscrtid LIKE nmbs_t.nmbscrtid, #資料建立者
       nmbscrtdp LIKE nmbs_t.nmbscrtdp, #資料建立部門
       nmbscrtdt LIKE nmbs_t.nmbscrtdt, #資料創建日
       nmbsmodid LIKE nmbs_t.nmbsmodid, #資料修改者
       nmbsmoddt LIKE nmbs_t.nmbsmoddt, #最近修改日
       nmbscnfid LIKE nmbs_t.nmbscnfid, #資料確認者
       nmbscnfdt LIKE nmbs_t.nmbscnfdt, #資料確認日
       nmbsstus LIKE nmbs_t.nmbsstus, #狀態碼
       nmbsud001 LIKE nmbs_t.nmbsud001, #自定義欄位(文字)001
       nmbsud002 LIKE nmbs_t.nmbsud002, #自定義欄位(文字)002
       nmbsud003 LIKE nmbs_t.nmbsud003, #自定義欄位(文字)003
       nmbsud004 LIKE nmbs_t.nmbsud004, #自定義欄位(文字)004
       nmbsud005 LIKE nmbs_t.nmbsud005, #自定義欄位(文字)005
       nmbsud006 LIKE nmbs_t.nmbsud006, #自定義欄位(文字)006
       nmbsud007 LIKE nmbs_t.nmbsud007, #自定義欄位(文字)007
       nmbsud008 LIKE nmbs_t.nmbsud008, #自定義欄位(文字)008
       nmbsud009 LIKE nmbs_t.nmbsud009, #自定義欄位(文字)009
       nmbsud010 LIKE nmbs_t.nmbsud010, #自定義欄位(文字)010
       nmbsud011 LIKE nmbs_t.nmbsud011, #自定義欄位(數字)011
       nmbsud012 LIKE nmbs_t.nmbsud012, #自定義欄位(數字)012
       nmbsud013 LIKE nmbs_t.nmbsud013, #自定義欄位(數字)013
       nmbsud014 LIKE nmbs_t.nmbsud014, #自定義欄位(數字)014
       nmbsud015 LIKE nmbs_t.nmbsud015, #自定義欄位(數字)015
       nmbsud016 LIKE nmbs_t.nmbsud016, #自定義欄位(數字)016
       nmbsud017 LIKE nmbs_t.nmbsud017, #自定義欄位(數字)017
       nmbsud018 LIKE nmbs_t.nmbsud018, #自定義欄位(數字)018
       nmbsud019 LIKE nmbs_t.nmbsud019, #自定義欄位(數字)019
       nmbsud020 LIKE nmbs_t.nmbsud020, #自定義欄位(數字)020
       nmbsud021 LIKE nmbs_t.nmbsud021, #自定義欄位(日期時間)021
       nmbsud022 LIKE nmbs_t.nmbsud022, #自定義欄位(日期時間)022
       nmbsud023 LIKE nmbs_t.nmbsud023, #自定義欄位(日期時間)023
       nmbsud024 LIKE nmbs_t.nmbsud024, #自定義欄位(日期時間)024
       nmbsud025 LIKE nmbs_t.nmbsud025, #自定義欄位(日期時間)025
       nmbsud026 LIKE nmbs_t.nmbsud026, #自定義欄位(日期時間)026
       nmbsud027 LIKE nmbs_t.nmbsud027, #自定義欄位(日期時間)027
       nmbsud028 LIKE nmbs_t.nmbsud028, #自定義欄位(日期時間)028
       nmbsud029 LIKE nmbs_t.nmbsud029, #自定義欄位(日期時間)029
       nmbsud030 LIKE nmbs_t.nmbsud030  #自定義欄位(日期時間)030
       END RECORD
   #161215-00044#2---modify----end-----------------
   DEFINE l_date           LIKE glap_t.glapdocdt
   DEFINE l_yy1       LIKE glav_t.glav002
   DEFINE l_mm1       LIKE glav_t.glav004
   DEFINE l_yy2       LIKE glav_t.glav002
   DEFINE l_mm2       LIKE glav_t.glav004
   
   IF cl_null(g_nmbs_m.nmbsld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbs_m.nmbscomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbs_m.nmbsdocno) THEN RETURN END IF   #無資料直接返回不做處理
  
   #161215-00044#2---modify----begin-----------------
   #SELECT * INTO l_nmbs.* 
   SELECT nmbsent,nmbssite,nmbscomp,nmbsld,nmbsdocno,nmbsdocdt,nmbs001,nmbs002,nmbs003,nmbs004,nmbsownid,nmbsowndp,
          nmbscrtid,nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid,nmbscnfdt,nmbsstus,nmbsud001,nmbsud002,
          nmbsud003,nmbsud004,nmbsud005,nmbsud006,nmbsud007,nmbsud008,nmbsud009,nmbsud010,nmbsud011,nmbsud012,
          nmbsud013,nmbsud014,nmbsud015,nmbsud016,nmbsud017,nmbsud018,nmbsud019,nmbsud020,nmbsud021,nmbsud022,
          nmbsud023,nmbsud024,nmbsud025,nmbsud026,nmbsud027,nmbsud028,nmbsud029,nmbsud030 INTO l_nmbs.* 
   #161215-00044#2---modify----end-----------------
     FROM nmbs_t 
    WHERE nmbsent = g_enterprise 
      AND nmbsdocno = g_nmbs_m.nmbsdocno 
      AND nmbsld = g_nmbs_m.nmbsld 
      AND nmbscomp = g_nmbs_m.nmbscomp

   IF l_nmbs.nmbsstus <> 'Y' OR cl_null(l_nmbs.nmbsstus)  THEN RETURN END IF

   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
   CALL cl_err_collect_init()
  #取得單別
   CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_slip
  #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032

   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00406' #未设置直接抛转凭证
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_err_collect_show()
      RETURN 
   END IF 

   #是否产生分录传票
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
   IF l_dfin0030 <> 'Y'  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00054' #此账款单设置为不需产生凭证!!
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_err_collect_show()
      RETURN 
   END IF
   
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
#   IF cl_null(l_gl_slip) THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'aap-00219' #单别参数aooi200未设置对应的总账单别
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN 
#   END IF

      LET l_slip = NULL
      LET l_date = NULL
  IF cl_null(l_gl_slip) THEN
     #CALL axrp330_01(g_nmbs_m.nmbsld) RETURNING l_slip,l_date                    #160620-00010#2 mark
     CALL axrp330_01(g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocdt,g_nmbs_m.nmbsdocdt) RETURNING l_slip,l_date  #160620-00010#2 add    #161213-00023#1 add g_nmbs_m.nmbsdocdt
   ELSE
     LET l_slip = l_gl_slip
     LET l_date = g_today
  END IF
#     IF cl_null(l_slip) AND cl_null(l_date) THEN 
#  
#     ELSE
        LET l_yy1 = NULL
        LET l_mm1 = NULL
        LET l_yy2 = NULL
        LET l_mm2 = NULL
        SELECT glav002,glav006 INTO l_yy1,l_mm1 
          FROM glav_t,glaa_t
         WHERE glavent = glaaent
           AND glav001 = glaa003
           AND glav004 = g_nmbs_m.nmbsdocdt
           AND glaaent = g_enterprise 
           AND glaald = g_nmbs_m.nmbsld
                     
        SELECT glav002,glav006 INTO l_yy2,l_mm2
          FROM glav_t,glaa_t
         WHERE glavent = glaaent
           AND glav001 = glaa003
           AND glav004 = l_date
           AND glaaent = g_enterprise 
           AND glaald = g_nmbs_m.nmbsld
                     
         IF l_yy1 <> l_yy2 OR l_mm1 <> l_mm2 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00327'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            CALL anmt311_turn_gen(l_slip,l_date)
            SELECT nmbs003,nmbs004 INTO g_nmbs_m.nmbs003,g_nmbs_m.nmbs004 FROM nmbs_t 
             WHERE nmbsent = g_enterprise
               AND nmbsld = g_nmbs_m.nmbsld
               AND nmbsdocno = g_nmbs_m.nmbsdocno
              CALL anmt311_show()
         END IF
        CALL cl_err_collect_show()         
      #END IF
      
#   LET ls_js = util.JSON.stringify( la_param.param[6] )
#   CALL cl_cmdrun_wait(ls_js)
#151125-00006#3--e
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
PRIVATE FUNCTION anmt311_nmbt_get_12(p_nmbt002,p_nmbt003)
 DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbadocno    LIKE nmba_t.nmbadocno
   DEFINE l_nmbacomp     LIKE nmba_t.nmbacomp
   DEFINE l_nmbbseq      LIKE nmbb_t.nmbbseq
   DEFINE l_nmba001      LIKE nmba_t.nmba001
   DEFINE l_nmba008      LIKE nmba_t.nmba008
   DEFINE l_nmbb004      LIKE nmbb_t.nmbb004
   DEFINE l_nmbb005      LIKE nmbb_t.nmbb005
   DEFINE l_nmbb006      LIKE nmbb_t.nmbb006
   DEFINE l_nmbb028      LIKE nmbb_t.nmbb028
   DEFINE l_nmee006      LIKE nmee_t.nmee006
   DEFINE l_nmee009      LIKE nmee_t.nmee009
   DEFINE l_nmee024      like nmee_t.nmee024
   DEFINE l_nmee025      LIKE nmee_t.nmee025
   DEFINE l_nmee026      LIKE nmee_t.nmee026
   DEFINE l_nmee018      LIKE nmee_t.nmee018
   DEFINE l_glab005      LIKE glab_t.glab005
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   define l_stbc008      like stbc_t.stbc008
   #160509-00004#28 add by liyan --str--
   DEFINE l_nmee022      LIKE nmee_t.nmee022,
          l_nmee020      LIKE nmee_t.nmee020,
          l_nmee003      LIKE nmee_t.nmee003
   #160509-00004#28 add by liyan --end--
   DEFINE l_nmbt         RECORD
             nmbtent        LIKE nmbt_t.nmbtent,     #企業編號
             nmbtcomp       LIKE nmbt_t.nmbtcomp,    #法人
             nmbtld         LIKE nmbt_t.nmbtld,      #帳別(套)編號
             nmbtdocno      LIKE nmbt_t.nmbtdocno,   #帳務編號
             nmbtseq        LIKE nmbt_t.nmbtseq,     #項次
             nmbt001        LIKE nmbt_t.nmbt001,     #單據來源
             nmbt002        LIKE nmbt_t.nmbt002,     #來源單號
             nmbt003        LIKE nmbt_t.nmbt003,     #來源單項次
             nmbt011        LIKE nmbt_t.nmbt011,     #票據號碼
             nmbt012        LIKE nmbt_t.nmbt012,     #票據日期
             nmbt013        LIKE nmbt_t.nmbt013,     #申請人
             nmbt014        LIKE nmbt_t.nmbt014,     #銀行帳號
             nmbt015        LIKE nmbt_t.nmbt015,     #結算方式
             nmbt016        LIKE nmbt_t.nmbt016,     #收支項目
             nmbt017        LIKE nmbt_t.nmbt017,     #營運據點
             nmbt018        LIKE nmbt_t.nmbt018,     #部門
             nmbt019        LIKE nmbt_t.nmbt019,     #利潤/成本中心
             nmbt020        LIKE nmbt_t.nmbt020,     #區域
             nmbt021        LIKE nmbt_t.nmbt021,     #交易客商
             nmbt022        LIKE nmbt_t.nmbt022,     #帳款客商
             nmbt023        LIKE nmbt_t.nmbt023,     #客群
             nmbt024        LIKE nmbt_t.nmbt024,     #產品類別
             nmbt025        LIKE nmbt_t.nmbt025,     #人員
             nmbt026        LIKE nmbt_t.nmbt026,     #預算編號
             nmbt027        LIKE nmbt_t.nmbt027,     #專案編號
             nmbt028        LIKE nmbt_t.nmbt028,     #WBS
             nmbt029        LIKE nmbt_t.nmbt029,     #科目
             nmbt030        LIKE nmbt_t.nmbt030,     #對方科目
             nmbt031        LIKE nmbt_t.nmbt031,     #經營方式
             nmbt032        LIKE nmbt_t.nmbt032,     #渠道
             nmbt033        LIKE nmbt_t.nmbt033,     #品牌
             nmbt034        LIKE nmbt_t.nmbt034,     #自由核算項一
             nmbt035        LIKE nmbt_t.nmbt035,     #自由核算項二
             nmbt036        LIKE nmbt_t.nmbt036,     #自由核算項三
             nmbt037        LIKE nmbt_t.nmbt037,     #自由核算項四
             nmbt038        LIKE nmbt_t.nmbt038,     #自由核算項五
             nmbt039        LIKE nmbt_t.nmbt039,     #自由核算項六
             nmbt040        LIKE nmbt_t.nmbt040,     #自由核算項七
             nmbt041        LIKE nmbt_t.nmbt041,     #自由核算項八
             nmbt042        LIKE nmbt_t.nmbt042,     #自由核算項九
             nmbt043        LIKE nmbt_t.nmbt043,     #自由核算項十
             nmbt100        LIKE nmbt_t.nmbt100,     #幣別
             nmbt101        LIKE nmbt_t.nmbt101,     #匯率
             nmbt103        LIKE nmbt_t.nmbt103,     #原幣金額
             nmbt113        LIKE nmbt_t.nmbt113,     #本幣金額
             nmbt121        LIKE nmbt_t.nmbt121,     #本位幣二匯率
             nmbt123        LIKE nmbt_t.nmbt123,     #本位幣二金額
             nmbt131        LIKE nmbt_t.nmbt131,     #本位幣三匯率
             nmbt133        LIKE nmbt_t.nmbt133,     #本位幣三金額
             nmbt004        LIKE nmbt_t.nmbt004      #異動別
                         END RECORD

   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = g_nmbs_m.nmbsdocno
   IF cl_null(l_nmbtseq) THEN LET l_nmbtseq = 0 END IF

   CALL s_transaction_begin()
   LET g_success = 'Y'

   #STEP1.存入
   LET g_sql = " SELECT nmbadocno,nmbbseq,nmbacomp,nmba001,nmba008,nmbb004,nmbb005,nmbb006,nmbb028",
               "   FROM nmba_t,nmbb_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'",
               "    AND nmbaent = nmbbent ",
               "    AND nmbacomp = nmbbcomp ",
               "    AND nmba003 = 'anmt564'",
               "    AND nmbadocno = nmbbdocno "
   PREPARE anmt311_nmbb_prep1 FROM g_sql
   DECLARE anmt311_nmbb_curs1 CURSOR FOR anmt311_nmbb_prep1
   FOREACH anmt311_nmbb_curs1 INTO l_nmbadocno,l_nmbbseq,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb004,l_nmbb005,l_nmbb006,l_nmbb028

         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glab001 = '21' AND glab003 = l_nmbb028
            AND glabld = g_nmbs_m.nmbsld

      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = g_nmbs_m.nmbsld
      LET l_nmbt.nmbtdocno= g_nmbs_m.nmbsdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = l_nmbbseq
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt021  = ''
      LET l_nmbt.nmbt022  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmbb004
      LET l_nmbt.nmbt101  = l_nmbb005
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = 3
      
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

   #STEP2.貸方科目
   LET g_sql = " SELECT nmbadocno,nmbacomp,nmba001,nmba008,SUM(nmee012),nmee006,nmee009,nmee018,nmee022,nmee020,nmee003,nmee024,nmee025,nmee026", #160509-00004#28 by liyan
               "   FROM nmba_t,nmee_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbadocno = '",p_nmbt002,"'",
               "    AND nmbaent = nmeeent ",
               "    AND nmbacomp = nmeecomp ",
               "    AND nmba003 = 'anmt564'",
               "    AND nmbadocno = nmeedocno ",
               "  GROUP BY nmbadocno,nmbacomp,nmba001,nmba008,nmee006,nmee009,nmee018,nmee022,nmee020,nmee003,nmee024,nmee025,nmee026"

   PREPARE anmt311_nmee_prep1 FROM g_sql
   DECLARE anmt311_nmee_curs1 CURSOR FOR anmt311_nmee_prep1
   FOREACH anmt311_nmee_curs1 INTO l_nmbadocno,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb006,l_nmee006,l_nmee009,l_nmee018
                                  ,l_nmee022,l_nmee020,l_nmee003,l_nmee024,l_nmee025,l_nmee026   #20160509-00004#28 add by liyan 
      LET l_glab005 = ""
      #160509-00004#28 mod by Naysa --str--
      IF l_nmee022 MATCHES '[12]' AND l_nmee024 MATCHES '[12]'  and cl_null(l_nmee025) THEN 
         SELECT glab013 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_nmbs_m.nmbsld
            AND glab001 = 'AR'
            AND glab002 = (select stba003 FROM stba_t WHERE stbaent=g_enterprise AND stbadocno=l_nmee003)
            AND glab003 = l_nmee006
      ELSE    
         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
             AND glabld = g_nmbs_m.nmbsld
            AND glab001 = 'AR'
            AND glab002 = (select stba003 FROM stba_t WHERE stbaent=g_enterprise AND stbadocno=l_nmee003)
             AND glab003 = l_nmee006
      END IF
      if l_nmee022='1' then 
          select DISTINCT stbc008  into l_stbc008   from stbc_t where stbcent= g_enterprise  and stbc004=l_nmee003 and stbc005=l_nmee004
          LET l_nmbt.nmbt021  = l_stbc008
          LET l_nmbt.nmbt022  = l_stbc008
      else
          LET l_nmbt.nmbt021  = ''
          LET l_nmbt.nmbt022  = ''
      end if           
      #160509-00004#28 mod by Naysa --end--
      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = g_nmbs_m.nmbsld
      LET l_nmbt.nmbtdocno= g_nmbs_m.nmbsdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = 0
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmee009
      LET l_nmbt.nmbt101  = l_nmee018
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = '4'

      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL anmt311_b_fill()
END FUNCTION

 
{</section>}
 
