#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq007.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:19(2016-11-01 14:05:32), PR版次:0019(2017-02-13 10:41:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: asfq007
#+ Description: 工單狀況匯總查詢
#+ Creator....: 04226(2014-08-21 16:19:41)
#+ Modifier...: 02040 -SD/PR- 07423
 
{</section>}
 
{<section id="asfq007.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#9  160519  By Polly   效能調整
#160425-00019    160520  By Whitney 齊料套數不及時計算改抓sfaa071
#160523-00055    160727  By Whitney add FQC PQC page
#160727-00025#5  16/08/01 By lixh 模具生產功能開發
#160727-00019#18 16/08/12 By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
#160921-00033#1  16/09/26 BY liuym   修正在相同報工單，相同報工料，相同報工數量的情況下，單身報工頁簽會只顯示一筆報工單資料
#161024-00057#1  16/10/24 By Whitney 刪除page_5[計畫完工日]頁籤及table6[sfae_t]相關程式
#161031-00012#1  16/10/31 By 02040   因刪除page_5，導致FOREACH抓取SQL錯誤，重新調整SQL順序
#161019-00003#1  16/11/01 By 02040   發退料頁籤由發退料需求檔(sfdc)改抓發退料明細檔(sfdd)資料，並加入項序欄位
#161109-00085#40 16/11/17 BY 08992  整批星號調整
#161205-00038#1  16/12/06 By liuym  调整table8查询SQL语句中第二个oocalent，将t3.oocalent换成t5.oocalent 
#161226-00020#1  16/12/26 By 00768  整顿临时表处理错误，导致状态下条件抓取不出资料
#170210-00010#1  17/02/13 By fionchen 效能調整
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
PRIVATE TYPE type_g_sfaa_d RECORD
       
       sel LIKE type_t.chr1, 
   progress LIKE type_t.chr500, 
   stus LIKE type_t.chr500, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaadocdt LIKE sfaa_t.sfaadocdt, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_1 LIKE type_t.chr500, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   sfaa068_desc LIKE type_t.chr500, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   fullsets LIKE type_t.num20_6, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaa021 LIKE sfaa_t.sfaa021, 
   sfaa025 LIKE sfaa_t.sfaa025, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa046 LIKE sfaa_t.sfaa046, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa011 LIKE sfaa_t.sfaa011
       END RECORD
PRIVATE TYPE type_g_sfaa10_d RECORD
       sfca001 LIKE sfca_t.sfca001, 
   prog_asft301 STRING, 
   sfca003 LIKE sfca_t.sfca003, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfca004 LIKE sfca_t.sfca004, 
   num LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_sfaa11_d RECORD
       sffbstus LIKE sffb_t.sffbstus, 
   sffbdocno LIKE sffb_t.sffbdocno, 
   prog_asft335 STRING, 
   sffb001 LIKE sffb_t.sffb001, 
   sffbdocdt LIKE sffb_t.sffbdocdt, 
   sffb006 LIKE sffb_t.sffb006, 
   sffb029 LIKE sffb_t.sffb029, 
   sffb029_desc LIKE type_t.chr500, 
   sffb029_desc_1 LIKE type_t.chr500, 
   sffb007 LIKE sffb_t.sffb007, 
   sffb007_desc LIKE type_t.chr500, 
   sffb008 LIKE sffb_t.sffb008, 
   sffb009 LIKE sffb_t.sffb009, 
   sffb009_desc LIKE type_t.chr500, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb020 LIKE sffb_t.sffb020
       END RECORD
 
PRIVATE TYPE type_g_sfaa2_d RECORD
       sfabseq LIKE sfab_t.sfabseq, 
   sfab001 LIKE sfab_t.sfab001, 
   sfab002 LIKE sfab_t.sfab002, 
   sfab003 LIKE sfab_t.sfab003, 
   sfab004 LIKE sfab_t.sfab004, 
   sfab005 LIKE sfab_t.sfab005, 
   sfab006 LIKE sfab_t.sfab006, 
   a1 LIKE type_t.num20_6, 
   a2 LIKE type_t.chr500, 
   a3 LIKE type_t.num20_6, 
   a4 LIKE type_t.chr500, 
   a5 LIKE type_t.num20_6, 
   sfab007 LIKE sfab_t.sfab007, 
   a6 LIKE type_t.chr500, 
   a6_desc LIKE type_t.chr500, 
   a7 LIKE type_t.chr500, 
   a7_desc LIKE type_t.chr500, 
   a8 LIKE type_t.chr500, 
   a8_desc LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_sfaa3_d RECORD
       sfacseq LIKE sfac_t.sfacseq, 
   sfac002 LIKE sfac_t.sfac002, 
   sfac001 LIKE sfac_t.sfac001, 
   sfac001_desc LIKE type_t.chr500, 
   sfac001_desc_1 LIKE type_t.chr500, 
   sfac006 LIKE sfac_t.sfac006, 
   sfac006_desc LIKE type_t.chr500, 
   sfac003 LIKE sfac_t.sfac003, 
   sfac004 LIKE sfac_t.sfac004, 
   sfac004_desc LIKE type_t.chr500, 
   sfac005 LIKE sfac_t.sfac005
       END RECORD
 
PRIVATE TYPE type_g_sfaa6_d RECORD
       sfafseq LIKE sfaf_t.sfafseq, 
   sfaf001 LIKE sfaf_t.sfaf001
       END RECORD
 
PRIVATE TYPE type_g_sfaa7_d RECORD
       sfbasite LIKE sfba_t.sfbasite, 
   sfbaseq LIKE sfba_t.sfbaseq, 
   sfbaseq1 LIKE sfba_t.sfbaseq1, 
   sfba006 LIKE sfba_t.sfba006, 
   sfba006_desc LIKE type_t.chr500, 
   sfba006_desc_1 LIKE type_t.chr500, 
   sfba021 LIKE sfba_t.sfba021, 
   sfba021_desc LIKE type_t.chr500, 
   replace LIKE type_t.chr500, 
   sfba005 LIKE sfba_t.sfba005, 
   sfba005_desc LIKE type_t.chr500, 
   sfba005_desc_1 LIKE type_t.chr500, 
   sfba003 LIKE sfba_t.sfba003, 
   sfba003_desc LIKE type_t.chr500, 
   sfba004 LIKE sfba_t.sfba004, 
   sfba013 LIKE sfba_t.sfba013, 
   sfba015 LIKE sfba_t.sfba015, 
   sfba009 LIKE sfba_t.sfba009, 
   sfba028 LIKE sfba_t.sfba028, 
   sfba016 LIKE sfba_t.sfba016, 
   sfba025 LIKE sfba_t.sfba025, 
   num1 LIKE type_t.num20_6, 
   num2 LIKE type_t.num20_6, 
   sfba017 LIKE sfba_t.sfba017, 
   sfba018 LIKE sfba_t.sfba018, 
   sfba019 LIKE sfba_t.sfba019, 
   sfba019_desc LIKE type_t.chr500, 
   sfba020 LIKE sfba_t.sfba020, 
   sfba020_desc LIKE type_t.chr500, 
   sfba002 LIKE sfba_t.sfba002
       END RECORD
 
PRIVATE TYPE type_g_sfaa8_d RECORD
       sfdcsite LIKE type_t.chr10, 
   sfdastus LIKE sfda_t.sfdastus, 
   sfda002 LIKE sfda_t.sfda002, 
   sfda001 LIKE sfda_t.sfda001, 
   sfdcdocno LIKE sfdc_t.sfdcdocno, 
   prog_asft310 STRING, 
   sfdcseq LIKE sfdc_t.sfdcseq, 
   l_sfddseq1 LIKE type_t.chr500, 
   sfdc004 LIKE sfdc_t.sfdc004, 
   sfdc004_desc LIKE type_t.chr500, 
   sfdc004_desc_1 LIKE type_t.chr500, 
   sfdc005 LIKE sfdc_t.sfdc005, 
   sfdc005_desc LIKE type_t.chr500, 
   sfdc012 LIKE sfdc_t.sfdc012, 
   sfdc012_desc LIKE type_t.chr500, 
   sfdc013 LIKE sfdc_t.sfdc013, 
   sfdc013_desc LIKE type_t.chr500, 
   sfdc014 LIKE sfdc_t.sfdc014, 
   sfdc016 LIKE sfdc_t.sfdc016, 
   sfdc006 LIKE sfdc_t.sfdc006, 
   sfdc006_desc LIKE type_t.chr500, 
   sfdc008 LIKE sfdc_t.sfdc008, 
   sfdc009 LIKE sfdc_t.sfdc009, 
   sfdc009_desc LIKE type_t.chr500, 
   sfdc011 LIKE sfdc_t.sfdc011
       END RECORD
 
PRIVATE TYPE type_g_sfaa9_d RECORD
       sfecsite LIKE sfec_t.sfecsite, 
   sfeastus LIKE sfea_t.sfeastus, 
   sfea001 LIKE sfea_t.sfea001, 
   sfecdocno LIKE sfec_t.sfecdocno, 
   prog_asft340 STRING, 
   sfecseq LIKE sfec_t.sfecseq, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfec002 LIKE sfec_t.sfec002, 
   sfec003 LIKE sfec_t.sfec003, 
   qcbc002 LIKE qcbc_t.qcbc002, 
   qcbc002_desc LIKE type_t.chr500, 
   sfec005 LIKE sfec_t.sfec005, 
   sfec005_desc LIKE type_t.chr500, 
   sfec005_desc_1 LIKE type_t.chr500, 
   sfec006 LIKE sfec_t.sfec006, 
   sfec006_desc LIKE type_t.chr500, 
   sfec012 LIKE sfec_t.sfec012, 
   sfec012_desc LIKE type_t.chr500, 
   sfec013 LIKE sfec_t.sfec013, 
   sfec013_desc LIKE type_t.chr500, 
   sfec014 LIKE sfec_t.sfec014, 
   sfec015 LIKE sfec_t.sfec015, 
   sfec008 LIKE sfec_t.sfec008, 
   sfec008_desc LIKE type_t.chr500, 
   sfec009 LIKE sfec_t.sfec009, 
   sfec010 LIKE sfec_t.sfec010, 
   sfec010_desc LIKE type_t.chr500, 
   sfec011 LIKE sfec_t.sfec011, 
   sfec028 LIKE sfec_t.sfec028, 
   sfec016 LIKE sfec_t.sfec016
       END RECORD
 
PRIVATE TYPE type_g_sfaa91_d RECORD
       sfcb001 LIKE sfcb_t.sfcb001, 
   prog_asft3011 STRING, 
   sfcb002 LIKE sfcb_t.sfcb002, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   sfcb003_desc LIKE type_t.chr500, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   sfcb011_desc LIKE type_t.chr500, 
   sfcb027 LIKE sfcb_t.sfcb027, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb028 LIKE sfcb_t.sfcb028, 
   sfcb029 LIKE sfcb_t.sfcb029, 
   sfcb030 LIKE sfcb_t.sfcb030, 
   sfcb031 LIKE sfcb_t.sfcb031, 
   sfcb032 LIKE sfcb_t.sfcb032, 
   sfcb033 LIKE sfcb_t.sfcb033, 
   sfcb034 LIKE sfcb_t.sfcb034, 
   sfcb035 LIKE sfcb_t.sfcb035, 
   sfcb036 LIKE sfcb_t.sfcb036, 
   sfcb037 LIKE sfcb_t.sfcb037, 
   sfcb038 LIKE sfcb_t.sfcb038, 
   sfcb039 LIKE sfcb_t.sfcb039, 
   sfcb041 LIKE sfcb_t.sfcb041, 
   sfcb042 LIKE sfcb_t.sfcb042, 
   sfcb043 LIKE sfcb_t.sfcb043, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051
       END RECORD
 
PRIVATE TYPE type_g_sfaa92_d RECORD
       pmdastus LIKE pmda_t.pmdastus, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   prog_apmt400 STRING, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda002_desc LIKE type_t.chr500, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr500, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   pmdb004_desc_1 LIKE type_t.chr500, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb005_desc LIKE type_t.chr500, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb009 LIKE pmdb_t.pmdb009, 
   pmdb009_desc LIKE type_t.chr500, 
   pmdb008 LIKE pmdb_t.pmdb008, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb049 LIKE pmdb_t.pmdb049
       END RECORD
 
PRIVATE TYPE type_g_sfaa93_d RECORD
       l_pmdlstus LIKE type_t.chr10, 
   l_pmdndocno LIKE type_t.chr20, 
   prog_apmt500 STRING, 
   l_pmdnseq LIKE type_t.num10, 
   l_pmdn001 LIKE type_t.chr500, 
   l_pmdn001_desc LIKE type_t.chr500, 
   l_pmdn001_desc_1 LIKE type_t.chr500, 
   l_pmdn002 LIKE type_t.chr500, 
   l_pmdn002_desc LIKE type_t.chr500, 
   l_pmdn006 LIKE type_t.chr10, 
   l_pmdn006_desc LIKE type_t.chr500, 
   l_pmdn007 LIKE type_t.num20_6, 
   l_pmdn008 LIKE type_t.chr10, 
   l_pmdn008_desc LIKE type_t.chr500, 
   l_pmdn009 LIKE type_t.num20_6, 
   l_pmdn012 LIKE type_t.dat, 
   l_pmdn013 LIKE type_t.dat, 
   l_pmdn014 LIKE type_t.dat
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#查詢條件
TYPE type_g_qbe      RECORD
     sfaa003         LIKE type_t.chr1000,
     sfaadocno       LIKE type_t.chr1000,
     sfaa021         LIKE type_t.chr1000,   #160727-00025#5 
     sfaadocdt       LIKE type_t.chr1000,
     sfaa002         LIKE type_t.chr1000,
     sfaa068         LIKE type_t.chr1000,   #150907 Sarah add
     sfaa010         LIKE type_t.chr1000,
     sfaa012         LIKE type_t.chr1000,
     sfaa019         LIKE type_t.chr1000,
     sfaa020         LIKE type_t.chr1000,
     sfaa017         LIKE type_t.chr1000, 
     left_stus       LIKE type_t.chr1000,
     l_progress      LIKE type_t.chr1000,
     l_closed        LIKE type_t.chr1000
                 END RECORD
DEFINE g_qbe         type_g_qbe  

#ming 20150827 add -----------------------------(S) 
 TYPE type_g_pmdn_d  RECORD
      pmdnsite       LIKE pmdn_t.pmdnsite,
      pmdlstus       LIKE pmdl_t.pmdlstus,
      pmdndocno      LIKE pmdn_t.pmdndocno,
      prog_apmt501   STRING,    
      pmdnseq        LIKE pmdn_t.pmdnseq,
      pmdn001        LIKE pmdn_t.pmdn001, 
      pmdn001_desc   LIKE type_t.chr500,
      pmdn001_desc_1 LIKE type_t.chr500,
      pmdn002        LIKE pmdn_t.pmdn002, 
      pmdn002_desc   LIKE type_t.chr500,
      pmdn006        LIKE pmdn_t.pmdn006, 
      pmdn006_desc   LIKE type_t.chr500,
      pmdn007        LIKE pmdn_t.pmdn007,
      #160727-00025#5-s
      pmdn008        LIKE pmdn_t.pmdn008,    
      pmdn008_desc   LIKE type_t.chr500,
      pmdn009        LIKE pmdn_t.pmdn009,
      #160727-00025#5-e
      pmdn012        LIKE pmdn_t.pmdn012,
      pmdn013        LIKE pmdn_t.pmdn013,
      pmdn014        LIKE pmdn_t.pmdn014
                 END RECORD
DEFINE g_pmdn_d      DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdn_d_t    type_g_pmdn_d
#ming 20150827 add -----------------------------(E)

#160523-00055 by whitney add start
 TYPE type_g_qcba1_d RECORD
      qcbasite       LIKE qcba_t.qcbasite,
      qcbastus       LIKE qcba_t.qcbastus,
      qcbadocdt      LIKE qcba_t.qcbadocdt,
      qcbadocno      LIKE qcba_t.qcbadocno,
      prog_aqct300   STRING,    #160727-00025#5
      qcba001        LIKE qcba_t.qcba001,
      qcba002        LIKE qcba_t.qcba002,
      qcba017        LIKE qcba_t.qcba017,
      qcbc002        LIKE qcbc_t.qcbc002,
      qcbc002_desc   LIKE qcaol_t.qcaol004,
      qcbc012        LIKE qcbc_t.qcbc012,
      qcbc009        LIKE qcbc_t.qcbc009
                 END RECORD
DEFINE g_qcba1_d     DYNAMIC ARRAY OF type_g_qcba1_d
 TYPE type_g_qcba2_d RECORD
      qcbasite       LIKE qcba_t.qcbasite,
      qcbastus       LIKE qcba_t.qcbastus,
      qcbadocdt      LIKE qcba_t.qcbadocdt,
      qcbadocno      LIKE qcba_t.qcbadocno,
      prog_aqct3001  STRING,               #160727-00025#5
      qcba001        LIKE qcba_t.qcba001,
      qcba002        LIKE qcba_t.qcba002,
      qcba006        LIKE qcba_t.qcba006,
      qcba006_desc   LIKE oocql_t.oocql004,
      qcba007        LIKE qcba_t.qcba007,
      qcba017        LIKE qcba_t.qcba017,
      qcbc002        LIKE qcbc_t.qcbc002,
      qcbc002_desc   LIKE qcaol_t.qcaol004,
      qcbc012        LIKE qcbc_t.qcbc012,
      qcbc009        LIKE qcbc_t.qcbc009
                 END RECORD
DEFINE g_qcba2_d     DYNAMIC ARRAY OF type_g_qcba2_d
#160523-00055 by whitney add end

#end add-point
 
#模組變數(Module Variables)
DEFINE g_sfaa_d            DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t          type_g_sfaa_d
DEFINE g_sfaa10_d     DYNAMIC ARRAY OF type_g_sfaa10_d
DEFINE g_sfaa10_d_t   type_g_sfaa10_d
 
DEFINE g_sfaa11_d     DYNAMIC ARRAY OF type_g_sfaa11_d
DEFINE g_sfaa11_d_t   type_g_sfaa11_d
 
DEFINE g_sfaa2_d     DYNAMIC ARRAY OF type_g_sfaa2_d
DEFINE g_sfaa2_d_t   type_g_sfaa2_d
 
DEFINE g_sfaa3_d     DYNAMIC ARRAY OF type_g_sfaa3_d
DEFINE g_sfaa3_d_t   type_g_sfaa3_d
 
DEFINE g_sfaa6_d     DYNAMIC ARRAY OF type_g_sfaa6_d
DEFINE g_sfaa6_d_t   type_g_sfaa6_d
 
DEFINE g_sfaa7_d     DYNAMIC ARRAY OF type_g_sfaa7_d
DEFINE g_sfaa7_d_t   type_g_sfaa7_d
 
DEFINE g_sfaa8_d     DYNAMIC ARRAY OF type_g_sfaa8_d
DEFINE g_sfaa8_d_t   type_g_sfaa8_d
 
DEFINE g_sfaa9_d     DYNAMIC ARRAY OF type_g_sfaa9_d
DEFINE g_sfaa9_d_t   type_g_sfaa9_d
 
DEFINE g_sfaa91_d     DYNAMIC ARRAY OF type_g_sfaa91_d
DEFINE g_sfaa91_d_t   type_g_sfaa91_d
 
DEFINE g_sfaa92_d     DYNAMIC ARRAY OF type_g_sfaa92_d
DEFINE g_sfaa92_d_t   type_g_sfaa92_d
 
DEFINE g_sfaa93_d     DYNAMIC ARRAY OF type_g_sfaa93_d
DEFINE g_sfaa93_d_t   type_g_sfaa93_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_detail2_page_action3 STRING
 
DEFINE g_wc2_table4   STRING
DEFINE g_detail2_page_action4 STRING
 
DEFINE g_wc2_table5   STRING
DEFINE g_detail2_page_action5 STRING
 
DEFINE g_wc2_table6   STRING
DEFINE g_detail2_page_action6 STRING
 
DEFINE g_wc2_table7   STRING
DEFINE g_detail2_page_action7 STRING
 
DEFINE g_wc2_table8   STRING
DEFINE g_detail2_page_action8 STRING
 
DEFINE g_wc2_table9   STRING
DEFINE g_detail2_page_action9 STRING
 
DEFINE g_wc2_table10   STRING
DEFINE g_detail2_page_action10 STRING
 
DEFINE g_wc2_table11   STRING
DEFINE g_detail2_page_action11 STRING
 
DEFINE g_wc2_table12   STRING
DEFINE g_detail2_page_action12 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
DEFINE g_wc2_filter_table3   STRING
 
DEFINE g_wc2_filter_table4   STRING
 
DEFINE g_wc2_filter_table5   STRING
 
DEFINE g_wc2_filter_table6   STRING
 
DEFINE g_wc2_filter_table7   STRING
 
DEFINE g_wc2_filter_table8   STRING
 
DEFINE g_wc2_filter_table9   STRING
 
DEFINE g_wc2_filter_table10   STRING
 
DEFINE g_wc2_filter_table11   STRING
 
DEFINE g_wc2_filter_table12   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfq007.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化 name="main.init"
   CALL asfq007_create_tmp()
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
   DECLARE asfq007_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq007_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq007_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq007 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq007_init()   
 
      #進入選單 Menu (="N")
      CALL asfq007_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq007
      
   END IF 
   
   CLOSE asfq007_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL asfq007_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq007.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq007_init()
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
      CALL cl_set_combo_scc_part('b_sfaastus','13','C,D,F,M,N,R,W,Y,X')
   CALL cl_set_combo_scc_part('b_sffbstus','13','N,Y,A,D,R,W,X')
   CALL cl_set_combo_scc_part('b_sfdastus','13','D,N,W,Y,A,R,S,X,Z')
   CALL cl_set_combo_scc_part('b_sfeastus','13','A,D,N,R,W,Y,S,Z,X')
   CALL cl_set_combo_scc_part('b_pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('b_sfaa003','4007') 
   CALL cl_set_combo_scc('b_sffb001','4021') 
   CALL cl_set_combo_scc('b_sfab001','4009') 
   CALL cl_set_combo_scc('b_sfac002','4019') 
   CALL cl_set_combo_scc('b_sfda002','4013') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sfaa003','4007')
   CALL cl_set_combo_scc('progress','4034')
   CALL cl_set_combo_scc('stus','4035')
   CALL cl_set_combo_scc('replace','4011')
   LET g_qbe.l_closed = 'N'
   LET g_qbe.l_progress = '3' 
   
   CALL cl_set_combo_scc('left_stus','4035') 
   
   #ming 20150827 add ------------------(S) 
   CALL cl_set_combo_scc_part('b_pmdlstus','13','N,Y,H,C,A,D,R,W,UH,X')
   #ming 20150827 add ------------------(E) 
   CALL cl_set_combo_scc('b_sffb001','4020')

   #160523-00055 by whitney add start
   CALL cl_set_combo_scc_part('b_qcbastus_1','13','N,Y,A,D,R,W,X')
   CALL cl_set_combo_scc_part('b_qcbastus_2','13','N,Y,A,D,R,W,X')
   CALL cl_set_combo_scc('b_qcbc012_1','5070')
   CALL cl_set_combo_scc('b_qcbc012_2','5070')
   #160523-00055 by whitney add end
   CALL cl_set_combo_scc_part('l_pmdlstus','13','N,Y,H,C,A,D,R,W,UH,X')    #160727-00025#5 
   #end add-point
 
   CALL asfq007_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq007.default_search" >}
PRIVATE FUNCTION asfq007_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " sfaadocno = '", g_argv[01], "' AND "
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
 
{<section id="asfq007.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq007_ui_dialog() 
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
   DEFINE  l_sfda002   LIKE sfda_t.sfda002     #160727-00025#5
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
   #準備b_fill2需要的sql
   #發料頁籤 發料日期 類型
   #ming 20141219 modify ------------------------------(S) 
   #LET g_sql = "SELECT sfda001,sfda002",
   #            "  FROM sfda_t",
   #            " WHERE sfdaent = ",g_enterprise,
   #            "   AND sfdadocno = ?"
   #PREPARE asfq007_sfda FROM g_sql
   LET g_sql = "SELECT sfda001,sfda002,sfdastus",
               "  FROM sfda_t",
               " WHERE sfdaent = ",g_enterprise,
               "   AND sfdadocno = ?"
   PREPARE asfq007_sfda FROM g_sql
   #ming 20141219 modify ------------------------------(E) 
   
   #入庫頁籤 入庫日期
   #ming 20141219 modify ------------------------------(S) 
   #LET g_sql = "SELECT sfea001 FROM sfea_t",
   #            " WHERE sfeaent = ",g_enterprise,
   #            "   AND sfeadocno = ?"
   #PREPARE asfq007_sfea FROM g_sql
   LET g_sql = "SELECT sfea001,sfeastus ",
               "  FROM sfea_t",
               " WHERE sfeaent = ",g_enterprise,
               "   AND sfeadocno = ?"
   PREPARE asfq007_sfea FROM g_sql
   #ming 20141219 modify ------------------------------(E)  
   
   #ming 20150827 add ---------------------------------(S) 
   #入庫頁籤 委外 
   LET g_sql = "SELECT pmds001,pmdsstus ",
               "  FROM pmds_t",
               " WHERE pmdsent = ",g_enterprise,
               "   AND pmdsdocno = ?"
   PREPARE asfq007_pmds FROM g_sql
   #ming 20150827 add ---------------------------------(E) 
   
   #入庫頁籤 FQC
   LET g_sql = "SELECT sfeb002 FROM sfeb_t",
               " WHERE sfebent = ",g_enterprise,
               "   AND sfebdocno = ?",
               "   AND sfebseq = ?"
   PREPARE asfq007_sfeb FROM g_sql
   
   #入庫頁籤 判定結果
   LET g_sql = "SELECT qcbc002 FROM qcbc_t",
               " WHERE qcbcent = ",g_enterprise,
               "   AND qcbcdocno = ?",
               "   AND qcbcseq = ?"
   PREPARE asfq007_qcbc FROM g_sql
   CALL gfrm_curr.setFieldHidden('b_pmdndocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_apmt501', FALSE) 
   #end add-point
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfca001', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_asft301', FALSE) 
   CALL gfrm_curr.setFieldHidden('b_sffbdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft335', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfdcdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft310', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfecdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft340', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfcb001', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft3011', FALSE)
   CALL gfrm_curr.setFieldHidden('b_pmdadocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_apmt400', FALSE)
   CALL gfrm_curr.setFieldHidden('l_pmdndocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_apmt500', FALSE)
 
  
 
 
 
   CALL asfq007_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_sfaa_d.clear()
         CALL g_sfaa10_d.clear()
 
         CALL g_sfaa11_d.clear()
 
         CALL g_sfaa2_d.clear()
 
         CALL g_sfaa3_d.clear()
 
         CALL g_sfaa6_d.clear()
 
         CALL g_sfaa7_d.clear()
 
         CALL g_sfaa8_d.clear()
 
         CALL g_sfaa9_d.clear()
 
         CALL g_sfaa91_d.clear()
 
         CALL g_sfaa92_d.clear()
 
         CALL g_sfaa93_d.clear()
 
 
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
 
         CALL asfq007_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON sfaa003,sfaadocno,sfaa021,sfaadocdt,sfaa002,sfaa068,   #150907 Sarah add sfaa068  #160727-00025#5 add sfaa021
                                   sfaa010,sfaa012,sfaa019,sfaa020,sfaa017,left_stus
            AFTER FIELD sfaa003
               LET g_qbe.sfaa003 = GET_FLDBUF(sfaa003)
            
            AFTER FIELD sfaadocno
               LET g_qbe.sfaadocno = GET_FLDBUF(sfaadocno)

           #160727-00025#5-s
            AFTER FIELD sfaa021
               LET g_qbe.sfaa021 = GET_FLDBUF(sfaa021)           
           #160727-00025#5-e
           
            AFTER FIELD sfaadocdt
               LET g_qbe.sfaadocdt = GET_FLDBUF(sfaadocdt)
            
            AFTER FIELD sfaa002
               LET g_qbe.sfaa002 = GET_FLDBUF(sfaa002)
               
#150907 Sarah add ----- (S)
            AFTER FIELD sfaa068
               LET g_qbe.sfaa068 = GET_FLDBUF(sfaa068)
#150907 Sarah add ----- (E)

            AFTER FIELD sfaa010
               LET g_qbe.sfaa010 = GET_FLDBUF(sfaa010)
            
            AFTER FIELD sfaa012
               LET g_qbe.sfaa012 = GET_FLDBUF(sfaa012)
            
            AFTER FIELD sfaa019
               LET g_qbe.sfaa019 = GET_FLDBUF(sfaa019)
               
            AFTER FIELD sfaa020
               LET g_qbe.sfaa020 = GET_FLDBUF(sfaa020)
            
            AFTER FIELD sfaa017
               LET g_qbe.sfaa017 = GET_FLDBUF(sfaa017) 
               
            AFTER FIELD left_stus
               LET g_qbe.left_stus = GET_FLDBUF(left_stus)

            #160727-00025#7-s
            ON ACTION controlp INFIELD sfaa021
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno_8()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa021      #顯示到畫面上
               NEXT FIELD sfaa021  
            #160727-00025#7-e
            
            ON ACTION controlp INFIELD sfaadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaadocno    #顯示到畫面上
               NEXT FIELD sfaadocno                       #返回原欄位
               
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001_2()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa002      #顯示到畫面上
               NEXT FIELD sfaa002                         #返回原欄位

#150907 Sarah add ----- (S)
            ON ACTION controlp INFIELD sfaa068
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = cl_get_today()
               CALL q_ooeg001_4()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa068      #顯示到畫面上
               NEXT FIELD sfaa068                         #返回原欄位
#150907 Sarah add ----- (E)

            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010      #顯示到畫面上
               NEXT FIELD sfaa010                         #返回原欄位

            ON ACTION controlp INFIELD sfaa017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_1()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa017      #顯示到畫面上
               NEXT FIELD sfaa017                         #返回原欄位
         END CONSTRUCT
         
         INPUT BY NAME g_qbe.l_progress,g_qbe.l_closed

         END INPUT
         #end add-point
     
         DISPLAY ARRAY g_sfaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL asfq007_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL asfq007_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_sfaa10_d TO s_detail10.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail10")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body10.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page2_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft301
                  LET g_action_choice="prog_asft301"
                  IF cl_auth_chk_act("prog_asft301") THEN
                     
                     #add-point:ON ACTION prog_asft301 name="menu.detail_show.page2_sub.prog_asft301"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft301'
               LET la_param.param[1] = g_sfaa_d[g_detail_idx].sfaadocno
               LET la_param.param[2] = g_sfaa10_d[g_detail_idx2].sfca001
               
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page2自定義行為 name="ui_dialog.body10.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa11_d TO s_detail11.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail11")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body11.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page3_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft335
                  LET g_action_choice="prog_asft335"
                  IF cl_auth_chk_act("prog_asft335") THEN
                     
                     #add-point:ON ACTION prog_asft335 name="menu.detail_show.page3_sub.prog_asft335"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft335'
               LET la_param.param[1] = g_sfaa11_d[g_detail_idx2].sffbdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page3自定義行為 name="ui_dialog.body11.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa6_d TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 6
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body6.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_6)
            
 
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa7_d TO s_detail7.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 7
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body7.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_7)
            
 
            #add-point:page7自定義行為 name="ui_dialog.body7.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa8_d TO s_detail8.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 8
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail8")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body8.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_8)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page8_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft310
                  LET g_action_choice="prog_asft310"
                  IF cl_auth_chk_act("prog_asft310") THEN
                     
                     #add-point:ON ACTION prog_asft310 name="menu.detail_show.page8_sub.prog_asft310"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft310'
               LET la_param.param[1] = g_sfaa8_d[g_detail_idx2].sfdcdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page8.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page8自定義行為 name="ui_dialog.body8.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa9_d TO s_detail9.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 9
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail9")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body9.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_9)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page9_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft340
                  LET g_action_choice="prog_asft340"
                  IF cl_auth_chk_act("prog_asft340") THEN
                     
                     #add-point:ON ACTION prog_asft340 name="menu.detail_show.page9_sub.prog_asft340"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft340'
               LET la_param.param[1] = g_sfaa9_d[g_detail_idx2].sfecdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page9.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page9自定義行為 name="ui_dialog.body9.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa91_d TO s_detail91.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 10
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail91")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body91.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_10)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page10_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft301
                  LET g_action_choice="prog_asft301"
                  IF cl_auth_chk_act("prog_asft301") THEN
                     
                     #add-point:ON ACTION prog_asft301 name="menu.detail_show.page10_sub.prog_asft301"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft301'
               LET la_param.param[1] = g_sfaa91_d[g_detail_idx2].sfcb001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page10.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page10自定義行為 name="ui_dialog.body91.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa92_d TO s_detail92.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 11
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail92")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body92.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_11)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page11_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmt400
                  LET g_action_choice="prog_apmt400"
                  IF cl_auth_chk_act("prog_apmt400") THEN
                     
                     #add-point:ON ACTION prog_apmt400 name="menu.detail_show.page11_sub.prog_apmt400"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt400'
               LET la_param.param[1] = g_sfaa92_d[g_detail_idx2].pmdadocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page11.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page11自定義行為 name="ui_dialog.body92.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfaa93_d TO s_detail93.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 12
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail93")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body93.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_12)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page12_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmt500
                  LET g_action_choice="prog_apmt500"
                  IF cl_auth_chk_act("prog_apmt500") THEN
                     
                     #add-point:ON ACTION prog_apmt500 name="menu.detail_show.page12_sub.prog_apmt500"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_sfaa93_d[g_detail_idx2].l_pmdndocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page12.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page12自定義行為 name="ui_dialog.body93.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #ming 20150827 add ------------------------------(S)  
         DISPLAY ARRAY g_pmdn_d TO s_detail12.*
            ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 13

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail12")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
         
            #160727-00025#5-s         
            #應用 a43 樣板自動產生(Version:4)
            ON ACTION detail_qrystr
                  MENU "" ATTRIBUTE(STYLE="popup")
                     #add-point:ON ACTION 相關動作 name="menu.detail_show.page10_sub."
        
                     #END add-point
                                    #應用 a43 樣板自動產生(Version:4)
                  ON ACTION prog_apmt501
                     LET g_action_choice="prog_apmt501"
                     IF cl_auth_chk_act("prog_apmt501") THEN
                        
                        #add-point:ON ACTION prog_asft340 name="menu.detail_show.page10_sub.prog_asft340"
                        #應用 a41 樣板自動產生(Version:3)
                        #使用JSON格式組合參數與作業編號(串查)
                        INITIALIZE la_param.* TO NULL
                        LET la_param.prog     = 'apmt501'
                        LET la_param.param[1] = g_pmdn_d[g_detail_idx2].pmdndocno
                     
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun_wait(ls_js)
        
                                             
                     END IF 
                  END MENU 
            #160727-00025#5-e  
         
         END DISPLAY
         #ming 20150827 add ------------------------------(E)
         
         #160523-00055 by whitney add start
         DISPLAY ARRAY g_qcba1_d TO s_detail13.*
            ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 14
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail13")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               
               #160727-00025#5-s         
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION detail_qrystr
                     MENU "" ATTRIBUTE(STYLE="popup")
                        #add-point:ON ACTION 相關動作 name="menu.detail_show.page10_sub."
           
                        #END add-point
                                       #應用 a43 樣板自動產生(Version:4)
                     ON ACTION prog_aqct300
                        LET g_action_choice="prog_aqct300"
                        IF cl_auth_chk_act("prog_aqct300") THEN
                           
                           #add-point:ON ACTION prog_asft340 name="menu.detail_show.page10_sub.prog_asft340"
                           #應用 a41 樣板自動產生(Version:3)
                           #使用JSON格式組合參數與作業編號(串查)
                           INITIALIZE la_param.* TO NULL
                           LET la_param.prog     = 'aqct300'
                           LET la_param.param[1] = g_qcba1_d[g_detail_idx2].qcbadocno
                        
                           LET ls_js = util.JSON.stringify(la_param)
                           CALL cl_cmdrun_wait(ls_js)
                                                          
                        END IF 
                     END MENU 
               #160727-00025#5-e  
            
         END DISPLAY
         
         DISPLAY ARRAY g_qcba2_d TO s_detail14.*
            ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 15
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail14")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               
               #160727-00025#5-s         
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION detail_qrystr
                     MENU "" ATTRIBUTE(STYLE="popup")
                        #add-point:ON ACTION 相關動作 name="menu.detail_show.page10_sub."
           
                        #END add-point
                                       #應用 a43 樣板自動產生(Version:4)
                     ON ACTION prog_apmt501
                        LET g_action_choice="prog_aqct300"
                        IF cl_auth_chk_act("prog_aqct300") THEN
                           
                           #add-point:ON ACTION prog_asft340 name="menu.detail_show.page10_sub.prog_asft340"
                     #應用 a41 樣板自動產生(Version:3)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aqct300'
                     LET la_param.param[1] = g_qcba2_d[g_detail_idx2].qcbadocno
           
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
           
                           #END add-point
                                                
                        END IF 
                     END MENU 
               #160727-00025#5-e  
            
         END DISPLAY
         #160523-00055 by whitney add end

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq007_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #狀態 預設全部
            IF cl_null(g_qbe.l_progress) THEN
               LET g_qbe.l_progress = '3'
            END IF
            #含已結案工單
            IF cl_null(g_qbe.l_closed) THEN
               LET g_qbe.l_closed = 'N'
            END IF
            DISPLAY BY NAME g_qbe.l_progress,g_qbe.l_closed
            #end add-point
            NEXT FIELD sfaa003
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table4
            END IF
 
            IF NOT cl_null(g_wc2_table5) AND g_wc2_table5 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table5
            END IF
 
            IF NOT cl_null(g_wc2_table6) AND g_wc2_table6 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table6
            END IF
 
            IF NOT cl_null(g_wc2_table7) AND g_wc2_table7 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table7
            END IF
 
            IF NOT cl_null(g_wc2_table8) AND g_wc2_table8 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table8
            END IF
 
            IF NOT cl_null(g_wc2_table9) AND g_wc2_table9 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table9
            END IF
 
            IF NOT cl_null(g_wc2_table10) AND g_wc2_table10 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table10
            END IF
 
            IF NOT cl_null(g_wc2_table11) AND g_wc2_table11 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table11
            END IF
 
            IF NOT cl_null(g_wc2_table12) AND g_wc2_table12 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table12
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table4
            END IF
 
            IF NOT cl_null(g_wc2_table5) AND g_wc2_table5 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table5
            END IF
 
            IF NOT cl_null(g_wc2_table6) AND g_wc2_table6 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table6
            END IF
 
            IF NOT cl_null(g_wc2_table7) AND g_wc2_table7 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table7
            END IF
 
            IF NOT cl_null(g_wc2_table8) AND g_wc2_table8 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table8
            END IF
 
            IF NOT cl_null(g_wc2_table9) AND g_wc2_table9 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table9
            END IF
 
            IF NOT cl_null(g_wc2_table10) AND g_wc2_table10 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table10
            END IF
 
            IF NOT cl_null(g_wc2_table11) AND g_wc2_table11 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table11
            END IF
 
            IF NOT cl_null(g_wc2_table12) AND g_wc2_table12 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table12
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL asfq007_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_sfaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_sfaa10_d)
               LET g_export_id[2]   = "s_detail10"
 
               LET g_export_node[3] = base.typeInfo.create(g_sfaa11_d)
               LET g_export_id[3]   = "s_detail11"
 
               LET g_export_node[4] = base.typeInfo.create(g_sfaa2_d)
               LET g_export_id[4]   = "s_detail2"
 
               LET g_export_node[5] = base.typeInfo.create(g_sfaa3_d)
               LET g_export_id[5]   = "s_detail3"
 
               LET g_export_node[6] = base.typeInfo.create(g_sfaa6_d)
               LET g_export_id[6]   = "s_detail6"
 
               LET g_export_node[7] = base.typeInfo.create(g_sfaa7_d)
               LET g_export_id[7]   = "s_detail7"
 
               LET g_export_node[8] = base.typeInfo.create(g_sfaa8_d)
               LET g_export_id[8]   = "s_detail8"
 
               LET g_export_node[9] = base.typeInfo.create(g_sfaa9_d)
               LET g_export_id[9]   = "s_detail9"
 
               LET g_export_node[10] = base.typeInfo.create(g_sfaa91_d)
               LET g_export_id[10]   = "s_detail91"
 
               LET g_export_node[11] = base.typeInfo.create(g_sfaa92_d)
               LET g_export_id[11]   = "s_detail92"
 
               LET g_export_node[12] = base.typeInfo.create(g_sfaa93_d)
               LET g_export_id[12]   = "s_detail93"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq007_b_fill()
 
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
            CALL asfq007_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq007_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq007_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq007_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               LET g_sfaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               LET g_sfaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_sfaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfq007_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
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
 
{<section id="asfq007.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq007_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_str           STRING           #用來做字串處理的  
   DEFINE l_len1          LIKE type_t.num5
   DEFINE l_len2          LIKE type_t.num5
   DEFINE l_wc1           STRING
   DEFINE l_wc2           STRING
   DEFINE l_wc3           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_str = g_wc
   LET l_len1 = l_str.getIndexOf("left_stus",1)    #查出我要的特定字串的位置  
   IF l_len1 > 0 THEN                              #如果大於0，代表有找到特定字串  
      LET l_wc1 = l_str.subString(1,l_len1-5)      #去掉最後的and  
      LET l_wc2 = l_str.subString(l_len1,l_str.getLength())
      LET l_str = l_wc2
      LET l_len2 = l_str.getIndexOf("and",l_len1)  #找找看後面還有沒有and 
      IF l_len2 > 0 THEN
         LET l_wc2 = l_str.subString(1,l_len2-2)
         LET l_wc3 = l_str.subString(l_len2+4,l_str.getLength())
         IF NOT cl_null(l_wc1) THEN
            LET l_wc1 = l_wc1 ," AND ",l_wc3
         ELSE
            LET l_wc1 = l_wc3
         END IF
      END IF

      LET g_wc = l_wc1
   END IF
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
 
   CALL g_sfaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc, " AND sfaasite = '",g_site,"'"
   #含已結案工單
   IF g_qbe.l_closed = 'N' THEN
      LET ls_wc = ls_wc," AND NOT(sfaastus = 'C' OR sfaastus = 'E' OR sfaastus = 'M')"
   END IF
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','',sfaadocno,sfaadocdt,sfaa003,sfaa010,'','',sfaa019,sfaa020, 
       sfaa002,'',sfaa068,'',sfaa012,sfaa049,'',sfaa050,sfaa051,sfaa021,sfaa025,sfaa013,sfaa046,sfaastus, 
       sfaa011  ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK FROM sfaa_t",
 
#table2
                     " LEFT JOIN sfca_t ON sfcaent = sfaaent AND sfaadocno = sfcadocno",
#table3
                     " LEFT JOIN sffb_t ON sffbent = sfaaent AND sfaadocno = sffb005",
#table4
                     " LEFT JOIN sfab_t ON sfabent = sfaaent AND sfaadocno = sfabdocno",
#table5
                     " LEFT JOIN sfac_t ON sfacent = sfaaent AND sfaadocno = sfacdocno",
#table6
                     " LEFT JOIN sfaf_t ON sfafent = sfaaent AND sfaadocno = sfafdocno",
#table7
                     " LEFT JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
#table8
                     " LEFT JOIN sfdc_t ON sfdcent = sfaaent AND sfaadocno = sfdc001",
#table9
                     " LEFT JOIN sfec_t ON sfecent = sfaaent AND sfaadocno = sfec001",
#table10
                     " LEFT JOIN sfcb_t ON sfcbent = sfaaent AND sfaadocno = sfcbdocno AND  = sfcb001 AND  = sfcb002",
#table11
                     " LEFT JOIN pmdb_t ON pmdbent = sfaaent AND sfaadocno = pmdbdocno AND  = pmdbseq",
#table12
                     " LEFT JOIN pmdn_t ON pmdnent = sfaaent AND sfaadocno = pmdndocno AND  = pmdnseq",
 
                     "",
                     " WHERE sfaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfaa_t"),
                     " ORDER BY sfaa_t.sfaadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #160503-00030#9-s--add
   LET ls_sql_rank = " SELECT UNIQUE '','','',sfaadocno,sfaadocdt,sfaa003,sfaa010,t1.imaal003,t1.imaal004,sfaa019, ",
                                   " sfaa020,sfaa002,t2.ooag011,sfaa068,t3.ooefl003,sfaa012,sfaa049,sfaa071,sfaa050,sfaa051, ",  #160425-00019 by whitney add sfaa071
                                   " sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011 
         ,DENSE_RANK() OVER( ORDER BY sfaa_t.sfaadocno) AS RANK FROM sfaa_t",
 
      #170210-00010#1 mark --(S)--
      #因為select語法中並無取出下列相關table資料,且於QBE條件中也無存在於下列相關table中的條件資料
      ##table2
      #" LEFT JOIN sfca_t ON sfcaent = sfaaent AND sfaadocno = sfcadocno",
      ##table3
      #" LEFT JOIN sffb_t ON sffbent = sfaaent AND sfaadocno = sffb005",
      ##table4
      #" LEFT JOIN sfab_t ON sfabent = sfaaent AND sfaadocno = sfabdocno",
      ##table5
      #" LEFT JOIN sfac_t ON sfacent = sfaaent AND sfaadocno = sfacdocno",
      ##table7
      #" LEFT JOIN sfaf_t ON sfafent = sfaaent AND sfaadocno = sfafdocno",
      ##table8
      #" LEFT JOIN sfba_t ON sfbaent = sfaaent AND sfaadocno = sfbadocno",
      ##table9
      #" LEFT JOIN sfdc_t ON sfdcent = sfaaent AND sfaadocno = sfdc001",
      ##table10
      #" LEFT JOIN sfec_t ON sfecent = sfaaent AND sfaadocno = sfec001",
      #170210-00010#1 mark --(E)--
       #語系
       " LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfaa010 AND t1.imaal002 = '"||g_dlang||"' ",
       " LEFT JOIN ooag_t t2 ON t2.ooagent = '"||g_enterprise||"' AND t2.ooag001 = sfaa002 ",
       " LEFT JOIN ooefl_t t3 ON t3.ooeflent = '"||g_enterprise||"' AND t3.ooefl001 = sfaa068 AND t3.ooefl002 = '"||g_dlang||"' ",
       "",
       " WHERE sfaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfaa_t"),
       " ORDER BY sfaa_t.sfaadocno"   
   #160503-00030#9-e-add
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
 
   LET g_sql = "SELECT '','','',sfaadocno,sfaadocdt,sfaa003,sfaa010,'','',sfaa019,sfaa020,sfaa002,'', 
       sfaa068,'',sfaa012,sfaa049,'',sfaa050,sfaa051,sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160503-00030#9-s--add
   LET g_sql = " SELECT '','','',sfaadocno,sfaadocdt,sfaa003,sfaa010,imaal003,imaal004,sfaa019, ",
                      " sfaa020,sfaa002,ooag011,sfaa068,ooefl003,sfaa012,sfaa049,sfaa071,sfaa050,sfaa051, ",  #160425-00019 by whitney add sfaa071
                      " sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011 ",
                 " FROM (",ls_sql_rank,")",
                " WHERE RANK >= ",g_pagestart,
                  " AND RANK < ",g_pagestart + g_num_in_page   
   #160503-00030#9-e--add
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq007_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq007_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].stus,g_sfaa_d[l_ac].sfaadocno, 
       g_sfaa_d[l_ac].sfaadocdt,g_sfaa_d[l_ac].sfaa003,g_sfaa_d[l_ac].sfaa010,g_sfaa_d[l_ac].sfaa010_desc, 
       g_sfaa_d[l_ac].sfaa010_desc_1,g_sfaa_d[l_ac].sfaa019,g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa002, 
       g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa068,g_sfaa_d[l_ac].sfaa068_desc,g_sfaa_d[l_ac].sfaa012, 
       g_sfaa_d[l_ac].sfaa049,g_sfaa_d[l_ac].fullsets,g_sfaa_d[l_ac].sfaa050,g_sfaa_d[l_ac].sfaa051, 
       g_sfaa_d[l_ac].sfaa021,g_sfaa_d[l_ac].sfaa025,g_sfaa_d[l_ac].sfaa013,g_sfaa_d[l_ac].sfaa046,g_sfaa_d[l_ac].sfaastus, 
       g_sfaa_d[l_ac].sfaa011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_sfaa_d[l_ac].sel = 'N'
            
      #進度
      CASE
         WHEN ((g_sfaa_d[l_ac].sfaa050 + g_sfaa_d[l_ac].sfaa051) < g_sfaa_d[l_ac].sfaa012) AND
              (g_sfaa_d[l_ac].sfaa020 < g_today)
            LET g_sfaa_d[l_ac].progress = '2'
            
            IF g_qbe.l_progress = '1' THEN
               CONTINUE FOREACH
            END IF
            
         WHEN ((g_sfaa_d[l_ac].sfaa050 + g_sfaa_d[l_ac].sfaa051) >= g_sfaa_d[l_ac].sfaa012) AND
              (g_sfaa_d[l_ac].sfaa046 > g_sfaa_d[l_ac].sfaa020 OR g_today > g_sfaa_d[l_ac].sfaa020)
            LET g_sfaa_d[l_ac].progress = '2'
            
            IF g_qbe.l_progress = '1' THEN
               CONTINUE FOREACH
            END IF
            
         OTHERWISE
            LET g_sfaa_d[l_ac].progress = '1'
            IF g_qbe.l_progress = '2' THEN
               CONTINUE FOREACH
            END IF
      END CASE
      #end add-point
 
      CALL asfq007_detail_show("'1'")
 
      CALL asfq007_sfaa_t_mask()
 
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
 
   CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF NOT cl_null(l_wc2) THEN
      #將已經產生到畫面上的資料寫入temp table後再做篩選  
      DELETE FROM asfq007_tmp01;  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
      FOR l_ac = 1 TO g_sfaa_d.getLength()
         #161109-00085#40 s
         #INSERT INTO asfq007_tmp01 VALUES(g_sfaa_d[l_ac].*)  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01         
         INSERT INTO asfq007_tmp01(sel,progress,left_stus,sfaadocno,sfaadocdt,
                                   sfaa003,sfaa010,sfaa010_desc,sfaa010_desc_1,sfaa019,
                                   sfaa020,sfaa002,sfaa002_desc,sfaa068,sfaa068_desc,
                                   sfaa012,sfaa049,fullsets,sfaa050,sfaa051,
                                   sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011) 
              #VALUES(g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt,
              VALUES(g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].stus,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt,  #161226-00020#1 mod
                     g_sfaa_d[l_ac].sfaa003,g_sfaa_d[l_ac].sfaa010, g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_1,g_sfaa_d[l_ac].sfaa019,
                     g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa002, g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa068, g_sfaa_d[l_ac].sfaa068_desc,
                     g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa049,g_sfaa_d[l_ac].fullsets,g_sfaa_d[l_ac].sfaa050,g_sfaa_d[l_ac].sfaa051,
                     g_sfaa_d[l_ac].sfaa021,g_sfaa_d[l_ac].sfaa025,g_sfaa_d[l_ac].sfaa013,g_sfaa_d[l_ac].sfaa046,g_sfaa_d[l_ac].sfaastus,g_sfaa_d[l_ac].sfaa011)
         #161109-00085#40 e         
      END FOR

      CALL g_sfaa_d.clear()
      #161109-00085#40 s
      #LET g_sql = "SELECT * ",
      LET g_sql = "SELECT sel,progress,left_stus,sfaadocno,sfaadocdt,
                          sfaa003,sfaa010,sfaa010_desc,sfaa010_desc_1,sfaa019,
                          sfaa020,sfaa002,sfaa002_desc,sfaa068,sfaa068_desc,
                          sfaa012,sfaa049,fullsets,sfaa050,sfaa051,
                          sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011 ",
      #161109-00085#40 e
                  "  FROM asfq007_tmp01 ",  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
                  " WHERE 1=1 ",
                  "   AND ",l_wc2
      PREPARE asfq007_for_stus_prep FROM g_sql
      DECLARE asfq007_for_stus_curs CURSOR FOR asfq007_for_stus_prep

      LET l_ac = 1
      #161109-00085#40 s
      #FOREACH asfq007_for_stus_curs INTO g_sfaa_d[l_ac].*
      #FOREACH asfq007_for_stus_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt,
      FOREACH asfq007_for_stus_curs INTO g_sfaa_d[l_ac].sel,g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].stus,g_sfaa_d[l_ac].sfaadocno,g_sfaa_d[l_ac].sfaadocdt, #161226-00020#1 mod
                                         g_sfaa_d[l_ac].sfaa003,g_sfaa_d[l_ac].sfaa010, g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_1,g_sfaa_d[l_ac].sfaa019,
                                         g_sfaa_d[l_ac].sfaa020,g_sfaa_d[l_ac].sfaa002, g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa068, g_sfaa_d[l_ac].sfaa068_desc,
                                         g_sfaa_d[l_ac].sfaa012,g_sfaa_d[l_ac].sfaa049,g_sfaa_d[l_ac].fullsets,g_sfaa_d[l_ac].sfaa050,g_sfaa_d[l_ac].sfaa051,
                                         g_sfaa_d[l_ac].sfaa021,g_sfaa_d[l_ac].sfaa025,g_sfaa_d[l_ac].sfaa013,g_sfaa_d[l_ac].sfaa046,g_sfaa_d[l_ac].sfaastus,g_sfaa_d[l_ac].sfaa011
      #161109-00085#40 e     
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF 
         CALL asfq007_detail_show("'1'")
         LET l_ac = l_ac + 1
      END FOREACH

      CALL g_sfaa_d.deleteElement(g_sfaa_d.getLength())
   END IF
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_sfaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq007_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq007_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq007_detail_action_trans()
 
   LET l_ac = 1
   IF g_sfaa_d.getLength() > 0 THEN
      CALL asfq007_b_fill2()
   END IF
 
      CALL asfq007_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq007_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq007_filter_show('sfaa003','b_sfaa003')
   CALL asfq007_filter_show('sfaa010','b_sfaa010')
   CALL asfq007_filter_show('sfaa019','b_sfaa019')
   CALL asfq007_filter_show('sfaa020','b_sfaa020')
   CALL asfq007_filter_show('sfaa002','b_sfaa002')
   CALL asfq007_filter_show('sfaa068','b_sfaa068')
   CALL asfq007_filter_show('sfaa012','b_sfaa012')
   CALL asfq007_filter_show('sfaa049','b_sfaa049')
   CALL asfq007_filter_show('sfaa050','b_sfaa050')
   CALL asfq007_filter_show('sfaa051','b_sfaa051')
   CALL asfq007_filter_show('sfaa021','b_sfaa021')
   CALL asfq007_filter_show('sfaa025','b_sfaa025')
   CALL asfq007_filter_show('sfaa013','b_sfaa013')
   CALL asfq007_filter_show('sfaa046','b_sfaa046')
   CALL asfq007_filter_show('sfaastus','b_sfaastus')
   CALL asfq007_filter_show('sfaa011','b_sfaa011')
   CALL asfq007_filter_show('sffbstus','b_sffbstus')
   CALL asfq007_filter_show('sffb029','b_sffb029')
   CALL asfq007_filter_show('sffb020','b_sffb020')
   CALL asfq007_filter_show('sfabseq','b_sfabseq')
   CALL asfq007_filter_show('sfab001','b_sfab001')
   CALL asfq007_filter_show('sfab002','b_sfab002')
   CALL asfq007_filter_show('sfab003','b_sfab003')
   CALL asfq007_filter_show('sfab004','b_sfab004')
   CALL asfq007_filter_show('sfab005','b_sfab005')
   CALL asfq007_filter_show('sfab006','b_sfab006')
   CALL asfq007_filter_show('sfab007','b_sfab007')
   CALL asfq007_filter_show('sfacseq','b_sfacseq')
   CALL asfq007_filter_show('sfac002','b_sfac002')
   CALL asfq007_filter_show('sfac001','b_sfac001')
   CALL asfq007_filter_show('sfac006','b_sfac006')
   CALL asfq007_filter_show('sfac003','b_sfac003')
   CALL asfq007_filter_show('sfac004','b_sfac004')
   CALL asfq007_filter_show('sfac005','b_sfac005')
   CALL asfq007_filter_show('sfafseq','b_sfafseq')
   CALL asfq007_filter_show('sfaf001','b_sfaf001')
   CALL asfq007_filter_show('sfdc016','b_sfdc016')
   CALL asfq007_filter_show('sfdc009','b_sfdc009')
   CALL asfq007_filter_show('sfdc011','b_sfdc011')
   CALL asfq007_filter_show('sfec006','b_sfec006')
   CALL asfq007_filter_show('sfec010','b_sfec010')
   CALL asfq007_filter_show('sfec011','b_sfec011')
   CALL asfq007_filter_show('sfec028','b_sfec028')
   CALL asfq007_filter_show('sfcb001','b_sfcb001')
   CALL asfq007_filter_show('sfcb002','b_sfcb002')
   CALL asfq007_filter_show('sfcb003','b_sfcb003')
   CALL asfq007_filter_show('sfcb004','b_sfcb004')
   CALL asfq007_filter_show('sfcb011','b_sfcb011')
   CALL asfq007_filter_show('sfcb027','b_sfcb027')
   CALL asfq007_filter_show('sfcb050','b_sfcb050')
   CALL asfq007_filter_show('sfcb028','b_sfcb028')
   CALL asfq007_filter_show('sfcb029','b_sfcb029')
   CALL asfq007_filter_show('sfcb030','b_sfcb030')
   CALL asfq007_filter_show('sfcb031','b_sfcb031')
   CALL asfq007_filter_show('sfcb032','b_sfcb032')
   CALL asfq007_filter_show('sfcb033','b_sfcb033')
   CALL asfq007_filter_show('sfcb034','b_sfcb034')
   CALL asfq007_filter_show('sfcb035','b_sfcb035')
   CALL asfq007_filter_show('sfcb036','b_sfcb036')
   CALL asfq007_filter_show('sfcb037','b_sfcb037')
   CALL asfq007_filter_show('sfcb038','b_sfcb038')
   CALL asfq007_filter_show('sfcb039','b_sfcb039')
   CALL asfq007_filter_show('sfcb041','b_sfcb041')
   CALL asfq007_filter_show('sfcb042','b_sfcb042')
   CALL asfq007_filter_show('sfcb043','b_sfcb043')
   CALL asfq007_filter_show('sfcb046','b_sfcb046')
   CALL asfq007_filter_show('sfcb047','b_sfcb047')
   CALL asfq007_filter_show('sfcb048','b_sfcb048')
   CALL asfq007_filter_show('sfcb049','b_sfcb049')
   CALL asfq007_filter_show('sfcb051','b_sfcb051')
   CALL asfq007_filter_show('pmdastus','b_pmdastus')
   CALL asfq007_filter_show('pmdadocno','b_pmdadocno')
   CALL asfq007_filter_show('pmdadocdt','b_pmdadocdt')
   CALL asfq007_filter_show('pmda002','b_pmda002')
   CALL asfq007_filter_show('pmda003','b_pmda003')
   CALL asfq007_filter_show('pmdbseq','b_pmdbseq')
   CALL asfq007_filter_show('pmdb002','b_pmdb002')
   CALL asfq007_filter_show('pmdb004','b_pmdb004')
   CALL asfq007_filter_show('pmdb005','b_pmdb005')
   CALL asfq007_filter_show('pmdb007','b_pmdb007')
   CALL asfq007_filter_show('pmdb006','b_pmdb006')
   CALL asfq007_filter_show('pmdb009','b_pmdb009')
   CALL asfq007_filter_show('pmdb008','b_pmdb008')
   CALL asfq007_filter_show('pmdb030','b_pmdb030')
   CALL asfq007_filter_show('pmdb049','b_pmdb049')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq007.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq007_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   #160503-00030#9-s--add
   DEFINE l_xmdd001         LIKE xmdd_t.xmdd001
   DEFINE l_xmdd004         LIKE xmdd_t.xmdd004
   DEFINE l_xmdd006         LIKE xmdd_t.xmdd006
   DEFINE l_sfaa013         LIKE sfaa_t.sfaa013
   DEFINE l_sfab007         LIKE sfab_t.sfab007   
   DEFINE l_sql             STRING
   DEFINE l_success         LIKE type_t.num5     
   #160503-00030#9-e--add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_sfaa10_d.clear()
#Page3
   CALL g_sfaa11_d.clear()
#Page4
   CALL g_sfaa2_d.clear()
#Page5
   CALL g_sfaa3_d.clear()
#Page6
   CALL g_sfaa6_d.clear()
#Page7
   CALL g_sfaa7_d.clear()
#Page8
   CALL g_sfaa8_d.clear()
#Page9
   CALL g_sfaa9_d.clear()
#Page10
   CALL g_sfaa91_d.clear()
#Page11
   CALL g_sfaa92_d.clear()
#Page12
   CALL g_sfaa93_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   IF g_detail_idx = 0 THEN LET g_detail_idx = 1 END IF   #150907 Sarah add
  #160503-00030#9-s--add  
   #已開工單數量
   LET l_sql = "SELECT sfaa013,sfab007",
               "  FROM sfaa_t,sfab_t",
               " WHERE sfaaent = sfabent",
               "   AND sfaadocno = sfabdocno",
               "   AND sfaaent = ",g_enterprise,
               "   AND sfaasite = '",g_site,"'",
               "   AND sfaa010 = ? ",
               "   AND sfaastus != 'X'",
               "   AND sfab002 = ? ",
               "   AND sfab003 = ? ",
               "   AND sfab004 = ? ",
               "   AND sfab005 = ? "
   PREPARE asfq007_pre FROM l_sql
   DECLARE asft300_cs CURSOR FOR asfq007_pre 
  #160503-00030#9-e--add             
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfca001,sfca003,'','',sfca004,'' FROM sfca_t",
                  "",
                  " WHERE sfcaent=? AND sfcadocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfca_t.sfca001"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR asfq007_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa10_d[l_ac].sfca001,g_sfaa10_d[l_ac].sfca003,g_sfaa10_d[l_ac].sfaa019,g_sfaa10_d[l_ac].sfaa020, 
          g_sfaa10_d[l_ac].sfca004,g_sfaa10_d[l_ac].num
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_asft301")
         LET g_sfaa10_d[l_ac].prog_asft301 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa10_d[l_ac].sfca001), 
             "</a>"
 
      ELSE 
         LET g_sfaa10_d[l_ac].prog_asft301 = g_sfaa10_d[l_ac].sfca001
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      
      #end add-point
 
      CALL asfq007_detail_show("'2'")
 
      CALL asfq007_sfca_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table3
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sffbstus,sffbdocno,sffb001,sffbdocdt,sffb006,sffb029,'','',sffb007, 
          '',sffb008,sffb009,'',sffb017,sffb018,sffb019,sffb020 FROM sffb_t",
                  "",
                  " WHERE sffbent=? AND sffb005=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sffb_t.sffbdocno"
  
      #add-point:單身填充前 name="b_fill2.before_fill3"
       
      LET g_sql = "SELECT   sffbstus,sffbdocno,sffb001,sffbdocdt,sffb006,sffb026,t3.imaal003,t3.imaal004,sffb007, ",  #160921-00033#1 delete  UNIQUE
                  "        t1.oocql004,sffb008,sffb009,t2.ecaa002,sffb017,sffb018,sffb019,sffb020  ",
                  "  FROM sffb_t ",
                  "  LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='221' AND t1.oocql002=sffb007 AND t1.oocql003='"||g_dlang||"' ",
                  "  LEFT JOIN ecaa_t t2 ON t2.ecaaent='"||g_enterprise||"' AND t2.ecaa001 = sffb009 AND t2.ecaasite = sffbsite  ",
                  "  LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001 = sffb026 AND t3.imaal002 = '"||g_dlang||"' ",  #160727-00025#5
                  " WHERE sffbent=? AND sffb005=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sffb_t.sffbdocno"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR asfq007_pb3
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs3 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs3
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa11_d[l_ac].sffbstus,g_sfaa11_d[l_ac].sffbdocno,g_sfaa11_d[l_ac].sffb001,g_sfaa11_d[l_ac].sffbdocdt, 
          g_sfaa11_d[l_ac].sffb006,g_sfaa11_d[l_ac].sffb029,g_sfaa11_d[l_ac].sffb029_desc,g_sfaa11_d[l_ac].sffb029_desc_1, 
          g_sfaa11_d[l_ac].sffb007,g_sfaa11_d[l_ac].sffb007_desc,g_sfaa11_d[l_ac].sffb008,g_sfaa11_d[l_ac].sffb009, 
          g_sfaa11_d[l_ac].sffb009_desc,g_sfaa11_d[l_ac].sffb017,g_sfaa11_d[l_ac].sffb018,g_sfaa11_d[l_ac].sffb019, 
          g_sfaa11_d[l_ac].sffb020
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_asft335")
         LET g_sfaa11_d[l_ac].prog_asft335 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa11_d[l_ac].sffbdocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa11_d[l_ac].prog_asft335 = g_sfaa11_d[l_ac].sffbdocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill3"
      
      #end add-point
 
      CALL asfq007_detail_show("'3'")
 
      CALL asfq007_sffb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table4
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfabseq,sfab001,sfab002,sfab003,sfab004,sfab005,sfab006,'','','','', 
          '',sfab007,'','','','','','' FROM sfab_t",
                  "",
                  " WHERE sfabent=? AND sfabdocno=?"
  
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfab_t.sfabseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill4"
#      LET g_sql = "SELECT  UNIQUE sfcb001,sfcb002,sfcb003,'',sfcb004,sfcb011,'',sfcb027,sfcb050,sfcb028, 
#          sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb041, 
#          sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 FROM sfcb_t",
#                  "",
#                  " WHERE sfcbent = ? AND sfcbdocno = ? "
#      
#      IF NOT cl_null(g_wc2_table4) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
#      END IF
#  
#      LET g_sql = g_sql, " ORDER BY sfcb_t.sfcbdocno,sfcb_t.sfcb001,sfcb_t.sfcb002"      
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb4 FROM g_sql
      DECLARE b_fill_curs4 CURSOR FOR asfq007_pb4
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs4 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs4
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa2_d[l_ac].sfabseq,g_sfaa2_d[l_ac].sfab001,g_sfaa2_d[l_ac].sfab002,g_sfaa2_d[l_ac].sfab003, 
          g_sfaa2_d[l_ac].sfab004,g_sfaa2_d[l_ac].sfab005,g_sfaa2_d[l_ac].sfab006,g_sfaa2_d[l_ac].a1, 
          g_sfaa2_d[l_ac].a2,g_sfaa2_d[l_ac].a3,g_sfaa2_d[l_ac].a4,g_sfaa2_d[l_ac].a5,g_sfaa2_d[l_ac].sfab007, 
          g_sfaa2_d[l_ac].a6,g_sfaa2_d[l_ac].a6_desc,g_sfaa2_d[l_ac].a7,g_sfaa2_d[l_ac].a7_desc,g_sfaa2_d[l_ac].a8, 
          g_sfaa2_d[l_ac].a8_desc
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill4"
      #160503-00030#9-s--add      
       IF g_sfaa2_d[l_ac].sfab001 = '2' THEN
          IF NOT cl_null(g_sfaa2_d[l_ac].sfab002) AND NOT cl_null(g_sfaa2_d[l_ac].sfab003) AND
             NOT cl_null(g_sfaa2_d[l_ac].sfab004) AND NOT cl_null(g_sfaa2_d[l_ac].sfab005) THEN
       
             SELECT xmda004,xmda003,xmda002,xmdd001,xmdd004,xmdd006
               INTO g_sfaa2_d[l_ac].a6,g_sfaa2_d[l_ac].a7,g_sfaa2_d[l_ac].a8,
                    l_xmdd001,l_xmdd004,l_xmdd006
               FROM xmda_t,xmdd_t
              WHERE xmdaent = xmddent
                AND xmdadocno = xmdddocno
                AND xmddent = g_enterprise
                AND xmddsite = g_site
                AND xmdddocno = g_sfaa2_d[l_ac].sfab002
                AND xmddseq = g_sfaa2_d[l_ac].sfab003
                AND xmddseq1 = g_sfaa2_d[l_ac].sfab004
                AND xmddseq2 = g_sfaa2_d[l_ac].sfab005
       	
             LET g_sfaa2_d[l_ac].a1 = l_xmdd006
             LET g_sfaa2_d[l_ac].a2 = l_xmdd004
             
             LET g_sfaa2_d[l_ac].a4 = g_sfaa_d[g_detail_idx].sfaa013
             CALL s_aooi250_convert_qty(l_xmdd001,g_sfaa2_d[l_ac].a2,g_sfaa2_d[l_ac].a4,g_sfaa2_d[l_ac].a1) 
                RETURNING l_success,g_sfaa2_d[l_ac].a3              

             LET g_sfaa2_d[l_ac].a5 = 0
             FOREACH asft300_cs USING g_sfaa_d[g_detail_idx].sfaa010,g_sfaa2_d[l_ac].sfab002,g_sfaa2_d[l_ac].sfab003,
                                      g_sfaa2_d[l_ac].sfab004,g_sfaa2_d[l_ac].sfab005 INTO l_sfaa013,l_sfab007
                                      
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "Foreach:"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   EXIT FOREACH
                END IF    	    
       
                CALL s_aooi250_convert_qty(g_sfaa_d[g_detail_idx].sfaa010,l_sfaa013,g_sfaa2_d[l_ac].a4,l_sfab007) 
                   RETURNING l_success,l_sfab007
       
                LET g_sfaa2_d[l_ac].a5 = g_sfaa2_d[l_ac].a5 + l_sfab007
             END FOREACH 	      	   
          END IF
       END IF 
      #160503-00030#9-e--add       

      #end add-point
 
      CALL asfq007_detail_show("'4'")
 
      CALL asfq007_sfab_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table5
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfacseq,sfac002,sfac001,'','',sfac006,'',sfac003,sfac004,'',sfac005 FROM sfac_t", 
 
                  "",
                  " WHERE sfacent=? AND sfacdocno=?"
  
      IF NOT cl_null(g_wc2_table5) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfac_t.sfacseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill5"
     #160503-00030#9-s--add
      LET g_sql = " SELECT UNIQUE sfacseq,sfac002,sfac001,t1.imaal003,t1.imaal004,sfac006, ",
                  "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfacent AND inaml001=sfac001 AND inaml002=sfac006 AND inaml003='"||g_dlang||"') inaml004, ",
                  "        sfac003,sfac004,t2.oocal003,sfac005 ",
                  "   FROM sfac_t", 
                  "   LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfac001 AND t1.imaal002 = '"||g_dlang||"' ",                  
                  "   LEFT JOIN oocal_t t2 ON t2.oocalent = '"||g_enterprise||"' AND t2.oocal001 = sfac004 AND t2.oocal002 = '"||g_dlang||"' ",                  
                  "  WHERE sfacent=? AND sfacdocno=?"
  
      IF NOT cl_null(g_wc2_table5) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
      END IF  
      LET g_sql = g_sql, " ORDER BY sfac_t.sfacseq" 
     #160503-00030#9-e--add
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb5 FROM g_sql
      DECLARE b_fill_curs5 CURSOR FOR asfq007_pb5
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs5 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs5
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa3_d[l_ac].sfacseq,g_sfaa3_d[l_ac].sfac002,g_sfaa3_d[l_ac].sfac001,g_sfaa3_d[l_ac].sfac001_desc, 
          g_sfaa3_d[l_ac].sfac001_desc_1,g_sfaa3_d[l_ac].sfac006,g_sfaa3_d[l_ac].sfac006_desc,g_sfaa3_d[l_ac].sfac003, 
          g_sfaa3_d[l_ac].sfac004,g_sfaa3_d[l_ac].sfac004_desc,g_sfaa3_d[l_ac].sfac005
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill5"
      
      #end add-point
 
      CALL asfq007_detail_show("'5'")
 
      CALL asfq007_sfac_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table6
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfafseq,sfaf001 FROM sfaf_t",
                  "",
                  " WHERE sfafent=? AND sfafdocno=?"
  
      IF NOT cl_null(g_wc2_table6) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfaf_t.sfafseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill6"
 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb6 FROM g_sql
      DECLARE b_fill_curs6 CURSOR FOR asfq007_pb6
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs6 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs6
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa6_d[l_ac].sfafseq,g_sfaa6_d[l_ac].sfaf001
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill6"
      
      #end add-point
 
      CALL asfq007_detail_show("'6'")
 
      CALL asfq007_sfaf_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table7
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfbasite,sfbaseq,sfbaseq1,sfba006,'','',sfba021,'','',sfba005,'','', 
          sfba003,'',sfba004,sfba013,sfba015,sfba009,sfba028,sfba016,sfba025,'','',sfba017,sfba018,sfba019, 
          '',sfba020,'',sfba002 FROM sfba_t",
                  "",
                  " WHERE sfbaent=? AND sfbadocno=?"
  
      IF NOT cl_null(g_wc2_table7) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1"
  
      #add-point:單身填充前 name="b_fill2.before_fill7"
      #161031-00012#1-s-add
      LET g_sql = " SELECT UNIQUE sfbasite,sfbaseq,sfbaseq1,sfba006,t1.imaal003,t1.imaal004,sfba021, ",
                  "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfbaent AND inaml001=sfba006 AND inaml002=sfba021 AND inaml003='"||g_dlang||"') inaml004, ",
                  "        '',sfba005,t2.imaal003,t2.imaal004,sfba003,t3.oocql004,sfba004, ",
                  "        sfba013,sfba015,sfba009,sfba028,sfba016,sfba025,'','', ",
                  "        sfba017,sfba018,sfba019,t4.inayl003,sfba020,t5.inab003,sfba002 ",
                  "   FROM sfba_t",
                  "   LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfba006 AND t1.imaal002 = '"||g_dlang||"' ",
                  "   LEFT JOIN imaal_t t2 ON t2.imaalent = '"||g_enterprise||"' AND t2.imaal001 = sfba005 AND t2.imaal002 = '"||g_dlang||"' ",
                  "   LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='221' AND t3.oocql002=sfba003 AND t3.oocql003='"||g_dlang||"' ",
                  "   LEFT JOIN inayl_t t4 ON t4.inaylent = '"||g_enterprise||"' AND t4.inayl001 = sfba019 AND t4.inayl002  = '"||g_dlang||"' ",
                  "   LEFT JOIN inab_t t5 ON t5.inabent='"||g_enterprise||"' AND t5.inabsite=sfbasite AND t5.inab001=sfba019 AND t5.inab002=sfba020 ",
                  "  WHERE sfbaent=? AND sfbadocno=?"  
                  
      IF NOT cl_null(g_wc2_table7) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1"        
      #161031-00012#1-e-add
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb7 FROM g_sql
      DECLARE b_fill_curs7 CURSOR FOR asfq007_pb7
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs7 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs7
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa7_d[l_ac].sfbasite,g_sfaa7_d[l_ac].sfbaseq,g_sfaa7_d[l_ac].sfbaseq1,g_sfaa7_d[l_ac].sfba006, 
          g_sfaa7_d[l_ac].sfba006_desc,g_sfaa7_d[l_ac].sfba006_desc_1,g_sfaa7_d[l_ac].sfba021,g_sfaa7_d[l_ac].sfba021_desc, 
          g_sfaa7_d[l_ac].replace,g_sfaa7_d[l_ac].sfba005,g_sfaa7_d[l_ac].sfba005_desc,g_sfaa7_d[l_ac].sfba005_desc_1, 
          g_sfaa7_d[l_ac].sfba003,g_sfaa7_d[l_ac].sfba003_desc,g_sfaa7_d[l_ac].sfba004,g_sfaa7_d[l_ac].sfba013, 
          g_sfaa7_d[l_ac].sfba015,g_sfaa7_d[l_ac].sfba009,g_sfaa7_d[l_ac].sfba028,g_sfaa7_d[l_ac].sfba016, 
          g_sfaa7_d[l_ac].sfba025,g_sfaa7_d[l_ac].num1,g_sfaa7_d[l_ac].num2,g_sfaa7_d[l_ac].sfba017, 
          g_sfaa7_d[l_ac].sfba018,g_sfaa7_d[l_ac].sfba019,g_sfaa7_d[l_ac].sfba019_desc,g_sfaa7_d[l_ac].sfba020, 
          g_sfaa7_d[l_ac].sfba020_desc,g_sfaa7_d[l_ac].sfba002
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill7"
 
      #end add-point
 
      CALL asfq007_detail_show("'7'")
 
      CALL asfq007_sfba_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table8
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','',sfdcdocno,sfdcseq,'',sfdc004,'','',sfdc005,'',sfdc012, 
          '',sfdc013,'',sfdc014,sfdc016,sfdc006,'',sfdc008,sfdc009,'',sfdc011 FROM sfdc_t",
                  "",
                  " WHERE sfdcent=? AND sfdc001=?"
  
      IF NOT cl_null(g_wc2_table8) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfdc_t.sfdcdocno,sfdc_t.sfdcseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill8"
     #161031-00012#1-s-mark
     ##160503-00030#9-s--add
     #LET g_sql = " SELECT UNIQUE sfbasite,sfbaseq,sfbaseq1,sfba006,t1.imaal003,t1.imaal004,sfba021, ",
     #            "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfbaent AND inaml001=sfba006 AND inaml002=sfba021 AND inaml003='"||g_dlang||"') inaml004, ",
     #            "        '',sfba005,t2.imaal003,t2.imaal004,sfba003,t3.oocql004,sfba004, ",
     #            "        sfba013,sfba015,sfba009,sfba028,sfba016,sfba025,'','', ",
     #            "        sfba017,sfba018,sfba019,t4.inayl003,sfba020,t5.inab003,sfba002 ",
     #            "   FROM sfba_t",
     #            "   LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfba006 AND t1.imaal002 = '"||g_dlang||"' ",
     #            "   LEFT JOIN imaal_t t2 ON t2.imaalent = '"||g_enterprise||"' AND t2.imaal001 = sfba005 AND t2.imaal002 = '"||g_dlang||"' ",
     #            "   LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='221' AND t3.oocql002=sfba003 AND t3.oocql003='"||g_dlang||"' ",
     #            "   LEFT JOIN inayl_t t4 ON t4.inaylent = '"||g_enterprise||"' AND t4.inayl001 = sfba019 AND t4.inayl002  = '"||g_dlang||"' ",
     #            "   LEFT JOIN inab_t t5 ON t5.inabent='"||g_enterprise||"' AND t5.inabsite=sfbasite AND t5.inab001=sfba019 AND t5.inab002=sfba020 ",
     #            "  WHERE sfbaent=? AND sfbadocno=?"  
     #IF NOT cl_null(g_wc2_table8) THEN
     #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
     #END IF
     #
     #LET g_sql = g_sql, " ORDER BY sfba_t.sfbaseq,sfba_t.sfbaseq1"  
     ##160503-00030#9-e--add
     #161031-00012#1-e-mark 
     #161019-00003#1-s-mark 
     ##161031-00012#1-s-add
     #LET g_sql = " SELECT UNIQUE '','','','',sfdcdocno,sfdcseq,sfdc004,t4.imaal003,t4.imaal004,sfdc005, ", 
     #            "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfdcent AND inaml001=sfdc004 AND inaml002=sfdc005 AND inaml003='"||g_dlang||"') inaml004, ",      
     #            "        sfdc012,t1.inayl003,sfdc013,t2.inab003,sfdc014,sfdc016,sfdc006,t3.oocal003, ",
     #            "        sfdc008,sfdc009,t5.oocal003,sfdc011 ",
     #            "   FROM sfdc_t",           
     #            "   LEFT JOIN inayl_t t1 ON t1.inaylent = '"||g_enterprise||"' AND t1.inayl001 = sfdc012 AND t1.inayl002  = '"||g_dlang||"' ",          
     #            "   LEFT JOIN inab_t t2 ON t2.inabent='"||g_enterprise||"' AND t2.inabsite=sfdcsite AND t2.inab001=sfdc012 AND t2.inab002=sfdc013 ",                
     #            "   LEFT JOIN oocal_t t3 ON t3.oocalent = '"||g_enterprise||"' AND t3.oocal001 = sfdc006 AND t3.oocal002 = '"||g_dlang||"' ", 
     #            #160727-00025#5-s
     #            "   LEFT JOIN oocal_t t5 ON t3.oocalent = '"||g_enterprise||"' AND t5.oocal001 = sfdc009 AND t5.oocal002 = '"||g_dlang||"' ",  
     #            "   LEFT JOIN imaal_t t4 ON t4.imaalent = '"||g_enterprise||"' AND t4.imaal001 = sfdc004 AND t4.imaal002 = '"||g_dlang||"' ",     
     #            #160727-00025#5-e                  
     #            "  WHERE sfdcent=? AND sfdc001=? "
     #161019-00003#1-e-mark            
     #161019-00003#1-s-add
      LET g_sql = " SELECT UNIQUE '','','','',sfdddocno,sfddseq,sfddseq1,sfdd001,t4.imaal003,t4.imaal004,sfdd013, ", 
                  "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfddent AND inaml001=sfdd001 AND inaml002=sfdd013 AND inaml003='"||g_dlang||"') inaml004, ",      
                  "        sfdd003,t1.inayl003,sfdd004,t2.inab003,sfdd005,sfdd010,sfdd006,t3.oocal003, ",
                  "        sfdd007,sfdd008,t5.oocal003,sfdd009 ",
                  "   FROM sfdc_t,sfdd_t ",  
                  "   LEFT JOIN inayl_t t1 ON t1.inaylent = '"||g_enterprise||"' AND t1.inayl001 = sfdd003 AND t1.inayl002  = '"||g_dlang||"' ",          
                  "   LEFT JOIN inab_t t2 ON t2.inabent='"||g_enterprise||"' AND t2.inabsite=sfddsite AND t2.inab001=sfdd003 AND t2.inab002=sfdd004 ",                 
                  "   LEFT JOIN oocal_t t3 ON t3.oocalent = '"||g_enterprise||"' AND t3.oocal001 = sfdd006 AND t3.oocal002 = '"||g_dlang||"' ", 
                  "   LEFT JOIN imaal_t t4 ON t4.imaalent = '"||g_enterprise||"' AND t4.imaal001 = sfdd001 AND t4.imaal002 = '"||g_dlang||"' ",                      
                  "   LEFT JOIN oocal_t t5 ON t5.oocalent = '"||g_enterprise||"' AND t5.oocal001 = sfdd008 AND t5.oocal002 = '"||g_dlang||"' ",  #161205-00038#1 t3.oocalent换成t5.oocalent  
                  "  WHERE sfdcent = sfddent AND sfdcdocno = sfdddocno AND sfdcseq =sfddseq ",
                  "    AND sfdcent = ? AND sfdc001 = ?" 
     
     #161019-00003#1-e-add
  
      IF NOT cl_null(g_wc2_table8) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
      END IF
     
      LET g_sql = g_sql, " ORDER BY sfdddocno,sfddseq,sfddseq1"      
     #161031-00012#1-e-add
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb8 FROM g_sql
      DECLARE b_fill_curs8 CURSOR FOR asfq007_pb8
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs8 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs8
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa8_d[l_ac].sfdcsite,g_sfaa8_d[l_ac].sfdastus,g_sfaa8_d[l_ac].sfda002,g_sfaa8_d[l_ac].sfda001, 
          g_sfaa8_d[l_ac].sfdcdocno,g_sfaa8_d[l_ac].sfdcseq,g_sfaa8_d[l_ac].l_sfddseq1,g_sfaa8_d[l_ac].sfdc004, 
          g_sfaa8_d[l_ac].sfdc004_desc,g_sfaa8_d[l_ac].sfdc004_desc_1,g_sfaa8_d[l_ac].sfdc005,g_sfaa8_d[l_ac].sfdc005_desc, 
          g_sfaa8_d[l_ac].sfdc012,g_sfaa8_d[l_ac].sfdc012_desc,g_sfaa8_d[l_ac].sfdc013,g_sfaa8_d[l_ac].sfdc013_desc, 
          g_sfaa8_d[l_ac].sfdc014,g_sfaa8_d[l_ac].sfdc016,g_sfaa8_d[l_ac].sfdc006,g_sfaa8_d[l_ac].sfdc006_desc, 
          g_sfaa8_d[l_ac].sfdc008,g_sfaa8_d[l_ac].sfdc009,g_sfaa8_d[l_ac].sfdc009_desc,g_sfaa8_d[l_ac].sfdc011 
 
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_asft310")
         LET g_sfaa8_d[l_ac].prog_asft310 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa8_d[l_ac].sfdcdocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa8_d[l_ac].prog_asft310 = g_sfaa8_d[l_ac].sfdcdocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill8"
      IF cl_null(g_sfaa7_d[l_ac].sfba013) THEN
         LET g_sfaa7_d[l_ac].sfba013 = 0
      END IF
      IF cl_null(g_sfaa7_d[l_ac].sfba015) THEN
         LET g_sfaa7_d[l_ac].sfba015 = 0
      END IF
      IF cl_null(g_sfaa7_d[l_ac].sfba016) THEN
         LET g_sfaa7_d[l_ac].sfba016 = 0
      END IF
      #end add-point
 
      CALL asfq007_detail_show("'8'")
 
      CALL asfq007_sfdc_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table9
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfecsite,'','',sfecdocno,sfecseq,'',sfec002,sfec003,'','',sfec005, 
          '','',sfec006,'',sfec012,'',sfec013,'',sfec014,sfec015,sfec008,'',sfec009,sfec010,'',sfec011, 
          sfec028,sfec016 FROM sfec_t",
                  "",
                  " WHERE sfecent=? AND sfec001=?"
  
      IF NOT cl_null(g_wc2_table9) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table9 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfec_t.sfecdocno,sfec_t.sfecseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill9"
     #161031-00012#1-s-mark  
     ##160503-00030#9-s--add        
     #LET g_sql = " SELECT UNIQUE '','','','',sfdcdocno,sfdcseq,sfdc004,t4.imaal003,t4.imaal004,sfdc005, ",
     #            "(SELECT inaml004 FROM inaml_t WHERE inamlent=sfdcent AND inaml001=sfdc004 AND inaml002=sfdc005 AND inaml003='"||g_dlang||"') inaml004, ",      
     #            "        sfdc012,t1.inayl003,sfdc013,t2.inab003,sfdc014,sfdc016,sfdc006,t3.oocal003, ",
     #            "        sfdc008,sfdc009,t5.oocal003,sfdc011 ",
     #            "   FROM sfdc_t",
     #            "   LEFT JOIN inayl_t t1 ON t1.inaylent = '"||g_enterprise||"' AND t1.inayl001 = sfdc012 AND t1.inayl002  = '"||g_dlang||"' ",
     #            "   LEFT JOIN inab_t t2 ON t2.inabent='"||g_enterprise||"' AND t2.inabsite=sfdcsite AND t2.inab001=sfdc012 AND t2.inab002=sfdc013 ",
     #            "   LEFT JOIN oocal_t t3 ON t3.oocalent = '"||g_enterprise||"' AND t3.oocal001 = sfdc006 AND t3.oocal002 = '"||g_dlang||"' ", 
     #            #160727-00025#5-s
     #            "   LEFT JOIN oocal_t t5 ON t3.oocalent = '"||g_enterprise||"' AND t5.oocal001 = sfdc009 AND t5.oocal002 = '"||g_dlang||"' ",  
     #            "   LEFT JOIN imaal_t t4 ON t4.imaalent = '"||g_enterprise||"' AND t4.imaal001 = sfdc004 AND t4.imaal002 = '"||g_dlang||"' ",     
     #            #160727-00025#5-e                  
     #            "  WHERE sfdcent=? AND sfdc001=?"
     #
     #IF NOT cl_null(g_wc2_table9) THEN
     #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table9 CLIPPED
     #END IF
     #
     #LET g_sql = g_sql, " ORDER BY sfdc_t.sfdcdocno,sfdc_t.sfdcseq" 
     ##160503-00030#9-e--add
     #161031-00012#1-e-mark 
     #161031-00012#1-s-add
      LET g_sql = "SELECT  UNIQUE sfecsite,'','',sfecdocno,sfecseq,'',sfec002, ",
                   "       sfec003,'','',sfec005,t1.imaal003,t1.imaal004,sfec006,t5.inaml004,sfec012,t2.inayl003,sfec013,t3.inab003, ",
                   "       sfec014,sfec015,sfec008,t4.oocal003,sfec009,sfec010,t6.oocal003,sfec011,sfec028,sfec016  ",
                   " FROM sfec_t",
                   " LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfec005 AND t1.imaal002 = '"||g_dlang||"' ",                  
                   " LEFT JOIN inayl_t t2 ON t2.inaylent = '"||g_enterprise||"' AND t2.inayl001 = sfec012 AND t2.inayl002  = '"||g_dlang||"' ",
                   " LEFT JOIN inab_t t3 ON t3.inabent='"||g_enterprise||"' AND t3.inabsite=sfecsite AND t3.inab001=sfec012 AND t3.inab002=sfec013 ",
                   " LEFT JOIN oocal_t t4 ON t4.oocalent = '"||g_enterprise||"' AND t4.oocal001 = sfec008 AND t4.oocal002 = '"||g_dlang||"' ",  
                   #160727-00025#5-s
                   " LEFT JOIN inaml_t t5 ON t5.inamlent = '"||g_enterprise||"' AND t5.inaml001 = sfec005 AND t5.inaml002 = sfec006 AND t5.inaml003 = '"||g_dlang||"' ",       
                   " LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = sfec010 AND t6.oocal002 = '"||g_dlang||"' ",                    
                   #160727-00025#5-e 
                   " WHERE sfecent=? AND sfec001=?" 
                   
      IF NOT cl_null(g_wc2_table9) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table9 CLIPPED
      END IF
      
      LET g_sql = g_sql, " UNION ",
                         "SELECT UNIQUE pmdtsite,'','',pmdtdocno,pmdtseq,'',pmdt081,pmdt082,'','',pmdt006,",
                         "              t1.imaal003,t1.imaal004,pmdt007,t5.inaml004,pmdt016,t2.inayl003,pmdt017,t3.inab003,pmdt018,pmdt063,pmdt019,t4.oocal003,pmdt020,pmdt021,t6.oocal003,pmdt022,pmdt219,pmdt089 ",
                         "  FROM pmdt_t",
                         " LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = pmdt006 AND t1.imaal002 = '"||g_dlang||"' ",                  
                         " LEFT JOIN inayl_t t2 ON t2.inaylent = '"||g_enterprise||"' AND t2.inayl001 = pmdt016 AND t2.inayl002  = '"||g_dlang||"' ",
                         " LEFT JOIN inab_t t3 ON t3.inabent='"||g_enterprise||"' AND t3.inabsite=pmdtsite AND t3.inab001=pmdt016 AND t3.inab002=pmdt017 ",
                         " LEFT JOIN oocal_t t4 ON t4.oocalent = '"||g_enterprise||"' AND t4.oocal001 = pmdt019 AND t4.oocal002 = '"||g_dlang||"' ",   
                         #160727-00025#5-s
                         " LEFT JOIN inaml_t t5 ON t5.inamlent = '"||g_enterprise||"' AND t5.inaml001 = pmdt006 AND t5.inaml002 = pmdt007 AND t5.inaml003 = '"||g_dlang||"' ",       
                         " LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = pmdt021 AND t6.oocal002 = '"||g_dlang||"' ",                    
                         #160727-00025#5-e                          
                         " WHERE pmdtent= '",g_enterprise,"' ", 
                         " AND pmdt001=(SELECT pmdldocno ", 
                         "                FROM pmdl_t ", 
                         "               WHERE pmdlent='",g_enterprise,"' ", 
                         "                 AND pmdl008='",g_sfaa_d[g_detail_idx].sfaadocno,"')" 
      LET g_sql = g_sql, " ORDER BY sfecdocno,sfecseq"        
     #161031-00012#1-e-add     
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb9 FROM g_sql
      DECLARE b_fill_curs9 CURSOR FOR asfq007_pb9
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs9 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs9
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa9_d[l_ac].sfecsite,g_sfaa9_d[l_ac].sfeastus,g_sfaa9_d[l_ac].sfea001,g_sfaa9_d[l_ac].sfecdocno, 
          g_sfaa9_d[l_ac].sfecseq,g_sfaa9_d[l_ac].sfeb002,g_sfaa9_d[l_ac].sfec002,g_sfaa9_d[l_ac].sfec003, 
          g_sfaa9_d[l_ac].qcbc002,g_sfaa9_d[l_ac].qcbc002_desc,g_sfaa9_d[l_ac].sfec005,g_sfaa9_d[l_ac].sfec005_desc, 
          g_sfaa9_d[l_ac].sfec005_desc_1,g_sfaa9_d[l_ac].sfec006,g_sfaa9_d[l_ac].sfec006_desc,g_sfaa9_d[l_ac].sfec012, 
          g_sfaa9_d[l_ac].sfec012_desc,g_sfaa9_d[l_ac].sfec013,g_sfaa9_d[l_ac].sfec013_desc,g_sfaa9_d[l_ac].sfec014, 
          g_sfaa9_d[l_ac].sfec015,g_sfaa9_d[l_ac].sfec008,g_sfaa9_d[l_ac].sfec008_desc,g_sfaa9_d[l_ac].sfec009, 
          g_sfaa9_d[l_ac].sfec010,g_sfaa9_d[l_ac].sfec010_desc,g_sfaa9_d[l_ac].sfec011,g_sfaa9_d[l_ac].sfec028, 
          g_sfaa9_d[l_ac].sfec016
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_asft340")
         LET g_sfaa9_d[l_ac].prog_asft340 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa9_d[l_ac].sfecdocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa9_d[l_ac].prog_asft340 = g_sfaa9_d[l_ac].sfecdocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill9"
#      IF cl_null(g_sfaa7_d[l_ac].sfba013) THEN
#         LET g_sfaa7_d[l_ac].sfba013 = 0
#      END IF
#      IF cl_null(g_sfaa7_d[l_ac].sfba015) THEN
#         LET g_sfaa7_d[l_ac].sfba015 = 0
#      END IF
#      IF cl_null(g_sfaa7_d[l_ac].sfba016) THEN
#         LET g_sfaa7_d[l_ac].sfba016 = 0
#      END IF
      #end add-point
 
      CALL asfq007_detail_show("'9'")
 
      CALL asfq007_sfec_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table10
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE sfcb001,sfcb002,sfcb003,'',sfcb004,sfcb011,'',sfcb027,sfcb050,sfcb028, 
          sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb041, 
          sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 FROM sfcb_t",
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table10) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table10 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfcb_t.sfcbdocno,sfcb_t.sfcb001,sfcb_t.sfcb002"
  
      #add-point:單身填充前 name="b_fill2.before_fill10"
     #160503-00030#9-s-mark  
     ##ming 20150827 add ---------------------------------(S) 
     #LET g_sql = "SELECT  UNIQUE sfecsite,'','',sfecdocno,sfecseq,'',sfec002,sfec003,'','',sfec005, 
     #    '','',sfec012,'',sfec013,'',sfec014,sfec015,sfec016,sfec009,sfec008,'' FROM sfec_t",
     #            "",
     #            " WHERE sfecent=? AND sfec001=?" 
     #IF NOT cl_null(g_wc2_table10) THEN
     #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table10 CLIPPED
     #END IF
     #
     #LET g_sql = g_sql, " UNION ",
     #                   "SELECT UNIQUE pmdtsite,'','',pmdtdocno,pmdtseq,'',pmdt081,pmdt082,'','',pmdt006,",
     #                   "              '','',pmdt016,'',pmdt017,'',pmdt018,pmdt063,pmdt089,pmdt020,pmdt019,''",
     #                   "  FROM pmdt_t",
     #                   " WHERE pmdtent= '",g_enterprise,"' ", 
     #                   " AND pmdt001=(SELECT pmdldocno ", 
     #                   "                FROM pmdl_t ", 
     #                   "               WHERE pmdlent='",g_enterprise,"' ", 
     #                   "                 AND pmdl008='",g_sfaa_d[g_detail_idx].sfaadocno,"')" 
     #LET g_sql = g_sql, " ORDER BY sfecdocno,sfecseq"   
     ##ming 20150827 add ---------------------------------(E) 
     #160503-00030#9-e-mark
     #161031-00012#1-s-mark
     ##160503-00030#9-s-add     
     #LET g_sql = "SELECT  UNIQUE sfecsite,'','',sfecdocno,sfecseq,'',sfec002, ",
     #             "       sfec003,'','',sfec005,t1.imaal003,t1.imaal004,sfec006,t5.inaml004,sfec012,t2.inayl003,sfec013,t3.inab003, ",
     #             "       sfec014,sfec015,sfec008,t4.oocal003,sfec009,sfec010,t6.oocal003,sfec011,sfec028,sfec016  ",
     #             " FROM sfec_t",
     #             " LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = sfec005 AND t1.imaal002 = '"||g_dlang||"' ",                  
     #             " LEFT JOIN inayl_t t2 ON t2.inaylent = '"||g_enterprise||"' AND t2.inayl001 = sfec012 AND t2.inayl002  = '"||g_dlang||"' ",
     #             " LEFT JOIN inab_t t3 ON t3.inabent='"||g_enterprise||"' AND t3.inabsite=sfecsite AND t3.inab001=sfec012 AND t3.inab002=sfec013 ",
     #             " LEFT JOIN oocal_t t4 ON t4.oocalent = '"||g_enterprise||"' AND t4.oocal001 = sfec008 AND t4.oocal002 = '"||g_dlang||"' ",  
     #             #160727-00025#5-s
     #             " LEFT JOIN inaml_t t5 ON t5.inamlent = '"||g_enterprise||"' AND t5.inaml001 = sfec005 AND t5.inaml002 = sfec006 AND t5.inaml003 = '"||g_dlang||"' ",       
     #             " LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = sfec010 AND t6.oocal002 = '"||g_dlang||"' ",                    
     #             #160727-00025#5-e 
     #             " WHERE sfecent=? AND sfec001=?" 
     #IF NOT cl_null(g_wc2_table10) THEN
     #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table10 CLIPPED
     #END IF
     #
     #LET g_sql = g_sql, " UNION ",
     #                   "SELECT UNIQUE pmdtsite,'','',pmdtdocno,pmdtseq,'',pmdt081,pmdt082,'','',pmdt006,",
     #                   "              t1.imaal003,t1.imaal004,pmdt007,t5.inaml004,pmdt016,t2.inayl003,pmdt017,t3.inab003,pmdt018,pmdt063,pmdt019,t4.oocal003,pmdt020,pmdt021,t6.oocal003,pmdt022,pmdt219,pmdt089 ",
     #                   "  FROM pmdt_t",
     #                   " LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = pmdt006 AND t1.imaal002 = '"||g_dlang||"' ",                  
     #                   " LEFT JOIN inayl_t t2 ON t2.inaylent = '"||g_enterprise||"' AND t2.inayl001 = pmdt016 AND t2.inayl002  = '"||g_dlang||"' ",
     #                   " LEFT JOIN inab_t t3 ON t3.inabent='"||g_enterprise||"' AND t3.inabsite=pmdtsite AND t3.inab001=pmdt016 AND t3.inab002=pmdt017 ",
     #                   " LEFT JOIN oocal_t t4 ON t4.oocalent = '"||g_enterprise||"' AND t4.oocal001 = pmdt019 AND t4.oocal002 = '"||g_dlang||"' ",   
     #                   #160727-00025#5-s
     #                   " LEFT JOIN inaml_t t5 ON t5.inamlent = '"||g_enterprise||"' AND t5.inaml001 = pmdt006 AND t5.inaml002 = pmdt007 AND t5.inaml003 = '"||g_dlang||"' ",       
     #                   " LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = pmdt021 AND t6.oocal002 = '"||g_dlang||"' ",                    
     #                   #160727-00025#5-e                          
     #                   " WHERE pmdtent= '",g_enterprise,"' ", 
     #                   " AND pmdt001=(SELECT pmdldocno ", 
     #                   "                FROM pmdl_t ", 
     #                   "               WHERE pmdlent='",g_enterprise,"' ", 
     #                   "                 AND pmdl008='",g_sfaa_d[g_detail_idx].sfaadocno,"')" 
     #LET g_sql = g_sql, " ORDER BY sfecdocno,sfecseq"      
     ##160503-00030#9-e-add
     #161031-00012#1-e-mark 
     #161031-00012#1-s-add
      LET g_sql = "SELECT  UNIQUE sfcb001,sfcb002,sfcb003,t1.oocql004,sfcb004,sfcb011,t2.ecaa002,sfcb027,sfcb050,sfcb028, 
                                  sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb041, 
                                  sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 FROM sfcb_t",
          
                  "  LEFT JOIN oocql_t t1 ON t1.oocqlent = '"||g_enterprise||"' AND t1.oocql001 = '221' AND t1.oocql002 = sfcb003 AND t1.oocql003 = '",g_dlang,"'",
                  "  LEFT JOIN ecaa_t t2 ON t2.ecaaent = '"||g_enterprise||"' AND t2.ecaa001 = sfcb011 AND t2.ecaasite = sfcbsite ", 
                  " WHERE sfcbent = ? AND sfcbdocno = ? "
      
      IF NOT cl_null(g_wc2_table10) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table10 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY sfcb001,sfcb002"       
     #161031-00012#1-e-add     
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb10 FROM g_sql
      DECLARE b_fill_curs10 CURSOR FOR asfq007_pb10
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs10 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs10
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa91_d[l_ac].sfcb001,g_sfaa91_d[l_ac].sfcb002,g_sfaa91_d[l_ac].sfcb003,g_sfaa91_d[l_ac].sfcb003_desc, 
          g_sfaa91_d[l_ac].sfcb004,g_sfaa91_d[l_ac].sfcb011,g_sfaa91_d[l_ac].sfcb011_desc,g_sfaa91_d[l_ac].sfcb027, 
          g_sfaa91_d[l_ac].sfcb050,g_sfaa91_d[l_ac].sfcb028,g_sfaa91_d[l_ac].sfcb029,g_sfaa91_d[l_ac].sfcb030, 
          g_sfaa91_d[l_ac].sfcb031,g_sfaa91_d[l_ac].sfcb032,g_sfaa91_d[l_ac].sfcb033,g_sfaa91_d[l_ac].sfcb034, 
          g_sfaa91_d[l_ac].sfcb035,g_sfaa91_d[l_ac].sfcb036,g_sfaa91_d[l_ac].sfcb037,g_sfaa91_d[l_ac].sfcb038, 
          g_sfaa91_d[l_ac].sfcb039,g_sfaa91_d[l_ac].sfcb041,g_sfaa91_d[l_ac].sfcb042,g_sfaa91_d[l_ac].sfcb043, 
          g_sfaa91_d[l_ac].sfcb046,g_sfaa91_d[l_ac].sfcb047,g_sfaa91_d[l_ac].sfcb048,g_sfaa91_d[l_ac].sfcb049, 
          g_sfaa91_d[l_ac].sfcb051
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_asft3011")
         LET g_sfaa91_d[l_ac].prog_asft3011 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa91_d[l_ac].sfcb001), 
             "</a>"
 
      ELSE 
         LET g_sfaa91_d[l_ac].prog_asft3011 = g_sfaa91_d[l_ac].sfcb001
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill10"
      
      #end add-point
 
      CALL asfq007_detail_show("'10'")
 
      CALL asfq007_sfcb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table11
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','','','','',pmdbseq,pmdb002,pmdb004,'','',pmdb005,'',pmdb007, 
          '',pmdb006,pmdb009,'',pmdb008,pmdb030,pmdb049 FROM pmdb_t",
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table11) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table11 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill11"
#      LET g_sql = "SELECT UNIQUE sfecsite,'',sfecdocno,sfecseq,'',sfec002,",
#                  "              sfec003,'','',sfec005,'','',sfec012,'',",
#                  "              sfec013,'',sfec014,sfec015,sfec016,sfec009,",
#                  "              sfec008,''",
#                  "  FROM sfec_t",
#                  " WHERE sfecent=? AND sfec001=?"
# 
#      IF NOT cl_null(g_wc2_table11) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table11 CLIPPED
#      END IF
#    
#     LET g_sql = g_sql, " ORDER BY sfecdocno,sfecseq"
     #161031-00012#1-s-mark 
     #LET g_sql = "SELECT  UNIQUE sfcb001,sfcb002,sfcb003,t1.oocql004,sfcb004,sfcb011,t2.ecaa002,sfcb027,sfcb050,sfcb028, 
     #                            sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb041, 
     #                            sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 FROM sfcb_t",
     #    
     #            "  LEFT JOIN oocql_t t1 ON t1.oocqlent = '"||g_enterprise||"' AND t1.oocql001 = '221' AND t1.oocql002 = sfcb003 AND t1.oocql003 = '",g_dlang,"'",
     #            "  LEFT JOIN ecaa_t t2 ON t2.ecaaent = '"||g_enterprise||"' AND t2.ecaa001 = sfcb011 AND t2.ecaasite = sfcbsite ", 
     #            " WHERE sfcbent = ? AND sfcbdocno = ? "
     #
     #IF NOT cl_null(g_wc2_table11) THEN
     #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table11 CLIPPED
     #END IF
     #
     #LET g_sql = g_sql, " ORDER BY sfcb001,sfcb002"   
     #161031-00012#1-e-mark 
     #161031-00012#1-s-add
      LET g_sql = " SELECT UNIQUE pmdastus,pmdadocno,pmdadocdt,pmda002,t1.ooag011,pmda003,t2.ooefl003,pmdbseq,pmdb003,pmdb004,t3.imaal003,t3.imaal004,pmdb005,t4.inaml004,pmdb007, 
                           t5.oocal003,pmdb006,pmdb009,t6.oocal003,pmdb008,pmdb030,pmdb049 FROM pmdb_t",
                  "  INNER JOIN pmda_t ON pmdaent = pmdbent AND pmdadocno = pmdbdocno ",         
                  "   LEFT JOIN ooag_t t1 ON t1.ooagent = '"||g_enterprise||"' AND t1.ooag001 = pmda002 ",
                  "   LEFT JOIN ooefl_t t2 ON t2.ooeflent = '"||g_enterprise||"' AND t2.ooefl001 = pmda003 AND t2.ooefl002 = '",g_dlang,"'",
                  "   LEFT JOIN imaal_t t3 ON t3.imaalent = '"||g_enterprise||"' AND t3.imaal001 = pmdb004 AND t3.imaal002 = '",g_dlang ,"'",
                  "   LEFT JOIN inaml_t t4 ON t4.inamlent = '"||g_enterprise||"' AND t4.inaml001 = pmdb004 AND t4.inaml002 = pmdb005 AND t4.inaml003 = '",g_dlang,"'",
                  "   LEFT JOIN oocal_t t5 ON t5.oocalent = '"||g_enterprise||"' AND t5.oocal001 = pmdb007 AND t5.oocal002 = '",g_dlang,"'",
                  "   LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = pmdb007 AND t6.oocal002 = '",g_dlang,"'",
                  "  WHERE 1=1 ",
                  "    AND pmdbent = ? AND pmdb001 = ? "
  
      IF NOT cl_null(g_wc2_table11) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table11 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdadocno,pmdbseq"     
      #161031-00012#1-e-add
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb11 FROM g_sql
      DECLARE b_fill_curs11 CURSOR FOR asfq007_pb11
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs11 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs11
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa92_d[l_ac].pmdastus,g_sfaa92_d[l_ac].pmdadocno,g_sfaa92_d[l_ac].pmdadocdt,g_sfaa92_d[l_ac].pmda002, 
          g_sfaa92_d[l_ac].pmda002_desc,g_sfaa92_d[l_ac].pmda003,g_sfaa92_d[l_ac].pmda003_desc,g_sfaa92_d[l_ac].pmdbseq, 
          g_sfaa92_d[l_ac].pmdb002,g_sfaa92_d[l_ac].pmdb004,g_sfaa92_d[l_ac].pmdb004_desc,g_sfaa92_d[l_ac].pmdb004_desc_1, 
          g_sfaa92_d[l_ac].pmdb005,g_sfaa92_d[l_ac].pmdb005_desc,g_sfaa92_d[l_ac].pmdb007,g_sfaa92_d[l_ac].pmdb007_desc, 
          g_sfaa92_d[l_ac].pmdb006,g_sfaa92_d[l_ac].pmdb009,g_sfaa92_d[l_ac].pmdb009_desc,g_sfaa92_d[l_ac].pmdb008, 
          g_sfaa92_d[l_ac].pmdb030,g_sfaa92_d[l_ac].pmdb049
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_apmt400")
         LET g_sfaa92_d[l_ac].prog_apmt400 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa92_d[l_ac].pmdadocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa92_d[l_ac].prog_apmt400 = g_sfaa92_d[l_ac].pmdadocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill11"
      
      #end add-point
 
      CALL asfq007_detail_show("'11'")
 
      CALL asfq007_pmdb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table12
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','' FROM pmdn_t",
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table12) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table12 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdn_t.pmdndocno,pmdn_t.pmdnseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill12"
      #161031-00012#1-s-mark
      #LET g_sql = " SELECT UNIQUE pmdastus,pmdadocno,pmdadocdt,pmda002,t1.ooag011,pmda003,t2.ooefl003,pmdbseq,pmdb003,pmdb004,t3.imaal003,t3.imaal004,pmdb005,t4.inaml004,pmdb007, 
      #                     t5.oocal003,pmdb006,pmdb009,t6.oocal003,pmdb008,pmdb030,pmdb049 FROM pmdb_t",
      #            "  INNER JOIN pmda_t ON pmdaent = pmdbent AND pmdadocno = pmdbdocno ",         
      #            "   LEFT JOIN ooag_t t1 ON t1.ooagent = '"||g_enterprise||"' AND t1.ooag001 = pmda002 ",
      #            "   LEFT JOIN ooefl_t t2 ON t2.ooeflent = '"||g_enterprise||"' AND t2.ooefl001 = pmda003 AND t2.ooefl002 = '",g_dlang,"'",
      #            "   LEFT JOIN imaal_t t3 ON t3.imaalent = '"||g_enterprise||"' AND t3.imaal001 = pmdb004 AND t3.imaal002 = '",g_dlang ,"'",
      #            "   LEFT JOIN inaml_t t4 ON t4.inamlent = '"||g_enterprise||"' AND t4.inaml001 = pmdb004 AND t4.inaml002 = pmdb005 AND t4.inaml003 = '",g_dlang,"'",
      #            "   LEFT JOIN oocal_t t5 ON t5.oocalent = '"||g_enterprise||"' AND t5.oocal001 = pmdb007 AND t5.oocal002 = '",g_dlang,"'",
      #            "   LEFT JOIN oocal_t t6 ON t6.oocalent = '"||g_enterprise||"' AND t6.oocal001 = pmdb007 AND t6.oocal002 = '",g_dlang,"'",
      #            "  WHERE 1=1 ",
      #            "    AND pmdbent = ? AND pmdb001 = ? "
      #
      #IF NOT cl_null(g_wc2_table12) THEN
      #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table12 CLIPPED
      #END IF
      #
      #LET g_sql = g_sql, " ORDER BY pmdadocno,pmdbseq"
      #161031-00012#1-s-mark
      LET g_sql = " SELECT UNIQUE pmdlstus,pmdndocno,pmdnseq,pmdn001,t1.imaal003,t1.imaal004,pmdn002,t2.inaml004,pmdn006,t3.oocal003,",
                  "               pmdn007,pmdn008,t4.oocal003,pmdn009,pmdn012,pmdn013,pmdn014 FROM pmdn_t",       
                  "  INNER JOIN pmdl_t ON pmdlent = pmdnent AND pmdldocno = pmdndocno ",
                  "   LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = pmdn001 AND t1.imaal002 = '",g_dlang,"'",
                  "   LEFT JOIN inaml_t t2 ON t2.inamlent = '"||g_enterprise||"' AND t2.inaml001 = pmdn001 AND t2.inaml002 = pmdn002 AND t2.inaml003 = '",g_dlang,"'",
                  "   LEFT JOIN oocal_t t3 ON t3.oocalent = '"||g_enterprise||"' AND t3.oocal001 = pmdn006 AND t3.oocal003 = '",g_dlang,"'",
                  "   LEFT JOIN oocal_t t4 ON t4.oocalent = '"||g_enterprise||"' AND t4.oocal001 = pmdn008 AND t4.oocal003 = '",g_dlang,"'",
                  "  WHERE pmdl007 = '4' ",
                  "    AND pmdl005 = '1' ",
                  "    AND pmdnent = ? AND pmdl008 = ? "
               
      IF NOT cl_null(g_wc2_table12) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table12 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdndocno,pmdnseq"                  
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb12 FROM g_sql
      DECLARE b_fill_curs12 CURSOR FOR asfq007_pb12
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs12 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs12
      USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
      INTO g_sfaa93_d[l_ac].l_pmdlstus,g_sfaa93_d[l_ac].l_pmdndocno,g_sfaa93_d[l_ac].l_pmdnseq,g_sfaa93_d[l_ac].l_pmdn001, 
          g_sfaa93_d[l_ac].l_pmdn001_desc,g_sfaa93_d[l_ac].l_pmdn001_desc_1,g_sfaa93_d[l_ac].l_pmdn002, 
          g_sfaa93_d[l_ac].l_pmdn002_desc,g_sfaa93_d[l_ac].l_pmdn006,g_sfaa93_d[l_ac].l_pmdn006_desc, 
          g_sfaa93_d[l_ac].l_pmdn007,g_sfaa93_d[l_ac].l_pmdn008,g_sfaa93_d[l_ac].l_pmdn008_desc,g_sfaa93_d[l_ac].l_pmdn009, 
          g_sfaa93_d[l_ac].l_pmdn012,g_sfaa93_d[l_ac].l_pmdn013,g_sfaa93_d[l_ac].l_pmdn014
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_apmt500")
         LET g_sfaa93_d[l_ac].prog_apmt500 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfaa93_d[l_ac].l_pmdndocno), 
             "</a>"
 
      ELSE 
         LET g_sfaa93_d[l_ac].prog_apmt500 = g_sfaa93_d[l_ac].l_pmdndocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill12"
      
      #end add-point
 
      CALL asfq007_detail_show("'12'")
 
      CALL asfq007_pmdn_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_sfaa10_d.deleteElement(g_sfaa10_d.getLength())
#Page3
   CALL g_sfaa11_d.deleteElement(g_sfaa11_d.getLength())
#Page4
   CALL g_sfaa2_d.deleteElement(g_sfaa2_d.getLength())
#Page5
   CALL g_sfaa3_d.deleteElement(g_sfaa3_d.getLength())
#Page6
   CALL g_sfaa6_d.deleteElement(g_sfaa6_d.getLength())
#Page7
   CALL g_sfaa7_d.deleteElement(g_sfaa7_d.getLength())
#Page8
   CALL g_sfaa8_d.deleteElement(g_sfaa8_d.getLength())
#Page9
   CALL g_sfaa9_d.deleteElement(g_sfaa9_d.getLength())
#Page10
   CALL g_sfaa91_d.deleteElement(g_sfaa91_d.getLength())
#Page11
   CALL g_sfaa92_d.deleteElement(g_sfaa92_d.getLength())
#Page12
   CALL g_sfaa93_d.deleteElement(g_sfaa93_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   #ming 20150827 add --------------------------------(S)  
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
     #160503-00030#9-s--mark                  
     # LET g_sql = "SELECT UNIQUE pmdnsite,pmdlstus,pmdndocno,pmdnseq, ",
     #             "              pmdn001,'','',pmdn002,'',pmdn006,'',pmdn007, ",
     #             "              pmdn012,pmdn013,pmdn014 ",
     #             "  FROM pmdn_t,pmdl_t ",                  
     #160503-00030#9-e--mark 
     #160503-00030#9-s--add                  
      LET g_sql = " SELECT UNIQUE pmdnsite,pmdlstus,pmdndocno,pmdnseq, ",
                  "               pmdn001,t1.imaal003,t1.imaal004,pmdn002, ",
                  "(SELECT inaml004 FROM inaml_t WHERE inamlent=pmdnent AND inaml001=pmdn001 AND inaml002=pmdn002 AND inaml003='"||g_dlang||"') inaml004, ",
                  "               pmdn006,t2.oocal003,pmdn007,pmdn008,t3.oocal003,pmdn009,pmdn012,pmdn013,pmdn014 ",   #160727-00025#5
                  "   FROM pmdl_t,pmdn_t ",      
                  "   LEFT JOIN imaal_t t1 ON t1.imaalent = '"||g_enterprise||"' AND t1.imaal001 = pmdn001 AND t1.imaal002 = '"||g_dlang||"' ",                                   
                  "   LEFT JOIN oocal_t t2 ON t2.oocalent = '"||g_enterprise||"' AND t2.oocal001 = pmdn006 AND t2.oocal002 = '"||g_dlang||"' ", 
                  "   LEFT JOIN oocal_t t3 ON t3.oocalent = '"||g_enterprise||"' AND t3.oocal001 = pmdn008 AND t3.oocal002 = '"||g_dlang||"' ",#160727-00025#5                  
     #160503-00030#9-e--add             
                  " WHERE pmdlent   = ? ",
                  "   AND pmdl007   = '4' ",
                  "   AND pmdl005   = '2' ",    #160727-00025#5 add
                  "   AND pmdl008   = ? ",
                  "   AND pmdlent   = pmdnent ",
                  "   AND pmdldocno = pmdndocno ",
                  " ORDER BY pmdndocno,pmdnseq "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #160727-00025#5-s  mark
#      PREPARE asfq007_pb12 FROM g_sql
#      DECLARE b_fill_curs12 CURSOR FOR asfq007_pb12
      #160727-00025#5-e  mark
      #160727-00025#5-s
      PREPARE asfq007_pb15 FROM g_sql
      DECLARE b_fill_curs15 CURSOR FOR asfq007_pb15     
      #160727-00025#5-e
   END IF
   #OPEN b_fill_curs12 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno  #160727-00025#5 mark
   OPEN b_fill_curs15 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno   #160727-00025#5 add
   LET l_ac = 1
   FOREACH b_fill_curs15 INTO g_pmdn_d[l_ac].pmdnsite,g_pmdn_d[l_ac].pmdlstus,
                              g_pmdn_d[l_ac].pmdndocno,g_pmdn_d[l_ac].pmdnseq,
                              g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn001_desc,
                              g_pmdn_d[l_ac].pmdn001_desc_1,
                              g_pmdn_d[l_ac].pmdn002,g_pmdn_d[l_ac].pmdn002_desc,
                              g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn006_desc,
                              g_pmdn_d[l_ac].pmdn007,
                              g_pmdn_d[l_ac].pmdn008,g_pmdn_d[l_ac].pmdn008_desc,g_pmdn_d[l_ac].pmdn009,  #160727-00025#5  
                              g_pmdn_d[l_ac].pmdn012,g_pmdn_d[l_ac].pmdn013,
                              g_pmdn_d[l_ac].pmdn014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #160727-00025#5-s
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_apmt501")
         LET g_pmdn_d[l_ac].prog_apmt501 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_pmdn_d[l_ac].pmdndocno), 
             "</a>"
 
      ELSE 
         LET  g_pmdn_d[l_ac].prog_apmt501 = g_pmdn_d[l_ac].pmdndocno
 
      END IF       
      #160727-00025#5-e   
      CALL asfq007_detail_show("'12'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend =  ""
         LET g_errparam.code   =  9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1

   END FOREACH

   CALL g_pmdn_d.deleteElement(g_pmdn_d.getLength())
   #ming 20150827 add --------------------------------(E)

   #160523-00055 by whitney add start
   #FQC
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = " SELECT UNIQUE qcbasite,qcbastus,qcbadocdt,qcbadocno,qcba001,qcba002,qcba017,qcbc002,'',qcbc012,qcbc009 ",
                  "   FROM qcba_t,qcbc_t ",
                  "  WHERE qcbaent=qcbcent AND qcbadocno=qcbcdocno ",
                  "    AND qcbaent=? AND qcba000='2' AND qcba003=? ",
                  "  ORDER BY qcbadocno "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb16 FROM g_sql
      DECLARE b_fill_curs16 CURSOR FOR asfq007_pb16   #160727-00025#5 b_fill_curs13=>b_fill_curs16
   END IF
 
   OPEN b_fill_curs16 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs16 INTO g_qcba1_d[l_ac].qcbasite,g_qcba1_d[l_ac].qcbastus,g_qcba1_d[l_ac].qcbadocdt,
                              g_qcba1_d[l_ac].qcbadocno,g_qcba1_d[l_ac].qcba001,g_qcba1_d[l_ac].qcba002,
                              g_qcba1_d[l_ac].qcba017,g_qcba1_d[l_ac].qcbc002,g_qcba1_d[l_ac].qcbc002_desc,
                              g_qcba1_d[l_ac].qcbc012,g_qcba1_d[l_ac].qcbc009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #160727-00025#5-s
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_aqct300")
         LET g_qcba1_d[l_ac].prog_aqct300 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_qcba1_d[l_ac].qcbadocno), 
             "</a>"
 
      ELSE 
         LET g_qcba1_d[l_ac].prog_aqct300 = g_qcba1_d[l_ac].qcbadocno
 
      END IF       
      #160727-00025#5-e
      CALL s_desc_get_qc_desc(g_qcba1_d[l_ac].qcbasite,g_qcba1_d[l_ac].qcbc002)
           RETURNING g_qcba1_d[l_ac].qcbc002_desc
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "b_fill_curs13" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   #PQC
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = " SELECT UNIQUE qcbasite,qcbastus,qcbadocdt,qcbadocno,qcba001,qcba002,qcba006, ",
                  "(SELECT oocql004 FROM oocql_t WHERE oocqlent=qcbaent AND oocql001='221' AND oocql002=qcba006 AND oocql003='"||g_dlang||"') oocql004, ",
                  "               qcba007,qcba017,qcbc002,'',qcbc012,qcbc009 ",
                  "   FROM qcba_t,qcbc_t ",
                  "  WHERE qcbaent=qcbcent AND qcbadocno=qcbcdocno ",
                  "    AND qcbaent=? AND qcba000='3' AND qcba001=? ",
                  "  ORDER BY qcbadocno "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE asfq007_pb14 FROM g_sql
      DECLARE b_fill_curs14 CURSOR FOR asfq007_pb14
   END IF
 
   OPEN b_fill_curs14 USING g_enterprise,g_sfaa_d[g_detail_idx].sfaadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs14 INTO g_qcba2_d[l_ac].qcbasite,g_qcba2_d[l_ac].qcbastus,g_qcba2_d[l_ac].qcbadocdt,
                              g_qcba2_d[l_ac].qcbadocno,g_qcba2_d[l_ac].qcba001,g_qcba2_d[l_ac].qcba002,
                              g_qcba2_d[l_ac].qcba006,g_qcba2_d[l_ac].qcba006_desc,g_qcba2_d[l_ac].qcba007,
                              g_qcba2_d[l_ac].qcba017,g_qcba2_d[l_ac].qcbc002,g_qcba2_d[l_ac].qcbc002_desc,
                              g_qcba2_d[l_ac].qcbc012,g_qcba2_d[l_ac].qcbc009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #160727-00025#5-s
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq007_get_hyper_data("prog_aqct3001")
         LET  g_qcba2_d[l_ac].prog_aqct3001 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_qcba2_d[l_ac].qcbadocno), 
             "</a>"
 
      ELSE 
         LET  g_qcba2_d[l_ac].prog_aqct3001 =  g_qcba2_d[l_ac].qcbadocno
 
      END IF       
      #160727-00025#5-e      
      CALL s_desc_get_qc_desc(g_qcba2_d[l_ac].qcbasite,g_qcba2_d[l_ac].qcbc002)
           RETURNING g_qcba2_d[l_ac].qcbc002_desc
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "b_fill_curs14" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_qcba1_d.deleteElement(g_qcba1_d.getLength())
   CALL g_qcba2_d.deleteElement(g_qcba2_d.getLength())
   #160523-00055 by whitney add end

   #end add-point
 
#Page2
   LET li_ac = g_sfaa10_d.getLength()
#Page3
   LET li_ac = g_sfaa11_d.getLength()
#Page4
   LET li_ac = g_sfaa2_d.getLength()
#Page5
   LET li_ac = g_sfaa3_d.getLength()
#Page6
   LET li_ac = g_sfaa6_d.getLength()
#Page7
   LET li_ac = g_sfaa7_d.getLength()
#Page8
   LET li_ac = g_sfaa8_d.getLength()
#Page9
   LET li_ac = g_sfaa9_d.getLength()
#Page10
   LET li_ac = g_sfaa91_d.getLength()
#Page11
   LET li_ac = g_sfaa92_d.getLength()
#Page12
   LET li_ac = g_sfaa93_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq007.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq007_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_sfaa013         LIKE sfaa_t.sfaa013
   DEFINE l_sfab007         LIKE sfab_t.sfab007
   DEFINE l_sql             STRING
   DEFINE l_xmdd001         LIKE xmdd_t.xmdd001
   DEFINE l_xmdd004         LIKE xmdd_t.xmdd004
   DEFINE l_xmdd006         LIKE xmdd_t.xmdd006
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_rate            LIKE inaj_t.inaj014
   DEFINE l_sfdc_cnt        LIKE type_t.num5
   DEFINE l_sfec_cnt        LIKE type_t.num5
   DEFINE l_pmdt_cnt        LIKE type_t.num5   #151014 Sarah add
   DEFINE l_num             LIKE type_t.num20_6
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      #工單資料頁籤
      
      #狀態
      IF g_sfaa_d[l_ac].sfaastus = 'F' THEN
         LET l_sfdc_cnt = 0
         SELECT COUNT(*) INTO l_sfdc_cnt
           FROM sfdc_t
          WHERE sfdcent = g_enterprise
            AND sfdc001 = g_sfaa_d[l_ac].sfaadocno
            
         LET l_sfec_cnt = 0
         SELECT COUNT(*) INTO l_sfec_cnt
           FROM sfec_t
          WHERE sfecent = g_enterprise
            AND sfec001 = g_sfaa_d[l_ac].sfaadocno
        #15/10/14 Sarah add -----(S)
         #委外採購入庫
         LET l_pmdt_cnt = 0
         SELECT COUNT(*) INTO l_pmdt_cnt
           FROM pmdt_t
          WHERE pmdtent= g_enterprise
            AND pmdt001=(SELECT pmdldocno FROM pmdl_t
                          WHERE pmdlent = g_enterprise
                            AND pmdl008 = g_sfaa_d[l_ac].sfaadocno)
         LET l_sfec_cnt = l_sfec_cnt + l_pmdt_cnt
        #15/10/14 Sarah add -----(E)
        
         LET l_num = 0
         SELECT SUM(CASE
                    WHEN COALESCE(sfba013,0) - COALESCE(sfba015,0) - COALESCE(sfba016,0) < 0
                      THEN 0
                    ELSE
                      COALESCE(sfba013,0) - COALESCE(sfba015,0) - COALESCE(sfba016,0)
                 END)
           INTO l_num
           FROM sfba_t
          WHERE sfbaent = g_enterprise
            AND sfbadocno = g_sfaa_d[g_detail_idx].sfaadocno
         CASE
            #發放：無發料單、入庫單
            WHEN l_sfdc_cnt = 0 AND l_sfec_cnt = 0
               LET g_sfaa_d[l_ac].stus = 'F'
            
            #部分發料：有發料單 AND 備料有欠料
            WHEN l_sfdc_cnt >= 1 AND l_num >= 1
               LET g_sfaa_d[l_ac].stus = 'PF'
               
            #全部發料：有發料單 AND 備料無欠料 AND 無入庫單
           #WHEN l_sfdc_cnt >= 1 AND l_num = 0                      #151014 Sarah mark
            WHEN l_sfdc_cnt >= 1 AND l_num = 0 AND l_sfec_cnt = 0   #151014 Sarah mod
               LET g_sfaa_d[l_ac].stus = 'AF'
               
            #部分入庫：有入庫單 AND 入庫數量 < 生產數量
            WHEN l_sfec_cnt >= 1 AND
                 (g_sfaa_d[l_ac].sfaa050 + g_sfaa_d[l_ac].sfaa051) < g_sfaa_d[l_ac].sfaa012
               LET g_sfaa_d[l_ac].stus = 'PS'
            #全部入庫：有入庫單 AND 入庫數量 >= 生產數量
            WHEN l_sfec_cnt >= 1 AND
                 (g_sfaa_d[l_ac].sfaa050 + g_sfaa_d[l_ac].sfaa051) >= g_sfaa_d[l_ac].sfaa012
               LET g_sfaa_d[l_ac].stus = 'AS'
         END CASE
      ELSE
         LET g_sfaa_d[l_ac].stus = g_sfaa_d[l_ac].sfaastus
      END IF
#160503-00030#9-s--mark
#      #品名 規格
#      CALL s_desc_get_item_desc(g_sfaa_d[l_ac].sfaa010)
#         RETURNING g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_1
#      
#      #生管人員
#      CALL s_desc_get_person_desc(g_sfaa_d[l_ac].sfaa002)
#         RETURNING g_sfaa_d[l_ac].sfaa002_desc
#      
#      #150907 Sarah add ----- (S)
#      #成本中心
#      CALL s_desc_get_department_desc(g_sfaa_d[l_ac].sfaa068)
#         RETURNING g_sfaa_d[l_ac].sfaa068_desc
#      #150907 Sarah add ----- (E)
#160503-00030#9-e--mark
#160425-00019 by whitney mark start
#      #齊料套數
#      CALL s_asft340_full_sets(g_sfaa_d[l_ac].sfaadocno,'','','')
#         RETURNING l_success,g_sfaa_d[l_ac].fullsets
#      DISPLAY BY NAME g_sfaa_d[l_ac].sfaa010_desc,g_sfaa_d[l_ac].sfaa010_desc_1,
#                      g_sfaa_d[l_ac].sfaa002_desc,g_sfaa_d[l_ac].sfaa068_desc,   #150907 Sarah add sfaa068_desc
#                      g_sfaa_d[l_ac].progress,g_sfaa_d[l_ac].stus,
#                      g_sfaa_d[l_ac].fullsets
#160425-00019 by whitney mark end

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body10.reference"
      #Run Card頁籤
      #預計開工日
      LET g_sfaa10_d[l_ac].sfaa019 = g_sfaa_d[g_detail_idx].sfaa019
      
      #預計完工日
      LET g_sfaa10_d[l_ac].sfaa020 = g_sfaa_d[g_detail_idx].sfaa020
      
      #在制量
      LET g_sfaa10_d[l_ac].num = g_sfaa10_d[l_ac].sfca003 - g_sfaa10_d[l_ac].sfca004
      
      DISPLAY BY NAME g_sfaa10_d[l_ac].num
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body11.reference"
      #報工頁籤
#160503-00030#9-s--mark
#      #作業編號
#      CALL s_desc_get_acc_desc('221',g_sfaa11_d[l_ac].sffb007)
#         RETURNING g_sfaa11_d[l_ac].sffb007_desc
#      
#      #工作站
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_sfaa11_d[l_ac].sffb009
#      LET ls_sql = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaa001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_sfaa11_d[l_ac].sffb009_desc = '', g_rtn_fields[1] , ''
#      
#      DISPLAY BY NAME g_sfaa11_d[l_ac].sffb007_desc,g_sfaa11_d[l_ac].sffb009_desc
#160503-00030#9-e--mark
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      #工單來源頁籤
       
     IF g_sfaa2_d[l_ac].sfab001 = '2' THEN
        
         IF NOT cl_null(g_sfaa2_d[l_ac].sfab002) AND NOT cl_null(g_sfaa2_d[l_ac].sfab003) AND
            NOT cl_null(g_sfaa2_d[l_ac].sfab004) AND NOT cl_null(g_sfaa2_d[l_ac].sfab005) THEN
#160503-00030#9-s--mark
#            SELECT xmda004,xmda003,xmda002,xmdd001,xmdd004,xmdd006
#              INTO g_sfaa2_d[l_ac].a6,g_sfaa2_d[l_ac].a7,g_sfaa2_d[l_ac].a8,
#                   l_xmdd001,l_xmdd004,l_xmdd006
#              FROM xmda_t,xmdd_t
#             WHERE xmdaent = xmddent
#               AND xmdadocno = xmdddocno
#               AND xmddent = g_enterprise
#               AND xmddsite = g_site
#               --AND xmdd001 = g_sfaa_d[g_detail_idx].sfaa010
#               AND xmdddocno = g_sfaa2_d[l_ac].sfab002
#               AND xmddseq = g_sfaa2_d[l_ac].sfab003
#               AND xmddseq1 = g_sfaa2_d[l_ac].sfab004
#               AND xmddseq2 = g_sfaa2_d[l_ac].sfab005
#      	   
#            LET g_sfaa2_d[l_ac].a1 = l_xmdd006
#            LET g_sfaa2_d[l_ac].a2 = l_xmdd004
#            LET g_sfaa2_d[l_ac].a4 = g_sfaa_d[g_detail_idx].sfaa013
##            CALL s_aimi190_get_convert(l_xmdd001,g_sfaa2_d[l_ac].a2,g_sfaa2_d[l_ac].a4)
##               RETURNING l_success,l_rate   #xj mod
#            CALL s_aooi250_convert_qty(l_xmdd001,g_sfaa2_d[l_ac].a2,g_sfaa2_d[l_ac].a4,g_sfaa2_d[l_ac].a1) 
#               RETURNING l_success,g_sfaa2_d[l_ac].a3
##            IF l_success THEN
##               LET g_sfaa2_d[l_ac].a3 = g_sfaa2_d[l_ac].a1 * l_rate
##            END IF   #xj mod
#            
#            #已開工單數量
#            LET l_sql = "SELECT sfaa013,sfab007",
#                        "  FROM sfaa_t,sfab_t",
#                        " WHERE sfaaent = sfabent",
#                        "   AND sfaadocno = sfabdocno",
#                        "   AND sfaaent = ",g_enterprise,
#                        "   AND sfaasite = '",g_site,"'",
#                        "   AND sfaa010 = '",g_sfaa_d[g_detail_idx].sfaa010,"'",
#                        "   AND sfaastus != 'X'",
#                        "   AND sfab002 = '",g_sfaa2_d[l_ac].sfab002,"'",
#                        "   AND sfab003 = ",g_sfaa2_d[l_ac].sfab003,
#                        "   AND sfab004 = ",g_sfaa2_d[l_ac].sfab004,
#                        "   AND sfab005 = ",g_sfaa2_d[l_ac].sfab005
#            PREPARE asfq007_pre FROM l_sql
#            DECLARE asft300_cs CURSOR FOR asfq007_pre
#            LET g_sfaa2_d[l_ac].a5 = 0
#            FOREACH asft300_cs INTO l_sfaa013,l_sfab007
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "Foreach:"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  EXIT FOREACH
#               END IF
#      	   
##               CALL s_aimi190_get_convert(g_sfaa_d[g_detail_idx].sfaa010,l_sfaa013,g_sfaa2_d[l_ac].a4)
##                  RETURNING l_success,l_rate  #xj mod
#               CALL s_aooi250_convert_qty(g_sfaa_d[g_detail_idx].sfaa010,l_sfaa013,g_sfaa2_d[l_ac].a4,l_sfab007) 
#                  RETURNING l_success,l_sfab007
##               IF l_success THEN
##                  LET l_sfab007 = l_sfab007 * l_rate
##               END IF   #xj mod
#               LET g_sfaa2_d[l_ac].a5 = g_sfaa2_d[l_ac].a5 + l_sfab007
#            END FOREACH
#160503-00030#9-e--mark
            #業務人員
            CALL s_desc_get_person_desc(g_sfaa2_d[l_ac].a8)
               RETURNING g_sfaa2_d[l_ac].a8_desc
      
            #部門
            CALL s_desc_get_department_desc(g_sfaa2_d[l_ac].a7)
               RETURNING g_sfaa2_d[l_ac].a7_desc
      
            #客戶編號
            CALL s_desc_get_trading_partner_abbr_desc(g_sfaa2_d[l_ac].a6)
               RETURNING g_sfaa2_d[l_ac].a6_desc
      	   
      	   DISPLAY BY NAME g_sfaa2_d[l_ac].a1,g_sfaa2_d[l_ac].a2,g_sfaa2_d[l_ac].a3,
      	                   g_sfaa2_d[l_ac].a4,g_sfaa2_d[l_ac].a5,g_sfaa2_d[l_ac].a6,
      	                   g_sfaa2_d[l_ac].a7,g_sfaa2_d[l_ac].a8,g_sfaa2_d[l_ac].a6_desc,
      	                   g_sfaa2_d[l_ac].a7_desc,g_sfaa2_d[l_ac].a8_desc
         END IF
      END IF   
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      #多產出主件頁籤
#160503-00030#9-s--mark
#      #品名規格
#      CALL s_desc_get_item_desc(g_sfaa3_d[l_ac].sfac001)
#         RETURNING g_sfaa3_d[l_ac].sfac001_desc,g_sfaa3_d[l_ac].sfac001_desc_1
#      
#      #生產單位說明
#      CALL s_desc_get_unit_desc(g_sfaa3_d[l_ac].sfac004)
#         RETURNING g_sfaa3_d[l_ac].sfac004_desc
#      
#      DISPLAY BY NAME g_sfaa3_d[l_ac].sfac001_desc,g_sfaa3_d[l_ac].sfac001_desc_1,
#                      g_sfaa3_d[l_ac].sfac004_desc
#      #ming 20141016 add -------------------------------(S) 
#      #取得產品特徵說明 
#      CALL s_feature_description(g_sfaa3_d[l_ac].sfac001,g_sfaa3_d[l_ac].sfac006)
#           RETURNING l_success,g_sfaa3_d[l_ac].sfac006_desc 
#      DISPLAY BY NAME g_sfaa3_d[l_ac].sfac006_desc 
#      #ming 20141016 add -------------------------------(E)
#160503-00030#9-e--mark
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #帶出公用欄位reference值page6
      
 
      #add-point:show段單身reference name="detail_show.body6.reference"
      #產品序號頁籤
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'7'",1) > 0 THEN
      #帶出公用欄位reference值page7
      
 
      #add-point:show段單身reference name="detail_show.body7.reference"
      #備料資訊
#160503-00030#9-s--mark
#      #發料料號 品名規格
#      CALL s_desc_get_item_desc(g_sfaa7_d[l_ac].sfba006)
#         RETURNING g_sfaa7_d[l_ac].sfba006_desc,g_sfaa7_d[l_ac].sfba006_desc_1
#160503-00030#9-e--mark
      #替代建議碼
      CALL s_abmm201_get_proposal(g_site,g_sfaa_d[g_detail_idx].sfaa010,
                                  g_sfaa_d[g_detail_idx].sfaa011,
                                  g_sfaa7_d[l_ac].sfba005,g_sfaa7_d[l_ac].sfba002,
                                  g_sfaa7_d[l_ac].sfba003,g_sfaa7_d[l_ac].sfba004)
         RETURNING g_sfaa7_d[l_ac].replace
#160503-00030#9-s--mark
#      #BOM料號 品名規格
#      CALL s_desc_get_item_desc(g_sfaa7_d[l_ac].sfba005)
#         RETURNING g_sfaa7_d[l_ac].sfba005_desc,g_sfaa7_d[l_ac].sfba005_desc_1
#      
#      #作業編號
#      CALL s_desc_get_acc_desc('221',g_sfaa7_d[l_ac].sfba003)
#         RETURNING g_sfaa7_d[l_ac].sfba003_desc
#160503-00030#9-e--mark
      #未發數量
      LET g_sfaa7_d[l_ac].num1 = g_sfaa7_d[l_ac].sfba013 - g_sfaa7_d[l_ac].sfba015 - g_sfaa7_d[l_ac].sfba016
      IF g_sfaa7_d[l_ac].num1 < 0 THEN
         LET g_sfaa7_d[l_ac].num1 = 0
      END IF
      
      #未足套數量
      IF NOT cl_null(g_sfaa_d[g_detail_idx].sfaadocno) AND
         NOT cl_null(g_sfaa7_d[l_ac].sfbaseq) AND
         NOT cl_null(g_sfaa7_d[l_ac].sfbaseq1) THEN
         CALL s_asft300_07(g_sfaa_d[g_detail_idx].sfaadocno,
                           g_sfaa7_d[l_ac].sfbaseq,
                           g_sfaa7_d[l_ac].sfbaseq1)
            RETURNING l_success,g_sfaa7_d[l_ac].num2
      END IF
#160503-00030#9-s--mark
#      #庫位
#      CALL s_desc_get_stock_desc('',g_sfaa7_d[l_ac].sfba019)
#         RETURNING g_sfaa7_d[l_ac].sfba019_desc
#      
#      #儲位
#      CALL s_desc_get_locator_desc(g_sfaa7_d[l_ac].sfbasite,g_sfaa7_d[l_ac].sfba019,g_sfaa7_d[l_ac].sfba020)
#         RETURNING g_sfaa7_d[l_ac].sfba020_desc
#      DISPLAY BY NAME g_sfaa7_d[l_ac].sfba006_desc,g_sfaa7_d[l_ac].sfba006_desc_1,
#                      g_sfaa7_d[l_ac].sfba005_desc,g_sfaa7_d[l_ac].sfba005_desc_1,
#                      g_sfaa7_d[l_ac].sfba003_desc,g_sfaa7_d[l_ac].sfba019_desc,
#                      g_sfaa7_d[l_ac].sfba020_desc,g_sfaa7_d[l_ac].replace,
#                      g_sfaa7_d[l_ac].num1,g_sfaa7_d[l_ac].num2 
#                      
#      #ming 20141016 add ---------------------------------(S) 
#      #取得產品特徵說明 
#      CALL s_feature_description(g_sfaa7_d[l_ac].sfba006,g_sfaa7_d[l_ac].sfba021)
#           RETURNING l_success,g_sfaa7_d[l_ac].sfba021_desc
#      DISPLAY BY NAME g_sfaa7_d[l_ac].sfba021_desc
#      #ming 20141016 add ---------------------------------(E)
#160503-00030#9-e--mark
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'8'",1) > 0 THEN
      #帶出公用欄位reference值page8
      
 
      #add-point:show段單身reference name="detail_show.body8.reference"
      #發料頁籤
      #ming 20141219 modify ---------------------------------------(S) 
      #EXECUTE asfq007_sfda USING g_sfaa8_d[l_ac].sfdcdocno
      #   INTO g_sfaa8_d[l_ac].sfda001,g_sfaa8_d[l_ac].sfda002
      EXECUTE asfq007_sfda USING g_sfaa8_d[l_ac].sfdcdocno
         INTO g_sfaa8_d[l_ac].sfda001,g_sfaa8_d[l_ac].sfda002,g_sfaa8_d[l_ac].sfdastus
      #ming 20141219 modify ---------------------------------------(E) 
#160503-00030#9-s--mark   
#      #發料庫位
#      CALL s_desc_get_stock_desc('',g_sfaa8_d[l_ac].sfdc012)
#         RETURNING g_sfaa8_d[l_ac].sfdc012_desc
#      
#      #發料儲位
#      CALL s_desc_get_locator_desc(g_sfaa8_d[l_ac].sfdcsite,g_sfaa8_d[l_ac].sfdc012,g_sfaa8_d[l_ac].sfdc013)
#         RETURNING g_sfaa8_d[l_ac].sfdc013_desc
#         
#      #單位
#      CALL s_desc_get_unit_desc(g_sfaa8_d[l_ac].sfdc006)
#         RETURNING g_sfaa8_d[l_ac].sfdc006_desc
#      
#      DISPLAY BY NAME g_sfaa8_d[l_ac].sfda001,g_sfaa8_d[l_ac].sfda002,
#                      g_sfaa8_d[l_ac].sfdc012_desc,g_sfaa8_d[l_ac].sfdc013_desc,
#                      g_sfaa8_d[l_ac].sfdc006_desc 
#     #ming 20141016 add ----------------------------------(S) 
#      #取得產品特徵說明 
#      CALL s_feature_description(g_sfaa8_d[l_ac].sfdc004,g_sfaa8_d[l_ac].sfdc005)
#           RETURNING l_success,g_sfaa8_d[l_ac].sfdc005_desc
#      DISPLAY BY NAME g_sfaa8_d[l_ac].sfdc005_desc
#      #ming 20141016 add ----------------------------------(E)
#160503-00030#9-e--mark        
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'9'",1) > 0 THEN
      #帶出公用欄位reference值page9
      
 
      #add-point:show段單身reference name="detail_show.body9.reference"
      #入庫頁籤
      
      #ming 20141219 modify ---------------------------------------(S) 
      #EXECUTE asfq007_sfea USING g_sfaa9_d[l_ac].sfecdocno
      #   INTO g_sfaa9_d[l_ac].sfea001
      EXECUTE asfq007_sfea USING g_sfaa9_d[l_ac].sfecdocno
         INTO g_sfaa9_d[l_ac].sfea001,g_sfaa9_d[l_ac].sfeastus
      #ming 20141219 modify ---------------------------------------(E) 
      
      #ming 20150827 add -----------------------(S) 
      IF cl_null(g_sfaa9_d[l_ac].sfea001) AND cl_null(g_sfaa9_d[l_ac].sfeastus) THEN
         EXECUTE asfq007_pmds USING g_sfaa9_d[l_ac].sfecdocno
            INTO g_sfaa9_d[l_ac].sfea001,g_sfaa9_d[l_ac].sfeastus
      END IF
      #ming 20150827 add -----------------------(E) 
         
      #FQC
      EXECUTE asfq007_sfeb USING g_sfaa9_d[l_ac].sfecdocno,g_sfaa9_d[l_ac].sfecseq
         INTO g_sfaa9_d[l_ac].sfeb002
      
      #判定結果
      EXECUTE asfq007_qcbc USING g_sfaa9_d[l_ac].sfec002,g_sfaa9_d[l_ac].sfec003
         INTO g_sfaa9_d[l_ac].qcbc002
      
      #判定結果說明
      CALL s_desc_get_qc_desc(g_sfaa9_d[l_ac].sfecsite,g_sfaa9_d[l_ac].qcbc002)
         RETURNING g_sfaa9_d[l_ac].qcbc002_desc
#160503-00030#9-s--mark      
#      #入庫料號 品名 規格
#      CALL s_desc_get_item_desc(g_sfaa9_d[l_ac].sfec005)
#         RETURNING g_sfaa9_d[l_ac].sfec005_desc,g_sfaa9_d[l_ac].sfec005_desc_1
#      
#      #入庫庫位
#      CALL s_desc_get_stock_desc('',g_sfaa9_d[l_ac].sfec012)
#         RETURNING g_sfaa9_d[l_ac].sfec012_desc
#      
#      #入庫儲位
#      CALL s_desc_get_locator_desc(g_sfaa9_d[l_ac].sfecsite,g_sfaa9_d[l_ac].sfec012,g_sfaa9_d[l_ac].sfec013)
#         RETURNING g_sfaa9_d[l_ac].sfec013_desc
#      
#      #入庫單位
#      CALL s_desc_get_unit_desc(g_sfaa9_d[l_ac].sfec008)
#         RETURNING g_sfaa9_d[l_ac].sfec008_desc
#      DISPLAY BY NAME g_sfaa9_d[l_ac].sfea001,g_sfaa9_d[l_ac].sfeb002,
#                      g_sfaa9_d[l_ac].qcbc002,g_sfaa9_d[l_ac].qcbc002_desc,
#                      g_sfaa9_d[l_ac].sfec005_desc,g_sfaa9_d[l_ac].sfec005_desc_1,
#                      g_sfaa9_d[l_ac].sfec012_desc,g_sfaa9_d[l_ac].sfec013_desc,
#                      g_sfaa9_d[l_ac].sfec008_desc
#160503-00030#9-s--mark
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'10'",1) > 0 THEN
      #帶出公用欄位reference值page10
      
 
      #add-point:show段單身reference name="detail_show.body91.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfaa91_d[l_ac].sfcb003
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_sfaa91_d[l_ac].sfcb003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfaa91_d[l_ac].sfcb003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfaa91_d[l_ac].sfcb011
#            LET g_ref_fields[2] = g_site   #160727-00025#5
#            LET ls_sql = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaa001=?  AND ecaasite = ?"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_sfaa91_d[l_ac].sfcb004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfaa91_d[l_ac].sfcb004_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'11'",1) > 0 THEN
      #帶出公用欄位reference值page11
      
 
      #add-point:show段單身reference name="detail_show.body92.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa92_d[l_ac].pmda002
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa92_d[l_ac].pmda002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa92_d[l_ac].pmda002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa92_d[l_ac].pmda003
            LET ls_sql = "SELECT ooefl004 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa92_d[l_ac].pmda003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa92_d[l_ac].pmda003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa92_d[l_ac].pmdb004
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa92_d[l_ac].pmdb004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa92_d[l_ac].pmdb004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa92_d[l_ac].pmdb007
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa92_d[l_ac].pmdb007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa92_d[l_ac].pmdb007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfaa92_d[l_ac].pmdb009
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfaa92_d[l_ac].pmdb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfaa92_d[l_ac].pmdb009_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'12'",1) > 0 THEN
      #帶出公用欄位reference值page12
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body93.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
#160503-00030#9-s--mark
#   #ming 20150827 add ------------------------------(S)  
#   IF ps_page.getIndexOf("'12'",1) > 0 THEN
#      CALL s_desc_get_item_desc(g_pmdn_d[l_ac].pmdn001)
#         RETURNING g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_1
#      DISPLAY BY NAME g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn001_desc_1
#      #取得產品特徵說明 
#      CALL s_feature_description(g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn002)
#           RETURNING l_success,g_pmdn_d[l_ac].pmdn002_desc
#      DISPLAY BY NAME g_pmdn_d[l_ac].pmdn002_desc
#      CALL s_desc_get_unit_desc(g_pmdn_d[l_ac].pmdn006)
#         RETURNING g_pmdn_d[l_ac].pmdn006_desc
#      DISPLAY BY NAME g_pmdn_d[l_ac].pmdn006_desc
#   END IF
#   #ming 20150827 add ------------------------------(E)
#160503-00030#9-e--mark
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq007.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq007_filter()
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_asft301', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_sfca001', FALSE) 
   CALL gfrm_curr.setFieldHidden('prog_asft335', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sffbdocno', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_asft310', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sfdcdocno', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_asft340', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sfecdocno', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_asft3011', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sfcb001', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_apmt400', TRUE)
   CALL gfrm_curr.setFieldHidden('b_pmdadocno', FALSE)
   CALL gfrm_curr.setFieldHidden('prog_apmt500', TRUE)
   CALL gfrm_curr.setFieldHidden('l_pmdndocno', FALSE)
 
  
 
 
 
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON sfaadocno,sfaadocdt,sfaa003,sfaa010,sfaa019,sfaa020,sfaa002,sfaa068,sfaa012, 
          sfaa049,sfaa050,sfaa051,sfaa021,sfaa025,sfaa013,sfaa046,sfaastus,sfaa011
                          FROM s_detail1[1].b_sfaadocno,s_detail1[1].b_sfaadocdt,s_detail1[1].b_sfaa003, 
                              s_detail1[1].b_sfaa010,s_detail1[1].b_sfaa019,s_detail1[1].b_sfaa020,s_detail1[1].b_sfaa002, 
                              s_detail1[1].b_sfaa068,s_detail1[1].b_sfaa012,s_detail1[1].b_sfaa049,s_detail1[1].b_sfaa050, 
                              s_detail1[1].b_sfaa051,s_detail1[1].b_sfaa021,s_detail1[1].b_sfaa025,s_detail1[1].b_sfaa013, 
                              s_detail1[1].b_sfaa046,s_detail1[1].b_sfaastus,s_detail1[1].b_sfaa011
 
         BEFORE CONSTRUCT
                     DISPLAY asfq007_filter_parser('sfaadocno') TO s_detail1[1].b_sfaadocno
            DISPLAY asfq007_filter_parser('sfaadocdt') TO s_detail1[1].b_sfaadocdt
            DISPLAY asfq007_filter_parser('sfaa003') TO s_detail1[1].b_sfaa003
            DISPLAY asfq007_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY asfq007_filter_parser('sfaa019') TO s_detail1[1].b_sfaa019
            DISPLAY asfq007_filter_parser('sfaa020') TO s_detail1[1].b_sfaa020
            DISPLAY asfq007_filter_parser('sfaa002') TO s_detail1[1].b_sfaa002
            DISPLAY asfq007_filter_parser('sfaa068') TO s_detail1[1].b_sfaa068
            DISPLAY asfq007_filter_parser('sfaa012') TO s_detail1[1].b_sfaa012
            DISPLAY asfq007_filter_parser('sfaa049') TO s_detail1[1].b_sfaa049
            DISPLAY asfq007_filter_parser('sfaa050') TO s_detail1[1].b_sfaa050
            DISPLAY asfq007_filter_parser('sfaa051') TO s_detail1[1].b_sfaa051
            DISPLAY asfq007_filter_parser('sfaa021') TO s_detail1[1].b_sfaa021
            DISPLAY asfq007_filter_parser('sfaa025') TO s_detail1[1].b_sfaa025
            DISPLAY asfq007_filter_parser('sfaa013') TO s_detail1[1].b_sfaa013
            DISPLAY asfq007_filter_parser('sfaa046') TO s_detail1[1].b_sfaa046
            DISPLAY asfq007_filter_parser('sfaastus') TO s_detail1[1].b_sfaastus
            DISPLAY asfq007_filter_parser('sfaa011') TO s_detail1[1].b_sfaa011
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<progress>>----
         #----<<stus>>----
         #Ctrlp:construct.c.filter.page1.stus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stus
            #add-point:ON ACTION controlp INFIELD stus name="construct.c.filter.page1.stus"
            
            #END add-point
 
 
         #----<<b_sfaadocno>>----
         #Ctrlp:construct.c.page1.b_sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocno
            #add-point:ON ACTION controlp INFIELD b_sfaadocno name="construct.c.filter.page1.b_sfaadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaadocno  #顯示到畫面上
            NEXT FIELD b_sfaadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaadocdt
            #add-point:ON ACTION controlp INFIELD b_sfaadocdt name="construct.c.filter.page1.b_sfaadocdt"
            
            #END add-point
 
 
         #----<<b_sfaa003>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa003
            #add-point:ON ACTION controlp INFIELD b_sfaa003 name="construct.c.filter.page1.b_sfaa003"
            
            #END add-point
 
 
         #----<<b_sfaa010>>----
         #Ctrlp:construct.c.page1.b_sfaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa010
            #add-point:ON ACTION controlp INFIELD b_sfaa010 name="construct.c.filter.page1.b_sfaa010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa010  #顯示到畫面上
            NEXT FIELD b_sfaa010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa010_desc>>----
         #----<<b_sfaa010_desc_1>>----
         #----<<b_sfaa019>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa019
            #add-point:ON ACTION controlp INFIELD b_sfaa019 name="construct.c.filter.page1.b_sfaa019"
            
            #END add-point
 
 
         #----<<b_sfaa020>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa020
            #add-point:ON ACTION controlp INFIELD b_sfaa020 name="construct.c.filter.page1.b_sfaa020"
            
            #END add-point
 
 
         #----<<b_sfaa002>>----
         #Ctrlp:construct.c.page1.b_sfaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa002
            #add-point:ON ACTION controlp INFIELD b_sfaa002 name="construct.c.filter.page1.b_sfaa002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa002  #顯示到畫面上
            NEXT FIELD b_sfaa002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa002_desc>>----
         #----<<b_sfaa068>>----
         #Ctrlp:construct.c.page1.b_sfaa068
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa068
            #add-point:ON ACTION controlp INFIELD b_sfaa068 name="construct.c.filter.page1.b_sfaa068"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfaa068  #顯示到畫面上
            NEXT FIELD b_sfaa068                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfaa068_desc>>----
         #----<<b_sfaa012>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa012
            #add-point:ON ACTION controlp INFIELD b_sfaa012 name="construct.c.filter.page1.b_sfaa012"
            
            #END add-point
 
 
         #----<<b_sfaa049>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa049
            #add-point:ON ACTION controlp INFIELD b_sfaa049 name="construct.c.filter.page1.b_sfaa049"
            
            #END add-point
 
 
         #----<<fullsets>>----
         #----<<b_sfaa050>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa050
            #add-point:ON ACTION controlp INFIELD b_sfaa050 name="construct.c.filter.page1.b_sfaa050"
            
            #END add-point
 
 
         #----<<b_sfaa051>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa051
            #add-point:ON ACTION controlp INFIELD b_sfaa051 name="construct.c.filter.page1.b_sfaa051"
            
            #END add-point
 
 
         #----<<b_sfaa021>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa021
            #add-point:ON ACTION controlp INFIELD b_sfaa021 name="construct.c.filter.page1.b_sfaa021"
            
            #END add-point
 
 
         #----<<b_sfaa025>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa025
            #add-point:ON ACTION controlp INFIELD b_sfaa025 name="construct.c.filter.page1.b_sfaa025"
            
            #END add-point
 
 
         #----<<b_sfaa013>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa013
            #add-point:ON ACTION controlp INFIELD b_sfaa013 name="construct.c.filter.page1.b_sfaa013"
            
            #END add-point
 
 
         #----<<b_sfaa046>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa046
            #add-point:ON ACTION controlp INFIELD b_sfaa046 name="construct.c.filter.page1.b_sfaa046"
            
            #END add-point
 
 
         #----<<b_sfaastus>>----
         #Ctrlp:construct.c.filter.page1.b_sfaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaastus
            #add-point:ON ACTION controlp INFIELD b_sfaastus name="construct.c.filter.page1.b_sfaastus"
            
            #END add-point
 
 
         #----<<b_sfaa011>>----
         #Ctrlp:construct.c.filter.page1.b_sfaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfaa011
            #add-point:ON ACTION controlp INFIELD b_sfaa011 name="construct.c.filter.page1.b_sfaa011"
            
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
 
 
 
 
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfca001', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_asft301', FALSE) 
   CALL gfrm_curr.setFieldHidden('b_sffbdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft335', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfdcdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft310', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfecdocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft340', FALSE)
   CALL gfrm_curr.setFieldHidden('b_sfcb001', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft3011', FALSE)
   CALL gfrm_curr.setFieldHidden('b_pmdadocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_apmt400', FALSE)
   CALL gfrm_curr.setFieldHidden('l_pmdndocno', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_apmt500', FALSE)
 
  
 
 
 
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL asfq007_filter_show('sfaadocno','b_sfaadocno')
   CALL asfq007_filter_show('sfaadocdt','b_sfaadocdt')
   CALL asfq007_filter_show('sfaa003','b_sfaa003')
   CALL asfq007_filter_show('sfaa010','b_sfaa010')
   CALL asfq007_filter_show('sfaa019','b_sfaa019')
   CALL asfq007_filter_show('sfaa020','b_sfaa020')
   CALL asfq007_filter_show('sfaa002','b_sfaa002')
   CALL asfq007_filter_show('sfaa068','b_sfaa068')
   CALL asfq007_filter_show('sfaa012','b_sfaa012')
   CALL asfq007_filter_show('sfaa049','b_sfaa049')
   CALL asfq007_filter_show('sfaa050','b_sfaa050')
   CALL asfq007_filter_show('sfaa051','b_sfaa051')
   CALL asfq007_filter_show('sfaa021','b_sfaa021')
   CALL asfq007_filter_show('sfaa025','b_sfaa025')
   CALL asfq007_filter_show('sfaa013','b_sfaa013')
   CALL asfq007_filter_show('sfaa046','b_sfaa046')
   CALL asfq007_filter_show('sfaastus','b_sfaastus')
   CALL asfq007_filter_show('sfaa011','b_sfaa011')
   CALL asfq007_filter_show('sffbstus','b_sffbstus')
   CALL asfq007_filter_show('sffb029','b_sffb029')
   CALL asfq007_filter_show('sffb020','b_sffb020')
   CALL asfq007_filter_show('sfabseq','b_sfabseq')
   CALL asfq007_filter_show('sfab001','b_sfab001')
   CALL asfq007_filter_show('sfab002','b_sfab002')
   CALL asfq007_filter_show('sfab003','b_sfab003')
   CALL asfq007_filter_show('sfab004','b_sfab004')
   CALL asfq007_filter_show('sfab005','b_sfab005')
   CALL asfq007_filter_show('sfab006','b_sfab006')
   CALL asfq007_filter_show('sfab007','b_sfab007')
   CALL asfq007_filter_show('sfacseq','b_sfacseq')
   CALL asfq007_filter_show('sfac002','b_sfac002')
   CALL asfq007_filter_show('sfac001','b_sfac001')
   CALL asfq007_filter_show('sfac006','b_sfac006')
   CALL asfq007_filter_show('sfac003','b_sfac003')
   CALL asfq007_filter_show('sfac004','b_sfac004')
   CALL asfq007_filter_show('sfac005','b_sfac005')
   CALL asfq007_filter_show('sfafseq','b_sfafseq')
   CALL asfq007_filter_show('sfaf001','b_sfaf001')
   CALL asfq007_filter_show('sfdc016','b_sfdc016')
   CALL asfq007_filter_show('sfdc009','b_sfdc009')
   CALL asfq007_filter_show('sfdc011','b_sfdc011')
   CALL asfq007_filter_show('sfec006','b_sfec006')
   CALL asfq007_filter_show('sfec010','b_sfec010')
   CALL asfq007_filter_show('sfec011','b_sfec011')
   CALL asfq007_filter_show('sfec028','b_sfec028')
   CALL asfq007_filter_show('sfcb001','b_sfcb001')
   CALL asfq007_filter_show('sfcb002','b_sfcb002')
   CALL asfq007_filter_show('sfcb003','b_sfcb003')
   CALL asfq007_filter_show('sfcb004','b_sfcb004')
   CALL asfq007_filter_show('sfcb011','b_sfcb011')
   CALL asfq007_filter_show('sfcb027','b_sfcb027')
   CALL asfq007_filter_show('sfcb050','b_sfcb050')
   CALL asfq007_filter_show('sfcb028','b_sfcb028')
   CALL asfq007_filter_show('sfcb029','b_sfcb029')
   CALL asfq007_filter_show('sfcb030','b_sfcb030')
   CALL asfq007_filter_show('sfcb031','b_sfcb031')
   CALL asfq007_filter_show('sfcb032','b_sfcb032')
   CALL asfq007_filter_show('sfcb033','b_sfcb033')
   CALL asfq007_filter_show('sfcb034','b_sfcb034')
   CALL asfq007_filter_show('sfcb035','b_sfcb035')
   CALL asfq007_filter_show('sfcb036','b_sfcb036')
   CALL asfq007_filter_show('sfcb037','b_sfcb037')
   CALL asfq007_filter_show('sfcb038','b_sfcb038')
   CALL asfq007_filter_show('sfcb039','b_sfcb039')
   CALL asfq007_filter_show('sfcb041','b_sfcb041')
   CALL asfq007_filter_show('sfcb042','b_sfcb042')
   CALL asfq007_filter_show('sfcb043','b_sfcb043')
   CALL asfq007_filter_show('sfcb046','b_sfcb046')
   CALL asfq007_filter_show('sfcb047','b_sfcb047')
   CALL asfq007_filter_show('sfcb048','b_sfcb048')
   CALL asfq007_filter_show('sfcb049','b_sfcb049')
   CALL asfq007_filter_show('sfcb051','b_sfcb051')
   CALL asfq007_filter_show('pmdastus','b_pmdastus')
   CALL asfq007_filter_show('pmdadocno','b_pmdadocno')
   CALL asfq007_filter_show('pmdadocdt','b_pmdadocdt')
   CALL asfq007_filter_show('pmda002','b_pmda002')
   CALL asfq007_filter_show('pmda003','b_pmda003')
   CALL asfq007_filter_show('pmdbseq','b_pmdbseq')
   CALL asfq007_filter_show('pmdb002','b_pmdb002')
   CALL asfq007_filter_show('pmdb004','b_pmdb004')
   CALL asfq007_filter_show('pmdb005','b_pmdb005')
   CALL asfq007_filter_show('pmdb007','b_pmdb007')
   CALL asfq007_filter_show('pmdb006','b_pmdb006')
   CALL asfq007_filter_show('pmdb009','b_pmdb009')
   CALL asfq007_filter_show('pmdb008','b_pmdb008')
   CALL asfq007_filter_show('pmdb030','b_pmdb030')
   CALL asfq007_filter_show('pmdb049','b_pmdb049')
 
 
   CALL asfq007_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq007.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq007_filter_parser(ps_field)
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
 
{<section id="asfq007.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq007_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq007_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="asfq007.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION asfq007_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_asft301" 
         LET la_param.prog = "asft301" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[2] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[3] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[4] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[5] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[6] = g_sfaa10_d[l_ac].sfca001
         LET la_param.param[7] = g_sfaa10_d[l_ac].sfca001 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft301" 
         
         #end add-point 
  
      WHEN ps_field_name = "prog_asft335"
         LET la_param.prog = "asft335"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[2] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[3] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[4] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[5] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[6] = g_sfaa11_d[l_ac].sffbdocno
         LET la_param.param[7] = g_sfaa11_d[l_ac].sffbdocno
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft335"
         
         #end add-point
      WHEN ps_field_name = "prog_asft310"
         LET la_param.prog = "asft310"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[2] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[3] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[4] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[5] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[6] = g_sfaa8_d[l_ac].sfdcdocno
         LET la_param.param[7] = g_sfaa8_d[l_ac].sfdcdocno
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft310"
         
         #end add-point
      WHEN ps_field_name = "prog_asft340"
         LET la_param.prog = "asft340"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[2] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[3] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[4] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[5] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[6] = g_sfaa9_d[l_ac].sfecdocno
         LET la_param.param[7] = g_sfaa9_d[l_ac].sfecdocno
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft340"
         
         #end add-point
      WHEN ps_field_name = "prog_asft3011"
         LET la_param.prog = "asft301"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[2] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[3] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[4] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[5] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[6] = g_sfaa91_d[l_ac].sfcb001
         LET la_param.param[7] = g_sfaa91_d[l_ac].sfcb001
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft3011"
         
         #end add-point
      WHEN ps_field_name = "prog_apmt400"
         LET la_param.prog = "apmt400"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[2] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[3] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[4] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[5] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[6] = g_sfaa92_d[l_ac].pmdadocno
         LET la_param.param[7] = g_sfaa92_d[l_ac].pmdadocno
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_apmt400"
         
         #end add-point
      WHEN ps_field_name = "prog_apmt500"
         LET la_param.prog = "apmt500"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[2] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[3] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[4] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[5] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[6] = g_sfaa93_d[l_ac].l_pmdndocno
         LET la_param.param[7] = g_sfaa93_d[l_ac].l_pmdndocno
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_apmt500"
         
         #end add-point
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="asfq007.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq007_detail_action_trans()
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
 
{<section id="asfq007.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq007_detail_index_setting()
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
            IF g_sfaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_sfaa_d.getLength() AND g_sfaa_d.getLength() > 0
            LET g_detail_idx = g_sfaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_sfaa_d.getLength() THEN
               LET g_detail_idx = g_sfaa_d.getLength()
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
 
{<section id="asfq007.mask_functions" >}
 &include "erp/asf/asfq007_mask.4gl"
 
{</section>}
 
{<section id="asfq007.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建temp table 
# Memo...........:
# Usage..........: CALL asfq007_create_tmp()
# Date & Author..: 2014/12/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq007_create_tmp()
   DROP TABLE asfq007_tmp01;  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
   CREATE TEMP TABLE asfq007_tmp01(  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
      sel             VARCHAR(1),
      progress        VARCHAR(500),
      left_stus       VARCHAR(500),
      sfaadocno       VARCHAR(20),
      sfaadocdt       DATE,
      sfaa003         VARCHAR(1),
      sfaa010         VARCHAR(40),
      sfaa010_desc    VARCHAR(500),
      sfaa010_desc_1  VARCHAR(500),
      sfaa019         DATE,
      sfaa020         DATE,
      sfaa002         VARCHAR(20),
      sfaa002_desc    VARCHAR(500),
      sfaa068         VARCHAR(10),        #150907 Sarah add
      sfaa068_desc    VARCHAR(500),         #150907 Sarah add
      sfaa012         DECIMAL(20,6),
      sfaa049         DECIMAL(20,6),
      fullsets        DECIMAL(20,6),        #161226-00020#1 mod chr500 ->num20_6
      sfaa050         DECIMAL(20,6),
      sfaa051         DECIMAL(20,6),
      sfaa021         VARCHAR(20),
      sfaa025         VARCHAR(20),
      sfaa013         VARCHAR(10),
      sfaa046         DATE,
      sfaastus        VARCHAR(10),
      sfaa011         VARCHAR(30)

   ) 
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL asfq007_drop_tmp()
# Date & Author..: 2014/12/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq007_drop_tmp()
   DROP TABLE asfq007_tmp01;  #160727-00019#18  16/08/12  By 08734  临时表长度超过15码的减少到15码以下 asfq007_sfaa_tmp ——> asfq007_tmp01
END FUNCTION

 
{</section>}
 
