#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp550.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-11-17 10:48:02), PR版次:0010(2017-02-10 15:20:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000308
#+ Filename...: aglp550
#+ Description: 常用及分攤傳票複製產生作業
#+ Creator....: 02291(2014-07-03 16:36:50)
#+ Modifier...: 02291 -SD/PR- 02599
 
{</section>}
 
{<section id="aglp550.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151222-00008#4   2015/12/22  By 02599  删除凭证单号时同步更新单别对应的最大流水号
#160318-00005#16  2016/03/25  by 07675  將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#42  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160824-00023#1   2016/08/30  By 02599   打印次数glap012=0
#160919-00014#1   2016/09/19  By 02599   1.金额增加按照币别取位,2.抓取金额来源增加核算项限制条件,
#                                        3.变动比率，取得變動分子科目總和=按常用分攤傳票單身指定的各變動分子科目,取科餘檔(glar_t)加總
#160920-00026#1   2016/09/21  By 02599   当天重复执行aglp550时，不论是否勾选‘同日已生成凭证者，重复产生’，都要把作废的凭证排除掉。
#161128-00061#1   2016/11/29  by 02481   标准程式定义采用宣告模式,弃用.*写法
#161208-00035#1   2016/12/29  By 02599   常用凭证设置作业中，当单身维护的科目+核算项，与金额来源科目中的科目+核算项资料相同时，
#                                        产生凭证的金额=单身维护的科目+核算项对应的金额 * 单身中该科目设置的比率（glam003）,
#                                        抓取金额的‘余额来源’‘余额性质’‘来源性质’等这些条件依照金额来源设置 
#170103-00019#18  2017/01/04  By 02599   抛转产生凭证时，同步产生相关细项立账资料
#170210-00041#1   2017/02/10  By 02599   常用分摊凭证复制时，glap015记录分摊单号，当判断同一日是否已有凭证产生时，增加分摊单号检核
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       year LIKE type_t.num5, 
   month LIKE type_t.num5, 
   glalld LIKE glal_t.glalld, 
   glalld_desc LIKE type_t.chr80, 
   glal002 LIKE glal_t.glal002, 
   glal002_desc LIKE type_t.chr80, 
   glan018 LIKE type_t.num5, 
   glan019 LIKE type_t.num5, 
   glapdocdt LIKE type_t.dat, 
   glap002 LIKE type_t.num5, 
   glap004 LIKE type_t.num5, 
   regenerate LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數

DEFINE g_glaa010             LIKE glaa_t.glaa010    #现行年度
DEFINE g_glaa011             LIKE glaa_t.glaa011    #期别
DEFINE g_glaa013             LIKE glaa_t.glaa013    #关账日期
DEFINE g_glaa001             LIKE glaa_t.glaa001    #账簿币别
DEFINE g_glaa003             LIKE glaa_t.glaa003    #会计周期表号
DEFINE g_glaa004             LIKE glaa_t.glaa004    #会计科目参照表号
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa024             LIKE glaa_t.glaa024    #单据别参照表号
DEFINE g_glaacomp            LIKE glaa_t.glaacomp   #归属法人
DEFINE g_glaldocno           LIKE glal_t.glaldocno
DEFINE g_glalld              LIKE glal_t.glalld
DEFINE g_glal001             LIKE glal_t.glal001
DEFINE g_glal006             LIKE glal_t.glal006
DEFINE g_glal007             LIKE glal_t.glal007
#161128-00061#1----modify------begin-----------
#DEFINE g_glal                RECORD LIKE glal_t.*
#DEFINE g_glam                RECORD LIKE glam_t.*
#DEFINE g_glan                RECORD LIKE glan_t.*
#DEFINE g_glar                RECORD LIKE glar_t.*
#DEFINE g_glap                RECORD LIKE glap_t.*
#DEFINE g_glaq                RECORD LIKE glaq_t.*
DEFINE g_glap RECORD  #傳票憑證單頭檔
       glapent LIKE glap_t.glapent, #企業編號
       glapld LIKE glap_t.glapld, #帳套
       glapcomp LIKE glap_t.glapcomp, #法人
       glapdocno LIKE glap_t.glapdocno, #單號
       glapdocdt LIKE glap_t.glapdocdt, #單據日期
       glap001 LIKE glap_t.glap001, #傳票性質
       glap002 LIKE glap_t.glap002, #會計年度
       glap003 LIKE glap_t.glap003, #會計季別
       glap004 LIKE glap_t.glap004, #會計期別
       glap005 LIKE glap_t.glap005, #會計周別
       glap006 LIKE glap_t.glap006, #收支科目
       glap007 LIKE glap_t.glap007, #來源碼
       glap008 LIKE glap_t.glap008, #帳款類型
       glap009 LIKE glap_t.glap009, #總號
       glap010 LIKE glap_t.glap010, #借方總金額
       glap011 LIKE glap_t.glap011, #貸方總金額
       glap012 LIKE glap_t.glap012, #列印次數
       glap013 LIKE glap_t.glap013, #附件張數
       glap014 LIKE glap_t.glap014, #外幣憑證否
       glap015 LIKE glap_t.glap015, #原傳票編號
       glap016 LIKE glap_t.glap016, #來源帳套編號
       glap017 LIKE glap_t.glap017, #來源傳票編號
       glapownid LIKE glap_t.glapownid, #資料所有者
       glapowndp LIKE glap_t.glapowndp, #資料所屬部門
       glapcrtid LIKE glap_t.glapcrtid, #資料建立者
       glapcrtdp LIKE glap_t.glapcrtdp, #資料建立部門
       glapcrtdt LIKE glap_t.glapcrtdt, #資料創建日
       glapmodid LIKE glap_t.glapmodid, #資料修改者
       glapmoddt LIKE glap_t.glapmoddt, #最近修改日
       glapcnfid LIKE glap_t.glapcnfid, #資料確認者
       glapcnfdt LIKE glap_t.glapcnfdt, #資料確認日
       glappstid LIKE glap_t.glappstid, #資料過帳者
       glappstdt LIKE glap_t.glappstdt, #資料過帳日
       glapstus LIKE glap_t.glapstus    #狀態碼
       END RECORD
       
DEFINE g_glaq RECORD  #傳票憑證單身檔
       glaqent LIKE glaq_t.glaqent, #企業編號
       glaqcomp LIKE glaq_t.glaqcomp, #法人
       glaqld LIKE glaq_t.glaqld, #帳套
       glaqdocno LIKE glaq_t.glaqdocno, #單號
       glaqseq LIKE glaq_t.glaqseq, #項次
       glaq001 LIKE glaq_t.glaq001, #摘要
       glaq002 LIKE glaq_t.glaq002, #科目編號
       glaq003 LIKE glaq_t.glaq003, #借方金額
       glaq004 LIKE glaq_t.glaq004, #貸方金額
       glaq005 LIKE glaq_t.glaq005, #交易幣別
       glaq006 LIKE glaq_t.glaq006, #匯率
       glaq007 LIKE glaq_t.glaq007, #計價單位
       glaq008 LIKE glaq_t.glaq008, #數量
       glaq009 LIKE glaq_t.glaq009, #單價
       glaq010 LIKE glaq_t.glaq010, #原幣金額
       glaq011 LIKE glaq_t.glaq011, #票據編碼
       glaq012 LIKE glaq_t.glaq012, #票據日期
       glaq013 LIKE glaq_t.glaq013, #申請人
       glaq014 LIKE glaq_t.glaq014, #銀行帳號
       glaq015 LIKE glaq_t.glaq015, #款別編號
       glaq016 LIKE glaq_t.glaq016, #收支專案
       glaq017 LIKE glaq_t.glaq017, #營運據點
       glaq018 LIKE glaq_t.glaq018, #部門
       glaq019 LIKE glaq_t.glaq019, #利潤/成本中心
       glaq020 LIKE glaq_t.glaq020, #區域
       glaq021 LIKE glaq_t.glaq021, #收付款客商
       glaq022 LIKE glaq_t.glaq022, #帳款客戶
       glaq023 LIKE glaq_t.glaq023, #客群
       glaq024 LIKE glaq_t.glaq024, #產品類別
       glaq025 LIKE glaq_t.glaq025, #人員
       glaq026 LIKE glaq_t.glaq026, #no use
       glaq027 LIKE glaq_t.glaq027, #專案編號
       glaq028 LIKE glaq_t.glaq028, #WBS
       glaq029 LIKE glaq_t.glaq029, #自由核算項一
       glaq030 LIKE glaq_t.glaq030, #自由核算項二
       glaq031 LIKE glaq_t.glaq031, #自由核算項三
       glaq032 LIKE glaq_t.glaq032, #自由核算項四
       glaq033 LIKE glaq_t.glaq033, #自由核算項五
       glaq034 LIKE glaq_t.glaq034, #自由核算項六
       glaq035 LIKE glaq_t.glaq035, #自由核算項七
       glaq036 LIKE glaq_t.glaq036, #自由核算項八
       glaq037 LIKE glaq_t.glaq037, #自由核算項九
       glaq038 LIKE glaq_t.glaq038, #自由核算項十
       glaq039 LIKE glaq_t.glaq039, #匯率(本位幣二)
       glaq040 LIKE glaq_t.glaq040, #借方金額(本位幣二)
       glaq041 LIKE glaq_t.glaq041, #貸方金額(本位幣二)
       glaq042 LIKE glaq_t.glaq042, #匯率(本位幣三)
       glaq043 LIKE glaq_t.glaq043, #借方金額(本位幣三)
       glaq044 LIKE glaq_t.glaq044, #貸方金額(本位幣三)
       glaq051 LIKE glaq_t.glaq051, #經營方式
       glaq052 LIKE glaq_t.glaq052, #渠道
       glaq053 LIKE glaq_t.glaq053  #品牌
      #170103-00019#18--add--str--
      ,glaqud001 LIKE glaq_t.glaqud001, #自定義欄位(文字)001
       glaqud002 LIKE glaq_t.glaqud002, #自定義欄位(文字)002
       glaqud003 LIKE glaq_t.glaqud003, #自定義欄位(文字)003
       glaqud004 LIKE glaq_t.glaqud004, #自定義欄位(文字)004
       glaqud005 LIKE glaq_t.glaqud005, #自定義欄位(文字)005
       glaqud006 LIKE glaq_t.glaqud006, #自定義欄位(文字)006
       glaqud007 LIKE glaq_t.glaqud007, #自定義欄位(文字)007
       glaqud008 LIKE glaq_t.glaqud008, #自定義欄位(文字)008
       glaqud009 LIKE glaq_t.glaqud009, #自定義欄位(文字)009
       glaqud010 LIKE glaq_t.glaqud010, #自定義欄位(文字)010
       glaqud011 LIKE glaq_t.glaqud011, #自定義欄位(數字)011
       glaqud012 LIKE glaq_t.glaqud012, #自定義欄位(數字)012
       glaqud013 LIKE glaq_t.glaqud013, #自定義欄位(數字)013
       glaqud014 LIKE glaq_t.glaqud014, #自定義欄位(數字)014
       glaqud015 LIKE glaq_t.glaqud015, #自定義欄位(數字)015
       glaqud016 LIKE glaq_t.glaqud016, #自定義欄位(數字)016
       glaqud017 LIKE glaq_t.glaqud017, #自定義欄位(數字)017
       glaqud018 LIKE glaq_t.glaqud018, #自定義欄位(數字)018
       glaqud019 LIKE glaq_t.glaqud019, #自定義欄位(數字)019
       glaqud020 LIKE glaq_t.glaqud020, #自定義欄位(數字)020
       glaqud021 LIKE glaq_t.glaqud021, #自定義欄位(日期時間)021
       glaqud022 LIKE glaq_t.glaqud022, #自定義欄位(日期時間)022
       glaqud023 LIKE glaq_t.glaqud023, #自定義欄位(日期時間)023
       glaqud024 LIKE glaq_t.glaqud024, #自定義欄位(日期時間)024
       glaqud025 LIKE glaq_t.glaqud025, #自定義欄位(日期時間)025
       glaqud026 LIKE glaq_t.glaqud026, #自定義欄位(日期時間)026
       glaqud027 LIKE glaq_t.glaqud027, #自定義欄位(日期時間)027
       glaqud028 LIKE glaq_t.glaqud028, #自定義欄位(日期時間)028
       glaqud029 LIKE glaq_t.glaqud029, #自定義欄位(日期時間)029
       glaqud030 LIKE glaq_t.glaqud030  #自定義欄位(日期時間)030
      #170103-00019#18--add--end 
       END RECORD

DEFINE g_glal RECORD  #常用分攤傳票單頭檔
       glalent LIKE glal_t.glalent, #企業編號
       glalownid LIKE glal_t.glalownid, #資料所有者
       glalowndp LIKE glal_t.glalowndp, #資料所屬部門
       glalcrtid LIKE glal_t.glalcrtid, #資料建立者
       glalcrtdp LIKE glal_t.glalcrtdp, #資料建立部門
       glalcrtdt LIKE glal_t.glalcrtdt, #資料創建日
       glalmodid LIKE glal_t.glalmodid, #資料修改者
       glalmoddt LIKE glal_t.glalmoddt, #最近修改日
       glalcnfid LIKE glal_t.glalcnfid, #資料確認者
       glalcnfdt LIKE glal_t.glalcnfdt, #資料確認日
       glalpstid LIKE glal_t.glalpstid, #資料過帳者
       glalpstdt LIKE glal_t.glalpstdt, #資料過帳日
       glalstus LIKE glal_t.glalstus, #狀態碼
       glalld LIKE glal_t.glalld, #帳套(套)編號
       glalcomp LIKE glal_t.glalcomp, #營運據點(法人)
       glaldocno LIKE glal_t.glaldocno, #分攤編號
       glaldocdt LIKE glal_t.glaldocdt, #單據日期
       glal001 LIKE glal_t.glal001, #分攤性質
       glal002 LIKE glal_t.glal002, #分攤類別
       glal003 LIKE glal_t.glal003, #自動產生順序
       glal004 LIKE glal_t.glal004, #起始日期
       glal005 LIKE glal_t.glal005, #截止日期
       glal006 LIKE glal_t.glal006, #傳票單別
       glal007 LIKE glal_t.glal007  #上次產生日期
       END RECORD

DEFINE g_glam RECORD  #常用分攤傳票單身檔
       glament LIKE glam_t.glament, #企業編號
       glamld LIKE glam_t.glamld, #帳套(套)編號
       glamcomp LIKE glam_t.glamcomp, #營運據點(法人
       glamdocno LIKE glam_t.glamdocno, #分攤編號
       glamseq LIKE glam_t.glamseq, #項次
       glam001 LIKE glam_t.glam001, #摘要
       glam002 LIKE glam_t.glam002, #科目編號
       glam003 LIKE glam_t.glam003, #借方金額/比率
       glam004 LIKE glam_t.glam004, #貸方金額/比率
       glam005 LIKE glam_t.glam005, #借方變動比率分子科目
       glam006 LIKE glam_t.glam006, #貸方變動比率分子科目
       glam007 LIKE glam_t.glam007, #營運據點
       glam008 LIKE glam_t.glam008, #部門
       glam009 LIKE glam_t.glam009, #利潤/成本中心
       glam010 LIKE glam_t.glam010, #區域
       glam011 LIKE glam_t.glam011, #收付款客商
       glam012 LIKE glam_t.glam012, #帳款客商
       glam013 LIKE glam_t.glam013, #客群
       glam014 LIKE glam_t.glam014, #產品類別
       glam015 LIKE glam_t.glam015, #人員
       glam016 LIKE glam_t.glam016, #no use
       glam017 LIKE glam_t.glam017, #專案編號
       glam018 LIKE glam_t.glam018, #WBS
       glam019 LIKE glam_t.glam019, #營運據點(借)
       glam020 LIKE glam_t.glam020, #部門(借)
       glam021 LIKE glam_t.glam021, #利潤/成本中心(借)
       glam022 LIKE glam_t.glam022, #區域(借)
       glam023 LIKE glam_t.glam023, #收付款客商(借)
       glam024 LIKE glam_t.glam024, #帳款客商(借)
       glam025 LIKE glam_t.glam025, #客群(借)
       glam026 LIKE glam_t.glam026, #產品類別(借)
       glam027 LIKE glam_t.glam027, #人員(借)
       glam028 LIKE glam_t.glam028, #no use
       glam029 LIKE glam_t.glam029, #專案編號(借)
       glam030 LIKE glam_t.glam030, #WBS(借)
       glam031 LIKE glam_t.glam031, #營運據點(貸)
       glam032 LIKE glam_t.glam032, #部門(貸)
       glam033 LIKE glam_t.glam033, #利潤/成本中心(貸)
       glam034 LIKE glam_t.glam034, #區域(貸)
       glam035 LIKE glam_t.glam035, #收付款客商(貸)
       glam036 LIKE glam_t.glam036, #帳款客商(貸)
       glam037 LIKE glam_t.glam037, #客群(貸)
       glam038 LIKE glam_t.glam038, #產品類別(貸)
       glam039 LIKE glam_t.glam039, #人員(貸)
       glam040 LIKE glam_t.glam040, #no use
       glam041 LIKE glam_t.glam041, #專案編號(貸)
       glam042 LIKE glam_t.glam042, #WBS(貸)
       glam043 LIKE glam_t.glam043, #匯率(本位幣二)
       glam044 LIKE glam_t.glam044, #借方金額(本位幣二)
       glam045 LIKE glam_t.glam045, #貸方金額(本位幣二)
       glam046 LIKE glam_t.glam046, #匯率(本位幣三)
       glam047 LIKE glam_t.glam047, #借方金額(本位幣三)
       glam048 LIKE glam_t.glam048, #貸方金額(本位幣三)
       glam051 LIKE glam_t.glam051, #經營方式
       glam052 LIKE glam_t.glam052, #渠道
       glam053 LIKE glam_t.glam053, #品牌
       glam054 LIKE glam_t.glam054, #經營方式(借)
       glam055 LIKE glam_t.glam055, #渠道(借)
       glam056 LIKE glam_t.glam056, #品牌(借)
       glam057 LIKE glam_t.glam057, #經營方式(貸)
       glam058 LIKE glam_t.glam058, #渠道(貸)
       glam059 LIKE glam_t.glam059  #品牌(貸)
       END RECORD

DEFINE g_glan RECORD  #分攤金額來源檔
       glanent LIKE glan_t.glanent, #企業編號
       glanownid LIKE glan_t.glanownid, #資料所有者
       glanowndp LIKE glan_t.glanowndp, #資料所屬部門
       glancrtid LIKE glan_t.glancrtid, #資料建立者
       glancrtdp LIKE glan_t.glancrtdp, #資料建立部門
       glancrtdt LIKE glan_t.glancrtdt, #資料創建日
       glanmodid LIKE glan_t.glanmodid, #資料修改者
       glanmoddt LIKE glan_t.glanmoddt, #最近修改日
       glancnfid LIKE glan_t.glancnfid, #資料確認者
       glancnfdt LIKE glan_t.glancnfdt, #資料確認日
       glanpstid LIKE glan_t.glanpstid, #資料過帳者
       glanpstdt LIKE glan_t.glanpstdt, #資料過帳日
       glanstus LIKE glan_t.glanstus, #狀態碼
       glanld LIKE glan_t.glanld, #帳套(套)編號
       glandocno LIKE glan_t.glandocno, #分攤編號
       glanseq LIKE glan_t.glanseq, #項次
       glan001 LIKE glan_t.glan001, #科目編號
       glan002 LIKE glan_t.glan002, #分攤百分比
       glan003 LIKE glan_t.glan003, #營運據點
       glan004 LIKE glan_t.glan004, #部門
       glan005 LIKE glan_t.glan005, #利潤/成本中心
       glan006 LIKE glan_t.glan006, #區域
       glan007 LIKE glan_t.glan007, #收付款客商
       glan008 LIKE glan_t.glan008, #帳款客商
       glan009 LIKE glan_t.glan009, #客群
       glan010 LIKE glan_t.glan010, #產品類別
       glan011 LIKE glan_t.glan011, #人員
       glan012 LIKE glan_t.glan012, #no use
       glan013 LIKE glan_t.glan013, #專案編號
       glan014 LIKE glan_t.glan014, #WBS
       glan015 LIKE glan_t.glan015, #餘額來源
       glan016 LIKE glan_t.glan016, #餘額性質
       glan017 LIKE glan_t.glan017, #來源性質
       glan018 LIKE glan_t.glan018, #餘額來源年度
       glan019 LIKE glan_t.glan019, #餘額來源期別
       glan051 LIKE glan_t.glan051, #經營方式
       glan052 LIKE glan_t.glan052, #渠道
       glan053 LIKE glan_t.glan053  #品牌
       END RECORD
DEFINE g_glar RECORD  #會計科目各期餘額檔
       glarent LIKE glar_t.glarent, #企業編號
       glarcomp LIKE glar_t.glarcomp, #法人
       glarld LIKE glar_t.glarld, #帳套
       glar001 LIKE glar_t.glar001, #會計科目
       glar002 LIKE glar_t.glar002, #年度
       glar003 LIKE glar_t.glar003, #期別
       glar004 LIKE glar_t.glar004, #組合要素(key)
       glar005 LIKE glar_t.glar005, #借方金額
       glar006 LIKE glar_t.glar006, #貸方金額
       glar007 LIKE glar_t.glar007, #借方筆數
       glar008 LIKE glar_t.glar008, #貸方筆數
       glar009 LIKE glar_t.glar009, #交易幣別
       glar010 LIKE glar_t.glar010, #原幣借方金額
       glar011 LIKE glar_t.glar011, #原幣貸方金額
       glar012 LIKE glar_t.glar012, #營運據點
       glar013 LIKE glar_t.glar013, #部門
       glar014 LIKE glar_t.glar014, #利潤/成本中心
       glar015 LIKE glar_t.glar015, #區域
       glar016 LIKE glar_t.glar016, #收付款客商
       glar017 LIKE glar_t.glar017, #帳款客商
       glar018 LIKE glar_t.glar018, #客群
       glar019 LIKE glar_t.glar019, #產品類別
       glar020 LIKE glar_t.glar020, #人員
       glar021 LIKE glar_t.glar021, #no use
       glar022 LIKE glar_t.glar022, #專案編號
       glar023 LIKE glar_t.glar023, #WBS
       glar024 LIKE glar_t.glar024, #自由核算項一
       glar025 LIKE glar_t.glar025, #自由核算項二
       glar026 LIKE glar_t.glar026, #自由核算項三
       glar027 LIKE glar_t.glar027, #自由核算項四
       glar028 LIKE glar_t.glar028, #自由核算項五
       glar029 LIKE glar_t.glar029, #自由核算項六
       glar030 LIKE glar_t.glar030, #自由核算項七
       glar031 LIKE glar_t.glar031, #自由核算項八
       glar032 LIKE glar_t.glar032, #自由核算項九
       glar033 LIKE glar_t.glar033, #自由核算項十
       glar034 LIKE glar_t.glar034, #借方金額(本位幣二)
       glar035 LIKE glar_t.glar035, #貸方金額(本位幣二)
       glar036 LIKE glar_t.glar036, #借方金額(本位幣三)
       glar037 LIKE glar_t.glar037, #貸方金額(本位幣三)
       glar051 LIKE glar_t.glar051, #經營方式
       glar052 LIKE glar_t.glar052, #通路
       glar053 LIKE glar_t.glar053  #品牌
       END RECORD
#161128-00061#1----modify------end-----------
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp550.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aglp550_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp550 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp550_init()
 
      #進入選單 Menu (="N")
      CALL aglp550_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp550
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp550.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp550_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   #获取预设主帐别
   CALL s_ld_bookno()  RETURNING l_success,g_glalld
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   LET g_glaa010 = ''
   LET g_glaa011 = ''
   LET g_glaa013 = ''
   SELECT glaacomp,glaa001,glaa003,glaa004,glaa010,glaa011,glaa013,glaa015,glaa016,
          glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa024
     INTO g_glaacomp,g_glaa001,g_glaa003,g_glaa004,g_glaa010,g_glaa011,g_glaa013,g_glaa015,g_glaa016,
          g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glalld


  #CALL aglp550_default_search()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp550.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp550_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_pass    LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CLEAR FORM 
  #LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.year,g_master.month,g_master.glalld,g_master.glal002,g_master.glan018, 
             g_master.glan019,g_master.glapdocdt,g_master.glap002,g_master.glap004,g_master.regenerate  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #预设值
               LET g_master.year = g_glaa010
               LET g_master.month = g_glaa011
               DISPLAY g_master.year TO year
               DISPLAY g_master.month TO month
              
               LET g_master.glalld =  g_glalld
               CALL aglp550_glal_desc() 
               DISPLAY g_master.glalld_desc TO glalld_desc
               DISPLAY g_master.glalld TO glalld
               LET g_master.glan018 = g_glaa010
               LET g_master.glan019 = g_glaa011
               LET g_master.glapdocdt = g_today
               LET g_master.glap002 = year(g_master.glapdocdt)
               LET g_master.glap004 = month(g_master.glapdocdt)
               LET g_master.regenerate = 'N'
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glalld
            
            #add-point:AFTER FIELD glalld name="input.a.glalld"
            IF NOT cl_null(g_master.glalld) THEN
               CALL aglp550_glalld_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.glalld
                  #160318-00005#16  --add--str
                  LET g_errparam.replace[1] ='agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog    ='agli010'
                  #160318-00005#16  --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glalld = ''
                  DISPLAY '' TO glalld_desc
                  NEXT FIELD glalld
               END IF 
               #检查使用者是否有权限使用当前账别
               CALL s_ld_chk_authorization(g_user,g_master.glalld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_master.glalld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glalld = ''
                  DISPLAY '' TO glalld_desc
                  NEXT FIELD glalld
               END IF 
               
               SELECT glaacomp,glaa001,glaa003,glaa004,glaa010,glaa011,glaa013,glaa015,glaa016,
                      glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa024
                 INTO g_glaacomp,g_glaa001,g_glaa003,g_glaa004,g_glaa010,g_glaa011,g_glaa013,g_glaa015,g_glaa016,
                      g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa024
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_master.glalld                  
            END IF 
            CALL aglp550_glal_desc() 
            DISPLAY g_master.glalld_desc TO glalld_desc
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glalld
            #add-point:BEFORE FIELD glalld name="input.b.glalld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glalld
            #add-point:ON CHANGE glalld name="input.g.glalld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glal002
            
            #add-point:AFTER FIELD glal002 name="input.a.glal002"
            IF NOT cl_null(g_master.glal002) THEN 
#此段落由子樣板a19產生
               CALL aglp550_glal_desc()
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.glal002

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.glal002 = ''
                  CALL aglp550_glal_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glal002
            #add-point:BEFORE FIELD glal002 name="input.b.glal002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glal002
            #add-point:ON CHANGE glal002 name="input.g.glal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glan018
            #add-point:BEFORE FIELD glan018 name="input.b.glan018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan018
            
            #add-point:AFTER FIELD glan018 name="input.a.glan018"
            IF NOT cl_null(g_master.glan018) THEN
               IF g_master.glan018 <1000 OR g_master.glan018 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_master.glan018
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glan018 =''
                  NEXT FIELD glan018
               END IF
               IF g_master.glan018 < YEAR(g_glaa013) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00163'
                  LET g_errparam.extend = g_master.glan018
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glan018 =''
                  NEXT FIELD glan018
               END IF 
               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glan018
            #add-point:ON CHANGE glan018 name="input.g.glan018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glan019
            #add-point:BEFORE FIELD glan019 name="input.b.glan019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan019
            
            #add-point:AFTER FIELD glan019 name="input.a.glan019"
            IF NOT cl_null(g_master.glan019) THEN
               IF (g_master.glan019 < 1) OR (g_master.glan019 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_master.glan019
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glan019 = ''
                  NEXT FIELD glan019
               END IF 
               IF g_master.glan018 = YEAR(g_glaa013) AND  g_master.glan019 < MONTH(g_glaa013) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00163'
                  LET g_errparam.extend = g_master.glan019
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_master.glan019 = ''
                  NEXT FIELD glan019
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glan019
            #add-point:ON CHANGE glan019 name="input.g.glan019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocdt
            #add-point:BEFORE FIELD glapdocdt name="input.b.glapdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocdt
            
            #add-point:AFTER FIELD glapdocdt name="input.a.glapdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocdt
            #add-point:ON CHANGE glapdocdt name="input.g.glapdocdt"
            IF NOT cl_null(g_master.glapdocdt) THEN 
               LET g_master.glap002 = year(g_master.glapdocdt)
               LET g_master.glap004 = month(g_master.glapdocdt)
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.glap002,"1000.000","1","9999.000","1","azz-00087",1) THEN
               NEXT FIELD glap002
            END IF 
 
 
 
            #add-point:AFTER FIELD glap002 name="input.a.glap002"
            IF NOT cl_null(g_master.glap002) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap002
            #add-point:BEFORE FIELD glap002 name="input.b.glap002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap002
            #add-point:ON CHANGE glap002 name="input.g.glap002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.glap004,"1.000","1","13.000","1","azz-00087",1) THEN
               NEXT FIELD glap004
            END IF 
 
 
 
            #add-point:AFTER FIELD glap004 name="input.a.glap004"
            IF NOT cl_null(g_master.glap004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap004
            #add-point:BEFORE FIELD glap004 name="input.b.glap004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap004
            #add-point:ON CHANGE glap004 name="input.g.glap004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD regenerate
            #add-point:BEFORE FIELD regenerate name="input.b.regenerate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD regenerate
            
            #add-point:AFTER FIELD regenerate name="input.a.regenerate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE regenerate
            #add-point:ON CHANGE regenerate name="input.g.regenerate"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.glalld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glalld
            #add-point:ON ACTION controlp INFIELD glalld name="input.c.glalld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.glalld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.glalld = g_qryparam.return1              
            CALL aglp550_glal_desc()

            DISPLAY g_master.glalld TO glalld              #
            DISPLAY g_master.glalld_desc TO glalld_desc              #

            NEXT FIELD glalld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glal002
            #add-point:ON ACTION controlp INFIELD glal002 name="input.c.glal002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.glal002             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3004" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_master.glal002 = g_qryparam.return1              
            #LET g_master.oocq002 = g_qryparam.return2 
            CALL aglp550_glal_desc() 
            DISPLAY g_master.glal002_desc TO glal002_desc
            DISPLAY g_master.glal002 TO glal002              #
            #DISPLAY g_master.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD glal002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glan018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan018
            #add-point:ON ACTION controlp INFIELD glan018 name="input.c.glan018"
            
            #END add-point
 
 
         #Ctrlp:input.c.glan019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan019
            #add-point:ON ACTION controlp INFIELD glan019 name="input.c.glan019"
            
            #END add-point
 
 
         #Ctrlp:input.c.glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocdt
            #add-point:ON ACTION controlp INFIELD glapdocdt name="input.c.glapdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap002
            #add-point:ON ACTION controlp INFIELD glap002 name="input.c.glap002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap004
            #add-point:ON ACTION controlp INFIELD glap004 name="input.c.glap004"
            
            #END add-point
 
 
         #Ctrlp:input.c.regenerate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD regenerate
            #add-point:ON ACTION controlp INFIELD regenerate name="input.c.regenerate"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
#         BEFORE DIALOG
#            NEXT FIELD glalld
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL aglp550_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            NEXT FIELD glalld
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
#         BEFORE DIALOG
#            NEXT FIELD glalld
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aglp550_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL aglp550_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp550_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglp550.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp550_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="aglp550.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp550_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5 #160920-00026#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
  #WHENEVER ERROR CONTINUE
   INITIALIZE g_glal.* TO NULL
   INITIALIZE g_glam.* TO NULL
   INITIALIZE g_glap.* TO NULL
   INITIALIZE g_glaq.* TO NULL
   INITIALIZE g_glar.* TO NULL
   LET g_success = 'Y'
   
   #开启事务
   CALL s_transaction_begin()
   
   #判断產生傳票日期是否小于关账日期
   IF (g_master.glap002 < YEAR(g_glaa013)) OR (g_master.glap002 = YEAR(g_glaa013) AND (NOT cl_null(g_master.glap004) AND g_master.glap004 < MONTH(g_glaa013))) THEN
#      CALL cl_errmsg('glaa013',g_glaa013,'','agl-00163',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_glaa013
      LET g_errparam.code = 'agl-00163'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF 
   
   #错误信息汇总初始化
   CALL cl_err_collect_init()
   LET l_count=0
   #筛选常用分摊传票数据文件中合乎输入账别/分摊类别的数据，依自动产生顺序复制到传票凭证数据单头/单身文件及传票中
   #161128-00061#1----modify------begin-----------
   #LET g_sql = " SELECT * FROM glal_t ",
   LET g_sql = " SELECT glalent,glalownid,glalowndp,glalcrtid,glalcrtdp,glalcrtdt,glalmodid,glalmoddt,",
               "glalcnfid,glalcnfdt,glalpstid,glalpstdt,glalstus,glalld,glalcomp,glaldocno,glaldocdt,",
               "glal001,glal002,glal003,glal004,glal005,glal006,glal007 FROM glal_t ",
   #161128-00061#1----modify------end-----------
               "  WHERE glalent = '",g_enterprise,"'",
               "    AND glalld = '",g_master.glalld,"'",
               "    AND glal002 = '",g_master.glal002,"'",
               "    AND glal004 <= '",g_master.glapdocdt,"'",
               "    AND glal005 >= '",g_master.glapdocdt,"'",
               "    AND glalstus = 'Y'",
               "  ORDER BY glal003,glaldocno"
   PREPARE aglp550_pre FROM g_sql
   DECLARE aglp550_cs CURSOR FOR  aglp550_pre
   FOREACH aglp550_cs INTO g_glal.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      
      IF g_master.regenerate = 'N' AND g_glal.glal007 IS NOT NULL AND g_glal.glal007 = g_master.glapdocdt THEN 
         #160920-00026#1--add--str--
         #当未勾选‘同日已生成凭证者，重复产生’时，排除同日产生且状态为作废的凭证，因为作废的凭证，可以继续产生同日凭证
         CASE g_glal.glal001 
            WHEN '1' 
               LET g_glap.glap007 = 'FC'
            WHEN '2' 
               LET g_glap.glap007 = 'FP' 
            WHEN '3' 
               LET g_glap.glap007 = 'VP'
         END CASE
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM glap_t
          WHERE glapent=g_enterprise AND glapld=g_master.glalld
            AND glapdocdt=g_master.glapdocdt
            AND glap007=g_glap.glap007
            AND glapstus <> 'X'
            AND glap015=g_glal.glaldocno #170210-00041#1 add
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "agl-00486"
            LET g_errparam.extend = g_glal.glaldocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
         #160920-00026#1--add--end
         CONTINUE FOREACH
         END IF #160920-00026#1 add
      END IF 
      
      CALL aglp550_glap_insert()
      LET l_count=l_count+1
   END FOREACH
   IF l_count=0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "aap-00313"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()
   ELSE
      CALL s_transaction_end('Y','0')
   END IF 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp550_process_cs CURSOR FROM ls_sql
#  FOREACH aglp550_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aglp550_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp550.get_buffer" >}
PRIVATE FUNCTION aglp550_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.glalld = p_dialog.getFieldBuffer('glalld')
   LET g_master.glal002 = p_dialog.getFieldBuffer('glal002')
   LET g_master.glan018 = p_dialog.getFieldBuffer('glan018')
   LET g_master.glan019 = p_dialog.getFieldBuffer('glan019')
   LET g_master.glapdocdt = p_dialog.getFieldBuffer('glapdocdt')
   LET g_master.glap002 = p_dialog.getFieldBuffer('glap002')
   LET g_master.glap004 = p_dialog.getFieldBuffer('glap004')
   LET g_master.regenerate = p_dialog.getFieldBuffer('regenerate')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp550.msgcentre_notify" >}
PRIVATE FUNCTION aglp550_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp550.other_function" readonly="Y" >}
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
PRIVATE FUNCTION aglp550_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " glalld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glaldocno = '", g_argv[02], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 說明帶值
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
PRIVATE FUNCTION aglp550_glal_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.glalld 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.glalld_desc = g_rtn_fields[1] 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.glal002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3004' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.glal002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.glal002_desc
END FUNCTION

################################################################################
# Descriptions...: glalld 帳別欄位檢查
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
PRIVATE FUNCTION aglp550_glalld_chk()
DEFINE l_glaastus  LIKE glaa_t.glaastus
   
   LET g_errno = ''
   SELECT glaastus INTO l_glaastus FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.glalld 
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#16 mod #'agl-00051'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: glal002 分攤類別欄位檢查
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
PRIVATE FUNCTION aglp550_glal002_chk()
DEFINE  l_oocqstus             LIKE oocq_t.oocqstus 
   
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '3004'
      AND oocq002 = g_master.glal002
      
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00118'
      WHEN l_oocqstus = 'N'      LET g_errno = 'agl-00119'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 傳票憑證單頭新增
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
PRIVATE FUNCTION aglp550_glap_insert()
DEFINE l_success           LIKE type_t.num5
   
   #若有勾选 '同日已产生传票者重新产生',则产生前先删除原同日分摊传票后再产生
   IF g_master.regenerate = 'Y' THEN 
       IF g_glal.glal001 = '1' THEN 
          CALL aglp550_glap_delete(g_master.glalld,g_master.glapdocdt,'FC')
       END IF
       IF g_glal.glal001 = '2' THEN 
          CALL aglp550_glap_delete(g_master.glalld,g_master.glapdocdt,'FP')
       END IF
       IF g_glal.glal001 = '3' THEN 
          CALL aglp550_glap_delete(g_master.glalld,g_master.glapdocdt,'VP')
       END IF
   END IF 
   
   
   #傳票憑證單頭
   CALL s_aooi200_fin_gen_docno(g_master.glalld,g_glaa024,g_glaa003,g_glal.glal006,g_master.glapdocdt,'aglt310') RETURNING l_success,g_glap.glapdocno
   IF l_success = FALSE THEN
      LET g_success = 'N'    
      RETURN       
   END IF 
   
   IF g_glal.glal001 = '1' THEN 
      LET g_glap.glap007 = 'FC'
   END IF 
   
   IF g_glal.glal001 = '2' THEN 
      LET g_glap.glap007 = 'FP'
   END IF
   
   IF g_glal.glal001 = '3' THEN 
      LET g_glap.glap007 = 'VP'
   END IF
   
   LET g_glap.glapent = g_enterprise
   LET g_glap.glapld = g_master.glalld
   LET g_glap.glapcomp = g_glaacomp 
   LET g_glap.glapdocdt = g_master.glapdocdt
   LET g_glap.glap001 = '1'
   LET g_glap.glap002 = g_master.glap002
   LET g_glap.glap004 = g_master.glap004
   LET g_glap.glap012 = 0 #160824-00023#1 打印次数
   LET g_glap.glap013 = 0
   LET g_glap.glap014 = 'N'
   LET g_glap.glapstus = 'N'
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapownid = g_user
   LET g_glap.glapowndp = g_dept
   LET g_glap.glapcrtid = g_user
   LET g_glap.glapcrtdp = g_dept 
   LET g_glap.glapcrtdt = cl_get_current()
   LET g_glap.glapcnfid = ""
   LET g_glap.glapcnfdt = ""
   LET g_glap.glap015 = g_glal.glaldocno #170210-00041#1 add
   
   #161128-00061#1----modify------begin-----------        
   #INSERT INTO glap_t VALUES(g_glap.*)
   INSERT INTO glap_t (glapent,glapld,glapcomp,glapdocno,glapdocdt,glap001,glap002,glap003,glap004,
                       glap005,glap006,glap007,glap008,glap009,glap010,glap011,glap012,glap013,glap014,
                       glap015,glap016,glap017,glapownid,glapowndp,glapcrtid,glapcrtdp,glapcrtdt,glapmodid,
                       glapmoddt,glapcnfid,glapcnfdt,glappstid,glappstdt,glapstus)
    VALUES(g_glap.glapent,g_glap.glapld,g_glap.glapcomp,g_glap.glapdocno,g_glap.glapdocdt,g_glap.glap001,g_glap.glap002,g_glap.glap003,g_glap.glap004,
           g_glap.glap005,g_glap.glap006,g_glap.glap007,g_glap.glap008,g_glap.glap009,g_glap.glap010,g_glap.glap011,g_glap.glap012,g_glap.glap013,g_glap.glap014,
           g_glap.glap015,g_glap.glap016,g_glap.glap017,g_glap.glapownid,g_glap.glapowndp,g_glap.glapcrtid,g_glap.glapcrtdp,g_glap.glapcrtdt,g_glap.glapmodid,
           g_glap.glapmoddt,g_glap.glapcnfid,g_glap.glapcnfdt,g_glap.glappstid,g_glap.glappstdt,g_glap.glapstus)
   #161128-00061#1----modify------end-----------
       
   IF SQLCA.SQLCODE THEN
#      CALL cl_errmsg('INSERT glap_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'INSERT glap_t'
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
   END IF
   
   #傳票憑證單身
   #161128-00061#1----modify------begin-----------
    #LET g_sql = " SELECT * FROM glam_t ",
     LET g_sql = " SELECT glament,glamld,glamcomp,glamdocno,glamseq,glam001,glam002,glam003,glam004,glam005,",
                 "glam006,glam007,glam008,glam009,glam010,glam011,glam012,glam013,glam014,glam015,glam016,",
                 "glam017,glam018,glam019,glam020,glam021,glam022,glam023,glam024,glam025,glam026,glam027,",
                 "glam028,glam029,glam030,glam031,glam032,glam033,glam034,glam035,glam036,glam037,glam038,",
                 "glam039,glam040,glam041,glam042,glam043,glam044,glam045,glam046,glam047,glam048,glam051,",
                 "glam052,glam053,glam054,glam055,glam056,glam057,glam058,glam059 FROM glam_t ",
    #161128-00061#1----modify------end-----------
               " WHERE glament = '",g_enterprise,"'",
               "   AND glamld = '",g_glal.glalld,"'",
               "   AND glamdocno = '",g_glal.glaldocno,"'"
   PREPARE aglp550_pre_1 FROM g_sql
   DECLARE aglp550_cs_1 CURSOR FOR  aglp550_pre_1
   
   #固定金额
   IF g_glal.glal001 = '1' THEN 
      CALL aglp550_fc()
   END IF 
   
   #固定比率
   IF g_glal.glal001 = '2' THEN 
      CALL aglp550_fp()
   END IF 
   
   #变动比率
   IF g_glal.glal001 = '3' THEN 
      CALL aglp550_vp()
   END IF
   
   #更新單頭金額
   SELECT SUM(glaq003),SUM(glaq004) INTO g_glap.glap010,g_glap.glap011 FROM glaq_t 
    WHERE glaqent = g_enterprise
      AND glaqld = g_glap.glapld
      AND glaqdocno = g_glap.glapdocno
   UPDATE glap_t SET glap010 = g_glap.glap010,
                     glap011 = g_glap.glap011
    WHERE glapent = g_enterprise
      AND glapld = g_glap.glapld
      AND glapdocno = g_glap.glapdocno
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'UPD glap_t'
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
   END IF     
   
   UPDATE glal_t SET glal007 = g_master.glapdocdt
    WHERE glalent = g_enterprise
      AND glalld = g_glal.glalld
      AND glaldocno = g_glal.glaldocno
     
   IF SQLCA.SQLCODE THEN
#      CALL cl_errmsg('UPD glal_t',g_glal.glaldocno,'',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'UPD glal_t'
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 固定金额(传票凭证来源类型:FC)
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
PRIVATE FUNCTION aglp550_fc()
DEFINE l_success        LIKE type_t.num5  #160919-00014#1 add
   
   INITIALIZE g_glam.* TO NULL 
   
   FOREACH aglp550_cs_1 INTO g_glam.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_glaq.glaqent = g_glam.glament
      LET g_glaq.glaqcomp = g_glam.glamcomp
      LET g_glaq.glaqld = g_glam.glamld
      LET g_glaq.glaqdocno = g_glap.glapdocno
      LET g_glaq.glaqseq = g_glam.glamseq
      LET g_glaq.glaq001 = g_glam.glam001
      LET g_glaq.glaq002 = g_glam.glam002
      LET g_glaq.glaq003 = g_glam.glam003
      LET g_glaq.glaq004 = g_glam.glam004
      LET g_glaq.glaq005 = g_glaa001
      LET g_glaq.glaq006 = 1
      LET g_glaq.glaq017 = g_glam.glam007 
      LET g_glaq.glaq018 = g_glam.glam008
      LET g_glaq.glaq019 = g_glam.glam009
      LET g_glaq.glaq020 = g_glam.glam010
      LET g_glaq.glaq021 = g_glam.glam011
      LET g_glaq.glaq022 = g_glam.glam012
      LET g_glaq.glaq023 = g_glam.glam013
      LET g_glaq.glaq024 = g_glam.glam014
      LET g_glaq.glaq025 = g_glam.glam015
#      LET g_glaq.glaq026 = g_glam.glam016
      LET g_glaq.glaq027 = g_glam.glam017
      LET g_glaq.glaq028 = g_glam.glam018
      LET g_glaq.glaq051 = g_glam.glam051
      LET g_glaq.glaq052 = g_glam.glam052
      LET g_glaq.glaq053 = g_glam.glam053
      CALL aglp550_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)
      
      IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003=0 END IF
      IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004=0 END IF
      #160919-00014#1--add--str--
      #按照币别取位
      CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq003,2) RETURNING l_success,g_errno,g_glaq.glaq003
      CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq004,2) RETURNING l_success,g_errno,g_glaq.glaq004
      #160919-00014#1--add--end
      IF g_glaq.glaq003<>0 THEN 
         LET g_glaq.glaq010 = g_glaq.glaq003
      END IF 
      IF g_glaq.glaq004<>0 THEN 
         LET g_glaq.glaq010 = g_glaq.glaq004
      END IF
      
      IF g_glaa015 = 'Y' THEN 
         LET g_glaq.glaq039 = g_glam.glam043
         LET g_glaq.glaq040 = g_glam.glam044
         LET g_glaq.glaq041 = g_glam.glam045
         IF cl_null(g_glaq.glaq040) THEN LET g_glaq.glaq040=0 END IF
         IF cl_null(g_glaq.glaq041) THEN LET g_glaq.glaq041=0 END IF
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq040,2) RETURNING l_success,g_errno,g_glaq.glaq040
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq041,2) RETURNING l_success,g_errno,g_glaq.glaq041
      ELSE
         LET g_glaq.glaq039 = 0
         LET g_glaq.glaq040 = 0
         LET g_glaq.glaq041 = 0
         #160919-00014#1--add--end
      END IF
      IF g_glaa019 = 'Y' THEN
         LET g_glaq.glaq042 = g_glam.glam046
         LET g_glaq.glaq043 = g_glam.glam047
         LET g_glaq.glaq044 = g_glam.glam048
         IF cl_null(g_glaq.glaq043) THEN LET g_glaq.glaq043=0 END IF
         IF cl_null(g_glaq.glaq044) THEN LET g_glaq.glaq044=0 END IF
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq043,2) RETURNING l_success,g_errno,g_glaq.glaq043
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq044,2) RETURNING l_success,g_errno,g_glaq.glaq044
      ELSE
         LET g_glaq.glaq042 = 0
         LET g_glaq.glaq043 = 0
         LET g_glaq.glaq044 = 0
         #160919-00014#1--add--end
      END IF
      
      #161128-00061#1----modify------begin-----------
      #INSERT INTO glaq_t VALUES (g_glaq.*)
       INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                           glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                           glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                           glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                           glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                           glaq052,glaq053)
        VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                g_glaq.glaq052,g_glaq.glaq053)
      #161128-00061#1----modify------end-----------
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('INSERT glam_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INSERT glaq_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      
      #170103-00019#18--add--str--
      #插入细项立冲账资料
      LET l_success = TRUE
      CALL s_pre_voucher_insert_glax(g_glaq.*) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      #170103-00019#18--add--end
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 固定比率(传票凭证来源类型:FP)
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
PRIVATE FUNCTION aglp550_fp()
   DEFINE l_total1        LIKE type_t.num20_6
   DEFINE l_total2        LIKE type_t.num20_6
   DEFINE l_total3        LIKE type_t.num20_6
   DEFINE l_success       LIKE type_t.num5  #160919-00014#1 add
   #161208-00035#1--add--str--
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_tot1          LIKE glam_t.glam003
   DEFINE l_tot2          LIKE glam_t.glam003
   DEFINE l_tot3          LIKE glam_t.glam003
   #161208-00035#1--add--end
   
   INITIALIZE g_glam.* TO NULL 
   
   #金額來源科目的計算
   CALL aglp550_glan_amt() RETURNING l_total1,l_total2,l_total3 
   
   #傳票憑證單身
   FOREACH aglp550_cs_1 INTO g_glam.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #161208-00035#1--add--str--
      #判断单身科目+核算项是否存在于金额来源档glan_t中，
      #如果存在，金额=单身科目+核算项对应金额 * 单身设置的比率，如果不存在，走原有逻辑
      LET l_count = 0
      SELECT COUNT(1) INTO l_count FROM glan_t
       WHERE glanent=g_enterprise AND glanld=g_glam.glamld
         AND glandocno=g_glam.glamdocno AND glan001=g_glam.glam002
         AND glan003=g_glam.glam007 AND glan004=g_glam.glam008
         AND glan005=g_glam.glam009 AND glan006=g_glam.glam010
         AND glan007=g_glam.glam011 AND glan008=g_glam.glam012
         AND glan009=g_glam.glam013 AND glan010=g_glam.glam014
         AND glan011=g_glam.glam015 AND glan013=g_glam.glam017
         AND glan014=g_glam.glam018 AND glan051=g_glam.glam051
         AND glan052=g_glam.glam052 AND glan053=g_glam.glam053
      IF l_count > 0 THEN
         CALL aglp550_amt() RETURNING l_tot1,l_tot2,l_tot3
      END IF
      #161208-00035#1--add--end
      
      LET g_glaq.glaqent = g_glam.glament
      LET g_glaq.glaqcomp = g_glam.glamcomp
      LET g_glaq.glaqld = g_glam.glamld
      LET g_glaq.glaqdocno = g_glap.glapdocno
      LET g_glaq.glaqseq = g_glam.glamseq
      LET g_glaq.glaq001 = g_glam.glam001
      LET g_glaq.glaq002 = g_glam.glam002
      #161208-00035#1--add--str--
      IF l_count > 0 THEN
         LET g_glaq.glaq003 = g_glam.glam003 * l_tot1/100
         LET g_glaq.glaq004 = g_glam.glam004 * l_tot1/100
      ELSE
      #161208-00035#1--add--end
      LET g_glaq.glaq003 = g_glam.glam003 * l_total1/100 
      LET g_glaq.glaq004 = g_glam.glam004 * l_total1/100 
      END IF #161208-00035# add
      LET g_glaq.glaq005 = g_glaa001
      LET g_glaq.glaq006 = 1
      LET g_glaq.glaq017 = g_glam.glam007 
      LET g_glaq.glaq018 = g_glam.glam008
      LET g_glaq.glaq019 = g_glam.glam009
      LET g_glaq.glaq020 = g_glam.glam010
      LET g_glaq.glaq021 = g_glam.glam011
      LET g_glaq.glaq022 = g_glam.glam012
      LET g_glaq.glaq023 = g_glam.glam013
      LET g_glaq.glaq024 = g_glam.glam014
      LET g_glaq.glaq025 = g_glam.glam015
#      LET g_glaq.glaq026 = g_glam.glam016
      LET g_glaq.glaq027 = g_glam.glam017
      LET g_glaq.glaq028 = g_glam.glam018
      LET g_glaq.glaq051 = g_glam.glam051
      LET g_glaq.glaq052 = g_glam.glam052
      LET g_glaq.glaq053 = g_glam.glam053
      CALL aglp550_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)
      
      IF cl_null(g_glaq.glaq003) THEN LET g_glaq.glaq003=0 END IF
      IF cl_null(g_glaq.glaq004) THEN LET g_glaq.glaq004=0 END IF
      #160919-00014#1--add--str--
      #按照币别取位
      CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq003,2) RETURNING l_success,g_errno,g_glaq.glaq003
      CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq004,2) RETURNING l_success,g_errno,g_glaq.glaq004
      LET g_glaq.glaq010 = 0
      #160919-00014#1--add--end
      IF g_glaq.glaq003<>0 THEN 
         LET g_glaq.glaq010 = g_glaq.glaq003
      END IF 
      IF g_glam.glam004<>0 THEN 
         LET g_glaq.glaq010 = g_glaq.glaq004
      END IF
      
      #161208-00035#1--add--str--
      #当借贷方金额都为0时，不插入glaq_t
      IF g_glaq.glaq003 = 0 AND g_glaq.glaq004 = 0 THEN
         CONTINUE FOREACH
      END IF
      #161208-00035#1--add--end
      
      IF g_glaa015 = 'Y' THEN 
                                         #帳套;                 日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_glaa016,0,g_glaa018)
         RETURNING g_glaq.glaq039   
         #161208-00035#1--add--str--
         IF l_count > 0 THEN
            LET g_glaq.glaq040 = g_glam.glam003 * l_tot2/100
            LET g_glaq.glaq041 = g_glam.glam004 * l_tot2/100
         ELSE
         #161208-00035#1--add--end
         LET g_glaq.glaq040 = g_glam.glam003 * l_total2/100
         LET g_glaq.glaq041 = g_glam.glam004 * l_total2/100
         END IF #161208-00035#1 add
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq040,2) RETURNING l_success,g_errno,g_glaq.glaq040
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq041,2) RETURNING l_success,g_errno,g_glaq.glaq041
      ELSE
         LET g_glaq.glaq039 = 0
         LET g_glaq.glaq040 = 0
         LET g_glaq.glaq041 = 0
         #160919-00014#1--add--end
      END IF
      
      IF g_glaa019 = 'Y' THEN 
                                            #帳套;              日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_glaa020,0,g_glaa022)
         RETURNING g_glaq.glaq042 
         #161208-00035#1--add--str--
         IF l_count > 0 THEN
            LET g_glaq.glaq043 = g_glam.glam003 * l_tot3/100
            LET g_glaq.glaq044 = g_glam.glam004 * l_tot3/100
         ELSE
         #161208-00035#1--add--end
         LET g_glaq.glaq043 = g_glam.glam003 * l_total3/100
         LET g_glaq.glaq044 = g_glam.glam004 * l_total3/100
         END IF #161208-00035#1 add
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq043,2) RETURNING l_success,g_errno,g_glaq.glaq043
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq044,2) RETURNING l_success,g_errno,g_glaq.glaq044
      ELSE
         LET g_glaq.glaq042 = 0
         LET g_glaq.glaq043 = 0
         LET g_glaq.glaq044 = 0
         #160919-00014#1--add--end
      END IF
      
      #161128-00061#1----modify------begin-----------
      #INSERT INTO glaq_t VALUES (g_glaq.*)
       INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                           glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                           glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                           glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                           glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                           glaq052,glaq053)
        VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                g_glaq.glaq052,g_glaq.glaq053)
      #161128-00061#1----modify------end-----------
          
      IF SQLCA.SQLCODE THEN
#         CALL cl_errmsg('INSERT glam_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'INSERT glaq_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      
      #170103-00019#18--add--str--
      #插入细项立冲账资料
      LET l_success = TRUE
      CALL s_pre_voucher_insert_glax(g_glaq.*) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      #170103-00019#18--add--end
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 变动比率(传票凭证来源类型:VP)
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
PRIVATE FUNCTION aglp550_vp()
DEFINE l_total1         LIKE type_t.num20_6
   DEFINE l_total2         LIKE type_t.num20_6
   DEFINE l_total3         LIKE type_t.num20_6
   DEFINE l_tot1           LIKE type_t.num20_6
   DEFINE l_tot2           LIKE type_t.num20_6
   DEFINE l_tot3           LIKE type_t.num20_6
   DEFINE l_glar001        LIKE glar_t.glar001
   DEFINE l_glam005_amt    LIKE type_t.num20_6
   DEFINE l_glam006_amt    LIKE type_t.num20_6
   DEFINE l_glar_sum1      LIKE type_t.num20_6
   DEFINE l_glar_sum2      LIKE type_t.num20_6
   DEFINE l_glac007        LIKE glac_t.glac007
   DEFINE l_glac008        LIKE glac_t.glac007
   DEFINE l_ac             LIKE type_t.num5
   DEFINE l_glar_sum3      LIKE type_t.num20_6      #本位幣二借方
   DEFINE l_glar_sum4      LIKE type_t.num20_6      #本位幣二貸方
   DEFINE l_glar_sum5      LIKE type_t.num20_6      #本位幣三借方
   DEFINE l_glar_sum6      LIKE type_t.num20_6      #本位幣三貸方
   DEFINE l_glam044_amt    LIKE type_t.num20_6
   DEFINE l_glam045_amt    LIKE type_t.num20_6
   DEFINE l_glam047_amt    LIKE type_t.num20_6
   DEFINE l_glam048_amt    LIKE type_t.num20_6
   DEFINE l_success        LIKE type_t.num5  #160919-00014#1 add
   #161208-00035#1--add--str--
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_amt1          LIKE glam_t.glam003
   DEFINE l_amt2          LIKE glam_t.glam003
   DEFINE l_amt3          LIKE glam_t.glam003
   #161208-00035#1--add--end
   
   INITIALIZE g_glam.* TO NULL 
   
   #金額來源科目的計算
   CALL aglp550_glan_amt() RETURNING l_total1,l_total2,l_total3
   
   #變動分子科目總和
   CALL aglp550_glam_amt() RETURNING l_tot1,l_tot2,l_tot3
   #傳票憑證單身
   LET l_ac = 1
   LET l_glam005_amt = 0
   LET l_glam006_amt = 0
   FOREACH aglp550_cs_1 INTO g_glam.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #161208-00035#1--add--str--
      #判断单身科目+核算项是否存在于金额来源档glan_t中，
      #如果存在，金额=单身科目+核算项对应金额 * 单身设置的比率，如果不存在，走原有逻辑
      LET l_count = 0
      SELECT COUNT(1) INTO l_count FROM glan_t
       WHERE glanent=g_enterprise AND glanld=g_glam.glamld
         AND glandocno=g_glam.glamdocno AND glan001=g_glam.glam002
         AND glan003=g_glam.glam007 AND glan004=g_glam.glam008
         AND glan005=g_glam.glam009 AND glan006=g_glam.glam010
         AND glan007=g_glam.glam011 AND glan008=g_glam.glam012
         AND glan009=g_glam.glam013 AND glan010=g_glam.glam014
         AND glan011=g_glam.glam015 AND glan013=g_glam.glam017
         AND glan014=g_glam.glam018 AND glan051=g_glam.glam051
         AND glan052=g_glam.glam052 AND glan053=g_glam.glam053
      IF l_count > 0 THEN
         CALL aglp550_amt() RETURNING l_amt1,l_amt2,l_amt3
      END IF
      #161208-00035#1--add--end

      LET g_glaq.glaqent = g_glam.glament
      LET g_glaq.glaqcomp = g_glam.glamcomp
      LET g_glaq.glaqld = g_glam.glamld
      LET g_glaq.glaqdocno = g_glap.glapdocno
      LET g_glaq.glaqseq = g_glam.glamseq
      LET g_glaq.glaq001 = g_glam.glam001
      LET g_glaq.glaq002 = g_glam.glam002 
      LET g_glaq.glaq005 = g_glaa001
      LET g_glaq.glaq006 = 1
      LET g_glaq.glaq017 = g_glam.glam007 
      LET g_glaq.glaq018 = g_glam.glam008
      LET g_glaq.glaq019 = g_glam.glam009
      LET g_glaq.glaq020 = g_glam.glam010
      LET g_glaq.glaq021 = g_glam.glam011
      LET g_glaq.glaq022 = g_glam.glam012
      LET g_glaq.glaq023 = g_glam.glam013
      LET g_glaq.glaq024 = g_glam.glam014
      LET g_glaq.glaq025 = g_glam.glam015
#      LET g_glaq.glaq026 = g_glam.glam016
      LET g_glaq.glaq027 = g_glam.glam017
      LET g_glaq.glaq028 = g_glam.glam018
      LET g_glaq.glaq051 = g_glam.glam051
      LET g_glaq.glaq052 = g_glam.glam052
      LET g_glaq.glaq053 = g_glam.glam053
      CALL aglp550_fix_acc_open(g_glaq.glaqld,g_glaq.glaq002)

      IF NOT cl_null(g_glam.glam005) THEN 
         LET l_glar001 = g_glam.glam005
         SELECT glac007,glac008 INTO l_glac007,l_glac008
           FROM glac_t
          WHERE glacent = g_enterprise
            AND glac001 = g_glaa004
            AND glac002 = g_glam.glam005
            
         #160919-00014#1--add--str--
         LET l_glar_sum1 = 0
         LET l_glar_sum2 = 0
         LET l_glar_sum3 = 0
         LET l_glar_sum4 = 0
         LET l_glar_sum5 = 0
         LET l_glar_sum6 = 0
         #160919-00014#1--add--end
      
         #科目性質為資產類，#累計餘額由本年度期初(第０期)開始計算   
         IF l_glac007 = '1' THEN 
            #160919-00014#1--mod--str--
#            SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam005
#               AND glar002 = g_master.glan018
#               AND glar003 <= g_master.glan019
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) 
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam005
               AND glar002 = g_master.glan018
               AND glar003 <= g_master.glan019
               AND glar012 = g_glam.glam019    #营运据点
               AND glar013 = g_glam.glam020    #部门
               AND glar014 = g_glam.glam021   #利润/成本中心
               AND glar015 = g_glam.glam022    #区域
               AND glar016 = g_glam.glam023    #收付款客商
               AND glar017 = g_glam.glam024    #账款客商
               AND glar018 = g_glam.glam025    #客群
               AND glar019 = g_glam.glam026    #产品类别
               AND glar020 = g_glam.glam027    #人员
               AND glar022 = g_glam.glam029    #专案编号
               AND glar023 = g_glam.glam030    #WBS
               AND glar051 = g_glam.glam054    #经营方式
               AND glar052 = g_glam.glam055    #渠道
               AND glar053 = g_glam.glam056    #品牌
            #160919-00014#1--mod--end
            
            IF cl_null(l_glar_sum1) THEN 
               LET l_glar_sum1 = 0
            END IF 
            IF cl_null(l_glar_sum2) THEN 
               LET l_glar_sum2 = 0
            END IF  
            
            #------------本位幣二-------------
            IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum3) THEN 
                  LET l_glar_sum3 = 0
               END IF 
               IF cl_null(l_glar_sum4) THEN 
                  LET l_glar_sum4 = 0
               END IF
            END IF
            #---------------------------------
            
            #------------本位幣三-------------
            IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum5) THEN 
                  LET l_glar_sum5 = 0
               END IF 
               IF cl_null(l_glar_sum6) THEN 
                  LET l_glar_sum6 = 0
               END IF
            END IF
            #---------------------------------
         ELSE
            #160919-00014#1--mod--str--
#           SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#             FROM glar_t 
#            WHERE glarent = g_enterprise
#              AND glarld = g_master.glalld  
#              AND glar001 = g_glam.glam005
#              AND glar002 = g_master.glan018
#              AND glar003 = g_master.glan019
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) 
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam005
               AND glar002 = g_master.glan018
               AND glar003 = g_master.glan019 
               AND glar012 = g_glam.glam019    #营运据点
               AND glar013 = g_glam.glam020    #部门
               AND glar014 = g_glam.glam021   #利润/成本中心
               AND glar015 = g_glam.glam022    #区域
               AND glar016 = g_glam.glam023    #收付款客商
               AND glar017 = g_glam.glam024    #账款客商
               AND glar018 = g_glam.glam025    #客群
               AND glar019 = g_glam.glam026    #产品类别
               AND glar020 = g_glam.glam027    #人员
               AND glar022 = g_glam.glam029    #专案编号
               AND glar023 = g_glam.glam030    #WBS
               AND glar051 = g_glam.glam054    #经营方式
               AND glar052 = g_glam.glam055    #渠道
               AND glar053 = g_glam.glam056    #品牌
            #160919-00014#1--mod--end
            IF cl_null(l_glar_sum1) THEN 
               LET l_glar_sum1 = 0
            END IF 
            IF cl_null(l_glar_sum2) THEN 
               LET l_glar_sum2 = 0
            END IF 
            
            #------------本位幣二-------------
            IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 = g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum3) THEN 
                  LET l_glar_sum3 = 0
               END IF 
               IF cl_null(l_glar_sum4) THEN 
                  LET l_glar_sum4 = 0
               END IF
            END IF
            #---------------------------------
            
            #------------本位幣三-------------
            IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 = g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum5) THEN 
                  LET l_glar_sum5 = 0
               END IF 
               IF cl_null(l_glar_sum6) THEN 
                  LET l_glar_sum6 = 0
               END IF
            END IF
            #---------------------------------
         END IF
         
         IF l_glac008 = '1' THEN   #借余
            LET l_glam005_amt = l_glar_sum1 - l_glar_sum2
            LET l_glam044_amt = l_glar_sum3 - l_glar_sum4
            LET l_glam047_amt = l_glar_sum5 - l_glar_sum6
         ELSE                      #貸余
            LET l_glam005_amt = l_glar_sum2 - l_glar_sum1
            LET l_glam044_amt = l_glar_sum4 - l_glar_sum3
            LET l_glam047_amt = l_glar_sum6 - l_glar_sum5
         END IF
         
         #161208-00035#1--add--str--
         IF l_count > 0 THEN
            LET g_glaq.glaq003 = l_glam005_amt/l_tot1 * l_amt1
         ELSE
         #161208-00035#1--add--end
         LET g_glaq.glaq003 = l_glam005_amt/l_tot1 * l_total1
         END IF #161208-00035#1 add
         
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq003,2) 
         RETURNING l_success,g_errno,g_glaq.glaq003
         #160919-00014#1--add--end
         LET g_glaq.glaq004 = 0
         
         #161208-00035#1--add--str--
         #当借贷方金额都为0时，不插入glaq_t
         IF g_glaq.glaq003 = 0 AND g_glaq.glaq004 = 0 THEN
            CONTINUE FOREACH
         END IF
         #161208-00035#1--add--end
         
         IF g_glaa015 = 'Y' THEN
                                           #帳套;                  日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                      #目的幣別;          交易金額; 匯類類型
                                      g_glaa016,0,g_glaa018)
            RETURNING g_glaq.glaq039 
            #161208-00035#1--add--str--
            IF l_count > 0 THEN
               LET g_glaq.glaq040 = l_glam044_amt/l_tot2 * l_amt2
            ELSE
            #161208-00035#1--add--end
            LET g_glaq.glaq040 = l_glam044_amt/l_tot2 * l_total2
            END IF #161208-00035#1 add
            
            LET g_glaq.glaq041 = 0
            #160919-00014#1--add--str--
            #按照币别取位
            CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq040,2) 
            RETURNING l_success,g_errno,g_glaq.glaq040
         ELSE
            LET g_glaq.glaq039 = 0
            LET g_glaq.glaq040 = 0
            LET g_glaq.glaq041 = 0
            #160919-00014#1--add--end
         END IF
         
         IF g_glaa019 = 'Y' THEN 
                                                  #帳套;              日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                      #目的幣別;          交易金額; 匯類類型
                                      g_glaa020,0,g_glaa022)
            RETURNING g_glaq.glaq042 
            #161208-00035#1--add--str--
            IF l_count > 0 THEN
               LET g_glaq.glaq043 = l_glam047_amt/l_tot3 * l_amt3
            ELSE
            #161208-00035#1--add--end
            LET g_glaq.glaq043 = l_glam047_amt/l_tot3 * l_total3
            END IF #161208-00035#1 add
            
            LET g_glaq.glaq044 = 0
            #160919-00014#1--add--str--
            #按照币别取位
            CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq043,2) 
            RETURNING l_success,g_errno,g_glaq.glaq043
         ELSE
            LET g_glaq.glaq042 = 0
            LET g_glaq.glaq043 = 0
            LET g_glaq.glaq044 = 0
            #160919-00014#1--add--end
         END IF
         
         LET g_glaq.glaq010 = g_glaq.glaq003
         
        #161128-00061#1----modify------begin-----------
        #INSERT INTO glaq_t VALUES (g_glaq.*)
         INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                             glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                             glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                             glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                             glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                             glaq052,glaq053)
          VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                  g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                  g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                  g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                  g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                  g_glaq.glaq052,g_glaq.glaq053)
        #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('INSERT glam_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'INSERT glaq_t'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         
         #170103-00019#18--add--str--
         #插入细项立冲账资料
         LET l_success = TRUE
         CALL s_pre_voucher_insert_glax(g_glaq.*) RETURNING l_success
         IF l_success = FALSE THEN
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         #170103-00019#18--add--end
      END IF
      
      IF NOT cl_null(g_glam.glam006) THEN 
         SELECT glac007,glac008 INTO l_glac007,l_glac008
           FROM glac_t
          WHERE glacent = g_enterprise
            AND glac001 = g_glaa004
            AND glac002 = g_glam.glam006
         
         #160919-00014#1--add--str--
         LET l_glar_sum1 = 0
         LET l_glar_sum2 = 0
         LET l_glar_sum3 = 0
         LET l_glar_sum4 = 0
         LET l_glar_sum5 = 0
         LET l_glar_sum6 = 0
         #160919-00014#1--add--end
         
         IF l_glac007 = '1' THEN 
            #160919-00014#1--mod--str--
#            SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam006
#               AND glar002 = g_master.glan018
#               AND glar003 <= g_master.glan019
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam006
               AND glar002 = g_master.glan018
               AND glar003 <= g_master.glan019
               AND glar012 = g_glam.glam031    #营运据点
               AND glar013 = g_glam.glam032    #部门
               AND glar014 = g_glam.glam033   #利润/成本中心
               AND glar015 = g_glam.glam034    #区域
               AND glar016 = g_glam.glam035    #收付款客商
               AND glar017 = g_glam.glam036    #账款客商
               AND glar018 = g_glam.glam037    #客群
               AND glar019 = g_glam.glam038    #产品类别
               AND glar020 = g_glam.glam039    #人员
               AND glar022 = g_glam.glam041    #专案编号
               AND glar023 = g_glam.glam042    #WBS
               AND glar051 = g_glam.glam057    #经营方式
               AND glar052 = g_glam.glam058    #渠道
               AND glar053 = g_glam.glam059    #品牌
            #160919-00014#1--mod--end  
            IF cl_null(l_glar_sum1) THEN 
               LET l_glar_sum1 = 0
            END IF 
            IF cl_null(l_glar_sum2) THEN 
               LET l_glar_sum2 = 0
            END IF 
            
            #------------本位幣二-------------
            IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum3) THEN 
                  LET l_glar_sum3 = 0
               END IF 
               IF cl_null(l_glar_sum4) THEN 
                  LET l_glar_sum4 = 0
               END IF
            END IF
            #---------------------------------
            
            #------------本位幣三-------------
            IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum5) THEN 
                  LET l_glar_sum5 = 0
               END IF 
               IF cl_null(l_glar_sum6) THEN 
                  LET l_glar_sum6 = 0
               END IF
            END IF
            #---------------------------------
         ELSE
            #160919-00014#1--mod--str--
#            SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#             FROM glar_t 
#            WHERE glarent = g_enterprise
#              AND glarld = g_master.glalld  
#              AND glar001 = g_glam.glam006
#              AND glar002 = g_master.glan018
#              AND glar003 = g_master.glan019
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam006
               AND glar002 = g_master.glan018
               AND glar003 = g_master.glan019
               AND glar012 = g_glam.glam031    #营运据点
               AND glar013 = g_glam.glam032    #部门
               AND glar014 = g_glam.glam033   #利润/成本中心
               AND glar015 = g_glam.glam034    #区域
               AND glar016 = g_glam.glam035    #收付款客商
               AND glar017 = g_glam.glam036    #账款客商
               AND glar018 = g_glam.glam037    #客群
               AND glar019 = g_glam.glam038    #产品类别
               AND glar020 = g_glam.glam039    #人员
               AND glar022 = g_glam.glam041    #专案编号
               AND glar023 = g_glam.glam042    #WBS
               AND glar051 = g_glam.glam057    #经营方式
               AND glar052 = g_glam.glam058    #渠道
               AND glar053 = g_glam.glam059    #品牌
            #160919-00014#1--mod--end  
            IF cl_null(l_glar_sum1) THEN 
               LET l_glar_sum1 = 0
            END IF 
            IF cl_null(l_glar_sum2) THEN 
               LET l_glar_sum2 = 0
            END IF
            
            #------------本位幣二-------------
            IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 = g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum3) THEN 
                  LET l_glar_sum3 = 0
               END IF 
               IF cl_null(l_glar_sum4) THEN 
                  LET l_glar_sum4 = 0
               END IF
            END IF
            #---------------------------------
            
            #------------本位幣三-------------
            IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#               SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                 FROM glar_t 
#                WHERE glarent = g_enterprise
#                  AND glarld = g_master.glalld  
#                  AND glar001 = g_glam.glam005
#                  AND glar002 = g_master.glan018
#                  AND glar003 = g_master.glan019
#160919-00014#1--mark--end
               IF cl_null(l_glar_sum5) THEN 
                  LET l_glar_sum5 = 0
               END IF 
               IF cl_null(l_glar_sum6) THEN 
                  LET l_glar_sum6 = 0
               END IF
            END IF
            #---------------------------------
         END IF
         
         IF l_glac008 = '1' THEN   #借余
            LET l_glam006_amt = l_glar_sum1 - l_glar_sum2
            LET l_glam045_amt = l_glar_sum3 - l_glar_sum4
            LET l_glam048_amt = l_glar_sum5 - l_glar_sum6
         ELSE                      #貸余
            LET l_glam006_amt = l_glar_sum2 - l_glar_sum1
            LET l_glam045_amt = l_glar_sum4 - l_glar_sum3
            LET l_glam048_amt = l_glar_sum6 - l_glar_sum5
         END IF
         
         LET g_glaq.glaq003 = 0 
         #161208-00035#1--add--str--
         IF l_count > 0 THEN
            LET g_glaq.glaq004 = l_glam006_amt/l_tot1 * l_amt1
         ELSE
         #161208-00035#1--add--end
         LET g_glaq.glaq004 = l_glam006_amt/l_tot1 * l_total1
         END IF #161208-00035#1 add
         
         #160919-00014#1--add--str--
         #按照币别取位
         CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa001,g_glaq.glaq004,2) 
         RETURNING l_success,g_errno,g_glaq.glaq004
         #160919-00014#1--add--end
         
         #161208-00035#1--add--str--
         #当借贷方金额都为0时，不插入glaq_t
         IF g_glaq.glaq003 = 0 AND g_glaq.glaq004 = 0 THEN
            CONTINUE FOREACH
         END IF
         #161208-00035#1--add--end
         
         IF g_glaa015 = 'Y' THEN
                                           #帳套;                  日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                      #目的幣別;          交易金額; 匯類類型
                                      g_glaa016,0,g_glaa018)
            RETURNING g_glaq.glaq039   
            LET g_glaq.glaq040 = 0
            #161208-00035#1--add--str--
            IF l_count > 0 THEN
               LET g_glaq.glaq041 = l_glam045_amt/l_tot2 * l_amt2
            ELSE
            #161208-00035#1--add--end
            LET g_glaq.glaq041 = l_glam045_amt/l_tot2 * l_total2
            END IF #161208-00035#1 add
            
            #160919-00014#1--add--str--
            #按照币别取位
            CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa016,g_glaq.glaq041,2) 
            RETURNING l_success,g_errno,g_glaq.glaq041
         ELSE
            LET g_glaq.glaq039 = 0
            LET g_glaq.glaq040 = 0
            LET g_glaq.glaq041 = 0
            #160919-00014#1--add--end
         END IF
         
         IF g_glaa019 = 'Y' THEN 
                                                  #帳套;              日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_glam.glamld,g_master.glapdocdt,g_glaa001,
                                      #目的幣別;          交易金額; 匯類類型
                                      g_glaa020,0,g_glaa022)
            RETURNING g_glaq.glaq042     
            LET g_glaq.glaq043 = 0
            #161208-00035#1--add--str--
            IF l_count > 0 THEN
               LET g_glaq.glaq044 = l_glam048_amt/l_tot3 * l_amt3
            ELSE
            #161208-00035#1--add--end
            LET g_glaq.glaq044 = l_glam048_amt/l_tot3 * l_total3
            END IF #161208-00035#1 add
            #160919-00014#1--add--str--
            #按照币别取位
            CALL s_curr_round_ld('1',g_glaq.glaqld,g_glaa020,g_glaq.glaq044,2) 
            RETURNING l_success,g_errno,g_glaq.glaq044
         ELSE
            LET g_glaq.glaq042 = 0
            LET g_glaq.glaq043 = 0
            LET g_glaq.glaq044 = 0
            #160919-00014#1--add--end
         END IF
         
         LET g_glaq.glaq010 = g_glaq.glaq004
         
        #161128-00061#1----modify------begin-----------
        #INSERT INTO glaq_t VALUES (g_glaq.*)
         INSERT INTO glaq_t (glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,glaq005,
                             glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013,glaq014,glaq015,
                             glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,
                             glaq026,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                             glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq051,
                             glaq052,glaq053)
          VALUES (g_glaq.glaqent,g_glaq.glaqcomp,g_glaq.glaqld,g_glaq.glaqdocno,g_glaq.glaqseq,g_glaq.glaq001,g_glaq.glaq002,g_glaq.glaq003,g_glaq.glaq004,g_glaq.glaq005,
                  g_glaq.glaq006,g_glaq.glaq007,g_glaq.glaq008,g_glaq.glaq009,g_glaq.glaq010,g_glaq.glaq011,g_glaq.glaq012,g_glaq.glaq013,g_glaq.glaq014,g_glaq.glaq015,
                  g_glaq.glaq016,g_glaq.glaq017,g_glaq.glaq018,g_glaq.glaq019,g_glaq.glaq020,g_glaq.glaq021,g_glaq.glaq022,g_glaq.glaq023,g_glaq.glaq024,g_glaq.glaq025,
                  g_glaq.glaq026,g_glaq.glaq027,g_glaq.glaq028,g_glaq.glaq029,g_glaq.glaq030,g_glaq.glaq031,g_glaq.glaq032,g_glaq.glaq033,g_glaq.glaq034,g_glaq.glaq035,
                  g_glaq.glaq036,g_glaq.glaq037,g_glaq.glaq038,g_glaq.glaq039,g_glaq.glaq040,g_glaq.glaq041,g_glaq.glaq042,g_glaq.glaq043,g_glaq.glaq044,g_glaq.glaq051,
                  g_glaq.glaq052,g_glaq.glaq053)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
#            CALL cl_errmsg('INSERT glam_t',g_glap.glapdocno,'',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'INSERT glaq_t'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         
         #170103-00019#18--add--str--
         #插入细项立冲账资料
         LET l_success = TRUE
         CALL s_pre_voucher_insert_glax(g_glaq.*) RETURNING l_success
         IF l_success = FALSE THEN
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         #170103-00019#18--add--end
      END IF 
      
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 勾选 '同日已产生传票者重新产生',则产生前先删除原同日分摊传票后再产生
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
PRIVATE FUNCTION aglp550_glap_delete(p_glapld,p_glapdocdt,p_glap007)
   DEFINE p_glapld         LIKE glap_t.glapld
   DEFINE p_glapdocdt      LIKE glap_t.glapdocdt
   DEFINE p_glap007        LIKE glap_t.glap007
   DEFINE l_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_glapstus       LIKE glap_t.glapstus
   DEFINE l_scom0002       LIKE type_t.chr10       #170103-00019#18 add
   DEFINE l_success        LIKE type_t.num5        #170103-00019#18 add
   
   CALL cl_get_para(g_enterprise,g_glaacomp,'S-COM-0002') RETURNING l_scom0002 #170103-00019#18 add
   
   #当勾选‘同日已生成凭证者，重复产生’时，排除作废凭证，作废凭证不用删除，继续产生同日凭证
   LET g_sql = "SELECT glapdocno,glapstus ",
               "  FROM glap_t",
               " WHERE glapent = '",g_enterprise,"'",
               "   AND glapld = '",p_glapld,"'",
               "   AND glapdocdt = '",p_glapdocdt,"'",
               "   AND glap007 = '",p_glap007,"'",
               "   AND glapstus <> 'X' ",    #160920-00026#1 add 
               " ORDER BY glapdocno DESC"    #151222-00008#4 add
   PREPARE aglp550_pre_3 FROM g_sql
   DECLARE aglp550_cs_3 CURSOR FOR  aglp550_pre_3
   FOREACH aglp550_cs_3 INTO l_glapdocno,l_glapstus
      IF l_glapstus != 'N' THEN 
#         CALL cl_errmsg('',l_glapdocno,'','agl-00171',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_glapdocno
         LET g_errparam.code = 'agl-00171'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      #170103-00019#18--add--str--
      #更新相关的细项立冲账资料
      LET l_success = TRUE
      CALL s_pre_voucher_delete_glax(p_glapld,l_glapdocno,'',l_scom0002) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = 'N' 
      END IF
   
      IF l_scom0002 = 'Y' THEN
      #凭证作废处理
         UPDATE glap_t SET glapstus = 'X'
          WHERE glapent = g_enterprise
            AND glapld = p_glapld
            AND glapdocno = l_glapdocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'UPDATE glap_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      ELSE
      #170103-00019#18--add--end 
         #151222-00008#4--add--str--
         #删除凭证单头
         DELETE FROM glap_t
          WHERE glapent = g_enterprise
            AND glapld = p_glapld
            AND glapdocno = l_glapdocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "DEL glap_t"
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         #删除凭证单身
         DELETE FROM glaq_t
          WHERE glaqent = g_enterprise
            AND glaqld = p_glapld
            AND glaqdocno =l_glapdocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "DEL glaq_t"
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         #更新单据自动编号
         IF g_success = 'Y' THEN 
            LET g_prog="aglt310"
            IF NOT s_aooi200_fin_del_docno(p_glapld,l_glapdocno,p_glapdocdt) THEN
               LET g_success = 'N'
            END IF
            LET g_prog="aglp550"
         END IF
         #151222-00008#4--add--end
      END IF #170103-00019#18 add
   END FOREACH 
#151222-00008#4--mark--str--   
#   DELETE FROM glap_t
#    WHERE glapent = g_enterprise
#      AND glapld = p_glapld
#      AND glapdocdt = p_glapdocdt
#      AND glap007 = p_glap007
#      
#   IF SQLCA.SQLCODE THEN
##      CALL cl_errmsg('DEL date',p_glapld,'',SQLCA.SQLCODE,1)
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = "DEL glap_t"
#      LET g_errparam.code = SQLCA.SQLCODE
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET g_success = 'N' 
#   END IF
#   
#   
#   DELETE FROM glaq_t
#    WHERE glaqent = g_enterprise
#      AND glaqld = p_glapld
#      AND glaqdocno IN (select glapdocno FROM glap_t 
#                         WHERE glapent = g_enterprise
#                           AND glapld = p_glapld
#                           AND glapdocdt = p_glapdocdt
#                           AND glap007 = p_glap007)
#   
#   IF SQLCA.SQLCODE THEN
##      CALL cl_errmsg('DEL date',p_glapld,'',SQLCA.SQLCODE,1)
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = "DEL glaq_t"
#      LET g_errparam.code = SQLCA.SQLCODE
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET g_success = 'N' 
#   END IF
#151222-00008#4--mark--end
END FUNCTION

################################################################################
# Descriptions...: 金額來源科目的金額計算
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
PRIVATE FUNCTION aglp550_glan_amt()
   DEFINE l_glar001      LIKE glar_t.glar001
   DEFINE l_glar005      LIKE glar_t.glar005
   DEFINE l_glar006      LIKE glar_t.glar006
   DEFINE l_glar_sum1    LIKE type_t.num20_6      #借方
   DEFINE l_glar_sum2    LIKE type_t.num20_6      #貸方
   DEFINE l_year         LIKE type_t.num5
   DEFINE l_month        LIKE type_t.num5
   DEFINE l_total1       LIKE type_t.num20_6
   DEFINE l_total2       LIKE type_t.num20_6
   DEFINE l_total3       LIKE type_t.num20_6
   DEFINE l_sum1         LIKE type_t.num20_6
   DEFINE l_sum2         LIKE type_t.num20_6
   DEFINE l_sum3         LIKE type_t.num20_6
   DEFINE l_glac008      LIKE glac_t.glac008
   DEFINE l_glar_sum3    LIKE type_t.num20_6      #本位幣二借方
   DEFINE l_glar_sum4    LIKE type_t.num20_6      #本位幣二貸方
   DEFINE l_glar_sum5    LIKE type_t.num20_6      #本位幣三借方
   DEFINE l_glar_sum6    LIKE type_t.num20_6      #本位幣三貸方
   
   
   LET l_total1 = 0
   LET l_total2 = 0
   LET l_total3 = 0
   LET l_sum1 = 0
   LET l_sum2 = 0
   LET l_sum3 = 0
   #161128-00061#1----modify------begin-----------
   #LET g_sql = " SELECT * FROM glan_t ",
    LET g_sql = " SELECT glanent,glanownid,glanowndp,glancrtid,glancrtdp,glancrtdt,glanmodid,glanmoddt,",
                "glancnfid,glancnfdt,glanpstid,glanpstdt,glanstus,glanld,glandocno,glanseq,glan001,glan002,",
                "glan003,glan004,glan005,glan006,glan007,glan008,glan009,glan010,glan011,glan012,glan013,",
                "glan014,glan015,glan016,glan017,glan018,glan019,glan051,glan052,glan053 FROM glan_t ",
    #161128-00061#1----modify------end-----------
               " WHERE glanent = '",g_enterprise,"'",
               "   AND glanld = '",g_master.glalld,"'",
               "   AND glandocno = '",g_glal.glaldocno,"'"
   PREPARE aglp550_pre_2 FROM g_sql
   DECLARE aglp550_cs_2 CURSOR FOR  aglp550_pre_2
   FOREACH aglp550_cs_2 INTO g_glan.*     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF g_glan.glan017 = '1' THEN     #固定年期
         LET l_year = g_glan.glan018
         LET l_month = g_glan.glan019
      ELSE   #变动年期
         LET l_year = g_master.glan018
         LET l_month = g_master.glan019
      END IF
      
      SELECT glac008 INTO l_glac008 
        FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = g_glaa004
         AND glac002 = g_glan.glan001
         
     #160919-00014#1--add--str--
     LET l_glar_sum1 = 0
     LET l_glar_sum2 = 0
     LET l_glar_sum3 = 0
     LET l_glar_sum4 = 0
     LET l_glar_sum5 = 0
     LET l_glar_sum6 = 0
     #160919-00014#1--add--end
     
     IF g_glan.glan015 = '1' THEN  #實際科目餘額
        IF g_glan.glan016 = '1' THEN   #累計餘額由本年度期初(第０期)開始計算
           #160919-00014#1--mod--str--
#           SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#             FROM glar_t 
#            WHERE glarent = g_enterprise
#              AND glarld = g_master.glalld  
#              AND glar001 = g_glan.glan001
#              AND glar002 = l_year
#              AND glar003 <= l_month
           SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
             INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
             FROM glar_t 
            WHERE glarent = g_enterprise
              AND glarld = g_master.glalld  
              AND glar001 = g_glan.glan001
              AND glar002 = l_year
              AND glar003 <= l_month
              AND glar012 = g_glan.glan003    #营运据点
              AND glar013 = g_glan.glan004    #部门
              AND glar014 = g_glan.glan005    #利润/成本中心
              AND glar015 = g_glan.glan006    #区域
              AND glar016 = g_glan.glan007    #收付款客商
              AND glar017 = g_glan.glan008    #账款客商
              AND glar018 = g_glan.glan009    #客群
              AND glar019 = g_glan.glan010    #产品类别
              AND glar020 = g_glan.glan011    #人员
              AND glar022 = g_glan.glan013    #专案编号
              AND glar023 = g_glan.glan014    #WBS
              AND glar051 = g_glan.glan051    #经营方式
              AND glar052 = g_glan.glan052    #渠道
              AND glar053 = g_glan.glan053    #品牌
           #160919-00014#1--mod--end
           IF cl_null(l_glar_sum1) THEN 
              LET l_glar_sum1 = 0
           ELSE
              LET l_glar_sum1 = l_glar_sum1 * g_glan.glan002/100
           END IF 
           IF cl_null(l_glar_sum2) THEN 
              LET l_glar_sum2 = 0
           ELSE
              LET l_glar_sum2 = l_glar_sum2 * g_glan.glan002/100
           END IF

           #------------本位幣二-------------
           IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#              SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                FROM glar_t 
#               WHERE glarent = g_enterprise
#                 AND glarld = g_master.glalld  
#                 AND glar001 = g_glan.glan001
#                 AND glar002 = l_year
#                 AND glar003 <= l_month
#160919-00014#1--mark--end
              IF cl_null(l_glar_sum3) THEN 
                 LET l_glar_sum3 = 0
              ELSE
                 LET l_glar_sum3 = l_glar_sum3 * g_glan.glan002/100
              END IF 
              IF cl_null(l_glar_sum4) THEN 
                 LET l_glar_sum4 = 0
              ELSE
                 LET l_glar_sum4 = l_glar_sum4 * g_glan.glan002/100
              END IF
           END IF
           #---------------------------------
           
           #------------本位幣三-------------
           IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#              SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                FROM glar_t 
#               WHERE glarent = g_enterprise
#                 AND glarld = g_master.glalld  
#                 AND glar001 = g_glan.glan001
#                 AND glar002 = l_year
#                 AND glar003 <= l_month
#160919-00014#1--mark--end
              IF cl_null(l_glar_sum5) THEN 
                 LET l_glar_sum5 = 0
              ELSE
                 LET l_glar_sum5 = l_glar_sum5 * g_glan.glan002/100
              END IF 
              IF cl_null(l_glar_sum6) THEN 
                 LET l_glar_sum6 = 0
              ELSE
                 LET l_glar_sum6 = l_glar_sum6 * g_glan.glan002/100
              END IF
           END IF
           #---------------------------------
           
           
           IF l_glac008 = '1' THEN   #借余
              LET l_sum1 = l_glar_sum1 - l_glar_sum2
              LET l_sum2 = l_glar_sum3 - l_glar_sum4
              LET l_sum3 = l_glar_sum5 - l_glar_sum6
           ELSE                      #貸余
              LET l_sum1 = l_glar_sum2 - l_glar_sum1
              LET l_sum2 = l_glar_sum4 - l_glar_sum3
              LET l_sum3 = l_glar_sum6 - l_glar_sum5
           END IF 
        END IF
        
        IF g_glan.glan016 = '2' THEN  #本期異動
           #160919-00014#1--mod--str--
#           SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2 
#             FROM glar_t 
#            WHERE glarent = g_enterprise
#              AND glarld = g_master.glalld  
#              AND glar001 = g_glan.glan001
#              AND glar002 = l_year
#              AND glar003 = l_month
           SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2 
             FROM glar_t 
            WHERE glarent = g_enterprise
              AND glarld = g_master.glalld  
              AND glar001 = g_glan.glan001
              AND glar002 = l_year
              AND glar003 = l_month
              AND glar012 = g_glan.glan003    #营运据点
              AND glar013 = g_glan.glan004    #部门
              AND glar014 = g_glan.glan005    #利润/成本中心
              AND glar015 = g_glan.glan006    #区域
              AND glar016 = g_glan.glan007    #收付款客商
              AND glar017 = g_glan.glan008    #账款客商
              AND glar018 = g_glan.glan009    #客群
              AND glar019 = g_glan.glan010    #产品类别
              AND glar020 = g_glan.glan011    #人员
              AND glar022 = g_glan.glan013    #专案编号
              AND glar023 = g_glan.glan014    #WBS
              AND glar051 = g_glan.glan051    #经营方式
              AND glar052 = g_glan.glan052    #渠道
              AND glar053 = g_glan.glan053    #品牌
           #160919-00014#1--mod--end
           IF cl_null(l_glar_sum1) THEN 
              LET l_glar_sum1 = 0
           ELSE
              LET l_glar_sum1 = l_glar_sum1 * g_glan.glan002/100
           END IF 
           IF cl_null(l_glar_sum2) THEN 
              LET l_glar_sum2 = 0
           ELSE
              LET l_glar_sum2 = l_glar_sum2 * g_glan.glan002/100
           END IF
           
           #------------本位幣二-------------
           IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#              SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#                FROM glar_t 
#               WHERE glarent = g_enterprise
#                 AND glarld = g_master.glalld  
#                 AND glar001 = g_glan.glan001
#                 AND glar002 = l_year
#                 AND glar003 = l_month
#160919-00014#1--mark--end
              IF cl_null(l_glar_sum3) THEN 
                 LET l_glar_sum3 = 0
              ELSE
                 LET l_glar_sum3 = l_glar_sum3 * g_glan.glan002/100
              END IF 
              IF cl_null(l_glar_sum4) THEN 
                 LET l_glar_sum4 = 0
              ELSE
                 LET l_glar_sum4 = l_glar_sum4 * g_glan.glan002/100
              END IF
           END IF
           #---------------------------------
           
           #------------本位幣三-------------
           IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#              SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#                FROM glar_t 
#               WHERE glarent = g_enterprise
#                 AND glarld = g_master.glalld  
#                 AND glar001 = g_glan.glan001
#                 AND glar002 = l_year
#                 AND glar003 = l_month
#160919-00014#1--mark--end
              IF cl_null(l_glar_sum5) THEN 
                 LET l_glar_sum5 = 0
              ELSE
                 LET l_glar_sum5 = l_glar_sum5 * g_glan.glan002/100
              END IF 
              IF cl_null(l_glar_sum6) THEN 
                 LET l_glar_sum6 = 0
              ELSE
                 LET l_glar_sum6 = l_glar_sum6 * g_glan.glan002/100
              END IF
           END IF
           #---------------------------------
           
           IF l_glac008 = '1' THEN   #借余
              LET l_sum1 = l_glar_sum1 - l_glar_sum2
              LET l_sum2 = l_glar_sum3 - l_glar_sum4
              LET l_sum3 = l_glar_sum5 - l_glar_sum6
           ELSE                      #貸余
              LET l_sum1 = l_glar_sum2 - l_glar_sum1
              LET l_sum2 = l_glar_sum4 - l_glar_sum3
              LET l_sum3 = l_glar_sum6 - l_glar_sum5
           END IF 
        END IF
     END IF 
     
     IF g_glan.glan015 = '2' THEN   #科目预算文件
        #取值方式同A.唯抓取的档案来源改为全面预算模块.科目预算文件(由全面预算模块规格提供）
     END IF 
     
     #票面金額
     LET l_total1 = l_total1 + l_sum1
     LET l_total2 = l_total2 + l_sum2
     LET l_total3 = l_total3 + l_sum3
   END FOREACH 
   RETURN l_total1,l_total2,l_total3
END FUNCTION

################################################################################
# Descriptions...: 變動分子科目總和
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
PRIVATE FUNCTION aglp550_glam_amt()
   DEFINE l_glac007        LIKE glac_t.glac007
   DEFINE l_glac008        LIKE glac_t.glac008
   DEFINE l_glar_sum1      LIKE type_t.num20_6
   DEFINE l_glar_sum2      LIKE type_t.num20_6
   DEFINE l_glar001        LIKE glar_t.glar001
   DEFINE l_tot1           LIKE type_t.num20_6
   DEFINE l_tot2           LIKE type_t.num20_6
   DEFINE l_tot3           LIKE type_t.num20_6
   DEFINE l_glar_sum3      LIKE type_t.num20_6      #本位幣二借方
   DEFINE l_glar_sum4      LIKE type_t.num20_6      #本位幣二貸方
   DEFINE l_glar_sum5      LIKE type_t.num20_6      #本位幣三借方
   DEFINE l_glar_sum6      LIKE type_t.num20_6      #本位幣三貸方
   DEFINE l_sum1           LIKE type_t.num20_6
   DEFINE l_sum2           LIKE type_t.num20_6
   DEFINE l_sum3           LIKE type_t.num20_6
   

   INITIALIZE g_glam.* TO NULL 
   
   
   LET l_tot1 = 0
   LET l_tot2 = 0
   LET l_tot3 = 0
   LET l_sum1 = 0
   LET l_sum2 = 0
   LET l_sum3 = 0
   LET l_glar_sum1 = 0
   LET l_glar_sum2 = 0
   FOREACH aglp550_cs_1 INTO g_glam.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #借方变动比率分子科目对应金额汇总
      IF NOT cl_null(g_glam.glam005) THEN  #160919-00014#1 add
      SELECT glac007,glac008 INTO l_glac007,l_glac008
        FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = g_glaa004
         AND glac002 = g_glam.glam005
         
      #160919-00014#1--add--str--
      LET l_glar_sum1 = 0
      LET l_glar_sum2 = 0
      LET l_glar_sum3 = 0
      LET l_glar_sum4 = 0
      LET l_glar_sum5 = 0
      LET l_glar_sum6 = 0
      #160919-00014#1--add--end
     
      #科目性質為資產類，#累計餘額由本年度期初(第０期)開始計算   
      IF l_glac007 = '1' THEN 
         #160919-00014#1--mod--str--
#         SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#           FROM glar_t 
#          WHERE glarent = g_enterprise
#            AND glarld = g_master.glalld  
#            AND glar001 = g_glam.glam005
#            AND glar002 = g_master.glan018
#            AND glar003 <= g_master.glan019
         SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
           INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
           FROM glar_t 
          WHERE glarent = g_enterprise
            AND glarld = g_master.glalld  
            AND glar001 = g_glam.glam005
            AND glar002 = g_master.glan018
            AND glar003 <= g_master.glan019
            AND glar012 = g_glam.glam019    #营运据点
            AND glar013 = g_glam.glam020    #部门
            AND glar014 = g_glam.glam021   #利润/成本中心
            AND glar015 = g_glam.glam022    #区域
            AND glar016 = g_glam.glam023    #收付款客商
            AND glar017 = g_glam.glam024    #账款客商
            AND glar018 = g_glam.glam025    #客群
            AND glar019 = g_glam.glam026    #产品类别
            AND glar020 = g_glam.glam027    #人员
            AND glar022 = g_glam.glam029    #专案编号
            AND glar023 = g_glam.glam030    #WBS
            AND glar051 = g_glam.glam054    #经营方式
            AND glar052 = g_glam.glam055    #渠道
            AND glar053 = g_glam.glam056    #品牌
         #160919-00014#1--mod--end
         IF cl_null(l_glar_sum1) THEN 
            LET l_glar_sum1 = 0
         END IF 
         IF cl_null(l_glar_sum2) THEN 
            LET l_glar_sum2 = 0
         END IF
         
         #------------本位幣二-------------
         IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#            SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam005
#               AND glar002 = g_master.glan018
#               AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
            IF cl_null(l_glar_sum3) THEN 
               LET l_glar_sum3 = 0
            END IF 
            IF cl_null(l_glar_sum4) THEN 
               LET l_glar_sum4 = 0
            END IF
         END IF
         #---------------------------------
         
         #------------本位幣三-------------
         IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#            SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam005
#               AND glar002 = g_master.glan018
#               AND glar003 <= g_master.glan019
#160919-00014#1--mark--end
            IF cl_null(l_glar_sum5) THEN 
               LET l_glar_sum5 = 0
            END IF 
            IF cl_null(l_glar_sum6) THEN 
               LET l_glar_sum6 = 0
            END IF
         END IF
         #---------------------------------
         
         
         IF l_glac008 = '1' THEN   #借余
            LET l_sum1 = l_glar_sum1 - l_glar_sum2
            LET l_sum2 = l_glar_sum3 - l_glar_sum4
            LET l_sum3 = l_glar_sum5 - l_glar_sum6
         ELSE                      #貸余
            LET l_sum1 = l_glar_sum2 - l_glar_sum1
            LET l_sum2 = l_glar_sum4 - l_glar_sum3
            LET l_sum3 = l_glar_sum6 - l_glar_sum5
         END IF 
      ELSE
         #160919-00014#1--mod--str--
#         SELECT SUM(glar005),SUM(glar006) INTO l_glar_sum1,l_glar_sum2
#           FROM glar_t 
#          WHERE glarent = g_enterprise
#            AND glarld = g_master.glalld  
#            AND glar001 = g_glam.glam005
#            AND glar002 = g_master.glan018
#            AND glar003 = g_master.glan019
          SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
           INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
           FROM glar_t 
          WHERE glarent = g_enterprise
            AND glarld = g_master.glalld  
            AND glar001 = g_glam.glam005
            AND glar002 = g_master.glan018
            AND glar003 = g_master.glan019
            AND glar012 = g_glam.glam019    #营运据点
            AND glar013 = g_glam.glam020    #部门
            AND glar014 = g_glam.glam021   #利润/成本中心
            AND glar015 = g_glam.glam022    #区域
            AND glar016 = g_glam.glam023    #收付款客商
            AND glar017 = g_glam.glam024    #账款客商
            AND glar018 = g_glam.glam025    #客群
            AND glar019 = g_glam.glam026    #产品类别
            AND glar020 = g_glam.glam027    #人员
            AND glar022 = g_glam.glam029    #专案编号
            AND glar023 = g_glam.glam030    #WBS
            AND glar051 = g_glam.glam054    #经营方式
            AND glar052 = g_glam.glam055    #渠道
            AND glar053 = g_glam.glam056    #品牌
         #160919-00014#1--mod--end
         IF cl_null(l_glar_sum1) THEN 
            LET l_glar_sum1 = 0
         END IF 
         IF cl_null(l_glar_sum2) THEN 
            LET l_glar_sum2 = 0
         END IF
         
         #------------本位幣二-------------
         IF g_glaa015 = 'Y' THEN 
#160919-00014#1--mark--str--
#            SELECT SUM(glar034),SUM(glar035) INTO l_glar_sum3,l_glar_sum4
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam005
#               AND glar002 = g_master.glan018
#               AND glar003 = g_master.glan019
#160919-00014#1--mark--end
            IF cl_null(l_glar_sum3) THEN 
               LET l_glar_sum3 = 0
            END IF 
            IF cl_null(l_glar_sum4) THEN 
               LET l_glar_sum4 = 0
            END IF
         END IF
         #---------------------------------
         
         #------------本位幣三-------------
         IF g_glaa019 = 'Y' THEN 
#160919-00014#1--mark--str--
#            SELECT SUM(glar036),SUM(glar037) INTO l_glar_sum5,l_glar_sum6
#              FROM glar_t 
#             WHERE glarent = g_enterprise
#               AND glarld = g_master.glalld  
#               AND glar001 = g_glam.glam005
#               AND glar002 = g_master.glan018
#               AND glar003 = g_master.glan019
#160919-00014#1--mark--end
            IF cl_null(l_glar_sum5) THEN 
               LET l_glar_sum5 = 0
            END IF 
            IF cl_null(l_glar_sum6) THEN 
               LET l_glar_sum6 = 0
            END IF
         END IF
         #---------------------------------
         
         IF l_glac008 = '1' THEN   #借余
            LET l_sum1 = l_glar_sum1 - l_glar_sum2
            LET l_sum2 = l_glar_sum3 - l_glar_sum4
            LET l_sum3 = l_glar_sum5 - l_glar_sum6
         ELSE                      #貸余
            LET l_sum1 = l_glar_sum2 - l_glar_sum1
            LET l_sum2 = l_glar_sum4 - l_glar_sum3
            LET l_sum3 = l_glar_sum6 - l_glar_sum5
         END IF 
      END IF
      LET l_tot1 = l_tot1 + l_sum1 
      LET l_tot2 = l_tot2 + l_sum2 
      LET l_tot3 = l_tot3 + l_sum3 
      END IF #160919-00014#1 add
      
      #160919-00014#1--add--str--
      #贷方变动比率分子科目对应金额汇总
      IF NOT cl_null(g_glam.glam006) THEN
         SELECT glac007,glac008 INTO l_glac007,l_glac008
           FROM glac_t
          WHERE glacent = g_enterprise
            AND glac001 = g_glaa004
            AND glac002 = g_glam.glam006            
         LET l_glar_sum1 = 0
         LET l_glar_sum2 = 0
         LET l_glar_sum3 = 0
         LET l_glar_sum4 = 0
         LET l_glar_sum5 = 0
         LET l_glar_sum6 = 0 
         
         #科目性質為資產類，#累計餘額由本年度期初(第０期)開始計算   
         IF l_glac007 = '1' THEN 
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam006
               AND glar002 = g_master.glan018
               AND glar003 <= g_master.glan019
               AND glar012 = g_glam.glam031    #营运据点
               AND glar013 = g_glam.glam032    #部门
               AND glar014 = g_glam.glam033   #利润/成本中心
               AND glar015 = g_glam.glam034    #区域
               AND glar016 = g_glam.glam035    #收付款客商
               AND glar017 = g_glam.glam036    #账款客商
               AND glar018 = g_glam.glam037    #客群
               AND glar019 = g_glam.glam038    #产品类别
               AND glar020 = g_glam.glam039    #人员
               AND glar022 = g_glam.glam041    #专案编号
               AND glar023 = g_glam.glam042    #WBS
               AND glar051 = g_glam.glam057    #经营方式
               AND glar052 = g_glam.glam058    #渠道
               AND glar053 = g_glam.glam059    #品牌
            IF cl_null(l_glar_sum1) THEN LET l_glar_sum1 = 0 END IF 
            IF cl_null(l_glar_sum2) THEN LET l_glar_sum2 = 0 END IF
            IF cl_null(l_glar_sum3) THEN LET l_glar_sum3 = 0 END IF
            IF cl_null(l_glar_sum4) THEN LET l_glar_sum4 = 0 END IF
            IF cl_null(l_glar_sum5) THEN LET l_glar_sum5 = 0 END IF
            IF cl_null(l_glar_sum6) THEN LET l_glar_sum6 = 0 END IF
            IF l_glac008 = '1' THEN   #借余
               LET l_sum1 = l_glar_sum1 - l_glar_sum2
               LET l_sum2 = l_glar_sum3 - l_glar_sum4
               LET l_sum3 = l_glar_sum5 - l_glar_sum6
            ELSE                      #貸余
               LET l_sum1 = l_glar_sum2 - l_glar_sum1
               LET l_sum2 = l_glar_sum4 - l_glar_sum3
               LET l_sum3 = l_glar_sum6 - l_glar_sum5
            END IF 
         ELSE
            SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)
              INTO l_glar_sum1,l_glar_sum2,l_glar_sum3,l_glar_sum4,l_glar_sum5,l_glar_sum6
              FROM glar_t 
             WHERE glarent = g_enterprise
               AND glarld = g_master.glalld  
               AND glar001 = g_glam.glam006
               AND glar002 = g_master.glan018
               AND glar003 = g_master.glan019
               AND glar012 = g_glam.glam031    #营运据点
               AND glar013 = g_glam.glam032    #部门
               AND glar014 = g_glam.glam033   #利润/成本中心
               AND glar015 = g_glam.glam034    #区域
               AND glar016 = g_glam.glam035    #收付款客商
               AND glar017 = g_glam.glam036    #账款客商
               AND glar018 = g_glam.glam037    #客群
               AND glar019 = g_glam.glam038    #产品类别
               AND glar020 = g_glam.glam039    #人员
               AND glar022 = g_glam.glam041    #专案编号
               AND glar023 = g_glam.glam042    #WBS
               AND glar051 = g_glam.glam057    #经营方式
               AND glar052 = g_glam.glam058    #渠道
               AND glar053 = g_glam.glam059    #品牌
            IF cl_null(l_glar_sum1) THEN LET l_glar_sum1 = 0 END IF 
            IF cl_null(l_glar_sum2) THEN LET l_glar_sum2 = 0 END IF
            IF cl_null(l_glar_sum3) THEN LET l_glar_sum3 = 0 END IF
            IF cl_null(l_glar_sum4) THEN LET l_glar_sum4 = 0 END IF
            IF cl_null(l_glar_sum5) THEN LET l_glar_sum5 = 0 END IF
            IF cl_null(l_glar_sum6) THEN LET l_glar_sum6 = 0 END IF         
            IF l_glac008 = '1' THEN   #借余
               LET l_sum1 = l_glar_sum1 - l_glar_sum2
               LET l_sum2 = l_glar_sum3 - l_glar_sum4
               LET l_sum3 = l_glar_sum5 - l_glar_sum6
            ELSE                      #貸余
               LET l_sum1 = l_glar_sum2 - l_glar_sum1
               LET l_sum2 = l_glar_sum4 - l_glar_sum3
               LET l_sum3 = l_glar_sum6 - l_glar_sum5
            END IF 
         END IF
         LET l_tot1 = l_tot1 + l_sum1 
         LET l_tot2 = l_tot2 + l_sum2 
         LET l_tot3 = l_tot3 + l_sum3 
      END IF 
      #160919-00014#1--add--end
   END FOREACH 
   RETURN l_tot1,l_tot2,l_tot3
END FUNCTION

################################################################################
# Descriptions...: 設置未啟用的核算項為空格
# Memo...........:
# Usage..........: CALL aglp550_fix_acc_open(p_glaqld,p_glaq002)
# Input parameter: p_glaqld       帳套
#                : p_glaq002      科目編號
# Date & Author..: 2015/02/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp550_fix_acc_open(p_glaqld,p_glaq002)
   DEFINE p_glaqld        LIKE glaq_t.glaqld
   DEFINE p_glaq002       LIKE glaq_t.glaq002
   #科目核算项
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #自由核算项
   DEFINE l_glad017       LIKE glad_t.glad017     #自由核算项一
   DEFINE l_glad018       LIKE glad_t.glad018     #自由核算项二
   DEFINE l_glad019       LIKE glad_t.glad019     #自由核算项三
   DEFINE l_glad020       LIKE glad_t.glad020     #自由核算项四
   DEFINE l_glad021       LIKE glad_t.glad021     #自由核算项五
   DEFINE l_glad022       LIKE glad_t.glad022     #自由核算项六
   DEFINE l_glad023       LIKE glad_t.glad023     #自由核算项七
   DEFINE l_glad024       LIKE glad_t.glad024     #自由核算项八
   DEFINE l_glad025       LIKE glad_t.glad025     #自由核算项九
   DEFINE l_glad026       LIKE glad_t.glad026     #自由核算项十
   
   CALL s_voucher_fix_acc_open_chk(p_glaqld,p_glaq002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
   #自由核算项
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026
     INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld = p_glaqld
      AND glad001 = p_glaq002
   #營運據點
   IF cl_null(g_glaq.glaq017) THEN
      SELECT glaacomp INTO g_glaq.glaq017 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_glaqld
   END IF
   #該科目做部門管理
   IF l_glad007 <> 'Y' OR l_glad007 IS NULL THEN
      LET g_glaq.glaq018 = ' ' 
   ELSE
      IF cl_null(g_glaq.glaq018) THEN
         #依據登入用戶抓取所在部門
         SELECT ooag003 INTO g_glaq.glaq018 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_user
      END IF
   END IF 
   #該科目做利潤成本管理時
   IF l_glad008 <> 'Y' OR l_glad008 IS NULL THEN
      LET g_glaq.glaq019 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq019) THEN
         SELECT ooeg004 INTO g_glaq.glaq019 FROM ooeg_t 
          WHERE ooegent = g_enterprise 
            AND ooeg001 = (SELECT ooag003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user)
      END IF
   END IF 
   #該科目做區域管理時
   IF l_glad009 <> 'Y' OR l_glad009 IS NULL THEN
      LET g_glaq.glaq020 = ' '
   ELSE
      IF cl_null(g_glaq.glaq020) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'4') RETURNING g_glaq.glaq020
      END IF
   END IF 
   #該科目做客商管理
   IF l_glad010 <> 'Y' OR l_glad010 IS NULL THEN
      LET g_glaq.glaq021 = ' '
   ELSE
      IF cl_null(g_glaq.glaq021) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'5') RETURNING g_glaq.glaq021
      END IF
   END IF 
   #該科目做账款客商管理時
   IF l_glad027 <> 'Y' OR l_glad027 IS NULL THEN
      LET g_glaq.glaq022 = ' '
   ELSE
      IF cl_null(g_glaq.glaq022) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'6') RETURNING g_glaq.glaq022
      END IF
   END IF 
   #該科目做客群管理時
   IF l_glad011 <> 'Y' OR l_glad011 IS NULL THEN
      LET g_glaq.glaq023 = ' '     
   ELSE
      IF cl_null(g_glaq.glaq023) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'7') RETURNING g_glaq.glaq023
      END IF   
   END IF 
   #該科目做產品分類管理時，
   IF l_glad012 <> 'Y' OR l_glad012 IS NULL THEN
      LET g_glaq.glaq024 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq024) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'8') RETURNING g_glaq.glaq024
      END IF
   END IF 
   #該科目做经营方式管理時，
   IF l_glad031 <> 'Y' OR l_glad031 IS NULL THEN
      LET g_glaq.glaq051 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq051) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'9') RETURNING g_glaq.glaq051
      END IF
   END IF
   #該科目做渠道管理時，
   IF l_glad032 <> 'Y' OR l_glad032 IS NULL THEN
      LET g_glaq.glaq052 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq052) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'10') RETURNING g_glaq.glaq052
      END IF
   END IF
   #該科目做品牌管理時，
   IF l_glad033 <> 'Y' OR l_glad033 IS NULL THEN
      LET g_glaq.glaq053 = ' '    
   ELSE
      IF cl_null(g_glaq.glaq053) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'11') RETURNING g_glaq.glaq053
      END IF
   END IF
   #該科目做人員管理時，
   IF l_glad013 <> 'Y' OR l_glad013 IS NULL THEN
      LET g_glaq.glaq025 = ' '    
   ELSE
      LET g_glaq.glaq025 = g_user
   END IF 
   #該科目做專案管理時，
   IF l_glad015 <> 'Y' OR l_glad015 IS NULL THEN
      LET g_glaq.glaq027 = ' '     
   ELSE
      IF cl_null(g_glaq.glaq027) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'13') RETURNING g_glaq.glaq027
      END IF 
   END IF 
   #該科目做WBS管理時，
   IF l_glad016 <> 'Y' OR l_glad016 IS NULL THEN
      LET g_glaq.glaq028 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq028) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'14') RETURNING g_glaq.glaq028
      END IF
   END IF 
   #核算项一
   IF l_glad017 <> 'Y' OR l_glad017 IS NULL THEN
      LET g_glaq.glaq029 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq029) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'15') RETURNING g_glaq.glaq029
      END IF
   END IF 
   #核算项二
   IF l_glad018 <> 'Y' OR l_glad018 IS NULL THEN
      LET g_glaq.glaq030 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq030) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'16') RETURNING g_glaq.glaq030
      END IF
   END IF
   #核算项三
   IF l_glad019 <> 'Y' OR l_glad019 IS NULL THEN
      LET g_glaq.glaq031 = ' '  
   ELSE
      IF cl_null(g_glaq.glaq031) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'17') RETURNING g_glaq.glaq031
      END IF   
   END IF
   #核算项四
   IF l_glad020 <> 'Y' OR l_glad020 IS NULL THEN
      LET g_glaq.glaq032 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq032) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'18') RETURNING g_glaq.glaq032
      END IF
   END IF
   #核算项五
   IF l_glad021 <> 'Y' OR l_glad021 IS NULL THEN
      LET g_glaq.glaq033 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq033) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'19') RETURNING g_glaq.glaq033
      END IF
   END IF
   #核算项四六
   IF l_glad022 <> 'Y' OR l_glad022 IS NULL THEN
      LET g_glaq.glaq034 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq034) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'20') RETURNING g_glaq.glaq034
      END IF
   END IF
   #核算项七
   IF l_glad023 <> 'Y' OR l_glad023 IS NULL THEN
      LET g_glaq.glaq035 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq035) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'21') RETURNING g_glaq.glaq035
      END IF
   END IF
   #核算项八
   IF l_glad024 <> 'Y' OR l_glad024 IS NULL THEN
      LET g_glaq.glaq036 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq036) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'22') RETURNING g_glaq.glaq036
      END IF
   END IF
   #核算项九
   IF l_glad025 <> 'Y' OR l_glad025 IS NULL THEN
      LET g_glaq.glaq037 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq037) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'23') RETURNING g_glaq.glaq037
      END IF
   END IF
   #核算项十
   IF l_glad026 <> 'Y' OR l_glad026 IS NULL THEN
      LET g_glaq.glaq038 = ' '   
   ELSE
      IF cl_null(g_glaq.glaq038) THEN
         CALL s_voucher_get_fix_default_value(p_glaqld,p_glaq002,'24') RETURNING g_glaq.glaq038
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据单身科目+核算项抓取金额
# Memo...........: #161208-00035#1
# Usage..........: CALL aglp550_amt()
#                  RETURNING l_tot1,l_tot2,l_tot3
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/29 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp550_amt()
DEFINE l_tot1           LIKE glam_t.glam003
DEFINE l_tot2           LIKE glam_t.glam003
DEFINE l_tot3           LIKE glam_t.glam003
DEFINE l_glan015        LIKE glan_t.glan015
DEFINE l_glan016        LIKE glan_t.glan016
DEFINE l_glan017        LIKE glan_t.glan017
DEFINE l_glan018        LIKE glan_t.glan018
DEFINE l_glan019        LIKE glan_t.glan019
DEFINE l_year           LIKE type_t.num5
DEFINE l_month          LIKE type_t.num5
DEFINE l_glac008        LIKE glac_t.glac008

   LET l_tot1 = 0
   LET l_tot2 = 0
   LET l_tot3 = 0
   
   LET l_glan015 = ''
   LET l_glan016 = ''
   LET l_glan017 = ''
   LET l_glan018 = ''
   LET l_glan019 = ''
   SELECT glan015,glan016,glan017,glan018,glan019
     INTO l_glan015,l_glan016,l_glan017,l_glan018,l_glan019
     FROM glan_t
    WHERE glanent = g_enterprise
      AND glanld = g_master.glalld
      AND glandocno = g_glal.glaldocno
      AND glan001 = g_glam.glam002
      AND glan003 = g_glam.glam007 
      AND glan004 = g_glam.glam008
      AND glan005 = g_glam.glam009 
      AND glan006 = g_glam.glam010
      AND glan007 = g_glam.glam011 
      AND glan008 = g_glam.glam012
      AND glan009 = g_glam.glam013 
      AND glan010 = g_glam.glam014
      AND glan011 = g_glam.glam015 
      AND glan013 = g_glam.glam017
      AND glan014 = g_glam.glam018 
      AND glan051 = g_glam.glam051
      AND glan052 = g_glam.glam052 
      AND glan053 = g_glam.glam053 
   
   #年度、期别
   IF l_glan017 = '1' THEN     #固定年期
      LET l_year = l_glan018
      LET l_month = l_glan019
   ELSE   #变动年期
      LET l_year = g_master.glan018
      LET l_month = g_master.glan019
   END IF
   #余额型态
   SELECT glac008 INTO l_glac008 
     FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_glaa004
      AND glac002 = g_glam.glam002
         
   IF l_glan015 = '1' THEN  #實際科目餘額
      IF l_glan016 = '1' THEN   #累計餘額由本年度期初(第０期)開始計算
         SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037)
           INTO l_tot1,l_tot2,l_tot3
           FROM glar_t 
          WHERE glarent = g_enterprise
            AND glarld = g_master.glalld  
            AND glar001 = g_glam.glam002
            AND glar002 = l_year
            AND glar003 <= l_month
            AND glar012 = g_glam.glam007    #营运据点
            AND glar013 = g_glam.glam008    #部门
            AND glar014 = g_glam.glam009    #利润/成本中心
            AND glar015 = g_glam.glam010    #区域
            AND glar016 = g_glam.glam011    #收付款客商
            AND glar017 = g_glam.glam012    #账款客商
            AND glar018 = g_glam.glam013    #客群
            AND glar019 = g_glam.glam014    #产品类别
            AND glar020 = g_glam.glam015    #人员
            AND glar022 = g_glam.glam017    #专案编号
            AND glar023 = g_glam.glam018    #WBS
            AND glar051 = g_glam.glam051    #经营方式
            AND glar052 = g_glam.glam052    #渠道
            AND glar053 = g_glam.glam053    #品牌         
      END IF
        
      IF l_glan016 = '2' THEN  #本期異動
         SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037)
           INTO l_tot1,l_tot2,l_tot3
           FROM glar_t 
          WHERE glarent = g_enterprise
            AND glarld = g_master.glalld  
            AND glar001 = g_glam.glam002
            AND glar002 = l_year
            AND glar003 = l_month
            AND glar012 = g_glam.glam007    #营运据点
            AND glar013 = g_glam.glam008    #部门
            AND glar014 = g_glam.glam009    #利润/成本中心
            AND glar015 = g_glam.glam010    #区域
            AND glar016 = g_glam.glam011    #收付款客商
            AND glar017 = g_glam.glam012    #账款客商
            AND glar018 = g_glam.glam013    #客群
            AND glar019 = g_glam.glam014    #产品类别
            AND glar020 = g_glam.glam015    #人员
            AND glar022 = g_glam.glam017    #专案编号
            AND glar023 = g_glam.glam018    #WBS
            AND glar051 = g_glam.glam051    #经营方式
            AND glar052 = g_glam.glam052    #渠道
            AND glar053 = g_glam.glam053    #品牌         
      END IF
      
      IF cl_null(l_tot1) THEN LET l_tot1 = 0 END IF 
      IF cl_null(l_tot2) THEN LET l_tot2 = 0 END IF
      IF cl_null(l_tot3) THEN LET l_tot3 = 0 END IF   
         
      IF l_glac008 = '2' THEN   #貸余
         LET l_tot1 = l_tot1 * -1
         LET l_tot2 = l_tot2 * -1
         LET l_tot3 = l_tot3 * -1
      END IF 
   END IF
   
   IF l_glan015 = '2' THEN   #科目预算文件
      #取值方式同A.唯抓取的档案来源改为全面预算模块.科目预算文件(由全面预算模块规格提供）
   END IF 
   
   RETURN l_tot1,l_tot2,l_tot3
END FUNCTION

#end add-point
 
{</section>}
 
