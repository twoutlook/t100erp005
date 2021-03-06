#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-04-28 10:28:56), PR版次:0016(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000122
#+ Filename...: apmt840
#+ Description: 採購單維護作業
#+ Creator....: 04226(2014-11-21 08:55:17)
#+ Modifier...: 02749 -SD/PR- 00000
 
{</section>}
 
{<section id="apmt840.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160201-00017#1   2016/02/02  By fionchen  產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160314-00009#5   2016/03/17  By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#21  2016/04/20  BY 07900     校验代码重复错误讯息的修改
#160510-00043#2   2016/07/25  By 02097     T類作業在browser_fill()組SQL前,呼叫s_aooi200_filter_slip將回傳條件組進去g_wc中
#160816-00001#9   2016/08/17  By 08734     抓取理由碼改CALL sub
#160816-00068#15  2016/08/22  By earl      調整transaction
#160818-00017#28  2016/08/30  By 08742     删除修改未重新判断状态码
#160824-00007#12  2016/09/14  By 06814     舊值備份處理
#170217-00003#1   2017/02/18  By 08171     v_inaa001_17校驗修正:改傳入最終收貨組織來校驗
#170217-00026#1   2017/02/21  By 08171     商品編號的開窗&校驗加上只能是自訂貨的控卡
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
PRIVATE type type_g_pmdl_m        RECORD
       pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlsite_desc LIKE type_t.chr80, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdl001 LIKE pmdl_t.pmdl001, 
   pmdl005 LIKE pmdl_t.pmdl005, 
   pmdl200 LIKE pmdl_t.pmdl200, 
   pmdl200_desc LIKE type_t.chr80, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl004_desc LIKE type_t.chr80, 
   pmdl203 LIKE pmdl_t.pmdl203, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl002_desc LIKE type_t.chr80, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl003_desc LIKE type_t.chr80, 
   pmdlstus LIKE pmdl_t.pmdlstus, 
   pmdl007 LIKE pmdl_t.pmdl007, 
   pmdl008 LIKE pmdl_t.pmdl008, 
   pmdl027 LIKE pmdl_t.pmdl027, 
   pmdl027_desc LIKE type_t.chr80, 
   pmdl201 LIKE pmdl_t.pmdl201, 
   pmdl202 LIKE pmdl_t.pmdl202, 
   pmdl204 LIKE pmdl_t.pmdl204, 
   pmdl204_desc LIKE type_t.chr80, 
   pmdl207 LIKE pmdl_t.pmdl207, 
   pmdl207_desc LIKE type_t.chr80, 
   pmdlunit LIKE pmdl_t.pmdlunit, 
   pmdlunit_desc LIKE type_t.chr80, 
   pmdl029 LIKE pmdl_t.pmdl029, 
   pmdl029_desc LIKE type_t.chr80, 
   pmdl025 LIKE pmdl_t.pmdl025, 
   pmdl025_desc LIKE type_t.chr80, 
   oofb017 LIKE type_t.chr500, 
   pmdl206 LIKE pmdl_t.pmdl206, 
   pmdl205 LIKE pmdl_t.pmdl205, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl023_desc LIKE type_t.chr80, 
   pmdl022 LIKE pmdl_t.pmdl022, 
   pmdl022_desc LIKE type_t.chr80, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl021_desc LIKE type_t.chr80, 
   pmdl047 LIKE pmdl_t.pmdl047, 
   pmdl054 LIKE pmdl_t.pmdl054, 
   pmdl055 LIKE pmdl_t.pmdl055, 
   pmdl009 LIKE pmdl_t.pmdl009, 
   pmdl009_desc LIKE type_t.chr80, 
   pmdl015 LIKE pmdl_t.pmdl015, 
   pmdl015_desc LIKE type_t.chr80, 
   pmdl016 LIKE pmdl_t.pmdl016, 
   pmdl010 LIKE pmdl_t.pmdl010, 
   pmdl010_desc LIKE type_t.chr80, 
   pmdl011 LIKE pmdl_t.pmdl011, 
   pmdl011_desc LIKE type_t.chr80, 
   pmdl012 LIKE pmdl_t.pmdl012, 
   pmdl013 LIKE pmdl_t.pmdl013, 
   pmdl033 LIKE pmdl_t.pmdl033, 
   pmdl033_desc LIKE type_t.chr80, 
   pmdl024 LIKE pmdl_t.pmdl024, 
   pmdl024_desc LIKE type_t.chr80, 
   pmdl043 LIKE pmdl_t.pmdl043, 
   pmdl043_desc LIKE type_t.chr80, 
   pmdl020 LIKE pmdl_t.pmdl020, 
   pmdl020_desc LIKE type_t.chr80, 
   pmdl044 LIKE pmdl_t.pmdl044, 
   pmdl006 LIKE pmdl_t.pmdl006, 
   pmdl028 LIKE pmdl_t.pmdl028, 
   pmdl042 LIKE pmdl_t.pmdl042, 
   pmdl048 LIKE pmdl_t.pmdl048, 
   pmdl049 LIKE pmdl_t.pmdl049, 
   pmdl046 LIKE pmdl_t.pmdl046, 
   pmdl040 LIKE pmdl_t.pmdl040, 
   pmdl041 LIKE pmdl_t.pmdl041, 
   pmdlownid LIKE pmdl_t.pmdlownid, 
   pmdlownid_desc LIKE type_t.chr80, 
   pmdlowndp LIKE pmdl_t.pmdlowndp, 
   pmdlowndp_desc LIKE type_t.chr80, 
   pmdlcrtid LIKE pmdl_t.pmdlcrtid, 
   pmdlcrtid_desc LIKE type_t.chr80, 
   pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, 
   pmdlcrtdp_desc LIKE type_t.chr80, 
   pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, 
   pmdlmodid LIKE pmdl_t.pmdlmodid, 
   pmdlmodid_desc LIKE type_t.chr80, 
   pmdlmoddt LIKE pmdl_t.pmdlmoddt, 
   pmdlcnfid LIKE pmdl_t.pmdlcnfid, 
   pmdlcnfid_desc LIKE type_t.chr80, 
   pmdlcnfdt LIKE pmdl_t.pmdlcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmdn_d        RECORD
       pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnsite_desc LIKE type_t.chr500, 
   pmdn200 LIKE pmdn_t.pmdn200, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn001_desc LIKE type_t.chr500, 
   pmdn001_desc_desc LIKE type_t.chr500, 
   pmdn228 LIKE pmdn_t.pmdn228, 
   pmdn228_desc LIKE type_t.chr500, 
   pmdn002 LIKE pmdn_t.pmdn002, 
   pmdn002_desc LIKE type_t.chr500, 
   pmdn016 LIKE pmdn_t.pmdn016, 
   pmdn016_desc LIKE type_t.chr500, 
   pmdn017 LIKE pmdn_t.pmdn017, 
   pmdn227 LIKE pmdn_t.pmdn227, 
   pmdn201 LIKE pmdn_t.pmdn201, 
   pmdn201_desc LIKE type_t.chr500, 
   pmdn202 LIKE pmdn_t.pmdn202, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn006_desc LIKE type_t.chr500, 
   pmdn007 LIKE pmdn_t.pmdn007, 
   pmdn226 LIKE pmdn_t.pmdn226, 
   pmdn008 LIKE pmdn_t.pmdn008, 
   pmdn008_desc LIKE type_t.chr500, 
   pmdn009 LIKE pmdn_t.pmdn009, 
   pmdn010 LIKE pmdn_t.pmdn010, 
   pmdn010_desc LIKE type_t.chr500, 
   pmdn011 LIKE pmdn_t.pmdn011, 
   pmdn015 LIKE pmdn_t.pmdn015, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   pmdnunit_desc LIKE type_t.chr500, 
   pmdn225 LIKE pmdn_t.pmdn225, 
   pmdn225_desc LIKE type_t.chr500, 
   pmdn203 LIKE pmdn_t.pmdn203, 
   pmdn203_desc LIKE type_t.chr500, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn025_desc LIKE type_t.chr500, 
   l_pmdn025_addr LIKE type_t.chr500, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn028_desc LIKE type_t.chr500, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn029_desc LIKE type_t.chr500, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn053 LIKE pmdn_t.pmdn053, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnorga_desc LIKE type_t.chr500, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn026_desc LIKE type_t.chr500, 
   l_pmdn026_addr LIKE type_t.chr500, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn014 LIKE pmdn_t.pmdn014, 
   pmdn012 LIKE pmdn_t.pmdn012, 
   pmdn013 LIKE pmdn_t.pmdn013, 
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn023_desc LIKE type_t.chr500, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn206 LIKE pmdn_t.pmdn206, 
   pmdn207 LIKE pmdn_t.pmdn207, 
   pmdn208 LIKE pmdn_t.pmdn208, 
   pmdn209 LIKE pmdn_t.pmdn209, 
   pmdn210 LIKE pmdn_t.pmdn210, 
   pmdn211 LIKE pmdn_t.pmdn211, 
   pmdn212 LIKE pmdn_t.pmdn212, 
   pmdn213 LIKE pmdn_t.pmdn213, 
   pmdn019 LIKE pmdn_t.pmdn019, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdn224 LIKE pmdn_t.pmdn224, 
   pmdn052 LIKE pmdn_t.pmdn052, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn049_desc LIKE type_t.chr500, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdn051_desc LIKE type_t.chr500, 
   pmdn205 LIKE pmdn_t.pmdn205, 
   pmdn205_desc LIKE type_t.chr500, 
   pmdn214 LIKE pmdn_t.pmdn214, 
   pmdn214_desc LIKE type_t.chr500, 
   pmdn215 LIKE pmdn_t.pmdn215, 
   pmdn216 LIKE pmdn_t.pmdn216, 
   pmdn217 LIKE pmdn_t.pmdn217, 
   pmdn217_desc LIKE type_t.chr500, 
   pmdn218 LIKE pmdn_t.pmdn218, 
   pmdn219 LIKE pmdn_t.pmdn219, 
   pmdn220 LIKE pmdn_t.pmdn220, 
   pmdn220_desc LIKE type_t.chr500, 
   pmdn221 LIKE pmdn_t.pmdn221, 
   pmdn221_desc LIKE type_t.chr500, 
   pmdn222 LIKE pmdn_t.pmdn222, 
   pmdn223 LIKE pmdn_t.pmdn223, 
   pmdn050 LIKE pmdn_t.pmdn050
       END RECORD
PRIVATE TYPE type_g_pmdn2_d RECORD
       xrcdsite LIKE xrcd_t.xrcdsite, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   pmdn2001 LIKE type_t.chr500, 
   pmdn0011 LIKE type_t.chr500, 
   pmdn0011_desc LIKE type_t.chr500, 
   pmdn0011_desc_desc LIKE type_t.chr500, 
   pmdn0021 LIKE type_t.chr500, 
   pmdn0021_desc LIKE type_t.chr500, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd104 LIKE xrcd_t.xrcd104
       END RECORD
PRIVATE TYPE type_g_pmdn3_d RECORD
       pmdosite LIKE pmdo_t.pmdosite, 
   pmdoseq LIKE pmdo_t.pmdoseq, 
   pmdoseq1 LIKE pmdo_t.pmdoseq1, 
   pmdoseq2 LIKE pmdo_t.pmdoseq2, 
   pmdo003 LIKE pmdo_t.pmdo003, 
   pmdo001 LIKE pmdo_t.pmdo001, 
   pmdo001_desc LIKE type_t.chr500, 
   pmdo001_desc_desc LIKE type_t.chr500, 
   pmdo002 LIKE pmdo_t.pmdo002, 
   pmdo005 LIKE pmdo_t.pmdo005, 
   pmdn0141 LIKE type_t.chr500, 
   pmdo200 LIKE pmdo_t.pmdo200, 
   pmdo200_desc LIKE type_t.chr500, 
   pmdo201 LIKE pmdo_t.pmdo201, 
   pmdo004 LIKE pmdo_t.pmdo004, 
   pmdo004_desc LIKE type_t.chr500, 
   pmdo006 LIKE pmdo_t.pmdo006, 
   pmdo028 LIKE pmdo_t.pmdo028, 
   pmdo028_desc LIKE type_t.chr500, 
   pmdo029 LIKE pmdo_t.pmdo029, 
   pmdo013 LIKE pmdo_t.pmdo013, 
   pmdo011 LIKE pmdo_t.pmdo011, 
   pmdo012 LIKE pmdo_t.pmdo012, 
   pmdo010 LIKE pmdo_t.pmdo010, 
   pmdo010_desc LIKE type_t.chr500, 
   pmdo009 LIKE pmdo_t.pmdo009, 
   pmdo015 LIKE pmdo_t.pmdo015, 
   pmdo016 LIKE pmdo_t.pmdo016, 
   pmdo017 LIKE pmdo_t.pmdo017, 
   pmdo040 LIKE pmdo_t.pmdo040, 
   pmdo019 LIKE pmdo_t.pmdo019, 
   pmdo021 LIKE pmdo_t.pmdo021, 
   pmdo030 LIKE pmdo_t.pmdo030, 
   pmdo030_desc LIKE type_t.chr500, 
   pmdo031 LIKE pmdo_t.pmdo031, 
   pmdo022 LIKE pmdo_t.pmdo022, 
   pmdo023 LIKE pmdo_t.pmdo023, 
   pmdo023_desc LIKE type_t.chr500, 
   pmdo024 LIKE pmdo_t.pmdo024, 
   pmdo032 LIKE pmdo_t.pmdo032, 
   pmdo033 LIKE pmdo_t.pmdo033, 
   pmdo034 LIKE pmdo_t.pmdo034, 
   pmdo025 LIKE pmdo_t.pmdo025, 
   pmdo026 LIKE pmdo_t.pmdo026, 
   pmdo026_desc LIKE type_t.chr500, 
   pmdo027 LIKE pmdo_t.pmdo027
       END RECORD
PRIVATE TYPE type_g_pmdn6_d RECORD
       pmdmsite LIKE pmdm_t.pmdmsite, 
   pmdm001 LIKE pmdm_t.pmdm001, 
   pmdm014 LIKE pmdm_t.pmdm014, 
   pmdm002 LIKE pmdm_t.pmdm002, 
   pmdm002_desc LIKE type_t.chr500, 
   pmdm003 LIKE pmdm_t.pmdm003, 
   pmdm004 LIKE pmdm_t.pmdm004, 
   pmdm005 LIKE pmdm_t.pmdm005, 
   pmdm006 LIKE pmdm_t.pmdm006, 
   pmdm007 LIKE pmdm_t.pmdm007, 
   pmdm008 LIKE pmdm_t.pmdm008, 
   pmdm009 LIKE pmdm_t.pmdm009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmdldocno LIKE pmdl_t.pmdldocno,
      b_pmdldocdt LIKE pmdl_t.pmdldocdt,
      b_pmdl001 LIKE pmdl_t.pmdl001,
      b_pmdl002 LIKE pmdl_t.pmdl002,
   b_pmdl002_desc LIKE type_t.chr80,
      b_pmdl003 LIKE pmdl_t.pmdl003,
   b_pmdl003_desc LIKE type_t.chr80,
      b_pmdl004 LIKE pmdl_t.pmdl004,
   b_pmdl004_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag    LIKE type_t.num5        #用來判斷單頭site的輸入狀況，用來欄位開關
DEFINE g_hold         LIKE type_t.num5
DEFINE g_field        STRING
DEFINE g_cmd          LIKE type_t.chr1       #160120-00001#5 160121 By pomelo add
DEFINE g_slip_wc          STRING     #160510-00043#2
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmdl_m          type_g_pmdl_m
DEFINE g_pmdl_m_t        type_g_pmdl_m
DEFINE g_pmdl_m_o        type_g_pmdl_m
DEFINE g_pmdl_m_mask_o   type_g_pmdl_m #轉換遮罩前資料
DEFINE g_pmdl_m_mask_n   type_g_pmdl_m #轉換遮罩後資料
 
   DEFINE g_pmdldocno_t LIKE pmdl_t.pmdldocno
 
 
DEFINE g_pmdn_d          DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdn_d_t        type_g_pmdn_d
DEFINE g_pmdn_d_o        type_g_pmdn_d
DEFINE g_pmdn_d_mask_o   DYNAMIC ARRAY OF type_g_pmdn_d #轉換遮罩前資料
DEFINE g_pmdn_d_mask_n   DYNAMIC ARRAY OF type_g_pmdn_d #轉換遮罩後資料
DEFINE g_pmdn2_d          DYNAMIC ARRAY OF type_g_pmdn2_d
DEFINE g_pmdn2_d_t        type_g_pmdn2_d
DEFINE g_pmdn2_d_o        type_g_pmdn2_d
DEFINE g_pmdn2_d_mask_o   DYNAMIC ARRAY OF type_g_pmdn2_d #轉換遮罩前資料
DEFINE g_pmdn2_d_mask_n   DYNAMIC ARRAY OF type_g_pmdn2_d #轉換遮罩後資料
DEFINE g_pmdn3_d          DYNAMIC ARRAY OF type_g_pmdn3_d
DEFINE g_pmdn3_d_t        type_g_pmdn3_d
DEFINE g_pmdn3_d_o        type_g_pmdn3_d
DEFINE g_pmdn3_d_mask_o   DYNAMIC ARRAY OF type_g_pmdn3_d #轉換遮罩前資料
DEFINE g_pmdn3_d_mask_n   DYNAMIC ARRAY OF type_g_pmdn3_d #轉換遮罩後資料
DEFINE g_pmdn6_d          DYNAMIC ARRAY OF type_g_pmdn6_d
DEFINE g_pmdn6_d_t        type_g_pmdn6_d
DEFINE g_pmdn6_d_o        type_g_pmdn6_d
DEFINE g_pmdn6_d_mask_o   DYNAMIC ARRAY OF type_g_pmdn6_d #轉換遮罩前資料
DEFINE g_pmdn6_d_mask_n   DYNAMIC ARRAY OF type_g_pmdn6_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
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
DEFINE g_touch               LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmt840.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_hold = FALSE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT pmdlsite,'',pmdldocdt,pmdldocno,pmdl001,pmdl005,pmdl200,'',pmdl004,'', 
       pmdl203,pmdl002,'',pmdl003,'',pmdlstus,pmdl007,pmdl008,pmdl027,'',pmdl201,pmdl202,pmdl204,'', 
       pmdl207,'',pmdlunit,'',pmdl029,'',pmdl025,'','',pmdl206,pmdl205,pmdl023,'',pmdl022,'',pmdl021, 
       '',pmdl047,pmdl054,pmdl055,pmdl009,'',pmdl015,'',pmdl016,pmdl010,'',pmdl011,'',pmdl012,pmdl013, 
       pmdl033,'',pmdl024,'',pmdl043,'',pmdl020,'',pmdl044,pmdl006,pmdl028,pmdl042,pmdl048,pmdl049,pmdl046, 
       pmdl040,pmdl041,pmdlownid,'',pmdlowndp,'',pmdlcrtid,'',pmdlcrtdp,'',pmdlcrtdt,pmdlmodid,'',pmdlmoddt, 
       pmdlcnfid,'',pmdlcnfdt", 
                      " FROM pmdl_t",
                      " WHERE pmdlent= ? AND pmdldocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt840_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmdlsite,t0.pmdldocdt,t0.pmdldocno,t0.pmdl001,t0.pmdl005,t0.pmdl200, 
       t0.pmdl004,t0.pmdl203,t0.pmdl002,t0.pmdl003,t0.pmdlstus,t0.pmdl007,t0.pmdl008,t0.pmdl027,t0.pmdl201, 
       t0.pmdl202,t0.pmdl204,t0.pmdl207,t0.pmdlunit,t0.pmdl029,t0.pmdl025,t0.pmdl206,t0.pmdl205,t0.pmdl023, 
       t0.pmdl022,t0.pmdl021,t0.pmdl047,t0.pmdl054,t0.pmdl055,t0.pmdl009,t0.pmdl015,t0.pmdl016,t0.pmdl010, 
       t0.pmdl011,t0.pmdl012,t0.pmdl013,t0.pmdl033,t0.pmdl024,t0.pmdl043,t0.pmdl020,t0.pmdl044,t0.pmdl006, 
       t0.pmdl028,t0.pmdl042,t0.pmdl048,t0.pmdl049,t0.pmdl046,t0.pmdl040,t0.pmdl041,t0.pmdlownid,t0.pmdlowndp, 
       t0.pmdlcrtid,t0.pmdlcrtdp,t0.pmdlcrtdt,t0.pmdlmodid,t0.pmdlmoddt,t0.pmdlcnfid,t0.pmdlcnfdt,t1.ooefl003 , 
       t2.ooefl003 ,t3.pmaal004 ,t4.ooag011 ,t5.ooefl003 ,t6.oofa011 ,t7.ooefl003 ,t8.rtaxl003 ,t9.ooefl003 , 
       t10.ooefl003 ,t11.oojdl003 ,t12.pmaal004 ,t13.pmaal004 ,t14.ooibl004 ,t15.ooail003 ,t16.oocql004 , 
       t17.oocql004 ,t18.oocql004 ,t19.oocql004 ,t20.ooag011 ,t21.ooefl003 ,t22.ooag011 ,t23.ooefl003 , 
       t24.ooag011 ,t25.ooag011",
               " FROM pmdl_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdlsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmdl200 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.pmdl004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.pmdl002  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmdl003 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t6 ON t6.oofaent="||g_enterprise||" AND t6.oofa001=t0.pmdl027  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmdl204 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t8 ON t8.rtaxlent="||g_enterprise||" AND t8.rtaxl001=t0.pmdl207 AND t8.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.pmdlunit AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.pmdl029 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t11 ON t11.oojdlent="||g_enterprise||" AND t11.oojdl001=t0.pmdl023 AND t11.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t12 ON t12.pmaalent="||g_enterprise||" AND t12.pmaal001=t0.pmdl022 AND t12.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t13 ON t13.pmaalent="||g_enterprise||" AND t13.pmaal001=t0.pmdl021 AND t13.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t14 ON t14.ooiblent="||g_enterprise||" AND t14.ooibl002=t0.pmdl009 AND t14.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t15 ON t15.ooailent="||g_enterprise||" AND t15.ooail001=t0.pmdl015 AND t15.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='238' AND t16.oocql002=t0.pmdl010 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent="||g_enterprise||" AND t17.oocql001='264' AND t17.oocql002=t0.pmdl024 AND t17.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='317' AND t18.oocql002=t0.pmdl043 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='263' AND t19.oocql002=t0.pmdl020 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.pmdlownid  ",
               " LEFT JOIN ooefl_t t21 ON t21.ooeflent="||g_enterprise||" AND t21.ooefl001=t0.pmdlowndp AND t21.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t22 ON t22.ooagent="||g_enterprise||" AND t22.ooag001=t0.pmdlcrtid  ",
               " LEFT JOIN ooefl_t t23 ON t23.ooeflent="||g_enterprise||" AND t23.ooefl001=t0.pmdlcrtdp AND t23.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t24 ON t24.ooagent="||g_enterprise||" AND t24.ooag001=t0.pmdlmodid  ",
               " LEFT JOIN ooag_t t25 ON t25.ooagent="||g_enterprise||" AND t25.ooag001=t0.pmdlcnfid  ",
 
               " WHERE t0.pmdlent = " ||g_enterprise|| " AND t0.pmdldocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt840_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt840 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt840_init()   
 
      #進入選單 Menu (="N")
      CALL apmt840_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt840
      
   END IF 
   
   CLOSE apmt840_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt840.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt840_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('pmdlstus','13','N,Y,H,C,A,D,R,W,UH,X')
 
      CALL cl_set_combo_scc('pmdl005','2052') 
   CALL cl_set_combo_scc('pmdl203','6014') 
   CALL cl_set_combo_scc('pmdl007','2054') 
   CALL cl_set_combo_scc('pmdl054','2087') 
   CALL cl_set_combo_scc('pmdl055','2086') 
   CALL cl_set_combo_scc('pmdl006','2053') 
   CALL cl_set_combo_scc('pmdl046','8321') 
   CALL cl_set_combo_scc('pmdn045','2035') 
   CALL cl_set_combo_scc('pmdn019','2055') 
   CALL cl_set_combo_scc('pmdn020','2036') 
   CALL cl_set_combo_scc('pmdn215','6739') 
   CALL cl_set_combo_scc('pmdn216','6013') 
   CALL cl_set_combo_scc('pmdo003','2055') 
   CALL cl_set_combo_scc('pmdo009','2057') 
   CALL cl_set_combo_scc('pmdo021','2058') 
   CALL cl_set_combo_scc('pmdm014','3015') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #採購性質
   CALL cl_set_combo_scc_part('pmdl005','2052','1')
   #採購方式
   CALL cl_set_combo_scc_part('pmdl203','6014','0,1,3')
   #資料來源類型
   #CALL cl_set_combo_scc_part('pmdl007','6740','1,2,3,4,5,7,10,11,12')   #150819-00025#1 150820 by sakura mark
   #CALL cl_set_combo_scc_part('pmdl007','6740','1,2,7,10,11,12')   #150819-00025#1 150820 by sakura add
   CALL cl_set_combo_scc_part('pmdl007','6740','1,2,7,10,11,12,13')    #151130-00008#2 20151218 add by beckxie
   
   CALL cl_set_combo_scc_part('pmdn019','2055','1,2,3,8,9')
   CALL cl_set_combo_scc('pmdo003','2055')
   CALL cl_set_combo_scc('pmdo009','2057')
   CALL cl_set_combo_scc('pmdo021','2058')
   LET g_errshow = 1
   
   #計算稅額所需的temp table
   CALL s_tax_recount_tmp()
   
   #維護多交期所需的temp table
   CALL apmt840_01_create_temp_table() RETURNING l_success
   
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #160314-00009#5 zhujing add 2016-3-17---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdn002,pmdn002_desc",FALSE)
   END IF
   #160314-00009#5 zhujing add 2016-3-17---(E)
   CALL s_aooi200_filter_slip('pmdldocno') RETURNING g_slip_wc    #160510-00043#2
   #end add-point
   
   #初始化搜尋條件
   CALL apmt840_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt840.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt840_ui_dialog()
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
   DEFINE l_pmaa004   LIKE pmaa_t.pmaa004
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rtka010   LIKE rtka_t.rtka010    #訂單有效期
   DEFINE l_rtka012   LIKE rtka_t.rtka012    #送貨天數
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007    #採購數量
   DEFINE l_pmdn011   LIKE pmdn_t.pmdn011    #計價數量
   DEFINE l_pmdn014   LIKE pmdn_t.pmdn014    #到庫日期
   DEFINE l_pmdn020   LIKE pmdn_t.pmdn020    #緊急度
   DEFINE l_pmdn024   LIKE pmdn_t.pmdn024    #多交期
   DEFINE l_pmdn046   LIKE pmdn_t.pmdn046    #未稅金額
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047    #含稅金額
   DEFINE l_pmdn048   LIKE pmdn_t.pmdn048    #稅額
   DEFINE l_pmdn202   LIKE pmdn_t.pmdn202    #包裝數量
   DEFINE l_pmdn224   LIKE pmdn_t.pmdn224    #採購失效日
   DEFINE l_xrcd103   LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104   LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105   LIKE xrcd_t.xrcd105
   DEFINE l_xrcd113   LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114   LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115   LIKE xrcd_t.xrcd115
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
            CALL apmt840_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
                        
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
            
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_touch = 1
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmdl_m.* TO NULL
         CALL g_pmdn_d.clear()
         CALL g_pmdn2_d.clear()
         CALL g_pmdn3_d.clear()
         CALL g_pmdn6_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt840_init()
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
               
               CALL apmt840_fetch('') # reload data
               LET l_ac = 1
               CALL apmt840_ui_detailshow() #Setting the current row 
         
               CALL apmt840_idx_chk()
               #NEXT FIELD pmdnseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmdn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt840_idx_chk()
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
               CALL apmt840_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                              
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmt840_s01_d
            LET g_action_choice="open_apmt840_s01_d"
            IF cl_auth_chk_act("open_apmt840_s01_d") THEN
               
               #add-point:ON ACTION open_apmt840_s01_d name="menu.detail_show.page1.open_apmt840_s01_d"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF NOT cl_null(g_pmdl_m.pmdldocno) AND 
                  NOT cl_null(g_pmdn_d[g_detail_idx].pmdnseq) THEN
                  CALL apmt840_show_pmdp(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmt840_01
            LET g_action_choice="open_apmt840_01"
            IF cl_auth_chk_act("open_apmt840_01") THEN
               
               #add-point:ON ACTION open_apmt840_01 name="menu.detail_show.page1.open_apmt840_01"
               IF g_detail_idx > 0 THEN
                  CALL s_transaction_begin()
                  LET l_success = ''
                  CALL apmt840_01(g_pmdl_m.pmdldocno, g_pmdn_d[g_detail_idx].pmdnseq,
                                  g_pmdn_d[g_detail_idx].pmdnsite,g_pmdn_d[g_detail_idx].pmdnunit,
                                  g_pmdn_d[g_detail_idx].pmdn001, g_pmdn_d[g_detail_idx].pmdn006,
                                  g_pmdn_d[g_detail_idx].pmdn007, g_pmdn_d[g_detail_idx].pmdn024,
                                  g_pmdn_d[g_detail_idx].pmdn201, g_pmdn_d[g_detail_idx].pmdn202)
                     RETURNING l_success,l_pmdn014,l_pmdn007,l_pmdn202,l_pmdn020,l_pmdn024
                  #計算包裝數量
                  IF NOT cl_null(g_pmdn_d[g_detail_idx].pmdn201) THEN
                     CALL s_aooi250_convert_qty(g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn201,l_pmdn007)
                        RETURNING l_success,l_pmdn202
                        #150903-00007#1 150903 by sakura add(S)
                        IF l_success = FALSE THEN
                           CALL s_transaction_end('N','0')
                           EXIT DIALOG
                        END IF
                        #150903-00007#1 150903 by sakura add(E)
                  END IF
                  #計算計價數量
                  IF NOT cl_null(g_pmdn_d[g_detail_idx].pmdn010) THEN
                     CALL s_aooi250_convert_qty(g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn010,l_pmdn007)
                        RETURNING l_success,l_pmdn011
                        #150903-00007#1 150903 by sakura add(S)
                        IF l_success = FALSE THEN
                           CALL s_transaction_end('N','0')
                           EXIT DIALOG
                        END IF
                        #150903-00007#1 150903 by sakura add(E)
                  END IF
                  #150407-00020#1 Mark_S By Ken 150410
                  ##取的訂單有效期
                  #CALL s_apmt840_get_rtka(g_pmdn_d[g_detail_idx].pmdnunit,g_pmdl_m.pmdl004)
                  #   RETURNING l_rtka010,l_rtka012
                  ##採購失效日(到庫日期+訂單有效期)
                  #LET l_pmdn224 = l_pmdn014 + l_rtka010
                  #150407-00020#1 Mark_E
                  #取得未稅金額、稅額、含稅金額
                  CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdn_d[g_detail_idx].pmdn007,g_pmdn_d[g_detail_idx].pmdn015,g_pmdn_d[g_detail_idx].pmdn016)
                     RETURNING l_pmdn046,l_pmdn048,l_pmdn047
                  
                  #150324-00006#16 2015/04/30 By pomelo add(S)
                  IF s_apmt840_get_pmdb033(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq) THEN
                  #150324-00006#16 2015/04/30 By pomelo add(E)
                     #緊急度
                     IF NOT cl_null(l_pmdn020) AND l_pmdn020 = '2'
                        AND g_pmdn_d[g_detail_idx].pmdn020 = '1' THEN
                        LET g_pmdn_d[g_detail_idx].pmdn020 = '2'
                     END IF
                  #150324-00006#16 2015/04/30 By pomelo add(S)
                  ELSE
                     LET l_pmdn020 = g_pmdn_d[g_detail_idx].pmdn020
                  END IF
                  #150324-00006#16 2015/04/30 By pomelo add(E)
                     
                  UPDATE pmdn_t
                     SET pmdn012 = l_pmdn014,   #出貨日期
                         pmdn013 = l_pmdn014,   #到廠日期
                         pmdn014 = l_pmdn014,   #到庫日期
                         pmdn007 = l_pmdn007,   #採購數量
                         pmdn011 = l_pmdn011,   #計價數量
                         pmdn020 = l_pmdn020,   #緊急度
                         pmdn024 = l_pmdn024,   #多交期
                         pmdn046 = l_pmdn046,   #未稅金額
                         pmdn048 = l_pmdn048,   #稅額
                         pmdn047 = l_pmdn047,   #含稅金額
                         pmdn202 = l_pmdn202    #包裝數量
                         #pmdn224 = l_pmdn224    #採購失效日 #150407-00020#1 Mark By Ken 150410
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_pmdl_m.pmdldocno
                     AND pmdnseq = g_pmdn_d[g_detail_idx].pmdnseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "Update pmdn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
                  #計算單據總金額
                  CALL s_tax_recount(g_pmdl_m.pmdldocno)
                     RETURNING l_xrcd103,l_xrcd104,l_xrcd105,l_xrcd113,l_xrcd114,l_xrcd115
                  UPDATE pmdl_t SET pmdl040 = l_xrcd103,
                                    pmdl042 = l_xrcd104,
                                    pmdl041 = l_xrcd105
                   WHERE pmdlent = g_enterprise
                     AND pmdldocno = g_pmdl_m.pmdldocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "Update pmdl_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
                  LET g_pmdl_m.pmdl040 = l_xrcd103
                  LET g_pmdl_m.pmdl042 = l_xrcd104
                  LET g_pmdl_m.pmdl041 = l_xrcd105
                  DISPLAY BY NAME g_pmdl_m.pmdl040,g_pmdl_m.pmdl042,g_pmdl_m.pmdl041
                  CALL s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq) RETURNING l_success
                  IF l_success = FALSE THEN
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
                  CALL apmt840_b_fill()
                  CALL s_transaction_end('Y','0')
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_pmdn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt840_idx_chk()
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
               CALL apmt840_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_pmdn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt840_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
                                             #IF l_ac > 1 THEN
               #   IF g_pmdn3_d[l_ac].pmdoseq = g_pmdn3_d[l_ac-1].pmdoseq 
               #     AND g_pmdn3_d[l_ac].pmdoseq1 = g_pmdn3_d[l_ac-1].pmdoseq1
               #     AND g_pmdn3_d[l_ac].pmdo003 = g_pmdn3_d[l_ac-1].pmdo003
               #     AND g_pmdn3_d[l_ac].pmdo001 = g_pmdn3_d[l_ac-1].pmdo001
               #     AND g_pmdn3_d[l_ac].pmdo002 = g_pmdn3_d[l_ac-1].pmdo002
               #     AND g_pmdn3_d[l_ac].pmdo004 = g_pmdn3_d[l_ac-1].pmdo004
               #     AND g_pmdn3_d[l_ac].pmdo005 = g_pmdn3_d[l_ac-1].pmdo005 THEN
               #     DISPLAY '' TO s_detail3[l_ac].pmdoseq
               #     DISPLAY '' TO s_detail3[l_ac].pmdoseq1
               #     DISPLAY '' TO s_detail3[l_ac].pmdo003
               #     DISPLAY '' TO s_detail3[l_ac].pmdo002
               #     DISPLAY '' TO s_detail3[l_ac].pmdo004
               #     DISPLAY '' TO s_detail3[l_ac].pmdo005
               #   END IF
               #END IF
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL apmt840_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_pmdn6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt840_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body6.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 4
               #顯示單身筆數
               CALL apmt840_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body6.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body6.action"
                        
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                  
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt840_browser_fill("")
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
               CALL apmt840_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt840_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt840_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #150519-00015#1 150520 By pomelo add(S)
            CALL apmt840_set_act_visible()
            CALL apmt840_set_act_no_visible()
            #150519-00015#1 150520 By pomelo add(E)
            CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt840_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt840_set_act_visible()   
            CALL apmt840_set_act_no_visible()
            IF NOT (g_pmdl_m.pmdldocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmdlent = " ||g_enterprise|| " AND",
                                  " pmdldocno = '", g_pmdl_m.pmdldocno, "' "
 
               #填到對應位置
               CALL apmt840_browser_fill("")
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
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdn_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmdo_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmdm_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL apmt840_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmdl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdn_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmdo_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "pmdm_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL apmt840_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt840_fetch("F")
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
               CALL apmt840_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt840_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt840_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt840_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt840_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt840_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt840_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt840_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt840_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt840_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt840_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmdn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pmdn2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_pmdn3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_pmdn6_d)
                  LET g_export_id[4]   = "s_detail6"
 
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
               NEXT FIELD pmdnseq
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
               CALL apmt840_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL gfrm_curr.ensureFieldVisible(g_field)     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt840_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               CALL aooi360_02('6',g_prog,g_pmdl_m.pmdldocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_detail
            LET g_action_choice="gen_detail"
            IF cl_auth_chk_act("gen_detail") THEN
               
               #add-point:ON ACTION gen_detail name="menu.gen_detail"
               #150512-00029#2 150525 By pomelo add(S)
               #當不為長效期訂單時，只能手動自己輸入單身 或 使用門店清單輸入單身
               IF g_pmdl_m.pmdl206 = 'N' THEN
               #150512-00029#2 150525 By pomelo add(E)
                  #單身如果有資料
                  LET l_cnt = 0
                  SELECT COUNT(pmdnseq) INTO l_cnt
                    FROM pmdn_t
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_pmdl_m.pmdldocno
                  #詢問使用者是否刪除單身資料重新產生
                  IF l_cnt >= 1 THEN
                     #單身已經有資料，如果要重新產生單身，單身資料會全部刪除後，重新產生，是否要重新產生單身?
                     IF NOT cl_ask_confirm('apm-00706') THEN
                        CONTINUE DIALOG
                     END IF
                  END IF
                  #CALL 批次產生單身
                  IF g_pmdl_m.pmdl203 = '0' THEN
                     #自訂貨批次拋轉
                     LET la_param.prog = 'apmp841'
                     LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                     LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                     LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                     LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                     LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                     LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                     LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                     LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                     LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#3 160126 by sakura add
                     LET ls_js = util.JSON.stringify(la_param)
                     DISPLAY "ls_js:",ls_js
                     CALL cl_cmdrun_wait(ls_js)
                  ELSE
                     #統採批次拋轉
                     LET la_param.prog = 'apmp840'
                     LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                     LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                     LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                     LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                     LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                     LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                     LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                     LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                     LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#2 151203 by sakura add
                     LET ls_js = util.JSON.stringify(la_param)
                     DISPLAY "ls_js:",ls_js
                     CALL cl_cmdrun_wait(ls_js)
                  END IF
                  
                  #單身有資料才做更新單頭的動作
                  LET l_cnt = 0
                  SELECT COUNT(pmdnseq) INTO l_cnt
                    FROM pmdn_t
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_pmdl_m.pmdldocno
                  #詢問使用者是否刪除單身資料重新產生
                  IF l_cnt >= 1 THEN                  
                     #150407-00020#1 Add By Ken 151208(S)
                     IF s_transaction_chk("N",0) THEN
                        CALL s_transaction_begin()
                     END IF                     
                     #150407-00020#1 Add By Ken 151208(E)
                     IF g_pmdl_m.pmdl203 = '0' THEN                  
                        LET l_success = ''
                        CALL s_apmp841_pmdl205_upd(g_pmdl_m.pmdldocno) RETURNING l_success                  
                        
                        LET l_success = ''
                        CALL s_apmp840_sum_money(g_pmdl_m.pmdldocno) RETURNING l_success                    
                        
                        LET l_success = ''
                        CALL s_apmp841_pmdl008_upd(g_pmdl_m.pmdldocno) RETURNING l_success   
                     ELSE
                        #更新單頭欄位
                        LET l_success = ''
                        CALL s_apmp840_upd_pmdl(g_pmdl_m.pmdldocno)
                           RETURNING l_success                     
                     END IF      
                     #150407-00020#1 Add By Ken 151208(S)
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF    
                     #150407-00020#1 Add By Ken 151208(E)
                  END IF
                  CALL apmt840_sel_money()
                  CALL apmt840_b_fill()
               END IF   #150512-00029#2 150525 By pomelo add
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmi004_01
            LET g_action_choice="open_apmi004_01"
            IF cl_auth_chk_act("open_apmi004_01") THEN
               
               #add-point:ON ACTION open_apmi004_01 name="menu.open_apmi004_01"
               #若輸入供應商的法人類型為'2:一次性交易'或是'4:內部員工'時，則自動串apmi004_01
               #維護一次性交易對項基本資料，維護完基本資料後會回傳一個一次性交易對象識別碼，
               #將識別碼值預設給pmdl028欄位
               IF NOT cl_null(g_pmdl_m.pmdl004) THEN
                  LET l_pmaa004 = ''
                  SELECT pmaa004 INTO l_pmaa004
                    FROM pmaa_t
                   WHERE pmaaent = g_enterprise
                     AND pmaa001 = g_pmdl_m.pmdl004
                  IF l_pmaa004 = '2' THEN   #一次性交易對象
                     CALL apmi004_01('1',g_pmdl_m.pmdl028,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocno) RETURNING g_pmdl_m.pmdl028
                  END IF
                  IF l_pmaa004 = '4' THEN   #內部員工
                     CALL apmi004_01('2',g_pmdl_m.pmdl028,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocno) RETURNING g_pmdl_m.pmdl028
                  END IF
               END IF
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page5
            LET g_action_choice="touch_page5"
            IF cl_auth_chk_act("touch_page5") THEN
               
               #add-point:ON ACTION touch_page5 name="menu.touch_page5"
               LET g_touch = 5
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt840_delete()
               #add-point:ON ACTION delete name="menu.delete"
                        
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt840_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")        
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmt840_s01
            LET g_action_choice="open_apmt840_s01"
            IF cl_auth_chk_act("open_apmt840_s01") THEN
               
               #add-point:ON ACTION open_apmt840_s01 name="menu.open_apmt840_s01"
               IF NOT cl_null(g_pmdl_m.pmdldocno) THEN
                  CALL apmt840_show_pmdp(g_pmdl_m.pmdldocno,'')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                #140530 mark gr
                #CALL apmr500_g01("pmdlent = "|| g_enterprise ||" AND pmdldocno = '"||g_pmdl_m.pmdldocno||"'",'') 
                LET g_rep_wc = "pmdlent = "|| g_enterprise ||" AND pmdldocno = '"||g_pmdl_m.pmdldocno||"'"                
                #140530 add xg
                #CALL apmr500_x01("pmdment = "|| g_enterprise )              
               #END add-point
               &include "erp/apm/apmt840_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                #140530 mark gr
                #CALL apmr500_g01("pmdlent = "|| g_enterprise ||" AND pmdldocno = '"||g_pmdl_m.pmdldocno||"'",'') 
                LET g_rep_wc = "pmdlent = "|| g_enterprise ||" AND pmdldocno = '"||g_pmdl_m.pmdldocno||"'"                
                #140530 add xg
                #CALL apmr500_x01("pmdment = "|| g_enterprise )              
               #END add-point
               &include "erp/apm/apmt840_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt840_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pmdm
            LET g_action_choice="open_pmdm"
            IF cl_auth_chk_act("open_pmdm") THEN
               
               #add-point:ON ACTION open_pmdm name="menu.open_pmdm"
               CALL apmt840_open_pmdm()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt840_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page2
            LET g_action_choice="touch_page2"
            IF cl_auth_chk_act("touch_page2") THEN
               
               #add-point:ON ACTION touch_page2 name="menu.touch_page2"
               LET g_touch = 2
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
            IF cl_auth_chk_act("touch_page1") THEN
               
               #add-point:ON ACTION touch_page1 name="menu.touch_page1"
               LET g_touch = 1
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page4
            LET g_action_choice="touch_page4"
            IF cl_auth_chk_act("touch_page4") THEN
               
               #add-point:ON ACTION touch_page4 name="menu.touch_page4"
               LET g_touch = 4
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page3
            LET g_action_choice="touch_page3"
            IF cl_auth_chk_act("touch_page3") THEN
               
               #add-point:ON ACTION touch_page3 name="menu.touch_page3"
               LET g_touch = 3
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmdl002
            LET g_action_choice="prog_pmdl002"
            IF cl_auth_chk_act("prog_pmdl002") THEN
               
               #add-point:ON ACTION prog_pmdl002 name="menu.prog_pmdl002"
                CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmdl_m.pmdl002)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmdl008
            LET g_action_choice="prog_pmdl008"
            IF cl_auth_chk_act("prog_pmdl008") THEN
               
               #add-point:ON ACTION prog_pmdl008 name="menu.prog_pmdl008"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               #150416-00001#1 150818 by sakura add(S)
               CASE g_pmdl_m.pmdl007
                  WHEN '2'
                     IF cl_null(g_pmdl_m.pmdl008) THEN
                       EXIT DIALOG
                     ELSE
                       LET la_param.prog     = 'apmt830'
                     END IF
                  WHEN '7'
                     LET la_param.prog     = 'apmt890'
                  OTHERWISE
                     EXIT DIALOG
               END CASE               
               #150416-00001#1 150818 by sakura add(E)
               LET la_param.param[1] = g_pmdl_m.pmdl008

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmdl027
            LET g_action_choice="prog_pmdl027"
            IF cl_auth_chk_act("prog_pmdl027") THEN
               
               #add-point:ON ACTION prog_pmdl027 name="menu.prog_pmdl027"
               CALL cl_user_contact("apmi005", "pmaj_t", "pmaj002", "pmaj001",'')                
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt840_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt840_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt840_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmdl_m.pmdldocdt)
 
 
 
         
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
 
{<section id="apmt840.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt840_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
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
   CALL s_aooi500_sql_where(g_prog,'pmdlsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   #160510-00043#2--(S)
   IF NOT cl_null(g_slip_wc) THEN
      LET g_wc = g_wc," AND ",g_slip_wc
   END IF   
   #160510-00043#2--(E)
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmdldocno ",
                      " FROM pmdl_t ",
                      " ",
                      " LEFT JOIN pmdn_t ON pmdnent = pmdlent AND pmdldocno = pmdndocno ", "  ",
                      #add-point:browser_fill段sql(pmdn_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xrcd_t ON xrcdent = pmdlent AND pmdldocno = xrcddocno", "  ",
                      #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.cnt.join.xrcd_t1"
                      "    AND xrcdseq = pmdnseq",
                      #end add-point
 
                      " LEFT JOIN pmdo_t ON pmdoent = pmdlent AND pmdldocno = pmdodocno", "  ",
                      #add-point:browser_fill段sql(pmdo_t1) name="browser_fill.cnt.join.pmdo_t1"
                      "    AND pmdoseq = pmdnseq",  
                      #end add-point
 
                      " LEFT JOIN pmdm_t ON pmdment = pmdlent AND pmdldocno = pmdmdocno", "  ",
                      #add-point:browser_fill段sql(pmdm_t1) name="browser_fill.cnt.join.pmdm_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE pmdlent = " ||g_enterprise|| " AND pmdnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmdl_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmdldocno ",
                      " FROM pmdl_t ", 
                      "  ",
                      "  ",
                      " WHERE pmdlent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmdl_t")
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
      INITIALIZE g_pmdl_m.* TO NULL
      CALL g_pmdn_d.clear()        
      CALL g_pmdn2_d.clear() 
      CALL g_pmdn3_d.clear() 
      CALL g_pmdn6_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmdldocno,t0.pmdldocdt,t0.pmdl001,t0.pmdl002,t0.pmdl003,t0.pmdl004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdlstus,t0.pmdldocno,t0.pmdldocdt,t0.pmdl001,t0.pmdl002,t0.pmdl003, 
          t0.pmdl004,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ",
                  " FROM pmdl_t t0",
                  "  ",
                  "  LEFT JOIN pmdn_t ON pmdnent = pmdlent AND pmdldocno = pmdndocno ", "  ", 
                  #add-point:browser_fill段sql(pmdn_t1) name="browser_fill.join.pmdn_t1"
                  
                  #end add-point
                  "  LEFT JOIN xrcd_t ON xrcdent = pmdlent AND pmdldocno = xrcddocno", "  ", 
                  #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.join.xrcd_t1"
               "    AND xrcdseq = pmdnseq",
                  #end add-point
 
                  "  LEFT JOIN pmdo_t ON pmdoent = pmdlent AND pmdldocno = pmdodocno", "  ", 
                  #add-point:browser_fill段sql(pmdo_t1) name="browser_fill.join.pmdo_t1"
               "    AND pmdoseq = pmdnseq",  
                  #end add-point
 
                  "  LEFT JOIN pmdm_t ON pmdment = pmdlent AND pmdldocno = pmdmdocno", "  ", 
                  #add-point:browser_fill段sql(pmdm_t1) name="browser_fill.join.pmdm_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmdl002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmdl003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.pmdl004 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdlent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmdl_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdlstus,t0.pmdldocno,t0.pmdldocdt,t0.pmdl001,t0.pmdl002,t0.pmdl003, 
          t0.pmdl004,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ",
                  " FROM pmdl_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmdl002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmdl003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.pmdl004 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdlent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmdl_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmdldocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
      
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmdl_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmdldocno,g_browser[g_cnt].b_pmdldocdt, 
          g_browser[g_cnt].b_pmdl001,g_browser[g_cnt].b_pmdl002,g_browser[g_cnt].b_pmdl003,g_browser[g_cnt].b_pmdl004, 
          g_browser[g_cnt].b_pmdl002_desc,g_browser[g_cnt].b_pmdl003_desc,g_browser[g_cnt].b_pmdl004_desc 
 
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
         CALL apmt840_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "H"
            LET g_browser[g_cnt].b_statepic = "stus/16/hold.png"
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
   
   IF cl_null(g_browser[g_cnt].b_pmdldocno) THEN
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
 
{<section id="apmt840.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt840_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmdl_m.pmdldocno = g_browser[g_current_idx].b_pmdldocno   
 
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
   CALL apmt840_pmdl_t_mask()
   CALL apmt840_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt840.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt840_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
      
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt840_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmdldocno = g_pmdl_m.pmdldocno 
 
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
 
{<section id="apmt840.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt840_construct()
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
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_sys       LIKE type_t.num5 #150610-00030#1 150612 by sakura add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_pmdl_m.* TO NULL
   CALL g_pmdn_d.clear()        
   CALL g_pmdn2_d.clear() 
   CALL g_pmdn3_d.clear() 
   CALL g_pmdn6_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON pmdlsite,pmdldocdt,pmdldocno,pmdl001,pmdl005,pmdl200,pmdl004,pmdl203, 
          pmdl002,pmdl003,pmdlstus,pmdl007,pmdl008,pmdl027,pmdl201,pmdl202,pmdl204,pmdl207,pmdlunit, 
          pmdl029,pmdl025,pmdl206,pmdl205,pmdl023,pmdl022,pmdl021,pmdl047,pmdl054,pmdl055,pmdl009,pmdl015, 
          pmdl016,pmdl010,pmdl011,pmdl012,pmdl013,pmdl033,pmdl024,pmdl043,pmdl020,pmdl044,pmdl006,pmdl028, 
          pmdl042,pmdl048,pmdl049,pmdl046,pmdl040,pmdl041,pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt, 
          pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmdlcrtdt>>----
         AFTER FIELD pmdlcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmdlmoddt>>----
         AFTER FIELD pmdlmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdlcnfdt>>----
         AFTER FIELD pmdlcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdlpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmdlsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlsite
            #add-point:ON ACTION controlp INFIELD pmdlsite name="construct.c.pmdlsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlsite  #顯示到畫面上
            NEXT FIELD pmdlsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlsite
            #add-point:BEFORE FIELD pmdlsite name="construct.b.pmdlsite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlsite
            
            #add-point:AFTER FIELD pmdlsite name="construct.a.pmdlsite"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocdt
            #add-point:BEFORE FIELD pmdldocdt name="construct.b.pmdldocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocdt
            
            #add-point:AFTER FIELD pmdldocdt name="construct.a.pmdldocdt"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocdt
            #add-point:ON ACTION controlp INFIELD pmdldocdt name="construct.c.pmdldocdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocno
            #add-point:ON ACTION controlp INFIELD pmdldocno name="construct.c.pmdldocno"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#160510-00043#2--(S)
            IF NOT cl_null(g_slip_wc) THEN
               LET g_qryparam.where = g_slip_wc
            END IF   
            #160510-00043#2--(E)
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdldocno  #顯示到畫面上

            NEXT FIELD pmdldocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocno
            #add-point:BEFORE FIELD pmdldocno name="construct.b.pmdldocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocno
            
            #add-point:AFTER FIELD pmdldocno name="construct.a.pmdldocno"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl001
            #add-point:BEFORE FIELD pmdl001 name="construct.b.pmdl001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl001
            
            #add-point:AFTER FIELD pmdl001 name="construct.a.pmdl001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl001
            #add-point:ON ACTION controlp INFIELD pmdl001 name="construct.c.pmdl001"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl005
            #add-point:BEFORE FIELD pmdl005 name="construct.b.pmdl005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl005
            
            #add-point:AFTER FIELD pmdl005 name="construct.a.pmdl005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl005
            #add-point:ON ACTION controlp INFIELD pmdl005 name="construct.c.pmdl005"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl200
            #add-point:ON ACTION controlp INFIELD pmdl200 name="construct.c.pmdl200"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdl200') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl200',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef303 = 'Y'"
               CALL q_ooef001()                    #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO pmdl200  #顯示到畫面上
            NEXT FIELD pmdl200                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl200
            #add-point:BEFORE FIELD pmdl200 name="construct.b.pmdl200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl200
            
            #add-point:AFTER FIELD pmdl200 name="construct.a.pmdl200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl004
            #add-point:ON ACTION controlp INFIELD pmdl004 name="construct.c.pmdl004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl004  #顯示到畫面上
            NEXT FIELD pmdl004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl004
            #add-point:BEFORE FIELD pmdl004 name="construct.b.pmdl004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl004
            
            #add-point:AFTER FIELD pmdl004 name="construct.a.pmdl004"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl203
            #add-point:BEFORE FIELD pmdl203 name="construct.b.pmdl203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl203
            
            #add-point:AFTER FIELD pmdl203 name="construct.a.pmdl203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl203
            #add-point:ON ACTION controlp INFIELD pmdl203 name="construct.c.pmdl203"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl002
            #add-point:ON ACTION controlp INFIELD pmdl002 name="construct.c.pmdl002"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl002  #顯示到畫面上

            NEXT FIELD pmdl002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl002
            #add-point:BEFORE FIELD pmdl002 name="construct.b.pmdl002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl002
            
            #add-point:AFTER FIELD pmdl002 name="construct.a.pmdl002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl003
            #add-point:ON ACTION controlp INFIELD pmdl003 name="construct.c.pmdl003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl003  #顯示到畫面上
            NEXT FIELD pmdl003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl003
            #add-point:BEFORE FIELD pmdl003 name="construct.b.pmdl003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl003
            
            #add-point:AFTER FIELD pmdl003 name="construct.a.pmdl003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlstus
            #add-point:BEFORE FIELD pmdlstus name="construct.b.pmdlstus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlstus
            
            #add-point:AFTER FIELD pmdlstus name="construct.a.pmdlstus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlstus
            #add-point:ON ACTION controlp INFIELD pmdlstus name="construct.c.pmdlstus"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl007
            #add-point:BEFORE FIELD pmdl007 name="construct.b.pmdl007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl007
            
            #add-point:AFTER FIELD pmdl007 name="construct.a.pmdl007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl007
            #add-point:ON ACTION controlp INFIELD pmdl007 name="construct.c.pmdl007"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl008
            #add-point:ON ACTION controlp INFIELD pmdl008 name="construct.c.pmdl008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdl008()    #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl008  #顯示到畫面上
            NEXT FIELD pmdl008                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl008
            #add-point:BEFORE FIELD pmdl008 name="construct.b.pmdl008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl008
            
            #add-point:AFTER FIELD pmdl008 name="construct.a.pmdl008"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl027
            #add-point:BEFORE FIELD pmdl027 name="construct.b.pmdl027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl027
            
            #add-point:AFTER FIELD pmdl027 name="construct.a.pmdl027"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl027
            #add-point:ON ACTION controlp INFIELD pmdl027 name="construct.c.pmdl027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl201
            #add-point:BEFORE FIELD pmdl201 name="construct.b.pmdl201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl201
            
            #add-point:AFTER FIELD pmdl201 name="construct.a.pmdl201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl201
            #add-point:ON ACTION controlp INFIELD pmdl201 name="construct.c.pmdl201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl202
            #add-point:BEFORE FIELD pmdl202 name="construct.b.pmdl202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl202
            
            #add-point:AFTER FIELD pmdl202 name="construct.a.pmdl202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl202
            #add-point:ON ACTION controlp INFIELD pmdl202 name="construct.c.pmdl202"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl204
            #add-point:ON ACTION controlp INFIELD pmdl204 name="construct.c.pmdl204"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdl204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl204',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef302 = 'Y'"
               CALL q_ooef001()                    #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO pmdl204  #顯示到畫面上
            NEXT FIELD pmdl204                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl204
            #add-point:BEFORE FIELD pmdl204 name="construct.b.pmdl204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl204
            
            #add-point:AFTER FIELD pmdl204 name="construct.a.pmdl204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl207
            #add-point:ON ACTION controlp INFIELD pmdl207 name="construct.c.pmdl207"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #150610-00030#1 150612 By sakura add(S)            
            #取得品類管理層級
            CALL cl_get_para(g_enterprise,g_pmdl_m.pmdlsite,'E-CIR-0001') RETURNING l_sys
            LET g_qryparam.arg1 = l_sys            
            #150610-00030#1 150612 By sakura add(E)            
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl207  #顯示到畫面上
            NEXT FIELD pmdl207                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl207
            #add-point:BEFORE FIELD pmdl207 name="construct.b.pmdl207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl207
            
            #add-point:AFTER FIELD pmdl207 name="construct.a.pmdl207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdlunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlunit
            #add-point:ON ACTION controlp INFIELD pmdlunit name="construct.c.pmdlunit"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlunit',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlunit  #顯示到畫面上
            NEXT FIELD pmdlunit                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlunit
            #add-point:BEFORE FIELD pmdlunit name="construct.b.pmdlunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlunit
            
            #add-point:AFTER FIELD pmdlunit name="construct.a.pmdlunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl029
            #add-point:ON ACTION controlp INFIELD pmdl029 name="construct.c.pmdl029"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl029  #顯示到畫面上
            NEXT FIELD pmdl029                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl029
            #add-point:BEFORE FIELD pmdl029 name="construct.b.pmdl029"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl029
            
            #add-point:AFTER FIELD pmdl029 name="construct.a.pmdl029"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl025
            #add-point:ON ACTION controlp INFIELD pmdl025 name="construct.c.pmdl025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " oofb008 = '3' "  #出貨地址
            CALL q_oofb019_1()
            DISPLAY g_qryparam.return1 TO pmdl025
            NEXT FIELD pmdl025
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl025
            #add-point:BEFORE FIELD pmdl025 name="construct.b.pmdl025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl025
            
            #add-point:AFTER FIELD pmdl025 name="construct.a.pmdl025"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl206
            #add-point:BEFORE FIELD pmdl206 name="construct.b.pmdl206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl206
            
            #add-point:AFTER FIELD pmdl206 name="construct.a.pmdl206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl206
            #add-point:ON ACTION controlp INFIELD pmdl206 name="construct.c.pmdl206"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl205
            #add-point:BEFORE FIELD pmdl205 name="construct.b.pmdl205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl205
            
            #add-point:AFTER FIELD pmdl205 name="construct.a.pmdl205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl205
            #add-point:ON ACTION controlp INFIELD pmdl205 name="construct.c.pmdl205"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl023
            #add-point:ON ACTION controlp INFIELD pmdl023 name="construct.c.pmdl023"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "2"
            CALL q_oojd001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl023  #顯示到畫面上
            NEXT FIELD pmdl023                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl023
            #add-point:BEFORE FIELD pmdl023 name="construct.b.pmdl023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl023
            
            #add-point:AFTER FIELD pmdl023 name="construct.a.pmdl023"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl022
            #add-point:ON ACTION controlp INFIELD pmdl022 name="construct.c.pmdl022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmac003 = '2'"
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO pmdl022
            NEXT FIELD pmdl022
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl022
            #add-point:BEFORE FIELD pmdl022 name="construct.b.pmdl022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl022
            
            #add-point:AFTER FIELD pmdl022 name="construct.a.pmdl022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl021
            #add-point:ON ACTION controlp INFIELD pmdl021 name="construct.c.pmdl021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmac003 = '1'"
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO pmdl021
            NEXT FIELD pmdl021
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl021
            #add-point:BEFORE FIELD pmdl021 name="construct.b.pmdl021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl021
            
            #add-point:AFTER FIELD pmdl021 name="construct.a.pmdl021"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl047
            #add-point:BEFORE FIELD pmdl047 name="construct.b.pmdl047"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl047
            
            #add-point:AFTER FIELD pmdl047 name="construct.a.pmdl047"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl047
            #add-point:ON ACTION controlp INFIELD pmdl047 name="construct.c.pmdl047"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl054
            #add-point:BEFORE FIELD pmdl054 name="construct.b.pmdl054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl054
            
            #add-point:AFTER FIELD pmdl054 name="construct.a.pmdl054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl054
            #add-point:ON ACTION controlp INFIELD pmdl054 name="construct.c.pmdl054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl055
            #add-point:BEFORE FIELD pmdl055 name="construct.b.pmdl055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl055
            
            #add-point:AFTER FIELD pmdl055 name="construct.a.pmdl055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl055
            #add-point:ON ACTION controlp INFIELD pmdl055 name="construct.c.pmdl055"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl009
            #add-point:ON ACTION controlp INFIELD pmdl009 name="construct.c.pmdl009"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmad002_2()
            DISPLAY g_qryparam.return1 TO pmdl009
            NEXT FIELD pmdl009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl009
            #add-point:BEFORE FIELD pmdl009 name="construct.b.pmdl009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl009
            
            #add-point:AFTER FIELD pmdl009 name="construct.a.pmdl009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl015
            #add-point:ON ACTION controlp INFIELD pmdl015 name="construct.c.pmdl015"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO pmdl015
            NEXT FIELD pmdl015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl015
            #add-point:BEFORE FIELD pmdl015 name="construct.b.pmdl015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl015
            
            #add-point:AFTER FIELD pmdl015 name="construct.a.pmdl015"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl016
            #add-point:BEFORE FIELD pmdl016 name="construct.b.pmdl016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl016
            
            #add-point:AFTER FIELD pmdl016 name="construct.a.pmdl016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl016
            #add-point:ON ACTION controlp INFIELD pmdl016 name="construct.c.pmdl016"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl010
            #add-point:ON ACTION controlp INFIELD pmdl010 name="construct.c.pmdl010"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl010  #顯示到畫面上
            NEXT FIELD pmdl010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl010
            #add-point:BEFORE FIELD pmdl010 name="construct.b.pmdl010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl010
            
            #add-point:AFTER FIELD pmdl010 name="construct.a.pmdl010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl011
            #add-point:ON ACTION controlp INFIELD pmdl011 name="construct.c.pmdl011"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #CALL q_oodb002_2()                           #呼叫開窗
            CALL q_oodb002_11()
            DISPLAY g_qryparam.return1 TO pmdl011  #顯示到畫面上
            NEXT FIELD pmdl011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl011
            #add-point:BEFORE FIELD pmdl011 name="construct.b.pmdl011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl011
            
            #add-point:AFTER FIELD pmdl011 name="construct.a.pmdl011"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl012
            #add-point:BEFORE FIELD pmdl012 name="construct.b.pmdl012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl012
            
            #add-point:AFTER FIELD pmdl012 name="construct.a.pmdl012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl012
            #add-point:ON ACTION controlp INFIELD pmdl012 name="construct.c.pmdl012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl013
            #add-point:BEFORE FIELD pmdl013 name="construct.b.pmdl013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl013
            
            #add-point:AFTER FIELD pmdl013 name="construct.a.pmdl013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl013
            #add-point:ON ACTION controlp INFIELD pmdl013 name="construct.c.pmdl013"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl033
            #add-point:ON ACTION controlp INFIELD pmdl033 name="construct.c.pmdl033"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = "1"
            CALL q_isac002_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl033  #顯示到畫面上
            NEXT FIELD pmdl033                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl033
            #add-point:BEFORE FIELD pmdl033 name="construct.b.pmdl033"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl033
            
            #add-point:AFTER FIELD pmdl033 name="construct.a.pmdl033"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl024
            #add-point:ON ACTION controlp INFIELD pmdl024 name="construct.c.pmdl024"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "264"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl024  #顯示到畫面上 
            NEXT FIELD pmdl024                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl024
            #add-point:BEFORE FIELD pmdl024 name="construct.b.pmdl024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl024
            
            #add-point:AFTER FIELD pmdl024 name="construct.a.pmdl024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl043
            #add-point:ON ACTION controlp INFIELD pmdl043 name="construct.c.pmdl043"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.arg1 = "298"  #150908-00013#1 150910 by sakura mark
			   LET g_qryparam.arg1 = "317"  #150908-00013#1 150910 by sakura add 
            CALL q_oocq002()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdl043  #顯示到畫面上
            NEXT FIELD pmdl043                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl043
            #add-point:BEFORE FIELD pmdl043 name="construct.b.pmdl043"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl043
            
            #add-point:AFTER FIELD pmdl043 name="construct.a.pmdl043"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl020
            #add-point:ON ACTION controlp INFIELD pmdl020 name="construct.c.pmdl020"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "263"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO pmdl020
            NEXT FIELD pmdl020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl020
            #add-point:BEFORE FIELD pmdl020 name="construct.b.pmdl020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl020
            
            #add-point:AFTER FIELD pmdl020 name="construct.a.pmdl020"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl044
            #add-point:BEFORE FIELD pmdl044 name="construct.b.pmdl044"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl044
            
            #add-point:AFTER FIELD pmdl044 name="construct.a.pmdl044"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl044
            #add-point:ON ACTION controlp INFIELD pmdl044 name="construct.c.pmdl044"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl006
            #add-point:BEFORE FIELD pmdl006 name="construct.b.pmdl006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl006
            
            #add-point:AFTER FIELD pmdl006 name="construct.a.pmdl006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl006
            #add-point:ON ACTION controlp INFIELD pmdl006 name="construct.c.pmdl006"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl028
            #add-point:BEFORE FIELD pmdl028 name="construct.b.pmdl028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl028
            
            #add-point:AFTER FIELD pmdl028 name="construct.a.pmdl028"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl028
            #add-point:ON ACTION controlp INFIELD pmdl028 name="construct.c.pmdl028"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl042
            #add-point:BEFORE FIELD pmdl042 name="construct.b.pmdl042"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl042
            
            #add-point:AFTER FIELD pmdl042 name="construct.a.pmdl042"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl042
            #add-point:ON ACTION controlp INFIELD pmdl042 name="construct.c.pmdl042"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl048
            #add-point:BEFORE FIELD pmdl048 name="construct.b.pmdl048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl048
            
            #add-point:AFTER FIELD pmdl048 name="construct.a.pmdl048"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl048
            #add-point:ON ACTION controlp INFIELD pmdl048 name="construct.c.pmdl048"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl049
            #add-point:BEFORE FIELD pmdl049 name="construct.b.pmdl049"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl049
            
            #add-point:AFTER FIELD pmdl049 name="construct.a.pmdl049"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl049
            #add-point:ON ACTION controlp INFIELD pmdl049 name="construct.c.pmdl049"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl046
            #add-point:BEFORE FIELD pmdl046 name="construct.b.pmdl046"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl046
            
            #add-point:AFTER FIELD pmdl046 name="construct.a.pmdl046"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl046
            #add-point:ON ACTION controlp INFIELD pmdl046 name="construct.c.pmdl046"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl040
            #add-point:BEFORE FIELD pmdl040 name="construct.b.pmdl040"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl040
            
            #add-point:AFTER FIELD pmdl040 name="construct.a.pmdl040"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl040
            #add-point:ON ACTION controlp INFIELD pmdl040 name="construct.c.pmdl040"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl041
            #add-point:BEFORE FIELD pmdl041 name="construct.b.pmdl041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl041
            
            #add-point:AFTER FIELD pmdl041 name="construct.a.pmdl041"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl041
            #add-point:ON ACTION controlp INFIELD pmdl041 name="construct.c.pmdl041"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdlownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlownid
            #add-point:ON ACTION controlp INFIELD pmdlownid name="construct.c.pmdlownid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlownid  #顯示到畫面上

            NEXT FIELD pmdlownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlownid
            #add-point:BEFORE FIELD pmdlownid name="construct.b.pmdlownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlownid
            
            #add-point:AFTER FIELD pmdlownid name="construct.a.pmdlownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdlowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlowndp
            #add-point:ON ACTION controlp INFIELD pmdlowndp name="construct.c.pmdlowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlowndp  #顯示到畫面上

            NEXT FIELD pmdlowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlowndp
            #add-point:BEFORE FIELD pmdlowndp name="construct.b.pmdlowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlowndp
            
            #add-point:AFTER FIELD pmdlowndp name="construct.a.pmdlowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdlcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlcrtid
            #add-point:ON ACTION controlp INFIELD pmdlcrtid name="construct.c.pmdlcrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlcrtid  #顯示到畫面上

            NEXT FIELD pmdlcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlcrtid
            #add-point:BEFORE FIELD pmdlcrtid name="construct.b.pmdlcrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlcrtid
            
            #add-point:AFTER FIELD pmdlcrtid name="construct.a.pmdlcrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdlcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlcrtdp
            #add-point:ON ACTION controlp INFIELD pmdlcrtdp name="construct.c.pmdlcrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlcrtdp  #顯示到畫面上

            NEXT FIELD pmdlcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlcrtdp
            #add-point:BEFORE FIELD pmdlcrtdp name="construct.b.pmdlcrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlcrtdp
            
            #add-point:AFTER FIELD pmdlcrtdp name="construct.a.pmdlcrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlcrtdt
            #add-point:BEFORE FIELD pmdlcrtdt name="construct.b.pmdlcrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdlmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlmodid
            #add-point:ON ACTION controlp INFIELD pmdlmodid name="construct.c.pmdlmodid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlmodid  #顯示到畫面上

            NEXT FIELD pmdlmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlmodid
            #add-point:BEFORE FIELD pmdlmodid name="construct.b.pmdlmodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlmodid
            
            #add-point:AFTER FIELD pmdlmodid name="construct.a.pmdlmodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlmoddt
            #add-point:BEFORE FIELD pmdlmoddt name="construct.b.pmdlmoddt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.pmdlcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlcnfid
            #add-point:ON ACTION controlp INFIELD pmdlcnfid name="construct.c.pmdlcnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdlcnfid  #顯示到畫面上

            NEXT FIELD pmdlcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlcnfid
            #add-point:BEFORE FIELD pmdlcnfid name="construct.b.pmdlcnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlcnfid
            
            #add-point:AFTER FIELD pmdlcnfid name="construct.a.pmdlcnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlcnfdt
            #add-point:BEFORE FIELD pmdlcnfdt name="construct.b.pmdlcnfdt"
                        
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmdnseq,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016,pmdn017,pmdn227, 
          pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011,pmdn015,pmdn043,pmdn046, 
          pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn025_desc,l_pmdn025_addr,pmdn028,pmdn029, 
          pmdn029_desc,pmdn030,pmdn053,pmdnorga,pmdn026,pmdn026_desc,l_pmdn026_addr,pmdn024,pmdn014, 
          pmdn012,pmdn013,pmdn022,pmdn023,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212, 
          pmdn213,pmdn019,pmdn020,pmdn224,pmdn052,pmdn049,pmdn051,pmdn205,pmdn214,pmdn215,pmdn216,pmdn217, 
          pmdn218,pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn050
           FROM s_detail1[1].pmdnseq,s_detail1[1].pmdnsite,s_detail1[1].pmdn200,s_detail1[1].pmdn001, 
               s_detail1[1].pmdn228,s_detail1[1].pmdn002,s_detail1[1].pmdn016,s_detail1[1].pmdn017,s_detail1[1].pmdn227, 
               s_detail1[1].pmdn201,s_detail1[1].pmdn202,s_detail1[1].pmdn006,s_detail1[1].pmdn007,s_detail1[1].pmdn226, 
               s_detail1[1].pmdn008,s_detail1[1].pmdn009,s_detail1[1].pmdn010,s_detail1[1].pmdn011,s_detail1[1].pmdn015, 
               s_detail1[1].pmdn043,s_detail1[1].pmdn046,s_detail1[1].pmdn048,s_detail1[1].pmdn047,s_detail1[1].pmdnunit, 
               s_detail1[1].pmdn225,s_detail1[1].pmdn203,s_detail1[1].pmdn025,s_detail1[1].pmdn025_desc, 
               s_detail1[1].l_pmdn025_addr,s_detail1[1].pmdn028,s_detail1[1].pmdn029,s_detail1[1].pmdn029_desc, 
               s_detail1[1].pmdn030,s_detail1[1].pmdn053,s_detail1[1].pmdnorga,s_detail1[1].pmdn026, 
               s_detail1[1].pmdn026_desc,s_detail1[1].l_pmdn026_addr,s_detail1[1].pmdn024,s_detail1[1].pmdn014, 
               s_detail1[1].pmdn012,s_detail1[1].pmdn013,s_detail1[1].pmdn022,s_detail1[1].pmdn023,s_detail1[1].pmdn045, 
               s_detail1[1].pmdn206,s_detail1[1].pmdn207,s_detail1[1].pmdn208,s_detail1[1].pmdn209,s_detail1[1].pmdn210, 
               s_detail1[1].pmdn211,s_detail1[1].pmdn212,s_detail1[1].pmdn213,s_detail1[1].pmdn019,s_detail1[1].pmdn020, 
               s_detail1[1].pmdn224,s_detail1[1].pmdn052,s_detail1[1].pmdn049,s_detail1[1].pmdn051,s_detail1[1].pmdn205, 
               s_detail1[1].pmdn214,s_detail1[1].pmdn215,s_detail1[1].pmdn216,s_detail1[1].pmdn217,s_detail1[1].pmdn218, 
               s_detail1[1].pmdn219,s_detail1[1].pmdn220,s_detail1[1].pmdn221,s_detail1[1].pmdn222,s_detail1[1].pmdn223, 
               s_detail1[1].pmdn050
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnseq
            #add-point:BEFORE FIELD pmdnseq name="construct.b.page1.pmdnseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnseq
            
            #add-point:AFTER FIELD pmdnseq name="construct.a.page1.pmdnseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnseq
            #add-point:ON ACTION controlp INFIELD pmdnseq name="construct.c.page1.pmdnseq"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnsite
            #add-point:ON ACTION controlp INFIELD pmdnsite name="construct.c.page1.pmdnsite"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdnsite',g_pmdl_m.pmdlsite,'c')
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdnsite  #顯示到畫面上
            NEXT FIELD pmdnsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnsite
            #add-point:BEFORE FIELD pmdnsite name="construct.b.page1.pmdnsite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnsite
            
            #add-point:AFTER FIELD pmdnsite name="construct.a.page1.pmdnsite"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn200
            #add-point:ON ACTION controlp INFIELD pmdn200 name="construct.c.page1.pmdn200"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn200  #顯示到畫面上
            NEXT FIELD pmdn200                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn200
            #add-point:BEFORE FIELD pmdn200 name="construct.b.page1.pmdn200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn200
            
            #add-point:AFTER FIELD pmdn200 name="construct.a.page1.pmdn200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn001
            #add-point:ON ACTION controlp INFIELD pmdn001 name="construct.c.page1.pmdn001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn001  #顯示到畫面上
            NEXT FIELD pmdn001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn001
            #add-point:BEFORE FIELD pmdn001 name="construct.b.page1.pmdn001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn001
            
            #add-point:AFTER FIELD pmdn001 name="construct.a.page1.pmdn001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn228
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn228
            #add-point:ON ACTION controlp INFIELD pmdn228 name="construct.c.page1.pmdn228"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn228  #顯示到畫面上
            NEXT FIELD pmdn228                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn228
            #add-point:BEFORE FIELD pmdn228 name="construct.b.page1.pmdn228"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn228
            
            #add-point:AFTER FIELD pmdn228 name="construct.a.page1.pmdn228"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn002
            #add-point:BEFORE FIELD pmdn002 name="construct.b.page1.pmdn002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn002
            
            #add-point:AFTER FIELD pmdn002 name="construct.a.page1.pmdn002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn002
            #add-point:ON ACTION controlp INFIELD pmdn002 name="construct.c.page1.pmdn002"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn016
            #add-point:ON ACTION controlp INFIELD pmdn016 name="construct.c.page1.pmdn016"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #CALL q_oodb002_2()                           #呼叫開窗
            CALL q_oodb002_11()
            DISPLAY g_qryparam.return1 TO pmdn016  #顯示到畫面上

            NEXT FIELD pmdn016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn016
            #add-point:BEFORE FIELD pmdn016 name="construct.b.page1.pmdn016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn016
            
            #add-point:AFTER FIELD pmdn016 name="construct.a.page1.pmdn016"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn017
            #add-point:BEFORE FIELD pmdn017 name="construct.b.page1.pmdn017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn017
            
            #add-point:AFTER FIELD pmdn017 name="construct.a.page1.pmdn017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn017
            #add-point:ON ACTION controlp INFIELD pmdn017 name="construct.c.page1.pmdn017"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn227
            #add-point:BEFORE FIELD pmdn227 name="construct.b.page1.pmdn227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn227
            
            #add-point:AFTER FIELD pmdn227 name="construct.a.page1.pmdn227"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn227
            #add-point:ON ACTION controlp INFIELD pmdn227 name="construct.c.page1.pmdn227"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn201
            #add-point:ON ACTION controlp INFIELD pmdn201 name="construct.c.page1.pmdn201"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn201  #顯示到畫面上
            NEXT FIELD pmdn201                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn201
            #add-point:BEFORE FIELD pmdn201 name="construct.b.page1.pmdn201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn201
            
            #add-point:AFTER FIELD pmdn201 name="construct.a.page1.pmdn201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn202
            #add-point:BEFORE FIELD pmdn202 name="construct.b.page1.pmdn202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn202
            
            #add-point:AFTER FIELD pmdn202 name="construct.a.page1.pmdn202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn202
            #add-point:ON ACTION controlp INFIELD pmdn202 name="construct.c.page1.pmdn202"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn006
            #add-point:ON ACTION controlp INFIELD pmdn006 name="construct.c.page1.pmdn006"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn006  #顯示到畫面上

            NEXT FIELD pmdn006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn006
            #add-point:BEFORE FIELD pmdn006 name="construct.b.page1.pmdn006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn006
            
            #add-point:AFTER FIELD pmdn006 name="construct.a.page1.pmdn006"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn007
            #add-point:BEFORE FIELD pmdn007 name="construct.b.page1.pmdn007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn007
            
            #add-point:AFTER FIELD pmdn007 name="construct.a.page1.pmdn007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn007
            #add-point:ON ACTION controlp INFIELD pmdn007 name="construct.c.page1.pmdn007"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn226
            #add-point:BEFORE FIELD pmdn226 name="construct.b.page1.pmdn226"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn226
            
            #add-point:AFTER FIELD pmdn226 name="construct.a.page1.pmdn226"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn226
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn226
            #add-point:ON ACTION controlp INFIELD pmdn226 name="construct.c.page1.pmdn226"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn008
            #add-point:BEFORE FIELD pmdn008 name="construct.b.page1.pmdn008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn008
            
            #add-point:AFTER FIELD pmdn008 name="construct.a.page1.pmdn008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn008
            #add-point:ON ACTION controlp INFIELD pmdn008 name="construct.c.page1.pmdn008"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn008  #顯示到畫面上

            NEXT FIELD pmdn008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn009
            #add-point:BEFORE FIELD pmdn009 name="construct.b.page1.pmdn009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn009
            
            #add-point:AFTER FIELD pmdn009 name="construct.a.page1.pmdn009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn009
            #add-point:ON ACTION controlp INFIELD pmdn009 name="construct.c.page1.pmdn009"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn010
            #add-point:ON ACTION controlp INFIELD pmdn010 name="construct.c.page1.pmdn010"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn010  #顯示到畫面上

            NEXT FIELD pmdn010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn010
            #add-point:BEFORE FIELD pmdn010 name="construct.b.page1.pmdn010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn010
            
            #add-point:AFTER FIELD pmdn010 name="construct.a.page1.pmdn010"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn011
            #add-point:BEFORE FIELD pmdn011 name="construct.b.page1.pmdn011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn011
            
            #add-point:AFTER FIELD pmdn011 name="construct.a.page1.pmdn011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn011
            #add-point:ON ACTION controlp INFIELD pmdn011 name="construct.c.page1.pmdn011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn015
            #add-point:BEFORE FIELD pmdn015 name="construct.b.page1.pmdn015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn015
            
            #add-point:AFTER FIELD pmdn015 name="construct.a.page1.pmdn015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn015
            #add-point:ON ACTION controlp INFIELD pmdn015 name="construct.c.page1.pmdn015"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn043
            #add-point:BEFORE FIELD pmdn043 name="construct.b.page1.pmdn043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn043
            
            #add-point:AFTER FIELD pmdn043 name="construct.a.page1.pmdn043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn043
            #add-point:ON ACTION controlp INFIELD pmdn043 name="construct.c.page1.pmdn043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn046
            #add-point:BEFORE FIELD pmdn046 name="construct.b.page1.pmdn046"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn046
            
            #add-point:AFTER FIELD pmdn046 name="construct.a.page1.pmdn046"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn046
            #add-point:ON ACTION controlp INFIELD pmdn046 name="construct.c.page1.pmdn046"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn048
            #add-point:BEFORE FIELD pmdn048 name="construct.b.page1.pmdn048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn048
            
            #add-point:AFTER FIELD pmdn048 name="construct.a.page1.pmdn048"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn048
            #add-point:ON ACTION controlp INFIELD pmdn048 name="construct.c.page1.pmdn048"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn047
            #add-point:BEFORE FIELD pmdn047 name="construct.b.page1.pmdn047"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn047
            
            #add-point:AFTER FIELD pmdn047 name="construct.a.page1.pmdn047"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn047
            #add-point:ON ACTION controlp INFIELD pmdn047 name="construct.c.page1.pmdn047"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdnunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnunit
            #add-point:ON ACTION controlp INFIELD pmdnunit name="construct.c.page1.pmdnunit"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdnunit',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdnunit  #顯示到畫面上
            NEXT FIELD pmdnunit                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnunit
            #add-point:BEFORE FIELD pmdnunit name="construct.b.page1.pmdnunit"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnunit
            
            #add-point:AFTER FIELD pmdnunit name="construct.a.page1.pmdnunit"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn225
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn225
            #add-point:ON ACTION controlp INFIELD pmdn225 name="construct.c.page1.pmdn225"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdn225') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdn225',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()                    #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef211 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO pmdn225  #顯示到畫面上
            NEXT FIELD pmdn225                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn225
            #add-point:BEFORE FIELD pmdn225 name="construct.b.page1.pmdn225"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn225
            
            #add-point:AFTER FIELD pmdn225 name="construct.a.page1.pmdn225"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn203
            #add-point:ON ACTION controlp INFIELD pmdn203 name="construct.c.page1.pmdn203"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn203  #顯示到畫面上
            NEXT FIELD pmdn203                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn203
            #add-point:BEFORE FIELD pmdn203 name="construct.b.page1.pmdn203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn203
            
            #add-point:AFTER FIELD pmdn203 name="construct.a.page1.pmdn203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn025
            #add-point:ON ACTION controlp INFIELD pmdn025 name="construct.c.page1.pmdn025"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oofb008 = '3' "  #出貨地址
            CALL q_oofb019_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn025  #顯示到畫面上
            NEXT FIELD pmdn025                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn025
            #add-point:BEFORE FIELD pmdn025 name="construct.b.page1.pmdn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn025
            
            #add-point:AFTER FIELD pmdn025 name="construct.a.page1.pmdn025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn025_desc
            #add-point:BEFORE FIELD pmdn025_desc name="construct.b.page1.pmdn025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn025_desc
            
            #add-point:AFTER FIELD pmdn025_desc name="construct.a.page1.pmdn025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn025_desc
            #add-point:ON ACTION controlp INFIELD pmdn025_desc name="construct.c.page1.pmdn025_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdn025_addr
            #add-point:BEFORE FIELD l_pmdn025_addr name="construct.b.page1.l_pmdn025_addr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdn025_addr
            
            #add-point:AFTER FIELD l_pmdn025_addr name="construct.a.page1.l_pmdn025_addr"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_pmdn025_addr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdn025_addr
            #add-point:ON ACTION controlp INFIELD l_pmdn025_addr name="construct.c.page1.l_pmdn025_addr"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn028
            #add-point:ON ACTION controlp INFIELD pmdn028 name="construct.c.page1.pmdn028"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn028  #顯示到畫面上
            NEXT FIELD pmdn028                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn028
            #add-point:BEFORE FIELD pmdn028 name="construct.b.page1.pmdn028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn028
            
            #add-point:AFTER FIELD pmdn028 name="construct.a.page1.pmdn028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn029
            #add-point:ON ACTION controlp INFIELD pmdn029 name="construct.c.page1.pmdn029"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn029  #顯示到畫面上
            NEXT FIELD pmdn029                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn029
            #add-point:BEFORE FIELD pmdn029 name="construct.b.page1.pmdn029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn029
            
            #add-point:AFTER FIELD pmdn029 name="construct.a.page1.pmdn029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn029_desc
            #add-point:BEFORE FIELD pmdn029_desc name="construct.b.page1.pmdn029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn029_desc
            
            #add-point:AFTER FIELD pmdn029_desc name="construct.a.page1.pmdn029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn029_desc
            #add-point:ON ACTION controlp INFIELD pmdn029_desc name="construct.c.page1.pmdn029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn030
            #add-point:BEFORE FIELD pmdn030 name="construct.b.page1.pmdn030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn030
            
            #add-point:AFTER FIELD pmdn030 name="construct.a.page1.pmdn030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn030
            #add-point:ON ACTION controlp INFIELD pmdn030 name="construct.c.page1.pmdn030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn053
            #add-point:BEFORE FIELD pmdn053 name="construct.b.page1.pmdn053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn053
            
            #add-point:AFTER FIELD pmdn053 name="construct.a.page1.pmdn053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn053
            #add-point:ON ACTION controlp INFIELD pmdn053 name="construct.c.page1.pmdn053"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdnorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnorga
            #add-point:ON ACTION controlp INFIELD pmdnorga name="construct.c.page1.pmdnorga"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdnorga  #顯示到畫面上

            NEXT FIELD pmdnorga                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnorga
            #add-point:BEFORE FIELD pmdnorga name="construct.b.page1.pmdnorga"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnorga
            
            #add-point:AFTER FIELD pmdnorga name="construct.a.page1.pmdnorga"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn026
            #add-point:ON ACTION controlp INFIELD pmdn026 name="construct.c.page1.pmdn026"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oofb008 = '5' "  #帳款地址
            CALL q_oofb019_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn026  #顯示到畫面上
            NEXT FIELD pmdn026                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn026
            #add-point:BEFORE FIELD pmdn026 name="construct.b.page1.pmdn026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn026
            
            #add-point:AFTER FIELD pmdn026 name="construct.a.page1.pmdn026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn026_desc
            #add-point:BEFORE FIELD pmdn026_desc name="construct.b.page1.pmdn026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn026_desc
            
            #add-point:AFTER FIELD pmdn026_desc name="construct.a.page1.pmdn026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn026_desc
            #add-point:ON ACTION controlp INFIELD pmdn026_desc name="construct.c.page1.pmdn026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdn026_addr
            #add-point:BEFORE FIELD l_pmdn026_addr name="construct.b.page1.l_pmdn026_addr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdn026_addr
            
            #add-point:AFTER FIELD l_pmdn026_addr name="construct.a.page1.l_pmdn026_addr"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_pmdn026_addr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdn026_addr
            #add-point:ON ACTION controlp INFIELD l_pmdn026_addr name="construct.c.page1.l_pmdn026_addr"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn024
            #add-point:BEFORE FIELD pmdn024 name="construct.b.page1.pmdn024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn024
            
            #add-point:AFTER FIELD pmdn024 name="construct.a.page1.pmdn024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn024
            #add-point:ON ACTION controlp INFIELD pmdn024 name="construct.c.page1.pmdn024"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn014
            #add-point:BEFORE FIELD pmdn014 name="construct.b.page1.pmdn014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn014
            
            #add-point:AFTER FIELD pmdn014 name="construct.a.page1.pmdn014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn014
            #add-point:ON ACTION controlp INFIELD pmdn014 name="construct.c.page1.pmdn014"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn012
            #add-point:BEFORE FIELD pmdn012 name="construct.b.page1.pmdn012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn012
            
            #add-point:AFTER FIELD pmdn012 name="construct.a.page1.pmdn012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn012
            #add-point:ON ACTION controlp INFIELD pmdn012 name="construct.c.page1.pmdn012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn013
            #add-point:BEFORE FIELD pmdn013 name="construct.b.page1.pmdn013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn013
            
            #add-point:AFTER FIELD pmdn013 name="construct.a.page1.pmdn013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn013
            #add-point:ON ACTION controlp INFIELD pmdn013 name="construct.c.page1.pmdn013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn022
            #add-point:BEFORE FIELD pmdn022 name="construct.b.page1.pmdn022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn022
            
            #add-point:AFTER FIELD pmdn022 name="construct.a.page1.pmdn022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn022
            #add-point:ON ACTION controlp INFIELD pmdn022 name="construct.c.page1.pmdn022"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn023
            #add-point:ON ACTION controlp INFIELD pmdn023 name="construct.c.page1.pmdn023"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " pmac003 = '2' "
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO pmdn023
            NEXT FIELD pmdn023
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn023
            #add-point:BEFORE FIELD pmdn023 name="construct.b.page1.pmdn023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn023
            
            #add-point:AFTER FIELD pmdn023 name="construct.a.page1.pmdn023"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn045
            #add-point:BEFORE FIELD pmdn045 name="construct.b.page1.pmdn045"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn045
            
            #add-point:AFTER FIELD pmdn045 name="construct.a.page1.pmdn045"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn045
            #add-point:ON ACTION controlp INFIELD pmdn045 name="construct.c.page1.pmdn045"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn206
            #add-point:BEFORE FIELD pmdn206 name="construct.b.page1.pmdn206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn206
            
            #add-point:AFTER FIELD pmdn206 name="construct.a.page1.pmdn206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn206
            #add-point:ON ACTION controlp INFIELD pmdn206 name="construct.c.page1.pmdn206"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn207
            #add-point:BEFORE FIELD pmdn207 name="construct.b.page1.pmdn207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn207
            
            #add-point:AFTER FIELD pmdn207 name="construct.a.page1.pmdn207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn207
            #add-point:ON ACTION controlp INFIELD pmdn207 name="construct.c.page1.pmdn207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn208
            #add-point:BEFORE FIELD pmdn208 name="construct.b.page1.pmdn208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn208
            
            #add-point:AFTER FIELD pmdn208 name="construct.a.page1.pmdn208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn208
            #add-point:ON ACTION controlp INFIELD pmdn208 name="construct.c.page1.pmdn208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn209
            #add-point:BEFORE FIELD pmdn209 name="construct.b.page1.pmdn209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn209
            
            #add-point:AFTER FIELD pmdn209 name="construct.a.page1.pmdn209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn209
            #add-point:ON ACTION controlp INFIELD pmdn209 name="construct.c.page1.pmdn209"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn210
            #add-point:BEFORE FIELD pmdn210 name="construct.b.page1.pmdn210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn210
            
            #add-point:AFTER FIELD pmdn210 name="construct.a.page1.pmdn210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn210
            #add-point:ON ACTION controlp INFIELD pmdn210 name="construct.c.page1.pmdn210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn211
            #add-point:BEFORE FIELD pmdn211 name="construct.b.page1.pmdn211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn211
            
            #add-point:AFTER FIELD pmdn211 name="construct.a.page1.pmdn211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn211
            #add-point:ON ACTION controlp INFIELD pmdn211 name="construct.c.page1.pmdn211"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn212
            #add-point:BEFORE FIELD pmdn212 name="construct.b.page1.pmdn212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn212
            
            #add-point:AFTER FIELD pmdn212 name="construct.a.page1.pmdn212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn212
            #add-point:ON ACTION controlp INFIELD pmdn212 name="construct.c.page1.pmdn212"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn213
            #add-point:BEFORE FIELD pmdn213 name="construct.b.page1.pmdn213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn213
            
            #add-point:AFTER FIELD pmdn213 name="construct.a.page1.pmdn213"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn213
            #add-point:ON ACTION controlp INFIELD pmdn213 name="construct.c.page1.pmdn213"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn019
            #add-point:BEFORE FIELD pmdn019 name="construct.b.page1.pmdn019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn019
            
            #add-point:AFTER FIELD pmdn019 name="construct.a.page1.pmdn019"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn019
            #add-point:ON ACTION controlp INFIELD pmdn019 name="construct.c.page1.pmdn019"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn020
            #add-point:BEFORE FIELD pmdn020 name="construct.b.page1.pmdn020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn020
            
            #add-point:AFTER FIELD pmdn020 name="construct.a.page1.pmdn020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn020
            #add-point:ON ACTION controlp INFIELD pmdn020 name="construct.c.page1.pmdn020"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn224
            #add-point:BEFORE FIELD pmdn224 name="construct.b.page1.pmdn224"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn224
            
            #add-point:AFTER FIELD pmdn224 name="construct.a.page1.pmdn224"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn224
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn224
            #add-point:ON ACTION controlp INFIELD pmdn224 name="construct.c.page1.pmdn224"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn052
            #add-point:BEFORE FIELD pmdn052 name="construct.b.page1.pmdn052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn052
            
            #add-point:AFTER FIELD pmdn052 name="construct.a.page1.pmdn052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn052
            #add-point:ON ACTION controlp INFIELD pmdn052 name="construct.c.page1.pmdn052"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn049
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn049
            #add-point:ON ACTION controlp INFIELD pmdn049 name="construct.c.page1.pmdn049"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = apmt840_get_gzcb004()
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO pmdn049
            NEXT FIELD pmdn049
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn049
            #add-point:BEFORE FIELD pmdn049 name="construct.b.page1.pmdn049"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn049
            
            #add-point:AFTER FIELD pmdn049 name="construct.a.page1.pmdn049"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn051
            #add-point:ON ACTION controlp INFIELD pmdn051 name="construct.c.page1.pmdn051"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = apmt840_get_gzcb004()
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO pmdn051
            NEXT FIELD pmdn051
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn051
            #add-point:BEFORE FIELD pmdn051 name="construct.b.page1.pmdn051"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn051
            
            #add-point:AFTER FIELD pmdn051 name="construct.a.page1.pmdn051"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn205
            #add-point:ON ACTION controlp INFIELD pmdn205 name="construct.c.page1.pmdn205"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdn205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdn205',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef210 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO pmdn205
            NEXT FIELD pmdn205
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn205
            #add-point:BEFORE FIELD pmdn205 name="construct.b.page1.pmdn205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn205
            
            #add-point:AFTER FIELD pmdn205 name="construct.a.page1.pmdn205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn214
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn214
            #add-point:ON ACTION controlp INFIELD pmdn214 name="construct.c.page1.pmdn214"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            DISPLAY g_qryparam.return1 TO pmdn214
            NEXT FIELD pmdn214
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn214
            #add-point:BEFORE FIELD pmdn214 name="construct.b.page1.pmdn214"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn214
            
            #add-point:AFTER FIELD pmdn214 name="construct.a.page1.pmdn214"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn215
            #add-point:BEFORE FIELD pmdn215 name="construct.b.page1.pmdn215"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn215
            
            #add-point:AFTER FIELD pmdn215 name="construct.a.page1.pmdn215"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn215
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn215
            #add-point:ON ACTION controlp INFIELD pmdn215 name="construct.c.page1.pmdn215"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn216
            #add-point:BEFORE FIELD pmdn216 name="construct.b.page1.pmdn216"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn216
            
            #add-point:AFTER FIELD pmdn216 name="construct.a.page1.pmdn216"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn216
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn216
            #add-point:ON ACTION controlp INFIELD pmdn216 name="construct.c.page1.pmdn216"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdn217
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn217
            #add-point:ON ACTION controlp INFIELD pmdn217 name="construct.c.page1.pmdn217"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn217  #顯示到畫面上
            NEXT FIELD pmdn217                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn217
            #add-point:BEFORE FIELD pmdn217 name="construct.b.page1.pmdn217"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn217
            
            #add-point:AFTER FIELD pmdn217 name="construct.a.page1.pmdn217"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn218
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn218
            #add-point:ON ACTION controlp INFIELD pmdn218 name="construct.c.page1.pmdn218"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdxdocno_1()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn218  #顯示到畫面上
            NEXT FIELD pmdn218                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn218
            #add-point:BEFORE FIELD pmdn218 name="construct.b.page1.pmdn218"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn218
            
            #add-point:AFTER FIELD pmdn218 name="construct.a.page1.pmdn218"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn219
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn219
            #add-point:ON ACTION controlp INFIELD pmdn219 name="construct.c.page1.pmdn219"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_star001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn219  #顯示到畫面上
            NEXT FIELD pmdn219                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn219
            #add-point:BEFORE FIELD pmdn219 name="construct.b.page1.pmdn219"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn219
            
            #add-point:AFTER FIELD pmdn219 name="construct.a.page1.pmdn219"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn220
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn220
            #add-point:ON ACTION controlp INFIELD pmdn220 name="construct.c.page1.pmdn220"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn220  #顯示到畫面上
            NEXT FIELD pmdn220                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn220
            #add-point:BEFORE FIELD pmdn220 name="construct.b.page1.pmdn220"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn220
            
            #add-point:AFTER FIELD pmdn220 name="construct.a.page1.pmdn220"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn221
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn221
            #add-point:ON ACTION controlp INFIELD pmdn221 name="construct.c.page1.pmdn221"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdn221  #顯示到畫面上
            NEXT FIELD pmdn221                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn221
            #add-point:BEFORE FIELD pmdn221 name="construct.b.page1.pmdn221"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn221
            
            #add-point:AFTER FIELD pmdn221 name="construct.a.page1.pmdn221"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn222
            #add-point:BEFORE FIELD pmdn222 name="construct.b.page1.pmdn222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn222
            
            #add-point:AFTER FIELD pmdn222 name="construct.a.page1.pmdn222"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn222
            #add-point:ON ACTION controlp INFIELD pmdn222 name="construct.c.page1.pmdn222"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn223
            #add-point:BEFORE FIELD pmdn223 name="construct.b.page1.pmdn223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn223
            
            #add-point:AFTER FIELD pmdn223 name="construct.a.page1.pmdn223"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn223
            #add-point:ON ACTION controlp INFIELD pmdn223 name="construct.c.page1.pmdn223"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn050
            #add-point:BEFORE FIELD pmdn050 name="construct.b.page1.pmdn050"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn050
            
            #add-point:AFTER FIELD pmdn050 name="construct.a.page1.pmdn050"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdn050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn050
            #add-point:ON ACTION controlp INFIELD pmdn050 name="construct.c.page1.pmdn050"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xrcdsite,xrcdld,xrcdseq,xrcd007,pmdn2001,pmdn0011,pmdn0021,pmdn0021_desc, 
          xrcd002,xrcd002_desc,xrcdseq2,xrcd003,xrcd006,xrcd004,xrcd104
           FROM s_detail2[1].xrcdsite,s_detail2[1].xrcdld,s_detail2[1].xrcdseq,s_detail2[1].xrcd007, 
               s_detail2[1].pmdn2001,s_detail2[1].pmdn0011,s_detail2[1].pmdn0021,s_detail2[1].pmdn0021_desc, 
               s_detail2[1].xrcd002,s_detail2[1].xrcd002_desc,s_detail2[1].xrcdseq2,s_detail2[1].xrcd003, 
               s_detail2[1].xrcd006,s_detail2[1].xrcd004,s_detail2[1].xrcd104
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdsite
            #add-point:BEFORE FIELD xrcdsite name="construct.b.page2.xrcdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdsite
            
            #add-point:AFTER FIELD xrcdsite name="construct.a.page2.xrcdsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdsite
            #add-point:ON ACTION controlp INFIELD xrcdsite name="construct.c.page2.xrcdsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdld
            #add-point:BEFORE FIELD xrcdld name="construct.b.page2.xrcdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdld
            
            #add-point:AFTER FIELD xrcdld name="construct.a.page2.xrcdld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdld
            #add-point:ON ACTION controlp INFIELD xrcdld name="construct.c.page2.xrcdld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="construct.b.page2.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="construct.a.page2.xrcdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="construct.c.page2.xrcdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="construct.b.page2.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="construct.a.page2.xrcd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="construct.c.page2.xrcd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn2001
            #add-point:BEFORE FIELD pmdn2001 name="construct.b.page2.pmdn2001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn2001
            
            #add-point:AFTER FIELD pmdn2001 name="construct.a.page2.pmdn2001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdn2001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn2001
            #add-point:ON ACTION controlp INFIELD pmdn2001 name="construct.c.page2.pmdn2001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn0011
            #add-point:BEFORE FIELD pmdn0011 name="construct.b.page2.pmdn0011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn0011
            
            #add-point:AFTER FIELD pmdn0011 name="construct.a.page2.pmdn0011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdn0011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn0011
            #add-point:ON ACTION controlp INFIELD pmdn0011 name="construct.c.page2.pmdn0011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn0021
            #add-point:BEFORE FIELD pmdn0021 name="construct.b.page2.pmdn0021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn0021
            
            #add-point:AFTER FIELD pmdn0021 name="construct.a.page2.pmdn0021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdn0021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn0021
            #add-point:ON ACTION controlp INFIELD pmdn0021 name="construct.c.page2.pmdn0021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn0021_desc
            #add-point:BEFORE FIELD pmdn0021_desc name="construct.b.page2.pmdn0021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn0021_desc
            
            #add-point:AFTER FIELD pmdn0021_desc name="construct.a.page2.pmdn0021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdn0021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn0021_desc
            #add-point:ON ACTION controlp INFIELD pmdn0021_desc name="construct.c.page2.pmdn0021_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrcd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="construct.c.page2.xrcd002"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcd002  #顯示到畫面上
            NEXT FIELD xrcd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="construct.b.page2.xrcd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="construct.a.page2.xrcd002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002_desc
            #add-point:BEFORE FIELD xrcd002_desc name="construct.b.page2.xrcd002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002_desc
            
            #add-point:AFTER FIELD xrcd002_desc name="construct.a.page2.xrcd002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002_desc
            #add-point:ON ACTION controlp INFIELD xrcd002_desc name="construct.c.page2.xrcd002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="construct.b.page2.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="construct.a.page2.xrcdseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="construct.c.page2.xrcdseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="construct.b.page2.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="construct.a.page2.xrcd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="construct.c.page2.xrcd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="construct.b.page2.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="construct.a.page2.xrcd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="construct.c.page2.xrcd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd004
            #add-point:BEFORE FIELD xrcd004 name="construct.b.page2.xrcd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd004
            
            #add-point:AFTER FIELD xrcd004 name="construct.a.page2.xrcd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd004
            #add-point:ON ACTION controlp INFIELD xrcd004 name="construct.c.page2.xrcd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD xrcd104 name="construct.b.page2.xrcd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD xrcd104 name="construct.a.page2.xrcd104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd104
            #add-point:ON ACTION controlp INFIELD xrcd104 name="construct.c.page2.xrcd104"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON pmdosite,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,pmdo002,pmdo005,pmdn0141, 
          pmdo200,pmdo201,pmdo004,pmdo006,pmdo028,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010,pmdo009,pmdo015, 
          pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,pmdo031,pmdo022,pmdo023,pmdo024,pmdo032,pmdo033, 
          pmdo034,pmdo025,pmdo026,pmdo027
           FROM s_detail3[1].pmdosite,s_detail3[1].pmdoseq,s_detail3[1].pmdoseq1,s_detail3[1].pmdoseq2, 
               s_detail3[1].pmdo003,s_detail3[1].pmdo001,s_detail3[1].pmdo002,s_detail3[1].pmdo005,s_detail3[1].pmdn0141, 
               s_detail3[1].pmdo200,s_detail3[1].pmdo201,s_detail3[1].pmdo004,s_detail3[1].pmdo006,s_detail3[1].pmdo028, 
               s_detail3[1].pmdo029,s_detail3[1].pmdo013,s_detail3[1].pmdo011,s_detail3[1].pmdo012,s_detail3[1].pmdo010, 
               s_detail3[1].pmdo009,s_detail3[1].pmdo015,s_detail3[1].pmdo016,s_detail3[1].pmdo017,s_detail3[1].pmdo040, 
               s_detail3[1].pmdo019,s_detail3[1].pmdo021,s_detail3[1].pmdo030,s_detail3[1].pmdo031,s_detail3[1].pmdo022, 
               s_detail3[1].pmdo023,s_detail3[1].pmdo024,s_detail3[1].pmdo032,s_detail3[1].pmdo033,s_detail3[1].pmdo034, 
               s_detail3[1].pmdo025,s_detail3[1].pmdo026,s_detail3[1].pmdo027
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdosite
            #add-point:BEFORE FIELD pmdosite name="construct.b.page3.pmdosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdosite
            
            #add-point:AFTER FIELD pmdosite name="construct.a.page3.pmdosite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdosite
            #add-point:ON ACTION controlp INFIELD pmdosite name="construct.c.page3.pmdosite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdoseq
            #add-point:BEFORE FIELD pmdoseq name="construct.b.page3.pmdoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdoseq
            
            #add-point:AFTER FIELD pmdoseq name="construct.a.page3.pmdoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdoseq
            #add-point:ON ACTION controlp INFIELD pmdoseq name="construct.c.page3.pmdoseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdoseq1
            #add-point:BEFORE FIELD pmdoseq1 name="construct.b.page3.pmdoseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdoseq1
            
            #add-point:AFTER FIELD pmdoseq1 name="construct.a.page3.pmdoseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdoseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdoseq1
            #add-point:ON ACTION controlp INFIELD pmdoseq1 name="construct.c.page3.pmdoseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdoseq2
            #add-point:BEFORE FIELD pmdoseq2 name="construct.b.page3.pmdoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdoseq2
            
            #add-point:AFTER FIELD pmdoseq2 name="construct.a.page3.pmdoseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdoseq2
            #add-point:ON ACTION controlp INFIELD pmdoseq2 name="construct.c.page3.pmdoseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo003
            #add-point:BEFORE FIELD pmdo003 name="construct.b.page3.pmdo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo003
            
            #add-point:AFTER FIELD pmdo003 name="construct.a.page3.pmdo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo003
            #add-point:ON ACTION controlp INFIELD pmdo003 name="construct.c.page3.pmdo003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo001
            #add-point:ON ACTION controlp INFIELD pmdo001 name="construct.c.page3.pmdo001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdo001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo001  #顯示到畫面上

            NEXT FIELD pmdo001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo001
            #add-point:BEFORE FIELD pmdo001 name="construct.b.page3.pmdo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo001
            
            #add-point:AFTER FIELD pmdo001 name="construct.a.page3.pmdo001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo002
            #add-point:BEFORE FIELD pmdo002 name="construct.b.page3.pmdo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo002
            
            #add-point:AFTER FIELD pmdo002 name="construct.a.page3.pmdo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo002
            #add-point:ON ACTION controlp INFIELD pmdo002 name="construct.c.page3.pmdo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo005
            #add-point:BEFORE FIELD pmdo005 name="construct.b.page3.pmdo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo005
            
            #add-point:AFTER FIELD pmdo005 name="construct.a.page3.pmdo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo005
            #add-point:ON ACTION controlp INFIELD pmdo005 name="construct.c.page3.pmdo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn0141
            #add-point:BEFORE FIELD pmdn0141 name="construct.b.page3.pmdn0141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn0141
            
            #add-point:AFTER FIELD pmdn0141 name="construct.a.page3.pmdn0141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdn0141
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn0141
            #add-point:ON ACTION controlp INFIELD pmdn0141 name="construct.c.page3.pmdn0141"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo200
            #add-point:ON ACTION controlp INFIELD pmdo200 name="construct.c.page3.pmdo200"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo200  #顯示到畫面上
            NEXT FIELD pmdo200                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo200
            #add-point:BEFORE FIELD pmdo200 name="construct.b.page3.pmdo200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo200
            
            #add-point:AFTER FIELD pmdo200 name="construct.a.page3.pmdo200"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo201
            #add-point:BEFORE FIELD pmdo201 name="construct.b.page3.pmdo201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo201
            
            #add-point:AFTER FIELD pmdo201 name="construct.a.page3.pmdo201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo201
            #add-point:ON ACTION controlp INFIELD pmdo201 name="construct.c.page3.pmdo201"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo004
            #add-point:ON ACTION controlp INFIELD pmdo004 name="construct.c.page3.pmdo004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo004  #顯示到畫面上

            NEXT FIELD pmdo004                     #返回原欄位



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo004
            #add-point:BEFORE FIELD pmdo004 name="construct.b.page3.pmdo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo004
            
            #add-point:AFTER FIELD pmdo004 name="construct.a.page3.pmdo004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo006
            #add-point:BEFORE FIELD pmdo006 name="construct.b.page3.pmdo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo006
            
            #add-point:AFTER FIELD pmdo006 name="construct.a.page3.pmdo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo006
            #add-point:ON ACTION controlp INFIELD pmdo006 name="construct.c.page3.pmdo006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo028
            #add-point:ON ACTION controlp INFIELD pmdo028 name="construct.c.page3.pmdo028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo028  #顯示到畫面上

            NEXT FIELD pmdo028

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo028
            #add-point:BEFORE FIELD pmdo028 name="construct.b.page3.pmdo028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo028
            
            #add-point:AFTER FIELD pmdo028 name="construct.a.page3.pmdo028"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo029
            #add-point:BEFORE FIELD pmdo029 name="construct.b.page3.pmdo029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo029
            
            #add-point:AFTER FIELD pmdo029 name="construct.a.page3.pmdo029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo029
            #add-point:ON ACTION controlp INFIELD pmdo029 name="construct.c.page3.pmdo029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo013
            #add-point:BEFORE FIELD pmdo013 name="construct.b.page3.pmdo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo013
            
            #add-point:AFTER FIELD pmdo013 name="construct.a.page3.pmdo013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo013
            #add-point:ON ACTION controlp INFIELD pmdo013 name="construct.c.page3.pmdo013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo011
            #add-point:BEFORE FIELD pmdo011 name="construct.b.page3.pmdo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo011
            
            #add-point:AFTER FIELD pmdo011 name="construct.a.page3.pmdo011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo011
            #add-point:ON ACTION controlp INFIELD pmdo011 name="construct.c.page3.pmdo011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo012
            #add-point:BEFORE FIELD pmdo012 name="construct.b.page3.pmdo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo012
            
            #add-point:AFTER FIELD pmdo012 name="construct.a.page3.pmdo012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo012
            #add-point:ON ACTION controlp INFIELD pmdo012 name="construct.c.page3.pmdo012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo010
            #add-point:ON ACTION controlp INFIELD pmdo010 name="construct.c.page3.pmdo010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "274"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo010  #顯示到畫面上

            NEXT FIELD pmdo010                     #返回原欄位
            


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo010
            #add-point:BEFORE FIELD pmdo010 name="construct.b.page3.pmdo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo010
            
            #add-point:AFTER FIELD pmdo010 name="construct.a.page3.pmdo010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo009
            #add-point:BEFORE FIELD pmdo009 name="construct.b.page3.pmdo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo009
            
            #add-point:AFTER FIELD pmdo009 name="construct.a.page3.pmdo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo009
            #add-point:ON ACTION controlp INFIELD pmdo009 name="construct.c.page3.pmdo009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo015
            #add-point:BEFORE FIELD pmdo015 name="construct.b.page3.pmdo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo015
            
            #add-point:AFTER FIELD pmdo015 name="construct.a.page3.pmdo015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo015
            #add-point:ON ACTION controlp INFIELD pmdo015 name="construct.c.page3.pmdo015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo016
            #add-point:BEFORE FIELD pmdo016 name="construct.b.page3.pmdo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo016
            
            #add-point:AFTER FIELD pmdo016 name="construct.a.page3.pmdo016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo016
            #add-point:ON ACTION controlp INFIELD pmdo016 name="construct.c.page3.pmdo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo017
            #add-point:BEFORE FIELD pmdo017 name="construct.b.page3.pmdo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo017
            
            #add-point:AFTER FIELD pmdo017 name="construct.a.page3.pmdo017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo017
            #add-point:ON ACTION controlp INFIELD pmdo017 name="construct.c.page3.pmdo017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo040
            #add-point:BEFORE FIELD pmdo040 name="construct.b.page3.pmdo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo040
            
            #add-point:AFTER FIELD pmdo040 name="construct.a.page3.pmdo040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo040
            #add-point:ON ACTION controlp INFIELD pmdo040 name="construct.c.page3.pmdo040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo019
            #add-point:BEFORE FIELD pmdo019 name="construct.b.page3.pmdo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo019
            
            #add-point:AFTER FIELD pmdo019 name="construct.a.page3.pmdo019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo019
            #add-point:ON ACTION controlp INFIELD pmdo019 name="construct.c.page3.pmdo019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo021
            #add-point:BEFORE FIELD pmdo021 name="construct.b.page3.pmdo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo021
            
            #add-point:AFTER FIELD pmdo021 name="construct.a.page3.pmdo021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo021
            #add-point:ON ACTION controlp INFIELD pmdo021 name="construct.c.page3.pmdo021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo030
            #add-point:ON ACTION controlp INFIELD pmdo030 name="construct.c.page3.pmdo030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo030  #顯示到畫面上
            NEXT FIELD pmdo030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo030
            #add-point:BEFORE FIELD pmdo030 name="construct.b.page3.pmdo030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo030
            
            #add-point:AFTER FIELD pmdo030 name="construct.a.page3.pmdo030"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo031
            #add-point:BEFORE FIELD pmdo031 name="construct.b.page3.pmdo031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo031
            
            #add-point:AFTER FIELD pmdo031 name="construct.a.page3.pmdo031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo031
            #add-point:ON ACTION controlp INFIELD pmdo031 name="construct.c.page3.pmdo031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo022
            #add-point:BEFORE FIELD pmdo022 name="construct.b.page3.pmdo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo022
            
            #add-point:AFTER FIELD pmdo022 name="construct.a.page3.pmdo022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo022
            #add-point:ON ACTION controlp INFIELD pmdo022 name="construct.c.page3.pmdo022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo023
            #add-point:ON ACTION controlp INFIELD pmdo023 name="construct.c.page3.pmdo023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_oodb002_2()                           #呼叫開窗
            CALL q_oodb002_11()
            DISPLAY g_qryparam.return1 TO pmdo023  #顯示到畫面上
            NEXT FIELD pmdo023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo023
            #add-point:BEFORE FIELD pmdo023 name="construct.b.page3.pmdo023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo023
            
            #add-point:AFTER FIELD pmdo023 name="construct.a.page3.pmdo023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo024
            #add-point:BEFORE FIELD pmdo024 name="construct.b.page3.pmdo024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo024
            
            #add-point:AFTER FIELD pmdo024 name="construct.a.page3.pmdo024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo024
            #add-point:ON ACTION controlp INFIELD pmdo024 name="construct.c.page3.pmdo024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo032
            #add-point:BEFORE FIELD pmdo032 name="construct.b.page3.pmdo032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo032
            
            #add-point:AFTER FIELD pmdo032 name="construct.a.page3.pmdo032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo032
            #add-point:ON ACTION controlp INFIELD pmdo032 name="construct.c.page3.pmdo032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo033
            #add-point:BEFORE FIELD pmdo033 name="construct.b.page3.pmdo033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo033
            
            #add-point:AFTER FIELD pmdo033 name="construct.a.page3.pmdo033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo033
            #add-point:ON ACTION controlp INFIELD pmdo033 name="construct.c.page3.pmdo033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo034
            #add-point:BEFORE FIELD pmdo034 name="construct.b.page3.pmdo034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo034
            
            #add-point:AFTER FIELD pmdo034 name="construct.a.page3.pmdo034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo034
            #add-point:ON ACTION controlp INFIELD pmdo034 name="construct.c.page3.pmdo034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo025
            #add-point:BEFORE FIELD pmdo025 name="construct.b.page3.pmdo025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo025
            
            #add-point:AFTER FIELD pmdo025 name="construct.a.page3.pmdo025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo025
            #add-point:ON ACTION controlp INFIELD pmdo025 name="construct.c.page3.pmdo025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.pmdo026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo026
            #add-point:ON ACTION controlp INFIELD pmdo026 name="construct.c.page3.pmdo026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdo026  #顯示到畫面上
            NEXT FIELD pmdo026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo026
            #add-point:BEFORE FIELD pmdo026 name="construct.b.page3.pmdo026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo026
            
            #add-point:AFTER FIELD pmdo026 name="construct.a.page3.pmdo026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdo027
            #add-point:BEFORE FIELD pmdo027 name="construct.b.page3.pmdo027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdo027
            
            #add-point:AFTER FIELD pmdo027 name="construct.a.page3.pmdo027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pmdo027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdo027
            #add-point:ON ACTION controlp INFIELD pmdo027 name="construct.c.page3.pmdo027"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON pmdmsite,pmdm001,pmdm014,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007, 
          pmdm008,pmdm009
           FROM s_detail6[1].pmdmsite,s_detail6[1].pmdm001,s_detail6[1].pmdm014,s_detail6[1].pmdm002, 
               s_detail6[1].pmdm003,s_detail6[1].pmdm004,s_detail6[1].pmdm005,s_detail6[1].pmdm006,s_detail6[1].pmdm007, 
               s_detail6[1].pmdm008,s_detail6[1].pmdm009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdmsite
            #add-point:BEFORE FIELD pmdmsite name="construct.b.page6.pmdmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdmsite
            
            #add-point:AFTER FIELD pmdmsite name="construct.a.page6.pmdmsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdmsite
            #add-point:ON ACTION controlp INFIELD pmdmsite name="construct.c.page6.pmdmsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm001
            #add-point:BEFORE FIELD pmdm001 name="construct.b.page6.pmdm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm001
            
            #add-point:AFTER FIELD pmdm001 name="construct.a.page6.pmdm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm001
            #add-point:ON ACTION controlp INFIELD pmdm001 name="construct.c.page6.pmdm001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm014
            #add-point:BEFORE FIELD pmdm014 name="construct.b.page6.pmdm014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm014
            
            #add-point:AFTER FIELD pmdm014 name="construct.a.page6.pmdm014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm014
            #add-point:ON ACTION controlp INFIELD pmdm014 name="construct.c.page6.pmdm014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page6.pmdm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm002
            #add-point:ON ACTION controlp INFIELD pmdm002 name="construct.c.page6.pmdm002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmad002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdm002  #顯示到畫面上

            NEXT FIELD pmdm002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm002
            #add-point:BEFORE FIELD pmdm002 name="construct.b.page6.pmdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm002
            
            #add-point:AFTER FIELD pmdm002 name="construct.a.page6.pmdm002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm003
            #add-point:BEFORE FIELD pmdm003 name="construct.b.page6.pmdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm003
            
            #add-point:AFTER FIELD pmdm003 name="construct.a.page6.pmdm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm003
            #add-point:ON ACTION controlp INFIELD pmdm003 name="construct.c.page6.pmdm003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm004
            #add-point:BEFORE FIELD pmdm004 name="construct.b.page6.pmdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm004
            
            #add-point:AFTER FIELD pmdm004 name="construct.a.page6.pmdm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm004
            #add-point:ON ACTION controlp INFIELD pmdm004 name="construct.c.page6.pmdm004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm005
            #add-point:BEFORE FIELD pmdm005 name="construct.b.page6.pmdm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm005
            
            #add-point:AFTER FIELD pmdm005 name="construct.a.page6.pmdm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm005
            #add-point:ON ACTION controlp INFIELD pmdm005 name="construct.c.page6.pmdm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm006
            #add-point:BEFORE FIELD pmdm006 name="construct.b.page6.pmdm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm006
            
            #add-point:AFTER FIELD pmdm006 name="construct.a.page6.pmdm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm006
            #add-point:ON ACTION controlp INFIELD pmdm006 name="construct.c.page6.pmdm006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm007
            #add-point:BEFORE FIELD pmdm007 name="construct.b.page6.pmdm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm007
            
            #add-point:AFTER FIELD pmdm007 name="construct.a.page6.pmdm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm007
            #add-point:ON ACTION controlp INFIELD pmdm007 name="construct.c.page6.pmdm007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm008
            #add-point:BEFORE FIELD pmdm008 name="construct.b.page6.pmdm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm008
            
            #add-point:AFTER FIELD pmdm008 name="construct.a.page6.pmdm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm008
            #add-point:ON ACTION controlp INFIELD pmdm008 name="construct.c.page6.pmdm008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm009
            #add-point:BEFORE FIELD pmdm009 name="construct.b.page6.pmdm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm009
            
            #add-point:AFTER FIELD pmdm009 name="construct.a.page6.pmdm009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.pmdm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm009
            #add-point:ON ACTION controlp INFIELD pmdm009 name="construct.c.page6.pmdm009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
            
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_pmdn_d[1].pmdnseq = ""
         DISPLAY ARRAY g_pmdn_d TO s_detail1.*
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
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "pmdl_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmdn_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrcd_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "pmdo_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "pmdm_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
      
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt840_filter()
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
      CONSTRUCT g_wc_filter ON pmdldocno,pmdldocdt,pmdl001,pmdl002,pmdl003,pmdl004
                          FROM s_browse[1].b_pmdldocno,s_browse[1].b_pmdldocdt,s_browse[1].b_pmdl001, 
                              s_browse[1].b_pmdl002,s_browse[1].b_pmdl003,s_browse[1].b_pmdl004
 
         BEFORE CONSTRUCT
               DISPLAY apmt840_filter_parser('pmdldocno') TO s_browse[1].b_pmdldocno
            DISPLAY apmt840_filter_parser('pmdldocdt') TO s_browse[1].b_pmdldocdt
            DISPLAY apmt840_filter_parser('pmdl001') TO s_browse[1].b_pmdl001
            DISPLAY apmt840_filter_parser('pmdl002') TO s_browse[1].b_pmdl002
            DISPLAY apmt840_filter_parser('pmdl003') TO s_browse[1].b_pmdl003
            DISPLAY apmt840_filter_parser('pmdl004') TO s_browse[1].b_pmdl004
      
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
 
      CALL apmt840_filter_show('pmdldocno')
   CALL apmt840_filter_show('pmdldocdt')
   CALL apmt840_filter_show('pmdl001')
   CALL apmt840_filter_show('pmdl002')
   CALL apmt840_filter_show('pmdl003')
   CALL apmt840_filter_show('pmdl004')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt840_filter_parser(ps_field)
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
 
{<section id="apmt840.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt840_filter_show(ps_field)
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
   LET ls_condition = apmt840_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt840_query()
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
   CALL g_pmdn_d.clear()
   CALL g_pmdn2_d.clear()
   CALL g_pmdn3_d.clear()
   CALL g_pmdn6_d.clear()
 
   
   #add-point:query段other name="query.other"
      
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt840_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt840_browser_fill("")
      CALL apmt840_fetch("")
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
      CALL apmt840_filter_show('pmdldocno')
   CALL apmt840_filter_show('pmdldocdt')
   CALL apmt840_filter_show('pmdl001')
   CALL apmt840_filter_show('pmdl002')
   CALL apmt840_filter_show('pmdl003')
   CALL apmt840_filter_show('pmdl004')
   CALL apmt840_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt840_fetch("F") 
      #顯示單身筆數
      CALL apmt840_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt840_fetch(p_flag)
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
   
   LET g_pmdl_m.pmdldocno = g_browser[g_current_idx].b_pmdldocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
   #遮罩相關處理
   LET g_pmdl_m_mask_o.* =  g_pmdl_m.*
   CALL apmt840_pmdl_t_mask()
   LET g_pmdl_m_mask_n.* =  g_pmdl_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt840_set_act_visible()   
   CALL apmt840_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
      
   #end add-point
   
   #保存單頭舊值
   LET g_pmdl_m_t.* = g_pmdl_m.*
   LET g_pmdl_m_o.* = g_pmdl_m.*
   
   LET g_data_owner = g_pmdl_m.pmdlownid      
   LET g_data_dept  = g_pmdl_m.pmdlowndp
   
   #重新顯示   
   CALL apmt840_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt840_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmdn_d.clear()   
   CALL g_pmdn2_d.clear()  
   CALL g_pmdn3_d.clear()  
   CALL g_pmdn6_d.clear()  
 
 
   INITIALIZE g_pmdl_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmdldocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdl_m.pmdlownid = g_user
      LET g_pmdl_m.pmdlowndp = g_dept
      LET g_pmdl_m.pmdlcrtid = g_user
      LET g_pmdl_m.pmdlcrtdp = g_dept 
      LET g_pmdl_m.pmdlcrtdt = cl_get_current()
      LET g_pmdl_m.pmdlmodid = g_user
      LET g_pmdl_m.pmdlmoddt = cl_get_current()
      LET g_pmdl_m.pmdlstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmdl_m.pmdl001 = "0"
      LET g_pmdl_m.pmdl005 = "1"
      LET g_pmdl_m.pmdl203 = "0"
      LET g_pmdl_m.pmdlstus = "N"
      LET g_pmdl_m.pmdl007 = "1"
      LET g_pmdl_m.pmdl206 = "N"
      LET g_pmdl_m.pmdl047 = "N"
      LET g_pmdl_m.pmdl054 = "1"
      LET g_pmdl_m.pmdl055 = "1"
      LET g_pmdl_m.pmdl013 = "N"
      LET g_pmdl_m.pmdl006 = "1"
      LET g_pmdl_m.pmdl042 = "0"
      LET g_pmdl_m.pmdl048 = "N"
      LET g_pmdl_m.pmdl049 = "N"
      LET g_pmdl_m.pmdl046 = "1"
      LET g_pmdl_m.pmdl040 = "0"
      LET g_pmdl_m.pmdl041 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #採購組織
      CALL s_aooi500_default(g_prog,'pmdlsite',g_pmdl_m.pmdlsite) RETURNING l_insert,g_pmdl_m.pmdlsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite) RETURNING g_pmdl_m.pmdlsite_desc
      DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
      
      #採購日期
      LET g_pmdl_m.pmdldocdt = g_today
      
      #採購單別
      CALL s_arti200_get_def_doc_type(g_pmdl_m.pmdlsite,g_prog,'1')
         RETURNING l_success,l_doctype
      LET g_pmdl_m.pmdldocno = l_doctype
      DISPLAY BY NAME g_pmdl_m.pmdldocno
      
      #採購人員
      LET g_pmdl_m.pmdl002 = g_user
      CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
      DISPLAY BY NAME g_pmdl_m.pmdl002_desc
      
      #採購部門
      LET g_pmdl_m.pmdl003 = g_dept
      CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
      DISPLAY BY NAME g_pmdl_m.pmdl003_desc
      
      LET g_site_flag = FALSE
      LET g_pmdl_m_t.* = g_pmdl_m.*
      LET g_pmdl_m_o.* = g_pmdl_m.*  #舊值備份
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmdl_m_t.* = g_pmdl_m.*
      LET g_pmdl_m_o.* = g_pmdl_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdl_m.pmdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
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
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL apmt840_input("a")
      
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
         INITIALIZE g_pmdl_m.* TO NULL
         INITIALIZE g_pmdn_d TO NULL
         INITIALIZE g_pmdn2_d TO NULL
         INITIALIZE g_pmdn3_d TO NULL
         INITIALIZE g_pmdn6_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt840_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmdn_d.clear()
      #CALL g_pmdn2_d.clear()
      #CALL g_pmdn3_d.clear()
      #CALL g_pmdn6_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt840_set_act_visible()   
   CALL apmt840_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdlent = " ||g_enterprise|| " AND",
                      " pmdldocno = '", g_pmdl_m.pmdldocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt840_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt840_cl
   
   CALL apmt840_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
   
   #遮罩相關處理
   LET g_pmdl_m_mask_o.* =  g_pmdl_m.*
   CALL apmt840_pmdl_t_mask()
   LET g_pmdl_m_mask_n.* =  g_pmdl_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001, 
       g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004,g_pmdl_m.pmdl004_desc, 
       g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003,g_pmdl_m.pmdl003_desc, 
       g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl201, 
       g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdl207,g_pmdl_m.pmdl207_desc, 
       g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025, 
       g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl023_desc, 
       g_pmdl_m.pmdl022,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl047, 
       g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015,g_pmdl_m.pmdl015_desc, 
       g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011,g_pmdl_m.pmdl011_desc, 
       g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl024,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl044, 
       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
       g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp, 
       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdp_desc, 
       g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
       g_pmdl_m.pmdlcnfid_desc,g_pmdl_m.pmdlcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmdl_m.pmdlownid      
   LET g_data_dept  = g_pmdl_m.pmdlowndp
   
   #功能已完成,通報訊息中心
   CALL apmt840_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt840_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmdl_m_t.* = g_pmdl_m.*
   LET g_pmdl_m_o.* = g_pmdl_m.*
   
   IF g_pmdl_m.pmdldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
   CALL s_transaction_begin()
   
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt840_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
   #檢查是否允許此動作
   IF NOT apmt840_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdl_m_mask_o.* =  g_pmdl_m.*
   CALL apmt840_pmdl_t_mask()
   LET g_pmdl_m_mask_n.* =  g_pmdl_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   LET g_site_flag = TRUE
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL apmt840_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmdl_m.pmdlmodid = g_user 
LET g_pmdl_m.pmdlmoddt = cl_get_current()
LET g_pmdl_m.pmdlmodid_desc = cl_get_username(g_pmdl_m.pmdlmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_pmdl_m.pmdlstus MATCHES '[DR]' THEN 
         LET g_pmdl_m.pmdlstus = "N"
      END IF

      
      LET g_pmdl_m_o.* = g_pmdl_m.*  #舊值備份
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt840_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmdl_t SET (pmdlmodid,pmdlmoddt) = (g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt)
          WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmdl_m.* = g_pmdl_m_t.*
            CALL apmt840_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmdl_m.pmdldocno != g_pmdl_m_t.pmdldocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                  
         #end add-point
         
         #更新單身key值
         UPDATE pmdn_t SET pmdndocno = g_pmdl_m.pmdldocno
 
          WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdl_m_t.pmdldocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
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
         
         UPDATE xrcd_t
            SET xrcddocno = g_pmdl_m.pmdldocno
 
          WHERE xrcdent = g_enterprise AND
                xrcddocno = g_pmdldocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
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
         
         UPDATE pmdo_t
            SET pmdodocno = g_pmdl_m.pmdldocno
 
          WHERE pmdoent = g_enterprise AND
                pmdodocno = g_pmdldocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
                  
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
                  
         #end add-point
         
         UPDATE pmdm_t
            SET pmdmdocno = g_pmdl_m.pmdldocno
 
          WHERE pmdment = g_enterprise AND
                pmdmdocno = g_pmdldocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
                  
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt840_set_act_visible()   
   CALL apmt840_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmdlent = " ||g_enterprise|| " AND",
                      " pmdldocno = '", g_pmdl_m.pmdldocno, "' "
 
   #填到對應位置
   CALL apmt840_browser_fill("")
 
   CLOSE apmt840_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt840_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt840.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt840_input(p_cmd)
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
   DEFINE  l_success    LIKE type_t.num5
   DEFINE  l_confirm    LIKE type_t.num5
   DEFINE  l_errno      LIKE type_t.chr10
   DEFINE  l_pmaa004    LIKE pmaa_t.pmaa004
   DEFINE  l_ooef001    LIKE ooef_t.ooef001
   DEFINE  l_ooef004    LIKE ooef_t.ooef004
   DEFINE  l_ooef012    LIKE ooef_t.ooef012
   DEFINE  l_ooef016    LIKE ooef_t.ooef016
   DEFINE  l_ooef019    LIKE ooef_t.ooef019
   DEFINE  l_acc        LIKE gzcb_t.gzcb007
   DEFINE  l_rtka010    LIKE rtka_t.rtka010    #訂單有效期
   DEFINE  l_rtka012    LIKE rtka_t.rtka012    #送貨天數
   DEFINE  l_rtka012_o  LIKE rtka_t.rtka012
   DEFINE  l_pmdn014    LIKE pmdn_t.pmdn014    #紀錄推算出來的到庫日期
   DEFINE  l_msg        STRING
   DEFINE  l_xrcd103    LIKE xrcd_t.xrcd103
   DEFINE  l_xrcd104    LIKE xrcd_t.xrcd104
   DEFINE  l_xrcd105    LIKE xrcd_t.xrcd105
   DEFINE  l_xrcd113    LIKE xrcd_t.xrcd113
   DEFINE  l_xrcd114    LIKE xrcd_t.xrcd114
   DEFINE  l_xrcd115    LIKE xrcd_t.xrcd115
   DEFINE  l_pmdn007    LIKE pmdn_t.pmdn007    #採購數量
   DEFINE  l_pmdn020    LIKE pmdn_t.pmdn020    #緊急度
   DEFINE  l_pmdn024    LIKE pmdn_t.pmdn024    #多交期
   DEFINE  l_pmdn202    LIKE pmdn_t.pmdn202    #包裝數量
   DEFINE  l_pmdn224    LIKE pmdn_t.pmdn224    #單身採購失效日
   DEFINE  l_pmdl205    LIKE pmdl_t.pmdl205    #單頭採購失效日
   DEFINE  l_pmak002    LIKE pmak_t.pmak002
   DEFINE  l_pmaa002    LIKE pmaa_t.pmaa002
   DEFINE  l_sql        STRING
   DEFINE  l_replace    STRING
   DEFINE  l_inam       DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001      LIKE inam_t.inam001,
           inam002      LIKE inam_t.inam002,
           inam004      LIKE inam_t.inam004
                        END RECORD
   DEFINE  l_imaa005    LIKE imaa_t.imaa005
   DEFINE  l_pmdnseq    LIKE pmdn_t.pmdnseq
   DEFINE  l_pmdn       RECORD
           pmdnent      LIKE pmdn_t.pmdnent,
           pmdndocno    LIKE pmdn_t.pmdndocno,
           pmdnseq      LIKE pmdn_t.pmdnseq, 
           pmdnsite     LIKE pmdn_t.pmdnsite,
           pmdn200      LIKE pmdn_t.pmdn200, 
           pmdn001      LIKE pmdn_t.pmdn001,
           pmdn002      LIKE pmdn_t.pmdn002,
           pmdn016      LIKE pmdn_t.pmdn016, 
           pmdn017      LIKE pmdn_t.pmdn017, 
           pmdn201      LIKE pmdn_t.pmdn201, 
           pmdn202      LIKE pmdn_t.pmdn202, 
           pmdn006      LIKE pmdn_t.pmdn006, 
           pmdn007      LIKE pmdn_t.pmdn007, 
           pmdn008      LIKE pmdn_t.pmdn008, 
           pmdn009      LIKE pmdn_t.pmdn009, 
           pmdn010      LIKE pmdn_t.pmdn010,  
           pmdn011      LIKE pmdn_t.pmdn011, 
           pmdn015      LIKE pmdn_t.pmdn015, 
           pmdn043      LIKE pmdn_t.pmdn043,
           pmdn046      LIKE pmdn_t.pmdn046, 
           pmdn048      LIKE pmdn_t.pmdn048, 
           pmdn047      LIKE pmdn_t.pmdn047, 
           pmdnunit     LIKE pmdn_t.pmdnunit,
           pmdn225      LIKE pmdn_t.pmdn225,
           pmdn203      LIKE pmdn_t.pmdn203,
           pmdn025      LIKE pmdn_t.pmdn025,
           pmdn028      LIKE pmdn_t.pmdn028, 
           pmdn029      LIKE pmdn_t.pmdn029, 
           pmdn030      LIKE pmdn_t.pmdn030, 
           pmdnorga     LIKE pmdn_t.pmdnorga,  
           pmdn026      LIKE pmdn_t.pmdn026, 
           pmdn024      LIKE pmdn_t.pmdn024, 
           pmdn014      LIKE pmdn_t.pmdn014, 
           pmdn012      LIKE pmdn_t.pmdn012, 
           pmdn013      LIKE pmdn_t.pmdn013, 
           pmdn022      LIKE pmdn_t.pmdn022, 
           pmdn023      LIKE pmdn_t.pmdn023, 
           pmdn045      LIKE pmdn_t.pmdn045, 
           pmdn206      LIKE pmdn_t.pmdn206, 
           pmdn207      LIKE pmdn_t.pmdn207, 
           pmdn208      LIKE pmdn_t.pmdn208, 
           pmdn209      LIKE pmdn_t.pmdn209, 
           pmdn210      LIKE pmdn_t.pmdn210, 
           pmdn211      LIKE pmdn_t.pmdn211, 
           pmdn212      LIKE pmdn_t.pmdn212, 
           pmdn213      LIKE pmdn_t.pmdn213, 
           pmdn019      LIKE pmdn_t.pmdn019, 
           pmdn020      LIKE pmdn_t.pmdn020, 
           pmdn224      LIKE pmdn_t.pmdn224, 
           pmdn049      LIKE pmdn_t.pmdn049, 
           pmdn051      LIKE pmdn_t.pmdn051, 
           pmdn205      LIKE pmdn_t.pmdn205, 
           pmdn214      LIKE pmdn_t.pmdn214, 
           pmdn215      LIKE pmdn_t.pmdn215, 
           pmdn216      LIKE pmdn_t.pmdn216, 
           pmdn217      LIKE pmdn_t.pmdn217, 
           pmdn218      LIKE pmdn_t.pmdn218, 
           pmdn219      LIKE pmdn_t.pmdn219, 
           pmdn220      LIKE pmdn_t.pmdn220, 
           pmdn221      LIKE pmdn_t.pmdn221, 
           pmdn222      LIKE pmdn_t.pmdn222, 
           pmdn223      LIKE pmdn_t.pmdn223, 
           pmdn050      LIKE pmdn_t.pmdn050,
           pmdn227      LIKE pmdn_t.pmdn227   #150710-00016#5 150713 by sakura add
                        END RECORD
   DEFINE  la_param     RECORD
           prog         STRING,
           param        DYNAMIC ARRAY OF STRING
                        END RECORD
   DEFINE ls_js         STRING
   DEFINE l_auto_detail LIKE type_t.chr1 #記錄進到單身是否已有詢問過自動產生單身
   DEFINE l_sys         LIKE type_t.num5 #150610-00030#1 150612 by sakura add
   DEFINE l_stboacti        LIKE stbo_t.stboacti  #151027-00013#1 Add By Ken 151113 astm301合約中的簽約門店有效否
   DEFINE l_staqacti        LIKE staq_t.staqacti  #151027-00013#1 Add By Ken 151113 astm301合約中的經營品類有效否
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   #160120-00001#5 160121 By pomelo add(S)
   IF p_cmd = 'r' THEN
      LET g_cmd = 'r'
   ELSE
      LET g_cmd = p_cmd
   END IF
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001, 
       g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004,g_pmdl_m.pmdl004_desc, 
       g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003,g_pmdl_m.pmdl003_desc, 
       g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl201, 
       g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdl207,g_pmdl_m.pmdl207_desc, 
       g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025, 
       g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl023_desc, 
       g_pmdl_m.pmdl022,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl047, 
       g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015,g_pmdl_m.pmdl015_desc, 
       g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011,g_pmdl_m.pmdl011_desc, 
       g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl024,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl044, 
       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
       g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp, 
       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdp_desc, 
       g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
       g_pmdl_m.pmdlcnfid_desc,g_pmdl_m.pmdlcnfdt
   
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
   LET l_auto_detail = 'Y'
   #end add-point 
   LET g_forupd_sql = "SELECT pmdnseq,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016,pmdn017,pmdn227, 
       pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011,pmdn015,pmdn043,pmdn046, 
       pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn028,pmdn029,pmdn030,pmdn053,pmdnorga,pmdn026, 
       pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210, 
       pmdn211,pmdn212,pmdn213,pmdn019,pmdn020,pmdn224,pmdn052,pmdn049,pmdn051,pmdn205,pmdn214,pmdn215, 
       pmdn216,pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn050 FROM pmdn_t WHERE pmdnent=?  
       AND pmdndocno=? AND pmdnseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt840_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
      
   #end add-point    
   LET g_forupd_sql = "SELECT xrcdsite,xrcdld,xrcdseq,xrcd007,xrcd002,xrcdseq2,xrcd003,xrcd006,xrcd004, 
       xrcd104 FROM xrcd_t WHERE xrcdent=? AND xrcddocno=? AND xrcdld=? AND xrcdseq=? AND xrcdseq2=?  
       AND xrcd007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt840_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
      
   #end add-point    
   LET g_forupd_sql = "SELECT pmdosite,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,pmdo002,pmdo005,pmdo200, 
       pmdo201,pmdo004,pmdo006,pmdo028,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010,pmdo009,pmdo015,pmdo016, 
       pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,pmdo031,pmdo022,pmdo023,pmdo024,pmdo032,pmdo033,pmdo034, 
       pmdo025,pmdo026,pmdo027 FROM pmdo_t WHERE pmdoent=? AND pmdodocno=? AND pmdoseq=? AND pmdoseq1=?  
       AND pmdoseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt840_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
      
   #end add-point    
   LET g_forupd_sql = "SELECT pmdmsite,pmdm001,pmdm014,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007, 
       pmdm008,pmdm009 FROM pmdm_t WHERE pmdment=? AND pmdmdocno=? AND pmdm001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt840_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
      
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt840_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL apmt840_set_no_required()
   CALL apmt840_set_required()
   #end add-point
   CALL apmt840_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005, 
       g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus, 
       g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204, 
       g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205, 
       g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055, 
       g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012, 
       g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024,g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044, 
       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
       g_pmdl_m.pmdl040,g_pmdl_m.pmdl041
   
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
 
{<section id="apmt840.input.head" >}
      #單頭段
      INPUT BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005, 
          g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus, 
          g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204, 
          g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205, 
          g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055, 
          g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012, 
          g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024,g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044, 
          g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
          g_pmdl_m.pmdl040,g_pmdl_m.pmdl041 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt840_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL apmt840_set_no_required()
            CALL apmt840_set_required()
            #end add-point
            CALL apmt840_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlsite
            
            #add-point:AFTER FIELD pmdlsite name="input.a.pmdlsite"
            LET g_pmdl_m.pmdlsite_desc = ' '
            DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
            IF cl_null(g_pmdl_m.pmdlsite) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'sub-00507'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_pmdl_m.pmdlsite = g_pmdl_m_t.pmdlsite
               CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite)
                  RETURNING g_pmdl_m.pmdlsite_desc
               DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
               NEXT FIELD CURRENT
            ELSE
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdl_m.pmdlsite != g_pmdl_m_t.pmdlsite OR g_pmdl_m_t.pmdlsite IS NULL )) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdl_m.pmdlsite != g_pmdl_m_o.pmdlsite OR cl_null(g_pmdl_m_o.pmdlsite) THEN   #160824-00007#12 20160914 add by beckxie
                  CALL s_aooi500_chk(g_prog,'pmdlsite',g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     #LET g_pmdl_m.pmdlsite = g_pmdl_m_t.pmdlsite   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdl_m.pmdlsite = g_pmdl_m_o.pmdlsite    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite)
                        RETURNING g_pmdl_m.pmdlsite_desc
                     DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdlsite = g_pmdl_m.pmdlsite   #160824-00007#12 20160914 add by beckxie
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite)
               RETURNING g_pmdl_m.pmdlsite_desc
            DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
            CALL apmt840_set_entry(p_cmd)
            CALL apmt840_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlsite
            #add-point:BEFORE FIELD pmdlsite name="input.b.pmdlsite"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdlsite
            #add-point:ON CHANGE pmdlsite name="input.g.pmdlsite"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocdt
            #add-point:BEFORE FIELD pmdldocdt name="input.b.pmdldocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocdt
            
            #add-point:AFTER FIELD pmdldocdt name="input.a.pmdldocdt"
            #150512-00029#2 150525 By pomelo add(S)
            IF NOT cl_null(g_pmdl_m.pmdldocdt) THEN
               IF g_pmdl_m.pmdldocdt != g_pmdl_m_o.pmdldocdt OR cl_null(g_pmdl_m_o.pmdldocdt) THEN
                  IF g_pmdl_m.pmdl206 = 'N' THEN
                     IF NOT cl_null(g_pmdl_m.pmdl004) AND NOT cl_null(g_pmdl_m.pmdlsite) THEN
                        #取的訂單有效期
                        CALL apmt840_get_rtka010(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004)
                           RETURNING l_rtka010
                        #採購失效日(到庫日期+訂單有效期)
                        IF cl_null(l_rtka010)  THEN
                           LET g_pmdl_m.pmdl205 = NULL
                        ELSE
                           LET g_pmdl_m.pmdl205 = g_pmdl_m.pmdldocdt + l_rtka010
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdldocdt = g_pmdl_m.pmdldocdt
            LET g_pmdl_m_o.pmdl205 = g_pmdl_m.pmdl205
            #150512-00029#2 150525 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdldocdt
            #add-point:ON CHANGE pmdldocdt name="input.g.pmdldocdt"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocno
            #add-point:BEFORE FIELD pmdldocno name="input.b.pmdldocno"
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_pmdl_m.pmdlsite
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocno
            
            #add-point:AFTER FIELD pmdldocno name="input.a.pmdldocno"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_pmdl_m.pmdldocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdl_m.pmdldocno != g_pmdldocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdl_t WHERE "||"pmdlent = '" ||g_enterprise|| "' AND "||"pmdldocno = '"||g_pmdl_m.pmdldocno ||"'",'std-00004',0) THEN 
                     LET g_pmdl_m.pmdldocno = g_pmdldocno_t
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_aooi200_chk_slip(g_pmdl_m.pmdlsite,'',g_pmdl_m.pmdldocno,g_prog) THEN
                     LET g_pmdl_m.pmdldocno = g_pmdldocno_t
                     NEXT FIELD CURRENT   
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdldocno
            #add-point:ON CHANGE pmdldocno name="input.g.pmdldocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl001
            #add-point:BEFORE FIELD pmdl001 name="input.b.pmdl001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl001
            
            #add-point:AFTER FIELD pmdl001 name="input.a.pmdl001"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl001
            #add-point:ON CHANGE pmdl001 name="input.g.pmdl001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl005
            #add-point:BEFORE FIELD pmdl005 name="input.b.pmdl005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl005
            
            #add-point:AFTER FIELD pmdl005 name="input.a.pmdl005"
          
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl005
            #add-point:ON CHANGE pmdl005 name="input.g.pmdl005"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl200
            
            #add-point:AFTER FIELD pmdl200 name="input.a.pmdl200"
            LET g_pmdl_m.pmdl200_desc = ' '
            DISPLAY BY NAME g_pmdl_m.pmdl200_desc
            IF NOT cl_null(g_pmdl_m.pmdl200) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdl_m.pmdl200 != g_pmdl_m_t.pmdl200 OR g_pmdl_m_t.pmdl200 IS NULL )) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdl_m.pmdl200 != g_pmdl_m_o.pmdl200 OR cl_null(g_pmdl_m_o.pmdl200) THEN   #160824-00007#12 20160914 add by beckxie
                  IF s_aooi500_setpoint(g_prog,'pmdl200') THEN
                     CALL s_aooi500_chk(g_prog,'pmdl200',g_pmdl_m.pmdl200,g_pmdl_m.pmdlsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_pmdl_m.pmdl200 = g_pmdl_m_t.pmdl200   #160824-00007#12 20160914 mark by beckxie
                        LET g_pmdl_m.pmdl200 = g_pmdl_m_o.pmdl200    #160824-00007#12 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmdl_m.pmdl200)
                            RETURNING g_pmdl_m.pmdl200_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl200_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmdl_m.pmdl200
                     IF NOT cl_chk_exist("v_ooef001_34") THEN
                        #LET g_pmdl_m.pmdl200 = g_pmdl_m_t.pmdl200   #160824-00007#12 20160914 mark by beckxie
                        LET g_pmdl_m.pmdl200 = g_pmdl_m_o.pmdl200    #160824-00007#12 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmdl_m.pmdl200)
                            RETURNING g_pmdl_m.pmdl200_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl200_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF NOT apmt840_chk_pact() THEN
                     #LET g_pmdl_m.pmdl200 = g_pmdl_m_t.pmdl200   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdl_m.pmdl200 = g_pmdl_m_o.pmdl200    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_department_desc(g_pmdl_m.pmdl200)
                         RETURNING g_pmdl_m.pmdl200_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl200_desc
                     NEXT FIELD CURRENT
                  END IF
                  #Add By Ken 151028 #151027-00013#1(S)   #取合約中的進項稅別
                  IF NOT cl_null(g_pmdl_m.pmdl004) THEN
                     CALL s_apmt840_get_stan007(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004,g_pmdl_m.pmdl200,g_pmdl_m.pmdl207)
                      RETURNING l_success,g_pmdl_m.pmdl011,l_stboacti,l_staqacti    
                     IF NOT l_success THEN
                        IF cl_null(g_pmdl_m.pmdl207) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-01024'
                           LET g_errparam.extend = ""
                           LET g_errparam.replace[1] = g_pmdl_m.pmdl004
                           LET g_errparam.replace[2] = g_pmdl_m.pmdl200
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                        
                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-01030'
                           LET g_errparam.extend = ""
                           LET g_errparam.replace[1] = g_pmdl_m.pmdl004
                           LET g_errparam.replace[2] = g_pmdl_m.pmdl200
                           LET g_errparam.replace[3] = g_pmdl_m.pmdl207
                           LET g_errparam.popup = TRUE
                           CALL cl_err()  
                        END IF
                        #LET g_pmdl_m.pmdl200 = g_pmdl_m_t.pmdl200   #160824-00007#12 20160914 mark by beckxie
                        LET g_pmdl_m.pmdl200 = g_pmdl_m_o.pmdl200    #160824-00007#12 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmdl_m.pmdl200)
                            RETURNING g_pmdl_m.pmdl200_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl200_desc                        
                        NEXT FIELD CURRENT 
                     END IF   
                     #根據供應商帶值，帶出相關欄位值
                     CALL apmt840_pmdl004_default()                       
                  END IF
                  #Add By Ken 151028 #151027-00013#1(E)                     
               END IF
            END IF
            LET g_pmdl_m_o.pmdl200 = g_pmdl_m.pmdl200   #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl200)
                RETURNING g_pmdl_m.pmdl200_desc
            DISPLAY BY NAME g_pmdl_m.pmdl200_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl200
            #add-point:BEFORE FIELD pmdl200 name="input.b.pmdl200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl200
            #add-point:ON CHANGE pmdl200 name="input.g.pmdl200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl004
            
            #add-point:AFTER FIELD pmdl004 name="input.a.pmdl004"
            LET g_pmdl_m.pmdl004_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl004_desc
            
            IF NOT cl_null(g_pmdl_m.pmdl004) THEN 
               IF g_pmdl_m.pmdl004 != g_pmdl_m_o.pmdl004 OR cl_null(g_pmdl_m_o.pmdl004) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl004
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_pmdl_m.pmdl004 = g_pmdl_m_o.pmdl004
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004) RETURNING g_pmdl_m.pmdl004_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl004_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT apmt840_chk_pact() THEN
                     LET g_pmdl_m.pmdl004 = g_pmdl_m_o.pmdl004
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004) RETURNING g_pmdl_m.pmdl004_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl004_desc
                     NEXT FIELD CURRENT
                  END IF
                                   
                  #Add By Ken 151028 #151027-00013#1(S)   #取合約中的進項稅別
                  IF NOT cl_null(g_pmdl_m.pmdl200) THEN
                     CALL s_apmt840_get_stan007(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004,g_pmdl_m.pmdl200,g_pmdl_m.pmdl207)
                      RETURNING l_success,g_pmdl_m.pmdl011,l_stboacti,l_staqacti
                     IF NOT l_success THEN
                        IF cl_null(g_pmdl_m.pmdl207) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-01024'
                           LET g_errparam.extend = ""
                           LET g_errparam.replace[1] = g_pmdl_m.pmdl004
                           LET g_errparam.replace[2] = g_pmdl_m.pmdl200
                           LET g_errparam.popup = TRUE
                           CALL cl_err() 
                        ELSE                           
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-01030'
                           LET g_errparam.extend = ""
                           LET g_errparam.replace[1] = g_pmdl_m.pmdl004
                           LET g_errparam.replace[2] = g_pmdl_m.pmdl200
                           LET g_errparam.replace[3] = g_pmdl_m.pmdl207
                           LET g_errparam.popup = TRUE
                           CALL cl_err()  
                        END IF
                        LET g_pmdl_m.pmdl004 = g_pmdl_m_o.pmdl004
                        CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004) RETURNING g_pmdl_m.pmdl004_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl004_desc                        
                        NEXT FIELD CURRENT 
                     END IF
                  END IF
                  #Add By Ken 151028 #151027-00013#1(E)
                  
                  #根據供應商帶值，帶出相關欄位值
                  CALL apmt840_pmdl004_default()                   
                  
                  #若輸入供應商的法人類型為'2:一次性交易'或是'4:內部員工'時，則自動串apmi004_01
                  #維護一次性交易對項基本資料，維護完基本資料後會回傳一個一次性交易對象識別碼，
                  #將識別碼值預設給pmdl028欄位
                  LET l_pmaa004 = ''
                  SELECT pmaa004 INTO l_pmaa004
                    FROM pmaa_t
                   WHERE pmaaent = g_enterprise
                     AND pmaa001 = g_pmdl_m.pmdl004
                  IF l_pmaa004 = '2' THEN   #一次性交易對象
                     CALL apmi004_01('1',g_pmdl_m.pmdl028,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocno) RETURNING g_pmdl_m.pmdl028
                  END IF
                  IF l_pmaa004 = '4' THEN   #內部員工
                     CALL apmi004_01('2',g_pmdl_m.pmdl028,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocno) RETURNING g_pmdl_m.pmdl028
                  END IF
                  
                  #150512-00029#2 150525 By pomelo add(S)
                  IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN
                  #150512-00029#2 150525 By pomelo add(E)
                     #150407-00020#1 Add_S By Ken 150410
                     #取的訂單有效期
                     IF NOT cl_null(g_pmdl_m.pmdlsite) THEN
                        CALL apmt840_get_rtka010(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004)
                           RETURNING l_rtka010
                        #採購失效日(採購日期+訂單有效期)
                        IF cl_null(l_rtka010) THEN
                           LET g_pmdl_m.pmdl205 = NULL
                        ELSE
                           LET g_pmdl_m.pmdl205 = g_pmdl_m.pmdldocdt + l_rtka010                 
                        END IF
                     END IF
                     #150407-00020#1 Add_E
                  END IF  #150512-00029#2 150525 By pomelo add
                  
               END IF
               
               #供应商生命周期的判断  2015/03/19  geza
               #IF NOT s_life_cycle_chk(g_prog,g_pmdl_m.pmdlsite,'2',g_pmdl_m.pmdl004)THEN    #150616-00035#78-mark by dongsz
               IF NOT s_life_cycle_chk(g_prog,g_pmdl_m.pmdlsite,'2',g_pmdl_m.pmdl004,'','')THEN    #150616-00035#78-add by dongsz
                  NEXT FIELD CURRENT
               END IF
            ELSE   
               LET g_pmdl_m.pmdl205 = NULL
            END IF
            LET g_pmdl_m_o.pmdl004 = g_pmdl_m.pmdl004
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004) RETURNING g_pmdl_m.pmdl004_desc
            DISPLAY BY NAME g_pmdl_m.pmdl004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl004
            #add-point:BEFORE FIELD pmdl004 name="input.b.pmdl004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl004
            #add-point:ON CHANGE pmdl004 name="input.g.pmdl004"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl203
            #add-point:BEFORE FIELD pmdl203 name="input.b.pmdl203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl203
            
            #add-point:AFTER FIELD pmdl203 name="input.a.pmdl203"
            IF NOT cl_null(g_pmdl_m.pmdl203) THEN
               IF g_pmdl_m.pmdl203 <> g_pmdl_m_o.pmdl203 OR cl_null(g_pmdl_m_o.pmdl203) THEN
                  IF g_pmdl_m.pmdl203 = '3' THEN
                     LET g_pmdl_m.pmdlunit = ''
                     LET g_pmdl_m.pmdlunit_desc = ''
                  ELSE
                     LET g_pmdl_m.pmdl204 = ''
                     LET g_pmdl_m.pmdl204_desc = ''
                  END IF
                  LET g_pmdl_m.pmdl025 = ''
                  LET g_pmdl_m.pmdl025_desc = ''
                  LET g_pmdl_m.oofb017 = ''
                  DISPLAY BY NAME g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,
                                  g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc,
                                  g_pmdl_m.pmdl025,g_pmdl_m.pmdl025_desc,
                                  g_pmdl_m.oofb017
                  CALL apmt840_addr_default(1)
               END IF
            END IF
            LET g_pmdl_m_o.pmdlunit = g_pmdl_m.pmdlunit
            LET g_pmdl_m_o.pmdl203 = g_pmdl_m.pmdl203
            LET g_pmdl_m_o.pmdl204 = g_pmdl_m.pmdl204
            LET g_pmdl_m_o.pmdl025 = g_pmdl_m.pmdl025
            CALL apmt840_set_entry(p_cmd)
            CALL apmt840_set_no_required()
            CALL apmt840_set_required()
            CALL apmt840_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl203
            #add-point:ON CHANGE pmdl203 name="input.g.pmdl203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl002
            
            #add-point:AFTER FIELD pmdl002 name="input.a.pmdl002"
            LET g_pmdl_m.pmdl002_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl002_desc
            IF NOT cl_null(g_pmdl_m.pmdl002) THEN
               IF g_pmdl_m.pmdl002 != g_pmdl_m_o.pmdl002 OR cl_null(g_pmdl_m_o.pmdl002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl002
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#21  by 07900 --add-end 
                  IF cl_chk_exist("v_ooag001") THEN
                     CALL s_apmt840_get_dep(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl003
                     CALL s_desc_get_person_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl003_desc   
                  ELSE
                     LET g_pmdl_m.pmdl002 = g_pmdl_m_o.pmdl002
                     CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
            DISPLAY BY NAME g_pmdl_m.pmdl002_desc
            LET g_pmdl_m_o.pmdl002 = g_pmdl_m.pmdl002
            LET g_pmdl_m_o.pmdl003 = g_pmdl_m.pmdl003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl002
            #add-point:BEFORE FIELD pmdl002 name="input.b.pmdl002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl002
            #add-point:ON CHANGE pmdl002 name="input.g.pmdl002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl003
            
            #add-point:AFTER FIELD pmdl003 name="input.a.pmdl003"
            LET g_pmdl_m.pmdl003_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl003_desc
            IF NOT cl_null(g_pmdl_m.pmdl003) THEN
               IF g_pmdl_m.pmdl003 != g_pmdl_m_t.pmdl003 OR cl_null(g_pmdl_m.pmdl003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl003
                  LET g_chkparam.arg2 = g_pmdl_m.pmdldocdt
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_pmdl_m.pmdl003 = g_pmdl_m_t.pmdl003
                     CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl003_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
            DISPLAY BY NAME g_pmdl_m.pmdl003_desc
            LET g_pmdl_m_o.pmdl003 = g_pmdl_m.pmdl003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl003
            #add-point:BEFORE FIELD pmdl003 name="input.b.pmdl003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl003
            #add-point:ON CHANGE pmdl003 name="input.g.pmdl003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlstus
            #add-point:BEFORE FIELD pmdlstus name="input.b.pmdlstus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlstus
            
            #add-point:AFTER FIELD pmdlstus name="input.a.pmdlstus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdlstus
            #add-point:ON CHANGE pmdlstus name="input.g.pmdlstus"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl007
            #add-point:BEFORE FIELD pmdl007 name="input.b.pmdl007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl007
            
            #add-point:AFTER FIELD pmdl007 name="input.a.pmdl007"
            CALL apmt840_set_entry(p_cmd)
            CALL apmt840_set_no_required()
            CALL apmt840_set_required()
            CALL apmt840_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl007
            #add-point:ON CHANGE pmdl007 name="input.g.pmdl007"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl008
            #add-point:BEFORE FIELD pmdl008 name="input.b.pmdl008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl008
            
            #add-point:AFTER FIELD pmdl008 name="input.a.pmdl008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl008
            #add-point:ON CHANGE pmdl008 name="input.g.pmdl008"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl027
            
            #add-point:AFTER FIELD pmdl027 name="input.a.pmdl027"
            LET g_pmdl_m.pmdl027_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl027_desc
            IF NOT cl_null(g_pmdl_m.pmdl027) THEN
               IF g_pmdl_m.pmdl027 != g_pmdl_m_o.pmdl027 OR cl_null(g_pmdl_m_o.pmdl027) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl004
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl027
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00257:sub-01302|apmi005|",cl_get_progname("apmi005",g_lang,"2"),"|:EXEPROGapmi005"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_pmaj002") THEN
                     LET g_pmdl_m.pmdl027 = g_pmdl_m_o.pmdl027
                     CALL apmt840_pmdl027_ref(g_pmdl_m.pmdl027) RETURNING g_pmdl_m.pmdl027_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl027_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmt840_pmdl027_ref(g_pmdl_m.pmdl027) RETURNING g_pmdl_m.pmdl027_desc
            DISPLAY BY NAME g_pmdl_m.pmdl027_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl027
            #add-point:BEFORE FIELD pmdl027 name="input.b.pmdl027"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl027
            #add-point:ON CHANGE pmdl027 name="input.g.pmdl027"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl201
            #add-point:BEFORE FIELD pmdl201 name="input.b.pmdl201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl201
            
            #add-point:AFTER FIELD pmdl201 name="input.a.pmdl201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl201
            #add-point:ON CHANGE pmdl201 name="input.g.pmdl201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl202
            #add-point:BEFORE FIELD pmdl202 name="input.b.pmdl202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl202
            
            #add-point:AFTER FIELD pmdl202 name="input.a.pmdl202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl202
            #add-point:ON CHANGE pmdl202 name="input.g.pmdl202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl204
            
            #add-point:AFTER FIELD pmdl204 name="input.a.pmdl204"
            LET g_pmdl_m.pmdl204_desc = ' '
            DISPLAY BY NAME g_pmdl_m.pmdl204_desc
            IF NOT cl_null(g_pmdl_m.pmdl204) THEN
               IF g_pmdl_m.pmdl204 != g_pmdl_m_o.pmdl204 OR cl_null(g_pmdl_m_o.pmdl204) THEN
                  IF s_aooi500_setpoint(g_prog,'pmdl204') THEN
                     CALL s_aooi500_chk(g_prog,'pmdl204',g_pmdl_m.pmdl204,g_pmdl_m.pmdlsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_pmdl_m.pmdl204 = g_pmdl_m_o.pmdl204
                        CALL s_desc_get_department_desc(g_pmdl_m.pmdl204) RETURNING g_pmdl_m.pmdl204_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl204_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmdl_m.pmdl204
                     IF NOT cl_chk_exist("v_ooef001_33") THEN
                        LET g_pmdl_m.pmdl204 = g_pmdl_m_o.pmdl204
                        CALL s_desc_get_department_desc(g_pmdl_m.pmdl204) RETURNING g_pmdl_m.pmdl204_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl204_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL apmt840_addr_default(1)
               END IF
            END IF
            LET g_pmdl_m_o.pmdl204 = g_pmdl_m.pmdl204
            LET g_pmdl_m_o.pmdl025 = g_pmdl_m.pmdl025
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl204) RETURNING g_pmdl_m.pmdl204_desc
            DISPLAY BY NAME g_pmdl_m.pmdl204_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl204
            #add-point:BEFORE FIELD pmdl204 name="input.b.pmdl204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl204
            #add-point:ON CHANGE pmdl204 name="input.g.pmdl204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl207
            
            #add-point:AFTER FIELD pmdl207 name="input.a.pmdl207"
            #150610-00030#1 150612 By sakura add(S)
            LET g_pmdl_m.pmdl207_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl207_desc
            IF NOT cl_null(g_pmdl_m.pmdl207) THEN
               IF g_pmdl_m.pmdl207 != g_pmdl_m_o.pmdl207 OR cl_null(g_pmdl_m_o.pmdl207) THEN
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl207
                  #取得品類管理層級
                  CALL cl_get_para(g_enterprise,g_pmdl_m.pmdlsite,'E-CIR-0001') RETURNING l_sys
                  LET g_chkparam.arg2 = l_sys
                   #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     LET g_pmdl_m.pmdl207 = g_pmdl_m_o.pmdl207
                     CALL s_desc_get_rtaxl003_desc(g_pmdl_m.pmdl207) RETURNING g_pmdl_m.pmdl207_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl207_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #部門品類(arti204)控卡
               IF NOT cl_null(g_pmdl_m.pmdl003) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_pmdl_m.pmdl003
                        AND rtay002 = g_pmdl_m.pmdl207
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_pmdl_m.pmdl207 = g_pmdl_m_o.pmdl207
                        CALL s_desc_get_rtaxl003_desc(g_pmdl_m.pmdl207) RETURNING g_pmdl_m.pmdl207_desc
                        DISPLAY BY NAME g_pmdl_m.pmdl207_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF  

            END IF
            #Add By Ken #151027-00013#1(S) 取合約中的進項稅別
            IF (NOT cl_null(g_pmdl_m.pmdl200)) AND (NOT cl_null(g_pmdl_m.pmdl004)) THEN
               CALL s_apmt840_get_stan007(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004,g_pmdl_m.pmdl200,g_pmdl_m.pmdl207)
                RETURNING l_success,g_pmdl_m.pmdl011,l_stboacti,l_staqacti
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-01030'
                  LET g_errparam.extend = ""
                  LET g_errparam.replace[1] = g_pmdl_m.pmdl004
                  LET g_errparam.replace[2] = g_pmdl_m.pmdl200
                  LET g_errparam.replace[3] = g_pmdl_m.pmdl207
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_pmdl_m.pmdl207 = g_pmdl_m_o.pmdl207
                  CALL s_desc_get_rtaxl003_desc(g_pmdl_m.pmdl207) RETURNING g_pmdl_m.pmdl207_desc
                  DISPLAY BY NAME g_pmdl_m.pmdl207_desc                  
                  NEXT FIELD CURRENT 
               END IF
            END IF
            #Add By Ken #151027-00013#1(E)            
            LET g_pmdl_m_o.pmdl207 = g_pmdl_m.pmdl207             
            CALL s_desc_get_rtaxl003_desc(g_pmdl_m.pmdl207) RETURNING g_pmdl_m.pmdl207_desc
            DISPLAY BY NAME g_pmdl_m.pmdl207_desc
            #150610-00030#1 150612 By sakura add(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl207
            #add-point:BEFORE FIELD pmdl207 name="input.b.pmdl207"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl207
            #add-point:ON CHANGE pmdl207 name="input.g.pmdl207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdlunit
            
            #add-point:AFTER FIELD pmdlunit name="input.a.pmdlunit"
            LET g_pmdl_m.pmdlunit_desc = ' '
            DISPLAY BY NAME g_pmdl_m.pmdlunit_desc
            IF NOT cl_null(g_pmdl_m.pmdlunit) THEN
               IF g_pmdl_m.pmdlunit != g_pmdl_m_o.pmdlunit OR cl_null(g_pmdl_m_o.pmdlunit) THEN
                  CALL s_aooi500_chk(g_prog,'pmdlunit',g_pmdl_m.pmdlunit,g_pmdl_m.pmdlsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_pmdl_m.pmdlunit = g_pmdl_m_o.pmdlunit
                     CALL s_desc_get_department_desc(g_pmdl_m.pmdlunit) RETURNING g_pmdl_m.pmdlunit_desc
                     DISPLAY BY NAME g_pmdl_m.pmdlunit_desc
                     NEXT FIELD CURRENT
                  END IF
                  #當不等於統採越庫的時候 才帶出出貨組織的預設地址碼
                  IF g_pmdl_m.pmdl203 = '3' THEN
                  ELSE
                     CALL apmt840_addr_default(1)
                  END IF
                  #150512-00029#2 150525 By pomelo add(S)
                  IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN
                  #150512-00029#2 150525 By pomelo add(E)
                     #150407-00020#1  Add By Ken 150410
                     #取的訂單有效期
                     CALL apmt840_get_rtka010(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010
                     #採購失效日(到庫日期+訂單有效期)
                     IF cl_null(l_rtka010)  THEN
                        LET g_pmdl_m.pmdl205 = NULL
                     ELSE
                        LET g_pmdl_m.pmdl205 = g_pmdl_m.pmdldocdt + l_rtka010                 
                     END IF                               
                     #150407-00020#1
                  END IF   #150512-00029#2 150525 By pomelo add
               END IF
            ELSE
               LET g_pmdl_m.pmdl205 = NULL            
            END IF
            LET g_pmdl_m_o.pmdlunit = g_pmdl_m.pmdlunit
            LET g_pmdl_m_o.pmdl025 = g_pmdl_m.pmdl025
            CALL s_desc_get_department_desc(g_pmdl_m.pmdlunit) RETURNING g_pmdl_m.pmdlunit_desc
            DISPLAY BY NAME g_pmdl_m.pmdlunit_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdlunit
            #add-point:BEFORE FIELD pmdlunit name="input.b.pmdlunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdlunit
            #add-point:ON CHANGE pmdlunit name="input.g.pmdlunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl029
            
            #add-point:AFTER FIELD pmdl029 name="input.a.pmdl029"
            LET g_pmdl_m.pmdl029_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl029_desc 
            IF NOT cl_null(g_pmdl_m.pmdl029) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdl_m.pmdl029 != g_pmdl_m_t.pmdl029 OR g_pmdl_m_t.pmdl029 IS NULL)) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdl_m.pmdl029 != g_pmdl_m_o.pmdl029 OR cl_null(g_pmdl_m_o.pmdl029) THEN   #160824-00007#12 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl029
                  LET g_chkparam.arg2 = g_pmdl_m.pmdldocdt
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     #LET g_pmdl_m.pmdl003 = g_pmdl_m_t.pmdl029   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdl_m.pmdl029 = g_pmdl_m_o.pmdl029    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_department_desc(g_pmdl_m.pmdl029) RETURNING g_pmdl_m.pmdl029_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl029_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl029 = g_pmdl_m.pmdl029   #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl029) RETURNING g_pmdl_m.pmdl029_desc
            DISPLAY BY NAME g_pmdl_m.pmdl029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl029
            #add-point:BEFORE FIELD pmdl029 name="input.b.pmdl029"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl029
            #add-point:ON CHANGE pmdl029 name="input.g.pmdl029"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl025
            
            #add-point:AFTER FIELD pmdl025 name="input.a.pmdl025"
            LET g_pmdl_m.pmdl025_desc = ''
            LET g_pmdl_m.oofb017 = ''
            DISPLAY BY NAME g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
            IF NOT cl_null(g_pmdl_m.pmdl025) THEN 
               IF g_pmdl_m.pmdl025 <> g_pmdl_m_o.pmdl025 OR cl_null(g_pmdl_m_o.pmdl025) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef012
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl025
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_oofb019_1") THEN
                     LET g_pmdl_m.pmdl025 = g_pmdl_m_o.pmdl025
                     CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,l_ooef001) RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
                     DISPLAY BY NAME g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl025 = g_pmdl_m.pmdl025
            CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,l_ooef001) RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
            DISPLAY BY NAME g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl025
            #add-point:BEFORE FIELD pmdl025 name="input.b.pmdl025"
            LET l_ooef012 = ''
            IF g_pmdl_m.pmdl203 = '3' THEN
               CALL s_apmt840_get_ooef012(g_pmdl_m.pmdl204) RETURNING l_ooef012
               LET l_ooef001 = g_pmdl_m.pmdl204
            ELSE
               CALL s_apmt840_get_ooef012(g_pmdl_m.pmdlunit) RETURNING l_ooef012
               LET l_ooef001 = g_pmdl_m.pmdlunit
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl025
            #add-point:ON CHANGE pmdl025 name="input.g.pmdl025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl206
            #add-point:BEFORE FIELD pmdl206 name="input.b.pmdl206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl206
            
            #add-point:AFTER FIELD pmdl206 name="input.a.pmdl206"
            #150512-00029#2 150525 By pomelo add(S)
            IF NOT cl_null(g_pmdl_m.pmdl206) THEN
               IF g_pmdl_m.pmdl206 != g_pmdl_m_o.pmdl206 OR cl_null(g_pmdl_m_o.pmdl206) THEN
                  IF g_pmdl_m.pmdl206 = 'N' THEN
                     IF NOT cl_null(g_pmdl_m.pmdl004) AND NOT cl_null(g_pmdl_m.pmdlsite) THEN
                        #取的訂單有效期
                        CALL apmt840_get_rtka010(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl004)
                           RETURNING l_rtka010
                        #採購失效日(到庫日期+訂單有效期)
                        IF cl_null(l_rtka010)  THEN
                           LET g_pmdl_m.pmdl205 = NULL
                        ELSE
                           LET g_pmdl_m.pmdl205 = g_pmdl_m.pmdldocdt + l_rtka010                 
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl206 = g_pmdl_m.pmdl206
            LET g_pmdl_m_o.pmdl205 = g_pmdl_m.pmdl205
            CALL apmt840_set_no_required()
            CALL apmt840_set_required()
            #150512-00029#2 150525 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl206
            #add-point:ON CHANGE pmdl206 name="input.g.pmdl206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl205
            #add-point:BEFORE FIELD pmdl205 name="input.b.pmdl205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl205
            
            #add-point:AFTER FIELD pmdl205 name="input.a.pmdl205"
            #150604-00026#1 150608 By pomelo add(S)
            IF NOT cl_null(g_pmdl_m.pmdl205) THEN
               IF g_pmdl_m.pmdl205 != g_pmdl_m_o.pmdl205 OR cl_null(g_pmdl_m_o.pmdl205) THEN
                  IF NOT apmt840_chk_pmdl205() THEN
                     LET g_pmdl_m.pmdl205 = g_pmdl_m_o.pmdl205
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl205 = g_pmdl_m.pmdl205
            #150604-00026#1 150608 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl205
            #add-point:ON CHANGE pmdl205 name="input.g.pmdl205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl023
            
            #add-point:AFTER FIELD pmdl023 name="input.a.pmdl023"
            LET g_pmdl_m.pmdl023_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl023_desc
            IF NOT cl_null(g_pmdl_m.pmdl023) THEN
               IF g_pmdl_m.pmdl023 != g_pmdl_m_o.pmdl023 OR cl_null(g_pmdl_m_o.pmdl023) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl023
                  LET g_chkparam.arg2 = '2'
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     LET g_pmdl_m.pmdl023 = g_pmdl_m_o.pmdl023
                     CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl023_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl023 = g_pmdl_m.pmdl023
            CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc
            DISPLAY BY NAME g_pmdl_m.pmdl023_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl023
            #add-point:BEFORE FIELD pmdl023 name="input.b.pmdl023"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl023
            #add-point:ON CHANGE pmdl023 name="input.g.pmdl023"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl022
            
            #add-point:AFTER FIELD pmdl022 name="input.a.pmdl022"
            LET g_pmdl_m.pmdl022_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl022_desc 
            IF NOT cl_null(g_pmdl_m.pmdl022) THEN
               IF g_pmdl_m.pmdl022 != g_pmdl_m_o.pmdl022 OR cl_null(g_pmdl_m_o.pmdl022) THEN
                  IF NOT s_adb_chk_pmac002(2,g_pmdl_m.pmdl004,g_pmdl_m.pmdl022,'2') THEN
                     LET g_pmdl_m.pmdl022 = g_pmdl_m_o.pmdl022
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl022) RETURNING g_pmdl_m.pmdl022_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl022_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl022 = g_pmdl_m.pmdl022
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl022) RETURNING g_pmdl_m.pmdl022_desc
            DISPLAY BY NAME g_pmdl_m.pmdl022_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl022
            #add-point:BEFORE FIELD pmdl022 name="input.b.pmdl022"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl022
            #add-point:ON CHANGE pmdl022 name="input.g.pmdl022"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl021
            
            #add-point:AFTER FIELD pmdl021 name="input.a.pmdl021"
            LET g_pmdl_m.pmdl021_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl021_desc 
            IF NOT cl_null(g_pmdl_m.pmdl021) THEN
               IF g_pmdl_m.pmdl021 != g_pmdl_m_o.pmdl021 OR cl_null(g_pmdl_m_o.pmdl021) THEN
                  IF NOT s_adb_chk_pmac002(2,g_pmdl_m.pmdl004,g_pmdl_m.pmdl021,'1') THEN
                     LET g_pmdl_m.pmdl021 = g_pmdl_m_o.pmdl021
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl021) RETURNING g_pmdl_m.pmdl021_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl021_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl021 = g_pmdl_m.pmdl021
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl021) RETURNING g_pmdl_m.pmdl021_desc
            DISPLAY BY NAME g_pmdl_m.pmdl021_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl021
            #add-point:BEFORE FIELD pmdl021 name="input.b.pmdl021"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl021
            #add-point:ON CHANGE pmdl021 name="input.g.pmdl021"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl047
            #add-point:BEFORE FIELD pmdl047 name="input.b.pmdl047"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl047
            
            #add-point:AFTER FIELD pmdl047 name="input.a.pmdl047"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl047
            #add-point:ON CHANGE pmdl047 name="input.g.pmdl047"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl054
            #add-point:BEFORE FIELD pmdl054 name="input.b.pmdl054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl054
            
            #add-point:AFTER FIELD pmdl054 name="input.a.pmdl054"
            #取匯率
            IF NOT cl_null(g_pmdl_m.pmdl054) THEN
               IF g_pmdl_m.pmdl054 != g_pmdl_m_o.pmdl054 OR cl_null(g_pmdl_m_o.pmdl054) THEN
                  CALL s_apmt840_pmdl016_default(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdl_m.pmdl054)
                     RETURNING g_pmdl_m.pmdl016
                  DISPLAY BY NAME g_pmdl_m.pmdl016
               END IF
            END IF
            LET g_pmdl_m_o.pmdl054 = g_pmdl_m.pmdl054
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl054
            #add-point:ON CHANGE pmdl054 name="input.g.pmdl054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl055
            #add-point:BEFORE FIELD pmdl055 name="input.b.pmdl055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl055
            
            #add-point:AFTER FIELD pmdl055 name="input.a.pmdl055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl055
            #add-point:ON CHANGE pmdl055 name="input.g.pmdl055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl009
            
            #add-point:AFTER FIELD pmdl009 name="input.a.pmdl009"
            LET g_pmdl_m.pmdl009_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl009_desc
            IF NOT cl_null(g_pmdl_m.pmdl009) THEN
               IF g_pmdl_m.pmdl009 != g_pmdl_m_o.pmdl009 OR cl_null(g_pmdl_m_o.pmdl009) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl004
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl009
                  IF NOT cl_chk_exist("v_pmad002_1") THEN
                     LET g_pmdl_m.pmdl009 = g_pmdl_m_o.pmdl009
                     CALL s_desc_get_ooib002_desc(g_pmdl_m.pmdl009) RETURNING g_pmdl_m.pmdl009_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl009_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl009 = g_pmdl_m.pmdl009
            CALL s_desc_get_ooib002_desc(g_pmdl_m.pmdl009) RETURNING g_pmdl_m.pmdl009_desc
            DISPLAY BY NAME g_pmdl_m.pmdl009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl009
            #add-point:BEFORE FIELD pmdl009 name="input.b.pmdl009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl009
            #add-point:ON CHANGE pmdl009 name="input.g.pmdl009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl015
            
            #add-point:AFTER FIELD pmdl015 name="input.a.pmdl015"
            LET g_pmdl_m.pmdl015_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl015_desc
            IF NOT cl_null(g_pmdl_m.pmdl015) THEN
               IF g_pmdl_m.pmdl015 != g_pmdl_m_o.pmdl015 OR cl_null(g_pmdl_m_o.pmdl015) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdlsite
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl015
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#21  by 07900 --add-end 
                  IF cl_chk_exist("v_ooaj002") THEN
                     CALL s_apmt840_pmdl016_default(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdl_m.pmdl054)
                        RETURNING g_pmdl_m.pmdl016
                     DISPLAY BY NAME g_pmdl_m.pmdl016
                  ELSE
                     LET g_pmdl_m.pmdl015 = g_pmdl_m_o.pmdl015
                     CALL s_desc_get_currency_desc(g_pmdl_m.pmdl015) RETURNING g_pmdl_m.pmdl015_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl015 = g_pmdl_m.pmdl015
            CALL s_desc_get_currency_desc(g_pmdl_m.pmdl015) RETURNING g_pmdl_m.pmdl015_desc
            DISPLAY BY NAME g_pmdl_m.pmdl015_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl015
            #add-point:BEFORE FIELD pmdl015 name="input.b.pmdl015"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl015
            #add-point:ON CHANGE pmdl015 name="input.g.pmdl015"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl016
            #add-point:BEFORE FIELD pmdl016 name="input.b.pmdl016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl016
            
            #add-point:AFTER FIELD pmdl016 name="input.a.pmdl016"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl016
            #add-point:ON CHANGE pmdl016 name="input.g.pmdl016"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl010
            
            #add-point:AFTER FIELD pmdl010 name="input.a.pmdl010"
            LET g_pmdl_m.pmdl010_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl010_desc
            IF NOT cl_null(g_pmdl_m.pmdl010) THEN
               IF g_pmdl_m.pmdl010 != g_pmdl_m_o.pmdl010 OR cl_null(g_pmdl_m_o.pmdl010) THEN
                  IF NOT s_azzi650_chk_exist('238',g_pmdl_m.pmdl010) THEN
                     LET g_pmdl_m.pmdl010 = g_pmdl_m_o.pmdl010
                     CALL s_desc_get_acc_desc('238',g_pmdl_m.pmdl010) RETURNING g_pmdl_m.pmdl010_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl010 = g_pmdl_m.pmdl010
            CALL s_desc_get_acc_desc('238',g_pmdl_m.pmdl010) RETURNING g_pmdl_m.pmdl010_desc
            DISPLAY BY NAME g_pmdl_m.pmdl010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl010
            #add-point:BEFORE FIELD pmdl010 name="input.b.pmdl010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl010
            #add-point:ON CHANGE pmdl010 name="input.g.pmdl010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl011
            
            #add-point:AFTER FIELD pmdl011 name="input.a.pmdl011"
            LET g_pmdl_m.pmdl011_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl011_desc
            
            IF NOT cl_null(g_pmdl_m.pmdl011) THEN
               IF g_pmdl_m.pmdl011 <> g_pmdl_m_o.pmdl011 OR cl_null(g_pmdl_m_o.pmdl011) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdlsite
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl011
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#21  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_pmdl_m.pmdl011 = g_pmdl_m_o.pmdl011
                     CALL s_desc_get_tax_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING g_pmdl_m.pmdl011_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl011_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_adb_oodb002_default(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011)
                     RETURNING g_pmdl_m.pmdl013,g_pmdl_m.pmdl012
               END IF
            END IF
            LET g_pmdl_m_o.pmdl011 = g_pmdl_m.pmdl011
            LET g_pmdl_m_o.pmdl012 = g_pmdl_m.pmdl012
            LET g_pmdl_m_o.pmdl013 = g_pmdl_m.pmdl013
            CALL s_desc_get_tax_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING g_pmdl_m.pmdl011_desc
            DISPLAY BY NAME g_pmdl_m.pmdl011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl011
            #add-point:BEFORE FIELD pmdl011 name="input.b.pmdl011"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl011
            #add-point:ON CHANGE pmdl011 name="input.g.pmdl011"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl012
            #add-point:BEFORE FIELD pmdl012 name="input.b.pmdl012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl012
            
            #add-point:AFTER FIELD pmdl012 name="input.a.pmdl012"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl012
            #add-point:ON CHANGE pmdl012 name="input.g.pmdl012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl013
            #add-point:BEFORE FIELD pmdl013 name="input.b.pmdl013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl013
            
            #add-point:AFTER FIELD pmdl013 name="input.a.pmdl013"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl013
            #add-point:ON CHANGE pmdl013 name="input.g.pmdl013"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl033
            
            #add-point:AFTER FIELD pmdl033 name="input.a.pmdl033"
            LET g_pmdl_m.pmdl033_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl033_desc
            IF NOT cl_null(g_pmdl_m.pmdl033) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdl_m.pmdl033 != g_pmdl_m_t.pmdl033 OR g_pmdl_m_t.pmdl033 IS NULL )) THEN   #160824-00007#12 20160914 add by beckxie
               IF g_pmdl_m.pmdl033 != g_pmdl_m_o.pmdl033 OR cl_null(g_pmdl_m_o.pmdl033) THEN   #160824-00007#12 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef019
                  LET g_chkparam.arg2 = g_pmdl_m.pmdl033
                  IF NOT cl_chk_exist("v_isac002_1") THEN
                     #LET g_pmdl_m.pmdl033 = g_pmdl_m_t.pmdl033   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdl_m.pmdl033 = g_pmdl_m_o.pmdl033   #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_invoice_type_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl033) RETURNING g_pmdl_m.pmdl033_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl033_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl033 = g_pmdl_m.pmdl033   #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_invoice_type_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl033) RETURNING g_pmdl_m.pmdl033_desc
            DISPLAY BY NAME g_pmdl_m.pmdl033_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl033
            #add-point:BEFORE FIELD pmdl033 name="input.b.pmdl033"
            LET l_ooef019 = ''
            CALL apmt840_get_ooef019(g_pmdl_m.pmdlsite) RETURNING l_ooef019
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl033
            #add-point:ON CHANGE pmdl033 name="input.g.pmdl033"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl024
            
            #add-point:AFTER FIELD pmdl024 name="input.a.pmdl024"
            LET g_pmdl_m.pmdl024_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl024_desc
                  
            IF NOT cl_null(g_pmdl_m.pmdl024) THEN
               IF g_pmdl_m.pmdl024 != g_pmdl_m_o.pmdl024 OR cl_null(g_pmdl_m_o.pmdl024) THEN
                  IF NOT s_azzi650_chk_exist('264',g_pmdl_m.pmdl024) THEN
                     LET g_pmdl_m.pmdl024 = g_pmdl_m_o.pmdl024
                     CALL s_desc_get_acc_desc('264',g_pmdl_m.pmdl024) RETURNING g_pmdl_m.pmdl024_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl024_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl024 = g_pmdl_m.pmdl024
            CALL s_desc_get_acc_desc('264',g_pmdl_m.pmdl024) RETURNING g_pmdl_m.pmdl024_desc
            DISPLAY BY NAME g_pmdl_m.pmdl024_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl024
            #add-point:BEFORE FIELD pmdl024 name="input.b.pmdl024"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl024
            #add-point:ON CHANGE pmdl024 name="input.g.pmdl024"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl043
            
            #add-point:AFTER FIELD pmdl043 name="input.a.pmdl043"
            #LET g_pmdl_m.pmdl043_desc = ''
            #DISPLAY BY NAME g_pmdl_m.pmdl043_desc
            #
            #IF NOT cl_null(g_pmdl_m.pmdl043) THEN 
            #   IF NOT s_azzi650_chk_exist('298',g_pmdl_m.pmdl043) THEN
            #      LET g_pmdl_m.pmdl043 = g_pmdl_m_t.pmdl043
            #      CALL s_desc_get_acc_desc('298',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc
            #      DISPLAY BY NAME g_pmdl_m.pmdl043_desc
            #   END IF
            #END IF
            #
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl043
            #add-point:BEFORE FIELD pmdl043 name="input.b.pmdl043"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl043
            #add-point:ON CHANGE pmdl043 name="input.g.pmdl043"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl020
            
            #add-point:AFTER FIELD pmdl020 name="input.a.pmdl020"
            LET g_pmdl_m.pmdl020_desc = ''
            DISPLAY BY NAME g_pmdl_m.pmdl020_desc
            IF NOT cl_null(g_pmdl_m.pmdl020) THEN
               IF g_pmdl_m.pmdl020 != g_pmdl_m_o.pmdl020 OR cl_null(g_pmdl_m_o.pmdl020) THEN
                  IF NOT s_azzi650_chk_exist('263',g_pmdl_m.pmdl020) THEN
                     LET g_pmdl_m.pmdl020 = g_pmdl_m_t.pmdl020
                     CALL s_desc_get_acc_desc('263',g_pmdl_m.pmdl020) RETURNING g_pmdl_m.pmdl020_desc
                     DISPLAY BY NAME g_pmdl_m.pmdl020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdl_m_o.pmdl020 = g_pmdl_m.pmdl020
            CALL s_desc_get_acc_desc('263',g_pmdl_m.pmdl020) RETURNING g_pmdl_m.pmdl020_desc
            DISPLAY BY NAME g_pmdl_m.pmdl020_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl020
            #add-point:BEFORE FIELD pmdl020 name="input.b.pmdl020"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl020
            #add-point:ON CHANGE pmdl020 name="input.g.pmdl020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl044
            #add-point:BEFORE FIELD pmdl044 name="input.b.pmdl044"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl044
            
            #add-point:AFTER FIELD pmdl044 name="input.a.pmdl044"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl044
            #add-point:ON CHANGE pmdl044 name="input.g.pmdl044"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl006
            #add-point:BEFORE FIELD pmdl006 name="input.b.pmdl006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl006
            
            #add-point:AFTER FIELD pmdl006 name="input.a.pmdl006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl006
            #add-point:ON CHANGE pmdl006 name="input.g.pmdl006"
                         
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl028
            #add-point:BEFORE FIELD pmdl028 name="input.b.pmdl028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl028
            
            #add-point:AFTER FIELD pmdl028 name="input.a.pmdl028"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl028
            #add-point:ON CHANGE pmdl028 name="input.g.pmdl028"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl042
            #add-point:BEFORE FIELD pmdl042 name="input.b.pmdl042"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl042
            
            #add-point:AFTER FIELD pmdl042 name="input.a.pmdl042"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl042
            #add-point:ON CHANGE pmdl042 name="input.g.pmdl042"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl048
            #add-point:BEFORE FIELD pmdl048 name="input.b.pmdl048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl048
            
            #add-point:AFTER FIELD pmdl048 name="input.a.pmdl048"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl048
            #add-point:ON CHANGE pmdl048 name="input.g.pmdl048"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl049
            #add-point:BEFORE FIELD pmdl049 name="input.b.pmdl049"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl049
            
            #add-point:AFTER FIELD pmdl049 name="input.a.pmdl049"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl049
            #add-point:ON CHANGE pmdl049 name="input.g.pmdl049"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl046
            #add-point:BEFORE FIELD pmdl046 name="input.b.pmdl046"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl046
            
            #add-point:AFTER FIELD pmdl046 name="input.a.pmdl046"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl046
            #add-point:ON CHANGE pmdl046 name="input.g.pmdl046"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl040
            #add-point:BEFORE FIELD pmdl040 name="input.b.pmdl040"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl040
            
            #add-point:AFTER FIELD pmdl040 name="input.a.pmdl040"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl040
            #add-point:ON CHANGE pmdl040 name="input.g.pmdl040"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl041
            #add-point:BEFORE FIELD pmdl041 name="input.b.pmdl041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl041
            
            #add-point:AFTER FIELD pmdl041 name="input.a.pmdl041"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl041
            #add-point:ON CHANGE pmdl041 name="input.g.pmdl041"
                        
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdlsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlsite
            #add-point:ON ACTION controlp INFIELD pmdlsite name="input.c.pmdlsite"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdlsite

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlsite','','i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()
            LET g_pmdl_m.pmdlsite = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdlsite TO pmdlsite
            CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite) RETURNING g_pmdl_m.pmdlsite_desc
            DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
            NEXT FIELD pmdlsite
            #END add-point
 
 
         #Ctrlp:input.c.pmdldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocdt
            #add-point:ON ACTION controlp INFIELD pmdldocdt name="input.c.pmdldocdt"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocno
            #add-point:ON ACTION controlp INFIELD pmdldocno name="input.c.pmdldocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdldocno  #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                            #呼叫開窗
            LET g_pmdl_m.pmdldocno = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_m.pmdldocno TO pmdldocno       #顯示到畫面上
            NEXT FIELD pmdldocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl001
            #add-point:ON ACTION controlp INFIELD pmdl001 name="input.c.pmdl001"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl005
            #add-point:ON ACTION controlp INFIELD pmdl005 name="input.c.pmdl005"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl200
            #add-point:ON ACTION controlp INFIELD pmdl200 name="input.c.pmdl200"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl200       #給予default值

            #給予arg
            IF s_aooi500_setpoint(g_prog,'pmdl200') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl200',g_pmdl_m.pmdlsite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef303 = 'Y'"
               CALL q_ooef001()                    #呼叫開窗
            END IF
            LET g_pmdl_m.pmdl200 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl200 TO pmdl200
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl200) RETURNING g_pmdl_m.pmdl200_desc
            DISPLAY BY NAME g_pmdl_m.pmdl200_desc
            NEXT FIELD pmdl200                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl004
            #add-point:ON ACTION controlp INFIELD pmdl004 name="input.c.pmdl004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl004   #給予default值
            
            CALL q_pmaa001_3()                           #呼叫開窗
            LET g_pmdl_m.pmdl004 = g_qryparam.return1    #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_m.pmdl004 TO pmdl004          #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004)
               RETURNING g_pmdl_m.pmdl004_desc
            DISPLAY BY NAME g_pmdl_m.pmdl004_desc
            NEXT FIELD pmdl004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdl203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl203
            #add-point:ON ACTION controlp INFIELD pmdl203 name="input.c.pmdl203"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl002
            #add-point:ON ACTION controlp INFIELD pmdl002 name="input.c.pmdl002"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdl_m.pmdl002             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pmdl_m.pmdl002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdl_m.pmdl002 TO pmdl002              #顯示到畫面上
            CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
            DISPLAY BY NAME g_pmdl_m.pmdl002_desc

            NEXT FIELD pmdl002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl003
            #add-point:ON ACTION controlp INFIELD pmdl003 name="input.c.pmdl003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl003

            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdldocdt
            CALL q_ooeg001()
            LET g_pmdl_m.pmdl003 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl003 TO pmdl003
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
            DISPLAY BY NAME g_pmdl_m.pmdl003_desc
            NEXT FIELD pmdl003
            #END add-point
 
 
         #Ctrlp:input.c.pmdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlstus
            #add-point:ON ACTION controlp INFIELD pmdlstus name="input.c.pmdlstus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl007
            #add-point:ON ACTION controlp INFIELD pmdl007 name="input.c.pmdl007"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl008
            #add-point:ON ACTION controlp INFIELD pmdl008 name="input.c.pmdl008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl027
            #add-point:ON ACTION controlp INFIELD pmdl027 name="input.c.pmdl027"
                        #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl027
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            CALL q_pmaj002()
            LET g_pmdl_m.pmdl027 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl027 TO pmdl027
            CALL apmt840_pmdl027_ref(g_pmdl_m.pmdl027) RETURNING g_pmdl_m.pmdl027_desc
            DISPLAY BY NAME g_pmdl_m.pmdl027_desc
            NEXT FIELD pmdl027
            #END add-point
 
 
         #Ctrlp:input.c.pmdl201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl201
            #add-point:ON ACTION controlp INFIELD pmdl201 name="input.c.pmdl201"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl202
            #add-point:ON ACTION controlp INFIELD pmdl202 name="input.c.pmdl202"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl204
            #add-point:ON ACTION controlp INFIELD pmdl204 name="input.c.pmdl204"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl204             #給予default值

            #給予arg
            IF s_aooi500_setpoint(g_prog,'pmdl204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl204',g_pmdl_m.pmdlsite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef302 = 'Y'"
               CALL q_ooef001()                    #呼叫開窗
            END IF
            LET g_pmdl_m.pmdl204 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl204 TO pmdl204
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl204) RETURNING g_pmdl_m.pmdl204_desc
            DISPLAY BY NAME g_pmdl_m.pmdl204_desc
            NEXT FIELD pmdl204                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdl207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl207
            #add-point:ON ACTION controlp INFIELD pmdl207 name="input.c.pmdl207"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl207             #給予default值
            #150610-00030#1 150612 By sakura add(S)
            #取得品類管理層級
            CALL cl_get_para(g_enterprise,g_pmdl_m.pmdlsite,'E-CIR-0001') RETURNING l_sys
            LET g_qryparam.arg1 = l_sys
            
            #部門品類(arti204)控卡
            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_pmdl_m.pmdl003,"' AND rtaystus = 'Y') "
            END IF
            
            CALL q_rtax001_3()                                #呼叫開窗
            LET g_pmdl_m.pmdl207 = g_qryparam.return1              
            DISPLAY g_pmdl_m.pmdl207 TO pmdl207              #
            CALL s_desc_get_rtaxl003_desc(g_pmdl_m.pmdl207) RETURNING g_pmdl_m.pmdl207_desc
            DISPLAY BY NAME g_pmdl_m.pmdl207_desc            
            #150610-00030#1 150612 By sakura add(E)
            NEXT FIELD pmdl207                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdlunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdlunit
            #add-point:ON ACTION controlp INFIELD pmdlunit name="input.c.pmdlunit"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdlunit
            
            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlunit',g_pmdl_m.pmdlsite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()
            LET g_pmdl_m.pmdlunit = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdlunit TO pmdlunit
            CALL s_desc_get_department_desc(g_pmdl_m.pmdlunit) RETURNING g_pmdl_m.pmdlunit_desc
            DISPLAY BY NAME g_pmdl_m.pmdlunit_desc
            NEXT FIELD pmdlunit
            #END add-point
 
 
         #Ctrlp:input.c.pmdl029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl029
            #add-point:ON ACTION controlp INFIELD pmdl029 name="input.c.pmdl029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl029

            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdldocdt
            CALL q_ooeg001()
            LET g_pmdl_m.pmdl029 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl029 TO pmdl029
            CALL s_desc_get_department_desc(g_pmdl_m.pmdl029) RETURNING g_pmdl_m.pmdl029_desc
            DISPLAY BY NAME g_pmdl_m.pmdl029_desc
            NEXT FIELD pmdl029
            #END add-point
 
 
         #Ctrlp:input.c.pmdl025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl025
            #add-point:ON ACTION controlp INFIELD pmdl025 name="input.c.pmdl025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl025
            
            #給予arg
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '3' "  #出貨地址

            CALL q_oofb019_1()
            LET g_pmdl_m.pmdl025 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl025 TO pmdl025
            CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,l_ooef001) RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
            DISPLAY BY NAME g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
            NEXT FIELD pmdl025
            #END add-point
 
 
         #Ctrlp:input.c.pmdl206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl206
            #add-point:ON ACTION controlp INFIELD pmdl206 name="input.c.pmdl206"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl205
            #add-point:ON ACTION controlp INFIELD pmdl205 name="input.c.pmdl205"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl023
            #add-point:ON ACTION controlp INFIELD pmdl023 name="input.c.pmdl023"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl023
            
            #給予arg
            LET g_qryparam.arg1 = "2" 
            CALL q_oojd001_1()
            LET g_pmdl_m.pmdl023 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl023 TO pmdl023
            CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc
            DISPLAY BY NAME g_pmdl_m.pmdl023_desc
            NEXT FIELD pmdl023
            #END add-point
 
 
         #Ctrlp:input.c.pmdl022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl022
            #add-point:ON ACTION controlp INFIELD pmdl022 name="input.c.pmdl022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl022
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            LET g_qryparam.where = " pmac003 = '2'"
            
            CALL q_pmac002_2()
            LET g_pmdl_m.pmdl022 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl022 TO pmdl022
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl022) RETURNING g_pmdl_m.pmdl022_desc
            DISPLAY BY NAME g_pmdl_m.pmdl022_desc
            NEXT FIELD pmdl022
            #END add-point
 
 
         #Ctrlp:input.c.pmdl021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl021
            #add-point:ON ACTION controlp INFIELD pmdl021 name="input.c.pmdl021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl021
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            LET g_qryparam.where = " pmac003 = '1'"
            
            CALL q_pmac002_2()
            LET g_pmdl_m.pmdl021 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl021 TO pmdl021
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl021) RETURNING g_pmdl_m.pmdl021_desc
            DISPLAY BY NAME g_pmdl_m.pmdl021_desc 
            NEXT FIELD pmdl021
            #END add-point
 
 
         #Ctrlp:input.c.pmdl047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl047
            #add-point:ON ACTION controlp INFIELD pmdl047 name="input.c.pmdl047"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl054
            #add-point:ON ACTION controlp INFIELD pmdl054 name="input.c.pmdl054"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl055
            #add-point:ON ACTION controlp INFIELD pmdl055 name="input.c.pmdl055"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl009
            #add-point:ON ACTION controlp INFIELD pmdl009 name="input.c.pmdl009"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl009

            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            CALL q_pmad002_2()
            LET g_pmdl_m.pmdl009 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl009 TO pmdl009
            CALL s_desc_get_ooib002_desc(g_pmdl_m.pmdl009) RETURNING g_pmdl_m.pmdl009_desc
            DISPLAY BY NAME g_pmdl_m.pmdl009_desc
            NEXT FIELD pmdl009
            #END add-point
 
 
         #Ctrlp:input.c.pmdl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl015
            #add-point:ON ACTION controlp INFIELD pmdl015 name="input.c.pmdl015"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl015
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdlsite
            CALL q_ooaj002_1()
            LET g_pmdl_m.pmdl015 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl015 TO pmdl015
            CALL s_desc_get_currency_desc(g_pmdl_m.pmdl015) RETURNING g_pmdl_m.pmdl015_desc
            DISPLAY BY NAME g_pmdl_m.pmdl015_desc
            NEXT FIELD pmdl015
            #END add-point
 
 
         #Ctrlp:input.c.pmdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl016
            #add-point:ON ACTION controlp INFIELD pmdl016 name="input.c.pmdl016"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl010
            #add-point:ON ACTION controlp INFIELD pmdl010 name="input.c.pmdl010"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl010
            
            #給予arg
            LET g_qryparam.arg1 = "238"
            CALL q_oocq002()
            LET g_pmdl_m.pmdl010 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl010 TO pmdl010
            CALL s_desc_get_acc_desc('238',g_pmdl_m.pmdl010) RETURNING g_pmdl_m.pmdl010_desc
            DISPLAY BY NAME g_pmdl_m.pmdl010_desc
            NEXT FIELD pmdl010
            #END add-point
 
 
         #Ctrlp:input.c.pmdl011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl011
            #add-point:ON ACTION controlp INFIELD pmdl011 name="input.c.pmdl011"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl011

            #給予arg
            CALL q_oodb002_11()
            LET g_pmdl_m.pmdl011 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl011 TO pmdl011
            CALL s_desc_get_tax_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING g_pmdl_m.pmdl011_desc
            DISPLAY BY NAME g_pmdl_m.pmdl011_desc
            NEXT FIELD pmdl011
            #END add-point
 
 
         #Ctrlp:input.c.pmdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl012
            #add-point:ON ACTION controlp INFIELD pmdl012 name="input.c.pmdl012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl013
            #add-point:ON ACTION controlp INFIELD pmdl013 name="input.c.pmdl013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl033
            #add-point:ON ACTION controlp INFIELD pmdl033 name="input.c.pmdl033"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl033
            
            #給予arg
            LET g_qryparam.arg1 = l_ooef019
            LET g_qryparam.arg2 = "1"
            CALL q_isac002_2()
            LET g_pmdl_m.pmdl033 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl033 TO pmdl033
            CALL s_desc_get_invoice_type_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl033) RETURNING g_pmdl_m.pmdl033_desc
            DISPLAY BY NAME g_pmdl_m.pmdl033_desc
            NEXT FIELD pmdl033
            #END add-point
 
 
         #Ctrlp:input.c.pmdl024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl024
            #add-point:ON ACTION controlp INFIELD pmdl024 name="input.c.pmdl024"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl024
            
            #給予arg
            LET g_qryparam.arg1 = "264"
            CALL q_oocq002()
            LET g_pmdl_m.pmdl024 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl024 TO pmdl024
            CALL s_desc_get_acc_desc('264',g_pmdl_m.pmdl024) RETURNING g_pmdl_m.pmdl024_desc
            DISPLAY BY NAME g_pmdl_m.pmdl024_desc
            NEXT FIELD pmdl024
            #END add-point
 
 
         #Ctrlp:input.c.pmdl043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl043
            #add-point:ON ACTION controlp INFIELD pmdl043 name="input.c.pmdl043"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdl_m.pmdl043

            #給予arg
            #LET g_qryparam.arg1 = "298"  #150908-00013#1 150910 by sakura mark
            LET g_qryparam.arg1 = "317"   #150908-00013#1 150910 by sakura add
            CALL q_oocq002()
            LET g_pmdl_m.pmdl043 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl043 TO pmdl043
            #CALL s_desc_get_acc_desc('298',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc  #150908-00013#1 150910 by sakura mark
            CALL s_desc_get_acc_desc('317',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc   #150908-00013#1 150910 by sakura add   
            DISPLAY BY NAME g_pmdl_m.pmdl043_desc
            NEXT FIELD pmdl043
            #END add-point
 
 
         #Ctrlp:input.c.pmdl020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl020
            #add-point:ON ACTION controlp INFIELD pmdl020 name="input.c.pmdl020"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl020
            
            #給予arg
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()
            LET g_pmdl_m.pmdl020 = g_qryparam.return1
            DISPLAY g_pmdl_m.pmdl020 TO pmdl020
            CALL s_desc_get_acc_desc('263',g_pmdl_m.pmdl020) RETURNING g_pmdl_m.pmdl020_desc
            DISPLAY BY NAME g_pmdl_m.pmdl020_desc
            NEXT FIELD pmdl020
            #END add-point
 
 
         #Ctrlp:input.c.pmdl044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl044
            #add-point:ON ACTION controlp INFIELD pmdl044 name="input.c.pmdl044"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl006
            #add-point:ON ACTION controlp INFIELD pmdl006 name="input.c.pmdl006"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl028
            #add-point:ON ACTION controlp INFIELD pmdl028 name="input.c.pmdl028"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl042
            #add-point:ON ACTION controlp INFIELD pmdl042 name="input.c.pmdl042"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl048
            #add-point:ON ACTION controlp INFIELD pmdl048 name="input.c.pmdl048"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl049
            #add-point:ON ACTION controlp INFIELD pmdl049 name="input.c.pmdl049"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl046
            #add-point:ON ACTION controlp INFIELD pmdl046 name="input.c.pmdl046"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl040
            #add-point:ON ACTION controlp INFIELD pmdl040 name="input.c.pmdl040"
                        
            #END add-point
 
 
         #Ctrlp:input.c.pmdl041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl041
            #add-point:ON ACTION controlp INFIELD pmdl041 name="input.c.pmdl041"
                        
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmdl_m.pmdldocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocno,g_pmdl_m.pmdldocdt,g_prog)
                  RETURNING l_success,g_pmdl_m.pmdldocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_pmdl_m.pmdldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pmdldocno           
               END IF
               
               #取完單號後，如果是一次性交易對像，需回寫回完整單號
               LET l_pmaa004 = ''
               SELECT pmaa004 INTO l_pmaa004
                 FROM pmaa_t
                WHERE pmaaent = g_enterprise
                  AND pmaa001 = g_pmdl_m.pmdl004
               IF l_cmd_t = 'r' AND l_pmaa004 MATCHES '[24]'
                  AND NOT cl_null(g_pmdl_m.pmdl028) THEN
                  #重新取聯絡對象識別碼
                  LET l_pmak002 = ''
                  LET g_sql = "SELECT pmak002 FROM pmak_t",
                              " WHERE pmakent = ",g_enterprise,
                              "   AND pmak001 = '",g_pmdl_m_t.pmdl028,"'"
                  PREPARE apmt840_pmak002 FROM g_sql
                  EXECUTE apmt840_pmak002 INTO l_pmak002
                  LET l_success = ''
                  SELECT pmaa002 INTO l_pmaa002
                    FROM pmaa_t
                   WHERE pmaaent = g_enterprise
                     AND pmaa001 =  l_pmak002
                  IF cl_null(l_pmaa002) THEN
                     LET l_pmaa002 = '3'
                  END IF
                  CALL s_aooi350_ins_oofa('3',l_pmak002,l_pmaa002)
                     RETURNING l_success,g_pmdl_m.pmdl028
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  LET g_sql = "INSERT INTO pmak_t (pmakent,pmak001,pmak002,pmak003,pmak004,",
                              "                    pmak005,pmak006,pmak007,pmak008,pmak009)",
                              "SELECT pmakent,'",g_pmdl_m.pmdl028,"',pmak002,pmak003,pmak004,",
                              "       pmak005,'",g_pmdl_m.pmdldocno,"',pmak007,pmak008,pmak009",
                              "  FROM pmak_t",
                              " WHERE pmakent = ",g_enterprise,
                              "   AND pmak001 = '",g_pmdl_m_t.pmdl028,"'"
                  PREPARE apmt840_ins_pmak FROM g_sql
                  EXECUTE apmt840_ins_pmak
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "Insert pmak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
               ELSE
                  IF l_pmaa004 MATCHES '[24]' AND NOT cl_null(g_pmdl_m.pmdl028) THEN
                     UPDATE pmak_t
                        SET pmak006 = g_pmdl_m.pmdldocno
                      WHERE pmakent = g_enterprise
                        AND pmak001 = g_pmdl_m.pmdl028
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "Update pmak_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               #end add-point
               
               INSERT INTO pmdl_t (pmdlent,pmdlsite,pmdldocdt,pmdldocno,pmdl001,pmdl005,pmdl200,pmdl004, 
                   pmdl203,pmdl002,pmdl003,pmdlstus,pmdl007,pmdl008,pmdl027,pmdl201,pmdl202,pmdl204, 
                   pmdl207,pmdlunit,pmdl029,pmdl025,pmdl206,pmdl205,pmdl023,pmdl022,pmdl021,pmdl047, 
                   pmdl054,pmdl055,pmdl009,pmdl015,pmdl016,pmdl010,pmdl011,pmdl012,pmdl013,pmdl033,pmdl024, 
                   pmdl043,pmdl020,pmdl044,pmdl006,pmdl028,pmdl042,pmdl048,pmdl049,pmdl046,pmdl040,pmdl041, 
                   pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt) 
 
               VALUES (g_enterprise,g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001, 
                   g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002, 
                   g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
                   g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit, 
                   g_pmdl_m.pmdl029,g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023, 
                   g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055, 
                   g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011, 
                   g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024,g_pmdl_m.pmdl043, 
                   g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
                   g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041, 
                   g_pmdl_m.pmdlownid,g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt, 
                   g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmdl_m:",SQLERRMESSAGE 
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
                  CALL apmt840_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt840_b_fill()
                  CALL apmt840_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               #150512-00029#2 150525 By pomelo add(S)
               #當不為長效期訂單時，只能手動自己輸入單身 或 使用門店清單輸入單身
               IF g_pmdl_m.pmdl206 = 'N' THEN
               #150512-00029#2 150525 By pomelo add(E)
                  #詢問單身是否由批次自動拋轉
                  LET l_cnt = 0
                  SELECT COUNT(pmdnseq) INTO l_cnt
                    FROM pmdn_t
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_pmdl_m.pmdldocno
                  IF l_cnt = 0 THEN
                     #是否要開啟批次作業，產生單身?
                     IF cl_ask_confirm('apm-00704') THEN
                        #CALL 批次產生單身
                        IF g_pmdl_m.pmdl203 = '0' THEN
                          #自訂貨批次拋轉
                          LET la_param.prog = 'apmp841'
                          LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                          LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                          LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                          LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                          LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                          LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                          LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                          LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                          LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#3 160126 by sakura add
                          LET ls_js = util.JSON.stringify(la_param)
                          DISPLAY "ls_js:",ls_js
                          CALL cl_cmdrun_wait(ls_js)
                        ELSE
                           #統採批次拋轉
                           LET la_param.prog = 'apmp840'
                           LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                           LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                           LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                           LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                           LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                           LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                           LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                           LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                           LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#2 151203 by sakura add
                           LET ls_js = util.JSON.stringify(la_param)
                           DISPLAY "ls_js:",ls_js
                           CALL cl_cmdrun_wait(ls_js)
                        END IF
                        #單身有資料才做更新單頭的動作
                        LET l_cnt = 0
                        SELECT COUNT(pmdnseq) INTO l_cnt
                          FROM pmdn_t
                         WHERE pmdnent = g_enterprise
                           AND pmdndocno = g_pmdl_m.pmdldocno
                        #詢問使用者是否刪除單身資料重新產生
                        IF l_cnt >= 1 THEN                  
                           #150407-00020#1 Add By Ken 151208(S)
                           IF s_transaction_chk("N",0) THEN
                              CALL s_transaction_begin()
                           END IF                     
                           #150407-00020#1 Add By Ken 151208(E)                           
                           IF g_pmdl_m.pmdl203 = '0' THEN                  
                              LET l_success = ''
                              CALL s_apmp841_pmdl205_upd(g_pmdl_m.pmdldocno) RETURNING l_success                  
                              
                              LET l_success = ''
                              CALL s_apmp840_sum_money(g_pmdl_m.pmdldocno) RETURNING l_success                    
                              
                              LET l_success = ''
                              CALL s_apmp841_pmdl008_upd(g_pmdl_m.pmdldocno) RETURNING l_success   
                           ELSE
                              #更新單頭欄位
                              LET l_success = ''
                              CALL s_apmp840_upd_pmdl(g_pmdl_m.pmdldocno)
                                 RETURNING l_success                     
                           END IF   
                           #150407-00020#1 Add By Ken 151208(S)
                           IF l_success THEN
                              CALL s_transaction_end('Y','0')
                           ELSE
                              CALL s_transaction_end('N','0')
                           END IF    
                           #150407-00020#1 Add By Ken 151208(E)                           
                        END IF                        
                        
                        CALL apmt840_sel_money()
                        CALL apmt840_b_fill()
                     END IF
                     LET l_auto_detail = 'N'
                  END IF
               END IF   #150512-00029#2 150525 By pomelo add
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apmt840_pmdl_t_mask_restore('restore_mask_o')
               
               UPDATE pmdl_t SET (pmdlsite,pmdldocdt,pmdldocno,pmdl001,pmdl005,pmdl200,pmdl004,pmdl203, 
                   pmdl002,pmdl003,pmdlstus,pmdl007,pmdl008,pmdl027,pmdl201,pmdl202,pmdl204,pmdl207, 
                   pmdlunit,pmdl029,pmdl025,pmdl206,pmdl205,pmdl023,pmdl022,pmdl021,pmdl047,pmdl054, 
                   pmdl055,pmdl009,pmdl015,pmdl016,pmdl010,pmdl011,pmdl012,pmdl013,pmdl033,pmdl024,pmdl043, 
                   pmdl020,pmdl044,pmdl006,pmdl028,pmdl042,pmdl048,pmdl049,pmdl046,pmdl040,pmdl041,pmdlownid, 
                   pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt) = (g_pmdl_m.pmdlsite, 
                   g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200, 
                   g_pmdl_m.pmdl004,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus, 
                   g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl201,g_pmdl_m.pmdl202, 
                   g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025, 
                   g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
                   g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015, 
                   g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013, 
                   g_pmdl_m.pmdl033,g_pmdl_m.pmdl024,g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044, 
                   g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049, 
                   g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlowndp, 
                   g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt, 
                   g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt)
                WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmdl_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                              
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt840_pmdl_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmdl_m_t)
               LET g_log2 = util.JSON.stringify(g_pmdl_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                              
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt840.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmdn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmt840_01
            LET g_action_choice="open_apmt840_01"
            IF cl_auth_chk_act("open_apmt840_01") THEN
               
               #add-point:ON ACTION open_apmt840_01 name="input.detail_input.page1.open_apmt840_01"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_pmdn_d[l_ac].pmdnunit) AND NOT cl_null(g_pmdn_d[l_ac].pmdnseq) AND
                     NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN
                     LET l_success = ''
                     LET l_pmdn020 = ''
                     CALL apmt840_01(g_pmdl_m.pmdldocno,     g_pmdn_d[l_ac].pmdnseq,
                                     g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdnunit,
                                     g_pmdn_d[l_ac].pmdn001, g_pmdn_d[l_ac].pmdn006,
                                     g_pmdn_d[l_ac].pmdn007, g_pmdn_d[l_ac].pmdn024,
                                     g_pmdn_d[l_ac].pmdn201, g_pmdn_d[l_ac].pmdn202)
                        RETURNING l_success,l_pmdn014,l_pmdn007,l_pmdn202,l_pmdn020,l_pmdn024
                     
                     LET g_pmdn_d[l_ac].pmdn007 = l_pmdn007   #採購數量
                     LET g_pmdn_d[l_ac].pmdn014 = l_pmdn014   #到庫日期
                     LET g_pmdn_d[l_ac].pmdn024 = l_pmdn024   #多交期
                     
                     CALL s_apmt840_get_rtka(g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010,l_rtka012
                     CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,l_pmdn020)
                     #150903-00007#1 150903 by sakura mark&add(S)
                     #CALL apmt840_num_change()
                     IF NOT apmt840_num_change() THEN
                        RETURN
                     END IF
                     #150903-00007#1 150903 by sakura mark&add(S)
                     CALL s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq) RETURNING l_success
                     LET g_pmdn_d_o.pmdn007 = g_pmdn_d[l_ac].pmdn007   #採購數量
                     LET g_pmdn_d_o.pmdn014 = g_pmdn_d[l_ac].pmdn014   #到庫日期
                     LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020   #緊急度
                     LET g_pmdn_d_o.pmdn024 = g_pmdn_d[l_ac].pmdn024   #多交期
                     LET g_pmdn_d_o.pmdn202 = g_pmdn_d[l_ac].pmdn202   #包裝數量
                  END IF
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #當有關聯性單據資料　不可以對單身資料進行新增刪除動作
            IF s_apmt840_count_pmdp(g_pmdl_m.pmdldocno) THEN
               CALL cl_set_act_visible("insert,delete", FALSE)
            END IF
            
            #150930-00013#1 Add By Ken 151005(S) 
            IF g_intrans = 'N' THEN
               CALL s_transaction_begin()            
            END IF
            #150930-00013#1 Add By Ken 151005(E)
            
            #150512-00029#2 150525 By pomelo add(S)
            #當不為長效期訂單時，只能手動自己輸入單身 或 使用門店清單輸入單身
            IF g_pmdl_m.pmdl206 = 'N' THEN
            #150512-00029#2 150525 By pomelo add(E)
               #詢問單身是否由批次自動拋轉
               LET l_cnt = 0
               SELECT COUNT(pmdnseq) INTO l_cnt
                 FROM pmdn_t
                WHERE pmdnent = g_enterprise
                  AND pmdndocno = g_pmdl_m.pmdldocno
               IF l_cnt = 0 AND l_auto_detail = 'Y' THEN
                  #是否要開啟批次作業，產生單身?
                  IF cl_ask_confirm('apm-00704') THEN
                     #CALL 批次產生單身
                     IF g_pmdl_m.pmdl203 = '0' THEN
                        #自訂貨批次拋轉
                        LET la_param.prog = 'apmp841'
                        LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                        LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                        LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                        LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                        LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                        LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                        LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                        LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                        LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#3 160126 by sakura add
                        LET ls_js = util.JSON.stringify(la_param)
                        DISPLAY "ls_js:",ls_js
                        CALL cl_cmdrun_wait(ls_js)
                     ELSE
                        #統採批次拋轉
                        LET la_param.prog = 'apmp840'
                        LET la_param.param[1] = g_pmdl_m.pmdldocno #採購單號
                        LET la_param.param[2] = g_pmdl_m.pmdl200   #採購中心
                        LET la_param.param[3] = g_pmdl_m.pmdl004   #供應商
                        LET la_param.param[4] = g_pmdl_m.pmdl002   #採購員
                        LET la_param.param[5] = g_pmdl_m.pmdl203   #採購方式
                        LET la_param.param[6] = g_pmdl_m.pmdlunit  #收貨組織
                        LET la_param.param[7] = g_pmdl_m.pmdl029   #收貨部門
                        LET la_param.param[8] = g_pmdl_m.pmdl204   #配送中心
                        LET la_param.param[9] = g_pmdl_m.pmdl207   #所屬品類   #150610-00030#2 151203 by sakura add
                        LET ls_js = util.JSON.stringify(la_param)
                        DISPLAY "ls_js:",ls_js
                        CALL cl_cmdrun_wait(ls_js)
                     END IF

                     #單身有資料才做更新單頭的動作
                     LET l_cnt = 0
                     SELECT COUNT(pmdnseq) INTO l_cnt
                       FROM pmdn_t
                      WHERE pmdnent = g_enterprise
                        AND pmdndocno = g_pmdl_m.pmdldocno
                     #詢問使用者是否刪除單身資料重新產生
                     IF l_cnt >= 1 THEN            
                        #150407-00020#1 Add By Ken 151208(S)
                        IF s_transaction_chk("N",0) THEN
                           CALL s_transaction_begin()
                        END IF                     
                        #150407-00020#1 Add By Ken 151208(E)                     
                        IF g_pmdl_m.pmdl203 = '0' THEN                  
                           LET l_success = ''
                           CALL s_apmp841_pmdl205_upd(g_pmdl_m.pmdldocno) RETURNING l_success                  
                           
                           LET l_success = ''
                           CALL s_apmp840_sum_money(g_pmdl_m.pmdldocno) RETURNING l_success                    
                           
                           LET l_success = ''
                           CALL s_apmp841_pmdl008_upd(g_pmdl_m.pmdldocno) RETURNING l_success   
                        ELSE
                           #更新單頭欄位
                           LET l_success = ''
                           CALL s_apmp840_upd_pmdl(g_pmdl_m.pmdldocno)
                              RETURNING l_success                     
                        END IF 
                        #150407-00020#1 Add By Ken 151208(S)
                        IF l_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF    
                        #150407-00020#1 Add By Ken 151208(E)                          
                     END IF
                     
                     CALL apmt840_sel_money()
                     CALL apmt840_b_fill()
                  END IF
               END IF
            END IF   #150512-00029#2 150525 By pomelo add
            
            CALL s_transaction_end('Y','0')  #150930-00013#1 Add By Ken 151005       
            
            #150616-00035#10 add by yangxf -----start-----
            #检查单身是否有资料
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM pmdn_t
             WHERE pmdnent = g_enterprise
               AND pmdndocno = g_pmdl_m.pmdldocno
           #IF l_cnt = 0 THEN   #150710-00016#5 150713 by sakura mark
            IF l_cnt = 0 AND g_pmdl_m.pmdl203 = '0' THEN   #為自訂貨才能批量產生#150710-00016#5 150713 by sakura add
               #询问是否产生单身资料?
               IF cl_ask_confirm('axm-00013') THEN
                  #单据编号/单据日期/营运组织
                  CALL apmt840_02(g_pmdl_m.pmdldocno,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdlsite)
                  CALL apmt840_b_fill()
                  LET INT_FLAG = 0   #150407-00020#1 Add By Ken 151211
               END IF
            END IF 
            #150616-00035#10 add by yangxf ------end------
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt840_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdn_d.getLength()
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
            OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmdn_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdn_d[l_ac].pmdnseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmdn_d_t.* = g_pmdn_d[l_ac].*  #BACKUP
               LET g_pmdn_d_o.* = g_pmdn_d[l_ac].*  #BACKUP
               CALL apmt840_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL apmt840_set_no_entry_b(l_cmd)
               IF NOT apmt840_lock_b("pmdn_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt840_bcl INTO g_pmdn_d[l_ac].pmdnseq,g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn200, 
                      g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn228,g_pmdn_d[l_ac].pmdn002,g_pmdn_d[l_ac].pmdn016, 
                      g_pmdn_d[l_ac].pmdn017,g_pmdn_d[l_ac].pmdn227,g_pmdn_d[l_ac].pmdn201,g_pmdn_d[l_ac].pmdn202, 
                      g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007,g_pmdn_d[l_ac].pmdn226,g_pmdn_d[l_ac].pmdn008, 
                      g_pmdn_d[l_ac].pmdn009,g_pmdn_d[l_ac].pmdn010,g_pmdn_d[l_ac].pmdn011,g_pmdn_d[l_ac].pmdn015, 
                      g_pmdn_d[l_ac].pmdn043,g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047, 
                      g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn225,g_pmdn_d[l_ac].pmdn203,g_pmdn_d[l_ac].pmdn025, 
                      g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029,g_pmdn_d[l_ac].pmdn030,g_pmdn_d[l_ac].pmdn053, 
                      g_pmdn_d[l_ac].pmdnorga,g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdn024,g_pmdn_d[l_ac].pmdn014, 
                      g_pmdn_d[l_ac].pmdn012,g_pmdn_d[l_ac].pmdn013,g_pmdn_d[l_ac].pmdn022,g_pmdn_d[l_ac].pmdn023, 
                      g_pmdn_d[l_ac].pmdn045,g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207,g_pmdn_d[l_ac].pmdn208, 
                      g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211,g_pmdn_d[l_ac].pmdn212, 
                      g_pmdn_d[l_ac].pmdn213,g_pmdn_d[l_ac].pmdn019,g_pmdn_d[l_ac].pmdn020,g_pmdn_d[l_ac].pmdn224, 
                      g_pmdn_d[l_ac].pmdn052,g_pmdn_d[l_ac].pmdn049,g_pmdn_d[l_ac].pmdn051,g_pmdn_d[l_ac].pmdn205, 
                      g_pmdn_d[l_ac].pmdn214,g_pmdn_d[l_ac].pmdn215,g_pmdn_d[l_ac].pmdn216,g_pmdn_d[l_ac].pmdn217, 
                      g_pmdn_d[l_ac].pmdn218,g_pmdn_d[l_ac].pmdn219,g_pmdn_d[l_ac].pmdn220,g_pmdn_d[l_ac].pmdn221, 
                      g_pmdn_d[l_ac].pmdn222,g_pmdn_d[l_ac].pmdn223,g_pmdn_d[l_ac].pmdn050
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdn_d_t.pmdnseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdn_d_mask_o[l_ac].* =  g_pmdn_d[l_ac].*
                  CALL apmt840_pmdn_t_mask()
                  LET g_pmdn_d_mask_n[l_ac].* =  g_pmdn_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt840_show()
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
            INITIALIZE g_pmdn_d[l_ac].* TO NULL 
            INITIALIZE g_pmdn_d_t.* TO NULL 
            INITIALIZE g_pmdn_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmdn_d[l_ac].pmdn009 = "0"
      LET g_pmdn_d[l_ac].pmdn011 = "0"
      LET g_pmdn_d[l_ac].pmdn015 = "0"
      LET g_pmdn_d[l_ac].pmdn043 = "0"
      LET g_pmdn_d[l_ac].pmdn046 = "0"
      LET g_pmdn_d[l_ac].pmdn048 = "0"
      LET g_pmdn_d[l_ac].pmdn047 = "0"
      LET g_pmdn_d[l_ac].pmdn024 = "N"
      LET g_pmdn_d[l_ac].pmdn022 = "Y"
      LET g_pmdn_d[l_ac].pmdn045 = "1"
      LET g_pmdn_d[l_ac].pmdn206 = "0"
      LET g_pmdn_d[l_ac].pmdn207 = "0"
      LET g_pmdn_d[l_ac].pmdn208 = "0"
      LET g_pmdn_d[l_ac].pmdn209 = "0"
      LET g_pmdn_d[l_ac].pmdn210 = "0"
      LET g_pmdn_d[l_ac].pmdn211 = "0"
      LET g_pmdn_d[l_ac].pmdn212 = "0"
      LET g_pmdn_d[l_ac].pmdn213 = "0"
      LET g_pmdn_d[l_ac].pmdn019 = "1"
      LET g_pmdn_d[l_ac].pmdn020 = "1"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #當是新增狀況 且 採購方式不等於自訂貨
            IF l_cmd = 'a' AND (g_pmdl_m.pmdl203 = '1' OR g_pmdl_m.pmdl203 = '3') THEN
               IF g_cmd != 'r' THEN     #160120-00001#5 160121 By pomelo add
                  #採購方式不屬於0.自訂貨時，不可以對單身進行新增動作，只可使用自動產生單身功能！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00705"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF                   #160120-00001#5 160121 By pomelo add
               #l_ac大於2表示單身有資料
               IF l_ac >= 2 THEN
                  CANCEL INSERT
               ELSE
                  NEXT FIELD pmdlsite
               END IF
            END IF
            
            #項次加1
            SELECT MAX(pmdnseq)+1 INTO g_pmdn_d[l_ac].pmdnseq
              FROM pmdn_t
             WHERE pmdnent = g_enterprise
               AND pmdndocno = g_pmdl_m.pmdldocno
            IF cl_null(g_pmdn_d[l_ac].pmdnseq) OR g_pmdn_d[l_ac].pmdnseq = 0 THEN
               LET g_pmdn_d[l_ac].pmdnseq = 1
            END IF
            
            #當採購方式 = 0.自訂貨且沒有來源資料，預設值 = 單頭採購組織
            IF g_pmdl_m.pmdl203 = '0' AND g_pmdl_m.pmdl007 = '1' THEN
               LET g_pmdn_d[l_ac].pmdnsite = g_pmdl_m.pmdlsite
               CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnsite) RETURNING g_pmdn_d[l_ac].pmdnsite_desc
            END IF
            
            #150407-00020#1 Add_S By Ken 150410 單身採購失效日預設為單頭採購失效日
            LET g_pmdn_d[l_ac].pmdn224 = g_pmdl_m.pmdl205
            #150407-00020#1 Add_E
            
            LET g_pmdn_d[l_ac].pmdn222 = g_pmdl_m.pmdl200
            LET g_pmdn_d[l_ac].pmdn223 = g_pmdl_m.pmdl204
            
            #收貨組織
            IF cl_null(g_pmdl_m.pmdlunit) THEN
               #先確認收貨組織在aooi500設定是可以的
               CALL s_aooi500_chk(g_prog,'pmdnunit',g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite)
                  RETURNING l_success,l_errno
               #IF l_success AND apmt840_chk_pmdnunit() THEN   #160406-00015 160412 by sakura mark
               IF l_success THEN                               #160406-00015 160412 by sakura add
                  LET g_pmdn_d[l_ac].pmdnunit = g_pmdl_m.pmdlsite
                  LET g_pmdn_d[l_ac].pmdnunit_desc = g_pmdl_m.pmdlsite_desc
                  CALL apmt840_addr_default(2)
               END IF
            ELSE
               LET g_pmdn_d[l_ac].pmdnunit = g_pmdl_m.pmdlunit
               LET g_pmdn_d[l_ac].pmdnunit_desc = g_pmdl_m.pmdlunit_desc
            END IF
            #最終收貨組織
            LET g_pmdn_d[l_ac].pmdn225 = g_pmdn_d[l_ac].pmdnunit
            LET g_pmdn_d[l_ac].pmdn225_desc = g_pmdn_d[l_ac].pmdnunit_desc
            
            #收貨部門
            IF NOT cl_null(g_pmdl_m.pmdl029) THEN
               LET g_pmdn_d[l_ac].pmdn203 = g_pmdl_m.pmdl029
               LET g_pmdn_d[l_ac].pmdn203_desc = g_pmdl_m.pmdl029_desc
            END IF
            
            #收貨地址碼
            IF NOT cl_null(g_pmdl_m.pmdl025) THEN
               LET g_pmdn_d[l_ac].pmdn025 = g_pmdl_m.pmdl025
               LET g_pmdn_d[l_ac].pmdn025_desc = g_pmdl_m.pmdl025_desc
               LET g_pmdn_d[l_ac].l_pmdn025_addr = g_pmdl_m.oofb017
            END IF
                                  
            #到庫日期
            CALL s_apmt840_get_date('1',g_pmdl_m.pmdldocdt,g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
               RETURNING g_pmdn_d[l_ac].pmdn014,l_rtka010
            CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,'')
            
            #代送商
            IF NOT cl_null(g_pmdl_m.pmdl022) THEN
               LET g_pmdn_d[l_ac].pmdn023 = g_pmdl_m.pmdl022
               LET g_pmdn_d[l_ac].pmdn023_desc = g_pmdl_m.pmdl022_desc
            END IF
            
            #要貨組織
            LET g_pmdn_d[l_ac].pmdn205 = g_pmdl_m.pmdlsite
            LET g_pmdn_d[l_ac].pmdn205_desc = g_pmdl_m.pmdlsite_desc
            
            #採購渠道
            IF NOT cl_null(g_pmdl_m.pmdl023) THEN
               LET g_pmdn_d[l_ac].pmdn214 = g_pmdl_m.pmdl023
               LET g_pmdn_d[l_ac].pmdn214_desc = g_pmdl_m.pmdl023_desc
               CALL s_apmt840_get_oojd004(g_pmdn_d[l_ac].pmdn214) RETURNING g_pmdn_d[l_ac].pmdn215
            END IF
            
            #150512-00029#2 150525 By pomelo add(S)
            #部分交貨
            IF g_pmdl_m.pmdl206 = 'Y' THEN
               LET g_pmdn_d[l_ac].pmdn022 = 'Y'
            ELSE
               SELECT pmab099 INTO g_pmdn_d[l_ac].pmdn022
                 FROM pmab_t
                WHERE pmabent = g_enterprise
                  AND pmabsite = 'ALL'
                  AND pmab001 = g_pmdl_m.pmdl004
            END IF
            #150512-00029#2 150525 By pomelo add(E)
            #end add-point
            LET g_pmdn_d_t.* = g_pmdn_d[l_ac].*     #新輸入資料
            LET g_pmdn_d_o.* = g_pmdn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt840_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
        
            #end add-point
            CALL apmt840_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
 
               LET g_pmdn_d[li_reproduce_target].pmdnseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
 
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
            
            #檢查單身稅別不可空白
            IF cl_null(g_pmdn_d[l_ac].pmdn016) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code = 'axm-00231'
               LET g_errparam.extend = g_pmdl_m.pmdldocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD pmdn016
            END IF          
            #料件有使用產品特徴則不可空白
            LET l_imaa005 = ''
            CALL apmt840_get_imaa005(g_pmdn_d[l_ac].pmdn001) RETURNING l_imaa005
            IF NOT cl_null(l_imaa005) THEN
               IF cl_null(g_pmdn_d[l_ac].pmdn002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00124'
                  LET g_errparam.extend = g_pmdl_m.pmdldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pmdn002               
               END IF
            ELSE 
               IF cl_null(g_pmdn_d[l_ac].pmdn002) THEN
                  LET g_pmdn_d[l_ac].pmdn002 = ' ' 
               END IF          
            END IF
            
            #確保在後面單據再扣庫存的時候不會因為Null值而錯誤
            #當庫位有值
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn028) THEN
               #儲位
               IF cl_null(g_pmdn_d[l_ac].pmdn029)THEN
                  LET g_pmdn_d[l_ac].pmdn029 = ' '
               END IF
               #批號
               IF cl_null(g_pmdn_d[l_ac].pmdn030) THEN
                  LET g_pmdn_d[l_ac].pmdn030 = ' '
               END IF
               #庫存管理特徵
               IF cl_null(g_pmdn_d[l_ac].pmdn053) THEN
                  LET g_pmdn_d[l_ac].pmdn053 = ' '
               END IF
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmdn_t 
             WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdl_m.pmdldocno
 
               AND pmdnseq = g_pmdn_d[l_ac].pmdnseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdl_m.pmdldocno
               LET gs_keys[2] = g_pmdn_d[g_detail_idx].pmdnseq
               CALL apmt840_insert_b('pmdn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmdn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt840_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #CALL s_transaction_end('Y','0')
               IF g_pmdn_d[l_ac].pmdn024 = 'N' THEN
                  CALL s_apmt840_gen_pmdq(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq) RETURNING l_success
               END IF
               
               CALL s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq) RETURNING l_success
               
               INITIALIZE l_pmdn.* TO NULL               
               SELECT pmdnent, pmdnsite,pmdn200, pmdn001,
                      pmdn002, pmdn016, pmdn017, pmdn201,
                      pmdn202, pmdn006, pmdn007, pmdn008,
                      pmdn009, pmdn010, pmdn011, pmdn015,
                      pmdn043, pmdn046, pmdn048, pmdn047,
                      pmdnunit,pmdn225, pmdn203, pmdn025,
                      pmdn028, pmdn029, pmdn030, pmdnorga,
                      pmdn026, pmdn024, pmdn014, pmdn012,
                      pmdn013, pmdn022, pmdn023, pmdn045,
                      pmdn206, pmdn207, pmdn208, pmdn209,
                      pmdn210, pmdn211, pmdn212, pmdn213,
                      pmdn019, pmdn020, pmdn224, pmdn049,
                      pmdn051, pmdn205, pmdn214, pmdn215,
                      pmdn216, pmdn217, pmdn218, pmdn219,
                      pmdn220, pmdn221, pmdn222, pmdn223,
                      pmdn050
                 INTO l_pmdn.pmdnent, l_pmdn.pmdnsite,l_pmdn.pmdn200, l_pmdn.pmdn001,
                      l_pmdn.pmdn002, l_pmdn.pmdn016, l_pmdn.pmdn017, l_pmdn.pmdn201,
                      l_pmdn.pmdn202, l_pmdn.pmdn006, l_pmdn.pmdn007, l_pmdn.pmdn008,
                      l_pmdn.pmdn009, l_pmdn.pmdn010, l_pmdn.pmdn011, l_pmdn.pmdn015,
                      l_pmdn.pmdn043, l_pmdn.pmdn046, l_pmdn.pmdn048, l_pmdn.pmdn047,
                      l_pmdn.pmdnunit,l_pmdn.pmdn225, l_pmdn.pmdn203, l_pmdn.pmdn025,
                      l_pmdn.pmdn028, l_pmdn.pmdn029, l_pmdn.pmdn030, l_pmdn.pmdnorga,
                      l_pmdn.pmdn026, l_pmdn.pmdn024, l_pmdn.pmdn014, l_pmdn.pmdn012,
                      l_pmdn.pmdn013, l_pmdn.pmdn022, l_pmdn.pmdn023, l_pmdn.pmdn045,
                      l_pmdn.pmdn206, l_pmdn.pmdn207, l_pmdn.pmdn208, l_pmdn.pmdn209,
                      l_pmdn.pmdn210, l_pmdn.pmdn211, l_pmdn.pmdn212, l_pmdn.pmdn213,
                      l_pmdn.pmdn019, l_pmdn.pmdn020, l_pmdn.pmdn224, l_pmdn.pmdn049,
                      l_pmdn.pmdn051, l_pmdn.pmdn205, l_pmdn.pmdn214, l_pmdn.pmdn215,
                      l_pmdn.pmdn216, l_pmdn.pmdn217, l_pmdn.pmdn218, l_pmdn.pmdn219,
                      l_pmdn.pmdn220, l_pmdn.pmdn221, l_pmdn.pmdn222, l_pmdn.pmdn223,
                      l_pmdn.pmdn050
                 FROM pmdn_t 
                WHERE pmdnent = g_enterprise
                  AND pmdndocno = g_pmdl_m.pmdldocno
                  AND pmdnseq = g_pmdn_d[l_ac].pmdnseq
               
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  LET l_pmdnseq = ''
                  SELECT MAX(pmdnseq) INTO l_pmdnseq
                    FROM pmdn_t
                   WHERE pmdnent   = g_enterprise
                     AND pmdndocno = g_pmdl_m.pmdldocno
                     
                  CALL cl_err_collect_init()
                  FOR l_i = 2 TO l_inam.getLength() 
                     IF cl_null(l_pmdnseq) OR l_pmdnseq = 0 THEN
                        LET l_pmdnseq = 1
                     ELSE
                        LET l_pmdnseq = l_pmdnseq + 1             
                     END IF 
                     
                     LET l_pmdn.pmdn002 = l_inam[l_i].inam002
                     LET l_pmdn.pmdn007 = l_inam[l_i].inam004
                     
                     #150521-00016#1 150528 By pomelo add(S)
                     IF NOT apmt840_unique_chk(l_pmdn.pmdnseq,  l_pmdn.pmdnsite,
                                               l_pmdn.pmdnunit, l_pmdn.pmdn001,
                                               l_pmdn.pmdn002) THEN
                        LET l_pmdnseq = l_pmdnseq - 1
                        CONTINUE FOR
                     END IF
                     #150521-00016#1 150528 By pomelo add(E)
                     
                     #單位間的轉換數量
                     #當銷售數量有值，由銷售數量轉換成包裝數量
                     LET l_success = ''
                     CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn201,l_pmdn.pmdn007)
                        RETURNING l_success,l_pmdn.pmdn202
                     #150903-00007#1 150903 by sakura add(S)
                     IF l_success = FALSE THEN
                        LET l_pmdnseq = l_pmdnseq - 1
                        CONTINUE FOR
                     END IF
                     #150903-00007#1 150903 by sakura add(E)
                     
                     #計算參考數量
                     IF NOT cl_null(l_pmdn.pmdn008) THEN
                        LET l_success = ''
                        CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008,l_pmdn.pmdn007)
                           RETURNING l_success,l_pmdn.pmdn009
                        #150903-00007#1 150903 by sakura add(S)
                        IF l_success = FALSE THEN
                           LET l_pmdnseq = l_pmdnseq - 1
                           CONTINUE FOR
                        END IF
                        #150903-00007#1 150903 by sakura add(E)                           
                     END IF
                     
                     #計算計價數量
                     IF NOT cl_null(l_pmdn.pmdn010) THEN
                        LET l_success = ''
                        CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn007)
                           RETURNING l_success,l_pmdn.pmdn011
                        #150903-00007#1 150903 by sakura add(S)
                        IF l_success = FALSE THEN
                           LET l_pmdnseq = l_pmdnseq - 1
                           CONTINUE FOR
                        END IF
                        #150903-00007#1 150903 by sakura add(E)                           
                     END IF
                     
                     #可用庫存量 跟 採購在途量
                     CALL apmt840_get_sum(l_pmdn.pmdnunit,l_pmdn.pmdn001,l_pmdn.pmdn002)   #sakura add 150413-00018#1
                        RETURNING l_pmdn.pmdn206,l_pmdn.pmdn207
                     
                     #計算單身日結/月結 銷量欄位
                     CALL apmt840_get_sale(l_pmdn.pmdn205,l_pmdn.pmdn001,l_pmdn.pmdn002)
                        RETURNING l_pmdn.pmdn208,l_pmdn.pmdn209,l_pmdn.pmdn210,l_pmdn.pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                                  l_pmdn.pmdn212,l_pmdn.pmdn213
                     
                     #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                     CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,l_pmdn.pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
                        RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047
                     
                     INSERT INTO pmdn_t (pmdnent, pmdnsite,pmdn200, pmdn001,
                                         pmdn002, pmdn016, pmdn017, pmdn201,
                                         pmdn202, pmdn006, pmdn007, pmdn008,
                                         pmdn009, pmdn010, pmdn011, pmdn015,
                                         pmdn043, pmdn046, pmdn048, pmdn047,
                                         pmdnunit,pmdn225, pmdn203, pmdn025,
                                         pmdn028, pmdn029, pmdn030, pmdnorga,
                                         pmdn026, pmdn024, pmdn014, pmdn012,
                                         pmdn013, pmdn022, pmdn023, pmdn045,
                                         pmdn206, pmdn207, pmdn208, pmdn209,
                                         pmdn210, pmdn211, pmdn212, pmdn213,
                                         pmdn019, pmdn020, pmdn224, pmdn049,
                                         pmdn051, pmdn205, pmdn214, pmdn215,
                                         pmdn216, pmdn217, pmdn218, pmdn219,
                                         pmdn220, pmdn221, pmdn222, pmdn223,
                                         pmdn050, pmdn227, pmdnseq)   #150710-00016#5 150713 by sakura add pmdn227  #160120-00001#5 160125 By pomelo add pmdnseq
                        VALUES(l_pmdn.pmdnent, l_pmdn.pmdnsite,l_pmdn.pmdn200, l_pmdn.pmdn001,
                               l_pmdn.pmdn002, l_pmdn.pmdn016, l_pmdn.pmdn017, l_pmdn.pmdn201,
                               l_pmdn.pmdn202, l_pmdn.pmdn006, l_pmdn.pmdn007, l_pmdn.pmdn008,
                               l_pmdn.pmdn009, l_pmdn.pmdn010, l_pmdn.pmdn011, l_pmdn.pmdn015,
                               l_pmdn.pmdn043, l_pmdn.pmdn046, l_pmdn.pmdn048, l_pmdn.pmdn047,
                               l_pmdn.pmdnunit,l_pmdn.pmdn225, l_pmdn.pmdn203, l_pmdn.pmdn025,
                               l_pmdn.pmdn028, l_pmdn.pmdn029, l_pmdn.pmdn030, l_pmdn.pmdnorga,
                               l_pmdn.pmdn026, l_pmdn.pmdn024, l_pmdn.pmdn014, l_pmdn.pmdn012,
                               l_pmdn.pmdn013, l_pmdn.pmdn022, l_pmdn.pmdn023, l_pmdn.pmdn045,
                               l_pmdn.pmdn206, l_pmdn.pmdn207, l_pmdn.pmdn208, l_pmdn.pmdn209,
                               l_pmdn.pmdn210, l_pmdn.pmdn211, l_pmdn.pmdn212, l_pmdn.pmdn213,
                               l_pmdn.pmdn019, l_pmdn.pmdn020, l_pmdn.pmdn224, l_pmdn.pmdn049,
                               l_pmdn.pmdn051, l_pmdn.pmdn205, l_pmdn.pmdn214, l_pmdn.pmdn215,
                               l_pmdn.pmdn216, l_pmdn.pmdn217, l_pmdn.pmdn218, l_pmdn.pmdn219,
                               l_pmdn.pmdn220, l_pmdn.pmdn221, l_pmdn.pmdn222, l_pmdn.pmdn223,
                               l_pmdn.pmdn050, l_pmdn.pmdn227, l_pmdnseq)   #150710-00016#5 150713 by sakura add pmdn227  #160120-00001#5 160125 By pomelo add pmdnseq
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmdn_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     END IF
                     CALL s_apmt840_gen_pmdq(g_pmdl_m.pmdldocno,l_pmdnseq) RETURNING l_success
                     CALL s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno,l_pmdnseq) RETURNING l_success
                  END FOR
                  LET g_rec_b = l_inam.getLength() - 1
                  CALL l_inam.clear()
                  CALL cl_err_collect_show()
               END IF
               CALL apmt840_b_fill()
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
               LET gs_keys[01] = g_pmdl_m.pmdldocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmdn_d_t.pmdnseq
 
            
               #刪除同層單身
               IF NOT apmt840_delete_b('pmdn_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt840_key_delete_b(gs_keys,'pmdn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                              
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt840_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM pmdo_t
                   WHERE pmdoent = g_enterprise
                     AND pmdodocno = g_pmdl_m.pmdldocno
                     AND pmdoseq = g_pmdn_d_t.pmdnseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF
                  
                  DELETE FROM pmdp_t
                   WHERE pmdpent = g_enterprise
                     AND pmdpdocno = g_pmdl_m.pmdldocno
                     AND pmdpseq = g_pmdn_d_t.pmdnseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdp_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF   
                  
                  DELETE FROM pmdq_t
                   WHERE pmdqent = g_enterprise
                     AND pmdqdocno = g_pmdl_m.pmdldocno
                     AND pmdqseq = g_pmdn_d_t.pmdnseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdq_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF
                  
                  DELETE FROM xrcd_t
                   WHERE xrcdent = g_enterprise
                     AND xrcddocno = g_pmdl_m.pmdldocno
                     AND xrcdseq = g_pmdn_d_t.pmdnseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xrcd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF
               #end add-point
               LET l_count = g_pmdn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                        
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdnseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdnseq
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdnseq name="input.a.page1.pmdnseq"
            #此段落由子樣板a05產生
            IF  g_pmdl_m.pmdldocno IS NOT NULL AND g_pmdn_d[l_ac].pmdnseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdl_m.pmdldocno != g_pmdldocno_t OR g_pmdn_d[l_ac].pmdnseq != g_pmdn_d_t.pmdnseq)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdn_t WHERE "||"pmdnent = '" ||g_enterprise|| "' AND "||"pmdndocno = '"||g_pmdl_m.pmdldocno ||"' AND "|| "pmdnseq = '"||g_pmdn_d[l_ac].pmdnseq ||"'",'std-00004',0) THEN 
                     LET g_pmdn_d[l_ac].pmdnseq = g_pmdn_d_t.pmdnseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnseq
            #add-point:BEFORE FIELD pmdnseq name="input.b.page1.pmdnseq"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnseq
            #add-point:ON CHANGE pmdnseq name="input.g.page1.pmdnseq"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnsite
            
            #add-point:AFTER FIELD pmdnsite name="input.a.page1.pmdnsite"
            LET g_pmdn_d[l_ac].pmdnsite_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnsite_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdnsite) THEN 
               IF g_pmdn_d[l_ac].pmdnsite != g_pmdn_d_o.pmdnsite OR cl_null(g_pmdn_d_o.pmdnsite) THEN
                  CALL s_aooi500_chk(g_prog,'pmdnsite',g_pmdn_d[l_ac].pmdnsite,g_pmdl_m.pmdlsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_pmdn_d[l_ac].pmdnsite = g_pmdn_d_o.pmdnsite
                     CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnsite) RETURNING g_pmdn_d[l_ac].pmdnsite_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdnsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN
                     IF g_pmdn_d[l_ac].pmdn001 != g_pmdn_d_o.pmdn001 OR cl_null(g_pmdn_d_o.pmdn001) THEN
                        IF NOT apmt840_pmdn001_chk(g_pmdn_d[l_ac].pmdn001) THEN
                           LET g_pmdn_d[l_ac].pmdnsite = g_pmdn_d_o.pmdnsite
                           CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnsite) RETURNING g_pmdn_d[l_ac].pmdnsite_desc
                           DISPLAY BY NAME g_pmdn_d[l_ac].pmdnsite_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdnsite = g_pmdn_d[l_ac].pmdnsite
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnsite) RETURNING g_pmdn_d[l_ac].pmdnsite_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnsite
            #add-point:BEFORE FIELD pmdnsite name="input.b.page1.pmdnsite"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnsite
            #add-point:ON CHANGE pmdnsite name="input.g.page1.pmdnsite"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn200
            
            #add-point:AFTER FIELD pmdn200 name="input.a.page1.pmdn200"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn200) THEN
               IF g_pmdn_d[l_ac].pmdn200 != g_pmdn_d_o.pmdn200 OR cl_null(g_pmdn_d_o.pmdn200) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdn200
                  IF NOT cl_chk_exist("v_imay003_1") THEN
                     LET g_pmdn_d[l_ac].pmdn200 = g_pmdn_d_o.pmdn200
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_apmt840_get_imay001(g_pmdn_d[l_ac].pmdn200) RETURNING g_pmdn_d[l_ac].pmdn001
                  IF NOT apmt840_pmdn001_chk(g_pmdn_d[l_ac].pmdn001) THEN
                     LET g_pmdn_d[l_ac].pmdn200 = g_pmdn_d_o.pmdn200
                     LET g_pmdn_d[l_ac].pmdn001 = g_pmdn_d_o.pmdn001
                     CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001) RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_pmdn001_default('1')
                  IF NOT apmt840_pmdn001_default('1') THEN
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
               END IF
            END IF
            LET g_pmdn_d_o.pmdn200 = g_pmdn_d[l_ac].pmdn200
            LET g_pmdn_d_o.pmdn001 = g_pmdn_d[l_ac].pmdn001
            CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001) RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn200
            #add-point:BEFORE FIELD pmdn200 name="input.b.page1.pmdn200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn200
            #add-point:ON CHANGE pmdn200 name="input.g.page1.pmdn200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn001
            
            #add-point:AFTER FIELD pmdn001 name="input.a.page1.pmdn001"
            LET g_pmdn_d[l_ac].pmdn001_desc = ''
            LET g_pmdn_d[l_ac].pmdn001_desc_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN 
               IF g_pmdn_d[l_ac].pmdn001 != g_pmdn_d_o.pmdn001 OR cl_null(g_pmdn_d_o.pmdn001) THEN
                  IF NOT apmt840_pmdn001_chk(g_pmdn_d[l_ac].pmdn001) THEN
                     LET g_pmdn_d[l_ac].pmdn001 = g_pmdn_d_o.pmdn001
                     CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001) RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_pmdn001_default('2')
                  IF NOT apmt840_pmdn001_default('2') THEN
                     NEXT FIELD CURRENT
                  END IF                  
                  #150903-00007#1 150903 by sakura mark&add(E)
               END IF    
            END IF 
            LET g_pmdn_d_o.pmdn200 = g_pmdn_d[l_ac].pmdn200
            LET g_pmdn_d_o.pmdn001 = g_pmdn_d[l_ac].pmdn001
            CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001) RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn001
            #add-point:BEFORE FIELD pmdn001 name="input.b.page1.pmdn001"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn001
            #add-point:ON CHANGE pmdn001 name="input.g.page1.pmdn001"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn002
            
            #add-point:AFTER FIELD pmdn002 name="input.a.page1.pmdn002"
            LET g_pmdn_d[l_ac].pmdn002_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc 
            
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn002) THEN 
               IF g_pmdn_d[l_ac].pmdn002 != g_pmdn_d_o.pmdn002 OR cl_null(g_pmdn_d_o.pmdn002) THEN 
                  IF NOT s_feature_check(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) THEN
                     LET g_pmdn_d[l_ac].pmdn002 = g_pmdn_d_o.pmdn002
                     CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160201-00017#1 add start ------------------------
                  IF NOT s_feature_direct_input(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002,g_pmdn_d_o.pmdn002,g_pmdl_m.pmdldocno,g_pmdl_m.pmdlsite) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #160201-00017#1 add end   ------------------------   
                  #150521-00016#1 150528 By pomelo add(S)
                  IF NOT apmt840_unique_chk(g_pmdn_d[l_ac].pmdnseq,  g_pmdn_d[l_ac].pmdnsite,
                                            g_pmdn_d[l_ac].pmdnunit, g_pmdn_d[l_ac].pmdn001,
                                            g_pmdn_d[l_ac].pmdn002) THEN
                     LET g_pmdn_d[l_ac].pmdn002 = g_pmdn_d_o.pmdn002
                     CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150521-00016#1 150528 By pomelo add(E)
                  
                  #可用庫存量 跟 採購在途量
                  CALL apmt840_get_sum(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207
                  #計算單身日結/月結 銷量欄位
                  CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                               g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
               END IF
            ELSE
               IF NOT cl_null(l_imaa005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'sub-00124'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE
                  LET g_pmdn_d[l_ac].pmdn002 = ' '
               END IF
            END IF
            LET g_pmdn_d_o.pmdn002 = g_pmdn_d[l_ac].pmdn002
            CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn002
            #add-point:BEFORE FIELD pmdn002 name="input.b.page1.pmdn002"
            #160314-00009#5   marked by zhujing 2016-3-17-----(S) 元件中有判断
#            LET l_imaa005 = ''
#            CALL apmt840_get_imaa005(g_pmdn_d[l_ac].pmdn001) RETURNING l_imaa005
            #160314-00009#5   marked by zhujing 2016-3-17-----(E) 
            #使用產品特徵 
            IF cl_get_para(g_enterprise,g_pmdn_d[l_ac].pmdnsite,'S-BAS-0036') = 'Y' THEN 
#               IF NOT cl_null(l_imaa005) THEN      #160314-00009#5   marked by zhujing 2016-3-17
               IF s_feature_auto_chk(g_pmdn_d[l_ac].pmdn001) AND cl_null(g_pmdn_d[l_ac].pmdn002) THEN      #160314-00009#5   mod by zhujing 2016-3-17
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdn_d[l_ac].pmdn001,'','',g_pmdn_d[l_ac].pmdnsite,g_pmdl_m.pmdldocno) RETURNING l_success,l_inam
                  LET g_pmdn_d[l_ac].pmdn002 = l_inam[1].inam002
                  LET g_pmdn_d[l_ac].pmdn007 = l_inam[1].inam004
                  #單位間的轉換數量
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_num_change()
                  IF NOT apmt840_num_change() THEN
                     NEXT FIELD pmdn002
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
                  
                  #150413-00018#1 2015/04/15 By sakura modify ---- S
                  #可用庫存量
                  #CALL s_apmt840_sum_inag008(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                  #  RETURNING g_pmdn_d[l_ac].pmdn206
                  #可用庫存量 跟 採購在途量
                  CALL apmt840_get_sum(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207
                  #150413-00018#1 2015/04/15 By sakura modify ---- E
                  #計算單身日結/月結 銷量欄位
                  CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                               g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
               END IF
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn002
            #add-point:ON CHANGE pmdn002 name="input.g.page1.pmdn002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn016
            
            #add-point:AFTER FIELD pmdn016 name="input.a.page1.pmdn016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn016
            #add-point:BEFORE FIELD pmdn016 name="input.b.page1.pmdn016"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn016
            #add-point:ON CHANGE pmdn016 name="input.g.page1.pmdn016"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn017
            #add-point:BEFORE FIELD pmdn017 name="input.b.page1.pmdn017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn017
            
            #add-point:AFTER FIELD pmdn017 name="input.a.page1.pmdn017"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn017
            #add-point:ON CHANGE pmdn017 name="input.g.page1.pmdn017"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn227
            #add-point:BEFORE FIELD pmdn227 name="input.b.page1.pmdn227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn227
            
            #add-point:AFTER FIELD pmdn227 name="input.a.page1.pmdn227"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn227
            #add-point:ON CHANGE pmdn227 name="input.g.page1.pmdn227"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn201
            
            #add-point:AFTER FIELD pmdn201 name="input.a.page1.pmdn201"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn201
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdn_d[l_ac].pmdn201_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn201_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn201
            #add-point:BEFORE FIELD pmdn201 name="input.b.page1.pmdn201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn201
            #add-point:ON CHANGE pmdn201 name="input.g.page1.pmdn201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn202
            #add-point:BEFORE FIELD pmdn202 name="input.b.page1.pmdn202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn202
            
            #add-point:AFTER FIELD pmdn202 name="input.a.page1.pmdn202"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn202) THEN
               IF g_pmdn_d[l_ac].pmdn202 != g_pmdn_d_o.pmdn202 OR cl_null(g_pmdn_d_o.pmdn202) THEN
                  IF g_pmdn_d[l_ac].pmdn202 <= 0 THEN
                     LET g_pmdn_d[l_ac].pmdn202 = g_pmdn_d_o.pmdn202
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "apm-00659" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #對輸入的採購數量取位
                  CALL s_aooi250_take_decimals(g_pmdn_d[l_ac].pmdn201,g_pmdn_d[l_ac].pmdn202)
                     RETURNING l_success,g_pmdn_d[l_ac].pmdn202
                  
                  #當多交期 = 'Y'
                  LET l_pmdn020 = ''
                  IF g_pmdn_d[l_ac].pmdn024 = 'Y' AND NOT cl_null(g_pmdn_d[l_ac].pmdnunit) AND
                     NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN
                     CALL apmt840_01(g_pmdl_m.pmdldocno,     g_pmdn_d[l_ac].pmdnseq,
                                     g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdnunit,
                                     g_pmdn_d[l_ac].pmdn001, g_pmdn_d[l_ac].pmdn006,
                                     g_pmdn_d[l_ac].pmdn007, g_pmdn_d[l_ac].pmdn024,
                                     g_pmdn_d[l_ac].pmdn201, g_pmdn_d[l_ac].pmdn202)
                           RETURNING l_success,l_pmdn014,l_pmdn007,l_pmdn202,l_pmdn020,l_pmdn024
                     LET g_pmdn_d[l_ac].pmdn007 = l_pmdn007    #採購數量
                     LET g_pmdn_d[l_ac].pmdn014 = l_pmdn014    #到庫日期
                     LET g_pmdn_d[l_ac].pmdn024 = l_pmdn024    #多交期
                     #取送貨天數
                     CALL s_apmt840_get_rtka(g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010,l_rtka012
                     CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,l_pmdn020)
                  END IF
                  
                  #單位間的轉換數量
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_num_change()
                  IF NOT apmt840_num_change() THEN
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
                  
                  #取得未稅金額、稅額、含稅金額
                  CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdn_d[l_ac].pmdn007,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn016)
                     RETURNING g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047
               END IF
            END IF
            LET g_pmdn_d_o.pmdn007 = g_pmdn_d[l_ac].pmdn007   #採購數量
            LET g_pmdn_d_o.pmdn014 = g_pmdn_d[l_ac].pmdn014   #到庫日期
            LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020   #緊急度
            LET g_pmdn_d_o.pmdn024 = g_pmdn_d[l_ac].pmdn024   #多交期
            LET g_pmdn_d_o.pmdn202 = g_pmdn_d[l_ac].pmdn202   #包裝數量
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn202
            #add-point:ON CHANGE pmdn202 name="input.g.page1.pmdn202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn006
            
            #add-point:AFTER FIELD pmdn006 name="input.a.page1.pmdn006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn006
            #add-point:BEFORE FIELD pmdn006 name="input.b.page1.pmdn006"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn006
            #add-point:ON CHANGE pmdn006 name="input.g.page1.pmdn006"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdn007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdn007
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn007 name="input.a.page1.pmdn007"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn007) THEN 
               IF g_pmdn_d[l_ac].pmdn007 != g_pmdn_d_o.pmdn007 OR cl_null(g_pmdn_d_o.pmdn007) THEN
                  #對輸入的採購數量取位
                  CALL s_aooi250_take_decimals(g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007)
                     RETURNING l_success,g_pmdn_d[l_ac].pmdn007
                  
                  #當多交期 = 'Y'
                  LET l_pmdn020 = ''
                  IF g_pmdn_d[l_ac].pmdn024 = 'Y' AND NOT cl_null(g_pmdn_d[l_ac].pmdnunit) AND
                     NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN
                     CALL apmt840_01(g_pmdl_m.pmdldocno,     g_pmdn_d[l_ac].pmdnseq,
                                     g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdnunit,
                                     g_pmdn_d[l_ac].pmdn001, g_pmdn_d[l_ac].pmdn006,
                                     g_pmdn_d[l_ac].pmdn007, g_pmdn_d[l_ac].pmdn024,
                                     g_pmdn_d[l_ac].pmdn201, g_pmdn_d[l_ac].pmdn202)
                           RETURNING l_success,l_pmdn014,l_pmdn007,l_pmdn202,l_pmdn020,l_pmdn024
                     LET g_pmdn_d[l_ac].pmdn007 = l_pmdn007    #採購數量
                     LET g_pmdn_d[l_ac].pmdn014 = l_pmdn014    #到庫日期
                     LET g_pmdn_d[l_ac].pmdn024 = l_pmdn024    #多交期
                     
                     #取送貨天數
                     CALL s_apmt840_get_rtka(g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010,l_rtka012
                     CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,l_pmdn020)
                  END IF
                  
                  #單位間的轉換數量
                  #150903-00007#1 150903 by sakura mark&add(S)
                  #CALL apmt840_num_change()
                  IF NOT apmt840_num_change() THEN
                     NEXT FIELD CURRENT
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
                  
                  #取得未稅金額、稅額、含稅金額
                  CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdn_d[l_ac].pmdn007,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn016)
                     RETURNING g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047
               END IF
            END IF 
            LET g_pmdn_d_o.pmdn007 = g_pmdn_d[l_ac].pmdn007   #採購數量
            LET g_pmdn_d_o.pmdn014 = g_pmdn_d[l_ac].pmdn014   #到庫日期
            LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020   #緊急度
            LET g_pmdn_d_o.pmdn024 = g_pmdn_d[l_ac].pmdn024   #多交期
            LET g_pmdn_d_o.pmdn202 = g_pmdn_d[l_ac].pmdn202   #包裝數量
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn007
            #add-point:BEFORE FIELD pmdn007 name="input.b.page1.pmdn007"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn007
            #add-point:ON CHANGE pmdn007 name="input.g.page1.pmdn007"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn226
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdn226,"0","0","","","azz-00079",1) THEN
               NEXT FIELD pmdn226
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn226 name="input.a.page1.pmdn226"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn226) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn226
            #add-point:BEFORE FIELD pmdn226 name="input.b.page1.pmdn226"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn226
            #add-point:ON CHANGE pmdn226 name="input.g.page1.pmdn226"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn008
            
            #add-point:AFTER FIELD pmdn008 name="input.a.page1.pmdn008"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn008
            #add-point:BEFORE FIELD pmdn008 name="input.b.page1.pmdn008"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn008
            #add-point:ON CHANGE pmdn008 name="input.g.page1.pmdn008"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdn009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdn009
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn009 name="input.a.page1.pmdn009"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn009
            #add-point:BEFORE FIELD pmdn009 name="input.b.page1.pmdn009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn009
            #add-point:ON CHANGE pmdn009 name="input.g.page1.pmdn009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn010
            
            #add-point:AFTER FIELD pmdn010 name="input.a.page1.pmdn010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn010
            #add-point:BEFORE FIELD pmdn010 name="input.b.page1.pmdn010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn010
            #add-point:ON CHANGE pmdn010 name="input.g.page1.pmdn010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdn011,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdn011
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn011 name="input.a.page1.pmdn011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn011
            #add-point:BEFORE FIELD pmdn011 name="input.b.page1.pmdn011"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn011
            #add-point:ON CHANGE pmdn011 name="input.g.page1.pmdn011"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn_d[l_ac].pmdn015,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdn015
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdn015 name="input.a.page1.pmdn015"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn015) THEN
               IF g_pmdn_d[l_ac].pmdn015 != g_pmdn_d_o.pmdn015 OR cl_null(g_pmdn_d_o.pmdn015) THEN
                  
                  #150506-00032#5 150527 by sakura mark---STR
                  ##修改的單價不可以小於取出單價
                  #IF g_pmdn_d[l_ac].pmdn015 < g_pmdn_d[l_ac].pmdn043 THEN
                  #   #修改的單價不可以小於取出單價！
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'apm-00805'
                  #   LET g_errparam.extend = ""
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_pmdn_d[l_ac].pmdn015 = g_pmdn_d_o.pmdn015
                  #   NEXT FIELD CURRENT
                  #END IF
                  #150506-00032#5 150527 by sakura mark---END
                  #150506-00032#5 150527 by sakura add---STR
                  #單價容差率控卡
                  IF NOT s_apm_price_get_stan025_chk(g_pmdn_d[l_ac].pmdn218,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn043) THEN
                     LET g_pmdn_d[l_ac].pmdn015 = g_pmdn_d_o.pmdn015
                     NEXT FIELD CURRENT                   
                  END IF 
                  #150506-00032#5 150527 by sakura add---END
                     
                  #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                  CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdn_d[l_ac].pmdn011,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn016)
                       RETURNING g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047
               END IF       
            END IF 
            LET g_pmdn_d_o.pmdn015 = g_pmdn_d[l_ac].pmdn015
            LET g_pmdn_d_o.pmdn046 = g_pmdn_d[l_ac].pmdn046
            LET g_pmdn_d_o.pmdn048 = g_pmdn_d[l_ac].pmdn048
            LET g_pmdn_d_o.pmdn047 = g_pmdn_d[l_ac].pmdn047
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn015
            #add-point:BEFORE FIELD pmdn015 name="input.b.page1.pmdn015"
           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn015
            #add-point:ON CHANGE pmdn015 name="input.g.page1.pmdn015"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn043
            #add-point:BEFORE FIELD pmdn043 name="input.b.page1.pmdn043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn043
            
            #add-point:AFTER FIELD pmdn043 name="input.a.page1.pmdn043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn043
            #add-point:ON CHANGE pmdn043 name="input.g.page1.pmdn043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn046
            #add-point:BEFORE FIELD pmdn046 name="input.b.page1.pmdn046"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn046
            
            #add-point:AFTER FIELD pmdn046 name="input.a.page1.pmdn046"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn046
            #add-point:ON CHANGE pmdn046 name="input.g.page1.pmdn046"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn048
            #add-point:BEFORE FIELD pmdn048 name="input.b.page1.pmdn048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn048
            
            #add-point:AFTER FIELD pmdn048 name="input.a.page1.pmdn048"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn048
            #add-point:ON CHANGE pmdn048 name="input.g.page1.pmdn048"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn047
            #add-point:BEFORE FIELD pmdn047 name="input.b.page1.pmdn047"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn047
            
            #add-point:AFTER FIELD pmdn047 name="input.a.page1.pmdn047"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn047
            #add-point:ON CHANGE pmdn047 name="input.g.page1.pmdn047"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnunit
            
            #add-point:AFTER FIELD pmdnunit name="input.a.page1.pmdnunit"
            LET g_pmdn_d[l_ac].pmdnunit_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdnunit) THEN 
               IF g_pmdn_d[l_ac].pmdnunit != g_pmdn_d_o.pmdnunit OR cl_null(g_pmdn_d_o.pmdnunit) THEN
                  CALL s_aooi500_chk(g_prog,'pmdnunit',g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdlsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_pmdn_d[l_ac].pmdnunit = g_pmdn_d_o.pmdnunit
                     CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnunit) RETURNING g_pmdn_d[l_ac].pmdnunit_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150521-00016#1 150528 By pomelo add(S)
                  IF NOT apmt840_unique_chk(g_pmdn_d[l_ac].pmdnseq,  g_pmdn_d[l_ac].pmdnsite,
                                            g_pmdn_d[l_ac].pmdnunit, g_pmdn_d[l_ac].pmdn001,
                                            g_pmdn_d[l_ac].pmdn002) THEN
                     LET g_pmdn_d[l_ac].pmdnunit = g_pmdn_d_o.pmdnunit
                     CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnunit) RETURNING g_pmdn_d[l_ac].pmdnunit_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
                     NEXT FIELD CURRENT
                  ENd IF
                  #150521-00016#1 150528 By pomelo add(E)
                  
                  #當多交期 = 'Y'
                  IF g_pmdn_d[l_ac].pmdn024 = 'Y' THEN
                     #原收貨組織的送貨天數
                     LET l_rtka012_o = 0
                     CALL s_apmt840_get_rtka(g_pmdn_d_o.pmdnunit,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010,l_rtka012_o
                     #新輸入的收貨組織的送貨天數
                     LET l_rtka012 = 0
                     CALL s_apmt840_get_rtka(g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                        RETURNING l_rtka010,l_rtka012
                        
                     IF l_rtka012_o　!= l_rtka012 THEN
                        #原出貨組織的送貨天數%1 與 輸入的出貨組織的送貨天數%2 不相同，因為影響多交期裡面的到庫日期推算，如果確定修改，會刪掉多交期裡面的資料。 是否確定修改出貨組織?
                        LET l_replace = l_rtka012_o ,"|",l_rtka012
                        LET l_msg = cl_getmsg_parm('apm-00668',g_dlang,l_replace)
                        
                        IF cl_ask_confirm_parm('std-00008',l_msg) THEN
                           DELETE FROM pmdq_t
                            WHERE pmdqent = g_enterprise
                              AND pmdqdocno = g_pmdl_m.pmdldocno
                              AND pmdqseq = g_pmdn_d[l_ac].pmdnseq
                           #重新計算到庫日期
                           CALL s_apmt840_get_date('1',g_pmdl_m.pmdldocdt,g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                              RETURNING g_pmdn_d[l_ac].pmdn014,l_rtka010
                           CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,'')
                           LET g_pmdn_d[l_ac].pmdn024 = 'N'
                        ELSE
                           LET g_pmdn_d[l_ac].pmdnunit = g_pmdn_d_o.pmdnunit
                           CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnunit) RETURNING g_pmdn_d[l_ac].pmdnunit_desc
                           DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #出貨地址預代值
                  CALL apmt840_addr_default(2)
                  #可用庫存量 跟 採購在途量
                  CALL apmt840_get_sum(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207
                  #計算單身日結/月結 銷量欄位
                  CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                               g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
               END IF
               LET g_pmdn_d[l_ac].pmdn225 = g_pmdn_d[l_ac].pmdnunit
            END IF
            LET g_pmdn_d_o.pmdn024 = g_pmdn_d[l_ac].pmdn024
            LET g_pmdn_d_o.pmdnunit = g_pmdn_d[l_ac].pmdnunit
            LET g_pmdn_d_o.pmdn025 = g_pmdn_d[l_ac].pmdn025
            LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnunit) RETURNING g_pmdn_d[l_ac].pmdnunit_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
            LET g_pmdn_d[l_ac].pmdn225_desc = g_pmdn_d[l_ac].pmdnunit_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnunit
            #add-point:BEFORE FIELD pmdnunit name="input.b.page1.pmdnunit"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnunit
            #add-point:ON CHANGE pmdnunit name="input.g.page1.pmdnunit"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn225
            
            #add-point:AFTER FIELD pmdn225 name="input.a.page1.pmdn225"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn225
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdn_d[l_ac].pmdn225_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn225_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn225
            #add-point:BEFORE FIELD pmdn225 name="input.b.page1.pmdn225"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn225
            #add-point:ON CHANGE pmdn225 name="input.g.page1.pmdn225"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn203
            
            #add-point:AFTER FIELD pmdn203 name="input.a.page1.pmdn203"
            LET g_pmdn_d[l_ac].pmdn203_desc = ' '
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn203_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn203) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdn_d[l_ac].pmdn203 != g_pmdn_d_t.pmdn203 OR g_pmdn_d_t.pmdn203 IS NULL )) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdn_d[l_ac].pmdn203 != g_pmdn_d_o.pmdn203 OR cl_null(g_pmdn_d_o.pmdn203) THEN   #160824-00007#12 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdn203
                  LET g_chkparam.arg2 = g_pmdl_m.pmdldocdt
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     #LET g_pmdn_d[l_ac].pmdn203 = g_pmdn_d_t.pmdn203   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdn_d[l_ac].pmdn203 = g_pmdn_d_o.pmdn203    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn203) RETURNING g_pmdn_d[l_ac].pmdn203_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn203_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn203 = g_pmdn_d[l_ac].pmdn203    #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn203) RETURNING g_pmdn_d[l_ac].pmdn203_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn203_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn203
            #add-point:BEFORE FIELD pmdn203 name="input.b.page1.pmdn203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn203
            #add-point:ON CHANGE pmdn203 name="input.g.page1.pmdn203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn025
            
            #add-point:AFTER FIELD pmdn025 name="input.a.page1.pmdn025"
            LET g_pmdn_d[l_ac].pmdn025_desc = ''
            LET g_pmdn_d[l_ac].l_pmdn025_addr = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn025) THEN 
               IF g_pmdn_d[l_ac].pmdn025 <> g_pmdn_d_o.pmdn025 OR cl_null(g_pmdn_d_o.pmdn025) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef012
                  LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdn025
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_oofb019_1") THEN
                     LET g_pmdn_d[l_ac].pmdn025 = g_pmdn_d_o.pmdn025
                     CALL s_apmt840_address_ref('3',g_pmdn_d[l_ac].pmdn025,l_ooef001) RETURNING g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn025 = g_pmdn_d[l_ac].pmdn025
            CALL s_apmt840_address_ref('3',g_pmdn_d[l_ac].pmdn025,l_ooef001) RETURNING g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn025
            #add-point:BEFORE FIELD pmdn025 name="input.b.page1.pmdn025"
            LET l_ooef012 = ''
            IF g_pmdl_m.pmdl203 = '3' THEN
               CALL s_apmt840_get_ooef012(g_pmdn_d[l_ac].pmdn223) RETURNING l_ooef012
               LET l_ooef001 = g_pmdn_d[l_ac].pmdn223
            ELSE
               CALL s_apmt840_get_ooef012(g_pmdn_d[l_ac].pmdnunit) RETURNING l_ooef012
               LET l_ooef001 = g_pmdn_d[l_ac].pmdnunit
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn025
            #add-point:ON CHANGE pmdn025 name="input.g.page1.pmdn025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn025_desc
            #add-point:BEFORE FIELD pmdn025_desc name="input.b.page1.pmdn025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn025_desc
            
            #add-point:AFTER FIELD pmdn025_desc name="input.a.page1.pmdn025_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn025_desc
            #add-point:ON CHANGE pmdn025_desc name="input.g.page1.pmdn025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdn025_addr
            #add-point:BEFORE FIELD l_pmdn025_addr name="input.b.page1.l_pmdn025_addr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdn025_addr
            
            #add-point:AFTER FIELD l_pmdn025_addr name="input.a.page1.l_pmdn025_addr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmdn025_addr
            #add-point:ON CHANGE l_pmdn025_addr name="input.g.page1.l_pmdn025_addr"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn028
            
            #add-point:AFTER FIELD pmdn028 name="input.a.page1.pmdn028"
            LET g_pmdn_d[l_ac].pmdn028_desc = ' '
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn028_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn028) THEN
               IF g_pmdn_d[l_ac].pmdn028 != g_pmdn_d_o.pmdn028 OR cl_null(g_pmdn_d_o.pmdn028) THEN
                  INITIALIZE g_chkparam.* TO NULL
                 #LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdnsite #170217-00003#1 17/02/18 By 08171 mark
                  LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdn225  #最終收貨組織 #170217-00003#1 17/02/18 By 08171 add
                  LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdn028
                  LET g_chkparam.arg3 = g_pmdn_d[l_ac].pmdn001
                  LET g_chkparam.arg4 = g_pmdl_m.pmdl203
                  IF g_pmdl_m.pmdl203 = '3' THEN
                     LET g_chkparam.arg5 = g_pmdn_d[l_ac].pmdn223
                  ELSE
                     LET g_chkparam.arg5 = g_pmdn_d[l_ac].pmdn222
                  END IF
                 #LET g_chkparam.arg6 = g_pmdn_d[l_ac].pmdnunit #170217-00003#1 17/02/18 By 08171 mark
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_17") THEN
                     LET g_pmdn_d[l_ac].pmdn028 = g_pmdn_d_o.pmdn028
                     CALL s_desc_get_stock_desc('',g_pmdn_d[l_ac].pmdn028) RETURNING g_pmdn_d[l_ac].pmdn028_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn028_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_pmdn_d[l_ac].pmdn029 = ''
                  LET g_pmdn_d[l_ac].pmdn029_desc = ''
                  LET g_pmdn_d[l_ac].pmdn030 = ''
               END IF
               #150518-00001#2--add by dongsz--str---
               IF NOT s_inaa_chk(g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn216) THEN
                  LET g_pmdn_d[l_ac].pmdn028 = g_pmdn_d_o.pmdn028
                  CALL s_desc_get_stock_desc('',g_pmdn_d[l_ac].pmdn028) RETURNING g_pmdn_d[l_ac].pmdn028_desc
                  DISPLAY BY NAME g_pmdn_d[l_ac].pmdn028_desc
                  NEXT FIELD CURRENT
               END IF
               #150518-00001#2--add by dongsz--end---
            END IF
            LET g_pmdn_d_o.pmdn028 = g_pmdn_d[l_ac].pmdn028
            LET g_pmdn_d_o.pmdn029 = g_pmdn_d[l_ac].pmdn029
            LET g_pmdn_d_o.pmdn030 = g_pmdn_d[l_ac].pmdn030
            CALL s_desc_get_stock_desc('',g_pmdn_d[l_ac].pmdn028) RETURNING g_pmdn_d[l_ac].pmdn028_desc
            CALL apmt840_set_entry(l_cmd)
            CALL apmt840_set_no_entry(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn028
            #add-point:BEFORE FIELD pmdn028 name="input.b.page1.pmdn028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn028
            #add-point:ON CHANGE pmdn028 name="input.g.page1.pmdn028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn029
            
            #add-point:AFTER FIELD pmdn029 name="input.a.page1.pmdn029"
            LET g_pmdn_d[l_ac].pmdn029_desc = ' '
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn029_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn029) THEN
               IF g_pmdn_d[l_ac].pmdn029 != g_pmdn_d_o.pmdn029 OR cl_null(g_pmdn_d_o.pmdn029) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdnunit
                  LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdn028
                  LET g_chkparam.arg3 = g_pmdn_d[l_ac].pmdn029
                  IF NOT cl_chk_exist("v_inab002_1") THEN
                     LET g_pmdn_d[l_ac].pmdn029 = g_pmdn_d_o.pmdn029
                     CALL s_desc_get_locator_desc(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029)
                        RETURNING g_pmdn_d[l_ac].pmdn029_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn029_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_pmdn_d[l_ac].pmdn030 = ''
               END IF
            END IF
            LET g_pmdn_d_o.pmdn029 = g_pmdn_d[l_ac].pmdn029
            LET g_pmdn_d_o.pmdn030 = g_pmdn_d[l_ac].pmdn030
            CALL s_desc_get_locator_desc(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029)
               RETURNING g_pmdn_d[l_ac].pmdn029_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn029
            #add-point:BEFORE FIELD pmdn029 name="input.b.page1.pmdn029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn029
            #add-point:ON CHANGE pmdn029 name="input.g.page1.pmdn029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn029_desc
            #add-point:BEFORE FIELD pmdn029_desc name="input.b.page1.pmdn029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn029_desc
            
            #add-point:AFTER FIELD pmdn029_desc name="input.a.page1.pmdn029_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn029_desc
            #add-point:ON CHANGE pmdn029_desc name="input.g.page1.pmdn029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn030
            #add-point:BEFORE FIELD pmdn030 name="input.b.page1.pmdn030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn030
            
            #add-point:AFTER FIELD pmdn030 name="input.a.page1.pmdn030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn030
            #add-point:ON CHANGE pmdn030 name="input.g.page1.pmdn030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn053
            #add-point:BEFORE FIELD pmdn053 name="input.b.page1.pmdn053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn053
            
            #add-point:AFTER FIELD pmdn053 name="input.a.page1.pmdn053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn053
            #add-point:ON CHANGE pmdn053 name="input.g.page1.pmdn053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnorga
            
            #add-point:AFTER FIELD pmdnorga name="input.a.page1.pmdnorga"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnorga
            #add-point:BEFORE FIELD pmdnorga name="input.b.page1.pmdnorga"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnorga
            #add-point:ON CHANGE pmdnorga name="input.g.page1.pmdnorga"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn026
            
            #add-point:AFTER FIELD pmdn026 name="input.a.page1.pmdn026"
            LET g_pmdn_d[l_ac].pmdn026_desc = ''
            LET g_pmdn_d[l_ac].l_pmdn026_addr = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn026) THEN 
               IF g_pmdn_d[l_ac].pmdn026 <> g_pmdn_d_o.pmdn026 OR cl_null(g_pmdn_d_o.pmdn026) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef012
                  LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdn026
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_oofb019_2") THEN
                     LET g_pmdn_d[l_ac].pmdn026 = g_pmdn_d_o.pmdn026
                     CALL s_apmt840_address_ref('5',g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdnorga) RETURNING g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn026 = g_pmdn_d[l_ac].pmdn026
            CALL s_apmt840_address_ref('5',g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdnorga) RETURNING g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn026
            #add-point:BEFORE FIELD pmdn026 name="input.b.page1.pmdn026"
            LET l_ooef012 = ''
            CALL s_apmt840_get_ooef012(g_pmdn_d[l_ac].pmdnorga) RETURNING l_ooef012
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn026
            #add-point:ON CHANGE pmdn026 name="input.g.page1.pmdn026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn026_desc
            #add-point:BEFORE FIELD pmdn026_desc name="input.b.page1.pmdn026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn026_desc
            
            #add-point:AFTER FIELD pmdn026_desc name="input.a.page1.pmdn026_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn026_desc
            #add-point:ON CHANGE pmdn026_desc name="input.g.page1.pmdn026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pmdn026_addr
            #add-point:BEFORE FIELD l_pmdn026_addr name="input.b.page1.l_pmdn026_addr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pmdn026_addr
            
            #add-point:AFTER FIELD l_pmdn026_addr name="input.a.page1.l_pmdn026_addr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pmdn026_addr
            #add-point:ON CHANGE l_pmdn026_addr name="input.g.page1.l_pmdn026_addr"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn024
            #add-point:BEFORE FIELD pmdn024 name="input.b.page1.pmdn024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn024
            
            #add-point:AFTER FIELD pmdn024 name="input.a.page1.pmdn024"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn024) THEN
               IF g_pmdn_d[l_ac].pmdn024 != g_pmdn_d_o.pmdn024 OR cl_null(g_pmdn_d_o.pmdn024) THEN   
                  IF g_pmdn_d[l_ac].pmdn024 = 'Y' THEN
                     IF NOT cl_null(g_pmdn_d[l_ac].pmdnunit) AND
                        NOT cl_null(g_pmdn_d[l_ac].pmdn001) THEN
                        LET l_pmdn020 = ''
                        CALL apmt840_01(g_pmdl_m.pmdldocno,     g_pmdn_d[l_ac].pmdnseq,
                                        g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdnunit,
                                        g_pmdn_d[l_ac].pmdn001, g_pmdn_d[l_ac].pmdn006,
                                        g_pmdn_d[l_ac].pmdn007, g_pmdn_d[l_ac].pmdn024,
                                        g_pmdn_d[l_ac].pmdn201, g_pmdn_d[l_ac].pmdn202)
                           RETURNING l_success,l_pmdn014,l_pmdn007,l_pmdn202,l_pmdn020,l_pmdn024
                        LET g_pmdn_d[l_ac].pmdn007 = l_pmdn007   #採購數量
                        LET g_pmdn_d[l_ac].pmdn014 = l_pmdn014   #到庫日期
                        LET g_pmdn_d[l_ac].pmdn024 = l_pmdn024   #多交期
                        CALL s_apmt840_get_rtka(g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                           RETURNING l_rtka010,l_rtka012
                        CALL apmt840_pmdn014_value(g_pmdn_d[l_ac].pmdn014,l_rtka010,l_pmdn020)
                        #150903-00007#1 150903 by sakura mark&add(S)
                        #CALL apmt840_num_change()
                        IF NOT apmt840_num_change() THEN
                           NEXT FIELD CURRENT
                        END IF
                        #150903-00007#1 150903 by sakura mark&add(E)
                     END IF
                  ELSE
                     #從多交期改成非多交期需清空多交期資料
                     IF g_pmdn_d_o.pmdn024 = 'Y' THEN
                        DELETE FROM pmdq_t
                         WHERE pmdqent = g_enterprise
                           AND pmdqdocno = g_pmdl_m.pmdldocno
                           AND pmdqseq = g_pmdn_d[l_ac].pmdnseq
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn024 = g_pmdn_d[l_ac].pmdn024   #多交期
            LET g_pmdn_d_o.pmdn007 = g_pmdn_d[l_ac].pmdn007   #採購數量
            LET g_pmdn_d_o.pmdn014 = g_pmdn_d[l_ac].pmdn014   #到庫日期
            LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020   #緊急度
            LET g_pmdn_d_o.pmdn202 = g_pmdn_d[l_ac].pmdn202   #包裝數量
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn024
            #add-point:ON CHANGE pmdn024 name="input.g.page1.pmdn024"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn014
            #add-point:BEFORE FIELD pmdn014 name="input.b.page1.pmdn014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn014
            
            #add-point:AFTER FIELD pmdn014 name="input.a.page1.pmdn014"
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn014) THEN
               IF g_pmdn_d[l_ac].pmdn014 != g_pmdn_d_o.pmdn014 OR cl_null(g_pmdn_d_o.pmdn014) THEN
                  #150512-00029#2 150525 By pomelo add(S)
                  IF g_pmdn_d[l_ac].pmdn014 < g_today THEN
                     #輸入的到庫日期%1小於系統日期！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00904'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_pmdn_d[l_ac].pmdn014
                     CALL cl_err()
                     LET g_pmdn_d[l_ac].pmdn014 = g_pmdn_d_o.pmdn014
                     NEXT FIELD pmdn014
                  END IF
                  #150512-00029#2 150525 By pomelo add(E)
                  #到庫日期
                  CALL s_apmt840_get_date('2',g_pmdn_d[l_ac].pmdn014,g_pmdn_d[l_ac].pmdnunit,g_pmdl_m.pmdl004)
                     RETURNING l_pmdn014,l_rtka010
                  #有推算出來的到庫日期
                  IF NOT cl_null(l_pmdn014) THEN
                     #當推算出來的到庫日期 < 系統日，警告使用者
                     IF l_pmdn014 < g_today THEN
                        #供應商的到庫日期%1 小於系統日！
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00660'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = l_pmdn014
                        CALL cl_err()
                        LET g_pmdn_d[l_ac].pmdn014 = g_today
                        CALL apmt840_pmdn014_value(l_pmdn014,l_rtka010,'')
                     END IF
                     IF l_pmdn014 >= g_today AND g_pmdn_d[l_ac].pmdn014 != l_pmdn014 THEN
                        #推算出來的供應商送貨日 = %1，是否更新為此日期?
                        LET l_msg = cl_getmsg_parm('apm-00661',g_dlang,l_pmdn014)
                        IF cl_ask_confirm_parm('apm-00661',l_pmdn014) THEN
                           LET g_pmdn_d[l_ac].pmdn014 = l_pmdn014
                        END IF
                     END IF
                  END IF
                  CALL apmt840_pmdn014_value(l_pmdn014,l_rtka010,'')
               END IF
            END IF
            LET g_pmdn_d_o.pmdn012 = g_pmdn_d[l_ac].pmdn012
            LET g_pmdn_d_o.pmdn013 = g_pmdn_d[l_ac].pmdn013
            LET g_pmdn_d_o.pmdn014 = g_pmdn_d[l_ac].pmdn014
            LET g_pmdn_d_o.pmdn020 = g_pmdn_d[l_ac].pmdn020
            #LET g_pmdn_d_o.pmdn224 = g_pmdn_d[l_ac].pmdn224 #150407-00020#1 Mark By Ken 150410
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn014
            #add-point:ON CHANGE pmdn014 name="input.g.page1.pmdn014"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn012
            #add-point:BEFORE FIELD pmdn012 name="input.b.page1.pmdn012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn012
            
            #add-point:AFTER FIELD pmdn012 name="input.a.page1.pmdn012"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn012
            #add-point:ON CHANGE pmdn012 name="input.g.page1.pmdn012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn013
            #add-point:BEFORE FIELD pmdn013 name="input.b.page1.pmdn013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn013
            
            #add-point:AFTER FIELD pmdn013 name="input.a.page1.pmdn013"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn013
            #add-point:ON CHANGE pmdn013 name="input.g.page1.pmdn013"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn022
            #add-point:BEFORE FIELD pmdn022 name="input.b.page1.pmdn022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn022
            
            #add-point:AFTER FIELD pmdn022 name="input.a.page1.pmdn022"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn022
            #add-point:ON CHANGE pmdn022 name="input.g.page1.pmdn022"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn023
            
            #add-point:AFTER FIELD pmdn023 name="input.a.page1.pmdn023"
            LET g_pmdn_d[l_ac].pmdn023_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn023_desc 
            
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn023) THEN 
               IF g_pmdn_d[l_ac].pmdn023 != g_pmdn_d_o.pmdn023 OR cl_null(g_pmdn_d_o.pmdn023) THEN
                  IF NOT s_adb_chk_pmac002(2,g_pmdl_m.pmdl004,g_pmdn_d[l_ac].pmdn023,'2') THEN
                     LET g_pmdn_d[l_ac].pmdn023 = g_pmdn_d_o.pmdn023
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmdn_d[l_ac].pmdn023) RETURNING g_pmdn_d[l_ac].pmdn023_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn023_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn023 = g_pmdn_d[l_ac].pmdn023
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdn_d[l_ac].pmdn023) RETURNING g_pmdn_d[l_ac].pmdn023_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn023_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn023
            #add-point:BEFORE FIELD pmdn023 name="input.b.page1.pmdn023"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn023
            #add-point:ON CHANGE pmdn023 name="input.g.page1.pmdn023"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn045
            #add-point:BEFORE FIELD pmdn045 name="input.b.page1.pmdn045"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn045
            
            #add-point:AFTER FIELD pmdn045 name="input.a.page1.pmdn045"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn045
            #add-point:ON CHANGE pmdn045 name="input.g.page1.pmdn045"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn206
            #add-point:BEFORE FIELD pmdn206 name="input.b.page1.pmdn206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn206
            
            #add-point:AFTER FIELD pmdn206 name="input.a.page1.pmdn206"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn206
            #add-point:ON CHANGE pmdn206 name="input.g.page1.pmdn206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn207
            #add-point:BEFORE FIELD pmdn207 name="input.b.page1.pmdn207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn207
            
            #add-point:AFTER FIELD pmdn207 name="input.a.page1.pmdn207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn207
            #add-point:ON CHANGE pmdn207 name="input.g.page1.pmdn207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn208
            #add-point:BEFORE FIELD pmdn208 name="input.b.page1.pmdn208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn208
            
            #add-point:AFTER FIELD pmdn208 name="input.a.page1.pmdn208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn208
            #add-point:ON CHANGE pmdn208 name="input.g.page1.pmdn208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn209
            #add-point:BEFORE FIELD pmdn209 name="input.b.page1.pmdn209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn209
            
            #add-point:AFTER FIELD pmdn209 name="input.a.page1.pmdn209"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn209
            #add-point:ON CHANGE pmdn209 name="input.g.page1.pmdn209"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn210
            #add-point:BEFORE FIELD pmdn210 name="input.b.page1.pmdn210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn210
            
            #add-point:AFTER FIELD pmdn210 name="input.a.page1.pmdn210"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn210
            #add-point:ON CHANGE pmdn210 name="input.g.page1.pmdn210"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn211
            #add-point:BEFORE FIELD pmdn211 name="input.b.page1.pmdn211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn211
            
            #add-point:AFTER FIELD pmdn211 name="input.a.page1.pmdn211"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn211
            #add-point:ON CHANGE pmdn211 name="input.g.page1.pmdn211"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn212
            #add-point:BEFORE FIELD pmdn212 name="input.b.page1.pmdn212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn212
            
            #add-point:AFTER FIELD pmdn212 name="input.a.page1.pmdn212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn212
            #add-point:ON CHANGE pmdn212 name="input.g.page1.pmdn212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn213
            #add-point:BEFORE FIELD pmdn213 name="input.b.page1.pmdn213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn213
            
            #add-point:AFTER FIELD pmdn213 name="input.a.page1.pmdn213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn213
            #add-point:ON CHANGE pmdn213 name="input.g.page1.pmdn213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn019
            #add-point:BEFORE FIELD pmdn019 name="input.b.page1.pmdn019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn019
            
            #add-point:AFTER FIELD pmdn019 name="input.a.page1.pmdn019"
            #子特性是樣品時，單價为0
            IF g_pmdn_d[l_ac].pmdn019 = '9' THEN
               LET g_pmdn_d[l_ac].pmdn015 = 0
               LET g_pmdn_d[l_ac].pmdn046 = 0
               LET g_pmdn_d[l_ac].pmdn047 = 0
               LET g_pmdn_d[l_ac].pmdn048 = 0
            END IF
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn019
            #add-point:ON CHANGE pmdn019 name="input.g.page1.pmdn019"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn020
            #add-point:BEFORE FIELD pmdn020 name="input.b.page1.pmdn020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn020
            
            #add-point:AFTER FIELD pmdn020 name="input.a.page1.pmdn020"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn020
            #add-point:ON CHANGE pmdn020 name="input.g.page1.pmdn020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn224
            #add-point:BEFORE FIELD pmdn224 name="input.b.page1.pmdn224"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn224
            
            #add-point:AFTER FIELD pmdn224 name="input.a.page1.pmdn224"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn224
            #add-point:ON CHANGE pmdn224 name="input.g.page1.pmdn224"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn052
            #add-point:BEFORE FIELD pmdn052 name="input.b.page1.pmdn052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn052
            
            #add-point:AFTER FIELD pmdn052 name="input.a.page1.pmdn052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn052
            #add-point:ON CHANGE pmdn052 name="input.g.page1.pmdn052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn049
            
            #add-point:AFTER FIELD pmdn049 name="input.a.page1.pmdn049"
            LET g_pmdn_d[l_ac].pmdn049_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn049_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn049) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdn_d[l_ac].pmdn049 != g_pmdn_d_t.pmdn049 OR g_pmdn_d_t.pmdn049 IS NULL )) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdn_d[l_ac].pmdn049 != g_pmdn_d_o.pmdn049 OR cl_null(g_pmdn_d_o.pmdn049) THEN   #160824-00007#12 20160914 add by beckxie
                  IF NOT s_azzi650_chk_exist(l_acc,g_pmdn_d[l_ac].pmdn049)  THEN
                     #LET g_pmdn_d[l_ac].pmdn049 = g_pmdn_d_t.pmdn049   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdn_d[l_ac].pmdn049 = g_pmdn_d_o.pmdn049    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_acc_desc(l_acc,g_pmdn_d[l_ac].pmdn049) RETURNING g_pmdn_d[l_ac].pmdn049_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn049_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn_d_o.pmdn049 = g_pmdn_d[l_ac].pmdn049    #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_acc_desc(l_acc,g_pmdn_d[l_ac].pmdn049) RETURNING g_pmdn_d[l_ac].pmdn049_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn049_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn049
            #add-point:BEFORE FIELD pmdn049 name="input.b.page1.pmdn049"
            LET l_acc = ''
            CALL apmt840_get_gzcb004() RETURNING l_acc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn049
            #add-point:ON CHANGE pmdn049 name="input.g.page1.pmdn049"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn051
            
            #add-point:AFTER FIELD pmdn051 name="input.a.page1.pmdn051"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn051
            #add-point:BEFORE FIELD pmdn051 name="input.b.page1.pmdn051"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn051
            #add-point:ON CHANGE pmdn051 name="input.g.page1.pmdn051"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn205
            
            #add-point:AFTER FIELD pmdn205 name="input.a.page1.pmdn205"
            LET g_pmdn_d[l_ac].pmdn205_desc = ' '
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn205_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn205) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmdn_d[l_ac].pmdn205 != g_pmdn_d_t.pmdn205 OR g_pmdn_d_t.pmdn205 IS NULL )) THEN   #160824-00007#12 20160914 mark by beckxie
               IF g_pmdn_d[l_ac].pmdn205 != g_pmdn_d_o.pmdn205 OR cl_null(g_pmdn_d_o.pmdn205) THEN   #160824-00007#12 20160914 add by beckxie
                  IF s_aooi500_setpoint(g_prog,'pmdn205') THEN
                     CALL s_aooi500_chk(g_prog,'pmdn205',g_pmdn_d[l_ac].pmdn205,g_pmdl_m.pmdlsite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_pmdn_d[l_ac].pmdn205 = g_pmdn_d_t.pmdn205   #160824-00007#12 20160914 mark by beckxie
                        LET g_pmdn_d[l_ac].pmdn205 = g_pmdn_d_o.pmdn205    #160824-00007#12 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn205) RETURNING g_pmdn_d[l_ac].pmdn205_desc
                        DISPLAY BY NAME g_pmdn_d[l_ac].pmdn205_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdn205
                     IF NOT cl_chk_exist("v_ooef001_29") THEN
                        #LET g_pmdn_d[l_ac].pmdn205 = g_pmdn_d_t.pmdn205   #160824-00007#12 20160914 mark by beckxie
                        LET g_pmdn_d[l_ac].pmdn205 = g_pmdn_d_o.pmdn205    #160824-00007#12 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn205) RETURNING g_pmdn_d[l_ac].pmdn205_desc
                        DISPLAY BY NAME g_pmdn_d[l_ac].pmdn205_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #計算單身日結/月結 銷量欄位
                  CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                               g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
               END IF
            END IF
            LET g_pmdn_d_o.pmdn205 = g_pmdn_d[l_ac].pmdn205   #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn205) RETURNING g_pmdn_d[l_ac].pmdn205_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn205_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn205
            #add-point:BEFORE FIELD pmdn205 name="input.b.page1.pmdn205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn205
            #add-point:ON CHANGE pmdn205 name="input.g.page1.pmdn205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn214
            
            #add-point:AFTER FIELD pmdn214 name="input.a.page1.pmdn214"
            LET g_pmdn_d[l_ac].pmdn214_desc = ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn214_desc
            IF NOT cl_null(g_pmdn_d[l_ac].pmdn214) THEN
               IF g_pmdn_d[l_ac].pmdn214 != g_pmdn_d_o.pmdn214 OR cl_null(g_pmdn_d_o.pmdn214) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdn_d[l_ac].pmdn214
                  LET g_chkparam.arg2 = '2'
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     LET g_pmdn_d[l_ac].pmdn214 = g_pmdn_d_o.pmdn214
                     CALL s_desc_get_oojdl003_desc(g_pmdn_d[l_ac].pmdn214) RETURNING g_pmdn_d[l_ac].pmdn214_desc
                     DISPLAY BY NAME g_pmdn_d[l_ac].pmdn214_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_apmt840_get_oojd004(g_pmdn_d[l_ac].pmdn214) RETURNING g_pmdn_d[l_ac].pmdn215
               END IF
            END IF
            LET g_pmdn_d_o.pmdn214 = g_pmdn_d[l_ac].pmdn214
            CALL s_desc_get_oojdl003_desc(g_pmdn_d[l_ac].pmdn214) RETURNING g_pmdn_d[l_ac].pmdn214_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn214_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn214
            #add-point:BEFORE FIELD pmdn214 name="input.b.page1.pmdn214"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn214
            #add-point:ON CHANGE pmdn214 name="input.g.page1.pmdn214"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn215
            #add-point:BEFORE FIELD pmdn215 name="input.b.page1.pmdn215"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn215
            
            #add-point:AFTER FIELD pmdn215 name="input.a.page1.pmdn215"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn215
            #add-point:ON CHANGE pmdn215 name="input.g.page1.pmdn215"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn216
            #add-point:BEFORE FIELD pmdn216 name="input.b.page1.pmdn216"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn216
            
            #add-point:AFTER FIELD pmdn216 name="input.a.page1.pmdn216"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn216
            #add-point:ON CHANGE pmdn216 name="input.g.page1.pmdn216"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn217
            
            #add-point:AFTER FIELD pmdn217 name="input.a.page1.pmdn217"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn217
            CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdn_d[l_ac].pmdn217_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn217_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn217
            #add-point:BEFORE FIELD pmdn217 name="input.b.page1.pmdn217"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn217
            #add-point:ON CHANGE pmdn217 name="input.g.page1.pmdn217"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn218
            #add-point:BEFORE FIELD pmdn218 name="input.b.page1.pmdn218"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn218
            
            #add-point:AFTER FIELD pmdn218 name="input.a.page1.pmdn218"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn218
            #add-point:ON CHANGE pmdn218 name="input.g.page1.pmdn218"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn219
            #add-point:BEFORE FIELD pmdn219 name="input.b.page1.pmdn219"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn219
            
            #add-point:AFTER FIELD pmdn219 name="input.a.page1.pmdn219"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn219
            #add-point:ON CHANGE pmdn219 name="input.g.page1.pmdn219"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn220
            
            #add-point:AFTER FIELD pmdn220 name="input.a.page1.pmdn220"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn220
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdn_d[l_ac].pmdn220_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn220_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn220
            #add-point:BEFORE FIELD pmdn220 name="input.b.page1.pmdn220"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn220
            #add-point:ON CHANGE pmdn220 name="input.g.page1.pmdn220"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn221
            
            #add-point:AFTER FIELD pmdn221 name="input.a.page1.pmdn221"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn221
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdn_d[l_ac].pmdn221_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn221_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn221
            #add-point:BEFORE FIELD pmdn221 name="input.b.page1.pmdn221"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn221
            #add-point:ON CHANGE pmdn221 name="input.g.page1.pmdn221"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn222
            #add-point:BEFORE FIELD pmdn222 name="input.b.page1.pmdn222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn222
            
            #add-point:AFTER FIELD pmdn222 name="input.a.page1.pmdn222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn222
            #add-point:ON CHANGE pmdn222 name="input.g.page1.pmdn222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn223
            #add-point:BEFORE FIELD pmdn223 name="input.b.page1.pmdn223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn223
            
            #add-point:AFTER FIELD pmdn223 name="input.a.page1.pmdn223"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn223
            #add-point:ON CHANGE pmdn223 name="input.g.page1.pmdn223"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdn050
            #add-point:BEFORE FIELD pmdn050 name="input.b.page1.pmdn050"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdn050
            
            #add-point:AFTER FIELD pmdn050 name="input.a.page1.pmdn050"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdn050
            #add-point:ON CHANGE pmdn050 name="input.g.page1.pmdn050"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnseq
            #add-point:ON ACTION controlp INFIELD pmdnseq name="input.c.page1.pmdnseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnsite
            #add-point:ON ACTION controlp INFIELD pmdnsite name="input.c.page1.pmdnsite"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdnsite
            
            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdnsite',g_pmdl_m.pmdlsite,'i')
            CALL q_ooef001_24()
            LET g_pmdn_d[l_ac].pmdnsite = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdnsite TO pmdnsite
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnsite) RETURNING g_pmdn_d[l_ac].pmdnsite_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnsite_desc
            NEXT FIELD pmdnsite
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn200
            #add-point:ON ACTION controlp INFIELD pmdn200 name="input.c.page1.pmdn200"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn200             #給予default值
            LET g_qryparam.arg1 = g_pmdn_d[l_ac].pmdnsite
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM rtdx_t,imaf_t",
                                   "          WHERE rtdxent = ",g_enterprise,
                                   "            AND rtdxsite = '",g_pmdn_d[l_ac].pmdnsite,"'",
                                   "            AND rtdx001 = imaa001",
                                   "            AND rtdxstus = 'Y'",
                                   "            AND imafent = rtdxent",
                                   "            AND imafsite = rtdxsite",
                                   "            AND imaf001 = rtdx001",
                                   "            AND imafstus = 'Y'",
                                   "            AND imaf153 = '",g_pmdl_m.pmdl004,"')"                                   
            #150610-00030#1 150612 By sakura add(S)            
            IF NOT cl_null(g_pmdl_m.pmdl207) THEN
               #取得品類管理層級
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               #所屬品類篩選               
               LET g_qryparam.where = g_qryparam.where CLIPPED, 
                                      "AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "                  WHERE rtaxent =",g_enterprise," AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "                  START WITH rtax003 = '",g_pmdl_m.pmdl207,"' ",
                                      "                  CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                                      "                  UNION ",
                                      "                 SELECT DISTINCT rtax001",
                                      "                            FROM rtax_t ",
                                      "                           WHERE rtaxent =",g_enterprise,
                                      "                             AND rtax004 = ",l_sys,
                                      "                             AND rtax005 = 0 ",
                                      "                             AND rtaxstus = 'Y' ",
                                      "                             AND rtax001 = '",g_pmdl_m.pmdl207,"' )"                                       
            END IF            
            #部門品類(arti204)控卡
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmdl_m.pmdl003,'2')
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmdl_m.pmdl003,'2')
            END IF            
            #150610-00030#1 150612 By sakura add(E)                                
            CALL q_imay003_11()
            LET g_pmdn_d[l_ac].pmdn200 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn200 TO pmdn200 
            NEXT FIELD pmdn200
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn001
            #add-point:ON ACTION controlp INFIELD pmdn001 name="input.c.page1.pmdn001"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn001
            LET g_qryparam.arg1 = 'ALL'
            LET g_qryparam.arg2 = g_pmdn_d[l_ac].pmdnsite
            LET g_qryparam.arg3 = g_pmdl_m.pmdl004
            #150610-00030#1 150612 By sakura add(S)            
            IF NOT cl_null(g_pmdl_m.pmdl207) THEN
               #取得品類管理層級
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               #所屬品類篩選               
               LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "              WHERE rtaxent =",g_enterprise," AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "              START WITH rtax003 = '",g_pmdl_m.pmdl207,"' ",
                                      "              CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                                      "              UNION ",
                                      "             SELECT DISTINCT rtax001",
                                      "                        FROM rtax_t ",
                                      "                       WHERE rtaxent =",g_enterprise,
                                      "                         AND rtax004 = ",l_sys,
                                      "                         AND rtax005 = 0 ",
                                      "                         AND rtaxstus = 'Y' ",
                                      "                         AND rtax001 = '",g_pmdl_m.pmdl207,"' )"                                     
            END IF            
            #部門品類(arti204)控卡
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmdl_m.pmdl003,'2')
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmdl_m.pmdl003,'2')
            END IF           
            #150610-00030#1 150612 By sakura add(E)

           #CALL q_imaf001_19() #170217-00026#1 17/02/21 By 08171
            CALL q_imaf001_27() #170217-00026#1 17/02/21 By 08171
            LET g_pmdn_d[l_ac].pmdn001 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn001 TO pmdn001
            CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001) RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc
            NEXT FIELD pmdn001
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn002
            #add-point:ON ACTION controlp INFIELD pmdn002 name="input.c.page1.pmdn002"
            LET l_imaa005 = ''
            CALL apmt840_get_imaa005(g_pmdn_d[l_ac].pmdn001) RETURNING l_imaa005
               
            IF NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdn_d[l_ac].pmdn001,'','',g_site,g_pmdl_m.pmdldocno) RETURNING l_success,l_inam
                  LET g_pmdn_d[l_ac].pmdn002 = l_inam[1].inam002
                  LET g_pmdn_d[l_ac].pmdn007 = l_inam[1].inam004
                  DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002,g_pmdn_d[l_ac].pmdn007
                  
                  #單位間的轉換數量
                  #150903-00007#1 150903 by sakura mark&add(E)
                  #CALL apmt840_num_change()
                  IF NOT apmt840_num_change() THEN
                     NEXT FIELD pmdn002
                  END IF
                  #150903-00007#1 150903 by sakura mark&add(E)
                  
                  #150413-00018#1 2015/04/15 By sakura modify ---- S
                  #可用庫存量
                  #CALL s_apmt840_sum_inag008(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                  #  RETURNING g_pmdn_d[l_ac].pmdn206
                  #可用庫存量 跟 採購在途量
                  CALL apmt840_get_sum(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207
                  #150413-00018#1 2015/04/15 By sakura modify ---- E
                  #計算單身日結/月結 銷量欄位
                  CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
                     RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, #160120-00001#5 160121 By pomelo add pmdn208
                               g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002,g_site,g_pmdl_m.pmdldocno)
                     RETURNING l_success,g_pmdn_d[l_ac].pmdn002
               END IF
            END IF
            CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn016
            #add-point:ON ACTION controlp INFIELD pmdn016 name="input.c.page1.pmdn016"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn017
            #add-point:ON ACTION controlp INFIELD pmdn017 name="input.c.page1.pmdn017"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn227
            #add-point:ON ACTION controlp INFIELD pmdn227 name="input.c.page1.pmdn227"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn201
            #add-point:ON ACTION controlp INFIELD pmdn201 name="input.c.page1.pmdn201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn202
            #add-point:ON ACTION controlp INFIELD pmdn202 name="input.c.page1.pmdn202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn006
            #add-point:ON ACTION controlp INFIELD pmdn006 name="input.c.page1.pmdn006"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn007
            #add-point:ON ACTION controlp INFIELD pmdn007 name="input.c.page1.pmdn007"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn226
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn226
            #add-point:ON ACTION controlp INFIELD pmdn226 name="input.c.page1.pmdn226"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn008
            #add-point:ON ACTION controlp INFIELD pmdn008 name="input.c.page1.pmdn008"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdn_d[l_ac].pmdn001
            CALL q_imao002()                                #呼叫開窗

            LET g_pmdn_d[l_ac].pmdn008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdn_d[l_ac].pmdn008 TO pmdn008              #顯示到畫面上

            NEXT FIELD pmdn008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn009
            #add-point:ON ACTION controlp INFIELD pmdn009 name="input.c.page1.pmdn009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn010
            #add-point:ON ACTION controlp INFIELD pmdn010 name="input.c.page1.pmdn010"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn011
            #add-point:ON ACTION controlp INFIELD pmdn011 name="input.c.page1.pmdn011"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn015
            #add-point:ON ACTION controlp INFIELD pmdn015 name="input.c.page1.pmdn015"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn043
            #add-point:ON ACTION controlp INFIELD pmdn043 name="input.c.page1.pmdn043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn046
            #add-point:ON ACTION controlp INFIELD pmdn046 name="input.c.page1.pmdn046"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn048
            #add-point:ON ACTION controlp INFIELD pmdn048 name="input.c.page1.pmdn048"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn047
            #add-point:ON ACTION controlp INFIELD pmdn047 name="input.c.page1.pmdn047"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdnunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnunit
            #add-point:ON ACTION controlp INFIELD pmdnunit name="input.c.page1.pmdnunit"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdnunit
            
            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdnunit',g_pmdl_m.pmdlsite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()
            LET g_pmdn_d[l_ac].pmdnunit = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdnunit TO pmdnunit
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnunit) RETURNING g_pmdn_d[l_ac].pmdnunit_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdnunit_desc
            NEXT FIELD pmdnunit
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn225
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn225
            #add-point:ON ACTION controlp INFIELD pmdn225 name="input.c.page1.pmdn225"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn203
            #add-point:ON ACTION controlp INFIELD pmdn203 name="input.c.page1.pmdn203"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn203
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdldocdt
            CALL q_ooeg001()
            LET g_pmdn_d[l_ac].pmdn203 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn203 TO pmdn203
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn203) RETURNING g_pmdn_d[l_ac].pmdn203_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn203_desc
            NEXT FIELD pmdn203
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn025
            #add-point:ON ACTION controlp INFIELD pmdn025 name="input.c.page1.pmdn025"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn025
            
            #給予arg
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '3' "  #出貨地址

            CALL q_oofb019_1()
            LET g_pmdn_d[l_ac].pmdn025 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn025 TO pmdn025
            CALL s_apmt840_address_ref('3',g_pmdn_d[l_ac].pmdn025,l_ooef001)
               RETURNING g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
            NEXT FIELD pmdn025
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn025_desc
            #add-point:ON ACTION controlp INFIELD pmdn025_desc name="input.c.page1.pmdn025_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmdn025_addr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdn025_addr
            #add-point:ON ACTION controlp INFIELD l_pmdn025_addr name="input.c.page1.l_pmdn025_addr"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn028
            #add-point:ON ACTION controlp INFIELD pmdn028 name="input.c.page1.pmdn028"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn028 
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdn_d[l_ac].pmdn001
            LET g_qryparam.arg2 = g_pmdl_m.pmdl203
            IF g_pmdl_m.pmdl203 = '3' THEN
               LET g_qryparam.arg3 = g_pmdn_d[l_ac].pmdn223
            ELSE
               LET g_qryparam.arg3 = g_pmdn_d[l_ac].pmdn222
            END IF
            #LET g_qryparam.arg4 = g_pmdn_d[l_ac].pmdnunit  #160304-00027#1 160325 By pomelo mark
            LET g_qryparam.arg4 = g_pmdn_d[l_ac].pmdn225    #160304-00027#1 160325 By pomelo add
            
            LET g_qryparam.where = s_inaa_ctrlp(g_pmdn_d[l_ac].pmdn216)    #150518-00001#2--add by dongsz
            
            CALL q_inaa001_27()
            LET g_pmdn_d[l_ac].pmdn028 = g_qryparam.return1 
            DISPLAY g_pmdn_d[l_ac].pmdn028 TO pmdn028
            CALL s_desc_get_stock_desc('',g_pmdn_d[l_ac].pmdn028) RETURNING g_pmdn_d[l_ac].pmdn028_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn028_desc
            NEXT FIELD pmdn028
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn029
            #add-point:ON ACTION controlp INFIELD pmdn029 name="input.c.page1.pmdn029"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn029             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = g_pmdn_d[l_ac].pmdnunit  #160304-00027#1 160325 By pomelo mark
            LET g_qryparam.arg1 = g_pmdn_d[l_ac].pmdn225    #160304-00027#1 160325 By pomelo add
            LET g_qryparam.arg2 = g_pmdn_d[l_ac].pmdn028
            
            CALL q_inab002_6()
            LET g_pmdn_d[l_ac].pmdn029 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn029 TO pmdn029
            CALL s_desc_get_locator_desc(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029)
               RETURNING g_pmdn_d[l_ac].pmdn029_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn029_desc
            NEXT FIELD pmdn029
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn029_desc
            #add-point:ON ACTION controlp INFIELD pmdn029_desc name="input.c.page1.pmdn029_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn030
            #add-point:ON ACTION controlp INFIELD pmdn030 name="input.c.page1.pmdn030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn053
            #add-point:ON ACTION controlp INFIELD pmdn053 name="input.c.page1.pmdn053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdnorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnorga
            #add-point:ON ACTION controlp INFIELD pmdnorga name="input.c.page1.pmdnorga"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn026
            #add-point:ON ACTION controlp INFIELD pmdn026 name="input.c.page1.pmdn026"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn026
            
            #給予arg
            LET g_qryparam.arg1 = l_ooef012
            LET g_qryparam.where = " oofb008 = '5' "  #帳款地址

            CALL q_oofb019_1()
            LET g_pmdn_d[l_ac].pmdn026 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn026 TO pmdn026
            CALL s_apmt840_address_ref('5',g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdnorga)
               RETURNING g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            NEXT FIELD pmdn026
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn026_desc
            #add-point:ON ACTION controlp INFIELD pmdn026_desc name="input.c.page1.pmdn026_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_pmdn026_addr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pmdn026_addr
            #add-point:ON ACTION controlp INFIELD l_pmdn026_addr name="input.c.page1.l_pmdn026_addr"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn024
            #add-point:ON ACTION controlp INFIELD pmdn024 name="input.c.page1.pmdn024"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn014
            #add-point:ON ACTION controlp INFIELD pmdn014 name="input.c.page1.pmdn014"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn012
            #add-point:ON ACTION controlp INFIELD pmdn012 name="input.c.page1.pmdn012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn013
            #add-point:ON ACTION controlp INFIELD pmdn013 name="input.c.page1.pmdn013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn022
            #add-point:ON ACTION controlp INFIELD pmdn022 name="input.c.page1.pmdn022"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn023
            #add-point:ON ACTION controlp INFIELD pmdn023 name="input.c.page1.pmdn023"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            LET g_qryparam.where = " pmac003 = '2' "
            
            CALL q_pmac002_2()
            LET g_pmdn_d[l_ac].pmdn023 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn023 TO pmdn023
            CALL s_desc_get_trading_partner_abbr_desc(g_pmdn_d[l_ac].pmdn023) RETURNING g_pmdn_d[l_ac].pmdn023_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn023_desc
            NEXT FIELD pmdn023
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn045
            #add-point:ON ACTION controlp INFIELD pmdn045 name="input.c.page1.pmdn045"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn206
            #add-point:ON ACTION controlp INFIELD pmdn206 name="input.c.page1.pmdn206"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn207
            #add-point:ON ACTION controlp INFIELD pmdn207 name="input.c.page1.pmdn207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn208
            #add-point:ON ACTION controlp INFIELD pmdn208 name="input.c.page1.pmdn208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn209
            #add-point:ON ACTION controlp INFIELD pmdn209 name="input.c.page1.pmdn209"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn210
            #add-point:ON ACTION controlp INFIELD pmdn210 name="input.c.page1.pmdn210"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn211
            #add-point:ON ACTION controlp INFIELD pmdn211 name="input.c.page1.pmdn211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn212
            #add-point:ON ACTION controlp INFIELD pmdn212 name="input.c.page1.pmdn212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn213
            #add-point:ON ACTION controlp INFIELD pmdn213 name="input.c.page1.pmdn213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn019
            #add-point:ON ACTION controlp INFIELD pmdn019 name="input.c.page1.pmdn019"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn020
            #add-point:ON ACTION controlp INFIELD pmdn020 name="input.c.page1.pmdn020"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn224
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn224
            #add-point:ON ACTION controlp INFIELD pmdn224 name="input.c.page1.pmdn224"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn052
            #add-point:ON ACTION controlp INFIELD pmdn052 name="input.c.page1.pmdn052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn049
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn049
            #add-point:ON ACTION controlp INFIELD pmdn049 name="input.c.page1.pmdn049"
             #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn049
            
            #給予arg
            LET g_qryparam.arg1 = apmt840_get_gzcb004()
            CALL q_oocq002()
            LET g_pmdn_d[l_ac].pmdn049 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn049 TO pmdn049
            CALL s_desc_get_acc_desc(l_acc,g_pmdn_d[l_ac].pmdn049) RETURNING g_pmdn_d[l_ac].pmdn049_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn049_desc
            NEXT FIELD pmdn049
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn051
            #add-point:ON ACTION controlp INFIELD pmdn051 name="input.c.page1.pmdn051"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn205
            #add-point:ON ACTION controlp INFIELD pmdn205 name="input.c.page1.pmdn205"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn205             #給予default值

            #給予arg
            IF s_aooi500_setpoint(g_prog,'pmdn205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdn205',g_pmdl_m.pmdlsite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef210 = 'Y'"
               CALL q_ooef001()                    #呼叫開窗
            END IF
            LET g_pmdn_d[l_ac].pmdn205 = g_qryparam.return1
            DISPLAY g_pmdn_d[l_ac].pmdn205 TO pmdn205
            CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn205) RETURNING g_pmdn_d[l_ac].pmdn205_desc
            DISPLAY BY NAME g_pmdn_d[l_ac].pmdn205_desc
            NEXT FIELD pmdn205
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn214
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn214
            #add-point:ON ACTION controlp INFIELD pmdn214 name="input.c.page1.pmdn214"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn_d[l_ac].pmdn214
            
            #給予arg
            LET g_qryparam.arg1 = "2"
            CALL q_oojd001_1()
            LET g_pmdn_d[l_ac].pmdn214 = g_qryparam.return1 
            DISPLAY g_pmdn_d[l_ac].pmdn214 TO pmdn214
            CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc
            DISPLAY BY NAME g_pmdl_m.pmdl023_desc
            NEXT FIELD pmdn214
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn215
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn215
            #add-point:ON ACTION controlp INFIELD pmdn215 name="input.c.page1.pmdn215"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn216
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn216
            #add-point:ON ACTION controlp INFIELD pmdn216 name="input.c.page1.pmdn216"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn217
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn217
            #add-point:ON ACTION controlp INFIELD pmdn217 name="input.c.page1.pmdn217"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn218
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn218
            #add-point:ON ACTION controlp INFIELD pmdn218 name="input.c.page1.pmdn218"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn219
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn219
            #add-point:ON ACTION controlp INFIELD pmdn219 name="input.c.page1.pmdn219"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn220
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn220
            #add-point:ON ACTION controlp INFIELD pmdn220 name="input.c.page1.pmdn220"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn221
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn221
            #add-point:ON ACTION controlp INFIELD pmdn221 name="input.c.page1.pmdn221"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn222
            #add-point:ON ACTION controlp INFIELD pmdn222 name="input.c.page1.pmdn222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn223
            #add-point:ON ACTION controlp INFIELD pmdn223 name="input.c.page1.pmdn223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdn050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdn050
            #add-point:ON ACTION controlp INFIELD pmdn050 name="input.c.page1.pmdn050"
                        
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt840_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdn_d[l_ac].pmdnseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt840_pmdn_t_mask_restore('restore_mask_o')
      
               UPDATE pmdn_t SET (pmdndocno,pmdnseq,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016, 
                   pmdn017,pmdn227,pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011, 
                   pmdn015,pmdn043,pmdn046,pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn028, 
                   pmdn029,pmdn030,pmdn053,pmdnorga,pmdn026,pmdn024,pmdn014,pmdn012,pmdn013,pmdn022, 
                   pmdn023,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019, 
                   pmdn020,pmdn224,pmdn052,pmdn049,pmdn051,pmdn205,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218, 
                   pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn050) = (g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq, 
                   g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn200,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn228, 
                   g_pmdn_d[l_ac].pmdn002,g_pmdn_d[l_ac].pmdn016,g_pmdn_d[l_ac].pmdn017,g_pmdn_d[l_ac].pmdn227, 
                   g_pmdn_d[l_ac].pmdn201,g_pmdn_d[l_ac].pmdn202,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007, 
                   g_pmdn_d[l_ac].pmdn226,g_pmdn_d[l_ac].pmdn008,g_pmdn_d[l_ac].pmdn009,g_pmdn_d[l_ac].pmdn010, 
                   g_pmdn_d[l_ac].pmdn011,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn043,g_pmdn_d[l_ac].pmdn046, 
                   g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047,g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn225, 
                   g_pmdn_d[l_ac].pmdn203,g_pmdn_d[l_ac].pmdn025,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029, 
                   g_pmdn_d[l_ac].pmdn030,g_pmdn_d[l_ac].pmdn053,g_pmdn_d[l_ac].pmdnorga,g_pmdn_d[l_ac].pmdn026, 
                   g_pmdn_d[l_ac].pmdn024,g_pmdn_d[l_ac].pmdn014,g_pmdn_d[l_ac].pmdn012,g_pmdn_d[l_ac].pmdn013, 
                   g_pmdn_d[l_ac].pmdn022,g_pmdn_d[l_ac].pmdn023,g_pmdn_d[l_ac].pmdn045,g_pmdn_d[l_ac].pmdn206, 
                   g_pmdn_d[l_ac].pmdn207,g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210, 
                   g_pmdn_d[l_ac].pmdn211,g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213,g_pmdn_d[l_ac].pmdn019, 
                   g_pmdn_d[l_ac].pmdn020,g_pmdn_d[l_ac].pmdn224,g_pmdn_d[l_ac].pmdn052,g_pmdn_d[l_ac].pmdn049, 
                   g_pmdn_d[l_ac].pmdn051,g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn214,g_pmdn_d[l_ac].pmdn215, 
                   g_pmdn_d[l_ac].pmdn216,g_pmdn_d[l_ac].pmdn217,g_pmdn_d[l_ac].pmdn218,g_pmdn_d[l_ac].pmdn219, 
                   g_pmdn_d[l_ac].pmdn220,g_pmdn_d[l_ac].pmdn221,g_pmdn_d[l_ac].pmdn222,g_pmdn_d[l_ac].pmdn223, 
                   g_pmdn_d[l_ac].pmdn050)
                WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdl_m.pmdldocno 
 
                  AND pmdnseq = g_pmdn_d_t.pmdnseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdl_m.pmdldocno
               LET gs_keys_bak[1] = g_pmdldocno_t
               LET gs_keys[2] = g_pmdn_d[g_detail_idx].pmdnseq
               LET gs_keys_bak[2] = g_pmdn_d_t.pmdnseq
               CALL apmt840_update_b('pmdn_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt840_pmdn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdn_d[g_detail_idx].pmdnseq = g_pmdn_d_t.pmdnseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmdl_m.pmdldocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdn_d_t.pmdnseq
 
                  CALL apmt840_key_update_b(gs_keys,'pmdn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmdl_m),util.JSON.stringify(g_pmdn_d_t)
               LET g_log2 = util.JSON.stringify(g_pmdl_m),util.JSON.stringify(g_pmdn_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #當更改到項次的時候
               IF g_pmdn_d[l_ac].pmdnseq <> g_pmdn_d_t.pmdnseq THEN
                  UPDATE pmdo_t
                     SET pmdoseq = g_pmdn_d[l_ac].pmdnseq
                   WHERE pmdoent = g_enterprise
                     AND pmdodocno = g_pmdl_m.pmdldocno
                     AND pmdoseq = g_pmdn_d_t.pmdnseq
                  IF SQLCA.sqlcode THEN #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*                     
                     CALL s_transaction_end('N','0')
                  END IF
                  UPDATE pmdq_t
                     SET pmdqseq = g_pmdn_d[l_ac].pmdnseq
                   WHERE pmdqent = g_enterprise
                     AND pmdqdocno = g_pmdl_m.pmdldocno
                     AND pmdqseq = g_pmdn_d_t.pmdnseq 
                  IF SQLCA.sqlcode THEN  #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdq_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*                     
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               
               IF s_apmt840_gen_pmdq(g_pmdl_m.pmdldocno,g_pmdn_d_t.pmdnseq) THEN
                  IF NOT s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno,g_pmdn_d_t.pmdnseq) THEN
                     CALL s_transaction_end('N','0')
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')
               END IF     
               
               CALL apmt840_b_fill()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
               #150407-00020#1 Add-S By Ken 150410
               #CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
               #IF NOT l_success THEN
               #150604  Mark
               #IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN   #150512-00029#2 150525 By pomelo add
               #   CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,0,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
               #   IF cl_null(g_pmdl_m.pmdl205) OR g_pmdl_m.pmdl205 < l_pmdl205 THEN
               #      LET l_replace = g_pmdl_m.pmdl205 ,"|", l_pmdl205
               #      LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)            
               #      IF NOT cl_null(g_pmdl_m.pmdl205) THEN
               #         IF cl_ask_confirm_parm('std-00008',l_msg) THEN
               #            IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
               #               CALL s_transaction_end('N','0')
               #               CALL cl_err_collect_show()
               #            END IF
               #         ELSE
               #         END IF
               #      ELSE
               #         IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
               #            CALL s_transaction_end('N','0')
               #            CALL cl_err_collect_show()
               #         END IF
               #      END IF
               #   END IF
               #END IF   #150512-00029#2 150525 By pomelo add(S)                 
               #150604 Mark
               #END IF
               #150407-00020#1 Add-E                        
            #end add-point
            CALL apmt840_unlock_b("pmdn_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #當有關聯性單據資料　不可以對單身資料進行新增刪除動作
            IF s_apmt840_count_pmdp(g_pmdl_m.pmdldocno) THEN
               CALL cl_set_act_visible("insert,delete",TRUE)
            ELSE
               LET l_success = FALSE
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
                  LET l_success = TRUE
               END IF
               CALL s_tax_recount(g_pmdl_m.pmdldocno)
                  RETURNING l_xrcd103,l_xrcd104,l_xrcd105,l_xrcd113,l_xrcd114,l_xrcd115
               UPDATE pmdl_t SET pmdl040 = l_xrcd103,
                                 pmdl042 = l_xrcd104,
                                 pmdl041 = l_xrcd105
                WHERE pmdlent = g_enterprise
                  AND pmdldocno = g_pmdl_m.pmdldocno
               LET g_pmdl_m.pmdl040 = l_xrcd103
               LET g_pmdl_m.pmdl042 = l_xrcd104
               LET g_pmdl_m.pmdl041 = l_xrcd105
               IF l_success THEN
                  IF SQLCA.sqlcode THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
               DISPLAY BY NAME g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdl042,
                               g_pmdl_m.pmdl205,g_pmdl_m.pmdl206
            END IF
            ##150608 By pomelo add(S)
            LET l_success = ''
            LET l_confirm = ''
            CALL apmt840_expiration_date('Y')
               RETURNING l_success,l_confirm
            IF l_success AND l_confirm = FALSE THEN
               NEXT FIELD pmdnseq
            END IF
            ##150608 By pomelo add(E)
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
 
               LET g_pmdn_d[li_reproduce_target].pmdnseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdn_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_pmdn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL apmt840_idx_chk()
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
            CALL apmt840_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_pmdn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL apmt840_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL apmt840_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
                  
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_pmdn6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL apmt840_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            LET g_detail_idx = l_ac
            
            #add-point:page4, before row動作 name="input.body6.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            CALL apmt840_idx_chk()
            LET g_current_page = 4
      
         #add-point:page4自定義行為 name="input.body6.action"
                  
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="apmt840.input.other" >}
      
      #add-point:自定義input name="input.more_input"
            
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD pmdlsite
            #end add-point  
            NEXT FIELD pmdldocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmdnseq
               WHEN "s_detail2"
                  NEXT FIELD xrcdsite
               WHEN "s_detail3"
                  NEXT FIELD pmdosite
               WHEN "s_detail6"
                  NEXT FIELD pmdmsite
 
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
         LET g_field = DIALOG.getCurrentItem()
         ###150608 By pomelo add(S)
         #LET l_success = ''
         #LET l_confirm = ''
         #CALL apmt840_expiration_date('Y')
         #   RETURNING l_success,l_confirm
         #IF l_success AND l_confirm = FALSE THEN
         #   CONTINUE DIALOG
         #END IF
         ###150608 By pomelo add(E)
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         ##Add-S By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單)             
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF        
         #IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN   #150512-00029#2 150525 By pomelo add
         #   CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,0,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
         #   IF (g_pmdl_m.pmdl205 < l_pmdl205) OR cl_null(g_pmdl_m.pmdl205) THEN
         #      LET l_replace = g_pmdl_m.pmdl205 ,"|",l_pmdl205
         #      LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)
         #      IF NOT cl_null(g_pmdl_m.pmdl205) THEN
         #         IF cl_ask_confirm_parm('std-00008',l_msg) THEN
         #            IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #               CALL s_transaction_end('N','0')
         #               CALL cl_err_collect_show()
         #               NEXT FIELD CURRENT
         #            ELSE
         #               CALL s_transaction_end('Y','0')
         #            END IF
         #         ELSE
         #            NEXT FIELD CURRENT
         #         END IF
         #      ELSE
         #         IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #            CALL s_transaction_end('N','0')
         #            CALL cl_err_collect_show()
         #            NEXT FIELD CURRENT
         #         ELSE
         #            CALL s_transaction_end('Y','0')
         #         END IF
         #      END IF
         #   END IF
         #END IF   #150512-00029#2 150525 By pomelo add(S)
         #DISPLAY g_pmdl_m.pmdl205 TO pmdl205
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF              
         ##Add-E By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單)   
         ##150608 By pomelo add(S)
         LET l_success = ''
         LET l_confirm = ''
         CALL apmt840_expiration_date('N')
            RETURNING l_success,l_confirm
         IF l_success AND l_confirm = FALSE THEN
            CONTINUE DIALOG
         END IF
         ##150608 By pomelo add(E)
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
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         ##Add-S By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單)             
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF        
         #IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN   #150512-00029#2 150525 By pomelo add
         #   CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,0,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
         #   IF (g_pmdl_m.pmdl205 < l_pmdl205) OR cl_null(g_pmdl_m.pmdl205) THEN
         #      LET l_replace = g_pmdl_m.pmdl205 ,"|",l_pmdl205
         #      LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)
         #      IF NOT cl_null(g_pmdl_m.pmdl205) THEN
         #         IF cl_ask_confirm_parm('std-00008',l_msg) THEN
         #            IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #               CALL s_transaction_end('N','0')
         #               CALL cl_err_collect_show()
         #               NEXT FIELD CURRENT
         #            ELSE
         #               CALL s_transaction_end('Y','0')
         #            END IF
         #         ELSE
         #            NEXT FIELD CURRENT
         #         END IF
         #      ELSE
         #         IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #            CALL s_transaction_end('N','0')
         #            CALL cl_err_collect_show()
         #            NEXT FIELD CURRENT
         #         ELSE
         #            CALL s_transaction_end('Y','0')
         #         END IF
         #      END IF
         #   END IF
         #END IF   #150512-00029#2 150525 By pomelo add(S)
         #DISPLAY g_pmdl_m.pmdl205 TO pmdl205
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF              
         ##Add-E By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單) 
         ##150608 By pomelo add(S)
         LET l_success = ''
         LET l_confirm = ''
         CALL apmt840_expiration_date('N')
            RETURNING l_success,l_confirm
         IF l_success AND l_confirm = FALSE THEN
            CONTINUE DIALOG
         END IF
         ##150608 By pomelo add(E)
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         ##Add-S By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單)             
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF        
         #IF g_pmdl_m.pmdl206 = 'N' OR cl_null(g_pmdl_m.pmdl206) THEN   #150512-00029#2 150525 By pomelo add
         #   CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,0,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
         #   IF (g_pmdl_m.pmdl205 < l_pmdl205) OR cl_null(g_pmdl_m.pmdl205) THEN
         #      LET l_replace = g_pmdl_m.pmdl205 ,"|",l_pmdl205
         #      LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)
         #      IF NOT cl_null(g_pmdl_m.pmdl205) THEN
         #         IF cl_ask_confirm_parm('std-00008',l_msg) THEN
         #            IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #               CALL s_transaction_end('N','0')
         #               CALL cl_err_collect_show()
         #               NEXT FIELD CURRENT
         #            ELSE
         #               CALL s_transaction_end('Y','0')
         #            END IF
         #         ELSE
         #            NEXT FIELD CURRENT
         #         END IF
         #      ELSE
         #         IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #            CALL s_transaction_end('N','0')
         #            CALL cl_err_collect_show()
         #            NEXT FIELD CURRENT
         #         ELSE
         #            CALL s_transaction_end('Y','0')
         #         END IF
         #      END IF
         #   END IF
         #END IF   #150512-00029#2 150525 By pomelo add(S)
         #DISPLAY g_pmdl_m.pmdl205 TO pmdl205
         #IF s_transaction_chk("N",0) THEN
         #   CALL s_transaction_begin()
         #END IF              
         ##Add-E By Ken 150604 單身離開更新單頭採購失效日 (型管的修改單號尚未開單) 
         ##150608 By pomelo add(S)
         LET l_success = ''
         LET l_confirm = ''
         CALL apmt840_expiration_date('N')
            RETURNING l_success,l_confirm
         IF l_success AND l_confirm = FALSE THEN
            CONTINUE DIALOG
         END IF
         ##150608 By pomelo add(E)
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
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
      
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt840_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooba002   LIKE ooba_t.ooba002
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt840_b_fill() #單身填充
      CALL apmt840_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt840_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #採購組織
   CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite) RETURNING g_pmdl_m.pmdlsite_desc
   
   #採購中心
   CALL s_desc_get_department_desc(g_pmdl_m.pmdl200) RETURNING g_pmdl_m.pmdl200_desc
   
   #供應商
   CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl004) RETURNING g_pmdl_m.pmdl004_desc
   
   #採購人員
   CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
   
   #採購部門
   CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
   
   #供應商聯絡人
   CALL apmt840_pmdl027_ref(g_pmdl_m.pmdl027) RETURNING g_pmdl_m.pmdl027_desc

   #配送中心
   CALL s_desc_get_department_desc(g_pmdl_m.pmdl204) RETURNING g_pmdl_m.pmdl204_desc

   #收貨組織
   CALL s_desc_get_department_desc(g_pmdl_m.pmdlunit) RETURNING g_pmdl_m.pmdlunit_desc

   #收貨部門
   CALL s_desc_get_department_desc(g_pmdl_m.pmdl029) RETURNING g_pmdl_m.pmdl029_desc

   #收貨地址
   IF g_pmdl_m.pmdl203 = '3' THEN
      CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,g_pmdl_m.pmdl204)
         RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
   ELSE
      CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,g_pmdl_m.pmdlunit)
         RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
   END IF
   
   #採購渠道
   CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc

   #送貨供應商
   CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl022) RETURNING g_pmdl_m.pmdl022_desc

   #付款供應商
   CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl021) RETURNING g_pmdl_m.pmdl021_desc
   
   #留置原因
   
   #運送方式
   CALL s_desc_get_acc_desc('263',g_pmdl_m.pmdl020) RETURNING g_pmdl_m.pmdl020_desc
   
   #付款條件
   CALL s_desc_get_ooib002_desc(g_pmdl_m.pmdl009) RETURNING g_pmdl_m.pmdl009_desc
   
   #幣別
   CALL s_desc_get_currency_desc(g_pmdl_m.pmdl015) RETURNING g_pmdl_m.pmdl015_desc
   
   #交易條件
   CALL s_desc_get_acc_desc('238',g_pmdl_m.pmdl010) RETURNING g_pmdl_m.pmdl010_desc
   
   #稅別
   CALL s_desc_get_tax_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING g_pmdl_m.pmdl011_desc
   
   #發票類型
   CALL s_desc_get_invoice_type_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl033) RETURNING g_pmdl_m.pmdl033_desc
   
   #採購分類
   CALL s_desc_get_acc_desc('264',g_pmdl_m.pmdl024) RETURNING g_pmdl_m.pmdl024_desc
            
   DISPLAY BY NAME g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc,
                   g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl004_desc,
                   g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,
                   g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdlunit_desc,
                   g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025_desc,
                   g_pmdl_m.oofb017,g_pmdl_m.pmdl023_desc,
                   g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021_desc,
                   g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl009_desc,
                   g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,
                   g_pmdl_m.pmdl011_desc,g_pmdl_m.pmdl033_desc,
                   g_pmdl_m.pmdl024_desc
                   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlcrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlcrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlcrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlcrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlmodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlmodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdl_m.pmdlcnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmdl_m.pmdlcnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdl_m.pmdlcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pmdl_m_mask_o.* =  g_pmdl_m.*
   CALL apmt840_pmdl_t_mask()
   LET g_pmdl_m_mask_n.* =  g_pmdl_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001, 
       g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004,g_pmdl_m.pmdl004_desc, 
       g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003,g_pmdl_m.pmdl003_desc, 
       g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl201, 
       g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdl207,g_pmdl_m.pmdl207_desc, 
       g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025, 
       g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl023_desc, 
       g_pmdl_m.pmdl022,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl047, 
       g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015,g_pmdl_m.pmdl015_desc, 
       g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011,g_pmdl_m.pmdl011_desc, 
       g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl024,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl044, 
       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
       g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp, 
       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdp_desc, 
       g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
       g_pmdl_m.pmdlcnfid_desc,g_pmdl_m.pmdlcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdl_m.pmdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
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
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmdn_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pmdn2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_pmdn3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
       
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_pmdn6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
      
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt840_detail_show()
 
   #add-point:show段之後 name="show.after"
      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt840_detail_show()
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
 
{<section id="apmt840.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt840_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmdl_t.pmdldocno 
   DEFINE l_oldno     LIKE pmdl_t.pmdldocno 
 
   DEFINE l_master    RECORD LIKE pmdl_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmdn_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE pmdo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE pmdm_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
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
   
   IF g_pmdl_m.pmdldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
    
   LET g_pmdl_m.pmdldocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdl_m.pmdlownid = g_user
      LET g_pmdl_m.pmdlowndp = g_dept
      LET g_pmdl_m.pmdlcrtid = g_user
      LET g_pmdl_m.pmdlcrtdp = g_dept 
      LET g_pmdl_m.pmdlcrtdt = cl_get_current()
      LET g_pmdl_m.pmdlmodid = g_user
      LET g_pmdl_m.pmdlmoddt = cl_get_current()
      LET g_pmdl_m.pmdlstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #採購組織
   CALL s_aooi500_default(g_prog,'pmdlsite',g_pmdl_m.pmdlsite) RETURNING l_insert,g_pmdl_m.pmdlsite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_pmdl_m.pmdlsite) RETURNING g_pmdl_m.pmdlsite_desc
   DISPLAY BY NAME g_pmdl_m.pmdlsite_desc
   
   #採購日期
   LET g_pmdl_m.pmdldocdt = g_today
   
   #採購單別
   CALL s_arti200_get_def_doc_type(g_pmdl_m.pmdlsite,g_prog,'1')
      RETURNING l_success,l_doctype
   LET g_pmdl_m.pmdldocno = l_doctype
   DISPLAY BY NAME g_pmdl_m.pmdldocno
   
   #採購人員
   LET g_pmdl_m.pmdl002 = g_user
   CALL s_desc_get_person_desc(g_pmdl_m.pmdl002) RETURNING g_pmdl_m.pmdl002_desc
   DISPLAY BY NAME g_pmdl_m.pmdl002_desc
   
   #採購部門
   LET g_pmdl_m.pmdl003 = g_dept
   CALL s_desc_get_department_desc(g_pmdl_m.pmdl003) RETURNING g_pmdl_m.pmdl003_desc
   DISPLAY BY NAME g_pmdl_m.pmdl003_desc
   
   LET g_site_flag = FALSE
   LET g_pmdl_m_t.* = g_pmdl_m.*
   LET g_pmdl_m_o.* = g_pmdl_m.*  #舊值備份
   CALL apmt840_b_fill()  #
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdl_m.pmdlstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
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
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL apmt840_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmdl_m.* TO NULL
      INITIALIZE g_pmdn_d TO NULL
      INITIALIZE g_pmdn2_d TO NULL
      INITIALIZE g_pmdn3_d TO NULL
      INITIALIZE g_pmdn6_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt840_show()
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
   CALL apmt840_set_act_visible()   
   CALL apmt840_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdlent = " ||g_enterprise|| " AND",
                      " pmdldocno = '", g_pmdl_m.pmdldocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt840_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
   
   CALL apmt840_idx_chk()
   
   LET g_data_owner = g_pmdl_m.pmdlownid      
   LET g_data_dept  = g_pmdl_m.pmdlowndp
   
   #功能已完成,通報訊息中心
   CALL apmt840_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt840_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmdn_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE pmdo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE pmdm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   #160120-00001#5 160121 By pomelo add(S)
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE type_t.chr10
   DEFINE l_rtka010     LIKE rtka_t.rtka010
   DEFINE l_sql         STRING
   DEFINE l_pmdn        RECORD
          pmdnseq       LIKE pmdn_t.pmdnseq,    #項次
          pmdnsite      LIKE pmdn_t.pmdnsite,   #營運組織
          pmdnunit      LIKE pmdn_t.pmdnunit,   #收貨組織
          pmdnorga      LIKE pmdn_t.pmdnorga,   #帳款組織
          pmdn001       LIKE pmdn_t.pmdn001,    #商品編號
          pmdn002       LIKE pmdn_t.pmdn002,    #產品特徵
          pmdn006       LIKE pmdn_t.pmdn006,    #採購單位
          pmdn007       LIKE pmdn_t.pmdn007,    #採購數量
          pmdn010       LIKE pmdn_t.pmdn010,    #計價單位
          pmdn011       LIKE pmdn_t.pmdn011,    #計價數量
          pmdn012       LIKE pmdn_t.pmdn012,    #出貨日期
          pmdn013       LIKE pmdn_t.pmdn013,    #到廠日期
          pmdn014       LIKE pmdn_t.pmdn014,    #到庫日期
          pmdn015       LIKE pmdn_t.pmdn015,    #單價
          pmdn016       LIKE pmdn_t.pmdn016,    #稅別
          pmdn017       LIKE pmdn_t.pmdn017,    #稅率
          pmdn020       LIKE pmdn_t.pmdn020,    #緊急度
          pmdn023       LIKE pmdn_t.pmdn023,    #代送商
          pmdn024       LIKE pmdn_t.pmdn024,    #多交期
          pmdn025       LIKE pmdn_t.pmdn025,    #收貨地址
          pmdn043       LIKE pmdn_t.pmdn043,    #取出價格
          pmdn046       LIKE pmdn_t.pmdn046,    #未稅金額
          pmdn047       LIKE pmdn_t.pmdn047,    #含稅金額
          pmdn048       LIKE pmdn_t.pmdn048,    #稅額
          pmdn201       LIKE pmdn_t.pmdn201,    #包裝單位
          pmdn202       LIKE pmdn_t.pmdn202,    #包裝數量
          pmdn203       LIKE pmdn_t.pmdn203,    #收貨部門
          pmdn205       LIKE pmdn_t.pmdn205,    #要貨組織
          pmdn206       LIKE pmdn_t.pmdn206,    #可用庫存量
          pmdn207       LIKE pmdn_t.pmdn207,    #採購在途量
          pmdn208       LIKE pmdn_t.pmdn208,    #前日銷量
          pmdn209       LIKE pmdn_t.pmdn209,    #上月銷量
          pmdn210       LIKE pmdn_t.pmdn210,    #第一週銷量
          pmdn211       LIKE pmdn_t.pmdn211,    #第二週銷量
          pmdn212       LIKE pmdn_t.pmdn212,    #第三週銷量
          pmdn213       LIKE pmdn_t.pmdn213,    #第四週銷量
          pmdn214       LIKE pmdn_t.pmdn214,    #採購渠道
          pmdn215       LIKE pmdn_t.pmdn215,    #渠道性質
          pmdn216       LIKE pmdn_t.pmdn216,    #經營方式
          pmdn217       LIKE pmdn_t.pmdn217,    #結算方式
          pmdn218       LIKE pmdn_t.pmdn218,    #合約編號
          pmdn219       LIKE pmdn_t.pmdn219,    #協議編號
          pmdn220       LIKE pmdn_t.pmdn220,    #採購人員
          pmdn221       LIKE pmdn_t.pmdn221,    #採購部門
          pmdn222       LIKE pmdn_t.pmdn222,    #採購中心
          pmdn225       LIKE pmdn_t.pmdn225     #最終收貨組織
                        END RECORD
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   #160120-00001#5 160121 By pomelo add(S)
   IF g_pmdl_m.pmdl203 MATCHES '[13]' THEN
      #採購方式不屬於0.自訂貨時，不可以對單身進行複製動作，只可使用自動產生單身功能！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apm-01072"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt840_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdn_t
    WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdldocno_t
 
    INTO TEMP apmt840_detail
 
   #將key修正為調整後   
   UPDATE apmt840_detail 
      #更新key欄位
      SET pmdndocno = g_pmdl_m.pmdldocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #160120-00001#5 160121 By pomelo add(S)
   CALL cl_err_collect_init()
   LET l_sql = "SELECT pmdnseq, pmdnsite, pmdnunit, pmdn001,",
               "       pmdn002, pmdn007,  pmdn023,  pmdn025,",
               "       pmdn201, pmdn203,  pmdn205,  pmdn214,",
               "       pmdn215, pmdn222",
               "  FROM apmt840_detail"
   PREPARE apmt840_detail_reproduce_pre FROM l_sql
   DECLARE apmt840_detail_reproduce_cs CURSOR FOR apmt840_detail_reproduce_pre
   
   LET l_sql = "DELETE FROM apmt840_detail",
               " WHERE pmdnseq = ?"
   PREPARE apmt840_detail_reproduce_del FROM l_sql
   
   LET l_sql = "UPDATE apmt840_detail",
               "   SET pmdnunit = ?, pmdnorga = ?,",
               "       pmdn006 = ?,  pmdn010 = ?,",
               "       pmdn011 = ?,  pmdn012 = ?,",
               "       pmdn013 = ?,  pmdn014 = ?,",
               "       pmdn015 = ?,  pmdn016 = ?,",
               "       pmdn017 = ?,  pmdn020 = ?,",
               "       pmdn023 = ?,  pmdn024 = ?,",
               "       pmdn025 = ?,  pmdn043 = ?,",
               "       pmdn046 = ?,  pmdn047 = ?,",
               "       pmdn048 = ?,  pmdn202 = ?,",
               "       pmdn203 = ?,  pmdn206 = ?,",
               "       pmdn207 = ?,  pmdn208 = ?,",
               "       pmdn209 = ?,  pmdn210 = ?,",
               "       pmdn211 = ?,  pmdn212 = ?,",
               "       pmdn213 = ?,  pmdn214 = ?,",
               "       pmdn215 = ?,  pmdn216 = ?,",
               "       pmdn217 = ?,  pmdn218 = ?,",
               "       pmdn219 = ?,  pmdn220 = ?,",
               "       pmdn221 = ?,  pmdn225 = ?",
               " WHERE pmdnseq = ?"
   PREPARE apmt840_detail_reproduce_upd FROM l_sql
   
   FOREACH apmt840_detail_reproduce_cs
      INTO l_pmdn.pmdnseq, l_pmdn.pmdnsite, l_pmdn.pmdnunit, l_pmdn.pmdn001,
           l_pmdn.pmdn002, l_pmdn.pmdn007,  l_pmdn.pmdn023,  l_pmdn.pmdn025,
           l_pmdn.pmdn201, l_pmdn.pmdn203,  l_pmdn.pmdn205,  l_pmdn.pmdn214,
           l_pmdn.pmdn215,  l_pmdn.pmdn222
      
      CALL s_apmt840_chk_pact_curr(l_pmdn.pmdn222, g_pmdl_m.pmdl004, g_pmdl_m.pmdldocdt,
                                   l_pmdn.pmdn001, g_pmdl_m.pmdl015, l_pmdn.pmdnsite)
         RETURNING l_success,l_errno
      IF l_success = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Seq = ",l_pmdn.pmdnseq
         LET g_errparam.code   = l_errno
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXECUTE apmt840_detail_reproduce_del USING l_pmdn.pmdnseq
         CONTINUE FOREACH
      END IF
      
      #取協議資訊
      CALL s_apmt840_get_pact(l_pmdn.pmdn222,     g_pmdl_m.pmdl015, g_pmdl_m.pmdl004,
                              g_pmdl_m.pmdldocdt, l_pmdn.pmdn001,   l_pmdn.pmdnsite)
         RETURNING l_pmdn.pmdnorga, l_pmdn.pmdn006, l_pmdn.pmdn010,  l_pmdn.pmdn043,
                   l_pmdn.pmdn016,  l_pmdn.pmdn017, l_pmdn.pmdn216,  l_pmdn.pmdn217,
                   l_pmdn.pmdn218,  l_pmdn.pmdn219, l_pmdn.pmdn220,  l_pmdn.pmdn221
      
      #最終收貨組織
      IF cl_null(l_pmdn.pmdn225) THEN
         LET l_pmdn.pmdn225 = l_pmdn.pmdnunit
      END IF
      
      #收貨組織
      IF NOT cl_null(g_pmdl_m.pmdlunit) THEN
         LET l_pmdn.pmdnunit = g_pmdl_m.pmdlunit
         LET l_pmdn.pmdn225 = g_pmdl_m.pmdlunit
      END IF
      
      #收貨部門
      IF NOT cl_null(g_pmdl_m.pmdl029) THEN
         LET l_pmdn.pmdn203 = g_pmdl_m.pmdl029
      END IF
      
      #收貨地址
      IF NOT cl_null(g_pmdl_m.pmdl025) THEN
         LET l_pmdn.pmdn025 = g_pmdl_m.pmdl025
      END IF
      
      #代送商
      IF NOT cl_null(g_pmdl_m.pmdl022) THEN
         LET l_pmdn.pmdn023 = g_pmdl_m.pmdl022
      END IF
      
      #採購渠道
      IF NOT cl_null(g_pmdl_m.pmdl023) THEN
         LET l_pmdn.pmdn214 = g_pmdl_m.pmdl023
         LET l_pmdn.pmdn215 = s_apmt840_get_oojd004(l_pmdn.pmdn214)
      END IF
      
      #由採購數量轉換成包裝數量
      CALL s_aooi250_convert_qty(l_pmdn.pmdn001, l_pmdn.pmdn006, l_pmdn.pmdn201, l_pmdn.pmdn007)
         RETURNING l_success, l_pmdn.pmdn202
      IF l_success = FALSE THEN           
         EXECUTE apmt840_detail_reproduce_del USING l_pmdn.pmdnseq
         CONTINUE FOREACH
      END IF
      
      #由採購數量轉換成計價數量
      CALL s_aooi250_convert_qty(l_pmdn.pmdn001, l_pmdn.pmdn006, l_pmdn.pmdn010, l_pmdn.pmdn007)
         RETURNING l_success, l_pmdn.pmdn011
      IF l_success = FALSE THEN           
         EXECUTE apmt840_detail_reproduce_del USING l_pmdn.pmdnseq
         CONTINUE FOREACH
      END IF
      
      #單價 = 取出價格
      LET l_pmdn.pmdn015 = l_pmdn.pmdn043
      
      #取得未稅金額、稅額、含稅金額
      CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno, l_pmdn.pmdnseq, g_pmdl_m.pmdlsite,
                                g_pmdl_m.pmdl015,   l_pmdn.pmdn007, l_pmdn.pmdn015, 
                                l_pmdn.pmdn016)
         RETURNING l_pmdn.pmdn046, l_pmdn.pmdn048, l_pmdn.pmdn047
         
      #可用庫存量 跟 採購在途量
      CALL apmt840_get_sum(l_pmdn.pmdnunit, l_pmdn.pmdn001, l_pmdn.pmdn002)
         RETURNING l_pmdn.pmdn206, l_pmdn.pmdn207
      
      #計算單身日結/月結 銷量欄位
      CALL apmt840_get_sale(l_pmdn.pmdn205, l_pmdn.pmdn001, l_pmdn.pmdn002)
         RETURNING l_pmdn.pmdn208, l_pmdn.pmdn209, l_pmdn.pmdn210,
                   l_pmdn.pmdn211, l_pmdn.pmdn212, l_pmdn.pmdn213
                   
      LET l_pmdn.pmdn024 = 'N'
      
      CALL s_apmt840_get_date('1',g_pmdl_m.pmdldocdt,l_pmdn.pmdnunit,g_pmdl_m.pmdl004)
         RETURNING l_pmdn.pmdn014,l_rtka010
      
      #到廠日期，交貨日期 = 到庫日期
      LET l_pmdn.pmdn012 = l_pmdn.pmdn014
      LET l_pmdn.pmdn013 = l_pmdn.pmdn014
      
      IF l_pmdn.pmdn014 < g_today THEN
         LET l_pmdn.pmdn020 = '2'
      ELSE
         LET l_pmdn.pmdn020 = '1'
      END IF
      
      #更新單身資料
      EXECUTE apmt840_detail_reproduce_upd
        USING l_pmdn.pmdnunit, l_pmdn.pmdnorga, l_pmdn.pmdn006,  l_pmdn.pmdn010,
              l_pmdn.pmdn011,  l_pmdn.pmdn012,  l_pmdn.pmdn013,  l_pmdn.pmdn014,
              l_pmdn.pmdn015,  l_pmdn.pmdn016,  l_pmdn.pmdn017,  l_pmdn.pmdn020,
              l_pmdn.pmdn023,  l_pmdn.pmdn024,  l_pmdn.pmdn025,  l_pmdn.pmdn043,
              l_pmdn.pmdn046,  l_pmdn.pmdn047,  l_pmdn.pmdn048,  l_pmdn.pmdn202,
              l_pmdn.pmdn203,  l_pmdn.pmdn206,  l_pmdn.pmdn207,  l_pmdn.pmdn208,
              l_pmdn.pmdn209,  l_pmdn.pmdn210,  l_pmdn.pmdn211,  l_pmdn.pmdn212,
              l_pmdn.pmdn213,  l_pmdn.pmdn214,  l_pmdn.pmdn215,  l_pmdn.pmdn216,
              l_pmdn.pmdn217,  l_pmdn.pmdn218,  l_pmdn.pmdn219,  l_pmdn.pmdn220,
              l_pmdn.pmdn221,  l_pmdn.pmdn225,  l_pmdn.pmdnseq
   END FOREACH
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmdn_t SELECT * FROM apmt840_detail
   
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
   DROP TABLE apmt840_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcd_t 
    WHERE xrcdent = g_enterprise AND xrcddocno = g_pmdldocno_t
 
    INTO TEMP apmt840_detail
 
   #將key修正為調整後   
   UPDATE apmt840_detail SET xrcddocno = g_pmdl_m.pmdldocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   DELETE FROM apmt840_detail     #160120-00001#5 160121 By pomelo add
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrcd_t SELECT * FROM apmt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   #150519-00027#1 150520 By pomelo mark(S)
   #UPDATE pmdo_t
   #   SET pmdo015 = 0,
   #       pmdo016 = 0,
   #       pmdo017 = 0,
   #       pmdo019 = 0,
   #       pmdo020 = 0,
   #       pmdo021 = '2',
   #       pmdo026 = '',
   #       pmdo027 = ''
   # WHERE pmdoent = g_enterprise
   #   AND pmdodocno = g_pmdl_m.pmdldocno
   #150519-00027#1 150520 By pomelo mark(E)
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdo_t 
    WHERE pmdoent = g_enterprise AND pmdodocno = g_pmdldocno_t
 
    INTO TEMP apmt840_detail
 
   #將key修正為調整後   
   UPDATE apmt840_detail SET pmdodocno = g_pmdl_m.pmdldocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   #160120-00001#5 160121 By pomelo add(S)
   DELETE FROM apmt840_detail
   LET l_sql = "SELECT pmdnseq",
               "  FROM pmdn_t",
               " WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",g_pmdl_m.pmdldocno,"'"
   PREPARE apmt840_detail_reproduce_pre1 FROM l_sql
   DECLARE apmt840_detail_reproduce_cs1 CURSOR FOR apmt840_detail_reproduce_pre1
   
   LET l_success = TRUE
   FOREACH apmt840_detail_reproduce_cs1 INTO l_pmdn.pmdnseq
      IF NOT s_apmt840_gen_pmdo(g_pmdl_m.pmdldocno, l_pmdn.pmdnseq) THEN
         LET l_success = FALSE
      END IF
   END FOREACH
   
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()
   END IF
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO pmdo_t SELECT * FROM apmt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdm_t 
    WHERE pmdment = g_enterprise AND pmdmdocno = g_pmdldocno_t
 
    INTO TEMP apmt840_detail
 
   #將key修正為調整後   
   UPDATE apmt840_detail SET pmdmdocno = g_pmdl_m.pmdldocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO pmdm_t SELECT * FROM apmt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   #150519-00027#1 150520 By pomelo add(S)
   UPDATE pmdo_t
      SET pmdo015 = 0,
          pmdo016 = 0,
          pmdo017 = 0,
          pmdo019 = 0,
          pmdo020 = 0,
          pmdo021 = '2',
          pmdo026 = '',
          pmdo027 = '',
          pmdo040 = 0
    WHERE pmdoent = g_enterprise
      AND pmdodocno = g_pmdl_m.pmdldocno
   #150519-00027#1 150520 By pomelo add(E)
   #150519-00027#1 150520 By pomelo mark(S)
   #DROP TABLE apmt840_detail
   ##CREATE TEMP TABLE
   #LET ls_sql = 
   #   "CREATE GLOBAL TEMPORARY TABLE apmt840_detail AS ",
   #   "SELECT * FROM pmdq_t "
   #PREPARE repro_tbl5 FROM ls_sql
   #EXECUTE repro_tbl5
   #FREE repro_tbl5
   #   
   ##將符合條件的資料丟入TEMP TABLE
   #INSERT INTO apmt840_detail SELECT * FROM pmdq_t
   #                                      WHERE pmdqent = g_enterprise AND pmdqdocno = g_pmdldocno_t
   #
   ##將key修正為調整後   
   #UPDATE apmt840_detail SET pmdqdocno = g_pmdl_m.pmdldocno
   ##將資料塞回原table   
   #INSERT INTO pmdq_t SELECT * FROM apmt840_detail   
   #150519-00027#1 150520 By pomelo mark(E)
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   CALL cl_err_collect_show()      #160120-00001#5 160121 By pomelo add
   CALL apmt840_b_fill()   #160324-00009#1 20160328 add by beckxie
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt840_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt           LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pmdl_m.pmdldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt840_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt840_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdl_m_mask_o.* =  g_pmdl_m.*
   CALL apmt840_pmdl_t_mask()
   LET g_pmdl_m_mask_n.* =  g_pmdl_m.*
   
   CALL apmt840_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt840_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmdldocno_t = g_pmdl_m.pmdldocno
 
 
      DELETE FROM pmdl_t
       WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdl_m.pmdldocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
            
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmdl_m.pmdldocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_pmdl_m.pmdldocno,g_pmdl_m.pmdldocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pmdn_t
       WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdl_m.pmdldocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
            
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
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
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcddocno = g_pmdl_m.pmdldocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
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
      DELETE FROM pmdo_t
       WHERE pmdoent = g_enterprise AND
             pmdodocno = g_pmdl_m.pmdldocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
            
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
            
      #end add-point
      DELETE FROM pmdm_t
       WHERE pmdment = g_enterprise AND
             pmdmdocno = g_pmdl_m.pmdldocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      #交易稅明細檔
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = g_pmdl_m.pmdldocno
      IF l_cnt >= 1 THEN
         DELETE FROM xrcd_t
          WHERE xrcdent = g_enterprise
            AND xrcddocno = g_pmdl_m.pmdldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del xrcd_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      #採購交期明細檔
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdodocno = g_pmdl_m.pmdldocno
      IF l_cnt >= 1 THEN
         DELETE FROM pmdo_t
          WHERE pmdoent = g_enterprise
            AND pmdodocno = g_pmdl_m.pmdldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del pmdo_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      #採購多交期匯總檔
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmdq_t
       WHERE pmdqent = g_enterprise
         AND pmdqdocno = g_pmdl_m.pmdldocno
      IF l_cnt >= 1 THEN
         DELETE FROM pmdq_t
          WHERE pmdqent = g_enterprise
            AND pmdqdocno = g_pmdl_m.pmdldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del pmdq_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      #採購關聯單據明細檔
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmdp_t
       WHERE pmdpent = g_enterprise
         AND pmdpdocno = g_pmdl_m.pmdldocno
      IF l_cnt >= 1 THEN
         DELETE FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpdocno = g_pmdl_m.pmdldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del pmdp_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      #一次性交易對象
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_pmdl_m.pmdl028
      IF l_cnt >= 1 THEN
         DELETE FROM pmak_t
          WHERE pmakent = g_enterprise
            AND pmak001 = g_pmdl_m.pmdl028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Del pmak_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      
      #備註
      IF NOT s_aooi360_del('6',g_prog,g_pmdl_m.pmdldocno,'','','','','','','','','4') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmdl_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt840_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmdn_d.clear() 
      CALL g_pmdn2_d.clear()       
      CALL g_pmdn3_d.clear()       
      CALL g_pmdn6_d.clear()       
 
     
      CALL apmt840_ui_browser_refresh()  
      #CALL apmt840_ui_headershow()  
      #CALL apmt840_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt840_browser_fill("")
         CALL apmt840_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt840_cl
 
   #功能已完成,通報訊息中心
   CALL apmt840_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt840.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt840_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_acc         LIKE gzcb_t.gzcb004
   DEFINE l_sql         STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmdn_d.clear()
   CALL g_pmdn2_d.clear()
   CALL g_pmdn3_d.clear()
   CALL g_pmdn6_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #交易稅頁籤
   LET l_sql = "SELECT pmdn200,pmdn001,pmdn002,imaal003,imaal004",
               "  FROM pmdn_t",
               "  LEFT OUTER JOIN imaal_t ON imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"'",
               " WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",g_pmdl_m.pmdldocno,"'",
               "   AND pmdnseq = ?"
   PREPARE apmt840_pre1 FROM l_sql
   
   #交期頁籤
   LET l_sql = "SELECT pmdn014",
               "  FROM pmdn_t",
               " WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",g_pmdl_m.pmdldocno,"'",
               "   AND pmdnseq = ?"
   PREPARE apmt840_pre2 FROM l_sql
   #end add-point
   
   #判斷是否填充
   IF apmt840_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdnseq,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016,pmdn017, 
             pmdn227,pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011,pmdn015, 
             pmdn043,pmdn046,pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn028,pmdn029,pmdn030, 
             pmdn053,pmdnorga,pmdn026,pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023,pmdn045,pmdn206, 
             pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020,pmdn224,pmdn052, 
             pmdn049,pmdn051,pmdn205,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218,pmdn219,pmdn220,pmdn221, 
             pmdn222,pmdn223,pmdn050 ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t4.rtaxl003 ,t5.oocal003 , 
             t6.oocal003 ,t7.oocal003 ,t8.oocal003 ,t9.ooefl003 ,t10.ooefl003 ,t11.ooefl003 ,t12.inayl003 , 
             t13.ooefl003 ,t14.pmaal004 ,t15.ooefl003 ,t16.oojdl003 ,t17.staal003 ,t18.ooag011 ,t19.ooefl003 FROM pmdn_t", 
                
                     " INNER JOIN pmdl_t ON pmdlent = " ||g_enterprise|| " AND pmdldocno = pmdndocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pmdnsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdn001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=pmdn001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=pmdn228 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=pmdn201 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=pmdn006 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=pmdn008 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=pmdn010 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=pmdnunit AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=pmdn225 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=pmdn203 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t12 ON t12.inaylent="||g_enterprise||" AND t12.inayl001=pmdn028 AND t12.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=pmdnorga AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=pmdn023 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=pmdn205 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t16 ON t16.oojdlent="||g_enterprise||" AND t16.oojdl001=pmdn214 AND t16.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t17 ON t17.staalent="||g_enterprise||" AND t17.staal001=pmdn217 AND t17.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=pmdn220  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=pmdn221 AND t19.ooefl002='"||g_dlang||"' ",
 
                     " WHERE pmdnent=? AND pmdndocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdn_t.pmdnseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt840_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt840_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmdl_m.pmdldocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmdl_m.pmdldocno INTO g_pmdn_d[l_ac].pmdnseq,g_pmdn_d[l_ac].pmdnsite, 
          g_pmdn_d[l_ac].pmdn200,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn228,g_pmdn_d[l_ac].pmdn002, 
          g_pmdn_d[l_ac].pmdn016,g_pmdn_d[l_ac].pmdn017,g_pmdn_d[l_ac].pmdn227,g_pmdn_d[l_ac].pmdn201, 
          g_pmdn_d[l_ac].pmdn202,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007,g_pmdn_d[l_ac].pmdn226, 
          g_pmdn_d[l_ac].pmdn008,g_pmdn_d[l_ac].pmdn009,g_pmdn_d[l_ac].pmdn010,g_pmdn_d[l_ac].pmdn011, 
          g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn043,g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048, 
          g_pmdn_d[l_ac].pmdn047,g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn225,g_pmdn_d[l_ac].pmdn203, 
          g_pmdn_d[l_ac].pmdn025,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029,g_pmdn_d[l_ac].pmdn030, 
          g_pmdn_d[l_ac].pmdn053,g_pmdn_d[l_ac].pmdnorga,g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdn024, 
          g_pmdn_d[l_ac].pmdn014,g_pmdn_d[l_ac].pmdn012,g_pmdn_d[l_ac].pmdn013,g_pmdn_d[l_ac].pmdn022, 
          g_pmdn_d[l_ac].pmdn023,g_pmdn_d[l_ac].pmdn045,g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207, 
          g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211, 
          g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213,g_pmdn_d[l_ac].pmdn019,g_pmdn_d[l_ac].pmdn020, 
          g_pmdn_d[l_ac].pmdn224,g_pmdn_d[l_ac].pmdn052,g_pmdn_d[l_ac].pmdn049,g_pmdn_d[l_ac].pmdn051, 
          g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn214,g_pmdn_d[l_ac].pmdn215,g_pmdn_d[l_ac].pmdn216, 
          g_pmdn_d[l_ac].pmdn217,g_pmdn_d[l_ac].pmdn218,g_pmdn_d[l_ac].pmdn219,g_pmdn_d[l_ac].pmdn220, 
          g_pmdn_d[l_ac].pmdn221,g_pmdn_d[l_ac].pmdn222,g_pmdn_d[l_ac].pmdn223,g_pmdn_d[l_ac].pmdn050, 
          g_pmdn_d[l_ac].pmdnsite_desc,g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_desc, 
          g_pmdn_d[l_ac].pmdn228_desc,g_pmdn_d[l_ac].pmdn201_desc,g_pmdn_d[l_ac].pmdn006_desc,g_pmdn_d[l_ac].pmdn008_desc, 
          g_pmdn_d[l_ac].pmdn010_desc,g_pmdn_d[l_ac].pmdnunit_desc,g_pmdn_d[l_ac].pmdn225_desc,g_pmdn_d[l_ac].pmdn203_desc, 
          g_pmdn_d[l_ac].pmdn028_desc,g_pmdn_d[l_ac].pmdnorga_desc,g_pmdn_d[l_ac].pmdn023_desc,g_pmdn_d[l_ac].pmdn205_desc, 
          g_pmdn_d[l_ac].pmdn214_desc,g_pmdn_d[l_ac].pmdn217_desc,g_pmdn_d[l_ac].pmdn220_desc,g_pmdn_d[l_ac].pmdn221_desc  
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
         #產品特徵說明
         CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002) RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
         
         #稅別
         CALL s_desc_get_tax_desc1(g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn016) RETURNING g_pmdn_d[l_ac].pmdn016_desc
         
         #出貨地址
         IF g_pmdl_m.pmdl203 = '3' THEN
            LET l_ooef001 = g_pmdn_d[l_ac].pmdn223
         ELSE
            LET l_ooef001 = g_pmdn_d[l_ac].pmdnunit
         END IF
         CALL s_apmt840_address_ref('3',g_pmdn_d[l_ac].pmdn025,l_ooef001)
            RETURNING g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
         
         #帳款地址
         CALL s_apmt840_address_ref('5',g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdnorga)
            RETURNING g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
            
         #出貨儲位
         CALL s_desc_get_locator_desc(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn028,g_pmdn_d[l_ac].pmdn029)
            RETURNING g_pmdn_d[l_ac].pmdn029_desc
            
         #理由碼
         LET l_acc = ''
         CALL apmt840_get_gzcb004() RETURNING l_acc
         CALL s_desc_get_acc_desc(l_acc,g_pmdn_d[l_ac].pmdn049) RETURNING g_pmdn_d[l_ac].pmdn049_desc
            
         #結案理由碼
         CALL s_desc_get_acc_desc(l_acc,g_pmdn_d[l_ac].pmdn051) RETURNING g_pmdn_d[l_ac].pmdn051_desc
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
   IF apmt840_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrcdsite,xrcdld,xrcdseq,xrcd007,xrcd002,xrcdseq2,xrcd003,xrcd006, 
             xrcd004,xrcd104  FROM xrcd_t",   
                     " INNER JOIN  pmdl_t ON pmdlent = " ||g_enterprise|| " AND pmdldocno = xrcddocno ",
 
                     "",
                     
                     
                     " WHERE xrcdent=? AND xrcddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
         
         #add-point:單身填充控制 name="b_fill.sql2"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt840_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR apmt840_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_pmdl_m.pmdldocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_pmdl_m.pmdldocno INTO g_pmdn2_d[l_ac].xrcdsite,g_pmdn2_d[l_ac].xrcdld, 
          g_pmdn2_d[l_ac].xrcdseq,g_pmdn2_d[l_ac].xrcd007,g_pmdn2_d[l_ac].xrcd002,g_pmdn2_d[l_ac].xrcdseq2, 
          g_pmdn2_d[l_ac].xrcd003,g_pmdn2_d[l_ac].xrcd006,g_pmdn2_d[l_ac].xrcd004,g_pmdn2_d[l_ac].xrcd104  
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
         #採購明細資料
         EXECUTE apmt840_pre1 USING g_pmdn2_d[l_ac].xrcdseq
            INTO g_pmdn2_d[l_ac].pmdn2001,g_pmdn2_d[l_ac].pmdn0011,g_pmdn2_d[l_ac].pmdn0021,
                 g_pmdn2_d[l_ac].pmdn0011_desc,g_pmdn2_d[l_ac].pmdn0011_desc_desc
                  
         #產品特徵說明
         CALL s_feature_description(g_pmdn2_d[l_ac].pmdn0011,g_pmdn2_d[l_ac].pmdn0021)
            RETURNING l_success,g_pmdn2_d[l_ac].pmdn0021_desc
         
         #稅別
         CALL s_desc_get_tax_desc1(g_pmdn2_d[l_ac].xrcdsite,g_pmdn2_d[l_ac].xrcd002)
            RETURNING g_pmdn2_d[l_ac].xrcd002_desc
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
 
   #判斷是否填充
   IF apmt840_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdosite,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,pmdo002,pmdo005, 
             pmdo200,pmdo201,pmdo004,pmdo006,pmdo028,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010,pmdo009, 
             pmdo015,pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,pmdo031,pmdo022,pmdo023,pmdo024, 
             pmdo032,pmdo033,pmdo034,pmdo025,pmdo026,pmdo027 ,t22.imaal003 ,t23.imaal004 ,t24.oocal003 , 
             t25.oocal003 ,t26.oocal003 ,t27.oocql004 ,t28.oocal003 ,t29.ooag011 FROM pmdo_t",   
                     " INNER JOIN  pmdl_t ON pmdlent = " ||g_enterprise|| " AND pmdldocno = pmdodocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t22 ON t22.imaalent="||g_enterprise||" AND t22.imaal001=pmdo001 AND t22.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t23 ON t23.imaalent="||g_enterprise||" AND t23.imaal001=pmdo001 AND t23.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t24 ON t24.oocalent="||g_enterprise||" AND t24.oocal001=pmdo200 AND t24.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t25 ON t25.oocalent="||g_enterprise||" AND t25.oocal001=pmdo004 AND t25.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t26 ON t26.oocalent="||g_enterprise||" AND t26.oocal001=pmdo028 AND t26.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t27 ON t27.oocqlent="||g_enterprise||" AND t27.oocql001='274' AND t27.oocql002=pmdo010 AND t27.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t28 ON t28.oocalent="||g_enterprise||" AND t28.oocal001=pmdo030 AND t28.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t29 ON t29.ooagent="||g_enterprise||" AND t29.ooag001=pmdo026  ",
 
                     " WHERE pmdoent=? AND pmdodocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdo_t.pmdoseq,pmdo_t.pmdoseq1,pmdo_t.pmdoseq2"
         
         #add-point:單身填充控制 name="b_fill.sql3"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt840_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR apmt840_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_pmdl_m.pmdldocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_pmdl_m.pmdldocno INTO g_pmdn3_d[l_ac].pmdosite,g_pmdn3_d[l_ac].pmdoseq, 
          g_pmdn3_d[l_ac].pmdoseq1,g_pmdn3_d[l_ac].pmdoseq2,g_pmdn3_d[l_ac].pmdo003,g_pmdn3_d[l_ac].pmdo001, 
          g_pmdn3_d[l_ac].pmdo002,g_pmdn3_d[l_ac].pmdo005,g_pmdn3_d[l_ac].pmdo200,g_pmdn3_d[l_ac].pmdo201, 
          g_pmdn3_d[l_ac].pmdo004,g_pmdn3_d[l_ac].pmdo006,g_pmdn3_d[l_ac].pmdo028,g_pmdn3_d[l_ac].pmdo029, 
          g_pmdn3_d[l_ac].pmdo013,g_pmdn3_d[l_ac].pmdo011,g_pmdn3_d[l_ac].pmdo012,g_pmdn3_d[l_ac].pmdo010, 
          g_pmdn3_d[l_ac].pmdo009,g_pmdn3_d[l_ac].pmdo015,g_pmdn3_d[l_ac].pmdo016,g_pmdn3_d[l_ac].pmdo017, 
          g_pmdn3_d[l_ac].pmdo040,g_pmdn3_d[l_ac].pmdo019,g_pmdn3_d[l_ac].pmdo021,g_pmdn3_d[l_ac].pmdo030, 
          g_pmdn3_d[l_ac].pmdo031,g_pmdn3_d[l_ac].pmdo022,g_pmdn3_d[l_ac].pmdo023,g_pmdn3_d[l_ac].pmdo024, 
          g_pmdn3_d[l_ac].pmdo032,g_pmdn3_d[l_ac].pmdo033,g_pmdn3_d[l_ac].pmdo034,g_pmdn3_d[l_ac].pmdo025, 
          g_pmdn3_d[l_ac].pmdo026,g_pmdn3_d[l_ac].pmdo027,g_pmdn3_d[l_ac].pmdo001_desc,g_pmdn3_d[l_ac].pmdo001_desc_desc, 
          g_pmdn3_d[l_ac].pmdo200_desc,g_pmdn3_d[l_ac].pmdo004_desc,g_pmdn3_d[l_ac].pmdo028_desc,g_pmdn3_d[l_ac].pmdo010_desc, 
          g_pmdn3_d[l_ac].pmdo030_desc,g_pmdn3_d[l_ac].pmdo026_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         #採購明細資料
         EXECUTE apmt840_pre2 USING g_pmdn3_d[l_ac].pmdoseq
            INTO g_pmdn3_d[l_ac].pmdn0141
         
         #稅別
         CALL s_desc_get_tax_desc1(g_pmdn3_d[l_ac].pmdosite,g_pmdn3_d[l_ac].pmdo023)
            RETURNING g_pmdn3_d[l_ac].pmdo023_desc
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
 
   #判斷是否填充
   IF apmt840_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdmsite,pmdm001,pmdm014,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006, 
             pmdm007,pmdm008,pmdm009 ,t30.ooibl004 FROM pmdm_t",   
                     " INNER JOIN  pmdl_t ON pmdlent = " ||g_enterprise|| " AND pmdldocno = pmdmdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooibl_t t30 ON t30.ooiblent="||g_enterprise||" AND t30.ooibl002=pmdm002 AND t30.ooibl003='"||g_dlang||"' ",
 
                     " WHERE pmdment=? AND pmdmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdm_t.pmdm001"
         
         #add-point:單身填充控制 name="b_fill.sql4"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt840_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR apmt840_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_pmdl_m.pmdldocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_pmdl_m.pmdldocno INTO g_pmdn6_d[l_ac].pmdmsite,g_pmdn6_d[l_ac].pmdm001, 
          g_pmdn6_d[l_ac].pmdm014,g_pmdn6_d[l_ac].pmdm002,g_pmdn6_d[l_ac].pmdm003,g_pmdn6_d[l_ac].pmdm004, 
          g_pmdn6_d[l_ac].pmdm005,g_pmdn6_d[l_ac].pmdm006,g_pmdn6_d[l_ac].pmdm007,g_pmdn6_d[l_ac].pmdm008, 
          g_pmdn6_d[l_ac].pmdm009,g_pmdn6_d[l_ac].pmdm002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         #CALL apmt840_pmdl009_ref(g_pmdn6_d[l_ac].pmdm002) RETURNING g_pmdn6_d[l_ac].pmdm002_desc
         #DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc
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
   
   CALL g_pmdn_d.deleteElement(g_pmdn_d.getLength())
   CALL g_pmdn2_d.deleteElement(g_pmdn2_d.getLength())
   CALL g_pmdn3_d.deleteElement(g_pmdn3_d.getLength())
   CALL g_pmdn6_d.deleteElement(g_pmdn6_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt840_pb
   FREE apmt840_pb2
 
   FREE apmt840_pb3
 
   FREE apmt840_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdn_d.getLength()
      LET g_pmdn_d_mask_o[l_ac].* =  g_pmdn_d[l_ac].*
      CALL apmt840_pmdn_t_mask()
      LET g_pmdn_d_mask_n[l_ac].* =  g_pmdn_d[l_ac].*
   END FOR
   
   LET g_pmdn2_d_mask_o.* =  g_pmdn2_d.*
   FOR l_ac = 1 TO g_pmdn2_d.getLength()
      LET g_pmdn2_d_mask_o[l_ac].* =  g_pmdn2_d[l_ac].*
      CALL apmt840_xrcd_t_mask()
      LET g_pmdn2_d_mask_n[l_ac].* =  g_pmdn2_d[l_ac].*
   END FOR
   LET g_pmdn3_d_mask_o.* =  g_pmdn3_d.*
   FOR l_ac = 1 TO g_pmdn3_d.getLength()
      LET g_pmdn3_d_mask_o[l_ac].* =  g_pmdn3_d[l_ac].*
      CALL apmt840_pmdo_t_mask()
      LET g_pmdn3_d_mask_n[l_ac].* =  g_pmdn3_d[l_ac].*
   END FOR
   LET g_pmdn6_d_mask_o.* =  g_pmdn6_d.*
   FOR l_ac = 1 TO g_pmdn6_d.getLength()
      LET g_pmdn6_d_mask_o[l_ac].* =  g_pmdn6_d[l_ac].*
      CALL apmt840_pmdm_t_mask()
      LET g_pmdn6_d_mask_n[l_ac].* =  g_pmdn6_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt840_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmdn_t
       WHERE pmdnent = g_enterprise AND
         pmdndocno = ps_keys_bak[1] AND pmdnseq = ps_keys_bak[2]
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
         CALL g_pmdn_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
            
      #end add-point    
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_pmdn2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
            
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
            
      #end add-point    
      DELETE FROM pmdo_t
       WHERE pmdoent = g_enterprise AND
             pmdodocno = ps_keys_bak[1] AND pmdoseq = ps_keys_bak[2] AND pmdoseq1 = ps_keys_bak[3] AND pmdoseq2 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_pmdn3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
            
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
            
      #end add-point    
      DELETE FROM pmdm_t
       WHERE pmdment = g_enterprise AND
             pmdmdocno = ps_keys_bak[1] AND pmdm001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_pmdn6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
            
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt840_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmdn_t
                  (pmdnent,
                   pmdndocno,
                   pmdnseq
                   ,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016,pmdn017,pmdn227,pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011,pmdn015,pmdn043,pmdn046,pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn028,pmdn029,pmdn030,pmdn053,pmdnorga,pmdn026,pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020,pmdn224,pmdn052,pmdn049,pmdn051,pmdn205,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn050) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmdn_d[g_detail_idx].pmdnsite,g_pmdn_d[g_detail_idx].pmdn200,g_pmdn_d[g_detail_idx].pmdn001, 
                       g_pmdn_d[g_detail_idx].pmdn228,g_pmdn_d[g_detail_idx].pmdn002,g_pmdn_d[g_detail_idx].pmdn016, 
                       g_pmdn_d[g_detail_idx].pmdn017,g_pmdn_d[g_detail_idx].pmdn227,g_pmdn_d[g_detail_idx].pmdn201, 
                       g_pmdn_d[g_detail_idx].pmdn202,g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn007, 
                       g_pmdn_d[g_detail_idx].pmdn226,g_pmdn_d[g_detail_idx].pmdn008,g_pmdn_d[g_detail_idx].pmdn009, 
                       g_pmdn_d[g_detail_idx].pmdn010,g_pmdn_d[g_detail_idx].pmdn011,g_pmdn_d[g_detail_idx].pmdn015, 
                       g_pmdn_d[g_detail_idx].pmdn043,g_pmdn_d[g_detail_idx].pmdn046,g_pmdn_d[g_detail_idx].pmdn048, 
                       g_pmdn_d[g_detail_idx].pmdn047,g_pmdn_d[g_detail_idx].pmdnunit,g_pmdn_d[g_detail_idx].pmdn225, 
                       g_pmdn_d[g_detail_idx].pmdn203,g_pmdn_d[g_detail_idx].pmdn025,g_pmdn_d[g_detail_idx].pmdn028, 
                       g_pmdn_d[g_detail_idx].pmdn029,g_pmdn_d[g_detail_idx].pmdn030,g_pmdn_d[g_detail_idx].pmdn053, 
                       g_pmdn_d[g_detail_idx].pmdnorga,g_pmdn_d[g_detail_idx].pmdn026,g_pmdn_d[g_detail_idx].pmdn024, 
                       g_pmdn_d[g_detail_idx].pmdn014,g_pmdn_d[g_detail_idx].pmdn012,g_pmdn_d[g_detail_idx].pmdn013, 
                       g_pmdn_d[g_detail_idx].pmdn022,g_pmdn_d[g_detail_idx].pmdn023,g_pmdn_d[g_detail_idx].pmdn045, 
                       g_pmdn_d[g_detail_idx].pmdn206,g_pmdn_d[g_detail_idx].pmdn207,g_pmdn_d[g_detail_idx].pmdn208, 
                       g_pmdn_d[g_detail_idx].pmdn209,g_pmdn_d[g_detail_idx].pmdn210,g_pmdn_d[g_detail_idx].pmdn211, 
                       g_pmdn_d[g_detail_idx].pmdn212,g_pmdn_d[g_detail_idx].pmdn213,g_pmdn_d[g_detail_idx].pmdn019, 
                       g_pmdn_d[g_detail_idx].pmdn020,g_pmdn_d[g_detail_idx].pmdn224,g_pmdn_d[g_detail_idx].pmdn052, 
                       g_pmdn_d[g_detail_idx].pmdn049,g_pmdn_d[g_detail_idx].pmdn051,g_pmdn_d[g_detail_idx].pmdn205, 
                       g_pmdn_d[g_detail_idx].pmdn214,g_pmdn_d[g_detail_idx].pmdn215,g_pmdn_d[g_detail_idx].pmdn216, 
                       g_pmdn_d[g_detail_idx].pmdn217,g_pmdn_d[g_detail_idx].pmdn218,g_pmdn_d[g_detail_idx].pmdn219, 
                       g_pmdn_d[g_detail_idx].pmdn220,g_pmdn_d[g_detail_idx].pmdn221,g_pmdn_d[g_detail_idx].pmdn222, 
                       g_pmdn_d[g_detail_idx].pmdn223,g_pmdn_d[g_detail_idx].pmdn050)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
            
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmdn_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
            
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
            
      #end add-point 
      INSERT INTO xrcd_t
                  (xrcdent,
                   xrcddocno,
                   xrcdld,xrcdseq,xrcdseq2,xrcd007
                   ,xrcdsite,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_pmdn2_d[g_detail_idx].xrcdsite,g_pmdn2_d[g_detail_idx].xrcd002,g_pmdn2_d[g_detail_idx].xrcd003, 
                       g_pmdn2_d[g_detail_idx].xrcd006,g_pmdn2_d[g_detail_idx].xrcd004,g_pmdn2_d[g_detail_idx].xrcd104) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_pmdn2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
            
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
            
      #end add-point 
      INSERT INTO pmdo_t
                  (pmdoent,
                   pmdodocno,
                   pmdoseq,pmdoseq1,pmdoseq2
                   ,pmdosite,pmdo003,pmdo001,pmdo002,pmdo005,pmdo200,pmdo201,pmdo004,pmdo006,pmdo028,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010,pmdo009,pmdo015,pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,pmdo031,pmdo022,pmdo023,pmdo024,pmdo032,pmdo033,pmdo034,pmdo025,pmdo026,pmdo027) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_pmdn3_d[g_detail_idx].pmdosite,g_pmdn3_d[g_detail_idx].pmdo003,g_pmdn3_d[g_detail_idx].pmdo001, 
                       g_pmdn3_d[g_detail_idx].pmdo002,g_pmdn3_d[g_detail_idx].pmdo005,g_pmdn3_d[g_detail_idx].pmdo200, 
                       g_pmdn3_d[g_detail_idx].pmdo201,g_pmdn3_d[g_detail_idx].pmdo004,g_pmdn3_d[g_detail_idx].pmdo006, 
                       g_pmdn3_d[g_detail_idx].pmdo028,g_pmdn3_d[g_detail_idx].pmdo029,g_pmdn3_d[g_detail_idx].pmdo013, 
                       g_pmdn3_d[g_detail_idx].pmdo011,g_pmdn3_d[g_detail_idx].pmdo012,g_pmdn3_d[g_detail_idx].pmdo010, 
                       g_pmdn3_d[g_detail_idx].pmdo009,g_pmdn3_d[g_detail_idx].pmdo015,g_pmdn3_d[g_detail_idx].pmdo016, 
                       g_pmdn3_d[g_detail_idx].pmdo017,g_pmdn3_d[g_detail_idx].pmdo040,g_pmdn3_d[g_detail_idx].pmdo019, 
                       g_pmdn3_d[g_detail_idx].pmdo021,g_pmdn3_d[g_detail_idx].pmdo030,g_pmdn3_d[g_detail_idx].pmdo031, 
                       g_pmdn3_d[g_detail_idx].pmdo022,g_pmdn3_d[g_detail_idx].pmdo023,g_pmdn3_d[g_detail_idx].pmdo024, 
                       g_pmdn3_d[g_detail_idx].pmdo032,g_pmdn3_d[g_detail_idx].pmdo033,g_pmdn3_d[g_detail_idx].pmdo034, 
                       g_pmdn3_d[g_detail_idx].pmdo025,g_pmdn3_d[g_detail_idx].pmdo026,g_pmdn3_d[g_detail_idx].pmdo027) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_pmdn3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
            
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
            
      #end add-point 
      INSERT INTO pmdm_t
                  (pmdment,
                   pmdmdocno,
                   pmdm001
                   ,pmdmsite,pmdm014,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007,pmdm008,pmdm009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmdn6_d[g_detail_idx].pmdmsite,g_pmdn6_d[g_detail_idx].pmdm014,g_pmdn6_d[g_detail_idx].pmdm002, 
                       g_pmdn6_d[g_detail_idx].pmdm003,g_pmdn6_d[g_detail_idx].pmdm004,g_pmdn6_d[g_detail_idx].pmdm005, 
                       g_pmdn6_d[g_detail_idx].pmdm006,g_pmdn6_d[g_detail_idx].pmdm007,g_pmdn6_d[g_detail_idx].pmdm008, 
                       g_pmdn6_d[g_detail_idx].pmdm009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_pmdn6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
            
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
      
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt840_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
            
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt840_pmdn_t_mask_restore('restore_mask_o')
               
      UPDATE pmdn_t 
         SET (pmdndocno,
              pmdnseq
              ,pmdnsite,pmdn200,pmdn001,pmdn228,pmdn002,pmdn016,pmdn017,pmdn227,pmdn201,pmdn202,pmdn006,pmdn007,pmdn226,pmdn008,pmdn009,pmdn010,pmdn011,pmdn015,pmdn043,pmdn046,pmdn048,pmdn047,pmdnunit,pmdn225,pmdn203,pmdn025,pmdn028,pmdn029,pmdn030,pmdn053,pmdnorga,pmdn026,pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020,pmdn224,pmdn052,pmdn049,pmdn051,pmdn205,pmdn214,pmdn215,pmdn216,pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,pmdn222,pmdn223,pmdn050) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmdn_d[g_detail_idx].pmdnsite,g_pmdn_d[g_detail_idx].pmdn200,g_pmdn_d[g_detail_idx].pmdn001, 
                  g_pmdn_d[g_detail_idx].pmdn228,g_pmdn_d[g_detail_idx].pmdn002,g_pmdn_d[g_detail_idx].pmdn016, 
                  g_pmdn_d[g_detail_idx].pmdn017,g_pmdn_d[g_detail_idx].pmdn227,g_pmdn_d[g_detail_idx].pmdn201, 
                  g_pmdn_d[g_detail_idx].pmdn202,g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn007, 
                  g_pmdn_d[g_detail_idx].pmdn226,g_pmdn_d[g_detail_idx].pmdn008,g_pmdn_d[g_detail_idx].pmdn009, 
                  g_pmdn_d[g_detail_idx].pmdn010,g_pmdn_d[g_detail_idx].pmdn011,g_pmdn_d[g_detail_idx].pmdn015, 
                  g_pmdn_d[g_detail_idx].pmdn043,g_pmdn_d[g_detail_idx].pmdn046,g_pmdn_d[g_detail_idx].pmdn048, 
                  g_pmdn_d[g_detail_idx].pmdn047,g_pmdn_d[g_detail_idx].pmdnunit,g_pmdn_d[g_detail_idx].pmdn225, 
                  g_pmdn_d[g_detail_idx].pmdn203,g_pmdn_d[g_detail_idx].pmdn025,g_pmdn_d[g_detail_idx].pmdn028, 
                  g_pmdn_d[g_detail_idx].pmdn029,g_pmdn_d[g_detail_idx].pmdn030,g_pmdn_d[g_detail_idx].pmdn053, 
                  g_pmdn_d[g_detail_idx].pmdnorga,g_pmdn_d[g_detail_idx].pmdn026,g_pmdn_d[g_detail_idx].pmdn024, 
                  g_pmdn_d[g_detail_idx].pmdn014,g_pmdn_d[g_detail_idx].pmdn012,g_pmdn_d[g_detail_idx].pmdn013, 
                  g_pmdn_d[g_detail_idx].pmdn022,g_pmdn_d[g_detail_idx].pmdn023,g_pmdn_d[g_detail_idx].pmdn045, 
                  g_pmdn_d[g_detail_idx].pmdn206,g_pmdn_d[g_detail_idx].pmdn207,g_pmdn_d[g_detail_idx].pmdn208, 
                  g_pmdn_d[g_detail_idx].pmdn209,g_pmdn_d[g_detail_idx].pmdn210,g_pmdn_d[g_detail_idx].pmdn211, 
                  g_pmdn_d[g_detail_idx].pmdn212,g_pmdn_d[g_detail_idx].pmdn213,g_pmdn_d[g_detail_idx].pmdn019, 
                  g_pmdn_d[g_detail_idx].pmdn020,g_pmdn_d[g_detail_idx].pmdn224,g_pmdn_d[g_detail_idx].pmdn052, 
                  g_pmdn_d[g_detail_idx].pmdn049,g_pmdn_d[g_detail_idx].pmdn051,g_pmdn_d[g_detail_idx].pmdn205, 
                  g_pmdn_d[g_detail_idx].pmdn214,g_pmdn_d[g_detail_idx].pmdn215,g_pmdn_d[g_detail_idx].pmdn216, 
                  g_pmdn_d[g_detail_idx].pmdn217,g_pmdn_d[g_detail_idx].pmdn218,g_pmdn_d[g_detail_idx].pmdn219, 
                  g_pmdn_d[g_detail_idx].pmdn220,g_pmdn_d[g_detail_idx].pmdn221,g_pmdn_d[g_detail_idx].pmdn222, 
                  g_pmdn_d[g_detail_idx].pmdn223,g_pmdn_d[g_detail_idx].pmdn050) 
         WHERE pmdnent = g_enterprise AND pmdndocno = ps_keys_bak[1] AND pmdnseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
            
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt840_pmdn_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
            
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL apmt840_xrcd_t_mask_restore('restore_mask_o')
               
      UPDATE xrcd_t 
         SET (xrcddocno,
              xrcdld,xrcdseq,xrcdseq2,xrcd007
              ,xrcdsite,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_pmdn2_d[g_detail_idx].xrcdsite,g_pmdn2_d[g_detail_idx].xrcd002,g_pmdn2_d[g_detail_idx].xrcd003, 
                  g_pmdn2_d[g_detail_idx].xrcd006,g_pmdn2_d[g_detail_idx].xrcd004,g_pmdn2_d[g_detail_idx].xrcd104)  
 
         WHERE xrcdent = g_enterprise AND xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:update_b段修改中 name="update_b.m_update2"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt840_xrcd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL apmt840_pmdo_t_mask_restore('restore_mask_o')
               
      UPDATE pmdo_t 
         SET (pmdodocno,
              pmdoseq,pmdoseq1,pmdoseq2
              ,pmdosite,pmdo003,pmdo001,pmdo002,pmdo005,pmdo200,pmdo201,pmdo004,pmdo006,pmdo028,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010,pmdo009,pmdo015,pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,pmdo031,pmdo022,pmdo023,pmdo024,pmdo032,pmdo033,pmdo034,pmdo025,pmdo026,pmdo027) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_pmdn3_d[g_detail_idx].pmdosite,g_pmdn3_d[g_detail_idx].pmdo003,g_pmdn3_d[g_detail_idx].pmdo001, 
                  g_pmdn3_d[g_detail_idx].pmdo002,g_pmdn3_d[g_detail_idx].pmdo005,g_pmdn3_d[g_detail_idx].pmdo200, 
                  g_pmdn3_d[g_detail_idx].pmdo201,g_pmdn3_d[g_detail_idx].pmdo004,g_pmdn3_d[g_detail_idx].pmdo006, 
                  g_pmdn3_d[g_detail_idx].pmdo028,g_pmdn3_d[g_detail_idx].pmdo029,g_pmdn3_d[g_detail_idx].pmdo013, 
                  g_pmdn3_d[g_detail_idx].pmdo011,g_pmdn3_d[g_detail_idx].pmdo012,g_pmdn3_d[g_detail_idx].pmdo010, 
                  g_pmdn3_d[g_detail_idx].pmdo009,g_pmdn3_d[g_detail_idx].pmdo015,g_pmdn3_d[g_detail_idx].pmdo016, 
                  g_pmdn3_d[g_detail_idx].pmdo017,g_pmdn3_d[g_detail_idx].pmdo040,g_pmdn3_d[g_detail_idx].pmdo019, 
                  g_pmdn3_d[g_detail_idx].pmdo021,g_pmdn3_d[g_detail_idx].pmdo030,g_pmdn3_d[g_detail_idx].pmdo031, 
                  g_pmdn3_d[g_detail_idx].pmdo022,g_pmdn3_d[g_detail_idx].pmdo023,g_pmdn3_d[g_detail_idx].pmdo024, 
                  g_pmdn3_d[g_detail_idx].pmdo032,g_pmdn3_d[g_detail_idx].pmdo033,g_pmdn3_d[g_detail_idx].pmdo034, 
                  g_pmdn3_d[g_detail_idx].pmdo025,g_pmdn3_d[g_detail_idx].pmdo026,g_pmdn3_d[g_detail_idx].pmdo027)  
 
         WHERE pmdoent = g_enterprise AND pmdodocno = ps_keys_bak[1] AND pmdoseq = ps_keys_bak[2] AND pmdoseq1 = ps_keys_bak[3] AND pmdoseq2 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update3"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt840_pmdo_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL apmt840_pmdm_t_mask_restore('restore_mask_o')
               
      UPDATE pmdm_t 
         SET (pmdmdocno,
              pmdm001
              ,pmdmsite,pmdm014,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007,pmdm008,pmdm009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmdn6_d[g_detail_idx].pmdmsite,g_pmdn6_d[g_detail_idx].pmdm014,g_pmdn6_d[g_detail_idx].pmdm002, 
                  g_pmdn6_d[g_detail_idx].pmdm003,g_pmdn6_d[g_detail_idx].pmdm004,g_pmdn6_d[g_detail_idx].pmdm005, 
                  g_pmdn6_d[g_detail_idx].pmdm006,g_pmdn6_d[g_detail_idx].pmdm007,g_pmdn6_d[g_detail_idx].pmdm008, 
                  g_pmdn6_d[g_detail_idx].pmdm009) 
         WHERE pmdment = g_enterprise AND pmdmdocno = ps_keys_bak[1] AND pmdm001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt840_pmdm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt840_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt840.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt840_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt840.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt840_lock_b(ps_table,ps_page)
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
   #CALL apmt840_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmdn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt840_bcl USING g_enterprise,
                                       g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt840_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xrcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmt840_bcl2 USING g_enterprise,
                                             g_pmdl_m.pmdldocno,g_pmdn2_d[g_detail_idx].xrcdld,g_pmdn2_d[g_detail_idx].xrcdseq, 
                                                 g_pmdn2_d[g_detail_idx].xrcdseq2,g_pmdn2_d[g_detail_idx].xrcd007 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt840_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "pmdo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmt840_bcl3 USING g_enterprise,
                                             g_pmdl_m.pmdldocno,g_pmdn3_d[g_detail_idx].pmdoseq,g_pmdn3_d[g_detail_idx].pmdoseq1, 
                                                 g_pmdn3_d[g_detail_idx].pmdoseq2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt840_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "pmdm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmt840_bcl4 USING g_enterprise,
                                             g_pmdl_m.pmdldocno,g_pmdn6_d[g_detail_idx].pmdm001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt840_bcl4:",SQLERRMESSAGE 
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
 
{<section id="apmt840.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt840_unlock_b(ps_table,ps_page)
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
      CLOSE apmt840_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt840_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt840_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt840_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt840_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
      
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmdldocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmdldocno",TRUE)
      CALL cl_set_comp_entry("pmdldocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("pmdlsite",TRUE)
      CALL cl_set_comp_entry("pmdldocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmdl200",TRUE)
   CALL cl_set_comp_entry("pmdl204",TRUE)
   CALL cl_set_comp_entry("pmdlunit",TRUE)
   CALL cl_set_comp_entry("pmdl029",TRUE)
   
   CALL cl_set_comp_entry("pmdl004",TRUE)
   CALL cl_set_comp_entry("pmdl203",TRUE)
   CALL cl_set_comp_entry("pmdl204",TRUE)
   CALL cl_set_comp_entry("pmdl025",TRUE)
   CALL cl_set_comp_entry("pmdl023",TRUE)
   CALl cl_set_comp_entry("pmdl022",TRUE)
   CALL cl_set_comp_entry("pmdl054",TRUE)
   CALL cl_set_comp_entry("pmdl009",TRUE)
   CALL cl_set_comp_entry("pmdl010",TRUE)
   CALL cl_set_comp_entry("pmdl011",TRUE)
   CALL cl_set_comp_entry("pmdl015",TRUE)
   CALL cl_set_comp_entry("pmdl043",TRUE)
   CALL cl_set_comp_entry("pmdl206",TRUE)  #長效期訂單 #150512-00029#2 150525 By pomelo add
   CALL cl_set_comp_entry("pmdl207",TRUE)  #所屬品類 #150610-00030#1 150612 by sakura add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt840_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmdldocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("pmdldocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmdldocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmdldocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #採購組織
   IF NOT s_aooi500_comp_entry(g_prog,'pmdlsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("pmdlsite",FALSE)
   END IF
   
   #收貨組織
   IF NOT s_aooi500_comp_entry(g_prog,'pmdlunit') THEN
      CALL cl_set_comp_entry("pmdlunit",FALSE)
   END IF
   
   #當採購方式<>3.統採越庫時，不可以輸入配送中心(pmdl204)
   IF g_pmdl_m.pmdl203 MATCHES '[01]' THEN
      CALL cl_set_comp_entry("pmdl204",FALSE)
   END IF
      
   #當單身有資料時，單頭不可修改的欄位
   LET l_cnt = 0
   SELECT COUNT(pmdnseq) INTO l_cnt
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno
   IF l_cnt >= 1 THEN
      CALL cl_set_comp_entry("pmdl200",FALSE)   #採購中心
      CALL cl_set_comp_entry("pmdl204",FALSE)   #配送中心
      CALL cl_set_comp_entry("pmdlunit",FALSE)  #收貨組織
      CALL cl_set_comp_entry("pmdl029",FALSE)   #收貨部門
      CALL cl_set_comp_entry("pmdl200",FALSE)   #採購中心
      CALL cl_set_comp_entry("pmdl004",FALSE)   #供應商
      CALL cl_set_comp_entry("pmdl203",FALSE)   #採購方式
      CALL cl_set_comp_entry("pmdl025",FALSE)   #送貨地址
      CALL cl_set_comp_entry("pmdl023",FALSE)   #採購渠道
      #CALl cl_set_comp_entry("pmdl022",FALSE)   #代送商
      CALL cl_set_comp_entry("pmdl054",FALSE)   #內外購
      CALL cl_set_comp_entry("pmdl009",FALSE)   #付款條件
      CALL cl_set_comp_entry("pmdl010",FALSE)   #交易條件
      CALL cl_set_comp_entry("pmdl011",FALSE)   #稅別
      CALL cl_set_comp_entry("pmdl015",FALSE)   #幣別
      CALL cl_set_comp_entry("pmdl206",FALSE)   #長效期訂單 #150512-00029#2 150525 By pomelo add
      CALL cl_set_comp_entry("pmdl207",FALSE)   #所屬品類 #150610-00030#1 150612 by sakura add
   END IF
   
   #留置原因
   IF NOT g_hold THEN
      CALL cl_set_comp_entry("pmdl043",FALSE)
   END IF
   #160120-00001#5 160121 By pomelo add(S)
   #當複製時
   IF g_cmd = 'r' THEN
      CALL cl_set_comp_entry("pmdlsite",FALSE)  #採購組織
      CALL cl_set_comp_entry("pmdl207",FALSE)   #所屬品類
   END IF
   #160120-00001#5 160121 By pomelo add(E)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt840_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("pmdnsite",TRUE)  #採購組織       #150810-00005#1 150810 By pomelo add
   CALL cl_set_comp_entry("pmdn025",TRUE)   #收貨地址代碼
   CALL cl_set_comp_entry("pmdn023",TRUE)   #送貨供應商
   CALL cl_set_comp_entry("pmdn214",TRUE)   #採購渠道
   CALL cl_set_comp_entry("pmdn203",TRUE)   #收貨部門
   CALL cl_set_comp_entry("pmdn014",TRUE)   #到庫日期
   
   CALL cl_set_comp_entry("pmdnseq",TRUE)   #項次
   CALL cl_set_comp_entry("pmdn200",TRUE)   #商品條碼
   CALL cl_set_comp_entry("pmdn001",TRUE)   #商品編號
   CALL cl_set_comp_entry("pmdn002",TRUE)   #產品特徵
   CALl cl_set_comp_entry("pmdn202",TRUE)   #包裝數量
   CALL cl_set_comp_entry("pmdn007",TRUE)   #採購數量
   CALL cl_set_comp_entry("pmdnunit",TRUE)  #收貨組織
   CALL cl_set_comp_entry("pmdb028",TRUE)   #收貨庫位
   CALL cl_set_comp_entry("pmdn205",TRUE)   #要貨組織
   CALL cl_set_comp_entry("pmdn020",TRUE)   #緊急度         #150324-00006#16 2015/04/30 By pomelo add
   #150512-00029#2 150525 By pomelo add(S)
   CALL cl_set_comp_entry("pmdn226",TRUE)   #長效期每次送貨量
   CALL cl_set_comp_entry("pmdn022",TRUE)   #部分交貨
   #150512-00029#2 150525 By pomelo add(E)
   CALL cl_set_comp_entry("pmdn015",TRUE)   #單價           #150506-00032#5 150527 by sakura add
   CALL cl_set_comp_entry("pmdn030",TRUE)   #收貨批號       #150427-00001#8 1500601 by lori522612 add
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt840_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005     LIKE inaa_t.inaa005
   DEFINE l_inaa007     LIKE inaa_t.inaa007
   DEFINE l_imaf055     LIKE imaf_t.imaf055    #庫存管理特微
   DEFINE l_imaf061     LIKE imaf_t.imaf061    #庫存批號控管方式
   DEFINE l_pmdb038     LIKE pmdb_t.pmdb038    #要貨單限定庫位
   DEFINE l_stan024     LIKE stan_t.stan024    #150506-00032#5 150527 by sakura add
   DEFINE l_success     LIKE type_t.num5       #150427-00001#5 150514 by lori522612 add
   DEFINE l_set_entry   LIKE type_t.num5       #150427-00001#5 150514 by lori522612 add    
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   #當有關聯性單據資料　不可以對單身資料進行新增刪除動作
   IF s_apmt840_count_pmdp(g_pmdl_m.pmdldocno) THEN
      CALL cl_set_comp_entry("pmdnseq",FALSE)   #項次
      CALL cl_set_comp_entry("pmdnsite",FALSE)  #採購組織   #150810-00005#1 150810 By pomelo add
      CALL cl_set_comp_entry("pmdn200",FALSE)   #商品條碼
      CALL cl_set_comp_entry("pmdn001",FALSE)   #商品編號
      CALL cl_set_comp_entry("pmdn002",FALSE)   #產品特徵
      CALl cl_set_comp_entry("pmdn202",FALSE)   #包裝數量
      CALL cl_set_comp_entry("pmdn007",FALSE)   #採購數量
      CALL cl_set_comp_entry("pmdnunit",FALSE)  #收貨組織
      CALL cl_set_comp_entry("pmdn205",FALSE)   #要貨組織
      #收貨庫位
      LET l_pmdb038 = apmt840_get_pmdb038()
      IF NOT cl_null(l_pmdb038) THEN
         CALL cl_set_comp_entry("pmdb028",FALSE)
      END IF
   END IF
   
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   LET l_imaa005 = ''
   CALL apmt840_get_imaa005(g_pmdn_d[l_ac].pmdn001) RETURNING l_imaa005
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdn002",FALSE)
      LET g_pmdn_d[l_ac].pmdn002 = ' '
   ELSE
      IF cl_null(g_pmdn_d[l_ac].pmdn002) THEN
         LET g_pmdn_d[l_ac].pmdn002 = ''
      END IF
   END IF
   
   #當採購單位為空，採購數量不可以給予維護，避免錯誤
   IF cl_null(g_pmdn_d[l_ac].pmdn006) THEN
      CALL cl_set_comp_entry("pmdn006",FALSE)
   END IF
   
   #當包裝數量單位為空，包裝數量不可以給予維護，避免錯誤
   IF cl_null(g_pmdn_d[l_ac].pmdn201) THEN
      CALL cl_set_comp_entry("pmdn202",FALSE)
   END IF
   
   #當採購數量有值時，包裝數量不可以修改
   IF NOT cl_null(g_pmdn_d[l_ac].pmdn007) THEN
      CALL cl_set_comp_entry("pmdn202",FALSE)
   END IF
   
   #收貨組織
   IF NOT s_aooi500_comp_entry(g_prog,'pmdnunit') THEN
      CALL cl_set_comp_entry("pmdnunit",FALSE)
   END IF
   
   #當單頭收貨組織不為空白
   IF NOT cl_null(g_pmdl_m.pmdlunit) THEN
      CALL cl_set_comp_entry("pmdnunit",FALSE)
   END IF
   
   #當單頭收貨部門不為空
   IF NOT cl_null(g_pmdl_m.pmdl029) THEN
      CALL cl_set_comp_entry("pmdn203",FALSE)
   END IF
   
   #當單頭收貨地址碼不為空白
   IF NOT cl_null(g_pmdl_m.pmdl025) THEN
      CALL cl_set_comp_entry("pmdn025",FALSE)
   END IF
   
   #當單頭代送商不為空白
   IF NOT cl_null(g_pmdl_m.pmdl022) THEN
      CALL cl_set_comp_entry("pmdn023",FALSE)
   END IF
   
   #當單頭採購渠道不為空白
   IF NOT cl_null(g_pmdl_m.pmdl023) THEN
      CALL cl_set_comp_entry("pmdn214",FALSE)
   END IF

   #庫位不使用儲位管理時，儲位不可維護
   LET l_inaa007 = ''
   SELECT inaa007 INTO l_inaa007
     FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = g_pmdn_d[l_ac].pmdnunit
      AND inaa001 = g_pmdn_d[l_ac].pmdn028
   IF l_inaa007 = '5' THEN
      CALL cl_set_comp_entry("pmdn029",FALSE)
      LET g_pmdn_d[l_ac].pmdn029 = ' '
      LET g_pmdn_d[l_ac].pmdn029_desc = ''
   END IF
   
   LET l_imaf061 = ''
   LET l_imaf055 = ''
   SELECT imaf055,imaf061 INTO l_imaf055,l_imaf061
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL'
      AND imaf001 = g_pmdn_d[l_ac].pmdn001
   
   #庫存批號控管 = 2.不可有批號，批號不可以輸入
   #150427-00001#8 1500601 by lori522612 mark and add---(S)
   #IF l_imaf061 = '2' THEN
   #   CALL cl_set_comp_entry("pmdn030",FALSE)
   #   LET g_pmdn_d[l_ac].pmdn030 = ' '
   #END IF
   LET l_success = ''  
   LET l_set_entry = ''
   CALL s_lot_out_entry(1,g_pmdl_m.pmdldocno,g_pmdl_m.pmdlsite,g_pmdn_d[l_ac].pmdn001) 
      RETURNING l_success,l_set_entry
   IF l_success THEN
      CALL cl_set_comp_entry("pmdn030",l_set_entry) 
   END IF
   #150427-00001#8 1500601 by lori522612 mark and add---(E)
   
   #庫存管理特徵 = 2.不可有庫存管理特徵，庫存管理特徵不可以輸入
   IF l_imaf055 = '2' THEN
      CALL cl_set_comp_entry("pmdn053",FALSE)
      LET g_pmdn_d[l_ac].pmdn053 = ' '
   END IF
   
   #當交期 = 'Y' 不可以修改到庫日期
   IF g_pmdn_d[l_ac].pmdn024 = 'Y' THEN
      CALL cl_set_comp_entry("pmdn014",FALSE)
   END IF
   
   #150324-00006#16 2015/04/30 By pomelo add(S)
   #當要貨單的緊急度 != 1.一般，不可以修改
   IF NOT s_apmt840_get_pmdb033(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq) THEN
      CALL cl_set_comp_entry("pmdn020",FALSE)
   END IF
   #150324-00006#16 2015/04/30 By pomelo add(E)
   
   #150512-00029#2 150525 By pomelo add(S)
   IF g_pmdl_m.pmdl206 = 'Y' THEN
      CALL cl_set_comp_entry("pmdn022",FALSE)   #部分交貨
   ELSE
      CALL cl_set_comp_entry("pmdn226",FALSE)   #長效期每次送貨量
   END IF
   #150512-00029#2 150525 By pomelo add(E)
   
   #150506-00032#5 150527 by sakura add---STR
   #合約:採購價格允許人工修改 = 'N',單價不可以維護
   SELECT stan024 INTO l_stan024
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan001 = g_pmdn_d[l_ac].pmdn218    
   IF l_stan024 = 'N' THEN
      CALL cl_set_comp_entry("pmdn015",FALSE)  #單價
   END IF
   #150506-00032#5 150527 by sakura add---END   
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt840_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify",TRUE)
   CALL cl_set_act_visible("query",TRUE)
   CALL cl_set_act_visible("delete",TRUE)
   CALL cl_set_act_visible("modify_detail",TRUE)
   CALL cl_set_act_visible("reproduce",TRUE)
   CALL cl_set_act_visible("bpm_status",TRUE)
   CALL cl_set_act_visible("open_pmdm",TRUE)       #多帳期預付款
   CALL cl_set_act_visible("gen_detail",TRUE)      #產生單身
   CALL cl_set_act_visible("open_apmi004_01",TRUE) #一次性交易對象
   CALL cl_set_act_visible("open_apmt840_s01",TRUE)#關聯單據明細
   CALL cl_set_act_visible("demo",TRUE)            #備註
   
   CALL cl_set_act_visible("open_apmt840_01",TRUE) #多交期
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt840_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_pmaa004  LIKE pmaa_t.pmaa004
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_success  LIKE type_t.num5
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #150519-00015#1 150520 By pomelo add(S)
   IF cl_null(g_pmdl_m.pmdldocno) THEN
      CALL cl_set_act_visible("open_pmdm",FALSE)       #多帳期預付款
      CALL cl_set_act_visible("gen_detail",FALSE)      #產生單身
      CALL cl_set_act_visible("open_apmi004_01",FALSE) #一次性交易對象
      CALL cl_set_act_visible("open_apmt840_s01",FALSE)#關聯單據明細
      CALL cl_set_act_visible("demo",FALSE)            #備註
   END IF
   #150519-00015#1 150520 By pomelo add(E)

   IF g_pmdl_m.pmdlstus NOT MATCHES '[NDR]' THEN       #N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("open_pmdm",FALSE)       #多帳期預付款
      CALL cl_set_act_visible("gen_detail",FALSE)      #產生單身
      CALL cl_set_act_visible("open_apmt840_01",FALSE) #多交期
      CALL cl_set_act_visible("modify",FALSE)
      CALL cl_set_act_visible("delete",FALSE)
      CALL cl_set_act_visible("modify_detail",FALSE)
   END IF
   IF g_pmdl_m.pmdlstus = 'Y' THEN
      CALL cl_set_act_visible("open_apmt840_01",FALSE) #多交期
   END IF
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   
   #當自訂貨 且 採購明細有資料 且關聯性單據沒有資料
   LET l_n = 0
   SELECT COUNT(pmdnseq) INTO l_n
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno
   IF g_pmdl_m.pmdl203 = '0' AND l_n >=1 AND
      NOT s_apmt840_count_pmdp(g_pmdl_m.pmdldocno) THEN
      CALL cl_set_act_visible("gen_detail",FALSE)      #產生單身
   END IF
   
   #當沒有單身資料 不可以維護多帳期預付款
   IF l_n = 0 THEN
      CALL cl_set_act_visible("open_pmdm",FALSE)       #多帳期預付款
   END IF
   
   IF NOT cl_null(g_pmdl_m.pmdl004) THEN
      LET l_pmaa004 = ''
      SELECT pmaa004 INTO l_pmaa004
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_pmdl_m.pmdl004
      IF l_pmaa004 NOT MATCHES '[34]' THEN
         CALL cl_set_act_visible("open_apmi004_01", FALSE)
      END IF
   ELSE
      CALL cl_set_act_visible("open_apmi004_01", FALSE)
   END IF
    
    #當有關連性單據資料時，不可以複製
    IF s_apmt840_count_pmdp(g_pmdl_m.pmdldocno) THEN
       CALL cl_set_act_visible("reproduce", FALSE)
    END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt840_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt840_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt840_default_search()
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
      LET ls_wc = ls_wc, " pmdldocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #傳單號範圍至apmt840,一次查詢可查詢出多個單號資料
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc , g_argv[02], " AND "
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
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "pmdl_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmdn_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrcd_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "pmdo_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "pmdm_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
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
 
{<section id="apmt840.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt840_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
         DEFINE l_success  LIKE type_t.num5
   DEFINE l_pmdl205     LIKE pmdl_t.pmdl205
   DEFINE l_replace    STRING   
   DEFINE l_msg        STRING   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmdl_m.pmdldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF STATUS THEN
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt840_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmt840_action_chk() THEN
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001, 
       g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004,g_pmdl_m.pmdl004_desc, 
       g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003,g_pmdl_m.pmdl003_desc, 
       g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl201, 
       g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdl207,g_pmdl_m.pmdl207_desc, 
       g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025, 
       g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl023_desc, 
       g_pmdl_m.pmdl022,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl047, 
       g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015,g_pmdl_m.pmdl015_desc, 
       g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011,g_pmdl_m.pmdl011_desc, 
       g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl024,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl044, 
       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
       g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp, 
       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdp_desc, 
       g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
       g_pmdl_m.pmdlcnfid_desc,g_pmdl_m.pmdlcnfdt
 
   CASE g_pmdl_m.pmdlstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "H"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
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
      WHEN "UH"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pmdl_m.pmdlstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "H"
               HIDE OPTION "hold"
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
            WHEN "UH"
               HIDE OPTION "unhold"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw,closed",FALSE)
      #將open改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CASE g_pmdl_m.pmdlstus
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
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)
         WHEN "H"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)    
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold,unhold",FALSE)
         WHEN "C"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt840_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt840_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt840_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt840_cl
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
      ON ACTION hold
         IF cl_auth_chk_act("hold") THEN
            LET lc_state = "H"
            #add-point:action控制 name="statechange.hold"
                  
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
      AND lc_state <> "H"
      AND lc_state <> "C"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "UH"
      AND lc_state <> "X"
      ) OR 
      g_pmdl_m.pmdlstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt840_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL cl_err_collect_init()
   IF lc_state = 'Y' THEN   
      IF NOT s_apmt840_conf_chk(g_pmdl_m.pmdldocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#15 add
         RETURN
      ELSE
         ##150407-00020#1 Add-S By Ken 150410
         #CALL apmt840_pmdl205_chk(g_pmdl_m.pmdldocno,0,g_pmdl_m.pmdl205) RETURNING l_success,l_pmdl205
         #IF NOT l_success THEN
         #   LET l_replace = g_pmdl_m.pmdl205 ,"|",l_pmdl205
         #   LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)            
         #   IF cl_ask_confirm_parm('std-00008',l_msg) THEN            
         #      IF NOT apmt840_pmdn224_upd(g_pmdl_m.pmdldocno,l_pmdl205) THEN
         #         CALL s_transaction_end('N','0')
         #         CALL cl_err_collect_show()
         #         RETURN
         #      END IF  
         #   ELSE
         #      RETURN
         #   END IF
         #END IF
         ##150407-00020#1 Add-E           
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         ELSE
            IF NOT s_apmt840_conf_upd(g_pmdl_m.pmdldocno) THEN
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
   
   IF lc_state = 'N' THEN
      IF NOT s_apmt840_unconf_chk(g_pmdl_m.pmdldocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#15 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         ELSE
            IF NOT s_apmt840_unconf_upd(g_pmdl_m.pmdldocno) THEN
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
   
   IF lc_state = 'X' THEN
      IF NOT s_apmt840_invalid_chk(g_pmdl_m.pmdldocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#15 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#15 add
            RETURN
         ELSE
            IF NOT s_apmt840_invalid_upd(g_pmdl_m.pmdldocno)  THEN
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
   
   IF lc_state = 'H' THEN
      IF NOT apmt840_pmdl043_hold() THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
         CALL cl_err_collect_show()
      END IF
   END IF
   
   IF lc_state = 'UH' THEN
      IF NOT apmt840_pmdl043_unhold() THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
         LET lc_state = 'Y'
         CALL cl_err_collect_show()
      END IF
   END IF
   #end add-point
   
   LET g_pmdl_m.pmdlmodid = g_user
   LET g_pmdl_m.pmdlmoddt = cl_get_current()
   LET g_pmdl_m.pmdlstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmdl_t 
      SET (pmdlstus,pmdlmodid,pmdlmoddt) 
        = (g_pmdl_m.pmdlstus,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt)     
    WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdl_m.pmdldocno
 
    
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
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
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
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
          g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
          g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
          g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
          g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
          g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
          g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
          g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
          g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
          g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
          g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
          g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
          g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
          g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
          g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc, 
          g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno, 
          g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004, 
          g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003, 
          g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
          g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl204_desc, 
          g_pmdl_m.pmdl207,g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029, 
          g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl025,g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017,g_pmdl_m.pmdl206, 
          g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022,g_pmdl_m.pmdl022_desc, 
          g_pmdl_m.pmdl021,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055, 
          g_pmdl_m.pmdl009,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl016, 
          g_pmdl_m.pmdl010,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011,g_pmdl_m.pmdl011_desc,g_pmdl_m.pmdl012, 
          g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl024,g_pmdl_m.pmdl024_desc, 
          g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl044, 
          g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046, 
          g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp, 
          g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdp_desc, 
          g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
          g_pmdl_m.pmdlcnfid_desc,g_pmdl_m.pmdlcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
      
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE apmt840_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt840_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt840.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt840_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmdn_d.getLength() THEN
         LET g_detail_idx = g_pmdn_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdn_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pmdn2_d.getLength() THEN
         LET g_detail_idx = g_pmdn2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdn2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdn2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_pmdn3_d.getLength() THEN
         LET g_detail_idx = g_pmdn3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdn3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdn3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_pmdn6_d.getLength() THEN
         LET g_detail_idx = g_pmdn6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdn6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdn6_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   CASE g_touch
      WHEN 1
         CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl007")
      WHEN 2
         CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl054")
      WHEN 3
         CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl043")
      WHEN 4
         CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdl046")
      WHEN 5
         CALL gfrm_curr.ensureFieldVisible("pmdl_t.pmdlownid")
   END CASE
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt840_b_fill2(pi_idx)
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
   
   CALL apmt840_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt840_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
            
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt840.status_show" >}
PRIVATE FUNCTION apmt840_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt840.mask_functions" >}
&include "erp/apm/apmt840_mask.4gl"
 
{</section>}
 
{<section id="apmt840.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt840_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL apmt840_show()
   CALL apmt840_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_apmt840_conf_chk(g_pmdl_m.pmdldocno) THEN
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF

   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmdl_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmdn_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_pmdn2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_pmdn3_d))
   CALL cl_bpm_set_detail_data("s_detail6", util.JSONArray.fromFGL(g_pmdn6_d))
 
 
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
   #CALL apmt840_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt840_ui_headershow()
   CALL apmt840_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt840_draw_out()
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
   CALL apmt840_ui_headershow()  
   CALL apmt840_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt840.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt840_set_pk_array()
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
   LET g_pk_array[1].values = g_pmdl_m.pmdldocno
   LET g_pk_array[1].column = 'pmdldocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt840.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt840.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt840_msgcentre_notify(lc_state)
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
   CALL apmt840_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmdl_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt840.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt840_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#28 add-S
   SELECT pmdlstus  INTO g_pmdl_m.pmdlstus
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdl_m.pmdldocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pmdl_m.pmdlstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'H'
           LET g_errno = 'sub-01348'
        WHEN 'C'
           LET g_errno = 'ain-00197'
        WHEN 'UH'
           LET g_errno = 'sub-01358'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_pmdl_m.pmdldocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apmt840_set_act_visible()
        CALL apmt840_set_act_no_visible()
        CALL apmt840_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#28 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt840.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭必要輸入欄位關閉
# Memo...........:
# Usage..........: CALL apmt840_set_no_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_set_no_required()
    CALL cl_set_comp_required("pmdl204",FALSE)
    CALL cl_set_comp_required("pmdl205",FALSE)
    CALL cl_set_comp_required("pmdl207",FALSE) #所屬品類 #150610-00030#1 150612 by sakura add
END FUNCTION

################################################################################
# Descriptions...: 單頭必要輸入欄位開啟
# Memo...........:
# Usage..........: CALL apmt840_set_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_set_required()
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sys            LIKE type_t.num5 #150610-00030#1 150612 by sakura add

   #當採購方式 = 3.統採越庫時，配送中心(pmdl204) 必要輸入
   IF g_pmdl_m.pmdl203 = '3' THEN
      CALL cl_set_comp_required("pmdl204",TRUE)
   END IF
   
   #150604-00026#1 150608 By pomelo add(S)
   #當長效期訂單 = 'N' 且 單身有資料，採購失效日 必要輸入
   LET l_cnt = 0
   SELECT COUNT(pmdnseq) INTO l_cnt
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno
   IF g_pmdl_m.pmdl206 = 'N' AND l_cnt >= 1 THEN
      CALL cl_set_comp_required("pmdl205",TRUE)
   END IF
   #150604-00026#1 150608 By pomelo add(E)
   
   #150610-00030#1 150612 By sakura add(S)
   #取得[要貨轉採購拆併單方式]參數
   CALL cl_get_para(g_enterprise,g_pmdl_m.pmdlsite,'E-CIR-0026') RETURNING l_sys
   #4.採購中心+供應商+代送商+採購方式+商品品類拆單
   #5.採購中心+供應商+採購方式+代送商+收貨組織+收貨部門+商品品類拆單
   #6.採購中心+供應商+採購方式+代送商+收貨地址碼+商品品類拆單
   #為4/5/6時,所屬品類為必輸
   IF l_sys = '4' OR l_sys = '5' OR l_sys = '6' THEN
      CALL cl_set_comp_required("pmdl207",TRUE)
   END IF
   #150610-00030#1 150612 By sakura add(E)
END FUNCTION

################################################################################
# Descriptions...: 根據供應商編號帶出其他欄位值
# Memo...........:
# Usage..........: CALL apmt840_pmdl004_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdl004_default()
DEFINE l_success   LIKE type_t.num5
DEFINE l_scc40     LIKE type_t.chr2
DEFINE l_ooef016   LIKE ooef_t.ooef016


    #SELECT pmab037,pmab053,pmab034,  #Mark By Ken 151028 #151027-00013#1
    SELECT pmab037,pmab053,           #Add By Ken 151028 #151027-00013#1
           pmab033,pmab040,
           pmab038,pmab039,pmab056,
           pmab057,pmab058
      #INTO g_pmdl_m.pmdl009,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,  #Mark By Ken 151028 #151027-00013#1
      INTO g_pmdl_m.pmdl009,g_pmdl_m.pmdl010,                    #Add By Ken 151028 #151027-00013#1
           g_pmdl_m.pmdl015,g_pmdl_m.pmdl020,
           g_pmdl_m.pmdl023,g_pmdl_m.pmdl024,g_pmdl_m.pmdl033,
           g_pmdl_m.pmdl054,g_pmdl_m.pmdl055
      FROM pmab_t
     WHERE pmabent = g_enterprise
       AND pmabsite = 'ALL'
       AND pmab001 = g_pmdl_m.pmdl004
          
    #取稅率、單價含稅否
    IF NOT cl_null(g_pmdl_m.pmdl011) THEN
       CALL s_adb_oodb002_default(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011)
          RETURNING g_pmdl_m.pmdl013,g_pmdl_m.pmdl012
    END IF
    
    #取匯率
    CALL s_apmt840_pmdl016_default(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdl_m.pmdl054)
       RETURNING g_pmdl_m.pmdl016
    
    #帳款供應商(pmdl021)依供應商編號抓取pmac_t 且 交易類型 = 1.收/付款對象 且 勾主要
    LET g_pmdl_m.pmdl021 = ''
    LET g_pmdl_m.pmdl021_desc = ''
    CALL s_adb_get_pmac002(g_pmdl_m.pmdl004,'1','') RETURNING g_pmdl_m.pmdl021
    
    #代送商(pmdl022)依供應商編號抓取pmac_t 且 交易類型 = 2:出貨對象 且 勾主要
    LET g_pmdl_m.pmdl022 = ''
    LET g_pmdl_m.pmdl022_desc = ''
    CALL s_adb_get_pmac002(g_pmdl_m.pmdl004,'2','') RETURNING g_pmdl_m.pmdl022
    
    #抓取交易對象聯絡人明細檔的聯絡對像識別碼顯示在採購單上的[C:供應商連絡人]，
    #若有設置多個聯絡人時，則取有勾選主要聯絡人的那一個
    LET g_pmdl_m.pmdl027 = ''
    LET g_pmdl_m.pmdl027_desc = ''
    SELECT pmaj002 INTO g_pmdl_m.pmdl027
      FROM pmaj_t
     WHERE pmajent = g_enterprise
       AND pmaj001 = g_pmdl_m.pmdl004
       AND pmajstus = 'Y'
       AND pmaj004 = 'Y'
    
    #付款條件
    CALL s_desc_get_ooib002_desc(g_pmdl_m.pmdl009) RETURNING g_pmdl_m.pmdl009_desc
    
    #交易條件
    CALL s_desc_get_acc_desc('238',g_pmdl_m.pmdl010) RETURNING g_pmdl_m.pmdl010_desc
    
    #稅別
    CALL s_desc_get_tax_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING g_pmdl_m.pmdl011_desc
    
    #幣別
    CALL s_desc_get_currency_desc(g_pmdl_m.pmdl015) RETURNING g_pmdl_m.pmdl015_desc
    
    #運送方式
    CALL s_desc_get_acc_desc('263',g_pmdl_m.pmdl020) RETURNING g_pmdl_m.pmdl020_desc
    
    #採購通路
    CALL s_desc_get_oojdl003_desc(g_pmdl_m.pmdl023) RETURNING g_pmdl_m.pmdl023_desc
    
    #採購分類
    CALL s_desc_get_acc_desc('264',g_pmdl_m.pmdl024) RETURNING g_pmdl_m.pmdl024_desc
    
    #發票類型
    CALL s_desc_get_invoice_type_desc1(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl033) RETURNING g_pmdl_m.pmdl033_desc
    
    #帳款供應商
    CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl021) RETURNING g_pmdl_m.pmdl021_desc
    
    #代送商
    CALL s_desc_get_trading_partner_abbr_desc(g_pmdl_m.pmdl022) RETURNING g_pmdl_m.pmdl022_desc
    
    #供應商連絡人
    CALL apmt840_pmdl027_ref(g_pmdl_m.pmdl027) RETURNING g_pmdl_m.pmdl027_desc
    
    DISPLAY BY NAME g_pmdl_m.pmdl009,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,
                    g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl015,
                    g_pmdl_m.pmdl016,g_pmdl_m.pmdl020,g_pmdl_m.pmdl023,
                    g_pmdl_m.pmdl024,g_pmdl_m.pmdl033,g_pmdl_m.pmdl054,
                    g_pmdl_m.pmdl055,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,
                    g_pmdl_m.pmdl027,                    
                    g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl011_desc,
                    g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdl023_desc,
                    g_pmdl_m.pmdl024_desc,g_pmdl_m.pmdl033_desc,g_pmdl_m.pmdl022_desc,
                    g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl027_desc
                    
    LET g_pmdl_m_o.pmdl009 = g_pmdl_m.pmdl009
    LET g_pmdl_m_o.pmdl010 = g_pmdl_m.pmdl010
    LET g_pmdl_m_o.pmdl011 = g_pmdl_m.pmdl011
    LET g_pmdl_m_o.pmdl012 = g_pmdl_m.pmdl012
    LET g_pmdl_m_o.pmdl013 = g_pmdl_m.pmdl013
    LET g_pmdl_m_o.pmdl015 = g_pmdl_m.pmdl015
    LET g_pmdl_m_o.pmdl016 = g_pmdl_m.pmdl016
    LET g_pmdl_m_o.pmdl020 = g_pmdl_m.pmdl020
    LET g_pmdl_m_o.pmdl023 = g_pmdl_m.pmdl023
    LET g_pmdl_m_o.pmdl024 = g_pmdl_m.pmdl024
    LET g_pmdl_m_o.pmdl033 = g_pmdl_m.pmdl033
    LET g_pmdl_m_o.pmdl054 = g_pmdl_m.pmdl054
    LET g_pmdl_m_o.pmdl055 = g_pmdl_m.pmdl055
    LET g_pmdl_m_o.pmdl022 = g_pmdl_m.pmdl022
    LET g_pmdl_m_o.pmdl021 = g_pmdl_m.pmdl021
    LET g_pmdl_m_o.pmdl027 = g_pmdl_m.pmdl027

END FUNCTION

################################################################################
# Descriptions...: 供應商聯絡人帶出全名
# Memo...........:
# Usage..........: CALL apmt840_pmdl027_ref(p_pmdl027) RETRUNING r_oofa011
# Input parameter: p_pmdl027     供應商聯絡人
# Return code....: r_oofa011     全名
# Date & Author..: 2014/11/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdl027_ref(p_pmdl027)
DEFINE p_pmdl027   LIKE pmdl_t.pmdl027
DEFINE r_oofa011   LIKE oofa_t.oofa011
    
    LET r_oofa011 = ''
    SELECT oofa011 INTO r_oofa011
      FROM oofa_t
     WHERE oofaent = g_enterprise
       AND oofa001 = p_pmdl027
       
    RETURN r_oofa011
END FUNCTION

################################################################################
# Descriptions...: 預設收貨地址
# Memo...........:
# Usage..........: CALL apmt840_addr_default()
# Input parameter: p_type     1.單頭 2.單身
# Return code....: 無
# Date & Author..: 2014/11/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_addr_default(p_type)
DEFINE p_type           LIKE type_t.num5
DEFINE l_ooef001        LIKE ooef_t.ooef001
DEFINE l_pmdl204        LIKE pmdl_t.pmdl204
DEFINE l_pmdl025        LIKE pmdl_t.pmdl025

   #當採購方式<>'3.統採越庫'時，輸入值須存在收貨組織(pmdlunit)所設置主要的聯絡地址資料的簡要代碼，且為有效的"3.送貨地址"資料
   #當採購方式 = '3.統採越庫'時，輸入值須存在"配送中心(pmdl204)"所設置主要的聯絡地址資料的簡要代碼，且為有效的"3.送貨地址"資料
   LET l_ooef001 = ''
   LET l_pmdl204 = ''
   
   CASE p_type
      WHEN 1
         IF cl_null(g_pmdl_m.pmdl025) THEN
            CASE
               WHEN g_pmdl_m.pmdl203 = '3' AND NOT cl_null(g_pmdl_m.pmdl204)
                  LET l_ooef001 = g_pmdl_m.pmdl204
                  
               WHEN g_pmdl_m.pmdl203 MATCHES '[01]' AND NOT cl_null(g_pmdl_m.pmdlunit)
                  LET l_ooef001 = g_pmdl_m.pmdlunit
            END CASE
         END IF
      WHEN 2
         IF cl_null(g_pmdn_d[l_ac].pmdn025) THEN
            CASE
               WHEN g_pmdl_m.pmdl203 = '3' AND NOT cl_null(g_pmdn_d[l_ac].pmdn223)
                  LET l_ooef001 = g_pmdn_d[l_ac].pmdn223
                  
               WHEN g_pmdl_m.pmdl203 MATCHES '[01]' AND NOT cl_null(g_pmdn_d[l_ac].pmdnunit)
                  LET l_ooef001 = g_pmdn_d[l_ac].pmdnunit
            END CASE
         END IF
   END CASE
   
   CALL s_apmt840_main_addr('3',l_ooef001) RETURNING l_pmdl025
   
   CASE p_type
      WHEN 1
         LET g_pmdl_m.pmdl025 = l_pmdl025
         CALL s_apmt840_address_ref('3',g_pmdl_m.pmdl025,l_ooef001)
            RETURNING g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
         DISPLAY BY NAME g_pmdl_m.pmdl025,g_pmdl_m.pmdl025_desc,g_pmdl_m.oofb017
      WHEN 2
         LET g_pmdn_d[l_ac].pmdn025 = l_pmdl025
         CALL s_apmt840_address_ref('3',g_pmdn_d[l_ac].pmdn025,l_ooef001)
            RETURNING g_pmdn_d[l_ac].pmdn025_desc,g_pmdn_d[l_ac].l_pmdn025_addr
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 取得稅區
# Memo...........:
# Usage..........: CALL apmt840_get_ooef019(p_ooef001)
#                  RETURNING r_ooef019
# Input parameter: p_ooef001      組織編號
# Return code....: r_ooef016      主幣別編號
# Date & Author..: 2014/11/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_get_ooef019(p_ooef001)
DEFINE p_ooef001         LIKE ooef_t.ooef001
DEFINE r_ooef019         LIKE ooef_t.ooef019

   LET r_ooef019 = ''
   SELECT ooef019 INTO r_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_ooef001
      
   RETURN r_ooef019
END FUNCTION

################################################################################
# Descriptions...: 商品編號檢查
# Memo...........:
# Usage..........: CALL apmt840_pmdn001_chk(p_pmdn001)
#                :    RETURNING r_success
# Input parameter: p_pmdn001      商品編號
# Return code....: r_success      True/False
# Date & Author..: 2014/11/27 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdn001_chk(p_pmdn001)
DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
DEFINE r_success     LIKE type_t.num5
DEFINE l_rtdxstus    LIKE rtdx_t.rtdxstus
DEFINE l_success     LIKE type_t.num5
DEFINE l_errno       LIKE type_t.chr10
#150610-00030#1 150612 By sakura add(S)
DEFINE l_sys         LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_n         LIKE type_t.num5
#150610-00030#1 150612 By sakura add(E)

   LET r_success = TRUE
   
   IF NOT cl_null(p_pmdn001) THEN
      #150521-00016#1 150528 By pomelo add(S)
      IF NOT apmt840_unique_chk(g_pmdn_d[l_ac].pmdnseq,  g_pmdn_d[l_ac].pmdnsite,
                                g_pmdn_d[l_ac].pmdnunit, g_pmdn_d[l_ac].pmdn001,
                                g_pmdn_d[l_ac].pmdn002) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #150521-00016#1 150528 By pomelo add(E)
   
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_pmdn001
      LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdnsite
      LET g_chkparam.err_str[1] = "aim-00066:art-00691"   #160118-00013#7 160217 By pomelo add
      IF cl_chk_exist("v_imaf001_15") THEN
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = p_pmdn001
         LET g_chkparam.arg2 = g_pmdn_d[l_ac].pmdnsite
        #IF NOT cl_chk_exist("v_rtdx001") THEN    #170217-00026#1 17/02/21 By 08171
         IF NOT cl_chk_exist("v_rtdx001_11") THEN #170217-00026#1 17/02/21 By 08171
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_success = ''
         LET l_errno   = ''
         CALL s_apmt840_chk_pact_curr(g_pmdn_d[l_ac].pmdn222,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocdt,g_pmdn_d[l_ac].pmdn001,g_pmdl_m.pmdl015,g_pmdn_d[l_ac].pmdnsite)
            RETURNING l_success,l_errno
         IF l_success = FALSE THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = l_errno
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         #商品生命周期的判断  2015/03/19  geza
         #IF NOT s_life_cycle_chk(g_prog,g_pmdl_m.pmdlsite,'1',g_pmdn_d[l_ac].pmdn001) THEN   #150616-00035#78-mark by dongsz
         IF NOT s_life_cycle_chk(g_prog,g_pmdl_m.pmdlsite,'1',g_pmdn_d[l_ac].pmdn001,g_pmdl_m.pmdl004,g_pmdl_m.pmdldocdt) THEN   #150616-00035#78-add by dongsz
            LET r_success = FALSE
            RETURN r_success
         END IF
      ELSE
         LET r_success = FALSE
         RETURN r_success
      END IF
      #150610-00030#1 150612 By sakura add(S)
      #若單頭有指定所屬品類。輸入商品必須存在所屬品類或者其下級
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      IF NOT cl_null(g_pmdl_m.pmdl207) THEN
         LET l_sql = " SELECT COUNT(imaa001) FROM imaa_t ",
                    "  WHERE imaaent = ",g_enterprise," AND imaa001 = '",g_pmdn_d[l_ac].pmdn001,"'",
                    "   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t",
                    "                    WHERE rtaxent = ",g_enterprise," AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                    "                    START WITH rtax003 = '", g_pmdl_m.pmdl207,"' ",
                    "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                    "                    UNION ",
                    "                   SELECT DISTINCT rtax001",
                    "                              FROM rtax_t ",
                    "                             WHERE rtaxent =",g_enterprise,
                    "                               AND rtax004 = ",l_sys,
                    "                               AND rtax005 = 0 ",
                    "                               AND rtaxstus = 'Y' ",
                    "                               AND rtax001 = '",g_pmdl_m.pmdl207,"' )"
         
         PREPARE sel_cnt FROM l_sql
         EXECUTE sel_cnt INTO l_n
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00331'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN FALSE
         END IF
      END IF      
      #150610-00030#1 150612 By sakura add(E)      
   END IF
   #08171
   IF NOT s_arti204_control_check(g_prog,g_pmdl_m.pmdl003,g_pmdn_d[l_ac].pmdn001,'') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #08171
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出其他欄位
# Memo...........:
# Usage..........: CALL apmt840_pmdn001_default()
# Input parameter: p_type      1.商品條碼 2.商品編號
# Return code....: r_success   True/False
# Date & Author..: 2014/11/27 By pomelo
# Modify.........: 2015/09/07 By sakura 新增回傳值
################################################################################
PUBLIC FUNCTION apmt840_pmdn001_default(p_type)
DEFINE r_success        LIKE type_t.num5      #150903-00007#1 150903 by sakura add
DEFINE p_type           LIKE type_t.chr1      #150512-00029#2 150525 By pomelo add
DEFINE l_rtdx002        LIKE rtdx_t.rtdx002   #商品主條碼
DEFINE l_imaz002        LIKE imaz_t.imaz002   #補貨規格
DEFINE l_imaz006        LIKE imaz_t.imaz006   #補貨規格說明   #150710-00016#5 150713 by sakura add
DEFINE l_imaz004        LIKE imaz_t.imaz004   #補貨單位       #150710-00016#5 150713 by sakura add
DEFINE l_oodb011        LIKE oodb_t.oodb011   #稅別應用       #150930-00013#1 Add By Ken 151005 

   LET r_success = TRUE   #150930-00013#1 Add By Ken 151005
   
   #檢驗否
   CALL s_apmt840_get_rtax009(g_pmdn_d[l_ac].pmdn001)
      RETURNING g_pmdn_d[l_ac].pmdn052

   #收貨庫位
   #CALL apmt840_pmdn028_default()    #150520-00016#1 150525 By pomelo add

   #取的門店清單裡的商品條碼及包裝單位
   #輸入商品編號的時候，需要重新帶出商品條碼
   #150512-00029#2 150525 By pomelo add(S)
   #IF p_type = '2' THEN   #150710-00016#5 150713 by sakura mark
      LET l_rtdx002 = ''
      LET l_imaz004 = ''   #150710-00016#5 150713 by sakura add
      LET l_imaz006 = ''   #150710-00016#5 150713 by sakura add
      #150521-00015#1 150527 By pomelo add(S)
      LET l_imaz002 = cl_get_para(g_enterprise,g_pmdn_d[l_ac].pmdnsite,'S-CIR-1002')
      SELECT imaz003,imaz004,imaz006 INTO l_rtdx002,l_imaz004,l_imaz006 #150710-00016#5 150713 by sakura add imaz004,imaz006
        FROM imaz_t
       WHERE imazent = g_enterprise
         AND imaz001 = g_pmdn_d[l_ac].pmdn001
         AND imaz002 = l_imaz002
      
      #IF cl_null(l_rtdx002)THEN   #150710-00016#5 150713 by sakura mark
      IF cl_null(g_pmdn_d[l_ac].pmdn200) OR g_pmdn_d_o.pmdn001 <> g_pmdn_d[l_ac].pmdn001 THEN   #150710-00016#5 150713 by sakura add
      #150521-00015#1 150527 By pomelo add(E)
         SELECT rtdx002 INTO l_rtdx002
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_pmdn_d[l_ac].pmdnsite
            AND rtdx001 = g_pmdn_d[l_ac].pmdn001
      END IF
      IF p_type = '2' THEN   #150710-00016#5 150713 by sakura add
         LET g_pmdn_d[l_ac].pmdn200 = l_rtdx002
      END IF   #150710-00016#5 150713 by sakura add
      #150710-00016#5 150713 by sakura add(S)
      #單據上的包裝帶位直接帶該商品補貨規格的單位，同時顯示補貨規格說明
      #1.依參數補貨規格設定，抓取商品主檔中的補貨規格的補貨單位->包裝單位及補貨規格說明
      #2.如依門店補貨規格參數抓取不到該商品的補貨規格時，則直接抓取該商品的主條碼的包裝單位當作單據的包裝單位，補貨規格放空白
      IF NOT cl_null(l_imaz004) THEN
         LET g_pmdn_d[l_ac].pmdn201 = l_imaz004      
         LET g_pmdn_d[l_ac].pmdn227 = l_imaz006
      ELSE
         #取得商品主條碼裡的包裝單位
         SELECT imay004 INTO g_pmdn_d[l_ac].pmdn201
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = g_pmdn_d[l_ac].pmdn001
            AND imay006 = 'Y'
         LET g_pmdn_d[l_ac].pmdn227 = ' '         
      END IF
      #150710-00016#5 150713 by sakura add(E)      
   #END IF   #150710-00016#5 150713 by sakura mark
   #150512-00029#2 150525 By pomelo add(E)

   #150710-00016#5 150713 by sakura mark(S)
   ##取的商品條碼裡的包裝單位
   #SELECT imay004 INTO g_pmdn_d[l_ac].pmdn201
   #  FROM imay_t
   # WHERE imayent = g_enterprise
   #   AND imay003 = g_pmdn_d[l_ac].pmdn200
   #150710-00016#5 150713 by sakura mark(E)
   
   #150512-00029#2 150525 By pomelo add(S)   
   #CALL s_apmt840_get_rtdx(g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn001)
   #   RETURNING g_pmdn_d[l_ac].pmdn200,g_pmdn_d[l_ac].pmdn201
   #150512-00029#2 150525 By pomelo add(E)

   #包裝單位
   CALL s_desc_get_unit_desc(g_pmdn_d[l_ac].pmdn201) RETURNING g_pmdn_d[l_ac].pmdn201_desc
    
   #取協議資訊
   CALL s_apmt840_get_pact(g_pmdn_d[l_ac].pmdn222,g_pmdl_m.pmdl015,g_pmdl_m.pmdl004,
                           g_pmdl_m.pmdldocdt,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdnsite)
      RETURNING g_pmdn_d[l_ac].pmdnorga,g_pmdn_d[l_ac].pmdn006,
                g_pmdn_d[l_ac].pmdn010, g_pmdn_d[l_ac].pmdn043,
                g_pmdn_d[l_ac].pmdn016, g_pmdn_d[l_ac].pmdn017,
                g_pmdn_d[l_ac].pmdn216, g_pmdn_d[l_ac].pmdn217,
                g_pmdn_d[l_ac].pmdn218, g_pmdn_d[l_ac].pmdn219,
                g_pmdn_d[l_ac].pmdn220, g_pmdn_d[l_ac].pmdn221
                
    #150930-00013#1 Add By Ken 151005(S)  #取得單頭稅別的稅別應用 
    LET l_oodb011 = ''
    CALL s_apmt840_get_oodb011(g_pmdl_m.pmdlsite,g_pmdl_m.pmdl011) RETURNING l_oodb011
    IF (l_oodb011 = '1') AND (g_pmdl_m.pmdl011 <> g_pmdn_d[l_ac].pmdn016) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  'apm-01002'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = g_pmdl_m.pmdl011
       LET g_errparam.replace[2] = g_pmdn_d[l_ac].pmdn016
       CALL cl_err()       
       LET r_success = FALSE
       RETURN r_success
    END IF
    #150930-00013#1 Add By Ken 151005(E)
    
    #單價 = 取出價格
    LET g_pmdn_d[l_ac].pmdn015 = g_pmdn_d[l_ac].pmdn043
    
    #帳務組織
    CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdnorga) RETURNING g_pmdn_d[l_ac].pmdnorga_desc

    #採購單位
    CALL s_desc_get_unit_desc(g_pmdn_d[l_ac].pmdn006) RETURNING g_pmdn_d[l_ac].pmdn006_desc
    
    #計價單位
    CALL s_desc_get_unit_desc(g_pmdn_d[l_ac].pmdn010) RETURNING g_pmdn_d[l_ac].pmdn010_desc
    
    #稅別
    CALL s_desc_get_tax_desc1(g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdn016) RETURNING g_pmdn_d[l_ac].pmdn016_desc
    
    #結算方式
    CALL apmt840_pmdn217_ref()
    
    #採購人員
    CALL s_desc_get_person_desc(g_pmdn_d[l_ac].pmdn220) RETURNING g_pmdn_d[l_ac].pmdn220_desc
    
    #採購部門
    CALL s_desc_get_department_desc(g_pmdn_d[l_ac].pmdn221) RETURNING g_pmdn_d[l_ac].pmdn221_desc
    
    #單位間的轉換數量
    #150903-00007#1 150903 by sakura mark&add(S)
    #CALL apmt840_num_change()
    IF NOT apmt840_num_change() THEN
       LET r_success = FALSE
       RETURN r_success
    END IF
    #150903-00007#1 150903 by sakura mark&add(E)
    
    #帳款地址預設
    CALL s_apmt840_main_addr('5',g_pmdn_d[l_ac].pmdnorga) RETURNING g_pmdn_d[l_ac].pmdn026
    
    #帳款地址碼
    CALL s_apmt840_address_ref('5',g_pmdn_d[l_ac].pmdn026,g_pmdn_d[l_ac].pmdnorga)
       RETURNING g_pmdn_d[l_ac].pmdn026_desc,g_pmdn_d[l_ac].l_pmdn026_addr
    
    #取得未稅金額、稅額、含稅金額
    CALL s_apmt840_get_amount(g_pmdl_m.pmdldocno,g_pmdn_d[l_ac].pmdnseq,g_pmdl_m.pmdlsite,g_pmdl_m.pmdl015,g_pmdn_d[l_ac].pmdn007,g_pmdn_d[l_ac].pmdn015,g_pmdn_d[l_ac].pmdn016)
       RETURNING g_pmdn_d[l_ac].pmdn046,g_pmdn_d[l_ac].pmdn048,g_pmdn_d[l_ac].pmdn047
    
    #可用庫存量 跟 採購在途量
    CALL apmt840_get_sum(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
       RETURNING g_pmdn_d[l_ac].pmdn206,g_pmdn_d[l_ac].pmdn207
       
    #計算單身日結/月結 銷量欄位
    CALL apmt840_get_sale(g_pmdn_d[l_ac].pmdn205,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
       RETURNING g_pmdn_d[l_ac].pmdn208,g_pmdn_d[l_ac].pmdn209,g_pmdn_d[l_ac].pmdn210,g_pmdn_d[l_ac].pmdn211,  #160120-00001#5 160121 By pomelo add pmdn208
                 g_pmdn_d[l_ac].pmdn212,g_pmdn_d[l_ac].pmdn213
    
    #品類編號 #151202-00010#2 s983961--add(s)
    SELECT imaa009,rtaxl003 INTO g_pmdn_d[l_ac].pmdn228,g_pmdn_d[l_ac].pmdn228_desc
      FROM imaa_t
      LEFT OUTER JOIN rtaxl_t ON rtaxlent = g_enterprise AND rtaxl001 = imaa009 AND rtaxl002 = g_dlang
     WHERE imaaent = g_enterprise
       AND imaa001 = g_pmdn_d[l_ac].pmdn001
    #151202-00010#2 s983961--add(e)

    LET g_pmdn_d_o.* = g_pmdn_d[l_ac].*
    
    RETURN r_success   #150930-00013#1 Add By Ken 151005 
END FUNCTION

################################################################################
# Descriptions...: 結算方式
# Memo...........:
# Usage..........: CALL apmt840_pmdn217_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/27 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdn217_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdn_d[l_ac].pmdn217
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdn_d[l_ac].pmdn217_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_pmdn_d[l_ac].pmdn217_desc
END FUNCTION

################################################################################
# Descriptions...: 單位間的轉換數量
# Memo...........: 當銷售數量為空，由包裝數量轉換成銷售數量及計價數量及參考數量
#                : 當銷售數量有值，由銷售數量轉換成包裝數量及計價數量及參考數量
# Usage..........: CALL apmt840_num_change()
# Input parameter: 無
# Return code....: r_success  True/False
# Date & Author..: 2014/11/28 By pomelo
# Modify.........: 2015/09/07 By sakura 新增回傳值
################################################################################
PUBLIC FUNCTION apmt840_num_change()
DEFINE r_success        LIKE type_t.num5   #150903-00007#1 150903 by sakura add
DEFINE l_success        LIKE type_t.num5

    LET r_success = TRUE   #150903-00007#1 150903 by sakura add
    #當包裝單位或銷售單位都為空，表示無法轉換
    IF cl_null(g_pmdn_d[l_ac].pmdn201) OR cl_null(g_pmdn_d[l_ac].pmdn006) THEN
       #150903-00007#1 150903 by sakura mark&add(S)
       #RETURN
       RETURN r_success
       #150903-00007#1 150903 by sakura mark&add(S)
    END IF
    
    #當銷售數量為空
    IF cl_null(g_pmdn_d[l_ac].pmdn007) THEN
       #當包裝數量為空
       IF cl_null(g_pmdn_d[l_ac].pmdn202) THEN
          #150903-00007#1 150903 by sakura mark&add(S)
          #RETURN
          RETURN r_success
          #150903-00007#1 150903 by sakura mark&add(S)
       ELSE
          #當銷售數量為空，由包裝數量轉換成銷售數量
          CALL s_aooi250_convert_qty(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn201,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn202)
             RETURNING l_success,g_pmdn_d[l_ac].pmdn007
          #150903-00007#1 150903 by sakura add(S)
          IF l_success = FALSE THEN         
             LET r_success = FALSE
             RETURN r_success
          END IF
          #150903-00007#1 150903 by sakura add(E)             
       END IF
    ELSE
       #當銷售數量有值，由銷售數量轉換成包裝數量
       CALL s_aooi250_convert_qty(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn201,g_pmdn_d[l_ac].pmdn007)
          RETURNING l_success,g_pmdn_d[l_ac].pmdn202
       #150903-00007#1 150903 by sakura add(S)
       IF l_success = FALSE THEN           
          LET r_success = FALSE
          RETURN r_success
       END IF
       #150903-00007#1 150903 by sakura add(E)       
    END IF
    
    #計算參考數量
    IF NOT cl_null(g_pmdn_d[l_ac].pmdn008) THEN
       CALL s_aooi250_convert_qty(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn008,g_pmdn_d[l_ac].pmdn007)
          RETURNING l_success,g_pmdn_d[l_ac].pmdn009
       #150903-00007#1 150903 by sakura add(S)
       IF l_success = FALSE THEN         
          LET r_success = FALSE
          RETURN r_success
       END IF
       #150903-00007#1 150903 by sakura add(E)       
    END IF
    
    #計算計價數量
    IF NOT cl_null(g_pmdn_d[l_ac].pmdn010) THEN
       CALL s_aooi250_convert_qty(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn010,g_pmdn_d[l_ac].pmdn007)
          RETURNING l_success,g_pmdn_d[l_ac].pmdn011
       #150903-00007#1 150903 by sakura add(S)
       IF l_success = FALSE THEN        
          LET r_success = FALSE
          RETURN r_success
       END IF
       #150903-00007#1 150903 by sakura add(E)          
    END IF
    
    RETURN r_success #150903-00007#1 150903 by sakura add r_success
END FUNCTION
################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL apmt840_get_imaa005(p_imaa001)
#                     RETURNING r_imaa005
# Input parameter: p_imaa001      商品編號
# Return code....: r_imaa005      特徵類別
# Date & Author..: 2014/11/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_get_imaa005(p_imaa001)
DEFINE p_imaa001      LIKE imaa_t.imaa001
DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005   
   
END FUNCTION

################################################################################
# Descriptions...: 單身收貨組織確認預設單頭採購組織時，是否屬於物流組織
# Memo...........:
# Usage..........: CALL apmt840_chk_pmdnunit()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/11/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_chk_pmdnunit()
DEFINE r_success            LIKE type_t.num5
DEFINE l_cnt                LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(ooef001) INTO l_cnt
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_pmdl_m.pmdlsite
      AND ooef211 = 'Y'
      
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      RETURN r_success
   END IF
END FUNCTION

################################################################################
# Descriptions...: 預設收貨庫位
# Memo...........:
# Usage..........: CALL apmt840_pmdn028_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdn028_default()
DEFINE l_ooef001        LIKE ooef_t.ooef001

   #有可能改商品條碼，可是是同一個商品編號
   IF g_pmdn_d[l_ac].pmdn001 != g_pmdn_d_o.pmdn001 OR
      cl_null(g_pmdn_d_o.pmdn001) THEN
      LET l_ooef001 = ''
      IF g_pmdl_m.pmdl203 = '3' THEN
         LET l_ooef001 = g_pmdn_d[l_ac].pmdn223
      ELSE
         LET l_ooef001 = g_pmdn_d[l_ac].pmdn222
      END IF
      
      CALL s_apmi830_inv_scope_def(g_pmdn_d[l_ac].pmdnunit,g_pmdn_d[l_ac].pmdn001,g_pmdl_m.pmdl203,l_ooef001)
         RETURNING g_pmdn_d[l_ac].pmdn028
         
      CALL s_desc_get_stock_desc('',g_pmdn_d[l_ac].pmdn028)
         RETURNING g_pmdn_d[l_ac].pmdn028_desc
   END IF
END FUNCTION

################################################################################
# Descriptions...: 計算單身日結/月結 銷量欄位
# Memo...........:
# Usage..........: CALL apmt840_get_sale(p_pmdn205,p_pmdn001,p_pmdn002)
#                :    RETURNING r_pmdn.pmdn208,r_pmdn.pmdn209,r_pmdn.pmdn210,r_pmdn.pmdn211,r_pmdn.pmdn212,r_pmdn.pmdn213
# Input parameter: p_pmdn205          要貨組織
#                : p_pmdn001          商品編號
#                : p_pmdn002          產品特徵
# Return code....: r_pmdn.pmdn208     前日銷售量
#                : r_pmdn.pmdn209     上月銷售量
#                : r_pmdn.pmdn210     第一周銷量
#                : r_pmdn.pmdn211     第二周銷量
#                : r_pmdn.pmdn212     第三周銷量
#                : r_pmdn.pmdn213     第四周銷量
# Date & Author..: 2014/11/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_get_sale(p_pmdn205,p_pmdn001,p_pmdn002)
DEFINE p_pmdn205            LIKE pmdn_t.pmdn205
DEFINE p_pmdn001            LIKE pmdn_t.pmdn001
DEFINE p_pmdn002            LIKE pmdn_t.pmdn002
DEFINE r_pmdn               RECORD
       pmdn208              LIKE pmdn_t.pmdn208,    #前日銷售量
       pmdn209              LIKE pmdn_t.pmdn209,    #上月銷售量
       pmdn210              LIKE pmdn_t.pmdn210,    #第一周銷量
       pmdn211              LIKE pmdn_t.pmdn211,    #第二周銷量
       pmdn212              LIKE pmdn_t.pmdn212,    #第三周銷量
       pmdn213              LIKE pmdn_t.pmdn213     #第四周銷量
                            END RECORD
                            
   INITIALIZE r_pmdn.* TO NULL
   
   #前日銷售量
   CALL s_daily_sale(p_pmdn205,g_pmdl_m.pmdldocdt,1,1,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn.pmdn208
   
   #上月銷售量
   CALL s_monthly_sale(p_pmdn205,g_pmdl_m.pmdldocdt,1,1,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn.pmdn209
   
   #第一週銷量
   CALL s_daily_sale(p_pmdn205,g_pmdl_m.pmdldocdt,1,7,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn.pmdn210
      
   #第二週銷量
   CALL s_daily_sale(p_pmdn205,g_pmdl_m.pmdldocdt,8,14,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn.pmdn211
      
   #第三週銷量
   CALL s_daily_sale(p_pmdn205,g_pmdl_m.pmdldocdt,15,21,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn.pmdn212
      
   #第四週銷量
   CALL s_daily_sale(p_pmdn205,g_pmdl_m.pmdldocdt,22,28,p_pmdn001,g_pmdn_d[l_ac].pmdn002)
      RETURNING r_pmdn.pmdn213
      
   RETURN r_pmdn.pmdn208,r_pmdn.pmdn209,r_pmdn.pmdn210,r_pmdn.pmdn211,r_pmdn.pmdn212,r_pmdn.pmdn213 #160120-00001#5 160121 By pomelo add pmdn208
END FUNCTION

################################################################################
# Descriptions...: 取理由碼 SCC
# Memo...........:
# Usage..........: CALL apmt840_get_gzcb004()
#                    RETURNING r_gzcb004
# Input parameter: 無
# Return code....: r_gzcb004      SCC代碼
# Date & Author..: 2014/11/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_get_gzcb004()
DEFINE r_gzcb004        LIKE gzcb_t.gzcb004

   LET r_gzcb004 = ''
   #160816-00001#9  2016/08/17  By 08734 Mark 
  # SELECT gzcb004 INTO r_gzcb004
  #   FROM gzcb_t
  #  WHERE gzcb001 = '24'
  #    AND gzcb002 = g_prog
   LET r_gzcb004 = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#9  2016/08/17  By 08734 add    
   RETURN r_gzcb004
END FUNCTION

################################################################################
# Descriptions...: 到庫日期影響其他欄位值
# Memo...........:
# Usage..........: CALL apmt840_pmdn014_value(p_pmdn014,p_rtka010,p_pmdn020)
# Input parameter: p_pmdn014     推算出來的到庫日期
#                : p_rtka010     訂單有效期
#                : p_pmdn020     緊急度
# Return code....: 無
# Date & Author..: 2014/11/30 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdn014_value(p_pmdn014,p_rtka010,p_pmdn020)
DEFINE p_pmdn014        LIKE pmdn_t.pmdn014
DEFINE p_rtka010        LIKE rtka_t.rtka010
DEFINE p_pmdn020        LIKE pmdn_t.pmdn020

   #判斷緊急度
   #150324-00006#16 2015/04/30 By pomelo add(S)
   IF s_apmt840_get_pmdb033(g_pmdl_m.pmdldocno,g_pmdn_d[g_detail_idx].pmdnseq) THEN
   #150324-00006#16 2015/04/30 By pomelo add(E)
      IF cl_null(p_pmdn020) THEN
         IF p_pmdn014 < g_today THEN
            LET g_pmdn_d[l_ac].pmdn020 = '2'
         ELSE
            LET g_pmdn_d[l_ac].pmdn020 = '1'
         END IF
      ELSE
         #當多交期 = 'Y' AND 多期維護裡面有一筆是為2.緊急
         #且原本此項次的緊急度為1.一般，必須將此項次的緊急度改為2.緊急
         IF g_pmdn_d[l_ac].pmdn020 = '1' AND p_pmdn020 = '2' THEN
            LET g_pmdn_d[l_ac].pmdn020 = '2'
         END IF
      END IF
   END IF   #150324-00006#16 2015/04/30 By pomelo add
   
   #到廠日期，交貨日期 = 到庫日期
   LET g_pmdn_d[l_ac].pmdn012 = g_pmdn_d[l_ac].pmdn014
   LET g_pmdn_d[l_ac].pmdn013 = g_pmdn_d[l_ac].pmdn014
   #採購失效日(到庫日期+訂單有效期)
   #LET g_pmdn_d[l_ac].pmdn224 = g_pmdn_d[l_ac].pmdn014 + p_rtka010  #150407-00020#1 Mark By Ken 150410
END FUNCTION

################################################################################
# Descriptions...: 計算可用庫存量 跟 採購在途量
# Memo...........:
# Usage..........: CALL apmt840_get_sum(p_pmdnunit,p_pmdn001,p_pmdn002)
#                     RETURNING r_pmdn206,r_pmdn207
# Input parameter: p_pmdnunit        收貨組織
#                : p_pmdn001         商品編號
#                : p_pmdn002         產品特徵
# Return code....: r_pmdn206         可用庫存量
#                : r_pmdn207         採購在途量
# Date & Author..: 2014/11/30 By pomelo
# Modify.........: 2015/04/15 By sakura 採購在途量新增傳入參數產品特徵(pmdn002)
################################################################################
PUBLIC FUNCTION apmt840_get_sum(p_pmdnunit,p_pmdn001,p_pmdn002)
DEFINE p_pmdnunit       LIKE pmdn_t.pmdnunit
DEFINE p_pmdn001        LIKE pmdn_t.pmdn001
DEFINE p_pmdn002        LIKE pmdn_t.pmdn002
DEFINE r_pmdn206        LIKE pmdn_t.pmdn206
DEFINE r_pmdn207        LIKE pmdn_t.pmdn207

   LET r_pmdn206 = 0
   LET r_pmdn207 = 0
   
   #可用庫存量
   CALL s_apmt840_sum_inag008(p_pmdnunit,p_pmdn001,p_pmdn002)
      RETURNING r_pmdn206
      
   #採購在途量
   CALL s_apmt840_sum_in_way(p_pmdnunit,p_pmdn001,p_pmdn002) #sakura add 150413-00018#1 pmdn002
      RETURNING r_pmdn207
   
   RETURN r_pmdn206,r_pmdn207   
END FUNCTION
#維護多長期預付款單身
PRIVATE FUNCTION apmt840_open_pmdm()
DEFINE  l_cmd           LIKE type_t.chr1
DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT 
DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
DEFINE  l_count         LIKE type_t.num5
DEFINE  l_i             LIKE type_t.num5
DEFINE  l_insert        BOOLEAN
DEFINE  ls_return       STRING
DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
DEFINE  l_vars          DYNAMIC ARRAY OF STRING
DEFINE  l_fields        DYNAMIC ARRAY OF STRING
DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
DEFINE  l_pmdm005       LIKE pmdm_t.pmdm005
DEFINE  l_pmdm006       LIKE pmdm_t.pmdm006
DEFINE  l_forupd_sql    STRING
DEFINE  l_pmdl040       LIKE pmdl_t.pmdl040
DEFINE  l_pmdl041       LIKE pmdl_t.pmdl041
DEFINE  l_oodbl004      LIKE oodbl_t.oodbl004  #稅別名稱
DEFINE  l_oodb005       LIKE oodb_t.oodb005    #含稅否
DEFINE  l_oodb006       LIKE oodb_t.oodb006    #稅率
DEFINE  l_oodb011       LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定
DEFINE  l_success       LIKE type_t.num5
DEFINE  l_sql           STRING

   IF g_pmdl_m.pmdldocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   SELECT UNIQUE pmdlsite, pmdldocdt,pmdldocno,pmdl001,  pmdl005,
                 pmdl200,  pmdl004,  pmdl203,  pmdl002,  pmdl003,
                 pmdlstus, pmdl007,  pmdl008,  pmdl027,  pmdl201,
                 pmdl202,  pmdl204,  pmdlunit, pmdl029,  pmdl025,
                 pmdl023,  pmdl022,  pmdl021,  pmdl043,  pmdl020,
                 pmdl044,  pmdl054,  pmdl055,  pmdl009,  pmdl015,
                 pmdl016,  pmdl010,  pmdl011,  pmdl012,  pmdl013,
                 pmdl033,  pmdl024,  pmdl028,  pmdl042,  pmdl047,
                 pmdl048,  pmdl049,  pmdl046,  pmdl040,  pmdl041,
                 pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,
                 pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt
     INTO g_pmdl_m.pmdlsite, g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,  g_pmdl_m.pmdl005,
          g_pmdl_m.pmdl200,  g_pmdl_m.pmdl004,  g_pmdl_m.pmdl203,  g_pmdl_m.pmdl002,  g_pmdl_m.pmdl003,
          g_pmdl_m.pmdlstus, g_pmdl_m.pmdl007,  g_pmdl_m.pmdl008,  g_pmdl_m.pmdl027,  g_pmdl_m.pmdl201,
          g_pmdl_m.pmdl202,  g_pmdl_m.pmdl204,  g_pmdl_m.pmdlunit, g_pmdl_m.pmdl029,  g_pmdl_m.pmdl025,
          g_pmdl_m.pmdl023,  g_pmdl_m.pmdl022,  g_pmdl_m.pmdl021,  g_pmdl_m.pmdl043,  g_pmdl_m.pmdl020,
          g_pmdl_m.pmdl044,  g_pmdl_m.pmdl054,  g_pmdl_m.pmdl055,  g_pmdl_m.pmdl009,  g_pmdl_m.pmdl015,
          g_pmdl_m.pmdl016,  g_pmdl_m.pmdl010,  g_pmdl_m.pmdl011,  g_pmdl_m.pmdl012,  g_pmdl_m.pmdl013,
          g_pmdl_m.pmdl033,  g_pmdl_m.pmdl024,  g_pmdl_m.pmdl028,  g_pmdl_m.pmdl042,  g_pmdl_m.pmdl047,
          g_pmdl_m.pmdl048,  g_pmdl_m.pmdl049,  g_pmdl_m.pmdl046,  g_pmdl_m.pmdl040,  g_pmdl_m.pmdl041,
          g_pmdl_m.pmdlownid,g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,
          g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdl_m.pmdldocno

   LET l_pmdl040 = g_pmdl_m.pmdl040
   LET l_pmdl041 = g_pmdl_m.pmdl041
    
   IF cl_null(l_pmdl040) THEN
      LET l_pmdl040 = 0
   END IF
   IF cl_null(l_pmdl041) THEN
      LET l_pmdl041 = 0
   END IF
   
   ERROR ""
  
   LET l_sql = "SELECT COALESCE(SUM(pmdm005),0),COALESCE(SUM(pmdm006),0)",
               "  FROM pmdm_t",
               " WHERE pmdment = ",g_enterprise,
               "   AND pmdmdocno = '",g_pmdl_m.pmdldocno,"'",
               "   AND COALESCE(pmdm001,-1) != COALESCE(?,-1)"
   PREPARE apmt840_sum_pmdm FROM l_sql
  
   CALL s_transaction_begin()
   
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt840_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #鎖住將被更改的資料
   #150707-00029#1 20150803 mark by beckxie ---S
#   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
#       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
#       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
#       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025, 
#       g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,g_pmdl_m.pmdl043,g_pmdl_m.pmdl020, 
#       g_pmdl_m.pmdl044,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
#       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
#       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl047,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049, 
#       g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid, 
#       g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
#       g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc, 
#       g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc, 
#       g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc, 
#       g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc,g_pmdl_m.pmdlownid_desc, 
#       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc, 
#       g_pmdl_m.pmdlcnfid_desc
   #150707-00029#1 20150803 mark by beckxie ---E
   #150707-00029#1 20150803 add  by beckxie ---S
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   #150707-00029#1 20150803 add by beckxie ---E
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_pmdl_m.pmdldocno 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   
   CALL apmt840_show()  
   
   LET g_forupd_sql = "SELECT pmdmsite,pmdm001,pmdm014,pmdm002,pmdm003,",
                      "       pmdm004, pmdm005,pmdm006,pmdm007,pmdm008,",
                      "       pmdm009",
                      "  FROM pmdm_t",
                      " WHERE pmdment = ?",
                      "   AND pmdmdocno=?",
                      "   AND pmdm001 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apmt840_bcl6 CURSOR FROM g_forupd_sql

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   DISPLAY BY NAME g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt,g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005, 
       g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203,g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus, 
       g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027,g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204, 
       g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009, 
       g_pmdl_m.pmdl015,g_pmdl_m.pmdl016,g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013, 
       g_pmdl_m.pmdl033,g_pmdl_m.pmdl024,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl047,g_pmdl_m.pmdl048, 
       g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041

   CALL apmt840_set_entry('u')
   CALL apmt840_set_no_required()
   CALL apmt840_set_required()
   CALL apmt840_set_no_entry('u')
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_pmdl_m.pmdl046 ATTRIBUTE(WITHOUT DEFAULTS)
      
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            UPDATE pmdl_t
               SET pmdl046 = g_pmdl_m.pmdl046 
             WHERE pmdlent = g_enterprise
               AND pmdldocno = g_pmdl_m.pmdldocno
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "pmdl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               OTHERWISE
                  CALL s_transaction_end('Y','0')
            END CASE
            
      END INPUT
      
      INPUT ARRAY g_pmdn6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdn6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF
            CALL apmt840_b_fill()
            LET g_rec_b = g_pmdn6_d.getLength()
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmdn6_d[l_ac].* TO NULL 
            
            LET g_pmdn6_d[l_ac].pmdmsite = g_pmdl_m.pmdlsite
            SELECT MAX(pmdm001)+1 INTO g_pmdn6_d[l_ac].pmdm001
              FROM pmdm_t
              WHERE pmdment = g_enterprise
                AND pmdmdocno = g_pmdl_m.pmdldocno
            IF cl_null(g_pmdn6_d[l_ac].pmdm001) OR g_pmdn6_d[l_ac].pmdm001 = 0 THEN
               LET g_pmdn6_d[l_ac].pmdm001 = 1
            END IF
            
            LET g_pmdn6_d_t.* = g_pmdn6_d[l_ac].*     #新輸入資料
            LET g_pmdn6_d_o.* = g_pmdn6_d[l_ac].*
            CALL cl_show_fld_cont()
            CALL apmt840_set_entry_b(l_cmd)
            CALL apmt840_set_no_entry_b(l_cmd)
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
           
            CALL s_transaction_begin()
            
            LET g_rec_b = g_pmdn6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdn6_d[l_ac].pmdm001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pmdn6_d_t.* = g_pmdn6_d[l_ac].*  #BACKUP
               LET g_pmdn6_d_o.* = g_pmdn6_d[l_ac].*
               CALL apmt840_set_entry_b(l_cmd)
               CALL apmt840_set_no_entry_b(l_cmd)
               
               OPEN apmt840_bcl6 USING g_enterprise,g_pmdl_m.pmdldocno,g_pmdn6_d[l_ac].pmdm001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmt840_bcl6"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt840_bcl6 INTO g_pmdn6_d[l_ac].pmdmsite,g_pmdn6_d[l_ac].pmdm001,
                                          g_pmdn6_d[l_ac].pmdm014, g_pmdn6_d[l_ac].pmdm002,
                                          g_pmdn6_d[l_ac].pmdm003, g_pmdn6_d[l_ac].pmdm004,
                                          g_pmdn6_d[l_ac].pmdm005, g_pmdn6_d[l_ac].pmdm006,
                                          g_pmdn6_d[l_ac].pmdm007, g_pmdn6_d[l_ac].pmdm008,
                                          g_pmdn6_d[l_ac].pmdm009
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  #付款條件
                  CALL s_desc_get_ooib002_desc(g_pmdn6_d[l_ac].pmdm002)
                     RETURNING g_pmdn6_d[l_ac].pmdm002_desc
                  DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc
                  
                  LET g_bfill = "N"
                  CALL apmt840_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pmdn6_d.deleteElement(l_ac)
               NEXT FIELD pmdm001
            END IF
         
            IF g_pmdn6_d[l_ac].pmdm001 IS NOT NULL
            THEN
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
               
               DELETE FROM pmdm_t
                WHERE pmdment = g_enterprise
                  AND pmdmdocno = g_pmdl_m.pmdldocno
                  AND pmdm001 = g_pmdn6_d_t.pmdm001

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdn_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1

                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apmt840_bcl6
               LET l_count = g_pmdn_d.getLength()
            END IF 

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
            SELECT COUNT(*) INTO l_count
              FROM pmdm_t 
             WHERE pmdment = g_enterprise
               AND pmdmdocno = g_pmdl_m.pmdldocno
               AND pmdm001 = g_pmdn6_d[l_ac].pmdm001
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmdm_t
                  (pmdment,pmdmdocno,pmdm001,pmdmsite,pmdm002,
                   pmdm003,pmdm004,  pmdm005,pmdm006, pmdm007,
                   pmdm008,pmdm009,  pmdm014) 
                 VALUES(g_enterprise,g_pmdl_m.pmdldocno,g_pmdn6_d[l_ac].pmdm001,
                   g_pmdn6_d[l_ac].pmdmsite,g_pmdn6_d[l_ac].pmdm002,g_pmdn6_d[l_ac].pmdm003, 
                   g_pmdn6_d[l_ac].pmdm004, g_pmdn6_d[l_ac].pmdm005,g_pmdn6_d[l_ac].pmdm006, 
                   g_pmdn6_d[l_ac].pmdm007, g_pmdn6_d[l_ac].pmdm008,g_pmdn6_d[l_ac].pmdm009,
                   g_pmdn6_d[l_ac].pmdm014) 

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmdm_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmdn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            
            CALL s_transaction_end('Y','0')
            ERROR 'INSERT O.K'
            LET g_rec_b = g_rec_b + 1
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmdn6_d[l_ac].* = g_pmdn6_d_t.*
               CLOSE apmt840_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmdn6_d[l_ac].* = g_pmdn6_d_t.*
            ELSE
               UPDATE pmdm_t SET (pmdmdocno,pmdmsite,pmdm001,
                                  pmdm002,  pmdm003, pmdm004,
                                  pmdm005,  pmdm006, pmdm007,
                                  pmdm008,  pmdm009, pmdm014)
                               = (g_pmdl_m.pmdldocno,g_pmdn6_d[l_ac].pmdmsite,g_pmdn6_d[l_ac].pmdm001,
                                  g_pmdn6_d[l_ac].pmdm002,g_pmdn6_d[l_ac].pmdm003,g_pmdn6_d[l_ac].pmdm004,
                                  g_pmdn6_d[l_ac].pmdm005,g_pmdn6_d[l_ac].pmdm006,g_pmdn6_d[l_ac].pmdm007,
                                  g_pmdn6_d[l_ac].pmdm008,g_pmdn6_d[l_ac].pmdm009,g_pmdn6_d[l_ac].pmdm014) #自訂欄位頁簽
                WHERE pmdment = g_enterprise AND pmdmdocno = g_pmdl_m.pmdldocno
                  AND pmdm001 = g_pmdn6_d_t.pmdm001 #項次                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pmdm_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_pmdn6_d[l_ac].* = g_pmdn6_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdm_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_pmdn6_d[l_ac].* = g_pmdn6_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_pmdl_m.pmdldocno
                     LET gs_keys_bak[1] = g_pmdldocno_t
                     LET gs_keys[2] = g_pmdn6_d[g_detail_idx].pmdm001
                     LET gs_keys_bak[2] = g_pmdn6_d_t.pmdm001
                     CALL apmt840_update_b('pmdm_t',gs_keys,gs_keys_bak,"'5'")
                     #資料多語言用-增/改
                     
               END CASE
            END IF
         
         #---------------------<  Detail: page5  >---------------------
         #----<<pmdm001>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmdm001
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmdn6_d[l_ac].pmdm001,"0.000","0","","","azz-00079",1) THEN
               LET g_pmdn6_d[l_ac].pmdm001 = g_pmdn6_d_t.pmdm001
               NEXT FIELD pmdm001
            END IF

            #此段落由子樣板a05產生
            IF  g_pmdl_m.pmdldocno IS NOT NULL AND g_pmdn6_d[l_ac].pmdm001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdl_m.pmdldocno != g_pmdldocno_t OR g_pmdn6_d[l_ac].pmdm001 != g_pmdn6_d_t.pmdm001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdm_t WHERE "||"pmdment = '" ||g_enterprise|| "' AND "||"pmdmdocno = '"||g_pmdl_m.pmdldocno ||"' AND "|| "pmdm001 = '"||g_pmdn6_d[l_ac].pmdm001 ||"'",'std-00004',0) THEN 
                     LET g_pmdn6_d[l_ac].pmdm001 = g_pmdn6_d_t.pmdm001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         #----<<pmdm002>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmdm002
            LET g_pmdn6_d[l_ac].pmdm002_desc = ''
            DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc
            IF NOT cl_null(g_pmdn6_d[l_ac].pmdm002) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdn6_d[l_ac].pmdm002 != g_pmdn6_d_t.pmdm002 OR g_pmdn6_d_t.pmdm002 IS NULL )) THEN   #160824-00007#12 20160914 add by beckxie
               IF g_pmdn6_d[l_ac].pmdm002 != g_pmdn6_d_o.pmdm002 OR cl_null(g_pmdn6_d_o.pmdm002) THEN   #160824-00007#12 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdl_m.pmdl004
                  LET g_chkparam.arg2 = g_pmdn6_d[l_ac].pmdm002
                  IF NOT cl_chk_exist("v_pmad002_1") THEN
                     #LET g_pmdn6_d[l_ac].pmdm002 = g_pmdn6_d_t.pmdm002   #160824-00007#12 20160914 mark by beckxie
                     LET g_pmdn6_d[l_ac].pmdm002 = g_pmdn6_d_o.pmdm002    #160824-00007#12 20160914 add by beckxie
                     CALL s_desc_get_ooib002_desc(g_pmdn6_d[l_ac].pmdm002)
                        RETURNING g_pmdn6_d[l_ac].pmdm002_desc
                     DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdn6_d_o.pmdm002 = g_pmdn6_d[l_ac].pmdm002    #160824-00007#12 20160914 add by beckxie
            CALL s_desc_get_ooib002_desc(g_pmdn6_d[l_ac].pmdm002)
               RETURNING g_pmdn6_d[l_ac].pmdm002_desc
            DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc

         AFTER FIELD pmdm004
            IF g_pmdn6_d[l_ac].pmdm003 > g_pmdn6_d[l_ac].pmdm004 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00080'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            
         AFTER FIELD pmdm005
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmdn6_d[l_ac].pmdm005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdm005
            END IF
            IF NOT cl_null(g_pmdn6_d[l_ac].pmdm005) THEN
               IF g_pmdn6_d[l_ac].pmdm005 != g_pmdn6_d_o.pmdm005 OR cl_null(g_pmdn6_d_o.pmdm005) THEN            
                  
                  #多帳期預付款金額加總不可超過整張採購單總採購金額(含未稅金額均不能超過)
                  LET l_pmdm005 = 0
                  LET l_pmdm006 = 0
                  EXECUTE apmt840_sum_pmdm USING g_pmdn6_d_t.pmdm001
                    INTO l_pmdm005,l_pmdm006
                  IF l_pmdm005 + g_pmdn6_d[l_ac].pmdm005 > l_pmdl040 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00263'
                     LET g_errparam.extend = g_pmdl_m.pmdldocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdn6_d[l_ac].pmdm005 = g_pmdn6_d_o.pmdm005
                     NEXT FIELD pmdm005
                  END IF
                  #稅率依單頭需未稅金額自動推算含稅金額
                  CALL s_tax_get_xrcd105(g_pmdn6_d[l_ac].pmdm005,g_pmdl_m.pmdl012,g_pmdl_m.pmdl015)
                     RETURNING g_pmdn6_d[l_ac].pmdm006
                  IF l_pmdm006 + g_pmdn6_d[l_ac].pmdm006 >= l_pmdl041 THEN
                     LET g_pmdn6_d[l_ac].pmdm006 = l_pmdl041 - l_pmdm006
                  END IF
               END IF
               
            END IF
            LET g_pmdn6_d_o.pmdm005 = g_pmdn6_d[l_ac].pmdm005
            LET g_pmdn6_d_o.pmdm006 = g_pmdn6_d[l_ac].pmdm006

         AFTER FIELD pmdm006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmdn6_d[l_ac].pmdm006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdm006
            END IF
            IF NOT cl_null(g_pmdn6_d[l_ac].pmdm006) THEN
               IF g_pmdn6_d[l_ac].pmdm006 != g_pmdn6_d_o.pmdm006 OR cl_null(g_pmdn6_d_o.pmdm006) THEN
                  LET l_pmdm005 = 0
                  LET l_pmdm006 = 0
                  EXECUTE apmt840_sum_pmdm USING g_pmdn6_d_t.pmdm001
                    INTO l_pmdm005,l_pmdm006
                  IF l_pmdm006 + g_pmdn6_d[l_ac].pmdm006 > l_pmdl041 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00264'
                     LET g_errparam.extend = g_pmdl_m.pmdldocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdn6_d[l_ac].pmdm006 = g_pmdn6_d_o.pmdm006
                     NEXT FIELD pmdm006
                  END IF
                  #稅率依單頭需含稅金額自動推算未稅金額
                  CALL s_tax_get_xrcd103(g_pmdn6_d[l_ac].pmdm006,g_pmdl_m.pmdl012,g_pmdl_m.pmdl015)
                     RETURNING g_pmdn6_d[l_ac].pmdm005
                  IF l_pmdm005 + g_pmdn6_d[l_ac].pmdm005 >= l_pmdl040 THEN
                     LET g_pmdn6_d[l_ac].pmdm005 = l_pmdl040 - l_pmdm005
                  END IF
                END IF
            END IF  
            LET g_pmdn6_d_o.pmdm005 = g_pmdn6_d[l_ac].pmdm005
            LET g_pmdn6_d_o.pmdm006 = g_pmdn6_d[l_ac].pmdm006

         #---------------------<  Detail: page5  >---------------------
         #----<<pmdm002>>----
         #Ctrlp:input.c.page5.pmdm002
         ON ACTION controlp INFIELD pmdm002
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdn6_d[l_ac].pmdm002 
            
            #給予arg
            LET g_qryparam.arg1 = g_pmdl_m.pmdl004
            CALL q_pmad002_2()
            LET g_pmdn6_d[l_ac].pmdm002 = g_qryparam.return1
            DISPLAY g_pmdn6_d[l_ac].pmdm002 TO pmdm002
            CALL s_desc_get_ooib002_desc(g_pmdn6_d[l_ac].pmdm002)
               RETURNING g_pmdn6_d[l_ac].pmdm002_desc
            DISPLAY BY NAME g_pmdn6_d[l_ac].pmdm002_desc
            NEXT FIELD pmdm002
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmdn6_d[l_ac].* = g_pmdn6_d_t.*
               END IF
               CLOSE apmt840_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #多帳期預付款金額加總不可超過整張採購單總採購金額(含未稅金額均不能超過)
            LET l_pmdm005 = 0
            LET l_pmdm006 = 0
            SELECT COALESCE(SUM(pmdm005),0) INTO l_pmdm005
              FROM pmdm_t 
             WHERE pmdment = g_enterprise
               AND pmdmdocno = g_pmdl_m.pmdldocno
            SELECT COALESCE(SUM(pmdm006),0) INTO l_pmdm006
              FROM pmdm_t 
             WHERE pmdment = g_enterprise
               AND pmdmdocno = g_pmdl_m.pmdldocno
               
            IF l_pmdm005 > g_pmdl_m.pmdl040 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00263'
               LET g_errparam.extend = g_pmdl_m.pmdldocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               LET g_pmdn6_d[l_ac].pmdm005 = g_pmdn6_d_t.pmdm005
               NEXT FIELD pmdm005
            END IF
            IF l_pmdm006 > g_pmdl_m.pmdl041 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00264'
               LET g_errparam.extend = g_pmdl_m.pmdldocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0') 
               LET g_pmdn6_d[l_ac].pmdm006 = g_pmdn6_d_t.pmdm006
               NEXT FIELD pmdm006
            END IF
            
            #其他table進行unlock
            CLOSE apmt840_bcl6
            CALL s_transaction_end('Y','0')  
            
         AFTER INPUT
            #多帳期預付款金額加總不可超過整張採購單總採購金額(含未稅金額均不能超過)
            LET l_pmdm005 = 0
            LET l_pmdm006 = 0
            EXECUTE apmt840_sum_pmdm USING '-1'
               INTO l_pmdm005,l_pmdm006
            IF l_pmdm005 > g_pmdl_m.pmdl040 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00587'
               LET g_errparam.extend = g_pmdl_m.pmdldocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmdn6_d[l_ac].pmdm005 = g_pmdn6_d_t.pmdm005
               NEXT FIELD pmdm005
            END IF
            IF l_pmdm006 > g_pmdl_m.pmdl041 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00588'
               LET g_errparam.extend = g_pmdl_m.pmdldocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmdn6_d[l_ac].pmdm006 = g_pmdn6_d_t.pmdm006
               NEXT FIELD pmdm006
            END IF
      END INPUT
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
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
   CLOSE apmt840_cl
   LET INT_FLAG = FALSE
            
END FUNCTION

################################################################################
# Descriptions...: 採購關聯單據明細檔
# Memo...........:
# Usage..........: CALL apmt840_show_pmdp(p_pmdndocno,p_pmdnseq)
# Input parameter: p_pmdndocno    單據編號
#                : p_pmdnseq      項次
# Return code....: 無
# Date & Author..: 2014/11/30 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_show_pmdp(p_pmdndocno,p_pmdnseq)
DEFINE p_pmdndocno         LIKE pmdn_t.pmdndocno
DEFINE p_pmdnseq           LIKE pmdn_t.pmdnseq
DEFINE l_sql               STRING
DEFINE l_seq               LIKE type_t.num5
TYPE   type_l_pmdp         RECORD
       pmdpdocno           LIKE pmdp_t.pmdpdocno,   #採購單號
       pmdpseq             LIKE pmdp_t.pmdpseq,     #採購項次
       pmdpseq1            LIKE pmdp_t.pmdpseq1,    #項序
       pmdp001             LIKE pmdp_t.pmdp001,     #商品編號
       pmdp001_desc        LIKE imaal_t.imaal003,   #品名
       pmdp001_desc_desc   LIKE imaal_t.imaal004,   #規格
       pmdp002             LIKE pmdp_t.pmdp002,     #產品特徵
       pmdp003             LIKE pmdp_t.pmdp003,     #來源單號
       pmdp004             LIKE pmdp_t.pmdp004,     #來源項次
       pmdp005             LIKE pmdp_t.pmdp005,     #來源項序
       pmdp006             LIKE pmdp_t.pmdp006,     #來源分批序
       pmdp007             LIKE pmdp_t.pmdp007,     #來源商品
       pmdp008             LIKE pmdp_t.pmdp008,     #來源產品特徵
       pmdp009             LIKE pmdp_t.pmdp009,     #來源作業編號
       pmdp010             LIKE pmdp_t.pmdp010,     #製程序
       pmdp011             LIKE pmdp_t.pmdp011,     #來源BOM特性
       pmdp012             LIKE pmdp_t.pmdp012,     #來源生產控制組
       pmdp021             LIKE pmdp_t.pmdp021,     #沖銷順序
       pmdp022             LIKE pmdp_t.pmdp022,     #需求單位
       pmdp022_desc        LIKE oocal_t.oocal003,   #需求單位名稱
       pmdp023             LIKE pmdp_t.pmdp023,     #需求數量
       pmdp024             LIKE pmdp_t.pmdp024,     #折合採購量
       pmdp025             LIKE pmdp_t.pmdp025,     #已收貨量
       pmdp026             LIKE pmdp_t.pmdp026,     #已入庫量
       pmdpsite            LIKE pmdp_t.pmdpsite     #營運據點
                           END RECORD
DEFINE l_pmdp              DYNAMIC ARRAY OF type_l_pmdp
DEFINE l_rec_b             LIKE type_t.num5

   OPEN WINDOW w_apmt840_s01 WITH FORM cl_ap_formpath("apm","apmt840_s01")
   
   CALL l_pmdp.clear()
   LET l_sql = "SELECT pmdpdocno,pmdpseq, pmdpseq1,pmdp001,",
               "       imaal003, imaal004,pmdp002, pmdp003,",
               "       pmdp004,  pmdp005, pmdp006, pmdp007,",
               "       pmdp008,  pmdp009, pmdp010, pmdp011,",
               "       pmdp012,  pmdp021, pmdp022, oocal003,",
               "       pmdp023,  pmdp024, pmdp025, pmdp026,",
               "       pmdpsite",
               "  FROM pmdp_t",
               "  LEFT OUTER JOIN imaal_t ON imaalent = pmdpent AND imaal001 = pmdp001 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t ON oocalent = pmdpent AND oocal001 = pmdp022 AND oocal002 = '",g_dlang,"'",
               " WHERE pmdpent = ",g_enterprise,
               "   AND pmdpdocno = '",p_pmdndocno,"'"
   IF NOT cl_null(p_pmdnseq) THEN
      LET l_sql = l_sql,"   AND pmdpseq = '",p_pmdnseq,"'"
   END IF
   
   PREPARE apmt840_s01_pre FROM l_sql
   DECLARE apmt840_s01_cs CURSOR FOR apmt840_s01_pre
   
   LET l_seq = 1
   FOREACH apmt840_s01_cs INTO l_pmdp[l_seq].pmdpdocno,   l_pmdp[l_seq].pmdpseq,          l_pmdp[l_seq].pmdpseq1,l_pmdp[l_seq].pmdp001,
                               l_pmdp[l_seq].pmdp001_desc,l_pmdp[l_seq].pmdp001_desc_desc,l_pmdp[l_seq].pmdp002, l_pmdp[l_seq].pmdp003,
                               l_pmdp[l_seq].pmdp004,     l_pmdp[l_seq].pmdp005,          l_pmdp[l_seq].pmdp006, l_pmdp[l_seq].pmdp007,
                               l_pmdp[l_seq].pmdp008,     l_pmdp[l_seq].pmdp009,          l_pmdp[l_seq].pmdp010, l_pmdp[l_seq].pmdp011,
                               l_pmdp[l_seq].pmdp012,     l_pmdp[l_seq].pmdp021,          l_pmdp[l_seq].pmdp022, l_pmdp[l_seq].pmdp022_desc,
                               l_pmdp[l_seq].pmdp023,     l_pmdp[l_seq].pmdp024,          l_pmdp[l_seq].pmdp025, l_pmdp[l_seq].pmdp026,
                               l_pmdp[l_seq].pmdpsite
   
       IF l_seq > g_max_rec THEN
          IF g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = l_seq
             LET g_errparam.code   = 9035 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          END IF
          EXIT FOREACH
       END IF
       LET l_seq = l_seq + 1
   END FOREACH
   
   CALL l_pmdp.deleteElement(l_pmdp.getLength())
   
   DISPLAY ARRAY l_pmdp TO s_detail1.* ATTRIBUTES(COUNT=l_rec_b) 
       
   END DISPLAY
   CLOSE WINDOW w_apmt840_s01
END FUNCTION

################################################################################
# Descriptions...: 取的關聯單據的庫位
# Memo...........:
# Usage..........: CALL apmt840_get_pmdb038()
#                :    RETURNING r_pmdb038
# Input parameter: 無
# Return code....: r_pmdb038      庫位
# Date & Author..: 2014/12/03 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_get_pmdb038()
DEFINE r_pmdb038            LIKE pmdb_t.pmdb038

   LET r_pmdb038 = ''
   
   SELECT DISTINCT pmdb038 INTO r_pmdb038
     FROM pmdb_t,pmdp_t
    WHERE pmdbent = pmdpent
      AND pmdbdocno = pmdp003
      AND pmdbseq = pmdp004
      AND pmdbent = g_enterprise
      AND pmdbdocno = g_pmdl_m.pmdldocno
      AND pmdbseq = g_pmdn_d[l_ac].pmdnseq
   
   RETURN r_pmdb038
END FUNCTION

################################################################################
# Descriptions...: 輸入畫面留置原因
# Memo...........:
# Usage..........: CALL apmt840_pmdl043_hold()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/12/04 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdl043_hold()
DEFINE  r_success       LIKE type_t.num5

   LET r_success = TRUE
   IF g_pmdl_m.pmdldocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   ERROR ""

   CALL s_transaction_begin()
   
   OPEN apmt840_cl USING g_enterprise,g_pmdl_m.pmdldocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN apmt840_cl:"
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #鎖住將被更改的資料
   #150707-00029#1 20150803 mark by beckxie ---S
#   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
#       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
#       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
#       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029,g_pmdl_m.pmdl025, 
#       g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021,g_pmdl_m.pmdl043,g_pmdl_m.pmdl020, 
#       g_pmdl_m.pmdl044,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
#       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
#       g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042,g_pmdl_m.pmdl047,g_pmdl_m.pmdl048,g_pmdl_m.pmdl049, 
#       g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid,g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid, 
#       g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid,g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid, 
#       g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc,g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc, 
#       g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc, 
#       g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc,g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc, 
#       g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc,g_pmdl_m.pmdlownid_desc, 
#       g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc,g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc, 
#       g_pmdl_m.pmdlcnfid_desc
   #150707-00029#1 20150803 mark by beckxie ---E
   #150707-00029#1 20150803 add  by beckxie ---S
   EXECUTE apmt840_master_referesh USING g_pmdl_m.pmdldocno INTO g_pmdl_m.pmdlsite,g_pmdl_m.pmdldocdt, 
       g_pmdl_m.pmdldocno,g_pmdl_m.pmdl001,g_pmdl_m.pmdl005,g_pmdl_m.pmdl200,g_pmdl_m.pmdl004,g_pmdl_m.pmdl203, 
       g_pmdl_m.pmdl002,g_pmdl_m.pmdl003,g_pmdl_m.pmdlstus,g_pmdl_m.pmdl007,g_pmdl_m.pmdl008,g_pmdl_m.pmdl027, 
       g_pmdl_m.pmdl201,g_pmdl_m.pmdl202,g_pmdl_m.pmdl204,g_pmdl_m.pmdl207,g_pmdl_m.pmdlunit,g_pmdl_m.pmdl029, 
       g_pmdl_m.pmdl025,g_pmdl_m.pmdl206,g_pmdl_m.pmdl205,g_pmdl_m.pmdl023,g_pmdl_m.pmdl022,g_pmdl_m.pmdl021, 
       g_pmdl_m.pmdl047,g_pmdl_m.pmdl054,g_pmdl_m.pmdl055,g_pmdl_m.pmdl009,g_pmdl_m.pmdl015,g_pmdl_m.pmdl016, 
       g_pmdl_m.pmdl010,g_pmdl_m.pmdl011,g_pmdl_m.pmdl012,g_pmdl_m.pmdl013,g_pmdl_m.pmdl033,g_pmdl_m.pmdl024, 
       g_pmdl_m.pmdl043,g_pmdl_m.pmdl020,g_pmdl_m.pmdl044,g_pmdl_m.pmdl006,g_pmdl_m.pmdl028,g_pmdl_m.pmdl042, 
       g_pmdl_m.pmdl048,g_pmdl_m.pmdl049,g_pmdl_m.pmdl046,g_pmdl_m.pmdl040,g_pmdl_m.pmdl041,g_pmdl_m.pmdlownid, 
       g_pmdl_m.pmdlowndp,g_pmdl_m.pmdlcrtid,g_pmdl_m.pmdlcrtdp,g_pmdl_m.pmdlcrtdt,g_pmdl_m.pmdlmodid, 
       g_pmdl_m.pmdlmoddt,g_pmdl_m.pmdlcnfid,g_pmdl_m.pmdlcnfdt,g_pmdl_m.pmdlsite_desc,g_pmdl_m.pmdl200_desc, 
       g_pmdl_m.pmdl004_desc,g_pmdl_m.pmdl002_desc,g_pmdl_m.pmdl003_desc,g_pmdl_m.pmdl027_desc,g_pmdl_m.pmdl204_desc, 
       g_pmdl_m.pmdl207_desc,g_pmdl_m.pmdlunit_desc,g_pmdl_m.pmdl029_desc,g_pmdl_m.pmdl023_desc,g_pmdl_m.pmdl022_desc, 
       g_pmdl_m.pmdl021_desc,g_pmdl_m.pmdl009_desc,g_pmdl_m.pmdl015_desc,g_pmdl_m.pmdl010_desc,g_pmdl_m.pmdl024_desc, 
       g_pmdl_m.pmdl043_desc,g_pmdl_m.pmdl020_desc,g_pmdl_m.pmdlownid_desc,g_pmdl_m.pmdlowndp_desc,g_pmdl_m.pmdlcrtid_desc, 
       g_pmdl_m.pmdlcrtdp_desc,g_pmdl_m.pmdlmodid_desc,g_pmdl_m.pmdlcnfid_desc
   #150707-00029#1 20150803 add  by beckxie ---E
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_pmdl_m.pmdldocno
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      CLOSE apmt840_cl
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL apmt840_show()
   LET g_hold = TRUE

   CALL apmt840_set_entry('u')
   CALL apmt840_set_no_entry('u')
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_pmdl_m.pmdl043 ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD pmdl043
            LET g_pmdl_m.pmdl043_desc = ''
            IF NOT cl_null(g_pmdl_m.pmdl043) THEN
               IF g_pmdl_m.pmdl043 != g_pmdl_m_t.pmdl043 OR g_pmdl_m_t.pmdl043 IS NULL THEN
                  #IF NOT s_azzi650_chk_exist('298',g_pmdl_m.pmdl043) THEN   #150908-00013#1 150910 by sakura mark
                  IF NOT s_azzi650_chk_exist('317',g_pmdl_m.pmdl043) THEN    #150908-00013#1 150910 by sakura add 
                     LET g_pmdl_m.pmdl043 = g_pmdl_m_t.pmdl043
                     #CALL s_desc_get_acc_desc('298',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc  #150908-00013#1 150910 by sakura mark
                     CALL s_desc_get_acc_desc('317',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc   #150908-00013#1 150910 by sakura add
                     DISPLAY BY NAME g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #CALL s_desc_get_acc_desc('298',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc  #150908-00013#1 150910 by sakura mark
            CALL s_desc_get_acc_desc('317',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc   #150908-00013#1 150910 by sakura add   
            DISPLAY BY NAME g_pmdl_m.pmdl043_desc

         ON ACTION controlp INFIELD pmdl043
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdl_m.pmdl043  #給予default值
            #LET g_qryparam.arg1 = "298"  #150908-00013#1 150910 by sakura mark
            LET g_qryparam.arg1 = "317"   #150908-00013#1 150910 by sakura add
            CALL q_oocq002()                            #呼叫開窗
            LET g_pmdl_m.pmdl043 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_pmdl_m.pmdl043 TO pmdl043         #顯示到畫面上
            #CALL s_desc_get_acc_desc('298',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc  #150908-00013#1 150910 by sakura mark
            CALL s_desc_get_acc_desc('317',g_pmdl_m.pmdl043) RETURNING g_pmdl_m.pmdl043_desc   #150908-00013#1 150910 by sakura add
            DISPLAY BY NAME g_pmdl_m.pmdl043_desc
            NEXT FIELD pmdl043                          #返回原欄位

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            UPDATE pmdl_t SET pmdl043 = g_pmdl_m.pmdl043
             WHERE pmdlent = g_enterprise
               AND pmdldocno = g_pmdl_m.pmdldocno
            CASE
               WHEN SQLCA.sqlerrd[3] = 0                   #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "UPDATE pmdl043"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET r_success = FALSE
                  EXIT DIALOG
               WHEN SQLCA.sqlcode                          #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "UPDATE pmdl043"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET r_success = FALSE
                  EXIT DIALOG
            END CASE
      END INPUT

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE
         LET r_success = FALSE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         LET r_success = FALSE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         LET r_success = FALSE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   CLOSE apmt840_cl
   LET g_hold = FALSE
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 清楚留置原因
# Memo...........:
# Usage..........: CALL apmt840_pmdl043_unhold()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/12/04 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdl043_unhold()
DEFINE  r_success       LIKE type_t.num5

   LET r_success = TRUE
   #清空留置原因
   UPDATE pmdl_t
      SET pmdl043 = ''
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdl_m.pmdldocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE pmdl"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET g_pmdl_m.pmdl043 = ''
   LET g_pmdl_m.pmdl043_desc = ''
   DISPLAY BY NAME g_pmdl_m.pmdl043,g_pmdl_m.pmdl043_desc

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 顯示單頭未稅 含稅欄位值
# Memo...........:
# Usage..........: CALL apmt840_sel_money()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/12/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_sel_money()

   SELECT pmdl040,pmdl041
     INTO g_pmdl_m.pmdl040,g_pmdl_m.pmdl041
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdl_m.pmdldocno
   
   DISPLAY BY NAME g_pmdl_m.pmdl040,g_pmdl_m.pmdl041

END FUNCTION

################################################################################
# Descriptions...: 檢查單身到庫日是否有大於單頭採購失效日
# Memo...........:
# Usage..........: CALL apmt840_pmdl205_chk(p_pmdldocno,p_pmdnseq,p_pmdl205)
#                  RETURNING r_success
# Input parameter: p_pmdldocno    採購單號
#                : p_pmdnseq      採購項次
#                : p_pmdl205      採購單頭失效日
# Return code....: r_success      TRUE(FALSE)
# Date & Author..: 2015/04/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_pmdl205_chk(p_pmdldocno,p_pmdnseq,p_pmdl205)
DEFINE p_pmdldocno         LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq           LIKE pmdn_t.pmdnseq
DEFINE p_pmdl205           LIKE pmdl_t.pmdl205
DEFINE l_pmdo013           LIKE pmdo_t.pmdo013
DEFINE r_pmdl205           LIKE pmdl_t.pmdl205
DEFINE r_success           LIKE type_t.num5

  LET r_success = TRUE
  LET r_pmdl205 = NULL
  LET l_pmdo013 = ''
  
  IF p_pmdnseq != 0 THEN
     SELECT pmdo013 INTO l_pmdo013 
       FROM pmdo_t
      WHERE pmdoent   = g_enterprise
        AND pmdodocno = p_pmdldocno
        AND pmdoseq   = p_pmdnseq
     IF l_pmdo013 > p_pmdl205 THEN
        LET r_pmdl205 = l_pmdo013
        LET r_success = FALSE
     ELSE
        LET r_pmdl205 = p_pmdl205
     END IF
  ELSE
     SELECT MAX(pmdo013) INTO l_pmdo013
       FROM pmdo_t
      WHERE pmdoent   = g_enterprise
        AND pmdodocno = p_pmdldocno
     IF (l_pmdo013 > p_pmdl205) OR cl_null(p_pmdl205) THEN
        LET r_pmdl205 = l_pmdo013
        LET r_success = FALSE
     ELSE
        LET r_pmdl205 = p_pmdl205
     END IF                
  END IF
  RETURN r_success,r_pmdl205
END FUNCTION

################################################################################
# Descriptions...: 更新單頭、單身失效日為單身最大到庫日
# Memo...........:
# Usage..........: CALL apmt840_pmdn224_upd(p_pmdldocno,p_pmdl205)
#                  RETURNING r_success
# Input parameter: p_pmdldocno    採購單號
#                : p_pmdl205      單頭交效日
# Return code....: r_success      TRUE(FALSE)
# Date & Author..: 2015/04/10 By Ken
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt840_pmdn224_upd(p_pmdldocno,p_pmdl205)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE p_pmdl205       LIKE pmdl_t.pmdl205
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   
   UPDATE pmdl_t 
      SET pmdl205 = p_pmdl205
    WHERE pmdlent = g_enterprise
      AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF      
      
   UPDATE pmdn_t 
      SET pmdn224 = p_pmdl205
    WHERE pmdnent = g_enterprise
      AND pmdndocno = p_pmdldocno   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF      
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取訂單有效期(先取門店再取店群)
# Memo...........: 1.先取門店 = 收貨組織
#                : 2.取不到再取 門店 = 'ALL'
#                : 3.取不到再取 店群
# Usage..........: CALL apmt840_get_rtka010(p_pmdlunit,p_pmdl004)
#                  RETURNING r_rtka010
# Input parameter: p_pmdlunit     收貨組織
#                : p_pmdl004      供應商
# Return code....: r_rtka010      訂單有效期
# Date & Author..: 2015/04/10 By Ken
# Modify.........: 
################################################################################
PRIVATE FUNCTION apmt840_get_rtka010(p_pmdlunit,p_pmdl004)
DEFINE p_pmdlunit         LIKE pmdl_t.pmdlunit
DEFINE p_pmdl004          LIKE pmdl_t.pmdl004
DEFINE r_rtka010          LIKE rtka_t.rtka010
DEFINE r_rtka012          LIKE rtka_t.rtka012
DEFINE l_rtaa001          LIKE rtaa_t.rtaa001
DEFINE l_sql              STRING

   WHENEVER ERROR CONTINUE
   LET r_rtka010 = NULL
   LET r_rtka012 = NULL
   
   IF cl_null(p_pmdlunit) OR cl_null(p_pmdl004) THEN
      RETURN r_rtka010
   END IF
   
   LET l_sql = "SELECT rtka010 FROM rtka_t",
               " WHERE rtkaent = ",g_enterprise,
               "   AND rtka001 = '",p_pmdl004,"'",
               "   AND rtka002 = ?",
               "   AND rtka003 = ?",
               "   AND rtkastus = 'Y'"
   PREPARE apmt840_get_rtka010 FROM l_sql
   
   #取門店
   EXECUTE apmt840_get_rtka010 USING '2',p_pmdlunit INTO r_rtka010
   
   IF STATUS = 100 THEN
      #取門店 = 'ALL'
      EXECUTE apmt840_get_rtka010 USING '2','ALL' INTO r_rtka010
      
      IF STATUS = 100 THEN
         #huangrh add rtak-----20150603
         LET l_rtaa001 = ''
         SELECT rtaa001 INTO l_rtaa001
           FROM rtak_t,rtaa_t
           LEFT OUTER JOIN rtab_t ON rtaaent = rtabent AND rtaa001 = rtab001
          WHERE rtaaent = g_enterprise
             AND rtakent=rtaaent
             AND rtak001=rtaa001
             AND rtak002='2'
             AND rtak003='Y'
             AND rtaastus = 'Y'
             AND rtab002 = p_pmdlunit
         #取店群
         EXECUTE apmt840_get_rtka010 USING '1',l_rtaa001 INTO r_rtka010
      END IF
   END IF

   RETURN r_rtka010   
END FUNCTION

################################################################################
# Descriptions...: 檢查當採購方式 = 0.自訂貨 且 沒有關聯式單據資料
#                :   採購組織+商品編號+產品特徵+收貨組織
# Memo...........:
# Usage..........: CALL apmt840_unique_chk(p_pmdnseq,p_pmdnsite,p_pmdnunit,p_pmdn001,p_pmdn002)
#                  RETURNING r_success
# Input parameter: p_pmdnseq      項次
#                : p_pmdnsite     採購組織
#                : p_pmdnunit     收貨組織
#                : p_pmdn001      商品編號
#                : p_pmdn002      產品特徵
# Return code....: r_success      True/False
# Date & Author..: 2015/05/28 By pomelo 150521-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_unique_chk(p_pmdnseq,p_pmdnsite,p_pmdnunit,p_pmdn001,p_pmdn002)
DEFINE p_pmdnseq         LIKE pmdn_t.pmdnseq    #項次
DEFINE p_pmdnsite        LIKE pmdn_t.pmdnsite   #採購組織
DEFINE p_pmdnunit        LIKE pmdn_t.pmdnunit   #收貨組織
DEFINE p_pmdn001         LIKE pmdn_t.pmdn001    #商品編號
DEFINE p_pmdn002         LIKE pmdn_t.pmdn002    #產品特徵
DEFINE r_success         LIKE type_t.num5

DEFINE l_imaa005         LIKE imaa_t.imaa005
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_pmdnsite) OR cl_null(p_pmdn001) OR
      cl_null(p_pmdnunit) THEN
      RETURN r_success
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(pmdpseq) INTO l_cnt
     FROM pmdp_t
    WHERE pmdpent = g_enterprise
      AND pmdpdocno = g_pmdl_m.pmdldocno
   IF l_cnt >= 1 THEN
      RETURN r_success
   END IF
   
   #商品編號使用產品特徵否
   LET l_imaa005 = apmt840_get_imaa005(p_pmdn001)
   
   #商品編號使用產品特徵 且 還為維護產品特徵
   IF NOT cl_null(l_imaa005) AND cl_null(p_pmdn002) THEN
      RETURN r_success
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(pmdnseq) INTO l_cnt
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdnsite = p_pmdnsite
      AND pmdnunit = p_pmdnunit
      AND pmdndocno = g_pmdl_m.pmdldocno
      AND pmdnseq != COALESCE(g_pmdn_d[l_ac].pmdnseq,-1)
      AND pmdn001 = p_pmdn001
      AND COALESCE(pmdn002,' ') = COALESCE(p_pmdn002,' ')
      
   #採購組織+商品+產品特徵+收貨組織
   IF l_cnt >= 1 THEN
      #當採購方式 = 0.自訂貨且沒有關聯式單據資料，單身採購組織+商品+產品特徵+收貨組織 不可重複！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00924'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 處理單頭採購失效日
# Memo...........:
# Usage..........: CALL apmt840_expiration_date(p_type)
#                     RETURNING r_success,r_confirm
# Input parameter: p_type         修改動作 Y：確認 N:放棄
# Return code....: r_success      True/False
#                : r_confirm      是否有修改
# Date & Author..: 2015/06/08 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_expiration_date(p_type)
DEFINE p_type            LIKE type_t.chr1
DEFINE r_success         LIKE type_t.num5
DEFINE r_confirm         LIKE type_t.num5
DEFINE l_pmdo013         LIKE pmdo_t.pmdo013
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_replace         STRING
DEFINE l_msg             STRING

   LET r_success = TRUE
   LET r_confirm = TRUE
   
   #當長效期訂單 = 'Y' 且 單頭採購失效日為空
   # 不需要處理採購失效日
   IF g_pmdl_m.pmdl206 = 'Y' AND cl_null(g_pmdl_m.pmdl205) THEN
      RETURN r_success,r_confirm
   END IF
   
   #單身沒有資料
   LET l_cnt = 0
   SELECT COUNT(pmdnseq) INTO l_cnt
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno
   IF l_cnt = 0 THEN
      RETURN r_success,r_confirm
   END IF
   
   #取採購交期明細檔中最大的到庫日期
   LET l_pmdo013 = ''
   SELECT MAX(pmdo013) INTO l_pmdo013
     FROM pmdo_t
    WHERE pmdoent = g_enterprise
      AND pmdodocno = g_pmdl_m.pmdldocno
   
   LET l_replace = g_pmdl_m.pmdl205 ,"|",l_pmdo013
   #單頭採購失效日 < 取採購多交期最大到庫日期
   IF g_pmdl_m.pmdl205 < l_pmdo013 AND NOT cl_null(g_pmdl_m.pmdl205) THEN
      LET l_msg = cl_getmsg_parm('apm-00884',g_dlang,l_replace)
      IF NOT cl_ask_confirm_parm('std-00008',l_msg) THEN
         LET r_confirm = FALSE
         RETURN r_success,r_confirm
      END IF
   END IF
   
   #單頭採購失效日 > 取採購多交期最大到庫日期
   IF g_pmdl_m.pmdl205 > l_pmdo013 AND NOT cl_null(g_pmdl_m.pmdl205) THEN
      LET l_msg = cl_getmsg_parm('apm-00932',g_dlang,l_replace)
      IF NOT cl_ask_confirm_parm('std-00008',l_msg) THEN
         RETURN r_success,r_confirm
      END IF
   END IF
   
   #修改動作為放棄修改
   #先rollback，在開啟trancation
   IF p_type = 'N' THEN
      CALL s_transaction_end('N','0')
   END IF
   IF s_transaction_chk("N",0) THEN
      CALL s_transaction_begin()
   END IF
   
   #更新單頭及單身採購失效日
   UPDATE pmdl_t 
      SET pmdl205 = l_pmdo013
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_pmdl_m.pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = "Upd pmdl_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success,r_confirm
   END IF      
      
   UPDATE pmdn_t 
      SET pmdn224 = l_pmdo013
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = "upd_pmdn_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      CALL s_transaction_end('N','0')
      RETURN r_success,r_confirm
   END IF
   
   LET g_pmdl_m.pmdl205 = l_pmdo013
   DISPLAY BY NAME g_pmdl_m.pmdl205
   
   CALL s_transaction_end('Y','0')
   RETURN r_success,r_confirm
END FUNCTION

################################################################################
# Descriptions...: 檢查採購失效日
# Memo...........:
# Usage..........: CALL apmt840_chk_pmdl205()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/06/08 By pomelo #15050604-00026#1
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_chk_pmdl205()
DEFINE r_success         LIKE type_t.num5
DEFINE l_pmdo013         LIKE pmdo_t.pmdo013
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(pmdnseq) INTO l_cnt
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = g_pmdl_m.pmdldocno
   IF l_cnt >= 1 THEN
      LET l_pmdo013 = ''
      SELECT MAX(pmdo013) INTO l_pmdo013
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdodocno = g_pmdl_m.pmdldocno
      
      #單頭採購失效日期 < 單身最大到庫日期
      IF g_pmdl_m.pmdl205 < l_pmdo013 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00933'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_pmdl_m.pmdl205
         LET g_errparam.replace[2] = l_pmdo013
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查供應商及採購中心存在採購協議
# Memo...........:
# Usage..........: CALL apmt840_chk_pact()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/07/01 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt840_chk_pact()
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(g_pmdl_m.pmdl004) OR cl_null(g_pmdl_m.pmdl200) THEN
      RETURN r_success
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(starent) INTO l_cnt
     FROM star_t
    WHERE starent = g_enterprise
      AND star003 = g_pmdl_m.pmdl004
      AND star008 = g_pmdl_m.pmdl200
      AND starstus = 'Y'
    
   IF l_cnt = 0 THEN
      #此採購中心%1+供應商%2不存在一筆以上有效的採購協議！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00967'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_pmdl_m.pmdl200
      LET g_errparam.replace[2] = g_pmdl_m.pmdl004
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
