#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt400_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-09-11 16:29:41), PR版次:0015(2016-12-05 12:43:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000410
#+ Filename...: axrt400_01
#+ Description: 已收款自動沖帳處理
#+ Creator....: 01727(2013-11-21 15:19:35)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="axrt400_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150820-00015#3   15/08/20 by 03538       帳款單加入參數agli010+單別是否產分錄聯合檢定可否沖銷
#160607-00015#3   2016/06/23  By 01727    自動產生時剔除存在於aist340的資料
#160905-00002#5   2016/09/05  By 08729    處理SQL條件多一項ENT
#161013-00014#1   2016/10/17  By 01727    收款核销整单操作“收款自动冲账”生成的第一单收款账号无法带出对应会计科目
#161025-00015#1   2016/10/31  By 01531    收款核销整单操作“收款自动冲账”选项“仅冲账之账款与收入相符”无资料带出。
#161101-00051#1   2016/11/01  By 01531    还原#161025-00015#1
#161109-00049#1   2016/11/07  By 01727    1.axrt400整单操自动冲账选择作冲销至接待相等,收款和账款不平
#                                         2.整批产生单身的时候，产生的转待抵单，但是金额还是不平，要审核的时候再产生一次
#                                         3.整批产生单身的时候冲账选择作冲销至接待相等,金额计算错误,又产生一笔汇兑损益
#161125-00053#1   2016/11/30 By 01727    增加【款別xrde007】顯示,有來源單號者,依來源anmt540帶入,且不可修改。無來源單據者，可維護款別
#161128-00061#5   2016/12/05 by 02481    标准程式定义采用宣告模式,弃用.*写法

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
 
#單頭 type 宣告
PRIVATE type type_g_xrda_m        RECORD
       lbl_a LIKE type_t.chr500, 
   check LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrcb_d        RECORD
       xrcborga     LIKE xrcb_t.xrcborga,
       xrcb001      LIKE xrcb_t.xrcb001,
       xrcb002      LIKE xrcb_t.xrcb002,
       xrcb003      LIKE xrcb_t.xrcb003,
       isaf010      LIKE isaf_t.isaf010,
       xrcc001      LIKE xrcc_t.xrcc001,
       xrcc004      LIKE xrcc_t.xrcc004,
       xrcc100      LIKE xrcc_t.xrcc100,
       xrcc108      LIKE xrcc_t.xrcc108,
       xrcc118      LIKE xrcc_t.xrcc118,
       xrcc128      LIKE xrcc_t.xrcc128,
       xrcc138      LIKE xrcc_t.xrcc138,
       xrca001      LIKE xrca_t.xrca001,
       xrccdocno    LIKE xrcc_t.xrccdocno,
       xrccseq      LIKE xrcc_t.xrccseq,
       xrca004      LIKE xrca_t.xrca004
       END RECORD
DEFINE g_ld       LIKE xrda_t.xrdald
DEFINE g_site     LIKE xrda_t.xrdasite
DEFINE g_comp     LIKE xrda_t.xrdacomp
DEFINE g_xrda003  LIKE xrda_t.xrda003
DEFINE g_xrda004  LIKE xrda_t.xrda004
DEFINE g_xrda005  LIKE xrda_t.xrda005
DEFINE g_docdt    LIKE xrda_t.xrdadocdt
DEFINE g_docno    LIKE xrda_t.xrdadocno
DEFINE g_wc       STRING
DEFINE g_wc1      STRING
DEFINE g_wc1_d    STRING
DEFINE g_wc2      STRING
DEFINE g_wc2_d    STRING
DEFINE g_wc3      STRING
DEFINE g_wc3_d    STRING
DEFINE p_rec_total    LIKE xrce_t.xrce109
DEFINE p_doc_total    LIKE xrce_t.xrce109
DEFINE p_vef_amount   LIKE xrce_t.xrce109
DEFINE g_xrdeseq      LIKE xrde_t.xrdeseq
DEFINE g_xrceseq      LIKE xrce_t.xrceseq
#161128-00061#5---modify----begin------------- 
#DEFINE g_xrde_t       RECORD LIKE xrde_t.*
#DEFINE g_xrce_t       RECORD LIKE xrce_t.*
#DEFINE g_glaa_t       RECORD LIKE glaa_t.*
DEFINE g_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
DEFINE g_xrce_t RECORD  #應收沖銷明細檔
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
DEFINE g_glaa_t RECORD  #帳套資料檔
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
#161128-00061#5---modify----end------------- 
DEFINE g_flag         LIKE type_t.chr1      #記錄是否有產生溢收
DEFINE g_ooab002      LIKE ooab_t.ooab002
DEFINE g_wc4          STRING   #150820-00015#3
#end add-point
 
DEFINE g_xrda_m        type_g_xrda_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt400_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt400_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ld,p_site,p_xrda004,p_xrda005,p_xrda003,p_docdt,p_docno
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_ld       LIKE xrda_t.xrdald
   DEFINE p_site     LIKE xrda_t.xrdasite
   DEFINE p_xrda003  LIKE xrda_t.xrda003
   DEFINE p_xrda004  LIKE xrda_t.xrda004
   DEFINE p_xrda005  LIKE xrda_t.xrda005
   DEFINE p_docdt    LIKE xrda_t.xrdadocdt
   DEFINE p_docno    LIKE xrda_t.xrdadocno
   DEFINE l_wc1      STRING
   DEFINE l_wc2      STRING
   DEFINE l_wc3      STRING
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrda     RECORD LIKE xrda_t.*
   DEFINE l_xrda RECORD  #收款核銷單單頭檔
       xrdaent LIKE xrda_t.xrdaent, #企业代码
       xrdacomp LIKE xrda_t.xrdacomp, #所屬法人
       xrdald LIKE xrda_t.xrdald, #帳套別
       xrdadocno LIKE xrda_t.xrdadocno, #沖帳單號
       xrdadocdt LIKE xrda_t.xrdadocdt, #沖帳日期
       xrdasite LIKE xrda_t.xrdasite, #帳務組織
       xrda001 LIKE xrda_t.xrda001, #帳款單性質
       xrda003 LIKE xrda_t.xrda003, #帳務人員
       xrda004 LIKE xrda_t.xrda004, #帳款核銷客戶
       xrda005 LIKE xrda_t.xrda005, #收款客戶
       xrda006 LIKE xrda_t.xrda006, #一次性對象識別碼
       xrda007 LIKE xrda_t.xrda007, #產生方式
       xrda008 LIKE xrda_t.xrda008, #來源參考單號
       xrda009 LIKE xrda_t.xrda009, #沖帳批序號
       xrda010 LIKE xrda_t.xrda010, #集團代收付單號
       xrda011 LIKE xrda_t.xrda011, #差異處理
       xrda012 LIKE xrda_t.xrda012, #退款類型
       xrda013 LIKE xrda_t.xrda013, #分錄底稿是否可重新產生
       xrda014 LIKE xrda_t.xrda014, #拋轉傳票號碼
       xrda015 LIKE xrda_t.xrda015, #作廢理由碼
       xrda016 LIKE xrda_t.xrda016, #列印次數
       xrda017 LIKE xrda_t.xrda017, #MEMO備註
       xrdastus LIKE xrda_t.xrdastus, #確認否
       xrdaownid LIKE xrda_t.xrdaownid, #資料所有者
       xrdaowndp LIKE xrda_t.xrdaowndp, #資料所屬部門
       xrdacrtid LIKE xrda_t.xrdacrtid, #資料建立者
       xrdacrtdp LIKE xrda_t.xrdacrtdp, #資料建立部門
       xrdacrtdt LIKE xrda_t.xrdacrtdt, #資料創建日
       xrdamodid LIKE xrda_t.xrdamodid, #資料修改者
       xrdamoddt LIKE xrda_t.xrdamoddt, #最近修改日
       xrda103 LIKE xrda_t.xrda103, #原幣借方金額合計
       xrda104 LIKE xrda_t.xrda104, #原幣貸方金額合計
       xrda113 LIKE xrda_t.xrda113, #本幣借方金額合計
       xrda114 LIKE xrda_t.xrda114, #本幣貸方金額合計
       xrda123 LIKE xrda_t.xrda123, #本位幣二借方金額合計
       xrda124 LIKE xrda_t.xrda124, #本位幣二貸方金額合計
       xrda133 LIKE xrda_t.xrda133, #本位幣三借方金額合計
       xrda134 LIKE xrda_t.xrda134, #本位幣三貸方金額合計
       xrdacnfid LIKE xrda_t.xrdacnfid, #資料確認這
       xrdacnfdt LIKE xrda_t.xrdacnfdt, #資料確認日
       xrdapstid LIKE xrda_t.xrdapstid, #資料過帳者
       xrdapstdt LIKE xrda_t.xrdapstdt, #資料過帳日
       xrda018 LIKE xrda_t.xrda018  #來源類型(流通)
       END RECORD 
   #161128-00061#5---modify----end------------- 
   #150820-00015#3--(s)
   DEFINE l_str       LIKE type_t.num5
   DEFINE l_end       LIKE type_t.num5      
   #150820-00015#3--(e)      
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt400_01 WITH FORM cl_ap_formpath("axr","axrt400_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET g_ld = p_ld
   LET g_docno = p_docno
   LET g_site = p_site
   LET g_xrda003 = p_xrda003
   LET g_xrda004 = p_xrda004
   LET g_xrda005 = p_xrda005
   LET g_docdt   = p_docdt
   LET g_xrdeseq = 1
   LET g_xrceseq = 1
   LET g_wc = " 1=1"
  #161128-00061#5-----modify--begin----------
  #SELECT * INTO g_glaa_t.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
  #161128-00061#5----modify--end----------
   FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
   LET g_ooab002 = ''
   SELECT ooab002 INTO g_ooab002 FROM ooab_t
    WHERE ooabent = g_enterprise
      AND ooabsite= g_site
      AND ooab001 = 'S-FIN-1002'
    
   #161128-00061#5---modify----begin-------------     
   #SELECT * INTO l_xrda.*
   SELECT xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,xrda006,
          xrda007,xrda008,xrda009,xrda010,xrda011,xrda012,xrda013,xrda014,xrda015,xrda016,xrda017,xrdastus,
          xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,xrda103,xrda104,xrda113,
          xrda114,xrda123,xrda124,xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,xrdapstdt,xrda018 INTO l_xrda.*    
   #161128-00061#5---modify----end------------- 
   FROM xrda_t WHERE xrdaent = g_enterprise
      AND xrdadocno = p_docno AND xrdald = p_ld
   LET g_comp = l_xrda.xrdacomp
   #150820-00015#3--(s)
   #帳套設定:核銷限定立帳己產生傳票
   IF g_glaa_t.glaa136 = 'Y' THEN
      CALL s_aapt420_get_slip_pos('') RETURNING l_str,l_end
      LET g_wc4  =
      #排除所屬單別參數"產生分錄傳票否"為Y,但尚未產生傳票者
      " NOT (",
      "      EXISTS (SELECT 1 FROM ooac_t ",
      "               WHERE ooacent = apcaent ",
      "                 AND ooac001 = '",g_glaa_t.glaa024,"' ",
      "                 AND ooac002 = SUBSTR(apcadocno,",l_str,",",l_end,") ",
      "                 AND ooac003 = 'D-FIN-0030' ",
      "                 AND ooac004 ='Y') ",
      "         AND apca038 IS NULL",
      "     )  "
   ELSE
      LET g_wc4  = " 1=1"
   END IF
   #150820-00015#3--(e)    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrda_m.lbl_a,g_xrda_m.check ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF cl_null(g_xrda_m.lbl_a) THEN
               LET g_xrda_m.lbl_a = '1'
               LET g_xrda_m.check = 'N'
               CALL cl_set_comp_entry('check',FALSE)
            END IF
            LET p_rec_total = 0
            LET p_doc_total = 0
            LET p_vef_amount= 0
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_a
            #add-point:BEFORE FIELD lbl_a name="input.b.lbl_a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_a
            
            #add-point:AFTER FIELD lbl_a name="input.a.lbl_a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_a
            #add-point:ON CHANGE lbl_a name="input.g.lbl_a"
            IF NOT cl_null(g_xrda_m.lbl_a) AND g_xrda_m.lbl_a = '3' THEN
               CALL cl_set_comp_entry('check',TRUE)
            ELSE
               CALL cl_set_comp_entry('check',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check
            #add-point:BEFORE FIELD check name="input.b.check"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check
            
            #add-point:AFTER FIELD check name="input.a.check"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check
            #add-point:ON CHANGE check name="input.g.check"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.lbl_a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_a
            #add-point:ON ACTION controlp INFIELD lbl_a name="input.c.lbl_a"
            
            #END add-point
 
 
         #Ctrlp:input.c.check
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check
            #add-point:ON ACTION controlp INFIELD check name="input.c.check"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc1 ON lbl_docno1
         BEFORE CONSTRUCT
            IF g_xrda_m.lbl_a != 3 THEN NEXT FIELD lbl_a END IF
            
          ON ACTION controlp INFIELD lbl_docno1
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
         #  #給予arg
            LET g_qryparam.arg1 = l_xrda.xrdasite   #帳務中心(接收,暫不處理)
            LET g_qryparam.arg2 = l_xrda.xrda004    #核銷客戶
            LET g_qryparam.arg3 = l_xrda.xrda005    #收款客戶
            LET g_qryparam.arg4 = l_xrda.xrdacomp   #來源組織(接收,暫不處理)
            LET g_qryparam.arg5 = l_xrda.xrdald     #帳套

            LET g_qryparam.where= "nmbadocdt <= '",l_xrda.xrdadocdt,"'",
                                  " AND (nmbb029 IN ('10','20') OR ( nmbb029 = '30' AND nmbb042 NOT IN('5','6','7','9'))) "
                                 #160607-00015#3  Add  ---(S)---
                                 ," AND NOT EXISTS (SELECT 1 FROM isba_t,isbb_t WHERE isbaent = isbbent AND isbadocno = isbbdocno ",
                                  " AND isbacomp = isbbcomp AND isbbent = nmbbent AND isbastus <> 'X' ",
                                  " AND isbb002 = nmbbdocno AND isbb003 = nmbbseq)"
                                 #160607-00015#3  Add  ---(E)---

            #呼叫開窗
            CALL axrt400_07()
            
            
            LET l_wc1 = g_qryparam.return1
            LET l_wc1 = cl_replace_str(l_wc1,'nmbbdocno = ','')
            LET l_wc1 = cl_replace_str(l_wc1,'nmbbseq = ','')
            LET l_wc1 = cl_replace_str(l_wc1,' OR ','/')
            LET l_wc1 = cl_replace_str(l_wc1,' AND ',',')
            DISPLAY l_wc1 TO lbl_docno1               #顯示到畫面上
            LET g_wc1_d = g_qryparam.return1
            NEXT FIELD lbl_docno1                     #返回原欄位
 
            
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON lbl_docno2
         BEFORE CONSTRUCT
            IF g_xrda_m.lbl_a != 3 THEN NEXT FIELD lbl_a END IF
            
          ON ACTION controlp INFIELD lbl_docno2
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
         #  #給予arg
            #LET g_qryparam.arg1 = l_xrda.xrdasite   #帳務中心(接收,暫不處理)
            #LET g_qryparam.arg2 = l_xrda.xrda004    #核銷客戶
            #LET g_qryparam.arg3 = l_xrda.xrda005    #收款客戶
            #LET g_qryparam.arg4 = l_xrda.xrdacomp   #來源組織(接收,暫不處理)
            #LET g_qryparam.arg5 = l_xrda.xrdald     #帳套
            #LET g_qryparam.arg7 = "'11','12','13','14','15','16','17','19','22','29'"
            #LET g_qryparam.arg8 = g_ooab002         #表單性質
            
            LET g_qryparam.arg1 = l_xrda.xrda005
            LET g_qryparam.arg2 = l_xrda.xrdald
            LET g_qryparam.arg3 = l_xrda.xrdasite         
            LET g_wc4 = cl_replace_str(g_wc4,'apca','xrca')   #150820-00015#3         
            LET g_qryparam.where= "xrcadocdt <= '",l_xrda.xrdadocdt,"'",
                                  "  AND xrca001 IN ('11','12','13','14','15','16','17','19')"
                                 ,"  AND",g_wc4   #150820-00015#3      
                                 #160607-00015#3  Add  ---(S)---
                                 ,"  AND NOT EXISTS (SELECT 1 FROM isba_t,isbc_t WHERE isbaent = isbcent AND isbadocno = isbcdocno ",
                                  "  AND isbacomp = isbccomp AND isbcent = xrccent AND isbastus <> 'X' ",
                                  "  AND isbc007 = xrccdocno AND isbc008 = xrcc001)"
                                 #160607-00015#3  Add  ---(E)---                      
            
            #呼叫開窗
            CALL axrt400_04()
            
            LET l_wc2 = g_qryparam.return1
            LET l_wc2 = cl_replace_str(l_wc2,'xrccseq = ','')
            LET l_wc2 = cl_replace_str(l_wc2,'xrccdocno = ','')
            LET l_wc2 = cl_replace_str(l_wc2,'xrcc001 = ','')
            LET l_wc2 = cl_replace_str(l_wc2,' AND ',',')
            LET l_wc2 = cl_replace_str(l_wc2,' OR ','/')
            DISPLAY l_wc2 TO lbl_docno2               #顯示到畫面上
            LET g_wc2_d = g_qryparam.return1

            NEXT FIELD lbl_docno2                     #返回原欄位
            
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc3 ON lbl_docno3
         BEFORE CONSTRUCT
            IF g_xrda_m.lbl_a != 3 THEN NEXT FIELD lbl_a END IF
            IF g_xrda_m.check = 'N'  THEN NEXT FIELD check END IF
            
         ON ACTION controlp INFIELD lbl_docno3
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = l_xrda.xrda005
            LET g_qryparam.arg2 = l_xrda.xrdald
            LET g_qryparam.arg3 = l_xrda.xrdasite
            LET g_wc4 = cl_replace_str(g_wc4,'xrca','apca')   #150820-00015#3                  
            LET g_qryparam.where= "     apcadocdt <= '",l_xrda.xrdadocdt,"'"
                                 ,"  AND",g_wc4     #150820-00015#3
            
            #呼叫開窗
            CALL axrt400_12()
            
            LET l_wc3 = g_qryparam.return1
            LET l_wc3 = cl_replace_str(l_wc3,'xrccseq = ','')
            LET l_wc3 = cl_replace_str(l_wc3,'xrccdocno = ','')
            LET l_wc3 = cl_replace_str(l_wc3,'xrcc001 = ','')
            LET l_wc3 = cl_replace_str(l_wc3,' AND ',',')
            LET l_wc3 = cl_replace_str(l_wc3,' OR ','/')
            DISPLAY l_wc3 TO lbl_docno3               #顯示到畫面上
            LET g_wc3_d = g_qryparam.return1

            NEXT FIELD lbl_docno3                     #返回原欄位
      END CONSTRUCT
      #end add-point
    
      #公用action
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrt400_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   LET g_wc1 = g_wc1_d
   LET g_wc2 = g_wc2_d 
              ,"  AND",g_wc4                             #150820-00015#3
   IF cl_null(g_wc2_d) THEN LET g_wc2 = g_wc4   END IF   #150820-00015#3
  #LET g_wc3 = cl_replace_str(g_wc3,'lbl_docno3','   ')
   CALL s_transaction_begin()
   LET g_success = 'Y'
   CASE
      WHEN g_xrda_m.lbl_a = '1'
         CALL axrt400_01_1()
      WHEN g_xrda_m.lbl_a = '2'
         CALL axrt400_01_2()
      WHEN g_xrda_m.lbl_a = '3'
         CALL axrt400_01_3()
   END CASE
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt400_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt400_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 全部未沖帳款自動產生
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
PRIVATE FUNCTION axrt400_01_1()
   DEFINE l_gzcb003      LIKE gzcb_t.gzcb003
   
   LET g_wc = " 1=1"
   
   INITIALIZE g_xrde_t.* To Null
   
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = '10'
      AND gzcb001 = '8306'
   LET g_xrde_t.xrdeent = g_enterprise
   LET g_xrde_t.xrdeld = g_ld
   LET g_xrde_t.xrdedocno = g_docno
   LET g_xrde_t.xrdesite  = g_site
   LET g_xrde_t.xrdeorga  = g_comp
   LET g_xrde_t.xrde001   = 'axrt400'
   LET g_xrde_t.xrde002   = '10'
   #LET g_xrde_t.xrde006   = '20'
   LET g_xrde_t.xrde013   = ''
   LET g_xrde_t.xrde014   = ''
   IF l_gzcb003 = 'D' THEN
      LET g_xrde_t.xrde015   =  'D'
   ELSE
      LET g_xrde_t.xrde015   =  'C'
   END IF
   LET g_xrce_t.xrce017   = ''
   LET g_xrce_t.xrce018   = ''
   LET g_xrce_t.xrce019   = ''
   LET g_xrce_t.xrce020   = ''
   LET g_xrce_t.xrce021   = ''
   LET g_xrce_t.xrce022   = ''
   LET g_xrce_t.xrce023   = ''
   
   #產生收款資料
   CALL axrt400_01_ins_xrce_dr()
   
   INITIALIZE g_xrce_t.* To Null
    
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = '30'
      AND gzcb001 = '8306'
   LET g_xrce_t.xrceent = g_enterprise
   LET g_xrce_t.xrceld = g_ld
   LET g_xrce_t.xrcedocno = g_docno
   LET g_xrce_t.xrcesite  = g_site
   LET g_xrce_t.xrceorga  = g_comp
   LET g_xrce_t.xrce002   = '30'
   LET g_xrce_t.xrce006   = ''
   LET g_xrce_t.xrce009   = 'N'
   LET g_xrce_t.xrce010   = ''
   LET g_xrce_t.xrce011   = ''
   LET g_xrce_t.xrce012   = ''
   LET g_xrce_t.xrce013   = ''
   LET g_xrce_t.xrce014   = ''
   IF l_gzcb003 = 'D' THEN
      LET g_xrce_t.xrce015   =  'D'
   ELSE
      LET g_xrce_t.xrce015   =  'C'
   END IF
   
   #產生帳款資料
   CALL axrt400_01_ins_xrce_cr()
   
   LET g_flag = 'Y'
   
   #產生溢收資料
   CALL axrt400_01_ins_xrce_or()
   IF g_flag = 'Y' THEN
      #產生匯兌損益資料
      CALL axrt400_01_ins_xrce_diff()
   END IF
END FUNCTION
################################################################################
# Descriptions...: 僅沖帳至帳款與收入相符
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
PRIVATE FUNCTION axrt400_01_2()
   DEFINE l_gzcb003      LIKE gzcb_t.gzcb003
   DEFINE l_sql          STRING
   DEFINE ls_sql1        STRING
   DEFINE l_sql2         STRING
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_nmbb004      LIKE nmbb_t.nmbb004
   DEFINE l_nmbb006      LIKE nmbb_t.nmbb006   #150820-00015#3 
   DEFINE l_nmbb007      LIKE nmbb_t.nmbb007
  #DEFINE l_nmbb008      LIKE nmbb_t.nmbb008   #150820-00015#3 mark
   DEFINE l_xrcc108      LIKE xrcc_t.xrcc108 
   DEFINE l_xrcc109      LIKE xrcc_t.xrcc109   
   DEFINE l_ld_s         LIKE type_t.num5
   DEFINE l_xrde109_10   LIKE xrde_t.xrde109
   DEFINE l_xrce109_30   LIKE xrce_t.xrce109
   DEFINE ls_wc1         STRING                #160607-00015#3 Add
   DEFINE ls_wc2         STRING                #160607-00015#3 Add

   #檢查是否是主帳套
   #SELECT COUNT(*) INTO l_count FROM glaa_t  #160905-00002#5
   SELECT COUNT(glaaent) INTO l_count FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
      AND glaa014 = 'Y'
   IF l_count < 1 THEN
      #次帳套一
      LET l_count = 0
      #SELECT COUNT(*) INTO l_count FROM ooab_t WHERE ooab001 = 'S-FIN-0001' AND ooab002 = g_ld #160905-00002#5 mark
      SELECT COUNT(ooabent) INTO l_count FROM ooab_t WHERE ooabent = g_enterprise AND ooab001 = 'S-FIN-0001' AND ooab002 = g_ld #160905-00002#5
      IF l_count > 0 THEN
         LET ls_sql1 = "nmbb006-nmbb020 nmbb006,nmbb007-nmbb021 nmbb007"
      END IF
      #次帳套二
      LET l_count = 0
      #SELECT COUNT(*) INTO l_count FROM ooab_t WHERE ooab001 = 'S-FIN-0002' AND ooab002 = g_ld #160905-00002#5 mark
      SELECT COUNT(ooabent) INTO l_count FROM ooab_t WHERE ooabent = g_enterprise AND ooab001 = 'S-FIN-0002' AND ooab002 = g_ld #160905-00002#5
      IF l_count > 0 THEN
         LET ls_sql1 = "nmbb006-nmbb023 nmbb006,nmbb007-nmbb024 nmbb007"
      END IF
   ELSE
      LET ls_sql1 = "nmbb006-nmbb008 nmbb006,nmbb007-nmbb009 nmbb007"
   END IF
   
   IF NOT cl_null(g_wc1) THEN
      LET g_wc = g_wc1
   END IF

  #160607-00015#3  Add  ---(S)---
   LET ls_wc1 = " NOT EXISTS (SELECT 1 FROM isba_t,isbb_t WHERE isbaent = isbbent AND isbadocno = isbbdocno ",
                " AND isbacomp = isbbcomp AND isbbent = nmbbent AND isbastus <> 'X' ",
                " AND isbb002 = nmbbdocno AND isbb003 = nmbbseq)"

   LET ls_wc2 = " NOT EXISTS (SELECT 1 FROM isba_t,isbc_t WHERE isbaent = isbcent AND isbadocno = isbcdocno ",
                " AND isbacomp = isbccomp AND isbcent = xrccent AND isbastus <> 'X' ",
                " AND isbc007 = xrccdocno AND isbc008 = xrcc001)"
  #160607-00015#3  Add  ---(E)---

   IF cl_null(g_wc1) THEN LET g_wc1 = " 1=1" END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   LET g_wc2 = cl_replace_str(g_wc2,'apca','xrca')   #150820-00015#3
   #本位幣二:nmbb013-nmbb014      本位幣三: nmbb017-nmbb018
   LET l_sql = "SELECT nmbb004,SUM(nmbb006),SUM(nmbb007),SUM(xrcc108),SUM(xrcc109) FROM (",
                "SELECT nmbb004 nmbb004,SUM(nmbb006 - nmbb008) nmbb006,SUM(nmbb007 - nmbb009) nmbb007,0 xrcc108,0 xrcc109 FROM nmba_t,nmbb_t",
                " WHERE nmbbent    = nmbaent",
                "   AND nmbbcomp   = nmbacomp",
                "   AND nmbbdocno  = nmbadocno",
                "   AND nmbaent    = '",g_enterprise,"'",
               #"   AND nmbastus   = 'Y'",        #150820-00015#3 mark
                "   AND nmbastus IN ('Y','V')",   #150820-00015#3 
                "   AND nmbb001    = '1'",
                "   AND nmbadocdt <= '",g_docdt,"'",
                "   AND nmbasite = '",g_site,"'",
                "   AND nmbacomp = '",g_comp,"'",
                "   AND nmbb026 IN ('",g_xrda004,"','",g_xrda005,"')",
                "   AND ",g_wc CLIPPED,
                "   AND ", ls_wc1 CLIPPED,   #160607-00015#3  Add
                " GROUP BY nmbb004 ",
                " UNION ",
                "SELECT xrcc100 nmbb004,0 nmbb006,0 nmbb007,",
                #161109-00049#1 Mod  ---(S)---
                "       SUM((xrcc108 - xrcc109) * CASE WHEN xrca001 LIKE '1%' THEN 1 ELSE -1 END) xrcc108,",
                "       SUM((xrcc118 - xrcc119) * CASE WHEN xrca001 LIKE '1%' THEN 1 ELSE -1 END) xrce119 ",
                #161109-00049#1 Mod  ---(E)---
                "  FROM xrcc_t,xrca_t,gzcb_t",
                " WHERE xrccld = xrcald",
                "   AND xrccld = '",g_ld,"'",
                "   AND xrccdocno = xrcadocno",
                "   AND xrccent = ",g_enterprise, #160905-00002#5
                "   AND xrccsite = '",g_site,"'",
                "   AND xrcastus = 'Y'",
                "   AND xrca001 = gzcb002",
                "   AND gzcb003 = '1'",
                "   AND gzcb001 = '8302'",
                "   AND xrcc108 - xrcc109 > 0",
                "   AND xrcadocdt <= '",g_docdt,"'",
                "   AND ((xrca001 LIKE '2%' AND xrca060 <> '2') OR xrca001 NOT LIKE '2%')",    #161109-00049#1 Add
                "   AND xrca004 IN ('",g_xrda004,"','",g_xrda005,"')",
                "   AND ", ls_wc2 CLIPPED,   #160607-00015#3  Add
                "   AND ",g_wc2 CLIPPED,
                " GROUP BY xrcc100 ",
                " )",
                " GROUP BY nmbb004"
                
   PREPARE axrt400_01_prep4 FROM l_sql
   DECLARE axrt400_01_amt CURSOR FOR axrt400_01_prep4

  #LET l_sql = "SELECT SUM(xrde109) FROM xrde_t,xrda_t WHERE xrceent = '",g_enterprise,"'",   #150820-00015#3 mark
   LET l_sql = "SELECT SUM(xrde109) FROM xrde_t,xrda_t WHERE xrdeent = '",g_enterprise,"'",   #150820-00015#3
               "   AND xrdeld = '",g_ld,"'",
               "   AND xrde100 = ?",
               "   AND xrde002 = ?",
               "   AND xrdeld = xrdald",
               "   AND xrdeent = xrdaent",
               "   AND xrdedocno = xrdadocno",
               "   AND xrda004 IN ('",g_xrda004,"','",g_xrda005,"')",
               "   AND xrdastus = 'N'"
               
   PREPARE axrt400_01_prep5 FROM l_sql
   
   LET l_sql = "SELECT SUM(xrce109) FROM xrce_t,xrda_t WHERE xrceent = '",g_enterprise,"'",
               "   AND xrceld = '",g_ld,"'",
               "   AND xrce100 = ?",
               "   AND xrce002 = ?",
               "   AND xrceld = xrdald",
               "   AND xrceent = xrdaent",
               "   AND xrcedocno = xrdadocno",
               "   AND xrda004 IN ('",g_xrda004,"','",g_xrda005,"')",
               "   AND xrdastus = 'N'"
               
   PREPARE axrt400_01_prep6 FROM l_sql

  #FOREACH axrt400_01_amt INTO l_nmbb004,l_nmbb007,l_nmbb008,l_xrcc108,l_xrcc109   #150820-00015#3 mark
   FOREACH axrt400_01_amt INTO l_nmbb004,l_nmbb006,l_nmbb007,l_xrcc108,l_xrcc109   #150820-00015#3  
      IF l_nmbb007 = 0 OR l_xrcc108 = 0 THEN CONTINUE FOREACH END IF #161025-00015#1 mark #161101-00051#1 remark
      #IF l_nmbb007 = 0 AND l_xrcc108 = 0 THEN CONTINUE FOREACH END IF #161025-00015#1 add #161101-00051#1 mark
      
      EXECUTE axrt400_01_prep5 USING l_nmbb004,'10' INTO l_xrde109_10
      EXECUTE axrt400_01_prep6 USING l_nmbb004,'30' INTO l_xrce109_30
      
      IF cl_null(l_xrde109_10) THEN LET l_xrde109_10 = 0 END IF
      IF cl_null(l_xrce109_30) THEN LET l_xrce109_30 = 0 END IF
      
      LET l_nmbb006 = l_nmbb006 - l_xrde109_10   #161109-00049#1 Mod l_nmbb007 --> l_nmbb006
      LET l_xrcc108 = l_xrcc108 - l_xrce109_30
      
      IF l_nmbb006 > l_xrcc108 THEN LET p_vef_amount = l_xrcc108 ELSE LET p_vef_amount = l_nmbb006 END IF   #161109-00049#1 Mod l_nmbb007 --> l_nmbb006
      IF NOT cl_null(g_wc1) THEN
         LET g_wc = g_wc1 CLIPPED," AND nmbb004 = '",l_nmbb004,"'"
      ELSE
         LET g_wc = g_wc," AND nmbb004 = '",l_nmbb004,"'"
      END IF
      
      INITIALIZE g_xrde_t.* To Null
      
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb002 = '10'
         AND gzcb001 = '8306'
      LET g_xrde_t.xrdeent = g_enterprise
      LET g_xrde_t.xrdeld = g_ld
      LET g_xrde_t.xrdedocno = g_docno
      LET g_xrde_t.xrdesite  = g_site
      LET g_xrde_t.xrdeorga  = g_comp
      LET g_xrde_t.xrde001   = 'axrt400'
      LET g_xrde_t.xrde002   = '10'
      #LET g_xrde_t.xrde006   = '20'
      LET g_xrde_t.xrde010   = ''
      LET g_xrde_t.xrde013   = ''
      LET g_xrde_t.xrde014   = ''
      IF l_gzcb003 = 'D' THEN
         LET g_xrde_t.xrde015   =  'D'
      ELSE
         LET g_xrde_t.xrde015   =  'C'
      END IF
      LET g_xrde_t.xrde017   = ''
      LET g_xrde_t.xrde018   = ''
      LET g_xrde_t.xrde019   = ''
      LET g_xrde_t.xrde020   = ''
      LET g_xrde_t.xrde022   = ''
      LET g_xrde_t.xrde023   = ''
   
      #產生收款資料
      CALL axrt400_01_ins_xrce_dr()
      
      IF NOT cl_null(g_wc2) THEN
         LET g_wc = g_wc2 CLIPPED," AND xrcc100 = '",l_nmbb004,"'"
      ELSE
         LET g_wc = g_wc," AND xrcc100 = '",l_nmbb004,"'"
      END IF
      
      INITIALIZE g_xrce_t.* To Null
       
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb002 = '30'
         AND gzcb001 = '8306'
      LET g_xrce_t.xrceent = g_enterprise
      LET g_xrce_t.xrceld = g_ld
      LET g_xrce_t.xrcedocno = g_docno
      LET g_xrce_t.xrcesite  = g_site
      LET g_xrce_t.xrceorga  = g_comp
      LET g_xrce_t.xrce002   = '30'
      LET g_xrce_t.xrce006   = ''
      LET g_xrce_t.xrce009   = 'N'
      LET g_xrce_t.xrce010   = ''
      LET g_xrce_t.xrce011   = ''
      LET g_xrce_t.xrce012   = ''
      LET g_xrce_t.xrce013   = ''
      LET g_xrce_t.xrce014   = ''
      IF l_gzcb003 = 'D' THEN
         LET g_xrce_t.xrce015   =  'D'
      ELSE
         LET g_xrce_t.xrce015   =  'C'
      END IF
      
      #產生帳款資料
      CALL axrt400_01_ins_xrce_cr()
      
   END FOREACH
   
   #產生匯兌損益資料
   CALL axrt400_01_ins_xrce_diff()
END FUNCTION
################################################################################
# Descriptions...: 依指定範圍產生
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
PRIVATE FUNCTION axrt400_01_3()
   DEFINE l_gzcb003      LIKE gzcb_t.gzcb003
   
   LET g_wc = " 1=1"

   IF NOT cl_null(g_wc1) THEN
      LET g_wc = g_wc1
   END IF

   INITIALIZE g_xrde_t.* To Null
   
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = '10'
      AND gzcb001 = '8306'
   LET g_xrde_t.xrdeent = g_enterprise
   LET g_xrde_t.xrdeld = g_ld
   LET g_xrde_t.xrdedocno = g_docno
   LET g_xrde_t.xrdesite  = g_site
   LET g_xrde_t.xrdeorga  = g_comp
   LET g_xrde_t.xrde001   = 'axrt400'
   LET g_xrde_t.xrde002   = '10'
   #LET g_xrde_t.xrde006   = '20'
   LET g_xrde_t.xrde010   = ''
   LET g_xrde_t.xrde013   = ''
   LET g_xrde_t.xrde014   = ''
   IF l_gzcb003 = 'D' THEN
      LET g_xrde_t.xrde015   =  'D'
   ELSE
      LET g_xrde_t.xrde015   =  'C'
   END IF
   LET g_xrde_t.xrde017   = ''
   LET g_xrde_t.xrde018   = ''
   LET g_xrde_t.xrde019   = ''
   LET g_xrde_t.xrde020   = ''
   LET g_xrde_t.xrde022   = ''
   LET g_xrde_t.xrde023   = ''
   
   #產生收款資料
   CALL axrt400_01_ins_xrce_dr()

   IF NOT cl_null(g_wc2) THEN
      LET g_wc = g_wc2
   END IF

   INITIALIZE g_xrce_t.* To Null
    
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = '30'
      AND gzcb001 = '8306'
   LET g_xrce_t.xrceent = g_enterprise
   LET g_xrce_t.xrceld = g_ld
   LET g_xrce_t.xrcedocno = g_docno
   LET g_xrce_t.xrcesite  = g_site
   LET g_xrce_t.xrceorga  = g_comp
   LET g_xrce_t.xrce002   = '30'
   LET g_xrce_t.xrce006   = ''
   LET g_xrce_t.xrce009   = 'N'
   LET g_xrce_t.xrce010   = ''
   LET g_xrce_t.xrce011   = ''
   LET g_xrce_t.xrce012   = ''
   LET g_xrce_t.xrce013   = ''
   LET g_xrce_t.xrce014   = ''
   IF l_gzcb003 = 'D' THEN
      LET g_xrce_t.xrce015   =  'D'
   ELSE
      LET g_xrce_t.xrce015   =  'C'
   END IF
   
   #產生帳款資料
   CALL axrt400_01_ins_xrce_cr()
END FUNCTION
################################################################################
# Descriptions...: xrce_t收款資料新增
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
PRIVATE FUNCTION axrt400_01_ins_xrce_dr()
   DEFINE l_xrde109      LIKE xrde_t.xrde109
   DEFINE l_xrde119      LIKE xrde_t.xrde119
   DEFINE l_xrde129      LIKE xrde_t.xrde129
   DEFINE l_xrde139      LIKE xrde_t.xrde139
   DEFINE l_xrde109_1    LIKE xrde_t.xrde109
   DEFINE l_xrde119_1    LIKE xrde_t.xrde119
   DEFINE l_xrde129_1    LIKE xrde_t.xrde129
   DEFINE l_xrde139_1    LIKE xrde_t.xrde139
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_ls_s         LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE ls_wc1         STRING                #160607-00015#3 Add
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_nmba_t       RECORD LIKE nmba_t.*
   #DEFINE l_nmbb_t       RECORD LIKE nmbb_t.*
   DEFINE l_nmba_t RECORD  #銀存收支主檔
       nmbaent LIKE nmba_t.nmbaent, #企業編號
       nmbaownid LIKE nmba_t.nmbaownid, #資料所有者
       nmbaowndp LIKE nmba_t.nmbaowndp, #資料所有部門
       nmbacrtid LIKE nmba_t.nmbacrtid, #資料建立者
       nmbacrtdp LIKE nmba_t.nmbacrtdp, #資料建立部門
       nmbacrtdt LIKE nmba_t.nmbacrtdt, #資料創建日
       nmbamodid LIKE nmba_t.nmbamodid, #資料修改者
       nmbamoddt LIKE nmba_t.nmbamoddt, #最近修改日
       nmbacnfid LIKE nmba_t.nmbacnfid, #資料確認者
       nmbacnfdt LIKE nmba_t.nmbacnfdt, #資料確認日
       nmbastus LIKE nmba_t.nmbastus, #確認碼
       nmbacomp LIKE nmba_t.nmbacomp, #法人
       nmbadocno LIKE nmba_t.nmbadocno, #收支單號
       nmbadocdt LIKE nmba_t.nmbadocdt, #收支日期
       nmbasite LIKE nmba_t.nmbasite, #資金中心
       nmba001 LIKE nmba_t.nmba001, #繳款部門
       nmba002 LIKE nmba_t.nmba002, #帳務人員
       nmba003 LIKE nmba_t.nmba003, #來源作業類型
       nmba004 LIKE nmba_t.nmba004, #交易對象
       nmba005 LIKE nmba_t.nmba005, #一次性交易對象識別碼
       nmba006 LIKE nmba_t.nmba006, #暫收否
       nmba007 LIKE nmba_t.nmba007, #帳務單號
       nmba008 LIKE nmba_t.nmba008, #繳款人員
       nmba009 LIKE nmba_t.nmba009, #核准日期
       nmba010 LIKE nmba_t.nmba010, #帳套二帳務單號
       nmba011 LIKE nmba_t.nmba011, #帳套三帳務單號
       nmba012 LIKE nmba_t.nmba012, #立帳否(for流通)
       nmba013 LIKE nmba_t.nmba013, #起始日期
       nmba014 LIKE nmba_t.nmba014, #截止日期
       nmba015 LIKE nmba_t.nmba015  #往來據點
       END RECORD
   DEFINE l_nmbb_t RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企業編號
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支單號
       nmbbseq LIKE nmbb_t.nmbbseq, #項次
       nmbborga LIKE nmbb_t.nmbborga, #來源組織
       nmbblegl LIKE nmbb_t.nmbblegl, #核算組織
       nmbb001 LIKE nmbb_t.nmbb001, #異動別
       nmbb002 LIKE nmbb_t.nmbb002, #存提碼
       nmbb003 LIKE nmbb_t.nmbb003, #交易帳戶編碼
       nmbb004 LIKE nmbb_t.nmbb004, #幣別
       nmbb005 LIKE nmbb_t.nmbb005, #匯率
       nmbb006 LIKE nmbb_t.nmbb006, #主帳套原幣金額
       nmbb007 LIKE nmbb_t.nmbb007, #主帳套本幣金額
       nmbb008 LIKE nmbb_t.nmbb008, #主帳套已沖原幣金額
       nmbb009 LIKE nmbb_t.nmbb009, #主帳套已沖本幣金額
       nmbb010 LIKE nmbb_t.nmbb010, #現金變動碼
       nmbb011 LIKE nmbb_t.nmbb011, #本位幣二幣別
       nmbb012 LIKE nmbb_t.nmbb012, #本位幣二匯率
       nmbb013 LIKE nmbb_t.nmbb013, #本位幣二金額
       nmbb014 LIKE nmbb_t.nmbb014, #本位幣二已沖金額
       nmbb015 LIKE nmbb_t.nmbb015, #本位幣三幣別
       nmbb016 LIKE nmbb_t.nmbb016, #本位幣三匯率
       nmbb017 LIKE nmbb_t.nmbb017, #本位幣三金額
       nmbb018 LIKE nmbb_t.nmbb018, #本位幣三已沖金額
       nmbb019 LIKE nmbb_t.nmbb019, #輔助帳套一匯率
       nmbb020 LIKE nmbb_t.nmbb020, #輔助帳套一原幣已沖
       nmbb021 LIKE nmbb_t.nmbb021, #輔助帳套一本幣已沖
       nmbb022 LIKE nmbb_t.nmbb022, #輔助帳套二匯率
       nmbb023 LIKE nmbb_t.nmbb023, #輔助帳套二原幣已沖
       nmbb024 LIKE nmbb_t.nmbb024, #輔助帳套二本幣已沖
       nmbb025 LIKE nmbb_t.nmbb025, #備註
       nmbb026 LIKE nmbb_t.nmbb026, #交易對象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易對象識別碼
       nmbb028 LIKE nmbb_t.nmbb028, #款別編碼
       nmbb029 LIKE nmbb_t.nmbb029, #款別分類
       nmbb030 LIKE nmbb_t.nmbb030, #票據號碼
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有價券數量
       nmbb033 LIKE nmbb_t.nmbb033, #有價券面額
       nmbb034 LIKE nmbb_t.nmbb034, #有價券起始編號
       nmbb035 LIKE nmbb_t.nmbb035, #有價券結束編號
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡銀行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡號
       nmbb038 LIKE nmbb_t.nmbb038, #手續費
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收機構
       nmbb040 LIKE nmbb_t.nmbb040, #背書轉入
       nmbb041 LIKE nmbb_t.nmbb041, #發票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票況
       nmbb043 LIKE nmbb_t.nmbb043, #票據付款銀行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率種類
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #轉付交易對象
       nmbb047 LIKE nmbb_t.nmbb047, #票據流通期間
       nmbb048 LIKE nmbb_t.nmbb048, #貼現利率種類
       nmbb049 LIKE nmbb_t.nmbb049, #貼現利率
       nmbb050 LIKE nmbb_t.nmbb050, #貼現期間
       nmbb051 LIKE nmbb_t.nmbb051, #貼現撥款原幣金額
       nmbb052 LIKE nmbb_t.nmbb052, #貼現撥款本幣金額
       nmbb053 LIKE nmbb_t.nmbb053, #繳款人員
       nmbb054 LIKE nmbb_t.nmbb054, #繳款部門
       nmbb055 LIKE nmbb_t.nmbb055, #POS繳款單號
       nmbb056 LIKE nmbb_t.nmbb056, #入帳匯率
       nmbb057 LIKE nmbb_t.nmbb057, #入帳原幣金額
       nmbb058 LIKE nmbb_t.nmbb058, #入帳主帳套本幣金額
       nmbb059 LIKE nmbb_t.nmbb059, #入帳主帳套本位幣二匯率
       nmbb060 LIKE nmbb_t.nmbb060, #入帳主帳套本位幣二金額
       nmbb061 LIKE nmbb_t.nmbb061, #入帳主帳套本位幣三匯率
       nmbb062 LIKE nmbb_t.nmbb062, #入帳主帳套本位幣三金額
       nmbb063 LIKE nmbb_t.nmbb063, #對方會科
       nmbb064 LIKE nmbb_t.nmbb064, #差異處理狀態
       nmbb065 LIKE nmbb_t.nmbb065, #開票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重評後本幣金額
       nmbb067 LIKE nmbb_t.nmbb067, #重評後本位幣二金額
       nmbb068 LIKE nmbb_t.nmbb068, #重評後本位幣三金額
       nmbb069 LIKE nmbb_t.nmbb069, #質押否
       nmbb070 LIKE nmbb_t.nmbb070, #往來據點
       nmbb071 LIKE nmbb_t.nmbb071, #來源單號
       nmbb072 LIKE nmbb_t.nmbb072, #項次
       nmbb073 LIKE nmbb_t.nmbb073 #開票帳號
       END RECORD
   #161128-00061#5---modify----end------------- 
   
   #檢查是否是主帳套
   #SELECT COUNT(*) INTO l_count FROM glaa_t #160905-00002#5 mark
   SELECT COUNT(glaaent) INTO l_count FROM glaa_t #160905-00002#5
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
      AND glaa014 = 'Y'
   IF l_count < 1 THEN
      #次帳套一
      LET l_count = 0
      SELECT COUNT(ooabent) INTO l_count FROM ooab_t WHERE ooabent = g_enterprise AND ooab001 = 'S-FIN-0001' AND ooab002 = g_ld #160905-00002#5
      #SELECT COUNT(*) INTO l_count FROM ooab_t WHERE ooab001 = 'S-FIN-0001' AND ooab002 = g_ld #160905-00002#5 mark
      IF l_count > 0 THEN
         LET l_ls_s = 2
      END IF
      #次帳套二
      LET l_count = 0
      SELECT COUNT(ooabent) INTO l_count FROM ooab_t WHERE ooabent = g_enterprise AND ooab001 = 'S-FIN-0002' AND ooab002 = g_ld #160905-00002#5
      #SELECT COUNT(*) INTO l_count FROM ooab_t WHERE ooab001 = 'S-FIN-0002' AND ooab002 = g_ld #160905-00002#5 mark
      IF l_count > 0 THEN
         LET l_ls_s = 3
      END IF
   ELSE
      LET l_ls_s = 1
   END IF

  #160607-00015#3  Add  ---(S)---
   LET ls_wc1 = " NOT EXISTS (SELECT 1 FROM isba_t,isbb_t WHERE isbaent = isbbent AND isbadocno = isbbdocno ",
                " AND isbacomp = isbbcomp AND isbbent = nmbbent AND isbastus <> 'X' ",
                " AND isbb002 = nmbbdocno AND isbb003 = nmbbseq)"
  #160607-00015#3  Add  ---(E)---

   #計算收款部分
   #銀存收支單據
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM nmba_t,nmbb_t",
   LET l_sql = "SELECT nmbaent,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,",
               "nmbacnfdt,nmbastus,nmbacomp,nmbadocno,nmbadocdt,nmbasite,nmba001,nmba002,nmba003,nmba004,nmba005,",
               "nmba006,nmba007,nmba008,nmba009,nmba010,nmba011,nmba012,nmba013,nmba014,nmba015,",
               "nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,nmbb005,nmbb006,",
               "nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,",
               "nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,nmbb030,",
               "nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,nmbb040,nmbb041,nmbb042,",
               "nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,",
               "nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,nmbb066,",
               "nmbb067,nmbb068,nmbb069,nmbb070,nmbb071,nmbb072,nmbb073 FROM nmba_t,nmbb_t",
   #161128-00061#5---modify----end------------- 
               " WHERE nmbbent    = nmbaent",
               "   AND nmbbcomp   = nmbacomp",
               "   AND nmbbdocno  = nmbadocno",
               "   AND nmbaent    = '",g_enterprise,"'",
               "   AND nmbb001    = '1'",
               "   AND nmbasite = '",g_site,"'",
               "   AND nmbacomp = '",g_comp,"'",
               "   AND nmba009 IS NOT NULL ",
               "   AND nmbadocdt <= '",g_docdt,"'",
               "   AND nmbastus <> 'X' ",
               "   AND ", ls_wc1 CLIPPED,   #160607-00015#3  Add
               "   AND nmbb026 IN ('",g_xrda004,"','",g_xrda005,"')",
               "   AND (nmbb029 IN ('10','20') OR ( nmbb029 = '30' AND nmbb042 NOT IN('5','6','7','9'))) ",
               "   AND (",g_wc,")"
   CASE
      WHEN l_ls_s = '1'
         LET l_sql = l_sql," AND nmbb006-nmbb008 > 0"
      WHEN l_ls_s = '1'
         LET l_sql = l_sql," AND nmbb006-nmbb020 > 0"
      WHEN l_ls_s = '1'
         LET l_sql = l_sql," AND nmbb006-nmbb023 > 0"
   END CASE
   
   PREPARE axrt400_01_prep1 FROM l_sql
   DECLARE axrt400_01_nmbb CURSOR FOR axrt400_01_prep1
   
   LET g_xrde_t.xrdeseq = g_xrdeseq
   LET p_rec_total = 0
   FOREACH axrt400_01_nmbb INTO l_nmba_t.*,l_nmbb_t.*
      #計算預沖金額
      LET l_xrde109 = 0   LET l_xrde119 = 0
      LET l_xrde129 = 0   LET l_xrde139 = 0
      SELECT SUM(xrde109),SUM(xrde119),SUM(xrde129),SUM(xrde139) INTO l_xrde109,l_xrde119,l_xrde129,l_xrde139 FROM xrde_t,xrda_t
       WHERE xrdaent   = xrdeent
         AND xrdald    = xrdeld
         AND xrdadocno = xrdedocno
         AND xrde003   = l_nmbb_t.nmbbdocno
         AND xrde004   = l_nmbb_t.nmbbseq
         AND xrdastus  = 'N'
      IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
      IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      IF cl_null(l_xrde129) THEN LET l_xrde129 = 0 END IF
      IF cl_null(l_xrde139) THEN LET l_xrde139 = 0 END IF
      
      #抓取直接沖帳未確認金額
      LET l_xrde109_1 = 0   LET l_xrde119_1 = 0
      LET l_xrde129_1 = 0   LET l_xrde139_1 = 0
      SELECT SUM(xrde109),SUM(xrde119),SUM(xrde129),SUM(xrde139) INTO l_xrde109_1,l_xrde119_1,l_xrde129_1,l_xrde139_1 FROM xrde_t,xrca_t
       WHERE xrcaent   = g_enterprise
         AND xrcaent   = xrdeent
         AND xrcald    = xrdeld
         AND xrcadocno = xrdedocno
         AND xrde003   = l_nmbb_t.nmbbdocno
         AND xrde004   = l_nmbb_t.nmbbseq
         AND xrcastus  = 'N'
      IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
      IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
      IF cl_null(l_xrde129_1) THEN LET l_xrde129_1 = 0 END IF
      IF cl_null(l_xrde139_1) THEN LET l_xrde139_1 = 0 END IF
      
      LET l_xrde109 = l_xrde109 + l_xrde109_1
      LET l_xrde119 = l_xrde119 + l_xrde119_1
      LET l_xrde129 = l_xrde129 + l_xrde129_1
      LET l_xrde139 = l_xrde139 + l_xrde139_1
      
      #LET g_xrde_t.xrdecomp = l_nmbb_t.nmbbcomp
      #LET g_xrde_t.xrdeorga = l_nmbb_t.nmbborga
      LET g_xrde_t.xrde003  = l_nmbb_t.nmbbdocno
      LET g_xrde_t.xrde004  = l_nmbb_t.nmbbseq
      LET g_xrde_t.xrde006  = l_nmbb_t.nmbb029
      LET g_xrde_t.xrde007  = l_nmbb_t.nmbb028   #161125-00053#1 Add
      
      IF l_nmbb_t.nmbb029 = '30' THEN 
         LET g_xrde_t.xrde008 = l_nmbb_t.nmbb030
      ELSE
         LET g_xrde_t.xrde008 = l_nmbb_t.nmbb003
      END IF
      LET g_xrde_t.xrde011  = l_nmbb_t.nmbb002
      LET g_xrde_t.xrde012  = l_nmbb_t.nmbb010
      LET g_xrde_t.xrde100  = l_nmbb_t.nmbb004
      LET g_xrde_t.xrde101  = l_nmbb_t.nmbb005
      #161013-00014#1 Mark ---(S)---
     ##抓取科目
     #SELECT nmbt030 INTO g_xrde_t.xrde016
     #  FROM nmbt_t
     # WHERE nmbtent = g_enterprise
     #   AND nmbt002 = g_xrde_t.xrde003
     #   AND nmbt003 = g_xrde_t.xrde004
      #161013-00014#1 Mark ---(E)---
      #161013-00014#1 Add  ---(S)---
      #其他資料獲取
      IF l_nmba_t.nmba006 = 'N' THEN
         #抓取科目
         IF l_nmbb_t.nmbb029 = '10' OR l_nmbb_t.nmbb029 = '20' THEN
            #借方科目: 依 anmi121  設定 
            SELECT DISTINCT glab005 INTO g_xrde_t.xrde016
              FROM glab_t
             WHERE glabent = g_enterprise 
               AND glabld  = g_xrde_t.xrdeld
               AND glab001 = '40'
               AND glab002 = '40'     
               AND glab003 = l_nmbb_t.nmbb003  #交易帳戶編號
         END IF
         #依agli190设定
         IF l_nmbb_t.nmbb029 MATCHES '[3456]0' THEN
            SELECT DISTINCT glab005 INTO g_xrde_t.xrde016
              FROM glab_t
             WHERE glabent = g_enterprise 
               AND glabld  = g_xrde_t.xrdeld
               AND glab001 = '21'
               AND glab002 = l_nmbb_t.nmbb029  
               AND glab003 = l_nmbb_t.nmbb028
         END IF
      ELSE
         SELECT glab005 INTO g_xrde_t.xrde016 FROM glab_t
          WHERE glabent= g_enterprise 
            AND glabld = g_xrde_t.xrdeld
            AND glab001= '41'
            AND glab002= '8714'
            AND glab003= 'F'
      END IF
      #161013-00014#1 Add  ---(E)---
      
      IF g_glaa_t.glaa015 = 'Y' THEN
         LET g_xrde_t.xrde120  = l_nmbb_t.nmbb011
         LET g_xrde_t.xrde121  = l_nmbb_t.nmbb012
      ELSE
         LET g_xrde_t.xrde120  = ''
         LET g_xrde_t.xrde121  = 0
         LET g_xrde_t.xrde129  = 0
      END IF
      IF g_glaa_t.glaa019 = 'Y' THEN
         LET g_xrde_t.xrde130  = l_nmbb_t.nmbb015
         LET g_xrde_t.xrde131  = l_nmbb_t.nmbb016
      ELSE
         LET g_xrde_t.xrde130  = ''
         LET g_xrde_t.xrde131  = 0
         LET g_xrde_t.xrde139  = 0
      END IF
      CASE
         WHEN l_ls_s = 1
            LET g_xrde_t.xrde109  = l_nmbb_t.nmbb006 - l_nmbb_t.nmbb008 - l_xrde109
            LET g_xrde_t.xrde119  = l_nmbb_t.nmbb007 - l_nmbb_t.nmbb009 - l_xrde119
         WHEN l_ls_s = 2
            LET g_xrde_t.xrde109  = l_nmbb_t.nmbb006 - l_nmbb_t.nmbb020 - l_xrde109
            LET g_xrde_t.xrde119  = l_nmbb_t.nmbb007 - l_nmbb_t.nmbb021 - l_xrde119
         WHEN l_ls_s = 3
            LET g_xrde_t.xrde109  = l_nmbb_t.nmbb006 - l_nmbb_t.nmbb023 - l_xrde109
            LET g_xrde_t.xrde119  = l_nmbb_t.nmbb007 - l_nmbb_t.nmbb024 - l_xrde119
      END CASE
      IF p_rec_total + g_xrde_t.xrde109 > p_vef_amount AND g_xrda_m.lbl_a = '2' THEN
         IF p_rec_total >= p_vef_amount THEN
            EXIT FOREACH
         ELSE
            LET g_xrde_t.xrde109 = p_vef_amount - p_rec_total
            IF g_xrde_t.xrde109 <= 0 THEN CONTINUE FOREACH END IF
            LET g_xrde_t.xrde119 = g_xrde_t.xrde109 * g_xrde_t.xrde101
            IF g_glaa_t.glaa015 = 'Y' THEN
               IF g_glaa_t.glaa017 = '1' THEN
                  LET g_xrde_t.xrde129  = g_xrde_t.xrde109 * g_xrde_t.xrde121
               ELSE
                  LET g_xrde_t.xrde129  = g_xrde_t.xrde119 * g_xrde_t.xrde121
               END IF
            END IF
            IF g_glaa_t.glaa019 = 'Y' THEN
               IF g_glaa_t.glaa021 = '1' THEN
                  LET g_xrde_t.xrde139  = g_xrde_t.xrde109 * g_xrde_t.xrde131
               ELSE
                  LET g_xrde_t.xrde139  = g_xrde_t.xrde119 * g_xrde_t.xrde131
               END IF
            END IF
         END IF
      ELSE
         IF g_xrde_t.xrde109 <= 0 THEN CONTINUE FOREACH END IF
         LET g_xrde_t.xrde129  = l_nmbb_t.nmbb013 - l_nmbb_t.nmbb014 - l_xrde129
         LET g_xrde_t.xrde139  = l_nmbb_t.nmbb017 - l_nmbb_t.nmbb018 - l_xrde139
      END IF

      #INSERT INTO xrde_t VALUES(g_xrde_t.*)
      INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(g_xrde_t.xrdeent ,g_xrde_t.xrdecomp ,g_xrde_t.xrdeld ,g_xrde_t.xrdesite,
                            g_xrde_t.xrdeorga,g_xrde_t.xrdedocno,g_xrde_t.xrdeseq,g_xrde_t.xrde001,
                            g_xrde_t.xrde002 ,g_xrde_t.xrde003  ,g_xrde_t.xrde004,g_xrde_t.xrde006,
                            g_xrde_t.xrde008 ,g_xrde_t.xrde010  ,g_xrde_t.xrde011,g_xrde_t.xrde012,
                            g_xrde_t.xrde013 ,g_xrde_t.xrde014  ,g_xrde_t.xrde015,g_xrde_t.xrde016,
                            g_xrde_t.xrde017 ,g_xrde_t.xrde018  ,g_xrde_t.xrde019,g_xrde_t.xrde020,
                            g_xrde_t.xrde022 ,g_xrde_t.xrde023  ,g_xrde_t.xrde100,g_xrde_t.xrde101,
                            g_xrde_t.xrde109 ,g_xrde_t.xrde119  ,g_xrde_t.xrde120,g_xrde_t.xrde121,
                            g_xrde_t.xrde129 ,g_xrde_t.xrde130  ,g_xrde_t.xrde131,g_xrde_t.xrde139
                            )
      IF SQLCA.sqlcode THEN
         LET g_success = 'N' RETURN
      END IF
         
      LET p_rec_total = p_rec_total + g_xrde_t.xrde109
      
      LET g_xrde_t.xrdeseq = g_xrde_t.xrdeseq + 1

   END FOREACH
   
   LET g_xrdeseq = g_xrde_t.xrdeseq
   
END FUNCTION
################################################################################
# Descriptions...: xrce_t帳款資料新增
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
PRIVATE FUNCTION axrt400_01_ins_xrce_cr()
   DEFINE p_xrce002      LIKE xrce_t.xrce002
   DEFINE l_xrce109      LIKE xrce_t.xrce109
   DEFINE l_xrce119      LIKE xrce_t.xrce119
   DEFINE l_xrce129      LIKE xrce_t.xrce129
   DEFINE l_xrce139      LIKE xrce_t.xrce139
   DEFINE l_gzcb003      LIKE gzcb_t.gzcb003
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_ls_s         LIKE type_t.num5
   DEFINE l_sql          STRING
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrca_t       RECORD LIKE xrca_t.*
   #DEFINE l_xrcc_t       RECORD LIKE xrcc_t.*
   #DEFINE l_xrce_t       RECORD LIKE xrce_t.*
   #DEFINE l_apca_t       RECORD LIKE apca_t.*
   #DEFINE l_apcc_t       RECORD LIKE apcc_t.*
   DEFINE l_xrca_t RECORD  #應收憑單單頭
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
DEFINE l_xrcc_t RECORD  #多帳期明細
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
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD
DEFINE l_xrce_t RECORD  #應收沖銷明細檔
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
   DEFINE l_apcc_t RECORD  #應付多帳期檔
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
       apcc015 LIKE apcc_t.apcc015, #付款條件
       apcc016 LIKE apcc_t.apcc016, #帳款類型
       apcc017 LIKE apcc_t.apcc017  #採購單號
       END RECORD
  DEFINE l_apca_t RECORD  #應付憑單單頭
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
       apca067 LIKE apca_t.apca067, #管理品類
       apca068 LIKE apca_t.apca068, #經營方式
       apca069 LIKE apca_t.apca069, #no use
       apca070 LIKE apca_t.apca070, #no use
       apca071 LIKE apca_t.apca071, #no use
       apca072 LIKE apca_t.apca072, #no use
       apca073 LIKE apca_t.apca073  #L/C No.
       END RECORD
       
   #161128-00061#5---modify----end------------- 
   
   DEFINE l_ooab002      LIKE ooab_t.ooab002
   DEFINE l_xrca001_str  STRING
   DEFINE l_apca001_str  STRING
   DEFINE ls_wc2         STRING                #160607-00015#3 Add
   DEFINE l_success      LIKE type_t.num5      #161109-00049#1 Add
   DEFINE l_xrce1091     LIKE xrce_t.xrce109   #161109-00049#1 Add

  #160607-00015#3  Add  ---(S)---
   LET ls_wc2 = " NOT EXISTS (SELECT 1 FROM isba_t,isbc_t WHERE isbaent = isbcent AND isbadocno = isbcdocno ",
                " AND isbacomp = isbccomp AND isbcent = xrccent AND isbastus <> 'X' ",
                " AND isbc007 = xrccdocno AND isbc008 = xrcc001)"
  #160607-00015#3  Add  ---(E)---

   LET l_ooab002 = ''
   SELECT ooab002 INTO l_ooab002 FROM ooab_t
    WHERE ooabent = g_enterprise
      AND ooabsite= g_site
      AND ooab001 = 'S-FIN-1002'
   IF g_wc = " 1=1" THEN LET g_wc = g_wc2 END IF   #150820-00015#3
   #計算帳款部分
   #161128-00061#5---modify----begin------------- 
   #LET l_sql ="SELECT * FROM xrcc_t,xrca_t,gzcb_t",
   LET l_sql ="SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,",
              "xrcc005,xrcc006,xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,",
              "xrcc014,xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,",
              "xrcc109,xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,",
              "xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,",
              "xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017",
              "xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,",
              "xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,",
              "xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,",
              "xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,",
              "xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,",
              "xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,",
              "xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,",
              "xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,",
              "xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,",
              "xrca133,xrca134,xrca136,xrca137,xrca138 FROM xrcc_t,xrca_t,gzcb_t",
   #161128-00061#5---modify----end------------- 
              " WHERE xrccent = '",g_enterprise,"'",
              "   AND xrccld = xrcald",
              "   AND xrccdocno = xrcadocno",
              "   AND xrccent = xrcaent ",
              "   AND xrcastus = 'Y'",
              "   AND xrcasite = '",g_site,"'",
              "   AND xrcald = '",g_ld,"'",
              "   AND xrca001 = gzcb002",
              "   AND gzcb003 = '1'",
              "   AND gzcb001 = '8302'",
              "   AND xrcc108 - xrcc109 > 0",
              "   AND xrca005 = '",g_xrda005,"'",
              "   AND xrcadocdt <= '",g_docdt,"'",                #161109-00049#1 Add
              "   AND ((xrca001 LIKE '2%' AND xrca060 <> '2') OR xrca001 NOT LIKE '2%')",    #161109-00049#1 Add
              "   AND ", ls_wc2 CLIPPED,   #160607-00015#3  Add
              "   AND (",g_wc,")"
             ," ORDER BY xrca001 DESC "                           #161109-00049#1 Add
   LET l_sql = cl_replace_str(l_sql,'apca','xrca')   #150820-00015#3
   PREPARE axrt400_sel_xrcc_prep FROM l_sql
   DECLARE axrt400_sel_xrcc_curs CURSOR FOR axrt400_sel_xrcc_prep

   LET p_rec_total = 0   #161109-00049#1 Add
   FOREACH axrt400_sel_xrcc_curs INTO l_xrcc_t.*,l_xrca_t.*
      #計算預沖金額
      LET l_xrce109 = 0   LET l_xrce119 = 0
      LET l_xrce129 = 0   LET l_xrce139 = 0
      SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139) INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
        FROM xrce_t,xrda_t
       WHERE xrdaent   = xrceent
         AND xrdald    = xrceld
         AND xrdadocno = xrcedocno
         AND xrce003   = l_xrcc_t.xrccdocno
         AND xrce004   = l_xrcc_t.xrccseq
         AND xrce005   = l_xrcc_t.xrcc001
         AND xrdastus  = 'N'
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
      
      SELECT MAX(xrceseq) INTO l_xrce_t.xrceseq
        FROM xrce_t
       WHERE xrceent = g_enterprise 
         AND xrceld = g_ld
         AND xrcedocno = g_docno
      IF cl_null(l_xrce_t.xrceseq) THEN
         LET l_xrce_t.xrceseq = 1
      ELSE
         LET l_xrce_t.xrceseq = l_xrce_t.xrceseq + 1
      END IF
      
      #151210-00004#1--mark--str--lujh
      #SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
      # WHERE gzcb002 = '30'
      #   AND gzcb001 = '8306'
      #151210-00004#1--mark--end--lujh
      LET l_xrce_t.xrceent = g_enterprise
      LET l_xrce_t.xrceld = g_ld
      LET l_xrce_t.xrcedocno = g_docno
      LET l_xrce_t.xrcesite  = g_site
      LET l_xrce_t.xrceorga  = g_comp
      LET l_xrca001_str = l_xrca_t.xrca001
      LET l_xrca001_str = l_xrca001_str.substring(1,1)
      IF l_xrca001_str = '1' THEN
         LET l_xrce_t.xrce002   = '30'
      END IF
      IF l_xrca001_str = '2' AND l_xrca_t.xrca001 <> '25' THEN 
         LET l_xrce_t.xrce002   = '31'
      END IF
      IF l_xrca_t.xrca001 = '25' THEN 
         LET l_xrce_t.xrce002   = '32'
      END IF
      
      #151210-00004#1--add--str--lujh
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb002 = l_xrce_t.xrce002
         AND gzcb001 = '8306'
      #151210-00004#1--add--end--lujh
      
      LET l_xrce_t.xrce010   = ''
      IF l_gzcb003 = 'D' THEN
         LET l_xrce_t.xrce015   =  'D'
      ELSE
         LET l_xrce_t.xrce015   =  'C'
      END IF
      
      
      LET l_xrce_t.xrcecomp = l_xrcc_t.xrcccomp
      LET l_xrce_t.xrce001  = 'axrt400'
      LET l_xrce_t.xrce003  = l_xrcc_t.xrccdocno
      LET l_xrce_t.xrce004  = l_xrcc_t.xrccseq
      LET l_xrce_t.xrce005  = l_xrcc_t.xrcc001
      LET l_xrce_t.xrce016  = l_xrca_t.xrca035
      LET l_xrce_t.xrce017  = l_xrca_t.xrca014
      LET l_xrce_t.xrce018  = l_xrca_t.xrca015
      LET l_xrce_t.xrce027	 = 'N'
      LET l_xrce_t.xrce028	 = 0
      LET l_xrce_t.xrce036	 = l_xrca_t.xrca006
      LET l_xrce_t.xrce053  = l_xrcc_t.xrcc008
      LET l_xrce_t.xrce054  = l_xrcc_t.xrcc009
      LET l_xrce_t.xrce100  = l_xrcc_t.xrcc100
      LET l_xrce_t.xrce101  = l_xrcc_t.xrcc102      #20150313  xrcc101 ---->xrcc102
      LET l_xrce_t.xrce104	 = 0
      LET l_xrce_t.xrce114	 = 0
      LET l_xrce_t.xrce120  = l_xrcc_t.xrcc120
      LET l_xrce_t.xrce121  = l_xrcc_t.xrcc122
      LET l_xrce_t.xrce130  = l_xrcc_t.xrcc130
      LET l_xrce_t.xrce131  = l_xrcc_t.xrcc132
      
      LET l_xrce_t.xrce109  = l_xrcc_t.xrcc108 - l_xrcc_t.xrcc109 - l_xrce109
      LET l_xrce_t.xrce119  = l_xrcc_t.xrcc118 - l_xrcc_t.xrcc119 - l_xrce119
      IF l_xrce_t.xrce109 <= 0 THEN CONTINUE FOREACH END IF
      LET l_xrce_t.xrce129  = l_xrcc_t.xrcc128 - l_xrcc_t.xrcc129 - l_xrce129
      LET l_xrce_t.xrce139  = l_xrcc_t.xrcc138 - l_xrcc_t.xrcc139 - l_xrce139

      IF g_glaa_t.glaa015 = 'N' THEN
         LET l_xrce_t.xrce120 = ''
         LET l_xrce_t.xrce121 = 0
         LET l_xrce_t.xrce129 = 0
      END IF
      
      IF g_glaa_t.glaa019 = 'N' THEN
         LET l_xrce_t.xrce130 = ''
         LET l_xrce_t.xrce131 = 0
         LET l_xrce_t.xrce139 = 0
      END IF

      #161109-00049#1 Add  ---(S)---
      IF l_xrca_t.xrca001 MATCHES '1*' THEN
         LET l_xrce1091 = l_xrce_t.xrce109
      ELSE
         LET l_xrce1091 = l_xrce_t.xrce109 * -1
      END IF
      IF p_rec_total + l_xrce1091 > p_vef_amount AND g_xrda_m.lbl_a = '2' THEN
         IF p_rec_total >= p_vef_amount THEN
            EXIT FOREACH
         ELSE
            IF l_xrca_t.xrca001 MATCHES '1*' THEN
               LET l_xrce_t.xrce109 = p_vef_amount - p_rec_total
            END IF
            IF l_xrce_t.xrce109 <= 0 THEN CONTINUE FOREACH END IF
            LET l_xrce_t.xrce119 = l_xrce_t.xrce109 * l_xrce_t.xrce101
            CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa001,l_xrce_t.xrce119,2)
               RETURNING l_success,g_errno,l_xrce_t.xrce119
            IF g_glaa_t.glaa015 = 'Y' THEN
               IF g_glaa_t.glaa017 = '1' THEN
                  LET l_xrce_t.xrce129  = l_xrce_t.xrce109 * l_xrce_t.xrce121
               ELSE
                  LET l_xrce_t.xrce129  = l_xrce_t.xrce119 * l_xrce_t.xrce121
               END IF
               CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa016,l_xrce_t.xrce129,2)
                  RETURNING l_success,g_errno,l_xrce_t.xrce129
            END IF
            IF g_glaa_t.glaa019 = 'Y' THEN
               IF g_glaa_t.glaa021 = '1' THEN
                  LET l_xrce_t.xrce139  = l_xrce_t.xrce109 * l_xrce_t.xrce131
               ELSE
                  LET l_xrce_t.xrce139  = l_xrce_t.xrce119 * l_xrce_t.xrce131
               END IF
               CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa020,l_xrce_t.xrce139,2)
                  RETURNING l_success,g_errno,l_xrce_t.xrce139
            END IF
         END IF
      END IF
      #161109-00049#1 Add  ---(E)---

      #INSERT INTO xrce_t VALUES(l_xrce_t.*)
      INSERT INTO xrce_t(xrceent,xrcecomp,xrceorga,xrcesite,xrceld,xrcedocno,xrceseq,xrce001,xrce002,xrce003,
                         xrce004,xrce005,xrce010,xrce015,xrce016,xrce017,xrce018,xrce027,xrce028,xrce036,
                         xrce053,xrce054,xrce100,xrce101,xrce104,xrce114,xrce109,
                         xrce119,xrce120,xrce121,xrce129,xrce130,xrce131,xrce139)
                  VALUES(l_xrce_t.xrceent,l_xrce_t.xrcecomp ,l_xrce_t.xrceorga,l_xrce_t.xrcesite,
                         l_xrce_t.xrceld ,l_xrce_t.xrcedocno,l_xrce_t.xrceseq ,l_xrce_t.xrce001 ,
                         l_xrce_t.xrce002,l_xrce_t.xrce003  ,l_xrce_t.xrce004 ,l_xrce_t.xrce005 ,
                         l_xrce_t.xrce010,l_xrce_t.xrce015  ,l_xrce_t.xrce016 ,l_xrce_t.xrce017 ,
                         l_xrce_t.xrce018,l_xrce_t.xrce027  ,l_xrce_t.xrce028 ,l_xrce_t.xrce036 ,
                         l_xrce_t.xrce053,l_xrce_t.xrce054  ,l_xrce_t.xrce100 ,l_xrce_t.xrce101 ,
                         l_xrce_t.xrce104,l_xrce_t.xrce114  ,l_xrce_t.xrce109 ,l_xrce_t.xrce119 ,
                         l_xrce_t.xrce120,l_xrce_t.xrce121  ,l_xrce_t.xrce129 ,l_xrce_t.xrce130 ,
                         l_xrce_t.xrce131,l_xrce_t.xrce139
                        )
      IF SQLCA.sqlcode THEN
         LET g_success = 'N' RETURN
      END IF

      LET p_rec_total = p_rec_total + l_xrce1091   #161109-00049#1 Add

   END FOREACH
   
   
   IF g_xrda_m.check = 'Y' THEN 
      #計算帳款部分
      #161128-00061#5---modify----begin------------- 
      #LET l_sql ="SELECT * FROM apcc_t,apca_t,gzcb_t",
      LET l_sql ="SELECT apccent,apccld,apcccomp,apcclegl,apccsite,apccdocno,apccseq,apcc001,apcc002,",
                 "apcc003,apcc004,apcc005,apcc006,apcc007,apcc008,apcc009,apcc010,apcc011,apcc012,apcc013,",
                 "apcc014,apcc100,apcc101,apcc102,apcc103,apcc104,apcc105,apcc106,apcc107,apcc108,apcc109,",
                 "apcc113,apcc114,apcc115,apcc116,apcc117,apcc118,apcc119,apcc120,apcc121,apcc122,apcc123,",
                 "apcc124,apcc125,apcc126,apcc127,apcc128,apcc129,apcc130,apcc131,apcc132,apcc133,apcc134,",
                 "apcc135,apcc136,apcc137,apcc138,apcc139,apcc015,apcc016,apcc017,",
                 "apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,",
                 "apcacnfdt,apcapstid,apcapstdt,apcastus,apcald,apcacomp,apcadocno,apcadocdt,apcasite,",
                 "apca001,apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,",
                 "apca013,apca014,apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,",
                 "apca026,apca027,apca028,apca029,apca030,apca031,apca032,apca033,apca034,apca035,apca036,",
                 "apca037,apca038,apca039,apca040,apca041,apca042,apca043,apca044,apca045,apca046,apca047,",
                 "apca048,apca049,apca050,apca051,apca052,apca053,apca054,apca055,apca056,apca057,apca058,",
                 "apca059,apca060,apca061,apca062,apca063,apca064,apca065,apca066,apca100,apca101,apca103,",
                 "apca104,apca106,apca107,apca108,apca113,apca114,apca116,apca117,apca118,apca120,apca121,",
                 "apca123,apca124,apca126,apca127,apca128,apca130,apca131,apca133,apca134,apca136,apca137,",
                 "apca138,apca067,apca068,apca069,apca070,apca071,apca072,apca073 FROM apcc_t,apca_t,gzcb_t",
      #161128-00061#5---modify----end-------------
              " WHERE apccent = '",g_enterprise,"'",
              "   AND apccld = apcald",
              "   AND apccdocno = apcadocno",
              "   AND apccent = apcaent ",
              "   AND apcastus = 'Y'",
              "   AND apcasite = '",g_site,"'",
              "   AND apcald = '",g_ld,"'",
              "   AND apca001 = gzcb002",
              "   AND gzcb003 = '1'",
              "   AND gzcb001 = '8502'",
              "   AND apcc108 - apcc109 > 0",
              "   AND ((apca001 LIKE '2%' AND apca060 <> '2') OR apca001 NOT LIKE '2%')",    #161109-00049#1 Add
              "   AND ", ls_wc2 CLIPPED,   #160607-00015#3  Add
              "   AND (",g_wc,")"
             ," ORDER BY apca001 DESC "    #161109-00049#1 Add
      LET l_sql = cl_replace_str(l_sql,'xrca','apca')   #150820-00015#3
      PREPARE axrt400_sel_apcc_prep FROM l_sql
      DECLARE axrt400_sel_apcc_curs CURSOR FOR axrt400_sel_apcc_prep
      
      LET p_rec_total = 0   #161109-00049#1 Add
      FOREACH axrt400_sel_apcc_curs INTO l_apcc_t.*,l_apca_t.*
         #計算預沖金額
         LET l_xrce109 = 0   LET l_xrce119 = 0
         LET l_xrce129 = 0   LET l_xrce139 = 0
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139) INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t,xrda_t
          WHERE xrdaent   = xrceent
            AND xrdald    = xrceld
            AND xrdadocno = xrcedocno
            AND xrce003   = l_apcc_t.apccdocno
            AND xrce004   = l_apcc_t.apccseq
            AND xrce005   = l_apcc_t.apcc001
            AND xrdastus  = 'N'
         IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
         IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
         IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
         IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
         
         SELECT MAX(xrceseq) INTO l_xrce_t.xrceseq
           FROM xrce_t
          WHERE xrceent = g_enterprise 
            AND xrceld = g_ld
            AND xrcedocno = g_docno
         IF cl_null(l_xrce_t.xrceseq) THEN
            LET l_xrce_t.xrceseq = 1
         ELSE
            LET l_xrce_t.xrceseq = l_xrce_t.xrceseq + 1
         END IF
         
         #151210-00004#1--mark--str--lujh
         #SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
         # WHERE gzcb002 = '30'
         #   AND gzcb001 = '8306'
         #151210-00004#1--mark--end--lujh   
         LET l_xrce_t.xrceent = g_enterprise
         LET l_xrce_t.xrceld = g_ld
         LET l_xrce_t.xrcedocno = g_docno
         LET l_xrce_t.xrcesite  = g_site
         LET l_xrce_t.xrceorga  = g_comp
         LET l_apca001_str = l_apca_t.apca001
         LET l_apca001_str = l_apca001_str.substring(1,1)
         IF l_apca001_str = '1' THEN
            LET l_xrce_t.xrce002   = '40'
         END IF
         IF l_apca001_str = '2' AND l_apca_t.apca001 <> '25' THEN 
            LET l_xrce_t.xrce002   = '41'
         END IF
         IF l_apca_t.apca001 = '25' THEN 
            LET l_xrce_t.xrce002   = '42'
         END IF
         
         #151210-00004#1--add--str--lujh
         SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
          WHERE gzcb002 = l_xrce_t.xrce002
            AND gzcb001 = '8306'
         #151210-00004#1--add--end--lujh
         
         LET l_xrce_t.xrce010   = ''
         IF l_gzcb003 = 'D' THEN
            LET l_xrce_t.xrce015   =  'D'
         ELSE
            LET l_xrce_t.xrce015   =  'C'
         END IF
         
         
         LET l_xrce_t.xrcecomp = l_apcc_t.apcccomp
         LET l_xrce_t.xrce001  = 'axrt400'
         LET l_xrce_t.xrce003  = l_apcc_t.apccdocno
         LET l_xrce_t.xrce004  = l_apcc_t.apccseq
         LET l_xrce_t.xrce005  = l_apcc_t.apcc001
         LET l_xrce_t.xrce016  = l_apca_t.apca035
         LET l_xrce_t.xrce017  = l_apca_t.apca014
         LET l_xrce_t.xrce018  = l_apca_t.apca015
         LET l_xrce_t.xrce027	 = 'N'
         LET l_xrce_t.xrce028	 = 0
         LET l_xrce_t.xrce036	 = l_apca_t.apca006
         LET l_xrce_t.xrce053  = l_apcc_t.apcc008
         LET l_xrce_t.xrce054  = l_apcc_t.apcc009
         LET l_xrce_t.xrce100  = l_apcc_t.apcc100
         LET l_xrce_t.xrce101  = l_apcc_t.apcc102     #20150313  apcc101 ---->apcc102
         LET l_xrce_t.xrce104   = 0
         LET l_xrce_t.xrce114   = 0
         LET l_xrce_t.xrce120  = l_apcc_t.apcc120
         LET l_xrce_t.xrce121  = l_apcc_t.apcc122
         LET l_xrce_t.xrce130  = l_apcc_t.apcc130
         LET l_xrce_t.xrce131  = l_apcc_t.apcc132
         
         LET l_xrce_t.xrce109  = l_apcc_t.apcc108 - l_apcc_t.apcc109 - l_xrce109
         LET l_xrce_t.xrce119  = l_apcc_t.apcc118 - l_apcc_t.apcc119 - l_xrce119
         IF l_xrce_t.xrce109 <= 0 THEN CONTINUE FOREACH END IF
         LET l_xrce_t.xrce129  = l_apcc_t.apcc128 - l_apcc_t.apcc129 - l_xrce129
         LET l_xrce_t.xrce139  = l_apcc_t.apcc138 - l_apcc_t.apcc139 - l_xrce139
      
         IF g_glaa_t.glaa015 = 'N' THEN
            LET l_xrce_t.xrce120 = ''
            LET l_xrce_t.xrce121 = 0
            LET l_xrce_t.xrce129 = 0
         END IF
         
         IF g_glaa_t.glaa019 = 'N' THEN
            LET l_xrce_t.xrce130 = ''
            LET l_xrce_t.xrce131 = 0
            LET l_xrce_t.xrce139 = 0
         END IF

         #161109-00049#1 Add  ---(S)---
         IF l_xrca_t.xrca001 MATCHES '1*' THEN
            LET l_xrce1091 = l_xrce_t.xrce109
         ELSE
            LET l_xrce1091 = l_xrce_t.xrce109 * -1
         END IF
         IF p_rec_total + l_xrce1091 > p_vef_amount AND g_xrda_m.lbl_a = '2' THEN
            IF p_rec_total >= p_vef_amount THEN
               EXIT FOREACH
            ELSE
               IF l_xrca_t.xrca001 MATCHES '1*' THEN
                  LET l_xrce_t.xrce109 = p_vef_amount - p_rec_total
               END IF
               IF l_xrce_t.xrce109 <= 0 THEN CONTINUE FOREACH END IF
               LET l_xrce_t.xrce119 = l_xrce_t.xrce109 * l_xrce_t.xrce101
               CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa001,l_xrce_t.xrce119,2)
                  RETURNING l_success,g_errno,l_xrce_t.xrce119
               IF g_glaa_t.glaa015 = 'Y' THEN
                  IF g_glaa_t.glaa017 = '1' THEN
                     LET l_xrce_t.xrce129  = l_xrce_t.xrce109 * l_xrce_t.xrce121
                  ELSE
                     LET l_xrce_t.xrce129  = l_xrce_t.xrce119 * l_xrce_t.xrce121
                  END IF
                  CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa016,l_xrce_t.xrce129,2)
                     RETURNING l_success,g_errno,l_xrce_t.xrce129
               END IF
               IF g_glaa_t.glaa019 = 'Y' THEN
                  IF g_glaa_t.glaa021 = '1' THEN
                     LET l_xrce_t.xrce139  = l_xrce_t.xrce109 * l_xrce_t.xrce131
                  ELSE
                     LET l_xrce_t.xrce139  = l_xrce_t.xrce119 * l_xrce_t.xrce131
                  END IF
                  CALL s_curr_round_ld('1',l_xrce_t.xrceld,g_glaa_t.glaa020,l_xrce_t.xrce139,2)
                     RETURNING l_success,g_errno,l_xrce_t.xrce139
               END IF
            END IF
         END IF
         #161109-00049#1 Add  ---(E)---

         #INSERT INTO xrce_t VALUES(l_xrce_t.*)
         INSERT INTO xrce_t(xrceent,xrcecomp,xrceorga,xrcesite,xrceld,xrcedocno,xrceseq,xrce001,xrce002,xrce003,
                            xrce004,xrce005,xrce010,xrce015,xrce016,xrce017,xrce018,xrce027,xrce028,xrce036,
                            xrce053,xrce054,xrce100,xrce101,xrce104,xrce114,xrce109,
                            xrce119,xrce120,xrce121,xrce129,xrce130,xrce131,xrce139)
                     VALUES(l_xrce_t.xrceent,l_xrce_t.xrcecomp ,l_xrce_t.xrceorga,l_xrce_t.xrcesite,
                            l_xrce_t.xrceld ,l_xrce_t.xrcedocno,l_xrce_t.xrceseq ,l_xrce_t.xrce001 ,
                            l_xrce_t.xrce002,l_xrce_t.xrce003  ,l_xrce_t.xrce004 ,l_xrce_t.xrce005 ,
                            l_xrce_t.xrce010,l_xrce_t.xrce015  ,l_xrce_t.xrce016 ,l_xrce_t.xrce017 ,
                            l_xrce_t.xrce018,l_xrce_t.xrce027  ,l_xrce_t.xrce028 ,l_xrce_t.xrce036 ,
                            l_xrce_t.xrce053,l_xrce_t.xrce054  ,l_xrce_t.xrce100 ,l_xrce_t.xrce101 ,
                            l_xrce_t.xrce104,l_xrce_t.xrce114  ,l_xrce_t.xrce109 ,l_xrce_t.xrce119 ,
                            l_xrce_t.xrce120,l_xrce_t.xrce121  ,l_xrce_t.xrce129 ,l_xrce_t.xrce130 ,
                            l_xrce_t.xrce131,l_xrce_t.xrce139
                           )
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         END IF

         LET p_rec_total = p_rec_total + l_xrce1091   #161109-00049#1 Add

      END FOREACH
   END IF
END FUNCTION
################################################################################
# Descriptions...: rce_t產生溢收資料
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
PRIVATE FUNCTION axrt400_01_ins_xrce_or()
   #161128-00061#5---modify----begin-------------  
   #DEFINE l_xrde_t      RECORD LIKE xrde_t.*
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_sql         STRING
   DEFINE l_xrde100     LIKE xrde_t.xrde100
   DEFINE l_xrde101     LIKE xrde_t.xrde101
   DEFINE l_xrde109     LIKE xrde_t.xrde109
   DEFINE l_xrde119     LIKE xrde_t.xrde119
   DEFINE l_xrde109_1   LIKE xrde_t.xrde109
   DEFINE l_xrde119_1   LIKE xrde_t.xrde119
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_cnt         LIKE type_t.num5    #151010-00001#1 add lujh
   
   ##151010-00001#1--add--str--lujh
   #计算2个单身一共有几个币别
   LET l_sql = "SELECT COUNT(DISTINCT xrde100) ",
               "  FROM ", 
               " ( ",
               " SELECT DISTINCT xrde100 xrde100 ",
               "   FROM xrde_t ",
               "  WHERE xrdeent = ",g_enterprise,
               "    AND xrdedocno = '",g_docno,"'",
               "    AND xrdeld = '",g_ld,"'",
               " UNION ",
               " SELECT DISTINCT xrce100 xrce100 ",
               "   FROM xrce_t ",
               "  WHERE xrceent = ",g_enterprise,
               "    AND xrcedocno = '",g_docno,"'",
               "    AND xrceld = '",g_ld,"'",
               " ) "
   PREPARE axrt400_01_xrde100_cnt_pre FROM l_sql
   EXECUTE axrt400_01_xrde100_cnt_pre INTO l_cnt
   
   IF l_cnt <= 1 THEN 
   #如果只有一个币别冲销,按原逻辑
   ##151010-00001#1--add--end--lujh
      #計算差異
      #161109-00049#1 Mark ---(S)---
     #LET l_sql ="SELECT xrde100,SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1)",
     #           "  FROM(",
     #           "       SELECT xrde100,SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1 FROM xrde_t",
     #           "        WHERE xrdeent = '",g_enterprise,"'",
     #           "          AND xrdedocno = '",g_docno,"'",
     #           "          AND xrdeld = '",g_ld,"'",
     #           "        GROUP BY xrde100",
     #           "        UNION ",
     #           "       SELECT xrce100,0,0,SUM(xrce109) xrde109_1,SUM(xrce119) xrde119_1 FROM xrce_t",
     #           "        WHERE xrceent = '",g_enterprise,"'",
     #           "          AND xrcedocno = '",g_docno,"'",
     #           "          AND xrceld = '",g_ld,"'",
     #           "        GROUP BY xrce100",
     #           "      )",
     #           " GROUP BY xrde100"
      #161109-00049#1 Mark ---(E)---
      #161109-00049#1 Add  ---(S)---
      LET l_sql ="SELECT xrde100,SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1)",
                 "  FROM(",
                 "       SELECT xrde100,SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1 FROM xrde_t,gzcb_t",
                 "        WHERE xrdeent = '",g_enterprise,"'",
                 "          AND xrdedocno = '",g_docno,"'",
                 "          AND xrdeld = '",g_ld,"'",
                 "          AND xrde002 = gzcb002",
                 "          AND gzcb001 = '8306' ",
                 "          AND gzcb004 = 1      ",
                 "        GROUP BY xrde100",
                 "        UNION ",
                 "       SELECT xrce100,0,0,SUM(xrce109) xrde109_1,SUM(xrce119) xrde119_1 FROM xrce_t,gzcb_t",
                 "        WHERE xrceent = '",g_enterprise,"'",
                 "          AND xrcedocno = '",g_docno,"'",
                 "          AND xrceld = '",g_ld,"'",
                 "          AND xrce002 = gzcb002",
                 "          AND gzcb001 = '8306' ",
                 "          AND gzcb004 = 2      ",
                 "        GROUP BY xrce100",
                 "      )",
                 " GROUP BY xrde100"
      #161109-00049#1 Add  ---(E)---
      PREPARE axrt400_01_prep3 FROM l_sql
      DECLARE axrt400_01_xrde CURSOR FOR axrt400_01_prep3
      
      LET l_xrde_t.xrdeseq = g_xrdeseq
      FOREACH axrt400_01_xrde INTO l_xrde100,l_xrde109,l_xrde119,l_xrde109_1,l_xrde119_1
         #原幣收款金額＞可沖帳款原幣:列為　20.溢收
         IF l_xrde109 > l_xrde109_1 THEN
            LET l_xrde_t.xrdeent  = g_enterprise
            LET l_xrde_t.xrdeld   = g_ld
            LET l_xrde_t.xrdedocno= g_docno
            LET l_xrde_t.xrdesite = g_site
            LET l_xrde_t.xrdeorga = g_comp
            LET l_xrde_t.xrde002  = '20'
            LET l_xrde_t.xrde006  = ''
            LET l_xrde_t.xrde001  = 'axrt400'
            LET l_xrde_t.xrde003  = ''
            LET l_xrde_t.xrde004  = 0
            LET l_xrde_t.xrde008  = ''
            LET l_xrde_t.xrde010  = ''
            LET l_xrde_t.xrde013  = g_xrda004
            #LET l_xrde_t.xrde100  = g_glaa_t.glaa001   #151010-00001#1 mark lujh
            LET l_xrde_t.xrde100  = l_xrde100           #151010-00001#1 add lujh
            LET l_xrde_t.xrde101  = 1
            LET l_xrde_t.xrde120  = g_glaa_t.glaa016
            LET l_xrde_t.xrde130  = g_glaa_t.glaa020
            LET l_xrde_t.xrde131  = 1
            LET l_xrde_t.xrde017  = g_xrda003
            LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
            LET l_xrde_t.xrde020  = ''
            LET l_xrde_t.xrde022  = ''
            LET l_xrde_t.xrde023  = ''
            SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xrda003
               
            SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_ld
               AND glab003 = '9711_24'
            
            SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = l_xrde_t.xrde011
              
            SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = '20'
               AND gzcb001 = '8306'
      
            SELECT ooab002 INTO l_ooab002 FROM ooab_t
             WHERE ooabent = g_enterprise
               AND ooabsite= g_site
               AND ooab001 = 'S-BAS-0010'
      
                                     #類型;帳套;日期;來源幣別
            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,l_xrde100,
                                     #目的幣別;         交易金額;               匯類類型
                                      g_glaa_t.glaa001,0,l_ooab002)
                RETURNING l_xrde101
      
            LET l_xrde_t.xrde109 = l_xrde101 *(l_xrde109 - l_xrde109_1)
            LET l_xrde_t.xrde119 = l_xrde_t.xrde109
            IF g_glaa_t.glaa015 = 'Y' THEN
                                        #類型;帳套;日期;來源幣別
               CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                        #目的幣別;         交易金額;               匯類類型
                                         g_glaa_t.glaa016,0,g_glaa_t.glaa018)
                  RETURNING l_xrde_t.xrde121
               LET l_xrde_t.xrde129  = l_xrde_t.xrde109 * l_xrde_t.xrde121
            END IF
            IF g_glaa_t.glaa019 = 'Y' THEN
                                        #類型;帳套;日期;來源幣別
               CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                        #目的幣別;         交易金額;               匯類類型
                                         g_glaa_t.glaa020,0,g_glaa_t.glaa022)
                  RETURNING l_xrde_t.xrde131
               LET l_xrde_t.xrde139  = l_xrde_t.xrde109 * l_xrde_t.xrde131
            END IF
      
            IF g_glaa_t.glaa015 = 'N' THEN
               LET l_xrde_t.xrde120 = ''
               LET l_xrde_t.xrde121 = 0
               LET l_xrde_t.xrde129 = 0
            END IF
            
            IF g_glaa_t.glaa019 = 'N' THEN
               LET l_xrde_t.xrde130 = ''
               LET l_xrde_t.xrde131 = 0
               LET l_xrde_t.xrde139 = 0
            END IF
      
            #INSERT INTO xrde_t VALUES(l_xrde_t.*)
            INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                               xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                               xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                               xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                        VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                               l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                               l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                               l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                               l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                               l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                               l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                               l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                               l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                               )
            IF SQLCA.sqlcode THEN
               LET g_success = 'N' RETURN
            ELSE
               LET g_flag = 'N'
            END IF
            
            LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
      
         END IF
      END FOREACH
   ##151010-00001#1--add--str--lujh
   ELSE
      #如果是多币别冲销,无法分清楚是哪个币别的溢收,以本币来计算
      LET l_sql ="SELECT SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1)",
                 "  FROM(",
                 "       SELECT SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1 FROM xrde_t",
                 "        WHERE xrdeent = '",g_enterprise,"'",
                 "          AND xrdedocno = '",g_docno,"'",
                 "          AND xrdeld = '",g_ld,"'",
                 "        UNION ",
                 "       SELECT 0,0,SUM(xrce109) xrde109_1,SUM(xrce119) xrde119_1 FROM xrce_t",
                 "        WHERE xrceent = '",g_enterprise,"'",
                 "          AND xrcedocno = '",g_docno,"'",
                 "          AND xrceld = '",g_ld,"'",
                 "      )"
      PREPARE axrt400_01_prep7 FROM l_sql
      DECLARE axrt400_01_cs CURSOR FOR axrt400_01_prep7
      
      LET l_xrde_t.xrdeseq = g_xrdeseq
      FOREACH axrt400_01_cs INTO l_xrde109,l_xrde119,l_xrde109_1,l_xrde119_1
         #本幣收款金額＞可沖帳款本幣:列為　20.溢收
         IF l_xrde119 > l_xrde119_1 THEN
            LET l_xrde_t.xrdeent  = g_enterprise
            LET l_xrde_t.xrdeld   = g_ld
            LET l_xrde_t.xrdedocno= g_docno
            LET l_xrde_t.xrdesite = g_site
            LET l_xrde_t.xrdeorga = g_comp
            LET l_xrde_t.xrde002  = '20'
            LET l_xrde_t.xrde006  = ''
            LET l_xrde_t.xrde001  = 'axrt400'
            LET l_xrde_t.xrde003  = ''
            LET l_xrde_t.xrde004  = 0
            LET l_xrde_t.xrde008  = ''
            LET l_xrde_t.xrde010  = ''
            LET l_xrde_t.xrde013  = g_xrda004
            LET l_xrde_t.xrde100  = g_glaa_t.glaa001
            LET l_xrde_t.xrde101  = 1
            LET l_xrde_t.xrde120  = g_glaa_t.glaa016
            LET l_xrde_t.xrde130  = g_glaa_t.glaa020
            LET l_xrde_t.xrde131  = 1
            LET l_xrde_t.xrde017  = g_xrda003
            LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
            LET l_xrde_t.xrde020  = ''
            LET l_xrde_t.xrde022  = ''
            LET l_xrde_t.xrde023  = ''
            SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xrda003
               
            SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_ld
               AND glab003 = '9711_24'
            
            SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = l_xrde_t.xrde011
              
            SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = '20'
               AND gzcb001 = '8306'
      
            SELECT ooab002 INTO l_ooab002 FROM ooab_t
             WHERE ooabent = g_enterprise
               AND ooabsite= g_site
               AND ooab001 = 'S-BAS-0010'
            
            LET l_xrde_t.xrde119 = l_xrde119 - l_xrde119_1
            LET l_xrde_t.xrde109 = l_xrde_t.xrde119
            
            IF g_glaa_t.glaa015 = 'Y' THEN
                                        #類型;帳套;日期;來源幣別
               CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                        #目的幣別;         交易金額;               匯類類型
                                         g_glaa_t.glaa016,0,g_glaa_t.glaa018)
                  RETURNING l_xrde_t.xrde121
               LET l_xrde_t.xrde129  = l_xrde_t.xrde109 * l_xrde_t.xrde121
            END IF
            IF g_glaa_t.glaa019 = 'Y' THEN
                                        #類型;帳套;日期;來源幣別
               CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                        #目的幣別;         交易金額;               匯類類型
                                         g_glaa_t.glaa020,0,g_glaa_t.glaa022)
                  RETURNING l_xrde_t.xrde131
               LET l_xrde_t.xrde139  = l_xrde_t.xrde109 * l_xrde_t.xrde131
            END IF
      
            IF g_glaa_t.glaa015 = 'N' THEN
               LET l_xrde_t.xrde120 = ''
               LET l_xrde_t.xrde121 = 0
               LET l_xrde_t.xrde129 = 0
            END IF
            
            IF g_glaa_t.glaa019 = 'N' THEN
               LET l_xrde_t.xrde130 = ''
               LET l_xrde_t.xrde131 = 0
               LET l_xrde_t.xrde139 = 0
            END IF
      
            #INSERT INTO xrde_t VALUES(l_xrde_t.*)
            INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                               xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                               xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                               xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                        VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                               l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                               l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                               l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                               l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                               l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                               l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                               l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                               l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                               )
            IF SQLCA.sqlcode THEN
               LET g_success = 'N' RETURN
            ELSE
               LET g_flag = 'N'
            END IF
            
            LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
         END IF   
      END FOREACH 
      
   END IF
   ##151010-00001#1--add--end--lujh
      
   LET g_xrdeseq = l_xrde_t.xrdeseq
END FUNCTION
################################################################################
# Descriptions...: xrce_t產生匯兌損益
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
PRIVATE FUNCTION axrt400_01_ins_xrce_diff()
   DEFINE l_glab003      LIKE glab_t.glab003
   #161128-00061#5---modify----begin-------------  
   #DEFINE l_xrde_t      RECORD LIKE xrde_t.*
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_sql         STRING
   DEFINE l_xrde100     LIKE xrde_t.xrde100
   DEFINE l_xrde109     LIKE xrde_t.xrde109
   DEFINE l_xrde119     LIKE xrde_t.xrde119
   DEFINE l_xrde109_1   LIKE xrde_t.xrde109
   DEFINE l_xrde119_1   LIKE xrde_t.xrde119
   DEFINE l_xrde109_2   LIKE xrde_t.xrde109
   DEFINE l_xrde119_2   LIKE xrde_t.xrde119
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_amt         LIKE xrde_t.xrde119   #匯差

   
   LET l_xrde_t.xrdeseq = g_xrdeseq
   LET l_xrde_t.xrdeent = g_enterprise
   LET l_xrde_t.xrdeld = g_ld
   LET l_xrde_t.xrdedocno = g_docno
   LET l_xrde_t.xrdesite = g_site
   LET l_xrde_t.xrdeorga = g_comp

   #計算差異
   #依次計算本位幣三、本位幣二、本位幣
   
   #本位幣三
   IF g_glaa_t.glaa019 = 'Y' THEN
      LET l_sql ="SELECT xrde100,SUM(xrde139),SUM(xrde139_1)",
                 "  FROM(",
                 "       SELECT xrde100,SUM(xrde139) xrde139,0 xrde139_1 FROM xrde_t,gzcb_t",
                 "        WHERE xrde002 = gzcb002",
                 "          AND gzcb001 = '8306'",
                 "          AND gzcb004 = '1'",
                 "          AND xrdeent = '",g_enterprise,"'",
                 "          AND xrdedocno = '",g_docno,"'",
                 "          AND xrdeld = '",g_ld,"'",
                 "        GROUP BY xrde100",
                 "        UNION ",
                 "       SELECT xrce100,0 xrde139,SUM(xrce139) xrde139_1 FROM xrce_t,gzcb_t",
                 "        WHERE xrce002 = gzcb002",
                 "          AND gzcb001 = '8306'",
                 "          AND gzcb004 = '2'",
                 "          AND xrceent = '",g_enterprise,"'",
                 "          AND xrcedocno = '",g_docno,"'",
                 "          AND xrceld = '",g_ld,"'",
                 "        GROUP BY xrce100",
                 "      )",
                 " GROUP BY xrde100"
      PREPARE axrt400_01_prep313 FROM l_sql
      DECLARE axrt400_01_xrde13 CURSOR FOR axrt400_01_prep313
   
      #產生本位幣三匯兌損益
      FOREACH axrt400_01_xrde13 INTO l_xrde100,l_xrde119,l_xrde119_1
         #本幣帳款 < 收款:12.匯兌收益;　反之 11.匯兌損失.
         IF l_xrde119 != l_xrde119_1 THEN
            IF l_xrde119 < l_xrde119_1 THEN
               LET l_xrde_t.xrde002  = '11'
               LET l_glab003 = '9711_12'
               LET l_amt = l_xrde119_1 - l_xrde119
            ELSE
               LET l_xrde_t.xrde002  = '12'
               LET l_glab003 = '9711_11'
               LET l_amt = l_xrde119 - l_xrde119_1
            END IF
            SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = l_xrde_t.xrde002
               AND gzcb001 = '8306'
            LET l_xrde_t.xrde006  = ''
            LET l_xrde_t.xrde001  = 'axrt400'
            LET l_xrde_t.xrde003  = ''
            LET l_xrde_t.xrde004  = ''
            LET l_xrde_t.xrde008  = ''
            LET l_xrde_t.xrde010  = ''
            LET l_xrde_t.xrde013  = ''
            LET l_xrde_t.xrde014  = ''
            LET l_xrde_t.xrde020  = ''
            LET l_xrde_t.xrde022  = ''
            LET l_xrde_t.xrde023  = ''
            LET l_xrde_t.xrde017  = g_xrda003
            SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xrda003
            LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
               
            SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_ld
               AND glab003 = l_glab003
            
            SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = l_xrde_t.xrde011
              
            #151210-00004#1--mark--str--lujh  
            #SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
            # WHERE gzcb002 = '20'
            #   AND gzcb001 = '8306'
            #151210-00004#1--mark--end--lujh  

            SELECT ooab002 INTO l_ooab002 FROM ooab_t
             WHERE ooabent = g_enterprise
               AND ooabsite= g_site
               AND ooab001 = 'S-BAS-0010'
   
                                     #類型;帳套;日期;來源幣別
            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa020,
                                     #目的幣別;         交易金額;               匯類類型
                                      g_glaa_t.glaa001,l_amt,g_glaa_t.glaa016)
                RETURNING l_xrde_t.xrde109

                                     #類型;帳套;日期;來源幣別
            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                     #目的幣別;         交易金額;               匯類類型
                                      g_glaa_t.glaa020,0,g_glaa_t.glaa016)
                RETURNING l_xrde_t.xrde131

            LET l_xrde_t.xrde100  = g_glaa_t.glaa001
            LET l_xrde_t.xrde101  = 1
            LET l_xrde_t.xrde119  = l_xrde_t.xrde109
            LET l_xrde_t.xrde120  = ''
            LET l_xrde_t.xrde121  = 0
            LET l_xrde_t.xrde129  = 0
            LET l_xrde_t.xrde130  = g_glaa_t.glaa020
            LET l_xrde_t.xrde139  = l_amt

            #INSERT INTO xrde_t VALUES(l_xrde_t.*)
            INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                            l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                            l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                            l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                            l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                            l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                            l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                            l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                            l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                            )
            IF SQLCA.sqlcode THEN
               LET g_success = 'N' RETURN
            END IF
            
            LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
            
         END IF

      END FOREACH
   END IF


   #本位幣二
   IF g_glaa_t.glaa015 = 'Y' THEN
      LET l_sql ="SELECT xrde100,SUM(xrde129),SUM(xrde129_1)",
                 "  FROM(",
                 "       SELECT xrde100,SUM(xrde129) xrde129,0 xrde129_1 FROM xrde_t,gzcb_t",
                 "        WHERE xrde002 = gzcb002",
                 "          AND gzcb001 = '8306'",
                 "          AND gzcb004 = '1'",
                 "          AND xrdeent = '",g_enterprise,"'",
                 "          AND xrdedocno = '",g_docno,"'",
                 "          AND xrdeld = '",g_ld,"'",
                 "        GROUP BY xrde100",
                 "        UNION ",
                 "       SELECT xrce100,0 xrde129,SUM(xrce129) xrde129_1 FROM xrce_t,gzcb_t",
                 "        WHERE xrce002 = gzcb002",
                 "          AND gzcb001 = '8306'",
                 "          AND gzcb004 = '2'",
                 "          AND xrceent = '",g_enterprise,"'",
                 "          AND xrcedocno = '",g_docno,"'",
                 "          AND xrceld = '",g_ld,"'",
                 "        GROUP BY xrce100",
                 "      )",
                 " GROUP BY xrde100"
      PREPARE axrt400_01_prep312 FROM l_sql
      DECLARE axrt400_01_xrde12 CURSOR FOR axrt400_01_prep312
   
      #產生本位幣二匯兌損益
      FOREACH axrt400_01_xrde12 INTO l_xrde100,l_xrde119,l_xrde119_1
         #本幣帳款 < 收款:12.匯兌收益;　反之 11.匯兌損失.
         IF l_xrde119 != l_xrde119_1 THEN
            IF l_xrde119 < l_xrde119_1 THEN
               LET l_xrde_t.xrde002  = '11'
               LET l_glab003 = '9711_12'
               LET l_amt = l_xrde119_1 - l_xrde119
            ELSE
               LET l_xrde_t.xrde002  = '12'
               LET l_glab003 = '9711_11'
               LET l_amt = l_xrde119 - l_xrde119_1
            END IF
            SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = l_xrde_t.xrde002
               AND gzcb001 = '8306'
            LET l_xrde_t.xrde006  = ''
            LET l_xrde_t.xrde001  = 'axrt400'
            LET l_xrde_t.xrde003  = ''
            LET l_xrde_t.xrde004  = ''
            LET l_xrde_t.xrde008  = ''
            LET l_xrde_t.xrde010  = ''
            LET l_xrde_t.xrde013  = ''
            LET l_xrde_t.xrde014  = ''
            LET l_xrde_t.xrde020  = ''
            LET l_xrde_t.xrde022  = ''
            LET l_xrde_t.xrde023  = ''
            LET l_xrde_t.xrde017  = g_xrda003
            SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xrda003
            LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
               
            SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = g_ld
               AND glab003 = l_glab003
            
            SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = l_xrde_t.xrde011
              
            #151210-00004#1--mark--str--lujh  
            #SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
            # WHERE gzcb002 = '20'
            #   AND gzcb001 = '8306'
            #151210-00004#1--mark--end--lujh  

                                     #類型;帳套;日期;來源幣別
            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa016,
                                     #目的幣別;         交易金額;               匯類類型
                                      g_glaa_t.glaa001,l_amt,g_glaa_t.glaa018)
                RETURNING l_xrde_t.xrde109
                
            IF l_xrde_t.xrde109 = 1 THEN LET l_xrde_t.xrde109 = l_amt END IF

                                     #類型;帳套;日期;來源幣別
            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
                                     #目的幣別;         交易金額;               匯類類型
                                      g_glaa_t.glaa016,0,g_glaa_t.glaa018)
                RETURNING l_xrde_t.xrde121

            LET l_xrde_t.xrde100  = g_glaa_t.glaa001
            LET l_xrde_t.xrde101  = 1
            LET l_xrde_t.xrde119  = l_xrde_t.xrde109
            LET l_xrde_t.xrde120  = g_glaa_t.glaa016
            LET l_xrde_t.xrde129  = l_amt
            LET l_xrde_t.xrde130  = ''
            LET l_xrde_t.xrde131  = 0
            LET l_xrde_t.xrde139  = 0

            #INSERT INTO xrde_t VALUES(l_xrde_t.*)
            INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                            l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                            l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                            l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                            l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                            l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                            l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                            l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                            l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                            ) 
            IF SQLCA.sqlcode THEN
               LET g_success = 'N' RETURN
            END IF
            
            LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
            
         END IF

      END FOREACH
   END IF

   #本幣
   LET l_sql ="SELECT SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1),SUM(xrde109_2),SUM(xrde119_2)",
              "  FROM(",
              "       SELECT SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrde_t",       #收款金額
              "        WHERE xrde002 = 10",
              "          AND xrdeent = '",g_enterprise,"'",
              "          AND xrdedocno = '",g_docno,"'",
              "          AND xrdeld = '",g_ld,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,SUM(xrce109 * CASE WHEN gzcb003 = 'D' THEN -1 ELSE 1 END) xrde109_1,SUM(xrce119 * CASE WHEN gzcb003 = 'D' THEN -1 ELSE 1 END) xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrce_t,gzcb_t",#帳款金額   #151210-00004#1 add * CASE WHEN gzcb003 = 'D' THEN -1 ELSE 1 END lujh  
              "        WHERE xrce002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '2'",
              "          AND xrceent = '",g_enterprise,"'",
              "          AND xrcedocno = '",g_docno,"'",
              "          AND xrceld = '",g_ld,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,0 xrde109_1,0 xrde119_1,SUM(xrde109 * CASE WHEN gzcb003 = 'D' THEN -1 ELSE 1 END) xrde109_2,SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN -1 ELSE 1 END) xrde119_2 FROM xrde_t,gzcb_t",#帳款金額
              "        WHERE xrde002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '1'",
              "          AND xrde002 <> 10",
              "          AND xrdeent = '",g_enterprise,"'",
              "          AND xrdedocno = '",g_docno,"'",
              "          AND xrdeld = '",g_ld,"'",
              "      )"
   PREPARE axrt400_01_prep31 FROM l_sql
   DECLARE axrt400_01_xrde1 CURSOR FOR axrt400_01_prep31

   FOREACH axrt400_01_xrde1 INTO l_xrde109,l_xrde119,l_xrde109_1,l_xrde119_1,l_xrde109_2,l_xrde119_2
      IF cl_null(l_xrde109)   THEN LET l_xrde109   = 0 END IF
      IF cl_null(l_xrde119)   THEN LET l_xrde119   = 0 END IF
      IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
      IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
      IF cl_null(l_xrde109_2) THEN LET l_xrde109_2 = 0 END IF
      IF cl_null(l_xrde119_2) THEN LET l_xrde119_2 = 0 END IF
      #本幣帳款 < 收款:12.匯兌收益;　反之(11.匯損).
      #需要考慮本位幣二、三產生的匯兌損益
      IF l_xrde119 - l_xrde119_2 != l_xrde119_1 THEN
         LET l_amt = l_xrde119 - l_xrde119_2 - l_xrde119_1
         IF l_amt < 0 THEN
            LET l_xrde_t.xrde002  = '11'
            LET l_glab003 = '9711_12'
            LET l_amt = l_amt * -1
         ELSE
            LET l_xrde_t.xrde002  = '12'
            LET l_glab003 = '9711_11'
         END IF
         SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
          WHERE gzcb002 = l_xrde_t.xrde002
            AND gzcb001 = '8306'
         LET l_xrde_t.xrde006  = ''
         LET l_xrde_t.xrde001  = 'axrt400'
         LET l_xrde_t.xrde003  = ''
         LET l_xrde_t.xrde004  = ''
         LET l_xrde_t.xrde008  = ''
         LET l_xrde_t.xrde010  = ''
         LET l_xrde_t.xrde013  = ''
         LET l_xrde_t.xrde014  = ''
         LET l_xrde_t.xrde100  = g_glaa_t.glaa001
         LET l_xrde_t.xrde101  = 1
         LET l_xrde_t.xrde109  = l_amt
         LET l_xrde_t.xrde119  = l_amt
         LET l_xrde_t.xrde120 = ''
         LET l_xrde_t.xrde121 = 0
         LET l_xrde_t.xrde129 = 0
         LET l_xrde_t.xrde130 = ''
         LET l_xrde_t.xrde131 = 0
         LET l_xrde_t.xrde139 = 0
         LET l_xrde_t.xrde017  = g_xrda003
         LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
         LET l_xrde_t.xrde020  = ''
         LET l_xrde_t.xrde022  = ''
         LET l_xrde_t.xrde023  = ''
         SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_xrda003
            
         SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_ld
            AND glab003 = l_glab003
         
         SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
          WHERE nmadent = g_enterprise
            AND nmad001 = g_glaa_t.glaa005
            AND nmad002 = l_xrde_t.xrde011
           
         #151210-00004#1--mark--str--lujh    
         #SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
         # WHERE gzcb002 = '20'
         #   AND gzcb001 = '8306'
         #151210-00004#1--mark--end--lujh  

         #INSERT INTO xrde_t VALUES(l_xrde_t.*)
         INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                            l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                            l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                            l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                            l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                            l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                            l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                            l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                            l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                            )    
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         END IF
         
         LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
         
      END IF

   END FOREACH
END FUNCTION

 
{</section>}
 
