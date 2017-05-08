#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2017-02-08 11:34:51), PR版次:0027(2017-02-23 16:33:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000166
#+ Filename...: aisp320
#+ Description: 出貨單批次發票開立作業
#+ Creator....: 03080(2015-06-03 15:16:40)
#+ Modifier...: 08729 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp320.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150624-00005#4   150629 By Jessy     處理排程相關程式
#150730-00006#1   150730 By albireo   帳務中心,帳套加入直接開程式時的預設值;稅務編號取值原則加上區域功能
#150803                  By albireo   清空帳務中心時  全欄位清空
#150904-00006#3   150907 By albireo   增加商用發票號碼邏輯
#150918-00001#7   150922 By albireo   1.有來源單時銷退發票類型改取aisi030新欄位 發票類型對應的折單類型;
#                                     2.出貨外銷抓對應的IV塞入isat
#                                     3.銷退外銷走xmdl單身發票號碼去產生isat
#150930-00010#1   150930 By albireo   回寫出貨發票號碼一律用isat最大號的發票號碼
#151012-00014#7   151014 By Jessy     帶入日/月平均匯率預設值，依aoos020(S-FIN-2009)設定
#151022-00017#2   151023 By Jessy     轉發票之匯率依畫面條件取得
#151021           151021 By albireo   isaf052 給定原單site(除內銷出貨)
#151123-00013#7   151127 By albireo   開窗邏輯增加出貨簽收流程
#151207-00018#2   151208 By albireo   出貨簽收邏輯變更
#151209-00019#2   151218 By albireo   由出貨單產生至 aist310時, isaf028統一編號,應該捉取aooi100的 ooef002
#151231-00010#3   160115 By albireo   增加交易對象控制組
#160120-00009#1   160130 By albireo   原兩條件(組織及簿號)都輸入才做控卡(因為必輸)  現在改成無輸入組織就進簿號提示先輸入組織並跳回組織
#160413-00034#1   160414 By albireo   160413-00033#1  問題相同;增加檢核加入作業別
#160318-00025#41  160425 By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160517-00005#1   160519 By albireo   針對使用回收號發票修改
#160601無單        160601 By albireo   kris:發票簿都不分作業都可取得
#160426-00013#3   160530 By Reanna    增加訂金發票流程
#160606無單       160606 By albireo   指定單號連續開發票時,問題修正
#160707-00023#1   160908 By Reanna    1.依據彙總條件拆單產生 2.版面調整 3.QBE增加條件
#160802-00007#1   160926 By 01727     一次性交易對象識別碼(pmaa004=2)功能應用
#161012-00026#2   161019 By albireo   匯率設定預設值改1.依原單
#161006-00005#33  161026 By Reanna    帳務中心(xrcasite)開窗改用q_ooef001_46()
#160712-00013#2   161108 By albireo   發票簿條件輸入營運據點後, 則需檢核該據點+ 發票類型是否存在於aisi090 
#                                     (isaqsite + isaq001),若不存在, 則警訊 "該據點不允許開立該類型發票,請檢查 "營運據點開立發票設定(aisi090) 
#161104-00024#10  161109 By 08171     程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#6   161110 By 08171     程式中INSERT時不可以用*的寫法，要一個一個欄位定義
#161118-00028#1   161118 By albireo   對象取全稱給到簡稱的修正
#161122-00020#1   161122 By Reanna    修正走內銷的出貨單沒有發票日期的bug
#161121-00028#1   161123 By albireo   銷退不共用發票簿不限制發票類型
#161125-00002#1   161212 By albireo   取消外銷出貨isat中會寫入invoice號碼邏輯,依發票類型於aisi090設定是否產生時就產發票號與內銷相同產生邏輯;
#                                     外銷出貨匯率先取IV的xmdo017若無IV則取出貨匯率xmdl024
#161208-00026#28  161217 By 08729     針對SELECT有星號的部分進行展開
#161229-00019#3   170109 By albireo   一次性交易對象識別碼應用:需帶入購買方資訊
#170113-00024#1   170113 By Reanna    延續170109-00005處:理假設建立一筆DSCTC據點的出貨單，從出貨單>整單操作>發票開立時，開啟的aisp320，
#                                     發票簿開窗無法選取DSCTP據點的發票簿，因此開單調整，改取得該帳套的法人底下的組織的發票簿據點
#170123-00001#1   170123 By Reanna    調整給予單頭發票類型值的方式
#170103-00009#1   170202 By 08729     發票類型=4.收據，發票簿條件的group要開啟(不隱藏)，但只開放發票號碼輸入
#170217-00004#1   170217 By Reanna    彙總選項增加:4.全部，只要是符合對帳單頭條件的資料彙總在同一張對帳單上(拆單原則不變)
#170218-00010#1   170223 By Reanna    1.aisp320進行匯總，其產生單身需串上QBE條件
#                                     2.依照aisi080設定紅字發票呈現方式，調整寫入金額正負值
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
   #150624-00005#4-----s
   l_xrcasite    LIKE type_t.chr10,
   l_xrcald      LIKE type_t.chr5,
   l_xrcacomp    LIKE type_t.chr10,
   l_xmdk015     LIKE type_t.chr2,
   l_curr_type   LIKE type_t.chr500,
   l_slip1       LIKE type_t.chr500,
   l_docdt       LIKE type_t.dat,
   l_toaistype   LIKE type_t.chr10,
   l_site        LIKE type_t.chr10,
   l_book        LIKE type_t.chr500,
   l_dat_memo    LIKE type_t.dat,
   l_isaf010     LIKE type_t.chr20,
   l_limit_memo  LIKE type_t.num20_6,
   l_isaf011     LIKE type_t.chr20,
   l_toaxrtype   LIKE type_t.chr100,
   l_slip2       LIKE type_t.chr500,
   l_slip3       LIKE type_t.chr500,   #160707-00023#1
   l_xrca063     LIKE type_t.chr20,
   l_xrca007     LIKE type_t.chr20,
   #150624-00005#4-----e
   #160707-00023#1 add ------
   l_xmdk042     LIKE type_t.chr1,
   l_group_type  LIKE type_t.chr1,
   l_chk1        LIKE type_t.chr1,
   l_chk2        LIKE type_t.chr1,
   #160707-00023#1 add end---
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_xrcasite LIKE type_t.chr10, 
   l_xrcasite_desc LIKE type_t.chr80, 
   l_xmdk042 LIKE type_t.chr10, 
   l_group_type LIKE type_t.chr500, 
   l_xrcacomp LIKE type_t.chr10, 
   l_xrcald LIKE type_t.chr5, 
   l_xrcald_desc LIKE type_t.chr80, 
   l_chk1 LIKE type_t.chr500, 
   l_chk2 LIKE type_t.chr500, 
   l_toaxrtype LIKE type_t.chr100, 
   l_xmdk015 LIKE type_t.chr2, 
   l_xmdk015_desc LIKE type_t.chr80, 
   l_curr_type LIKE type_t.chr500, 
   l_slip1 LIKE type_t.chr500, 
   l_slip1_desc LIKE type_t.chr80, 
   l_docdt LIKE type_t.dat, 
   l_toaistype LIKE type_t.chr10, 
   l_slip2 LIKE type_t.chr500, 
   l_slip2_desc LIKE type_t.chr80, 
   l_slip3 LIKE type_t.chr500, 
   l_slip3_desc LIKE type_t.chr80, 
   l_xrca007 LIKE type_t.chr10, 
   l_xrca007_desc LIKE type_t.chr80, 
   l_xrca063 LIKE type_t.chr20, 
   l_site LIKE type_t.chr10, 
   l_site_desc LIKE type_t.chr80, 
   l_book LIKE type_t.chr500, 
   l_dat_memo LIKE type_t.dat, 
   l_isaf010 LIKE type_t.chr20, 
   l_limit_memo LIKE type_t.num20_6, 
   l_isae007 LIKE type_t.chr20, 
   l_isaf011 LIKE type_t.chr20, 
   xmdkdocno LIKE type_t.chr20, 
   xmdk007 LIKE type_t.chr10, 
   xmdk009 LIKE type_t.chr10, 
   xmdkdocdt LIKE type_t.dat, 
   xmdk004 LIKE type_t.chr10, 
   xmdk003 LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaald   LIKE glaa_t.glaald
DEFINE g_ooef019  LIKE ooef_t.ooef019
DEFINE g_xmdk000  LIKE xmdk_t.xmdk000

DEFINE g_xmdk    RECORD
                 xmdk015   LIKE xmdk_t.xmdk015,
                 xmdk017   LIKE xmdk_t.xmdk017,
                 xmdksite  LIKE xmdk_t.xmdksite,
                 xmdk001   LIKE xmdk_t.xmdk001,
                 xmdk000   LIKE xmdk_t.xmdk000,
                 xmdk008   LIKE xmdk_t.xmdk008   #albireo 150826 add
                 END RECORD
DEFINE g_isao    RECORD
                 isao014   LIKE isao_t.isao014,
                 isao015   LIKE isao_t.isao015,
                 isao016   LIKE isao_t.isao016
                 END RECORD
#DEFINE g_isai    RECORD  LIKE isai_t.* #161104-00024#10 mark 
#DEFINE g_isaq    RECORD  LIKE isaq_t.* #161104-00024#10 mark
#DEFINE g_isac    RECORD  LIKE isac_t.* #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE g_isai RECORD  #稅區參數資料檔
       isaient LIKE isai_t.isaient, #企業編號
       isai001 LIKE isai_t.isai001, #交易稅區
       isai002 LIKE isai_t.isai002, #發票編碼方式
       isai003 LIKE isai_t.isai003, #紅字發票是否必須對應原始發票
       isai004 LIKE isai_t.isai004, #紅字發票呈現方式
       isai005 LIKE isai_t.isai005, #編碼長度
       isaiownid LIKE isai_t.isaiownid, #資料所有者
       isaiowndp LIKE isai_t.isaiowndp, #資料所屬部門
       isaicrtid LIKE isai_t.isaicrtid, #資料建立者
       isaicrtdp LIKE isai_t.isaicrtdp, #資料建立部門
       isaicrtdt LIKE isai_t.isaicrtdt, #資料創建日
       isaimodid LIKE isai_t.isaimodid, #資料修改者
       isaimoddt LIKE isai_t.isaimoddt, #最近修改日
       isai006 LIKE isai_t.isai006, #紅字發票與藍字發票共用發票簿
       isai007 LIKE isai_t.isai007, #出貨發票列印方式
       isaistus LIKE isai_t.isaistus, #狀態碼
       isai008 LIKE isai_t.isai008,  #稅區所屬國家
       #161208-00026#28-add(s)
       isaiud001 LIKE isai_t.isaiud001, #自定義欄位(文字)001
       isaiud002 LIKE isai_t.isaiud002, #自定義欄位(文字)002
       isaiud003 LIKE isai_t.isaiud003, #自定義欄位(文字)003
       isaiud004 LIKE isai_t.isaiud004, #自定義欄位(文字)004
       isaiud005 LIKE isai_t.isaiud005, #自定義欄位(文字)005
       isaiud006 LIKE isai_t.isaiud006, #自定義欄位(文字)006
       isaiud007 LIKE isai_t.isaiud007, #自定義欄位(文字)007
       isaiud008 LIKE isai_t.isaiud008, #自定義欄位(文字)008
       isaiud009 LIKE isai_t.isaiud009, #自定義欄位(文字)009
       isaiud010 LIKE isai_t.isaiud010, #自定義欄位(文字)010
       isaiud011 LIKE isai_t.isaiud011, #自定義欄位(數字)011
       isaiud012 LIKE isai_t.isaiud012, #自定義欄位(數字)012
       isaiud013 LIKE isai_t.isaiud013, #自定義欄位(數字)013
       isaiud014 LIKE isai_t.isaiud014, #自定義欄位(數字)014
       isaiud015 LIKE isai_t.isaiud015, #自定義欄位(數字)015
       isaiud016 LIKE isai_t.isaiud016, #自定義欄位(數字)016
       isaiud017 LIKE isai_t.isaiud017, #自定義欄位(數字)017
       isaiud018 LIKE isai_t.isaiud018, #自定義欄位(數字)018
       isaiud019 LIKE isai_t.isaiud019, #自定義欄位(數字)019
       isaiud020 LIKE isai_t.isaiud020, #自定義欄位(數字)020
       isaiud021 LIKE isai_t.isaiud021, #自定義欄位(日期時間)021
       isaiud022 LIKE isai_t.isaiud022, #自定義欄位(日期時間)022
       isaiud023 LIKE isai_t.isaiud023, #自定義欄位(日期時間)023
       isaiud024 LIKE isai_t.isaiud024, #自定義欄位(日期時間)024
       isaiud025 LIKE isai_t.isaiud025, #自定義欄位(日期時間)025
       isaiud026 LIKE isai_t.isaiud026, #自定義欄位(日期時間)026
       isaiud027 LIKE isai_t.isaiud027, #自定義欄位(日期時間)027
       isaiud028 LIKE isai_t.isaiud028, #自定義欄位(日期時間)028
       isaiud029 LIKE isai_t.isaiud029, #自定義欄位(日期時間)029
       isaiud030 LIKE isai_t.isaiud030  #自定義欄位(日期時間)030
       #161208-00026#28-add(e)
END RECORD
DEFINE g_isaq RECORD  #營運據點可用發票類型設定檔
       isaqent LIKE isaq_t.isaqent, #企業編號
       isaqsite LIKE isaq_t.isaqsite, #營運據點
       isaq001 LIKE isaq_t.isaq001, #發票類型
       isaq002 LIKE isaq_t.isaq002, #發票購入方式
       isaq003 LIKE isaq_t.isaq003, #發票回收否
       isaq004 LIKE isaq_t.isaq004, #套表樣版
       isaq005 LIKE isaq_t.isaq005, #發票取得時機點
       isaqstus LIKE isaq_t.isaqstus, #狀態碼
       #161208-00026#28-add(s)
       isaqud001 LIKE isaq_t.isaqud001, #自定義欄位(文字)001
       isaqud002 LIKE isaq_t.isaqud002, #自定義欄位(文字)002
       isaqud003 LIKE isaq_t.isaqud003, #自定義欄位(文字)003
       isaqud004 LIKE isaq_t.isaqud004, #自定義欄位(文字)004
       isaqud005 LIKE isaq_t.isaqud005, #自定義欄位(文字)005
       isaqud006 LIKE isaq_t.isaqud006, #自定義欄位(文字)006
       isaqud007 LIKE isaq_t.isaqud007, #自定義欄位(文字)007
       isaqud008 LIKE isaq_t.isaqud008, #自定義欄位(文字)008
       isaqud009 LIKE isaq_t.isaqud009, #自定義欄位(文字)009
       isaqud010 LIKE isaq_t.isaqud010, #自定義欄位(文字)010
       isaqud011 LIKE isaq_t.isaqud011, #自定義欄位(數字)011
       isaqud012 LIKE isaq_t.isaqud012, #自定義欄位(數字)012
       isaqud013 LIKE isaq_t.isaqud013, #自定義欄位(數字)013
       isaqud014 LIKE isaq_t.isaqud014, #自定義欄位(數字)014
       isaqud015 LIKE isaq_t.isaqud015, #自定義欄位(數字)015
       isaqud016 LIKE isaq_t.isaqud016, #自定義欄位(數字)016
       isaqud017 LIKE isaq_t.isaqud017, #自定義欄位(數字)017
       isaqud018 LIKE isaq_t.isaqud018, #自定義欄位(數字)018
       isaqud019 LIKE isaq_t.isaqud019, #自定義欄位(數字)019
       isaqud020 LIKE isaq_t.isaqud020, #自定義欄位(數字)020
       isaqud021 LIKE isaq_t.isaqud021, #自定義欄位(日期時間)021
       isaqud022 LIKE isaq_t.isaqud022, #自定義欄位(日期時間)022
       isaqud023 LIKE isaq_t.isaqud023, #自定義欄位(日期時間)023
       isaqud024 LIKE isaq_t.isaqud024, #自定義欄位(日期時間)024
       isaqud025 LIKE isaq_t.isaqud025, #自定義欄位(日期時間)025
       isaqud026 LIKE isaq_t.isaqud026, #自定義欄位(日期時間)026
       isaqud027 LIKE isaq_t.isaqud027, #自定義欄位(日期時間)027
       isaqud028 LIKE isaq_t.isaqud028, #自定義欄位(日期時間)028
       isaqud029 LIKE isaq_t.isaqud029, #自定義欄位(日期時間)029
       isaqud030 LIKE isaq_t.isaqud030  #自定義欄位(日期時間)030
       #161208-00026#28-add(e)
END RECORD
DEFINE g_isac RECORD  #發票類型維護
       isacent LIKE isac_t.isacent, #企業編號
       isacownid LIKE isac_t.isacownid, #資料所有者
       isacowndp LIKE isac_t.isacowndp, #資料所屬部門
       isaccrtid LIKE isac_t.isaccrtid, #資料建立者
       isaccrtdp LIKE isac_t.isaccrtdp, #資料建立部門
       isaccrtdt LIKE isac_t.isaccrtdt, #資料創建日
       isacmodid LIKE isac_t.isacmodid, #資料修改者
       isacmoddt LIKE isac_t.isacmoddt, #最近修改日
       isacstus LIKE isac_t.isacstus, #狀態碼
       isac001 LIKE isac_t.isac001, #交易稅區
       isac002 LIKE isac_t.isac002, #發票類型
       isac003 LIKE isac_t.isac003, #發票歸屬進銷項
       isac004 LIKE isac_t.isac004, #媒體申報格式
       isac005 LIKE isac_t.isac005, #計稅原則
       isac006 LIKE isac_t.isac006, #發票明細筆數
       isac007 LIKE isac_t.isac007, #容差額
       isac008 LIKE isac_t.isac008, #發票聯數
       isac009 LIKE isac_t.isac009, #對應折單類型
       isac010 LIKE isac_t.isac010, #允許多稅率否
       isac011 LIKE isac_t.isac011, #發票張數
       isac012 LIKE isac_t.isac012, #不同稅務編號可調撥否
       #161208-00026#28-add(s)
       isacud001 LIKE isac_t.isacud001, #自定義欄位(文字)001
       isacud002 LIKE isac_t.isacud002, #自定義欄位(文字)002
       isacud003 LIKE isac_t.isacud003, #自定義欄位(文字)003
       isacud004 LIKE isac_t.isacud004, #自定義欄位(文字)004
       isacud005 LIKE isac_t.isacud005, #自定義欄位(文字)005
       isacud006 LIKE isac_t.isacud006, #自定義欄位(文字)006
       isacud007 LIKE isac_t.isacud007, #自定義欄位(文字)007
       isacud008 LIKE isac_t.isacud008, #自定義欄位(文字)008
       isacud009 LIKE isac_t.isacud009, #自定義欄位(文字)009
       isacud010 LIKE isac_t.isacud010, #自定義欄位(文字)010
       isacud011 LIKE isac_t.isacud011, #自定義欄位(數字)011
       isacud012 LIKE isac_t.isacud012, #自定義欄位(數字)012
       isacud013 LIKE isac_t.isacud013, #自定義欄位(數字)013
       isacud014 LIKE isac_t.isacud014, #自定義欄位(數字)014
       isacud015 LIKE isac_t.isacud015, #自定義欄位(數字)015
       isacud016 LIKE isac_t.isacud016, #自定義欄位(數字)016
       isacud017 LIKE isac_t.isacud017, #自定義欄位(數字)017
       isacud018 LIKE isac_t.isacud018, #自定義欄位(數字)018
       isacud019 LIKE isac_t.isacud019, #自定義欄位(數字)019
       isacud020 LIKE isac_t.isacud020, #自定義欄位(數字)020
       isacud021 LIKE isac_t.isacud021, #自定義欄位(日期時間)021
       isacud022 LIKE isac_t.isacud022, #自定義欄位(日期時間)022
       isacud023 LIKE isac_t.isacud023, #自定義欄位(日期時間)023
       isacud024 LIKE isac_t.isacud024, #自定義欄位(日期時間)024
       isacud025 LIKE isac_t.isacud025, #自定義欄位(日期時間)025
       isacud026 LIKE isac_t.isacud026, #自定義欄位(日期時間)026
       isacud027 LIKE isac_t.isacud027, #自定義欄位(日期時間)027
       isacud028 LIKE isac_t.isacud028, #自定義欄位(日期時間)028
       isacud029 LIKE isac_t.isacud029, #自定義欄位(日期時間)029
       isacud030 LIKE isac_t.isacud030  #自定義欄位(日期時間)030
       #161208-00026#28-add(e)
END RECORD
#161104-00024#10 --e add
DEFINE g_master_o type_master
DEFINE g_wc_xrcasite         STRING                   #帳務組織條件
DEFINE g_wc_xrcald           STRING

#150918-00001#7-----s
DEFINE g_xmdkdocno           LIKE xmdk_t.xmdkdocno    #隨貨附發票時外部呼叫時的出貨單號
#150918-00001#7-----e
DEFINE g_sql_ctrl            STRING                   #160707-00023#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp320.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
      CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success
      CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success      
      #end add-point
      CALL aisp320_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp320 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp320_init()
 
      #進入選單 Menu (="N")
      CALL aisp320_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp320.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp320_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
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
   CALL cl_set_combo_scc('l_toaistype','9731')
   CALL cl_set_combo_scc('l_curr_type','9951')
   CALL cl_set_combo_scc('l_toaxrtype','9960')
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success
   CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
   
   #160707-00023#1 -s
   CALL cl_set_combo_scc('l_xmdk042','2085')                   #內外銷
  #CALL cl_set_combo_scc_part('l_group_type','8327','0,2,3')   #彙總條件 #170217-00004#1 mark
   CALL cl_set_combo_scc_part('l_group_type','8327','0,2,3,6') #彙總條件 #170217-00004#1
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #160707-00023#1 -e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp320_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_comp        LIKE ooef_t.ooef001
   DEFINE l_isae007     LIKE isae_t.isae007
   DEFINE l_isae008     LIKE isae_t.isae008
   DEFINE l_isae012     LIKE isae_t.isae012
   DEFINE l_prog        LIKE type_t.chr20
   DEFINE l_oofg_return DYNAMIC ARRAY OF RECORD
             oofg019       LIKE oofg_t.oofg019,   #field
             oofg020       LIKE oofg_t.oofg020    #value
                        END RECORD
   DEFINE l_count       LIKE type_t.num10
   DEFINE l_tran        RECORD
             wc            STRING
                        END RECORD
   DEFINE l_ctl_where   STRING                #151231-00010#3
   DEFINE l_isah002do   LIKE isah_t.isah002   #160517-00005#1
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aisp320_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_xrcasite,g_master.l_xmdk042,g_master.l_group_type,g_master.l_xrcacomp, 
             g_master.l_xrcald,g_master.l_chk1,g_master.l_chk2,g_master.l_toaxrtype,g_master.l_xmdk015, 
             g_master.l_curr_type,g_master.l_slip1,g_master.l_docdt,g_master.l_toaistype,g_master.l_slip2, 
             g_master.l_slip3,g_master.l_xrca007,g_master.l_xrca063,g_master.l_site,g_master.l_book, 
             g_master.l_dat_memo,g_master.l_isaf010,g_master.l_limit_memo,g_master.l_isae007,g_master.l_isaf011  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcasite
            
            #add-point:AFTER FIELD l_xrcasite name="input.a.l_xrcasite"

            #albireo 150713-----s
            IF NOT cl_null(g_master.l_xrcasite)THEN
               IF (g_master.l_xrcasite <> g_master_o.l_xrcasite) OR (g_master_o.l_xrcasite IS NULL) THEN
                  CALL s_fin_account_center_sons_query('3',g_master.l_xrcasite,g_today,'1')          
                  CALL s_fin_account_center_with_ld_chk(g_master.l_xrcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_xrcasite = g_master_o.l_xrcasite
                     CALL s_desc_get_department_desc(g_master.l_xrcasite) RETURNING g_master.l_xrcasite_desc
                     DISPLAY BY NAME g_master.l_xrcasite,g_master.l_xrcasite_desc
                     NEXT FIELD l_xrcasite
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_master.l_xrcasite) RETURNING g_sub_success,g_errno,g_master.l_xrcacomp,g_master.l_xrcald
                  SELECT ooef019 INTO g_ooef019 FROM ooef_t
                   WHERE ooefent =g_enterprise
                     AND ooef001 = g_master.l_xrcacomp
                  
                  LET g_master.l_site = ''
                  LET g_master.l_book = ''
                  #albireo 150803-----s
                  LET g_master.l_site_desc = ''
                  DISPLAY BY NAME g_master.l_site_desc
                  LET g_master.l_slip1 = ''
                  LET g_master.l_slip1_desc = ''
                  LET g_master.l_slip2 = ''
                  LET g_master.l_slip2_desc = ''
                  LET g_master.l_xmdk015 = ''
                  LET g_master.l_xmdk015_desc = ''
                  DISPLAY BY NAME g_master.l_slip1,g_master.l_slip1_desc,
                                  g_master.l_slip2,g_master.l_slip2_desc,
                                  g_master.l_xmdk015,g_master.l_xmdk015_desc
                  DISPLAY '' TO xmdkdocno
                  #albireo 150803-----e
                  
                  DISPLAY BY NAME g_master.l_site,g_master.l_book
                  LET g_master.l_xrcald_desc = s_desc_get_ld_desc(g_master.l_xrcald)
                  LET g_master.l_xrcasite_desc = s_desc_get_department_desc(g_master.l_xrcasite)
                  DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcasite_desc
                  
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
                  CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
                  CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
                  
                  INITIALIZE g_isai.* TO NULL
                  #SELECT * INTO g_isai.* FROM isai_t  #161208-00026#28 mark
                  #161208-00026#28-add(s)
                  SELECT isaient,isai001,isai002,isai003,isai004,
                         isai005,isaiownid,isaiowndp,isaicrtid,isaicrtdp,
                         isaicrtdt,isaimodid,isaimoddt,isai006,isai007,
                         isaistus,isai008,isaiud001,isaiud002,isaiud003,
                         isaiud004,isaiud005,isaiud006,isaiud007,isaiud008,
                         isaiud009,isaiud010,isaiud011,isaiud012,isaiud013,
                         isaiud014,isaiud015,isaiud016,isaiud017,isaiud018,
                         isaiud019,isaiud020,isaiud021,isaiud022,isaiud023,
                         isaiud024,isaiud025,isaiud026,isaiud027,isaiud028,
                         isaiud029,isaiud030 
                    INTO g_isai.* 
                    FROM isai_t 
                  #161208-00026#28-add(e)
                   WHERE isaient = g_enterprise
                     AND isai001 = g_ooef019

                  #albireo 150817-----s
                  IF NOT cl_null(g_master.l_toaxrtype)THEN
                     INITIALIZE g_isao.* TO NULL
                     SELECT isao014,isao015,isao016 
                       INTO g_isao.*
                       FROM isao_t
                      WHERE isaoent = g_enterprise
                        AND isaosite = g_master.l_xrcasite 
                     IF g_master.l_toaxrtype = '2' THEN
                        #折讓
                        LET g_master.l_slip1 = g_isao.isao015
                     ELSE
                        #出貨
                        LET g_master.l_slip1 = g_isao.isao014
                     END IF
                     CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
                     DISPLAY BY NAME g_master.l_slip1,g_master.l_slip1_desc
                     
                  END IF
                  #albireo 150817-----e
               END IF
            END IF
            LET g_master_o.l_xrcasite = g_master.l_xrcasite
            CALL s_desc_get_department_desc(g_master.l_xrcasite) RETURNING g_master.l_xrcasite_desc
            DISPLAY BY NAME g_master.l_xrcasite_desc
            #albireo 150713-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcasite
            #add-point:BEFORE FIELD l_xrcasite name="input.b.l_xrcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcasite
            #add-point:ON CHANGE l_xrcasite name="input.g.l_xrcasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmdk042
            #add-point:BEFORE FIELD l_xmdk042 name="input.b.l_xmdk042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmdk042
            
            #add-point:AFTER FIELD l_xmdk042 name="input.a.l_xmdk042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmdk042
            #add-point:ON CHANGE l_xmdk042 name="input.g.l_xmdk042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_group_type
            #add-point:BEFORE FIELD l_group_type name="input.b.l_group_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_group_type
            
            #add-point:AFTER FIELD l_group_type name="input.a.l_group_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_group_type
            #add-point:ON CHANGE l_group_type name="input.g.l_group_type"
            #160707-00023#1 add ------
            CALL cl_set_comp_entry("l_slip2,l_slip3",TRUE)
            IF g_master.l_toaxrtype = '1' AND g_master.l_group_type = '0' THEN
               CALL cl_set_comp_entry("l_slip3",FALSE)
               LET g_master.l_slip3 = ''
               LET g_master.l_slip3_desc = ''
               DISPLAY BY NAME g_master.l_slip3,g_master.l_slip3_desc
            END IF
            IF g_master.l_toaxrtype = '2' THEN
               CALL cl_set_comp_entry("l_slip2",FALSE)
               LET g_master.l_slip2 = ''
               LET g_master.l_slip2_desc = ''
               DISPLAY BY NAME g_master.l_slip2,g_master.l_slip2_desc
            END IF
            #160707-00023#1 add end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcacomp
            #add-point:BEFORE FIELD l_xrcacomp name="input.b.l_xrcacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcacomp
            
            #add-point:AFTER FIELD l_xrcacomp name="input.a.l_xrcacomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcacomp
            #add-point:ON CHANGE l_xrcacomp name="input.g.l_xrcacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcald
            
            #add-point:AFTER FIELD l_xrcald name="input.a.l_xrcald"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcald
            #add-point:BEFORE FIELD l_xrcald name="input.b.l_xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcald
            #add-point:ON CHANGE l_xrcald name="input.g.l_xrcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk1
            #add-point:BEFORE FIELD l_chk1 name="input.b.l_chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk1
            
            #add-point:AFTER FIELD l_chk1 name="input.a.l_chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk1
            #add-point:ON CHANGE l_chk1 name="input.g.l_chk1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk2
            #add-point:BEFORE FIELD l_chk2 name="input.b.l_chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk2
            
            #add-point:AFTER FIELD l_chk2 name="input.a.l_chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk2
            #add-point:ON CHANGE l_chk2 name="input.g.l_chk2"
            #160707-00023#1 -s
            CALL cl_set_comp_visible('group_toaxr',TRUE)
            IF g_master.l_chk2 = 'N' THEN
               CALL cl_set_comp_visible('group_toaxr',FALSE)
            END IF
            #160707-00023#1 -s
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_toaxrtype
            #add-point:BEFORE FIELD l_toaxrtype name="input.b.l_toaxrtype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_toaxrtype
            
            #add-point:AFTER FIELD l_toaxrtype name="input.a.l_toaxrtype"
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_toaxrtype
            #add-point:ON CHANGE l_toaxrtype name="input.g.l_toaxrtype"
            #160707-00023#1 mark ------
            #LET g_master.l_slip2 = ''
            #LET g_master.l_slip2_desc = ''
            #DISPLAY BY NAME g_master.l_slip2,g_master.l_slip2_desc
            #160707-00023#1 mark end---
            #160707-00023#1 add ------
            CALL cl_set_comp_entry("l_slip2,l_slip3",TRUE)
            IF g_master.l_toaxrtype = '1' AND g_master.l_group_type = '0' THEN
               CALL cl_set_comp_entry("l_slip3",FALSE)
               LET g_master.l_slip3 = ''
               LET g_master.l_slip3_desc = ''
               DISPLAY BY NAME g_master.l_slip3,g_master.l_slip3_desc
            END IF
            IF g_master.l_toaxrtype = '2' THEN
               CALL cl_set_comp_entry("l_slip2",FALSE)
               LET g_master.l_slip2 = ''
               LET g_master.l_slip2_desc = ''
               DISPLAY BY NAME g_master.l_slip2,g_master.l_slip2_desc
            END IF
            #160707-00023#1 add end---
            #albireo 150817-----s
            IF NOT cl_null(g_master.l_toaxrtype)THEN
               INITIALIZE g_isao.* TO NULL
               SELECT isao014,isao015,isao016 
                 INTO g_isao.*
                 FROM isao_t
                WHERE isaoent = g_enterprise
                  AND isaosite = g_master.l_xrcasite 
               IF g_master.l_toaxrtype = '2' THEN
                  #折讓
                  LET g_master.l_slip1 = g_isao.isao015
               ELSE
                  #出貨
                  LET g_master.l_slip1 = g_isao.isao014
               END IF
               CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
               DISPLAY BY NAME g_master.l_slip1,g_master.l_slip1_desc
               
            END IF
            #albireo 150817-----e
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmdk015
            
            #add-point:AFTER FIELD l_xmdk015 name="input.a.l_xmdk015"
            LET g_master.l_xmdk015_desc = ''
            DISPLAY BY NAME g_master.l_xmdk015_desc
            IF NOT cl_null(g_master.l_xmdk015)THEN
               IF (g_master.l_xmdk015 <> g_master_o.l_xmdk015) OR (g_master_o.l_xmdk015 IS NULL) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_master.l_xmdk015
                  IF NOT cl_chk_exist("v_isac002_2") THEN
                     LET g_master.l_xmdk015 = g_xmdk.xmdk015
                     INITIALIZE g_isaq.* TO NULL
                     #SELECT * INTO g_isaq.* FROM isaq_t   #161208-00026#28 mark
                     #161208-00026#28-add(s)
                     SELECT isaqent,isaqsite,isaq001,isaq002,isaq003,
                            isaq004,isaq005,isaqstus,isaqud001,isaqud002,
                            isaqud003,isaqud004,isaqud005,isaqud006,isaqud007,
                            isaqud008,isaqud009,isaqud010,isaqud011,isaqud012,
                            isaqud013,isaqud014,isaqud015,isaqud016,isaqud017,
                            isaqud018,isaqud019,isaqud020,isaqud021,isaqud022,
                            isaqud023,isaqud024,isaqud025,isaqud026,isaqud027,
                            isaqud028,isaqud029,isaqud030 
                       INTO g_isaq.* 
                       FROM isaq_t
                     #161208-00026#28-add(e)
                      WHERE isaqent = g_enterprise
                       #AND isaqsite = g_master.l_site       #160707-00023#1 mark
                        AND isaqsite = g_master.l_xrcasite   #160707-00023#1
                        AND isaq001 = g_master.l_xmdk015
                     CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
                     DISPLAY BY NAME g_master.l_xmdk015_desc
                     CALL aisp320_visible()
                     NEXT FIELD l_xmdk015
                  END IF
               END IF
            END IF
            LET g_master_o.l_xmdk015 = g_master.l_xmdk015
            
            INITIALIZE g_isaq.* TO NULL
            #SELECT * INTO g_isaq.* FROM isaq_t      #161208-00026#28 mark
            #161208-00026#28-add(s)
            SELECT isaqent,isaqsite,isaq001,isaq002,isaq003,
                   isaq004,isaq005,isaqstus,isaqud001,isaqud002,
                   isaqud003,isaqud004,isaqud005,isaqud006,isaqud007,
                   isaqud008,isaqud009,isaqud010,isaqud011,isaqud012,
                   isaqud013,isaqud014,isaqud015,isaqud016,isaqud017,
                   isaqud018,isaqud019,isaqud020,isaqud021,isaqud022,
                   isaqud023,isaqud024,isaqud025,isaqud026,isaqud027,
                   isaqud028,isaqud029,isaqud030 
              INTO g_isaq.* 
              FROM isaq_t
            #161208-00026#28-add(e)
             WHERE isaqent = g_enterprise
              #AND isaqsite = g_master.l_site       #160707-00023#1 mark
               AND isaqsite = g_master.l_xrcasite   #160707-00023#1
               AND isaq001 = g_master.l_xmdk015
               
            INITIALIZE g_isac.* TO NULL
            #SELECT * INTO g_isac.*   #161208-00026#28 mark
            #161208-00026#28-add(s)
            SELECT isacent,isacownid,isacowndp,isaccrtid,isaccrtdp,
                   isaccrtdt,isacmodid,isacmoddt,isacstus,isac001,
                   isac002,isac003,isac004,isac005,isac006,
                   isac007,isac008,isac009,isac010,isac011,
                   isac012,isacud001,isacud002,isacud003,isacud004,
                   isacud005,isacud006,isacud007,isacud008,isacud009,
                   isacud010,isacud011,isacud012,isacud013,isacud014,
                   isacud015,isacud016,isacud017,isacud018,isacud019,
                   isacud020,isacud021,isacud022,isacud023,isacud024,
                   isacud025,isacud026,isacud027,isacud028,isacud029,
                   isacud030 
              INTO g_isac.*
            #161208-00026#28-add(e)
              FROM isac_t
             WHERE isacent = g_enterprise
               AND isac001 = g_ooef019
               AND isac002 = g_master.l_xmdk015
            CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
            DISPLAY BY NAME g_master.l_xmdk015_desc
            CALL aisp320_visible()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmdk015
            #add-point:BEFORE FIELD l_xmdk015 name="input.b.l_xmdk015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmdk015
            #add-point:ON CHANGE l_xmdk015 name="input.g.l_xmdk015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_curr_type
            #add-point:BEFORE FIELD l_curr_type name="input.b.l_curr_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_curr_type
            
            #add-point:AFTER FIELD l_curr_type name="input.a.l_curr_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_curr_type
            #add-point:ON CHANGE l_curr_type name="input.g.l_curr_type"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip1
            
            #add-point:AFTER FIELD l_slip1 name="input.a.l_slip1"
            IF NOT cl_null(g_master.l_slip1)THEN
               IF (g_master.l_slip1 <> g_master_o.l_slip1) OR (g_master_o.l_slip1 IS NULL) THEN
                  CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip1,'aist310') 
                     RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     NEXT FIELD l_slip1
                  END IF
               END IF
            END IF
            LET g_master_o.l_slip1 = g_master.l_slip1
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.l_slip1_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip1
            #add-point:BEFORE FIELD l_slip1 name="input.b.l_slip1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip1
            #add-point:ON CHANGE l_slip1 name="input.g.l_slip1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_docdt
            #add-point:BEFORE FIELD l_docdt name="input.b.l_docdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_docdt
            
            #add-point:AFTER FIELD l_docdt name="input.a.l_docdt"
            IF NOT cl_null(g_master.l_docdt)THEN
               IF (g_master.l_docdt <> g_master_o.l_docdt) OR (g_master_o.l_docdt IS NULL) THEN
                  CALL aisp320_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_docdt = NULL
                     DISPLAY BY NAME g_master.l_docdt
                     CALL cl_err()
                     NEXT FIELD l_docdt
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_docdt
            #add-point:ON CHANGE l_docdt name="input.g.l_docdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_toaistype
            #add-point:BEFORE FIELD l_toaistype name="input.b.l_toaistype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_toaistype
            
            #add-point:AFTER FIELD l_toaistype name="input.a.l_toaistype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_toaistype
            #add-point:ON CHANGE l_toaistype name="input.g.l_toaistype"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip2
            
            #add-point:AFTER FIELD l_slip2 name="input.a.l_slip2"
            IF NOT cl_null(g_master.l_slip2)THEN
               #160707-00023#1 mark ------
               #IF g_master.l_toaxrtype = '2' THEN
               #   LET l_prog = 'axrt340'
               #ELSE
               #   LET l_prog = 'axrt300'
               #END IF
               #CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip2,l_prog) 
               #   RETURNING g_sub_success
               #160707-00023#1 mark end---
               #160707-00023#1 -s
               CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip2,'axrt300') 
                  RETURNING g_sub_success
               #160707-00023#1 -e
               IF NOT g_sub_success THEN
                  NEXT FIELD l_slip2
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc
            DISPLAY BY NAME g_master.l_slip2_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip2
            #add-point:BEFORE FIELD l_slip2 name="input.b.l_slip2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip2
            #add-point:ON CHANGE l_slip2 name="input.g.l_slip2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip3
            
            #add-point:AFTER FIELD l_slip3 name="input.a.l_slip3"
            #160707-00023#1 -s
            IF NOT cl_null(g_master.l_slip3)THEN
               CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip3,'axrt340') 
                  RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  NEXT FIELD l_slip3
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip3) RETURNING g_master.l_slip3_desc
            DISPLAY BY NAME g_master.l_slip3_desc
            #160707-00023#1 -e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip3
            #add-point:BEFORE FIELD l_slip3 name="input.b.l_slip3"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip3
            #add-point:ON CHANGE l_slip3 name="input.g.l_slip3"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrca007
            
            #add-point:AFTER FIELD l_xrca007 name="input.a.l_xrca007"
            #albireo 150826-----s          
            IF NOT cl_null(g_master.l_xrca007)THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.l_xrca007
               #160318-00025#41  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
               #160318-00025#41  2016/04/25  by pengxin  add(E)
               IF NOT cl_chk_exist("v_oocq002_3111") THEN
                  LET g_master.l_xrca007 = g_master_o.l_xrca007 
                  CALL s_desc_get_acc_desc('3111',g_master.l_xrca007) RETURNING g_master.l_xrca007_desc
                  DISPLAY BY NAME g_master.l_xrca007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master_o.l_xrca007 = g_master.l_xrca007
            CALL s_desc_get_acc_desc('3111',g_master.l_xrca007) RETURNING g_master.l_xrca007_desc
            DISPLAY BY NAME g_master.l_xrca007_desc
            #albireo 150826-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrca007
            #add-point:BEFORE FIELD l_xrca007 name="input.b.l_xrca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrca007
            #add-point:ON CHANGE l_xrca007 name="input.g.l_xrca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrca063
            #add-point:BEFORE FIELD l_xrca063 name="input.b.l_xrca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrca063
            
            #add-point:AFTER FIELD l_xrca063 name="input.a.l_xrca063"
            IF NOT cl_null(g_master.l_xrca063)THEN
               IF NOT s_aooi390_chk('14',g_master.l_xrca063) THEN
                  LET g_master.l_xrca063 = g_master_o.l_xrca063
                  DISPLAY BY NAME g_master.l_xrca063
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master_o.l_xrca063 = g_master.l_xrca063
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrca063
            #add-point:ON CHANGE l_xrca063 name="input.g.l_xrca063"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_site
            
            #add-point:AFTER FIELD l_site name="input.a.l_site"
            LET g_master.l_site_desc = NULL
            DISPLAY BY NAME g_master.l_site_desc
            IF NOT cl_null(g_master.l_site)THEN
               #IF (g_master.l_site <> g_master_o.l_site) OR (g_master_o.l_site) THEN       #170113-00024#1 mark
               IF (g_master.l_site <> g_master_o.l_site) OR cl_null(g_master_o.l_site) THEN #170113-00024#1
                  CALL aisp320_ooef001_chk(g_master.l_site)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_site = NULL
                     DISPLAY BY NAME g_master.l_site
                     CALL cl_err()
                     NEXT FIELD l_site
                  END IF
                  
                  CALL aisp320_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_site = NULL
                     DISPLAY BY NAME g_master.l_site
                     CALL cl_err()
                     NEXT FIELD l_site
                  END IF
               END IF
            END IF

            LET g_master_o.l_site = g_master.l_site
            SELECT isae014,isae007,isae008,isae012
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012
               FROM isae_t
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai.isai002 = '1' THEN
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai.isai002 = '2' THEN
                LET g_master.l_isaf010 = l_isae008
             END IF
             
            LET g_master.l_isae007 = l_isae007     #160517-00005#1
            DISPLAY BY NAME g_master.l_isae007     #160517-00005#1
             
            LET g_master.l_isaf011 = l_isae012
            CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
            DISPLAY BY NAME g_master.l_site_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_site
            #add-point:BEFORE FIELD l_site name="input.b.l_site"
            #160120-00009-----s
            CALL aisp320_book_exist(g_master.l_docdt,g_master.l_xmdk015)
              RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_xmdk015
            END IF
            #160120-00009-----e
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_site
            #add-point:ON CHANGE l_site name="input.g.l_site"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_book
            #add-point:BEFORE FIELD l_book name="input.b.l_book"
            #160120-00009-----s
            IF cl_null(g_master.l_site) THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = 'ais-00283'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_site
            END IF
            
            
            CALL aisp320_book_exist(g_master.l_docdt,g_master.l_xmdk015)
              RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_xmdk015
            END IF
            #160120-00009-----e
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_book
            
            #add-point:AFTER FIELD l_book name="input.a.l_book"
            IF NOT cl_null(g_master.l_book)THEN
               CALL aisp320_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                 RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_master.l_book = NULL
                  DISPLAY BY NAME g_master.l_book
                  CALL cl_err()
                  NEXT FIELD l_book
               END IF
            END IF
            SELECT isae014,isae007,isae008,isae012,isae020
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012,g_master.l_limit_memo
               FROM isae_t           
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai.isai002 = '1' THEN 
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai.isai002 = '2' THEN 
                LET g_master.l_isaf010 = l_isae008
             END IF
             
             IF cl_null(g_master.l_limit_memo)THEN
                LET g_master.l_limit_memo = 0
             END IF
             
            LET g_master.l_isaf011 = l_isae012
            DISPLAY BY NAME g_master.l_isaf011,g_master.l_isaf010,g_master.l_limit_memo,
                            g_master.l_dat_memo
                            
            LET g_master.l_isae007 = l_isae007     #160517-00005#1
            DISPLAY BY NAME g_master.l_isae007     #160517-00005#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_book
            #add-point:ON CHANGE l_book name="input.g.l_book"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dat_memo
            #add-point:BEFORE FIELD l_dat_memo name="input.b.l_dat_memo"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dat_memo
            
            #add-point:AFTER FIELD l_dat_memo name="input.a.l_dat_memo"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_dat_memo
            #add-point:ON CHANGE l_dat_memo name="input.g.l_dat_memo"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaf010
            #add-point:BEFORE FIELD l_isaf010 name="input.b.l_isaf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaf010
            
            #add-point:AFTER FIELD l_isaf010 name="input.a.l_isaf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaf010
            #add-point:ON CHANGE l_isaf010 name="input.g.l_isaf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_limit_memo
            #add-point:BEFORE FIELD l_limit_memo name="input.b.l_limit_memo"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_limit_memo
            
            #add-point:AFTER FIELD l_limit_memo name="input.a.l_limit_memo"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_limit_memo
            #add-point:ON CHANGE l_limit_memo name="input.g.l_limit_memo"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isae007
            #add-point:BEFORE FIELD l_isae007 name="input.b.l_isae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isae007
            
            #add-point:AFTER FIELD l_isae007 name="input.a.l_isae007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isae007
            #add-point:ON CHANGE l_isae007 name="input.g.l_isae007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaf011
            #add-point:BEFORE FIELD l_isaf011 name="input.b.l_isaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaf011
            
            #add-point:AFTER FIELD l_isaf011 name="input.a.l_isaf011"
            IF NOT cl_null(g_master.l_isaf011)THEN
               #170103-00009#1 add ------
               #如果發票聯別=4:收據，不用檢核是否存在發票簿
               IF g_isac.isac008 <> '4' THEN
               #170103-00009#1 add end---
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count FROM isae_t
                   WHERE isaeent = g_enterprise
                     AND isaesite = g_master.l_site
                     AND isae001  = g_master.l_book
                     AND isae002 <= g_master.l_docdt
                     AND isae003 >= g_master.l_docdt
                     AND isae009 <= g_master.l_isaf011
                     AND isae010 >= g_master.l_isaf011
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'ais-00236'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_isaf011 = l_isae012
                     NEXT FIELD l_isaf011
                  END IF
               END IF  #170103-00009#1
               #160517-00005#1 mark 因回收號已可小於下次列印號-----s
               #IF g_master.l_isaf011 < l_isae012 THEN
               #   #IF NOT cl_ask_confirm('ais-00218') THEN    #發票序時序號 因此可大於等於下次列印號碼
               #   LET g_master.l_isaf011 = l_isae012
               #   NEXT FIELD l_isaf011
               #    END IF
               #END IF
               #160517-00005#1  因回收號已可小於下次列印號 mark-----e
               
               #160517-00005#1-----s
               #檢核發票是否產生過了
               IF g_isai.isai008 = 'TW' THEN
                 IF NOT cl_null(g_master.l_isae007)THEN
                    LET l_isah002do = g_master.l_isae007 CLIPPED,g_master.l_isaf011 CLIPPED
                 END IF
               END IF
               
               LET l_count = NULL
               IF g_isai.isai008 = 'TW' THEN
                  SELECT COUNT(*) INTO l_count FROM isat_t
                   WHERE isatent = g_enterprise
                     AND isat004 = l_isah002do
                     AND isat001 = g_master.l_xmdk015
                     AND to_char(isat007,'yyyy') = to_char(g_master.l_docdt,'yyyy')
                     AND isat025 = '11'
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
               ELSE
                  SELECT COUNT(*) INTO l_count FROM isat_t
                   WHERE isatent = g_enterprise
                     AND isat004 = l_isah002do
                     AND isat001 = g_master.l_xmdk015
                     AND isat003 = g_master.l_isaf010
                     AND to_char(isat007,'yyyy') = to_char(g_master.l_docdt,'yyyy')
                     AND isat025 = '11'
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
               END IF
               IF l_count > 0 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'ais-00201'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_isaf011 = l_isae012
                  NEXT FIELD l_isaf011
               END IF
               #160517-00005#1-----e
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaf011
            #add-point:ON CHANGE l_isaf011 name="input.g.l_isaf011"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_xrcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcasite
            #add-point:ON ACTION controlp INFIELD l_xrcasite name="input.c.l_xrcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrcasite
            #LET g_qryparam.where = " ooef204 = 'Y' "  #161006-00005#28 mark
            #CALL q_ooef001()                          #161006-00005#28 mark
            CALL q_ooef001_46()                        #161006-00005#28
            LET g_master.l_xrcasite = g_qryparam.return1
            DISPLAY BY NAME g_master.l_xrcasite
            NEXT FIELD l_xrcasite
            #END add-point
 
 
         #Ctrlp:input.c.l_xmdk042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmdk042
            #add-point:ON ACTION controlp INFIELD l_xmdk042 name="input.c.l_xmdk042"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_group_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_group_type
            #add-point:ON ACTION controlp INFIELD l_group_type name="input.c.l_group_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xrcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcacomp
            #add-point:ON ACTION controlp INFIELD l_xrcacomp name="input.c.l_xrcacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcald
            #add-point:ON ACTION controlp INFIELD l_xrcald name="input.c.l_xrcald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrcald
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_apcald
            LET g_qryparam.where = " glaacomp = '",l_comp,"' "
            CALL q_authorised_ld()
            LET g_master.l_xrcald = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.l_xrcald) RETURNING g_master.l_xrcald_desc
            DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcald
            NEXT FIELD l_xrcald
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_toaxrtype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_toaxrtype
            #add-point:ON ACTION controlp INFIELD l_toaxrtype name="input.c.l_toaxrtype"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xmdk015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmdk015
            #add-point:ON ACTION controlp INFIELD l_xmdk015 name="input.c.l_xmdk015"
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xmdk015             #給予default值
            IF g_master.l_toaxrtype = '1' THEN
               LET g_qryparam.where = "     isac001 = '",g_ooef019,"'",
                                      " AND isac003 = '2'"
            ELSE
               IF g_isai.isai006 = 'N' THEN
                  LET g_qryparam.where = "     isac001 = '",g_ooef019,"'",
                                         " AND isac003 = '4'"
               ELSE
                  LET g_qryparam.where = "     isac001 = '",g_ooef019,"'",
                                         " AND (isac003 = '2' OR isac003 = '4')"
               END IF
            END IF
            CALL q_isac002()                                #呼叫開窗
            LET  g_master.l_xmdk015  = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY BY NAME  g_master.l_xmdk015               #顯示到畫面上
            NEXT FIELD l_xmdk015                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_curr_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_curr_type
            #add-point:ON ACTION controlp INFIELD l_curr_type name="input.c.l_curr_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip1
            #add-point:ON ACTION controlp INFIELD l_slip1 name="input.c.l_slip1"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip1
            CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_comp,g_glaald
            LET l_glaa024 = ''
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_glaald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "aist310"
            CALL q_ooba002_1()
            LET g_master.l_slip1 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip1
            NEXT FIELD l_slip1
            #END add-point
 
 
         #Ctrlp:input.c.l_docdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_docdt
            #add-point:ON ACTION controlp INFIELD l_docdt name="input.c.l_docdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_toaistype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_toaistype
            #add-point:ON ACTION controlp INFIELD l_toaistype name="input.c.l_toaistype"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip2
            #add-point:ON ACTION controlp INFIELD l_slip2 name="input.c.l_slip2"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip2
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_master.l_xrcald
            LET g_qryparam.arg1 = l_glaa024
            #160707-00023#1 mark ------
            #IF g_master.l_toaxrtype = '1' THEN
            #   LET g_qryparam.arg2 = 'axrt300'
            #ELSE
            #   LET g_qryparam.arg2 = 'axrt340'
            #END IF
            #160707-00023#1 mark end---
            LET g_qryparam.arg2 = 'axrt300'   #160707-00023#1
            CALL q_ooba002_1()
            LET g_master.l_slip2 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip2
            NEXT FIELD l_slip2
            #END add-point
 
 
         #Ctrlp:input.c.l_slip3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip3
            #add-point:ON ACTION controlp INFIELD l_slip3 name="input.c.l_slip3"
            #160707-00023#1-s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip3
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_master.l_xrcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt340'
            CALL q_ooba002_1()
            LET g_master.l_slip3 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip3
            NEXT FIELD l_slip3
            #160707-00023#1-e
            #END add-point
 
 
         #Ctrlp:input.c.l_xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrca007
            #add-point:ON ACTION controlp INFIELD l_xrca007 name="input.c.l_xrca007"
            #albireo 150826-----s
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrca007 
            LET g_qryparam.arg1 = "3111" 
            CALL q_oocq002()             
            LET g_master.l_xrca007 = g_qryparam.return1
            CALL s_desc_get_acc_desc('3211',g_master.l_xrca007) RETURNING g_master.l_xrca007_desc
            DISPLAY BY NAME g_master.l_xrca007_desc
            NEXT FIELD l_xrca007                   
            #albireo 150826-----e
            #END add-point
 
 
         #Ctrlp:input.c.l_xrca063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrca063
            #add-point:ON ACTION controlp INFIELD l_xrca063 name="input.c.l_xrca063"
            CALL s_aooi390_gen('14') RETURNING g_sub_success,g_master.l_xrca063,l_oofg_return   
            DISPLAY BY NAME g_master.l_xrca063
            NEXT FIELD l_xrca063
            #END add-point
 
 
         #Ctrlp:input.c.l_site
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_site
            #add-point:ON ACTION controlp INFIELD l_site name="input.c.l_site"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_site
            LET g_qryparam.default2 = g_master.l_book
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
            IF g_isai.isai002 = '1' THEN
               LET l_prog = 'aisi055'
            ELSE
               LET l_prog = 'aisi050'
            END IF
            LET g_qryparam.where = #"isaesite IN ('",g_master.l_site,"','",l_comp,"' ) ",  #albireo 150803 mark
                                   #" isaesite IN ",g_wc_xrcasite,                         #albireo 150803 add #170113-00024#1 mark
                                   " isaesite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017='",g_master.l_xrcacomp,"')",  #170113-00024#1
                                   " AND isae002 <= '",g_master.l_docdt,"'",
                                   " AND isae003 >= '",g_master.l_docdt,"'",
                                   " AND isac001 = '",g_ooef019,"'"  #, albireo 160601 mark
                                   #" AND isae019 = '",l_prog,"' "   #albireo 160601 mark
                                   #" AND isae012 IS NOT NULL "  #SD建議可選到跟發票簿看到的相同但在欄位控卡提示錯誤
                                                                 #因此可選到發票號碼已經用完的發票簿號
            #IF g_xmdk.xmdk000 = '6' AND g_isai.isai006 = 'Y' THEN   #151123-00013#7
            #IF (g_xmdk.xmdk000 = '6' OR g_xmdk.xmdk000 = '5') AND g_isai.isai006 = 'Y' THEN   #151123-00013#7
            IF g_xmdk.xmdk000 = '6' AND g_isai.isai006 = 'Y' THEN    #151207-00018#2
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                                      " AND isae004  = '",g_master.l_xmdk015,"'"
            END IF
            CALL q_isaesite_3()
            LET g_master.l_site  = g_qryparam.return1
            LET g_master.l_book  = g_qryparam.return2
            DISPLAY BY NAME g_master.l_site,g_master.l_book
            NEXT FIELD l_site
            #END add-point
 
 
         #Ctrlp:input.c.l_book
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_book
            #add-point:ON ACTION controlp INFIELD l_book name="input.c.l_book"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_site
            LET g_qryparam.default2 = g_master.l_book
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
            IF g_isai.isai002 = '1' THEN
               LET l_prog = 'aisi055'
            ELSE
               LET l_prog = 'aisi050'
            END IF
            LET g_qryparam.where = #" isaesite IN ('",g_master.l_site,"','",l_comp,"' ) ", #albireo 150803 mark
                                   #" isaesite IN ",g_wc_xrcasite,                         #albireo 150803 add#170113-00024#1 mark
                                   " isaesite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef017='",g_master.l_xrcacomp,"')",  #170113-00024#1
                                   " AND isae002 <= '",g_master.l_docdt,"'",
                                   " AND isae003 >= '",g_master.l_docdt,"'",
                                   " AND isac001 = '",g_ooef019,"'"   #, albireo 160601 mark
                                   #" AND isae019 = '",l_prog,"' "      #albireo 160601 mark
                                   #" AND isae012 IS NOT NULL " #SD建議可選到跟發票簿看到的相同但在欄位控卡提示錯誤
                                                                #因此可選到發票號碼已經用完的發票簿號
            #IF g_xmdk.xmdk000 = '6' AND g_isai.isai006 = 'Y' THEN    #151123-00013#7
            #IF (g_xmdk.xmdk000 = '6' OR g_xmdk.xmdk000 = '5') AND g_isai.isai006 = 'Y' THEN    #151123-00013#7 
            #170113-00024#1 add ------
            IF NOT cl_null(g_master.l_site) THEN
               LET g_qryparam.where = g_qryparam.where," AND isaesite = '",g_master.l_site,"'"
            END IF
            #170113-00024#1 add end---
            IF g_xmdk.xmdk000 = '6' AND g_isai.isai006 = 'Y' THEN     #151207-00018#2
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                                      " AND isae004  = '",g_master.l_xmdk015,"'"
            END IF
            CALL q_isaesite_3()
            LET g_master.l_site  = g_qryparam.return1
            LET g_master.l_book  = g_qryparam.return2
            DISPLAY BY NAME g_master.l_site,g_master.l_book
            NEXT FIELD l_book
            #END add-point
 
 
         #Ctrlp:input.c.l_dat_memo
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dat_memo
            #add-point:ON ACTION controlp INFIELD l_dat_memo name="input.c.l_dat_memo"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaf010
            #add-point:ON ACTION controlp INFIELD l_isaf010 name="input.c.l_isaf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_limit_memo
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_limit_memo
            #add-point:ON ACTION controlp INFIELD l_limit_memo name="input.c.l_limit_memo"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isae007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isae007
            #add-point:ON ACTION controlp INFIELD l_isae007 name="input.c.l_isae007"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaf011
            #add-point:ON ACTION controlp INFIELD l_isaf011 name="input.c.l_isaf011"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xmdkdocno,xmdk007,xmdk009,xmdkdocdt,xmdk004,xmdk003
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xmdkdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocno
            #add-point:ON ACTION controlp INFIELD xmdkdocno name="construct.c.xmdkdocno"
            #來源單號-開窗c段
            #151231-00010#3-----s
            CALL s_control_get_customer_sql('2',g_master.l_xrcacomp,g_user,g_dept,'') RETURNING g_sub_success,l_ctl_where
            #151231-00010#3-----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = #"xmdkstus = 'S' ",
                                   " 1=1 ",   #151123-00013#7
                                   " AND xmdksite IN ",g_wc_xrcasite,
                                   " AND xmdksite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
                                                     " AND ooef017 = '",g_master.l_xrcacomp,"')",
                                   " AND xmdk001 <= '",g_master.l_docdt,"'",
                                   " AND xmdl087 = 'Y'",
                                   " AND (xmdl022 - xmdl047) > 0",
                                   #" AND xmdk015 = '",g_master.l_xmdk015,"'",  #發票類型 #160707-00023#1    161111-00048#1 mark 要增加判斷
                                   " AND xmdk042 = '",g_master.l_xmdk042,"'",  #內外銷   #160707-00023#1
                                   #151231-00010#3-----s 
                                   " AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t ",
                                                " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                "   AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
                                                "   AND pmabsite = '",g_master.l_xrcacomp,"'",
                                                "   AND pmaaent = xmdkent",
                                                "   AND pmaa001 = xmdk007 )"                                   #151231-00010#3-----e
            
            #160707-00023#1-----s
            CASE
               WHEN g_master.l_toaxrtype = '2' AND g_isai.isai006 = 'N'
               OTHERWISE
                   LET g_qryparam.where = g_qryparam.where CLIPPED," AND xmdk015 = '",g_master.l_xmdk015,"' "
            END CASE
            #160707-00023#1-----e
            
            #160707-00023#1 mark ------
            #IF g_master.l_toaxrtype = '1' THEN
            #   #藍字發票
            #   LET g_qryparam.where = g_qryparam.where CLIPPED,
            #                          #" AND xmdk000 <> '6' "
            #                          " AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1') OR (xmdk000 = '4' AND xmdkstus = 'Y' and xmdk002  ='3'))"   #151123-00013#7
            #   
            #ELSE
            #   #紅字發票
            #   LET g_qryparam.where = g_qryparam.where CLIPPED,
            #                          #" AND xmdk000 = '6' ",
            #                          #" AND ((xmdk006 = '6' AND xmdkstus = 'S' AND xmdk002  ='1') OR (xmdk005 = '5' AND xmdkstus = 'Y' AND xmdk002  ='3')) "   #151123-00013#7
            #                          " AND (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5' ) "   #151207-00018#2
            #END IF
            #160707-00023#1 mark end---
            #160707-00023#1 add ------
            CASE
              #WHEN g_master.l_toaxrtype = '1' AND g_master.l_group_type MATCHES '[23]'  #170217-00004#1 mark
               WHEN g_master.l_toaxrtype = '1' AND g_master.l_group_type MATCHES '[236]' #170217-00004#1
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1')",
                                         "      OR (xmdk000 = '4' AND xmdkstus = 'Y' and xmdk002  ='3')",
                                         "      OR (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5'))"
               WHEN g_master.l_toaxrtype = '1' AND g_master.l_group_type = '0'
                  #藍字發票
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                      " AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1') OR (xmdk000 = '4' AND xmdkstus = 'Y' and xmdk002  ='3'))"
               WHEN g_master.l_toaxrtype = '2'
                  #紅字發票
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5')" 
            END CASE
            #160707-00023#1 add end---
            LET g_qryparam.arg1 = '1'
            CALL q_xmdkdocno_16()
            DISPLAY g_qryparam.return1 TO xmdkdocno
            NEXT FIELD xmdkdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkdocno
            #add-point:BEFORE FIELD xmdkdocno name="construct.b.xmdkdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkdocno
            
            #add-point:AFTER FIELD xmdkdocno name="construct.a.xmdkdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk007
            #add-point:ON ACTION controlp INFIELD xmdk007 name="construct.c.xmdk007"
            #160707-00023#1 -s
            #客戶編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"
            ELSE
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3') AND ",g_qryparam.where
            END IF
            CALL q_pmaa001()
            DISPLAY g_qryparam.return1 TO xmdk007
            NEXT FIELD xmdk007
            #160707-00023#1 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk007
            #add-point:BEFORE FIELD xmdk007 name="construct.b.xmdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk007
            
            #add-point:AFTER FIELD xmdk007 name="construct.a.xmdk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk009
            #add-point:ON ACTION controlp INFIELD xmdk009 name="construct.c.xmdk009"
            #160707-00023#1 -s
            #收貨客戶
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"
            ELSE
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3') AND ",g_qryparam.where
            END IF
            CALL q_pmaa001()
            DISPLAY g_qryparam.return1 TO xmdk009
            NEXT FIELD xmdk009
            #160707-00023#1 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk009
            #add-point:BEFORE FIELD xmdk009 name="construct.b.xmdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk009
            
            #add-point:AFTER FIELD xmdk009 name="construct.a.xmdk009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkdocdt
            #add-point:BEFORE FIELD xmdkdocdt name="construct.b.xmdkdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkdocdt
            
            #add-point:AFTER FIELD xmdkdocdt name="construct.a.xmdkdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocdt
            #add-point:ON ACTION controlp INFIELD xmdkdocdt name="construct.c.xmdkdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk004
            #add-point:ON ACTION controlp INFIELD xmdk004 name="construct.c.xmdk004"
            #160707-00023#1 -s
            #業務部門
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooeg009 = '",g_master.l_xrcacomp,"'"
            CALL q_ooeg001()
            DISPLAY g_qryparam.return1 TO xmdk004
            NEXT FIELD xmdk004
            #160707-00023#1 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk004
            #add-point:BEFORE FIELD xmdk004 name="construct.b.xmdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk004
            
            #add-point:AFTER FIELD xmdk004 name="construct.a.xmdk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk003
            #add-point:ON ACTION controlp INFIELD xmdk003 name="construct.c.xmdk003"
            #160707-00023#1 -s
            #業務人員
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooag004 ='",g_master.l_xrcasite,"'"
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xmdk003
            NEXT FIELD xmdk003
            #160707-00023#1 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk003
            #add-point:BEFORE FIELD xmdk003 name="construct.b.xmdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk003
            
            #add-point:AFTER FIELD xmdk003 name="construct.a.xmdk003"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL aisp320_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
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
            CALL aisp320_qbeclear()
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
         CALL aisp320_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#4-----s
      #LET lc_param.l_xmdkdocno   = g_master.l_xmdkdocno
      LET lc_param.l_xmdk015     = g_master.l_xmdk015
      #LET lc_param.l_xmdk017     = g_master.l_xmdk017
      LET lc_param.l_slip1       = g_master.l_slip1
      LET lc_param.l_docdt       = g_master.l_docdt
      LET lc_param.l_toaistype   = g_master.l_toaistype
      LET lc_param.l_site        = g_master.l_site
      LET lc_param.l_book        = g_master.l_book
      LET lc_param.l_dat_memo    = g_master.l_dat_memo
      LET lc_param.l_isaf010     = g_master.l_isaf010
      LET lc_param.l_limit_memo  = g_master.l_limit_memo
      LET lc_param.l_isaf011     = g_master.l_isaf011
      LET lc_param.l_xrcald      = g_master.l_xrcald
      LET lc_param.l_slip2       = g_master.l_slip2
      LET lc_param.l_slip3       = g_master.l_slip3       #160707-00023#1
      LET lc_param.l_xrca063     = g_master.l_xrca063
      LET lc_param.l_xrcasite    = g_master.l_xrcasite
      LET lc_param.l_xrcacomp    = g_master.l_xrcacomp
      LET lc_param.l_curr_type   = g_master.l_curr_type
      LET lc_param.l_toaxrtype   = g_master.l_toaxrtype
      LET lc_param.l_xrca007     = g_master.l_xrca007     #albireo 150826 add
      #160707-00023#1 add ------
      LET lc_param.l_xmdk042     = g_master.l_xmdk042
      LET lc_param.l_group_type  = g_master.l_group_type
      LET lc_param.l_chk1        = g_master.l_chk1
      LET lc_param.l_chk2        = g_master.l_chk2
      #160707-00023#1 add end---
      #150624-00005#4-----e
      CALL util.JSON.parse(g_argv[1],l_tran)
      IF NOT cl_null(l_tran.wc)THEN
         
         LET lc_param.wc = lc_param.wc CLIPPED," AND ",l_tran.wc CLIPPED
         
      END IF
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
                 CALL aisp320_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp320_transfer_argv(ls_js)
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
 
{<section id="aisp320.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp320_transfer_argv(ls_js)
 
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
 
{<section id="aisp320.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp320_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
#DEFINE l_isaf        RECORD LIKE isaf_t.*      #對帳單頭 #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE l_isaf RECORD  #銷項發票主檔
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
#DEFINE l_xmdk        RECORD LIKE xmdk_t.*      # #161104-00024#10 mark
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
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
END RECORD
#161104-00024#10 --e add
DEFINE r_success     LIKE type_t.num5
DEFINE l_wc          STRING
DEFINE l_array       DYNAMIC ARRAY OF RECORD
          chr           LIKE type_t.chr1000,
          dat           LIKE type_t.dat
                     END RECORD
DEFINE l_pmaa003     LIKE pmaa_t.pmaa003   #150730-00006#1 add
#DEFINE l_isaf011 LIKE isaf_t.isaf011      #albireo 150813
#cmdrun axrp132-----s
DEFINE la_param      RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                     END RECORD
DEFINE tran_master   RECORD
          xrcasite      LIKE xrca_t.xrcasite,
          xrcasite_desc LIKE type_t.chr80,
          xrcald        LIKE xrca_t.xrcald,
          xrcald_desc   LIKE type_t.chr80,
          b_style       LIKE type_t.chr500,
          l_isaf001     LIKE type_t.chr500,     #160426-00013#3
          xrcadocno     LIKE xrca_t.xrcadocno,
          xrca007       LIKE xrca_t.xrca007,
          xrcadocdt     LIKE xrca_t.xrcadocdt,
          b_check1      LIKE type_t.chr500,
          b_check4      LIKE type_t.chr500,
          b_check2      LIKE type_t.chr500,
          b_check5      LIKE type_t.chr500,
          b_check3      LIKE type_t.chr500,
          b_check6      LIKE type_t.chr500,
          b_comb1       LIKE type_t.chr500,
          b_comb2       LIKE type_t.chr500,
          isafdocno     LIKE isaf_t.isafdocno,
          fflabel_desc  LIKE type_t.chr80,
          isaf002       LIKE isaf_t.isaf002,
          isaf010       LIKE isaf_t.isaf010,
          isaf003       LIKE isaf_t.isaf003,
          isaf011       LIKE isaf_t.isaf011,
          isaf055       LIKE isaf_t.isaf055,
          isaf014       LIKE isaf_t.isaf014,
          isaf004       LIKE isaf_t.isaf004,
          isaf016       LIKE isaf_t.isaf016,
          isaf057       LIKE isaf_t.isaf057,
          stagenow      LIKE type_t.chr80,
          wc            STRING
                     END RECORD
DEFINE l_tran        STRING
DEFINE ls_js2        STRING
DEFINE l_comp        LIKE ooef_t.ooef001 #150624-00005#4
#cmdrun axrp132-----e
DEFINE l_sql         STRING
DEFINE l_xmdkdocno   LIKE xmdk_t.xmdkdocno
DEFINE l_strno       LIKE type_t.chr80
DEFINE l_endno       LIKE type_t.chr80
DEFINE l_strno1      LIKE isaf_t.isafdocno
DEFINE l_endno1      LIKE isaf_t.isafdocno
DEFINE l_strno2      LIKE xrca_t.xrcadocno
DEFINE l_endno2      LIKE xrca_t.xrcadocno
DEFINE l_doais       LIKE type_t.num5
DEFINE l_doaxr       LIKE type_t.num5
DEFINE l_xrca063     LIKE xrca_t.xrca063
DEFINE l_isae007     LIKE isae_t.isae007
DEFINE l_isaf011     LIKE isaf_t.isaf011   #發票號碼
##150918-00001#7-----s
DEFINE l_isatsum     LIKE type_t.num20_6
DEFINE l_isafsum     LIKE type_t.num20_6
DEFINE l_count       LIKE type_t.num10
#150918-00001#7------e
#151022-00017#2--s
DEFINE l_sfin2009    LIKE type_t.chr1
DEFINE lc_param_rate RECORD
          type          LIKE type_t.chr1,       #類型
          apca004       LIKE apca_t.apca004,    #交易對象
          sfin2009      LIKE type_t.chr1        #匯率類型
                     END RECORD
DEFINE l_desc        LIKE type_t.chr10
#151022-00017#2--e
#151231-00010#3-----s
DEFINE l_ctl_where   STRING
#151231-00010#3-----e
#albireo 160606-----s
DEFINE l_isat004     LIKE isat_t.isat004
DEFINE l_isatcnt     LIKE type_t.num10
#albireo 160606-----e
#160707-00023#1 add ------
DEFINE l_field1      STRING
DEFINE l_field2      STRING
DEFINE l_field3      STRING
DEFINE l_xmdk007     LIKE xmdk_t.xmdk007
DEFINE l_xmdk009     LIKE xmdk_t.xmdk009
DEFINE l_xmdk010     LIKE xmdk_t.xmdk010
DEFINE l_xmdk012     LIKE xmdk_t.xmdk012
DEFINE l_xmdk016     LIKE xmdk_t.xmdk016
DEFINE l_xmdksite    LIKE xmdk_t.xmdksite
DEFINE l_type        LIKE type_t.chr5
DEFINE l_group       LIKE type_t.chr500
DEFINE l_oodbl004    LIKE oodbl_t.oodbl004  #稅率說明
DEFINE l_oodb011     LIKE oodb_t.oodb011    #稅別應用
#160707-00023#1 add ------
#161125-00002#1-----s
DEFINE l_xmdo017     LIKE xmdo_t.xmdo017    #IV 匯率
#161125-00002#1-----e
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #JSON解開的變數內容給到g_master中
   #150624-00005#4-----s
   ##將傳遞參數變數傳回給畫面上的變數
   #IF g_bgjob = "Y" OR g_bgjob = "T" THEN
   #   LET g_master.wc            = lc_param.wc
   #   #LET g_master.l_xmdkdocno  = lc_param.l_xmdkdocno
   #   LET g_master.l_xmdk015     = lc_param.l_xmdk015
   #   #LET g_master.l_xmdk017    = lc_param.l_xmdk017
   #   LET g_master.l_slip1       = lc_param.l_slip1
   #   LET g_master.l_docdt       = lc_param.l_docdt
   #   LET g_master.l_toaistype   = lc_param.l_toaistype
   #   LET g_master.l_site        = lc_param.l_site
   #   LET g_master.l_book        = lc_param.l_book
   #   LET g_master.l_dat_memo    = lc_param.l_dat_memo
   #   LET g_master.l_isaf010     = lc_param.l_isaf010
   #   LET g_master.l_limit_memo  = lc_param.l_limit_memo
   #   LET g_master.l_isaf011     = lc_param.l_isaf011
   #   LET g_master.l_xrcald      = lc_param.l_xrcald
   #   LET g_master.l_slip2       = lc_param.l_slip2
   #   LET g_master.l_xrca063     = lc_param.l_xrca063
   #END IF
   #150624-00005#4-----e
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp320_process_cs CURSOR FROM ls_sql
#  FOREACH aisp320_process_cs INTO
   #add-point:process段process name="process.process"
   #帳務中心預設的範圍等值
   CALL s_fin_orga_get_comp_ld(lc_param.l_xrcasite) RETURNING g_sub_success,g_errno,lc_param.l_xrcacomp,lc_param.l_xrcald
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent =g_enterprise
      AND ooef001 = lc_param.l_xrcacomp
   CALL s_fin_account_center_sons_query('3',lc_param.l_xrcasite,g_today,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
   CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   CALL s_control_get_customer_sql('2',lc_param.l_xrcacomp,g_user,g_dept,'') RETURNING g_sub_success,l_ctl_where  #151231-00010#3

   #160707-00023#1 mark ------
   #LET l_sql = "SELECT DISTINCT xmdkdocno FROM xmdk_t,xmdl_t",
   #            " WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno",
   #            " AND xmdkent = ",g_enterprise,
   #           #" AND xmdkstus = 'S' ",     #151123-00013#7 mark
   #            " AND xmdk001 <= '",lc_param.l_docdt,"'",
   #            " AND ",lc_param.wc CLIPPED,
   #            " AND xmdksite IN ",g_wc_xrcasite,
   #            " AND xmdksite IN( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
   #            "                     AND ooef017 = '",lc_param.l_xrcacomp,"')",
   #            " AND xmdl087 = 'Y' ",
   #            " AND (xmdl022-xmdl047) > 0",
   #            #151231-00010#3-----s
   #            " AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t",
   #            "              WHERE pmab001 = pmaa001 AND pmabent = pmaaent",
   #            "                AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
   #            "                AND pmabsite = '",lc_param.l_xrcacomp,"'",
   #            "                AND pmaaent = xmdkent",
   #            "                AND pmaa001 = xmdk007)"
   #            #151231-00010#3-----e
   #           #" AND (xmdl022 - xmdl038 - xmdl053) > 0 "   #150730 albireo mark  SA認為這部分應讓axrp132去判斷就行了
   #160707-00023#1 mark end---
   
   #160707-00023#1 add ------
   #彙總group by條件組合處：
   #1.依照彙總條件
   CASE
      WHEN lc_param.l_group_type = '0'  #0:出貨單
         LET l_field1 = ",xmdkdocno"
      WHEN lc_param.l_group_type = '2'  #2:業務人員
         LET l_field1 = ",xmdk003"
      WHEN lc_param.l_group_type = '3'  #3:業務部門
         LET l_field1 = ",xmdk004"
      #170217-00004#1 add ------
      WHEN lc_param.l_group_type = '6'  #6:全部
         LET l_field1 = ",''"
      #170217-00004#1 add end---
   END CASE
   #2.是否依來源營運據點拆單
   IF lc_param.l_chk1 = "Y" THEN
      LET l_field2 = ",xmdksite"
   ELSE
      LET l_field2 = ",''"
   END IF
   #3.匯率選擇是1:依原單匯率
   IF lc_param.l_curr_type = '1' THEN
      LET l_field3 = ",xmdk017"
   ELSE
      LET l_field3 = ",''"
   END IF
   
   LET l_sql = "SELECT '1',xmdk007,xmdk008,xmdk009,xmdk010,",
               "       xmdk012,xmdk016,xmdk047,",    #160802-00007#1 Add xmdk047
               "       SUM(xmdk051),SUM(xmdk052),SUM(xmdk053)",
               l_field1,l_field2,l_field3,
               " FROM xmdk_t,xmdl_t",
               " WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno",
               " AND xmdkent = ",g_enterprise,
               " AND xmdk001 <= '",lc_param.l_docdt,"'",
               " AND xmdksite IN ",g_wc_xrcasite,
               " AND xmdksite IN( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
               "                     AND ooef017 = '",lc_param.l_xrcacomp,"')",
               " AND xmdl087 = 'Y' ",
               " AND (xmdl022-xmdl047) > 0",
               " AND xmdk042 = '",lc_param.l_xmdk042,"'",  #內外銷
               " AND (xmdk084 <> '2'  OR xmdk084 IS NULL)",
               " AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t",
               "              WHERE pmab001 = pmaa001 AND pmabent = pmaaent",
               "                AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
               "                AND pmabsite = '",lc_param.l_xrcacomp,"'",
               "                AND pmaaent = xmdkent",
               "                AND pmaa001 = xmdk007)",
               " AND ",lc_param.wc CLIPPED
   #160707-00023#1 add end---
   
   #IF lc_param.l_toaxrtype = '1' THEN
   #   LET l_sql = l_sql CLIPPED," AND xmdk000 <> '6' "
   #ELSE
   #   LET l_sql = l_sql CLIPPED," AND xmdk000 = '6' "
   #END IF
   #160707-00023#1 mark ------
   ##151123-00013#7-----s
   #IF g_master.l_toaxrtype = '1' THEN
   #   #藍字發票
   #   LET l_sql = l_sql CLIPPED," AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1')  OR  (xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002  ='3'))"   #151123-00013#7
   #ELSE
   #   #紅字發票
   #   LET l_sql = l_sql CLIPPED,#" AND ((xmdk006 = '6' AND xmdkstus = 'S' AND xmdk002  ='1') OR (xmdk005 = '5' AND xmdkstus = 'Y' AND xmdk002  ='3')) "   #151123-00013#7
   #                              " AND (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5' ) "   #151207-00018#2
   #END IF
   ##151123-00013#7-----e
   #160707-00023#1 mark end---
   #160707-00023#1 add ------
   CASE
     #WHEN lc_param.l_toaxrtype = '1' AND lc_param.l_group_type MATCHES '[23]'  #170217-00004#1 mark
      WHEN lc_param.l_toaxrtype = '1' AND lc_param.l_group_type MATCHES '[236]' #170217-00004#1
         LET l_sql = l_sql CLIPPED," AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1')",
                                   "      OR (xmdk000 = '4' AND xmdkstus = 'Y' and xmdk002  ='3')",
                                   "      OR (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5'))"
      WHEN lc_param.l_toaxrtype = '1' AND lc_param.l_group_type = '0'
         #藍字發票
         LET l_sql = l_sql CLIPPED," AND ((xmdk000 IN ('1','2','3') AND xmdkstus = 'S' AND xmdk002  ='1') ",
                                   "      OR (xmdk000 = '4' AND xmdkstus = 'Y' and xmdk002  ='3'))"
      WHEN lc_param.l_toaxrtype = '2'
         #紅字發票
         LET l_sql = l_sql CLIPPED," AND (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5')" 
   END CASE
   LET l_sql = l_sql CLIPPED," GROUP BY xmdk007,xmdk008,xmdk009,xmdk010,xmdk012,",
                             "          xmdk016,xmdk047",    #160802-00007#1 Add xmdk047
                             l_field1,l_field2,l_field3,
                             #當銷退單折讓單開立方式(xmdk084)為2:須開立發票扣抵證明單時，獨立產生資料
                             " UNION ",
                             "SELECT '2',xmdk007,xmdk008,xmdk009,xmdk010,",
                             "       xmdk012,xmdk016,xmdk047,",    #160802-00007#1 Add xmdk047
                             "       SUM(xmdk051),SUM(xmdk052),SUM(xmdk053),xmdkdocno",
                             l_field2,l_field3,
                             " FROM xmdk_t,xmdl_t",
                             " WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno",
                             " AND xmdkent = ",g_enterprise,
                             " AND xmdk001 <= '",lc_param.l_docdt,"'",
                             " AND xmdksite IN ",g_wc_xrcasite,
                             " AND xmdksite IN( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise,
                             "                     AND ooef017 = '",lc_param.l_xrcacomp,"')",
                             " AND xmdl087 = 'Y' ",
                             " AND (xmdl022-xmdl047) > 0",
                             " AND xmdk042 = '",lc_param.l_xmdk042,"'",  #內外銷
                             " AND xmdk084 = '2'",
                             " AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t",
                             "              WHERE pmab001 = pmaa001 AND pmabent = pmaaent",
                             "                AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
                             "                AND pmabsite = '",lc_param.l_xrcacomp,"'",
                             "                AND pmaaent = xmdkent",
                             "                AND pmaa001 = xmdk007)",
                             " AND ",lc_param.wc CLIPPED,
                             " AND (xmdk000 = '6' AND xmdkstus = 'S' AND xmdk082 <> '5')",
                             " GROUP BY xmdk007,xmdk008,xmdk009,xmdk010,xmdk012,xmdk047,",    #160802-00007#1 Add xmdk047
                             "          xmdk016,xmdkdocno",
                             l_field2,l_field3
   #160707-00023#1 add end---
   PREPARE aisp320_mainp1 FROM l_sql
   DECLARE aisp320_mainc1 CURSOR WITH HOLD FOR aisp320_mainp1
   
   LET l_strno1 = NULL   LET l_endno1 = NULL
   LET l_strno2 = NULL   LET l_endno2 = NULL
   LET l_doaxr = 0       LET l_doais = 0
   
   #整帳批序號
   IF NOT cl_null(lc_param.l_xrca063)THEN
      CALL s_transaction_begin()
      CALL s_aooi390_get_auto_no('14',lc_param.l_xrca063) RETURNING g_sub_success,l_xrca063
      CALL s_aooi390_oofi_upd('14',l_xrca063) RETURNING g_sub_success
      CALL s_transaction_end('Y','0')
   END IF
   
   CALL cl_err_collect_init()
   #FOREACH aisp320_mainc1 INTO l_xmdkdocno  #160707-00023#1 mark
   #160707-00023#1 add ------
   FOREACH aisp320_mainc1 INTO l_type,l_xmdk.xmdk007,l_xmdk.xmdk008,l_xmdk.xmdk009,l_xmdk.xmdk010,
                               l_xmdk.xmdk012,l_xmdk.xmdk016,l_xmdk.xmdk047,l_xmdk.xmdk051,l_xmdk.xmdk052,l_xmdk.xmdk053,   #160802-00007#1 Add xmdk047
                               l_group,l_xmdksite,l_xmdk.xmdk017
   #160707-00023#1 add end---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:aisp320_mainc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET r_success = TRUE
      
      #160707-00023#1 mark ------
      #INITIALIZE l_xmdk.* TO NULL
      #SELECT * INTO l_xmdk.* FROM xmdk_t
      # WHERE xmdkent = g_enterprise
      #   AND xmdkdocno = l_xmdkdocno    #alberr
      #160707-00023#1 mark end---
      
      #160707-00023#1 add ------
      INITIALIZE l_isaf.* TO NULL
      #依照彙總條件先給值
      CASE
         WHEN lc_param.l_group_type = '0' OR l_type = '2' #0:出貨單/銷退單(2:須開立發票扣抵證明單)
            LET l_xmdkdocno = l_group
            INITIALIZE l_xmdk.* TO NULL
            #SELECT * INTO l_xmdk.* FROM xmdk_t   #161208-00026#28 mark
            #161208-00026#28-add(s)
            SELECT xmdkent,xmdksite,xmdkunit,xmdkdocno,xmdkdocdt,
                   xmdk000,xmdk001,xmdk002,xmdk003,xmdk004,
                   xmdk005,xmdk006,xmdk007,xmdk008,xmdk009,
                   xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,
                   xmdk015,xmdk016,xmdk017,xmdk018,xmdk019,
                   xmdk020,xmdk021,xmdk022,xmdk023,xmdk024,
                   xmdk025,xmdk026,xmdk027,xmdk028,xmdk029,
                   xmdk030,xmdk031,xmdk032,xmdk033,xmdk034,
                   xmdk035,xmdk036,xmdk037,xmdk038,xmdk039,
                   xmdk040,xmdk041,xmdk042,xmdk043,xmdk044,
                   xmdk045,xmdk051,xmdk052,xmdk053,xmdk054,
                   xmdk055,xmdk081,xmdk082,xmdk083,xmdk084,
                   xmdk200,xmdk201,xmdk202,xmdk203,xmdk204,
                   xmdk205,xmdk206,xmdk207,xmdk208,xmdk209,
                   xmdk210,xmdk211,xmdk212,xmdk213,xmdk214,
                   xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,xmdkcrtdt,
                   xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,
                   xmdkpstdt,xmdkstus,xmdkud001,xmdkud002,xmdkud003,
                   xmdkud004,xmdkud005,xmdkud006,xmdkud007,xmdkud008,
                   xmdkud009,xmdkud010,xmdkud011,xmdkud012,xmdkud013,
                   xmdkud014,xmdkud015,xmdkud016,xmdkud017,xmdkud018,
                   xmdkud019,xmdkud020,xmdkud021,xmdkud022,xmdkud023,
                   xmdkud024,xmdkud025,xmdkud026,xmdkud027,xmdkud028,
                   xmdkud029,xmdkud030,xmdk085,xmdk086,xmdk046,
                   xmdk087,xmdk047,xmdk088,xmdk089 
              INTO l_xmdk.* 
              FROM xmdk_t
            #161208-00026#28-add(e)
             WHERE xmdkent = g_enterprise
               AND xmdkdocno = l_xmdkdocno
            IF lc_param.l_xmdk042 = '1' THEN #1:內銷
               LET l_isaf.isafdocdt = l_xmdk.xmdk001
               LET l_isaf.isaf014 = l_xmdk.xmdk001   #161122-00020#1
            ELSE
               LET l_isaf.isafdocdt = l_xmdk.xmdk032
               LET l_isaf.isaf014 = l_xmdk.xmdk032
            END IF
         WHEN lc_param.l_group_type = '2'  #2:業務人員
            LET l_xmdk.xmdk003 = l_group
            SELECT pmab109 INTO l_xmdk.xmdk004
              FROM pmab_t
             WHERE pmabent = g_enterprise
               AND pmabsite = lc_param.l_xrcasite
               AND pmab001 = l_xmdk.xmdk007
            IF cl_null(l_xmdk.xmdk004) THEN LET l_xmdk.xmdk004 = g_dept END IF
            LET l_xmdk.xmdk202 = l_xmdk.xmdk008 #發票客戶(比照aist310新增給法)
            LET l_isaf.isafdocdt = lc_param.l_docdt
            LET l_isaf.isaf014   = lc_param.l_docdt
         WHEN lc_param.l_group_type = '3'  #3:業務部門
            SELECT pmab081 INTO l_xmdk.xmdk003
              FROM pmab_t
             WHERE pmabent = g_enterprise
               AND pmabsite = lc_param.l_xrcasite
               AND pmab001 = l_xmdk.xmdk007
           #IF cl_null(l_xmdk.xmdk004) THEN LET l_xmdk.xmdk004 = g_user END IF #170217-00004#1 mark
            IF cl_null(l_xmdk.xmdk003) THEN LET l_xmdk.xmdk003 = g_user END IF #170217-00004#1
            LET l_xmdk.xmdk004 = l_group
            LET l_xmdk.xmdk202 = l_xmdk.xmdk008 #發票客戶(比照aist310新增給法)
            LET l_isaf.isafdocdt = lc_param.l_docdt
            LET l_isaf.isaf014   = lc_param.l_docdt
         #170217-00004#1 add ------
         WHEN lc_param.l_group_type = '6'  #6:全部
            #取apmm100的預設資料，沒有就給空白
            SELECT pmaa096,pmaa097 INTO l_xmdk.xmdk003,l_xmdk.xmdk004
              FROM pmaa_t
             WHERE pmaaent = g_enterprise
               AND pmaa001 = l_xmdk.xmdk008
            IF cl_null(l_xmdk.xmdk003) THEN LET l_xmdk.xmdk003 = g_user END IF
            LET l_xmdk.xmdk202 = l_xmdk.xmdk008 #發票客戶(比照aist310新增給法)
            LET l_isaf.isafdocdt = lc_param.l_docdt
            LET l_isaf.isaf014   = lc_param.l_docdt
         #170217-00004#1 add ------
      END CASE
      #160707-00023#1 add end---
      
      CALL s_transaction_begin() 
      
      #INITIALIZE l_isaf.* TO NULL              #160707-00023#1 mark
      LET l_isaf.isafent = g_enterprise
      #LET l_isaf.isafsite = l_xmdk.xmdksite    #160707-00023#1 mark
      LET l_isaf.isafsite = lc_param.l_xrcasite #160707-00023#1
      CALL s_fin_orga_get_comp_ld(l_isaf.isafsite) RETURNING g_sub_success,g_errno,l_isaf.isafcomp,g_glaald
      
      LET g_ooef019 = NULL
      SELECT ooef019 INTO g_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
      LET l_isaf.isafdocno = lc_param.l_slip1
     #LET l_isaf.isafdocdt = lc_param.l_docdt  #albireo 150810 modify  # g_today>lc_param.l_docdt #160707-00023#1 mark
      
      #auto asigh no
      #160707-00023#1 add ------
      IF l_type = '2' THEN #折讓
         #取aisi090設定的常用單別
         SELECT isao015 INTO l_isaf.isafdocno
           FROM isao_t
          WHERE isaoent = g_enterprise
            AND isaosite = lc_param.l_xrcasite
      END IF
      #160707-00023#1 add end---
      CALL s_aooi200_fin_gen_docno(g_glaald,'','',l_isaf.isafdocno,l_isaf.isafdocdt,'aist310')
         RETURNING g_sub_success,l_isaf.isafdocno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      LET l_isaf.isaf002   = l_xmdk.xmdk202     #發票客戶
      LET l_isaf.isaf003   = l_xmdk.xmdk008     #帳款客戶
      LET l_isaf.isaf004   = l_xmdk.xmdk004     #業務組織
      LET l_isaf.isaf005   = g_user
      #開票人員串ooag003
      SELECT ooag003 INTO l_isaf.isaf006 FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = l_isaf.isaf005
      
      #161111-00048#1-----s
      CASE
         #WHEN lc_param.l_group_type = '0' AND g_isai.isai006 = 'N' #170123-00001#1 mark
         #立帳依據：2:扣抵折讓單+紅字發票與藍字發票共用發票簿=Y，則取aisi030對應折單類型
         WHEN lc_param.l_toaxrtype = '2' AND g_isai.isai006 = 'Y'   #170123-00001#1
            SELECT isac009 INTO l_isaf.isaf008
              FROM isac_t
             WHERE isacent = g_enterprise
               AND isac001 = g_ooef019
               AND isac002 = l_xmdk.xmdk015 
            IF cl_null(l_isaf.isaf008)THEN LET l_isaf.isaf008   = lc_param.l_xmdk015 END IF
         #沒有就取原單發票類型
         OTHERWISE
            LET l_isaf.isaf008   = lc_param.l_xmdk015 #發票類型
      END CASE
      #161111-00048#1-----e
      #LET l_isaf.isaf009   = #從發票簿抓 預設N
      #LET l_isaf.isaf010   = #發票代碼後面呼叫展算回寫
      #LET l_isaf.isaf011   = #發票號碼
      #LET l_isaf.isaf014   = lc_param.l_docdt  #160707-00023#1 mark
      LET l_isaf.isaf016   = l_xmdk.xmdk012     #稅別
      LET l_isaf.isaf017   = l_xmdk.xmdk014     #含稅否
      LET l_isaf.isaf018   = l_xmdk.xmdk013     #稅率
      #160707-00023#1 add ------
      IF cl_null(l_isaf.isaf017) OR cl_null(l_isaf.isaf018) THEN
         CALL s_tax_chk(lc_param.l_xrcasite,l_xmdk.xmdk012)
              RETURNING g_sub_success,l_oodbl004,l_isaf.isaf017,l_isaf.isaf018,l_oodb011
      END IF
      #160707-00023#1 add end---
      
      SELECT isak008,isak009,isak010,isak011,isak012
        INTO l_isaf.isaf022,l_isaf.isaf023,l_isaf.isaf024,l_isaf.isaf025,l_isaf.isaf026
        FROM isak_t
       WHERE isakent = g_enterprise
         AND isak001 = l_isaf.isaf002
         AND isak002 = g_ooef019
         AND isakstus = 'Y'
      
      #150730-00006#1-----s
      #稅務編號處理(isaf022)
      #國別為台灣的處理
      IF g_isai.isai008 = 'TW' THEN
         #isaf022 用pmaa003
         LET l_pmaa003 = NULL
         SELECT pmaa003 INTO l_pmaa003
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_isaf.isaf002
            AND pmaastus = 'Y'
         LET l_isaf.isaf022 = l_pmaa003
      ELSE
         #isaf022 用isak008(aisi020)
      END IF
      #150730-00006#1-----e
      
      #lc_param.l_site得開票部門對外全稱 ooefl005
      SELECT ooefl004 INTO l_isaf.isaf027 FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = l_isaf.isafcomp
         AND ooefl002 = g_dlang
      
      #151209-00019#2-----s
      #SELECT isao001,isao002,isao003,isao004,isao005
      #  INTO l_isaf.isaf028,l_isaf.isaf029,l_isaf.isaf030,l_isaf.isaf031,l_isaf.isaf032
      #  FROM isao_t
      # WHERE isaoent = g_enterprise
      #   AND isaosite = l_isaf.isafcomp
      #   AND isaostus = 'Y'
      SELECT isao002,isao003,isao004,isao005
        INTO l_isaf.isaf029,l_isaf.isaf030,l_isaf.isaf031,l_isaf.isaf032
        FROM isao_t
       WHERE isaoent = g_enterprise
         AND isaosite = l_isaf.isafcomp
         AND isaostus = 'Y'
      SELECT ooef002 INTO l_isaf.isaf028
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
      #151209-00019#2-----e
      LET l_isaf.isaf039 = g_today
      LET l_isaf.isaf040 = cl_get_time()
      LET l_isaf.isaf041 = g_user
      LET l_isaf.isaf044   = 0 
      SELECT ooef002 INTO l_isaf.isaf046 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
      LET l_isaf.isaf050   = 0
      LET l_isaf.isaf051   = lc_param.l_book
      LET l_isaf.isaf052   = lc_param.l_site
      #albireo 151021-----s
      #內銷銷退  外銷出貨銷退
      #不會啟用發票簿  所以site要抓原單site
      IF cl_null(l_isaf.isaf052)THEN
        #LET l_isaf.isaf052 = l_xmdk.xmdksite     #160707-00023#1 mark
         LET l_isaf.isaf052 = lc_param.l_xrcasite #160707-00023#1
      END IF
      #albireo 151021-----e
      
      #LET l_isaf.isaf053   #發票聯別  用發票類型串
      #LET l_isaf.isaf054   #課稅別    用發票類型串
      LET l_isaf.isaf055   = l_xmdk.xmdk008  #收款客戶
      
      #IF l_xmdk.xmdk000 = '6' THEN                          #151123-00013#7 mark
      #IF l_xmdk.xmdk000 = '6' OR l_xmdk.xmdk000 = '5' THEN  #151123-00013#7
      #IF l_xmdk.xmdk000 = '6' THEN         #151207-00018#2  #160707-00023#1 mark
      IF lc_param.l_toaxrtype = '2' OR l_type = '2' THEN    #160707-00023#1
         LET l_isaf.isaf056 = '2'  #出貨單1藍字發票 銷退單2紅字發票
         LET l_isaf.isaf001   = '4'
      ELSE
         LET l_isaf.isaf056 = '1'
         LET l_isaf.isaf001   = '1'
      END IF
      
      LET l_isaf.isaf057   = l_xmdk.xmdk003  #業務人員
      LET l_isaf.isaf058   = l_xmdk.xmdk010  #收款條件
      
      SELECT oodb008 INTO l_isaf.isaf054
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = l_isaf.isaf016
      
      #170103-00009#1 add ------
      IF g_isac.isac008 = '4' THEN
         LET l_isaf.isaf011 = g_master.l_isae007 CLIPPED,lc_param.l_isaf011
      ELSE
      #170103-00009#1 add end---
         #發票簿預設值
         LET l_isae007 = NULL
         SELECT isae005,isae008,isae012,isae007
           INTO l_isaf.isaf009,l_isaf.isaf010,l_isaf011,l_isae007
           FROM isae_t
          WHERE isaeent = g_enterprise
            AND isaecomp = l_isaf.isafcomp
            AND isaesite = l_isaf.isaf052
            AND isae001 = l_isaf.isaf051
            AND isae002 <= l_isaf.isaf014 AND isae003 >= l_isaf.isaf014
            AND isae004 = l_isaf.isaf008
         #albireo 160122-----s
         IF cl_null(lc_param.l_isaf011)THEN
            LET lc_param.l_isaf011 = l_isaf011
         END IF 
         
         #albireo 160606-----s
         LET l_isat004 = g_master.l_isae007 CLIPPED,lc_param.l_isaf011
         LET l_isatcnt = NULL
         SELECT COUNT(*) INTO l_isatcnt FROM isat_t
          WHERE isatent = g_enterprise
            AND isat004 = l_isat004
            AND isat025 = '11'
         IF cl_null(l_isatcnt)THEN LET l_isatcnt = 0 END IF
         IF l_isatcnt > 0 THEN
            LET lc_param.l_isaf011 = l_isaf011
         END IF
         #albireo 160606-----e
         
         LET l_isaf.isaf011 = lc_param.l_isaf011
         #albireo 160122-----e
      END IF  #170103-00009#1

      #媒申格式
      SELECT isac004,isac008 INTO l_isaf.isaf019,l_isaf.isaf053
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = l_isaf.isaf008
      
      #發票客戶帶出交易對象全名
      #SELECT pmaal004 INTO l_isaf.isaf021   #161118-00028#1 mark
      SELECT pmaal003 INTO l_isaf.isaf021    #161118-00028#1 add
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = l_isaf.isaf002
         AND pmaal002 = g_dlang
      
      LET l_isaf.isaf101   = l_xmdk.xmdk017   #匯率      #161125-00002#1 add
      
      #150904-00006#3-----s
      LET l_isaf.isaf066 = ''
      LET l_xmdo017   = NULL   #161125-00002#1 add
      
      #IF l_xmdk.xmdk042 = '2' THEN    #160707-00023#1 mark
      IF lc_param.l_xmdk042 = '2' THEN #160707-00023#1
         #取出貨單對應invoice
         #SELECT UNIQUE xmdodocno INTO l_isaf.isaf066 FROM xmdp_t ,xmdo_t    #161125-00002#1 mark
         #161125-00002#1-----s
         SELECT DISTINCT xmdodocno,xmdo017  INTO l_isaf.isaf066,l_xmdo017
           FROM xmdp_t,xmdo_t
         #161125-00002#1-----e
          WHERE xmdoent = g_enterprise
            AND xmdoent = xmdpent
            AND xmdodocno = xmdpdocno
            AND xmdp001   = l_xmdk.xmdkdocno
            AND xmdo004 ='2' #出貨單
            AND xmdostus = 'Y'
            
         IF cl_null(l_isaf.isaf066)THEN
            #取不到取出貨通知單對應invoice
            #SELECT UNIQUE xmdodocno INTO l_isaf.isaf066 FROM xmdp_t ,xmdo_t    #161125-00002#1 mark
            #161125-00002#1-----s
            SELECT DISTINCT xmdodocno,xmdo017  INTO l_isaf.isaf066,l_xmdo017
              FROM xmdp_t,xmdo_t
            #161125-00002#1-----e            
             WHERE xmdoent = g_enterprise
               AND xmdoent = xmdpent AND xmdodocno = xmdpdocno
               AND xmdp001 IN (SELECT DISTINCT xmdl001 FROM xmdl_t WHERE xmdlent = g_enterprise AND xmdldocno = l_xmdk.xmdkdocno)
               AND xmdo004 ='1' #出通單
               AND xmdostus = 'Y'
         END IF
         
         #161125-00002#1-----s
         IF NOT cl_null(l_xmdo017)THEN
            LET l_isaf.isaf101 = l_xmdo017 
         END IF
         #161125-00002#1-----e
      END IF
      #150904-00006#3-----e
      
      LET l_isaf.isaf100   = l_xmdk.xmdk016   #幣別
      #LET l_isaf.isaf101   = l_xmdk.xmdk017   #匯率      #161125-00002#1 mark
      #151022-00017#2--s
      IF lc_param.l_curr_type MATCHES '[23]' THEN
         LET l_isaf.isaf101 = ''
         LET lc_param_rate.type = '1'
         LET lc_param_rate.apca004 = l_xmdk.xmdk008
         LET lc_param_rate.sfin2009 = lc_param.l_curr_type
         LET ls_js = util.JSON.stringify(lc_param_rate)
         CALL s_fin_get_curr_rate(lc_param.l_xrcacomp,lc_param.l_xrcald,lc_param.l_docdt,l_xmdk.xmdk016,ls_js)
              RETURNING l_isaf.isaf101,l_desc,l_desc
      END IF
      #151022-00017#2--e
      LET l_isaf.isaf103   = l_xmdk.xmdk051  #發票原幣未稅金額
      LET l_isaf.isaf104   = l_xmdk.xmdk053  #發票原幣稅額
      LET l_isaf.isaf105   = l_xmdk.xmdk052  #發票原幣含稅金額
      LET l_isaf.isaf106   = 0 
      LET l_isaf.isaf107   = 0
      LET l_isaf.isaf108   = 0
      LET l_isaf.isaf113   = 0 
      LET l_isaf.isaf114   = 0
      LET l_isaf.isaf115   = 0
      LET l_isaf.isaf116   = 0
      LET l_isaf.isaf117   = 0
      LET l_isaf.isaf118   = 0
      LET l_isaf.isaf119   = 0
                                 #if  isaf054課稅別= '1' then
                                 #    應稅類金額= isaf105
                                 #    零稅類金額= 0
                                 #    免稅類金額= 0
                                 #end if
      LET l_isaf.isaf120   = 0
                                 #= if  isaf054課稅別 = '2' then
                                 #   應稅類金額= 0
                                 #   零稅類金額= isaf105
                                 #   免稅類金額= 0
                                 # end if
      LET l_isaf.isaf121   = 0
                                 #= if isaf054課稅別 = '3' then
                                 #     應稅類金額= 0
                                 #     零稅類金額= 0
                                 #     免稅類金額= isaf105
                                 # end if
      LET l_isaf.isaf122   = 0
      LET l_isaf.isaf123   = 0
      LET l_isaf.isaf124   = 0
      #產生單頭
      
      #狀態碼及modifydt等
      LET l_isaf.isafownid = g_user
      LET l_isaf.isafowndp = g_dept
      LET l_isaf.isafcrtid = g_user
      LET l_isaf.isafcrtdp = g_dept
      LET l_isaf.isafcrtdt = cl_get_current()
      LET l_isaf.isafmodid = g_user
      LET l_isaf.isafmoddt = cl_get_current()
      LET l_isaf.isafstus  = 'N'
      LET l_isaf.isaf205   = 'N'
      LET l_isaf.isaf067   = l_xmdk.xmdk047   #160802-00007#1 Add
      #161229-00019#3-----s
      IF NOT cl_null(l_isaf.isaf067)THEN
         SELECT pmak003,pmak004,pmak005 INTO l_isaf.isaf021,l_isaf.isaf022,l_isaf.isaf023
           FROM pmak_t
          WHERE pmakent = g_enterprise
            AND pmak001 = l_isaf.isaf067
      END IF
      #161229-00019#3-----e
      
     #INSERT INTO isaf_t VALUES(l_isaf.*) #161108-00017#6 mark
      #161108-00017#6 --s add
      INSERT INTO isaf_t(isafent,isafsite,isafcomp,isafdocno,isafdocdt,
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
                         isaf066,isaf067)
      VALUES(l_isaf.isafent,l_isaf.isafsite,l_isaf.isafcomp,l_isaf.isafdocno,l_isaf.isafdocdt,
             l_isaf.isaf001,l_isaf.isaf002,l_isaf.isaf003,l_isaf.isaf004,l_isaf.isaf005,
             l_isaf.isaf006,l_isaf.isaf007,l_isaf.isaf008,l_isaf.isaf009,l_isaf.isaf010,
             l_isaf.isaf011,l_isaf.isaf012,l_isaf.isaf013,l_isaf.isaf014,l_isaf.isaf015,
             l_isaf.isaf016,l_isaf.isaf017,l_isaf.isaf018,l_isaf.isaf019,l_isaf.isaf020,
             l_isaf.isaf021,l_isaf.isaf022,l_isaf.isaf023,l_isaf.isaf024,l_isaf.isaf025,
             l_isaf.isaf026,l_isaf.isaf027,l_isaf.isaf028,l_isaf.isaf029,l_isaf.isaf030,
             l_isaf.isaf031,l_isaf.isaf032,l_isaf.isaf033,l_isaf.isaf034,l_isaf.isaf035,
             l_isaf.isaf036,l_isaf.isaf037,l_isaf.isaf038,l_isaf.isaf039,l_isaf.isaf040,
             l_isaf.isaf041,l_isaf.isaf042,l_isaf.isaf043,l_isaf.isaf044,l_isaf.isaf045,
             l_isaf.isaf046,l_isaf.isaf047,l_isaf.isaf048,l_isaf.isaf049,l_isaf.isaf050,
             l_isaf.isaf051,l_isaf.isaf052,l_isaf.isaf053,l_isaf.isaf054,l_isaf.isaf055,
             l_isaf.isaf056,l_isaf.isaf057,l_isaf.isaf058,l_isaf.isaf100,l_isaf.isaf101,
             l_isaf.isaf103,l_isaf.isaf104,l_isaf.isaf105,l_isaf.isaf106,l_isaf.isaf107,
             l_isaf.isaf108,l_isaf.isaf113,l_isaf.isaf114,l_isaf.isaf115,l_isaf.isaf116,
             l_isaf.isaf117,l_isaf.isaf118,l_isaf.isaf119,l_isaf.isaf120,l_isaf.isaf121,
             l_isaf.isaf122,l_isaf.isaf123,l_isaf.isaf124,l_isaf.isaf201,l_isaf.isaf202,
             l_isaf.isaf203,l_isaf.isaf204,l_isaf.isaf205,l_isaf.isaf206,l_isaf.isaf207,
             l_isaf.isaf208,l_isaf.isaf209,l_isaf.isaf210,l_isaf.isafstus,l_isaf.isafownid,
             l_isaf.isafowndp,l_isaf.isafcrtid,l_isaf.isafcrtdp,l_isaf.isafcrtdt,l_isaf.isafmodid,
             l_isaf.isafmoddt,l_isaf.isafcnfid,l_isaf.isafcnfdt,l_isaf.isafud001,l_isaf.isafud002,
             l_isaf.isafud003,l_isaf.isafud004,l_isaf.isafud005,l_isaf.isafud006,l_isaf.isafud007,
             l_isaf.isafud008,l_isaf.isafud009,l_isaf.isafud010,l_isaf.isafud011,l_isaf.isafud012,
             l_isaf.isafud013,l_isaf.isafud014,l_isaf.isafud015,l_isaf.isafud016,l_isaf.isafud017,
             l_isaf.isafud018,l_isaf.isafud019,l_isaf.isafud020,l_isaf.isafud021,l_isaf.isafud022,
             l_isaf.isafud023,l_isaf.isafud024,l_isaf.isafud025,l_isaf.isafud026,l_isaf.isafud027,
             l_isaf.isafud028,l_isaf.isafud029,l_isaf.isafud030,l_isaf.isaf059,l_isaf.isaf060,
             l_isaf.isaf061,l_isaf.isaf062,l_isaf.isaf063,l_isaf.isaf064,l_isaf.isaf065,
             l_isaf.isaf066,l_isaf.isaf067)
      #161108-00017#6 --e add
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET r_success = FALSE
      END IF
      
      
      
      
      #產生來源明細單身
      #LET l_wc = " xmdkdocno ='",l_xmdkdocno,"' " #160707-00023#1 mark
      #160707-00023#1 add ------
      CASE
         WHEN lc_param.l_group_type = '0' OR l_type = '2'  #0:出貨單/銷退單(2:須開立發票扣抵證明單)
            LET l_wc = " xmdkdocno = '",l_xmdkdocno,"'"
         WHEN lc_param.l_group_type = '2'  #2:業務人員
            LET l_wc = " (xmdk084 <> '2'  OR xmdk084 IS NULL)",
                       " AND xmdk007 = '",l_xmdk.xmdk007,"' AND xmdk008 = '",l_xmdk.xmdk008,"'",
                       " AND xmdk009 = '",l_xmdk.xmdk009,"' AND xmdk010 = '",l_xmdk.xmdk010,"'",
                       " AND xmdk012 = '",l_xmdk.xmdk012,"' AND xmdk016 = '",l_xmdk.xmdk016,"'",
                       " AND xmdk003 = '",l_xmdk.xmdk003,"'"
                      ," AND ",lc_param.wc CLIPPED #170218 add By Reanna
         WHEN lc_param.l_group_type = '3'  #3:業務部門
            LET l_wc = " (xmdk084 <> '2'  OR xmdk084 IS NULL)",
                       " AND xmdk007 = '",l_xmdk.xmdk007,"' AND xmdk008 = '",l_xmdk.xmdk008,"'",
                       " AND xmdk009 = '",l_xmdk.xmdk009,"' AND xmdk010 = '",l_xmdk.xmdk010,"'",
                       " AND xmdk012 = '",l_xmdk.xmdk012,"' AND xmdk016 = '",l_xmdk.xmdk016,"'",
                       " AND xmdk004 = '",l_xmdk.xmdk004,"'"
                      ," AND ",lc_param.wc CLIPPED #170218 add By Reanna
         #170217-00004#1 add ------
         WHEN lc_param.l_group_type = '6'  #6:全部
            LET l_wc = " 1=1 "
         #170217-00004#1 add ------
      END CASE
      #2.是否依來源營運據點拆單
      IF lc_param.l_chk1 = "Y" THEN
         LET l_wc = l_wc," AND xmdksite = '",lc_param.l_xrcasite,"'"
      END IF
      #3.匯率選擇是1:依原單匯率
      IF lc_param.l_curr_type = '1' THEN
         LET l_wc = l_wc," AND xmdk017 = '",l_xmdk.xmdk017,"'"
      END IF
      #160707-00023#1 add end---
      CALL l_array.clear()
      LET l_array[1].chr = l_isaf.isafdocno
      LET l_array[2].chr = l_isaf.isafcomp
      CALL s_aisp320_ins_isag(l_wc,l_array)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      
      #160426-00013#3-s
      #若該出貨單有訂金發票，則須依參數來決定產生aist310是27or29
      LET l_wc = ' 1=1 '
      CALL l_array.clear()
      LET l_array[1].chr = l_xmdk.xmdkdocno
      LET l_array[2].chr = l_isaf.isafdocno
      LET l_array[3].chr = l_isaf.isafcomp
      CALL s_aisp320_ins_isag_2729(l_wc,l_array) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      ELSE
         CALL l_array.clear()
         LET l_array[1].chr = l_isaf.isafdocno
         LET l_array[2].chr = l_isaf.isafcomp
      END IF
      #160426-00013#3-e
      
      #產生發票明細 AND 歷程
      LET l_wc = ' 1=1'
      CALL l_array.clear()
      LET l_array[1].chr = l_isaf.isafdocno
      LET l_array[2].chr = l_isaf.isafcomp
      LET l_array[3].chr = lc_param.l_toaistype
      LET l_array[4].chr = lc_param.l_limit_memo
      LET l_array[5].chr = lc_param.l_book
      LET l_array[6].chr = lc_param.l_site
      LET l_array[7].chr = lc_param.l_isaf010
      LET l_array[8].chr = lc_param.l_isaf011
      CALL s_aisp320_ins_isah(l_wc,l_array)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      
      
      #150918-00001#7-----s
      #IF NOT l_xmdk.xmdk000 = '6' AND l_xmdk.xmdk042 = '2' THEN   ##151123-00013#7
      #IF NOT (l_xmdk.xmdk000 = '6' OR l_xmdk.xmdk000 = '5') AND l_xmdk.xmdk042 = '2' THEN   #151123-00013#7
      
      #161125-00002#1 mark-----s
      #IF NOT l_xmdk.xmdk000 = '6' AND l_xmdk.xmdk042 = '2' THEN    #151123-00013#7
      #   #外銷出貨   #isat用iv產生
      #   CALL l_array.clear()
      #   LET l_array[1].chr = l_isaf.isafdocno
      #   LET l_array[2].chr = l_isaf.isafcomp
      #   LET l_array[3].chr = l_xmdk.xmdkdocno
      #   CALL s_aisp320_ins_isat2(l_array)RETURNING g_sub_success
      #   IF NOT g_sub_success THEN
      #      LET r_success = FALSE
      #   END IF
      #   LET l_count = NULL
      #   SELECT COUNT(*) INTO l_count FROM isat_t
      #    WHERE isatent = g_enterprise
      #      AND isatcomp = l_isaf.isafcomp
      #      AND isatdocno = l_isaf.isafdocno
      #   IF cl_null(l_count)THEN LET l_count = 0 END IF
      #   
      #   IF r_success AND l_count > 0 THEN
      #      #檢查外銷出貨單原幣總額跟invoice原幣總額是否相同
      #      LET l_isatsum = NULL
      #      SELECT SUM(isat105) INTO l_isatsum FROM isat_t
      #       WHERE isatent = g_enterprise
      #         AND isatdocno = l_isaf.isafdocno
      #         AND isatcomp  = l_isaf.isafcomp
      #      IF cl_null(l_isatsum)THEN LET l_isatsum = 0 END IF
      #     
      #      LET l_isafsum = NULL
      #      SELECT isaf105 INTO l_isafsum FROM isaf_t
      #       WHERE isafent = g_enterprise
      #         AND isafcomp = l_isaf.isafcomp
      #         AND isafdocno = l_isaf.isafdocno
      #      IF cl_null(l_isafsum)THEN LET l_isafsum = 0 END IF
      #      
      #      IF l_isatsum <> l_isafsum THEN
      #         INITIALIZE g_errparam.* TO NULL
      #         LET g_errparam.code = 'ais-00242'
      #         LET g_errparam.extend = 'xmdkdocno =',l_xmdk.xmdkdocno
      #         LET g_errparam.popup = TRUE
      #         CALL cl_err()
      #         LET r_success = FALSE
      #      END IF
      #   END IF
      #END IF
      ##150918-00001#7-----e
      ##161125-00002#1 mark-----e
      
      #確認
      CALL s_aisp320_conf_upd(l_isaf.isafcomp,l_isaf.isafdocno)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
 
      IF r_success THEN
         #albireo 150813-----s
         #產生aist310成功會有發票號碼 把發票號碼回寫來源單
         #150930-00010#1-----s
         #LET l_isaf011 = NULL
         #SELECT isaf011 INTO l_isaf011
         #  FROM isaf_t
         # WHERE isafent = g_enterprise
         #   AND isafcomp = l_isaf.isafcomp
         #   AND isafdocno = l_isaf.isafdocno
         LET l_isaf011 = NULL
         SELECT MAX(isat004) INTO l_isaf011 FROM isat_t
          WHERE isatent = g_enterprise
            AND isatcomp = l_isaf.isafcomp
            AND isatdocno = l_isaf.isafdocno
         #150930-00010#1-----e
          
         UPDATE xmdk_t SET xmdk037 = l_isaf011
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = l_xmdkdocno
         #albireo 150813-----e
         CALL s_transaction_end('Y',0)
         #INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = 'asf-00251'
         #LET g_errparam.replace[1] = l_isaf.isafdocno
         #LET g_errparam.replace[2] = l_isaf.isafdocno
         #LET g_errparam.extend = ''
         #LET g_errparam.popup = TRUE
         #CALL cl_err()
         #CALL s_transaction_end('Y',0)   #150126-00012#1 mark
         IF cl_null(l_strno1) THEN
            LET l_strno1 = l_isaf.isafdocno
         END IF
         LET l_endno1 = l_isaf.isafdocno
         LET l_doais = l_doais + 1
         
         #拋axrp132-----s
         IF lc_param.l_chk2 = "Y" THEN  #160707-00023#1
            INITIALIZE tran_master.* TO NULL
            LET tran_master.xrcasite = lc_param.l_xrcasite
            LET tran_master.b_check1 = 'N'
            LET tran_master.b_check2 = 'N'
            LET tran_master.b_check3 = 'N'
            LET tran_master.b_check4 = 'N'
            LET tran_master.b_check5 = 'N'
            LET tran_master.b_check6 = 'N'
            LET tran_master.xrcald = lc_param.l_xrcald
            #IF l_xmdk.xmdk000 = '6' THEN
            #IF (l_xmdk.xmdk000 = '6' OR l_xmdk.xmdk000 = '5') THEN   #151123-00013#7
            IF l_xmdk.xmdk000 = '6' THEN   #151123-00013#7
               #LET tran_master.b_style  = 'axrt340'        #160426-00013#3 mark
               LET tran_master.l_isaf001  = '4'             #160426-00013#3
               LET tran_master.xrcadocno = lc_param.l_slip3 #160707-00023#1
            ELSE
               #LET tran_master.b_style  = 'axrt300'        #160426-00013#3 mark
               LET tran_master.l_isaf001  = '1'             #160426-00013#3
               LET tran_master.xrcadocno = lc_param.l_slip2 #160707-00023#1
            END IF
            #LET tran_master.xrcadocno = lc_param.l_slip2 #160707-00023#1 mark
            LET tran_master.xrcadocdt = lc_param.l_docdt
            LET tran_master.b_comb2 = '1'
            LET tran_master.b_comb1 = lc_param.l_curr_type
            LET tran_master.wc  = " isafdocno = '",l_isaf.isafdocno,"' "
            LET tran_master.xrca007 = lc_param.l_xrca007    #albireo 150826 add
            
            LET l_tran = util.JSON.stringify(tran_master) 
            INITIALIZE la_param.* TO NULL
            LET la_param.prog = 'axrp132'
            LET la_param.param[1] = l_tran
            LET la_param.background = 'Y'
            LET ls_js2 = util.JSON.stringify(la_param)
            CALL cl_cmdrun_wait(ls_js2)
            
            #取成功號
            LET l_strno = NULL
            SELECT xrcadocno INTO l_strno FROM xrca_t
             WHERE xrcaent = g_enterprise
               AND xrcald  = lc_param.l_xrcald
               AND xrca018 = l_isaf.isafdocno
            IF NOT cl_null(l_strno)THEN
               IF cl_null(l_strno2)THEN 
                  LET l_strno2 = l_strno
               END IF
               LET l_endno2 = l_strno
               #回寫整帳批序號
               IF NOT cl_null(l_xrca063)THEN
                  UPDATE xrca_t SET xrca063 = l_xrca063
                   WHERE xrcaent = g_enterprise
                     AND xrcadocno = l_strno
               END IF
               LET l_doaxr = l_doaxr + 1
            END IF
         END IF  #160707-00023#1
         #拋axrp132-----e
         
      ELSE
         CALL s_transaction_end('N',0)
         #INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = 'aap-00187'   #單據產生失敗
         #LET g_errparam.extend = ''
         #LET g_errparam.popup = TRUE
         #CALL cl_err()
      END IF
   END FOREACH
   
   #IF (l_doaxr + l_doais = 0) THEN #160707-00023#1 mark
   IF l_doais = 0 THEN              #160707-00023#1
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      IF l_doais > 0 THEN
         #顯示成功的對帳單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00379'
         LET g_errparam.replace[1] = l_strno1
         LET g_errparam.replace[2] = l_endno1
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      IF l_doaxr > 0 THEN
         #顯示成功的帳務單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00380'
         LET g_errparam.replace[1] = l_strno2
         LET g_errparam.replace[2] = l_endno2
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   CALL cl_err_collect_show()
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
   CALL aisp320_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp320.get_buffer" >}
PRIVATE FUNCTION aisp320_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_xrcasite = p_dialog.getFieldBuffer('l_xrcasite')
   LET g_master.l_xmdk042 = p_dialog.getFieldBuffer('l_xmdk042')
   LET g_master.l_group_type = p_dialog.getFieldBuffer('l_group_type')
   LET g_master.l_xrcacomp = p_dialog.getFieldBuffer('l_xrcacomp')
   LET g_master.l_xrcald = p_dialog.getFieldBuffer('l_xrcald')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
   LET g_master.l_toaxrtype = p_dialog.getFieldBuffer('l_toaxrtype')
   LET g_master.l_xmdk015 = p_dialog.getFieldBuffer('l_xmdk015')
   LET g_master.l_curr_type = p_dialog.getFieldBuffer('l_curr_type')
   LET g_master.l_slip1 = p_dialog.getFieldBuffer('l_slip1')
   LET g_master.l_docdt = p_dialog.getFieldBuffer('l_docdt')
   LET g_master.l_toaistype = p_dialog.getFieldBuffer('l_toaistype')
   LET g_master.l_slip2 = p_dialog.getFieldBuffer('l_slip2')
   LET g_master.l_slip3 = p_dialog.getFieldBuffer('l_slip3')
   LET g_master.l_xrca007 = p_dialog.getFieldBuffer('l_xrca007')
   LET g_master.l_xrca063 = p_dialog.getFieldBuffer('l_xrca063')
   LET g_master.l_site = p_dialog.getFieldBuffer('l_site')
   LET g_master.l_book = p_dialog.getFieldBuffer('l_book')
   LET g_master.l_dat_memo = p_dialog.getFieldBuffer('l_dat_memo')
   LET g_master.l_isaf010 = p_dialog.getFieldBuffer('l_isaf010')
   LET g_master.l_limit_memo = p_dialog.getFieldBuffer('l_limit_memo')
   LET g_master.l_isae007 = p_dialog.getFieldBuffer('l_isae007')
   LET g_master.l_isaf011 = p_dialog.getFieldBuffer('l_isaf011')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp320.msgcentre_notify" >}
PRIVATE FUNCTION aisp320_msgcentre_notify()
 
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
 
{<section id="aisp320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aisp320_qbeclear()
   DEFINE l_comp  LIKE ooef_t.ooef001
   DEFINE l_tran  RECORD
                  wc  STRING
                  END RECORD
   DEFINE l_sql   STRING
   DEFINE l_xmdkdocno LIKE xmdk_t.xmdkdocno
   DEFINE l_count LIKE type_t.num10
   DEFINE ls_js   STRING
   DEFINE l_sfin2009  LIKE type_t.chr1 #151012-00014#7
   
   
   INITIALIZE g_master.* TO NULL
   INITIALIZE g_xmdk.* TO NULL
   INITIALIZE g_isao.* TO NULL
   
   LET g_master.l_docdt = g_today
   LET g_master.l_toaistype = '1'
   LET g_master.l_curr_type = '1'
   LET g_master.l_toaxrtype = '1'
   
   #160707-00023#1 -s
   CALL cl_set_comp_entry("l_slip3",FALSE)
   LET g_master.l_xmdk042 = '1'     #內外銷
   LET g_master.l_group_type = '0'  #彙總條件
   LET g_master.l_chk1 = 'N'        #是否依來源營運據點拆單
   LET g_master.l_chk2 = 'N'        #是否一併產生應收帳款
   CALL cl_set_comp_visible('group_toaxr',FALSE)
   #160707-00023#1 -e
   
   #150730-00006#1-----s
   #albireo 150803-----s
   LET ls_js = g_argv[01]
   CALL util.JSON.parse(ls_js,l_tran)
   LET l_sql = "SELECT DISTINCT xmdkdocno FROM xmdk_t ",
              #" WHERE ",l_tran.wc CLIPPED #170217-00004#1 mark
               " WHERE xmdkent = ",g_enterprise," AND ",l_tran.wc CLIPPED #170217-00004#1
   PREPARE sel_xmdkp1 FROM l_sql
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,") "
   PREPARE sel_xmdkp2 FROM l_sql
   
   LET l_count = NULL
   EXECUTE sel_xmdkp2 INTO l_count
   CALL cl_set_comp_visible('group_qbe',TRUE)
   CALL cl_set_comp_entry('l_xrcasite,l_toaxrtype',TRUE)
   IF l_count > 0 THEN
      LET l_xmdkdocno = NULL
      EXECUTE sel_xmdkp1 INTO l_xmdkdocno
      
      LET g_xmdkdocno = l_xmdkdocno   #150918-00001#7 add  
      CALL aisp320_xmdtdocno_def(l_xmdkdocno)
      CALL cl_set_comp_visible('group_qbe',FALSE)
      CALL cl_set_comp_entry('l_xrcasite,l_toaxrtype',FALSE)
   ELSE
      LET g_master.l_xrcasite = g_site
   END IF
   #albireo 150803-----e

   CALL s_fin_orga_get_comp_ld(g_master.l_xrcasite) RETURNING g_sub_success,g_errno,g_master.l_xrcacomp,g_master.l_xrcald
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent =g_enterprise
      AND ooef001 = g_master.l_xrcacomp
   
   LET g_master.l_site = ''
   LET g_master.l_book = ''
   DISPLAY BY NAME g_master.l_site,g_master.l_book
   LET g_master.l_xrcald_desc = s_desc_get_ld_desc(g_master.l_xrcald)
   LET g_master.l_xrcasite_desc = s_desc_get_department_desc(g_master.l_xrcasite)
   DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcasite_desc,
                   g_master.l_xrcald
   CALL s_fin_account_center_sons_query('3',g_master.l_xrcasite,g_today,'1') 
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
   CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   
   INITIALIZE g_isai.* TO NULL
   #SELECT * INTO g_isai.* FROM isai_t    #161208-00026#28 mark
   #161208-00026#28-add(s)
   SELECT isaient,isai001,isai002,isai003,isai004,
          isai005,isaiownid,isaiowndp,isaicrtid,isaicrtdp,
          isaicrtdt,isaimodid,isaimoddt,isai006,isai007,
          isaistus,isai008,isaiud001,isaiud002,isaiud003,
          isaiud004,isaiud005,isaiud006,isaiud007,isaiud008,
          isaiud009,isaiud010,isaiud011,isaiud012,isaiud013,
          isaiud014,isaiud015,isaiud016,isaiud017,isaiud018,
          isaiud019,isaiud020,isaiud021,isaiud022,isaiud023,
          isaiud024,isaiud025,isaiud026,isaiud027,isaiud028,
          isaiud029,isaiud030  
     INTO g_isai.* 
     FROM isai_t
   #161208-00026#28-add(e)
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
   #150730-00006#1-----e
   
   #161012-00026#2 mark-----s
   ##151012-00014#7-----s
   ##依畫面上帳套所屬法人取S-FIN-2009預設匯率選項
   #CALL cl_get_para(g_enterprise,g_master.l_xrcacomp,'S-FIN-2009') RETURNING l_sfin2009
   #CASE l_sfin2009
   #     WHEN '1'  #依立帳日匯率(aooi160)
   #        LET g_master.l_curr_type = '2'
   #     WHEN '2'  #依立帳日月平均匯率(aooi170)
   #        LET g_master.l_curr_type = '3'
   #END CASE
   ##151012-00014#7-----e
   #161012-00026#2 mark-----e
   
   DISPLAY BY NAME g_master.l_docdt,g_master.l_toaistype,
                   g_master.l_site,
                   g_master.l_xrcald,
                   g_master.l_curr_type
   
   LET g_master_o.* = g_master.*
END FUNCTION

################################################################################
# Descriptions...: 出貨單號預設資料
# Memo...........:
# Usage..........: 
# Date & Author..: 150608 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp320_xmdtdocno_def(p_xmdkdocno)
   DEFINE l_prog   LIKE type_t.chr20
   DEFINE l_slip3  LIKE type_t.chr20
   DEFINE p_xmdkdocno  LIKE xmdk_t.xmdkdocno
   #albireo 150826-----s
   DEFINE l_comp   LIKE ooef_t.ooef001
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_cnt        LIKE type_t.num10
   #albireo 150826-----e
 
   
                    
   INITIALIZE g_xmdk.* TO NULL
   SELECT xmdk015,xmdk017,xmdksite,xmdk001,xmdk000,
          xmdk008   #albireo 150826 add
     INTO g_xmdk.*
     FROM xmdk_t
    WHERE xmdkent = g_enterprise
      AND xmdkdocno = p_xmdkdocno   #albireo 150803
   
   LET l_comp = NULL  #albireo 150826 add
   SELECT glaald,ooef019 ,
          glaacomp #albireo 150826 add
     INTO g_master.l_xrcald,g_ooef019,
          l_comp   #albireo 150826 add
     FROM glaa_t,ooef_t
    WHERE ooefent = glaaent 
      AND ooef017 = glaacomp
      AND glaaent = g_enterprise
      AND ooef001 = g_xmdk.xmdksite
   
   #150918-00001#7-----s
   #IF g_xmdk.xmdk000 = '6' THEN
   #IF (g_xmdk.xmdk000 = '6' OR g_xmdk.xmdk000 = '5') THEN    #151123-00013#7 
   IF g_xmdk.xmdk000 = '6' THEN   #151207-00018#2 add
      #銷退要用原單發票類型去推折單類型
      LET g_master.l_xmdk015 = NULL
      SELECT isac009 INTO g_master.l_xmdk015
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = g_xmdk.xmdk015
   ELSE
      LET g_master.l_xmdk015 = g_xmdk.xmdk015
   END IF
   #150918-00001#7-----e
   
   #LET g_master.l_site    = g_xmdk.xmdksite
   LET g_master.l_xrcasite = g_xmdk.xmdksite
   #LET g_master.l_xmdk017 = g_xmdk.xmdk017
   LET g_master.l_docdt   = g_xmdk.xmdk001
   
   INITIALIZE g_isao.* TO NULL
   SELECT isao014,isao015,isao016 
     INTO g_isao.*
     FROM isao_t
    WHERE isaoent = g_enterprise
      AND isaosite = g_xmdk.xmdksite
      

   #IF g_xmdk.xmdk000 = '6' THEN
   #IF (g_xmdk.xmdk000 = '6' OR g_xmdk.xmdk000 = '5') THEN   #151123-00013#7
   IF g_xmdk.xmdk000 = '6' THEN   #151207-00018#2 add   
      #折讓
      LET g_master.l_slip1 = g_isao.isao015
      LET l_prog = 'axrt340'
      LET g_master.l_toaxrtype = '2'
   ELSE
      #出貨
      LET g_master.l_slip1 = g_isao.isao014
      LEt l_prog = 'axrt300'
      LET g_master.l_toaxrtype = '1'
   END IF
   

      
   CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
   
   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
   CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
   CALL s_desc_get_ld_desc(g_master.l_xrcald)RETURNING g_master.l_xrcald_desc
   
   #albireo 150813-----s
   #檢核預帶的單別
   CALL cl_err_collect_init()
   CALL s_aooi200_fin_chk_docno(g_master.l_xrcald,'','',g_master.l_slip1,g_master.l_docdt,'aist310')
      RETURNING g_sub_success
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   IF NOT g_sub_success THEN
      LET g_master.l_slip1 = ''
   END IF
   #albireo 150813-----e
   DISPLAY BY NAME g_master.l_xmdk015,
                   #g_master.l_xmdk017,
                   g_master.l_docdt,
                   g_master.l_slip1,g_master.l_slip1_desc,g_master.l_xmdk015_desc,
                   g_master.l_xrcald_desc,g_master.l_xrcald,
                   g_master.l_site,g_master.l_site_desc
   CALL s_aooi200_get_slip(p_xmdkdocno)RETURNING g_sub_success,l_slip3   #alberr
#   CALL s_aooi210_get_doc(g_xmdk.xmdksite,'','2',l_slip3,l_prog,'Y')
#      RETURNING g_sub_success,g_master.l_slip2

   #albireo 150823-----s
   CALL s_aooi100_sel_ooef004(g_xmdk.xmdksite) RETURNING g_sub_success,l_ooef004
   CALL s_aooi210_set_chk(l_slip3,l_prog,l_ooef004,l_ooef004,'1')RETURNING l_cnt

   IF l_cnt > 0 THEN
      CALL s_aooi210_get_doc(g_xmdk.xmdksite,'','2',l_slip3,l_prog,'Y')  
         RETURNING g_sub_success,g_master.l_slip2
   END IF
   #albireo 150823-----e  
   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc
   DISPLAY BY NAME g_master.l_slip2_desc,g_master.l_slip2
   
   INITIALIZE g_isai.* TO NULL
   #SELECT * INTO g_isai.* FROM isai_t   #161208-00026#28 mark
   #161208-00026#28-add(s)
   SELECT isaient,isai001,isai002,isai003,isai004,
          isai005,isaiownid,isaiowndp,isaicrtid,isaicrtdp,
          isaicrtdt,isaimodid,isaimoddt,isai006,isai007,
          isaistus,isai008,isaiud001,isaiud002,isaiud003,
          isaiud004,isaiud005,isaiud006,isaiud007,isaiud008,
          isaiud009,isaiud010,isaiud011,isaiud012,isaiud013,
          isaiud014,isaiud015,isaiud016,isaiud017,isaiud018,
          isaiud019,isaiud020,isaiud021,isaiud022,isaiud023,
          isaiud024,isaiud025,isaiud026,isaiud027,isaiud028,
          isaiud029,isaiud030  
     INTO g_isai.* 
     FROM isai_t
   #161208-00026#28-add(e)
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
      
   INITIALIZE g_isaq.* TO NULL
   #SELECT * INTO g_isaq.* FROM isaq_t     #161208-00026#28 mark
   #161208-00026#28-add(s)
   SELECT isaqent,isaqsite,isaq001,isaq002,isaq003,
          isaq004,isaq005,isaqstus,isaqud001,isaqud002,
          isaqud003,isaqud004,isaqud005,isaqud006,isaqud007,
          isaqud008,isaqud009,isaqud010,isaqud011,isaqud012,
          isaqud013,isaqud014,isaqud015,isaqud016,isaqud017,
          isaqud018,isaqud019,isaqud020,isaqud021,isaqud022,
          isaqud023,isaqud024,isaqud025,isaqud026,isaqud027,
          isaqud028,isaqud029,isaqud030 
     INTO g_isaq.* 
     FROM isaq_t
   #161208-00026#28-add(e)
    WHERE isaqent = g_enterprise
     #AND isaqsite = g_master.l_site       #160707-00023#1 mark
      AND isaqsite = g_master.l_xrcasite   #160707-00023#1
      AND isaq001 = g_master.l_xmdk015
      
   INITIALIZE g_isac.* TO NULL
   #SELECT * INTO g_isac.*                 #161208-00026#28 mark
   #161208-00026#28-add(s)
   SELECT isacent,isacownid,isacowndp,isaccrtid,isaccrtdp,
          isaccrtdt,isacmodid,isacmoddt,isacstus,isac001,
          isac002,isac003,isac004,isac005,isac006,
          isac007,isac008,isac009,isac010,isac011,
          isac012,isacud001,isacud002,isacud003,isacud004,
          isacud005,isacud006,isacud007,isacud008,isacud009,
          isacud010,isacud011,isacud012,isacud013,isacud014,
          isacud015,isacud016,isacud017,isacud018,isacud019,
          isacud020,isacud021,isacud022,isacud023,isacud024,
          isacud025,isacud026,isacud027,isacud028,isacud029,
          isacud030 
     INTO g_isac.*
   #161208-00026#28-add(e)
     FROM isac_t
    WHERE isacent = g_enterprise
      AND isac001 = g_ooef019
      AND isac002 = g_master.l_xmdk015
   CALL aisp320_visible()
   
   #albireo 150826-----s
   

   #albireo 150825-----s
   
   CALL s_apmm101_sel_pmab(l_comp,g_xmdk.xmdk008,'pmab105') RETURNING g_sub_success,g_errno,g_master.l_xrca007
   CALL s_desc_get_acc_desc('3111',g_master.l_xrca007) RETURNING g_master.l_xrca007_desc
   DISPLAY BY NAME g_master.l_xrca007_desc,g_master.l_xrca007
   #albireo 150826-----e
   
   LET g_master_o.* = g_master.*
END FUNCTION

PRIVATE FUNCTION aisp320_site_with_book_chk(p_site,p_book,p_dat,p_type)
   DEFINE p_site   LIKE ooef_t.ooef001
   DEFINE p_book   LIKE isae_t.isae001
   DEFINE p_dat    LIKE type_t.dat
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE l_count   LIKE type_t.num10
   DEFINE l_ooef017 LIKE ooef_t.ooef017
   DEFINE p_type    LIKE xmdk_t.xmdk015
   DEFINE l_isae012 LIKE isae_t.isae012
   DEFINE l_prog    LIKE type_t.chr20   #160413-00033#1
   
   #160413-00033#1-----e
   IF g_isai.isai002 = '1' THEN
      LET l_prog = 'aisi055'
   ELSE
      LET l_prog = 'aisi050'
   END IF
   #160413-00033#1-----e
   
   LET r_success = TRUE
   LET r_errno  =''
   
   #160712-00013#2-----s
   IF NOT cl_null(p_site)
      AND NOT cl_null(p_type)THEN
      #該據點不允許開立該類型發票,請檢查營運據點開立發票設定(aisi090)
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM isaq_t
       WHERE isaqent = g_enterprise
         AND isaqsite = p_site
         AND isaq001  = p_type
      #  AND isaqstus = 'Y'   #系統中無使用此欄位
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_errno ='ais-00345'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
   END IF
   #160712-00013#2-----e
   
   IF NOT cl_null(p_site) 
      AND NOT cl_null(p_book)
      AND NOT cl_null(p_dat)
      AND NOT cl_null(p_type)THEN
      LET l_ooef017 = NULL
      SELECT ooef017 INTO l_ooef017 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_site
      
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM isae_t
       WHERE isaeent = g_enterprise
         AND isaesite IN (p_site,l_ooef017) 
         AND isae001  = p_book
         AND isae002 <= p_dat
         AND isae003 >= p_dat
         AND isae004 = p_type
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_errno ='ais-00144'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      
      #160413-00033#1-----s
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM isae_t
       WHERE isaeent = g_enterprise
         AND isaesite IN (p_site,l_ooef017) 
         AND isae001  = p_book
         AND isae002 <= p_dat
         AND isae003 >= p_dat
         AND isae004 = p_type
         #AND isae019 = l_prog   #albireo 160601 mark
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         IF g_isai.isai002 = '1' THEN
            LET r_errno ='ais-00278'
            LET r_success = FALSE
            RETURN r_success,r_errno
         ELSE
            LET r_errno ='ais-00030'
            LET r_success = FALSE
            RETURN r_success,r_errno
         END IF
      END IF
      #160413-00033#1-----e
      
     SELECT isae012
       INTO l_isae012
       FROM isae_t           
      WHERE isaeent = g_enterprise
        AND isaesite IN (p_site,l_ooef017) 
        AND isae001  = p_book
        AND isae002 <= p_dat
        AND isae003 >= p_dat
        AND isae004 = p_type
        
      IF cl_null(l_isae012)THEN
         LET r_errno = 'ais-00234'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION aisp320_visible()
DEFINE l_xmdk042   LIKE xmdk_t.xmdk042  #150918-00001#7
   
   CALL cl_set_comp_visible('l_isaf010',TRUE)
   CALL cl_set_comp_visible('l_isae007',TRUE)      #160517-00005#1
   IF g_isai.isai002 = '1' THEN
      CALL cl_set_comp_visible('l_isaf010',FALSE)
   ELSE
      CALL cl_set_comp_visible('l_isae007',FALSE)  #160517-00005#1
   END IF
   CALL cl_set_comp_visible('group_book',TRUE)
   #170103-00009#1 add(s)
   CALL cl_set_comp_entry('l_site',TRUE)
   CALL cl_set_comp_entry('l_book',TRUE)
   CALL cl_set_comp_entry('l_isae007',TRUE)
   CALL cl_set_comp_required("l_isae007",TRUE)
   IF g_isac.isac008 = '4' THEN
      CALL cl_set_comp_entry('l_site',FALSE)
      CALL cl_set_comp_entry('l_book',FALSE)
      IF g_isai.isai002 = '2' THEN
         CALL cl_set_comp_entry('l_isae007',FALSE)
         CALL cl_set_comp_required("l_isae007",FALSE)
      END IF
   ELSE
      CALL cl_set_comp_entry('l_isae007',FALSE)
      CALL cl_set_comp_required("l_isae007",FALSE)
   #170103-00009#1 add(e)
      IF g_isac.isac003 = '4' THEN  #發票類型為銷項折單
         IF g_isai.isai006 = 'N' THEN   #紅字發票與藍字發票共用發票簿
            CALL cl_set_comp_visible('group_book',FALSE)
         END IF
      END IF
      #160707-00023#1 -s
      #發票簿條件依據 aisi090 isaq005=1:列印時回寫>>隱藏/2:產生時回寫>>顯示
      IF g_isaq.isaq005 = '1' THEN
         CALL cl_set_comp_visible('group_book',FALSE)
      END IF
      #160707-00023#1 -e
   END IF #170103-00009#1 add
   #161125-00002#1 mark-----s
   ##150918-00001#7-----s
   ##外銷就不開發票簿了
   ##因此次修改都改用iv no
   #IF NOT cl_null(g_xmdkdocno)THEN
   #   LET l_xmdk042 = NULL
   #   SELECT xmdk042 INTO l_xmdk042 
   #     FROM xmdk_t
   #    WHERE xmdkent = g_enterprise
   #      AND xmdkdocno = g_xmdkdocno
   #      
   #   IF l_xmdk042 = '2' THEN
   #      CALL cl_set_comp_visible('group_book',FALSE)
   #   END IF
   #END IF
   ##150918-00001#7-----e
   #161125-00002#1 mark-----e
   
END FUNCTION

PRIVATE FUNCTION aisp320_ooef001_chk(p_ooef001)
   DEFINE p_ooef001   LIKE ooef_t.ooef001
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_stus      LIKE type_t.chr1
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooef017   LIKE ooef_t.ooef017  #170113-00024#1
   
   LET r_success = TRUE
   LET r_errno  = ''
   LET l_stus = NULL
   #SELECT ooefstus FROM ooef_t #170113-00024#1 mark
   #170113-00024#1 add ------
   SELECT ooef017,ooefstus INTO l_ooef017,l_stus
     FROM ooef_t
   #170113-00024#1 add end---
    WHERE ooefent = g_enterprise
      AND ooef001 = p_ooef001
   
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno  = 'aoo-00094'
         LET r_success = FALSE
      WHEN l_stus <> 'Y'
         LET r_errno = 'axc-00105'
         LET r_success = FALSE
      #170113-00024#1 add ------
      WHEN l_ooef017 <> g_master.l_xrcacomp
         LET r_errno = 'axr-00122'
         LET r_success = FALSE
      #170113-00024#1 add ------
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION aisp320_book_exist(p_dat,p_type)
 DEFINE p_site   LIKE ooef_t.ooef001
   DEFINE p_book   LIKE isae_t.isae001
   DEFINE p_dat    LIKE type_t.dat
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE l_count   LIKE type_t.num10
   DEFINE l_ooef017 LIKE ooef_t.ooef017
   DEFINE p_type    LIKE xmdk_t.xmdk015
   DEFINE l_isae012 LIKE isae_t.isae012
   
   LET r_success = TRUE
   LET r_errno  =''
         
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM isae_t
    WHERE isaeent = g_enterprise
      AND isae002 <= p_dat
      AND isae003 >= p_dat
      AND isae004 = p_type
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_errno ='ais-00284'
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

#end add-point
 
{</section>}
 
