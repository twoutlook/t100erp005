#該程式未解開Section, 採用最新樣板產出!
{<section id="apst300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2016-05-16 15:08:58), PR版次:0023(2017-01-10 19:20:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000236
#+ Filename...: apst300
#+ Description: 獨立需求維護作業
#+ Creator....: 02295(2014-03-05 15:31:26)
#+ Modifier...: 03079 -SD/PR- 08992
 
{</section>}
 
{<section id="apst300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4   2015/12/01   By 06948   增加作廢時詢問「是否作廢」
#160214-00005#4   2016/02/19   By 07024   1.增加「BOM特性」欄位 2.料件+BOM特性校驗
#160307-00012#1   2016/03/15   By 07024   複製時,單身的已耗需求(psab006)歸零、讓「淨需求量=需求數量」
#                 2016/03/24   By 07024   修正複製時申請人員、部門的說明，及修正異動頁籤的說明
#160318-00025#2   2016/04/07   By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160509-00009#3   2016/05/16   By ming    單身增加欄位 保稅否(psab013)，新增時預設料件據點資料imaf034 
#160613-00038#1   2016/06/14   By 06821   s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160627-00021#1   2016/07/15   By 07024   需求數量psab005要按單位psab004取位，CALL s_aooi250_take_decimals
#160729-00074#1   2016/08/08   By 07024   修正結案與取消結案，沒有紀錄最近修改者、最近修改日期的問題
#160804-00080#1   2016/08/10   By 07024   修正料號的產品特徵設維二維輸入，新增資料時，沒有顯現的問題
#160816-00068#14  2016/08/17   By 08209   調整transaction
#160818-00017#32  2016/08/30   By 08742   删除修改未重新判断状态码
#161017-00051#5   2016/10/20   By 06189   aimi092里没有勾选单据录入产品特征值自动开窗，不能自动开特征值窗
#161109-00085#16  2016/11/15   By 08993   整批調整系統星號寫法
#161109-00085#61  2016/11/29   By 08171   整批調整系統星號寫法
#161216-00017#1   2016/12/22   By Jessica 配合BPM整合
#                                         1.狀態為D.抽單時，按修改後儲存，狀態應變更為N.未確認 
#                                         2.狀態為R.已拒絕時，按修改後儲存，狀態應變更為N.未確認 
#                                         3.確認段需拆解至SUB，如附件開發規範: 四、開發整合自動確認功能
#161226-00069#1   2016/01/10   By 08992   新增psab002產品特徵檢查
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
PRIVATE type type_g_psaa_m        RECORD
       psaadocno LIKE psaa_t.psaadocno, 
   psaadocno_desc LIKE type_t.chr80, 
   psaadocdt LIKE psaa_t.psaadocdt, 
   psaasite LIKE psaa_t.psaasite, 
   psaa001 LIKE psaa_t.psaa001, 
   psaa001_desc LIKE type_t.chr80, 
   psaa002 LIKE psaa_t.psaa002, 
   psaa002_desc LIKE type_t.chr80, 
   psaa003 LIKE psaa_t.psaa003, 
   psaastus LIKE psaa_t.psaastus, 
   psaaownid LIKE psaa_t.psaaownid, 
   psaaownid_desc LIKE type_t.chr80, 
   psaaowndp LIKE psaa_t.psaaowndp, 
   psaaowndp_desc LIKE type_t.chr80, 
   psaacrtid LIKE psaa_t.psaacrtid, 
   psaacrtid_desc LIKE type_t.chr80, 
   psaacrtdp LIKE psaa_t.psaacrtdp, 
   psaacrtdp_desc LIKE type_t.chr80, 
   psaacrtdt LIKE psaa_t.psaacrtdt, 
   psaamodid LIKE psaa_t.psaamodid, 
   psaamodid_desc LIKE type_t.chr80, 
   psaamoddt LIKE psaa_t.psaamoddt, 
   psaacnfid LIKE psaa_t.psaacnfid, 
   psaacnfid_desc LIKE type_t.chr80, 
   psaacnfdt LIKE psaa_t.psaacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_psab_d        RECORD
       psabseq LIKE psab_t.psabseq, 
   psab001 LIKE psab_t.psab001, 
   psab012 LIKE psab_t.psab012, 
   psab001_desc LIKE type_t.chr500, 
   psab001_desc_desc LIKE type_t.chr500, 
   psab002 LIKE psab_t.psab002, 
   psab002_desc LIKE type_t.chr500, 
   psab003 LIKE psab_t.psab003, 
   psab004 LIKE psab_t.psab004, 
   psab005 LIKE psab_t.psab005, 
   psab006 LIKE psab_t.psab006, 
   net LIKE type_t.num20_6, 
   psab010 LIKE psab_t.psab010, 
   psab010_desc LIKE type_t.chr500, 
   psab011 LIKE psab_t.psab011, 
   psab011_desc LIKE type_t.chr500, 
   psab007 LIKE psab_t.psab007, 
   psab008 LIKE psab_t.psab008, 
   psab009 LIKE psab_t.psab009, 
   psabsite LIKE psab_t.psabsite, 
   psab013 LIKE psab_t.psab013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_psaadocno LIKE psaa_t.psaadocno,
   b_psaadocno_desc LIKE type_t.chr80,
      b_psaadocdt LIKE psaa_t.psaadocdt,
      b_psaa001 LIKE psaa_t.psaa001,
   b_psaa001_desc LIKE type_t.chr80,
      b_psaa002 LIKE psaa_t.psaa002,
   b_psaa002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#mod--161109-00085#16 By 08993--(s)
#DEFINE g_ooef        RECORD LIKE ooef_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE g_ooef        RECORD  #組織基本資料檔
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
       ooef116 LIKE ooef_t.ooef116  #語言別
          END RECORD
#mod--161109-00085#16 By 08993--(e)
DEFINE g_qty         LIKE type_t.chr1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_psaa_m          type_g_psaa_m
DEFINE g_psaa_m_t        type_g_psaa_m
DEFINE g_psaa_m_o        type_g_psaa_m
DEFINE g_psaa_m_mask_o   type_g_psaa_m #轉換遮罩前資料
DEFINE g_psaa_m_mask_n   type_g_psaa_m #轉換遮罩後資料
 
   DEFINE g_psaadocno_t LIKE psaa_t.psaadocno
 
 
DEFINE g_psab_d          DYNAMIC ARRAY OF type_g_psab_d
DEFINE g_psab_d_t        type_g_psab_d
DEFINE g_psab_d_o        type_g_psab_d
DEFINE g_psab_d_mask_o   DYNAMIC ARRAY OF type_g_psab_d #轉換遮罩前資料
DEFINE g_psab_d_mask_n   DYNAMIC ARRAY OF type_g_psab_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="apst300.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:作業初始化 name="main.init"
                     
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                  #mod--161109-00085#16 By 08993--(s)
#                  SELECT * INTO g_ooef.* FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #mark--161109-00085#16 By 08993--(s)
                  SELECT ooefent,ooefstus,ooef001,ooef002,ooef004,ooef005,ooef006,ooef007,ooef008,ooef009,ooef010,ooef011,
                         ooef012,ooef013,ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,ooefmodid,ooefmoddt,ooef014,
                         ooef015,ooef016,ooef017,ooef018,ooef019,ooef020,ooef021,ooef022,ooef003,ooef023,ooef024,ooef025,
                         ooef026,ooef100,ooef101,ooef102,ooef103,ooef104,ooef105,ooef106,ooef107,ooef108,ooef109,ooef110,
                         ooef111,ooef112,ooef113,ooef114,ooef115,ooef120,ooef121,ooef122,ooef123,ooef124,ooef125,ooef150,
                         ooef151,ooef152,ooef153,ooef154,ooef155,ooef156,ooef157,ooef158,ooef159,ooef160,ooef161,ooef162,
                         ooef163,ooef164,ooef165,ooef166,ooef167,ooef168,ooef169,ooef170,ooef171,ooef172,ooef173,ooefunit,
                         ooef200,ooef201,ooef202,ooef203,ooef204,ooef205,ooef206,ooef207,ooef208,ooef209,ooef210,ooef211,
                         ooef212,ooef213,ooef214,ooef215,ooef216,ooef217,ooef301,ooef302,ooef303,ooef304,ooef305,ooef306,
                         ooef307,ooef308,ooef309,ooef310,ooef126,ooef127,ooef128,ooef116 
                     INTO g_ooef.ooefent,g_ooef.ooefstus,g_ooef.ooef001,g_ooef.ooef002,g_ooef.ooef004,g_ooef.ooef005,
                          g_ooef.ooef006,g_ooef.ooef007,g_ooef.ooef008,g_ooef.ooef009,g_ooef.ooef010,g_ooef.ooef011,
                          g_ooef.ooef012,g_ooef.ooef013,g_ooef.ooefownid,g_ooef.ooefowndp,g_ooef.ooefcrtid,g_ooef.ooefcrtdp,
                          g_ooef.ooefcrtdt,g_ooef.ooefmodid,g_ooef.ooefmoddt,g_ooef.ooef014,g_ooef.ooef015,g_ooef.ooef016,
                          g_ooef.ooef017,g_ooef.ooef018,g_ooef.ooef019,g_ooef.ooef020,g_ooef.ooef021,g_ooef.ooef022,
                          g_ooef.ooef003,g_ooef.ooef023,g_ooef.ooef024,g_ooef.ooef025,g_ooef.ooef026,g_ooef.ooef100,
                          g_ooef.ooef101,g_ooef.ooef102,g_ooef.ooef103,g_ooef.ooef104,g_ooef.ooef105,g_ooef.ooef106,
                          g_ooef.ooef107,g_ooef.ooef108,g_ooef.ooef109,g_ooef.ooef110,g_ooef.ooef111,g_ooef.ooef112,
                          g_ooef.ooef113,g_ooef.ooef114,g_ooef.ooef115,g_ooef.ooef120,g_ooef.ooef121,g_ooef.ooef122,
                          g_ooef.ooef123,g_ooef.ooef124,g_ooef.ooef125,g_ooef.ooef150,g_ooef.ooef151,g_ooef.ooef152,
                          g_ooef.ooef153,g_ooef.ooef154,g_ooef.ooef155,g_ooef.ooef156,g_ooef.ooef157,g_ooef.ooef158,
                          g_ooef.ooef159,g_ooef.ooef160,g_ooef.ooef161,g_ooef.ooef162,g_ooef.ooef163,g_ooef.ooef164,
                          g_ooef.ooef165,g_ooef.ooef166,g_ooef.ooef167,g_ooef.ooef168,g_ooef.ooef169,g_ooef.ooef170,
                          g_ooef.ooef171,g_ooef.ooef172,g_ooef.ooef173,g_ooef.ooefunit,g_ooef.ooef200,g_ooef.ooef201,
                          g_ooef.ooef202,g_ooef.ooef203,g_ooef.ooef204,g_ooef.ooef205,g_ooef.ooef206,g_ooef.ooef207,
                          g_ooef.ooef208,g_ooef.ooef209,g_ooef.ooef210,g_ooef.ooef211,g_ooef.ooef212,g_ooef.ooef213,
                          g_ooef.ooef214,g_ooef.ooef215,g_ooef.ooef216,g_ooef.ooef217,g_ooef.ooef301,g_ooef.ooef302,
                          g_ooef.ooef303,g_ooef.ooef304,g_ooef.ooef305,g_ooef.ooef306,g_ooef.ooef307,g_ooef.ooef308,
                          g_ooef.ooef309,g_ooef.ooef310,g_ooef.ooef126,g_ooef.ooef127,g_ooef.ooef128,g_ooef.ooef116 
                     FROM ooef_t 
                     WHERE ooefent = g_enterprise AND ooef001 = g_site
                  #mod--161109-00085#16 By 08993--(e)
   #end add-point
   LET g_forupd_sql = " SELECT psaadocno,'',psaadocdt,psaasite,psaa001,'',psaa002,'',psaa003,psaastus, 
       psaaownid,'',psaaowndp,'',psaacrtid,'',psaacrtdp,'',psaacrtdt,psaamodid,'',psaamoddt,psaacnfid, 
       '',psaacnfdt", 
                      " FROM psaa_t",
                      " WHERE psaaent= ? AND psaadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                     
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apst300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.psaadocno,t0.psaadocdt,t0.psaasite,t0.psaa001,t0.psaa002,t0.psaa003, 
       t0.psaastus,t0.psaaownid,t0.psaaowndp,t0.psaacrtid,t0.psaacrtdp,t0.psaacrtdt,t0.psaamodid,t0.psaamoddt, 
       t0.psaacnfid,t0.psaacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooag011",
               " FROM psaa_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.psaa001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.psaa002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.psaaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.psaaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.psaacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.psaacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.psaamodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.psaacnfid  ",
 
               " WHERE t0.psaaent = " ||g_enterprise|| " AND t0.psaadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apst300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                          
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apst300 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apst300_init()   
 
      #進入選單 Menu (="N")
      CALL apst300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                          
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apst300
      
   END IF 
   
   CLOSE apst300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
                     
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apst300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apst300_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('psaastus','13','N,Y,C,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("psab002,psab002_desc",FALSE)
   END IF  
   #end add-point
   
   #初始化搜尋條件
   CALL apst300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apst300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apst300_ui_dialog()
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
            CALL apst300_insert()
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
         INITIALIZE g_psaa_m.* TO NULL
         CALL g_psab_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apst300_init()
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
               
               CALL apst300_fetch('') # reload data
               LET l_ac = 1
               CALL apst300_ui_detailshow() #Setting the current row 
         
               CALL apst300_idx_chk()
               #NEXT FIELD psabseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_psab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apst300_idx_chk()
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
               CALL apst300_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                                                                                         
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                                                    
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                                               
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apst300_browser_fill("")
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
               CALL apst300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apst300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apst300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                                                                    
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apst300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apst300_set_act_visible()   
            CALL apst300_set_act_no_visible()
            IF NOT (g_psaa_m.psaadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " psaaent = " ||g_enterprise|| " AND",
                                  " psaadocno = '", g_psaa_m.psaadocno, "' "
 
               #填到對應位置
               CALL apst300_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "psaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "psab_t" 
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
               CALL apst300_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "psaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "psab_t" 
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
                  CALL apst300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apst300_fetch("F")
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
               CALL apst300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apst300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apst300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apst300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apst300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apst300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apst300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apst300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apst300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apst300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apst300_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_psab_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD psabseq
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
               CALL apst300_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                         
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apst300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                         
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION single_closed
            LET g_action_choice="single_closed"
            IF cl_auth_chk_act("single_closed") THEN
               
               #add-point:ON ACTION single_closed name="menu.single_closed"
               CALL apst300_single_closed()
               CALL apst300_fetch('')  #dorislai-20151012-add
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apst300_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                         
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apst300_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                         
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "psaaent ="|| g_enterprise ||"  AND psaadocno ='"|| g_psaa_m.psaadocno||"'"
               #END add-point
               &include "erp/aps/apst300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "psaaent ="|| g_enterprise ||"  AND psaadocno ='"|| g_psaa_m.psaadocno||"'"
               #END add-point
               &include "erp/aps/apst300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apst300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                                                                         
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apst300_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                         
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION single_unclosed
            LET g_action_choice="single_unclosed"
            IF cl_auth_chk_act("single_unclosed") THEN
               
               #add-point:ON ACTION single_unclosed name="menu.single_unclosed"
               CALL apst300_single_unclosed()
               CALL apst300_fetch('')  #dorislai-20151012-add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION con_qty
            LET g_action_choice="con_qty"
            IF cl_auth_chk_act("con_qty") THEN
               
               #add-point:ON ACTION con_qty name="menu.con_qty"
               LET g_qty = '1'
               CALL apst300_modify()
               LET g_qty = '0'
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_psaa001
            LET g_action_choice="prog_psaa001"
            IF cl_auth_chk_act("prog_psaa001") THEN
               
               #add-point:ON ACTION prog_psaa001 name="menu.prog_psaa001"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_psaa_m.psaa001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_button
            LET g_action_choice="prog_button"
            IF cl_auth_chk_act("prog_button") THEN
               
               #add-point:ON ACTION prog_button name="menu.prog_button"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_psaa_m.psaa001)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apst300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apst300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apst300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_psaa_m.psaadocdt)
 
 
 
         
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
 
{<section id="apst300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apst300_browser_fill(ps_page_action)
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
      LET g_wc = " psaasite = '",g_site,"' " 
   ELSE
      LET g_wc = g_wc," AND psaasite = '",g_site,"' "
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT psaadocno ",
                      " FROM psaa_t ",
                      " ",
                      " LEFT JOIN psab_t ON psabent = psaaent AND psaadocno = psabdocno ", "  ",
                      #add-point:browser_fill段sql(psab_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE psaaent = " ||g_enterprise|| " AND psabent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("psaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT psaadocno ",
                      " FROM psaa_t ", 
                      "  ",
                      "  ",
                      " WHERE psaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("psaa_t")
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
      INITIALIZE g_psaa_m.* TO NULL
      CALL g_psab_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.psaadocno,t0.psaadocdt,t0.psaa001,t0.psaa002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.psaastus,t0.psaadocno,t0.psaadocdt,t0.psaa001,t0.psaa002,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM psaa_t t0",
                  "  ",
                  "  LEFT JOIN psab_t ON psabent = psaaent AND psaadocno = psabdocno ", "  ", 
                  #add-point:browser_fill段sql(psab_t1) name="browser_fill.join.psab_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.psaa001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.psaa002 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.psaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("psaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.psaastus,t0.psaadocno,t0.psaadocdt,t0.psaa001,t0.psaa002,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM psaa_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.psaa001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.psaa002 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.psaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("psaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY psaadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
                     
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"psaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
                     
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_psaadocno,g_browser[g_cnt].b_psaadocdt, 
          g_browser[g_cnt].b_psaa001,g_browser[g_cnt].b_psaa002,g_browser[g_cnt].b_psaa001_desc,g_browser[g_cnt].b_psaa002_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
                              CALL s_aooi200_get_slip_desc(g_browser[g_cnt].b_psaadocno) RETURNING g_browser[g_cnt].b_psaadocno_desc
      DISPLAY BY NAME g_browser[g_cnt].b_psaadocno_desc
         #end add-point
      
         #遮罩相關處理
         CALL apst300_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_psaadocno) THEN
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
 
{<section id="apst300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apst300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                     
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_psaa_m.psaadocno = g_browser[g_current_idx].b_psaadocno   
 
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
   CALL apst300_psaa_t_mask()
   CALL apst300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apst300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apst300_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
                     
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
                     
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
                     
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apst300_ui_browser_refresh()
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
      IF g_browser[l_i].b_psaadocno = g_psaa_m.psaadocno 
 
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
 
{<section id="apst300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apst300_construct()
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
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_psaa_m.* TO NULL
   CALL g_psab_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON psaadocno,psaadocno_desc,psaadocdt,psaasite,psaa001,psaa002,psaa003, 
          psaastus,psaaownid,psaaowndp,psaacrtid,psaacrtdp,psaacrtdt,psaamodid,psaamoddt,psaacnfid,psaacnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                                                    
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<psaacrtdt>>----
         AFTER FIELD psaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<psaamoddt>>----
         AFTER FIELD psaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<psaacnfdt>>----
         AFTER FIELD psaacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<psaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.psaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaadocno
            #add-point:ON ACTION controlp INFIELD psaadocno name="construct.c.psaadocno"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_psaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaadocno  #顯示到畫面上

            NEXT FIELD psaadocno                     #返回原欄位                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaadocno
            #add-point:BEFORE FIELD psaadocno name="construct.b.psaadocno"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaadocno
            
            #add-point:AFTER FIELD psaadocno name="construct.a.psaadocno"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaadocno_desc
            #add-point:BEFORE FIELD psaadocno_desc name="construct.b.psaadocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaadocno_desc
            
            #add-point:AFTER FIELD psaadocno_desc name="construct.a.psaadocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaadocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaadocno_desc
            #add-point:ON ACTION controlp INFIELD psaadocno_desc name="construct.c.psaadocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaadocdt
            #add-point:BEFORE FIELD psaadocdt name="construct.b.psaadocdt"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaadocdt
            
            #add-point:AFTER FIELD psaadocdt name="construct.a.psaadocdt"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaadocdt
            #add-point:ON ACTION controlp INFIELD psaadocdt name="construct.c.psaadocdt"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaasite
            #add-point:BEFORE FIELD psaasite name="construct.b.psaasite"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaasite
            
            #add-point:AFTER FIELD psaasite name="construct.a.psaasite"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaasite
            #add-point:ON ACTION controlp INFIELD psaasite name="construct.c.psaasite"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.psaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa001
            #add-point:ON ACTION controlp INFIELD psaa001 name="construct.c.psaa001"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaa001  #顯示到畫面上

            NEXT FIELD psaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa001
            #add-point:BEFORE FIELD psaa001 name="construct.b.psaa001"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa001
            
            #add-point:AFTER FIELD psaa001 name="construct.a.psaa001"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa002
            #add-point:ON ACTION controlp INFIELD psaa002 name="construct.c.psaa002"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaa002  #顯示到畫面上

            NEXT FIELD psaa002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa002
            #add-point:BEFORE FIELD psaa002 name="construct.b.psaa002"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa002
            
            #add-point:AFTER FIELD psaa002 name="construct.a.psaa002"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa003
            #add-point:BEFORE FIELD psaa003 name="construct.b.psaa003"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa003
            
            #add-point:AFTER FIELD psaa003 name="construct.a.psaa003"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa003
            #add-point:ON ACTION controlp INFIELD psaa003 name="construct.c.psaa003"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaastus
            #add-point:BEFORE FIELD psaastus name="construct.b.psaastus"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaastus
            
            #add-point:AFTER FIELD psaastus name="construct.a.psaastus"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaastus
            #add-point:ON ACTION controlp INFIELD psaastus name="construct.c.psaastus"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.psaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaaownid
            #add-point:ON ACTION controlp INFIELD psaaownid name="construct.c.psaaownid"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaaownid  #顯示到畫面上

            NEXT FIELD psaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaaownid
            #add-point:BEFORE FIELD psaaownid name="construct.b.psaaownid"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaaownid
            
            #add-point:AFTER FIELD psaaownid name="construct.a.psaaownid"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaaowndp
            #add-point:ON ACTION controlp INFIELD psaaowndp name="construct.c.psaaowndp"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaaowndp  #顯示到畫面上

            NEXT FIELD psaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaaowndp
            #add-point:BEFORE FIELD psaaowndp name="construct.b.psaaowndp"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaaowndp
            
            #add-point:AFTER FIELD psaaowndp name="construct.a.psaaowndp"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaacrtid
            #add-point:ON ACTION controlp INFIELD psaacrtid name="construct.c.psaacrtid"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaacrtid  #顯示到畫面上

            NEXT FIELD psaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaacrtid
            #add-point:BEFORE FIELD psaacrtid name="construct.b.psaacrtid"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaacrtid
            
            #add-point:AFTER FIELD psaacrtid name="construct.a.psaacrtid"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.psaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaacrtdp
            #add-point:ON ACTION controlp INFIELD psaacrtdp name="construct.c.psaacrtdp"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaacrtdp  #顯示到畫面上

            NEXT FIELD psaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaacrtdp
            #add-point:BEFORE FIELD psaacrtdp name="construct.b.psaacrtdp"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaacrtdp
            
            #add-point:AFTER FIELD psaacrtdp name="construct.a.psaacrtdp"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaacrtdt
            #add-point:BEFORE FIELD psaacrtdt name="construct.b.psaacrtdt"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.psaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaamodid
            #add-point:ON ACTION controlp INFIELD psaamodid name="construct.c.psaamodid"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaamodid  #顯示到畫面上

            NEXT FIELD psaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaamodid
            #add-point:BEFORE FIELD psaamodid name="construct.b.psaamodid"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaamodid
            
            #add-point:AFTER FIELD psaamodid name="construct.a.psaamodid"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaamoddt
            #add-point:BEFORE FIELD psaamoddt name="construct.b.psaamoddt"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.psaacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaacnfid
            #add-point:ON ACTION controlp INFIELD psaacnfid name="construct.c.psaacnfid"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psaacnfid  #顯示到畫面上

            NEXT FIELD psaacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaacnfid
            #add-point:BEFORE FIELD psaacnfid name="construct.b.psaacnfid"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaacnfid
            
            #add-point:AFTER FIELD psaacnfid name="construct.a.psaacnfid"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaacnfdt
            #add-point:BEFORE FIELD psaacnfdt name="construct.b.psaacnfdt"
                                                                                    
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON psabseq,psab001,psab012,psab002,psab003,psab004,psab005,psab006,psab010, 
          psab011,psab008,psab009,psabsite,psab013
           FROM s_detail1[1].psabseq,s_detail1[1].psab001,s_detail1[1].psab012,s_detail1[1].psab002, 
               s_detail1[1].psab003,s_detail1[1].psab004,s_detail1[1].psab005,s_detail1[1].psab006,s_detail1[1].psab010, 
               s_detail1[1].psab011,s_detail1[1].psab008,s_detail1[1].psab009,s_detail1[1].psabsite, 
               s_detail1[1].psab013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psabseq
            #add-point:BEFORE FIELD psabseq name="construct.b.page1.psabseq"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psabseq
            
            #add-point:AFTER FIELD psabseq name="construct.a.page1.psabseq"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psabseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psabseq
            #add-point:ON ACTION controlp INFIELD psabseq name="construct.c.page1.psabseq"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.psab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab001
            #add-point:ON ACTION controlp INFIELD psab001 name="construct.c.page1.psab001"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_psaa_m.psaasite 
            CALL q_imaf001_7()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO psab001  #顯示到畫面上

            NEXT FIELD psab001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab001
            #add-point:BEFORE FIELD psab001 name="construct.b.page1.psab001"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab001
            
            #add-point:AFTER FIELD psab001 name="construct.a.page1.psab001"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab012
            #add-point:BEFORE FIELD psab012 name="construct.b.page1.psab012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab012
            
            #add-point:AFTER FIELD psab012 name="construct.a.page1.psab012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab012
            #add-point:ON ACTION controlp INFIELD psab012 name="construct.c.page1.psab012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.psab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab002
            #add-point:ON ACTION controlp INFIELD psab002 name="construct.c.page1.psab002"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab002
            #add-point:BEFORE FIELD psab002 name="construct.b.page1.psab002"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab002
            
            #add-point:AFTER FIELD psab002 name="construct.a.page1.psab002"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab003
            #add-point:BEFORE FIELD psab003 name="construct.b.page1.psab003"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab003
            
            #add-point:AFTER FIELD psab003 name="construct.a.page1.psab003"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab003
            #add-point:ON ACTION controlp INFIELD psab003 name="construct.c.page1.psab003"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.psab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab004
            #add-point:ON ACTION controlp INFIELD psab004 name="construct.c.page1.psab004"
                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psab004  #顯示到畫面上

            NEXT FIELD psab004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab004
            #add-point:BEFORE FIELD psab004 name="construct.b.page1.psab004"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab004
            
            #add-point:AFTER FIELD psab004 name="construct.a.page1.psab004"
                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab005
            #add-point:BEFORE FIELD psab005 name="construct.b.page1.psab005"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab005
            
            #add-point:AFTER FIELD psab005 name="construct.a.page1.psab005"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab005
            #add-point:ON ACTION controlp INFIELD psab005 name="construct.c.page1.psab005"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab006
            #add-point:BEFORE FIELD psab006 name="construct.b.page1.psab006"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab006
            
            #add-point:AFTER FIELD psab006 name="construct.a.page1.psab006"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab006
            #add-point:ON ACTION controlp INFIELD psab006 name="construct.c.page1.psab006"
                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.psab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab010
            #add-point:ON ACTION controlp INFIELD psab010 name="construct.c.page1.psab010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psab010  #顯示到畫面上
            NEXT FIELD psab010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab010
            #add-point:BEFORE FIELD psab010 name="construct.b.page1.psab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab010
            
            #add-point:AFTER FIELD psab010 name="construct.a.page1.psab010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab011
            #add-point:ON ACTION controlp INFIELD psab011 name="construct.c.page1.psab011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psab011  #顯示到畫面上
            NEXT FIELD psab011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab011
            #add-point:BEFORE FIELD psab011 name="construct.b.page1.psab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab011
            
            #add-point:AFTER FIELD psab011 name="construct.a.page1.psab011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab008
            #add-point:BEFORE FIELD psab008 name="construct.b.page1.psab008"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab008
            
            #add-point:AFTER FIELD psab008 name="construct.a.page1.psab008"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab008
            #add-point:ON ACTION controlp INFIELD psab008 name="construct.c.page1.psab008"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab009
            #add-point:BEFORE FIELD psab009 name="construct.b.page1.psab009"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab009
            
            #add-point:AFTER FIELD psab009 name="construct.a.page1.psab009"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab009
            #add-point:ON ACTION controlp INFIELD psab009 name="construct.c.page1.psab009"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psabsite
            #add-point:BEFORE FIELD psabsite name="construct.b.page1.psabsite"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psabsite
            
            #add-point:AFTER FIELD psabsite name="construct.a.page1.psabsite"
                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psabsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psabsite
            #add-point:ON ACTION controlp INFIELD psabsite name="construct.c.page1.psabsite"
                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab013
            #add-point:BEFORE FIELD psab013 name="construct.b.page1.psab013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab013
            
            #add-point:AFTER FIELD psab013 name="construct.a.page1.psab013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.psab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab013
            #add-point:ON ACTION controlp INFIELD psab013 name="construct.c.page1.psab013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
                                          
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #dorislai-20151013-add----(S)
         #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_psab_d[1].psabseq = ""
         DISPLAY ARRAY g_psab_d TO s_detail1.* 
            BEFORE DISPLAY
               EXIT DISPLAY    
         END DISPLAY
         #dorislai-20151013-add----(E)                                      
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
                  WHEN la_wc[li_idx].tableid = "psaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "psab_t" 
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
                     
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apst300_filter()
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
      CONSTRUCT g_wc_filter ON psaadocno,psaadocdt,psaa001,psaa002
                          FROM s_browse[1].b_psaadocno,s_browse[1].b_psaadocdt,s_browse[1].b_psaa001, 
                              s_browse[1].b_psaa002
 
         BEFORE CONSTRUCT
               DISPLAY apst300_filter_parser('psaadocno') TO s_browse[1].b_psaadocno
            DISPLAY apst300_filter_parser('psaadocdt') TO s_browse[1].b_psaadocdt
            DISPLAY apst300_filter_parser('psaa001') TO s_browse[1].b_psaa001
            DISPLAY apst300_filter_parser('psaa002') TO s_browse[1].b_psaa002
      
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
 
      CALL apst300_filter_show('psaadocno')
   CALL apst300_filter_show('psaadocdt')
   CALL apst300_filter_show('psaa001')
   CALL apst300_filter_show('psaa002')
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apst300_filter_parser(ps_field)
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
 
{<section id="apst300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apst300_filter_show(ps_field)
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
   LET ls_condition = apst300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apst300_query()
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
   CALL g_psab_d.clear()
 
   
   #add-point:query段other name="query.other"
                     
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apst300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apst300_browser_fill("")
      CALL apst300_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL apst300_filter_show('psaadocno')
   CALL apst300_filter_show('psaadocdt')
   CALL apst300_filter_show('psaa001')
   CALL apst300_filter_show('psaa002')
   CALL apst300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apst300_fetch("F") 
      #顯示單身筆數
      CALL apst300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apst300_fetch(p_flag)
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
   
   LET g_psaa_m.psaadocno = g_browser[g_current_idx].b_psaadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
   #遮罩相關處理
   LET g_psaa_m_mask_o.* =  g_psaa_m.*
   CALL apst300_psaa_t_mask()
   LET g_psaa_m_mask_n.* =  g_psaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apst300_set_act_visible()   
   CALL apst300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,modify_detail,delete,con_qty,single_closed,single_unclosed",TRUE)
   CASE g_psaa_m.psaastus 
      WHEN 'Y'  
         CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
      WHEN 'C' 
         CALL cl_set_act_visible("modify,modify_detail,delete,con_qty",FALSE)
      WHEN 'N'  
         CALL cl_set_act_visible("con_qty,single_closed,single_unclosed",FALSE)
      WHEN 'X'  
         CALL cl_set_act_visible("modify,modify_detail,delete,con_qty,single_closed,single_unclosed",FALSE)
   END CASE  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
                     
   #end add-point
   
   #保存單頭舊值
   LET g_psaa_m_t.* = g_psaa_m.*
   LET g_psaa_m_o.* = g_psaa_m.*
   
   LET g_data_owner = g_psaa_m.psaaownid      
   LET g_data_dept  = g_psaa_m.psaaowndp
   
   #重新顯示   
   CALL apst300_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.insert" >}
#+ 資料新增
PRIVATE FUNCTION apst300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
                     
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_psab_d.clear()   
 
 
   INITIALIZE g_psaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_psaadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_psaa_m.psaaownid = g_user
      LET g_psaa_m.psaaowndp = g_dept
      LET g_psaa_m.psaacrtid = g_user
      LET g_psaa_m.psaacrtdp = g_dept 
      LET g_psaa_m.psaacrtdt = cl_get_current()
      LET g_psaa_m.psaamodid = g_user
      LET g_psaa_m.psaamoddt = cl_get_current()
      LET g_psaa_m.psaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
                                    LET g_psaa_m.psaadocdt = cl_get_current()
      LET g_psaa_m.psaastus = "N"      
      LET g_psaa_m.psaa001 = g_user
      LET g_psaa_m.psaa002 = g_dept
      LET g_psaa_m.psaasite = g_site
      CALL apst300_psaa001_desc()
      CALL apst300_psaa002_desc()
      LET g_psaa_m_t.* = g_psaa_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_psaa_m_t.* = g_psaa_m.*
      LET g_psaa_m_o.* = g_psaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_psaa_m.psaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
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
 
 
 
    
      CALL apst300_input("a")
      
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
         INITIALIZE g_psaa_m.* TO NULL
         INITIALIZE g_psab_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apst300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_psab_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apst300_set_act_visible()   
   CALL apst300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_psaadocno_t = g_psaa_m.psaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " psaaent = " ||g_enterprise|| " AND",
                      " psaadocno = '", g_psaa_m.psaadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apst300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apst300_cl
   
   CALL apst300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
   
   #遮罩相關處理
   LET g_psaa_m_mask_o.* =  g_psaa_m.*
   CALL apst300_psaa_t_mask()
   LET g_psaa_m_mask_n.* =  g_psaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocno_desc,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001, 
       g_psaa_m.psaa001_desc,g_psaa_m.psaa002,g_psaa_m.psaa002_desc,g_psaa_m.psaa003,g_psaa_m.psaastus, 
       g_psaa_m.psaaownid,g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid, 
       g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdp_desc,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfid_desc,g_psaa_m.psaacnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_psaa_m.psaaownid      
   LET g_data_dept  = g_psaa_m.psaaowndp
   
   #功能已完成,通報訊息中心
   CALL apst300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.modify" >}
#+ 資料修改
PRIVATE FUNCTION apst300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
                     
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_psaa_m_t.* = g_psaa_m.*
   LET g_psaa_m_o.* = g_psaa_m.*
   
   IF g_psaa_m.psaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_psaadocno_t = g_psaa_m.psaadocno
 
   CALL s_transaction_begin()
   
   OPEN apst300_cl USING g_enterprise,g_psaa_m.psaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apst300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
   #檢查是否允許此動作
   IF NOT apst300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_psaa_m_mask_o.* =  g_psaa_m.*
   CALL apst300_psaa_t_mask()
   LET g_psaa_m_mask_n.* =  g_psaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apst300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_psaadocno_t = g_psaa_m.psaadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_psaa_m.psaamodid = g_user 
LET g_psaa_m.psaamoddt = cl_get_current()
LET g_psaa_m.psaamodid_desc = cl_get_username(g_psaa_m.psaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #161216-00017#1-S
      IF g_psaa_m.psaastus MATCHES '[DR]' THEN 
         LET g_psaa_m.psaastus = "N"
      END IF
      #161216-00017#1-E      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apst300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                                          
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE psaa_t SET (psaamodid,psaamoddt) = (g_psaa_m.psaamodid,g_psaa_m.psaamoddt)
          WHERE psaaent = g_enterprise AND psaadocno = g_psaadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_psaa_m.* = g_psaa_m_t.*
            CALL apst300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_psaa_m.psaadocno != g_psaa_m_t.psaadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                                               
         #end add-point
         
         #更新單身key值
         UPDATE psab_t SET psabdocno = g_psaa_m.psaadocno
 
          WHERE psabent = g_enterprise AND psabdocno = g_psaa_m_t.psaadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                                               
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "psab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
                                                               
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apst300_set_act_visible()   
   CALL apst300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " psaaent = " ||g_enterprise|| " AND",
                      " psaadocno = '", g_psaa_m.psaadocno, "' "
 
   #填到對應位置
   CALL apst300_browser_fill("")
 
   CLOSE apst300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apst300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apst300.input" >}
#+ 資料輸入
PRIVATE FUNCTION apst300_input(p_cmd)
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
   DEFINE l_psab002_t            LIKE psab_t.psab002 
   DEFINE l_success              LIKE type_t.num5   
   #160804-00080#1-add-(S)
   DEFINE l_imaa005              LIKE imaa_t.imaa005  
   DEFINE  l_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001 LIKE inam_t.inam001,
           inam002 LIKE inam_t.inam002,
           inam004 LIKE inam_t.inam004
                        END RECORD
   #mod--161109-00085#16 By 08993--(s)                     
#   DEFINE l_psab           RECORD LIKE psab_t.*     #紀錄多維的產品特徵   #mark--161109-00085#16 By 08993--(s)
   DEFINE l_psab           RECORD  #獨立需求單身檔
       psabent LIKE psab_t.psabent, #企業編號
       psabsite LIKE psab_t.psabsite, #營運據點
       psabdocno LIKE psab_t.psabdocno, #需求單號
       psabseq LIKE psab_t.psabseq, #項次
       psab001 LIKE psab_t.psab001, #料件編號
       psab002 LIKE psab_t.psab002, #產品特徵
       psab003 LIKE psab_t.psab003, #需求日期
       psab004 LIKE psab_t.psab004, #單位
       psab005 LIKE psab_t.psab005, #需求數量
       psab006 LIKE psab_t.psab006, #已耗需求
       psab007 LIKE psab_t.psab007, #備註
       psab008 LIKE psab_t.psab008, #結案
       psab009 LIKE psab_t.psab009, #MRP凍結
       #161109-00085#61 --s add
       psabud001 LIKE psab_t.psabud001, #自定義欄位(文字)001
       psabud002 LIKE psab_t.psabud002, #自定義欄位(文字)002
       psabud003 LIKE psab_t.psabud003, #自定義欄位(文字)003
       psabud004 LIKE psab_t.psabud004, #自定義欄位(文字)004
       psabud005 LIKE psab_t.psabud005, #自定義欄位(文字)005
       psabud006 LIKE psab_t.psabud006, #自定義欄位(文字)006
       psabud007 LIKE psab_t.psabud007, #自定義欄位(文字)007
       psabud008 LIKE psab_t.psabud008, #自定義欄位(文字)008
       psabud009 LIKE psab_t.psabud009, #自定義欄位(文字)009
       psabud010 LIKE psab_t.psabud010, #自定義欄位(文字)010
       psabud011 LIKE psab_t.psabud011, #自定義欄位(數字)011
       psabud012 LIKE psab_t.psabud012, #自定義欄位(數字)012
       psabud013 LIKE psab_t.psabud013, #自定義欄位(數字)013
       psabud014 LIKE psab_t.psabud014, #自定義欄位(數字)014
       psabud015 LIKE psab_t.psabud015, #自定義欄位(數字)015
       psabud016 LIKE psab_t.psabud016, #自定義欄位(數字)016
       psabud017 LIKE psab_t.psabud017, #自定義欄位(數字)017
       psabud018 LIKE psab_t.psabud018, #自定義欄位(數字)018
       psabud019 LIKE psab_t.psabud019, #自定義欄位(數字)019
       psabud020 LIKE psab_t.psabud020, #自定義欄位(數字)020
       psabud021 LIKE psab_t.psabud021, #自定義欄位(日期時間)021
       psabud022 LIKE psab_t.psabud022, #自定義欄位(日期時間)022
       psabud023 LIKE psab_t.psabud023, #自定義欄位(日期時間)023
       psabud024 LIKE psab_t.psabud024, #自定義欄位(日期時間)024
       psabud025 LIKE psab_t.psabud025, #自定義欄位(日期時間)025
       psabud026 LIKE psab_t.psabud026, #自定義欄位(日期時間)026
       psabud027 LIKE psab_t.psabud027, #自定義欄位(日期時間)027
       psabud028 LIKE psab_t.psabud028, #自定義欄位(日期時間)028
       psabud029 LIKE psab_t.psabud029, #自定義欄位(日期時間)029
       psabud030 LIKE psab_t.psabud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psab010 LIKE psab_t.psab010, #專案編號
       psab011 LIKE psab_t.psab011, #WBS編號
       psab012 LIKE psab_t.psab012, #BOM特性
       psab013 LIKE psab_t.psab013  #保稅否
          END RECORD
   #mod--161109-00085#16 By 08993--(e)
   
   DEFINE l_psabseq        LIKE psab_t.psabseq      #紀錄最大項次
   #160804-00080#1-add-(E)                     
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   #doirslai-20160324-add-(S)
   IF p_cmd = 'r' THEN
      CALL apst300_reproduce_show()
   END IF
   #doirslai-20160324-add-(E)
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocno_desc,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001, 
       g_psaa_m.psaa001_desc,g_psaa_m.psaa002,g_psaa_m.psaa002_desc,g_psaa_m.psaa003,g_psaa_m.psaastus, 
       g_psaa_m.psaaownid,g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid, 
       g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdp_desc,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfid_desc,g_psaa_m.psaacnfdt 
 
   
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
   LET g_forupd_sql = "SELECT psabseq,psab001,psab012,psab002,psab003,psab004,psab005,psab006,psab010, 
       psab011,psab007,psab008,psab009,psabsite,psab013 FROM psab_t WHERE psabent=? AND psabdocno=?  
       AND psabseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                     
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apst300_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
                     
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apst300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                     
   #end add-point
   CALL apst300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002, 
       g_psaa_m.psaa003,g_psaa_m.psaastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   IF g_qty = '1' THEN 
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE     
   END IF
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apst300.input.head" >}
      #單頭段
      INPUT BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002, 
          g_psaa_m.psaa003,g_psaa_m.psaastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apst300_cl USING g_enterprise,g_psaa_m.psaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apst300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apst300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apst300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                                                                                    
            #end add-point
            CALL apst300_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaadocno
            
            #add-point:AFTER FIELD psaadocno name="input.a.psaadocno"
                                                                                                
            CALL s_aooi200_get_slip_desc(g_psaa_m.psaadocno) RETURNING g_psaa_m.psaadocno_desc
            DISPLAY BY NAME g_psaa_m.psaadocno_desc            
            
            #此段落由子樣板a05產生
            IF NOT cl_null(g_psaa_m.psaadocno) THEN
               #IF NOT s_aooi200_chk_slip(g_psaa_m.psaasite,'',g_psaa_m.psaadocno,'apst300') THEN #160613-00038#1 mark
               IF NOT s_aooi200_chk_slip(g_psaa_m.psaasite,'',g_psaa_m.psaadocno,g_prog) THEN     #160613-00038#1 add
                  LET g_psaa_m.psaadocno = g_psaa_m_t.psaadocno
                  NEXT FIELD CURRENT
               END IF             
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_psaa_m.psaadocno != g_psaadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM psaa_t WHERE "||"psaaent = '" ||g_enterprise|| "' AND "||"psaadocno = '"||g_psaa_m.psaadocno ||"'",'std-00004',0) THEN 
                     LET g_psaa_m.psaadocno = g_psaa_m_t.psaadocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
               NEXT FIELD psaadocdt
            ELSE   
               NEXT FIELD CURRENT   
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaadocno
            #add-point:BEFORE FIELD psaadocno name="input.b.psaadocno"
                                                                                    CALL s_aooi200_get_slip_desc(g_psaa_m.psaadocno) RETURNING g_psaa_m.psaadocno_desc
            DISPLAY BY NAME g_psaa_m.psaadocno_desc             
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaadocno
            #add-point:ON CHANGE psaadocno name="input.g.psaadocno"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaadocdt
            #add-point:BEFORE FIELD psaadocdt name="input.b.psaadocdt"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaadocdt
            
            #add-point:AFTER FIELD psaadocdt name="input.a.psaadocdt"
                                                                                    IF cl_null(g_psaa_m.psaadocdt) THEN 
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaadocdt
            #add-point:ON CHANGE psaadocdt name="input.g.psaadocdt"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaasite
            #add-point:BEFORE FIELD psaasite name="input.b.psaasite"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaasite
            
            #add-point:AFTER FIELD psaasite name="input.a.psaasite"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaasite
            #add-point:ON CHANGE psaasite name="input.g.psaasite"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa001
            
            #add-point:AFTER FIELD psaa001 name="input.a.psaa001"
                                                                                    
            CALL apst300_psaa001_desc()
            IF NOT cl_null(g_psaa_m.psaa001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_psaa_m.psaa001
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_psaa_m.psaa001 = g_psaa_m_t.psaa001
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa001
            #add-point:BEFORE FIELD psaa001 name="input.b.psaa001"
                                                                                    CALL apst300_psaa001_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaa001
            #add-point:ON CHANGE psaa001 name="input.g.psaa001"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa002
            
            #add-point:AFTER FIELD psaa002 name="input.a.psaa002"
                                                                                    
            CALL apst300_psaa002_desc()
            IF NOT cl_null(g_psaa_m.psaa002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_psaa_m.psaa002
               LET g_chkparam.arg2 = g_psaa_m.psaadocdt
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_psaa_m.psaa002 = g_psaa_m_t.psaa002
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa002
            #add-point:BEFORE FIELD psaa002 name="input.b.psaa002"
                                                                                    CALL apst300_psaa002_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaa002
            #add-point:ON CHANGE psaa002 name="input.g.psaa002"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaa003
            #add-point:BEFORE FIELD psaa003 name="input.b.psaa003"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaa003
            
            #add-point:AFTER FIELD psaa003 name="input.a.psaa003"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaa003
            #add-point:ON CHANGE psaa003 name="input.g.psaa003"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psaastus
            #add-point:BEFORE FIELD psaastus name="input.b.psaastus"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psaastus
            
            #add-point:AFTER FIELD psaastus name="input.a.psaastus"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psaastus
            #add-point:ON CHANGE psaastus name="input.g.psaastus"
                                                                                    
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.psaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaadocno
            #add-point:ON ACTION controlp INFIELD psaadocno name="input.c.psaadocno"
                                                                                                                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psaa_m.psaadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004 #
            #LET g_qryparam.arg2 = "apst300" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_psaa_m.psaadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_psaa_m.psaadocno TO psaadocno              #顯示到畫面上

            NEXT FIELD psaadocno                          #返回原欄位                         
            #END add-point
 
 
         #Ctrlp:input.c.psaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaadocdt
            #add-point:ON ACTION controlp INFIELD psaadocdt name="input.c.psaadocdt"
                                                                                   
            #END add-point
 
 
         #Ctrlp:input.c.psaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaasite
            #add-point:ON ACTION controlp INFIELD psaasite name="input.c.psaasite"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.psaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa001
            #add-point:ON ACTION controlp INFIELD psaa001 name="input.c.psaa001"
                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psaa_m.psaa001             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_psaa_m.psaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_psaa_m.psaa001 TO psaa001              #顯示到畫面上

            NEXT FIELD psaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.psaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa002
            #add-point:ON ACTION controlp INFIELD psaa002 name="input.c.psaa002"
                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psaa_m.psaa002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_psaa_m.psaadocdt

            CALL q_ooeg001()                                #呼叫開窗

            LET g_psaa_m.psaa002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_psaa_m.psaa002 TO psaa002              #顯示到畫面上

            NEXT FIELD psaa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.psaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaa003
            #add-point:ON ACTION controlp INFIELD psaa003 name="input.c.psaa003"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.psaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psaastus
            #add-point:ON ACTION controlp INFIELD psaastus name="input.c.psaastus"
                                                                                    
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_psaa_m.psaadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                                                                                                         
               CALL s_aooi200_gen_docno(g_psaa_m.psaasite,g_psaa_m.psaadocno,g_psaa_m.psaadocdt,g_prog)
               RETURNING g_success,g_psaa_m.psaadocno
               IF g_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_psaa_m.psaadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD psaadocno
               ELSE
                  CALL apst300_set_entry('u') 
                  CALL apst300_set_no_entry('u')                  
               END IF 
               DISPLAY BY NAME g_psaa_m.psaadocno               
               #end add-point
               
               INSERT INTO psaa_t (psaaent,psaadocno,psaadocdt,psaasite,psaa001,psaa002,psaa003,psaastus, 
                   psaaownid,psaaowndp,psaacrtid,psaacrtdp,psaacrtdt,psaamodid,psaamoddt,psaacnfid,psaacnfdt) 
 
               VALUES (g_enterprise,g_psaa_m.psaadocno,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001, 
                   g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid,g_psaa_m.psaaowndp, 
                   g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid,g_psaa_m.psaamoddt, 
                   g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_psaa_m:",SQLERRMESSAGE 
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
                  CALL apst300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apst300_b_fill()
                  CALL apst300_b_fill2('0')
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
               CALL apst300_psaa_t_mask_restore('restore_mask_o')
               
               UPDATE psaa_t SET (psaadocno,psaadocdt,psaasite,psaa001,psaa002,psaa003,psaastus,psaaownid, 
                   psaaowndp,psaacrtid,psaacrtdp,psaacrtdt,psaamodid,psaamoddt,psaacnfid,psaacnfdt) = (g_psaa_m.psaadocno, 
                   g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003, 
                   g_psaa_m.psaastus,g_psaa_m.psaaownid,g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp, 
                   g_psaa_m.psaacrtdt,g_psaa_m.psaamodid,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt) 
 
                WHERE psaaent = g_enterprise AND psaadocno = g_psaadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "psaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                                                                                         
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apst300_psaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_psaa_m_t)
               LET g_log2 = util.JSON.stringify(g_psaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                                         
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_psaadocno_t = g_psaa_m.psaadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apst300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_psab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_psab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apst300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_psab_d.getLength()
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
            OPEN apst300_cl USING g_enterprise,g_psaa_m.psaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apst300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apst300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_psab_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_psab_d[l_ac].psabseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_psab_d_t.* = g_psab_d[l_ac].*  #BACKUP
               LET g_psab_d_o.* = g_psab_d[l_ac].*  #BACKUP
               CALL apst300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL apst300_set_no_entry_b(l_cmd)
               IF NOT apst300_lock_b("psab_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apst300_bcl INTO g_psab_d[l_ac].psabseq,g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab012, 
                      g_psab_d[l_ac].psab002,g_psab_d[l_ac].psab003,g_psab_d[l_ac].psab004,g_psab_d[l_ac].psab005, 
                      g_psab_d[l_ac].psab006,g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011,g_psab_d[l_ac].psab007, 
                      g_psab_d[l_ac].psab008,g_psab_d[l_ac].psab009,g_psab_d[l_ac].psabsite,g_psab_d[l_ac].psab013 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_psab_d_t.psabseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_psab_d_mask_o[l_ac].* =  g_psab_d[l_ac].*
                  CALL apst300_psab_t_mask()
                  LET g_psab_d_mask_n[l_ac].* =  g_psab_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apst300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_psab_d_o.* = g_psab_d[l_ac].*
            IF g_qty = '1' THEN
               IF g_psab_d[l_ac].psab008 = 'Y' THEN
                  IF g_rec_b = l_ac THEN 
                     LET l_i = 1
                  ELSE
                     LET l_i = l_ac + 1
                  END IF
                  CALL FGL_SET_ARR_CURR(l_i)              
               END IF
            END IF            
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
            INITIALIZE g_psab_d[l_ac].* TO NULL 
            INITIALIZE g_psab_d_t.* TO NULL 
            INITIALIZE g_psab_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_psab_d[l_ac].psab006 = "0"
      LET g_psab_d[l_ac].net = "0"
      LET g_psab_d[l_ac].psab008 = "N"
      LET g_psab_d[l_ac].psab009 = "N"
      LET g_psab_d[l_ac].psab013 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_psab_d_t.* = g_psab_d[l_ac].*     #新輸入資料
            LET g_psab_d_o.* = g_psab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apst300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            LET g_psab_d[l_ac].psabsite = g_site 
            LET g_psab_d[l_ac].psab002 = ' '            
            #end add-point
            CALL apst300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_psab_d[li_reproduce_target].* = g_psab_d[li_reproduce].*
 
               LET g_psab_d[li_reproduce_target].psabseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN
               IF cl_null(g_psab_d[l_ac].psabseq) THEN
                  SELECT MAX(psabseq) INTO g_psab_d[l_ac].psabseq
                    FROM psab_t
                   WHERE psabent = g_enterprise 
                     AND psabdocno = g_psaa_m.psaadocno
                  IF cl_null(g_psab_d[l_ac].psabseq) THEN
                     LET g_psab_d[l_ac].psabseq = 1
                  ELSE
                     LET g_psab_d[l_ac].psabseq = g_psab_d[l_ac].psabseq +1
                  END IF
               END IF
            END IF
            LET g_psab_d_o.* = g_psab_d[l_ac].*  
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
            SELECT COUNT(1) INTO l_count FROM psab_t 
             WHERE psabent = g_enterprise AND psabdocno = g_psaa_m.psaadocno
 
               AND psabseq = g_psab_d[l_ac].psabseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                                                         
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psaa_m.psaadocno
               LET gs_keys[2] = g_psab_d[g_detail_idx].psabseq
               CALL apst300_insert_b('psab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                                                                         
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_psab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apst300_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
   
               #160804-00080#1-add-(S)   
               #清空資料
               LET l_psabseq = ''
               INITIALIZE l_psab.* TO NULL
               #抓第一筆已經存進DB的單身
               SELECT psabent,psabsite,psabdocno,psab001,psab012,psab002,psab003,
                      psab004,psab005,psab006,psab010,psab011,psab007,
                      psab008,psab009,psab013
                 INTO l_psab.psabent,l_psab.psabsite,l_psab.psabdocno,l_psab.psab001,l_psab.psab012,l_psab.psab002,
                      l_psab.psab003,l_psab.psab004,l_psab.psab005,l_psab.psab006,l_psab.psab010,l_psab.psab011,
                      l_psab.psab007,l_psab.psab008,l_psab.psab009,l_psab.psab013
                 FROM psab_t
                WHERE psabent = g_enterprise
                  AND psabsite = g_site
                  AND psabdocno = g_psaa_m.psaadocno
                  AND psabseq = g_psab_d[l_ac].psabseq
               #看是否有多筆的產品特徵
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  IF cl_null(l_psabseq) THEN   
                     SELECT MAX(psabseq) INTO l_psabseq
                       FROM psab_t
                      WHERE psabent   = g_enterprise
                        AND psabsite  = g_site
                        AND psabdocno = g_psaa_m.psaadocno                     
                  END IF 
                  #開始填第一筆之後的產品特徵
                  FOR l_i = 2 TO l_inam.getLength() 
                     #項次
                     IF cl_null(l_psabseq) THEN
                        LET l_psabseq = 1
                     ELSE
                        LET l_psabseq = l_psabseq + 1             
                     END IF  
                     #產品特徵
                     LET l_psab.psab002 = l_inam[l_i].inam002
                     #需求數量
                     LET l_psab.psab005 = l_inam[l_i].inam004
                     #已耗需求
                     LET l_psab.psab006 = 0
                     INSERT INTO psab_t (psabent,psabsite,psabdocno,psabseq,psab001,psab012,psab002,psab003,
                                         psab004,psab005,psab006,psab010,psab011,psab007,
                                         psab008,psab009,psab013 )
                                 VALUES (l_psab.psabent,l_psab.psabsite,l_psab.psabdocno,l_psabseq,l_psab.psab001,l_psab.psab012,l_psab.psab002,
                                         l_psab.psab003,l_psab.psab004,l_psab.psab005,l_psab.psab006,l_psab.psab010,l_psab.psab011,
                                         l_psab.psab007,l_psab.psab008,l_psab.psab009,l_psab.psab013 )
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "psab_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     END IF                  
                  END FOR
               END IF
               CALL apst300_b_fill()
               CALL apst300_show()
               #160804-00080#1-add-(E)
               
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
               LET gs_keys[01] = g_psaa_m.psaadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_psab_d_t.psabseq
 
            
               #刪除同層單身
               IF NOT apst300_delete_b('psab_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apst300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apst300_key_delete_b(gs_keys,'psab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apst300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                                                                         
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apst300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                                                                              
               #end add-point
               LET l_count = g_psab_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_psab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psabseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_psab_d[l_ac].psabseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD psabseq
            END IF 
 
 
 
            #add-point:AFTER FIELD psabseq name="input.a.page1.psabseq"
                                                                                                #此段落由子樣板a05產生
            IF  g_psaa_m.psaadocno IS NOT NULL AND g_psab_d[g_detail_idx].psabseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_psaa_m.psaadocno != g_psaadocno_t OR g_psab_d[g_detail_idx].psabseq != g_psab_d_t.psabseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM psab_t WHERE "||"psabent = '" ||g_enterprise|| "' AND "||"psabdocno = '"||g_psaa_m.psaadocno ||"' AND "|| "psabseq = '"||g_psab_d[g_detail_idx].psabseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psabseq
            #add-point:BEFORE FIELD psabseq name="input.b.page1.psabseq"
                                                            IF cl_null(g_psab_d[l_ac].psabseq) THEN
               SELECT MAX(psabseq) INTO g_psab_d[l_ac].psabseq
                 FROM psab_t
                WHERE psabent = g_enterprise 
                  AND psabdocno = g_psaa_m.psaadocno
               IF cl_null(g_psab_d[l_ac].psabseq) THEN
                  LET g_psab_d[l_ac].psabseq = 1
               ELSE
                  LET g_psab_d[l_ac].psabseq = g_psab_d[l_ac].psabseq +1
               END IF
            END IF                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psabseq
            #add-point:ON CHANGE psabseq name="input.g.page1.psabseq"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab001
            
            #add-point:AFTER FIELD psab001 name="input.a.page1.psab001"
            CALL apst300_psab001_desc()                                                                        
            IF NOT cl_null(g_psab_d[l_ac].psab001) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_psaa_m.psaasite
               LET g_chkparam.arg2 = g_psab_d[l_ac].psab001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_3") THEN
                  #檢查成功時後續處理
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_psab_d[l_ac].psab001 <> g_psab_d_o.psab001 OR g_psab_d_o.psab001 IS NULL)) THEN 
                     CALL apst300_psab001_ref()
                  END IF   
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               #160214-00005-add----(S)
               #檢查料號+BOM特性是否存在當前據點BOM中
               IF NOT cl_null(g_psab_d[l_ac].psab012) THEN
                  IF NOT apst300_psab012_chk() THEN
                     LET g_psab_d[l_ac].psab012 = ''
                  END IF
               END IF
               #160214-00005-add----(E) 
               
               #160509-00009#3 20160516 add by ming -----(S) 
               IF g_psab_d[l_ac].psab001 <> g_psab_d_o.psab001 OR cl_null(g_psab_d_o.psab001) THEN 
                  SELECT imaf034 INTO g_psab_d[l_ac].psab013 
                    FROM imaf_t 
                   WHERE imafent  = g_enterprise 
                     AND imafsite = g_site 
                     AND imaf001  = g_psab_d[l_ac].psab001 
                  LET g_psab_d_o.psab013 = g_psab_d[l_ac].psab013 
               END IF 
               #160509-00009#3 20160516 add by ming -----(E) 
            END IF
            CALL apst300_set_entry_b(l_cmd)
            CALL apst300_set_no_entry_b(l_cmd)            
            LET g_psab_d_o.psab001 = g_psab_d[l_ac].psab001                                          

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab001
            #add-point:BEFORE FIELD psab001 name="input.b.page1.psab001"
            CALL apst300_psab001_desc()                                                                          
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab001
            #add-point:ON CHANGE psab001 name="input.g.page1.psab001"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab012
            
            #add-point:AFTER FIELD psab012 name="input.a.page1.psab012"
            #160214-00005#4-add----(S)
            IF cl_null(g_psab_d[l_ac].psab012) THEN
               LET g_psab_d[l_ac].psab012 = ' '
            ELSE
               IF NOT cl_null(g_psab_d[l_ac].psab001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_psab_d[l_ac].psab001
                  LET g_chkparam.arg2 = g_psab_d[l_ac].psab012
                  #160318-00025#2--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aim-00127:sub-01302|abmm200|",cl_get_progname("abmm200",g_lang,"2"),"|:EXEPROGabmm200"
                  #160318-00025#2--add--end
                  IF NOT cl_chk_exist("v_bmaa002") THEN
                     LET g_psab_d[l_ac].psab012 = g_psab_d_o.psab012
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_psab_d_o.psab012 = g_psab_d[l_ac].psab012
            #160214-00005#4-add----(E) 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab012
            #add-point:BEFORE FIELD psab012 name="input.b.page1.psab012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab012
            #add-point:ON CHANGE psab012 name="input.g.page1.psab012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab002
            
            #add-point:AFTER FIELD psab002 name="input.a.page1.psab002"
            IF cl_null(g_psab_d[l_ac].psab002) THEN 
               LET g_psab_d[l_ac].psab002 = ' '
            END IF
            #161226-00069#1-s
            #取得產品特徵說明 
            IF g_psab_d[l_ac].psab002 IS NOT NULL THEN
               IF NOT s_feature_check(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002) THEN
                  LET g_psab_d[l_ac].psab002 = g_psab_d[l_ac].psab002
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_feature_direct_input(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002,g_psab_d_t.psab002,g_psaa_m.psaadocno,g_psaa_m.psaasite) THEN
                  NEXT FIELD CURRENT
               END IF                
            END IF
            #161226-00069#1-e
            CALL s_feature_description(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002) RETURNING l_success,g_psab_d[l_ac].psab002_desc          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab002
            #add-point:BEFORE FIELD psab002 name="input.b.page1.psab002"
            CALL s_feature_description(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002) RETURNING l_success,g_psab_d[l_ac].psab002_desc
            #160804-00080#1-mod-(S)
#            IF apst300_imaa005_exists() THEN 
#               IF cl_null(g_psab_d[l_ac].psab002) THEN
#                  CALL aimm200_02(g_psab_d[l_ac].psab001) RETURNING g_psab_d[l_ac].psab002
#                  IF cl_null(g_psab_d[l_ac].psab002) THEN
#                     LET g_psab_d[l_ac].psab002 = ' '
#                  END IF
#                  DISPLAY BY NAME g_psab_d[l_ac].psab002
#               END IF
#            END IF    
            IF apst300_imaa005_exists() THEN 
               IF cl_null(g_psab_d[l_ac].psab002) AND NOT cl_null(g_psab_d[l_ac].psab001) THEN
                  IF s_feature_auto_chk(g_psab_d[l_ac].psab001) AND cl_null(g_psab_d[l_ac].psab002) THEN    #161017-00051#5   add by geza 20161020
                     IF l_cmd = 'a' THEN            
                        CALL l_inam.clear()            
                        CALL s_feature(l_cmd,g_psab_d[l_ac].psab001,'','',g_site,g_psaa_m.psaadocno) RETURNING l_success,l_inam
                        LET g_psab_d[l_ac].psab002 = l_inam[1].inam002  #產品特徵
                        LET g_psab_d[l_ac].psab005 = l_inam[1].inam004  #需求數量
                        DISPLAY BY NAME g_psab_d[l_ac].psab002,g_psab_d[l_ac].psab005
                     END IF
                     IF l_cmd = 'u' THEN
                        CALL s_feature_single(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002,g_site,g_psaa_m.psaadocno)
                           RETURNING l_success,g_psab_d[l_ac].psab002
                        DISPLAY BY NAME g_psab_d[l_ac].psab002
                     END IF
                  END IF   #161017-00051#5   add by geza 20161020
               END IF
            END IF
            #160804-00080#1-mod-(E)   
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab002
            #add-point:ON CHANGE psab002 name="input.g.page1.psab002"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab003
            #add-point:BEFORE FIELD psab003 name="input.b.page1.psab003"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab003
            
            #add-point:AFTER FIELD psab003 name="input.a.page1.psab003"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab003
            #add-point:ON CHANGE psab003 name="input.g.page1.psab003"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab004
            
            #add-point:AFTER FIELD psab004 name="input.a.page1.psab004"
                                                                                    
            IF NOT cl_null(g_psab_d[l_ac].psab004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_psab_d[l_ac].psab004
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               #160627-00021#1-add-(S)
               IF NOT cl_null(g_psab_d[l_ac].psab005) THEN
                  CALL s_aooi250_take_decimals(g_psab_d[l_ac].psab004,g_psab_d[l_ac].psab005) RETURNING l_success,g_psab_d[l_ac].psab005
               END IF
               #160627-00021#1-add-(E)

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab004
            #add-point:BEFORE FIELD psab004 name="input.b.page1.psab004"
                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab004
            #add-point:ON CHANGE psab004 name="input.g.page1.psab004"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_psab_d[l_ac].psab005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD psab005
            END IF 
 
 
 
            #add-point:AFTER FIELD psab005 name="input.a.page1.psab005"
                                                                                    
            IF NOT cl_null(g_psab_d[l_ac].psab005) THEN
               IF g_psab_d[l_ac].psab005 < g_psab_d[l_ac].psab006 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00042'
                  LET g_errparam.extend = g_psab_d[l_ac].psab006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_psab_d[l_ac].psab005 = g_psab_d_t.psab005 
                  NEXT FIELD CURRENT
               END IF
               #160627-00021#1-add-(S)
               IF NOT cl_null(g_psab_d[l_ac].psab004) THEN
                  CALL s_aooi250_take_decimals(g_psab_d[l_ac].psab004,g_psab_d[l_ac].psab005) RETURNING l_success,g_psab_d[l_ac].psab005
               END IF
               #160627-00021#1-add-(E)
               LET g_psab_d[l_ac].net = g_psab_d[l_ac].psab005 - g_psab_d[l_ac].psab006
            END IF             


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab005
            #add-point:BEFORE FIELD psab005 name="input.b.page1.psab005"
                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab005
            #add-point:ON CHANGE psab005 name="input.g.page1.psab005"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_psab_d[l_ac].psab006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD psab006
            END IF 
 
 
 
            #add-point:AFTER FIELD psab006 name="input.a.page1.psab006"
                                                                                    
            IF NOT cl_null(g_psab_d[l_ac].psab006) THEN
               IF g_psab_d[l_ac].psab006 > g_psab_d[l_ac].psab005 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00039'
                  LET g_errparam.extend = g_psab_d[l_ac].psab006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_psab_d[l_ac].psab006 = g_psab_d_t.psab006 
                  NEXT FIELD CURRENT
               END IF
               LET g_psab_d[l_ac].net = g_psab_d[l_ac].psab005 - g_psab_d[l_ac].psab006
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab006
            #add-point:BEFORE FIELD psab006 name="input.b.page1.psab006"
                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab006
            #add-point:ON CHANGE psab006 name="input.g.page1.psab006"
                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab010
            
            #add-point:AFTER FIELD psab010 name="input.a.page1.psab010"
            CALL s_desc_get_project_desc(g_psab_d[l_ac].psab010) RETURNING g_psab_d[l_ac].psab010_desc
            DISPLAY BY NAME g_psab_d[l_ac].psab010_desc
            IF NOT cl_null(g_psab_d[l_ac].psab010) THEN 
#應用 a17 樣板自動產生(Version:2)
               IF g_psab_d[l_ac].psab010 != g_psab_d_o.psab010 OR cl_null(g_psab_d_o.psab010) THEN
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_psab_d[l_ac].psab010
                  #160318-00025#2--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                  #160318-00025#2--add--end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pjba001") THEN
                     #檢查失敗時後續處理
                     LET g_psab_d[l_ac].psab010 = g_psab_d_o.psab010
                     CALL s_desc_get_project_desc(g_psab_d[l_ac].psab010) RETURNING g_psab_d[l_ac].psab010_desc
                     DISPLAY BY NAME g_psab_d[l_ac].psab010_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_psab_d[l_ac].psab011 = ''
                  LET g_psab_d[l_ac].psab011_desc = ''
                  DISPLAY BY NAME g_psab_d[l_ac].psab011,g_psab_d[l_ac].psab011_desc
               END IF

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab010
            #add-point:BEFORE FIELD psab010 name="input.b.page1.psab010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab010
            #add-point:ON CHANGE psab010 name="input.g.page1.psab010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab011
            
            #add-point:AFTER FIELD psab011 name="input.a.page1.psab011"
            CALL s_desc_get_wbs_desc(g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011) RETURNING g_psab_d[l_ac].psab011_desc
            DISPLAY BY NAME g_psab_d[l_ac].psab011_desc
            IF NOT cl_null(g_psab_d[l_ac].psab011) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_psab_d[l_ac].psab010
               LET g_chkparam.arg2 = g_psab_d[l_ac].psab011
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbb002") THEN
                  #檢查失敗時後續處理
                  LET g_psab_d[l_ac].psab011 = g_psab_d_t.psab011
                  CALL s_desc_get_wbs_desc(g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011) RETURNING g_psab_d[l_ac].psab011_desc
                  DISPLAY BY NAME g_psab_d[l_ac].psab011_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab011
            #add-point:BEFORE FIELD psab011 name="input.b.page1.psab011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab011
            #add-point:ON CHANGE psab011 name="input.g.page1.psab011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab008
            #add-point:BEFORE FIELD psab008 name="input.b.page1.psab008"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab008
            
            #add-point:AFTER FIELD psab008 name="input.a.page1.psab008"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab008
            #add-point:ON CHANGE psab008 name="input.g.page1.psab008"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab009
            #add-point:BEFORE FIELD psab009 name="input.b.page1.psab009"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab009
            
            #add-point:AFTER FIELD psab009 name="input.a.page1.psab009"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab009
            #add-point:ON CHANGE psab009 name="input.g.page1.psab009"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psabsite
            #add-point:BEFORE FIELD psabsite name="input.b.page1.psabsite"
                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psabsite
            
            #add-point:AFTER FIELD psabsite name="input.a.page1.psabsite"
                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psabsite
            #add-point:ON CHANGE psabsite name="input.g.page1.psabsite"
                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psab013
            #add-point:BEFORE FIELD psab013 name="input.b.page1.psab013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psab013
            
            #add-point:AFTER FIELD psab013 name="input.a.page1.psab013"
            LET g_psab_d_o.psab013 = g_psab_d[l_ac].psab013 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psab013
            #add-point:ON CHANGE psab013 name="input.g.page1.psab013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.psabseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psabseq
            #add-point:ON ACTION controlp INFIELD psabseq name="input.c.page1.psabseq"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab001
            #add-point:ON ACTION controlp INFIELD psab001 name="input.c.page1.psab001"
                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psab_d[l_ac].psab001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_psaa_m.psaasite 
            CALL q_imaf001_7()                                #呼叫開窗

            LET g_psab_d[l_ac].psab001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_psab_d[l_ac].psab001 TO psab001              #顯示到畫面上

            NEXT FIELD psab001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.psab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab012
            #add-point:ON ACTION controlp INFIELD psab012 name="input.c.page1.psab012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab002
            #add-point:ON ACTION controlp INFIELD psab002 name="input.c.page1.psab002"
            #此段落由子樣板a07產生
            #160804-00080#1-mark-(S)
#            #開窗i段
#		    	INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#		   	LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_psab_d[l_ac].psab002             #給予default值
#            LET l_psab002_t = g_psab_d[l_ac].psab002
#            #給予arg
#
#            CALL aimm200_02(g_psab_d[l_ac].psab001) RETURNING g_qryparam.return1                             #呼叫開窗
#
#            LET g_psab_d[l_ac].psab002 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            IF cl_null(g_psab_d[l_ac].psab002) THEN
#               LET g_psab_d[l_ac].psab002 = l_psab002_t
#            END IF
#            DISPLAY g_psab_d[l_ac].psab002 TO psab002              #顯示到畫面上                                  
            #160804-00080#1-mark-(E)
            #160804-00080#1-add-(S)
            #先確認料件產品特徵有沒有
            IF apst300_imaa005_exists() THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_psab_d[l_ac].psab001,'','',g_site,g_psaa_m.psaadocno) RETURNING l_success,l_inam
                  LET g_psab_d[l_ac].psab002 = l_inam[1].inam002  #產品特徵
                  LET g_psab_d[l_ac].psab005 = l_inam[1].inam004  #需求數量
                  DISPLAY BY NAME g_psab_d[l_ac].psab002,g_psab_d[l_ac].psab005
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002,g_site,g_psaa_m.psaadocno)
                     RETURNING l_success,g_psab_d[l_ac].psab002
                  DISPLAY BY NAME g_psab_d[l_ac].psab002
               END IF
            END IF 
            #160804-00080#1-add-(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab003
            #add-point:ON ACTION controlp INFIELD psab003 name="input.c.page1.psab003"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab004
            #add-point:ON ACTION controlp INFIELD psab004 name="input.c.page1.psab004"
                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psab_d[l_ac].psab004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_psab_d[l_ac].psab004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_psab_d[l_ac].psab004 TO psab004              #顯示到畫面上

            NEXT FIELD psab004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.psab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab005
            #add-point:ON ACTION controlp INFIELD psab005 name="input.c.page1.psab005"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab006
            #add-point:ON ACTION controlp INFIELD psab006 name="input.c.page1.psab006"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab010
            #add-point:ON ACTION controlp INFIELD psab010 name="input.c.page1.psab010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psab_d[l_ac].psab010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjba001()                                #呼叫開窗

            LET g_psab_d[l_ac].psab010 = g_qryparam.return1              

            DISPLAY g_psab_d[l_ac].psab010 TO psab010              #
            CALL s_desc_get_project_desc(g_psab_d[l_ac].psab010) RETURNING g_psab_d[l_ac].psab010_desc
            DISPLAY BY NAME g_psab_d[l_ac].psab010_desc

            NEXT FIELD psab010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.psab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab011
            #add-point:ON ACTION controlp INFIELD psab011 name="input.c.page1.psab011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_psab_d[l_ac].psab011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_psab_d[l_ac].psab010 #s
 

            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_psab_d[l_ac].psab011 = g_qryparam.return1              

            DISPLAY g_psab_d[l_ac].psab011 TO psab011              #
            CALL s_desc_get_wbs_desc(g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011) RETURNING g_psab_d[l_ac].psab011_desc
            DISPLAY BY NAME g_psab_d[l_ac].psab011_desc

            NEXT FIELD psab011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.psab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab008
            #add-point:ON ACTION controlp INFIELD psab008 name="input.c.page1.psab008"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab009
            #add-point:ON ACTION controlp INFIELD psab009 name="input.c.page1.psab009"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psabsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psabsite
            #add-point:ON ACTION controlp INFIELD psabsite name="input.c.page1.psabsite"
                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.psab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psab013
            #add-point:ON ACTION controlp INFIELD psab013 name="input.c.page1.psab013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_psab_d[l_ac].* = g_psab_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apst300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_psab_d[l_ac].psabseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_psab_d[l_ac].* = g_psab_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                                                                                         
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apst300_psab_t_mask_restore('restore_mask_o')
      
               UPDATE psab_t SET (psabdocno,psabseq,psab001,psab012,psab002,psab003,psab004,psab005, 
                   psab006,psab010,psab011,psab007,psab008,psab009,psabsite,psab013) = (g_psaa_m.psaadocno, 
                   g_psab_d[l_ac].psabseq,g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab012,g_psab_d[l_ac].psab002, 
                   g_psab_d[l_ac].psab003,g_psab_d[l_ac].psab004,g_psab_d[l_ac].psab005,g_psab_d[l_ac].psab006, 
                   g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011,g_psab_d[l_ac].psab007,g_psab_d[l_ac].psab008, 
                   g_psab_d[l_ac].psab009,g_psab_d[l_ac].psabsite,g_psab_d[l_ac].psab013)
                WHERE psabent = g_enterprise AND psabdocno = g_psaa_m.psaadocno 
 
                  AND psabseq = g_psab_d_t.psabseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                                                                         
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_psab_d[l_ac].* = g_psab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "psab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_psab_d[l_ac].* = g_psab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psaa_m.psaadocno
               LET gs_keys_bak[1] = g_psaadocno_t
               LET gs_keys[2] = g_psab_d[g_detail_idx].psabseq
               LET gs_keys_bak[2] = g_psab_d_t.psabseq
               CALL apst300_update_b('psab_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apst300_psab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_psab_d[g_detail_idx].psabseq = g_psab_d_t.psabseq 
 
                  ) THEN
                  LET gs_keys[01] = g_psaa_m.psaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_psab_d_t.psabseq
 
                  CALL apst300_key_update_b(gs_keys,'psab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_psaa_m),util.JSON.stringify(g_psab_d_t)
               LET g_log2 = util.JSON.stringify(g_psaa_m),util.JSON.stringify(g_psab_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                                                                                         
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #160214-00005#4-add-(S)
            IF cl_null(g_psab_d[l_ac].psab012) THEN
               LET g_psab_d[l_ac].psab012 = ' '
            END IF
            #160214-00005#4-add-(E)
            #end add-point
            CALL apst300_unlock_b("psab_t","'1'")
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
               LET g_psab_d[li_reproduce_target].* = g_psab_d[li_reproduce].*
 
               LET g_psab_d[li_reproduce_target].psabseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_psab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_psab_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apst300.input.other" >}
      
      #add-point:自定義input name="input.more_input"
                                          
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_qty = 'Y' THEN    
            CALL FGL_SET_ARR_CURR(l_ac)
         END IF            
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD psaadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD psabseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
                     
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apst300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5                   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
                     
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apst300_b_fill() #單身填充
      CALL apst300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apst300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
                     
            CALL s_aooi200_get_slip_desc(g_psaa_m.psaadocno) RETURNING g_psaa_m.psaadocno_desc
            DISPLAY BY NAME g_psaa_m.psaadocno_desc
#            CALL apst300_psaa001_desc()
#            CALL apst300_psaa002_desc()
#            
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaamodid_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_psaa_m.psaacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_psaa_m.psaacnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_psaa_m.psaacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_psaa_m_mask_o.* =  g_psaa_m.*
   CALL apst300_psaa_t_mask()
   LET g_psaa_m_mask_n.* =  g_psaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocno_desc,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001, 
       g_psaa_m.psaa001_desc,g_psaa_m.psaa002,g_psaa_m.psaa002_desc,g_psaa_m.psaa003,g_psaa_m.psaastus, 
       g_psaa_m.psaaownid,g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid, 
       g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdp_desc,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfid_desc,g_psaa_m.psaacnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_psaa_m.psaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
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
   FOR l_ac = 1 TO g_psab_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                              
      LET g_psab_d[l_ac].net = g_psab_d[l_ac].psab005 - g_psab_d[l_ac].psab006       
#      CALL apst300_psab001_desc()
      CALL s_feature_description(g_psab_d[l_ac].psab001,g_psab_d[l_ac].psab002) RETURNING l_success,g_psab_d[l_ac].psab002_desc
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
                     
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apst300_detail_show()
 
   #add-point:show段之後 name="show.after"
                     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apst300_detail_show()
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
 
{<section id="apst300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apst300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE psaa_t.psaadocno 
   DEFINE l_oldno     LIKE psaa_t.psaadocno 
 
   DEFINE l_master    RECORD LIKE psaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE psab_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_i         LIKE type_t.num5   #160307-00012#1-add
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
   
   IF g_psaa_m.psaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_psaadocno_t = g_psaa_m.psaadocno
 
    
   LET g_psaa_m.psaadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_psaa_m.psaaownid = g_user
      LET g_psaa_m.psaaowndp = g_dept
      LET g_psaa_m.psaacrtid = g_user
      LET g_psaa_m.psaacrtdp = g_dept 
      LET g_psaa_m.psaacrtdt = cl_get_current()
      LET g_psaa_m.psaamodid = g_user
      LET g_psaa_m.psaamoddt = cl_get_current()
      LET g_psaa_m.psaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_psaa_m.psaacnfid = ""
   LET g_psaa_m.psaacnfdt = ""   
   LET g_psaa_m.psaastus ='N'
   #doirslai-20160324-add-(S)
   LET g_psaa_m.psaacnfid_desc = "" 
   LET g_psaa_m.psaacnfid_desc = ""
   LET g_psaa_m.psaadocdt = g_today
   LET g_psaa_m.psaa001 = g_user
   LET g_psaa_m.psaa002 = g_dept
   #doirslai-20160324-add-(E)
   DISPLAY BY NAME g_psaa_m.*
   LET g_psaa_m_t.* =  g_psaa_m.*    
   #160307-00012#1-add-(S)
   #複製要把已耗需求歸0
   FOR l_i = 1 TO g_psab_d.getLength()
      LET g_psab_d[l_i].psab006 = 0    #已耗需求歸0
      LET g_psab_d[l_i].net = g_psab_d[l_i].psab005 #淨需求量=需求數量
   END FOR
   #160307-00012#1-add-(E)
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_psaa_m.psaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
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
      LET g_psaa_m.psaadocno_desc = ''
   DISPLAY BY NAME g_psaa_m.psaadocno_desc
 
   
   CALL apst300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_psaa_m.* TO NULL
      INITIALIZE g_psab_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apst300_show()
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
   CALL apst300_set_act_visible()   
   CALL apst300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_psaadocno_t = g_psaa_m.psaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " psaaent = " ||g_enterprise|| " AND",
                      " psaadocno = '", g_psaa_m.psaadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apst300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apst300_idx_chk()
   
   LET g_data_owner = g_psaa_m.psaaownid      
   LET g_data_dept  = g_psaa_m.psaaowndp
   
   #功能已完成,通報訊息中心
   CALL apst300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apst300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE psab_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apst300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM psab_t
    WHERE psabent = g_enterprise AND psabdocno = g_psaadocno_t
 
    INTO TEMP apst300_detail
 
   #將key修正為調整後   
   UPDATE apst300_detail 
      #更新key欄位
      SET psabdocno = g_psaa_m.psaadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #160307-00012#1-add-(S)
   UPDATE apst300_detail
      SET psab006 = 0
    WHERE psabent = g_enterprise
      AND psabsite = g_site
      AND psabdocno = g_psaa_m.psaadocno
   #160307-00012#1-add-(E)
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO psab_t SELECT * FROM apst300_detail
   
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
   DROP TABLE apst300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                     
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_psaadocno_t = g_psaa_m.psaadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apst300_delete()
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
   
   IF g_psaa_m.psaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apst300_cl USING g_enterprise,g_psaa_m.psaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apst300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apst300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_psaa_m_mask_o.* =  g_psaa_m.*
   CALL apst300_psaa_t_mask()
   LET g_psaa_m_mask_n.* =  g_psaa_m.*
   
   CALL apst300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                          
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apst300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_psaadocno_t = g_psaa_m.psaadocno
 
 
      DELETE FROM psaa_t
       WHERE psaaent = g_enterprise AND psaadocno = g_psaa_m.psaadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                                          
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_psaa_m.psaadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM psab_t
       WHERE psabent = g_enterprise AND psabdocno = g_psaa_m.psaadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                                          
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
                                          
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_psaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apst300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_psab_d.clear() 
 
     
      CALL apst300_ui_browser_refresh()  
      #CALL apst300_ui_headershow()  
      #CALL apst300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apst300_browser_fill("")
         CALL apst300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apst300_cl
 
   #功能已完成,通報訊息中心
   CALL apst300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apst300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apst300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
                     
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_psab_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
                     
   #end add-point
   
   #判斷是否填充
   IF apst300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT psabseq,psab001,psab012,psab002,psab003,psab004,psab005,psab006, 
             psab010,psab011,psab007,psab008,psab009,psabsite,psab013 ,t1.imaal003 ,t2.imaal004 ,t3.pjbal003 , 
             t4.pjbbl004 FROM psab_t",   
                     " INNER JOIN psaa_t ON psaaent = " ||g_enterprise|| " AND psaadocno = psabdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=psab001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=psab001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t3 ON t3.pjbalent="||g_enterprise||" AND t3.pjbal001=psab010 AND t3.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t4 ON t4.pjbblent="||g_enterprise||" AND t4.pjbbl001=psab010 AND t4.pjbbl002=psab011 AND t4.pjbbl003='"||g_dlang||"' ",
 
                     " WHERE psabent=? AND psabdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                                          
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY psab_t.psabseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                                          
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apst300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apst300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_psaa_m.psaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_psaa_m.psaadocno INTO g_psab_d[l_ac].psabseq,g_psab_d[l_ac].psab001, 
          g_psab_d[l_ac].psab012,g_psab_d[l_ac].psab002,g_psab_d[l_ac].psab003,g_psab_d[l_ac].psab004, 
          g_psab_d[l_ac].psab005,g_psab_d[l_ac].psab006,g_psab_d[l_ac].psab010,g_psab_d[l_ac].psab011, 
          g_psab_d[l_ac].psab007,g_psab_d[l_ac].psab008,g_psab_d[l_ac].psab009,g_psab_d[l_ac].psabsite, 
          g_psab_d[l_ac].psab013,g_psab_d[l_ac].psab001_desc,g_psab_d[l_ac].psab001_desc_desc,g_psab_d[l_ac].psab010_desc, 
          g_psab_d[l_ac].psab011_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_psab_d[l_ac].net = g_psab_d[l_ac].psab005 - g_psab_d[l_ac].psab006                     
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
   
   CALL g_psab_d.deleteElement(g_psab_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apst300_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_psab_d.getLength()
      LET g_psab_d_mask_o[l_ac].* =  g_psab_d[l_ac].*
      CALL apst300_psab_t_mask()
      LET g_psab_d_mask_n[l_ac].* =  g_psab_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apst300_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM psab_t
       WHERE psabent = g_enterprise AND
         psabdocno = ps_keys_bak[1] AND psabseq = ps_keys_bak[2]
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
         CALL g_psab_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
                     
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apst300_insert_b(ps_table,ps_keys,ps_page)
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
                                          
      #end add-point 
      INSERT INTO psab_t
                  (psabent,
                   psabdocno,
                   psabseq
                   ,psab001,psab012,psab002,psab003,psab004,psab005,psab006,psab010,psab011,psab007,psab008,psab009,psabsite,psab013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_psab_d[g_detail_idx].psab001,g_psab_d[g_detail_idx].psab012,g_psab_d[g_detail_idx].psab002, 
                       g_psab_d[g_detail_idx].psab003,g_psab_d[g_detail_idx].psab004,g_psab_d[g_detail_idx].psab005, 
                       g_psab_d[g_detail_idx].psab006,g_psab_d[g_detail_idx].psab010,g_psab_d[g_detail_idx].psab011, 
                       g_psab_d[g_detail_idx].psab007,g_psab_d[g_detail_idx].psab008,g_psab_d[g_detail_idx].psab009, 
                       g_psab_d[g_detail_idx].psabsite,g_psab_d[g_detail_idx].psab013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                                          
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_psab_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                                          
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
                     
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apst300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "psab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                                          
      #end add-point 
      
      #將遮罩欄位還原
      CALL apst300_psab_t_mask_restore('restore_mask_o')
               
      UPDATE psab_t 
         SET (psabdocno,
              psabseq
              ,psab001,psab012,psab002,psab003,psab004,psab005,psab006,psab010,psab011,psab007,psab008,psab009,psabsite,psab013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_psab_d[g_detail_idx].psab001,g_psab_d[g_detail_idx].psab012,g_psab_d[g_detail_idx].psab002, 
                  g_psab_d[g_detail_idx].psab003,g_psab_d[g_detail_idx].psab004,g_psab_d[g_detail_idx].psab005, 
                  g_psab_d[g_detail_idx].psab006,g_psab_d[g_detail_idx].psab010,g_psab_d[g_detail_idx].psab011, 
                  g_psab_d[g_detail_idx].psab007,g_psab_d[g_detail_idx].psab008,g_psab_d[g_detail_idx].psab009, 
                  g_psab_d[g_detail_idx].psabsite,g_psab_d[g_detail_idx].psab013) 
         WHERE psabent = g_enterprise AND psabdocno = ps_keys_bak[1] AND psabseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                                          
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "psab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "psab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apst300_psab_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                                          
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
                     
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apst300_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apst300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apst300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apst300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apst300_lock_b(ps_table,ps_page)
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
   #CALL apst300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "psab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apst300_bcl USING g_enterprise,
                                       g_psaa_m.psaadocno,g_psab_d[g_detail_idx].psabseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apst300_bcl:",SQLERRMESSAGE 
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
 
{<section id="apst300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apst300_unlock_b(ps_table,ps_page)
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
      CLOSE apst300_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
                     
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apst300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                     
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("psaadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("psaadocno",TRUE)
      CALL cl_set_comp_entry("psaadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
            CALL cl_set_comp_entry("psaadocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("psaa001,psaa002,psaa003",TRUE)
                  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apst300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
                     
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("psaadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
            CALL cl_set_comp_entry("psaadocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("psaadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("psaadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
      IF g_qty = '1' THEN 
      CALL cl_set_comp_entry("psaa001,psaa002,psaa003",FALSE)
   END IF  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apst300_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("psabseq,psab001,psab002,psab003,psab004,psab005,psab007,psab009",TRUE)
                   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apst300_set_no_entry_b(p_cmd)
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
   IF g_qty = '1' THEN 
      CALL cl_set_comp_entry("psabseq,psab001,psab002,psab003,psab004,psab005,psab007,psab009",FALSE)
   END IF 
   IF NOT apst300_imaa005_exists() THEN
      CALL cl_set_comp_entry("psab002",FALSE)
      LET g_psab_d[l_ac].psab002 = ' '
   END IF   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apst300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   #dorislai-20151013-add----(S)
   CALL cl_set_act_visible("modify,modify_detail,delete,con_qty,single_closed,single_unclosed",TRUE)
   #dorislai-20151013-add----(E)
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apst300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_psaa_m.psaastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #dorislai-20151013-add----(S)
   CASE g_psaa_m.psaastus 
      WHEN 'Y'  
         CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
      WHEN 'C' 
         CALL cl_set_act_visible("modify,modify_detail,delete,con_qty",FALSE)
      WHEN 'N'  
         CALL cl_set_act_visible("con_qty,single_closed,single_unclosed",FALSE)
      WHEN 'X'  
         CALL cl_set_act_visible("modify,modify_detail,delete,con_qty,single_closed,single_unclosed",FALSE)
   END CASE 
   #dorislai-20151013-add----(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apst300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apst300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apst300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apst300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apst300_default_search()
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
      LET ls_wc = ls_wc, " psaadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "psaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "psab_t" 
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
 
{<section id="apst300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apst300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5   #161216-00017#1                 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_psaa_m.psaastus = 'X' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = g_psaa_m.psaastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #dorislai-21051012-add---(S)
   #若狀態為C:結案，不彈跳出選擇窗
   IF g_psaa_m.psaastus = 'C' THEN
      RETURN
   END IF
   #dorislai-21051012-add---(E)
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_psaa_m.psaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apst300_cl USING g_enterprise,g_psaa_m.psaadocno
   IF STATUS THEN
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apst300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
       g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
       g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
       g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apst300_action_chk() THEN
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocno_desc,g_psaa_m.psaadocdt,g_psaa_m.psaasite,g_psaa_m.psaa001, 
       g_psaa_m.psaa001_desc,g_psaa_m.psaa002,g_psaa_m.psaa002_desc,g_psaa_m.psaa003,g_psaa_m.psaastus, 
       g_psaa_m.psaaownid,g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid, 
       g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdp_desc,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
       g_psaa_m.psaamodid_desc,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfid_desc,g_psaa_m.psaacnfdt 
 
 
   CASE g_psaa_m.psaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
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
         CASE g_psaa_m.psaastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "C"
               HIDE OPTION "closed"
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
         #dorislai-20151012-moidfy----(S)
#         CASE g_psaa_m.psaastus
#            WHEN "N"
#               HIDE OPTION "open"
#               HIDE OPTION "closed"
#            WHEN "X"
#               HIDE OPTION "invalid"
#               HIDE OPTION "confirmed"
#               HIDE OPTION "closed"
#               HIDE OPTION "open"
#            WHEN "Y"
#               HIDE OPTION "confirmed"
#               HIDE OPTION "invalid"
#            WHEN "C"
#               HIDE OPTION "closed"
#               HIDE OPTION "open"
#               HIDE OPTION "invalid"
#            
#         END CASE 
         CASE g_psaa_m.psaastus
            
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
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "H"
               HIDE OPTION "hold"
            WHEN "UH"
               HIDE OPTION "unhold"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
         
         #open改為unconfirmed
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
         #無條件關結案
         CALL cl_set_act_visible("closed,unclosed",FALSE)
         #提交和抽單一開始先無條件關
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         
         CASE g_psaa_m.psaastus
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  CALL cl_set_act_visible("signing",TRUE)
                  CALL cl_set_act_visible("confirmed",FALSE)
               END IF
       
            WHEN "X"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
               CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
               RETURN
            WHEN "Y"
               CALL cl_set_act_visible("closed",TRUE)
               CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
            #結案，其餘功能接隱藏
            WHEN "C"
               CALL cl_set_act_visible("unconfirmed,invalid,closed,confirmed",FALSE)  
               
            #已核准只能顯示確認;其餘應用功能皆隱藏
            WHEN "A"     
               CALL cl_set_act_visible("confirmed ",TRUE)   
               CALL cl_set_act_visible("unconfirmed,invalid",FALSE)         
            
            #保留修改的功能(如作廢)，隱藏其他應用功能
            WHEN "R"   
               CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            WHEN "D"  
               CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
               
            #送簽中只能顯示抽單;其餘應用功能皆隱藏
            WHEN "W"   
               CALL cl_set_act_visible("withdraw",TRUE)  
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         END CASE
         #dorislai-20151012-modify---(E)
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apst300_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apst300_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apst300_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apst300_cl
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
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
                                                            
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
      AND lc_state <> "C"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_psaa_m.psaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---   
   
   IF lc_state = "C" THEN 
      UPDATE psab_t 
         SET psab008 = 'Y' 
       WHERE psabent = g_enterprise
         AND psabdocno = g_psaa_m.psaadocno
      IF SQLCA.sqlcode <> 0 THEN 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   ELSE    
      UPDATE psab_t 
         SET psab008 = 'N' 
       WHERE psabent = g_enterprise
         AND psabdocno = g_psaa_m.psaadocno
      IF SQLCA.sqlcode <> 0 THEN 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
   END IF
   
   #161216-00017#1-S
   #IF lc_state = "Y" THEN 
   #   LET g_psaa_m.psaacnfid = g_user
   #   LET g_psaa_m.psaacnfdt = cl_get_current()
   #   UPDATE psaa_t 
   #      SET psaacnfid = g_psaa_m.psaacnfid,
   #          psaacnfdt = g_psaa_m.psaacnfdt         
   #    WHERE psaaent = g_enterprise
   #      AND psaadocno = g_psaa_m.psaadocno
   #   IF SQLCA.sqlcode <> 0 THEN 
   #      CALL s_transaction_end('N','0')
   #      RETURN
   #   END IF        
   #END IF   
   IF lc_state = 'Y' THEN
      CALL s_apst300_conf_chk(g_psaa_m.psaadocno) RETURNING l_success
      IF NOT l_success THEN
         CLOSE apst300_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CLOSE apst300_cl
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_apst300_conf_upd(g_psaa_m.psaadocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE apst300_cl  
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #161216-00017#1-E
   IF lc_state = "N" THEN 
      LET g_psaa_m.psaacnfid = ''
      LET g_psaa_m.psaacnfdt = ''
      UPDATE psaa_t 
         SET psaacnfid = g_psaa_m.psaacnfid,
             psaacnfdt = g_psaa_m.psaacnfdt         
       WHERE psaaent = g_enterprise
         AND psaadocno = g_psaa_m.psaadocno
      IF SQLCA.sqlcode <> 0 THEN 
         CALL s_transaction_end('N','0')
         RETURN
      END IF        
   END IF   
   CALL apst300_show()  #dorislai-20151012-add
   #end add-point
   
   LET g_psaa_m.psaamodid = g_user
   LET g_psaa_m.psaamoddt = cl_get_current()
   LET g_psaa_m.psaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE psaa_t 
      SET (psaastus,psaamodid,psaamoddt) 
        = (g_psaa_m.psaastus,g_psaa_m.psaamodid,g_psaa_m.psaamoddt)     
    WHERE psaaent = g_enterprise AND psaadocno = g_psaa_m.psaadocno
 
    
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
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
      EXECUTE apst300_master_referesh USING g_psaa_m.psaadocno INTO g_psaa_m.psaadocno,g_psaa_m.psaadocdt, 
          g_psaa_m.psaasite,g_psaa_m.psaa001,g_psaa_m.psaa002,g_psaa_m.psaa003,g_psaa_m.psaastus,g_psaa_m.psaaownid, 
          g_psaa_m.psaaowndp,g_psaa_m.psaacrtid,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdt,g_psaa_m.psaamodid, 
          g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt,g_psaa_m.psaa001_desc,g_psaa_m.psaa002_desc, 
          g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp_desc,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp_desc, 
          g_psaa_m.psaamodid_desc,g_psaa_m.psaacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_psaa_m.psaadocno,g_psaa_m.psaadocno_desc,g_psaa_m.psaadocdt,g_psaa_m.psaasite, 
          g_psaa_m.psaa001,g_psaa_m.psaa001_desc,g_psaa_m.psaa002,g_psaa_m.psaa002_desc,g_psaa_m.psaa003, 
          g_psaa_m.psaastus,g_psaa_m.psaaownid,g_psaa_m.psaaownid_desc,g_psaa_m.psaaowndp,g_psaa_m.psaaowndp_desc, 
          g_psaa_m.psaacrtid,g_psaa_m.psaacrtid_desc,g_psaa_m.psaacrtdp,g_psaa_m.psaacrtdp_desc,g_psaa_m.psaacrtdt, 
          g_psaa_m.psaamodid,g_psaa_m.psaamodid_desc,g_psaa_m.psaamoddt,g_psaa_m.psaacnfid,g_psaa_m.psaacnfid_desc, 
          g_psaa_m.psaacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
         CALL s_transaction_end('Y','0')            
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   LET g_psaa_m.psaacnfid = ''
   LET g_psaa_m.psaacnfdt = ''
   SELECT psaacnfid,psaacnfdt INTO g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt
    FROM psaa_t       
    WHERE psaaent = g_enterprise
      AND psaadocno = g_psaa_m.psaadocno
   DISPLAY BY NAME g_psaa_m.psaacnfid,g_psaa_m.psaacnfdt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psaa_m.psaacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaacnfid_desc   
    
   #end add-point  
 
   CLOSE apst300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apst300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apst300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apst300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
                     
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_psab_d.getLength() THEN
         LET g_detail_idx = g_psab_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_psab_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_psab_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
                     
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apst300_b_fill2(pi_idx)
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
   
   CALL apst300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apst300_fill_chk(ps_idx)
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
 
{<section id="apst300.status_show" >}
PRIVATE FUNCTION apst300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apst300.mask_functions" >}
&include "erp/aps/apst300_mask.4gl"
 
{</section>}
 
{<section id="apst300.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apst300_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apst300_show()
   CALL apst300_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #161216-00017#1-S
   #確認前檢核段
   IF NOT s_apst300_conf_chk(g_psaa_m.psaastus) THEN
      CLOSE apst300_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #161216-00017#1-E 
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_psaa_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_psab_d))
 
 
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
   #CALL apst300_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apst300_ui_headershow()
   CALL apst300_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apst300_draw_out()
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
   CALL apst300_ui_headershow()  
   CALL apst300_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apst300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apst300_set_pk_array()
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
   LET g_pk_array[1].values = g_psaa_m.psaadocno
   LET g_pk_array[1].column = 'psaadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apst300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apst300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apst300_msgcentre_notify(lc_state)
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
   CALL apst300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_psaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apst300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apst300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#32 add-S
   SELECT psaastus  INTO g_psaa_m.psaastus
     FROM psaa_t
    WHERE psaaent = g_enterprise
      AND psaadocno = g_psaa_m.psaadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_psaa_m.psaastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
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
        LET g_errparam.extend = g_psaa_m.psaadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apst300_set_act_visible()
        CALL apst300_set_act_no_visible()
        CALL apst300_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#32 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apst300.other_function" readonly="Y" >}

PRIVATE FUNCTION apst300_psaa001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psaa_m.psaa001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaa001_desc
END FUNCTION

PRIVATE FUNCTION apst300_psaa002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaa002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psaa_m.psaa002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaa002_desc
END FUNCTION

PRIVATE FUNCTION apst300_psab001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psab_d[l_ac].psab001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psab_d[l_ac].psab001_desc = '', g_rtn_fields[1] , ''
   LET g_psab_d[l_ac].psab001_desc_desc = '', g_rtn_fields[2] , '' 
   DISPLAY BY NAME g_psab_d[l_ac].psab001_desc,g_psab_d[l_ac].psab001_desc_desc
END FUNCTION

PRIVATE FUNCTION apst300_single_closed()
DEFINE l_cnt  LIKE type_t.num5   
   
   IF cl_null(l_ac) OR l_ac = 0 THEN 
      RETURN
   END IF
   IF g_psab_d[l_ac].psab008 = 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00040'
      LET g_errparam.extend = g_psab_d[l_ac].psab008
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   UPDATE psab_t 
      SET psab008 = 'Y' 
    WHERE psabent = g_enterprise
      AND psabdocno = g_psaa_m.psaadocno
      AND psabseq = g_psab_d[l_ac].psabseq
   
   IF g_psaa_m.psaastus = 'Y' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM psab_t
       WHERE psabent = g_enterprise
         AND psabdocno = g_psaa_m.psaadocno
         AND psab008 <> 'Y'
      IF l_cnt = 0 THEN 
         UPDATE psaa_t 
            SET psaastus = 'C' 
          WHERE psaaent = g_enterprise
            AND psaadocno = g_psaa_m.psaadocno
      END IF
   END IF
   #160729-00074#1-add-(S)
   #資料做結案與取消結案，也應該要記錄於最近修改者與日期
   LET g_psaa_m.psaamodid = g_user   
   LET g_psaa_m.psaamoddt = cl_get_current()
   UPDATE psaa_t 
      SET psaamodid = g_psaa_m.psaamodid,
          psaamoddt = g_psaa_m.psaamoddt
    WHERE psaaent = g_enterprise
      AND psaadocno = g_psaa_m.psaadocno
   #160729-00074#1-add-(E)
END FUNCTION

PRIVATE FUNCTION apst300_single_unclosed()
DEFINE l_cnt  LIKE type_t.num5

   IF cl_null(l_ac) OR l_ac = 0 THEN 
      RETURN
   END IF
   IF g_psab_d[l_ac].psab008 = 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00041'
      LET g_errparam.extend = g_psab_d[l_ac].psab008
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF   
   UPDATE psab_t 
      SET psab008 = 'N' 
    WHERE psabent = g_enterprise
      AND psabdocno = g_psaa_m.psaadocno
      AND psabseq = g_psab_d[l_ac].psabseq
   
   IF g_psaa_m.psaastus = 'C' THEN    
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM psab_t
       WHERE psabent = g_enterprise
         AND psabdocno = g_psaa_m.psaadocno
         AND psab008 <> 'Y'
      IF l_cnt > 0 THEN 
         UPDATE psaa_t 
            SET psaastus = 'Y' 
          WHERE psaaent = g_enterprise
            AND psaadocno = g_psaa_m.psaadocno
      END IF
   END IF  
   #160729-00074#1-add-(S)
   #資料做結案與取消結案，也應該要記錄於最近修改者與日期
   LET g_psaa_m.psaamodid = g_user   
   LET g_psaa_m.psaamoddt = cl_get_current()
   UPDATE psaa_t 
      SET psaamodid = g_psaa_m.psaamodid,
          psaamoddt = g_psaa_m.psaamoddt
    WHERE psaaent = g_enterprise
      AND psaadocno = g_psaa_m.psaadocno   
   #160729-00074#1-add-(E)   
END FUNCTION

PRIVATE FUNCTION apst300_imaa005_exists()
DEFINE l_imaa005  LIKE imaa_t.imaa005
   IF NOT cl_null(g_psab_d[l_ac].psab001) THEN
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 =  g_psab_d[l_ac].psab001
      IF cl_null(l_imaa005) THEN
         RETURN FALSE
      END IF
   ELSE
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apst300_psab001_ref()
   LET g_psab_d[l_ac].psab002 = ''
   LET g_psab_d[l_ac].psab004 = ''
   SELECT imaf053 INTO g_psab_d[l_ac].psab004 
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_psaa_m.psaasite
      AND imaf001 =  g_psab_d[l_ac].psab001
    
END FUNCTION

################################################################################
# Descriptions...: #檢查料號+BOM特性是否存在當前據點BOM中
# Memo...........:
# Usage..........: CALL apst300_psab012_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/02/19 By dorislai(160214-00005#4)
# Modify.........:
################################################################################
PRIVATE FUNCTION apst300_psab012_chk()
   DEFINE r_success LIKE type_t.num5
   DEFINE l_cnt     LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt
     FROM bmaa_t
    WHERE bmaaent = g_enterprise 
      AND bmaasite = g_site 
      AND bmaa001 = g_psab_d[l_ac].psab001
      AND bmaa002 = g_psab_d[l_ac].psab012
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
   
   
END FUNCTION

################################################################################
# Descriptions...: 單頭複製，說明欄位的顯示
# Memo...........:
# Usage..........: CALL apst300_reproduce_show()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/03/24 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apst300_reproduce_show()
   CALL apst300_psaa001_desc()
   CALL apst300_psaa002_desc()
   
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psaa_m.psaaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaaownid_desc
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psaa_m.psaaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaaowndp_desc
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psaa_m.psaacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaacrtid_desc
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psaa_m.psaacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaacrtdp_desc
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psaa_m.psaamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psaa_m.psaamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psaa_m.psaamodid_desc
END FUNCTION

 
{</section>}
 
