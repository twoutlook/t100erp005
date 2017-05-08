#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0060(2017-02-15 17:53:54), PR版次:0060(2017-04-21 16:32:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000826
#+ Filename...: axmt520
#+ Description: 出貨通知單維護作業
#+ Creator....: 04441(2014-02-26 16:51:19)
#+ Modifier...: 08992 -SD/PR- TOPSTD
 
{</section>}
 
{<section id="axmt520.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151208-00018#1   2015/12/09 By earl      修改銷售替代料元件
#151224-00025#5   2015/12/28 By dorishsu  產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#151210-00009#1   2015/12/30 By earl      多角流水號一致時，開窗、校驗調整
#150721-00001#1   2016/01/08 By earl      控制組過濾、單據別與客戶預設資料調整
#160119-00015#1   2016/01/20 By dorislai  嘜頭編號欄位開窗改用「收貨客戶」篩選
#160314-00008#1   2016/03/16 By catmoon   批/序號3:不控管時,修改儲位/批號時沒有更新到inao_t
#160316-00007#4   2016/03/17 By xianghui  库存管理特征需增加制造批序号的处理逻辑
#160324-00021#1   2016/03/24 By Sarah     訂單單號、項次、項序、分批序也應該考慮修改前後不同時回寫訂單的狀況
#160314-00009#3   2016/03/28 By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#150720-00006#1   2016/03/29 By earl      補上單頭確認詢問自動帶單身功能
#160318-00005#46  2016/04/01 By pengxin   修正azzi920重复定义之错误讯息
#160318-00025#15  2016/04/06 BY 07900     重复错误讯息的修改
#160408-00035#4   2016/04/15 By Sarah     如果訂單有做硬備置，那麼出通單產生單身資料的時候，要自動帶出備置的庫儲批與數量
#160325-00002#1   2016/05/30 By shiun     修改參考數量是否輸入判斷方式(imaf015換成單身參考單位是否有值xmdh018)
#160519-00008#9   2016/07/19 By 02097     单据上库存管理特征栏位依依料件设定控管
#160510-00043#2   2016/07/25 By 02097     T類作業在browser_fill()組SQL前,呼叫s_aooi200_filter_slip將回傳條件組進去g_wc中
#160804-00027#1   2016/08/04 By 00768     修正当料件库存中有特征和库存管理特征的时候，仓库开窗开不出资料的问题
#160805-00052#1   2016/08/05 By 00768     修正在库存足的情况下，若单身明细中有使用库存管理特征，则总会提示提示：库存-在拣量后，库存不足的问题
#160818-00017#43  2016/08/26 By lixh      单据类作业修改，删除时需重新检查状态
#160902-00048#2   2016/09/06 By 02097      針對SQL的WHERE條件中缺少ent的清單做補強
#161011-00017#1   2016/10/13 By dorislai  輸入完資料後，重新計算尾差
#161102-00022#1   2016/11/02 By fionchen  取消出通單的在檢量檢核
#161025-00028#1   2016/11/07 By catmoon47 多倉儲批彈窗只有一筆時，須將倉儲批資料回寫g_xmdh_d_o
#161026-00025#3   2016/11/10 By Whitney   在呼叫v_pmao004前,增加一行轉換錯誤訊息apm-00260改為使用axm-00053
#161124-00053#1   2016/11/25 By ouhz      调整有订单转出通单，单身录入费用料号后，存盘闪退问题
#161027-00035#1   2016/11/28 By Whitney   參數設定多角單據自動拋轉時，如拋轉未成功，彈出錯誤訊息，並將單據資料一併還原
#161129-00035#1   2016/11/2  By ouhz      1.调整限定批号有值后，库位开窗只显示限定批号库存,2.手动输入批号后，去掉检查是否存在库存明细档中
#161205-00025#9   2016/12/15 By lori      效能調整
#161207-00033#35  2016/12/23 By 08992     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#170106-00020#1   2017/01/06 By 08993     1.若料件編號為空時,則不需要做費用料號預帶欄位的處理,2.費用料號的檢驗否(xmdh022)應預設為N
#170110-00003#1   2017/01/10 By ouhz      调整单身输入订单单号后没有带出客户订单编号信息
#170111-00002#1   2017/01/11 By ouhz      调整170110-00003#1 条件给值问题
#161221-00064#16  2017/01/10 By zhujing   增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#170116-00044#1   2017/01/17 By dorislai  若有費用性的資料，不需控卡單身訂單單號
#170117-00047#1   2017/01/18 By catmoon47 單身倉儲批的開窗應與出貨單(axmt540)一樣
#170119-00008#2   2017/01/20 By 08171     1.新增时，部门开窗和手动输入检核不一致，开窗开不出其他法人归属的部门，但手动输入提交OK
#                                         2.新增时，单头“出通单号”栏位开窗会带出流通分销出货通知单
#                                         3.新增时，单头“订单单号”栏位开窗会带出流通分销订单
#                                         4.新增时，单身已经输入订单单号，则单身“料件编号”栏位应只开窗带出显示该笔订单对应的料件编号或替代料信息提供开窗，目前开出所有的料件编号，选择后再提示无替代关系不符合对应订单单号的检核
#                                         5.單身訂單單號也要過濾跳流通的單據別
#170202-00011#1   2017/02/06 By Ann_Huang 修正取得費用料號單價應由訂單的預估金額(xmds004)帶入
#170202-00033#1   2017/02/03 By dorishsu  費用性的資料，不需檢核修改後單價的合理性
#161031-00025#25  2017/02/06 By 08992     1.將aooi360_01以嵌入的方式，用頁籤放在axmt520單頭多帳期頁籤與異動資訊頁籤中間
#                                           要可修改
#                                           控制類型 =3:內部資訊傳遞 取消不要了
#                                           項次固定寫入0
#                                         2.原axmt520的備註action，改為確認後可執行，直接修改單頭新的"備註"頁籤
#                                         3.axmt520單身最後面增加顯示"長備註"欄位，一樣抓取aooi360的備註顯示
#                                           項次 = 單身項次
#                                           控制類型 = 列印在後
#170401-00018#1   2017/4/7 By chenssz     更改开窗对单据别参数的管控，将ooac004 ='Y'改为ooac004 ='Y' or ooac004 is null
#170421-00006#1   2017/04/21 By ouhz      调整aics010设置参数E-BAS-0018='Y'时,新增订单单号栏位开窗报-217错误问题

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL sub_s_lot
IMPORT FGL aoo_aooi360_01   #161031-00025#25
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
#161031-00025#25-s
GLOBALS
TYPE type_g_ooff_d        RECORD
       ooff001 LIKE ooff_t.ooff001, 
   ooff002 LIKE ooff_t.ooff002, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff013 LIKE ooff_t.ooff013, 
   ooff014 LIKE ooff_t.ooff014
       END RECORD
 
DEFINE g_ooff_d4          DYNAMIC ARRAY OF type_g_ooff_d

DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
DEFINE g_wc2_i36001      STRING             #备注单身QBE條件
DEFINE g_d_idx_i36001    LIKE type_t.num5   #备注单身所在筆數
DEFINE g_d_cnt_i36001    LIKE type_t.num5   #备注单身總筆數
DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
DEFINE g_ooff001_d       LIKE ooff_t.ooff001
DEFINE g_ooff002_d       LIKE ooff_t.ooff002
DEFINE g_ooff003_d       LIKE ooff_t.ooff003
DEFINE g_ooff004_d       LIKE ooff_t.ooff004
DEFINE g_ooff005_d       LIKE ooff_t.ooff005
DEFINE g_ooff006_d       LIKE ooff_t.ooff006
DEFINE g_ooff007_d       LIKE ooff_t.ooff007
DEFINE g_ooff008_d       LIKE ooff_t.ooff008
DEFINE g_ooff009_d       LIKE ooff_t.ooff009
DEFINE g_ooff010_d       LIKE ooff_t.ooff010
DEFINE g_ooff011_d       LIKE ooff_t.ooff011
END GLOBALS
#161031-00025#25-e
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xmdg_m        RECORD
       xmdgdocno LIKE xmdg_t.xmdgdocno, 
   xmdgdocno_desc LIKE type_t.chr80, 
   xmdgdocdt LIKE xmdg_t.xmdgdocdt, 
   xmdg004 LIKE xmdg_t.xmdg004, 
   xmdgsite LIKE xmdg_t.xmdgsite, 
   xmdg002 LIKE xmdg_t.xmdg002, 
   xmdg002_desc LIKE type_t.chr80, 
   xmdg003 LIKE xmdg_t.xmdg003, 
   xmdg003_desc LIKE type_t.chr80, 
   xmdgstus LIKE xmdg_t.xmdgstus, 
   xmdg001 LIKE xmdg_t.xmdg001, 
   xmdg034 LIKE xmdg_t.xmdg034, 
   xmdg005 LIKE xmdg_t.xmdg005, 
   xmdg005_desc LIKE type_t.chr80, 
   xmdg006 LIKE xmdg_t.xmdg006, 
   xmdg006_desc LIKE type_t.chr80, 
   xmdg007 LIKE xmdg_t.xmdg007, 
   xmdg007_desc LIKE type_t.chr80, 
   xmdg202 LIKE xmdg_t.xmdg202, 
   xmdg202_desc LIKE type_t.chr80, 
   xmdg028 LIKE xmdg_t.xmdg028, 
   xmdg026 LIKE xmdg_t.xmdg026, 
   xmdg026_desc LIKE type_t.chr80, 
   xmdg027 LIKE xmdg_t.xmdg027, 
   xmdg027_desc LIKE type_t.chr80, 
   xmdg024 LIKE xmdg_t.xmdg024, 
   xmdg025 LIKE xmdg_t.xmdg025, 
   xmdg030 LIKE xmdg_t.xmdg030, 
   xmdg030_desc LIKE type_t.chr80, 
   xmdg031 LIKE xmdg_t.xmdg031, 
   xmdg031_desc LIKE type_t.chr80, 
   xmdg053 LIKE xmdg_t.xmdg053, 
   xmdg056 LIKE xmdg_t.xmdg056, 
   xmdg056_desc LIKE type_t.chr80, 
   xmdg055 LIKE xmdg_t.xmdg055, 
   xmdg054 LIKE xmdg_t.xmdg054, 
   xmdg057 LIKE xmdg_t.xmdg057, 
   xmdg058 LIKE xmdg_t.xmdg058, 
   xmdg017 LIKE xmdg_t.xmdg017, 
   xmdg017_desc LIKE type_t.chr80, 
   textedit1 LIKE type_t.chr500, 
   xmdg018 LIKE xmdg_t.xmdg018, 
   xmdg018_desc LIKE type_t.chr80, 
   xmdg019 LIKE xmdg_t.xmdg019, 
   xmdg019_desc LIKE type_t.chr80, 
   xmdg020 LIKE xmdg_t.xmdg020, 
   xmdg020_desc LIKE type_t.chr80, 
   xmdg016 LIKE xmdg_t.xmdg016, 
   xmdg016_desc LIKE type_t.chr80, 
   xmdg021 LIKE xmdg_t.xmdg021, 
   xmdg022 LIKE xmdg_t.xmdg022, 
   xmdg023 LIKE xmdg_t.xmdg023, 
   xmdg023_desc LIKE type_t.chr80, 
   xmdg008 LIKE xmdg_t.xmdg008, 
   xmdg008_desc LIKE type_t.chr80, 
   xmdg009 LIKE xmdg_t.xmdg009, 
   xmdg009_desc LIKE type_t.chr80, 
   xmdg010 LIKE xmdg_t.xmdg010, 
   xmdg010_desc LIKE type_t.chr80, 
   xmdg011 LIKE xmdg_t.xmdg011, 
   xmdg012 LIKE xmdg_t.xmdg012, 
   xmdg013 LIKE xmdg_t.xmdg013, 
   xmdg013_desc LIKE type_t.chr80, 
   xmdg032 LIKE xmdg_t.xmdg032, 
   xmdg033 LIKE xmdg_t.xmdg033, 
   xmdg014 LIKE xmdg_t.xmdg014, 
   xmdg014_desc LIKE type_t.chr80, 
   xmdg015 LIKE xmdg_t.xmdg015, 
   xmdgownid LIKE xmdg_t.xmdgownid, 
   xmdgownid_desc LIKE type_t.chr80, 
   xmdgowndp LIKE xmdg_t.xmdgowndp, 
   xmdgowndp_desc LIKE type_t.chr80, 
   xmdgcrtid LIKE xmdg_t.xmdgcrtid, 
   xmdgcrtid_desc LIKE type_t.chr80, 
   xmdgcrtdp LIKE xmdg_t.xmdgcrtdp, 
   xmdgcrtdp_desc LIKE type_t.chr80, 
   xmdgcrtdt LIKE xmdg_t.xmdgcrtdt, 
   xmdgmodid LIKE xmdg_t.xmdgmodid, 
   xmdgmodid_desc LIKE type_t.chr80, 
   xmdgmoddt LIKE xmdg_t.xmdgmoddt, 
   xmdgcnfid LIKE xmdg_t.xmdgcnfid, 
   xmdgcnfid_desc LIKE type_t.chr80, 
   xmdgcnfdt LIKE xmdg_t.xmdgcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdh_d        RECORD
       xmdhsite LIKE type_t.chr10, 
   xmdhseq LIKE xmdh_t.xmdhseq, 
   xmdh001 LIKE xmdh_t.xmdh001, 
   xmdh002 LIKE xmdh_t.xmdh002, 
   xmdh003 LIKE xmdh_t.xmdh003, 
   xmdh004 LIKE xmdh_t.xmdh004, 
   xmda033 LIKE type_t.chr500, 
   xmdh005 LIKE xmdh_t.xmdh005, 
   xmdh006 LIKE xmdh_t.xmdh006, 
   xmdh006_desc LIKE type_t.chr500, 
   xmdh006_desc_desc LIKE type_t.chr500, 
   xmdh007 LIKE xmdh_t.xmdh007, 
   xmdh007_desc LIKE type_t.chr500, 
   xmdh034 LIKE xmdh_t.xmdh034, 
   xmdh034_desc LIKE type_t.chr500, 
   xmdh034_desc_desc LIKE type_t.chr500, 
   xmdh009 LIKE xmdh_t.xmdh009, 
   xmdh009_desc LIKE type_t.chr500, 
   xmdh010 LIKE xmdh_t.xmdh010, 
   xmdh015 LIKE xmdh_t.xmdh015, 
   xmdh015_desc LIKE type_t.chr500, 
   xmdh016 LIKE xmdh_t.xmdh016, 
   xmdh017 LIKE xmdh_t.xmdh017, 
   xmdh018 LIKE xmdh_t.xmdh018, 
   xmdh018_desc LIKE type_t.chr500, 
   xmdh019 LIKE xmdh_t.xmdh019, 
   xmdh008 LIKE xmdh_t.xmdh008, 
   xmdh011 LIKE xmdh_t.xmdh011, 
   xmdh012 LIKE xmdh_t.xmdh012, 
   xmdh012_desc LIKE type_t.chr500, 
   xmdh013 LIKE xmdh_t.xmdh013, 
   xmdh013_desc LIKE type_t.chr500, 
   xmdh014 LIKE xmdh_t.xmdh014, 
   xmdh029 LIKE xmdh_t.xmdh029, 
   xmdh020 LIKE xmdh_t.xmdh020, 
   xmdh020_desc LIKE type_t.chr500, 
   xmdh021 LIKE xmdh_t.xmdh021, 
   xmdh022 LIKE xmdh_t.xmdh022, 
   xmdh036 LIKE xmdh_t.xmdh036, 
   xmdh031 LIKE xmdh_t.xmdh031, 
   xmdh031_desc LIKE type_t.chr500, 
   xmdh032 LIKE xmdh_t.xmdh032, 
   xmdh032_desc LIKE type_t.chr500, 
   xmdh033 LIKE xmdh_t.xmdh033, 
   xmdh033_desc LIKE type_t.chr500, 
   xmdh050 LIKE xmdh_t.xmdh050, 
   xmdh056 LIKE xmdh_t.xmdh056, 
   xmdh030 LIKE xmdh_t.xmdh030, 
   xmdh051 LIKE xmdh_t.xmdh051, 
   xmdh052 LIKE xmdh_t.xmdh052, 
   xmdhunit LIKE xmdh_t.xmdhunit, 
   xmdh035 LIKE xmdh_t.xmdh035, 
   ooff013 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmdh2_d RECORD
       xmdisite LIKE xmdi_t.xmdisite, 
   xmdiseq LIKE xmdi_t.xmdiseq, 
   xmdiseq1 LIKE xmdi_t.xmdiseq1, 
   xmdi001 LIKE xmdi_t.xmdi001, 
   xmdi001_desc LIKE type_t.chr500, 
   xmdi001_desc_desc LIKE type_t.chr500, 
   xmdi002 LIKE xmdi_t.xmdi002, 
   xmdi002_desc LIKE type_t.chr500, 
   xmdi003 LIKE xmdi_t.xmdi003, 
   xmdi003_desc LIKE type_t.chr500, 
   xmdi004 LIKE xmdi_t.xmdi004, 
   xmdi005 LIKE xmdi_t.xmdi005, 
   xmdi005_desc LIKE type_t.chr500, 
   xmdi006 LIKE xmdi_t.xmdi006, 
   xmdi006_desc LIKE type_t.chr500, 
   xmdi007 LIKE xmdi_t.xmdi007, 
   xmdi013 LIKE xmdi_t.xmdi013, 
   xmdi008 LIKE xmdi_t.xmdi008, 
   xmdi008_desc LIKE type_t.chr500, 
   xmdi009 LIKE xmdi_t.xmdi009, 
   xmdi010 LIKE xmdi_t.xmdi010, 
   xmdi010_desc LIKE type_t.chr500, 
   xmdi011 LIKE xmdi_t.xmdi011, 
   xmdi012 LIKE xmdi_t.xmdi012
       END RECORD
PRIVATE TYPE type_g_xmdh4_d RECORD
       xmdhseq LIKE xmdh_t.xmdhseq, 
   xmdh0011 LIKE type_t.chr20, 
   xmdh0021 LIKE type_t.num10, 
   xmdh0031 LIKE type_t.num10, 
   xmdh0041 LIKE type_t.num10, 
   xmdh0051 LIKE type_t.chr10, 
   xmdh0061 LIKE type_t.chr500, 
   xmdh0061_desc LIKE type_t.chr500, 
   xmdh0061_desc_desc LIKE type_t.chr500, 
   xmdh0071 LIKE type_t.chr500, 
   xmdh0071_desc LIKE type_t.chr500, 
   xmdh0091 LIKE type_t.chr10, 
   xmdh0091_desc LIKE type_t.chr500, 
   xmdh0101 LIKE type_t.chr10, 
   xmdh0151 LIKE type_t.chr10, 
   xmdh0151_desc LIKE type_t.chr500, 
   xmdh0161 LIKE type_t.num20_6, 
   xmdh0201 LIKE type_t.chr10, 
   xmdh0201_desc LIKE type_t.chr500, 
   xmdh0211 LIKE type_t.num20_6, 
   xmdh023 LIKE xmdh_t.xmdh023, 
   xmdh024 LIKE xmdh_t.xmdh024, 
   xmdh024_desc LIKE type_t.chr500, 
   xmdh025 LIKE xmdh_t.xmdh025, 
   xmdh026 LIKE xmdh_t.xmdh026, 
   xmdh027 LIKE xmdh_t.xmdh027, 
   xmdh028 LIKE xmdh_t.xmdh028
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xmdgdocno LIKE xmdg_t.xmdgdocno,
      b_xmdgdocdt LIKE xmdg_t.xmdgdocdt,
      b_xmdg002 LIKE xmdg_t.xmdg002,
   b_xmdg002_desc LIKE type_t.chr80,
      b_xmdg003 LIKE xmdg_t.xmdg003,
   b_xmdg003_desc LIKE type_t.chr80,
      b_xmdg004 LIKE xmdg_t.xmdg004,
      b_xmdg005 LIKE xmdg_t.xmdg005,
   b_xmdg005_desc LIKE type_t.chr80,
      b_xmdg006 LIKE xmdg_t.xmdg006,
   b_xmdg006_desc LIKE type_t.chr80,
      b_xmdg007 LIKE xmdg_t.xmdg007,
   b_xmdg007_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_inam                DYNAMIC ARRAY OF RECORD   #記錄產品特徵
         inam001             LIKE inam_t.inam001,
         inam002             LIKE inam_t.inam002,
         inam004             LIKE inam_t.inam004
                             END RECORD
DEFINE g_ooef004             LIKE ooef_t.ooef004  #參照表號
DEFINE g_ooef016             LIKE ooef_t.ooef016  #主幣別編號 
DEFINE g_ooef019             LIKE ooef_t.ooef019  #所屬稅區
DEFINE g_flag                LIKE type_t.chr1     #預估費用

GLOBALS
   DEFINE g_d_idx_display   LIKE type_t.num5   #製造批序號明細所在筆數
   DEFINE g_d_cnt_display   LIKE type_t.num5   #製造批序號明細總筆數
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
END GLOBALS

DEFINE g_aic_doc            LIKE type_t.num5    #151210-00009#1  2015/12/30 By earl add
DEFINE g_ask                LIKE type_t.num5    #150720-00006#1  2016/03/29  By earl  #詢問是否自動產生單身
DEFINE g_slip_wc          STRING     #160510-00043#2
DEFINE g_slip_wc1         STRING     #170119-00008#2  2017/01/20 By 08171 add
DEFINE g_detail_id          STRING           #紀錄停留在哪個Page #161031-00025#25 add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmdg_m          type_g_xmdg_m
DEFINE g_xmdg_m_t        type_g_xmdg_m
DEFINE g_xmdg_m_o        type_g_xmdg_m
DEFINE g_xmdg_m_mask_o   type_g_xmdg_m #轉換遮罩前資料
DEFINE g_xmdg_m_mask_n   type_g_xmdg_m #轉換遮罩後資料
 
   DEFINE g_xmdgdocno_t LIKE xmdg_t.xmdgdocno
 
 
DEFINE g_xmdh_d          DYNAMIC ARRAY OF type_g_xmdh_d
DEFINE g_xmdh_d_t        type_g_xmdh_d
DEFINE g_xmdh_d_o        type_g_xmdh_d
DEFINE g_xmdh_d_mask_o   DYNAMIC ARRAY OF type_g_xmdh_d #轉換遮罩前資料
DEFINE g_xmdh_d_mask_n   DYNAMIC ARRAY OF type_g_xmdh_d #轉換遮罩後資料
DEFINE g_xmdh2_d          DYNAMIC ARRAY OF type_g_xmdh2_d
DEFINE g_xmdh2_d_t        type_g_xmdh2_d
DEFINE g_xmdh2_d_o        type_g_xmdh2_d
DEFINE g_xmdh2_d_mask_o   DYNAMIC ARRAY OF type_g_xmdh2_d #轉換遮罩前資料
DEFINE g_xmdh2_d_mask_n   DYNAMIC ARRAY OF type_g_xmdh2_d #轉換遮罩後資料
DEFINE g_xmdh4_d          DYNAMIC ARRAY OF type_g_xmdh4_d
DEFINE g_xmdh4_d_t        type_g_xmdh4_d
DEFINE g_xmdh4_d_o        type_g_xmdh4_d
DEFINE g_xmdh4_d_mask_o   DYNAMIC ARRAY OF type_g_xmdh4_d #轉換遮罩前資料
DEFINE g_xmdh4_d_mask_n   DYNAMIC ARRAY OF type_g_xmdh4_d #轉換遮罩後資料
 
 
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
 
{<section id="axmt520.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
     
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
     
   #end add-point
   LET g_forupd_sql = " SELECT xmdgdocno,'',xmdgdocdt,xmdg004,xmdgsite,xmdg002,'',xmdg003,'',xmdgstus, 
       xmdg001,xmdg034,xmdg005,'',xmdg006,'',xmdg007,'',xmdg202,'',xmdg028,xmdg026,'',xmdg027,'',xmdg024, 
       xmdg025,xmdg030,'',xmdg031,'',xmdg053,xmdg056,'',xmdg055,xmdg054,xmdg057,xmdg058,xmdg017,'','', 
       xmdg018,'',xmdg019,'',xmdg020,'',xmdg016,'',xmdg021,xmdg022,xmdg023,'',xmdg008,'',xmdg009,'', 
       xmdg010,'',xmdg011,xmdg012,xmdg013,'',xmdg032,xmdg033,xmdg014,'',xmdg015,xmdgownid,'',xmdgowndp, 
       '',xmdgcrtid,'',xmdgcrtdp,'',xmdgcrtdt,xmdgmodid,'',xmdgmoddt,xmdgcnfid,'',xmdgcnfdt", 
                      " FROM xmdg_t",
                      " WHERE xmdgent= ? AND xmdgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
     
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmdgdocno,t0.xmdgdocdt,t0.xmdg004,t0.xmdgsite,t0.xmdg002,t0.xmdg003, 
       t0.xmdgstus,t0.xmdg001,t0.xmdg034,t0.xmdg005,t0.xmdg006,t0.xmdg007,t0.xmdg202,t0.xmdg028,t0.xmdg026, 
       t0.xmdg027,t0.xmdg024,t0.xmdg025,t0.xmdg030,t0.xmdg031,t0.xmdg053,t0.xmdg056,t0.xmdg055,t0.xmdg054, 
       t0.xmdg057,t0.xmdg058,t0.xmdg017,t0.xmdg018,t0.xmdg019,t0.xmdg020,t0.xmdg016,t0.xmdg021,t0.xmdg022, 
       t0.xmdg023,t0.xmdg008,t0.xmdg009,t0.xmdg010,t0.xmdg011,t0.xmdg012,t0.xmdg013,t0.xmdg032,t0.xmdg033, 
       t0.xmdg014,t0.xmdg015,t0.xmdgownid,t0.xmdgowndp,t0.xmdgcrtid,t0.xmdgcrtdp,t0.xmdgcrtdt,t0.xmdgmodid, 
       t0.xmdgmoddt,t0.xmdgcnfid,t0.xmdgcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 , 
       t6.pmaal004 ,t7.oojdl003 ,t8.oocql004 ,t9.oocql004 ,t10.oocql004 ,t11.icaal003 ,t12.oofb011 , 
       t13.oocql004 ,t14.pmaal004 ,t15.ooibl004 ,t16.oocql004 ,t17.ooail003 ,t18.ooag011 ,t19.ooefl003 , 
       t20.ooag011 ,t21.ooefl003 ,t22.ooag011 ,t23.ooag011",
               " FROM xmdg_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdg002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdg003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdg005 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdg006 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdg007 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.xmdg202 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t7 ON t7.oojdlent="||g_enterprise||" AND t7.oojdl001=t0.xmdg026 AND t7.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='295' AND t8.oocql002=t0.xmdg027 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='209' AND t9.oocql002=t0.xmdg030 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='297' AND t10.oocql002=t0.xmdg031 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN icaal_t t11 ON t11.icaalent="||g_enterprise||" AND t11.icaal001=t0.xmdg056 AND t11.icaal002='"||g_dlang||"' ",
               " LEFT JOIN oofb_t t12 ON t12.oofbent="||g_enterprise||" AND t12.oofb001=t0.xmdg017  ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='263' AND t13.oocql002=t0.xmdg018 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.xmdg016 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t15 ON t15.ooiblent="||g_enterprise||" AND t15.ooibl002=t0.xmdg008 AND t15.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='238' AND t16.oocql002=t0.xmdg009 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t17 ON t17.ooailent="||g_enterprise||" AND t17.ooail001=t0.xmdg014 AND t17.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.xmdgownid  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=t0.xmdgowndp AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.xmdgcrtid  ",
               " LEFT JOIN ooefl_t t21 ON t21.ooeflent="||g_enterprise||" AND t21.ooefl001=t0.xmdgcrtdp AND t21.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t22 ON t22.ooagent="||g_enterprise||" AND t22.ooag001=t0.xmdgmodid  ",
               " LEFT JOIN ooag_t t23 ON t23.ooagent="||g_enterprise||" AND t23.ooag001=t0.xmdgcnfid  ",
 
               " WHERE t0.xmdgent = " ||g_enterprise|| " AND t0.xmdgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
 
   #end add-point
   PREPARE axmt520_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
           
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmt520 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmt520_init()   
 
      #進入選單 Menu (="N")
      CALL axmt520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_lot_sel_drop_tmp()             
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmt520
      
   END IF 
   
   CLOSE axmt520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL axmt540_01_drop_temp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmt520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmt520_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_gzze003  LIKE gzze_t.gzze003
   DEFINE l_prog_o   LIKE type_t.chr10 #170119-00008#2  2017/01/20 By 08171  add
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
      CALL cl_set_combo_scc_part('xmdgstus','13','N,Y,A,D,R,W,H,UH,X')
 
      CALL cl_set_combo_scc('xmdg001','2063') 
   CALL cl_set_combo_scc('xmdg034','2064') 
   CALL cl_set_combo_scc('xmdg057','4060') 
   CALL cl_set_combo_scc('xmdg032','2085') 
   CALL cl_set_combo_scc('xmdg033','2084') 
   CALL cl_set_combo_scc('xmdh005','2055') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','3',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #161031-00025#25-s
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_remarks", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc_part('ooff012','11','1,2,4')
   CALL cl_set_comp_visible("ooff003",FALSE)
   #161031-00025#25-e  
   CALL cl_set_combo_scc_part('xmdgstus','13','N,X,Y,A,D,R,W,H')
   CALL cl_set_combo_scc('xmdh0051','2055')
   CALL axmt540_01_create_temp_table() RETURNING l_success
   CALL s_tax_recount_tmp()

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("xmdh018,xmdh018_desc,xmdh019,xmdi010,xmdi010_desc,xmdi011",FALSE)
   END IF

   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdh007,xmdh0071,xmdh007_desc,xmdh0071_desc,xmdi002,xmdi002_desc",FALSE)
   END IF

   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0007') = "N" THEN
      CALL cl_set_comp_visible("xmdh020,xmdh020_desc,xmdh021,xmdh0201,xmdh0201_desc,xmdh0211",FALSE)
   END IF

   IF g_argv[01] = '8' THEN
      #借貨訂單單號
      CALL cl_getmsg('axm-00534',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('xmdg004',l_gzze003)
      CALL cl_set_comp_att_text('xmdh001',l_gzze003)
   END IF

   #150821-xianghui-b
   CALL cl_set_toolbaritem_visible("s_lot_sel",TRUE)
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01")
   CALL s_lot_sel_create_tmp() 
   
   CALL cl_set_comp_visible("page_6",TRUE) 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0048') = 'N' THEN 
      CALL cl_set_comp_visible("page_6",FALSE)
   END IF
   #150821-xianghui-e
   
   LET g_ooef004 = ''
   LET g_ooef016 = ''
   LET g_ooef019 = ''
   SELECT ooef004,ooef016,ooef019
     INTO g_ooef004,g_ooef016,g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   #151210-00009#1  2015/12/30 By earl s
   IF cl_get_para(g_enterprise,'','E-BAS-0018') = 'Y' THEN
      LET g_aic_doc = TRUE
   ELSE
      LET g_aic_doc = FALSE
   END IF
   #151210-00009#1  2015/12/30 By earl e
   CALL s_aooi200_filter_slip('xmdgdocno') RETURNING g_slip_wc    #160510-00043#2
   #170119-00008#2  2017/01/20 By 08171 --s add
   LET l_prog_o = g_prog
   LET g_prog = 'axmt500' 
   CALL s_aooi200_filter_slip('xmdadocno') RETURNING g_slip_wc1    #beckxie 20170119
   LET g_prog = l_prog_o
   #170119-00008#2  2017/01/20 By 08171 --e add
   #end add-point
   
   #初始化搜尋條件
   CALL axmt520_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmt520.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmt520_ui_dialog()
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
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_rollback LIKE type_t.num5
   DEFINE l_xmdh012  LIKE xmdh_t.xmdh012
   DEFINE l_xmdh013  LIKE xmdh_t.xmdh013
   DEFINE l_xmdh014  LIKE xmdh_t.xmdh014
   DEFINE l_xmdh029  LIKE xmdh_t.xmdh029 
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
            CALL axmt520_insert()
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
         INITIALIZE g_xmdg_m.* TO NULL
         CALL g_xmdh_d.clear()
         CALL g_xmdh2_d.clear()
         CALL g_xmdh4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmt520_init()
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
               
               CALL axmt520_fetch('') # reload data
               LET l_ac = 1
               CALL axmt520_ui_detailshow() #Setting the current row 
         
               CALL axmt520_idx_chk()
               #NEXT FIELD xmdhseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xmdh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt520_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
                             
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axmt520_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                             
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  BEFORE MENU
                     IF cl_null(g_xmdh_d[l_ac].xmdh001) THEN
                        EXIT MENU
                     END IF
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_axmt500
                  LET g_action_choice="prog_axmt500"
                  IF cl_auth_chk_act("prog_axmt500") THEN
                     
                     #add-point:ON ACTION prog_axmt500 name="menu.detail_show.page1_sub.prog_axmt500"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               IF g_argv[01] = '8' THEN
                  LET la_param.prog     = 'axmt501'                  
               ELSE
                  LET la_param.prog     = 'axmt500'
               END IF
               LET la_param.param[1] = g_xmdh_d[l_ac].xmdh001
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
         DISPLAY ARRAY g_xmdh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt520_idx_chk()
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
               CALL axmt520_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               CALL axmt520_set_act_visible_b()
               CALL axmt520_set_act_no_visible_b()               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               #150821-xianghui-b
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
               
               IF g_xmdg_m.xmdgstus <> 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00035'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
               
               IF cl_null(g_xmdh2_d[g_detail_idx].xmdi005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00126'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
               
               IF NOT cl_null(g_xmdg_m.xmdgdocno) AND
                  NOT cl_null(g_xmdh2_d[g_detail_idx].xmdiseq) AND
                  NOT cl_null(g_xmdh2_d[g_detail_idx].xmdi001) AND
                  NOT cl_null(g_xmdh2_d[g_detail_idx].xmdi008) AND
                  NOT cl_null(g_xmdh2_d[g_detail_idx].xmdi009) THEN
                  LET l_success = ''
                  CALL s_transaction_begin()
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0048') = 'Y' THEN
                     CALL s_lot_sel('1','2',g_site,g_xmdg_m.xmdgdocno,g_xmdh2_d[g_detail_idx].xmdiseq,g_xmdh2_d[g_detail_idx].xmdiseq1,g_xmdh2_d[g_detail_idx].xmdi001,g_xmdh2_d[g_detail_idx].xmdi002,g_xmdh2_d[g_detail_idx].xmdi013,g_xmdh2_d[g_detail_idx].xmdi005,g_xmdh2_d[g_detail_idx].xmdi006,g_xmdh2_d[g_detail_idx].xmdi007,g_xmdh2_d[g_detail_idx].xmdi008,g_xmdh2_d[g_detail_idx].xmdi009,'-1','axmt520','','','','',0)
                          RETURNING l_success                   
                  END IF        
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
                  IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
                     CALL s_lot_b_fill('1',g_site,'2',g_xmdg_m.xmdgdocno,'','','-1')
                  END IF                  
               END IF
               #150821-xianghui-e                     
               #END add-point
               
            END IF
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                       
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmdh4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt520_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body4.before_row"
                             
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axmt520_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body4.before_display"
                             
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body4.action"
                       
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG sub_s_lot.s_lot_display  
         SUBDIALOG aoo_aooi360_01.aooi360_01_display     #161031-00025#25 add         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axmt520_browser_fill("")
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
               CALL axmt520_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmt520_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axmt520_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #150721-00001#1  2016/01/08 By earl mod s
            CALL axmt520_set_act_visible()
            CALL axmt520_set_act_no_visible()
            #150721-00001#1  2016/01/08 By earl mod e
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         #161031-00025#25-s
         ON ACTION remarks_page
            LET g_detail_id = "remarks_page"
            NEXT FIELD ooff012
         #161031-00025#25-e
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axmt520_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axmt520_set_act_visible()   
            CALL axmt520_set_act_no_visible()
            IF NOT (g_xmdg_m.xmdgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xmdgent = " ||g_enterprise|| " AND",
                                  " xmdgdocno = '", g_xmdg_m.xmdgdocno, "' "
 
               #填到對應位置
               CALL axmt520_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xmdg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdi_t" 
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
               CALL axmt520_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xmdg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdi_t" 
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
                  CALL axmt520_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmt520_fetch("F")
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
               CALL axmt520_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmt520_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt520_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmt520_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt520_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmt520_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt520_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmt520_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt520_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmt520_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt520_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmdh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmdh2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xmdh4_d)
                  LET g_export_id[3]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161031-00025#25-s
                  LET g_export_node[4] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[4]   = "s_detail1_aooi360_01"
                  #161031-00025#25-e
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
               NEXT FIELD xmdhseq
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
               CALL axmt520_modify()
               #add-point:ON ACTION modify name="menu.modify"
                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmt520_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               #CALL aooi360_02('6',g_prog,g_xmdg_m.xmdgdocno,'','','','','','','','','4') #161031-00025#25 mark
               #161031-00025#25-s
               IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
                  CALL axmt520_remaks()
               END IF
               #161031-00025#25-e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmt520_delete()
               #add-point:ON ACTION delete name="menu.delete"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmt520_insert()
               #add-point:ON ACTION insert name="menu.insert"
                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL axmr520_g01("xmdgent ="|| g_enterprise ||"  AND xmdgdocno ='"|| g_xmdg_m.xmdgdocno||"'",'Y','Y')
               LET g_rep_wc = "xmdgent ="|| g_enterprise ||"  AND xmdgdocno ='"|| g_xmdg_m.xmdgdocno||"'"
              
               #END add-point
               &include "erp/axm/axmt520_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL axmr520_g01("xmdgent ="|| g_enterprise ||"  AND xmdgdocno ='"|| g_xmdg_m.xmdgdocno||"'",'Y','Y')
               LET g_rep_wc = "xmdgent ="|| g_enterprise ||"  AND xmdgdocno ='"|| g_xmdg_m.xmdgdocno||"'"
              
               #END add-point
               &include "erp/axm/axmt520_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmt520_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION show_price
            LET g_action_choice="show_price"
            IF cl_auth_chk_act("show_price") THEN
               
               #add-point:ON ACTION show_price name="menu.show_price"
               
               #顯示價格資訊頁籤
               CALL cl_set_comp_visible("page_7",TRUE)
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt520_01
            LET g_action_choice="axmt520_01"
            IF cl_auth_chk_act("axmt520_01") THEN
               
               #add-point:ON ACTION axmt520_01 name="menu.axmt520_01"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_xmdg_m.xmdgstus = 'X' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00229'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_xmdh_d[g_detail_idx].xmdh012 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00162'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               CALL s_transaction_begin()
			 
               CALL axmt540_01('2',g_site,'',g_xmdg_m.xmdgdocno,g_xmdh_d[g_detail_idx].xmdhseq,
                               g_xmdh_d[g_detail_idx].xmdh006,g_xmdh_d[g_detail_idx].xmdh007,
                               g_xmdh_d[g_detail_idx].xmdh009,g_xmdh_d[g_detail_idx].xmdh010,
                               g_xmdh_d[g_detail_idx].xmdh015,g_xmdh_d[g_detail_idx].xmdh016,
                               '',g_xmdh_d[g_detail_idx].xmdh018,g_xmdh_d[g_detail_idx].xmdh019,
                               '',g_xmdg_m.xmdgdocno,g_xmdh_d[g_detail_idx].xmdhseq,  #141205-00006#4 mod
                               g_xmdh_d[g_detail_idx].xmdh001,g_xmdh_d[g_detail_idx].xmdh002,
                               g_xmdh_d[g_detail_idx].xmdh031)
                    RETURNING l_success,l_rollback,l_xmdh012,l_xmdh013,l_xmdh014,l_xmdh029
               IF l_rollback OR NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               END IF                    
               IF NOT cl_null(l_xmdh012) THEN
                  UPDATE xmdh_t
                     SET xmdh011 = 'N',
                         xmdh012 = l_xmdh012,
                         xmdh013 = l_xmdh013,
                         xmdh014 = l_xmdh014,
                         xmdh029 = l_xmdh029
                   WHERE xmdhent = g_enterprise
                     AND xmdhsite = g_site
                     AND xmdhdocno = g_xmdg_m.xmdgdocno
                     AND xmdhseq = g_xmdh_d[l_ac].xmdhseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "UPDATE:"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
               ELSE
                  UPDATE xmdh_t
                     SET xmdh011 = 'Y',
                         xmdh012 = '',
                         xmdh013 = '',
                         xmdh014 = ''
                   WHERE xmdhent = g_enterprise
                     AND xmdhsite = g_site
                     AND xmdhdocno = g_xmdg_m.xmdgdocno
                     AND xmdhseq = g_xmdh_d[l_ac].xmdhseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "UPDATE:"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
               END IF
               CALL s_transaction_end('Y','0')
               CALL axmt520_b_fill()   #160408-00035#4 add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmt520_query()
               #add-point:ON ACTION query name="menu.query"
                             
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_price
            LET g_action_choice="upd_price"
            IF cl_auth_chk_act("upd_price") THEN
               
               #add-point:ON ACTION upd_price name="menu.upd_price"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #顯示價格資訊頁籤
               CALL cl_set_comp_visible("page_7",TRUE)
               
               LET g_action_choice= "modify_detail"
               IF cl_auth_chk_act("modify") THEN
                  CALL s_transaction_begin()
                  IF NOT axmt520_action_modify('P') THEN
                     CALL s_transaction_end('N','0')
                  
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdg004
            LET g_action_choice="prog_xmdg004"
            IF cl_auth_chk_act("prog_xmdg004") THEN
               
               #add-point:ON ACTION prog_xmdg004 name="menu.prog_xmdg004"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               IF g_argv[01] = '8' THEN
                  LET la_param.prog     = 'axmt501'
               ELSE
                  LET la_param.prog     = 'axmt500'
               END IF
               LET la_param.param[1] = g_xmdg_m.xmdg004
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdg002
            LET g_action_choice="prog_xmdg002"
            IF cl_auth_chk_act("prog_xmdg002") THEN
               
               #add-point:ON ACTION prog_xmdg002 name="menu.prog_xmdg002"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_xmdg_m.xmdg002)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmt520_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
 
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmt520_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
 
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmt520_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
 
            #END add-point
            CALL cl_user_overview_follow(g_xmdg_m.xmdgdocdt)
 
 
 
         
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
 
{<section id="axmt520.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmt520_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象全名   #161207-00033#35 add  
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161031-00025#25-s
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   #清除备注单身
   END IF
   #161031-00025#25-e
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
   IF cl_null(g_wc) THEN
      LET g_wc = " xmdgsite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc," AND xmdgsite = '",g_site,"' "
   END IF
   
   IF g_argv[01] = '8' THEN
      LET g_wc = g_wc," AND xmdg001 = '", g_argv[01], "' "
   ELSE
      LET g_wc = g_wc," AND xmdg001 <> '8' "
   END IF
   #160510-00043#2--(S)
   IF NOT cl_null(g_slip_wc) THEN
      LET g_wc = g_wc," AND ",g_slip_wc
   END IF   
   #160510-00043#2--(E)
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xmdgdocno ",
                      " FROM xmdg_t ",
                      " ",
                      " LEFT JOIN xmdh_t ON xmdhent = xmdgent AND xmdgdocno = xmdhdocno ", "  ",
                      #add-point:browser_fill段sql(xmdh_t1) name="browser_fill.cnt.join.}"
                      " LEFT JOIN xmda_t ON xmdaent = xmdgent AND xmdadocno = xmdh001 ",      #150120新增"客戶訂單號碼"  earl
                      #end add-point
                      " LEFT JOIN xmdi_t ON xmdient = xmdgent AND xmdgdocno = xmdidocno", "  ",
                      #add-point:browser_fill段sql(xmdi_t1) name="browser_fill.cnt.join.xmdi_t1"
                      " AND xmdiseq = xmdhseq ",
                      " LEFT JOIN ooff_t ON ooffent = xmdgent AND ooff001 = '7' 
                        AND ooff002 = '",g_prog,"' AND xmdgdocno = ooff003  AND ooff004 = xmdhseq ",  "  ",   #161031-00025#25 add
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xmdgent = " ||g_enterprise|| " AND xmdhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmdg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmdgdocno ",
                      " FROM xmdg_t ", 
                      "  ",
                      "  ",
                      " WHERE xmdgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmdg_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #161031-00025#25-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                        WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                          AND ooff002 = '",g_prog,"' AND ooff003 = xmdgdocno
                                                          AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#25-e
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
      INITIALIZE g_xmdg_m.* TO NULL
      CALL g_xmdh_d.clear()        
      CALL g_xmdh2_d.clear() 
      CALL g_xmdh4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmdgdocno,t0.xmdgdocdt,t0.xmdg002,t0.xmdg003,t0.xmdg004,t0.xmdg005,t0.xmdg006,t0.xmdg007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdgstus,t0.xmdgdocno,t0.xmdgdocdt,t0.xmdg002,t0.xmdg003,t0.xmdg004, 
          t0.xmdg005,t0.xmdg006,t0.xmdg007,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 ", 
 
                  " FROM xmdg_t t0",
                  "  ",
                  "  LEFT JOIN xmdh_t ON xmdhent = xmdgent AND xmdgdocno = xmdhdocno ", "  ", 
                  #add-point:browser_fill段sql(xmdh_t1) name="browser_fill.join.xmdh_t1"
               "  LEFT JOIN xmda_t ON xmdaent = xmdgent AND xmdadocno = xmdh001 ",      #150120新增"客戶訂單號碼"  earl
                  #end add-point
                  "  LEFT JOIN xmdi_t ON xmdient = xmdgent AND xmdgdocno = xmdidocno", "  ", 
                  #add-point:browser_fill段sql(xmdi_t1) name="browser_fill.join.xmdi_t1"
               " AND xmdiseq = xmdhseq ",
               " LEFT JOIN ooff_t ON ooffent = xmdgent AND ooff001 = '7' 
                 AND ooff002 = '",g_prog,"' AND xmdgdocno = ooff003  AND ooff004 = xmdhseq ",  "  ",   #161031-00025#25 add
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdg002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdg003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdg005 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdg006 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdg007 AND t5.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xmdg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdgstus,t0.xmdgdocno,t0.xmdgdocdt,t0.xmdg002,t0.xmdg003,t0.xmdg004, 
          t0.xmdg005,t0.xmdg006,t0.xmdg007,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 ", 
 
                  " FROM xmdg_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdg002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdg003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdg005 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdg006 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdg007 AND t5.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xmdg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161031-00025#25-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                        WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                          AND ooff002 = '",g_prog,"' AND ooff003 = xmdgdocno
                                                          AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#25-e
   #end add-point
   LET g_sql = g_sql, " ORDER BY xmdgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
     
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmdg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
     
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmdgdocno,g_browser[g_cnt].b_xmdgdocdt, 
          g_browser[g_cnt].b_xmdg002,g_browser[g_cnt].b_xmdg003,g_browser[g_cnt].b_xmdg004,g_browser[g_cnt].b_xmdg005, 
          g_browser[g_cnt].b_xmdg006,g_browser[g_cnt].b_xmdg007,g_browser[g_cnt].b_xmdg002_desc,g_browser[g_cnt].b_xmdg003_desc, 
          g_browser[g_cnt].b_xmdg005_desc,g_browser[g_cnt].b_xmdg006_desc,g_browser[g_cnt].b_xmdg007_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         #161207-00033#35-s   
         IF NOT cl_null(g_browser[g_cnt].b_xmdgdocno) THEN   
            CALL s_desc_axm_get_oneturn_guest_desc('2',g_browser[g_cnt].b_xmdgdocno)
                 RETURNING l_pmak003
            IF NOT cl_null(l_pmak003) THEN
               LET g_browser[g_cnt].b_xmdg005_desc = l_pmak003
               IF g_browser[g_cnt].b_xmdg006 = g_browser[g_cnt].b_xmdg005 THEN   #帳款客戶
                  LET g_browser[g_cnt].b_xmdg006_desc = g_browser[g_cnt].b_xmdg005_desc
               END IF
               IF g_browser[g_cnt].b_xmdg007 = g_browser[g_cnt].b_xmdg005 THEN   #收貨客戶
                  LET g_browser[g_cnt].b_xmdg007_desc = g_browser[g_cnt].b_xmdg005_desc
               END IF
            END IF
         END IF
         #161207-00033#35-e   
         #end add-point
      
         #遮罩相關處理
         CALL axmt520_browser_mask()
      
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
         WHEN "H"
            LET g_browser[g_cnt].b_statepic = "stus/16/hold.png"
         WHEN "UH"
            LET g_browser[g_cnt].b_statepic = "stus/16/unhold.png"
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
   
   IF cl_null(g_browser[g_cnt].b_xmdgdocno) THEN
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
 
{<section id="axmt520.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmt520_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
     
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmdg_m.xmdgdocno = g_browser[g_current_idx].b_xmdgdocno   
 
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
   CALL axmt520_xmdg_t_mask()
   CALL axmt520_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axmt520.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmt520_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
     
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
     
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
     
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmt520_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmdgdocno = g_xmdg_m.xmdgdocno 
 
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
 
{<section id="axmt520.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmt520_construct()
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
   DEFINE l_form_wc   STRING    #150120新增"客戶訂單號碼"  earl
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#25
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xmdg_m.* TO NULL
   CALL g_xmdh_d.clear()        
   CALL g_xmdh2_d.clear() 
   CALL g_xmdh4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
     
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmdgdocno,xmdgdocdt,xmdg004,xmdgsite,xmdg002,xmdg003,xmdgstus,xmdg001, 
          xmdg034,xmdg005,xmdg006,xmdg007,xmdg202,xmdg028,xmdg026,xmdg027,xmdg024,xmdg025,xmdg030,xmdg031, 
          xmdg053,xmdg056,xmdg055,xmdg054,xmdg057,xmdg058,xmdg017,xmdg018,xmdg019,xmdg020,xmdg016,xmdg021, 
          xmdg022,xmdg023,xmdg008,xmdg009,xmdg010,xmdg011,xmdg012,xmdg013,xmdg032,xmdg033,xmdg014,xmdg015, 
          xmdgownid,xmdgowndp,xmdgcrtid,xmdgcrtdp,xmdgcrtdt,xmdgmodid,xmdgmoddt,xmdgcnfid,xmdgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                       
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmdgcrtdt>>----
         AFTER FIELD xmdgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmdgmoddt>>----
         AFTER FIELD xmdgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdgcnfdt>>----
         AFTER FIELD xmdgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdgpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xmdgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgdocno
            #add-point:ON ACTION controlp INFIELD xmdgdocno name="construct.c.xmdgdocno"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            IF g_argv[01] = '8' THEN
   	   		LET g_qryparam.where = " xmdg001 = '8' "
   	   	ELSE
   	   		LET g_qryparam.where = " xmdg001 <> '8' "
            END IF
            #160510-00043#2--(S)
            IF NOT cl_null(g_slip_wc) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_slip_wc
            END IF   
            #160510-00043#2--(E)
            CALL q_xmdgdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgdocno  #顯示到畫面上
            NEXT FIELD xmdgdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgdocno
            #add-point:BEFORE FIELD xmdgdocno name="construct.b.xmdgdocno"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgdocno
            
            #add-point:AFTER FIELD xmdgdocno name="construct.a.xmdgdocno"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgdocdt
            #add-point:BEFORE FIELD xmdgdocdt name="construct.b.xmdgdocdt"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgdocdt
            
            #add-point:AFTER FIELD xmdgdocdt name="construct.a.xmdgdocdt"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgdocdt
            #add-point:ON ACTION controlp INFIELD xmdgdocdt name="construct.c.xmdgdocdt"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg004
            #add-point:ON ACTION controlp INFIELD xmdg004 name="construct.c.xmdg004"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            IF g_argv[01] = '8' THEN
   	   		LET g_qryparam.where = " xmda005 = '8' "
   	   	ELSE
   	   		LET g_qryparam.where = " xmda005 <> '8' "
            END IF
            CALL q_xmdadocno_2()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg004  #顯示到畫面上
            NEXT FIELD xmdg004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg004
            #add-point:BEFORE FIELD xmdg004 name="construct.b.xmdg004"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg004
            
            #add-point:AFTER FIELD xmdg004 name="construct.a.xmdg004"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgsite
            #add-point:BEFORE FIELD xmdgsite name="construct.b.xmdgsite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgsite
            
            #add-point:AFTER FIELD xmdgsite name="construct.a.xmdgsite"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgsite
            #add-point:ON ACTION controlp INFIELD xmdgsite name="construct.c.xmdgsite"
 
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg002
            #add-point:ON ACTION controlp INFIELD xmdg002 name="construct.c.xmdg002"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg002  #顯示到畫面上
            NEXT FIELD xmdg002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg002
            #add-point:BEFORE FIELD xmdg002 name="construct.b.xmdg002"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg002
            
            #add-point:AFTER FIELD xmdg002 name="construct.a.xmdg002"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg003
            #add-point:ON ACTION controlp INFIELD xmdg003 name="construct.c.xmdg003"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg003  #顯示到畫面上
            NEXT FIELD xmdg003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg003
            #add-point:BEFORE FIELD xmdg003 name="construct.b.xmdg003"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg003
            
            #add-point:AFTER FIELD xmdg003 name="construct.a.xmdg003"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgstus
            #add-point:BEFORE FIELD xmdgstus name="construct.b.xmdgstus"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgstus
            
            #add-point:AFTER FIELD xmdgstus name="construct.a.xmdgstus"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgstus
            #add-point:ON ACTION controlp INFIELD xmdgstus name="construct.c.xmdgstus"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg001
            #add-point:BEFORE FIELD xmdg001 name="construct.b.xmdg001"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg001
            
            #add-point:AFTER FIELD xmdg001 name="construct.a.xmdg001"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg001
            #add-point:ON ACTION controlp INFIELD xmdg001 name="construct.c.xmdg001"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg034
            #add-point:BEFORE FIELD xmdg034 name="construct.b.xmdg034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg034
            
            #add-point:AFTER FIELD xmdg034 name="construct.a.xmdg034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg034
            #add-point:ON ACTION controlp INFIELD xmdg034 name="construct.c.xmdg034"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg005
            #add-point:ON ACTION controlp INFIELD xmdg005 name="construct.c.xmdg005"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
	   		LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg005  #顯示到畫面上
            NEXT FIELD xmdg005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg005
            #add-point:BEFORE FIELD xmdg005 name="construct.b.xmdg005"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg005
            
            #add-point:AFTER FIELD xmdg005 name="construct.a.xmdg005"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg006
            #add-point:ON ACTION controlp INFIELD xmdg006 name="construct.c.xmdg006"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
	   		LET g_qryparam.arg2 = g_site
            CALL q_pmac002_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg006  #顯示到畫面上
            NEXT FIELD xmdg006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg006
            #add-point:BEFORE FIELD xmdg006 name="construct.b.xmdg006"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg006
            
            #add-point:AFTER FIELD xmdg006 name="construct.a.xmdg006"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg007
            #add-point:ON ACTION controlp INFIELD xmdg007 name="construct.c.xmdg007"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
	   		LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg007  #顯示到畫面上
            NEXT FIELD xmdg007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg007
            #add-point:BEFORE FIELD xmdg007 name="construct.b.xmdg007"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg007
            
            #add-point:AFTER FIELD xmdg007 name="construct.a.xmdg007"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg202
            #add-point:ON ACTION controlp INFIELD xmdg202 name="construct.c.xmdg202"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
	   		LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg202  #顯示到畫面上
            NEXT FIELD xmdg202                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg202
            #add-point:BEFORE FIELD xmdg202 name="construct.b.xmdg202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg202
            
            #add-point:AFTER FIELD xmdg202 name="construct.a.xmdg202"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg028
            #add-point:BEFORE FIELD xmdg028 name="construct.b.xmdg028"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg028
            
            #add-point:AFTER FIELD xmdg028 name="construct.a.xmdg028"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg028
            #add-point:ON ACTION controlp INFIELD xmdg028 name="construct.c.xmdg028"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg026
            #add-point:ON ACTION controlp INFIELD xmdg026 name="construct.c.xmdg026"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            DISPLAY g_qryparam.return1 TO xmdg026  #顯示到畫面上
            NEXT FIELD xmdg026                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg026
            #add-point:BEFORE FIELD xmdg026 name="construct.b.xmdg026"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg026
            
            #add-point:AFTER FIELD xmdg026 name="construct.a.xmdg026"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg027
            #add-point:ON ACTION controlp INFIELD xmdg027 name="construct.c.xmdg027"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "295" 
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg027  #顯示到畫面上
            NEXT FIELD xmdg027                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg027
            #add-point:BEFORE FIELD xmdg027 name="construct.b.xmdg027"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg027
            
            #add-point:AFTER FIELD xmdg027 name="construct.a.xmdg027"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg024
            #add-point:BEFORE FIELD xmdg024 name="construct.b.xmdg024"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg024
            
            #add-point:AFTER FIELD xmdg024 name="construct.a.xmdg024"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg024
            #add-point:ON ACTION controlp INFIELD xmdg024 name="construct.c.xmdg024"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg025
            #add-point:BEFORE FIELD xmdg025 name="construct.b.xmdg025"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg025
            
            #add-point:AFTER FIELD xmdg025 name="construct.a.xmdg025"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg025
            #add-point:ON ACTION controlp INFIELD xmdg025 name="construct.c.xmdg025"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg030
            #add-point:ON ACTION controlp INFIELD xmdg030 name="construct.c.xmdg030"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "209" 
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg030  #顯示到畫面上
            NEXT FIELD xmdg030                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg030
            #add-point:BEFORE FIELD xmdg030 name="construct.b.xmdg030"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg030
            
            #add-point:AFTER FIELD xmdg030 name="construct.a.xmdg030"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg031
            #add-point:ON ACTION controlp INFIELD xmdg031 name="construct.c.xmdg031"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
	   		LET g_qryparam.arg1 = "297"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg031  #顯示到畫面上
            NEXT FIELD xmdg031                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg031
            #add-point:BEFORE FIELD xmdg031 name="construct.b.xmdg031"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg031
            
            #add-point:AFTER FIELD xmdg031 name="construct.a.xmdg031"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg053
            #add-point:BEFORE FIELD xmdg053 name="construct.b.xmdg053"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg053
            
            #add-point:AFTER FIELD xmdg053 name="construct.a.xmdg053"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg053
            #add-point:ON ACTION controlp INFIELD xmdg053 name="construct.c.xmdg053"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg056
            #add-point:ON ACTION controlp INFIELD xmdg056 name="construct.c.xmdg056"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_icaa001_8()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg056  #顯示到畫面上
            NEXT FIELD xmdg056                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg056
            #add-point:BEFORE FIELD xmdg056 name="construct.b.xmdg056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg056
            
            #add-point:AFTER FIELD xmdg056 name="construct.a.xmdg056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg055
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg055
            #add-point:ON ACTION controlp INFIELD xmdg055 name="construct.c.xmdg055"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdg055()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg055  #顯示到畫面上
            NEXT FIELD xmdg055                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg055
            #add-point:BEFORE FIELD xmdg055 name="construct.b.xmdg055"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg055
            
            #add-point:AFTER FIELD xmdg055 name="construct.a.xmdg055"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg054
            #add-point:BEFORE FIELD xmdg054 name="construct.b.xmdg054"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg054
            
            #add-point:AFTER FIELD xmdg054 name="construct.a.xmdg054"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg054
            #add-point:ON ACTION controlp INFIELD xmdg054 name="construct.c.xmdg054"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg057
            #add-point:BEFORE FIELD xmdg057 name="construct.b.xmdg057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg057
            
            #add-point:AFTER FIELD xmdg057 name="construct.a.xmdg057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg057
            #add-point:ON ACTION controlp INFIELD xmdg057 name="construct.c.xmdg057"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg058
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg058
            #add-point:ON ACTION controlp INFIELD xmdg058 name="construct.c.xmdg058"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdg058()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg058  #顯示到畫面上
            NEXT FIELD xmdg058                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg058
            #add-point:BEFORE FIELD xmdg058 name="construct.b.xmdg058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg058
            
            #add-point:AFTER FIELD xmdg058 name="construct.a.xmdg058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg017
            #add-point:ON ACTION controlp INFIELD xmdg017 name="construct.c.xmdg017"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_oofb019_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg017  #顯示到畫面上
            NEXT FIELD xmdg017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg017
            #add-point:BEFORE FIELD xmdg017 name="construct.b.xmdg017"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg017
            
            #add-point:AFTER FIELD xmdg017 name="construct.a.xmdg017"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg018
            #add-point:ON ACTION controlp INFIELD xmdg018 name="construct.c.xmdg018"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg018  #顯示到畫面上
            NEXT FIELD xmdg018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg018
            #add-point:BEFORE FIELD xmdg018 name="construct.b.xmdg018"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg018
            
            #add-point:AFTER FIELD xmdg018 name="construct.a.xmdg018"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg019
            #add-point:ON ACTION controlp INFIELD xmdg019 name="construct.c.xmdg019"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_xmdg019()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg019  #顯示到畫面上
            NEXT FIELD xmdg019                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg019
            #add-point:BEFORE FIELD xmdg019 name="construct.b.xmdg019"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg019
            
            #add-point:AFTER FIELD xmdg019 name="construct.a.xmdg019"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg020
            #add-point:ON ACTION controlp INFIELD xmdg020 name="construct.c.xmdg020"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_xmdg020()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg020  #顯示到畫面上
            NEXT FIELD xmdg020                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg020
            #add-point:BEFORE FIELD xmdg020 name="construct.b.xmdg020"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg020
            
            #add-point:AFTER FIELD xmdg020 name="construct.a.xmdg020"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg016
            #add-point:ON ACTION controlp INFIELD xmdg016 name="construct.c.xmdg016"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg016  #顯示到畫面上
            NEXT FIELD xmdg016                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg016
            #add-point:BEFORE FIELD xmdg016 name="construct.b.xmdg016"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg016
            
            #add-point:AFTER FIELD xmdg016 name="construct.a.xmdg016"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg021
            #add-point:BEFORE FIELD xmdg021 name="construct.b.xmdg021"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg021
            
            #add-point:AFTER FIELD xmdg021 name="construct.a.xmdg021"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg021
            #add-point:ON ACTION controlp INFIELD xmdg021 name="construct.c.xmdg021"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg022
            #add-point:BEFORE FIELD xmdg022 name="construct.b.xmdg022"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg022
            
            #add-point:AFTER FIELD xmdg022 name="construct.a.xmdg022"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg022
            #add-point:ON ACTION controlp INFIELD xmdg022 name="construct.c.xmdg022"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg023
            #add-point:BEFORE FIELD xmdg023 name="construct.b.xmdg023"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg023
            
            #add-point:AFTER FIELD xmdg023 name="construct.a.xmdg023"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg023
            #add-point:ON ACTION controlp INFIELD xmdg023 name="construct.c.xmdg023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmao002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg023  #顯示到畫面上
            NEXT FIELD xmdg023                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg008
            #add-point:ON ACTION controlp INFIELD xmdg008 name="construct.c.xmdg008"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_pmad002_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg008  #顯示到畫面上
            NEXT FIELD xmdg008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg008
            #add-point:BEFORE FIELD xmdg008 name="construct.b.xmdg008"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg008
            
            #add-point:AFTER FIELD xmdg008 name="construct.a.xmdg008"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg009
            #add-point:ON ACTION controlp INFIELD xmdg009 name="construct.c.xmdg009"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg009  #顯示到畫面上
            NEXT FIELD xmdg009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg009
            #add-point:BEFORE FIELD xmdg009 name="construct.b.xmdg009"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg009
            
            #add-point:AFTER FIELD xmdg009 name="construct.a.xmdg009"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg010
            #add-point:ON ACTION controlp INFIELD xmdg010 name="construct.c.xmdg010"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_oodb002_11()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg010  #顯示到畫面上
            NEXT FIELD xmdg010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg010
            #add-point:BEFORE FIELD xmdg010 name="construct.b.xmdg010"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg010
            
            #add-point:AFTER FIELD xmdg010 name="construct.a.xmdg010"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg011
            #add-point:BEFORE FIELD xmdg011 name="construct.b.xmdg011"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg011
            
            #add-point:AFTER FIELD xmdg011 name="construct.a.xmdg011"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg011
            #add-point:ON ACTION controlp INFIELD xmdg011 name="construct.c.xmdg011"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg012
            #add-point:BEFORE FIELD xmdg012 name="construct.b.xmdg012"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg012
            
            #add-point:AFTER FIELD xmdg012 name="construct.a.xmdg012"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg012
            #add-point:ON ACTION controlp INFIELD xmdg012 name="construct.c.xmdg012"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg013
            #add-point:ON ACTION controlp INFIELD xmdg013 name="construct.c.xmdg013"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_ooef019        #稅區編號
            LET g_qryparam.arg2 = "2"              #銷項
            CALL q_isac002_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg013  #顯示到畫面上
            NEXT FIELD xmdg013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg013
            #add-point:BEFORE FIELD xmdg013 name="construct.b.xmdg013"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg013
            
            #add-point:AFTER FIELD xmdg013 name="construct.a.xmdg013"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg032
            #add-point:BEFORE FIELD xmdg032 name="construct.b.xmdg032"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg032
            
            #add-point:AFTER FIELD xmdg032 name="construct.a.xmdg032"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg032
            #add-point:ON ACTION controlp INFIELD xmdg032 name="construct.c.xmdg032"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg033
            #add-point:BEFORE FIELD xmdg033 name="construct.b.xmdg033"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg033
            
            #add-point:AFTER FIELD xmdg033 name="construct.a.xmdg033"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg033
            #add-point:ON ACTION controlp INFIELD xmdg033 name="construct.c.xmdg033"
 
            #END add-point
 
 
         #Ctrlp:construct.c.xmdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg014
            #add-point:ON ACTION controlp INFIELD xmdg014 name="construct.c.xmdg014"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdg014  #顯示到畫面上
            NEXT FIELD xmdg014                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg014
            #add-point:BEFORE FIELD xmdg014 name="construct.b.xmdg014"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg014
            
            #add-point:AFTER FIELD xmdg014 name="construct.a.xmdg014"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg015
            #add-point:BEFORE FIELD xmdg015 name="construct.b.xmdg015"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg015
            
            #add-point:AFTER FIELD xmdg015 name="construct.a.xmdg015"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg015
            #add-point:ON ACTION controlp INFIELD xmdg015 name="construct.c.xmdg015"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgownid
            #add-point:ON ACTION controlp INFIELD xmdgownid name="construct.c.xmdgownid"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgownid  #顯示到畫面上
            NEXT FIELD xmdgownid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgownid
            #add-point:BEFORE FIELD xmdgownid name="construct.b.xmdgownid"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgownid
            
            #add-point:AFTER FIELD xmdgownid name="construct.a.xmdgownid"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgowndp
            #add-point:ON ACTION controlp INFIELD xmdgowndp name="construct.c.xmdgowndp"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgowndp  #顯示到畫面上
            NEXT FIELD xmdgowndp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgowndp
            #add-point:BEFORE FIELD xmdgowndp name="construct.b.xmdgowndp"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgowndp
            
            #add-point:AFTER FIELD xmdgowndp name="construct.a.xmdgowndp"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgcrtid
            #add-point:ON ACTION controlp INFIELD xmdgcrtid name="construct.c.xmdgcrtid"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgcrtid  #顯示到畫面上
            NEXT FIELD xmdgcrtid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgcrtid
            #add-point:BEFORE FIELD xmdgcrtid name="construct.b.xmdgcrtid"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgcrtid
            
            #add-point:AFTER FIELD xmdgcrtid name="construct.a.xmdgcrtid"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgcrtdp
            #add-point:ON ACTION controlp INFIELD xmdgcrtdp name="construct.c.xmdgcrtdp"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgcrtdp  #顯示到畫面上
            NEXT FIELD xmdgcrtdp                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgcrtdp
            #add-point:BEFORE FIELD xmdgcrtdp name="construct.b.xmdgcrtdp"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgcrtdp
            
            #add-point:AFTER FIELD xmdgcrtdp name="construct.a.xmdgcrtdp"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgcrtdt
            #add-point:BEFORE FIELD xmdgcrtdt name="construct.b.xmdgcrtdt"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgmodid
            #add-point:ON ACTION controlp INFIELD xmdgmodid name="construct.c.xmdgmodid"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgmodid  #顯示到畫面上
            NEXT FIELD xmdgmodid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgmodid
            #add-point:BEFORE FIELD xmdgmodid name="construct.b.xmdgmodid"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgmodid
            
            #add-point:AFTER FIELD xmdgmodid name="construct.a.xmdgmodid"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgmoddt
            #add-point:BEFORE FIELD xmdgmoddt name="construct.b.xmdgmoddt"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.xmdgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgcnfid
            #add-point:ON ACTION controlp INFIELD xmdgcnfid name="construct.c.xmdgcnfid"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdgcnfid  #顯示到畫面上
            NEXT FIELD xmdgcnfid                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgcnfid
            #add-point:BEFORE FIELD xmdgcnfid name="construct.b.xmdgcnfid"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgcnfid
            
            #add-point:AFTER FIELD xmdgcnfid name="construct.a.xmdgcnfid"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgcnfdt
            #add-point:BEFORE FIELD xmdgcnfdt name="construct.b.xmdgcnfdt"
                       
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,xmdh007, 
          xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011,xmdh012,xmdh013, 
          xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033,xmdh050,xmdh056,xmdh030, 
          xmdh051,xmdh052,xmdhunit,xmdh035,ooff013,xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,xmdh028
           FROM s_detail1[1].xmdhsite,s_detail1[1].xmdhseq,s_detail1[1].xmdh001,s_detail1[1].xmdh002, 
               s_detail1[1].xmdh003,s_detail1[1].xmdh004,s_detail1[1].xmdh005,s_detail1[1].xmdh006,s_detail1[1].xmdh007, 
               s_detail1[1].xmdh034,s_detail1[1].xmdh009,s_detail1[1].xmdh010,s_detail1[1].xmdh015,s_detail1[1].xmdh016, 
               s_detail1[1].xmdh017,s_detail1[1].xmdh018,s_detail1[1].xmdh019,s_detail1[1].xmdh008,s_detail1[1].xmdh011, 
               s_detail1[1].xmdh012,s_detail1[1].xmdh013,s_detail1[1].xmdh014,s_detail1[1].xmdh029,s_detail1[1].xmdh020, 
               s_detail1[1].xmdh021,s_detail1[1].xmdh022,s_detail1[1].xmdh036,s_detail1[1].xmdh031,s_detail1[1].xmdh032, 
               s_detail1[1].xmdh033,s_detail1[1].xmdh050,s_detail1[1].xmdh056,s_detail1[1].xmdh030,s_detail1[1].xmdh051, 
               s_detail1[1].xmdh052,s_detail1[1].xmdhunit,s_detail1[1].xmdh035,s_detail1[1].ooff013, 
               s_detail4[1].xmdh023,s_detail4[1].xmdh024,s_detail4[1].xmdh025,s_detail4[1].xmdh026,s_detail4[1].xmdh027, 
               s_detail4[1].xmdh028
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                       
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhsite
            #add-point:BEFORE FIELD xmdhsite name="construct.b.page1.xmdhsite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhsite
            
            #add-point:AFTER FIELD xmdhsite name="construct.a.page1.xmdhsite"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhsite
            #add-point:ON ACTION controlp INFIELD xmdhsite name="construct.c.page1.xmdhsite"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhseq
            #add-point:BEFORE FIELD xmdhseq name="construct.b.page1.xmdhseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhseq
            
            #add-point:AFTER FIELD xmdhseq name="construct.a.page1.xmdhseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhseq
            #add-point:ON ACTION controlp INFIELD xmdhseq name="construct.c.page1.xmdhseq"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh001
            #add-point:ON ACTION controlp INFIELD xmdh001 name="construct.c.page1.xmdh001"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            IF g_argv[01] = '8' THEN
   	   		LET g_qryparam.where = " xmda005 = '8' "
   	   	ELSE
   	   		LET g_qryparam.where = " xmda005 <> '8' "
            END IF
            CALL q_xmdddocno_3()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh001  #顯示到畫面上
            NEXT FIELD xmdh001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh001
            #add-point:BEFORE FIELD xmdh001 name="construct.b.page1.xmdh001"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh001
            
            #add-point:AFTER FIELD xmdh001 name="construct.a.page1.xmdh001"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh002
            #add-point:BEFORE FIELD xmdh002 name="construct.b.page1.xmdh002"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh002
            
            #add-point:AFTER FIELD xmdh002 name="construct.a.page1.xmdh002"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh002
            #add-point:ON ACTION controlp INFIELD xmdh002 name="construct.c.page1.xmdh002"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh003
            #add-point:BEFORE FIELD xmdh003 name="construct.b.page1.xmdh003"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh003
            
            #add-point:AFTER FIELD xmdh003 name="construct.a.page1.xmdh003"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh003
            #add-point:ON ACTION controlp INFIELD xmdh003 name="construct.c.page1.xmdh003"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh004
            #add-point:BEFORE FIELD xmdh004 name="construct.b.page1.xmdh004"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh004
            
            #add-point:AFTER FIELD xmdh004 name="construct.a.page1.xmdh004"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh004
            #add-point:ON ACTION controlp INFIELD xmdh004 name="construct.c.page1.xmdh004"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh005
            #add-point:BEFORE FIELD xmdh005 name="construct.b.page1.xmdh005"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh005
            
            #add-point:AFTER FIELD xmdh005 name="construct.a.page1.xmdh005"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh005
            #add-point:ON ACTION controlp INFIELD xmdh005 name="construct.c.page1.xmdh005"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh006
            #add-point:ON ACTION controlp INFIELD xmdh006 name="construct.c.page1.xmdh006"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh006  #顯示到畫面上
            NEXT FIELD xmdh006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh006
            #add-point:BEFORE FIELD xmdh006 name="construct.b.page1.xmdh006"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh006
            
            #add-point:AFTER FIELD xmdh006 name="construct.a.page1.xmdh006"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh007
            #add-point:BEFORE FIELD xmdh007 name="construct.b.page1.xmdh007"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh007
            
            #add-point:AFTER FIELD xmdh007 name="construct.a.page1.xmdh007"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh007
            #add-point:ON ACTION controlp INFIELD xmdh007 name="construct.c.page1.xmdh007"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh034
            #add-point:ON ACTION controlp INFIELD xmdh034 name="construct.c.page1.xmdh034"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_pmao004_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh034  #顯示到畫面上
            NEXT FIELD xmdh034                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh034
            #add-point:BEFORE FIELD xmdh034 name="construct.b.page1.xmdh034"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh034
            
            #add-point:AFTER FIELD xmdh034 name="construct.a.page1.xmdh034"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh009
            #add-point:ON ACTION controlp INFIELD xmdh009 name="construct.c.page1.xmdh009"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" 
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh009  #顯示到畫面上
            NEXT FIELD xmdh009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh009
            #add-point:BEFORE FIELD xmdh009 name="construct.b.page1.xmdh009"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh009
            
            #add-point:AFTER FIELD xmdh009 name="construct.a.page1.xmdh009"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh010
            #add-point:BEFORE FIELD xmdh010 name="construct.b.page1.xmdh010"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh010
            
            #add-point:AFTER FIELD xmdh010 name="construct.a.page1.xmdh010"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh010
            #add-point:ON ACTION controlp INFIELD xmdh010 name="construct.c.page1.xmdh010"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh015
            #add-point:ON ACTION controlp INFIELD xmdh015 name="construct.c.page1.xmdh015"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh015  #顯示到畫面上
            NEXT FIELD xmdh015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh015
            #add-point:BEFORE FIELD xmdh015 name="construct.b.page1.xmdh015"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh015
            
            #add-point:AFTER FIELD xmdh015 name="construct.a.page1.xmdh015"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh016
            #add-point:BEFORE FIELD xmdh016 name="construct.b.page1.xmdh016"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh016
            
            #add-point:AFTER FIELD xmdh016 name="construct.a.page1.xmdh016"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh016
            #add-point:ON ACTION controlp INFIELD xmdh016 name="construct.c.page1.xmdh016"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh017
            #add-point:BEFORE FIELD xmdh017 name="construct.b.page1.xmdh017"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh017
            
            #add-point:AFTER FIELD xmdh017 name="construct.a.page1.xmdh017"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh017
            #add-point:ON ACTION controlp INFIELD xmdh017 name="construct.c.page1.xmdh017"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh018
            #add-point:ON ACTION controlp INFIELD xmdh018 name="construct.c.page1.xmdh018"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh018  #顯示到畫面上
            NEXT FIELD xmdh018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh018
            #add-point:BEFORE FIELD xmdh018 name="construct.b.page1.xmdh018"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh018
            
            #add-point:AFTER FIELD xmdh018 name="construct.a.page1.xmdh018"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh019
            #add-point:BEFORE FIELD xmdh019 name="construct.b.page1.xmdh019"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh019
            
            #add-point:AFTER FIELD xmdh019 name="construct.a.page1.xmdh019"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh019
            #add-point:ON ACTION controlp INFIELD xmdh019 name="construct.c.page1.xmdh019"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh008
            #add-point:ON ACTION controlp INFIELD xmdh008 name="construct.c.page1.xmdh008"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_imaf001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh008  #顯示到畫面上
            NEXT FIELD xmdh008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh008
            #add-point:BEFORE FIELD xmdh008 name="construct.b.page1.xmdh008"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh008
            
            #add-point:AFTER FIELD xmdh008 name="construct.a.page1.xmdh008"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh011
            #add-point:BEFORE FIELD xmdh011 name="construct.b.page1.xmdh011"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh011
            
            #add-point:AFTER FIELD xmdh011 name="construct.a.page1.xmdh011"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh011
            #add-point:ON ACTION controlp INFIELD xmdh011 name="construct.c.page1.xmdh011"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh012
            #add-point:ON ACTION controlp INFIELD xmdh012 name="construct.c.page1.xmdh012"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
           #CALL q_inag004_1()                     #呼叫開窗  #170117-00047#1 mark
            CALL q_inaa001_2()                     #呼叫開窗  #170117-00047#1 add
            DISPLAY g_qryparam.return1 TO xmdh012  #顯示到畫面上
            NEXT FIELD xmdh012                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh012
            #add-point:BEFORE FIELD xmdh012 name="construct.b.page1.xmdh012"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh012
            
            #add-point:AFTER FIELD xmdh012 name="construct.a.page1.xmdh012"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh013
            #add-point:ON ACTION controlp INFIELD xmdh013 name="construct.c.page1.xmdh013"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
           #CALL q_inag005_5()                     #呼叫開窗 #170117-00047#1 mark
            CALL q_inab002_5()                     #呼叫開窗 #170117-00047#1 add
            DISPLAY g_qryparam.return1 TO xmdh013  #顯示到畫面上
            NEXT FIELD xmdh013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh013
            #add-point:BEFORE FIELD xmdh013 name="construct.b.page1.xmdh013"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh013
            
            #add-point:AFTER FIELD xmdh013 name="construct.a.page1.xmdh013"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh014
            #add-point:ON ACTION controlp INFIELD xmdh014 name="construct.c.page1.xmdh014"
            #170117-00047#1--add--start--
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
            CALL q_inad003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh014  #顯示到畫面上
            NEXT FIELD xmdh014                     #返回原欄位
            #170117-00047#1--add--end----
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh014
            #add-point:BEFORE FIELD xmdh014 name="construct.b.page1.xmdh014"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh014
            
            #add-point:AFTER FIELD xmdh014 name="construct.a.page1.xmdh014"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh029
            #add-point:BEFORE FIELD xmdh029 name="construct.b.page1.xmdh029"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh029
            
            #add-point:AFTER FIELD xmdh029 name="construct.a.page1.xmdh029"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh029
            #add-point:ON ACTION controlp INFIELD xmdh029 name="construct.c.page1.xmdh029"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh020
            #add-point:ON ACTION controlp INFIELD xmdh020 name="construct.c.page1.xmdh020"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh020  #顯示到畫面上
            NEXT FIELD xmdh020                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh020
            #add-point:BEFORE FIELD xmdh020 name="construct.b.page1.xmdh020"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh020
            
            #add-point:AFTER FIELD xmdh020 name="construct.a.page1.xmdh020"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh021
            #add-point:BEFORE FIELD xmdh021 name="construct.b.page1.xmdh021"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh021
            
            #add-point:AFTER FIELD xmdh021 name="construct.a.page1.xmdh021"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh021
            #add-point:ON ACTION controlp INFIELD xmdh021 name="construct.c.page1.xmdh021"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh022
            #add-point:BEFORE FIELD xmdh022 name="construct.b.page1.xmdh022"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh022
            
            #add-point:AFTER FIELD xmdh022 name="construct.a.page1.xmdh022"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh022
            #add-point:ON ACTION controlp INFIELD xmdh022 name="construct.c.page1.xmdh022"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh036
            #add-point:BEFORE FIELD xmdh036 name="construct.b.page1.xmdh036"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh036
            
            #add-point:AFTER FIELD xmdh036 name="construct.a.page1.xmdh036"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh036
            #add-point:ON ACTION controlp INFIELD xmdh036 name="construct.c.page1.xmdh036"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh031
            #add-point:ON ACTION controlp INFIELD xmdh031 name="construct.c.page1.xmdh031"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh031  #顯示到畫面上
            NEXT FIELD xmdh031                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh031
            #add-point:BEFORE FIELD xmdh031 name="construct.b.page1.xmdh031"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh031
            
            #add-point:AFTER FIELD xmdh031 name="construct.a.page1.xmdh031"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh032
            #add-point:ON ACTION controlp INFIELD xmdh032 name="construct.c.page1.xmdh032"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh032  #顯示到畫面上
            NEXT FIELD xmdh032                     #返回原欄位
                           
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh032
            #add-point:BEFORE FIELD xmdh032 name="construct.b.page1.xmdh032"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh032
            
            #add-point:AFTER FIELD xmdh032 name="construct.a.page1.xmdh032"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh033
            #add-point:ON ACTION controlp INFIELD xmdh033 name="construct.c.page1.xmdh033"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh033  #顯示到畫面上
            NEXT FIELD xmdh033                     #返回原欄位
                                                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh033
            #add-point:BEFORE FIELD xmdh033 name="construct.b.page1.xmdh033"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh033
            
            #add-point:AFTER FIELD xmdh033 name="construct.a.page1.xmdh033"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh050
            #add-point:BEFORE FIELD xmdh050 name="construct.b.page1.xmdh050"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh050
            
            #add-point:AFTER FIELD xmdh050 name="construct.a.page1.xmdh050"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh050
            #add-point:ON ACTION controlp INFIELD xmdh050 name="construct.c.page1.xmdh050"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh056
            #add-point:BEFORE FIELD xmdh056 name="construct.b.page1.xmdh056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh056
            
            #add-point:AFTER FIELD xmdh056 name="construct.a.page1.xmdh056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh056
            #add-point:ON ACTION controlp INFIELD xmdh056 name="construct.c.page1.xmdh056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh030
            #add-point:BEFORE FIELD xmdh030 name="construct.b.page1.xmdh030"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh030
            
            #add-point:AFTER FIELD xmdh030 name="construct.a.page1.xmdh030"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh030
            #add-point:ON ACTION controlp INFIELD xmdh030 name="construct.c.page1.xmdh030"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdh051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh051
            #add-point:ON ACTION controlp INFIELD xmdh051 name="construct.c.page1.xmdh051"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_icaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh051  #顯示到畫面上
            NEXT FIELD xmdh051                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh051
            #add-point:BEFORE FIELD xmdh051 name="construct.b.page1.xmdh051"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh051
            
            #add-point:AFTER FIELD xmdh051 name="construct.a.page1.xmdh051"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh052
            #add-point:ON ACTION controlp INFIELD xmdh052 name="construct.c.page1.xmdh052"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_icab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh052  #顯示到畫面上
            NEXT FIELD xmdh052                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh052
            #add-point:BEFORE FIELD xmdh052 name="construct.b.page1.xmdh052"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh052
            
            #add-point:AFTER FIELD xmdh052 name="construct.a.page1.xmdh052"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdhunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhunit
            #add-point:ON ACTION controlp INFIELD xmdhunit name="construct.c.page1.xmdhunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdhunit  #顯示到畫面上
            NEXT FIELD xmdhunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhunit
            #add-point:BEFORE FIELD xmdhunit name="construct.b.page1.xmdhunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhunit
            
            #add-point:AFTER FIELD xmdhunit name="construct.a.page1.xmdhunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh035
            #add-point:BEFORE FIELD xmdh035 name="construct.b.page1.xmdh035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh035
            
            #add-point:AFTER FIELD xmdh035 name="construct.a.page1.xmdh035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdh035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh035
            #add-point:ON ACTION controlp INFIELD xmdh035 name="construct.c.page1.xmdh035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="construct.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="construct.a.page1.ooff013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="construct.c.page1.ooff013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh023
            #add-point:BEFORE FIELD xmdh023 name="construct.b.page4.xmdh023"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh023
            
            #add-point:AFTER FIELD xmdh023 name="construct.a.page4.xmdh023"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh023
            #add-point:ON ACTION controlp INFIELD xmdh023 name="construct.c.page4.xmdh023"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xmdh024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh024
            #add-point:ON ACTION controlp INFIELD xmdh024 name="construct.c.page4.xmdh024"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_oodb002_11()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdh024  #顯示到畫面上
            NEXT FIELD xmdh024                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh024
            #add-point:BEFORE FIELD xmdh024 name="construct.b.page4.xmdh024"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh024
            
            #add-point:AFTER FIELD xmdh024 name="construct.a.page4.xmdh024"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh025
            #add-point:BEFORE FIELD xmdh025 name="construct.b.page4.xmdh025"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh025
            
            #add-point:AFTER FIELD xmdh025 name="construct.a.page4.xmdh025"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdh025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh025
            #add-point:ON ACTION controlp INFIELD xmdh025 name="construct.c.page4.xmdh025"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh026
            #add-point:BEFORE FIELD xmdh026 name="construct.b.page4.xmdh026"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh026
            
            #add-point:AFTER FIELD xmdh026 name="construct.a.page4.xmdh026"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdh026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh026
            #add-point:ON ACTION controlp INFIELD xmdh026 name="construct.c.page4.xmdh026"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh027
            #add-point:BEFORE FIELD xmdh027 name="construct.b.page4.xmdh027"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh027
            
            #add-point:AFTER FIELD xmdh027 name="construct.a.page4.xmdh027"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdh027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh027
            #add-point:ON ACTION controlp INFIELD xmdh027 name="construct.c.page4.xmdh027"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh028
            #add-point:BEFORE FIELD xmdh028 name="construct.b.page4.xmdh028"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh028
            
            #add-point:AFTER FIELD xmdh028 name="construct.a.page4.xmdh028"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdh028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh028
            #add-point:ON ACTION controlp INFIELD xmdh028 name="construct.c.page4.xmdh028"
                       
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xmdisite,xmdiseq,xmdiseq1,xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,xmdi006, 
          xmdi007,xmdi013,xmdi008,xmdi009,xmdi010,xmdi011,xmdi012
           FROM s_detail2[1].xmdisite,s_detail2[1].xmdiseq,s_detail2[1].xmdiseq1,s_detail2[1].xmdi001, 
               s_detail2[1].xmdi002,s_detail2[1].xmdi003,s_detail2[1].xmdi004,s_detail2[1].xmdi005,s_detail2[1].xmdi006, 
               s_detail2[1].xmdi007,s_detail2[1].xmdi013,s_detail2[1].xmdi008,s_detail2[1].xmdi009,s_detail2[1].xmdi010, 
               s_detail2[1].xmdi011,s_detail2[1].xmdi012
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                       
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdisite
            #add-point:BEFORE FIELD xmdisite name="construct.b.page2.xmdisite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdisite
            
            #add-point:AFTER FIELD xmdisite name="construct.a.page2.xmdisite"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdisite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdisite
            #add-point:ON ACTION controlp INFIELD xmdisite name="construct.c.page2.xmdisite"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdiseq
            #add-point:BEFORE FIELD xmdiseq name="construct.b.page2.xmdiseq"
                         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdiseq
            
            #add-point:AFTER FIELD xmdiseq name="construct.a.page2.xmdiseq"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdiseq
            #add-point:ON ACTION controlp INFIELD xmdiseq name="construct.c.page2.xmdiseq"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdiseq1
            #add-point:BEFORE FIELD xmdiseq1 name="construct.b.page2.xmdiseq1"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdiseq1
            
            #add-point:AFTER FIELD xmdiseq1 name="construct.a.page2.xmdiseq1"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdiseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdiseq1
            #add-point:ON ACTION controlp INFIELD xmdiseq1 name="construct.c.page2.xmdiseq1"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmdi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi001
            #add-point:ON ACTION controlp INFIELD xmdi001 name="construct.c.page2.xmdi001"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi001  #顯示到畫面上
            NEXT FIELD xmdi001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi001
            #add-point:BEFORE FIELD xmdi001 name="construct.b.page2.xmdi001"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi001
            
            #add-point:AFTER FIELD xmdi001 name="construct.a.page2.xmdi001"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi002
            #add-point:BEFORE FIELD xmdi002 name="construct.b.page2.xmdi002"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi002
            
            #add-point:AFTER FIELD xmdi002 name="construct.a.page2.xmdi002"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi002
            #add-point:ON ACTION controlp INFIELD xmdi002 name="construct.c.page2.xmdi002"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmdi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi003
            #add-point:ON ACTION controlp INFIELD xmdi003 name="construct.c.page2.xmdi003"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" 
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi003  #顯示到畫面上
            NEXT FIELD xmdi003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi003
            #add-point:BEFORE FIELD xmdi003 name="construct.b.page2.xmdi003"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi003
            
            #add-point:AFTER FIELD xmdi003 name="construct.a.page2.xmdi003"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi004
            #add-point:BEFORE FIELD xmdi004 name="construct.b.page2.xmdi004"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi004
            
            #add-point:AFTER FIELD xmdi004 name="construct.a.page2.xmdi004"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi004
            #add-point:ON ACTION controlp INFIELD xmdi004 name="construct.c.page2.xmdi004"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmdi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi005
            #add-point:ON ACTION controlp INFIELD xmdi005 name="construct.c.page2.xmdi005"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_inag004_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi005  #顯示到畫面上
            NEXT FIELD xmdi005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi005
            #add-point:BEFORE FIELD xmdi005 name="construct.b.page2.xmdi005"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi005
            
            #add-point:AFTER FIELD xmdi005 name="construct.a.page2.xmdi005"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi006
            #add-point:ON ACTION controlp INFIELD xmdi006 name="construct.c.page2.xmdi006"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_inag005_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi006  #顯示到畫面上
            NEXT FIELD xmdi006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi006
            #add-point:BEFORE FIELD xmdi006 name="construct.b.page2.xmdi006"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi006
            
            #add-point:AFTER FIELD xmdi006 name="construct.a.page2.xmdi006"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi007
            #add-point:BEFORE FIELD xmdi007 name="construct.b.page2.xmdi007"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi007
            
            #add-point:AFTER FIELD xmdi007 name="construct.a.page2.xmdi007"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi007
            #add-point:ON ACTION controlp INFIELD xmdi007 name="construct.c.page2.xmdi007"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi013
            #add-point:BEFORE FIELD xmdi013 name="construct.b.page2.xmdi013"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi013
            
            #add-point:AFTER FIELD xmdi013 name="construct.a.page2.xmdi013"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi013
            #add-point:ON ACTION controlp INFIELD xmdi013 name="construct.c.page2.xmdi013"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmdi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi008
            #add-point:ON ACTION controlp INFIELD xmdi008 name="construct.c.page2.xmdi008"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi008  #顯示到畫面上
            NEXT FIELD xmdi008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi008
            #add-point:BEFORE FIELD xmdi008 name="construct.b.page2.xmdi008"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi008
            
            #add-point:AFTER FIELD xmdi008 name="construct.a.page2.xmdi008"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi009
            #add-point:BEFORE FIELD xmdi009 name="construct.b.page2.xmdi009"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi009
            
            #add-point:AFTER FIELD xmdi009 name="construct.a.page2.xmdi009"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi009
            #add-point:ON ACTION controlp INFIELD xmdi009 name="construct.c.page2.xmdi009"
                       
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmdi010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi010
            #add-point:ON ACTION controlp INFIELD xmdi010 name="construct.c.page2.xmdi010"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdi010  #顯示到畫面上
            NEXT FIELD xmdi010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi010
            #add-point:BEFORE FIELD xmdi010 name="construct.b.page2.xmdi010"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi010
            
            #add-point:AFTER FIELD xmdi010 name="construct.a.page2.xmdi010"
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi011
            #add-point:BEFORE FIELD xmdi011 name="construct.b.page2.xmdi011"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi011
            
            #add-point:AFTER FIELD xmdi011 name="construct.a.page2.xmdi011"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi011
            #add-point:ON ACTION controlp INFIELD xmdi011 name="construct.c.page2.xmdi011"
                       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdi012
            #add-point:BEFORE FIELD xmdi012 name="construct.b.page2.xmdi012"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdi012
            
            #add-point:AFTER FIELD xmdi012 name="construct.a.page2.xmdi012"
                       
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdi012
            #add-point:ON ACTION controlp INFIELD xmdi012 name="construct.c.page2.xmdi012"
                       
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct   #备注单身  #161031-00025#25
      #150120新增"客戶訂單號碼"  earl(s)
      CONSTRUCT l_form_wc ON xmda033 FROM s_detail1[1].xmda033
                      
         BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD xmda033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_xmda033()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda033  #顯示到畫面上
            NEXT FIELD xmda033
         
         
      END CONSTRUCT
      #150120新增"客戶訂單號碼"  earl(e)
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_xmdh_d[1].xmdhseq = ""
         DISPLAY ARRAY g_xmdh_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         LET g_xmdh2_d[1].xmdiseq = ""
         DISPLAY ARRAY g_xmdh2_d TO s_detail2.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY         
         LET g_xmdh4_d[1].xmdhseq = ""
         DISPLAY ARRAY g_xmdh4_d TO s_detail4.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY         
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
                  WHEN la_wc[li_idx].tableid = "xmdg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmdh_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmdi_t" 
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
   #150120新增"客戶訂單號碼"  earl(s)
   IF l_form_wc <> " 1=1" THEN
      LET g_wc2 = g_wc2," AND ",l_form_wc
      LET g_wc2_table1 = g_wc2_table1," AND xmdh001 IN (SELECT xmdadocno",
                                      "                   FROM xmda_t",
                                      "                  WHERE xmdaent = ",g_enterprise,
                                      "                    AND ",l_form_wc,")"
   END IF
   #150120新增"客戶訂單號碼"  earl(e)
   IF g_argv[01] = '8' THEN
      LET g_wc = g_wc , " AND xmdg001 = '", g_argv[01], "' "
   ELSE
      LET g_wc = g_wc , " AND xmdg001 <> '8' "
   END IF


   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmt520_filter()
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
      CONSTRUCT g_wc_filter ON xmdgdocno,xmdgdocdt,xmdg002,xmdg003,xmdg004,xmdg005,xmdg006,xmdg007
                          FROM s_browse[1].b_xmdgdocno,s_browse[1].b_xmdgdocdt,s_browse[1].b_xmdg002, 
                              s_browse[1].b_xmdg003,s_browse[1].b_xmdg004,s_browse[1].b_xmdg005,s_browse[1].b_xmdg006, 
                              s_browse[1].b_xmdg007
 
         BEFORE CONSTRUCT
               DISPLAY axmt520_filter_parser('xmdgdocno') TO s_browse[1].b_xmdgdocno
            DISPLAY axmt520_filter_parser('xmdgdocdt') TO s_browse[1].b_xmdgdocdt
            DISPLAY axmt520_filter_parser('xmdg002') TO s_browse[1].b_xmdg002
            DISPLAY axmt520_filter_parser('xmdg003') TO s_browse[1].b_xmdg003
            DISPLAY axmt520_filter_parser('xmdg004') TO s_browse[1].b_xmdg004
            DISPLAY axmt520_filter_parser('xmdg005') TO s_browse[1].b_xmdg005
            DISPLAY axmt520_filter_parser('xmdg006') TO s_browse[1].b_xmdg006
            DISPLAY axmt520_filter_parser('xmdg007') TO s_browse[1].b_xmdg007
      
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
 
      CALL axmt520_filter_show('xmdgdocno')
   CALL axmt520_filter_show('xmdgdocdt')
   CALL axmt520_filter_show('xmdg002')
   CALL axmt520_filter_show('xmdg003')
   CALL axmt520_filter_show('xmdg004')
   CALL axmt520_filter_show('xmdg005')
   CALL axmt520_filter_show('xmdg006')
   CALL axmt520_filter_show('xmdg007')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmt520_filter_parser(ps_field)
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
 
{<section id="axmt520.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmt520_filter_show(ps_field)
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
   LET ls_condition = axmt520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmt520_query()
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
   CALL g_xmdh_d.clear()
   CALL g_xmdh2_d.clear()
   CALL g_xmdh4_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#25 add     
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axmt520_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmt520_browser_fill("")
      CALL axmt520_fetch("")
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
      CALL axmt520_filter_show('xmdgdocno')
   CALL axmt520_filter_show('xmdgdocdt')
   CALL axmt520_filter_show('xmdg002')
   CALL axmt520_filter_show('xmdg003')
   CALL axmt520_filter_show('xmdg004')
   CALL axmt520_filter_show('xmdg005')
   CALL axmt520_filter_show('xmdg006')
   CALL axmt520_filter_show('xmdg007')
   CALL axmt520_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axmt520_fetch("F") 
      #顯示單身筆數
      CALL axmt520_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmt520_fetch(p_flag)
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
   
   LET g_xmdg_m.xmdgdocno = g_browser[g_current_idx].b_xmdgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
   #遮罩相關處理
   LET g_xmdg_m_mask_o.* =  g_xmdg_m.*
   CALL axmt520_xmdg_t_mask()
   LET g_xmdg_m_mask_n.* =  g_xmdg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt520_set_act_visible()   
   CALL axmt520_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   LET g_ask = TRUE   #150720-00006#1  2016/03/29  By earl add
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmdg_m_t.* = g_xmdg_m.*
   LET g_xmdg_m_o.* = g_xmdg_m.*
   
   LET g_data_owner = g_xmdg_m.xmdgownid      
   LET g_data_dept  = g_xmdg_m.xmdgowndp
   
   #重新顯示   
   CALL axmt520_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmt520_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
     
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xmdh_d.clear()   
   CALL g_xmdh2_d.clear()  
   CALL g_xmdh4_d.clear()  
 
 
   INITIALIZE g_xmdg_m.* TO NULL             #DEFAULT 設定
   
   LET g_xmdgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#25 add
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdg_m.xmdgownid = g_user
      LET g_xmdg_m.xmdgowndp = g_dept
      LET g_xmdg_m.xmdgcrtid = g_user
      LET g_xmdg_m.xmdgcrtdp = g_dept 
      LET g_xmdg_m.xmdgcrtdt = cl_get_current()
      LET g_xmdg_m.xmdgmodid = g_user
      LET g_xmdg_m.xmdgmoddt = cl_get_current()
      LET g_xmdg_m.xmdgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmdg_m.xmdg001 = "1"
      LET g_xmdg_m.xmdg034 = "1"
      LET g_xmdg_m.xmdg024 = "N"
      LET g_xmdg_m.xmdg025 = "N"
      LET g_xmdg_m.xmdg054 = "N"
      LET g_xmdg_m.xmdg057 = "1"
      LET g_xmdg_m.xmdg012 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_xmdg_m.xmdgsite = g_site
      LET g_xmdg_m.xmdgdocdt = g_today
      LET g_xmdg_m.xmdg002 = g_user
      LET g_xmdg_m.xmdg003 = g_dept
      LET g_xmdg_m.xmdg022 = g_today
      LET g_xmdg_m.xmdg028 = g_today
      CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc
      CALL s_desc_get_department_desc(g_xmdg_m.xmdg003) RETURNING g_xmdg_m.xmdg003_desc
      DISPLAY BY NAME g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003_desc
      
      IF g_argv[01] = '8' THEN
         LET g_xmdg_m.xmdg001 = g_argv[01]
      END IF
      
      CALL s_lot_clear_detail()

      LET g_xmdg_m_t.* = g_xmdg_m.*
      LET g_xmdg_m_o.* = g_xmdg_m.*
      #161031-00025#25-s
      LET g_ooff001_d = '6'   #6.單據單頭備註
      LET g_ooff002_d = g_prog
      LET g_ooff003_d = ''    #单号
      LET g_ooff004_d = '0'     #项次
      LET g_ooff005_d = ' '
      LET g_ooff006_d = ' '
      LET g_ooff007_d = ' '
      LET g_ooff008_d = ' '
      LET g_ooff009_d = ' '
      LET g_ooff010_d = ' '
      LET g_ooff011_d = ' '
      #161031-00025#25-e     
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xmdg_m_t.* = g_xmdg_m.*
      LET g_xmdg_m_o.* = g_xmdg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdg_m.xmdgstus 
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
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL axmt520_input("a")
      
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
         INITIALIZE g_xmdg_m.* TO NULL
         INITIALIZE g_xmdh_d TO NULL
         INITIALIZE g_xmdh2_d TO NULL
         INITIALIZE g_xmdh4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axmt520_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xmdh_d.clear()
      #CALL g_xmdh2_d.clear()
      #CALL g_xmdh4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt520_set_act_visible()   
   CALL axmt520_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdgent = " ||g_enterprise|| " AND",
                      " xmdgdocno = '", g_xmdg_m.xmdgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axmt520_cl
   
   CALL axmt520_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
   
   #遮罩相關處理
   LET g_xmdg_m_mask_o.* =  g_xmdg_m.*
   CALL axmt520_xmdg_t_mask()
   LET g_xmdg_m_mask_n.* =  g_xmdg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
       g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdgstus, 
       g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc, 
       g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc,g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc, 
       g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc, 
       g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid, 
       g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc, 
       g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
   
   #add-point:新增結束後 name="insert.after"
   CALL axmt520_show()  #161207-00033#35-add
   #end add-point 
   
   LET g_data_owner = g_xmdg_m.xmdgownid      
   LET g_data_dept  = g_xmdg_m.xmdgowndp
   
   #功能已完成,通報訊息中心
   CALL axmt520_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmt520_modify()
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
   LET g_xmdg_m_t.* = g_xmdg_m.*
   LET g_xmdg_m_o.* = g_xmdg_m.*
   
   IF g_xmdg_m.xmdgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
   CALL s_transaction_begin()
   
   OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt520_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT axmt520_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdg_m_mask_o.* =  g_xmdg_m.*
   CALL axmt520_xmdg_t_mask()
   LET g_xmdg_m_mask_n.* =  g_xmdg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axmt520_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xmdg_m.xmdgmodid = g_user 
LET g_xmdg_m.xmdgmoddt = cl_get_current()
LET g_xmdg_m.xmdgmodid_desc = cl_get_username(g_xmdg_m.xmdgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
     
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_xmdg_m.xmdgstus MATCHES "[DR]" THEN 
         LET g_xmdg_m.xmdgstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axmt520_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
           
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xmdg_t SET (xmdgmodid,xmdgmoddt) = (g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt)
          WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xmdg_m.* = g_xmdg_m_t.*
            CALL axmt520_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xmdg_m.xmdgdocno != g_xmdg_m_t.xmdgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                 
         #end add-point
         
         #更新單身key值
         UPDATE xmdh_t SET xmdhdocno = g_xmdg_m.xmdgdocno
 
          WHERE xmdhent = g_enterprise AND xmdhdocno = g_xmdg_m_t.xmdgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                 
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmdh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
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
         
         UPDATE xmdi_t
            SET xmdidocno = g_xmdg_m.xmdgdocno
 
          WHERE xmdient = g_enterprise AND
                xmdidocno = g_xmdgdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                 
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmdi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdi_t:",SQLERRMESSAGE 
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
   CALL axmt520_set_act_visible()   
   CALL axmt520_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmdgent = " ||g_enterprise|| " AND",
                      " xmdgdocno = '", g_xmdg_m.xmdgdocno, "' "
 
   #填到對應位置
   CALL axmt520_browser_fill("")
 
   CLOSE axmt520_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt520_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axmt520.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmt520_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_rollback             LIKE type_t.num5
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_para                 LIKE type_t.chr2
   DEFINE l_where                STRING
   DEFINE l_imaa005              LIKE imaa_t.imaa005  #特徵類別
   DEFINE l_pmaa027              LIKE pmaa_t.pmaa027  #聯絡對象識別碼
   DEFINE l_oocq019              LIKE oocq_t.oocq019
   DEFINE l_oodb011              LIKE oodb_t.oodb011
   DEFINE l_xmdhseq_backup       LIKE xmdh_t.xmdhseq    #紀錄新增多庫儲批時的項次  
   DEFINE l_ooba002              LIKE ooba_t.ooba002  #20150825-dorislai-add   
   DEFINE l_msg1                 LIKE gzze_t.gzze003   #160621-00003#3 20160629 add by beckxie
   DEFINE l_imaf055     LIKE imaf_t.imaf055  #160519-00008#9
   DEFINE l_imaf061     LIKE imaf_t.imaf061  #160519-00008#9
   #170119-00008#2  2017/01/20 By 08171 add --s
   DEFINE l_li          LIKE type_t.num10 
   DEFINE l_in          STRING    
   DEFINE l_in2         STRING      
   DEFINE l_ooac001     LIKE ooac_t.ooac001
   DEFINE l_doc         LIKE type_t.chr10
   DEFINE l_slip_str    STRING 
   DEFINE l_slip_wc2    STRING
   DEFINE l_where1      STRING
   DEFINE l_where2      STRING
   DEFINE l_where3      STRING
   #170119-00008#2  2017/01/20 By 08171 add --e 
   DEFINE l_where4      STRING           #170421-00006#1 add
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   #160621-00003#3 20160629 add by beckxie---S
   LET l_msg1 = ''
   SELECT gzze003 INTO l_msg1 FROM gzze_t WHERE gzze001 = 'aoo-00708' AND gzze002 = g_dlang 
   #160621-00003#3 20160629 add by beckxie---E
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
       g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdgstus, 
       g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc, 
       g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc,g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc, 
       g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc, 
       g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid, 
       g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc, 
       g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
   
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
   LET g_forupd_sql = "SELECT xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,xmdh007, 
       xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011,xmdh012,xmdh013, 
       xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033,xmdh050,xmdh056,xmdh030, 
       xmdh051,xmdh052,xmdhunit,xmdh035,xmdhseq,xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,xmdh028 FROM  
       xmdh_t WHERE xmdhent=? AND xmdhdocno=? AND xmdhseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt520_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
     
   #end add-point    
   LET g_forupd_sql = "SELECT xmdisite,xmdiseq,xmdiseq1,xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,xmdi006, 
       xmdi007,xmdi013,xmdi008,xmdi009,xmdi010,xmdi011,xmdi012 FROM xmdi_t WHERE xmdient=? AND xmdidocno=?  
       AND xmdiseq=? AND xmdiseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
     
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt520_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
     
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmt520_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   #161031-00025#25-s
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #161031-00025#25-e     
   #end add-point
   CALL axmt520_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002, 
       g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028,g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031,g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014, 
       g_xmdg_m.xmdg015
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmt520.input.head" >}
      #單頭段
      INPUT BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002, 
          g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006, 
          g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028,g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024, 
          g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031,g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg057, 
          g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016, 
          g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010, 
          g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014, 
          g_xmdg_m.xmdg015 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt520_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axmt520_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_xmdg_m_t.* = g_xmdg_m.*
            LET g_xmdg_m_o.* = g_xmdg_m.*
            
            #end add-point
            CALL axmt520_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgdocno
            
            #add-point:AFTER FIELD xmdgdocno name="input.a.xmdgdocno"
            LET g_xmdg_m.xmdgdocno_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdgdocno_desc
            IF cl_null(g_xmdg_m.xmdgdocno) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00532'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdgdocno != g_xmdgdocno_t OR g_xmdgdocno_t IS NULL )) THEN
                  IF NOT axmt520_xmdgdocno_chk() THEN
                     LET g_xmdg_m.xmdgdocno = g_xmdgdocno_t
                     CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno) RETURNING g_xmdg_m.xmdgdocno_desc
                     DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160204-00004 160302 by lori mark---(S)
                  ##150909 earl add s
                  ##檢核前後置單別的合理性
                  #IF NOT cl_null(g_xmdg_m.xmdg004) THEN
                  #   IF NOT s_aooi210_check_doc(g_site,'',g_xmdg_m.xmdg004,g_xmdg_m.xmdgdocno,'3','') THEN
                  #      LET g_xmdg_m.xmdgdocno = g_xmdgdocno_t
                  #      CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno) RETURNING g_xmdg_m.xmdgdocno_desc
                  #      DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc
                  #      NEXT FIELD CURRENT
                  #   END IF
                  #END IF
                  #150909 earl add e
                  
                  #CALL axmt520_doc_default()
                  #160204-00004 160302 by lori mark---(E)
               END IF
               
               #160204-00004 160302 by lori add---(S)
               IF g_xmdg_m.xmdgdocno != g_xmdg_m_o.xmdgdocno OR cl_null(g_xmdg_m_o.xmdgdocno) THEN
                  LET g_xmdg_m.xmdg004 = ''
                  DISPLAY BY NAME g_xmdg_m.xmdg004
                  
                  CALL axmt520_doc_default()
               END IF
               #160204-00004 160302 by lori add---(E)
               
            END IF
            
            LET g_xmdg_m_o.xmdgdocno = g_xmdg_m.xmdgdocno   #160204-00004 160302 by lori add
            CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno) RETURNING g_xmdg_m.xmdgdocno_desc
            DISPLAY BY NAME g_xmdg_m.xmdgdocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgdocno
            #add-point:BEFORE FIELD xmdgdocno name="input.b.xmdgdocno"
                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdgdocno
            #add-point:ON CHANGE xmdgdocno name="input.g.xmdgdocno"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgdocdt
            #add-point:BEFORE FIELD xmdgdocdt name="input.b.xmdgdocdt"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgdocdt
            
            #add-point:AFTER FIELD xmdgdocdt name="input.a.xmdgdocdt"
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdgdocdt
            #add-point:ON CHANGE xmdgdocdt name="input.g.xmdgdocdt"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg004
            
            #add-point:AFTER FIELD xmdg004 name="input.a.xmdg004"
            IF NOT cl_null(g_xmdg_m.xmdg004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg004 != g_xmdg_m_o.xmdg004 OR g_xmdg_m_o.xmdg004 IS NULL )) THEN                  
                  IF NOT axmt520_xmdadocno_chk(g_xmdg_m.xmdg004,'1') THEN
                     LET g_xmdg_m.xmdg004 = g_xmdg_m_o.xmdg004 
                     DISPLAY BY NAME g_xmdg_m.xmdg004
                     NEXT FIELD CURRENT
                  END IF
                  CALL axmt520_xmdg004_default()
               END IF
            END IF
            CALL axmt520_set_entry(p_cmd)
            CALL axmt520_set_no_entry(p_cmd)
            LET g_xmdg_m_o.xmdg004 = g_xmdg_m.xmdg004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg004
            #add-point:BEFORE FIELD xmdg004 name="input.b.xmdg004"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg004
            #add-point:ON CHANGE xmdg004 name="input.g.xmdg004"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgsite
            #add-point:BEFORE FIELD xmdgsite name="input.b.xmdgsite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgsite
            
            #add-point:AFTER FIELD xmdgsite name="input.a.xmdgsite"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdgsite
            #add-point:ON CHANGE xmdgsite name="input.g.xmdgsite"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg002
            
            #add-point:AFTER FIELD xmdg002 name="input.a.xmdg002"
            LET g_xmdg_m.xmdg002_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg002_desc
            IF NOT cl_null(g_xmdg_m.xmdg002) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg002 != g_xmdg_m_o.xmdg002 OR g_xmdg_m_o.xmdg002 IS NULL )) THEN
               IF g_xmdg_m.xmdg002 != g_xmdg_m_o.xmdg002 OR g_xmdg_m_o.xmdg002 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg002
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#15 by 07900 --add-end
                  IF cl_chk_exist("v_ooag001") THEN
                     #抓取業務人員對應的部門預設到xmdg003
                     SELECT ooag003 INTO g_xmdg_m.xmdg003 FROM ooag_t
                      WHERE ooagent = g_enterprise AND ooag001 = g_xmdg_m.xmdg002
                     CALL s_desc_get_department_desc(g_xmdg_m.xmdg003) RETURNING g_xmdg_m.xmdg003_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc
                  ELSE
                     LET g_xmdg_m.xmdg002 = g_xmdg_m_o.xmdg002 
                     CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc
            DISPLAY BY NAME g_xmdg_m.xmdg002_desc
            LET g_xmdg_m_o.xmdg002 = g_xmdg_m.xmdg002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg002
            #add-point:BEFORE FIELD xmdg002 name="input.b.xmdg002"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg002
            #add-point:ON CHANGE xmdg002 name="input.g.xmdg002"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg003
            
            #add-point:AFTER FIELD xmdg003 name="input.a.xmdg003"
            LET g_xmdg_m.xmdg003_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg003_desc
            IF NOT cl_null(g_xmdg_m.xmdg003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg003 != g_xmdg_m_o.xmdg003 OR g_xmdg_m_o.xmdg003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg003
                  LET g_chkparam.arg2 = g_xmdg_m.xmdgdocdt
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#15 by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_xmdg_m.xmdg003 = g_xmdg_m_o.xmdg003 
                     CALL s_desc_get_department_desc(g_xmdg_m.xmdg003) RETURNING g_xmdg_m.xmdg003_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_xmdg_m.xmdg003) RETURNING g_xmdg_m.xmdg003_desc
            DISPLAY BY NAME g_xmdg_m.xmdg003_desc
            LET g_xmdg_m_o.xmdg003 = g_xmdg_m.xmdg003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg003
            #add-point:BEFORE FIELD xmdg003 name="input.b.xmdg003"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg003
            #add-point:ON CHANGE xmdg003 name="input.g.xmdg003"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdgstus
            #add-point:BEFORE FIELD xmdgstus name="input.b.xmdgstus"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdgstus
            
            #add-point:AFTER FIELD xmdgstus name="input.a.xmdgstus"
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdgstus
            #add-point:ON CHANGE xmdgstus name="input.g.xmdgstus"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg001
            #add-point:BEFORE FIELD xmdg001 name="input.b.xmdg001"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg001
            
            #add-point:AFTER FIELD xmdg001 name="input.a.xmdg001"
            #add by shiun--------------------------
            LET g_xmdg_m_o.xmdg001 = g_xmdg_m.xmdg001
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg001
            #add-point:ON CHANGE xmdg001 name="input.g.xmdg001"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg034
            #add-point:BEFORE FIELD xmdg034 name="input.b.xmdg034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg034
            
            #add-point:AFTER FIELD xmdg034 name="input.a.xmdg034"
            LET g_xmdg_m_o.xmdg034 = g_xmdg_m.xmdg034
            CALL axmt520_set_entry(p_cmd)
            CALL axmt520_set_no_entry(p_cmd)
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg034
            #add-point:ON CHANGE xmdg034 name="input.g.xmdg034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg005
            
            #add-point:AFTER FIELD xmdg005 name="input.a.xmdg005"
            LET g_xmdg_m.xmdg005_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg005_desc
            IF NOT cl_null(g_xmdg_m.xmdg005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg005 != g_xmdg_m_o.xmdg005 OR g_xmdg_m_o.xmdg005 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                   LET g_errshow = TRUE #是否開窗
                   #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg005
                  LET g_chkparam.arg2 = g_site
                   #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_pmaa001_3") THEN
                     LET g_xmdg_m.xmdg005 = g_xmdg_m_o.xmdg005 
                     CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005) RETURNING g_xmdg_m.xmdg005_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150721-00001#1  2016/01/08 By earl mod s
#                  IF NOT s_control_check_customer(g_xmdg_m.xmdg005,'2',g_site,g_user,g_dept,g_xmdg_m.xmdgdocno) THEN
#                     LET g_xmdg_m.xmdg005 = g_xmdg_m_o.xmdg005 
#                     CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005) RETURNING g_xmdg_m.xmdg005_desc
#                     DISPLAY BY NAME g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  
                  CALL s_control_chk_doc('3',g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                      LET g_xmdg_m.xmdg005 = g_xmdg_m_o.xmdg005 
                      CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005) RETURNING g_xmdg_m.xmdg005_desc
                      DISPLAY BY NAME g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc
                      NEXT FIELD CURRENT
                  END IF
                  #150721-00001#1  2016/01/08 By earl mod e
                  
                  #若出通單上的訂單沒有輸入時，在輸入客戶編號後需自動帶預設交易條件
                  IF cl_null(g_xmdg_m.xmdg004) THEN
                     CALL axmt520_xmdg005_default()
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005) RETURNING g_xmdg_m.xmdg005_desc
            DISPLAY BY NAME g_xmdg_m.xmdg005_desc
            LET g_xmdg_m_o.xmdg005 = g_xmdg_m.xmdg005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg005
            #add-point:BEFORE FIELD xmdg005 name="input.b.xmdg005"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg005
            #add-point:ON CHANGE xmdg005 name="input.g.xmdg005"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg006
            
            #add-point:AFTER FIELD xmdg006 name="input.a.xmdg006"
            LET g_xmdg_m.xmdg006_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg006_desc
            IF NOT cl_null(g_xmdg_m.xmdg006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg006 != g_xmdg_m_o.xmdg006 OR g_xmdg_m_o.xmdg006 IS NULL )) THEN
                  IF g_xmdg_m.xmdg006 <> g_xmdg_m.xmdg005 THEN
                     INITIALIZE g_chkparam.* TO NULL
                      #160318-00025#15 by 07900 --add-str 
                     LET g_errshow = TRUE #是否開窗
                     #160318-00025#15 by 07900 --add-end
                     LET g_chkparam.arg1 = g_xmdg_m.xmdg005
                     LET g_chkparam.arg2 = g_xmdg_m.xmdg006
                     LET g_chkparam.arg3 = g_site
                     #160318-00025#15 by 07900 --add-str 
                     LET g_chkparam.err_str[1] ="axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
                     #160318-00025#15 by 07900 --add-end
                     IF NOT cl_chk_exist("v_pmac002") THEN
                        LET g_xmdg_m.xmdg006 = g_xmdg_m_o.xmdg006 
                        CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006) RETURNING g_xmdg_m.xmdg006_desc
                        DISPLAY BY NAME g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006) RETURNING g_xmdg_m.xmdg006_desc
            DISPLAY BY NAME g_xmdg_m.xmdg006_desc
            LET g_xmdg_m_o.xmdg006 = g_xmdg_m.xmdg006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg006
            #add-point:BEFORE FIELD xmdg006 name="input.b.xmdg006"
            IF cl_null(g_xmdg_m.xmdg005) THEN
               #請先輸入客戶編號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg006
            #add-point:ON CHANGE xmdg006 name="input.g.xmdg006"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg007
            
            #add-point:AFTER FIELD xmdg007 name="input.a.xmdg007"
            LET g_xmdg_m.xmdg007_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg007_desc
            IF NOT cl_null(g_xmdg_m.xmdg007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg007 != g_xmdg_m_o.xmdg007 OR g_xmdg_m_o.xmdg007 IS NULL )) THEN
                  IF g_xmdg_m.xmdg007 <> g_xmdg_m.xmdg005 THEN
                     INITIALIZE g_chkparam.* TO NULL
                      #160318-00025#15 by 07900 --add-str 
                     LET g_errshow = TRUE #是否開窗
                     #160318-00025#15 by 07900 --add-end
                     LET g_chkparam.arg1 = g_xmdg_m.xmdg005
                     LET g_chkparam.arg2 = g_xmdg_m.xmdg007
                     LET g_chkparam.arg3 = g_site
                      #160318-00025#15 by 07900 --add-str 
                     LET g_chkparam.err_str[1] ="axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
                     #160318-00025#15 by 07900 --add-end
                     IF NOT cl_chk_exist("v_pmac002_2") THEN
                        LET g_xmdg_m.xmdg007 = g_xmdg_m_o.xmdg007 
                        CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007) RETURNING g_xmdg_m.xmdg007_desc
                        DISPLAY BY NAME g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007) RETURNING g_xmdg_m.xmdg007_desc
            DISPLAY BY NAME g_xmdg_m.xmdg007_desc
            LET g_xmdg_m_o.xmdg007 = g_xmdg_m.xmdg007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg007
            #add-point:BEFORE FIELD xmdg007 name="input.b.xmdg007"
            IF cl_null(g_xmdg_m.xmdg005) THEN
               #請先輸入客戶編號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg007
            #add-point:ON CHANGE xmdg007 name="input.g.xmdg007"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg202
            
            #add-point:AFTER FIELD xmdg202 name="input.a.xmdg202"
            LET g_xmdg_m.xmdg202_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg202_desc
            IF NOT cl_null(g_xmdg_m.xmdg202) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg202 != g_xmdg_m_o.xmdg202 OR g_xmdg_m_o.xmdg202 IS NULL )) THEN
                  IF g_xmdg_m.xmdg202 <> g_xmdg_m.xmdg005 THEN
                     INITIALIZE g_chkparam.* TO NULL
                     #160318-00025#15 by 07900 --add-str 
                     LET g_errshow = TRUE #是否開窗
                     #160318-00025#15 by 07900 --add-end
                     LET g_chkparam.arg1 = g_xmdg_m.xmdg005
                     LET g_chkparam.arg2 = g_xmdg_m.xmdg202
                     LET g_chkparam.arg3 = g_site
                      #160318-00025#15 by 07900 --add-str 
                     LET g_chkparam.err_str[1] ="axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
                     #160318-00025#15 by 07900 --add-end
                     IF NOT cl_chk_exist("v_pmac002_6") THEN
                        LET g_xmdg_m.xmdg202 = g_xmdg_m_o.xmdg202
                        CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg202) RETURNING g_xmdg_m.xmdg202_desc
                        DISPLAY BY NAME g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg202) RETURNING g_xmdg_m.xmdg202_desc
            DISPLAY BY NAME g_xmdg_m.xmdg202_desc
            LET g_xmdg_m_o.xmdg202 = g_xmdg_m.xmdg202
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg202
            #add-point:BEFORE FIELD xmdg202 name="input.b.xmdg202"
            IF cl_null(g_xmdg_m.xmdg005) THEN
               #請先輸入客戶編號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg202
            #add-point:ON CHANGE xmdg202 name="input.g.xmdg202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg028
            #add-point:BEFORE FIELD xmdg028 name="input.b.xmdg028"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg028
            
            #add-point:AFTER FIELD xmdg028 name="input.a.xmdg028"
            IF NOT cl_null(g_xmdg_m.xmdg028) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg028 != g_xmdg_m_o.xmdg028 OR g_xmdg_m_o.xmdg028 IS NULL )) THEN
                  IF g_xmdg_m.xmdg028 < g_xmdg_m.xmdgdocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00143'
                     LET g_errparam.extend = g_xmdg_m.xmdg028
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdg_m.xmdg028 = g_xmdg_m_o.xmdg028
                     DISPLAY BY NAME g_xmdg_m.xmdg028
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_xmdg_m_o.xmdg028 = g_xmdg_m.xmdg028
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg028
            #add-point:ON CHANGE xmdg028 name="input.g.xmdg028"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg026
            
            #add-point:AFTER FIELD xmdg026 name="input.a.xmdg026"
            LET g_xmdg_m.xmdg026_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg026_desc
            IF NOT cl_null(g_xmdg_m.xmdg026) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg026 != g_xmdg_m_o.xmdg026 OR g_xmdg_m_o.xmdg026 IS NULL )) THEN
                  #160621-00003#3 20160627 modify by beckxie---S
                  #IF NOT s_azzi650_chk_exist('275',g_xmdg_m.xmdg026) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg026
                  LET g_chkparam.arg2 = '1'
                  LET g_chkparam.err_str[1] = "aoo-00299|",l_msg1
                  IF NOT cl_chk_exist("v_oojd001") THEN
                  #160621-00003#3 20160627 modify by beckxie---E
                  
                     LET g_xmdg_m.xmdg026 = g_xmdg_m_o.xmdg026
                     #160621-00003#3 20160629 modify by beckxie---S
                     #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
                     CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
                     #160621-00003#3 20160629 modify by beckxie---E
                     DISPLAY BY NAME g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160621-00003#3 20160629 modify by beckxie---S
            #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
            CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
            #160621-00003#3 20160629 modify by beckxie---E
            DISPLAY BY NAME g_xmdg_m.xmdg026_desc
            LET g_xmdg_m_o.xmdg026 = g_xmdg_m.xmdg026
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg026
            #add-point:BEFORE FIELD xmdg026 name="input.b.xmdg026"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg026
            #add-point:ON CHANGE xmdg026 name="input.g.xmdg026"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg027
            
            #add-point:AFTER FIELD xmdg027 name="input.a.xmdg027"
            LET g_xmdg_m.xmdg027_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg027_desc
            IF NOT cl_null(g_xmdg_m.xmdg027) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg027 != g_xmdg_m_o.xmdg027 OR g_xmdg_m_o.xmdg027 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('295',g_xmdg_m.xmdg027) THEN
                     LET g_xmdg_m.xmdg027 = g_xmdg_m_o.xmdg027
                     CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027) RETURNING g_xmdg_m.xmdg027_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027) RETURNING g_xmdg_m.xmdg027_desc
            DISPLAY BY NAME g_xmdg_m.xmdg027_desc
            LET g_xmdg_m_o.xmdg027 = g_xmdg_m.xmdg027
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg027
            #add-point:BEFORE FIELD xmdg027 name="input.b.xmdg027"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg027
            #add-point:ON CHANGE xmdg027 name="input.g.xmdg027"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg024
            #add-point:BEFORE FIELD xmdg024 name="input.b.xmdg024"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg024
            
            #add-point:AFTER FIELD xmdg024 name="input.a.xmdg024"
            LET g_xmdg_m_o.xmdg024 = g_xmdg_m.xmdg024
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg024
            #add-point:ON CHANGE xmdg024 name="input.g.xmdg024"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg025
            #add-point:BEFORE FIELD xmdg025 name="input.b.xmdg025"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg025
            
            #add-point:AFTER FIELD xmdg025 name="input.a.xmdg025"
            LET g_xmdg_m_o.xmdg025 = g_xmdg_m.xmdg025
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg025
            #add-point:ON CHANGE xmdg025 name="input.g.xmdg025"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg030
            
            #add-point:AFTER FIELD xmdg030 name="input.a.xmdg030"
            LET g_xmdg_m.xmdg030_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg030_desc
            IF NOT cl_null(g_xmdg_m.xmdg030) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg030 != g_xmdg_m_o.xmdg030 OR g_xmdg_m_o.xmdg030 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = '209'
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg030
                  #160318-00025#15 by 07900 --add-str 
                 LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_oocq002_1") THEN
                     LET g_xmdg_m.xmdg030 = g_xmdg_m_o.xmdg030
                     CALL s_desc_get_acc_desc('209',g_xmdg_m.xmdg030) RETURNING g_xmdg_m.xmdg030_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('209',g_xmdg_m.xmdg030) RETURNING g_xmdg_m.xmdg030_desc
            DISPLAY BY NAME g_xmdg_m.xmdg030_desc
            LET g_xmdg_m_o.xmdg030 = g_xmdg_m.xmdg030
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg030
            #add-point:BEFORE FIELD xmdg030 name="input.b.xmdg030"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg030
            #add-point:ON CHANGE xmdg030 name="input.g.xmdg030"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg031
            
            #add-point:AFTER FIELD xmdg031 name="input.a.xmdg031"
            LET g_xmdg_m.xmdg031_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            IF NOT cl_null(g_xmdg_m.xmdg031) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg031 != g_xmdg_m_o.xmdg031 OR g_xmdg_m_o.xmdg031 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('297',g_xmdg_m.xmdg031) THEN
                     LET g_xmdg_m.xmdg031 = g_xmdg_m_o.xmdg031
                     CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031) RETURNING g_xmdg_m.xmdg031_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031) RETURNING g_xmdg_m.xmdg031_desc
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            LET g_xmdg_m_o.xmdg031 = g_xmdg_m.xmdg031
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg031
            #add-point:BEFORE FIELD xmdg031 name="input.b.xmdg031"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg031
            #add-point:ON CHANGE xmdg031 name="input.g.xmdg031"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg053
            #add-point:BEFORE FIELD xmdg053 name="input.b.xmdg053"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg053
            
            #add-point:AFTER FIELD xmdg053 name="input.a.xmdg053"
            LET g_xmdg_m_o.xmdg053 = g_xmdg_m.xmdg053
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg053
            #add-point:ON CHANGE xmdg053 name="input.g.xmdg053"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg056
            
            #add-point:AFTER FIELD xmdg056 name="input.a.xmdg056"
            LET g_xmdg_m.xmdg056_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg056_desc
            IF NOT cl_null(g_xmdg_m.xmdg056) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg056 != g_xmdg_m_o.xmdg056 OR g_xmdg_m_o.xmdg056 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg056
                  LET g_chkparam.arg2 = g_site
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"
                  #160318-00025#15 by 07900 --add-end
                  IF NOT cl_chk_exist("v_icaa001_7") THEN
                     LET g_xmdg_m.xmdg056 = g_xmdg_m_o.xmdg056
                     CALL s_desc_get_icaa001_desc(g_xmdg_m.xmdg056) RETURNING g_xmdg_m.xmdg056_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_icaa001_desc(g_xmdg_m.xmdg056) RETURNING g_xmdg_m.xmdg056_desc
            DISPLAY BY NAME g_xmdg_m.xmdg056_desc
            LET g_xmdg_m_o.xmdg056 = g_xmdg_m.xmdg056

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg056
            #add-point:BEFORE FIELD xmdg056 name="input.b.xmdg056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg056
            #add-point:ON CHANGE xmdg056 name="input.g.xmdg056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg057
            #add-point:BEFORE FIELD xmdg057 name="input.b.xmdg057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg057
            
            #add-point:AFTER FIELD xmdg057 name="input.a.xmdg057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg057
            #add-point:ON CHANGE xmdg057 name="input.g.xmdg057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg058
            #add-point:BEFORE FIELD xmdg058 name="input.b.xmdg058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg058
            
            #add-point:AFTER FIELD xmdg058 name="input.a.xmdg058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg058
            #add-point:ON CHANGE xmdg058 name="input.g.xmdg058"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg017
            
            #add-point:AFTER FIELD xmdg017 name="input.a.xmdg017"
            LET g_xmdg_m.xmdg017_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg017_desc
            IF NOT cl_null(g_xmdg_m.xmdg017) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg017 != g_xmdg_m_o.xmdg017 OR g_xmdg_m_o.xmdg017 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end 
                  CALL s_axmt500_get_pmaa027(g_xmdg_m.xmdg007) RETURNING l_pmaa027
                  LET g_chkparam.arg1 = l_pmaa027
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg017
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
                  #160318-00025#15 by 07900 --add-end
                  IF NOT cl_chk_exist("v_oofb019") THEN
                     LET g_xmdg_m.xmdg017 = g_xmdg_m_o.xmdg017
                     DISPLAY BY NAME g_xmdg_m.xmdg017
                     CALL axmt520_xmdg017_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmt520_xmdg017_ref()
            LET g_xmdg_m_o.xmdg017 = g_xmdg_m.xmdg017
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg017
            #add-point:BEFORE FIELD xmdg017 name="input.b.xmdg017"
            IF cl_null(g_xmdg_m.xmdg007) THEN
               #請先輸入收貨客戶
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00146'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg007
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg017
            #add-point:ON CHANGE xmdg017 name="input.g.xmdg017"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg018
            
            #add-point:AFTER FIELD xmdg018 name="input.a.xmdg018"
            LET g_xmdg_m.xmdg018_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg018_desc
            IF NOT cl_null(g_xmdg_m.xmdg018) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg018 != g_xmdg_m_o.xmdg018 OR g_xmdg_m_o.xmdg018 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('263',g_xmdg_m.xmdg018) THEN
                     LET g_xmdg_m.xmdg018 = g_xmdg_m_o.xmdg018
                     CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018) RETURNING g_xmdg_m.xmdg018_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018) RETURNING g_xmdg_m.xmdg018_desc
            DISPLAY BY NAME g_xmdg_m.xmdg018_desc
            LET g_xmdg_m_o.xmdg018 = g_xmdg_m.xmdg018
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg018
            #add-point:BEFORE FIELD xmdg018 name="input.b.xmdg018"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg018
            #add-point:ON CHANGE xmdg018 name="input.g.xmdg018"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg019
            
            #add-point:AFTER FIELD xmdg019 name="input.a.xmdg019"
            LET g_xmdg_m.xmdg019_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg019_desc
            IF NOT cl_null(g_xmdg_m.xmdg019) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg019 != g_xmdg_m_o.xmdg019 OR g_xmdg_m_o.xmdg019 IS NULL )) THEN
                  CALL s_apmi011_check_location(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_xmdg_m.xmdg019 = g_xmdg_m_o.xmdg019
                     CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019) RETURNING g_xmdg_m.xmdg019_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019) RETURNING g_xmdg_m.xmdg019_desc
            DISPLAY BY NAME g_xmdg_m.xmdg019_desc
            LET g_xmdg_m_o.xmdg019 = g_xmdg_m.xmdg019
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg019
            #add-point:BEFORE FIELD xmdg019 name="input.b.xmdg019"
            IF cl_null(g_xmdg_m.xmdg018) THEN
               #請先輸入運輸方式
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg018
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg019
            #add-point:ON CHANGE xmdg019 name="input.g.xmdg019"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg020
            
            #add-point:AFTER FIELD xmdg020 name="input.a.xmdg020"
            LET g_xmdg_m.xmdg020_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg020_desc
            IF NOT cl_null(g_xmdg_m.xmdg020) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg020 != g_xmdg_m_o.xmdg020 OR g_xmdg_m_o.xmdg020 IS NULL )) THEN
                  CALL s_apmi011_check_location(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_xmdg_m.xmdg020 = g_xmdg_m_o.xmdg020
                     CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020) RETURNING g_xmdg_m.xmdg020_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020) RETURNING g_xmdg_m.xmdg020_desc
            DISPLAY BY NAME g_xmdg_m.xmdg020_desc
            LET g_xmdg_m_o.xmdg020 = g_xmdg_m.xmdg020
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg020
            #add-point:BEFORE FIELD xmdg020 name="input.b.xmdg020"
            IF cl_null(g_xmdg_m.xmdg018) THEN
               #請先輸入運輸方式   
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg018
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg020
            #add-point:ON CHANGE xmdg020 name="input.g.xmdg020"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg016
            
            #add-point:AFTER FIELD xmdg016 name="input.a.xmdg016"
            LET g_xmdg_m.xmdg016_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg016_desc
            IF NOT cl_null(g_xmdg_m.xmdg016) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg016 != g_xmdg_m_o.xmdg016 OR g_xmdg_m_o.xmdg016 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg016
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_xmdg_m.xmdg016 = g_xmdg_m_o.xmdg016 
                     CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016) RETURNING g_xmdg_m.xmdg016_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg016,g_xmdg_m.xmdg016_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150721-00001#1  2016/01/08 By earl add s
                  #檢核供應商編號的生命週期是否在單據別的限制範圍內
                  CALL s_control_chk_doc('2',g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg016,'','','','')
                       RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_xmdg_m.xmdg016 = g_xmdg_m_o.xmdg016 
                     CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016) RETURNING g_xmdg_m.xmdg016_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg016,g_xmdg_m.xmdg016_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150721-00001#1  2016/01/08 By earl add e
                  
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016) RETURNING g_xmdg_m.xmdg016_desc
            DISPLAY BY NAME g_xmdg_m.xmdg016_desc
            LET g_xmdg_m_o.xmdg016 = g_xmdg_m.xmdg016
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg016
            #add-point:BEFORE FIELD xmdg016 name="input.b.xmdg016"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg016
            #add-point:ON CHANGE xmdg016 name="input.g.xmdg016"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg021
            #add-point:BEFORE FIELD xmdg021 name="input.b.xmdg021"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg021
            
            #add-point:AFTER FIELD xmdg021 name="input.a.xmdg021"
            LET g_xmdg_m_o.xmdg021 = g_xmdg_m.xmdg021
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg021
            #add-point:ON CHANGE xmdg021 name="input.g.xmdg021"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg022
            #add-point:BEFORE FIELD xmdg022 name="input.b.xmdg022"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg022
            
            #add-point:AFTER FIELD xmdg022 name="input.a.xmdg022"
            LET g_xmdg_m_o.xmdg022 = g_xmdg_m.xmdg022
                      
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg022
            #add-point:ON CHANGE xmdg022 name="input.g.xmdg022"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg023
            
            #add-point:AFTER FIELD xmdg023 name="input.a.xmdg023"
            LET g_xmdg_m.xmdg023_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg023_desc
            IF NOT cl_null(g_xmdg_m.xmdg023) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg023 != g_xmdg_m_o.xmdg023 OR g_xmdg_m_o.xmdg023 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_xmdg_m.xmdg005 #160119-00015#1-mod-(S)
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg007  #160119-00015#1-mod-(E)
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg023
                  IF NOT cl_chk_exist("v_xmao002") THEN
                     LET g_xmdg_m.xmdg023 = g_xmdg_m_o.xmdg023
                     CALL axmt520_xmdg023_ref()
                     DISPLAY BY NAME g_xmdg_m.xmdg023
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmt520_xmdg023_ref()
            LET g_xmdg_m_o.xmdg023 = g_xmdg_m.xmdg023
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg023
            #add-point:BEFORE FIELD xmdg023 name="input.b.xmdg023"
            IF cl_null(g_xmdg_m.xmdg005) THEN
               #請先輸入客戶編號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg023
            #add-point:ON CHANGE xmdg023 name="input.g.xmdg023"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg008
            
            #add-point:AFTER FIELD xmdg008 name="input.a.xmdg008"
            LET g_xmdg_m.xmdg008_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg008_desc
            IF NOT cl_null(g_xmdg_m.xmdg008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg008 != g_xmdg_m_o.xmdg008 OR g_xmdg_m_o.xmdg008 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg005
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg008
                  IF NOT cl_chk_exist("v_pmad002_2") THEN
                     LET g_xmdg_m.xmdg008 = g_xmdg_m_o.xmdg008
                     DISPLAY BY NAME g_xmdg_m.xmdg008
                     CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008) RETURNING g_xmdg_m.xmdg008_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008) RETURNING g_xmdg_m.xmdg008_desc
            DISPLAY BY NAME g_xmdg_m.xmdg008_desc
            LET g_xmdg_m_o.xmdg008 = g_xmdg_m.xmdg008
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg008
            #add-point:BEFORE FIELD xmdg008 name="input.b.xmdg008"
            IF cl_null(g_xmdg_m.xmdg005) THEN
               #請先輸入客戶編號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdg005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg008
            #add-point:ON CHANGE xmdg008 name="input.g.xmdg008"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg009
            
            #add-point:AFTER FIELD xmdg009 name="input.a.xmdg009"
            LET g_xmdg_m.xmdg009_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg009_desc
            IF NOT cl_null(g_xmdg_m.xmdg009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg009 != g_xmdg_m_o.xmdg009 OR g_xmdg_m_o.xmdg009 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = '238'
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg009
                   #160318-00025#15 by 07900 --add-str 
                 LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_oocq002_1") THEN
                     LET g_xmdg_m.xmdg009 = g_xmdg_m_o.xmdg009
                     CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009) RETURNING g_xmdg_m.xmdg009_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009) RETURNING g_xmdg_m.xmdg009_desc
            DISPLAY BY NAME g_xmdg_m.xmdg009_desc
            LET g_xmdg_m_o.xmdg009 = g_xmdg_m.xmdg009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg009
            #add-point:BEFORE FIELD xmdg009 name="input.b.xmdg009"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg009
            #add-point:ON CHANGE xmdg009 name="input.g.xmdg009"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg010
            
            #add-point:AFTER FIELD xmdg010 name="input.a.xmdg010"
            LET g_xmdg_m.xmdg010_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg010_desc
            IF NOT cl_null(g_xmdg_m.xmdg010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg010 != g_xmdg_m_o.xmdg010 OR g_xmdg_m_o.xmdg010 IS NULL )) THEN
                  CALL s_tax_chk(g_site,g_xmdg_m.xmdg010)
                       RETURNING l_success,g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg012,g_xmdg_m.xmdg011,l_oodb011
                       DISPLAY BY NAME g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg012,g_xmdg_m.xmdg011
                  IF NOT l_success THEN
                     LET g_xmdg_m.xmdg010 = g_xmdg_m_o.xmdg010
                     LET g_xmdg_m.xmdg011 = g_xmdg_m_o.xmdg011
                     LET g_xmdg_m.xmdg012 = g_xmdg_m_o.xmdg012
                     CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010) RETURNING g_xmdg_m.xmdg010_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010) RETURNING g_xmdg_m.xmdg010_desc
            DISPLAY BY NAME g_xmdg_m.xmdg010_desc
            LET g_xmdg_m_o.xmdg010 = g_xmdg_m.xmdg010
            LET g_xmdg_m_o.xmdg011 = g_xmdg_m.xmdg011
            LET g_xmdg_m_o.xmdg012 = g_xmdg_m.xmdg012
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg010
            #add-point:BEFORE FIELD xmdg010 name="input.b.xmdg010"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg010
            #add-point:ON CHANGE xmdg010 name="input.g.xmdg010"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg011
            #add-point:BEFORE FIELD xmdg011 name="input.b.xmdg011"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg011
            
            #add-point:AFTER FIELD xmdg011 name="input.a.xmdg011"
            LET g_xmdg_m_o.xmdg011 = g_xmdg_m.xmdg011
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg011
            #add-point:ON CHANGE xmdg011 name="input.g.xmdg011"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg012
            #add-point:BEFORE FIELD xmdg012 name="input.b.xmdg012"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg012
            
            #add-point:AFTER FIELD xmdg012 name="input.a.xmdg012"
            LET g_xmdg_m_o.xmdg012 = g_xmdg_m.xmdg012
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg012
            #add-point:ON CHANGE xmdg012 name="input.g.xmdg012"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg013
            
            #add-point:AFTER FIELD xmdg013 name="input.a.xmdg013"
            LET g_xmdg_m.xmdg013_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg013_desc
            IF NOT cl_null(g_xmdg_m.xmdg013) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg013 != g_xmdg_m_o.xmdg013 OR g_xmdg_m_o.xmdg013 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg013
                  IF NOT cl_chk_exist("v_isac002") THEN
                     LET g_xmdg_m.xmdg013 = g_xmdg_m_o.xmdg013
                     CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013) RETURNING g_xmdg_m.xmdg013_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013) RETURNING g_xmdg_m.xmdg013_desc
            DISPLAY BY NAME g_xmdg_m.xmdg013_desc
            LET g_xmdg_m_o.xmdg013 = g_xmdg_m.xmdg013
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg013
            #add-point:BEFORE FIELD xmdg013 name="input.b.xmdg013"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg013
            #add-point:ON CHANGE xmdg013 name="input.g.xmdg013"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg032
            #add-point:BEFORE FIELD xmdg032 name="input.b.xmdg032"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg032
            
            #add-point:AFTER FIELD xmdg032 name="input.a.xmdg032"
            IF NOT cl_null(g_xmdg_m.xmdg032) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg032 != g_xmdg_m_o.xmdg032 OR g_xmdg_m_o.xmdg032 IS NULL )) THEN
                  IF NOT cl_null(g_xmdg_m.xmdg014) THEN
                     #add--2015/11/19 By shiun--(S)
                     CALL axmt520_xmda_xmdg015() RETURNING g_xmdg_m.xmdg015
                     IF cl_null(g_xmdg_m.xmdg015) THEN                     
                        CALL s_axmt540_get_exchange(g_xmdg_m.xmdg032,g_xmdg_m.xmdg014,g_xmdg_m.xmdgdocdt) RETURNING g_xmdg_m.xmdg015   #modify--2015/11/18 By shiun     新增傳入參數
                     END IF
                     #add--2015/11/19 By shiun--(E)
                     DISPLAY BY NAME g_xmdg_m.xmdg015
                  END IF
               END IF
            END IF
            LET g_xmdg_m_o.xmdg032 = g_xmdg_m.xmdg032
            LET g_xmdg_m_o.xmdg015 = g_xmdg_m.xmdg015
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg032
            #add-point:ON CHANGE xmdg032 name="input.g.xmdg032"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg033
            #add-point:BEFORE FIELD xmdg033 name="input.b.xmdg033"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg033
            
            #add-point:AFTER FIELD xmdg033 name="input.a.xmdg033"
            LET g_xmdg_m_o.xmdg033 = g_xmdg_m.xmdg033
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg033
            #add-point:ON CHANGE xmdg033 name="input.g.xmdg033"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg014
            
            #add-point:AFTER FIELD xmdg014 name="input.a.xmdg014"
            LET g_xmdg_m.xmdg014_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg014_desc
            IF NOT cl_null(g_xmdg_m.xmdg014) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdg_m.xmdg014 != g_xmdg_m_o.xmdg014 OR g_xmdg_m_o.xmdg014 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_xmdg_m.xmdg014
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_xmdg_m.xmdg014 = g_xmdg_m_o.xmdg014
                     CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014) RETURNING g_xmdg_m.xmdg014_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xmdg_m.xmdg032) THEN
                     #add--2015/11/19 By shiun--(S)
                     CALL axmt520_xmda_xmdg015() RETURNING g_xmdg_m.xmdg015
                     IF cl_null(g_xmdg_m.xmdg015) THEN                     
                        CALL s_axmt540_get_exchange(g_xmdg_m.xmdg032,g_xmdg_m.xmdg014,g_xmdg_m.xmdgdocdt) RETURNING g_xmdg_m.xmdg015   #modify--2015/11/18 By shiun     新增傳入參數
                     END IF
                     #add--2015/11/19 By shiun--(E)
                     DISPLAY BY NAME g_xmdg_m.xmdg015
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014) RETURNING g_xmdg_m.xmdg014_desc
            DISPLAY BY NAME g_xmdg_m.xmdg014_desc
            LET g_xmdg_m_o.xmdg014 = g_xmdg_m.xmdg014
            LET g_xmdg_m_o.xmdg015 = g_xmdg_m.xmdg015
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg014
            #add-point:BEFORE FIELD xmdg014 name="input.b.xmdg014"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg014
            #add-point:ON CHANGE xmdg014 name="input.g.xmdg014"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdg015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdg_m.xmdg015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdg015
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdg015 name="input.a.xmdg015"
            LET g_xmdg_m_o.xmdg015 = g_xmdg_m.xmdg015
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdg015
            #add-point:BEFORE FIELD xmdg015 name="input.b.xmdg015"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdg015
            #add-point:ON CHANGE xmdg015 name="input.g.xmdg015"
                       
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmdgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgdocno
            #add-point:ON ACTION controlp INFIELD xmdgdocno name="input.c.xmdgdocno"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdgdocno  #給予default值
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog
            
            #160204-00004#2 160302 by lori mark---(S)
            #150909 earl mod s
            #IF NOT cl_null(g_xmdg_m.xmdg004) THEN
            #   CALL s_aooi210_get_search_sql(g_site,'',g_xmdg_m.xmdg004,g_prog) RETURNING l_success,l_where
            #ELSE            
               LET l_success = TRUE
               LET l_where = " 1=1 "
            #END IF
            #160204-00004#2 160302 by lori mark---(E)
            
            IF l_success THEN
               #151210-00009#1  2015/12/30 By earl s
               IF g_aic_doc THEN
                  LET l_where = l_where,
                                " AND NOT EXISTS (SELECT 1 FROM icaa_t,icab_t a,icac_t ",
                                "                  WHERE icaaent = a.icabent AND a.icabent = icacent AND icacent = ",g_enterprise,
                                "                    AND icaa001 = a.icab001 AND a.icab001 = icac001",
                                "                    AND a.icab002 = icac002",
                                "                    AND a.icab003 = '",g_site,"'",
                                "                    AND ooba002 = icac004",
                                #排除正拋初始站、逆拋最終站、逆拋中斷初始站
                                "                    AND NOT ((icaa003 = '1'",
                                "                              AND (icaa011 = '1' OR (icaa011 = '2' AND icaa005 = 'Y')) AND a.icab002 = '0')",
                                "                          OR ((icaa003 = '1' OR icaa003 = '2')",
                                "                              AND icaa011 = '2' AND a.icab002 = (SELECT MAX(b.icab002) FROM icab_t b",
                                "                                                                  WHERE b.icabent = icaaent",
                                "                                                                    AND b.icab001 = icaa001))",
                                "                            )",
                                "                )"
               END IF
               #151210-00009#1  2015/12/30 By earl e
            
               LET g_qryparam.where = l_where
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_xmdg_m.xmdgdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_xmdg_m.xmdgdocno TO xmdgdocno       #顯示到畫面上
               CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno) RETURNING g_xmdg_m.xmdgdocno_desc
               DISPLAY BY NAME g_xmdg_m.xmdgdocno_desc
            END IF
            #150909 earl mod e
            
            NEXT FIELD xmdgdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgdocdt
            #add-point:ON ACTION controlp INFIELD xmdgdocdt name="input.c.xmdgdocdt"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg004
            #add-point:ON ACTION controlp INFIELD xmdg004 name="input.c.xmdg004"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg004  #給予default值
            #借貨
            IF g_argv[01] = '8' THEN
               LET g_qryparam.where = " xmda005 = '8'"
   	   	ELSE
               LET g_qryparam.where = " xmda005 <> '8'"
            END IF
            LET l_where4 = '1=1' #170421-00006#1 add
            #過濾已全數轉出通
            #LET l_where = l_where," AND (NVL(xmdd006,0)+NVL(xmdd016,0)+NVL(xmdd034,0)) > ",         #170325-00105#2 mod #170421-00006#1 mark
             LET l_where4 = l_where4," AND (NVL(xmdd006,0)+NVL(xmdd016,0)+NVL(xmdd034,0)) > ",      #170421-00006#1 add
                                  " (SELECT NVL(SUM(xmdh016),0)",
                                  "    FROM xmdg_t,xmdh_t",
                                  "   WHERE xmdgent = xmdhent",
                                  "     AND xmdgdocno = xmdhdocno",
                                  "     AND xmdgstus <> 'X'",
                                  "     AND xmdhent = xmddent",
                                  "     AND xmdhsite = xmddsite",
                                  "     AND xmdh001 = xmdddocno",
                                  "     AND xmdh002 = xmddseq",
                                  "     AND xmdh003 = xmddseq1",
                                  "     AND xmdh004 = xmddseq2)"
            #過濾已全數轉出貨
           #LET l_where = l_where," AND (NVL(xmdd006,0)+NVL(xmdd016,0)+NVL(xmdd034,0)) > ",    #170421-00006#1 mark
            LET l_where4 = l_where4," AND (NVL(xmdd006,0)+NVL(xmdd016,0)+NVL(xmdd034,0)) > ",   #170421-00006#1 add 
                                  " (SELECT NVL(SUM(xmdl018),0)",
                                  "    FROM xmdk_t,xmdl_t",
                                  "   WHERE xmdkent = xmdlent",
                                  "     AND xmdkdocno = xmdldocno",
                                  "     AND xmdkstus <> 'X'",
                                  "     AND xmdlent = xmddent",
                                  "     AND xmdlsite = xmddsite",
                                  "     AND xmdl003 = xmdddocno",
                                  "     AND xmdl004 = xmddseq",
                                  "     AND xmdl005 = xmddseq1",
                                  "     AND xmdl006 = xmddseq2)"
            #170119-00008#2  2017/01/20 By 08171 --s add   
            LET l_slip_str = ''
            LET l_slip_wc2 = ''            
            FOR l_li = 0 TO g_slip_wc1.getLength()
               LET l_in = g_slip_wc1.subString(l_li,l_li+1)
               IF l_in = "IN" THEN
                  EXIT FOR
               END IF
            END FOR
            LET l_slip_str = g_slip_wc1.subString(1,l_li+1)
            LET l_slip_wc2 = g_slip_wc1.subString(l_li,g_slip_wc1.getLength()) #IN(axmt500的單據別)
            
            #參照表編號
            SELECT ooef004 INTO l_ooac001
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            
            #170119-00008#2  2017/01/20 By 08171 --e add
            #150909 earl mod s
            #組合過濾前後置單據資料SQL
            #CALL s_aooi210_get_check_sql(g_site,'',g_xmdg_m.xmdgdocno,'4','','xmdadocno') RETURNING l_success,l_where #170119-00008#2  2017/01/20 By 08171 mark
            #170119-00008#2  2017/01/20 By 08171 --s add
            #抓前後單據單別
            CALL s_aooi210_get_check_sql(g_site,'',g_xmdg_m.xmdgdocno,'4','','xmdadocno') RETURNING l_success,l_where1
            LET l_where3 = ""
            FOR l_li = 0 TO l_where1.getLength()
            #ex:l_where1 = AND (xmdadocno LIKE '____000%' OR xmdadocno LIKE '____502%' )
               LET l_in2 = l_where1.subString(l_li,l_li+4) 
               IF l_in2 = "'____" THEN
                  LET l_doc = l_where1.subString(l_li+5,l_li+7)
                  LET l_where2 = "OR ooac002 = '",l_doc,"' "
                  LET l_where3 = l_where3,l_where2
               END IF
            END FOR
            LET l_where3 = l_where3.subString(3,l_where3.getLength()) #去掉最前面的OR
            LET l_where3 = "AND (",l_where3,")" #EX: AND ( ooac002 = '000' OR ooac002 = '502' )
            #170119-00008#2  2017/01/20 By 08171 --e add
            IF l_success THEN
               #LET g_qryparam.where = g_qryparam.where," AND ",l_where  #170421-00006#1 mark
               LET g_qryparam.where = g_qryparam.where," AND ",l_where4    #170421-00006#1 add
               #170119-00008#2  2017/01/20 By 08171 --s add
               IF NOT cl_null(g_slip_wc1) AND l_where1 = '1=1' THEN
                  #訂單需走出通單='Y'          
                  LET g_qryparam.where = g_qryparam.where," AND ",l_slip_str," (SELECT ooac002 FROM ooac_t WHERE ooacent = ",g_enterprise,
                                                       #  "                     AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND ooac004= 'Y' ",      #170401-00018#1  2017/4/7 By chenssz mark
                                                          "                     AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND (ooac004= 'Y' or ooac004 is null) ",   #170401-00018#1  2017/4/7 By chenssz 
                                                          "                     AND ooac002 ",l_slip_wc2,")"
               ELSE
                  LET g_qryparam.where = g_qryparam.where," AND ",l_where1
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT * FROM ooac_t WHERE ooacent = ",g_enterprise,
                                                       #  "             AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND ooac004= 'Y' ",l_where3,")"  #170401-00018#1  2017/4/7 By chenssz mark
                                                          "             AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND (ooac004= 'Y' or ooac004 is null) ",l_where3,")"#170401-00018#1  2017/4/7 By chenssz
               END IF
               
               #170119-00008#2  2017/01/20 By 08171 --e add
               CALL q_xmdadocno_2()                        #呼叫開窗
               LET g_xmdg_m.xmdg004 = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_xmdg_m.xmdg004 TO xmdg004         #顯示到畫面上
            END IF
            #150909 earl mod e
            NEXT FIELD xmdg004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgsite
            #add-point:ON ACTION controlp INFIELD xmdgsite name="input.c.xmdgsite"
 
            #END add-point
 
 
         #Ctrlp:input.c.xmdg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg002
            #add-point:ON ACTION controlp INFIELD xmdg002 name="input.c.xmdg002"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg002  #給予default值
            CALL q_ooag001()                            #呼叫開窗
            LET g_xmdg_m.xmdg002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg002 TO xmdg002         #顯示到畫面上
            CALL s_desc_get_person_desc(g_xmdg_m.xmdg002) RETURNING g_xmdg_m.xmdg002_desc
            DISPLAY BY NAME g_xmdg_m.xmdg002_desc
            NEXT FIELD xmdg002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg003
            #add-point:ON ACTION controlp INFIELD xmdg003 name="input.c.xmdg003"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg003  #給予default值
            LET g_qryparam.arg1 = g_xmdg_m.xmdgdocdt    #日期
            CALL q_ooeg001()                            #呼叫開窗
            LET g_xmdg_m.xmdg003 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg003 TO xmdg003         #顯示到畫面上
            CALL s_desc_get_department_desc(g_xmdg_m.xmdg003) RETURNING g_xmdg_m.xmdg003_desc
            DISPLAY BY NAME g_xmdg_m.xmdg003_desc
            NEXT FIELD xmdg003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdgstus
            #add-point:ON ACTION controlp INFIELD xmdgstus name="input.c.xmdgstus"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg001
            #add-point:ON ACTION controlp INFIELD xmdg001 name="input.c.xmdg001"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg034
            #add-point:ON ACTION controlp INFIELD xmdg034 name="input.c.xmdg034"
 
            #END add-point
 
 
         #Ctrlp:input.c.xmdg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg005
            #add-point:ON ACTION controlp INFIELD xmdg005 name="input.c.xmdg005"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg005  #給予default值
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,g_xmdg_m.xmdgdocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
	   		LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                          #呼叫開窗
            LET g_xmdg_m.xmdg005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg005 TO xmdg005         #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005) RETURNING g_xmdg_m.xmdg005_desc
            DISPLAY BY NAME g_xmdg_m.xmdg005_desc
            NEXT FIELD xmdg005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg006
            #add-point:ON ACTION controlp INFIELD xmdg006 name="input.c.xmdg006"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg006  #給予default值
	   		LET g_qryparam.arg1 = g_xmdg_m.xmdg005
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_5()                          #呼叫開窗
            LET g_xmdg_m.xmdg006 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg006 TO xmdg006         #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006) RETURNING g_xmdg_m.xmdg006_desc
            DISPLAY BY NAME g_xmdg_m.xmdg006_desc
            NEXT FIELD xmdg006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg007
            #add-point:ON ACTION controlp INFIELD xmdg007 name="input.c.xmdg007"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg007  #給予default值
	   		LET g_qryparam.arg1 = g_xmdg_m.xmdg005
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                          #呼叫開窗
            LET g_xmdg_m.xmdg007 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg007 TO xmdg007         #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007) RETURNING g_xmdg_m.xmdg007_desc
            DISPLAY BY NAME g_xmdg_m.xmdg007_desc
            NEXT FIELD xmdg007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg202
            #add-point:ON ACTION controlp INFIELD xmdg202 name="input.c.xmdg202"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg202  #給予default值
	   		LET g_qryparam.arg1 = g_xmdg_m.xmdg005
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_7()                          #呼叫開窗
            LET g_xmdg_m.xmdg202 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg202 TO xmdg202         #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg202) RETURNING g_xmdg_m.xmdg202_desc
            DISPLAY BY NAME g_xmdg_m.xmdg202_desc
            NEXT FIELD xmdg202                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg028
            #add-point:ON ACTION controlp INFIELD xmdg028 name="input.c.xmdg028"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg026
            #add-point:ON ACTION controlp INFIELD xmdg026 name="input.c.xmdg026"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg026  #給予default值
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            LET g_xmdg_m.xmdg026 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg026 TO xmdg026         #顯示到畫面上
            #160621-00003#3 20160629 modify by beckxie---S
            #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
            CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
            #160621-00003#3 20160629 modify by beckxie---E
            DISPLAY BY NAME g_xmdg_m.xmdg026_desc
            NEXT FIELD xmdg026                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg027
            #add-point:ON ACTION controlp INFIELD xmdg027 name="input.c.xmdg027"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg027  #給予default值
            LET g_qryparam.arg1 = "295" 
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg027 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg027 TO xmdg027         #顯示到畫面上
            CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027) RETURNING g_xmdg_m.xmdg027_desc
            DISPLAY BY NAME g_xmdg_m.xmdg027_desc
            NEXT FIELD xmdg027                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg024
            #add-point:ON ACTION controlp INFIELD xmdg024 name="input.c.xmdg024"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg025
            #add-point:ON ACTION controlp INFIELD xmdg025 name="input.c.xmdg025"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg030
            #add-point:ON ACTION controlp INFIELD xmdg030 name="input.c.xmdg030"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg030  #給予default值
            LET g_qryparam.arg1 = "209" 
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg030 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg030 TO xmdg030         #顯示到畫面上
            CALL s_desc_get_acc_desc('209',g_xmdg_m.xmdg030) RETURNING g_xmdg_m.xmdg030_desc
            DISPLAY BY NAME g_xmdg_m.xmdg030_desc
            NEXT FIELD xmdg030                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg031
            #add-point:ON ACTION controlp INFIELD xmdg031 name="input.c.xmdg031"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg031  #給予default值
            LET g_qryparam.arg1 = "297" 
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg031 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg031 TO xmdg031         #顯示到畫面上
            CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031) RETURNING g_xmdg_m.xmdg031_desc
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            NEXT FIELD xmdg031                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg053
            #add-point:ON ACTION controlp INFIELD xmdg053 name="input.c.xmdg053"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg056
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg056
            #add-point:ON ACTION controlp INFIELD xmdg056 name="input.c.xmdg056"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg056
            CALL q_icaa001_8()
            LET g_xmdg_m.xmdg056 = g_qryparam.return1
            DISPLAY g_xmdg_m.xmdg056 TO xmdg056
            CALL s_desc_get_icaa001_desc(g_xmdg_m.xmdg056) RETURNING g_xmdg_m.xmdg056_desc
            DISPLAY BY NAME g_xmdg_m.xmdg056_desc
            NEXT FIELD xmdg056

            #END add-point
 
 
         #Ctrlp:input.c.xmdg057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg057
            #add-point:ON ACTION controlp INFIELD xmdg057 name="input.c.xmdg057"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdg058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg058
            #add-point:ON ACTION controlp INFIELD xmdg058 name="input.c.xmdg058"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg017
            #add-point:ON ACTION controlp INFIELD xmdg017 name="input.c.xmdg017"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg017  #給予default值
            CALL s_axmt500_get_pmaa027(g_xmdg_m.xmdg007) RETURNING l_pmaa027
            LET g_qryparam.arg1 = l_pmaa027
            CALL q_oofb019_1()                          #呼叫開窗
            LET g_xmdg_m.xmdg017 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg017 TO xmdg017         #顯示到畫面上
            CALL axmt520_xmdg017_ref()
            NEXT FIELD xmdg017                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg018
            #add-point:ON ACTION controlp INFIELD xmdg018 name="input.c.xmdg018"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg018  #給予default值
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg018 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg018 TO xmdg018         #顯示到畫面上
            CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018) RETURNING g_xmdg_m.xmdg018_desc
            DISPLAY BY NAME g_xmdg_m.xmdg018_desc
            NEXT FIELD xmdg018                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg019
            #add-point:ON ACTION controlp INFIELD xmdg019 name="input.c.xmdg019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg019
            CALL axmt520_get_oocq019() RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF
            LET g_xmdg_m.xmdg019 = g_qryparam.return1       #將開窗取得的值回傳到變數       
            DISPLAY g_xmdg_m.xmdg019 TO xmdg019
            CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019) RETURNING g_xmdg_m.xmdg019_desc
            DISPLAY BY NAME g_xmdg_m.xmdg019_desc
            NEXT FIELD xmdg019                 
            #END add-point
 
 
         #Ctrlp:input.c.xmdg020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg020
            #add-point:ON ACTION controlp INFIELD xmdg020 name="input.c.xmdg020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg020
            CALL axmt520_get_oocq019() RETURNING l_oocq019  #運輸類型
            IF NOT cl_null(l_oocq019) THEN
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()
                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()
                  OTHERWISE EXIT CASE
               END CASE
            END IF
            LET g_xmdg_m.xmdg020 = g_qryparam.return1       #將開窗取得的值回傳到變數       
            DISPLAY g_xmdg_m.xmdg020 TO xmdg020
            CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020) RETURNING g_xmdg_m.xmdg020_desc
            DISPLAY BY NAME g_xmdg_m.xmdg020_desc
            NEXT FIELD xmdg020
            #END add-point
 
 
         #Ctrlp:input.c.xmdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg016
            #add-point:ON ACTION controlp INFIELD xmdg016 name="input.c.xmdg016"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg016  #給予default值
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_supplier_sql('2',g_site,g_user,g_dept,g_xmdg_m.xmdgdocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            CALL q_pmaa001_3()                          #呼叫開窗
            LET g_xmdg_m.xmdg016 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg016 TO xmdg016         #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016) RETURNING g_xmdg_m.xmdg016_desc
            DISPLAY BY NAME g_xmdg_m.xmdg016_desc
            NEXT FIELD xmdg016                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.xmdg021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg021
            #add-point:ON ACTION controlp INFIELD xmdg021 name="input.c.xmdg021"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg022
            #add-point:ON ACTION controlp INFIELD xmdg022 name="input.c.xmdg022"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg023
            #add-point:ON ACTION controlp INFIELD xmdg023 name="input.c.xmdg023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg023
#            LET g_qryparam.where = " xmao001 = '",g_xmdg_m.xmdg005,"'" #160119-00015#1-mod-(S)
            LET g_qryparam.where = " xmao001 = '",g_xmdg_m.xmdg007,"'"  #160119-00015#1-mod-(E)
            CALL q_xmao002()
            LET g_xmdg_m.xmdg023 = g_qryparam.return1
            DISPLAY g_xmdg_m.xmdg023 TO xmdg023
            CALL axmt520_xmdg023_ref()
            NEXT FIELD xmdg023
            #END add-point
 
 
         #Ctrlp:input.c.xmdg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg008
            #add-point:ON ACTION controlp INFIELD xmdg008 name="input.c.xmdg008"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg008        #給予default值
            LET g_qryparam.arg1 = g_xmdg_m.xmdg005            #客戶編號
            CALL q_pmad002_3()                                #呼叫開窗
            LET g_xmdg_m.xmdg008 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg008 TO xmdg008               #顯示到畫面上
            CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008) RETURNING g_xmdg_m.xmdg008_desc
            DISPLAY BY NAME g_xmdg_m.xmdg008_desc
            NEXT FIELD xmdg008                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg009
            #add-point:ON ACTION controlp INFIELD xmdg009 name="input.c.xmdg009"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg009  #給予default值
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg009 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg009 TO xmdg009         #顯示到畫面上
            CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009) RETURNING g_xmdg_m.xmdg009_desc
            DISPLAY BY NAME g_xmdg_m.xmdg009_desc
            NEXT FIELD xmdg009                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg010
            #add-point:ON ACTION controlp INFIELD xmdg010 name="input.c.xmdg010"
         	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg010  #給予default值
            CALL q_oodb002_11()                         #呼叫開窗
            LET g_xmdg_m.xmdg010 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg010 TO xmdg010         #顯示到畫面上
            CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010) RETURNING g_xmdg_m.xmdg010_desc
            DISPLAY BY NAME g_xmdg_m.xmdg010_desc
            NEXT FIELD xmdg010                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg011
            #add-point:ON ACTION controlp INFIELD xmdg011 name="input.c.xmdg011"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg012
            #add-point:ON ACTION controlp INFIELD xmdg012 name="input.c.xmdg012"
                       
            #END add-point
 
 
         #Ctrlp:input.c.xmdg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg013
            #add-point:ON ACTION controlp INFIELD xmdg013 name="input.c.xmdg013"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg013  #給予default值
            LET g_qryparam.arg1 = g_ooef019             #稅區編號
            LET g_qryparam.arg2 = "2"                   #銷項
            CALL q_isac002_1()                          #呼叫開窗
            LET g_xmdg_m.xmdg013 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg013 TO xmdg013         #顯示到畫面上
            CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013) RETURNING g_xmdg_m.xmdg013_desc
            DISPLAY BY NAME g_xmdg_m.xmdg013_desc
            NEXT FIELD xmdg013                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg032
            #add-point:ON ACTION controlp INFIELD xmdg032 name="input.c.xmdg032"
 
            #END add-point
 
 
         #Ctrlp:input.c.xmdg033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg033
            #add-point:ON ACTION controlp INFIELD xmdg033 name="input.c.xmdg033"
 
            #END add-point
 
 
         #Ctrlp:input.c.xmdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg014
            #add-point:ON ACTION controlp INFIELD xmdg014 name="input.c.xmdg014"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg014  #給予default值
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002()                            #呼叫開窗
            LET g_xmdg_m.xmdg014 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg014 TO xmdg014         #顯示到畫面上
            CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014) RETURNING g_xmdg_m.xmdg014_desc
            DISPLAY BY NAME g_xmdg_m.xmdg014_desc
            NEXT FIELD xmdg014                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmdg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdg015
            #add-point:ON ACTION controlp INFIELD xmdg015 name="input.c.xmdg015"
                       
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmdg_m.xmdgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt,g_prog) RETURNING l_success,g_xmdg_m.xmdgdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_xmdg_m.xmdgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xmdgdocno
               END IF
               DISPLAY BY NAME g_xmdg_m.xmdgdocno
               #end add-point
               
               INSERT INTO xmdg_t (xmdgent,xmdgdocno,xmdgdocdt,xmdg004,xmdgsite,xmdg002,xmdg003,xmdgstus, 
                   xmdg001,xmdg034,xmdg005,xmdg006,xmdg007,xmdg202,xmdg028,xmdg026,xmdg027,xmdg024,xmdg025, 
                   xmdg030,xmdg031,xmdg053,xmdg056,xmdg055,xmdg054,xmdg057,xmdg058,xmdg017,xmdg018,xmdg019, 
                   xmdg020,xmdg016,xmdg021,xmdg022,xmdg023,xmdg008,xmdg009,xmdg010,xmdg011,xmdg012,xmdg013, 
                   xmdg032,xmdg033,xmdg014,xmdg015,xmdgownid,xmdgowndp,xmdgcrtid,xmdgcrtdp,xmdgcrtdt, 
                   xmdgmodid,xmdgmoddt,xmdgcnfid,xmdgcnfdt)
               VALUES (g_enterprise,g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
                   g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001,g_xmdg_m.xmdg034, 
                   g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
                   g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030, 
                   g_xmdg_m.xmdg031,g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054, 
                   g_xmdg_m.xmdg057,g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019, 
                   g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023, 
                   g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012, 
                   g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
                   g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
                   g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xmdg_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_ooff003_d = g_xmdg_m.xmdgdocno   #161031-00025#25 add                             
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"

            #150720-00006#1  2016/03/29  By earl add s
            LET g_ask = TRUE
            
            IF NOT axmt520_auto_insert() THEN
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            #150720-00006#1  2016/03/29  By earl add e

#            CALL s_transaction_end('Y','0')
#            CALL s_transaction_begin()
#            IF NOT cl_null(g_xmdg_m.xmdg004) THEN
#               IF g_argv[01] = '8' THEN
#                  IF cl_ask_confirm('axm-00566') THEN   #是否由[借貨訂單axmt501]自動產生單身資料？
#                     LET l_success = ''
#                     CALL axmt520_gen_xmdh()  #自動產生單身
#                          RETURNING l_success
#                     IF NOT l_success THEN 
#                        CALL s_transaction_end('N','0')
#                     END IF
#                  END IF
#               ELSE
#                  IF cl_ask_confirm('axm-00140') THEN   #是否由[訂單axmt500]自動產生單身資料！
#                     LET l_success = ''
#                     CALL axmt520_gen_xmdh()  #自動產生單身
#                          RETURNING l_success
#                     IF NOT l_success THEN 
#                        CALL s_transaction_end('N','0')
#                     END IF
#                  END IF
#               END IF
#            END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmt520_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axmt520_b_fill()
                  CALL axmt520_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               CALL axmt520_b_fill()

               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
                             
               #end add-point
               
               #將遮罩欄位還原
               CALL axmt520_xmdg_t_mask_restore('restore_mask_o')
               
               UPDATE xmdg_t SET (xmdgdocno,xmdgdocdt,xmdg004,xmdgsite,xmdg002,xmdg003,xmdgstus,xmdg001, 
                   xmdg034,xmdg005,xmdg006,xmdg007,xmdg202,xmdg028,xmdg026,xmdg027,xmdg024,xmdg025,xmdg030, 
                   xmdg031,xmdg053,xmdg056,xmdg055,xmdg054,xmdg057,xmdg058,xmdg017,xmdg018,xmdg019,xmdg020, 
                   xmdg016,xmdg021,xmdg022,xmdg023,xmdg008,xmdg009,xmdg010,xmdg011,xmdg012,xmdg013,xmdg032, 
                   xmdg033,xmdg014,xmdg015,xmdgownid,xmdgowndp,xmdgcrtid,xmdgcrtdp,xmdgcrtdt,xmdgmodid, 
                   xmdgmoddt,xmdgcnfid,xmdgcnfdt) = (g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004, 
                   g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
                   g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202, 
                   g_xmdg_m.xmdg028,g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025, 
                   g_xmdg_m.xmdg030,g_xmdg_m.xmdg031,g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055, 
                   g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018, 
                   g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022, 
                   g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
                   g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014, 
                   g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp, 
                   g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt) 
 
                WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmdg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                             
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axmt520_xmdg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xmdg_m_t)
               LET g_log2 = util.JSON.stringify(g_xmdg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                             
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axmt520.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmdh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="input.detail_input.page1.s_lot_sel"
               IF cl_null(g_xmdh_d[l_ac].xmdh012) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00126'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               IF NOT cl_null(g_xmdg_m.xmdgdocno) AND
                  NOT cl_null(g_xmdh_d[l_ac].xmdhseq) AND
                  NOT cl_null(g_xmdh_d[l_ac].xmdh006) AND
                  NOT cl_null(g_xmdh_d[l_ac].xmdh015) AND
                  NOT cl_null(g_xmdh_d[l_ac].xmdh016) THEN
                  CALL axmt520_inao('1') RETURNING l_success                       
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #150720-00006#1  2016/03/29  By earl mod s
            CALL s_transaction_begin()
            IF axmt520_auto_insert() THEN
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF
            
            LET g_ask = TRUE
            
#            LET l_cnt = 0
#            SELECT COUNT(*) INTO l_cnt
#              FROM xmdh_t
#             WHERE xmdhent = g_enterprise
#               AND xmdhdocno = g_xmdg_m.xmdgdocno
#            IF cl_null(l_cnt) OR l_cnt = 0 THEN
#               IF NOT cl_null(g_xmdg_m.xmdg004) THEN
#                  IF g_argv[01] = '8' THEN
#                     IF cl_ask_confirm('axm-00566') THEN   #是否由[借貨訂單axmt501]自動產生單身資料？
#                        CALL s_transaction_begin()
#                        LET l_success = ''
#                        CALL axmt520_gen_xmdh()  #自動產生單身
#                             RETURNING l_success
#                        IF NOT l_success THEN 
#                           CALL s_transaction_end('N','0')
#                        END IF
#                        CALL s_transaction_end('Y','0')
#                     END IF
#                  ELSE
#                     IF cl_ask_confirm('axm-00140') THEN   #是否由[訂單axmt500]自動產生單身資料！
#                        CALL s_transaction_begin()
#                        LET l_success = ''
#                        CALL axmt520_gen_xmdh()  #自動產生單身
#                             RETURNING l_success
#                        IF NOT l_success THEN 
#                           CALL s_transaction_end('N','0')
#                        END IF
#                        CALL s_transaction_end('Y','0')
#                     END IF
#                  END IF
#               END IF
#            END IF
            #150720-00006#1  2016/03/29  By earl mod e
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmdh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt520_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmdh_d.getLength()
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
            OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt520_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmdh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmdh_d[l_ac].xmdhseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*  #BACKUP
               LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*  #BACKUP
               CALL axmt520_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               IF cl_null(g_xmdh_d[l_ac].xmdh002) THEN
                  LET g_flag = 'Y'
               ELSE
                  LET g_flag = 'N'
               END IF

               #end add-point  
               CALL axmt520_set_no_entry_b(l_cmd)
               IF NOT axmt520_lock_b("xmdh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt520_bcl INTO g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh001, 
                      g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh005, 
                      g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh034,g_xmdh_d[l_ac].xmdh009, 
                      g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh017, 
                      g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh008,g_xmdh_d[l_ac].xmdh011, 
                      g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029, 
                      g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021,g_xmdh_d[l_ac].xmdh022,g_xmdh_d[l_ac].xmdh036, 
                      g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032,g_xmdh_d[l_ac].xmdh033,g_xmdh_d[l_ac].xmdh050, 
                      g_xmdh_d[l_ac].xmdh056,g_xmdh_d[l_ac].xmdh030,g_xmdh_d[l_ac].xmdh051,g_xmdh_d[l_ac].xmdh052, 
                      g_xmdh_d[l_ac].xmdhunit,g_xmdh_d[l_ac].xmdh035,g_xmdh4_d[l_ac].xmdhseq,g_xmdh4_d[l_ac].xmdh023, 
                      g_xmdh4_d[l_ac].xmdh024,g_xmdh4_d[l_ac].xmdh025,g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027, 
                      g_xmdh4_d[l_ac].xmdh028
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmdh_d_t.xmdhseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmdh_d_mask_o[l_ac].* =  g_xmdh_d[l_ac].*
                  CALL axmt520_xmdh_t_mask()
                  LET g_xmdh_d_mask_n[l_ac].* =  g_xmdh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt520_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET l_xmdhseq_backup = g_xmdh_d[l_ac].xmdhseq  #備份多庫儲批項次


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
            INITIALIZE g_xmdh_d[l_ac].* TO NULL 
            INITIALIZE g_xmdh_d_t.* TO NULL 
            INITIALIZE g_xmdh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xmdh_d[l_ac].xmdh005 = "1"
      LET g_xmdh_d[l_ac].xmdh011 = "N"
      LET g_xmdh_d[l_ac].xmdh022 = "Y"
      LET g_xmdh_d[l_ac].xmdh036 = "N"
      LET g_xmdh_d[l_ac].xmdh056 = "0"
      LET g_xmdh_d[l_ac].xmdh030 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*     #新輸入資料
            LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt520_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
 
            #end add-point
            CALL axmt520_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmdh_d[li_reproduce_target].* = g_xmdh_d[li_reproduce].*
               LET g_xmdh4_d[li_reproduce_target].* = g_xmdh4_d[li_reproduce].*
 
               LET g_xmdh_d[li_reproduce_target].xmdhseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(xmdhseq)+1 INTO g_xmdh_d[l_ac].xmdhseq
              FROM xmdh_t
             WHERE xmdhent = g_enterprise
               AND xmdhdocno = g_xmdg_m.xmdgdocno
            IF cl_null(g_xmdh_d[l_ac].xmdhseq) OR g_xmdh_d[l_ac].xmdhseq = 0 THEN
               LET g_xmdh_d[l_ac].xmdhseq = 1
            END IF
            #若單頭有輸入訂單號，則單身的訂單號預設單頭的訂單號
            IF NOT cl_null(g_xmdg_m.xmdg004) THEN
               LET g_xmdh_d[l_ac].xmdh001 = g_xmdg_m.xmdg004
            END IF
            LET g_xmdh_d[l_ac].xmdhsite = g_site
            LET g_xmdh_d[l_ac].xmdh007 = ' '
            LET g_xmdh_d[l_ac].xmdh012 = ' '
            LET g_xmdh_d[l_ac].xmdh013 = ' '
            LET g_xmdh_d[l_ac].xmdh014 = ' '
            #dorislai-20150824-add----(S)
            #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
            IF cl_null(g_xmdh_d[l_ac].xmdh012) THEN
               #預設欄位
               CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_success,l_ooba002
               IF l_success THEN
                  CALL s_aooi200_get_doc_default(g_site,'1',l_ooba002,'xmdh012',g_xmdh_d[l_ac].xmdh012)
                  RETURNING g_xmdh_d[l_ac].xmdh012
                  #應用參數
                  IF cl_null(g_xmdh_d[l_ac].xmdh012) THEN
                     CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076')
                     RETURNING g_xmdh_d[l_ac].xmdh012
                  END IF
               END IF
            END IF
            #dorislai-20150824-add----(E)            
            LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*
            LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*
            
            LET l_xmdhseq_backup = g_xmdh_d[l_ac].xmdhseq   #備份多庫儲批項次
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
            SELECT COUNT(1) INTO l_count FROM xmdh_t 
             WHERE xmdhent = g_enterprise AND xmdhdocno = g_xmdg_m.xmdgdocno
 
               AND xmdhseq = g_xmdh_d[l_ac].xmdhseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                             
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdg_m.xmdgdocno
               LET gs_keys[2] = g_xmdh_d[g_detail_idx].xmdhseq
               CALL axmt520_insert_b('xmdh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161031-00025#25-s
               IF NOT cl_null(g_xmdh_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'','','','','','','','1',g_xmdh_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#25-e                             
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xmdh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt520_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF NOT axmt540_01_xmdm_modify('2',l_xmdhseq_backup,g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,
                                             g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                             g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,
                                             g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh015,
                                             g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,
                                             '','') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF               
              #160324-00021#1 mod str
              #IF NOT axmt520_upd_xmdd031(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,
              #                           g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh016,g_xmdh_d_t.xmdh016) THEN
               IF NOT axmt520_upd_xmdd031(g_xmdh_d[l_ac].xmdh001,g_xmdh_d_t.xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d_t.xmdh002,
                                          g_xmdh_d[l_ac].xmdh003,g_xmdh_d_t.xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d_t.xmdh004,
                                          g_xmdh_d[l_ac].xmdh016,g_xmdh_d_t.xmdh016) THEN
              #160324-00021#1 mod end
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               CALL s_transaction_end('N','0')  #150821-xianghui     
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
               
               #依據出貨明細的的實際出貨數量更新對應的訂的交期名細中的已轉出貨量(xmdd031)
               IF NOT s_axmt520_upd_xmdd031(g_xmdg_m.xmdgdocno,g_xmdh_d_t.xmdhseq) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF

               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmdg_m.xmdgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xmdh_d_t.xmdhseq
 
            
               #刪除同層單身
               IF NOT axmt520_delete_b('xmdh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt520_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt520_key_delete_b(gs_keys,'xmdh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt520_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #150821-xianghui-b
               #同步刪除對應的[T:製造批序號庫存異動明細檔]
               DELETE FROM inao_t
                  WHERE inaoent = g_enterprise 
                    AND inaosite = g_site 
                    AND inaodocno = g_xmdg_m.xmdgdocno
                    AND inaoseq = g_xmdh_d[l_ac].xmdhseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inao_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()           
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF  
               #150821-xianghui-e    
               #161031-00025#25-s
               CALL s_aooi360_del('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d_t.xmdhseq,'','','','','','','','1') RETURNING l_success
               #161031-00025#25-e                
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt520_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_xmdh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                       
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmdh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhsite
            #add-point:BEFORE FIELD xmdhsite name="input.b.page1.xmdhsite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhsite
            
            #add-point:AFTER FIELD xmdhsite name="input.a.page1.xmdhsite"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdhsite
            #add-point:ON CHANGE xmdhsite name="input.g.page1.xmdhsite"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhseq
            #add-point:BEFORE FIELD xmdhseq name="input.b.page1.xmdhseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhseq
            
            #add-point:AFTER FIELD xmdhseq name="input.a.page1.xmdhseq"
            IF  g_xmdg_m.xmdgdocno IS NOT NULL AND g_xmdh_d[g_detail_idx].xmdhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdg_m.xmdgdocno != g_xmdgdocno_t OR g_xmdh_d[g_detail_idx].xmdhseq != g_xmdh_d_t.xmdhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdh_t WHERE "||"xmdhent = '" ||g_enterprise|| "' AND "||"xmdhdocno = '"||g_xmdg_m.xmdgdocno ||"' AND "|| "xmdhseq = '"||g_xmdh_d[g_detail_idx].xmdhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdh_d[l_ac].xmdhseq != g_xmdh_d_o.xmdhseq OR g_xmdh_d_o.xmdhseq IS NULL)) THEN 
                  CALL axmt520_get_amount(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh021,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024)
                       RETURNING g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh028,g_xmdh4_d[l_ac].xmdh027
                  #IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                  #   CALL axmt520_xmdi_del()
                  #END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdhseq = g_xmdh_d[l_ac].xmdhseq
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdhseq
            #add-point:ON CHANGE xmdhseq name="input.g.page1.xmdhseq"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh001
            
            #add-point:AFTER FIELD xmdh001 name="input.a.page1.xmdh001"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh001 != g_xmdh_d_o.xmdh001 OR g_xmdh_d_o.xmdh001 IS NULL )) THEN
                  IF NOT axmt520_xmdadocno_chk(g_xmdh_d[l_ac].xmdh001,'2') THEN
                     LET g_xmdh_d[l_ac].xmdh001 = g_xmdh_d_o.xmdh001
                     NEXT FIELD CURRENT
                  END IF
                  CALL axmt520_xmdh001_default()
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdh001 = g_xmdh_d[l_ac].xmdh001
            LET g_xmdh_d_o.xmdh002 = g_xmdh_d[l_ac].xmdh002
            LET g_xmdh_d_o.xmdh003 = g_xmdh_d[l_ac].xmdh003
            LET g_xmdh_d_o.xmdh004 = g_xmdh_d[l_ac].xmdh004
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh001
            #add-point:BEFORE FIELD xmdh001 name="input.b.page1.xmdh001"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh001
            #add-point:ON CHANGE xmdh001 name="input.g.page1.xmdh001"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh002
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh002 name="input.a.page1.xmdh002"
            IF cl_null(g_xmdh_d[l_ac].xmdh002) THEN
               LET g_flag = 'Y'
               LET g_xmdh_d[l_ac].xmdh003 = ''
               LET g_xmdh_d[l_ac].xmdh004 = ''
            ELSE
               LET g_flag = 'N'
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh002 != g_xmdh_d_o.xmdh002 OR g_xmdh_d_o.xmdh002 IS NULL )) THEN
                  #訂單號+訂單項次必須存在xmdd_t中
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM xmdd_t
                   WHERE xmddent = g_enterprise
                     AND xmdddocno = g_xmdh_d[l_ac].xmdh001
                     AND xmddseq = g_xmdh_d[l_ac].xmdh002
                  IF cl_null(l_cnt) OR l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axm-00158'  #160318-00005#50  mark
                     LET g_errparam.code = 'sub-01323'   #160318-00005#50  add
                     LET g_errparam.extend = g_xmdh_d[l_ac].xmdh002
                     #160318-00005#50 --s add
                     LET g_errparam.replace[1] = 'axmt500'
                     LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
                     LET g_errparam.exeprog = 'axmt500'
                     #160318-00005#50 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdh_d[l_ac].xmdh002 = g_xmdh_d_o.xmdh002
                     NEXT FIELD CURRENT
                  END IF
                  #若輸入的訂單號+訂單項次的xmdd_t只有對應一個分批序時，則自動將分批序預設到出通單身[C:分批序]上
                  IF l_cnt = 1 THEN
                     SELECT xmddseq1,xmddseq2
                       INTO g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004
                       FROM xmdd_t
                      WHERE xmddent = g_enterprise
                        AND xmdddocno = g_xmdh_d[l_ac].xmdh001
                        AND xmddseq = g_xmdh_d[l_ac].xmdh002
                     CALL axmt520_xmdh004_chk()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        #160318-00005#50 --s add
                        CASE g_errno
                           WHEN 'sub-01323'
                              LET g_errparam.replace[1] = 'axmt500'
                              LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
                              LET g_errparam.exeprog = 'axmt500'
                        END CASE
                        #160318-00005#50 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmdh_d[l_ac].xmdh002 = g_xmdh_d_o.xmdh002
                        LET g_xmdh_d[l_ac].xmdh003 = g_xmdh_d_o.xmdh003
                        LET g_xmdh_d[l_ac].xmdh004 = g_xmdh_d_o.xmdh004
                        NEXT FIELD CURRENT
                     ELSE
                        CALL axmt520_xmdh004_default()
                     END IF
                  ELSE
                     LET g_xmdh_d[l_ac].xmdh003 = ''
                     LET g_xmdh_d[l_ac].xmdh004 = ''
                     CALL axmt520_xmdh002_default()
                  END IF
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdh002 = g_xmdh_d[l_ac].xmdh002
            LET g_xmdh_d_o.xmdh003 = g_xmdh_d[l_ac].xmdh003
            LET g_xmdh_d_o.xmdh004 = g_xmdh_d[l_ac].xmdh004
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh002
            #add-point:BEFORE FIELD xmdh002 name="input.b.page1.xmdh002"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh002
            #add-point:ON CHANGE xmdh002 name="input.g.page1.xmdh002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh003,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh003
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh003 name="input.a.page1.xmdh003"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh003 != g_xmdh_d_o.xmdh003 OR g_xmdh_d_o.xmdh003 IS NULL )) THEN
                  #訂單號+訂單項次必須存在xmdd_t中
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM xmdd_t
                   WHERE xmddent = g_enterprise
                     AND xmdddocno = g_xmdh_d[l_ac].xmdh001
                     AND xmddseq = g_xmdh_d[l_ac].xmdh002
                     AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
                  IF cl_null(l_cnt) OR l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axm-00158'  #160318-00005#50  mark
                     LET g_errparam.code = 'sub-01323'   #160318-00005#50  add
                     LET g_errparam.extend = g_xmdh_d[l_ac].xmdh003
                     #160318-00005#50 --s add
                     LET g_errparam.replace[1] = 'axmt500'
                     LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
                     LET g_errparam.exeprog = 'axmt500'
                     #160318-00005#50 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdh_d[l_ac].xmdh003 = g_xmdh_d_o.xmdh003
                     NEXT FIELD CURRENT
                  END IF
                  #若輸入的訂單號+訂單項次的xmdd_t只有對應一個分批序時，則自動將分批序預設到出通單身[C:分批序]上
                  IF l_cnt = 1 THEN
                     SELECT xmddseq2 INTO g_xmdh_d[l_ac].xmdh004
                       FROM xmdd_t
                      WHERE xmddent = g_enterprise
                        AND xmdddocno = g_xmdh_d[l_ac].xmdh001
                        AND xmddseq = g_xmdh_d[l_ac].xmdh002
                        AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
                     CALL axmt520_xmdh004_chk()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        #160318-00005#50 --s add
                        CASE g_errno
                           WHEN 'sub-01323'
                              LET g_errparam.replace[1] = 'axmt500'
                              LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
                              LET g_errparam.exeprog = 'axmt500'
                        END CASE
                        #160318-00005#50 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmdh_d[l_ac].xmdh003 = g_xmdh_d_o.xmdh003
                        LET g_xmdh_d[l_ac].xmdh004 = g_xmdh_d_o.xmdh004
                        NEXT FIELD CURRENT
                     ELSE
                        CALL axmt520_xmdh004_default()
                     END IF
                  ELSE
                     LET g_xmdh_d[l_ac].xmdh004 = ''
                  END IF
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdh003 = g_xmdh_d[l_ac].xmdh003
            LET g_xmdh_d_o.xmdh004 = g_xmdh_d[l_ac].xmdh004
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh003
            #add-point:BEFORE FIELD xmdh003 name="input.b.page1.xmdh003"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh003
            #add-point:ON CHANGE xmdh003 name="input.g.page1.xmdh003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh004
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh004 name="input.a.page1.xmdh004"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh004 != g_xmdh_d_o.xmdh004 OR g_xmdh_d_o.xmdh004 IS NULL )) THEN
                  CALL axmt520_xmdh004_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xmdh_d[l_ac].xmdh004
                     #160318-00005#50 --s add
                        CASE g_errno
                           WHEN 'sub-01323'
                              LET g_errparam.replace[1] = 'axmt500'
                              LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
                              LET g_errparam.exeprog = 'axmt500'
                        END CASE
                        #160318-00005#50 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdh_d[l_ac].xmdh004 = g_xmdh_d_o.xmdh004
                     NEXT FIELD CURRENT
                  END IF
                  CALL axmt520_xmdh004_default()
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdh004 = g_xmdh_d[l_ac].xmdh004
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)  
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh004
            #add-point:BEFORE FIELD xmdh004 name="input.b.page1.xmdh004"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh004
            #add-point:ON CHANGE xmdh004 name="input.g.page1.xmdh004"
                         
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh005
            #add-point:BEFORE FIELD xmdh005 name="input.b.page1.xmdh005"
                         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh005
            
            #add-point:AFTER FIELD xmdh005 name="input.a.page1.xmdh005"
            LET g_xmdh_d_o.xmdh005 = g_xmdh_d[l_ac].xmdh005
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh005
            #add-point:ON CHANGE xmdh005 name="input.g.page1.xmdh005"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh006
            
            #add-point:AFTER FIELD xmdh006 name="input.a.page1.xmdh006"
            LET g_xmdh_d[l_ac].xmdh006_desc = ''
            LET g_xmdh_d[l_ac].xmdh006_desc_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh006 != g_xmdh_d_o.xmdh006 OR g_xmdh_d_o.xmdh006 IS NULL )) THEN
                  IF NOT axmt520_xmdh006_chk() THEN
                     LET g_xmdh_d[l_ac].xmdh006 = g_xmdh_d_o.xmdh006
                     CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006) RETURNING g_xmdh_d[l_ac].xmdh006_desc,g_xmdh_d[l_ac].xmdh006_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #呼叫取交易對象料號的應用元件將對應的料號抓出顯示在客戶料號
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh007) THEN
                     #161221-00064#16 mod-S
#                     CALL s_apmi070_get_pmao004(g_xmdg_m.xmdg005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
#                          RETURNING l_success,g_xmdh_d[l_ac].xmdh034
                     CALL s_apmi070_get_pmao004_2(g_xmdg_m.xmdg005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,'2')
                          RETURNING l_success,g_xmdh_d[l_ac].xmdh034
                     #161221-00064#16 mod-E
                  END IF
                  
                  IF g_flag = 'Y' THEN
                     CALL axmt520_xmdh006_default()
                  ELSE
                     #160314-00009#3  2016/03/28  By zhujing marked ---(S)
#                     LET l_imaa005 = ''
#                     CALL s_axmt500_get_imaa005(g_enterprise,g_xmdh_d[l_ac].xmdh006) RETURNING l_imaa005
#                     IF cl_null(l_imaa005) THEN
                     #160314-00009#3  2016/03/28  By zhujing marked ---(E)
                     IF s_feature_auto_chk(g_xmdh_d[l_ac].xmdh006) AND cl_null(g_xmdh_d[l_ac].xmdh007) THEN  #160314-00009#3  2016/03/28  By zhujing mod
                        CALL g_inam.clear()            
                        CALL s_feature(l_cmd,g_xmdh_d[l_ac].xmdh006,'','',g_site,g_xmdg_m.xmdgdocno) RETURNING l_success,g_inam
                        LET g_xmdh_d[l_ac].xmdh007 = g_inam[1].inam002
                        LET g_xmdh_d[l_ac].xmdh016 = g_inam[1].inam004
                     END IF
                  END IF
                  
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
                                       
               END IF
            END IF
            CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006) RETURNING g_xmdh_d[l_ac].xmdh006_desc,g_xmdh_d[l_ac].xmdh006_desc_desc
            CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
            LET g_xmdh_d_o.xmdh006 = g_xmdh_d[l_ac].xmdh006
            LET g_xmdh_d_o.xmdh007 = g_xmdh_d[l_ac].xmdh007
            LET g_xmdh_d_o.xmdh016 = g_xmdh_d[l_ac].xmdh016
            LET g_xmdh_d_o.xmdh034 = g_xmdh_d[l_ac].xmdh034
            SELECT pmao009,pmao010
              INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdg_m.xmdg005
               AND pmao002 = g_xmdh_d[l_ac].xmdh006
               AND pmao003 = g_xmdh_d[l_ac].xmdh007
               AND pmao004 = g_xmdh_d[l_ac].xmdh034      
               AND pmao000 = '2' #161221-00064#16 add               
            DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh006
            #add-point:BEFORE FIELD xmdh006 name="input.b.page1.xmdh006"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh006
            #add-point:ON CHANGE xmdh006 name="input.g.page1.xmdh006"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh007
            
            #add-point:AFTER FIELD xmdh007 name="input.a.page1.xmdh007"
            LET g_xmdh_d[l_ac].xmdh007_desc = ''
            IF cl_null(g_xmdh_d[l_ac].xmdh007) THEN
               LET g_xmdh_d[l_ac].xmdh007 = ' '
            ELSE
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh007 != g_xmdh_d_o.xmdh007 OR g_xmdh_d_o.xmdh007 IS NULL )) THEN
                  IF NOT s_feature_check(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) THEN
                     LET g_xmdh_d[l_ac].xmdh007 = g_xmdh_d_o.xmdh007
                     CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#5---dorishsu---151228---add--
                  IF NOT s_feature_direct_input(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d_o.xmdh007,g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgsite) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#5---dorishsu---151228---end--
                  IF NOT axmt520_xmdh006_xmdh007_chk() THEN
                     LET g_xmdh_d[l_ac].xmdh007 = g_xmdh_d_o.xmdh007
                     CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00064#16 mod-S
#                  CALL s_apmi070_get_pmao004(g_xmdg_m.xmdg005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
#                       RETURNING l_success,g_xmdh_d[l_ac].xmdh034
                  CALL s_apmi070_get_pmao004_2(g_xmdg_m.xmdg005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,'2')
                       RETURNING l_success,g_xmdh_d[l_ac].xmdh034
                  #161221-00064#16 mod-E
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
               END IF
            END IF
            LET g_xmdh_d_o.xmdh007 = g_xmdh_d[l_ac].xmdh007
            LET g_xmdh_d_o.xmdh016 = g_xmdh_d[l_ac].xmdh016
            LET g_xmdh_d_o.xmdh034 = g_xmdh_d[l_ac].xmdh034
            SELECT pmao009,pmao010
              INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdg_m.xmdg005
               AND pmao002 = g_xmdh_d[l_ac].xmdh006
               AND pmao003 = g_xmdh_d[l_ac].xmdh007
               AND pmao004 = g_xmdh_d[l_ac].xmdh034                      
               AND pmao000 = '2' #161221-00064#16 add               
            DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
            CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh007
            #add-point:BEFORE FIELD xmdh007 name="input.b.page1.xmdh007"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh007
            #add-point:ON CHANGE xmdh007 name="input.g.page1.xmdh007"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh034
            
            #add-point:AFTER FIELD xmdh034 name="input.a.page1.xmdh034"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh034) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh034 != g_xmdh_d_o.xmdh034 OR g_xmdh_d_o.xmdh034 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdg_m.xmdg005       #交易對象編號
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006 #料件編號
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007 #產品特徵
                  LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh034
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="apm-00261:sub-01302|apmi120|",cl_get_progname("apmi120",g_lang,"2"),"|:EXEPROGapmi120"
                  #160318-00025#15 by 07900 --add-end 
                  #161026-00025#3-s
                  LET g_chkparam.err_str[1] ="apm-00260:axm-00053|axmi120|",cl_get_progname("axmi120",g_lang,"2"),"|:EXEPROGaxmi120"
                  #161026-00025#3-e
                  IF NOT cl_chk_exist("v_pmao004") THEN
                     LET g_xmdh_d[l_ac].xmdh034 = g_xmdh_d_o.xmdh034
                     LET g_xmdh_d[l_ac].xmdh034_desc = g_xmdh_d_o.xmdh034_desc
                     LET g_xmdh_d[l_ac].xmdh034_desc_desc = g_xmdh_d_o.xmdh034_desc_desc
                     DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT pmao009,pmao010
                       INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
                       FROM pmao_t
                   WHERE pmaoent = g_enterprise
                     AND pmao001 = g_xmdg_m.xmdg005
                     AND pmao002 = g_xmdh_d[l_ac].xmdh006
                     AND pmao003 = g_xmdh_d[l_ac].xmdh007
                     AND pmao004 = g_xmdh_d[l_ac].xmdh034                      
                     AND pmao000 = '2' #161221-00064#16 add               
                  DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
               END IF
            ELSE
               LET g_xmdh_d[l_ac].xmdh034_desc = ''
               LET g_xmdh_d[l_ac].xmdh034_desc_desc = ''
               DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
            END IF 
            LET g_xmdh_d_o.xmdh034 = g_xmdh_d[l_ac].xmdh034
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh034
            #add-point:BEFORE FIELD xmdh034 name="input.b.page1.xmdh034"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh034
            #add-point:ON CHANGE xmdh034 name="input.g.page1.xmdh034"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh009
            
            #add-point:AFTER FIELD xmdh009 name="input.a.page1.xmdh009"
            LET g_xmdh_d[l_ac].xmdh009_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh009) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh009 != g_xmdh_d_o.xmdh009 OR g_xmdh_d_o.xmdh009 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = '221'
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh009
                   #160318-00025#15 by 07900 --add-str 
                 LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_oocq002_1") THEN
                     LET g_xmdh_d[l_ac].xmdh009 = g_xmdh_d_o.xmdh009
                     CALL s_desc_get_acc_desc('221',g_xmdh_d[l_ac].xmdh009) RETURNING g_xmdh_d[l_ac].xmdh009_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_acc_desc('221',g_xmdh_d[l_ac].xmdh009) RETURNING g_xmdh_d[l_ac].xmdh009_desc
            LET g_xmdh_d_o.xmdh009 = g_xmdh_d[l_ac].xmdh009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh009
            #add-point:BEFORE FIELD xmdh009 name="input.b.page1.xmdh009"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh009
            #add-point:ON CHANGE xmdh009 name="input.g.page1.xmdh009"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh010
            #add-point:BEFORE FIELD xmdh010 name="input.b.page1.xmdh010"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh010
            
            #add-point:AFTER FIELD xmdh010 name="input.a.page1.xmdh010"
            LET g_xmdh_d_o.xmdh010 = g_xmdh_d[l_ac].xmdh010
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh010
            #add-point:ON CHANGE xmdh010 name="input.g.page1.xmdh010"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh015
            
            #add-point:AFTER FIELD xmdh015 name="input.a.page1.xmdh015"
            LET g_xmdh_d[l_ac].xmdh015_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh015) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh015 != g_xmdh_d_o.xmdh015 OR g_xmdh_d_o.xmdh015 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh015
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_xmdh_d[l_ac].xmdh015 = g_xmdh_d_o.xmdh015
                     CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015) RETURNING g_xmdh_d[l_ac].xmdh015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015) RETURNING g_xmdh_d[l_ac].xmdh015_desc
            LET g_xmdh_d_o.xmdh015 = g_xmdh_d[l_ac].xmdh015
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh015
            #add-point:BEFORE FIELD xmdh015 name="input.b.page1.xmdh015"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh015
            #add-point:ON CHANGE xmdh015 name="input.g.page1.xmdh015"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh016,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh016
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh016 name="input.a.page1.xmdh016"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh016) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh016 != g_xmdh_d_o.xmdh016 OR g_xmdh_d_o.xmdh016 IS NULL )) THEN
                  IF g_flag <> 'Y' THEN
                     #輸入的數量不可大於xmdd006-xmdd031-已轉出通單未確認數量
                    #161205-00025#9 161215 by lori mod---(S)
                    #CALL axmt520_xmdd006_chk(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh016,g_xmdh_d_t.xmdh016)   
                    CALL axmt520_xmdd006_chk(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,
                                             g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh016,
                                             g_xmdh_d_t.xmdh016,'','')
                    #161205-00025#9 161215 by lori mod---(E)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xmdh_d[l_ac].xmdh016
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmdh_d[l_ac].xmdh016 = g_xmdh_d_o.xmdh016
                        NEXT FIELD CURRENT
                     END IF
                    #161102-00022#1 mark --(S)--
                    ##在揀量
                    #IF NOT axmt520_inan_chk() THEN
                    #   LET g_xmdh_d[l_ac].xmdh016 = g_xmdh_d_o.xmdh016
                    #   NEXT FIELD CURRENT
                    #END IF
                    #161102-00022#1 mark --(E)--
                  END IF
                  
                  CALL axmt520_inao('1') RETURNING l_success #150821-xianghui

                  CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
                                             g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                                             g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                                             g_xmdh_d[l_ac].xmdh001)  #150522---earl---add
                       RETURNING g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh021,
                                 g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,
                                 g_xmdh4_d[l_ac].xmdh028,g_xmdh_d[l_ac].xmdh056
               END IF
    
            END IF 
            LET g_xmdh_d_o.xmdh016 = g_xmdh_d[l_ac].xmdh016
            LET g_xmdh_d_o.xmdh017 = g_xmdh_d[l_ac].xmdh017
            LET g_xmdh_d_o.xmdh019 = g_xmdh_d[l_ac].xmdh019
            LET g_xmdh_d_o.xmdh021 = g_xmdh_d[l_ac].xmdh021
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh016
            #add-point:BEFORE FIELD xmdh016 name="input.b.page1.xmdh016"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh016
            #add-point:ON CHANGE xmdh016 name="input.g.page1.xmdh016"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh017,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh017
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh017 name="input.a.page1.xmdh017"
            LET g_xmdh_d_o.xmdh017 = g_xmdh_d[l_ac].xmdh017
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh017
            #add-point:BEFORE FIELD xmdh017 name="input.b.page1.xmdh017"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh017
            #add-point:ON CHANGE xmdh017 name="input.g.page1.xmdh017"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh018
            
            #add-point:AFTER FIELD xmdh018 name="input.a.page1.xmdh018"
            LET g_xmdh_d[l_ac].xmdh018_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh018 != g_xmdh_d_o.xmdh018 OR g_xmdh_d_o.xmdh018 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh018
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_xmdh_d[l_ac].xmdh018 = g_xmdh_d_o.xmdh018
                     CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018) RETURNING g_xmdh_d[l_ac].xmdh018_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh019) THEN
                     #對數量進行取位
                     CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                          RETURNING l_success,g_xmdh_d[l_ac].xmdh019
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018) RETURNING g_xmdh_d[l_ac].xmdh018_desc
            LET g_xmdh_d_o.xmdh018 = g_xmdh_d[l_ac].xmdh018
            LET g_xmdh_d_o.xmdh019 = g_xmdh_d[l_ac].xmdh019
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh018
            #add-point:BEFORE FIELD xmdh018 name="input.b.page1.xmdh018"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh018
            #add-point:ON CHANGE xmdh018 name="input.g.page1.xmdh018"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdh019
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh019 name="input.a.page1.xmdh019"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh019) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh019 != g_xmdh_d_o.xmdh019 OR g_xmdh_d_o.xmdh019 IS NULL )) THEN
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh018) THEN
                     #對數量進行取位
                     CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019)
                          RETURNING l_success,g_xmdh_d[l_ac].xmdh019
                  END IF
               END IF
            END IF 
            LET g_xmdh_d_o.xmdh019 = g_xmdh_d[l_ac].xmdh019
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh019
            #add-point:BEFORE FIELD xmdh019 name="input.b.page1.xmdh019"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh019
            #add-point:ON CHANGE xmdh019 name="input.g.page1.xmdh019"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh008
            
            #add-point:AFTER FIELD xmdh008 name="input.a.page1.xmdh008"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh008) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh008 != g_xmdh_d_o.xmdh008 OR g_xmdh_d_o.xmdh008 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                   #160318-00025#15 by 07900 --add-end
                  LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh008
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                  #160318-00025#15 by 07900 --add-end 
                  IF NOT cl_chk_exist("v_imaf001_2") THEN
                     LET g_xmdh_d[l_ac].xmdh008 = g_xmdh_d_o.xmdh008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_xmdh_d_o.xmdh008 = g_xmdh_d[l_ac].xmdh008
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh008
            #add-point:BEFORE FIELD xmdh008 name="input.b.page1.xmdh008"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh008
            #add-point:ON CHANGE xmdh008 name="input.g.page1.xmdh008"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh011
            #add-point:BEFORE FIELD xmdh011 name="input.b.page1.xmdh011"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh011
            
            #add-point:AFTER FIELD xmdh011 name="input.a.page1.xmdh011"
            IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
               LET g_xmdh_d[l_ac].xmdh012 = ''
               LET g_xmdh_d[l_ac].xmdh013 = ''
               LET g_xmdh_d[l_ac].xmdh014 = ''
            ELSE               
               LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
               LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
               LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
            END IF
            CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            CALL axmt520_set_entry_b(l_cmd)
            CALL axmt520_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh011
            #add-point:ON CHANGE xmdh011 name="input.g.page1.xmdh011"
            IF g_xmdh_d[l_ac].xmdh011 = 'N' THEN
               CALL axmt520_xmdi_del()
            END IF
            IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
               CALL axmt540_01('2',g_site,'',g_xmdg_m.xmdgdocno,g_xmdh_d[g_detail_idx].xmdhseq,
                               g_xmdh_d[g_detail_idx].xmdh006,g_xmdh_d[g_detail_idx].xmdh007,
                               g_xmdh_d[g_detail_idx].xmdh009,g_xmdh_d[g_detail_idx].xmdh010,
                               g_xmdh_d[g_detail_idx].xmdh015,g_xmdh_d[g_detail_idx].xmdh016,
                               '',g_xmdh_d[g_detail_idx].xmdh018,g_xmdh_d[g_detail_idx].xmdh019,
                               '','','',g_xmdh_d[g_detail_idx].xmdh001,g_xmdh_d[g_detail_idx].xmdh002,g_xmdh_d[g_detail_idx].xmdh031)
                    RETURNING l_success,l_rollback,g_xmdh_d[g_detail_idx].xmdh012,g_xmdh_d[g_detail_idx].xmdh013,g_xmdh_d[g_detail_idx].xmdh014,g_xmdh_d[g_detail_idx].xmdh029
               IF NOT l_success OR NOT cl_null(g_xmdh_d[g_detail_idx].xmdh012) THEN
                  LET g_xmdh_d[l_ac].xmdh011 = 'N'
                  #161025-00028#1--add--start--
                  IF NOT cl_null(g_xmdh_d[g_detail_idx].xmdh012) THEN
                     LET g_xmdh_d_o.xmdh012 = g_xmdh_d[l_ac].xmdh012
                     LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
                     LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
                  END IF 
                  #161025-00028#1--add--end----
               END IF
            END IF
            LET l_xmdhseq_backup = g_xmdh_d[l_ac].xmdhseq #紀錄產生庫儲批所用的項次
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh012
            
            #add-point:AFTER FIELD xmdh012 name="input.a.page1.xmdh012"
            LET g_xmdh_d[l_ac].xmdh012_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh012 != g_xmdh_d_o.xmdh012 OR g_xmdh_d_o.xmdh012 IS NULL 
                  OR g_xmdh_d[l_ac].xmdh013 != g_xmdh_d_o.xmdh013 OR g_xmdh_d_o.xmdh013 IS NULL    #150821-xianghui
                  OR g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL    #150821-xianghui
               )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #160804-00027#1 mod--s
                  #LET g_chkparam.arg1 = g_site
                  #LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006  #料件编号
                  #LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007  #产品特征
                  #LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012  #限定库位
                  #IF NOT cl_chk_exist("v_inag004_1") THEN
                  LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh006  #料件编号
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh007  #产品特征
                  LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh012  #限定库位
                  IF NOT cl_chk_exist("v_inag004_6") THEN
                  #160804-00027#1 mod--e  
                     LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                     CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150721-00001#1  2016/01/08 By earl mod s                  
                  #檢核輸入的庫位(From)是否在單據別限制範圍內
                  IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
                     CALL s_control_chk_doc('6',g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdh012,'','','','')
                     RETURNING l_success,l_flag
                     
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                        CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150721-00001#1  2016/01/08 By earl mod e
                  
                 #161102-00022#1 mark --(S)-- 
                 #IF NOT axmt520_inan_chk() THEN
                 #   LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                 #   CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
                 #   NEXT FIELD CURRENT
                 #END IF
                 #161102-00022#1 mark --(E)-- 
                  IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                     CALL axmt520_xmdi_del()
                  END IF
                  IF NOT axmt520_inao('2') THEN #150821-xianghui
                     LET g_xmdh_d[l_ac].xmdh012 = g_xmdh_d_o.xmdh012
                     CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc                    
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc                   
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014                   
                  END IF
               END IF
            END IF 
            CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
            LET g_xmdh_d_o.xmdh012 = g_xmdh_d[l_ac].xmdh012
            LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
            CALL axmt520_set_entry_b(p_cmd)
            CALL axmt520_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh012
            #add-point:BEFORE FIELD xmdh012 name="input.b.page1.xmdh012"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh012
            #add-point:ON CHANGE xmdh012 name="input.g.page1.xmdh012"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh013
            
            #add-point:AFTER FIELD xmdh013 name="input.a.page1.xmdh013"
            LET g_xmdh_d[l_ac].xmdh013_desc = ''
            #150821-xianghui
            IF g_xmdh_d[l_ac].xmdh013 IS NULL THEN 
               LET g_xmdh_d[l_ac].xmdh013 = ' '
            END IF
            #150821-xianghui            
            #IF NOT cl_null(g_xmdh_d[l_ac].xmdh013) THEN    #150821-xianghui-mark
            IF g_xmdh_d[l_ac].xmdh013 IS NOT NULL THEN   #150821-xianghui
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh013 != g_xmdh_d_o.xmdh013 OR g_xmdh_d_o.xmdh013 IS NULL 
                  OR g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL    #150821-xianghui
                  )) THEN
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh013) THEN    #150821-xianghui
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                     LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                     LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                     LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                     IF NOT cl_chk_exist("v_inag005_1") THEN
                        LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                        CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
                        NEXT FIELD CURRENT
                     END IF
                    #161102-00022#1 mark --(S)-- 
                    #IF NOT axmt520_inan_chk() THEN
                    #   LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                    #   CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
                    #   NEXT FIELD CURRENT
                    #END IF
                    #161102-00022#1 mark --(E)-- 
                     IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                        CALL axmt520_xmdi_del()
                     END IF
                  END IF   #150821-xianghui
                  IF NOT axmt520_inao('2') THEN #150821-xianghui
                     LET g_xmdh_d[l_ac].xmdh013 = g_xmdh_d_o.xmdh013
                     CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc                   
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014  
                  END IF                  
               END IF
            END IF 
            CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            LET g_xmdh_d_o.xmdh013 = g_xmdh_d[l_ac].xmdh013
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014   #150821-xianghui
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh013
            #add-point:BEFORE FIELD xmdh013 name="input.b.page1.xmdh013"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh013
            #add-point:ON CHANGE xmdh013 name="input.g.page1.xmdh013"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh014
            
            #add-point:AFTER FIELD xmdh014 name="input.a.page1.xmdh014"
            #150821-xianghui
            IF g_xmdh_d[l_ac].xmdh014 IS NULL THEN 
               LET g_xmdh_d[l_ac].xmdh014 = ' '
            END IF
            #150821-xianghui            
            #IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN    #150821-xianghui-mark
            IF g_xmdh_d[l_ac].xmdh014 IS NOT NULL THEN   #150821-xianghui
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh014 != g_xmdh_d_o.xmdh014 OR g_xmdh_d_o.xmdh014 IS NULL )) THEN
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh014) THEN    #150821-xianghui
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh006
                     LET g_chkparam.arg3 = g_xmdh_d[l_ac].xmdh007
                     LET g_chkparam.arg4 = g_xmdh_d[l_ac].xmdh012
                     LET g_chkparam.arg5 = g_xmdh_d[l_ac].xmdh013
                     LET g_chkparam.arg6 = g_xmdh_d[l_ac].xmdh014
                     #161129-00035#1----mark---begin--------
#                    IF not cl_chk_exist("v_inag006_1") THEN
#                       LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
#                       NEXT FIELD CURRENT
#                    END IF
                     #161129-00035#1----mark---end------------------
                    #161102-00022#1 mark --(S)-- 
                    #IF NOT axmt520_inan_chk() THEN
                    #   LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014
                    #   NEXT FIELD CURRENT
                    #END IF
                    #161102-00022#1 mark --(E)-- 
                     IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
                        CALL axmt520_xmdi_del()
                     END IF
                  END IF   #150821-xianghui
                  IF NOT axmt520_inao('2') THEN #150821-xianghui
                     LET g_xmdh_d[l_ac].xmdh014 = g_xmdh_d_o.xmdh014                  
                  END IF                
               END IF
            END IF 
            LET g_xmdh_d_o.xmdh014 = g_xmdh_d[l_ac].xmdh014
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh014
            #add-point:BEFORE FIELD xmdh014 name="input.b.page1.xmdh014"
                     
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh014
            #add-point:ON CHANGE xmdh014 name="input.g.page1.xmdh014"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh029
            #add-point:BEFORE FIELD xmdh029 name="input.b.page1.xmdh029"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh029
            
            #add-point:AFTER FIELD xmdh029 name="input.a.page1.xmdh029"
            #160316-00007#4--add--begin
            CALL s_axmt540_get_imaf(g_xmdh_d[l_ac].xmdh006) RETURNING l_imaf055,l_imaf061 #160519-00008#9
            IF l_imaf055  = '3' THEN   #160519-00008#9
               IF g_xmdh_d[l_ac].xmdh029 IS NULL THEN 
                  LET g_xmdh_d[l_ac].xmdh029 = ' '
               END IF
            END IF               #160519-00008#9
            IF g_xmdh_d[l_ac].xmdh029 IS NOT NULL THEN   
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh029 != g_xmdh_d_o.xmdh029 OR g_xmdh_d_o.xmdh029 IS NULL )) THEN
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh029) THEN 
                    #161102-00022#1 mark --(S)--                 
                    #IF NOT axmt520_inan_chk() THEN
                    #   LET g_xmdh_d[l_ac].xmdh029 = g_xmdh_d_o.xmdh029
                    #   NEXT FIELD CURRENT
                    #END IF
                    #161102-00022#1 mark --(E)-- 
                     IF g_xmdh_d[l_ac].xmdh029 = 'Y' THEN
                        CALL axmt520_xmdi_del()
                     END IF
                  END IF  
                  IF NOT axmt520_inao('2') THEN 
                     LET g_xmdh_d[l_ac].xmdh029 = g_xmdh_d_o.xmdh029                  
                  END IF                
               END IF
            END IF 
            LET g_xmdh_d_o.xmdh029 = g_xmdh_d[l_ac].xmdh029
            #160316-00007#4--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh029
            #add-point:ON CHANGE xmdh029 name="input.g.page1.xmdh029"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh020
            
            #add-point:AFTER FIELD xmdh020 name="input.a.page1.xmdh020"
            LET g_xmdh_d[l_ac].xmdh020_desc = ''
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh020 != g_xmdh_d_o.xmdh020 OR g_xmdh_d_o.xmdh020 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh006
                  LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh020
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_xmdh_d[l_ac].xmdh020 = g_xmdh_d_o.xmdh020
                     CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020) RETURNING g_xmdh_d[l_ac].xmdh020_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh021) THEN
                     #對出貨進行取位
                     CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                          RETURNING l_success,g_xmdh_d[l_ac].xmdh021
                     #重新計算未稅金額、含稅金額、稅額
                     CALL axmt520_get_amount(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh021,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024)
                          RETURNING g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh028,g_xmdh4_d[l_ac].xmdh027
                  END IF
               END IF
            END IF 
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020) RETURNING g_xmdh_d[l_ac].xmdh020_desc
            LET g_xmdh_d_o.xmdh020 = g_xmdh_d[l_ac].xmdh020
            LET g_xmdh_d_o.xmdh021 = g_xmdh_d[l_ac].xmdh021
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh020
            #add-point:BEFORE FIELD xmdh020 name="input.b.page1.xmdh020"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh020
            #add-point:ON CHANGE xmdh020 name="input.g.page1.xmdh020"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdh_d[l_ac].xmdh021,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdh021
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdh021 name="input.a.page1.xmdh021"
            IF NOT cl_null(g_xmdh_d[l_ac].xmdh021) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdh_d[l_ac].xmdh021 != g_xmdh_d_o.xmdh021 OR g_xmdh_d_o.xmdh021 IS NULL )) THEN
                  IF NOT cl_null(g_xmdh_d[l_ac].xmdh020) THEN
                     #對出貨進行取位
                     CALL s_aooi250_take_decimals(g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021)
                          RETURNING l_success,g_xmdh_d[l_ac].xmdh021
                  END IF
                  #重新計算未稅金額、含稅金額、稅額
                  CALL axmt520_get_amount(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh021,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024)
                       RETURNING g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh028,g_xmdh4_d[l_ac].xmdh027
               END IF
            END IF 
            LET g_xmdh_d_o.xmdh021 = g_xmdh_d[l_ac].xmdh021
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh021
            #add-point:BEFORE FIELD xmdh021 name="input.b.page1.xmdh021"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh021
            #add-point:ON CHANGE xmdh021 name="input.g.page1.xmdh021"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh022
            #add-point:BEFORE FIELD xmdh022 name="input.b.page1.xmdh022"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh022
            
            #add-point:AFTER FIELD xmdh022 name="input.a.page1.xmdh022"
            LET g_xmdh_d_o.xmdh022= g_xmdh_d[l_ac].xmdh022
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh022
            #add-point:ON CHANGE xmdh022 name="input.g.page1.xmdh022"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh036
            #add-point:BEFORE FIELD xmdh036 name="input.b.page1.xmdh036"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh036
            
            #add-point:AFTER FIELD xmdh036 name="input.a.page1.xmdh036"
            LET g_xmdh_d_o.xmdh036 = g_xmdh_d[l_ac].xmdh036
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh036
            #add-point:ON CHANGE xmdh036 name="input.g.page1.xmdh036"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh031
            
            #add-point:AFTER FIELD xmdh031 name="input.a.page1.xmdh031"
            LET g_xmdh_d_o.xmdh031 = g_xmdh_d[l_ac].xmdh031
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh031
            #add-point:BEFORE FIELD xmdh031 name="input.b.page1.xmdh031"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh031
            #add-point:ON CHANGE xmdh031 name="input.g.page1.xmdh031"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh032
            
            #add-point:AFTER FIELD xmdh032 name="input.a.page1.xmdh032"
            LET g_xmdh_d_o.xmdh032 = g_xmdh_d[l_ac].xmdh032
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh032
            #add-point:BEFORE FIELD xmdh032 name="input.b.page1.xmdh032"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh032
            #add-point:ON CHANGE xmdh032 name="input.g.page1.xmdh032"
                       
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh033
            
            #add-point:AFTER FIELD xmdh033 name="input.a.page1.xmdh033"
            LET g_xmdh_d_o.xmdh033 = g_xmdh_d[l_ac].xmdh033
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh033
            #add-point:BEFORE FIELD xmdh033 name="input.b.page1.xmdh033"
                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh033
            #add-point:ON CHANGE xmdh033 name="input.g.page1.xmdh033"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh050
            #add-point:BEFORE FIELD xmdh050 name="input.b.page1.xmdh050"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh050
            
            #add-point:AFTER FIELD xmdh050 name="input.a.page1.xmdh050"
            LET g_xmdh_d_o.xmdh050 = g_xmdh_d[l_ac].xmdh050
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh050
            #add-point:ON CHANGE xmdh050 name="input.g.page1.xmdh050"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh030
            #add-point:BEFORE FIELD xmdh030 name="input.b.page1.xmdh030"
                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh030
            
            #add-point:AFTER FIELD xmdh030 name="input.a.page1.xmdh030"
            LET g_xmdh_d_o.xmdh030 = g_xmdh_d[l_ac].xmdh030
                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh030
            #add-point:ON CHANGE xmdh030 name="input.g.page1.xmdh030"
                       
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh051
            #add-point:BEFORE FIELD xmdh051 name="input.b.page1.xmdh051"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh051
            
            #add-point:AFTER FIELD xmdh051 name="input.a.page1.xmdh051"
            LET g_xmdh_d_o.xmdh051 = g_xmdh_d[l_ac].xmdh051
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh051
            #add-point:ON CHANGE xmdh051 name="input.g.page1.xmdh051"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh052
            #add-point:BEFORE FIELD xmdh052 name="input.b.page1.xmdh052"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh052
            
            #add-point:AFTER FIELD xmdh052 name="input.a.page1.xmdh052"
            LET g_xmdh_d_o.xmdh052 = g_xmdh_d[l_ac].xmdh052

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh052
            #add-point:ON CHANGE xmdh052 name="input.g.page1.xmdh052"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdhunit
            #add-point:BEFORE FIELD xmdhunit name="input.b.page1.xmdhunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdhunit
            
            #add-point:AFTER FIELD xmdhunit name="input.a.page1.xmdhunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdhunit
            #add-point:ON CHANGE xmdhunit name="input.g.page1.xmdhunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdh035
            #add-point:BEFORE FIELD xmdh035 name="input.b.page1.xmdh035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdh035
            
            #add-point:AFTER FIELD xmdh035 name="input.a.page1.xmdh035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdh035
            #add-point:ON CHANGE xmdh035 name="input.g.page1.xmdh035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.page1.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.page1.ooff013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdhsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhsite
            #add-point:ON ACTION controlp INFIELD xmdhsite name="input.c.page1.xmdhsite"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhseq
            #add-point:ON ACTION controlp INFIELD xmdhseq name="input.c.page1.xmdhseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh001
            #add-point:ON ACTION controlp INFIELD xmdh001 name="input.c.page1.xmdh001"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh001  #給予default值
            LET g_qryparam.where = "1=1 "
            #170119-00008#2  2017/02/03 By 08171 --s add     
            LET l_slip_str = ''
            LET l_slip_wc2 = ''
            FOR l_li = 0 TO g_slip_wc1.getLength()
               LET l_in = g_slip_wc1.subString(l_li,l_li+1)
               IF l_in = "IN" THEN
                  EXIT FOR
               END IF
            END FOR
            LET l_slip_str = g_slip_wc1.subString(1,l_li+1)
            LET l_slip_wc2 = g_slip_wc1.subString(l_li,g_slip_wc1.getLength()) #IN(axmt500的單據別)
            
            #參照表編號
            SELECT ooef004 INTO l_ooac001
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            
            #170119-00008#2  2017/02/03 By 08171 --e add
            #150909 earl mod s
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_xmdg_m.xmdgdocno,'4','','xmdadocno') RETURNING l_success,l_where
            IF g_argv[01] = '8' THEN
               #LET g_qryparam.where = " xmda005 = '8' AND ",l_where #170119-00008#2  2017/02/03 By 08171 mark
               #170119-00008#2  2017/02/03 By 08171 add --s
               IF NOT cl_null(g_slip_wc1) AND l_where = '1=1' THEN
                  LET g_qryparam.where = " xmda005 = '8' AND ",l_slip_str," (SELECT ooac002 FROM ooac_t WHERE ooacent = ",g_enterprise,
                                                             "                     AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND ooac004= 'Y' ",
                                                             "                     AND ooac002 ",l_slip_wc2,")"
               ELSE
                  LET g_qryparam.where = " xmda005 = '8' AND ",l_where
               END IF
               #170119-00008#2  2017/02/03 By 08171 add --e
   	   	ELSE
               #LET g_qryparam.where = " xmda005 <> '8' AND ",l_where #170119-00008#2  2017/02/03 By 08171 mark
               #170119-00008#2  2017/02/03 By 08171 --s add
               IF NOT cl_null(g_slip_wc1) AND l_where = '1=1' THEN
                  LET g_qryparam.where = " xmda005 <> '8' AND ",l_slip_str," (SELECT ooac002 FROM ooac_t WHERE ooacent = ",g_enterprise,
                                                              "                     AND ooac001 = '",l_ooac001,"' AND ooac003 ='D-BAS-0077' AND ooac004= 'Y' ",
                                                              "                     AND ooac002 ",l_slip_wc2,")"
               ELSE
                  LET g_qryparam.where = " xmda005 <> '8' AND ",l_where
               END IF
               #170119-00008#2  2017/02/03 By 08171 --e add
            END IF

            IF l_success THEN
               IF NOT cl_null(g_xmdg_m.xmdg005) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda004 = '",g_xmdg_m.xmdg005,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg001) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda005 = '",g_xmdg_m.xmdg001,"' "
               END IF
               #add by shiun------------(S)
               IF NOT cl_null(g_xmdg_m.xmdg034) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda006 = '",g_xmdg_m.xmdg034,"' "
               END IF
               #add by shiun------------(E)
               IF NOT cl_null(g_xmdg_m.xmdg008) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda009 = '",g_xmdg_m.xmdg008,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg009) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda010 = '",g_xmdg_m.xmdg009,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg010) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda011 = '",g_xmdg_m.xmdg010,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg014) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda015 = '",g_xmdg_m.xmdg014,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg006) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda021 = '",g_xmdg_m.xmdg006,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg007) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda022 = '",g_xmdg_m.xmdg007,"' "
               END IF
               IF NOT cl_null(g_xmdg_m.xmdg013) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND xmda035 = '",g_xmdg_m.xmdg013,"' "
               END IF
            END IF
            #150909 earl mod e
            
            CALL q_xmdddocno_3()                             #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh001 = g_qryparam.return1  #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh001 TO xmdh001        #顯示到畫面上
            NEXT FIELD xmdh001                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh002
            #add-point:ON ACTION controlp INFIELD xmdh002 name="input.c.page1.xmdh002"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh003
            #add-point:ON ACTION controlp INFIELD xmdh003 name="input.c.page1.xmdh003"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh004
            #add-point:ON ACTION controlp INFIELD xmdh004 name="input.c.page1.xmdh004"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh005
            #add-point:ON ACTION controlp INFIELD xmdh005 name="input.c.page1.xmdh005"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh006
            #add-point:ON ACTION controlp INFIELD xmdh006 name="input.c.page1.xmdh006"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh006  #給予default值
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_xmdg_m.xmdgdocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF            
            IF g_flag = 'Y' THEN  #訂單費用料號
               LET g_qryparam.where = g_qryparam.where,
                                      " AND imaf001 IN (SELECT xmds001 FROM xmds_t",
                                      "                  WHERE xmdsent = ",g_enterprise,
                                      "                    AND xmdsdocno = '",g_xmdh_d[l_ac].xmdh001,"')"
               CALL q_imaf001_17()
            ELSE
               #170119-00008#2  2017/01/20 By 08171 --s add
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	   		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh006  #給予default值
               LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh001
               LET g_qryparam.arg2 = g_xmdg_m.xmdg005
               LET g_qryparam.arg3 = g_xmdh_d[l_ac].xmdh007
               LET g_qryparam.where = "1=1 "
               CALL q_imaf001_26()
               #170119-00008#2  2017/01/20 By 08171 --e add
            #   CALL q_imaf001_15()                            #呼叫開窗 #170119-00008#2  2017/01/20 By 08171 mark
            END IF
            LET g_xmdh_d[l_ac].xmdh006 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh006 TO xmdh006         #顯示到畫面上
            CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006) RETURNING g_xmdh_d[l_ac].xmdh006_desc,g_xmdh_d[l_ac].xmdh006_desc_desc
            NEXT FIELD xmdh006                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh007
            #add-point:ON ACTION controlp INFIELD xmdh007 name="input.c.page1.xmdh007"
            LET l_imaa005 = ''
            CALL s_axmt500_get_imaa005(g_enterprise,g_xmdh_d[l_ac].xmdh006) RETURNING l_imaa005
            IF NOT cl_null(l_imaa005) THEN
               CALL s_feature_single(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_site,g_xmdg_m.xmdgdocno)
                    RETURNING l_success,g_xmdh_d[l_ac].xmdh007
            END IF
            CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh034
            #add-point:ON ACTION controlp INFIELD xmdh034 name="input.c.page1.xmdh034"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh034  #給予default值
            LET g_qryparam.arg1 = g_xmdg_m.xmdg005            #交易對象編號
            LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh006      #料件編號
            LET g_qryparam.arg3 = g_xmdh_d[l_ac].xmdh007      #產品特徵
            CALL q_pmao004_1()                                #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh034 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh034 TO xmdh034         #顯示到畫面
            SELECT pmao009,pmao010
              INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdg_m.xmdg005
               AND pmao002 = g_xmdh_d[l_ac].xmdh006
               AND pmao003 = g_xmdh_d[l_ac].xmdh007
               AND pmao004 = g_xmdh_d[l_ac].xmdh034                      
               AND pmao000 = '2' #161221-00064#16 add               
            DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
            NEXT FIELD xmdh034                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh009
            #add-point:ON ACTION controlp INFIELD xmdh009 name="input.c.page1.xmdh009"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh009  #給予default值
            LET g_qryparam.arg1 = "221" 
            CALL q_oocq002()                                  #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh009 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh009 TO xmdh009         #顯示到畫面上
            CALL s_desc_get_acc_desc('221',g_xmdh_d[l_ac].xmdh009) RETURNING g_xmdh_d[l_ac].xmdh009_desc
            NEXT FIELD xmdh009                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh010
            #add-point:ON ACTION controlp INFIELD xmdh010 name="input.c.page1.xmdh010"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh015
            #add-point:ON ACTION controlp INFIELD xmdh015 name="input.c.page1.xmdh015"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh015  #給予default值
            LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            CALL q_imao002()                                  #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh015 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh015 TO xmdh015         #顯示到畫面上
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015) RETURNING g_xmdh_d[l_ac].xmdh015_desc
            NEXT FIELD xmdh015                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh016
            #add-point:ON ACTION controlp INFIELD xmdh016 name="input.c.page1.xmdh016"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh017
            #add-point:ON ACTION controlp INFIELD xmdh017 name="input.c.page1.xmdh017"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh018
            #add-point:ON ACTION controlp INFIELD xmdh018 name="input.c.page1.xmdh018"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh018  #給予default值
            LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            CALL q_imao002()                                  #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh018 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh018 TO xmdh018         #顯示到畫面上
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018) RETURNING g_xmdh_d[l_ac].xmdh018_desc
            NEXT FIELD xmdh018                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh019
            #add-point:ON ACTION controlp INFIELD xmdh019 name="input.c.page1.xmdh019"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh008
            #add-point:ON ACTION controlp INFIELD xmdh008 name="input.c.page1.xmdh008"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh008  #給予default值
            CALL q_imaf001_5()                                #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh008 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh008 TO xmdh008         #顯示到畫面上
            NEXT FIELD xmdh008                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh011
            #add-point:ON ACTION controlp INFIELD xmdh011 name="input.c.page1.xmdh011"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh012
            #add-point:ON ACTION controlp INFIELD xmdh012 name="input.c.page1.xmdh012"
   			#170117-00047#1--mark--start--
   			#INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
	   		#LET g_qryparam.reqry = FALSE	   	   
            #LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012  #給予default值
            #LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            #LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
            ##161129-00035#1----add---begin---------
            #IF NOT  cl_null(g_xmdh_d[l_ac].xmdh014) THEN
            #   LET g_qryparam.where = " inag006 = '",g_xmdh_d[l_ac].xmdh014, "' "
            #END IF 
            ##161129-00035#1----add---end---------
            ##160804-00027#1 mod--s
            ##CALL q_inag004_1()                                #呼叫開窗
            #CALL q_inag004_13()                                #呼叫開窗
            ##160804-00027#1 mod--e
            #LET g_xmdh_d[l_ac].xmdh012 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return2 
            #LET g_xmdh_d[l_ac].xmdh014 = g_qryparam.return3 
            #LET g_xmdh_d[l_ac].xmdh029 = g_qryparam.return4  #160804-00027#1 add
            #DISPLAY g_xmdh_d[l_ac].xmdh012 TO xmdh012         #顯示到畫面上
            #DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013
            #DISPLAY g_xmdh_d[l_ac].xmdh014 TO xmdh014
            #DISPLAY g_xmdh_d[l_ac].xmdh029 TO xmdh029   #160804-00027#1 add
            #CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
            #CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            #170117-00047#1--mark--end----
            CALL axmt520_xmdh012_xmdh013_xmdh014_xmdh029_qry('1') #170117-00047#1 add
            NEXT FIELD xmdh012                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh013
            #add-point:ON ACTION controlp INFIELD xmdh013 name="input.c.page1.xmdh013"
   			#170117-00047#1--mark--start--
   			#INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
	   		#LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh013  #給予default值
            #LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            #LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
            #LET g_qryparam.arg3 = g_xmdh_d[l_ac].xmdh012
            #CALL q_inag005_5()                                #呼叫開窗
            #LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return1   #將開窗取得的值回傳到變數
            #DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013         #顯示到畫面上
            #CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
            #170117-00047#1--mark--end----
            CALL axmt520_xmdh012_xmdh013_xmdh014_xmdh029_qry('2') #170117-00047#1 add
            NEXT FIELD xmdh013                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh014
            #add-point:ON ACTION controlp INFIELD xmdh014 name="input.c.page1.xmdh014"
            #170117-00047#1--add--start--
            CALL axmt520_xmdh012_xmdh013_xmdh014_xmdh029_qry('3')
            NEXT FIELD xmdh014
            #170117-00047#1--add--end----            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh029
            #add-point:ON ACTION controlp INFIELD xmdh029 name="input.c.page1.xmdh029"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh020
            #add-point:ON ACTION controlp INFIELD xmdh020 name="input.c.page1.xmdh020"
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh020  #給予default值
            LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
            CALL q_imao002()                                  #呼叫開窗
            LET g_xmdh_d[l_ac].xmdh020 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdh_d[l_ac].xmdh020 TO xmdh020         #顯示到畫面上
            CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020) RETURNING g_xmdh_d[l_ac].xmdh020_desc
            NEXT FIELD xmdh020                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh021
            #add-point:ON ACTION controlp INFIELD xmdh021 name="input.c.page1.xmdh021"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh022
            #add-point:ON ACTION controlp INFIELD xmdh022 name="input.c.page1.xmdh022"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh036
            #add-point:ON ACTION controlp INFIELD xmdh036 name="input.c.page1.xmdh036"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh031
            #add-point:ON ACTION controlp INFIELD xmdh031 name="input.c.page1.xmdh031"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh032
            #add-point:ON ACTION controlp INFIELD xmdh032 name="input.c.page1.xmdh032"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh033
            #add-point:ON ACTION controlp INFIELD xmdh033 name="input.c.page1.xmdh033"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh050
            #add-point:ON ACTION controlp INFIELD xmdh050 name="input.c.page1.xmdh050"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh030
            #add-point:ON ACTION controlp INFIELD xmdh030 name="input.c.page1.xmdh030"
                       
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh051
            #add-point:ON ACTION controlp INFIELD xmdh051 name="input.c.page1.xmdh051"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh052
            #add-point:ON ACTION controlp INFIELD xmdh052 name="input.c.page1.xmdh052"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdhunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdhunit
            #add-point:ON ACTION controlp INFIELD xmdhunit name="input.c.page1.xmdhunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdh035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdh035
            #add-point:ON ACTION controlp INFIELD xmdh035 name="input.c.page1.xmdh035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1.ooff013"
            #161031-00025#25-s
            IF NOT cl_null(g_xmdg_m.xmdgdocno) AND l_ac > 0 THEN
               CALL aooi360_02('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'','','','','','','','1')
               CALL s_aooi360_sel('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'','','','','','','','1') RETURNING l_success,g_xmdh_d[l_ac].ooff013
               LET g_ooff001_d = '6'   #6.單據單頭備註
               LET g_ooff002_d = g_prog
               LET g_ooff003_d = g_xmdg_m.xmdgdocno   #单号
               LET g_ooff004_d = 0     #项次
               LET g_ooff005_d = ' '
               LET g_ooff006_d = ' '
               LET g_ooff007_d = ' '
               LET g_ooff008_d = ' '
               LET g_ooff009_d = ' '
               LET g_ooff010_d = ' '
               LET g_ooff011_d = ' '
               CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
            END IF
            #161031-00025#25-e
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt520_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmdh_d[l_ac].xmdhseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_xmdh_d[l_ac].xmdhsite) THEN
                  LET g_xmdh_d[l_ac].xmdhsite = g_site
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axmt520_xmdh_t_mask_restore('restore_mask_o')
      
               UPDATE xmdh_t SET (xmdhdocno,xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005, 
                   xmdh006,xmdh007,xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008, 
                   xmdh011,xmdh012,xmdh013,xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032, 
                   xmdh033,xmdh050,xmdh056,xmdh030,xmdh051,xmdh052,xmdhunit,xmdh035,xmdh023,xmdh024, 
                   xmdh025,xmdh026,xmdh027,xmdh028) = (g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdhseq, 
                   g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004, 
                   g_xmdh_d[l_ac].xmdh005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh034, 
                   g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016, 
                   g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh008, 
                   g_xmdh_d[l_ac].xmdh011,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014, 
                   g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021,g_xmdh_d[l_ac].xmdh022, 
                   g_xmdh_d[l_ac].xmdh036,g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032,g_xmdh_d[l_ac].xmdh033, 
                   g_xmdh_d[l_ac].xmdh050,g_xmdh_d[l_ac].xmdh056,g_xmdh_d[l_ac].xmdh030,g_xmdh_d[l_ac].xmdh051, 
                   g_xmdh_d[l_ac].xmdh052,g_xmdh_d[l_ac].xmdhunit,g_xmdh_d[l_ac].xmdh035,g_xmdh4_d[l_ac].xmdh023, 
                   g_xmdh4_d[l_ac].xmdh024,g_xmdh4_d[l_ac].xmdh025,g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027, 
                   g_xmdh4_d[l_ac].xmdh028)
                WHERE xmdhent = g_enterprise AND xmdhdocno = g_xmdg_m.xmdgdocno 
 
                  AND xmdhseq = g_xmdh_d_t.xmdhseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                             
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdg_m.xmdgdocno
               LET gs_keys_bak[1] = g_xmdgdocno_t
               LET gs_keys[2] = g_xmdh_d[g_detail_idx].xmdhseq
               LET gs_keys_bak[2] = g_xmdh_d_t.xmdhseq
               CALL axmt520_update_b('xmdh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axmt520_xmdh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xmdh_d[g_detail_idx].xmdhseq = g_xmdh_d_t.xmdhseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xmdg_m.xmdgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmdh_d_t.xmdhseq
 
                  CALL axmt520_key_update_b(gs_keys,'xmdh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmdg_m),util.JSON.stringify(g_xmdh_d_t)
               LET g_log2 = util.JSON.stringify(g_xmdg_m),util.JSON.stringify(g_xmdh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT axmt540_01_xmdm_modify('2',l_xmdhseq_backup,g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,
                                             g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                             g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,
                                             g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh015,
                                             g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,
                                             '','') THEN
                  CALL s_transaction_end('N','0')
               END IF
              #160324-00021#1 mod str
              #IF NOT axmt520_upd_xmdd031(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,
              #                           g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh016,g_xmdh_d_t.xmdh016) THEN
               IF NOT axmt520_upd_xmdd031(g_xmdh_d[l_ac].xmdh001,g_xmdh_d_t.xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d_t.xmdh002,
                                          g_xmdh_d[l_ac].xmdh003,g_xmdh_d_t.xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d_t.xmdh004,
                                          g_xmdh_d[l_ac].xmdh016,g_xmdh_d_t.xmdh016) THEN
              #160324-00021#1 mod end
                  CALL s_transaction_end('N','0')
               END IF
               #161031-00025#24-s
               CALL s_aooi360_del('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d_t.xmdhseq,'','','','','','','','1') RETURNING l_success
               IF NOT cl_null(g_xmdh_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'','','','','','','','1',g_xmdh_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#24-e               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                       
            #end add-point
            CALL axmt520_unlock_b("xmdh_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
 
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            CALL axmt520_total_count()
            CALL s_transaction_end('Y','0')
            CALL axmt520_b_fill()

            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmdh_d[li_reproduce_target].* = g_xmdh_d[li_reproduce].*
               LET g_xmdh4_d[li_reproduce_target].* = g_xmdh4_d[li_reproduce].*
 
               LET g_xmdh_d[li_reproduce_target].xmdhseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmdh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmdh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_xmdh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL axmt520_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
                       
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL axmt520_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
            CALL axmt520_b_fill()
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_xmdh4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL axmt520_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body4.before_row"
            CALL axmt520_b_fill()
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            CALL axmt520_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body4.action"
            CALL axmt520_b_fill()
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="axmt520.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身  #161031-00025#25 add         
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #161031-00025#25-s
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff012     
            END CASE
         END IF
         #161031-00025#25-e                   
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','3',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xmdgdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmdhsite
               WHEN "s_detail2"
                  NEXT FIELD xmdisite
               WHEN "s_detail4"
                  NEXT FIELD xmdhseq_3
 
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
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
     
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmt520_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象全名   #161207-00033#35 add  
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axmt520_b_fill() #單身填充
      CALL axmt520_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmt520_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_xmdg_m.xmdgdocno) RETURNING g_xmdg_m.xmdgdocno_desc
   
   CALL axmt520_xmdg017_ref()
   CALL axmt520_xmdg023_ref()
   
   CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019) RETURNING g_xmdg_m.xmdg019_desc
   
   CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020) RETURNING g_xmdg_m.xmdg020_desc            
   
   CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010) RETURNING g_xmdg_m.xmdg010_desc
  
   CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013) RETURNING g_xmdg_m.xmdg013_desc
   #161207-00033#35-s      
   IF cl_null(g_xmdg_m.xmdg004) THEN
      CALL axmt520_get_pmak003('2',g_xmdg_m.xmdgdocno)
   ELSE
      CALL axmt520_get_pmak003('1',g_xmdg_m.xmdg004)
   END IF
   #161207-00033#35-e   
   #end add-point
   
   #遮罩相關處理
   LET g_xmdg_m_mask_o.* =  g_xmdg_m.*
   CALL axmt520_xmdg_t_mask()
   LET g_xmdg_m_mask_n.* =  g_xmdg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
       g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdgstus, 
       g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc, 
       g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc,g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc, 
       g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc, 
       g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid, 
       g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc, 
       g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdg_m.xmdgstus 
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
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmdh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
#150123 搬至b_fill段  earl
#      CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
#
#      #150120新增"客戶訂單號碼"  earl(s)
#      SELECT xmda033 INTO g_xmdh_d[l_ac].xmda033
#        FROM xmda_t
#       WHERE xmdaent = g_enterprise
#         AND xmdadocno = g_xmdh_d[l_ac].xmdh001
#      #150120新增"客戶訂單號碼"  earl(e)

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmdh2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

#150123 搬至b_fill段  earl
#      CALL s_feature_description(g_xmdh2_d[l_ac].xmdi001,g_xmdh2_d[l_ac].xmdi002) RETURNING l_success,g_xmdh2_d[l_ac].xmdi002_desc
#      
#      CALL s_desc_get_item_desc(g_xmdh2_d[l_ac].xmdi001) RETURNING g_xmdh2_d[l_ac].xmdi001_desc,g_xmdh2_d[l_ac].xmdi001_desc_desc
#      
#      CALL s_desc_get_acc_desc('221',g_xmdh2_d[l_ac].xmdi003) RETURNING g_xmdh2_d[l_ac].xmdi003_desc
#      
#      CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdi005) RETURNING g_xmdh2_d[l_ac].xmdi005
#      
#      CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdi005,g_xmdh2_d[l_ac].xmdi006) RETURNING g_xmdh2_d[l_ac].xmdi006_desc
#      
#      CALL s_desc_get_unit_desc(g_xmdh2_d[l_ac].xmdi008) RETURNING g_xmdh2_d[l_ac].xmdi008_desc
#     
#      CALL s_desc_get_unit_desc(g_xmdh2_d[l_ac].xmdi010) RETURNING g_xmdh2_d[l_ac].xmdi010_desc

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmdh4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
#150123 搬至b_fill段  earl
#      CALL s_feature_description(g_xmdh4_d[l_ac].xmdh0061,g_xmdh4_d[l_ac].xmdh0071) RETURNING l_success,g_xmdh4_d[l_ac].xmdh0071_desc
#      
#      CALL s_desc_get_tax_desc1(g_site,g_xmdh4_d[l_ac].xmdh024) RETURNING g_xmdh4_d[l_ac].xmdh024_desc
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axmt520_detail_show()
 
   #add-point:show段之後 name="show.after"
     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axmt520_detail_show()
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
 
{<section id="axmt520.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmt520_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xmdg_t.xmdgdocno 
   DEFINE l_oldno     LIKE xmdg_t.xmdgdocno 
 
   DEFINE l_master    RECORD LIKE xmdg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmdh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmdi_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
     
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   IF NOT cl_null(g_xmdg_m.xmdg004) THEN
      IF NOT axmt520_xmdadocno_chk(g_xmdg_m.xmdg004,'1') THEN
         RETURN
      END IF
   END IF
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_xmdg_m.xmdgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
    
   LET g_xmdg_m.xmdgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdg_m.xmdgownid = g_user
      LET g_xmdg_m.xmdgowndp = g_dept
      LET g_xmdg_m.xmdgcrtid = g_user
      LET g_xmdg_m.xmdgcrtdp = g_dept 
      LET g_xmdg_m.xmdgcrtdt = cl_get_current()
      LET g_xmdg_m.xmdgmodid = g_user
      LET g_xmdg_m.xmdgmoddt = cl_get_current()
      LET g_xmdg_m.xmdgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xmdg_m.xmdgcnfid = ""
   LET g_xmdg_m.xmdgcnfdt = ""
   LET g_xmdg_m.xmdgdocdt = g_today
   LET g_xmdg_m.xmdg002   = g_user
   LET g_xmdg_m.xmdg003   = g_dept
   LET g_xmdg_m.xmdg054   = "N"  #多角貿易已拋轉
   LET g_xmdg_m.xmdgownid_desc = cl_get_username(g_xmdg_m.xmdgownid)
   LET g_xmdg_m.xmdgcrtid_desc = cl_get_username(g_xmdg_m.xmdgcrtid)
   LET g_xmdg_m.xmdgmodid_desc = ''
   LET g_xmdg_m.xmdgcnfid_desc = ''
   LET g_xmdg_m.xmdg002_desc   = cl_get_username(g_xmdg_m.xmdg002)
   LET g_xmdg_m.xmdgowndp_desc = cl_get_deptname(g_xmdg_m.xmdgowndp)
   LET g_xmdg_m.xmdgcrtdp_desc = cl_get_deptname(g_xmdg_m.xmdgcrtdp)
   LET g_xmdg_m.xmdg003_desc   = cl_get_deptname(g_xmdg_m.xmdg003)
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdg_m.xmdgstus 
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
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xmdg_m.xmdgdocno_desc = ''
   DISPLAY BY NAME g_xmdg_m.xmdgdocno_desc
 
   
   CALL axmt520_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xmdg_m.* TO NULL
      INITIALIZE g_xmdh_d TO NULL
      INITIALIZE g_xmdh2_d TO NULL
      INITIALIZE g_xmdh4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axmt520_show()
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
   CALL axmt520_set_act_visible()   
   CALL axmt520_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdgent = " ||g_enterprise|| " AND",
                      " xmdgdocno = '", g_xmdg_m.xmdgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
     
   #end add-point
   
   CALL axmt520_idx_chk()
   
   LET g_data_owner = g_xmdg_m.xmdgownid      
   LET g_data_dept  = g_xmdg_m.xmdgowndp
   
   #功能已完成,通報訊息中心
   CALL axmt520_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmt520_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmdh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmdi_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   #150522---earl---add---s
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_slip         LIKE ooba_t.ooba002
   DEFINE l_xmdh056      LIKE xmdh_t.xmdh056
   #150522---earl---add---e
   DEFINE l_xmdh  RECORD
       xmdhdocno  LIKE xmdh_t.xmdhdocno,
       xmdhseq    LIKE xmdh_t.xmdhseq,
       xmdh001    LIKE xmdh_t.xmdh001,
       xmdh002    LIKE xmdh_t.xmdh002,
       xmdh003    LIKE xmdh_t.xmdh003,
       xmdh004    LIKE xmdh_t.xmdh004,
       xmdh006    LIKE xmdh_t.xmdh006,
       xmdh016    LIKE xmdh_t.xmdh016,
       xmdh022    LIKE xmdh_t.xmdh022
              END RECORD
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmt520_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
     
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdh_t
    WHERE xmdhent = g_enterprise AND xmdhdocno = g_xmdgdocno_t
 
    INTO TEMP axmt520_detail
 
   #將key修正為調整後   
   UPDATE axmt520_detail 
      #更新key欄位
      SET xmdhdocno = g_xmdg_m.xmdgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   INITIALIZE l_xmdh.* TO NULL
   DECLARE axmt520_detail_reproduce_chk_cs CURSOR FOR
      SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh006,xmdh016,xmdh022
        FROM axmt520_detail
   FOREACH axmt520_detail_reproduce_chk_cs
      INTO l_xmdh.xmdhdocno,l_xmdh.xmdhseq,l_xmdh.xmdh001,l_xmdh.xmdh002,l_xmdh.xmdh003,
           l_xmdh.xmdh004,l_xmdh.xmdh006,l_xmdh.xmdh016,l_xmdh.xmdh022
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "FOREACH axmt520_detail_reproduce_chk_cs" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
        LET l_success = FALSE
        EXIT FOREACH
      END IF
      
      #檢核不可大於(xmdd006-xmdd014-已登打出貨未確認的出貨量)
     #161205-00025#9 161215 by lori mod---(S) 
     #CALL axmt520_xmdd006_chk(l_xmdh.xmdh001,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh006,l_xmdh.xmdh016,0) 
      CALL axmt520_xmdd006_chk(l_xmdh.xmdh001,l_xmdh.xmdh002,l_xmdh.xmdh003,
                               l_xmdh.xmdh004,l_xmdh.xmdh006,l_xmdh.xmdh016,
                               0,'','') 
     #161205-00025#9 161215 by lori mod---(E)
      IF NOT cl_null(g_errno) THEN
         DELETE FROM axmt520_detail
          WHERE xmdhent = g_enterprise
            AND xmdhdocno = l_xmdh.xmdhdocno
            AND xmdhseq = l_xmdh.xmdhseq
         CONTINUE FOREACH
      END IF
      
     #160324-00021#1 mod str
     #IF NOT axmt520_upd_xmdd031(l_xmdh.xmdh001,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh016,0) THEN          
      IF NOT axmt520_upd_xmdd031(l_xmdh.xmdh001,'',l_xmdh.xmdh002,'',
                                 l_xmdh.xmdh003,'',l_xmdh.xmdh004,'',
                                 l_xmdh.xmdh016,0) THEN
     #160324-00021#1 mod end
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #150522---earl---mod---s
      
      #預設檢驗合格量
      IF l_xmdh.xmdh022 = 'Y' AND NOT cl_null(l_xmdh.xmdh001) THEN
         #單據別參數
         CALL s_aooi200_get_slip(l_xmdh.xmdh001) RETURNING l_success,l_slip
         IF l_success THEN
            #OQC檢驗時機為"1出貨通知時檢驗"
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094') = '1' THEN
               LET l_xmdh056 = 0
            ELSE
               LET l_xmdh056 = l_xmdh.xmdh016
            END IF
         ELSE
            LET l_xmdh056 =  l_xmdh.xmdh016
         END IF
      END IF
      
      UPDATE axmt520_detail
         SET xmdh030 = '0',        #已轉出貨數量
             xmdh056 = l_xmdh056   #檢驗合格量
       WHERE xmdhent = g_enterprise
         AND xmdhdocno = l_xmdh.xmdhdocno
         AND xmdhseq = l_xmdh.xmdhseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE axmt520_detail" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF NOT l_success THEN
      RETURN
   END IF
   #150522---earl---mod---e

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xmdh_t SELECT * FROM axmt520_detail
   
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
   DROP TABLE axmt520_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
 
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
     
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdi_t 
    WHERE xmdient = g_enterprise AND xmdidocno = g_xmdgdocno_t
 
    INTO TEMP axmt520_detail
 
   #將key修正為調整後   
   UPDATE axmt520_detail SET xmdidocno = g_xmdg_m.xmdgdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmdi_t SELECT * FROM axmt520_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   UPDATE xmdi_t SET xmdi012 = '0'  #已轉出貨量
    WHERE xmdient = g_enterprise
      AND xmdidocno = g_xmdg_m.xmdgdocno
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt520_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
     
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmt520_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xmdg_m.xmdgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt520_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT axmt520_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdg_m_mask_o.* =  g_xmdg_m.*
   CALL axmt520_xmdg_t_mask()
   LET g_xmdg_m_mask_n.* =  g_xmdg_m.*
   
   CALL axmt520_show()
   
   #add-point:delete段before ask name="delete.before_ask"
 
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
           
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmt520_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
 
      DELETE FROM xmdg_t
       WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdg_m.xmdgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
           
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdg_m.xmdgdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#25-s mark
#      IF NOT s_aooi360_del('6',g_prog,g_xmdg_m.xmdgdocno,'','','','','','','','','4') THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
      #161031-00025#25-e mark
      #161031-00025#25-s
      #单头的aooi360_01的备注单身资料同步删除
      DELETE FROM ooff_t
       WHERE ooffent = g_enterprise AND ooff001 IN ('6','7')
         AND ooff002 = g_prog AND ooff003 = g_xmdg_m.xmdgdocno
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdg_m.xmdgdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      CALL aooi360_01_clear_detail()   #清除备注单身  
      #161031-00025#25-e      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"

      #依據出貨明細的的實際出貨數量更新對應的訂的交期名細中的已轉出貨量(xmdd031)
      IF NOT s_axmt520_upd_xmdd031(g_xmdg_m.xmdgdocno,'') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #end add-point
      
      DELETE FROM xmdh_t
       WHERE xmdhent = g_enterprise AND xmdhdocno = g_xmdg_m.xmdgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
           
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"

      DELETE FROM xrcd_t
       WHERE xrcddocno = g_xmdg_m.xmdgdocno
         AND xrcdent = g_enterprise    #160902-00048#2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
           
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
           
      #end add-point
      DELETE FROM xmdi_t
       WHERE xmdient = g_enterprise AND
             xmdidocno = g_xmdg_m.xmdgdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
           
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #150821-xianghui-b
      #同步刪除對應的[T:製造批序號庫存異動明細檔]
      DELETE FROM inao_t
         WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno = g_xmdg_m.xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      CALL s_lot_clear_detail()  
      #150821-xianghui-e      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmdg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axmt520_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xmdh_d.clear() 
      CALL g_xmdh2_d.clear()       
      CALL g_xmdh4_d.clear()       
 
     
      CALL axmt520_ui_browser_refresh()  
      #CALL axmt520_ui_headershow()  
      #CALL axmt520_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
 
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
 
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axmt520_browser_fill("")
         CALL axmt520_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmt520_cl
 
   #功能已完成,通報訊息中心
   CALL axmt520_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmt520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmt520_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql      STRING    #161205-00025#9 161215 by lori add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xmdh_d.clear()
   CALL g_xmdh2_d.clear()
   CALL g_xmdh4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #161205-00025#9 161215 by lori add---(S)
   LET l_sql = "SELECT xmda033 ",
               "  FROM xmda_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdadocno = ? "
   PREPARE axmt520_sel_xmda033 FROM l_sql   

   LET l_sql = "SELECT pmao009,pmao010 ",
               "  FROM pmao_t ",
               " WHERE pmaoent = ",g_enterprise,
               "   AND pmao000 = '2'",    #161221-00064#16 add               
               "   AND pmao001 = '",g_xmdg_m.xmdg005,"' ",
               "   AND pmao002 = ? ",
               "   AND pmao003 = ? ",
               "   AND pmao004 = ? "
   PREPARE axmt520_sel_pmao FROM l_sql            
   #161205-00025#9 161215 by lori add---(E)  
   #end add-point
   
   #判斷是否填充
   IF axmt520_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
 
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006, 
             xmdh007,xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011, 
             xmdh012,xmdh013,xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033, 
             xmdh050,xmdh056,xmdh030,xmdh051,xmdh052,xmdhunit,xmdh035,xmdhseq,xmdh023,xmdh024,xmdh025, 
             xmdh026,xmdh027,xmdh028 ,t1.imaal003 ,t2.imaal004 ,t5.oocql004 ,t6.oocal003 ,t7.oocal003 , 
             t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.pjbal003 ,t12.pjbbl004 ,t13.pjbml004 ,t21.imaal003 , 
             t22.imaal004 ,t23.oocql004 ,t24.oocal003 ,t25.oocal003 FROM xmdh_t",   
                     " INNER JOIN xmdg_t ON xmdgent = " ||g_enterprise|| " AND xmdgdocno = xmdhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdh006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdh006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmdh018 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=xmdh012 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent="||g_enterprise||" AND t9.inabsite=xmdhsite AND t9.inab001=xmdh012 AND t9.inab002=xmdh013  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=xmdh020 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t11 ON t11.pjbalent="||g_enterprise||" AND t11.pjbal001=xmdh031 AND t11.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t12 ON t12.pjbblent="||g_enterprise||" AND t12.pjbbl001=xmdh031 AND t12.pjbbl002=xmdh032 AND t12.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t13 ON t13.pjbmlent="||g_enterprise||" AND t13.pjbml001=xmdh031 AND t13.pjbml002=xmdh033 AND t13.pjbml003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t21 ON t21.imaalent="||g_enterprise||" AND t21.imaal001=xmdh006 AND t21.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t22 ON t22.imaalent="||g_enterprise||" AND t22.imaal001=xmdh006 AND t22.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t23 ON t23.oocqlent="||g_enterprise||" AND t23.oocql001='221' AND t23.oocql002=xmdh009 AND t23.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t24 ON t24.oocalent="||g_enterprise||" AND t24.oocal001=xmdh015 AND t24.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t25 ON t25.oocalent="||g_enterprise||" AND t25.oocal001=xmdh020 AND t25.oocal002='"||g_dlang||"' ",
 
                     " WHERE xmdhent=? AND xmdhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #161031-00025#25-s
         LET g_sql = "SELECT  DISTINCT xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006, 
             xmdh007,xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011, 
             xmdh012,xmdh013,xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033, 
             xmdh050,xmdh056,xmdh030,xmdh051,xmdh052,xmdhunit,xmdh035,xmdhseq,xmdh023,xmdh024,xmdh025, 
             xmdh026,xmdh027,xmdh028 ,t1.imaal003 ,t2.imaal004 ,t5.oocql004 ,t6.oocal003 ,t7.oocal003 , 
             t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.pjbal003 ,t12.pjbbl004 ,t13.pjbml004 ,t21.imaal003 , 
             t22.imaal004 ,t23.oocql004 ,t24.oocal003 ,t25.oocal003 FROM xmdh_t",   
                     " INNER JOIN xmdg_t ON xmdgent = " ||g_enterprise|| " AND xmdgdocno = xmdhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdh006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdh006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=xmdh009 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=xmdh015 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmdh018 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=xmdh012 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent="||g_enterprise||" AND t9.inabsite=xmdhsite AND t9.inab001=xmdh012 AND t9.inab002=xmdh013  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=xmdh020 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t11 ON t11.pjbalent="||g_enterprise||" AND t11.pjbal001=xmdh031 AND t11.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t12 ON t12.pjbblent="||g_enterprise||" AND t12.pjbbl001=xmdh031 AND t12.pjbbl002=xmdh032 AND t12.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t13 ON t13.pjbmlent="||g_enterprise||" AND t13.pjbml001=xmdh031 AND t13.pjbml002=xmdh033 AND t13.pjbml003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t21 ON t21.imaalent="||g_enterprise||" AND t21.imaal001=xmdh006 AND t21.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t22 ON t22.imaalent="||g_enterprise||" AND t22.imaal001=xmdh006 AND t22.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t23 ON t23.oocqlent="||g_enterprise||" AND t23.oocql001='221' AND t23.oocql002=xmdh009 AND t23.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t24 ON t24.oocalent="||g_enterprise||" AND t24.oocal001=xmdh015 AND t24.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t25 ON t25.oocalent="||g_enterprise||" AND t25.oocal001=xmdh020 AND t25.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooff_t  ON ooffent="||g_enterprise||" AND ooff002 = '",g_prog,"' AND ooff003 = xmdhdocno AND ooff004 = xmdhseq", 
                     " WHERE xmdhent=? AND xmdhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #161031-00025#25-e
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmdh_t.xmdhseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt520_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmt520_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmdg_m.xmdgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmdg_m.xmdgdocno INTO g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdhseq, 
          g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004, 
          g_xmdh_d[l_ac].xmdh005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh034, 
          g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016, 
          g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh008, 
          g_xmdh_d[l_ac].xmdh011,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014, 
          g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021,g_xmdh_d[l_ac].xmdh022, 
          g_xmdh_d[l_ac].xmdh036,g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032,g_xmdh_d[l_ac].xmdh033, 
          g_xmdh_d[l_ac].xmdh050,g_xmdh_d[l_ac].xmdh056,g_xmdh_d[l_ac].xmdh030,g_xmdh_d[l_ac].xmdh051, 
          g_xmdh_d[l_ac].xmdh052,g_xmdh_d[l_ac].xmdhunit,g_xmdh_d[l_ac].xmdh035,g_xmdh4_d[l_ac].xmdhseq, 
          g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,g_xmdh4_d[l_ac].xmdh025,g_xmdh4_d[l_ac].xmdh026, 
          g_xmdh4_d[l_ac].xmdh027,g_xmdh4_d[l_ac].xmdh028,g_xmdh_d[l_ac].xmdh006_desc,g_xmdh_d[l_ac].xmdh006_desc_desc, 
          g_xmdh_d[l_ac].xmdh009_desc,g_xmdh_d[l_ac].xmdh015_desc,g_xmdh_d[l_ac].xmdh018_desc,g_xmdh_d[l_ac].xmdh012_desc, 
          g_xmdh_d[l_ac].xmdh013_desc,g_xmdh_d[l_ac].xmdh020_desc,g_xmdh_d[l_ac].xmdh031_desc,g_xmdh_d[l_ac].xmdh032_desc, 
          g_xmdh_d[l_ac].xmdh033_desc,g_xmdh4_d[l_ac].xmdh0061_desc,g_xmdh4_d[l_ac].xmdh0061_desc_desc, 
          g_xmdh4_d[l_ac].xmdh0091_desc,g_xmdh4_d[l_ac].xmdh0151_desc,g_xmdh4_d[l_ac].xmdh0201_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
        
         CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007) RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
       
         #161205-00025#9 161215 by lori mod---(S)
         ##150120新增"客戶訂單號碼"  earl(s)
         #SELECT xmda033 INTO g_xmdh_d[l_ac].xmda033
         #  FROM xmda_t
         # WHERE xmdaent = g_enterprise
         #   AND xmdadocno = g_xmdh_d[l_ac].xmdh001
         ##150120新增"客戶訂單號碼"  earl(e) 
         
         EXECUTE axmt520_sel_xmda033 USING g_xmdh_d[l_ac].xmdh001
                                     INTO g_xmdh_d[l_ac].xmda033
         #161205-00025#9 161215 by lori mod---(E)         
         
         #161205-00025#9 161215 by lori mark---(S)
         ##add by lixiang 2015/06/18--s--
         #CALL s_desc_get_project_desc(g_xmdh_d[l_ac].xmdh031) RETURNING g_xmdh_d[l_ac].xmdh031_desc
         #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh031_desc
         #
         #CALL s_desc_get_wbs_desc(g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032) RETURNING g_xmdh_d[l_ac].xmdh032_desc
         #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh032_desc
         #
         #CALL s_desc_get_activity_desc(g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh033) RETURNING g_xmdh_d[l_ac].xmdh033_desc
         #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh033_desc
         #
         ##add by lixiang 2015/06/18--e----
         #161205-00025#9 161215 by lori mark---(E)
         CALL axmt520_xmdh_display()

         CALL s_feature_description(g_xmdh4_d[l_ac].xmdh0061,g_xmdh4_d[l_ac].xmdh0071) RETURNING l_success,g_xmdh4_d[l_ac].xmdh0071_desc
      
         CALL s_desc_get_tax_desc1(g_site,g_xmdh4_d[l_ac].xmdh024) RETURNING g_xmdh4_d[l_ac].xmdh024_desc
         
         #161205-00025#9 161215 by lori mod---(S)
         #SELECT pmao009,pmao010
         #  INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
         #  FROM pmao_t
         # WHERE pmaoent = g_enterprise
         #   AND pmao001 = g_xmdg_m.xmdg005
         #   AND pmao002 = g_xmdh_d[l_ac].xmdh006
         #   AND pmao003 = g_xmdh_d[l_ac].xmdh007
         #   AND pmao004 = g_xmdh_d[l_ac].xmdh034
         #DISPLAY BY NAME g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
         
         EXECUTE axmt520_sel_pmao USING g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh034
                                   INTO g_xmdh_d[l_ac].xmdh034_desc,g_xmdh_d[l_ac].xmdh034_desc_desc
         #161205-00025#9 161215 by lori mod---(S)             
         #161031-00025#25-s
         CALL s_aooi360_sel('7',g_prog,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'','','','','','','','1') RETURNING l_success,g_xmdh_d[l_ac].ooff013
         #161031-00025#25-e         
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
   IF axmt520_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmdisite,xmdiseq,xmdiseq1,xmdi001,xmdi002,xmdi003,xmdi004,xmdi005, 
             xmdi006,xmdi007,xmdi013,xmdi008,xmdi009,xmdi010,xmdi011,xmdi012 ,t14.imaal003 ,t15.imaal004 , 
             t16.oocql004 ,t17.inayl003 ,t18.inab003 ,t19.oocal003 ,t20.oocal003 FROM xmdi_t",   
                     " INNER JOIN  xmdg_t ON xmdgent = " ||g_enterprise|| " AND xmdgdocno = xmdidocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t14 ON t14.imaalent="||g_enterprise||" AND t14.imaal001=xmdi001 AND t14.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t15 ON t15.imaalent="||g_enterprise||" AND t15.imaal001=xmdi001 AND t15.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='221' AND t16.oocql002=xmdi003 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t17 ON t17.inaylent="||g_enterprise||" AND t17.inayl001=xmdi005 AND t17.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t18 ON t18.inabent="||g_enterprise||" AND t18.inabsite=xmdisite AND t18.inab001=xmdi005 AND t18.inab002=xmdi006  ",
               " LEFT JOIN oocal_t t19 ON t19.oocalent="||g_enterprise||" AND t19.oocal001=xmdi008 AND t19.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t20 ON t20.oocalent="||g_enterprise||" AND t20.oocal001=xmdi010 AND t20.oocal002='"||g_dlang||"' ",
 
                     " WHERE xmdient=? AND xmdidocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
           
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmdi_t.xmdiseq,xmdi_t.xmdiseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
           
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt520_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axmt520_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xmdg_m.xmdgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xmdg_m.xmdgdocno INTO g_xmdh2_d[l_ac].xmdisite,g_xmdh2_d[l_ac].xmdiseq, 
          g_xmdh2_d[l_ac].xmdiseq1,g_xmdh2_d[l_ac].xmdi001,g_xmdh2_d[l_ac].xmdi002,g_xmdh2_d[l_ac].xmdi003, 
          g_xmdh2_d[l_ac].xmdi004,g_xmdh2_d[l_ac].xmdi005,g_xmdh2_d[l_ac].xmdi006,g_xmdh2_d[l_ac].xmdi007, 
          g_xmdh2_d[l_ac].xmdi013,g_xmdh2_d[l_ac].xmdi008,g_xmdh2_d[l_ac].xmdi009,g_xmdh2_d[l_ac].xmdi010, 
          g_xmdh2_d[l_ac].xmdi011,g_xmdh2_d[l_ac].xmdi012,g_xmdh2_d[l_ac].xmdi001_desc,g_xmdh2_d[l_ac].xmdi001_desc_desc, 
          g_xmdh2_d[l_ac].xmdi003_desc,g_xmdh2_d[l_ac].xmdi005_desc,g_xmdh2_d[l_ac].xmdi006_desc,g_xmdh2_d[l_ac].xmdi008_desc, 
          g_xmdh2_d[l_ac].xmdi010_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
      
         CALL s_feature_description(g_xmdh2_d[l_ac].xmdi001,g_xmdh2_d[l_ac].xmdi002) RETURNING l_success,g_xmdh2_d[l_ac].xmdi002_desc
         
         #161205-00025#9 161215 by lori mark---(S)
         #CALL s_desc_get_item_desc(g_xmdh2_d[l_ac].xmdi001) RETURNING g_xmdh2_d[l_ac].xmdi001_desc,g_xmdh2_d[l_ac].xmdi001_desc_desc
         #
         #CALL s_desc_get_acc_desc('221',g_xmdh2_d[l_ac].xmdi003) RETURNING g_xmdh2_d[l_ac].xmdi003_desc
         #161205-00025#9 161215 by lori mark---(E)
         
         CALL s_desc_get_stock_desc(g_site,g_xmdh2_d[l_ac].xmdi005) RETURNING g_xmdh2_d[l_ac].xmdi005_desc
         
         CALL s_desc_get_locator_desc(g_site,g_xmdh2_d[l_ac].xmdi005,g_xmdh2_d[l_ac].xmdi006) RETURNING g_xmdh2_d[l_ac].xmdi006_desc
         
         #161205-00025#9 161215 by lori mark---(S)
         #CALL s_desc_get_unit_desc(g_xmdh2_d[l_ac].xmdi008) RETURNING g_xmdh2_d[l_ac].xmdi008_desc
         #
         #CALL s_desc_get_unit_desc(g_xmdh2_d[l_ac].xmdi010) RETURNING g_xmdh2_d[l_ac].xmdi010_desc
         #161205-00025#9 161215 by lori mark---(E)
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
   IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
      CALL s_lot_b_fill('1',g_site,'2',g_xmdg_m.xmdgdocno,'','','-1')
   END IF
   #161031-00025#25-s
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog
   LET g_ooff003_d = g_xmdg_m.xmdgdocno   #单号
   LET g_ooff004_d = '0'     #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
   #161031-00025#25-e 
   #end add-point
   
   CALL g_xmdh_d.deleteElement(g_xmdh_d.getLength())
   CALL g_xmdh2_d.deleteElement(g_xmdh2_d.getLength())
   CALL g_xmdh4_d.deleteElement(g_xmdh4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axmt520_pb
   FREE axmt520_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmdh_d.getLength()
      LET g_xmdh_d_mask_o[l_ac].* =  g_xmdh_d[l_ac].*
      CALL axmt520_xmdh_t_mask()
      LET g_xmdh_d_mask_n[l_ac].* =  g_xmdh_d[l_ac].*
   END FOR
   
   LET g_xmdh2_d_mask_o.* =  g_xmdh2_d.*
   FOR l_ac = 1 TO g_xmdh2_d.getLength()
      LET g_xmdh2_d_mask_o[l_ac].* =  g_xmdh2_d[l_ac].*
      CALL axmt520_xmdi_t_mask()
      LET g_xmdh2_d_mask_n[l_ac].* =  g_xmdh2_d[l_ac].*
   END FOR
   LET g_xmdh4_d_mask_o.* =  g_xmdh4_d.*
   FOR l_ac = 1 TO g_xmdh4_d.getLength()
      LET g_xmdh4_d_mask_o[l_ac].* =  g_xmdh4_d[l_ac].*
      CALL axmt520_xmdh_t_mask()
      LET g_xmdh4_d_mask_n[l_ac].* =  g_xmdh4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmt520_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_success   LIKE type_t.num5
     
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xmdh_t
       WHERE xmdhent = g_enterprise AND
         xmdhdocno = ps_keys_bak[1] AND xmdhseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      CALL axmt540_01_xmdm_delete('2',ps_keys_bak[1],ps_keys_bak[2],'N') RETURNING l_success
      
      DELETE FROM xrcd_t
       WHERE xrcddocno = ps_keys_bak[1] AND xrcdseq = ps_keys_bak[2]
         AND xrcdent = g_enterprise    #160902-00048#2
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
         CALL g_xmdh_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xmdh4_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
           
      #end add-point    
      DELETE FROM xmdi_t
       WHERE xmdient = g_enterprise AND
             xmdidocno = ps_keys_bak[1] AND xmdiseq = ps_keys_bak[2] AND xmdiseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
           
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmdh2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
           
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
 
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmt520_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_success   LIKE type_t.num5
     
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET g_xmdh_d[g_detail_idx].xmdhsite = g_site
      
      #end add-point 
      INSERT INTO xmdh_t
                  (xmdhent,
                   xmdhdocno,
                   xmdhseq
                   ,xmdhsite,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,xmdh007,xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011,xmdh012,xmdh013,xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033,xmdh050,xmdh056,xmdh030,xmdh051,xmdh052,xmdhunit,xmdh035,xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,xmdh028) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmdh_d[g_detail_idx].xmdhsite,g_xmdh_d[g_detail_idx].xmdh001,g_xmdh_d[g_detail_idx].xmdh002, 
                       g_xmdh_d[g_detail_idx].xmdh003,g_xmdh_d[g_detail_idx].xmdh004,g_xmdh_d[g_detail_idx].xmdh005, 
                       g_xmdh_d[g_detail_idx].xmdh006,g_xmdh_d[g_detail_idx].xmdh007,g_xmdh_d[g_detail_idx].xmdh034, 
                       g_xmdh_d[g_detail_idx].xmdh009,g_xmdh_d[g_detail_idx].xmdh010,g_xmdh_d[g_detail_idx].xmdh015, 
                       g_xmdh_d[g_detail_idx].xmdh016,g_xmdh_d[g_detail_idx].xmdh017,g_xmdh_d[g_detail_idx].xmdh018, 
                       g_xmdh_d[g_detail_idx].xmdh019,g_xmdh_d[g_detail_idx].xmdh008,g_xmdh_d[g_detail_idx].xmdh011, 
                       g_xmdh_d[g_detail_idx].xmdh012,g_xmdh_d[g_detail_idx].xmdh013,g_xmdh_d[g_detail_idx].xmdh014, 
                       g_xmdh_d[g_detail_idx].xmdh029,g_xmdh_d[g_detail_idx].xmdh020,g_xmdh_d[g_detail_idx].xmdh021, 
                       g_xmdh_d[g_detail_idx].xmdh022,g_xmdh_d[g_detail_idx].xmdh036,g_xmdh_d[g_detail_idx].xmdh031, 
                       g_xmdh_d[g_detail_idx].xmdh032,g_xmdh_d[g_detail_idx].xmdh033,g_xmdh_d[g_detail_idx].xmdh050, 
                       g_xmdh_d[g_detail_idx].xmdh056,g_xmdh_d[g_detail_idx].xmdh030,g_xmdh_d[g_detail_idx].xmdh051, 
                       g_xmdh_d[g_detail_idx].xmdh052,g_xmdh_d[g_detail_idx].xmdhunit,g_xmdh_d[g_detail_idx].xmdh035, 
                       g_xmdh4_d[g_detail_idx].xmdh023,g_xmdh4_d[g_detail_idx].xmdh024,g_xmdh4_d[g_detail_idx].xmdh025, 
                       g_xmdh4_d[g_detail_idx].xmdh026,g_xmdh4_d[g_detail_idx].xmdh027,g_xmdh4_d[g_detail_idx].xmdh028) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
           
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xmdh_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xmdh4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
 
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      LET g_xmdh2_d[g_detail_idx].xmdisite = g_site
      
      #end add-point 
      INSERT INTO xmdi_t
                  (xmdient,
                   xmdidocno,
                   xmdiseq,xmdiseq1
                   ,xmdisite,xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,xmdi006,xmdi007,xmdi013,xmdi008,xmdi009,xmdi010,xmdi011,xmdi012) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xmdh2_d[g_detail_idx].xmdisite,g_xmdh2_d[g_detail_idx].xmdi001,g_xmdh2_d[g_detail_idx].xmdi002, 
                       g_xmdh2_d[g_detail_idx].xmdi003,g_xmdh2_d[g_detail_idx].xmdi004,g_xmdh2_d[g_detail_idx].xmdi005, 
                       g_xmdh2_d[g_detail_idx].xmdi006,g_xmdh2_d[g_detail_idx].xmdi007,g_xmdh2_d[g_detail_idx].xmdi013, 
                       g_xmdh2_d[g_detail_idx].xmdi008,g_xmdh2_d[g_detail_idx].xmdi009,g_xmdh2_d[g_detail_idx].xmdi010, 
                       g_xmdh2_d[g_detail_idx].xmdi011,g_xmdh2_d[g_detail_idx].xmdi012)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
           
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmdh2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
           
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
     
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmt520_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   DEFINE l_success        LIKE type_t.num5 
     
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
   LET ls_group = "'1','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      IF cl_null(g_xmdh_d[g_detail_idx].xmdhsite) THEN
         LET g_xmdh_d[g_detail_idx].xmdhsite = g_site
      END IF
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axmt520_xmdh_t_mask_restore('restore_mask_o')
               
      UPDATE xmdh_t 
         SET (xmdhdocno,
              xmdhseq
              ,xmdhsite,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,xmdh007,xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011,xmdh012,xmdh013,xmdh014,xmdh029,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033,xmdh050,xmdh056,xmdh030,xmdh051,xmdh052,xmdhunit,xmdh035,xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,xmdh028) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmdh_d[g_detail_idx].xmdhsite,g_xmdh_d[g_detail_idx].xmdh001,g_xmdh_d[g_detail_idx].xmdh002, 
                  g_xmdh_d[g_detail_idx].xmdh003,g_xmdh_d[g_detail_idx].xmdh004,g_xmdh_d[g_detail_idx].xmdh005, 
                  g_xmdh_d[g_detail_idx].xmdh006,g_xmdh_d[g_detail_idx].xmdh007,g_xmdh_d[g_detail_idx].xmdh034, 
                  g_xmdh_d[g_detail_idx].xmdh009,g_xmdh_d[g_detail_idx].xmdh010,g_xmdh_d[g_detail_idx].xmdh015, 
                  g_xmdh_d[g_detail_idx].xmdh016,g_xmdh_d[g_detail_idx].xmdh017,g_xmdh_d[g_detail_idx].xmdh018, 
                  g_xmdh_d[g_detail_idx].xmdh019,g_xmdh_d[g_detail_idx].xmdh008,g_xmdh_d[g_detail_idx].xmdh011, 
                  g_xmdh_d[g_detail_idx].xmdh012,g_xmdh_d[g_detail_idx].xmdh013,g_xmdh_d[g_detail_idx].xmdh014, 
                  g_xmdh_d[g_detail_idx].xmdh029,g_xmdh_d[g_detail_idx].xmdh020,g_xmdh_d[g_detail_idx].xmdh021, 
                  g_xmdh_d[g_detail_idx].xmdh022,g_xmdh_d[g_detail_idx].xmdh036,g_xmdh_d[g_detail_idx].xmdh031, 
                  g_xmdh_d[g_detail_idx].xmdh032,g_xmdh_d[g_detail_idx].xmdh033,g_xmdh_d[g_detail_idx].xmdh050, 
                  g_xmdh_d[g_detail_idx].xmdh056,g_xmdh_d[g_detail_idx].xmdh030,g_xmdh_d[g_detail_idx].xmdh051, 
                  g_xmdh_d[g_detail_idx].xmdh052,g_xmdh_d[g_detail_idx].xmdhunit,g_xmdh_d[g_detail_idx].xmdh035, 
                  g_xmdh4_d[g_detail_idx].xmdh023,g_xmdh4_d[g_detail_idx].xmdh024,g_xmdh4_d[g_detail_idx].xmdh025, 
                  g_xmdh4_d[g_detail_idx].xmdh026,g_xmdh4_d[g_detail_idx].xmdh027,g_xmdh4_d[g_detail_idx].xmdh028)  
 
         WHERE xmdhent = g_enterprise AND xmdhdocno = ps_keys_bak[1] AND xmdhseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
           
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt520_xmdh_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
 
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      IF cl_null(g_xmdh2_d[g_detail_idx].xmdisite) THEN
         LET g_xmdh2_d[g_detail_idx].xmdisite = g_site
      END IF
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt520_xmdi_t_mask_restore('restore_mask_o')
               
      UPDATE xmdi_t 
         SET (xmdidocno,
              xmdiseq,xmdiseq1
              ,xmdisite,xmdi001,xmdi002,xmdi003,xmdi004,xmdi005,xmdi006,xmdi007,xmdi013,xmdi008,xmdi009,xmdi010,xmdi011,xmdi012) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xmdh2_d[g_detail_idx].xmdisite,g_xmdh2_d[g_detail_idx].xmdi001,g_xmdh2_d[g_detail_idx].xmdi002, 
                  g_xmdh2_d[g_detail_idx].xmdi003,g_xmdh2_d[g_detail_idx].xmdi004,g_xmdh2_d[g_detail_idx].xmdi005, 
                  g_xmdh2_d[g_detail_idx].xmdi006,g_xmdh2_d[g_detail_idx].xmdi007,g_xmdh2_d[g_detail_idx].xmdi013, 
                  g_xmdh2_d[g_detail_idx].xmdi008,g_xmdh2_d[g_detail_idx].xmdi009,g_xmdh2_d[g_detail_idx].xmdi010, 
                  g_xmdh2_d[g_detail_idx].xmdi011,g_xmdh2_d[g_detail_idx].xmdi012) 
         WHERE xmdient = g_enterprise AND xmdidocno = ps_keys_bak[1] AND xmdiseq = ps_keys_bak[2] AND xmdiseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
           
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt520_xmdi_t_mask_restore('restore_mask_n')
 
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
 
{<section id="axmt520.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axmt520_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt520.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmt520_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt520.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmt520_lock_b(ps_table,ps_page)
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
   #CALL axmt520_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','3',"
   #僅鎖定自身table
   LET ls_group = "xmdh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axmt520_bcl USING g_enterprise,
                                       g_xmdg_m.xmdgdocno,g_xmdh_d[g_detail_idx].xmdhseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt520_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xmdi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt520_bcl2 USING g_enterprise,
                                             g_xmdg_m.xmdgdocno,g_xmdh2_d[g_detail_idx].xmdiseq,g_xmdh2_d[g_detail_idx].xmdiseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt520_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axmt520.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmt520_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
     
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt520_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt520_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
     
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmt520_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
     
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xmdgdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmdgdocno",TRUE)
      CALL cl_set_comp_entry("xmdgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xmdgdocdt,xmdg004",TRUE)
     
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #add xmdg034 by shiun----------------
   CALL cl_set_comp_entry("xmdg001,xmdg034,xmdg005,xmdg006,xmdg007,xmdg008,xmdg009",TRUE)
   CALL cl_set_comp_entry("xmdg010,xmdg013,xmdg014,xmdg016,xmdg017,xmdg018",TRUE)
   CALL cl_set_comp_entry("xmdg019,xmdg020,xmdg023,xmdg026,xmdg027,xmdg032,xmdg033",TRUE)
   CALL cl_set_comp_entry("xmdg001",TRUE)
#   CALL cl_set_comp_entry("xmdg056",TRUE)
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmt520_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_fields   STRING 
   DEFINE l_xmda049  LIKE  xmda_t.xmda049
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmdgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xmdgdocdt,xmdg004",FALSE)
      LET l_cnt = ''
      SELECT COUNT(*) INTO l_cnt
        FROM xmdh_t
       WHERE xmdhent = g_enterprise
         AND xmdhdocno = g_xmdg_m.xmdgdocno
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt <> 0 THEN
         CALL cl_set_comp_entry("xmdg001,xmdg005,xmdg006,xmdg007,xmdg008,xmdg009,xmdg010,xmdg013,xmdg014",FALSE)
      END IF
      #add xmdg034 by shiun----------------
      CALL cl_set_comp_entry("xmdg001,xmdg034,xmdg005,xmdg006,xmdg007,xmdg008,xmdg009",FALSE) 
      CALL cl_set_comp_entry("xmdg010,xmdg013,xmdg014,xmdg032",FALSE) 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xmdgdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xmdgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_null(g_xmdg_m.xmdg004) THEN
      #依單據別設定判斷欄位是否需要做輸入控制
      IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
         LET l_fields = ''
         CALL s_aooi200_get_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno) RETURNING l_fields
         CALL cl_set_comp_entry(l_fields,FALSE)
      END IF
   ELSE
      #將訂單對應的相關欄位預設到出通單上後不能維護
      #add xmdg034 by shiun----------------
      CALL cl_set_comp_entry("xmdg001,xmdg034,xmdg005,xmdg006,xmdg007,xmdg008,xmdg009",FALSE) 
      CALL cl_set_comp_entry("xmdg010,xmdg013,xmdg014,xmdg032",FALSE)
      #新增時若單頭來源有輸入訂單時，且來源訂單的設置的匯率基準是依訂單匯率時，則出通單的匯率預設訂單的匯率且不可以修改
      LET l_xmda049 = ''
      SELECT xmda049 INTO l_xmda049
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_xmdg_m.xmdg004
      IF l_xmda049 = '1' THEN
         CALL cl_set_comp_entry("xmdg015",FALSE)
      END IF
   END IF
   IF g_argv[01] = '8' THEN
      CALL cl_set_comp_entry("xmdg001",FALSE)
   END IF
   
#   #多角性質=2.銷售多角，多角流程代號必輸
#   IF g_xmdg_m.xmdg034 <> '2' THEN
#      CALL cl_set_comp_entry("xmdg056",FALSE)
#   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmt520_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("xmdh001,xmdh002,xmdh003,xmdh004,xmdh007",TRUE)
   CALL cl_set_comp_entry("xmdh011,xmdh012,xmdh013,xmdh014",TRUE)
   CALL cl_set_comp_entry("xmdh016,xmdh019,xmdh021,xmdh023",TRUE)

   CALL cl_set_comp_entry("xmdi009",TRUE)
   
   CALL cl_set_comp_entry("xmdh031,xmdh032,xmdh033",TRUE)  #add by lixiang 2015/06/18
   CALL cl_set_comp_entry("xmdh029,xmdi013",TRUE)                  #160519-00008#9
   CALL cl_set_comp_required("xmdh029,xmdi013",TRUE)               #160519-00008#9
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmt520_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005 LIKE imaa_t.imaa005
   DEFINE l_imaf015 LIKE imaf_t.imaf015
   DEFINE l_imaf061 LIKE imaf_t.imaf061
   DEFINE l_imaf113 LIKE imaf_t.imaf113
   DEFINE l_xmdc022 LIKE xmdc_t.xmdc022
   DEFINE l_xmdc028 LIKE xmdc_t.xmdc028
   DEFINE l_xmdc029 LIKE xmdc_t.xmdc029
   DEFINE l_xmdc030 LIKE xmdc_t.xmdc030
   DEFINE l_xmdd006 LIKE xmdd_t.xmdd006
   DEFINE l_inaa007 LIKE inaa_t.inaa007
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_imaf055 LIKE imaf_t.imaf055      #160519-00008#9
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
 
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"

   IF NOT cl_null(g_xmdg_m.xmdg004) THEN
      CALL cl_set_comp_entry("xmdh001",FALSE)
   END IF

   IF cl_null(g_xmdh_d[l_ac].xmdh002) THEN
      CALL cl_set_comp_entry("xmdh011,xmdh012,xmdh013,xmdh014,xmdh016,xmdh019,xmdh021",FALSE)
   END IF

   IF cl_null(g_xmdh_d[l_ac].xmdh006) THEN
      CALL cl_set_comp_entry("xmdh007",FALSE)
   ELSE
      IF g_flag = 'Y' THEN
         CALL cl_set_comp_entry("xmdh002,xmdh003,xmdh004",FALSE)
      END IF
      LET l_imaa005 = ''
      CALL s_axmt500_get_imaa005(g_enterprise,g_xmdh_d[l_ac].xmdh006) RETURNING l_imaa005
      #料件主檔無特徵類別，不能維護產品特徵
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("xmdh007",FALSE)
      ELSE
         #若料件有使用產品特徵時，則此欄位不允許空白
         CALL cl_set_comp_required("xmdh007",TRUE)
      END IF
      LET l_imaf015 = ''
      LET l_imaf061 = ''
      LET l_imaf113 = ''
      SELECT imaf015,imaf061,imaf113
        INTO l_imaf015,l_imaf061,l_imaf113
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_xmdh_d[l_ac].xmdh006
      #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
      IF l_imaf061 NOT MATCHES '[13]' THEN
         LET g_xmdh_d[l_ac].xmdh014 = ' '
         CALL cl_set_comp_entry("xmdh014",FALSE)
      END IF
      #[T:料件據點進銷存檔]未設參考單位，參考數量不允許輸入
      #mod--160325-00002#1 By shiun--(S)
#      IF cl_null(l_imaf015) THEN
      IF cl_null(g_xmdh_d[l_ac].xmdh018) THEN
         CALL cl_set_comp_entry("xmdh019",FALSE)
      END IF
      #[T:料件據點進銷存檔]未設計價單位，計價數量不允許輸入
#      IF cl_null(l_imaf113) THEN
      IF cl_null(g_xmdh_d[l_ac].xmdh020) THEN
         CALL cl_set_comp_entry("xmdh021",FALSE)
      END IF
      #mod--160325-00002#1 By shiun--(E)
   END IF
   
   IF NOT cl_null(g_xmdh_d[l_ac].xmdh001) AND
      NOT cl_null(g_xmdh_d[l_ac].xmdh002) AND
      NOT cl_null(g_xmdh_d[l_ac].xmdh003) AND
      NOT cl_null(g_xmdh_d[l_ac].xmdh004) THEN
      LET l_xmdc022 = ''
      LET l_xmdc028 = ''
      LET l_xmdc029 = ''
      LET l_xmdc030 = ''
      LET l_xmdd006 = ''
      SELECT xmdc022,xmdc028,xmdc029,xmdc030,xmdd006
        INTO l_xmdc022,l_xmdc028,l_xmdc029,l_xmdc030,l_xmdd006
        FROM xmdd_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmddent
                                          AND xmdcsite = xmddsite
                                          AND xmdcdocno = xmdddocno
                                          AND xmdcseq = xmddseq
       WHERE xmddent = g_enterprise
--         AND xmddsite = g_site
         AND xmdddocno = g_xmdh_d[l_ac].xmdh001
         AND xmddseq = g_xmdh_d[l_ac].xmdh002
         AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
         AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
      #不允許部分交貨，則不能修改數量
      IF l_xmdc022 = 'N' THEN
         LET g_xmdh_d[l_ac].xmdh016 = l_xmdd006
         CALL cl_set_comp_entry("xmdh016",FALSE)
      END IF
      #訂單是否已有限定庫儲批
      IF NOT cl_null(l_xmdc028) THEN
         CALL cl_set_comp_entry("xmdh011,xmdh012",FALSE)
         IF NOT cl_null(l_xmdc029) THEN
            CALL cl_set_comp_entry("xmdh013",FALSE)
            IF NOT cl_null(l_xmdc030) THEN
               CALL cl_set_comp_entry("xmdh014",FALSE)
            END IF
         END IF
      END IF
   END IF
   
   IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
      #若使用多倉儲批，不能限定庫儲批
      CALL cl_set_comp_entry("xmdh0012,xmdh0013,xmdh0014",FALSE)
   END IF

   IF NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN
      #若有限定庫位，不能再維護多倉儲批
      CALL cl_set_comp_entry("xmdh011",FALSE)
      LET l_inaa007 = ''
      SELECT inaa007 INTO l_inaa007
        FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_xmdh_d[l_ac].xmdh012
      #儲位控管若為5.不使用儲位控管，則不能維護儲位
      IF l_inaa007 = '5' THEN
         CALL cl_set_comp_entry("xmdh013",FALSE)
      END IF
   END IF

   #ACTION維護單價
   CALL cl_set_comp_entry("xmdh023",FALSE)
   
   #帶入來源單據的專案編號、WBS編號、活動編號，不可修改
   CALL cl_set_comp_entry("xmdh031,xmdh032,xmdh033",FALSE)  #add by lixiang 2015/06/18
   #160519-00008#9--(S)
   CALL s_axmt540_get_imaf(g_xmdh_d[l_ac].xmdh006) RETURNING l_imaf055,l_imaf061
   IF l_imaf055 <> '1' THEN
      CALL cl_set_comp_required("xmdh029",FALSE)
   END IF
   CASE l_imaf055
       WHEN '1'
          IF g_xmdh_d[l_ac].xmdh029 = ' ' THEN
             LET g_xmdh_d[l_ac].xmdh029 = ''
          END IF
       WHEN '2'  #不可有庫存管理特徵
          LET g_xmdh_d[l_ac].xmdh029 = ''
          CALL cl_set_comp_entry("xmdh029",FALSE)            
          CALL cl_set_comp_required("xmdh029",FALSE)
   END CASE
   #160519-00008#9--(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmt520_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #150721-00001#1  2016/01/08 By earl mod s
   CALL cl_set_act_visible("insert", TRUE)
   
   IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
      CALL cl_set_act_visible("upd_price,axmt520_01,s_lot_sel",TRUE)
   END IF
   #150721-00001#1  2016/01/08 By earl mod s
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmt520_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #150721-00001#1  2016/01/08 By earl add s
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   #150721-00001#1  2016/01/08 By earl add e
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_xmdg_m.xmdgstus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
      CALL cl_set_act_visible("upd_price,axmt520_01,s_lot_sel",FALSE)
   END IF
   
   #150721-00001#1  2016/01/08 By earl add s
   CALL s_control_chk_group('5','2',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN    #處理狀態為FALSE 或 不在控制組範圍內
      CALL cl_set_act_visible("insert", FALSE)
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
      CALL cl_set_act_visible("upd_price,axmt520_01,s_lot_sel",FALSE)
   END IF
   
   #150721-00001#1  2016/01/08 By earl add e

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmt520_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("s_lot_sel",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmt520_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE l_imaf071         LIKE imaf_t.imaf071
   DEFINE l_imaf081         LIKE imaf_t.imaf081
   #150721-00001#1  2016/01/08 By earl add s
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   #150721-00001#1  2016/01/08 By earl add e
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   IF l_ac > 0 THEN    
      #抓取料件據點進銷存相關資訊
      LET l_imaf071 = NULL
      LET l_imaf081 = NULL
      SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 
        FROM imaf_t 
       WHERE imafent = g_enterprise
         AND imafsite = g_site AND imaf001 = g_xmdh_d[l_ac].xmdh006
      IF (l_imaf071 ='2' AND l_imaf081 ='2') OR cl_get_para(g_enterprise,g_site,'S-BAS-0048') = 'N' THEN 
         CALL cl_set_act_visible("s_lot_sel",FALSE)
      END IF
   END IF
   
   #150721-00001#1  2016/01/08 By earl add s
   CALL s_control_chk_group('5','2',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN    #處理狀態為FALSE 或 不在控制組範圍內
      CALL cl_set_act_visible("s_lot_sel",FALSE)
   END IF
   #150721-00001#1  2016/01/08 By earl add e
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmt520_default_search()
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
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmdgdocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " xmdgdocno IN ('",g_argv[02],"') AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "xmdg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmdh_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmdi_t" 
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
   IF g_argv[01] = '8' THEN
      LET g_wc = g_wc , " AND xmdg001 = '", g_argv[01], "' "
   ELSE
      LET g_wc = g_wc , " AND xmdg001 <> '8' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axmt520_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_xmaj003_1 LIKE xmaj_t.xmaj003  #出通單確認時超限控管方式(據點)
   DEFINE l_xmaj003_2 LIKE xmaj_t.xmaj003  #出通單確認時超限控管方式(集團)
   #150629 earl add start
   DEFINE la_param   RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                     END RECORD

   DEFINE ls_js         STRING
   DEFINE l_xmdg054     LIKE xmdg_t.xmdg054
   #150629 earl add end
   DEFINE l_flag        LIKE type_t.chr1  #150924 by whitney add
   DEFINE l_pmak003     LIKE pmak_t.pmak003   #161207-00033#35 add  
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
     
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xmdg_m.xmdgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
   IF STATUS THEN
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt520_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
       g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
       g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
       g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
       g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
       g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
       g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
       g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
       g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
       g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT axmt520_action_chk() THEN
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
       g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdgstus, 
       g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc, 
       g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc,g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc, 
       g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc, 
       g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid, 
       g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc, 
       g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
 
   CASE g_xmdg_m.xmdgstus
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
      WHEN "H"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
      WHEN "UH"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   #161207-00033#35-s-add 
   IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
      CALL axmt520_get_pmak003('2',g_xmdg_m.xmdgdocno)
   END IF
   #161207-00033#35-e-add
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xmdg_m.xmdgstus
            
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
            WHEN "H"
               HIDE OPTION "hold"
            WHEN "UH"
               HIDE OPTION "unhold"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #提交和抽單一開始先無條件關
      #xujing---mark-start
#      CALL cl_set_act_visible("signing,withdraw",FALSE)
#      CALL cl_set_act_visible("confirmed,unconfirmed,invalid,unhold,hold",FALSE)
#      
#      CASE g_xmdg_m.xmdgstus
#         #未確認，需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#         WHEN "N"
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF  
#         #作廢
#         WHEN "X"
#            RETURN
#         #已確認
#         WHEN "Y"
#            CALL cl_set_act_visible("unconfirmed,hold",TRUE)
#         #已核准只能顯示確認;其餘應用功能皆隱藏
#         WHEN "A"     
#             CALL cl_set_act_visible("confirmed ",TRUE)  
#         #已拒絕，保留修改的功能(如作廢)，隱藏其他應用功能
#         #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#         WHEN "R"
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF
#         #抽單，需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#         WHEN "D"
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF
#         #送簽中只能顯示抽單;其餘應用功能皆隱藏
#         WHEN "W"
#            CALL cl_set_act_visible("withdraw",TRUE)
#         #留置
#         WHEN "H"
#            CALL cl_set_act_visible("unhold",TRUE)
#         END CASE    
 #xujing-mark-end
 #xujing---add-start
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unhold,hold",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_xmdg_m.xmdgstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold,unhold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,unhold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,unhold",FALSE) 
          
         WHEN "X"
            CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold,unhold",FALSE)
         WHEN "H"
            CALL cl_set_act_visible("hold,unconfirmed,invalid,confirmed",FALSE)
      END CASE

 #xujing---add---end
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axmt520_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt520_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axmt520_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt520_cl
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
 
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION hold
         IF cl_auth_chk_act("hold") THEN
            LET lc_state = "H"
            #add-point:action控制 name="statechange.hold"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unhold
         IF cl_auth_chk_act("unhold") THEN
            LET lc_state = "UH"
            #add-point:action控制 name="statechange.unhold"
            
            #end add-point
         END IF
         EXIT MENU
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
      AND lc_state <> "H"
      AND lc_state <> "UH"
      AND lc_state <> "X"
      ) OR 
      g_xmdg_m.xmdgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #CALL cl_err_collect_init()  #161027-00035#1 mark
   
   IF lc_state = 'H' THEN
      #CALL cl_err_collect_show()  #161027-00035#1 mark
      #CALL s_transaction_begin()  #161027-00035#1 mark
      IF NOT axmt520_action_modify('H') THEN
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #CALL s_transaction_end('Y','0')  #161027-00035#1 mark
   END IF
   
   CALL cl_err_collect_init()  #161027-00035#1 add
   
   IF lc_state = 'Y' THEN
      IF NOT s_axmt520_conf_chk(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      IF NOT cl_ask_confirm('aim-00108') THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      CALL s_axmt520_credit_chk(g_xmdg_m.xmdgdocno) RETURNING l_flag
      IF l_flag = '0' OR l_flag = '2' THEN
         LET lc_state = 'H'
      END IF
      #CALL s_transaction_begin()  #161027-00035#1 mark
      IF NOT s_axmt520_conf_upd(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF lc_state = 'H' THEN
         CALL cl_ask_confirm3("axm-00440","")
         LET g_xmdg_m.xmdgstus = 'H'
         CASE l_flag
            WHEN '0'  #超限
               LET g_xmdg_m.xmdg031 = cl_get_para(g_enterprise,g_site,'S-BAS-0047')
            WHEN '2'  #逾期
               LET g_xmdg_m.xmdg031 = cl_get_para(g_enterprise,g_site,'S-BAS-0051')
         END CASE
         UPDATE xmdg_t
            SET xmdg031 = g_xmdg_m.xmdg031,
                xmdgstus = g_xmdg_m.xmdgstus
          WHERE xmdgent = g_enterprise
            AND xmdgdocno = g_xmdg_m.xmdgdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "upd xmdg_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL cl_err_collect_show()
            CLOSE axmt520_cl  #161027-00035#1 add
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      CALL s_transaction_end('Y','0')
      #150629---earl---add---s
      #多角自動拋轉
      IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y' AND
         g_xmdg_m.xmdg034 MATCHES '[27]' AND 
         g_xmdg_m.xmdg056 IS NOT NULL THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog     = 'aicp300'
         LET la_param.param[1] = g_xmdg_m.xmdgdocno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)
         #161027-00035#1-s add
         LET l_xmdg054 = ''
         SELECT xmdg054 INTO l_xmdg054
           FROM xmdg_t
          WHERE xmdgent = g_enterprise
            AND xmdgdocno = g_xmdg_m.xmdg054
         #多角流程拋轉失敗！
         IF l_xmdg054 <> 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'aic-00177'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL s_transaction_begin()
            IF NOT s_axmt520_unconf_upd(g_xmdg_m.xmdgdocno) THEN
               CALL s_transaction_end('N','0')
            END IF
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()
            CLOSE axmt520_cl
            RETURN
         END IF
         #161027-00035#1-e add
      END IF
      #150629---earl---add---e
   END IF
   
   IF lc_state = 'X' THEN
      IF NOT s_axmt520_invalid_chk(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      #CALL s_transaction_begin()  #161027-00035#1 mark
      IF NOT s_axmt520_invalid_upd(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #CALL s_transaction_end('Y','0')  #161027-00035#1 mark
   END IF
   
   IF lc_state = 'N' THEN
      IF NOT s_axmt520_unconf_chk(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      IF NOT cl_ask_confirm('aim-00110') THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816
         RETURN
      END IF
      #150629---earl---add---s
      CALL s_transaction_end('Y','0')
      #多角自動拋轉還原
      IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y'  AND
         g_xmdg_m.xmdg034 MATCHES '[27]' AND 
         g_xmdg_m.xmdg056 IS NOT NULL THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog     = 'aicp310'
         LET la_param.param[1] = g_xmdg_m.xmdgdocno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)
      END IF
      LET l_xmdg054 = ''
      SELECT xmdg054 INTO l_xmdg054
        FROM xmdg_t
       WHERE xmdgent = g_enterprise
         AND xmdgdocno = g_xmdg_m.xmdg054
      IF l_xmdg054 = 'Y' THEN
         INITIALIZE g_errparam TO NULL
         #多角流程已拋轉之單據不可取消確認！
         LET g_errparam.code   = 'aic-00180'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CALL cl_err_collect_show()
         CLOSE axmt520_cl
         #CALL s_transaction_end('N','0')     #160812-00017#5 Add By Ken 160816  #161027-00035#1 mark
         RETURN
      END IF
      CALL s_transaction_begin()
      #161027-00035#1-s mark
      #OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
      #IF STATUS THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.extend = "OPEN axmt520_cl:"
      #   LET g_errparam.code   = STATUS
      #   LET g_errparam.popup  = TRUE
      #   CALL cl_err()
      #   CLOSE axmt520_cl
      #   CALL s_transaction_end('N','0')
      #   CALL cl_err_collect_show()
      #   RETURN
      #END IF
      #161027-00035#1-s mark
      #150623---earl---add---e
      #CALL s_transaction_begin()  #161027-00035#1 mark
      IF NOT s_axmt520_unconf_upd(g_xmdg_m.xmdgdocno) THEN
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #CALL s_transaction_end('Y','0')  #161027-00035#1 mark
   END IF
   
   IF lc_state = 'UH' THEN
      #161027-00035#1-s add
      #多角自動拋轉
      IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y' AND
         g_xmdg_m.xmdg034 MATCHES '[27]' AND 
         g_xmdg_m.xmdg056 IS NOT NULL THEN
         UPDATE xmdg_t
            SET xmdgstus  = 'Y'
          WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdg_m.xmdgdocno
         CALL s_transaction_end('Y','0')
         INITIALIZE la_param.* TO NULL
         LET la_param.prog     = 'aicp300'
         LET la_param.param[1] = g_xmdg_m.xmdgdocno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)
         LET l_xmdg054 = ''
         SELECT xmdg054 INTO l_xmdg054
           FROM xmdg_t
          WHERE xmdgent = g_enterprise
            AND xmdgdocno = g_xmdg_m.xmdg054
         #多角流程拋轉失敗！
         IF l_xmdg054 <> 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'aic-00177'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL s_transaction_begin()
            UPDATE xmdg_t
               SET xmdgstus  = 'H'
             WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdg_m.xmdgdocno
            CALL s_transaction_end('Y','0')
            CALL cl_err_collect_show()
            CLOSE axmt520_cl
            RETURN
         END IF
      END IF
      #161027-00035#1-e add
      CALL s_transaction_begin()
      LET lc_state = 'Y'
      LET g_xmdg_m.xmdgstus = lc_state
      LET g_xmdg_m.xmdg031 = ''
      LET g_xmdg_m.xmdg031_desc = ''
      LET g_xmdg_m.xmdgmodid = g_user
      LET g_xmdg_m.xmdgmoddt = cl_get_current()
      UPDATE xmdg_t
         SET xmdg031   = g_xmdg_m.xmdg031,
             xmdgstus  = g_xmdg_m.xmdgstus,
             xmdgmodid = g_xmdg_m.xmdgmodid,
             xmdgmoddt = g_xmdg_m.xmdgmoddt
       WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdg_m.xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd xmdg_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL cl_err_collect_show()
         CLOSE axmt520_cl  #161027-00035#1 add
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161027-00035#1 mark-s
      #CALL s_transaction_end('Y','0')
      ##150629---earl---add---s
      ##多角自動拋轉
      #IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y' AND
      #   g_xmdg_m.xmdg034 MATCHES '[27]' AND 
      #   g_xmdg_m.xmdg056 IS NOT NULL THEN
      #   INITIALIZE la_param.* TO NULL
      #   LET la_param.prog     = 'aicp300'
      #   LET la_param.param[1] = g_xmdg_m.xmdgdocno
      #   LET ls_js = util.JSON.stringify(la_param)
      #   CALL cl_cmdrun_wait(ls_js)
      #END IF
      ##150629---earl---add---e
      #161027-00035#1 mark-e
   END IF
   
   CALL cl_err_collect_show()

   #end add-point
   
   LET g_xmdg_m.xmdgmodid = g_user
   LET g_xmdg_m.xmdgmoddt = cl_get_current()
   LET g_xmdg_m.xmdgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xmdg_t 
      SET (xmdgstus,xmdgmodid,xmdgmoddt) 
        = (g_xmdg_m.xmdgstus,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt)     
    WHERE xmdgent = g_enterprise AND xmdgdocno = g_xmdg_m.xmdgdocno
 
    
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
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
          g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
          g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
          g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
          g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058, 
          g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021, 
          g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011, 
          g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015, 
          g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt, 
          g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc, 
          g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc, 
          g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg056_desc, 
          g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009_desc, 
          g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
          g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004, 
          g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc, 
          g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc, 
          g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202, 
          g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028,g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027, 
          g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc, 
          g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc, 
          g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057,g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc, 
          g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc, 
          g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021, 
          g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc,g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc, 
          g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010,g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011, 
          g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033, 
          g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid,g_xmdg_m.xmdgownid_desc, 
          g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc,g_xmdg_m.xmdgcrtdp, 
          g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgmoddt, 
          g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #161207-00033#35-s-add 
   IF NOT cl_null(g_xmdg_m.xmdgdocno) THEN
      CALL axmt520_get_pmak003('2',g_xmdg_m.xmdgdocno)
   END IF
   #161207-00033#35-e-add
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
 
   #end add-point  
 
   CLOSE axmt520_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt520_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt520.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmt520_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
     
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xmdh_d.getLength() THEN
         LET g_detail_idx = g_xmdh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdh_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xmdh2_d.getLength() THEN
         LET g_detail_idx = g_xmdh2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdh2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdh2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_xmdh4_d.getLength() THEN
         LET g_detail_idx = g_xmdh4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdh4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdh4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
     
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmt520_b_fill2(pi_idx)
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
   
   CALL axmt520_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmt520_fill_chk(ps_idx)
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
 
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt520.status_show" >}
PRIVATE FUNCTION axmt520_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt520.mask_functions" >}
&include "erp/axm/axmt520_mask.4gl"
 
{</section>}
 
{<section id="axmt520.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axmt520_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
 
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL axmt520_show()
   CALL axmt520_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_axmt520_conf_chk(g_xmdg_m.xmdgdocno) THEN
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xmdg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xmdh_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xmdh2_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_xmdh4_d))
 
 
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
   #CALL axmt520_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axmt520_ui_headershow()
   CALL axmt520_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axmt520_draw_out()
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
   CALL axmt520_ui_headershow()  
   CALL axmt520_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axmt520.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmt520_set_pk_array()
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
   LET g_pk_array[1].values = g_xmdg_m.xmdgdocno
   LET g_pk_array[1].column = 'xmdgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
 
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt520.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axmt520.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmt520_msgcentre_notify(lc_state)
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
   CALL axmt520_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmdg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt520.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmt520_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#43-s
   SELECT xmdgstus INTO g_xmdg_m.xmdgstus FROM xmdg_t
    WHERE xmdgent = g_enterprise
      AND xmdgdocno = g_xmdg_m.xmdgdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xmdg_m.xmdgstus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'H'
           LET g_errno = 'sub-01348'
        WHEN 'UH'
           LET g_errno = 'sub-01358'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_xmdg_m.xmdgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL axmt520_set_act_visible()
        CALL axmt520_set_act_no_visible()
        CALL axmt520_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#43-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt520.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 由訂單單號帶出單身明細
# Memo...........:
# Usage..........: CALL axmt520_gen_xmdh()
#                : RETURNING r_success
# Input parameter: no
# Return code....: r_success
# Date & Author..: 140326 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_gen_xmdh()
DEFINE r_success    LIKE type_t.num5
DEFINE l_xmdh  RECORD
    xmdhunit   LIKE xmdh_t.xmdhunit,
    xmdh002    LIKE xmdh_t.xmdh002,
    xmdh003    LIKE xmdh_t.xmdh003,
    xmdh004    LIKE xmdh_t.xmdh004,
    xmdh005    LIKE xmdh_t.xmdh005,
    xmdh006    LIKE xmdh_t.xmdh006,
    xmdh007    LIKE xmdh_t.xmdh007,
    xmdh008    LIKE xmdh_t.xmdh008,
    xmdh009    LIKE xmdh_t.xmdh009,
    xmdh010    LIKE xmdh_t.xmdh010,
    xmdh011    LIKE xmdh_t.xmdh011,
    xmdh012    LIKE xmdh_t.xmdh012,
    xmdh013    LIKE xmdh_t.xmdh013,
    xmdh014    LIKE xmdh_t.xmdh014,
    xmdh015    LIKE xmdh_t.xmdh015,
    xmdh016    LIKE xmdh_t.xmdh016,
    xmdh017    LIKE xmdh_t.xmdh017,
    xmdh018    LIKE xmdh_t.xmdh018,
    xmdh019    LIKE xmdh_t.xmdh019,
    xmdh020    LIKE xmdh_t.xmdh020,
    xmdh021    LIKE xmdh_t.xmdh021,
    xmdh022    LIKE xmdh_t.xmdh022,
    xmdh023    LIKE xmdh_t.xmdh023,
    xmdh024    LIKE xmdh_t.xmdh024,
    xmdh025    LIKE xmdh_t.xmdh025,
    xmdh026    LIKE xmdh_t.xmdh026,
    xmdh027    LIKE xmdh_t.xmdh027,
    xmdh028    LIKE xmdh_t.xmdh028,
    xmdh029    LIKE xmdh_t.xmdh029,
    xmdh030    LIKE xmdh_t.xmdh030,
    xmdh031    LIKE xmdh_t.xmdh031,
    xmdh032    LIKE xmdh_t.xmdh032,
    xmdh033    LIKE xmdh_t.xmdh033,
    xmdh034    LIKE xmdh_t.xmdh034,
    xmdh035    LIKE xmdh_t.xmdh035,
    xmdh036    LIKE xmdh_t.xmdh036,
    xmdh050    LIKE xmdh_t.xmdh050,
    xmdh051    LIKE xmdh_t.xmdh051,
    xmdh056    LIKE xmdh_t.xmdh056
           END RECORD
DEFINE l_seq        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_date       LIKE type_t.dat
DEFINE l_ask  RECORD
    all       LIKE type_t.chr1,
    assign    LIKE type_t.chr1,
    day       LIKE type_t.num5
          END RECORD
DEFINE l_ooba002    LIKE ooba_t.ooba002   #20150825-dorislai-add
DEFINE l_xmdd016    LIKE xmdd_t.xmdd016   #160219-00003#1 add
DEFINE l_xmdd031    LIKE xmdd_t.xmdd031   #160219-00003#1 add
DEFINE l_xmdc032    LIKE xmdc_t.xmdc032   #160219-00003#1 add
DEFINE l_pmdp023    LIKE pmdp_t.pmdp023   #160219-00003#1 add
DEFINE l_xmdr_cnt   LIKE type_t.num5      #160408-00035#4 add
DEFINE l_xmdr_qty   LIKE xmdr_t.xmdr008   #160408-00035#4 add
DEFINE l_qty        LIKE xmdr_t.xmdr008   #160408-00035#4 add
DEFINE l_diff_qty   LIKE xmdr_t.xmdr008   #160408-00035#4 add

   OPEN WINDOW w_axmt540_s02 WITH FORM cl_ap_formpath("axm",'axmt540_s02')
   
   INITIALIZE l_ask.* TO NULL
   LET l_ask.all = 'Y'
   LET l_ask.assign = 'N'
   LET l_ask.day = 0
   CALL cl_set_comp_entry("day",FALSE)

   INPUT BY NAME l_ask.all,l_ask.assign,l_ask.day WITHOUT DEFAULTS
      BEFORE INPUT
      
      ON CHANGE all
         IF l_ask.all = 'Y' THEN
            LET l_ask.assign = 'N'
            LET l_ask.day = 0
            CALL cl_set_comp_entry("day",FALSE)
         ELSE 
            LET l_ask.assign = 'Y'
            CALL cl_set_comp_entry("day",TRUE)
         END IF
         DISPLAY BY NAME l_ask.all,l_ask.assign,l_ask.day

      ON CHANGE assign
         IF l_ask.assign = 'Y' THEN
            LET l_ask.all = 'N'
            CALL cl_set_comp_entry("day",TRUE)
         ELSE
            LET l_ask.all = 'Y'
            LET l_ask.day = 0
            CALL cl_set_comp_entry("day",FALSE)
         END IF
         DISPLAY BY NAME l_ask.all,l_ask.assign,l_ask.day
                               
      ON ACTION accept
         ACCEPT INPUT
         
      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT INPUT

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT INPUT
      
      AFTER INPUT
   END INPUT
   
   CLOSE WINDOW w_axmt540_s02
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF   

#160408-00035#4 add str
#先將抓取訂單備置明細檔的CURSOR準備好
   LET g_sql = "SELECT xmdr004,xmdr005,xmdr006,xmdr010,(xmdr008-xmdr009) FROM xmdr_t",
               " WHERE xmdrent = ",g_enterprise,
               "   AND xmdrdocno = ? AND xmdrseq = ? AND xmdrseq1 = ? AND xmdrseq2 = ? "
   PREPARE axmt520_sel_xmdr_rep FROM g_sql
   DECLARE axmt520_sel_xmdr_cur CURSOR FOR axmt520_sel_xmdr_rep
#160408-00035#4 add end

   LET g_sql = " SELECT xmddunit,xmddseq,xmddseq1,xmddseq2,xmdd003,xmdd001,xmdd002,xmdc003,xmdc004,xmdc005, ",
               "        xmdc028,xmdc029,xmdc030,xmdd004,(xmdd006-xmdd031+xmdd016),xmdd024,xmdd026,xmdc052, ",
               "        xmdd018,xmdd019,xmdd020,xmdc057,xmdc036,xmdc037,xmdc038,xmdc027,xmdd008,xmdc021, ",
               "        xmdc050,xmda050",
              #160408-00035#4 add str  #查看有沒有硬備置的資料
               "      ,(SELECT COUNT(*) FROM xmdr_t ",
               "         WHERE xmdrent=xmddent AND xmdrsite=xmddsite AND xmdrdocno=xmdddocno",
               "           AND xmdrseq=xmddseq AND xmdrseq1=xmddseq1 AND xmdrseq2=xmddseq2",
               "           AND xmdr004 IS NOT NULL AND xmdr004 <> ' ') xmdr_cnt",
               "      ,(SELECT SUM(xmdr008-xmdr009) FROM xmdr_t ",
               "         WHERE xmdrent=xmddent AND xmdrsite=xmddsite AND xmdrdocno=xmdddocno",
               "           AND xmdrseq=xmddseq AND xmdrseq1=xmddseq1 AND xmdrseq2=xmddseq2",
               "           AND xmdr004 IS NOT NULL AND xmdr004 <> ' ') xmdr_qty",
              #160408-00035#4 add end
               "   FROM xmdd_t,xmdc_t,xmda_t ",
               "  WHERE xmddent = '",g_enterprise,"' AND xmdcunit = '",g_site,"' AND xmdddocno = '",g_xmdg_m.xmdg004,"'",
               "    AND xmdcent = xmddent AND xmdcsite = xmddsite AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq AND xmdc045 = '1' ",
               "    AND xmdaent = xmddent AND xmdasite = xmddsite AND xmdadocno = xmdddocno "
   IF l_ask.all = 'N' THEN
      CALL s_date_get_date(g_xmdg_m.xmdgdocdt,0,l_ask.day) RETURNING l_date
      LET g_sql = g_sql CLIPPED," AND xmdd011 <= '",l_date,"' "
   END IF      
   LET g_sql = g_sql, " ORDER BY xmddseq,xmddseq1,xmddseq2"
      
   PREPARE axmt520_gen_xmdh_pb FROM g_sql
   DECLARE axmt520_gen_xmdh_cs CURSOR FOR axmt520_gen_xmdh_pb
       
   INITIALIZE l_xmdh.* TO NULL
   LET l_xmdr_cnt = 0   #160408-00035#4 add
   LET l_xmdr_qty = 0   #160408-00035#4 add
   LET r_success = TRUE
   LET l_seq = 1
   
   FOREACH axmt520_gen_xmdh_cs INTO
      l_xmdh.xmdhunit,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh005,
      l_xmdh.xmdh006,l_xmdh.xmdh007,l_xmdh.xmdh008,l_xmdh.xmdh009,l_xmdh.xmdh010,
      l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,l_xmdh.xmdh016,
      l_xmdh.xmdh018,l_xmdh.xmdh020,l_xmdh.xmdh022,l_xmdh.xmdh023,l_xmdh.xmdh024,
      l_xmdh.xmdh025,l_xmdh.xmdh029,l_xmdh.xmdh031,l_xmdh.xmdh032,l_xmdh.xmdh033,
      l_xmdh.xmdh034,l_xmdh.xmdh035,l_xmdh.xmdh036,l_xmdh.xmdh050,l_xmdh.xmdh051
     ,l_xmdr_cnt,l_xmdr_qty   #160408-00035#4 add
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      #dorislai-20150824-add----(S)
      #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
      IF cl_null(l_xmdh.xmdh012) THEN
         #預設欄位
         CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_success,l_ooba002
         IF l_success THEN
            CALL s_aooi200_get_doc_default(g_site,'1',l_ooba002,'xmdh012',l_xmdh.xmdh012)
            RETURNING l_xmdh.xmdh012
            #應用參數
            IF cl_null(l_xmdh.xmdh012) THEN
               CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076')
               RETURNING l_xmdh.xmdh012
            END IF
         END IF
      END IF
      #dorislai-20150824-add----(E)
      #--160219-00003--add--(S)
      CALL s_axmt540_get_xmdc032(g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004)
        RETURNING l_xmdc032,l_pmdp023
      IF l_xmdc032 = '3' THEN
         SELECT xmdd016,xmdd031 INTO l_xmdd016,l_xmdd031
           FROM xmdd_t
          WHERE xmddent = g_enterprise AND xmdddocno = g_xmdg_m.xmdg004
            AND xmddseq = l_xmdh.xmdh002 AND xmddseq1 = l_xmdh.xmdh003 AND xmddseq2 = l_xmdh.xmdh004
         IF cl_null(l_xmdd016) THEN LET l_xmdd016 = 0 END IF
         IF cl_null(l_xmdd031) THEN LET l_xmdd031 = 0 END IF
         LET l_xmdh.xmdh016 = l_pmdp023 - l_xmdd031 + l_xmdd016
      END IF      
      #--160219-00003--add--(E)

#     LET l_xmdh.xmdh011 = 'N'   #多庫儲批  #160408-00035#4 mark      
#160408-00035#4 add str
#如果訂單有做硬備置，那麼出通單產生單身資料的時候，要自動帶出備置的庫儲批與數量
      #當有做硬備置(l_xmdr_cnt>0) 且 訂單數量<>硬備置數量時 , 差異數量應該再寫一筆進多倉儲批
      #例如:訂單數量100，硬備置A倉數量25、B倉數量25
      CASE 
         WHEN l_xmdr_cnt = 1   #備置1筆倉儲批 
            IF l_xmdr_cnt > 0 AND l_xmdh.xmdh016 <> l_xmdr_qty THEN
               LET l_xmdh.xmdh011 = 'Y'   #多庫儲批
               LET l_xmdh.xmdh012 = ''
               LET l_xmdh.xmdh013 = ''
               LET l_xmdh.xmdh014 = ''
            ELSE
               LET l_xmdh.xmdh011 = 'N'   #多庫儲批
               OPEN axmt520_sel_xmdr_cur USING g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004
               FETCH axmt520_sel_xmdr_cur INTO l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,l_xmdh.xmdh016
            END IF
         WHEN l_xmdr_cnt > 1   #備置多筆倉儲批
            LET l_xmdh.xmdh011 = 'Y'   #多庫儲批
            LET l_xmdh.xmdh012 = ''
            LET l_xmdh.xmdh013 = ''
            LET l_xmdh.xmdh014 = ''
         OTHERWISE             #沒有備置
            LET l_xmdh.xmdh011 = 'N'   #多庫儲批
      END CASE
#160408-00035#4 add end
      
      #已轉出貨數量
      LET l_xmdh.xmdh030 = 0
      #檢核不可大於(xmdd006-xmdd014-已登打出貨未確認的出貨量)
     #161205-00025#9 161215 by lori mod---(S) 
     #CALL axmt520_xmdd006_chk(g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh006,l_xmdh.xmdh016,0)   
      CALL axmt520_xmdd006_chk(g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,
                               l_xmdh.xmdh004,l_xmdh.xmdh006, l_xmdh.xmdh016,
                               0,l_xmdc032,l_pmdp023) 
     #161205-00025#9 161215 by lori mod---(E)
      IF NOT cl_null(g_errno) THEN
         CONTINUE FOREACH
      END IF

      CALL axmt520_xmdh016_count(l_seq,l_xmdh.xmdh006,l_xmdh.xmdh015,
                                 l_xmdh.xmdh016,l_xmdh.xmdh018,l_xmdh.xmdh020,
                                 l_xmdh.xmdh022,l_xmdh.xmdh023,l_xmdh.xmdh024,
                                 g_xmdg_m.xmdg004)  #150522---earl---add
           RETURNING l_xmdh.xmdh017,l_xmdh.xmdh019,l_xmdh.xmdh021,
                     l_xmdh.xmdh026,l_xmdh.xmdh027,
                     l_xmdh.xmdh028,l_xmdh.xmdh056

      INSERT INTO xmdh_t (xmdhent,xmdhsite,xmdhunit,xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,
                          xmdh006,xmdh007,xmdh008,xmdh009,xmdh010,xmdh011,xmdh012,xmdh013,xmdh014,xmdh015,
                          xmdh016,xmdh017,xmdh018,xmdh019,xmdh020,xmdh021,xmdh022,xmdh023,xmdh024,xmdh025,
                          xmdh026,xmdh027,xmdh028,xmdh029,xmdh030,xmdh031,xmdh032,xmdh033,xmdh034,xmdh035,
                          xmdh036,xmdh050,xmdh051,xmdh056)
           VALUES (g_enterprise,g_site,l_xmdh.xmdhunit,g_xmdg_m.xmdgdocno,l_seq,   
                   g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004,l_xmdh.xmdh005,
                   l_xmdh.xmdh006,l_xmdh.xmdh007,l_xmdh.xmdh008,l_xmdh.xmdh009,l_xmdh.xmdh010,
                   l_xmdh.xmdh011,l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,
                   l_xmdh.xmdh016,l_xmdh.xmdh017,l_xmdh.xmdh018,l_xmdh.xmdh019,l_xmdh.xmdh020,
                   l_xmdh.xmdh021,l_xmdh.xmdh022,l_xmdh.xmdh023,l_xmdh.xmdh024,l_xmdh.xmdh025,
                   l_xmdh.xmdh026,l_xmdh.xmdh027,l_xmdh.xmdh028,l_xmdh.xmdh029,l_xmdh.xmdh030,
                   l_xmdh.xmdh031,l_xmdh.xmdh032,l_xmdh.xmdh033,l_xmdh.xmdh034,l_xmdh.xmdh035,
                   l_xmdh.xmdh036,l_xmdh.xmdh050,l_xmdh.xmdh051,l_xmdh.xmdh056)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins xmdh" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

#160408-00035#4 mod str
#      IF NOT axmt540_01_xmdm_modify('2',l_seq,g_site,g_xmdg_m.xmdgdocno,l_seq,l_xmdh.xmdh006,
#                                    l_xmdh.xmdh007,l_xmdh.xmdh009,l_xmdh.xmdh010,l_xmdh.xmdh012,
#                                    l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh029,l_xmdh.xmdh015,
#                                    l_xmdh.xmdh016,l_xmdh.xmdh018,l_xmdh.xmdh019,'','') THEN
#         LET r_success = FALSE
#         EXIT FOREACH
#      END IF
#如果訂單有做硬備置，那麼出通單產生單身資料的時候，要自動帶出備置的庫儲批與數量
      IF l_xmdh.xmdh011 = 'Y' THEN
         #把硬備置的資料繞過一輪
         FOREACH axmt520_sel_xmdr_cur
           USING g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,l_xmdh.xmdh004
            INTO l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,l_qty
            CALL axmt520_xmdh016_count(l_seq,l_xmdh.xmdh006,l_xmdh.xmdh015,
                                       l_qty,l_xmdh.xmdh018,l_xmdh.xmdh020,
                                       l_xmdh.xmdh022,l_xmdh.xmdh023,l_xmdh.xmdh024,
                                       g_xmdg_m.xmdg004)
                 RETURNING l_xmdh.xmdh017,l_xmdh.xmdh019,l_xmdh.xmdh021,
                           l_xmdh.xmdh026,l_xmdh.xmdh027,
                           l_xmdh.xmdh028,l_xmdh.xmdh056
                        
            CALL axmt540_01_xmdm_insert('2',g_site,g_xmdg_m.xmdgdocno,l_seq,  
                                        l_xmdh.xmdh006,l_xmdh.xmdh007,l_xmdh.xmdh009,
                                        l_xmdh.xmdh010,l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,
                                        l_xmdh.xmdh029,l_xmdh.xmdh015,l_qty,
                                        l_xmdh.xmdh018,l_xmdh.xmdh019,'','') 
                 RETURNING r_success
            IF NOT r_success THEN
               EXIT FOREACH
            END IF
            #回寫訂單的已轉出通量
            IF NOT axmt520_upd_xmdd031(g_xmdg_m.xmdg004,'',l_xmdh.xmdh002,'',
                                       l_xmdh.xmdh003,'',l_xmdh.xmdh004,'',
                                       l_qty,0) THEN
               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END FOREACH
         #硬備置的都跑完了,比較一下訂單數量與備置數量若有差異,則把剩下的量再寫入一筆倉儲批為空的
         IF l_xmdh.xmdh016 <> l_xmdr_qty THEN
            LET l_diff_qty = l_xmdh.xmdh016 - l_xmdr_qty
            CALL axmt520_xmdh016_count(l_seq,l_xmdh.xmdh006,l_xmdh.xmdh015,
                                       l_diff_qty,l_xmdh.xmdh018,l_xmdh.xmdh020,
                                       l_xmdh.xmdh022,l_xmdh.xmdh023,l_xmdh.xmdh024,
                                       g_xmdg_m.xmdg004)
                 RETURNING l_xmdh.xmdh017,l_xmdh.xmdh019,l_xmdh.xmdh021,
                           l_xmdh.xmdh026,l_xmdh.xmdh027,
                           l_xmdh.xmdh028,l_xmdh.xmdh056
            CALL axmt540_01_xmdm_insert('2',g_site,g_xmdg_m.xmdgdocno,l_seq,  
                                        l_xmdh.xmdh006,l_xmdh.xmdh007,l_xmdh.xmdh009,
                                        l_xmdh.xmdh010,'','','',
                                        l_xmdh.xmdh029,l_xmdh.xmdh015,l_diff_qty,
                                        l_xmdh.xmdh018,l_xmdh.xmdh019,'','')
                 RETURNING r_success
            IF NOT r_success THEN
               EXIT FOREACH
            END IF
            #回寫訂單的已轉出通量
            IF NOT axmt520_upd_xmdd031(g_xmdg_m.xmdg004,'',l_xmdh.xmdh002,'',
                                       l_xmdh.xmdh003,'',l_xmdh.xmdh004,'',
                                       l_diff_qty,0) THEN
               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END IF
      ELSE    #備置1筆倉儲批或沒有備置
         IF NOT axmt540_01_xmdm_modify('2',l_seq,g_site,g_xmdg_m.xmdgdocno,l_seq,l_xmdh.xmdh006,
                                       l_xmdh.xmdh007,l_xmdh.xmdh009,l_xmdh.xmdh010,l_xmdh.xmdh012,
                                       l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh029,l_xmdh.xmdh015,
                                       l_xmdh.xmdh016,l_xmdh.xmdh018,l_xmdh.xmdh019,'','') THEN
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         #回寫訂單的已轉出通量
         IF NOT axmt520_upd_xmdd031(g_xmdg_m.xmdg004,'',l_xmdh.xmdh002,'',
                                    l_xmdh.xmdh003,'',l_xmdh.xmdh004,'',
                                    l_xmdh.xmdh016,0) THEN
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF  
#     #160324-00021#1 mod str
#     #IF NOT axmt520_upd_xmdd031(g_xmdg_m.xmdg004,l_xmdh.xmdh002,l_xmdh.xmdh003,
#     #                           l_xmdh.xmdh004,l_xmdh.xmdh016,0) THEN          
#      IF NOT axmt520_upd_xmdd031(g_xmdg_m.xmdg004,'',l_xmdh.xmdh002,'',
#                                 l_xmdh.xmdh003,'',l_xmdh.xmdh004,'',
#                                 l_xmdh.xmdh016,0) THEN
#     #160324-00021#1 mod end
#         LET r_success = FALSE
#         EXIT FOREACH
#      END IF
#160408-00035#4 mod end

      INITIALIZE l_xmdh.* TO NULL
      LET l_seq = l_seq + 1
      
   END FOREACH
   
   IF r_success THEN
      CALL axmt520_total_count()  
   END IF
   
   RETURN r_success
  
END FUNCTION

################################################################################
# Descriptions...: 刪除對應的多庫儲批資料
# Memo...........:
# Usage..........: CALL axmt520_xmdi_del()
# Input parameter: no
# Return code....: no
# Date & Author..: 140512 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdi_del()
DEFINE l_n          LIKE type_t.num5
DEFINE l_xmdr_cnt   LIKE type_t.num5  #160408-00035#4 add

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM xmdi_t
    WHERE xmdient = g_enterprise
      AND xmdidocno = g_xmdg_m.xmdgdocno
      AND xmdiseq = g_xmdh_d[l_ac].xmdhseq
   IF cl_null(l_n) THEN LET l_n = 0 END IF
   
  #160408-00035#4 add str  
  #因為有硬備置的這種資料，是會同步產生xmdi_t的，所以這種的不問要不要刪除xmdi_T
   SELECT COUNT(*) INTO l_xmdr_cnt FROM xmdr_t
    WHERE xmdrent = g_enterprise
      AND xmdrsite = g_site
      AND xmdrdocno = g_xmdh_d[l_ac].xmdh001
      AND xmdrseq = g_xmdh_d[l_ac].xmdh002
      AND xmdrseq1 = g_xmdh_d[l_ac].xmdh003
      AND xmdrseq2 = g_xmdh_d[l_ac].xmdh004
      AND xmdr004 IS NOT NULL AND xmdr004 <> ' '
   IF cl_null(l_xmdr_cnt) THEN LET l_xmdr_cnt = 0 END IF
  #160408-00035#4 add end 
  #IF l_n <> 0 THEN                      #160408-00035#4 mark
   IF l_n <> 0 AND l_xmdr_cnt = 0 THEN   #160408-00035#4 mod
      #是否取消多庫儲批出貨，且刪除對應的出通單多庫儲批出貨明細檔？
      IF cl_ask_confirm('axm-00194') THEN
         DELETE FROM xmdi_t
          WHERE xmdient = g_enterprise
            AND xmdidocno = g_xmdg_m.xmdgdocno
            AND xmdiseq = g_xmdh_d[l_ac].xmdhseq
         LET g_xmdh_d[l_ac].xmdh011 = 'N'
         #150821-xianghui-b
         DELETE FROM inao_t
          WHERE inaoent = g_enterprise
            AND inaodocno = g_xmdg_m.xmdgdocno
            AND inaoseq = g_xmdh_d[l_ac].xmdhseq
         #150821-xianghui-e          
      END IF
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 單別檢核
# Memo...........:
# Usage..........: CALL axmt520_xmdgdocno_chk()
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 140624 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdgdocno_chk()
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5

   #key值
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdg_t WHERE "||"xmdgent = '" ||g_enterprise|| "' AND "||"xmdgdocno = '"||g_xmdg_m.xmdgdocno ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   
   #檢查單別
   IF NOT s_aooi200_chk_slip(g_site,'',g_xmdg_m.xmdgdocno,g_prog) THEN
      RETURN FALSE
   END IF
            
   #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
   CALL s_control_chk_doc('1',g_xmdg_m.xmdgdocno,'2',g_user,g_dept,'','')
        RETURNING l_success,l_flag
   IF l_success THEN
      IF NOT l_flag THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00015'
         LET g_errparam.extend = g_xmdg_m.xmdgdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE
      RETURN FALSE
   END IF

   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 來源訂單檢核
# Memo...........:
# Usage..........: CALL axmt520_xmdadocno_chk(p_docno,p_type)
# Input parameter: p_docno   訂單單號
#                : p_type    1.單頭/2.單身
# Return code....: TRUE OR FALSE
# Date & Author..: 140307 By whitney
# Modify.........: 160120-00008 By whitney 增加檢核是否有可轉出通量
################################################################################
PRIVATE FUNCTION axmt520_xmdadocno_chk(p_docno,p_type)
DEFINE p_docno      LIKE xmda_t.xmdadocno
DEFINE p_type       LIKE type_t.chr1
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_slip       LIKE ooba_t.ooba002
DEFINE l_xmda  RECORD
    xmdastus   LIKE xmda_t.xmdastus,
    xmda004    LIKE xmda_t.xmda004,
    xmda005    LIKE xmda_t.xmda005,
    xmda006    LIKE xmda_t.xmda006,
    xmda009    LIKE xmda_t.xmda009,
    xmda010    LIKE xmda_t.xmda010,
    xmda011    LIKE xmda_t.xmda011,
    xmda015    LIKE xmda_t.xmda015,
    xmda021    LIKE xmda_t.xmda021,
    xmda022    LIKE xmda_t.xmda022,
    xmda035    LIKE xmda_t.xmda035,
    xmda045    LIKE xmda_t.xmda045,
    xmda048    LIKE xmda_t.xmda048,
    xmda050    LIKE xmda_t.xmda050,
    xmda203    LIKE xmda_t.xmda203
           END RECORD   
DEFINE l_n          LIKE type_t.num5
DEFINE l_oodb011    LIKE oodb_t.oodb011
DEFINE l_icaa011    LIKE icaa_t.icaa011
DEFINE l_icab003    LIKE icab_t.icab003
#151210-00009#1  2015/12/30 By earl s
DEFINE l_sql        STRING
DEFINE l_slip_doc   LIKE ooba_t.ooba002
#151210-00009#1  2015/12/30 By earl e

   LET r_success = TRUE
   CALL cl_err_collect_init()
   
   #單據別參數
   CALL s_aooi200_get_slip(p_docno) RETURNING l_success,l_slip
   IF l_success THEN
      IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0077') = 'N' THEN
         #單據別參數設定該筆訂單不須經過出通流程！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00349'
         LET g_errparam.extend = l_slip
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   #150909 earl add s
   #檢核前後置單別的合理性
   IF NOT s_aooi210_check_doc(g_site,'',p_docno,g_xmdg_m.xmdgdocno,'4','') THEN
      LET r_success = FALSE
   END IF
   #150909 earl add e
   
   LET l_n = 0
   IF p_type = '1' THEN #170119-00008#2  2017/01/20 By 08171 add 
      SELECT COUNT(*) INTO l_n
        FROM xmdd_t
       WHERE xmddent = g_enterprise
         AND xmdddocno = p_docno
   #170119-00008#2  2017/01/20 By 08171 add --s
   #單身的訂單單號，要符合axmt500訂單的條件
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM xmdd_t
        LEFT JOIN xmda_t ON xmddent = xmdaent AND xmdddocno = xmdadocno
       WHERE xmddent = g_enterprise
         AND xmdddocno = p_docno
         AND xmda004 = g_xmdg_m.xmdg005
         AND xmda005 = g_xmdg_m.xmdg001
         AND xmda006 = g_xmdg_m.xmdg034
         AND xmda009 = g_xmdg_m.xmdg008
         AND xmda010 = g_xmdg_m.xmdg009
         AND xmda011 = g_xmdg_m.xmdg010
         AND xmda015 = g_xmdg_m.xmdg014
         AND xmda021 = g_xmdg_m.xmdg006
         AND xmda022 = g_xmdg_m.xmdg007
         AND xmda035 = g_xmdg_m.xmdg013
   END IF
   #170119-00008#2  2017/01/20 By 08171 add --e
   IF cl_null(l_n) OR l_n = 0 THEN
      #輸入的資料在訂單單身明細檔中無對應的資料！
      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code   = 'axm-00158' #160318-00005#50  mark
      LET g_errparam.code   = 'sub-01323' #160318-00005#50  add
      LET g_errparam.extend = p_docno
      #160318-00005#50 --s add
      LET g_errparam.replace[1] = 'axmt500'
      LET g_errparam.replace[2] = cl_get_progname('axmt500',g_lang,"2")
      LET g_errparam.exeprog = 'axmt500'
      #160318-00005#50 --e add
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   LET l_n = 0
   SELECT COUNT(xmdcseq) INTO l_n
     FROM xmdc_t
    WHERE xmdcent = g_enterprise
      AND xmdcdocno = p_docno
      AND xmdc045 = '1'
   IF cl_null(l_n) OR l_n = 0 THEN
      #訂單單身狀態非[1.一般]，不可輸入!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'axm-00634'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   LET l_n = 0
   SELECT COUNT(xmdcseq) INTO l_n
     FROM xmdc_t
    WHERE xmdcent = g_enterprise
      AND xmdcdocno = p_docno
      AND xmdcunit = g_site
   IF cl_null(l_n) OR l_n = 0 THEN
      #此訂單的出貨據點與當前營運據點不一樣，不允許輸入此訂單！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00139'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM xmda_t,xmdd_t
    WHERE xmddent = g_enterprise
--      AND xmddsite = g_site
      AND xmdddocno = p_docno
     #AND (NVL(xmdd006,0)+NVL(xmdd016,0)-NVL(xmdd031,0)) > 0 #170119-00008#2  2017/02/03 By 08171 mark
      AND (NVL(xmdd006,0)+NVL(xmdd016,0)+NVL(xmdd034,0)-NVL(xmdd031,0)) > 0 #170119-00008#2  2017/02/03 By 08171 add
      AND xmdastus <> 'X'
      AND xmdadocno = xmdddocno
      AND xmdaent = xmddent
   IF cl_null(l_n) OR l_n = 0 THEN
      #170116-00044#1-s-add
      #若有費用性的資料，不需控卡
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM xmds_t,xmdh_t
       WHERE xmdhent = xmdsent AND xmdhsite = xmdssite 
         AND xmdh001 = xmdsdocno AND xmdh006 <> xmds001
        AND xmdhent = g_enterprise AND xmdhsite = g_site AND xmdh001 = p_docno
      IF l_n = 0 THEN
      #170116-00044#1-e-add
         #此訂單無可轉出通量(訂購數量 - 已轉出通數量 + 銷退換貨數量)！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00743'
         LET g_errparam.extend = p_docno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF  #170116-00044-add
   END IF
   
   INITIALIZE l_xmda.* TO NULL
   SELECT xmdastus,xmda004,xmda005,xmda006,xmda009,
          xmda010 ,xmda011,xmda015,xmda021,xmda022,
          xmda035 ,xmda045,xmda048,xmda050,xmda203
     INTO l_xmda.xmdastus,l_xmda.xmda004,l_xmda.xmda005,l_xmda.xmda006,l_xmda.xmda009,
          l_xmda.xmda010 ,l_xmda.xmda011,l_xmda.xmda015,l_xmda.xmda021,l_xmda.xmda022,
          l_xmda.xmda035 ,l_xmda.xmda045,l_xmda.xmda048,l_xmda.xmda050,l_xmda.xmda203
     FROM xmda_t
     WHERE xmdaent   = g_enterprise
--       AND xmdasite  = g_site
       AND xmdadocno = p_docno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      IF SQLCA.sqlcode = 100 THEN
         #輸入的資料不存在於 訂單單頭檔 中!
         LET g_errparam.code = 'axm-00041'
      ELSE
         LET g_errparam.code = SQLCA.sqlcode
      END IF
      LET g_errparam.extend = p_docno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF l_xmda.xmdastus <> 'Y' THEN
      #輸入的資料狀態非"已確認"!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'axm-00042'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF l_xmda.xmda005 = '5' THEN
      #此筆資料的單據性質為預先訂單，不可以出貨！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'axm-00237'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF l_xmda.xmda045 = 'Y' THEN
      #該訂單已物流結案，不可輸入！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'axm-00359'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF g_argv[01] = '8' THEN
      IF l_xmda.xmda005 <> '8' THEN
         #該訂單的訂單性質非[8:借貨訂單]
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00541'
         LET g_errparam.extend = p_docno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   ELSE
      IF l_xmda.xmda005 = '8' THEN
         #該訂單的訂單性質為[8:借貨訂單]！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00744'
         LET g_errparam.extend = p_docno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   IF p_type = '2' THEN  #單身
      IF l_xmda.xmda004 <> g_xmdg_m.xmdg005 THEN
         #該訂單的客戶代號與出通單單頭客戶代號不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00147'
         LET g_errparam.extend = l_xmda.xmda004
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda021 <> g_xmdg_m.xmdg006 THEN
         #該訂單的收款客戶與出通單單頭收款客戶不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00148'
         LET g_errparam.extend = l_xmda.xmda021
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda022 <> g_xmdg_m.xmdg007 THEN
         #該訂單的收貨客戶與出通單單頭收貨客戶不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00149'
         LET g_errparam.extend = l_xmda.xmda022
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda203 <> g_xmdg_m.xmdg202 THEN
         #該訂單的發票客戶與出通單單頭發票客戶不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00745'
         LET g_errparam.extend = l_xmda.xmda203
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda011 <> g_xmdg_m.xmdg010 THEN
         LET l_oodb011 = ''
         SELECT oodb011 INTO l_oodb011
           FROM oodb_t
          WHERE oodbent = g_enterprise
            AND oodb001 = g_ooef019
            AND oodb002 = g_xmdg_m.xmdg010
         IF l_oodb011 = '1' THEN
            #該訂單的稅別與出通單單頭稅別不一致！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'axm-00150'
            LET g_errparam.extend = l_xmda.xmda011
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END IF
      IF l_xmda.xmda015 <> g_xmdg_m.xmdg014 THEN
         #該訂單的幣別與出通單單頭幣別不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00151'
         LET g_errparam.extend = l_xmda.xmda015
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda010 <> g_xmdg_m.xmdg009 THEN
         #該訂單的交易條件與出通單單頭交易條件不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00152'
         LET g_errparam.extend = l_xmda.xmda010
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda009 <> g_xmdg_m.xmdg008 THEN
         #該訂單的收款條件與出通單單頭收款條件不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00153'
         LET g_errparam.extend = l_xmda.xmda009
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda035 <> g_xmdg_m.xmdg013 THEN
         #該訂單的發票類別與出通單發票類別條件不一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00154'
         LET g_errparam.extend = l_xmda.xmda035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda005 <> g_xmdg_m.xmdg001 THEN
         #該筆訂單的訂單性質與出通單單頭出通性質必須相同！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00155'
         LET g_errparam.extend = l_xmda.xmda005
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda006 <> g_xmdg_m.xmdg034 THEN
         #單身訂單對應的多角性質需與單頭多角性質一致！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00156'
         LET g_errparam.extend = l_xmda.xmda006
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF l_xmda.xmda048 <> g_xmdg_m.xmdg032 THEN
         #單據內外銷與單頭資料不符！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00356'
         LET g_errparam.extend = l_xmda.xmda048
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM xmdh_t 
       WHERE xmdhent = g_enterprise 
         AND xmdhsite = g_site
         AND xmdhdocno = g_xmdg_m.xmdgdocno
         AND COALESCE(xmdh051,' ') <> COALESCE(l_xmda.xmda050,' ')
      IF cl_null(l_n) THEN LET l_n = 0 END IF
      IF l_n > 0 THEN
         #單身多角流程代碼需一至！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00272'
         LET g_errparam.extend = l_xmda.xmda050
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   #訂單多角性質=1.一般交易
   IF l_xmda.xmda006 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n 
        FROM xmdc_t 
       WHERE xmdcent = g_enterprise 
#         AND xmdcsite = g_site
         AND xmdcdocno = p_docno
         AND xmdcunit = g_site
      IF l_n = 0 OR cl_null(l_n) THEN
         #訂單無任何一筆項次的出貨據點與當前營運據點一樣，不允許輸入此訂單！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00097'
         LET g_errparam.extend = g_site
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   END IF 

   IF NOT cl_null(l_xmda.xmda050) THEN
      LET l_icaa011 = ''
      LET l_icab003 = ''
      SELECT icaa011 INTO l_icaa011
        FROM icaa_t
       WHERE icaaent = g_enterprise
         AND icaa001 = l_xmda.xmda050
      #aici100之出貨通知單開立點
      CASE l_icaa011
         WHEN '0'  #來源站(正拋)
            SELECT icab003 INTO l_icab003
              FROM icab_t
             WHERE icabent = g_enterprise
               AND icab001 = l_xmda.xmda050
               AND icab002 = '1'
         WHEN '2'  #終點站(逆拋)
            SELECT icab003 INTO l_icab003
              FROM icab_t
             WHERE icabent = g_enterprise
               AND icab001 = l_xmda.xmda050
               AND icab002 = ( SELECT MAX(icab002)
                                 FROM icab_t
                                WHERE icabent = g_enterprise
                                  AND icab001 = l_xmda.xmda050 )
         OTHERWISE LET l_icab003 = g_site
      END CASE
      IF l_icab003 <> g_site THEN
         #當下的營運據點與多角貿易流程設定的營運據點不符！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'axm-00275'
         LET g_errparam.extend = l_icab003
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF

#151210-00009#1  2015/12/30 By earl s
   IF g_aic_doc THEN
      LET l_slip_doc = ''
      CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_success,l_slip_doc
      
      LET l_sql = "SELECT COUNT(*)",
                  "  FROM icab_t,icac_t",
                  " WHERE icabent = icacent AND icacent = ",g_enterprise,
                  "   AND icab001 = icac001",
                  "   AND icab002 = icac002",
                  "   AND icab003 = '",g_site,"'",
                  "   AND icac004 = '",l_slip_doc,"'"
      PREPARE axmt520_xmdadocno_pre1 FROM l_sql
      
      LET l_sql = l_sql," AND icac003 = '",l_slip,"'"
      PREPARE axmt520_xmdadocno_pre2 FROM l_sql
      
      LET l_n = 0
      EXECUTE axmt520_xmdadocno_pre1 INTO l_n
      IF l_n > 0 THEN
         LET l_n = 0
         EXECUTE axmt520_xmdadocno_pre2 INTO l_n
      
         IF l_n = 0 THEN
            #多角貿易設定為"多角單據流水號保持一致"時前後單別需存在對應關係！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "aic-00211"
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
      END IF
   END IF
#151210-00009#1  2015/12/30 By earl e
   
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單頭從訂單單號帶出預設值
# Memo...........:
# Usage..........: CALL axmt520_xmdg004_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140624 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdg004_default()
   DEFINE l_xmda031     LIKE xmda_t.xmda031   #150703 earl add
   DEFINE l_xmdg034     LIKE xmdg_t.xmdg034   #150703 earl add
   DEFINE l_pmak003     LIKE pmak_t.pmak003   #161207-00033#35 add  
   LET l_xmda031 = '' #150703 earl add
   SELECT xmda031,    #150703 earl add
          xmda005,xmda002,xmda003,xmda004,xmda021,xmda022,xmda009,xmda010,xmda011,xmda012,
          xmda013,xmda035,xmda015,xmda016,xmda036,xmda025,xmda020,xmda037,xmda038,xmda044,
          xmda023,xmda024,xmda032,xmda048,xmda049,xmda006,xmda050,xmda203
     INTO l_xmda031,  #150703 earl add
          g_xmdg_m.xmdg001,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,
          g_xmdg_m.xmdg007,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,
          g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015,g_xmdg_m.xmdg016,
          g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg023,
          g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg031,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,
          g_xmdg_m.xmdg034,g_xmdg_m.xmdg056,g_xmdg_m.xmdg202
     FROM xmda_t
    WHERE xmdaent = g_enterprise
      AND xmdadocno = g_xmdg_m.xmdg004

   #150703 earl mod s
   #多角處理
   IF NOT cl_null(g_xmdg_m.xmdg056) THEN
      #改抓發起站之多角性質
      LET l_xmdg034 = ''
      SELECT xmda006 INTO l_xmdg034
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmda031 = l_xmda031
         AND xmdasite = (SELECT icab003
                           FROM icab_t
                          WHERE icabent = g_enterprise
                            AND icab001 = g_xmdg_m.xmdg056
                            AND icab002 = 0)
                            
      IF cl_null(l_xmdg034) THEN
         LET l_xmdg034 = '7'   #7:代採購出貨
      END IF
      
      LET g_xmdg_m.xmdg034 = l_xmdg034
   END IF
   #150703 earl mod e
   
   IF NOT cl_null(g_xmdg_m.xmdg002) THEN
      CALL s_desc_get_person_desc(g_xmdg_m.xmdg002)
           RETURNING g_xmdg_m.xmdg002_desc
      DISPLAY BY NAME g_xmdg_m.xmdg002_desc
   END IF

   IF NOT cl_null(g_xmdg_m.xmdg002) AND cl_null(g_xmdg_m.xmdg003) THEN
      SELECT ooag003 INTO g_xmdg_m.xmdg003
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_xmdg_m.xmdg002
   END IF
   IF NOT cl_null(g_xmdg_m.xmdg003) THEN
      CALL s_desc_get_department_desc(g_xmdg_m.xmdg003)
           RETURNING g_xmdg_m.xmdg003_desc
      DISPLAY BY NAME g_xmdg_m.xmdg003_desc
   END IF
   
   IF NOT cl_null(g_xmdg_m.xmdg005) THEN
      IF cl_null(g_xmdg_m.xmdg006) THEN
         CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'1')
              RETURNING g_xmdg_m.xmdg006
      END IF
      IF cl_null(g_xmdg_m.xmdg007) THEN
         CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'2')
              RETURNING g_xmdg_m.xmdg007
      END IF
   END IF

   IF NOT cl_null(g_xmdg_m.xmdg032) AND NOT cl_null(g_xmdg_m.xmdg014) AND g_xmdg_m.xmdg033 <> '1' THEN
      #add--2015/11/19 By shiun--(S)
      CALL axmt520_xmda_xmdg015() RETURNING g_xmdg_m.xmdg015
      IF cl_null(g_xmdg_m.xmdg015) THEN                     
         CALL s_axmt540_get_exchange(g_xmdg_m.xmdg032,g_xmdg_m.xmdg014,g_xmdg_m.xmdgdocdt) RETURNING g_xmdg_m.xmdg015   #modify--2015/11/18 By shiun     新增傳入參數
      END IF
      #add--2015/11/19 By shiun--(E)
   END IF
   
   DISPLAY BY NAME g_xmdg_m.xmdg001,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,
                   g_xmdg_m.xmdg007,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,
                   g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015,g_xmdg_m.xmdg016,
                   g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,g_xmdg_m.xmdg023,
                   g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg031,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,
                   g_xmdg_m.xmdg034,g_xmdg_m.xmdg056,g_xmdg_m.xmdg202
   
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005)
        RETURNING g_xmdg_m.xmdg005_desc
   DISPLAY BY NAME g_xmdg_m.xmdg005_desc

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006)
        RETURNING g_xmdg_m.xmdg006_desc
   DISPLAY BY NAME g_xmdg_m.xmdg006_desc

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007)
        RETURNING g_xmdg_m.xmdg007_desc
   DISPLAY BY NAME g_xmdg_m.xmdg007_desc

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg202)
        RETURNING g_xmdg_m.xmdg202_desc
   DISPLAY BY NAME g_xmdg_m.xmdg202_desc

   #160621-00003#3 20160629 modify by beckxie---S
   #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
   CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
   #160621-00003#3 20160629 modify by beckxie---E
   DISPLAY BY NAME g_xmdg_m.xmdg026_desc

   CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027)
        RETURNING g_xmdg_m.xmdg027_desc
   DISPLAY BY NAME g_xmdg_m.xmdg027_desc

   CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031)
        RETURNING g_xmdg_m.xmdg031_desc
   DISPLAY BY NAME g_xmdg_m.xmdg031_desc

   CALL axmt520_xmdg017_ref()
   CALL axmt520_xmdg023_ref()

   IF NOT cl_null(g_xmdg_m.xmdg018) THEN
      CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018)
           RETURNING g_xmdg_m.xmdg018_desc
      DISPLAY BY NAME g_xmdg_m.xmdg018_desc
      CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019)
           RETURNING g_xmdg_m.xmdg019_desc
      DISPLAY BY NAME g_xmdg_m.xmdg019_desc
      CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020)
           RETURNING g_xmdg_m.xmdg020_desc
      DISPLAY BY NAME g_xmdg_m.xmdg020_desc
   END IF

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016)
        RETURNING g_xmdg_m.xmdg016_desc
   DISPLAY BY NAME g_xmdg_m.xmdg016_desc

   CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008)
        RETURNING g_xmdg_m.xmdg008_desc
   DISPLAY BY NAME g_xmdg_m.xmdg008_desc

   CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009)
        RETURNING g_xmdg_m.xmdg009_desc
   DISPLAY BY NAME g_xmdg_m.xmdg009_desc

   CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010)
        RETURNING g_xmdg_m.xmdg010_desc
   DISPLAY BY NAME g_xmdg_m.xmdg010_desc

   CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013)
        RETURNING g_xmdg_m.xmdg013_desc
   DISPLAY BY NAME g_xmdg_m.xmdg013_desc

   CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014)
        RETURNING g_xmdg_m.xmdg014_desc
   DISPLAY BY NAME g_xmdg_m.xmdg014_desc

   CALL s_desc_get_icaa001_desc(g_xmdg_m.xmdg056)
        RETURNING g_xmdg_m.xmdg056_desc
   DISPLAY BY NAME g_xmdg_m.xmdg056_desc
   
   CALL axmt520_get_pmak003('1',g_xmdg_m.xmdg004) #161207-00033#35-add
               
   LET g_xmdg_m_o.* = g_xmdg_m.*
   
END FUNCTION

################################################################################
# Descriptions...: 依客戶編號預設交易條件
# Memo...........:
# Usage..........: CALL axmt520_xmdg005_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140311 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdg005_default()
DEFINE l_success    LIKE type_t.num5
DEFINE l_oodb011    LIKE oodb_t.oodb011
DEFINE l_xmdk  RECORD
    xmdk003    LIKE xmdk_t.xmdk003,
    xmdk004    LIKE xmdk_t.xmdk004,
    xmdk010    LIKE xmdk_t.xmdk010,
    xmdk011    LIKE xmdk_t.xmdk011,
    xmdk012    LIKE xmdk_t.xmdk012,
    xmdk015    LIKE xmdk_t.xmdk015,
    xmdk016    LIKE xmdk_t.xmdk016,
    xmdk018    LIKE xmdk_t.xmdk018,
    xmdk022    LIKE xmdk_t.xmdk022,
    xmdk023    LIKE xmdk_t.xmdk023,
    xmdk024    LIKE xmdk_t.xmdk024,
    xmdk030    LIKE xmdk_t.xmdk030,
    xmdk031    LIKE xmdk_t.xmdk031,
    xmdk042    LIKE xmdk_t.xmdk042,
    xmdk043    LIKE xmdk_t.xmdk043
           END RECORD

   CALL s_axmt540_client_default(g_xmdg_m.xmdg005,g_user,g_dept)
        RETURNING l_xmdk.xmdk003,l_xmdk.xmdk004,
                  l_xmdk.xmdk010,l_xmdk.xmdk011,l_xmdk.xmdk012,l_xmdk.xmdk015,l_xmdk.xmdk016,
                  l_xmdk.xmdk018,l_xmdk.xmdk022,l_xmdk.xmdk023,l_xmdk.xmdk024,l_xmdk.xmdk030,
                  l_xmdk.xmdk031,l_xmdk.xmdk042,l_xmdk.xmdk043

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg002') THEN
      LET g_xmdg_m.xmdg002 = l_xmdk.xmdk003
      CALL s_desc_get_person_desc(g_xmdg_m.xmdg002)
           RETURNING g_xmdg_m.xmdg002_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg003') THEN
      LET g_xmdg_m.xmdg003 = l_xmdk.xmdk004
      IF NOT cl_null(g_xmdg_m.xmdg002) AND cl_null(g_xmdg_m.xmdg003) THEN
         SELECT ooag003 INTO g_xmdg_m.xmdg003
           FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_xmdg_m.xmdg002
      END IF
      CALL s_desc_get_department_desc(g_xmdg_m.xmdg003)
           RETURNING g_xmdg_m.xmdg003_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg008') THEN
      LET g_xmdg_m.xmdg008 = l_xmdk.xmdk010
      CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008)
           RETURNING g_xmdg_m.xmdg008_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg009') THEN
      LET g_xmdg_m.xmdg009 = l_xmdk.xmdk011
      CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009)
           RETURNING g_xmdg_m.xmdg009_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg010') THEN
      LET g_xmdg_m.xmdg010 = l_xmdk.xmdk012
      IF NOT cl_null(g_xmdg_m.xmdg010) THEN
         CALL s_tax_chk(g_site,g_xmdg_m.xmdg010)
              RETURNING l_success,g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg012,g_xmdg_m.xmdg011,l_oodb011
         IF NOT l_success THEN
            LET g_xmdg_m.xmdg010 = g_xmdg_m_o.xmdg010
            LET g_xmdg_m.xmdg011 = g_xmdg_m_o.xmdg011
            LET g_xmdg_m.xmdg012 = g_xmdg_m_o.xmdg012
         END IF
      END IF
      CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010)
           RETURNING g_xmdg_m.xmdg010_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg013') THEN
      LET g_xmdg_m.xmdg013 = l_xmdk.xmdk015
      CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013)
           RETURNING g_xmdg_m.xmdg013_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg014') THEN
      LET g_xmdg_m.xmdg014 = l_xmdk.xmdk016
      CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014)
           RETURNING g_xmdg_m.xmdg014_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg018') THEN
      LET g_xmdg_m.xmdg018 = l_xmdk.xmdk022
      CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018)
           RETURNING g_xmdg_m.xmdg018_desc
   END IF
   IF NOT cl_null(g_xmdg_m.xmdg018) THEN
      IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg019') THEN
         LET g_xmdg_m.xmdg019 = l_xmdk.xmdk023
         CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019)
              RETURNING g_xmdg_m.xmdg019_desc
      END IF
      IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg020') THEN
         LET g_xmdg_m.xmdg020 = l_xmdk.xmdk024
         CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020)
              RETURNING g_xmdg_m.xmdg020_desc
      END IF
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg026') THEN
      LET g_xmdg_m.xmdg026 = l_xmdk.xmdk030
      #160621-00003#3 20160629 modify by beckxie---S
      #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
      CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
      #160621-00003#3 20160629 modify by beckxie---E
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg027') THEN
      LET g_xmdg_m.xmdg027 = l_xmdk.xmdk031
      CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027)
           RETURNING g_xmdg_m.xmdg027_desc
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg032') THEN
      LET g_xmdg_m.xmdg032 = l_xmdk.xmdk042
   END IF

   IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg033') THEN
      LET g_xmdg_m.xmdg033 = l_xmdk.xmdk043
   END IF
   
   IF NOT cl_null(g_xmdg_m.xmdg032) AND NOT cl_null(g_xmdg_m.xmdg014) THEN
      #add--2015/11/19 By shiun--(S)
      CALL axmt520_xmda_xmdg015() RETURNING g_xmdg_m.xmdg015
      IF cl_null(g_xmdg_m.xmdg015) THEN                     
         CALL s_axmt540_get_exchange(g_xmdg_m.xmdg032,g_xmdg_m.xmdg014,g_xmdg_m.xmdgdocdt) RETURNING g_xmdg_m.xmdg015   #modify--2015/11/18 By shiun     新增傳入參數
      END IF
      #add--2015/11/19 By shiun--(E)
   END IF
                   
   #收款客戶
   CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'1')
        RETURNING g_xmdg_m.xmdg006
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006)
        RETURNING g_xmdg_m.xmdg006_desc

   #收貨客戶
   CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'2')
        RETURNING g_xmdg_m.xmdg007
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007)
        RETURNING g_xmdg_m.xmdg007_desc

   #依據客戶抓取夥伴關係檔設置的發票對象(若有多筆時選取主要)預設給發票對象欄位(xmdg202)，若沒有設置則預設客戶編號
   IF cl_null(g_xmdg_m.xmdg202) THEN
      SELECT pmac002 INTO g_xmdg_m.xmdg202
        FROM pmac_t
       WHERE pmacent = g_enterprise
         AND pmac001 = g_xmdg_m.xmdg005
         AND pmac003 = '3'
         AND pmac004 = 'Y'
         AND pmacstus = 'Y'
   END IF
   IF cl_null(g_xmdg_m.xmdg202) THEN
      DECLARE pmac_cur CURSOR FOR
         SELECT pmac002 FROM pmac_t
          WHERE pmacent = g_enterprise
            AND pmac001 = g_xmdg_m.xmdg005
            AND pmac003 = '3'
            AND pmacstus = 'Y'
      FOREACH pmac_cur INTO g_xmdg_m.xmdg202
         IF NOT cl_null(g_xmdg_m.xmdg202) THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   IF cl_null(g_xmdg_m.xmdg202) THEN
      LET g_xmdg_m.xmdg202 = g_xmdg_m.xmdg005
   END IF
   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg202) RETURNING g_xmdg_m.xmdg202_desc

   DISPLAY BY NAME g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg008,
                   g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,
                   g_xmdg_m.xmdg014,g_xmdg_m.xmdg015,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,
                   g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,
                   g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg008_desc,
                   g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg013_desc,
                   g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg019_desc,
                   g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,
                   g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc

   LET g_xmdg_m_o.* = g_xmdg_m.*

END FUNCTION

################################################################################
# Descriptions...: 帶出送貨地址
# Memo...........:
# Usage..........: CALL axmt520_xmdg017_ref()
# Input parameter: no
# Return code....: no
# Date & Author..: 140310 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdg017_ref()
DEFINE l_success    LIKE type_t.num5
DEFINE l_address    STRING
DEFINE l_pmaa027    LIKE pmaa_t.pmaa027

   LET g_xmdg_m.xmdg017_desc = ''
   LET g_xmdg_m.textedit1 = ''

   IF cl_null(g_xmdg_m.xmdg017) THEN
      RETURN
   END IF

   IF NOT cl_null(g_xmdg_m.xmdg007) THEN
      CALL s_axmt500_get_pmaa027(g_xmdg_m.xmdg007)
           RETURNING l_pmaa027
      IF NOT cl_null(l_pmaa027) THEN
         SELECT oofb011 INTO g_xmdg_m.xmdg017_desc
           FROM oofb_t
          WHERE oofbent = g_enterprise 
            AND oofb002 = l_pmaa027
            AND oofbstus = 'Y'
            AND oofb019 = g_xmdg_m.xmdg017
         #呼叫地址組合應用元件，將組合好的聯絡地址顯示在下方
         CALL s_aooi350_get_address(l_pmaa027,g_xmdg_m.xmdg017,g_dlang)
              RETURNING l_success,l_address
         IF l_success THEN
            LET g_xmdg_m.textedit1 = l_address
         END IF
      END IF
   END IF
   DISPLAY BY NAME g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1
   
END FUNCTION

################################################################################
# Descriptions...: 若輸入的訂單號+訂單項次的xmdd_t只有對應一個分批序時，則自動將分批序預設到出通單身[C:分批序]上
# Memo...........:
# Usage..........: CALL axmt520_xmdh001_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140312 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh001_default()
DEFINE l_n          LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM xmdd_t
    WHERE xmddent = g_enterprise
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
   IF l_n = 1 THEN
      SELECT xmddseq,xmddseq1,xmddseq2
        INTO g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004
        FROM xmdd_t
       WHERE xmddent = g_enterprise
         AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      CALL axmt520_xmdh004_chk()
      IF NOT cl_null(g_errno) THEN
         LET g_xmdh_d[l_ac].xmdh002 = g_xmdh_d_o.xmdh002
         LET g_xmdh_d[l_ac].xmdh003 = g_xmdh_d_o.xmdh003
         LET g_xmdh_d[l_ac].xmdh004 = g_xmdh_d_o.xmdh004
         RETURN
      ELSE
         CALL axmt520_xmdh004_default()
      END IF
   ELSE
      LET g_xmdh_d[l_ac].xmdh002 = ''
      LET g_xmdh_d[l_ac].xmdh003 = ''
      LET g_xmdh_d[l_ac].xmdh004 = ''
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 若輸入的訂單號+訂單項次的xmdd_t只有對應一個訂單項序時，則自動將訂單項序預設到出通單身[C:訂單項序]上
# Memo...........:
# Usage..........: CALL axmt520_xmdh002_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140312 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh002_default()
DEFINE l_cnt        LIKE type_t.num5

   LET l_cnt = 0
   SELECT count(count(xmddseq1)) INTO l_cnt
     FROM xmdd_t
    WHERE xmddent = g_enterprise
--      AND xmddsite = g_site
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      AND xmddseq = g_xmdh_d[l_ac].xmdh002
    GROUP BY xmddseq1
   IF l_cnt = 1 THEN
      SELECT DISTINCT xmddseq1 INTO g_xmdh_d[l_ac].xmdh003
        FROM xmdd_t
       WHERE xmddent = g_enterprise
--         AND xmddsite = g_site
         AND xmdddocno = g_xmdh_d[l_ac].xmdh001
         AND xmddseq = g_xmdh_d[l_ac].xmdh002
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 訂單分批序欄位校驗
# Memo...........:
# Usage..........: CALL axmt520_xmdh004_chk()
# Input parameter: no
# Return code....: no
# Date & Author..: 140312 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh004_chk()
DEFINE l_xmdc045    LIKE xmdc_t.xmdc045

   LET g_errno = ''
   
   SELECT xmdc045 
     INTO l_xmdc045
     FROM xmdd_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmddent
                                       AND xmdcdocno = xmdddocno
                                       AND xmdcseq = xmddseq
    WHERE xmddent = g_enterprise
--      AND xmddsite = g_site
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      AND xmddseq = g_xmdh_d[l_ac].xmdh002
      AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
      AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
   CASE
#      WHEN SQLCA.sqlcode = 100    LET g_errno = 'axm-00158'      #160318-00005#50  mark
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'sub-01323'       #160318-00005#50  add
      #输入的数据在订单单身明细档中无对应的数据！
      WHEN l_xmdc045 <> '1' LET g_errno = 'axm-00634'
      #訂單已結案，不可輸入!
      OTHERWISE LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
   
   
   IF cl_null(g_errno) THEN
     #161205-00025#9 161215 by lori add---(S)
     #CALL axmt520_xmdd006_chk(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh006,0,0)  
      CALL axmt520_xmdd006_chk(g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,
                               g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh006,0,
                               0,'','')
     #161205-00025#9 161215 by lori add---(E)
   END IF
  
END FUNCTION

################################################################################
# Descriptions...: 若訂單號、項次、項序、分批序均有值時，則需預設出貨單身相關欄位值
# Memo...........:
# Usage..........: CALL axmt520_xmdh004_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140312 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh004_default()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_ooba002    LIKE ooba_t.ooba002   #dorislai-20150824-add
DEFINE l_xmdr_cnt   LIKE type_t.num5      #160408-00035#4 add
DEFINE l_xmdr_qty   LIKE xmdr_t.xmdr008   #160408-00035#4 add
DEFINE l_qty        LIKE xmdr_t.xmdr008   #160408-00035#4 add
DEFINE l_diff_qty   LIKE xmdr_t.xmdr008   #160408-00035#4 add

DEFINE l_xmdh  RECORD
    xmdhunit   LIKE xmdh_t.xmdhunit,
    xmdh002    LIKE xmdh_t.xmdh002,
    xmdh003    LIKE xmdh_t.xmdh003,
    xmdh004    LIKE xmdh_t.xmdh004,
    xmdh005    LIKE xmdh_t.xmdh005,
    xmdh006    LIKE xmdh_t.xmdh006,
    xmdh007    LIKE xmdh_t.xmdh007,
    xmdh008    LIKE xmdh_t.xmdh008,
    xmdh009    LIKE xmdh_t.xmdh009,
    xmdh010    LIKE xmdh_t.xmdh010,
    xmdh011    LIKE xmdh_t.xmdh011,
    xmdh012    LIKE xmdh_t.xmdh012,
    xmdh013    LIKE xmdh_t.xmdh013,
    xmdh014    LIKE xmdh_t.xmdh014,
    xmdh015    LIKE xmdh_t.xmdh015,
    xmdh016    LIKE xmdh_t.xmdh016,
    xmdh017    LIKE xmdh_t.xmdh017,
    xmdh018    LIKE xmdh_t.xmdh018,
    xmdh019    LIKE xmdh_t.xmdh019,
    xmdh020    LIKE xmdh_t.xmdh020,
    xmdh021    LIKE xmdh_t.xmdh021,
    xmdh022    LIKE xmdh_t.xmdh022,
    xmdh023    LIKE xmdh_t.xmdh023,
    xmdh024    LIKE xmdh_t.xmdh024,
    xmdh025    LIKE xmdh_t.xmdh025,
    xmdh026    LIKE xmdh_t.xmdh026,
    xmdh027    LIKE xmdh_t.xmdh027,
    xmdh028    LIKE xmdh_t.xmdh028,
    xmdh029    LIKE xmdh_t.xmdh029,
    xmdh030    LIKE xmdh_t.xmdh030,
    xmdh031    LIKE xmdh_t.xmdh031,
    xmdh032    LIKE xmdh_t.xmdh032,
    xmdh033    LIKE xmdh_t.xmdh033,
    xmdh034    LIKE xmdh_t.xmdh034,
    xmdh035    LIKE xmdh_t.xmdh035,
    xmdh036    LIKE xmdh_t.xmdh036,
    xmdh050    LIKE xmdh_t.xmdh050,
    xmdh051    LIKE xmdh_t.xmdh051,
    xmdh056    LIKE xmdh_t.xmdh056
           END RECORD

   IF cl_null(g_xmdh_d[l_ac].xmdh001) OR
      cl_null(g_xmdh_d[l_ac].xmdh002) OR
      cl_null(g_xmdh_d[l_ac].xmdh003) OR
      cl_null(g_xmdh_d[l_ac].xmdh004) THEN
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xmdd_t 
    WHERE xmddent = g_enterprise
#     AND xmddsite = g_site
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      AND xmddseq = g_xmdh_d[l_ac].xmdh002
      AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
      AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
   IF l_cnt = 0 OR cl_null(l_cnt) THEN
      RETURN
   END IF
   
#160408-00035#4 add str
#先將抓取訂單備置明細檔的CURSOR準備好
   LET g_sql = "SELECT xmdr004,xmdr005,xmdr006,xmdr010,(xmdr008-xmdr009) FROM xmdr_t",
               " WHERE xmdrent = ",g_enterprise,
               "   AND xmdrdocno = ? AND xmdrseq = ? AND xmdrseq1 = ? AND xmdrseq2 = ? "
   PREPARE axmt520_sel_xmdr_rep1 FROM g_sql
   DECLARE axmt520_sel_xmdr_cur1 CURSOR FOR axmt520_sel_xmdr_rep1
#160408-00035#4 add end   

   SELECT xmddunit,xmdd003,xmdd001,xmdd002,xmdc003,xmdc004,xmdc005,xmdc028,xmdc029,xmdc030,
          xmdd004,(xmdd006-xmdd031+xmdd016),xmdd024,xmdd026,xmdc052,xmdd018,xmdd019,xmdd020,
          xmdc057,xmdc036,xmdc037,xmdc038,xmdc027,xmdd008,xmdc021,xmdc050,xmda050
         #160408-00035#4 add str  #查看有沒有硬備置的資料
         ,(SELECT COUNT(*) FROM xmdr_t 
            WHERE xmdrent=xmddent AND xmdrsite=xmddsite AND xmdrdocno=xmdddocno
              AND xmdrseq=xmddseq AND xmdrseq1=xmddseq1 AND xmdrseq2=xmddseq2
              AND xmdr004 IS NOT NULL AND xmdr004 <> ' ') xmdr_cnt
         ,(SELECT SUM(xmdr008-xmdr009) FROM xmdr_t 
            WHERE xmdrent=xmddent AND xmdrsite=xmddsite AND xmdrdocno=xmdddocno
              AND xmdrseq=xmddseq AND xmdrseq1=xmddseq1 AND xmdrseq2=xmddseq2
              AND xmdr004 IS NOT NULL AND xmdr004 <> ' ') xmdr_qty
         #160408-00035#4 add end
     INTO g_xmdh_d[l_ac].xmdhunit,g_xmdh_d[l_ac].xmdh005 ,g_xmdh_d[l_ac].xmdh006 ,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh008,
          g_xmdh_d[l_ac].xmdh009 ,g_xmdh_d[l_ac].xmdh010 ,g_xmdh_d[l_ac].xmdh012 ,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,
          g_xmdh_d[l_ac].xmdh015 ,g_xmdh_d[l_ac].xmdh016 ,g_xmdh_d[l_ac].xmdh018 ,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh022,
          g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,g_xmdh4_d[l_ac].xmdh025,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh031,
          g_xmdh_d[l_ac].xmdh032 ,g_xmdh_d[l_ac].xmdh033 ,g_xmdh_d[l_ac].xmdh034 ,g_xmdh_d[l_ac].xmdh035,g_xmdh_d[l_ac].xmdh036,
          g_xmdh_d[l_ac].xmdh050 ,g_xmdh_d[l_ac].xmdh051
         ,l_xmdr_cnt,l_xmdr_qty   #160408-00035#4 add
     FROM xmdd_t LEFT OUTER JOIN xmdc_t ON xmdcent = xmddent
                                       AND xmdcsite = xmddsite
                                       AND xmdcdocno = xmdddocno
                                       AND xmdcseq = xmddseq
                                       AND xmdc045 = '1'
                 LEFT OUTER JOIN xmda_t ON xmdaent = xmddent
                                       AND xmdasite = xmddsite
                                       AND xmdadocno = xmdddocno
    WHERE xmddent = g_enterprise
#     AND xmddsite = g_site
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      AND xmddseq = g_xmdh_d[l_ac].xmdh002
      AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
      AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
   #dorislai-20150824-add----(S)
   #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
   IF cl_null(g_xmdh_d[l_ac].xmdh012) THEN
      #預設欄位
      CALL s_aooi200_get_slip(g_xmdg_m.xmdgdocno) RETURNING l_success,l_ooba002
      IF l_success THEN
         CALL s_aooi200_get_doc_default(g_site,'1',l_ooba002,'xmdh012',g_xmdh_d[l_ac].xmdh012)
         RETURNING g_xmdh_d[l_ac].xmdh012
         #應用參數
         IF cl_null(g_xmdh_d[l_ac].xmdh012) THEN
            CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076')
            RETURNING g_xmdh_d[l_ac].xmdh012
         END IF
      END IF
   END IF
   #dorislai-20150824-add----(E)

#   LET g_xmdh_d[l_ac].xmdh011 = 'N'  #多庫儲批  #160408-00035#4 mark
#160408-00035#4 add str
#如果訂單有做硬備置，那麼出通單要自動帶出備置的庫儲批與數量
   #當有做硬備置(l_xmdr_cnt>0) 且 訂單數量<>硬備置數量時 , 差異數量應該再寫一筆進多倉儲批
   #例如:訂單數量100，硬備置A倉數量25、B倉數量25
   CASE 
      WHEN l_xmdr_cnt = 1   #備置1筆倉儲批 
         IF l_xmdr_cnt > 0 AND g_xmdh_d[l_ac].xmdh016 <> l_xmdr_qty THEN
            LET g_xmdh_d[l_ac].xmdh011 = 'Y'   #多庫儲批
            LET g_xmdh_d[l_ac].xmdh012 = ''
            LET g_xmdh_d[l_ac].xmdh013 = ''
            LET g_xmdh_d[l_ac].xmdh014 = ''
         ELSE
            LET g_xmdh_d[l_ac].xmdh011 = 'N'   #多庫儲批         
            OPEN axmt520_sel_xmdr_cur1 USING g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,
                                             g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004
            FETCH axmt520_sel_xmdr_cur1 INTO g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,
                                             g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016
         END IF
      WHEN l_xmdr_cnt > 1   #備置多筆倉儲批
         LET g_xmdh_d[l_ac].xmdh011 = 'Y'   #多庫儲批
         LET g_xmdh_d[l_ac].xmdh012 = ''
         LET g_xmdh_d[l_ac].xmdh013 = ''
         LET g_xmdh_d[l_ac].xmdh014 = ''
      OTHERWISE             #沒有備置
         LET g_xmdh_d[l_ac].xmdh011 = 'N'   #多庫儲批
   END CASE
#160408-00035#4 add end   
   
   #已轉出貨數量
   LET g_xmdh_d[l_ac].xmdh030 = 0

   CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
                              g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                              g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                              g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
        RETURNING g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh021,
                  g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,g_xmdh4_d[l_ac].xmdh028,
                  g_xmdh_d[l_ac].xmdh056

#160408-00035#4 mod str
#   CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
#                              g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
#                              g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
#                              g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
#        RETURNING g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh021,
#                  g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,
#                  g_xmdh4_d[l_ac].xmdh028,g_xmdh_d[l_ac].xmdh056
#如果訂單有做硬備置，那麼出通單產生單身資料的時候，自動帶出備置的庫儲批與數量
   IF g_xmdh_d[l_ac].xmdh011 = 'Y' THEN
      #把硬備置的資料繞過一輪
      FOREACH axmt520_sel_xmdr_cur1
        USING g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004
         INTO l_xmdh.xmdh012,l_xmdh.xmdh013,l_xmdh.xmdh014,l_xmdh.xmdh015,l_qty
         CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,l_xmdh.xmdh015,
                                    l_qty,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                                    g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                                    g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
              RETURNING l_xmdh.xmdh017,l_xmdh.xmdh019,l_xmdh.xmdh021,
                        l_xmdh.xmdh026,l_xmdh.xmdh027,l_xmdh.xmdh028,l_xmdh.xmdh056
                     
         CALL axmt540_01_xmdm_insert('2',g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,  
                                     g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                     g_xmdh_d[l_ac].xmdh010,l_xmdh.xmdh012,l_xmdh.xmdh013,
                                     l_xmdh.xmdh014,g_xmdh_d[l_ac].xmdh029,l_xmdh.xmdh015,l_qty,
                                     g_xmdh_d[l_ac].xmdh018,l_xmdh.xmdh019,'','') 
              RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
      END FOREACH
      #硬備置的都跑完了,比較一下訂單數量與備置數量若有差異,則把剩下的量再寫入一筆倉儲批為空的
      IF g_xmdh_d[l_ac].xmdh016 <> l_xmdr_qty THEN
         LET l_diff_qty = g_xmdh_d[l_ac].xmdh016 - l_xmdr_qty
         CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
                                    l_diff_qty,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                                    g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                                    g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
              RETURNING l_xmdh.xmdh017,l_xmdh.xmdh019,l_xmdh.xmdh021,
                        l_xmdh.xmdh026,l_xmdh.xmdh027,l_xmdh.xmdh028,l_xmdh.xmdh056
         CALL axmt540_01_xmdm_insert('2',g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,  
                                     g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,
                                     g_xmdh_d[l_ac].xmdh010,'','','',
                                     g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh015,l_diff_qty,
                                     g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,'','')
              RETURNING l_success
      END IF
   ELSE    #備置1筆倉儲批或沒有備置
      CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
                                 g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                                 g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                                 g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
           RETURNING g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh021,
                     g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,
                     g_xmdh4_d[l_ac].xmdh028,g_xmdh_d[l_ac].xmdh056   
      IF NOT axmt540_01_xmdm_modify('2',g_xmdh_d[l_ac].xmdhseq,g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,
                                    g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,g_xmdh_d[l_ac].xmdh012,
                                    g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh015,
                                    g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh019,'','') THEN
      END IF
   END IF  
#160408-00035#4 mod end

   CALL s_desc_get_item_desc(g_xmdh_d[l_ac].xmdh006)
        RETURNING g_xmdh_d[l_ac].xmdh006_desc,g_xmdh_d[l_ac].xmdh006_desc_desc
   CALL s_desc_get_acc_desc('221',g_xmdh_d[l_ac].xmdh009)
        RETURNING g_xmdh_d[l_ac].xmdh009_desc
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015)
        RETURNING g_xmdh_d[l_ac].xmdh015_desc
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018)
        RETURNING g_xmdh_d[l_ac].xmdh018_desc
   CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012)
        RETURNING g_xmdh_d[l_ac].xmdh012_desc
   CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013)
        RETURNING g_xmdh_d[l_ac].xmdh013_desc
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020)
        RETURNING g_xmdh_d[l_ac].xmdh020_desc
        
   #add by lixiang 2015/06/18--s--
   CALL s_desc_get_project_desc(g_xmdh_d[l_ac].xmdh031) RETURNING g_xmdh_d[l_ac].xmdh031_desc
   DISPLAY BY NAME g_xmdh_d[l_ac].xmdh031_desc
   
   CALL s_desc_get_wbs_desc(g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032) RETURNING g_xmdh_d[l_ac].xmdh032_desc
   DISPLAY BY NAME g_xmdh_d[l_ac].xmdh032_desc
   
   CALL s_desc_get_activity_desc(g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh033) RETURNING g_xmdh_d[l_ac].xmdh033_desc
   DISPLAY BY NAME g_xmdh_d[l_ac].xmdh033_desc
   #add by lixiang 2015/06/18--e----
   #170110-00003#1---add---begin---
   SELECT xmda033 INTO g_xmdh_d[l_ac].xmda033 FROM xmda_t 
     WHERE xmdaent   = g_enterprise
      #AND xmdadocno = g_xmdg_m.xmdg004        #170111-00002#1 mark
       AND xmdadocno = g_xmdh_d[l_ac].xmdh001  #170111-00002#1 add
   DISPLAY BY NAME g_xmdh_d[l_ac].xmda033     
   #170110-00003#1---add---end---

   LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*

END FUNCTION

################################################################################
# Descriptions...: 料件編號檢核
# Memo...........:
# Usage..........: CALL axmt520_xmdh006_chk()
# Input parameter: no
# Return code....: no
# Date & Author..: 140313 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh006_chk()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_xmdh_d[l_ac].xmdh006
   IF g_flag = 'Y' THEN
      LET g_chkparam.arg2 = g_xmdh_d[l_ac].xmdh001
      #單身輸入訂單不存在的項次，料號需存在axmt500的”預估費用”資料中
      IF NOT cl_chk_exist("v_xmds001") THEN
         RETURN FALSE
      END IF
   ELSE
      IF NOT cl_chk_exist("v_imaf001_14") THEN
         RETURN FALSE
      END IF
   END IF
   
   #150721-00001#1  2016/01/08 By earl mod s
   #檢核輸入的料件的生命週期是否在單據別限制範圍內
   CALL s_control_chk_doc('4',g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdh006,'','','','')
   RETURNING l_success,l_flag
    
   IF NOT l_success OR NOT l_flag THEN
      RETURN FALSE
   END IF                
    
   #檢核輸入的料件的產品分類是否在單據別限制範圍內
   CALL s_control_chk_doc('5',g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdh006,'','','','')
   RETURNING l_success,l_flag
   
   IF NOT l_success OR NOT l_flag THEN
      RETURN FALSE
   END IF
#   IF NOT s_control_check_item(g_xmdh_d[l_ac].xmdh006,'2',g_site,g_user,g_dept,g_xmdg_m.xmdgdocno) THEN
#      RETURN FALSE
#   END IF
   #150721-00001#1  2016/01/08 By earl mod e
   
   IF NOT axmt520_xmdh006_xmdh007_chk() THEN
      RETURN FALSE
   END IF

   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 取得未稅金額、含稅金額、稅額
# Memo...........:
# Usage..........: CALL axmt520_get_amount(p_xmdhseq,p_xmdh021,p_xmdh023,p_xmdh024)
# Input parameter: p_xmdhseq,p_xmdh021,p_xmdh023,p_xmdh024
# Return code....: r_xmdh026,r_xmdh028,r_xmdh027
# Date & Author..: 140314 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_get_amount(p_xmdhseq,p_xmdh021,p_xmdh023,p_xmdh024)
DEFINE p_xmdgdocno  LIKE xmdg_t.xmdgdocno
DEFINE p_xmdhseq    LIKE xmdh_t.xmdhseq
DEFINE p_xmdh021    LIKE xmdh_t.xmdh021
DEFINE p_xmdh023    LIKE xmdh_t.xmdh023
DEFINE p_xmdh024    LIKE xmdh_t.xmdh024
DEFINE p_xmdg014    LIKE xmdg_t.xmdg014
DEFINE r_xmdh026    LIKE xmdh_t.xmdh026
DEFINE r_xmdh028    LIKE xmdh_t.xmdh028
DEFINE r_xmdh027    LIKE xmdh_t.xmdh027
DEFINE l_money      LIKE xrcd_t.xrcd113
DEFINE l_xrcd113    LIKE xrcd_t.xrcd113
DEFINE l_xrcd114    LIKE xrcd_t.xrcd114
DEFINE l_xrcd115    LIKE xrcd_t.xrcd115
DEFINE l_xrcd123    LIKE xrcd_t.xrcd113
DEFINE l_xrcd124    LIKE xrcd_t.xrcd114
DEFINE l_xrcd125    LIKE xrcd_t.xrcd115
DEFINE l_xrcd133    LIKE xrcd_t.xrcd113
DEFINE l_xrcd134    LIKE xrcd_t.xrcd114
DEFINE l_xrcd135    LIKE xrcd_t.xrcd115

   LET r_xmdh026 = 0
   LET r_xmdh028 = 0
   LET r_xmdh027 = 0

   IF cl_null(g_xmdg_m.xmdgdocno) OR cl_null(p_xmdhseq) OR 
      cl_null(p_xmdh021) OR cl_null(p_xmdh023) OR 
      cl_null(p_xmdh024) OR cl_null(g_xmdg_m.xmdg014) THEN
      RETURN r_xmdh026,r_xmdh028,r_xmdh027
   END IF
   
   LET l_money = p_xmdh021 * p_xmdh023
   CALL s_tax_ins(g_xmdg_m.xmdgdocno,p_xmdhseq,0,g_site,l_money,
                  p_xmdh024,p_xmdh021,g_xmdg_m.xmdg014,1,'','','' )
        RETURNING r_xmdh026,r_xmdh028,r_xmdh027,l_xrcd113,l_xrcd114,l_xrcd115,
                  l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

   RETURN r_xmdh026,r_xmdh028,r_xmdh027
   
END FUNCTION

################################################################################
# Descriptions...: 若單據別參數設定需檢核在揀量時，則帳面庫存量-已在揀量小於申請出貨數量時，則不允許輸入此庫位
# Memo...........:
# Usage..........: CALL axmt520_inan_chk()
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 140630 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_inan_chk()
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5

   IF g_flag = 'Y' THEN
      RETURN TRUE
   END IF
   #160408-00035#9-add-g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002
   CALL s_inventory_check_inan(g_site,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,
                               #' ',g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,
                               g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,  #160805-00052#1 mod
                               g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh015,
                               g_xmdh_d[l_ac].xmdh016,g_xmdg_m.xmdgdocno,
                               g_xmdh_d[l_ac].xmdhseq,'0',g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002)  
        RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN FALSE
      IF l_flag = 0 THEN
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: get oocq019
# Memo...........:
# Usage..........: CALL axmt520_get_oocq019()
#                  RETURNING r_oocq019
# Input parameter: no
# Return code....: r_oocq019
# Date & Author..: 140325 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_get_oocq019()
DEFINE r_oocq019    LIKE oocq_t.oocq019

   LET r_oocq019 = ''
   SELECT oocq019 INTO r_oocq019
     FROM oocq_t
    WHERE oocq001 ='263'
      AND oocq002 = g_xmdg_m.xmdg018
      AND oocqent = g_enterprise    #160902-00048#2
   RETURN r_oocq019
   
END FUNCTION

################################################################################
# Descriptions...: 頁簽4顯示欄位
# Memo...........:
# Usage..........: CALL axmt520_xmdh_display()
# Input parameter: no
# Return code....: no
# Date & Author..: 140701 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh_display()
   LET g_xmdh4_d[l_ac].xmdhseq = g_xmdh_d[l_ac].xmdhseq 
   LET g_xmdh4_d[l_ac].xmdh0011 = g_xmdh_d[l_ac].xmdh001 
   LET g_xmdh4_d[l_ac].xmdh0021 = g_xmdh_d[l_ac].xmdh002
   LET g_xmdh4_d[l_ac].xmdh0031 = g_xmdh_d[l_ac].xmdh003
   LET g_xmdh4_d[l_ac].xmdh0041 = g_xmdh_d[l_ac].xmdh004
   LET g_xmdh4_d[l_ac].xmdh0051 = g_xmdh_d[l_ac].xmdh005 
   LET g_xmdh4_d[l_ac].xmdh0061 = g_xmdh_d[l_ac].xmdh006
   LET g_xmdh4_d[l_ac].xmdh0061_desc = g_xmdh_d[l_ac].xmdh006_desc
   LET g_xmdh4_d[l_ac].xmdh0061_desc_desc = g_xmdh_d[l_ac].xmdh006_desc_desc
   LET g_xmdh4_d[l_ac].xmdh0071 = g_xmdh_d[l_ac].xmdh007     
   LET g_xmdh4_d[l_ac].xmdh0071_desc = g_xmdh_d[l_ac].xmdh007_desc     
   LET g_xmdh4_d[l_ac].xmdh0091 = g_xmdh_d[l_ac].xmdh009     
   LET g_xmdh4_d[l_ac].xmdh0091_desc = g_xmdh_d[l_ac].xmdh009_desc 
   LET g_xmdh4_d[l_ac].xmdh0101 = g_xmdh_d[l_ac].xmdh010     
   LET g_xmdh4_d[l_ac].xmdh0151 = g_xmdh_d[l_ac].xmdh015     
   LET g_xmdh4_d[l_ac].xmdh0151_desc = g_xmdh_d[l_ac].xmdh015_desc 
   LET g_xmdh4_d[l_ac].xmdh0161 = g_xmdh_d[l_ac].xmdh016     
   LET g_xmdh4_d[l_ac].xmdh0201 = g_xmdh_d[l_ac].xmdh020     
   LET g_xmdh4_d[l_ac].xmdh0201_desc = g_xmdh_d[l_ac].xmdh020_desc 
   LET g_xmdh4_d[l_ac].xmdh0211 = g_xmdh_d[l_ac].xmdh021
   
END FUNCTION

################################################################################
# Descriptions...: 修改單價
# Memo...........:
# Usage..........: CALL axmt520_upd_price()
# Input parameter: no
# Return code....: no
# Date & Author..: 140411 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_upd_price()
DEFINE l_lock_sw    LIKE type_t.chr1                #單身鎖住否
DEFINE ls_group     STRING
DEFINE l_flag       LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
DEFINE l_xmda017    LIKE xmda_t.xmda017
DEFINE l_xmdc040    LIKE xmdc_t.xmdc040
DEFINE l_xmah003    LIKE xmah_t.xmah003
DEFINE l_cnt        LIKE type_t.num5   #170202-00033#1 add

   LET l_xmda017 = ''
   LET l_xmdc040 = ''
   LET l_xmah003 = ''
   SELECT xmda017,xmdc040,xmah003
     INTO l_xmda017,l_xmdc040,l_xmah003
     FROM xmda_t,xmdc_t,xmah_t
    WHERE xmdaent = g_enterprise
--      AND xmdasite = g_site
      AND xmdadocno = g_xmdh_d[g_detail_idx].xmdh001
      AND xmdaent = xmdcent
      AND xmdadocno = xmdcdocno
      AND xmdcseq = g_xmdh_d[g_detail_idx].xmdh002
      AND xmdaent = xmahent
      AND xmda017 = xmah001
   #若單頭取價方式的基本資料設置不允許修改單價時，則單價欄位不可以維護
   IF l_xmah003 = 'N' THEN   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_xmda017
      LET g_errparam.code   = 'sub-00594'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF

   LET g_forupd_sql = "SELECT xmdhsite,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,xmdh007, 
       xmdh034,xmdh009,xmdh010,xmdh015,xmdh016,xmdh017,xmdh018,xmdh019,xmdh008,xmdh011,xmdh012,xmdh013, 
       xmdh014,xmdh020,xmdh021,xmdh022,xmdh036,xmdh031,xmdh032,xmdh033,xmdh050,xmdh030,xmdh051,xmdh052, 
       xmdhseq,xmdh023,xmdh024,xmdh025,xmdh026,xmdh027,xmdh028 FROM xmdh_t WHERE xmdhent=? AND xmdhdocno=?  
       AND xmdhseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt520_bcl4 CURSOR FROM g_forupd_sql
   
   CALL cl_set_comp_entry("xmdh023",TRUE)
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_xmdh4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, 
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
                 
         BEFORE INPUT
            CALL axmt520_b_fill()
            LET g_rec_b = g_xmdh4_d.getLength()
            
         BEFORE ROW     
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN axmt520_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE axmt520_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_xmdh4_d.getLength()
            
            LET g_xmdh_d_t.* = g_xmdh_d[l_ac].*    #BACKUP
            LET g_xmdh4_d_t.* = g_xmdh4_d[l_ac].*  #BACKUP
            LET g_xmdh4_d_o.* = g_xmdh4_d[l_ac].*

            LET ls_group = "xmdh_t"
            IF ls_group.getIndexOf("xmdh_t",1) THEN
               OPEN axmt520_bcl4 USING g_enterprise,g_xmdg_m.xmdgdocno,g_xmdh_d[g_detail_idx].xmdhseq     
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt520_bcl4" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt520_bcl4 INTO
                      g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh001,g_xmdh_d[l_ac].xmdh002,
                      g_xmdh_d[l_ac].xmdh003,g_xmdh_d[l_ac].xmdh004,g_xmdh_d[l_ac].xmdh005,g_xmdh_d[l_ac].xmdh006,
                      g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh034,g_xmdh_d[l_ac].xmdh009,g_xmdh_d[l_ac].xmdh010,
                      g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh018,
                      g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh008,g_xmdh_d[l_ac].xmdh011,g_xmdh_d[l_ac].xmdh012,
                      g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh020,g_xmdh_d[l_ac].xmdh021,
                      g_xmdh_d[l_ac].xmdh022,g_xmdh_d[l_ac].xmdh036,g_xmdh_d[l_ac].xmdh031,g_xmdh_d[l_ac].xmdh032,
                      g_xmdh_d[l_ac].xmdh033,g_xmdh_d[l_ac].xmdh050,g_xmdh_d[l_ac].xmdh030,g_xmdh_d[l_ac].xmdh051,
                      g_xmdh_d[l_ac].xmdh052,g_xmdh4_d[l_ac].xmdhseq,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                      g_xmdh4_d[l_ac].xmdh025,g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,g_xmdh4_d[l_ac].xmdh028
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmdh_d[g_detail_idx].xmdhseq
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL axmt520_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            END IF
         
         AFTER FIELD xmdh023
            #170202-00033#1---add---str--
            #費用性的資料，不需檢核修改後單價的合理性
            LET L_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM xmds_t,xmdh_t
             WHERE xmdhent = xmdsent AND xmdhsite = xmdssite
               AND xmdhdocno = xmdhdocno
               AND xmdh001 = xmdsdocno AND xmdh006 = xmds001
               AND xmdhent = g_enterprise AND xmdhsite = g_site AND xmdh001 = g_xmdh_d[l_ac].xmdh001
               AND xmdhdocno = g_xmdg_m.xmdgdocno AND xmdh006 = g_xmdh_d[l_ac].xmdh006
            IF cl_null(l_cnt) THEN LET L_cnt = 0 END IF
            IF l_cnt = 0 THEN
               SELECT xmda017,xmdc040
                 INTO l_xmda017,l_xmdc040
                 FROM xmda_t,xmdc_t
                WHERE xmdaent = g_enterprise
                  AND xmdadocno = g_xmdh_d[g_detail_idx].xmdh001
                  AND xmdaent = xmdcent
                  AND xmdadocno = xmdcdocno
                  AND xmdcseq = g_xmdh_d[g_detail_idx].xmdh002
            #170202-00033#1---add---end--
               CALL s_sale_price_check(l_xmda017,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d_o.xmdh023,l_xmdc040,g_xmdg_m.xmdg014,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh020)
                    RETURNING l_flag,l_errno
               IF NOT l_flag THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  LET g_xmdh4_d[l_ac].xmdh023 = g_xmdh4_d_o.xmdh023
                  NEXT FIELD xmdh023
               END IF         
            END IF   #170202-00033#1 add            
            IF NOT cl_null(g_xmdh4_d[l_ac].xmdh023) THEN 
               IF g_xmdh4_d[l_ac].xmdh023 <> g_xmdh4_d_o.xmdh023 OR cl_null(g_xmdh4_d_o.xmdh023) THEN
                  CALL axmt520_get_amount(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh021,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024)
                       RETURNING g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh028,g_xmdh4_d[l_ac].xmdh027
               END IF
            END IF 
            LET g_xmdh4_d_o.xmdh023 = g_xmdh4_d[l_ac].xmdh023

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
               LET g_xmdh4_d[l_ac].* = g_xmdh4_d_t.*
               CALL s_transaction_end('N','0')
               CLOSE axmt520_bcl4
               EXIT DIALOG 
            END IF
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmdh_d[g_detail_idx].xmdhseq
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
               LET g_xmdh4_d[l_ac].* = g_xmdh4_d_t.*
            ELSE
               UPDATE xmdh_t
                  SET xmdh023 = g_xmdh4_d[l_ac].xmdh023,
                      xmdh026 = g_xmdh4_d[l_ac].xmdh026,
                      xmdh027 = g_xmdh4_d[l_ac].xmdh027,
                      xmdh028 = g_xmdh4_d[l_ac].xmdh028
                WHERE xmdhent = g_enterprise
                  AND xmdhdocno = g_xmdg_m.xmdgdocno 
                  AND xmdhseq = g_xmdh_d[g_detail_idx].xmdhseq
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
                     LET g_xmdh4_d[l_ac].* = g_xmdh4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdh_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_xmdh_d[l_ac].* = g_xmdh_d_t.*
                     LET g_xmdh4_d[l_ac].* = g_xmdh4_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmdg_m.xmdgdocno
                     LET gs_keys_bak[1] = g_xmdgdocno_t
                     LET gs_keys[2] = g_xmdh_d[g_detail_idx].xmdhseq
                     LET gs_keys_bak[2] = g_xmdh4_d_t.xmdhseq
                     CALL axmt520_update_b('xmdh_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
               END CASE
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_xmdg_m),util.JSON.stringify(g_xmdh_d_t)
               LET g_log2 = util.JSON.stringify(g_xmdg_m),util.JSON.stringify(g_xmdh_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            
         AFTER ROW
            CLOSE axmt520_bcl4
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            CALL axmt520_total_count()

      END INPUT
 
      BEFORE DIALOG 
         NEXT FIELD xmdhseq_4
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   CALL cl_set_comp_entry("xmdh023",FALSE)
   
END FUNCTION

################################################################################
# Descriptions...: 單別預設
# Memo...........:
# Usage..........: CALL axmt520_doc_default()
# Input parameter: no
# Return code....: no
# Date & Author..: 140806 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_doc_default()
DEFINE l_success    LIKE type_t.num5
DEFINE l_oodb011    LIKE oodb_t.oodb011
   
   LET g_errshow = 0
   
   LET g_xmdg_m.xmdg001 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg001',g_xmdg_m.xmdg001)
   LET g_xmdg_m.xmdg002 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg002',g_xmdg_m.xmdg002)
   LET g_xmdg_m.xmdg003 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg003',g_xmdg_m.xmdg003)
   LET g_xmdg_m.xmdg004 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg004',g_xmdg_m.xmdg004)
   LET g_xmdg_m.xmdg005 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg005',g_xmdg_m.xmdg005)
   LET g_xmdg_m.xmdg006 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg006',g_xmdg_m.xmdg006)
   LET g_xmdg_m.xmdg007 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg007',g_xmdg_m.xmdg007)
   LET g_xmdg_m.xmdg008 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg008',g_xmdg_m.xmdg008)
   LET g_xmdg_m.xmdg009 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg009',g_xmdg_m.xmdg009)
   LET g_xmdg_m.xmdg010 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg010',g_xmdg_m.xmdg010)
   LET g_xmdg_m.xmdg011 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg011',g_xmdg_m.xmdg011)
   LET g_xmdg_m.xmdg012 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg012',g_xmdg_m.xmdg012)
   LET g_xmdg_m.xmdg013 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg013',g_xmdg_m.xmdg013)
   LET g_xmdg_m.xmdg014 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg014',g_xmdg_m.xmdg014)
   LET g_xmdg_m.xmdg015 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg015',g_xmdg_m.xmdg015)
   LET g_xmdg_m.xmdg016 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg016',g_xmdg_m.xmdg016)
   LET g_xmdg_m.xmdg017 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg017',g_xmdg_m.xmdg017)
   LET g_xmdg_m.xmdg018 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg018',g_xmdg_m.xmdg018)
   LET g_xmdg_m.xmdg019 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg019',g_xmdg_m.xmdg019)
   LET g_xmdg_m.xmdg020 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg020',g_xmdg_m.xmdg020)
   LET g_xmdg_m.xmdg021 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg021',g_xmdg_m.xmdg021)
   LET g_xmdg_m.xmdg022 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg022',g_xmdg_m.xmdg022)
   LET g_xmdg_m.xmdg023 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg023',g_xmdg_m.xmdg023)
   LET g_xmdg_m.xmdg024 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg024',g_xmdg_m.xmdg024)
   LET g_xmdg_m.xmdg025 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg025',g_xmdg_m.xmdg025)
   LET g_xmdg_m.xmdg026 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg026',g_xmdg_m.xmdg026)
   LET g_xmdg_m.xmdg027 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg027',g_xmdg_m.xmdg027)
   LET g_xmdg_m.xmdg028 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg028',g_xmdg_m.xmdg028)
   LET g_xmdg_m.xmdg030 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg030',g_xmdg_m.xmdg030)
   LET g_xmdg_m.xmdg031 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg031',g_xmdg_m.xmdg031)
   LET g_xmdg_m.xmdg032 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg032',g_xmdg_m.xmdg032)
   LET g_xmdg_m.xmdg033 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg033',g_xmdg_m.xmdg033)
   #add xmdg034 by shiun------------
   LET g_xmdg_m.xmdg034 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg034',g_xmdg_m.xmdg034)
   #LET g_xmdg_m.xmdg050 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg050',g_xmdg_m.xmdg050)
   #LET g_xmdg_m.xmdg051 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg051',g_xmdg_m.xmdg051)
   #LET g_xmdg_m.xmdg052 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg052',g_xmdg_m.xmdg052)
   LET g_xmdg_m.xmdg053 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg053',g_xmdg_m.xmdg053)
   LET g_xmdg_m.xmdg054 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg054',g_xmdg_m.xmdg054)
   LET g_xmdg_m.xmdg055 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg055',g_xmdg_m.xmdg055)
   LET g_xmdg_m.xmdg056 = s_aooi200_get_doc_default(g_site,'1',g_xmdg_m.xmdgdocno,'xmdg056',g_xmdg_m.xmdg056)

   CALL s_desc_get_person_desc(g_xmdg_m.xmdg002)
        RETURNING g_xmdg_m.xmdg002_desc
   DISPLAY BY NAME g_xmdg_m.xmdg002_desc
   
   IF NOT cl_null(g_xmdg_m.xmdg002) AND cl_null(g_xmdg_m.xmdg003) THEN
      SELECT ooag003 INTO g_xmdg_m.xmdg003
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_xmdg_m.xmdg002
   END IF

   CALL s_desc_get_department_desc(g_xmdg_m.xmdg003)
        RETURNING g_xmdg_m.xmdg003_desc
   DISPLAY BY NAME g_xmdg_m.xmdg003_desc

   IF NOT cl_null(g_xmdg_m.xmdg005) THEN
      IF cl_null(g_xmdg_m.xmdg006) THEN
         CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'1')
              RETURNING g_xmdg_m.xmdg006
      END IF
      IF cl_null(g_xmdg_m.xmdg007) THEN
         CALL s_axmt540_client_partner(g_xmdg_m.xmdgdocno,g_xmdg_m.xmdg005,'2')
              RETURNING g_xmdg_m.xmdg007
      END IF
   END IF

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg005)
        RETURNING g_xmdg_m.xmdg005_desc
   DISPLAY BY NAME g_xmdg_m.xmdg005_desc

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg006)
        RETURNING g_xmdg_m.xmdg006_desc
   DISPLAY BY NAME g_xmdg_m.xmdg006_desc

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg007)
        RETURNING g_xmdg_m.xmdg007_desc
   DISPLAY BY NAME g_xmdg_m.xmdg007_desc

   #160621-00003#3 20160629 modify by beckxie---S
   #CALL s_desc_get_acc_desc('275',g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
   CALL s_desc_get_oojdl003_desc(g_xmdg_m.xmdg026) RETURNING g_xmdg_m.xmdg026_desc
   #160621-00003#3 20160629 modify by beckxie---E
   DISPLAY BY NAME g_xmdg_m.xmdg026_desc

   CALL s_desc_get_acc_desc('295',g_xmdg_m.xmdg027)
        RETURNING g_xmdg_m.xmdg027_desc
   DISPLAY BY NAME g_xmdg_m.xmdg027_desc

   CALL s_desc_get_acc_desc('209',g_xmdg_m.xmdg030)
        RETURNING g_xmdg_m.xmdg030_desc
   DISPLAY BY NAME g_xmdg_m.xmdg030_desc

   CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031)
        RETURNING g_xmdg_m.xmdg031_desc
   DISPLAY BY NAME g_xmdg_m.xmdg031_desc

   CALL axmt520_xmdg017_ref()
   CALL axmt520_xmdg023_ref()

   IF NOT cl_null(g_xmdg_m.xmdg018) THEN
      CALL s_desc_get_acc_desc('263',g_xmdg_m.xmdg018)
           RETURNING g_xmdg_m.xmdg018_desc
      DISPLAY BY NAME g_xmdg_m.xmdg018_desc
      CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg019)
           RETURNING g_xmdg_m.xmdg019_desc
      DISPLAY BY NAME g_xmdg_m.xmdg019_desc
      CALL s_apmi011_location_ref(g_xmdg_m.xmdg018,g_xmdg_m.xmdg020)
           RETURNING g_xmdg_m.xmdg020_desc
      DISPLAY BY NAME g_xmdg_m.xmdg020_desc
   END IF

   CALL s_desc_get_trading_partner_abbr_desc(g_xmdg_m.xmdg016)
        RETURNING g_xmdg_m.xmdg016_desc
   DISPLAY BY NAME g_xmdg_m.xmdg016_desc

   CALL s_desc_get_ooib002_desc(g_xmdg_m.xmdg008)
        RETURNING g_xmdg_m.xmdg008_desc
   DISPLAY BY NAME g_xmdg_m.xmdg008_desc

   CALL s_desc_get_acc_desc('238',g_xmdg_m.xmdg009)
        RETURNING g_xmdg_m.xmdg009_desc
   DISPLAY BY NAME g_xmdg_m.xmdg009_desc

   IF NOT cl_null(g_xmdg_m.xmdg010) THEN
      CALL s_tax_chk(g_site,g_xmdg_m.xmdg010)
           RETURNING l_success,g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg012,g_xmdg_m.xmdg011,l_oodb011
      IF NOT l_success THEN
         LET g_xmdg_m.xmdg010 = g_xmdg_m_o.xmdg010
         LET g_xmdg_m.xmdg011 = g_xmdg_m_o.xmdg011
         LET g_xmdg_m.xmdg012 = g_xmdg_m_o.xmdg012
      END IF
   END IF

   CALL s_desc_get_tax_desc1(g_site,g_xmdg_m.xmdg010)
        RETURNING g_xmdg_m.xmdg010_desc
   DISPLAY BY NAME g_xmdg_m.xmdg010_desc

   CALL s_desc_get_invoice_type_desc1(g_site,g_xmdg_m.xmdg013)
        RETURNING g_xmdg_m.xmdg013_desc
   DISPLAY BY NAME g_xmdg_m.xmdg013_desc

   IF NOT cl_null(g_xmdg_m.xmdg032) AND NOT cl_null(g_xmdg_m.xmdg014) THEN
      #add--2015/11/19 By shiun--(S)
      CALL axmt520_xmda_xmdg015() RETURNING g_xmdg_m.xmdg015
      IF cl_null(g_xmdg_m.xmdg015) THEN                     
         CALL s_axmt540_get_exchange(g_xmdg_m.xmdg032,g_xmdg_m.xmdg014,g_xmdg_m.xmdgdocdt) RETURNING g_xmdg_m.xmdg015   #modify--2015/11/18 By shiun     新增傳入參數
      END IF
      #add--2015/11/19 By shiun--(E)
   END IF

   CALL s_desc_get_currency_desc(g_xmdg_m.xmdg014)
        RETURNING g_xmdg_m.xmdg014_desc
   DISPLAY BY NAME g_xmdg_m.xmdg014_desc
   
   #add xmdg034 by shiun------------
   DISPLAY BY NAME g_xmdg_m.xmdg001,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdg004,g_xmdg_m.xmdg005,
                   g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg008,g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,
                   g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015,
                   g_xmdg_m.xmdg016,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019,g_xmdg_m.xmdg020,
                   g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,
                   g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg028,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031,
                   g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,#g_xmdg_m.xmdg050,g_xmdg_m.xmdg051,g_xmdg_m.xmdg052,
                   g_xmdg_m.xmdg034,g_xmdg_m.xmdg053,g_xmdg_m.xmdg054,g_xmdg_m.xmdg055,g_xmdg_m.xmdg056

   LET g_xmdg_m_o.* = g_xmdg_m.*
   
END FUNCTION

################################################################################
# Descriptions...: 當出貨料號與訂單料號不一樣時，必須檢核是否與訂單料號有替代關係，若沒有則不允許修改
# Memo...........:
# Usage..........: CALL axmt520_xmdh006_xmdh007_chk()
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 140808 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh006_xmdh007_chk()
DEFINE l_xmdd001    LIKE xmdd_t.xmdd001
DEFINE l_xmdd002    LIKE xmdd_t.xmdd002
   
   IF g_flag = 'Y' THEN
      RETURN TRUE
   END IF
   
   LET l_xmdd001 = ''
   LET l_xmdd002 = ''
   SELECT xmdd001,xmdd002
     INTO l_xmdd001,l_xmdd002
     FROM xmdd_t
    WHERE xmddent = g_enterprise
      AND xmdddocno = g_xmdh_d[l_ac].xmdh001
      AND xmddseq = g_xmdh_d[l_ac].xmdh002
      AND xmddseq1 = g_xmdh_d[l_ac].xmdh003
      AND xmddseq2 = g_xmdh_d[l_ac].xmdh004
   IF l_xmdd001 <> g_xmdh_d[l_ac].xmdh006 OR l_xmdd002 <> g_xmdh_d[l_ac].xmdh007 THEN
      #151208-00018#1   2015/12/09  By earl mod s
      #IF NOT s_pmaq_chk_replacement(g_xmdg_m.xmdg005,l_xmdd001,g_xmdh_d[l_ac].xmdh006,'3',l_xmdd002,g_xmdh_d[l_ac].xmdh007) THEN
      IF NOT s_pmaq_chk_replacement_sale(g_xmdg_m.xmdg005,l_xmdd001,g_xmdh_d[l_ac].xmdh006,'12',l_xmdd002,g_xmdh_d[l_ac].xmdh007) THEN
      #151208-00018#1   2015/12/09  By earl mod e
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 執行action修改資料前lock
# Memo...........:
# Usage..........: CALL axmt520_action_modify(p_flag)
# Input parameter: p_flag   'P'單價/'H'留置
# Return code....: TRUE OR FALSE
# Date & Author..: 140811 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_action_modify(p_flag)
DEFINE p_flag       LIKE type_t.chr1
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   IF g_xmdg_m.xmdgdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN FALSE
   END IF
 
   ERROR ""
  
   LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
 
   OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt520_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axmt520_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
 
#   EXECUTE axmt520_master_referesh USING g_xmdg_m.xmdgdocno INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocdt, 
#       g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite,g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdgstus,g_xmdg_m.xmdg001, 
#       g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg006,g_xmdg_m.xmdg007,g_xmdg_m.xmdg202,g_xmdg_m.xmdg028, 
#       g_xmdg_m.xmdg026,g_xmdg_m.xmdg027,g_xmdg_m.xmdg024,g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg031, 
#       g_xmdg_m.xmdg053,g_xmdg_m.xmdg054,g_xmdg_m.xmdg055,g_xmdg_m.xmdg017,g_xmdg_m.xmdg018,g_xmdg_m.xmdg019, 
#       g_xmdg_m.xmdg020,g_xmdg_m.xmdg016,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg008, 
#       g_xmdg_m.xmdg009,g_xmdg_m.xmdg010,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg032, 
#       g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgcrtid, 
#       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid, 
#       g_xmdg_m.xmdgcnfdt,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc, 
#       g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg030_desc, 
#       g_xmdg_m.xmdg031_desc,g_xmdg_m.xmdg017_desc,g_xmdg_m.xmdg018_desc,g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg008_desc, 
#       g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid_desc, 
#       g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgmodid_desc,g_xmdg_m.xmdgcnfid_desc
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = g_xmdg_m.xmdgdocno 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      CLOSE axmt520_cl
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
   
   CALL axmt520_show()

   WHILE TRUE
      LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
      LET g_xmdg_m.xmdgmodid = g_user 
      LET g_xmdg_m.xmdgmoddt = cl_get_current()
      
      CASE p_flag
         WHEN 'P'  #單價         
            CALL axmt520_upd_price()
         WHEN 'H'  #留置
            CALL axmt520_hold()
         OTHERWISE EXIT CASE
      END CASE
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xmdg_m.* = g_xmdg_m_t.*
         CALL axmt520_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT WHILE
      END IF 
      
      UPDATE xmdg_t
         SET xmdgmodid = g_xmdg_m.xmdgmodid,
             xmdgmoddt = g_xmdg_m.xmdgmoddt
       WHERE xmdgent = g_enterprise
         AND xmdgdocno = g_xmdgdocno_t
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd xmdg_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   
      EXIT WHILE
   END WHILE
   
   CLOSE axmt520_cl
   
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xmdg_m.xmdgdocno,'U')
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 留置
# Memo...........:
# Usage..........: axmt520_hold()
# Input parameter: no
# Return code....: no
# Date & Author..: 140811 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_hold()

   CALL cl_set_comp_entry("xmdg031",TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_xmdg_m.xmdg031
         ATTRIBUTE(WITHOUT DEFAULTS)
     
         BEFORE INPUT
            LET g_xmdg_m_t.* = g_xmdg_m.*
            LET g_xmdg_m_o.* = g_xmdg_m.*

         AFTER FIELD xmdg031
            LET g_xmdg_m.xmdg031_desc = ''
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            IF NOT cl_null(g_xmdg_m.xmdg031) THEN
               IF (g_xmdg_m.xmdg031 != g_xmdg_m_o.xmdg031 OR g_xmdg_m_o.xmdg031 IS NULL ) THEN
                  IF NOT s_azzi650_chk_exist('297',g_xmdg_m.xmdg031) THEN
                     LET g_xmdg_m.xmdg031 = g_xmdg_m_o.xmdg031
                     CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031)
                          RETURNING g_xmdg_m.xmdg031_desc
                     DISPLAY BY NAME g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031)
                 RETURNING g_xmdg_m.xmdg031_desc
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            LET g_xmdg_m_o.xmdg031 = g_xmdg_m.xmdg031

         ON ACTION controlp INFIELD xmdg031
   			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdg_m.xmdg031  #給予default值
            LET g_qryparam.arg1 = "297" 
            CALL q_oocq002()                            #呼叫開窗
            LET g_xmdg_m.xmdg031 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_xmdg_m.xmdg031 TO xmdg031         #顯示到畫面上
            CALL s_desc_get_acc_desc('297',g_xmdg_m.xmdg031)
                 RETURNING g_xmdg_m.xmdg031_desc
            DISPLAY BY NAME g_xmdg_m.xmdg031_desc
            NEXT FIELD xmdg031                          #返回原欄位

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            DISPLAY BY NAME g_xmdg_m.xmdgdocno
            LET g_xmdg_m.xmdgstus = 'H'
            UPDATE xmdg_t
               SET xmdg031 = g_xmdg_m.xmdg031,
                   xmdgstus = g_xmdg_m.xmdgstus
             WHERE xmdgent = g_enterprise
               AND xmdgdocno = g_xmdgdocno_t
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdg_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET INT_FLAG = TRUE 
               CONTINUE DIALOG
            END IF
            LET g_log1 = util.JSON.stringify(g_xmdg_m_t)
            LET g_log2 = util.JSON.stringify(g_xmdg_m)
            IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
               LET INT_FLAG = TRUE 
            END IF
            LET g_xmdgdocno_t = g_xmdg_m.xmdgdocno
            
      END INPUT
      
      BEFORE DIALOG 
         NEXT FIELD xmdg031
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   CALL cl_set_comp_entry("xmdg031",FALSE)

END FUNCTION

################################################################################
# Descriptions...: 計算總額
# Memo...........:
# Usage..........: CALL axmt520_total_count()
# Input parameter: no
# Return code....: no
# Date & Author..: 140930 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_total_count()
DEFINE l_xrcd103    LIKE xrcd_t.xrcd103
DEFINE l_xrcd104    LIKE xrcd_t.xrcd104
DEFINE l_xrcd105    LIKE xrcd_t.xrcd105
DEFINE l_xrcd113    LIKE xrcd_t.xrcd113
DEFINE l_xrcd114    LIKE xrcd_t.xrcd114
DEFINE l_xrcd115    LIKE xrcd_t.xrcd115

   CALL s_tax_recount(g_xmdg_m.xmdgdocno)
        RETURNING l_xrcd103,l_xrcd104,l_xrcd105,
                  l_xrcd113,l_xrcd114,l_xrcd115     
   UPDATE xmdg_t
      SET xmdg050 = l_xrcd103,
          xmdg051 = l_xrcd105,
          xmdg052 = l_xrcd104
    WHERE xmdgent = g_enterprise
      AND xmdgdocno = g_xmdg_m.xmdgdocno
    
   CALL axmt520_adjust_xmdh(l_xrcd103,l_xrcd104,l_xrcd105) #161011-00017#1-add
END FUNCTION

################################################################################
# Descriptions...: 費用料號預帶欄位
# Memo...........:
# Usage..........: CALL axmt520_xmdh006_default()
# Input parameter:
# Return code....: 
# Date & Author..: 141205 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh006_default()
DEFINE l_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_xmdh  RECORD
    xmdh005    LIKE xmdh_t.xmdh005,  #子件特性
    xmdh008    LIKE xmdh_t.xmdh008,  #包裝容器
    xmdh015    LIKE xmdh_t.xmdh015,  #出貨單位
    xmdh018    LIKE xmdh_t.xmdh018,  #參考單位
    xmdh020    LIKE xmdh_t.xmdh020,  #計價單位
    xmdh012    LIKE xmdh_t.xmdh012,  #出貨庫位
    xmdh013    LIKE xmdh_t.xmdh013   #出貨儲位
   ,xmdh023    LIKE xmdh_t.xmdh023   #單價     #170202-00011#1 add
           END RECORD
                
#   IF NOT cl_null(g_xmdh_d[l_ac].xmdh006) THEN   #170106-00020#1 mark
   IF cl_null(g_xmdh_d[l_ac].xmdh006) THEN        #170106-00020#1 mod
      RETURN
   END IF
   
   LET g_xmdh_d[l_ac].xmdh022='N'                 #170106-00020#1 add

   #稅別
   LET g_xmdh4_d[l_ac].xmdh024 = g_xmdg_m.xmdg010
   LET g_xmdh4_d[l_ac].xmdh024_desc = g_xmdg_m.xmdg010_desc
   LET g_xmdh4_d[l_ac].xmdh025 = g_xmdg_m.xmdg011
   #產品特徵
   IF cl_null(g_xmdh_d[l_ac].xmdh007) THEN
      LET g_xmdh_d[l_ac].xmdh007 = ' '
   END IF
   #預帶料件預設值
   CALL s_axmt540_materials_search(g_xmdg_m.xmdg002,g_xmdg_m.xmdg003,g_xmdg_m.xmdg005,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
        RETURNING l_xmdh.xmdh005,l_xmdh.xmdh008,l_xmdh.xmdh015,l_xmdh.xmdh018,l_xmdh.xmdh020,l_xmdh.xmdh012,l_xmdh.xmdh013
#   #子件特性
#   LET g_xmdh_d[l_ac].xmdh005 = l_xmdh.xmdh005
#   LET g_xmdh_d_o.xmdh005 = g_xmdh_d[l_ac].xmdh005
   #包裝容器
   LET g_xmdh_d[l_ac].xmdh008 = l_xmdh.xmdh008
   #出貨單位
   LET g_xmdh_d[l_ac].xmdh015 = l_xmdh.xmdh015
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh015)
        RETURNING g_xmdh_d[l_ac].xmdh015_desc
   #營運據點是否使用參考單位(若不使用為'')
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = "N" THEN
      LET g_xmdh_d[l_ac].xmdh018 = ''
   ELSE
      LET g_xmdh_d[l_ac].xmdh018 = l_xmdh.xmdh018
   END IF
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh018)
        RETURNING g_xmdh_d[l_ac].xmdh018_desc
   #計價單位
   LET g_xmdh_d[l_ac].xmdh020 = l_xmdh.xmdh020
   CALL s_desc_get_unit_desc(g_xmdh_d[l_ac].xmdh020)
        RETURNING g_xmdh_d[l_ac].xmdh020_desc
   #出貨庫位
   LET g_xmdh_d[l_ac].xmdh012 = l_xmdh.xmdh012
   CALL s_desc_get_stock_desc(g_site,g_xmdh_d[l_ac].xmdh012)
        RETURNING g_xmdh_d[l_ac].xmdh012_desc
   #出貨儲位
   LET g_xmdh_d[l_ac].xmdh013 = l_xmdh.xmdh013
   CALL s_desc_get_locator_desc(g_site,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013)
        RETURNING g_xmdh_d[l_ac].xmdh013_desc
   #數量預設為1
   LET g_xmdh_d[l_ac].xmdh016 = 1
   
   #170202-00011#1-(S)-add
   #取得費用料號單價由訂單的預估金額(xmds004)帶入
   SELECT xmds004 INTO l_xmdh.xmdh023
     FROM xmds_t 
    WHERE xmdsent   = g_enterprise
      AND xmdssite  = g_site
      AND xmdsdocno = g_xmdh_d[l_ac].xmdh001
      AND xmds001   = g_xmdh_d[l_ac].xmdh006
      AND rownum = 1  #避免同料,只取一筆
     ORDER BY xmdsseq
        
   LET g_xmdh4_d[l_ac].xmdh023 = l_xmdh.xmdh023
   #170202-00011#1-(E)-add

   CALL axmt520_xmdh016_count(g_xmdh_d[l_ac].xmdhseq,g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh015,
                              g_xmdh_d[l_ac].xmdh016,g_xmdh_d[l_ac].xmdh018,g_xmdh_d[l_ac].xmdh020,
                              g_xmdh_d[l_ac].xmdh022,g_xmdh4_d[l_ac].xmdh023,g_xmdh4_d[l_ac].xmdh024,
                              g_xmdh_d[l_ac].xmdh001)   #150522---earl---add
        RETURNING g_xmdh_d[l_ac].xmdh017,g_xmdh_d[l_ac].xmdh019,g_xmdh_d[l_ac].xmdh021,
                  g_xmdh4_d[l_ac].xmdh026,g_xmdh4_d[l_ac].xmdh027,
                  g_xmdh4_d[l_ac].xmdh028,g_xmdh_d[l_ac].xmdh056

   LET g_xmdh_d_o.* = g_xmdh_d[l_ac].*

END FUNCTION

################################################################################
# Descriptions...: 檢核該訂單分批續是否還有可轉出通量
# Memo...........:
# Usage..........: CALL axmt520_xmdd006_chk(p_xmdh001,p_xmdh002,p_xmdh003,p_xmdh004,p_xmdh006,
#                                           p_xmdh016,p_xmdh016_o,p_xmdc032,p_pmdp023)
#                : RETURNING
# Input parameter: p_xmdh001   單號
#                : p_xmdh002   項次
#                : p_xmdh003   項序
#                : p_xmdh004   分批序
#                : p_xmdh006   料件編號
#                : p_xmdh016   本次登打出通量
#                : p_xmdh016_o 修改前
#                : p_xmdc032   取貨方式
#                : p_pmdp023   需求數量
# Return code....: 
# Date & Author..: 140312 By whitney
# Modify.........: 141216-00003#1 打出通未確認的量，調整成不可大於訂單量 - 已轉出通量即可
#                  2016/12/15 by lori 新增參數p_xmdc032,p_pmdp023,限axmt520_gen_xmdh()傳入值,其他則傳空值
################################################################################
PRIVATE FUNCTION axmt520_xmdd006_chk(p_xmdh001,p_xmdh002,p_xmdh003,p_xmdh004,p_xmdh006,p_xmdh016,p_xmdh016_o,p_xmdc032,p_pmdp023)
DEFINE p_xmdh001    LIKE xmdh_t.xmdh001
DEFINE p_xmdh002    LIKE xmdh_t.xmdh002
DEFINE p_xmdh003    LIKE xmdh_t.xmdh003
DEFINE p_xmdh004    LIKE xmdh_t.xmdh004
DEFINE p_xmdh006    LIKE xmdh_t.xmdh006
DEFINE p_xmdh016    LIKE xmdh_t.xmdh016
DEFINE p_xmdh016_o  LIKE xmdh_t.xmdh016
DEFINE p_xmdc032    LIKE xmdc_t.xmdc032   #161205-00025#9 161215 by lori add
DEFINE p_pmdp023    LIKE pmdp_t.pmdp023   #161205-00025#9 161215 by lori add
DEFINE l_xmdh016    LIKE xmdh_t.xmdh016
DEFINE l_xmdd006    LIKE xmdd_t.xmdd006
DEFINE l_xmdd016    LIKE xmdd_t.xmdd016
DEFINE l_xmdd031    LIKE xmdd_t.xmdd031
DEFINE l_imaf128    LIKE imaf_t.imaf128
DEFINE l_xmdc032    LIKE xmdc_t.xmdc032   #160219-00003#1 add
DEFINE l_pmdp023    LIKE pmdp_t.pmdp023   #160219-00003#1 add

   LET g_errno = ''

   #訂單號、項次、項序、分批序且均有值時做檢核
   IF cl_null(p_xmdh001) OR cl_null(p_xmdh002) OR
      cl_null(p_xmdh003) OR cl_null(p_xmdh004) THEN
      RETURN
   END IF

   IF cl_null(p_xmdh016) THEN LET p_xmdh016 = 0 END IF
   IF cl_null(p_xmdh016_o) THEN LET p_xmdh016_o = 0 END IF

   LET l_xmdd006 = 0
   LET l_xmdd016 = 0
   LET l_xmdd031 = 0
   
   #161205-00025#9 161215 by lori mod---(S)
   #效能調整
   #SELECT NVL(xmdd006,0),NVL(xmdd016,0),NVL(xmdd031,0) INTO l_xmdd006,l_xmdd016,l_xmdd031
   #  FROM xmda_t,xmdd_t
   # WHERE xmddent = g_enterprise
   #  #AND xmddsite = g_site
   #   AND xmdddocno = p_xmdh001
   #   AND xmddseq = p_xmdh002
   #   AND xmddseq1 = p_xmdh003
   #   AND xmddseq2 = p_xmdh004
   #   AND xmdastus <> 'X'
   #   AND xmdadocno = xmdddocno
   #   AND xmdaent = xmddent
   SELECT xmdd006,xmdd016,xmdd031 INTO l_xmdd006,l_xmdd016,l_xmdd031
     FROM xmdd_t
    WHERE xmddent = g_enterprise
      AND xmdddocno = p_xmdh001
      AND xmddseq = p_xmdh002
      AND xmddseq1 = p_xmdh003
      AND xmddseq2 = p_xmdh004
      AND EXISTS(SELECT 1 FROM xmda_t WHERE xmdaent = xmddent AND xmdadocno = xmdddocno AND xmdastus <> 'X')
    
   IF cl_null(l_xmdd006) THEN    LET l_xmdd006 = 0     END IF
   IF cl_null(l_xmdd016) THEN    LET l_xmdd016 = 0     END IF
   IF cl_null(l_xmdd031) THEN    LET l_xmdd031 = 0     END IF   
   #161205-00025#9 161215 by lori mod---(E)
   
   LET l_imaf128 = ''
   SELECT imaf128 INTO l_imaf128
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_xmdh006
   IF NOT cl_null(l_imaf128) AND l_imaf128 > 0 THEN
      LET l_xmdd006 = l_xmdd006 * (100+l_imaf128) / 100
   END IF

#   SELECT SUM(xmdh016) INTO l_xmdh016
#     FROM xmdh_t,xmdg_t
#    WHERE xmdhent = g_enterprise
#      AND xmdhsite = g_site
#      AND xmdh001 = p_xmdh001
#      AND xmdh002 = p_xmdh002
#      AND xmdh003 = p_xmdh003
#      AND xmdh004 = p_xmdh004
#      AND xmdgent = xmdhent 
#      AND xmdgsite =xmdhsite
#      AND xmdgdocno = xmdhdocno
#      AND xmdgstus = 'N'
#   IF cl_null(l_xmdh016) THEN LET l_xmdh016 = 0 END IF
#   
#   #可轉出通量 = 分批訂購數量 - 已轉出通數量 + 銷退換貨數量 - 該確認單據已登打出通未確認的出通量
#   IF (l_xmdd006 - l_xmdd031 + l_xmdd016 - l_xmdh016) < 0 THEN
#      LET g_errno = 'axm-00157'
#   END IF
    #--160219-00003#1--add--(S)
   
   #161205-00025#9 161215 by lori add---(S)
   IF NOT cl_null(p_xmdc032) AND NOT cl_null(p_pmdp023) THEN   
      LET l_xmdc032 = p_xmdc032
      LET l_pmdp023 = p_pmdp023
   ELSE
   #161205-00025#9 161215 by lori add---(E)
      CALL s_axmt540_get_xmdc032(p_xmdh001,p_xmdh002,p_xmdh003,p_xmdh004) RETURNING l_xmdc032,l_pmdp023
   END IF   #161205-00025#9 161215 by lori add
   IF l_xmdc032 = '3' THEN
      LET l_xmdh016 = l_pmdp023 - l_xmdd031 + l_xmdd016 - p_xmdh016 + p_xmdh016_o
      IF l_xmdh016 < 0 OR (l_xmdh016 = 0 AND p_xmdh016 = 0) THEN
         LET g_errno = 'axm-00753'   #訂單單身取貨方式為「供應商直送」，出通/出貨數量不足採購單已確認之需求量
      END IF
   ELSE
    #--160219-00003#1--add--(E)
      LET l_xmdh016 = l_xmdd006 - l_xmdd031 + l_xmdd016 - p_xmdh016 + p_xmdh016_o
      IF l_xmdh016 < 0 OR (l_xmdh016 = 0 AND p_xmdh016 = 0) THEN
         LET g_errno = 'axm-00157'
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 回寫訂單的已轉出通量
# Memo...........:
# Usage..........: CALL axmt520_upd_xmdd031(p_xmdh001,p_xmdh001_o,p_xmdh002,p_xmdh002_o,
#                                           p_xmdh003,p_xmdh003_o,p_xmdh004,p_xmdh004_o,
#                                           p_xmdh016,p_xmdh016_o)
#                : RETURNING r_success
# Input parameter: p_xmdh001   訂單單號
#                : p_xmdh001_o 修改前訂單單號
#                : p_xmdh002   項次
#                : p_xmdh002_o 修改前項次
#                : p_xmdh003   項序
#                : p_xmdh003_o 修改前項序
#                : p_xmdh004   分批序
#                : p_xmdh004_o 修改前分批序
#                : p_xmdh016   本次登打出通量
#                : p_xmdh016_o 修改前出通量
# Return code....: r_success   處理狀態
# Date & Author..: 140408 By whitney
# Modify.........: 160324-00021#1 By Sarah  訂單單號、項次、項序、分批序也應該考慮修改前後不同時回寫訂單的狀況
################################################################################
PRIVATE FUNCTION axmt520_upd_xmdd031(p_xmdh001,p_xmdh001_o,p_xmdh002,p_xmdh002_o,p_xmdh003,p_xmdh003_o,p_xmdh004,p_xmdh004_o,p_xmdh016,p_xmdh016_o)
DEFINE p_xmdh001   LIKE xmdh_t.xmdh001
DEFINE p_xmdh001_o LIKE xmdh_t.xmdh001  #160324-00021#1 add
DEFINE p_xmdh002   LIKE xmdh_t.xmdh002
DEFINE p_xmdh002_o LIKE xmdh_t.xmdh002  #160324-00021#1 add
DEFINE p_xmdh003   LIKE xmdh_t.xmdh003
DEFINE p_xmdh003_o LIKE xmdh_t.xmdh003  #160324-00021#1 add
DEFINE p_xmdh004   LIKE xmdh_t.xmdh004
DEFINE p_xmdh004_o LIKE xmdh_t.xmdh004  #160324-00021#1 add
DEFINE p_xmdh016   LIKE xmdh_t.xmdh016
DEFINE p_xmdh016_o LIKE xmdh_t.xmdh016
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE

   #訂單號、項次、項序、分批序且均有值時做檢核
   IF cl_null(p_xmdh001) OR cl_null(p_xmdh002) OR
      cl_null(p_xmdh003) OR cl_null(p_xmdh004) THEN
     #RETURN                #161124-00053#1 mark
     RETURN r_success       #161124-00053#1 add 
   END IF

   IF cl_null(p_xmdh016) THEN LET p_xmdh016 = 0 END IF
   IF cl_null(p_xmdh016_o) THEN LET p_xmdh016_o = 0 END IF

#160324-00021#1 mark str
#   UPDATE xmdd_t
#      SET xmdd031 = COALESCE(xmdd031,0) + p_xmdh016 - p_xmdh016_o 
#    WHERE xmddent = g_enterprise
#      AND xmddsite = g_site
#      AND xmdddocno = p_xmdh001
#      AND xmddseq = p_xmdh002
#      AND xmddseq1 = p_xmdh003
#      AND xmddseq2 = p_xmdh004
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "upd xmdd_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      LET r_success = FALSE
#   END IF
#160324-00021#1 mark end

#160324-00021#1 add str
   #若訂單單號、項次、項序、分批序有舊值，且修改前、修改後值有不同，
   #則針對修改前的訂單單號、項次、項序、分批序的已轉出通量做更新
   IF NOT cl_null(p_xmdh001_o) AND NOT cl_null(p_xmdh002_o) AND
      NOT cl_null(p_xmdh003_o) AND NOT cl_null(p_xmdh004_o) THEN      
      UPDATE xmdd_t
         SET xmdd031 = COALESCE(xmdd031,0) - p_xmdh016_o
       WHERE xmddent = g_enterprise
         AND xmddsite = g_site
         AND xmdddocno = p_xmdh001_o
         AND xmddseq = p_xmdh002_o
         AND xmddseq1 = p_xmdh003_o
         AND xmddseq2 = p_xmdh004_o
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd xmdd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF

   #針對修改後的訂單單號、項次、項序、分批序的已轉出通量做更新
   UPDATE xmdd_t
      SET xmdd031 = COALESCE(xmdd031,0) + p_xmdh016
    WHERE xmddent = g_enterprise
      AND xmddsite = g_site
      AND xmdddocno = p_xmdh001
      AND xmddseq = p_xmdh002
      AND xmddseq1 = p_xmdh003
      AND xmddseq2 = p_xmdh004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd xmdd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
#160324-00021#1 add end

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 數量異動後其他欄位對應的調整
# Memo...........:
# Usage..........: CALL axmt520_xmdh016_count(p_xmdhseq,p_xmdh006,p_xmdh015,p_xmdh016,p_xmdh018,p_xmdh020,p_xmdh022,p_xmdh023,p_xmdh024,p_xmdh001)
#                  RETURNING r_xmdh017,r_xmdh019,r_xmdh021,r_xmdh026,r_xmdh027,r_xmdh028,r_xmdh056
# Input parameter: 
# Return code....: 
# Date & Author..: 150520 By whitney
# Modify.........: 150522 By Earl加上p_xmdh001用來判斷訂單單據別參數
################################################################################
PRIVATE FUNCTION axmt520_xmdh016_count(p_xmdhseq,p_xmdh006,p_xmdh015,p_xmdh016,p_xmdh018,p_xmdh020,p_xmdh022,p_xmdh023,p_xmdh024,p_xmdh001)
DEFINE p_xmdhseq    LIKE xmdh_t.xmdhseq
DEFINE p_xmdh006    LIKE xmdh_t.xmdh006
DEFINE p_xmdh015    LIKE xmdh_t.xmdh015
DEFINE p_xmdh016    LIKE xmdh_t.xmdh016
DEFINE p_xmdh018    LIKE xmdh_t.xmdh018
DEFINE p_xmdh020    LIKE xmdh_t.xmdh020
DEFINE p_xmdh022    LIKE xmdh_t.xmdh022
DEFINE p_xmdh023    LIKE xmdh_t.xmdh023
DEFINE p_xmdh024    LIKE xmdh_t.xmdh024
DEFINE p_xmdh001    LIKE xmdh_t.xmdh001    #150522---earl---add
DEFINE r_xmdh017    LIKE xmdh_t.xmdh017
DEFINE r_xmdh019    LIKE xmdh_t.xmdh019
DEFINE r_xmdh021    LIKE xmdh_t.xmdh021
DEFINE r_xmdh026    LIKE xmdh_t.xmdh026
DEFINE r_xmdh027    LIKE xmdh_t.xmdh027
DEFINE r_xmdh028    LIKE xmdh_t.xmdh028
DEFINE r_xmdh056    LIKE xmdh_t.xmdh056
DEFINE l_success    LIKE type_t.num5
DEFINE l_slip       LIKE ooba_t.ooba002    #150522---earl---add

   LET r_xmdh017 = 0
   LET r_xmdh019 = 0
   LET r_xmdh021 = 0
   LET r_xmdh026 = 0
   LET r_xmdh027 = 0
   LET r_xmdh028 = 0
   LET r_xmdh056 = 0
   
   #對出貨數量進行取位
   IF NOT cl_null(p_xmdh015) THEN
      CALL s_aooi250_take_decimals(p_xmdh015,p_xmdh016)
           RETURNING l_success,p_xmdh016
   END IF
   
   #申請出通數量值預設給實際出通量
   LET r_xmdh017 = p_xmdh016

#150522---earl---mod---s
   #預設檢驗合格量
   IF p_xmdh022 = 'Y' AND NOT cl_null(p_xmdh001) THEN
      #單據別參數
      CALL s_aooi200_get_slip(p_xmdh001) RETURNING l_success,l_slip
      IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094') = '1' THEN   #OQC檢驗時機為"1出貨通知時檢驗"
         LET r_xmdh056 = 0
      ELSE
         LET r_xmdh056 = p_xmdh016
      END IF
   ELSE
      LET r_xmdh056 = p_xmdh016
   END IF
#150522---earl---mod---e

   IF cl_null(p_xmdh006) THEN
      RETURN r_xmdh017,r_xmdh019,r_xmdh021,r_xmdh026,r_xmdh027,r_xmdh028,r_xmdh056
   END IF
   
   #若料號有設置使用參考單位時且出貨單位與參考單位有設置換算率時，則應自動推算參考數量
   IF NOT cl_null(p_xmdh018) THEN
      #161205-00025#9 161215 by lori add---(S)
      IF p_xmdh015 = p_xmdh018 THEN
         LET r_xmdh019 = p_xmdh016
      ELSE
      #161205-00025#9 161215 by lori add---(E)
         CALL s_aooi250_convert_qty(p_xmdh006,p_xmdh015,p_xmdh018,p_xmdh016)
              RETURNING l_success,r_xmdh019
      END IF   #161205-00025#9 161215 by lori add
   END IF
   #若料號有使用銷售計價單位時，則輸入[C:出貨數量]時則應自動推算計價數量
   IF NOT cl_null(p_xmdh020) THEN
      #161205-00025#9 161215 by lori add---(S)
      IF p_xmdh015 = p_xmdh020 THEN
         LET r_xmdh021 = p_xmdh016
      ELSE
      #161205-00025#9 161215 by lori add---(E)   
         CALL s_aooi250_convert_qty(p_xmdh006,p_xmdh015,p_xmdh020,p_xmdh016)
              RETURNING l_success,r_xmdh021
         #重新計算未稅金額、含稅金額、稅額
      END IF   #161205-00025#9 161215 by lori add
      
      CALL axmt520_get_amount(p_xmdhseq,r_xmdh021,p_xmdh023,p_xmdh024)
           RETURNING r_xmdh026,r_xmdh028,r_xmdh027
   END IF

   RETURN r_xmdh017,r_xmdh019,r_xmdh021,r_xmdh026,r_xmdh027,r_xmdh028,r_xmdh056
END FUNCTION

################################################################################
# Descriptions...: 嘜頭編號说明
# Memo...........:
# Usage..........: CALL axmt520_xmdg023_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 150609 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdg023_ref()

   LET g_xmdg_m.xmdg023_desc = ''
   
   IF cl_null(g_xmdg_m.xmdg005) OR cl_null(g_xmdg_m.xmdg023) THEN
      RETURN
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdg_m.xmdg005
   LET g_ref_fields[2] = g_xmdg_m.xmdg023
   CALL ap_ref_array2(g_ref_fields,"SELECT xmaol004 FROM xmaol_t WHERE xmaolent='"||g_enterprise||"' AND xmaol001=? AND xmaol002=? AND xmaol003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdg_m.xmdg023_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdg_m.xmdg023_desc

END FUNCTION

################################################################################
# Descriptions...: 调整制造批序号
# Memo...........:
# Usage..........: CALL axmt520_inao(p_type)
#                  RETURNING r_success
# Input parameter: p_type   传入参数变量说明1
# Return code....: r_success   回传参数变量说明1
# Date & Author..: 2015/11/19 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_inao(p_type)
DEFINE p_type      LIKE type_t.chr1,
       r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5   
DEFINE l_xmdh013   LIKE xmdh_t.xmdh013
DEFINE l_xmdh014   LIKE xmdh_t.xmdh014
DEFINE l_cnt       LIKE type_t.num5

   LET r_success = TRUE
   
  #IF s_lot_batch_number(g_xmdh_d[l_ac].xmdh006,g_site) THEN     #160314-00008#1 mark
   IF s_lot_batch_number_1n3(g_xmdh_d[l_ac].xmdh006,g_site) THEN #160314-00008#1 add
      IF p_type = '2' THEN
         CALL s_lot_inao_chk(g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,1,'2',g_site) RETURNING l_success,l_cnt
         IF l_cnt > 0 THEN 
            IF l_success = FALSE THEN 
               LET r_success = FALSE
            ELSE
               #刪除資料                              
               DELETE FROM inao_t 
                WHERE inaoent = g_enterprise 
                  AND inaosite = g_site
                  AND inaodocno = g_xmdg_m.xmdgdocno
                  AND inaoseq = g_xmdh_d[l_ac].xmdhseq
                  AND inaoseq1 = '1'
                  AND inao000 = '2'
                  AND inao013 = '-1'
            END IF                  
         END IF
      END IF
      IF p_type = '1' OR r_success = TRUE THEN
         IF NOT cl_null(g_xmdh_d[l_ac].xmdh006) AND NOT cl_null(g_xmdh_d[l_ac].xmdh016) AND NOT cl_null(g_xmdh_d[l_ac].xmdh012) THEN       
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0048') = 'Y' THEN 
               IF g_xmdh_d[l_ac].xmdh016 > 0 THEN 
                  CALL s_lot_sel('1','2',g_site,g_xmdg_m.xmdgdocno,g_xmdh_d[l_ac].xmdhseq,'1',g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007,g_xmdh_d[l_ac].xmdh029,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013,g_xmdh_d[l_ac].xmdh014,g_xmdh_d[l_ac].xmdh015,g_xmdh_d[l_ac].xmdh016,'-1','axmt520','','','','',0)
                       RETURNING r_success                        
               END IF
            END IF
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 匯率計算基準為'依訂單日匯率'，直接回抓訂單匯率
# Memo...........:
# Usage..........: CALL axmt520_xmda_xmdg015()
#                  RETURNING r_xmdg015
# Input parameter: 
# Return code....: r_xmdg015  匯率
# Date & Author..: 2015/11/19 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmda_xmdg015()
   DEFINE r_xmdg015   LIKE xmdg_t.xmdg015

   LET r_xmdg015 = ''
   IF g_xmdg_m.xmdg033 = '1' AND NOT cl_null(g_xmdg_m.xmdg004) THEN
      SELECT xmda016 INTO r_xmdg015
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_xmdg_m.xmdg004
   END IF
   RETURN r_xmdg015
END FUNCTION

################################################################################
# Descriptions...: 由訂單自動帶出單身
# Memo...........:
# Usage..........: CALL axmt520_auto_insert()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 160329 By earl
# Modify.........: #150720-00006#1  2016/03/29  By earl      補上單頭確認詢問自動帶單身功能
################################################################################
PRIVATE FUNCTION axmt520_auto_insert()
    DEFINE r_success    LIKE type_t.num5
    DEFINE l_cnt        LIKE type_t.num10
    
    LET r_success = TRUE
    
    IF g_ask THEN
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM xmdh_t
        WHERE xmdhent = g_enterprise
          AND xmdhdocno = g_xmdg_m.xmdgdocno
       
       IF cl_null(l_cnt) OR l_cnt = 0 THEN
          IF NOT cl_null(g_xmdg_m.xmdg004) THEN
             IF g_argv[01] = '8' THEN
                IF cl_ask_confirm('axm-00566') THEN   #是否由[借貨訂單axmt501]自動產生單身資料？
                   CALL axmt520_gen_xmdh()  #自動產生單身
                        RETURNING r_success
                ELSE
                   LET g_ask = FALSE  #不二次詢問
                END IF
             ELSE
                IF cl_ask_confirm('axm-00140') THEN   #是否由[訂單axmt500]自動產生單身資料！
                   CALL axmt520_gen_xmdh()  #自動產生單身
                        RETURNING r_success
                ELSE
                   LET g_ask = FALSE  #不二次詢問
                END IF
             END IF
          END IF
       END IF
       
    END IF
    
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 調整金額尾差
# Memo...........:
# Usage..........: CALL axmt520_adjust_xmdh(p_xrcd103,p_xrcd104,p_xrcd105)
# Input parameter: p_xrcd103   原幣未稅金額
#                : p_xrcd104   原幣稅額
#                : p_xrcd105   原幣含稅金額
# Return code....: 
# Date & Author..: 20161013 By dorislai (#161011-00017#1)
# Modify.........
################################################################################
PRIVATE FUNCTION axmt520_adjust_xmdh(p_xrcd103,p_xrcd104,p_xrcd105)
   DEFINE l_xmdh026    LIKE xmdh_t.xmdh026
   DEFINE l_xmdh027    LIKE xmdh_t.xmdh027
   DEFINE l_xmdh028    LIKE xmdh_t.xmdh028
   DEFINE l_xmdhseq    LIKE xmdh_t.xmdhseq
   DEFINE p_xrcd103    LIKE xrcd_t.xrcd103
   DEFINE p_xrcd104    LIKE xrcd_t.xrcd104
   DEFINE p_xrcd105    LIKE xrcd_t.xrcd105

   
   LET l_xmdh026 = 0
   LET l_xmdh027 = 0
   LET l_xmdh028 = 0
   LET l_xmdhseq = ''
   
   #抓取出貨總金額(未稅、含稅、稅額)
   SELECT SUM(xmdh026),SUM(xmdh027),SUM(xmdh028)
     INTO l_xmdh026,l_xmdh027,l_xmdh028
     FROM xmdh_t
    WHERE xmdhent = g_enterprise
      AND xmdhsite = g_site
      AND xmdhdocno = g_xmdg_m.xmdgdocno
      
   #調整金額(未稅、含稅、稅額)
   IF p_xrcd103 <> l_xmdh026 OR p_xrcd104 <> l_xmdh027 OR p_xrcd105 <> l_xmdh028 THEN
      #抓取最大筆金額的項次
      SELECT xmdhseq INTO l_xmdhseq
        FROM xmdh_t
       WHERE xmdhent = g_enterprise
         AND xmdhsite = g_site
         AND xmdhdocno = g_xmdg_m.xmdgdocno
       ORDER BY xmdh026 DESC
     #補尾差
     UPDATE xmdh_t SET xmdh026 = xmdh026 + (p_xrcd103-l_xmdh026),
                       xmdh027 = xmdh027 + (p_xrcd105-l_xmdh027),
                       xmdh028 = xmdh028 + (p_xrcd104-l_xmdh028)
       WHERE xmdhent = g_enterprise
         AND xmdhsite = g_site
         AND xmdhdocno = g_xmdg_m.xmdgdocno
         AND xmdhseq = l_xmdhseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE xmdh_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 一次性交易對象說明
# Memo...........:
# Usage..........: axmt520_get_pmak003(p_type,p_docno)
# Input parameter: p_type         類型：1.訂單 2.出通單
#                : p_docno        單號
# Return code....: 
# Date & Author..: 2016/12/28 By dorislai(#161207-00033#35)
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_get_pmak003(p_type,p_docno)
   DEFINE  p_type     LIKE  type_t.num5
   DEFINE  p_docno    LIKE  xmdg_t.xmdgdocno
   DEFINE  l_pmak003  LIKE  pmak_t.pmak003
   
   CALL s_desc_axm_get_oneturn_guest_desc(p_type,p_docno)
     RETURNING l_pmak003
   IF NOT cl_null(l_pmak003) THEN
      LET g_xmdg_m.xmdg005_desc = l_pmak003
      #帳款客戶
      IF g_xmdg_m.xmdg006 = g_xmdg_m.xmdg005 THEN   
         LET g_xmdg_m.xmdg006_desc = g_xmdg_m.xmdg005_desc
      END IF
      #收貨客戶
      IF g_xmdg_m.xmdg007 = g_xmdg_m.xmdg005 THEN   
         LET g_xmdg_m.xmdg007_desc = g_xmdg_m.xmdg005_desc
      END IF
      #發票客戶
      IF g_xmdg_m.xmdg202 = g_xmdg_m.xmdg005 THEN   
         LET g_xmdg_m.xmdg202_desc = g_xmdg_m.xmdg005_desc
      END IF
      #送貨供應商
      IF g_xmdg_m.xmdg016 = g_xmdg_m.xmdg005 THEN   
         LET g_xmdg_m.xmdg016_desc = g_xmdg_m.xmdg005_desc
      END IF
      DISPLAY BY NAME g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006_desc,g_xmdg_m.xmdg007_desc,
                      g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg016_desc
   END IF
END FUNCTION
################################################################################
# Descriptions...: 庫、儲、批、庫存管理特徵，輸入開窗
# Memo...........:
# Usage..........: CALL axmt520_xmdh012_xmdh013_xmdh014_xmdh029_qry(p_type)
#                  
# Input parameter: p_type 1.庫位2.儲位3.批號4.庫存管理特徵
#                : 
# Return code....: 
#                : 
# Date & Author..: #170117-00047#1 add By catmoon47
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt520_xmdh012_xmdh013_xmdh014_xmdh029_qry(p_type)
   DEFINE p_type            LIKE type_t.chr1
   DEFINE l_success         LIKE type_t.num5  #150921-00014 earl add
   DEFINE l_where           STRING            #150921-00014 earl add
   DEFINE l_imaf054         LIKE imaf_t.imaf054   #20151106 by stellar add
   DEFINE l_imaf055     LIKE imaf_t.imaf055  #160519-00008#8
   DEFINE l_imaf061     LIKE imaf_t.imaf061  #160519-00008#8
 
   #開窗i段
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'i'
   LET g_qryparam.reqry = FALSE
   
   LET g_qryparam.default1 = g_xmdh_d[l_ac].xmdh012             #給予default值
   LET g_qryparam.default2 = g_xmdh_d[l_ac].xmdh013
   LET g_qryparam.default3 = g_xmdh_d[l_ac].xmdh014
   LET g_qryparam.default4 = g_xmdh_d[l_ac].xmdh029
   
   #給予arg
   LET g_qryparam.arg1 = g_xmdh_d[l_ac].xmdh006
   LET g_qryparam.arg2 = g_xmdh_d[l_ac].xmdh007
   
   #stellar modify:使用單一單位時，不限制只能是該單位的倉儲批
   LET g_qryparam.where = "inag007 = '",g_xmdh_d[l_ac].xmdh015,"'"
   LET l_imaf054 = ''
   SELECT imaf054 INTO l_imaf054
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = g_xmdh_d[l_ac].xmdh006
   IF l_imaf054 = 'Y' THEN
      LET g_qryparam.where = "inag007 = '",g_xmdh_d[l_ac].xmdh015,"'"
   ELSE
      LET g_qryparam.where = " 1=1"
   END IF
 
   #單據別庫位限制(From)
   CALL s_control_get_doc_sql('inag004',g_xmdg_m.xmdgdocno,'6') RETURNING l_success,l_where
   IF l_success THEN
      LET g_qryparam.where = g_qryparam.where," AND ",l_where
   END IF
 
   CALL q_inag004_13()
 
   #庫位
   LET g_xmdh_d[l_ac].xmdh012 = g_qryparam.return1
   DISPLAY g_xmdh_d[l_ac].xmdh012 TO xmdh012
   CALL s_desc_get_stock_desc(g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdh012) RETURNING g_xmdh_d[l_ac].xmdh012_desc
   
   #儲位
   LET g_xmdh_d[l_ac].xmdh013 = g_qryparam.return2
   DISPLAY g_xmdh_d[l_ac].xmdh013 TO xmdh013
   CALL s_desc_get_locator_desc(g_xmdh_d[l_ac].xmdhsite,g_xmdh_d[l_ac].xmdh012,g_xmdh_d[l_ac].xmdh013) RETURNING g_xmdh_d[l_ac].xmdh013_desc
   
   #批號      
   LET g_xmdh_d[l_ac].xmdh014 = g_qryparam.return3      
   DISPLAY g_xmdh_d[l_ac].xmdh014 TO xmdh014
   
   #庫存管理特徵
   CALL s_axmt540_get_imaf(g_xmdh_d[l_ac].xmdh006) RETURNING l_imaf055,l_imaf061
   IF l_imaf055 = '1' AND (cl_null(g_qryparam.return3) OR g_qryparam.return3 = ' ') THEN
      LET g_xmdh_d[l_ac].xmdh029 = ''
   ELSE
      LET g_xmdh_d[l_ac].xmdh029 = g_qryparam.return4
   END IF         
   DISPLAY g_xmdh_d[l_ac].xmdh029 TO xmdh029
 

END FUNCTION

################################################################################
#161031-00025#25 add
#維護備註單身
################################################################################
PRIVATE FUNCTION axmt520_remaks()

   IF g_xmdg_m.xmdgdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
       
   CALL s_transaction_begin()
   
   OPEN axmt520_cl USING g_enterprise,g_xmdg_m.xmdgdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmt520_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #鎖住將被更改的資料
   FETCH axmt520_cl INTO g_xmdg_m.xmdgdocno,g_xmdg_m.xmdgdocno_desc,g_xmdg_m.xmdgdocdt,g_xmdg_m.xmdg004,g_xmdg_m.xmdgsite, 
       g_xmdg_m.xmdg002,g_xmdg_m.xmdg002_desc,g_xmdg_m.xmdg003,g_xmdg_m.xmdg003_desc,g_xmdg_m.xmdgstus, 
       g_xmdg_m.xmdg001,g_xmdg_m.xmdg034,g_xmdg_m.xmdg005,g_xmdg_m.xmdg005_desc,g_xmdg_m.xmdg006,g_xmdg_m.xmdg006_desc, 
       g_xmdg_m.xmdg007,g_xmdg_m.xmdg007_desc,g_xmdg_m.xmdg202,g_xmdg_m.xmdg202_desc,g_xmdg_m.xmdg028, 
       g_xmdg_m.xmdg026,g_xmdg_m.xmdg026_desc,g_xmdg_m.xmdg027,g_xmdg_m.xmdg027_desc,g_xmdg_m.xmdg024, 
       g_xmdg_m.xmdg025,g_xmdg_m.xmdg030,g_xmdg_m.xmdg030_desc,g_xmdg_m.xmdg031,g_xmdg_m.xmdg031_desc, 
       g_xmdg_m.xmdg053,g_xmdg_m.xmdg056,g_xmdg_m.xmdg056_desc,g_xmdg_m.xmdg055,g_xmdg_m.xmdg054,g_xmdg_m.xmdg057, 
       g_xmdg_m.xmdg058,g_xmdg_m.xmdg017,g_xmdg_m.xmdg017_desc,g_xmdg_m.textedit1,g_xmdg_m.xmdg018,g_xmdg_m.xmdg018_desc, 
       g_xmdg_m.xmdg019,g_xmdg_m.xmdg019_desc,g_xmdg_m.xmdg020,g_xmdg_m.xmdg020_desc,g_xmdg_m.xmdg016, 
       g_xmdg_m.xmdg016_desc,g_xmdg_m.xmdg021,g_xmdg_m.xmdg022,g_xmdg_m.xmdg023,g_xmdg_m.xmdg023_desc, 
       g_xmdg_m.xmdg008,g_xmdg_m.xmdg008_desc,g_xmdg_m.xmdg009,g_xmdg_m.xmdg009_desc,g_xmdg_m.xmdg010, 
       g_xmdg_m.xmdg010_desc,g_xmdg_m.xmdg011,g_xmdg_m.xmdg012,g_xmdg_m.xmdg013,g_xmdg_m.xmdg013_desc, 
       g_xmdg_m.xmdg032,g_xmdg_m.xmdg033,g_xmdg_m.xmdg014,g_xmdg_m.xmdg014_desc,g_xmdg_m.xmdg015,g_xmdg_m.xmdgownid, 
       g_xmdg_m.xmdgownid_desc,g_xmdg_m.xmdgowndp,g_xmdg_m.xmdgowndp_desc,g_xmdg_m.xmdgcrtid,g_xmdg_m.xmdgcrtid_desc, 
       g_xmdg_m.xmdgcrtdp,g_xmdg_m.xmdgcrtdp_desc,g_xmdg_m.xmdgcrtdt,g_xmdg_m.xmdgmodid,g_xmdg_m.xmdgmodid_desc, 
       g_xmdg_m.xmdgmoddt,g_xmdg_m.xmdgcnfid,g_xmdg_m.xmdgcnfid_desc,g_xmdg_m.xmdgcnfdt
       
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xmdg_m.xmdgdocno
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF
 
   #檢查是否允許此動作
   IF NOT axmt520_action_chk() THEN
      CLOSE axmt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog   
   LET g_ooff003_d = g_xmdg_m.xmdgdocno   #单号  
   LET g_ooff004_d = '0'    #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身
      
      ON ACTION accept  
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄) 
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
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
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
    
   CLOSE axmt520_cl
   
   CALL s_transaction_end('Y','0')
   
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身
   
END FUNCTION

 
{</section>}
 
