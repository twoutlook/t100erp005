#該程式未解開Section, 採用最新樣板產出!
{<section id="apmm100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-11-24 09:56:48), PR版次:0003(2017-02-22 12:46:41)
#+ Customerized Version.: SD版次:0002(2017-04-10 13:51:51), PR版次:0003(2017-04-13 13:15:20)
#+ Build......: 000643
#+ Filename...: apmm100
#+ Description: 交易對象維護作業
#+ Creator....: 02294(2013-09-02 10:34:48)
#+ Modifier...: 04441 -SD/PR- 02294
 
{</section>}
 
{<section id="apmm100.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150922-00020#3   15/10/02   By Alberti   axmm200有UPDATE時，資料一併同步至axmm201 
#160318-00005#34  16/03/18   By Hans  將重複內容的錯誤訊息置換為公用錯誤訊息
#160409-00005#1   16/04/11   By catmoon 在apmm200輸入pmaa001已經存在，詢問後將資料UPDATE成"3.交易對象"，須將g_master_insert設定為TURE
#160418-00001#1   16/04/19   By catmoon 法人類型(pmaa04)不為1時，開放所屬法人(pmaa05)修改，但不須清空
#160318-00025#37  16/04/20   By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160509-00018#1   16/05/09   By fengmy  开窗条件未清空，导致后续开窗带有前一开窗的条件
#160524-00014#1   16/06/01   By lixiang [信用額度設置]，[C:額度計算幣別]開窗是查詢狀態，導致無法挑選帶值回欄位
#160524-00018#1   16/06/08   By lixiang 修正查询、录入状态下，开窗时状态不对的问题
#160620-00004#4   16/06/24   By dorislai axmm200新增時，pmaa230客戶性質這個欄位值須為1:直接客戶
#160701-00017#1   16/07/05   By lixiang 修正新增客户资料，若输入的编号是交易对象的供应商编号，有提示apm-00578 是否为同一交易对象，若选择“否”，可以继续录入资料，插入资料库报错的问题
#160817-00008#1   16/08/17   By yuanqy  隐藏对公否栏位
#160816-00068#15  16/08/22   By earl    調整transaction
#160818-00017#25  2016-08-30 By 08734   删除修改未重新判断状态码
#160818-00017#47  2016/09/01 By lixiang 审核之后可以修改
#160920-00003#1   2016/09/21 By fionchen 新增時將主要的收款條件預設為apmm101裡的慣用收款條件
#161124-00048#8   2016/12/13 By zhujing .*整批调整
#161230-00036#1   2017/01/05 By 08729   增加統一發票檢核
#170216-00073#1   2017/02/17 By dujuan   pmaa001为空的时候，此時維護供應商簡稱, 並沒有跳出 存在相同的簡稱 是否為同一個交易對象
#170222-00019#1   2017/02/22 By lixiang 在apmm200  統編檢核, 改成警訊 不要限制錯誤不可輸入
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
IMPORT FGL apm_apmm100_01
IMPORT FGL apm_apmm100_02
IMPORT FGL apm_apmm100_03
IMPORT FGL apm_apmm100_05
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmaa_m        RECORD
       pmaa001 LIKE pmaa_t.pmaa001, 
   pmaa002 LIKE pmaa_t.pmaa002, 
   pmaal004 LIKE pmaal_t.pmaal004, 
   pmaal003 LIKE pmaal_t.pmaal003, 
   pmaal006 LIKE pmaal_t.pmaal006, 
   pmaal005 LIKE pmaal_t.pmaal005, 
   pmaa003 LIKE pmaa_t.pmaa003, 
   pmaastus LIKE pmaa_t.pmaastus, 
   pmaa004 LIKE pmaa_t.pmaa004, 
   pmaa005 LIKE pmaa_t.pmaa005, 
   pmaa005_desc LIKE type_t.chr80, 
   pmaa006 LIKE pmaa_t.pmaa006, 
   pmaa006_desc LIKE type_t.chr80, 
   pmaa007 LIKE pmaa_t.pmaa007, 
   pmaa007_desc LIKE type_t.chr80, 
   pmaa008 LIKE pmaa_t.pmaa008, 
   pmaa009 LIKE pmaa_t.pmaa009, 
   pmaa009_desc LIKE type_t.chr80, 
   pmaa010 LIKE pmaa_t.pmaa010, 
   pmaa011 LIKE pmaa_t.pmaa011, 
   pmaa011_desc LIKE type_t.chr80, 
   pmaa230 LIKE pmaa_t.pmaa230, 
   pmaaud001 LIKE pmaa_t.pmaaud001, 
   pmaaud002 LIKE pmaa_t.pmaaud002, 
   pmaa017 LIKE pmaa_t.pmaa017, 
   pmaa016 LIKE pmaa_t.pmaa016, 
   pmaa018 LIKE pmaa_t.pmaa018, 
   pmaa019 LIKE pmaa_t.pmaa019, 
   pmaa019_desc LIKE type_t.chr80, 
   pmaa021 LIKE pmaa_t.pmaa021, 
   pmaa022 LIKE pmaa_t.pmaa022, 
   pmaa022_desc LIKE type_t.chr80, 
   pmaa020 LIKE pmaa_t.pmaa020, 
   pmaa023 LIKE pmaa_t.pmaa023, 
   pmaa023_desc LIKE type_t.chr80, 
   pmaa024 LIKE pmaa_t.pmaa024, 
   pmaa024_desc LIKE type_t.chr80, 
   pmaa025 LIKE pmaa_t.pmaa025, 
   pmaa026 LIKE pmaa_t.pmaa026, 
   pmaa026_desc LIKE type_t.chr80, 
   pmaa098 LIKE pmaa_t.pmaa098, 
   pmaa028 LIKE pmaa_t.pmaa028, 
   pmaa029 LIKE pmaa_t.pmaa029, 
   pmaa090 LIKE pmaa_t.pmaa090, 
   pmaa090_desc LIKE type_t.chr80, 
   pmaa091 LIKE pmaa_t.pmaa091, 
   pmaa091_desc LIKE type_t.chr80, 
   pmaa092 LIKE pmaa_t.pmaa092, 
   pmaa094 LIKE pmaa_t.pmaa094, 
   pmaa094_desc LIKE type_t.chr80, 
   pmaa093 LIKE pmaa_t.pmaa093, 
   pmaa093_desc LIKE type_t.chr80, 
   pmaa095 LIKE pmaa_t.pmaa095, 
   pmaa095_desc LIKE type_t.chr80, 
   pmaa096 LIKE pmaa_t.pmaa096, 
   pmaa096_desc LIKE type_t.chr80, 
   pmaa097 LIKE pmaa_t.pmaa097, 
   pmaa097_desc LIKE type_t.chr80, 
   pmaa080 LIKE pmaa_t.pmaa080, 
   pmaa080_desc LIKE type_t.chr80, 
   pmaa081 LIKE pmaa_t.pmaa081, 
   pmaa081_desc LIKE type_t.chr80, 
   pmaa082 LIKE pmaa_t.pmaa082, 
   pmaa084 LIKE pmaa_t.pmaa084, 
   pmaa084_desc LIKE type_t.chr80, 
   pmaa083 LIKE pmaa_t.pmaa083, 
   pmaa083_desc LIKE type_t.chr80, 
   pmaa085 LIKE pmaa_t.pmaa085, 
   pmaa085_desc LIKE type_t.chr80, 
   pmaa086 LIKE pmaa_t.pmaa086, 
   pmaa086_desc LIKE type_t.chr80, 
   pmaa087 LIKE pmaa_t.pmaa087, 
   pmaa087_desc LIKE type_t.chr80, 
   pmaa088 LIKE pmaa_t.pmaa088, 
   pmaa047 LIKE pmaa_t.pmaa047, 
   pmaa037 LIKE pmaa_t.pmaa037, 
   pmaa036 LIKE pmaa_t.pmaa036, 
   pmaa038 LIKE pmaa_t.pmaa038, 
   pmaa039 LIKE pmaa_t.pmaa039, 
   pmaa040 LIKE pmaa_t.pmaa040, 
   pmaa041 LIKE pmaa_t.pmaa041, 
   pmaa042 LIKE pmaa_t.pmaa042, 
   pmaa043 LIKE pmaa_t.pmaa043, 
   pmaa044 LIKE pmaa_t.pmaa044, 
   pmaa045 LIKE pmaa_t.pmaa045, 
   pmaa046 LIKE pmaa_t.pmaa046, 
   pmaa068 LIKE pmaa_t.pmaa068, 
   pmaa069 LIKE pmaa_t.pmaa069, 
   pmaa072 LIKE pmaa_t.pmaa072, 
   pmaa070 LIKE pmaa_t.pmaa070, 
   pmaa071 LIKE pmaa_t.pmaa071, 
   pmaa073 LIKE pmaa_t.pmaa073, 
   pmaa051 LIKE pmaa_t.pmaa051, 
   pmaa052 LIKE pmaa_t.pmaa052, 
   pmaa052_desc LIKE type_t.chr80, 
   pmaa053 LIKE pmaa_t.pmaa053, 
   pmaa053_desc LIKE type_t.chr80, 
   pmaa054 LIKE pmaa_t.pmaa054, 
   pmaa054_desc LIKE type_t.chr80, 
   pmaa055 LIKE pmaa_t.pmaa055, 
   pmaa056 LIKE pmaa_t.pmaa056, 
   pmaa057 LIKE pmaa_t.pmaa057, 
   pmaa058 LIKE pmaa_t.pmaa058, 
   pmaa074 LIKE pmaa_t.pmaa074, 
   pmaa059 LIKE pmaa_t.pmaa059, 
   pmaa075 LIKE pmaa_t.pmaa075, 
   pmaa060 LIKE pmaa_t.pmaa060, 
   pmaa061 LIKE pmaa_t.pmaa061, 
   pmaa062 LIKE pmaa_t.pmaa062, 
   pmaa063 LIKE pmaa_t.pmaa063, 
   pmaa064 LIKE pmaa_t.pmaa064, 
   pmaa065 LIKE pmaa_t.pmaa065, 
   pmaa066 LIKE pmaa_t.pmaa066, 
   pmaa067 LIKE pmaa_t.pmaa067, 
   pmaa291 LIKE pmaa_t.pmaa291, 
   pmaa291_desc LIKE type_t.chr80, 
   pmaa292 LIKE pmaa_t.pmaa292, 
   pmaa292_desc LIKE type_t.chr80, 
   pmaa293 LIKE pmaa_t.pmaa293, 
   pmaa293_desc LIKE type_t.chr80, 
   pmaa294 LIKE pmaa_t.pmaa294, 
   pmaa294_desc LIKE type_t.chr80, 
   pmaa295 LIKE pmaa_t.pmaa295, 
   pmaa295_desc LIKE type_t.chr80, 
   pmaa296 LIKE pmaa_t.pmaa296, 
   pmaa296_desc LIKE type_t.chr80, 
   pmaa297 LIKE pmaa_t.pmaa297, 
   pmaa297_desc LIKE type_t.chr80, 
   pmaa298 LIKE pmaa_t.pmaa298, 
   pmaa298_desc LIKE type_t.chr80, 
   pmaa299 LIKE pmaa_t.pmaa299, 
   pmaa299_desc LIKE type_t.chr80, 
   pmaa300 LIKE pmaa_t.pmaa300, 
   pmaa300_desc LIKE type_t.chr80, 
   pmaa281 LIKE pmaa_t.pmaa281, 
   pmaa281_desc LIKE type_t.chr80, 
   pmaa282 LIKE pmaa_t.pmaa282, 
   pmaa282_desc LIKE type_t.chr80, 
   pmaa283 LIKE pmaa_t.pmaa283, 
   pmaa283_desc LIKE type_t.chr80, 
   pmaa284 LIKE pmaa_t.pmaa284, 
   pmaa284_desc LIKE type_t.chr80, 
   pmaa285 LIKE pmaa_t.pmaa285, 
   pmaa285_desc LIKE type_t.chr80, 
   pmaa286 LIKE pmaa_t.pmaa286, 
   pmaa286_desc LIKE type_t.chr80, 
   pmaa287 LIKE pmaa_t.pmaa287, 
   pmaa287_desc LIKE type_t.chr80, 
   pmaa288 LIKE pmaa_t.pmaa288, 
   pmaa288_desc LIKE type_t.chr80, 
   pmaa289 LIKE pmaa_t.pmaa289, 
   pmaa289_desc LIKE type_t.chr80, 
   pmaa290 LIKE pmaa_t.pmaa290, 
   pmaa290_desc LIKE type_t.chr80, 
   ooff013 LIKE type_t.chr500, 
   pmaaownid LIKE pmaa_t.pmaaownid, 
   pmaaownid_desc LIKE type_t.chr80, 
   pmaaowndp LIKE pmaa_t.pmaaowndp, 
   pmaaowndp_desc LIKE type_t.chr80, 
   pmaacrtid LIKE pmaa_t.pmaacrtid, 
   pmaacrtid_desc LIKE type_t.chr80, 
   pmaacrtdp LIKE pmaa_t.pmaacrtdp, 
   pmaacrtdp_desc LIKE type_t.chr80, 
   pmaacrtdt LIKE pmaa_t.pmaacrtdt, 
   pmaamodid LIKE pmaa_t.pmaamodid, 
   pmaamodid_desc LIKE type_t.chr80, 
   pmaamoddt LIKE pmaa_t.pmaamoddt, 
   pmaacnfid LIKE pmaa_t.pmaacnfid, 
   pmaacnfid_desc LIKE type_t.chr80, 
   pmaacnfdt LIKE pmaa_t.pmaacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmae_d        RECORD
       pmae002 LIKE pmae_t.pmae002, 
   pmae002_desc LIKE type_t.chr500, 
   oocq005 LIKE type_t.chr500, 
   pmae003 LIKE pmae_t.pmae003
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmaa001 LIKE pmaa_t.pmaa001,
   b_pmaa001_desc LIKE type_t.chr80,
   b_pmaal003 LIKE type_t.chr80,
   b_pmaal006 LIKE type_t.chr80,
      b_pmaa002 LIKE pmaa_t.pmaa002,
      b_pmaa004 LIKE pmaa_t.pmaa004,
      b_pmaa005 LIKE pmaa_t.pmaa005,
      b_pmaa026 LIKE pmaa_t.pmaa026,
      b_pmaa006 LIKE pmaa_t.pmaa006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_pmae_d2        RECORD
       pmae002_1  LIKE pmae_t.pmae002, 
       oocql004_1 LIKE type_t.chr80, 
       oocq005_1  LIKE type_t.chr80
       END RECORD

DEFINE g_pmae_d2          DYNAMIC ARRAY OF type_g_pmae_d2
DEFINE g_pmae_d2_t        type_g_pmae_d2

DEFINE g_rec_b2              LIKE type_t.num5           
DEFINE l_ac2                 LIKE type_t.num5
DEFINE g_bfill2              LIKE type_t.chr5              #是否刷新單身
DEFINE g_wc3                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc3_table1          STRING

GLOBALS
 TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus,
   oofb001 LIKE oofb_t.oofb001,
   oofb019 LIKE oofb_t.oofb019,
   oofb011 LIKE oofb_t.oofb011,
   oofb008 LIKE oofb_t.oofb008,
   oofb009 LIKE oofb_t.oofb009,
   oofb009_desc LIKE type_t.chr500,
   oofb010 LIKE oofb_t.oofb010,
   oofb012 LIKE oofb_t.oofb012,
   oofb012_desc LIKE type_t.chr500,
   oofb013 LIKE oofb_t.oofb013,
   oofb014 LIKE oofb_t.oofb014,
   oofb014_desc LIKE type_t.chr500,
   oofb015 LIKE oofb_t.oofb015,
   oofb015_desc LIKE type_t.chr500,
   oofb016 LIKE oofb_t.oofb016,
   oofb016_desc LIKE type_t.chr500,
   oofb017 LIKE oofb_t.oofb017,
   oofb022 LIKE oofb_t.oofb022,
   oofb022_desc LIKE type_t.chr500,
   oofb020 LIKE oofb_t.oofb020,
   oofb021 LIKE oofb_t.oofb021,
   oofb018 LIKE oofb_t.oofb018
       END RECORD
DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d

 TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus,
   oofc001 LIKE oofc_t.oofc001,
   oofc008 LIKE oofc_t.oofc008,
   oofc009 LIKE oofc_t.oofc009,
   oofc009_desc LIKE type_t.chr500,
   oofc012 LIKE oofc_t.oofc012,
   oofc010 LIKE oofc_t.oofc010,
   oofc014 LIKE oofc_t.oofc014,
   oofc011 LIKE oofc_t.oofc011,
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d

 TYPE type_g_pmac_d        RECORD
       pmacstus LIKE pmac_t.pmacstus, 
   pmac001 LIKE pmac_t.pmac001, 
   pmac003 LIKE pmac_t.pmac003, 
   pmac004 LIKE pmac_t.pmac004, 
   pmac002 LIKE pmac_t.pmac002, 
   pmac002_desc LIKE type_t.chr500
       END RECORD
DEFINE g_pmaa_d          DYNAMIC ARRAY OF type_g_pmac_d

 TYPE type_g_pmaf_d        RECORD
       pmafstus LIKE pmaf_t.pmafstus, 
   pmaf001 LIKE pmaf_t.pmaf001, 
   pmaf002 LIKE pmaf_t.pmaf002, 
   pmaf002_desc LIKE type_t.chr500, 
   pmaf003 LIKE pmaf_t.pmaf003, 
   pmaf004 LIKE pmaf_t.pmaf004, 
   pmaf008 LIKE pmaf_t.pmaf008, 
   pmaf009 LIKE pmaf_t.pmaf009, 
   pmaf005 LIKE pmaf_t.pmaf005, 
   pmaf007 LIKE pmaf_t.pmaf007, 
   pmaf006 LIKE pmaf_t.pmaf006,
   pmaf010 like pmaf_t.pmaf010   #add by liyan 160706
       END RECORD
DEFINE g_pmaa2_d          DYNAMIC ARRAY OF type_g_pmaf_d

 TYPE type_g_pmad_d        RECORD
       pmadstus LIKE pmad_t.pmadstus, 
   pmad001 LIKE pmad_t.pmad001, 
   pmad002 LIKE pmad_t.pmad002, 
   pmad002_desc LIKE type_t.chr500, 
   pmad003 LIKE pmad_t.pmad003, 
   pmad004 LIKE pmad_t.pmad004
       END RECORD
DEFINE g_pmaa3_d          DYNAMIC ARRAY OF type_g_pmad_d

 TYPE type_g_pmad2_d        RECORD
       chk LIKE type_t.chr500, 
   pmad001 LIKE pmad_t.pmad001, 
   pmad002 LIKE pmad_t.pmad002, 
   pmad002_1_desc LIKE type_t.chr500, 
   pmad003 LIKE pmad_t.pmad003, 
   pmad004 LIKE pmad_t.pmad004
       END RECORD
DEFINE g_pmaa5_d          DYNAMIC ARRAY OF type_g_pmad2_d

   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   DEFINE g_wc2_m10001      STRING             #交易夥伴QBE條件
   DEFINE g_d_idx_m10001    LIKE type_t.num5   #交易夥伴所在筆數
   DEFINE g_d_cnt_m10001    LIKE type_t.num5   #聯交易夥伴總筆數
   DEFINE g_wc2_m10002      STRING             #銀行資訊QBE條件
   DEFINE g_d_idx_m10002    LIKE type_t.num5   #銀行資訊所在筆數
   DEFINE g_d_cnt_m10002    LIKE type_t.num5   #銀行資訊總筆數
   DEFINE g_pmaa001_d       LIKE pmaa_t.pmaa001
   DEFINE g_wc2_m10003      STRING              #收款條件QBE條件
   DEFINE g_d_idx_m10003    LIKE type_t.num5    #收款條件所在筆數
   DEFINE g_d_cnt_m10003    LIKE type_t.num5    #收款條件總筆數
   DEFINE g_pmad003_d       LIKE pmad_t.pmad003 #交易類型
   DEFINE g_wc2_m10005      STRING              #付款條件QBE條件
   DEFINE g_d_idx_m10005    LIKE type_t.num5    #付款條件所在筆數
   DEFINE g_d_cnt_m10005    LIKE type_t.num5    #付款條件總筆數
END GLOBALS
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
DEFINE ga_field             DYNAMIC ARRAY OF VARCHAR(500)   #2015/07/02 by stellar add

#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmaa_m          type_g_pmaa_m
DEFINE g_pmaa_m_t        type_g_pmaa_m
DEFINE g_pmaa_m_o        type_g_pmaa_m
DEFINE g_pmaa_m_mask_o   type_g_pmaa_m #轉換遮罩前資料
DEFINE g_pmaa_m_mask_n   type_g_pmaa_m #轉換遮罩後資料
 
   DEFINE g_pmaa001_t LIKE pmaa_t.pmaa001
 
 
DEFINE g_pmae_d          DYNAMIC ARRAY OF type_g_pmae_d
DEFINE g_pmae_d_t        type_g_pmae_d
DEFINE g_pmae_d_o        type_g_pmae_d
DEFINE g_pmae_d_mask_o   DYNAMIC ARRAY OF type_g_pmae_d #轉換遮罩前資料
DEFINE g_pmae_d_mask_n   DYNAMIC ARRAY OF type_g_pmae_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      pmaal001 LIKE pmaal_t.pmaal001,
      pmaal004 LIKE pmaal_t.pmaal004,
      pmaal003 LIKE pmaal_t.pmaal003,
      pmaal006 LIKE pmaal_t.pmaal006,
      pmaal005 LIKE pmaal_t.pmaal005
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
 
{<section id="apmm100.main" >}
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
   CALL cl_ap_init("cpm","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_pmaa_m.pmaa002 = g_argv[1]
   END IF

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmaa001,pmaa002,'','','','',pmaa003,pmaastus,pmaa004,pmaa005,'',pmaa006, 
       '',pmaa007,'',pmaa008,pmaa009,'',pmaa010,pmaa011,'',pmaa230,pmaaud001,pmaaud002,pmaa017,pmaa016, 
       pmaa018,pmaa019,'',pmaa021,pmaa022,'',pmaa020,pmaa023,'',pmaa024,'',pmaa025,pmaa026,'',pmaa098, 
       pmaa028,pmaa029,pmaa090,'',pmaa091,'',pmaa092,pmaa094,'',pmaa093,'',pmaa095,'',pmaa096,'',pmaa097, 
       '',pmaa080,'',pmaa081,'',pmaa082,pmaa084,'',pmaa083,'',pmaa085,'',pmaa086,'',pmaa087,'',pmaa088, 
       pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046, 
       pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa073,pmaa051,pmaa052,'',pmaa053,'',pmaa054,'',pmaa055, 
       pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065, 
       pmaa066,pmaa067,pmaa291,'',pmaa292,'',pmaa293,'',pmaa294,'',pmaa295,'',pmaa296,'',pmaa297,'', 
       pmaa298,'',pmaa299,'',pmaa300,'',pmaa281,'',pmaa282,'',pmaa283,'',pmaa284,'',pmaa285,'',pmaa286, 
       '',pmaa287,'',pmaa288,'',pmaa289,'',pmaa290,'','',pmaaownid,'',pmaaowndp,'',pmaacrtid,'',pmaacrtdp, 
       '',pmaacrtdt,pmaamodid,'',pmaamoddt,pmaacnfid,'',pmaacnfdt", 
                      " FROM pmaa_t",
                      " WHERE pmaaent= ? AND pmaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmm100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmaa001,t0.pmaa002,t0.pmaa003,t0.pmaastus,t0.pmaa004,t0.pmaa005, 
       t0.pmaa006,t0.pmaa007,t0.pmaa008,t0.pmaa009,t0.pmaa010,t0.pmaa011,t0.pmaa230,t0.pmaaud001,t0.pmaaud002, 
       t0.pmaa017,t0.pmaa016,t0.pmaa018,t0.pmaa019,t0.pmaa021,t0.pmaa022,t0.pmaa020,t0.pmaa023,t0.pmaa024, 
       t0.pmaa025,t0.pmaa026,t0.pmaa098,t0.pmaa028,t0.pmaa029,t0.pmaa090,t0.pmaa091,t0.pmaa092,t0.pmaa094, 
       t0.pmaa093,t0.pmaa095,t0.pmaa096,t0.pmaa097,t0.pmaa080,t0.pmaa081,t0.pmaa082,t0.pmaa084,t0.pmaa083, 
       t0.pmaa085,t0.pmaa086,t0.pmaa087,t0.pmaa088,t0.pmaa047,t0.pmaa037,t0.pmaa036,t0.pmaa038,t0.pmaa039, 
       t0.pmaa040,t0.pmaa041,t0.pmaa042,t0.pmaa043,t0.pmaa044,t0.pmaa045,t0.pmaa046,t0.pmaa068,t0.pmaa069, 
       t0.pmaa072,t0.pmaa070,t0.pmaa071,t0.pmaa073,t0.pmaa051,t0.pmaa052,t0.pmaa053,t0.pmaa054,t0.pmaa055, 
       t0.pmaa056,t0.pmaa057,t0.pmaa058,t0.pmaa074,t0.pmaa059,t0.pmaa075,t0.pmaa060,t0.pmaa061,t0.pmaa062, 
       t0.pmaa063,t0.pmaa064,t0.pmaa065,t0.pmaa066,t0.pmaa067,t0.pmaa291,t0.pmaa292,t0.pmaa293,t0.pmaa294, 
       t0.pmaa295,t0.pmaa296,t0.pmaa297,t0.pmaa298,t0.pmaa299,t0.pmaa300,t0.pmaa281,t0.pmaa282,t0.pmaa283, 
       t0.pmaa284,t0.pmaa285,t0.pmaa286,t0.pmaa287,t0.pmaa288,t0.pmaa289,t0.pmaa290,t0.pmaaownid,t0.pmaaowndp, 
       t0.pmaacrtid,t0.pmaacrtdp,t0.pmaacrtdt,t0.pmaamodid,t0.pmaamoddt,t0.pmaacnfid,t0.pmaacnfdt,t1.pmaal004 , 
       t2.oocql004 ,t3.oocgl003 ,t4.ooall004 ,t5.ooail003 ,t6.ooail003 ,t7.ooail003 ,t8.oocql004 ,t9.oocql004 , 
       t10.oocql004 ,t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.oocql004 ,t15.ooefl003 ,t16.ooag011 , 
       t17.ooefl003 ,t18.oocql004 ,t19.oocql004 ,t20.oocql004 ,t21.oocql004 ,t22.ooefl003 ,t23.ooag011 , 
       t24.ooefl003 ,t25.pmaal004 ,t26.xmajl003 ,t27.ooail003 ,t28.oocql004 ,t29.oocql004 ,t30.oocql004 , 
       t31.oocql004 ,t32.oocql004 ,t33.oocql004 ,t34.oocql004 ,t35.oocql004 ,t36.oocql004 ,t37.oocql004 , 
       t38.oocql004 ,t39.oocql004 ,t40.oocql004 ,t41.oocql004 ,t42.oocql004 ,t43.oocql004 ,t44.oocql004 , 
       t45.oocql004 ,t46.oocql004 ,t47.oocql004 ,t48.ooag011 ,t49.ooefl003 ,t50.ooag011 ,t51.ooefl003 , 
       t52.ooag011 ,t53.ooag011",
               " FROM pmaa_t t0",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmaa005 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='261' AND t2.oocql002=t0.pmaa006 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t3 ON t3.oocglent="||g_enterprise||" AND t3.oocgl001=t0.pmaa007 AND t3.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t4 ON t4.ooallent="||g_enterprise||" AND t4.ooall001='4' AND t4.ooall002=t0.pmaa009 AND t4.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t5 ON t5.ooailent="||g_enterprise||" AND t5.ooail001=t0.pmaa011 AND t5.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t6 ON t6.ooailent="||g_enterprise||" AND t6.ooail001=t0.pmaa019 AND t6.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t7 ON t7.ooailent="||g_enterprise||" AND t7.ooail001=t0.pmaa022 AND t7.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='254' AND t8.oocql002=t0.pmaa023 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='260' AND t9.oocql002=t0.pmaa024 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='250' AND t10.oocql002=t0.pmaa026 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='281' AND t11.oocql002=t0.pmaa090 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='283' AND t12.oocql002=t0.pmaa091 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='286' AND t13.oocql002=t0.pmaa094 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t14 ON t14.oocqlent="||g_enterprise||" AND t14.oocql001='285' AND t14.oocql002=t0.pmaa093 AND t14.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.pmaa095 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.pmaa096  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.pmaa097 AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='251' AND t18.oocql002=t0.pmaa080 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='253' AND t19.oocql002=t0.pmaa081 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t20 ON t20.oocqlent="||g_enterprise||" AND t20.oocql001='256' AND t20.oocql002=t0.pmaa084 AND t20.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t21 ON t21.oocqlent="||g_enterprise||" AND t21.oocql001='255' AND t21.oocql002=t0.pmaa083 AND t21.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t22 ON t22.ooeflent="||g_enterprise||" AND t22.ooefl001=t0.pmaa085 AND t22.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t23 ON t23.ooagent="||g_enterprise||" AND t23.ooag001=t0.pmaa086  ",
               " LEFT JOIN ooefl_t t24 ON t24.ooeflent="||g_enterprise||" AND t24.ooefl001=t0.pmaa087 AND t24.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t25 ON t25.pmaalent="||g_enterprise||" AND t25.pmaal001=t0.pmaa052 AND t25.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xmajl_t t26 ON t26.xmajlent="||g_enterprise||" AND t26.xmajl001=t0.pmaa053 AND t26.xmajl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t27 ON t27.ooailent="||g_enterprise||" AND t27.ooail001=t0.pmaa054 AND t27.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t28 ON t28.oocqlent="||g_enterprise||" AND t28.oocql001='2061' AND t28.oocql002=t0.pmaa291 AND t28.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t29 ON t29.oocqlent="||g_enterprise||" AND t29.oocql001='2061' AND t29.oocql002=t0.pmaa292 AND t29.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t30 ON t30.oocqlent="||g_enterprise||" AND t30.oocql001='2063' AND t30.oocql002=t0.pmaa293 AND t30.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t31 ON t31.oocqlent="||g_enterprise||" AND t31.oocql001='2064' AND t31.oocql002=t0.pmaa294 AND t31.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t32 ON t32.oocqlent="||g_enterprise||" AND t32.oocql001='2065' AND t32.oocql002=t0.pmaa295 AND t32.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t33 ON t33.oocqlent="||g_enterprise||" AND t33.oocql001='2066' AND t33.oocql002=t0.pmaa296 AND t33.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t34 ON t34.oocqlent="||g_enterprise||" AND t34.oocql001='2067' AND t34.oocql002=t0.pmaa297 AND t34.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t35 ON t35.oocqlent="||g_enterprise||" AND t35.oocql001='2068' AND t35.oocql002=t0.pmaa298 AND t35.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t36 ON t36.oocqlent="||g_enterprise||" AND t36.oocql001='2069' AND t36.oocql002=t0.pmaa299 AND t36.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t37 ON t37.oocqlent="||g_enterprise||" AND t37.oocql001='2070' AND t37.oocql002=t0.pmaa300 AND t37.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t38 ON t38.oocqlent="||g_enterprise||" AND t38.oocql001='2037' AND t38.oocql002=t0.pmaa281 AND t38.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t39 ON t39.oocqlent="||g_enterprise||" AND t39.oocql001='2038' AND t39.oocql002=t0.pmaa282 AND t39.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t40 ON t40.oocqlent="||g_enterprise||" AND t40.oocql001='2039' AND t40.oocql002=t0.pmaa283 AND t40.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t41 ON t41.oocqlent="||g_enterprise||" AND t41.oocql001='2040' AND t41.oocql002=t0.pmaa284 AND t41.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t42 ON t42.oocqlent="||g_enterprise||" AND t42.oocql001='2041' AND t42.oocql002=t0.pmaa285 AND t42.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t43 ON t43.oocqlent="||g_enterprise||" AND t43.oocql001='2042' AND t43.oocql002=t0.pmaa286 AND t43.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t44 ON t44.oocqlent="||g_enterprise||" AND t44.oocql001='2043' AND t44.oocql002=t0.pmaa287 AND t44.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t45 ON t45.oocqlent="||g_enterprise||" AND t45.oocql001='2044' AND t45.oocql002=t0.pmaa288 AND t45.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t46 ON t46.oocqlent="||g_enterprise||" AND t46.oocql001='2045' AND t46.oocql002=t0.pmaa289 AND t46.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t47 ON t47.oocqlent="||g_enterprise||" AND t47.oocql001='2046' AND t47.oocql002=t0.pmaa290 AND t47.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t48 ON t48.ooagent="||g_enterprise||" AND t48.ooag001=t0.pmaaownid  ",
               " LEFT JOIN ooefl_t t49 ON t49.ooeflent="||g_enterprise||" AND t49.ooefl001=t0.pmaaowndp AND t49.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t50 ON t50.ooagent="||g_enterprise||" AND t50.ooag001=t0.pmaacrtid  ",
               " LEFT JOIN ooefl_t t51 ON t51.ooeflent="||g_enterprise||" AND t51.ooefl001=t0.pmaacrtdp AND t51.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t52 ON t52.ooagent="||g_enterprise||" AND t52.ooag001=t0.pmaamodid  ",
               " LEFT JOIN ooag_t t53 ON t53.ooagent="||g_enterprise||" AND t53.ooag001=t0.pmaacnfid  ",
 
               " WHERE t0.pmaaent = " ||g_enterprise|| " AND t0.pmaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmm100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmm100 WITH FORM cl_ap_formpath("cpm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmm100_init()   
 
      #進入選單 Menu (="N")
      CALL apmm100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi390_drop_tmp_table()  #150427 by whitney add for 增加編碼功能
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmm100
      
   END IF 
   
   CLOSE apmm100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmm100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmm100_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE  l_str    STRING
   DEFINE  l_sql    STRING
   DEFINE  l_gzcb002   LIKE gzcb_t.gzcb002
   DEFINE  l_success   LIKE type_t.num5     #150427 by whitney add for 增加編碼功能
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
      CALL cl_set_combo_scc_part('pmaastus','50','N,Y,X')
 
      CALL cl_set_combo_scc('pmaa002','2014') 
   CALL cl_set_combo_scc('pmaa004','2015') 
   CALL cl_set_combo_scc('pmaa010','25') 
   CALL cl_set_combo_scc('pmaa092','2040') 
   CALL cl_set_combo_scc('pmaa082','2011') 
   CALL cl_set_combo_scc('pmaa037','2012') 
   CALL cl_set_combo_scc('pmaa073','8312') 
   CALL cl_set_combo_scc('pmaa051','2033') 
   CALL cl_set_combo_scc('pmaa061','2034') 
   CALL cl_set_combo_scc('pmaa063','2034') 
   CALL cl_set_combo_scc('pmaa065','2034') 
   CALL cl_set_combo_scc('pmaa067','2034') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pmaa230','6018')  #160620-00004#4-add
   LET l_ac2 = 1 #第二單身指標  #add by lixiang 2015/10/26
   
   #---str---add by qianyuan170411---#20170331-00003
   IF g_prog='axmm200' THEN 
      CALL cl_set_comp_visible('pmaaud001,pmaaud002',TRUE)
   ELSE 
      CALL cl_set_comp_visible('pmaaud001,pmaaud002',FALSE)
   END IF 
   #---end---add by qianyuan170411---#20170331-00003
   #add by yangxb 170413 start#######################客户基础资料显示名称
   IF g_prog='axmm200' THEN 
      CALL cl_set_comp_att_text('pmaa038','对账日期')
      CALL cl_set_comp_att_text('pmaa041','发票截止日')
      CALL cl_set_comp_att_text('pmaa044','客户付款日期')
   END IF 
   #add by yangxb 170413  end ########################
   
   #系統應用欄位一(azzi600中的gzcb003栏位)為Y的才進選單
   LET l_sql = " SELECT gzcb002 FROM gzcb_t ",
               "  WHERE gzcb001 = '8312'",
               "    AND gzcb003 = 'Y'"
   PREPARE apmm100_gzcb002 FROM l_sql
   DECLARE apmm100_gzcb002_curs CURSOR FOR apmm100_gzcb002 
   LET l_str = ''
   FOREACH apmm100_gzcb002_curs INTO l_gzcb002 
      IF cl_null(l_str) THEN
         LET l_str = l_gzcb002
      ELSE
         LET l_str = l_str,",",l_gzcb002 
      END IF
   END FOREACH 
   CALL cl_set_combo_scc_part('pmaa073','8312',l_str)
   
   #功能不完善，先隱藏
   CALL cl_set_comp_visible("group7",FALSE)
   
   CALL cl_set_combo_scc('b_pmaa002','2014') 
   IF NOT cl_null(g_argv[1]) THEN
      CASE g_argv[1] 
         WHEN '1' CALL cl_set_combo_scc_part('pmaa002','2014','1,3')
         WHEN '2' CALL cl_set_combo_scc_part('pmaa002','2014','2,3')
         WHEN '3' CALL cl_set_combo_scc('pmaa002','2014')
      END CASE
   END IF
   CALL cl_set_combo_scc('b_pmaa004','2015') 
   
   CALL apmm100_set_visible()
   
   #隱藏之前單身嵌入功能未實現時，添加的action的操作
   CALL cl_set_toolbaritem_visible("aooi350_01,aooi350_02,apmm100_01,apmm100_02,apmm100_03,apmm100_03_1",FALSE)
   
   LET g_bfill2 = "Y"
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_contact", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_communication", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmm100_01"), "grid_friends", "Table", "s_detail1_apmm100_01")
   CALL cl_set_combo_scc('pmac003','2013')   #交易類型
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmm100_02"), "grid_bank", "Table", "s_detail1_apmm100_02")
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmm100_03"), "grid_receivable", "Table", "s_detail1_apmm100_03")
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmm100_05"), "grid_pay", "Table", "s_detail1_apmm100_05")

   CALL s_aooi390_cre_tmp_table() RETURNING l_success  #150427 by whitney add for 增加編碼功能

   #判斷據點參數aoos020參數使用EC時才顯示，不使用要隱藏(據點參數:S-SYS-0002)
   IF cl_get_para(g_enterprise,g_site,'S-SYS-0002') = 'N' THEN
      CALL cl_set_comp_visible("pmaa098",FALSE)
   END IF
   CALL cl_set_comp_visible("pmaf010",FALSE)  #160817-00008#1   by 08172
   #end add-point
   
   #初始化搜尋條件
   CALL apmm100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmm100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmm100_ui_dialog()
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
   DEFINE l_pmaa027 LIKE pmaa_t.pmaa027
   DEFINE l_cmd     STRING
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
            CALL apmm100_insert()
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
         INITIALIZE g_pmaa_m.* TO NULL
         CALL g_pmae_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmm100_init()
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
               
               CALL apmm100_fetch('') # reload data
               LET l_ac = 1
               CALL apmm100_ui_detailshow() #Setting the current row 
         
               CALL apmm100_idx_chk()
               #NEXT FIELD pmae002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmae_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmm100_idx_chk()
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
               CALL apmm100_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_pmae_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
         
            BEFORE ROW
               CALL apmm100_idx_chk()
			   LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               CALL apmm100_idx_chk()
               LET g_current_page = 1
               
         END DISPLAY
         #通訊地址單身顯示
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         #聯絡方式單身顯示
         SUBDIALOG aoo_aooi350_02.aooi350_02_display
         #交易夥伴單身顯示
         SUBDIALOG apm_apmm100_01.apmm100_01_display
         #銀行資訊單身顯示
         SUBDIALOG apm_apmm100_02.apmm100_02_display
         #收款條件單身顯示
         SUBDIALOG apm_apmm100_03.apmm100_03_display
         #付款條件單身顯示
         SUBDIALOG apm_apmm100_05.apmm100_05_display
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmm100_browser_fill("")
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
               CALL apmm100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmm100_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmm100_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
         ON ACTION cust_page
            LET g_detail_id = "cust_page"
            NEXT FIELD pmae002
         ON ACTION supplier_page
            LET g_detail_id = "supplier_page"
            NEXT FIELD pmae002_1
         ON ACTION cont_page
            LET g_detail_id = "cont_page"
            NEXT FIELD oofbstus
         ON ACTION comm_page
            LET g_detail_id = "comm_page"
            NEXT FIELD oofcstus
         ON ACTION friends_page
            LET g_detail_id = "friends_page"
            NEXT FIELD pmacstus
         ON ACTION bank_page
            LET g_detail_id = "bank_page"
            NEXT FIELD pmafstus
         ON ACTION receivable_page
            LET g_detail_id = "receivable_page"
            NEXT FIELD pmad001_2 
         ON ACTION pay_page
            LET g_detail_id = "pay_page"
            NEXT FIELD pmad001_1       
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmm100_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmm100_set_act_visible()   
            CALL apmm100_set_act_no_visible()
            IF NOT (g_pmaa_m.pmaa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmaaent = " ||g_enterprise|| " AND",
                                  " pmaa001 = '", g_pmaa_m.pmaa001, "' "
 
               #填到對應位置
               CALL apmm100_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmae_t" 
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
               CALL apmm100_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "pmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmae_t" 
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
                  CALL apmm100_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmm100_fetch("F")
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
               CALL apmm100_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmm100_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmm100_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmm100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmm100_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmm100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmm100_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmm100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmm100_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmm100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmm100_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmae_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_pmba_d)
                  LET g_export_id[2]   = "s_detail1_aooi350_01"
                  LET g_export_node[3] = base.typeInfo.create(g_pmba2_d)
                  LET g_export_id[3]   = "s_detail1_aooi350_02"
                  LET g_export_node[4] = base.typeInfo.create(g_pmaa_d)
                  LET g_export_id[4]   = "s_detail1_apmm100_01"
                  LET g_export_node[5] = base.typeInfo.create(g_pmaa2_d)
                  LET g_export_id[5]   = "s_detail1_apmm100_02"
                  LET g_export_node[6] = base.typeInfo.create(g_pmaa3_d)
                  LET g_export_id[6]   = "s_detail1_apmm100_03"
                  LET g_export_node[7] = base.typeInfo.create(g_pmaa5_d)
                  LET g_export_id[7]   = "s_detail1_apmm100_05"                        
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
               NEXT FIELD pmae002
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
         ON ACTION apmm100_02
            LET g_action_choice="apmm100_02"
            IF cl_auth_chk_act("apmm100_02") THEN
               
               #add-point:ON ACTION apmm100_02 name="menu.apmm100_02"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_02(g_pmaa_m.pmaa001)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL apmm100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmm100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmm101_1
            LET g_action_choice="open_apmm101_1"
            IF cl_auth_chk_act("open_apmm101_1") THEN
               
               #add-point:ON ACTION open_apmm101_1 name="menu.open_apmm101_1"
               #非集團層的據點資料維護
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CASE g_argv[1]
                     WHEN '1' #LET l_cmd = "apmm202 '"||g_site||"' '"||g_pmaa_m.pmaa001||"'"   
                              LET la_param.prog = 'apmm202'
                              LET la_param.param[1] = g_site
                              LET la_param.param[2] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )                     
                     WHEN '2' #LET l_cmd = "axmm202 '"||g_site||"' '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'axmm202'
                              LET la_param.param[1] = g_site
                              LET la_param.param[2] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param ) 
                     WHEN '3' #LET l_cmd = "apmm102 '"||g_site||"' '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'apmm102'
                              LET la_param.param[1] = g_site
                              LET la_param.param[2] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )
                  END CASE
                  #CALL cl_cmdrun_wait(l_cmd)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION edsz
            LET g_action_choice="edsz"
            IF cl_auth_chk_act("edsz") THEN
               
               #add-point:ON ACTION edsz name="menu.edsz"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_edsz()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmm101
            LET g_action_choice="open_apmm101"
            IF cl_auth_chk_act("open_apmm101") THEN
               
               #add-point:ON ACTION open_apmm101 name="menu.open_apmm101"
               #'ALL'集團層的據點資料維護
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CASE g_argv[1]
                     WHEN '1' #LET l_cmd = "apmm201 '"||g_pmaa_m.pmaa001||"'"    
                              LET la_param.prog = 'apmm201'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )                     
                     WHEN '2' #LET l_cmd = "axmm201 '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'axmm201'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param ) 
                     WHEN '3' #LET l_cmd = "apmm101 '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'apmm101'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param ) 
                  END CASE
                  #CALL cl_cmdrun_wait(l_cmd)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmm100_04
            LET g_action_choice="apmm100_04"
            IF cl_auth_chk_act("apmm100_04") THEN
               
               #add-point:ON ACTION apmm100_04 name="menu.apmm100_04"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN              
                  CALL apmm100_04(g_pmaa_m.pmaa001)
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmm100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmm100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="menu.open_s_carry_query"
               #2015/07/02 by stellar add ----- (S)
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET ga_field[1] = g_pmaa_m.pmaa001
                  CALL s_carry_query('3',ga_field)
               END IF
               #2015/07/02 by stellar add ----- (E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmm100_01
            LET g_action_choice="apmm100_01"
            IF cl_auth_chk_act("apmm100_01") THEN
               
               #add-point:ON ACTION apmm100_01 name="menu.apmm100_01"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_01(g_pmaa_m.pmaa001)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmm100_03
            LET g_action_choice="apmm100_03"
            IF cl_auth_chk_act("apmm100_03") THEN
               
               #add-point:ON ACTION apmm100_03 name="menu.apmm100_03"
               #收款條件
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_03(g_pmaa_m.pmaa001,'2')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmm100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmm100_03_1
            LET g_action_choice="apmm100_03_1"
            IF cl_auth_chk_act("apmm100_03_1") THEN
               
               #add-point:ON ACTION apmm100_03_1 name="menu.apmm100_03_1"
               #付款條件
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_03(g_pmaa_m.pmaa001,'1')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmm100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu.aooi350_01"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                  CALL aooi350_01(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu.aooi350_02"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                  CALL aooi350_02(l_pmaa027)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmi005
            LET g_action_choice="open_apmi005"
            IF cl_auth_chk_act("open_apmi005") THEN
               
               #add-point:ON ACTION open_apmi005 name="menu.open_apmi005"
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CASE g_pmaa_m.pmaa002
                     WHEN '1' #LET l_cmd = "apmi100 '"||g_pmaa_m.pmaa001||"'" 
                              LET la_param.prog = 'apmi100'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )                      
                     WHEN '2' #LET l_cmd = "axmi100 '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'axmi100'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )
                     WHEN '3' #LET l_cmd = "apmi005 '"||g_pmaa_m.pmaa001||"'"
                              LET la_param.prog = 'apmi005'
                              LET la_param.param[1] = g_pmaa_m.pmaa001
                              LET ls_js = util.JSON.stringify( la_param )
                  END CASE
                  #CALL cl_cmdrun_wait(l_cmd)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unvoid
            LET g_action_choice="unvoid"
            IF cl_auth_chk_act("unvoid") THEN
               
               #add-point:ON ACTION unvoid name="menu.unvoid"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmm100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmm100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmm100_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="apmm100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmm100_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_wc3             STRING
   DEFINE l_sql1            STRING
   DEFINE l_sql2            STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
      CALL apmm100_01_clear_detail()   #清除交易夥伴
      CALL apmm100_02_clear_detail()   #清除銀行資訊
      CALL apmm100_03_clear_detail()   #清除收款條件
      CALL apmm100_05_clear_detail()   #清除付款條件
      CALL g_pmae_d2.clear()
   END IF
   
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
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET l_wc3 = g_wc3.trim()  #供應商標籤頁簽的查詢條件
   
   #IF NOT cl_null(g_argv[1]) THEN
   #   CASE g_argv[1] 
   #      WHEN '1' LET l_wc = l_wc," AND (pmaa002 = '1' OR pmaa002 = '3' ) "
   #      WHEN '2' LET l_wc = l_wc," AND (pmaa002 = '2' OR pmaa002 = '3' ) "
   #   END CASE
   #END IF
   IF NOT cl_null(g_argv[1]) THEN
      CASE g_argv[1] 
         WHEN '1' LET g_wc = g_wc," AND (pmaa002 = '1' OR pmaa002 = '3' ) "
         WHEN '2' LET g_wc = g_wc," AND (pmaa002 = '2' OR pmaa002 = '3' ) "
      END CASE
   END IF
   LET l_wc  = g_wc.trim()
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmaa001 ",
                      " FROM pmaa_t ",
                      " ",
                      " LEFT JOIN pmae_t ON pmaeent = pmaaent AND pmaa001 = pmae001 ", "  ",
                      #add-point:browser_fill段sql(pmae_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN pmaal_t ON pmaalent = "||g_enterprise||" AND pmaa001 = pmaal001 AND pmaal002 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE pmaaent = " ||g_enterprise|| " AND pmaeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmaa001 ",
                      " FROM pmaa_t ", 
                      "  ",
                      "  LEFT JOIN pmaal_t ON pmaalent = "||g_enterprise||" AND pmaa001 = pmaal001 AND pmaal002 = '",g_dlang,"' ",
                      " WHERE pmaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #单身下的条件需加到left join 上
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      IF g_wc3 <> " 1=1" THEN
         #單身有輸入搜尋條件    
         #单身下的条件需加到left join 上      
         LET l_sub_sql = " SELECT UNIQUE pmaa001 ",
   
                           " FROM pmaa_t ",
                           " LEFT JOIN pmaal_t ON pmaaent = pmaalent AND pmaa001 = pmaal001 AND pmaal002 = '",g_lang,"' ", #170216-00073#1--add---pmaaent = pmaalent AND
                           " ,",
                           " pmae_t ",
                          " WHERE pmaeent = pmaaent AND pmaa001 = pmae001 AND ((",l_wc2,") OR ( ",l_wc3,"))",
                          "   AND pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
    
      ELSE
         LET l_sub_sql = " SELECT UNIQUE pmaa001 ",
   
                           " FROM pmaa_t ",
                           " LEFT JOIN pmaal_t ON pmaaent = pmaalent AND pmaa001 = pmaal001 AND pmaal002 = '",g_lang,"' ",  #170216-00073#1--add---pmaaent = pmaalent AND
                           " ,",
                           " pmae_t ",
                          " WHERE pmaeent = pmaaent AND pmaa001 = pmae001 AND ", l_wc2,
                          "   AND pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
      END IF
   ELSE
      IF g_wc3 <> " 1=1" THEN
         #單身有輸入搜尋條件    
         LET l_sub_sql = " SELECT UNIQUE pmaa001 ",
   
                           " FROM pmaa_t ",
                           " LEFT JOIN pmaal_t ON pmaaent = pmaalent AND pmaa001 = pmaal001 AND pmaal002 = '",g_lang,"' ",  #170216-00073#1--add---pmaaent = pmaalent AND
                           " ,",
                           " pmae_t ",
                          " WHERE pmaeent = pmaaent AND pmaa001 = pmae001 AND ", l_wc3,
                          "   AND pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
    
      ELSE
         #單身未輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE pmaa001 ",
         
                           " FROM pmaa_t ",
                           " LEFT JOIN pmaal_t ON pmaaent = pmaalent AND pmaa001 = pmaal001 AND pmaal002 = '",g_lang,"' ",    #170216-00073#1--add---pmaaent = pmaalent AND
                           "WHERE pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
       END IF  
   END IF
   
   #add by lixiang 2015/12/23--begin---
   #嵌入的子作業查詢條件加入到主作業中
   IF NOT cl_null(g_wc2_i35001) AND g_wc2_i35001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa027 IN ( SELECT oofb002 FROM oofb_t WHERE oofbent = '",g_enterprise,"' AND ",g_wc2_i35001 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_i35002) AND g_wc2_i35002 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa027 IN ( SELECT oofc002 FROM oofc_t WHERE oofcent = '",g_enterprise,"' AND ",g_wc2_i35002 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10001) AND g_wc2_m10001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa001 IN ( SELECT pmac001 FROM pmac_t WHERE pmacent = '",g_enterprise,"' AND ",g_wc2_m10001 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10002) AND g_wc2_m10002 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa001 IN ( SELECT pmaf001 FROM pmaf_t WHERE pmafent = '",g_enterprise,"' AND ",g_wc2_m10002 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10003) AND g_wc2_m10003 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa001 IN ( SELECT pmad001 FROM pmad_t WHERE pmadent = '",g_enterprise,"' AND pmad003 = '2' AND ",g_wc2_m10003 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10005) AND g_wc2_m10005 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmaa001 IN ( SELECT pmad001 FROM pmad_t WHERE pmadent = '",g_enterprise,"' AND pmad003 = '1' AND ",g_wc2_m10005 CLIPPED ,")"
   END IF
   #add by lixiang 2015/12/23--end---
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

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
      INITIALIZE g_pmaa_m.* TO NULL
      CALL g_pmae_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026,t0.pmaa006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026, 
          t0.pmaa006,t1.pmaal004 ",
                  " FROM pmaa_t t0",
                  "  ",
                  "  LEFT JOIN pmae_t ON pmaeent = pmaaent AND pmaa001 = pmae001 ", "  ", 
                  #add-point:browser_fill段sql(pmae_t1) name="browser_fill.join.pmae_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.pmaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026, 
          t0.pmaa006,t1.pmaal004 ",
                  " FROM pmaa_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.pmaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照pmaa001,'','',pmaa002,pmaa004,pmaa005,pmaa026,pmaa006 Browser欄位定義(取代原本bs_sql功能)
      IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN 
         LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026,t0.pmaa006,t1.pmaal004 ",
                     " FROM pmaa_t t0",
                     " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_lang||"' ",
                     " ,",
                     " pmae_t ",
                     " WHERE pmaeent = t0.pmaaent AND t0.pmaa001 = pmae001 AND ((",l_wc2,") OR (",l_wc3,"))",
                     "   AND t0.pmaaent = '" ||g_enterprise|| "' AND ",l_wc  CLIPPED, cl_sql_add_filter("pmaa_t")
      ELSE
         LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026,t0.pmaa006,t1.pmaal004 ",
                     " FROM pmaa_t t0",
                     " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_lang||"' ",
                     " ,",
                     " pmae_t ",
                     " WHERE pmaeent = t0.pmaaent AND t0.pmaa001 = pmae001 AND ",l_wc2,
                     "   AND t0.pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
      END IF
   ELSE
      IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN 
         LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026,t0.pmaa006,t1.pmaal004 ",
                     " FROM pmaa_t t0",
                     " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_lang||"' ",
                     " ,",
                     " pmae_t ",
                     " WHERE pmaeent = t0.pmaaent AND t0.pmaa001 = pmae001 AND ",l_wc3,
                     "   AND t0.pmaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
      ELSE
         #單身無輸入資料
         LET g_sql = " SELECT DISTINCT t0.pmaastus,t0.pmaa001,t0.pmaa002,t0.pmaa004,t0.pmaa005,t0.pmaa026,t0.pmaa006,t1.pmaal004 ",
                     " FROM pmaa_t t0",
                     " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.pmaa001 AND t1.pmaal002='"||g_lang||"' ",
                     " WHERE t0.pmaaent = '" ||g_enterprise|| "' AND ", l_wc CLIPPED, cl_sql_add_filter("pmaa_t")
      END IF
   END IF
   
   #add by lixiang 2015/12/23--begin---
   #嵌入的子作業查詢條件加入到主作業中
   IF NOT cl_null(g_wc2_i35001) AND g_wc2_i35001 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa027 IN ( SELECT oofb002 FROM oofb_t WHERE oofbent = '",g_enterprise,"' AND ",g_wc2_i35001 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_i35002) AND g_wc2_i35002 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa027 IN ( SELECT oofc002 FROM oofc_t WHERE oofcent = '",g_enterprise,"' AND ",g_wc2_i35002 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10001) AND g_wc2_m10001 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa001 IN ( SELECT pmac001 FROM pmac_t WHERE pmacent = '",g_enterprise,"' AND ",g_wc2_m10001 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10002) AND g_wc2_m10002 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa001 IN ( SELECT pmaf001 FROM pmaf_t WHERE pmafent = '",g_enterprise,"' AND ",g_wc2_m10002 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10003) AND g_wc2_m10003 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa001 IN ( SELECT pmad001 FROM pmad_t WHERE pmadent = '",g_enterprise,"' AND pmad003 = '2' AND ",g_wc2_m10003 CLIPPED ,")"
   END IF
   
   IF NOT cl_null(g_wc2_m10005) AND g_wc2_m10005 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND t0.pmaa001 IN ( SELECT pmad001 FROM pmad_t WHERE pmadent = '",g_enterprise,"' AND pmad003 = '1' AND ",g_wc2_m10005 CLIPPED ,")"
   END IF
   #add by lixiang 2015/12/23--end---
   
   LET g_sql = g_sql, " ORDER BY pmaa001 ",g_order

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmaa001,g_browser[g_cnt].b_pmaa002, 
          g_browser[g_cnt].b_pmaa004,g_browser[g_cnt].b_pmaa005,g_browser[g_cnt].b_pmaa026,g_browser[g_cnt].b_pmaa006, 
          g_browser[g_cnt].b_pmaa001_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmaa001
      #modify--2015/06/25 By shiun--(S)
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004,pmaal003,pmaal006 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmaa001_desc = '', g_rtn_fields[1] , ''
      LET g_browser[g_cnt].b_pmaal003 = '', g_rtn_fields[2] , ''
      LET g_browser[g_cnt].b_pmaal006 = '', g_rtn_fields[3] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmaa001_desc,g_browser[g_cnt].b_pmaal003,g_browser[g_cnt].b_pmaal006
      #modify--2015/06/25 By shiun--(E)      
         #end add-point
      
         #遮罩相關處理
         CALL apmm100_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_pmaa001) THEN
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
 
{<section id="apmm100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmm100_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmaa_m.pmaa001 = g_browser[g_current_idx].b_pmaa001   
 
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
   CALL apmm100_pmaa_t_mask()
   CALL apmm100_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmm100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmm100_ui_detailshow()
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
 
{<section id="apmm100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmm100_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmaa001 = g_pmaa_m.pmaa001 
 
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
 
{<section id="apmm100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmm100_construct()
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
   INITIALIZE g_pmaa_m.* TO NULL
   CALL g_pmae_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   CALL apmm100_01_clear_detail()   #清除交易夥伴
   CALL apmm100_02_clear_detail()   #清除銀行資訊
   CALL apmm100_03_clear_detail()   #清除收款條件
   CALL apmm100_05_clear_detail()   #清除付款條件
   
   INITIALIZE g_wc3 TO NULL
   
   INITIALIZE g_wc3_table1 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pmaa001,pmaa002,pmaal004,pmaal003,pmaal006,pmaal005,pmaa003,pmaastus, 
          pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa230,pmaaud001,pmaaud002, 
          pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa098, 
          pmaa028,pmaa029,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa097,pmaa080,pmaa081, 
          pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa087,pmaa088,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039, 
          pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071, 
          pmaa073,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075, 
          pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294, 
          pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286, 
          pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdp,pmaacrtdt,pmaamodid, 
          pmaamoddt,pmaacnfid,pmaacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmaacrtdt>>----
         AFTER FIELD pmaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmaamoddt>>----
         AFTER FIELD pmaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmaacnfdt>>----
         AFTER FIELD pmaacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa001
            #add-point:ON ACTION controlp INFIELD pmaa001 name="construct.c.pmaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            IF NOT cl_null(g_argv[1]) THEN
               CASE g_argv[1] 
                  WHEN '1' LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
                  WHEN '2' LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 = '3') "
               END CASE
            END IF
            CALL q_pmaa001_5()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO pmaa001  #顯示到畫面上

            NEXT FIELD pmaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa001
            #add-point:BEFORE FIELD pmaa001 name="construct.b.pmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa001
            
            #add-point:AFTER FIELD pmaa001 name="construct.a.pmaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa002
            #add-point:BEFORE FIELD pmaa002 name="construct.b.pmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa002
            
            #add-point:AFTER FIELD pmaa002 name="construct.a.pmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa002
            #add-point:ON ACTION controlp INFIELD pmaa002 name="construct.c.pmaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal004
            #add-point:BEFORE FIELD pmaal004 name="construct.b.pmaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal004
            
            #add-point:AFTER FIELD pmaal004 name="construct.a.pmaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal004
            #add-point:ON ACTION controlp INFIELD pmaal004 name="construct.c.pmaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal003
            #add-point:BEFORE FIELD pmaal003 name="construct.b.pmaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal003
            
            #add-point:AFTER FIELD pmaal003 name="construct.a.pmaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal003
            #add-point:ON ACTION controlp INFIELD pmaal003 name="construct.c.pmaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal006
            #add-point:BEFORE FIELD pmaal006 name="construct.b.pmaal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal006
            
            #add-point:AFTER FIELD pmaal006 name="construct.a.pmaal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal006
            #add-point:ON ACTION controlp INFIELD pmaal006 name="construct.c.pmaal006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal005
            #add-point:BEFORE FIELD pmaal005 name="construct.b.pmaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal005
            
            #add-point:AFTER FIELD pmaal005 name="construct.a.pmaal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal005
            #add-point:ON ACTION controlp INFIELD pmaal005 name="construct.c.pmaal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa003
            #add-point:BEFORE FIELD pmaa003 name="construct.b.pmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa003
            
            #add-point:AFTER FIELD pmaa003 name="construct.a.pmaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa003
            #add-point:ON ACTION controlp INFIELD pmaa003 name="construct.c.pmaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaastus
            #add-point:BEFORE FIELD pmaastus name="construct.b.pmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaastus
            
            #add-point:AFTER FIELD pmaastus name="construct.a.pmaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaastus
            #add-point:ON ACTION controlp INFIELD pmaastus name="construct.c.pmaastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa004
            #add-point:BEFORE FIELD pmaa004 name="construct.b.pmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa004
            
            #add-point:AFTER FIELD pmaa004 name="construct.a.pmaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa004
            #add-point:ON ACTION controlp INFIELD pmaa004 name="construct.c.pmaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa005
            #add-point:ON ACTION controlp INFIELD pmaa005 name="construct.c.pmaa005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1            
            LET g_qryparam.where = " pmaa004 = '1' "
            CALL q_pmaa001_4()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO pmaa005  #顯示到畫面上

            NEXT FIELD pmaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa005
            #add-point:BEFORE FIELD pmaa005 name="construct.b.pmaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa005
            
            #add-point:AFTER FIELD pmaa005 name="construct.a.pmaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa006
            #add-point:ON ACTION controlp INFIELD pmaa006 name="construct.c.pmaa006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "261"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa006  #顯示到畫面上

            NEXT FIELD pmaa006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa006
            #add-point:BEFORE FIELD pmaa006 name="construct.b.pmaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa006
            
            #add-point:AFTER FIELD pmaa006 name="construct.a.pmaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa007
            #add-point:ON ACTION controlp INFIELD pmaa007 name="construct.c.pmaa007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa007  #顯示到畫面上

            NEXT FIELD pmaa007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa007
            #add-point:BEFORE FIELD pmaa007 name="construct.b.pmaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa007
            
            #add-point:AFTER FIELD pmaa007 name="construct.a.pmaa007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa008
            #add-point:BEFORE FIELD pmaa008 name="construct.b.pmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa008
            
            #add-point:AFTER FIELD pmaa008 name="construct.a.pmaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa008
            #add-point:ON ACTION controlp INFIELD pmaa008 name="construct.c.pmaa008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa009
            #add-point:ON ACTION controlp INFIELD pmaa009 name="construct.c.pmaa009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooal002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa009  #顯示到畫面上

            NEXT FIELD pmaa009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa009
            #add-point:BEFORE FIELD pmaa009 name="construct.b.pmaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa009
            
            #add-point:AFTER FIELD pmaa009 name="construct.a.pmaa009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa010
            #add-point:BEFORE FIELD pmaa010 name="construct.b.pmaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa010
            
            #add-point:AFTER FIELD pmaa010 name="construct.a.pmaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa010
            #add-point:ON ACTION controlp INFIELD pmaa010 name="construct.c.pmaa010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa011
            #add-point:ON ACTION controlp INFIELD pmaa011 name="construct.c.pmaa011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa011  #顯示到畫面上

            NEXT FIELD pmaa011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa011
            #add-point:BEFORE FIELD pmaa011 name="construct.b.pmaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa011
            
            #add-point:AFTER FIELD pmaa011 name="construct.a.pmaa011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa230
            #add-point:BEFORE FIELD pmaa230 name="construct.b.pmaa230"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa230
            
            #add-point:AFTER FIELD pmaa230 name="construct.a.pmaa230"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa230
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa230
            #add-point:ON ACTION controlp INFIELD pmaa230 name="construct.c.pmaa230"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaud001
            #add-point:BEFORE FIELD pmaaud001 name="construct.b.pmaaud001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaud001
            
            #add-point:AFTER FIELD pmaaud001 name="construct.a.pmaaud001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaaud001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaud001
            #add-point:ON ACTION controlp INFIELD pmaaud001 name="construct.c.pmaaud001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaud002
            #add-point:BEFORE FIELD pmaaud002 name="construct.b.pmaaud002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaud002
            
            #add-point:AFTER FIELD pmaaud002 name="construct.a.pmaaud002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaaud002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaud002
            #add-point:ON ACTION controlp INFIELD pmaaud002 name="construct.c.pmaaud002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa017
            #add-point:BEFORE FIELD pmaa017 name="construct.b.pmaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa017
            
            #add-point:AFTER FIELD pmaa017 name="construct.a.pmaa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa017
            #add-point:ON ACTION controlp INFIELD pmaa017 name="construct.c.pmaa017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa016
            #add-point:BEFORE FIELD pmaa016 name="construct.b.pmaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa016
            
            #add-point:AFTER FIELD pmaa016 name="construct.a.pmaa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa016
            #add-point:ON ACTION controlp INFIELD pmaa016 name="construct.c.pmaa016"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa018
            #add-point:BEFORE FIELD pmaa018 name="construct.b.pmaa018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa018
            
            #add-point:AFTER FIELD pmaa018 name="construct.a.pmaa018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa018
            #add-point:ON ACTION controlp INFIELD pmaa018 name="construct.c.pmaa018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa019
            #add-point:ON ACTION controlp INFIELD pmaa019 name="construct.c.pmaa019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa019  #顯示到畫面上

            NEXT FIELD pmaa019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa019
            #add-point:BEFORE FIELD pmaa019 name="construct.b.pmaa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa019
            
            #add-point:AFTER FIELD pmaa019 name="construct.a.pmaa019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa021
            #add-point:BEFORE FIELD pmaa021 name="construct.b.pmaa021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa021
            
            #add-point:AFTER FIELD pmaa021 name="construct.a.pmaa021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa021
            #add-point:ON ACTION controlp INFIELD pmaa021 name="construct.c.pmaa021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa022
            #add-point:ON ACTION controlp INFIELD pmaa022 name="construct.c.pmaa022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa022  #顯示到畫面上

            NEXT FIELD pmaa022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa022
            #add-point:BEFORE FIELD pmaa022 name="construct.b.pmaa022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa022
            
            #add-point:AFTER FIELD pmaa022 name="construct.a.pmaa022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa020
            #add-point:BEFORE FIELD pmaa020 name="construct.b.pmaa020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa020
            
            #add-point:AFTER FIELD pmaa020 name="construct.a.pmaa020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa020
            #add-point:ON ACTION controlp INFIELD pmaa020 name="construct.c.pmaa020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa023
            #add-point:ON ACTION controlp INFIELD pmaa023 name="construct.c.pmaa023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "254"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa023  #顯示到畫面上

            NEXT FIELD pmaa023                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa023
            #add-point:BEFORE FIELD pmaa023 name="construct.b.pmaa023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa023
            
            #add-point:AFTER FIELD pmaa023 name="construct.a.pmaa023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa024
            #add-point:ON ACTION controlp INFIELD pmaa024 name="construct.c.pmaa024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "260"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa024  #顯示到畫面上

            NEXT FIELD pmaa024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa024
            #add-point:BEFORE FIELD pmaa024 name="construct.b.pmaa024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa024
            
            #add-point:AFTER FIELD pmaa024 name="construct.a.pmaa024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa025
            #add-point:BEFORE FIELD pmaa025 name="construct.b.pmaa025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa025
            
            #add-point:AFTER FIELD pmaa025 name="construct.a.pmaa025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa025
            #add-point:ON ACTION controlp INFIELD pmaa025 name="construct.c.pmaa025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa026
            #add-point:ON ACTION controlp INFIELD pmaa026 name="construct.c.pmaa026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "250"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa026  #顯示到畫面上

            NEXT FIELD pmaa026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa026
            #add-point:BEFORE FIELD pmaa026 name="construct.b.pmaa026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa026
            
            #add-point:AFTER FIELD pmaa026 name="construct.a.pmaa026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa098
            #add-point:BEFORE FIELD pmaa098 name="construct.b.pmaa098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa098
            
            #add-point:AFTER FIELD pmaa098 name="construct.a.pmaa098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa098
            #add-point:ON ACTION controlp INFIELD pmaa098 name="construct.c.pmaa098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa028
            #add-point:BEFORE FIELD pmaa028 name="construct.b.pmaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa028
            
            #add-point:AFTER FIELD pmaa028 name="construct.a.pmaa028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa028
            #add-point:ON ACTION controlp INFIELD pmaa028 name="construct.c.pmaa028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa029
            #add-point:BEFORE FIELD pmaa029 name="construct.b.pmaa029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa029
            
            #add-point:AFTER FIELD pmaa029 name="construct.a.pmaa029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa029
            #add-point:ON ACTION controlp INFIELD pmaa029 name="construct.c.pmaa029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa090
            #add-point:ON ACTION controlp INFIELD pmaa090 name="construct.c.pmaa090"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "281"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa090  #顯示到畫面上

            NEXT FIELD pmaa090                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa090
            #add-point:BEFORE FIELD pmaa090 name="construct.b.pmaa090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa090
            
            #add-point:AFTER FIELD pmaa090 name="construct.a.pmaa090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa091
            #add-point:ON ACTION controlp INFIELD pmaa091 name="construct.c.pmaa091"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "283"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa091  #顯示到畫面上

            NEXT FIELD pmaa091                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa091
            #add-point:BEFORE FIELD pmaa091 name="construct.b.pmaa091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa091
            
            #add-point:AFTER FIELD pmaa091 name="construct.a.pmaa091"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa092
            #add-point:BEFORE FIELD pmaa092 name="construct.b.pmaa092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa092
            
            #add-point:AFTER FIELD pmaa092 name="construct.a.pmaa092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa092
            #add-point:ON ACTION controlp INFIELD pmaa092 name="construct.c.pmaa092"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa094
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa094
            #add-point:ON ACTION controlp INFIELD pmaa094 name="construct.c.pmaa094"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "286"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa094  #顯示到畫面上

            NEXT FIELD pmaa094                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa094
            #add-point:BEFORE FIELD pmaa094 name="construct.b.pmaa094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa094
            
            #add-point:AFTER FIELD pmaa094 name="construct.a.pmaa094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa093
            #add-point:ON ACTION controlp INFIELD pmaa093 name="construct.c.pmaa093"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "285"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa093  #顯示到畫面上

            NEXT FIELD pmaa093                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa093
            #add-point:BEFORE FIELD pmaa093 name="construct.b.pmaa093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa093
            
            #add-point:AFTER FIELD pmaa093 name="construct.a.pmaa093"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa095
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa095
            #add-point:ON ACTION controlp INFIELD pmaa095 name="construct.c.pmaa095"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooea001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa095  #顯示到畫面上

            NEXT FIELD pmaa095                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa095
            #add-point:BEFORE FIELD pmaa095 name="construct.b.pmaa095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa095
            
            #add-point:AFTER FIELD pmaa095 name="construct.a.pmaa095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa096
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa096
            #add-point:ON ACTION controlp INFIELD pmaa096 name="construct.c.pmaa096"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa096  #顯示到畫面上

            NEXT FIELD pmaa096                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa096
            #add-point:BEFORE FIELD pmaa096 name="construct.b.pmaa096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa096
            
            #add-point:AFTER FIELD pmaa096 name="construct.a.pmaa096"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa097
            #add-point:ON ACTION controlp INFIELD pmaa097 name="construct.c.pmaa097"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa097  #顯示到畫面上
            NEXT FIELD pmaa097                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa097
            #add-point:BEFORE FIELD pmaa097 name="construct.b.pmaa097"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa097
            
            #add-point:AFTER FIELD pmaa097 name="construct.a.pmaa097"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa080
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa080
            #add-point:ON ACTION controlp INFIELD pmaa080 name="construct.c.pmaa080"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "251"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa080  #顯示到畫面上

            NEXT FIELD pmaa080                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa080
            #add-point:BEFORE FIELD pmaa080 name="construct.b.pmaa080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa080
            
            #add-point:AFTER FIELD pmaa080 name="construct.a.pmaa080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa081
            #add-point:ON ACTION controlp INFIELD pmaa081 name="construct.c.pmaa081"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "253"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa081  #顯示到畫面上

            NEXT FIELD pmaa081                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa081
            #add-point:BEFORE FIELD pmaa081 name="construct.b.pmaa081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa081
            
            #add-point:AFTER FIELD pmaa081 name="construct.a.pmaa081"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa082
            #add-point:BEFORE FIELD pmaa082 name="construct.b.pmaa082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa082
            
            #add-point:AFTER FIELD pmaa082 name="construct.a.pmaa082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa082
            #add-point:ON ACTION controlp INFIELD pmaa082 name="construct.c.pmaa082"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa084
            #add-point:ON ACTION controlp INFIELD pmaa084 name="construct.c.pmaa084"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160524-00018#1
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "256"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa084  #顯示到畫面上

            NEXT FIELD pmaa084                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa084
            #add-point:BEFORE FIELD pmaa084 name="construct.b.pmaa084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa084
            
            #add-point:AFTER FIELD pmaa084 name="construct.a.pmaa084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa083
            #add-point:ON ACTION controlp INFIELD pmaa083 name="construct.c.pmaa083"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "255"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa083  #顯示到畫面上

            NEXT FIELD pmaa083                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa083
            #add-point:BEFORE FIELD pmaa083 name="construct.b.pmaa083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa083
            
            #add-point:AFTER FIELD pmaa083 name="construct.a.pmaa083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa085
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa085
            #add-point:ON ACTION controlp INFIELD pmaa085 name="construct.c.pmaa085"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooea001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa085  #顯示到畫面上

            NEXT FIELD pmaa085                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa085
            #add-point:BEFORE FIELD pmaa085 name="construct.b.pmaa085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa085
            
            #add-point:AFTER FIELD pmaa085 name="construct.a.pmaa085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa086
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa086
            #add-point:ON ACTION controlp INFIELD pmaa086 name="construct.c.pmaa086"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa086  #顯示到畫面上

            NEXT FIELD pmaa086                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa086
            #add-point:BEFORE FIELD pmaa086 name="construct.b.pmaa086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa086
            
            #add-point:AFTER FIELD pmaa086 name="construct.a.pmaa086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa087
            #add-point:ON ACTION controlp INFIELD pmaa087 name="construct.c.pmaa087"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa087  #顯示到畫面上
            NEXT FIELD pmaa087                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa087
            #add-point:BEFORE FIELD pmaa087 name="construct.b.pmaa087"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa087
            
            #add-point:AFTER FIELD pmaa087 name="construct.a.pmaa087"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa088
            #add-point:BEFORE FIELD pmaa088 name="construct.b.pmaa088"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa088
            
            #add-point:AFTER FIELD pmaa088 name="construct.a.pmaa088"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa088
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa088
            #add-point:ON ACTION controlp INFIELD pmaa088 name="construct.c.pmaa088"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa047
            #add-point:BEFORE FIELD pmaa047 name="construct.b.pmaa047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa047
            
            #add-point:AFTER FIELD pmaa047 name="construct.a.pmaa047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa047
            #add-point:ON ACTION controlp INFIELD pmaa047 name="construct.c.pmaa047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa037
            #add-point:BEFORE FIELD pmaa037 name="construct.b.pmaa037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa037
            
            #add-point:AFTER FIELD pmaa037 name="construct.a.pmaa037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa037
            #add-point:ON ACTION controlp INFIELD pmaa037 name="construct.c.pmaa037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa036
            #add-point:BEFORE FIELD pmaa036 name="construct.b.pmaa036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa036
            
            #add-point:AFTER FIELD pmaa036 name="construct.a.pmaa036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa036
            #add-point:ON ACTION controlp INFIELD pmaa036 name="construct.c.pmaa036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa038
            #add-point:BEFORE FIELD pmaa038 name="construct.b.pmaa038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa038
            
            #add-point:AFTER FIELD pmaa038 name="construct.a.pmaa038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa038
            #add-point:ON ACTION controlp INFIELD pmaa038 name="construct.c.pmaa038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa039
            #add-point:BEFORE FIELD pmaa039 name="construct.b.pmaa039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa039
            
            #add-point:AFTER FIELD pmaa039 name="construct.a.pmaa039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa039
            #add-point:ON ACTION controlp INFIELD pmaa039 name="construct.c.pmaa039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa040
            #add-point:BEFORE FIELD pmaa040 name="construct.b.pmaa040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa040
            
            #add-point:AFTER FIELD pmaa040 name="construct.a.pmaa040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa040
            #add-point:ON ACTION controlp INFIELD pmaa040 name="construct.c.pmaa040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa041
            #add-point:BEFORE FIELD pmaa041 name="construct.b.pmaa041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa041
            
            #add-point:AFTER FIELD pmaa041 name="construct.a.pmaa041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa041
            #add-point:ON ACTION controlp INFIELD pmaa041 name="construct.c.pmaa041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa042
            #add-point:BEFORE FIELD pmaa042 name="construct.b.pmaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa042
            
            #add-point:AFTER FIELD pmaa042 name="construct.a.pmaa042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa042
            #add-point:ON ACTION controlp INFIELD pmaa042 name="construct.c.pmaa042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa043
            #add-point:BEFORE FIELD pmaa043 name="construct.b.pmaa043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa043
            
            #add-point:AFTER FIELD pmaa043 name="construct.a.pmaa043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa043
            #add-point:ON ACTION controlp INFIELD pmaa043 name="construct.c.pmaa043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa044
            #add-point:BEFORE FIELD pmaa044 name="construct.b.pmaa044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa044
            
            #add-point:AFTER FIELD pmaa044 name="construct.a.pmaa044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa044
            #add-point:ON ACTION controlp INFIELD pmaa044 name="construct.c.pmaa044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa045
            #add-point:BEFORE FIELD pmaa045 name="construct.b.pmaa045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa045
            
            #add-point:AFTER FIELD pmaa045 name="construct.a.pmaa045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa045
            #add-point:ON ACTION controlp INFIELD pmaa045 name="construct.c.pmaa045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa046
            #add-point:BEFORE FIELD pmaa046 name="construct.b.pmaa046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa046
            
            #add-point:AFTER FIELD pmaa046 name="construct.a.pmaa046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa046
            #add-point:ON ACTION controlp INFIELD pmaa046 name="construct.c.pmaa046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa068
            #add-point:BEFORE FIELD pmaa068 name="construct.b.pmaa068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa068
            
            #add-point:AFTER FIELD pmaa068 name="construct.a.pmaa068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa068
            #add-point:ON ACTION controlp INFIELD pmaa068 name="construct.c.pmaa068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa069
            #add-point:BEFORE FIELD pmaa069 name="construct.b.pmaa069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa069
            
            #add-point:AFTER FIELD pmaa069 name="construct.a.pmaa069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa069
            #add-point:ON ACTION controlp INFIELD pmaa069 name="construct.c.pmaa069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa072
            #add-point:BEFORE FIELD pmaa072 name="construct.b.pmaa072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa072
            
            #add-point:AFTER FIELD pmaa072 name="construct.a.pmaa072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa072
            #add-point:ON ACTION controlp INFIELD pmaa072 name="construct.c.pmaa072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa070
            #add-point:BEFORE FIELD pmaa070 name="construct.b.pmaa070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa070
            
            #add-point:AFTER FIELD pmaa070 name="construct.a.pmaa070"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa070
            #add-point:ON ACTION controlp INFIELD pmaa070 name="construct.c.pmaa070"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa071
            #add-point:BEFORE FIELD pmaa071 name="construct.b.pmaa071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa071
            
            #add-point:AFTER FIELD pmaa071 name="construct.a.pmaa071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa071
            #add-point:ON ACTION controlp INFIELD pmaa071 name="construct.c.pmaa071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa073
            #add-point:BEFORE FIELD pmaa073 name="construct.b.pmaa073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa073
            
            #add-point:AFTER FIELD pmaa073 name="construct.a.pmaa073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa073
            #add-point:ON ACTION controlp INFIELD pmaa073 name="construct.c.pmaa073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa051
            #add-point:BEFORE FIELD pmaa051 name="construct.b.pmaa051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa051
            
            #add-point:AFTER FIELD pmaa051 name="construct.a.pmaa051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa051
            #add-point:ON ACTION controlp INFIELD pmaa051 name="construct.c.pmaa051"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa052
            #add-point:ON ACTION controlp INFIELD pmaa052 name="construct.c.pmaa052"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa052  #顯示到畫面上

            NEXT FIELD pmaa052                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa052
            #add-point:BEFORE FIELD pmaa052 name="construct.b.pmaa052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa052
            
            #add-point:AFTER FIELD pmaa052 name="construct.a.pmaa052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa053
            #add-point:ON ACTION controlp INFIELD pmaa053 name="construct.c.pmaa053"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #ming 140817 modify ---------------------------------(S) 
            #CALL q_xmaa001()                           #呼叫開窗
            #企鵝：信用評等欄位的開窗與校驗改取xmaj_t 
            CALL q_xmaj001()                           #呼叫開窗
            #ming 140817 modify ---------------------------------(E) 
            DISPLAY g_qryparam.return1 TO pmaa053  #顯示到畫面上
            NEXT FIELD pmaa053                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa053
            #add-point:BEFORE FIELD pmaa053 name="construct.b.pmaa053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa053
            
            #add-point:AFTER FIELD pmaa053 name="construct.a.pmaa053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa054
            #add-point:ON ACTION controlp INFIELD pmaa054 name="construct.c.pmaa054"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa054  #顯示到畫面上

            NEXT FIELD pmaa054                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa054
            #add-point:BEFORE FIELD pmaa054 name="construct.b.pmaa054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa054
            
            #add-point:AFTER FIELD pmaa054 name="construct.a.pmaa054"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa055
            #add-point:BEFORE FIELD pmaa055 name="construct.b.pmaa055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa055
            
            #add-point:AFTER FIELD pmaa055 name="construct.a.pmaa055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa055
            #add-point:ON ACTION controlp INFIELD pmaa055 name="construct.c.pmaa055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa056
            #add-point:BEFORE FIELD pmaa056 name="construct.b.pmaa056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa056
            
            #add-point:AFTER FIELD pmaa056 name="construct.a.pmaa056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa056
            #add-point:ON ACTION controlp INFIELD pmaa056 name="construct.c.pmaa056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa057
            #add-point:BEFORE FIELD pmaa057 name="construct.b.pmaa057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa057
            
            #add-point:AFTER FIELD pmaa057 name="construct.a.pmaa057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa057
            #add-point:ON ACTION controlp INFIELD pmaa057 name="construct.c.pmaa057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa058
            #add-point:BEFORE FIELD pmaa058 name="construct.b.pmaa058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa058
            
            #add-point:AFTER FIELD pmaa058 name="construct.a.pmaa058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa058
            #add-point:ON ACTION controlp INFIELD pmaa058 name="construct.c.pmaa058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa074
            #add-point:BEFORE FIELD pmaa074 name="construct.b.pmaa074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa074
            
            #add-point:AFTER FIELD pmaa074 name="construct.a.pmaa074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa074
            #add-point:ON ACTION controlp INFIELD pmaa074 name="construct.c.pmaa074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa059
            #add-point:BEFORE FIELD pmaa059 name="construct.b.pmaa059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa059
            
            #add-point:AFTER FIELD pmaa059 name="construct.a.pmaa059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa059
            #add-point:ON ACTION controlp INFIELD pmaa059 name="construct.c.pmaa059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa075
            #add-point:BEFORE FIELD pmaa075 name="construct.b.pmaa075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa075
            
            #add-point:AFTER FIELD pmaa075 name="construct.a.pmaa075"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa075
            #add-point:ON ACTION controlp INFIELD pmaa075 name="construct.c.pmaa075"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa060
            #add-point:BEFORE FIELD pmaa060 name="construct.b.pmaa060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa060
            
            #add-point:AFTER FIELD pmaa060 name="construct.a.pmaa060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa060
            #add-point:ON ACTION controlp INFIELD pmaa060 name="construct.c.pmaa060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa061
            #add-point:BEFORE FIELD pmaa061 name="construct.b.pmaa061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa061
            
            #add-point:AFTER FIELD pmaa061 name="construct.a.pmaa061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa061
            #add-point:ON ACTION controlp INFIELD pmaa061 name="construct.c.pmaa061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa062
            #add-point:BEFORE FIELD pmaa062 name="construct.b.pmaa062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa062
            
            #add-point:AFTER FIELD pmaa062 name="construct.a.pmaa062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa062
            #add-point:ON ACTION controlp INFIELD pmaa062 name="construct.c.pmaa062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa063
            #add-point:BEFORE FIELD pmaa063 name="construct.b.pmaa063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa063
            
            #add-point:AFTER FIELD pmaa063 name="construct.a.pmaa063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa063
            #add-point:ON ACTION controlp INFIELD pmaa063 name="construct.c.pmaa063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa064
            #add-point:BEFORE FIELD pmaa064 name="construct.b.pmaa064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa064
            
            #add-point:AFTER FIELD pmaa064 name="construct.a.pmaa064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa064
            #add-point:ON ACTION controlp INFIELD pmaa064 name="construct.c.pmaa064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa065
            #add-point:BEFORE FIELD pmaa065 name="construct.b.pmaa065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa065
            
            #add-point:AFTER FIELD pmaa065 name="construct.a.pmaa065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa065
            #add-point:ON ACTION controlp INFIELD pmaa065 name="construct.c.pmaa065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa066
            #add-point:BEFORE FIELD pmaa066 name="construct.b.pmaa066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa066
            
            #add-point:AFTER FIELD pmaa066 name="construct.a.pmaa066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa066
            #add-point:ON ACTION controlp INFIELD pmaa066 name="construct.c.pmaa066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa067
            #add-point:BEFORE FIELD pmaa067 name="construct.b.pmaa067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa067
            
            #add-point:AFTER FIELD pmaa067 name="construct.a.pmaa067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa067
            #add-point:ON ACTION controlp INFIELD pmaa067 name="construct.c.pmaa067"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaa291
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa291
            #add-point:ON ACTION controlp INFIELD pmaa291 name="construct.c.pmaa291"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2061"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa291  #顯示到畫面上

            NEXT FIELD pmaa291                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa291
            #add-point:BEFORE FIELD pmaa291 name="construct.b.pmaa291"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa291
            
            #add-point:AFTER FIELD pmaa291 name="construct.a.pmaa291"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa292
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa292
            #add-point:ON ACTION controlp INFIELD pmaa292 name="construct.c.pmaa292"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2062"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa292  #顯示到畫面上

            NEXT FIELD pmaa292                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa292
            #add-point:BEFORE FIELD pmaa292 name="construct.b.pmaa292"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa292
            
            #add-point:AFTER FIELD pmaa292 name="construct.a.pmaa292"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa293
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa293
            #add-point:ON ACTION controlp INFIELD pmaa293 name="construct.c.pmaa293"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2063"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa293  #顯示到畫面上

            NEXT FIELD pmaa293                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa293
            #add-point:BEFORE FIELD pmaa293 name="construct.b.pmaa293"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa293
            
            #add-point:AFTER FIELD pmaa293 name="construct.a.pmaa293"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa294
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa294
            #add-point:ON ACTION controlp INFIELD pmaa294 name="construct.c.pmaa294"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2064"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa294  #顯示到畫面上

            NEXT FIELD pmaa294                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa294
            #add-point:BEFORE FIELD pmaa294 name="construct.b.pmaa294"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa294
            
            #add-point:AFTER FIELD pmaa294 name="construct.a.pmaa294"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa295
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa295
            #add-point:ON ACTION controlp INFIELD pmaa295 name="construct.c.pmaa295"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2065"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa295  #顯示到畫面上

            NEXT FIELD pmaa295                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa295
            #add-point:BEFORE FIELD pmaa295 name="construct.b.pmaa295"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa295
            
            #add-point:AFTER FIELD pmaa295 name="construct.a.pmaa295"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa296
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa296
            #add-point:ON ACTION controlp INFIELD pmaa296 name="construct.c.pmaa296"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2066"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa296  #顯示到畫面上

            NEXT FIELD pmaa296                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa296
            #add-point:BEFORE FIELD pmaa296 name="construct.b.pmaa296"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa296
            
            #add-point:AFTER FIELD pmaa296 name="construct.a.pmaa296"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa297
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa297
            #add-point:ON ACTION controlp INFIELD pmaa297 name="construct.c.pmaa297"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2067"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa297  #顯示到畫面上

            NEXT FIELD pmaa297                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa297
            #add-point:BEFORE FIELD pmaa297 name="construct.b.pmaa297"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa297
            
            #add-point:AFTER FIELD pmaa297 name="construct.a.pmaa297"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa298
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa298
            #add-point:ON ACTION controlp INFIELD pmaa298 name="construct.c.pmaa298"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2068"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa298  #顯示到畫面上

            NEXT FIELD pmaa298                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa298
            #add-point:BEFORE FIELD pmaa298 name="construct.b.pmaa298"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa298
            
            #add-point:AFTER FIELD pmaa298 name="construct.a.pmaa298"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa299
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa299
            #add-point:ON ACTION controlp INFIELD pmaa299 name="construct.c.pmaa299"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2069"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa299  #顯示到畫面上

            NEXT FIELD pmaa299                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa299
            #add-point:BEFORE FIELD pmaa299 name="construct.b.pmaa299"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa299
            
            #add-point:AFTER FIELD pmaa299 name="construct.a.pmaa299"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa300
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa300
            #add-point:ON ACTION controlp INFIELD pmaa300 name="construct.c.pmaa300"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2070"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa300  #顯示到畫面上

            NEXT FIELD pmaa300                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa300
            #add-point:BEFORE FIELD pmaa300 name="construct.b.pmaa300"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa300
            
            #add-point:AFTER FIELD pmaa300 name="construct.a.pmaa300"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa281
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa281
            #add-point:ON ACTION controlp INFIELD pmaa281 name="construct.c.pmaa281"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2037"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa281  #顯示到畫面上

            NEXT FIELD pmaa281                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa281
            #add-point:BEFORE FIELD pmaa281 name="construct.b.pmaa281"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa281
            
            #add-point:AFTER FIELD pmaa281 name="construct.a.pmaa281"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa282
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa282
            #add-point:ON ACTION controlp INFIELD pmaa282 name="construct.c.pmaa282"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2038"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa282  #顯示到畫面上

            NEXT FIELD pmaa282                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa282
            #add-point:BEFORE FIELD pmaa282 name="construct.b.pmaa282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa282
            
            #add-point:AFTER FIELD pmaa282 name="construct.a.pmaa282"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa283
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa283
            #add-point:ON ACTION controlp INFIELD pmaa283 name="construct.c.pmaa283"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2039"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa283  #顯示到畫面上

            NEXT FIELD pmaa283                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa283
            #add-point:BEFORE FIELD pmaa283 name="construct.b.pmaa283"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa283
            
            #add-point:AFTER FIELD pmaa283 name="construct.a.pmaa283"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa284
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa284
            #add-point:ON ACTION controlp INFIELD pmaa284 name="construct.c.pmaa284"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2040"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa284  #顯示到畫面上

            NEXT FIELD pmaa284                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa284
            #add-point:BEFORE FIELD pmaa284 name="construct.b.pmaa284"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa284
            
            #add-point:AFTER FIELD pmaa284 name="construct.a.pmaa284"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa285
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa285
            #add-point:ON ACTION controlp INFIELD pmaa285 name="construct.c.pmaa285"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2041"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa285  #顯示到畫面上

            NEXT FIELD pmaa285                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa285
            #add-point:BEFORE FIELD pmaa285 name="construct.b.pmaa285"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa285
            
            #add-point:AFTER FIELD pmaa285 name="construct.a.pmaa285"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa286
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa286
            #add-point:ON ACTION controlp INFIELD pmaa286 name="construct.c.pmaa286"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2042"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa286  #顯示到畫面上

            NEXT FIELD pmaa286                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa286
            #add-point:BEFORE FIELD pmaa286 name="construct.b.pmaa286"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa286
            
            #add-point:AFTER FIELD pmaa286 name="construct.a.pmaa286"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa287
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa287
            #add-point:ON ACTION controlp INFIELD pmaa287 name="construct.c.pmaa287"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2043"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa287  #顯示到畫面上

            NEXT FIELD pmaa287                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa287
            #add-point:BEFORE FIELD pmaa287 name="construct.b.pmaa287"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa287
            
            #add-point:AFTER FIELD pmaa287 name="construct.a.pmaa287"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa288
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa288
            #add-point:ON ACTION controlp INFIELD pmaa288 name="construct.c.pmaa288"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2044"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa288  #顯示到畫面上

            NEXT FIELD pmaa288                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa288
            #add-point:BEFORE FIELD pmaa288 name="construct.b.pmaa288"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa288
            
            #add-point:AFTER FIELD pmaa288 name="construct.a.pmaa288"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa289
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa289
            #add-point:ON ACTION controlp INFIELD pmaa289 name="construct.c.pmaa289"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2045"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa289  #顯示到畫面上

            NEXT FIELD pmaa289                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa289
            #add-point:BEFORE FIELD pmaa289 name="construct.b.pmaa289"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa289
            
            #add-point:AFTER FIELD pmaa289 name="construct.a.pmaa289"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa290
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa290
            #add-point:ON ACTION controlp INFIELD pmaa290 name="construct.c.pmaa290"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = "2046"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa290  #顯示到畫面上

            NEXT FIELD pmaa290                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa290
            #add-point:BEFORE FIELD pmaa290 name="construct.b.pmaa290"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa290
            
            #add-point:AFTER FIELD pmaa290 name="construct.a.pmaa290"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaownid
            #add-point:ON ACTION controlp INFIELD pmaaownid name="construct.c.pmaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaaownid  #顯示到畫面上

            NEXT FIELD pmaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaownid
            #add-point:BEFORE FIELD pmaaownid name="construct.b.pmaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaownid
            
            #add-point:AFTER FIELD pmaaownid name="construct.a.pmaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaowndp
            #add-point:ON ACTION controlp INFIELD pmaaowndp name="construct.c.pmaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaaowndp  #顯示到畫面上

            NEXT FIELD pmaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaowndp
            #add-point:BEFORE FIELD pmaaowndp name="construct.b.pmaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaowndp
            
            #add-point:AFTER FIELD pmaaowndp name="construct.a.pmaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaacrtid
            #add-point:ON ACTION controlp INFIELD pmaacrtid name="construct.c.pmaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaacrtid  #顯示到畫面上

            NEXT FIELD pmaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaacrtid
            #add-point:BEFORE FIELD pmaacrtid name="construct.b.pmaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaacrtid
            
            #add-point:AFTER FIELD pmaacrtid name="construct.a.pmaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaacrtdp
            #add-point:ON ACTION controlp INFIELD pmaacrtdp name="construct.c.pmaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaacrtdp  #顯示到畫面上

            NEXT FIELD pmaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaacrtdp
            #add-point:BEFORE FIELD pmaacrtdp name="construct.b.pmaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaacrtdp
            
            #add-point:AFTER FIELD pmaacrtdp name="construct.a.pmaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaacrtdt
            #add-point:BEFORE FIELD pmaacrtdt name="construct.b.pmaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaamodid
            #add-point:ON ACTION controlp INFIELD pmaamodid name="construct.c.pmaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaamodid  #顯示到畫面上

            NEXT FIELD pmaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaamodid
            #add-point:BEFORE FIELD pmaamodid name="construct.b.pmaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaamodid
            
            #add-point:AFTER FIELD pmaamodid name="construct.a.pmaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaamoddt
            #add-point:BEFORE FIELD pmaamoddt name="construct.b.pmaamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmaacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaacnfid
            #add-point:ON ACTION controlp INFIELD pmaacnfid name="construct.c.pmaacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaacnfid  #顯示到畫面上

            NEXT FIELD pmaacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaacnfid
            #add-point:BEFORE FIELD pmaacnfid name="construct.b.pmaacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaacnfid
            
            #add-point:AFTER FIELD pmaacnfid name="construct.a.pmaacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaacnfdt
            #add-point:BEFORE FIELD pmaacnfdt name="construct.b.pmaacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmae002,oocq005,pmae003
           FROM s_detail1[1].pmae002,s_detail1[1].oocq005,s_detail1[1].pmae003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.pmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmae002
            #add-point:ON ACTION controlp INFIELD pmae002 name="construct.c.page1.pmae002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = '235'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmae002  #顯示到畫面上

            NEXT FIELD pmae002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmae002
            #add-point:BEFORE FIELD pmae002 name="construct.b.page1.pmae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmae002
            
            #add-point:AFTER FIELD pmae002 name="construct.a.page1.pmae002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq005
            #add-point:BEFORE FIELD oocq005 name="construct.b.page1.oocq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq005
            
            #add-point:AFTER FIELD oocq005 name="construct.a.page1.oocq005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq005
            #add-point:ON ACTION controlp INFIELD oocq005 name="construct.c.page1.oocq005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmae003
            #add-point:BEFORE FIELD pmae003 name="construct.b.page1.pmae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmae003
            
            #add-point:AFTER FIELD pmae003 name="construct.a.page1.pmae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmae003
            #add-point:ON ACTION controlp INFIELD pmae003 name="construct.c.page1.pmae003"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      #單身根據table分拆construct
      CONSTRUCT g_wc3_table1 ON pmae002
           FROM s_detail2[1].pmae002_1
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)

         ON ACTION controlp INFIELD pmae002_1
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'    #160524-00018#1
            LET g_qryparam.arg1 = '242'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmae002_1  #顯示到畫面上

            NEXT FIELD pmae002_1                    #返回原欄位
       
      END CONSTRUCT
      #通訊地址查詢
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct
      SUBDIALOG apm_apmm100_01.apmm100_01_construct
      SUBDIALOG apm_apmm100_02.apmm100_02_construct
      SUBDIALOG apm_apmm100_03.apmm100_03_construct
      SUBDIALOG apm_apmm100_05.apmm100_05_construct
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         NEXT FIELD pmaa001
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
                  WHEN la_wc[li_idx].tableid = "pmaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmae_t" 
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
   #客戶標籤，加上交易類型 pmae003 = '2'
   IF NOT cl_null(g_wc2_table1) AND g_wc2_table1 <> " 1=1" THEN
      LET g_wc2_table1 = g_wc2_table1 CLIPPED, " AND pmae003 = '2' "
   END IF
   LET g_wc2 = g_wc2_table1
   
   #供應商標籤，加上交易類型 pmae003 = '1'
   IF NOT cl_null(g_wc3_table1) AND g_wc3_table1 <> " 1=1" THEN
      LET g_wc3_table1 = g_wc3_table1 CLIPPED, " AND pmae003 = '1' "
   END IF
   LET g_wc3 = g_wc3_table1
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmm100_filter()
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
      CONSTRUCT g_wc_filter ON pmaa001,pmaa002,pmaa004,pmaa005,pmaa026,pmaa006
                          FROM s_browse[1].b_pmaa001,s_browse[1].b_pmaa002,s_browse[1].b_pmaa004,s_browse[1].b_pmaa005, 
                              s_browse[1].b_pmaa026,s_browse[1].b_pmaa006
 
         BEFORE CONSTRUCT
               DISPLAY apmm100_filter_parser('pmaa001') TO s_browse[1].b_pmaa001
            DISPLAY apmm100_filter_parser('pmaa002') TO s_browse[1].b_pmaa002
            DISPLAY apmm100_filter_parser('pmaa004') TO s_browse[1].b_pmaa004
            DISPLAY apmm100_filter_parser('pmaa005') TO s_browse[1].b_pmaa005
            DISPLAY apmm100_filter_parser('pmaa026') TO s_browse[1].b_pmaa026
            DISPLAY apmm100_filter_parser('pmaa006') TO s_browse[1].b_pmaa006
      
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
 
      CALL apmm100_filter_show('pmaa001')
   CALL apmm100_filter_show('pmaa002')
   CALL apmm100_filter_show('pmaa004')
   CALL apmm100_filter_show('pmaa005')
   CALL apmm100_filter_show('pmaa026')
   CALL apmm100_filter_show('pmaa006')
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmm100_filter_parser(ps_field)
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
 
{<section id="apmm100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmm100_filter_show(ps_field)
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
   LET ls_condition = apmm100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmm100_query()
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
   CALL g_pmae_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi350_01_clear_detail()   #清除聯絡地址
   CALL aooi350_02_clear_detail()   #清除通訊方式
   CALL apmm100_01_clear_detail()   #清除交易夥伴
   CALL apmm100_02_clear_detail()   #清除銀行資訊
   CALL apmm100_03_clear_detail()   #清除收款條件
   CALL apmm100_05_clear_detail()   #清除付款條件
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmm100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmm100_browser_fill("")
      CALL apmm100_fetch("")
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
      CALL apmm100_filter_show('pmaa001')
   CALL apmm100_filter_show('pmaa002')
   CALL apmm100_filter_show('pmaa004')
   CALL apmm100_filter_show('pmaa005')
   CALL apmm100_filter_show('pmaa026')
   CALL apmm100_filter_show('pmaa006')
   CALL apmm100_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmm100_fetch("F") 
      #顯示單身筆數
      CALL apmm100_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmm100_fetch(p_flag)
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
   
   LET g_pmaa_m.pmaa001 = g_browser[g_current_idx].b_pmaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
   #遮罩相關處理
   LET g_pmaa_m_mask_o.* =  g_pmaa_m.*
   CALL apmm100_pmaa_t_mask()
   LET g_pmaa_m_mask_n.* =  g_pmaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmm100_set_act_visible()   
   CALL apmm100_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmaa_m_t.* = g_pmaa_m.*
   LET g_pmaa_m_o.* = g_pmaa_m.*
   
   LET g_data_owner = g_pmaa_m.pmaaownid      
   LET g_data_dept  = g_pmaa_m.pmaaowndp
   
   #重新顯示   
   CALL apmm100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmm100_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmae_d.clear()   
 
 
   INITIALIZE g_pmaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmaa_m.pmaaownid = g_user
      LET g_pmaa_m.pmaaowndp = g_dept
      LET g_pmaa_m.pmaacrtid = g_user
      LET g_pmaa_m.pmaacrtdp = g_dept 
      LET g_pmaa_m.pmaacrtdt = cl_get_current()
      LET g_pmaa_m.pmaamodid = g_user
      LET g_pmaa_m.pmaamoddt = cl_get_current()
      LET g_pmaa_m.pmaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmaa_m.pmaastus = "N"
      LET g_pmaa_m.pmaa004 = "1"
      LET g_pmaa_m.pmaa010 = "1"
      LET g_pmaa_m.pmaa018 = "0"
      LET g_pmaa_m.pmaa021 = "0"
      LET g_pmaa_m.pmaa098 = "N"
      LET g_pmaa_m.pmaa092 = "1"
      LET g_pmaa_m.pmaa082 = "1"
      LET g_pmaa_m.pmaa088 = "Y"
      LET g_pmaa_m.pmaa047 = "N"
      LET g_pmaa_m.pmaa037 = "1"
      LET g_pmaa_m.pmaa036 = "N"
      LET g_pmaa_m.pmaa068 = "Y"
      LET g_pmaa_m.pmaa069 = "Y"
      LET g_pmaa_m.pmaa072 = "Y"
      LET g_pmaa_m.pmaa070 = "Y"
      LET g_pmaa_m.pmaa071 = "Y"
      LET g_pmaa_m.pmaa073 = "01"
      LET g_pmaa_m.pmaa051 = "1"
      LET g_pmaa_m.pmaa055 = "0"
      LET g_pmaa_m.pmaa058 = "0"
      LET g_pmaa_m.pmaa074 = "0"
      LET g_pmaa_m.pmaa059 = "0"
      LET g_pmaa_m.pmaa061 = "1"
      LET g_pmaa_m.pmaa063 = "1"
      LET g_pmaa_m.pmaa065 = "1"
      LET g_pmaa_m.pmaa066 = "N"
      LET g_pmaa_m.pmaa067 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_pmaa_m_t.* TO NULL
      LET g_pmaa_m_t.* = g_pmaa_m.*
      
      IF NOT cl_null(g_argv[1]) THEN
         LET g_pmaa_m.pmaa002 = g_argv[1]
      END IF
 
      LET g_pmaa_m.pmaa095 = g_site
      LET g_pmaa_m.pmaa085 = g_site
      INITIALIZE g_pmaa027_d TO NULL
      INITIALIZE g_pmaa001_d TO NULL
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
      CALL apmm100_01_clear_detail()   #清除交易夥伴
      CALL apmm100_02_clear_detail()   #清除銀行資訊
      CALL apmm100_03_clear_detail()   #清除收款條件
      CALL apmm100_05_clear_detail()   #清除付款條件
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmaa_m_t.* = g_pmaa_m.*
      LET g_pmaa_m_o.* = g_pmaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmaa_m.pmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL apmm100_input("a")
      
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
         INITIALIZE g_pmaa_m.* TO NULL
         INITIALIZE g_pmae_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmm100_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmae_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmm100_set_act_visible()   
   CALL apmm100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmaa001_t = g_pmaa_m.pmaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmaaent = " ||g_enterprise|| " AND",
                      " pmaa001 = '", g_pmaa_m.pmaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmm100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmm100_cl
   
   CALL apmm100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
   
   #遮罩相關處理
   LET g_pmaa_m_mask_o.* =  g_pmaa_m.*
   CALL apmm100_pmaa_t_mask()
   LET g_pmaa_m_mask_n.* =  g_pmaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
       g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc, 
       g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc, 
       g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018, 
       g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc, 
       g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029, 
       g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092, 
       g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095, 
       g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097,g_pmaa_m.pmaa097_desc, 
       g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082, 
       g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085, 
       g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087,g_pmaa_m.pmaa087_desc, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc, 
       g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058, 
       g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062, 
       g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291, 
       g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc, 
       g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296, 
       g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc, 
       g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281, 
       g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc, 
       g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc, 
       g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013, 
       g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid, 
       g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
       g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmaa_m.pmaaownid      
   LET g_data_dept  = g_pmaa_m.pmaaowndp
   
   #功能已完成,通報訊息中心
   CALL apmm100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmm100_modify()
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
   LET g_pmaa_m_t.* = g_pmaa_m.*
   LET g_pmaa_m_o.* = g_pmaa_m.*
   
   IF g_pmaa_m.pmaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmaa001_t = g_pmaa_m.pmaa001
 
   CALL s_transaction_begin()
   
   OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmm100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmm100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
   #檢查是否允許此動作
   IF NOT apmm100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmaa_m_mask_o.* =  g_pmaa_m.*
   CALL apmm100_pmaa_t_mask()
   LET g_pmaa_m_mask_n.* =  g_pmaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmm100_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pmaa001_t = g_pmaa_m.pmaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmaa_m.pmaamodid = g_user 
LET g_pmaa_m.pmaamoddt = cl_get_current()
LET g_pmaa_m.pmaamodid_desc = cl_get_username(g_pmaa_m.pmaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmm100_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmaa_t SET (pmaamodid,pmaamoddt) = (g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt)
          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmaa_m.* = g_pmaa_m_t.*
            CALL apmm100_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmaa_m.pmaa001 != g_pmaa_m_t.pmaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmae_t SET pmae001 = g_pmaa_m.pmaa001
 
          WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m_t.pmaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmae_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         #--150925--polly--add--(s)
         #需依aooi090設定帶回據點(site)
         IF NOT s_aooi090_upd_fields('4',g_pmaa_m.pmaa001) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00034'
            LET g_errparam.extend = g_pmaa_m.pmaa001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF
         #--150925--polly--add--(e)
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmm100_set_act_visible()   
   CALL apmm100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmaaent = " ||g_enterprise|| " AND",
                      " pmaa001 = '", g_pmaa_m.pmaa001, "' "
 
   #填到對應位置
   CALL apmm100_browser_fill("")
 
   CLOSE apmm100_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmm100_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmm100.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmm100_input(p_cmd)
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
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_oofa001       LIKE oofa_t.oofa001
   DEFINE  l_cmd2          LIKE type_t.chr1
   DEFINE  l_n2            LIKE type_t.num5 
   DEFINE  l_ooef006       LIKE ooef_t.ooef006
   DEFINE  l_pmaa027       LIKE pmaa_t.pmaa027
   DEFINE  l_pmaa002       LIKE pmaa_t.pmaa002
   DEFINE  l_cm            STRING
   DEFINE  la_param  RECORD
             prog    STRING,
             param   DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE  ls_js     STRING
   
   DEFINE  l_errno         LIKE gzze_t.gzze001   #150303---earl---add
   #150427 by whitney add for 增加編碼功能 start
   DEFINE  l_oofg_return   DYNAMIC ARRAY OF RECORD
             oofg019       LIKE oofg_t.oofg019,  #field
             oofg020       LIKE oofg_t.oofg020   #value
                           END RECORD
   #150427 by whitney add for 增加編碼功能 end
   DEFINE  l_flag          LIKE type_t.num5
   DEFINE  l_pmab081       LIKE pmab_t.pmab081  #150922-00020#3 add 
   DEFINE  l_pmab109       LIKE pmab_t.pmab109  #150922-00020#3 add
   DEFINE  l_pmad002       LIKE pmad_t.pmad002  #160920-00003#1
   DEFINE  l_ooef011       LIKE ooef_t.ooef011  #161230-00036#1 add
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
   DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
       g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc, 
       g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc, 
       g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018, 
       g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc, 
       g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029, 
       g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092, 
       g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095, 
       g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097,g_pmaa_m.pmaa097_desc, 
       g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082, 
       g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085, 
       g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087,g_pmaa_m.pmaa087_desc, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc, 
       g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058, 
       g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062, 
       g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291, 
       g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc, 
       g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296, 
       g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc, 
       g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281, 
       g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc, 
       g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc, 
       g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013, 
       g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid, 
       g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
       g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt 
 
   
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
   LET g_forupd_sql = "SELECT pmae002,'','' FROM pmae_t WHERE pmaeent=? AND pmae001=? AND pmae002=? AND pmae003=? FOR UPDATE"
 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apmm100_bcl5 CURSOR FROM g_forupd_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT pmae002,pmae003 FROM pmae_t WHERE pmaeent=? AND pmae001=? AND pmae002=?  
       AND pmae003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmm100_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmm100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   CALL apmm100_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
       g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006, 
       g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230, 
       g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019, 
       g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025, 
       g_pmaa_m.pmaa026,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091, 
       g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097, 
       g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085, 
       g_pmaa_m.pmaa086,g_pmaa_m.pmaa087,g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036, 
       g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043, 
       g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072, 
       g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053, 
       g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074, 
       g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063, 
       g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292, 
       g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298, 
       g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284, 
       g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290, 
       g_pmaa_m.ooff013
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmm100.input.head" >}
      #單頭段
      INPUT BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
          g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006, 
          g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230, 
          g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019, 
          g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025, 
          g_pmaa_m.pmaa026,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091, 
          g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097, 
          g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085, 
          g_pmaa_m.pmaa086,g_pmaa_m.pmaa087,g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036, 
          g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043, 
          g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072, 
          g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053, 
          g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074, 
          g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063, 
          g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292, 
          g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298, 
          g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284, 
          g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290, 
          g_pmaa_m.ooff013 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_pmaa_m.pmaa001)  THEN
                  CALL n_pmaal(g_pmaa_m.pmaa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pmaa_m.pmaa001
                  #modify--2015/05/25 By shiun--(S)
                  CALL ap_ref_array2(g_ref_fields," SELECT pmaal003,pmaal004,pmaal005,pmaal006 FROM pmaal_t WHERE pmaalent = '" 
                      ||g_enterprise||"' AND pmaal001 = ? AND pmaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pmaa_m.pmaal003 = g_rtn_fields[1]
                  LET g_pmaa_m.pmaal004 = g_rtn_fields[2]
                  LET g_pmaa_m.pmaal005 = g_rtn_fields[3]
                  LET g_pmaa_m.pmaal006 = g_rtn_fields[4]
                  DISPLAY BY NAME g_pmaa_m.pmaal003,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaal006
                  #modify--2015/05/25 By shiun--(E)
               END IF 
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="input.master_input.open_s_carry_query"
               #2015/07/02 by stellar add ----- (S)
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET ga_field[1] = g_pmaa_m.pmaa001
                  CALL s_carry_query('3',ga_field)
               END IF
               #2015/07/02 by stellar add ----- (E)
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmm100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmm100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.pmaal001 = g_pmaa_m.pmaa001
LET g_master_multi_table_t.pmaal004 = g_pmaa_m.pmaal004
LET g_master_multi_table_t.pmaal003 = g_pmaa_m.pmaal003
LET g_master_multi_table_t.pmaal006 = g_pmaa_m.pmaal006
LET g_master_multi_table_t.pmaal005 = g_pmaa_m.pmaal005
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.pmaal001 = ''
LET g_master_multi_table_t.pmaal004 = ''
LET g_master_multi_table_t.pmaal003 = ''
LET g_master_multi_table_t.pmaal006 = ''
LET g_master_multi_table_t.pmaal005 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmm100_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
               CALL apmm100_reproduce_init()
            END IF
            #end add-point
            CALL apmm100_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa001
            #add-point:BEFORE FIELD pmaa001 name="input.b.pmaa001"
            #150427 by whitney add for 增加編碼功能 start
            IF cl_null(g_pmaa_m.pmaa001) THEN
               CALL s_aooi390_gen('2') RETURNING l_success,g_pmaa_m.pmaa001,l_oofg_return
               DISPLAY BY NAME g_pmaa_m.pmaa001
            END IF
            #150427 by whitney add for 增加編碼功能 end

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa001
            
            #add-point:AFTER FIELD pmaa001 name="input.a.pmaa001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_pmaa_m.pmaa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmaa_m.pmaa001 != g_pmaa001_t ))) THEN 
                  
                  LET l_n = 0
                  #在apmm200若輸入的"客戶編號"pmaa001已經存在
                  #"交易對象類型"pmaa002是"1.供應商"或是"3.交易對象"提示key值重複不可輸入~
                  #"交易對象類型"pmaa002是"2.客戶編號"則同pmaal004詢問後將資料UPDATE成"3.交易對象"
                  #在axmm200若輸入的"客戶編號"pmaa001已經存在
                  #"交易對象類型"pmaa002是"2.客戶編號"或是"3.交易對象"提示key值重複不可輸入~
                  #"交易對象類型"pmaa002是"1.供應商"則同pmaal004詢問後將資料UPDATE成"3.交易對象"
                  SELECT COUNT(*) INTO l_n FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001 AND pmaa002 <> g_pmaa_m.pmaa002 AND pmaa002 <> '3'
                  IF l_n > 0 THEN
                     #存在相同的交易對象編號是否為同一個交易對象？
                     IF cl_ask_confirm('apm-00578') THEN
                        LET g_pmaa_m.pmaamoddt = cl_get_current()
                        UPDATE pmaa_t SET pmaa002 = '3',pmaamodid = g_user,pmaamoddt = g_pmaa_m.pmaamoddt WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        
                        SELECT UNIQUE pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa080,pmaa081,pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdt,pmaacrtdp,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt
                          INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt
                          FROM pmaa_t
                          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        CALL apmm100_show()
                        LET g_master_insert = TRUE  #160409-00005#1 add
                        EXIT DIALOG
                     #160701-00017#1---s---
                     ELSE
                        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||"pmaa001 = '"||g_pmaa_m.pmaa001 ||"'",'std-00004',0) THEN 
                           LET g_pmaa_m.pmaa001 = g_pmaa_m_t.pmaa001
                           NEXT FIELD CURRENT
                        END IF
                     #160701-00017#1----e----
                     END IF
                  ELSE
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||"pmaa001 = '"||g_pmaa_m.pmaa001 ||"'",'std-00004',0) THEN 
                        LET g_pmaa_m.pmaa001 = g_pmaa_m_t.pmaa001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150427 by whitney add for 增加編碼功能 start
                  IF NOT s_aooi390_chk('2',g_pmaa_m.pmaa001) THEN
                     LET g_pmaa_m.pmaa001 = g_pmaa_m_t.pmaa001
                     DISPLAY BY NAME g_pmaa_m.pmaa001
                     NEXT FIELD CURRENT
                  END IF
                  #150427 by whitney add for 增加編碼功能 end
               END IF
               IF g_pmaa_m.pmaa004 = '1' THEN
                  LET g_pmaa_m.pmaa005 = g_pmaa_m.pmaa001
               END IF
               IF cl_null(g_pmaa_m.pmaa052) THEN
                  LET g_pmaa_m.pmaa052 = g_pmaa_m.pmaa001
                  LET g_pmaa_m_t.pmaa052 = g_pmaa_m.pmaa001
               END IF
               
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa001
            #add-point:ON CHANGE pmaa001 name="input.g.pmaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa002
            #add-point:BEFORE FIELD pmaa002 name="input.b.pmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa002
            
            #add-point:AFTER FIELD pmaa002 name="input.a.pmaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa002
            #add-point:ON CHANGE pmaa002 name="input.g.pmaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal004
            #add-point:BEFORE FIELD pmaal004 name="input.b.pmaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal004
            
            #add-point:AFTER FIELD pmaal004 name="input.a.pmaal004"
            IF NOT cl_null(g_pmaa_m.pmaal004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaal004 != g_master_multi_table_t.pmaal004 OR cl_null(g_master_multi_table_t.pmaal004))) THEN 
                  LET l_n = 0 
                  IF NOT cl_null(g_pmaa_m.pmaa001) THEN  #170216-00073#1-----add---g_pmaa_m.pmaa001等于空值的时候查询if里的sql语句l_n=0
                     SELECT COUNT(*) INTO l_n FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal004 = g_pmaa_m.pmaal004 AND pmaal001 <> g_pmaa_m.pmaa001 AND pmaal002 = g_dlang
                  #170216-00073#1-----add-----str
                  ELSE
                      SELECT COUNT(*) INTO l_n FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal004 = g_pmaa_m.pmaal004 AND pmaal002 = g_dlang
                  END IF
                  #170216-00073#1-----add-----end                  
                  IF l_n > 0 THEN
                     #存在相同的簡稱是否為同一個交易對象?
                     #1.若選擇否，則不做任何控管繼續往下執行
                     #2.若選擇是，則將相同簡稱所對應的交易對象編號更新回pmaa001欄位中，
                     #  且其他交易對象資料欄位也移一併帶出顯示在畫面上，並將pmaa002更新為3(交易對象)
                     IF cl_ask_confirm('apm-00150') THEN
                        SELECT DISTINCT pmaal001 INTO g_pmaa_m.pmaa001 FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal004 = g_pmaa_m.pmaal004
                        SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        IF l_pmaa002 <> g_pmaa_m.pmaa002 THEN
                           LET g_pmaa_m.pmaamoddt = cl_get_current()
                           UPDATE pmaa_t SET pmaa002 = '3',pmaamodid = g_user,pmaamoddt = g_pmaa_m.pmaamoddt WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        END IF
                        SELECT UNIQUE pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa080,pmaa081,pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdt,pmaacrtdp,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt
                          INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt
                          FROM pmaa_t
                          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        CALL apmm100_show()
                        LET g_master_insert = TRUE  #170216-00073#1-----add
                        EXIT DIALOG
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal004
            #add-point:ON CHANGE pmaal004 name="input.g.pmaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal003
            #add-point:BEFORE FIELD pmaal003 name="input.b.pmaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal003
            
            #add-point:AFTER FIELD pmaal003 name="input.a.pmaal003"
            IF NOT cl_null(g_pmaa_m.pmaal003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaal003 != g_master_multi_table_t.pmaal003 OR cl_null(g_master_multi_table_t.pmaal003))) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal003 = g_pmaa_m.pmaal003 AND pmaal001 <> g_pmaa_m.pmaa001 AND pmaal002 = g_dlang
                  IF l_n > 0 THEN
                     #存在相同的全名是否為同一個交易對象?
                     #1.若選擇否，則不做任何控管繼續往下執行
                     #2.若選擇是，則將相同簡稱所對應的交易對象編號更新回pmaa001欄位中，
                     #  且其他交易對象資料欄位也移一併帶出顯示在畫面上，並將pmaa002更新為3(交易對象)
                     IF cl_ask_confirm('apm-00151') THEN
                        SELECT DISTINCT pmaal001 INTO g_pmaa_m.pmaa001 FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal003 = g_pmaa_m.pmaal003
                        SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        IF l_pmaa002 <> g_pmaa_m.pmaa002 THEN
                           LET g_pmaa_m.pmaamoddt = cl_get_current()
                           UPDATE pmaa_t SET pmaa002 = '3',pmaamodid = g_user,pmaamoddt = g_pmaa_m.pmaamoddt WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        END IF
                        SELECT UNIQUE pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa080,pmaa081,pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdt,pmaacrtdp,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt
                          INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt
                          FROM pmaa_t
                          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        CALL apmm100_show()
                        EXIT DIALOG
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal003
            #add-point:ON CHANGE pmaal003 name="input.g.pmaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal006
            #add-point:BEFORE FIELD pmaal006 name="input.b.pmaal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal006
            
            #add-point:AFTER FIELD pmaal006 name="input.a.pmaal006"
            IF NOT cl_null(g_pmaa_m.pmaal006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaal006 != g_master_multi_table_t.pmaal006 OR cl_null(g_master_multi_table_t.pmaal006))) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal006 = g_pmaa_m.pmaal006 AND pmaal001 <> g_pmaa_m.pmaa001 AND pmaal002 = g_dlang
                  IF l_n > 0 THEN
                     #存在相同的全名是否為同一個交易對象?
                     #1.若選擇否，則不做任何控管繼續往下執行
                     #2.若選擇是，則將相同簡稱所對應的交易對象編號更新回pmaa001欄位中，
                     #  且其他交易對象資料欄位也移一併帶出顯示在畫面上，並將pmaa002更新為3(交易對象)
                     IF cl_ask_confirm('apm-00151') THEN
                        SELECT DISTINCT pmaal001 INTO g_pmaa_m.pmaa001 FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal006 = g_pmaa_m.pmaal006
                        SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        IF l_pmaa002 <> g_pmaa_m.pmaa002 THEN
                           LET g_pmaa_m.pmaamoddt = cl_get_current()
                           UPDATE pmaa_t SET pmaa002 = '3',pmaamodid = g_user,pmaamoddt = g_pmaa_m.pmaamoddt WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        END IF
                        SELECT UNIQUE pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa080,pmaa081,pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdt,pmaacrtdp,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt
                          INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt
                          FROM pmaa_t
                          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        CALL apmm100_show()
                        EXIT DIALOG
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal006
            #add-point:ON CHANGE pmaal006 name="input.g.pmaal006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaal005
            #add-point:BEFORE FIELD pmaal005 name="input.b.pmaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaal005
            
            #add-point:AFTER FIELD pmaal005 name="input.a.pmaal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaal005
            #add-point:ON CHANGE pmaal005 name="input.g.pmaal005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa003
            #add-point:BEFORE FIELD pmaa003 name="input.b.pmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa003
            
            #add-point:AFTER FIELD pmaa003 name="input.a.pmaa003"
            IF NOT cl_null(g_pmaa_m.pmaa003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa003 != g_pmaa_m_t.pmaa003 OR cl_null(g_pmaa_m_t.pmaa003))) THEN 
                  #161230-00036#1-add(s)
                  LET l_ooef011 = ' '
                  SELECT ooef011 INTO l_ooef011 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                  IF l_ooef011 = 'TW' THEN
                     IF NOT cl_null(g_pmaa_m.pmaa003) THEN
                        #先檢查輸入的營利事業統一編號是否為8碼或都為數字
                        CALL s_rule_chk_vat_id_string(g_pmaa_m.pmaa003) RETURNING l_success
                        #170222-00019#1---mark--s
                        #IF NOT l_success THEN
                        #   LET g_pmaa_m.pmaa003 = g_pmaa_m_t.pmaa003
                        #   NEXT FIELD pmaa003
                        #END IF
                        #170222-00019#1---mark--e
                        #檢查營利事業統一編號邏輯
                        CALL s_rule_chk_vat_id(l_ooef011,g_pmaa_m.pmaa003) RETURNING l_success
                        #170222-00019#1---mark--s
                        #IF NOT l_success THEN
                        #   LET g_pmaa_m.pmaa003 = g_pmaa_m_t.pmaa003
                        #END IF
                        #170222-00019#1---mark--e
                     END IF 
                  END IF               
                  #161230-00036#1-add(e)
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa003 = g_pmaa_m.pmaa003
                  IF l_n > 0 THEN
                     #存在相同的稅籍編號是否為同一個交易對象?
                     #1.若選擇否，則不做任何控管繼續往下執行
                     #2.若選擇是，則將相同簡稱所對應的交易對象編號更新回pmaa001欄位中，
                     #  且其他交易對象資料欄位也移一併帶出顯示在畫面上，並將pmaa002更新為3(交易對象)
                     
                     IF cl_ask_confirm('apm-00152') THEN
                        SELECT pmaa001 INTO g_pmaa_m.pmaa001 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa003 = g_pmaa_m.pmaa003 AND ROWNUM =1
                        SELECT pmaa002 INTO l_pmaa002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        IF l_pmaa002 <> g_pmaa_m.pmaa002 THEN
                           LET g_pmaa_m.pmaamoddt = cl_get_current()
                           UPDATE pmaa_t SET pmaa002 = '3',pmaamodid = g_user,pmaamoddt = g_pmaa_m.pmaamoddt WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        END IF
                        SELECT UNIQUE pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa017,pmaa016,pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa080,pmaa081,pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid,pmaacrtdt,pmaacrtdp,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt
                          INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt
                          FROM pmaa_t
                          WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                        CALL apmm100_show()
                        EXIT DIALOG
                     END IF
                  END IF
                  #當此欄位值不是空白時且[T:營運據點資料檔].[C:專屬國家地區功能]為"台灣"，
                  #且[檢核稅務編號合理性]參數有勾選時，則需呼叫檢核統一編號的應用元件，s_rule_chk_vat_id_tw(pmaa003)
                  #檢核該編號是否合理。
                  #161230-00036#1 mark(s)
                  #LET l_ooef006 = ' '
                  #SELECT ooef006 INTO l_ooef006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                  #IF l_ooef006 = 'TW' OR l_ooef006 = 'tw' THEN
                  #   CALL s_rule_chk_vat_id(l_ooef006,g_pmaa_m.pmaa003) RETURNING l_success
                  #   IF NOT l_success THEN
                  #      LET g_pmaa_m.pmaa003 = g_pmaa_m_t.pmaa003
                  #      NEXT FIELD pmaa003
                  #   END IF
                  #END IF
                  #161230-00036#1 mark(e)
               END IF
            END IF
            LET g_pmaa_m_t.* = g_pmaa_m.* #161230-00036#1 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa003
            #add-point:ON CHANGE pmaa003 name="input.g.pmaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaastus
            #add-point:BEFORE FIELD pmaastus name="input.b.pmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaastus
            
            #add-point:AFTER FIELD pmaastus name="input.a.pmaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaastus
            #add-point:ON CHANGE pmaastus name="input.g.pmaastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa004
            #add-point:BEFORE FIELD pmaa004 name="input.b.pmaa004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa004
            
            #add-point:AFTER FIELD pmaa004 name="input.a.pmaa004"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa004
            #add-point:ON CHANGE pmaa004 name="input.g.pmaa004"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa005
            
            #add-point:AFTER FIELD pmaa005 name="input.a.pmaa005"
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
            DISPLAY BY NAME g_pmaa_m.pmaa005_desc
            IF g_pmaa_m.pmaa004 MATCHES '[13]' THEN
               IF NOT cl_null(g_pmaa_m.pmaa005) THEN 
                  #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa005 != g_pmaa_m_t.pmaa005 OR cl_null(g_pmaa_m_t.pmaa005))) THEN 
                     IF NOT ap_chk_isExist(g_pmaa_m.pmaa005,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
                        LET g_pmaa_m.pmaa005 = g_pmaa_m_t.pmaa005
                        CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
                        DISPLAY BY NAME g_pmaa_m.pmaa005_desc
                        NEXT FIELD CURRENT
                     END IF
                     #IF NOT ap_chk_isExist(g_pmaa_m.pmaa005,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN             #160318-00005#34
                      IF NOT ap_chk_isExist(g_pmaa_m.pmaa005,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apsub-01302",'apmm100' ) THEN   #160318-00005#34
                        LET g_pmaa_m.pmaa005 = g_pmaa_m_t.pmaa005
                        CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
                        DISPLAY BY NAME g_pmaa_m.pmaa005_desc
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT ap_chk_isExist(g_pmaa_m.pmaa005,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaa004 = '1' AND pmaa001 != '"||g_pmaa_m.pmaa001||"' ","apm-00085",1 ) THEN
                        LET g_pmaa_m.pmaa005 = g_pmaa_m_t.pmaa005
                        CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
                        DISPLAY BY NAME g_pmaa_m.pmaa005_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
            DISPLAY BY NAME g_pmaa_m.pmaa005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa005
            #add-point:BEFORE FIELD pmaa005 name="input.b.pmaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa005
            #add-point:ON CHANGE pmaa005 name="input.g.pmaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa006
            
            #add-point:AFTER FIELD pmaa006 name="input.a.pmaa006"
            CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
            DISPLAY BY NAME g_pmaa_m.pmaa006_desc
            IF NOT cl_null(g_pmaa_m.pmaa006) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa006 != g_pmaa_m_t.pmaa006 OR cl_null(g_pmaa_m_t.pmaa006))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa006,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '261' AND oocq002 = ? ","apm-00148",1 ) THEN           #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa006,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '261' AND oocq002 = ? ","sub-01303",'apmi013' ) THEN    #160318-00005#34
                     LET g_pmaa_m.pmaa006 = g_pmaa_m_t.pmaa006
                     CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa006,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '261' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00149",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa006,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '261' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi013' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa006 = g_pmaa_m_t.pmaa006
                     CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
            DISPLAY BY NAME g_pmaa_m.pmaa006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa006
            #add-point:BEFORE FIELD pmaa006 name="input.b.pmaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa006
            #add-point:ON CHANGE pmaa006 name="input.g.pmaa006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa007
            
            #add-point:AFTER FIELD pmaa007 name="input.a.pmaa007"
            CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
            DISPLAY BY NAME g_pmaa_m.pmaa007_desc
            IF NOT cl_null(g_pmaa_m.pmaa007) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa007 != g_pmaa_m_t.pmaa007 OR cl_null(g_pmaa_m_t.pmaa007))) THEN 
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa007,"SELECT COUNT(*) FROM oocg_t WHERE oocgent = '" ||g_enterprise||"' AND oocg001 = ? ","aoo-00013",1 ) THEN
                     LET g_pmaa_m.pmaa007 = g_pmaa_m_t.pmaa007
                     CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa007,"SELECT COUNT(*) FROM oocg_t WHERE oocgent = '" ||g_enterprise||"' AND oocg001 = ? AND oocgstus = 'Y' ","aoo-00035",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa007,"SELECT COUNT(*) FROM oocg_t WHERE oocgent = '" ||g_enterprise||"' AND oocg001 = ? AND oocgstus = 'Y' ","sub-01302",'aooi020' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa007 = g_pmaa_m_t.pmaa007
                     CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
            DISPLAY BY NAME g_pmaa_m.pmaa007_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa007
            #add-point:BEFORE FIELD pmaa007 name="input.b.pmaa007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa007
            #add-point:ON CHANGE pmaa007 name="input.g.pmaa007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa008
            #add-point:BEFORE FIELD pmaa008 name="input.b.pmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa008
            
            #add-point:AFTER FIELD pmaa008 name="input.a.pmaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa008
            #add-point:ON CHANGE pmaa008 name="input.g.pmaa008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa009
            
            #add-point:AFTER FIELD pmaa009 name="input.a.pmaa009"
            CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
            DISPLAY BY NAME g_pmaa_m.pmaa009_desc
            
            IF NOT cl_null(g_pmaa_m.pmaa009) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa009 != g_pmaa_m_t.pmaa009 OR cl_null(g_pmaa_m_t.pmaa009))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa009,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '" ||g_enterprise||"' AND ooal001 = '4' AND ooal002 = ? ","aoo-00125",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa009,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '" ||g_enterprise||"' AND ooal001 = '4' AND ooal002 = ? ","sub-01305",'aooi074' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa009 = g_pmaa_m_t.pmaa009
                     CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa009_desc
                     NEXT FIELD pmaa009
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa009,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '" ||g_enterprise||"' AND ooal001 = '4' AND ooalstus = 'Y' AND ooal002 = ? ","aoo-00124",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa009,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '" ||g_enterprise||"' AND ooal001 = '4' AND ooalstus = 'Y' AND ooal002 = ? ","sub-01302",'aooi074' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa009 = g_pmaa_m_t.pmaa009
                     CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa009_desc
                     NEXT FIELD pmaa009
                  END IF
               END IF
            END IF

            CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
            DISPLAY BY NAME g_pmaa_m.pmaa009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa009
            #add-point:BEFORE FIELD pmaa009 name="input.b.pmaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa009
            #add-point:ON CHANGE pmaa009 name="input.g.pmaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa010
            #add-point:BEFORE FIELD pmaa010 name="input.b.pmaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa010
            
            #add-point:AFTER FIELD pmaa010 name="input.a.pmaa010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa010
            #add-point:ON CHANGE pmaa010 name="input.g.pmaa010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa011
            
            #add-point:AFTER FIELD pmaa011 name="input.a.pmaa011"
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa011) RETURNING g_pmaa_m.pmaa011_desc
            DISPLAY BY NAME g_pmaa_m.pmaa011_desc
            
            IF NOT cl_null(g_pmaa_m.pmaa011) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa011 != g_pmaa_m_t.pmaa011 OR cl_null(g_pmaa_m_t.pmaa011))) THEN 
                  IF NOT apmm100_pmaa011_chk(g_pmaa_m.pmaa011) THEN
                     LET g_pmaa_m.pmaa011 = g_pmaa_m_t.pmaa011
                     CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa011) RETURNING g_pmaa_m.pmaa011_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa011_desc
                     NEXT FIELD pmaa011
                  END IF
               END IF
               IF cl_null(g_pmaa_m.pmaa019) THEN
                  LET g_pmaa_m.pmaa019 = g_pmaa_m.pmaa011
                  CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
                  DISPLAY BY NAME g_pmaa_m.pmaa019_desc
               END IF
               IF cl_null(g_pmaa_m.pmaa022) THEN
                  LET g_pmaa_m.pmaa022 = g_pmaa_m.pmaa011
                  CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
                  DISPLAY BY NAME g_pmaa_m.pmaa022_desc
               END IF            
            END IF
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa011) RETURNING g_pmaa_m.pmaa011_desc
            DISPLAY BY NAME g_pmaa_m.pmaa011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa011
            #add-point:BEFORE FIELD pmaa011 name="input.b.pmaa011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa011
            #add-point:ON CHANGE pmaa011 name="input.g.pmaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa230
            #add-point:BEFORE FIELD pmaa230 name="input.b.pmaa230"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa230
            
            #add-point:AFTER FIELD pmaa230 name="input.a.pmaa230"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa230
            #add-point:ON CHANGE pmaa230 name="input.g.pmaa230"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaud001
            #add-point:BEFORE FIELD pmaaud001 name="input.b.pmaaud001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaud001
            
            #add-point:AFTER FIELD pmaaud001 name="input.a.pmaaud001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaaud001
            #add-point:ON CHANGE pmaaud001 name="input.g.pmaaud001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaaud002
            #add-point:BEFORE FIELD pmaaud002 name="input.b.pmaaud002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaaud002
            
            #add-point:AFTER FIELD pmaaud002 name="input.a.pmaaud002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaaud002
            #add-point:ON CHANGE pmaaud002 name="input.g.pmaaud002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa017
            #add-point:BEFORE FIELD pmaa017 name="input.b.pmaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa017
            
            #add-point:AFTER FIELD pmaa017 name="input.a.pmaa017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa017
            #add-point:ON CHANGE pmaa017 name="input.g.pmaa017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa016
            #add-point:BEFORE FIELD pmaa016 name="input.b.pmaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa016
            
            #add-point:AFTER FIELD pmaa016 name="input.a.pmaa016"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa016
            #add-point:ON CHANGE pmaa016 name="input.g.pmaa016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa018
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa018 name="input.a.pmaa018"
            IF NOT cl_null(g_pmaa_m.pmaa018) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa018
            #add-point:BEFORE FIELD pmaa018 name="input.b.pmaa018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa018
            #add-point:ON CHANGE pmaa018 name="input.g.pmaa018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa019
            
            #add-point:AFTER FIELD pmaa019 name="input.a.pmaa019"
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
            DISPLAY BY NAME g_pmaa_m.pmaa019_desc
            
            IF NOT cl_null(g_pmaa_m.pmaa019) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa019 != g_pmaa_m_t.pmaa019 OR cl_null(g_pmaa_m_t.pmaa019))) THEN 
                  IF NOT apmm100_pmaa011_chk(g_pmaa_m.pmaa019) THEN
                     LET g_pmaa_m.pmaa019 = g_pmaa_m_t.pmaa019
                     CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa019_desc
                     NEXT FIELD pmaa019
                  END IF
               END IF  
            END IF
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
            DISPLAY BY NAME g_pmaa_m.pmaa019_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa019
            #add-point:BEFORE FIELD pmaa019 name="input.b.pmaa019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa019
            #add-point:ON CHANGE pmaa019 name="input.g.pmaa019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa021
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa021 name="input.a.pmaa021"
            IF NOT cl_null(g_pmaa_m.pmaa021) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa021
            #add-point:BEFORE FIELD pmaa021 name="input.b.pmaa021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa021
            #add-point:ON CHANGE pmaa021 name="input.g.pmaa021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa022
            
            #add-point:AFTER FIELD pmaa022 name="input.a.pmaa022"
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
            DISPLAY BY NAME g_pmaa_m.pmaa022_desc
            
            IF NOT cl_null(g_pmaa_m.pmaa022) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa022 != g_pmaa_m_t.pmaa022 OR cl_null(g_pmaa_m_t.pmaa022))) THEN 
                  IF NOT apmm100_pmaa011_chk(g_pmaa_m.pmaa022) THEN
                     LET g_pmaa_m.pmaa022 = g_pmaa_m_t.pmaa022
                     CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa022_desc
                     NEXT FIELD pmaa022
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
            DISPLAY BY NAME g_pmaa_m.pmaa022_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa022
            #add-point:BEFORE FIELD pmaa022 name="input.b.pmaa022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa022
            #add-point:ON CHANGE pmaa022 name="input.g.pmaa022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa020
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa020 name="input.a.pmaa020"
            IF NOT cl_null(g_pmaa_m.pmaa020) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa020
            #add-point:BEFORE FIELD pmaa020 name="input.b.pmaa020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa020
            #add-point:ON CHANGE pmaa020 name="input.g.pmaa020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa023
            
            #add-point:AFTER FIELD pmaa023 name="input.a.pmaa023"
            CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
            DISPLAY BY NAME g_pmaa_m.pmaa023_desc
            IF NOT cl_null(g_pmaa_m.pmaa023) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa023 != g_pmaa_m_t.pmaa023 OR cl_null(g_pmaa_m_t.pmaa023))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa023,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '254' AND oocq002 = ? ","apm-00086",1 ) THEN           #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa023,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '254' AND oocq002 = ? ","sub-01303",'apmi007' ) THEN    #160318-00005#34
                     LET g_pmaa_m.pmaa023 = g_pmaa_m_t.pmaa023
                     CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa023_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa023,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '254' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00087",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa023,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '254' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi007' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa023 = g_pmaa_m_t.pmaa023
                     CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa023_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
            DISPLAY BY NAME g_pmaa_m.pmaa023_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa023
            #add-point:BEFORE FIELD pmaa023 name="input.b.pmaa023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa023
            #add-point:ON CHANGE pmaa023 name="input.g.pmaa023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa024
            
            #add-point:AFTER FIELD pmaa024 name="input.a.pmaa024"
            CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
            DISPLAY BY NAME g_pmaa_m.pmaa024_desc
            IF NOT cl_null(g_pmaa_m.pmaa024) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa024 != g_pmaa_m_t.pmaa024 OR cl_null(g_pmaa_m_t.pmaa024))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa024,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '260' AND oocq002 = ? ","apm-00088",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa024,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '260' AND oocq002 = ? ","sub-01303",'apmi009' ) THEN   #160318-00005#34 
                     LET g_pmaa_m.pmaa024 = g_pmaa_m_t.pmaa024
                     CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa024_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa024,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '260' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00089",1 ) THEN         #160318-00005#34 
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa024,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '260' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi009' ) THEN  #160318-00005#34                
                     LET g_pmaa_m.pmaa024 = g_pmaa_m_t.pmaa024
                     CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa024_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
            DISPLAY BY NAME g_pmaa_m.pmaa024_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa024
            #add-point:BEFORE FIELD pmaa024 name="input.b.pmaa024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa024
            #add-point:ON CHANGE pmaa024 name="input.g.pmaa024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa025
            #add-point:BEFORE FIELD pmaa025 name="input.b.pmaa025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa025
            
            #add-point:AFTER FIELD pmaa025 name="input.a.pmaa025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa025
            #add-point:ON CHANGE pmaa025 name="input.g.pmaa025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa026
            
            #add-point:AFTER FIELD pmaa026 name="input.a.pmaa026"
            CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
            DISPLAY BY NAME g_pmaa_m.pmaa026_desc
            IF NOT cl_null(g_pmaa_m.pmaa026) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa026 != g_pmaa_m_t.pmaa026 OR cl_null(g_pmaa_m_t.pmaa026))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa026,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '250' AND oocq002 = ? ","apm-00090",1 ) THEN
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa026,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '250' AND oocq002 = ? ","sub-01303",'apmi006' ) THEN
                     LET g_pmaa_m.pmaa026 = g_pmaa_m_t.pmaa026
                     CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa026_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa026,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '250' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00091",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa026,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '250' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi006' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa026 = g_pmaa_m_t.pmaa026
                     CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa026_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
            DISPLAY BY NAME g_pmaa_m.pmaa026_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa026
            #add-point:BEFORE FIELD pmaa026 name="input.b.pmaa026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa026
            #add-point:ON CHANGE pmaa026 name="input.g.pmaa026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa098
            #add-point:BEFORE FIELD pmaa098 name="input.b.pmaa098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa098
            
            #add-point:AFTER FIELD pmaa098 name="input.a.pmaa098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa098
            #add-point:ON CHANGE pmaa098 name="input.g.pmaa098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa028
            #add-point:BEFORE FIELD pmaa028 name="input.b.pmaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa028
            
            #add-point:AFTER FIELD pmaa028 name="input.a.pmaa028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa028
            #add-point:ON CHANGE pmaa028 name="input.g.pmaa028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa029
            #add-point:BEFORE FIELD pmaa029 name="input.b.pmaa029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa029
            
            #add-point:AFTER FIELD pmaa029 name="input.a.pmaa029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa029
            #add-point:ON CHANGE pmaa029 name="input.g.pmaa029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa090
            
            #add-point:AFTER FIELD pmaa090 name="input.a.pmaa090"
            CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
            DISPLAY BY NAME g_pmaa_m.pmaa090_desc
            IF NOT cl_null(g_pmaa_m.pmaa090) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa090 != g_pmaa_m_t.pmaa090 OR cl_null(g_pmaa_m_t.pmaa090))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '281' AND oocq002 = ? ","apm-00092",1 ) THEN             #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '281' AND oocq002 = ? ","sub-01303",'axmi021' ) THEN      #160318-00005#34
                     LET g_pmaa_m.pmaa090 = g_pmaa_m_t.pmaa090
                     CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa090_desc
                     NEXT FIELD CURRENT
                  END IF
                 #IF NOT ap_chk_isExist(g_pmaa_m.pmaa090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '281' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00093",1 ) THEN         #160318-00005#34
                 IF NOT ap_chk_isExist(g_pmaa_m.pmaa090,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '281' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi021' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa090 = g_pmaa_m_t.pmaa090
                     CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa090_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
            DISPLAY BY NAME g_pmaa_m.pmaa090_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa090
            #add-point:BEFORE FIELD pmaa090 name="input.b.pmaa090"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa090
            #add-point:ON CHANGE pmaa090 name="input.g.pmaa090"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa091
            
            #add-point:AFTER FIELD pmaa091 name="input.a.pmaa091"
            CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
            DISPLAY BY NAME g_pmaa_m.pmaa091_desc
            IF NOT cl_null(g_pmaa_m.pmaa091) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa091 != g_pmaa_m_t.pmaa091 OR cl_null(g_pmaa_m_t.pmaa091))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '283' AND oocq002 = ? ","apm-00146",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '283' AND oocq002 = ? ","sub-01303",'axmi023' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa091 = g_pmaa_m_t.pmaa091
                     CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa091_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '283' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00147",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa091,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '283' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi023' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa091 = g_pmaa_m_t.pmaa091
                     CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa091_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
            DISPLAY BY NAME g_pmaa_m.pmaa091_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa091
            #add-point:BEFORE FIELD pmaa091 name="input.b.pmaa091"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa091
            #add-point:ON CHANGE pmaa091 name="input.g.pmaa091"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa092
            #add-point:BEFORE FIELD pmaa092 name="input.b.pmaa092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa092
            
            #add-point:AFTER FIELD pmaa092 name="input.a.pmaa092"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa092
            #add-point:ON CHANGE pmaa092 name="input.g.pmaa092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa094
            
            #add-point:AFTER FIELD pmaa094 name="input.a.pmaa094"
            CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
            DISPLAY BY NAME g_pmaa_m.pmaa094_desc
            IF NOT cl_null(g_pmaa_m.pmaa094) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa094 != g_pmaa_m_t.pmaa094 OR cl_null(g_pmaa_m_t.pmaa094))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa094,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '286' AND oocq002 = ? ","apm-00094",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa094,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '286' AND oocq002 = ? ","sub-01303",'axmi026' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa094 = g_pmaa_m_t.pmaa094
                     CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa094_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa094,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '286' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00095",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa094,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '286' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi026' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa094 = g_pmaa_m_t.pmaa094
                     CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa094_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
            DISPLAY BY NAME g_pmaa_m.pmaa094_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa094
            #add-point:BEFORE FIELD pmaa094 name="input.b.pmaa094"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa094
            #add-point:ON CHANGE pmaa094 name="input.g.pmaa094"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa093
            
            #add-point:AFTER FIELD pmaa093 name="input.a.pmaa093"
            CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
            DISPLAY BY NAME g_pmaa_m.pmaa093_desc
            IF NOT cl_null(g_pmaa_m.pmaa093) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa093 != g_pmaa_m_t.pmaa093 OR cl_null(g_pmaa_m_t.pmaa093))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa093,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '285' AND oocq002 = ? ","apm-00096",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa093,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '285' AND oocq002 = ? ","sub-01303",'axmi025' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa093 = g_pmaa_m_t.pmaa093
                     CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa093_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa093,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '285' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00097",1 ) THEN
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa093,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '285' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi025' ) THEN
                     LET g_pmaa_m.pmaa093 = g_pmaa_m_t.pmaa093
                     CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa093_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
            DISPLAY BY NAME g_pmaa_m.pmaa093_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa093
            #add-point:BEFORE FIELD pmaa093 name="input.b.pmaa093"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa093
            #add-point:ON CHANGE pmaa093 name="input.g.pmaa093"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa095
            
            #add-point:AFTER FIELD pmaa095 name="input.a.pmaa095"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaa095
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaa095_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaa095_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa095
            #add-point:BEFORE FIELD pmaa095 name="input.b.pmaa095"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa095
            #add-point:ON CHANGE pmaa095 name="input.g.pmaa095"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa096
            
            #add-point:AFTER FIELD pmaa096 name="input.a.pmaa096"
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa096) RETURNING g_pmaa_m.pmaa096_desc
            DISPLAY BY NAME g_pmaa_m.pmaa096_desc
            IF NOT cl_null(g_pmaa_m.pmaa096) THEN
            #150303---earl---mod---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa096 != g_pmaa_m_t.pmaa096 OR cl_null(g_pmaa_m_t.pmaa096))) THEN 
               IF g_pmaa_m.pmaa096 <> g_pmaa_m_o.pmaa096 OR cl_null(g_pmaa_m_o.pmaa096) THEN
                  IF NOT apmm100_pmaa096_chk(g_pmaa_m.pmaa096) THEN
                     #LET g_pmaa_m.pmaa096 = g_pmaa_m_t.pmaa096
                     LET g_pmaa_m.pmaa096 = g_pmaa_m_o.pmaa096
                     CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa096) RETURNING g_pmaa_m.pmaa096_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa096_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmaa_m.pmaa096) RETURNING l_success,l_errno,g_pmaa_m.pmaa097,g_pmaa_m.pmaa097_desc
                  DISPLAY BY NAME g_pmaa_m.pmaa097
                  DISPLAY BY NAME g_pmaa_m.pmaa097_desc
                  LET g_pmaa_m_o.pmaa097 = g_pmaa_m.pmaa097
                  
               END IF
            END IF
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa096) RETURNING g_pmaa_m.pmaa096_desc
            DISPLAY BY NAME g_pmaa_m.pmaa096_desc
            
            LET g_pmaa_m_o.pmaa096 = g_pmaa_m.pmaa096
            #150303---earl---mod---e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa096
            #add-point:BEFORE FIELD pmaa096 name="input.b.pmaa096"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa096
            #add-point:ON CHANGE pmaa096 name="input.g.pmaa096"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa097
            
            #add-point:AFTER FIELD pmaa097 name="input.a.pmaa097"
            CALL s_desc_get_department_desc(g_pmaa_m.pmaa097) RETURNING g_pmaa_m.pmaa097_desc
            DISPLAY BY NAME g_pmaa_m.pmaa097_desc

            IF NOT cl_null(g_pmaa_m.pmaa097) THEN 
               IF g_pmaa_m.pmaa097 <> g_pmaa_m_o.pmaa097 OR cl_null(g_pmaa_m_o.pmaa097) THEN 
                  IF NOT s_department_chk(g_pmaa_m.pmaa097,g_today) THEN
                     LET g_pmaa_m.pmaa097 = g_pmaa_m_o.pmaa097

                     CALL s_desc_get_department_desc(g_pmaa_m.pmaa097) RETURNING g_pmaa_m.pmaa097_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa097_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF
            
            LET g_pmaa_m_o.pmaa097 = g_pmaa_m.pmaa097
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa097
            #add-point:BEFORE FIELD pmaa097 name="input.b.pmaa097"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa097
            #add-point:ON CHANGE pmaa097 name="input.g.pmaa097"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa080
            
            #add-point:AFTER FIELD pmaa080 name="input.a.pmaa080"
            CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
            DISPLAY BY NAME g_pmaa_m.pmaa080_desc
            IF NOT cl_null(g_pmaa_m.pmaa080) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa080 != g_pmaa_m_t.pmaa080 OR cl_null(g_pmaa_m_t.pmaa080))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa080,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '251' AND oocq002 = ? ","apm-00098",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa080,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '251' AND oocq002 = ? ","sub-01303",'apmi024' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa080 = g_pmaa_m_t.pmaa080
                     CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa080_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa080,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '251' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00099",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa080,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '251' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi024' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa080 = g_pmaa_m_t.pmaa080
                     CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa080_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
            DISPLAY BY NAME g_pmaa_m.pmaa080_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa080
            #add-point:BEFORE FIELD pmaa080 name="input.b.pmaa080"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa080
            #add-point:ON CHANGE pmaa080 name="input.g.pmaa080"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa081
            
            #add-point:AFTER FIELD pmaa081 name="input.a.pmaa081"
            CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
            DISPLAY BY NAME g_pmaa_m.pmaa081_desc
            IF NOT cl_null(g_pmaa_m.pmaa081) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa081 != g_pmaa_m_t.pmaa081 OR cl_null(g_pmaa_m_t.pmaa081))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa081,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '253' AND oocq002 = ? ","apm-00100",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa081,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '253' AND oocq002 = ? ","sub-01303",'apmi023' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa081 = g_pmaa_m_t.pmaa081
                     CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa081_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa081,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '253' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00101",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa081,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '253' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi023' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa081 = g_pmaa_m_t.pmaa081
                     CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa081_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
            DISPLAY BY NAME g_pmaa_m.pmaa081_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa081
            #add-point:BEFORE FIELD pmaa081 name="input.b.pmaa081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa081
            #add-point:ON CHANGE pmaa081 name="input.g.pmaa081"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa082
            #add-point:BEFORE FIELD pmaa082 name="input.b.pmaa082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa082
            
            #add-point:AFTER FIELD pmaa082 name="input.a.pmaa082"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa082
            #add-point:ON CHANGE pmaa082 name="input.g.pmaa082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa084
            
            #add-point:AFTER FIELD pmaa084 name="input.a.pmaa084"
            CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
            DISPLAY BY NAME g_pmaa_m.pmaa084_desc
            IF NOT cl_null(g_pmaa_m.pmaa084) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa084 != g_pmaa_m_t.pmaa084 OR cl_null(g_pmaa_m_t.pmaa084))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa084,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '256' AND oocq002 = ? ","apm-00102",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa084,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '256' AND oocq002 = ? ","sub-01303",'apmi026' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa084 = g_pmaa_m_t.pmaa084
                     CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa084_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa084,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '256' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00103",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa084,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '256' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi026' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa084 = g_pmaa_m_t.pmaa084
                     CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa084_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
            DISPLAY BY NAME g_pmaa_m.pmaa084_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa084
            #add-point:BEFORE FIELD pmaa084 name="input.b.pmaa084"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa084
            #add-point:ON CHANGE pmaa084 name="input.g.pmaa084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa083
            
            #add-point:AFTER FIELD pmaa083 name="input.a.pmaa083"
            CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
            DISPLAY BY NAME g_pmaa_m.pmaa083_desc
            IF NOT cl_null(g_pmaa_m.pmaa083) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa083 != g_pmaa_m_t.pmaa083 OR cl_null(g_pmaa_m_t.pmaa083))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa083,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '255' AND oocq002 = ? ","apm-00104",1 ) THEN  #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa083,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '255' AND oocq002 = ? ","sub-01303",'apmi025' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa083 = g_pmaa_m_t.pmaa083
                     CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa083_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa083,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '255' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00105",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa083,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '255' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi025' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa083 = g_pmaa_m_t.pmaa083
                     CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa083_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
            DISPLAY BY NAME g_pmaa_m.pmaa083_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa083
            #add-point:BEFORE FIELD pmaa083 name="input.b.pmaa083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa083
            #add-point:ON CHANGE pmaa083 name="input.g.pmaa083"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa085
            
            #add-point:AFTER FIELD pmaa085 name="input.a.pmaa085"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaa085
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaa085_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaa085_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa085
            #add-point:BEFORE FIELD pmaa085 name="input.b.pmaa085"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa085
            #add-point:ON CHANGE pmaa085 name="input.g.pmaa085"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa086
            
            #add-point:AFTER FIELD pmaa086 name="input.a.pmaa086"
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa086) RETURNING g_pmaa_m.pmaa086_desc
            DISPLAY BY NAME g_pmaa_m.pmaa086_desc
            IF NOT cl_null(g_pmaa_m.pmaa086) THEN
            #150303---earl---mod---s
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa086 != g_pmaa_m_t.pmaa086 OR cl_null(g_pmaa_m_t.pmaa086))) THEN 
               IF g_pmaa_m.pmaa086 <> g_pmaa_m_o.pmaa086 OR cl_null(g_pmaa_m_o.pmaa086) THEN
                  IF NOT apmm100_pmaa096_chk(g_pmaa_m.pmaa086) THEN
                     #LET g_pmaa_m.pmaa086 = g_pmaa_m_t.pmaa086
                     LET g_pmaa_m.pmaa086 = g_pmaa_m_o.pmaa086
                     CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa086) RETURNING g_pmaa_m.pmaa086_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa086_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #帶出部門
                  CALL s_employee_get_dept(g_pmaa_m.pmaa086) RETURNING l_success,l_errno,g_pmaa_m.pmaa087,g_pmaa_m.pmaa087_desc
                  DISPLAY BY NAME g_pmaa_m.pmaa087
                  DISPLAY BY NAME g_pmaa_m.pmaa087_desc
                  LET g_pmaa_m_o.pmaa087 = g_pmaa_m.pmaa087
                  
               END IF
            END IF
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa086) RETURNING g_pmaa_m.pmaa086_desc
            DISPLAY BY NAME g_pmaa_m.pmaa086_desc

            LET g_pmaa_m_o.pmaa086 = g_pmaa_m.pmaa086
            #150303---earl---mod---e                  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa086
            #add-point:BEFORE FIELD pmaa086 name="input.b.pmaa086"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa086
            #add-point:ON CHANGE pmaa086 name="input.g.pmaa086"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa087
            
            #add-point:AFTER FIELD pmaa087 name="input.a.pmaa087"
            CALL s_desc_get_department_desc(g_pmaa_m.pmaa087) RETURNING g_pmaa_m.pmaa087_desc
            DISPLAY BY NAME g_pmaa_m.pmaa087_desc

            IF NOT cl_null(g_pmaa_m.pmaa087) THEN 
               IF g_pmaa_m.pmaa087 <> g_pmaa_m_o.pmaa087 OR cl_null(g_pmaa_m_o.pmaa087) THEN 
                  IF NOT s_department_chk(g_pmaa_m.pmaa087,g_today) THEN
                     LET g_pmaa_m.pmaa087 = g_pmaa_m_o.pmaa087

                     CALL s_desc_get_department_desc(g_pmaa_m.pmaa087) RETURNING g_pmaa_m.pmaa087_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa087_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF

            LET g_pmaa_m_o.pmaa087 = g_pmaa_m.pmaa087
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa087
            #add-point:BEFORE FIELD pmaa087 name="input.b.pmaa087"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa087
            #add-point:ON CHANGE pmaa087 name="input.g.pmaa087"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa088
            #add-point:BEFORE FIELD pmaa088 name="input.b.pmaa088"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa088
            
            #add-point:AFTER FIELD pmaa088 name="input.a.pmaa088"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa088
            #add-point:ON CHANGE pmaa088 name="input.g.pmaa088"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa047
            #add-point:BEFORE FIELD pmaa047 name="input.b.pmaa047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa047
            
            #add-point:AFTER FIELD pmaa047 name="input.a.pmaa047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa047
            #add-point:ON CHANGE pmaa047 name="input.g.pmaa047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa037
            #add-point:BEFORE FIELD pmaa037 name="input.b.pmaa037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa037
            
            #add-point:AFTER FIELD pmaa037 name="input.a.pmaa037"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa037
            #add-point:ON CHANGE pmaa037 name="input.g.pmaa037"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa036
            #add-point:BEFORE FIELD pmaa036 name="input.b.pmaa036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa036
            
            #add-point:AFTER FIELD pmaa036 name="input.a.pmaa036"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa036
            #add-point:ON CHANGE pmaa036 name="input.g.pmaa036"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa038,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa038
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa038 name="input.a.pmaa038"
            IF NOT cl_null(g_pmaa_m.pmaa038) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa038
            #add-point:BEFORE FIELD pmaa038 name="input.b.pmaa038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa038
            #add-point:ON CHANGE pmaa038 name="input.g.pmaa038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa039
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa039,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa039
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa039 name="input.a.pmaa039"
            IF NOT cl_null(g_pmaa_m.pmaa039) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa039
            #add-point:BEFORE FIELD pmaa039 name="input.b.pmaa039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa039
            #add-point:ON CHANGE pmaa039 name="input.g.pmaa039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa040,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa040
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa040 name="input.a.pmaa040"
            IF NOT cl_null(g_pmaa_m.pmaa040) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa040
            #add-point:BEFORE FIELD pmaa040 name="input.b.pmaa040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa040
            #add-point:ON CHANGE pmaa040 name="input.g.pmaa040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa041
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa041,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa041
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa041 name="input.a.pmaa041"
            IF NOT cl_null(g_pmaa_m.pmaa041) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa041
            #add-point:BEFORE FIELD pmaa041 name="input.b.pmaa041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa041
            #add-point:ON CHANGE pmaa041 name="input.g.pmaa041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa042
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa042,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa042
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa042 name="input.a.pmaa042"
            IF NOT cl_null(g_pmaa_m.pmaa042) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa042
            #add-point:BEFORE FIELD pmaa042 name="input.b.pmaa042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa042
            #add-point:ON CHANGE pmaa042 name="input.g.pmaa042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa043
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa043,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa043
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa043 name="input.a.pmaa043"
            IF NOT cl_null(g_pmaa_m.pmaa043) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa043
            #add-point:BEFORE FIELD pmaa043 name="input.b.pmaa043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa043
            #add-point:ON CHANGE pmaa043 name="input.g.pmaa043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa044,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa044
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa044 name="input.a.pmaa044"
            IF NOT cl_null(g_pmaa_m.pmaa044) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa044
            #add-point:BEFORE FIELD pmaa044 name="input.b.pmaa044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa044
            #add-point:ON CHANGE pmaa044 name="input.g.pmaa044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa045,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa045
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa045 name="input.a.pmaa045"
            IF NOT cl_null(g_pmaa_m.pmaa045) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa045
            #add-point:BEFORE FIELD pmaa045 name="input.b.pmaa045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa045
            #add-point:ON CHANGE pmaa045 name="input.g.pmaa045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa046,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD pmaa046
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa046 name="input.a.pmaa046"
            IF NOT cl_null(g_pmaa_m.pmaa046) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa046
            #add-point:BEFORE FIELD pmaa046 name="input.b.pmaa046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa046
            #add-point:ON CHANGE pmaa046 name="input.g.pmaa046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa068
            #add-point:BEFORE FIELD pmaa068 name="input.b.pmaa068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa068
            
            #add-point:AFTER FIELD pmaa068 name="input.a.pmaa068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa068
            #add-point:ON CHANGE pmaa068 name="input.g.pmaa068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa069
            #add-point:BEFORE FIELD pmaa069 name="input.b.pmaa069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa069
            
            #add-point:AFTER FIELD pmaa069 name="input.a.pmaa069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa069
            #add-point:ON CHANGE pmaa069 name="input.g.pmaa069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa072
            #add-point:BEFORE FIELD pmaa072 name="input.b.pmaa072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa072
            
            #add-point:AFTER FIELD pmaa072 name="input.a.pmaa072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa072
            #add-point:ON CHANGE pmaa072 name="input.g.pmaa072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa070
            #add-point:BEFORE FIELD pmaa070 name="input.b.pmaa070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa070
            
            #add-point:AFTER FIELD pmaa070 name="input.a.pmaa070"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa070
            #add-point:ON CHANGE pmaa070 name="input.g.pmaa070"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa071
            #add-point:BEFORE FIELD pmaa071 name="input.b.pmaa071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa071
            
            #add-point:AFTER FIELD pmaa071 name="input.a.pmaa071"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa071
            #add-point:ON CHANGE pmaa071 name="input.g.pmaa071"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa073
            #add-point:BEFORE FIELD pmaa073 name="input.b.pmaa073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa073
            
            #add-point:AFTER FIELD pmaa073 name="input.a.pmaa073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa073
            #add-point:ON CHANGE pmaa073 name="input.g.pmaa073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa051
            #add-point:BEFORE FIELD pmaa051 name="input.b.pmaa051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa051
            
            #add-point:AFTER FIELD pmaa051 name="input.a.pmaa051"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa051
            #add-point:ON CHANGE pmaa051 name="input.g.pmaa051"
            CALL apmm100_set_entry(p_cmd)
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            CALL apmm100_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa052
            
            #add-point:AFTER FIELD pmaa052 name="input.a.pmaa052"
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            DISPLAY BY NAME g_pmaa_m.pmaa052_desc
            IF NOT cl_null(g_pmaa_m.pmaa052) THEN
               IF g_pmaa_m.pmaa052 != g_pmaa_m_t.pmaa052 OR cl_null(g_pmaa_m_t.pmaa052) THEN 
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
                     LET g_pmaa_m.pmaa052 = g_pmaa_m_t.pmaa052
                     CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa052_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN           #160318-00005#34
                   IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa052 = g_pmaa_m_t.pmaa052
                     CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa052_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            DISPLAY BY NAME g_pmaa_m.pmaa052_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa052
            #add-point:BEFORE FIELD pmaa052 name="input.b.pmaa052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa052
            #add-point:ON CHANGE pmaa052 name="input.g.pmaa052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa053
            
            #add-point:AFTER FIELD pmaa053 name="input.a.pmaa053"
            #ming 20140817 modify ---------------------------------------------------------(S) 
            #CALL s_desc_get_acc_desc('296',g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #ming 20140817 modify ---------------------------------------------------------(E) 
            DISPLAY BY NAME g_pmaa_m.pmaa053_desc
            
            IF NOT cl_null(g_pmaa_m.pmaa053) THEN 
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmaa_m.pmaa053

                  
               #呼叫檢查存在並帶值的library
               #ming 20140817 modify -------------------------------------------(S) 
               #IF cl_chk_exist("v_xmaa001") THEN
               #企鵝：信用評等欄位的開窗與校驗改取xmaj_t 
               IF cl_chk_exist("v_xmaj001") THEN
               #ming 20140817 modify -------------------------------------------(E) 
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmaa_m.pmaa053 = g_pmaa_m_t.pmaa053
                  #ming 20140817 modify --------------------------------------------------------(S) 
                  #CALL s_desc_get_acc_desc('296',g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
                  #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
                  CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
                  #ming 20140817 modify --------------------------------------------------------(E) 
                  DISPLAY BY NAME g_pmaa_m.pmaa053_desc
            
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            #ming 20140817 add -------------------------------------(S) 
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            DISPLAY BY NAME g_pmaa_m.pmaa053_desc
            #ming 20140817 add -------------------------------------(E) 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa053
            #add-point:BEFORE FIELD pmaa053 name="input.b.pmaa053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa053
            #add-point:ON CHANGE pmaa053 name="input.g.pmaa053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa054
            
            #add-point:AFTER FIELD pmaa054 name="input.a.pmaa054"
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            IF NOT cl_null(g_pmaa_m.pmaa054) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa054 != g_pmaa_m_t.pmaa054 OR cl_null(g_pmaa_m_t.pmaa054))) THEN 
                  IF NOT apmm100_pmaa011_chk(g_pmaa_m.pmaa054) THEN
                     LET g_pmaa_m.pmaa054 = g_pmaa_m_t.pmaa054
                     CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa054_desc
                     NEXT FIELD pmaa054
                   END IF
               END IF  
            END IF
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa054
            #add-point:BEFORE FIELD pmaa054 name="input.b.pmaa054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa054
            #add-point:ON CHANGE pmaa054 name="input.g.pmaa054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa055
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa055,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa055
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa055 name="input.a.pmaa055"
            IF NOT cl_null(g_pmaa_m.pmaa055) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa055
            #add-point:BEFORE FIELD pmaa055 name="input.b.pmaa055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa055
            #add-point:ON CHANGE pmaa055 name="input.g.pmaa055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa056
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa056,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa056
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa056 name="input.a.pmaa056"
            IF NOT cl_null(g_pmaa_m.pmaa056) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa056
            #add-point:BEFORE FIELD pmaa056 name="input.b.pmaa056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa056
            #add-point:ON CHANGE pmaa056 name="input.g.pmaa056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa057
            #add-point:BEFORE FIELD pmaa057 name="input.b.pmaa057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa057
            
            #add-point:AFTER FIELD pmaa057 name="input.a.pmaa057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa057
            #add-point:ON CHANGE pmaa057 name="input.g.pmaa057"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa058
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa058,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa058
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa058 name="input.a.pmaa058"
            IF NOT cl_null(g_pmaa_m.pmaa058) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa058
            #add-point:BEFORE FIELD pmaa058 name="input.b.pmaa058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa058
            #add-point:ON CHANGE pmaa058 name="input.g.pmaa058"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa074
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa074,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa074
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa074 name="input.a.pmaa074"
            IF NOT cl_null(g_pmaa_m.pmaa074) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa074
            #add-point:BEFORE FIELD pmaa074 name="input.b.pmaa074"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa074
            #add-point:ON CHANGE pmaa074 name="input.g.pmaa074"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa059
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa059,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmaa059
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa059 name="input.a.pmaa059"
            IF NOT cl_null(g_pmaa_m.pmaa059) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa059
            #add-point:BEFORE FIELD pmaa059 name="input.b.pmaa059"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa059
            #add-point:ON CHANGE pmaa059 name="input.g.pmaa059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa075
            #add-point:BEFORE FIELD pmaa075 name="input.b.pmaa075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa075
            
            #add-point:AFTER FIELD pmaa075 name="input.a.pmaa075"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa075
            #add-point:ON CHANGE pmaa075 name="input.g.pmaa075"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa060
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa060,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmaa060
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa060 name="input.a.pmaa060"
            IF NOT cl_null(g_pmaa_m.pmaa060) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa060
            #add-point:BEFORE FIELD pmaa060 name="input.b.pmaa060"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa060
            #add-point:ON CHANGE pmaa060 name="input.g.pmaa060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa061
            #add-point:BEFORE FIELD pmaa061 name="input.b.pmaa061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa061
            
            #add-point:AFTER FIELD pmaa061 name="input.a.pmaa061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa061
            #add-point:ON CHANGE pmaa061 name="input.g.pmaa061"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa062
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa062,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmaa062
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa062 name="input.a.pmaa062"
            IF NOT cl_null(g_pmaa_m.pmaa062) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa062
            #add-point:BEFORE FIELD pmaa062 name="input.b.pmaa062"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa062
            #add-point:ON CHANGE pmaa062 name="input.g.pmaa062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa063
            #add-point:BEFORE FIELD pmaa063 name="input.b.pmaa063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa063
            
            #add-point:AFTER FIELD pmaa063 name="input.a.pmaa063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa063
            #add-point:ON CHANGE pmaa063 name="input.g.pmaa063"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa064
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmaa_m.pmaa064,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD pmaa064
            END IF 
 
 
 
            #add-point:AFTER FIELD pmaa064 name="input.a.pmaa064"
            IF NOT cl_null(g_pmaa_m.pmaa064) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa064
            #add-point:BEFORE FIELD pmaa064 name="input.b.pmaa064"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa064
            #add-point:ON CHANGE pmaa064 name="input.g.pmaa064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa065
            #add-point:BEFORE FIELD pmaa065 name="input.b.pmaa065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa065
            
            #add-point:AFTER FIELD pmaa065 name="input.a.pmaa065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa065
            #add-point:ON CHANGE pmaa065 name="input.g.pmaa065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa066
            #add-point:BEFORE FIELD pmaa066 name="input.b.pmaa066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa066
            
            #add-point:AFTER FIELD pmaa066 name="input.a.pmaa066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa066
            #add-point:ON CHANGE pmaa066 name="input.g.pmaa066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa067
            #add-point:BEFORE FIELD pmaa067 name="input.b.pmaa067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa067
            
            #add-point:AFTER FIELD pmaa067 name="input.a.pmaa067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa067
            #add-point:ON CHANGE pmaa067 name="input.g.pmaa067"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa291
            
            #add-point:AFTER FIELD pmaa291 name="input.a.pmaa291"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
            DISPLAY BY NAME g_pmaa_m.pmaa291_desc
            IF NOT cl_null(g_pmaa_m.pmaa291) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa291 != g_pmaa_m_t.pmaa291 OR cl_null(g_pmaa_m_t.pmaa291))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa291,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2061' AND oocq002 = ? ","apm-00106",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa291,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2061' AND oocq002 = ? ","sub-01303",'axmi037' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa291 = g_pmaa_m_t.pmaa291
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa291_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa291,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2061' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00107",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa291,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2061' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi037' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa291 = g_pmaa_m_t.pmaa291
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa291_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
            DISPLAY BY NAME g_pmaa_m.pmaa291_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa291
            #add-point:BEFORE FIELD pmaa291 name="input.b.pmaa291"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa291
            #add-point:ON CHANGE pmaa291 name="input.g.pmaa291"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa292
            
            #add-point:AFTER FIELD pmaa292 name="input.a.pmaa292"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
            DISPLAY BY NAME g_pmaa_m.pmaa292_desc
            IF NOT cl_null(g_pmaa_m.pmaa292) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa292 != g_pmaa_m_t.pmaa292 OR cl_null(g_pmaa_m_t.pmaa292))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa292,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2062' AND oocq002 = ? ","apm-00108",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa292,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2062' AND oocq002 = ? ","sub-01303",'axmi038' ) THEN #160318-00005#34 
                     LET g_pmaa_m.pmaa292 = g_pmaa_m_t.pmaa292
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa292_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa292,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2062' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00109",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa292,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2062' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi038' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa292 = g_pmaa_m_t.pmaa292
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa292_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
            DISPLAY BY NAME g_pmaa_m.pmaa292_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa292
            #add-point:BEFORE FIELD pmaa292 name="input.b.pmaa292"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa292
            #add-point:ON CHANGE pmaa292 name="input.g.pmaa292"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa293
            
            #add-point:AFTER FIELD pmaa293 name="input.a.pmaa293"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
            DISPLAY BY NAME g_pmaa_m.pmaa293_desc
            IF NOT cl_null(g_pmaa_m.pmaa293) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa293 != g_pmaa_m_t.pmaa293 OR cl_null(g_pmaa_m_t.pmaa293))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa293,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2063' AND oocq002 = ? ","apm-00110",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa293,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2063' AND oocq002 = ? ","sub-01303",'axmi039' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa293 = g_pmaa_m_t.pmaa293
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa293_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa293,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2063' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00111",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa293,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2063' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi039' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa293 = g_pmaa_m_t.pmaa293
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa293_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
            DISPLAY BY NAME g_pmaa_m.pmaa293_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa293
            #add-point:BEFORE FIELD pmaa293 name="input.b.pmaa293"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa293
            #add-point:ON CHANGE pmaa293 name="input.g.pmaa293"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa294
            
            #add-point:AFTER FIELD pmaa294 name="input.a.pmaa294"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
            DISPLAY BY NAME g_pmaa_m.pmaa294_desc
            IF NOT cl_null(g_pmaa_m.pmaa294) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa294 != g_pmaa_m_t.pmaa294 OR cl_null(g_pmaa_m_t.pmaa294))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa294,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2064' AND oocq002 = ? ","apm-00112",1 ) THEN   #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa294,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2064' AND oocq002 = ? ","sub-01303",'axmi040' ) THEN    #160318-00005#34
                     LET g_pmaa_m.pmaa294 = g_pmaa_m_t.pmaa294
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa294_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa294,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2064' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00113",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa294,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2064' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi040' ) THEN   #160318-00005#34                
                     LET g_pmaa_m.pmaa294 = g_pmaa_m_t.pmaa294
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa294_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
            DISPLAY BY NAME g_pmaa_m.pmaa294_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa294
            #add-point:BEFORE FIELD pmaa294 name="input.b.pmaa294"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa294
            #add-point:ON CHANGE pmaa294 name="input.g.pmaa294"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa295
            
            #add-point:AFTER FIELD pmaa295 name="input.a.pmaa295"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
            DISPLAY BY NAME g_pmaa_m.pmaa295_desc
            IF NOT cl_null(g_pmaa_m.pmaa295) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa295 != g_pmaa_m_t.pmaa295 OR cl_null(g_pmaa_m_t.pmaa295))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa295,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2065' AND oocq002 = ? ","apm-00114",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa295,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2065' AND oocq002 = ? ","sub-01303",'axmi041' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa295 = g_pmaa_m_t.pmaa295
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa295_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa295,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2065' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00115",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa295,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2065' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi041' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa295 = g_pmaa_m_t.pmaa295
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa295_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
            DISPLAY BY NAME g_pmaa_m.pmaa295_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa295
            #add-point:BEFORE FIELD pmaa295 name="input.b.pmaa295"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa295
            #add-point:ON CHANGE pmaa295 name="input.g.pmaa295"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa296
            
            #add-point:AFTER FIELD pmaa296 name="input.a.pmaa296"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
            DISPLAY BY NAME g_pmaa_m.pmaa296_desc
            IF NOT cl_null(g_pmaa_m.pmaa296) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa296 != g_pmaa_m_t.pmaa296 OR cl_null(g_pmaa_m_t.pmaa296))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa296,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2066' AND oocq002 = ? ","apm-00116",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa296,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2066' AND oocq002 = ? ","sub-01303",'axmi042' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa296 = g_pmaa_m_t.pmaa296
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa296_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa296,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2066' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00117",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa296,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2066' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi042' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa296 = g_pmaa_m_t.pmaa296
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa296_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
            DISPLAY BY NAME g_pmaa_m.pmaa296_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa296
            #add-point:BEFORE FIELD pmaa296 name="input.b.pmaa296"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa296
            #add-point:ON CHANGE pmaa296 name="input.g.pmaa296"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa297
            
            #add-point:AFTER FIELD pmaa297 name="input.a.pmaa297"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
            DISPLAY BY NAME g_pmaa_m.pmaa297_desc
            IF NOT cl_null(g_pmaa_m.pmaa297) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa297 != g_pmaa_m_t.pmaa297 OR cl_null(g_pmaa_m_t.pmaa297))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa297,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2067' AND oocq002 = ? ","apm-00118",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa297,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2067' AND oocq002 = ? ","sub-01303",'axmi043' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa297 = g_pmaa_m_t.pmaa297
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa297_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa297,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2067' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00119",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa297,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2067' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi043' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa297 = g_pmaa_m_t.pmaa297
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa297_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
            DISPLAY BY NAME g_pmaa_m.pmaa297_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa297
            #add-point:BEFORE FIELD pmaa297 name="input.b.pmaa297"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa297
            #add-point:ON CHANGE pmaa297 name="input.g.pmaa297"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa298
            
            #add-point:AFTER FIELD pmaa298 name="input.a.pmaa298"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
            DISPLAY BY NAME g_pmaa_m.pmaa298_desc
            IF NOT cl_null(g_pmaa_m.pmaa298) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa298 != g_pmaa_m_t.pmaa298 OR cl_null(g_pmaa_m_t.pmaa298))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa298,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2068' AND oocq002 = ? ","apm-00120",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa298,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2068' AND oocq002 = ? ","sub-01303",'axmi044' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa298 = g_pmaa_m_t.pmaa298
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa298_desc
                     NEXT FIELD CURRENT
                  END IF
                 #IF NOT ap_chk_isExist(g_pmaa_m.pmaa298,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2068' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00121",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa298,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2068' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi044' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa298 = g_pmaa_m_t.pmaa298
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa298_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
            DISPLAY BY NAME g_pmaa_m.pmaa298_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa298
            #add-point:BEFORE FIELD pmaa298 name="input.b.pmaa298"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa298
            #add-point:ON CHANGE pmaa298 name="input.g.pmaa298"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa299
            
            #add-point:AFTER FIELD pmaa299 name="input.a.pmaa299"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
            DISPLAY BY NAME g_pmaa_m.pmaa299_desc
            IF NOT cl_null(g_pmaa_m.pmaa299) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa299 != g_pmaa_m_t.pmaa299 OR cl_null(g_pmaa_m_t.pmaa299))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa299,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2069' AND oocq002 = ? ","apm-00122",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa299,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2069' AND oocq002 = ? ","sub-01303",'axmi045' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa299 = g_pmaa_m_t.pmaa299
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa299_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa299,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2069' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00123",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa299,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2069' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi045' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa299 = g_pmaa_m_t.pmaa299
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa299_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
            DISPLAY BY NAME g_pmaa_m.pmaa299_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa299
            #add-point:BEFORE FIELD pmaa299 name="input.b.pmaa299"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa299
            #add-point:ON CHANGE pmaa299 name="input.g.pmaa299"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa300
            
            #add-point:AFTER FIELD pmaa300 name="input.a.pmaa300"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
            DISPLAY BY NAME g_pmaa_m.pmaa300_desc
            IF NOT cl_null(g_pmaa_m.pmaa300) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa300 != g_pmaa_m_t.pmaa300 OR cl_null(g_pmaa_m_t.pmaa300))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa300,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2070' AND oocq002 = ? ","apm-00124",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa300,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2070' AND oocq002 = ? ","sub-01303",'axmi046' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa300 = g_pmaa_m_t.pmaa300
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa300_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa300,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2070' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00125",1 ) THEN        #160318-00005#34     
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa300,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2070' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axmi046' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa300 = g_pmaa_m_t.pmaa300
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa300_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
            DISPLAY BY NAME g_pmaa_m.pmaa300_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa300
            #add-point:BEFORE FIELD pmaa300 name="input.b.pmaa300"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa300
            #add-point:ON CHANGE pmaa300 name="input.g.pmaa300"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa281
            
            #add-point:AFTER FIELD pmaa281 name="input.a.pmaa281"
#            #---str---mark by qianyuan170410--- #将pmaa281的栏位从buttonedit换成combox之后，去掉栏位管控
#            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
#            DISPLAY BY NAME g_pmaa_m.pmaa281_desc
#            IF NOT cl_null(g_pmaa_m.pmaa281) THEN
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa281 != g_pmaa_m_t.pmaa281 OR cl_null(g_pmaa_m_t.pmaa281))) THEN 
#                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa281,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2037' AND oocq002 = ? ","apm-00126",1 ) THEN            #160318-00005#34
#                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa281,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2037' AND oocq002 = ? ","sub-01303",'apmi037' ) THEN     #160318-00005#34
#                     LET g_pmaa_m.pmaa281 = g_pmaa_m_t.pmaa281
#                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
#                     DISPLAY BY NAME g_pmaa_m.pmaa281_desc
#                     NEXT FIELD CURRENT
#                  END IF
#                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa281,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2037' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00127",1 ) THEN         #160318-00005#34
#                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa281,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2037' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi037' ) THEN  #160318-00005#34
#                     LET g_pmaa_m.pmaa281 = g_pmaa_m_t.pmaa281
#                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
#                     DISPLAY BY NAME g_pmaa_m.pmaa281_desc
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
#            DISPLAY BY NAME g_pmaa_m.pmaa281_desc
#            #---end---mark by qianyuan170410---

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa281
            #add-point:BEFORE FIELD pmaa281 name="input.b.pmaa281"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa281
            #add-point:ON CHANGE pmaa281 name="input.g.pmaa281"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa282
            
            #add-point:AFTER FIELD pmaa282 name="input.a.pmaa282"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
            DISPLAY BY NAME g_pmaa_m.pmaa282_desc
            IF NOT cl_null(g_pmaa_m.pmaa282) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa282 != g_pmaa_m_t.pmaa282 OR cl_null(g_pmaa_m_t.pmaa282))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa282,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2038' AND oocq002 = ? ","apm-00128",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa282,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2038' AND oocq002 = ? ","sub-01303",'apmi038' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa282 = g_pmaa_m_t.pmaa282
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa282_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa282,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2038' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00129",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa282,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2038' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi038' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa282 = g_pmaa_m_t.pmaa282
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa282_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
            DISPLAY BY NAME g_pmaa_m.pmaa282_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa282
            #add-point:BEFORE FIELD pmaa282 name="input.b.pmaa282"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa282
            #add-point:ON CHANGE pmaa282 name="input.g.pmaa282"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa283
            
            #add-point:AFTER FIELD pmaa283 name="input.a.pmaa283"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
            DISPLAY BY NAME g_pmaa_m.pmaa283_desc
            IF NOT cl_null(g_pmaa_m.pmaa283) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa283 != g_pmaa_m_t.pmaa283 OR cl_null(g_pmaa_m_t.pmaa283))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa283,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2039' AND oocq002 = ? ","apm-00130",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa283,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2039' AND oocq002 = ? ","sub-01303",'apmi039' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa283 = g_pmaa_m_t.pmaa283
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa283_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa283,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2039' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00131",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa283,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2039' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi039' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa283 = g_pmaa_m_t.pmaa283
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa283_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
            DISPLAY BY NAME g_pmaa_m.pmaa283_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa283
            #add-point:BEFORE FIELD pmaa283 name="input.b.pmaa283"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa283
            #add-point:ON CHANGE pmaa283 name="input.g.pmaa283"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa284
            
            #add-point:AFTER FIELD pmaa284 name="input.a.pmaa284"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
            DISPLAY BY NAME g_pmaa_m.pmaa284_desc
            IF NOT cl_null(g_pmaa_m.pmaa284) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa284 != g_pmaa_m_t.pmaa284 OR cl_null(g_pmaa_m_t.pmaa284))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa284,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2040' AND oocq002 = ? ","apm-00132",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa284,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2040' AND oocq002 = ? ","sub-01303",'apmi040' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa284 = g_pmaa_m_t.pmaa284
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa284_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa284,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2040' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00133",1 ) THEN           #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa284,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2040' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi040' ) THEN    #160318-00005#34
                     LET g_pmaa_m.pmaa284 = g_pmaa_m_t.pmaa284
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa284_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
            DISPLAY BY NAME g_pmaa_m.pmaa284_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa284
            #add-point:BEFORE FIELD pmaa284 name="input.b.pmaa284"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa284
            #add-point:ON CHANGE pmaa284 name="input.g.pmaa284"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa285
            
            #add-point:AFTER FIELD pmaa285 name="input.a.pmaa285"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
            DISPLAY BY NAME g_pmaa_m.pmaa285_desc
            IF NOT cl_null(g_pmaa_m.pmaa285) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa285 != g_pmaa_m_t.pmaa285 OR cl_null(g_pmaa_m_t.pmaa285))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa285,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2041' AND oocq002 = ? ","apm-00134",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa285,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2041' AND oocq002 = ? ","sub-01303",'apmi041' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa285 = g_pmaa_m_t.pmaa285
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa285_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa285,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2041' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00135",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa285,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2041' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi041' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa285 = g_pmaa_m_t.pmaa285
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa285_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
            DISPLAY BY NAME g_pmaa_m.pmaa285_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa285
            #add-point:BEFORE FIELD pmaa285 name="input.b.pmaa285"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa285
            #add-point:ON CHANGE pmaa285 name="input.g.pmaa285"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa286
            
            #add-point:AFTER FIELD pmaa286 name="input.a.pmaa286"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
            DISPLAY BY NAME g_pmaa_m.pmaa286_desc
            IF NOT cl_null(g_pmaa_m.pmaa286) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa286 != g_pmaa_m_t.pmaa286 OR cl_null(g_pmaa_m_t.pmaa286))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa286,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2042' AND oocq002 = ? ","apm-00136",1 ) THEN          #160318-00005#34
                   IF NOT ap_chk_isExist(g_pmaa_m.pmaa286,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2042' AND oocq002 = ? ","sub-01303",'apmi042' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa286 = g_pmaa_m_t.pmaa286
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa286_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa286,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2042' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00137",1 ) THEN  #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa286,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2042' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi042' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa286 = g_pmaa_m_t.pmaa286
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa286_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
            DISPLAY BY NAME g_pmaa_m.pmaa286_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa286
            #add-point:BEFORE FIELD pmaa286 name="input.b.pmaa286"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa286
            #add-point:ON CHANGE pmaa286 name="input.g.pmaa286"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa287
            
            #add-point:AFTER FIELD pmaa287 name="input.a.pmaa287"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
            DISPLAY BY NAME g_pmaa_m.pmaa287_desc
            IF NOT cl_null(g_pmaa_m.pmaa287) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa287 != g_pmaa_m_t.pmaa287 OR cl_null(g_pmaa_m_t.pmaa287))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa287,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2043' AND oocq002 = ? ","apm-00138",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa287,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2043' AND oocq002 = ? ","sub-01303",'apmi043' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa287 = g_pmaa_m_t.pmaa287
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa287_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa287,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2043' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00139",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa287,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2043' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi043' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa287 = g_pmaa_m_t.pmaa287
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa287_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
            DISPLAY BY NAME g_pmaa_m.pmaa287_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa287
            #add-point:BEFORE FIELD pmaa287 name="input.b.pmaa287"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa287
            #add-point:ON CHANGE pmaa287 name="input.g.pmaa287"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa288
            
            #add-point:AFTER FIELD pmaa288 name="input.a.pmaa288"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
            DISPLAY BY NAME g_pmaa_m.pmaa288_desc
            IF NOT cl_null(g_pmaa_m.pmaa288) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa288 != g_pmaa_m_t.pmaa288 OR cl_null(g_pmaa_m_t.pmaa288))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa288,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2044' AND oocq002 = ? ","apm-00140",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa288,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2044' AND oocq002 = ? ","sub-01303",'apmi044' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa288 = g_pmaa_m_t.pmaa288
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa288_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa288,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2044' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00141",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa288,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2044' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi044' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa288 = g_pmaa_m_t.pmaa288
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa288_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
            DISPLAY BY NAME g_pmaa_m.pmaa288_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa288
            #add-point:BEFORE FIELD pmaa288 name="input.b.pmaa288"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa288
            #add-point:ON CHANGE pmaa288 name="input.g.pmaa288"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa289
            
            #add-point:AFTER FIELD pmaa289 name="input.a.pmaa289"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
            DISPLAY BY NAME g_pmaa_m.pmaa289_desc
            IF NOT cl_null(g_pmaa_m.pmaa289) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa289 != g_pmaa_m_t.pmaa289 OR cl_null(g_pmaa_m_t.pmaa289))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa289,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2045' AND oocq002 = ? ","apm-00142",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa289,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2045' AND oocq002 = ? ","sub-01303",'apmi045' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa289 = g_pmaa_m_t.pmaa289
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa289_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa289,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2045' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00143",1 ) THEN          #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa289,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2045' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi045' ) THEN   #160318-00005#34
                     LET g_pmaa_m.pmaa289 = g_pmaa_m_t.pmaa289
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa289_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
            DISPLAY BY NAME g_pmaa_m.pmaa289_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa289
            #add-point:BEFORE FIELD pmaa289 name="input.b.pmaa289"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa289
            #add-point:ON CHANGE pmaa289 name="input.g.pmaa289"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa290
            
            #add-point:AFTER FIELD pmaa290 name="input.a.pmaa290"
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
            DISPLAY BY NAME g_pmaa_m.pmaa290_desc
            IF NOT cl_null(g_pmaa_m.pmaa290) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmaa_m.pmaa290 != g_pmaa_m_t.pmaa290 OR cl_null(g_pmaa_m_t.pmaa290))) THEN 
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa290,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2046' AND oocq002 = ? ","apm-00144",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa290,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2046' AND oocq002 = ? ","sub-01303",'apmi046' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa290 = g_pmaa_m_t.pmaa290
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa290_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa290,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2046' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00145",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa290,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '2046' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi046' ) THEN  #160318-00005#34
                     LET g_pmaa_m.pmaa290 = g_pmaa_m_t.pmaa290
                     CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa290_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
            DISPLAY BY NAME g_pmaa_m.pmaa290_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa290
            #add-point:BEFORE FIELD pmaa290 name="input.b.pmaa290"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmaa290
            #add-point:ON CHANGE pmaa290 name="input.g.pmaa290"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.ooff013"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa001
            #add-point:ON ACTION controlp INFIELD pmaa001 name="input.c.pmaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa002
            #add-point:ON ACTION controlp INFIELD pmaa002 name="input.c.pmaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal004
            #add-point:ON ACTION controlp INFIELD pmaal004 name="input.c.pmaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal003
            #add-point:ON ACTION controlp INFIELD pmaal003 name="input.c.pmaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal006
            #add-point:ON ACTION controlp INFIELD pmaal006 name="input.c.pmaal006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaal005
            #add-point:ON ACTION controlp INFIELD pmaal005 name="input.c.pmaal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa003
            #add-point:ON ACTION controlp INFIELD pmaa003 name="input.c.pmaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaastus
            #add-point:ON ACTION controlp INFIELD pmaastus name="input.c.pmaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa004
            #add-point:ON ACTION controlp INFIELD pmaa004 name="input.c.pmaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa005
            #add-point:ON ACTION controlp INFIELD pmaa005 name="input.c.pmaa005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa005             #給予default值
            LET g_qryparam.where = " pmaa004 = '1' "
    
            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_pmaa_m.pmaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa005 TO pmaa005              #顯示到畫面上
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
            DISPLAY BY NAME g_pmaa_m.pmaa005_desc

            NEXT FIELD pmaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa006
            #add-point:ON ACTION controlp INFIELD pmaa006 name="input.c.pmaa006"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "261" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa006 TO pmaa006              #顯示到畫面上
            CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
            DISPLAY BY NAME g_pmaa_m.pmaa006_desc

            NEXT FIELD pmaa006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa007
            #add-point:ON ACTION controlp INFIELD pmaa007 name="input.c.pmaa007"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa007             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_pmaa_m.pmaa007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa007 TO pmaa007              #顯示到畫面上
            CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
            DISPLAY BY NAME g_pmaa_m.pmaa007_desc

            NEXT FIELD pmaa007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa008
            #add-point:ON ACTION controlp INFIELD pmaa008 name="input.c.pmaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa009
            #add-point:ON ACTION controlp INFIELD pmaa009 name="input.c.pmaa009"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa009             #給予default值

            #給予arg

            CALL q_ooal002_5()                                #呼叫開窗

            LET g_pmaa_m.pmaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa009 TO pmaa009              #顯示到畫面上
            CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
            DISPLAY BY NAME g_pmaa_m.pmaa009_desc

            NEXT FIELD pmaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa010
            #add-point:ON ACTION controlp INFIELD pmaa010 name="input.c.pmaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa011
            #add-point:ON ACTION controlp INFIELD pmaa011 name="input.c.pmaa011"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa011             #給予default值

            #給予arg

            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                 #呼叫開窗

            LET g_pmaa_m.pmaa011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa011 TO pmaa011              #顯示到畫面上
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa011) RETURNING g_pmaa_m.pmaa011_desc
            DISPLAY BY NAME g_pmaa_m.pmaa011_desc

            NEXT FIELD pmaa011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa230
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa230
            #add-point:ON ACTION controlp INFIELD pmaa230 name="input.c.pmaa230"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaaud001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaud001
            #add-point:ON ACTION controlp INFIELD pmaaud001 name="input.c.pmaaud001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaaud002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaaud002
            #add-point:ON ACTION controlp INFIELD pmaaud002 name="input.c.pmaaud002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa017
            #add-point:ON ACTION controlp INFIELD pmaa017 name="input.c.pmaa017"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa016
            #add-point:ON ACTION controlp INFIELD pmaa016 name="input.c.pmaa016"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmaa018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa018
            #add-point:ON ACTION controlp INFIELD pmaa018 name="input.c.pmaa018"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa019
            #add-point:ON ACTION controlp INFIELD pmaa019 name="input.c.pmaa019"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa019             #給予default值

            #給予arg

           LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                 #呼叫開窗

            LET g_pmaa_m.pmaa019 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa019 TO pmaa019              #顯示到畫面上
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
            DISPLAY BY NAME g_pmaa_m.pmaa019_desc

            NEXT FIELD pmaa019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa021
            #add-point:ON ACTION controlp INFIELD pmaa021 name="input.c.pmaa021"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa022
            #add-point:ON ACTION controlp INFIELD pmaa022 name="input.c.pmaa022"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa022             #給予default值

            #給予arg

            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                              #呼叫開窗

            LET g_pmaa_m.pmaa022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa022 TO pmaa022              #顯示到畫面上
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
            DISPLAY BY NAME g_pmaa_m.pmaa022_desc

            NEXT FIELD pmaa022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa020
            #add-point:ON ACTION controlp INFIELD pmaa020 name="input.c.pmaa020"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa023
            #add-point:ON ACTION controlp INFIELD pmaa023 name="input.c.pmaa023"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "254" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa023 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa023 TO pmaa023              #顯示到畫面上
            CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
            DISPLAY BY NAME g_pmaa_m.pmaa023_desc

            NEXT FIELD pmaa023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa024
            #add-point:ON ACTION controlp INFIELD pmaa024 name="input.c.pmaa024"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "260" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa024 TO pmaa024              #顯示到畫面上
            CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
            DISPLAY BY NAME g_pmaa_m.pmaa024_desc

            NEXT FIELD pmaa024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa025
            #add-point:ON ACTION controlp INFIELD pmaa025 name="input.c.pmaa025"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa026
            #add-point:ON ACTION controlp INFIELD pmaa026 name="input.c.pmaa026"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "250" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa026 TO pmaa026              #顯示到畫面上
            CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
            DISPLAY BY NAME g_pmaa_m.pmaa026_desc

            NEXT FIELD pmaa026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa098
            #add-point:ON ACTION controlp INFIELD pmaa098 name="input.c.pmaa098"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa028
            #add-point:ON ACTION controlp INFIELD pmaa028 name="input.c.pmaa028"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa029
            #add-point:ON ACTION controlp INFIELD pmaa029 name="input.c.pmaa029"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa090
            #add-point:ON ACTION controlp INFIELD pmaa090 name="input.c.pmaa090"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa090             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "281" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa090 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa090 TO pmaa090              #顯示到畫面上
            CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
            DISPLAY BY NAME g_pmaa_m.pmaa090_desc

            NEXT FIELD pmaa090                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa091
            #add-point:ON ACTION controlp INFIELD pmaa091 name="input.c.pmaa091"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa091             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "283" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa091 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa091 TO pmaa091              #顯示到畫面上
            CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
            DISPLAY BY NAME g_pmaa_m.pmaa091_desc

            NEXT FIELD pmaa091                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa092
            #add-point:ON ACTION controlp INFIELD pmaa092 name="input.c.pmaa092"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa094
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa094
            #add-point:ON ACTION controlp INFIELD pmaa094 name="input.c.pmaa094"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa094             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "286" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa094 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa094 TO pmaa094              #顯示到畫面上
            CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
            DISPLAY BY NAME g_pmaa_m.pmaa094_desc

            NEXT FIELD pmaa094                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa093
            #add-point:ON ACTION controlp INFIELD pmaa093 name="input.c.pmaa093"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa093             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "285" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa093 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa093 TO pmaa093              #顯示到畫面上
            CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
            DISPLAY BY NAME g_pmaa_m.pmaa093_desc

            NEXT FIELD pmaa093                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa095
            #add-point:ON ACTION controlp INFIELD pmaa095 name="input.c.pmaa095"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmaa096
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa096
            #add-point:ON ACTION controlp INFIELD pmaa096 name="input.c.pmaa096"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa096             #給予default值

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_pmaa_m.pmaa096 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa096 TO pmaa096              #顯示到畫面上
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa096) RETURNING g_pmaa_m.pmaa096_desc
            DISPLAY BY NAME g_pmaa_m.pmaa096_desc

            NEXT FIELD pmaa096                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa097
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa097
            #add-point:ON ACTION controlp INFIELD pmaa097 name="input.c.pmaa097"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmaa_m.pmaa097             #給予default值
            LET g_qryparam.default2 = "" #g_pmaa_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmaa_m.pmaa097 = g_qryparam.return1              
            #LET g_pmaa_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmaa_m.pmaa097 TO pmaa097              #
            #DISPLAY g_pmaa_m.ooeg001 TO ooeg001 #部門編號
            
            CALL s_desc_get_department_desc(g_pmaa_m.pmaa097) RETURNING g_pmaa_m.pmaa097_desc
            DISPLAY BY NAME g_pmaa_m.pmaa097_desc            
            
            NEXT FIELD pmaa097                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa080
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa080
            #add-point:ON ACTION controlp INFIELD pmaa080 name="input.c.pmaa080"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa080             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "251" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa080 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa080 TO pmaa080              #顯示到畫面上
            CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
            DISPLAY BY NAME g_pmaa_m.pmaa080_desc

            NEXT FIELD pmaa080                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa081
            #add-point:ON ACTION controlp INFIELD pmaa081 name="input.c.pmaa081"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa081             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "253" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa081 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa081 TO pmaa081              #顯示到畫面上
            CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
            DISPLAY BY NAME g_pmaa_m.pmaa081_desc

            NEXT FIELD pmaa081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa082
            #add-point:ON ACTION controlp INFIELD pmaa082 name="input.c.pmaa082"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa084
            #add-point:ON ACTION controlp INFIELD pmaa084 name="input.c.pmaa084"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa084             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "256" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa084 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa084 TO pmaa084              #顯示到畫面上
            CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
            DISPLAY BY NAME g_pmaa_m.pmaa084_desc

            NEXT FIELD pmaa084                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa083
            #add-point:ON ACTION controlp INFIELD pmaa083 name="input.c.pmaa083"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa083             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "255" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa083 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa083 TO pmaa083              #顯示到畫面上
            CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
            DISPLAY BY NAME g_pmaa_m.pmaa083_desc

            NEXT FIELD pmaa083                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa085
            #add-point:ON ACTION controlp INFIELD pmaa085 name="input.c.pmaa085"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmaa086
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa086
            #add-point:ON ACTION controlp INFIELD pmaa086 name="input.c.pmaa086"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa086             #給予default值

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_pmaa_m.pmaa086 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa086 TO pmaa086              #顯示到畫面上
            CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa086) RETURNING g_pmaa_m.pmaa086_desc
            DISPLAY BY NAME g_pmaa_m.pmaa086_desc

            NEXT FIELD pmaa086                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa087
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa087
            #add-point:ON ACTION controlp INFIELD pmaa087 name="input.c.pmaa087"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'     #fengmy160518
            LET g_qryparam.default1 = g_pmaa_m.pmaa087             #給予default值
            LET g_qryparam.default2 = "" #g_pmaa_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmaa_m.pmaa087 = g_qryparam.return1              
            #LET g_pmaa_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_pmaa_m.pmaa087 TO pmaa087              #
            #DISPLAY g_pmaa_m.ooeg001 TO ooeg001 #部門編號
            
            CALL s_desc_get_department_desc(g_pmaa_m.pmaa087) RETURNING g_pmaa_m.pmaa087_desc
            DISPLAY BY NAME g_pmaa_m.pmaa087_desc
            
            NEXT FIELD pmaa087                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa088
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa088
            #add-point:ON ACTION controlp INFIELD pmaa088 name="input.c.pmaa088"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa047
            #add-point:ON ACTION controlp INFIELD pmaa047 name="input.c.pmaa047"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa037
            #add-point:ON ACTION controlp INFIELD pmaa037 name="input.c.pmaa037"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa036
            #add-point:ON ACTION controlp INFIELD pmaa036 name="input.c.pmaa036"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa038
            #add-point:ON ACTION controlp INFIELD pmaa038 name="input.c.pmaa038"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa039
            #add-point:ON ACTION controlp INFIELD pmaa039 name="input.c.pmaa039"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa040
            #add-point:ON ACTION controlp INFIELD pmaa040 name="input.c.pmaa040"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa041
            #add-point:ON ACTION controlp INFIELD pmaa041 name="input.c.pmaa041"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa042
            #add-point:ON ACTION controlp INFIELD pmaa042 name="input.c.pmaa042"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa043
            #add-point:ON ACTION controlp INFIELD pmaa043 name="input.c.pmaa043"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa044
            #add-point:ON ACTION controlp INFIELD pmaa044 name="input.c.pmaa044"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa045
            #add-point:ON ACTION controlp INFIELD pmaa045 name="input.c.pmaa045"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa046
            #add-point:ON ACTION controlp INFIELD pmaa046 name="input.c.pmaa046"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa068
            #add-point:ON ACTION controlp INFIELD pmaa068 name="input.c.pmaa068"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa069
            #add-point:ON ACTION controlp INFIELD pmaa069 name="input.c.pmaa069"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa072
            #add-point:ON ACTION controlp INFIELD pmaa072 name="input.c.pmaa072"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa070
            #add-point:ON ACTION controlp INFIELD pmaa070 name="input.c.pmaa070"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa071
            #add-point:ON ACTION controlp INFIELD pmaa071 name="input.c.pmaa071"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa073
            #add-point:ON ACTION controlp INFIELD pmaa073 name="input.c.pmaa073"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa051
            #add-point:ON ACTION controlp INFIELD pmaa051 name="input.c.pmaa051"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa052
            #add-point:ON ACTION controlp INFIELD pmaa052 name="input.c.pmaa052"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa052             #給予default值

            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmaa_m.pmaa052 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa052 TO pmaa052              #顯示到畫面上
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            DISPLAY BY NAME g_pmaa_m.pmaa052_desc

            NEXT FIELD pmaa052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa053
            #add-point:ON ACTION controlp INFIELD pmaa053 name="input.c.pmaa053"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmaa_m.pmaa053             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #ming 20140817 modify ----------------------------------------------------(S) 
            #CALL q_xmaa001()                                #呼叫開窗
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL q_xmaj001()                                #呼叫開窗
            #ming 20140817 modify ----------------------------------------------------(E) 

            LET g_pmaa_m.pmaa053 = g_qryparam.return1              

            DISPLAY g_pmaa_m.pmaa053 TO pmaa053              #
            #ming 20140817 modify ----------------------------------------------------(S) 
            #CALL s_desc_get_acc_desc('296',g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #ming 20140817 modify ----------------------------------------------------(E) 
            DISPLAY BY NAME g_pmaa_m.pmaa053_desc

            NEXT FIELD pmaa053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa054
            #add-point:ON ACTION controlp INFIELD pmaa054 name="input.c.pmaa054"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa054             #給予default值

            #給予arg

            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                            #呼叫開窗

            LET g_pmaa_m.pmaa054 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa054 TO pmaa054              #顯示到畫面上
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            DISPLAY BY NAME g_pmaa_m.pmaa054_desc

            NEXT FIELD pmaa054                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa055
            #add-point:ON ACTION controlp INFIELD pmaa055 name="input.c.pmaa055"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa056
            #add-point:ON ACTION controlp INFIELD pmaa056 name="input.c.pmaa056"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa057
            #add-point:ON ACTION controlp INFIELD pmaa057 name="input.c.pmaa057"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa058
            #add-point:ON ACTION controlp INFIELD pmaa058 name="input.c.pmaa058"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa074
            #add-point:ON ACTION controlp INFIELD pmaa074 name="input.c.pmaa074"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa059
            #add-point:ON ACTION controlp INFIELD pmaa059 name="input.c.pmaa059"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa075
            #add-point:ON ACTION controlp INFIELD pmaa075 name="input.c.pmaa075"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa060
            #add-point:ON ACTION controlp INFIELD pmaa060 name="input.c.pmaa060"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa061
            #add-point:ON ACTION controlp INFIELD pmaa061 name="input.c.pmaa061"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa062
            #add-point:ON ACTION controlp INFIELD pmaa062 name="input.c.pmaa062"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa063
            #add-point:ON ACTION controlp INFIELD pmaa063 name="input.c.pmaa063"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa064
            #add-point:ON ACTION controlp INFIELD pmaa064 name="input.c.pmaa064"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa065
            #add-point:ON ACTION controlp INFIELD pmaa065 name="input.c.pmaa065"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa066
            #add-point:ON ACTION controlp INFIELD pmaa066 name="input.c.pmaa066"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa067
            #add-point:ON ACTION controlp INFIELD pmaa067 name="input.c.pmaa067"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmaa291
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa291
            #add-point:ON ACTION controlp INFIELD pmaa291 name="input.c.pmaa291"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa291             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2061" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa291 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa291 TO pmaa291              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
            DISPLAY BY NAME g_pmaa_m.pmaa291_desc

            NEXT FIELD pmaa291                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa292
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa292
            #add-point:ON ACTION controlp INFIELD pmaa292 name="input.c.pmaa292"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa292             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2062" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa292 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa292 TO pmaa292              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
            DISPLAY BY NAME g_pmaa_m.pmaa292_desc

            NEXT FIELD pmaa292                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa293
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa293
            #add-point:ON ACTION controlp INFIELD pmaa293 name="input.c.pmaa293"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa293             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2063" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa293 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa293 TO pmaa293              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
            DISPLAY BY NAME g_pmaa_m.pmaa293_desc

            NEXT FIELD pmaa293                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa294
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa294
            #add-point:ON ACTION controlp INFIELD pmaa294 name="input.c.pmaa294"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa294             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2064" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa294 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa294 TO pmaa294              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
            DISPLAY BY NAME g_pmaa_m.pmaa294_desc

            NEXT FIELD pmaa294                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa295
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa295
            #add-point:ON ACTION controlp INFIELD pmaa295 name="input.c.pmaa295"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa295             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2065" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa295 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa295 TO pmaa295              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
            DISPLAY BY NAME g_pmaa_m.pmaa295_desc

            NEXT FIELD pmaa295                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa296
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa296
            #add-point:ON ACTION controlp INFIELD pmaa296 name="input.c.pmaa296"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa296             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2066" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa296 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa296 TO pmaa296              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
            DISPLAY BY NAME g_pmaa_m.pmaa296_desc

            NEXT FIELD pmaa296                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa297
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa297
            #add-point:ON ACTION controlp INFIELD pmaa297 name="input.c.pmaa297"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa297             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2067" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa297 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa297 TO pmaa297              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
            DISPLAY BY NAME g_pmaa_m.pmaa297_desc

            NEXT FIELD pmaa297                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa298
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa298
            #add-point:ON ACTION controlp INFIELD pmaa298 name="input.c.pmaa298"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa298             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2068" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa298 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa298 TO pmaa298              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
            DISPLAY BY NAME g_pmaa_m.pmaa298_desc

            NEXT FIELD pmaa298                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa299
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa299
            #add-point:ON ACTION controlp INFIELD pmaa299 name="input.c.pmaa299"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa299             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2069" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa299 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa299 TO pmaa299              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
            DISPLAY BY NAME g_pmaa_m.pmaa299_desc

            NEXT FIELD pmaa299                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa300
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa300
            #add-point:ON ACTION controlp INFIELD pmaa300 name="input.c.pmaa300"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa300             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2070" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa300 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa300 TO pmaa300              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
            DISPLAY BY NAME g_pmaa_m.pmaa300_desc

            NEXT FIELD pmaa300                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa281
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa281
            #add-point:ON ACTION controlp INFIELD pmaa281 name="input.c.pmaa281"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa281             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2037" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa281 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa281 TO pmaa281              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
            DISPLAY BY NAME g_pmaa_m.pmaa281_desc

            NEXT FIELD pmaa281                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa282
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa282
            #add-point:ON ACTION controlp INFIELD pmaa282 name="input.c.pmaa282"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa282             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2038" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa282 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa282 TO pmaa282              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
            DISPLAY BY NAME g_pmaa_m.pmaa282_desc

            NEXT FIELD pmaa282                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa283
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa283
            #add-point:ON ACTION controlp INFIELD pmaa283 name="input.c.pmaa283"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa283             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2039" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa283 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa283 TO pmaa283              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
            DISPLAY BY NAME g_pmaa_m.pmaa283_desc

            NEXT FIELD pmaa283                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa284
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa284
            #add-point:ON ACTION controlp INFIELD pmaa284 name="input.c.pmaa284"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa284             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2040" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa284 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa284 TO pmaa284              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
            DISPLAY BY NAME g_pmaa_m.pmaa284_desc

            NEXT FIELD pmaa284                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa285
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa285
            #add-point:ON ACTION controlp INFIELD pmaa285 name="input.c.pmaa285"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa285             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2041" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa285 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa285 TO pmaa285              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
            DISPLAY BY NAME g_pmaa_m.pmaa285_desc

            NEXT FIELD pmaa285                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa286
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa286
            #add-point:ON ACTION controlp INFIELD pmaa286 name="input.c.pmaa286"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa286             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2042" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa286 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa286 TO pmaa286              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
            DISPLAY BY NAME g_pmaa_m.pmaa286_desc

            NEXT FIELD pmaa286                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa287
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa287
            #add-point:ON ACTION controlp INFIELD pmaa287 name="input.c.pmaa287"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa287             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2043" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa287 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa287 TO pmaa287              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
            DISPLAY BY NAME g_pmaa_m.pmaa287_desc

            NEXT FIELD pmaa287                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa288
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa288
            #add-point:ON ACTION controlp INFIELD pmaa288 name="input.c.pmaa288"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa288             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2044" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa288 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa288 TO pmaa288              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
            DISPLAY BY NAME g_pmaa_m.pmaa288_desc

            NEXT FIELD pmaa288                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa289
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa289
            #add-point:ON ACTION controlp INFIELD pmaa289 name="input.c.pmaa289"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa289             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2045" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa289 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa289 TO pmaa289              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
            DISPLAY BY NAME g_pmaa_m.pmaa289_desc

            NEXT FIELD pmaa289                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmaa290
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa290
            #add-point:ON ACTION controlp INFIELD pmaa290 name="input.c.pmaa290"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmaa_m.pmaa290             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2046" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmaa_m.pmaa290 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmaa_m.pmaa290 TO pmaa290              #顯示到畫面上
            CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
            DISPLAY BY NAME g_pmaa_m.pmaa290_desc

            NEXT FIELD pmaa290                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.ooff013"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmaa_m.pmaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #add--2015/07/14 By shiun--(S)
               CALL s_aooi390_get_auto_no('2',g_pmaa_m.pmaa001) RETURNING l_success,g_pmaa_m.pmaa001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF   
               DISPLAY BY NAME g_pmaa_m.pmaa001
               #add--2015/07/14 By shiun--(E)
               CALL s_aooi390_oofi_upd('2',g_pmaa_m.pmaa001) RETURNING l_success  #150427 by whitney add for 增加編碼功能
               
               #add by lixiang ---2015/11/02--begin--
               #供應商編號自動編碼時，在點確定後，才會編出真正的編碼，所以若是法人，所屬法人欄位也要更新
               IF g_pmaa_m.pmaa004 = '1' THEN
                  LET g_pmaa_m.pmaa005 = g_pmaa_m.pmaa001
               END IF
               #add by lixiang ---2015/11/02--end--
               
               #IF cl_null(g_pmaa_m.pmaa052) THEN  #mark by lixiang 2015/11/02
               IF cl_null(g_pmaa_m.pmaa052) OR g_pmaa_m.pmaa052 = g_pmaa_m_t.pmaa052 THEN #add by lixiang 2015/11/02
                  LET g_pmaa_m.pmaa052 = g_pmaa_m.pmaa001 #預設交易對象編號
               END IF
               
               #160620-00004#4-add-(S)
               IF g_pmaa_m.pmaa002 MATCHES '[23]' THEN
                  LET g_pmaa_m.pmaa230 = '1' #axmm200，客戶性質為1:直接客戶
               END IF
               #160620-00004#4-add-(E)
               #end add-point
               
               INSERT INTO pmaa_t (pmaaent,pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006, 
                   pmaa007,pmaa008,pmaa009,pmaa010,pmaa011,pmaa230,pmaaud001,pmaaud002,pmaa017,pmaa016, 
                   pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa098,pmaa028, 
                   pmaa029,pmaa090,pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa097,pmaa080,pmaa081, 
                   pmaa082,pmaa084,pmaa083,pmaa085,pmaa086,pmaa087,pmaa088,pmaa047,pmaa037,pmaa036,pmaa038, 
                   pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072, 
                   pmaa070,pmaa071,pmaa073,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058, 
                   pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067, 
                   pmaa291,pmaa292,pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281, 
                   pmaa282,pmaa283,pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid, 
                   pmaaowndp,pmaacrtid,pmaacrtdp,pmaacrtdt,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt)
               VALUES (g_enterprise,g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus, 
                   g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
                   g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001, 
                   g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019, 
                   g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024, 
                   g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029, 
                   g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093, 
                   g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
                   g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086, 
                   g_pmaa_m.pmaa087,g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036, 
                   g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042, 
                   g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068, 
                   g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa073, 
                   g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
                   g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059, 
                   g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063, 
                   g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291, 
                   g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296, 
                   g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281, 
                   g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
                   g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid, 
                   g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
                   g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_pmaa_m.pmaa001 = g_master_multi_table_t.pmaal001 AND
         g_pmaa_m.pmaal004 = g_master_multi_table_t.pmaal004 AND 
         g_pmaa_m.pmaal003 = g_master_multi_table_t.pmaal003 AND 
         g_pmaa_m.pmaal006 = g_master_multi_table_t.pmaal006 AND 
         g_pmaa_m.pmaal005 = g_master_multi_table_t.pmaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pmaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pmaa_m.pmaa001
            LET l_field_keys[02] = 'pmaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pmaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pmaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pmaa_m.pmaal004
            LET l_fields[01] = 'pmaal004'
            LET l_vars[02] = g_pmaa_m.pmaal003
            LET l_fields[02] = 'pmaal003'
            LET l_vars[03] = g_pmaa_m.pmaal006
            LET l_fields[03] = 'pmaal006'
            LET l_vars[04] = g_pmaa_m.pmaal005
            LET l_fields[04] = 'pmaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pmaal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #新增到oofa_t 聯絡信息
               LET l_success = ''
               LET l_oofa001 = ''
               CALL s_aooi350_ins_oofa('3',g_pmaa_m.pmaa001,'') RETURNING l_success,l_oofa001
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CONTINUE DIALOG 
               ELSE
                  UPDATE pmaa_t SET pmaa027 = l_oofa001 
                    WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmaa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG 
                  END IF
               END IF
               LET g_pmaa027_d = l_oofa001
               LET g_pmaa001_d = g_pmaa_m.pmaa001
               
               #新增到ooff_t 備註
               IF NOT cl_null(g_pmaa_m.ooff013) THEN
                  LET l_success = '' 
                  CALL s_aooi360_gen('2',g_pmaa_m.pmaa001,'','','','','','','','','','4',g_pmaa_m.ooff013) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooff_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF
               ELSE
                  CALL s_aooi360_del('2',g_pmaa_m.pmaa001,'','','','','','','','','','4') RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooff_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF           
               END IF
               
               #新增後自動新增一筆all的apmm101的資料並彈axmm201的視窗讓她維護其他欄位資料
               IF l_cmd_t <> 'r' THEN
                  IF NOT apmm100_ins_pmab() THEN
                     CONTINUE DIALOG
                  END IF
               END IF
               
               #複製狀態
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  #複製聯絡地址
                  LET l_n = 0
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa001_t
                  SELECT COUNT(*) INTO l_n FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_pmaa027
                  IF l_n > 0 THEN
                     CALL apmm100_insert_oofb(l_pmaa027,l_oofa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofb_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
                  
                  #複製通訊方式
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM oofc_t WHERE oofcent = g_enterprise AND oofc002 = l_pmaa027
                  IF l_n > 0 THEN
                     CALL apmm100_insert_oofc(l_pmaa027,l_oofa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofc_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
     
                  #複製交易對象交易夥伴檔
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = g_pmaa001_t
                  IF l_n > 0 THEN
                     CALL apmm100_insert_pmac(g_pmaa001_t,g_pmaa_m.pmaa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmac_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
                  
                  #複製交易對象允許收/付款條件檔
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmad_t WHERE pmadent = g_enterprise AND pmad001 = g_pmaa001_t
                  IF l_n > 0 THEN
                     CALL apmm100_insert_pmad(g_pmaa001_t,g_pmaa_m.pmaa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmad_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
                  
                  #複製交易對象往來銀行檔
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaf_t WHERE pmafent = g_enterprise AND pmaf001 = g_pmaa001_t
                  IF l_n > 0 THEN
                     CALL apmm100_insert_pmaf(g_pmaa001_t,g_pmaa_m.pmaa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmaf_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF   
                  
                  #複製據點檔
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmab_t WHERE pmabent = g_enterprise AND pmab001 = g_pmaa001_t
                  IF l_n > 0 THEN
                     CALL apmm100_insert_pmab(g_pmaa001_t,g_pmaa_m.pmaa001) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmab_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               
               CALL s_transaction_end('Y','0') 

               CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
               CALL apmm100_set_act_visible()   
               CALL apmm100_set_act_no_visible()
               
               #modify by lixiang 150603 資料都錄入完成，點確認時在串集團預設資料
               #'ALL'集團層的據點資料維護
               IF l_cmd_t <> 'r' AND p_cmd = 'a' THEN
                  LET l_flag = TRUE
                  #IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  #   CASE g_argv[1]
                  #      WHEN '1' #LET l_cm = "apmm201 '"||g_pmaa_m.pmaa001||"'"    
                  #               LET la_param.prog = 'apmm201'
                  #               LET la_param.param[1] = g_pmaa_m.pmaa001
                  #               LET ls_js = util.JSON.stringify( la_param )                         
                  #      WHEN '2' #LET l_cm = "axmm201 '"||g_pmaa_m.pmaa001||"'"
                  #               LET la_param.prog = 'axmm201'
                  #               LET la_param.param[1] = g_pmaa_m.pmaa001
                  #               LET ls_js = util.JSON.stringify( la_param ) 
                  #      WHEN '3' #LET l_cm = "apmm101 '"||g_pmaa_m.pmaa001||"'"
                  #               LET la_param.prog = 'apmm101'
                  #               LET la_param.param[1] = g_pmaa_m.pmaa001
                  #               LET ls_js = util.JSON.stringify( la_param ) 
                  #   END CASE
                  #   #CALL cl_cmdrun_wait(l_cm)
                  #   CALL cl_cmdrun_wait(ls_js)
                  #END IF
               END IF   
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmm100_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmm100_b_fill()
                  CALL apmm100_b_fill2('0')
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
               CALL apmm100_pmaa_t_mask_restore('restore_mask_o')
               
               UPDATE pmaa_t SET (pmaa001,pmaa002,pmaa003,pmaastus,pmaa004,pmaa005,pmaa006,pmaa007,pmaa008, 
                   pmaa009,pmaa010,pmaa011,pmaa230,pmaaud001,pmaaud002,pmaa017,pmaa016,pmaa018,pmaa019, 
                   pmaa021,pmaa022,pmaa020,pmaa023,pmaa024,pmaa025,pmaa026,pmaa098,pmaa028,pmaa029,pmaa090, 
                   pmaa091,pmaa092,pmaa094,pmaa093,pmaa095,pmaa096,pmaa097,pmaa080,pmaa081,pmaa082,pmaa084, 
                   pmaa083,pmaa085,pmaa086,pmaa087,pmaa088,pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040, 
                   pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071, 
                   pmaa073,pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059, 
                   pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,pmaa292, 
                   pmaa293,pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaa281,pmaa282,pmaa283, 
                   pmaa284,pmaa285,pmaa286,pmaa287,pmaa288,pmaa289,pmaa290,pmaaownid,pmaaowndp,pmaacrtid, 
                   pmaacrtdp,pmaacrtdt,pmaamodid,pmaamoddt,pmaacnfid,pmaacnfdt) = (g_pmaa_m.pmaa001, 
                   g_pmaa_m.pmaa002,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005, 
                   g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010, 
                   g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017, 
                   g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
                   g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026, 
                   g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091, 
                   g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096, 
                   g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084, 
                   g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087,g_pmaa_m.pmaa088, 
                   g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
                   g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044, 
                   g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072, 
                   g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052, 
                   g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057, 
                   g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060, 
                   g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
                   g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293, 
                   g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298, 
                   g_pmaa_m.pmaa299,g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283, 
                   g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288, 
                   g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid, 
                   g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid, 
                   g_pmaa_m.pmaacnfdt)
                WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #新增到ooff_t 備註
               IF NOT cl_null(g_pmaa_m.ooff013) THEN
                  LET l_success = '' 
                  CALL s_aooi360_gen('2',g_pmaa_m.pmaa001,'','','','','','','','','','4',g_pmaa_m.ooff013) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooff_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
               ELSE
                  CALL s_aooi360_del('2',g_pmaa_m.pmaa001,'','','','','','','','','','4') RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooff_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF           
               END IF
               
               #150922-00020#3-Start-Add
               IF g_argv[1] = '2' THEN
                  LET l_pmab081 = ' '
                  LET l_pmab109 = ' '
                  SELECT pmab081,pmab109
                    INTO l_pmab081,l_pmab109
                    FROM pmab_t
                    WHERE pmabent = g_enterprise 
                     AND pmabsite = 'ALL'
                     AND pmab001 = g_pmaa_m.pmaa001 
                  IF cl_null(l_pmab081) THEN LET l_pmab081 = ' ' END IF 
                  IF cl_null(l_pmab109) THEN LET l_pmab109 = ' ' END IF
                  
                  IF l_pmab081 != g_pmaa_m.pmaa096 OR l_pmab109 != g_pmaa_m.pmaa097 THEN                   
                     UPDATE pmab_t SET (pmab081,pmab109) =           #負責業務人員,負責業務人員
                                       (g_pmaa_m.pmaa096,g_pmaa_m.pmaa097)
                      WHERE pmabent = g_enterprise 
                        AND pmabsite = 'ALL'
                        AND pmab001 = g_pmaa_m.pmaa001                   
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "g_pmab_m"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()  
                        CALL s_transaction_end('N','0')
                     END IF
                     IF g_pmaa_m.pmaastus = 'Y' THEN #已確認單據才需要重新拋轉到axmm202
                        IF NOT s_aooi090_upd_fields('4',g_pmaa_m.pmaa001) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'sub-00034'
                           LET g_errparam.extend = g_pmaa_m.pmaa001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                         END IF   
                     END IF 
                  END IF
               END IF 
               #150922-00020#3-End-Add
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_pmaa_m.pmaa001 = g_master_multi_table_t.pmaal001 AND
         g_pmaa_m.pmaal004 = g_master_multi_table_t.pmaal004 AND 
         g_pmaa_m.pmaal003 = g_master_multi_table_t.pmaal003 AND 
         g_pmaa_m.pmaal006 = g_master_multi_table_t.pmaal006 AND 
         g_pmaa_m.pmaal005 = g_master_multi_table_t.pmaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'pmaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_pmaa_m.pmaa001
            LET l_field_keys[02] = 'pmaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.pmaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'pmaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_pmaa_m.pmaal004
            LET l_fields[01] = 'pmaal004'
            LET l_vars[02] = g_pmaa_m.pmaal003
            LET l_fields[02] = 'pmaal003'
            LET l_vars[03] = g_pmaa_m.pmaal006
            LET l_fields[03] = 'pmaal006'
            LET l_vars[04] = g_pmaa_m.pmaal005
            LET l_fields[04] = 'pmaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pmaal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL apmm100_pmaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmaa_m_t)
               LET g_log2 = util.JSON.stringify(g_pmaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
 
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmaa001_t = g_pmaa_m.pmaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmm100.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmae_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmm100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmae_d.getLength()
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
            OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmm100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmm100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmae_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmae_d[l_ac].pmae002 IS NOT NULL
               AND g_pmae_d[l_ac].pmae003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmae_d_t.* = g_pmae_d[l_ac].*  #BACKUP
               LET g_pmae_d_o.* = g_pmae_d[l_ac].*  #BACKUP
               CALL apmm100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apmm100_set_no_entry_b(l_cmd)
               IF NOT apmm100_lock_b("pmae_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmm100_bcl INTO g_pmae_d[l_ac].pmae002,g_pmae_d[l_ac].pmae003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmae_d_t.pmae002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmae_d_mask_o[l_ac].* =  g_pmae_d[l_ac].*
                  CALL apmm100_pmae_t_mask()
                  LET g_pmae_d_mask_n[l_ac].* =  g_pmae_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmm100_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
 
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
            INITIALIZE g_pmae_d[l_ac].* TO NULL 
            INITIALIZE g_pmae_d_t.* TO NULL 
            INITIALIZE g_pmae_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmae_d_t.* = g_pmae_d[l_ac].*     #新輸入資料
            LET g_pmae_d_o.* = g_pmae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmm100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apmm100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmae_d[li_reproduce_target].* = g_pmae_d[li_reproduce].*
 
               LET g_pmae_d[li_reproduce_target].pmae002 = NULL
               LET g_pmae_d[li_reproduce_target].pmae003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_pmae_d[l_ac].pmae003 = '2'   #客戶
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
            SELECT COUNT(1) INTO l_count FROM pmae_t 
             WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001
 
               AND pmae002 = g_pmae_d[l_ac].pmae002
               AND pmae003 = g_pmae_d[l_ac].pmae003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmaa_m.pmaa001
               LET gs_keys[2] = g_pmae_d[g_detail_idx].pmae002
               LET gs_keys[3] = g_pmae_d[g_detail_idx].pmae003
               CALL apmm100_insert_b('pmae_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmae_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmm100_b_fill()
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
               LET gs_keys[01] = g_pmaa_m.pmaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmae_d_t.pmae002
               LET gs_keys[gs_keys.getLength()+1] = g_pmae_d_t.pmae003
 
            
               #刪除同層單身
               IF NOT apmm100_delete_b('pmae_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmm100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmm100_key_delete_b(gs_keys,'pmae_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmm100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmm100_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pmae_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmae002
            
            #add-point:AFTER FIELD pmae002 name="input.a.page1.pmae002"
            #此段落由子樣板a05產生
            CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
            DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
            
            IF  NOT cl_null(g_pmaa_m.pmaa001) AND NOT cl_null(g_pmae_d[l_ac].pmae002) AND NOT cl_null(g_pmae_d[l_ac].pmae003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmaa_m.pmaa001 != g_pmaa001_t OR g_pmae_d[l_ac].pmae002 != g_pmae_d_t.pmae002 OR g_pmae_d[l_ac].pmae003 != g_pmae_d_t.pmae003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmae_t WHERE "||"pmaeent = '" ||g_enterprise|| "' AND "||"pmae001 = '"||g_pmaa_m.pmaa001 ||"' AND "|| "pmae002 = '"||g_pmae_d[l_ac].pmae002 ||"' AND "|| "pmae003 = '"||g_pmae_d[l_ac].pmae003 ||"'",'std-00004',0) THEN 
                     LET g_pmae_d[l_ac].pmae002 = g_pmae_d_t.pmae002
                     CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmae_d[l_ac].pmae002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '235' AND oocq002 = ? ","apm-00163",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmae_d[l_ac].pmae002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '235' AND oocq002 = ? ","sub-01303",'axmi011' ) THEN  #160318-00005#34
                     LET g_pmae_d[l_ac].pmae002 = g_pmae_d_t.pmae002
                     CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmae_d[l_ac].pmae002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '235' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00164",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmae_d[l_ac].pmae002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '235' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi011' ) THEN #160318-00005#34
                     LET g_pmae_d[l_ac].pmae002 = g_pmae_d_t.pmae002
                     CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmae002
            #add-point:BEFORE FIELD pmae002 name="input.b.page1.pmae002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmae002
            #add-point:ON CHANGE pmae002 name="input.g.page1.pmae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq005
            #add-point:BEFORE FIELD oocq005 name="input.b.page1.oocq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq005
            
            #add-point:AFTER FIELD oocq005 name="input.a.page1.oocq005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq005
            #add-point:ON CHANGE oocq005 name="input.g.page1.oocq005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmae003
            #add-point:BEFORE FIELD pmae003 name="input.b.page1.pmae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmae003
            
            #add-point:AFTER FIELD pmae003 name="input.a.page1.pmae003"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmae003
            #add-point:ON CHANGE pmae003 name="input.g.page1.pmae003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmae002
            #add-point:ON ACTION controlp INFIELD pmae002 name="input.c.page1.pmae002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'    #160524-00018#1
            LET g_qryparam.default1 = g_pmae_d[l_ac].pmae002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "235" #應用分類

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_pmae_d[l_ac].pmae002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmae_d[l_ac].pmae002 TO pmae002              #顯示到畫面上
            CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
            DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005

            NEXT FIELD pmae002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq005
            #add-point:ON ACTION controlp INFIELD oocq005 name="input.c.page1.oocq005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmae003
            #add-point:ON ACTION controlp INFIELD pmae003 name="input.c.page1.pmae003"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmae_d[l_ac].* = g_pmae_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmm100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmae_d[l_ac].pmae002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmae_d[l_ac].* = g_pmae_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmm100_pmae_t_mask_restore('restore_mask_o')
      
               UPDATE pmae_t SET (pmae001,pmae002,pmae003) = (g_pmaa_m.pmaa001,g_pmae_d[l_ac].pmae002, 
                   g_pmae_d[l_ac].pmae003)
                WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001 
 
                  AND pmae002 = g_pmae_d_t.pmae002 #項次   
                  AND pmae003 = g_pmae_d_t.pmae003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmae_d[l_ac].* = g_pmae_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmae_d[l_ac].* = g_pmae_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmaa_m.pmaa001
               LET gs_keys_bak[1] = g_pmaa001_t
               LET gs_keys[2] = g_pmae_d[g_detail_idx].pmae002
               LET gs_keys_bak[2] = g_pmae_d_t.pmae002
               LET gs_keys[3] = g_pmae_d[g_detail_idx].pmae003
               LET gs_keys_bak[3] = g_pmae_d_t.pmae003
               CALL apmm100_update_b('pmae_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmm100_pmae_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmae_d[g_detail_idx].pmae002 = g_pmae_d_t.pmae002 
                  AND g_pmae_d[g_detail_idx].pmae003 = g_pmae_d_t.pmae003 
 
                  ) THEN
                  LET gs_keys[01] = g_pmaa_m.pmaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmae_d_t.pmae002
                  LET gs_keys[gs_keys.getLength()+1] = g_pmae_d_t.pmae003
 
                  CALL apmm100_key_update_b(gs_keys,'pmae_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmaa_m),util.JSON.stringify(g_pmae_d_t)
               LET g_log2 = util.JSON.stringify(g_pmaa_m),util.JSON.stringify(g_pmae_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apmm100_unlock_b("pmae_t","'1'")
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
               LET g_pmae_d[li_reproduce_target].* = g_pmae_d[li_reproduce].*
 
               LET g_pmae_d[li_reproduce_target].pmae002 = NULL
               LET g_pmae_d[li_reproduce_target].pmae003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmae_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apmm100.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_pmae_d2 FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmae_d2.getLength()+1) 
              LET g_insert = 'N' 
           END IF 

            CALL apmm100_b2_fill()
            LET g_rec_b2 = g_pmae_d2.getLength()
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd2 = ''
            LET l_ac2 = ARR_CURR()
            #LET g_detail_idx = l_ac2
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n2 = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apmm100_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apmm100_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                   
            #FETCH apmm100_cl INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaa002,g_pmaa_m.pmaal003,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa059,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296,g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281,g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286,g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_pmaa_m.pmaa001,SQLCA.sqlcode,0)
            #   CLOSE apmm100_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b2 = g_pmae_d2.getLength()
            
            IF g_rec_b2 >= l_ac2 
               AND NOT cl_null(g_pmae_d2[l_ac2].pmae002_1)
            THEN
               LET l_cmd2='u'
			   LET g_pmae_d2_t.* = g_pmae_d2[l_ac2].*  #BACKUP
               #CALL apmm100_set_entry_b(l_cmd)
               #CALL apmm100_set_no_entry_b(l_cmd)
               
               OPEN apmm100_bcl5 USING g_enterprise,g_pmaa_m.pmaa001,g_pmae_d2[l_ac2].pmae002_1,'1'
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmm100_bcl2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmm100_bcl5 INTO g_pmae_d2[l_ac2].pmae002_1,g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                  CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                  DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pmae_d2_t.pmae002_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill2 = "N"
                  CALL apmm100_show()
				  LET g_bfill2 = "Y"
				  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd2='a'
            END IF
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n2 = ARR_COUNT()
            LET l_cmd2 = 'a'
            INITIALIZE g_pmae_d2[l_ac2].* TO NULL 
            
            LET g_pmae_d2_t.* = g_pmae_d2[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            #CALL apmm100_set_entry_b(l_cmd)
            #CALL apmm100_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
 
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM pmae_t 
             WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001
               AND pmae002 = g_pmae_d2[l_ac2].pmae002_1 AND pmae003 = '1'
         
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmae_t (pmaeent,pmae001,pmae002,pmae003) 
                  VALUES (g_enterprise,g_pmaa_m.pmaa001,g_pmae_d2[l_ac2].pmae002_1,'1') #pmae003='1'代表供應商
               
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmae_d2[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmae_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b2 = g_rec_b2 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_pmae_d2[l_ac2].pmae002_1) THEN     
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               DELETE FROM pmae_t
                WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001 
                  AND pmae002 = g_pmae_d2_t.pmae002_1
                  AND pmae003 = '1'

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmae_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b2 = g_rec_b2-1
                  
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apmm100_bcl5
               LET l_count = g_pmae_d2.getLength()
            END IF 
            
         AFTER FIELD pmae002_1
         
            CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
            DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
            
            IF  NOT cl_null(g_pmaa_m.pmaa001) AND NOT cl_null(g_pmae_d2[l_ac2].pmae002_1) THEN 
               IF l_cmd2 = 'a' OR ( l_cmd2 = 'u' AND (g_pmae_d2[l_ac2].pmae002_1 != g_pmae_d2_t.pmae002_1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmae_t WHERE "||"pmaeent = '" ||g_enterprise|| "' AND "||"pmae001 = '"||g_pmaa_m.pmaa001 ||"' AND "|| "pmae002 = '"||g_pmae_d2[l_ac2].pmae002_1 ||"' AND "|| "pmae003 = '1'",'std-00004',0) THEN 
                     LET g_pmae_d2[l_ac2].pmae002_1 = g_pmae_d2_t.pmae002_1
                     CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmae_d2[l_ac2].pmae002_1,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '242' AND oocq002 = ? ","apm-00165",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmae_d2[l_ac2].pmae002_1,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '242' AND oocq002 = ? ","sub-01303",'apmi021' ) THEN #160318-00005#34
                     LET g_pmae_d2[l_ac2].pmae002_1 = g_pmae_d2_t.pmae002_1
                     CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmae_d2[l_ac2].pmae002_1,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '242' AND oocq002 = ? AND oocqstus = 'Y' ","apm-00166",1 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmae_d2[l_ac2].pmae002_1,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '242' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'apmi021' ) THEN  #160318-00005#34
                     LET g_pmae_d2[l_ac2].pmae002_1 = g_pmae_d2_t.pmae002_1
                     CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
            DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1


         ON ACTION controlp INFIELD pmae002_1
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmae_d2[l_ac2].pmae002_1             #給予default值
            LET g_qryparam.state = 'i'     #fengmy160518
            #給予arg
            LET g_qryparam.arg1 = "242" #應用分類

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_pmae_d2[l_ac2].pmae002_1 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmae_d2[l_ac2].pmae002_1 TO pmae002_1              #顯示到畫面上
            CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
            DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1

            NEXT FIELD pmae002_1                          #返回原欄位

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmae_d2[l_ac2].* = g_pmae_d2_t.*
               CLOSE apmm100_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmae_d2[l_ac2].pmae002_1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmae_d2[l_ac2].* = g_pmae_d2_t.*
            ELSE

               UPDATE pmae_t SET (pmae001,pmae002) = (g_pmaa_m.pmaa001,g_pmae_d2[l_ac2].pmae002_1)
                WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001 
                  AND pmae002 = g_pmae_d_t.pmae002 #項次   
                  AND pmae003 = '1'

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmae_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_pmae_d2[l_ac2].* = g_pmae_d2_t.*
               END IF
               
            END IF
            
         AFTER ROW
            CLOSE apmm100_bcl5
            CALL s_transaction_end('Y','0')
             
      END INPUT

      #聯絡地址輸入
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      #通訊方式輸入
      SUBDIALOG aoo_aooi350_02.aooi350_02_input
      #交易夥伴輸入
      SUBDIALOG apm_apmm100_01.apmm100_01_input
      #銀行資訊輸入
      SUBDIALOG apm_apmm100_02.apmm100_02_input
      #收款條件輸入
      SUBDIALOG apm_apmm100_03.apmm100_03_input
      #付款條件輸入
      SUBDIALOG apm_apmm100_05.apmm100_05_input
      
         ON ACTION aooi350_01
           IF cl_auth_chk_act("aooi350_01") THEN 
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                  CALL aooi350_01(l_pmaa027)
               END IF
            END IF


         ON ACTION aooi350_02
            IF cl_auth_chk_act("aooi350_02") THEN 
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  LET l_pmaa027 = ' '
                  SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
                  CALL aooi350_02(l_pmaa027)
               END IF
            END IF


         ON ACTION apmm100_01
            IF cl_auth_chk_act("apmm100_01") THEN 
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_01(g_pmaa_m.pmaa001)
               END IF
            END IF


         ON ACTION apmm100_02
            IF cl_auth_chk_act("apmm100_02") THEN 
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_02(g_pmaa_m.pmaa001)
               END IF
            END IF


         ON ACTION apmm100_03
            IF cl_auth_chk_act("apmm100_03") THEN 
               #收款條件
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_03(g_pmaa_m.pmaa001,'2')
               END IF
            END IF


         ON ACTION apmm100_03_1
            IF cl_auth_chk_act("apmm100_03_1") THEN 
               #付款條件
               IF NOT cl_null(g_pmaa_m.pmaa001) THEN
                  CALL apmm100_03(g_pmaa_m.pmaa001,'1')
               END IF
            END IF
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
               WHEN "s_detail1_apmm100_01"
                  NEXT FIELD pmacstus
               WHEN "s_detail1_apmm100_02"
                  NEXT FIELD pmafstus  
               WHEN "s_detail1_apmm100_03"
                  NEXT FIELD pmad001_2 
               WHEN "s_detail1_apmm100_05"
                  NEXT FIELD pmad001_1                  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pmaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmae002
 
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
   #'ALL'集團層的據點資料維護
   IF l_flag THEN
      LET l_flag = FALSE
      
      #160920-00003#1 add --(S)--
      #若是新增狀態,將允許收款條件頁籤中的主要交易條件帶至apmm101的慣用收款條件欄位當預設值
      IF NOT cl_null(p_cmd) AND p_cmd <> 'r' AND 
         NOT cl_null(l_cmd_t) AND l_cmd_t = 'a' AND
         NOT cl_null(g_pmaa_m.pmaa001) THEN
         LET l_pmad002 = NULL
         SELECT pmad002 INTO l_pmad002
           FROM pmad_t
          WHERE pmadent = g_enterprise
            AND pmad001 = g_pmaa_m.pmaa001
            AND pmad003 = 2
            AND pmad004 = 'Y'
            AND pmadstus = 'Y'
         IF NOT cl_null(l_pmad002) THEN
            UPDATE pmab_t SET pmab087 = l_pmad002
              WHERE pmabent = g_enterprise AND pmabsite = 'ALL'
                AND pmab001 = g_pmaa_m.pmaa001
         END IF
      END IF
      #160920-00003#1 add --(E)--
      
      IF NOT cl_null(g_pmaa_m.pmaa001) THEN
         CASE g_argv[1]
            WHEN '1' #LET l_cm = "apmm201 '"||g_pmaa_m.pmaa001||"'"    
                     LET la_param.prog = 'apmm201'
                     LET la_param.param[1] = g_pmaa_m.pmaa001
                     LET ls_js = util.JSON.stringify( la_param )                         
            WHEN '2' #LET l_cm = "axmm201 '"||g_pmaa_m.pmaa001||"'"
                     LET la_param.prog = 'axmm201'
                     LET la_param.param[1] = g_pmaa_m.pmaa001
                     LET ls_js = util.JSON.stringify( la_param ) 
            WHEN '3' #LET l_cm = "apmm101 '"||g_pmaa_m.pmaa001||"'"
                     LET la_param.prog = 'apmm101'
                     LET la_param.param[1] = g_pmaa_m.pmaa001
                     LET ls_js = util.JSON.stringify( la_param ) 
         END CASE
         #CALL cl_cmdrun_wait(l_cm)
         CALL cl_cmdrun_wait(ls_js)
      END IF
   END IF   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmm100_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmm100_b_fill() #單身填充
      CALL apmm100_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmm100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   IF g_bfill2 = "Y" THEN
      CALL apmm100_b2_fill()                 #單身
   END IF
   
            #modify--2015/05/25 By shiun--(S)
            CALL apmm100_pmaa001_ref(g_pmaa_m.pmaa001) RETURNING g_pmaa_m.pmaal003,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaal006
            DISPLAY BY NAME g_pmaa_m.pmaal003,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaal006
            #modify--2015/05/25 By shiun--(E)
            
            #CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa005_desc
            #
            #CALL apmm100_pmaa006_ref(g_pmaa_m.pmaa006) RETURNING g_pmaa_m.pmaa006_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa006_desc
            #
            #CALL apmm100_pmaa007_ref(g_pmaa_m.pmaa007) RETURNING g_pmaa_m.pmaa007_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa007_desc
            #
            #CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa011) RETURNING g_pmaa_m.pmaa011_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa011_desc
            #
            #CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa019) RETURNING g_pmaa_m.pmaa019_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa019_desc
            #
            #CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa022) RETURNING g_pmaa_m.pmaa022_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa022_desc
            #
            #CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            #
            #CALL apmm100_pmaa009_ref(g_pmaa_m.pmaa009) RETURNING g_pmaa_m.pmaa009_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa009_desc
            #
            #CALL apmm100_pmaa023_ref(g_pmaa_m.pmaa023) RETURNING g_pmaa_m.pmaa023_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa023_desc
            #
            #CALL apmm100_pmaa024_ref(g_pmaa_m.pmaa024) RETURNING g_pmaa_m.pmaa024_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa024_desc
            #
            #CALL apmm100_pmaa026_ref(g_pmaa_m.pmaa026) RETURNING g_pmaa_m.pmaa026_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa026_desc
            #
            #CALL apmm100_pmaa090_ref(g_pmaa_m.pmaa090) RETURNING g_pmaa_m.pmaa090_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa090_desc
            #
            #CALL apmm100_pmaa091_ref(g_pmaa_m.pmaa091) RETURNING g_pmaa_m.pmaa091_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa091_desc
            #
            #CALL apmm100_pmaa094_ref(g_pmaa_m.pmaa094) RETURNING g_pmaa_m.pmaa094_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa094_desc
            #
            #CALL apmm100_pmaa093_ref(g_pmaa_m.pmaa093) RETURNING g_pmaa_m.pmaa093_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa093_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmaa_m.pmaa095
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_pmaa_m.pmaa095_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmaa_m.pmaa095_desc
            #
            #CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa096) RETURNING g_pmaa_m.pmaa096_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa096_desc
            #
            #
            #CALL apmm100_pmaa080_ref(g_pmaa_m.pmaa080) RETURNING g_pmaa_m.pmaa080_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa080_desc
            #
            #CALL apmm100_pmaa081_ref(g_pmaa_m.pmaa081) RETURNING g_pmaa_m.pmaa081_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa081_desc
            #
            #CALL apmm100_pmaa084_ref(g_pmaa_m.pmaa084) RETURNING g_pmaa_m.pmaa084_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa084_desc
            #
            #CALL apmm100_pmaa083_ref(g_pmaa_m.pmaa083) RETURNING g_pmaa_m.pmaa083_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa083_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmaa_m.pmaa085
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_pmaa_m.pmaa085_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmaa_m.pmaa085_desc
            #
            #CALL apmm100_pmaa096_ref(g_pmaa_m.pmaa086) RETURNING g_pmaa_m.pmaa086_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa086_desc
            #
            #CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa052_desc            
            #
            #CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa291,'2061') RETURNING g_pmaa_m.pmaa291_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa291_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa292,'2062') RETURNING g_pmaa_m.pmaa292_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa292_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa293,'2063') RETURNING g_pmaa_m.pmaa293_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa293_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa294,'2064') RETURNING g_pmaa_m.pmaa294_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa294_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa295,'2065') RETURNING g_pmaa_m.pmaa295_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa295_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa296,'2066') RETURNING g_pmaa_m.pmaa296_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa296_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa297,'2067') RETURNING g_pmaa_m.pmaa297_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa297_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa298,'2068') RETURNING g_pmaa_m.pmaa298_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa298_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa299,'2069') RETURNING g_pmaa_m.pmaa299_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa299_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa300,'2070') RETURNING g_pmaa_m.pmaa300_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa300_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa281,'2037') RETURNING g_pmaa_m.pmaa281_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa281_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa282,'2038') RETURNING g_pmaa_m.pmaa282_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa282_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa283,'2039') RETURNING g_pmaa_m.pmaa283_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa283_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa284,'2040') RETURNING g_pmaa_m.pmaa284_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa284_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa285,'2041') RETURNING g_pmaa_m.pmaa285_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa285_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa286,'2042') RETURNING g_pmaa_m.pmaa286_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa286_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa287,'2043') RETURNING g_pmaa_m.pmaa287_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa287_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa288,'2044') RETURNING g_pmaa_m.pmaa288_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa288_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa289,'2045') RETURNING g_pmaa_m.pmaa289_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa289_desc
            #
            #CALL apmm100_pmaa291_ref(g_pmaa_m.pmaa290,'2046') RETURNING g_pmaa_m.pmaa290_desc
            #DISPLAY BY NAME g_pmaa_m.pmaa290_desc
            
            
            
            #顯示備註
            IF NOT cl_null(g_pmaa_m.pmaa001) THEN
               CALL s_aooi360_sel('2',g_pmaa_m.pmaa001,'','','','','','','','','','4') RETURNING l_success,g_pmaa_m.ooff013
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmaa_m.pmaacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmaa_m.pmaacnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmaa_m.pmaacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pmaa_m_mask_o.* =  g_pmaa_m.*
   CALL apmm100_pmaa_t_mask()
   LET g_pmaa_m_mask_n.* =  g_pmaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
       g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc, 
       g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc, 
       g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018, 
       g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc, 
       g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029, 
       g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092, 
       g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095, 
       g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097,g_pmaa_m.pmaa097_desc, 
       g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082, 
       g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085, 
       g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087,g_pmaa_m.pmaa087_desc, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc, 
       g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058, 
       g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062, 
       g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291, 
       g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc, 
       g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296, 
       g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc, 
       g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281, 
       g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc, 
       g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc, 
       g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013, 
       g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid, 
       g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
       g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmaa_m.pmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmae_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
      DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   ##要先取得聯絡對象識別碼才能取得通訊地址, 聯絡方式單身資料
   #SELECT pmaa027 INTO g_pmaa027_d FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
   #CALL aooi350_01_b_fill(g_pmaa027_d)
   #CALL aooi350_02_b_fill(g_pmaa027_d)
   #
   #LET g_pmaa001_d = g_pmaa_m.pmaa001
   #CALL apmm100_01_b_fill(g_pmaa001_d)
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmm100_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmm100_detail_show()
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
 
{<section id="apmm100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmm100_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmaa_t.pmaa001 
   DEFINE l_oldno     LIKE pmaa_t.pmaa001 
 
   DEFINE l_master    RECORD LIKE pmaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmae_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_oofa001       LIKE oofa_t.oofa001
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
   
   IF g_pmaa_m.pmaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmaa001_t = g_pmaa_m.pmaa001
 
    
   LET g_pmaa_m.pmaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmaa_m.pmaaownid = g_user
      LET g_pmaa_m.pmaaowndp = g_dept
      LET g_pmaa_m.pmaacrtid = g_user
      LET g_pmaa_m.pmaacrtdp = g_dept 
      LET g_pmaa_m.pmaacrtdt = cl_get_current()
      LET g_pmaa_m.pmaamodid = g_user
      LET g_pmaa_m.pmaamoddt = cl_get_current()
      LET g_pmaa_m.pmaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmaa_m.pmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL apmm100_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmaa_m.* TO NULL
      INITIALIZE g_pmae_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmm100_show()
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
   CALL apmm100_set_act_visible()   
   CALL apmm100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmaa001_t = g_pmaa_m.pmaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmaaent = " ||g_enterprise|| " AND",
                      " pmaa001 = '", g_pmaa_m.pmaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmm100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmm100_idx_chk()
   
   LET g_data_owner = g_pmaa_m.pmaaownid      
   LET g_data_dept  = g_pmaa_m.pmaaowndp
   
   #功能已完成,通報訊息中心
   CALL apmm100_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmm100_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmae_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmm100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmae_t
    WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa001_t
 
    INTO TEMP apmm100_detail
 
   #將key修正為調整後   
   UPDATE apmm100_detail 
      #更新key欄位
      SET pmae001 = g_pmaa_m.pmaa001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmae_t SELECT * FROM apmm100_detail
   
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
   DROP TABLE apmm100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmaa001_t = g_pmaa_m.pmaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmm100_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_pmaa027       LIKE pmaa_t.pmaa027
   DEFINE  l_pmaj002       LIKE pmaj_t.pmaj002
   DEFINE  l_success       LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pmaa_m.pmaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.pmaal001 = g_pmaa_m.pmaa001
LET g_master_multi_table_t.pmaal004 = g_pmaa_m.pmaal004
LET g_master_multi_table_t.pmaal003 = g_pmaa_m.pmaal003
LET g_master_multi_table_t.pmaal006 = g_pmaa_m.pmaal006
LET g_master_multi_table_t.pmaal005 = g_pmaa_m.pmaal005
 
   
   CALL s_transaction_begin()
 
   OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmm100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmm100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmm100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmaa_m_mask_o.* =  g_pmaa_m.*
   CALL apmm100_pmaa_t_mask()
   LET g_pmaa_m_mask_n.* =  g_pmaa_m.*
   
   CALL apmm100_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      LET l_pmaa027 = ' '
      SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmm100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmaa001_t = g_pmaa_m.pmaa001
 
 
      DELETE FROM pmaa_t
       WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmaa_m.pmaa001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #刪除多語言檔
      DELETE FROM pmaal_t
       WHERE pmaalent = g_enterprise AND pmaal001 = g_pmaa_m.pmaa001
      
      #刪除ooff_t備註
      LET l_success = ''
      CALL s_aooi360_del('2',g_pmaa_m.pmaa001,'','','','','','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
  
         CALL s_transaction_end('N','0')
         RETURN
      END IF
    
      #刪除oofa_t 聯絡信息
      IF NOT s_aooi350_del(l_pmaa027) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oofa_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pmab_t
       WHERE pmabent = g_enterprise AND pmab001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pmac_t
       WHERE pmacent = g_enterprise AND pmac001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pmad_t
       WHERE pmadent = g_enterprise AND pmad001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmad_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pmae_t
       WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmae_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pmaf_t
       WHERE pmafent = g_enterprise AND pmaf001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmaf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DECLARE pmaj002_cur CURSOR FOR 
        SELECT pmaj002 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = g_pmaa_m.pmaa001
      FOREACH pmaj002_cur INTO l_pmaj002
         IF NOT s_aooi350_del(l_pmaj002) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "oofa_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END FOREACH
      DELETE FROM pmaj_t
       WHERE pmajent = g_enterprise AND pmaj001 = g_pmaa_m.pmaa001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmaj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pmae_t
       WHERE pmaeent = g_enterprise AND pmae001 = g_pmaa_m.pmaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      CALL aooi350_01_clear_detail()   #清除聯絡地址
      CALL aooi350_02_clear_detail()   #清除通訊方式
      CALL apmm100_01_clear_detail()   #清除交易夥伴
      CALL apmm100_02_clear_detail()   #清除銀行資訊
      CALL apmm100_03_clear_detail()   #清除收款條件
      CALL apmm100_05_clear_detail()   #清除付款條件
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmm100_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmae_d.clear() 
 
     
      CALL apmm100_ui_browser_refresh()  
      #CALL apmm100_ui_headershow()  
      #CALL apmm100_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'pmaalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.pmaal001
   LET l_field_keys[02] = 'pmaal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pmaal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmm100_browser_fill("")
         CALL apmm100_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmm100_cl
 
   #功能已完成,通報訊息中心
   CALL apmm100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmm100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmm100_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmae_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc2_table1) OR g_wc2_table1 = " 1=1" THEN
      LET g_wc2_table1 = " pmae003 = '2' "
   END IF
   #end add-point
   
   #判斷是否填充
   IF apmm100_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmae002,pmae003 ,t1.oocql004 FROM pmae_t",   
                     " INNER JOIN pmaa_t ON pmaaent = " ||g_enterprise|| " AND pmaa001 = pmae001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='235' AND t1.oocql002=pmae002 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmaeent=? AND pmae001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmae_t.pmae002,pmae_t.pmae003"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmm100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmm100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmaa_m.pmaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmaa_m.pmaa001 INTO g_pmae_d[l_ac].pmae002,g_pmae_d[l_ac].pmae003, 
          g_pmae_d[l_ac].pmae002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL apmm100_pmae002_ref(g_pmae_d[l_ac].pmae002,'235') RETURNING g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
         DISPLAY BY NAME g_pmae_d[l_ac].pmae002_desc,g_pmae_d[l_ac].oocq005
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
   CALL apmm100_b2_fill()   
   
   #要先取得聯絡對象識別碼才能取得通訊地址, 聯絡方式單身資料
   SELECT pmaa027 INTO g_pmaa027_d FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
   IF NOT cl_null(g_pmaa027_d) THEN
      CALL aooi350_01_b_fill(g_pmaa027_d)
      CALL aooi350_02_b_fill(g_pmaa027_d)
   END IF
   
   LET g_pmaa001_d = g_pmaa_m.pmaa001
   CALL apmm100_01_b_fill(g_pmaa001_d)
   CALL apmm100_02_b_fill(g_pmaa001_d)
   CALL apmm100_03_b_fill(g_pmaa001_d,'2') #收款
   CALL apmm100_05_b_fill(g_pmaa001_d,'1') #付款
   #end add-point
   
   CALL g_pmae_d.deleteElement(g_pmae_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmm100_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmae_d.getLength()
      LET g_pmae_d_mask_o[l_ac].* =  g_pmae_d[l_ac].*
      CALL apmm100_pmae_t_mask()
      LET g_pmae_d_mask_n[l_ac].* =  g_pmae_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmm100_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmae_t
       WHERE pmaeent = g_enterprise AND
         pmae001 = ps_keys_bak[1] AND pmae002 = ps_keys_bak[2] AND pmae003 = ps_keys_bak[3]
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
         CALL g_pmae_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmm100_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmae_t
                  (pmaeent,
                   pmae001,
                   pmae002,pmae003
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmae_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmm100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmae_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmm100_pmae_t_mask_restore('restore_mask_o')
               
      UPDATE pmae_t 
         SET (pmae001,
              pmae002,pmae003
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE pmaeent = g_enterprise AND pmae001 = ps_keys_bak[1] AND pmae002 = ps_keys_bak[2] AND pmae003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmm100_pmae_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmm100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmm100_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmm100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmm100_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmm100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmm100_lock_b(ps_table,ps_page)
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
   #CALL apmm100_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmae_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmm100_bcl USING g_enterprise,
                                       g_pmaa_m.pmaa001,g_pmae_d[g_detail_idx].pmae002,g_pmae_d[g_detail_idx].pmae003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmm100_bcl:",SQLERRMESSAGE 
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
 
{<section id="apmm100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmm100_unlock_b(ps_table,ps_page)
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
      CLOSE apmm100_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmm100_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmaa001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_argv[1] = '3' THEN
      CALL cl_set_comp_entry("pmaa002",TRUE)
   END IF
   IF g_argv[1] <> '1' THEN
      CALL cl_set_comp_entry("pmaa070,pmaa071",TRUE)
   END IF
   
   IF g_pmaa_m.pmaa004 <> '1' THEN
      CALL cl_set_comp_entry("pmaa005",TRUE)
      #160418-00001#1--mark--start--
      #LET g_pmaa_m.pmaa005 = ''
      #CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
      #DISPLAY BY NAME g_pmaa_m.pmaa005_desc
      #160418-00001#1--mark--end----   
   END IF
  
   IF g_pmaa_m.pmaa036 = 'Y' THEN
      CALL cl_set_comp_entry("pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046",TRUE)
   END IF
           
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmm100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmaa001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_argv[1] MATCHES '[12]' THEN
      CALL cl_set_comp_entry("pmaa002",FALSE)
   END IF
   
   #供應商
   IF g_argv[1] = '1' THEN
      CALL cl_set_comp_entry("pmaa070,pmaa071",FALSE)
   END IF
   
   IF g_pmaa_m.pmaa004 = '1' THEN
      CALL cl_set_comp_entry("pmaa005",FALSE)
      LET g_pmaa_m.pmaa005 = g_pmaa_m.pmaa001
      CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa005) RETURNING g_pmaa_m.pmaa005_desc
     #DISPLAY BY NAME g_pmaa_m.pmaa005_desc                  #160418-00001#1 mark
      DISPLAY BY NAME g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc #160418-00001#1 add
   END IF
   
   IF g_pmaa_m.pmaa036 <> 'Y' THEN
      CALL cl_set_comp_entry("pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046",FALSE)
   END IF
      
   #額度設置的頁簽的欄位透過action執行，不可直接維護
   CALL cl_set_comp_entry("pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,
                           pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmm100_set_entry_b(p_cmd)
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
 
{<section id="apmm100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmm100_set_no_entry_b(p_cmd)
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
 
{<section id="apmm100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmm100_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
 
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("delete,modify",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmm100_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_pmaa_m.pmaastus = 'Y' THEN
       CALL cl_set_act_visible("delete", FALSE)
    END IF
    IF g_pmaa_m.pmaastus = 'X' THEN
       CALL cl_set_act_visible("modify,delete", FALSE)
    END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmm100_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmm100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmm100_default_search()
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
      LET ls_wc = ls_wc, " pmaa001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " pmaa001 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pmaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmae_t" 
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
   IF NOT cl_null(g_argv[01]) THEN
      CASE g_argv[01] 
         WHEN '1' LET g_wc = g_wc, " AND (pmaa002 = '1' OR pmaa002 = '3' ) "
         WHEN '2' LET g_wc = g_wc, " AND (pmaa002 = '2' OR pmaa002 = '3' ) "
         WHEN '3' LET g_wc = g_wc, " AND 1=1"
      END CASE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmm100.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmm100_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmaa_m.pmaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmm100_cl USING g_enterprise,g_pmaa_m.pmaa001
   IF STATUS THEN
      CLOSE apmm100_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmm100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaa003, 
       g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002, 
       g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa098, 
       g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094, 
       g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080,g_pmaa_m.pmaa081, 
       g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086,g_pmaa_m.pmaa087, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055, 
       g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
       g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
       g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293,g_pmaa_m.pmaa294, 
       g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299,g_pmaa_m.pmaa300, 
       g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaowndp, 
       g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt, 
       g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007_desc, 
       g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa023_desc, 
       g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa094_desc, 
       g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080_desc, 
       g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086_desc, 
       g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa291_desc, 
       g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296_desc, 
       g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281_desc, 
       g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286_desc, 
       g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc,g_pmaa_m.pmaaownid_desc, 
       g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaamodid_desc, 
       g_pmaa_m.pmaacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmm100_action_chk() THEN
      CLOSE apmm100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
       g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc, 
       g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008, 
       g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc, 
       g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018, 
       g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc, 
       g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc, 
       g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029, 
       g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092, 
       g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095, 
       g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097,g_pmaa_m.pmaa097_desc, 
       g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082, 
       g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085, 
       g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087,g_pmaa_m.pmaa087_desc, 
       g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039, 
       g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045, 
       g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071, 
       g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc, 
       g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058, 
       g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062, 
       g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291, 
       g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc, 
       g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296, 
       g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc, 
       g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281, 
       g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc, 
       g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286, 
       g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc, 
       g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013, 
       g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid, 
       g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
       g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt 
 
 
   CASE g_pmaa_m.pmaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pmaa_m.pmaastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
        CALL cl_set_act_visible("open,unvoid,confirmed,void", TRUE)
        CASE g_pmaa_m.pmaastus
            WHEN "N"
               #HIDE OPTION "unconfirmed,invalid,valid"
               CALL cl_set_act_visible("open,unvoid", FALSE)
               
            WHEN "X"
               #HIDE OPTION "void,invalid,valid,unconfirmed,confirmed"
               CALL cl_set_act_visible("void,open,valid", FALSE)

            WHEN "Y"
               #HIDE OPTION "confirm,invalid,valid,void"
               CALL cl_set_act_visible("valid,void,unvoid", FALSE)


         END CASE
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
             CALL s_transaction_begin()
             IF NOT s_apmm100_unconf_chk(g_pmaa_m.pmaa001) THEN
                CALL s_transaction_end('N','0')   #160816-00068#15
                RETURN
             ELSE
                IF NOT cl_ask_confirm('aim-00110') THEN
                   CALL s_transaction_end('N','0')   #160816-00068#15
                   RETURN
                ELSE
                   IF NOT s_apmm100_unconf_upd(g_pmaa_m.pmaa001) THEN
                      CALL s_transaction_end('N','0')
                      RETURN
                   ELSE
                      CALL s_transaction_end('Y','0')
                   END IF
                END IF
             END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            CALL s_transaction_begin()
            IF NOT s_apmm100_conf_chk(g_pmaa_m.pmaa001) THEN
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN
            ELSE
               IF NOT cl_ask_confirm('aim-00108') THEN
                  CALL s_transaction_end('N','0')   #160816-00068#15
                  RETURN
               ELSE
                  CALL s_transaction_begin()
                  IF NOT s_apmm100_conf_upd(g_pmaa_m.pmaa001) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            CALL s_transaction_begin()
            IF NOT s_apmm100_void_chk(g_pmaa_m.pmaa001) THEN
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN
            ELSE
               IF NOT cl_ask_confirm('art-00039') THEN
                  CALL s_transaction_end('N','0')   #160816-00068#15
                  RETURN
               ELSE
                  IF NOT s_apmm100_void_upd(g_pmaa_m.pmaa001) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
         END IF
         
         EXIT MENU
         
      ON ACTION unvoid
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "N"

            CALL s_transaction_begin()
            IF NOT s_apmm100_unvoid_chk(g_pmaa_m.pmaa001) THEN
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN
            ELSE
               IF NOT cl_ask_confirm('apm-00167') THEN
                  CALL s_transaction_end('N','0')   #160816-00068#15
                  RETURN
               ELSE
                  IF NOT s_apmm100_unvoid_upd(g_pmaa_m.pmaa001) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      #  CALL cl_set_act_visible("open,unvoid,valid,void", TRUE)
      #  CASE g_pmaa_m.pmaastus
      #      WHEN "N"
      #         #HIDE OPTION "unconfirmed,invalid,valid"
      #         CALL cl_set_act_visible("open,unvoid", FALSE)
      #         
      #      WHEN "X"
      #         #HIDE OPTION "void,invalid,valid,unconfirmed,confirmed"
      #         CALL cl_set_act_visible("void,open,valid", FALSE)
#
      #      WHEN "Y"
      #         #HIDE OPTION "confirm,invalid,valid,void"
      #         CALL cl_set_act_visible("valid,void,unvoid", FALSE)
#
#
      #   END CASE
     #
	 # 
     # ON ACTION unconfirmed
     #    LET lc_state = "N"
     #    #add-point:action控制
     #    CALL s_transaction_begin()
     #    IF NOT s_apmm100_unconf_chk(g_pmaa_m.pmaa001) THEN
     #       RETURN
     #    ELSE
     #       IF NOT cl_ask_confirm('aim-00110') THEN
     #          RETURN
     #       ELSE
     #          IF NOT s_apmm100_unconf_upd(g_pmaa_m.pmaa001) THEN
     #             CALL s_transaction_end('N','0')
     #             RETURN
     #          ELSE
     #             CALL s_transaction_end('Y','0')
     #          END IF
     #       END IF
     #    END IF
#
     #    EXIT MENU
     #    
     # ON ACTION confirmed
     #    LET lc_state = "Y"
     #    #add-point:action控制
     #    CALL s_transaction_begin()
     #    IF NOT s_apmm100_conf_chk(g_pmaa_m.pmaa001) THEN
     #       RETURN
     #    ELSE
     #       IF NOT cl_ask_confirm('aim-00108') THEN
     #          RETURN
     #       ELSE
     #          IF NOT s_apmm100_conf_upd(g_pmaa_m.pmaa001) THEN
     #             CALL s_transaction_end('N','0')
     #             RETURN
     #          ELSE
     #             CALL s_transaction_end('Y','0')
     #          END IF
     #       END IF
     #    END IF
     #    EXIT MENU
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_pmaa_m.pmaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmm100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_pmaa_m.pmaamodid = g_user
   LET g_pmaa_m.pmaamoddt = cl_get_current()
   LET g_pmaa_m.pmaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmaa_t 
      SET (pmaastus,pmaamodid,pmaamoddt) 
        = (g_pmaa_m.pmaastus,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt)     
    WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE apmm100_master_referesh USING g_pmaa_m.pmaa001 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaa002, 
          g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa006,g_pmaa_m.pmaa007, 
          g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001, 
          g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa021, 
          g_pmaa_m.pmaa022,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa024,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026, 
          g_pmaa_m.pmaa098,g_pmaa_m.pmaa028,g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa091,g_pmaa_m.pmaa092, 
          g_pmaa_m.pmaa094,g_pmaa_m.pmaa093,g_pmaa_m.pmaa095,g_pmaa_m.pmaa096,g_pmaa_m.pmaa097,g_pmaa_m.pmaa080, 
          g_pmaa_m.pmaa081,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa083,g_pmaa_m.pmaa085,g_pmaa_m.pmaa086, 
          g_pmaa_m.pmaa087,g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038, 
          g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044, 
          g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070, 
          g_pmaa_m.pmaa071,g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054, 
          g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059, 
          g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064, 
          g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa292,g_pmaa_m.pmaa293, 
          g_pmaa_m.pmaa294,g_pmaa_m.pmaa295,g_pmaa_m.pmaa296,g_pmaa_m.pmaa297,g_pmaa_m.pmaa298,g_pmaa_m.pmaa299, 
          g_pmaa_m.pmaa300,g_pmaa_m.pmaa281,g_pmaa_m.pmaa282,g_pmaa_m.pmaa283,g_pmaa_m.pmaa284,g_pmaa_m.pmaa285, 
          g_pmaa_m.pmaa286,g_pmaa_m.pmaa287,g_pmaa_m.pmaa288,g_pmaa_m.pmaa289,g_pmaa_m.pmaa290,g_pmaa_m.pmaaownid, 
          g_pmaa_m.pmaaowndp,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid, 
          g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfdt,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006_desc, 
          g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa022_desc, 
          g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091_desc, 
          g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097_desc, 
          g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085_desc, 
          g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054_desc, 
          g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295_desc, 
          g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300_desc, 
          g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285_desc, 
          g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290_desc, 
          g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp_desc, 
          g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaa002,g_pmaa_m.pmaal004,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006, 
          g_pmaa_m.pmaal005,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc, 
          g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008, 
          g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc, 
          g_pmaa_m.pmaa230,g_pmaa_m.pmaaud001,g_pmaa_m.pmaaud002,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018, 
          g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc, 
          g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc, 
          g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa098,g_pmaa_m.pmaa028, 
          g_pmaa_m.pmaa029,g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc, 
          g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc, 
          g_pmaa_m.pmaa095,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa097, 
          g_pmaa_m.pmaa097_desc,g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc, 
          g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc, 
          g_pmaa_m.pmaa085,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa087, 
          g_pmaa_m.pmaa087_desc,g_pmaa_m.pmaa088,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036, 
          g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043, 
          g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072, 
          g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa073,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc, 
          g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc,g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055, 
          g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075, 
          g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065, 
          g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292, 
          g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc, 
          g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296,g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297, 
          g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc, 
          g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281,g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282, 
          g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc, 
          g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286,g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287, 
          g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc, 
          g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc, 
          g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp, 
          g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt, 
          g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmm100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmm100_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmm100_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmae_d.getLength() THEN
         LET g_detail_idx = g_pmae_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmae_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmae_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #若停留在嵌入的Page, 必須更新單身筆數顯示
   CASE g_detail_id
      WHEN "cont_page"
         DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt
      WHEN "comm_page"
         DISPLAY g_d_idx_i35002, g_d_cnt_i35002 TO FORMONLY.idx, FORMONLY.cnt
      WHEN "friends_page"
         DISPLAY g_d_idx_m10001, g_d_cnt_m10001 TO FORMONLY.idx, FORMONLY.cnt
      WHEN "bank_page"
         DISPLAY g_d_idx_m10002, g_d_cnt_m10002 TO FORMONLY.idx, FORMONLY.cnt
      WHEN "receivable_page"
         #CALL apmm100_03_b_fill(g_pmaa_m.pmaa001,'2') #收款
         DISPLAY g_d_idx_m10003, g_d_cnt_m10003 TO FORMONLY.idx, FORMONLY.cnt 
      WHEN "pay_page"
         #CALL apmm100_05_b_fill(g_pmaa_m.pmaa001,'1')  #付款
         DISPLAY g_d_idx_m10005, g_d_cnt_m10005 TO FORMONLY.idx, FORMONLY.cnt         
   END CASE
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmm100_b_fill2(pi_idx)
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
   
   CALL apmm100_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmm100_fill_chk(ps_idx)
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
 
{<section id="apmm100.status_show" >}
PRIVATE FUNCTION apmm100_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmm100.mask_functions" >}
&include "erp/cpm/apmm100_mask.4gl"
 
{</section>}
 
{<section id="apmm100.signature" >}
   
 
{</section>}
 
{<section id="apmm100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmm100_set_pk_array()
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
   LET g_pk_array[1].values = g_pmaa_m.pmaa001
   LET g_pk_array[1].column = 'pmaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm100.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmm100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmm100_msgcentre_notify(lc_state)
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
   CALL apmm100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmm100.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmm100_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#25 add-S
   SELECT pmaastus  INTO g_pmaa_m.pmaastus
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_pmaa_m.pmaa001
   
   #IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN  #160818-00017#47
   IF g_action_choice="delete" THEN  #160818-00017#47
      LET g_errno = NULL
      CASE g_pmaa_m.pmaastus
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
         LET g_errparam.extend = g_pmaa_m.pmaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_errno = NULL
         CALL apmm100_set_act_visible()
         CALL apmm100_set_act_no_visible()
         CALL apmm100_show()
         RETURN FALSE
      END IF
   END IF 
   #160818-00017#47--S
   IF (g_action_choice="modify" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_pmaa_m.pmaastus
         WHEN 'W'
            LET g_errno = 'sub-00180'
         WHEN 'X'
            LET g_errno = 'sub-00229'
         WHEN 'S'
            LET g_errno = 'sub-00230'
      END CASE
    
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_pmaa_m.pmaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_errno = NULL
         CALL apmm100_set_act_visible()
         CALL apmm100_set_act_no_visible()
         CALL apmm100_show()
         RETURN FALSE
      END IF
   END IF
   #160818-00017#47--E  
   #160818-00017#25 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100.other_function" readonly="Y" >}
#################################################################################
#1.當傳入參數p_type = '1'(供應商維護作業)時
#  1-1."客戶資料"、"允許收款條件"、"客戶其它分類"等頁籤需隱藏不可以維護
#  1-2.畫面上是交易對象的名稱均改為供應商
#2.當傳入參數p_type = '2'(客戶維護作業)時，
#  2-1."供應商資料"、"允許付款條件"、"供應商其它分類"等頁籤需隱藏不可維護
#  2-2.畫面上是交易對象的名稱均改為客戶
#################################################################################
PRIVATE FUNCTION apmm100_set_visible()
DEFINE l_gzze003  LIKE gzze_t.gzze003
DEFINE l_ooef006  LIKE ooef_t.ooef006

    CALL cl_set_toolbaritem_visible("apmm100_03,apmm100_03_1",TRUE)
    #供應商
    IF g_argv[1] = '1' THEN
       CALL cl_set_comp_visible("page_3,page_7,bpage_1,bpage_5",FALSE)
       CALL apmm100_set_title_visible('1')
       CALL cl_set_toolbaritem_visible("apmm100_03",FALSE)
    END IF
    #客戶    
    IF g_argv[1] = '2' THEN
       CALL cl_set_comp_visible("page_4,page_8,bpage_2,bpage_6",FALSE)
       CALL apmm100_set_title_visible('2')
       CALL cl_set_toolbaritem_visible("apmm100_03_1",FALSE)
    END IF 

    #[T:營運據點資料檔].[C:專屬國家地區功能]為"台灣"畫面顯示"統一編號"
    LET l_ooef006 = ' '
    SELECT ooef006 INTO l_ooef006 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
    IF l_ooef006 = 'TW' OR l_ooef006 = 'tw' THEN
       LET l_gzze003 = ' '
       SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00084' AND gzze002 = g_dlang
       CALL cl_set_comp_att_text('pmaa003',l_gzze003)
    END IF
    
END FUNCTION
#+
PRIVATE FUNCTION apmm100_set_title_visible(p_pmaa002)
DEFINE p_pmaa002  LIKE pmaa_t.pmaa002
DEFINE l_gzze003  LIKE gzze_t.gzze003

       IF NOT cl_null(p_pmaa002) THEN
          #供應商
          IF p_pmaa002 = '1' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaa001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00051' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaa001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00077' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal003',l_gzze003)
             #add--2015/05/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00962' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal006',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal006',l_gzze003)
             #add--2015/05/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00078' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa003',l_gzze003)
          END IF
          #客戶 
          IF p_pmaa002 = '2' THEN
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa001',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaa001',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00053' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal004',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaa001_desc',l_gzze003)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00079' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal003',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal003',l_gzze003)
             #add--2015/05/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00963' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaal006',l_gzze003)
             CALL cl_set_comp_att_text('b_pmaal006',l_gzze003)
             #add--2015/05/25 By shiun--(S)
             LET l_gzze003 = ' '
             SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00080' AND gzze002 = g_dlang
             CALL cl_set_comp_att_text('pmaa003',l_gzze003)
          END IF
       END IF
       
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa005_ref(p_pmaa005)
DEFINE p_pmaa005      LIKE pmaa_t.pmaa005
DEFINE r_pmaa005_desc LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa005
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa005_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa005_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa006_ref(p_pmaa006)
DEFINE p_pmaa006      LIKE pmaa_t.pmaa006
DEFINE r_pmaa006_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa006
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='261' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa006_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa006_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa007_ref(p_pmaa007)
DEFINE p_pmaa007      LIKE pmaa_t.pmaa007
DEFINE r_pmaa007_desc LIKE oocgl_t.oocgl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa007
       CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa007_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa007_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa009_ref(p_pmaa009)
DEFINE p_pmaa009      LIKE pmaa_t.pmaa009
DEFINE r_pmaa009_desc LIKE ooall_t.ooall004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa009
       CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa009_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa009_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa011_chk(p_pmaa011)
DEFINE p_pmaa011      LIKE pmaa_t.pmaa011
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       
       #設定g_chkparam.*的參數
       LET g_chkparam.arg1 = g_site
       LET g_chkparam.arg2 = p_pmaa011
       #160318-00025#38  2016/04/20  by pengxin  add(S)
       LET g_errshow = TRUE #是否開窗 
       LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
       #160318-00025#38  2016/04/20  by pengxin  add(E)
       #呼叫檢查存在並帶值的library
       IF NOT cl_chk_exist("v_ooaj002") THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa023_ref(p_pmaa023)
DEFINE p_pmaa023      LIKE pmaa_t.pmaa023
DEFINE r_pmaa023_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa023
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='254' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa023_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa023_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa024_ref(p_pmaa024)
DEFINE p_pmaa024      LIKE pmaa_t.pmaa024
DEFINE r_pmaa024_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa024
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='260' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa024_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa024_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa026_ref(p_pmaa026)
DEFINE p_pmaa026      LIKE pmaa_t.pmaa026
DEFINE r_pmaa026_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa026
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='250' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa026_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa026_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa090_ref(p_pmaa090)
DEFINE p_pmaa090      LIKE pmaa_t.pmaa090
DEFINE r_pmaa090_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa090
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa090_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa090_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa091_ref(p_pmaa091)
DEFINE p_pmaa091      LIKE pmaa_t.pmaa091
DEFINE r_pmaa091_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa091
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='283' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa091_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa091_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa094_ref(p_pmaa094)
DEFINE p_pmaa094      LIKE pmaa_t.pmaa094
DEFINE r_pmaa094_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa094
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='286' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa094_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa094_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa093_ref(p_pmaa093)
DEFINE p_pmaa093      LIKE pmaa_t.pmaa093
DEFINE r_pmaa093_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa093
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='285' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa093_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa093_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa096_ref(p_pmaa096)
DEFINE p_pmaa096      LIKE pmaa_t.pmaa096
DEFINE r_pmaa096_desc LIKE oofa_t.oofa011
            
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa096
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmaa096_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa096_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa080_ref(p_pmaa080)
DEFINE p_pmaa080      LIKE pmaa_t.pmaa080
DEFINE r_pmaa080_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa080
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='251' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa080_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa080_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa081_ref(p_pmaa081)
DEFINE p_pmaa081      LIKE pmaa_t.pmaa081
DEFINE r_pmaa081_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa081
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='253' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa081_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa081_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa084_ref(p_pmaa084)
DEFINE p_pmaa084      LIKE pmaa_t.pmaa084
DEFINE r_pmaa084_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa084
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='256' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa084_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa084_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa083_ref(p_pmaa083)
DEFINE p_pmaa083      LIKE pmaa_t.pmaa083
DEFINE r_pmaa083_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa083
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='255' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa083_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa083_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa096_chk(p_pmaa096)
DEFINE p_pmaa096      LIKE pmaa_t.pmaa096
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT ap_chk_isExist(p_pmaa096,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? ","aoo-00074",1 ) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #IF NOT ap_chk_isExist(p_pmaa096,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","aoo-00071",1 ) THEN          #160318-00005#34
       IF NOT ap_chk_isExist(p_pmaa096,"SELECT COUNT(*) FROM ooag_t WHERE ooagent = '" ||g_enterprise||"' AND ooag001 = ? AND ooagstus = 'Y' ","sub-01302",'aooi130') THEN    #160318-00005#34
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa291_ref(p_pmaa291,p_oocq001)
DEFINE p_pmaa291      LIKE pmaa_t.pmaa291
DEFINE p_oocq001      LIKE oocq_t.oocq001
DEFINE r_pmaa291_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa291
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||p_oocq001||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa291_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa291_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa001_ref(p_pmaa001)
DEFINE p_pmaa001      LIKE pmaa_t.pmaa001
DEFINE r_pmaal003     LIKE pmaal_t.pmaal003
DEFINE r_pmaal004     LIKE pmaal_t.pmaal004
DEFINE r_pmaal005     LIKE pmaal_t.pmaal005
DEFINE r_pmaal006     LIKE pmaal_t.pmaal006  #add--2015/05/25 By shiun

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmaa001
      #modify--2015/05/25 By shiun--(S)
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003,pmaal004,pmaal005,pmaal006 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET r_pmaal003 = '', g_rtn_fields[1] , ''
      LET r_pmaal004 = '', g_rtn_fields[2] , ''
      LET r_pmaal005 = '', g_rtn_fields[3] , ''
      LET r_pmaal006 = '', g_rtn_fields[4] , ''
      RETURN r_pmaal003,r_pmaal004,r_pmaal005,r_pmaal006
      #modify--2015/05/25 By shiun--(E)
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmae002_ref(p_pmae002,p_oocq001)
DEFINE p_pmae002      LIKE pmae_t.pmae002
DEFINE p_oocq001      LIKE oocq_t.oocq001
DEFINE r_pmae002_desc LIKE oocql_t.oocql004
DEFINE r_oocq005      LIKE oocq_t.oocq005

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmae002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||p_oocq001||"' AND oocql002 = ? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
      LET r_pmae002_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_pmae002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocq005 FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001='"||p_oocq001||"' AND oocq002 = ? ","") RETURNING g_rtn_fields
      LET r_oocq005 = '', g_rtn_fields[1] , ''
      
      RETURN r_pmae002_desc,r_oocq005
      
END FUNCTION
#供應商標籤單身填充
PRIVATE FUNCTION apmm100_b2_fill()
   DEFINE p_wc2      STRING
   DEFINE l_cnt      LIKE type_t.num10  #add by lixiang 2015/10/26
   
   CALL g_pmae_d2.clear()  
   
   IF cl_null(g_wc3_table1) OR g_wc3_table1 = " 1=1" THEN
      LET g_wc3_table1 = " pmae003 = '1' "
   END IF
   
   LET g_sql = "SELECT  UNIQUE pmae002,'','' FROM pmae_t",    
               " WHERE pmaeent=? AND pmae001=? "
 
   IF NOT cl_null(g_wc3_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc3_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY pmae_t.pmae002"

   PREPARE apmm100_pb5 FROM g_sql
   DECLARE b_fill_cs5 CURSOR FOR apmm100_pb5
 
   #LET g_cnt = l_ac2  #mark by lixiang 2015/10/26
   LET l_cnt = l_ac2   #add by lixiang 2015/10/26
   LET l_ac2 = 1
 
   OPEN b_fill_cs5 USING g_enterprise,g_pmaa_m.pmaa001
                                          
   FOREACH b_fill_cs5 INTO g_pmae_d2[l_ac2].pmae002_1,g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL apmm100_pmae002_ref(g_pmae_d2[l_ac2].pmae002_1,'242') RETURNING g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
      DISPLAY BY NAME g_pmae_d2[l_ac2].oocql004_1,g_pmae_d2[l_ac2].oocq005_1
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_pmae_d2.deleteElement(g_pmae_d2.getLength())

   #LET l_ac2 = g_cnt  #mark by lixiang 2015/10/26
   #LET g_cnt = 0      #mark by lixiang 2015/10/26
   LET l_ac2 = l_cnt   #add by lixiang 2015/10/26
   LET l_cnt = 0       #add by lixiang 2015/10/26
   
   
   FREE apmm100_pb5

END FUNCTION
#+
PRIVATE FUNCTION apmm100_edsz()
DEFINE l_sql    STRING
DEFINE l_cnt    LIKE type_t.num5                 #20150420 POLLY ADD

      LET l_sql = "SELECT pmaa001,'','',pmaa002,'','',pmaa003,pmaastus,pmaa004,pmaa005,'',pmaa006,'',pmaa007,'',pmaa008,pmaa009,'',pmaa010,pmaa011,'',pmaa017,pmaa016,pmaa018,pmaa019,'',pmaa021,pmaa022,'',pmaa020,pmaa023,'',pmaa024,'',pmaa025,pmaa026,'',pmaa090,'',pmaa091,'',pmaa092,pmaa094,'',pmaa093,'',pmaa095,'',pmaa096,'',pmaa080,'',pmaa081,'',pmaa082,pmaa084,'',pmaa083,'',pmaa085,'',pmaa086,'',pmaa047,pmaa037,pmaa036,pmaa038,pmaa039,pmaa040,pmaa041,pmaa042,pmaa043,pmaa044,pmaa045,pmaa046,pmaa068,pmaa069,pmaa072,pmaa070,pmaa071,pmaa051,pmaa052,'',pmaa053,pmaa054,'',pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaa291,'',pmaa292,'',pmaa293,'',pmaa294,'',pmaa295,'',pmaa296,'',pmaa297,'',pmaa298,'',pmaa299,'',pmaa300,'',pmaa281,'',pmaa282,'',pmaa283,'',pmaa284,'',pmaa285,'',pmaa286,'',pmaa287,'',pmaa288,'',pmaa289,'',pmaa290,'','',pmaaownid,'',pmaaowndp,'',pmaacrtid,'',pmaacrtdp,'',pmaacrtdt,pmaamodid,'',pmaamoddt,pmaacnfid,'',pmaacnfdt FROM pmaa_t WHERE pmaaent= ? AND pmaa001=? FOR UPDATE"

      LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
      DECLARE apmm100_cl2 CURSOR FROM l_sql 
   
   
      CALL cl_set_comp_entry("pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067",TRUE)

      CALL s_transaction_begin()
      
      OPEN apmm100_cl2 USING g_enterprise,g_pmaa_m.pmaa001
   
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  STATUS
         LET g_errparam.extend = "OPEN apmm100_cl2:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE apmm100_cl2
         CALL s_transaction_end('N','0')
         RETURN
      END IF
    
      #鎖住將被更改或取消的資料
      FETCH apmm100_cl2 INTO g_pmaa_m.pmaa001,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaa002,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296,g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281,g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286,g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt
 
      #資料被他人LOCK, 或是sql執行時出現錯誤
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_pmaa_m.pmaa001
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CLOSE apmm100_cl2
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      LET g_pmaa_m.pmaamodid = g_user 
      LET g_pmaa_m.pmaamoddt = cl_get_current()
      
      DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaal004,g_pmaa_m.pmaal005,g_pmaa_m.pmaa002,g_pmaa_m.pmaal003,g_pmaa_m.pmaal006,g_pmaa_m.pmaa003,g_pmaa_m.pmaastus,g_pmaa_m.pmaa004,g_pmaa_m.pmaa005,g_pmaa_m.pmaa005_desc,g_pmaa_m.pmaa006,g_pmaa_m.pmaa006_desc,g_pmaa_m.pmaa007,g_pmaa_m.pmaa007_desc,g_pmaa_m.pmaa008,g_pmaa_m.pmaa009,g_pmaa_m.pmaa009_desc,g_pmaa_m.pmaa010,g_pmaa_m.pmaa011,g_pmaa_m.pmaa011_desc,g_pmaa_m.pmaa017,g_pmaa_m.pmaa016,g_pmaa_m.pmaa018,g_pmaa_m.pmaa019,g_pmaa_m.pmaa019_desc,g_pmaa_m.pmaa021,g_pmaa_m.pmaa022,g_pmaa_m.pmaa022_desc,g_pmaa_m.pmaa020,g_pmaa_m.pmaa023,g_pmaa_m.pmaa023_desc,g_pmaa_m.pmaa024,g_pmaa_m.pmaa024_desc,g_pmaa_m.pmaa025,g_pmaa_m.pmaa026,g_pmaa_m.pmaa026_desc,g_pmaa_m.pmaa090,g_pmaa_m.pmaa090_desc,g_pmaa_m.pmaa091,g_pmaa_m.pmaa091_desc,g_pmaa_m.pmaa092,g_pmaa_m.pmaa094,g_pmaa_m.pmaa094_desc,g_pmaa_m.pmaa093,g_pmaa_m.pmaa093_desc,g_pmaa_m.pmaa095,g_pmaa_m.pmaa095_desc,g_pmaa_m.pmaa096,g_pmaa_m.pmaa096_desc,g_pmaa_m.pmaa080,g_pmaa_m.pmaa080_desc,g_pmaa_m.pmaa081,g_pmaa_m.pmaa081_desc,g_pmaa_m.pmaa082,g_pmaa_m.pmaa084,g_pmaa_m.pmaa084_desc,g_pmaa_m.pmaa083,g_pmaa_m.pmaa083_desc,g_pmaa_m.pmaa085,g_pmaa_m.pmaa085_desc,g_pmaa_m.pmaa086,g_pmaa_m.pmaa086_desc,g_pmaa_m.pmaa047,g_pmaa_m.pmaa037,g_pmaa_m.pmaa036,g_pmaa_m.pmaa038,g_pmaa_m.pmaa039,g_pmaa_m.pmaa040,g_pmaa_m.pmaa041,g_pmaa_m.pmaa042,g_pmaa_m.pmaa043,g_pmaa_m.pmaa044,g_pmaa_m.pmaa045,g_pmaa_m.pmaa046,g_pmaa_m.pmaa068,g_pmaa_m.pmaa069,g_pmaa_m.pmaa072,g_pmaa_m.pmaa070,g_pmaa_m.pmaa071,g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa291,g_pmaa_m.pmaa291_desc,g_pmaa_m.pmaa292,g_pmaa_m.pmaa292_desc,g_pmaa_m.pmaa293,g_pmaa_m.pmaa293_desc,g_pmaa_m.pmaa294,g_pmaa_m.pmaa294_desc,g_pmaa_m.pmaa295,g_pmaa_m.pmaa295_desc,g_pmaa_m.pmaa296,g_pmaa_m.pmaa296_desc,g_pmaa_m.pmaa297,g_pmaa_m.pmaa297_desc,g_pmaa_m.pmaa298,g_pmaa_m.pmaa298_desc,g_pmaa_m.pmaa299,g_pmaa_m.pmaa299_desc,g_pmaa_m.pmaa300,g_pmaa_m.pmaa300_desc,g_pmaa_m.pmaa281,g_pmaa_m.pmaa281_desc,g_pmaa_m.pmaa282,g_pmaa_m.pmaa282_desc,g_pmaa_m.pmaa283,g_pmaa_m.pmaa283_desc,g_pmaa_m.pmaa284,g_pmaa_m.pmaa284_desc,g_pmaa_m.pmaa285,g_pmaa_m.pmaa285_desc,g_pmaa_m.pmaa286,g_pmaa_m.pmaa286_desc,g_pmaa_m.pmaa287,g_pmaa_m.pmaa287_desc,g_pmaa_m.pmaa288,g_pmaa_m.pmaa288_desc,g_pmaa_m.pmaa289,g_pmaa_m.pmaa289_desc,g_pmaa_m.pmaa290,g_pmaa_m.pmaa290_desc,g_pmaa_m.ooff013,g_pmaa_m.pmaaownid,g_pmaa_m.pmaaownid_desc,g_pmaa_m.pmaaowndp,g_pmaa_m.pmaaowndp_desc,g_pmaa_m.pmaacrtid,g_pmaa_m.pmaacrtid_desc,g_pmaa_m.pmaacrtdp,g_pmaa_m.pmaacrtdp_desc,g_pmaa_m.pmaacrtdt,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamodid_desc,g_pmaa_m.pmaamoddt,g_pmaa_m.pmaacnfid,g_pmaa_m.pmaacnfid_desc,g_pmaa_m.pmaacnfdt

      INPUT BY NAME g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,
              g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,
              g_pmaa_m.pmaa066,g_pmaa_m.pmaa067
         WITHOUT DEFAULTS
         #150930-00021#3 20151005 add by beckxie---S
         BEFORE INPUT
            IF g_pmaa_m.pmaa052 <> g_pmaa_m.pmaa001 THEN
               CALL cl_set_comp_entry("pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075",FALSE)
            ELSE
               CALL cl_set_comp_entry("pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075",TRUE)
            END IF
            LET g_pmaa_m_o.* = g_pmaa_m.*
            LET g_pmaa_m_t.* = g_pmaa_m.*
         #150930-00021#3 20151005 add by beckxie---E
         AFTER FIELD pmaa051 
            #CALL apmm100_set_entry('u')
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            #CALL apmm100_set_no_entry('u')      
            
         ON CHANGE pmaa051
            #CALL apmm100_set_entry('u')
            CALL apmm100_set_required()
            CALL apmm100_set_no_required()        
            #CALL apmm100_set_no_entry('u')        {#ADP版次:1#}

         #此段落由子樣板a02產生
         AFTER FIELD pmaa052
            LET g_pmaa_m.pmaa052_desc = '' 
            IF NOT cl_null(g_pmaa_m.pmaa052) THEN
               IF g_pmaa_m.pmaa052 != g_pmaa_m_o.pmaa052 OR cl_null(g_pmaa_m_o.pmaa052) THEN 
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",1 ) THEN
                     LET g_pmaa_m.pmaa052 = g_pmaa_m_o.pmaa052
                     CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",1 ) THEN        #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmaa_m.pmaa052,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN #160318-00005#34
                     LET g_pmaa_m.pmaa052 = g_pmaa_m_o.pmaa052
                     CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa052,g_pmaa_m.pmaa052_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150930-00021#3 20151005 add by beckxie---S
                  IF g_pmaa_m.pmaa052 <> g_pmaa_m.pmaa001 THEN
                     CALL cl_set_comp_entry("pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075",TRUE)
                  END IF
                  #150930-00021#3 20151005 add by beckxie---E
               END IF
            END IF
            LET g_pmaa_m_o.pmaa052 = g_pmaa_m.pmaa052
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            DISPLAY BY NAME g_pmaa_m.pmaa052_desc
            
         AFTER FIELD pmaa053
            LET g_pmaa_m.pmaa053_desc = ''
            IF NOT cl_null(g_pmaa_m.pmaa053) THEN 
               IF g_pmaa_m.pmaa053 != g_pmaa_m_o.pmaa053 OR cl_null(g_pmaa_m_o.pmaa053) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmaa_m.pmaa053
                  #呼叫檢查存在並帶值的library
                  #ming 20140817 modify ---------------------------------------(S) 
                  #IF cl_chk_exist("v_xmaa001") THEN
                  #企鵝：信用評等欄位的開窗與校驗改取xmaj_t 
                  IF cl_chk_exist("v_xmaj001") THEN
                  #ming 20140817 modify ---------------------------------------(E) 
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmaa_m.pmaa053 = g_pmaa_m_o.pmaa053
                     #ming 20140817 modify -------------------------------------------------------(S) 
                     #CALL s_desc_get_acc_desc('296',g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
                     #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
                     CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
                     #ming 20140817 modify -------------------------------------------------------(E) 
                     DISPLAY BY NAME g_pmaa_m.pmaa053,g_pmaa_m.pmaa053_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmaa_m_o.pmaa053 = g_pmaa_m.pmaa053
            #ming 20140817 add -------------------------------------------------(S) 
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            DISPLAY BY NAME g_pmaa_m.pmaa053_desc
            #ming 20140817 add -------------------------------------------------(E) 

         AFTER FIELD pmaa054
            LET g_pmaa_m.pmaa054_desc = ''
            IF NOT cl_null(g_pmaa_m.pmaa054) THEN  
               IF g_pmaa_m.pmaa054 != g_pmaa_m_o.pmaa054 OR cl_null(g_pmaa_m_o.pmaa054) THEN 
                  IF NOT apmm100_pmaa011_chk(g_pmaa_m.pmaa054) THEN
                     LET g_pmaa_m.pmaa054 = g_pmaa_m_o.pmaa054
                     CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
                     DISPLAY BY NAME g_pmaa_m.pmaa054,g_pmaa_m.pmaa054_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa054 = g_pmaa_m.pmaa054
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            
         AFTER FIELD pmaa055
            IF NOT cl_null(g_pmaa_m.pmaa055) THEN  
               IF g_pmaa_m.pmaa055 != g_pmaa_m_o.pmaa055 OR cl_null(g_pmaa_m_o.pmaa055) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa055,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa055 = g_pmaa_m_o.pmaa055
                     DISPLAY BY NAME g_pmaa_m.pmaa055
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa055 = g_pmaa_m.pmaa055

         AFTER FIELD pmaa056
            IF NOT cl_null(g_pmaa_m.pmaa056) THEN  
               IF g_pmaa_m.pmaa056 != g_pmaa_m_o.pmaa056 OR cl_null(g_pmaa_m_o.pmaa056) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa056,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa056 = g_pmaa_m_o.pmaa056
                     DISPLAY BY NAME g_pmaa_m.pmaa056
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa056 = g_pmaa_m.pmaa056

         AFTER FIELD pmaa058
            IF NOT cl_null(g_pmaa_m.pmaa058) THEN  
               IF g_pmaa_m.pmaa058 != g_pmaa_m_o.pmaa058 OR cl_null(g_pmaa_m_o.pmaa058) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa058,"0","1","","","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa058 = g_pmaa_m_o.pmaa058
                     DISPLAY BY NAME g_pmaa_m.pmaa058
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa058 = g_pmaa_m.pmaa058
         
         AFTER FIELD pmaa074
            IF NOT cl_null(g_pmaa_m.pmaa074) THEN  
               IF g_pmaa_m.pmaa074 != g_pmaa_m_o.pmaa074 OR cl_null(g_pmaa_m_o.pmaa074) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa074,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa074 = g_pmaa_m_o.pmaa074
                     DISPLAY BY NAME g_pmaa_m.pmaa074
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa074 = g_pmaa_m.pmaa074
            
         AFTER FIELD pmaa059
            IF NOT cl_null(g_pmaa_m.pmaa059) THEN  
               IF g_pmaa_m.pmaa059 != g_pmaa_m_o.pmaa059 OR cl_null(g_pmaa_m_o.pmaa059) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa059,"0.000","1","","","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa059 = g_pmaa_m_o.pmaa059
                     DISPLAY BY NAME g_pmaa_m.pmaa059
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa059 = g_pmaa_m.pmaa059

         AFTER FIELD pmaa060
            IF NOT cl_null(g_pmaa_m.pmaa060) THEN  
               IF g_pmaa_m.pmaa060 != g_pmaa_m_o.pmaa060 OR cl_null(g_pmaa_m_o.pmaa060) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa060,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa060 = g_pmaa_m_o.pmaa060
                     DISPLAY BY NAME g_pmaa_m.pmaa060
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa060 = g_pmaa_m.pmaa060

         AFTER FIELD pmaa062
            IF NOT cl_null(g_pmaa_m.pmaa062) THEN  
               IF g_pmaa_m.pmaa062 != g_pmaa_m_o.pmaa062 OR cl_null(g_pmaa_m_o.pmaa062) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa062,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa062 = g_pmaa_m_o.pmaa062
                     DISPLAY BY NAME g_pmaa_m.pmaa062
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa062 = g_pmaa_m.pmaa062

         AFTER FIELD pmaa064
            IF NOT cl_null(g_pmaa_m.pmaa064) THEN  
               IF g_pmaa_m.pmaa064 != g_pmaa_m_o.pmaa064 OR cl_null(g_pmaa_m_o.pmaa064) THEN 
                  IF NOT cl_ap_chk_range(g_pmaa_m.pmaa064,"0.000","1","100.000","1","azz-00079",1) THEN
                     LET g_pmaa_m.pmaa064 = g_pmaa_m_o.pmaa064
                     DISPLAY BY NAME g_pmaa_m.pmaa064
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            LET g_pmaa_m_o.pmaa064 = g_pmaa_m.pmaa064

         ON ACTION controlp INFIELD pmaa052
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmaa_m.pmaa052             #給予default值
            CALL q_pmaa001_4()                                #呼叫開窗
            LET g_pmaa_m.pmaa052 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmaa_m.pmaa052 TO pmaa052              #顯示到畫面上
            CALL apmm100_pmaa005_ref(g_pmaa_m.pmaa052) RETURNING g_pmaa_m.pmaa052_desc
            DISPLAY BY NAME g_pmaa_m.pmaa052_desc
            NEXT FIELD pmaa052                          #返回原欄位

         ON ACTION controlp INFIELD pmaa053
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmaa_m.pmaa053             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            #ming 140817 modify -------------------------------------------------------(S) 
            #CALL q_xmaa001()                                #呼叫開窗
            #企鵝：信用評等欄位的開窗與校驗改取xmaj_t 
            CALL q_xmaj001()                                #呼叫開窗
            #ming 140817 modify -------------------------------------------------------(E) 
            LET g_pmaa_m.pmaa053 = g_qryparam.return1              
            DISPLAY g_pmaa_m.pmaa053 TO pmaa053              #
            #ming 20140817 modify ----------------------------------------------------------(S) 
            #CALL s_desc_get_acc_desc('296',g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #信用評等的開窗與校驗從xmaa_t改成xmaj_t 多語言的部分改取xmajl_t  
            CALL apmm100_pmaa053_ref(g_pmaa_m.pmaa053) RETURNING g_pmaa_m.pmaa053_desc
            #ming 20140817 modify ----------------------------------------------------------(E) 
            DISPLAY BY NAME g_pmaa_m.pmaa053_desc
            NEXT FIELD pmaa053                          #返回原欄位

         ON ACTION controlp INFIELD pmaa054
            INITIALIZE g_qryparam.* TO NULL #160509-00018#1
            LET g_qryparam.state = 'i'   #160524-00014#1
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmaa_m.pmaa054             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                            #呼叫開窗
            LET g_pmaa_m.pmaa054 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmaa_m.pmaa054 TO pmaa054              #顯示到畫面上
            CALL apmm100_pmaa011_ref(g_pmaa_m.pmaa054) RETURNING g_pmaa_m.pmaa054_desc
            DISPLAY BY NAME g_pmaa_m.pmaa054_desc
            NEXT FIELD pmaa054                          #返回原欄位
       
       
         AFTER INPUT
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               EXIT INPUT
            END IF
            
            UPDATE pmaa_t SET (pmaa051,pmaa052,pmaa053,pmaa054,pmaa055,pmaa056,pmaa057,pmaa058,pmaa074,pmaa059,pmaa075,pmaa060,pmaa061,pmaa062,pmaa063,pmaa064,pmaa065,pmaa066,pmaa067,pmaamodid,pmaamoddt) = (g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa074,g_pmaa_m.pmaa059,g_pmaa_m.pmaa075,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt)
                WHERE pmaaent = g_enterprise AND pmaa001 = g_pmaa_m.pmaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_pmaa_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  CALL s_transaction_end('N','0')
               ELSE
                 #--20150420--POLLY--ADD--(S)
                 #需一併更新據點級ALL的資料
                 LET l_cnt = 0
                 SELECT COUNT(*) INTO l_cnt
                   FROM pmab_t
                   WHERE pmabent = g_enterprise 
                     AND pmabsite = 'ALL'
                     AND pmab001 = g_pmaa_m.pmaa001  
                 IF l_cnt > 0 THEN   
                    UPDATE pmab_t SET (pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab010,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmab019,pmab020,pmabmodid,pmabmoddt) 
                                    = (g_pmaa_m.pmaa051,g_pmaa_m.pmaa052,g_pmaa_m.pmaa053,g_pmaa_m.pmaa054,g_pmaa_m.pmaa055,g_pmaa_m.pmaa056,g_pmaa_m.pmaa057,g_pmaa_m.pmaa058,g_pmaa_m.pmaa059,g_pmaa_m.pmaa060,g_pmaa_m.pmaa061,g_pmaa_m.pmaa062,g_pmaa_m.pmaa063,g_pmaa_m.pmaa064,g_pmaa_m.pmaa065,g_pmaa_m.pmaa066,g_pmaa_m.pmaa067,g_pmaa_m.pmaa074,g_pmaa_m.pmaa075,g_pmaa_m.pmaamodid,g_pmaa_m.pmaamoddt)
                     WHERE pmabent = g_enterprise 
                       AND pmabsite = 'ALL'
                       AND pmab001 = g_pmaa_m.pmaa001                   
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = "g_pmaa_m"
                       LET g_errparam.popup = TRUE
                       CALL cl_err()  
                       CALL s_transaction_end('N','0')
                    ELSE 
                       #--150925--polly--add--(s)
                       #需依aooi090設定帶回據點(site)  
                       IF NOT s_aooi090_upd_fields('4',g_pmaa_m.pmaa001) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'sub-00034'
                          LET g_errparam.extend = g_pmaa_m.pmaa001
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          CALL s_transaction_end('N','0')
                       ELSE
                          CALL s_transaction_end('Y','0')
                       #--150925--polly--add--(e)
                          #150930-00021#3 20151005 add by beckxie---S
                          IF (g_pmaa_m.pmaa052 != g_pmaa_m_t.pmaa052 OR g_pmaa_m.pmaa054 != g_pmaa_m_t.pmaa054) THEN
                             CALL cl_ask_confirm3('axm-00728',"") 
                             IF g_pmaa_m.pmaa052 != g_pmaa_m_t.pmaa052 THEN          #異動額度客戶
                                CALL s_apmm100_call_axmp140_bg(g_pmaa_m_t.pmaa052)   #變更前的額度客戶
                                CALL s_apmm100_call_axmp140_bg(g_pmaa_m.pmaa052)     #變更後的額度客戶
                             ELSE
                                CALL s_apmm100_call_axmp140_bg(g_pmaa_m.pmaa052) 
                             END IF
                             CALL cl_ask_confirm3("axm-00729","")
                          END IF
                          #150930-00021#3 20151005 add by beckxie---E
                       END IF   
                    END IF
                 ELSE
                    CALL s_transaction_end('Y','0')                 
                 END IF   
                 #--20150420--POLLY--ADD--(E)
               END IF
      END INPUT
      LET INT_FLAG = FALSE
      CLOSE apmm100_cl2
      
END FUNCTION
#+
PRIVATE FUNCTION apmm100_pmaa011_ref(p_pmaa011)
DEFINE p_pmaa011      LIKE pmaa_t.pmaa011
DEFINE r_pmaa011_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmaa011
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaa011_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmaa011_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmm100_set_no_required()
   IF g_pmaa_m.pmaa004 <> '3' THEN
      CALL cl_set_comp_required("pmaa005",FALSE)
   END IF
   
   IF g_pmaa_m.pmaa051 NOT MATCHES '[23]' THEN
      CALL cl_set_comp_required("pmaa053,pmaa054,pmaa055",FALSE)
   END IF
END FUNCTION
#+
PRIVATE FUNCTION apmm100_set_required()
   IF g_pmaa_m.pmaa004 = '3' THEN
      CALL cl_set_comp_required("pmaa005",TRUE)
   END IF  
     
   IF g_pmaa_m.pmaa051 MATCHES '[23]' THEN
      CALL cl_set_comp_required("pmaa053,pmaa054,pmaa055",TRUE)
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 複製聯絡地址
# Memo...........:
# Usage..........: CALL apmm100_insert_oofb(p_oofb002_f,p_oofb002_t)
#                  RETURNING r_success 
# Input parameter: p_oofb002_f  來源聯絡對象識別碼
#                  p_oofb002_t  目的聯絡對象識別碼
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION apmm100_insert_oofb(p_oofb002_f,p_oofb002_t)
DEFINE p_oofb002_f    LIKE oofb_t.oofb002    #來源联络对象识别码
DEFINE p_oofb002_t    LIKE oofb_t.oofb002    #目的聯絡對象識別碼
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
DEFINE l_date         LIKE oofb_t.oofb018    #当日
#161124-00048#8  mod-S
#DEFINE l_oofb         RECORD LIKE oofb_t.*
DEFINE l_oofb RECORD  #聯絡地址檔
       oofbstus LIKE oofb_t.oofbstus, #状态码
       oofbent LIKE oofb_t.oofbent, #企业编号
       oofb001 LIKE oofb_t.oofb001, #联络地址识别码
       oofb002 LIKE oofb_t.oofb002, #联络对象识别码
       oofb003 LIKE oofb_t.oofb003, #联络对象编号一
       oofb004 LIKE oofb_t.oofb004, #联络对象编号二
       oofb005 LIKE oofb_t.oofb005, #联络对象编号三
       oofb006 LIKE oofb_t.oofb006, #联络对象编号四
       oofb007 LIKE oofb_t.oofb007, #联络对象编号五
       oofb008 LIKE oofb_t.oofb008, #地址类型
       oofb009 LIKE oofb_t.oofb009, #地址应用分类
       oofb010 LIKE oofb_t.oofb010, #主要联络地址
       oofb011 LIKE oofb_t.oofb011, #简要说明
       oofb012 LIKE oofb_t.oofb012, #国家/地区
       oofb013 LIKE oofb_t.oofb013, #邮政编号
       oofb014 LIKE oofb_t.oofb014, #州/省/直辖市
       oofb015 LIKE oofb_t.oofb015, #县/市
       oofb016 LIKE oofb_t.oofb016, #行政区域
       oofb017 LIKE oofb_t.oofb017, #地址
       oofb018 LIKE oofb_t.oofb018, #失效日期
       oofbownid LIKE oofb_t.oofbownid, #资料所有者
       oofbowndp LIKE oofb_t.oofbowndp, #资料所有部门
       oofbcrtid LIKE oofb_t.oofbcrtid, #资料录入者
       oofbcrtdp LIKE oofb_t.oofbcrtdp, #资料录入部门
       oofbcrtdt LIKE oofb_t.oofbcrtdt, #资料创建日
       oofbmodid LIKE oofb_t.oofbmodid, #资料更改者
       oofbmoddt LIKE oofb_t.oofbmoddt, #最近更改日
       oofb019 LIKE oofb_t.oofb019, #简要编号
       oofb020 LIKE oofb_t.oofb020, #经度
       oofb021 LIKE oofb_t.oofb021, #维度
       oofb022 LIKE oofb_t.oofb022, #收货站点
       oofb023 LIKE oofb_t.oofb023  #联络对象类型
END RECORD
#161124-00048#8  mod-E
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数
DEFINE l_success      LIKE type_t.num5
DEFINE l_wc           STRING

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #当日
   LET l_date = cl_get_current()

   #将来源联络对象识别码的联络地址取出
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM oofb_t  ",
   LET l_sql = "SELECT oofbstus,oofbent,oofb001,oofb002,oofb003,",
               "       oofb004,oofb005,oofb006,oofb007,oofb008,",
               "       oofb009,oofb010,oofb011,oofb012,oofb013,",
               "       oofb014,oofb015,oofb016,oofb017,oofb018,",
               "       oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,",
               "       oofbmodid,oofbmoddt,oofb019,oofb020,oofb021,",
               "       oofb022,oofb023 ",
               "FROM oofb_t  ",
   #161124-00048#8  mod-E
               " WHERE oofb002='",p_oofb002_f,"' ",
               "   AND oofbent=",g_enterprise,
               "   AND (oofb018 is null or oofb018 >'",l_date,"') "  #失效日期                                  
               #"   AND oofbstus='Y' "                                    #状态码        
   PREPARE apmm100_ins_oofb_p FROM l_sql
   DECLARE apmm100_ins_oofb_c CURSOR FOR apmm100_ins_oofb_p
   FOREACH apmm100_ins_oofb_c INTO l_oofb.*
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       LET l_oofb.oofbmodid= ''         #资料修改者
       LET l_oofb.oofbmoddt= ''         #最近修改日
       LET l_oofb.oofbownid= g_user     #资料所有者
       LET l_oofb.oofbowndp= g_dept     #资料所有部门
       LET l_oofb.oofbcrtid= g_user     #资料建立者
       LET l_oofb.oofbcrtdp= g_dept     #资料建立部门
       LET l_oofb.oofbcrtdt= cl_get_current()    #资料创建日
       #LET l_oofb.oofbstus = 'Y'        #资料状态码
       LET l_oofb.oofb018 = ''          #失效日期
       LET l_oofb.oofb002 = p_oofb002_t #联络对象识别码  

       #产生联络地址识别码
       LET l_wc = " oofbent = ",g_enterprise
       CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
          RETURNING l_success,l_oofb.oofb001
       IF NOT l_success THEN
          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF

       #插入联络地址识别档
       #161124-00048#8  mod-S
#       INSERT INTO oofb_t VALUES (l_oofb.*)
       INSERT INTO oofb_t 
                   (oofbstus,oofbent,oofb001,oofb002,oofb003,
                    oofb004,oofb005,oofb006,oofb007,oofb008,
                    oofb009,oofb010,oofb011,oofb012,oofb013,
                    oofb014,oofb015,oofb016,oofb017,oofb018,
                    oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,
                    oofbmodid,oofbmoddt,oofb019,oofb020,oofb021,
                    oofb022,oofb023)
            VALUES (l_oofb.*)
       #161124-00048#8  mod-E
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 複製通訊方式
# Memo...........:
# Usage..........: CALL apmm100_insert_oofc(p_oofc002_f,p_oofc002_t)
#                  RETURNING r_success 
# Input parameter: p_oofc002_f  來源聯絡對象識別碼
#                  p_oofc002_t  目的聯絡對象識別碼
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION apmm100_insert_oofc(p_oofc002_f,p_oofc002_t)
DEFINE p_oofc002_f    LIKE oofc_t.oofc002    #來源联络对象识别码
DEFINE p_oofc002_t    LIKE oofc_t.oofc002    #目的联络对象识别码
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
DEFINE l_date         LIKE oofc_t.oofc013    #当日
#161124-00048#8  mod-S
#DEFINE l_oofc         RECORD LIKE oofc_t.*
DEFINE l_oofc RECORD  #通訊方式檔
       oofcstus LIKE oofc_t.oofcstus, #状态码
       oofcent LIKE oofc_t.oofcent, #企业编号
       oofc001 LIKE oofc_t.oofc001, #通信方式识别码
       oofc002 LIKE oofc_t.oofc002, #联络对象识别码
       oofc003 LIKE oofc_t.oofc003, #联络对象编号一
       oofc004 LIKE oofc_t.oofc004, #联络对象编号二
       oofc005 LIKE oofc_t.oofc005, #联络对象编号三
       oofc006 LIKE oofc_t.oofc006, #联络对象编号四
       oofc007 LIKE oofc_t.oofc007, #联络对象编号五
       oofc008 LIKE oofc_t.oofc008, #通信类型
       oofc009 LIKE oofc_t.oofc009, #通信应用分类
       oofc010 LIKE oofc_t.oofc010, #主要通信方式
       oofc011 LIKE oofc_t.oofc011, #简要说明
       oofc012 LIKE oofc_t.oofc012, #通信内容
       oofc013 LIKE oofc_t.oofc013, #失效日期
       oofcownid LIKE oofc_t.oofcownid, #资料所有者
       oofcowndp LIKE oofc_t.oofcowndp, #资料所有部门
       oofccrtid LIKE oofc_t.oofccrtid, #资料录入者
       oofccrtdp LIKE oofc_t.oofccrtdp, #资料录入部门
       oofccrtdt LIKE oofc_t.oofccrtdt, #资料创建日
       oofcmodid LIKE oofc_t.oofcmodid, #资料更改者
       oofcmoddt LIKE oofc_t.oofcmoddt, #最近更改日
       oofc014 LIKE oofc_t.oofc014, #简要编号
       oofc015 LIKE oofc_t.oofc015, #寄发邮件
       oofc016 LIKE oofc_t.oofc016  #联络对象类型
END RECORD
#161124-00048#8  mod-E
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数
DEFINE l_success      LIKE type_t.num5
DEFINE l_wc           STRING

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #将来源联络对象识别码的通訊方式取出
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM oofc_t  ",
   LET l_sql = "SELECT oofcstus,oofcent,oofc001,oofc002,oofc003,",
               "       oofc004,oofc005,oofc006,oofc007,oofc008,",
               "       oofc009,oofc010,oofc011,oofc012,oofc013,",
               "       oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,",
               "       oofcmodid,oofcmoddt,oofc014,oofc015,oofc016 ",
               "FROM oofc_t  ",
   #161124-00048#8  mod-E
               " WHERE oofc002='",p_oofc002_f,"' ",
               "   AND oofcent=",g_enterprise,
               "   AND (oofc013 is null or oofc013 >'",l_date,"') "    #失效日期                                  
               #"   AND oofcstus='Y' "                                    #状态码        
   PREPARE apmm100_insert_oofc_p FROM l_sql
   DECLARE apmm100_insert_oofc_c CURSOR FOR apmm100_insert_oofc_p
   FOREACH apmm100_insert_oofc_c INTO l_oofc.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       LET l_oofc.oofcmodid= ''         #资料修改者
       LET l_oofc.oofcmoddt= ''         #最近修改日
       LET l_oofc.oofcownid= g_user     #资料所有者
       LET l_oofc.oofcowndp= g_dept     #资料所有部门
       LET l_oofc.oofccrtid= g_user     #资料建立者
       LET l_oofc.oofccrtdp= g_dept     #资料建立部门
       LET l_oofc.oofccrtdt= cl_get_current()    #资料创建日
       #LET l_oofc.oofcstus = 'Y'        #资料状态码
       LET l_oofc.oofc013 = ''          #失效日期
       LET l_oofc.oofc002 = p_oofc002_t   #联络对象识别码  

       #产生通訊方式识别码 
       LET l_wc = " oofcent = ",g_enterprise
       CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
          RETURNING l_success,l_oofc.oofc001
       IF NOT l_success THEN
          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF

       #插入通訊方式识别档
       #161124-00048#8  mod-S
#       INSERT INTO oofc_t VALUES (l_oofc.*)
       INSERT INTO oofc_t 
                   (oofcstus,oofcent,oofc001,oofc002,oofc003,
                    oofc004,oofc005,oofc006,oofc007,oofc008,
                    oofc009,oofc010,oofc011,oofc012,oofc013,
                    oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,
                    oofcmodid,oofcmoddt,oofc014,oofc015,oofc016)
            VALUES (l_oofc.*)
       #161124-00048#8  mod-E
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 複製交易對象交易夥伴檔
# Memo...........:
# Usage..........: CALL apmm100_insert_pmac(p_pmac001_f,p_pmac001_t)
#                  RETURNING r_success 
# Input parameter: p_pmac001_f  來源交易對象編號
#                  p_pmac001_t  目的交易對象編號
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION apmm100_insert_pmac(p_pmac001_f,p_pmac001_t)
DEFINE p_pmac001_f    LIKE pmac_t.pmac001    #来源交易對象編號
DEFINE p_pmac001_t    LIKE pmac_t.pmac001    #目的交易對象編號
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
#161124-00048#8  mod-S
#DEFINE l_pmac         RECORD LIKE pmac_t.*
DEFINE l_pmac RECORD  #交易對象交易夥伴檔
       pmacent LIKE pmac_t.pmacent, #企业编号
       pmac001 LIKE pmac_t.pmac001, #交易对象编号
       pmac002 LIKE pmac_t.pmac002, #交易伙伴编号
       pmac003 LIKE pmac_t.pmac003, #交易类型
       pmac004 LIKE pmac_t.pmac004, #主要否
       pmacstus LIKE pmac_t.pmacstus #状态码
END RECORD
#161124-00048#8  mod-E
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #将来源交易對象的交易夥伴檔取出
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM pmac_t  ",
   LET l_sql = "SELECT pmacent,pmac001,pmac002,pmac003,pmac004,pmacstus ",
               "FROM pmac_t  ",
   #161124-00048#8  mod-E
               " WHERE pmac001='",p_pmac001_f,"' ",
               "   AND pmacent='",g_enterprise,"' "                                  
               #"   AND pmacstus='Y' "                                    #状态码        
   PREPARE apmm100_insert_pmac_p FROM l_sql
   DECLARE apmm100_insert_pmac_c CURSOR FOR apmm100_insert_pmac_p
   FOREACH apmm100_insert_pmac_c INTO l_pmac.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       #LET l_pmac.pmacstus = 'Y'        #资料状态码
       LET l_pmac.pmac001 = p_pmac001_t #目的交易對象編號  

       #插入交易對象交易夥伴檔
       #161124-00048#8  mod-S
#       INSERT INTO pmac_t VALUES (l_pmac.*)
       INSERT INTO pmac_t 
                   (pmacent,pmac001,pmac002,pmac003,pmac004,pmacstus)
            VALUES (l_pmac.*)
       #161124-00048#8  mod-E
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmac_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 複製交易對象允許收/付款條件檔
# Memo...........:
# Usage..........: CALL apmm100_insert_pmad(p_pmad001_f,p_pmad001_t)
#                  RETURNING r_success 
# Input parameter: p_pmad001_f  來源交易對象編號
#                  p_pmad001_t  目的交易對象編號
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION apmm100_insert_pmad(p_pmad001_f,p_pmad001_t)
DEFINE p_pmad001_f    LIKE pmad_t.pmad001    #来源交易對象編號
DEFINE p_pmad001_t    LIKE pmad_t.pmad001    #目的交易對象編號
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
#161124-00048#8  mod-S
#DEFINE l_pmad         RECORD LIKE pmad_t.*
DEFINE l_pmad RECORD  #交易對象允許收/付款條件檔
       pmadent LIKE pmad_t.pmadent, #企业编号
       pmad001 LIKE pmad_t.pmad001, #交易对象编号
       pmad002 LIKE pmad_t.pmad002, #交易条件编号
       pmad003 LIKE pmad_t.pmad003, #交易类型
       pmad004 LIKE pmad_t.pmad004, #主要否
       pmadstus LIKE pmad_t.pmadstus  #状态码
END RECORD
#161124-00048#8  mod-E
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #将来源交易對象的允許收/付款條件檔取出
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM pmad_t  ",
   LET l_sql = "SELECT pmadent,pmad001,pmad002,pmad003,pmad004,pmadstus ",
               "FROM pmad_t  ",
   #161124-00048#8  mod-E
               " WHERE pmad001='",p_pmad001_f,"' ",
               "   AND pmadent='",g_enterprise,"' "                                  
               #"   AND pmadstus='Y' "                                    #状态码        
   PREPARE apmm100_insert_pmad_p FROM l_sql
   DECLARE apmm100_insert_pmad_c CURSOR FOR apmm100_insert_pmad_p
   FOREACH apmm100_insert_pmad_c INTO l_pmad.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       #LET l_pmad.pmadstus = 'Y'        #资料状态码
       LET l_pmad.pmad001 = p_pmad001_t #目的交易對象編號  

       #插入交易對象交易夥伴檔
        #161124-00048#8  mod-S
#       INSERT INTO pmad_t VALUES (l_pmad.*)
       INSERT INTO pmad_t 
                   (pmadent,pmad001,pmad002,pmad003,pmad004,pmadstus)
            VALUES (l_pmad.*)
        #161124-00048#8  mod-E
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmad_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 複製交易對象往來銀行檔
# Memo...........:
# Usage..........: CALL apmm100_insert_pmaf(p_pmaf001_f,p_pmaf001_t)
#                  RETURNING r_success 
# Input parameter: p_pmaf001_f  來源交易對象編號
#                  p_pmaf001_t  目的交易對象編號
# Return code....: r_success  TRUE/FALSE
################################################################################
PRIVATE FUNCTION apmm100_insert_pmaf(p_pmaf001_f,p_pmaf001_t)
DEFINE p_pmaf001_f    LIKE pmaf_t.pmaf001    #来源交易對象編號
DEFINE p_pmaf001_t    LIKE pmaf_t.pmaf001    #目的交易對象編號
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
#161124-00048#8  mod-S
#DEFINE l_pmaf         RECORD LIKE pmaf_t.*
DEFINE l_pmaf RECORD  #交易對象往來銀行檔
       pmafent LIKE pmaf_t.pmafent, #企业编号
       pmaf001 LIKE pmaf_t.pmaf001, #交易对象编号
       pmaf002 LIKE pmaf_t.pmaf002, #银行编号
       pmaf003 LIKE pmaf_t.pmaf003, #银行账户
       pmaf004 LIKE pmaf_t.pmaf004, #账户名称
       pmaf005 LIKE pmaf_t.pmaf005, #SWIFT CODE
       pmaf006 LIKE pmaf_t.pmaf006, #备注
       pmaf007 LIKE pmaf_t.pmaf007, #IBAN CODE
       pmaf008 LIKE pmaf_t.pmaf008, #主要收款账户
       pmaf009 LIKE pmaf_t.pmaf009, #主要付款账户
       pmafstus LIKE pmaf_t.pmafstus, #状态码
       pmaf010 LIKE pmaf_t.pmaf010, #對公否
       pmaf011 LIKE pmaf_t.pmaf011  #铺位编号
END RECORD
#161124-00048#8  mod-E
DEFINE l_count        LIKE type_t.num10      #记录赋值成功笔数

   LET r_success = TRUE
   LET l_count = 0

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #将来源交易對象的允許收/付款條件檔取出
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM pmaf_t  ",
   LET l_sql = "SELECT pmafent,pmaf001,pmaf002,pmaf003,pmaf004,",
               "       pmaf005,pmaf006,pmaf007,pmaf008,pmaf009,",
               "       pmafstus,pmaf010,pmaf011 ",
               "FROM pmaf_t  ",
   #161124-00048#8  mod-E
               " WHERE pmaf001='",p_pmaf001_f,"' ",
               "   AND pmafent='",g_enterprise,"' "                                  
               #"   AND pmafstus='Y' "                                    #状态码        
   PREPARE apmm100_insert_pmaf_p FROM l_sql
   DECLARE apmm100_insert_pmaf_c CURSOR FOR apmm100_insert_pmaf_p
   FOREACH apmm100_insert_pmaf_c INTO l_pmaf.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       #LET l_pmaf.pmafstus = 'Y'        #资料状态码
       LET l_pmaf.pmaf001 = p_pmaf001_t #目的交易對象編號  

       #插入交易對象交易夥伴檔
       #161124-00048#8  mod-S
#       INSERT INTO pmaf_t VALUES (l_pmaf.*)
       INSERT INTO pmaf_t 
                   (pmafent,pmaf001,pmaf002,pmaf003,pmaf004,
                    pmaf005,pmaf006,pmaf007,pmaf008,pmaf009,
                    pmafstus,pmaf010,pmaf011)
            VALUES (l_pmaf.*)
       #161124-00048#8  mod-E
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmaf_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          LET l_count = 0
          EXIT FOREACH
       END IF
       LET l_count = l_count + 1

   END FOREACH

   RETURN r_success
   
END FUNCTION

PRIVATE FUNCTION apmm100_insert_pmab(p_pmab001_f,p_pmab001_t)
DEFINE p_pmab001_f    LIKE pmab_t.pmab001    #来源交易對象編號
DEFINE p_pmab001_t    LIKE pmab_t.pmab001    #目的交易對象編號
DEFINE r_success      LIKE type_t.num5       #处理状态
DEFINE l_sql          STRING
#161124-00048#8  mod-S
#DEFINE l_pmab         RECORD LIKE pmab_t.*
DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企业编号
       pmabsite LIKE pmab_t.pmabsite, #营运据点
       pmab001 LIKE pmab_t.pmab001, #交易对象编号
       pmab002 LIKE pmab_t.pmab002, #信用额度检查
       pmab003 LIKE pmab_t.pmab003, #额度交易对象
       pmab004 LIKE pmab_t.pmab004, #信用评核等级
       pmab005 LIKE pmab_t.pmab005, #额度计算币种
       pmab006 LIKE pmab_t.pmab006, #企业额度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
       pmab010 LIKE pmab_t.pmab010, #允许除外额度
       pmab011 LIKE pmab_t.pmab011, #额度警示水准一
       pmab012 LIKE pmab_t.pmab012, #水准一通知层
       pmab013 LIKE pmab_t.pmab013, #额度警示水准二
       pmab014 LIKE pmab_t.pmab014, #水准二通知层
       pmab015 LIKE pmab_t.pmab015, #额度警示水准三
       pmab016 LIKE pmab_t.pmab016, #水准三通知层
       pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
       pmab018 LIKE pmab_t.pmab018, #预期应收通知层
       pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
       pmab031 LIKE pmab_t.pmab031, #负责采购人员
       pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
       pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
       pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
       pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
       pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
       pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
       pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
       pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
       pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
       pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
       pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
       pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
       pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
       pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
       pmab046 LIKE pmab_t.pmab046, #供应商折扣率
       pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
       pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
       pmab052 LIKE pmab_t.pmab052, #可提前收货天数
       pmab053 LIKE pmab_t.pmab053, #惯用交易条件
       pmab054 LIKE pmab_t.pmab054, #惯用取价方式
       pmab055 LIKE pmab_t.pmab055, #应付账款类别
       pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
       pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
       pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
       pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
       pmab061 LIKE pmab_t.pmab061, #价格评分
       pmab062 LIKE pmab_t.pmab062, #达交率评分
       pmab063 LIKE pmab_t.pmab063, #质量评分
       pmab064 LIKE pmab_t.pmab064, #配合度评分
       pmab065 LIKE pmab_t.pmab065, #调整加减分
       pmab066 LIKE pmab_t.pmab066, #定性评分一
       pmab067 LIKE pmab_t.pmab067, #定性评分二
       pmab068 LIKE pmab_t.pmab068, #定性评分三
       pmab069 LIKE pmab_t.pmab069, #定性评分四
       pmab070 LIKE pmab_t.pmab070, #定性评分五
       pmab071 LIKE pmab_t.pmab071, #检验程度
       pmab072 LIKE pmab_t.pmab072, #检验水准
       pmab073 LIKE pmab_t.pmab073, #检验级数
       pmab080 LIKE pmab_t.pmab080, #客户ABC分类
       pmab081 LIKE pmab_t.pmab081, #负责业务人员
       pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
       pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
       pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
       pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
       pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
       pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
       pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
       pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
       pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
       pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
       pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
       pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
       pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
       pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
       pmab096 LIKE pmab_t.pmab096, #客户折扣率
       pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
       pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
       pmab102 LIKE pmab_t.pmab102, #可提前交货天数
       pmab103 LIKE pmab_t.pmab103, #惯用交易条件
       pmab104 LIKE pmab_t.pmab104, #惯用取价方式
       pmab105 LIKE pmab_t.pmab105, #应收账款类别
       pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
       pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
       pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
       pmabownid LIKE pmab_t.pmabownid, #资料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
       pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
       pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
       pmabstus LIKE pmab_t.pmabstus, #状态码
       pmab059 LIKE pmab_t.pmab059, #负责采购部门
       pmab109 LIKE pmab_t.pmab109, #负责业务部门
       pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
       pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
       pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
       pmab020 LIKE pmab_t.pmab020, #除外额有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
END RECORD
#161124-00048#8  mod-E
DEFINE l_pmabcrtdt    DATETIME YEAR TO SECOND

   LET r_success = TRUE


   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #複製集團層的預設資料pmab_t
   #161124-00048#8  mod-S
#   LET l_sql = "SELECT * FROM pmab_t  ",
   LET l_sql = "SELECT pmabent,pmabsite,pmab001,pmab002,pmab003,",
               "       pmab004,pmab005,pmab006,pmab007,pmab008,",
               "       pmab009,pmab010,pmab011,pmab012,pmab013,",
               "       pmab014,pmab015,pmab016,pmab017,pmab018,",
               "       pmab030,pmab031,pmab032,pmab033,pmab034,",
               "       pmab035,pmab036,pmab037,pmab038,pmab039,",
               "       pmab040,pmab041,pmab042,pmab043,pmab044,",
               "       pmab045,pmab046,pmab047,pmab048,pmab049,",
               "       pmab050,pmab051,pmab052,pmab053,pmab054,",
               "       pmab055,pmab056,pmab057,pmab058,pmab060,",
               "       pmab061,pmab062,pmab063,pmab064,pmab065,",
               "       pmab066,pmab067,pmab068,pmab069,pmab070,",
               "       pmab071,pmab072,pmab073,pmab080,pmab081,",
               "       pmab082,pmab083,pmab084,pmab085,pmab086,",
               "       pmab087,pmab088,pmab089,pmab090,pmab091,",
               "       pmab092,pmab093,pmab094,pmab095,pmab096,",
               "       pmab097,pmab098,pmab099,pmab100,pmab101,",
               "       pmab102,pmab103,pmab104,pmab105,pmab106,",
               "       pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,",
               "       pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt,pmabcnfid,",
               "       pmabcnfdt,pmabstus,pmab059,pmab109,pmab110,",
               "       pmab111,pmab019,pmab020,pmab112 ",
               "FROM pmab_t  ",
   #161124-00048#8  mod-E
               " WHERE pmab001='",p_pmab001_f,"' ",
               "   AND pmabent='",g_enterprise,"' ",     
               "   AND pmabsite = 'ALL' "               
   PREPARE apmm100_insert_pmab_p FROM l_sql
   DECLARE apmm100_insert_pmab_c CURSOR FOR apmm100_insert_pmab_p
   FOREACH apmm100_insert_pmab_c INTO l_pmab.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
       END IF

       LET l_pmab.pmab001 = p_pmab001_t #目的交易對象編號  
       LET l_pmab.pmabownid = g_user
       LET l_pmab.pmabowndp = g_dept
       LET l_pmab.pmabcrtid = g_user
       LET l_pmab.pmabcrtdp = g_dept
       LET l_pmabcrtdt = cl_get_current()
       LET l_pmab.pmabmodid = NULL
       LET l_pmab.pmabmoddt = NULL
       
       INSERT INTO pmab_t (pmabent,pmabsite,pmab001,pmab080,pmab081,pmab082,pmab083,pmab084,pmab103,pmab104,pmab085,pmab086,pmab087,
                           pmab105,pmab088,pmab089,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,pmab098,pmab099,
                           pmab100,pmab101,pmab102,pmab030,pmab031,pmab032,pmab033,pmab034,pmab053,pmab054,pmab035,pmab036,pmab037,
                           pmab055,pmab038,pmab039,pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,pmab046,pmab047,pmab048,pmab049,
                           pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,
                           pmab064,pmab069,pmab065,pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,pmab007,pmab008,pmab009,pmab010,
                           pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmab019,pmab020,pmab056,pmab057,pmab058,pmab106,pmab107,
                           pmab108,pmabownid,pmabowndp,pmabcrtid,pmabcrtdt,pmabcrtdp,pmabmodid,pmabmoddt)
           VALUES (g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab080,l_pmab.pmab081,l_pmab.pmab082,l_pmab.pmab083,l_pmab.pmab084,
                   l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab085,l_pmab.pmab086,l_pmab.pmab087,l_pmab.pmab105,l_pmab.pmab088,l_pmab.pmab089,
                   l_pmab.pmab090,l_pmab.pmab091,l_pmab.pmab092,l_pmab.pmab093,l_pmab.pmab094,l_pmab.pmab095,l_pmab.pmab096,l_pmab.pmab097,
                   l_pmab.pmab098,l_pmab.pmab099,l_pmab.pmab100,l_pmab.pmab101,l_pmab.pmab102,l_pmab.pmab030,l_pmab.pmab031,l_pmab.pmab032,
                   l_pmab.pmab033,l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab035,l_pmab.pmab036,l_pmab.pmab037,l_pmab.pmab055,
                   l_pmab.pmab038,l_pmab.pmab039,l_pmab.pmab040,l_pmab.pmab041,l_pmab.pmab042,l_pmab.pmab043,l_pmab.pmab044,l_pmab.pmab045,
                   l_pmab.pmab046,l_pmab.pmab047,l_pmab.pmab048,l_pmab.pmab049,l_pmab.pmab050,l_pmab.pmab051,l_pmab.pmab052,l_pmab.pmab071,
                   l_pmab.pmab072,l_pmab.pmab073,l_pmab.pmab060,l_pmab.pmab061,l_pmab.pmab066,l_pmab.pmab062,l_pmab.pmab067,l_pmab.pmab063,
                   l_pmab.pmab068,l_pmab.pmab064,l_pmab.pmab069,l_pmab.pmab065,l_pmab.pmab070,l_pmab.pmab002,l_pmab.pmab003,l_pmab.pmab004,
                   l_pmab.pmab005,l_pmab.pmab006,l_pmab.pmab007,l_pmab.pmab008,l_pmab.pmab009,l_pmab.pmab010,l_pmab.pmab011,l_pmab.pmab012,
                   l_pmab.pmab013,l_pmab.pmab014,l_pmab.pmab015,l_pmab.pmab016,l_pmab.pmab017,l_pmab.pmab018,l_pmab.pmab019,l_pmab.pmab020,
                   l_pmab.pmab056,l_pmab.pmab057,
                   l_pmab.pmab058,l_pmab.pmab106,l_pmab.pmab107,l_pmab.pmab108,l_pmab.pmabownid,l_pmab.pmabowndp,l_pmab.pmabcrtid,
                   l_pmabcrtdt,l_pmab.pmabcrtdp,l_pmab.pmabmodid,l_pmab.pmabmoddt) # DISK WRITE
              
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmab_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          EXIT FOREACH
       END IF

   END FOREACH

   RETURN r_success
   
END FUNCTION
#複製時欄位初始化
PRIVATE FUNCTION apmm100_reproduce_init()
    LET g_pmaa_m.pmaa001 = ''
    LET g_pmaa_m.pmaastus = 'N'
    CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
    DISPLAY BY NAME g_pmaa_m.pmaa001,g_pmaa_m.pmaastus
    LET g_pmaa_m.pmaaownid = g_user
    LET g_pmaa_m.pmaaowndp = g_dept
    LET g_pmaa_m.pmaacrtid = g_user
    LET g_pmaa_m.pmaacrtdp = g_dept 
    LET g_pmaa_m.pmaacrtdt = cl_get_current()
    LET g_pmaa_m.pmaamodid = ''
    LET g_pmaa_m.pmaamoddt = ''
    LET g_pmaa_m.pmaacnfid = ''
    LET g_pmaa_m.pmaacnfdt = ''
    
END FUNCTION

#新增後自動新增一筆all的集團預設的資料
PRIVATE FUNCTION apmm100_ins_pmab()
DEFINE r_success      LIKE type_t.num5       #处理状态
#161124-00048#8  mod-S
#DEFINE l_pmab         RECORD LIKE pmab_t.*
DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企业编号
       pmabsite LIKE pmab_t.pmabsite, #营运据点
       pmab001 LIKE pmab_t.pmab001, #交易对象编号
       pmab002 LIKE pmab_t.pmab002, #信用额度检查
       pmab003 LIKE pmab_t.pmab003, #额度交易对象
       pmab004 LIKE pmab_t.pmab004, #信用评核等级
       pmab005 LIKE pmab_t.pmab005, #额度计算币种
       pmab006 LIKE pmab_t.pmab006, #企业额度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
       pmab010 LIKE pmab_t.pmab010, #允许除外额度
       pmab011 LIKE pmab_t.pmab011, #额度警示水准一
       pmab012 LIKE pmab_t.pmab012, #水准一通知层
       pmab013 LIKE pmab_t.pmab013, #额度警示水准二
       pmab014 LIKE pmab_t.pmab014, #水准二通知层
       pmab015 LIKE pmab_t.pmab015, #额度警示水准三
       pmab016 LIKE pmab_t.pmab016, #水准三通知层
       pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
       pmab018 LIKE pmab_t.pmab018, #预期应收通知层
       pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
       pmab031 LIKE pmab_t.pmab031, #负责采购人员
       pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
       pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
       pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
       pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
       pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
       pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
       pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
       pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
       pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
       pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
       pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
       pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
       pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
       pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
       pmab046 LIKE pmab_t.pmab046, #供应商折扣率
       pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
       pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
       pmab052 LIKE pmab_t.pmab052, #可提前收货天数
       pmab053 LIKE pmab_t.pmab053, #惯用交易条件
       pmab054 LIKE pmab_t.pmab054, #惯用取价方式
       pmab055 LIKE pmab_t.pmab055, #应付账款类别
       pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
       pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
       pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
       pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
       pmab061 LIKE pmab_t.pmab061, #价格评分
       pmab062 LIKE pmab_t.pmab062, #达交率评分
       pmab063 LIKE pmab_t.pmab063, #质量评分
       pmab064 LIKE pmab_t.pmab064, #配合度评分
       pmab065 LIKE pmab_t.pmab065, #调整加减分
       pmab066 LIKE pmab_t.pmab066, #定性评分一
       pmab067 LIKE pmab_t.pmab067, #定性评分二
       pmab068 LIKE pmab_t.pmab068, #定性评分三
       pmab069 LIKE pmab_t.pmab069, #定性评分四
       pmab070 LIKE pmab_t.pmab070, #定性评分五
       pmab071 LIKE pmab_t.pmab071, #检验程度
       pmab072 LIKE pmab_t.pmab072, #检验水准
       pmab073 LIKE pmab_t.pmab073, #检验级数
       pmab080 LIKE pmab_t.pmab080, #客户ABC分类
       pmab081 LIKE pmab_t.pmab081, #负责业务人员
       pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
       pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
       pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
       pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
       pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
       pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
       pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
       pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
       pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
       pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
       pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
       pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
       pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
       pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
       pmab096 LIKE pmab_t.pmab096, #客户折扣率
       pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
       pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
       pmab102 LIKE pmab_t.pmab102, #可提前交货天数
       pmab103 LIKE pmab_t.pmab103, #惯用交易条件
       pmab104 LIKE pmab_t.pmab104, #惯用取价方式
       pmab105 LIKE pmab_t.pmab105, #应收账款类别
       pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
       pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
       pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
       pmabownid LIKE pmab_t.pmabownid, #资料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
       pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
       pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
       pmabstus LIKE pmab_t.pmabstus, #状态码
       pmab059 LIKE pmab_t.pmab059, #负责采购部门
       pmab109 LIKE pmab_t.pmab109, #负责业务部门
       pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
       pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
       pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
       pmab020 LIKE pmab_t.pmab020, #除外额有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
END RECORD
#161124-00048#8  mod-E
DEFINE l_pmabcrtdt    DATETIME YEAR TO SECOND

   LET r_success = TRUE


   #检查:应在事物中的
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   INITIALIZE l_pmab.* TO NULL
   
   LET l_pmab.pmabsite = 'ALL'
   LET l_pmab.pmab001 = g_pmaa_m.pmaa001  #交易對象編號  
   LET l_pmab.pmabownid = g_user
   LET l_pmab.pmabowndp = g_dept
   LET l_pmab.pmabcrtid = g_user
   LET l_pmab.pmabcrtdp = g_dept
   LET l_pmabcrtdt = cl_get_current()
   LET l_pmab.pmabmodid = NULL
   LET l_pmab.pmabmoddt = NULL
   
   #一般欄位給值
   LET l_pmab.pmab080 = "A"
   LET l_pmab.pmab085 = "10"
   LET l_pmab.pmab086 = "1"
   LET l_pmab.pmab107 = "1" 
   #ming 20150923 modify -----(S) 
   #LET l_pmab.pmab108 = "1"
   LET l_pmab.pmab108 = "2" 
   #ming 20150923 modify -----(E) 
   LET l_pmab.pmab099 = "Y"
   LET l_pmab.pmab101 = "Y"
   LET l_pmab.pmab030 = "A"
   LET l_pmab.pmab035 = "10"
   LET l_pmab.pmab036 = "1"
   LET l_pmab.pmab057 = "1" 
   #ming 20150923 modify -----(S) 
   #LET l_pmab.pmab058 = "1"
   LET l_pmab.pmab058 = "2" 
   #ming 20150923 modify -----(E) 
   LET l_pmab.pmab049 = "Y"
   LET l_pmab.pmab051 = "Y"
   LET l_pmab.pmab071 = "N"
   LET l_pmab.pmab072 = "1"
   LET l_pmab.pmab073 = "1"
   LET l_pmab.pmab002 = "1"
   LET l_pmab.pmab012 = "1"
   LET l_pmab.pmab014 = "1"
   LET l_pmab.pmab016 = "1"
   LET l_pmab.pmab017 = "N"
   LET l_pmab.pmab018 = "1"
   
   LET l_pmab.pmab019 = "0"
   
   #150529 by whitney add start
   LET l_pmab.pmab111 = "0"
   LET l_pmab.pmab110 = "0"
   LET l_pmab.pmab006 = "0"
   LET l_pmab.pmab010 = "0"
   LET l_pmab.pmab032 = g_dlang
   LET l_pmab.pmab082 = g_dlang
   #150529 by whitney add end
   
   #150922-00020#3-Start-Add
   LET l_pmab.pmab081 = g_pmaa_m.pmaa096
   LET l_pmab.pmab109 = g_pmaa_m.pmaa097
   #150922-00020#3-End-Add
   LET l_pmab.pmab003 = l_pmab.pmab001 #預設交易對象編號

   INSERT INTO pmab_t (pmabent,pmabsite,pmab001,pmab080,pmab081,pmab082,pmab083,pmab084,pmab103,pmab104,pmab085,pmab086,pmab087,
                       pmab105,pmab088,pmab089,pmab090,pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,pmab098,
                       pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab032,pmab033,pmab034,pmab053,pmab054,pmab035,pmab036,
                       pmab037,pmab055,pmab038,pmab039,pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,pmab046,pmab047,
                       pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,pmab060,pmab061,pmab066,pmab062,
                       pmab067,pmab063,pmab068,pmab064,pmab069,pmab065,pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,
                       pmab007,pmab008,pmab009,pmab010,pmab011,pmab012,pmab013,pmab014,pmab015,pmab016,pmab017,pmab018,pmab019,pmab020,
                       pmab056,pmab057,pmab058,pmab106,pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,pmabcrtdt,pmabcrtdp,
                      #pmabmodid,pmabmoddt)         #150922-00020#3 mark
                       pmabmodid,pmabmoddt,pmab109) #150922-00020#3 Add
       VALUES (g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab080,l_pmab.pmab081,l_pmab.pmab082,l_pmab.pmab083,l_pmab.pmab084,
               l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab085,l_pmab.pmab086,l_pmab.pmab087,l_pmab.pmab105,l_pmab.pmab088,l_pmab.pmab089,
               l_pmab.pmab090,l_pmab.pmab091,l_pmab.pmab092,l_pmab.pmab093,l_pmab.pmab094,l_pmab.pmab095,l_pmab.pmab096,l_pmab.pmab097,
               l_pmab.pmab098,l_pmab.pmab099,l_pmab.pmab100,l_pmab.pmab101,l_pmab.pmab102,l_pmab.pmab030,l_pmab.pmab031,l_pmab.pmab032,
               l_pmab.pmab033,l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,l_pmab.pmab035,l_pmab.pmab036,l_pmab.pmab037,l_pmab.pmab055,
               l_pmab.pmab038,l_pmab.pmab039,l_pmab.pmab040,l_pmab.pmab041,l_pmab.pmab042,l_pmab.pmab043,l_pmab.pmab044,l_pmab.pmab045,
               l_pmab.pmab046,l_pmab.pmab047,l_pmab.pmab048,l_pmab.pmab049,l_pmab.pmab050,l_pmab.pmab051,l_pmab.pmab052,l_pmab.pmab071,
               l_pmab.pmab072,l_pmab.pmab073,l_pmab.pmab060,l_pmab.pmab061,l_pmab.pmab066,l_pmab.pmab062,l_pmab.pmab067,l_pmab.pmab063,
               l_pmab.pmab068,l_pmab.pmab064,l_pmab.pmab069,l_pmab.pmab065,l_pmab.pmab070,l_pmab.pmab002,l_pmab.pmab003,l_pmab.pmab004,
               l_pmab.pmab005,l_pmab.pmab006,l_pmab.pmab007,l_pmab.pmab008,l_pmab.pmab009,l_pmab.pmab010,l_pmab.pmab011,l_pmab.pmab012,
               l_pmab.pmab013,l_pmab.pmab014,l_pmab.pmab015,l_pmab.pmab016,l_pmab.pmab017,l_pmab.pmab018,l_pmab.pmab019,l_pmab.pmab020,
               l_pmab.pmab056,l_pmab.pmab057,
               l_pmab.pmab058,l_pmab.pmab106,l_pmab.pmab107,l_pmab.pmab108,l_pmab.pmabownid,l_pmab.pmabowndp,l_pmab.pmabcrtid,l_pmabcrtdt,
              #l_pmab.pmabcrtdp,l_pmab.pmabmodid,l_pmab.pmabmoddt)                # DISK WRITE #150922-00020#3 mark
               l_pmab.pmabcrtdp,l_pmab.pmabmodid,l_pmab.pmabmoddt,l_pmab.pmab109) # DISK WRITE #150922-00020#3 add
          
   IF SQLCA.sqlcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
   
END FUNCTION

#信用評級檢查
PRIVATE FUNCTION apmm100_pmaa053_chk()

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmm100_pmaa053_ref(p_xmajl001)
# Input parameter: p_xmajl001
# Return code....: r_xmajl003
# Date & Author..: 2014/08/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmm100_pmaa053_ref(p_xmajl001)
   DEFINE p_xmajl001     LIKE xmajl_t.xmajl001
   DEFINE r_xmajl003     LIKE xmajl_t.xmajl003

   LET r_xmajl003 = ''
   SELECT xmajl003 INTO r_xmajl003
     FROM xmajl_t
    WHERE xmajlent = g_enterprise
      AND xmajl001 = p_xmajl001
      AND xmajl002 = g_dlang

   RETURN r_xmajl003
END FUNCTION

 
{</section>}
 
