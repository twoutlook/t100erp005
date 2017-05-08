#該程式未解開Section, 採用最新樣板產出!
{<section id="axmq500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:16(2016-11-07 09:40:34), PR版次:0016(2017-02-15 11:47:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000082
#+ Filename...: axmq500
#+ Description: 訂單追蹤查詢作業
#+ Creator....: 05384(2014-10-02 09:45:32)
#+ Modifier...: 02040 -SD/PR- 07423
 
{</section>}
 
{<section id="axmq500.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150908           15/09/08  By 03538    增加顯示帳款單性質
#160503-00030#12  16/05/20  By Sarah    效能改善
#160523-00056#1   16/07/12  By 03079    增加請購明細、採購明細頁籤 
#160725-00024#1   16/07/25  By summer   採購明細，不限制採購狀態為已確認
#161014-00022#1   16/10/19  By 06948    工單來源為multi，查詢訂單時因來源單號為空而查不到工單，調整查詢sfab_t
#161026-00019#1   16/10/26  By fionchen 1.修正ON ACTION controlp INFIELD xmdd001的NEXT FIELD錯誤
#                                       2.QBE增加客戶料號欄位,訂單明細頁籤增加顯示客戶料號/客戶料號品名/客戶料號規格 
#161027-00003#1   16/10/27  By fionchen QBE查詢產品分類條件,訂單明細不會顯是資料的問題
#161104-00031#1   16/11/07  By 02040    訂單明細僅顯示未交資料，數量應該分批數量xmdd006而非總數量xmdd005去做計算
#161207-00033#3   16/12/20  By 08992    一次性交易對象顯示說明，所以的客戶/供應商欄位都應該處理
#161221-00064#19  17/01/10  By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#170209-00005#1   17/02/15  By fionchen 調整若訂單只有單頭資料無單身資料也需顯示,與總筆數的SQL少了site條件
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmda_d RECORD
       
       sel LIKE type_t.chr1, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda004_desc LIKE type_t.chr500, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda002_desc LIKE type_t.chr500, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda003_desc LIKE type_t.chr500, 
   xmda033 LIKE xmda_t.xmda033
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xmda_m   RECORD
    xmda004_sel       LIKE type_t.chr1,
    xmdadocno_sel     LIKE type_t.chr1,
    xmdadocdt_sel     LIKE type_t.chr1,
    xmda002_sel       LIKE type_t.chr1,
    xmda003_sel       LIKE type_t.chr1
                  END RECORD
DEFINE g_xmda_m       type_g_xmda_m
 TYPE type_g_attribute  RECORD
    attribute01       LIKE type_t.chr1,
    attribute02       LIKE type_t.chr1,
    attribute03       LIKE type_t.chr1,
    attribute04       LIKE type_t.chr1
                  END RECORD
DEFINE g_attribute    type_g_attribute
#訂單明細
 TYPE type_g_xmdd_d   RECORD
    xmdadocno_1       LIKE xmda_t.xmdadocno, 
    xmdadocdt_1       LIKE xmda_t.xmdadocdt, 
    xmda004_1         LIKE xmda_t.xmda004, 
    xmda004_1_desc    LIKE pmaal_t.pmaal004, 
    xmda002_1         LIKE xmda_t.xmda002, 
    xmda002_1_desc    LIKE ooag_t.ooag011, 
    xmda003_1         LIKE xmda_t.xmda003, 
    xmda003_1_desc    LIKE ooefl_t.ooefl003, 
    xmda033_1         LIKE xmda_t.xmda033, 
    xmddseq           LIKE xmdd_t.xmddseq, 
    xmddseq1          LIKE xmdd_t.xmddseq1, 
    xmddseq2          LIKE xmdd_t.xmddseq2, 
    xmdd003           LIKE xmdd_t.xmdd003, 
    xmdd001           LIKE xmdd_t.xmdd001, 
    xmdd001_desc      LIKE imaal_t.imaal003, 
    xmdd001_desc_1    LIKE imaal_t.imaal004, 
    xmdc027           LIKE xmdc_t.xmdc027,     #161026-00019#1 add
    xmdc027_desc      LIKE pmao_t.pmao009,     #161026-00019#1 add
    xmdc027_desc_1    LIKE pmao_t.pmao010,     #161026-00019#1 add
    xmdd002           LIKE xmdd_t.xmdd002,
    xmdd002_desc      LIKE type_t.chr1000,
    xmdd006           LIKE xmdd_t.xmdd006,     #161104-00031#1 xmdd005 mod xmdd006
    xmdd004           LIKE xmdd_t.xmdd004,
    xmdd004_desc      LIKE oocal_t.oocal003,       
    xmdd011           LIKE xmdd_t.xmdd011,
    xmdd031           LIKE xmdd_t.xmdd031, 
    xmdd014           LIKE xmdd_t.xmdd014,
    xmdd015           LIKE xmdd_t.xmdd015, 
    xmdd016           LIKE xmdd_t.xmdd016,
    xmdc050           LIKE xmdc_t.xmdc050,
    xmdastus          LIKE xmda_t.xmdastus       
                  END RECORD
DEFINE g_xmdd_d       DYNAMIC ARRAY OF type_g_xmdd_d
DEFINE g_xmdd_d_t     type_g_xmdd_d
#工單生產明細
 TYPE type_g_sfaa_d   RECORD
    sfaadocno         LIKE sfaa_t.sfaadocno,
    sfaadocdt         LIKE sfaa_t.sfaadocdt,
    sfaa002           LIKE sfaa_t.sfaa002,
    sfaa002_desc      LIKE ooag_t.ooag011, 
    sfaa006           LIKE sfaa_t.sfaa006,
    sfaa007           LIKE sfaa_t.sfaa007,
    xmda033_2         LIKE xmda_t.xmda033, 
    sfaa009           LIKE sfaa_t.sfaa009,
    sfaa009_desc      LIKE pmaal_t.pmaal004,
    sfaa010           LIKE sfaa_t.sfaa010,
    sfaa010_desc      LIKE imaal_t.imaal003,
    sfaa010_desc_1    LIKE imaal_t.imaal004,
    sfaa013           LIKE sfaa_t.sfaa013,
    sfaa013_desc      LIKE oocal_t.oocal003,
    sfaa012           LIKE sfaa_t.sfaa012,
    sfaa049           LIKE sfaa_t.sfaa049,
    sfaa050           LIKE sfaa_t.sfaa050,
    sfaa051           LIKE sfaa_t.sfaa051,
    sfaa055           LIKE sfaa_t.sfaa055,
    sfaa056           LIKE sfaa_t.sfaa056,
    sfaastus          LIKE sfaa_t.sfaastus
                  END RECORD
DEFINE g_sfaa_d       DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t     type_g_sfaa_d

#160523-00056#1 20160712 -----(S) 
TYPE type_g_pmda_d    RECORD
                         pmdadocno     LIKE pmda_t.pmdadocno,
                         pmdadocdt     LIKE pmda_t.pmdadocdt,
                         pmda002       LIKE pmda_t.pmda002,
                         pmda002_desc  LIKE ooag_t.ooag011, 
                         pmda003       LIKE pmda_t.pmda003,
                         pmda003_desc  LIKE ooefl_t.ooefl003, 
                         pmdbseq       LIKE pmdb_t.pmdbseq,
                         pmdb002       LIKE pmdb_t.pmdb002,
                         pmdb004       LIKE pmdb_t.pmdb004, 
                         pmdb004_desc  LIKE imaal_t.imaal003, 
                         pmdb004_desc_1 LIKE imaal_t.imaal004, 
                         pmdb005       LIKE pmdb_t.pmdb005, 
                         pmdb005_desc  LIKE type_t.chr1000, 
                         pmdb007       LIKE pmdb_t.pmdb007, 
                         pmdb007_desc  LIKE oocal_t.oocal003, 
                         pmdb006       LIKE pmdb_t.pmdb006,
                         pmdb030       LIKE pmdb_t.pmdb030,
                         pmdb049       LIKE pmdb_t.pmdb049,
                         pmdb050       LIKE pmdb_t.pmdb050,
                         pmdastus      LIKE pmda_t.pmdastus
                      END RECORD
DEFINE g_pmda_d       DYNAMIC ARRAY OF type_g_pmda_d
DEFINE g_pmda_d_t     type_g_pmda_d

TYPE type_g_pmdl_d    RECORD
                         pmdldocno     LIKE pmdl_t.pmdldocno,
                         pmdldocdt     LIKE pmdl_t.pmdldocdt,
                         pmdl004       LIKE pmdl_t.pmdl004, 
                         pmdl004_desc  LIKE pmaal_t.pmaal004, 
                         pmdl002       LIKE pmdl_t.pmdl002,
                         pmdl002_desc  LIKE ooag_t.ooag011, 
                         pmdl003       LIKE pmdl_t.pmdl003, 
                         pmdl003_desc  LIKE ooefl_t.ooefl003, 
                         pmdnseq       LIKE pmdn_t.pmdnseq,
                         pmdpseq1      LIKE pmdp_t.pmdpseq1,
                         pmdp004       LIKE pmdp_t.pmdp004,
                         pmdn001       LIKE pmdn_t.pmdn001, 
                         pmdn001_desc  LIKE imaal_t.imaal003, 
                         pmdn001_desc_1 LIKE imaal_t.imaal004, 
                         pmdn002       LIKE pmdn_t.pmdn002, 
                         pmdn002_desc  LIKE type_t.chr1000, 
                         pmdn006       LIKE pmdn_t.pmdn006, 
                         pmdn006_desc  LIKE oocal_t.oocal003, 
                         pmdp024       LIKE pmdp_t.pmdp024,
                         pmdn012       LIKE pmdn_t.pmdn012,
                         pmdp025       LIKE pmdp_t.pmdp025,
                         pmdp026       LIKE pmdp_t.pmdp026,
                         pmdn050       LIKE pmdn_t.pmdn050,
                         pmdlstus      LIKE pmdl_t.pmdlstus
                      END RECORD
DEFINE g_pmdl_d       DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t     type_g_pmdl_d
#160523-00056#1 20160712 -----(E) 

#出貨通知單明細
 TYPE type_g_xmdh_d   RECORD
    xmdgdocno         LIKE xmdg_t.xmdgdocno,
    xmdgdocdt         LIKE xmdg_t.xmdgdocdt,
    xmdg005           LIKE xmdg_t.xmdg005,
    xmdg005_desc      LIKE pmaal_t.pmaal004,
    xmdg002           LIKE xmdg_t.xmdg002,
    xmdg002_desc      LIKE ooag_t.ooag011,
    xmdg003           LIKE xmdg_t.xmdg003,
    xmdg003_desc      LIKE ooefl_t.ooefl003,
    xmdhseq           LIKE xmdh_t.xmdhseq,
    xmdh001           LIKE xmdh_t.xmdh001,
    xmdh002           LIKE xmdh_t.xmdh002,
    xmda033_3         LIKE xmda_t.xmda033, 
    xmdh006           LIKE xmdh_t.xmdh006,
    xmdh006_desc      LIKE imaal_t.imaal003,
    xmdh006_desc_1    LIKE imaal_t.imaal004,
    xmdh007           LIKE xmdh_t.xmdh007,
    xmdh007_desc      LIKE type_t.chr1000,
    xmdh015           LIKE xmdh_t.xmdh015,
    xmdh015_desc      LIKE oocal_t.oocal003,
    xmdh016           LIKE xmdh_t.xmdh016,
    xmdh030           LIKE xmdh_t.xmdh030,
    xmdh050           LIKE xmdh_t.xmdh050,
    xmdgstus          LIKE xmdg_t.xmdgstus
                  END RECORD
DEFINE g_xmdh_d       DYNAMIC ARRAY OF type_g_xmdh_d
DEFINE g_xmdh_d_t     type_g_xmdh_d
#出貨明細
 TYPE type_g_xmdl_d   RECORD
    xmdkdocno         LIKE xmdk_t.xmdkdocno,
    xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
    xmdk002           LIKE xmdk_t.xmdk002,
    xmdk007           LIKE xmdk_t.xmdk007,
    xmdk007_desc      LIKE pmaal_t.pmaal004,
    xmdk003           LIKE xmdk_t.xmdk003,
    xmdk003_desc      LIKE ooag_t.ooag011,
    xmdk004           LIKE xmdk_t.xmdk004,
    xmdk004_desc      LIKE ooefl_t.ooefl003,
    xmdlseq           LIKE xmdl_t.xmdlseq,
    xmdl003           LIKE xmdl_t.xmdl003,
    xmdl004           LIKE xmdl_t.xmdl004,
    xmda033_4         LIKE xmda_t.xmda033, 
    xmdl008           LIKE xmdl_t.xmdl008,
    xmdl008_desc      LIKE imaal_t.imaal003,
    xmdl008_desc_1    LIKE imaal_t.imaal004,
    xmdl009           LIKE xmdl_t.xmdl009,
    xmdl009_desc      LIKE type_t.chr1000,
    xmdl017           LIKE xmdl_t.xmdl017,
    xmdl017_desc      LIKE oocal_t.oocal003,
    xmdl018           LIKE xmdl_t.xmdl018,
    xmdl035           LIKE xmdl_t.xmdl035,
    xmdl036           LIKE xmdl_t.xmdl036,
    xmdl037           LIKE xmdl_t.xmdl037,
    xmdl051           LIKE xmdl_t.xmdl051,
    xmdkstus          LIKE xmdk_t.xmdkstus       
                  END RECORD
DEFINE g_xmdl_d       DYNAMIC ARRAY OF type_g_xmdl_d
DEFINE g_xmdl_d_t     type_g_xmdl_d
#出貨簽收明細
 TYPE type_g_xmdk_d   RECORD
    xmdkdocno_1       LIKE xmdk_t.xmdkdocno,
    xmdkdocdt_1       LIKE xmdk_t.xmdkdocdt,
    xmdk007_1         LIKE xmdk_t.xmdk007,
    xmdk007_1_desc    LIKE pmaal_t.pmaal004,
    xmdk003_1         LIKE xmdk_t.xmdk003,
    xmdk003_1_desc    LIKE ooag_t.ooag011,
    xmdk004_1         LIKE xmdk_t.xmdk004,
    xmdk004_1_desc    LIKE ooefl_t.ooefl003,
    xmdlseq_1         LIKE xmdl_t.xmdlseq,
    xmdl003_1         LIKE xmdl_t.xmdl003,
    xmdl004_1         LIKE xmdl_t.xmdl004,
    xmda033_5         LIKE xmda_t.xmda033, 
    xmdl008_1         LIKE xmdl_t.xmdl008,
    xmdl008_1_desc    LIKE imaal_t.imaal003,
    xmdl008_1_desc_1  LIKE imaal_t.imaal004,
    xmdl009_1         LIKE xmdl_t.xmdl009,
    xmdl009_1_desc    LIKE type_t.chr1000,
    xmdl017_1         LIKE xmdl_t.xmdl017,
    xmdl017_1_desc    LIKE oocal_t.oocal003,
    xmdl018_1         LIKE xmdl_t.xmdl018,
    xmdl081           LIKE xmdl_t.xmdl081,
    xmdl084           LIKE xmdl_t.xmdl084,
    xmdl084_desc      LIKE oocql_t.oocql004,#280
    xmdl051_1         LIKE xmdl_t.xmdl051,
    xmdkstus_1        LIKE xmdk_t.xmdkstus
                  END RECORD
DEFINE g_xmdk_d       DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t     type_g_xmdk_d
#銷退明細
 TYPE type_g_xmdk_d_2 RECORD
    xmdkdocno_2       LIKE xmdk_t.xmdkdocno,
    xmdkdocdt_2       LIKE xmdk_t.xmdkdocdt,
    xmdk082           LIKE xmdk_t.xmdk082,
    xmdk007_2         LIKE xmdk_t.xmdk007,
    xmdk007_2_desc    LIKE pmaal_t.pmaal004,
    xmdk003_2         LIKE xmdk_t.xmdk003,
    xmdk003_2_desc    LIKE ooag_t.ooag011,
    xmdk004_2         LIKE xmdk_t.xmdk004,
    xmdk004_2_desc    LIKE ooefl_t.ooefl003,
    xmdlseq_2         LIKE xmdl_t.xmdlseq,
    xmdl003_2         LIKE xmdl_t.xmdl003,
    xmdl004_2         LIKE xmdl_t.xmdl004,
    xmda033_6         LIKE xmda_t.xmda033, 
    xmdl008_2         LIKE xmdl_t.xmdl008,
    xmdl008_2_desc    LIKE imaal_t.imaal003,
    xmdl008_2_desc_1  LIKE imaal_t.imaal004,
    xmdl009_2         LIKE xmdl_t.xmdl009,
    xmdl009_2_desc    LIKE type_t.chr1000,
    xmdl017_2         LIKE xmdl_t.xmdl017,
    xmdl017_2_desc    LIKE oocal_t.oocal003,
    xmdl018_2         LIKE xmdl_t.xmdl018,
    xmdl050           LIKE xmdl_t.xmdl050,
    xmdl050_desc      LIKE oocql_t.oocql004,#310
    xmdl051_2         LIKE xmdl_t.xmdl051,
    xmdkstus_2        LIKE xmdk_t.xmdkstus
                  END RECORD
DEFINE g_xmdk_d_2     DYNAMIC ARRAY OF type_g_xmdk_d_2
DEFINE g_xmdk_d_2_t   type_g_xmdk_d_2
#應收帳款明細
 TYPE type_g_xrca_d   RECORD
    xrcadocno         LIKE xrca_t.xrcadocno,
    xrcadocdt         LIKE xrca_t.xrcadocdt,
    xrca001           LIKE xrca_t.xrca001,   #150908    
    xrca005           LIKE xrca_t.xrca005,
    xrca005_desc      LIKE pmaal_t.pmaal004,
    xrca014           LIKE xrca_t.xrca014,
    xrca014_desc      LIKE ooag_t.ooag011,
    xrca015           LIKE xrca_t.xrca015,
    xrca015_desc      LIKE ooefl_t.ooefl003,
    xrccseq           LIKE xrcc_t.xrccseq,
    xrcc001           LIKE xrcc_t.xrcc001,
    xrcc004           LIKE xrcc_t.xrcc004,
    xrcc118           LIKE xrcc_t.xrcc118,
    xrcc119           LIKE xrcc_t.xrcc119
                  END RECORD
DEFINE g_xrca_d       DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_xrca_d_t     type_g_xrca_d

DEFINE g_detail_cnt2  LIKE type_t.num5
DEFINE g_detail_cnt3  LIKE type_t.num5
DEFINE g_detail_cnt4  LIKE type_t.num5
DEFINE g_detail_cnt5  LIKE type_t.num5
DEFINE g_detail_cnt6  LIKE type_t.num5
DEFINE g_detail_cnt7  LIKE type_t.num5
DEFINE g_detail_cnt8  LIKE type_t.num5
#160523-00056#1 20160712 -----(S) 
DEFINE g_detail_cnt9  LIKE type_t.num5
DEFINE g_detail_cnt10 LIKE type_t.num5
#160523-00056#1 20160712 -----(E) 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmda_d            DYNAMIC ARRAY OF type_g_xmda_d
DEFINE g_xmda_d_t          type_g_xmda_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmq500.main" >}
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
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmq500 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmq500_init()   
 
      #進入選單 Menu (="N")
      CALL axmq500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmq500
      
   END IF 
   
   CLOSE axmq500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmq500_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xmdd003','2055')
   CALL cl_set_combo_scc('xmdastus','13')
   CALL cl_set_combo_scc('sfaastus','13')
   CALL cl_set_combo_scc('xmdgstus','13')
   CALL cl_set_combo_scc('xmdkstus','13')
   CALL cl_set_combo_scc('xmdk002','2063')
   CALL cl_set_combo_scc('xmdkstus_1','13')
   CALL cl_set_combo_scc('xmdk082','2088')
   CALL cl_set_combo_scc('xmdkstus_2','13')
   CALL cl_set_combo_scc('xrca001','8302')  #150908
   CALL cl_set_combo_scc('pmdastus','13')  #160523-00056#1 
   CALL cl_set_combo_scc('pmdlstus','13')  #160523-00056#1 
   #end add-point
 
   CALL axmq500_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axmq500.default_search" >}
PRIVATE FUNCTION axmq500_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdadocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmq500_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_xmda_m.xmda004_sel = 'Y'
   LET g_xmda_m.xmdadocno_sel = 'Y'
   LET g_xmda_m.xmdadocdt_sel = 'N'
   LET g_xmda_m.xmda002_sel = 'N'
   LET g_xmda_m.xmda003_sel = 'N'
   LET g_attribute.attribute01 = 'N'
   LET g_attribute.attribute02 = 'N'
   LET g_attribute.attribute03 = 'N'
   LET g_attribute.attribute04 = 'N'
   CALL axmq500_set_visible()
   #end add-point
 
   
   CALL axmq500_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmda_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axmq500_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_xmda_m.xmda004_sel,g_xmda_m.xmdadocno_sel,g_xmda_m.xmdadocdt_sel,
                       g_xmda_m.xmda002_sel,g_xmda_m.xmda003_sel ATTRIBUTE(WITHOUT DEFAULTS)
                       
         END INPUT
         INPUT BY NAME g_attribute.attribute01,g_attribute.attribute02,
                       g_attribute.attribute03,g_attribute.attribute04 ATTRIBUTE(WITHOUT DEFAULTS)
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xmdadocno,xmdadocdt,xmda002,xmda003,xmda033,xmdd001,imaa009,xmdc027    #161026-00019#1 add xmdc027
         
             BEFORE CONSTRUCT
                
              ON ACTION controlp INFIELD xmdadocno
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_xmdadocno()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdadocno  #顯示到畫面上
                NEXT FIELD xmdadocno
                
              ON ACTION controlp INFIELD xmda002
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooag001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
                NEXT FIELD xmda002
                
              ON ACTION controlp INFIELD xmda003
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda003  #顯示到畫面上
                NEXT FIELD xmda003
                
              ON ACTION controlp INFIELD xmda033
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_xmda033()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda033  #顯示到畫面上
                NEXT FIELD xmda033
                
              ON ACTION controlp INFIELD xmdd001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_imaa001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdd001  #顯示到畫面上
               #NEXT FIELD xmdc001                     #161026-00019#1 mark
                NEXT FIELD xmdd001                     #161026-00019#1 add
                
              ON ACTION controlp INFIELD imaa009
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_rtax001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
                NEXT FIELD imaa009
                
              #161026-00019#1 add --(S)--  
              ON ACTION controlp INFIELD xmdc027
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_pmao004_1()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdc027  #顯示到畫面上
                NEXT FIELD xmdc027  
              #161026-00019#1 add --(S)--    
                
          END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmq500_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axmq500_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xmdd_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
         END DISPLAY
         DISPLAY ARRAY g_sfaa_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
         END DISPLAY
         DISPLAY ARRAY g_xmdh_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4)
         END DISPLAY
         DISPLAY ARRAY g_xmdl_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5)
         END DISPLAY
         DISPLAY ARRAY g_xmdk_d TO s_detail6.* ATTRIBUTE(COUNT=g_detail_cnt6)
         END DISPLAY
         DISPLAY ARRAY g_xmdk_d_2 TO s_detail7.* ATTRIBUTE(COUNT=g_detail_cnt7)
         END DISPLAY
         DISPLAY ARRAY g_xrca_d TO s_detail8.* ATTRIBUTE(COUNT=g_detail_cnt8)
         END DISPLAY
         #160523-00056#1 20160712 -----(S) 
         DISPLAY ARRAY g_pmda_d TO s_detail9.* ATTRIBUTE(COUNT=g_detail_cnt9)
         END DISPLAY
         DISPLAY ARRAY g_pmdl_d TO s_detail10.* ATTRIBUTE(COUNT=g_detail_cnt10)
         END DISPLAY
         #160523-00056#1 20160712 -----(E) 
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axmq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD xmdadocno
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
 
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axmq500_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmda_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               LET g_export_node[2] = base.typeInfo.create(g_xmdd_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_sfaa_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_xmdh_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_xmdl_d)
               LET g_export_id[5]   = "s_detail5"
               LET g_export_node[6] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[6]   = "s_detail6"
               LET g_export_node[7] = base.typeInfo.create(g_xmdk_d_2)
               LET g_export_id[7]   = "s_detail7"
               LET g_export_node[8] = base.typeInfo.create(g_xrca_d)
               LET g_export_id[8]   = "s_detail8"
               #160523-00056#1 20160712 -----(S) 
               LET g_export_node[9] = base.typeInfo.create(g_pmda_d)
               LET g_export_id[9]   = "s_detail9"
               LET g_export_node[10] = base.typeInfo.create(g_pmdl_d)
               LET g_export_id[10]   = "s_detail10"
               #160523-00056#1 20160712 -----(E) 
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axmq500_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axmq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axmq500_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axmq500_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axmq500_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmq500_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmq500_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_select        STRING
   DEFINE l_from          STRING
   DEFINE l_where         STRING
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#3 add
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_xmda_m.xmda004_sel = 'N' AND g_xmda_m.xmdadocno_sel = 'N' AND
      g_xmda_m.xmdadocdt_sel = 'N' AND g_xmda_m.xmda002_sel = 'N' AND
      g_xmda_m.xmda003_sel = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aqc-00071'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   CALL ui.interface.refresh()
   CALL axmq500_set_visible()
   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xmda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_xmdd_d.clear()
   CALL g_xrca_d.clear()
   CALL g_xmdk_d_2.clear()
   CALL g_xmdk_d.clear()
   CALL g_xmdl_d.clear()
   CALL g_xmdh_d.clear()
   CALL g_sfaa_d.clear()
   #160523-00056#1 20160712 -----(S) 
   CALL g_pmda_d.clear()
   CALL g_pmdl_d.clear()
   #160523-00056#1 20160712 -----(E) 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xmda004,'',xmdadocno,xmdadocdt,xmda002,'',xmda003,'',xmda033  , 
       DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK FROM xmda_t",
 
 
                     "",
                     " WHERE xmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                     " ORDER BY xmda_t.xmdadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #170209-00005#1 add --(S)--
   LET ls_sql_rank = "SELECT  UNIQUE '',xmda004,'',xmdadocno,xmdadocdt,xmda002,'',xmda003,'',xmda033  , 
       DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK FROM xmda_t",
                     " WHERE xmdaent= ? AND xmdasite = '",g_site,"' AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                     " ORDER BY xmda_t.xmdadocno"
   #170209-00005#1 add --(E)--
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',xmda004,'',xmdadocno,xmdadocdt,xmda002,'',xmda003,'',xmda033",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_select = " SELECT UNIQUE 'Y',"
   LET l_from   = "   FROM xmda_t "
  #LET l_where  = "  WHERE xmdaent = ? AND xmdasite = '",g_site,"' AND xmddent = xmdaent AND xmdddocno = xmdadocno AND ",ls_wc," ORDER BY 1"   #170209-00005#1 mark
   LET l_where  = "  WHERE xmdaent = ? AND xmdasite = '",g_site,"' AND ",ls_wc," ORDER BY 1"                                                   #170209-00005#1 add
   
   IF g_xmda_m.xmda004_sel = 'Y' THEN
#160503-00030#12-s mod
#      LET l_select = l_select,"xmda004,pmaal004,"
#      LET l_from = l_from," LEFT JOIN pmaal_t ON pmaalent = xmdaent AND pmaal001 = xmda004 AND pmaal002 = '",g_dlang,"'"    
      LET l_select = l_select,"xmda004,",
                              "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdaent AND pmaal001=xmda004 AND pmaal002='",g_dlang,"'),"
#160503-00030#12-e mod
      LET l_where = l_where,",xmda004"
   ELSE
      LET l_select = l_select,"'','',"
   END IF
   
   IF g_xmda_m.xmdadocno_sel = 'Y' THEN
      LET l_select = l_select,"xmdadocno,"
      LET l_where = l_where,",xmdadocno"
   ELSE 
      LET l_select = l_select,"'',"
   END IF
    
   IF g_xmda_m.xmdadocdt_sel = 'Y' THEN
      LET l_select = l_select,"xmdadocdt,"
      LET l_where = l_where,",xmdadocdt"
   ELSE
      LET l_select = l_select,"''," 
   END IF
   
   IF g_xmda_m.xmda002_sel = 'Y' THEN
#160503-00030#12-s mod
#      LET l_select = l_select,"xmda002,ooag011,"
#      LET l_from = l_from," LEFT JOIN ooag_t  ON ooagent  = xmdaent AND ooag001  = xmda002" 
      LET l_select = l_select,"xmda002,",
                              "(SELECT ooag011 FROM ooag_t WHERE ooagent=xmdaent AND ooag001=xmda002),"
#160503-00030#12-e mod
      LET l_where = l_where,",xmda002"
   ELSE
      LET l_select = l_select,"'','',"
   END IF
   
   IF g_xmda_m.xmda003_sel = 'Y' THEN
#160503-00030#12-s mod
#      LET l_select = l_select,"xmda003,ooefl003,"
#      LET l_from = l_from," LEFT JOIN ooefl_t  ON ooeflent  = xmdaent AND ooefl001  = xmda003 AND ooefl002 = '",g_dlang,"'" 
      LET l_select = l_select,"xmda003,",
                              "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmda003 AND ooefl002='",g_dlang,"'),"
#160503-00030#12-e mod
      LET l_where = l_where,",xmda003"
   ELSE
      LET l_select = l_select,"'','',"
   END IF
   
   IF g_xmda_m.xmdadocno_sel = 'Y' THEN
      LET l_select = l_select,"xmda033"
   ELSE
      LET l_select = l_select,"''"
   END IF
#160503-00030#12-s mod
#   LET l_from = l_from," LEFT OUTER JOIN (SELECT * FROM xmdd_t ) x ON x.xmddent = xmda_t.xmdaent AND x.xmdddocno = xmda_t.xmdadocno ",
   LET l_from = l_from," LEFT OUTER JOIN (SELECT * FROM xmdd_t WHERE xmddent=",g_enterprise," AND xmddsite='",g_site,"') x ON x.xmddent = xmda_t.xmdaent AND x.xmdddocno = xmda_t.xmdadocno ",
#160503-00030#12-e mod
                       " LEFT OUTER JOIN (SELECT * FROM xmdc_t WHERE xmdcent=",g_enterprise," AND xmdcsite='",g_site,"') y ON y.xmdcent = xmda_t.xmdaent AND y.xmdcdocno = xmda_t.xmdadocno ",        #161026-00019#1 add
                       " LEFT JOIN imaa_t  ON imaaent = x.xmddent AND imaa001 = x.xmdd001 "

   LET g_sql = l_select CLIPPED ," ",l_from CLIPPED ," ",l_where CLIPPED
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axmq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmq500_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmda_d[l_ac].sel,g_xmda_d[l_ac].xmda004,g_xmda_d[l_ac].xmda004_desc,g_xmda_d[l_ac].xmdadocno, 
       g_xmda_d[l_ac].xmdadocdt,g_xmda_d[l_ac].xmda002,g_xmda_d[l_ac].xmda002_desc,g_xmda_d[l_ac].xmda003, 
       g_xmda_d[l_ac].xmda003_desc,g_xmda_d[l_ac].xmda033
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #161207-00033#3-s-add
      #取得客戶對應的法人類型
      LET l_pmaa004 = ''
      SELECT pmaa004 INTO l_pmaa004
        FROM pmaa_t WHERE pmaaent=g_enterprise AND pmaa001 = g_xmda_d[l_ac].xmda004
      IF l_pmaa004 = '2' THEN 
         #一次性交易對象全名
         CALL s_desc_axm_get_oneturn_guest_desc('1',g_xmda_d[l_ac].xmdadocno)
              RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmda_d[l_ac].xmda004_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add  
      #end add-point
 
      CALL axmq500_detail_show("'1'")
 
      CALL axmq500_xmda_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xmda_d.deleteElement(g_xmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axmq500_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axmq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axmq500_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmda_d.getLength() > 0 THEN
      CALL axmq500_b_fill2()
   END IF
 
      CALL axmq500_filter_show('xmda004','b_xmda004')
   CALL axmq500_filter_show('xmdadocno','b_xmdadocno')
   CALL axmq500_filter_show('xmdadocdt','b_xmdadocdt')
   CALL axmq500_filter_show('xmda002','b_xmda002')
   CALL axmq500_filter_show('xmda003','b_xmda003')
   CALL axmq500_filter_show('xmda033','b_xmda033')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmq500_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_xmdd006       LIKE xmdd_t.xmdd006   #161104-00031#1 xmdd005 mod xmdd006
   DEFINE l_xmdh016       LIKE xmdh_t.xmdh016
   DEFINE l_xmdl018       LIKE xmdl_t.xmdl018
   DEFINE l_xrcc118       LIKE xrcc_t.xrcc118
   DEFINE l_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE l_sql           STRING
   DEFINE l_sql_xmdk      STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql3          STRING
   DEFINE l_sql4          STRING
   DEFINE l_sql5          STRING
   DEFINE l_sql6          STRING
   DEFINE l_sql7          STRING
   DEFINE l_sql8          STRING              #160523-00056#1 20160712 
   DEFINE l_oocql_sql     STRING
   DEFINE l_gzcb004       LIKE gzcb_t.gzcb004
   DEFINE l_xmda_count    LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_select        STRING              #160503-00030#12
   DEFINE l_where         STRING              #160503-00030#12
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#3 add
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_xmdd_d.clear()
   CALL g_xrca_d.clear()
   CALL g_xmdk_d_2.clear()
   CALL g_xmdk_d.clear()
   CALL g_xmdl_d.clear()
   CALL g_xmdh_d.clear()
   CALL g_sfaa_d.clear()
   
   IF g_wc = ' 1=2' THEN
      RETURN
   END IF

#160503-00030#12-s add
   IF cl_null(g_xmda_d[g_detail_idx].xmda004)   THEN LET g_xmda_d[g_detail_idx].xmda004=' ' END IF
   IF cl_null(g_xmda_d[g_detail_idx].xmdadocno) THEN LET g_xmda_d[g_detail_idx].xmdadocno=' ' END IF
   IF cl_null(g_xmda_d[g_detail_idx].xmdadocdt) THEN LET g_xmda_d[g_detail_idx].xmdadocdt=g_today END IF
   IF cl_null(g_xmda_d[g_detail_idx].xmda002)   THEN LET g_xmda_d[g_detail_idx].xmda002=' ' END IF
   IF cl_null(g_xmda_d[g_detail_idx].xmda003)   THEN LET g_xmda_d[g_detail_idx].xmda003=' ' END IF
#160503-00030#12-e add

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
#160503-00030#12-s add
      LET l_select = " "
      IF g_xmda_m.xmda004_sel = 'Y' THEN
         LET l_select = l_select,",xmda004  xmda004_sel"
      ELSE
         LET l_select = l_select,",' '  xmda004_sel"
      END IF
      IF g_xmda_m.xmdadocno_sel = 'Y' THEN
         LET l_select = l_select,",xmdadocno  xmdadocno_sel"
      ELSE
         LET l_select = l_select,",' '  xmdadocno_sel"
      END IF
      IF g_xmda_m.xmdadocdt_sel = 'Y' THEN
         LET l_select = l_select,",xmdadocdt  xmdadocdt_sel"
      ELSE
         LET l_select = l_select,",'",g_today,"' xmdadocdt_sel"
      END IF
      IF g_xmda_m.xmda002_sel = 'Y' THEN
         LET l_select = l_select,",xmda002  xmda002_sel"
      ELSE
         LET l_select = l_select,",' '  xmda002_sel"
      END IF
      IF g_xmda_m.xmda003_sel = 'Y' THEN
         LET l_select = l_select,",xmda003  xmda003_sel"
      ELSE
         LET l_select = l_select,",' '  xmda003_sel"
      END IF
      
      IF g_attribute.attribute01 = 'Y' THEN   #訂單明細僅顯示未交資料        
         LET l_where = " (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)) > 0"   #161104-00031#1 xmdd005 mod xmdd006
      ELSE
         LET l_where = " 1=1"
      END IF
#160503-00030#12-e add   
   
#160503-00030#12-s mod
      #訂單明細
#      LET g_sql = " SELECT xmdadocno,xmdadocdt,xmda004,pmaal004,xmda002,ooag011,xmda003,ooefl003,xmda033,xmddseq,",
#                  "        xmddseq1,xmddseq2,xmdd003,xmdd001,imaal003,imaal004,xmdd002,'',xmdd005,xmdd004,",
#                  "        oocal003,xmdd011,xmdd031,xmdd014,xmdd015,xmdd016,xmdc050,xmdastus",
#                  "   FROM xmda_t",
#                  "   LEFT JOIN pmaal_t ON pmaalent = xmdaent AND pmaal001 = xmda004 AND pmaal002 = '",g_dlang,"'",
#                  "   LEFT JOIN ooag_t  ON ooagent  = xmdaent AND ooag001  = xmda002",
#                  "   LEFT JOIN ooefl_t ON ooeflent = xmdaent AND ooefl001 = xmda003 AND ooefl002 = '",g_dlang,"'",
#                  "   LEFT OUTER JOIN ",
#                  "( SELECT xmdd_t.*,imaal_t.imaal003 imaal003,imaal_t.imaal004 imaal004,oocal_t.oocal003 oocal003 ",
#                  "    FROM xmdd_t",
#                  "    LEFT JOIN imaal_t ON imaalent = xmddent AND imaal001 = xmdd001 AND imaal002 = '",g_dlang,"'",
#                  "    LEFT JOIN oocal_t ON oocalent = xmddent AND oocal001 = xmdd004 AND oocal002 = '",g_dlang,"'",
#                  ") x  ON xmda_t.xmdaent = x.xmddent AND xmda_t.xmdasite = x.xmddsite AND xmda_t.xmdadocno = x.xmdddocno",
#                  "   LEFT OUTER JOIN xmdc_t y ON xmdaent = y.xmdcent AND xmdasite = y.xmdcsite AND xmdadocno = y.xmdcdocno",
#                  "  WHERE xmdaent = ",g_enterprise," AND xmdasite = '",g_site,"'",
#                  "    AND x.xmddseq = y.xmdcseq AND ",g_wc
      LET g_sql = "SELECT xmdadocno,xmdadocdt,xmda004,xmda004_desc,xmda002,xmda002_desc,xmda003,xmda003_desc,",
                  "       xmda033,xmddseq,xmddseq1,xmddseq2,xmdd003,xmdd001,xmdd001_desc,xmdd001_desc1,",
                  "       xmdc027,xmdc027_desc,xmdc027_desc_1,",                     #161026-00019#1 add      
                  "       xmdd002,xmdd002_desc,xmdd006,xmdd004,xmdd004_desc,",       #161104-00031#1 xmdd005 mod xmdd006
                  "       xmdd011,xmdd031,xmdd014,xmdd015,xmdd016,xmdc050,xmdastus",
                  "        ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent='",g_enterprise,"' AND pmaa001=xmda004) pmaa004 ",  #161207-00033#3-add
                  "  FROM (",
                  " SELECT xmdadocno,xmdadocdt,xmda004,",
                  "        (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdaent AND pmaal001=xmda004 AND pmaal002='",g_dlang,"') xmda004_desc,",  
                  "        xmda002,",
                  "        (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdaent AND ooag001=xmda002) xmda002_desc,",
                  "        xmda003,",
                  "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdaent AND ooefl001=xmda003 AND ooefl002='",g_dlang,"') xmda003_desc,",
                  "        xmda033,xmddseq,",
                  "        xmddseq1,xmddseq2,xmdd003,xmdd001,",
                  "        (SELECT imaal003 FROM imaal_t WHERE imaalent=xmddent AND imaal001=xmdd001 AND imaal002='",g_dlang,"') xmdd001_desc,",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent=xmddent AND imaal001=xmdd001 AND imaal002='",g_dlang,"') xmdd001_desc1,",
                  "        xmdd002,xmdc027,",         #161026-00019#1 add xmdc027
                  #161221-00064#19 mod-S
#                  "        (SELECT pmao009 FROM pmao_t WHERE pmaoent=xmdcent AND pmao001=xmda004 AND pmao002=xmdd001 AND pmao003=xmdd002 AND pmao004=xmdc027) xmdc027_desc,",     #161026-00019#1 add
#                  "        (SELECT pmao010 FROM pmao_t WHERE pmaoent=xmdcent AND pmao001=xmda004 AND pmao002=xmdd001 AND pmao003=xmdd002 AND pmao004=xmdc027) xmdc027_desc_1,",     #161026-00019#1 add
                  "        (SELECT pmao009 FROM pmao_t WHERE pmaoent=xmdcent AND pmao001=xmda004 AND pmao002=xmdd001 AND pmao003=xmdd002 AND pmao004=xmdc027 AND pmao000 = '2') xmdc027_desc,",     #161026-00019#1 add
                  "        (SELECT pmao010 FROM pmao_t WHERE pmaoent=xmdcent AND pmao001=xmda004 AND pmao002=xmdd001 AND pmao003=xmdd002 AND pmao004=xmdc027 AND pmao000 = '2') xmdc027_desc_1,",     #161026-00019#1 add
                  #161221-00064#19 mod-E
                  "        (SELECT inaml004 FROM inaml_t WHERE inamlent=xmddent AND inaml001=xmdd001 AND inaml002=xmdd002 AND inaml003='",g_dlang,"') xmdd002_desc,",
                  "        xmdd006,xmdd004,",         #161104-00031#1 xmdd005 mod xmdd006
                  "        (SELECT oocal003 FROM oocal_t WHERE oocalent=xmddent AND oocal001=xmdd004 AND oocal002='",g_dlang,"') xmdd004_desc,",
                  "        xmdd011,xmdd031,xmdd014,xmdd015,xmdd016,",
                  "        (SELECT xmdc050 FROM xmdc_t WHERE xmdcent=xmddent AND xmdcdocno=xmdddocno AND xmdcseq=xmddseq) xmdc050,",
                  "        xmdastus",l_select,
                  "   FROM xmda_t",
                 #"   LEFT OUTER JOIN xmdd_t ON xmdaent = xmddent AND xmdasite = xmddsite AND xmdadocno = xmdddocno",             #161026-00019#1 mark
                  "   JOIN xmdd_t ON xmdaent = xmddent AND xmdasite = xmddsite AND xmdadocno = xmdddocno",                        #161026-00019#1 add
                  "   JOIN xmdc_t ON xmdcent = xmddent AND xmdcsite = xmddsite AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq",  #161026-00019#1 add
                  "   JOIN imaa_t ON xmddent = imaaent AND xmdd001 = imaa001",                                                    #161027-00003#1 add 
                  "  WHERE xmdaent = ? AND xmdasite = ?",
                  "    AND ",g_wc,
                  "    AND ",l_where,")",
                  " WHERE xmda004_sel = COALESCE(?,' ')",
                  "   AND xmdadocno_sel = COALESCE(?,' ')",
                  "   AND xmdadocdt_sel = ?",
                  "   AND xmda002_sel = COALESCE(?,' ')",
                  "   AND xmda003_sel = COALESCE(?,' ')",
                  " ORDER BY xmda004_sel,xmdadocno_sel,xmdadocdt_sel,xmda002_sel,xmda003_sel"
#160503-00030#12-e mod

#160503-00030#12-s mod
#      LET l_sql = " SELECT xmdadocno ",
#                  "   FROM xmda_t ",
#                  "   LEFT OUTER JOIN (SELECT * FROM xmdd_t ) x ON x.xmddent = xmda_t.xmdaent AND x.xmdddocno = xmda_t.xmdadocno",
#                  "   LEFT JOIN imaa_t  ON imaaent = x.xmddent AND imaa001 = x.xmdd001 ",
#                  "  WHERE xmdaent = ",g_enterprise," AND xmdasite = '",g_site,"'",
#                  "    AND xmddent = xmdaent AND xmdddocno = xmdadocno AND ",g_wc
      LET l_sql = " SELECT xmdadocno FROM (",
                  " SELECT xmdadocno ",l_select,
                  "   FROM xmda_t ",
                  "   LEFT OUTER JOIN (SELECT * FROM xmdd_t ) x ON x.xmddent = xmda_t.xmdaent AND x.xmdddocno = xmda_t.xmdadocno",
                  "   LEFT OUTER JOIN (SELECT * FROM xmdc_t ) y ON y.xmdcent = xmda_t.xmdaent AND y.xmdcdocno = xmda_t.xmdadocno ",        #161026-00019#1 add
                  "   LEFT JOIN imaa_t  ON imaaent = x.xmddent AND imaa001 = x.xmdd001 ",
                  "  WHERE xmdaent = ? AND xmdasite = ?",
                  "    AND ",g_wc,
                  "    AND ",l_where,")",
                  " WHERE xmda004_sel = COALESCE(?,' ')",
                  "   AND xmdadocno_sel = COALESCE(?,' ')",
                  "   AND xmdadocdt_sel = ?",
                  "   AND xmda002_sel = COALESCE(?,' ')",
                  "   AND xmda003_sel = COALESCE(?,' ')"
#160503-00030#12-e mod

#160503-00030#12-s mark
#      IF g_xmda_m.xmda004_sel = 'Y' AND NOT cl_null(g_xmda_d[g_detail_idx].xmda004) THEN
#         LET g_sql = g_sql," AND xmda004 = '",g_xmda_d[g_detail_idx].xmda004,"'"
#         LET l_sql = l_sql," AND xmda004 = '",g_xmda_d[g_detail_idx].xmda004,"'"
#      END IF
#      
#      IF g_xmda_m.xmdadocno_sel = 'Y' AND NOT cl_null(g_xmda_d[g_detail_idx].xmdadocno) THEN
#         LET g_sql = g_sql," AND xmdadocno = '",g_xmda_d[g_detail_idx].xmdadocno,"'"
#         LET l_sql = l_sql," AND xmdadocno = '",g_xmda_d[g_detail_idx].xmdadocno,"'"
#      END IF
#      
#      IF g_xmda_m.xmdadocdt_sel = 'Y' AND NOT cl_null(g_xmda_d[g_detail_idx].xmdadocdt) THEN
#         LET g_sql = g_sql," AND xmdadocdt = '",g_xmda_d[g_detail_idx].xmdadocdt,"'"
#         LET l_sql = l_sql," AND xmdadocdt = '",g_xmda_d[g_detail_idx].xmdadocdt,"'"
#      END IF
#      
#      IF g_xmda_m.xmda002_sel = 'Y' AND NOT cl_null(g_xmda_d[g_detail_idx].xmda002) THEN
#         LET g_sql = g_sql," AND xmda002 = '",g_xmda_d[g_detail_idx].xmda002,"'"
#         LET l_sql = l_sql," AND xmda002 = '",g_xmda_d[g_detail_idx].xmda002,"'"
#      END IF
#      
#      IF g_xmda_m.xmda003_sel = 'Y' AND NOT cl_null(g_xmda_d[g_detail_idx].xmda003) THEN
#         LET g_sql = g_sql," AND xmda003 = '",g_xmda_d[g_detail_idx].xmda003,"'"
#         LET l_sql = l_sql," AND xmda003 = '",g_xmda_d[g_detail_idx].xmda003,"'"
#      END IF
#     
#      LET g_sql = g_sql," ORDER BY 1"
#      
#      IF g_xmda_m.xmda004_sel = 'Y' THEN
#         LET g_sql = g_sql,",xmda004"
#      END IF
#      
#      IF g_xmda_m.xmdadocno_sel = 'Y' THEN
#         LET g_sql = g_sql,",xmdadocno"
#      END IF
#       
#      IF g_xmda_m.xmdadocdt_sel = 'Y' THEN
#         LET g_sql = g_sql,",xmdadocdt"
#      END IF
#      
#      IF g_xmda_m.xmda002_sel = 'Y' THEN
#         LET g_sql = g_sql,",xmda002"
#      END IF
#      
#      IF g_xmda_m.xmda003_sel = 'Y' THEN
#         LET g_sql = g_sql,",xmda003"
#      END IF
#160503-00030#12-e mark
      
      LET l_sql_xmdk = " SELECT xmdkdocno ",
                       "   FROM xmdk_t,xmdl_t ",
                       "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno",
                       "    AND xmdkent = ? AND xmdksite = ?",
                       "    AND xmdk000 IN ('1','6') AND xmdl003 IN (",l_sql,")"
      
      PREPARE axmq500_xmdadocno FROM l_sql
      DECLARE axmq500_xmdadocno_curs CURSOR FOR axmq500_xmdadocno

      PREPARE axmq500_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR axmq500_pb2
   END IF    #160503-00030#12 add

#160503-00030#12-s mod
#   EXECUTE axmq500_xmdadocno INTO l_xmdadocno
   OPEN axmq500_xmdadocno_curs USING g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
   FETCH axmq500_xmdadocno_curs INTO l_xmdadocno
#160503-00030#12-e mod

   LET l_ac = 1
   LET l_pmaa004 = '' #161207-00033#3-add
#161207-00033#3-s-mod 多l_pmaa004
##160503-00030#12-s mod
##   FOREACH b_fill_curs2 INTO g_xmdd_d[l_ac].*
#   FOREACH b_fill_curs2
#     USING g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
#      INTO g_xmdd_d[l_ac].*
##160503-00030#12-e mod   
   FOREACH b_fill_curs2
     USING g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xmdd_d[l_ac].*,l_pmaa004
#161207-00033#3-e-mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF cl_null(g_xmdd_d[l_ac].xmdd006) THEN LET g_xmdd_d[l_ac].xmdd006 = 0 END IF  #161104-00031#1 xmdd005 mod xmdd006
      IF cl_null(g_xmdd_d[l_ac].xmdd014) THEN LET g_xmdd_d[l_ac].xmdd014 = 0 END IF
      IF cl_null(g_xmdd_d[l_ac].xmdd016) THEN LET g_xmdd_d[l_ac].xmdd016 = 0 END IF
#160503-00030#12-s mark
#      LET l_xmdd005 = g_xmdd_d[l_ac].xmdd005 - g_xmdd_d[l_ac].xmdd014 + g_xmdd_d[l_ac].xmdd016
#      IF l_xmdd005 <= 0 AND g_attribute.attribute01 = 'Y' THEN
#         CONTINUE FOREACH
#      END  IF
#
#      CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002)
#           RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc
#160503-00030#12-e mark
      #161207-00033#3-s-add
      IF l_pmaa004 = '2' THEN
         CALL s_desc_axm_get_oneturn_guest_desc('1',g_xmdd_d[l_ac].xmdadocno_1) RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdd_d[l_ac].xmda004_1_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
      #工單生產明細
#160503-00030#12-s mod
#      LET l_sql2 = "SELECT sfaadocno,sfaadocdt,sfaa002,ooag011,sfaa006,sfaa007,'',sfaa009,pmaal004,sfaa010,",
#                   "       imaal003,imaal004,sfaa013,oocal003,sfaa012,sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,sfaastus",
#                   "  FROM sfaa_t LEFT JOIN pmaal_t ON pmaalent = sfaaent AND pmaal001 = sfaa009 AND pmaal002 = '",g_dlang,"'",
#                   "              LEFT JOIN ooag_t  ON ooagent  = sfaaent AND ooag001  = sfaa002",
#                   "              LEFT JOIN imaal_t ON imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_dlang,"'",
#                   "              LEFT JOIN oocal_t ON oocalent = sfaaent AND oocal001 = sfaa013 AND oocal002 = '",g_dlang,"'",
#                   " WHERE sfaaent = ",g_enterprise," AND sfaasite = '",g_site,"' AND sfaa006 IN (",l_sql,")",
#                   " ORDER BY sfaadocno,sfaa006,sfaa007"                   
      LET l_sql2 = "SELECT sfaadocno,sfaadocdt,sfaa002,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=sfaaent AND ooag001=sfaa002),",
                   "       sfaa006,sfaa007,",
                   "       (SELECT xmda033 FROM xmda_t WHERE xmdaent=sfaaent AND xmdadocno=sfaa006),",
                   "       sfaa009,",
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=sfaaent AND pmaal001=sfaa009 AND pmaal002='",g_dlang,"'),",
                   "       sfaa010,",
                   "       (SELECT imaal003 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"'),",
                   "       (SELECT imaal004 FROM imaal_t WHERE imaalent=sfaaent AND imaal001=sfaa010 AND imaal002='",g_dlang,"'),",
                   "       sfaa013,",
                   "       (SELECT oocal003 FROM oocal_t WHERE oocalent=sfaaent AND oocal001=sfaa013 AND oocal002='",g_dlang,"'),",
                   "       sfaa012,sfaa049,sfaa050,sfaa051,sfaa055,sfaa056,sfaastus",
                   "  FROM sfaa_t",
                   "       LEFT JOIN sfab_t ON sfabent = sfaaent AND sfabdocno = sfaadocno AND sfabsite = sfaasite ",   #161014-00022#1 add
                  #" WHERE sfaaent = ? AND sfaasite = ? AND sfaa006 IN (",l_sql,")",    #161014-00022#1 mark
                   " WHERE sfaaent = ? AND sfaasite = ? AND sfab002 IN (",l_sql,")",    #161014-00022#1 add
                   " ORDER BY sfaadocno,sfaa006,sfaa007" 
#160503-00030#12-e mod                   
                   
      PREPARE axmq500_sfaa FROM l_sql2
      DECLARE b_fill_sfaa CURSOR FOR axmq500_sfaa
   END IF   #160503-00030#12 add

   LET l_ac = 1
   
#160503-00030#12-s mod
#   FOREACH b_fill_sfaa INTO g_sfaa_d[l_ac].*
   FOREACH b_fill_sfaa
     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_sfaa_d[l_ac].*
#160503-00030#12-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

#160503-00030#12-s mark
#      CALL axmq500_get_xmda033(g_sfaa_d[l_ac].sfaa006)
#           RETURNING g_sfaa_d[l_ac].xmda033_2
#160503-00030#12-s mark

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH
   
   #160523-00056#1 20160712 -----(S) 
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET l_sql8 = "SELECT pmdadocno,pmdadocdt,pmda002,(SELECT ooag011 FROM ooag_t ", 
                   "                                     WHERE ooagent = '",g_enterprise,"' ", 
                   "                                       AND ooag001 = pmda002), ",
                   "       pmda003,(SELECT ooefl003 FROM ooefl_t ", 
                   "                 WHERE ooeflent = '",g_enterprise,"' ", 
                   "                   AND ooefl001 = pmda003 ", 
                   "                   AND ooefl002 = '",g_dlang,"'), ", 
                   "       pmdbseq,pmdb002, ", 
                   "       pmdb004,(SELECT imaal003 FROM imaal_t ", 
                   "                 WHERE imaalent = '",g_enterprise,"' ", 
                   "                   AND imaal001 = pmdb004 ", 
                   "                   AND imaal002 = '",g_dlang,"' ), ", 
                   "       (SELECT imaal004 FROM imaal_t ", 
                   "         WHERE imaalent = '",g_enterprise,"' ", 
                   "           AND imaal001 = pmdb004 ", 
                   "           AND imaal002 = '",g_dlang,"' ),", 
                   "       pmdb005,(SELECT inaml004 FROM inaml_t ", 
                   "                 WHERE inamlent = '",g_enterprise,"' ", 
                   "                   AND inaml001 = pmdb004 ", 
                   "                   AND inaml002 = pmdb005 ", 
                   "                   AND inaml003 = '",g_dlang,"' ), ", 
                   "       pmdb007,(SELECT oocal003 FROM oocal_t ", 
                   "                 WHERE oocalent = '",g_enterprise,"' ", 
                   "                   AND oocal001 = pmdb007 ", 
                   "                   AND oocal002 = '",g_dlang,"' ),",
                   "       pmdb006,pmdb030,pmdb049,pmdb050,pmdastus ",
                   "  FROM pmda_t,pmdb_t ",
                   " WHERE pmdaent   = pmdbent ",
                   "   AND pmdadocno = pmdbdocno ",
                   "   AND pmdaent   = '",g_enterprise,"' ",
                   "   AND pmdasite  = '",g_site,"' ",
                   "   AND pmdb001 IN (",l_sql,") "
      PREPARE axmq500_pmda FROM l_sql8
      DECLARE b_fill_pmda CURSOR FOR axmq500_pmda

      LET l_sql8 = "SELECT pmdldocno,pmdldocdt,pmdl004,(SELECT pmaal004 FROM pmaal_t ", 
                   "                                     WHERE pmaalent = '",g_enterprise,"' ", 
                   "                                       AND pmaal001 = pmdl004 ", 
                   "                                       AND pmaal002 = '",g_dlang,"' ), ", 
                   "       pmdl002,(SELECT ooag011 FROM ooag_t ", 
                   "                 WHERE ooagent = '",g_enterprise,"' ", 
                   "                   AND ooag001 = pmdl002 ), ", 
                   "       pmdl003,(SELECT ooefl003 FROM ooefl_t ", 
                   "                 WHERE ooeflent = '",g_enterprise,"' ",
                   "                   AND ooefl001 = pmdl003 ", 
                   "                   AND ooefl002 = '",g_dlang,"' ), ",
                   "       pmdnseq,pmdpseq1,pmdp004,pmdn001, ", 
                   "       (SELECT imaal003 FROM imaal_t ", 
                   "         WHERE imaalent = '",g_enterprise,"' ", 
                   "           AND imaal001 = pmdn001 ", 
                   "           AND imaal002 = '",g_dlang,"' ),",
                   "       (SELECT imaal004 FROM imaal_t ", 
                   "         WHERE imaalent = '",g_enterprise,"' ", 
                   "           AND imaal001 = pmdn001 ", 
                   "           AND imaal002 = '",g_dlang,"' ),",
                   "       pmdn002,(SELECT inaml004 FROM inaml_t ", 
                   "                 WHERE inamlent = '",g_enterprise,"' ", 
                   "                   AND inaml001 = pmdn001 ", 
                   "                   AND inaml002 = pmdn002 ", 
                   "                   AND inaml003 = '",g_dlang,"' ), ", 
                   "       pmdn006,(SELECT oocal003 FROM oocal_t ", 
                   "                 WHERE oocalent = '",g_enterprise,"' ", 
                   "                   AND oocal001 = pmdn006 ", 
                   "                   AND oocal002 = '",g_dlang,"' ), ",
                   "       pmdp024,pmdn012,pmdp025,pmdp026,pmdn050,pmdlstus ",
                   "  FROM pmdl_t,pmdn_t,pmdp_t ",
                   " WHERE pmdlent   = pmdnent ",
                   "   AND pmdldocno = pmdndocno ",
                   "   AND pmdlent   = pmdpent ",
                   "   AND pmdldocno = pmdpdocno ",
                   "   AND pmdnseq   = pmdpseq ",
                   "   AND pmdl007   = '3' ",
                  #"   AND pmdlstus  = 'Y' ", #160725-00024#1 mark
                   "   AND pmdlent   = '",g_enterprise,"' ",
                   "   AND pmdlsite  = '",g_site,"' ",
                   "   AND pmdp003  IN (",l_sql,") "
      PREPARE axmq500_pmdl FROM l_sql8
      DECLARE b_fill_pmdl CURSOR FOR axmq500_pmdl

   END IF 
   
   LET l_ac = 1
   FOREACH b_fill_pmda USING g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,
                             g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,
                             g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
                        INTO g_pmda_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH

      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   =  9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_ac = 1
   FOREACH b_fill_pmdl USING g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,
                             g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt, 
                             g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
                        INTO g_pmdl_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   =  9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   #160523-00056#1 20160712 -----(E) 

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
      #出貨通知單明細
#160503-00030#12-s mod
#      LET l_sql3 = "   SELECT xmdgdocno,xmdgdocdt,xmdg005,pmaal004,xmdg002,ooag011,xmdg003,ooefl003,xmdhseq,",
#                   "          xmdh001,xmdh002,'',xmdh006,imaal003,imaal004,xmdh007,'',xmdh015,oocal003,xmdh016,xmdh030,xmdh050,xmdgstus",
#                   "     FROM xmdg_t LEFT JOIN pmaal_t ON pmaalent = xmdgent AND pmaal001 = xmdg005 AND pmaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN ooag_t  ON ooagent  = xmdgent AND ooag001  = xmdg002",
#                   "                 LEFT JOIN ooefl_t ON ooeflent = xmdgent AND ooefl001 = xmdg003 AND ooefl002 = '",g_dlang,"'",
#                   "                 LEFT OUTER JOIN ( SELECT xmdh_t.*,imaal_t.imaal003 imaal003,imaal_t.imaal004 imaal004,oocal_t.oocal003 oocal003 ",
#                   "     FROM xmdh_t LEFT JOIN imaal_t ON imaalent = xmdhent AND imaal001 = xmdh006 AND imaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocal_t ON oocalent = xmdhent AND oocal001 = xmdh015 AND oocal002 = '",g_dlang,"'",
#                   ") x  ON xmdg_t.xmdgent = x.xmdhent AND xmdg_t.xmdgsite = x.xmdhsite AND xmdg_t.xmdgdocno = x.xmdhdocno ",
#                   "  WHERE xmdgent = ",g_enterprise," AND xmdgsite = '",g_site,"' AND x.xmdh001 IN (",l_sql,")",
#                   "  ORDER BY xmdgdocno,xmdhseq,xmdh001,xmdh002"
      LET l_sql3 = "SELECT xmdgdocno,xmdgdocdt,xmdg005,",
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdgent AND pmaal001=xmdg005 AND pmaal002='",g_dlang,"'),",
                   "       xmdg002,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdgent AND ooag001=xmdg002),",
                   "       xmdg003,",
                   "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdgent AND ooefl001=xmdg003 AND ooefl002='",g_dlang,"'),",
                   "       xmdhseq,xmdh001,xmdh002,",
                   "       (SELECT xmda033 FROM xmda_t WHERE xmdaent=xmdhent AND xmdadocno=xmdh001),",
                   "       xmdh006,",
                   "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdhent AND imaal001=xmdh006 AND imaal002='",g_dlang,"'),",
                   "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdhent AND imaal001=xmdh006 AND imaal002='",g_dlang,"'),",
                   "       xmdh007,",
                   "       (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdhent AND inaml001=xmdh006 AND inaml002=xmdh007 AND inaml003='",g_dlang,"'),",
                   "       xmdh015,",
                   "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xmdhent AND oocal001=xmdh015 AND oocal002='",g_dlang,"'),",
                   "       xmdh016,xmdh030,xmdh050,xmdgstus",
                   "       ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdgent AND pmaa001=xmdg005) pmaa004 ",  #161207-00033#3-add
                   "  FROM xmdg_t,xmdh_t",
                   " WHERE xmdgent=xmdhent AND xmdgsite=xmdhsite AND xmdgdocno=xmdhdocno",
                   "   AND xmdgent = ? AND xmdgsite = ? AND xmdh001 IN (",l_sql,")"
#160503-00030#12-e mod

#160503-00030#12-s add
      IF g_attribute.attribute02 = 'Y' THEN   #出貨通知明細僅顯示未出貨量
         LET l_sql3 = l_sql3," AND (COALESCE(xmdh016,0)-COALESCE(xmdh030,0)) > 0"
      END IF
      LET l_sql3 = l_sql3,"  ORDER BY xmdgdocno,xmdhseq,xmdh001,xmdh002"
#160503-00030#12-e add

      PREPARE axmq500_xmdh FROM l_sql3
      DECLARE b_fill_xmdh CURSOR FOR axmq500_xmdh
   END IF   #160503-00030#12 add
   
   LET l_ac = 1
   LET l_pmaa004 = '' #161207-00033#3-add
#161207-00033#3-s-mod 多l_pmaa004
##160503-00030#12-s mod
##   FOREACH b_fill_xmdh INTO g_xmdh_d[l_ac].*
#   FOREACH b_fill_xmdh
#     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
#      INTO g_xmdh_d[l_ac].*
##160503-00030#12-e mod
   FOREACH b_fill_xmdh
     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xmdh_d[l_ac].*,l_pmaa004
#161207-00033#3-e-mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF cl_null(g_xmdh_d[l_ac].xmdh016) THEN LET g_xmdh_d[l_ac].xmdh016 = 0 END IF
      IF cl_null(g_xmdh_d[l_ac].xmdh030) THEN LET g_xmdh_d[l_ac].xmdh030 = 0 END IF
#160503-00030#12-s mark
#      LET l_xmdh016 = g_xmdh_d[l_ac].xmdh016 - g_xmdh_d[l_ac].xmdh030
#      IF l_xmdh016 <= 0 AND g_attribute.attribute02 = 'Y' THEN
#         CONTINUE FOREACH
#      END IF
#      
#      CALL s_feature_description(g_xmdh_d[l_ac].xmdh006,g_xmdh_d[l_ac].xmdh007)
#           RETURNING l_success,g_xmdh_d[l_ac].xmdh007_desc
#
#      CALL axmq500_get_xmda033(g_xmdh_d[l_ac].xmdh001)
#           RETURNING g_xmdh_d[l_ac].xmda033_3
#160503-00030#12-e mark
      #161207-00033#3-s-add
      IF l_pmaa004 = '2' THEN
         CALL s_desc_axm_get_oneturn_guest_desc('2',g_xmdh_d[l_ac].xmdgdocno) RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
           LET g_xmdh_d[l_ac].xmdg005_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
      #出貨明細
#160503-00030#12-s mod
#      LET l_sql4 = "   SELECT xmdkdocno,xmdkdocdt,xmdk002,xmdk007,pmaal004,xmdk003,ooag011,xmdk004,ooefl003,xmdlseq,",
#                   "          xmdl003,xmdl004,'',xmdl008,imaal003,imaal004,xmdl009,'',xmdl017,oocal003,xmdl018,xmdl035,xmdl036,xmdl037,xmdl051,xmdkstus",
#                   "     FROM xmdk_t LEFT JOIN pmaal_t ON pmaalent = xmdkent AND pmaal001 = xmdk007 AND pmaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN ooag_t  ON ooagent  = xmdkent AND ooag001  = xmdk003",
#                   "                 LEFT JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"'",
#                   "                 LEFT OUTER JOIN ( SELECT xmdl_t.*,imaal_t.imaal003 imaal003,imaal_t.imaal004 imaal004,oocal_t.oocal003 oocal003 ",
#                   "     FROM xmdl_t LEFT JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocal_t ON oocalent = xmdlent AND oocal001 = xmdl017 AND oocal002 = '",g_dlang,"'",
#                   ") x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdksite = x.xmdlsite AND xmdk_t.xmdkdocno = x.xmdldocno ",
#                   "  WHERE xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' AND xmdk000 IN ('1','2','3') AND x.xmdl003 IN (",l_sql,")"
#                   "  ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
      LET l_sql4 = "SELECT xmdkdocno,xmdkdocdt,xmdk002,xmdk007,",
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"'),",
                   "       xmdk003,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdkent AND ooag001=xmdk003),",
                   "       xmdk004,",
                   "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"'),",
                   "       xmdlseq,xmdl003,xmdl004,",
                   "       (SELECT xmda033 FROM xmda_t WHERE xmdaent=xmdlent AND xmdadocno=xmdl003),",
                   "       xmdl008,",
                   "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       xmdl009,",
                   "       (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdlent AND inaml001=xmdl008 AND inaml002=xmdl009 AND inaml003='",g_dlang,"'),",
                   "       xmdl017,",
                   "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xmdlent AND oocal001=xmdl017 AND oocal002='",g_dlang,"'),",
                   "       xmdl018,xmdl035,xmdl036,xmdl037,xmdl051,xmdkstus",
                   "       ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdkent AND pmaa001=xmdk007) pmaa004 ",  #161207-00033#3-add
                   "  FROM xmdk_t ,xmdl_t",
                   " WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno",
                   "   AND xmdkent = ? AND xmdksite = ? AND xmdk000 IN ('1','2','3') AND xmdl003 IN (",l_sql,")"
#160503-00030#12-e mod

#160503-00030#12-s add
      IF g_attribute.attribute03 = 'Y' THEN   #出貨明細僅顯示未簽收量
         LET l_sql4 = l_sql4," AND (COALESCE(xmdl018,0)-COALESCE(xmdl035,0)-COALESCE(xmdl036,0)) > 0",
                             " AND xmdk002 = '3'"
      END IF
      LET l_sql4 = l_sql4,"  ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
#160503-00030#12-e add
                
      PREPARE axmq500_xmdl FROM l_sql4
      DECLARE b_fill_xmdl CURSOR FOR axmq500_xmdl
   END IF   #160503-00030#12 add
   
   LET l_ac = 1
   LET l_pmaa004 = ''  #161207-00033#3-add
#161207-00033#3-s-mod  多加l_pmaa004
##160503-00030#12-s mod
##   FOREACH b_fill_xmdl INTO g_xmdl_d[l_ac].*
#   FOREACH b_fill_xmdl
#     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
#      INTO g_xmdl_d[l_ac].*
##160503-00030#12-e mod  
   FOREACH b_fill_xmdl
     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xmdl_d[l_ac].*,l_pmaa004
#161207-00033#3-e-mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF cl_null(g_xmdl_d[l_ac].xmdl018) THEN LET g_xmdl_d[l_ac].xmdl018 = 0 END IF
      IF cl_null(g_xmdl_d[l_ac].xmdl035) THEN LET g_xmdl_d[l_ac].xmdl035 = 0 END IF
      IF cl_null(g_xmdl_d[l_ac].xmdl036) THEN LET g_xmdl_d[l_ac].xmdl036 = 0 END IF
#160503-00030#12-s mark
#      LET l_xmdl018 = g_xmdl_d[l_ac].xmdl018 - g_xmdl_d[l_ac].xmdl035 - g_xmdl_d[l_ac].xmdl036
#      IF g_attribute.attribute03 = 'Y' THEN
#         IF l_xmdl018 <= 0 OR g_xmdl_d[l_ac].xmdk002 != '3' THEN
#            CONTINUE FOREACH
#         END IF
#      END IF
#      
#      CALL s_feature_description(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009)
#           RETURNING l_success,g_xmdl_d[l_ac].xmdl009_desc
#
#      CALL axmq500_get_xmda033(g_xmdl_d[l_ac].xmdl003)
#           RETURNING g_xmdl_d[l_ac].xmda033_4
#160503-00030#12-e mark
      #161207-00033#3-s-add
      IF l_pmaa004 = '2' THEN
         CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmdl_d[l_ac].xmdkdocno) RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdl_d[l_ac].xmdk007_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
      #出貨簽收明細
#160503-00030#12-s mod
#      LET l_gzcb004 = ''
#      SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'axmt590'
#      LET l_sql5 = "   SELECT xmdkdocno,xmdkdocdt,xmdk007,pmaal004,xmdk003,ooag011,xmdk004,ooefl003,xmdlseq,xmdl003,",
#                   "          xmdl004,'',xmdl008,imaal003,imaal004,xmdl009,'',xmdl017,oocal003,xmdl018,xmdl081,xmdl084,oocql004,xmdl051,xmdkstus",
#                   "     FROM xmdk_t LEFT JOIN pmaal_t ON pmaalent = xmdkent AND pmaal001 = xmdk007 AND pmaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN ooag_t  ON ooagent  = xmdkent AND ooag001  = xmdk003",
#                   "                 LEFT JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"'",
#                   "                 LEFT OUTER JOIN ( SELECT xmdl_t.*,imaal_t.imaal003 imaal003,imaal_t.imaal004 imaal004,oocql_t.oocql004 oocql004,oocal_t.oocal003 oocal003 ",
#                   "     FROM xmdl_t LEFT JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocql_t ON oocqlent = xmdlent AND oocql001 = '",l_gzcb004,"' AND oocql002 = xmdl084 AND oocql003 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocal_t ON oocalent = xmdlent AND oocal001 = xmdl017 AND oocal002 = '",g_dlang,"'",
#                   ") x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdksite = x.xmdlsite AND xmdk_t.xmdkdocno = x.xmdldocno ",
#                   "  WHERE xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' AND xmdk000 = '4' AND x.xmdl003 IN (",l_sql,")",
#                   "  ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
      LET l_sql5 = "SELECT xmdkdocno,xmdkdocdt,xmdk007,",
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"'),",
                   "       xmdk003,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdkent AND ooag001=xmdk003),",
                   "       xmdk004,",
                   "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"'),",
                   "       xmdlseq,xmdl003,xmdl004,",
                   "       (SELECT xmda033 FROM xmda_t WHERE xmdaent=xmdlent AND xmdadocno=xmdl003),",
                   "       xmdl008,",
                   "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       xmdl009,",
                   "       (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdlent AND inaml001=xmdl008 AND inaml002=xmdl009 AND inaml003='",g_dlang,"'),",
                   "       xmdl017,",
                   "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xmdlent AND oocal001=xmdl017 AND oocal002='",g_dlang,"'),",
                   "       xmdl018,xmdl081,xmdl084,",
                   "       (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdlent",
                   "                                       AND oocql001=(SELECT gzcb004 FROM gzcb_t WHERE gzcb001='24' AND gzcb002='axmt500')",
                   "                                       AND oocql002=xmdl084",
                   "                                       AND oocql003='",g_dlang,"'),",
                   "       xmdl051,xmdkstus",    
                   "       ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdkent AND pmaa001=xmdk007) pmaa004 ",  #161207-00033#3-add
                   "  FROM xmdk_t,xmdl_t",
                   " WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno",
                   "   AND xmdkent = ? AND xmdksite = ? AND xmdk000 = '4' AND xmdl003 IN (",l_sql,")",
                   " ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
#160503-00030#12-e mod

      PREPARE axmq500_xmdk FROM l_sql5
      DECLARE b_fill_xmdk CURSOR FOR axmq500_xmdk
   END IF   #160503-00030#12 add
   
   LET l_ac = 1
   LET l_pmaa004 = ''  #161207-00033#3-add
#161207-00033#3-s-mod
##160503-00030#12-s mod
##   FOREACH b_fill_xmdk INTO g_xmdk_d[l_ac].*
#   FOREACH b_fill_xmdk
#     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
#      INTO g_xmdk_d[l_ac].*
##160503-00030#12-e mod
   FOREACH b_fill_xmdk
     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xmdk_d[l_ac].*,l_pmaa004
#161207-00033#3-e-mod
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

#160503-00030#12-s mark
#      CALL s_feature_description(g_xmdk_d[l_ac].xmdl008_1,g_xmdk_d[l_ac].xmdl009_1)
#           RETURNING l_success,g_xmdk_d[l_ac].xmdl009_1_desc
#
#      CALL axmq500_get_xmda033(g_xmdk_d[l_ac].xmdl003_1)
#           RETURNING g_xmdk_d[l_ac].xmda033_5
#160503-00030#12-e mark
      #161207-00033#3-s-add
      IF l_pmaa004 = '2' THEN
         CALL s_desc_axm_get_oneturn_guest_desc('4',g_xmdk_d[l_ac].xmdkdocno_1) RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdk_d[l_ac].xmdk007_1_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH

   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add
      #銷退明細
#160503-00030#12-s mod
#      LET l_gzcb004 = ''
#      SELECT gzcb004 INTO l_gzcb004 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'axmt600'
#      LET l_sql6 = "   SELECT xmdkdocno,xmdkdocdt,xmdk082,xmdk007,pmaal004,xmdk003,ooag011,xmdk004,ooefl003,xmdlseq,",
#                   "          xmdl003,xmdl004,'',xmdl008,imaal003,imaal004,xmdl009,'',xmdl017,oocal003,xmdl018,xmdl050,oocql004,xmdl051,xmdkstus",
#                   "     FROM xmdk_t LEFT JOIN pmaal_t ON pmaalent = xmdkent AND pmaal001 = xmdk007 AND pmaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN ooag_t  ON ooagent  = xmdkent AND ooag001  = xmdk003",
#                   "                 LEFT JOIN ooefl_t ON ooeflent = xmdkent AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"'",
#                   "                 LEFT OUTER JOIN ( SELECT xmdl_t.*,imaal_t.imaal003 imaal003,imaal_t.imaal004 imaal004,oocql_t.oocql004 oocql004,oocal_t.oocal003 oocal003 ",
#                   "     FROM xmdl_t LEFT JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocql_t ON oocqlent = xmdlent AND oocql001 = '",l_gzcb004,"' AND oocql002 = xmdl050 AND oocql003 = '",g_dlang,"'",
#                   "                 LEFT JOIN oocal_t ON oocalent = xmdlent AND oocal001 = xmdl017 AND oocal002 = '",g_dlang,"'",
#                   ") x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdksite = x.xmdlsite AND xmdk_t.xmdkdocno = x.xmdldocno ",
#                   "  WHERE xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"' AND xmdk000 = '6' AND x.xmdl003 IN (",l_sql,")",
#                   "  ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
      LET l_sql6 = "SELECT xmdkdocno,xmdkdocdt,xmdk082,xmdk007,",
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xmdkent AND pmaal001=xmdk007 AND pmaal002='",g_dlang,"'),",
                   "       xmdk003,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xmdkent AND ooag001=xmdk003),",
                   "       xmdk004,",
                   "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xmdkent AND ooefl001=xmdk004 AND ooefl002='",g_dlang,"'),",
                   "       xmdlseq,xmdl003,xmdl004,",
                   "       (SELECT xmda033 FROM xmda_t WHERE xmdaent=xmdlent AND xmdadocno=xmdl003),",
                   "       xmdl008,",
                   "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xmdlent AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
                   "       xmdl009,",
                   "       (SELECT inaml004 FROM inaml_t WHERE inamlent=xmdlent AND inaml001=xmdl008 AND inaml002=xmdl009 AND inaml003='",g_dlang,"'),",
                   "       xmdl017,",
                   "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xmdlent AND oocal001=xmdl017 AND oocal002='",g_dlang,"'),",
                   "       xmdl018,xmdl050,",
                   "       (SELECT oocql004 FROM oocql_t WHERE oocqlent=xmdlent",
                   "                                       AND oocql001=(SELECT gzcb004 FROM gzcb_t WHERE gzcb001='24' AND gzcb002='axmt600')",
                   "                                       AND oocql002=xmdl050",
                   "                                       AND oocql003='",g_dlang,"'),",
                   "       xmdl051,xmdkstus",
                   "       ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdkent AND pmaa001=xmdk007) pmaa004 ",  #161207-00033#3-add
                   "  FROM xmdk_t,xmdl_t",
                   " WHERE xmdkent=xmdlent AND xmdksite=xmdlsite AND xmdkdocno=xmdldocno ",
                   "   AND xmdkent = ? AND xmdksite = ? AND xmdk000 = '6' AND xmdl003 IN (",l_sql,")",
                   "  ORDER BY xmdkdocno,xmdlseq,xmdl003,xmdl004"
#160503-00030#12-e mod
      PREPARE axmq500_xmdk_2 FROM l_sql6
      DECLARE b_fill_xmdk_2 CURSOR FOR axmq500_xmdk_2
   END IF   #160503-00030#12 add

   LET l_ac = 1
   LET l_pmaa004 = '' #161207-00033#3-add
#161207-00033#3-s-mod
##160503-00030#12-s mod
##   FOREACH b_fill_xmdk_2 INTO g_xmdk_d_2[l_ac].*
#   FOREACH b_fill_xmdk_2
#     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
#      INTO g_xmdk_d_2[l_ac].*
##160503-00030#12-e mod
   FOREACH b_fill_xmdk_2
     USING g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xmdk_d_2[l_ac].*,l_pmaa004
#161207-00033#3-e-mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

#160503-00030#12-s mark
#      CALL s_feature_description(g_xmdk_d_2[l_ac].xmdl008_2,g_xmdk_d_2[l_ac].xmdl009_2)
#           RETURNING l_success,g_xmdk_d_2[l_ac].xmdl009_2_desc
#
#      CALL axmq500_get_xmda033(g_xmdk_d_2[l_ac].xmdl003_2)
#           RETURNING g_xmdk_d_2[l_ac].xmda033_6
#160503-00030#12-e mark
      
      #161207-00033#3-s-add
      IF l_pmaa004 = '2' THEN
         CALL s_desc_axm_get_oneturn_guest_desc('4',g_xmdk_d_2[l_ac].xmdkdocno_2) RETURNING l_pmak003
         IF NOT cl_null(l_pmak003) THEN
            LET g_xmdk_d_2[l_ac].xmdk007_2_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e-add
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN   #160503-00030#12 add   
      #應收帳款明細
#160503-00030#12-s mod
#      LET l_sql7 = "   SELECT xrcadocno,xrcadocdt,xrca001,xrca005,pmaal004,xrca014,ooag011,",   #150908 add xrca001   
#                   "          xrca015,ooefl003,xrccseq,xrcc001,xrcc004,xrcc118,xrcc119",
#                   "     FROM xrca_t LEFT JOIN pmaal_t ON pmaalent = xrcaent AND pmaal001 = xrca005 AND pmaal002 = '",g_dlang,"'",
#                   "                 LEFT JOIN ooag_t  ON ooagent  = xrcaent AND ooag001  = xrca014",
#                   "                 LEFT JOIN ooefl_t ON ooeflent = xrcaent AND ooefl001 = xrca015 AND ooefl002 = '",g_dlang,"'",
#                   "                 LEFT OUTER JOIN ( SELECT * FROM xrcc_t ) x  ",
#                   "       ON xrca_t.xrcaent = x.xrccent AND xrca_t.xrcald = x.xrccld AND xrca_t.xrcadocno = x.xrccdocno ",
#                   "                 LEFT OUTER JOIN ( SELECT * FROM xrcb_t ) y ",
#                   "       ON xrca_t.xrcaent = y.xrcbent AND xrca_t.xrcald = y.xrcbld AND xrca_t.xrcadocno = y.xrcbdocno ",
#                   "  WHERE xrcaent = ",g_enterprise," AND xrcasite = '",g_site,"' AND y.xrcb008 IN (",l_sql_xmdk,")",
#                   "  WHERE xrcaent = ",g_enterprise," AND xrcasite = '",g_site,"' AND y.xrcb002 IN (",l_sql_xmdk,")",
#                   "  ORDER BY xrcadocno,xrccseq,xrcc001"
      LET l_sql7 = "SELECT xrcadocno,xrcadocdt,xrca001,xrca005,",   #150908 add xrca001
                   "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent=xrcaent AND pmaal001=xrca005 AND pmaal002='",g_dlang,"'),",
                   "       xrca014,",
                   "       (SELECT ooag011 FROM ooag_t WHERE ooagent=xrcaent AND ooag001=xrca014),",
                   "       xrca015,",
                   "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xrcaent AND ooefl001=xrca015 AND ooefl002='",g_dlang,"'),",
                   "       xrccseq,xrcc001,xrcc004,xrcc118,xrcc119",
                   "  FROM xrca_t",
                   "  LEFT OUTER JOIN xrcc_t ON xrcaent=xrccent AND xrcald=xrccld AND xrcadocno=xrccdocno",
                   "  LEFT OUTER JOIN xrcb_t ON xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno",
                   " WHERE xrcaent = ? AND xrcasite = ? AND xrcb002 IN (",l_sql_xmdk,")"
#160503-00030#12-e mod

   #160503-00030#12-s add
      IF g_attribute.attribute04 = 'Y' THEN   #應收明細僅顯示未沖帳量
         LET l_sql7 = l_sql7," AND (COALESCE(xrcc118,0)-COALESCE(xrcc119,0)) > 0"
      END IF
      LET l_sql7 = l_sql7,"  ORDER BY xrcadocno,xrccseq,xrcc001"
   #160503-00030#12-e add
   
      PREPARE axmq500_xrca FROM l_sql7
      DECLARE b_fill_xrca CURSOR FOR axmq500_xrca
   END IF   #160503-00030#12 add

   LET l_ac = 1
   
#160503-00030#12-s mod
#   FOREACH b_fill_xrca INTO g_xrca_d[l_ac].*
   FOREACH b_fill_xrca
     USING g_enterprise,g_site,g_enterprise,g_site,g_enterprise,g_site,g_xmda_d[g_detail_idx].xmda004,g_xmda_d[g_detail_idx].xmdadocno,g_xmda_d[g_detail_idx].xmdadocdt,g_xmda_d[g_detail_idx].xmda002,g_xmda_d[g_detail_idx].xmda003
      INTO g_xrca_d[l_ac].*
#160503-00030#12-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF cl_null(g_xrca_d[l_ac].xrcc118) THEN LET g_xrca_d[l_ac].xrcc118 = 0 END IF
      IF cl_null(g_xrca_d[l_ac].xrcc119) THEN LET g_xrca_d[l_ac].xrcc119 = 0 END IF
#160503-00030#12-s mark
#      LET l_xrcc118 = g_xrca_d[l_ac].xrcc118 - g_xrca_d[l_ac].xrcc119
#      IF l_xrcc118 <= 0 AND g_attribute.attribute04 = 'Y' THEN
#         CONTINUE FOREACH
#      END IF 
#160503-00030#12-e mark

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN               
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF               
   END FOREACH
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   CALL g_xmdd_d.deleteElement(g_xmdd_d.getLength())
   CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
   CALL g_xmdh_d.deleteElement(g_xmdh_d.getLength())
   CALL g_xmdl_d.deleteElement(g_xmdl_d.getLength())
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
   CALL g_xmdk_d_2.deleteElement(g_xmdk_d_2.getLength())
   CALL g_xrca_d.deleteElement(g_xrca_d.getLength())
   #160523-00056#1 20160712 -----(S) 
   CALL g_pmda_d.deleteElement(g_pmda_d.getLength())
   CALL g_pmdl_d.deleteElement(g_pmdl_d.getLength())
   #160523-00056#1 20160712 -----(E) 
   
   LET g_detail_cnt2 = g_xmdd_d.getLength()
   LET g_detail_cnt3 = g_sfaa_d.getLength()
   LET g_detail_cnt4 = g_xmdh_d.getLength()
   LET g_detail_cnt5 = g_xmdl_d.getLength()
   LET g_detail_cnt6 = g_xmdk_d.getLength()
   LET g_detail_cnt7 = g_xmdk_d_2.getLength()
   LET g_detail_cnt8 = g_xrca_d.getLength()
   #160523-00056#1 20160712 -----(S) 
   LET g_detail_cnt9 = g_pmda_d.getLength()
   LET g_detail_cnt10 = g_pmdl_d.getLength()
   #160523-00056#1 20160712 -----(E) 
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   CLOSE b_fill_curs2
   FREE axmq500_pb2
   CLOSE b_fill_sfaa
   FREE axmq500_sfaa
   CLOSE b_fill_xmdh
   FREE axmq500_xmdh
   CLOSE b_fill_xmdl
   FREE axmq500_xmdl
   FREE axmq500_xmdadocno
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmq500_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axmq500_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xmda004,xmdadocno,xmdadocdt,xmda002,xmda003,xmda033
                          FROM s_detail1[1].b_xmda004,s_detail1[1].b_xmdadocno,s_detail1[1].b_xmdadocdt, 
                              s_detail1[1].b_xmda002,s_detail1[1].b_xmda003,s_detail1[1].b_xmda033
 
         BEFORE CONSTRUCT
                     DISPLAY axmq500_filter_parser('xmda004') TO s_detail1[1].b_xmda004
            DISPLAY axmq500_filter_parser('xmdadocno') TO s_detail1[1].b_xmdadocno
            DISPLAY axmq500_filter_parser('xmdadocdt') TO s_detail1[1].b_xmdadocdt
            DISPLAY axmq500_filter_parser('xmda002') TO s_detail1[1].b_xmda002
            DISPLAY axmq500_filter_parser('xmda003') TO s_detail1[1].b_xmda003
            DISPLAY axmq500_filter_parser('xmda033') TO s_detail1[1].b_xmda033
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmda004>>----
         #Ctrlp:construct.c.page1.b_xmda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda004
            #add-point:ON ACTION controlp INFIELD b_xmda004 name="construct.c.filter.page1.b_xmda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda004  #顯示到畫面上
            NEXT FIELD b_xmda004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda004_desc>>----
         #----<<b_xmdadocno>>----
         #Ctrlp:construct.c.page1.b_xmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocno
            #add-point:ON ACTION controlp INFIELD b_xmdadocno name="construct.c.filter.page1.b_xmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdadocno  #顯示到畫面上
            NEXT FIELD b_xmdadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocdt
            #add-point:ON ACTION controlp INFIELD b_xmdadocdt name="construct.c.filter.page1.b_xmdadocdt"
            
            #END add-point
 
 
         #----<<b_xmda002>>----
         #Ctrlp:construct.c.page1.b_xmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda002
            #add-point:ON ACTION controlp INFIELD b_xmda002 name="construct.c.filter.page1.b_xmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda002  #顯示到畫面上
            NEXT FIELD b_xmda002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda002_desc>>----
         #----<<b_xmda003>>----
         #Ctrlp:construct.c.page1.b_xmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda003
            #add-point:ON ACTION controlp INFIELD b_xmda003 name="construct.c.filter.page1.b_xmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda003  #顯示到畫面上
            NEXT FIELD b_xmda003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda003_desc>>----
         #----<<b_xmda033>>----
         #Ctrlp:construct.c.page1.b_xmda033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda033
            #add-point:ON ACTION controlp INFIELD b_xmda033 name="construct.c.filter.page1.b_xmda033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmda033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda033  #顯示到畫面上
            NEXT FIELD b_xmda033                     #返回原欄位
    


            #END add-point
 
 
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL axmq500_filter_show('xmda004','b_xmda004')
   CALL axmq500_filter_show('xmdadocno','b_xmdadocno')
   CALL axmq500_filter_show('xmdadocdt','b_xmdadocdt')
   CALL axmq500_filter_show('xmda002','b_xmda002')
   CALL axmq500_filter_show('xmda003','b_xmda003')
   CALL axmq500_filter_show('xmda033','b_xmda033')
 
 
   CALL axmq500_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axmq500_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="axmq500.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axmq500_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axmq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axmq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axmq500_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axmq500_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmda_d.getLength() AND g_xmda_d.getLength() > 0
            LET g_detail_idx = g_xmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmda_d.getLength() THEN
               LET g_detail_idx = g_xmda_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmq500.mask_functions" >}
 &include "erp/axm/axmq500_mask.4gl"
 
{</section>}
 
{<section id="axmq500.other_function" readonly="Y" >}

PRIVATE FUNCTION axmq500_set_visible()
   CALL cl_set_comp_visible("b_xmda004,b_xmda004_desc,b_xmdadocno,b_xmdadocdt",TRUE)
   CALL cl_set_comp_visible("b_xmda002,b_xmda002_desc,b_xmda003,b_xmda003_desc",TRUE)
   CALL cl_set_comp_visible("xmda004_1,xmda004_1_desc,xmdadocno_1,xmdadocdt_1,xmda002_1,xmda002_1_desc",TRUE)
   CALL cl_set_comp_visible("xmda003_1,xmda003_1_desc,sfaa006,xmdh001,xmdl003,xmdl003_1,xmdl003_2",TRUE)
   CALL cl_set_comp_visible("b_xmda033,xmda033_1,xmda033_2,xmda033_3,xmda033_4,xmda033_5,xmda033_6",TRUE)
                          
   IF g_xmda_m.xmda004_sel = 'Y' THEN
      CALL cl_set_comp_visible("xmda004_1,xmda004_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmda004,b_xmda004_desc",FALSE)
   END IF
   
   IF g_xmda_m.xmdadocno_sel = 'Y' THEN
      CALL cl_set_comp_visible("xmdadocno_1,sfaa006,xmdh001,xmdl003,xmdl003_1,xmdl003_2",FALSE)
      CALL cl_set_comp_visible("xmda033_1,xmda033_2,xmda033_3,xmda033_4,xmda033_5,xmda033_6",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdadocno",FALSE)
      CALL cl_set_comp_visible("b_xmda033",FALSE)
   END IF
    
   IF g_xmda_m.xmdadocdt_sel = 'Y' THEN
      CALL cl_set_comp_visible("xmdadocdt_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmdadocdt",FALSE)
   END IF
   
   IF g_xmda_m.xmda002_sel = 'Y' THEN
      CALL cl_set_comp_visible("xmda002_1,xmda002_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmda002,b_xmda002_desc",FALSE)
   END IF
   
   IF g_xmda_m.xmda003_sel = 'Y' THEN
      CALL cl_set_comp_visible("xmda003_1,xmda003_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_xmda003,b_xmda003_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 取得訂單的客戶訂購單號
# Memo...........:
# Usage..........: CALL axmq500_get_xmda033(p_xmdadocno)
#                  RETURNING r_xmda033
# Input parameter: p_xmdadocno 訂單單號
# Return code....: r_xmda033   客戶訂購單號
# Date & Author..: 150114 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmq500_get_xmda033(p_xmdadocno)
DEFINE p_xmdadocno  LIKE xmda_t.xmdadocno
DEFINE r_xmda033    LIKE xmda_t.xmda033

#160503-00030#12-s mark
#   LET r_xmda033 = ''
#   SELECT xmda033 INTO r_xmda033
#     FROM xmda_t
#    WHERE xmdaent = g_enterprise
#      AND xmdadocno = p_xmdadocno
#   RETURN r_xmda033
#160503-00030#12-e mark

END FUNCTION

 
{</section>}
 
