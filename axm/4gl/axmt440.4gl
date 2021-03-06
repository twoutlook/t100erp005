#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0028(2017-02-15 17:25:23), PR版次:0028(2017-02-16 19:41:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000588
#+ Filename...: axmt440
#+ Description: 銷售合約單維護作業
#+ Creator....: 02295(2014-01-22 23:06:18)
#+ Modifier...: 08992 -SD/PR- 08992
 
{</section>}
 
{<section id="axmt440.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#5   2015/12/29 By dorishsu 產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160318-00005#49  2016/04/01 by pengxin  修正azzi920重复定义之错误讯息
#160318-00025#17  2016/04/11 By 07900    校验代码的重复错误讯息修改
#160324-00037#9   2016/04/28 By Polly    1.整單操作增加「修改失效日期」，已確認的單據才可執行 
#                                        2.增加「結案」的狀態碼    
#                                        3.整單操作增加「結案/取消結案」 
#160517-00022#1  2016/05/31 By 02295    只能查询出当前据点的资料 
#160711-00005#2  2016/07/21 By 03079    產品特徵控制 
#160812-00017#6  2016/08/19 By 06814    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 
#                                       造成transaction沒有結束就直接RETURN
#160818-00017#43 2016/08/29 By lixh     单据类作业修改，删除时需重新检查状态
#161221-00064#1  2016/12/26 By ouhz     增加pmao0001(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#161221-00064#15 2017/01/10 By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#161031-00025#21 2017/02/02 By 08992    1.將aooi360_01以嵌入的方式，用頁籤放在axmt440單頭多帳期頁籤與異動資訊頁籤中間
#                                         要可修改
#                                         控制類型 =3:內部資訊傳遞 取消不要了
#                                         項次固定寫入0
#                                       2.原axmt440的備註action，改為確認後可執行，直接修改單頭新的"備註"頁籤
#                                       3.axmt440單身最後面增加顯示"長備註"欄位，一樣抓取aooi360的備註顯示
#                                         項次 = 單身項次
#                                         控制類型 = 列印在後
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi360_01   #161031-00025#21
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
#161031-00025#21-s
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
#161031-00025#21-e
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xmdx_m        RECORD
       xmdxdocno LIKE xmdx_t.xmdxdocno, 
   xmdx000 LIKE xmdx_t.xmdx000, 
   xmdxdocno_desc LIKE type_t.chr80, 
   xmdxdocdt LIKE xmdx_t.xmdxdocdt, 
   xmdx004 LIKE xmdx_t.xmdx004, 
   xmdx004_desc LIKE type_t.chr80, 
   xmdx002 LIKE xmdx_t.xmdx002, 
   xmdx002_desc LIKE type_t.chr80, 
   xmdx003 LIKE xmdx_t.xmdx003, 
   xmdx003_desc LIKE type_t.chr80, 
   xmdxstus LIKE xmdx_t.xmdxstus, 
   xmdx005 LIKE xmdx_t.xmdx005, 
   xmdx005_desc LIKE type_t.chr80, 
   xmdx006 LIKE xmdx_t.xmdx006, 
   xmdx006_desc LIKE type_t.chr80, 
   xmdx007 LIKE xmdx_t.xmdx007, 
   xmdx008 LIKE xmdx_t.xmdx008, 
   xmdx009 LIKE xmdx_t.xmdx009, 
   xmdx009_desc LIKE type_t.chr80, 
   xmdx011 LIKE xmdx_t.xmdx011, 
   xmdx011_desc LIKE type_t.chr80, 
   xmdx030 LIKE xmdx_t.xmdx030, 
   xmdx016 LIKE xmdx_t.xmdx016, 
   xmdx017 LIKE xmdx_t.xmdx017, 
   xmdx018 LIKE xmdx_t.xmdx018, 
   xmdx019 LIKE xmdx_t.xmdx019, 
   xmdx020 LIKE xmdx_t.xmdx020, 
   xmdx010 LIKE xmdx_t.xmdx010, 
   xmdx012 LIKE xmdx_t.xmdx012, 
   xmdx001 LIKE xmdx_t.xmdx001, 
   xmdx014 LIKE xmdx_t.xmdx014, 
   xmdx015 LIKE xmdx_t.xmdx015, 
   xmdxsite LIKE xmdx_t.xmdxsite, 
   xmdxownid LIKE xmdx_t.xmdxownid, 
   xmdxownid_desc LIKE type_t.chr80, 
   xmdxowndp LIKE xmdx_t.xmdxowndp, 
   xmdxowndp_desc LIKE type_t.chr80, 
   xmdxcrtid LIKE xmdx_t.xmdxcrtid, 
   xmdxcrtid_desc LIKE type_t.chr80, 
   xmdxcrtdp LIKE xmdx_t.xmdxcrtdp, 
   xmdxcrtdp_desc LIKE type_t.chr80, 
   xmdxcrtdt LIKE xmdx_t.xmdxcrtdt, 
   xmdxmodid LIKE xmdx_t.xmdxmodid, 
   xmdxmodid_desc LIKE type_t.chr80, 
   xmdxmoddt LIKE xmdx_t.xmdxmoddt, 
   xmdxcnfid LIKE xmdx_t.xmdxcnfid, 
   xmdxcnfid_desc LIKE type_t.chr80, 
   xmdxcnfdt LIKE xmdx_t.xmdxcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdy_d        RECORD
       xmdysite LIKE xmdy_t.xmdysite, 
   xmdyseq LIKE xmdy_t.xmdyseq, 
   xmdy002 LIKE xmdy_t.xmdy002, 
   xmdy002_desc LIKE type_t.chr500, 
   xmdy002_desc_desc LIKE type_t.chr500, 
   xmdy003 LIKE xmdy_t.xmdy003, 
   xmdy003_desc LIKE type_t.chr500, 
   xmdy005 LIKE xmdy_t.xmdy005, 
   l_pmao009 LIKE type_t.chr500, 
   l_pmao010 LIKE type_t.chr500, 
   xmdy006 LIKE xmdy_t.xmdy006, 
   xmdy006_desc LIKE type_t.chr500, 
   xmdy007 LIKE xmdy_t.xmdy007, 
   xmdy014 LIKE xmdy_t.xmdy014, 
   xmdy014_desc LIKE type_t.chr500, 
   xmdy008 LIKE xmdy_t.xmdy008, 
   xmdy009 LIKE xmdy_t.xmdy009, 
   xmdy010 LIKE xmdy_t.xmdy010, 
   xmdy024 LIKE xmdy_t.xmdy024, 
   xmdy011 LIKE xmdy_t.xmdy011, 
   xmdy011_desc LIKE type_t.chr500, 
   xmdy012 LIKE xmdy_t.xmdy012, 
   xmdy017 LIKE xmdy_t.xmdy017, 
   xmdy018 LIKE xmdy_t.xmdy018, 
   xmdy019 LIKE xmdy_t.xmdy019, 
   xmdy013 LIKE xmdy_t.xmdy013, 
   xmdy013_desc LIKE type_t.chr500, 
   xmdy004 LIKE xmdy_t.xmdy004, 
   xmdy030 LIKE xmdy_t.xmdy030, 
   xmdy001 LIKE xmdy_t.xmdy001, 
   ooff013 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmdy2_d RECORD
       xmdyseq2 LIKE type_t.num10, 
   xmdy0022 LIKE type_t.chr500, 
   xmdy002_2_desc LIKE type_t.chr500, 
   xmdy002_2_desc1 LIKE type_t.chr500, 
   xmdy0032 LIKE type_t.chr500, 
   xmdy0062 LIKE type_t.chr10, 
   xmdy0072 LIKE type_t.chr10, 
   xmdy0082 LIKE type_t.chr10, 
   xmdy0092 LIKE type_t.num20_6, 
   xmdy0102 LIKE type_t.num20_6, 
   xmdy020 LIKE xmdy_t.xmdy020, 
   xmdy021 LIKE xmdy_t.xmdy021, 
   xmdy022 LIKE xmdy_t.xmdy022, 
   xmdy023 LIKE xmdy_t.xmdy023, 
   xmdy0202 LIKE type_t.num20_6, 
   xmdy0212 LIKE type_t.num20_6, 
   xmdy0222 LIKE type_t.num20_6, 
   xmdy0232 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_xmdy3_d RECORD
       xmdzseq LIKE xmdz_t.xmdzseq, 
   xmdzseq1 LIKE xmdz_t.xmdzseq1, 
   xmdz001 LIKE xmdz_t.xmdz001, 
   xmdz002 LIKE xmdz_t.xmdz002, 
   xmdz003 LIKE xmdz_t.xmdz003, 
   xmdz004 LIKE xmdz_t.xmdz004, 
   xmdz005 LIKE xmdz_t.xmdz005
       END RECORD
PRIVATE TYPE type_g_xmdy4_d RECORD
       xmdw003 LIKE type_t.dat, 
   xmdw004 LIKE type_t.num20_6, 
   xmdw005 LIKE type_t.num20_6, 
   xmdw006 LIKE type_t.num20_6, 
   xmdw007 LIKE type_t.num20_6, 
   xmdw008 LIKE type_t.num20_6, 
   xmdw009 LIKE type_t.num20_6, 
   xmdw010 LIKE type_t.num20_6, 
   xmdw011 LIKE type_t.num20_6, 
   xmdw012 LIKE type_t.chr20, 
   xmdw012_desc LIKE type_t.chr500, 
   xmdw013 LIKE type_t.chr10, 
   xmdw013_desc LIKE type_t.chr500, 
   xmdwsite LIKE type_t.chr10, 
   xmdw001 LIKE type_t.chr20, 
   xmdw002 LIKE type_t.num10
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xmdxdocno LIKE xmdx_t.xmdxdocno,
   b_xmdxdocno_desc LIKE type_t.chr80,
      b_xmdxdocdt LIKE xmdx_t.xmdxdocdt,
      b_xmdx002 LIKE xmdx_t.xmdx002,
   b_xmdx002_desc LIKE type_t.chr80,
      b_xmdx003 LIKE xmdx_t.xmdx003,
   b_xmdx003_desc LIKE type_t.chr80,
      b_xmdx004 LIKE xmdx_t.xmdx004,
   b_xmdx004_desc LIKE type_t.chr80,
      b_xmdx005 LIKE xmdx_t.xmdx005,
   b_xmdx005_desc LIKE type_t.chr80,
      b_xmdx014 LIKE xmdx_t.xmdx014,
      b_xmdx015 LIKE xmdx_t.xmdx015
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#161109-00085#6-mod-s
#DEFINE g_ooef                RECORD LIKE ooef_t.*   #161109-00085#6   mark
DEFINE g_ooef                RECORD  #組織基本資料檔
       ooefent LIKE ooef_t.ooefent, #企業編號
       ooefstus LIKE ooef_t.ooefstus, #狀態碼
       ooef001 LIKE ooef_t.ooef001, #組織編號
       ooef002 LIKE ooef_t.ooef002, #統一編號
       ooef004 LIKE ooef_t.ooef004, #單據別參照表號
       ooef005 LIKE ooef_t.ooef005, #單據據點編號
       ooef006 LIKE ooef_t.ooef006, #所屬國家地區
       ooef007 LIKE ooef_t.ooef007, #上市櫃公司編號
       ooef008 LIKE ooef_t.ooef008, #行事曆參照表號
       ooef009 LIKE ooef_t.ooef009, #製造行事曆對應類別
       ooef010 LIKE ooef_t.ooef010, #辦公行事曆對應類別
       ooef011 LIKE ooef_t.ooef011, #專屬國家地區功能
       ooef012 LIKE ooef_t.ooef012, #聯絡對象識別碼
       ooef013 LIKE ooef_t.ooef013, #日期顯示格式
       ooefownid LIKE ooef_t.ooefownid, #資料所有者
       ooefowndp LIKE ooef_t.ooefowndp, #資料所有部門
       ooefcrtid LIKE ooef_t.ooefcrtid, #資料建立者
       ooefcrtdp LIKE ooef_t.ooefcrtdp, #資料建立部門
       ooefcrtdt LIKE ooef_t.ooefcrtdt, #資料創建日
       ooefmodid LIKE ooef_t.ooefmodid, #資料修改者
       ooefmoddt LIKE ooef_t.ooefmoddt, #最近修改日
       ooef014 LIKE ooef_t.ooef014, #幣別參照表號
       ooef015 LIKE ooef_t.ooef015, #匯率參照表號
       ooef016 LIKE ooef_t.ooef016, #主幣別編號
       ooef017 LIKE ooef_t.ooef017, #法人歸屬
       ooef018 LIKE ooef_t.ooef018, #時區
       ooef019 LIKE ooef_t.ooef019, #稅區
       ooef020 LIKE ooef_t.ooef020, #工商登記號
       ooef021 LIKE ooef_t.ooef021, #法人代表
       ooef022 LIKE ooef_t.ooef022, #註冊資本
       ooef003 LIKE ooef_t.ooef003, #法人否
       ooef023 LIKE ooef_t.ooef023, #數字/金額顯示格式
       ooef024 LIKE ooef_t.ooef024, #據點對應客戶/供應商編號
       ooef025 LIKE ooef_t.ooef025, #品管參照表號
       ooef026 LIKE ooef_t.ooef026, #預設存款銀行帳戶
       ooef100 LIKE ooef_t.ooef100, #門店狀態
       ooef101 LIKE ooef_t.ooef101, #層級類型
       ooef102 LIKE ooef_t.ooef102, #業態
       ooef103 LIKE ooef_t.ooef103, #渠道
       ooef104 LIKE ooef_t.ooef104, #商圈
       ooef105 LIKE ooef_t.ooef105, #可比店
       ooef106 LIKE ooef_t.ooef106, #價格參考標準
       ooef107 LIKE ooef_t.ooef107, #店慶會計期
       ooef108 LIKE ooef_t.ooef108, #散客編號
       ooef109 LIKE ooef_t.ooef109, #開業日期
       ooef110 LIKE ooef_t.ooef110, #閉店日期
       ooef111 LIKE ooef_t.ooef111, #測量面積
       ooef112 LIKE ooef_t.ooef112, #建築面積
       ooef113 LIKE ooef_t.ooef113, #經營面積
       ooef114 LIKE ooef_t.ooef114, #合作對象總數
       ooef115 LIKE ooef_t.ooef115, #24小時營業否
       ooef120 LIKE ooef_t.ooef120, #本店取貨訂定比例
       ooef121 LIKE ooef_t.ooef121, #異店取貨訂定比例
       ooef122 LIKE ooef_t.ooef122, #總部配送訂定比例
       ooef123 LIKE ooef_t.ooef123, #預設收貨成本倉
       ooef124 LIKE ooef_t.ooef124, #預設出貨成本倉
       ooef125 LIKE ooef_t.ooef125, #預設在途成本倉
       ooef150 LIKE ooef_t.ooef150, #門店類別
       ooef151 LIKE ooef_t.ooef151, #規模類別
       ooef152 LIKE ooef_t.ooef152, #門店週期
       ooef153 LIKE ooef_t.ooef153, #銷售區域
       ooef154 LIKE ooef_t.ooef154, #銷售省區
       ooef155 LIKE ooef_t.ooef155, #銷售地區
       ooef156 LIKE ooef_t.ooef156, #銷售片區
       ooef157 LIKE ooef_t.ooef157, #其他屬性1
       ooef158 LIKE ooef_t.ooef158, #其他屬性2
       ooef159 LIKE ooef_t.ooef159, #其他屬性3
       ooef160 LIKE ooef_t.ooef160, #其他屬性4
       ooef161 LIKE ooef_t.ooef161, #其他屬性5
       ooef162 LIKE ooef_t.ooef162, #其他屬性6
       ooef163 LIKE ooef_t.ooef163, #其他屬性7
       ooef164 LIKE ooef_t.ooef164, #其他屬性8
       ooef165 LIKE ooef_t.ooef165, #其他屬性9
       ooef166 LIKE ooef_t.ooef166, #其他屬性10
       ooef167 LIKE ooef_t.ooef167, #其他屬性11
       ooef168 LIKE ooef_t.ooef168, #其他屬性12
       ooef169 LIKE ooef_t.ooef169, #其他屬性13
       ooef170 LIKE ooef_t.ooef170, #其他屬性14
       ooef171 LIKE ooef_t.ooef171, #其他屬性15
       ooef172 LIKE ooef_t.ooef172, #其他屬性16
       ooef173 LIKE ooef_t.ooef173, #其他屬性17
       ooefunit LIKE ooef_t.ooefunit, #應用組織
       ooef200 LIKE ooef_t.ooef200, #分群編號
       ooef201 LIKE ooef_t.ooef201, #營運據點
       ooef202 LIKE ooef_t.ooef202, #預測組織
       ooef203 LIKE ooef_t.ooef203, #部門組織
       ooef204 LIKE ooef_t.ooef204, #核算組織
       ooef205 LIKE ooef_t.ooef205, #預算組織
       ooef206 LIKE ooef_t.ooef206, #資金組織
       ooef207 LIKE ooef_t.ooef207, #資產組織
       ooef208 LIKE ooef_t.ooef208, #銷售組織
       ooef209 LIKE ooef_t.ooef209, #銷售範圍
       ooef210 LIKE ooef_t.ooef210, #採購組織
       ooef211 LIKE ooef_t.ooef211, #物流組織
       ooef212 LIKE ooef_t.ooef212, #結算組織
       ooef213 LIKE ooef_t.ooef213, #nouse
       ooef214 LIKE ooef_t.ooef214, #nouse
       ooef215 LIKE ooef_t.ooef215, #nouse
       ooef216 LIKE ooef_t.ooef216, #nouse
       ooef217 LIKE ooef_t.ooef217, #nouse
       ooef301 LIKE ooef_t.ooef301, #營銷中心
       ooef302 LIKE ooef_t.ooef302, #配送中心
       ooef303 LIKE ooef_t.ooef303, #採購中心
       ooef304 LIKE ooef_t.ooef304, #門店
       ooef305 LIKE ooef_t.ooef305, #辦事處
       ooef306 LIKE ooef_t.ooef306, #nouse
       ooef307 LIKE ooef_t.ooef307, #nouse
       ooef308 LIKE ooef_t.ooef308, #nouse
       ooef309 LIKE ooef_t.ooef309, #nouse
       ooef310 LIKE ooef_t.ooef310, #nouse
       ooef126 LIKE ooef_t.ooef126, #預設收貨非成本倉
       ooef127 LIKE ooef_t.ooef127, #預設出貨非成本倉
       ooef128 LIKE ooef_t.ooef128, #預設在途非成本倉
       ooef116 LIKE ooef_t.ooef116 #語言別
          END RECORD
#161109-00085#6-mod-e
DEFINE g_tax_app             LIKE oodb_t.oodb011
DEFINE g_pmab089             LIKE pmab_t.pmab089
DEFINE g_xmdx004_o           LIKE xmdx_t.xmdx004
DEFINE g_xmdx005_o           LIKE xmdx_t.xmdx005
DEFINE g_xmdx006_o           LIKE xmdx_t.xmdx006
DEFINE g_pmao_flag           LIKE type_t.chr1
DEFINE g_detail_id          STRING           #紀錄停留在哪個Page #161031-00025#21 add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmdx_m          type_g_xmdx_m
DEFINE g_xmdx_m_t        type_g_xmdx_m
DEFINE g_xmdx_m_o        type_g_xmdx_m
DEFINE g_xmdx_m_mask_o   type_g_xmdx_m #轉換遮罩前資料
DEFINE g_xmdx_m_mask_n   type_g_xmdx_m #轉換遮罩後資料
 
   DEFINE g_xmdxdocno_t LIKE xmdx_t.xmdxdocno
 
 
DEFINE g_xmdy_d          DYNAMIC ARRAY OF type_g_xmdy_d
DEFINE g_xmdy_d_t        type_g_xmdy_d
DEFINE g_xmdy_d_o        type_g_xmdy_d
DEFINE g_xmdy_d_mask_o   DYNAMIC ARRAY OF type_g_xmdy_d #轉換遮罩前資料
DEFINE g_xmdy_d_mask_n   DYNAMIC ARRAY OF type_g_xmdy_d #轉換遮罩後資料
DEFINE g_xmdy2_d          DYNAMIC ARRAY OF type_g_xmdy2_d
DEFINE g_xmdy2_d_t        type_g_xmdy2_d
DEFINE g_xmdy2_d_o        type_g_xmdy2_d
DEFINE g_xmdy2_d_mask_o   DYNAMIC ARRAY OF type_g_xmdy2_d #轉換遮罩前資料
DEFINE g_xmdy2_d_mask_n   DYNAMIC ARRAY OF type_g_xmdy2_d #轉換遮罩後資料
DEFINE g_xmdy3_d          DYNAMIC ARRAY OF type_g_xmdy3_d
DEFINE g_xmdy3_d_t        type_g_xmdy3_d
DEFINE g_xmdy3_d_o        type_g_xmdy3_d
DEFINE g_xmdy3_d_mask_o   DYNAMIC ARRAY OF type_g_xmdy3_d #轉換遮罩前資料
DEFINE g_xmdy3_d_mask_n   DYNAMIC ARRAY OF type_g_xmdy3_d #轉換遮罩後資料
DEFINE g_xmdy4_d          DYNAMIC ARRAY OF type_g_xmdy4_d
DEFINE g_xmdy4_d_t        type_g_xmdy4_d
DEFINE g_xmdy4_d_o        type_g_xmdy4_d
DEFINE g_xmdy4_d_mask_o   DYNAMIC ARRAY OF type_g_xmdy4_d #轉換遮罩前資料
DEFINE g_xmdy4_d_mask_n   DYNAMIC ARRAY OF type_g_xmdy4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
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
 
{<section id="axmt440.main" >}
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
   LET g_forupd_sql = " SELECT xmdxdocno,xmdx000,'',xmdxdocdt,xmdx004,'',xmdx002,'',xmdx003,'',xmdxstus, 
       xmdx005,'',xmdx006,'',xmdx007,xmdx008,xmdx009,'',xmdx011,'',xmdx030,xmdx016,xmdx017,xmdx018,xmdx019, 
       xmdx020,xmdx010,xmdx012,xmdx001,xmdx014,xmdx015,xmdxsite,xmdxownid,'',xmdxowndp,'',xmdxcrtid, 
       '',xmdxcrtdp,'',xmdxcrtdt,xmdxmodid,'',xmdxmoddt,xmdxcnfid,'',xmdxcnfdt", 
                      " FROM xmdx_t",
                      " WHERE xmdxent= ? AND xmdxdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt440_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmdxdocno,t0.xmdx000,t0.xmdxdocdt,t0.xmdx004,t0.xmdx002,t0.xmdx003, 
       t0.xmdxstus,t0.xmdx005,t0.xmdx006,t0.xmdx007,t0.xmdx008,t0.xmdx009,t0.xmdx011,t0.xmdx030,t0.xmdx016, 
       t0.xmdx017,t0.xmdx018,t0.xmdx019,t0.xmdx020,t0.xmdx010,t0.xmdx012,t0.xmdx001,t0.xmdx014,t0.xmdx015, 
       t0.xmdxsite,t0.xmdxownid,t0.xmdxowndp,t0.xmdxcrtid,t0.xmdxcrtdp,t0.xmdxcrtdt,t0.xmdxmodid,t0.xmdxmoddt, 
       t0.xmdxcnfid,t0.xmdxcnfdt,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ,t4.ooail003 ,t5.ooibl004 ,t6.oocql004 , 
       t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM xmdx_t t0",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.xmdx004 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.xmdx002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.xmdx003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.xmdx005 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t5 ON t5.ooiblent="||g_enterprise||" AND t5.ooibl002=t0.xmdx009 AND t5.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='238' AND t6.oocql002=t0.xmdx011 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.xmdxownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.xmdxowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.xmdxcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.xmdxcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.xmdxmodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.xmdxcnfid  ",
 
               " WHERE t0.xmdxent = " ||g_enterprise|| " AND t0.xmdxdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmt440_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmt440 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmt440_init()   
 
      #進入選單 Menu (="N")
      CALL axmt440_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmt440
      
   END IF 
   
   CLOSE axmt440_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmt440.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmt440_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_bas0036     LIKE type_t.chr1   #160711-00005#2 20160721 
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xmdxstus','13','N,Y,A,D,R,W,X,C')
 
      CALL cl_set_combo_scc('xmdx016','2046') 
   CALL cl_set_combo_scc('xmdx017','2042') 
   CALL cl_set_combo_scc('xmdx018','2066') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #161031-00025#21-s
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_remarks", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc_part('ooff012','11','1,2,4')
   CALL cl_set_comp_visible("ooff003",FALSE)
   #161031-00025#21-e   
#161109-00085#6-mod-s
#  SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #161109-00085#6   mark
   SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,ooef008,ooef009,ooef010,ooef011,ooef012,
          ooef013,ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,ooef015,ooef016,ooef017,
          ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,ooef023,ooef024,ooef025,ooef026,ooef100,ooef101,ooef102,ooef103,
          ooef104,ooef105,ooef106,ooef107,ooef108,ooef109,ooef110,ooef111,ooef112,ooef113,ooef114,ooef115,ooef120,ooef121,
          ooef122,ooef123,ooef124,ooef125,ooef150,ooef151,ooef152,ooef153,ooef154,ooef155,ooef156,ooef157,ooef158,ooef159,
          ooef160,ooef161,ooef162,ooef163,ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,ooef171,ooef172,ooef173,
          ooefunit,ooef200,ooef201,ooef202,ooef203,ooef204,ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,ooef212,
          ooef213,ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,ooef304,ooef305,ooef306,ooef307,ooef308,ooef309,
          ooef310,ooef126,ooef127,ooef128,ooef116 
    INTO g_ooef.ooefent,g_ooef.ooefstus,g_ooef.ooef001,g_ooef.ooef002,g_ooef.ooef004,g_ooef.ooef005,g_ooef.ooef006,
         g_ooef.ooef007,g_ooef.ooef008,g_ooef.ooef009,g_ooef.ooef010,g_ooef.ooef011,g_ooef.ooef012,g_ooef.ooef013,
         g_ooef.ooefownid,g_ooef.ooefowndp,g_ooef.ooefcrtid,g_ooef.ooefcrtdp,g_ooef.ooefcrtdt,g_ooef.ooefmodid,g_ooef.ooefmoddt,
         g_ooef.ooef014,g_ooef.ooef015,g_ooef.ooef016,g_ooef.ooef017,g_ooef.ooef018,g_ooef.ooef019,g_ooef.ooef020,g_ooef.ooef021,
         g_ooef.ooef022,g_ooef.ooef003,g_ooef.ooef023,g_ooef.ooef024,g_ooef.ooef025,g_ooef.ooef026,g_ooef.ooef100,g_ooef.ooef101,
         g_ooef.ooef102,g_ooef.ooef103,g_ooef.ooef104,g_ooef.ooef105,g_ooef.ooef106,g_ooef.ooef107,g_ooef.ooef108,g_ooef.ooef109,
         g_ooef.ooef110,g_ooef.ooef111,g_ooef.ooef112,g_ooef.ooef113,g_ooef.ooef114,g_ooef.ooef115,g_ooef.ooef120,g_ooef.ooef121,
         g_ooef.ooef122,g_ooef.ooef123,g_ooef.ooef124,g_ooef.ooef125,g_ooef.ooef150,g_ooef.ooef151,g_ooef.ooef152,g_ooef.ooef153,
         g_ooef.ooef154,g_ooef.ooef155,g_ooef.ooef156,g_ooef.ooef157,g_ooef.ooef158,g_ooef.ooef159,g_ooef.ooef160,g_ooef.ooef161,
         g_ooef.ooef162,g_ooef.ooef163,g_ooef.ooef164,g_ooef.ooef165,g_ooef.ooef166,g_ooef.ooef167,g_ooef.ooef168,g_ooef.ooef169,
         g_ooef.ooef170,g_ooef.ooef171,g_ooef.ooef172,g_ooef.ooef173,g_ooef.ooefunit,g_ooef.ooef200,g_ooef.ooef201,g_ooef.ooef202,
         g_ooef.ooef203,g_ooef.ooef204,g_ooef.ooef205,g_ooef.ooef206,g_ooef.ooef207,g_ooef.ooef208,g_ooef.ooef209,g_ooef.ooef210,
         g_ooef.ooef211,g_ooef.ooef212,g_ooef.ooef213,g_ooef.ooef214,g_ooef.ooef215,g_ooef.ooef216,g_ooef.ooef217,g_ooef.ooef301,
         g_ooef.ooef302,g_ooef.ooef303,g_ooef.ooef304,g_ooef.ooef305,g_ooef.ooef306,g_ooef.ooef307,g_ooef.ooef308,g_ooef.ooef309,
         g_ooef.ooef310,g_ooef.ooef126,g_ooef.ooef127,g_ooef.ooef128,g_ooef.ooef116 
    FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#161109-00085#6-mod-e   
   #160711-00005#2 20160721 -----(S) 
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0036') RETURNING l_bas0036
   IF l_bas0036 = 'N' OR cl_null(l_bas0036) THEN
      CALL cl_set_comp_visible("xmdy003,xmdy003_desc,xmdy0032",FALSE)
   END IF
   #160711-00005#2 20160721 -----(E) 
   #end add-point
   
   #初始化搜尋條件
   CALL axmt440_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmt440.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmt440_ui_dialog()
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
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_success              LIKE type_t.num5      #160324-00037#9 add   
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
            CALL axmt440_insert()
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
         INITIALIZE g_xmdx_m.* TO NULL
         CALL g_xmdy_d.clear()
         CALL g_xmdy2_d.clear()
         CALL g_xmdy3_d.clear()
         CALL g_xmdy4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmt440_init()
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
               
               CALL axmt440_fetch('') # reload data
               LET l_ac = 1
               CALL axmt440_ui_detailshow() #Setting the current row 
         
               CALL axmt440_idx_chk()
               #NEXT FIELD xmdyseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xmdy_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt440_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               CALL axmt440_b_fill2('2')
CALL axmt440_b_fill2('3')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               IF l_ac >0 THEN 
                  CALL cl_set_act_visible("axmt440_01",FALSE)
                  IF g_xmdy_d[l_ac].xmdy024 = 'Y' THEN 
                     CALL cl_set_act_visible("axmt440_01",TRUE)
                  END IF
               END IF
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axmt440_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
 
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xmdy2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt440_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               CALL axmt440_b_fill2('2')
CALL axmt440_b_fill2('3')
 
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axmt440_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #第二階單身段落
         DISPLAY ARRAY g_xmdy3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt440_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axmt440_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第二階單身段落
         DISPLAY ARRAY g_xmdy4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt440_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL axmt440_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG aoo_aooi360_01.aooi360_01_display     #161031-00025#21 add
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axmt440_browser_fill("")
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
               CALL axmt440_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmt440_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axmt440_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         #161031-00025#21-s
         ON ACTION remarks_page
            LET g_detail_id = "remarks_page"
            NEXT FIELD ooff012
         #161031-00025#21-e
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axmt440_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axmt440_set_act_visible()   
            CALL axmt440_set_act_no_visible()
            IF NOT (g_xmdx_m.xmdxdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xmdxent = " ||g_enterprise|| " AND",
                                  " xmdxdocno = '", g_xmdx_m.xmdxdocno, "' "
 
               #填到對應位置
               CALL axmt440_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xmdx_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdy_t" 
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
               CALL axmt440_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xmdx_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdy_t" 
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
                  CALL axmt440_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmt440_fetch("F")
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
               CALL axmt440_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmt440_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt440_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmt440_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt440_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmt440_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt440_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmt440_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt440_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmt440_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt440_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmdy_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmdy2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xmdy3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_xmdy4_d)
                  LET g_export_id[4]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161031-00025#21-s
                  LET g_export_node[5] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[5]   = "s_detail1_aooi360_01"
                  #161031-00025#21-e
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
               NEXT FIELD xmdyseq
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
         ON ACTION clear_xmdw
            LET g_action_choice="clear_xmdw"
            IF cl_auth_chk_act("clear_xmdw") THEN
               
               #add-point:ON ACTION clear_xmdw name="menu.clear_xmdw"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00066'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM xmdw_t
                WHERE xmdwent = g_enterprise
                  AND xmdw001 = g_xmdx_m.xmdxdocno
                  AND xmdw002 = g_xmdy_d[g_detail_idx].xmdyseq
               IF l_cnt > 0 AND NOT cl_null(l_cnt) THEN  
                  IF cl_ask_confirm('axm-00627') THEN               
                     CALL s_transaction_begin()
                     IF axmt440_clear_xmdw(g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'adz-00217'
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                     
                        CALL s_transaction_end('Y','0')
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'adz-00218'
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                                    
                        CALL s_transaction_end('N','0')
                     END IF
                     CALL axmt440_b_fill2('3')
                   END IF  
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00626'     #合約單號%1項次%2無結算資料，故不需還原！
                  LET g_errparam.extend = ''
                  LET g_errparam.replace[1] = g_xmdx_m.xmdxdocno
                  LET g_errparam.replace[2] = g_xmdy_d[g_detail_idx].xmdyseq
                  LET g_errparam.popup = TRUE
                  CALL cl_err()             
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmt440_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmt440_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION stus_closed
            LET g_action_choice="stus_closed"
            IF cl_auth_chk_act("stus_closed") THEN
               
               #add-point:ON ACTION stus_closed name="menu.stus_closed"
               #--160324-00037#9--add--(S) 
               CALL s_transaction_begin()

               IF g_xmdx_m.xmdxstus = 'C' THEN
                  CALL s_axmt440_unclosed_chk(g_xmdx_m.xmdxdocno)
                    RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     IF NOT cl_ask_confirm('lib-004') THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_axmt440_unclosed_upd(g_xmdx_m.xmdxdocno)
                          RETURNING l_success
                        IF l_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  END IF
               ELSE
                  CALL s_axmt440_closed_chk(g_xmdx_m.xmdxdocno)
                    RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     IF NOT cl_ask_confirm('lib-003') THEN
                        CALL s_transaction_end('N','0')
                     ELSE 
                        CALL s_axmt440_closed_upd(g_xmdx_m.xmdxdocno)
                          RETURNING l_success
                        IF l_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  END IF
               END IF

               SELECT xmdxstus INTO g_xmdx_m.xmdxstus
                 FROM xmdx_t
                WHERE xmdxent   = g_enterprise
                  AND xmdxdocno = g_xmdx_m.xmdxdocno
               CALL axmt440_show()
               
               #--160324-00037#9--add--(S) 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION change_xmdx015
            LET g_action_choice="change_xmdx015"
            IF cl_auth_chk_act("change_xmdx015") THEN
               
               #add-point:ON ACTION change_xmdx015 name="menu.change_xmdx015"
              #--160324-00037#9--add--(S)  
               CALL s_transaction_begin()
               CALL axmt440_change_xmdx015() RETURNING l_success

               IF l_success THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               #--160324-00037#9--add--(E)  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmt440_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmt440_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL axmr440_g01("xmdxent ="|| g_enterprise ||" AND xmdxdocno ='"|| g_xmdx_m.xmdxdocno||"'")
               LET g_rep_wc = "xmdxent ="|| g_enterprise ||" AND xmdxdocno ='"|| g_xmdx_m.xmdxdocno||"'" 
               #END add-point
               &include "erp/axm/axmt440_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL axmr440_g01("xmdxent ="|| g_enterprise ||" AND xmdxdocno ='"|| g_xmdx_m.xmdxdocno||"'")
               LET g_rep_wc = "xmdxent ="|| g_enterprise ||" AND xmdxdocno ='"|| g_xmdx_m.xmdxdocno||"'" 
               #END add-point
               &include "erp/axm/axmt440_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmt440_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt440_01
            LET g_action_choice="axmt440_01"
            IF cl_auth_chk_act("axmt440_01") THEN
               
               #add-point:ON ACTION axmt440_01 name="menu.axmt440_01"
               IF l_ac > 0 THEN
                  IF g_xmdy_d[l_ac].xmdy024 = 'Y' THEN               
                     CALL axmt440_01('2',g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_xmdy_d[l_ac].xmdy004,g_xmdy_d[l_ac].xmdy006,g_xmdy_d[l_ac].xmdy007,g_xmdy_d[l_ac].xmdy008,g_xmdy_d[l_ac].xmdy009)
                  END IF
               END IF 
               LET g_action_choice="axmt440_01"               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmt440_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION memo
            LET g_action_choice="memo"
            IF cl_auth_chk_act("memo") THEN
               
               #add-point:ON ACTION memo name="menu.memo"
               #CALL aooi360_02('6','axmt440',g_xmdx_m.xmdxdocno,'','','','','','','','','')   #161031-00025#21 mark            
               #161031-00025#21-s
               IF NOT cl_null(g_xmdx_m.xmdxdocno) THEN
                  CALL axmt440_remaks()
               END IF
               #161031-00025#21-e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_msg
            LET g_action_choice="prog_msg"
            IF cl_auth_chk_act("prog_msg") THEN
               
               #add-point:ON ACTION prog_msg name="menu.prog_msg"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_xmdx_m.xmdx002)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmt440_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmt440_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmt440_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xmdx_m.xmdxdocdt)
 
 
 
         
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
 
{<section id="axmt440.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmt440_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161031-00025#21-s
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   #清除备注单身
   END IF
   #161031-00025#21-e
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
#   IF NOT cl_null(g_argv[1]) THEN
#      IF g_argv[1] = '1' THEN 
#         LET g_wc = g_wc, " AND xmdx001 = 'N' "
#      ELSE
#         LET g_wc = g_wc, " AND xmdx001 = 'Y' "
#      END IF      
#   END IF   
   LET g_wc = g_wc," AND xmdxsite = '",g_site,"'"  
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xmdxdocno ",
                      " FROM xmdx_t ",
                      " ",
                      " LEFT JOIN xmdy_t ON xmdyent = xmdxent AND xmdxdocno = xmdydocno ", "  ",
                      #add-point:browser_fill段sql(xmdy_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN xmdz_t ON xmdzent = xmdxent AND xmdydocno = xmdzdocno AND xmdyseq = xmdzseq", "  ",
                      #add-point:browser_fill段sql(xmdz_t1) name="browser_fill.cnt.join.xmdz_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmdw_t ON xmdwent = xmdxent AND xmdydocno = xmdw001 AND xmdyseq = xmdw002", "  ",
                      #add-point:browser_fill段sql(xmdw_t1) name="browser_fill.cnt.join.xmdw_t1"
                      " LEFT JOIN ooff_t ON ooffent = xmdxent AND ooff001 = '7' 
                              AND ooff002 = '",g_prog,"' AND xmdxdocno = ooff003  AND ooff004 = xmdyseq ",  "  ",   #161031-00025#21 add
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
                      " ",
 
 
                      " WHERE xmdxent = " ||g_enterprise|| " AND xmdyent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmdx_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmdxdocno ",
                      " FROM xmdx_t ", 
                      "  ",
                      "  ",
                      " WHERE xmdxent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmdx_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #161031-00025#21-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                        WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                          AND ooff002 = '",g_prog,"' AND ooff003 = xmdxdocno
                                                          AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#21-e
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
      INITIALIZE g_xmdx_m.* TO NULL
      CALL g_xmdy_d.clear()        
      CALL g_xmdy2_d.clear() 
      CALL g_xmdy3_d.clear() 
      CALL g_xmdy4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmdxdocno,t0.xmdxdocdt,t0.xmdx002,t0.xmdx003,t0.xmdx004,t0.xmdx005,t0.xmdx014,t0.xmdx015 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdxstus,t0.xmdxdocno,t0.xmdxdocdt,t0.xmdx002,t0.xmdx003,t0.xmdx004, 
          t0.xmdx005,t0.xmdx014,t0.xmdx015,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.ooail003 ",
                  " FROM xmdx_t t0",
                  "  ",
                  "  LEFT JOIN xmdy_t ON xmdyent = xmdxent AND xmdxdocno = xmdydocno ", "  ", 
                  #add-point:browser_fill段sql(xmdy_t1) name="browser_fill.join.xmdy_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmdz_t ON xmdzent = xmdxent AND xmdydocno = xmdzdocno AND xmdyseq = xmdzseq", "  ", 
                  #add-point:browser_fill段sql(xmdz_t1) name="browser_fill.join.xmdz_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmdw_t ON xmdwent = xmdxent AND xmdydocno = xmdw001 AND xmdyseq = xmdw002", "  ", 
                  #add-point:browser_fill段sql(xmdw_t1) name="browser_fill.join.xmdw_t1"
                  " LEFT JOIN ooff_t ON ooffent = xmdxent AND ooff001 = '7' 
                          AND ooff002 = '",g_prog,"' AND xmdxdocno = ooff003  AND ooff004 = xmdyseq ",  "  ",   #161031-00025#21 add
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdx002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdx003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdx004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.xmdx005 AND t4.ooail002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdxent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xmdx_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdxstus,t0.xmdxdocno,t0.xmdxdocdt,t0.xmdx002,t0.xmdx003,t0.xmdx004, 
          t0.xmdx005,t0.xmdx014,t0.xmdx015,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.ooail003 ",
                  " FROM xmdx_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdx002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdx003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdx004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.xmdx005 AND t4.ooail002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdxent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xmdx_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161031-00025#21-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                  AND ooff002 = '",g_prog,"' AND ooff003 = xmdxdocno
                                                  AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#21-e
   #end add-point
   LET g_sql = g_sql, " ORDER BY xmdxdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmdx_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmdxdocno,g_browser[g_cnt].b_xmdxdocdt, 
          g_browser[g_cnt].b_xmdx002,g_browser[g_cnt].b_xmdx003,g_browser[g_cnt].b_xmdx004,g_browser[g_cnt].b_xmdx005, 
          g_browser[g_cnt].b_xmdx014,g_browser[g_cnt].b_xmdx015,g_browser[g_cnt].b_xmdx002_desc,g_browser[g_cnt].b_xmdx003_desc, 
          g_browser[g_cnt].b_xmdx004_desc,g_browser[g_cnt].b_xmdx005_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL axmt440_xmdxdocno_desc('2',g_browser[g_cnt].b_xmdxdocno) RETURNING g_browser[g_cnt].b_xmdxdocno_desc
      DISPLAY BY NAME g_browser[g_cnt].b_xmdxdocno_desc
         #end add-point
      
         #遮罩相關處理
         CALL axmt440_browser_mask()
      
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
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_xmdxdocno) THEN
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
 
{<section id="axmt440.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmt440_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmdx_m.xmdxdocno = g_browser[g_current_idx].b_xmdxdocno   
 
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
   CALL axmt440_xmdx_t_mask()
   CALL axmt440_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axmt440.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmt440_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
#   IF NOT cl_null(g_curr_diag) THEN
#      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
#      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
#      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
#   ELSE
#      CALL g_curr_diag.setCurrentRow("s_browse",g_detail_idx)
#   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmt440_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmdxdocno = g_xmdx_m.xmdxdocno 
 
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
 
{<section id="axmt440.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmt440_construct()
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
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#21
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xmdx_m.* TO NULL
   CALL g_xmdy_d.clear()        
   CALL g_xmdy2_d.clear() 
   CALL g_xmdy3_d.clear() 
   CALL g_xmdy4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmdxdocno,xmdx000,xmdxdocno_desc,xmdxdocdt,xmdx004,xmdx002,xmdx003,xmdxstus, 
          xmdx005,xmdx006,xmdx006_desc,xmdx007,xmdx008,xmdx009,xmdx011,xmdx030,xmdx016,xmdx017,xmdx018, 
          xmdx019,xmdx020,xmdx010,xmdx012,xmdx001,xmdx014,xmdx015,xmdxsite,xmdxownid,xmdxowndp,xmdxcrtid, 
          xmdxcrtdp,xmdxcrtdt,xmdxmodid,xmdxmoddt,xmdxcnfid,xmdxcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmdxcrtdt>>----
         AFTER FIELD xmdxcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmdxmoddt>>----
         AFTER FIELD xmdxmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdxcnfdt>>----
         AFTER FIELD xmdxcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdxpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xmdxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxdocno
            #add-point:ON ACTION controlp INFIELD xmdxdocno name="construct.c.xmdxdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmdxdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxdocno  #顯示到畫面上

            NEXT FIELD xmdxdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxdocno
            #add-point:BEFORE FIELD xmdxdocno name="construct.b.xmdxdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxdocno
            
            #add-point:AFTER FIELD xmdxdocno name="construct.a.xmdxdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx000
            #add-point:BEFORE FIELD xmdx000 name="construct.b.xmdx000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx000
            
            #add-point:AFTER FIELD xmdx000 name="construct.a.xmdx000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx000
            #add-point:ON ACTION controlp INFIELD xmdx000 name="construct.c.xmdx000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxdocno_desc
            #add-point:BEFORE FIELD xmdxdocno_desc name="construct.b.xmdxdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxdocno_desc
            
            #add-point:AFTER FIELD xmdxdocno_desc name="construct.a.xmdxdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxdocno_desc
            #add-point:ON ACTION controlp INFIELD xmdxdocno_desc name="construct.c.xmdxdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxdocdt
            #add-point:BEFORE FIELD xmdxdocdt name="construct.b.xmdxdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxdocdt
            
            #add-point:AFTER FIELD xmdxdocdt name="construct.a.xmdxdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxdocdt
            #add-point:ON ACTION controlp INFIELD xmdxdocdt name="construct.c.xmdxdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx004
            #add-point:ON ACTION controlp INFIELD xmdx004 name="construct.c.xmdx004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			
			   LET g_qryparam.arg1 = g_site
			
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx004  #顯示到畫面上

            NEXT FIELD xmdx004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx004
            #add-point:BEFORE FIELD xmdx004 name="construct.b.xmdx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx004
            
            #add-point:AFTER FIELD xmdx004 name="construct.a.xmdx004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx002
            #add-point:ON ACTION controlp INFIELD xmdx002 name="construct.c.xmdx002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx002  #顯示到畫面上

            NEXT FIELD xmdx002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx002
            #add-point:BEFORE FIELD xmdx002 name="construct.b.xmdx002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx002
            
            #add-point:AFTER FIELD xmdx002 name="construct.a.xmdx002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx003
            #add-point:ON ACTION controlp INFIELD xmdx003 name="construct.c.xmdx003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx003  #顯示到畫面上

            NEXT FIELD xmdx003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx003
            #add-point:BEFORE FIELD xmdx003 name="construct.b.xmdx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx003
            
            #add-point:AFTER FIELD xmdx003 name="construct.a.xmdx003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxstus
            #add-point:BEFORE FIELD xmdxstus name="construct.b.xmdxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxstus
            
            #add-point:AFTER FIELD xmdxstus name="construct.a.xmdxstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxstus
            #add-point:ON ACTION controlp INFIELD xmdxstus name="construct.c.xmdxstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdx005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx005
            #add-point:ON ACTION controlp INFIELD xmdx005 name="construct.c.xmdx005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx005  #顯示到畫面上

            NEXT FIELD xmdx005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx005
            #add-point:BEFORE FIELD xmdx005 name="construct.b.xmdx005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx005
            
            #add-point:AFTER FIELD xmdx005 name="construct.a.xmdx005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx006
            #add-point:ON ACTION controlp INFIELD xmdx006 name="construct.c.xmdx006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " oodb001 = '",g_ooef.ooef019,"'"
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx006  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oodb002 #稅別代碼 

            NEXT FIELD xmdx006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx006
            #add-point:BEFORE FIELD xmdx006 name="construct.b.xmdx006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx006
            
            #add-point:AFTER FIELD xmdx006 name="construct.a.xmdx006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx006_desc
            #add-point:BEFORE FIELD xmdx006_desc name="construct.b.xmdx006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx006_desc
            
            #add-point:AFTER FIELD xmdx006_desc name="construct.a.xmdx006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx006_desc
            #add-point:ON ACTION controlp INFIELD xmdx006_desc name="construct.c.xmdx006_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx007
            #add-point:BEFORE FIELD xmdx007 name="construct.b.xmdx007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx007
            
            #add-point:AFTER FIELD xmdx007 name="construct.a.xmdx007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx007
            #add-point:ON ACTION controlp INFIELD xmdx007 name="construct.c.xmdx007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx008
            #add-point:BEFORE FIELD xmdx008 name="construct.b.xmdx008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx008
            
            #add-point:AFTER FIELD xmdx008 name="construct.a.xmdx008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx008
            #add-point:ON ACTION controlp INFIELD xmdx008 name="construct.c.xmdx008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdx009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx009
            #add-point:ON ACTION controlp INFIELD xmdx009 name="construct.c.xmdx009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmad002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx009  #顯示到畫面上

            NEXT FIELD xmdx009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx009
            #add-point:BEFORE FIELD xmdx009 name="construct.b.xmdx009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx009
            
            #add-point:AFTER FIELD xmdx009 name="construct.a.xmdx009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx011
            #add-point:ON ACTION controlp INFIELD xmdx011 name="construct.c.xmdx011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdx011  #顯示到畫面上

            NEXT FIELD xmdx011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx011
            #add-point:BEFORE FIELD xmdx011 name="construct.b.xmdx011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx011
            
            #add-point:AFTER FIELD xmdx011 name="construct.a.xmdx011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx030
            #add-point:BEFORE FIELD xmdx030 name="construct.b.xmdx030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx030
            
            #add-point:AFTER FIELD xmdx030 name="construct.a.xmdx030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx030
            #add-point:ON ACTION controlp INFIELD xmdx030 name="construct.c.xmdx030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx016
            #add-point:BEFORE FIELD xmdx016 name="construct.b.xmdx016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx016
            
            #add-point:AFTER FIELD xmdx016 name="construct.a.xmdx016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx016
            #add-point:ON ACTION controlp INFIELD xmdx016 name="construct.c.xmdx016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx017
            #add-point:BEFORE FIELD xmdx017 name="construct.b.xmdx017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx017
            
            #add-point:AFTER FIELD xmdx017 name="construct.a.xmdx017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx017
            #add-point:ON ACTION controlp INFIELD xmdx017 name="construct.c.xmdx017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx018
            #add-point:BEFORE FIELD xmdx018 name="construct.b.xmdx018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx018
            
            #add-point:AFTER FIELD xmdx018 name="construct.a.xmdx018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx018
            #add-point:ON ACTION controlp INFIELD xmdx018 name="construct.c.xmdx018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx019
            #add-point:BEFORE FIELD xmdx019 name="construct.b.xmdx019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx019
            
            #add-point:AFTER FIELD xmdx019 name="construct.a.xmdx019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx019
            #add-point:ON ACTION controlp INFIELD xmdx019 name="construct.c.xmdx019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx020
            #add-point:BEFORE FIELD xmdx020 name="construct.b.xmdx020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx020
            
            #add-point:AFTER FIELD xmdx020 name="construct.a.xmdx020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx020
            #add-point:ON ACTION controlp INFIELD xmdx020 name="construct.c.xmdx020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx010
            #add-point:BEFORE FIELD xmdx010 name="construct.b.xmdx010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx010
            
            #add-point:AFTER FIELD xmdx010 name="construct.a.xmdx010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx010
            #add-point:ON ACTION controlp INFIELD xmdx010 name="construct.c.xmdx010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx012
            #add-point:BEFORE FIELD xmdx012 name="construct.b.xmdx012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx012
            
            #add-point:AFTER FIELD xmdx012 name="construct.a.xmdx012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx012
            #add-point:ON ACTION controlp INFIELD xmdx012 name="construct.c.xmdx012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx001
            #add-point:BEFORE FIELD xmdx001 name="construct.b.xmdx001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx001
            
            #add-point:AFTER FIELD xmdx001 name="construct.a.xmdx001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx001
            #add-point:ON ACTION controlp INFIELD xmdx001 name="construct.c.xmdx001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx014
            #add-point:BEFORE FIELD xmdx014 name="construct.b.xmdx014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx014
            
            #add-point:AFTER FIELD xmdx014 name="construct.a.xmdx014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx014
            #add-point:ON ACTION controlp INFIELD xmdx014 name="construct.c.xmdx014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx015
            #add-point:BEFORE FIELD xmdx015 name="construct.b.xmdx015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx015
            
            #add-point:AFTER FIELD xmdx015 name="construct.a.xmdx015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdx015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx015
            #add-point:ON ACTION controlp INFIELD xmdx015 name="construct.c.xmdx015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxsite
            #add-point:BEFORE FIELD xmdxsite name="construct.b.xmdxsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxsite
            
            #add-point:AFTER FIELD xmdxsite name="construct.a.xmdxsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxsite
            #add-point:ON ACTION controlp INFIELD xmdxsite name="construct.c.xmdxsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdxownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxownid
            #add-point:ON ACTION controlp INFIELD xmdxownid name="construct.c.xmdxownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxownid  #顯示到畫面上

            NEXT FIELD xmdxownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxownid
            #add-point:BEFORE FIELD xmdxownid name="construct.b.xmdxownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxownid
            
            #add-point:AFTER FIELD xmdxownid name="construct.a.xmdxownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxowndp
            #add-point:ON ACTION controlp INFIELD xmdxowndp name="construct.c.xmdxowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxowndp  #顯示到畫面上

            NEXT FIELD xmdxowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxowndp
            #add-point:BEFORE FIELD xmdxowndp name="construct.b.xmdxowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxowndp
            
            #add-point:AFTER FIELD xmdxowndp name="construct.a.xmdxowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxcrtid
            #add-point:ON ACTION controlp INFIELD xmdxcrtid name="construct.c.xmdxcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxcrtid  #顯示到畫面上

            NEXT FIELD xmdxcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxcrtid
            #add-point:BEFORE FIELD xmdxcrtid name="construct.b.xmdxcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxcrtid
            
            #add-point:AFTER FIELD xmdxcrtid name="construct.a.xmdxcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdxcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxcrtdp
            #add-point:ON ACTION controlp INFIELD xmdxcrtdp name="construct.c.xmdxcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxcrtdp  #顯示到畫面上

            NEXT FIELD xmdxcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxcrtdp
            #add-point:BEFORE FIELD xmdxcrtdp name="construct.b.xmdxcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxcrtdp
            
            #add-point:AFTER FIELD xmdxcrtdp name="construct.a.xmdxcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxcrtdt
            #add-point:BEFORE FIELD xmdxcrtdt name="construct.b.xmdxcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdxmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxmodid
            #add-point:ON ACTION controlp INFIELD xmdxmodid name="construct.c.xmdxmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxmodid  #顯示到畫面上

            NEXT FIELD xmdxmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxmodid
            #add-point:BEFORE FIELD xmdxmodid name="construct.b.xmdxmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxmodid
            
            #add-point:AFTER FIELD xmdxmodid name="construct.a.xmdxmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxmoddt
            #add-point:BEFORE FIELD xmdxmoddt name="construct.b.xmdxmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdxcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxcnfid
            #add-point:ON ACTION controlp INFIELD xmdxcnfid name="construct.c.xmdxcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdxcnfid  #顯示到畫面上

            NEXT FIELD xmdxcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxcnfid
            #add-point:BEFORE FIELD xmdxcnfid name="construct.b.xmdxcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxcnfid
            
            #add-point:AFTER FIELD xmdxcnfid name="construct.a.xmdxcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxcnfdt
            #add-point:BEFORE FIELD xmdxcnfdt name="construct.b.xmdxcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xmdysite,xmdyseq,xmdy002,xmdy003,xmdy003_desc,xmdy005,xmdy006,xmdy007, 
          xmdy014,xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy011_desc,xmdy012,xmdy017,xmdy018,xmdy019, 
          xmdy013,xmdy004,xmdy030,ooff013,xmdy020,xmdy021,xmdy022,xmdy023
           FROM s_detail1[1].xmdysite,s_detail1[1].xmdyseq,s_detail1[1].xmdy002,s_detail1[1].xmdy003, 
               s_detail1[1].xmdy003_desc,s_detail1[1].xmdy005,s_detail1[1].xmdy006,s_detail1[1].xmdy007, 
               s_detail1[1].xmdy014,s_detail1[1].xmdy008,s_detail1[1].xmdy009,s_detail1[1].xmdy010,s_detail1[1].xmdy024, 
               s_detail1[1].xmdy011,s_detail1[1].xmdy011_desc,s_detail1[1].xmdy012,s_detail1[1].xmdy017, 
               s_detail1[1].xmdy018,s_detail1[1].xmdy019,s_detail1[1].xmdy013,s_detail1[1].xmdy004,s_detail1[1].xmdy030, 
               s_detail1[1].ooff013,s_detail2[1].xmdy020,s_detail2[1].xmdy021,s_detail2[1].xmdy022,s_detail2[1].xmdy023 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
#        
#
#         ON ACTION controlp INFIELD xmdy002
#			   INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            CALL q_imaf001()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy002              #顯示到畫面上
#            NEXT FIELD xmdy002                          #返回原欄位
# 
#         ON ACTION controlp INFIELD xmdy005
#			   INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#		    	LET g_qryparam.reqry = FALSE
#            CALL q_pmao004_2()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy005              #顯示到畫面上
#            NEXT FIELD xmdy005                          #返回原欄位
#
#         ON ACTION controlp INFIELD xmdy006
#			   INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#		    	LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '221'
#            CALL q_oocq002()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy006              #顯示到畫面上
#            NEXT FIELD xmdy006                          #返回原欄位
# 
#         ON ACTION controlp INFIELD xmdy014
#		   	INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#		   	LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '277'
#            CALL q_oocq002()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy014              #顯示到畫面上
#            NEXT FIELD xmdy014                          #返回原欄位
# 
#         ON ACTION controlp INFIELD xmdy008
#			   INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            CALL q_ooca001_1()                                #呼叫開窗
#            LET g_xmdy_d[l_ac].xmdy008 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_qryparam.return1 TO xmdy008              #顯示到畫面上
#            NEXT FIELD xmdy008                          #返回原欄位
# 
#         ON ACTION controlp INFIELD xmdy011
#	    		INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#		   	LET g_qryparam.reqry = FALSE
#		   	LET g_qryparam.where = " oodb001 = '",g_ooef.ooef019,"'"
#            CALL q_oodb002_4()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy011              #顯示到畫面上
#            NEXT FIELD xmdy011                          #返回原欄位
#
#         ON ACTION controlp INFIELD xmdy013
#		   	INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#		   	LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '263'
#            CALL q_oocq002()                                #呼叫開窗
#            LET g_xmdy_d[l_ac].xmdy013 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_qryparam.return1 TO xmdy013              #顯示到畫面上
#            NEXT FIELD xmdy013                          #返回原欄位
#
#         ON ACTION controlp INFIELD xmdy004
#	   		INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#	    		LET g_qryparam.reqry = FALSE
#            CALL q_imaf001_12()                                #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmdy004              #顯示到畫面上
#            NEXT FIELD xmdy004                          #返回原欄位
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdysite
            #add-point:BEFORE FIELD xmdysite name="construct.b.page1.xmdysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdysite
            
            #add-point:AFTER FIELD xmdysite name="construct.a.page1.xmdysite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdysite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdysite
            #add-point:ON ACTION controlp INFIELD xmdysite name="construct.c.page1.xmdysite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdyseq
            #add-point:BEFORE FIELD xmdyseq name="construct.b.page1.xmdyseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdyseq
            
            #add-point:AFTER FIELD xmdyseq name="construct.a.page1.xmdyseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdyseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdyseq
            #add-point:ON ACTION controlp INFIELD xmdyseq name="construct.c.page1.xmdyseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdy002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy002
            #add-point:ON ACTION controlp INFIELD xmdy002 name="construct.c.page1.xmdy002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy002  #顯示到畫面上

            NEXT FIELD xmdy002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy002
            #add-point:BEFORE FIELD xmdy002 name="construct.b.page1.xmdy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy002
            
            #add-point:AFTER FIELD xmdy002 name="construct.a.page1.xmdy002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy003
            #add-point:BEFORE FIELD xmdy003 name="construct.b.page1.xmdy003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy003
            
            #add-point:AFTER FIELD xmdy003 name="construct.a.page1.xmdy003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy003
            #add-point:ON ACTION controlp INFIELD xmdy003 name="construct.c.page1.xmdy003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy003_desc
            #add-point:BEFORE FIELD xmdy003_desc name="construct.b.page1.xmdy003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy003_desc
            
            #add-point:AFTER FIELD xmdy003_desc name="construct.a.page1.xmdy003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy003_desc
            #add-point:ON ACTION controlp INFIELD xmdy003_desc name="construct.c.page1.xmdy003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdy005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy005
            #add-point:ON ACTION controlp INFIELD xmdy005 name="construct.c.page1.xmdy005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmao004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy005  #顯示到畫面上

            NEXT FIELD xmdy005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy005
            #add-point:BEFORE FIELD xmdy005 name="construct.b.page1.xmdy005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy005
            
            #add-point:AFTER FIELD xmdy005 name="construct.a.page1.xmdy005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy006
            #add-point:ON ACTION controlp INFIELD xmdy006 name="construct.c.page1.xmdy006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy006  #顯示到畫面上

            NEXT FIELD xmdy006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy006
            #add-point:BEFORE FIELD xmdy006 name="construct.b.page1.xmdy006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy006
            
            #add-point:AFTER FIELD xmdy006 name="construct.a.page1.xmdy006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy007
            #add-point:BEFORE FIELD xmdy007 name="construct.b.page1.xmdy007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy007
            
            #add-point:AFTER FIELD xmdy007 name="construct.a.page1.xmdy007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy007
            #add-point:ON ACTION controlp INFIELD xmdy007 name="construct.c.page1.xmdy007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdy014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy014
            #add-point:ON ACTION controlp INFIELD xmdy014 name="construct.c.page1.xmdy014"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '277'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy014  #顯示到畫面上

            NEXT FIELD xmdy014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy014
            #add-point:BEFORE FIELD xmdy014 name="construct.b.page1.xmdy014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy014
            
            #add-point:AFTER FIELD xmdy014 name="construct.a.page1.xmdy014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy008
            #add-point:ON ACTION controlp INFIELD xmdy008 name="construct.c.page1.xmdy008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy008  #顯示到畫面上

            NEXT FIELD xmdy008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy008
            #add-point:BEFORE FIELD xmdy008 name="construct.b.page1.xmdy008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy008
            
            #add-point:AFTER FIELD xmdy008 name="construct.a.page1.xmdy008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy009
            #add-point:BEFORE FIELD xmdy009 name="construct.b.page1.xmdy009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy009
            
            #add-point:AFTER FIELD xmdy009 name="construct.a.page1.xmdy009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy009
            #add-point:ON ACTION controlp INFIELD xmdy009 name="construct.c.page1.xmdy009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy010
            #add-point:BEFORE FIELD xmdy010 name="construct.b.page1.xmdy010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy010
            
            #add-point:AFTER FIELD xmdy010 name="construct.a.page1.xmdy010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy010
            #add-point:ON ACTION controlp INFIELD xmdy010 name="construct.c.page1.xmdy010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy024
            #add-point:BEFORE FIELD xmdy024 name="construct.b.page1.xmdy024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy024
            
            #add-point:AFTER FIELD xmdy024 name="construct.a.page1.xmdy024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy024
            #add-point:ON ACTION controlp INFIELD xmdy024 name="construct.c.page1.xmdy024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdy011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy011
            #add-point:ON ACTION controlp INFIELD xmdy011 name="construct.c.page1.xmdy011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy011  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oodb002 #稅別代碼 

            NEXT FIELD xmdy011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy011
            #add-point:BEFORE FIELD xmdy011 name="construct.b.page1.xmdy011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy011
            
            #add-point:AFTER FIELD xmdy011 name="construct.a.page1.xmdy011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy011_desc
            #add-point:BEFORE FIELD xmdy011_desc name="construct.b.page1.xmdy011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy011_desc
            
            #add-point:AFTER FIELD xmdy011_desc name="construct.a.page1.xmdy011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy011_desc
            #add-point:ON ACTION controlp INFIELD xmdy011_desc name="construct.c.page1.xmdy011_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy012
            #add-point:BEFORE FIELD xmdy012 name="construct.b.page1.xmdy012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy012
            
            #add-point:AFTER FIELD xmdy012 name="construct.a.page1.xmdy012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy012
            #add-point:ON ACTION controlp INFIELD xmdy012 name="construct.c.page1.xmdy012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy017
            #add-point:BEFORE FIELD xmdy017 name="construct.b.page1.xmdy017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy017
            
            #add-point:AFTER FIELD xmdy017 name="construct.a.page1.xmdy017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy017
            #add-point:ON ACTION controlp INFIELD xmdy017 name="construct.c.page1.xmdy017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy018
            #add-point:BEFORE FIELD xmdy018 name="construct.b.page1.xmdy018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy018
            
            #add-point:AFTER FIELD xmdy018 name="construct.a.page1.xmdy018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy018
            #add-point:ON ACTION controlp INFIELD xmdy018 name="construct.c.page1.xmdy018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy019
            #add-point:BEFORE FIELD xmdy019 name="construct.b.page1.xmdy019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy019
            
            #add-point:AFTER FIELD xmdy019 name="construct.a.page1.xmdy019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy019
            #add-point:ON ACTION controlp INFIELD xmdy019 name="construct.c.page1.xmdy019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdy013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy013
            #add-point:ON ACTION controlp INFIELD xmdy013 name="construct.c.page1.xmdy013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy013  #顯示到畫面上

            NEXT FIELD xmdy013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy013
            #add-point:BEFORE FIELD xmdy013 name="construct.b.page1.xmdy013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy013
            
            #add-point:AFTER FIELD xmdy013 name="construct.a.page1.xmdy013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy004
            #add-point:ON ACTION controlp INFIELD xmdy004 name="construct.c.page1.xmdy004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaf001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdy004  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO imaal003 #品名 

            NEXT FIELD xmdy004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy004
            #add-point:BEFORE FIELD xmdy004 name="construct.b.page1.xmdy004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy004
            
            #add-point:AFTER FIELD xmdy004 name="construct.a.page1.xmdy004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy030
            #add-point:BEFORE FIELD xmdy030 name="construct.b.page1.xmdy030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy030
            
            #add-point:AFTER FIELD xmdy030 name="construct.a.page1.xmdy030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdy030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy030
            #add-point:ON ACTION controlp INFIELD xmdy030 name="construct.c.page1.xmdy030"
            
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
         BEFORE FIELD xmdy020
            #add-point:BEFORE FIELD xmdy020 name="construct.b.page2.xmdy020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy020
            
            #add-point:AFTER FIELD xmdy020 name="construct.a.page2.xmdy020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdy020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy020
            #add-point:ON ACTION controlp INFIELD xmdy020 name="construct.c.page2.xmdy020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy021
            #add-point:BEFORE FIELD xmdy021 name="construct.b.page2.xmdy021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy021
            
            #add-point:AFTER FIELD xmdy021 name="construct.a.page2.xmdy021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdy021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy021
            #add-point:ON ACTION controlp INFIELD xmdy021 name="construct.c.page2.xmdy021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy022
            #add-point:BEFORE FIELD xmdy022 name="construct.b.page2.xmdy022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy022
            
            #add-point:AFTER FIELD xmdy022 name="construct.a.page2.xmdy022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdy022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy022
            #add-point:ON ACTION controlp INFIELD xmdy022 name="construct.c.page2.xmdy022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy023
            #add-point:BEFORE FIELD xmdy023 name="construct.b.page2.xmdy023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy023
            
            #add-point:AFTER FIELD xmdy023 name="construct.a.page2.xmdy023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmdy023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy023
            #add-point:ON ACTION controlp INFIELD xmdy023 name="construct.c.page2.xmdy023"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON xmdzseq,xmdzseq1,xmdz001,xmdz002,xmdz003,xmdz004,xmdz005
           FROM s_detail3[1].xmdzseq,s_detail3[1].xmdzseq1,s_detail3[1].xmdz001,s_detail3[1].xmdz002, 
               s_detail3[1].xmdz003,s_detail3[1].xmdz004,s_detail3[1].xmdz005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdzseq
            #add-point:BEFORE FIELD xmdzseq name="construct.b.page3.xmdzseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdzseq
            
            #add-point:AFTER FIELD xmdzseq name="construct.a.page3.xmdzseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdzseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdzseq
            #add-point:ON ACTION controlp INFIELD xmdzseq name="construct.c.page3.xmdzseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdzseq1
            #add-point:BEFORE FIELD xmdzseq1 name="construct.b.page3.xmdzseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdzseq1
            
            #add-point:AFTER FIELD xmdzseq1 name="construct.a.page3.xmdzseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdzseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdzseq1
            #add-point:ON ACTION controlp INFIELD xmdzseq1 name="construct.c.page3.xmdzseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdz001
            #add-point:BEFORE FIELD xmdz001 name="construct.b.page3.xmdz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdz001
            
            #add-point:AFTER FIELD xmdz001 name="construct.a.page3.xmdz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdz001
            #add-point:ON ACTION controlp INFIELD xmdz001 name="construct.c.page3.xmdz001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdz002
            #add-point:BEFORE FIELD xmdz002 name="construct.b.page3.xmdz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdz002
            
            #add-point:AFTER FIELD xmdz002 name="construct.a.page3.xmdz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdz002
            #add-point:ON ACTION controlp INFIELD xmdz002 name="construct.c.page3.xmdz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdz003
            #add-point:BEFORE FIELD xmdz003 name="construct.b.page3.xmdz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdz003
            
            #add-point:AFTER FIELD xmdz003 name="construct.a.page3.xmdz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdz003
            #add-point:ON ACTION controlp INFIELD xmdz003 name="construct.c.page3.xmdz003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdz004
            #add-point:BEFORE FIELD xmdz004 name="construct.b.page3.xmdz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdz004
            
            #add-point:AFTER FIELD xmdz004 name="construct.a.page3.xmdz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdz004
            #add-point:ON ACTION controlp INFIELD xmdz004 name="construct.c.page3.xmdz004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdz005
            #add-point:BEFORE FIELD xmdz005 name="construct.b.page3.xmdz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdz005
            
            #add-point:AFTER FIELD xmdz005 name="construct.a.page3.xmdz005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdz005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdz005
            #add-point:ON ACTION controlp INFIELD xmdz005 name="construct.c.page3.xmdz005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xmdw003,xmdw004,xmdw005,xmdw006,xmdw007,xmdw008,xmdw009,xmdw010,xmdw011, 
          xmdw012,xmdw013,xmdwsite,xmdw001,xmdw002
           FROM s_detail4[1].xmdw003,s_detail4[1].xmdw004,s_detail4[1].xmdw005,s_detail4[1].xmdw006, 
               s_detail4[1].xmdw007,s_detail4[1].xmdw008,s_detail4[1].xmdw009,s_detail4[1].xmdw010,s_detail4[1].xmdw011, 
               s_detail4[1].xmdw012,s_detail4[1].xmdw013,s_detail4[1].xmdwsite,s_detail4[1].xmdw001, 
               s_detail4[1].xmdw002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw003
            #add-point:BEFORE FIELD xmdw003 name="construct.b.page4.xmdw003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw003
            
            #add-point:AFTER FIELD xmdw003 name="construct.a.page4.xmdw003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw003
            #add-point:ON ACTION controlp INFIELD xmdw003 name="construct.c.page4.xmdw003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw004
            #add-point:BEFORE FIELD xmdw004 name="construct.b.page4.xmdw004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw004
            
            #add-point:AFTER FIELD xmdw004 name="construct.a.page4.xmdw004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw004
            #add-point:ON ACTION controlp INFIELD xmdw004 name="construct.c.page4.xmdw004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw005
            #add-point:BEFORE FIELD xmdw005 name="construct.b.page4.xmdw005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw005
            
            #add-point:AFTER FIELD xmdw005 name="construct.a.page4.xmdw005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw005
            #add-point:ON ACTION controlp INFIELD xmdw005 name="construct.c.page4.xmdw005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw006
            #add-point:BEFORE FIELD xmdw006 name="construct.b.page4.xmdw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw006
            
            #add-point:AFTER FIELD xmdw006 name="construct.a.page4.xmdw006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw006
            #add-point:ON ACTION controlp INFIELD xmdw006 name="construct.c.page4.xmdw006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw007
            #add-point:BEFORE FIELD xmdw007 name="construct.b.page4.xmdw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw007
            
            #add-point:AFTER FIELD xmdw007 name="construct.a.page4.xmdw007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw007
            #add-point:ON ACTION controlp INFIELD xmdw007 name="construct.c.page4.xmdw007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw008
            #add-point:BEFORE FIELD xmdw008 name="construct.b.page4.xmdw008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw008
            
            #add-point:AFTER FIELD xmdw008 name="construct.a.page4.xmdw008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw008
            #add-point:ON ACTION controlp INFIELD xmdw008 name="construct.c.page4.xmdw008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw009
            #add-point:BEFORE FIELD xmdw009 name="construct.b.page4.xmdw009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw009
            
            #add-point:AFTER FIELD xmdw009 name="construct.a.page4.xmdw009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw009
            #add-point:ON ACTION controlp INFIELD xmdw009 name="construct.c.page4.xmdw009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw010
            #add-point:BEFORE FIELD xmdw010 name="construct.b.page4.xmdw010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw010
            
            #add-point:AFTER FIELD xmdw010 name="construct.a.page4.xmdw010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw010
            #add-point:ON ACTION controlp INFIELD xmdw010 name="construct.c.page4.xmdw010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw011
            #add-point:BEFORE FIELD xmdw011 name="construct.b.page4.xmdw011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw011
            
            #add-point:AFTER FIELD xmdw011 name="construct.a.page4.xmdw011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw011
            #add-point:ON ACTION controlp INFIELD xmdw011 name="construct.c.page4.xmdw011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw012
            #add-point:BEFORE FIELD xmdw012 name="construct.b.page4.xmdw012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw012
            
            #add-point:AFTER FIELD xmdw012 name="construct.a.page4.xmdw012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw012
            #add-point:ON ACTION controlp INFIELD xmdw012 name="construct.c.page4.xmdw012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw013
            #add-point:BEFORE FIELD xmdw013 name="construct.b.page4.xmdw013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw013
            
            #add-point:AFTER FIELD xmdw013 name="construct.a.page4.xmdw013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw013
            #add-point:ON ACTION controlp INFIELD xmdw013 name="construct.c.page4.xmdw013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdwsite
            #add-point:BEFORE FIELD xmdwsite name="construct.b.page4.xmdwsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdwsite
            
            #add-point:AFTER FIELD xmdwsite name="construct.a.page4.xmdwsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdwsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdwsite
            #add-point:ON ACTION controlp INFIELD xmdwsite name="construct.c.page4.xmdwsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw001
            #add-point:BEFORE FIELD xmdw001 name="construct.b.page4.xmdw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw001
            
            #add-point:AFTER FIELD xmdw001 name="construct.a.page4.xmdw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw001
            #add-point:ON ACTION controlp INFIELD xmdw001 name="construct.c.page4.xmdw001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdw002
            #add-point:BEFORE FIELD xmdw002 name="construct.b.page4.xmdw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdw002
            
            #add-point:AFTER FIELD xmdw002 name="construct.a.page4.xmdw002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmdw002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdw002
            #add-point:ON ACTION controlp INFIELD xmdw002 name="construct.c.page4.xmdw002"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct   #备注单身  #161031-00025#21  
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
                  WHEN la_wc[li_idx].tableid = "xmdx_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmdy_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF g_argv[1] = '1' THEN 
      LET g_wc = g_wc, " AND xmdx001 = 'N' "
   ELSE
      LET g_wc = g_wc, " AND xmdx001 = 'Y' "
   END IF
   LET g_wc = g_wc," AND xmdxsite = '",g_site,"'"
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmt440_filter()
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
      CONSTRUCT g_wc_filter ON xmdxdocno,xmdxdocdt,xmdx002,xmdx003,xmdx004,xmdx005,xmdx014,xmdx015
                          FROM s_browse[1].b_xmdxdocno,s_browse[1].b_xmdxdocdt,s_browse[1].b_xmdx002, 
                              s_browse[1].b_xmdx003,s_browse[1].b_xmdx004,s_browse[1].b_xmdx005,s_browse[1].b_xmdx014, 
                              s_browse[1].b_xmdx015
 
         BEFORE CONSTRUCT
               DISPLAY axmt440_filter_parser('xmdxdocno') TO s_browse[1].b_xmdxdocno
            DISPLAY axmt440_filter_parser('xmdxdocdt') TO s_browse[1].b_xmdxdocdt
            DISPLAY axmt440_filter_parser('xmdx002') TO s_browse[1].b_xmdx002
            DISPLAY axmt440_filter_parser('xmdx003') TO s_browse[1].b_xmdx003
            DISPLAY axmt440_filter_parser('xmdx004') TO s_browse[1].b_xmdx004
            DISPLAY axmt440_filter_parser('xmdx005') TO s_browse[1].b_xmdx005
            DISPLAY axmt440_filter_parser('xmdx014') TO s_browse[1].b_xmdx014
            DISPLAY axmt440_filter_parser('xmdx015') TO s_browse[1].b_xmdx015
      
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
 
      CALL axmt440_filter_show('xmdxdocno')
   CALL axmt440_filter_show('xmdxdocdt')
   CALL axmt440_filter_show('xmdx002')
   CALL axmt440_filter_show('xmdx003')
   CALL axmt440_filter_show('xmdx004')
   CALL axmt440_filter_show('xmdx005')
   CALL axmt440_filter_show('xmdx014')
   CALL axmt440_filter_show('xmdx015')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmt440_filter_parser(ps_field)
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
 
{<section id="axmt440.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmt440_filter_show(ps_field)
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
   LET ls_condition = axmt440_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmt440_query()
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
   CALL g_xmdy_d.clear()
   CALL g_xmdy2_d.clear()
   CALL g_xmdy3_d.clear()
   CALL g_xmdy4_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#21 add  
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axmt440_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmt440_browser_fill("")
      CALL axmt440_fetch("")
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL axmt440_filter_show('xmdxdocno')
   CALL axmt440_filter_show('xmdxdocdt')
   CALL axmt440_filter_show('xmdx002')
   CALL axmt440_filter_show('xmdx003')
   CALL axmt440_filter_show('xmdx004')
   CALL axmt440_filter_show('xmdx005')
   CALL axmt440_filter_show('xmdx014')
   CALL axmt440_filter_show('xmdx015')
   CALL axmt440_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axmt440_fetch("F") 
      #顯示單身筆數
      CALL axmt440_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmt440_fetch(p_flag)
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
   CALL g_xmdy3_d.clear()
   CALL g_xmdy4_d.clear()
 
   
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
   
   LET g_xmdx_m.xmdxdocno = g_browser[g_current_idx].b_xmdxdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
   #遮罩相關處理
   LET g_xmdx_m_mask_o.* =  g_xmdx_m.*
   CALL axmt440_xmdx_t_mask()
   LET g_xmdx_m_mask_n.* =  g_xmdx_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt440_set_act_visible()   
   CALL axmt440_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
#   CASE g_xmdx_m.xmdxstus
#      WHEN "N"
#         CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
#      WHEN "Y"
#         CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
#      WHEN "X"
#         CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
#   END CASE  
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_xmdx_m.xmdxstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmdx_m_t.* = g_xmdx_m.*
   LET g_xmdx_m_o.* = g_xmdx_m.*
   
   LET g_data_owner = g_xmdx_m.xmdxownid      
   LET g_data_dept  = g_xmdx_m.xmdxowndp
   
   #重新顯示   
   CALL axmt440_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmt440_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xmdy_d.clear()   
   CALL g_xmdy2_d.clear()  
   CALL g_xmdy3_d.clear()  
   CALL g_xmdy4_d.clear()  
 
 
   INITIALIZE g_xmdx_m.* TO NULL             #DEFAULT 設定
   
   LET g_xmdxdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#21
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdx_m.xmdxownid = g_user
      LET g_xmdx_m.xmdxowndp = g_dept
      LET g_xmdx_m.xmdxcrtid = g_user
      LET g_xmdx_m.xmdxcrtdp = g_dept 
      LET g_xmdx_m.xmdxcrtdt = cl_get_current()
      LET g_xmdx_m.xmdxmodid = g_user
      LET g_xmdx_m.xmdxmoddt = cl_get_current()
      LET g_xmdx_m.xmdxstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmdx_m.xmdx000 = "0"
      LET g_xmdx_m.xmdxstus = "N"
      LET g_xmdx_m.xmdx008 = "N"
      LET g_xmdx_m.xmdx016 = "1"
      LET g_xmdx_m.xmdx017 = "1"
      LET g_xmdx_m.xmdx018 = "1"
      LET g_xmdx_m.xmdx019 = "N"
      LET g_xmdx_m.xmdx020 = "N"
      LET g_xmdx_m.xmdx010 = "N"
      LET g_xmdx_m.xmdx012 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_xmdx_m.xmdxdocdt = g_today
      LET g_xmdx_m.xmdx002 = g_user
      LET g_xmdx_m.xmdx003 = g_dept
      CALL axmt440_xmdx002_desc()  
      CALL axmt440_xmdx003_desc()       
      LET g_xmdx_m.xmdx014 = g_today
      LET g_xmdx_m.xmdxsite = g_site
      IF g_argv[1] = '1' THEN 
         LET g_xmdx_m.xmdx001 = 'N'
      ELSE
         LET g_xmdx_m.xmdx001 = 'Y'
      END IF
      LET g_xmdx_m_t.* = g_xmdx_m.*
      LET g_xmdx_m_o.* = g_xmdx_m.*  
      
      #161031-00025#21-s
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
      #161031-00025#21-e      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xmdx_m_t.* = g_xmdx_m.*
      LET g_xmdx_m_o.* = g_xmdx_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdx_m.xmdxstus 
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         
      END CASE
 
 
 
    
      CALL axmt440_input("a")
      
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
         INITIALIZE g_xmdx_m.* TO NULL
         INITIALIZE g_xmdy_d TO NULL
         INITIALIZE g_xmdy2_d TO NULL
         INITIALIZE g_xmdy3_d TO NULL
         INITIALIZE g_xmdy4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axmt440_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xmdy_d.clear()
      #CALL g_xmdy2_d.clear()
      #CALL g_xmdy3_d.clear()
      #CALL g_xmdy4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt440_set_act_visible()   
   CALL axmt440_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdxent = " ||g_enterprise|| " AND",
                      " xmdxdocno = '", g_xmdx_m.xmdxdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt440_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axmt440_cl
   
   CALL axmt440_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
   
   #遮罩相關處理
   LET g_xmdx_m_mask_o.* =  g_xmdx_m.*
   CALL axmt440_xmdx_t_mask()
   LET g_xmdx_m_mask_n.* =  g_xmdx_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
       g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
       g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
       g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
       g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite, 
       g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid, 
       g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xmdx_m.xmdxownid      
   LET g_data_dept  = g_xmdx_m.xmdxowndp
   
   #功能已完成,通報訊息中心
   CALL axmt440_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmt440_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_oodbl004   LIKE oodbl_t.oodbl004    #課稅原則
   DEFINE  l_oodb005    LIKE oodb_t.oodb005      #含稅否
   DEFINE  l_oodb006    LIKE oodb_t.oodb006      #稅率 
   DEFINE  l_success    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmdx_m_t.* = g_xmdx_m.*
   LET g_xmdx_m_o.* = g_xmdx_m.*
   
   IF g_xmdx_m.xmdxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
   CALL s_transaction_begin()
   
   OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt440_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
   #檢查是否允許此動作
   IF NOT axmt440_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdx_m_mask_o.* =  g_xmdx_m.*
   CALL axmt440_xmdx_t_mask()
   LET g_xmdx_m_mask_n.* =  g_xmdx_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   
   CALL axmt440_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
    
   WHILE TRUE
      LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xmdx_m.xmdxmodid = g_user 
LET g_xmdx_m.xmdxmoddt = cl_get_current()
LET g_xmdx_m.xmdxmodid_desc = cl_get_username(g_xmdx_m.xmdxmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      CALL axmt440_pmab089()
      CALL s_tax_chk(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx006)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,g_tax_app
      LET g_xmdx_m_t.* = g_xmdx_m.*
      LET g_xmdx_m_o.* = g_xmdx_m.*  
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_xmdx_m.xmdxstus MATCHES "[DR]" THEN 
         LET g_xmdx_m.xmdxstus = "N"
      END IF
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axmt440_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xmdx_t SET (xmdxmodid,xmdxmoddt) = (g_xmdx_m.xmdxmodid,g_xmdx_m.xmdxmoddt)
          WHERE xmdxent = g_enterprise AND xmdxdocno = g_xmdxdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xmdx_m.* = g_xmdx_m_t.*
            CALL axmt440_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xmdx_m.xmdxdocno != g_xmdx_m_t.xmdxdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xmdy_t SET xmdydocno = g_xmdx_m.xmdxdocno
 
          WHERE xmdyent = g_enterprise AND xmdydocno = g_xmdx_m_t.xmdxdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmdy_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
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
         UPDATE xmdz_t
            SET xmdzdocno = g_xmdx_m.xmdxdocno
 
          WHERE xmdzent = g_enterprise AND
                xmdzdocno = g_xmdxdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdz_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         UPDATE xmdw_t
            SET xmdw001 = g_xmdx_m.xmdxdocno
 
          WHERE xmdwent = g_enterprise AND
                xmdw001 = g_xmdxdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdw_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt440_set_act_visible()   
   CALL axmt440_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmdxent = " ||g_enterprise|| " AND",
                      " xmdxdocno = '", g_xmdx_m.xmdxdocno, "' "
 
   #填到對應位置
   CALL axmt440_browser_fill("")
 
   CLOSE axmt440_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt440_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axmt440.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmt440_input(p_cmd)
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
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_where          STRING
   DEFINE l_oodbl004       LIKE oodbl_t.oodbl004
   DEFINE l_pmaostus       LIKE pmao_t.pmaostus
   DEFINE l_pmao003        LIKE pmao_t.pmao003  #161221-00064#1 add
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
   DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
       g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
       g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
       g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
       g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite, 
       g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid, 
       g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt 
 
   
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
   LET g_forupd_sql = "SELECT xmdysite,xmdyseq,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007,xmdy014,xmdy008, 
       xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,xmdy004,xmdy030,xmdy001, 
       xmdy020,xmdy021,xmdy022,xmdy023 FROM xmdy_t WHERE xmdyent=? AND xmdydocno=? AND xmdyseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
#   LET g_forupd_sql = "SELECT xmdysite,xmdyseq,xmdy002,'','',xmdy003,xmdy005,xmdy006,'',xmdy007,xmdy014, 
#       '',xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,'',xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,'',xmdy004,
#       xmdy030,xmdy001,
#       xmdyseq,xmdy002,'','',xmdy003,xmdy006,xmdy007,xmdy008,xmdy009,xmdy010,
#       xmdy020,xmdy021,xmdy022,xmdy023,
#       xmdy009-xmdy020,xmdy017-xmdy021,xmdy018-xmdy022,xmdy019-xmdy023
#       FROM xmdy_t WHERE xmdyent=?  
#       AND xmdydocno=? AND xmdyseq=? FOR UPDATE"
       
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt440_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmdzseq,xmdzseq1,xmdz001,xmdz002,xmdz003,xmdz004,xmdz005 FROM xmdz_t WHERE  
       xmdzent=? AND xmdzdocno=? AND xmdzseq=? AND xmdzseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt440_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmdw003,xmdw004,xmdw005,xmdw006,xmdw007,xmdw008,xmdw009,xmdw010,xmdw011, 
       xmdw012,xmdw013,xmdwsite,xmdw001,xmdw002 FROM xmdw_t WHERE xmdwent=? AND xmdw001=? AND xmdw002=?  
       AND xmdw003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt440_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
 
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmt440_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   #161031-00025#21-s
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #161031-00025#21-e
   #end add-point
   CALL axmt440_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009, 
       g_xmdx_m.xmdx011,g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019, 
       g_xmdx_m.xmdx020,g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015, 
       g_xmdx_m.xmdxsite
   
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
 
{<section id="axmt440.input.head" >}
      #單頭段
      INPUT BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003, 
          g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009, 
          g_xmdx_m.xmdx011,g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019, 
          g_xmdx_m.xmdx020,g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015, 
          g_xmdx_m.xmdxsite 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt440_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt440_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axmt440_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axmt440_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxdocno
            
            #add-point:AFTER FIELD xmdxdocno name="input.a.xmdxdocno"
            CALL axmt440_xmdxdocno_desc('1',g_xmdx_m.xmdxdocno) RETURNING g_xmdx_m.xmdxdocno_desc
            DISPLAY BY NAME g_xmdx_m.xmdxdocno_desc
            IF NOT cl_null(g_xmdx_m.xmdxdocno) THEN 
               CALL s_aooi200_chk_slip(g_site,g_ooef.ooef004,g_xmdx_m.xmdxdocno,g_prog) RETURNING g_success
               IF NOT g_success THEN
                  LET g_xmdx_m.xmdxdocno = g_xmdx_m_t.xmdxdocno               
                  NEXT FIELD CURRENT
               END IF
               CALL axmt440_xmdx015_def()
               CALL axmt440_slip_default()
            ELSE
               NEXT FIELD CURRENT            
            END IF          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxdocno
            #add-point:BEFORE FIELD xmdxdocno name="input.b.xmdxdocno"
            CALL axmt440_xmdxdocno_desc('1',g_xmdx_m.xmdxdocno) RETURNING g_xmdx_m.xmdxdocno_desc
            DISPLAY BY NAME g_xmdx_m.xmdxdocno_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdxdocno
            #add-point:ON CHANGE xmdxdocno name="input.g.xmdxdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxdocdt
            #add-point:BEFORE FIELD xmdxdocdt name="input.b.xmdxdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxdocdt
            
            #add-point:AFTER FIELD xmdxdocdt name="input.a.xmdxdocdt"
            IF cl_null(g_xmdx_m.xmdxdocdt) THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdxdocdt
            #add-point:ON CHANGE xmdxdocdt name="input.g.xmdxdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx004
            
            #add-point:AFTER FIELD xmdx004 name="input.a.xmdx004"
            CALL axmt440_xmdx004_desc()
  
            IF NOT cl_null(g_xmdx_m.xmdx004) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdx_m.xmdx004               
               LET g_chkparam.arg2 = g_site
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
               #160318-00025#17  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_3") THEN
#                  CALL s_control_chk_group('1','2',g_user,g_dept,g_xmdx_m.xmdx004,'','','','') RETURNING l_success,l_flag
#                  IF l_success THEN 
#                     IF NOT l_flag THEN 
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'axm-00007'
#                        LET g_errparam.extend = g_xmdx_m.xmdx004
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
#                        NEXT FIELD CURRENT
#                     END IF
#                  ELSE
#                     LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
#                     NEXT FIELD CURRENT                  
#                  END IF
#                  CALL s_control_chk_doc('3',g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx004,'','','','') RETURNING l_success,l_flag
#                  IF l_success THEN 
#                     IF NOT l_flag THEN 
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'axm-00006'
#                        LET g_errparam.extend = g_xmdx_m.xmdx004
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
#                        NEXT FIELD CURRENT
#                     END IF
#                  ELSE
#                     LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
#                     NEXT FIELD CURRENT                      
#                  END IF
                  IF NOT s_control_check_customer(g_xmdx_m.xmdx004,'2',g_site,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxdocno) THEN
                     LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
                     NEXT FIELD CURRENT                     
                  END IF
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdx_m.xmdx004 != g_xmdx_m_o.xmdx004 OR cl_null(g_xmdx_m_o.xmdx004))) THEN 
                     CALL axmt440_xmdx004_ref()
                     IF p_cmd = 'u' AND (g_xmdx_m.xmdx004 != g_xmdx_m_o.xmdx004 OR cl_null(g_xmdx_m_o.xmdx004)) THEN                    
                        CALL axmt440_xmdy005_upd()                     
                     END IF
                     CALL axmt440_set_entry(p_cmd)
                     CALL axmt440_set_no_entry(p_cmd)
                     IF p_cmd = 'u' AND (g_xmdx_m.xmdx005 != g_xmdx_m_o.xmdx005 OR cl_null(g_xmdx_m_o.xmdx005)) THEN
                        CALL axmt440_xmdy_upd()
                     END IF
                     IF p_cmd = 'u' AND (g_xmdx_m.xmdx006 <> g_xmdx_m_o.xmdx006 OR cl_null(g_xmdx_m_o.xmdx006)) THEN 
                        IF cl_ask_confirm('apm-00351') THEN
                           CALL s_tax_chk(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx006)
                                RETURNING l_success,l_oodbl004,g_xmdx_m.xmdx008,g_xmdx_m.xmdx007,g_tax_app
                           CALL axmt440_change_xmdx011(p_cmd)
                        END IF   
                     END IF                      
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdx_m.xmdx004 = g_xmdx_m_t.xmdx004
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_xmdx_m_o.xmdx004 = g_xmdx_m.xmdx004
            LET g_xmdx_m_o.xmdx005 = g_xmdx_m.xmdx005
            LET g_xmdx_m_o.xmdx006 = g_xmdx_m.xmdx006            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx004
            #add-point:BEFORE FIELD xmdx004 name="input.b.xmdx004"
            CALL axmt440_xmdx004_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx004
            #add-point:ON CHANGE xmdx004 name="input.g.xmdx004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx002
            
            #add-point:AFTER FIELD xmdx002 name="input.a.xmdx002"
            CALL axmt440_xmdx002_desc()
            IF NOT cl_null(g_xmdx_m.xmdx002) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdx_m.xmdx002 
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#17  by 07900 --add-end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  CALL axmt440_xmdx002_ref() 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdx_m.xmdx002 = g_xmdx_m_t.xmdx002 
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx002
            #add-point:BEFORE FIELD xmdx002 name="input.b.xmdx002"
            CALL axmt440_xmdx002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx002
            #add-point:ON CHANGE xmdx002 name="input.g.xmdx002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx003
            
            #add-point:AFTER FIELD xmdx003 name="input.a.xmdx003"
            CALL axmt440_xmdx003_desc()
            IF NOT cl_null(g_xmdx_m.xmdx003) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdx_m.xmdx003
               LET g_chkparam.arg2 = g_xmdx_m.xmdxdocdt
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdx_m.xmdx003 = g_xmdx_m_t.xmdx003 
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx003
            #add-point:BEFORE FIELD xmdx003 name="input.b.xmdx003"
            CALL axmt440_xmdx003_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx003
            #add-point:ON CHANGE xmdx003 name="input.g.xmdx003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxstus
            #add-point:BEFORE FIELD xmdxstus name="input.b.xmdxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxstus
            
            #add-point:AFTER FIELD xmdxstus name="input.a.xmdxstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdxstus
            #add-point:ON CHANGE xmdxstus name="input.g.xmdxstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx005
            
            #add-point:AFTER FIELD xmdx005 name="input.a.xmdx005"
            CALL axmt440_xmdx005_desc()
            IF NOT cl_null(g_xmdx_m.xmdx005) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL  
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdx_m.xmdxsite
               LET g_chkparam.arg2 = g_xmdx_m.xmdx005
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdx_m.xmdx005 = g_xmdx_m_t.xmdx005
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'u' AND (g_xmdx_m.xmdx005 != g_xmdx_m_o.xmdx005 OR cl_null(g_xmdx_m_o.xmdx005)) THEN
                  CALL axmt440_xmdy_upd()
               END IF               
            END IF 
            LET g_xmdx_m_o.xmdx005 = g_xmdx_m.xmdx005            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx005
            #add-point:BEFORE FIELD xmdx005 name="input.b.xmdx005"
            CALL axmt440_xmdx005_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx005
            #add-point:ON CHANGE xmdx005 name="input.g.xmdx005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx006
            
            #add-point:AFTER FIELD xmdx006 name="input.a.xmdx006"
            CALL axmt440_xmdx006_desc()
            IF NOT cl_null(g_xmdx_m.xmdx006) THEN 
               CALL s_tax_chk(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx006)
                    RETURNING l_success,l_oodbl004,g_xmdx_m.xmdx008,g_xmdx_m.xmdx007,g_tax_app
               IF NOT l_success THEN
                  LET g_xmdx_m.xmdx006 = g_xmdx_m_t.xmdx006
                  LET g_xmdx_m.xmdx007 = g_xmdx_m_t.xmdx007
                  LET g_xmdx_m.xmdx008 = g_xmdx_m_t.xmdx008
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'u' AND (g_xmdx_m.xmdx006 <> g_xmdx_m_o.xmdx006 OR cl_null(g_xmdx_m_o.xmdx006)) THEN 
                  IF cl_ask_confirm('apm-00351') THEN
                     CALL axmt440_change_xmdx011(p_cmd)
                  END IF   
               END IF               
            END IF
            LET g_xmdx_m_o.xmdx006 = g_xmdx_m.xmdx006            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx006
            #add-point:BEFORE FIELD xmdx006 name="input.b.xmdx006"
            CALL axmt440_xmdx006_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx006
            #add-point:ON CHANGE xmdx006 name="input.g.xmdx006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx007
            #add-point:BEFORE FIELD xmdx007 name="input.b.xmdx007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx007
            
            #add-point:AFTER FIELD xmdx007 name="input.a.xmdx007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx007
            #add-point:ON CHANGE xmdx007 name="input.g.xmdx007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx008
            #add-point:BEFORE FIELD xmdx008 name="input.b.xmdx008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx008
            
            #add-point:AFTER FIELD xmdx008 name="input.a.xmdx008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx008
            #add-point:ON CHANGE xmdx008 name="input.g.xmdx008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx009
            
            #add-point:AFTER FIELD xmdx009 name="input.a.xmdx009"
            CALL axmt440_xmdx009_desc()
            IF NOT cl_null(g_xmdx_m.xmdx009) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdx_m.xmdx004
               LET g_chkparam.arg2 = g_xmdx_m.xmdx009
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmad002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdx_m.xmdx009 = g_xmdx_m_t.xmdx009
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_xmdx_m.xmdx010 = 'N'             
            END IF
            CALL axmt440_set_entry(p_cmd)
            CALL axmt440_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx009
            #add-point:BEFORE FIELD xmdx009 name="input.b.xmdx009"
            CALL axmt440_xmdx009_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx009
            #add-point:ON CHANGE xmdx009 name="input.g.xmdx009"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx011
            
            #add-point:AFTER FIELD xmdx011 name="input.a.xmdx011"
            CALL axmt440_xmdx011_desc()
            IF NOT cl_null(g_xmdx_m.xmdx011) THEN 
               IF NOT s_azzi650_chk_exist('238',g_xmdx_m.xmdx011) THEN
                  LET g_xmdx_m.xmdx011 = g_xmdx_m_t.xmdx011
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_xmdx_m.xmdx012 = 'N'            
            END IF
            CALL axmt440_set_entry(p_cmd)
            CALL axmt440_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx011
            #add-point:BEFORE FIELD xmdx011 name="input.b.xmdx011"
            CALL axmt440_xmdx011_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx011
            #add-point:ON CHANGE xmdx011 name="input.g.xmdx011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx030
            #add-point:BEFORE FIELD xmdx030 name="input.b.xmdx030"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx030
            
            #add-point:AFTER FIELD xmdx030 name="input.a.xmdx030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx030
            #add-point:ON CHANGE xmdx030 name="input.g.xmdx030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx016
            #add-point:BEFORE FIELD xmdx016 name="input.b.xmdx016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx016
            
            #add-point:AFTER FIELD xmdx016 name="input.a.xmdx016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx016
            #add-point:ON CHANGE xmdx016 name="input.g.xmdx016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx017
            #add-point:BEFORE FIELD xmdx017 name="input.b.xmdx017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx017
            
            #add-point:AFTER FIELD xmdx017 name="input.a.xmdx017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx017
            #add-point:ON CHANGE xmdx017 name="input.g.xmdx017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx018
            #add-point:BEFORE FIELD xmdx018 name="input.b.xmdx018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx018
            
            #add-point:AFTER FIELD xmdx018 name="input.a.xmdx018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx018
            #add-point:ON CHANGE xmdx018 name="input.g.xmdx018"
            IF g_xmdx_m.xmdx018 = '1' THEN 
               CALL cl_set_comp_required('xmdy009',TRUE)
            ELSE
               CALL cl_set_comp_required('xmdy009',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx019
            #add-point:BEFORE FIELD xmdx019 name="input.b.xmdx019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx019
            
            #add-point:AFTER FIELD xmdx019 name="input.a.xmdx019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx019
            #add-point:ON CHANGE xmdx019 name="input.g.xmdx019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx020
            #add-point:BEFORE FIELD xmdx020 name="input.b.xmdx020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx020
            
            #add-point:AFTER FIELD xmdx020 name="input.a.xmdx020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx020
            #add-point:ON CHANGE xmdx020 name="input.g.xmdx020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx010
            #add-point:BEFORE FIELD xmdx010 name="input.b.xmdx010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx010
            
            #add-point:AFTER FIELD xmdx010 name="input.a.xmdx010"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx010
            #add-point:ON CHANGE xmdx010 name="input.g.xmdx010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx012
            #add-point:BEFORE FIELD xmdx012 name="input.b.xmdx012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx012
            
            #add-point:AFTER FIELD xmdx012 name="input.a.xmdx012"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx012
            #add-point:ON CHANGE xmdx012 name="input.g.xmdx012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx001
            #add-point:BEFORE FIELD xmdx001 name="input.b.xmdx001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx001
            
            #add-point:AFTER FIELD xmdx001 name="input.a.xmdx001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx001
            #add-point:ON CHANGE xmdx001 name="input.g.xmdx001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx014
            #add-point:BEFORE FIELD xmdx014 name="input.b.xmdx014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx014
            
            #add-point:AFTER FIELD xmdx014 name="input.a.xmdx014"
            IF NOT cl_null(g_xmdx_m.xmdx014) THEN 
               IF g_xmdx_m.xmdx015 < g_xmdx_m.xmdx014 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_xmdx_m.xmdx015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xmdx_m.xmdx014 = g_xmdx_m_t.xmdx014
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmdx_m.xmdx014 <> g_xmdx_m_o.xmdx014 OR cl_null(g_xmdx_m_o.xmdx014))) THEN
                  CALL axmt440_xmdx015_def()
               END IF   
            END IF
            LET g_xmdx_m_o.xmdx014 = g_xmdx_m.xmdx014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx014
            #add-point:ON CHANGE xmdx014 name="input.g.xmdx014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdx015
            #add-point:BEFORE FIELD xmdx015 name="input.b.xmdx015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdx015
            
            #add-point:AFTER FIELD xmdx015 name="input.a.xmdx015"
            IF NOT cl_null(g_xmdx_m.xmdx015) THEN 
               IF g_xmdx_m.xmdx015 < g_xmdx_m.xmdx014 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00048'
                  LET g_errparam.extend = g_xmdx_m.xmdx015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xmdx_m.xmdx015 = g_xmdx_m_t.xmdx015 
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdx015
            #add-point:ON CHANGE xmdx015 name="input.g.xmdx015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdxsite
            #add-point:BEFORE FIELD xmdxsite name="input.b.xmdxsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdxsite
            
            #add-point:AFTER FIELD xmdxsite name="input.a.xmdxsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdxsite
            #add-point:ON CHANGE xmdxsite name="input.g.xmdxsite"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmdxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxdocno
            #add-point:ON ACTION controlp INFIELD xmdxdocno name="input.c.xmdxdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdxdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004
            #LET g_qryparam.arg2 = 'axmt440'     #160705-00042#6 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#6 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_xmdx_m.xmdxdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdxdocno TO xmdxdocno              #顯示到畫面上

            NEXT FIELD xmdxdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdxdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxdocdt
            #add-point:ON ACTION controlp INFIELD xmdxdocdt name="input.c.xmdxdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx004
            #add-point:ON ACTION controlp INFIELD xmdx004 name="input.c.xmdx004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdx_m.xmdx004             #給予default值
            LET l_where = ''
            CALL s_control_get_customer_sql('2',g_site,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxdocno) RETURNING g_success,l_where
            LET g_qryparam.where = l_where
            #給予arg
            LET g_qryparam.arg1 = g_site
            
            CALL q_pmaa001_6()                                #呼叫開窗
            LET g_xmdx_m.xmdx004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdx_m.xmdx004 TO xmdx004              #顯示到畫面上
            NEXT FIELD xmdx004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx002
            #add-point:ON ACTION controlp INFIELD xmdx002 name="input.c.xmdx002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx002             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_xmdx_m.xmdx002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdx002 TO xmdx002              #顯示到畫面上

            NEXT FIELD xmdx002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx003
            #add-point:ON ACTION controlp INFIELD xmdx003 name="input.c.xmdx003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmdx_m.xmdxdocdt

            CALL q_ooeg001()                                #呼叫開窗

            LET g_xmdx_m.xmdx003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdx003 TO xmdx003              #顯示到畫面上

            NEXT FIELD xmdx003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxstus
            #add-point:ON ACTION controlp INFIELD xmdxstus name="input.c.xmdxstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx005
            #add-point:ON ACTION controlp INFIELD xmdx005 name="input.c.xmdx005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmdx_m.xmdxsite
            CALL q_ooaj002_3()                                #呼叫開窗

            LET g_xmdx_m.xmdx005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdx005 TO xmdx005              #顯示到畫面上

            NEXT FIELD xmdx005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx006
            #add-point:ON ACTION controlp INFIELD xmdx006 name="input.c.xmdx006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx006             #給予default值
            LET g_qryparam.default2 = "" #g_xmdx_m.oodb002 #稅別代碼
            LET g_qryparam.where = " oodb001 = '",g_ooef.ooef019,"'"
            #給予arg

            CALL q_oodb002_4()                                #呼叫開窗

            LET g_xmdx_m.xmdx006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_xmdx_m.oodb002 = g_qryparam.return2 #稅別代碼

            DISPLAY g_xmdx_m.xmdx006 TO xmdx006              #顯示到畫面上
            #DISPLAY g_xmdx_m.oodb002 TO oodb002 #稅別代碼

            NEXT FIELD xmdx006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx007
            #add-point:ON ACTION controlp INFIELD xmdx007 name="input.c.xmdx007"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx008
            #add-point:ON ACTION controlp INFIELD xmdx008 name="input.c.xmdx008"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx009
            #add-point:ON ACTION controlp INFIELD xmdx009 name="input.c.xmdx009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmdx_m.xmdx004
            CALL q_pmad002_3()                                #呼叫開窗

            LET g_xmdx_m.xmdx009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdx009 TO xmdx009              #顯示到畫面上

            NEXT FIELD xmdx009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx011
            #add-point:ON ACTION controlp INFIELD xmdx011 name="input.c.xmdx011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdx_m.xmdx011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '238'

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmdx_m.xmdx011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdx_m.xmdx011 TO xmdx011              #顯示到畫面上

            NEXT FIELD xmdx011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmdx030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx030
            #add-point:ON ACTION controlp INFIELD xmdx030 name="input.c.xmdx030"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx016
            #add-point:ON ACTION controlp INFIELD xmdx016 name="input.c.xmdx016"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx017
            #add-point:ON ACTION controlp INFIELD xmdx017 name="input.c.xmdx017"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx018
            #add-point:ON ACTION controlp INFIELD xmdx018 name="input.c.xmdx018"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx019
            #add-point:ON ACTION controlp INFIELD xmdx019 name="input.c.xmdx019"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx020
            #add-point:ON ACTION controlp INFIELD xmdx020 name="input.c.xmdx020"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx010
            #add-point:ON ACTION controlp INFIELD xmdx010 name="input.c.xmdx010"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx012
            #add-point:ON ACTION controlp INFIELD xmdx012 name="input.c.xmdx012"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx001
            #add-point:ON ACTION controlp INFIELD xmdx001 name="input.c.xmdx001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx014
            #add-point:ON ACTION controlp INFIELD xmdx014 name="input.c.xmdx014"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdx015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdx015
            #add-point:ON ACTION controlp INFIELD xmdx015 name="input.c.xmdx015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmdxsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdxsite
            #add-point:ON ACTION controlp INFIELD xmdxsite name="input.c.xmdxsite"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmdx_m.xmdxdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_ooef.ooef001,g_xmdx_m.xmdxdocno,g_xmdx_m.xmdxdocdt,g_prog)
                  RETURNING l_success,g_xmdx_m.xmdxdocno
                  IF l_success  = 0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_xmdx_m.xmdxdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD xmdxdocno
                  END IF 
                  DISPLAY BY NAME g_xmdx_m.xmdxdocno
               #end add-point
               
               INSERT INTO xmdx_t (xmdxent,xmdxdocno,xmdx000,xmdxdocdt,xmdx004,xmdx002,xmdx003,xmdxstus, 
                   xmdx005,xmdx006,xmdx007,xmdx008,xmdx009,xmdx011,xmdx030,xmdx016,xmdx017,xmdx018,xmdx019, 
                   xmdx020,xmdx010,xmdx012,xmdx001,xmdx014,xmdx015,xmdxsite,xmdxownid,xmdxowndp,xmdxcrtid, 
                   xmdxcrtdp,xmdxcrtdt,xmdxmodid,xmdxmoddt,xmdxcnfid,xmdxcnfdt)
               VALUES (g_enterprise,g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
                   g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx006, 
                   g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
                   g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
                   g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015, 
                   g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp, 
                   g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xmdx_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_ooff003_d = g_xmdx_m.xmdxdocno   #161031-00025#21 add  
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                 
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmt440_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axmt440_b_fill()
                  CALL axmt440_b_fill2('0')
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
               CALL axmt440_xmdx_t_mask_restore('restore_mask_o')
               
               UPDATE xmdx_t SET (xmdxdocno,xmdx000,xmdxdocdt,xmdx004,xmdx002,xmdx003,xmdxstus,xmdx005, 
                   xmdx006,xmdx007,xmdx008,xmdx009,xmdx011,xmdx030,xmdx016,xmdx017,xmdx018,xmdx019,xmdx020, 
                   xmdx010,xmdx012,xmdx001,xmdx014,xmdx015,xmdxsite,xmdxownid,xmdxowndp,xmdxcrtid,xmdxcrtdp, 
                   xmdxcrtdt,xmdxmodid,xmdxmoddt,xmdxcnfid,xmdxcnfdt) = (g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
                   g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus, 
                   g_xmdx_m.xmdx005,g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009, 
                   g_xmdx_m.xmdx011,g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018, 
                   g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001, 
                   g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid,g_xmdx_m.xmdxowndp, 
                   g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid,g_xmdx_m.xmdxmoddt, 
                   g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt)
                WHERE xmdxent = g_enterprise AND xmdxdocno = g_xmdxdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmdx_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axmt440_xmdx_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xmdx_m_t)
               LET g_log2 = util.JSON.stringify(g_xmdx_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axmt440.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmdy_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmdy_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt440_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmdy_d.getLength()
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
            CALL axmt440_b_fill2('2')
CALL axmt440_b_fill2('3')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt440_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt440_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmdy_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmdy_d[l_ac].xmdyseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmdy_d_t.* = g_xmdy_d[l_ac].*  #BACKUP
               LET g_xmdy_d_o.* = g_xmdy_d[l_ac].*  #BACKUP
               CALL axmt440_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL axmt440_set_no_entry_b(l_cmd)
               IF NOT axmt440_lock_b("xmdy_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt440_bcl INTO g_xmdy_d[l_ac].xmdysite,g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy002, 
                      g_xmdy_d[l_ac].xmdy003,g_xmdy_d[l_ac].xmdy005,g_xmdy_d[l_ac].xmdy006,g_xmdy_d[l_ac].xmdy007, 
                      g_xmdy_d[l_ac].xmdy014,g_xmdy_d[l_ac].xmdy008,g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010, 
                      g_xmdy_d[l_ac].xmdy024,g_xmdy_d[l_ac].xmdy011,g_xmdy_d[l_ac].xmdy012,g_xmdy_d[l_ac].xmdy017, 
                      g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019,g_xmdy_d[l_ac].xmdy013,g_xmdy_d[l_ac].xmdy004, 
                      g_xmdy_d[l_ac].xmdy030,g_xmdy_d[l_ac].xmdy001,g_xmdy2_d[l_ac].xmdy020,g_xmdy2_d[l_ac].xmdy021, 
                      g_xmdy2_d[l_ac].xmdy022,g_xmdy2_d[l_ac].xmdy023
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmdy_d_t.xmdyseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmdy_d_mask_o[l_ac].* =  g_xmdy_d[l_ac].*
                  CALL axmt440_xmdy_t_mask()
                  LET g_xmdy_d_mask_n[l_ac].* =  g_xmdy_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt440_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_xmdy_d_o.* = g_xmdy_d[l_ac].*
            LET g_pmao_flag ='N'
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
            INITIALIZE g_xmdy_d[l_ac].* TO NULL 
            INITIALIZE g_xmdy_d_t.* TO NULL 
            INITIALIZE g_xmdy_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xmdy_d[l_ac].xmdy024 = "N"
      LET g_xmdy_d[l_ac].xmdy012 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_pmao_flag = 'N'
            #end add-point
            LET g_xmdy_d_t.* = g_xmdy_d[l_ac].*     #新輸入資料
            LET g_xmdy_d_o.* = g_xmdy_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt440_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt440_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmdy_d[li_reproduce_target].* = g_xmdy_d[li_reproduce].*
               LET g_xmdy2_d[li_reproduce_target].* = g_xmdy2_d[li_reproduce].*
 
               LET g_xmdy_d[li_reproduce_target].xmdyseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_xmdy_d[l_ac].xmdysite = g_xmdx_m.xmdxsite
            LET g_xmdy_d[l_ac].xmdy001 = g_xmdx_m.xmdx001
#           LET g_xmdy_d[l_ac].xmdy003 = ' '
            LET g_xmdy_d[l_ac].xmdy004 = ' '
            LET g_xmdy_d[l_ac].xmdy006 = ' '
            LET g_xmdy_d[l_ac].xmdy007 = ' '
            IF cl_null(g_xmdy_d[l_ac].xmdyseq) THEN
               SELECT MAX(xmdyseq) INTO g_xmdy_d[l_ac].xmdyseq
                 FROM xmdy_t
                WHERE xmdyent = g_enterprise
                  AND xmdydocno = g_xmdx_m.xmdxdocno
               IF cl_null(g_xmdy_d[l_ac].xmdyseq) THEN
                  LET g_xmdy_d[l_ac].xmdyseq = 1
               ELSE
                  LET g_xmdy_d[l_ac].xmdyseq = g_xmdy_d[l_ac].xmdyseq + 1
               END IF
            END IF 
            #--151105--polly--add--(s)
             LET g_xmdy2_d[l_ac].xmdy020 = 0        
             LET g_xmdy2_d[l_ac].xmdy021 = 0
             LET g_xmdy2_d[l_ac].xmdy022 = 0
             LET g_xmdy2_d[l_ac].xmdy023 = 0
            #--151105--polly--add--(e)            
            LET g_xmdy_d_t.* = g_xmdy_d[l_ac].*
            LET g_xmdy_d_o.* = g_xmdy_d[l_ac].*            
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
            IF g_xmdy_d[l_ac].xmdy024 = 'N' THEN
               DELETE FROM xmdz_t
                     WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdx_m.xmdxdocno
                       AND xmdzseq = g_xmdy_d[l_ac].xmdyseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmdz_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmdy_t 
             WHERE xmdyent = g_enterprise AND xmdydocno = g_xmdx_m.xmdxdocno
 
               AND xmdyseq = g_xmdy_d[l_ac].xmdyseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdx_m.xmdxdocno
               LET gs_keys[2] = g_xmdy_d[g_detail_idx].xmdyseq
               CALL axmt440_insert_b('xmdy_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161031-00025#21-s
               IF NOT cl_null(g_xmdy_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1',g_xmdy_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#21-e
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xmdy_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt440_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL axmt440_ins_pmao()
               #161031-00025#21-s
               IF NOT cl_null(g_xmdy_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1',g_xmdy_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#21-e
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
               LET gs_keys[01] = g_xmdx_m.xmdxdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xmdy_d_t.xmdyseq
 
            
               #刪除同層單身
               IF NOT axmt440_delete_b('xmdy_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt440_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt440_key_delete_b(gs_keys,'xmdy_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt440_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #161031-00025#21-s
               CALL s_aooi360_del('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d_t.xmdyseq,'','','','','','','','1') RETURNING l_success
               #161031-00025#21-e 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt440_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM xmdz_t
                   WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdx_m.xmdxdocno AND
                         xmdzseq = g_xmdy_d_t.xmdyseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdz_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF                         
               #end add-point
               LET l_count = g_xmdy_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmdy_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdysite
            #add-point:BEFORE FIELD xmdysite name="input.b.page1.xmdysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdysite
            
            #add-point:AFTER FIELD xmdysite name="input.a.page1.xmdysite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdysite
            #add-point:ON CHANGE xmdysite name="input.g.page1.xmdysite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdyseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdy_d[l_ac].xmdyseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmdyseq
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdyseq name="input.a.page1.xmdyseq"
            #此段落由子樣板a05產生
            IF  g_xmdx_m.xmdxdocno IS NOT NULL AND g_xmdy_d[g_detail_idx].xmdyseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdx_m.xmdxdocno != g_xmdxdocno_t OR g_xmdy_d[g_detail_idx].xmdyseq != g_xmdy_d_t.xmdyseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdy_t WHERE "||"xmdyent = '" ||g_enterprise|| "' AND "||"xmdydocno = '"||g_xmdx_m.xmdxdocno ||"' AND "|| "xmdyseq = '"||g_xmdy_d[g_detail_idx].xmdyseq ||"'",'std-00004',0) THEN 
                     LET g_xmdy_d[l_ac].xmdyseq = g_xmdy_d_t.xmdyseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdyseq
            #add-point:BEFORE FIELD xmdyseq name="input.b.page1.xmdyseq"
            IF cl_null(g_xmdy_d[l_ac].xmdyseq) AND l_cmd = 'a' THEN
               SELECT MAX(xmdyseq) INTO g_xmdy_d[l_ac].xmdyseq
                 FROM xmdy_t
                WHERE xmdyent = g_enterprise
                  AND xmdydocno = g_xmdx_m.xmdxdocno
               IF cl_null(g_xmdy_d[l_ac].xmdyseq) THEN
                  LET g_xmdy_d[l_ac].xmdyseq = 1
               ELSE
                  LET g_xmdy_d[l_ac].xmdyseq = g_xmdy_d[l_ac].xmdyseq + 1
               END IF
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdyseq
            #add-point:ON CHANGE xmdyseq name="input.g.page1.xmdyseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy002
            
            #add-point:AFTER FIELD xmdy002 name="input.a.page1.xmdy002"
            CALL axmt440_xmdy002_desc()
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy002) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdy_d[l_ac].xmdy002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_1") THEN
                  #檢查成功時後續處理
#                  CALL s_control_chk_doc('4',g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx003,'','','','') RETURNING l_success,l_flag
#                  IF l_success THEN 
#                     IF NOT l_flag THEN 
#                        LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
#                        NEXT FIELD CURRENT
#                     END IF
#                  ELSE
#                     LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
#                     NEXT FIELD CURRENT                  
#                  END IF
#                  CALL s_control_chk_doc('5',g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx003,'','','','') RETURNING l_success,l_flag
#                  IF l_success THEN 
#                     IF NOT l_flag THEN 
#                        LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
#                        NEXT FIELD CURRENT
#                     END IF
#                  ELSE
#                     LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
#                     NEXT FIELD CURRENT                  
#                  END IF
                  IF NOT s_control_check_item(g_xmdy_d[l_ac].xmdy002,'2',g_site,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxdocno) THEN 
                     LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
                     NEXT FIELD CURRENT
                  END IF
                  IF g_xmdy_d[l_ac].xmdy002 <> g_xmdy_d_o.xmdy002 OR cl_null(g_xmdy_d_o.xmdy002) THEN   
#                     LET g_xmdy_d[l_ac].xmdy003 = ' '
                     INITIALIZE g_xmdy_d[l_ac].xmdy003 TO NULL   #add--2015/03/31 By shiun
                     DISPLAY BY NAME g_xmdy_d[l_ac].xmdy003
                     CALL axmt440_xmdy002_xmdy003_ref(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) RETURNING g_xmdy_d[l_ac].xmdy005
                     DISPLAY BY NAME g_xmdy_d[l_ac].xmdy005
                     CALL axmt440_xmdy002_ref()
                  END IF                     
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdy_d[l_ac].xmdy002 = g_xmdy_d_t.xmdy002
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161221-00064#1 add-S
            IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
               LET l_pmao003 = ' '
            ELSE
               LET l_pmao003 = g_xmdy_d[l_ac].xmdy003
            END IF
            #161221-00064#1 add-E
            SELECT pmao009,pmao010
              INTO g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdx_m.xmdx004
               AND pmao002 = g_xmdy_d[l_ac].xmdy002
               #161221-00064#1 mod-S
#               AND pmao003 = g_xmdy_d[l_ac].xmdy003
               AND pmao003 = l_pmao003
               #161221-00064#1 mod-E
               AND pmao004 = g_xmdy_d[l_ac].xmdy005  
               AND pmao000 = '2'   #161221-00064#1 add       
            DISPLAY BY NAME g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
            CALL axmt440_set_entry_b('') 
            CALL axmt440_set_no_entry_b('')            
            LET g_xmdy_d_o.xmdy002 = g_xmdy_d[l_ac].xmdy002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy002
            #add-point:BEFORE FIELD xmdy002 name="input.b.page1.xmdy002"
            CALL axmt440_xmdy002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy002
            #add-point:ON CHANGE xmdy002 name="input.g.page1.xmdy002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy003
            
            #add-point:AFTER FIELD xmdy003 name="input.a.page1.xmdy003"
            CALL s_feature_description(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) RETURNING l_success,g_xmdy_d[l_ac].xmdy003_desc 
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy003) THEN           
               IF NOT s_feature_check(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) THEN 
                  LET g_xmdy_d[l_ac].xmdy003 = g_xmdy_d_t.xmdy003
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#5---dorishsu---151228---add--
               IF NOT s_feature_direct_input(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_xmdy_d_t.xmdy003,g_xmdx_m.xmdxdocno,g_xmdx_m.xmdxsite) THEN
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#5---dorishsu---151228---end--
               
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmdy_d[l_ac].xmdy003 <> g_xmdy_d_o.xmdy003 OR cl_null(g_xmdy_d_o.xmdy003))) THEN   
                  CALL axmt440_xmdy002_xmdy003_ref(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) RETURNING g_xmdy_d[l_ac].xmdy005
                  DISPLAY BY NAME g_xmdy_d[l_ac].xmdy005
               END IF
#            ELSE
#               LET g_xmdy_d[l_ac].xmdy003 = ' '            
            END IF
            LET g_xmdy_d_o.xmdy003 = g_xmdy_d[l_ac].xmdy003
            #161221-00064#1 add-S
            IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
               LET l_pmao003 = ' '
            ELSE
               LET l_pmao003 = g_xmdy_d[l_ac].xmdy003
            END IF
            #161221-00064#1 add-E
            SELECT pmao009,pmao010
              INTO g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdx_m.xmdx004
               AND pmao002 = g_xmdy_d[l_ac].xmdy002
               #161221-00064#1 mod-S
#               AND pmao003 = g_xmdy_d[l_ac].xmdy003
               AND pmao003 = l_pmao003
               #161221-00064#1 mod-E
               AND pmao004 = g_xmdy_d[l_ac].xmdy005  
               AND pmao000 = '2'    #161221-00064#15 add               
            DISPLAY BY NAME g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy003
            #add-point:BEFORE FIELD xmdy003 name="input.b.page1.xmdy003"
            IF s_feature_auto_chk(g_xmdy_d[l_ac].xmdy002) THEN #160314-00009#13 add   
               IF axmt440_imaa005_exists() THEN 
                  IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
                     CALL s_feature_single(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_site,'') RETURNING l_success,g_xmdy_d[l_ac].xmdy003
                     DISPLAY BY NAME g_xmdy_d[l_ac].xmdy003
                  ELSE
                     CALL s_feature_description(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) RETURNING l_success,g_xmdy_d[l_ac].xmdy003_desc                  
                  END IF             
               END IF
            END IF            #160314-00009#13 add 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy003
            #add-point:ON CHANGE xmdy003 name="input.g.page1.xmdy003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy003_desc
            #add-point:BEFORE FIELD xmdy003_desc name="input.b.page1.xmdy003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy003_desc
            
            #add-point:AFTER FIELD xmdy003_desc name="input.a.page1.xmdy003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy003_desc
            #add-point:ON CHANGE xmdy003_desc name="input.g.page1.xmdy003_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy005
            
            #add-point:AFTER FIELD xmdy005 name="input.a.page1.xmdy005"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy005) THEN 
               SELECT pmaostus INTO l_pmaostus
                 FROM pmao_t
                WHERE pmaoent = g_enterprise
                  AND pmao001 = g_xmdx_m.xmdx004                 
                  AND pmao002 = g_xmdy_d[l_ac].xmdy002
                  AND pmao003 = g_xmdy_d[l_ac].xmdy003
                  AND pmao004 = g_xmdy_d[l_ac].xmdy005
                  AND pmao000 = '2'   #161221-00064#1 add       
               IF l_pmaostus = 'N' THEN
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'apm-00397'     #160318-00005#49  mark
                     LET g_errparam.code = 'sub-01302'      #160318-00005#49  add
                     LET g_errparam.extend = g_xmdy_d[l_ac].xmdy005
                     #160318-00005#49 --s add
                     LET g_errparam.replace[1] = 'apmi070'
                     LET g_errparam.replace[2] = cl_get_progname('apmi070',g_lang,"2")
                     LET g_errparam.exeprog = 'apmi070'
                     #160318-00005#49 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                     LET g_xmdy_d[l_ac].xmdy005 = g_xmdy_d_t.xmdy005
                     LET g_xmdy_d[l_ac].l_pmao009 = g_xmdy_d_t.l_pmao009
                     LET g_xmdy_d[l_ac].l_pmao010 = g_xmdy_d_t.l_pmao010
                     NEXT FIELD CURRENT
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM pmao_t
                WHERE pmaoent = g_enterprise
                  AND pmao001 = g_xmdx_m.xmdx004                 
                  AND pmao002 = g_xmdy_d[l_ac].xmdy002
                  AND pmao003 = g_xmdy_d[l_ac].xmdy003
                  AND pmao004 = g_xmdy_d[l_ac].xmdy005
                  AND pmao000 = '2'   #161221-00064#1 add       
               IF l_cnt = 0 THEN 
                  LET g_pmao_flag ='Y'
               END IF
            END IF 
            #161221-00064#1 add-S
            IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
               LET l_pmao003 = ' '
            ELSE
               LET l_pmao003 = g_xmdy_d[l_ac].xmdy003
            END IF
            #161221-00064#1 add-E
            SELECT pmao009,pmao010
              INTO g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdx_m.xmdx004
               AND pmao002 = g_xmdy_d[l_ac].xmdy002
               #161221-00064#1 mod-S
#               AND pmao003 = g_xmdy_d[l_ac].xmdy003
               AND pmao003 = l_pmao003
               #161221-00064#1 mod-E
               AND pmao004 = g_xmdy_d[l_ac].xmdy005
               AND pmao000 = '2'   #161221-00064#1 add                      
            DISPLAY BY NAME g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
            CALL axmt440_set_entry_b(l_cmd)
            CALL axmt440_set_no_entry_b(l_cmd)
            IF g_pmao_flag = 'Y' THEN
               NEXT FIELD l_pmao009
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy005
            #add-point:BEFORE FIELD xmdy005 name="input.b.page1.xmdy005"
            CALL axmt440_set_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy005
            #add-point:ON CHANGE xmdy005 name="input.g.page1.xmdy005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmao009
            #add-point:BEFORE FIELD l_pmao009 name="input.b.page1.l_pmao009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmao009
            
            #add-point:AFTER FIELD l_pmao009 name="input.a.page1.l_pmao009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmao009
            #add-point:ON CHANGE l_pmao009 name="input.g.page1.l_pmao009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmao010
            #add-point:BEFORE FIELD l_pmao010 name="input.b.page1.l_pmao010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmao010
            
            #add-point:AFTER FIELD l_pmao010 name="input.a.page1.l_pmao010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmao010
            #add-point:ON CHANGE l_pmao010 name="input.g.page1.l_pmao010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy006
            
            #add-point:AFTER FIELD xmdy006 name="input.a.page1.xmdy006"
            CALL axmt440_xmdy006_desc()
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy006) THEN 
               IF NOT s_azzi650_chk_exist('221',g_xmdy_d[l_ac].xmdy006) THEN
                  LET g_xmdy_d[l_ac].xmdy006 = g_xmdy_d_t.xmdy006
                  NEXT FIELD CURRENT
               END IF 
            ELSE
               LET g_xmdy_d[l_ac].xmdy006 = ' '             
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy006
            #add-point:BEFORE FIELD xmdy006 name="input.b.page1.xmdy006"
            CALL axmt440_xmdy006_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy006
            #add-point:ON CHANGE xmdy006 name="input.g.page1.xmdy006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy007
            #add-point:BEFORE FIELD xmdy007 name="input.b.page1.xmdy007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy007
            
            #add-point:AFTER FIELD xmdy007 name="input.a.page1.xmdy007"
            IF cl_null(g_xmdy_d[l_ac].xmdy007) THEN 
               LET g_xmdy_d[l_ac].xmdy007 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy007
            #add-point:ON CHANGE xmdy007 name="input.g.page1.xmdy007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy014
            
            #add-point:AFTER FIELD xmdy014 name="input.a.page1.xmdy014"
            CALL axmt440_xmdy014_desc()
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy014) THEN 
               IF NOT s_azzi650_chk_exist('277',g_xmdy_d[l_ac].xmdy014) THEN
                  LET g_xmdy_d[l_ac].xmdy014 = g_xmdy_d_t.xmdy014
                  NEXT FIELD CURRENT
               END IF
               CALL s_control_chk_doc('8',g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx014,'','','','') RETURNING l_success,l_flag
               IF l_success THEN 
                  IF NOT l_flag THEN 
                     LET g_xmdy_d[l_ac].xmdy014 = g_xmdy_d_t.xmdy014
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_xmdy_d[l_ac].xmdy014 = g_xmdy_d_t.xmdy014
                  NEXT FIELD CURRENT                  
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy014
            #add-point:BEFORE FIELD xmdy014 name="input.b.page1.xmdy014"
            CALL axmt440_xmdy014_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy014
            #add-point:ON CHANGE xmdy014 name="input.g.page1.xmdy014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy008
            
            #add-point:AFTER FIELD xmdy008 name="input.a.page1.xmdy008"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdy_d[l_ac].xmdy002
               LET g_chkparam.arg2 = g_xmdy_d[l_ac].xmdy008

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imao002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmdy_d[l_ac].xmdy008 <> g_xmdy_d_o.xmdy008 OR cl_null(g_xmdy_d_o.xmdy008))) THEN  
                     CALL axmt440_xmdy009_round()
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdy_d[l_ac].xmdy008 = g_xmdy_d_t.xmdy008
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            LET g_xmdy_d_o.xmdy008 = g_xmdy_d[l_ac].xmdy008 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy008
            #add-point:BEFORE FIELD xmdy008 name="input.b.page1.xmdy008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy008
            #add-point:ON CHANGE xmdy008 name="input.g.page1.xmdy008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdy_d[l_ac].xmdy009,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmdy009
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdy009 name="input.a.page1.xmdy009"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy009) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmdy_d[l_ac].xmdy009 <> g_xmdy_d_o.xmdy009 OR cl_null(g_xmdy_d_o.xmdy009))) THEN  
                  CALL axmt440_xmdy009_round()
                  CALL axmt440_get_amount(g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy011)  
                     RETURNING g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019
                  DISPLAY BY NAME g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019                   
               END IF            
            END IF 
            LET g_xmdy_d_o.xmdy009 = g_xmdy_d[l_ac].xmdy009 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy009
            #add-point:BEFORE FIELD xmdy009 name="input.b.page1.xmdy009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy009
            #add-point:ON CHANGE xmdy009 name="input.g.page1.xmdy009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdy_d[l_ac].xmdy010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdy010
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdy010 name="input.a.page1.xmdy010"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy010) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmdy_d[l_ac].xmdy010 <> g_xmdy_d_o.xmdy010 OR cl_null(g_xmdy_d_o.xmdy010))) THEN  
                  CALL s_curr_round(g_ooef.ooef001,g_xmdx_m.xmdx005,g_xmdy_d[l_ac].xmdy010,'1') RETURNING g_xmdy_d[l_ac].xmdy010
                  CALL axmt440_get_amount(g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy011)  
                     RETURNING g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019
                  DISPLAY BY NAME g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019                      
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy010
            #add-point:BEFORE FIELD xmdy010 name="input.b.page1.xmdy010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy010
            #add-point:ON CHANGE xmdy010 name="input.g.page1.xmdy010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy024
            #add-point:BEFORE FIELD xmdy024 name="input.b.page1.xmdy024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy024
            
            #add-point:AFTER FIELD xmdy024 name="input.a.page1.xmdy024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy024
            #add-point:ON CHANGE xmdy024 name="input.g.page1.xmdy024"
            IF g_xmdy_d[l_ac].xmdy024 = 'Y' THEN 
               CALL axmt440_01('1',g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_xmdy_d[l_ac].xmdy004,g_xmdy_d[l_ac].xmdy006,g_xmdy_d[l_ac].xmdy007,g_xmdy_d[l_ac].xmdy008,g_xmdy_d[l_ac].xmdy009)          
               CALL s_transaction_begin()           
           END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy011
            
            #add-point:AFTER FIELD xmdy011 name="input.a.page1.xmdy011"
            CALL axmt440_xmdy011_desc()
            CALL axmt440_xmdy011_ref()
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_xmdy_d[l_ac].xmdy011

               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
               #160318-00025#17  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmdy_d[l_ac].xmdy011 <> g_xmdy_d_o.xmdy011 OR cl_null(g_xmdy_d_o.xmdy011))) THEN  
                     CALL axmt440_get_amount(g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy011)  
                        RETURNING g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019
                     DISPLAY BY NAME g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019                      
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdy_d[l_ac].xmdy011 = g_xmdy_d_t.xmdy011
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_xmdy_d_o.xmdy011 = g_xmdy_d[l_ac].xmdy011
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy011
            #add-point:BEFORE FIELD xmdy011 name="input.b.page1.xmdy011"
            CALL axmt440_xmdy011_desc()
            CALL axmt440_xmdy011_ref() 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy011
            #add-point:ON CHANGE xmdy011 name="input.g.page1.xmdy011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy011_desc
            #add-point:BEFORE FIELD xmdy011_desc name="input.b.page1.xmdy011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy011_desc
            
            #add-point:AFTER FIELD xmdy011_desc name="input.a.page1.xmdy011_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy011_desc
            #add-point:ON CHANGE xmdy011_desc name="input.g.page1.xmdy011_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdy_d[l_ac].xmdy012,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD xmdy012
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdy012 name="input.a.page1.xmdy012"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy012) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy012
            #add-point:BEFORE FIELD xmdy012 name="input.b.page1.xmdy012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy012
            #add-point:ON CHANGE xmdy012 name="input.g.page1.xmdy012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy017
            #add-point:BEFORE FIELD xmdy017 name="input.b.page1.xmdy017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy017
            
            #add-point:AFTER FIELD xmdy017 name="input.a.page1.xmdy017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy017
            #add-point:ON CHANGE xmdy017 name="input.g.page1.xmdy017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy018
            #add-point:BEFORE FIELD xmdy018 name="input.b.page1.xmdy018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy018
            
            #add-point:AFTER FIELD xmdy018 name="input.a.page1.xmdy018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy018
            #add-point:ON CHANGE xmdy018 name="input.g.page1.xmdy018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy019
            #add-point:BEFORE FIELD xmdy019 name="input.b.page1.xmdy019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy019
            
            #add-point:AFTER FIELD xmdy019 name="input.a.page1.xmdy019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy019
            #add-point:ON CHANGE xmdy019 name="input.g.page1.xmdy019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy013
            
            #add-point:AFTER FIELD xmdy013 name="input.a.page1.xmdy013"
            CALL axmt440_xmdy013_desc()
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy013) THEN 
               IF NOT s_azzi650_chk_exist('263',g_xmdy_d[l_ac].xmdy013) THEN
                  LET g_xmdy_d[l_ac].xmdy013 = g_xmdy_d_t.xmdy013
                  NEXT FIELD CURRENT
               END IF             
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy013
            #add-point:BEFORE FIELD xmdy013 name="input.b.page1.xmdy013"
            CALL axmt440_xmdy013_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy013
            #add-point:ON CHANGE xmdy013 name="input.g.page1.xmdy013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy004
            
            #add-point:AFTER FIELD xmdy004 name="input.a.page1.xmdy004"
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmdy_d[l_ac].xmdy004

               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmdy_d[l_ac].xmdy004 = g_xmdy_d_t.xmdy004
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_xmdy_d[l_ac].xmdy004 = ' '
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy004
            #add-point:BEFORE FIELD xmdy004 name="input.b.page1.xmdy004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy004
            #add-point:ON CHANGE xmdy004 name="input.g.page1.xmdy004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdy030
            #add-point:BEFORE FIELD xmdy030 name="input.b.page1.xmdy030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdy030
            
            #add-point:AFTER FIELD xmdy030 name="input.a.page1.xmdy030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdy030
            #add-point:ON CHANGE xmdy030 name="input.g.page1.xmdy030"
            
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
 
 
 
                  #Ctrlp:input.c.page1.xmdysite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdysite
            #add-point:ON ACTION controlp INFIELD xmdysite name="input.c.page1.xmdysite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdyseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdyseq
            #add-point:ON ACTION controlp INFIELD xmdyseq name="input.c.page1.xmdyseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy002
            #add-point:ON ACTION controlp INFIELD xmdy002 name="input.c.page1.xmdy002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy002             #給予default值
            LET l_where = ''
            CALL s_control_get_item_sql('2',g_site,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxdocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = l_where
            END IF
            #給予arg

            CALL q_imaf001()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy002 TO xmdy002              #顯示到畫面上

            NEXT FIELD xmdy002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy003
            #add-point:ON ACTION controlp INFIELD xmdy003 name="input.c.page1.xmdy003"
#此段落由子樣板a07產生            
            #開窗i段
            CALL s_feature_single(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_site,'') RETURNING l_success,g_xmdy_d[l_ac].xmdy003     #呼叫開窗
            DISPLAY g_xmdy_d[l_ac].xmdy003 TO xmdy003   #顯示到畫面上
            NEXT FIELD xmdy003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy003_desc
            #add-point:ON ACTION controlp INFIELD xmdy003_desc name="input.c.page1.xmdy003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy005
            #add-point:ON ACTION controlp INFIELD xmdy005 name="input.c.page1.xmdy005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy005             #給予default值
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy002) THEN 
               LET g_qryparam.where = " pmao002 = '",g_xmdy_d[l_ac].xmdy002,"'"
            END IF
            IF NOT cl_null(g_xmdy_d[l_ac].xmdy003) THEN 
               LET g_qryparam.where = g_qryparam.where," AND pmao003 = '",g_xmdy_d[l_ac].xmdy003,"'"
            END IF 
            #給予arg
            LET g_qryparam.arg1 = g_xmdx_m.xmdx004

            CALL q_pmao004_2()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy005 TO xmdy005              #顯示到畫面上
            #161221-00064#1 add-S
            IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
               LET l_pmao003 = ' '
            ELSE
               LET l_pmao003 = g_xmdy_d[l_ac].xmdy003
            END IF
            #161221-00064#1 add-E
            SELECT pmao009,pmao010
              INTO g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = g_xmdx_m.xmdx004
               AND pmao002 = g_xmdy_d[l_ac].xmdy002
               #161221-00064#1 mod-S
#               AND pmao003 = g_xmdy_d[l_ac].xmdy003
               AND pmao003 = l_pmao003
               #161221-00064#1 mod-E
               AND pmao004 = g_xmdy_d[l_ac].xmdy005 
               AND pmao000 = '2'   #161221-00064#1 add                      
            DISPLAY BY NAME g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
            NEXT FIELD xmdy005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmao009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmao009
            #add-point:ON ACTION controlp INFIELD l_pmao009 name="input.c.page1.l_pmao009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmao010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmao010
            #add-point:ON ACTION controlp INFIELD l_pmao010 name="input.c.page1.l_pmao010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy006
            #add-point:ON ACTION controlp INFIELD xmdy006 name="input.c.page1.xmdy006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '221'

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy006 TO xmdy006              #顯示到畫面上

            NEXT FIELD xmdy006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy007
            #add-point:ON ACTION controlp INFIELD xmdy007 name="input.c.page1.xmdy007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy014
            #add-point:ON ACTION controlp INFIELD xmdy014 name="input.c.page1.xmdy014"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '277'

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy014 TO xmdy014              #顯示到畫面上

            NEXT FIELD xmdy014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy008
            #add-point:ON ACTION controlp INFIELD xmdy008 name="input.c.page1.xmdy008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmdy_d[l_ac].xmdy002
            CALL q_imao002()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy008 TO xmdy008              #顯示到畫面上

            NEXT FIELD xmdy008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy009
            #add-point:ON ACTION controlp INFIELD xmdy009 name="input.c.page1.xmdy009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy010
            #add-point:ON ACTION controlp INFIELD xmdy010 name="input.c.page1.xmdy010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy024
            #add-point:ON ACTION controlp INFIELD xmdy024 name="input.c.page1.xmdy024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy011
            #add-point:ON ACTION controlp INFIELD xmdy011 name="input.c.page1.xmdy011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy011             #給予default值
            LET g_qryparam.default2 = "" #g_xmdy_d[l_ac].oodb002 #稅別代碼
            LET g_qryparam.where = " oodb001 = '",g_ooef.ooef019,"'"
            #給予arg

            CALL q_oodb002_4()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_xmdy_d[l_ac].oodb002 = g_qryparam.return2 #稅別代碼

            DISPLAY g_xmdy_d[l_ac].xmdy011 TO xmdy011              #顯示到畫面上
            #DISPLAY g_xmdy_d[l_ac].oodb002 TO oodb002 #稅別代碼

            NEXT FIELD xmdy011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy011_desc
            #add-point:ON ACTION controlp INFIELD xmdy011_desc name="input.c.page1.xmdy011_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy012
            #add-point:ON ACTION controlp INFIELD xmdy012 name="input.c.page1.xmdy012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy017
            #add-point:ON ACTION controlp INFIELD xmdy017 name="input.c.page1.xmdy017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy018
            #add-point:ON ACTION controlp INFIELD xmdy018 name="input.c.page1.xmdy018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy019
            #add-point:ON ACTION controlp INFIELD xmdy019 name="input.c.page1.xmdy019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy013
            #add-point:ON ACTION controlp INFIELD xmdy013 name="input.c.page1.xmdy013"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '263'

            CALL q_oocq002()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdy_d[l_ac].xmdy013 TO xmdy013              #顯示到畫面上

            NEXT FIELD xmdy013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy004
            #add-point:ON ACTION controlp INFIELD xmdy004 name="input.c.page1.xmdy004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmdy_d[l_ac].xmdy004             #給予default值
            

            #給予arg

            CALL q_imaf001_12()                                #呼叫開窗

            LET g_xmdy_d[l_ac].xmdy004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_xmdy_d[l_ac].imaal003 = g_qryparam.return2 #品名

            DISPLAY g_xmdy_d[l_ac].xmdy004 TO xmdy004              #顯示到畫面上
            #DISPLAY g_xmdy_d[l_ac].imaal003 TO imaal003 #品名

            NEXT FIELD xmdy004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdy030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdy030
            #add-point:ON ACTION controlp INFIELD xmdy030 name="input.c.page1.xmdy030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1.ooff013"
            #161031-00025#21-s
            IF NOT cl_null(g_xmdx_m.xmdxdocno) AND l_ac > 0 THEN
               CALL aooi360_02('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1')
               CALL s_aooi360_sel('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1') RETURNING l_success,g_xmdy_d[l_ac].ooff013
               LET g_ooff001_d = '6'   #6.單據單頭備註
               LET g_ooff002_d = g_prog
               LET g_ooff003_d = g_xmdx_m.xmdxdocno   #单号
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
            #161031-00025#21-e
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmdy_d[l_ac].* = g_xmdy_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt440_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmdy_d[l_ac].xmdyseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmdy_d[l_ac].* = g_xmdy_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axmt440_xmdy_t_mask_restore('restore_mask_o')
      
               UPDATE xmdy_t SET (xmdydocno,xmdysite,xmdyseq,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007, 
                   xmdy014,xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013, 
                   xmdy004,xmdy030,xmdy001,xmdy020,xmdy021,xmdy022,xmdy023) = (g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdysite, 
                   g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_xmdy_d[l_ac].xmdy005, 
                   g_xmdy_d[l_ac].xmdy006,g_xmdy_d[l_ac].xmdy007,g_xmdy_d[l_ac].xmdy014,g_xmdy_d[l_ac].xmdy008, 
                   g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy024,g_xmdy_d[l_ac].xmdy011, 
                   g_xmdy_d[l_ac].xmdy012,g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019, 
                   g_xmdy_d[l_ac].xmdy013,g_xmdy_d[l_ac].xmdy004,g_xmdy_d[l_ac].xmdy030,g_xmdy_d[l_ac].xmdy001, 
                   g_xmdy2_d[l_ac].xmdy020,g_xmdy2_d[l_ac].xmdy021,g_xmdy2_d[l_ac].xmdy022,g_xmdy2_d[l_ac].xmdy023) 
 
                WHERE xmdyent = g_enterprise AND xmdydocno = g_xmdx_m.xmdxdocno 
 
                  AND xmdyseq = g_xmdy_d_t.xmdyseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmdy_d[l_ac].* = g_xmdy_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdy_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmdy_d[l_ac].* = g_xmdy_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdx_m.xmdxdocno
               LET gs_keys_bak[1] = g_xmdxdocno_t
               LET gs_keys[2] = g_xmdy_d[g_detail_idx].xmdyseq
               LET gs_keys_bak[2] = g_xmdy_d_t.xmdyseq
               CALL axmt440_update_b('xmdy_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axmt440_xmdy_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xmdy_d[g_detail_idx].xmdyseq = g_xmdy_d_t.xmdyseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xmdx_m.xmdxdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmdy_d_t.xmdyseq
 
                  CALL axmt440_key_update_b(gs_keys,'xmdy_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmdx_m),util.JSON.stringify(g_xmdy_d_t)
               LET g_log2 = util.JSON.stringify(g_xmdx_m),util.JSON.stringify(g_xmdy_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_xmdy_d[l_ac].xmdyseq != g_xmdy_d_t.xmdyseq THEN
                  UPDATE xmdz_t SET xmdzseq = g_xmdy_d[l_ac].xmdyseq
                    WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdx_m.xmdxdocno
                      AND xmdzseq = g_xmdy_d_t.xmdyseq
                  IF SQLCA.SQLcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdz_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               IF g_xmdy_d[l_ac].xmdy024 = 'N' THEN
                  DELETE FROM xmdz_t
                     WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdx_m.xmdxdocno
                       AND xmdzseq = g_xmdy_d[l_ac].xmdyseq
                  IF SQLCA.SQLcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmdz_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               CALL axmt440_ins_pmao()
               #161031-00025#21-s
               CALL s_aooi360_del('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d_t.xmdyseq,'','','','','','','','1') RETURNING l_success
               IF NOT cl_null(g_xmdy_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1',g_xmdy_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#21-e
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
 
            #end add-point
            CALL axmt440_unlock_b("xmdy_t","'1'")
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
               LET g_xmdy_d[li_reproduce_target].* = g_xmdy_d[li_reproduce].*
               LET g_xmdy2_d[li_reproduce_target].* = g_xmdy2_d[li_reproduce].*
 
               LET g_xmdy_d[li_reproduce_target].xmdyseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmdy_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmdy_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_xmdy2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL axmt440_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            CALL axmt440_b_fill2('2')
CALL axmt440_b_fill2('3')
 
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL axmt440_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
 
         #end add-point
      
      END DISPLAY
 
      DISPLAY ARRAY g_xmdy3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL axmt440_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx2 = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL axmt440_idx_chk()
            LET g_current_page = 3
      
         #自訂ACTION(detail_show,page_3)
         
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_xmdy4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL axmt440_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx2 = l_ac
            
            #add-point:page4, before row動作 name="input.body4.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            CALL axmt440_idx_chk()
            LET g_current_page = 4
      
         #自訂ACTION(detail_show,page_4)
         
      
         #add-point:page4自定義行為 name="input.body4.action"
         
         #end add-point
      
      END DISPLAY
 
 
{</section>}
 
{<section id="axmt440.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身  #161031-00025#21
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #161031-00025#21-s
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff012     
            END CASE
         END IF
         #161031-00025#21-e 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xmdxdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmdysite
               WHEN "s_detail2"
                  NEXT FIELD xmdyseq2
               WHEN "s_detail3"
                  NEXT FIELD xmdzseq
               WHEN "s_detail4"
                  NEXT FIELD xmdw003
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF INT_FLAG AND l_ac > 0 THEN
      DELETE FROM xmdz_t
            WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdx_m.xmdxdocno
              AND xmdzseq = g_xmdy_d[l_ac].xmdyseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdz_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmt440_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axmt440_b_fill() #單身填充
      CALL axmt440_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmt440_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            IF NOT cl_null(g_xmdx_m.xmdxdocno) THEN
               CALL axmt440_xmdxdocno_desc('2',g_xmdx_m.xmdxdocno) RETURNING g_xmdx_m.xmdxdocno_desc
               DISPLAY BY NAME g_xmdx_m.xmdxdocno_desc
            END IF
#            CALL axmt440_xmdx002_desc()
#            
#            CALL axmt440_xmdx003_desc()
#
#            CALL axmt440_xmdx004_desc()
#
#            CALL axmt440_xmdx005_desc()

            CALL axmt440_xmdx006_desc()

#            CALL axmt440_xmdx009_desc()
#            
#            CALL axmt440_xmdx011_desc()

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdx_m.xmdxcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmdx_m.xmdxcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdx_m.xmdxcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_xmdx_m_mask_o.* =  g_xmdx_m.*
   CALL axmt440_xmdx_t_mask()
   LET g_xmdx_m_mask_n.* =  g_xmdx_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
       g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
       g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
       g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
       g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite, 
       g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid, 
       g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdx_m.xmdxstus 
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmdy_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#      CALL axmt440_xmdy002_desc()
       CALL s_feature_description(g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003) RETURNING l_success,g_xmdy_d[l_ac].xmdy003_desc 
#      CALL axmt440_xmdy006_desc()
       CALL axmt440_xmdy011_desc()
#      CALL axmt440_xmdy013_desc()
#      CALL axmt440_xmdy014_desc()      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmdy2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      LET g_xmdy2_d[l_ac].xmdy002_2_desc = g_xmdy_d[l_ac].xmdy002_desc
      LET g_xmdy2_d[l_ac].xmdy002_2_desc1 = g_xmdy_d[l_ac].xmdy002_desc_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmdy3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmdy4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axmt440_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF l_ac > 0 THEN 
      CALL cl_set_act_visible("axmt440_01",FALSE)
      IF g_xmdy_d[l_ac].xmdy024 = 'Y' THEN 
         CALL cl_set_act_visible("axmt440_01",TRUE)
      END IF   
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axmt440_detail_show()
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
 
{<section id="axmt440.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmt440_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xmdx_t.xmdxdocno 
   DEFINE l_oldno     LIKE xmdx_t.xmdxdocno 
 
   DEFINE l_master    RECORD LIKE xmdx_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmdy_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE xmdz_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xmdw_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_xmdx_m.xmdxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
    
   LET g_xmdx_m.xmdxdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdx_m.xmdxownid = g_user
      LET g_xmdx_m.xmdxowndp = g_dept
      LET g_xmdx_m.xmdxcrtid = g_user
      LET g_xmdx_m.xmdxcrtdp = g_dept 
      LET g_xmdx_m.xmdxcrtdt = cl_get_current()
      LET g_xmdx_m.xmdxmodid = g_user
      LET g_xmdx_m.xmdxmoddt = cl_get_current()
      LET g_xmdx_m.xmdxstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xmdx_m.xmdxdocdt = g_today
   LET g_xmdx_m.xmdx002 = g_user
   LET g_xmdx_m.xmdx003 = g_dept
   CALL axmt440_xmdx002_desc()  
   CALL axmt440_xmdx003_desc()   
   LET g_xmdx_m.xmdxcnfid = ""
   LET g_xmdx_m.xmdxcnfdt = ""
   LET g_xmdx_m.xmdxstus = "N"
   DISPLAY BY NAME g_xmdx_m.*
   LET g_xmdx_m_t.* = g_xmdx_m.*
   LET g_xmdx004_o = g_xmdx_m.xmdx004
   LET g_xmdx005_o = g_xmdx_m.xmdx005
   LET g_xmdx006_o = g_xmdx_m.xmdx006
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdx_m.xmdxstus 
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xmdx_m.xmdxdocno_desc = ''
   DISPLAY BY NAME g_xmdx_m.xmdxdocno_desc
 
   
   CALL axmt440_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xmdx_m.* TO NULL
      INITIALIZE g_xmdy_d TO NULL
      INITIALIZE g_xmdy2_d TO NULL
      INITIALIZE g_xmdy3_d TO NULL
      INITIALIZE g_xmdy4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axmt440_show()
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
   CALL axmt440_set_act_visible()   
   CALL axmt440_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdxent = " ||g_enterprise|| " AND",
                      " xmdxdocno = '", g_xmdx_m.xmdxdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt440_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axmt440_idx_chk()
   
   LET g_data_owner = g_xmdx_m.xmdxownid      
   LET g_data_dept  = g_xmdx_m.xmdxowndp
   
   #功能已完成,通報訊息中心
   CALL axmt440_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmt440_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmdy_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE xmdz_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xmdw_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE  l_oodbl004   LIKE oodbl_t.oodbl004    #課稅原則
   DEFINE  l_oodb005    LIKE oodb_t.oodb005      #含稅否
   DEFINE  l_oodb006    LIKE oodb_t.oodb006      #稅率 
   DEFINE  l_success    LIKE type_t.num5   
   
   CALL axmt440_pmab089()
   CALL s_tax_chk(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx006)
       RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,g_tax_app
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmt440_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdy_t
    WHERE xmdyent = g_enterprise AND xmdydocno = g_xmdxdocno_t
 
    INTO TEMP axmt440_detail
 
   #將key修正為調整後   
   UPDATE axmt440_detail 
      #更新key欄位
      SET xmdydocno = g_xmdx_m.xmdxdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xmdy_t SELECT * FROM axmt440_detail
   
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
   DROP TABLE axmt440_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdz_t 
    WHERE xmdzent = g_enterprise AND xmdzdocno = g_xmdxdocno_t
 
    INTO TEMP axmt440_detail
 
   #將key修正為調整後   
   UPDATE axmt440_detail SET xmdzdocno = g_xmdx_m.xmdxdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO xmdz_t SELECT * FROM axmt440_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt440_detail
   
   LET g_data_owner = g_xmdx_m.xmdxownid      
   LET g_data_dept  = g_xmdx_m.xmdxowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   IF g_xmdx_m.xmdx004 != g_xmdx004_o OR cl_null(g_xmdx006_o) THEN
      CALL axmt440_xmdy005_upd() 
   END IF   
   IF g_xmdx_m.xmdx005 != g_xmdx005_o OR cl_null(g_xmdx006_o) THEN
      CALL axmt440_xmdy_upd()
   END IF
   IF g_xmdx_m.xmdx006 <> g_xmdx006_o OR cl_null(g_xmdx006_o) THEN 
      CALL axmt440_change_xmdx011('u')  
   END IF  
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdw_t 
    WHERE xmdwent = g_enterprise AND xmdw001 = g_xmdxdocno_t
 
    INTO TEMP axmt440_detail
 
   #將key修正為調整後   
   UPDATE axmt440_detail SET xmdw001 = g_xmdx_m.xmdxdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO xmdw_t SELECT * FROM axmt440_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt440_detail
   
   LET g_data_owner = g_xmdx_m.xmdxownid      
   LET g_data_dept  = g_xmdx_m.xmdxowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmt440_delete()
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
   
   IF g_xmdx_m.xmdxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt440_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT axmt440_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdx_m_mask_o.* =  g_xmdx_m.*
   CALL axmt440_xmdx_t_mask()
   LET g_xmdx_m_mask_n.* =  g_xmdx_m.*
   
   CALL axmt440_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmt440_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno
 
 
      DELETE FROM xmdx_t
       WHERE xmdxent = g_enterprise AND xmdxdocno = g_xmdx_m.xmdxdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdx_m.xmdxdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_xmdx_m.xmdxdocno,g_xmdx_m.xmdxdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#21-s MARK      
#      IF NOT s_aooi360_del('6','axmt440',g_xmdx_m.xmdxdocno,'','','','','','','','','4') THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
      #161031-00025#21-e MARK
      #161031-00025#21-s
      #单头的aooi360_01的备注单身资料同步删除
      DELETE FROM ooff_t
       WHERE ooffent = g_enterprise AND ooff001 IN ('6','7')
         AND ooff002 = g_prog AND ooff003 = g_xmdx_m.xmdxdocno
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdx_m.xmdxdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      CALL aooi360_01_clear_detail()   #清除备注单身  
      #161031-00025#21-e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xmdy_t
       WHERE xmdyent = g_enterprise AND xmdydocno = g_xmdx_m.xmdxdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
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
      DELETE FROM xmdz_t
       WHERE xmdzent = g_enterprise AND
             xmdzdocno = g_xmdx_m.xmdxdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM xmdw_t
       WHERE xmdwent = g_enterprise AND
             xmdw001 = g_xmdx_m.xmdxdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmdx_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axmt440_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xmdy_d.clear() 
      CALL g_xmdy2_d.clear()       
      CALL g_xmdy3_d.clear()       
      CALL g_xmdy4_d.clear()       
 
     
      CALL axmt440_ui_browser_refresh()  
      #CALL axmt440_ui_headershow()  
      #CALL axmt440_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axmt440_browser_fill("")
         CALL axmt440_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmt440_cl
 
   #功能已完成,通報訊息中心
   CALL axmt440_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmt440.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmt440_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_pmao003        LIKE pmao_t.pmao003  #161221-00064#1 add
   DEFINE l_success              LIKE type_t.num5 #161031-00025#21 add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xmdy_d.clear()
   CALL g_xmdy2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axmt440_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmdysite,xmdyseq,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007,xmdy014, 
             xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,xmdy004, 
             xmdy030,xmdy001,xmdy020,xmdy021,xmdy022,xmdy023 ,t1.imaal003 ,t2.imaal004 ,t3.oocql004 , 
             t4.oocql004 ,t5.oocql004 FROM xmdy_t",   
                     " INNER JOIN xmdx_t ON xmdxent = " ||g_enterprise|| " AND xmdxdocno = xmdydocno ",
 
                     #"",
                     " LEFT JOIN xmdz_t ON xmdyent = xmdzent AND xmdydocno = xmdzdocno AND xmdyseq = xmdzseq ",
               " LEFT JOIN xmdw_t ON xmdyent = xmdwent AND xmdydocno = xmdw001 AND xmdyseq = xmdw002 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
                     " ",
 
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdy002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdy002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='221' AND t3.oocql002=xmdy006 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='277' AND t4.oocql002=xmdy014 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='263' AND t5.oocql002=xmdy013 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE xmdyent=? AND xmdydocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #161031-00025#21-s
         LET g_sql = "SELECT  DISTINCT xmdysite,xmdyseq,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007,xmdy014, 
             xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,xmdy004, 
             xmdy030,xmdy001,xmdy020,xmdy021,xmdy022,xmdy023 ,t1.imaal003 ,t2.imaal004 ,t3.oocql004 , 
             t4.oocql004 ,t5.oocql004 FROM xmdy_t",   
                     " INNER JOIN xmdx_t ON xmdxent = " ||g_enterprise|| " AND xmdxdocno = xmdydocno ",
 
                     #"",
                     " LEFT JOIN xmdz_t ON xmdyent = xmdzent AND xmdydocno = xmdzdocno AND xmdyseq = xmdzseq ",
               " LEFT JOIN xmdw_t ON xmdyent = xmdwent AND xmdydocno = xmdw001 AND xmdyseq = xmdw002 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
                     " ",
 
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdy002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdy002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='221' AND t3.oocql002=xmdy006 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='277' AND t4.oocql002=xmdy014 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='263' AND t5.oocql002=xmdy013 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooff_t  ON ooffent="||g_enterprise||" AND ooff002 = '",g_prog,"' AND ooff003 = xmdydocno AND ooff004 = xmdyseq",
                     " WHERE xmdyent=? AND xmdydocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #161031-00025#21-e 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
   IF NOT cl_null(g_wc2_table3) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table3 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY xmdy_t.xmdyseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
       
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt440_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmt440_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmdx_m.xmdxdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmdx_m.xmdxdocno INTO g_xmdy_d[l_ac].xmdysite,g_xmdy_d[l_ac].xmdyseq, 
          g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003,g_xmdy_d[l_ac].xmdy005,g_xmdy_d[l_ac].xmdy006, 
          g_xmdy_d[l_ac].xmdy007,g_xmdy_d[l_ac].xmdy014,g_xmdy_d[l_ac].xmdy008,g_xmdy_d[l_ac].xmdy009, 
          g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy024,g_xmdy_d[l_ac].xmdy011,g_xmdy_d[l_ac].xmdy012, 
          g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019,g_xmdy_d[l_ac].xmdy013, 
          g_xmdy_d[l_ac].xmdy004,g_xmdy_d[l_ac].xmdy030,g_xmdy_d[l_ac].xmdy001,g_xmdy2_d[l_ac].xmdy020, 
          g_xmdy2_d[l_ac].xmdy021,g_xmdy2_d[l_ac].xmdy022,g_xmdy2_d[l_ac].xmdy023,g_xmdy_d[l_ac].xmdy002_desc, 
          g_xmdy_d[l_ac].xmdy002_desc_desc,g_xmdy_d[l_ac].xmdy006_desc,g_xmdy_d[l_ac].xmdy014_desc,g_xmdy_d[l_ac].xmdy013_desc  
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
         LET g_xmdy2_d[l_ac].xmdyseq2 = g_xmdy_d[l_ac].xmdyseq
         LET g_xmdy2_d[l_ac].xmdy0022 = g_xmdy_d[l_ac].xmdy002
         LET g_xmdy2_d[l_ac].xmdy0032 = g_xmdy_d[l_ac].xmdy003
         LET g_xmdy2_d[l_ac].xmdy0062 = g_xmdy_d[l_ac].xmdy006
         LET g_xmdy2_d[l_ac].xmdy0072 = g_xmdy_d[l_ac].xmdy007
         LET g_xmdy2_d[l_ac].xmdy0082 = g_xmdy_d[l_ac].xmdy008
         LET g_xmdy2_d[l_ac].xmdy0092 = g_xmdy_d[l_ac].xmdy009
         LET g_xmdy2_d[l_ac].xmdy0102 = g_xmdy_d[l_ac].xmdy010
         LET g_xmdy2_d[l_ac].xmdy0202 = g_xmdy_d[l_ac].xmdy009 - g_xmdy2_d[l_ac].xmdy020
         LET g_xmdy2_d[l_ac].xmdy0212 = g_xmdy_d[l_ac].xmdy017 - g_xmdy2_d[l_ac].xmdy021
         LET g_xmdy2_d[l_ac].xmdy0222 = g_xmdy_d[l_ac].xmdy018 - g_xmdy2_d[l_ac].xmdy022
         LET g_xmdy2_d[l_ac].xmdy0232 = g_xmdy_d[l_ac].xmdy019 - g_xmdy2_d[l_ac].xmdy023   
         
         #161221-00064#1 add-S
         IF cl_null(g_xmdy_d[l_ac].xmdy003) THEN
            LET l_pmao003 = ' '
         ELSE
            LET l_pmao003 = g_xmdy_d[l_ac].xmdy003
         END IF
         #161221-00064#1 add-E
         SELECT pmao009,pmao010
           INTO g_xmdy_d[l_ac].l_pmao009,g_xmdy_d[l_ac].l_pmao010
           FROM pmao_t
          WHERE pmaoent = g_enterprise
            AND pmao001 = g_xmdx_m.xmdx004
            AND pmao002 = g_xmdy_d[l_ac].xmdy002
            #161221-00064#1 mod-S
#            AND pmao003 = g_xmdy_d[l_ac].xmdy003
            AND pmao003 = l_pmao003
            #161221-00064#1 mod-E
            AND pmao004 = g_xmdy_d[l_ac].xmdy005 
            AND pmao000 = '2'   #161221-00064#1 add  
         #161031-00025#21-s
         CALL s_aooi360_sel('7',g_prog,g_xmdx_m.xmdxdocno,g_xmdy_d[l_ac].xmdyseq,'','','','','','','','1') RETURNING l_success,g_xmdy_d[l_ac].ooff013
         #161031-00025#21-e            
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
   #161031-00025#21-s
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog
   LET g_ooff003_d = g_xmdx_m.xmdxdocno   #单号
   LET g_ooff004_d = '0'     #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
   #161031-00025#21-e 
   #end add-point
   
   CALL g_xmdy_d.deleteElement(g_xmdy_d.getLength())
   CALL g_xmdy2_d.deleteElement(g_xmdy2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axmt440_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmdy_d.getLength()
      LET g_xmdy_d_mask_o[l_ac].* =  g_xmdy_d[l_ac].*
      CALL axmt440_xmdy_t_mask()
      LET g_xmdy_d_mask_n[l_ac].* =  g_xmdy_d[l_ac].*
   END FOR
   
   LET g_xmdy2_d_mask_o.* =  g_xmdy2_d.*
   FOR l_ac = 1 TO g_xmdy2_d.getLength()
      LET g_xmdy2_d_mask_o[l_ac].* =  g_xmdy2_d[l_ac].*
      CALL axmt440_xmdy_t_mask()
      LET g_xmdy2_d_mask_n[l_ac].* =  g_xmdy2_d[l_ac].*
   END FOR
   LET g_xmdy3_d_mask_o.* =  g_xmdy3_d.*
   FOR l_ac = 1 TO g_xmdy3_d.getLength()
      LET g_xmdy3_d_mask_o[l_ac].* =  g_xmdy3_d[l_ac].*
      CALL axmt440_xmdz_t_mask()
      LET g_xmdy3_d_mask_n[l_ac].* =  g_xmdy3_d[l_ac].*
   END FOR
   LET g_xmdy4_d_mask_o.* =  g_xmdy4_d.*
   FOR l_ac = 1 TO g_xmdy4_d.getLength()
      LET g_xmdy4_d_mask_o[l_ac].* =  g_xmdy4_d[l_ac].*
      CALL axmt440_xmdw_t_mask()
      LET g_xmdy4_d_mask_n[l_ac].* =  g_xmdy4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmt440_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xmdy_t
       WHERE xmdyent = g_enterprise AND
         xmdydocno = ps_keys_bak[1] AND xmdyseq = ps_keys_bak[2]
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
         CALL g_xmdy_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xmdy2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xmdz_t
       WHERE xmdzent = g_enterprise AND
             xmdzdocno = ps_keys_bak[1] AND xmdzseq = ps_keys_bak[2] AND xmdzseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_xmdy3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM xmdw_t
       WHERE xmdwent = g_enterprise AND
             xmdw001 = ps_keys_bak[1] AND xmdw002 = ps_keys_bak[2] AND xmdw003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'4'" THEN 
         CALL g_xmdy4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmt440_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO xmdy_t
                  (xmdyent,
                   xmdydocno,
                   xmdyseq
                   ,xmdysite,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007,xmdy014,xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,xmdy004,xmdy030,xmdy001,xmdy020,xmdy021,xmdy022,xmdy023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmdy_d[g_detail_idx].xmdysite,g_xmdy_d[g_detail_idx].xmdy002,g_xmdy_d[g_detail_idx].xmdy003, 
                       g_xmdy_d[g_detail_idx].xmdy005,g_xmdy_d[g_detail_idx].xmdy006,g_xmdy_d[g_detail_idx].xmdy007, 
                       g_xmdy_d[g_detail_idx].xmdy014,g_xmdy_d[g_detail_idx].xmdy008,g_xmdy_d[g_detail_idx].xmdy009, 
                       g_xmdy_d[g_detail_idx].xmdy010,g_xmdy_d[g_detail_idx].xmdy024,g_xmdy_d[g_detail_idx].xmdy011, 
                       g_xmdy_d[g_detail_idx].xmdy012,g_xmdy_d[g_detail_idx].xmdy017,g_xmdy_d[g_detail_idx].xmdy018, 
                       g_xmdy_d[g_detail_idx].xmdy019,g_xmdy_d[g_detail_idx].xmdy013,g_xmdy_d[g_detail_idx].xmdy004, 
                       g_xmdy_d[g_detail_idx].xmdy030,g_xmdy_d[g_detail_idx].xmdy001,g_xmdy2_d[g_detail_idx].xmdy020, 
                       g_xmdy2_d[g_detail_idx].xmdy021,g_xmdy2_d[g_detail_idx].xmdy022,g_xmdy2_d[g_detail_idx].xmdy023) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xmdy_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xmdy2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xmdz_t
                  (xmdzent,
                   xmdzdocno,xmdzseq,
                   xmdzseq1
                   ,xmdz001,xmdz002,xmdz003,xmdz004,xmdz005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xmdy3_d[g_detail_idx2].xmdz001,g_xmdy3_d[g_detail_idx2].xmdz002,g_xmdy3_d[g_detail_idx2].xmdz003, 
                       g_xmdy3_d[g_detail_idx2].xmdz004,g_xmdy3_d[g_detail_idx2].xmdz005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_xmdy3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO xmdw_t
                  (xmdwent,
                   xmdw001,xmdw002,
                   xmdw003
                   ,xmdw004,xmdw005,xmdw006,xmdw007,xmdw008,xmdw009,xmdw010,xmdw011,xmdw012,xmdw013,xmdwsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xmdy4_d[g_detail_idx2].xmdw004,g_xmdy4_d[g_detail_idx2].xmdw005,g_xmdy4_d[g_detail_idx2].xmdw006, 
                       g_xmdy4_d[g_detail_idx2].xmdw007,g_xmdy4_d[g_detail_idx2].xmdw008,g_xmdy4_d[g_detail_idx2].xmdw009, 
                       g_xmdy4_d[g_detail_idx2].xmdw010,g_xmdy4_d[g_detail_idx2].xmdw011,g_xmdy4_d[g_detail_idx2].xmdw012, 
                       g_xmdy4_d[g_detail_idx2].xmdw013,g_xmdy4_d[g_detail_idx2].xmdwsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'4'" THEN 
         CALL g_xmdy4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmt440_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdy_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axmt440_xmdy_t_mask_restore('restore_mask_o')
               
      UPDATE xmdy_t 
         SET (xmdydocno,
              xmdyseq
              ,xmdysite,xmdy002,xmdy003,xmdy005,xmdy006,xmdy007,xmdy014,xmdy008,xmdy009,xmdy010,xmdy024,xmdy011,xmdy012,xmdy017,xmdy018,xmdy019,xmdy013,xmdy004,xmdy030,xmdy001,xmdy020,xmdy021,xmdy022,xmdy023) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmdy_d[g_detail_idx].xmdysite,g_xmdy_d[g_detail_idx].xmdy002,g_xmdy_d[g_detail_idx].xmdy003, 
                  g_xmdy_d[g_detail_idx].xmdy005,g_xmdy_d[g_detail_idx].xmdy006,g_xmdy_d[g_detail_idx].xmdy007, 
                  g_xmdy_d[g_detail_idx].xmdy014,g_xmdy_d[g_detail_idx].xmdy008,g_xmdy_d[g_detail_idx].xmdy009, 
                  g_xmdy_d[g_detail_idx].xmdy010,g_xmdy_d[g_detail_idx].xmdy024,g_xmdy_d[g_detail_idx].xmdy011, 
                  g_xmdy_d[g_detail_idx].xmdy012,g_xmdy_d[g_detail_idx].xmdy017,g_xmdy_d[g_detail_idx].xmdy018, 
                  g_xmdy_d[g_detail_idx].xmdy019,g_xmdy_d[g_detail_idx].xmdy013,g_xmdy_d[g_detail_idx].xmdy004, 
                  g_xmdy_d[g_detail_idx].xmdy030,g_xmdy_d[g_detail_idx].xmdy001,g_xmdy2_d[g_detail_idx].xmdy020, 
                  g_xmdy2_d[g_detail_idx].xmdy021,g_xmdy2_d[g_detail_idx].xmdy022,g_xmdy2_d[g_detail_idx].xmdy023)  
 
         WHERE xmdyent = g_enterprise AND xmdydocno = ps_keys_bak[1] AND xmdyseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdy_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdy_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt440_xmdy_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdz_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL axmt440_xmdz_t_mask_restore('restore_mask_o')
               
      UPDATE xmdz_t 
         SET (xmdzdocno,xmdzseq,
              xmdzseq1
              ,xmdz001,xmdz002,xmdz003,xmdz004,xmdz005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xmdy3_d[g_detail_idx2].xmdz001,g_xmdy3_d[g_detail_idx2].xmdz002,g_xmdy3_d[g_detail_idx2].xmdz003, 
                  g_xmdy3_d[g_detail_idx2].xmdz004,g_xmdy3_d[g_detail_idx2].xmdz005) 
         WHERE xmdzent = g_enterprise AND xmdzdocno = ps_keys_bak[1] AND xmdzseq = ps_keys_bak[2] AND xmdzseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
 
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt440_xmdz_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
 
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdw_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL axmt440_xmdw_t_mask_restore('restore_mask_o')
               
      UPDATE xmdw_t 
         SET (xmdw001,xmdw002,
              xmdw003
              ,xmdw004,xmdw005,xmdw006,xmdw007,xmdw008,xmdw009,xmdw010,xmdw011,xmdw012,xmdw013,xmdwsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xmdy4_d[g_detail_idx2].xmdw004,g_xmdy4_d[g_detail_idx2].xmdw005,g_xmdy4_d[g_detail_idx2].xmdw006, 
                  g_xmdy4_d[g_detail_idx2].xmdw007,g_xmdy4_d[g_detail_idx2].xmdw008,g_xmdy4_d[g_detail_idx2].xmdw009, 
                  g_xmdy4_d[g_detail_idx2].xmdw010,g_xmdy4_d[g_detail_idx2].xmdw011,g_xmdy4_d[g_detail_idx2].xmdw012, 
                  g_xmdy4_d[g_detail_idx2].xmdw013,g_xmdy4_d[g_detail_idx2].xmdwsite) 
         WHERE xmdwent = g_enterprise AND xmdw001 = ps_keys_bak[1] AND xmdw002 = ps_keys_bak[2] AND xmdw003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdw_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt440_xmdw_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axmt440_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'xmdy_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE xmdz_t 
         SET (xmdzdocno,xmdzseq) 
              = 
             (g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq) 
         WHERE xmdzent = g_enterprise AND
               xmdzdocno = ps_keys_bak[1] AND xmdzseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行update
   IF ps_table = 'xmdy_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update3"
      
      #end add-point
      
      UPDATE xmdw_t 
         SET (xmdw001,xmdw002) 
              = 
             (g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq) 
         WHERE xmdwent = g_enterprise AND
               xmdw001 = ps_keys_bak[1] AND xmdw002 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmt440_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'xmdy_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM xmdz_t 
            WHERE xmdzent = g_enterprise AND
                  xmdzdocno = ps_keys_bak[1] AND xmdzseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行delete
   IF ps_table = 'xmdy_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete3"
      
      #end add-point
      
      DELETE FROM xmdw_t 
            WHERE xmdwent = g_enterprise AND
                  xmdw001 = ps_keys_bak[1] AND xmdw002 = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdw_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete3"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmt440_lock_b(ps_table,ps_page)
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
   #CALL axmt440_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "xmdy_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axmt440_bcl USING g_enterprise,
                                       g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt440_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xmdz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt440_bcl2 USING g_enterprise,
                                             g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq,
                                             g_xmdy3_d[g_detail_idx2].xmdzseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt440_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "xmdw_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt440_bcl3 USING g_enterprise,
                                             g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq,
                                             g_xmdy4_d[g_detail_idx2].xmdw003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt440_bcl3:",SQLERRMESSAGE 
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
 
{<section id="axmt440.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmt440_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt440_bcl
   END IF
   
 
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt440_bcl2
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt440_bcl3
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmt440_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xmdxdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmdxdocno",TRUE)
      CALL cl_set_comp_entry("xmdxdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("xmdx010,xmdx012",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmt440_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmdxdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xmdxdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xmdxdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_null(g_xmdx_m.xmdx009) THEN 
      CALL cl_set_comp_entry("xmdx010",FALSE)    
   END IF
   IF cl_null(g_xmdx_m.xmdx011) THEN 
      CALL cl_set_comp_entry("xmdx012",FALSE)    
   END IF  

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmt440_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("xmdy003",TRUE)
   CALL cl_set_comp_entry("xmdy017,xmdy018",TRUE)  
   CALL cl_set_comp_entry("l_pmao009,l_pmao010",TRUE)  
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmt440_set_no_entry_b(p_cmd)
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
   #當料件有使用產品特徵功能時產品特徵欄位才可輸入
   IF NOT axmt440_imaa005_exists() AND NOT cl_null(g_xmdy_d[l_ac].xmdy002) THEN 
      CALL cl_set_comp_entry("xmdy003",FALSE)
      LET g_xmdy_d[l_ac].xmdy003 = ''
      LET g_xmdy_d[l_ac].xmdy003_desc = ''
   END IF
   IF g_xmdx_m.xmdx018 = '1' THEN 
      CALL cl_set_comp_required("xmdy009",TRUE) 
      CALL cl_set_comp_entry("xmdy017,xmdy018",FALSE)
   END IF
   IF g_xmdx_m.xmdx018 = '2' THEN 
      CALL cl_set_comp_required("xmdy017,xmdy018",TRUE) 
   END IF    
   
   IF g_pmao_flag ='Y' THEN
   ELSE
       CALL cl_set_comp_entry("l_pmao009,l_pmao010",FALSE)  
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmt440_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
 
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
    CALL cl_set_act_visible("change_xmdx015",TRUE)   #160324-00037#9 add
    CALL cl_set_act_visible("stus_closed",TRUE)      #160324-00037#9 add
    
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmt440_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_xmdx_m.xmdxstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
  #--160324-00037#9--add--(S) 
   IF g_xmdx_m.xmdxstus <> 'Y' THEN
      CALL cl_set_act_visible("change_xmdx015",FALSE)
   END IF
   IF g_xmdx_m.xmdxstus <> 'Y' AND g_xmdx_m.xmdxstus <> 'C' THEN
      CALL cl_set_act_visible("stus_closed",FALSE)
   END IF   
  #--160324-00037#9--add--(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmt440_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmt440_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmt440_default_search()
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
      LET ls_wc = ls_wc, " xmdxdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmdxdocno = '", g_argv[02], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xmdx_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmdy_t" 
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
   IF NOT cl_null(g_argv[1]) THEN
      IF g_argv[1] = '1' THEN 
         LET g_wc = g_wc, " AND xmdx001 = 'N' "
      ELSE
         LET g_wc = g_wc, " AND xmdx001 = 'Y' "
      END IF      
   END IF
   LET g_wc = g_wc," AND xmdxsite = '",g_site,"'"    #160517-00022#1   
   #LET g_wc = g_wc," AND xmdxsite = '",g_site,"'"   
   IF g_argv[1] = '2' THEN 
      CALL cl_set_comp_visible("xmdy006,xmdy007,xmdy006_desc,xmdy0062,xmdy0072",TRUE)
   ELSE
      CALL cl_set_comp_visible("xmdy006,xmdy007,xmdy006_desc,xmdy0062,xmdy0072",FALSE)
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axmt440_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xmdx_m.xmdxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
   IF STATUS THEN
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt440_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
       g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
       g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
       g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
       g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
       g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
       g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
       g_xmdx_m.xmdxcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT axmt440_action_chk() THEN
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
       g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
       g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
       g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
       g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite, 
       g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid, 
       g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
       g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt 
 
 
   CASE g_xmdx_m.xmdxstus
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
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xmdx_m.xmdxstus
            
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
            WHEN "C"
               HIDE OPTION "closed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
#      HIDE OPTION "verify"
#      CASE g_xmdx_m.xmdxstus
#         WHEN "N"
#            HIDE OPTION "unconfirmed"
#         WHEN "X"
#            EXIT MENU
#         WHEN "Y"
#            HIDE OPTION "confirmed"
#            HIDE OPTION "invalid"
#      END CASE
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_xmdx_m.xmdxstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add
  
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add            
          
         WHEN "X"
            EXIT MENU
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
            CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
             CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
             CALL cl_set_act_visible("closed",FALSE)  #160324-00037#9 add
        #--160324-00037#9--add--(S)  
         WHEN "C" 
            EXIT MENU 
        #--160324-00037#9--add--(E)
      END CASE
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axmt440_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt440_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axmt440_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt440_cl
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
         CALL s_axmt440_conf_chk(g_xmdx_m.xmdxdocno) RETURNING l_success
         IF NOT l_success THEN 
            LET lc_state =''
         END IF         
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
         CALL s_axmt440_invalid_chk(g_xmdx_m.xmdxdocno) RETURNING l_success
         IF NOT l_success THEN 
            LET lc_state =''
         END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
            
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
      AND lc_state <> "C"
      ) OR 
      g_xmdx_m.xmdxstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      IF NOT cl_ask_confirm('lib-014') THEN
         CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
         RETURN
      ELSE
         CALL s_axmt440_conf_upd(g_xmdx_m.xmdxdocno) RETURNING l_success 
         IF NOT l_success THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF   
   END IF
   IF lc_state = 'N' THEN
      IF NOT cl_ask_confirm('lib-015') THEN
         CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
         RETURN
      ELSE   
         CALL s_axmt440_unconf_upd(g_xmdx_m.xmdxdocno) RETURNING l_success
         IF NOT l_success THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF 
      END IF      
   END IF
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
         RETURN
      ELSE   
         CALL s_axmt440_invalid_upd(g_xmdx_m.xmdxdocno) RETURNING l_success
         IF NOT l_success THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF  
      END IF
   END IF   
   #end add-point
   
   LET g_xmdx_m.xmdxmodid = g_user
   LET g_xmdx_m.xmdxmoddt = cl_get_current()
   LET g_xmdx_m.xmdxstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xmdx_t 
      SET (xmdxstus,xmdxmodid,xmdxmoddt) 
        = (g_xmdx_m.xmdxstus,g_xmdx_m.xmdxmodid,g_xmdx_m.xmdxmoddt)     
    WHERE xmdxent = g_enterprise AND xmdxdocno = g_xmdx_m.xmdxdocno
 
    
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axmt440_master_referesh USING g_xmdx_m.xmdxdocno INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000, 
          g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004,g_xmdx_m.xmdx002,g_xmdx_m.xmdx003,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005, 
          g_xmdx_m.xmdx006,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011,g_xmdx_m.xmdx030, 
          g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010, 
          g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid, 
          g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
          g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002_desc, 
          g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdxownid_desc, 
          g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxmodid_desc, 
          g_xmdx_m.xmdxcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt, 
          g_xmdx_m.xmdx004,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003, 
          g_xmdx_m.xmdx003_desc,g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006, 
          g_xmdx_m.xmdx006_desc,g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc, 
          g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc,g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017, 
          g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020,g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001, 
          g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite,g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc, 
          g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid,g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp, 
          g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid,g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt, 
          g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL s_transaction_end('Y','0')
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
   CASE g_xmdx_m.xmdxstus
      WHEN "N"
         CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
      WHEN "Y"
         CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
      WHEN "X"
         CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
   END CASE
   LET g_xmdx_m.xmdxcnfid = '' 
   LET g_xmdx_m.xmdxcnfdt = ''  
   SELECT xmdxcnfid,xmdxcnfdt INTO g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt
     FROM xmdx_t
    WHERE xmdxent = g_enterprise AND xmdxdocno = g_xmdx_m.xmdxdocno
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdxcnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdxcnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdxcnfid_desc    
   DISPLAY BY NAME g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfdt    
   #end add-point  
 
   CLOSE axmt440_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt440_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt440.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmt440_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xmdy_d.getLength() THEN
         LET g_detail_idx = g_xmdy_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdy_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdy_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xmdy2_d.getLength() THEN
         LET g_detail_idx = g_xmdy2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdy2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdy2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_xmdy3_d.getLength() THEN
         LET g_detail_idx2 = g_xmdy3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xmdy3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xmdy3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_xmdy4_d.getLength() THEN
         LET g_detail_idx2 = g_xmdy4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_xmdy4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_xmdy4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmt440_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"


   IF g_detail_idx = 0 OR cl_null(g_detail_idx)THEN 
      RETURN
   END IF
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
   IF axmt440_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_xmdy_d.getLength() > 0 THEN
               CALL g_xmdy3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT xmdzseq,xmdzseq1,xmdz001,xmdz002,xmdz003,xmdz004,xmdz005  FROM xmdz_t", 
                 
                     "",
                     
                     " WHERE xmdzent=? AND xmdzdocno=? AND xmdzseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  xmdz_t.xmdzseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_xmdy3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt440_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR axmt440_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq INTO g_xmdy3_d[l_ac].xmdzseq, 
             g_xmdy3_d[l_ac].xmdzseq1,g_xmdy3_d[l_ac].xmdz001,g_xmdy3_d[l_ac].xmdz002,g_xmdy3_d[l_ac].xmdz003, 
             g_xmdy3_d[l_ac].xmdz004,g_xmdy3_d[l_ac].xmdz005   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_xmdy3_d.deleteElement(g_xmdy3_d.getLength())
 
      END IF
   END IF
 
   IF axmt440_fill_chk(3) THEN
      IF (pi_idx = 3 OR pi_idx = 0 ) AND g_xmdy_d.getLength() > 0 THEN
               CALL g_xmdy4_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT xmdw003,xmdw004,xmdw005,xmdw006,xmdw007,xmdw008,xmdw009,xmdw010, 
             xmdw011,xmdw012,xmdw013,xmdwsite,xmdw001,xmdw002 ,t6.ooag011 ,t7.ooefl003 FROM xmdw_t", 
                 
                     "",
                                    " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xmdw012  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=xmdw013 AND t7.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xmdwent=? AND xmdw001=? AND xmdw002=?"
         
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  xmdw_t.xmdw003" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill3"
         
         #end add-point
         
         #先清空資料
               CALL g_xmdy4_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt440_pb3 FROM g_sql
         DECLARE b_fill_curs3 CURSOR FOR axmt440_pb3
         
      #  OPEN b_fill_curs3 USING g_enterprise,g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs3 USING g_enterprise,g_xmdx_m.xmdxdocno,g_xmdy_d[g_detail_idx].xmdyseq INTO g_xmdy4_d[l_ac].xmdw003, 
             g_xmdy4_d[l_ac].xmdw004,g_xmdy4_d[l_ac].xmdw005,g_xmdy4_d[l_ac].xmdw006,g_xmdy4_d[l_ac].xmdw007, 
             g_xmdy4_d[l_ac].xmdw008,g_xmdy4_d[l_ac].xmdw009,g_xmdy4_d[l_ac].xmdw010,g_xmdy4_d[l_ac].xmdw011, 
             g_xmdy4_d[l_ac].xmdw012,g_xmdy4_d[l_ac].xmdw013,g_xmdy4_d[l_ac].xmdwsite,g_xmdy4_d[l_ac].xmdw001, 
             g_xmdy4_d[l_ac].xmdw002,g_xmdy4_d[l_ac].xmdw012_desc,g_xmdy4_d[l_ac].xmdw013_desc   #(ver:78) 
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill3"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_xmdy4_d.deleteElement(g_xmdy4_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_xmdy3_d_mask_o.* =  g_xmdy3_d.*
   FOR l_ac = 1 TO g_xmdy3_d.getLength()
      LET g_xmdy3_d_mask_o[l_ac].* =  g_xmdy3_d[l_ac].*
      CALL axmt440_xmdz_t_mask()
      LET g_xmdy3_d_mask_n[l_ac].* =  g_xmdy3_d[l_ac].*
   END FOR
   LET g_xmdy4_d_mask_o.* =  g_xmdy4_d.*
   FOR l_ac = 1 TO g_xmdy4_d.getLength()
      LET g_xmdy4_d_mask_o[l_ac].* =  g_xmdy4_d[l_ac].*
      CALL axmt440_xmdw_t_mask()
      LET g_xmdy4_d_mask_n[l_ac].* =  g_xmdy4_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axmt440_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmt440_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt440.status_show" >}
PRIVATE FUNCTION axmt440_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt440.mask_functions" >}
&include "erp/axm/axmt440_mask.4gl"
 
{</section>}
 
{<section id="axmt440.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axmt440_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL axmt440_show()
   CALL axmt440_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_axmt440_conf_chk(g_xmdx_m.xmdxdocno) THEN 
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xmdx_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xmdy_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xmdy2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_xmdy3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_xmdy4_d))
 
 
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
   #CALL axmt440_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axmt440_ui_headershow()
   CALL axmt440_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axmt440_draw_out()
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
   CALL axmt440_ui_headershow()  
   CALL axmt440_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axmt440.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmt440_set_pk_array()
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
   LET g_pk_array[1].values = g_xmdx_m.xmdxdocno
   LET g_pk_array[1].column = 'xmdxdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt440.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axmt440.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmt440_msgcentre_notify(lc_state)
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
   CALL axmt440_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmdx_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt440.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmt440_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#43-s
   SELECT xmdxstus INTO g_xmdx_m.xmdxstus FROM xmdx_t
    WHERE xmdxent = g_enterprise
      AND xmdxsite = g_site
      AND xmdxdocno = g_xmdx_m.xmdxdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xmdx_m.xmdxstus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'C'
           LET g_errno = 'ain-00197'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_xmdx_m.xmdxdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL axmt440_set_act_visible()
        CALL axmt440_set_act_no_visible()
        CALL axmt440_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#43-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt440.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt440_xmdx004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx004
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx004_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx002
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? AND oofa002 = '2' ","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx002_desc  
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx003_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag003 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx003 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx003
   
   CALL axmt440_xmdx003_desc() 
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx005_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx006_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx006
   CALL ap_ref_array2(g_ref_fields,"SELECT oodb005,oodb006 FROM oodb_t WHERE oodbent='"||g_enterprise||"' AND oodb001='"||g_ooef.ooef019||"' AND oodb002=? ","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx008 = g_rtn_fields[1]
   LET g_xmdx_m.xmdx007 = g_rtn_fields[2]
   DISPLAY BY NAME g_xmdx_m.xmdx007,g_xmdx_m.xmdx008

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx006
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||g_ooef.ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx006_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx011_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx011_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx009_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx009
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdx_m.xmdx009_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy002_desc = '', g_rtn_fields[1] , ''
   LET g_xmdy_d[l_ac].xmdy002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy002_desc,g_xmdy_d[l_ac].xmdy002_desc_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdx_m.xmdx004
   CALL ap_ref_array2(g_ref_fields,"SELECT pmab083,pmab084,pmab087,pmab103 FROM pmab_t WHERE pmabent='"||g_enterprise||"' AND pmabsite = '"||g_xmdx_m.xmdxsite||"' AND pmab001=? ","") RETURNING g_rtn_fields
   LET g_xmdx_m.xmdx005 = g_rtn_fields[1] 
   LET g_xmdx_m.xmdx006 = g_rtn_fields[2]
   LET g_xmdx_m.xmdx009 = g_rtn_fields[3] 
   LET g_xmdx_m.xmdx011 = g_rtn_fields[4]
   DISPLAY BY NAME g_xmdx_m.xmdx005,g_xmdx_m.xmdx006,g_xmdx_m.xmdx009,g_xmdx_m.xmdx011 
   CALL axmt440_xmdx005_desc()
   CALL axmt440_xmdx006_desc()
   CALL axmt440_xmdx009_desc()
   CALL axmt440_xmdx011_desc()

   CALL axmt440_pmab089()
 
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy013_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy013_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy006_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy006_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy002_xmdy003_ref(p_xmdy002,p_xmdy003)
DEFINE p_xmdy002      LIKE xmdy_t.xmdy002
DEFINE p_xmdy003      LIKE xmdy_t.xmdy003
DEFINE l_pmao004      LIKE pmao_t.pmao004       #交易對象料件編號
DEFINE l_success      LIKE type_t.num5          #返回狀態
   
   LET l_pmao004 = ' '
   #add--2015/03/26 By shiun--(S)
   IF cl_null(p_xmdy002) THEN   
      RETURN ''
   END IF
   IF axmt440_imaa005_exists() THEN
      IF p_xmdy003 IS NOT NULL THEN
         #161221-00064#15 mod-S
#         CALL s_apmi070_get_pmao004(g_xmdx_m.xmdx004,p_xmdy002,p_xmdy003) RETURNING l_success,l_pmao004
         CALL s_apmi070_get_pmao004_2(g_xmdx_m.xmdx004,p_xmdy002,p_xmdy003,'2') RETURNING l_success,l_pmao004
         #161221-00064#15 mod-E
      END IF
   ELSE
      #161221-00064#15 mod-S
#      CALL s_apmi070_get_pmao004(g_xmdx_m.xmdx004,p_xmdy002,' ') RETURNING l_success,l_pmao004
      CALL s_apmi070_get_pmao004_2(g_xmdx_m.xmdx004,p_xmdy002,' ','2') RETURNING l_success,l_pmao004
      #161221-00064#15 mod-E
   END IF
   #add--2015/03/26 By shiun--(E)
   #mark--2015/03/26 By shiun--(S)
#   IF NOT cl_null(p_xmdy002) AND p_xmdy003 IS NOT NULL THEN 
#      CALL s_apmi070_get_pmao004(g_xmdx_m.xmdx004,p_xmdy002,p_xmdy003) RETURNING l_success,l_pmao004
#   END IF      
   #mark--2015/03/26 By shiun--(E)
   RETURN l_pmao004
 
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy014_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='277' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy014_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy011_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy011
   CALL ap_ref_array2(g_ref_fields,"SELECT oodb006 FROM oodb_t WHERE oodbent='"||g_enterprise||"' AND oodb001='"||g_ooef.ooef019||"' AND oodb002=? ","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy012 = g_rtn_fields[1]
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy012
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy002_ref()
DEFINE l_imaf123    LIKE imaf_t.imaf123   
DEFINE l_success    LIKE type_t.num5

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaf112,imaf113,imaf123 FROM imaf_t WHERE imafent='"||g_enterprise||"' AND imaf001=? AND imafsite='"||g_xmdy_d[l_ac].xmdysite||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy008 = g_rtn_fields[1]
   LET l_imaf123 = g_rtn_fields[2]
   IF NOT cl_null(l_imaf123) THEN 
      LET g_xmdy_d[l_ac].xmdy008 = l_imaf123
   END IF   
   LET g_xmdy_d[l_ac].xmdy004 = g_rtn_fields[3]    
   
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy008,g_xmdy_d[l_ac].xmdy004
   CALL axmt440_xmdy009_round()
   
   IF g_tax_app = '2' THEN
      #依料件設定
      CALL s_tax_chktype(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx004,g_xmdy_d[l_ac].xmdy002,
                         '1',g_pmab089)
           RETURNING l_success,g_xmdy_d[l_ac].xmdy011,g_xmdy_d[l_ac].xmdy012
   ELSE
      #依正常稅率
      LET g_xmdy_d[l_ac].xmdy011 = g_xmdx_m.xmdx006
      LET g_xmdy_d[l_ac].xmdy012 = g_xmdx_m.xmdx007
   END IF
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy011,g_xmdy_d[l_ac].xmdy012 
   CALL axmt440_xmdy011_desc()
   CALL axmt440_get_amount(g_xmdy_d[l_ac].xmdyseq,g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy010,g_xmdy_d[l_ac].xmdy011)  
      RETURNING g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy009,g_xmdy_d[l_ac].xmdy017,g_xmdy_d[l_ac].xmdy018,g_xmdy_d[l_ac].xmdy019  
                  
END FUNCTION

PRIVATE FUNCTION axmt440_xmdxdocno_desc(p_flag,p_xmdxdocno)
DEFINE p_flag     LIKE type_t.chr1 
DEFINE p_xmdxdocno LIKE xmdx_t.xmdxdocno
DEFINE l_ooba002  LIKE ooba_t.ooba002
DEFINE l_success  LIKE type_t.num5
DEFINE r_xmdxdocno_desc LIKE type_t.chr80

   IF p_flag = '2' THEN  
      Call s_aooi200_get_slip(p_xmdxdocno) returning l_success,l_ooba002
   ELSE
      LET l_ooba002 = p_xmdxdocno   
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooba002
   CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001= ? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_xmdxdocno_desc = '', g_rtn_fields[1] , ''
   RETURN r_xmdxdocno_desc
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy009_round()
DEFINE l_success   LIKE type_t.num5,
       l_ooca002   LIKE ooca_t.ooca002,
       l_ooca004   LIKE ooca_t.ooca004

   IF NOT cl_null(g_xmdy_d[l_ac].xmdy008) AND NOT cl_null(g_xmdy_d[l_ac].xmdy009) THEN 
      CALL s_aooi250_get_msg(g_xmdy_d[l_ac].xmdy008) RETURNING l_success,l_ooca002,l_ooca004
      IF l_success = TRUE THEN 
         CALL s_num_round(l_ooca004,g_xmdy_d[l_ac].xmdy009,l_ooca002) RETURNING g_xmdy_d[l_ac].xmdy009
      END IF
   END IF
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy005_ref()
DEFINE l_success    LIKE type_t.num5 
DEFINE l_pmao002    LIKE pmao_t.pmao002       #公司料件編號
DEFINE l_pmao003    LIKE pmao_t.pmao003       #產品特徵   
   
   #161221-00064#15 mod-S
#   CALL s_apmi070_get_pmao002_pmao003(g_xmdx_m.xmdx004,g_xmdy_d[l_ac].xmdy005) RETURNING l_success,l_pmao002,l_pmao003
   CALL s_apmi070_get_pmao002_pmao003_2(g_xmdx_m.xmdx004,g_xmdy_d[l_ac].xmdy005,'2') RETURNING l_success,l_pmao002,l_pmao003
   #161221-00064#15 mod-E
   IF l_success THEN 
      LET g_xmdy_d[l_ac].xmdy002 = l_pmao002
      LET g_xmdy_d[l_ac].xmdy003 = l_pmao003
   END IF
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy002,g_xmdy_d[l_ac].xmdy003 
   CALL axmt440_xmdy002_ref()   
END FUNCTION

PRIVATE FUNCTION axmt440_change_xmdx011(p_cmd)
DEFINE p_cmd             LIKE type_t.chr1
DEFINE l_i               LIKE type_t.num10
DEFINE l_success         LIKE type_t.num5
DEFINE l_xmdyseq         LIKE xmdy_t.xmdyseq
DEFINE l_xmdy002         LIKE xmdy_t.xmdy002
DEFINE l_xmdy009         LIKE xmdy_t.xmdy009
DEFINE l_xmdy010         LIKE xmdy_t.xmdy010
DEFINE l_xmdy011         LIKE xmdy_t.xmdy011
DEFINE l_xmdy012         LIKE xmdy_t.xmdy012
DEFINE l_xmdy017         LIKE xmdy_t.xmdy017
DEFINE l_xmdy018         LIKE xmdy_t.xmdy018
DEFINE l_xmdy019         LIKE xmdy_t.xmdy019

   #單頭新增時，因單身資料還沒insert到資料庫，所以只改變畫面上的顯示
   IF p_cmd = 'a' THEN
      FOR l_i = 1 TO g_xmdy_d.getLength()
         IF g_tax_app = '2' THEN
            #依料件設定
            CALL s_tax_chktype(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx004,g_xmdy_d[l_i].xmdy002,
                               '1',g_pmab089)
                 RETURNING l_success,g_xmdy_d[l_i].xmdy011,g_xmdy_d[l_i].xmdy012
         ELSE
            #依正常稅率
            LET g_xmdy_d[l_i].xmdy011 = g_xmdx_m.xmdx006
            LET g_xmdy_d[l_i].xmdy012 = g_xmdx_m.xmdx007
         END IF

         #重計未稅金額、含稅金額、稅額
         CALL axmt440_get_amount(g_xmdy_d[l_i].xmdyseq,g_xmdy_d[l_i].xmdy009,
                                 g_xmdy_d[l_i].xmdy010,g_xmdy_d[l_i].xmdy011)
              RETURNING g_xmdy_d[l_i].xmdy017,g_xmdy_d[l_i].xmdy018,g_xmdy_d[l_i].xmdy019
      END FOR
   ELSE
      DECLARE sel_xmdy_cs CURSOR FOR
       SELECT xmdyseq,xmdy002,xmdy009,xmdy010
         FROM xmdy_t
        WHERE xmdyent = g_enterprise
          AND xmdydocno = g_xmdx_m.xmdxdocno
         
      FOREACH sel_xmdy_cs INTO l_xmdyseq,l_xmdy002,l_xmdy009,l_xmdy010
         IF g_tax_app = '2' THEN
            #依料件設定
            CALL s_tax_chktype(g_xmdx_m.xmdxsite,g_xmdx_m.xmdx004,l_xmdy002,
                               '1',g_pmab089)
                 RETURNING l_success,l_xmdy011,l_xmdy012
         ELSE
            #依正常稅率
            LET l_xmdy011 = g_xmdx_m.xmdx006
            LET l_xmdy012 = g_xmdx_m.xmdx007
         END IF

         #重計未稅金額、含稅金額、稅額
         CALL axmt440_get_amount(l_xmdyseq,l_xmdy009,
                                 l_xmdy010,l_xmdy011)
              RETURNING l_xmdy017,l_xmdy018,l_xmdy019

         UPDATE xmdy_t SET xmdy011 = l_xmdy011,
                           xmdy012 = l_xmdy012,
                           xmdy017 = l_xmdy017,
                           xmdy018 = l_xmdy018,
                           xmdy019 = l_xmdy019
          WHERE xmdyent = g_enterprise
            AND xmdydocno = g_xmdx_m.xmdxdocno
            AND xmdyseq = l_xmdyseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "xmdy_t:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF            
      END FOREACH
      CALL axmt440_b_fill()
   END IF
END FUNCTION

PRIVATE FUNCTION axmt440_get_amount(p_xmdyseq,p_xmdy009,p_xmdy010,p_xmdy011)
DEFINE p_xmdyseq         LIKE xmdy_t.xmdyseq
DEFINE p_xmdy009         LIKE xmdy_t.xmdy009
DEFINE p_xmdy010         LIKE xmdy_t.xmdy010
DEFINE p_xmdy011         LIKE xmdy_t.xmdy011
DEFINE r_xmdy017         LIKE xmdy_t.xmdy017
DEFINE r_xmdy018         LIKE xmdy_t.xmdy018
DEFINE r_xmdy019         LIKE xmdy_t.xmdy019
DEFINE l_money           LIKE xmdy_t.xmdy017
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_xrcd123         LIKE xrcd_t.xrcd113
DEFINE l_xrcd124         LIKE xrcd_t.xrcd114
DEFINE l_xrcd125         LIKE xrcd_t.xrcd115
DEFINE l_xrcd133         LIKE xrcd_t.xrcd113
DEFINE l_xrcd134         LIKE xrcd_t.xrcd114
DEFINE l_xrcd135         LIKE xrcd_t.xrcd115

   LET r_xmdy017 = 0
   LET r_xmdy018 = 0
   LET r_xmdy019 = 0

   IF cl_null(p_xmdyseq) OR cl_null(p_xmdy009) OR
      cl_null(p_xmdy010) OR cl_null(p_xmdy011) THEN
      RETURN r_xmdy017,r_xmdy018,r_xmdy019
   END IF

   LET l_money = p_xmdy009 * p_xmdy010
   CALL s_tax_ins(g_xmdx_m.xmdxdocno,p_xmdyseq,0,g_xmdx_m.xmdxsite,l_money,p_xmdy011,
                  p_xmdy009,g_xmdx_m.xmdx005,1,' ',1,1)
        RETURNING r_xmdy017,r_xmdy019,r_xmdy018,l_xrcd113,l_xrcd114,l_xrcd115,
                  l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

   IF cl_null(r_xmdy017) THEN LET r_xmdy017 = 0 END IF
   IF cl_null(r_xmdy018) THEN LET r_xmdy018 = 0 END IF
   IF cl_null(r_xmdy019) THEN LET r_xmdy019 = 0 END IF

   RETURN r_xmdy017,r_xmdy018,r_xmdy019
END FUNCTION

PRIVATE FUNCTION axmt440_pmab089()
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_xmdx_m.xmdx004
  CALL ap_ref_array2(g_ref_fields,"SELECT pmab089 FROM pmab_t WHERE pmabent='"||g_enterprise||"' AND pmabsite = '"||g_xmdx_m.xmdxsite||"' AND pmab001=? ","") RETURNING g_rtn_fields
  LET g_pmab089 = g_rtn_fields[1]
END FUNCTION

PRIVATE FUNCTION axmt440_xmdx015_def()
DEFINE l_ooba002   LIKE ooba_t.ooba002
DEFINE l_success   LIKE type_t.num5
DEFINE l_mm        LIKE type_t.num5

   IF NOT cl_null(g_xmdx_m.xmdx014) THEN 
      CALL s_aooi200_get_slip(g_xmdx_m.xmdxdocno) RETURNING l_success,l_ooba002
      CALL cl_get_doc_para(g_enterprise,g_xmdx_m.xmdxsite,l_ooba002,'D-BAS-0080') RETURNING l_mm
      IF NOT cl_null(l_mm) AND l_mm <> 0 THEN
      CALL s_date_get_date(g_xmdx_m.xmdx014,l_mm,0) RETURNING g_xmdx_m.xmdx015
      DISPLAY BY NAME g_xmdx_m.xmdx015
      END IF
   END IF
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy_upd()
DEFINE l_xmdyseq   LIKE xmdy_t.xmdyseq
DEFINE l_xmdy009   LIKE xmdy_t.xmdy009
DEFINE l_xmdy010   LIKE xmdy_t.xmdy010
DEFINE l_xmdy011   LIKE xmdy_t.xmdy011
DEFINE l_xmdy017   LIKE xmdy_t.xmdy017
DEFINE l_xmdy018   LIKE xmdy_t.xmdy018
DEFINE l_xmdy019   LIKE xmdy_t.xmdy019
DEFINE l_sql       STRING

   LET l_sql = " SELECT xmdyseq,xmdy009,xmdy010,xmdy011 FROM xmdy_t ",
               "  WHERE xmdyent = '",g_enterprise,"'"  ,
               "    AND xmdydocno = '",g_xmdx_m.xmdxdocno,"'"
   PREPARE t440_xmdy_pre FROM l_sql
   DECLARE t440_xmdy_cs CURSOR FOR t440_xmdy_pre
   FOREACH t440_xmdy_cs INTO l_xmdyseq,l_xmdy009,l_xmdy010,l_xmdy011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF  
      CALL s_curr_round(g_site,g_xmdx_m.xmdx005,l_xmdy010,'1') RETURNING l_xmdy010
      CALL axmt440_get_amount(l_xmdyseq,l_xmdy009,l_xmdy010,l_xmdy011)  
         RETURNING l_xmdy017,l_xmdy018,l_xmdy019
      UPDATE xmdy_t 
         SET xmdy010 = l_xmdy010,
             xmdy017 = l_xmdy017,
             xmdy018 = l_xmdy018,
             xmdy019 = l_xmdy019
       WHERE xmdyent = g_enterprise
         AND xmdydocno = g_xmdx_m.xmdxdocno
         AND xmdyseq = l_xmdyseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdy_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH 
   CALL axmt440_b_fill()   
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy005_upd()
DEFINE l_xmdyseq   LIKE xmdy_t.xmdyseq
DEFINE l_xmdy002   LIKE xmdy_t.xmdy002
DEFINE l_xmdy003   LIKE xmdy_t.xmdy003
DEFINE l_xmdy005   LIKE xmdy_t.xmdy005
DEFINE l_sql       STRING

   LET l_sql = " SELECT xmdyseq,xmdy002,xmdy003 FROM xmdy_t ",
               "  WHERE xmdyent = '",g_enterprise,"'"  ,
               "    AND xmdydocno = '",g_xmdx_m.xmdxdocno,"'"
   PREPARE t440_xmdy005_pre FROM l_sql
   DECLARE t440_xmdy005_cs CURSOR FOR t440_xmdy005_pre
   FOREACH t440_xmdy005_cs INTO l_xmdyseq,l_xmdy002,l_xmdy003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF  
      CALL axmt440_xmdy002_xmdy003_ref(l_xmdy002,l_xmdy003) RETURNING l_xmdy005
      IF cl_null(l_xmdy005) THEN LET l_xmdy005 = ' ' END IF
      UPDATE xmdy_t 
         SET xmdy005 = l_xmdy005
       WHERE xmdyent = g_enterprise
         AND xmdydocno = g_xmdx_m.xmdxdocno
         AND xmdyseq = l_xmdyseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdy_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH 
   CALL axmt440_b_fill() 
END FUNCTION

PRIVATE FUNCTION axmt440_imaa005_exists()
DEFINE l_imaa005  LIKE imaa_t.imaa005
   IF NOT cl_null(g_xmdy_d[l_ac].xmdy002) THEN
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 =  g_xmdy_d[l_ac].xmdy002
      IF cl_null(l_imaa005) THEN
         RETURN FALSE
      END IF
   ELSE
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION axmt440_xmdy011_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdy_d[l_ac].xmdy011
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||g_ooef.ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdy_d[l_ac].xmdy011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdy_d[l_ac].xmdy011_desc
END FUNCTION

PRIVATE FUNCTION axmt440_slip_default()
   LET g_xmdx_m.xmdxdocdt = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdxdocdt',g_xmdx_m.xmdxdocdt)
   LET g_xmdx_m.xmdx002 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx002',g_xmdx_m.xmdx002)
   LET g_xmdx_m.xmdx003 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx003',g_xmdx_m.xmdx003)
   LET g_xmdx_m.xmdx004 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx004',g_xmdx_m.xmdx004)
   LET g_xmdx_m.xmdx005 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx005',g_xmdx_m.xmdx005)
   LET g_xmdx_m.xmdx006 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx006',g_xmdx_m.xmdx006)
   LET g_xmdx_m.xmdx007 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx007',g_xmdx_m.xmdx007)
   LET g_xmdx_m.xmdx008 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx008',g_xmdx_m.xmdx008)
   LET g_xmdx_m.xmdx009 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx009',g_xmdx_m.xmdx009)
   LET g_xmdx_m.xmdx010 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx010',g_xmdx_m.xmdx010)
   LET g_xmdx_m.xmdx011 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx011',g_xmdx_m.xmdx011)
   LET g_xmdx_m.xmdx012 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx012',g_xmdx_m.xmdx012)
   #LET g_xmdx_m.xmdx013 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx013',g_xmdx_m.xmdx013)
   LET g_xmdx_m.xmdx014 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx014',g_xmdx_m.xmdx014)
   LET g_xmdx_m.xmdx015 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx015',g_xmdx_m.xmdx015)
   LET g_xmdx_m.xmdx016 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx016',g_xmdx_m.xmdx016)
   LET g_xmdx_m.xmdx017 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx017',g_xmdx_m.xmdx017)
   LET g_xmdx_m.xmdx018 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx018',g_xmdx_m.xmdx018)
   LET g_xmdx_m.xmdx019 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx019',g_xmdx_m.xmdx019)
   LET g_xmdx_m.xmdx020 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx020',g_xmdx_m.xmdx020)
   LET g_xmdx_m.xmdx030 = s_aooi200_get_doc_default(g_site,'1',g_xmdx_m.xmdxdocno,'xmdx030',g_xmdx_m.xmdx030)
   
   CALL axmt440_xmdx002_desc()
   CALL axmt440_xmdx003_desc()
   CALL axmt440_xmdx004_desc()
   CALL axmt440_xmdx005_desc()
   CALL axmt440_xmdx006_desc()
   CALL axmt440_xmdx009_desc()
   CALL axmt440_xmdx011_desc() 
   
   DISPLAY BY NAME g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc, 
       g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdx004,g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
       g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
       g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
       g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
       g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015  
END FUNCTION

################################################################################
# Descriptions...: 输入客户料号不存在时自动新增到pmao_t中
################################################################################
PRIVATE FUNCTION axmt440_ins_pmao()
DEFINE l_pmao  RECORD 
         pmaoent     LIKE pmao_t.pmaoent,
         pmaoownid   LIKE pmao_t.pmaoownid,
         pmaoowndp   LIKE pmao_t.pmaoowndp,
         pmaocrtid   LIKE pmao_t.pmaocrtid,
         pmaocrtdp   LIKE pmao_t.pmaocrtdp,
         pmaocrtdt   DATETIME YEAR TO SECOND,
         pmaomodid   LIKE pmao_t.pmaomodid,
         pmaomoddt   DATETIME YEAR TO SECOND,
         pmaostus    LIKE pmao_t.pmaostus,
         pmao000     LIKE pmao_t.pmao000,    #161221-00064#1 add       
         pmao001     LIKE pmao_t.pmao001,
         pmao002     LIKE pmao_t.pmao002,
         pmao003     LIKE pmao_t.pmao003,
         pmao004     LIKE pmao_t.pmao004,
         pmao005     LIKE pmao_t.pmao005,
         pmao006     LIKE pmao_t.pmao006,
         pmao007     LIKE pmao_t.pmao007,
         pmao008     LIKE pmao_t.pmao008,
         pmao009     LIKE pmao_t.pmao009, 
         pmao010     LIKE pmao_t.pmao010
      END RECORD
DEFINE l_cnt LIKE type_t.num5


   IF cl_null(g_xmdy_d[l_ac].xmdy005) OR g_xmdy_d[l_ac].xmdy003 IS NULL THEN 
      RETURN
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM pmao_t
    WHERE pmaoent = g_enterprise
      AND pmao001 = g_xmdx_m.xmdx004                 
      AND pmao002 = g_xmdy_d[l_ac].xmdy002
      AND pmao003 = g_xmdy_d[l_ac].xmdy003
      AND pmao004 = g_xmdy_d[l_ac].xmdy005
      AND pmao000 = '2'   #161221-00064#1 add
   IF l_cnt > 0 THEN 
      RETURN
   END IF

   LET l_pmao.pmaoent = g_enterprise
   LET l_pmao.pmaoownid = g_user
   LET l_pmao.pmaoowndp = g_dept
   LET l_pmao.pmaocrtid = g_user
   LET l_pmao.pmaocrtdp = g_dept
   LET l_pmao.pmaocrtdt = cl_get_current()
   LET l_pmao.pmaomodid = g_user
   LET l_pmao.pmaomoddt = cl_get_current()
   LET l_pmao.pmaostus = 'Y'
   LET l_pmao.pmao001 = g_xmdx_m.xmdx004
   LET l_pmao.pmao002 = g_xmdy_d[l_ac].xmdy002
   LET l_pmao.pmao003 = g_xmdy_d[l_ac].xmdy003
   LET l_pmao.pmao004 = g_xmdy_d[l_ac].xmdy005
   LET l_pmao.pmao005 = ''
   LET l_pmao.pmao006 = ''
   LET l_pmao.pmao007 = 'N'
   LET l_pmao.pmao008 = 0
   LET l_pmao.pmao009 = g_xmdy_d[l_ac].l_pmao009 
   LET l_pmao.pmao010 = g_xmdy_d[l_ac].l_pmao010 
   LET l_pmao.pmao000 = '2'  #161221-00064#1 add

   INSERT INTO pmao_t(pmaoent,pmaoownid,pmaoowndp,pmaocrtid,pmaocrtdp,pmaocrtdt,pmaomodid,pmaomoddt,
                      pmaostus,pmao000,pmao001,pmao002,pmao003,pmao004,pmao005,pmao006,pmao007,pmao008,pmao009,pmao010) #161221-00064#1 add pmaa000 
        VALUES (l_pmao.*)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins pmao_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 結算還原
# Memo...........:
# Usage..........: CALL axmt440_clear_xmdw(p_xmdydocno,p_xmdyseq)
#                  RETURNING r_success
# Input parameter: p_xmdydocno    單號
#                : p_xmdyseq      項次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20150310 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt440_clear_xmdw(p_xmdydocno,p_xmdyseq)
  DEFINE p_xmdydocno   LIKE xmdy_t.xmdydocno
  DEFINE p_xmdyseq     LIKE xmdy_t.xmdyseq
  DEFINE l_xmdw003     LIKE xmdw_t.xmdw003
  DEFINE l_cnt         LIKE type_t.num5
  DEFINE r_success     LIKE type_t.num5
  
  
    LET r_success = TRUE
       
    #抓取最近結算日期xmdw
    SELECT MAX(xmdw003)
      INTO l_xmdw003
      FROM xmdw_t
     WHERE xmdwent = g_enterprise
       AND xmdw001 = p_xmdydocno
       AND xmdw002 = p_xmdyseq
       
    #檢查銷售合約/核價結算來源單據明細檔xmde是否已處理了(xmde023為'2)，則不可還原   
    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt
      FROM xmde_t
     WHERE xmdeent = g_enterprise
       AND xmde000 = '1'     #合約關聯資料
       AND xmde001 = p_xmdydocno
       AND xmde002 = p_xmdyseq
       AND xmde005 = l_xmdw003
       AND xmde025 = '2'  
    IF l_cnt > 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code   = 'axm-00625'
       LET g_errparam.extend = p_xmdydocno       
       LET g_errparam.replace[1] = l_xmdw003
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success
    END IF


    #將相對應的xmde刪除
    DELETE FROM xmde_t
     WHERE xmdeent = g_enterprise
       AND xmde000 = '1'             #合約關聯資料
       AND xmde001 = p_xmdydocno
       AND xmde002 = p_xmdyseq
       AND xmde005 = l_xmdw003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "delete xmde_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF
   #將相對應的xmdw刪除
   DELETE FROM xmdw_t
    WHERE xmdwent = g_enterprise
      AND xmdw001 = p_xmdydocno
      AND xmdw002 = p_xmdyseq   
      AND xmdw003 = l_xmdw003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "delete xmdw_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF

    
    RETURN r_success



END FUNCTION
################################################################################
# Descriptions...: 修改失效日期
# Memo...........:
# Usage..........: CALL axmt440_change_xmdx015()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 160324-00037#9 2016/04/28 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt440_change_xmdx015()
   DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'OPEN axmt440_cl:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      CLOSE axmt440_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   CALL axmt440_show()
   LET g_xmdxdocno_t = g_xmdx_m.xmdxdocno

   INPUT BY NAME g_xmdx_m.xmdx015 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT 
         LET g_xmdx_m_t.* = g_xmdx_m.* 
         LET g_xmdx_m_o.* = g_xmdx_m.* 

      AFTER FIELD xmdx015
         IF NOT cl_null(g_xmdx_m.xmdx015) AND (g_xmdx_m_o.xmdx015 IS NULL OR
                                               g_xmdx_m_o.xmdx015 <> g_xmdx_m.xmdx015) THEN
            IF g_xmdx_m.xmdx015 < g_xmdx_m.xmdx014 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_xmdx_m.xmdx015
               LET g_errparam.code   = 'ais-00048' 
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_xmdx_m.xmdx015 = g_xmdx_m_o.xmdx015
               NEXT FIELD CURRENT
            END IF
         END IF

         LET g_xmdx_m_o.xmdx015 = g_xmdx_m.xmdx015

      AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF

      ON ACTION accept
         ACCEPT INPUT

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT INPUT

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT INPUT

      ON ACTION close
         LET INT_FLAG =TRUE 
         EXIT INPUT

   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET g_xmdx_m.* = g_xmdx_m_t.*
      CALL axmt440_show()

      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 9001
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      CLOSE axmt440_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   UPDATE xmdx_t SET xmdx015 = g_xmdx_m.xmdx015
    WHERE xmdxent   = g_enterprise
      AND xmdxdocno = g_xmdxdocno_t
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'upd xmdx_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      CLOSE axmt440_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   CLOSE axmt440_cl

   RETURN r_success 
END FUNCTION

#161031-00025#21 add
#維護備註單身
PRIVATE FUNCTION axmt440_remaks()

   IF g_xmdx_m.xmdxdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
       
   CALL s_transaction_begin()
   
   OPEN axmt440_cl USING g_enterprise,g_xmdx_m.xmdxdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmt440_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #鎖住將被更改的資料
   FETCH axmt440_cl INTO g_xmdx_m.xmdxdocno,g_xmdx_m.xmdx000,g_xmdx_m.xmdxdocno_desc,g_xmdx_m.xmdxdocdt,g_xmdx_m.xmdx004, 
                         g_xmdx_m.xmdx004_desc,g_xmdx_m.xmdx002,g_xmdx_m.xmdx002_desc,g_xmdx_m.xmdx003,g_xmdx_m.xmdx003_desc, 
                         g_xmdx_m.xmdxstus,g_xmdx_m.xmdx005,g_xmdx_m.xmdx005_desc,g_xmdx_m.xmdx006,g_xmdx_m.xmdx006_desc, 
                         g_xmdx_m.xmdx007,g_xmdx_m.xmdx008,g_xmdx_m.xmdx009,g_xmdx_m.xmdx009_desc,g_xmdx_m.xmdx011,g_xmdx_m.xmdx011_desc, 
                         g_xmdx_m.xmdx030,g_xmdx_m.xmdx016,g_xmdx_m.xmdx017,g_xmdx_m.xmdx018,g_xmdx_m.xmdx019,g_xmdx_m.xmdx020, 
                         g_xmdx_m.xmdx010,g_xmdx_m.xmdx012,g_xmdx_m.xmdx001,g_xmdx_m.xmdx014,g_xmdx_m.xmdx015,g_xmdx_m.xmdxsite, 
                         g_xmdx_m.xmdxownid,g_xmdx_m.xmdxownid_desc,g_xmdx_m.xmdxowndp,g_xmdx_m.xmdxowndp_desc,g_xmdx_m.xmdxcrtid, 
                         g_xmdx_m.xmdxcrtid_desc,g_xmdx_m.xmdxcrtdp,g_xmdx_m.xmdxcrtdp_desc,g_xmdx_m.xmdxcrtdt,g_xmdx_m.xmdxmodid, 
                         g_xmdx_m.xmdxmodid_desc,g_xmdx_m.xmdxmoddt,g_xmdx_m.xmdxcnfid,g_xmdx_m.xmdxcnfid_desc,g_xmdx_m.xmdxcnfdt 
       
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xmdx_m.xmdxdocno
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF
 
   #檢查是否允許此動作
   IF NOT axmt440_action_chk() THEN
      CLOSE axmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog   
   LET g_ooff003_d = g_xmdx_m.xmdxdocno   #单号  
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
    
   CLOSE axmt440_cl
   
   CALL s_transaction_end('Y','0')
   
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身
   
END FUNCTION

 
{</section>}
 
